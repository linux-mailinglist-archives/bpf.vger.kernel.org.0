Return-Path: <bpf+bounces-79528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF1D3BD08
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C4783027FE6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DD24466B;
	Tue, 20 Jan 2026 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTzGd0Ru";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GcOVh+ah"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489DF21CC62;
	Tue, 20 Jan 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873337; cv=fail; b=H6Ohpx6JhDIRU4oxYN4Jalj8okZUfX8f1bwIqE8Uzgp8dT9CnwYWQcaOwh4O63p2Ns+362MR+ThnegEH7qnTfw8G40SRyT8h6BB9MDlMUo/xdF55z7iKBPj9soGytlROBIud72LNZ7ELchyDBdSosig85ZaaXSQjF3bZegfMF2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873337; c=relaxed/simple;
	bh=sWn0uia5oO/V0ArUdnpIaUO9uMxSM8ItI/VaN0wmxaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KjHLL0JU9YdT9Rx8srylQENsLE5dkNq2Y9CkTimioSLb1qI+t3ZSacA/9vktOPUsPI5XjrdsZmHqArXs1FdM+8/8om6YaQvKiZvNIuoudx1jBH8Zi3Y06jcwEmJhO80uIJaUimJpNwubzRPKvABVU/q2FbEGIhFca886lir9aMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fTzGd0Ru; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GcOVh+ah; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JLuvUM2568797;
	Tue, 20 Jan 2026 01:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w/0DYR/KmPWl+XtrkD
	SxjB3uX4z+XMesfyQ/yBb1qT4=; b=fTzGd0RuFdL1pufkofEjHhSymTnkelIgrY
	lfr50UGnLWaHH/scNryFSjCHt3+Sn0GnfLAJYdfMz7TpAF0A1hLET0lSEy9BJRhZ
	VieHU9uxmuxlrq1PQREXELLdyNTLYTX+S373ilGt/BwC4gFUE+WcqBi5uDQEyPWi
	7u4it1rM/r4I7izs7Sm+3MYRi/u90dY3ywAmhQmgYYSZUD3hXJpzD5/iSNwSbaqd
	VAsGRoc+P5fBr4Zuqt4FTshczb1wapQw7t9H0N80m1Wbh+WogmbTeZKORJSUai2U
	DwMXzQv7u4Nv5w5RoxRPZ4DjO+O6fGGCBIB3ww8d16Gz9hc3brqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qayd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 01:41:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K0MgKU032213;
	Tue, 20 Jan 2026 01:41:55 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcq6dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 01:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIFALoZPUIxXPXM+8Q3OCBiKmEtaz91U48IjawIpwxRgpcufkXRnILmxpfXrJxFEdQefDw36ZUaPIAtfaSBEchU7y+mmBx2rP71zqH2bJEZU0rRHY2jtyjLw+knu5iT1GMy/5E6F+vO6H1xbkN70nCIQSXYddF5e8Nocia097lmioXNIwoFSY3ogjjzURpaMw6Us37qIQrLbhgago9gokN24uV0woa1l5IgVrUlRXbQtuLojqKYTH4dkiKLnWL0P4ytDDjLCjxiSTk9keQLBvF+Ha7f7yLE6eyqAIfluY9h+fuX6Vu5VEgtMsfyHkkjA/IUSuuTjZydmlINEujUbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/0DYR/KmPWl+XtrkDSxjB3uX4z+XMesfyQ/yBb1qT4=;
 b=lKQTvxZVOR3iEpYSYukfZfT+MI6tLYUWoUzKDoFF2t9XocNbdQ5N6aNQDfIfeisHgak4UimTxPMryW2mbWDMorDj3FlXOhpjYaE9YghVyt9W8GgmU+v4ykRrcHQq4Y50ZHtHmI6BD77cV3kIC9RJsT8hRMSmYWqTqlbK7eVBqjXf8o7Yujwn/mrwjxX0e6nB60G0XwpuYBw9Qm7lCDcFEajLKQh9xEQNlwdZWiVK58jBPE4L9LNXRmgWM70yf2xxxZ9gGuCDi3Tg3kvHXGjsqHeocx4z0IBcEA98sN6Sbq3iy5fodbbnwbs6/23ClV+peNPzdN3udBHB/g8shnTlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/0DYR/KmPWl+XtrkDSxjB3uX4z+XMesfyQ/yBb1qT4=;
 b=GcOVh+ahddZ5ljfMFwBfTJBqr5h8StoRzoGCWgxY7tjXKe5IU89RzchkWK2Q0d62n4ipZ+oHJ3scX/4eDU2neM7dE/20xVdnJ2yKT/WpRUy6nNa7v8Ua5AoPYDtxK4ivUW9i1p8le2olIWd2yvdgSU0bfIUm8eXpntsROURjO4s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPF7F0BE85A1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:41:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 01:41:48 +0000
