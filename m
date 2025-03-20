Return-Path: <bpf+bounces-54489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002FA6AD29
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 19:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D1718999E2
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 18:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD1226CFB;
	Thu, 20 Mar 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJkjWuyf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84611E9B0B;
	Thu, 20 Mar 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495781; cv=none; b=tHEbcnCqkyKCqSJkifM4ksSzQWmZjMIAQ8wJiVy7EMVIN7TPEhfG4iEz4+JqhXaeE7Pxbu808HH+pD2hv6/F1Yv8+Yj626wZIlbi/jwnQE7dZFGsPK9+DaalK1MEdC+2I3jbIQrd11kdfTgiT7nxt5fn0l2ynCGpjfsu5pIHlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495781; c=relaxed/simple;
	bh=S7nLSBQ+ek4WtJVAzgbgs3rhKjShwEW7Y0tcqknO2Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H4PytyfwUUdCqU9sWtpZf+dJTNpljZ9eahhgz5HZw5mxmy63PQn7hshONc1WSyf0ITz8tQl/5Dk9/vD33U/lr3YBwenCVeX4KgE+GnabE3cQJUrWS4Po2Te8lRCU4cK0KFpCBlMGfwppu4Gw6dAkcqxAVJ5itZISvqJpfxUJb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJkjWuyf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so1904265a12.2;
        Thu, 20 Mar 2025 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742495776; x=1743100576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoQkaQjQVuB8gBuHh6FHLS+Odc0MdG58RFKMyvuygrk=;
        b=YJkjWuyfah8zlKuoAOEc0/TcUoS4Cvb/OcP+21egO0/f9lltjmJvjLWMOT8eJk5hhW
         45GLHaWy30zwZpS3Wv+pf6CugldmjU6/9YMW6HpyuaFOQY28F8iDPO/XeRiYRra9xG6x
         wMsWAoYGhsXBGnZ8zeGvLFEpdfyfv+HZrYoUCgib/ukxBBViaocRbmkADOfyHLUT86b+
         CWElh2qLLhdcNCXtxSgxpCHiqQffshooMNFsPXNx2ExjDVgXnfB/VLV/4cXdZp9keKIf
         XSWkAQWKiJ2jbVJC/5DgIdeHhzF7yQeXeEhgaaB+pFamuECAhXf6OOR7RiEgiXr/bEHJ
         ExDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495776; x=1743100576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoQkaQjQVuB8gBuHh6FHLS+Odc0MdG58RFKMyvuygrk=;
        b=dyX/QPIFdilmuDunrwfx7y6u27DzJF4L3HWIGhFvWbiJ2RcoTerJIV3gh/NmSL5iMO
         yWFoXYn0XzAD+yxfZEoWFMB/pzqgZaw/27zi2EpcoDroQkMGxKtDlC2Omdsc7btZF4dK
         PsJNBL/KruZuRSqLZPIPlwBwYbrQXV6t0cR5VOBPWPkhQsHbR5S+AcvYP/0Kb91liOtJ
         J8Na1lLGBwhkDBLCRISqgp45Abwe+q2RsISuNTC+QZntjMpiM/Sl2wDaQYXP5n9Vf/hp
         nciDnvYHI5xBHbeGDQFz5A1yqbYCx1oFoMTGGaSrsZpXRHwP8ZHRJuzPehxnCnrF96++
         PzWg==
X-Forwarded-Encrypted: i=1; AJvYcCWD6CHmz8QUq2oBNJ0DzJJRoxpci8JGN64WYfmaHmVDYEJ+S4W5SSMCL26NNrjb0QA6SGLbvBjttxFAXAzl@vger.kernel.org, AJvYcCWOffRVlcePcBJOz+sOQ+mKhbZ9wSZs+ZNpmtspFEVTFmcbVJNpdRxTNtwuiGhZzrrLLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkoUOXdJgweXTUnrIs5IxRNQ4xJO0iNMnnlvuz3txZL+bGQkB
	KuWYSbuM6sMkNeFVAAE1eqAnjAJqy7ziZwSbg6Iy+vq/QIYLG3/N
X-Gm-Gg: ASbGncsd/DtBWxx/CUvMnljClkhDXTfTcYbKD2C8bDYELUAp0475HU9yXwke5ipBHla
	TrzTKEDuldYW/WWHJN2JmnBGn0XQ5renqIxQg2UGY3kHTA1sTxAFEEhBHVguyMH/O7k0USKshXo
	MgrcNr4pvN8L4uNF/O63CZatiO7p/JZCa4pOeAmsRnpEHr40rwVZEm0b/8YFQIAsSbNFXxjLH1t
	kmPNCqlmdiDgbVaqQ2YZ3YEM/7Or2c/HTsZ+rPiJ7z4FZYQoQiOW5UqDFlOoImwNtirxWRL2eVS
	SL4VNxSKP4qIfnrSWl12EWXIRUTW2Z4HfJqw7KW7xJ9iRB2bk+0IZ6nra2tNffMrLE8LtVwhSl2
	vLplZ
