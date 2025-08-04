Return-Path: <bpf+bounces-65004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D656B1A331
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 15:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C09717004D
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69026A0DB;
	Mon,  4 Aug 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFTgkCyN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD3267F48;
	Mon,  4 Aug 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314011; cv=none; b=ZdQMZIyEfslS3z4JaC16WLurVhuRnsFdyfvQXvQt26KOMoj05ZwCinoUysmR3ZI/Bj/DKnr8NtSvzLyeB7hCapZc8ADRmYgwidD4iMzbtY/x4g4C88BQuraS/Wm3SBQueXyndopWv3GsyfcbPROmVceOlC9Fsdfnf3b7Uy09Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314011; c=relaxed/simple;
	bh=t7ETmf0H+nvKvs92jN/VK1JNsQL7CVr5t2gKdQ0ASWk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qp1P6qcUe4SIjP7NxGa1aeLc74esQq3D3HWX+3SXZ108UlerRls+6TGwYWAwXU7G/1csWrkldOTFpKFdhQXt7RLs+FWlznWt3D2Pmv9WJc4MaGJx9m6OWtw7csRGDBR9Kcc0zydI9c0IvdktBH+05AyztiyxHXXbgHYt2DzIXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFTgkCyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D0C4CEF0;
	Mon,  4 Aug 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754314010;
	bh=t7ETmf0H+nvKvs92jN/VK1JNsQL7CVr5t2gKdQ0ASWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFTgkCyNVCh3tv4xzled9DizoEOdY1JikSnh0CHzGZC5fSSEuxzy+hkKpyqOi26bj
	 i/w8M32m4K/CtToIU/jEhnbzeMoWIjZGwe1VIUBpBbHHI6FPT5JwkLwI+USzXiVWzl
	 j2XBUaQDrG0Oo77+CRcCj4rOEfpFv+RBuy8WaOlq0Xzbh0Wa/eO0xZQpXSQixd1VLK
	 A6cN5xsWSwXRrPKvJXhpneI8r7H6NWiij/UiZ97Y4MRDPGgPHbLF9rRGRgLV8S2WQM
	 VuC4KdMVnIhUOnzUp3ff2qt4ea5Gtj0Vuuc8JLcz9dFEDZtvBql2FDCedC2WVPxhs2
	 ItgB/2SNGLwMQ==
Date: Mon, 4 Aug 2025 22:26:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
Message-Id: <20250804222645.5d8dd9895812b31e7a6963e9@kernel.org>
In-Reply-To: <20250801071622.63dc9b78@gandalf.local.home>
References: <20250801071622.63dc9b78@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 07:16:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Several functions need to call btf_put() on the btf pointer before it
> returns leading to using "goto" branches to jump to the end to call
> btf_put(btf). This can be simplified by introducing DEFINE_FREE() to allow
> functions to define the btf descriptor with:
> 
>    struct btf *btf __free(btf_put) = NULL;
> 
> Then the btf descriptor will always have btf_put() called on it if it
> isn't NULL or ERR before exiting the function.
> 
> Where needed, no_free_ptr(btf) is used to assign the btf descriptor to a
> pointer that will be used outside the function.
> 