Date: Tue, 20 Jan 2026 10:41:37 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Message-ID: <aW7dUeoDALhJI0Ic@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <aW3SJBR1BcDor-ya@hyeyoo>
 <e106a4d5-32f7-4314-b8c1-19ebc6da6d7a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e106a4d5-32f7-4314-b8c1-19ebc6da6d7a@suse.cz>
X-ClientProxiedBy: SE2P216CA0146.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPF7F0BE85A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf14fe6-143e-4da8-b287-08de57c5137b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wl5sSO2xRkx1mBnm6k/gWy9QYNAbx2lRZbr97Nx4+mSzmk8h1LjoGEPupcUX?=
 =?us-ascii?Q?n0L7mb2+LPqzIiiTjGJdfQVbR41c54XiaXgm3HWcrl11rlluBu8KpMW27+5Q?=
 =?us-ascii?Q?Mn/b7qN32+jsKpEsFIBoNVl927ek6QIg1VVOTGI4zlgt6KM8jELQAvcO2sJ0?=
 =?us-ascii?Q?3aIkDFJyryErbouNq5FM0TBWMCFhmWWS10haEm0u25dKJm77OzcwpG0KmNCn?=
 =?us-ascii?Q?aC/qmB/MZY+RlZOLhsI3gQDfC5caj2vhu3JDM1qJRJ+Rhjr3if6fKjZfXUcN?=
 =?us-ascii?Q?oslJNqpp8JE2IXlE0k03N0xwMMdSFY9JK5tUIVsIQgPhj18J4GKXY2DYNzs4?=
 =?us-ascii?Q?CLyRClNNpveaGa9d4GPRvwTPjGdkaCs9BR63rca/wKtLFfbw7a8s0cLXzaZE?=
 =?us-ascii?Q?boqZR7ZP8ScuLAhhZWn8t7LVQlgg9CQx0I2dx/p2gsdH1+z6t214IL7fkYQ7?=
 =?us-ascii?Q?aW1Lb1TDXl9FsCDFrFUjpKVoT7LgY9DDGetOAuv0nhocDbL9WnNBuliDEDVj?=
 =?us-ascii?Q?/ts6482EXdFsmh7EqXS6vQiH0nb3jDn8hS2mwpsb+e+3nB8dSEn4z0orTQDb?=
 =?us-ascii?Q?+xxBJe97Qu9tnhM5xl/lucunFDcEW25s6yetzM6QoQnceCs97IHEmgeW0KKi?=
 =?us-ascii?Q?syxZT9d1NhKe7j7uqAVgAIPzMBPIKM7J9ghUKj+++I5Q4o8GnUJ84i5B8dK9?=
 =?us-ascii?Q?ZkIbxuTf1IKyExAN/8W+UKOL41xuzzZ08Ntz/ozlDXjnMOwT+JKJkrRR1yui?=
 =?us-ascii?Q?7sg5FMFStq3V7KGMVh8xX2CZnxG0duGZUlFCqOHyMjK7Nf8NTEz0TUQrQpRW?=
 =?us-ascii?Q?MMyozX7gb4sHU1bxKNPXBC9Q3zE03mFOcFDkJRCL9eh5VTiwKt7cZ5uGaDs2?=
 =?us-ascii?Q?+Edh9ZZESDxZm+zNSWC3JQjjivqsVUqOgiz85MuLn1bURP4QMoq0Y1mSU7KJ?=
 =?us-ascii?Q?Wj8Ctsrx8DApRJGyUNgIz2tpjqaFvSDBSuB7uuRC1ewBaFFnS+Vuvuy01Y5k?=
 =?us-ascii?Q?Vg4bkO9TTt3NL7SjH4cncqgBO57MiHXNWFlZ7WbThnm7BG6wkjLyeKiA7Fof?=
 =?us-ascii?Q?fkFIXubOC2s+nrJOO2OqcJ59P617hOeJXJKp9Hx2wx3ivLH/DsVOjmU0/5m5?=
 =?us-ascii?Q?0loE7W/sjrJV5qazWRJiCVZrJV4H81FSSTB1lJ1CL6uQQHUfnURWCZl/QQtQ?=
 =?us-ascii?Q?BtALU1wWqarkT/0R626Hk+kscnp87xURGfFiKvSXLyGBYEuxVQ27NyKaS3Wk?=
 =?us-ascii?Q?n/T1hX5oE4WFabs7Lf3nBW7Rd+eSgLl/WRtW9GeYJPpqOW+tm36JVJf+5y8N?=
 =?us-ascii?Q?Eiaq/zCiKsEchFV/wfcGTlGxu8r8wfE1SAGeaRJA+l9FEES5/m1ZDyAO/8hh?=
 =?us-ascii?Q?uCC53xwkvlXlNnfZISpQ82iT+EkaRUcOkD1bXMx2AsBB93jIYnHPfjWgNq/B?=
 =?us-ascii?Q?aKtNj7OeLQ09nXkzspY7NW6iIGt9dBTIPhtyS9Pl2px7BK4snwSfoPeYGx/e?=
 =?us-ascii?Q?1NHBqxFltg65Tu1g+YCh11ejamnLApGbOsnRT/WZtAE8b9WzFX9ezwMpNZIZ?=
 =?us-ascii?Q?Eq1OtPUF6NUyTf9geBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oYThucZk9CgmENk4ZpOmlNjW9SO1PTbYMONFRs5T+uqm5go0EUzyTLsYU8g?=
 =?us-ascii?Q?zNlwox5rDnQ4SVNXUl9SNovn8fa5O7JVeb0wwPiid4hmcMP9Kpygvi34sI3S?=
 =?us-ascii?Q?hd6Kb59DztOt1W2WW3rDLbFkxUBmzpMYmo+ZxA2+oLAoHFmDR/7tLE61QwWE?=
 =?us-ascii?Q?uBTVgCIWDz6rHZeV0jyf/V9SxVuNoxCTCK+2/vf7vkPHlL11G/LBrzzFliqQ?=
 =?us-ascii?Q?iJdb2awxDXaRtnCiNqfMya9HdM1pc9b6QzvQkAs4P0OkN04JiWWNl5bRYJCc?=
 =?us-ascii?Q?HJfVZAApRgXbUvmLf0NSilol6bRmjA4EpLOeQjs4dMsxnAmQn5BlpRf+A03U?=
 =?us-ascii?Q?Hr66k5NebgVwgad1TMpi5SzsVLk0uWA3mrb8iv+Cslw4VKyVyvkD/PLsXM9F?=
 =?us-ascii?Q?MvkDEbl3M0VFrs9PUMilm1MsYRjJ5u4Ujwg4K1izK23cd5sER0LrFPjMHwep?=
 =?us-ascii?Q?FgK5fsNeoWrDVZFIBAGJZ/Ws+5t7ixhTvVfXl9iG+uYXLHOPN1ClocSUoWTy?=
 =?us-ascii?Q?H7L8xPNDxtZ8cLtqDjMwfO8UYCcstNDkep6hsOHChRzPLPKbTIOrQdv1yZOs?=
 =?us-ascii?Q?T7LBNYOLI6WZc39HulyII1srN+DfkMFSWvZfH3rAvv3K4g0zyKx8USJ7mBK7?=
 =?us-ascii?Q?Zt5qQXqqDU39+FNswMjZBo5M/PMwBoEcu7JkVa1tdxTdWbv564X7vr3JoVxV?=
 =?us-ascii?Q?foWF5347r+HTWe8t965yXW7ktC+RkjQ5+S19HOf7qmqZZvJ7jVQ4AQ2pQwQl?=
 =?us-ascii?Q?JsjOnfJHtXH+Bnew4gAbVQIiziZVZon6TbYHzUBmEoYonoqgtVxULwAwy4h4?=
 =?us-ascii?Q?EEMy3RIfER6Rsd9EgzVUz4jEu9M/hr0AvLtG1dhYfFZ5XNzamXKf2eCrbCdP?=
 =?us-ascii?Q?f34FytT9xShxgyhzeDPSQgwcB15cIBKzhE2IXr1FXtgUsJKisu42BPB52lL5?=
 =?us-ascii?Q?8c/lEMLKYlmdMmMDoSa2WmanBJxbf/3xZALVgdcWxwABctdI82xrU8Qlc10H?=
 =?us-ascii?Q?TRmELk4/FbKd8AmAc9+cki3DQyo8pYCmGP0unc9u13va4kEuY8EbjZUkz7/q?=
 =?us-ascii?Q?sE9bOuI4Q5FMNuTr5StPjj3fj2vYOTuBPzbxmsxPilIEnMTy4ysbIw03f0QQ?=
 =?us-ascii?Q?NdLIvEGCFZlTPO05G3FmimxJfac9/dyq8/Jz+G7r8/pvKyQ/XtbGY8GoHdkW?=
 =?us-ascii?Q?TLgzWTnLUpAo/P1l22P4NhZ7jZiIKekeuwYC77K6kjEwEnFQ1GHxSoJqAzne?=
 =?us-ascii?Q?1q2cfExSNssDJ69qOKLfU0QqkrMRvUIZbL9MZ45xG3MMuCCFbKDJS+y1Le2f?=
 =?us-ascii?Q?rVYCGfsXsNu4HcBZsKmno/Gi+7fWBYWjwXSgiqnMscfNscye8J3OTVisNUYx?=
 =?us-ascii?Q?22830CbzA5e2od6v+IZ4TqTQLbEMxfr4q2ucfu9vO800139DwZ5+0SWP57p0?=
 =?us-ascii?Q?MoyBurdn1Mk4UaWjJ5g4pB7yDylgELH6w5PZL4dR9mIR8uRIQYPLrCvT6tmZ?=
 =?us-ascii?Q?xtOW+20SAdJQE7cY4kYBH7DKOAlMp7nNbhnOciRj0qddsPOR6rHJ3gujDOVa?=
 =?us-ascii?Q?6s4fV1WYYhLTWiAcsw/Jn7Kbvm1Ud1yzPsPBWKONKdgdpoz1V6ngShq5hadb?=
 =?us-ascii?Q?16+GJS/A8891+q0VW1OfR89wTCmYGQXxI0+IP/LWEUD8Tjsf0YsywnIoKiUl?=
 =?us-ascii?Q?Rxk6f2UflEt74IrH6/m+lmwdJdUZgLNYFd5kFnp5S8wyBGlGpWM35ZvDTUpU?=
 =?us-ascii?Q?0gpkaiMW4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9WeLb64QjJmbm9inXy8dCv1aQVK4wdFq4PCi5EPBnsmoNJZX3olccnF9X/utQGDWZmgEhP8agx6jtBziYj9SeM9ibe6dyHV3TtDQCWZ1Czl34gPN7Ik/DovyD4dEteAVywsv8Zuz8HMAhC//Tcu+6/WyMHMChttUH84U3e1old6kRDABlTUeu08+UdAH0MV5jXUmocXkKjugGj+HNKInvAFp62hiIn1nncrUOpuqRPu2Ib8UCVQVfT5XC2I2aE+G+IJnARle8qZzu7iST2Xxd7zst2naTWALlWhymSxNfvp49Ax8aLSTiHKuYNWI0ttvZlqD3Qwvltmzn8zBcFy02Rtb0V4C/vAcGFE+1JOQZ92vM1xqbh3BWoeOZtWkEfj2Abx3SiaN8KyZ9j+sbRJEFAcoEOTa6+jgsHM75Y8dnamX/eeTuRJnRtlyzT/08GePKROBUxOyhjiMnI0U9R0eLK0Y32JmoADpL68si564wGRJviphaStzEKFdnVhRy43e069RkqZAN11M4V9HisSdBAxMJejz4tcoEzumDNItJS5K7nJJVYA6Hykq/xbl/HDjgmorvJeUJEJv5syFOM5zSh1V6RVeqnh2XlrYSEN8RIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf14fe6-143e-4da8-b287-08de57c5137b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:41:48.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR7a5QsNZFOqlv6WDvwQDWNZTn7Q24j2RMgehdPJ35Ms6cQ9sPzlFqnrIyen8yc6AkpXZixqgHOwCkDm9Dh1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7F0BE85A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_06,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=983 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200012
