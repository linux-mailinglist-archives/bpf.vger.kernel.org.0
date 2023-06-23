Return-Path: <bpf+bounces-3295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5973BD26
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996D5281C67
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2302C8C6;
	Fri, 23 Jun 2023 16:49:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8FA959
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:49:39 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C3273F
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:49:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3112902f785so1996453f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687538952; x=1690130952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsOp9KP6jOzwj1SH/ZQmAEVBWG3fb3UXXsXb6PAG+7E=;
        b=dYHDKOarCC5KZ/voKSQdwivPr8KfUVtFDozyF01YoBQLymLJpYj1Vkn81D/tj6tq/j
         oN11NnwltqxB29CJe80JyTSMD86ltSKpT5fQQOl9o6hHp0sWkP7MA8fY6dveejhOJL2H
         EqlQew8Lrzx1ueKOXNvMFr++oedM21CGjKMrL9mE8QDqfoOwHBzfwRZchDGXkbdNAUPj
         5Ul7cIhHCg9YeK+YfcLpYjr7aOfBiiWbGm+24KCNW3UuF5cmjYxVFZmPrgXB/7sMsitI
         CkV4pmMYFbsdf4tKO+ZYmuVWD9fZenf3PXXDgrytzLAk7RMlve23zMPsDtfe96nccbmQ
         L5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538952; x=1690130952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsOp9KP6jOzwj1SH/ZQmAEVBWG3fb3UXXsXb6PAG+7E=;
        b=VdRj+64WVBW2DuoB2NgF5rycbRgPCUdO0CwG3JfZIcHElcV2/rBuugZHCuztyYwI1O
         orlU5vGKVqQMM6b0QZMZXYY38iTypxdBr/v+SDQOsOXFZj5JJNxTsgrH5yDJV2JMJqnK
         s6xXfcKMaRoCw0JdKjCujff4BOiBNe7FbCGlJ5a/rE0piMzBGc1ifYg7IWfYGyPUf3p8
         Ncwn5+n7sa5kTfRx9RtXA33VOJ8H99VoLIxxL7zgqiRgBlm2hGjuyckn9MZ2tI3if9vs
         oqmY9nPTysm9FldXiXAgHXsEQril68l8Oy1hfUy+N4lGRhlPcFgHipTAfX35bwzFWz5+
         sCOw==
X-Gm-Message-State: AC+VfDw1D/mi7oKS5tdijMHV+1Ufpjn+3hJe7L5M4sAobY7AKALkmxFa
	UcXNbBTI2Bns98VUhxDjES42FA==
X-Google-Smtp-Source: ACHHUZ4Jfu0KIVM+dih3L9c2VNAPSojMwoPN5AlFukktEfF8YKvX0fUimDG99CNT/4tzWBuQDwrjNw==
X-Received: by 2002:adf:e910:0:b0:30f:c7e5:6176 with SMTP id f16-20020adfe910000000b0030fc7e56176mr20658581wrm.14.1687538952548;
        Fri, 23 Jun 2023 09:49:12 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id m18-20020adfdc52000000b003113b3bc9d7sm9879067wrj.32.2023.06.23.09.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:49:12 -0700 (PDT)
Message-ID: <47769c5d-e6da-1f60-aac5-42c7322485fd@isovalent.com>
Date: Fri, 23 Jun 2023 17:49:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 bpf-next 11/11] bpftool: Show perf link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230623141546.3751-1-laoar.shao@gmail.com>
 <20230623141546.3751-12-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623141546.3751-12-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Enhance bpftool to display comprehensive information about exposed
> perf_event links, covering uprobe, kprobe, tracepoint, and generic perf=

