Return-Path: <bpf+bounces-68633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B5B80119
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075EE163F58
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73304285042;
	Wed, 17 Sep 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+nNTHcm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YrNpBxUo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5462737E8
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092581; cv=fail; b=AtTPP0yhIKjHpZsI6RB+v/aj838Si6ZchZN8XURiF/DWWXnJWHuwKwMc4CztBtxZP7VcDT6zmYuLTOgSksPQdFlSFeS3QS6EIY5n0acW4vYRIFQzVPakCJ22esxzuqDbtU0AZ7vroOK7u/oGhAOO9Q6JsQuS5OE853/WhLvS+5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092581; c=relaxed/simple;
	bh=cBMy+wDIYeAn6JBTs6lWAf1if9n/EeKkt66LC4fO9Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1e87SRX6fsmfD6DEGq34HiYFAoOcZM2cXeSE6oE13Yy/sVMWukbGWA/zq0NqGWpCPjzHWQFf67C1gf87paAUH9sOSiCPAR9YjAN3em0Zu6kBdTdxWsS52czOsl+yGTsji1JQKs16pB4Neyqz8OYV9O5BsGGQZEFCIKZWH4GxoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+nNTHcm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YrNpBxUo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZH2Q032620;
	Wed, 17 Sep 2025 07:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jbnqip7ZcGxH5Zxqj0pCkyqFfltLpMxEADyq3mnFyaQ=; b=
	Z+nNTHcmLcpBVF8Bsj8xcDrCNKbi4CXmzkExtjKr1eexPPL4rVREu9UOOhbgJbxl
	v/Ex9Vxk5DmWU9XCmg4S2mGRs9jJ07x/yJ2yPOILozFSXodu/YNB1iLmQ2Y/tPdK
	vie7/db30XwFJEaJJc0cbzh2n3XPAaDVIMSymSeWomtRexYAlg807XIu8HBehIFp
	rrMUDjGfEIq9tr9lKg42OaiytPzrdFBFm4kCsPcMJWzre05Kht5FQBtDD2dnqrww
	D2M52fAYDAIRQn5LHud31aYWjsPMnvsz2hCt019+a1OhOxXYvax6cIL9x5zTnYmM
	nzOJEruKlDS2lrXz7k5NDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb0hyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 07:02:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5vxKe035203;
	Wed, 17 Sep 2025 07:02:38 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2kp5c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 07:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwzVu0vvyCGue4cmciT0fa8VVzVPUUHlBRcRhOVjhSK+hL05uc5W5Uemk+pFobeHBhoLKGFlBYkAIf1EQuacGyBuE5h1b6YYkVTqWdorxnlFhvVuOJokiBiEAG5Bacaq/Pf4exjEy6OoLDkN00L00w66pz3jrZgXAdmBbqBXpLGduCJQavUfd0vYpz8aU01OrA74W4u4CbhwvPhULkPUgeuUYZCkYbWf59Foux7Fjj86E3LksHIGFg1kcBsTcM3Ckt7ALZdpidOfRexMY1tOk7HePCTFXCSmrkXbSKXsiBIwMXuFIcXy1YZaU9HHfr9pYqrXzs9M5X9PVuFyibVpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbnqip7ZcGxH5Zxqj0pCkyqFfltLpMxEADyq3mnFyaQ=;
 b=yGoSmfZishmYDeORrmDe3JYp1owLoISUvDHnyO2hP+/2HB+FfeoDvhhx8CFYSn8OjDrzp3SHcLG0pYzLhHPVISFTUWDdB64N8hADn/L8Dw2hNmstv5LsiS0vUOwMnAWcOraAFG5u13CGIfHWkc05NhJi3ezWzZXDLilr++/5o3cD8rVWG1g9ST6L+0/e0sukl9lrVQsYVv84iAu7a5Nb8mRl65sbRbXNNlX24Y0JaJtls0Ro8HqxD1/a5sUp1znspm7SOcJaJF3vAfapfPm6vnhxt29Fu3RVAEDwZZaIfl/BZX0QbwtZgc967/HmIi14pMp7rtkaZp4ccoCXQULXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbnqip7ZcGxH5Zxqj0pCkyqFfltLpMxEADyq3mnFyaQ=;
 b=YrNpBxUoenQ9M56EAXIcCkPOKCBUz9zoOqdx8Bt6IQIDGaygtwjmlIbXCZmk0N+cmERPa5nPRiL1qdTNUwbskTisOw7qy+AzOYMNjUK2RaregznJGcGwfVHEvaKqpxT4IMVbb/UFkb7hZRYljOq0mV39X/PGGeXkA/4TRBxbyIo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPFCC6481C4C.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 07:02:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 07:02:34 +0000
