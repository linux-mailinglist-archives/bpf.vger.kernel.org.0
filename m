Return-Path: <bpf+bounces-54965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA709A766B0
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F3216A84B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071CA211476;
	Mon, 31 Mar 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuA5F6je";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PFf2ek2E"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42F2A1D7;
	Mon, 31 Mar 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427094; cv=fail; b=K58w0QsMj1F6udRYoxt7UwscGf3hpR7RXlvmJfhUBoDafgHAtprCJQMyl5bDUrB5oUn67hCyooVPS5wiZaQlYjzkNftZHSsbbn1NrvwQQT+DXhu73B6bi2y7G6HttnMafSFlylfiTveFzeutpe4cumik680diJahFLVXlkuYsZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427094; c=relaxed/simple;
	bh=6JP8dUt4qbUEENLG0mg3SHTl/z9ozN53GKl7AWYdHA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nqoy1tsNS7ScHOARG875H9yKEIYxK/RGGdpCsxBOP43sDgO+m12q4TlZodmA8wgyy6ZaM/VB+rckYpyXtT/IRlKGfb5Dpz7NgtkUhtMmv8CqnS6J5auM0FvrKlVSgkQwSNxeusTduVjHrjm+YKaMrC1B8mM1p6DzLg3hSFLDZuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VuA5F6je; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PFf2ek2E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBuOhp020315;
	Mon, 31 Mar 2025 13:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n9TY60QHkrSP+BqZVutHItUKApIras55J1yFCzidqKc=; b=
	VuA5F6jet6Bre/q3sXRwZUO6cg9/xtraOtVURVqmAoWrjci3nST5h69j3kE6UI/D
	Avoq3CqxisWh1+X0/dleJzwykcqhmuB4NIt8ts+e11aA8knX5vFBat4G3FQqqN3x
	eNX/vV6gEotNrzjtRlascZ0wPzP5454HQIPv8q7CD0O+pvvNKrIVAyNvAA7Vm0mw
	xd+Q6atPtqwO9aIbN40tKKEwOVrvAkhpLKamfEYPP9s6H+H9Ta/PBcvqIZSYlPfL
	6h8JCSCAS4nE3JLZSpiwfbFlUrC793Ye0m9nduc/6Ttj5KpzYAqwjHdiPg4zNpcP
	pCrshg7LySFSLl9Mb7NuQw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcb704-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:17:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VAsPHL010768;
	Mon, 31 Mar 2025 13:17:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7adw7d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+w98TLYXtwDbpe6AnwtymRiy1t/yKjr0zKAsQyVOdfP4eZk/fzxpwMSnreZFpG4N8zVGhk7TXFKTvnvI7JOLYqjfA8nqAUblAZ8L3uC+Kc6eLEVpMsH6OlzlFKCjrMuf/Itn230oEUkOW9yBsXAK1HR+PRMh8fFVauqVxEia4CCswsCPtnUkdB98CUX8jNF2j/WYKrofEkZfUafD5PtLVHcid+s8+Buj6BUyaBP+i0OddpUvf4wczYqkKLnEMv/U8ck1sYS16zdRxtj565IcyTO3INg0UfCNhnpyDy+9nPW/YyHqrVumszkqKmeeef4b75N4YSoBH+hNkPe7/6w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9TY60QHkrSP+BqZVutHItUKApIras55J1yFCzidqKc=;
 b=RfBh5Vi6hpNi5E66pumXIGsrvK/i49tZQ/dOLAxZjQN61SujSzoQsRo3mPjILkPYNXggBz3Xz28PCGA29OaPcoONnqbUMmr6V2tShwHVNONTAM01oznByATfs47HJfttma6iIaCKzih9CJhmTJcJ9w4uwksEfg16T8WQt8IDItXyeS/iLYV0Dc62BkA1cqzD8GxZXOwiYcKHdZwx8cymXlPTuekI/hA1s5GrrrtXJWL2rb3v9+3Ei39bYQf8/dxfgPk/T+0gZiFKWJchYnzEDjVQKg/bv6+r/9bR2LP8j+/9x43/FXA9RMX5uvVRfzfD3HbEUYlWw/fXc5dxDStmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9TY60QHkrSP+BqZVutHItUKApIras55J1yFCzidqKc=;
 b=PFf2ek2E2Dw98LMJ62RLwRKgJ1QCMVIuyfmRKqpyYA71ChcGsaGp/Jcy+A5NcyGWJE1vChA3wFjelDcVBBEyBdLRIa4U1ezDT9l8FRTavQd/UPAIzektRJqtuUczgee48TaR+0V9H8hLjbwZ21BRnrKIUY90GgIWmSWsqxwl+7Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 13:17:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 13:17:47 +0000
