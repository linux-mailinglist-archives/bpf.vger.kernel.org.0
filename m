Return-Path: <bpf+bounces-59311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E6AC81CE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4455A41264
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406022FF39;
	Thu, 29 May 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjdkjISO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328322F752
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540857; cv=none; b=XtwZNNuqXZNbOPaWrH06dLzrY/0uutT2j8RjoFY4FH7nV61kpLhTSm8n+nxr+Agar0tXD0EYNleRotk7BVEueI7k/08G7mBY68OVz3VV9xrp6XRNmleiy/P0ZxSZvwCbtm+P/tviriuTshFqYgVu39kEnbROyfha40XXerlxrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540857; c=relaxed/simple;
	bh=HbHocys9iUG4CKQt2nBc5xkBHk46pgbsMnTnBspfcoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCBiILyq30s71uwL0q3le7LNCc3XIjmzhDwySW56OwSUB/U2TkJDxlg9SmKrI0Ye/VAhzq31v/lt/ES6qWoQ/neqqrWt0VpxKKM8ZR0C8pYwGDzAQBnAZlouGAMNTR6juDhyweRda2SYJ+rw7eqE1ZZoerTei2yF2nqppz+Xy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjdkjISO; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso12965ab.1
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748540855; x=1749145655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE0ipkhs8HeEHqXkUMIR2vLt4OP+aFT5KMiHPVBOXno=;
        b=UjdkjISOCDTaUniWHr8+hKOTp2eqdBiTL1LWKHfxHrSJHGWh0mF64ptNHTavtd5OvL
         pwcGbPgsbOptWJ785P1xQkehrEmRSAUY5CLa0Stu51Q85QNlccjrQg7fEo47Sl8xjoWl
         dtJcwNDwHXApyc8yCyqcEinzm2YgtpvXJWkS4rndOFfVodkRtsrLsEWmOfLSp4NbTC4q
         q5WvKPlPkK26PAZbAsRh4MzIfKoisoh/BnE9yAoAcWnRlI9m6jircVtIr5NciV4Ms9Xs
         yEtSDiRLh/umwKoA1IqKfPeYvNy++Gz3Ukyd8l7QRCCQJwEhLCCCe6P+7u5losHBtZ6Y
         kZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748540855; x=1749145655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE0ipkhs8HeEHqXkUMIR2vLt4OP+aFT5KMiHPVBOXno=;
        b=qvVOmBJRq+T/dajWjejn85qQxOLpTHcfWTt92+5BsjAeZx1hukyx6KnIxMZT3TKUmK
         XatYk7RHtYBY8Elhp1dIHuCbUHIqhGUS553Iq0Epzvl/B00p/5mKcgQ6543Kab1Dn9Y8
         L8pmhX8eYPs2Z34mpv6L3rs1vM7dvvywd9i1xdV0PIxK4Yjs+Xy7hMtVAE6hrBzsjGaT
         4WR/OAhD/tZhlwBzvOBsEx7Tltomo54CFUw5mmDSJkyqQ2HATbYjgwbIZuYHn5IBFtRk
         VeDc1hO+wlw0QvzmQLTedTs9NqSEiFav849lPcw9JGPNvNpdoiNPmIXtXPvRO7cBYU6A
         9WGw==
X-Forwarded-Encrypted: i=1; AJvYcCX5PWiP4ipsLWnfCOicCXuWo/iduNvVgxTftPi+AsLBkXpBw1ZRiPD+3NHhSQ7zKQ/cIIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ye+oaBsEkCZeUCfokNVnC/yywTbQATzHCrP9AH2tJFWpjx4V
	3YEARhUppVbxJuLFbvudOcdhwhaMqPksu8Vs8fVoeQiNJuMW5D86wxbQZx/vRMbL8ttvsrS9n5k
	Qfv31sOH189MZVZmW535aebHrbuPuxdjxOC0IykjJ
X-Gm-Gg: ASbGncuBjAnxoxmO0wKHZM82Uqm1gUXmHYo3lSyQfFEXovIKcoydr4vpVdxScfLM+1q
	8HBsnnNGq2GRiL0j29964aYi6SgPbGc8kIHX1WgaL0rHAjOCZjj871tazkbKRczqxFcxkTk/Vmh
	KLufOSSvKy+Aef6v56Ns+HZgjpcsHQ2gMESUzN0F89IrHxLsMI6FU+BRn4ki/TD3vpuucOaVki
