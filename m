Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957C2435119
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTRV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJTRVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:21:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9AC061753
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:19:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i5so10383162pla.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=runRMUbYuIEo+wRieTz5hZS3ahaqIjDgmEjxbql3ZJQ=;
        b=O6aGHkat779xaaQF9BlG/oOdJrP5jWVHIorF+7an3DaGJzNN1MV3X4+sWp+XUcnjk1
         tR6gO8tP2EKJsTbB/GdSzzwXgSN5c+RR9CIrjLTJ4U8pNG3V859xKAOokmLsgTBWPYfc
         BY3rcMXe94sqWTDhgHrrxPFxJtH1kZjGkktqP48tMmgcu+WdbWL/IuL3upeO6X8nMJZC
         ORvPD7c2SqTf/+nXkwcFe14GKborfNKSp0WtHCcdag1tDkereJivmbYkNWcJpaeIS1eY
         +AO6m81s7ZMMHQ8LxKeGpx7+9eUPIEynBW/cCf1CpqYZ/mwuWIGkaUobJ6a9+L3MiQrF
         fHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=runRMUbYuIEo+wRieTz5hZS3ahaqIjDgmEjxbql3ZJQ=;
        b=Ll609m615TbUtl5zuImaaBEwWoKUsGsXg8QEDdLqyiSBp1nigY1pvH0EyC3gJUz3yo
         DGDoekwxvtNDOW1xBetpF56iXXDnAOY2/Ezz8KDyd65F8Eyz25iQ8Y4dKwSQkPUF3uJT
         AnpuQGT2/lB+iGys+RYl8/Q1cVY99NrogB2Bbe8z40eTdtfIb8kLWoEpzw6+VvPtksBg
         HfIExbCJDXF5nVonbT6mYxri0xdS88cIrCxVcrr2VsKirt05VhBDjueAhQAIcqm6VO9P
         kKtddSIfpCu+Oq1BBbeajSpYEdwCurt5ojB1SXNDoF8wiMWJJhKlNtAjY741KAfYDxy1
         qUIg==
X-Gm-Message-State: AOAM532QFPRnRN6X8ezPFc+v5Bvzv+QPJAUTRXZfWzHn0NT7nenb6DZa
        jwLs1rp0pt5ibqYYPWSSKO0=
X-Google-Smtp-Source: ABdhPJz7g2zQCyr4wmCqB4uKsdns6NSqGdL31IynanX64B7uFPOVwm+be0mMqgi0HkibZ3abNHN22A==
X-Received: by 2002:a17:902:64d6:b0:13e:a5a9:c6d6 with SMTP id y22-20020a17090264d600b0013ea5a9c6d6mr403677pli.52.1634750377535;
        Wed, 20 Oct 2021 10:19:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b634])
        by smtp.gmail.com with ESMTPSA id j6sm2808178pgf.60.2021.10.20.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:19:37 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:19:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC 9/9] libbpf: use new-style syscall args
Message-ID: <20211020171935.qsxfrhv2i5n3hkc7@ast-mbp.dhcp.thefacebook.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
 <20211014143436.54470-13-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014143436.54470-13-lmb@cloudflare.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 14, 2021 at 03:34:36PM +0100, Lorenz Bauer wrote:
> ---
>  tools/lib/bpf/bpf.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 7d1741ceaa32..79a9bfe214b0 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -506,15 +506,14 @@ int bpf_map_delete_elem(int fd, const void *key)
>  
>  int bpf_map_get_next_key(int fd, const void *key, void *next_key)
>  {
> -	union bpf_attr attr;
> -	int ret;
> +	struct bpf_map_get_next_key_attr attr = {
> +		.map_fd		= fd,
> +		.key		= key,
> +		.next_key	= next_key,
> +	};

I see this change as the main advantage of additional uapi structs.
Note, though, that such stack savings don't strictly need uapi extensions.
Light skeleton already doing that.
Every command is using exactly the right amount of stack/bytes.
The full 'union bpf_attr' is never allocated.
Take a look at bpf_gen__map_freeze() in libbpf gen_loader.c.
In case of light skeleton it's not only the stack. Saving space
in loader's map was important.
