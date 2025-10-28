Return-Path: <bpf+bounces-72512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2482BC1407A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA019C5771
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216132E540C;
	Tue, 28 Oct 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nBz0+NF3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="toZ/q5qe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B82DEA96
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646547; cv=fail; b=Kfno/zB77kvAgwF6nMgVT+8V1S1ghscCwVdUKL6lYvMsHIiP6/0bjCsf+oxe2zC7e/w8JRmxuP2cn4V9k8Z/I5zz1ZTV2lp9Ri99xx6qJQpr+MkthgfjbzkvKifw/6OOIchiFs2bv4DU6J6XR03++10SRyGUEYAwNFlEVpWmm+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646547; c=relaxed/simple;
	bh=FIwOBDt91fySBEGUmkbcG1Sh+GXvAM6NwnEeYFynypE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALUWXPVar63mUfc+V2a8/ARh+3TZdAK6ZAd76oY0rfeBSHpE1UV9tHz3+ISXL1r+pKEhO7TpDWfqYt9T45q0BUEGuqmAx1ZGeKBLxKxWhS6qeTJUx8nl3jpBaOtC7cxCXZwf8PBhfrGClKa9hYQRnM6qNbRz23Q+P+nsXh/fxyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nBz0+NF3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=toZ/q5qe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NPOZ012910;
	Tue, 28 Oct 2025 10:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BXAWmWFDh1dSdYa++OnKxu3OqdeXdlln/EFr4b9G/dA=; b=
	nBz0+NF3wTNTKPVlVghQqgRUinm9lSaMzf6G9CW1gFDH0oqWvwrvKOty65w53o7s
	jedIjPd9IXkhzW5plJ0DPJ4jm81o75ooW50Vo1zIeW/qagMMOubReGTwut2HhfZi
	64W2SWbpAgbRUSN3zCJIjeKx4BRHzKsWQqwl+Px+mA4umKlP1zVsDix2nN7+kjB6
	PG5689F9BGEHQFjLOYn1Wj+WijhsQW+UmoD5kYr5bCllvEtFJ51R+xHKCiSfRP64
	Rj5fiJXOBwgH0v5WsiJEI8PZ2fhayJjlDIGNf3qczYvjkNYPZUorlFXoilL/8b67
	CaeAGlvYblm1RqMEIQxb9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22x6u3gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:15:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9p8am016405;
	Tue, 28 Oct 2025 10:15:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n080pqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 10:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=varwy/Yw2kz0+S96u8GRunsZZn7jI5glHXrVdgABBD91w5vUTGxFd3HC+22lNZpuCtWeN/BVkKlOKGSrLg+WN5+7K8JdjEG/vcfXJ+/Zh0dvE+NikXrPlyBML+VO0g+OMjv7Yv6H7/amM+czzO55S4RriW8qxdiQE/Y5WtpmqRvf654y0IFXITcm/KZ4RgFDfVM/RZh/3OecCLpI9c+PGyz4Fjp99jAoFoL9jGAUAPxno9dkSgRQ2bmkDxx+y9+JJcfzDhoYlJPRGqULF4Nt+Nlj/3nZ8kGme5pq5YuFqHkgvJyKa9MqQY2xOMgUC/wtVPpXAvstHs1f2X8eHgvBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXAWmWFDh1dSdYa++OnKxu3OqdeXdlln/EFr4b9G/dA=;
 b=Cwfr4mlcJ4GkXkKyNStIlcmZGKjSp7AnhMd8mN0ZZ+xvjTGkOffHzY64k73KMbQx9OeVdMsASyvJszOQ+JhYkmeifEeh4CHnen9VYoBHsKu2aAxbo1ibTlHkMjwRK8lpfYStqSM7Bp0DUL7bbEhXA1rKQc6A03XSQLwpxH7lDTGO6OW6DXVw9oWk9H9YDSHNHXUBkUjvjE/wMzhd4s0nAvTrWUtZrLxR83m5L8j+MWvlCRBPnPH+a28BBvMGP5XrVjVRLGZBY40CiiGlp6KT0SI+OTNu1+A9Xu7zkHXYwU0+T6gyd5LSNgdffpwsbEIbKPWqxiUuU2nSJoNtynYIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXAWmWFDh1dSdYa++OnKxu3OqdeXdlln/EFr4b9G/dA=;
 b=toZ/q5qeFGNx685I0pul/rD3BbRCtEIo73X5zyAm972w7qTEZNsS4xZY+XVrE2O8qDnT3gzF6oSFXbF/K0SIq67xLU41beEAMtF44eAOkl6xhzkZ06TWosruFWttcjmvCNalJgkdnV+6WGHM0jzijhIUKsAMR2mgFhk6gp1O5ok=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 10:15:33 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 10:15:33 +0000
