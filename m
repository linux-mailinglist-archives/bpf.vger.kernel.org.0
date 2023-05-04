Return-Path: <bpf+bounces-42-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C86F78F2
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CC280F3E
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C130C158;
	Thu,  4 May 2023 22:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A987C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:20:37 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9355711B55
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:20:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a516fb6523so9606485ad.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683238836; x=1685830836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klxSZvvgoSkAKRZzVBBWqPhJyd1EjjRCRQpANOtcZp0=;
        b=Y+f+x7MMn81dFQFT/Lt2rIP5i7vuh2tVgwNFkeyPNBLTIYDr6N2H4pyB8AXEcJ4Tp2
         jGGpZteyGIfX5wrJkwr3cLxIdJG2WGsg9J7IHWTfoTsVNBVn8iYAHjJB0TJ6vrxxLSJe
         dmDPIys9zOM4RmR3+ouOhAt3pVW1Dvv2hSrjYrBKCgVI6OC7vWPcGERiELWOY+KmtoLT
         0/TmXZUd1BmuEujKVHzvfh7gA/kQOQTPA2lltvowjJ97RFSnZ77PXTZOBrclFOUHTnG6
         RtCpHneLE2RjiEHuYhCFDLmpEoDsiotQs+fyhwBu5XEow0CuKPnouioh0fb5wsXt5EkW
         ac3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238836; x=1685830836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klxSZvvgoSkAKRZzVBBWqPhJyd1EjjRCRQpANOtcZp0=;
        b=B+CXXUugthWStwPTxSHtiKDGa02T7YiUuRD1OJrH+GcOVg+MeK7wH+Ot4Rh8WT7jiY
         wTm6/MClbta8Tzna/jo9hbhLnNgQcD4Z0jYpMD2pSri8ORaL/sHt7M1jcxjGpbJM/OVH
         2/st19CnvLI+gkNKcCRpmR09uW+cYeOUCHlBs73NYEHeFnTCW1uKoGoLJQp0aYKYBOGw
         y8gmWx2IGe0MPpN92+io5KaQA3KQwS0AYrYdsEc7JuTWrvo5CyY4YQTCEyS0C8+ddqVa
         cnwWE3NXbY6AQvesYCwduCYZUYm7j7Bi7cvr5xWyYdGyyiMHOzzdzZWWOriCsmiHGtrh
         tp9Q==
X-Gm-Message-State: AC+VfDwN2JM+v7LFwXBg/SXHAmTs4eXatF97PAhlh+kgjvPfvj6MF4kN
	9E43J2YbjQ7+ZAczt0DXk/Q=
X-Google-Smtp-Source: ACHHUZ5Q46L/7RxQSMwmnYcGF/p7GQeLD9hCF9UZb3xwMoLpzva1EN3CR+gnY2t3W8qU997t//H5Kw==
X-Received: by 2002:a17:902:9008:b0:1a9:90bc:c3c5 with SMTP id a8-20020a170902900800b001a990bcc3c5mr4681428plp.62.1683238835908;
        Thu, 04 May 2023 15:20:35 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id v13-20020a170903238d00b001a076025715sm31116plh.117.2023.05.04.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:20:35 -0700 (PDT)
Date: Thu, 4 May 2023 15:20:33 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
Message-ID: <20230504222033.gw64tn73fverqccf@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-11-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502230619.2592406-11-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 04:06:19PM -0700, Andrii Nakryiko wrote:
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 4d057d39c286..c0d60da7e0e0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -661,7 +661,7 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
>  void bpf_prog_kallsyms_add(struct bpf_prog *fp)
>  {
>  	if (!bpf_prog_kallsyms_candidate(fp) ||
> -	    !bpf_capable())
> +	    !fp->aux->bpf_capable)
>  		return;

Looking at this bit made me worry about classic bpf.
bpf_prog_alloc_no_stats() zeros all fields include aux->bpf_capable.
And loading of classic progs doesn't go through bpf_check().
So fp->aux->bpf_capable will stay 'false' even when root loads cBPF.
It doesn't matter here, since bpf_prog_kallsyms_candidate() will return false
for cBPF.

Maybe we should init aux->bpf_capable in bpf_prog_alloc_no_stats()
to stay consistent between cBPF and eBPF ?
It probably has no effect, but anyone looking at crash dumps with drgn
will have a consistent view of aux->bpf_capable field.

