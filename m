Return-Path: <bpf+bounces-15392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B27F1C6F
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B94282888
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB530CFB;
	Mon, 20 Nov 2023 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxrBGsbl"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9292
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:32:09 -0800 (PST)
Message-ID: <769b00a5-88ac-4902-a69e-01ec977338ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700505128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUO6eiHLX8t5ia5wEYuTnRKu0VNEUF4Qz6HlmbhcyFs=;
	b=qxrBGsbluNrFU/664ToRTpqgxdWeC9S8R7PLawsT5srMn/Pa/6QvNpYajIdT0ZuxO9o0KE
	kNyc1Hx51orHKiqooOwwl/tqNng/GizCQ013cj8JSC3bQmsCONw+Wk5vI4XydRgvGwOxcy
	xtwnvshg8MqY7uY6MERHwgr46bw2tMg=
Date: Mon, 20 Nov 2023 10:32:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 6/6] bpftool: Add support to display
 uprobe_multi links
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>, Quentin Monnet <quentin@isovalent.com>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-7-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231120145639.3179656-7-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 9:56 AM, Jiri Olsa wrote:
> Adding support to display details for uprobe_multi links,
> both plain:
>
>    # bpftool link -p
>    ...
>    24: uprobe_multi  prog 126
>            uprobe.multi  path /home/jolsa/bpf/test_progs  func_cnt 3  pid 4143
>            offset             ref_ctr_offset     cookies
>            0xd1f88            0xf5d5a8           0xdead
>            0xd1f8f            0xf5d5aa           0xbeef
>            0xd1f96            0xf5d5ac           0xcafe
>
> and json:
>
>    # bpftool link -p
>    [{
>    ...
>        },{
>            "id": 24,
>            "type": "uprobe_multi",
>            "prog_id": 126,
>            "retprobe": false,
>            "path": "/home/jolsa/bpf/test_progs",
>            "func_cnt": 3,
>            "pid": 4143,
>            "funcs": [{
>                    "offset": 860040,
>                    "ref_ctr_offset": 16111016,
>                    "cookie": 57005
>                },{
>                    "offset": 860047,
>                    "ref_ctr_offset": 16111018,
>                    "cookie": 48879
>                },{
>                    "offset": 860054,
>                    "ref_ctr_offset": 16111020,
>                    "cookie": 51966
>                }
>            ]
>        }
>    ]
>
> Acked-by: Song Liu <song@kernel.org>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   tools/bpf/bpftool/link.c | 105 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a1528cde81ab..d198adf77d81 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -294,6 +294,37 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>   	jsonw_end_array(json_wtr);
>   }
>   
> +static __u64 *u64_to_arr(__u64 val)
> +{
> +	return (__u64 *) u64_to_ptr(val);
> +}
> +
> +static void
> +show_uprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +	__u32 i;
> +
> +	jsonw_bool_field(json_wtr, "retprobe",
> +			 info->uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN);
> +	jsonw_string_field(json_wtr, "path", (char *) u64_to_ptr(info->uprobe_multi.path));
> +	jsonw_uint_field(json_wtr, "func_cnt", info->uprobe_multi.count);
> +	jsonw_int_field(json_wtr, "pid", (int) info->uprobe_multi.pid);
> +	jsonw_name(json_wtr, "funcs");
> +	jsonw_start_array(json_wtr);
> +
> +	for (i = 0; i < info->uprobe_multi.count; i++) {
> +		jsonw_start_object(json_wtr);
> +		jsonw_uint_field(json_wtr, "offset",
> +				 u64_to_arr(info->uprobe_multi.offsets)[i]);
> +		jsonw_uint_field(json_wtr, "ref_ctr_offset",
> +				 u64_to_arr(info->uprobe_multi.ref_ctr_offsets)[i]);
> +		jsonw_uint_field(json_wtr, "cookie",
> +				 u64_to_arr(info->uprobe_multi.cookies)[i]);
> +		jsonw_end_object(json_wtr);
> +	}
> +	jsonw_end_array(json_wtr);
> +}
> +
>   static void
>   show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
>   {
> @@ -465,6 +496,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>   	case BPF_LINK_TYPE_KPROBE_MULTI:
>   		show_kprobe_multi_json(info, json_wtr);
>   		break;
> +	case BPF_LINK_TYPE_UPROBE_MULTI:
> +		show_uprobe_multi_json(info, json_wtr);
> +		break;
>   	case BPF_LINK_TYPE_PERF_EVENT:
>   		switch (info->perf_event.type) {
>   		case BPF_PERF_EVENT_EVENT:
> @@ -674,6 +708,33 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>   	}
>   }
>   
> +static void show_uprobe_multi_plain(struct bpf_link_info *info)
> +{
> +	__u32 i;
> +
> +	if (!info->uprobe_multi.count)
> +		return;
> +
> +	if (info->uprobe_multi.flags & BPF_F_UPROBE_MULTI_RETURN)
> +		printf("\n\turetprobe.multi  ");
> +	else
> +		printf("\n\tuprobe.multi  ");
> +
> +	printf("path %s  ", (char *) u64_to_ptr(info->uprobe_multi.path));
> +	printf("func_cnt %u  ", info->uprobe_multi.count);
> +
> +	if (info->uprobe_multi.pid != (__u32) -1)
> +		printf("pid %d  ", info->uprobe_multi.pid);

Could you explain when info->uprobe_multi.pid could be -1?
 From patch 3, I see:
	info->uprobe_multi.pid = umulti_link->task ?
			 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
and cannot find how -1 could be assigned to info->uprobe_multi.pid.

> +
> +	printf("\n\t%-16s   %-16s   %-16s", "offset", "ref_ctr_offset", "cookies");
> +	for (i = 0; i < info->uprobe_multi.count; i++) {
> +		printf("\n\t0x%-16llx 0x%-16llx 0x%-16llx",
> +			u64_to_arr(info->uprobe_multi.offsets)[i],
> +			u64_to_arr(info->uprobe_multi.ref_ctr_offsets)[i],
> +			u64_to_arr(info->uprobe_multi.cookies)[i]);
> +	}
> +}
> +
>   static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
>   {
>   	const char *buf;
> [...]

