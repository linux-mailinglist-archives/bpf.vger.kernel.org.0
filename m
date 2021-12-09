Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6646E26A
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhLIG3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 01:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLIG3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 01:29:54 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40655C061746
        for <bpf@vger.kernel.org>; Wed,  8 Dec 2021 22:26:21 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j21so4396709ila.5
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 22:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NrqIN1jx34UdNGwq/wJVLA70QR+dpGBHuRaom8optxo=;
        b=SILqZBbTNaLNiF7askEJdaio326/lUpqlUvDYv0+CEc+K6kODL29a/JZfs8rZArSqB
         hn1JdXB0oFZOKl0GCouuOEyWLHx+OlhFo8AhqVDRkSZCvc5VXLKtpcUY+3hZvlBQZL6K
         8v51NPdcFHKw+bx+t37bYglB23Myk3mhHuJzxoB2lsVNUVDXYvoiY1tOSKLG0pSi6FMb
         MYvQ50wBER2j48XbWUwhNxGVZOAzi2Pky9JlXqH0sCRn9icQPGrAlSeGXXNM9t0oX9Jq
         fxqolj44v0Ru4Lb1GcKzrvzJD1RtsUpMuJzE93cnEsqXzUPcDRzniLwioh04vYeRKLtz
         L4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NrqIN1jx34UdNGwq/wJVLA70QR+dpGBHuRaom8optxo=;
        b=Prtha6rL0Z40ST5GG0wvvMRLVljTnWfRhe2gRAcQIIwzLIgubphZ4ljzMoDPU2NEvN
         XBZOOXuTSwORZ8N/2Zjro3MQYQS5cZ13AAZo5q1g+EEJI2RQHw8Hbt+2T9ovnzb6nKYP
         nYw5PWzR2X0lMrNKmcGF+g6l1RF49TXW2FpT1ozkW2KxGutmRxTCSM3eZT560nZcsUn4
         rtzCTAUheHRfWICCN4PFUT68kGtlWW+sXz92lKxVs8t3DgkRdvcAoUQpsQ0nCx+rPEMH
         GlS5sdPsaWI7ujRTQym5rLEeTadgGTXTrDLZa/022jUTZ/cBMtO5W43Wq3AriBG3aR06
         KI+Q==
X-Gm-Message-State: AOAM530fQxAa7zSUQVtg9sVbTBKIomGri2Pc4K+HPR4R0ywFhjlYQ7ri
        qn1L1ua/uuhX0ZbsUTcRKIg=
X-Google-Smtp-Source: ABdhPJyn19mPnsE+NyGAxR3lzoNDpae2lutgpfDO86fgRmMjOw1fHSJEuJLk3wJhidZ4r4IHhn89OA==
X-Received: by 2002:a05:6e02:b4a:: with SMTP id f10mr11141159ilu.281.1639031180456;
        Wed, 08 Dec 2021 22:26:20 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id x14sm3090128ilj.87.2021.12.08.22.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:26:20 -0800 (PST)
Date:   Wed, 08 Dec 2021 22:26:12 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <61b1a1844d712_ae146208b@john.notmuch>
In-Reply-To: <20211209004920.4085377-2-andrii@kernel.org>
References: <20211209004920.4085377-1-andrii@kernel.org>
 <20211209004920.4085377-2-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 01/12] libbpf: fix bpf_prog_load() log_buf
 logic for log_level 0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> To unify libbpf APIs behavior w.r.t. log_buf and log_level, fix
> bpf_prog_load() to follow the same logic as bpf_btf_load() and
> high-level bpf_object__load() API will follow in the subsequent patches:
>   - if log_level is 0 and non-NULL log_buf is provided by a user, attempt
>     load operation initially with no log_buf and log_level set;
>   - if successful, we are done, return new FD;
>   - on error, retry the load operation with log_level bumped to 1 and
>     log_buf set; this way verbose logging will be requested only when we
>     are sure that there is a failure, but will be fast in the
>     common/expected success case.
> 
> Of course, user can still specify log_level > 0 from the very beginning
> to force log collection.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> @@ -366,16 +368,17 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
>  			goto done;
>  	}
>  
> -	if (log_level || !log_buf)
> -		goto done;
> +	if (log_level == 0 && !log_buf) {
                              ^^^^^^^^

with non-Null log buf? Seems comment and above are out of sync?

Should it be, if (log_level == 0 && log_buf) { ... }

> +		/* log_level == 0 with non-NULL log_buf requires retrying on error
> +		 * with log_level == 1 and log_buf/log_buf_size set, to get details of
> +		 * failure
> +		 */
> +		attr.log_buf = ptr_to_u64(log_buf);
> +		attr.log_size = log_size;
> +		attr.log_level = 1;
>  
> -	/* Try again with log */
> -	log_buf[0] = 0;
> -	attr.log_buf = ptr_to_u64(log_buf);
> -	attr.log_size = log_size;
> -	attr.log_level = 1;
> -
> -	fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> +		fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> +	}
>  done:
>  	/* free() doesn't affect errno, so we don't need to restore it */
>  	free(finfo);
> -- 
> 2.30.2
> 


