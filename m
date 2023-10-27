Return-Path: <bpf+bounces-13406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F67D905C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04829B213D3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 07:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A280FC04;
	Fri, 27 Oct 2023 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi+TqgDg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70ED312
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:52:12 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E810A;
	Fri, 27 Oct 2023 00:52:10 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1289229276.0;
        Fri, 27 Oct 2023 00:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698393130; x=1698997930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBJ/vLGbn8T31J+Jp9hMFCbdezdboPZSmsjGMxZtQ9M=;
        b=Wi+TqgDgRV08Pu+e1Q6hEQ5CJ9qmXeWKtAaz+j5mjVrFtAUt3+02mtcSqQRzHupNXj
         Zpya+JMgWFDUww+Rgr2CONwuCZCHg0VmyfigA1BvMuJFEvOXlL+LvEMbDvpoLk7Jw3eR
         Q4osMHkrIfwlQexG4/pZ+5OUSLmV0KXM+KwT+chsoqPPOETTm6bH5VSu3Ps9YoWRBqEV
         0sD7rF0XaB3n6UdH/8bxjHgFa9Ck/YtwlCiCsv05BsZQlBN4acRG1SWudizaKhN8M95Q
         qOSImPpxAKack+ye2J3I0RdRaWdgjXn7H+K7OzTwMGWzcTnBvliMPZ2EAkDMhsIn3cmh
         Fq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393130; x=1698997930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBJ/vLGbn8T31J+Jp9hMFCbdezdboPZSmsjGMxZtQ9M=;
        b=AkJX0P27HJjcYwko5BWg4bGxliIToJCWc7LOAQCmDG1qMyPxCw/f6tWtswWLyLKwVN
         82RYc1MQEbiOJumtugjg6DA0b5VbNthvAl9QsZFuk7W4oQ7NtBRa1TBUXA5JaBMcXawZ
         91FSqz64XbO7/BUTWvlBHsYCckCsQYtGJhVI1/+F8FobCoulKBAI6QbAa/DJzLSFIZtC
         suDKPOBFl+vcpM2YOgQ60cnLs7HWykjVCKwBPBqBkF7krxSMzl7rVqbRym8xg+LUaPol
         0DrjvFczDzefFbB6qsKGM+nReH4JIQoo9WOCuzMxz6O3x462+DjoD0O6rPBLfkuBn+ga
         6QXw==
X-Gm-Message-State: AOJu0YzhA8cpsFamVEh8NEB2mZzhH0r016Rp5yK9KH3L13SPp+P96wdw
	JBW+a30/Gi5ji2d9GnX1QVryde/w1NK8206crg==
X-Google-Smtp-Source: AGHT+IHiQlUzWvtfsIHc/qBSiQ3u/a3Hc44INB42XIZiYOkf89GPA1evTCYOk1vC1YuteO+KWfZdQ7tczKxqiHGfDFw=
X-Received: by 2002:a25:f828:0:b0:d9a:3d72:bfab with SMTP id
 u40-20020a25f828000000b00d9a3d72bfabmr1710093ybd.40.1698393129979; Fri, 27
 Oct 2023 00:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
 <20231026-fix-check-stack-write-v1-1-6b325ef3ce7e@gmail.com>
 <ZTtjQlqRQWCWwmHx@u94a> <ZTtqSnKmaQ4ma98g@u94a>
