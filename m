Return-Path: <bpf+bounces-38006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2795DBF8
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 07:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3181C2176C
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76D14B06C;
	Sat, 24 Aug 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kHz/MUEc"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2089.outbound.protection.outlook.com [40.92.63.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570182C80;
	Sat, 24 Aug 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724478592; cv=fail; b=qDMLBpAzQrq3wQyQWOGPRsi5fnyewWH/A6Xl0hE//BMkqIQxYkiQcraYRjXyWPwV91i3BqlDGXQ3je2Ka9oJ7mogX4DyjY5zz4hYiSVvBGd6ArbNWwIE1aXs+PknDpQEgiAYLH7L9uJ2jziW8aDvN0Ot8JBCCRpKTWGbAbyd1js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724478592; c=relaxed/simple;
	bh=48m3fxnQ23xBPxX+h+xGNs0BMtapxFWVivKCVilIwnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3x5V6m66t2kOhd8y+JxgbWJDstU4VFiP4BjRDlUqHXsAIPbIrbMLFyRmS40WYSj0MuZ6MOmMD4RE0mw6A6m9qJOqY1Pgey3T+0RNJSxqeOaaz/2YpcWu1A/GET0RObeXgPv+4Hfo3hc18HDzoXQnSkfhO2h9d+1WPYjXtoLpOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kHz/MUEc; arc=fail smtp.client-ip=40.92.63.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmusglfmwGEMREMElK/1TyN4Mk/k0ECKX0d1mSqmSG1+1cdz4GXmJ5EbcDsbmBq2q9uwkREAlEkVCyNiXJ5fq7DIavQO9a4p+wgO5SjGwQ8CEeXRl47cwsUtcMZ3+TKWdHNq18issc+z2bp6x+OSIFsHO/ForiOXUGcJWqW/WysHZl0whN6FlFK+Kjdtr5CRn4h9E+pNLn/fKufV0DZshVmTICI9i+/lllXn8tL3/o963sowHDwqz2IJ2X4AViLF84SDKDlnASbkdRVy7cPqDAaZW/HhoqdkCXwqX9IfcmAoUktMk82cP1KwuGkkhIKo+gYFOPznmI56dTF8ZBDE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U68NKtVVolN0tivb3sBHm6UKL9ZEz5OG9UClsRI8aIo=;
 b=SCC+qkTYFmK36cErK/PowGfnFuO839MmIIdza/wHMU2BWIitsDnoSKu8TwbeJpUSj3JFghlmczOrmkoVYY2s3dmXwR8/s0oHXaB1jSzcf/1iLLgAjlufcz28XUjcWN47liczE5MJXbgRdfQ0pEIGnKcSP24DXtlVX6uRTpE9lN7+eZS0B0XZGjGCQkCS1oaM4P+/BcbfFaMD5/VfCTV/cWWwEnxJOWI4iivn8NH3IXgAijD5xQlAHCgtRjViRuMK0w/Z+lj9VV0bBQoEQDDwWP581MXr2u670SEixotvRl5W3znwK3JhJ3HmwoHU+1G1VtQTSPH+AmDvdQOk49l78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U68NKtVVolN0tivb3sBHm6UKL9ZEz5OG9UClsRI8aIo=;
 b=kHz/MUEciHXXvu+C5t1xM2yxVrKuVDSN2h+ePbTgbJuM256+wwqyTyvkHhASSH+G7CQKqhxDywZQlfM09mG8DDmG0U3LChEN6Rpv3wnOCZWIkAnxisg4kumsYGa6SyuMEyFJFIu6Do7Ss46404+EqXaAflv02Tgq4FHKGiaE75YyPmsNOIKpP3zTWYHTFYJMX/LNB6eV2dPuJgGEUHOXqsn4fT1R70uMexcXZSj037sdo6vzid92RaWOPVoloLVyFgCzTbAd9wTK0a6Vkj0pZugko/ylvUtPMQiazeJ3kLAf+aBPrd0gmHCc0N6o1/v0VCNxji0Ca+kD/hhCh1uTJQ==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY8P300MB0760.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 05:49:44 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 05:49:44 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: andrii.nakryiko@gmail.com,
	mhiramat@kernel.org
Cc: ajor@meta.com,
	albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org,
	flaniel@linux.microsoft.com,
	i.pear@outlook.com,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com,
	mathieu.desnoyers@efficios.com,
	oleg@redhat.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Sat, 24 Aug 2024 13:49:26 +0800
Message-ID:
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [D4TL4rciRF9/aeq4vvVEzufTMMQtPGDFb5pwChQ7dO2XN9RlovbQDQ==]
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240824054926.24341-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY8P300MB0760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcf30ab-d34a-46c1-6f29-08dcc4008e33
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|5072599009|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	CvBkkQH2jIIYBbqik5C2NWHGBmhbpZUWv6DaOXptjxMv+fbtWmUUIlFw7IG+z5XRQ/UACOsQ2WuDZFCdqqc0SOkds+s0oXJCY0G5Ezcl2zsKrHHo9FmNd1Gh18/JIx+nmoTFmpo4/W4aSWKSjtoVTGFHgwJpqQQLIoHoe6YzFBLXurtbRQygp7XC3ZPg9b/nd4JF+rI7BgKLxExj527lAvbMeKwOedfwJWdwHbU+zUIGdG7tSFhP0xntjaaMCVxyO/0Av5OlmWsdl7tqmcZXR1pg8iQZRbKmGzN3ZHgavsuoWb0ttTviU1e8LgOeHcBfxhz8B5Enu/8BaHus9mbfwWV4ai0gX9i6Y43bmNQyyEYRxXJR+kmHNK50Qm2Tf5nUotNWOmM5XFIfYgpFNBzi4KOqnBhMxTTs+Umpul/uCVMr+JzmIBiTdc2MiJBtiwB4r9GG5mqVHcfLNNONFYA0gvOKlS1yEy55ElgAe4EOh8K/qrKfzE1bdaR6NawamfQ5RPxA3+cSKjqGGxcCv4JgFtYsmGGwIshBBNT1/FkFVL7AK2gh4/3Yahsez1N3GNsd4c8+OFt07SqLkJ5WWbMVxT8w6D8B0DSn9QCUxK0Q4mxnLDnGK4pbEtlV8vyPcv1zN39QT6FaBuwTefVtehuBWojGUFD2b1WDZ49ob6WX3lnCPVaV/6sQA+nOQiGf2YjIXklkSNnTDKjvC/fKt/yg4Es7TedmNIbPrDlTmW7Zh94=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ytw820brPEdTNExgqBoH4rcJY8GQouIJRoDDN3Wb6cEoLa66nwYFQ0IdkgRi?=
 =?us-ascii?Q?nXDVDQw9TOLV6Gw4mTFXZDGMezSReSc+vquwHV+EOrJZgWdKUvaVqvll/CD7?=
 =?us-ascii?Q?Ms8SCn/jNxcnfQEqT1niER7JyhmQsmo4KUF+hccpN1cRYsGD0FnuRiokpXy0?=
 =?us-ascii?Q?5Hxz5E5dKEJmRHbHx82psUBK+P9+LBt5Ia2+gwGf3WXn2ZHpsTiIv0Y1oo0t?=
 =?us-ascii?Q?NqStQnIzqP0vokhdeSjdKjjGNae4IRQufiLI5x+VsIOH1tNVMQq5FGtMQl4v?=
 =?us-ascii?Q?lDagwcDypAChYLSfwNBZdQjtXRBnik++DanVLDFJGL9p06kuYQHaE0RxJ+iv?=
 =?us-ascii?Q?wH8FAS1BCz5P/hhKSiEfDvgKWCrhA4FApASblua7ulNEuLT8g0TOVc13FdDk?=
 =?us-ascii?Q?Fn2iTLJVIUQFZpHPt7niME+mFkZgYznQ2l9KiBCirGXNx3Ypd7wtL2Px4ZMG?=
 =?us-ascii?Q?d0IhoXI2Daxap8Rzl4PmngJ0qrFGs10v/ZjAno/xGg/fI3JzHA5ZbHyJljei?=
 =?us-ascii?Q?tz2rSZrHF3yQZIyNMygW1gN9tN+4dOkThJLeLqmzljUl+bTw4IsBTjb4RwFe?=
 =?us-ascii?Q?XpIy9rosCYyl3jWsAtJ8jCosJoVTbnW0BIEU2RbUNsnHgMLLTpWwO1BDn6kt?=
 =?us-ascii?Q?+ovod12AgPj7zAr6GdDzH8uEw5gP813DW/kSRObPTBResSQWD4oCODEoerEM?=
 =?us-ascii?Q?k2pfQLspNhFbers1Hkp18be7MIGxrsXIdgKip5cR9EL5/9Y21xkbONIDU9H8?=
 =?us-ascii?Q?qLHc2ScMzLu8/jRBwkx5RYSka5zxvcc8nkQd2C/G1OWn7W6xGZ1/4bqPvbUP?=
 =?us-ascii?Q?Dtgswl2j4jhsOTfbh686VqTuksh4YV+CCiBVXmWL7e6AtcMcy+hUrY+nKbpd?=
 =?us-ascii?Q?n0pjzkehLwpVcN0fZvir2i3+2vELKeT2H8NE8bZh1gcZfM0rV5Zx9CnX0K6v?=
 =?us-ascii?Q?gtpduyiwX0wvk0u/NiaMNm0Vnm2N2/xqJGzTd/5vBI4vHHwqp3GXVhddp6lJ?=
 =?us-ascii?Q?eIGwTvfnSIjMSbtizXsaB+arwjf2JF41RBTkR/l3s/cUGcyHJ6is+DP5UJks?=
 =?us-ascii?Q?2al90Um4rouZSXI/cc9AqvX6y8tPmgIXNBhK9zCwHBVV6AwP3nHThvr06bVp?=
 =?us-ascii?Q?VRY5tF6SyXN/9KtAjlR/VNhC3JkFWrr4nkaCj5o422ENOOwvT+PYElLKi7i/?=
 =?us-ascii?Q?uM8QFYqT2nVCEjLQA23IKMoSxDY8T88XVLBSihSrD5PMZXloW2NkE78xtlJw?=
 =?us-ascii?Q?j+TS/dRTkczi+3pxZrGLvvYhw2TLIrDAF/PKDrOaQQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcf30ab-d34a-46c1-6f29-08dcc4008e33
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 05:49:44.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0760

