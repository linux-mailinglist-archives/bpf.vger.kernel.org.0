Return-Path: <bpf+bounces-59536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B625ACCE04
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 22:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B73A446F
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEC2236FB;
	Tue,  3 Jun 2025 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiIta3Jw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6C221739;
	Tue,  3 Jun 2025 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748981705; cv=none; b=txruYCvkb0cpIh8bpsXFbSRhRVnv1h7HAQcmxoD2NQFfOcVppM86T66fbQQKoT+YJlPjhewwatnt1xlJo30Jfn2PFC7zKpwuUgHTFcQmRS1v+8+MP4c+cgWRu63bzO9u8wuprEZlWlebOhB5xmRtc11hMps3wBFjSrdpkxUNGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748981705; c=relaxed/simple;
	bh=p8xgZQd9Ydumm3F8fmXPvBzq5GcnxxeEKAiHtLPaKPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW5/0HSppT3s8ShkfCE9TxpEgo+yPSD+NAWY3jg6gAfF30MvFyW/fu3LjNx5mTCE42KuJZ2FmdwXC+4vdNr4SCL+2pe/U4aa+oqRXTSbdAndPH9QMH8D0QqlrR86NnhzxbeWNWtDVE1CmzOQU63aQ4dG55OMvOUhk8Bv708A7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiIta3Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EEAC4CEED;
	Tue,  3 Jun 2025 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748981705;
	bh=p8xgZQd9Ydumm3F8fmXPvBzq5GcnxxeEKAiHtLPaKPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiIta3Jw50l5wqXAjnpI2REIhmHwI0Lzhj4hLEiBk4wGokWGgIEpbzPSdHbk7JXXs
	 pktPIsY2ok0vnVJujiznapExh8nP1pj9UY24bqbFe0OpLMht34ZaeyIAnvWZyzvf9W
	 Z//5id5A4itMihjPEFlGGLUjC+8BrdVkPulMdfl+2zKxPNT2Hh/xa8tIfvzVJQehPZ
	 FRrXUdTIpjICNLE2VVgozKE7Rl3OtCN3+N9FRweyRKl018htFg5N65Y6oCID9rneaj
	 IMau77Rn5/ZrvCUEG04c5NptDoXsziWundP4OiiRSRDZAyvvtMJ4+TN2Dd1okE8Ptm
	 h6D0ffmAgtk9g==
Date: Tue, 3 Jun 2025 13:15:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
Message-ID: <aD9Xxhwqpm8BDeKe@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521222725.3895192-3-blakejones@google.com>

On Wed, May 21, 2025 at 03:27:24PM -0700, Blake Jones wrote:
> Look for .rodata maps, find ones with 'bpf_metadata_' variables, extract
> their values as strings, and create a new PERF_RECORD_BPF_METADATA
> synthetic event using that data. The code gets invoked from the existing
> routine perf_event__synthesize_one_bpf_prog().

It would be great if you can show an example how those metadata is
constructed and shared between BPF programs.

IIUC the metadata is collected for each BPF program which may have
multiple subprograms.  Then this patch creates multiple PERF_RECORD_
BPF_METADATA for each subprogram, right?

Can it be shared using the BPF program ID?

> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/lib/perf/include/perf/event.h |  18 ++
>  tools/perf/util/bpf-event.c         | 310 ++++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h         |  13 ++
>  3 files changed, 341 insertions(+)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 09b7c643ddac..6608f1e3701b 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -467,6 +467,22 @@ struct perf_record_compressed2 {
>  	char			 data[];
>  };
>  
> +#define BPF_METADATA_KEY_LEN   64
> +#define BPF_METADATA_VALUE_LEN 256
> +#define BPF_PROG_NAME_LEN      KSYM_NAME_LEN
> +
> +struct perf_record_bpf_metadata_entry {
> +	char key[BPF_METADATA_KEY_LEN];
> +	char value[BPF_METADATA_VALUE_LEN];
> +};
> +
> +struct perf_record_bpf_metadata {
> +	struct perf_event_header	      header;
> +	char				      prog_name[BPF_PROG_NAME_LEN];
> +	__u64				      nr_entries;
> +	struct perf_record_bpf_metadata_entry entries[];
> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_USER_TYPE_START		= 64,
>  	PERF_RECORD_HEADER_ATTR			= 64,
> @@ -489,6 +505,7 @@ enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_COMPRESSED			= 81,
>  	PERF_RECORD_FINISHED_INIT		= 82,
>  	PERF_RECORD_COMPRESSED2			= 83,
> +	PERF_RECORD_BPF_METADATA		= 84,
>  	PERF_RECORD_HEADER_MAX
>  };
>  
> @@ -530,6 +547,7 @@ union perf_event {
>  	struct perf_record_header_feature	feat;
>  	struct perf_record_compressed		pack;
>  	struct perf_record_compressed2		pack2;
> +	struct perf_record_bpf_metadata		bpf_metadata;
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
> @@ -151,6 +158,298 @@ static int synthesize_bpf_prog_name(char *buf, int size,
>  	return name_len;
>  }
>  
> +#define BPF_METADATA_PREFIX "bpf_metadata_"
> +#define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
> +
> +static bool name_has_bpf_metadata_prefix(const char **s)
> +{
> +	if (strncmp(*s, BPF_METADATA_PREFIX, BPF_METADATA_PREFIX_LEN) != 0)
> +		return false;
> +	*s += BPF_METADATA_PREFIX_LEN;
> +	return true;
> +}
> +
> +struct bpf_metadata_map {
> +	struct btf *btf;
> +	const struct btf_type *datasec;
> +	void *rodata;
> +	size_t rodata_size;
> +	unsigned int num_vars;
> +};
> +
> +static int bpf_metadata_read_map_data(__u32 map_id, struct bpf_metadata_map *map)
> +{
> +	int map_fd;
> +	struct bpf_map_info map_info;
> +	__u32 map_info_len;
> +	int key;
> +	struct btf *btf;
> +	const struct btf_type *datasec;
> +	struct btf_var_secinfo *vsi;
> +	unsigned int vlen, vars;
> +	void *rodata;
> +
> +	map_fd = bpf_map_get_fd_by_id(map_id);
> +	if (map_fd < 0)
> +		return -1;
> +
> +	memset(&map_info, 0, sizeof(map_info));
> +	map_info_len = sizeof(map_info);
> +	if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len) < 0)
> +		goto out_close;
> +
> +	/* If it's not an .rodata map, don't bother. */
> +	if (map_info.type != BPF_MAP_TYPE_ARRAY ||
> +	    map_info.key_size != sizeof(int) ||
> +	    map_info.max_entries != 1 ||
> +	    !map_info.btf_value_type_id ||
> +	    !strstr(map_info.name, ".rodata")) {
> +		goto out_close;
> +	}
> +
> +	btf = btf__load_from_kernel_by_id(map_info.btf_id);
> +	if (!btf)
> +		goto out_close;
> +	datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
> +	if (!btf_is_datasec(datasec))
> +		goto out_free_btf;
> +
> +	/* If there aren't any variables with the "bpf_metadata_" prefix,
> +	 * don't bother.
> +	 */
> +	vlen = btf_vlen(datasec);
> +	vsi = btf_var_secinfos(datasec);
> +	vars = 0;
> +	for (unsigned int i = 0; i < vlen; i++, vsi++) {
> +		const struct btf_type *t_var = btf__type_by_id(btf, vsi->type);
> +		const char *name = btf__name_by_offset(btf, t_var->name_off);
> +
> +		if (name_has_bpf_metadata_prefix(&name))
> +			vars++;
> +	}
> +	if (vars == 0)
> +		goto out_free_btf;
> +
> +	rodata = calloc(1, map_info.value_size);

You can use 'zalloc()' instead, in other places too.


> +	if (!rodata)
> +		goto out_free_btf;
> +	key = 0;
> +	if (bpf_map_lookup_elem(map_fd, &key, rodata)) {
> +		free(rodata);
> +		goto out_free_btf;
> +	}
> +	close(map_fd);
> +
> +	map->btf = btf;
> +	map->datasec = datasec;
> +	map->rodata = rodata;
> +	map->rodata_size = map_info.value_size;
> +	map->num_vars = vars;
> +	return 0;
> +
> +out_free_btf:
> +	btf__free(btf);
> +out_close:
> +	close(map_fd);
> +	return -1;
> +}
> +
> +struct format_btf_ctx {
> +	char *buf;
> +	size_t buf_size;
> +	size_t buf_idx;
> +};
> +
> +static void format_btf_cb(void *arg, const char *fmt, va_list ap)
> +{
> +	int n;
> +	struct format_btf_ctx *ctx = (struct format_btf_ctx *)arg;
> +
> +	n = vsnprintf(ctx->buf + ctx->buf_idx, ctx->buf_size - ctx->buf_idx,
> +		      fmt, ap);
> +	ctx->buf_idx += n;
> +	if (ctx->buf_idx >= ctx->buf_size)
> +		ctx->buf_idx = ctx->buf_size;
> +}
> +
> +static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
> +				const struct btf_type *t, const void *btf_data)
> +{
> +	struct format_btf_ctx ctx = {
> +		.buf = buf,
> +		.buf_idx = 0,
> +		.buf_size = buf_size,
> +	};
> +	const struct btf_dump_type_data_opts opts = {
> +		.sz = sizeof(struct btf_dump_type_data_opts),
> +		.skip_names = 1,
> +		.compact = 1,
> +		.print_strings = 1,
> +	};
> +	struct btf_dump *d;
> +	size_t btf_size;
> +
> +	d = btf_dump__new(btf, format_btf_cb, &ctx, NULL);
> +	btf_size = btf__resolve_size(btf, t->type);
> +	btf_dump__dump_type_data(d, t->type, btf_data, btf_size, &opts);
> +	btf_dump__free(d);
> +}
> +
> +static void bpf_metadata_fill_event(struct bpf_metadata_map *map,
> +				    struct perf_record_bpf_metadata *bpf_metadata_event)
> +{
> +	struct btf_var_secinfo *vsi;
> +	unsigned int i, vlen;
> +
> +	memset(bpf_metadata_event->prog_name, 0, BPF_PROG_NAME_LEN);
> +	vlen = btf_vlen(map->datasec);
> +	vsi = btf_var_secinfos(map->datasec);
> +
> +	for (i = 0; i < vlen; i++, vsi++) {
> +		const struct btf_type *t_var = btf__type_by_id(map->btf,
> +							       vsi->type);
> +		const char *name = btf__name_by_offset(map->btf,
> +						       t_var->name_off);
> +		const __u64 nr_entries = bpf_metadata_event->nr_entries;
> +		struct perf_record_bpf_metadata_entry *entry;
> +
> +		if (!name_has_bpf_metadata_prefix(&name))
> +			continue;
> +
> +		if (nr_entries >= (__u64)map->num_vars)
> +			break;
> +
> +		entry = &bpf_metadata_event->entries[nr_entries];
> +		memset(entry, 0, sizeof(*entry));
> +		snprintf(entry->key, BPF_METADATA_KEY_LEN, "%s", name);
> +		format_btf_variable(map->btf, entry->value,
> +				    BPF_METADATA_VALUE_LEN, t_var,
> +				    map->rodata + vsi->offset);
> +		bpf_metadata_event->nr_entries++;
> +	}
> +}
> +
> +static void bpf_metadata_free_map_data(struct bpf_metadata_map *map)
> +{
> +	btf__free(map->btf);
> +	free(map->rodata);
> +}
> +
> +void bpf_metadata_free(struct bpf_metadata *metadata)
> +{
> +	if (metadata == NULL)
> +		return;
> +	for (__u32 index = 0; index < metadata->nr_prog_names; index++)
> +		free(metadata->prog_names[index]);
> +	if (metadata->prog_names != NULL)
> +		free(metadata->prog_names);
> +	if (metadata->event != NULL)
> +		free(metadata->event);

No need to NULL change for free().


> +	free(metadata);
> +}
> +
> +static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
> +					       __u32 nr_variables)
> +{
> +	struct bpf_metadata *metadata;
> +
> +	metadata = calloc(1, sizeof(struct bpf_metadata));
> +	if (!metadata)
> +		return NULL;
> +
> +	metadata->prog_names = calloc(nr_prog_tags, sizeof(char *));
> +	if (!metadata->prog_names) {
> +		bpf_metadata_free(metadata);
> +		return NULL;
> +	}
> +	for (__u32 prog_index = 0; prog_index < nr_prog_tags; prog_index++) {
> +		metadata->prog_names[prog_index] = calloc(BPF_PROG_NAME_LEN,
> +							  sizeof(char));
> +		if (!metadata->prog_names[prog_index]) {
> +			bpf_metadata_free(metadata);
> +			return NULL;
> +		}
> +		metadata->nr_prog_names++;
> +	}
> +
> +	metadata->event_size = sizeof(metadata->event->bpf_metadata) +
> +	    nr_variables * sizeof(metadata->event->bpf_metadata.entries[0]);
> +	metadata->event = calloc(1, metadata->event_size);
> +	if (!metadata->event) {
> +		bpf_metadata_free(metadata);
> +		return NULL;
> +	}
> +
> +	return metadata;
> +}
> +
> +static struct bpf_metadata *bpf_metadata_create(struct bpf_prog_info *info)
> +{
> +	struct bpf_metadata *metadata;
> +	const __u32 *map_ids = (__u32 *)(uintptr_t)info->map_ids;
> +
> +	for (__u32 map_index = 0; map_index < info->nr_map_ids; map_index++) {
> +		struct perf_record_bpf_metadata *bpf_metadata_event;
> +		struct bpf_metadata_map map;
> +
> +		if (bpf_metadata_read_map_data(map_ids[map_index], &map) != 0)
> +			continue;
> +
> +		metadata = bpf_metadata_alloc(info->nr_prog_tags, map.num_vars);
> +		if (!metadata)
> +			continue;
> +
> +		bpf_metadata_event = &metadata->event->bpf_metadata;
> +		*bpf_metadata_event = (struct perf_record_bpf_metadata) {
> +			.header = {
> +				.type = PERF_RECORD_BPF_METADATA,
> +				.size = metadata->event_size,
> +			},
> +			.nr_entries = 0,
> +		};
> +		bpf_metadata_fill_event(&map, bpf_metadata_event);
> +
> +		for (__u32 index = 0; index < info->nr_prog_tags; index++) {
> +			synthesize_bpf_prog_name(metadata->prog_names[index],
> +						 BPF_PROG_NAME_LEN, info,
> +						 map.btf, index);
> +		}
> +
> +		bpf_metadata_free_map_data(&map);
> +
> +		return metadata;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int synthesize_perf_record_bpf_metadata(const struct bpf_metadata *metadata,
> +					       const struct perf_tool *tool,
> +					       perf_event__handler_t process,
> +					       struct machine *machine)
> +{
> +	union perf_event *event;
> +	int err = 0;
> +
> +	event = calloc(1, metadata->event_size + machine->id_hdr_size);
> +	if (!event)
> +		return -1;
> +	memcpy(event, metadata->event, metadata->event_size);
> +	memset((void *)event + event->header.size, 0, machine->id_hdr_size);
> +	event->header.size += machine->id_hdr_size;
> +	for (__u32 index = 0; index < metadata->nr_prog_names; index++) {
> +		memcpy(event->bpf_metadata.prog_name,
> +		       metadata->prog_names[index], BPF_PROG_NAME_LEN);

Is it possible to call synthesize_bpf_prog_name() directly to the
event->bpf_metadata.prog_name instead of saving it metadata->prog_names?

Thanks,
Namhyung


> +		err = perf_tool__process_synth_event(tool, event, machine,
> +						     process);
> +		if (err != 0)
> +			break;
> +	}
> +
> +	free(event);
> +	return err;
> +}
> +
>  /*
>   * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
>   * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
> @@ -173,6 +472,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  	const struct perf_tool *tool = session->tool;
>  	struct bpf_prog_info_node *info_node;
>  	struct perf_bpil *info_linear;
> +	struct bpf_metadata *metadata;
>  	struct bpf_prog_info *info;
>  	struct btf *btf = NULL;
>  	struct perf_env *env;
> @@ -193,6 +493,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
>  	arrays |= 1UL << PERF_BPIL_LINE_INFO;
>  	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
> +	arrays |= 1UL << PERF_BPIL_MAP_IDS;
>  
>  	info_linear = get_bpf_prog_info_linear(fd, arrays);
>  	if (IS_ERR_OR_NULL(info_linear)) {
> @@ -301,6 +602,15 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  		 */
>  		err = perf_tool__process_synth_event(tool, event,
>  						     machine, process);
> +
> +		/* Synthesize PERF_RECORD_BPF_METADATA */
> +		metadata = bpf_metadata_create(info);
> +		if (metadata != NULL) {
> +			err = synthesize_perf_record_bpf_metadata(metadata,
> +								  tool, process,
> +								  machine);
> +			bpf_metadata_free(metadata);
> +		}
>  	}
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
> +	union perf_event *event;
> +	size_t		 event_size;
> +	char		 **prog_names;
> +	__u64		 nr_prog_names;
> +};
> +
>  struct bpf_prog_info_node {
>  	struct perf_bpil		*info_linear;
>  	struct rb_node			rb_node;
> @@ -36,6 +43,7 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
>  void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
>  				      struct perf_env *env,
>  				      FILE *fp);
> +void bpf_metadata_free(struct bpf_metadata *metadata);
>  #else
>  static inline int machine__process_bpf(struct machine *machine __maybe_unused,
>  				       union perf_event *event __maybe_unused,
> @@ -55,6 +63,11 @@ static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info _
>  						    FILE *fp __maybe_unused)
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

