Return-Path: <bpf+bounces-70243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE2BB571A
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29213C05B0
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042C28850E;
	Thu,  2 Oct 2025 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zico77ih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633B283130
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438898; cv=none; b=PYu70mAtHTibXHcY/F6QpkLOjyDvAQAcfrfX4+kpesjCSeOY4KsQC3aM5JsX4BuGWAVlNBLWwOwM3UL05SStS03tFZyN8V2XzWXCXf9TK4jRucOslIxTY902370rsYE9dPa1+SWkFafMBc27Lw5FaAZaXFSaNs1yK1yDb0ADcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438898; c=relaxed/simple;
	bh=6wd4T83ZSg2IkaiVsvtLg4znY01NlnqYMmR7roEBunQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlxoM2R3qN7c1vdr/kTGkryYidS2si9ZhxocP1oYyMhapITjLlq3jsmTT2e0D/8UitYqAeuohoAoRmOs/rmj527JD9zXW8sDJP3Nl5H2n+RkWe+3Vs9YFnhMN1eiG8FiSpA7ByRqeDWZ7AI0+tYIsubcDC4CFvMs3gfYFaYqMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zico77ih; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78115430134so1103903b3a.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438895; x=1760043695; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfFMAG3RbEzVyFjAyHkruUXOyp/Oj6fhsnvgB06D76A=;
        b=Zico77ih0+XrOk12PnNtBff6wAu0sv2SHbEhGvkl2pVSWkhnFH95xwkqbnb7NyvuXk
         YCR4DwDtGoojOk43gxhERz9xojAeAVlQ+qkjO2/vKXO396pxzTlMKsKPu7BWhihPWi8K
         QKdyzeGENMj5abVqWwaW7dF5Tk9Uh4y6STxe79oE7ErfXzD0qmNtVytRdbejCehL4Eiz
         Y8cdxq5vlCn4AK2WHQv/9e9zZSFPVwmVbHMzfSA4WfXtgmK5w5/ixCfW1G9aGHlKf3a/
         JBDzJAMiJ/UlzKujQUQ3ZI8YzTr3lHXcrXBDpsiB8lRsAE0DIg9s+T7pd7hAcIzP5d6n
         fsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438895; x=1760043695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfFMAG3RbEzVyFjAyHkruUXOyp/Oj6fhsnvgB06D76A=;
        b=Kb+KlENUwQeCbeTD8UBa562MWb0J1qfZ20ifQdMe6kusy7gBZqntiw27XeTOKCHYDv
         2zUwzlUYtI0/W2I+NteDfgsXr0kqMGApHxAzlMToq1FwQRfqcWMlaK1fBaY6N3Nh0Pez
         czRA5t7u4gU0+XQRtlYDEGWuNefwCXtYJCJW1G8jXncrySZt/8xtbHpVhnrb4OJ54i11
         fz0xmFMXMxXko/Hxy+yxNjmyBBYVdpzFOtkeU6HcaQHvw+MEnbb6BZ5QZuaUjPhY9MQU
         kdmSDQtoq/OhczuYc8tURffD5/ns+mbfCgf9hLIH/krJqJnVJEOXZWfHvJciNI9NrkXu
         EXZA==
X-Forwarded-Encrypted: i=1; AJvYcCULoh6s/UoWfJs5OY/1UxyzNGfVFbJo5GY2IHfvdh4Du0g5QXkksADsAVSNKbcHzO50vbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvacYioyz9fnhwO7v8i2FU4Dr8T3IzVv9VpPNWB8IWdqhSFs7L
	o8tZos4WDiClNCFvwgRXZfu/aY+7RQFtb4elJ4MDGNkdHGT3YfryBXBZ
X-Gm-Gg: ASbGncu5a+YvFuDTHhYFsxjPNtx/LQ0XoLOwFlShucQUMk4pbsFdqVCM22dJjW5LqeF
	i93nya/pr6nX28FWQE/8coayE275ZpuOLaGmQ+myrWAAo4voqVwR8LKjXePOssBxVsBNXGuxupR
	SFVFpyQAJhpoqLI63JjlAwgLPDYPYp+QFl9O3goabMHS5JByjcoN2qqnfY1qhDob9OqNWWKBIJV
	GOEsx5ma0rEHc5qfSlVZug7O/x3vwXQ4enHVa/pF2PDpva68FCmQHHDeM2KqVNiQQZmAKA6fU2F
	eMRz8DRCn8dwDSBKjLnVyDuw1vb0Nh+1TucmtaB8lAHPFXBtnl2I2RLQvAHHtNIsFcbqqKH8Anl
	oEf9xrUQ3OoF83jFv/33a3xywu2yHdgY7QjBI6/0YGmz9
