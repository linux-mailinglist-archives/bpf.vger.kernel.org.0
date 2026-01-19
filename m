Return-Path: <bpf+bounces-79416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BF0D39D2F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A8003001FDD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383629B228;
	Mon, 19 Jan 2026 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZUvd1pm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DG0Eo96u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740301A9F83;
	Mon, 19 Jan 2026 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794077; cv=fail; b=sICCLo0RCULPqNFobblZxOvCo4E6WKkRkDaAz/ilvhyxI+kFGIvQg3Z8U1uKdd9JfZIaSg/hPd1iF1lUYuju6GU1BtbNh2TGsFC+9+ZwQOTWNNo+fk26tsFeJlZeGjFzuMrYG1ai9m5UK/peEJd8S/CT6Hw9Zq4hj3OIf98czIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794077; c=relaxed/simple;
	bh=pH0PIF6HHYLZ+Cqt3XzVRQWdZvbH4ZysEqUyISf9coA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfvvO9eeiqvy5xEQCX8wgXo5/AJ2Jf7/fXBMGCPc3+cnFWo+XYlYa3sRu6i26X/JQ2JOjUm3/b5NlqRI9v4f2i7pgGOMjM6P56N6hrMQPvjYq+B5cafTRuu5WQUy/SacVUX8IrYplCPM9x2pkyBNNbcGhws2jma/czOHU/UfCSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZUvd1pm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DG0Eo96u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J1KlMK320417;
	Mon, 19 Jan 2026 03:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dXKVRZuQACHDrb4ujKq4CNnID40YHFMw0nSRLMWlim0=; b=
	JZUvd1pmevOM+GWRu4Cnjm/L6ltz3LF4kTtUROzmktXSeJb2Z3Ar7DEc898irQzI
	HMDXeamHoJOSQHDfwyiiMs6OSO3S1KeWjEYYOoLw3XJAtWO94FaFZ0XO8MURPCDP
	IjLI8qnh9b9Nt5Kx1b0Rz0R+1wMewT0rjEu1Q+CxLp0ZQmA1Xp7k6kgxN34zk28s
	0tWdx+gXo2rIhYa5qjfzEgSoJG/++FNIjKqHM3hFl57+vHC7ZZyErI2/sdC55Y5P
	zgbVcXpbA2EZVfUOixHsfDpAIDK5OAk2rOW0Xw+15qQyQ0uJ3ieli3JMw1uRYojj
	0oyhkW21aBkoOqjNHM+fDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b89p2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 03:40:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J2AJZd022543;
	Mon, 19 Jan 2026 03:40:22 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vbm62m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 03:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UENh6Due0Fb9OzkwPlCRIz3HCsi1tpT4bfBxb6/lWQhrgxMiOvOj/J9sZpzvDZ/cZMTkdGC9oNjKcT6beh8BnAm7xOyBK1zz76Y+hLfVHm/0Sa2AL8GQdasxf8/NQYgIfMMVZeFjdxca9n3a3UKuSugvys0lnnxirv+9agLjsyWUw8yPOrpBGVtkcRdoZPzt0OLeCSLaTlT7UlZOv+PHKHAciq9Md+VDItvSBa93oQS7MnXqnPLrk/jL2JiYFhIOD2S3WYrQVO6e529OIigtGIDhMSpWZ4YXevvEp/tMdACK+vdA8aNGUqj8OkLBmPtVev+C7KWxCfz1/rhXm9IfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXKVRZuQACHDrb4ujKq4CNnID40YHFMw0nSRLMWlim0=;
 b=C1b2CpI6SVW8Bhg6iGo0xPHnECnF7Fbd6nlTSrl1CklapZ4w+kSa3h02UnPGT5+Hgv4CbfmRLtK1sQ3dre22xnw0+L74cE2l8YGqgesOPdBMWIx8ri38imFczxVsWSU+7SVhoJebOTe+TAouL+N5OVBY6k1AG/KJFPtm9FsqB25MJ/RBg76QYaZbu5tKSzWm41V1QLKxcYTQuHtm8V4dq60Nor8eYi7DWuw4REBeiCUr4yj1mbaxEmYgtsRflO/RpD18GWx9yXO3UK4Mk1mvR+CPWqT8Knm9ibEGARLWECQzfUsuadilMN9RlefufEnJyccKY6nBtVXddMGiY9mMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXKVRZuQACHDrb4ujKq4CNnID40YHFMw0nSRLMWlim0=;
 b=DG0Eo96uogrAyfywFiiblhsNNlF1iXTVS6O+VEQdjigv53JfW0fF4HF6g9vPKqAS+kYzKm1wAsxubyOpEntF7FNMPZC3CwX9xN0nOa++DQsQi30A1KRncpnFTGer2PlhrdHdwAwCW2WTMb1RcQVb6mNjx/cvdg4/yIPzmKDyX7I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6635.namprd10.prod.outlook.com (2603:10b6:930:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 03:40:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 03:40:14 +0000
Date: Mon, 19 Jan 2026 12:40:04 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 06/21] slab: introduce percpu sheaves bootstrap
Message-ID: <aW2nlIlXFXGk4yx1@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
 <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
