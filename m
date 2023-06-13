Return-Path: <bpf+bounces-2506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2622772E462
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEF828123D
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432834D86;
	Tue, 13 Jun 2023 13:42:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E3522B
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 13:42:07 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07153BB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:42:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f81b449357so22987935e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686663722; x=1689255722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNJiILYHPWhdjN2t4sY8KGNSl7ZB0k4TdhE6UxfhbUU=;
        b=Wr+SXAkvWKSafC+7fLISNW3A6KpB4v+HdoiTXJOmQy6ZAK22ajGU6erqySSbl2kpna
         SQUWlEsepmumstRk+e0Sq1asqMzkt516CVjsIaUUzx/mh+MzouUe29xrIW5pQRgzZUwC
         bsg8XqvrVm620ZdhM0Dun+zELBL5gNf4GdNZ91B/GatfPzyzr6U1CfPClQbEvdIYxrR/
         Is7KrKxXB4FBoflz5/DfKhOPFyXSDjRK1Mu5OtrUUzhFY4QgND2C1Xqq87aeK9CGJwqi
         ZrSdSWsvt8EWCaHWfGwrxuHUrRDbSvnEfAiav6Cuz6FXwtMvsCOcH3cIdrua/AKK5j54
         Fitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663722; x=1689255722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNJiILYHPWhdjN2t4sY8KGNSl7ZB0k4TdhE6UxfhbUU=;
        b=QUJuIqjCDBFmQfsAcjgrobCX62w0v3/S5rwmh+REKXlEq3gG9MXDPVTMQg8CIuPPBX
         hw5crKYa1kmECnqBuNiVZpqaJp29Ih+yDdF977w2lQ7UagU21NTwS2jVOmZ5rxJT7pH6
         0ISsVynSz/XbHlsmq/OL77dIlSM+LrHJcX8uoZ3uYrNnAqv1XzX8WnCoojqoEyw7Qpi+
         qPhRledVuH5o4JPx+082QBy1fSB1rqpvdH1U5fLiF6ZoorJWEj0ijMCIfER34sFxnnzq
         aWivhsLIrwhP/I9FMXOvCeL3A2VFkEkDrJZqPmcpX2/KC2n2t063WCzoO+noV76Kb+i5
         tZ3w==
X-Gm-Message-State: AC+VfDw2u+yTqc5T1/sgQUmcAWiSOGUmKVM6iMaR7Y3Y4M4bPvr95YIK
	p5Rw9p00K9D4hh53udDQD91PiA==
X-Google-Smtp-Source: ACHHUZ7ziclHwDVkDkGPplJtBQmutOUNirDXL2hy4oCYb5ut4DPYqVcS2phQzffGvbfAL1nwcRceSg==
X-Received: by 2002:a7b:cd11:0:b0:3f7:4961:52ad with SMTP id f17-20020a7bcd11000000b003f7496152admr9423484wmj.3.1686663722429;
        Tue, 13 Jun 2023 06:42:02 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a03e:3034:b6bf:fd8e? ([2a02:8011:e80c:0:a03e:3034:b6bf:fd8e])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8140763c7sm9378164wml.30.2023.06.13.06.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:42:02 -0700 (PDT)
Message-ID: <98bd7ece-2058-d4bf-dab9-fc566eb655b3@isovalent.com>
Date: Tue, 13 Jun 2023 14:42:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in
 perf_event link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-11-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230612151608.99661-11-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-12 15:16 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Enhance bpftool to display comprehensive information about exposed
> perf_event links, covering uprobe, kprobe, tracepoint, and generic perf=

> event. The resulting output will include the following details:
>=20
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event_type software  event_config cpu-clock
>         bpf_cookie 0
>         pids perf_event(1379330)
> 4: perf_event  prog 14
>         event_type hw-cache  event_config LLC-load-misses
>         bpf_cookie 0
>         pids perf_event(1379330)
> 5: perf_event  prog 14
>         event_type hardware  event_config cpu-cycles
>         bpf_cookie 0
>         pids perf_event(1379330)
> 6: perf_event  prog 20
>         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
>         bpf_cookie 0
>         pids uprobe(1379706)
> 7: perf_event  prog 21
>         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
>         bpf_cookie 0
>         pids uprobe(1379706)
> 8: perf_event  prog 27
>         tp_name sched_switch
>         bpf_cookie 0
>         pids tracepoint(1381734)
> 10: perf_event  prog 43
>         retprobe 0  func_name kernel_clone  addr ffffffffad0a9660

Could we swap the name and the address, for consistency with the
kprobe_multi case?

Also do we really need the "_name" suffix in "func_name" and "file_name"
for plain output? I don't mind in JSON, but I think the result is a bit
long for plain output.

