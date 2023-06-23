Return-Path: <bpf+bounces-3258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C173B76A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9971C21280
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CB230F6;
	Fri, 23 Jun 2023 12:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733B191
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 12:34:43 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E182733
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 05:34:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so7379325e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687523669; x=1690115669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlOpW2YIof75AViP3GM7RTU59L/jcXB6fwm/RJaGd9k=;
        b=B28JjowvgFAiFOe1J9fTBSpRQJ1zRMc2H8Izsnpo7SMaddh1UVnPNMtBYCDacc6fDZ
         OpvzGLHnwjTvjn44ha/oYV/pLHbyRuVwsWTiYYOxq6RI56jIVJatIEeXFQnRIpxERj8m
         Ao17vQHvrKxUbv4mOCbAgbMQztMfEy5g/Vjwam9/gAR/XDSesXSd4VJkeT6iGgztCfTR
         Ix67wW2DvDR6j2QlpM5tB5vULoL/L1IOBUQAjxqVEnpYMHjbM3lykA+E3JSyxsFeChMU
         k0AuqYAHKWwRjrgEomzbAquJMaJhKH9CUEx2jQL/uCNOveiMDvWPNyA/hjIVCecMv8Ow
         kPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523669; x=1690115669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlOpW2YIof75AViP3GM7RTU59L/jcXB6fwm/RJaGd9k=;
        b=YCPrk4oDCfr0UAlgQAj1ai59epVExMz2TMVCp1Qo0ZWOY6zm3jt2Qcc3Dh7qqNM1Dh
         sVlE0FPpa4GdAPL3KUqv5ioOwgPxlC2P5okgsfccXXFTv9byO8SmpBpp/4CxFUEh0G4J
         cw7s2/6EtPf7UQjKyjn0aMpMmKKSP9uDWqxSnDp+ldnyjEM4ca4E3Bx3lD0WIVutc0gF
         NvmCgp8k+A3IXdg8QSM402/Tu5hp1gaWZEakSIpn1zzLx6OajzI/9FimupRXT1vVOHvc
         T2iS5t/lqgF39sOvBWKCwEJ7oIt9UHrSvxrwbRkDF9yi5ean51m0PSlngd4MwuiZ1hr0
         xQyQ==
X-Gm-Message-State: AC+VfDwOqus1AH4WFGpfuCFQoKSEkQDKskIIbLiwCVszLFDH5OfvD/1J
	64oBKCaAGKfvh3+6Rxy0AIubsA==
X-Google-Smtp-Source: ACHHUZ7AMlb/DZ0HafhquZpgxoeP6w6iD0M9LzvA9Wladd3KXmRdqnp3CLRnsmfeWYkNkH2ELOVrSA==
X-Received: by 2002:a05:600c:2942:b0:3f9:b8b8:20e4 with SMTP id n2-20020a05600c294200b003f9b8b820e4mr7966628wmd.31.1687523669232;
        Fri, 23 Jun 2023 05:34:29 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n10-20020a7bc5ca000000b003f42314832fsm2263257wmk.18.2023.06.23.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:34:28 -0700 (PDT)
Date: Fri, 23 Jun 2023 12:35:31 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC v2 PATCH bpf-next 1/4] bpf: add percpu stats for bpf_map
 elements insertions/deletions
Message-ID: <ZJWRk/FC9t6eyDbT@zh-lab-node-5>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095330.1023453-2-aspsk@isovalent.com>
 <8e18e99d-afca-8afd-6777-c9d0b728baf5@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e18e99d-afca-8afd-6777-c9d0b728baf5@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:51:21PM +0200, Daniel Borkmann wrote:
> On 6/22/23 11:53 AM, Anton Protopopov wrote:
> > Add a generic percpu stats for bpf_map elements insertions/deletions in order
> > to keep track of both, the current (approximate) number of elements in a map
> > and per-cpu statistics on update/delete operations.
> > 
> > To expose these stats a particular map implementation should initialize the
> > counter and adjust it as needed using the 'bpf_map_*_elements_counter' helpers
> > provided by this commit. The counter can be read by an iterator program.
> > 
> > A bpf_map_sum_elements_counter kfunc was added to simplify getting the sum of
> > the per-cpu values. If a map doesn't implement the counter, then it will always
> > return 0.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >   include/linux/bpf.h   | 30 +++++++++++++++++++++++++++
> >   kernel/bpf/map_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 77 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f58895830ada..20292a096188 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -275,6 +275,7 @@ struct bpf_map {
> >   	} owner;
> >   	bool bypass_spec_v1;
> >   	bool frozen; /* write-once; write-protected by freeze_mutex */
> > +	s64 __percpu *elements_count;
> 
> To avoid corruption on 32 bit archs, should we convert this into local64_t here?

Looks like using this_cpu_inc we can do it lockless on archs which support it
(AFAICS this is x86_64, arm64, s390, and loongarch). Otherwise we can use
atomic64_t (local64_t will switch to atomic64_t in any case for such systems).

