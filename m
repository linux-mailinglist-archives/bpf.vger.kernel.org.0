Return-Path: <bpf+bounces-4027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F081A747F65
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7E281011
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B71946B2;
	Wed,  5 Jul 2023 08:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DB46AC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 08:20:12 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0BC1FD0;
	Wed,  5 Jul 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6ZsMSb8LwF0LXoceKsU9Xs/64Pe4Vz3mMpchj4lt+Nk=; b=BYoKJFpTvonJPVz5i79XoW2b3g
	63iV0yMLfGOUtdDr0UfM3sR7PAWxplsTfa0TMhct+mPs1j3HodHgayZ0I9C9O3mbv3CvHmGeRf0Ay
	8ouLqSlDJWUCm9DOGZUNYf3hQ+VOYUojntyLf5qxfDAW2GC87RDHgp5TaG+adsXJPd/wuTZE8svQm
	EEYPVoF9G9h9TQQQd4JE9nWZgTi78mwQkJLmoODIe9rohTF7xmNMNNdgPjJaHYJeP57OamjTNpAm4
	9V1vizoZuybw5qP7KvJCiLewZRJQa4C+IsmPfRdWyGIZh2W3LrzbeOFfR9p88iTj3G3vzHLhdqBtn
	2uxmwqUg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGxjD-0008g5-5Y; Wed, 05 Jul 2023 10:19:11 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGxjC-0005ac-Ji; Wed, 05 Jul 2023 10:19:10 +0200
Subject: Re: [PATCH v6 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-6-laoar.shao@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ed6bc64-ab80-486b-fb13-207174d9ff2d@iogearbox.net>
Date: Wed, 5 Jul 2023 10:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230628115329.248450-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/28/23 1:53 PM, Yafang Shao wrote:
> To avoid returning uninitialized or random values when querying the file
> descriptor (fd) and accessing probe_addr, it is necessary to clear the
> variable prior to its use.
> 
> Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   kernel/trace/bpf_trace.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1f9f78e1992f..ac9958907a7c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2382,10 +2382,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
>   						  event->attr.type == PERF_TYPE_TRACEPOINT);
>   #endif
>   #ifdef CONFIG_UPROBE_EVENTS
> -		if (flags & TRACE_EVENT_FL_UPROBE)
> +		if (flags & TRACE_EVENT_FL_UPROBE) {
>   			err = bpf_get_uprobe_info(event, fd_type, buf,
>   						  probe_offset,
>   						  event->attr.type == PERF_TYPE_TRACEPOINT);
> +			*probe_addr = 0x0;
> +		}

Could we make this a bit more robust by just moving the zero'ing into the common path?

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 03b7f6b8e4f0..795e16d5d2f7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2362,6 +2362,9 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
                 return -EOPNOTSUPP;

         *prog_id = prog->aux->id;
+       *probe_offset = 0x0;
+       *probe_addr = 0x0;
+
         flags = event->tp_event->flags;
         is_tracepoint = flags & TRACE_EVENT_FL_TRACEPOINT;
         is_syscall_tp = is_syscall_trace_event(event->tp_event);
@@ -2370,8 +2373,6 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
                 *buf = is_tracepoint ? event->tp_event->tp->name
                                      : event->tp_event->name;
                 *fd_type = BPF_FD_TYPE_TRACEPOINT;
-               *probe_offset = 0x0;
-               *probe_addr = 0x0;
         } else {
                 /* kprobe/uprobe */
                 err = -EOPNOTSUPP;