> event. The resulting output will include the following details:
>=20
> $ tools/bpf/bpftool/bpftool link show
> 4: perf_event  prog 23
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(27503)
> 5: perf_event  prog 24
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
>         bpf_cookie 0
>         pids uprobe(27503)
> 6: perf_event  prog 31
>         kprobe ffffffffa90a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(27777)
> 7: perf_event  prog 30
>         kretprobe ffffffffa90a9660 kernel_clone
>         bpf_cookie 0
>         pids kprobe(27777)
> 8: perf_event  prog 37
>         tracepoint sched_switch
>         bpf_cookie 0
>         pids tracepoint(28036)
> 9: perf_event  prog 43
>         event software:cpu-clock
>         bpf_cookie 0
>         pids perf_event(28261)
> 10: perf_event  prog 43
>         event hw-cache:LLC-load-misses
>         bpf_cookie 0
>         pids perf_event(28261)
> 11: perf_event  prog 43
>         event hardware:cpu-cycles
>         bpf_cookie 0
>         pids perf_event(28261)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":4,"type":"perf_event","prog_id":23,"retprobe":false,"file":"/hom=
e/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"pid"=
:27503,"comm":"uprobe"}]},{"id":5,"type":"perf_event","prog_id":24,"retpr=
obe":true,"file":"/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_co=
okie":0,"pids":[{"pid":27503,"comm":"uprobe"}]},{"id":6,"type":"perf_even=
t","prog_id":31,"retprobe":false,"addr":18446744072250627680,"func":"kern=
el_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":27777,"comm":"kprobe"}=
]},{"id":7,"type":"perf_event","prog_id":30,"retprobe":true,"addr":184467=
44072250627680,"func":"kernel_clone","offset":0,"bpf_cookie":0,"pids":[{"=
pid":27777,"comm":"kprobe"}]},{"id":8,"type":"perf_event","prog_id":37,"t=
racepoint":"sched_switch","bpf_cookie":0,"pids":[{"pid":28036,"comm":"tra=
cepoint"}]},{"id":9,"type":"perf_event","prog_id":43,"event_type":"softwa=
re","event_config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":28261,"comm"=
:"perf_event"}]},{"id":10,"type":"perf_event","prog_id":43,"event_type":"=
hw-cache","event_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":=
28261,"comm":"perf_event"}]},{"id":11,"type":"perf_event","prog_id":43,"e=
vent_type":"hardware","event_config":"cpu-cycles","bpf_cookie":0,"pids":[=
{"pid":28261,"comm":"perf_event"}]}]
>=20
> For generic perf events, the displayed information in bpftool is limite=
d to
> the type and configuration, while other attributes such as sample_perio=
d,
> sample_freq, etc., are not included.
>=20
> The kernel function address won't be exposed if it is not permitted by
> kptr_restrict. The result as follows when kptr_restrict is 2.
>=20
> $ tools/bpf/bpftool/bpftool link show
> 4: perf_event  prog 23
>         uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 5: perf_event  prog 24
>         uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
> 6: perf_event  prog 31
>         kprobe kernel_clone
> 7: perf_event  prog 30
>         kretprobe kernel_clone
> 8: perf_event  prog 37
>         tracepoint sched_switch
> 9: perf_event  prog 43
>         event software:cpu-clock
> 10: perf_event  prog 43
>         event hw-cache:LLC-load-misses
> 11: perf_event  prog 43
>         event hardware:cpu-cycles
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 237 +++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 236 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index e5aeee3..31bee95 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -17,6 +17,8 @@
>  #include "main.h"
>  #include "xlated_dumper.h"
> =20
> +#define PERF_HW_CACHE_LEN 128
> +
>  static struct hashmap *link_table;
>  static struct dump_data dd =3D {};
> =20
> @@ -274,6 +276,110 @@ static int cmp_u64(const void *A, const void *B)
>  	jsonw_end_array(json_wtr);
>  }
> =20
> +static void
> +show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> +{
> +	jsonw_bool_field(wtr, "retprobe", info->perf_event.kprobe.flags & 0x1=
);
> +	jsonw_uint_field(wtr, "addr", info->perf_event.kprobe.addr);
> +	jsonw_string_field(wtr, "func",
> +			   u64_to_ptr(info->perf_event.kprobe.func_name));
> +	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
> +}
> +
> +static void
> +show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> +{
> +	jsonw_bool_field(wtr, "retprobe", info->perf_event.uprobe.flags & 0x1=
);
> +	jsonw_string_field(wtr, "file",
> +			   u64_to_ptr(info->perf_event.uprobe.file_name));
> +	jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
> +}
> +
> +static void
> +show_perf_event_tracepoint_json(struct bpf_link_info *info, json_write=
r_t *wtr)
> +{
> +	jsonw_string_field(wtr, "tracepoint",
> +			   u64_to_ptr(info->perf_event.tracepoint.tp_name));
> +}
> +
> +static char *perf_config_hw_cache_str(__u64 config)
> +{
> +	const char *hw_cache, *result, *op;
> +	char *str =3D malloc(PERF_HW_CACHE_LEN);
> +
> +	if (!str) {
> +		p_err("mem alloc failed");
> +		return NULL;
> +	}
> +
> +	hw_cache =3D perf_event_name(evsel__hw_cache, config & 0xff);
> +	if (hw_cache)
> +		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
> +	else
> +		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
> +
> +	op =3D perf_event_name(evsel__hw_cache_op, (config >> 8) & 0xff);
> +	if (op)
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%s-", op);
> +	else
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%lld-", (config >> 8) & 0xff);
> +
> +	result =3D perf_event_name(evsel__hw_cache_result, config >> 16);
> +	if (result)
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%s", result);
> +	else
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%lld", config >> 16);
> +	return str;
> +}
> +
> +static const char *perf_config_str(__u32 type, __u64 config)
> +{
> +	const char *perf_config;
> +
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		perf_config =3D perf_event_name(event_symbols_hw, config);
> +		break;
> +	case PERF_TYPE_SOFTWARE:
> +		perf_config =3D perf_event_name(event_symbols_sw, config);
> +		break;
> +	case PERF_TYPE_HW_CACHE:
> +		perf_config =3D perf_config_hw_cache_str(config);
> +		break;
> +	default:
> +		perf_config =3D NULL;
> +		break;
> +	}
> +	return perf_config;
> +}
> +
> +static void
> +show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *=
wtr)
> +{
> +	__u64 config =3D info->perf_event.event.config;
> +	__u32 type =3D info->perf_event.event.type;
> +	const char *perf_type, *perf_config;
> +
> +	perf_type =3D perf_event_name(perf_type_name, type);
> +	if (perf_type)
> +		jsonw_string_field(wtr, "event_type", perf_type);
> +	else
> +		jsonw_uint_field(wtr, "event_type", type);
> +
> +	perf_config =3D perf_config_str(type, config);
> +	if (perf_config)
> +		jsonw_string_field(wtr, "event_config", perf_config);
> +	else
> +		jsonw_uint_field(wtr, "event_config", config);
> +
> +	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> +		free((void *)perf_config);
> +}
> +
>  static int show_link_close_json(int fd, struct bpf_link_info *info)
>  {
>  	struct bpf_prog_info prog_info;
> @@ -329,6 +435,24 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
>  	case BPF_LINK_TYPE_KPROBE_MULTI:
>  		show_kprobe_multi_json(info, json_wtr);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		switch (info->perf_event.type) {
> +		case BPF_PERF_EVENT_EVENT:
> +			show_perf_event_event_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_TRACEPOINT:
> +			show_perf_event_tracepoint_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_KPROBE:
> +			show_perf_event_kprobe_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_UPROBE:
> +			show_perf_event_uprobe_json(info, json_wtr);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -500,6 +624,75 @@ static void show_kprobe_multi_plain(struct bpf_lin=
k_info *info)
>  	}
>  }
> =20
> +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +
> +	buf =3D (const char *)u64_to_ptr(info->perf_event.kprobe.func_name);
> +	if (buf[0] =3D=3D '\0' && !info->perf_event.kprobe.addr)
> +		return;
> +
> +	if (info->perf_event.kprobe.flags & 0x1)
> +		printf("\n\tkretprobe ");
> +	else
> +		printf("\n\tkprobe ");
> +	if (info->perf_event.kprobe.addr)
> +		printf("%llx ", info->perf_event.kprobe.addr);
> +	printf("%s", buf);
> +	if (info->perf_event.kprobe.offset)
> +		printf("+%#x", info->perf_event.kprobe.offset);
> +	printf("  ");
> +}
> +
> +static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +
> +	buf =3D (const char *)u64_to_ptr(info->perf_event.uprobe.file_name);
> +	if (buf[0] =3D=3D '\0')
> +		return;
> +
> +	if (info->perf_event.uprobe.flags & 0x1)
> +		printf("\n\turetprobe ");
> +	else
> +		printf("\n\tuprobe ");
> +	printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
> +}
> +
> +static void show_perf_event_tracepoint_plain(struct bpf_link_info *inf=
o)
> +{
> +	const char *buf;
> +
> +	buf =3D (const char *)u64_to_ptr(info->perf_event.tracepoint.tp_name)=
;
> +	if (buf[0] =3D=3D '\0')
> +		return;
> +
> +	printf("\n\ttracepoint %s  ", buf);
> +}
> +
> +static void show_perf_event_event_plain(struct bpf_link_info *info)
> +{
> +	__u64 config =3D info->perf_event.event.config;
> +	__u32 type =3D info->perf_event.event.type;
> +	const char *perf_type, *perf_config;
> +
> +	printf("\n\tevent ");
> +	perf_type =3D perf_event_name(perf_type_name, type);
> +	if (perf_type)
> +		printf("%s:", perf_type);
> +	else
> +		printf("%u :", type);
> +
> +	perf_config =3D perf_config_str(type, config);
> +	if (perf_config)
> +		printf("%s  ", perf_config);
> +	else
> +		printf("%llu  ", config);
> +
> +	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> +		free((void *)perf_config);
> +}
> +
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  {
>  	struct bpf_prog_info prog_info;
> @@ -548,6 +741,24 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
>  	case BPF_LINK_TYPE_KPROBE_MULTI:
>  		show_kprobe_multi_plain(info);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		switch (info->perf_event.type) {
> +		case BPF_PERF_EVENT_EVENT:
> +			show_perf_event_event_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_TRACEPOINT:
> +			show_perf_event_tracepoint_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_KPROBE:
> +			show_perf_event_kprobe_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_UPROBE:
> +			show_perf_event_uprobe_plain(info);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -570,11 +781,12 @@ static int do_show_link(int fd)
>  	struct bpf_link_info info;
>  	__u32 len =3D sizeof(info);
>  	__u64 *addrs =3D NULL;
> -	char buf[256];
> +	char buf[PATH_MAX];
>  	int count;
>  	int err;
> =20
>  	memset(&info, 0, sizeof(info));
> +	buf[0] =3D '\0';
>  again:
>  	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
>  	if (err) {
> @@ -609,7 +821,30 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
> +		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_EVENT)
> +			goto out;

This "if (...) goto out;" seems unnecessary? If info.perf_event.type is
BPF_PERF_EVENT_EVENT we won't match any of the conditions below and
should reach the "out:" label anyway (and that label seems also
unnecessary)?

> +		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_TRACEPOINT &&
> +		    !info.perf_event.tracepoint.tp_name) {
> +			info.perf_event.tracepoint.tp_name =3D (unsigned long)&buf;
> +			info.perf_event.tracepoint.name_len =3D sizeof(buf);
> +			goto again;
> +		}
> +		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_KPROBE &&
> +		    !info.perf_event.kprobe.func_name) {
> +			info.perf_event.kprobe.func_name =3D (unsigned long)&buf;
> +			info.perf_event.kprobe.name_len =3D sizeof(buf);
> +			goto again;
> +		}
> +		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_UPROBE &&
> +		    !info.perf_event.uprobe.file_name) {
> +			info.perf_event.uprobe.file_name =3D (unsigned long)&buf;
> +			info.perf_event.uprobe.name_len =3D sizeof(buf);
> +			goto again;
> +		}
> +	}
> =20
> +out:
>  	if (json_output)
>  		show_link_close_json(fd, &info);
>  	else