X-Google-Smtp-Source: AGHT+IHCCdSEXUiGdfRyednmvAQMfYHGaskD102mXpZPg/eXarExfDq61XUwL9aw2hgnzh0NZJ9JKetLHYOoK+z35GM=
X-Received: by 2002:a05:6e02:18cb:b0:3dc:7ffe:33e4 with SMTP id
 e9e14a558f8ab-3dd93102305mr4291085ab.5.1748540854498; Thu, 29 May 2025
 10:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com> <20250521222725.3895192-3-blakejones@google.com>
In-Reply-To: <20250521222725.3895192-3-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 May 2025 10:47:22 -0700
X-Gm-Features: AX0GCFtPE4eUZ4x4Qqtef2mhzTPd8hLWFCqibuLJF5L8NueR6M2Ow6xxU8v0AEI
Message-ID: <CAP-5=fVn++LYR6PcRMf9wcBooALVHX2y=i_C6cLsDipN2EDsOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:27=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Look for .rodata maps, find ones with 'bpf_metadata_' variables, extract
> their values as strings, and create a new PERF_RECORD_BPF_METADATA
> synthetic event using that data. The code gets invoked from the existing
> routine perf_event__synthesize_one_bpf_prog().
>
> Signed-off-by: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/lib/perf/include/perf/event.h |  18 ++
>  tools/perf/util/bpf-event.c         | 310 ++++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h         |  13 ++
>  3 files changed, 341 insertions(+)
>
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index 09b7c643ddac..6608f1e3701b 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -467,6 +467,22 @@ struct perf_record_compressed2 {
>         char                     data[];
>  };
>
> +#define BPF_METADATA_KEY_LEN   64
> +#define BPF_METADATA_VALUE_LEN 256
> +#define BPF_PROG_NAME_LEN      KSYM_NAME_LEN
> +
> +struct perf_record_bpf_metadata_entry {
> +       char key[BPF_METADATA_KEY_LEN];
> +       char value[BPF_METADATA_VALUE_LEN];
> +};
> +
> +struct perf_record_bpf_metadata {
> +       struct perf_event_header              header;
> +       char                                  prog_name[BPF_PROG_NAME_LEN=
];
> +       __u64                                 nr_entries;
> +       struct perf_record_bpf_metadata_entry entries[];
> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>         PERF_RECORD_USER_TYPE_START             =3D 64,
>         PERF_RECORD_HEADER_ATTR                 =3D 64,
> @@ -489,6 +505,7 @@ enum perf_user_event_type { /* above any possible ker=
nel type */
>         PERF_RECORD_COMPRESSED                  =3D 81,
>         PERF_RECORD_FINISHED_INIT               =3D 82,
>         PERF_RECORD_COMPRESSED2                 =3D 83,
> +       PERF_RECORD_BPF_METADATA                =3D 84,
>         PERF_RECORD_HEADER_MAX
>  };
>
> @@ -530,6 +547,7 @@ union perf_event {
>         struct perf_record_header_feature       feat;
>         struct perf_record_compressed           pack;
>         struct perf_record_compressed2          pack2;
> +       struct perf_record_bpf_metadata         bpf_metadata;
>  };
>
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index c81444059ad0..36d5676f025e 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -1,13 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
> +#include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/err.h>
> +#include <linux/perf_event.h>
>  #include <linux/string.h>
>  #include <internal/lib.h>
> +#include <perf/event.h>
>  #include <symbol/kallsyms.h>
>  #include "bpf-event.h"
>  #include "bpf-utils.h"
> @@ -151,6 +158,298 @@ static int synthesize_bpf_prog_name(char *buf, int =
size,
>         return name_len;
>  }
>
> +#define BPF_METADATA_PREFIX "bpf_metadata_"
> +#define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
> +
> +static bool name_has_bpf_metadata_prefix(const char **s)
> +{
> +       if (strncmp(*s, BPF_METADATA_PREFIX, BPF_METADATA_PREFIX_LEN) !=
=3D 0)
> +               return false;
> +       *s +=3D BPF_METADATA_PREFIX_LEN;
> +       return true;
> +}
> +
> +struct bpf_metadata_map {
> +       struct btf *btf;
> +       const struct btf_type *datasec;
> +       void *rodata;
> +       size_t rodata_size;
> +       unsigned int num_vars;
> +};
> +
> +static int bpf_metadata_read_map_data(__u32 map_id, struct bpf_metadata_=
map *map)
> +{
> +       int map_fd;
> +       struct bpf_map_info map_info;
> +       __u32 map_info_len;
> +       int key;
> +       struct btf *btf;
> +       const struct btf_type *datasec;
> +       struct btf_var_secinfo *vsi;
> +       unsigned int vlen, vars;
> +       void *rodata;
> +
> +       map_fd =3D bpf_map_get_fd_by_id(map_id);
> +       if (map_fd < 0)
> +               return -1;
> +
> +       memset(&map_info, 0, sizeof(map_info));
> +       map_info_len =3D sizeof(map_info);
> +       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len) < 0)
> +               goto out_close;
> +
> +       /* If it's not an .rodata map, don't bother. */
> +       if (map_info.type !=3D BPF_MAP_TYPE_ARRAY ||
> +           map_info.key_size !=3D sizeof(int) ||
> +           map_info.max_entries !=3D 1 ||
> +           !map_info.btf_value_type_id ||
> +           !strstr(map_info.name, ".rodata")) {
> +               goto out_close;
> +       }
> +
> +       btf =3D btf__load_from_kernel_by_id(map_info.btf_id);
> +       if (!btf)
> +               goto out_close;
> +       datasec =3D btf__type_by_id(btf, map_info.btf_value_type_id);
> +       if (!btf_is_datasec(datasec))
> +               goto out_free_btf;
> +
> +       /* If there aren't any variables with the "bpf_metadata_" prefix,
> +        * don't bother.
> +        */
> +       vlen =3D btf_vlen(datasec);
> +       vsi =3D btf_var_secinfos(datasec);
> +       vars =3D 0;
> +       for (unsigned int i =3D 0; i < vlen; i++, vsi++) {
> +               const struct btf_type *t_var =3D btf__type_by_id(btf, vsi=
->type);
> +               const char *name =3D btf__name_by_offset(btf, t_var->name=
_off);
> +
> +               if (name_has_bpf_metadata_prefix(&name))
> +                       vars++;
> +       }
> +       if (vars =3D=3D 0)
> +               goto out_free_btf;
> +
> +       rodata =3D calloc(1, map_info.value_size);
> +       if (!rodata)
> +               goto out_free_btf;
> +       key =3D 0;
> +       if (bpf_map_lookup_elem(map_fd, &key, rodata)) {
> +               free(rodata);
> +               goto out_free_btf;
> +       }
> +       close(map_fd);
> +
> +       map->btf =3D btf;
> +       map->datasec =3D datasec;
> +       map->rodata =3D rodata;
> +       map->rodata_size =3D map_info.value_size;
> +       map->num_vars =3D vars;
> +       return 0;
> +
> +out_free_btf:
> +       btf__free(btf);
> +out_close:
> +       close(map_fd);
> +       return -1;
> +}
> +
> +struct format_btf_ctx {
> +       char *buf;
> +       size_t buf_size;
> +       size_t buf_idx;
> +};
> +
> +static void format_btf_cb(void *arg, const char *fmt, va_list ap)
> +{
> +       int n;
> +       struct format_btf_ctx *ctx =3D (struct format_btf_ctx *)arg;
> +
> +       n =3D vsnprintf(ctx->buf + ctx->buf_idx, ctx->buf_size - ctx->buf=
_idx,
> +                     fmt, ap);
> +       ctx->buf_idx +=3D n;
> +       if (ctx->buf_idx >=3D ctx->buf_size)
> +               ctx->buf_idx =3D ctx->buf_size;
> +}
> +
> +static void format_btf_variable(struct btf *btf, char *buf, size_t buf_s=
ize,
> +                               const struct btf_type *t, const void *btf=
_data)
> +{
> +       struct format_btf_ctx ctx =3D {
> +               .buf =3D buf,
> +               .buf_idx =3D 0,
> +               .buf_size =3D buf_size,
> +       };
> +       const struct btf_dump_type_data_opts opts =3D {
> +               .sz =3D sizeof(struct btf_dump_type_data_opts),
> +               .skip_names =3D 1,
> +               .compact =3D 1,
> +               .print_strings =3D 1,
> +       };
> +       struct btf_dump *d;
> +       size_t btf_size;
> +
> +       d =3D btf_dump__new(btf, format_btf_cb, &ctx, NULL);
> +       btf_size =3D btf__resolve_size(btf, t->type);
> +       btf_dump__dump_type_data(d, t->type, btf_data, btf_size, &opts);
> +       btf_dump__free(d);
> +}
> +
> +static void bpf_metadata_fill_event(struct bpf_metadata_map *map,
> +                                   struct perf_record_bpf_metadata *bpf_=
metadata_event)
> +{
> +       struct btf_var_secinfo *vsi;
> +       unsigned int i, vlen;
> +
> +       memset(bpf_metadata_event->prog_name, 0, BPF_PROG_NAME_LEN);
> +       vlen =3D btf_vlen(map->datasec);
> +       vsi =3D btf_var_secinfos(map->datasec);
> +
> +       for (i =3D 0; i < vlen; i++, vsi++) {
> +               const struct btf_type *t_var =3D btf__type_by_id(map->btf=
,
> +                                                              vsi->type)=
;
> +               const char *name =3D btf__name_by_offset(map->btf,
> +                                                      t_var->name_off);
> +               const __u64 nr_entries =3D bpf_metadata_event->nr_entries=
;
> +               struct perf_record_bpf_metadata_entry *entry;
> +
> +               if (!name_has_bpf_metadata_prefix(&name))
> +                       continue;
> +
> +               if (nr_entries >=3D (__u64)map->num_vars)
> +                       break;
> +
> +               entry =3D &bpf_metadata_event->entries[nr_entries];
> +               memset(entry, 0, sizeof(*entry));
> +               snprintf(entry->key, BPF_METADATA_KEY_LEN, "%s", name);
> +               format_btf_variable(map->btf, entry->value,
> +                                   BPF_METADATA_VALUE_LEN, t_var,
> +                                   map->rodata + vsi->offset);
> +               bpf_metadata_event->nr_entries++;
> +       }
> +}
> +
> +static void bpf_metadata_free_map_data(struct bpf_metadata_map *map)
> +{
> +       btf__free(map->btf);
> +       free(map->rodata);
> +}
> +
> +void bpf_metadata_free(struct bpf_metadata *metadata)
> +{
> +       if (metadata =3D=3D NULL)
> +               return;
> +       for (__u32 index =3D 0; index < metadata->nr_prog_names; index++)
> +               free(metadata->prog_names[index]);
> +       if (metadata->prog_names !=3D NULL)
> +               free(metadata->prog_names);
> +       if (metadata->event !=3D NULL)
> +               free(metadata->event);
> +       free(metadata);
> +}
> +
> +static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
> +                                              __u32 nr_variables)
> +{
> +       struct bpf_metadata *metadata;
> +
> +       metadata =3D calloc(1, sizeof(struct bpf_metadata));
> +       if (!metadata)
> +               return NULL;
> +
> +       metadata->prog_names =3D calloc(nr_prog_tags, sizeof(char *));
> +       if (!metadata->prog_names) {
> +               bpf_metadata_free(metadata);
> +               return NULL;
> +       }
> +       for (__u32 prog_index =3D 0; prog_index < nr_prog_tags; prog_inde=
x++) {
> +               metadata->prog_names[prog_index] =3D calloc(BPF_PROG_NAME=
_LEN,
> +                                                         sizeof(char));
> +               if (!metadata->prog_names[prog_index]) {
> +                       bpf_metadata_free(metadata);
> +                       return NULL;
> +               }
> +               metadata->nr_prog_names++;
> +       }
> +
> +       metadata->event_size =3D sizeof(metadata->event->bpf_metadata) +
> +           nr_variables * sizeof(metadata->event->bpf_metadata.entries[0=
]);
> +       metadata->event =3D calloc(1, metadata->event_size);
> +       if (!metadata->event) {
> +               bpf_metadata_free(metadata);
> +               return NULL;
> +       }
> +
> +       return metadata;
> +}
> +
> +static struct bpf_metadata *bpf_metadata_create(struct bpf_prog_info *in=
fo)
> +{
> +       struct bpf_metadata *metadata;
> +       const __u32 *map_ids =3D (__u32 *)(uintptr_t)info->map_ids;
> +
> +       for (__u32 map_index =3D 0; map_index < info->nr_map_ids; map_ind=
ex++) {
> +               struct perf_record_bpf_metadata *bpf_metadata_event;
> +               struct bpf_metadata_map map;
> +
> +               if (bpf_metadata_read_map_data(map_ids[map_index], &map) =
!=3D 0)
> +                       continue;
> +
> +               metadata =3D bpf_metadata_alloc(info->nr_prog_tags, map.n=
um_vars);
> +               if (!metadata)
> +                       continue;
> +
> +               bpf_metadata_event =3D &metadata->event->bpf_metadata;
> +               *bpf_metadata_event =3D (struct perf_record_bpf_metadata)=
 {
> +                       .header =3D {
> +                               .type =3D PERF_RECORD_BPF_METADATA,
> +                               .size =3D metadata->event_size,

nit: Could we set the header.size in bpf_metadata_alloc to remove
metadata->event_size. The code generally doesn't pass a pair of
perf_event + size around as the size should be in the header.

Thanks,
Ian

> +                       },
> +                       .nr_entries =3D 0,
> +               };
> +               bpf_metadata_fill_event(&map, bpf_metadata_event);
> +
> +               for (__u32 index =3D 0; index < info->nr_prog_tags; index=
++) {
> +                       synthesize_bpf_prog_name(metadata->prog_names[ind=
ex],
> +                                                BPF_PROG_NAME_LEN, info,
> +                                                map.btf, index);
> +               }
> +
> +               bpf_metadata_free_map_data(&map);
> +
> +               return metadata;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int synthesize_perf_record_bpf_metadata(const struct bpf_metadata=
 *metadata,
> +                                              const struct perf_tool *to=
ol,
> +                                              perf_event__handler_t proc=
ess,
> +                                              struct machine *machine)
> +{
> +       union perf_event *event;
> +       int err =3D 0;
> +
> +       event =3D calloc(1, metadata->event_size + machine->id_hdr_size);
> +       if (!event)
> +               return -1;
> +       memcpy(event, metadata->event, metadata->event_size);
> +       memset((void *)event + event->header.size, 0, machine->id_hdr_siz=
e);
> +       event->header.size +=3D machine->id_hdr_size;
> +       for (__u32 index =3D 0; index < metadata->nr_prog_names; index++)=
 {
> +               memcpy(event->bpf_metadata.prog_name,
> +                      metadata->prog_names[index], BPF_PROG_NAME_LEN);
> +               err =3D perf_tool__process_synth_event(tool, event, machi=
ne,
> +                                                    process);
> +               if (err !=3D 0)
> +                       break;
> +       }
> +
> +       free(event);
> +       return err;
> +}
> +
>  /*
>   * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
>   * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
> @@ -173,6 +472,7 @@ static int perf_event__synthesize_one_bpf_prog(struct=
 perf_session *session,
>         const struct perf_tool *tool =3D session->tool;
>         struct bpf_prog_info_node *info_node;
>         struct perf_bpil *info_linear;
> +       struct bpf_metadata *metadata;
>         struct bpf_prog_info *info;
>         struct btf *btf =3D NULL;
>         struct perf_env *env;
> @@ -193,6 +493,7 @@ static int perf_event__synthesize_one_bpf_prog(struct=
 perf_session *session,
>         arrays |=3D 1UL << PERF_BPIL_JITED_INSNS;
>         arrays |=3D 1UL << PERF_BPIL_LINE_INFO;
>         arrays |=3D 1UL << PERF_BPIL_JITED_LINE_INFO;
> +       arrays |=3D 1UL << PERF_BPIL_MAP_IDS;
>
>         info_linear =3D get_bpf_prog_info_linear(fd, arrays);
>         if (IS_ERR_OR_NULL(info_linear)) {
> @@ -301,6 +602,15 @@ static int perf_event__synthesize_one_bpf_prog(struc=
t perf_session *session,
>                  */
>                 err =3D perf_tool__process_synth_event(tool, event,
>                                                      machine, process);
> +
> +               /* Synthesize PERF_RECORD_BPF_METADATA */
> +               metadata =3D bpf_metadata_create(info);
> +               if (metadata !=3D NULL) {
> +                       err =3D synthesize_perf_record_bpf_metadata(metad=
ata,
> +                                                                 tool, p=
rocess,
> +                                                                 machine=
);
> +                       bpf_metadata_free(metadata);
> +               }
>         }
>
>  out:
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index e2f0420905f5..007f0b4d21cb 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -17,6 +17,13 @@ struct record_opts;
>  struct evlist;
>  struct target;
>
> +struct bpf_metadata {
> +       union perf_event *event;
> +       size_t           event_size;
> +       char             **prog_names;
> +       __u64            nr_prog_names;
> +};
> +
>  struct bpf_prog_info_node {
>         struct perf_bpil                *info_linear;
>         struct rb_node                  rb_node;
> @@ -36,6 +43,7 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, str=
uct perf_env *env);
>  void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
>                                       struct perf_env *env,
>                                       FILE *fp);
> +void bpf_metadata_free(struct bpf_metadata *metadata);
>  #else
>  static inline int machine__process_bpf(struct machine *machine __maybe_u=
nused,
>                                        union perf_event *event __maybe_un=
used,
> @@ -55,6 +63,11 @@ static inline void __bpf_event__print_bpf_prog_info(st=
ruct bpf_prog_info *info _
>                                                     FILE *fp __maybe_unus=
ed)
>  {
>
> +}
> +
> +static inline void bpf_metadata_free(struct bpf_metadata *metadata)
> +{
> +
>  }
>  #endif // HAVE_LIBBPF_SUPPORT
>  #endif
> --
> 2.49.0.1143.g0be31eac6b-goog
>