X-Google-Smtp-Source: AGHT+IF7blsyLeEhbspDkd9skIsR8bmrNZyeSpwLNlDwzGcuKexNIGgr6AWJrYy4+wXI+BBu5fONvw==
X-Received: by 2002:a05:6a00:13a5:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-78c98a40a56mr889110b3a.3.1759438895289;
        Thu, 02 Oct 2025 14:01:35 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02073d00sm2945448b3a.77.2025.10.02.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:01:34 -0700 (PDT)
Message-ID: <b5fd31c3e703c8c84c6710f5536510fbce04b36f.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 13/15] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 14:01:32 -0700
In-Reply-To: <20250930125111.1269861-14-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-14-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> For v5 instruction set LLVM is allowed to generate indirect jumps for
> switch statements and for 'goto *rX' assembly. Every such a jump will
> be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
>=20
>        0:       r2 =3D 0x0 ll
>                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>=20
> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>=20
>     Symbol table:
>        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>=20
> The -bpf-min-jump-table-entries llvm option may be used to control the
> minimal size of a switch which will be converted to an indirect jumps.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

I think structurally this is fine.
Left a few nitpicks below.

>  tools/lib/bpf/libbpf.c        | 221 +++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_probes.c |   4 +
>  tools/lib/bpf/linker.c        |  10 +-
>  3 files changed, 232 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 083ec3ca4813..b6fbba1a42d5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -192,6 +192,7 @@ static const char * const map_type_name[] =3D {
>  	[BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
>  	[BPF_MAP_TYPE_CGRP_STORAGE]		=3D "cgrp_storage",
>  	[BPF_MAP_TYPE_ARENA]			=3D "arena",
> +	[BPF_MAP_TYPE_INSN_ARRAY]		=3D "insn_array",
>  };
> =20
>  static const char * const prog_type_name[] =3D {
> @@ -373,6 +374,7 @@ enum reloc_type {
>  	RELO_EXTERN_CALL,
>  	RELO_SUBPROG_ADDR,
>  	RELO_CORE,
> +	RELO_INSN_ARRAY,
>  };
> =20
>  struct reloc_desc {
> @@ -383,7 +385,10 @@ struct reloc_desc {
>  		struct {
>  			int map_idx;
>  			int sym_off;
> -			int ext_idx;
> +			union {
> +				int ext_idx;
> +				int sym_size;

Nit: maybe add a comment, stating when each alternative is active?

> +			};
>  		};
>  	};
>  };
> @@ -425,6 +430,11 @@ struct bpf_sec_def {
>  	libbpf_prog_attach_fn_t prog_attach_fn;
>  };
> =20
> +struct bpf_light_subprog {
> +	__u32 sec_insn_off;
> +	__u32 sub_insn_off;
> +};
> +
>  /*
>   * bpf_prog should be a better name but it has been used in
>   * linux/filter.h.
> @@ -498,6 +508,9 @@ struct bpf_program {
>  	__u32 line_info_cnt;
>  	__u32 prog_flags;
>  	__u8  hash[SHA256_DIGEST_LENGTH];
> +
> +	struct bpf_light_subprog *subprogs;
> +	__u32 subprog_cnt;

Just to clarify: this cannot be an array of bpf_program pointers,
because bpf_object__append_subprog_code() mutates subprog->sub_insn_off
between bpf_object__reloc_code() and bpf_object__relocate_data()
calls, right?

>  };
> =20
>  struct bpf_struct_ops {
> @@ -527,6 +540,7 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +#define JUMPTABLES_SEC ".jumptables"
> =20
>  enum libbpf_map_type {
>  	LIBBPF_MAP_UNSPEC,
> @@ -671,6 +685,7 @@ struct elf_state {
>  	int symbols_shndx;
>  	bool has_st_ops;
>  	int arena_data_shndx;
> +	int jumptables_data_shndx;
>  };
> =20
>  struct usdt_manager;
> @@ -742,6 +757,16 @@ struct bpf_object {
>  	void *arena_data;
>  	size_t arena_data_sz;
> =20
> +	void *jumptables_data;
> +	size_t jumptables_data_sz;
> +
> +	struct {
> +		struct bpf_program *prog;
> +		int off;
> +		int fd;
> +	} *jumptable_maps;
> +	size_t jumptable_map_cnt;
> +
>  	struct kern_feature_cache *feat_cache;
>  	char *token_path;
>  	int token_fd;
> @@ -768,6 +793,7 @@ void bpf_program__unload(struct bpf_program *prog)
> =20
>  	zfree(&prog->func_info);
>  	zfree(&prog->line_info);
> +	zfree(&prog->subprogs);

Maybe move this to bpf_object__free_relocs()?
`subprogs` are only needed during relocation resolution,
and free_relocs() is called from bpf_object__load_progs().

>  }
> =20
>  static void bpf_program__exit(struct bpf_program *prog)
> @@ -3946,6 +3972,13 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>  			} else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
>  				obj->efile.arena_data =3D data;
>  				obj->efile.arena_data_shndx =3D idx;
> +			} else if (strcmp(name, JUMPTABLES_SEC) =3D=3D 0) {
> +				obj->jumptables_data =3D malloc(data->d_size);
> +				if (!obj->jumptables_data)
> +					return -ENOMEM;
> +				memcpy(obj->jumptables_data, data->d_buf, data->d_size);
> +				obj->jumptables_data_sz =3D data->d_size;
> +				obj->efile.jumptables_data_shndx =3D idx;
>  			} else {
>  				pr_info("elf: skipping unrecognized data section(%d) %s\n",
>  					idx, name);
> @@ -4638,6 +4671,16 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
>  		return 0;
>  	}
> =20
> +	/* jump table data relocation */
> +	if (shdr_idx =3D=3D obj->efile.jumptables_data_shndx) {
> +		reloc_desc->type =3D RELO_INSN_ARRAY;
> +		reloc_desc->insn_idx =3D insn_idx;
> +		reloc_desc->map_idx =3D -1;
> +		reloc_desc->sym_off =3D sym->st_value;
> +		reloc_desc->sym_size =3D sym->st_size;
> +		return 0;
> +	}
> +
>  	/* generic map reference relocation */
>  	if (type =3D=3D LIBBPF_MAP_UNSPEC) {
>  		if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
> @@ -6148,6 +6191,131 @@ static void poison_kfunc_call(struct bpf_program =
*prog, int relo_idx,
>  	insn->imm =3D POISON_CALL_KFUNC_BASE + ext_idx;
>  }
> =20
> +static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog,=
 int off)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < obj->jumptable_map_cnt; i++) {
> +		/*
> +		 * This might happen that same offset is used for two different
> +		 * programs (as jump tables can be the same). However, for
> +		 * different programs different maps should be created.
> +		 */
> +		if (obj->jumptable_maps[i].off =3D=3D off &&
> +		    obj->jumptable_maps[i].prog =3D=3D prog)
> +			return obj->jumptable_maps[i].fd;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, =
int off, int map_fd)
> +{
> +	size_t new_cnt =3D obj->jumptable_map_cnt + 1;
> +	size_t size =3D sizeof(obj->jumptable_maps[0]);
> +	void *tmp;
> +
> +	tmp =3D libbpf_reallocarray(obj->jumptable_maps, new_cnt, size);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	obj->jumptable_maps =3D tmp;
> +	obj->jumptable_maps[new_cnt - 1].prog =3D prog;
> +	obj->jumptable_maps[new_cnt - 1].off =3D off;
                                         ^^^
Nit:             Could you please rename this and corresponding
                 parameters of `{create,add}_jt_map` to `sym_off`?

> +	obj->jumptable_maps[new_cnt - 1].fd =3D map_fd;
> +	obj->jumptable_map_cnt =3D new_cnt;
> +
> +	return 0;
> +}
> +
> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *pro=
g,
> +			 int off, int size, int adjust_off)
> +{
> +	const __u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +	const __u32 max_entries =3D size / value_size;
> +	struct bpf_insn_array_value val =3D {};
> +	int map_fd, err;
> +	__u64 xlated_off;
> +	__u64 *jt;
> +	__u32 i;
> +
> +	map_fd =3D find_jt_map(obj, prog, off);
> +	if (map_fd >=3D 0)
> +		return map_fd;
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> +				4, value_size, max_entries, NULL);
> +	if (map_fd < 0)
> +		return map_fd;
> +
> +	if (!obj->jumptables_data) {
> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +	if (off + size > obj->jumptables_data_sz) {
> +		pr_warn("jumptables_data size is %zd, trying to access %d\n",
> +			obj->jumptables_data_sz, off + size);
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}

Maybe also check that `size` and `off` are 8-bytes aligned?

> +
> +	jt =3D (__u64 *)(obj->jumptables_data + off);
> +	for (i =3D 0; i < max_entries; i++) {
> +		/*
> +		 * LLVM-generated jump tables contain u64 records, however
> +		 * should contain values that fit in u32.
> +		 * The adjust_off provided by the caller adjusts the offset to
> +		 * be relative to the beginning of the main function
> +		 */
> +		xlated_off =3D jt[i]/sizeof(struct bpf_insn) + adjust_off;
> +		if (xlated_off > UINT32_MAX) {
> +			pr_warn("invalid jump table value %llx at offset %d (adjust_off %d)\n=
",
> +				jt[i], off + i, adjust_off);
> +			err =3D -EINVAL;
> +			goto err_close;
> +		}
> +
> +		val.xlated_off =3D xlated_off;
> +		err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +		if (err)
> +			goto err_close;
> +	}
> +
> +	err =3D bpf_map_freeze(map_fd);
> +	if (err)
> +		goto err_close;
> +
> +	err =3D add_jt_map(obj, prog, off, map_fd);
> +	if (err)
> +		goto err_close;
> +
> +	return map_fd;
> +
> +err_close:
> +	close(map_fd);
> +	return err;
> +}
> +
> +/*
> + * In LLVM the .jumptables section contains jump tables entries relative=
 to the
> + * section start. The BPF kernel-side code expects jump table offsets re=
lative
> + * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). This =
helper
> + * computes a delta to be added when creating a map.
> + */
> +static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
> +{
> +	int i;
> +
> +	for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--) {
> +		if (insn_idx >=3D prog->subprogs[i].sub_insn_off)
> +			return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn_of=
f;
> +	}
> +
> +	return -prog->sec_insn_off;
> +}