X-Proofpoint-GUID: gsG4sUCPa8zsCpUQQhDqnq3LGqWAd1wz
X-Proofpoint-ORIG-GUID: gsG4sUCPa8zsCpUQQhDqnq3LGqWAd1wz
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696edd64 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DBvTpO_pozPjgqcj1I0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxMiBTYWx0ZWRfXzVbfY9jXUPMm
 RdTZzHy23lUi3qxEIuXtbifqbX3C4VwxwOZ4MZbUXcaMEjFiDbOUH/34QwUYE2BeCDU87hmGutr
 gTAocM2lhHNu7egQFk6YB3s91v9j8E9b52EO/vOziX1dWWfWz8XxE55ggEzq3ElKHsyJILU0nRu
 COW05r0QZPkQpQB3bN0zNitsYW6yzW/ys4nvsml6BOshGkctkPRtYj7Qtf1i1kZx8zyYL1TMCKj
 8E7QyH/1zFzAmYNRlVpIVbPtNxgeHc+mSQgRr48u0kgKt5LKEAv5PsmUjCmZcu/pIHBBh/oPRi+
 5/jRfGEGG2Ue9gR6AP4ANW53MBUoxMIsidkK++WX+XQ4YRddTo8RjLRjO1veaXtLosZUoR2xLCU
 aYS58++d9gFJ+3zfMHBHZP4g4NJ6J+OPIzAdzlVx6QaZZ26CU4v3x4kFnGseJAyrx/b5Xms5RXF
 RQziEcpI0IptwuTOTeH/oW+nlFewS+9LyB5F4yag=

