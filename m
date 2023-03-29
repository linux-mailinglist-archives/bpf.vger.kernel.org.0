Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA716CF231
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjC2Sgk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2Sgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:36:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBA1FDA
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:36:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so67132747edc.3
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680114996; x=1682706996;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sn7/83lioykY4gPnLZgKgES7rQzxaV2avnnPtKyMhEo=;
        b=MnEtu347R93OxYR+aQCWkn/U1RtN2/TGFmnkNKVTNo8sxZ6Pfs5WINlf/0CwEXKI5V
         fen+QVoe0Rcge9V11TArDqiObKU52Yy+PoCmAFs5tIybB+MiBLQCXdfwvlqLDQI3EccV
         r+Xv6IehdcszEzzOKpaNWEPy2dz1nQ+sK3ClekCRGhpddDwMqmf+T/jVaKMF+6H6KAFJ
         H6sd9BKVjd7GiX3bwGLU2lHgcRH/mtJg4jqsc6JOak9Zp+Mrs7/bu1agCp+pWgBc4VJ3
         yppmQQys8LFysVS00gb1vO14IlF3hrsk8oIKpjTnESMASp2lREpN6Qxs9V76yMDWSGua
         hzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680114996; x=1682706996;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sn7/83lioykY4gPnLZgKgES7rQzxaV2avnnPtKyMhEo=;
        b=NsOak0EPIZqEqFVgWmuRK/CfgJK5tRcNRwxAvR5xhBtBmbl6rGmuViMwDug46lZdJ9
         JWK7/1O24Zfi8MgV5h2/OqQ20ms+Fyp+pHTmJXSfc/IEIaFbKZnaYCnbu9qFbDTF8Px2
         ZNnCbujgAaLrirPJmZ1PPoEqTmOXtrM1sBC4RXwljmF6UjqgXeMWszTHixsY6hxkEpS3
         rXEqK7I/39ZzHYPjZGvJOmG4H7WFn+uVJjJwGDGnzRZ7GiI21PuqJy9yAv1J/4RNfz1D
         lHmEnk/oxe/1Z68xC4ZmN2VVKnfdU5GcR8H1nLGk51HrmNufXm9uYNXXi8c84uJkyMUR
         YCWA==
X-Gm-Message-State: AAQBX9fNul/R9eqsagj+lOE+PQjcnSoYBth0Z/QlEVz2QNSRoaMPPnj9
        OPa0ij5NLlt81aPzQQOmnSc=
X-Google-Smtp-Source: AKy350YuMNl2yORJR39PyVzM69XM8HiH0NYLgaagtyo+6uElmx3zsu33zkQJLYk3SHFXH/BGfrWLMA==
X-Received: by 2002:aa7:d9c7:0:b0:4fc:6a39:d2f2 with SMTP id v7-20020aa7d9c7000000b004fc6a39d2f2mr20051894eds.18.1680114996094;
        Wed, 29 Mar 2023 11:36:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id be8-20020a1709070a4800b0093f822321fesm5681731ejc.137.2023.03.29.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:36:35 -0700 (PDT)
Message-ID: <09709d267f92856f5fd5293bd81bbe1ada4b41bc.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] veristat: guess and substitue
 underlying program type for freplace (EXT) progs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc:     kernel-team@meta.com
Date:   Wed, 29 Mar 2023 21:36:34 +0300
In-Reply-To: <20230327185202.1929145-4-andrii@kernel.org>
References: <20230327185202.1929145-1-andrii@kernel.org>
         <20230327185202.1929145-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable as
> is through veristat, as kernel expects actual program's FD during
> BPF_PROG_LOAD time, which veristat has no way of knowing.
>=20
> Unfortunately, freplace programs are a pretty important class of
> programs, especially when dealing with XDP chaining solutions, which
> rely on EXT programs.
>=20
> So let's do our best and teach veristat to try to guess the original
> program type, based on program's context argument type. And if guessing
> process succeeds, we manually override freplace/EXT with guessed program
> type using bpf_program__set_type() setter to increase chances of proper
> BPF verification.
>=20
> We rely on BTF and maintain a simple lookup table. This process is
> obviously not 100% bulletproof, as valid program might not use context
> and thus wouldn't have to specify correct type. Also, __sk_buff is very
> ambiguous and is the context type across many different program types.
> We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine in
> practice so far. Similarly, some program types require specifying attach
> type, and so we pick one out of possible few variants.
>=20
> Best effort at its best. But this makes veristat even more widely
> applicable.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I left one nitpick below, otherwise looks good.

