Return-Path: <bpf+bounces-38687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE5967BE7
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 21:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5161F2169F
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 19:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3355E73;
	Sun,  1 Sep 2024 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C3vEhU4r"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2078.outbound.protection.outlook.com [40.92.63.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1454537FF;
	Sun,  1 Sep 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725218618; cv=fail; b=jzm6/zprVbC8jGjrpXwSP3YdszDhyR5rTDjyIG0JObg74KCp7sGwTYwZFDX/kZdD1/uVvVfMHYWeTRLDLEj4M6nr5r/cFrsgFPJKfFOTKlCBNlE58s57HjBjVUZ8stARoR4JP26CLMNmF1y9KkPSD6LV5P92JOBke0OR1dm3CuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725218618; c=relaxed/simple;
	bh=tIeaN9rkSM6Ov8FXhtqpQ3XKey4WGy/MQGaa3NxU4Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFbErjAqKIu/DHibdMFHcZQ131f3VLfhZTrX6fwUNGJJ8/++WdrurBXoUQUT9GmUy6KA1nQYVHKqGOHEfucsVZotMkFfaJmDmBnG+W+tCUQ4rB7txaD96ArTnmWFUlsQP9Z2D/B9keRxXO5o1Agp4pjoC+uh2hVqGtKRbUEBIh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C3vEhU4r; arc=fail smtp.client-ip=40.92.63.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOfDF8MYhMkWPdPvF5SrYPR8q99KjcyexOJe1QT6vhU2Tv/ri+ydd/BMPlCaXsNUU2IiT+DfhYK1Pkl2d7GHNDflDvYxKwKjykGDTQp/NpoUMPIMsa/Kgpd8qC43WWJOEA9bbE34onjuzvAhRLHOrxUi1vvH3grPK9ZRYfATJqByv/SdaVcS7AHk9eTKgQFzxHqe5eaBy6ZKB8q93g3pQhJcw0eQzzRz2Uja5Jd0mCZRkLxLXC7GTVxrryVcLFBSV/68gt+0cYSQOZlJDEP4AUHrqHFBswlLZjO0lBr6VN80Rm0yvRO0yRFHLx4Oy6JzmgEO4rXgo7cmivjec9pczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06POzpqPb91ZgEGfE+vrmvSY2ELzPa65lLGpBD42cEM=;
 b=gQqucrn2QXYVCG2Jo2zTprVDfDLgsoGGeLLlTTRCCpyXvpC/cWFt6s6jHtFRrz3OFURDOfFsTh7djGpE9eS1/BOuhIIS5HSi/p0Co9wGlZOavORbD5ew5rfhAKFBjNLOh/WArLr8zbzm53uBitrqdJCVDcABhKRwSi+ymZEVhFGK+mqws5oCVLyQcf19bmSXJxEeNCZF/4Sv8HE0G6zPP6XCqyUElxxpYIK5QS5sSwDWSXf7Z2Y8yZYim4eZQpAnX0ZC+a7f/9H/q2O/kEEw7wvSqN0OsK13xYNY6eJ5HQQNGINexXBZvnY9/ds2C8Pl6Dy/o4KiQxgiqUYMh2rvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06POzpqPb91ZgEGfE+vrmvSY2ELzPa65lLGpBD42cEM=;
 b=C3vEhU4r2KE9RZ/fnOIrKvTkPSTSb77MB6nevFUY0UA4A6748TDbyqirPx7xPptAmOnrIi4blFzzd/O9uGdN2kvr7BMX1wSFbFqfbdIem6M+yqLdh8nEi8yw1x8jvsY2vEty2jzj48rQE/HiYSGyc2inI2Qw9ZvxTBsFNN87SYV6g7UbkZirq2+cagxvLYrEjWc66oGwFaun7tp2DH7LWz0ieHNvHfC6OxLTTmzPLJOypXZN6aFT1EZauqgFO8Ugf+X86/YgrBeqV2I5rAmk91fXHJgZh4TsvLTOioIJRp8sVrt6rRNvnQlvMhvpz3noVOHXoqNL3jTiNZluk/c/zQ==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY7P300MB0719.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:289::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Sun, 1 Sep
 2024 19:22:56 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7918.024; Sun, 1 Sep 2024
 19:22:56 +0000
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
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Mon,  2 Sep 2024 03:22:25 +0800
Message-ID:
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830101209.GA24733@redhat.com>
References: <20240830101209.GA24733@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zRDbimR9uD+wBpiKF7eRDNfqRz0VN5KrilEQXCQdOmR9OyRHugI7Cg==]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240901192225.128847-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY7P300MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 58884a6e-de33-43b3-fdbc-08dccabb7b93
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|5072599009|440099028|4302099013|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	Q+OfAg/jWTQS0/cDraFUtCUSvBNVoiDYXZYc9Kjjnu22VSK1lpQG3eW7hJL9DMFTov2ObxiiDlDdSu483Q6Jc4WvQFwzGIAP0K6rPA5jyh86PJK3DG2FPdJedB+EMKw4ft6URlsrG2HF5CVJpM4axVa96RpNgkL/qNGroB1hriBaYWdFffMV/qk8zYjRNcrAyYrIdA/iBWOBv0Zm6Y54XNdl/usvX5N3YKC557TghL1hGdAMhZLWrH0F8Z/usCo6zWt+qsMwIs+dRXBMGbh12cybjDvNNKNxHnwWmO5+BamIJ/ycpruhpTxFESrMA1iAmNSGhg5Rh8ujBMtjfV1JhorJTGLQfdz3ihygkOlUqgg8MeepWLOlYl2Lg30VlNnOnjbT/+CytD2vbq8sw519++XPVLUFPDKXl2gCscD2oXFFSTUBLlJWEEiyTuzQcOqiZjAYdJzIii0Zk7pZ1hMi+7gnLtb0aENvvvGkq38RryCIFbprbkD6DdNbi2vVoNAEk1ukFcWrLyO0NWinD4NFInQ//Bb1sL/8ZLZ0F0zDDibRjaR2Dj1jwZyQcHhd4THrDPPqT3ypgJorzFTKTAY0IHKNLPKg12SyGOnADHofaqqVUnSxwgr3wVPtFeMREaKpq5deRn4OVSIQaFM3nh4zJflCUvk+mGkyxp/HSgip4A1jH/GdmTEixiQSex1MLRKdB2ZS5QoVQiLyMtWUzxZprKVZgUKkRHkndnRNtVHJU/8r0NGRqbXaSmUhGIpSfWzVmcuQt/EbFn3l8jwwIDxSFX27KW2jD3y32m+kv/RIOL7FbN6z5n9lTXOKULBTu5N1vmnMGVhj2pMSNpJNdBurPRVjxkehPzX2RUafHM+2EkBKN3TYul8oh18hlc3WlfVOa8Tjb8utPVuPBQ4ze6O+pA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rEkKtrG05+UwptnHIHon7p2H2QuqMB+iupsh2Z8qcEk3hsMhVvlcAcgj/l2X?=
 =?us-ascii?Q?ZbEf39aYGRBPKpcuEVcT9IBcly3yAnbx9GBsmG+Cx02Ea4LrtWlOxpd//dN7?=
 =?us-ascii?Q?1B/MsJuVqPol27657J4iPLGYaTpc7h0Cjnv8GgphgTd3nVdYy70DtyV9slfp?=
 =?us-ascii?Q?9dETADmjuzhf+uKUxmHz0UQQkCMr/UZZtDT9SNOmHBvJ75rZ56wa3b+pmy2h?=
 =?us-ascii?Q?qHhweb4EkoxiRvB3l1FYSRsBSmI61kX3XmBq7tMRWiBLYQpDx6q9BT+KbGpJ?=
 =?us-ascii?Q?iypCU/as4ujXlRAUUlI2rnIOy5BJOxiZndW9PVAobVLq+r9dhxNk6e+XqbYO?=
 =?us-ascii?Q?1CCmVstVc4QzxL6HxGJWjb7NHlZ/fQvHywVsMeeR3xf9ACmb2PmWSIYhedYk?=
 =?us-ascii?Q?TVwXssPdzpubwdHUS78MhRRUo7uRsBNbwtJfZOCrm2+yivUP0nB07QEion4u?=
 =?us-ascii?Q?5JvGwki1iD+6yoeA7jq5bL0l+xmedX0sUlAo0P3crvmAeNtBEO9lPGE3i2aQ?=
 =?us-ascii?Q?r47X6liqD0WwgQhO2XUw/bKX5QKvoyJR8sdw8ppKyQt0fTPOFLFRU5FlRAmS?=
 =?us-ascii?Q?LdnF2suQrSebweemtI9JE1wBd1L1aFHd8TPuUtZvI4UlNYJUdl9MHVERJyiZ?=
 =?us-ascii?Q?4QCmgHUsrRgBdObaXprLehrHYaNgck4z6Xs+So6mC0lPKWaQCgabxLeTvRST?=
 =?us-ascii?Q?ai9BkyW2Ux8J7kG1MagZNLc/ufOHPZGfeecjBnPaAaukwnCs1Kh1qvxf58QP?=
 =?us-ascii?Q?Hlob1gxR6usrt+zUiirJUW1+HWXdGh7rBt6f6SJn/XCNu4X0vVzs2XNrRNtr?=
 =?us-ascii?Q?Jua/Omr9xtzlR8yZ/Uyt3b8wXGJCwel5l2yBY2vLT0lhGoUDsrr+nS1+Q2wX?=
 =?us-ascii?Q?4L3i/jeoQV7Tk/9o6IlzjiBP9GqeRQNGtvm+euNjJpV9ao1yd+2BouyGJq+G?=
 =?us-ascii?Q?oscDiuDb3TkUWdP7XprmDBBNXS/iD0cjdd/9nY7foH//8EhOsj+FCFnN0Gx5?=
 =?us-ascii?Q?KjznwJ6R9A2GSm7VZGtDsG6HS+LVdU6ecsMaGRRNEOF4FjngoL15eXpcSl04?=
 =?us-ascii?Q?qybMd9Ma665yQopniiff1GX+5Dv8VHdiwBwhWofEvkgzFdhjg+TlNVKrGaTa?=
 =?us-ascii?Q?iPGowGwzKGAM2MvrgokjQGpmOPIO6PbudJyYU2g0Np1jTScWwxAJmibqnILp?=
 =?us-ascii?Q?EJkr4PsJP9wceWIzN2W3C9GH51wakln55SJp3dT52FP5x/AAhq1Zbat92CtS?=
 =?us-ascii?Q?hG7x+5GS43VPsYVOzaLPlgIjPy78Pq7KzXgcdLhq/Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58884a6e-de33-43b3-fdbc-08dccabb7b93
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 19:22:56.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0719

