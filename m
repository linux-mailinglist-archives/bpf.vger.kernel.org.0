Return-Path: <bpf+bounces-41640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08479993F7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6061B21712
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB31E231B;
	Thu, 10 Oct 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mypdh8jA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD111CF7B8
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593624; cv=none; b=ULAoGpWGE0Pcd4XXOKpfme0rw/d1XJZaPF1tysY9sXRCol4AUL/nRTuG//HemeTWb7EiCdUoFrrP2exM9RSNzQi6KpJ8yRdNxiXDXxT8AouD8V7IiBxquQOSAsI9313Ej09F6g916ySf+0twq0OuMM/Kd2Zjg/3RaGpxKzSTMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593624; c=relaxed/simple;
	bh=JsSRODlK7S1ND9ukd/YfGfz9fsavUFpfoPruEzzWuXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIJXWwyaNSRFcRFcZf99sK9rX6IEL/ttxUJdBkSY3LX1RN7Q2k3fnAopi6ppXRXeThz21MAPkBNsms8D8fg5OT6U3yiRwJQEBoRiXklBpbnNgTuDBslyTR8lghAHBZZehA7Z/5BngC9PQtFg04FQF1hsvKPsk/crOxBxadP9Y0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mypdh8jA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43117917eb9so9779615e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728593621; x=1729198421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzmrApdpdkoe9FrT9uikSmfqtZzZllaO5/Kq0hq9nYU=;
        b=mypdh8jAuY54QsLlJ9dvJdMUHoj4QcuXUBlV+XsMhOPealDUrijdK0kJt1/Ic4c2MS
         8Gzt9yiYwyugT1f20w7pMYls5BRARJphYsZI6LmYkeLS69X7I3Fih6aORKj9ZISvN5gm
         a+Ae2G7Ckgw6Tyx6n340ZgZ9h9lH1JVdGIPo5pjKQvWP8AHekBtkEi5dg1pzkRuUcq0s
         fo28iJYE7CRdMV9tPkmF4vNX74vmtgSIVlJk6TqXKhpwVs6YnDivRC71RVH1Vl3ysxwR
         JahJEawXC5o3MdZ0F9o31Udm7EWjaR18joLDDh4AGIkQs62aLIXpxaCGRaRmiux5Uons
         e7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728593621; x=1729198421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzmrApdpdkoe9FrT9uikSmfqtZzZllaO5/Kq0hq9nYU=;
        b=UTa+DcDpvylMyBPx7SxSDgUYScBMEjQ1o5akwybbf8tUuSesgf3BdgAz67mci/Qvl2
         wQ2ryriePIoNBld9fxiIrhXy03sZSCfH0HaIX+P93OlRXaMrGMr6LfoqcPEUy2JfnvMQ
         +bgVfwMBVZFeXBudqHb82qQ8BIhkI81BdZBglFBZU7urqXL6rOHmHv2qPEPl+/LoRi89
         DoQDGidV1SkZo83jPciJldoIiGwhQZfR1Dzz2igGD6CLChZstX/wk+6jp2nm2V3GPLBA
         uR5PPn82Yl3mvU7b5UjT4+tnHqzKoDv9dpugDcYTVJYa9IEYog5SWF/QXN7fHMEvZh4F
         fOmQ==
X-Gm-Message-State: AOJu0Yz3t3Urs2XhC3lX6odsICy5p485yM6D7RU2H9IuKaWeGDHk72PJ
	iqBJ/4bCVpR1ZHxx1+zhTx1wNIl+oq4BTLxoxFHgBa0EgSQZcS9E22OwsZp31dl7K2/OlZ9DJlY
	XJZqu3KaiIfroW3IrC0ZWE/LrPoBU3Ep4