Message-ID: <dbfbb337-ab02-479d-bfe9-4009a53565a2@oracle.com>
Date: Mon, 31 Mar 2025 14:17:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: parallel pahole hangs while building modules from
 nvidia-open-kernel-dkms
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Domenico Andreoli <domenico.andreoli@linux.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <Z-JzFrXaopQCYd6h@localhost>
 <310663685bc9fcc1e16490ca9f08b25825ddea91@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <310663685bc9fcc1e16490ca9f08b25825ddea91@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: b2069342-6cd0-452f-419f-08dd70566e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBzczBGZjM2TjVKeWVueWRJMjdnOXFTaDZsS1FlaTd1SWtMUGlRcHFUYWdC?=
 =?utf-8?B?NG5aOUZpNUVMem81S21KQzJFYTIwYVlOdFN0T1JlQ1BHb1NRTVlSS1V3U0dH?=
 =?utf-8?B?eWpFdkhjYXhhb25wVE5TSzllVDJGUFdHL2pLUC9OR3dYb1RCSXEzSmFwYTBx?=
 =?utf-8?B?UytoZkVXblo5NG5vVW5QaXFBVmNqQnY3V1NBVzNnbVdNTkYwL2VscE5IaTZQ?=
 =?utf-8?B?bVNEbmI4azVhM0tvUDJRK2JYZ0RkWjc2U1JlZi85Qjc5bXJiN2JSbXhLU0tz?=
 =?utf-8?B?RW1SK3RQZ1lOcnRETWNBZGZOem1GR1VnenQ3K0l5TFcrb0VvUjM1UmNEYk4v?=
 =?utf-8?B?MEFIVVpSR0NrWXhFbzc1Mi9TcEJGWjZpbWVxTmVqM0p0UytORVRGaVlUQlBk?=
 =?utf-8?B?d1RZNkp6VXBQbnFnTUp1QUJHeGZ3MUlzUWNVT0cxUFBESU45RGtubS8rTkds?=
 =?utf-8?B?SGlMN2FTd2FmTkZpN3NXaWJ6dG9nQllhUWVaeGRWWVdVQkFwbU5NVG9kVUEx?=
 =?utf-8?B?Tm5nTGtHZUc4TFNwY1ZWR1dHSDUwcDFsdXppczJOZndIRnlJVE5JcFhhKzd6?=
 =?utf-8?B?YjEyc0ZsSWlTcWdGZzNTWW9BS3YvMkhMUlRJT292aDN0aDBNY3RDc2k4U3RP?=
 =?utf-8?B?YmE0VG1lVmQ4WURUN2lLL2xBOVVKYVRubHRIaXFJbkw0Q3RnUlBVUitoV0Ra?=
 =?utf-8?B?anFyaFJ2UFR6NnJYM3ZwcjhwcVpwUHREYzhzamVOK2RjVEY3QVlFUUczaHB0?=
 =?utf-8?B?Y3JFV3ZVQ2Y3V213L1pzcU00UlNoVEhYRHE1RnRWd2lFMXRERHE0bnoyaGlq?=
 =?utf-8?B?U25McVlTb3FoQkRxbzMrNGdVUzR5YXVXN3pYT0pxOGY0K3ZmNmpRbytJNUVH?=
 =?utf-8?B?ejVKOWEwOHR1NVh6ditLVTQ0c3dJdzhGZFMxRHVBdkplRDk3aHhtZEpPd2Rk?=
 =?utf-8?B?dnBGbXRKbTRabmhjay9JRll4RktLc2laWSsvZFJRUTQxbHVNelBLNXRuSGor?=
 =?utf-8?B?TFZVKzJFdThjVmNlZkFYanZUNkZhRHp0cnQ5RzBpWU1HQnAzS2hNY0NMeFk2?=
 =?utf-8?B?WTE3Q1JTSm5jb2I5M21oYWthRDdYKy9XbmJmVFBDT0ZtTGVJNDJORmNEM256?=
 =?utf-8?B?M2Y0eTZ5OFN5QWorUnBUdnVMcVY5QnpmSGZ3TGJOMTh3WVFaLzAzL3FJeXc0?=
 =?utf-8?B?TDAvajN5SWxSZndQZGFpRklScnNVUjJZNk96Wjdia0VCbS9Dam9BbjZ0TWs0?=
 =?utf-8?B?UlFidUVWSWxOQzRHeHB2aUFLL0xLZDVtS08rcFhzaVgrS3JJalAzejZ1cWUx?=
 =?utf-8?B?U1ZySk9nbTErUUNNb3U2eGJVMGU4Q0cvSmphckFJdkVCbU92Y05ETzBUMEVk?=
 =?utf-8?B?VlM0aTVuSVJmcDFteW5Wd0xVSU9Uem1ybTZnd3hRWlIxTkxpVThsbGVTVUQ1?=
 =?utf-8?B?Y29SWGRpZWZPazZBR0tMcG5IWHVPUXVsMDhJYnNhRWoyQlRTY3dvWnVlQnBl?=
 =?utf-8?B?YmE3SlBBR0hWekdDVHNqQVhTNy9IbTRsdnhZdTBOYnJFTWw1V1JCcmxuclJH?=
 =?utf-8?B?RkwyNit6eW5YdlgrUFk4SFJyV29nYm9keUVsU2kzSms5eFArRHkwV3F1ZXdY?=
 =?utf-8?B?V0dyNE1mSXpXM1BGaVg4VVVlaEpLdDZ6dm0wOE9HTmVZTmlLKzZBK1dlUERp?=
 =?utf-8?B?QVhNL3Z4d3E0bEwybWQ0SHpiNVFCTERBc0RXZ096UHMxSHF0amlaZ05hWmdG?=
 =?utf-8?B?QXVGUk9XRzdDSy9FRW5qTG9yVTJ0aVY0emk0UUFzaVg4SHRKbzhTZlJTcGVJ?=
 =?utf-8?B?Z3lNcXgwSXgyM2FoM08yaS9zQzhodE9URnFwK0R0ZDVMME5xK3hMb2xxRC82?=
 =?utf-8?B?VDJuTXRuNEFzUUdUcGg0ZUF5TnZDTnQxb3lCQWZMeDJTUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStJTXdlM1BwWUY4eXZRWFR4bGtBRTdZRVlzckF2VWcvOFdJbUJXNU5RWU44?=
 =?utf-8?B?b1Y0N0dodzlNZmFmTkhXSUxFZGo4Mkw4UkRvaS96SFpscExEVHJJZlliSyto?=
 =?utf-8?B?aWx4OTZFTWpuWTdZL3dCNVc4YVI2R2ZxT3J4cnpCUjR1WU53Q0dTWFB6Ui9r?=
 =?utf-8?B?OEQ5djV5OWg1SmxOR1NOd04wTC9lQ1dlRXJrR3U4V29YTTIyby9ZSlV4SGh0?=
 =?utf-8?B?WDBSblBGUktub1Z6KzV5SENmcklMamdqckhiMGpFNThkRUxHMk1UeDZ3OTBZ?=
 =?utf-8?B?N0FpYXhvcnBML09tcHVNSkZQaUxQUUtMS0RjUEdYY1pQbnpzNWFHRnJyYW81?=
 =?utf-8?B?VGhhQnBpWXU5NkVkakx5NVRUV3dPd0NHaTh5Z0NwbUIvaXZzNTZOVGg5NVpU?=
 =?utf-8?B?U3o4NThhajhoN21RZVNSWWs5Um1tNDB3d2ROMVNiWU8xczlQeHVTdjdoVWt3?=
 =?utf-8?B?MXZmV3ZHSWFPckZrcjBiZU1hVnNiR2plRW9scytvR1NBNzhOUFN0azgwL2VL?=
 =?utf-8?B?dWZ6YVVabnM5ck9mem5TSG5OdWhILzB2bE04NmdHMHJOak1OSUpOd0l0WVlp?=
 =?utf-8?B?RE81NHZaUkdJQ09YVXdPeEU2NmpYeW1iZFBQYW43RDFmalREZnRFMGZSeDEz?=
 =?utf-8?B?UjRDaXhqbllHckI4OTFmUzlXRHFqNUtWRFN0TEJnS0o4b2ErQTJ2L0hxL3Q1?=
 =?utf-8?B?WDZmaEVKd1FYdW4zZHFDeG5reG5HbTlrSEc2WU5qT09UTHV3b21Xalk1LytC?=
 =?utf-8?B?dG0wN29TSk81L1hlYk1YaTVDQTlORW9JMWU2cjJFTHlEYjlZZ01rUU12U1U2?=
 =?utf-8?B?aDFMcjFoODdMOEFibXN6R2lES3lmMFRoajhTa0I5OTk1YUdtZElqcmlvd0My?=
 =?utf-8?B?WFdoTXl2bklsY3V0M2xLbytaNjZ5eUl6RWU1cmd5aDhRQWU0a0VtTnk1QmFT?=
 =?utf-8?B?Ykt1Q2hWaDRVMEFqMElqNXFiWFFSa29KUGw1N0pLR2V6bklHNUtTcUlQcUEx?=
 =?utf-8?B?WEEzZ1lMQVhFRmlxalY5bkpDeHFXek1TK0tyM1ZaRW1YYjNXTmNPUkcxeHZu?=
 =?utf-8?B?RDF3YlJIWDNKL1lycVBjTnF6ckZxZmN1aE1yaFRnTUZ6TUZheHZJODdDQUx5?=
 =?utf-8?B?NWc5YkkyTE93MmxQajUyNVQ2TG1USjdQMmtZRVBLY3hoTVluN0Z5OS80OGR5?=
 =?utf-8?B?SjlRUGE3YytrWmI0YVEyMjVPRWVoallHaWlNc2htcEk2MFpMaU5wZkdEbG9K?=
 =?utf-8?B?Q1VjamJ5OEE4TVM4Q2JRWDM1WTg1UEJIVTRYaFBtY29VS3lwUG91RXgvTzRJ?=
 =?utf-8?B?b3owOGNCaUl2TUk2Z2kwdWNuQUd6MC9sclV6ZnVoZnJhanlQRGxzMklzSWM1?=
 =?utf-8?B?eU5oUHY3ZER4cEptZWtCQzNBWHE4QXhiK1RZVUJhb3c2RXd2UU9IbnNmQ2RO?=
 =?utf-8?B?QmcvRC9EQzdOU2kySTc5Skp5MVUxMlpSMHlmekpkYlpERzRNRW5nQU5hck5O?=
 =?utf-8?B?a2EyMitvTW84ZE4wNi83bnF6aEVKRE9jSkp1TkNuUVBpSWtPQUp6ZnkwY01v?=
 =?utf-8?B?Ny9GRXVpaG16VXovT0Y2N0lQUUUvTTA2MWJ2NVQyVm1vczFWSjNONHgxMVNM?=
 =?utf-8?B?cTk4VFJ5WTBjMlR6aEpMSEZSYTVVM0hPUXVyZENLN3ZHOFlMd0RYUE5MZGlW?=
 =?utf-8?B?anBTaFdzNnpnM0JCUTRTNnAwYnduNmY5TEQ3RHRwSGY5UDJDenpIU1Roa2pv?=
 =?utf-8?B?Zm1OOVB3SUhoMm1GVytGWVNOdGFxMU1ZV1VMV2xJQlhKdGFFdzZQUlNJUUoz?=
 =?utf-8?B?L0MrK3Ava2RINTdabDJMM0JJK0h5ZzVLenYycUtiT3p0dFF2dE9iYTFIWnNW?=
 =?utf-8?B?OTRCTWdwaW5maC93dmtWYUJHOWQ4dUkwWVRMNko2VjNzcnFZOTZvaVFiWUhu?=
 =?utf-8?B?UTYxZnJvR0ZoeEZ6SXJaRDEwclM1RzdJQWpmc2hhZytROGR5UEV2c1JrOHJI?=
 =?utf-8?B?Nnh1OEpOMmlqM0ZSQlpjZWVIVnBiWG9mSjBIa0lHTHpoRSszdGtkczZMK0tK?=
 =?utf-8?B?TGVUTkprbERZQkQ4TWMwNVZLSzErWGhaYUlMQ082VElXRE1iUy95SFozdDlK?=
 =?utf-8?B?aDU1ckhTcFczdDQ3b0xIcnhBMnh1S1prdDQzeUF6M3FJQUNlZ0ZsbEh2ZXQy?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vB3a+PDtWbYKnWhvh8fhjAIqAFZP4lNfRSdhPvNDvUqlFsppwW6PP4GN8q0KJfBGBh8waT7NLVNpYa6MEO59hslcB/pXO3XkQt4HMV+50x2i2R3GJKqMow5rKUwmsIdciOEJNAlDlllUwWCVo9TlXxYlhSFAxokwaJ3rcvjtquetNOuZHV7ih9R6EMgj7X6cwvQZec8joCIU15F/xWXMSzJES57Mx+FsoHpKMUxpTqut6MLMdyCdCjio+nWwrR4AR4KFjqfud4Ur8DMyvsrGsydXpW1j4ukSE09SAazLb7Z7b9yMFYqbDiEYhoWunOHKJc7zolQmJq7M2uz6qTdF34b6wBm6JlFcIJlREavqVSzVSoQCZNmyecNq4KoBXFBCG7yUB5q5j479BtmHCHMi9xHHD7AtvhMs0qByZEjuhhisL8u7FDP3sHC6EjcUGJlmoP8mYcGS168qKmZ/gHV79pc/1ssrEHOMoGdjiYjJreX02aFGOX5TmWgKGgumFYFGuPNL4poolQueU2OR+zkQ40SVDuhMmeV0aYMx4eoqz89sZ+8d20G9F/Vh119SZGA4bNzJOFm0fbjL8LEcwJJMwiJB04WNIWpSn8jd8koYHWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2069342-6cd0-452f-419f-08dd70566e31
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 13:17:47.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZRxZys6UDz1ccleFlQr3tZAqNvzU/ur92reapATBxpLlm3nDXSDUjkO27IIzoEAOYdoxORKS2nDe+vy6Vtr/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310094
X-Proofpoint-GUID: BJXeG9xeCtrvAZr3Ncmk5rxbU9MhI1XF
X-Proofpoint-ORIG-GUID: BJXeG9xeCtrvAZr3Ncmk5rxbU9MhI1XF