Message-ID: <708fcb30-42bf-4525-aefe-cf9791bf70e0@oracle.com>
Date: Tue, 28 Oct 2025 10:15:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] Build error in tools/testing/selftests/bpf/
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        bpf@vger.kernel.org, kpsingh@kernel.org
References: <e9a3bfc2-2e9b-4ace-8443-52a951a4707b@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e9a3bfc2-2e9b-4ace-8443-52a951a4707b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fe66e7-3e1b-483c-69ed-08de160aee08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnEreFJJalh1Y2pMeVVLTmxBMTNMUTRvME1ZVEpldVRiWm42Z2Exc3dQeURu?=
 =?utf-8?B?WFFKWFRwaTZ1dGZ0OU5ZL0JRRzhQbTQ2K09FRlFmUXVHNk5sNmRpNnJkaVAy?=
 =?utf-8?B?enpMRnZSRnBpamc1UHBUaHZwOTRaejgvbGIyeTNJeHdKWllsUFl3WmE4b3Zk?=
 =?utf-8?B?YjA3YUZTMEw5SHdkVXVkV2R5cmIrUXRZRXl6dEl0VFdocjBOL1I4K2hoOWk0?=
 =?utf-8?B?ZDFzanZnS2Z2aEluTDJLVFpuRThsc3h6eTlyc0JWbEV4dnFObytZZXVlZ2Fj?=
 =?utf-8?B?cFdibnNSMUx0MFQvVUtzOWV5WHBhY3VBR3dJMkdUVCsvYnppZXIrSTZFU0N2?=
 =?utf-8?B?VGE4bzJvTk5BOGREVXRQMFR6U3B3bkRqNVZsZTFEQUN4Nkd3QmZQaUlLaDNV?=
 =?utf-8?B?cVN1eFowb2pZUU5zMlFia005NmRzbVY4K2RpM2pPU3FNemRYaFhQU0t3NmYw?=
 =?utf-8?B?Sld4RDdkenl3ZTJsNXVXb0psZTR5dlhSb0tjV1VwQmpMRTAyU1RxYWpUOTdv?=
 =?utf-8?B?Vmo1WlpoWTAycnN6dkZJOENvQ2JESzNZb2I3YjI5NWZvcDFLNnRKRUtraDIz?=
 =?utf-8?B?MEhRajU3ZTllQVErdEt1RlR6UENxS2Q5WTRXN3JudXpsUWJaZ3dwdDM2d2Vr?=
 =?utf-8?B?by9SU0dlYXl1ekNWUEIvb0x4RGcwa1JPQUhWK05jbWNwNzNBeFY3VmdraUVM?=
 =?utf-8?B?WUtVVE9ZMHlMWkxJdzZpNGZpNGxPYS9USzVFUEJTS1dTLzFUMitubzlWRGpo?=
 =?utf-8?B?K1BFNmpUTmdncytYSTEzd1duelQ0MUhIQ1pEWUtuZy9mOHhDa0d1NFNFbTJP?=
 =?utf-8?B?TXNTVnVLbmRyK1hONFBqaldkS2RxRGVhUVdjZEIwSFlyT1lUNUZnajNLbXR1?=
 =?utf-8?B?OFF1c21LZjF0dGhTZDlLSENpcTJmZEVVYzYwekdRSVlUN25DVVlybkk2VElT?=
 =?utf-8?B?SXFVdzVnM1VBbDg2V1BDcGtZcHFXUDFOWWVPSTN5NUpoWWtDdDdmOVFoYjM0?=
 =?utf-8?B?dkZYcVBVTUhkR0dkZlRWOGh3VEtkZ1BtbDZ4ZHhqWm5zbjh4RWdid0hQMW1F?=
 =?utf-8?B?RW9ZaXBBNWxJUGdPOXJCZjFEc01Mb1NlSFh1aGVXQnYxTHkwUnUrOVR5T1NO?=
 =?utf-8?B?T3gzT296R2x1ZW92a3IvRGx6YnNwa1BhNGNVd2tqajBqRzBXYmdLUTE1Y0U0?=
 =?utf-8?B?OEJuTWFBWVVWNmFwZ0Uxa3JvV0FuT0JCRzZIQjVneldpTzFGTEcwRXpzdFAy?=
 =?utf-8?B?blU5eTFNQktXVWNRc2JtaUg5Vy9kYlkvajA5TVNDUlZCcDZwTzJuMTFMcFZK?=
 =?utf-8?B?b3RBbnN5QkR2NG11ZXMvQkxFOUJqUHM4bFlNK1hxdk42N3MvNW1qNFJlbUFi?=
 =?utf-8?B?NzNXUUZ1aWVPVzR0N21tTFlaVk1LSkcyM2lRVjFVUmo2aStxcEFqZGxIdU9Z?=
 =?utf-8?B?TXBlcm5wMUFua0xUdG9sajMzVzFGREROc2ZJVE0rMnF3SlNrcUxwR2VxaUpt?=
 =?utf-8?B?RGJPMWlqQmdla2VKaGJPVmR6VUdvWXBiUzQ3NFlvay84NWIrTTVERjNqZnQw?=
 =?utf-8?B?MkJzQ0YwQWp3a3dZRU93UnpRTERmMWVlSFJadkY2SEh2aGJuek1BSURMdGhP?=
 =?utf-8?B?SFA3QTVsSmlvS0pUeDRqdzNhK2EyaktvUGtwVjR4SzlJeDB4dFJaWTY0RXMx?=
 =?utf-8?B?SXNZcGZuMUg4TTFBTTUrckd5YXdGdkE1b1lwUm9ROGpQay82MzFmZFhhNUJK?=
 =?utf-8?B?VFdhZ3hoTW9JVlVBd01kRlBoblFMa041RGk1S0hTbHA3NXFEVVBpV0FMWDVX?=
 =?utf-8?B?bzc4VDBBWFYyZWd6U2FuMGRHdnpTV1dUT0IvSHdkb1lVV1UzditTWktLWEhF?=
 =?utf-8?B?OUdXa0kvU3Y2cmxmazYwcllZK1Y0cGFJdGpNa0NkZDA3eEJqYjJSczlTbzdN?=
 =?utf-8?Q?7xdfmqFA2tGn14SgxqirsWMsC57O4SwW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNXa3FyN2pyYzhwMUZFa1A2cU1IcHhaR2tOYjk2RlNmYmh5bkZhVkxvaXdu?=
 =?utf-8?B?a1hzK1ZVMFE4eFlZcjFuN09oVFpiMS9mQVdOd2NzcnpnL2FlTGwvZGk0RlAy?=
 =?utf-8?B?RVplUTQwTGhNQUxaMkwyU3k3dG1vYlVtRmh3Q3ZXTDdEdEZGNTVzekxleTdY?=
 =?utf-8?B?OTZGbkIrc0xzcnpjVmlKanIvRmtwa0FzaFk2aUc3aUlqRnVWYk54UnJMN04v?=
 =?utf-8?B?TGdraWpCcDgydlZKWFlWSDM4TnJqTDRoREN0NDRWejVUaXl3L1dIMUd0cHNY?=
 =?utf-8?B?KzhVRUU3eDJKS3BSMmMvdUxHTU8wZ1VtbHVFLzJkeWpOOUdNaSs5eFlrTmdI?=
 =?utf-8?B?S3IxdCttY05JalM1MlJQcUtrNkkvQjVTNUlwcSt0VlpBMjd0WVQ3cFhySnMz?=
 =?utf-8?B?cUZ0ZGxyUkhDQlUxQmkrSU5VbkEvN0ZZME5TRlR6OGdyc2NkMmJUWGRLcWV5?=
 =?utf-8?B?NHA2L0kzYWNFYmdkMFlkM1RvcU00ajJFOXk4WHpBaGJCSk5rZlROQWtVb21j?=
 =?utf-8?B?QkZENnVQYkpwc2dNcmhmbnViVGE3MVl0RVhyQ1graGxhNlY0RHlpS3lSbUNL?=
 =?utf-8?B?anZ6aFFrb2QzWGMyWEY3bHZCNDE5bUxzQXJ1RWVHWWZ1alp0RVhJblZTRnlE?=
 =?utf-8?B?ZUxHaVlUTGZBN2pXZ0dWd3lTeW1TMnRhSE1JcUxYeHp6RlZUOHVORnB3Nzdx?=
 =?utf-8?B?N3I2V0dKb3FVeHZvTUhwbGdwc2ZVSmlmd05IbzJ4NHExcmdIYi9FeFdYeXYz?=
 =?utf-8?B?ZlVhSWp5Q1ZUK3dKM09nbUc1NXpIMmt5TmwyNUhSYmxqeWs0bUxQdDVDWDU5?=
 =?utf-8?B?ZnVvVU0xOWxoRktUZFlCYisrOWRZMFg2Rnp2UjUrY2lDejNPK2syV1dvemxI?=
 =?utf-8?B?K00rdGtXQmdraXd4bmtuSHIwcTlQY3Vxd2N2Q211N3Z6ZjhYVExWWFNGNGRW?=
 =?utf-8?B?R3J4ejhrRmNEQ3lvNU84MEd1OWlHcWlRWmxpKzJjYVhHYWVLRmQ2VkRaVFZW?=
 =?utf-8?B?dSt6c2o2bU95dlVuTytSUHNoTm1zT0thK3NDRDFwT3lwQ2VjdlBidFNFWkRm?=
 =?utf-8?B?R21wWVE1UTFXNUMzUVlpYmFlWW52UHNpOHJTUzhQM243U0I0c0tlTFE1TllO?=
 =?utf-8?B?SCtnSWRYWU55UDRCTERPOG5UczI2bDVpZ1pxcXhuSm8xNFU3LzZrWko3cnJ1?=
 =?utf-8?B?U0tCdTgwbm52blB2MWU3d3k0cTlDYmdGSVk3Wk0yUnBWbWxYcDVJZHFtVU5W?=
 =?utf-8?B?bGxvcmNSRjdPb1hqVnBlbDBWaGpoekhva1JPL0JSYURTajU3UTl4NTJRYTl3?=
 =?utf-8?B?OUg0eW1oNWdzeW8wT1d0QWo4SFFRSXh0VFAveVZNdmpFMWNyZlN3QTRUWVVV?=
 =?utf-8?B?M2RqNmRUVURIOXRnb3NyVE4ybCtsc3hrbmY2NWMzNGR4Z1ZHSU1nb2VxR0Vn?=
 =?utf-8?B?Sk43SzJLRlc5UU5GeTd5TVptMkEyd28wcVl1YzkwL0F3Um5DV1V5UjRxTlBZ?=
 =?utf-8?B?OERPN0tNdEJFS05mSk1IbWZJcFNsbWUxd3RIbUcvamMwNHQrUjRkOVhWU2tr?=
 =?utf-8?B?eFd1dXdIUW5xcW9mWmM3VFhHRFgwdzFWLzUyOXh6TWU5MkoxZ1V5QVdTT0pY?=
 =?utf-8?B?Tk9sZEtGNzgzaDlwZm1ZNzFvUEZwTVZ2clFmb09pTGpaWmtQZGhWQ1lUaWhV?=
 =?utf-8?B?Z3g2U0pwRjVPNDh0RGRITENMN2diblZ3Y2tFa1RZcDF5SVZaZ0s4TWo4cWhk?=
 =?utf-8?B?SDY1WXJ1VDB3NEcrdzhpZVZJZFpXZnNpbXZJYkczdGFqZmVSZ3crdml6UU43?=
 =?utf-8?B?M3Jvam1aaUIyalNoaEN0bGFPMzkrT0MzWWtCYWRaS1RIM1duYk8zbkRDdlFl?=
 =?utf-8?B?R0h4Wis5Y1RtczgwT3AzTjFNOWpvWGQ1Vkc4MWRtWEZSaFhOU0h6eitXS2Vy?=
 =?utf-8?B?TFdnTUtQcUZSeTkxZlNkYWVxN0pTWHFWczh6RnVGdFdYVUhTTEJjT2NhSjIx?=
 =?utf-8?B?NkpUQVFoVVBWU1NocSswNlcvQjE1dU9tQUQrUUZPOU1NV0M5bUJBZ2ZySzR6?=
 =?utf-8?B?SllxV3Fkc2Y1bDAxdkpnSGN6eFBJVHBaMTREY3gxYVRmNTBNbFhTdG55a05Q?=
 =?utf-8?B?bGxUNGtCMTd1U2ZtaUhDNkFnbE4yRjJ2YnFvMnBFR0pwem5iVGZ0YzJMcmx4?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Na5FscfhzuCIaCnRJE0SgkoCA7AsfDrednfn/FZNpUv/s/OlICa+dSWxozMBCMdr37mSk+mqJTBatLsQipXYW5OcZDWk3LRQXkaspeeEQ5PtFq7BHGf2E2JAcAW4SSUBk+4eyKT8p6KYvuIri9820+gKQFSRdZ7hiX9Y00PiRgSpiKoHT/g3KOFHvWrXZ8u3NTmRfe+Evny7G7wKPJusBEgPorUelErazIet0YxcZLeE/kABLP5qiAoci62UsGfYjrbbmPSnza2FZQBlV2xa0uMm1xPQ1Zjcyco2yFq5bFEbqHbEUHFxDEzLfYczCK4yHAiDFPEfR+8QXHB5rjwgOGwpmZvMz5cQFddaZX/Gt9oXGHfOTp7z0oFtKzsMXfJX6UaAfhDHEv+nkfl001c4c5sOeivx3dG3xrMoanpGjOQAPZsi25DyD4SvEpEepU6FBPUFff7IDf+4aBTMZ3kAM+CtKrVgVV7wQu4Wq59eJVbk3YRO4XMPTRel+fMlbDMRo9rXX9T4J97Yhb9wX1Las0GzaxSIYfAzJSzsaQFXJyoFbOEZIsejLD9M1OCUhp3Q/87s0b+SVQJZDd1G0VJw8N3Llv6OMZBQ254Keq0Dhi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe66e7-3e1b-483c-69ed-08de160aee08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:15:33.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0gylzCKmMRpDL3UVepBpSOFze99alvG3lJDNS7bqHUKZkgKZunEivuTrww8NG12MjLijZyl2eNADg8AWPHLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX+HnKkIJXUAxZ
 Jq8NfRynkK1Ls9frBw4q/gqCvJuJtKMb+7WerDdP5OYkDKAX9MLgOadtKzGsYIZMqfSSeGKwN3U
 BjPY1BlA2xFie2lKo2c0DkHe/wiPwmkbC9kbdWVVj5rgcqzqSA0UhzqBt3x8VkDDbPEP3IMq74R
 /V5GfyaRj36ZHygAHeBOZWE6Bhif8MW29IgG0k6npYVc1NrZHArZzuh+8g5b9YS0IFVGycOzv+a
 fbXJYCjKlfixeXUisYhCpO4zhqKXo+680drklWs+s+7co+4cNCC2L96c1zw0D03LQhymJvwpEqy
 oANIffTytl4oBW/lHvs+zwFZUrNl/DyuRDXmTc1YhwZBYebpwAMtAItlud4MuBhLcFmpBVFVG0+
 lQsn/z0GhWBgucfubDIH1noX4Q8J4BHfp8UrtRnGh3End0wdcbU=
