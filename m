Return-Path: <bpf+bounces-27450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD148AD377
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C49AB2370A
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F7153BF4;
	Mon, 22 Apr 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVYEu0Ow"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB06153BE5
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808120; cv=none; b=ZYoz3meXdaHKvglfs6wiQsNGzOH+ktI1pfd6f1yGn1RwKDo+o93rJjjanf1nOdGXqPEtLEt5+pV4aie4rPR/B+9AtCaI1Qc1nZG15yJtBdOZURbxUhAxKyBG+sm1Q+guirpguJ0b8vK1xmmMs/yw9dtM4qH7ifbIaTJ+c8x/l18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808120; c=relaxed/simple;
	bh=uIqyT75OMn7qLCvySJEubGjCadUX81qojC3Ob1UR0LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXa1PAWhYQ8RZa32srTNmih/OFH//GZka9ULrJiZIaS9wsjmTLMvXq8lJNKzGbh64/n+pyZuYd1MmEoP0V3Vb9TKpGgAH9l4yl2EuvWzcVZCARGjo7ufTAkpLkadGXW42DiXRqj+wXVNXwz93W6+bbf7T6wd1TYjTEPYf3sen8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVYEu0Ow; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34a7e47d164so2635234f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713808117; x=1714412917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9bAYq2+XKehxlmRw8KrQcjSLC598f6et9o6jv++Lq0=;
        b=ZVYEu0OwJB0BuNXLURTgHiMwqehTrz5QPyl5gYir89A5qdecqe6vDJv4E9FwTXIIOY
         cnLMe13VjytS2LtFcbVQercf0Skgza2mx2hxG9qpKKx7cbjnVI1m/B2tdzVW+CyfuHhh
         INw0FrDv6/VFwQN012M3KxBJW626T5pxuDwP8KWw/OAsf1uzJX18R6tlOOUgP5FRZS1L
         B2QshQVpW30LdiJO94vy+6uuN+Us9oAmnBdREziJwkCab4Wa7DCzTA3PIMIfeoIpEKCm
         jj4JUj3KH0kDDhbvkDKw/w6qQX4tMM7o7WSvCZQbnDObuvjVPXAayaIn6s7+QJGjAvQu
         dA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808117; x=1714412917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9bAYq2+XKehxlmRw8KrQcjSLC598f6et9o6jv++Lq0=;
        b=BI+erTN+LQ+6P+B1tLM2N/JeNlonrpqZa9qKrxv0sGDoxyDX8oABuWkOKb8TnKJPxX
         B0gaIE4PF16A/9bnTsYtlc8ao+V1OEf6ntdSJigQyHqcWNs7I+Fz0U1NDajfgLUu75X4
         6ECzdoPPVzk5XhwMfDnHG34kVhPs7Utkd7OI8ih6DLMfMPljCzKjqs4ARMQsOMmAOZBV
         4YEMZhv+7I4P8/+izLCFw4vMI3ZADNA3zIg2upLR2VLqS/vZ1WMcTE3X+vkRG8+xUaWT
         P/XwAuvXRKh7V9N7ZSl9BUolJG6j9MyJTX10dWcnRfNDagblKytHVj8CjGQnsUR9g46S
         hVTg==
X-Forwarded-Encrypted: i=1; AJvYcCV+/rinTZfJWAwD4er/9Y/+SbQxyagXdRas3t0oUF80VfZ0NeL+JRH9HsQhdcJ2n73iyoXLCSFGtILx8GFhtiHwWI3B
X-Gm-Message-State: AOJu0YzIcxBQFsiLYi3255iVmOw38sqh5SJQV/PtahCz01SyY3h85F9W
	ONrgUosjtsYz+VTf2hQVX0uPjw4eEM+cfOh4bvB2BRR63thbH/5SusVIY/1HSw+eElv38WksEqv
	O4F43op4sevuKOXUwCOpDlK/7ZYY=
X-Google-Smtp-Source: AGHT+IHp4H1LpN0qJlENwt/qtaOah/4gSc9LGnhrBEp4mlXL/JKB/dK/GUGNBiufPJ6bMlOXJgxY0jivq47aLrQmEvY=
X-Received: by 2002:a5d:604d:0:b0:346:b452:1740 with SMTP id
 j13-20020a5d604d000000b00346b4521740mr8441168wrt.3.1713808116572; Mon, 22 Apr
 2024 10:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-4-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-4-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Apr 2024 10:48:25 -0700
Message-ID: <CAADnVQLAgVgf__rxd+C_RO1+ELEKOcLP5eN3V9QGWkpBvUT59g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add support for kprobe multi session cookie
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for cookie within the session of kprobe multi
> entry and return program.
>
> The session cookie is u64 value and can be retrieved be new
> kfunc bpf_session_cookie, which returns pointer to the cookie
> value. The bpf program can use the pointer to store (on entry)
> and load (on return) the value.
>
> The cookie value is implemented via fprobe feature that allows
> to share values between entry and return ftrace fprobe callbacks.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c    |  7 +++++++
>  kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 68cfd6fc6ad4..baaca451aebc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10987,6 +10987,7 @@ enum special_kfunc_type {
>         KF_bpf_percpu_obj_drop_impl,
>         KF_bpf_throw,
>         KF_bpf_iter_css_task_new,
> +       KF_bpf_session_cookie,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -11013,6 +11014,7 @@ BTF_ID(func, bpf_throw)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(func, bpf_iter_css_task_new)
>  #endif
> +BTF_ID(func, bpf_session_cookie)
>  BTF_SET_END(special_kfunc_set)
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -11043,6 +11045,7 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +BTF_ID(func, bpf_session_cookie)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -12409,6 +12412,10 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                                  * because packet slices are not refcount=
ed (see
>                                  * dynptr_type_refcounted)
>                                  */
> +                       } else if (meta.func_id =3D=3D special_kfunc_list=
[KF_bpf_session_cookie]) {
> +                               mark_reg_known_zero(env, regs, BPF_REG_0)=
;
> +                               regs[BPF_REG_0].type =3D PTR_TO_MEM;
> +                               regs[BPF_REG_0].mem_size =3D sizeof(u64);

Are you sure you need this?

} else if (!__btf_type_is_struct(ptr_type)) {

block should have handled it automatically.

> +__bpf_kfunc __u64 *bpf_session_cookie(void)
> +{

...

