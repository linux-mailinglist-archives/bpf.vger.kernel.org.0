Return-Path: <bpf+bounces-30700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC48D105E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576111F21B62
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D98E167294;
	Mon, 27 May 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXwY2dms"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB173167265
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849900; cv=none; b=Eby+bPIRJ06S/Z6cITiZuNZK/PokrrD7ZvIgQSTmSyXpclOEe3lXxr5CwxGhezYSUHzf1G/4RuqtO4bmFHUjiQfLhdtJkYOAexinQE3xOGVGXjtroTatBqN0TgkTtd3IHDksfBYXhJJRbQvRgeDb5eZHe3ymzIFby5QPU9UvQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849900; c=relaxed/simple;
	bh=hCv6yl5mw6/q3N1s4M6FJ1Tc2rdxtla6CrsFe0ys0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkhF8S5gCoavVGdQd0a6D3LeLbMRydCP7V1Vac40gXuhPVp/u8xBowlgJRoqQ8Pv8oxBMal1QGajeN57EAbvB6jxrzgQYHasRzYgvQift281kcLx7Z6C3vfLAGA79Mler+1Nfqkm0QoMeRfRIKt8mhXdFSPLRZOEchOG5EOmRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXwY2dms; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-356c4e926a3so138520f8f.1
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716849896; x=1717454696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGVftqpU1/5ZEtw6gJzRx0gRL093OPfWqAnmcv+bGwM=;
        b=TXwY2dmsPqt08cDxyZXptmKPDADbAjEL4Vmp3KaTk2bn486JUxpznKJ+2fNQIx/iRL
         P/DeAjRB6ojKw0BaFUGz842g5nqGr4tnochU4UNquyoclU4D7gNz0YhZtEi+HvucRTEF
         NXNZqPgSVVCqHYULppYU8ujt4NY2T4iDwpLReNFZ5TDjiqRFv2u1bnyGx/ZhuSFBVKTN
         5xCpDVAEyjj1/+7qpBzFs2vXqUayHIaPtuxP/RVfuPUt1g50P4CN9/6Lu+8u0ZQRnukz
         7bSEjpjtV1LU01yQHkJwULyH7W1XEZUMpkJ8mGVSl9NAgXurhxjhX05vplBA5zIjXkeZ
         /LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716849896; x=1717454696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGVftqpU1/5ZEtw6gJzRx0gRL093OPfWqAnmcv+bGwM=;
        b=cSsWaepGivDaMHz7M81pQjp0fVti1dB51rUQHaZ1PfBhi0o7KLs4akli705XU2TqDE
         ieXcTFXpL98ubykBtYnjvpngHZMD1+p8MB5DrwZo+bnc3hmqhjbw8clYHkJYMWDtuqIt
         +qeEnS1F5WWyZrbHeJuErI6/W4ESSDFaucxpndJEQb2V3EqfYYNbRnoRAsT2GHgGdmMH
         NOHX3cl7oWZ8JNTAmJTyYLF+7lzX+MGrlxKnVwZeAFqpcZNcOlTQBxP20TJB/AxCMfwA
         iS6PTAqxKVCd7YdkzTwJKeEXGJL7GMkenbCF5l7anbQ8HihnysUTPCRXcp48ejoWQSxu
         zIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeliIaQ9gdg0HADy4bLv3iHdxFjz9ZH3CPk+C3xjzivXtrRRD2wkWgClTajWY1W8OVX8i0Op3/bx8wMw+bLtuFx4U7
X-Gm-Message-State: AOJu0YwGiGbGT6+J/X5uBpNHpzvuy0mYRn6Hcee5rG3obU1HVNKqLNnb
	FvW1v3AjIbCcJp5ky870ZIBZQ872maWsuJNRAso5Hkwbqzd7VNKz7gyMNkYIXMv6qQZ5uqPbWvg
	fgR9c40+xS+i0EgcSpo9DjMvQQmo=
X-Google-Smtp-Source: AGHT+IFXnyQ8uJxzz9ocbmpnYG6BTT0oEs5LLhGgomPFu+Vzp6LKKEPzTsLNL9W7s+dg4FdC1vhKC+Zeg9E/nEh2GTM=
X-Received: by 2002:adf:ea0c:0:b0:34d:837a:9d08 with SMTP id
 ffacd0b85a97d-3552fdfd452mr7258969f8f.61.1716849895857; Mon, 27 May 2024
 15:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com> <91453e3f-66b0-4927-a756-bd18f9e6bf05@moroto.mountain>
