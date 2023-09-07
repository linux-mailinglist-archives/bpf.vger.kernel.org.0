Return-Path: <bpf+bounces-9411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F32797462
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D271C20B70
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6912B78;
	Thu,  7 Sep 2023 15:37:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186729B4
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:37:58 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB462D44
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 08:37:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso18365261fa.2
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101009; x=1694705809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNUjL5NYr3fl2Nz9u4NMZvf537GDFiwVmtA3TLgGYPs=;
        b=cn985BaibGuf0Nq7VgT52F+U32fHJNpMCqt5HkUsgKXw80e7RvR7TQNnByipS0LLGD
         aY3gNdXkXzWnSJIUZ65viHQg164IudMrylLgPtyDG/M4n+P8q8C5pT/RR7mBVNMph5J7
         QX99nt55/VHLESDWWp6H8OowF304Ksb7M9XwHvCjIjfI/xFjWVWntJUAE7nbydYJzglV
         wtP3OpEEaWEd8zbC/DsOyRcO47e18OacVbS0cun+JWlb9m6PgkgsepqsNZ1vXVP9BgQZ
         m3cPe01fRibW+qjlY0hWj/2WdrJvUFUOaUTYfvDn+XAToDBENdCFycug5KhCNJCJlqD2
         f5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101009; x=1694705809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNUjL5NYr3fl2Nz9u4NMZvf537GDFiwVmtA3TLgGYPs=;
        b=YYLPIES3XCCiORXJNizsoWt1kCN2v93DkORb1mzhzvSpUMRN3ZFFmTyd2dFpjMuScu
         rGZKGs+gMdRDQtlTeUq9seoy0nx+YsCw7hwWfsteJoMTayY0Zd4NJ+szdgMugDRp9Dzx
         RXqFSkCaBCQslQkVjBt37oQXY6IsqcuxRpIanB5PWCRDBYFW4bCfo8xNon967YTaeaXr
         GngTd2hw566jkWFxSJLSymQMlnDa8cXNNg2V03+r9LNsxtaAU2ib1jziSHM70WQdKApm
         T//r1KfPFXR3iXPPqmjdTFHOFospNTbEzJh659CAkfTolPVJG3qC7W/QrvfMcdWe1mun
         Lb4g==
X-Gm-Message-State: AOJu0Yze/7qVNuqccwX5muwJxloKXC0sr5bf0O5XosPiQN3LkCR6AqlY
	F6L/J1gemaxFIUTrkqj8W8GO9sXqMFsbhF6vEYY=
X-Google-Smtp-Source: AGHT+IE8M5U7d80188WEncXGMShuelyS9wzD/CMBdxGkQ8nNQlFm1Kgoxlx4/yDxZlR/pnOoJvDJgJfBA6m34InE0nI=
X-Received: by 2002:a05:651c:1214:b0:2bc:f39b:d1a8 with SMTP id
 i20-20020a05651c121400b002bcf39bd1a8mr5282196lja.46.1694101009110; Thu, 07
 Sep 2023 08:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com> <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com>
In-Reply-To: <mb61p4jk630a9.fsf@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Sep 2023 08:36:36 -0700
Message-ID: <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 12:33=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Sep 06 2023, Alexei Starovoitov wrote:
>
> > On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> >>
> >> On Fri, Sep 01 2023, Puranjay Mohan wrote:
> >>
> >> > The problem here is that reg->subreg_def should be set as DEF_NOT_SU=
BREG for
> >> > registers that are used as destination registers of BPF_LDX |
> >> > BPF_MEMSX. I am seeing
> >> > the same problem on ARM32 and was going to send a patch today.
> >> >
> >> > The problem is that is_reg64() returns false for destination registe=
rs
> >> > of BPF_LDX | BPF_MEMSX.
> >> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
> >> > sign extension so
> >> > is_reg64() should return true.
> >> >
> >> > I have written a patch that I will be sending as a reply to this.
> >> > Please let me know if that makes sense.
> >> >
> >>
> >> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NOT_SUB=
REG for destination
> >> registers if is_reg64() returns true for these registers. My patch bel=
ow make is_reg64()
> >> return true for destination registers of BPF_LDX with mod =3D BPF_MEMS=
X. I feel this is the
> >> correct way to fix this problem.
> >>
> >> Here is my patch:
> >>
> >> --- 8< ---
> >> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2001
> >> From: Puranjay Mohan <puranjay12@gmail.com>
> >> Date: Fri, 1 Sep 2023 11:18:59 +0000
> >> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extended =
load as
> >>  64 bit
> >>
> >> The verifier can emit instructions to zero-extend destination register=
s
> >> when the register is being used to keep 32 bit values. This behaviour =
is
> >> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the ca=
se
> >> of a sign extended load instruction, the destination register always h=
as a
> >> 64-bit value, therefore the verifier should not emit zero-extend
> >> instructions for it.
> >>
> >> Change is_reg64() to return true if the register under consideration i=
s a
> >> destination register of LDX instruction with mode =3D BPF_MEMSX.
> >>
> >> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> ---
> >>  kernel/bpf/verifier.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index bb78212fa5b2..93f84b868ccc 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env *en=
v, struct bpf_insn *insn,
> >>
> >>         if (class =3D=3D BPF_LDX) {
> >>                 if (t !=3D SRC_OP)
> >> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
> >> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || BPF_MO=
DE(code) =3D=3D BPF_MEMSX);
> >
> > Looks like we have a bug here for normal LDX too.
> > This 'if' condition was inserting unnecessary zext for LDX.
> > It was harmless for LDX and broken for LDSX.
> > Both LDX and LDSX write all bits of 64-bit register.
> >
> > I think the proper fix is to remove above two lines.
> > wdyt?
>
> For LDX this returns true only if it is with a BPF_DW, for others it retu=
rns false.
> This means a zext is inserted for BPF_LDX | BPF_B/H/W.
>
> This is not a bug because LDX writes 64 bits of the register only with BP=
F_DW.
> With BPF_B/H/W It only writes the lower 32bits and needs zext for upper 3=
2 bits.

No. The interpreter writes all 64-bit for any LDX insn.
All JITs must do it as well.

> On 32 bit architectures where a 64-bit BPF register is simulated with two=
 32-bit registers,
> explicit zext is required for BPF_LDX | BPF_B/H/W.

zext JIT-aid done by the verifier has nothing to do with 32-bit architectur=
e.
It's necessary on 64-bit as well when HW doesn't automatically zero out
upper 32-bit like it does on arm64 and x86-64

> So, we should not remove this.

I still think we should.