X-ClientProxiedBy: SL2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::27) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 349215c3-b048-464d-2327-08de570c748c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1M5WFlVUEdiWHlFZzZCbmpXSTJ4Qkh0YnE5NjhXOEM0cWFVcXdxaWlXdTBs?=
 =?utf-8?B?allRZVUvbGVRWnJzTzI4bFV1MTlEY1BjSGNaRXg5QTFBZXFSV1VTSkFxZkZG?=
 =?utf-8?B?ZzBLZy94NUJYY1JtWGxQRHFDTERUUHNPL3k4UmQrUVI1QWJ0WlZ4cGp6VW5Q?=
 =?utf-8?B?YlJWcHprZ2FydHNYUGE1TjlpV3lSSDJsblhrZTVPT05CODg5UU5KbktLRWFs?=
 =?utf-8?B?WTVVejRDaERGdUlUWXFDZkhyUDkydldvWE9PamkvOUZGUjY3ckQwb2IxOFRS?=
 =?utf-8?B?eVdxN0tlelgzNm5hbmEyZTM1UGN5c25LV0ppWmo4em9MeWI2NTh2bTdQc2ZD?=
 =?utf-8?B?VG42YUN5dWpIWmZHVFkyZUJRQnFDRmIrVVNqSVplcTRSUWxFTkE0ZXZPeDhh?=
 =?utf-8?B?VzhRcjQ5akc4bXUyZnRDQ0ppZUJBamZaOWswcE9EYmxjSzlZd0tBRFZGbW53?=
 =?utf-8?B?NlN3OExSUUVwK0w3N1VCZURGSDEzdU0rdHdCTjhrZnZYTGM2dGlkS0dHZGZn?=
 =?utf-8?B?ODFkSmtNb2FPaTExL0RDZmJLZGs4Mzd1cm1aVE9QQ3UrWjMwT2MxdmlqSEhD?=
 =?utf-8?B?akkwaktIdkhrN3dqYTcwVXlQVzZKSmpGS1R5MThKdkVvQjB0K2U2dmhGVjAy?=
 =?utf-8?B?dWZ0ZTBYYU9wanRJRDVzUnhJSGx6dVp0UlNLODl3QVJ2Z1Q0dTlZdGN2YlE0?=
 =?utf-8?B?MkN1Y2czMGxEVWx4UnlvczNZSEtvZitoaHZjTFRnSEZYazErOGVHK1lZaFRn?=
 =?utf-8?B?UG5LMHhtOUxQeHJlLytiMGlqYm1XVUFHTTNKTU9OdzEvb011Qy9Ud0pxaEZL?=
 =?utf-8?B?c0ErTTVBMzBGMHo5eUNTekVkeWtvTUVnaWd3VUlCNm5uUU56UDcva29xTkc3?=
 =?utf-8?B?V2xMNy9xN3A3OTl2bTlscmtyOHRvdXhDZmVUTkg1em9US2RnSVNmaXNEYlhx?=
 =?utf-8?B?ZWxTSmZXbmI2SlFQbzE5N09XbVA4N1hXcXFRdzMvbFVrOXg5ZVAzVkExT2FX?=
 =?utf-8?B?Mnc1My9qaUZ1WkJUZzFpY29hdG1hKzN6ZzZLQTNoUlJHcFNQMzdORjVkT2pQ?=
 =?utf-8?B?VXhYWXk4V3plQlplSGdTdmNOTU8zb0g4S2tkT2doRm1kL09BcUdaZWEzZDBO?=
 =?utf-8?B?Q3dNRVZ4TE94U1Y4VTdwbWIxNEkvZXN6K25mcEZFTjZzbDIzSWpvWE9vdUZt?=
 =?utf-8?B?OHdycXFlL1F6V3lhQUdERzRYa1RNZVNJNDBOWXBYdTdGVXcyL0Y3VlI1eFAz?=
 =?utf-8?B?MHJ1ZVh3SlNHb2dnNWh2SlNmNnBwS2xZdGZWdnBKRzVHbEpBS0tERGRwK1I1?=
 =?utf-8?B?ZVVjeVFkREFxSUpIVU5FZkNvNnB3YnBVSGJxVU5yNElORjduKy81WW5qV1p4?=
 =?utf-8?B?a1RTdGIrYXNrcnFuTS9BQ0s2SzdwN2ZMTEo5NlQ0cmpJVVB3eXMveXl3dWhF?=
 =?utf-8?B?RFJkcUkyZkpWeFh0YzF1b3hRU3NsdVk5ZkR5SUEvYlR1ODNPcUdGUWwydFYz?=
 =?utf-8?B?VFVjRFNtMTQvSHdhL2JEczJNeXFEZ1drMEF6aG5lY3FBU0hEWTU5dVJLYlo2?=
 =?utf-8?B?d20wdmFZMVZHZHh4QTg3VDRzZnhnczc2N2hidHF0M0pia1o5TFZhL3A1STRS?=
 =?utf-8?B?WllTRzFFdHdMcUQ4d1NRQXNiVXhoUGFXemd6dDc2a2RpRmN5bVhxODk5Z2ps?=
 =?utf-8?B?UTluR2hyc2lCT0JhSTVpQUI3RXFpakw2YlJYc2xyQlhVajF2b2xtVmd2a3lt?=
 =?utf-8?B?ZTRjQ1pQSWRCa2l2UkIrQ20yNkRuRTJ1VHBBU1daRUxJSjBxYkQ1OWpxSEVh?=
 =?utf-8?B?U0FIMC9jMXdxZUgzaWs2eGVmUU05WE9CWk5FZ1UrY2FQR2xOdStsV1hzeURV?=
 =?utf-8?B?b1pKVFp1MmJLVGRISXNNb0VUTDU0V1luc1dKYkFvUTBBMHpCSEhyaFBPSDJB?=
 =?utf-8?B?SEZOb1plbHl0Zk5YeWo1a3ZrMkpTbEhJQmFPQVMxQUJGZkZDcW43bHRYQk5k?=
 =?utf-8?B?VU16RVNlYjRuRE40dWVRVlAyd0JOd1AwZlM5MDZiWnlZd21EQ2U3bDdpci9V?=
 =?utf-8?B?WlRnNklSY1pjU3pFN3pyVnI4QXYxQ2N3QmhGRkJRaVhYMTYzK2JyVkl0V05D?=
 =?utf-8?Q?9/p4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2ZXREF0ZmEyU1ZQMDJCTktYUVZxNHpxZ250WFUwZTFqWnJaU3FJQXJGZ2lp?=
 =?utf-8?B?elB3dS9Pb285a3E5QjlHSHVqWEk4WWFEWXlqZDdtc1hveHEzVC92L1gwZ3ZV?=
 =?utf-8?B?VFMvMjEwSzZTQ010RmNaWCtaZlJseGEvMWpuWGpZRkdCTGdRTE5KY2R3M0ky?=
 =?utf-8?B?c1czNDNQeTVhQThuOEttcitHODFieTNweHNwWU13RldHbm1vcUpGSEJHQXhW?=
 =?utf-8?B?ZENzalJQaFlZc24yYnJhYzA2VjR0YzIxNUI1aEF1akIxWEFzYUx2MkFwaWZk?=
 =?utf-8?B?b2JKRjlQbEhWcUdrZVRZMUJVZWdrUE9Yek9nck52N3NJUVlRTmlzVGlJUFVM?=
 =?utf-8?B?dS9qMFJtVmdMWmxsY3FDcExqUzUwVDRDMWZ5N29ackxXeUM1YStHUDFlQTdT?=
 =?utf-8?B?MGxtKytMZUNZRFRadU1PK0ErTmMzV3Z2ZHFMeHRiYXlVdG0vZG5odkpTWmNw?=
 =?utf-8?B?ZGp5K1ZSOVViczl4ODNNTkxFeEliTTdyeEdnN1U3UXBSOTNaT1N3YjE0a204?=
 =?utf-8?B?ZWYvT09tZDAxeURrZjlpSFBoMmg2WlBDK0gxTk85YkFBa1VUU2wwYVorK0M0?=
 =?utf-8?B?MGUzQzBQK2NyaFdrMCswU3ZSVGh4d3BvODdLTTFtSDBDTjFXQndERnZrd0pN?=
 =?utf-8?B?SU5LQUoyWGhNUG1tdHM1cTZ4UDQzYWRLVUUrcTY1NTlVUGo3WjJBcGsrL09F?=
 =?utf-8?B?K05vRUw3aEFWZ3BLRWR3WHVPb3dDMXhvcXdabFM1NHBjaGhEeWJQa3MvMEtZ?=
 =?utf-8?B?Rmx1Y2VLVXFOYmU2R2d0Z256bm5qSHpzemtNNSsvSktUeUt4VWZVdzlMNTRa?=
 =?utf-8?B?bmMrcG52Mi9lSkd5OTJYY1M5Y0ZEbjkwWldmanRBKzdpTUh3ZGxLbmNNRDJP?=
 =?utf-8?B?eWJEdVNuRkJFM0F1NklvdDlwcnpLZmw5eXZVd2hRSzV2L0h2YXUwb0wvbkVO?=
 =?utf-8?B?ZDBld0JVN1BndlVCM0E3aDd4blNMRjFDM2lOeHR0U3JWc2QzQ253N2g1Rndm?=
 =?utf-8?B?ZHYzSmEwZHZaUXo0NG5YSFN3b1hOMnMzR0FYd1dIeTUyQWtBcEduVjNnbmtT?=
 =?utf-8?B?WkNJSkJ4SHZ5REJFNGJzNExDZkkrRDdodkFMMlg5bVlVKzFFNXd3NzRRSllo?=
 =?utf-8?B?S0U4WTl5UkQwZHZBc1hYZFBOeFZHWGtqbWRVeFFGNEdlRjE4MitEQnBmdWtm?=
 =?utf-8?B?Wit5Uy9WUkRKMTlRUCtPSjhMNkZvdnpWc1BDUkFIdTVTekhqS214dzl4OURT?=
 =?utf-8?B?OWdFZnJacklsbDdTbGpOU3VpQ3FZM1dyTnFTOVJPMU9KRDJzVFJ6Zjd3b2s4?=
 =?utf-8?B?dFpreG5uaTJVajd1UU5CT3hOZlpLcGplWWNLWFBGU2JNekFzeG10UW10MDhr?=
 =?utf-8?B?ODZRdkU4eENYOVVCSHZGcFRHQnRzbHU4eUp1R1BpMDBKUkRvUmlPN0lxVWQv?=
 =?utf-8?B?bWNUM2lzWDFHSHB5ak9OVk9DdkpZK25leThFYTNQNm5qV2dKSmlxMElQdThU?=
 =?utf-8?B?TDRDVTNTUWJYMFJxZ3VDVjBuZnQzQzlCYW55Rk5IWFVFNkV3SmpSem1NMUxJ?=
 =?utf-8?B?UVhQSHlqc2Z5MFlFSWxBaStnMWFHTGdQYU9EQW1jUi9XTEFDMWFFQlFKSGxq?=
 =?utf-8?B?Q2loZ0x6WVV4eVk5bllkOElydi9DLzQxNGM4TXZPT1NDOFA1cVlQV0RRS1Bh?=
 =?utf-8?B?NlZkemg4cHRIQWdUMGFHanJrUnVpQks2cWRhWU01SUdseHk2b05BU0llTDNu?=
 =?utf-8?B?UFlHWUxTOFcwbTJVazFuSFZRVGhtbGZEV21STzJ0cDFqUUd2ak1RYTBxdFM1?=
 =?utf-8?B?aG16TTBTTSt3WTZJL2VhakROZmMxb25jSDhrSlJXQmNaRWozVkpUMEpWbXZm?=
 =?utf-8?B?a0pXbUdEeUV2amRiMzlBbDJFVkRDTzZKVkE5cmNiVFc4OHVoaHQwNXhhZE9k?=
 =?utf-8?B?K0RaYmptYWQ4aDNVb1daYnBFWm1CNjBQOVNlR3AxbC9XdGlDL1AxVUNCcUFs?=
 =?utf-8?B?d0o0MFVSUDFHczUwZDhyQVVydk9acmJuOWJ4VVFSbnRmVExZai9NQkhnb0Er?=
 =?utf-8?B?MkFyTlhxMm9IVjR5bTlvV1VFdUgweDM0UG5uWmRBK3pDcmx3MlREYUVBSE4w?=
 =?utf-8?B?dHRlYUhlVVYxZ0ZjRUdBUm9IWGpNaWtIZXZ5TkFkOE9XVW9SZzNDZmNRZUts?=
 =?utf-8?B?a25xVmdycHgxR1FzeXY5YVV5OGdMVnRFZDVjVFZ2eGNpK3BuWmUrMFhUek1U?=
 =?utf-8?B?SFJQTEZkcENEb2I1ZlhwM3owa2FlYWxwT05CazFVNXFUSEx5bXp3cmlUYUlp?=
 =?utf-8?B?NnovRzZpVTV0Y1Z5cGEreVdOSXNzUC84bFJKV2ZDemowMDJnWTFPUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k+abDA2Z8QMLHAb3qyhCPEgWiPB4Z3Q4e1DBA6tmZYntC07zTqukfsEHB8zaOg7xPjX4LP+XbwySOZkGCkPAd9DZYhoHU18pvKt4vcx5i86/w9K+IBfqKthU7i6qXKMQsJ3/jUkBX/QfrQU/sxLw15DZnxc4Fq6yvJb4r9qjnS8SQLW/mw5XL3B3KiNSwYNvQjkeao2bySQQnXyB3r6Rs/umacSBD7xFCDLAQ1KPvVsNF6zaehFIyDpEVpHmnU1g2y9vAfZtLppdxX8m3/AD5bM0YH/I20P7qr4WVB1IqNdfRi6lEkepZPgDME/ffgDoCYlJELh8nZIsceEuK2C1YTrbN+qovgiIb9/Yw42CWAJcgXxg4YP4rH56kZau+BoPYT9UGooSb6s3H7pWgJXZXe03upXAawuqXhuMzJW15TmrQ2cJ82/n/3Oiz9hqs2YvrMr+Lfqgv8uXPmu1wjG5bAAUE75yndlQ/bSRca4W4UeRzBa8gkL7Nf6G9JcuhmJR7vXVtrEljZ5proOSjWiuA+pcyOPPescBzonpPSiryqw0D4PpPUPSIZA0IGcenDs8MZZ00s/9Bz1oWrAHUApizoRSv2FUOWVznDz7EJBTdJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349215c3-b048-464d-2327-08de570c748c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 03:40:14.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp6tvdZPLZr2lK8xH/DxMto8Fy5U+FbZBVZF8Ow2JMJrlJv4GGyUjD2/0TRDzr9eSIWjACd5/B9sJkt4DPwvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190028
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696da7a8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vNGDkrUGIHPNHXQ7m_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAyOCBTYWx0ZWRfXyHdkO//mkT2E
 AmOhKOh/sRM8LVjF2+ZDHz/LVLqItPebWWMIZGd/76+4AilWy1tBeaFBPlf6qxe9JuYOGIvnhR6
 2IJ6mUtXi+3FBhxNjW+2Wm+3j6xSXXFcPAKU3kiOp1Ifxlqj5t68IJMW37AJhEpLOpsKCCeVPwl
 SxWBq5BWppIbh6dpclVxtFWHLx6YfYNI/b8vMWoYeNIRxWr4hKdbx7KRgBK39TdEOp7wGNiNfLW
 A+S2VY1gMoqrrHtFvCvOaJXk9uMahm1nSbINzndOticaUXB7Yhn35zTzatGiCyMOqD+w/5HXAA2
 l7HBduGxdi4Riv7cA0T2wIjpGvu9wGk1XvLBf9g3n/FizYESyX8Fjsig7l6j2gcv4y9PNHmuWnj
 XfWx5SLo21gCbYhVRjD8cSmMNIdlDYLW4BSYu8OuOMlyYTxkYC8D+ALRD3DIb+7HES2wF3/77NS
 9Lb9K29Pc65pz3/hJZ30KFS/0Per+3hWPsyRoQZ0=
