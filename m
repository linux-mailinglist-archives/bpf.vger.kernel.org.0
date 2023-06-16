Return-Path: <bpf+bounces-2770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37B733B0C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 22:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208A4281568
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C6463C4;
	Fri, 16 Jun 2023 20:41:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3D2109
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 20:41:41 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8E3A91;
	Fri, 16 Jun 2023 13:41:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so9322021fa.0;
        Fri, 16 Jun 2023 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686948098; x=1689540098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki5b2++CnhmaytZ7my3uDRSJyQZZ4BLsbJIbBjIvEhw=;
        b=Y1gz+I0eAGdt3SPU8fv7HZvYNAYbSgesd0UPhimP2S60FaqzDcRVTUweO9JRmf5+d4
         CVDfuYIKN0OiLhjwniWt3jOqX5Z/r0NcTRyTeT8c7ZdzCVFfv6zMRKi7zAxHOj8VQHSY
         JajixoVED3R9oILpmOZB8Zz7fKkulvFRcpUb6OYjWjpwXCPROYXGbSr62YrlBbiDQdeK
         HEpSm2hVlXVaKGwb8gYs+Oplpk4PDmNx6opnTlywgS3wXDhXAmWcLTQE9G9tXLUddf2G
         3+fK9IjbGkGWq5231pxVCtH2Fit0fWqlPwdIOYx/SyVLmeu3kO1v6idIgZqGdjYzW8BJ
         oKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948098; x=1689540098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki5b2++CnhmaytZ7my3uDRSJyQZZ4BLsbJIbBjIvEhw=;
        b=EH/D/+OEVbp3cN22TDflMIC/tySl5wNbo17RI+s3GFf+u2d97NHnlQwCiqXewtvFfh
         WmBAu7olIb3mwo8b6QIfqhF2DyQ2PPr6cz54WP59CRZdm/1hcx16c3d9fiAyZAosI25u
         OJB82XAuEHi+rF+6ga58Mc5BjU6QbdzK2ysVQHkXDI5G7MEHNRwM22+JMM1X48Sdf3de
         egDsQFh2TMc2DAe0dCe6ShiRoKkji1UTnN4qobgsnJg1A1FE2rPqG4g0O0+exRy6RWvq
         3E/RcyJMaoVYdPTwPMndkgWYy1pFAdPnbmut4QL24ijPHKngSkV31ZPruOP4KaL9G27n
         kihw==
X-Gm-Message-State: AC+VfDx3IjJBQKiyJPv5p5BYy073kRN+3hJjQCNHXRXIuMUGZ/PT+2UI
	lvd6kpxvOf0yvMOfaVzRwahciMhYtZUSqKwRPLY=
X-Google-Smtp-Source: ACHHUZ5naXwCp1m0N1E8kO1pncwEcJ+uz0TRmeUU77f85NsMGlyQVxGksnWUS+hfPUvyK1VniLF8sw7CJzmlpgOYwhc=
X-Received: by 2002:a2e:6e07:0:b0:2b1:ed29:7c47 with SMTP id
 j7-20020a2e6e07000000b002b1ed297c47mr2498336ljc.8.1686948097905; Fri, 16 Jun
 2023 13:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-11-laoar.shao@gmail.com>
In-Reply-To: <20230612151608.99661-11-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 13:41:26 -0700
Message-ID: <CAEf4BzYTxEeaXLLajU-ka=OxPVh4LZERq210_A75mDZH+7t-yg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in
 perf_event link info
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Enhance bpftool to display comprehensive information about exposed
> perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
> event. The resulting output will include the following details:
>
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

how about

"event hardware:cpu-cycles" for events

>         bpf_cookie 0
>         pids perf_event(1379330)
> 6: perf_event  prog 20
>         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x133=
8

for uprobes: "uprobe /home/yafang/bpf/uprobe/a.out+0x1338"
for retprobes: "uretprobe /home/yafang/bpf/uprobe/a.out+0x1338"

>         bpf_cookie 0
>         pids uprobe(1379706)
> 7: perf_event  prog 21
>         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x133=
8
>         bpf_cookie 0
>         pids uprobe(1379706)
> 8: perf_event  prog 27
>         tp_name sched_switch

"tracepoint  sched_switch" ?

>         bpf_cookie 0
>         pids tracepoint(1381734)
> 10: perf_event  prog 43
>         retprobe 0  func_name kernel_clone  addr ffffffffad0a9660

similar to uprobes:

"kprobe kernel_clone  0xffffffffad0a9660"
"kretprobe kernel_clone  0xffffffffad0a9660"


That is, make this more human readable instead of mechanically
translated from kernel info? retprobe 1/0 is quite cumbersome,
"uprobe" vs "uretprobe" makes more sense?

JSON is where it could be completely mechanically translated, IMO.

>         bpf_cookie 0
>         pids kprobe(1384186)
> 11: perf_event  prog 41
>         retprobe 1  func_name kernel_clone  addr ffffffffad0a9660
>         bpf_cookie 0
>         pids kprobe(1384186)
>
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","event_=
config":"cpu-clock","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"perf_even=
t"}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache","eve=
nt_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"=
perf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":"hardw=
are","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":1379330,"com=
m":"perf_event"}]},{"id":6,"type":"perf_event","prog_id":20,"retprobe":0,"f=
ile_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pid=
s":[{"pid":1379706,"comm":"uprobe"}]},{"id":7,"type":"perf_event","prog_id"=
:21,"retprobe":1,"file_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,=
"bpf_cookie":0,"pids":[{"pid":1379706,"comm":"uprobe"}]},{"id":8,"type":"pe=
rf_event","prog_id":27,"tp_name":"sched_switch","bpf_cookie":0,"pids":[{"pi=
d":1381734,"comm":"tracepoint"}]},{"id":10,"type":"perf_event","prog_id":43=
,"retprobe":0,"func_name":"kernel_clone","offset":0,"addr":1844674407231773=
6544,"bpf_cookie":0,"pids":[{"pid":1384186,"comm":"kprobe"}]},{"id":11,"typ=
e":"perf_event","prog_id":41,"retprobe":1,"func_name":"kernel_clone","offse=
t":0,"addr":18446744072317736544,"bpf_cookie":0,"pids":[{"pid":1384186,"com=
m":"kprobe"}]}]
>
> For generic perf events, the displayed information in bpftool is limited =
to
> the type and configuration, while other attributes such as sample_period,
> sample_freq, etc., are not included.
>
> The kernel function address won't be exposed if it is not permitted by
> kptr_restrict. The result as follows when kptr_restrict is 2.
>
> $ tools/bpf/bpftool/bpftool link show
> 3: perf_event  prog 14
>         event_type software  event_config cpu-clock
> 4: perf_event  prog 14
>         event_type hw-cache  event_config LLC-load-misses
> 5: perf_event  prog 14
>         event_type hardware  event_config cpu-cycles
> 6: perf_event  prog 20
>         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x133=
8
> 7: perf_event  prog 21
>         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x133=
8
> 8: perf_event  prog 27
>         tp_name sched_switch
> 10: perf_event  prog 43
>         retprobe 0  func_name kernel_clone
> 11: perf_event  prog 41
>         retprobe 1  func_name kernel_clone
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 213 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 213 insertions(+)
>

[...]

