Return-Path: <bpf+bounces-35772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F9B93DAC4
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81436B23089
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5A214B07B;
	Fri, 26 Jul 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt0s8qa2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15121812;
	Fri, 26 Jul 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033952; cv=none; b=md5fVtUzC/uLSV8PEflI7vilKZJre5UH3xEzDG0L/7aFWYPhuLJmc426zdRMun0NkNeK19aUjpKLUOAkzOBQMs2O+hYBocch96sgYuNYaG25CnMGY/8yYvLYcUFqtHjdArthoDjOeyhiJ/YwgYoPGzckH3xyG16LW21VbszVcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033952; c=relaxed/simple;
	bh=AV7kCeNFPKhVa+YcBthtsbLbMH26qY7Dllekj9cOg/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMciAMfiFODTi8DY39gUi7QXJ4VjkvdurIH4unXdQM62oTQ7YJ5K9SMarW1dg9CWNIvtTV4aYDcbG9Woq4uqevmzYnqI1ShXTi0CZMQHjjF//Ik7N8n4Tf8zlvKxhA0bEZB3+pfu7AC6TbzionpUj+duqPokRhbeID5MWS5J7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt0s8qa2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0354459844so154785276.3;
        Fri, 26 Jul 2024 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722033950; x=1722638750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsr4aULdyg4pzgt/bnL4YWid1ZZ71VKjYx55ybGh0/8=;
        b=Lt0s8qa285hIBxZa11Vlb3/1ZaJ7F4y/MRbNDZfQajczcfZbU97xfeKDbHS1yO94Lo
         nOfhKtKjb1pDnd5gH+vS1VK5MEC6iPRrqGVm/mrwEdyfkyU+SuFZU6oYVYI8fcQVKjAk
         uvRsLFMQ5/DMGODotPyzbM06M7H0tIfPkfJ2aLQnzejShRtfApXLYrwSqq+FwXBDrwAT
         9RZWCsq+dLzehtXgFuaWD6MeTp8pZYHPbWBAnuiHLxJmMCctmdQNWgTFP8Q+cw+mPXt/
         ySVhrDHvpH+Gck4UF1TrAr4SuaQbKylsjzDbMfMIN9wFg+IaUF1/Co4RH7pnbgW3l95u
         D4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722033950; x=1722638750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsr4aULdyg4pzgt/bnL4YWid1ZZ71VKjYx55ybGh0/8=;
        b=F7jr+R/hqbkw7ucp2SOKBWudqKmPZXg8O7OK5e81Xtpe5ZvXFhZuYBzIuLDYBNHoQs
         z+/xkJKhB+CMKatWLiQHB4vhynbdY+xXZ7bmEsTK57h6xolvqht3Hbkn2jp2JOyYIYtR
         cZYAmkqLxMYyXmCzctqW1LWSxC4BmjWvH2PUr8IyDkdf3lAOarF5Cs104AJlZjdSBE1D
         8oiIJ+W3xpTgrszgIBxyQF0y44bwr+JNDMbjtB87CdOfXUi9s95Zw1spzCuMhzL/uQe4
         e+4QfKI0JKLCcemqyLIDm/dbPcH3scYz5oiNV8Cn1LYo0XiVdEwqESouRYUSn8h02KBK
         8nSg==
X-Forwarded-Encrypted: i=1; AJvYcCWaKoVxJiU7FAdNMR8hbqrjk7EOC6hDv9EWnxOhe9uu9GVuYoamnrUQZ+XlC2tL1kzt0bmVYZC5qL9OXF2UeJ+y4qkK
X-Gm-Message-State: AOJu0Yy7o4984a8TMFROTH1Qi5VQYokUm6vm/TL8FREow9/qBdYTputt
	MsaqXnsNeniQaKYywZ5kW0nFU1gsSFt4w/cQ3Sl31gBr37z0vDQr9vMer8f+FvpfjKX9hdbdIGj
	c1lLq6N5e2b2tLeyc4nRlzcuWVAg=
X-Google-Smtp-Source: AGHT+IHwijvFpXfct7F0RL6ZJC+gX5VTX57O37jQ4+nupWobSbyBlOozw+6Q0EWe9jbtB6A2F0z2v8AXi8YmsflaYsk=
X-Received: by 2002:a05:6902:2789:b0:e08:5554:b2cd with SMTP id
 3f1490d57ef6-e0b543f4b4bmr1393061276.4.1722033949885; Fri, 26 Jul 2024
 15:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-4-amery.hung@bytedance.com> <5b527381-ef28-470e-954d-45ce27e8d9d9@gmail.com>
 <CAMB2axOR-9_h2wCiibRD0bwoCntZi7h_g79E1naRLFOurWscTg@mail.gmail.com> <71fa8e2c-953d-447d-905a-e2c596839cea@gmail.com>
