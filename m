Return-Path: <bpf+bounces-38704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5B968878
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B814B214AB
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C3119C57E;
	Mon,  2 Sep 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btQ8trnx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j9RtxaTN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D485205E25;
	Mon,  2 Sep 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282436; cv=fail; b=uAl/ct7Yr/tGFYOuAl4kEY9mkG6H4VT3tfb67mhcM780rkG5NYOYiKG7eB80KIxKCgxVLdMNm1/GL5IWw5/bV1PXn7TCVuYqMuqtIlAtomeYIn3Ay/7hRyD41Zp2iyDcb6HrG+XPLnHIpLA76xpuWVs2dCXQur8mvqNndqlRkHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282436; c=relaxed/simple;
	bh=zwuX6087MG8blMukMf0jsrBmxHn0yYb8zcR07wC/ZvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt1VVyBZB5bmr5owjiLzSMuRrVJgI2ShMq+TZgKCu133/xQHGCKY0QFoq1kqMKjokzjFGVmpP1CRdKUlEqDhXRezWWacYGXYJyizsscS1WifrrPxfxOWXyyJJTHA2Vwh+47l6zztmmRwA/lZxAMW0Lbtd/ueEfJduwWmMy9tomc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btQ8trnx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j9RtxaTN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482Cc7Wr010399;
	Mon, 2 Sep 2024 13:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=YZZKTxEFtf3TSd0B5mitYpYKyQnrHuqyOCgGhxPBb+w=; b=
	btQ8trnxIzl5B+JdT+ur0Ugq0L1VJBx9fEsG1K3YRllJFnaQ9ryckxYpVWNuhe4o
	RX7+baJMsQ/t0ax/PCl/iNUmFUKZ1SWn5y4PINQmS007L5EwdawhOA5SzQFPRIxF
	9YChfIhIz6GDo/iIbB8VY2Zj5Ay/FzywxzYXo/dCBaPeUQUwkWRCKHYz3Hv7de9w
	xGYZN+d+B0i1LjYbitGmCUVX33lHVfTrvdEHiO44MlETZbdx1Lhj4FtQEIAPL53Q
	mpcLOwhbdtVv5/qQDNPjcooaySpdemqtF6WMMjL4k5RABzhbgdrn3Z0K5ru8NWRV
	uQC7ms7a9ohxu7VIkNkOng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41d9qu0fxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 13:06:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482BdO4J040080;
	Mon, 2 Sep 2024 13:06:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm7p6ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 13:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoJ2Sj3UI8m8yUePSXnqfbu2v5ovZysVTyDufHolAtzgGvrWSOk76tjyFcEcE2ylgWLmaK50mQ77hTU2lXdNgAkcEsfKKq+v0Sbcz9zq+rUtRHapRoXHdEEDoN8oJXGLX+C3zGCwOK41sfW/MfJzKOo1Lbq66R5lz7eB0+7ZfhrFKIcKhEQvyO4chB8NB4Yv5e0AS0PUx62AJ8N2Q1H8lXEINZFd/mN5/ymGDnwZy+9KZAH+SrUcwbna1no73k1n4xVCZ/qQ9RkkpNceKNKT8Q0+T36TrjZWZEAJVqmF2zOQFujCAbjWrGMSHMzA1Q+IGLkw6KtpiPi3v7Vth+9pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZZKTxEFtf3TSd0B5mitYpYKyQnrHuqyOCgGhxPBb+w=;
 b=OWADcI+XFMH6c3OdvfuC4xU25ZeQmXuIfpiKS+9OY5bnQFMqy+F38JD5zRMw7rc+6djD5KhMVgTEOR1XjPgefwoU5DhR93uztYwXiC5j2HU9AeZ3oCGf3lF/Suqm4kjGGRjpt9w6zRdaRBRXbrFyzKSabHih4HrW/MAxRW1xIt3rFnRvSbfoErMR/S13cv+RRmOi4KqH+Z7zCYwTk3OsBBB/r/LFYEhdPYjlkA4I7D6nagikjvz4aDrNMt2NetFOORpsQPP7gLWGx1m1ZOjJHJqfrq8fx7NPStXQ+hJSBkVNAZcW3yvEFsHcdfiRN+DjeX6hb/gU+V89H/x2es00Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZZKTxEFtf3TSd0B5mitYpYKyQnrHuqyOCgGhxPBb+w=;
 b=j9RtxaTNcNsXtc326pCxWk28HI619yT9UFElmKsjarc58IrZtzdQ7rbZxZq4nLtr60sZdYqyvX5LJPZfs3yVJh9Z2LVwfMf+xbV+CY25hUdiQnZYWtpxEhoS3nNBLzcf/RrmGL7wZ5mYIomUWWmwnJVNVnyHd844ApCecvY50bU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 13:06:56 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:06:55 +0000