I tried in on freplace programs from selftests and only 3 out 18
programs verified correctly, others complained about unavailable
functions or exit code not in range [0, 1], etc.
Not sure, if it's possible to select more permissive attachment kinds, thou=
gh.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  tools/testing/selftests/bpf/veristat.c | 121 ++++++++++++++++++++++++-
>  1 file changed, 117 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 263df32fbda8..055df1abd7ca 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -15,6 +15,7 @@
>  #include <sys/sysinfo.h>
>  #include <sys/stat.h>
>  #include <bpf/libbpf.h>
> +#include <bpf/btf.h>
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <float.h>
> @@ -778,7 +779,62 @@ static int parse_verif_log(char * const buf, size_t =
buf_sz, struct verif_stats *
>  	return 0;
>  }
> =20
> -static void fixup_obj(struct bpf_object *obj)
> +static int guess_prog_type_by_ctx_name(const char *ctx_name,
> +				       enum bpf_prog_type *prog_type,
> +				       enum bpf_attach_type *attach_type)
> +{
> +	/* We need to guess program type based on its declared context type.
> +	 * This guess can't be perfect as many different program types might
> +	 * share the same context type.  So we can only hope to reasonably
> +	 * well guess this and get lucky.
> +	 *
> +	 * Just in case, we support both UAPI-side type names and
> +	 * kernel-internal names.
> +	 */
> +	static struct {
> +		const char *uapi_name;
> +		const char *kern_name;
> +		enum bpf_prog_type prog_type;
> +		enum bpf_attach_type attach_type;
> +	} ctx_map[] =3D {
> +		/* __sk_buff is most ambiguous, for now we assume cgroup_skb */
> +		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_IN=
GRESS },
> +		{ "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGROUP_INET4_POST=
_BIND },
> +		{ "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_CGROUP_SOCK_AD=
DR, BPF_CGROUP_INET4_BIND },
> +		{ "bpf_sock_ops", "bpf_sock_ops_kern", BPF_PROG_TYPE_SOCK_OPS, BPF_CGR=
OUP_SOCK_OPS },
> +		{ "sk_msg_md", "sk_msg", BPF_PROG_TYPE_SK_MSG, BPF_SK_MSG_VERDICT },
> +		{ "bpf_cgroup_dev_ctx", "bpf_cgroup_dev_ctx", BPF_PROG_TYPE_CGROUP_DEV=
ICE, BPF_CGROUP_DEVICE },
> +		{ "bpf_sysctl", "bpf_sysctl_kern", BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CG=
ROUP_SYSCTL },
> +		{ "bpf_sockopt", "bpf_sockopt_kern", BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF=
_CGROUP_SETSOCKOPT },
> +		{ "sk_reuseport_md", "sk_reuseport_kern", BPF_PROG_TYPE_SK_REUSEPORT, =
BPF_SK_REUSEPORT_SELECT_OR_MIGRATE },
> +		{ "bpf_sk_lookup", "bpf_sk_lookup_kern", BPF_PROG_TYPE_SK_LOOKUP, BPF_=
SK_LOOKUP },
> +		{ "xdp_md", "xdp_buff", BPF_PROG_TYPE_XDP, BPF_XDP },
> +		/* tracing types with no expected attach type */
> +		{ "bpf_user_pt_regs_t", "pt_regs", BPF_PROG_TYPE_KPROBE },
> +		{ "bpf_perf_event_data", "bpf_perf_event_data_kern", BPF_PROG_TYPE_PER=
F_EVENT },
> +		/* raw_tp programs use u64[] from kernel side, we don't want
> +		 * to match on that, probably; so NULL for kern-side type
> +		 */
> +		{ "bpf_raw_tracepoint_args", NULL, BPF_PROG_TYPE_RAW_TRACEPOINT },
> +	};
> +	int i;
> +
> +	if (!ctx_name)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ctx_map); i++) {
> +		if (strcmp(ctx_map[i].uapi_name, ctx_name) =3D=3D 0 ||
> +		    (ctx_map[i].kern_name && strcmp(ctx_map[i].kern_name, ctx_name) =
=3D=3D 0)) {
> +			*prog_type =3D ctx_map[i].prog_type;
> +			*attach_type =3D ctx_map[i].attach_type;
> +			return 0;
> +		}
> +	}
> +
> +	return -ESRCH;
> +}
> +
> +static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, =
const char *filename)
>  {
>  	struct bpf_map *map;
> =20
> @@ -798,18 +854,75 @@ static void fixup_obj(struct bpf_object *obj)
>  				bpf_map__set_max_entries(map, 1);
>  		}
>  	}
> +
> +	/* SEC(freplace) programs can't be loaded with veristat as is,
> +	 * but we can try guessing their target program's expected type by
> +	 * looking at the type of program's first argument and substituting
> +	 * corresponding program type
> +	 */
> +	if (bpf_program__type(prog) =3D=3D BPF_PROG_TYPE_EXT) {
> +		const struct btf *btf =3D bpf_object__btf(obj);
> +		const char *prog_name =3D bpf_program__name(prog);
> +		enum bpf_prog_type prog_type;
> +		enum bpf_attach_type attach_type;
> +		const struct btf_type *t;
> +		const char *ctx_name;
> +		int id;
> +
> +		if (!btf)
> +			goto skip_freplace_fixup;
> +
> +		id =3D btf__find_by_name_kind(btf, prog_name, BTF_KIND_FUNC);
> +		t =3D btf__type_by_id(btf, id);
> +		t =3D btf__type_by_id(btf, t->type);
> +		if (!btf_is_func_proto(t) || btf_vlen(t) !=3D 1)
> +			goto skip_freplace_fixup;
> +
> +		/* context argument is a pointer to a struct/typedef */
> +		t =3D btf__type_by_id(btf, btf_params(t)[0].type);
> +		while (t && btf_is_mod(t))
> +			t =3D btf__type_by_id(btf, t->type);
> +		if (!t || !btf_is_ptr(t))
> +			goto skip_freplace_fixup;
> +		t =3D btf__type_by_id(btf, t->type);
> +		while (t && btf_is_mod(t))
> +			t =3D btf__type_by_id(btf, t->type);
> +		if (!t)
> +			goto skip_freplace_fixup;

Nitpick:
  In case if something goes wrong with BTF there is no "Failed to guess ...=
" message.

> +
> +		ctx_name =3D btf__name_by_offset(btf, t->name_off);
> +
> +		if (guess_prog_type_by_ctx_name(ctx_name, &prog_type, &attach_type) =
=3D=3D 0) {
> +			bpf_program__set_type(prog, prog_type);
> +			bpf_program__set_expected_attach_type(prog, attach_type);
> +
> +			if (!env.quiet) {
> +				printf("Using guessed program type '%s' for %s/%s...\n",
> +					libbpf_bpf_prog_type_str(prog_type),
> +					filename, prog_name);
> +			}
> +		} else {
> +			if (!env.quiet) {
> +				printf("Failed to guess program type for freplace program with conte=
xt type name '%s' for %s/%s. Consider using canonical type names to help ve=
ristat...\n",
> +					ctx_name, filename, prog_name);
> +			}
> +		}
> +	}
> +skip_freplace_fixup:
> +	return;
>  }
> =20
>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>  	const char *prog_name =3D bpf_program__name(prog);
> +	const char *base_filename =3D basename(filename);
>  	size_t buf_sz =3D sizeof(verif_log_buf);
>  	char *buf =3D verif_log_buf;
>  	struct verif_stats *stats;
>  	int err =3D 0;
>  	void *tmp;
> =20
> -	if (!should_process_file_prog(basename(filename), bpf_program__name(pro=
g))) {
> +	if (!should_process_file_prog(base_filename, bpf_program__name(prog))) =
{
>  		env.progs_skipped++;
>  		return 0;
>  	}
> @@ -835,12 +948,12 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>  	verif_log_buf[0] =3D '\0';
> =20
>  	/* increase chances of successful BPF object loading */
> -	fixup_obj(obj);
> +	fixup_obj(obj, prog, base_filename);
> =20
>  	err =3D bpf_object__load(obj);
>  	env.progs_processed++;
> =20
> -	stats->file_name =3D strdup(basename(filename));
> +	stats->file_name =3D strdup(base_filename);
>  	stats->prog_name =3D strdup(bpf_program__name(prog));
>  	stats->stats[VERDICT] =3D err =3D=3D 0; /* 1 - success, 0 - failure */
>  	parse_verif_log(buf, buf_sz, stats);