Hi Masami and Andrii:

I would like to share more information and ideas, but I'm possibly wrong.

> > U(ret)probes are designed to be filterable using the PID, which is the
> > second parameter in the perf_event_open syscall. Currently, uprobe works
> > well with the filtering, but uretprobe is not affected by it. This often
> > leads to users being disturbed by events from uninterested processes while
> > using uretprobe.
> >
> > We found that the filter function was not invoked when uretprobe was
> > initially implemented, and this has been existing for ten years. We have
> > tested the patch under our workload, binding eBPF programs to uretprobe
> > tracepoints, and confirmed that it resolved our problem.
> 
> Is this eBPF related problem? It seems only perf record is also affected.
> Let me try.

I guess it should be a general issue and is not specific to BPF, because
the BPF handler is only a event "consumer".

> 
> And trace one of them;
> 
> $ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
> 

A key trigger here is that the two tracer instances (either `bpftrace` or
`perf record`) must be running *simultaneously*. One of them should use
PID1 as filter, while the other uses PID2.

I think the reason why only tracing PID1 fails to trigger the bug is that,
uprobe uses some form of copy-on-write mechanism to create independent
.text pages for the traced process. For example, if only PID1 is being
traced, then only the libc.so used by PID1 is patched. Other processes
will continue to use the unpatched original libc.so, so the event isn't
triggered. In my reproduction example, the two bpftrace instances must be
running at the same moment.

> This is a bit confusing, because even if the kernel-side uretprobe
> handler doesn't do the filtering by itself, uprobe subsystem shouldn't
> install breakpoints on processes which don't have uretprobe requested
> for (unless I'm missing something, of course).

There're two tracers, one attached to PID1, and the other attached
to PID2, as described above.

> It still needs to be fixed like you do in your patch, though. Even
> more, we probably need a similar UPROBE_HANDLER_REMOVE handling in
> handle_uretprobe_chain() to clean up breakpoint for processes which
> don't have uretprobe attached anymore (but I think that's a separate
> follow up).

Agreed, the implementation of uretprobe should be almost the same as
uprobe, but it seems uretprobe was ignored in previous modifications.

> $ sudo ~/bin/perf trace record -e probe_malloc:malloc__return  -p 93928
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]
> 
> And dump the data;
> 
> $ sudo ~/bin/perf script
>       malloc-run   93928 [004] 351736.730649:       raw_syscalls:sys_exit: NR 230 = 0
>       malloc-run   93928 [004] 351736.730694: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351736.730696:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
>       malloc-run   93928 [004] 351738.730857:       raw_syscalls:sys_exit: NR 230 = 0
>       malloc-run   93928 [004] 351738.730869: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351738.730883:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
>       malloc-run   93928 [004] 351740.731110:       raw_syscalls:sys_exit: NR 230 = 0
>       malloc-run   93928 [004] 351740.731125: probe_malloc:malloc__return: (561cfdeb30c0 <- 561cfdeb3204)
>       malloc-run   93928 [004] 351740.731127:      raw_syscalls:sys_enter: NR 230 (0, 0, 7ffc7a5c5380, 7ffc7a5c5380, 561d2940f6b0,
> 
> Hmm, it seems to trace one pid data. (without this change)
> If this changes eBPF behavior, I would like to involve eBPF people to ask
> this is OK. As far as from the viewpoint of perf tool, current code works.

I tried this and also couldn't reproduce the bug. Even when running two
perf instances simultaneously, `perf record` (or perhaps `perf trace` for
convenience) only outputs events from the corresponding PID as expected.
I initially suspected that perf might be applying another filter in user
space, but that doesn't seem to be the case. I'll need to conduct further
debugging, which might take some time.

I also tried combining bpftrace with `perf trace`. Specifically, I used
`perf trace` for PID1 and bpftrace for PID2. `perf trace` still only
outputs events from PID1, but bpftrace prints events from both PIDs.
I'm not yet sure why this is happening.

Thanks so much,