In-Reply-To: <ZTtqSnKmaQ4ma98g@u94a>
From: Hao Sun <sunhao.th@gmail.com>
Date: Fri, 27 Oct 2023 09:51:58 +0200
Message-ID: <CACkBjsZM8pYj6Y7vazw_Rp3ZYDnpTiCSO0bNYdt36MxFEvqZZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix check_stack_write_fixed_off() to
 correctly spill imm
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 9:44=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Fri, Oct 27, 2023 at 03:14:10PM +0800, Shung-Hsi Yu wrote:
> > On Thu, Oct 26, 2023 at 05:13:10PM +0200, Hao Sun wrote:
> > > In check_stack_write_fixed_off(), imm value is cast to u32 before bei=
ng
> > > spilled to the stack. Therefore, the sign information is lost, and th=
e
> > > range information is incorrect when load from the stack again.
> > >
> > > For the following prog:
> > > 0: r2 =3D r10
> > > 1: *(u64*)(r2 -40) =3D -44
> > > 2: r0 =3D *(u64*)(r2 - 40)
> > > 3: if r0 s<=3D 0xa goto +2
> > > 4: r0 =3D 1
> > > 5: exit
> > > 6: r0  =3D 0
> > > 7: exit
> > >
> > > The verifier gives:
> > > func#0 @0
> > > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > 0: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
> > > 1: (7a) *(u64 *)(r2 -40) =3D -44        ; R2_w=3Dfp0 fp-40_w=3D429496=
7252
> > > 2: (79) r0 =3D *(u64 *)(r2 -40)         ; R0_w=3D4294967252 R2_w=3Dfp=
0
> > > fp-40_w=3D4294967252
> > > 3: (c5) if r0 s< 0xa goto pc+2
> > > mark_precise: frame0: last_idx 3 first_idx 0 subseq_idx -1
> > > mark_precise: frame0: regs=3Dr0 stack=3D before 2: (79) r0 =3D *(u64 =
*)(r2 -40)
> > > 3: R0_w=3D4294967252
> > > 4: (b7) r0 =3D 1                        ; R0_w=3D1
> > > 5: (95) exit
> > > verification time 7971 usec
> > > stack depth 40
> > > processed 6 insns (limit 1000000) max_states_per_insn 0 total_states =
0
> > > peak_states 0 mark_read 0
> > >
> > > So remove the incorrect cast, since imm field is declared as s32, and
> > > __mark_reg_known() takes u64, so imm would be correctly sign extended
> > > by compiler.
> > >
> > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> >
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >
> > The acked-by applies to future version of the patchset as well.
>

(BPF_ALU | BPF_MOV | BPF_K) is handled correctly in the current
code, i.e., no cast in BPF_ALU64 so that the sign is extended, and
the cast in BPF_ALU correctly zero extend the reg.

> Oh and since this is a fix it would be great to have the fixes tag[1] to
> specify when the bug was introduced
>
> Fixes: ecdf985d7615 ("bpf: track immediate values written to stack by BPF=
_ST instruction")
>

Noted, thanks.

> Add Cc tag for stable[2] so stable kernels pick up the fix as well
>
> Cc: stable@vger.kernel.org
>
> And ideally specify that the patch should be applied to the bpf tree rath=
er
> than bpf-next[3] (though the BPF maintainers has the final say on which t=
ree
> this patch should be applied).
>
> I'd owe you a big thank as well since this helps with our internal proces=
s
> at my company. So thank you in advance!
>
> 1: https://docs.kernel.org/process/submitting-patches.html#describe-your-=
changes
> 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.htm=
l#option-1
> 3: https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-the-changes-mak=
e-their-way-into-linux
>
> > FWIW I think we'd also need the same treatment for the (BPF_ALU | BPF_M=
OV |
> > BPF_K) case in check_alu_op().
> >
> > > ---
> > >  kernel/bpf/verifier.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 857d76694517..44af69ce1301 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct b=
pf_verifier_env *env,
> > >                insn->imm !=3D 0 && env->bpf_capable) {
> > >             struct bpf_reg_state fake_reg =3D {};
> > >
> > > -           __mark_reg_known(&fake_reg, (u32)insn->imm);
> > > +           __mark_reg_known(&fake_reg, insn->imm);
> > >             fake_reg.type =3D SCALAR_VALUE;
> > >             save_register_state(state, spi, &fake_reg, size);
> > >     } else if (reg && is_spillable_regtype(reg->type)) {
> > >
> > > --
> > > 2.34.1
> > >

