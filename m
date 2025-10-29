Return-Path: <bpf+bounces-72934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77EC1DD24
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FF4E3738
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E231DD8A;
	Wed, 29 Oct 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRJnLRbB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B2324B0B
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782081; cv=none; b=MkBpuxggOaBrU8bPyFlhcDUFeIBiTTVNxkGtAxQ40seOFyUt2OmxamLwRy9bD2X85Nq/a9c6t8TRIP2FPjWNzf29p1ngdxE6aUvxD4onigbrVNeH1lgAuATdrz8G6HywN0xDcC327Yxd1VgLAlniw0hVI8+Na0b0TtxiG0sB5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782081; c=relaxed/simple;
	bh=zp+FmUeTDv91zwjFtIzjR1ralGK/Pq/QuyLkiR15cO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIrmGyIpSzXqoN/JE1Fo3Ttf90WSIG88lGW8N1HjTbqaSTa0d3Ytp5jBH8hwCrXgkI/23iCFdRYt5CIVrhNuzv9bUYk/IxdL3uymin+k/o+akamMnG//eIidPpYIzUd2zbqqa7Dq6UR5cd2Kj0zTajl1dRIDBbxy4KpVXgL6XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRJnLRbB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so315239a12.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782077; x=1762386877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=99FjNe/EmZZtNqagxUN5pM1ZgMAs2Zx4+DmUPT9B8uI=;
        b=RRJnLRbBR3IwgVu+MeB6sfNnV+C8S9XwoFKtvfhUTnu6NwWjIiG5H0DCZtUrxhljfL
         pP6deJKoOoVMv+FA23WIJOBNNd4DKPPlLwwo4dVIjIZPQrSrpZ72TqxlltbhAGw/6FME
         TZyNQ6hOQBoKkNUqMrIppG6EDPrlbRJavW//Db1QHL72b95TjRQ1twP5Bco8FlDe3jgr
         KOmnBnboJZiSF8L0x8qHx+QJmzflUyfBBj7I/YM6R3n1P9UA6Mzy4KzzXShY8NpsFPYr
         sYe/mxFTjGzct+rSOFN4QTPaXdOCnvYewur1o2qyEdOTC0xVFByFzYvj9aLf3qRyzpDl
         Jasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782077; x=1762386877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99FjNe/EmZZtNqagxUN5pM1ZgMAs2Zx4+DmUPT9B8uI=;
        b=KQ9+6Plf0jaNOmSTCjcGjwrmH8il6zCq5h1Nr3bt9hP845PZRaVmS5m4P6yvYfSJW5
         cFkfFeqvRTeUiT8jH3Q/9pLTP2lyOPpWIM3RT0xt1/ufo1LcDIjDHZp/NAYFa+gbJXmk
         ekhcbGWtGVuCqkdamFNUaJbfBOwIJXtDRJf8mg6l2whrHH0Ze55TnrjQscnWWsksbipN
         ncO6RnOFGp5SU9Svd7kLMB2V+ptuvOC96ACBEpb/MBk/mgKgEfJknoBE9jeWOp9s2MBV
         3VJt1X91ijBLSj3KXe53c5sRtTEmT+z/RrlyuzDE5YsJ1OXzLDcbSwtY2vseGuOeE5lL
         avnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcq06fGKkHM/9h5hz3tygDAwCv7/QaOuoOCw2bclfsFy0fv/ylXurnZoPoGpF0NPomCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmMHLx0UwdYXjGOeOUP3LGkIQYQiaMMTgltbO1i0WjmHUhApM
	p7KTfmbdmMWS1SX6EjyQ0O1Q2XDyD63MWswxwhdgkLRXzAQdNAQ8RgLc
X-Gm-Gg: ASbGnctXmvmjAt+kdlRsZc2tLezje+13cZwBTqFPqRBy7GZHOPAPZyLd074Yc+la26x
	lSNyUJr1IDUl5hPj5JHc9izbn0sOVPloUOMEHJXoElclG2N4jRzw3Ozv6GgrTZbjYGtzVQPpXec
	9zL7Idmh0gfZLsRlwqVCS5QkFkkTbYAXiFAFjwZh2UkEGs6OK0qf4rI5xJSPYSDttyuWc1QdFx1
	u2Qpd68EUD0luEQHP9wIvuGXGEAGXoqGAKt1YcgEwZECQxNNRfhNHJXiMJHzEj5wSU/GFgzK0ti
	RaA7rIk8gZ3Iv3NOimTS7R1aLbd3yJr8Y6u5iPDkiH3bk13rpjVuL1L9cLIicjEsymQVrIsKcBE
	FzyBrlUj4nXwPBNZHIZUsgEi8OMXA5+29kIJzmXq8HGfSwrSO2avMJSzR9sm1pvUnpQvgt49gbn
	5fufO3Ri97jV9QrhueXfiDb6ng6w==