X-Proofpoint-ORIG-GUID: gxkvvMAMRBf2cA0XcQ4NOddJGjJx-7_j
X-Proofpoint-GUID: gxkvvMAMRBf2cA0XcQ4NOddJGjJx-7_j

On Sat, Jan 17, 2026 at 02:11:02AM +0000, Suren Baghdasaryan wrote:
> On Fri, Jan 16, 2026 at 2:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
> > sheaves enabled. Since we want to enable them for almost all caches,
> > it's suboptimal to test the pointer in the fast paths, so instead
> > allocate it for all caches in do_kmem_cache_create(). Instead of testing
> > the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
> > kmem_cache->sheaf_capacity for being 0, where needed, using a new
> > cache_has_sheaves() helper.
> >
> > However, for the fast paths sake we also assume that the main sheaf
> > always exists (pcs->main is !NULL), and during bootstrap we cannot
> > allocate sheaves yet.
> >
> > Solve this by introducing a single static bootstrap_sheaf that's
> > assigned as pcs->main during bootstrap. It has a size of 0, so during
> > allocations, the fast path will find it's empty. Since the size of 0
> > matches sheaf_capacity of 0, the freeing fast paths will find it's
> > "full". In the slow path handlers, we use cache_has_sheaves() to
> > recognize that the cache doesn't (yet) have real sheaves, and fall back.
> 
> I don't think kmem_cache_prefill_sheaf() handles this case, does it?
> Or do you rely on the caller to never try prefilling a bootstrapped
> sheaf?

