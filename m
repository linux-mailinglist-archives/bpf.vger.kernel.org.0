Return-Path: <bpf+bounces-65559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDEB25570
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84029A214B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7502FE57C;
	Wed, 13 Aug 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrsaEnQN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EC2877C2
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120564; cv=none; b=R5yOTw3QYEsKb3VCmYUUkTXLhzSsogPF1bPzcwQZY5k1tY74yZZupu914nU8gOWc38hZ4c45s7yGHPyfdC2UB1EKGrJKixJfR/khR4A74fgiQfKCk97KLE6DM1mvVy+V+pMwwlZtR5RUasfTh08RvmVL9UsNFtpjVTYHaUJeRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120564; c=relaxed/simple;
	bh=0ZjI+XuH+lk/Rsb6awM7WoiUO3qNdwmBRxOiuKRFM88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6o950baIB3dx+sWPmJrwTSua0SA24V7878D914VPx76xUxcqgkxkaau94SE3xSKItEOLhNv9GZAsvU7/yLCGHDTJ7hRQmB8MyacBgeRNEudDFNssQqnutnv0piuLnPraeMFcytZ2asPB+5eceY5spgX+4yoCWL3/3aK5xIYaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrsaEnQN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso319167a91.1
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755120562; x=1755725362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUG9Iq7TqVm7+LL5A8BrtAygS4tmGu4G0AF1SXsz0Sc=;
        b=NrsaEnQNHH1mxjK/TgBlclrbpU8lwCwvcH4ErQ2DuFksFQeWVa38R/nO5ttDkejFQh
         yiwvGFPhOUNMxGSfEayTrslz0LYaMKVsVNeMc1jv74d7osMeWlj15jOOdqdhsnbOMy+N
         stsz5sGQ/2JaHyan/eZoaF1H0sxbnErdaz/9FbbnNdrHu4t3AynNoxaYCkcP86ktRSzJ
         yCbAagQQyHkkmi+wrngTpMk2sRY+ZPkWk2ycFo0oasrghOSre+ahwdVh6nT5MeDl5mwC
         YguiBbdYqcW5FbaeQzo6j5MqF5DjCySHjsDlXboxDB7owChY4VAZJS/Tt4vIOqvQxdbb
         bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120562; x=1755725362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUG9Iq7TqVm7+LL5A8BrtAygS4tmGu4G0AF1SXsz0Sc=;
        b=u3+vouh0QKrhSUQZjrO2QD6FHslj81jwTbEQ4+H661jhemGgsvY4hirKlR4ABn9AHx
         tHUfkXD8vkaPWy0rieWl0CghTdJrSL0h6Rj/w1BEYZDBEpSJ+dgOG8LGlzFBywbWAW5V
         2p9OTJL7YpaRp488QSwShwjdlGzIB9LACOzx3MAEcuatteA+P7NqNQJxefBb0E/uCG5y
         FepP9aNW8kLQofQNx40J8T1Kuqmwj3gfd7APYK+oUhaUyQFKalAIeEcd8KFBGxKv0ktp
         DWD+cnOujoyMy9ZtLjAbCLXZf5RL4gO1jPPNMwL+uZK7MkR2BI4+1S0LkUqUuoayEnW/
         85iA==
X-Forwarded-Encrypted: i=1; AJvYcCUvSHjx3jsWpbSo9BFewPPSCiCy5ebXQxx2RjxvtWwOLiIPmPdlhA6axQ6t6Kx4uLBcY6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtU5mEGsc0YKAqOg1si2FMRnZvfeDbH43l4/o/ZMIL7YTJM8D/
	D9dPEmF58JHePVK5chFmIGQG4T0uHzWfCu3f5y09jmMbirmntv71dSPv
X-Gm-Gg: ASbGncuKb8lm1saT29sGM9glOZOIGmtbcbHtZhXF317ieGOueekTtmvc7weisFQk+Mh
	pb8C57scXuRyn9yRma1J48NugB+FA5qob8N3abzif3vJS841cirNGGuMmZFMvxevN/jqVQmelvx
	uCzwNjn6Wm2Zd+hYoaQ7WJpzIMNNoW+Mydws8DNjHEeDi4YJBhhYO8iwMpc8rS2N3+X2JkwgCYG
	VIeyspjr3EXxx5sL0GnHsob3CjtpRsQqeNXxvb0O+FbPO9oiDsVZ4rPs59nQIU4//AL8aYrpVyA
	Q/hSwal+QvybdWCkTzXZQmOhr0m+h1WmUlW/4LcRNHx6SDjqTIiHTwnKCzwZLpgejMxPbTqtlzE
	z6SGe9VZhlIhQBpiBR9i8x2/eFnOs
