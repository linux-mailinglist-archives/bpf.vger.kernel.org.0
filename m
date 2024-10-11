Return-Path: <bpf+bounces-41750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E20199A806
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337AD280D17
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2419750B;
	Fri, 11 Oct 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnFXsaHN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6C195F22
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661216; cv=none; b=HJT+Jqu2EHrO60R2U01tkFE1k7upsakekduSQKLNcMb/LQE72yZwEOzsjlEW3ShGtSkyjl/76VdWbvd6t/JFKX1PcRJHTxw8c6mDihQv5iwKs10ba3tezURnyJ0IQSdBwJZ7ZxHTKNbTSDEuXzENY6iC7mLPykT8XYRBFao1hTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661216; c=relaxed/simple;
	bh=J7TyzTg1taAdFoaEDMZnvo+2HFHOqzKr1hiCVNUHT3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbbHbmpjMaa21HhPnT4jXBXB4bTUfRV3lkgsmvle1ZDezAuIZ9YEiS5C43hdhZj1P/QEjoxuWVAY6zrmhO6IAvEtA9WpGEKrxiqRYprAqrfoBFkIjA4X74+3iELOTcP75iiToIywdp1SUj4E7lUE0RG1Zv1tQXvu5+Q5XSxcgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnFXsaHN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so23704255e9.0
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728661213; x=1729266013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZu/D7YdUcDJ3f8rWhlleRYQo2vEDqgCipAbTot8xMU=;
        b=ZnFXsaHNV9YgYNnIPvqEymqtMhJq+JnccE8lJD7Lqux8Q3GyFaUpDCvtNm7xqANykw
         L+75yQfYyiulfV1gfBcb38GPPoTuPfYV3Xqj51bRC61WxfCz3PzfEB3/dUHFwxpZR/Cs
         QXFCEtvfq2Om4CE+mkaWG/3OZn74knsqMKgu1zM4d7b0/2vskq7y9k/DoPLjDL1oaMi/
         tAc1/OtFb4CXUY7nXol4THwlxh1/uwQ2WqnLHehXk2Z7awdUVxD9AR6y4j6eljeeb6MS
         fKo5QqHw04NjJJb4dauDkhXQ0QToPELSyQk0IVt+12Up/LpZ0lKjuTrihjyfC8VynCM8
         UBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661213; x=1729266013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZu/D7YdUcDJ3f8rWhlleRYQo2vEDqgCipAbTot8xMU=;
        b=qJ6rHD/6u0+O46Ljocd3jYBfAV5J5FIyiX16oYJveIeNOFfPYqH2TeJBIcAWCqd8GR
         9h7Vk0vcUyP/RGIq6VJ/C/aB4gHj4j8kr9EM6kI6ImGJTvRo32quRVnlWBMKAJPYr5VF
         O7I4/IytPc9fUMDbk3lDu5mkCMNEfI1dUngzEu0YksHlvlkPNDAzvnSVH6QdOSevBGdy
         35R9Yg9ARzJ4XDIR9uMEd5WXx282QGkdCbX4NTRJUhT1gBe5Aw9s7OG5AszdduoXlA3O
         tnZflUJVEHpeIBf21yz6JgMcdMuV4uwBIAO2SgL6QCnxHKnra5WExg/uwlYklj8D9G9Y
         AfRQ==
X-Gm-Message-State: AOJu0Yy/G0Puom+QGa+9RmvwcnYbdogbgafdl1E3k7c94eWMi1zAKPIa
	RVVpEBMyQDMJrdVl5KphizBlDMiDakHVxLP3bRiecdNywqLIEtZ5x2jzzI3J2dm6THlpWFLg7Zb
	1RbJHorWhv4BS9gbg4r0GZvkZFrwrrw==
X-Google-Smtp-Source: AGHT+IF3iknTBjviVHJ98LObNwPJcoKbPUVSh54r4BLaHkFRw4cR0BcyrEHzLa6LvBjYojxUH8+aj/CLcKPZEfosfQ0=
X-Received: by 2002:adf:f6d1:0:b0:37d:4586:948f with SMTP id
 ffacd0b85a97d-37d600d2fefmr55322f8f.42.1728661212951; Fri, 11 Oct 2024
 08:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175638.1899406-1-yonghong.song@linux.dev> <CAADnVQJmEkQvAhPs3q1oYGpdO48n2JE3MnMxXgYCMoUup=UOBg@mail.gmail.com>
 <64da4fb8-7e13-41fc-891e-c0f79bf778d1@linux.dev> <CAADnVQKyDT+W8-Vgr0GcCmffeKqKjkNrkSa7=GaggcK83vbvYg@mail.gmail.com>
 <1ce7840f-aede-457b-aefd-463499fb94b2@linux.dev>