On Fri, Aug 30, 2024 at 18:12:41PM +0800, Oleg Nesterov wrote:
> The whole discussion was very confusing (yes, I too contributed to the
> confusion ;), let me try to summarise.
> 
> > U(ret)probes are designed to be filterable using the PID, which is the
> > second parameter in the perf_event_open syscall. Currently, uprobe works
> > well with the filtering, but uretprobe is not affected by it.
> 
> And this is correct. But the CONFIG_BPF_EVENTS code in __uprobe_perf_func()
> misunderstands the purpose of uprobe_perf_filter().
> 
> Lets forget about BPF for the moment. It is not that uprobe_perf_filter()
> does the filtering by the PID, it doesn't. We can simply kill this function
> and perf will work correctly. The perf layer in __uprobe_perf_func() does
> the filtering when perf_event->hw.target != NULL.
> 
> So why does uprobe_perf_filter() call uprobe_perf_filter()? Not to avoid
> the __uprobe_perf_func() call (as the BPF code assumes), but to trigger
> unapply_uprobe() in handler_chain().
> 
> Suppose you do, say,
> 
> 	$ perf probe -x /path/to/libc some_hot_function
> or
> 	$ perf probe -x /path/to/libc some_hot_function%return
> then
> 	$perf record -e ... -p 1
> 
> to trace the usage of some_hot_function() in the init process. Everything
> will work just fine if we kill uprobe_perf_filter()->uprobe_perf_filter().
> 
> But. If INIT forks a child C, dup_mm() will copy int3 installed by perf.
> So the child C will hit this breakpoint and cal handle_swbp/etc for no
> reason every time it calls some_hot_function(), not good.
> 
> That is why uprobe_perf_func() calls uprobe_perf_filter() which returns
> UPROBE_HANDLER_REMOVE when C hits the breakpoint. handler_chain() will
> call unapply_uprobe() which will remove this breakpoint from C->mm.
> 
> > We found that the filter function was not invoked when uretprobe was
> > initially implemented, and this has been existing for ten years.
> 
> See above, this is correct.
> 
> Note also that if you only use perf-probe + perf-record, no matter how
> many instances, you can even add BUG_ON(!uprobe_perf_filter(...)) into
> uretprobe_perf_func(). IIRC, perf doesn't use create_local_trace_uprobe().
> 