X-Google-Smtp-Source: AGHT+IHIfNQQg5mz9WcRP1E9IhKrU9xJCabagmUgHweTA73OKHlviUwzIr4FfeyCppCmJX2RKiLB/A==
X-Received: by 2002:a17:902:c402:b0:294:e8a0:382b with SMTP id d9443c01a7336-294ee477f04mr10900275ad.54.1761782076612;
        Wed, 29 Oct 2025 16:54:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40dbfsm167500675ad.72.2025.10.29.16.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:54:36 -0700 (PDT)
Message-ID: <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 16:54:34 -0700
In-Reply-To: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <20251029190113.3323406-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
                                 ^^^^^^^^^^^^^
		I don't like this name very much.
		It bears very little context.
		Imo, KF_IMPLICIT_ARGS fits the use case much better.

> two types in BTF:
>   * `bpf_foo` with a function prototype that omits __magic arguments
>   * `bpf_foo_impl` with a function prototype that matches kernel
>      declaration, but doesn't have a ksym associated with its name

Could you please start with an example here?
Stating how `bpf_foo` needs to be declared in kernel, and what are the
options to invoke it from bpf.  Then proceed with BTF details, etc.

> In order to support magic kfuncs the verifier has to know how to
> resolve calls both of `bpf_foo` and `bpf_foo_impl` to the correct BTF
> function prototype and address.
>=20
> In add_kfunc_call() kfunc flags are inspected to detect a magic kfunc
> or its _impl, and then the address and func_proto are adjusted for the
> kfunc descriptor.
>=20
> In fetch_kfunc_meta() similar logic is used to fixup the contents of
> struct bpf_kfunc_call_arg_meta.
>=20
> In check_kfunc_call() reset the subreg_def of registers holding magic
> arguments to correctly track zero extensions.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  include/linux/btf.h   |   1 +
>  kernel/bpf/verifier.c | 123 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 120 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9c64bc5e5789..3fe20514692f 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,7 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
> +#define KF_MAGIC_ARGS   (1 << 16) /* kfunc signature is different from i=
ts BPF signature */
> =20
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cb1b483be0fa..fcf0872b9e3d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf=
_verifier_env *env, s16 offset)
>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  }
> =20
> +/*
> + * magic_kfuncs is used as a list of (foo, foo_impl) pairs
> + */
> +BTF_ID_LIST(magic_kfuncs)
> +BTF_ID_UNUSED
> +BTF_ID_LIST_END(magic_kfuncs)
> +
> +static s32 magic_kfunc_by_impl(s32 impl_func_id)
> +{
> +	int i;
> +
> +	for (i =3D 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i +=3D 2) {
> +		if (magic_kfuncs[i] =3D=3D impl_func_id)
                                       ^^^^^
Nit: similarly, I'd rename this to something like "implicit_func_id"
     or "fake_func_id. "impl" is confusing because this id has nothing
     to do with implementation.

> +			return magic_kfuncs[i - 1];
> +	}
> +	return -ENOENT;
> +}
> +
> +static s32 impl_by_magic_kfunc(s32 func_id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i +=3D 2) {
> +		if (magic_kfuncs[i] =3D=3D func_id)
> +			return magic_kfuncs[i + 1];
> +	}
> +	return -ENOENT;
> +}
> +
> +static const struct btf_type *find_magic_kfunc_proto(struct btf *desc_bt=
f, s32 func_id)
> +{
> +	const struct btf_type *impl_func, *func_proto;
> +	u32 impl_func_id;
> +
> +	impl_func_id =3D impl_by_magic_kfunc(func_id);
> +	if (impl_func_id < 0)
> +		return NULL;
> +
> +	impl_func =3D btf_type_by_id(desc_btf, impl_func_id);
> +	if (!impl_func || !btf_type_is_func(impl_func))
> +		return NULL;
> +
> +	func_proto =3D btf_type_by_id(desc_btf, impl_func->type);
> +	if (!func_proto || !btf_type_is_func_proto(func_proto))
> +		return NULL;
> +
> +	return func_proto;
> +}
> +
>  static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16=
 offset)