In-Reply-To: <71fa8e2c-953d-447d-905a-e2c596839cea@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 26 Jul 2024 15:45:39 -0700
Message-ID: <CAMB2axMTqkvqQ2Mw6K4RzBrGfhOWjZd3Py1WYybm=y2mYsGAjg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return
 referenced kptr
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 11:22=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 7/24/24 13:44, Amery Hung wrote:
> > On Tue, Jul 23, 2024 at 10:36=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 7/14/24 10:51, Amery Hung wrote:
> >>> Allow a struct_ops program to return a referenced kptr if the struct_=
ops
> >>> operator has pointer to struct as the return type. To make sure the
> >>> returned pointer continues to be valid in the kernel, several
> >>> constraints are required:
> >>>
> >>> 1) The type of the pointer must matches the return type
> >>> 2) The pointer originally comes from the kernel (not locally allocate=
d)
> >>> 3) The pointer is in its unmodified form
> >>>
> >>> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> >>> pointer to be returned when there is no skb to be dequeued, we will a=
llow
> >>> a scalar value with value equals to NULL to be returned.
> >>>
> >>> In the future when there is a struct_ops user that always expects a v=
alid
> >>> pointer to be returned from an operator, we may extend tagging to the
> >>> return value. We can tell the verifier to only allow NULL pointer ret=
urn
> >>> if the return value is tagged with MAY_BE_NULL.
> >>>
> >>> The check is split into two parts since check_reference_leak() happen=
s
> >>> before check_return_code(). We first allow a reference object to leak
> >>> through return if it is in the return register and the type matches t=
he
> >>> return type. Then, we check whether the pointer to-be-returned is val=
id in
> >>> check_return_code().
> >>>
> >>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >>> ---
> >>>    kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++=
----
> >>>    1 file changed, 46 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index f614ab283c37..e7f356098902 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env *en=
v, struct bpf_call_arg_meta *meta,
> >>>
> >>>    static int check_reference_leak(struct bpf_verifier_env *env, bool=
 exception_exit)
