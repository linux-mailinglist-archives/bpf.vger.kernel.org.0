Return-Path: <bpf+bounces-11545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809837BBD2A
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 18:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A101C20957
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7F28DBD;
	Fri,  6 Oct 2023 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/Lq5saE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E557BE4F
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:46:14 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9231BD6
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 09:44:48 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b0a569e2f5so880379241.3
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696610679; x=1697215479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcwTHXgRnZuhbGDE1wxh+CjRdtVciqpN6ZjARirGVYw=;
        b=P/Lq5saEd+zjbPOBqSQ4JS1opQS7S3KSaCi9FNHFgOx5jJ9PYv9H5Ck+ZkzBDH4sTW
         Mx7+AyPd2CPuWlwRrgzBjp/BemlTA9MsPtb/+KXT4ajK1xR9P945Ya5kOlu8FdMVtoR0
         zefwAVqPP9fKOxSoV4KqQe9QMlTHoREgDXpDzq8fq7zUDcqO3v0DD0D1JHV8+tcLg0SI
         XGUhg/UTLIB4aXJTXU5OzSI4OfY33FZ+1YwN2bNBCrNHlx6ZIyt3lJ3aoKKsC3gup1bA
         ggIGBsASmNzY+IP3geoK4P000sfrnvwF5xaQ82cpCr0LRdAulmW5+kyn8B+XDtLH4DlM
         RZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610679; x=1697215479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcwTHXgRnZuhbGDE1wxh+CjRdtVciqpN6ZjARirGVYw=;
        b=L9v7h6JiAl2mhYrjlyEALGeaP5rxkshBia1LQEAthGbIFWeqc9GsZHPDHMIJUXSj31
         021I2wb+ut/TGxwkRoDbD5ZmDxoF0t7NKzuZJJamU2qo0x8uzlb5kV1LDHMjBiB38838
         2DXgb+Au3mEEcfxxhLP27BHu42nEboYqulfezOuLJf524gNcB5skZmEL87M1XCl299ub
         rlYIqiDbEMV70EuUVjESGnOlPeq2rYYb6n59wW+cOT0X1MyF5F9CtoIb+/dZlX4zn3Js
         lexI8MG40/dZCDgEx7Z6/6EY2m0zNcEoosmUpSzhWyshRwCGqq5+sOGwZvTrc6C8O3JB
         /qQA==
X-Gm-Message-State: AOJu0Yz0oQdxFfuLz8DiBzvdK4CsW1XLcMrUBlpIRhfCqlGvPk8FtMvD
	TDwTopFDwN7H1nADCIlV0wgoNNALkNDm6l8vI4s8nQ==
X-Google-Smtp-Source: AGHT+IG4Yn8cgBfHyS7Szw/jWC8lUYghgZmDRjdjhb38GRwlD9L0RFSF6I4zdqDlgIdghGEy2OhAsxEOvXHMTwDD3Lo=
X-Received: by 2002:a1f:ec83:0:b0:49a:a3ee:d280 with SMTP id
 k125-20020a1fec83000000b0049aa3eed280mr8321722vkh.16.1696610678651; Fri, 06
 Oct 2023 09:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005145814.83122-1-hffilwlqm@gmail.com> <20231005145814.83122-2-hffilwlqm@gmail.com>
 <ZR763xGlqqu2gb41@google.com> <787e2f5e-41b3-0793-97e3-a6566c2b34bf@gmail.com>
In-Reply-To: <787e2f5e-41b3-0793-97e3-a6566c2b34bf@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 6 Oct 2023 09:44:27 -0700
Message-ID: <CAKH8qBtjbEdCVyHr7seTFYcgNRF_uzGW761GVH-5Q81=HuLGuw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com, 
	iii@linux.ibm.com, hengqi.chen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 6:43=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 6/10/23 02:05, Stanislav Fomichev wrote:
> > On 10/05, Leon Hwang wrote:
> >> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailc=
all
> >> handling in JIT"), the tailcall on x64 works better than before.
> >>
> >> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprog=
rams
> >> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> >>
> >> How about:
> >>
> >> 1. More than 1 subprograms are called in a bpf program.
> >> 2. The tailcalls in the subprograms call the bpf program.
> >>
> >> Because of missing tail_call_cnt back-propagation, a tailcall hierarch=
y
> >> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> >>
> >> As we know, in tail call context, the tail_call_cnt propagates by stac=
k
> >> and rax register between BPF subprograms. So, propagating tail_call_cn=
t
> >> pointer by stack and rax register makes tail_call_cnt as like a global
> >> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
> >> hierarchy cases.
> >>
> >> Before jumping to other bpf prog, load tail_call_cnt from the pointer
> >> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
> >> tail_call_cnt by the pointer.
> >>
> >> But, where does tail_call_cnt store?
> >>
> >> It stores on the stack of uppest-hierarchy-layer bpf prog, like
> >>
> >>  |  STACK  |
> >>  +---------+ RBP
> >>  |         |
> >>  |         |
> >>  |         |
> >>  | tcc_ptr |
> >>  |   tcc   |
> >>  |   rbx   |
> >>  +---------+ RSP
> >>
> >> Why not back-propagate tail_call_cnt?
> >>
> >> It's because it's vulnerable to back-propagate it. It's unable to work
> >> well with the following case.
> >>
> >> int prog1();
> >> int prog2();
> >>
> >> prog1 is tail caller, and prog2 is tail callee. If we do back-propagat=
e
> >> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at th=
e
> >> same time? The answer is NO. Otherwise, there will be a register to be
> >> polluted, which will make kernel crash.
> >>
> >> Can tail_call_cnt store at other place instead of the stack of bpf pro=
g?
> >>
> >> I'm not able to infer a better place to store tail_call_cnt. It's not =
a
> >> working inference to store it at ctx or on the stack of bpf prog's
> >> caller.
> >>
> >> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handl=
ing in JIT")
> >> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for =
x64 JIT")
> >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++------------=
-
> >>  1 file changed, 76 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 8c10d9abc2394..8ad6368353c2b 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -256,7 +256,7 @@ struct jit_context {
> >>  /* Number of bytes emit_patch() needs to generate instructions */
> >>  #define X86_PATCH_SIZE              5
> >>  /* Number of bytes that will be skipped on tailcall */
> >> -#define X86_TAIL_CALL_OFFSET        (11 + ENDBR_INSN_SIZE)
> >> +#define X86_TAIL_CALL_OFFSET        (24 + ENDBR_INSN_SIZE)
> >>
> >>  static void push_r12(u8 **pprog)
> >>  {
> >> @@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *cal=
lee_regs_used)
> >>      *pprog =3D prog;
> >>  }
> >>
> >
> > [..]
> >
> >> +static void emit_nops(u8 **pprog, int len)
> >> +{
> >> +    u8 *prog =3D *pprog;
> >> +    int i, noplen;
> >> +
> >> +    while (len > 0) {
> >> +            noplen =3D len;
> >> +
> >> +            if (noplen > ASM_NOP_MAX)
> >> +                    noplen =3D ASM_NOP_MAX;
> >> +
> >> +            for (i =3D 0; i < noplen; i++)
> >> +                    EMIT1(x86_nops[noplen][i]);
> >> +            len -=3D noplen;
> >> +    }
> >> +
> >> +    *pprog =3D prog;
> >> +}
> >
> > From high level - makes sense to me.
> > I'll leave a thorough review to the people who understand more :-)
> > I see Maciej commenting on your original "Fix tailcall infinite loop"
> > series.
>
> Welcome for your review.
>
> >
> > One suggestion I have is: the changes to 'memcpy(prog, x86_nops[5],
> > X86_PATCH_SIZE);' and this emit_nops move here don't seem like
> > they actually belong to this patch. Maybe do them separately?
>
> Moving emit_nops here is for them:
>
> +                       /* Keep the same instruction layout. */
> +                       emit_nops(&prog, 3);
> +                       emit_nops(&prog, 6);
> +                       emit_nops(&prog, 6);
>
> and do the changes to 'memcpy(prog, x86_nops[5], X86_PATCH_SIZE);' BTW.

Right, I'm saying that you can do the move + replace memcpy in a
separate (first) patch to make the patch with the actual changes a bit
smaller.
But that's not strictly required, up to you.