X-Proofpoint-GUID: tXwab8Rp_qhG15ETDENvIe7hB5VGLxut
X-Proofpoint-ORIG-GUID: tXwab8Rp_qhG15ETDENvIe7hB5VGLxut
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=690097c9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yQpL5E4rcfw2QfizZL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657

On 28/10/2025 09:31, Harshit Mogalapalli wrote:
> Hi all,
> 
> I am seeing a build failure with latest bpf-next:
> 
> 
> [root@hamogala-Kbuild bpf-next]# git describe
> bpf-next-6.16-44604-gf9db3a38224e
> [root@hamogala-Kbuild bpf-next]# make -j$(nproc) -C tools/testing/
> selftests/bpf/
> make: Entering directory '/home/opc/bpf-next/tools/testing/selftests/bpf'
> 
> Usage:
>        xxd [options] [infile [outfile]]
>     or
>        xxd -r [-s [-]offset] [-c cols] [-ps] [infile [outfile]]
> Options:
>     -a          toggle autoskip: A single '*' replaces nul-lines.
> Default off.
>     -b          binary digit dump (incompatible with -ps,-i,-r). Default
> hex.
>     -C          capitalize variable names in C include file style (-i).
>     -c cols     format <cols> octets per line. Default 16 (-i: 12, -ps:
> 30).
>     -E          show characters in EBCDIC. Default ASCII.
>     -e          little-endian dump (incompatible with -ps,-i,-r).
>     -g          number of octets per group in normal output. Default 2
> (-e: 4).
>     -h          print this summary.
>     -i          output in C include file style.
>     -l len      stop after <len> octets.
>     -o off      add <off> to the displayed file position.
>     -ps         output in postscript plain hexdump style.
>     -r          reverse operation: convert (or patch) hexdump into binary.
>     -r -s off   revert with <off> added to file positions found in hexdump.
>     -d          show offset in decimal instead of hex.
>     -s [+][-]seek  start at <seek> bytes abs. (or +: rel.) infile offset.
>     -u          use upper case hex letters.
>     -v          show version: "xxd V1.10 27oct98 by Juergen Weigert".
> make: *** [Makefile:726: verification_cert.h] Error 1
> make: *** Deleting file 'verification_cert.h'
> make: Leaving directory '/home/opc/bpf-next/tools/testing/selftests/bpf'
> 
> This looks related to: commit: b720903e2b14 ("selftests/bpf: Enable
> signature verification for some lskel tests")
> 
>

hi Harshit, I ran into this too; it turns out the version of
/usr/bin/xxd needs to support the -n (name) option and only the
vim-common v9 or later version supports that. The name option allows the
user to provide a name not derived implicitly from the file path
apparently. It _might_ make sense to do something like the below since
it would loosen the requirement for a very new vim-common package to be
installed. Many distros may not have a new enough xxd packaged, and as a
result run into this issue.

The patch simply creates a symlink to the cert with the right name,
allowing xxd to generate the header without the -n option.

diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 7437c325179e..a276f83d7c52 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -722,7 +722,8 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
        $(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)

 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
-       $(Q)xxd -i -n test_progs_verification_cert $< > $@
+       $(Q)ln -fs $< test_progs_verification_cert && \
+       xxd -i test_progs_verification_cert > $@

 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests



