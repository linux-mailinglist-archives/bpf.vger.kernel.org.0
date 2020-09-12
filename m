Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4F267A1A
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgILLrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Sep 2020 07:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgILLrT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Sep 2020 07:47:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027F7214D8;
        Sat, 12 Sep 2020 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599911223;
        bh=tcy2pv8jwy7gfP4u9YzIxvq8wYbaPrazMLwunNOxOtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ir6W8kWKHKmWml+SmsxBudZOi7onIp501EbyEtnnXDc54J75qcJaKzYZsHfimml2k
         CB7SRGWB7Jdj4ocEg12OCYfbFAugkcOvOh9BBD/126Zu5Xgd+Lzbnj4zgqj/QSPpAx
         uBGo7/iOuzOLu72E9Jv3ye3bfdLHmzoa9P8dZPKk=
Date:   Sat, 12 Sep 2020 13:47:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Using a pointer and kzalloc in place of a struct directly
Message-ID: <20200912114706.GA171774@kroah.com>
References: <000000000000c82fe505aef233c6@google.com>
 <20200912113804.6465-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912113804.6465-1-anant.thazhemadam@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 12, 2020 at 05:08:04PM +0530, Anant Thazhemadam wrote:
> Updated the usage of a struct variable directly, in bpf_link_get_info_by_fd
> to using a pointer of the same type instead, which points to a memory 
> location allocated using kzalloc.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

Note, your "To:" line seemed corrupted, and why not cc: the bpf mailing
list as well?

Anyway, comment on your patch below:

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4108ef3b828b..01b9c203ef65 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3605,30 +3605,31 @@ static int bpf_link_get_info_by_fd(struct file *file,
>  				  union bpf_attr __user *uattr)
>  {
>  	struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
> -	struct bpf_link_info info;
> +	struct bpf_link_info *info = NULL;
>  	u32 info_len = attr->info.info_len;
>  	int err;
>  
> -	err = bpf_check_uarg_tail_zero(uinfo, sizeof(info), info_len);
> +	err = bpf_check_uarg_tail_zero(uinfo, sizeof(struct bpf_link_info), info_len);
> +
>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);
>  
> -	memset(&info, 0, sizeof(info));
> -	if (copy_from_user(&info, uinfo, info_len))
> +	info = kzalloc(sizeof(struct bpf_link_info), GFP_KERNEL);
> +	if (copy_from_user(info, uinfo, info_len))
>  		return -EFAULT;

You leaked memory :(

Did you test this patch?  Where do you free this memory, I don't see
that happening anywhere in this patch, did I miss it?

And odds are this change will slow things down, right?  Why make this
change, what's wrong with the structure being on the stack?

thanks,

greg k-h
