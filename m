Return-Path: <bpf+bounces-4031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF7748036
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFC280F9B
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71E46B2;
	Wed,  5 Jul 2023 08:55:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FC20E8
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:55:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA33171D;
	Wed,  5 Jul 2023 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=k+aNtxK2HcEksDu8tXRWO4vxzo2tYmq+QOVL0QIH2gQ=; b=S2PrZSmNtj+6G8XENDctH2m3ZJ
	f6qajHfW0iI4LryOuIgTfOqlFYjdoNSc211xUnkxZcarCI4BvyV49l4wjCmiV8G6t0IaEC5Hrp6Jo
	Eq6qNw4ultRyAHCouSJUifI2qiUyUZIKGE0Zzm6yE4McI0KfvZMiyWViaVrYt255lj0Djpji6KHiN
	0pyMkzBMzf90xdT55lZTUye6874bOzXVtkODJo7ObFVc7WeN7prCE7wZAd94w8tsh77Y4JSro15ld
	lHUT7OljcruUMB2urPmimMqPKSIhq/eyqAIu3eC+YPsh01nQY8ZIPrMmQ8g7DELeeRpH4pRfPGoIb
	Kby0tkNA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyHq-0002sJ-Lr; Wed, 05 Jul 2023 10:54:58 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGyHq-000FLL-3d; Wed, 05 Jul 2023 10:54:58 +0200
Subject: Re: [PATCH v6 bpf-next 11/11] bpftool: Show perf link info
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-12-laoar.shao@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d991de64-ebdd-bb65-482a-aae64459c739@iogearbox.net>
Date: Wed, 5 Jul 2023 10:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230628115329.248450-12-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/28/23 1:53 PM, Yafang Shao wrote:
[...]
> +
> +static void
> +show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +	__u64 config = info->perf_event.event.config;
> +	__u32 type = info->perf_event.event.type;
> +	const char *perf_type, *perf_config;
> +
> +	perf_type = perf_event_name(perf_type_name, type);
> +	if (perf_type)
> +		jsonw_string_field(wtr, "event_type", perf_type);
> +	else
> +		jsonw_uint_field(wtr, "event_type", type);
> +
> +	perf_config = perf_config_str(type, config);
> +	if (perf_config)
> +		jsonw_string_field(wtr, "event_config", perf_config);
> +	else
> +		jsonw_uint_field(wtr, "event_config", config);
> +
> +	if (type == PERF_TYPE_HW_CACHE && perf_config)
> +		free((void *)perf_config);

nit no need to cast

> +}
> +
>   static int show_link_close_json(int fd, struct bpf_link_info *info)
>   {
>   	struct bpf_prog_info prog_info;
> @@ -334,6 +440,26 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>   	case BPF_LINK_TYPE_KPROBE_MULTI:
>   		show_kprobe_multi_json(info, json_wtr);
>   		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		switch (info->perf_event.type) {
> +		case BPF_PERF_EVENT_EVENT:
> +			show_perf_event_event_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_TRACEPOINT:
> +			show_perf_event_tracepoint_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_KPROBE:
> +		case BPF_PERF_EVENT_KRETPROBE:
> +			show_perf_event_kprobe_json(info, json_wtr);
> +			break;
> +		case BPF_PERF_EVENT_UPROBE:
> +		case BPF_PERF_EVENT_URETPROBE:
> +			show_perf_event_uprobe_json(info, json_wtr);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
> @@ -505,6 +631,75 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>   	}
>   }
>   
> +static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +
> +	buf = (const char *)u64_to_ptr(info->perf_event.kprobe.func_name);

ditto, same for the other occurrences further below