X-Google-Smtp-Source: AGHT+IGl7h/0FOPqmqcmimZvLsg8XKJkbSWDQr1Zaz7U/Szr/Hfo6hIfWpAIYWgkYLVxImzALlf9jw==
X-Received: by 2002:a05:6402:2753:b0:5e6:ddab:736c with SMTP id 4fb4d7f45d1cf-5ebcd467f5fmr364795a12.17.1742495774981;
        Thu, 20 Mar 2025 11:36:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:f202:b164:4fe2:c11? ([2620:10d:c092:500::5:3227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0df211sm146904a12.67.2025.03.20.11.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:36:14 -0700 (PDT)
Message-ID: <fdd4ec9d-39d6-4e24-a736-ac664fb14905@gmail.com>
Date: Thu, 20 Mar 2025 18:36:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] libbpf: Add namespace for errstr making it
 libbpf_errstr
To: Ian Rogers <irogers@google.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250320175951.1265274-1-irogers@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250320175951.1265274-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 17:59, Ian Rogers wrote:
> When statically linking symbols can be replaced with those from other
> statically linked libraries depending on the link order and the hoped
> for "multiple definition" error may not appear. To avoid conflicts it
> is good practice to namespace symbols, this change renames errstr to
> libbpf_errstr.
>
> Fixes: 1633a83bf993 ("libbpf: Introduce errstr() for stringifying errno")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> I feel like this patch shouldn't be strictly necessary, it turned out
> for a use-case it was and people who know better than me say the
> linker is working as intended. The conflicting errstr was from:
> https://sourceforge.net/projects/linuxquota/
> The fixes tag may not be strictly necessary.
> ---
>   tools/lib/bpf/btf.c        |  24 ++--
>   tools/lib/bpf/btf_dump.c   |   2 +-
>   tools/lib/bpf/elf.c        |   2 +-
>   tools/lib/bpf/features.c   |   6 +-
>   tools/lib/bpf/gen_loader.c |   2 +-
>   tools/lib/bpf/libbpf.c     | 228 +++++++++++++++++++------------------
>   tools/lib/bpf/linker.c     |  21 ++--
>   tools/lib/bpf/ringbuf.c    |  21 ++--
>   tools/lib/bpf/str_error.c  |   2 +-
>   tools/lib/bpf/str_error.h  |   4 +-
>   tools/lib/bpf/usdt.c       |  16 +--
>   11 files changed, 168 insertions(+), 160 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 38bc6b14b066..b9389ce6a316 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1180,7 +1180,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>   	fd = open(path, O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
>   		err = -errno;
> -		pr_warn("failed to open %s: %s\n", path, errstr(err));
> +		pr_warn("failed to open %s: %s\n", path, libbpf_errstr(err));
>   		return ERR_PTR(err);
>   	}
>   
> @@ -1447,7 +1447,7 @@ int btf_load_into_kernel(struct btf *btf,
>   			goto retry_load;
>   
>   		err = -errno;
> -		pr_warn("BTF loading error: %s\n", errstr(err));
> +		pr_warn("BTF loading error: %s\n", libbpf_errstr(err));
>   		/* don't print out contents of custom log_buf */
>   		if (!log_buf && buf[0])
>   			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf);
> @@ -3517,42 +3517,42 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
>   
>   	err = btf_dedup_prep(d);
>   	if (err) {
> -		pr_debug("btf_dedup_prep failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_prep failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_strings(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_strings failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_strings failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_prim_types(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_prim_types failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_prim_types failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_struct_types(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_struct_types failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_struct_types failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_resolve_fwds(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_resolve_fwds failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_resolve_fwds failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_ref_types(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_ref_types failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_ref_types failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_compact_types(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_compact_types failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_compact_types failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   	err = btf_dedup_remap_types(d);
>   	if (err < 0) {
> -		pr_debug("btf_dedup_remap_types failed: %s\n", errstr(err));
> +		pr_debug("btf_dedup_remap_types failed: %s\n", libbpf_errstr(err));
>   		goto done;
>   	}
>   
> @@ -5272,7 +5272,7 @@ struct btf *btf__load_vmlinux_btf(void)
>   		if (!btf) {
>   			err = -errno;
>   			pr_warn("failed to read kernel BTF from '%s': %s\n",
> -				sysfs_btf_path, errstr(err));
> +				sysfs_btf_path, libbpf_errstr(err));
>   			return libbpf_err_ptr(err);
>   		}
>   		pr_debug("loaded kernel BTF from '%s'\n", sysfs_btf_path);
> @@ -5289,7 +5289,7 @@ struct btf *btf__load_vmlinux_btf(void)
>   
>   		btf = btf__parse(path, NULL);
>   		err = libbpf_get_error(btf);
> -		pr_debug("loading kernel BTF '%s': %s\n", path, errstr(err));
> +		pr_debug("loading kernel BTF '%s': %s\n", path, libbpf_errstr(err));
>   		if (err)
>   			continue;
>   
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 460c3e57fadb..75c27db7a01c 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1305,7 +1305,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
>   			 * chain, restore stack, emit warning, and try to
>   			 * proceed nevertheless
>   			 */
> -			pr_warn("not enough memory for decl stack: %s\n", errstr(err));
> +			pr_warn("not enough memory for decl stack: %s\n", libbpf_errstr(err));
>   			d->decl_stack_cnt = stack_start;
>   			return;
>   		}
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 823f83ad819c..4294c9f9f572 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -37,7 +37,7 @@ int elf_open(const char *binary_path, struct elf_fd *elf_fd)
>   	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
>   		ret = -errno;
> -		pr_warn("elf: failed to open %s: %s\n", binary_path, errstr(ret));
> +		pr_warn("elf: failed to open %s: %s\n", binary_path, libbpf_errstr(ret));
>   		return ret;
>   	}
>   	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c..f47cadf6512a 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -67,7 +67,7 @@ static int probe_kern_global_data(int token_fd)
>   	if (map < 0) {
>   		ret = -errno;
>   		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
> -			__func__, errstr(ret));
> +			__func__, libbpf_errstr(ret));
>   		return ret;
>   	}
>   
> @@ -283,7 +283,7 @@ static int probe_prog_bind_map(int token_fd)
>   	if (map < 0) {
>   		ret = -errno;
>   		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
> -			__func__, errstr(ret));
> +			__func__, libbpf_errstr(ret));
>   		return ret;
>   	}
>   
> @@ -601,7 +601,7 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
>   			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>   		} else {
>   			pr_warn("Detection of kernel %s support failed: %s\n",
> -				feat->desc, errstr(ret));
> +				feat->desc, libbpf_errstr(ret));
>   			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>   		}
>   	}
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 113ae4abd345..157364527781 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -394,7 +394,7 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>   			      blob_fd_array_off(gen, i));
>   	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
>   	emit(gen, BPF_EXIT_INSN());
> -	pr_debug("gen: finish %s\n", errstr(gen->error));
> +	pr_debug("gen: finish %s\n", libbpf_errstr(gen->error));
>   	if (!gen->error) {
>   		struct gen_loader_opts *opts = gen->opts;
>   
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..c4a9059eab12 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1558,7 +1558,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
>   		obj->efile.fd = open(obj->path, O_RDONLY | O_CLOEXEC);
>   		if (obj->efile.fd < 0) {
>   			err = -errno;
> -			pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
> +			pr_warn("elf: failed to open %s: %s\n", obj->path, libbpf_errstr(err));
>   			return err;
>   		}
>   
> @@ -1976,7 +1976,8 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>   	if (map->mmaped == MAP_FAILED) {
>   		err = -errno;
>   		map->mmaped = NULL;
> -		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
> +		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name,
> +			libbpf_errstr(err));
>   		zfree(&map->real_name);
>   		zfree(&map->name);
>   		return err;
> @@ -2140,7 +2141,7 @@ static int parse_u64(const char *value, __u64 *res)
>   	*res = strtoull(value, &value_end, 0);
>   	if (errno) {
>   		err = -errno;
> -		pr_warn("failed to parse '%s': %s\n", value, errstr(err));
> +		pr_warn("failed to parse '%s': %s\n", value, libbpf_errstr(err));
>   		return err;
>   	}
>   	if (*value_end) {
> @@ -2307,7 +2308,7 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
>   		err = bpf_object__process_kconfig_line(obj, buf, data);
>   		if (err) {
>   			pr_warn("error parsing system Kconfig line '%s': %s\n",
> -				buf, errstr(err));
> +				buf, libbpf_errstr(err));
>   			goto out;
>   		}
>   	}
> @@ -2327,7 +2328,7 @@ static int bpf_object__read_kconfig_mem(struct bpf_object *obj,
>   	file = fmemopen((void *)config, strlen(config), "r");
>   	if (!file) {
>   		err = -errno;
> -		pr_warn("failed to open in-memory Kconfig: %s\n", errstr(err));
> +		pr_warn("failed to open in-memory Kconfig: %s\n", libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -2335,7 +2336,7 @@ static int bpf_object__read_kconfig_mem(struct bpf_object *obj,
>   		err = bpf_object__process_kconfig_line(obj, buf, data);
>   		if (err) {
>   			pr_warn("error parsing in-memory Kconfig line '%s': %s\n",
> -				buf, errstr(err));
> +				buf, libbpf_errstr(err));
>   			break;
>   		}
>   	}
> @@ -3250,7 +3251,8 @@ static int bpf_object__init_btf(struct bpf_object *obj,
>   		err = libbpf_get_error(obj->btf);
>   		if (err) {
>   			obj->btf = NULL;
> -			pr_warn("Error loading ELF section %s: %s.\n", BTF_ELF_SEC, errstr(err));
> +			pr_warn("Error loading ELF section %s: %s.\n", BTF_ELF_SEC,
> +				libbpf_errstr(err));
>   			goto out;
>   		}
>   		/* enforce 8-byte pointers for BPF-targeted BTFs */
> @@ -3269,7 +3271,7 @@ static int bpf_object__init_btf(struct bpf_object *obj,
>   		err = libbpf_get_error(obj->btf_ext);
>   		if (err) {
>   			pr_warn("Error loading ELF section %s: %s. Ignored and continue.\n",
> -				BTF_EXT_ELF_SEC, errstr(err));
> +				BTF_EXT_ELF_SEC, libbpf_errstr(err));
>   			obj->btf_ext = NULL;
>   			goto out;
>   		}
> @@ -3362,7 +3364,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
>   		err = find_elf_sec_sz(obj, sec_name, &size);
>   		if (err || !size) {
>   			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %s\n",
> -				 sec_name, size, errstr(err));
> +				 sec_name, size, libbpf_errstr(err));
>   			return -ENOENT;
>   		}
>   
> @@ -3516,7 +3518,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
>   	obj->btf_vmlinux = btf__load_vmlinux_btf();
>   	err = libbpf_get_error(obj->btf_vmlinux);
>   	if (err) {
> -		pr_warn("Error loading vmlinux BTF: %s\n", errstr(err));
> +		pr_warn("Error loading vmlinux BTF: %s\n", libbpf_errstr(err));
>   		obj->btf_vmlinux = NULL;
>   		return err;
>   	}
> @@ -3621,10 +3623,10 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
>   		btf_mandatory = kernel_needs_btf(obj);
>   		if (btf_mandatory) {
>   			pr_warn("Error loading .BTF into kernel: %s. BTF is mandatory, can't proceed.\n",
> -				errstr(err));
> +				libbpf_errstr(err));
>   		} else {
>   			pr_info("Error loading .BTF into kernel: %s. BTF is optional, ignoring.\n",
> -				errstr(err));
> +				libbpf_errstr(err));
>   			err = 0;
>   		}
>   	}
> @@ -4829,7 +4831,7 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
>   	if (!fp) {
>   		err = -errno;
>   		pr_warn("failed to open %s: %s. No procfs support?\n", file,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -4990,7 +4992,7 @@ static int bpf_object_prepare_token(struct bpf_object *obj)
>   	if (bpffs_fd < 0) {
>   		err = -errno;
>   		__pr(level, "object '%s': failed (%s) to open BPF FS mount at '%s'%s\n",
> -		     obj->name, errstr(err), bpffs_path,
> +		     obj->name, libbpf_errstr(err), bpffs_path,
>   		     mandatory ? "" : ", skipping optional step...");
>   		return mandatory ? err : 0;
>   	}
> @@ -5040,7 +5042,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
>   	ret = bump_rlimit_memlock();
>   	if (ret)
>   		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %s), you might need to do it explicitly!\n",
> -			errstr(ret));
> +			libbpf_errstr(ret));
>   
>   	/* make sure basic loading works */
>   	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
> @@ -5049,7 +5051,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
>   	if (ret < 0) {
>   		ret = errno;
>   		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",
> -			__func__, errstr(ret));
> +			__func__, libbpf_errstr(ret));
>   		return -ret;
>   	}
>   	close(ret);
> @@ -5083,7 +5085,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>   		err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
>   	if (err) {
>   		pr_warn("failed to get map info for map FD %d: %s\n", map_fd,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		return false;
>   	}
>   
> @@ -5110,7 +5112,7 @@ bpf_object__reuse_map(struct bpf_map *map)
>   		}
>   
>   		pr_warn("couldn't retrieve pinned map '%s': %s\n",
> -			map->pin_path, errstr(err));
> +			map->pin_path, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -5151,7 +5153,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>   	if (err) {
>   		err = -errno;
>   		pr_warn("map '%s': failed to set initial contents: %s\n",
> -			bpf_map__name(map), errstr(err));
> +			bpf_map__name(map), libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -5161,7 +5163,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>   		if (err) {
>   			err = -errno;
>   			pr_warn("map '%s': failed to freeze as read-only: %s\n",
> -				bpf_map__name(map), errstr(err));
> +				bpf_map__name(map), libbpf_errstr(err));
>   			return err;
>   		}
>   	}
> @@ -5188,7 +5190,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>   		if (mmaped == MAP_FAILED) {
>   			err = -errno;
>   			pr_warn("map '%s': failed to re-mmap() contents: %s\n",
> -				bpf_map__name(map), errstr(err));
> +				bpf_map__name(map), libbpf_errstr(err));
>   			return err;
>   		}
>   		map->mmaped = mmaped;
> @@ -5241,7 +5243,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   			err = bpf_object__create_map(obj, map->inner_map, true);
>   			if (err) {
>   				pr_warn("map '%s': failed to create inner map: %s\n",
> -					map->name, errstr(err));
> +					map->name, libbpf_errstr(err));
>   				return err;
>   			}
>   			map->inner_map_fd = map->inner_map->fd;
> @@ -5297,7 +5299,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
>   		err = -errno;
>   		pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
> -			map->name, errstr(err));
> +			map->name, libbpf_errstr(err));
>   		create_attr.btf_fd = 0;
>   		create_attr.btf_key_type_id = 0;
>   		create_attr.btf_value_type_id = 0;
> @@ -5353,7 +5355,7 @@ static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
>   		if (err) {
>   			err = -errno;
>   			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %s\n",
> -				map->name, i, targ_map->name, fd, errstr(err));
> +				map->name, i, targ_map->name, fd, libbpf_errstr(err));
>   			return err;
>   		}
>   		pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
> @@ -5386,7 +5388,7 @@ static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
>   		if (err) {
>   			err = -errno;
>   			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %s\n",
> -				map->name, i, targ_prog->name, fd, errstr(err));
> +				map->name, i, targ_prog->name, fd, libbpf_errstr(err));
>   			return err;
>   		}
>   		pr_debug("map '%s': slot [%d] set to prog '%s' fd=%d\n",
> @@ -5513,7 +5515,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>   					err = -errno;
>   					map->mmaped = NULL;
>   					pr_warn("map '%s': failed to mmap arena: %s\n",
> -						map->name, errstr(err));
> +						map->name, libbpf_errstr(err));
>   					return err;
>   				}
>   				if (obj->arena_data) {
> @@ -5536,7 +5538,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>   					goto retry;
>   				}
>   				pr_warn("map '%s': failed to auto-pin at '%s': %s\n",
> -					map->name, map->pin_path, errstr(err));
> +					map->name, map->pin_path, libbpf_errstr(err));
>   				goto err_out;
>   			}
>   		}
> @@ -5545,7 +5547,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>   	return 0;
>   
>   err_out:
> -	pr_warn("map '%s': failed to create: %s\n", map->name, errstr(err));
> +	pr_warn("map '%s': failed to create: %s\n", map->name, libbpf_errstr(err));
>   	pr_perm_msg(err);
>   	for (j = 0; j < i; j++)
>   		zclose(obj->maps[j].fd);
> @@ -5669,7 +5671,7 @@ static int load_module_btfs(struct bpf_object *obj)
>   		}
>   		if (err) {
>   			err = -errno;
> -			pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
> +			pr_warn("failed to iterate BTF objects: %s\n", libbpf_errstr(err));
>   			return err;
>   		}
>   
> @@ -5678,7 +5680,7 @@ static int load_module_btfs(struct bpf_object *obj)
>   			if (errno == ENOENT)
>   				continue; /* expected race: BTF was unloaded */
>   			err = -errno;
> -			pr_warn("failed to get BTF object #%d FD: %s\n", id, errstr(err));
> +			pr_warn("failed to get BTF object #%d FD: %s\n", id, libbpf_errstr(err));
>   			return err;
>   		}
>   
> @@ -5690,7 +5692,7 @@ static int load_module_btfs(struct bpf_object *obj)
>   		err = bpf_btf_get_info_by_fd(fd, &info, &len);
>   		if (err) {
>   			err = -errno;
> -			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
> +			pr_warn("failed to get BTF object #%d info: %s\n", id, libbpf_errstr(err));
>   			goto err_out;
>   		}
>   
> @@ -5704,7 +5706,7 @@ static int load_module_btfs(struct bpf_object *obj)
>   		err = libbpf_get_error(btf);
>   		if (err) {
>   			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
> -				name, id, errstr(err));
> +				name, id, libbpf_errstr(err));
>   			goto err_out;
>   		}
>   
> @@ -5933,7 +5935,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
>   		obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
>   		err = libbpf_get_error(obj->btf_vmlinux_override);
>   		if (err) {
> -			pr_warn("failed to parse target BTF: %s\n", errstr(err));
> +			pr_warn("failed to parse target BTF: %s\n", libbpf_errstr(err));
>   			return err;
>   		}
>   	}
> @@ -5994,7 +5996,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
>   			err = record_relo_core(prog, rec, insn_idx);
>   			if (err) {
>   				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
> -					prog->name, i, errstr(err));
> +					prog->name, i, libbpf_errstr(err));
>   				goto out;
>   			}
>   
> @@ -6004,14 +6006,14 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
>   			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
>   			if (err) {
>   				pr_warn("prog '%s': relo #%d: failed to relocate: %s\n",
> -					prog->name, i, errstr(err));
> +					prog->name, i, libbpf_errstr(err));
>   				goto out;
>   			}
>   
>   			err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
>   			if (err) {
>   				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %s\n",
> -					prog->name, i, insn_idx, errstr(err));
> +					prog->name, i, insn_idx, libbpf_errstr(err));
>   				goto out;
>   			}
>   		}
> @@ -6280,7 +6282,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
>   	if (err) {
>   		if (err != -ENOENT) {
>   			pr_warn("prog '%s': error relocating .BTF.ext function info: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   		if (main_prog->func_info) {
> @@ -6308,7 +6310,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
>   	if (err) {
>   		if (err != -ENOENT) {
>   			pr_warn("prog '%s': error relocating .BTF.ext line info: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   		if (main_prog->line_info) {
> @@ -7073,7 +7075,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>   		err = bpf_object__relocate_core(obj, targ_btf_path);
>   		if (err) {
>   			pr_warn("failed to perform CO-RE relocations: %s\n",
> -				errstr(err));
> +				libbpf_errstr(err));
>   			return err;
>   		}
>   		bpf_object__sort_relos(obj);
> @@ -7118,7 +7120,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>   		err = bpf_object__relocate_calls(obj, prog);
>   		if (err) {
>   			pr_warn("prog '%s': failed to relocate calls: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   
> @@ -7155,7 +7157,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>   		err = bpf_object__relocate_data(obj, prog);
>   		if (err) {
>   			pr_warn("prog '%s': failed to relocate data references: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   
> @@ -7163,7 +7165,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
>   		err = bpf_program_fixup_func_info(obj, prog);
>   		if (err) {
>   			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   	}
> @@ -7536,7 +7538,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   		err = prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->sec_def->cookie);
>   		if (err < 0) {
>   			pr_warn("prog '%s': failed to prepare load attributes: %s\n",
> -				prog->name, errstr(err));
> +				prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   		insns = prog->insns;
> @@ -7601,7 +7603,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   
>   				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
>   					pr_warn("prog '%s': failed to bind map '%s': %s\n",
> -						prog->name, map->real_name, errstr(errno));
> +						prog->name, map->real_name, libbpf_errstr(errno));
>   					/* Don't fail hard if can't bind rodata. */
>   				}
>   			}
> @@ -7631,7 +7633,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   	/* post-process verifier log to improve error descriptions */
>   	fixup_verifier_log(prog, log_buf, log_buf_size);
>   
> -	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, errstr(errno));
> +	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, libbpf_errstr(errno));
>   	pr_perm_msg(ret);
>   
>   	if (own_log_buf && log_buf && log_buf[0] != '\0') {
> @@ -7917,7 +7919,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
>   		err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
>   					   obj->license, obj->kern_version, &prog->fd);
>   		if (err) {
> -			pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
> +			pr_warn("prog '%s': failed to load: %s\n", prog->name, libbpf_errstr(err));
>   			return err;
>   		}
>   	}
> @@ -7967,7 +7969,7 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
>   			err = prog->sec_def->prog_setup_fn(prog, prog->sec_def->cookie);
>   			if (err < 0) {
>   				pr_warn("prog '%s': failed to initialize: %s\n",
> -					prog->name, errstr(err));
> +					prog->name, libbpf_errstr(err));
>   				return err;
>   			}
>   		}
> @@ -8156,7 +8158,7 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>   	f = fopen("/proc/kallsyms", "re");
>   	if (!f) {
>   		err = -errno;
> -		pr_warn("failed to open /proc/kallsyms: %s\n", errstr(err));
> +		pr_warn("failed to open /proc/kallsyms: %s\n", libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -8697,7 +8699,7 @@ static int make_parent_dir(const char *path)
>   
>   	free(dname);
>   	if (err) {
> -		pr_warn("failed to mkdir %s: %s\n", path, errstr(err));
> +		pr_warn("failed to mkdir %s: %s\n", path, libbpf_errstr(err));
>   	}
>   	return err;
>   }
> @@ -8717,7 +8719,7 @@ static int check_path(const char *path)
>   
>   	dir = dirname(dname);
>   	if (statfs(dir, &st_fs)) {
> -		pr_warn("failed to statfs %s: %s\n", dir, errstr(errno));
> +		pr_warn("failed to statfs %s: %s\n", dir, libbpf_errstr(errno));
>   		err = -errno;
>   	}
>   	free(dname);
> @@ -8749,7 +8751,8 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
>   
>   	if (bpf_obj_pin(prog->fd, path)) {
>   		err = -errno;
> -		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, errstr(err));
> +		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path,
> +			libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -8838,7 +8841,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
>   	return 0;
>   
>   out_err:
> -	pr_warn("failed to pin map: %s\n", errstr(err));
> +	pr_warn("failed to pin map: %s\n", libbpf_errstr(err));
>   	return libbpf_err(err);
>   }
>   
> @@ -10035,7 +10038,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
>   	err = bpf_prog_get_info_by_fd(attach_prog_fd, &info, &info_len);
>   	if (err) {
>   		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %s\n",
> -			attach_prog_fd, errstr(err));
> +			attach_prog_fd, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -10047,7 +10050,8 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
>   	btf = btf_load_from_kernel(info.btf_id, NULL, token_fd);
>   	err = libbpf_get_error(btf);
>   	if (err) {
> -		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
> +		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id,
> +			libbpf_errstr(err));
>   		goto out;
>   	}
>   	err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> @@ -10130,7 +10134,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
>   		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd, prog->obj->token_fd);
>   		if (err < 0) {
>   			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
> -				prog->name, attach_prog_fd, attach_name, errstr(err));
> +				prog->name, attach_prog_fd, attach_name, libbpf_errstr(err));
>   			return err;
>   		}
>   		*btf_obj_fd = 0;
> @@ -10150,7 +10154,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
>   	}
>   	if (err) {
>   		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
> -			prog->name, attach_name, errstr(err));
> +			prog->name, attach_name, libbpf_errstr(err));
>   		return err;
>   	}
>   	return 0;
> @@ -10379,13 +10383,13 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>   		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
>   		if (err) {
>   			pr_warn("map '%s': failed to resize memory-mapped region: %s\n",
> -				bpf_map__name(map), errstr(err));
> +				bpf_map__name(map), libbpf_errstr(err));
>   			return libbpf_err(err);
>   		}
>   		err = map_btf_datasec_resize(map, size);
>   		if (err && err != -ENOENT) {
>   			pr_warn("map '%s': failed to adjust resized BTF, clearing BTF key/value info: %s\n",
> -				bpf_map__name(map), errstr(err));
> +				bpf_map__name(map), libbpf_errstr(err));
>   			map->btf_value_type_id = 0;
>   			map->btf_key_type_id = 0;
>   		}
> @@ -10911,7 +10915,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>   		if (link_fd < 0) {
>   			err = -errno;
>   			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %s\n",
> -				prog->name, pfd, errstr(err));
> +				prog->name, pfd, libbpf_errstr(err));
>   			goto err_out;
>   		}
>   		link->link.fd = link_fd;
> @@ -10925,7 +10929,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>   		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
>   			err = -errno;
>   			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
> -				prog->name, pfd, errstr(err));
> +				prog->name, pfd, libbpf_errstr(err));
>   			if (err == -EPROTO)
>   				pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n",
>   					prog->name, pfd);
> @@ -10936,7 +10940,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>   	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
>   		err = -errno;
>   		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
> -			prog->name, pfd, errstr(err));
> +			prog->name, pfd, libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> @@ -10966,13 +10970,13 @@ static int parse_uint_from_file(const char *file, const char *fmt)
>   	f = fopen(file, "re");
>   	if (!f) {
>   		err = -errno;
> -		pr_debug("failed to open '%s': %s\n", file, errstr(err));
> +		pr_debug("failed to open '%s': %s\n", file, libbpf_errstr(err));
>   		return err;
>   	}
>   	err = fscanf(f, fmt, &ret);
>   	if (err != 1) {
>   		err = err == EOF ? -EIO : -errno;
> -		pr_debug("failed to parse '%s': %s\n", file, errstr(err));
> +		pr_debug("failed to parse '%s': %s\n", file, libbpf_errstr(err));
>   		fclose(f);
>   		return err;
>   	}
> @@ -11028,7 +11032,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>   	if (type < 0) {
>   		pr_warn("failed to determine %s perf type: %s\n",
>   			uprobe ? "uprobe" : "kprobe",
> -			errstr(type));
> +			libbpf_errstr(type));
>   		return type;
>   	}
>   	if (retprobe) {
> @@ -11038,7 +11042,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>   		if (bit < 0) {
>   			pr_warn("failed to determine %s retprobe bit: %s\n",
>   				uprobe ? "uprobe" : "kprobe",
> -				errstr(bit));
> +				libbpf_errstr(bit));
>   			return bit;
>   		}
>   		attr.config |= 1 << bit;
> @@ -11173,7 +11177,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
>   	if (err < 0) {
>   		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
>   			kfunc_name, offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		return err;
>   	}
>   	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
> @@ -11181,7 +11185,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
>   		err = type;
>   		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
>   			kfunc_name, offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   
> @@ -11197,7 +11201,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
>   	if (pfd < 0) {
>   		err = -errno;
>   		pr_warn("legacy kprobe perf_event_open() failed: %s\n",
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   	return pfd;
> @@ -11330,7 +11334,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>   		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
>   			prog->name, retprobe ? "kretprobe" : "kprobe",
>   			func_name, offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_out;
>   	}
>   	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
> @@ -11340,7 +11344,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>   		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
>   			prog->name, retprobe ? "kretprobe" : "kprobe",
>   			func_name, offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   	if (legacy) {
> @@ -11500,7 +11504,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
>   	f = fopen(available_functions_file, "re");
>   	if (!f) {
>   		err = -errno;
> -		pr_warn("failed to open %s: %s\n", available_functions_file, errstr(err));
> +		pr_warn("failed to open %s: %s\n", available_functions_file, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -11575,7 +11579,7 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
>   	f = fopen(available_path, "re");
>   	if (!f) {
>   		err = -errno;
> -		pr_warn("failed to open %s: %s\n", available_path, errstr(err));
> +		pr_warn("failed to open %s: %s\n", available_path, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -11699,7 +11703,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>   	if (link_fd < 0) {
>   		err = -errno;
>   		pr_warn("prog '%s': failed to attach: %s\n",
> -			prog->name, errstr(err));
> +			prog->name, libbpf_errstr(err));
>   		goto error;
>   	}
>   	link->fd = link_fd;
> @@ -11909,14 +11913,14 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
>   	err = add_uprobe_event_legacy(probe_name, retprobe, binary_path, offset);
>   	if (err < 0) {
>   		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %s\n",
> -			binary_path, (size_t)offset, errstr(err));
> +			binary_path, (size_t)offset, libbpf_errstr(err));
>   		return err;
>   	}
>   	type = determine_uprobe_perf_type_legacy(probe_name, retprobe);
>   	if (type < 0) {
>   		err = type;
>   		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %s\n",
> -			binary_path, offset, errstr(err));
> +			binary_path, offset, libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   
> @@ -11931,7 +11935,7 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
>   		      -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
>   	if (pfd < 0) {
>   		err = -errno;
> -		pr_warn("legacy uprobe perf_event_open() failed: %s\n", errstr(err));
> +		pr_warn("legacy uprobe perf_event_open() failed: %s\n", libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   	return pfd;
> @@ -12156,7 +12160,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
>   			err = resolve_full_path(path, full_path, sizeof(full_path));
>   			if (err) {
>   				pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
> -					prog->name, path, errstr(err));
> +					prog->name, path, libbpf_errstr(err));
>   				return libbpf_err_ptr(err);
>   			}
>   			path = full_path;
> @@ -12199,7 +12203,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
>   	if (link_fd < 0) {
>   		err = -errno;
>   		pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
> -			prog->name, errstr(err));
> +			prog->name, libbpf_errstr(err));
>   		goto error;
>   	}
>   	link->fd = link_fd;
> @@ -12251,7 +12255,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>   		err = resolve_full_path(binary_path, full_path, sizeof(full_path));
>   		if (err) {
>   			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
> -				prog->name, binary_path, errstr(err));
> +				prog->name, binary_path, libbpf_errstr(err));
>   			return libbpf_err_ptr(err);
>   		}
>   		binary_path = full_path;
> @@ -12317,7 +12321,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>   		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
>   			prog->name, retprobe ? "uretprobe" : "uprobe",
>   			binary_path, func_offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> @@ -12328,7 +12332,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>   		pr_warn("prog '%s': failed to attach to %s '%s:0x%zx': %s\n",
>   			prog->name, retprobe ? "uretprobe" : "uprobe",
>   			binary_path, func_offset,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto err_clean_legacy;
>   	}
>   	if (legacy) {
> @@ -12450,7 +12454,7 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>   		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>   		if (err) {
>   			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
> -				prog->name, binary_path, errstr(err));
> +				prog->name, binary_path, libbpf_errstr(err));
>   			return libbpf_err_ptr(err);
>   		}
>   		binary_path = resolved_path;
> @@ -12534,7 +12538,7 @@ static int perf_event_open_tracepoint(const char *tp_category,
>   	if (tp_id < 0) {
>   		pr_warn("failed to determine tracepoint '%s/%s' perf event ID: %s\n",
>   			tp_category, tp_name,
> -			errstr(tp_id));
> +			libbpf_errstr(tp_id));
>   		return tp_id;
>   	}
>   
> @@ -12549,7 +12553,7 @@ static int perf_event_open_tracepoint(const char *tp_category,
>   		err = -errno;
>   		pr_warn("tracepoint '%s/%s' perf_event_open() failed: %s\n",
>   			tp_category, tp_name,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		return err;
>   	}
>   	return pfd;
> @@ -12573,7 +12577,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
>   	if (pfd < 0) {
>   		pr_warn("prog '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
>   			prog->name, tp_category, tp_name,
> -			errstr(pfd));
> +			libbpf_errstr(pfd));
>   		return libbpf_err_ptr(pfd);
>   	}
>   	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
> @@ -12582,7 +12586,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
>   		close(pfd);
>   		pr_warn("prog '%s': failed to attach to tracepoint '%s/%s': %s\n",
>   			prog->name, tp_category, tp_name,
> -			errstr(err));
> +			libbpf_errstr(err));
>   		return libbpf_err_ptr(err);
>   	}
>   	return link;
> @@ -12657,7 +12661,7 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
>   		pfd = -errno;
>   		free(link);
>   		pr_warn("prog '%s': failed to attach to raw tracepoint '%s': %s\n",
> -			prog->name, tp_name, errstr(pfd));
> +			prog->name, tp_name, libbpf_errstr(pfd));
>   		return libbpf_err_ptr(pfd);
>   	}
>   	link->fd = pfd;
> @@ -12740,7 +12744,7 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
>   		pfd = -errno;
>   		free(link);
>   		pr_warn("prog '%s': failed to attach: %s\n",
> -			prog->name, errstr(pfd));
> +			prog->name, libbpf_errstr(pfd));
>   		return libbpf_err_ptr(pfd);
>   	}
>   	link->fd = pfd;
> @@ -12802,7 +12806,7 @@ bpf_program_attach_fd(const struct bpf_program *prog,
>   		free(link);
>   		pr_warn("prog '%s': failed to attach to %s: %s\n",
>   			prog->name, target_name,
> -			errstr(link_fd));
> +			libbpf_errstr(link_fd));
>   		return libbpf_err_ptr(link_fd);
>   	}
>   	link->fd = link_fd;
> @@ -12971,7 +12975,7 @@ bpf_program__attach_iter(const struct bpf_program *prog,
>   		link_fd = -errno;
>   		free(link);
>   		pr_warn("prog '%s': failed to attach to iterator: %s\n",
> -			prog->name, errstr(link_fd));
> +			prog->name, libbpf_errstr(link_fd));
>   		return libbpf_err_ptr(link_fd);
>   	}
>   	link->fd = link_fd;
> @@ -13016,7 +13020,7 @@ struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program *prog,
>   		link_fd = -errno;
>   		free(link);
>   		pr_warn("prog '%s': failed to attach to netfilter: %s\n",
> -			prog->name, errstr(link_fd));
> +			prog->name, libbpf_errstr(link_fd));
>   		return libbpf_err_ptr(link_fd);
>   	}
>   	link->fd = link_fd;
> @@ -13316,7 +13320,7 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
>   	if (cpu_buf->fd < 0) {
>   		err = -errno;
>   		pr_warn("failed to open perf buffer event on cpu #%d: %s\n",
> -			cpu, errstr(err));
> +			cpu, libbpf_errstr(err));
>   		goto error;
>   	}
>   
> @@ -13327,14 +13331,14 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
>   		cpu_buf->base = NULL;
>   		err = -errno;
>   		pr_warn("failed to mmap perf buffer on cpu #%d: %s\n",
> -			cpu, errstr(err));
> +			cpu, libbpf_errstr(err));
>   		goto error;
>   	}
>   
>   	if (ioctl(cpu_buf->fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
>   		err = -errno;
>   		pr_warn("failed to enable perf buffer event on cpu #%d: %s\n",
> -			cpu, errstr(err));
> +			cpu, libbpf_errstr(err));
>   		goto error;
>   	}
>   
> @@ -13432,7 +13436,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
>   		 */
>   		if (err != -EINVAL) {
>   			pr_warn("failed to get map info for map FD %d: %s\n",
> -				map_fd, errstr(err));
> +				map_fd, libbpf_errstr(err));
>   			return ERR_PTR(err);
>   		}
>   		pr_debug("failed to get map info for FD %d; API not supported? Ignoring...\n",
> @@ -13462,7 +13466,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
>   	if (pb->epoll_fd < 0) {
>   		err = -errno;
>   		pr_warn("failed to create epoll instance: %s\n",
> -			errstr(err));
> +			libbpf_errstr(err));
>   		goto error;
>   	}
>   
> @@ -13493,7 +13497,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
>   
>   	err = parse_cpu_mask_file(online_cpus_file, &online, &n);
>   	if (err) {
> -		pr_warn("failed to get online CPU mask: %s\n", errstr(err));
> +		pr_warn("failed to get online CPU mask: %s\n", libbpf_errstr(err));
>   		goto error;
>   	}
>   
> @@ -13524,7 +13528,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
>   			err = -errno;
>   			pr_warn("failed to set cpu #%d, key %d -> perf FD %d: %s\n",
>   				cpu, map_key, cpu_buf->fd,
> -				errstr(err));
> +				libbpf_errstr(err));
>   			goto error;
>   		}
>   
> @@ -13535,7 +13539,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
>   			err = -errno;
>   			pr_warn("failed to epoll_ctl cpu #%d perf FD %d: %s\n",
>   				cpu, cpu_buf->fd,
> -				errstr(err));
> +				libbpf_errstr(err));
>   			goto error;
>   		}
>   		j++;
> @@ -13630,7 +13634,7 @@ int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms)
>   
>   		err = perf_buffer__process_records(pb, cpu_buf);
>   		if (err) {
> -			pr_warn("error while processing records: %s\n", errstr(err));
> +			pr_warn("error while processing records: %s\n", libbpf_errstr(err));
>   			return libbpf_err(err);
>   		}
>   	}
> @@ -13715,7 +13719,7 @@ int perf_buffer__consume(struct perf_buffer *pb)
>   		err = perf_buffer__process_records(pb, cpu_buf);
>   		if (err) {
>   			pr_warn("perf_buffer: failed to process records in buffer #%d: %s\n",
> -				i, errstr(err));
> +				i, libbpf_errstr(err));
>   			return libbpf_err(err);
>   		}
>   	}
> @@ -13826,14 +13830,14 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
>   	fd = open(fcpu, O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
>   		err = -errno;
> -		pr_warn("Failed to open cpu mask file %s: %s\n", fcpu, errstr(err));
> +		pr_warn("Failed to open cpu mask file %s: %s\n", fcpu, libbpf_errstr(err));
>   		return err;
>   	}
>   	len = read(fd, buf, sizeof(buf));
>   	close(fd);
>   	if (len <= 0) {
>   		err = len ? -errno : -EINVAL;
> -		pr_warn("Failed to read cpu mask from %s: %s\n", fcpu, errstr(err));
> +		pr_warn("Failed to read cpu mask from %s: %s\n", fcpu, libbpf_errstr(err));
>   		return err;
>   	}
>   	if (len >= sizeof(buf)) {
> @@ -13926,20 +13930,22 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
>   	if (IS_ERR(obj)) {
>   		err = PTR_ERR(obj);
>   		pr_warn("failed to initialize skeleton BPF object '%s': %s\n",
> -			s->name, errstr(err));
> +			s->name, libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
>   	*s->obj = obj;
>   	err = populate_skeleton_maps(obj, s->maps, s->map_cnt, s->map_skel_sz);
>   	if (err) {
> -		pr_warn("failed to populate skeleton maps for '%s': %s\n", s->name, errstr(err));
> +		pr_warn("failed to populate skeleton maps for '%s': %s\n", s->name,
> +			libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
>   	err = populate_skeleton_progs(obj, s->progs, s->prog_cnt, s->prog_skel_sz);
>   	if (err) {
> -		pr_warn("failed to populate skeleton progs for '%s': %s\n", s->name, errstr(err));
> +		pr_warn("failed to populate skeleton progs for '%s': %s\n", s->name,
> +			libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -13969,13 +13975,13 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
>   
>   	err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt, s->map_skel_sz);
>   	if (err) {
> -		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
> +		pr_warn("failed to populate subskeleton maps: %s\n", libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
>   	err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt, s->prog_skel_sz);
>   	if (err) {
> -		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
> +		pr_warn("failed to populate subskeleton maps: %s\n", libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -14022,7 +14028,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
>   
>   	err = bpf_object__load(*s->obj);
>   	if (err) {
> -		pr_warn("failed to load BPF skeleton '%s': %s\n", s->name, errstr(err));
> +		pr_warn("failed to load BPF skeleton '%s': %s\n", s->name, libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -14062,7 +14068,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
>   		err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, link);
>   		if (err) {
>   			pr_warn("prog '%s': failed to auto-attach: %s\n",
> -				bpf_program__name(prog), errstr(err));
> +				bpf_program__name(prog), libbpf_errstr(err));
>   			return libbpf_err(err);
>   		}
>   
> @@ -14106,7 +14112,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
>   		if (!*link) {
>   			err = -errno;
>   			pr_warn("map '%s': failed to auto-attach: %s\n",
> -				bpf_map__name(map), errstr(err));
> +				bpf_map__name(map), libbpf_errstr(err));
>   			return libbpf_err(err);
>   		}
>   	}
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 800e0ef09c37..6ad79b18ef58 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -530,7 +530,7 @@ int bpf_linker__add_file(struct bpf_linker *linker, const char *filename,
>   	fd = open(filename, O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
>   		err = -errno;
> -		pr_warn("failed to open file '%s': %s\n", filename, errstr(err));
> +		pr_warn("failed to open file '%s': %s\n", filename, libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -576,7 +576,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
>   	fd = memfd_create(filename, 0);
>   	if (fd < 0) {
>   		ret = -errno;
> -		pr_warn("failed to create memfd '%s': %s\n", filename, errstr(ret));
> +		pr_warn("failed to create memfd '%s': %s\n", filename, libbpf_errstr(ret));
>   		return libbpf_err(ret);
>   	}
>   
> @@ -585,7 +585,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
>   		ret = write(fd, buf, buf_sz);
>   		if (ret < 0) {
>   			ret = -errno;
> -			pr_warn("failed to write '%s': %s\n", filename, errstr(ret));
> +			pr_warn("failed to write '%s': %s\n", filename, libbpf_errstr(ret));
>   			goto err_out;
>   		}
>   		written += ret;
> @@ -785,7 +785,7 @@ static int linker_load_obj_file(struct bpf_linker *linker,
>   				err = libbpf_get_error(obj->btf);
>   				if (err) {
>   					pr_warn("failed to parse .BTF from %s: %s\n",
> -						obj->filename, errstr(err));
> +						obj->filename, libbpf_errstr(err));
>   					return err;
>   				}
>   				sec->skipped = true;
> @@ -796,7 +796,7 @@ static int linker_load_obj_file(struct bpf_linker *linker,
>   				err = libbpf_get_error(obj->btf_ext);
>   				if (err) {
>   					pr_warn("failed to parse .BTF.ext from '%s': %s\n",
> -						obj->filename, errstr(err));
> +						obj->filename, libbpf_errstr(err));
>   					return err;
>   				}
>   				sec->skipped = true;
> @@ -2891,14 +2891,14 @@ static int finalize_btf(struct bpf_linker *linker)
>   
>   	err = finalize_btf_ext(linker);
>   	if (err) {
> -		pr_warn(".BTF.ext generation failed: %s\n", errstr(err));
> +		pr_warn(".BTF.ext generation failed: %s\n", libbpf_errstr(err));
>   		return err;
>   	}
>   
>   	opts.btf_ext = linker->btf_ext;
>   	err = btf__dedup(linker->btf, &opts);
>   	if (err) {
> -		pr_warn("BTF dedup failed: %s\n", errstr(err));
> +		pr_warn("BTF dedup failed: %s\n", libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -2916,7 +2916,7 @@ static int finalize_btf(struct bpf_linker *linker)
>   
>   	err = emit_elf_data_sec(linker, BTF_ELF_SEC, 8, raw_data, raw_sz);
>   	if (err) {
> -		pr_warn("failed to write out .BTF ELF section: %s\n", errstr(err));
> +		pr_warn("failed to write out .BTF ELF section: %s\n", libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -2928,7 +2928,8 @@ static int finalize_btf(struct bpf_linker *linker)
>   
>   		err = emit_elf_data_sec(linker, BTF_EXT_ELF_SEC, 8, raw_data, raw_sz);
>   		if (err) {
> -			pr_warn("failed to write out .BTF.ext ELF section: %s\n", errstr(err));
> +			pr_warn("failed to write out .BTF.ext ELF section: %s\n",
> +				libbpf_errstr(err));
>   			return err;
>   		}
>   	}
> @@ -3104,7 +3105,7 @@ static int finalize_btf_ext(struct bpf_linker *linker)
>   	err = libbpf_get_error(linker->btf_ext);
>   	if (err) {
>   		linker->btf_ext = NULL;
> -		pr_warn("failed to parse final .BTF.ext data: %s\n", errstr(err));
> +		pr_warn("failed to parse final .BTF.ext data: %s\n", libbpf_errstr(err));
>   		goto out;
>   	}
>   
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 9702b70da444..2ea03b35a3ef 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -90,7 +90,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   	if (err) {
>   		err = -errno;
>   		pr_warn("ringbuf: failed to get map info for fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		return libbpf_err(err);
>   	}
>   
> @@ -125,7 +125,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   	if (tmp == MAP_FAILED) {
>   		err = -errno;
>   		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		goto err_out;
>   	}
>   	r->consumer_pos = tmp;
> @@ -144,7 +144,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   	if (tmp == MAP_FAILED) {
>   		err = -errno;
>   		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		goto err_out;
>   	}
>   	r->producer_pos = tmp;
> @@ -158,7 +158,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
>   		err = -errno;
>   		pr_warn("ringbuf: failed to epoll add map fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> @@ -206,7 +206,7 @@ ring_buffer__new(int map_fd, ring_buffer_sample_fn sample_cb, void *ctx,
>   	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
>   	if (rb->epoll_fd < 0) {
>   		err = -errno;
> -		pr_warn("ringbuf: failed to create epoll instance: %s\n", errstr(err));
> +		pr_warn("ringbuf: failed to create epoll instance: %s\n", libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> @@ -460,7 +460,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>   	if (err) {
>   		err = -errno;
>   		pr_warn("user ringbuf: failed to get map info for fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -477,7 +477,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>   	if (tmp == MAP_FAILED) {
>   		err = -errno;
>   		pr_warn("user ringbuf: failed to mmap consumer page for map fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		return err;
>   	}
>   	rb->consumer_pos = tmp;
> @@ -497,7 +497,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>   	if (tmp == MAP_FAILED) {
>   		err = -errno;
>   		pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %s\n",
> -			map_fd, errstr(err));
> +			map_fd, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -508,7 +508,8 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
>   	rb_epoll->events = EPOLLOUT;
>   	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
>   		err = -errno;
> -		pr_warn("user ringbuf: failed to epoll add map fd=%d: %s\n", map_fd, errstr(err));
> +		pr_warn("user ringbuf: failed to epoll add map fd=%d: %s\n", map_fd,
> +			libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -533,7 +534,7 @@ user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts)
>   	rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
>   	if (rb->epoll_fd < 0) {
>   		err = -errno;
> -		pr_warn("user ringbuf: failed to create epoll instance: %s\n", errstr(err));
> +		pr_warn("user ringbuf: failed to create epoll instance: %s\n", libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
> index 8743049e32b7..9a541762f54c 100644
> --- a/tools/lib/bpf/str_error.c
> +++ b/tools/lib/bpf/str_error.c
> @@ -36,7 +36,7 @@ char *libbpf_strerror_r(int err, char *dst, int len)
>   	return dst;
>   }
>   
> -const char *errstr(int err)
> +const char *libbpf_errstr(int err)
>   {
>   	static __thread char buf[12];
>   
> diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
> index 66ffebde0684..2f7725072c5c 100644
> --- a/tools/lib/bpf/str_error.h
> +++ b/tools/lib/bpf/str_error.h
> @@ -7,10 +7,10 @@
>   char *libbpf_strerror_r(int err, char *dst, int len);
>   
>   /**
> - * @brief **errstr()** returns string corresponding to numeric errno
> + * @brief **libbpf_errstr()** returns string corresponding to numeric errno
>    * @param err negative numeric errno
>    * @return pointer to string representation of the errno, that is invalidated
>    * upon the next call.
>    */
> -const char *errstr(int err);
> +const char *libbpf_errstr(int err);
>   #endif /* __LIBBPF_STR_ERROR_H */
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 4e4a52742b01..c91a7b3af2d3 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -467,7 +467,7 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
>   
>   	if (!realpath(lib_path, path)) {
>   		pr_warn("usdt: failed to get absolute path of '%s' (err %s), using path as is...\n",
> -			lib_path, errstr(-errno));
> +			lib_path, libbpf_errstr(-errno));
>   		libbpf_strlcpy(path, lib_path, sizeof(path));
>   	}
>   
> @@ -477,7 +477,7 @@ static int parse_vma_segs(int pid, const char *lib_path, struct elf_seg **segs,
>   	if (!f) {
>   		err = -errno;
>   		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %s\n",
> -			line, lib_path, errstr(err));
> +			line, lib_path, libbpf_errstr(err));
>   		return err;
>   	}
>   
> @@ -608,7 +608,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
>   	err = parse_elf_segs(elf, path, &segs, &seg_cnt);
>   	if (err) {
>   		pr_warn("usdt: failed to process ELF program segments for '%s': %s\n",
> -			path, errstr(err));
> +			path, libbpf_errstr(err));
>   		goto err_out;
>   	}
>   
> @@ -711,7 +711,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
>   				err = parse_vma_segs(pid, path, &vma_segs, &vma_seg_cnt);
>   				if (err) {
>   					pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %s\n",
> -						pid, path, errstr(err));
> +						pid, path, libbpf_errstr(err));
>   					goto err_out;
>   				}
>   			}
> @@ -1050,7 +1050,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
>   		if (is_new && bpf_map_update_elem(spec_map_fd, &spec_id, &target->spec, BPF_ANY)) {
>   			err = -errno;
>   			pr_warn("usdt: failed to set USDT spec #%d for '%s:%s' in '%s': %s\n",
> -				spec_id, usdt_provider, usdt_name, path, errstr(err));
> +				spec_id, usdt_provider, usdt_name, path, libbpf_errstr(err));
>   			goto err_out;
>   		}
>   		if (!man->has_bpf_cookie &&
> @@ -1062,7 +1062,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
>   			} else {
>   				pr_warn("usdt: failed to map IP 0x%lx to spec #%d for '%s:%s' in '%s': %s\n",
>   					target->abs_ip, spec_id, usdt_provider, usdt_name,
> -					path, errstr(err));
> +					path, libbpf_errstr(err));
>   			}
>   			goto err_out;
>   		}
> @@ -1079,7 +1079,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
>   			err = libbpf_get_error(uprobe_link);
>   			if (err) {
>   				pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %s\n",
> -					i, usdt_provider, usdt_name, path, errstr(err));
> +					i, usdt_provider, usdt_name, path, libbpf_errstr(err));
>   				goto err_out;
>   			}
>   
> @@ -1102,7 +1102,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
>   		if (!link->multi_link) {
>   			err = -errno;
>   			pr_warn("usdt: failed to attach uprobe multi for '%s:%s' in '%s': %s\n",
> -				usdt_provider, usdt_name, path, errstr(err));
> +				usdt_provider, usdt_name, path, libbpf_errstr(err));
>   			goto err_out;
>   		}
>   
Thanks for the patch. Looks good.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>