On 28/03/2025 20:25, Ihor Solodrai wrote:
> On 3/25/25 2:10 AM, Domenico Andreoli wrote:
>> Hi,
>>
>>   This a forward of Debian bug report [0] where you can find more
>> details. At [1] and [2] you can get the kernel and module to reproduce.
>> I could reproduce on both amd64 and arm64 using pahole 1.29.
>>
>> This is marked as serious severity because it makes the autobuilder hang
>> as well [3].
>>
>> Could you please help?
>>
>> Regards,
>> Domenico
>>
>>
>> The command to succeed:
>>
>> This simplified (sequential) command succeeds:
>>
>> cp nvidia-modeset.base.ko nvidia-modeset.ko
>> LLVM_OBJCOPY="x86_64-linux-gnu-objcopy" pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base vmlinux nvidia-modeset.ko -j1
>> echo $?
>>
>> producing this output:
>> ===== 8< =====
>> dwarf_expr: unhandled 0x12 DW_OP_ operation
>> Unsupported DW_TAG_reference_type(0x10): type: 0x28172
> 
> Domenico, Alan, Arnaldo,
> 
> I was able to reproduce this error using the input files provided by
> Domenico [1][2].
> 
>     ./build/pahole -J --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --btf_features=distilled_base --btf_base debian-repro/vmlinux debian-repro/nvidia-modeset.base.ko -j1
>     dwarf_expr: unhandled 0x12 DW_OP_ operation
>     Unsupported DW_TAG_reference_type(0x10): type: 0x28172
>     Error while encoding BTF.
>     libbpf: failed to find '.BTF' ELF section in debian-repro/nvidia-modeset.base.ko
>     pahole: debian-repro/nvidia-modeset.base.ko: Invalid argument
> 
> 
> The unhandled tag points to src/common/displayport/src/dp_auxretry.cpp
> [3] of nvidia-modeset.base.ko
> 
> Now, as far as I know, BTF can't represent C++-style references
> directly (maybe indirectly with tags?).
> 
> According to the code, pahole simply bails out in case it encounters
> `DW_TAG_reference_type` during BTF encoding. So the question is why
> BTF generation is even attempted for a module written in C++? It does
> not appear to be a supported use-case.
> 
> Please correct me if I'm wrong about this.
> 
> Alan, sorry for jumping into this uninvited. I trust you'll take over
> from here. Thanks!
> 
> I've sent a patch with a fix for the hanging [4].
>