Date: Wed, 17 Sep 2025 16:02:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
Message-ID: <aMpdAVKZBLltOElH@hyeyoo>
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz>
 <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz>
 <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
 <0beac436-1905-4542-aebe-92074aaea54f@suse.cz>
 <CAADnVQJbj3OqS9x6MOmnmHa=69ACVEKa=QX-KVAncyocjCn1AQ@mail.gmail.com>
 <c370486e-cb8f-4201-b70e-2bdddab9e642@suse.cz>
 <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL6xGz8=NTDs=3wPfaEqxUjfQE98h5Q2ex-iyRs4yemiw@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0046.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPFCC6481C4C:EE_
X-MS-Office365-Filtering-Correlation-Id: 20288838-513e-49d5-a20b-08ddf5b82d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFJZaWRXNGtxcnBad0dVNTBublRRUmNIcExCTTgvM1p1bGdONzM3M1RNeERX?=
 =?utf-8?B?RmoxMmthaVJZdEtDa2d5b3h5TzBYd0hCTGY0azFaN3U2VW93aGdLYXRNdGxP?=
 =?utf-8?B?bjhEUmNmK3dZcDJRK0dwcGQ1QmpucU1tamFwUGJvcFU1WFYvQzg4NS8rUC9L?=
 =?utf-8?B?RGovMjRXcVY1V282T3k3Ynp6d2FnR2lodUV2VGlpbXFoSzR2bEdxVy9pMElH?=
 =?utf-8?B?bHFUR2FUaGdOekN1V05HVmVsbVl5TkZXRnFuY3JvWC9GbjNCUDZTUFovb2Q1?=
 =?utf-8?B?N2JDZ2tPYXJnNEY5MmdtYUluVWUzQUIxUTlxY3JPNDR5eHh3U1p5ak5LYzRw?=
 =?utf-8?B?bWRjR094RGR3bDJ6S0Nad3UvTDFsTEhzdkozSTR2SjN4azhvdVBTN2IrV2d6?=
 =?utf-8?B?dnRzVU9ZTHhsL3VwYTB1WWFNSHd0T2JsUDZuUkhVVzlHTVdVZ05pa3YxRm93?=
 =?utf-8?B?dS9lbXdUY3BsR2tua3pMYTNySVRpWlJIb3dySW40aGhFRk1nRTdpWTB2akdP?=
 =?utf-8?B?MlRBV2kycmkzcEY1eHc3UDR2Q080WE9Nd1k3SW9TcjVpV2c2V1U5L1lscVdy?=
 =?utf-8?B?MlNwS1VQd1pLRStLVGNQUFMwOHBsdm0wTEtyUVZ5ZTNwVG9EeUFjMHM0dnYz?=
 =?utf-8?B?cjhtYWxBUDFNMlFkczF6MU9wT241VnhBTm1vRnFLdmlTcWI0OWIzaExBZmJq?=
 =?utf-8?B?T0p2SkZYT0kyaVNjc1R5QzF5bXVyQUdXVjIrRHdScEtNTzQ1dGRpSFl2MWJx?=
 =?utf-8?B?eTd5RVNuQlNiY0hQeldtTXJaVmRWbUdZeFlhaTczZmxxd2hwUlY3aXlUV1Fr?=
 =?utf-8?B?UWtOMFgrRERLY2tSUHdaWjY4L0h0TkN2UTNPcmdubkdvcVRNQkxMeTlLV2Vv?=
 =?utf-8?B?ZGtOMUh5cDlmR1NnL0d6Z2NVandzelptQkFGTEJSTGFGR3hJV2ZKb2JYc3p0?=
 =?utf-8?B?TWQ4OGpqcEVvcE9leFNnbUxFVS9CMWFXeHpWVjZEMlFkYlZlUk0yRzJtTFUz?=
 =?utf-8?B?WCsyY1VKeU5xVXZiQzh6WUhYbUpGKzRvSi8wbkZFYXY2b0hlRHZHdUFBOE5E?=
 =?utf-8?B?czg1MFFQdnRPU0dxNE5NYTVtNG9Yb3RVd2lsR25wZ1EvSGxqZklwMVBTMFY0?=
 =?utf-8?B?dXdRalJLekpha0lYU0tPYU53TmloYWQ0S3o5UnJ4QkRwQlFaM0lWOTNqYTlC?=
 =?utf-8?B?dnVVVmVhZVlob0VPNHhHYUxqNXpSY2xCQzRhMWlRKy9oNm1sekk5cXpGZVdL?=
 =?utf-8?B?ZzN2bHduUzVnVkhUeUJwKzRTWk1IeHJFa05RWUxqYmFheUVLYzRIUW1uQlBG?=
 =?utf-8?B?RGt6SjVTYi9rTVVxOStaZzd0ZmZjcG1LREFOR3Vtc3k3dHlyK0ROQzBjMm82?=
 =?utf-8?B?TUdpbkNtVFNYM091R05ZWThkdFF3bStsc3RwajlQVGtrUWpWV1hBcnNlMlFv?=
 =?utf-8?B?ZUo5MWRUWWpQY1JHWGs3RFovUFBjVy8zQVl1STJPZWlNQUZ4SVlwV3hsd3l4?=
 =?utf-8?B?enUzT2h4bHkzZDhEdG1XaVlZeGVWZ0hyTHRldnM2YzBiVmwxQXN4SUZLQmo1?=
 =?utf-8?B?Kyt1djcvZ1BqQ0JkVzBZWkVDQksrNWpxWlR5MkhMNzk5eDdaNC9CN3RVbDN0?=
 =?utf-8?B?cklLMmRhQXNTbU04c296Z2ZXSW5iM1hRamI5ZHZHN0R6T0NhZnUxbE80N3Zw?=
 =?utf-8?B?cktuWlQ0U1RkQnQyQnIycmo0M1NyYktVdWl2WDJoVUtUemZEdnZ2dlljaVFT?=
 =?utf-8?B?SG5FU3JsUFp0dWdxdlNrZGxYMVJhN0VpRTBwaXYrVlFKRmpPdXhEWUpUQkhZ?=
 =?utf-8?B?SDg4R1JBUWVFOGZqSWczOWJYVUI2dzVSOGdCbHIra0hiendMT3E4Tms0SnZ1?=
 =?utf-8?B?Vmx1NHJOR3pzcFQyaGlsNGd2cVVTcDlYRXBMNnp0SjlZclJnUzBJV3Rha1dt?=
 =?utf-8?Q?1wYW6zZwmEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk9qd01nZjdHL1pUeWZOUXlFdExwdmZ2QytwT3M0Unc1WFVKbEFJUzJSY2hM?=
 =?utf-8?B?L2xXdi9aM2dLUy9FVHFVUXU0RWRkUGw5NWJQSjM5ZUxpZW0yVVdPZGozQ3Nv?=
 =?utf-8?B?cEcyMnRJMm1saXdReGM2TWYvejJ6eW5mRmV0MzJrSmx3MHVNcVFiQ1RkMU10?=
 =?utf-8?B?ZWg4ZElBZzdoRUV5MzY4U21POGp6SXRnUzlCVkZiY1lodSt3UmxZbHhBK040?=
 =?utf-8?B?RHdLOGFQa0NqTTVnYTE2YTRseVNDb0gybUhNSnU0anFlQWx2dG90dTJDa0hv?=
 =?utf-8?B?QTkwTVA5eGwrbHNMQ1U0dGltUjJqTFJaRVczNmlMQTJHejc2SVhsMXZ5dlZR?=
 =?utf-8?B?RFpDNUN3bDhsZm1LbVdLckVCRDFGNzZOR3JFS0FtM24wbEN6eU1QbENmTXZX?=
 =?utf-8?B?dFlidlh5ZURhendTcnZDS1VDampWdTdSTUtGMzFEMU1wSE90dWhySlE2WlZG?=
 =?utf-8?B?ZXpvQkx4OFdwL2dvRTBYcUYrbTlSMEV1cDE0OW9DTWVMWmRBR3o3OUJwaVVJ?=
 =?utf-8?B?QlJDd0ltMjU4OFVpRmVIdWlNUFllT2VraFg0MFFUSWY5dExsd2dNYThlclJI?=
 =?utf-8?B?dDJKajk1dVgzenVPZ0ZnMGQ5M2RLTmJtZ3VnclgvZHF0SXh1cFMyaFRSMVdL?=
 =?utf-8?B?OTRpWThsYWhIMTN6bkpyMEtHQTNJR1EyMkJNYXhxbHprdUJScVhMREJ0THhH?=
 =?utf-8?B?N2JiOTFVQ3pzMnM5TzNqd3hUR2IvUFpZTEpJQ0VQcEdSai9DSFZJWHRwQzZF?=
 =?utf-8?B?YTNZYXEvL2pFZnZxQjlaZFFLSUgweThGNTVUU3RuamIySzhNaFB4RmZpQllp?=
 =?utf-8?B?cTBBd1k1SVA2dWdNeHA0UG1kMk9vaXFtdDVtNEdrUk5sZVhJUzFnZVRCWE1l?=
 =?utf-8?B?QVdXVFN3U2IzU01xamJZellWbk9mQUNKcmZRK2R6cHk4eXlucTdIMnl6UUtV?=
 =?utf-8?B?bEtobklOYlNPY2FEQXBocXNjMllGYkFTMUN2a3VzK2dTWmZLQ2ZTeXpNL1NZ?=
 =?utf-8?B?eXdROUxMOTc0cEtDeTVTYkVNaWN0ZUgwTk9SKzl1aURhV2MzZzFCby8zVW5J?=
 =?utf-8?B?ZU8vMTRQZTRVclQxSC9vWkpYUzJRTnIzL05tc3o5NWtQTW4weTNLS0tVNlJ6?=
 =?utf-8?B?clFUeEhZcDg3U3VCSHlaZzVNTGRJSlNVdUduTXR1ZFNTVCtnYXloSk9ESHJF?=
 =?utf-8?B?aGNXUVZzdElkNEpXcmQxUzVEMll1dGdoQXRMVjZhNkQ4blVldzZaUCsrUmNK?=
 =?utf-8?B?U3NLVjh2YUxWenlCMTBnd29Vd2RSNHRrUnZVSFprTmVhTUxCREE1ZThlNlJt?=
 =?utf-8?B?Q0VvNFRrc1JsaHhnMkVLdlFjbmRHSVk3bGt2WC8rUzhvbE9GZnJpR3paU1NJ?=
 =?utf-8?B?d0RUMjlsY1VpSUlCUnBFWXdNYXBEeVhkaitOUzJyR25VaVpRaUc4eTlaQjN1?=
 =?utf-8?B?MjZlQUNvTVE0MHAxMHg5U2VMTTdFTDFMbnFqci9MR3o3bWdXckgwMGx4aWM2?=
 =?utf-8?B?Y0R2MWFNNVVQN2pWbVdoYkM4bmlwSUdQUjF0V2NCZVZLNldhbUYwWlBxRWF6?=
 =?utf-8?B?WGl3KzFQOHlNVGhoT05xbDdEa2RHc3RIMDF0UVQ3cC9WQlI3M2xhRHJyK2Rp?=
 =?utf-8?B?NG8zNkR1aFRueFJMSGdORUc5a3RNVDU0ZWw2dko2STFxN0l4WDlvMFZXamdj?=
 =?utf-8?B?SUlNQ0JiUnZnQU03UWFCRXVRTThWYXdqZ1VWU1RMLzB0RE14NzVkN0ZRcENl?=
 =?utf-8?B?TmFxM1VCTVQ1YXdwUlhWVmRYMGhudzZMMXF4QmxsOGZVVE9BUGJybFA3aTV6?=
 =?utf-8?B?UUkxT2EraE5xR1dPSHlvdzJpUCsxZEpmVnQ1Z0tvc3JoNmtmZXgwTTZxdzJ5?=
 =?utf-8?B?V3YyU29BMmxKYlY3aGpFc3N6YlhmOFVzc00vTXg0dUNQbzhoYWI3R1NIWEQ3?=
 =?utf-8?B?Mm9nRjIwQ3ZjdHNET2M0M1UvUHpvLzByYmlnRERBemNGMzNBa08yQ01jNGhZ?=
 =?utf-8?B?TDNBZVI5KzVzaDdROEU2ZmI3YVI0UkJST2daZXdoWUNyVWdMNjZzeE5tQ2M2?=
 =?utf-8?B?MFZxTUd0MmdYOVEzRTdXcnNhNHZDYXdzSnZMejhiTEZkODlzVFhqUzYvSTV5?=
 =?utf-8?Q?7XgS0gBVZPt0WLkXO8QLjWUMO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CeLh8KjNDHOmT6aaEHnnQv+Papi42DnzNYTPJaP6NnbsM155qES/5z+vwEbXB15V0ViXPRIIIvnwekm6ALt6tf0LsSB4h1dq3GTFfcxowzaN8QsrMKiQBR9SnaFb0TyHxXrawYHw2Nog67FzTW63bZiWsJOuG/SF1OawWlbDsVyFBxsTVs2ILPuGvcjtVI+0pjtQhp+Zfsi2yGJp5Oy+0l3vOML7UrVtFYZh4jfgm4Pa5o85R0tu8q9CJynjjYqubrkFcK81amZs5I3njgbg+ZXGD0+RXJRjCDto65Pb0ecfoq51kBGNN5/sbGHOV8+4+jocwfzCRWL2J5855H5vbaQ0qNBMwpWC+TPVEcDYOuxIQR94ggQl5g98NyUoKE0md+4SFpD6+dbXYd2RDptqgO9T31M0oHHrWqyA11ZHzzNuYJZeB2R7P/zl8+nRFBYQ0i7vOtAf+HPuVV+a6Dcd7YJFpARgs3he7YFwpO1ijqBRcefEa0wAANeJLLOC4Gea421QPxFVKlcTaI4kcWG8o3xKPuTG3HcJDLjEKFlGZHSRTTEOnpfRPgCFNlIcpX1A0Ajoq6X5yeS6Mk6dojHvmJRG3ut57DZbK/Pvu2e4dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20288838-513e-49d5-a20b-08ddf5b82d6c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:02:34.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTln2DYITTfaDvXtZA9jmvs9cOYBZIIWkKwDMa9JS0xeyTNsKii0di6igBDqVKcx4P0dYeQS3t0wnuFU6l651Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC6481C4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=928 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0oijGDI2Zu1E
 sf6rUV28btzlr7NYtUGr3ZYvZshav07+v1FgPhVY6o89zk+s3DbZ9V7lBdrsaIpFstEz+SNMy8I
 mya0OrVd1uLgAKzOKJJDoEwH31qvXT08yVZQCkxIbKjoSnTPaGEB2fSntzDeuLg9me08CIm0Rmc
 gm1Q0os49isvW4xdh2fXJI7PfWQ2vMQUQbLDLb9AW31p8KsUA627zif+h2v71Mr5EG2u1eAv7SE
 k7KaTuiom6M286aledlohiaxyOl2Rx5yNHGAw/NHvMIV7ecLSAfJcSsMmmzXyP3M+utBKVsWLO4
 peQOyR0wSf5aM/mC1ofey2VQWb4UjgVUt+XNTqbsOKzT4yJnn8F2dFRnulex7Xgfj9YnTeh31Tq
 Qd5erAc/Z4967acmuDFpVwr6DmMDug==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68ca5d0f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=4pYPNrIQVuUIRFadlSAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: Y_B1m0hEH6OW88Xnfr-R5kx6wiluyN7e