In-Reply-To: <1ce7840f-aede-457b-aefd-463499fb94b2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 08:40:02 -0700
Message-ID: <CAADnVQK5ch77xD2STLAfZjXX4V4Dh5xL2Xfopb1e++J8RqysKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 09/10] bpf, x86: Jit support for nested bpf_prog_call
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:39=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/10/24 9:29 PM, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 9:21=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 10/10/24 1:53 PM, Alexei Starovoitov wrote:
> >>> On Thu, Oct 10, 2024 at 10:59=E2=80=AFAM Yonghong Song <yonghong.song=
@linux.dev> wrote:
> >>>>    static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_=
prog,
> >>>> -                               enum bpf_priv_stack_mode priv_stack_=
mode)
> >>>> +                               enum bpf_priv_stack_mode priv_stack_=
mode,
> >>>> +                               bool is_subprog, u8 *image, u8 *temp=
)
> >>>>    {
> >>>>           u32 orig_stack_depth =3D round_up(bpf_prog->aux->stack_dep=
th, 8);
> >>>>           u8 *prog =3D *pprog;
> >>>>
> >>>> -       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG)
> >>>> -               emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack=
_depth);
> >>>> -       else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_=
stack_depth)
> >>>> +       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG) {
> >>>> +               int offs;
> >>>> +               u8 *func;
> >>>> +
> >>>> +               if (!bpf_prog->aux->has_prog_call) {
> >>>> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, or=
ig_stack_depth);
> >>>> +               } else {
> >>>> +                       EMIT1(0x57);            /* push rdi */
> >>>> +                       if (is_subprog) {
> >>>> +                               /* subprog may have up to 5 argument=
s */
> >>>> +                               EMIT1(0x56);            /* push rsi =
*/
> >>>> +                               EMIT1(0x52);            /* push rdx =
*/
> >>>> +                               EMIT1(0x51);            /* push rcx =
*/
> >>>> +                               EMIT2(0x41, 0x50);      /* push r8 *=
/
> >>>> +                       }
> >>>> +                       emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_=
prog >> 32,
> >>>> +                                      (u32) (long) bpf_prog);
> >>>> +                       func =3D (u8 *)__bpf_prog_enter_recur_limite=
d;
> >>>> +                       offs =3D prog - temp;
> >>>> +                       offs +=3D x86_call_depth_emit_accounting(&pr=
og, func, image + offs);
> >>>> +                       emit_call(&prog, func, image + offs);
> >>>> +                       if (is_subprog) {
> >>>> +                               EMIT2(0x41, 0x58);      /* pop r8 */
> >>>> +                               EMIT1(0x59);            /* pop rcx *=
/
> >>>> +                               EMIT1(0x5a);            /* pop rdx *=
/
> >>>> +                               EMIT1(0x5e);            /* pop rsi *=
/
> >>>> +                       }
> >>>> +                       EMIT1(0x5f);            /* pop rdi */
> >>>> +
> >>>> +                       EMIT4(0x48, 0x83, 0xf8, 0x0);   /* cmp rax,0=
x0 */
> >>>> +                       EMIT2(X86_JNE, num_bytes_of_emit_return() + =
1);
> >>>> +
> >>>> +                       /* return if stack recursion has been reache=
d */
> >>>> +                       EMIT1(0xC9);    /* leave */
> >>>> +                       emit_return(&prog, image + (prog - temp));
> >>>> +
> >>>> +                       /* cnt -=3D 1 */
> >>>> +                       emit_alu_helper_1(&prog, BPF_ALU64 | BPF_SUB=
 | BPF_K,
> >>>> +                                         BPF_REG_0, 1);
> >>>> +
> >>>> +                       /* accum_stack_depth =3D cnt * subtree_stack=
_depth */
> >>>> +                       emit_alu_helper_3(&prog, BPF_ALU64 | BPF_MUL=
 | BPF_K, BPF_REG_0,
> >>>> +                                         bpf_prog->aux->subtree_sta=
ck_depth);
> >>>> +
> >>>> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, or=
ig_stack_depth);
> >>>> +
> >>>> +                       /* r9 +=3D accum_stack_depth */
> >>>> +                       emit_alu_helper_2(&prog, BPF_ALU64 | BPF_ADD=
 | BPF_X, X86_REG_R9,
> >>>> +                                         BPF_REG_0);
> >>> That's way too much asm for logic that can stay in C.
> >>>
> >>> bpf_trampoline_enter() should select __bpf_prog_enter_recur_limited()
> >>> for appropriate prog_type/attach_type/etc.
> >> The above jit code not just for the main prog, but also for callback f=
n's
> >> since callback fn could call bpf prog as well. So putting in bpf tramp=
oline
> >> not enough.
> > callback can call the prog only if bpf_call_prog() kfunc exists
> > and that's one more reason to avoid going that direction.
>
> Okay, I will add verifier check to prevent bpf_call_prog() in callback fu=
nctions.

We're talking past each other.
It's a nack to introduce bpf_call_prog kfunc.