Yeah, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/btf.h         |  4 +++
>  kernel/bpf/btf.c            | 56 +++++++++++--------------------------
>  kernel/trace/trace_btf.c    | 15 +++++-----
>  kernel/trace/trace_output.c |  8 ++----
>  4 files changed, 31 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index b2983706292f..e118c69c4996 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -8,6 +8,7 @@
>  #include <linux/bpfptr.h>
>  #include <linux/bsearch.h>
>  #include <linux/btf_ids.h>
> +#include <linux/cleanup.h>
>  #include <uapi/linux/btf.h>
>  #include <uapi/linux/bpf.h>
>  
> @@ -150,6 +151,9 @@ struct btf *btf_get_by_fd(int fd);
>  int btf_get_info_by_fd(const struct btf *btf,
>  		       const union bpf_attr *attr,
>  		       union bpf_attr __user *uattr);
> +
> +DEFINE_FREE(btf_put, struct btf *, if (!IS_ERR_OR_NULL(_T)) btf_put(_T))
> +
>  /* Figure out the size of a type_id.  If type_id is a modifier
>   * (e.g. const), it will be resolved to find out the type with size.
>   *
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1d2cf898e21e..480657912c96 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3788,7 +3788,7 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  	/* If a matching btf type is found in kernel or module BTFs, kptr_ref
>  	 * is that BTF, otherwise it's program BTF
>  	 */
> -	struct btf *kptr_btf;
> +	struct btf *kptr_btf __free(btf_put) = NULL;
>  	int ret;
>  	s32 id;
>  
> @@ -3827,23 +3827,17 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  		 * the same time.
>  		 */
>  		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id);
> -		if (dtor_btf_id < 0) {
> -			ret = dtor_btf_id;
> -			goto end_btf;
> -		}
> +		if (dtor_btf_id < 0)
> +			return dtor_btf_id;
>  
>  		dtor_func = btf_type_by_id(kptr_btf, dtor_btf_id);
> -		if (!dtor_func) {
> -			ret = -ENOENT;
> -			goto end_btf;
> -		}
> +		if (!dtor_func)
> +			return -ENOENT;
>  
>  		if (btf_is_module(kptr_btf)) {
>  			mod = btf_try_get_module(kptr_btf);
> -			if (!mod) {
> -				ret = -ENXIO;
> -				goto end_btf;
> -			}
> +			if (!mod)
> +				return -ENXIO;
>  		}
>  
>  		/* We already verified dtor_func to be btf_type_is_func
> @@ -3860,13 +3854,11 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  
>  found_dtor:
>  	field->kptr.btf_id = id;
> -	field->kptr.btf = kptr_btf;
> +	field->kptr.btf = no_free_ptr(kptr_btf);
>  	field->kptr.module = mod;
>  	return 0;
>  end_mod:
>  	module_put(mod);
> -end_btf:
> -	btf_put(kptr_btf);
>  	return ret;
>  }
>  
> @@ -8699,7 +8691,7 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
>  static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  				       const struct btf_kfunc_id_set *kset)
>  {
> -	struct btf *btf;
> +	struct btf *btf __free(btf_put) = NULL;
>  	int ret, i;
>  
>  	btf = btf_get_module_btf(kset->owner);
> @@ -8712,14 +8704,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
>  					     kset->set->pairs[i].flags);
>  		if (ret)
> -			goto err_out;
> +			return ret;
>  	}
>  
> -	ret = btf_populate_kfunc_set(btf, hook, kset);
> -
> -err_out:
> -	btf_put(btf);
> -	return ret;
> +	return btf_populate_kfunc_set(btf, hook, kset);
>  }
>  
>  /* This function must be invoked only from initcalls/module init functions */
> @@ -8807,7 +8795,7 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>  				struct module *owner)
>  {
>  	struct btf_id_dtor_kfunc_tab *tab;
> -	struct btf *btf;
> +	struct btf *btf __free(btf_put) = NULL;
>  	u32 tab_cnt, i;
>  	int ret;
>  
> @@ -8873,7 +8861,6 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>  end:
>  	if (ret)
>  		btf_free_dtor_kfunc_tab(btf);
> -	btf_put(btf);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(register_btf_id_dtor_kfuncs);
> @@ -9484,9 +9471,8 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
>  
>  int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
>  {
> -	struct bpf_verifier_log *log;
> -	struct btf *btf;
> -	int err = 0;
> +	struct bpf_verifier_log *log __free(kfree) = NULL;
> +	struct btf *btf __free(btf_put) = NULL;
>  
>  	btf = btf_get_module_btf(st_ops->owner);
>  	if (!btf)
> @@ -9495,20 +9481,12 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
>  		return PTR_ERR(btf);
>  
>  	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> -	if (!log) {
> -		err = -ENOMEM;
> -		goto errout;
> -	}
> +	if (!log)
> +		return -ENOMEM;
>  
>  	log->level = BPF_LOG_KERNEL;
>  
> -	err = btf_add_struct_ops(btf, st_ops, log);
> -
> -errout:
> -	kfree(log);
> -	btf_put(btf);
> -
> -	return err;
> +	return btf_add_struct_ops(btf, st_ops, log);
>  }
>  EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
>  #endif
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> index 5bbdbcbbde3c..1c9111ab538b 100644
> --- a/kernel/trace/trace_btf.c
> +++ b/kernel/trace/trace_btf.c
> @@ -13,26 +13,25 @@
>  const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
>  {
>  	const struct btf_type *t;
> +	struct btf *btf __free(btf_put) = NULL;
>  	s32 id;
>  
> -	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> +	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, &btf);
>  	if (id < 0)
>  		return NULL;
>  
>  	/* Get BTF_KIND_FUNC type */
> -	t = btf_type_by_id(*btf_p, id);
> +	t = btf_type_by_id(btf, id);
>  	if (!t || !btf_type_is_func(t))
> -		goto err;
> +		return NULL;
>  
>  	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> -	t = btf_type_by_id(*btf_p, t->type);
> +	t = btf_type_by_id(btf, t->type);
>  	if (!t || !btf_type_is_func_proto(t))
> -		goto err;
> +		return NULL;
>  
> +	*btf_p = no_free_ptr(btf);
>  	return t;
> -err:
> -	btf_put(*btf_p);
> -	return NULL;
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 0b3db02030a7..c11adfa83d5c 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -698,7 +698,7 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  	const char *param_name;
>  	char name[KSYM_NAME_LEN];
>  	unsigned long arg;
> -	struct btf *btf;
> +	struct btf *btf __free(btf_put) = NULL;
>  	s32 tid, nr = 0;
>  	int a, p, x;
>  
> @@ -716,7 +716,7 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  
>  	param = btf_get_func_param(t, &nr);
>  	if (!param)
> -		goto out_put;
> +		goto out;
>  
>  	for (a = 0, p = 0; p < nr; a++, p++) {
>  		if (p)
> @@ -756,7 +756,7 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  				trace_seq_putc(s, ':');
>  				if (++a == FTRACE_REGS_MAX_ARGS) {
>  					trace_seq_puts(s, "...]");
> -					goto out_put;
> +					goto out;
>  				}
>  				trace_seq_printf(s, "0x%lx", args[a]);
>  			}
> @@ -764,8 +764,6 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  			break;
>  		}
>  	}
> -out_put:
> -	btf_put(btf);
>  out:
>  	trace_seq_printf(s, ")");
>  }
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