On Mon, Jan 19, 2026 at 11:54:18AM +0100, Vlastimil Babka wrote:
> On 1/19/26 07:41, Harry Yoo wrote:
> > On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
> >> At this point we have sheaves enabled for all caches, but their refill
> >> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> >> slabs - now a redundant caching layer that we are about to remove.
> >> 
> >> The refill will thus be done from slabs on the node partial list.
> >> Introduce new functions that can do that in an optimized way as it's
> >> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> >> 
> >> Extend struct partial_context so it can return a list of slabs from the
> >> partial list with the sum of free objects in them within the requested
> >> min and max.
> >> 
> >> Introduce get_partial_node_bulk() that removes the slabs from freelist
> >> and returns them in the list.
> >> 
> >> Introduce get_freelist_nofreeze() which grabs the freelist without
> >> freezing the slab.
> >> 
> >> Introduce alloc_from_new_slab() which can allocate multiple objects from
> >> a newly allocated slab where we don't need to synchronize with freeing.
> >> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> >> the cache is a non-debug one so it can avoid some actions.
> >> 
> >> Introduce __refill_objects() that uses the functions above to fill an
> >> array of objects. It has to handle the possibility that the slabs will
> >> contain more objects that were requested, due to concurrent freeing of
> >> objects to those slabs. When no more slabs on partial lists are
> >> available, it will allocate new slabs. It is intended to be only used
> >> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> >> 
> >> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> >> only refilled from contexts that allow spinning, or even blocking.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slub.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 264 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 9bea8a65e510..dce80463f92c 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -3522,6 +3525,63 @@ static inline void put_cpu_partial(struct kmem_cache *s, struct slab *slab,
> >>  #endif
> >>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
> >>  
> >> +static bool get_partial_node_bulk(struct kmem_cache *s,
> >> +				  struct kmem_cache_node *n,
> >> +				  struct partial_context *pc)
> >> +{
> >> +	struct slab *slab, *slab2;
> >> +	unsigned int total_free = 0;
> >> +	unsigned long flags;
> >> +
> >> +	/* Racy check to avoid taking the lock unnecessarily. */
> >> +	if (!n || data_race(!n->nr_partial))
> >> +		return false;
> >> +
> >> +	INIT_LIST_HEAD(&pc->slabs);
> >> +
> >> +	spin_lock_irqsave(&n->list_lock, flags);
> >> +
> >> +	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> >> +		struct freelist_counters flc;
> >> +		unsigned int slab_free;
> >> +
> >> +		if (!pfmemalloc_match(slab, pc->flags))
> >> +			continue;
> >> +		/*
> >> +		 * determine the number of free objects in the slab racily
> >> +		 *
> >> +		 * due to atomic updates done by a racing free we should not
> >> +		 * read an inconsistent value here, but do a sanity check anyway
> >> +		 *
> >> +		 * slab_free is a lower bound due to subsequent concurrent
> >> +		 * freeing, the caller might get more objects than requested and
> >> +		 * must deal with it
> >> +		 */
> >> +		flc.counters = data_race(READ_ONCE(slab->counters));
> >> +		slab_free = flc.objects - flc.inuse;
> >> +
> >> +		if (unlikely(slab_free > oo_objects(s->oo)))
> >> +			continue;
> > 
> > When is this condition supposed to be true?
> > 
> > I guess it's when __update_freelist_slow() doesn't update
> > slab->counters atomically?
> 
> Yeah. Probably could be solvable with WRITE_ONCE() there, as this is only
> about hypothetical read/write tearing, not seeing stale values.

Ok. That's less confusing than "we should not read an inconsistent value
here, but do a sanity check anyway".

> >> +
> >> +		/* we have already min and this would get us over the max */
> >> +		if (total_free >= pc->min_objects
> >> +		    && total_free + slab_free > pc->max_objects)
> >> +			break;
> >> +
> >> +		remove_partial(n, slab);
> >> +
> >> +		list_add(&slab->slab_list, &pc->slabs);
> >> +
> >> +		total_free += slab_free;
> >> +		if (total_free >= pc->max_objects)
> >> +			break;
> >> +	}
> >> +
> >> +	spin_unlock_irqrestore(&n->list_lock, flags);
> >> +	return total_free > 0;
> >> +}
> >> +
> >>  /*
> >>   * Try to allocate a partial slab from a specific node.
> >>   */
> >> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
> >> +		void **p, unsigned int count, bool allow_spin)
> >> +{
> >> +	unsigned int allocated = 0;
> >> +	struct kmem_cache_node *n;
> >> +	unsigned long flags;
> >> +	void *object;
> >> +
> >> +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
> >> +
> >> +		n = get_node(s, slab_nid(slab));
> >> +
> >> +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> >> +			/* Unlucky, discard newly allocated slab */
> >> +			defer_deactivate_slab(slab, NULL);
> >> +			return 0;
> >> +		}
> >> +	}
> >> +
> >> +	object = slab->freelist;
> >> +	while (object && allocated < count) {
> >> +		p[allocated] = object;
> >> +		object = get_freepointer(s, object);
> >> +		maybe_wipe_obj_freeptr(s, p[allocated]);
> >> +
> >> +		slab->inuse++;
> >> +		allocated++;
> >> +	}
> >> +	slab->freelist = object;
> >> +
> >> +	if (slab->freelist) {
> >> +
> >> +		if (allow_spin) {
> >> +			n = get_node(s, slab_nid(slab));
> >> +			spin_lock_irqsave(&n->list_lock, flags);
> >> +		}
> >> +		add_partial(n, slab, DEACTIVATE_TO_HEAD);
> >> +		spin_unlock_irqrestore(&n->list_lock, flags);
> >> +	}
> >> +
> >> +	inc_slabs_node(s, slab_nid(slab), slab->objects);
> > 
> > Maybe add a comment explaining why inc_slabs_node() doesn't need to be
> > called under n->list_lock?
> 
> Hm, we might not even be holding it. The old code also did the inc with no
> comment. If anything could use one, it would be in
> alloc_single_from_new_slab()? But that's outside the scope here.

Ok. Perhaps worth adding something like this later, but yeah it's outside
the scope here.

diff --git a/mm/slub.c b/mm/slub.c
index 698c0d940f06..c5a1e47dfe16 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1633,6 +1633,9 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
 {
 	struct kmem_cache_node *n = get_node(s, node);
 
+	if (kmem_cache_debug(s))
+		/* slab validation may generate false errors without the lock */
+		lockdep_assert_held(&n->list_lock);
 	atomic_long_inc(&n->nr_slabs);
 	atomic_long_add(objects, &n->total_objects);
 }


-- 
Cheers,
Harry / Hyeonggon

