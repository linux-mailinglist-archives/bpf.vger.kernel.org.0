Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436603B2B46
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFXJYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 05:24:01 -0400
Received: from gofer.mess.org ([88.97.38.141]:52939 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhFXJYB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 05:24:01 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id DF5E6C63B7; Thu, 24 Jun 2021 10:21:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1624526500; bh=KCjBW8cr9npc8C+5qWS7S+F3vdfvrc8twP/JSy5H3os=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kZZmCFe5jMb0QWaQU5MFjPU6DIC6Fj2hnyyVUeFZDC4ZvWDhJr+MAalJvqgjPTIDl
         yR7YqQV7ARzuP7eCN6bnpNJfFWxUMVRH+Zw6x9vQm/DZ1meY1d99Qf+AsK+qHwAgRX
         T69UHh0+/vYwqGoR8Nvss3l6uCjqaTQsFJkKEsXGT1zQxO9Sp0BbWJduc5VfIZczNa
         89sQdnH9XgqjE5K4Jf4Afcckr9HBhXQexLanXYC+69DeIk2AFBHUrqnDLp0QaEDCTp
         FtApEV6kiitgUkjFB7VdeSJydMHk04RaYPbDSM6RYNFOu+Z81Ip+urcOh4sbIIco53
         JeLXN6NNXGRIQ==
Date:   Thu, 24 Jun 2021 10:21:40 +0100
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] media: bpf: do not copy more entries than user space
 requested
Message-ID: <20210624092140.GA8011@gofer.mess.org>
References: <20210623213754.632-1-sean@mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623213754.632-1-sean@mess.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 23, 2021 at 10:37:54PM +0100, Sean Young wrote:
> The syscall bpf(BPF_PROG_QUERY, &attr) should the prog_cnt field to see

s/should the/should use the/

> how many entries user space provided and return ENOSPC if there are
> more programs than that. Before this patch, this is not checked and
> ENOSPC is never returned.
> 
> Note that one lirc device is limited to 64 bpf programs, and user space
> I'm aware of -- ir-keytable -- always gives enough space for 64 entries
> already. However, we should not copy program ids than are requested.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/media/rc/bpf-lirc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index 3fe3edd80876..afae0afe3f81 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -326,7 +326,8 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
>  	}
>  
>  	if (attr->query.prog_cnt != 0 && prog_ids && cnt)
> -		ret = bpf_prog_array_copy_to_user(progs, prog_ids, cnt);
> +		ret = bpf_prog_array_copy_to_user(progs, prog_ids,
> +						  attr->query.prog_cnt);
>  
>  unlock:
>  	mutex_unlock(&ir_raw_handler_lock);
> -- 
> 2.31.1