> >>>    {
> >>> +     enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> >>> +     u32 regno =3D exception_exit ? BPF_REG_1 : BPF_REG_0;
> >>> +     struct bpf_reg_state *reg =3D reg_state(env, regno);
> >>>        struct bpf_func_state *state =3D cur_func(env);
> >>> +     const struct bpf_prog *prog =3D env->prog;
> >>> +     const struct btf_type *ret_type =3D NULL;
> >>>        bool refs_lingering =3D false;
> >>> +     struct btf *btf;
> >>>        int i;
> >>>
> >>>        if (!exception_exit && state->frameno && !state->in_callback_f=
n)
> >>>                return 0;
> >>>
> >>> +     if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> >>> +         reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
> >>> +             btf =3D bpf_prog_get_target_btf(prog);
> >>> +             ret_type =3D btf_type_by_id(btf, prog->aux->attach_func=
_proto->type);
> >>> +             if (reg->btf_id !=3D ret_type->type) {
> >>> +                     verbose(env, "Return kptr type, struct %s, does=
n't match function prototype, struct %s\n",
> >>> +                             btf_type_name(reg->btf, reg->btf_id),
> >>> +                             btf_type_name(btf, ret_type->type));
> >>> +                     return -EINVAL;
> >>> +             }
> >>> +     }
> >>> +
> >>>        for (i =3D 0; i < state->acquired_refs; i++) {
> >>>                if (!exception_exit && state->in_callback_fn && state-=
>refs[i].callback_ref !=3D state->frameno)
> >>>                        continue;
> >>> +             if (ret_type && reg->ref_obj_id =3D=3D state->refs[i].i=
d)
> >>> +                     continue;
> >>
> >> Is it possible having two kptrs that both are in the returned type
> >> passing into a function?
> >>
> >
> > Just to make sure I understand the question correctly: Are you asking
> > what would happen here if a struct_ops operator has the following
> > signature?
> >
> > struct *foo xxx_ops__dummy_op(struct foo *foo_a__ref, struct foo *foo_b=
__ref)
>
> Right! What would happen to this case? Could one of them leak without
> being detected?
>

There will be a ref_obj_id for foo_a and another one for foo_b when we
enter the program (patch 1). Then, in the for loop in
check_reference_leak(), reg->ref_obj_id should just match one of
those, and all others will still be viewed as reference leak.

> >
> >>
> >>>                verbose(env, "Unreleased reference id=3D%d alloc_insn=
=3D%d\n",
> >>>                        state->refs[i].id, state->refs[i].insn_idx);
> >>>                refs_lingering =3D true;
> >>> @@ -15677,12 +15697,15 @@ static int check_return_code(struct bpf_ver=
ifier_env *env, int regno, const char
> >>>        const char *exit_ctx =3D "At program exit";
> >>>        struct tnum enforce_attach_type_range =3D tnum_unknown;
> >>>        const struct bpf_prog *prog =3D env->prog;
> >>> -     struct bpf_reg_state *reg;
> >>> +     struct bpf_reg_state *reg =3D reg_state(env, regno);
> >>>        struct bpf_retval_range range =3D retval_range(0, 1);
> >>>        enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> >>>        int err;
> >>>        struct bpf_func_state *frame =3D env->cur_state->frame[0];
> >>>        const bool is_subprog =3D frame->subprogno;
> >>> +     struct btf *btf =3D bpf_prog_get_target_btf(prog);
> >>> +     bool st_ops_ret_is_kptr =3D false;
> >>> +     const struct btf_type *t;
> >>>
> >>>        /* LSM and struct_ops func-ptr's return type could be "void" *=
/
> >>>        if (!is_subprog || frame->in_exception_callback_fn) {
> >>> @@ -15691,10 +15714,26 @@ static int check_return_code(struct bpf_ver=
ifier_env *env, int regno, const char
> >>>                        if (prog->expected_attach_type =3D=3D BPF_LSM_=
CGROUP)
> >>>                                /* See below, can be 0 or 0-1 dependin=
g on hook. */
> >>>                                break;
> >>> -                     fallthrough;
> >>> +                     if (!prog->aux->attach_func_proto->type)
> >>> +                             return 0;
> >>> +                     break;
> >>>                case BPF_PROG_TYPE_STRUCT_OPS:
> >>>                        if (!prog->aux->attach_func_proto->type)
> >>>                                return 0;
> >>> +
> >>> +                     t =3D btf_type_by_id(btf, prog->aux->attach_fun=
c_proto->type);
> >>> +                     if (btf_type_is_ptr(t)) {
> >>> +                             /* Allow struct_ops programs to return =
kptr or null if
> >>> +                              * the return type is a pointer type.
> >>> +                              * check_reference_leak has ensured the=
 returning kptr
> >>> +                              * matches the type of the function pro=
totype and is
> >>> +                              * the only leaking reference. Thus, we=
 can safely return
> >>> +                              * if the pointer is in its unmodified =
form
> >>> +                              */
> >>> +                             if (reg->type & PTR_TO_BTF_ID)
> >>> +                                     return __check_ptr_off_reg(env,=
 reg, regno, false);
> >>> +                             st_ops_ret_is_kptr =3D true;
> >>> +                     }
> >>>                        break;
> >>>                default:
> >>>                        break;
> >>> @@ -15716,8 +15755,6 @@ static int check_return_code(struct bpf_verif=
ier_env *env, int regno, const char
> >>>                return -EACCES;
> >>>        }
> >>>
> >>> -     reg =3D cur_regs(env) + regno;
> >>> -
> >>>        if (frame->in_async_callback_fn) {
> >>>                /* enforce return zero from async callbacks like timer=
 */
> >>>                exit_ctx =3D "At async callback return";
> >>> @@ -15804,6 +15841,11 @@ static int check_return_code(struct bpf_veri=
fier_env *env, int regno, const char
> >>>        case BPF_PROG_TYPE_NETFILTER:
> >>>                range =3D retval_range(NF_DROP, NF_ACCEPT);
> >>>                break;
> >>> +     case BPF_PROG_TYPE_STRUCT_OPS:
> >>> +             if (!st_ops_ret_is_kptr)
> >>> +                     return 0;
> >>> +             range =3D retval_range(0, 0);
> >>> +             break;
> >>>        case BPF_PROG_TYPE_EXT:
> >>>                /* freplace program can return anything as its return =
value
> >>>                 * depends on the to-be-replaced kernel func or bpf pr=
ogram.