>  {
> -	const struct btf_type *func, *func_proto;
> +	const struct btf_type *func, *func_proto, *tmp_func;
>  	struct bpf_kfunc_btf_tab *btf_tab;
> +	const char *func_name, *tmp_name;
>  	struct btf_func_model func_model;
>  	struct bpf_kfunc_desc_tab *tab;
>  	struct bpf_prog_aux *prog_aux;
>  	struct bpf_kfunc_desc *desc;
> -	const char *func_name;
>  	struct btf *desc_btf;
>  	unsigned long addr;
> +	u32 *kfunc_flags;
> +	s32 tmp_func_id;
>  	int err;
> =20
>  	prog_aux =3D env->prog->aux;
> @@ -3349,8 +3400,37 @@ static int add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, s16 offset)
>  		return -EINVAL;
>  	}
> =20
> +	kfunc_flags =3D btf_kfunc_flags(desc_btf, func_id, env->prog);
>  	func_name =3D btf_name_by_offset(desc_btf, func->name_off);
>  	addr =3D kallsyms_lookup_name(func_name);
> +
> +	/* This may be an _impl kfunc with KF_MAGIC_ARGS counterpart */
> +	if (unlikely(!addr && !kfunc_flags)) {
> +		tmp_func_id =3D magic_kfunc_by_impl(func_id);

I think there is no need to hide magic_kfunc_by_impl() call behind the
above condition. It can be moved before kfunc_flags assignment.
Then it wont be necessary to textually repeat btf_name_by_offset() and
kallsyms_lookup_name() calls.

> +		if (tmp_func_id < 0)
> +			return -EACCES;

Nit: this skips proper error reporting: "cannot find address for kernel fun=
ction %s\n".

> +		tmp_func =3D btf_type_by_id(desc_btf, tmp_func_id);
> +		if (!tmp_func || !btf_type_is_func(tmp_func))

Nit: this condition indicates a verifier bug, should it be reported as such=
?

> +			return -EACCES;
> +		tmp_name =3D btf_name_by_offset(desc_btf, tmp_func->name_off);
> +		addr =3D kallsyms_lookup_name(tmp_name);
> +	}
> +
> +	/*
> +	 * Note that kfunc_flags may be NULL at this point, which means that we=
 couldn't find
> +	 * func_id in any relevant kfunc_id_set. This most likely indicates an =
invalid kfunc call.
> +	 * However we don't want to fail the verification here, because invalid=
 calls may be
> +	 * eliminated as dead code later.
> +	 */
> +	if (unlikely(kfunc_flags && KF_MAGIC_ARGS & *kfunc_flags)) {
> +		func_proto =3D find_magic_kfunc_proto(desc_btf, func_id);
> +		if (!func_proto) {
> +			verbose(env, "cannot find _impl proto for kernel function %s\n",
> +			func_name);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if (!addr) {
>  		verbose(env, "cannot find address for kernel function %s\n",
>  			func_name);
> @@ -12051,6 +12131,11 @@ static bool is_kfunc_arg_irq_flag(const struct b=
tf *btf, const struct btf_param
>  	return btf_param_match_suffix(btf, arg, "__irq_flag");
>  }
> =20
> +static bool is_kfunc_arg_magic(const struct btf *btf, const struct btf_p=
aram *arg)
> +{
> +	return btf_param_match_suffix(btf, arg, "__magic");
> +}
> +
>  static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_pa=
ram *arg)
>  {
>  	return btf_param_match_suffix(btf, arg, "__prog");
> @@ -13613,6 +13698,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_e=
nv *env,
>  	u32 func_id, *kfunc_flags;
>  	const char *func_name;
>  	struct btf *desc_btf;
> +	s32 tmp_func_id;
> =20
>  	if (kfunc_name)
>  		*kfunc_name =3D NULL;
> @@ -13632,10 +13718,28 @@ static int fetch_kfunc_meta(struct bpf_verifier=
_env *env,
>  	func_proto =3D btf_type_by_id(desc_btf, func->type);
> =20
>  	kfunc_flags =3D btf_kfunc_flags_if_allowed(desc_btf, func_id, env->prog=
);
> -	if (!kfunc_flags) {
> -		return -EACCES;
> +	if (unlikely(!kfunc_flags)) {

What if we patch insn->imm to use the "fake" function id in add_kfunc_call(=
)?
Then modifications to fetch_kfunc_meta() wont be necessary.

> +		/*
> +		 * An _impl kfunc with KF_MAGIC_ARGS counterpart
> +		 * does not have its own kfunc flags.
> +		 */
> +		tmp_func_id =3D magic_kfunc_by_impl(func_id);
> +		if (tmp_func_id < 0)
> +			return -EACCES;
> +		kfunc_flags =3D btf_kfunc_flags_if_allowed(desc_btf, tmp_func_id, env-=
>prog);
> +		if (!kfunc_flags)
> +			return -EACCES;
> +	} else if (unlikely(KF_MAGIC_ARGS & *kfunc_flags)) {
> +		/*
> +		 * An actual func_proto of a kfunc with KF_MAGIC_ARGS flag
> +		 * can be found through the corresponding _impl kfunc.
> +		 */
> +		func_proto =3D find_magic_kfunc_proto(desc_btf, func_id);
>  	}
> =20
> +	if (!func_proto)
> +		return -EACCES;
> +
>  	memset(meta, 0, sizeof(*meta));
>  	meta->btf =3D desc_btf;
>  	meta->func_id =3D func_id;
> @@ -14189,6 +14293,17 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	for (i =3D 0; i < nargs; i++) {
>  		u32 regno =3D i + 1;
> =20
> +		/*
> +		 * Magic arguments are set after main verification pass.
> +		 * For correct tracking of zero-extensions we have to reset subreg_def=
 for such
> +		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_=
def of regs
> +		 * from an earlier (irrelevant) point in the program, which may lead t=
o an error
> +		 * in opt_subreg_zext_lo32_rnd_hi32().
> +		 */
> +		if (unlikely(KF_MAGIC_ARGS & meta.kfunc_flags
> +				&& is_kfunc_arg_magic(desc_btf, &args[i])))
> +			regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +
>  		t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
>  		if (btf_type_is_ptr(t))
>  			mark_btf_func_reg_size(env, regno, sizeof(void *));

