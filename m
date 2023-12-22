Return-Path: <bpf+bounces-18609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA581CA93
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7594E28456C
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703519443;
	Fri, 22 Dec 2023 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOjEHT4A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330218B09
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a234dc0984fso206246766b.0
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703250913; x=1703855713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIJlAKo7nEYXbGaQklBFW91BYiHD8oNjc8kaONWkqmI=;
        b=DOjEHT4AGsz44S6zveoR3K656edQUT0MiTaFOYhU8v4/lYjsdqpCaImyokvpRQ6aff
         IvLIJ9+GQg55GKJox8mSu3GxiZlRTckzilJwcz+xThFR1bVd5xBpZdz4IXH9D+vBa5nS
         ag/G6WUFImixDmmUd5Ww7+VoH9Hlg5pfuE6uALyBA0agk7SuvXZJaHLsdhkGWw1s5xHv
         ouVCQoyxEuFKVzp2v8+FOwuE/rda1FkV8fNkvZFHvcoeh+GhQre5UUUUWKdfm3uTtoKE
         SBIDDzwLfmCJ/D1VCB+az5SjwzdfKv7f2zY5fzhD3RYuvyLyiqB//XDh//ypnZ0/B4QZ
         qtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250913; x=1703855713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIJlAKo7nEYXbGaQklBFW91BYiHD8oNjc8kaONWkqmI=;
        b=CjbXCq+ZxoKNHEfVzkNp/iWOumVXtFo79TEciTlHe6o6f8m0n1y92Rgdmmqi/1du8r
         KR2RQ8PmqG0VitX7sV1nS+uIY+gZ46s0ZCOPFYKEcf6scaFz4kwQF/uF7g828V0l/Qso
         UIs7yinRtOM7ijLPL45/+FfpGDq4F8eSLXlRNsDAFo/uDgE4JK1ywPKPq0lJ+t3tSV/f
         7fADkjho/0HCI1BsegYlaNCOdiQkW4aHBoiSWF2VDaDI8pD0OS7iXJHmR1geNPF0DYze
         vVGuZU2gNKvJPyrgJ8/0hH2hUpNCX3GgeQyM1klmRygc2y/3duS4P2ARdOt9jmb3cSmL
         95FA==
X-Gm-Message-State: AOJu0YxT6GRGgi/OHCctrW3kDWhhBfhCDxWsmxK18tsPj9p95Q6vS1q6
	da4EwomOgw/guXWwe8s8XDw=
X-Google-Smtp-Source: AGHT+IFzlf3IS9EgVSsfbUYKlpGwhrDR1dLHeic7TOJDoCICcwDWJOoLM1pgB3WhLD97kBl9sfzyWg==
X-Received: by 2002:a17:906:5fda:b0:a23:6b49:774d with SMTP id k26-20020a1709065fda00b00a236b49774dmr749735ejv.117.1703250912374;
        Fri, 22 Dec 2023 05:15:12 -0800 (PST)
Received: from krava (host-87-27-10-76.business.telecomitalia.it. [87.27.10.76])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170906ca5a00b00a26aec4c473sm1218445ejb.137.2023.12.22.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:15:11 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Dec 2023 14:15:09 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
Message-ID: <ZYWL3UNIB2sJ3HmQ@krava>
References: <20231220233127.1990417-1-andrii@kernel.org>
 <20231220233127.1990417-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220233127.1990417-8-andrii@kernel.org>

On Wed, Dec 20, 2023 at 03:31:26PM -0800, Andrii Nakryiko wrote:
> Out of all special global func arg tag annotations, __arg_ctx is
> practically is the most immediately useful and most critical to have
> working across multitude kernel version, if possible. This would allow
> end users to write much simpler code if __arg_ctx semantics worked for
> older kernels that don't natively understand btf_decl_tag("arg:ctx") in
> verifier logic.

curious what's the workaround now.. having separate function for each
program type instead of just one global function? I wonder ebpf/cilium
library could do the same thing

