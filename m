Return-Path: <bpf+bounces-45712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC19DA7EB
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 13:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C6A280A1D
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819281FC7DA;
	Wed, 27 Nov 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/xPqDX3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018B1FBE96;
	Wed, 27 Nov 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711016; cv=fail; b=Wii9bNgS4nGHSI3fGmc2uzU4vltPJpcI7/+7IFctsSIqSWqz8NcjaB04XrBduL7MeUwxRDDk+aYQmaPRP85O9CXG3k1bRSKUxEUbgB5eg67zXZZV84E8IrZhn/SmQ9T2Xey5t7oIa0a7CZuoFeSHV71s5q55CKjvJKjRk/0Js9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711016; c=relaxed/simple;
	bh=LG1YZXTdyMkxieFN6hvuzqtPkAMAavJRrJOOZTHPw/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ak3wWiLM+eDCe1e6BbJ2g17VPsNxLL8NMpDczqpbbu2SJ2GCc4RiJlIjwo+5BM43jPX9+H8RqmghCPGcO4JeEcAl90JiTGnsecwnIlw4coOStzrtRhdzI/hccobdqn9y87EIoPNSC3853hoPDGRGJOxwkHsLHf6jpD8KqvrEvj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/xPqDX3; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1h8Xf004248;
	Wed, 27 Nov 2024 12:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LG1YZXTdyMkxieFN6hvuzqtPkAMAavJRrJOOZTHPw/Y=; b=N/xPqDX3
	xb5LC3kiMUmMyVegdXcuWEaLUFnCh1aizafUvmLELXbQVh6f5aNX8IhvsclVBzdI
	uG2bB73pUh/A9ttWxSKHXsGwri5UZYYI2+gHCtnBr7MOOGcH/CRxrBzO25pCIfd+
	DhoP2RgBkUdAie9xE11ufeOKj5+1ysnsNb/OaV23wAzdmYLCDDtpfGHmq8iKwARl
	H9wXTENGUhRudFADSe/S/mOUUAeevwZqPgM5RYm/Cb5GtCVv21w4omgaFs541/od
	/rFgmMtJwHl0e7HMu9u2U5xXE9xP53fVFtU/QyFcjeNQhOKmrnc019TXLG7qq71C
	4Foyw+ec7RayBA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhs4tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 12:36:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ARCQwPe001146;
	Wed, 27 Nov 2024 12:36:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4350rhs4tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 12:36:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTiGy435Rxl5Mm+N4GHzWXkS07dUvc+AXoQIkZ8UZix/v8RDXSnNfxL2D0uY9MVQRn0GVkIMg+hgzMomaZjfcCgrV6qO6a88FvifdbK0zv6F73gkkJR2rf3Zn1rOGMgGZDPmvGxc+rzKHStBlMnLJ4HKig6Dtup9tnhtF4TXnDDVEEGjYA4hB1jhsT6tcd7p7bkDan5lcCEoJyyeWDAto+XIr7/8yoEGxeoO51aOp3U0SiLZsZpSADpQPWnx+ofNlJ5484wSqV/XIO3FeyWIEvLN8KK9UpX5mFR7V8AHLIELQj1Q5CgAcuK9J2D/q68hlTVeZrBEL1be5JeKbk6l8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG1YZXTdyMkxieFN6hvuzqtPkAMAavJRrJOOZTHPw/Y=;
 b=uvAskbralbsZ0nMzjU8HhAYH6jlu1+b+9T13XfX+TLQOUI97zhZvlrlQHIXAMEOprDtKiEhxpzJQV2tfNo9KQ5rgJiv2Mz6R++aR06ZVQ8hfoWk46DeYDr+IuP2VtRST57f1i5s+qoUsNrHexoZid+A6KGa9UeU6ArUQIxsUCX06I/eeUEP9JHwPsltXNp/O0IYtwwVywtGAtbx3+RZvnXeEAvN0SPN8+aJEmlammrQbQp6NQSpJ5lYXq0oinbxGGGHxcIhorDnfWMDavYY0VTdpIp18r9DIVJF3bAHYToMgOM2a8KfjKL1gO341zC8AKJ3A3P13ege6XY6mjhPMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB4839.namprd15.prod.outlook.com (2603:10b6:806:1e2::11)
 by LV2PR15MB5359.namprd15.prod.outlook.com (2603:10b6:408:17c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 12:36:20 +0000
Received: from SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945]) by SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 12:36:20 +0000
From: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
To: Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang
	<kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>, Ze Gao
	<zegao2021@gmail.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Dominique
 Martinet <asmadeus@codewreck.org>,
        Junhao He <hejunhao3@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
