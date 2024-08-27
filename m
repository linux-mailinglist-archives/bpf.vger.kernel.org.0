Return-Path: <bpf+bounces-38124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C799601A0
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C480B22337
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 06:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A51494CF;
	Tue, 27 Aug 2024 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U7iqJL6r"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2040.outbound.protection.outlook.com [40.92.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2614830A;
	Tue, 27 Aug 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740066; cv=fail; b=qIZE6ZIBWg9jum7KT4UWr4C5j5p7BLxWUdfrA56wU2vSZ0JMk8UWiznuxF1XX+ewXg+Rt+KgtoMFZAJU8mjfJFgsurtbrW0E000aP2zjfDflg2pBWGAnSjRMT6e5km3ssECHTIBgunG2HYLD9JGej4jkl+4pgcDulDqKCooVhz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740066; c=relaxed/simple;
	bh=dG6KUzoVX0uoguPC0ZJrwj4D+bZbEpqDfEPVFewAOnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFlvl65Dpi7r1LtHdo2mqdGKCQNAth/Xi6v+DCUvVoUk80O36Z0GsxbN+SCLWTjng8SJq5TT8p6jEyY6CWN38yQW9p2RN89nrNPkwqSjYWnJ1zVZgDXi4h2AY/20fwPVJ13KO8BJYnK5fTpa3dLQoSoHUq5s48UpeyWFc6tOiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U7iqJL6r; arc=fail smtp.client-ip=40.92.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvMOLBdVX5GNjYqQnGKAJ0iTlzYAiD4/tvwHPSx3oXBcaS+gRekMRo/i24hcqWb0IrBKhAkSqJg2B22YlT4aUdZhokQ/odh5dkm049TxPQYlq1+ivEEF5XWJwcMwm/wQl881TDZ0YxUPem3xhzKkaLm4KPAJJPJ070Lh0Fy/mZ1lgzSl7GYOqWN5AB6PcvDC/r8/1/hAxqOkcH3nI9k4YtWcXyHJX5aJpvFbwrTJxw/p/jxsr0q6MrjhRPbhUHv9KOrTvAB22KeE3jGOCGzTAG1On9oPfiO9sDhGEcNx1BKpSgNcMNDULhYS/U73IqELxxGtpE3YZEL9Efpo8gVZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKKScbzFz3rKarkbFxP3sHNGt8W49fKfyipjczfrQwk=;
 b=Buv0iN0o7hRCldcu2P9eQSUAeIsNUkdy5Y38XsvOm7uKbny+b6ooZDujBChJOqgSPYJ0NwC15t/s8bze/zV6dcDPyDg6QZrzIuygBbKFaJuEpkcM0BpiaH46KmShv8T8H1z8rmV5EXLI7CJUT12XbdYfD2Qs52NDbX2mpUTg9s3V2HJQnV8/3hp76Ku2hv7KT1H5tsbx1Wlm//nRALIIWS/C3jJ4fFyYtzQcBbw76mg60r8lstQDwcfurTKlekKqQLfUf/j04IM+hGxTfvByXHfGHLnwxJ9HTi2FAMd1lbChggj1GXUcg1HSfP3aOwflli7mF648WsSrQS3qRm2N6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKKScbzFz3rKarkbFxP3sHNGt8W49fKfyipjczfrQwk=;
 b=U7iqJL6rEwaJx2SV/cO39+3wkJWgQYTSbiNp+RSut5G79iBiL051C6oXGA1kcxBptom6yUY3JeEwVsdImzy//YG/AJ4X36tcSNcYC9G+XALFqTJ0gf9sE6bS441LYJxqR5sIMvjfhBzf3u48igs+LswgdJ0HuyqKbq20G3Xoi4BPgv8qzMLdF0IN1I3ocvWyYODG81R74vctvglcvJkYX9ad9HazzIDUJ70ZsmmK+3itoeZMGAd0CQiEPkCjw7o6rAba4pWEfFzpY/0nxKUbNe3AiEjdkNy1r27tYYnEHDnVvdKzdWaOWOn9SpY9Kw8UaHLxINpIRxIMX5eGi2mnBA==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY8P300MB0357.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:27:39 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:27:39 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: oleg@redhat.com
Cc: ajor@meta.com,
	albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org,
	flaniel@linux.microsoft.com,
	i.pear@outlook.com,
	linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	olsajiri@gmail.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Tue, 27 Aug 2024 14:27:24 +0800
Message-ID:
 <ME0P300MB04166AF6F0F8AA91D81221DB9D942@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826212552.GB30765@redhat.com>
