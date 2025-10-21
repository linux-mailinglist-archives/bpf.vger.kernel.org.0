Return-Path: <bpf+bounces-71643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB5BF907F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3234EFAAF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC738296BC9;
	Tue, 21 Oct 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOHd154n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53052874F8
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085141; cv=none; b=LQ4J+otY7Vl5gyRMGnFCWiyzm1wzrp61OzCsh8Eh1OqNWTf73UEdkq2eOKifZPLavTuUXL/eyMGEVxaxUQ2guqaUqe/ld2Qe6LRG/ExPix21Tp3D6wLlXono/9ocukHPIxL5BEa1POPXwBkHGRPpA3X1hd6zcS9mR0Ss9nmEyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085141; c=relaxed/simple;
	bh=HRFl25BrWz9aXkoQjrDn6KtubThwHbvuU/W7vOLxuv4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MK/k4IDIGWk7Nj4m8chxkDFO3JpOT/NzuNzcpBq5reu73TZPicpDgxpwTuO34R6xRkb9BT8a/RDJip95IEkh5ufTlfEiU9t10KmkUtO19d2L7GLNFsDqPVHemhO8s93/Kbms4eOJG6CWPsju/3sN35z0MAHKQ0qMv7rCPXVwPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOHd154n; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so79844a91.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761085139; x=1761689939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nl/B8/L8NTRbwks8d3iJu7mxda8iPe6Z17RML5jACeY=;
        b=fOHd154nc2MzWW8FtcGsN8k1YKEUA8joueE1QhmJXiIleJ539mN492FvNboMOZu825
         5LP5nmCnN8fGXwrq8RexFI6Btuyh5mP+vxofwKK3YrIXRcBBYDhB7lHo9pX0F+vMKACr
         MIlKrVAtuoOrawaETNqG7l1oqPC5hserJOpeOImHUlaTJou1ayiJjoe8WHG2IFjtc2bi
         0IIbypu1nRBBtAjaDOANI3/+T/Fr2aIl9TB6OBIjW0qR6LrOQdd8dScsG55J9ne8eK+H
         IgyGUvDmqFy0Ni5xXNBGWxlE+MLFwmLj3qnlt2QpKuG22R0T+658/V0sz2gM/abBbcuh
         qSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085139; x=1761689939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nl/B8/L8NTRbwks8d3iJu7mxda8iPe6Z17RML5jACeY=;
        b=foCk4dGZ/2hmVyVP/JqN3ShJ5I/zd6dqP9ruYwQuAxEHehj2o7kv6ij934XZbuB5rm
         Xtah2CCHwYiRh9EROl+fCUeDgpx7mzxPy2FkzdkXfbcVubXGiKGkfgY8jYe3an7K+pud
         p1ULEfqG4o8sjxvOcLkX/wrSdzkWB5d2cGWI6y8/AbwhHS2BN3fHM9d7s7Ycil293PSl
         UF6x0ze4vaU9Z1k376ddurgBUXqvEik3tsMeeFwqHkVsSSXfDWx75gjXKvCtJ4j9NDK2
         PP3suM67dYPl8dYb5p/vgnyeDv4Fhs10D5eulspqF7l7TQZsJCaiyGVtTHzyBnsGALDH
         bo8w==
X-Forwarded-Encrypted: i=1; AJvYcCWV3N9skn+IqJRAgIuIK4p9m3mzxlVKfJLxGDDve3O/Pu29bsBcWdDFhb0f1AOSUyBRQUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6Nbn6fg9PWATOeHDwdttQoD2pB9X7uxkPh8SwUvYXc+3m/YT
	GBHDf/X0zzeS81/Sa6WrFEZazDnbrzEnT5oMjx5kcQgCTBOHumA+87Q1tobJ+O3A
X-Gm-Gg: ASbGnctRoRuWWCx4DuPW7yoaGpugJNrL59IntfAjf0OiuIqWaifdd3agyGa5T8x9Pf8
	ZD9tk68cLuF/LgZq8CRohgOBmMVuG5OMUzaVGRs+AL6Kv6ZRgX2TOz5CWzMjK7QfyzNyNDT0r1N
	zVtYJsY49gKBnW74IJLQcsbTTLLSS3TdmnRqM0ckfctGkwIbgjr7blPk7HP3cXW3K9X1g4xY6O0
	2a48NUoBjjEh1uQw7qHxXoObOc6SU39G59Ef1/OXIaQet+HbY7c5pCEhLYDO/SJjLuW/xUJBYJp
	zILcnyWga43qyYd++6di2L0+E/y3/Wpz1OFnIIba4pLd/py3tQjyCMwaYluVek1yMf78Eg8a8ps
	TKsMNyt6nMc364JWubKc8H3hJshR0C2W9vn1o+mL6Q6U8A+5lOHxffn1Osbj10wtdNJ46Ccp6mr
	abvhN94ovg03OklplN3tV/cJllunikxAwEazg=