X-Google-Smtp-Source: AGHT+IE6rrRZcexzzlF114xi6eTTtgGE8GD1btcaqAO7pKRR1AyR7K4UaNFdO2IQLvwqpPOXTGC+7A==
X-Received: by 2002:a17:90a:d405:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-32329a72cafmr264048a91.2.1755120561914;
        Wed, 13 Aug 2025 14:29:21 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::e47? ([2620:10d:c090:600::1:f146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257828dfsm989530a91.17.2025.08.13.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:29:21 -0700 (PDT)
Message-ID: <c3d641238a669ed2426abdbfa0d7a0f568f7a0fe.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add BPF program dump in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 13 Aug 2025 14:29:19 -0700
In-Reply-To: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
References: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-11 at 22:20 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> This patch adds support for dumping BPF program instructions directly
> from veristat.
> While it is already possible to inspect BPF program dump using bpftool,
> it requires multiple commands. During active development, it's common
> for developers to use veristat for testing verification. Integrating
> instruction dumping into veristat reduces the need to switch tools and
> simplifies the workflow.
> By making this information more readily accessible, this change aims
> to streamline the BPF development cycle and improve usability for
> developers.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

I have a feature request for this:
generate local labels for branch and call targets.
E.g. as in the tools/testing/selftests/bpf/jit_disasm_helpers.c.
Or as in llvm-objdump -d --symbolize-operands.

That aside, it looks like the code is very similar to bpftool's
xlated_dumper.c. Is there a way to share the code?
There would be now three places where xlated program is printed:
- bpftool
- veristat
- selftests (this one does not handle ksyms, but it would be nice if it cou=
ld)
Should we add something like this to libbpf itself?

[...]

> +static void kernel_syms_load(struct dump_context *ctx)
> +{
> +	struct kernel_sym *sym;
> +	char buff[256];
> +	void *tmp, *address;
> +	FILE *fp;
> +
> +	fp =3D fopen("/proc/kallsyms", "r");
> +	if (!fp)
> +		return;
> +	while (fgets(buff, sizeof(buff), fp)) {
> +		tmp =3D reallocarray(ctx->kernel_syms, ctx->kernel_sym_cnt + 1,
> +				   sizeof(*ctx->kernel_syms));
> +		if (!tmp)
> +			goto failure;
> +		ctx->kernel_syms =3D tmp;
> +		sym =3D ctx->kernel_syms + ctx->kernel_sym_cnt;
> +
> +		if (sscanf(buff, "%p %*c %s", &address, sym->name) < 2)
> +			continue;
> +		sym->address =3D (unsigned long)address;
> +		if (!strcmp(sym->name, "__bpf_call_base")) {
> +			ctx->kfunc_base_addr =3D sym->address;
> +			/* sysctl kernel.kptr_restrict was set */
> +			if (!sym->address)
> +				goto failure;
> +		}
> +		if (sym->address)
> +			ctx->kernel_sym_cnt++;
> +	}
> +
> +	fclose(fp);
> +	qsort(ctx->kernel_syms, ctx->kernel_sym_cnt, sizeof(*ctx->kernel_syms),=
 kernel_syms_cmp);
> +	return;
> +failure:

Say something in debug or verbose mode?

> +	kernel_syms_free(ctx);
> +	fclose(fp);
> +}

[...]

> +static const char *print_call(void *private_data, const struct bpf_insn =
*insn)
> +{
> +	struct kernel_sym *sym;
> +	struct dump_context *ctx =3D (struct dump_context *)private_data;
> +	size_t address =3D ctx->kfunc_base_addr + insn->imm;
> +	struct bpf_prog_info *info =3D ctx->info;
> +
> +	if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
> +		if ((__u32)insn->imm < info->nr_jited_ksyms && info->jited_ksyms) {

Nit: if info->nr_jited_ksyms is non-zero info->jited_ksyms is
     guaranteed to be not NULL?

> +			__u64 *ptr =3D (void *)(size_t)info->jited_ksyms;
> +
> +			address =3D ptr[insn->imm];
> +		}
> +
> +		sym =3D kernel_syms_search(address, ctx);
> +		if (!info->jited_ksyms)
> +			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d", insn->off=
);
> +		else if (sym)
> +			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d#%s", insn->=
off,
> +				 sym->name);
> +		else
> +			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d#0x%lx", ins=
n->off,
> +				 address);
> +	} else {
> +		sym =3D kernel_syms_search(address, ctx);
> +		if (sym)
> +			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%s", sym->name)=
;
> +		else
> +			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "0x%lx", address=
);
> +	}
> +	return ctx->scratch_buf;
> +}

