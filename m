Return-Path: <bpf+bounces-39193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5A9703E5
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F908283F8F
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12E165F1C;
	Sat,  7 Sep 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PKMP+T1n"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2105.outbound.protection.outlook.com [40.92.63.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E63B1A2;
	Sat,  7 Sep 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725736768; cv=fail; b=jF3kNZcwnUtoGErG7tWpr7Iyrq07Umylq7BzuzRgCEv5X9ZhdBRzh+vYOrmiSKUz+1zO0FII9NN5k/3fbmOL6N0J6lPPpsaD9ZEQ5o294rQCUtSIDUi3E/C5t+45kD3Gz02TvqI+3xsgy2fWoRbsw132g78Cp9PgQqZbfNllIDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725736768; c=relaxed/simple;
	bh=Ivz/VH5EQXx2iPkApFCpJ7RZPzbzn+tMBWvoqeouxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOF82Rm5sDuJ+QkhrnHqunAXMEIT4zTqR0B/irks2jQXainGhR5Y3LYFEkvXFxDMSJycawNW3rlIHuAcOR29QcKsZUYmKms3zhCBhdC92nLNNvsVTz/VCDLWeezLWkY7grKbImECQDOL9VYNu/4tjLs4J85YKVyo2cv9e+IWgEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PKMP+T1n; arc=fail smtp.client-ip=40.92.63.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoPeSkSZVQ1wbtcVtqnciP5Devp7bc6KRrX+rOZpMFyuMPnzrC7T0ae62pWLWLrzJ9QvBQt+5Sr/lkWqYzH5jGqLwt0qKlw1wpDGk+nR4L1vgXfeJEMpZF1gGroenrvcpFb83tsy0TxixiTh/u/7BU60GCgdZyrnMUpLLwlxzxL0WnFGyz9rl/oxfwlzZxHXDUA9eY5/PEladPEGZ88sRmYBjr1vXGHvPd8aRaFYDw7k1Icn6KzfzrzUCA9NyqduZH5fL6CZfs+5JrpIVBEzg6tfS49JEvMU/BhYfizXZFIxjJH34ycFcqBxzXUREF5BeCORaz3gsttC9aItqvDgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9xcSxuVmBJpkP9HiZgcvDfmQZWGEzc1HF1XUhMPX+k=;
 b=dt/0siRn6MJrXqev/n81WXmr6pZefD6JNRwzfj9w2Avba3Joi0AWFJbvezpo1GEnA9sxbFslp7HIFptHn3G9JHxvSYTZceIezScH7x9/XB/2G6NuNEVgSDF38rXAGqT3NpKvm5KiVljC5VguckDhTmzhxyXPj0ESdmj9YelMsmZQtMpDOIDlD8NU0BGBrD9VBtvMYal2LcKVUrbSf316WZMD2I0lPPOzphjaRjMRXn98wOGvbpEwFT3ca4JpPahm68E4bI7xH7uS2SH6Ym0ghjlOwhaH51r4OKYdQHSMeOserEYuGEsbklOM9i3aJPTfsmquqr7KL1V9hMlkyKdf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9xcSxuVmBJpkP9HiZgcvDfmQZWGEzc1HF1XUhMPX+k=;
 b=PKMP+T1nFPQEE1DHSF1Iq0W7hAUkJ9Bd+yF0IyEGNx7XW+BDv2uW8Dbsw0Zj5dPYG7kgGZa6ieTKNZmXhBqLgAfwKh+cTfoFVN0zAfFBQenG7W8AuwtqiQO2FCToSxjBmcfsN+olTLrcjrVusywKkNpvl0B9tzC9K9VMk5o9lYZw9K/ESs4hTFCO/zdBHekXUU6w+AejqfajEB1EV2U1IrFKT/zYZRmGZv70inwFKPauNf8lDEWOI87MFbZM5jIvWcPBKUguMkTZybtTcQPjDT8TEBsUT1LNbcGNDE476AWUvU8u4TZ+Z7DopFNCvdwyKyAk/BjDxbhizPZpEI87Tw==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY0P300MB0026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Sat, 7 Sep
 2024 19:19:20 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 19:19:20 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: olsajiri@gmail.com,
	oleg@redhat.com
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
	rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Date: Sun,  8 Sep 2024 03:19:01 +0800
Message-ID:
 <ME0P300MB0416A96545165A39507DF6429D9F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <Ztrc6eJ14M26xmvr@krava>
