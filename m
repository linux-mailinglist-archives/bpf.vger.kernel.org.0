Return-Path: <bpf+bounces-78815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8CCD1C203
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F82302AFB8
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA292FDC55;
	Wed, 14 Jan 2026 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MyGV5KzT"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B349215077
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357559; cv=none; b=dsF9a1FBp0GGZammqzQmaFr4JU0qsRMo1JtBsOOZ7CK2vGrdwEyEol6KhFddQ0H1cOsQa4nJskeap3e/PymtkV+678XVRv5SndNGyikj1SfxCGUFNf69bYgczvJRCL2OIEQoanOcBaRxUydTxNvgAqCekrufVjZlfQZdMIb7Sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357559; c=relaxed/simple;
	bh=7QlruefSFU5VivGuOFlSA8UdtDYSuAMsvC7hc6oov/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2APSLsNDIOHsE+JYKEoCangE7WLQwK0Ynd3j7fqLP+KJiUmV5nc6qUruCIXf5CklXIJqywscgI8LwJm5vOosUYGkBm22nWr8i+3CONwpuOd/wRfdfAGFOEzgfz3nJk7Y5UG9jhIugJP2NNQrbkLlcu8PT6izdaVPyGQ5HekKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MyGV5KzT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768357544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldPZx7QkOGGsRgh2JZ/aOzAveRu52NfE4WFpc0QdLIw=;
	b=MyGV5KzTcjT8TyG/sLGpxECcOuUnkb9247vIpHds8u4oE3EV3Vn6Tf+Km0zU7DOBBgTw7v
	FMCCgWlRVXePVtqoXYOjK6Jr866zIqf7SzVhMLsBqf6js8WFw6CBeYmU0sx4XHrknx8ha7
	YoyQ55z6p27SsoJic2gTWVSywmkdf98=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v9 04/11] bpf: support fsession for bpf_session_is_return
Date: Wed, 14 Jan 2026 10:25:31 +0800
Message-ID: <9562692.CDJkKcVGEf@7940hx>
In-Reply-To:
 <CAEf4BzZBhGfWN3t0_u-1GrOxtjoJUhMk+NqAaZFnFpgB4QskHQ@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-5-dongml2@chinatelecom.cn>
 <CAEf4BzZBhGfWN3t0_u-1GrOxtjoJUhMk+NqAaZFnFpgB4QskHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
> > ctx[-1] to store the "is_return" flag.
> >
> > The logic of bpf_session_is_return() for fsession is implemented in the
> > verifier by inline following code:
> >
> >   bool bpf_session_is_return(void *ctx)
> >   {
> >       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
>=20
> this look unnecessarily scary :) !! part is unnecessary because
> non-zero integer will be converted to proper true(1)/false(0) by
> compiler. But I'd just rewrite it in arguably slightly simpler form
> that lays itself to assembly more directly:
>=20
> return ((u64 *)ctx[-1] >> BPF_TRAMP_M_IS_RETURN) & 1;

Yeah, the C code in the comment is wrong and not corresponding
to the inline code. I'll update it in the next version.

>=20
> >   }
> >
[......]
> >  };
> >
> > +#define BPF_TRAMP_M_NR_ARGS    0
> > +#define BPF_TRAMP_M_IS_RETURN  8
>=20
> nit: What does "M" stand for? Macro? Mask? Menglong? ;) Some new
> convention, why?

Ah, I think it stand for Mask. I'm not good at naming, and
this word come to my mind when I want a prefix for the
case ;)

>=20
> > +
> >  struct bpf_tramp_links {
> >         struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
> >         int nr_links;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bfff3f84fd91..1b0292a03186 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12374,6 +12374,7 @@ enum special_kfunc_type {
> >         KF_bpf_arena_alloc_pages,
> >         KF_bpf_arena_free_pages,
> >         KF_bpf_arena_reserve_pages,
> > +       KF_bpf_session_is_return,
> >  };
> >
> >  BTF_ID_LIST(special_kfunc_list)
> > @@ -12451,6 +12452,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
> >  BTF_ID(func, bpf_arena_alloc_pages)
> >  BTF_ID(func, bpf_arena_free_pages)
> >  BTF_ID(func, bpf_arena_reserve_pages)
> > +BTF_ID(func, bpf_session_is_return)
> >
> >  static bool is_task_work_add_kfunc(u32 func_id)
> >  {
> > @@ -12505,7 +12507,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
> >         struct bpf_reg_state *reg =3D &regs[regno];
> >         bool arg_mem_size =3D false;
> >
> > -       if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx])
> > +       if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx] ||
> > +           meta->func_id =3D=3D special_kfunc_list[KF_bpf_session_is_r=
eturn])
> >                 return KF_ARG_PTR_TO_CTX;
> >
> >         if (argno + 1 < nargs &&
> > @@ -22558,6 +22561,16 @@ static int fixup_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonl=
y_cast]) {
> >                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> >                 *cnt =3D 1;
> > +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_sessi=
on_is_return] &&
> > +                  env->prog->expected_attach_type =3D=3D BPF_TRACE_FSE=
SSION) {
> > +               /* implement and inline the bpf_session_is_return() for
>=20
> nit: comment style

ACK

>=20
> > +                * fsession, and the logic is:
> > +                *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_=
RETURN))
> > +                */
> > +               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_=
1, -8);
> > +               insn_buf[1] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_T=
RAMP_M_IS_RETURN);
> > +               insn_buf[2] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
>=20
> lol, your assembly is simpler than that C expression above, let's keep
> C close to what you actually are doing in assembler

ACK

>=20
> > +               *cnt =3D 3;
> >         }
> >
> >         if (env->insn_aux_data[insn_idx].arg_prog) {
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 297dcafb2c55..1fe508d451b7 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3334,34 +3334,40 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
> >
> >  __bpf_kfunc_end_defs();
> >
> > -BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> > +BTF_KFUNCS_START(session_kfunc_set_ids)
> >  BTF_ID_FLAGS(func, bpf_session_is_return)
> >  BTF_ID_FLAGS(func, bpf_session_cookie)
> > -BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> > +BTF_KFUNCS_END(session_kfunc_set_ids)
> >
> > -static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> > +static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> >  {
> > -       if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id=
))
> > +       if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
> >                 return 0;
> >
> > -       if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
> > +       if (!is_kprobe_session(prog) && !is_uprobe_session(prog) &&
> > +           prog->expected_attach_type !=3D BPF_TRACE_FSESSION)
>=20
> check both expected_attach_type *and* prog_type, please (and I think
> it would be good to check prog type for kprobe_session and
> uprobe_session as well, because now it's not guaranteed that program
> will be of BPF_PROG_TYPE_KPROBE

OK, it make sense. I'll check the prog_type for all of them.

Thanks!
Menglong Dong

>=20
>=20
> >                 return -EACCES;
> >
> >         return 0;
> >  }
> >
> > -static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set =3D {
> > +static const struct btf_kfunc_id_set bpf_session_kfunc_set =3D {
> >         .owner =3D THIS_MODULE,
> > -       .set =3D &kprobe_multi_kfunc_set_ids,
> > -       .filter =3D bpf_kprobe_multi_filter,
> > +       .set =3D &session_kfunc_set_ids,
> > +       .filter =3D bpf_session_filter,
> >  };
> >
> > -static int __init bpf_kprobe_multi_kfuncs_init(void)
> > +static int __init bpf_trace_kfuncs_init(void)
> >  {
> > -       return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kpr=
obe_multi_kfunc_set);
> > +       int err =3D 0;
> > +
> > +       err =3D err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, =
&bpf_session_kfunc_set);
> > +       err =3D err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,=
 &bpf_session_kfunc_set);
> > +
> > +       return err;
> >  }
> >
> > -late_initcall(bpf_kprobe_multi_kfuncs_init);
> > +late_initcall(bpf_trace_kfuncs_init);
> >
> >  typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct =
task_struct *tsk);
> >
> > --
> > 2.52.0
> >
>=20