References: <20240826212552.GB30765@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kc2sGG0L1wBfQnTJEaO1vxnd8aVOPYKb6XXyvrLM19Mzo0xYrZnecw==]
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240827062724.194765-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY8P300MB0357:EE_
X-MS-Office365-Filtering-Correlation-Id: ef034324-eaf3-40cd-0de1-08dcc6615909
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|8060799006|5072599009|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	W/iUsaWSIgesC+mUBAzqLwqiDHBqAcgUp5xUsbBstIlzxjHCj2ssX4iBOe+kzaNibLH+gPHortOIW8h8ry0P2jiTkodPxctogv1EEzYsWxcN39iCom9+NO+Q6SGdqiwFvvK2s6bsRljBE57Oc3OnlepODy85M9FxcjOTYyZYbAe5P82akALaBiCxh0Lha0Mo9zlados2k0RTh2NAtFEfX1v+0re1T0r0tzUOq8shZZ/gk/gAaeWiv6iRACtzGWKqHNJUeCjuquleh0BiSjjok1GDyGoGu+bzNv3E8/sHY27bMtt2GtHmqTay5FxWlRpM3NFcNWR6/0OuHg25choCem8FQwrzwJCDx2dCQcIJlUdY1S9fMoAK4XXsX+vDyY+GNCDNiJ8nNh+jBspayVeeGmLpQ88fQUyDHu6elfd/deTatEXFXk0QyYv2rf1FLuzt/w0B4I1hh5BDGbTPTTGgS9djYK60NkMr4ajDT6YMA+KWIXmgG5BFrs2RzIzOEQq9/HNoxuJYUMQJ3amk4qhDBzOt69Mi7BOB8n6BhhVIeW/tDb7GHY+52TW1E6D1sC8ilAoPqSlFkB2V2oUJnp7pljEeejMPeQwpABWvSSs4CgZkDS/47mkhlLUzRZbZ2EC4TYXiVKAz2eJV8NAnVdolkAGyPVAP7kKpipHTLHWNWftU/GfY4iIgQZLMnUFLi42UsUUcdZaUi+FLxHjfYqmQlrw7/ivaXC5j7YA7fWEuv/CQBChRFD/BJqdzz7XZAQ5W3CyhQfP4xsMAuB0VTlN+lsieU5KziAk4r3Jk+0Hq1OBFOCTay1RzEnHoX+xADHUzyXZW8w9qHmoclUtBprUwnA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ts7QCRfcdLNdkJO8kkdm0BSYdZmUf37Lgbzy/sk4e670epOBiKzxVw0r3ElX?=
 =?us-ascii?Q?zGUOkU/SxOrRGkk9p5VBCNvYArqRw0AdNDvtgunyFlnZl/0HItGpw7AuvF8w?=
 =?us-ascii?Q?OI76TRqnsKRrHT15whryubXxbliD4Aa1qlEuHEqmx4YJZjEJuKk9t2GU8KHI?=
 =?us-ascii?Q?BfcBksK8Y/Ii8+mVm+LF62o2lXsE6zEav+YyDCfZdHGVSMVZzDRPxT+TF4t/?=
 =?us-ascii?Q?PKY/1klZXTZ1H37d2nLu7nzKne+tu2htj0qiQLC8QQ9RN2ZuCuS4ki3TOujE?=
 =?us-ascii?Q?Bk0ZdFz4iGIecfcDaTB592nmjG51ogOXMEzgM/Ny6wTs+3wVfcQLyt9eC1cH?=
 =?us-ascii?Q?Ou+t75mP6KL+8K++tSGBKlT6uIVNLsFxnR59iBxz/VDbP9CT7JHdZH6cXYGy?=
 =?us-ascii?Q?jXTUMIslzds7SSIaQki0ar9pQ0BF0rzWvJei0UJROnNwUyiN1c95OAsSzx/j?=
 =?us-ascii?Q?5ceanWRMyzw0iX1wP+mkzea7RqqnmxjHOjs8OwedtCuysuTzZagQOTMbU66a?=
 =?us-ascii?Q?wAhKuE6pBm/VfUam2sSvYJANL0u/WJ9UBLXB+Ebq4SgBYEYWIC0Kd2zWE6oI?=
 =?us-ascii?Q?OJNGWi4Q5UPgGu+Otf3aBqFaJ7Xz81t0xzGAlEhGRhS1uug5DCnczUKhRtvD?=
 =?us-ascii?Q?kTqfAqJG7IjaYrcu30AFfb6DdporLWPqpdsket0j7UIorQGJnNG42ANipq67?=
 =?us-ascii?Q?53bmplCxqm/jXEVPFuCPQFuhpDXAse5J5g4Q/YTG+geu3ZHjbbxL0WMH7F8h?=
 =?us-ascii?Q?VzXuFo/i2Snl7CR4XDrNvSxxhdRVfmtPzDddLFRMKXczt736UWhp2d5kKr9Z?=
 =?us-ascii?Q?i3opw40r8w7d1JQ8x3m8szzVFmEypgH0fLar+4bjIW+OXmYxgaw6AqJabLGx?=
 =?us-ascii?Q?66Kog5VZ/RHfJNuwa5y1kzht9Z9vhmS4ObmAKFG1gRdvNUHXDMne0nXtdBdh?=
 =?us-ascii?Q?gWqIbWdNwfsVTCKUGxfPIrQc5gm0LxlrOMi9vU/SZF6lYfCYNxKi1tO/1wkU?=
 =?us-ascii?Q?pSrK/bym0kcaXNhE/X+wcz0D0eHW780XCoRVFVmMl/rUyZ+bdTbcwq/DMoQZ?=
 =?us-ascii?Q?0bM6yGA3beifXP4QBkgA6wyexKAIyZg9OjfYr5Q6Q1hrlmUYY5Oe4pz9Ho6G?=
 =?us-ascii?Q?hVP9qHXnFlXGoR/EfRGOUnqh8xd5yJJ4Po8LmGRW8RapWxiYs70SctyNR9y+?=
 =?us-ascii?Q?eV2QNVmvyER1KYI2P7+B9b7NJrxtE+06YLmivQCuqK4LZpPx4iNzEhb1XD3k?=
 =?us-ascii?Q?QaBSfnHHu64NPNWM+ceJ/xTN7oWj8k7guAOPQWMQUA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef034324-eaf3-40cd-0de1-08dcc6615909
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:27:39.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0357