References: <Ztrc6eJ14M26xmvr@krava>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vjd+KF+tVjxSr1QDyApUGJdkmM8RHWciF5VmTN20n3Xst9aTzlrfOg==]
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240907191901.8665-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY0P300MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4e0ff0-aac6-4ed0-e6a8-08dccf71f90e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|5072599009|8060799006|461199028|3412199025|440099028|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	MMMtZixOnSSU6r+K1qVcA9glrK3C4mI2fuBthsR93QMTqqwEYu1Qmdu6gmmXwuURloXoajFPhaw6BroiRXJ8ee4Zr9+Bf6l1FmKyKSsK6RuYSZ8MUjXA30oUqwnY3e7hyxdpBc13oPXSfWZhVt0nGEAzB+jhXBwGesRX2bEisaWdwoUYW/WaBYmzo6CJB18Jtza9OkbGkyVP8D/DXM2d/w/FnzBmqGjrXPTEx0gS5aYmdJTsurEaGRLlbzeETMGOwHVcqZ1kR/r1UMLFdfHlhK5NQEfo6K1HgNRTK97RrKC/Xg40XUAfG8ETbjexOgerMFmT8tLJUdCb1IUjxEjqh8tdKMxATJJkz91ruwzFALI0u5No9Q8ZCAF5k8oyjr2kjefslKQKvbbzpejWzul8eTkZUszPStJhyERxDTkYEBAjC1IagY7QSYovPzamZrkcQbZzrfWiY3TS6lpi3WyanAf+E32vhETu1Yof7ppso6wWDamaWLHmcDKgjq1r0ieW9OqEyRHQVkwsgNoHm+Zso+MR9aq5Z+oarJzhevCjFCFsotfLqdEpVj2iFQ/Q777WhftRjVF8uDVjiWQqIUlwYO0x8V4X+wQjZBMz2rCbQl2G/6deXG1U2Ajs6wTRhG38BYa0jFWUoN6yN0jbrWBgAPTs1eptDK3PFV1aIB4ohwYm78mo9vZByNdOlht0hqQDzY+9uQQfzrxsY3UPzfwMFByr56z/RbqTp7bjzt/isYYPhO6VOAE3Tu08+sFqqeSCERVX0ZH1eEJG8nJ4F5GPcDu4aaxkzdcFw0MY6nrunkitIcnf/O12Rm47Swh53JdH7sczeHLAgFzVkMNWP1oUEIAnuP43NZusMuq+m0g+FKo8zrcE9aGsn8G/76MU17TUFfzoUGFvamFdPPyHgOSd8w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/o0hp8Y1Y7r2uKdBbE23yALfGXpOzDz03B1cFOs5H7YIfMqarHrYWZu+TOfl?=
 =?us-ascii?Q?+u8odvUOB0okc/mmQCBypM01ao9HQ7csjRKqwkTaHzZ9sFhCQI6rpeHam4ej?=
 =?us-ascii?Q?hIeI42GM+ofGZcbAd7IwasEUFii930N5qK9qF3mNLOMbthq8TZUzeYZQNbNG?=
 =?us-ascii?Q?Xy+O0M4HPx+l8mpRiyZQBQLir6Dqbd5Yr+3F+S4Qdnu1ZDhWNC1ln6AxPT4A?=
 =?us-ascii?Q?yOKz+cdJpUF4wozb7TdKRUm3Ttg1zeurGjtWTjk/RnZUrXOVStMPXESvy5cL?=
 =?us-ascii?Q?zev7I6vjliLHJImoJV2FEBNuN5LLfcC6H5BWuRP0g8Mv5tVABWDBcV7vgGG6?=
 =?us-ascii?Q?WXKk8jZoRFDdkb0b0VW0JiJD68iOmzhJVZerS2pHaq1UIoMErgzjFyMIohNS?=
 =?us-ascii?Q?j8yBv5+Jvs9LYDUDJhuPEElXDzl3Ecv1lsDm1zwEcedITLCVyWX7qbI3FCq0?=
 =?us-ascii?Q?cnHOJ/+D6g3nSffpz8QNLkL6hBKj8aWXCGAsnVyvbwOQiYez0sV2QAurnmJV?=
 =?us-ascii?Q?RumdLh88JAEwlvRgWC5PEgzFYAAnCFNB/R9vtiZFpiCEw8gbmeP+CC5mi3/2?=
 =?us-ascii?Q?kuMv/xEayZro8ZlAiDFLccbiNGu08g5qOqaT+zqjd+Lsfv6kHlIwWskJDCgH?=
 =?us-ascii?Q?2mGBaqeNJS1k9RQZZm7W3maDNa7L5nD8tKKmPEBMEr6oAIXRUaNFXq7fObt/?=
 =?us-ascii?Q?tooVnUhSAlxA66I2wMeVPIahPRtXkXaCTNdnCthoXnqA8xqPOrj7cjlMCCdq?=
 =?us-ascii?Q?Hb8r7s8glY9XwF9e/HLiw/3ldbYOc3wdWEPuCFa+1jEuy4GYHtGF9T1R3Wbx?=
 =?us-ascii?Q?bsCMJsQPqN5mQKIkIFFbU0ABQuo+MSrNTnBfw2iK6cxL1WWSZY02eJ52Kpok?=
 =?us-ascii?Q?INl7gy7xNcQMDdcyi3A7Rqw10N4VjeNfAtMx3tcTpOsp3HIgH/P1rkNz07cN?=
 =?us-ascii?Q?zxQ7yc9NMcdlTSThY+xaCuI4e8M7FwBHPTe0n6+LpKH1/Fmx4TDkveP8Mj0T?=
 =?us-ascii?Q?P7bFRy1YOpZzcWwiOf1oX2L3diZHQGJRPBGlSzRFxLCiKp1Za7OJVmKwl/GE?=
 =?us-ascii?Q?s+MZN+Q5ZSHRICXzMNR504Wjg5FEasXRvdIzZJXkqNiZhyKJX9BBWr7c8e62?=
 =?us-ascii?Q?hfArH/Ps9AdxiiSYUYlwwgxmP8ywIKcSZ11SiWWIXFTcL8ymbrkxdhXzocLL?=
 =?us-ascii?Q?SH+TXZQec4tq5DcK4atN4kHprFXm1wYtjYHgiR/sIpSjGcVQKWP9E/QvBML4?=
 =?us-ascii?Q?tEH7pQsfIIKMUkoOQGZEFt/oIz6g65TruuyTz4czug=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4e0ff0-aac6-4ed0-e6a8-08dccf71f90e
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 19:19:20.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0026