>         bpf_cookie 0
>         pids kprobe(1384186)
> 11: perf_event  prog 41
>         retprobe 1  func_name kernel_clone  addr ffffffffad0a9660
>         bpf_cookie 0
>         pids kprobe(1384186)
>=20
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","even=
t_config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"perf_=
event"}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache=
","event_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":1379330,=
"comm":"perf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_ty=
pe":"hardware","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":=
1379330,"comm":"perf_event"}]},{"id":6,"type":"perf_event","prog_id":20,"=
retprobe":0,"file_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,"bp=
f_cookie":0,"pids":[{"pid":1379706,"comm":"uprobe"}]},{"id":7,"type":"per=
f_event","prog_id":21,"retprobe":1,"file_name":"/home/yafang/bpf/uprobe/a=
=2Eout","offset":4920,"bpf_cookie":0,"pids":[{"pid":1379706,"comm":"uprob=
e"}]},{"id":8,"type":"perf_event","prog_id":27,"tp_name":"sched_switch","=
bpf_cookie":0,"pids":[{"pid":1381734,"comm":"tracepoint"}]},{"id":10,"typ=
e":"perf_event","prog_id":43,"retprobe":0,"func_name":"kernel_clone","off=
set":0,"addr":18446744072317736544,"bpf_cookie":0,"pids":[{"pid":1384186,=
"comm":"kprobe"}]},{"id":11,"type":"perf_event","prog_id":41,"retprobe":1=
,"func_name":"kernel_clone","offset":0,"addr":18446744072317736544,"bpf_c=
ookie":0,"pids":[{"pid":1384186,"comm":"kprobe"}]}]
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
> 3: perf_event  prog 14
>         event_type software  event_config cpu-clock
> 4: perf_event  prog 14
>         event_type hw-cache  event_config LLC-load-misses
> 5: perf_event  prog 14
>         event_type hardware  event_config cpu-cycles
> 6: perf_event  prog 20
>         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> 7: perf_event  prog 21
>         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> 8: perf_event  prog 27
>         tp_name sched_switch
> 10: perf_event  prog 43
>         retprobe 0  func_name kernel_clone
> 11: perf_event  prog 41
>         retprobe 1  func_name kernel_clone
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 213 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 213 insertions(+)
>=20
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 0015582..c16f71d 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -15,6 +15,7 @@
>  #include "json_writer.h"
>  #include "main.h"
>  #include "xlated_dumper.h"
> +#include "perf.h"
> =20
>  static struct hashmap *link_table;
>  static struct dump_data dd =3D {};
> @@ -207,6 +208,109 @@ static int cmp_u64(const void *A, const void *B)
>  	jsonw_end_array(json_wtr);
>  }
> =20
> +static void
> +show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> +{
> +	jsonw_uint_field(wtr, "retprobe", info->kprobe.flags & 0x1);

"retprobe" should likely be a boolean here too (and below), I don't see
them taking any other values than 0 or 1?

> +	jsonw_string_field(wtr, "func_name",
> +			   u64_to_ptr(info->kprobe.func_name));
> +	jsonw_uint_field(wtr, "offset", info->kprobe.offset);
> +	jsonw_uint_field(wtr, "addr", info->kprobe.addr);
> +}
> +
> +static void
> +show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t =
*wtr)
> +{
> +	jsonw_uint_field(wtr, "retprobe", info->uprobe.flags & 0x1);
> +	jsonw_string_field(wtr, "file_name",
> +			   u64_to_ptr(info->uprobe.file_name));
> +	jsonw_uint_field(wtr, "offset", info->uprobe.offset);
> +}
> +
> +static void
> +show_perf_event_tp_json(struct bpf_link_info *info, json_writer_t *wtr=
)
> +{
> +	jsonw_string_field(wtr, "tp_name",
> +			   u64_to_ptr(info->tracepoint.tp_name));
> +}
> +
> +static const char *perf_config_hw_cache_str(__u64 config)

The returned "str" is not a "const char *"? Why not simply a "char *"
and avoiding the cast when we free() it?

> +{
> +#define PERF_HW_CACHE_LEN 128

Let's move the #define to the top of the file, please.

> +	const char *hw_cache, *result, *op;
> +	char *str =3D malloc(PERF_HW_CACHE_LEN);
> +
> +	if (!str) {
> +		p_err("mem alloc failed");
> +		return NULL;
> +	}
> +	hw_cache =3D perf_hw_cache_str(config & 0xff);
> +	if (hw_cache)
> +		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
> +	else
> +		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
> +	op =3D perf_hw_cache_op_str((config >> 8) & 0xff);
> +	if (op)
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%s-", op);
> +	else
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%lld-", (config >> 8) & 0xff);
> +	result =3D perf_hw_cache_op_result_str(config >> 16);
> +	if (result)
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%s", result);
> +	else
> +		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
> +			 "%lld", config >> 16);
> +
> +	return str;
> +}
> +
> +static const char *perf_config_str(__u32 type, __u64 config)
> +{
> +	const char *perf_config;
> +
> +	switch (type) {
> +	case PERF_TYPE_HARDWARE:
> +		perf_config =3D perf_hw_str(config);
> +		break;
> +	case PERF_TYPE_SOFTWARE:
> +		perf_config =3D perf_sw_str(config);
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
> +	__u64 config =3D info->perf_event.config;
> +	__u32 type =3D info->perf_event.type;
> +	const char *perf_type, *perf_config;
> +
> +	perf_type =3D perf_type_str(type);
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
> @@ -262,6 +366,16 @@ static int show_link_close_json(int fd, struct bpf=
_link_info *info)
>  	case BPF_LINK_TYPE_KPROBE_MULTI:
>  		show_kprobe_multi_json(info, json_wtr);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> +			show_perf_event_event_json(info, json_wtr);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT)
> +			show_perf_event_tp_json(info, json_wtr);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE)
> +			show_perf_event_kprobe_json(info, json_wtr);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE)
> +			show_perf_event_uprobe_json(info, json_wtr);

