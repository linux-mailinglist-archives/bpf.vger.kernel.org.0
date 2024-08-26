Return-Path: <bpf+bounces-38083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775495F471
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E536281157
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77518D64D;
	Mon, 26 Aug 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NWs/PX9p"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2048.outbound.protection.outlook.com [40.92.63.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166E13B286;
	Mon, 26 Aug 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683985; cv=fail; b=U+5UgREojf6q/WgX0UsPuaYu15SFZ/iTSNxK0D6DWkGdnKq9bZJDRedRz7pFgBxnmmi+LMAHzBTXBlcQyIbLfgFphBJKW93+3rmXdAHK1LdMRXLC4H7F1mNuUkKBgsold2gpPqcRMAdLdP5KPe3Qtr/+txzcHQuRpYqciE4nUIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683985; c=relaxed/simple;
	bh=zELJUXIzBU/2S1TrFuoNhHEac4ZSYPeNSumhIVL4r/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NObEDDJs+JphcyDISlA1mrYiyQOFBFAkC02AMXtkYR9bdpf8UA146OK7pFBcIwkJM16kMaGwFeFNIgEkHeRGflDeY2G8Y8EwHOC6l14gXfAkuowZFeA4v21XXc32lzXTGDCixRLRUj1eFPoFj6fPhRaqWWm4LMMC3fngfntoS38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NWs/PX9p; arc=fail smtp.client-ip=40.92.63.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCWc1tWYGNp0cuBbTOqRrm+0kb1ISqCd3TylulGoqICLI/Hk/Df9UMffUMkhKFhj7gATDIHNtMB37gTTGz5y42Y8FZSgHn7hLygCMdwlCOFmyc5odBJZcR7WNTC+j6/O9PVuhVa6Wmdh6/TCgfNgBZKvrKGeyK9T2zwnWgjbEQpnce+5EjLEDwwh5Gl2MZ8rI8+HCbiyjsH6CNFUgSwzGN2LxpNJabgf/eHqrsifgrWKIh6z3SGK7PXcQG8hcq6CY16oFajGJovtDZF73QZ7rd7g+ROgyM66CWw44/9KbwJwxR0aJO24KqdOoJjAh7qWN5MLqtej0Y4EmZ7rN43NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqLzxDpc+WDlkjg036HrcLBy+y0d/7MOc/5fykpuZ7Q=;
 b=YGLNO8pToYbqqxT+GAO6lPHoP2UykO02HB+vATEHi8P9olpkDrh7J3Bx49l+A69qVFVXk1TEGsjCNJN4/GcBYKR0fOOFHN/D0y174jjAitYUi9DCawXuK1FGDyXYrAA7g1xlyVk7R0UxInsiqvj+DkNxt8EjPNTjm0Pe25vGBDt/iNETW6TVycmRInx449kEiilmPdIJvh1wx+sXZphPBBLysXdI0EDGNbQNEZ+Q6fLNiEi0IqQKzavCAZeVwhbNyAwKS0W296BtQc9pIjAhcKS0LYjPzA5zgBqi7Y6ZS30ZsDAMQ0a3EvFYx2buO+aQQ+3m1dzLbSxrhmZtSHbLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqLzxDpc+WDlkjg036HrcLBy+y0d/7MOc/5fykpuZ7Q=;
 b=NWs/PX9pStXDJPYia7qdyjAZ/MOmojFXOny6c/S2xZoJn5kl9uZ9wmD9OPZEhVIjCULJTS7baXc+JwSFgRp9pXQkin2ESw1LVLlvVgkc4+VnXQXD/flWlpIyKQ/oWBWlfKcgzGgUrISnEZSl5E9RkFu99grocu6dEoBYKXplQIuDMBu0As6WSu8GqEFbVW83u8QvkIUfQimRCdtyZi4/zK3dNussi61Fi9iC0YAxqbSw/aRYh73Q2/HPv8E9isGhiHLhMN1UXyrPvHh6dArB8Pwk/90NkEE1Mc4OpnXhhLjCa0sdiOjzC5gdqgcjTe2di8N2es6XbB5nNTy47x9Gfw==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY7P300MB0258.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 14:52:58 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 14:52:58 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: oleg@redhat.com
