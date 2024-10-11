Return-Path: <bpf+bounces-41713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5E999BA4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 06:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D5D1C229AE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AD1F4FD8;
	Fri, 11 Oct 2024 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntSPV13D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704831917FB
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621005; cv=none; b=GPimRFbj/B9d+EAvmw+lWiICLfkAf68w9k4UoyG77IUAW7bjMaWSLe2jSziM7O+TNRPdR/MHzOx3/qEiJbabDN+idToU+nGWVB+XXVSWWs2r35/Q+gb6yDvAQu4dQsbY/6h16NVsN05glm/I22Ql376Q0UbYO0rvRAwQgW4WuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621005; c=relaxed/simple;
	bh=ujkSViOn/turF8+1CUXOWx7clDEqjC5fBe14Mp7s2Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj77Dbb5pc6QXuMaSzOnFrHUUPciMzdPVfYVviIe1c59WRRCYd1/XzzBfJabpPgannAhcl325QmY6WYA8s4SPS67nDUF4lRpdatUAZooED7PwqmqUPN4MUT26Bburug5vtdTB24EqTO1V4yEmBCUFBRh0/06wM+ZQ8SiIOYqKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntSPV13D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb806623eso13597875e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728621002; x=1729225802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuGEOU/axvpOY9yH+vtwnVq4dOxRJBrg6F+Rqa8hNMs=;
        b=ntSPV13DfpgNfRkPrqaG80Pb822gVrPcds77v1QLvCi7tddvZscahiq/9NPFHR1bmY
         PTHyYUBfjYTZ6GCQYT60e62Upem95FsRPCH2kYL3phyelNW6MFLTvYLmFSf1c5YVpmIn
         VbnORuMqyuYH/0ZdKW0Bt9GjdsPIkJIIV1zurXtuT+6LpOJAeFQ01biR15Yhq4aWWwdC
         kPWuwJMCrjUgJKojRHg6Sk+nLZWX0ZrmTM8idqislJEW9YXOsjzTyLuZu6vSNEDMC6e+
         yvBUeNhuqL8ENHGCT1m5TzWOeq87ZlQMtI68t3SEX2yAS/zclXkCoa8vTjyMPVW0eGLe
         pWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728621002; x=1729225802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuGEOU/axvpOY9yH+vtwnVq4dOxRJBrg6F+Rqa8hNMs=;
        b=pGZgQ/2gQxsuXeAaf+aINkklKjijssui6TaRqXq2nrYP8rOcQj5Krq67Ri6vHlgTvi
         Wf6o6HDcdz8tCx9uLYIdpuJl32A30831c5qYZC5E13oR4jZJUwiq+IiwdBc09dEx/ryW
         c6GMWNCtIBrSCuX7XBxBDtof/VjeIBkzXcAXSNNq0o8qGbFTKVeuOl0BYJWXmJCzghgz
         u2axWfsCXsMhRMuEMjGj0amwgL+wVM8oVaQMdzzAkpip1QZhLYqHE2zyl/ClccHxVsG7
         Zxv8n9RSUUK8uTAYDPBbx1xFMvxpcr7HlrCseXByqsy/6LxpGJZVz6TruCFaNpqwZd4c
         ib7A==
X-Gm-Message-State: AOJu0YwDg2pQheFrCsN1UP6Doat7QJchx/SWbGHWiOLgPyp6IdsNukYy
	U9Z+3L7Ha4oXmE+B3BDKqY5kpLcSX6fzXQxYC1bqbahY843K+Fxtup68o8JPiJzEVQLyWUskMlg
	TAZG1Wep7RtTSFAYreLcHWgrFzu5zbA==
X-Google-Smtp-Source: AGHT+IHJxe/axs+fGmC9uI74vsCCc04j+dyeHk4GYNbySFBQUwIY6K5AI+nfvaELvgpHmLxsttPW9cS/jkniMo/F/1I=
X-Received: by 2002:a05:600c:35d3:b0:430:58b8:aacf with SMTP id
 5b1f17b1804b1-4311def41d7mr8119865e9.15.1728621001511; Thu, 10 Oct 2024
 21:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175638.1899406-1-yonghong.song@linux.dev> <CAADnVQJmEkQvAhPs3q1oYGpdO48n2JE3MnMxXgYCMoUup=UOBg@mail.gmail.com>
 <64da4fb8-7e13-41fc-891e-c0f79bf778d1@linux.dev>
In-Reply-To: <64da4fb8-7e13-41fc-891e-c0f79bf778d1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 21:29:50 -0700
Message-ID: <CAADnVQKyDT+W8-Vgr0GcCmffeKqKjkNrkSa7=GaggcK83vbvYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 09/10] bpf, x86: Jit support for nested bpf_prog_call
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/10/24 1:53 PM, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 10:59=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>   static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_pro=
g,
> >> -                               enum bpf_priv_stack_mode priv_stack_mo=
de)
> >> +                               enum bpf_priv_stack_mode priv_stack_mo=
de,
> >> +                               bool is_subprog, u8 *image, u8 *temp)
> >>   {
> >>          u32 orig_stack_depth =3D round_up(bpf_prog->aux->stack_depth,=
 8);
> >>          u8 *prog =3D *pprog;
> >>
> >> -       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG)
> >> -               emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_d=
epth);
> >> -       else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_st=
ack_depth)
> >> +       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG) {
> >> +               int offs;
> >> +               u8 *func;
> >> +
> >> +               if (!bpf_prog->aux->has_prog_call) {
> >> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig=
_stack_depth);
> >> +               } else {
> >> +                       EMIT1(0x57);            /* push rdi */
> >> +                       if (is_subprog) {
> >> +                               /* subprog may have up to 5 arguments =
*/
> >> +                               EMIT1(0x56);            /* push rsi */
> >> +                               EMIT1(0x52);            /* push rdx */
> >> +                               EMIT1(0x51);            /* push rcx */
> >> +                               EMIT2(0x41, 0x50);      /* push r8 */
> >> +                       }
> >> +                       emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_pr=
og >> 32,
> >> +                                      (u32) (long) bpf_prog);
> >> +                       func =3D (u8 *)__bpf_prog_enter_recur_limited;
> >> +                       offs =3D prog - temp;
> >> +                       offs +=3D x86_call_depth_emit_accounting(&prog=
, func, image + offs);
> >> +                       emit_call(&prog, func, image + offs);
> >> +                       if (is_subprog) {
> >> +                               EMIT2(0x41, 0x58);      /* pop r8 */
> >> +                               EMIT1(0x59);            /* pop rcx */
> >> +                               EMIT1(0x5a);            /* pop rdx */
> >> +                               EMIT1(0x5e);            /* pop rsi */
> >> +                       }
> >> +                       EMIT1(0x5f);            /* pop rdi */
> >> +
> >> +                       EMIT4(0x48, 0x83, 0xf8, 0x0);   /* cmp rax,0x0=
 */
> >> +                       EMIT2(X86_JNE, num_bytes_of_emit_return() + 1)=
;
> >> +
> >> +                       /* return if stack recursion has been reached =
*/
> >> +                       EMIT1(0xC9);    /* leave */
> >> +                       emit_return(&prog, image + (prog - temp));
> >> +
> >> +                       /* cnt -=3D 1 */
> >> +                       emit_alu_helper_1(&prog, BPF_ALU64 | BPF_SUB |=
 BPF_K,
> >> +                                         BPF_REG_0, 1);
> >> +
> >> +                       /* accum_stack_depth =3D cnt * subtree_stack_d=
epth */
> >> +                       emit_alu_helper_3(&prog, BPF_ALU64 | BPF_MUL |=
 BPF_K, BPF_REG_0,
> >> +                                         bpf_prog->aux->subtree_stack=
_depth);
> >> +
> >> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig=
_stack_depth);
> >> +
> >> +                       /* r9 +=3D accum_stack_depth */
> >> +                       emit_alu_helper_2(&prog, BPF_ALU64 | BPF_ADD |=
 BPF_X, X86_REG_R9,
> >> +                                         BPF_REG_0);
> > That's way too much asm for logic that can stay in C.
> >
> > bpf_trampoline_enter() should select __bpf_prog_enter_recur_limited()
> > for appropriate prog_type/attach_type/etc.
>
> The above jit code not just for the main prog, but also for callback fn's
> since callback fn could call bpf prog as well. So putting in bpf trampoli=
ne
> not enough.

callback can call the prog only if bpf_call_prog() kfunc exists
and that's one more reason to avoid going that direction.

