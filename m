Return-Path: <bpf+bounces-17550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC280F1A8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5081F216C1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9576DDF;
	Tue, 12 Dec 2023 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT0y12kr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0AAC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 07:58:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so29834255e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702396709; x=1703001509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7EshB7IP+RFH6uWUoXyIGzbgqwaczaR0ZNZ03inq+I=;
        b=aT0y12krLdP6HL1hqoLiOz+fnGB2JmWKvW7Legtlj46r59+5F3t3YE6OYDiuzt+JpH
         jNKbnQfkZB7LZFvTLlclFQFTLaJb1ABSdMedW/Orwz+jgDiR8Fj9UZO1r0NUjbQF85T5
         JNNdP/GniHRi2rQ8sCB0D+Bf7w7Shu7qCMBoch3V61Zxb/prdcWm231uMfO578NWn6Jh
         8U9QCPasRCIJaTaMtCyh+vx39PzSB2sG/6Cihz1+wsdMki6R1+AElBta+QCcygKc15sJ
         rT+DODQ+3BW2KYRXjqvfD6rZbMOi+nevRSkK5bLaDPj6jeqc8UVTO+ZirBH7mc0zqIwV
         A8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396709; x=1703001509;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7EshB7IP+RFH6uWUoXyIGzbgqwaczaR0ZNZ03inq+I=;
        b=hAQSQWBiO3Ny+ZemppwHhuEAlRcSWFCwGmhvhQ4Mk/X1rWMqzqjpoUt1S9ijUrreKt
         f9GUlEhGM6IIBf48m+/onH4gxz0rhD7H5umw1nIoSdqpdnUTl9NfS1a30zs1v/G2lZuQ
         lt9bX/WcBmriPXLfkhYMVzhFVhO9JnFlyEvDBhEBg+VZ+1MgCf9BKxjskJJqdv8E7aF3
         L354HAD5WBWGCeQfHU8JLvCpTGxTRtxvN0RBVWI4L5R9YYyY8i1goMVHInjHEVaRsDCY
         bseJvbhzyoNGFXKTUUTd4D3V0hwqvOpoN1bhqzJm8wy0I5FWIhen3BkJvzbyHlnpICB0
         qA0A==
X-Gm-Message-State: AOJu0Yy/VqO/N8fGwpJiQMcS7zvKHpSvWB+P1UgLo9pGkUb/4Kdcv4yH
	n6+EAHUvnVYOnIBgjGm7iIc=
X-Google-Smtp-Source: AGHT+IHLA29Qef35bzg39bpQq3E2rHRAna1J8YmBU+yPdpcK7QUXFPumca0dinD/0N7jF8evSGNkEg==
X-Received: by 2002:a05:600c:3187:b0:40c:2b01:e09e with SMTP id s7-20020a05600c318700b0040c2b01e09emr3218751wmp.47.1702396708584;
        Tue, 12 Dec 2023 07:58:28 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0040c4be1af17sm5522002wmg.21.2023.12.12.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:58:28 -0800 (PST)
Message-ID: <90dd9462984be5cfce9db23eda53df44f39a8687.camel@gmail.com>
Subject: Re: [RFC v2 2/3] bpftool: add attribute preserve_static_offset for
 context types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, alan.maguire@oracle.com
Date: Tue, 12 Dec 2023 17:58:21 +0200
In-Reply-To: <baee9fb4-7559-4ba2-a254-7388bb6caa63@isovalent.com>
References: <20231212023136.7021-1-eddyz87@gmail.com>
	 <20231212023136.7021-3-eddyz87@gmail.com>
	 <baee9fb4-7559-4ba2-a254-7388bb6caa63@isovalent.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 11:39 +0000, Quentin Monnet wrote:
[...]
> Hi, and thanks for this!
>=20
> Apologies for missing the discussion on v1. Reading through the previous
> thread I see that they were votes in favour of the hard-coded approach,
> but I would ask folks to please reconsider.
>=20
> I'm not keen on taking this list in bpftool, it doesn't seem to be the
> right place for that. I understand there's no plan to add new mirror
> context structs, but if we change policy for whatever reason, we're sure
> to miss the update in this list and that's a bug in bpftool. If bpftool
> ever gets ported to Windows and Windows needs support for new structs,
> that's more juggling to do to support multiple platforms. And if any
> tool other than bpftool needs to generate vmlinux.h headers in the
> future, it's back to square one - although by then there might be extra
> pushback for changing the BTF, if bpftool already does the work.
>=20
> Like Alan, I rather share your own inclination towards the more generic
> declaration tags approach, if you don't mind the additional work.

Understood, thank you for feedback.
The second option is to:

1. Define __bpf_ctx macro in linux headers as follows:

    #if __has_attribute(preserve_static_offset) && defined(__bpf__)
    #define __bpf_ctx __attribute__((preserve_static_offset)) \
                      __attribute__((btf_decl_tag(preserve_static_offset)))
    #else
    #define __bpf_ctx
    #endif

2a. Update libbpf to emit __attribute__((preserve_static_offset)) when
    corresponding decl tag is present in the BTF.

2b. Update bpftool to emit __attribute__((preserve_static_offset)) for
    types with corresponding decl tag. (Like in this patch but check
    for decl tag instead of name).

I think that 2b is better, because emitting
BPF_NO_PRESERVE_STATIC_OFFSET from the same place where
BPF_NO_PRESERVE_ACCESS_INDEX makes more sense,
libbpf does not emit any macro definitions at the moment.

wdyt?