[...]

> +static void emit_line_info(const struct btf *btf, const struct bpf_line_=
info *linfo)
> +{
> +	const char *line =3D btf__name_by_offset(btf, linfo->line_off);
> +
> +	if (!line)
> +		return;
> +	line =3D ltrim(line);
> +	printf("; %s\n", line);

Maybe use same format as kernel here (add file name and line number)?

> +}

[...]

> +static void dump_xlated(const struct btf *btf, struct bpf_program *prog,=
 struct bpf_prog_info *info)
> +{
> +	const struct bpf_insn *insn;
> +	const struct bpf_func_info *finfo;
> +	const struct bpf_line_info *linfo;
> +	const struct bpf_prog_linfo *prog_linfo;
> +	struct btf_dump *d;
> +	__u32 nr_skip =3D 0, i, n;
> +	bool double_insn =3D false;
> +	LIBBPF_OPTS(btf_dump_opts, dump_opts);
> +	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, emit_opts);
> +	struct dump_context ctx =3D {
> +		.info =3D info,
> +		.kernel_syms =3D NULL,
> +		.kernel_sym_cnt =3D 0,
> +		.kfunc_base_addr =3D 0
> +	};
> +	struct bpf_insn_cbs cbs =3D {
> +		.cb_print =3D print_insn,
> +		.cb_call =3D print_call,
> +		.cb_imm =3D print_imm,
> +		.private_data =3D &ctx,
> +	};
> +
> +	/* load symbols for each prog, as prog load could have added new items =
*/
> +	kernel_syms_load(&ctx);
> +
> +	prog_linfo =3D bpf_prog_linfo__new(info);
> +	insn =3D (struct bpf_insn *)info->xlated_prog_insns;
> +	finfo =3D (struct bpf_func_info *)info->func_info;
> +	d =3D btf_dump__new(btf, func_printf, NULL, &dump_opts);

Nit: &dump_opts can be just NULL.
Nit: btf_dump__new() allocates significant amount of memory for
     btf_dump->type_states. Is there a way to share dump instance for
     all programs in the object?

> +	n =3D info->xlated_prog_len / sizeof(*insn);
> +
> +	for (i =3D 0; i < n; i +=3D double_insn ? 2 : 1) {
> +		if (d && finfo && finfo->insn_off =3D=3D i) {
> +			emit_func_info(d, btf, finfo);
> +			finfo++;
> +		}
> +
> +		if (prog_linfo) {
> +			linfo =3D bpf_prog_linfo__lfind(prog_linfo, i, nr_skip);
> +			if (linfo) {
> +				emit_line_info(btf, linfo);
> +				nr_skip++;
> +			}
> +		}
> +		printf("%4u: ", i);
> +		print_bpf_insn(&cbs, insn + i, false);
> +		double_insn =3D insn[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
> +	}
> +

Nit: Add an empty line after the program?
     E.g. take a look at the output for ./veristat iters.bpf.o (from selfte=
sts).

> +	kernel_syms_free(&ctx);
> +	btf_dump__free(d);
> +}
> +
> +static void dump(const struct btf *btf, struct bpf_program *prog, struct=
 bpf_prog_info *info,
> +		 int prog_fd)
> +{
> +	int err;
> +	__u32 info_len =3D sizeof(*info);
> +
> +	if (!env.dump || prog_fd <=3D 0)
> +		return;

Nit: move this to caller?

> +
> +	err =3D prep_prog_info(info);
> +	if (err)
> +		return;
> +
> +	if (bpf_prog_get_info_by_fd(prog_fd, info, &info_len) !=3D 0)
> +		goto cleanup;
> +	dump_xlated(btf, prog, info);
> +cleanup:
> +	free((void *)(unsigned long)info->xlated_prog_insns);

Nit: this is a bit hackish, allocate new info as a part of the malloc
     region in the prep_prog_info()?

> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>  	const char *base_filename =3D basename(strdupa(filename));

[...]