Message-ID: <b1c8d88f-cd36-4ab9-ac2c-26fb85d0a63c@oracle.com>
Date: Mon, 2 Sep 2024 14:06:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Song Liu <songliubraving@meta.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
 <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
 <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
 <CAEf4BzbykuVKzXa1z+6icECPTTh2bU4JFezDmA+4-S_izAUhsA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbykuVKzXa1z+6icECPTTh2bU4JFezDmA+4-S_izAUhsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d071404-9ce9-4ab5-66d3-08dccb501ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUJRZU05OU5jNmpGblVzblVoSWNwR1F0Sk1tTUlqZlR0ZzVUUGMzTG1Bb0s4?=
 =?utf-8?B?UWozS2hRTlBKL3NoWU92RTNTcXM5cU03WkwxcWxCRnFjMVZ1T0NaSjY5Zzhu?=
 =?utf-8?B?NUh3N1BjTHl4bDRoMFpUY295QkVmUkpoWkgzaWVRNlI5Vkg1NEo3eGtMNVB4?=
 =?utf-8?B?M0VjeFltYUxBaVRIdllZZUg1d3Z6UkNuY3RiTXdIWVRGOU5TbzF4ZkhtYmdC?=
 =?utf-8?B?cktkdzRsZzIrRlBSUU5icmNreXdjZHdTZTNpeVNXSGV0eW1RMjA0dUQ0SUJQ?=
 =?utf-8?B?aHp1Z3JESnB6WDN5L1FTblJhamtjblQ0Z3JqWlJNLzVSSFhQNGtOVE1tS0Ev?=
 =?utf-8?B?R3paSnFBa0ZNZ2Z4M3duQmZ0U1R5V3MzNHFiN25TQ3Zqb0tvOVNkS1JTN2VK?=
 =?utf-8?B?cndySldaSnRhcjRpSmdQaVd3SmdINUFJL2hyZlJGRVVKU0czcmZ6aGJQQUZj?=
 =?utf-8?B?eHJvczZEYllJenlRVE0vNSs1STlZZm9KNjE5R0pZWGN1SElxaFIwZFZsVmlX?=
 =?utf-8?B?RTViNHdhNDFOUVI2eVM1ZG5HbGhrdWpzNjNoL2ZzeEFJRS8yQ1hic3dtRHpQ?=
 =?utf-8?B?Ung2aUtkd3d3Lys4SzJMS0VYSnBaeFhDb0x4bnNWZWR0TmpSYXBvK2Q1SVRq?=
 =?utf-8?B?SlZ6dWN2OXNuOVpHd3VKeExNUnRxd3g5anoxUzJicU5mcmN2Z3lCWGp3WHYx?=
 =?utf-8?B?UUtIMjJIc2t2bVY3a3pZZ1kzK2x0NFpEbllRc09RNWlvdnp4T3V6TWhYVTFB?=
 =?utf-8?B?N3FzN0Y4Vm8xNVUvVWZPSjJ3RnBRNWU0ZzVSdnBLamdNU3hZTk1QQTgxUmRr?=
 =?utf-8?B?c3h3c01qUWtLaEs5NmgyQ3JackltdDBtWkRkWVlPNEJjZE1vbVZzZlJaaFdt?=
 =?utf-8?B?L2dkaUk0NDJMcldiTE1lSXpuc09aSTdDVDFFQThNZDgzVGUwVDI3R05NbnBC?=
 =?utf-8?B?a2RvMXFMWE1lY2lGSW5tZE1ZVHFFSDZZalN5QW5UWDZCRE9yUjVlVTdUaWda?=
 =?utf-8?B?Z3FNV3NIUTZ6YXdybGdjRlpWMVpucHMzL3c4WVM0TTlxcEFmL1M1bjE5ZGww?=
 =?utf-8?B?bHFldHBpMFdNLzJhSTlaU2t0NGErSHIvdzRITXFRajBwOXJMaCtya2VlOGIy?=
 =?utf-8?B?U3ZremNGRzRFbmJiM2xYK0doYmExR1FpUG8xeFhmejNQY0g3NVlTUFRMWHBv?=
 =?utf-8?B?YXlsUzBTZ1ZBMnowTjNWTThJSEJXa2dFQjVVSGNubVlHVWF1Q0dPbWo2czNp?=
 =?utf-8?B?dXFBMnV6Q2ZmQlh5OCtVaFprbFAwWnNpVEtLQzlOWDlkWm5MS3F6RGdVSWFW?=
 =?utf-8?B?VEtKTm5ZVEhORkk2NlRLQlp3bUtWWGdubHhtWXBPTTR2Mk5ybS9tVVNNTUly?=
 =?utf-8?B?NXRkZ0FmY1RiOHRORmFaUHFtYjFnNEFYVGkzWk14YStkV0ZxZmdabnFSeFF5?=
 =?utf-8?B?UGo1aWpreEUrUCtmbVFOSWxCWC9OMmt2bm5RSzZSOUEzWEhpRDdldHBscmty?=
 =?utf-8?B?NmxZNXBaWWQ3ZmVUTGZFMTRDdlUwVjg1SmtFQlZ2cVhvOXM2cEJHZ0I1THkz?=
 =?utf-8?B?RWg0V2s0cnpiRjJuYU1nY0Zvc2h3cFdoZlErWXY2M3QxdzV2RHZFRWQzdVl1?=
 =?utf-8?B?OHBZZnk1eVdxK3c0S2pMVEtTWnZZSmJWekRhRlVTNE5ScmJuSzlzRUc4eXBZ?=
 =?utf-8?B?aHZ5ZWRHSWVBbTB0Tk5TMlJ0UU9aWEdJd1ZMZ2lPWjhRem1xcjFjTTB4QmZZ?=
 =?utf-8?B?V04yNXFpNFZWaGdQYndHWW02ZlVZSnQ3MUd6L3lOUjByeGdrSTZVTUtxVnZV?=
 =?utf-8?Q?+SVbrEISm6QfXwa7lr8gZ8QtqE9A7PGc/E3k8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXlOMVVzZFB2VGV0amI3OXFadVZYTmc3d3lJVTN6Z3V6b0toTGxtNmRYWEVn?=
 =?utf-8?B?Z0lFZWNQeXVtdko2dzh0Z3NKYjFsMllKV1RnVjB5a1dVeFpmMHdqM2xUc214?=
 =?utf-8?B?bUIxYWljMHRmbnJNM2svN2JYeVFLT2xkMElzNWJOVXFoajJwMTkyY0hnV3dN?=
 =?utf-8?B?OGErUmF6NGlFcitON0pBZEg5VlZ1c0lldE55MTlBdmxERys5UTI3YW53R05D?=
 =?utf-8?B?R0gzRU82K09kekoyWXdscXYxQWp4Z09UbmxrK0dseWJ4YlpURE9Vb09MekJr?=
 =?utf-8?B?azZMVU42Z09INnQwSCtZZkhJUndJaU0zZGplQ0pHTkpPVGxycWtQWi9UZ1gv?=
 =?utf-8?B?WDFtcjRacllvU2RPbXRmdXhreXBuNEpwRXhJL3oydlFrQjNTTGtKTjRQVlpv?=
 =?utf-8?B?Wk45dTdyVWJQZkxKUTBBalFOeWNyZ2JFT0wzUkp1UjNDZ1VCU0Q4RXJKajM4?=
 =?utf-8?B?bTBsVXlZVkV3VDV4TkRpMlFhWXNCd0VlTnNqYzFhTEZDWC8vQTJLczJXMW9T?=
 =?utf-8?B?dFdiOVJXUzlmNWtVc1BEWll4MkJFeFZ4Q3lnSlpuQWQveG0vMndXZm5ZY1FB?=
 =?utf-8?B?UjE2cVk1OExLUEo3L1BFV3c0a0FqOHpBUDdGV3hGZFYxQUs3YTBBcldQOHpL?=
 =?utf-8?B?MS9mZ00vcmkzSDRrVWJ4VldOYjB4WkdHQlVoREdGVzlFQWlHdGNpZWtIdVV0?=
 =?utf-8?B?YlFLZk54K1Qzai9qa21XTVVHa21ESERaWDM4TWFZOXBTbnR0Yi9nMk5KUHVa?=
 =?utf-8?B?NUNUcThLRDFJVFFEa2RpVmxDRThOVUZuSW04d2R6WU05QnI5RmttTzU1WXgy?=
 =?utf-8?B?MUZkNVo5RGVNUVFvamVnS09WdmRzcStBdmlXbjk0SjB3bitKUU9uamFnVXhw?=
 =?utf-8?B?YmVGT1VzekFzWlIyaWFSUXhMQnFMbVJvNmgrcUI5UTc1NTBZSmxrK3RJVVQw?=
 =?utf-8?B?Qm81TVR1ZG5Udmx1eDQxRGZZR0gxS1FzQitUb2pTd2s4Sis1N1pyRjFidnRx?=
 =?utf-8?B?T2pJZHBaUU11U3FpSFVFWDRBdDhrMTRaQjMwQVpFL0Ria3FjKzhTbURoaTdZ?=
 =?utf-8?B?dFd5dW9SRFpWOXlBRGNlVmo3QkhGSUhSMGZ3ci82cjA4SG42QVpNb2xucXp2?=
 =?utf-8?B?MGJYQlRXSE0ybGRiR3dYbm9mbGdVOUZPV3NFeHMxaHZFY0c3L05Gd3MzVTlJ?=
 =?utf-8?B?allQRUNoZlNjL2JtMVBvTU1OalYrWENSSXoxZStDNHQzL1BpZXNvWVJyU3pu?=
 =?utf-8?B?OWdudlNJcDF4THh3ZDZxVlR4UDVNS1l3aUJld2YxWXVMRk9rWlo0aHBVM3kw?=
 =?utf-8?B?elZYdC8wS2xUbnMxU0xLdlRHdlZqeEV6NVVEV2RYMWFsZGRwbUh5eXBMSmxU?=
 =?utf-8?B?WVRlbG9YY1k3STFnOURWaFpSUTlyUElhU2xUejZ1TGh1MWNCWmR3ZG4wdko4?=
 =?utf-8?B?bTNFV3dUM0xXU3VidkNPV1U5SnlCQ1hQendxeEUrMkg3MXlhN1ptNzBXczhK?=
 =?utf-8?B?R09OT29jNktKbE9QKzhCdXlPcXZ3RklVbzJCVkQvNEJmU0dMRjBSTFdIa1hs?=
 =?utf-8?B?TForMnhMd3dZVzZNRStJdTg4OXEyWWRpK3JmYlR6UklhQVRqQzIxVklkUmxY?=
 =?utf-8?B?ZWk3WHZLenNGWlk0UmdQZ3l3TnJXekdWSEI1SDBKMFdMcE9aQkV3VEN6UEI1?=
 =?utf-8?B?WkJxdjhCcW0rL0VXQU1JUlhDcHNQdHNQTW8zNGtYcFQ2V0VMQzl0L3VHYUd4?=
 =?utf-8?B?OS84OWZjTStiMWp1cVFyc0dxNUd5aUZkcjNKbnZ5WFhhZ1QreDRUK2RKVDQ2?=
 =?utf-8?B?REk0TFRUTmcrWEFzZE1GUHBxUTJ6ZStZYnNyYWFLWDVZYzFYUTg2V1N0b3Av?=
 =?utf-8?B?ZjdkalJuTll2akkxZGJVOXNPRG5lNkdSNzA5R0FYQWs4UG4vSFlJT21ybm9v?=
 =?utf-8?B?aFJJcTJuSVZZcG1GTGV1c0tiNHFmVmNMRFArWktWYjEyYThIQkNkSkt0c1la?=
 =?utf-8?B?Nm85MzBwTjh1Wkc3ajJ4SVg3a3MzemVlV0owK3NnWVNiTjBhTEFubGw4SE9q?=
 =?utf-8?B?eUIrcHpiKzhCc1UvZVR5ajhYYUUvM1N3TFhQTDN4WHJHRkJOVGZaMkQ0VXpH?=
 =?utf-8?B?bTUxeHN5T0lEY3lzWkVGd2FweGg5WjhueDN0eDdGU1VhTEdjTDFHUUpyR245?=
 =?utf-8?Q?uEN3CSys4SvSD2oRaS1RozE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2FUryAoad5zSMwFuPilMtDuxJdNGbNvzx2vs+qbZqrT9pJ15cMxrxSImfY3l1cKR8BtfZ0zl6NK791IOyxZoP6TATkHVBIV5HZVT3/BZgr9YLQzjyb15Y6eWH5gd+z5Rub4DFvrkWSpmWcoNufxdfNFJk/F9SHEdQSoMw/lErfcUxnSy38IE+u0sstV3kEamIKr+MfJzLdEb66ng2p/P6SpLi68En8Ms+IYhPqMZg0bZkxlhLE/kgdY3lddSjPAhOwQex/m2sxJkPvxuUwHmgQb8/AErcoDPZ5BcLzdIhqf2GZDgpqDsRTASqcuKjDdrvPAPahmXvbGy8XFtIvJx1x739O9BGUSR9KybGIBZFZg3VUPUXK5KIlfgIqhPCGPX7TcUf74bg/CV67WAdSqVJBcdPvF4LHlnQCrlMQTfv/BymIpcCob10m/Hg0LkuYQQv7hL58L0I0nzPTL0UKWv/cCGvYIShQoypr5bnAgvB2M9FRyhsm1NxWBsrGPwVF7DPwPDKTfDv+UZnvT1zHlbZYlXqbgacJfr2uKJNfzpJC+wdpH3b4ZJMAW6vDl2bK5VHKipGLoLzDFnE0qSl/6iom63m7w/FD2oa3/A/IlRpWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d071404-9ce9-4ab5-66d3-08dccb501ee7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:06:55.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBwiTp2DAMa5sj64tEE7cfUen/Rm339efoP2fszlNn73uIgWboUTDsM19GAl2oe+uMaFdLfsTRezozImeL2axQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_03,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020103