Thanks for the update; I'll test the fix shortly and I can reproduce
this failure at my end now too. For me, adding --lang_excude=c++11
resolves the issue and BTF encoding is successful, i.e. the following:


pahole -J
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
--btf_features=distilled_base --lang_exclude=rust,c++11 --btf_base
vmlinux nvidia-modeset.base.ko


...works. I see though there is some support in pahole for C++
constructs, so we should figure out what we can/should support too. In
this particular case, the reference types and rvalue reference types all
appear to be toplevel DWARF tags, e.g.

 <1></>: Abbrev Number: 16 (DW_TAG_reference_type)
    <2b6053>   DW_AT_byte_size   : 8
    <2b6053>   DW_AT_type        : <0x2b5805>

...refers to a const type:

 <2><2b5805>: Abbrev Number: 10 (DW_TAG_const_type)
    <2b5806>   DW_AT_type        : <0x2b561f>


...which in turn refers to a buffer:

 <2><2b561f>: Abbrev Number: 43 (DW_TAG_class_type)
    <2b5620>   DW_AT_name        : (indirect string, offset: 0x20bf79):
Buffer
    <2b5624>   DW_AT_byte_size   : 24
    <2b5625>   DW_AT_decl_file   : 10
    <2b5626>   DW_AT_decl_line   : 38
    <2b5627>   DW_AT_decl_column : 11
    <2b5627>   DW_AT_sibling     : <0x2b5805>


I tried doing the simple thing and skipping them for BTF encoding and we
end up falling over during deduplication, so that tells us they are
getting swept up into the type hierarchy.

Further investigation shows the DW_TAG_subprogram associated with Buffer
refers to the above reference type as a formal parameter.

I think these are class constructors, possibly for

https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/common/displayport/inc/dp_buffer.h

so

Buffer(const Buffer & other);

The & connotes a reference type in C++ I think (&& is a rvalue reference
type, which we'd need to handle too)..


> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=vmlinux.zst;msg=19
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1100503;filename=nvidia-modeset.base.ko.zst;msg=12
> [3] https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/common/displayport/src/dp_auxretry.cpp
> [4] https://lore.kernel.org/bpf/20250328174003.3945581-1-ihor.solodrai@linux.dev/
> 
>> Error while encoding BTF.
>> 0
>> ===== >8 =====
>>
>> [...]
> 