Cc: ajor@meta.com,
	albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com,
	bpf@vger.kernel.org,
	flaniel@linux.microsoft.com,
	i.pear@outlook.com,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Mon, 26 Aug 2024 22:52:03 +0800
Message-ID:
 <ME0P300MB0416F9EF9AC702904601CAA19D8B2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825224018.GD3906@redhat.com>
References: <20240825224018.GD3906@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [w/YF1fAAmIX6yvHtqdd9TiK4sAMPYWbQFZX42E3RweBdRlnuQTjF0A==]
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240826145203.162222-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY7P300MB0258:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c8cc55-5311-475d-2d5b-08dcc5dec643
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|5072599009|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	T3myEWf81FxFcmcoARw4sIhptDclOHwEZrt1W4UXGXwxgxBo2jV38SiEQy5PmHVYI4o9gb+0KJSRc8EaufiWdBPCiVS0BURGT4uScMJHF5nGfn6iohyu+TCE9chzn1k+jSZkyLmQ63wyv6tL5ZKmbLRcmYw7RAWqeloVNy3VqnmykrAygNi3OWtCQT/5x8PUTMvobHZ1D3lrt7t7iJVJz2H29Kq4B7JQxkxggJq+HCsd3HWJDr4872ylWx7tq482Ko0HlzbVV/8dbOdQLOO9l4NDQ8r61isOZa38Oqzb/A+aD9WrEi30osQNcla0SjK3VduYdsJ/Wgg52d15rFnXbNu+ZjumyINA98L0MBb+KDFtttfMhZ3CJZu2wI9LE0rnuX0H0zn/O0yitm+336PXGbGU00SGMyRjmOLzFVENRf4BcPEWv81cyVhRFkhMxkfTB7n8sreWPx20T9JwomEQCDleoIAsKqRADzLSFqV3omL/AkCR2CiIYwW4uT+m0I7gKq0AhdjVCIuFq2mB+m8WRui1z7r8GH4P3mTFCy1oNaI9Sbe0lZELoGBS2+jk7Q/0myqPg5HEf/3fnCTidn/Ni6KqEq+wiG3GgAjQ4cI9hHnKnZZsnzV+YIgLXRalCSAV/W4jKEKSj8baZPDf+kwE9OvijZ9UZeaEzXU2tMbBqUtRjlosUquNyoHrvXyyIEmb05nGhr4W4tgSqUAZzKjuGeFYsUumLwE25F7or5Nrg3Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nu9fBFLc8QAv8o9fxh5944zTgFRsgL6mir+7R7jW3yTU5Aymu1Ulh8n/FHjF?=
 =?us-ascii?Q?DoHjCe0PvD2Cj5nzY2xU2TQsRqWHHPcN/IuhdGElmR28/A/V4uimuhtm6xnm?=
 =?us-ascii?Q?QKY/i5ECr+BbLnjyTGARDemayedQpX1XrSPBUcFzjhzed3h0cAvt5eAowijv?=
 =?us-ascii?Q?zv+6KcAlEDP5si4YKxkpLci6Bjp6zBtzoP3C9vvED+8kH0jH/rNwHHv/SdEU?=
 =?us-ascii?Q?965dkzGEte3bSql9f78l40Ee1HvgIhtIa6eEYCv0SsGR6CByiIstw/RlR7vT?=
 =?us-ascii?Q?XOK9nL6cxfArK3YjwWZhGN4ibvIxrK6sQVFdaK1r+/egtGVKUnZPqmoBG4Be?=
 =?us-ascii?Q?3XkrOZgmehmlsziZSOItGJd/cKlEaNl94RJ9SdW6p0+0dkgCmeGyOq/kxIjJ?=
 =?us-ascii?Q?0XN8oO3mc7uSiYTgN0p3QolqYObKA9ug18IWqeix2Nsz8jPpShGkWh6DPy4X?=
 =?us-ascii?Q?yjMyo+B+6tfjabZr5fh0K65YN/NmAdAgZrIH7nVLEtYBVZOscU8et/hNkoYT?=
 =?us-ascii?Q?Oqq41//r2oMRZ9d8/aLZl/wTPOZWsZdBR/Nw55P1xxhnbwVGzJFBw1GwNav7?=
 =?us-ascii?Q?eyd4DSYbgEh9jT0+30BwvV7Rn1WtrOSBwzZTmb9vakx1XmnQhRiFlvip3vjW?=
 =?us-ascii?Q?08IPDXi2nrzguEWv1MpoyftVjstLgKe+uPjD0/sH3nABnMm0VpMqPdhi738C?=
 =?us-ascii?Q?xq+wjeHoVDILhXAVj4u2gLyjIGnx87+ci69HMguBRl4mJzkdTlAkZpAxfgWx?=
 =?us-ascii?Q?k1DOzsUnQQrnXxNSKFzQrqR3iVOLPgQQL9hjZSRHRh8cj42EfOh6yTpC5Oc+?=
 =?us-ascii?Q?QD+rcMjVyuzE9kGLTvVfGj5l4CMeRc5bZrT7kJg1bIkZpuUxdYgQunvWViTy?=
 =?us-ascii?Q?yHkaJCDeZLl5qlBQQ1ITTCTT/CimSh8Ut87P0rS77pTYRbPRChdmX8xtntcy?=
 =?us-ascii?Q?tuf83dX6/5se7Tgnc6xMMVabgua3bCW/xuJ5kDR4KJJWiQNmowfHgffD/nv3?=
 =?us-ascii?Q?SPmQd13iSDknffdiZAPfk1/7gF3XybreU6qYtvzS70Ri/dghIy/4cutHVpqk?=
 =?us-ascii?Q?jIrsMkRVpzX1EXly2SG5Qf/aCSOSHPP32JiM1s7E9s/DtiMqsztObtk2d7II?=
 =?us-ascii?Q?VgRfb/xVU/wyioMPp+JGgf0fWlWPPwfRJ2LEqU/J7A9npN7jFIjWieL4fJIF?=
 =?us-ascii?Q?I9tiBc9vdQF5XVNaX4ovtlT7UZoI+xgn+M7lXrMZxhxM1+L9k76CLQqR+y+U?=
 =?us-ascii?Q?VhGrvZ+g69gtE0+XhDBfGUn0rdAdcxpQOdlXwQoUhg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c8cc55-5311-475d-2d5b-08dcc5dec643
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:52:58.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0258