It would be clearer to me with another switch/case I think (same for
plain output), but I don't mind much.

> +		break;
>  	default:
>  		break;
>  	}
> @@ -433,6 +547,71 @@ static void show_kprobe_multi_plain(struct bpf_lin=
k_info *info)
>  	}
>  }
> =20
> +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +	__u32 retprobe;
> +
> +	buf =3D (const char *)u64_to_ptr(info->kprobe.func_name);
> +	if (buf[0] =3D=3D '\0' && !info->kprobe.addr)
> +		return;
> +
> +	retprobe =3D info->kprobe.flags & 0x1;
> +	printf("\n\tretprobe %u  func_name %s  ", retprobe, buf);
> +	if (info->kprobe.offset)
> +		printf("offset %#x  ", info->kprobe.offset);
> +	if (info->kprobe.addr)
> +		printf("addr %llx  ", info->kprobe.addr);
> +}
> +
> +static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +	__u32 retprobe;
> +
> +	buf =3D (const char *)u64_to_ptr(info->uprobe.file_name);
> +	if (buf[0] =3D=3D '\0')
> +		return;
> +
> +	retprobe =3D info->uprobe.flags & 0x1;
> +	printf("\n\tretprobe %u  file_name %s  ", retprobe, buf);
> +	if (info->uprobe.offset)
> +		printf("offset %#x  ", info->kprobe.offset);
> +}
> +
> +static void show_perf_event_tp_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +
> +	buf =3D (const char *)u64_to_ptr(info->tracepoint.tp_name);
> +	if (buf[0] =3D=3D '\0')
> +		return;
> +
> +	printf("\n\ttp_name %s  ", buf);
> +}
> +
> +static void show_perf_event_event_plain(struct bpf_link_info *info)
> +{
> +	__u64 config =3D info->perf_event.config;
> +	__u32 type =3D info->perf_event.type;
> +	const char *perf_type, *perf_config;
> +
> +	perf_type =3D perf_type_str(type);
> +	if (perf_type)
> +		printf("\n\tevent_type %s  ", perf_type);
> +	else
> +		printf("\n\tevent_type %u  ", type);
> +
> +	perf_config =3D perf_config_str(type, config);
> +	if (perf_config)
> +		printf("event_config %s  ", perf_config);
> +	else
> +		printf("event_config %llu  ", config);
> +
> +	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
> +		free((void *)perf_config);
> +}
> +
>  static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  {
>  	struct bpf_prog_info prog_info;
> @@ -481,6 +660,16 @@ static int show_link_close_plain(int fd, struct bp=
f_link_info *info)
>  	case BPF_LINK_TYPE_KPROBE_MULTI:
>  		show_kprobe_multi_plain(info);
>  		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> +			show_perf_event_event_plain(info);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT)
> +			show_perf_event_tp_plain(info);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE)
> +			show_perf_event_kprobe_plain(info);
> +		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE)
> +			show_perf_event_uprobe_plain(info);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -508,6 +697,7 @@ static int do_show_link(int fd)
>  	int err;
> =20
>  	memset(&info, 0, sizeof(info));
> +	buf[0] =3D '\0';
>  again:
>  	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
>  	if (err) {
> @@ -542,7 +732,30 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
> +		if (info.perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> +			goto out;
> +		if (info.perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
> +		    !info.tracepoint.tp_name) {
> +			info.tracepoint.tp_name =3D (unsigned long)&buf;
> +			info.tracepoint.name_len =3D sizeof(buf);
> +			goto again;
> +		}
> +		if (info.perf_link_type =3D=3D BPF_PERF_LINK_KPROBE &&
> +		    !info.kprobe.func_name) {
> +			info.kprobe.func_name =3D (unsigned long)&buf;
> +			info.kprobe.name_len =3D sizeof(buf);
> +			goto again;
> +		}
> +		if (info.perf_link_type =3D=3D BPF_PERF_LINK_UPROBE &&
> +		    !info.uprobe.file_name) {
> +			info.uprobe.file_name =3D (unsigned long)&buf;
> +			info.uprobe.name_len =3D sizeof(buf);

Maybe increase the size of buf to accommodate for long paths?

> +			goto again;
> +		}
> +	}
> =20
> +out:
>  	if (json_output)
>  		show_link_close_json(fd, &info);
>  	else

Thanks for this work!