X-Google-Smtp-Source: AGHT+IHuMp7LSLCSwDhF5o5FEZ27rgiMYCCUhezw5fPHfHYztvp5z4+LdlzkC3GYrOvL+b4IPHKCi7/1c1k1uIxGBzE=
X-Received: by 2002:a05:600c:45cd:b0:42c:b1a4:c3ef with SMTP id
 5b1f17b1804b1-4311df4205cmr1678215e9.33.1728593620764; Thu, 10 Oct 2024
 13:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev> <20241010175638.1899406-1-yonghong.song@linux.dev>
In-Reply-To: <20241010175638.1899406-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 13:53:28 -0700
Message-ID: <CAADnVQJmEkQvAhPs3q1oYGpdO48n2JE3MnMxXgYCMoUup=UOBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 09/10] bpf, x86: Jit support for nested bpf_prog_call
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:59=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>  static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
> -                               enum bpf_priv_stack_mode priv_stack_mode)
> +                               enum bpf_priv_stack_mode priv_stack_mode,
> +                               bool is_subprog, u8 *image, u8 *temp)
>  {
>         u32 orig_stack_depth =3D round_up(bpf_prog->aux->stack_depth, 8);
>         u8 *prog =3D *pprog;
>
> -       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG)
> -               emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_dept=
h);
> -       else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_stack=
_depth)
> +       if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG) {
> +               int offs;
> +               u8 *func;
> +
> +               if (!bpf_prog->aux->has_prog_call) {
> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig_st=
ack_depth);
> +               } else {
> +                       EMIT1(0x57);            /* push rdi */
> +                       if (is_subprog) {
> +                               /* subprog may have up to 5 arguments */
> +                               EMIT1(0x56);            /* push rsi */
> +                               EMIT1(0x52);            /* push rdx */
> +                               EMIT1(0x51);            /* push rcx */
> +                               EMIT2(0x41, 0x50);      /* push r8 */
> +                       }
> +                       emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_prog =
>> 32,
> +                                      (u32) (long) bpf_prog);
> +                       func =3D (u8 *)__bpf_prog_enter_recur_limited;
> +                       offs =3D prog - temp;
> +                       offs +=3D x86_call_depth_emit_accounting(&prog, f=
unc, image + offs);
> +                       emit_call(&prog, func, image + offs);
> +                       if (is_subprog) {
> +                               EMIT2(0x41, 0x58);      /* pop r8 */
> +                               EMIT1(0x59);            /* pop rcx */
> +                               EMIT1(0x5a);            /* pop rdx */
> +                               EMIT1(0x5e);            /* pop rsi */
> +                       }
> +                       EMIT1(0x5f);            /* pop rdi */
> +
> +                       EMIT4(0x48, 0x83, 0xf8, 0x0);   /* cmp rax,0x0 */
> +                       EMIT2(X86_JNE, num_bytes_of_emit_return() + 1);
> +
> +                       /* return if stack recursion has been reached */
> +                       EMIT1(0xC9);    /* leave */
> +                       emit_return(&prog, image + (prog - temp));
> +
> +                       /* cnt -=3D 1 */
> +                       emit_alu_helper_1(&prog, BPF_ALU64 | BPF_SUB | BP=
F_K,
> +                                         BPF_REG_0, 1);
> +
> +                       /* accum_stack_depth =3D cnt * subtree_stack_dept=
h */
> +                       emit_alu_helper_3(&prog, BPF_ALU64 | BPF_MUL | BP=
F_K, BPF_REG_0,
> +                                         bpf_prog->aux->subtree_stack_de=
pth);
> +
> +                       emit_root_priv_frame_ptr(&prog, bpf_prog, orig_st=
ack_depth);
> +
> +                       /* r9 +=3D accum_stack_depth */
> +                       emit_alu_helper_2(&prog, BPF_ALU64 | BPF_ADD | BP=
F_X, X86_REG_R9,
> +                                         BPF_REG_0);

That's way too much asm for logic that can stay in C.

bpf_trampoline_enter() should select __bpf_prog_enter_recur_limited()
for appropriate prog_type/attach_type/etc.

JITs don't need to change.

