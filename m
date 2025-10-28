Return-Path: <bpf+bounces-72617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058DC1673B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A4FBB99
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4034DB49;
	Tue, 28 Oct 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpPSE6Pw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQ9cAMco"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39934DB4F;
	Tue, 28 Oct 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675717; cv=fail; b=HNg/lUDOWAlQxWUXP0ufHl0+FBC2/K5Xs2awyDMI/4O0uC7G/adOJFRGSDNLzZ4fnJVvIFyUm5QhgRp3xSGm0g6P/uyLiCO5suNvQu8GOv6BYSNxcXiUmdys0Pn4Sw7rWGTGVJ99Hltjw2V/lhdy0RPXHjlkGWv1cbssoFVNhr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675717; c=relaxed/simple;
	bh=7UlMUuqNwTdR+Vtg6rVtO2bI118H5zVK1c09+9UL6Go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDq7TeA/4ePVwr2de3/oYoqZc/bXUMtr9I9xN7LIgd/HqA7C6RcOIra8+iHvlCuYGQuRkQLmHi/dbYc7diSFTfRyL29BaPzToQONPtkty9q2kgNPM81F544b527P9Vz4Dep0ge4lIgOUPKQf8okYJ5qmTRf3oGRbOYvpi6HeSFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dpPSE6Pw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQ9cAMco; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SH44mX022540;
	Tue, 28 Oct 2025 18:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aMmKISkXg/5LZZhwI58hkYQxdoz0fIslI7kemtqviS8=; b=
	dpPSE6PwgwpNtoMV0m4n/ZsSaeVuOOJ5YF+uVTX3qXfYFgjxgTkqwuogKiRq9Kou
	Fgd+0eeKjuY54c41ce7sX5Eu6l61zMkYmJd1JN1ToK1tS47JLx+ayXzJbk6GMV+e
	jUFD7wRc5NGrbU2BbeWD+Qb7H2TfZPS9yi2+Di0mNYLSgKITL6Q6ULJVXUMO8WqY
	w2WmwjDkT8wHLkL2VjDskIwJnxxkCVLyYXsMBKQSKhP99dXI4DYZyEcBeFWR8lQd
	TMx8amSoHw17wMvqnKJSUMU0iWhPjAuh/lpdtyE1qMlaL/pzeapyx0y4Ui19gEZ6
	AoxzBDNMkJmV46UmczCwhg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232uvc5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SIFHnw018715;
	Tue, 28 Oct 2025 18:21:28 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0fty0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KugC9i0mSBegeadyi3x56vW0sLCgbwRlKT5Hrle4ppUxL3ekCfBPjOxCg3YfFQJC01/Fg8j6oASO+OwFFQhMFN3kKitSWoSU6g94Yi8DxRWHGCIPyJ07EPTjc16wdcrbAPYhy0fQPK2tJ9COmIkziB3uHGqmDOsIhw+/vg2Myvw4Jyp5MCXXHFa97G1Kyp0RS+x7T9BjAbQDNvqMmZHWAeE84wZYu2ERTRwEmj8ZsV0erLv4eHnTlZYFRmZcUaSrEx715VXDKE3tSad4PNAkOm+7/m4Qkk68QBn0wu56UAbm84vtmgG3WE8T1ZV3h+wlIBrGqcpbdnGYbfN+TQMOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMmKISkXg/5LZZhwI58hkYQxdoz0fIslI7kemtqviS8=;
 b=B69oTTor8eRdTNfGgf0AFn/4z0hZQkd0A4cOezPjNbB509IMQle4Byii5RierFNq2ragCsUPKcBy4iKrSZNPJC3cc87MX4kKNQ1Z0zacqyIk0MDjCL+iFJOZlfuaU5AQ0IdAchkOZ7+GAJWFp0xztUouUhadmJV1sPK/3flNMmxjZap213tso01wmPi30kLVv9sFQRJHr+mMjnJHUQTkqbi7DkN4lTgjc2Qypr0NO50ffkzJpeFJMdZMDGNBCraWNyHqac7ZO2/0un9tI2156lTyRj+afwcKtMrxlvm9tGu8GXKA8avJWSNevROPIrnjeeFZXnbhyP4Ti8okdk/2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMmKISkXg/5LZZhwI58hkYQxdoz0fIslI7kemtqviS8=;
 b=mQ9cAMcoKkzQ5LRadw5b7BWW3LI9rqqz1YOYx9vbn21zA5COIX6gzRGUlT2lU6AjNsEyykr8dEKu9HLn9kSR8MJiNyT4H1fnSXzmKXwMdwIB02ZtZ3WPWbVot6mVEJ5M7UL2TG79X5YnvwzRHQOYke3N/zq3IsRviLRL46s2iuc=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by IA3PR10MB8682.namprd10.prod.outlook.com (2603:10b6:208:573::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:21:25 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 18:21:25 +0000
Message-ID: <5f7583bd-2b62-46a3-b500-35c33111accb@oracle.com>
Date: Tue, 28 Oct 2025 18:21:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Ignore the modules that failed to load
 BTF object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Bixuan Cui <cuibixuan@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20251028135732.6489-1-cuibixuan@vivo.com>
 <CAEf4Bzbp2FYvTVz6SStj_p_ok+LLeXEAxcUiCkyWRf3wyjwi_Q@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzbp2FYvTVz6SStj_p_ok+LLeXEAxcUiCkyWRf3wyjwi_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|IA3PR10MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afd8152-1e4b-453d-5506-08de164ecdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnVNbkFTVlZSaHc3TXlneXVjcE95R2JXSitnY0FBRFJlTUx0MkJodUdrRy9R?=
 =?utf-8?B?V1ZkaGtJazBHa0xZdTU5dWNtcXdLUDI3VkxxdDBPYWNDbG1aRkd6WkVNSlBU?=
 =?utf-8?B?ZkFjcWl4SHNxVjB2ck1tTEwvcFFZWkc0aVlYNnQvNC9iVVZ6ZlNGWksxTitq?=
 =?utf-8?B?YmNEN1ZsU1NzdFZqZ3VFK25RanVoTXVRYUNBVWoyZmVRUjV4T0phcm9mME5t?=
 =?utf-8?B?eXFHaDVaUEs3dmdtMEpvMWUxbTNBODlkcWtNSFBmYURqYnVsdXhqVTFMV2kz?=
 =?utf-8?B?VGU0ZWc5MEVHK0t6aVAxU2xRR3E4dXhKTmZTbWxMNnRhbmsyVzk2REljNVgr?=
 =?utf-8?B?MEdVZVByQjN4cHVvLzcxRlhWd3lHdmtKaUo4Wm1IWXBUenZieE1mZVhQRWh3?=
 =?utf-8?B?ZG1FYzYzRTFCUFR6b0thRk1xbXBhOCtQMkJoT29Vemt3eTFmMDlLaDlzSU11?=
 =?utf-8?B?Q0U3M2djU3Z2RVpBVjdxcHNrR0IvSllqSWFDTzZDdWxjRG93emtTb1ZDM0dS?=
 =?utf-8?B?OFZ0cXB6QXhFbFZPNmdXNFQzUkJXd0tLcG96TlF1YkZwaFBLaWhIc1RFNHR0?=
 =?utf-8?B?cE9ObXcxK0NCWmRGQVJmSTRBdFFJejZLNWk3RDh2MFQ0NEVxUXgzRnUxQ2tW?=
 =?utf-8?B?MXRxVExRRDVab2VDeHBuZStZak9mUElNU0hZUWJUQURoa0F4bjc2NnV2ZU5u?=
 =?utf-8?B?aEtjWXB3OGp1ZFpNRlZwN1pIL0ptMmpiZVlTTHEzNDRXdWhMajNNMytHQzVi?=
 =?utf-8?B?VENBanZRRFZnMDE4dWpKWVNiLy9DbExtVWNqQXpqNWNWdkFwRW1XZy9wQWdt?=
 =?utf-8?B?WUw3QlpocWRIUzlSNTVNNURaREwyYmJrVjRKN09OaHZ6VlZZa1JIeFhYZXVC?=
 =?utf-8?B?QU5oeFhoNlZwcjdiRXV2a3pZZDhKYVVqSHhaQzVmMkFJemRBZy9JY3l6R1lT?=
 =?utf-8?B?ZWlleXhrYmxWc2ZGRnJmVWxVSGpzR3c2NmtnNmxPY1d1OWZUc0hrQUVLKy9j?=
 =?utf-8?B?bXNjL3RaVjRJVjN3am9LaVAraFUwMCtHZE1JTis4anJlZWlhL0t3enVKZE1j?=
 =?utf-8?B?ZFRJVXVxbHZPUDdrMGRHS2hCZm93MnVBZnhGM1lSZ0dNZnM3VWNIMlI3ZlhM?=
 =?utf-8?B?YjRncTBJS3R3cFluYjBrN04wUy9FbFhqTnhKUzhadk9NTVE5ZWRsY0NqeTFG?=
 =?utf-8?B?eGNBQnBuWWpROHRJTERoL2xEWlhkUUk5Yk5lTVR5cjFVR3Uxbkl1c01lcitK?=
 =?utf-8?B?aTFCam1mSXRveGpLUmswY08zY25XQWFmOXk1LzFscUJQSDk1S2FKcjh3QWw1?=
 =?utf-8?B?ckZ0V3RTUWw3bEl2bWhoam9tR0RVNGlNV1Z1MXQ4MFUvTk9qWDQwejJrNWtZ?=
 =?utf-8?B?VWRhcWRabXkrWDU0Z2FsMi8wMVA5SEZlamZSdndQN1ZKeXZaK1o3Q0k1MDlN?=
 =?utf-8?B?amx6NCs4QngzY0Eya2Rjd3hZUElNdVB4eERyOUZERmNkSHAva2h0Mit1R2N0?=
 =?utf-8?B?WEZyYkdvZk5sNTREUCs1N1FwcGNpK3FsbUFnVDJkbWdSZHNEUUlzUkdDaFRC?=
 =?utf-8?B?VzAvVlN4MEMxUERWSEpMSWNqTTZLakRaSERpNVZCb1g3cHg3cVlQdHN2ekI2?=
 =?utf-8?B?bzNIN05Dc3dHR1FYYWtuVWV0V3pKUlRoMGtTRDJBZTYvcnEwT2ZYWU9hMEc2?=
 =?utf-8?B?cVBIaklFeHM5dThQRXRvRnpGWGtyT1J1b1VZRzdHNnU2RDZXTnhac3dhZFlj?=
 =?utf-8?B?bDY4V1lKcUVwQ0lJdExPU2dJTjZiNVo0N1oyUkthK21jKzY0NE5MZ2tjQ2pP?=
 =?utf-8?B?YkZ3SURnMEtwMnlqRXl0SUJhRHFOY3BKN3Q3MFlzdEVsVXd2NCt6YzBqTFpJ?=
 =?utf-8?B?ZjFrTDZXdUlVdmJXY2JvZnZWbFdqVHRjRDg1MnBTZisrbStPK2JqK1RoZ1JV?=
 =?utf-8?Q?oSG3xM62wKrhg1RmdTlrg6j1xXpyvvqN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZJb3J5YzA3UTBMQ1U0OS9OczZEcGlxSGdGUU5VZFpoOGhHaFdnVTJrRlFa?=
 =?utf-8?B?SWFidkp4QU4rUkZ5M2wvaEUzelk4czNPclpsWFBpQXJPb2ZjK0JoYUI5NmF3?=
 =?utf-8?B?Z2RrTlpldEJDbGcvcktxbGJzM2RZb1FFWGs3OXRBYk53ZkFVYXpMOFVieDhB?=
 =?utf-8?B?NWJKZHd0ZXYyRWRFeHVHeHJ4OU1wRDdWbHJIT2dreDJVTDc1UlhSMDdGQlpM?=
 =?utf-8?B?ekFmWXlUQ0dtUU5UQkNFZHcvbXJpalk1RXhkb3N5L3BOKy9qeXFTdUlmRmlr?=
 =?utf-8?B?ejlhY1FkK3UxbnlWVWlXbEIvQmlFN0xScDIwYVRQd3pDY2pwazgrWE1SQ2VJ?=
 =?utf-8?B?TTFrbUtkMHdRTFBHaUhxbWI2SllFRTI2OWNQUnloVDlZWlovaU5uQzJSYnl0?=
 =?utf-8?B?TTNKZlVxWjJ4R0liSWg5bngrZUpTRjFJeUl6bjJXc0VDMkVvOS84N1lXdVZ3?=
 =?utf-8?B?aW02TXc3WXBVdU5IamcwR0p3Nk04TnNQdSt2QU1YdXRJaFREa2Q0b0h3WHI2?=
 =?utf-8?B?enAyTjV2SHhQZ2xKczVSM21Eb0VKMFAyWE5RQlM3ejhiejc2MFhBS3hidHgw?=
 =?utf-8?B?RjQ0bHFYM1cyaGxpOCs5Ti9mSmxZL2hIV1Z2TkZKS1NjOU9jVVpCWUhDckRx?=
 =?utf-8?B?OXBxSlVoZFVKOGErU1p3RnRndWs2QUJYSDVYOTVjSzNkTHB1M0ZJTnkyWGJa?=
 =?utf-8?B?NjN2VkRiSmw1TitMMkt5MWV2VHBxVXpxbTdxc3k5RkJVd0w4cjFva0VFQXBr?=
 =?utf-8?B?NFdnblVhRVU0SWFQWGN6R0J2dzlqN3RjaFFnNjJ0WGJkRURXVnc2RHpYekln?=
 =?utf-8?B?dHBjZ3k1M1RmM25ob09ORmVDa3B2a2JaYVJJazB2L3ZFeW0wTTJ4anV4U3A5?=
 =?utf-8?B?bW9EL1lBR2JzZFE3a2thMitZZUdCdGVPQlFNWlkrNUN0cXl2ai9qdmN3SkhP?=
 =?utf-8?B?NVBNakhRZ0cwbHBQMndRSFZsQndPQW1KODlTNDFrWTJjVU5TUkdiMVFabWVq?=
 =?utf-8?B?Lzh6ZDNEamRMbGFZRUFiZWZKYURXN0V0bVBYMVVweDJIb1cySE1Fc3l0ckU4?=
 =?utf-8?B?V09HTFh5VVZ4RjVxdFNDYnBNQ2tXUHhGaWpCVUtaWnduaThaTTlqbjRmK09a?=
 =?utf-8?B?cXB3TUtYL28zdUttZjJ6Z3dIOTh4em1HaEd4VnNma3hIbFJ3ZFEzTWVYdjAw?=
 =?utf-8?B?dkJmdWVUVkhpa2NLdktCYWxvL3kzWEtRLzg0eE1YQ3hqcVloN1J3S0wrWW10?=
 =?utf-8?B?NnJzNWZPOGJ2K2dOSDlTeHR6b243cHVkRUhDVjN1dmlBTVkwRjl5NzBNblZ0?=
 =?utf-8?B?ZGdXVmlsTlhHU0lwRi9yRUs4S1VVOUhxd3NOT3lRVzI2N3pzenJ0Zm5wOWJa?=
 =?utf-8?B?SGV3KzdzSCtKRVhSYlZMM29kdFpkeUszeStCNjhXWmdjNnRxZDZQVHh6UVZ4?=
 =?utf-8?B?My9RbWxTc214OXBXd1RKeXRZd2FrNlhMLzRnM0hadWZnbC9uWm5zbTBVaWlq?=
 =?utf-8?B?NlJ6emw3ZXAzZ3lJUkYxeURRYmpCeUsyTWhLbVJ6eFVxVzJYWnlRdXZvaEpE?=
 =?utf-8?B?QXJiNHhLQkdvTVlTK0pzVUxSOEpsL21IVDVqNzZtOGFoR1NqZkc1VURwVG1h?=
 =?utf-8?B?NVhTSkF2RXUvMHhHVzdLVFVEM3ozc0w5M0owNHdibXpPZkFmL0t4L21MNUhU?=
 =?utf-8?B?WHZvanA2akE1MG9qOWVacmR5Y1RHb3luT253d2JZVzdHMGFreHNqZGRJb3Nl?=
 =?utf-8?B?d1BvSGZnSStqaXZQTm9TdGY5ZHBpQktxYTJ2QlBrSTJyUW5NZ0VFQlozcms0?=
 =?utf-8?B?Vm5zOThFclpLVHVrM0xYMlp2Y0tnM1FRbnVMcE1ZTmpHRTQxVURhbXYrYkwy?=
 =?utf-8?B?Qm5tUlVKQmlYeFZDa2FnTmNDTFZMTnVIMm84UFZ0cHhqM1JYSnMvMVlMZE9V?=
 =?utf-8?B?ZXdic3lrWjVHUStZWFNnekFnWDlsS2g3U1R4QTFIbkxmNE5XYTI2cEc5aVZG?=
 =?utf-8?B?THd4b1lWZnhRT3YvRWJnWXlzUTNyQVZ5OGRFY2kzc2JlQWx2VCtLRDQ2TGlB?=
 =?utf-8?B?SWdHYXk1ajZXb1FXOXo0S0orTTNmaGZrV1hyVjFMVENKVTkveTMrNk9sZlNr?=
 =?utf-8?B?bC8vaUpQVzd3UUp5dVBMSDJaekRJUWY5a2c2dXZrRzhhSWV0b25yRXgxOXYz?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hTji5e/oRrVHlpbJJxxRn+Kjw+7sW+WtPNoIWvnSZO8NkuucgyZ9mmH/U5oxEgc92PwsSvYv9jQ9zRdswtyGOwW/XzbSUKSpWTMNVIIYdz39RIlG7J3TwSMp2gWM5Wrs5Fg48q9tGnsLco+uMKNLTZcg95Dh9CI4ZKF4dmy15o1a6HpkNWi6vGeAKYX4bPTze4swPaXFLqMoYG/RllY9l9mvItCH+fqLZ1w7Q5pOp5eP1HA34/dCu0X9ZiK8G+sSktD6+6PZTDZG/A5zRnHg9USNwJ0S6paz45Mj46KfNTh+RCmeYC557K5Q03h3hL2ZF4MH4Ae1okSgOl8rL3SHMTX5SBwxgy7wC0bD8E75u/iT/rwdri50S/AvsgGobozfPUqhxBXViyEMti/1NnqzZsOcUGYv4B8A7aqYEunYrkH4sCsSlBvh585hGp7EjY489jZcAKLVBOUe/mxo2bTT4tN8j9/iI7ai0M79OIzAHcw2vfvOP01DZZ4BSCvyuK7HR5wuqif/l9an/iJgPlCbur3gUDHOK+dZxlQX5MTr1BjvaYQOquB8xBNX6fX7oMRcYzpWi/SI4vYiFmbNaZsUKdYSdv2qvTGoMUDbZhhbisI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afd8152-1e4b-453d-5506-08de164ecdb3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:21:24.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WMSoWN2fYX69LnZewQnhG446CfylOQDSZ0vUffKjdTg8KD7wIrCIic80R1BROSzVDctdxPQQwCw9AOqQyZSXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX0exPd2KM4zUL
 4V0xPwKJy+bkFrWkKD4UUfHUfLJtMgb9LjLcbn5GW16mAIPahHr9cnXhABh6chpOWdXXGofZ4uz
 jll+pl/V5PaUVzmTlB6Ee0Os9JJ32RNruTQ1Tb5APl7bJQgDBpHWSK4oOIbWiPiarDYwkWCvGZh
 ifKvMmGhrMDHFBjZQzYdcpqClsGMXyME5P0qWO5AxNPT470ARF0y88xlBCb3qBlHJ/7XAJ1jrwp
 mwZzJVPRc/39+WOVPFE1pmgNNRKUHuPLHrIbcJH+rBoTTkMxnLYdCgUc7pWJIu2QS9vTYdORu7A
 J5irijQrc06VkpM4gzfQMygYUWYBAss6SiM2M6Cey6pINwJPeJSJnM4JTL+gLPPUR5NeZrXTI+P
 ej8iI8epe/5VBmATuZaalcF7i4AgGGZHcrFk8Ie3z1rJIrszv6o=
X-Proofpoint-GUID: ZMnbYK8NLJVlp4NiZiRdg-QEX3JdEkXY
X-Proofpoint-ORIG-GUID: ZMnbYK8NLJVlp4NiZiRdg-QEX3JdEkXY
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=690109aa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=CVs2B2WrNIwjf9Ec:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1WtWmnkvAAAA:8 a=B7-tGCk0ZPfMIw9PDWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12123

On 28/10/2025 18:05, Andrii Nakryiko wrote:
> On Tue, Oct 28, 2025 at 6:57 AM Bixuan Cui <cuibixuan@vivo.com> wrote:
>>
>> Register kfunc in self-developed module but run error in other modules:
>>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROTO
>>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #2: -22
>>
>> It is usually skipping the error does not affect the search for the next module.
>>
>> Then ignoring the failed modules, load the bpf process:
>>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROTO
>>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #3: -22
>>     libbpf: extern (func ksym) 'bpf_kfunc': resolved to bpf_module [164442]
>>     ...
>>
>> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 711173acbcef..0fa0d89da068 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -5702,7 +5702,8 @@ static int load_module_btfs(struct bpf_object *obj)
>>                 if (err) {
>>                         pr_warn("failed to load module [%s]'s BTF object #%d: %d\n",
>>                                 name, id, err);
>> -                       goto err_out;
>> +                       close(fd);
>> +                       continue;
>>                 }
> 
> It's not an expected condition to have kernel module with corrupted
> BTF, so I don't think we should be doing this.
> 
> pw-bot: cr
>

Would be good to understand this failure better. If the module is being
built out-of-tree with relatively new pahole, it will have a .BTF.base
section and a .BTF section; the .BTF.base section allows the module to
carry stable references to vmlinux BTF types which then get fixed up to
the real vmlinux BTF id references when the module is loaded. It is
possible there are bugs in that code however, so it woul be good to
figure that out. bpftool should dump BTF for your module using the
.BTF.base section as base, so

bpftool btf dump file mymod.ko

should work (provided "objdump -h mymod.ko" shows a .BTF.base and .BTF
section).  If it does, the BTF id relocation may be breaking and we
might need to do further digging to understand where. It should relocate
BTF kfunc ids also, but again there may be a bug lurking here.

If the BTF is loading into the kernel, comparing

bpftool btf dump -B /sys/kernel/btf file /sys/kernel/btf/mymod

...to the .ko BTF would be valuable.

If your module only has a .BTF section and no .BTF.base section, it is
possible it did not get (re)built against an updated vmlinux and has
outdated type id references as a result.

Alan