In-Reply-To: <91453e3f-66b0-4927-a756-bd18f9e6bf05@moroto.mountain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 May 2024 15:44:44 -0700
Message-ID: <CAADnVQLWbPd2skY1Lzs8oJ=9Ag9e2qD9Khhb4ycQRimZqdeBfA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	kbuild test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:26=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hi Alexei,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov=
/selftests-bpf-Remove-i-zero-workaround-and-add-new-tests/20240525-111247
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20240525031156.13545-1-alexei.st=
arovoitov%40gmail.com
> patch subject: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in op=
en coded iters and may_goto loop.
> config: nios2-randconfig-r071-20240526 (https://download.01.org/0day-ci/a=
rchive/20240526/202405260726.0H6QiGNy-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 13.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202405260726.0H6QiGNy-lkp@intel.com/
>
> New smatch warnings:
> kernel/bpf/verifier.c:15315 check_cond_jmp_op() error: uninitialized symb=
ol 'other_dst_reg'.
>
> Old smatch warnings:
> arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: unin=
itialized symbol 'sp'.
>
> vim +/other_dst_reg +15315 kernel/bpf/verifier.c
>
> 58e2af8b3a6b58 Jakub Kicinski     2016-09-21  15108  static int check_con=
d_jmp_op(struct bpf_verifier_env *env,
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15109                      =
    struct bpf_insn *insn, int *insn_idx)
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15110  {
> f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15111     struct bpf_verifi=
er_state *this_branch =3D env->cur_state;
> f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15112     struct bpf_verifi=
er_state *other_branch;
> f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15113     struct bpf_reg_st=
ate *regs =3D this_branch->frame[this_branch->curframe]->regs;
> fb8d251ee2a6bf Alexei Starovoitov 2019-06-15  15114     struct bpf_reg_st=
ate *dst_reg, *other_branch_regs, *src_reg =3D NULL;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15115     struct bpf_reg_st=
ate *eq_branch_regs, *other_dst_reg, *other_src_reg =3D NULL;
> c31534267c180f Andrii Nakryiko    2023-11-01  15116     struct bpf_reg_st=
ate fake_reg =3D {};
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15117     u8 opcode =3D BPF=
_OP(insn->code);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15118     bool is_jmp32, ig=
nore_pred;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15119     bool has_src_reg =
=3D false;
> fb8d251ee2a6bf Alexei Starovoitov 2019-06-15  15120     int pred =3D -1;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15121     int err;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15122
> 092ed0968bb648 Jiong Wang         2019-01-26  15123     /* Only condition=
al jumps are expected to reach here. */
> 011832b97b311b Alexei Starovoitov 2024-03-05  15124     if (opcode =3D=3D=
 BPF_JA || opcode > BPF_JCOND) {
> 092ed0968bb648 Jiong Wang         2019-01-26  15125             verbose(e=
nv, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15126             return -E=
INVAL;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15127     }
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15128
> 011832b97b311b Alexei Starovoitov 2024-03-05  15129     if (opcode =3D=3D=
 BPF_JCOND) {
> 011832b97b311b Alexei Starovoitov 2024-03-05  15130             struct bp=
f_verifier_state *cur_st =3D env->cur_state, *queued_st, *prev_st;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15131             int idx =
=3D *insn_idx;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15132
> 011832b97b311b Alexei Starovoitov 2024-03-05  15133             if (insn-=
>code !=3D (BPF_JMP | BPF_JCOND) ||
> 011832b97b311b Alexei Starovoitov 2024-03-05  15134                 insn-=
>src_reg !=3D BPF_MAY_GOTO ||
> 011832b97b311b Alexei Starovoitov 2024-03-05  15135                 insn-=
>dst_reg || insn->imm || insn->off =3D=3D 0) {
> 011832b97b311b Alexei Starovoitov 2024-03-05  15136                     v=
erbose(env, "invalid may_goto off %d imm %d\n",
> 011832b97b311b Alexei Starovoitov 2024-03-05  15137                      =
       insn->off, insn->imm);
> 011832b97b311b Alexei Starovoitov 2024-03-05  15138                     r=
eturn -EINVAL;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15139             }
> 011832b97b311b Alexei Starovoitov 2024-03-05  15140             prev_st =
=3D find_prev_entry(env, cur_st->parent, idx);
> 011832b97b311b Alexei Starovoitov 2024-03-05  15141
> 011832b97b311b Alexei Starovoitov 2024-03-05  15142             /* branch=
 out 'fallthrough' insn as a new state to explore */
> 011832b97b311b Alexei Starovoitov 2024-03-05  15143             queued_st=
 =3D push_stack(env, idx + 1, idx, false);
> 011832b97b311b Alexei Starovoitov 2024-03-05  15144             if (!queu=
ed_st)
> 011832b97b311b Alexei Starovoitov 2024-03-05  15145                     r=
eturn -ENOMEM;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15146
> 011832b97b311b Alexei Starovoitov 2024-03-05  15147             queued_st=
->may_goto_depth++;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15148             if (prev_=
st)
> 011832b97b311b Alexei Starovoitov 2024-03-05  15149                     w=
iden_imprecise_scalars(env, prev_st, queued_st);
> 011832b97b311b Alexei Starovoitov 2024-03-05  15150             *insn_idx=
 +=3D insn->off;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15151             return 0;
> 011832b97b311b Alexei Starovoitov 2024-03-05  15152     }
> 011832b97b311b Alexei Starovoitov 2024-03-05  15153
> d75e30dddf7344 Yafang Shao        2023-08-23  15154     /* check src2 ope=
rand */
> d75e30dddf7344 Yafang Shao        2023-08-23  15155     err =3D check_reg=
_arg(env, insn->dst_reg, SRC_OP);
> d75e30dddf7344 Yafang Shao        2023-08-23  15156     if (err)
> d75e30dddf7344 Yafang Shao        2023-08-23  15157             return er=
r;
> d75e30dddf7344 Yafang Shao        2023-08-23  15158
> d75e30dddf7344 Yafang Shao        2023-08-23  15159     dst_reg =3D &regs=
[insn->dst_reg];
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15160     if (BPF_SRC(insn-=
>code) =3D=3D BPF_X) {
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15161             if (insn-=
>imm !=3D 0) {
> 092ed0968bb648 Jiong Wang         2019-01-26  15162                     v=
erbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15163                     r=
eturn -EINVAL;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15164             }
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15165
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15166             /* check =
src1 operand */
> dc503a8ad98474 Edward Cree        2017-08-15  15167             err =3D c=
heck_reg_arg(env, insn->src_reg, SRC_OP);
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15168             if (err)
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15169                     r=
eturn err;
> 1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15170
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15171             has_src_r=
eg =3D true;
> d75e30dddf7344 Yafang Shao        2023-08-23  15172             src_reg =
=3D &regs[insn->src_reg];
> d75e30dddf7344 Yafang Shao        2023-08-23  15173             if (!(reg=
_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
> d75e30dddf7344 Yafang Shao        2023-08-23  15174                 is_po=
inter_value(env, insn->src_reg)) {
> 61bd5218eef349 Jakub Kicinski     2017-10-09  15175                     v=
erbose(env, "R%d pointer comparison prohibited\n",
> 1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15176                      =
       insn->src_reg);
> 1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15177                     r=
eturn -EACCES;
> 1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15178             }
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15179     } else {
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15180             if (insn-=
>src_reg !=3D BPF_REG_0) {
> 092ed0968bb648 Jiong Wang         2019-01-26  15181                     v=
erbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15182                     r=
eturn -EINVAL;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15183             }
> c31534267c180f Andrii Nakryiko    2023-11-01  15184             src_reg =
=3D &fake_reg;
> c31534267c180f Andrii Nakryiko    2023-11-01  15185             src_reg->=
type =3D SCALAR_VALUE;
> c31534267c180f Andrii Nakryiko    2023-11-01  15186             __mark_re=
g_known(src_reg, insn->imm);
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15187     }
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15188
> 092ed0968bb648 Jiong Wang         2019-01-26  15189     is_jmp32 =3D BPF_=
CLASS(insn->code) =3D=3D BPF_JMP32;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15190     if (dst_reg->type=
 !=3D SCALAR_VALUE || src_reg->type !=3D SCALAR_VALUE)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15191             ignore_pr=
ed =3D false;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15192     /*
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15193      * Compilers ofte=
n optimize loop exit condition to equality, so
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15194      *      for (i =
=3D 0; i < 100; i++) arr[i] =3D 1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15195      * becomes
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15196      *      for (i =
=3D 0; i !=3D 100; i++) arr[1] =3D 1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15197      * Hence treat !=
=3D and =3D=3D conditions specially in the verifier.
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15198      * Widen only not=
-predicted branch and keep predict branch as is. Example:
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15199      *    r1 =3D 0
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15200      *    goto L1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15201      * L2:
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15202      *    arr[r1] =3D=
 1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15203      *    r1++
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15204      * L1:
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15205      *    if r1 !=3D =
100 goto L2
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15206      *    fallthrough=
: r1=3D100 after widening
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15207      *    other_branc=
h: r1 stays as-is (0, 1, 2, ..)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15208      *
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15209      *  Also recogniz=
e the case where both LHS and RHS are constant and
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15210      *  equal to each=
 other. In this case don't widen at all and take the
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15211      *  predicted pat=
h. This key heuristic allows the verifier detect loop
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15212      *  end condition=
 and 'for (i =3D 0; i !=3D 100; i++)' is validated just
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15213      *  like bounded =
loop.
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15214      */
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15215     else if (is_reg_c=
onst(dst_reg, is_jmp32) && is_reg_const(src_reg, is_jmp32) &&
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15216         reg_const_val=
ue(dst_reg, is_jmp32) =3D=3D reg_const_value(src_reg, is_jmp32))
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15217             ignore_pr=
ed =3D false;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15218     else
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15219             ignore_pr=
ed =3D (get_loop_entry(this_branch) ||
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15220                      =
      this_branch->may_goto_depth) &&
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15221                      =
       /* Gate widen_reg() logic */
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15222                      =
       env->bpf_capable;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15223
> c31534267c180f Andrii Nakryiko    2023-11-01  15224     pred =3D is_branc=
h_taken(dst_reg, src_reg, opcode, is_jmp32);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15225     if (pred >=3D 0 &=
& !ignore_pred) {
> cac616db39c207 John Fastabend     2020-05-21  15226             /* If we =
get here with a dst_reg pointer type it is because
> cac616db39c207 John Fastabend     2020-05-21  15227              * above =
is_branch_taken() special cased the 0 comparison.
> cac616db39c207 John Fastabend     2020-05-21  15228              */
> cac616db39c207 John Fastabend     2020-05-21  15229             if (!__is=
_pointer_value(false, dst_reg))
> b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15230                     e=
rr =3D mark_chain_precision(env, insn->dst_reg);
> 6d94e741a8ff81 Alexei Starovoitov 2020-11-10  15231             if (BPF_S=
RC(insn->code) =3D=3D BPF_X && !err &&
> 6d94e741a8ff81 Alexei Starovoitov 2020-11-10  15232                 !__is=
_pointer_value(false, src_reg))
> b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15233                     e=
rr =3D mark_chain_precision(env, insn->src_reg);
> b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15234             if (err)
> b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15235                     r=
eturn err;
> b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15236     }
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15237
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15238     if (pred < 0 || i=
gnore_pred) {
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15239             other_bra=
nch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15240                      =
                 false);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15241             if (!othe=
r_branch)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15242                     r=
eturn -EFAULT;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15243             other_bra=
nch_regs =3D other_branch->frame[other_branch->curframe]->regs;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15244             other_dst=
_reg =3D &other_branch_regs[insn->dst_reg];
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15245             if (has_s=
rc_reg)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15246                     o=
ther_src_reg =3D &other_branch_regs[insn->src_reg];
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15247     }
>
> other_dst_reg not set on else path.
>
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15248
> 4f7b3e82589e0d Alexei Starovoitov 2018-12-03  15249     if (pred =3D=3D 1=
) {
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15250             /* Only f=
ollow the goto, ignore fall-through. If needed, push
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15251              * the fa=
ll-through branch for simulation under speculative
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15252              * execut=
ion.
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15253              */
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15254             if (!env-=
>bypass_spec_v1 &&
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15255                 !sani=
tize_speculative_path(env, insn, *insn_idx + 1,
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15256                      =
                      *insn_idx))
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15257                     r=
eturn -EFAULT;
> 1a8a315f008a58 Andrii Nakryiko    2023-10-11  15258             if (env->=
log.level & BPF_LOG_LEVEL)
> 1a8a315f008a58 Andrii Nakryiko    2023-10-11  15259                     p=
rint_insn_state(env, this_branch->frame[this_branch->curframe]);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15260             if (ignor=
e_pred) {
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15261                     /=
* dst and src regs are scalars. Widen them */
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15262                     w=
iden_reg(dst_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15263                     i=
f (has_src_reg)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15264                      =
       widen_reg(src_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15265                     /=
*
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15266                      =
* Widen other branch only if not comparing for equlity.
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15267                      =
* Example:
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15268                      =
*   r1 =3D 1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15269                      =
*   if (r1 < 100)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15270                      =
* will produce
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15271                      =
*   [0, 99] and [100, UMAX] after widening and reg_set_min_max().
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15272                      =
*
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15273                      =
*   r1 =3D 1
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15274                      =
*   if (r1 =3D=3D 100)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15275                      =
* will produce
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15276                      =
*    [1] and [100] after widening in other_branch and reg_set_min_max().
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15277                      =
*/
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15278                     i=
f (opcode !=3D BPF_JEQ && opcode !=3D BPF_JNE) {
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15279                      =
       widen_reg(other_dst_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15280                      =
       if (has_src_reg)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15281                      =
               widen_reg(other_src_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15282                     }
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15283             } else {
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15284                     *=
insn_idx +=3D insn->off;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15285                     r=
eturn 0;
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15286             }
> 4f7b3e82589e0d Alexei Starovoitov 2018-12-03  15287     } else if (pred =
=3D=3D 0) {
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15288             /* Only f=
ollow the fall-through branch, since that's where the
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15289              * progra=
m will go. If needed, push the goto branch for
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15290              * simula=
tion under speculative execution.
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15291              */
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15292             if (!env-=
>bypass_spec_v1 &&
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15293                 !sani=
tize_speculative_path(env, insn,
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15294                      =
                      *insn_idx + insn->off + 1,
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15295                      =
                      *insn_idx))
> 9183671af6dbf6 Daniel Borkmann    2021-05-28  15296                     r=
eturn -EFAULT;
> 1a8a315f008a58 Andrii Nakryiko    2023-10-11  15297             if (env->=
log.level & BPF_LOG_LEVEL)
> 1a8a315f008a58 Andrii Nakryiko    2023-10-11  15298                     p=
rint_insn_state(env, this_branch->frame[this_branch->curframe]);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15299             if (ignor=
e_pred) {
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15300                     i=
f (opcode !=3D BPF_JEQ && opcode !=3D BPF_JNE) {
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15301                      =
       widen_reg(dst_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15302                      =
       if (has_src_reg)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15303                      =
               widen_reg(src_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15304                     }
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15305                     w=
iden_reg(other_dst_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15306                     i=
f (has_src_reg)
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15307                      =
       widen_reg(other_src_reg);
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15308             } else {
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15309                     r=
eturn 0;
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15310             }
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15311     }
> 17a5267067f3c3 Alexei Starovoitov 2014-09-26  15312
> 484611357c19f9 Josef Bacik        2016-09-28  15313     if (BPF_SRC(insn-=
>code) =3D=3D BPF_X) {
> 5f99f312bd3bed Andrii Nakryiko    2023-11-11  15314             err =3D r=
eg_set_min_max(env,
> 689049426b9d3b Alexei Starovoitov 2024-05-24 @15315                      =
             other_dst_reg, other_src_reg,
>                                                                          =
             ^^^^^^^^^^^^^
>
> 4621202adc5bc0 Andrii Nakryiko    2023-11-01  15316                      =
             dst_reg, src_reg, opcode, is_jmp32);
> 4621202adc5bc0 Andrii Nakryiko    2023-11-01  15317     } else /* BPF_SRC=
(insn->code) =3D=3D BPF_K */ {
> 5f99f312bd3bed Andrii Nakryiko    2023-11-11  15318             err =3D r=
eg_set_min_max(env,
> 689049426b9d3b Alexei Starovoitov 2024-05-24  15319                      =
             other_dst_reg,
>                                                                          =
             ^^^^^^^^^^^^^
> Passed to reg_set_min_max() without being initialized.

No. It's initialized when passed. It's a false positive.
Try to make smatch smarter?