Nit: the docstring for sub_insn_off says that it is 0 for main sub-program.
     meaning that last return is unreachable. I'd rewrite the above as foll=
ows:

       static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
       {
         int i;

         for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--)
                if (insn_idx >=3D prog->subprogs[i].sub_insn_off)
                        break;

         return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn=
_off;
       }

    Or rename this thing to find_subprog_idx(), pass relo object into
    create_jt_map(), call find_subprog_idx() there, and do the following:

      xlated_off =3D jt[i] / sizeof(struct bpf_insn);
      /* make xlated_off relative to subprogram start */
      xlated_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
      /* make xlated_off relative to main subprogram start */
      xlated_off +=3D prog->subprogs[subprog_idx].sub_insn_off;

   I think it's easier to grasp what this adjustment does this way.

> +
> +
>  /* Relocate data references within program code:
>   *  - map references;
>   *  - global variable references;
> @@ -6239,6 +6407,21 @@ bpf_object__relocate_data(struct bpf_object *obj, =
struct bpf_program *prog)
>  		case RELO_CORE:
>  			/* will be handled by bpf_program_record_relos() */
>  			break;
> +		case RELO_INSN_ARRAY: {
> +			int map_fd;
> +
> +			map_fd =3D create_jt_map(obj, prog, relo->sym_off, relo->sym_size,
> +					       jt_adjust_off(prog, relo->insn_idx));
> +			if (map_fd < 0) {
> +				pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n"=
,
> +						prog->name, i, relo->sym_off);
> +				return map_fd;
> +			}
> +			insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
> +			insn->imm =3D map_fd;
> +			insn->off =3D 0;
> +		}
> +			break;
>  		default:
>  			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
>  				prog->name, i, relo->type);
> @@ -6436,6 +6619,24 @@ static int append_subprog_relos(struct bpf_program=
 *main_prog, struct bpf_progra
>  	return 0;
>  }
> =20
> +static int save_subprog_offsets(struct bpf_program *main_prog, struct bp=
f_program *subprog)
> +{
> +	size_t size =3D sizeof(main_prog->subprogs[0]);
> +	int new_cnt =3D main_prog->subprog_cnt + 1;
> +	void *tmp;
> +
> +	tmp =3D libbpf_reallocarray(main_prog->subprogs, new_cnt, size);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	main_prog->subprogs =3D tmp;
> +	main_prog->subprogs[new_cnt - 1].sec_insn_off =3D subprog->sec_insn_off=
;
> +	main_prog->subprogs[new_cnt - 1].sub_insn_off =3D subprog->sub_insn_off=
;
> +	main_prog->subprog_cnt =3D new_cnt;
> +
> +	return 0;
> +}
> +
>  static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
>  				struct bpf_program *subprog)
> @@ -6465,6 +6666,15 @@ bpf_object__append_subprog_code(struct bpf_object =
*obj, struct bpf_program *main
>  	err =3D append_subprog_relos(main_prog, subprog);
>  	if (err)
>  		return err;
> +
> +	/* Save subprogram offsets */
> +	err =3D save_subprog_offsets(main_prog, subprog);
> +	if (err) {
> +		pr_warn("prog '%s': failed to add subprog offsets: %s\n",
> +			main_prog->name, errstr(err));
> +		return err;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -9232,6 +9442,15 @@ void bpf_object__close(struct bpf_object *obj)
> =20
>  	zfree(&obj->arena_data);
> =20
> +	zfree(&obj->jumptables_data);
> +	obj->jumptables_data_sz =3D 0;
> +
> +	if (obj->jumptable_maps && obj->jumptable_map_cnt) {
> +		for (i =3D 0; i < obj->jumptable_map_cnt; i++)
> +			close(obj->jumptable_maps[i].fd);
> +	}
> +	zfree(&obj->jumptable_maps);
> +
>  	free(obj);
>  }
> =20
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index 9dfbe7750f56..bccf4bb747e1 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -364,6 +364,10 @@ static int probe_map_create(enum bpf_map_type map_ty=
pe)
>  	case BPF_MAP_TYPE_SOCKHASH:
>  	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
>  		break;
> +	case BPF_MAP_TYPE_INSN_ARRAY:
> +		key_size	=3D sizeof(__u32);
> +		value_size	=3D sizeof(struct bpf_insn_array_value);
> +		break;
>  	case BPF_MAP_TYPE_UNSPEC:
>  	default:
>  		return -EOPNOTSUPP;
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index a469e5d4fee7..60dbf3edfa54 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -28,6 +28,8 @@
>  #include "str_error.h"
> =20
>  #define BTF_EXTERN_SEC ".extern"
> +#define JUMPTABLES_SEC ".jumptables"
> +#define JUMPTABLES_REL_SEC ".rel.jumptables"
> =20
>  struct src_sec {
>  	const char *sec_name;
> @@ -2026,6 +2028,9 @@ static int linker_append_elf_sym(struct bpf_linker =
*linker, struct src_obj *obj,
>  			obj->sym_map[src_sym_idx] =3D dst_sec->sec_sym_idx;
>  			return 0;
>  		}
> +
> +		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) =3D=3D 0)
> +			goto add_sym;
>  	}
> =20
>  	if (sym_bind =3D=3D STB_LOCAL)
> @@ -2272,8 +2277,9 @@ static int linker_append_elf_relos(struct bpf_linke=
r *linker, struct src_obj *ob
>  						insn->imm +=3D sec->dst_off / sizeof(struct bpf_insn);
>  					else
>  						insn->imm +=3D sec->dst_off;
> -				} else {
> -					pr_warn("relocation against STT_SECTION in non-exec section is not =
supported!\n");
> +				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) !=3D 0) {
> +					pr_warn("relocation against STT_SECTION in section %s is not suppor=
ted!\n",
> +						src_sec->sec_name);
>  					return -EINVAL;
>  				}
>  			}