On Mon, Sep 06, 2024 at 18:43:00AM +0800, Jiri Olsa wrote:

SNIP

> > > ---------------------------------------------------------------------------
> > > Now lets return to BPF and this particular problem. I won't really argue
> > > with this patch, but
> > > 
> > > 	- Please change the subject and update the changelog,
> > > 	  "Fixes: c1ae5c75e103" and the whole reasoning is misleading
> > > 	  and wrong, IMO.
> > > 
> > > 	- This patch won't fix all problems because uprobe_perf_filter()
> > > 	  filters by mm, not by pid. The changelog/patch assumes that it
> > > 	  is a "PID filter", but it is not.
> > > 
> > > 	  See https://lore.kernel.org/linux-trace-kernel/20240825224018.GD3906@redhat.com/
> > > 	  If the traced process does clone(CLONE_VM), bpftrace will hit the
> > > 	  similar problem, with uprobe or uretprobe.
> > > 
> > > 	- So I still think that the "right" fix should change the
> > > 	  bpf_prog_run_array_uprobe() paths somehow, but I know nothing
> > > 	  about bpf.
> > 
> > I agree that this patch does not address the issue correctly. 
> > The PID filter should be implemented within bpf_prog_run_array_uprobe, 
> > or alternatively, bpf_prog_run_array_uprobe should be called after 
> > perf_tp_event_match to reuse the filtering mechanism provided by perf.
> > 
> > Also, uretprobe may need UPROBE_HANDLER_REMOVE, similar to uprobe.
> > 
> > For now, please forget the original patch as we need a new solution ;)
> 
> hi,
> any chance we could go with your fix until we find better solution?
> 
> it's simple and it fixes most of the cases for return uprobe pid filter
> for events with bpf programs.. I know during the discussion we found
> that standard perf record path won't work if there's bpf program
> attached on the same event, but I think that likely it needs more
> changes and also it's not a common use case
> 
> would you consider sending another version addressing Oleg's points
> for changelog above?

My pleasure, I'll resend the updated patch in a new thread.

Based on previous discussions, `uprobe_perf_filter` acts as a preliminary
filter that removes breakpoints when they are no longer needed.
More complex filtering mechanisms related to perf are implemented in
perf-specific paths.

From my understanding, the original patch attempted to partially implement
UPROBE_HANDLER_REMOVE (since it didn't actually remove the breakpoint but
only prevented it from entering the BPF-related code).
I'm trying to provide a complete implementation, i.e., removing the
breakpoint when `uprobe_perf_filter` returns false, similar to how uprobe
functions. However, this would require merging the following functions,
because they will almost be the same:

uprobe_perf_func / uretprobe_perf_func
uprobe_dispatcher / uretprobe_dispatcher
handler_chain / handle_uretprobe_chain

I'm not sure why the paths of uprobe and uretprobe are entirely different.
I suspect that uretprobe might have been implemented later than uprobe and
was only partially implemented.

Oleg, do you have more insights on this?
In your opinion, does uretprobe need UPROBE_HANDLER_REMOVE?
If so, is it a good idea to merge the paths of uprobe and uretprobe?

Regardless, if we only need a temporary and incomplete fix, I will modify
only the commit message according to Oleg's suggestions and resend it.

I'm aware that using `uprobe_perf_filter` in `uretprobe_perf_func` is not
the solution for BPF filtering. I'm just trying to alleviate the issue
in some simple cases.

Sorry for the late reply as I spent a long time looking at the details
discussed above.

Thanks,

