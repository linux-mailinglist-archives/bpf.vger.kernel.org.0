Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA86D8066
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbjDEPGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjDEPF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 11:05:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3049F9
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 08:05:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x15so34242747pjk.2
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680707151;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GCJMvIo5Cc/js0vM4hvqZrgsKuITDERrvANCKFn44Q=;
        b=Qtvq9sEcHj4P0N/CyFUxfYYdMnBMw04TZadSTRExWapZzSNIuE37KpTDjGJmXKvHUY
         J3DAwal2QjKoudoN7P2M8z2bKQA0KVeNNnmgRqdJ5TbtL3i2LJl0aiJ6jjcyt7bFIPy7
         nPN4C3Pg0dCWQhBZmKJzJ2IBzH78L4l1E+poFW6DLudNDeNKn93T4dJtbFTJht/XeOqN
         KeZI2iqoYRaVg/ulN+mKtXxisJZONVx+PDXaaKjNcJCWglkMC1Uz71z2BABsjEQb4TpU
         O8G0eQ0SMY8hxzTwePjkhL1Ian2ZUpfmMt9eEoKbFDR4F2R8vOnr1tpc0VcOeej8Jf7G
         6oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707151;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GCJMvIo5Cc/js0vM4hvqZrgsKuITDERrvANCKFn44Q=;
        b=jIjN2k8ynBlUxN2OA/tz34QWf8O3w//n7KeoJnOcEoWwu/+FE/LXb3wr+xQE/rYocZ
         tCo/JMNLbRB+s7tDtaOxwqIVDQ3XcfDsaQkIX8BoNuooy9VieAuZcqgNiHIIFiHk29SS
         D2Vg+12pfVYj+/CmdFZZUkpU/nxx2qGlV1qkSR2GCYpog48PTNaUs/KYsJs8/obngL7C
         LNRKvVL5m80R00ZMbp4FRrXjbc6CbLG2/1aaosucoUpe9ypS/OXQUiuPtTmTAkvhoIfH
         zerzjqygiCwyvZUUL3GUvhCzLLvrOBlYUp2rF+45vIn+DpT1xG0hnzJcdY80D8RrCA5y
         3Fmw==
X-Gm-Message-State: AAQBX9eolq5po78fK6N58E4z74nGb3lC8VL2BIFTRozy6t6P2bVKJQ1I
        253PLIwZap37zoXu8eP+O12TLnirFAYZfoUaa8s=
X-Google-Smtp-Source: AKy350Z1wZVnYTvD6hIqJ6v0duWsyuttRNXdHOM4rcIr7e8VZz+SEvqdLh5cvOcJMfqyxkdh+yMH0Q==
X-Received: by 2002:a05:6a20:bfdd:b0:cc:d96c:1090 with SMTP id gs29-20020a056a20bfdd00b000ccd96c1090mr5290925pzb.2.1680707151386;
        Wed, 05 Apr 2023 08:05:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b46c:756f:54fd:f48d? ([2601:647:4900:1fbb:b46c:756f:54fd:f48d])
        by smtp.gmail.com with ESMTPSA id g4-20020a63dd44000000b0050bf1d1cdc8sm9474255pgj.21.2023.04.05.08.05.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:05:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH bpf-next] bpf: Add a kfunc filter function to 'struct
 btf_kfunc_id_set'.
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <20230404060959.2259448-1-martin.lau@linux.dev>
Date:   Wed, 5 Apr 2023 08:05:48 -0700
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>, kernel-team@meta.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCD96FC5-9926-49F6-B56D-FAFB65A2FEE4@isovalent.com>
References: <500d452b-f9d5-d01f-d365-2949c4fd37ab@linux.dev>
 <20230404060959.2259448-1-martin.lau@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Looks quite promising for the sock_destroy use case, and also as a =
generic filtering mechanism, but I'm not aware of other use cases. I =
haven't had a chance to apply this patch locally, but I'm planning to do =
it soon. Thanks!