Thanks for the detailed explanation above, I can understand the code now. 
Yes, I completely misunderstood the purpose of uprobe_perf_filter, 
sorry for the confusion.

> ---------------------------------------------------------------------------
> Now lets return to BPF and this particular problem. I won't really argue
> with this patch, but
> 
> 	- Please change the subject and update the changelog,
> 	  "Fixes: c1ae5c75e103" and the whole reasoning is misleading
> 	  and wrong, IMO.
> 
> 	- This patch won't fix all problems because uprobe_perf_filter()
> 	  filters by mm, not by pid. The changelog/patch assumes that it
> 	  is a "PID filter", but it is not.
> 
> 	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/
> 	  If the traced process does clone(CLONE_VM), bpftrace will hit the
> 	  similar problem, with uprobe or uretprobe.
> 
> 	- So I still think that the "right" fix should change the
> 	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> 	  about bpf.

I agree that this patch does not address the issue correctly. 
The PID filter should be implemented within bpf_prog_run_array_uprobe, 
or alternatively, bpf_prog_run_array_uprobe should be called after 
perf_tp_event_match to reuse the filtering mechanism provided by perf.

Also, uretprobe may need UPROBE_HANDLER_REMOVE, similar to uprobe.

For now, please forget the original patch as we need a new solution ;)


Thanks for your time,

