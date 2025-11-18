Return-Path: <bpf+bounces-74824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F1C66A1E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A1E32293C9
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D72417DE;
	Tue, 18 Nov 2025 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utN2wdt5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1613AD26
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425109; cv=none; b=UcoLP+JE+MVFXLmFT2vvmIoYY0yDvikCs2U7+7GT5caQSmwmDhb2P2EfRGOrffkqw32ty0kosZ0JVjguulTBLc3P7mpRSVEctWGraGY/3dV1HQQjJWLalt9prLbJcZz7qZ/Z9+qrVIrnBx9Lf7p8JP9ZfyF0SoNH14+yD77PTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425109; c=relaxed/simple;
	bh=qBhAKg20qoDgWvtC5epSiL0NufQXuEY4Y8OL6stT5yY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IjQGR7UZdtCb1aT/ma53eYlr6YMZX+hDDbFP+bZ2Rq8xUcl8oZAr0c7X/rwxnnuu5JxlUztPG/31k5b+/CuU6qzMyI4lQqfrleS6OTce3h1fzeXjT/ljSrS2tfyGeJ5j2S+X1LtoGnwBNEnlDAVcitd0RrJr4NaGnsmTTyCGwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utN2wdt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B33C2BCB1;
	Tue, 18 Nov 2025 00:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763425108;
	bh=qBhAKg20qoDgWvtC5epSiL0NufQXuEY4Y8OL6stT5yY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=utN2wdt5Eyz4WLgIL9yS2UnectR3d/XEkfgm02pyyNZ3+rTIA6XE806zmvZ+t2Z70
	 7KYnweacfYu2yFOhwCQb5FZAiO3UlLgVEzhVepNA6CjR9BkEPHlyUXT19nQ353Bgyl
	 pv/MBGHhvu4q/k9y9Ed9UePw7lHg+sqEeX6kQ9svEuVn9ZWkhboi8b+foEEioce6Eu
	 RTIbXtvx1fISdmbOVSnQSp45yQLasfw/dNFRpwz1bGgXVhE9xaG0NyldUSbWlH0dlc
	 i5PfkRYkpJgbE9ky+G7SfDFUyIw1SMh7OzgHrKO0N9V6Qi65hWQdyYkU3YMxdaeBgm
	 NmeAeMlfKYAdg==
Content-Type: multipart/mixed; boundary="===============0036236790022755823=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d256ee4485ea2c5142e8692b7dbbd559d05c41afb1f4ed81b78fd59eed9eb15@mail.kernel.org>
In-Reply-To: <20251117235636.140259-3-emil@etsalapatis.com>
References: <20251117235636.140259-3-emil@etsalapatis.com>
Subject: Re: [PATCH 2/4] libbpf: add stub for offset-related skeleton padding
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,memxor@gmail.com,andrii@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Nov 2025 00:18:27 +0000 (UTC)

--===============0036236790022755823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 993c7d948..6ed125b1b 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -269,7 +269,8 @@ static int codegen_datasec_def(struct bpf_object *obj,
>  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>  {
>  	size_t tmp_sz;
>
>  	if (bpf_map__type(map) == BPF_MAP_TYPE_ARENA && bpf_map__initial_value(map, &tmp_sz)) {
>  		snprintf(buf, sz, "arena");
>  		return true;
>  	}
>
>  	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>  		return false;
>
>  	if (!get_map_ident(map, buf, sz))
>  		return false;
>
>  	return true;
>  }

[ ... ]

> @@ -287,6 +291,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>  	struct bpf_map *map;
>  	const struct btf_type *sec;
>  	char map_ident[256];
> +	int var_off;
>  	int err = 0;
>
>  	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);

[ ... ]

> @@ -303,7 +316,13 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>  			printf("	struct %s__%s {\n", obj_name, map_ident);
>  			printf("	} *%s;\n", map_ident);
>  		} else {
> -			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
> +			var_off = bpf_map__data_offset(map);
> +			if (var_off < 0)  {
> +				p_err("bpf_map__data_offset called on unmapped map\n");
> +				err = var_off;
> +				goto out;
> +			}
> +			err = codegen_datasec_def(obj, btf, d, sec, obj_name, var_off);
>  			if (err)
>  				goto out;
>  		}

Can bpf_map__data_offset() be called here on an arena map that doesn't
have its mmaped field set yet?

During skeleton generation in do_skeleton(), the code calls
bpf_object__open_mem() but never calls bpf_object__load(). Looking at
is_mmapable_map() above, arena maps return true and will reach this code
path. However, arena maps only get their mmaped field set during
bpf_object__load() in libbpf.c around line 5615, not during
bpf_object__open().

This means bpf_map__data_offset() will be called on arena maps with
map->mmaped == NULL, causing it to return -EINVAL, which would fail
skeleton generation for any program with arena maps.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481b..32dac36ba 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10552,6 +10552,16 @@ const char *bpf_map__name(const struct bpf_map *map)
>  	return map->name;
>  }
>
> +int bpf_map__data_offset(const struct bpf_map *map)
> +{
> +	if (!map->mmaped)
> +		return -EINVAL;
> +
> +	/* No offsetting for now. */
> +	return 0;
> +}
         ^^^^

The check for map->mmaped here causes the problem described above. Since
this function is called during skeleton generation (before load), the
mmaped field won't be set for arena maps yet. Should this check be
removed, or should the skeleton generation code path be changed?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19448868610

--===============0036236790022755823==--