> On Apr 3, 2023, at 11:09 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This set =
(https://lore.kernel.org/bpf/https://lore.kernel.org/bpf/500d452b-f9d5-d01=
f-d365-2949c4fd37ab@linux.dev/)
> needs to limit bpf_sock_destroy kfunc to BPF_TRACE_ITER.
> In the earlier reply, I thought of adding a =
BTF_KFUNC_HOOK_TRACING_ITER.
>=20
> Instead of adding BTF_KFUNC_HOOK_TRACING_ITER, I quickly hacked =
something
> that added a callback filter to 'struct btf_kfunc_id_set'. The filter =
has
> access to the prog such that it can filter by other properties of a =
prog.
> The prog->expected_attached_type is used in the tracing_iter_filter().
> It is mostly compiler tested only, so it is still very rough but =
should
> be good enough to show the idea.
>=20
> would like to hear how others think. It is pretty much the only
> piece left for the above mentioned set.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
> include/linux/btf.h                           | 18 +++---
> kernel/bpf/btf.c                              | 59 +++++++++++++++----
> kernel/bpf/verifier.c                         |  7 ++-
> net/core/filter.c                             |  9 +++
> .../selftests/bpf/progs/sock_destroy_prog.c   | 10 ++++
> 5 files changed, 83 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index d53b10cc55f2..84c31b4f5785 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -99,10 +99,14 @@ struct btf_type;
> union bpf_attr;
> struct btf_show;
> struct btf_id_set;
> +struct bpf_prog;
> +
> +typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 =
kfunc_id);
>=20
> struct btf_kfunc_id_set {
> 	struct module *owner;
> 	struct btf_id_set8 *set;
> +	btf_kfunc_filter_t filter;
> };
>=20
> struct btf_id_dtor_kfunc {
> @@ -482,7 +486,6 @@ static inline void *btf_id_set8_contains(const =
struct btf_id_set8 *set, u32 id)
> 	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), =
btf_id_cmp_func);
> }
>=20
> -struct bpf_prog;
> struct bpf_verifier_log;
>=20
> #ifdef CONFIG_BPF_SYSCALL
> @@ -490,10 +493,10 @@ const struct btf_type *btf_type_by_id(const =
struct btf *btf, u32 type_id);
> const char *btf_name_by_offset(const struct btf *btf, u32 offset);
> struct btf *btf_parse_vmlinux(void);
> struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
> -u32 *btf_kfunc_id_set_contains(const struct btf *btf,
> -			       enum bpf_prog_type prog_type,
> -			       u32 kfunc_btf_id);
> -u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 =
kfunc_btf_id);
> +u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 =
kfunc_btf_id,
> +			       const struct bpf_prog *prog);
> +u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 =
kfunc_btf_id,
> +				const struct bpf_prog *prog);
> int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
> 			      const struct btf_kfunc_id_set *s);
> int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
> @@ -520,8 +523,9 @@ static inline const char *btf_name_by_offset(const =
struct btf *btf,
> 	return NULL;
> }
> static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
> -					     enum bpf_prog_type =
prog_type,
> -					     u32 kfunc_btf_id)
> +					     u32 kfunc_btf_id,
> +					     struct bpf_prog *prog)
> +
> {
> 	return NULL;
> }
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b7e5a5510b91..7685af3ca9c0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -218,10 +218,17 @@ enum btf_kfunc_hook {
> enum {
> 	BTF_KFUNC_SET_MAX_CNT =3D 256,
> 	BTF_DTOR_KFUNC_MAX_CNT =3D 256,
> +	BTF_KFUNC_FILTER_MAX_CNT =3D 16,
> +};
> +
> +struct btf_kfunc_hook_filter {
> +	btf_kfunc_filter_t filters[BTF_KFUNC_FILTER_MAX_CNT];
> +	u32 nr_filters;
> };
>=20
> struct btf_kfunc_set_tab {
> 	struct btf_id_set8 *sets[BTF_KFUNC_HOOK_MAX];
> +	struct btf_kfunc_hook_filter hook_filters[BTF_KFUNC_HOOK_MAX];
> };
>=20
> struct btf_id_dtor_kfunc_tab {
> @@ -7712,9 +7719,12 @@ static int btf_check_kfunc_protos(struct btf =
*btf, u32 func_id, u32 func_flags)
> /* Kernel Function (kfunc) BTF ID set registration API */
>=20
> static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook =
hook,
> -				  struct btf_id_set8 *add_set)
> +				  const struct btf_kfunc_id_set *kset)
> {
> +	struct btf_kfunc_hook_filter *hook_filter;
> +	struct btf_id_set8 *add_set =3D kset->set;
> 	bool vmlinux_set =3D !btf_is_module(btf);
> +	bool add_filter =3D !!kset->filter;
> 	struct btf_kfunc_set_tab *tab;
> 	struct btf_id_set8 *set;
> 	u32 set_cnt;
> @@ -7729,6 +7739,20 @@ static int btf_populate_kfunc_set(struct btf =
*btf, enum btf_kfunc_hook hook,
> 		return 0;
>=20
> 	tab =3D btf->kfunc_set_tab;
> +
> +	if (tab && add_filter) {
> +		int i;
> +
> +		hook_filter =3D &tab->hook_filters[hook];
> +		for (i =3D 0; i < hook_filter->nr_filters; i++) {
> +			if (hook_filter->filters[i] =3D=3D kset->filter)
> +				add_filter =3D false;
> +		}

Not intimately familiar with the internals of kfuncs, so mainly for my =
understanding, what's the use case for having multiple filters?

> +
> +		if (add_filter && hook_filter->nr_filters =3D=3D =
BTF_KFUNC_FILTER_MAX_CNT)
> +			return -E2BIG;
> +	}
> +
> 	if (!tab) {
> 		tab =3D kzalloc(sizeof(*tab), GFP_KERNEL | =
__GFP_NOWARN);
> 		if (!tab)
> @@ -7751,7 +7775,7 @@ static int btf_populate_kfunc_set(struct btf =
*btf, enum btf_kfunc_hook hook,
> 	 */
> 	if (!vmlinux_set) {
> 		tab->sets[hook] =3D add_set;
> -		return 0;
> +		goto do_add_filter;
> 	}
>=20
> 	/* In case of vmlinux sets, there may be more than one set being
> @@ -7793,6 +7817,11 @@ static int btf_populate_kfunc_set(struct btf =
*btf, enum btf_kfunc_hook hook,
>=20
> 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), =
btf_id_cmp_func, NULL);
>=20
> +do_add_filter:
> +	if (add_filter) {
> +		hook_filter =3D &tab->hook_filters[hook];
> +		hook_filter->filters[hook_filter->nr_filters++] =3D =
kset->filter;
> +	}
> 	return 0;
> end:
> 	btf_free_kfunc_set_tab(btf);
> @@ -7801,15 +7830,22 @@ static int btf_populate_kfunc_set(struct btf =
*btf, enum btf_kfunc_hook hook,
>=20
> static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
> 					enum btf_kfunc_hook hook,
> +					const struct bpf_prog *prog,
> 					u32 kfunc_btf_id)
> {
> +	struct btf_kfunc_hook_filter *hook_filter;
> 	struct btf_id_set8 *set;
> -	u32 *id;
> +	u32 *id, i;
>=20
> 	if (hook >=3D BTF_KFUNC_HOOK_MAX)
> 		return NULL;
> 	if (!btf->kfunc_set_tab)
> 		return NULL;
> +	hook_filter =3D &btf->kfunc_set_tab->hook_filters[hook];
> +	for (i =3D 0; i < hook_filter->nr_filters; i++) {
> +		if (hook_filter->filters[i](prog, kfunc_btf_id))
> +			return NULL;
> +	}
> 	set =3D btf->kfunc_set_tab->sets[hook];
> 	if (!set)
> 		return NULL;
> @@ -7862,23 +7898,25 @@ static int bpf_prog_type_to_kfunc_hook(enum =
bpf_prog_type prog_type)
>  * protection for looking up a well-formed btf->kfunc_set_tab.
>  */
> u32 *btf_kfunc_id_set_contains(const struct btf *btf,
> -			       enum bpf_prog_type prog_type,
> -			       u32 kfunc_btf_id)
> +			       u32 kfunc_btf_id,
> +			       const struct bpf_prog *prog)
> {
> +	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
> 	enum btf_kfunc_hook hook;
> 	u32 *kfunc_flags;
>=20
> -	kfunc_flags =3D __btf_kfunc_id_set_contains(btf, =
BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
> +	kfunc_flags =3D __btf_kfunc_id_set_contains(btf, =
BTF_KFUNC_HOOK_COMMON, prog, kfunc_btf_id);
> 	if (kfunc_flags)
> 		return kfunc_flags;
>=20
> 	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
> -	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> +	return __btf_kfunc_id_set_contains(btf, hook, prog, =
kfunc_btf_id);
> }
>=20
> -u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 =
kfunc_btf_id)
> +u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 =
kfunc_btf_id,
> +				const struct bpf_prog *prog)
> {
> -	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, =
kfunc_btf_id);
> +	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, =
prog, kfunc_btf_id);
> }
>=20
> static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
> @@ -7909,7 +7947,8 @@ static int __register_btf_kfunc_id_set(enum =
btf_kfunc_hook hook,
> 			goto err_out;
> 	}
>=20
> -	ret =3D btf_populate_kfunc_set(btf, hook, kset->set);
> +	ret =3D btf_populate_kfunc_set(btf, hook, kset);
> +
> err_out:
> 	btf_put(btf);
> 	return ret;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20eb2015842f..1a854cdb2566 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10553,7 +10553,7 @@ static int fetch_kfunc_meta(struct =
bpf_verifier_env *env,
> 		*kfunc_name =3D func_name;
> 	func_proto =3D btf_type_by_id(desc_btf, func->type);
>=20
> -	kfunc_flags =3D btf_kfunc_id_set_contains(desc_btf, =
resolve_prog_type(env->prog), func_id);
> +	kfunc_flags =3D btf_kfunc_id_set_contains(desc_btf, func_id, =
env->prog);
> 	if (!kfunc_flags) {
> 		return -EACCES;
> 	}
> @@ -18521,7 +18521,8 @@ int bpf_check_attach_target(struct =
bpf_verifier_log *log,
> 				 * in the fmodret id set with the =
KF_SLEEPABLE flag.
> 				 */
> 				else {
> -					u32 *flags =3D =
btf_kfunc_is_modify_return(btf, btf_id);
> +					u32 *flags =3D =
btf_kfunc_is_modify_return(btf, btf_id,
> +										=
prog);
>=20
> 					if (flags && (*flags & =
KF_SLEEPABLE))
> 						ret =3D 0;
> @@ -18549,7 +18550,7 @@ int bpf_check_attach_target(struct =
bpf_verifier_log *log,
> 				return -EINVAL;
> 			}
> 			ret =3D -EINVAL;
> -			if (btf_kfunc_is_modify_return(btf, btf_id) ||
> +			if (btf_kfunc_is_modify_return(btf, btf_id, =
prog) ||
> 			    !check_attach_modify_return(addr, tname))
> 				ret =3D 0;
> 			if (ret) {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a70c7b9876fa..5e5e6f9baccc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11768,9 +11768,18 @@ BTF_SET8_START(sock_destroy_kfunc_set)
> BTF_ID_FLAGS(func, bpf_sock_destroy)
> BTF_SET8_END(sock_destroy_kfunc_set)
>=20
> +static int tracing_iter_filter(const struct bpf_prog *prog, u32 =
kfunc_id)
> +{
> +	if (btf_id_set8_contains(&sock_destroy_kfunc_set, kfunc_id) &&
> +	    prog->expected_attach_type !=3D BPF_TRACE_ITER)
> +		return -EACCES;
> +	return 0;
> +}
> +
> static const struct btf_kfunc_id_set bpf_sock_destroy_kfunc_set =3D {
> 	.owner =3D THIS_MODULE,
> 	.set   =3D &sock_destroy_kfunc_set,
> +	.filter =3D tracing_iter_filter,
> };
>=20
> static int init_subsystem(void)
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> index 5c1e65d50598..5204e44f6ae4 100644
> --- a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> @@ -3,6 +3,7 @@
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_tracing.h>
>=20
> #include "bpf_tracing_net.h"
>=20
> @@ -144,4 +145,13 @@ int iter_udp6_server(struct bpf_iter__udp *ctx)
> 	return 0;
> }
>=20
> +SEC("tp_btf/tcp_destroy_sock")
> +int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
> +{
> +	/* should not load */
> +	bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> char _license[] SEC("license") =3D "GPL";
> --=20
> 2.34.1
>=20