X-Google-Smtp-Source: AGHT+IH5hkxcp9op+/Ntg0G38aeDuCbFDWdz4z6/MmtzaT/ogGFLBESuCLUACMeTE2aiU4qMrGscTQ==
X-Received: by 2002:a17:90b:38c7:b0:339:d1f0:c735 with SMTP id 98e67ed59e1d1-33bcf91e032mr23098715a91.28.1761085138868;
        Tue, 21 Oct 2025 15:18:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4482a1sm1333772a91.10.2025.10.21.15.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:18:58 -0700 (PDT)
Message-ID: <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 14/17] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 15:18:56 -0700
In-Reply-To: <20251019202145.3944697-15-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-15-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:

[...]

> ---
>  tools/lib/bpf/libbpf.c        | 240 +++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_probes.c |   4 +
>  tools/lib/bpf/linker.c        |  10 +-
>  3 files changed, 251 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b90574f39d1c..ee44bc49a3ba 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[...]

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

Sorry, I'm still confused about what happens here.
The `insn_idx` is comes from relocation, meaning that it is a value
recorded relative to section start, right?  On the other hand,
`.sub_insn_off` is an offset of a subprogram within a concatenated
program, about to be loaded.  These values should not be compared
directly.

I think, that my suggestion from v5 [1] should be easier to understand:

   > Or rename this thing to find_subprog_idx(), pass relo object into
   > create_jt_map(), call find_subprog_idx() there, and do the following:
   >
   >   xlated_off =3D jt[i] / sizeof(struct bpf_insn);
   >   /* make xlated_off relative to subprogram start */
   >   xlated_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
   >   /* make xlated_off relative to main subprogram start */
   >   xlated_off +=3D prog->subprogs[subprog_idx].sub_insn_off;

[1] https://lore.kernel.org/bpf/b5fd31c3e703c8c84c6710f5536510fbce04b36f.ca=
mel@gmail.com/

> +			return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn_of=
f;
> +	}
> +
> +	return -prog->sec_insn_off;
> +}
> +
> +
>  /* Relocate data references within program code:
>   *  - map references;
>   *  - global variable references;
> @@ -6235,6 +6422,21 @@ bpf_object__relocate_data(struct bpf_object *obj, =
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

[...]

> @@ -9228,6 +9457,15 @@ void bpf_object__close(struct bpf_object *obj)
> =20
>  	zfree(&obj->arena_data);
> =20
> +	zfree(&obj->jumptables_data);
> +	obj->jumptables_data_sz =3D 0;
> +
> +	if (obj->jumptable_maps && obj->jumptable_map_cnt) {

Nit: outer 'if' seems unnecessary.

> +		for (i =3D 0; i < obj->jumptable_map_cnt; i++)
> +			close(obj->jumptable_maps[i].fd);
> +	}
> +	zfree(&obj->jumptable_maps);
> +
>  	free(obj);
>  }

[...]

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 56ae77047bc3..3defd4bc9154 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -27,6 +27,8 @@
>  #include "strset.h"
> =20
>  #define BTF_EXTERN_SEC ".extern"
> +#define JUMPTABLES_SEC ".jumptables"
> +#define JUMPTABLES_REL_SEC ".rel.jumptables"

Nit: maybe avoid duplicating JUMPTABLES_SEC by moving all *_SEC macro
     to libbpf_internal.h?

> =20
>  struct src_sec {
>  	const char *sec_name;
> @@ -2025,6 +2027,9 @@ static int linker_append_elf_sym(struct bpf_linker =
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
> @@ -2271,8 +2276,9 @@ static int linker_append_elf_relos(struct bpf_linke=
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

Sorry, I missed this on a previous iteration.
LLVM generates section relative offsets for jump table contents, so it
seems that relocations inside jump table section should not occur.
Is this a leftover, or am I confused?

>  					return -EINVAL;
>  				}
>  			}

