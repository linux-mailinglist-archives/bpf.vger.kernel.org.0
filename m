Return-Path: <bpf+bounces-30179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF58CB633
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293A8B21AEF
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6D149C66;
	Tue, 21 May 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9vz9M6V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2958AC1
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332194; cv=none; b=IzqbIinbkBKm2+eE5FOkS6cLpyBAjfYG503aJYt2Eh6IlQs1Ap68H6E1hLt+7T9BL52fy1w8J7XH+EB6U/2Bgo2pVrKA4VnFYTNgR1PGIyqtbAMkcHQY6c7FkWyr2dC1eMqCC4h/ZKBcjCl3r0CM3XLbVZkjVCHC3KlrDFaztEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332194; c=relaxed/simple;
	bh=YLVRVxdN3xvhbkJux88fX2fEuDQv8wCrS9B+X+f+ls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUOWwnAFZGfTkCh0+QXih7B9rg1ZQaXbEe33an2s9JgYUPORgTS2UC9H4/t6rT10EuOVDmi0BzcmwskSfpKFL0uBQrMdc+LeFuqbh/xsWQuLqY3pPW3rC8Kjgw61/cJVaxaB4c4f6gCpn12m7TFMkM7KzaBW+/do7AEiF1A33Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9vz9M6V; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b8ebc4eeso338399385a.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716332191; x=1716936991; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IejvPuE8dcb4brEgl4Jwi3ncpd2VAUU7ECP5XwpyxY8=;
        b=K9vz9M6VdpRIlDhigdzGYtzfGTwCYDtPSTzt5sDsYnnKdQLYLO1LiLCJG7ORj4BDRT
         +6CkMsquO6GLy14qZjbyzXJPtJgLVFkMcmNTYKhcfgrbt2huJ2BGftolNmvPiu6ZcFzR
         d0wJKIQ/43kcvHhl8tWw1PDkIRw29m2UBGWTrUQNUA4r8LBZWVfeUVmD7l+1/EpllO44
         GlK2/WYbJFJ0pmzZzwOu6ae43QFrT5HbnpNsKSxkQMEhQ2ewk4eu4V2HCk3cDGxXq6ZF
         +B3ArGBJddaL9cinBtl5Y4Bedv91sUXzCNvJ7CQeIFdmJYxq2K9H5FtNzMBJUSfTtzdN
         V+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716332191; x=1716936991;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IejvPuE8dcb4brEgl4Jwi3ncpd2VAUU7ECP5XwpyxY8=;
        b=YWj5Iv0iwgbkLsFeGBMLx4HoIYkITsIoXa5I2ixlf9DKJsEQTng0EUmnTzANyHPL+z
         Eoo137MffSlzoaCeEHJfmJkUZU8hgxiFmlQDEasNv7TehuAxKshjHUAHJd+VZbOf6eRu
         6ee/e3u3NhdpsxyWsXTJU/RhVLVsg3W9wYO4gEO+qLtrxz8DNBodpymitoH+Ke4YZALx
         8VLCHYKoux2gKhMO9QNWFTETVNvCCATnAcnny2cAArf1U/oK0YiRE0e5LYdvLfl2Hndj
         3SXkro/4WYVxTOl8ECdSdLc/FzpgYaQge2iZL7y4anskCcq8BpVpAqJYDBCV7+zsMD+8
         g70g==
X-Gm-Message-State: AOJu0YzdS5XO6Emu1yTBPI2XscxxNMj2oAQo1YwnVQ/Pv4qfKyYr4wQw
	wp9BKoplbfN3x1KbMraKs2Tx2Bm0lJtIrX4rGMqQchUP0JV5Xow1
X-Google-Smtp-Source: AGHT+IE+8PwZTmeq/y1Ja0uKG0R1+U9zjPi1Rjk4Xwoqwnxi4gX6oLz4pqFz7KWq3f83blTEBXuJzA==
X-Received: by 2002:a05:6214:2b87:b0:6a9:30b8:4558 with SMTP id 6a1803df08f44-6ab7f35f02emr2662826d6.30.1716332191439;
        Tue, 21 May 2024 15:56:31 -0700 (PDT)
Received: from bytedance ([130.44.212.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d6f30sm127331476d6.110.2024.05.21.15.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:56:31 -0700 (PDT)
Date: Tue, 21 May 2024 22:56:26 +0000
From: Amery Hung <ameryhung@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
Message-ID: <20240521225252.GA3845630@bytedance>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-7-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510002942.1253354-7-thinker.li@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 09, 2024 at 05:29:41PM -0700, Kui-Feng Lee wrote:
> Not only a user space program can detach a struct_ops link, the subsystem
> managing a link can also detach the link. This patch adds a kfunc to
> simulate detaching a link by the subsystem managing it and makes sure user
> space programs get notified through epoll.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
>  .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++++
>  .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
>  4 files changed, 117 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 1150e758e630..1f347eed6c18 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -741,6 +741,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
>  	return err;
>  }
>  
> +static DEFINE_SPINLOCK(detach_lock);
> +static struct bpf_link *link_to_detach;
> +
> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
> +{
> +	struct bpf_link *link;
> +	int ret = -ENOENT;
> +
> +	/* A subsystem must ensure that a link is valid when detaching the
> +	 * link. In order to achieve that, the subsystem may need to obtain
> +	 * a lock to safeguard a table that holds the pointer to the link
> +	 * being detached. However, the subsystem cannot invoke
> +	 * link->ops->detach() while holding the lock because other tasks
> +	 * may be in the process of unregistering, which could lead to
> +	 * acquiring the same lock and causing a deadlock. This is why
> +	 * bpf_link_inc_not_zero() is used to maintain the link's validity.
> +	 */
> +	spin_lock(&detach_lock);
> +	link = link_to_detach;
> +	/* Make sure the link is still valid by increasing its refcnt */
> +	if (link && IS_ERR(bpf_link_inc_not_zero(link)))
> +		link = NULL;
> +	spin_unlock(&detach_lock);
> +

I know it probably doesn't matter in this example, but where would you set
link_to_detach to NULL if reg and unreg can be called multiple times?

> +	if (link) {
> +		ret = link->ops->detach(link);
> +		bpf_link_put(link);
> +	}
> +
> +	return ret;
> +}

[...]