whole patchset lgtm:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Luckily, it is possible to ensure __arg_ctx works on old kernels through
> a bit of extra work done by libbpf, at least in a lot of common cases.
> 
> To explain the overall idea, we need to go back at how context argument
> was supported in global funcs before __arg_ctx support was added. This
> was done based on special struct name checks in kernel. E.g., for
> BPF_PROG_TYPE_PERF_EVENT the expectation is that argument type `struct
> bpf_perf_event_data *` mark that argument as PTR_TO_CTX. This is all
> good as long as global function is used from the same BPF program types
> only, which is often not the case. If the same subprog has to be called
> from, say, kprobe and perf_event program types, there is no single
> definition that would satisfy BPF verifier. Subprog will have context
> argument either for kprobe (if using bpf_user_pt_regs_t struct name) or
> perf_event (with bpf_perf_event_data struct name), but not both.
> 
> This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> the actual argument type not important, so that user can just define
> "generic" signature:
> 
>   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
> 
> I won't belabor how libbpf is implementing subprograms, see a huge
> comment next to bpf_object__relocate_calls() function. The idea is that
> each main/entry BPF program gets its own copy of global_subprog's code
> appended.
> 
> This per-program copy of global subprog code *and* associated func_info
> .BTF.ext information, pointing to FUNC -> FUNC_PROTO BTF type chain
> allows libbpf to simulate __arg_ctx behavior transparently, even if the
> kernel doesn't yet support __arg_ctx annotation natively.
> 
> The idea is straightforward: each time we append global subprog's code
> and func_info information, we adjust its FUNC -> FUNC_PROTO type
> information, if necessary (that is, libbpf can detect the presence of
> btf_decl_tag("arg:ctx") just like BPF verifier would do it).
> 
> The rest is just mechanical and somewhat painful BTF manipulation code.
> It's painful because we need to clone FUNC -> FUNC_PROTO, instead of
> reusing it, as same FUNC -> FUNC_PROTO chain might be used by another
> main BPF program within the same BPF object, so we can't just modify it
> in-place (and cloning BTF types within the same struct btf object is
> painful due to constant memory invalidation, see comments in code).
> Uploaded BPF object's BTF information has to work for all BPF
> programs at the same time.
> 
> Once we have FUNC -> FUNC_PROTO clones, we make sure that instead of
> using some `void *ctx` parameter definition, we have an expected `struct
> bpf_perf_event_data *ctx` definition (as far as BPF verifier and kernel
> is concerned), which will mark it as context for BPF verifier. Same
> global subprog relocated and copied into another main BPF program will
> get different type information according to main program's type. It all
> works out in the end in a completely transparent way for end user.
> 
> Libbpf maintains internal program type -> expected context struct name
> mapping internally. Note, not all BPF program types have named context
> struct, so this approach won't work for such programs (just like it
> didn't before __arg_ctx). So native __arg_ctx is still important to have
> in kernel to have generic context support across all BPF program types.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 239 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 231 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 92171bcf4c25..1a7354b6a289 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6168,7 +6168,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
>  	int err;
>  
>  	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
> -	 * supprot func/line info
> +	 * support func/line info
>  	 */
>  	if (!obj->btf_ext || !kernel_supports(obj, FEAT_BTF_FUNC))
>  		return 0;
> @@ -6650,8 +6650,223 @@ static int bpf_prog_assign_exc_cb(struct bpf_object *obj, struct bpf_program *pr
>  	return 0;
>  }
>  
> -static int
> -bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
> +static struct {
> +	enum bpf_prog_type prog_type;
> +	const char *ctx_name;
> +} global_ctx_map[] = {
> +	{ BPF_PROG_TYPE_CGROUP_DEVICE,           "bpf_cgroup_dev_ctx" },
> +	{ BPF_PROG_TYPE_CGROUP_SKB,              "__sk_buff" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCK,             "bpf_sock" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCK_ADDR,        "bpf_sock_addr" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCKOPT,          "bpf_sockopt" },
> +	{ BPF_PROG_TYPE_CGROUP_SYSCTL,           "bpf_sysctl" },
> +	{ BPF_PROG_TYPE_FLOW_DISSECTOR,          "__sk_buff" },
> +	{ BPF_PROG_TYPE_KPROBE,                  "bpf_user_pt_regs_t" },
> +	{ BPF_PROG_TYPE_LWT_IN,                  "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_OUT,                 "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_SEG6LOCAL,           "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_XMIT,                "__sk_buff" },
> +	{ BPF_PROG_TYPE_NETFILTER,               "bpf_nf_ctx" },
> +	{ BPF_PROG_TYPE_PERF_EVENT,              "bpf_perf_event_data" },
> +	{ BPF_PROG_TYPE_RAW_TRACEPOINT,          "bpf_raw_tracepoint_args" },
> +	{ BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, "bpf_raw_tracepoint_args" },
> +	{ BPF_PROG_TYPE_SCHED_ACT,               "__sk_buff" },
> +	{ BPF_PROG_TYPE_SCHED_CLS,               "__sk_buff" },
> +	{ BPF_PROG_TYPE_SK_LOOKUP,               "bpf_sk_lookup" },
> +	{ BPF_PROG_TYPE_SK_MSG,                  "sk_msg_md" },
> +	{ BPF_PROG_TYPE_SK_REUSEPORT,            "sk_reuseport_md" },
> +	{ BPF_PROG_TYPE_SK_SKB,                  "__sk_buff" },
> +	{ BPF_PROG_TYPE_SOCK_OPS,                "bpf_sock_ops" },
> +	{ BPF_PROG_TYPE_SOCKET_FILTER,           "__sk_buff" },
> +	{ BPF_PROG_TYPE_XDP,                     "xdp_md" },
> +	/* all other program types don't have "named" context structs */
> +};
> +
> +/* Check if main program or global subprog's function prototype has `arg:ctx`
> + * argument tags, and, if necessary, substitute correct type to match what BPF
> + * verifier would expect, taking into account specific program type. This
> + * allows to support __arg_ctx tag transparently on old kernels that don't yet
> + * have a native support for it in the verifier, making user's life much
> + * easier.
> + */
> +static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_program *prog)
> +{
> +	const char *ctx_name = NULL, *ctx_tag = "arg:ctx";
> +	struct bpf_func_info_min *func_rec;
> +	struct btf_type *fn_t, *fn_proto_t;
> +	struct btf *btf = obj->btf;
> +	const struct btf_type *t;
> +	struct btf_param *p;
> +	int ptr_id = 0, struct_id, tag_id, orig_fn_id;
> +	int i, j, n, arg_idx, arg_cnt, err, name_off, rec_idx;
> +	int *orig_ids;
> +
> +	/* no .BTF.ext, no problem */
> +	if (!obj->btf_ext || !prog->func_info)
> +		return 0;
> +
> +	/* some BPF program types just don't have named context structs, so
> +	 * this fallback mechanism doesn't work for them
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(global_ctx_map); i++) {
> +		if (global_ctx_map[i].prog_type != prog->type)
> +			continue;
> +		ctx_name = global_ctx_map[i].ctx_name;
> +		break;
> +	}
> +	if (!ctx_name)
> +		return 0;
> +
> +	/* remember original func BTF IDs to detect if we already cloned them */
> +	orig_ids = calloc(prog->func_info_cnt, sizeof(*orig_ids));
> +	if (!orig_ids)
> +		return -ENOMEM;
> +	for (i = 0; i < prog->func_info_cnt; i++) {
> +		func_rec = prog->func_info + prog->func_info_rec_size * i;
> +		orig_ids[i] = func_rec->type_id;
> +	}
> +
> +	/* go through each DECL_TAG with "arg:ctx" and see if it points to one
> +	 * of our subprogs; if yes and subprog is global and needs adjustment,
> +	 * clone and adjust FUNC -> FUNC_PROTO combo
> +	 */
> +	for (i = 1, n = btf__type_cnt(btf); i < n; i++) {
> +		/* only DECL_TAG with "arg:ctx" value are interesting */
> +		t = btf__type_by_id(btf, i);
> +		if (!btf_is_decl_tag(t))
> +			continue;
> +		if (strcmp(btf__str_by_offset(btf, t->name_off), ctx_tag) != 0)
> +			continue;
> +
> +		/* only global funcs need adjustment, if at all */
> +		orig_fn_id = t->type;
> +		fn_t = btf_type_by_id(btf, orig_fn_id);
> +		if (!btf_is_func(fn_t) || btf_func_linkage(fn_t) != BTF_FUNC_GLOBAL)
> +			continue;
> +
> +		/* sanity check FUNC -> FUNC_PROTO chain, just in case */
> +		fn_proto_t = btf_type_by_id(btf, fn_t->type);
> +		if (!fn_proto_t || !btf_is_func_proto(fn_proto_t))
> +			continue;
> +
> +		/* find corresponding func_info record */
> +		func_rec = NULL;
> +		for (rec_idx = 0; rec_idx < prog->func_info_cnt; rec_idx++) {
> +			if (orig_ids[rec_idx] == t->type) {
> +				func_rec = prog->func_info + prog->func_info_rec_size * rec_idx;
> +				break;
> +			}
> +		}
> +		/* current main program doesn't call into this subprog */
> +		if (!func_rec)
> +			continue;
> +
> +		/* some more sanity checking of DECL_TAG */
> +		arg_cnt = btf_vlen(fn_proto_t);
> +		arg_idx = btf_decl_tag(t)->component_idx;
> +		if (arg_idx < 0 || arg_idx >= arg_cnt)
> +			continue;
> +
> +		/* check if existing parameter already matches verifier expectations */
> +		p = &btf_params(fn_proto_t)[arg_idx];
> +		t = skip_mods_and_typedefs(btf, p->type, NULL);
> +		if (btf_is_ptr(t) &&
> +		    (t = skip_mods_and_typedefs(btf, t->type, NULL)) &&
> +		    btf_is_struct(t) &&
> +		    strcmp(btf__str_by_offset(btf, t->name_off), ctx_name) == 0) {
> +			continue; /* no need for fix up */
> +		}
> +
> +		/* clone fn/fn_proto, unless we already did it for another arg */
> +		if (func_rec->type_id == orig_fn_id) {
> +			int fn_id, fn_proto_id, ret_type_id, orig_proto_id;
> +
> +			/* Note that each btf__add_xxx() operation invalidates
> +			 * all btf_type and string pointers, so we need to be
> +			 * very careful when cloning BTF types. BTF type
> +			 * pointers have to be always refetched. And to avoid
> +			 * problems with invalidated string pointers, we
> +			 * add empty strings initially, then just fix up
> +			 * name_off offsets in place. Offsets are stable for
> +			 * existing strings, so that works out.
> +			 */
> +			name_off = fn_t->name_off; /* we are about to invalidate fn_t */
> +			ret_type_id = fn_proto_t->type; /* and fn_proto_t as well */
> +			orig_proto_id = fn_t->type; /* original FUNC_PROTO ID */
> +
> +			/* clone FUNC first, btf__add_func() enforces
> +			 * non-empty name, so use entry program's name as
> +			 * a placeholder, which we replace immediately
> +			 */
> +			fn_id = btf__add_func(btf, prog->name, btf_func_linkage(fn_t), fn_t->type);
> +			if (fn_id < 0)
> +				return -EINVAL;
> +			fn_t = btf_type_by_id(btf, fn_id);
> +			fn_t->name_off = name_off; /* reuse original string */
> +			fn_t->type = fn_id + 1; /* we can predict FUNC_PROTO ID */
> +
> +			/* clone FUNC_PROTO and its params now */
> +			fn_proto_id = btf__add_func_proto(btf, ret_type_id);
> +			if (fn_proto_id < 0) {
> +				err = -EINVAL;
> +				goto err_out;
> +			}
> +			for (j = 0; j < arg_cnt; j++) {
> +				/* copy original parameter data */
> +				t = btf_type_by_id(btf, orig_proto_id);
> +				p = &btf_params(t)[j];
> +				name_off = p->name_off;
> +
> +				err = btf__add_func_param(btf, "", p->type);
> +				if (err)
> +					goto err_out;
> +				fn_proto_t = btf_type_by_id(btf, fn_proto_id);
> +				p = &btf_params(fn_proto_t)[j];
> +				p->name_off = name_off; /* use remembered str offset */
> +			}
> +
> +			/* point func_info record to a cloned FUNC type */
> +			func_rec->type_id = fn_id;
> +		}
> +
> +		/* create PTR -> STRUCT type chain to mark PTR_TO_CTX argument;
> +		 * we do it just once per main BPF program, as all global
> +		 * funcs share the same program type, so need only PTR ->
> +		 * STRUCT type chain
> +		 */
> +		if (ptr_id == 0) {
> +			struct_id = btf__add_struct(btf, ctx_name, 0);
> +			ptr_id = btf__add_ptr(btf, struct_id);
> +			if (ptr_id < 0 || struct_id < 0) {
> +				err = -EINVAL;
> +				goto err_out;
> +			}
> +		}
> +
> +		/* for completeness, clone DECL_TAG and point it to cloned param */
> +		tag_id = btf__add_decl_tag(btf, ctx_tag, func_rec->type_id, arg_idx);
> +		if (tag_id < 0) {
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		/* all the BTF manipulations invalidated pointers, refetch them */
> +		fn_t = btf_type_by_id(btf, func_rec->type_id);
> +		fn_proto_t = btf_type_by_id(btf, fn_t->type);
> +
> +		/* fix up type ID pointed to by param */
> +		p = &btf_params(fn_proto_t)[arg_idx];
> +		p->type = ptr_id;
> +	}
> +
> +	free(orig_ids);
> +	return 0;
> +err_out:
> +	free(orig_ids);
> +	return err;
> +}
> +
> +static int bpf_object_relocate(struct bpf_object *obj, const char *targ_btf_path)
>  {
>  	struct bpf_program *prog;
>  	size_t i, j;
> @@ -6732,19 +6947,28 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
>  			}
>  		}
>  	}
> -	/* Process data relos for main programs */
>  	for (i = 0; i < obj->nr_programs; i++) {
>  		prog = &obj->programs[i];
>  		if (prog_is_subprog(obj, prog))
>  			continue;
>  		if (!prog->autoload)
>  			continue;
> +
> +		/* Process data relos for main programs */
>  		err = bpf_object__relocate_data(obj, prog);
>  		if (err) {
>  			pr_warn("prog '%s': failed to relocate data references: %d\n",
>  				prog->name, err);
>  			return err;
>  		}
> +
> +		/* Fix up .BTF.ext information, if necessary */
> +		err = bpf_program_fixup_func_info(obj, prog);
> +		if (err) {
> +			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %d\n",
> +				prog->name, err);
> +			return err;
> +		}
>  	}
>  
>  	return 0;
> @@ -7456,8 +7680,7 @@ static int bpf_program_record_relos(struct bpf_program *prog)
>  	return 0;
>  }
>  
> -static int
> -bpf_object__load_progs(struct bpf_object *obj, int log_level)
> +static int bpf_object_load_progs(struct bpf_object *obj, int log_level)
>  {
>  	struct bpf_program *prog;
>  	size_t i;
> @@ -8093,10 +8316,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>  	err = err ? : bpf_object__sanitize_maps(obj);
>  	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
> -	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
> +	err = err ? : bpf_object_relocate(obj, obj->btf_custom_path ? : target_btf_path);
>  	err = err ? : bpf_object_load_btf(obj);
>  	err = err ? : bpf_object_create_maps(obj);
> -	err = err ? : bpf_object__load_progs(obj, extra_log_level);
> +	err = err ? : bpf_object_load_progs(obj, extra_log_level);
>  	err = err ? : bpf_object_init_prog_arrays(obj);
>  	err = err ? : bpf_object_prepare_struct_ops(obj);
>  
> -- 
> 2.34.1
> 
> 