X-Proofpoint-ORIG-GUID: Y_B1m0hEH6OW88Xnfr-R5kx6wiluyN7e

On Tue, Sep 16, 2025 at 01:26:53PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 16, 2025 at 12:06 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > >>
> > >> Hm I see. I wrongly reasoned as if NOKPROBE_SYMBOL(___slab_alloc) covers the
> > >> whole scope of ___slab_alloc() but that's not the case. Thanks for clearin
> > >> that up.
> > >
> > > hmm. NOKPROBE_SYMBOL(___slab_alloc) covers the whole function.
> > > It disallows kprobes anywhere within the body,
> > > but it doesn't make it 'notrace', so tracing the first nop5
> > > is still ok.
> >
> > Yeah by "scope" I meant also whatever that function calls, i.e. the spinlock
> > operations you mentioned (local_lock_irqsave()). That's not part of the
> > ___slab_alloc() body so you're right we have not eliminated it.
> 
> Ahh. Yes. All functions that ___slab_alloc() calls
> are not affected and it's ok.
> There are no calls in the middle freelist update.

Gotcha! I'm confused about this too :)

> > >> But with nmi that's variant of #1 of that comment.
> > >>
> > >> Like for ___slab_alloc() we need to prevent #2 with no nmi?
> > >> example on !RT:
> > >>
> > >> kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf ->
> > >> kfree_nolock() -> do_slab_free()
> > >>
> > >> in_nmi() || !USE_LOCKLESS_FAST_PATH()
> > >> false || false, we proceed, no checking of local_lock_is_locked()
> > >>
> > >> if (USE_LOCKLESS_FAST_PATH()) { - true (!RT)
> > >> -> __update_cpu_freelist_fast()
> > >>
> > >> Am I missing something?
> > >
> > > It's ok to call __update_cpu_freelist_fast(). It won't break anything.
> > > Because only nmi can make this cpu to be in the middle of freelist update.
> >
> > You're right, freeing uses the "slowpath" (local_lock protected instead of
> > cmpxchg16b) c->freelist manipulation only on RT. So we can't preempt it with
> > a kprobe on !RT because it doesn't exist there at all.

Right.

> > The only one is in ___slab_alloc() and that's covered.

Right.

and this is a question not relevant to reentrant kmalloc:

On PREEMPT_RT, disabling fastpath in the alloc path makes sense because
both paths updates c->freelist, but in the free path, by disabling the
lockless fastpath, what are we protecting against?

the free fastpath updates c->freelist but not slab->freelist, and
the free slowpath updates slab->freelist but not c->freelist?

I failed to imagine how things can go wrong if we enable the lockless
fastpath in the free path.

-- 
Cheers,
Harry / Hyeonggon

