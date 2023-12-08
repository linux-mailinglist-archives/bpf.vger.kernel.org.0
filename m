Return-Path: <bpf+bounces-17209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6780AB11
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A47B20B22
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7321A3B799;
	Fri,  8 Dec 2023 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxPnUljG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C59173B
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:46:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-333630e9e43so2380147f8f.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057602; x=1702662402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ1U+u5MsU+xBs/Q82IvJvfIhtv3q453JDYwSQm9w/0=;
        b=OxPnUljGVxaPa2evDeXzaLytIy2ytgusCnApD2PDfsrT4gxDzhS7hh2afSRkIzwu0G
         YNrHm53DLYdpYkPKqzkzM41K1jvCLICB/eb0kjnIv2Id+Qkx0h58zw7c+INsvm1vTVoP
         p3N/CR7ZtXpTJVKvdGKIR2XTRBAwfhMqkqQoJfJGvuRP4XToCDL0bYX7fyZN2jhNpWzH
         WpFFlVu3hcYq4qtOK11MZYgMumJJ5oHYHUH2nUPQfeHiK4xUSE66DU2SU9D8cZ0bA1H/
         V8GQRkldoIk7y1OmzLJ9H9Y5b3OXCTAwse5hY1TjAp4tGCmoU460/XINqtW8aNAsW540
         esUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057602; x=1702662402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ1U+u5MsU+xBs/Q82IvJvfIhtv3q453JDYwSQm9w/0=;
        b=wHOGSX1cAhRTddreRGCviXlsHo3YhKAQyup/VnSlYkts/UM3tyC0U5V/LQo767kb6F
         rGzaNq2t2UbAtN9Niti1HKRr+UmKo3w1S5A04NrqDrtG2riqet77nkwdgeP3IvdaSFTu
         TTc5fu8tscDt/rsTsKRtANrSej7bEvS1XNIgwqQHCxZKNjrThOKVy+mHyM3T3J0InDHQ
         1Ti7XNPYfNiPJgNREbXFAhH3n8qZOtg9Mm/+fVdeRntxhYDi3JW2Cz0gMTcUuKewMnsC
         Xb850d+PZonCMnZhxg3u5LIpXQ32wq1Ae9AoqD7lCOL0IXCiogBfS0XbV3273ac0CQ6t
         pNKQ==
X-Gm-Message-State: AOJu0YzI8h9piIWll74lGS72iEuTOS/AihxRCIvZMG5CmB6GFIPRgrjt
	PN9Gq/40IBSV7Ci2D3B8xk9jiTHa0LtEgZwZ+uU=
X-Google-Smtp-Source: AGHT+IHZEXhXJIO2Cm8vsNKdaX4U7DCBv1W9FoqQWQ7Oo9amz0XgGht1J5z6mONYopBTt3MTdiU7Bzc2qnYY500C02Y=
X-Received: by 2002:adf:e44c:0:b0:32d:bb4a:525c with SMTP id
 t12-20020adfe44c000000b0032dbb4a525cmr188563wrm.14.1702057601593; Fri, 08 Dec
 2023 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000531.19179-1-eddyz87@gmail.com> <012efc61-e067-4c21-8cab-47dec9bbaf0c@linux.dev>
 <0275c6985bcb299890da7ea7fb96642802cdcdbe.camel@gmail.com> <85a5312a-ba79-4e1d-b1be-434a7fe64cf0@linux.dev>
In-Reply-To: <85a5312a-ba79-4e1d-b1be-434a7fe64cf0@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 09:46:30 -0800
Message-ID: <CAADnVQK-RP-rOq2cGOSRt614td536Kp+9c=moNH_pen0EY2FUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi headers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:30=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/8/23 6:34 AM, Eduard Zingerman wrote:
> > On Thu, 2023-12-07 at 18:28 -0800, Yonghong Song wrote:
> > [...]
> >> All context types are defined in include/linux/bpf_types.h.
> >> The context type bpf_nf_ctx is missing.
> > convert_ctx_access() is not applied for bpf_nf_ctx. Searching through
> > kernel code shows that BPF programs access this structure directly
> > (net/netfilter/nf_bpf_link.c):
> >
> >      static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff=
 *skb,
> >                          const struct nf_hook_state *s)
> >      {
> >          const struct bpf_prog *prog =3D bpf_prog;
> >          struct bpf_nf_ctx ctx =3D {
> >              .state =3D s,
> >              .skb =3D skb,
> >          };
> >
> >          return bpf_prog_run(prog, &ctx);
> >      }
> >
> > I added __bpf_ctx only for types that are subject to convert_ctx_access=
()
> > transformation. On the other hand, applying it to each context type
> > should not hurt either. Which way would you prefer?
> >
> > [...]
> >
> >>> How to add the same definitions in vmlinux.h is an open question,
> >>> and most likely requires bpftool modification:
> >>> - Hard code generation of __bpf_ctx based on type names?
> >>> - Mark context types with some special
> >>>     __attribute__((btf_decl_tag("preserve_static_offset")))
> >>>     and convert it to __attribute__((preserve_static_offset))?
> >> The number of context types is limited, I would just go through
> >> the first approach with hard coding the list of ctx types and
> >> mark them with preserve_static_offset attribute in vmlinux.h.
> > Tbh, I'm with Alan here, generic approach seems a tad nicer.
> > Lets collect some more votes :)
>
> I just want to propose to have less work :-) since we are only dealing
> with a few structs in bpf domain. Note that eventually generated
> vmlinux.h will be the same whether we use 'hard code' approach or the
> decl_tag approach. The difference is just how to do it: - dwarf/btf with
> decl tag -> bpftool vmlinux.h gen, or - dwarf/btf without decl tag +
> hardcoded bpf ctx info -> bpftool vmlinux.h gen If we intends to cover
> all uapi data structures (to prevent unnecessary CORE relocation, esp.
> for troublesome bitfield operations), hardcoded approach won't work and
> we may have to go to decl tag approach.

+1 for simplicity of "hard code" approach.
We've stopped adding new uapi "mirror" structs like __sk_buff long ago.
The number of structs that need ctx rewrite will not increase.