Hi Oleg,

> For the moment, please forget about ret-probes. Could you compile this program
> 
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sched.h>
> #include <signal.h>
> 
> int func(int i)
> {
>         return i;
> }
> 
> int test(void *arg)
> {
>         int i;
>         for (i = 0;; ++i) {
>                 sleep(1);
>                 func(i);
>         }
>         return 0;
> }
> 
> int main(void)
> {
>         static char stack[65536];
> 
>         clone(test, stack + sizeof(stack)/2, CLONE_VM|SIGCHLD, NULL);
>         test(NULL);
> 
>         return 0;
> }
> 
> and then do something like
> 
>         $ ./test &
>         $ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> 
> I hope that the syntax of the 2nd command is correct...
> 
> I _think_ that it will print 2 pids too.
> 
> But "perf-record -p" works as expected.

Yes, the output from bpftrace and perf matches what you described:

$ ./tester &
[1] 158592

$ perf probe -x tester --add func
Added new event:
  probe_tester:func    (on func in /root/test/tester)

$ bpftrace -p 158592 -e 'uprobe:./tester:func { printf("time=%llu pid=%d\n", elapsed / 1000000000, pid); }'
Attaching 1 probe...
time=0 pid=158592
time=0 pid=158594
time=1 pid=158592
time=1 pid=158594
time=2 pid=158592
time=2 pid=158594
time=3 pid=158592
time=3 pid=158594

$ perf record -e probe_tester:func -p 158592 -o 158592
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.022 MB 158592 (19 samples) ]

$ perf script -i 158592
tester  158592 [006] 246475.295762: probe_tester:func: (55a6def14149)
tester  158592 [006] 246476.295828: probe_tester:func: (55a6def14149)
tester  158592 [006] 246477.295892: probe_tester:func: (55a6def14149)
tester  158592 [006] 246478.295958: probe_tester:func: (55a6def14149)
tester  158592 [006] 246479.296024: probe_tester:func: (55a6def14149)
tester  158592 [010] 246480.296202: probe_tester:func: (55a6def14149)
tester  158592 [010] 246481.296360: probe_tester:func: (55a6def14149)
[...]

Thanks,

