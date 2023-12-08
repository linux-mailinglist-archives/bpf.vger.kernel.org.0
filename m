Return-Path: <bpf+bounces-17189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC880A592
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FFFB20C35
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372BB1DFE0;
	Fri,  8 Dec 2023 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWqBJtsx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A0173B
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 06:34:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so23153085e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702046054; x=1702650854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=he5eB9dkMa1Q2+jJlDztajJ1c2IY4kYF9fPdWV3+k0E=;
        b=NWqBJtsxdoRO91O8Hk6lXGuJP68S1uEShkL9JkwUoc0fDRjA9ATPHvVD6Xj5iw22O3
         4mXQbOzXENcNkySgKE+giugnOZyFFoLyp7iacbfGUgn9+0aYnKH5yoeHQe7vgm614c2M
         lczKHIrRzJKXPHCgQGPymcn5O8gIa4Wu3p1bFpkqjuVQCIygietj33oh/naxWneCuGJy
         VvR9k6rwEglU9scz94JiseJKyFe8kSHGdkTNelOWuMvqx2og4yu/jL1bAz1PBTogdodb
         n3Nj7n+OnxkYwkxiBaFwwSKhB8PLKUrVlw25A8qdNi6AGZ4D94vm15Re+nogOHh9zstn
         lQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046054; x=1702650854;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he5eB9dkMa1Q2+jJlDztajJ1c2IY4kYF9fPdWV3+k0E=;
        b=vvTaazppHanpIzi0gpSiYrDhOjmRPjXufvDOLSJW3dt09Kfd8FVAsQct0PmltCcKWv
         EtnYq0WlZr2vloDvhd+S8AGq3ME56kTcGMtZ/F63vbuV7+XfT976xegsObs7nJVwq8bJ
         gyQw/mTy7Pd4rYYjDWKr3BYMBfECMJWt4hN24+BuHmjL+GBcQgBtac6A0gJUJPkz1ZMO
         JeD9xfRXPS3K0G76Orad11j0g2FWIXx5NaVt8Wwe4HAPaA3q7Eoat49VC3cWLqfH+9rK
         J3SP5XTSGhGsHSosDeFZvOAyXkXhNjymGuTzT1gKRX/vCdz/x+m4sJ5CohY/ktnxZLop
         zdsA==
X-Gm-Message-State: AOJu0Yzsm4xs0X682vy7leQS9OFqIQ5cCectxX+8CRkHBhkmZ/Vwl4wC
	LKFFL/dl6IVRg/cnTlX5Ws4z3L44CtAd0w==
X-Google-Smtp-Source: AGHT+IE+mTDka696tB6L4moD4vpkpIL6Hcozq38q4cJSYd77sTazznekZj60PB0Rp55QjjX7cAh/WQ==
X-Received: by 2002:a05:600c:458d:b0:40b:5e1c:af2a with SMTP id r13-20020a05600c458d00b0040b5e1caf2amr42772wmo.48.1702046054109;
        Fri, 08 Dec 2023 06:34:14 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b0040b4562ee20sm2082941wme.0.2023.12.08.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:34:13 -0800 (PST)
Message-ID: <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, jose.marchesi@oracle.com
Date: Fri, 08 Dec 2023 16:34:12 +0200
In-Reply-To: <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
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

On Thu, 2023-12-07 at 18:28 -0800, Yonghong Song wrote:
[...]
> All context types are defined in include/linux/bpf_types.h.
> The context type bpf_nf_ctx is missing.

convert_ctx_access() is not applied for bpf_nf_ctx. Searching through
kernel code shows that BPF programs access this structure directly
(net/netfilter/nf_bpf_link.c):

    static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb=
,
                        const struct nf_hook_state *s)
    {
        const struct bpf_prog *prog =3D bpf_prog;
        struct bpf_nf_ctx ctx =3D {
            .state =3D s,
            .skb =3D skb,
        };

        return bpf_prog_run(prog, &ctx);
    }

I added __bpf_ctx only for types that are subject to convert_ctx_access()
transformation. On the other hand, applying it to each context type
should not hurt either. Which way would you prefer?

[...]

> > How to add the same definitions in vmlinux.h is an open question,
> > and most likely requires bpftool modification:
> > - Hard code generation of __bpf_ctx based on type names?
> > - Mark context types with some special
> >    __attribute__((btf_decl_tag("preserve_static_offset")))
> >    and convert it to __attribute__((preserve_static_offset))?
>=20
> The number of context types is limited, I would just go through
> the first approach with hard coding the list of ctx types and
> mark them with preserve_static_offset attribute in vmlinux.h.

Tbh, I'm with Alan here, generic approach seems a tad nicer.
Lets collect some more votes :)