Thread-Topic: [PATCH v2 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
Thread-Index: AQHbQMj2cK6c12zAU0aCkkSHoXc3sQ==
Date: Wed, 27 Nov 2024 12:36:20 +0000
Message-ID: <0ED8731D-B183-49A5-86C3-7048D190774F@ibm.com>
References: <20241113011956.402096-1-irogers@google.com>
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB4839:EE_|LV2PR15MB5359:EE_
x-ms-office365-filtering-correlation-id: 282fa445-f6ea-4aa1-e636-08dd0ee018b2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGVJY0lWK1RSeHZGNGl4d203YWhjNUZNeWprSzV0ZGlWcERYOFRiRGM2OXgw?=
 =?utf-8?B?UDZsekMvOHlKeG8vWjZjcGFnR0QwdlhLMnJDQXJBTlhSem5SUElwWXNKQTVZ?=
 =?utf-8?B?NnFTelU2OHFCT3g1SkJxRHJUZEdFREt4Q2tLaW5NTVdrcEZacm1XVHY1SVhz?=
 =?utf-8?B?N2U0TkVRcjU0L1FhQURLWFh4UUs0ditqeVJPRWF1UTNOaVh4TjBPV1VMTkNT?=
 =?utf-8?B?Vm1yRlJVT2IxYlZ0aHJDMEFabXJIZXJNcHJXejByeUpHMGZTQnFOYW5JUE9U?=
 =?utf-8?B?K1BHQTc2QmJGaFdSZmZRdUZjelI5dng5VXJDK2JlYlEyc2h0Nlp2aVp4Q1lk?=
 =?utf-8?B?cENTWFY2MHAvckRMOWhYUVNVL0hkOEZGMzVKQVM5cFlVeGFjWG1Bc2Q3WkpR?=
 =?utf-8?B?ZXdhWDVvMEJxV2Ewb3JhR3dUTmwwK2dra1FiUUgraG4zZVlkZTdDTDdvM3RK?=
 =?utf-8?B?NEhxdm5IaTVyV2lQcmlXNVZmeUVHZW8rOVB3OHdnZEgxV0g2c0VkYWNCalhr?=
 =?utf-8?B?L3h5OW5ZSXdYUE0xU1ZPYUV3dzhVVWd0Zjh2ZklTb3lZMUI5VWp6VjRvSjg3?=
 =?utf-8?B?bS9abnM2Q0QxdndXdnNFNDltREdDU002R2o3aWpSUUhmRmd2dmErb1VhdDhx?=
 =?utf-8?B?QnB2cDJTRmltZ0tpU2k5Wi9Rem5IczJiMFpaZ1Y4REFTVElPL2VpTHZobTVy?=
 =?utf-8?B?TjUwejRERktBUWdCYjVFMkhhdGYzVGo0ZVd4MjZHVUl4d1dscFFqUklCWTRw?=
 =?utf-8?B?SzZNT2tsRzMyc3oyamQ4eld3KzBuUzNPZys5M1pBK3ZDRmRuUGxBUDJyL1Zi?=
 =?utf-8?B?eXVyU2ZUZ2cvbHBrQ3hnY2JMOVJkSDhXMFNqeTZCeEFaWFhGZ0diVmFiTCtr?=
 =?utf-8?B?KzRuWm5xRXlMcUt5ZlBUMEFPaXFZVnZUR0tKSldDVlJNQUNrOUYrZWQxUEk3?=
 =?utf-8?B?VkFhT053RjM2VFMyb0o4TDljZW1iZEtRNUEyRm9qb21XUGJueDlTRHkzVUhR?=
 =?utf-8?B?MDRsZ04zNmEvRGEyTnJDTS9VRWF2cU5haHV6eS81VlR5WHR4ZXpwbmFxVnU5?=
 =?utf-8?B?OHVIOFdXZTFxM05yNVJFNWJZWFh1a0Q2eVRRcm5YVVVabDN2UnJFMWJuMEd1?=
 =?utf-8?B?cFdrd1V6N05ZWnNNQ0NTSU40SS9IaXNRYlc4N3F2b2xNelJ2dFdZRDVoZldZ?=
 =?utf-8?B?Z2YvT09GbyswMExvSDBaUXBiaC9UWDZ4TUVPOWVMa2ZlcUhhbk1USkljdUF0?=
 =?utf-8?B?TjNzSW1xWEtqZXJtbnpQMkhWRWJVVGN3THNGMHViWFJHQysvazdJYVhQcHdU?=
 =?utf-8?B?eEE0V2VEUnFGNjRUV0RoS1NnLzlrVE82ZmV6eVdubUpWQ0VyTThmdUxjS0Uw?=
 =?utf-8?B?QnZIb1VTMC9xOEpkSnVObHRtVEVkSXRwY1lRSVl3dE5STktmYjJzYzd1ZUdS?=
 =?utf-8?B?aXZ5SVo3U1hiaHBTbnlFQ3FWZVcxTUZrQW91SVNSMjNTZ3BCaDlXcXlkR3Vq?=
 =?utf-8?B?ZlQ2NkFHU0FuVWdxREJhQWxoOTBXckRDM0xFKytZRHdVNWg0VEhjZUFSZWF6?=
 =?utf-8?B?RnluWU5TanZlYzdQTS9FM3NpWnhtWktleVN0OVlnZlpKemtLMGdmVEltajlF?=
 =?utf-8?B?MXgwdkFpMDMwM1RlU3dFODh0VkFLdzN6WmhqZUIxd1FLZ2VDQjJJOEV5MXly?=
 =?utf-8?B?M21OY20xOStYaDhoMDVjVXA0dmZaVUpkRWxzdzVDcVpqb3RVUEY1REFRMWNq?=
 =?utf-8?B?ek93TnRsYWNTNGJMZTZFcGN6U2M3cFVFc3M0WVhWQTIxdUljeENZREZQS05W?=
 =?utf-8?B?SFdrMlNyNmVGQ1Y4RGlmZnhMazR4cnFhY2dlNDB0ekh2VmJBNWxSUFJSSldB?=
 =?utf-8?B?aGFSTE1NcS9xbTN6eFlpcE9ZNFBnK20yemV5OStGUHNFVWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckxSZmpiV2x4S0U1QlBZYW1pcFVaVm1ReHlVNFFqYkRnM0IvYmxleWlnVTQy?=
 =?utf-8?B?ckpuN1NmWVpCUGVDdlBOcmY3ZVVNa3J2dk9lUDZmalRkTi9ndEZVM1J2dmRQ?=
 =?utf-8?B?dlpVSjZJRnVKUXEzYVp2RVVuMk5RL1R5MzF3WTFNdWI0K284U0EvTVNCRm1F?=
 =?utf-8?B?bThHVDUrT0RZc2d6YUxxK05PT045OVhTWUJzVG5tekJiWmNua1B3SDJEVVFK?=
 =?utf-8?B?d202N3BaZ2lSeWRUVDRGL2xSWkNmbEZjV3YyWHAwWmQ4NmY3QVpHbjIvUmxv?=
 =?utf-8?B?VVBJNTNlU3BTS0dPZTEwK0pORFR2QjdJN3gxKzFBaWRHUVFQS0FNYzlpUWpY?=
 =?utf-8?B?WUNTcXIyWm5Ib1FkSXJVRy9yQ1YyYVYyczV3WXJWUmx6dGNCWXQ3a3JycUVy?=
 =?utf-8?B?QU01MUF4QSt5VFEzTXJTeXdvOXBXb0g2VkEzbGRKMEEyY3V2bENOazVpQ1U2?=
 =?utf-8?B?c1I4V1p5SnEzNUlLM09HY2JwSlREVUk1Zm9Xd2drbEN6Y0RIOVZ4aGlKTmtq?=
 =?utf-8?B?ZjVHbTN5S1EyS3MxbXB6UW9YVmFydzJzaXEwU3VQUGtlQUl1aERRbllZbFpZ?=
 =?utf-8?B?YXd3TTluZWVtUFJuZUl5SXlHMFBNakZ5aFRiN0JaK3VZWS9WYyszMEtSUWhM?=
 =?utf-8?B?QjhZejJnWVJWNCtCb0JDSG5yVklJTkovYi91UGRRNmMrUFRIZXEvTkFKR1RU?=
 =?utf-8?B?SzZCUU1CWTJ0Z25sNEVXWk91b29Wb0YwamlEclVzcG90NjVCOEk2S2pVRG9C?=
 =?utf-8?B?TWpTQmM4SnVidVBmSDRyUHMzelJQMHZQR2xRNnFxVzRucEhqRFFJbGZvUnN3?=
 =?utf-8?B?S2FwenNqNFJQbHkvOTkyRllkYUtXMHMwUXJpZkxFSldTUmhNcmJ0QlBMNWtV?=
 =?utf-8?B?TWd1eWg3ek43ZUtNRGJCR3pkRDkzNHVOaVBPNG9sbnFqRXE2MDBtaXBtdlVX?=
 =?utf-8?B?M2tOTTdxOEl0b1NFS2hFMWljazY1aytjOS94dWxSRDlVRkdxZDJyVmJXL2JX?=
 =?utf-8?B?dDBoWlA0NVZUYlpDQXpIK2pBdmVRUitHVUJUVjIycXpyMnVDMU13Wk1nYkF0?=
 =?utf-8?B?NTBBbGVxYzVKVVRHYU1EM2dvSVMrY0NCZmN1dzIzZ2N1elQ3cGlzMmVLQzJS?=
 =?utf-8?B?L2UzMGZEMmxGVGhEcU1weWlhMjZxNC9WTUVySXZ5TEdSUlpkaWNIeHlqY2Nt?=
 =?utf-8?B?UTBKNDVlU1hkakJTbkNkcHZpcnlwZWlMUk5IbGkwRmRHaXVueHZRdDZkZGxl?=
 =?utf-8?B?UDJKVDd0SndVRVNUUmRBbmx0bC83UG9xajQwMmU4bzRyc1EzZWJKdDFzK1ZV?=
 =?utf-8?B?QXZuaFNLQkxhWDRReUxZcklubnF3ektMRWxMUmRIK2IrOEdNTjhGSmF3dTMv?=
 =?utf-8?B?Sm5JV3JtSTBTQUhRS0MxZDZ0Tndid1g0bnREVEk5Tk43OUY5L0krMVYrdWRG?=
 =?utf-8?B?azVQemRvUTFwdWI4NGNTWWIxa3IxOUlTdDBlaDlKbXJrSThwVTNUeGJyblNQ?=
 =?utf-8?B?aHpETjB3SWpGZGw5UzhyOURlVVlYdGtOakVReElkUFltSXpscFFsemF3OWFI?=
 =?utf-8?B?TkZKTUZSRWdUcWxGSVhPOHZlQXZFUFhCSGNlWjEvR1NQZGpXT1I1eG9iKzBU?=
 =?utf-8?B?eitIblRVb3I0OE5MYlZZSzVUVDc0SWhSdGtLREE4REZNQkhsSGNtMUh1dSt3?=
 =?utf-8?B?L3J3TTcxdCt3REFaZWhWczJQeVlyWjk0bnArUk1BZDNsQStNVU02ZEtwa1pK?=
 =?utf-8?B?NWczTWFXbFpJd3IzWVZlUEdBR2pyY0F1N1FYUlFkSTNobk03UDRoSmJmSEYy?=
 =?utf-8?B?YVJuL01UNEg0Q0pSc1A5a1pTMGgzbk5YR0srdU5XVXIxZkRJa3R5UW9oc3Vw?=
 =?utf-8?B?RnFCOXFVOGVNL21PMlFiTzdsVnZUUXZwc2RYQk5scjd2WEN2Q0dWUURMTFRp?=
 =?utf-8?B?RmpnRTJPd1pEb0tJSzBiSmhEekk1SmdUdWJTYW9IcE5NeVdyOFNvWmRyc0dQ?=
 =?utf-8?B?eDZndXpiR211d2t6OUlxenp2dWRpUm8rZnpPSXRFUmhjZkt0bW5aeDBKY3Nl?=
 =?utf-8?B?b0lCUDFiZDYvVU5WYlF5VTRUTW5BU081ckJiRUo4YUhscGQxYmdQQ3lzaWVq?=
 =?utf-8?B?VFJGVzVlR3ViTXFqWUxoWklzTWlkaHM0eks1VnllNXlNL0FGelRjRm9vdzQr?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0D6014F5098D84BBA8759DCF89582FB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282fa445-f6ea-4aa1-e636-08dd0ee018b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 12:36:20.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dsECuRglhatluiL3FKUD+CmH7zZu0j6V4xA7qM4wSljbP/na3GWlghcQqBbem5h87pAJ42JIvzItBiIPlQqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5359
X-Proofpoint-GUID: Fg6YIjFSnt9Lbg898QPpRF39pIl-Kxpd
X-Proofpoint-ORIG-GUID: EsmiokvqZkR3fBBaT4NS6zm00FUO3Lvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270101

DQoNCj4gT24gMTMgTm92IDIwMjQsIGF0IDY6NDnigK9BTSwgSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bn
b29nbGUuY29tPiB3cm90ZToNCj4gDQo+IEF0IHRoZSBSSVNDLVYgc3VtbWl0IHRoZSB0b3BpYyBv
ZiBhdm9pZGluZyBldmVudCBkYXRhIGJlaW5nIGluIHRoZQ0KPiBSSVNDLVYgUE1VIGtlcm5lbCBk
cml2ZXIgY2FtZSB1cC4gVGhlcmUgaXMgYSBwcmVmZXJlbmNlIGZvciBzeXNmcy9KU09ODQo+IGV2
ZW50cyBiZWluZyB0aGUgcHJpb3JpdHkgd2hlbiBubyBQTVUgaXMgcHJvdmlkZWQgc28gdGhhdCBs
ZWdhY3kNCj4gZXZlbnRzIG1heWJlIHN1cHBvcnRlZCB2aWEganNvbi4gT3JpZ2luYWxseSBNYXJr
IFJ1dGxhbmQgYWxzbw0KPiBleHByZXNzZWQgYXQgTFBDIDIwMjMgdGhhdCBkb2luZyB0aGlzIHdv
dWxkIHJlc29sdmUgYnVncyBvbiBBUk0gQXBwbGUNCj4gTT8gcHJvY2Vzc29ycywgYnV0IEphbWVz
IENsYXJrIG1vcmUgcmVjZW50bHkgdGVzdGVkIHRoaXMgYW5kIGJlbGlldmVzDQo+IHRoZSBkcml2
ZXIgaXNzdWVzIHRoZXJlIG1heSBub3QgaGF2ZSBleGlzdGVkIG9yIGhhdmUgYmVlbiByZXNvbHZl
ZC4gSW4NCj4gYW55IGNhc2UsIGl0IGlzIGluY29uc2lzdGVudCB0aGF0IHdpdGggYSBQTVUgZXZl
bnQgbmFtZXMgYXZvaWQgbGVnYWN5DQo+IGVuY29kaW5ncywgYnV0IHdoZW4gd2lsZGNhcmRpbmcg
UE1VcyAoaWUgd2l0aG91dCBhIFBNVSB3aXRoIHRoZSBldmVudA0KPiBuYW1lKSB0aGUgbGVnYWN5
IGVuY29kaW5ncyBoYXZlIHByaW9yaXR5Lg0KPiANCj4gVGhlIHBhdGNoIGRvaW5nIHRoaXMgd29y
ayB3YXMgcmV2ZXJ0ZWQgaW4gYSB2Ni4xMCByZWxlYXNlIGNhbmRpZGF0ZQ0KPiBhcywgZXZlbiB0
aG91Z2ggdGhlIHBhdGNoIHdhcyBwb3N0ZWQgZm9yIHdlZWtzIGFuZCBoYWQgYmVlbiBvbg0KPiBs
aW51eC1uZXh0IGZvciB3ZWVrcyB3aXRob3V0IGlzc3VlLCBMaW51cyB3YXMgaW4gdGhlIGhhYml0
IG9mIHVzaW5nDQo+IGV4cGxpY2l0IGxlZ2FjeSBldmVudHMgd2l0aCB1bnN1cHBvcnRlZCBwcmVj
aXNpb24gb3B0aW9ucyBvbiBoaXMNCj4gTmVvdmVyc2UtTjEuIFRoaXMgbWFjaGluZSBoYXMgU0xD
IFBNVSBldmVudHMgZm9yIGJ1cyBhbmQgQ1BVIGN5Y2xlcw0KPiB3aGVyZSBBUk0gZGVjaWRlZCB0
byBjYWxsIHRoZSBldmVudHMgYnVzX2N5Y2xlcyBhbmQgY3ljbGVzLCB0aGUgbGF0dGVyDQo+IGJl
aW5nIGFsc28gYSBsZWdhY3kgZXZlbnQgbmFtZS4gQVJNIGhhdmVuJ3QgcmVuYW1lZCB0aGUgY3lj
bGVzIGV2ZW50DQo+IHRvIGEgbW9yZSBjb25zaXN0ZW50IGNwdV9jeWNsZXMgYW5kIGF2b2lkZWQg
dGhlIHByb2JsZW0uIFdpdGggdGhlc2UNCj4gY2hhbmdlcyB0aGUgcHJvYmxlbWF0aWMgZXZlbnQg
d2lsbCBub3cgYmUgc2tpcHBlZCwgYSBsYXJnZSB3YXJuaW5nDQo+IHByb2R1Y2VkLCBhbmQgcGVy
ZiByZWNvcmQgd2lsbCBjb250aW51ZSBmb3IgdGhlIG90aGVyIFBNVSBldmVudHMuIFRoaXMNCj4g
c29sdXRpb24gd2FzIHByb3Bvc2VkIGJ5IEFybmFsZG8uDQo+IA0KPiBUd28gbWlub3IgY2hhbmdl
cyBoYXZlIGJlZW4gYWRkZWQgdG8gaGVscCB3aXRoIHRoZSBlcnJvciBtZXNzYWdlIGFuZA0KPiB0
byB3b3JrIGFyb3VuZCBpc3N1ZXMgb2NjdXJyaW5nIHdpdGggInBlcmYgc3RhdCBtZXRyaWNzIChz
aGFkb3cgc3RhdCkNCj4gdGVzdCIuDQo+IA0KPiBUaGUgcGF0Y2hlcyBoYXZlIG9ubHkgYmVlbiB0
ZXN0ZWQgb24gbXkgeDg2IG5vbi1oeWJyaWQgbGFwdG9wLg0KDQpIaSwNCkFmdGVyIGFwcGx5aW5n
IHRoaXMgcGF0Y2ggc2VyaWVzLHdlIG9ic2VydmVkIGEgcmVncmVzc2lvbiB3aGlsZSBydW5uaW5n
IHRoZSBwZXJmIHRlc3Qgc3VpdGUgb24gcG93ZXJwYyBzeXN0ZW0uIFNwZWNpZmljYWxseSwgdGVz
dCBjYXNlIGZvciAiQ2hlY2sgYnJhbmNoIHN0YWNrIHNhbXBsaW5nIiBub3cgZmFpbHMuDQpVcG9u
IGludmVzdGlnYXRpb24sIGlkZW50aWZpZWQgdGhhdCBwYXRjaCAicGVyZiByZWNvcmQ6IFNraXAg
ZG9uJ3QgZmFpbCBmb3IgZXZlbnRzIHRoYXQgZG9uJ3Qgb3BlbiIgIGlzIGNhdXNpbmcgdGhlIGJy
ZWFrYWdlLiBUaGlzIHRlc3QgY2FzZSB1c2VzIGJyYW5jaC1maWx0ZXIgYXMgInNhdmVfdHlwZSIg
YW5kIGl0IGlzIHN1cHBvc2VkIHRvIGJlIHNraXBwZWQgaW4gcG93ZXJwYy4gDQpTbmlwcGV0IG9m
IGNvZGU6DQoNCnNraXAgdGhlIHRlc3QgaWYgdGhlIGhhcmR3YXJlIGRvZXNuJ3Qgc3VwcG9ydCBi
cmFuY2ggc3RhY2sgc2FtcGxpbmcNCiBhbmQgaWYgdGhlIGFyY2hpdGVjdHVyZSBkb2Vzbid0IHN1
cHBvcnQgZmlsdGVyIHR5cGVzOiBhbnksc2F2ZV90eXBlLHUNCmlmICEgcGVyZiByZWNvcmQgLW8t
IC0tbm8tYnVpbGRpZCAtLWJyYW5jaC1maWx0ZXIgYW55LHNhdmVfdHlwZSx1IC0tIHRydWUgPiAv
ZGV2L251bGwgMj4mMSA7IHRoZW4NCiAgICBlY2hvICJza2lwOiBzeXN0ZW0gZG9lc24ndCBzdXBw
b3J0IGZpbHRlciB0eXBlczogYW55LHNhdmVfdHlwZSx1Ig0KICAgIGV4aXQgMg0KZmkNCg0KQmVm
b3JlIGFwcGx5aW5nIHRoZSBwYXRjaCwgcnVubmluZyB0aGUgY29tbWFuZDoNCi4vcGVyZiByZWNv
cmQgLW8tIC0tbm8tYnVpbGRpZCAtLWJyYW5jaC1maWx0ZXIgYW55LHNhdmVfdHlwZSx1IC0tIHRy
dWUgIA0KY3ljbGVzOlBIOiBQTVUgSGFyZHdhcmUgb3IgZXZlbnQgdHlwZSBkb2Vzbid0IHN1cHBv
cnQgYnJhbmNoIHN0YWNrIHNhbXBsaW5nLiAgDQojIGVjaG8gJD8gIA0KMjU1ICANCg0Kd291bGQg
cmV0dXJuIDI1NSAoaW5kaWNhdGluZyBub3Qgc3VwcG9ydGVkKSB3aXRoIHRoZSBlcnJvci4NCkFm
dGVyIGFwcGx5aW5nIHRoZSBwYXRjaCwgdGhlIHNhbWUgY29tbWFuZCBub3cgcmV0dXJucyAwLCB3
aGljaCBpcyBpbmNvcnJlY3QuIFRoZSBvdXRwdXQgaXMgYXMgZm9sbG93czoNCg0KIyAuL3BlcmYg
cmVjb3JkIC1vLSAtLW5vLWJ1aWxkaWQgLS1icmFuY2gtZmlsdGVyIGFueSxzYXZlX3R5cGUsdSAt
LSB0cnVlICANCkxvd2VyaW5nIGRlZmF1bHQgZnJlcXVlbmN5IHJhdGUgZnJvbSA0MDAwIHRvIDIw
MDAuICANClBsZWFzZSBjb25zaWRlciB0d2Vha2luZyAvcHJvYy9zeXMva2VybmVsL3BlcmZfZXZl
bnRfbWF4X3NhbXBsZV9yYXRlLiAgDQpFcnJvcjogIA0KRmFpbHVyZSB0byBvcGVuIGV2ZW50ICdj
eWNsZXM6UEgnIG9uIFBNVSAnY3B1JyB3aGljaCB3aWxsIGJlIHJlbW92ZWQuICANCmN5Y2xlczpQ
SDogUE1VIEhhcmR3YXJlIG9yIGV2ZW50IHR5cGUgZG9lc24ndCBzdXBwb3J0IGJyYW5jaCBzdGFj
ayBzYW1wbGluZy4gIA0KbGlicGVyZjogTWlzY291bnRlZCBucl9tbWFwcyAwIHZzIDggIA0KV0FS
TklORzogTm8gc2FtcGxlX2lkX2FsbCBzdXBwb3J0LCBmYWxsaW5nIGJhY2sgdG8gdW5vcmRlcmVk
IHByb2Nlc3NpbmcgIA0KWyBwZXJmIHJlY29yZDogV29rZW4gdXAgMSB0aW1lcyB0byB3cml0ZSBk
YXRhIF0gIA0KWyBwZXJmIHJlY29yZDogQ2FwdHVyZWQgYW5kIHdyb3RlIDAuMDA4IE1CIC0gXSAg
DQojIGVjaG8gJD8gIA0KMCAgDQoNCkFsc28gdGhlcmUgd2VyZSBzb21lIGp1bmsgcmVzdWx0IGlu
IHRoZSBvdXRwdXQgd2hpY2ggSSBoYXZlIHNraXBwZWQgaW4gYWJvdmUgcmVzdWx0LiBUaGUgcGF0
Y2ggYXBwZWFycyB0byBhbHRlciBiZWhhdmlvciBzdWNoIHRoYXQgdGhlIHVuc3VwcG9ydGVkIG9y
IGZhaWxlZCBldmVudCBvcGVuIHN0aWxsIHByb2NlZWRzIGFuZCBsZWFkaW5nIHRvIHRoaXMuIA0K
DQpJYW4gLA0KSXMgdGhpcyBiZWhhdmlvdXIgZXhwZWN0ZWQgPw0KDQpUaGFuayB5b3UsDQpBZGl0
eWENCj4gDQo+IHYyOiBSZWJhc2UgYW5kIGFkZCB0ZXN0ZWQtYnkgdGFncyBmcm9tIEphbWVzIENs
YXJrLCBMZW8gWWFuIGFuZCBBdGlzaA0KPiAgICBQYXRyYSB3aG8gaGF2ZSB0ZXN0ZWQgb24gUklT
Qy1WIGFuZCBBUk0gQ1BVcywgaW5jbHVkaW5nIHRoZQ0KPiAgICBwcm9ibGVtIGNhc2UgZnJvbSBi
ZWZvcmUuDQo+IA0KPiBJYW4gUm9nZXJzICg0KToNCj4gIHBlcmYgZXZzZWw6IEFkZCBwbXVfbmFt
ZSBoZWxwZXINCj4gIHBlcmYgc3RhdDogRml4IGZpbmRfc3RhdCBmb3IgbWl4ZWQgbGVnYWN5L25v
bi1sZWdhY3kgZXZlbnRzDQo+ICBwZXJmIHJlY29yZDogU2tpcCBkb24ndCBmYWlsIGZvciBldmVu
dHMgdGhhdCBkb24ndCBvcGVuDQo+ICBwZXJmIHBhcnNlLWV2ZW50czogUmVhcHBseSAiUHJlZmVy
IHN5c2ZzL0pTT04gaGFyZHdhcmUgZXZlbnRzIG92ZXINCj4gICAgbGVnYWN5Ig0KPiANCj4gdG9v
bHMvcGVyZi9idWlsdGluLXJlY29yZC5jICAgIHwgMjIgKysrKysrKy0tLQ0KPiB0b29scy9wZXJm
L3V0aWwvZXZzZWwuYyAgICAgICAgfCAxMCArKysrKw0KPiB0b29scy9wZXJmL3V0aWwvZXZzZWwu
aCAgICAgICAgfCAgMSArDQo+IHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuYyB8IDI2ICsr
KysrKysrKy0tLQ0KPiB0b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmwgfCA3NiArKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+IHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVu
dHMueSB8IDYwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiB0b29scy9wZXJmL3V0aWwv
cG11cy5jICAgICAgICAgfCAyMCArKysrKysrLS0NCj4gdG9vbHMvcGVyZi91dGlsL3N0YXQtc2hh
ZG93LmMgIHwgIDMgKy0NCj4gOCBmaWxlcyBjaGFuZ2VkLCAxNDUgaW5zZXJ0aW9ucygrKSwgNzMg
ZGVsZXRpb25zKC0pDQo+IA0KPiAtLSANCj4gMi40Ny4wLjI3Ny5nODgwMDQzMWVlYS1nb29nDQo+
IA0KPiANCg0K