> +	if (buf[0] == '\0' && !info->perf_event.kprobe.addr)
> +		return;
> +
> +	if (info->perf_event.type == BPF_PERF_EVENT_KRETPROBE)
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
> +	buf = (const char *)u64_to_ptr(info->perf_event.uprobe.file_name);
> +	if (buf[0] == '\0')
> +		return;
> +
> +	if (info->perf_event.type == BPF_PERF_EVENT_URETPROBE)
> +		printf("\n\turetprobe ");
> +	else
> +		printf("\n\tuprobe ");
> +	printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
> +}
> +
> +static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
> +{
> +	const char *buf;
> +
> +	buf = (const char *)u64_to_ptr(info->perf_event.tracepoint.tp_name);
> +	if (buf[0] == '\0')
> +		return;
> +
> +	printf("\n\ttracepoint %s  ", buf);
> +}
> +
> +static void show_perf_event_event_plain(struct bpf_link_info *info)
> +{
> +	__u64 config = info->perf_event.event.config;
> +	__u32 type = info->perf_event.event.type;
> +	const char *perf_type, *perf_config;
> +
> +	printf("\n\tevent ");
> +	perf_type = perf_event_name(perf_type_name, type);
> +	if (perf_type)
> +		printf("%s:", perf_type);
> +	else
> +		printf("%u :", type);
> +
> +	perf_config = perf_config_str(type, config);
> +	if (perf_config)
> +		printf("%s  ", perf_config);
> +	else
> +		printf("%llu  ", config);
> +
> +	if (type == PERF_TYPE_HW_CACHE && perf_config)
> +		free((void *)perf_config);

same

> +}
> +
>   static int show_link_close_plain(int fd, struct bpf_link_info *info)
>   {
>   	struct bpf_prog_info prog_info;
> @@ -553,6 +748,26 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>   	case BPF_LINK_TYPE_KPROBE_MULTI:
>   		show_kprobe_multi_plain(info);
>   		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		switch (info->perf_event.type) {
> +		case BPF_PERF_EVENT_EVENT:
> +			show_perf_event_event_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_TRACEPOINT:
> +			show_perf_event_tracepoint_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_KPROBE:
> +		case BPF_PERF_EVENT_KRETPROBE:
> +			show_perf_event_kprobe_plain(info);
> +			break;
> +		case BPF_PERF_EVENT_UPROBE:
> +		case BPF_PERF_EVENT_URETPROBE:
> +			show_perf_event_uprobe_plain(info);
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
> @@ -575,11 +790,12 @@ static int do_show_link(int fd)
>   	struct bpf_link_info info;
>   	__u32 len = sizeof(info);
>   	__u64 *addrs = NULL;
> -	char buf[256];
> +	char buf[PATH_MAX];
>   	int count;
>   	int err;
>   
>   	memset(&info, 0, sizeof(info));
> +	buf[0] = '\0';
>   again:
>   	err = bpf_link_get_info_by_fd(fd, &info, &len);
>   	if (err) {
> @@ -614,6 +830,35 @@ static int do_show_link(int fd)
>   			goto again;
>   		}
>   	}
> +	if (info.type == BPF_LINK_TYPE_PERF_EVENT) {
> +		switch (info.perf_event.type) {
> +		case BPF_PERF_EVENT_TRACEPOINT:
> +			if (!info.perf_event.tracepoint.tp_name) {
> +				info.perf_event.tracepoint.tp_name = (unsigned long)&buf;

lets use ptr_to_u64() in all these cases

> +				info.perf_event.tracepoint.name_len = sizeof(buf);
> +				goto again;
> +			}
> +			break;
> +		case BPF_PERF_EVENT_KPROBE:
> +		case BPF_PERF_EVENT_KRETPROBE:
> +			if (!info.perf_event.kprobe.func_name) {
> +				info.perf_event.kprobe.func_name = (unsigned long)&buf;
> +				info.perf_event.kprobe.name_len = sizeof(buf);
> +				goto again;
> +			}
> +			break;
> +		case BPF_PERF_EVENT_UPROBE:
> +		case BPF_PERF_EVENT_URETPROBE:
> +			if (!info.perf_event.uprobe.file_name) {
> +				info.perf_event.uprobe.file_name = (unsigned long)&buf;
> +				info.perf_event.uprobe.name_len = sizeof(buf);
> +				goto again;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>   
>   	if (json_output)
>   		show_link_close_json(fd, &info);
> 


