Return-Path: <bpf+bounces-9847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30179DCF9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 02:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FA328131C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489D37E;
	Wed, 13 Sep 2023 00:09:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641547F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 00:09:58 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB710F2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:09:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so10206419e87.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694563795; x=1695168595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/FTY0OvuCwhtUtpXj6zoD09HdvLc/FeIF8ehvLhyUM=;
        b=ZOKLns5qPcz9Hj1FKH/qxqeMeRfah1/ikHacPKcoUbrppVyVOxZ74xbMJBzzdH5HWY
         NpeZienJZv4drLMtjN/w15lHEULjamwY23qXCzbopJ3BZdI3Wk3OZ2HPWa3rPrQgQR+W
         NJTExP4VuCebeq+FdHek4Nw2ZyaAfLtzLmtht+M+FGnakSJ8d6/xbP8Bsc1ur4ISPv6i
         NNk+V8YEIpvnVI2scQZhGpY5sHEgUWKjkS07I73NzUoBzyGRB+hsc31Vk4zbV5Sm9d1B
         m2fRhSDm3A2OtKeS9Dk9fLxdAcmC/7si/CyCPeGnMLUFOI/zD4g5ZJ/kl6pUohvsUrjS
         PrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563795; x=1695168595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/FTY0OvuCwhtUtpXj6zoD09HdvLc/FeIF8ehvLhyUM=;
        b=rDGYz+J4x6Xt+kuKDNdRTxgAIIXJqU2bgFig5FhWA+bO9rxF1C/Ks3CglUIIYKz55M
         ZCckSYfkIlN5sGC5bWBk0b2ukS1TRC53my9UjWJat7rQtS3BlkwrsW71wiBpqkM0zgms
         FokARHOmYHyocl8PfWjvFtqsORiaijojg+YJxoUBbDJjHg+vMkrxfzDJlRrpANME8sVa
         OxKpl8uetYeTumLsVuS5g8QAuHvPGPhUSj9MAhw5KZqiVstP2QqmEKAJhV485fW9ejEW
         NDAGJPOBboLWdIifzlxqtU44riFGKpdSPt324s01TLgujsNhGRw+y5LGfvrur3vW0GkL
         nW3g==
X-Gm-Message-State: AOJu0YzRD2C+cZ1cdW+3EgWMz2iQHehzSs/rTlGEtsoo6W1+2Yx4ZIdy
	AWa9WtAcGWRK2hbBKYCUdZYFk5A0YIdpcl59KD4=
X-Google-Smtp-Source: AGHT+IHkWAGu2TNmW3knDge4tkaAINOj0jGtbRTHcmjHN2PCKWEuzK+P2ZWwX0FCvDUEOGSmlXbL0S/jjFEEQ0mi2A0=
X-Received: by 2002:a05:6512:3994:b0:4f8:7513:8cac with SMTP id
 j20-20020a056512399400b004f875138cacmr1014517lfu.48.1694563795354; Tue, 12
 Sep 2023 17:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com> <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com> <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
 <mb61pv8cm0wf9.fsf@amazon.com> <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
 <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com>
In-Reply-To: <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 17:09:44 -0700
Message-ID: <CAADnVQ+EpYBTGMJ0MBdK8=qKrYseicxpA1AE+BmHu1CFoOPUvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 3:49=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi Alexei,
>
> [...]
>
> > I guess we never clearly defined what 'needs_zext' is supposed to be,
> > so it wouldn't be fair to call 32-bit JITs buggy.
> > But we better address this issue now.
> > This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
> > I believe all 4 JITs emit proper zero extension into 64-bit register
> > by using single cpu instruction,
> > but they also define bpf_jit_needs_zext() as true,
> > so extra BPF_ZEXT_REG() is added by the verifier
> > and it is a pure run-time overhead.
>
> I just realised that these zext instructions will not be a runtime
> overhead because the JITs ignore them.
> Like
> s390 does:
> case BPF_LDX | BPF_MEM | BPF_B: /* dst =3D *(u8 *)(ul) (src + off) */
> case BPF_LDX | BPF_PROBE_MEM | BPF_B:
>         /* llgc %dst,0(off,%src) */
>         EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
>         jit->seen |=3D SEEN_MEM;
>         if (insn_is_zext(&insn[1]))
>                 insn_count =3D 2; /* this will skip the next zext instruc=
tion */
>         break;
>
> powerpc does after LDX:
> if (size !=3D BPF_DW && insn_is_zext(&insn[i + 1]))
>         addrs[++i] =3D ctx->idx * 4;


I see. Indeed the 64-bit JITs ignore this special zext insn after LDX.

> > It's better to remove
> > if (t !=3D SRC_OP)
> >     return BPF_SIZE(code) =3D=3D BPF_DW;
> > from is_reg64() to avoid adding BPF_ZEXT_REG() insn
> > and fix 32-bit JITs at the same time.
> > RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
> > to always zero upper 32-bit after LDX and
> > then 4th patch to remove these two lines.
>
> I have sent the patches for above, although I think this optimization
> is useful because
> zero extension after LDX is only required when the loaded value is
> later being used as
> a 64-bit value. If it is not the case then the verifier will not emit
> the zext and 32-bit JITs will emit
> 1 less instruction because they expect the verifier to do the zext for
> them where required.

You're correct.
Ok. Let's keep zext for LDX as-is.