X-Proofpoint-GUID: fedCnqj1W_s5PhMKwsIxxErAmERvnfTJ
X-Proofpoint-ORIG-GUID: fedCnqj1W_s5PhMKwsIxxErAmERvnfTJ

On 31/08/2024 00:30, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 3:34 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 30/08/2024 23:20, Andrii Nakryiko wrote:
>>> On Fri, Aug 30, 2024 at 1:49 PM Arnaldo Carvalho de Melo
>>> <acme@kernel.org> wrote:
>>>>
>>>> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
>>>>> On Fri, Aug 30, 2024 at 6:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>>> On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
>>>>>>> Arnaldo: apologies but I think we'll either need to back out the
>>>>>>> distilled stuff for 1.28 or have a new libbpf resync that captures the
>>>>>>> fixes for endian issues once they land. Let me know what works best for
>>>>>>> you. Thanks!
>>>>>>
>>>>>> It was useful, we got it tested more widely and caught this one.
>>>>>>
>>>>>> Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
>>>>>> do a resying in pahole and then release 1.28?
>>>>>
>>>>> Did you mean 1.4.6? We haven't released v1.5 just yet.
>>>>>
>>>>> But yes, I'm going to cut a new set of bugfix releases to libbpf
>>>>> anyways, there is one more skeleton-related fix I have to backport.
>>>>>
>>>>> So I'll try to review, land, and backport the fix ASAP.
>>>>
>>>> Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, I
>>>> think he meant what is to become 1.5.0, so even better, I think its just
>>>> a matter of updating the submodule sha:
>>>>
>>>> ⬢[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd647312718e7f
>>>> commit b6def578aa4a631f870568e13bfd647312718e7f
>>>> Author: Alan Maguire <alan.maguire@oracle.com>
>>>> Date:   Mon Jul 29 12:13:16 2024 +0100
>>>>
>>>>     pahole: Sync with libbpf-1.5
>>>>
>>>>     This will pull in BTF support for distilled base BTF.
>>>>
>>>>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>     Cc: Alexei Starovoitov <ast@kernel.org>
>>>>     Cc: Andrii Nakryiko <andrii@kernel.org>
>>>>     Cc: Eduard Zingerman <eddyz87@gmail.com>
>>>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>>>     Cc: bpf@vger.kernel.org
>>>>     Cc: dwarves@vger.kernel.org
>>>>     Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.maguire@oracle.com
>>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>
>>>> diff --git a/lib/bpf b/lib/bpf
>>>> index 6597330c45d18538..686f600bca59e107 160000
>>>> --- a/lib/bpf
>>>> +++ b/lib/bpf
>>>> @@ -1 +1 @@
>>>> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
>>>> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
>>>> ⬢[acme@toolbox pahole]$
>>>>
>>>> Right?
>>>
>>> Yes, and I'm doing another Github sync today.
>>>
>>> Separate question, I think pahole supports the shared library version
>>> of libbpf, as an option, is that right? How do you guys handle missing
>>> APIs for distilled BTF in such a case?
>>>
>>
>> Good question - at present the distill-related code is conditionally
>> compiled if LIBBPF_MAJOR_VERSION >=1 and LIBBF_MINOR_VERSION >= 5; so if
>> an older shared library libbpf+headers is used, the btf_feature is
>> simply ignored as if we didn't know about it. See [1] for the relevant
>> code in btf_encoder.c. This problem doesn't arise if we're using the
>> synced libbpf.
> 
> Is it possible to compile against newer libbpf headers, but run with
> older shared library?
>

It would be possible alright; the most important case is package build
time versus package install time. IIRC rpmbuild will auto-detect the
version dependency (as long as libbpf is packaged too I think). We
probably don't want an explicit libbpf "Requires:" dependency in the
dwarves spec file since that wouldn't be needed for the static libbpf
library case.

> BTW, I've just synced the latest libbpf sources to Github ([0]), feel
> free to pull the latest submodule reference.
> 
>   [0] https://github.com/libbpf/libbpf/pull/848
> 

Great, thanks! I'll send a patch to update the sha from the dwarves side.

Alan