On 08/27 05:26, Oleg Nesterov wrote:
>    __uprobe_register+1
>    probe_event_enable+399
>    perf_trace_event_init+440
>    perf_uprobe_init+152
>    perf_uprobe_event_init+74
>    perf_try_init_event+71
>    perf_event_alloc+1681
>    __do_sys_perf_event_open+447
>    do_syscall_64+130
>    entry_SYSCALL_64_after_hwframe+118
> 
> so it seems that bpftrace doesn't use bpf_uprobe_multi_link_attach()
> (called by sys_bpf(BPF_LINK_CREATE) ?) in this case.

I'm using bpftrace v0.21.2 with "uprobe_multi: no", and I got the same
stack as yours.

When I use strace to trace bpftrace, I get:
```
$ strace bpftrace -p 38962 -e 'uretprobe:libc:malloc { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }' 2>&1 | grep perf_event_open
perf_event_open({type=0x7 /* PERF_TYPE_??? */, size=0x88 /* PERF_ATTR_SIZE_??? */,config=0x1, sample_period=1, 
sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, ...}, 38962, -1, -1, PERF_FLAG_FD_CLOEXEC) = 12

$ cat /sys/bus/event_source/devices/uprobe/type 
7
```

Here bpftrace is using "uprobe" as the event type, which is registered in
```
static struct pmu perf_uprobe = {
	.task_ctx_nr	= perf_sw_context,
	.event_init	= perf_uprobe_event_init,
	.add		= perf_trace_add,
	.del		= perf_trace_del,
	.start		= perf_swevent_start,
	.stop		= perf_swevent_stop,
	.read		= perf_swevent_read,
	.attr_groups	= uprobe_attr_groups,
};
perf_pmu_register(&perf_uprobe, "uprobe", -1);
```

While I use strace for perf, I get:
```
$ strace perf trace -e probe_libc:malloc__return -p 38962 2>&1 |grep perf_event_open
[...]
perf_event_open({type=PERF_TYPE_TRACEPOINT, size=0x88 /* PERF_ATTR_SIZE_??? */, config=1641, sample_period=1, 
sample_type=PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_CPU|PERF_SAMPLE_PERIOD|PERF_SAMPLE_RAW, 
read_format=PERF_FORMAT_ID, disabled=1, mmap=1, comm=1, task=1, precise_ip=0 /* arbitrary skid */, sample_id_all=1, 
exclude_guest=1, mmap2=1, comm_exec=1, ksymbol=1, bpf_event=1, ...}, 38962, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
```

The PERF_TYPE_TRACEPOINT is registered in:
```
static struct pmu perf_tracepoint = {
	.task_ctx_nr	= perf_sw_context,
	.event_init	= perf_tp_event_init,
	.add		= perf_trace_add,
	.del		= perf_trace_del,
	.start		= perf_swevent_start,
	.stop		= perf_swevent_stop,
	.read		= perf_swevent_read,
};
perf_pmu_register(&perf_tracepoint, "tracepoint", PERF_TYPE_TRACEPOINT);
```

So there's a slight difference between the event types being used. I 
haven't found the connection between this and the filtering, just WFI.

By the way, I used bpftrace just for convenience in reproducing the issue.
This bug was originally discovered while using cilium/ebpf (a golang ebpf
library), which also uses "uprobe" as the event type [1].

[1] https://github.com/cilium/ebpf/blob/main/link/kprobe.go#L251