If a cache doesn't have sheaves, s->sheaf_capacity should be 0,
so the sheaf returned by kmem_cache_prefill_sheaf() should be
"oversized" one... unless the user tries to prefill a sheaf with
size == 0?

> kmem_cache_refill_sheaf() and kmem_cache_return_sheaf() operate on a
> sheaf obtained by calling kmem_cache_prefill_sheaf(), so if
> kmem_cache_prefill_sheaf() never returns a bootstrapped sheaf we don't
> need special handling there.

Right.

> > Thus sharing the single bootstrap sheaf like this for multiple caches
> > and cpus is safe.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 119 ++++++++++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 81 insertions(+), 38 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index edf341c87e20..706cb6398f05 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -501,6 +501,18 @@ struct kmem_cache_node {
> >         struct node_barn *barn;
> >  };
> >
> > +/*
> > + * Every cache has !NULL s->cpu_sheaves but they may point to the
> > + * bootstrap_sheaf temporarily during init, or permanently for the boot caches
> > + * and caches with debugging enabled, or all caches with CONFIG_SLUB_TINY. This
> > + * helper distinguishes whether cache has real non-bootstrap sheaves.
> > + */
> > +static inline bool cache_has_sheaves(struct kmem_cache *s)
> > +{
> > +       /* Test CONFIG_SLUB_TINY for code elimination purposes */
> > +       return !IS_ENABLED(CONFIG_SLUB_TINY) && s->sheaf_capacity;
> > +}
> > +
> >  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
> >  {
> >         return s->node[node];
> > @@ -2855,6 +2867,10 @@ static void pcs_destroy(struct kmem_cache *s)
> >                 if (!pcs->main)
> >                         continue;
> >
> > +               /* bootstrap or debug caches, it's the bootstrap_sheaf */
> > +               if (!pcs->main->cache)
> > +                       continue;
> 
> BTW, I see one last check for s->cpu_sheaves that you didn't replace
> with cache_has_sheaves() inside __kmem_cache_release(). I think that's
> because it's also in the failure path of do_kmem_cache_create() and
> it's possible that s->sheaf_capacity > 0 while s->cpu_sheaves == NULL
> (if alloc_percpu(struct slub_percpu_sheaves) fails). It might be
> helpful to add a comment inside __kmem_cache_release() to explain why
> cache_has_sheaves() can't be used there.

I was thinking it cannot be replaced because s->cpu_sheaves is not NULL
even when s->sheaf_capacity == 0.

Agree that a comment would be worth it!

-- 
Cheers,
Harry / Hyeonggon

