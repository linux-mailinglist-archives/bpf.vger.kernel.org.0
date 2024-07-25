Return-Path: <bpf+bounces-35659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A093C8C8
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767332834E7
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F352F9E;
	Thu, 25 Jul 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="INPTPBqH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OHNBb4ur"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47A1F959;
	Thu, 25 Jul 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936279; cv=fail; b=qxVWBmL1InZXjEme0sHkZ6Pian2CCc1pqWO2qTAvYK21I/BsETb9dHAjiKnAEeKLqZWq/LhZplu9DoUZWGN7Oxm15xSCvKy+D/P7NHi1yyyTfZP+CPkSHhHFH8QnUxuv8PJ7wUpj9P6lXYlVt+p/kbqhCrzAqN1061qjcb4qUbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936279; c=relaxed/simple;
	bh=BAfNEmPABy/s8GYEbHtLzHhgXPy68LB9OsG37G55TwM=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=R2RXhdck5OWsS+Q3jCBVLfOf75I4YW9lLto5vCYyOtdmcw943jMEgxvlH13kI9r0x4tTIB3FWJKk++5845etwIbHway6lScuiTk9T1sBjCerEWC2Di7hCmbNC7r+Cpx050PS/bAdblf94CtIVwAmIegzbW47xmSrTK0JoZ76ruQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=INPTPBqH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OHNBb4ur; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PHiT4h005877;
	Thu, 25 Jul 2024 19:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:from:subject:cc:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=B
	AfNEmPABy/s8GYEbHtLzHhgXPy68LB9OsG37G55TwM=; b=INPTPBqHbJtKLxaNg
	SBUT4bY/PFhJ2KLnuSWtPXPkpKjn8SdqAj9CZuHUm1bM7zcmm3aP/Nbvtb+7OtXl
	tuFKZxoMOQBqPA2AmnXlZfgjxMYr+esOZG3NOFIa76F3IQ6X1FOA6OpggzfFy9Ml
	8B9ifd5BJLTycNYIKuvTjn82RGd6o+9k9NDfjhWmJhTjsIDb/jw4IKV2b7LmNj1b
	ee2+/QzCEZjvwrt6s84DnkKTarWk0mLi1TqlunmlEN5uYmvV7IvS2Jdz5ehhU62x
	799hw5nazZcMF+Vu2cQealkj4ApNgWbaqWn2MI8lsAZXrUJMgKpDLYjaZCSgcd2m
	PxnLw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40k7yutfkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 19:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46PJ5hPi022252;
	Thu, 25 Jul 2024 19:37:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27r2fue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 19:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3O6NkWwsQNW5Ur1xYtUtpyrz3sjejiKSh8rKIOU+d6WANFqQ+UcowY/5wHlyVJ2aIys5kiejibDL9/WYZzHiYtUbfUOzpb0NkVntW+jNDKToSddKqpjYhNB7ZRIMC4KvcMDVw5KCY5SjcGA3ynwK5rgPyPXKe30eGNStp/Y/muPhIJEuVr3plxl44pwT2P9F+qv6cFEzHQnioI3BPJd5LVOeBvIgtQGo82NUWLf/bHJQmxktc0Hx9wA6PIb/pHV3Yqs76QH6qx6t7FlAMK8tNOEdeUAThJKzeRCUk0mNSBL6I9lfXBkPVCkt+uAPjSd4InJUvIW8n/X7zqnih2QcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAfNEmPABy/s8GYEbHtLzHhgXPy68LB9OsG37G55TwM=;
 b=Zv/yqIifDakOYqBltFyHZtbjwPImqSdWODRAW+ZGBvb9W7uGUqQMknuAv3UbLZlKzI1mPw7XQ7gEGiLSAAIonAzjcJ3RUgQ5wtHFTtfkdT2HYjlIEsYbh4RFfGm2GXeevL5jR7kmCjb9EqLrjKZuSbazFw20e8v4X2c60zgyfIfjsROft30nXJjbWnSy7u1f5vO2wt7Qh9A+l1PN9GlAhj1qmBUYl4aSV6MeZ4FwIfoz2N2rdQ7NIg8/BMk+hNMn+uSGUvUnGdC1pZ//FItHmARZM6UnnqGWlzCsIJUN01lo+PIlXYar/dMVp6tqt7aqWcSTGBYaJtLvnBJ9iqGTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAfNEmPABy/s8GYEbHtLzHhgXPy68LB9OsG37G55TwM=;
 b=OHNBb4urIKoZwh68lkcOt3RZ2bZWvMGXOmFUC8Xn2oLObo30aGk/7i+Q28LOZgsfQrKm2KPbTMZkgMRQrJKBf4T3UJMZbI50ArGwVIduyFYj7ke2Jn5Drm+2ZP8Cr1mx822qggQZyIf9uFDewMVeyEAz8TKV8nPrSu1MSdw9nsI=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CO6PR10MB5588.namprd10.prod.outlook.com (2603:10b6:303:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 19:37:39 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 19:37:38 +0000
Message-ID: <2628656e-ea6f-4885-8fbc-bd14f07a5b00@oracle.com>
Date: Thu, 25 Jul 2024 12:37:03 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sdf@google.com, Eric Dumazet <edumazet@google.com>, priyarjha@google.com,
        ycheng@google.com, soheil@google.com, daniel@iogearbox.net
From: Rao Shoaib <rao.shoaib@oracle.com>
Subject: bpf: add BPF_CGROUP_SOCK_OPS callback that is executed on every RTT
 (commit: 23729ff23186424)
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CO6PR10MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dcb3ad-af48-47ca-6612-08dcace13da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1KNE00Q25rendlL29IdHIrNU1zYjBtcllxK1g0RHZscWRwYUxMUVNsOXlF?=
 =?utf-8?B?WnJaalhpaE9ydVBxUFRHZFE2YWtkVjFLanRNY00wcmxrUDhYRUJwS2tZc3Zm?=
 =?utf-8?B?NmMrdGVMajM2LzN1MVBoejVVcStlMy80enBveVZFdFlCZEV6Nzl2OXQyUGFF?=
 =?utf-8?B?dVFLcDhRVHh1amR3elVtdkVjaUNxVi9BREErZEZLc05ic3FxNDFmV0hCZnhv?=
 =?utf-8?B?OTgweVBnVFBEQjM5bkxSMW4wOXJyUGlvRW9SWjhmakNKbkllTXBFdXZvSVFi?=
 =?utf-8?B?Y0R3b2RabjJDUWcxYkJXcjNOSVJ1WER3KzFuT05USU9Oc2xwMXIrRm8vVXlq?=
 =?utf-8?B?YWtBQUVuVFZhU0dickVDWC9hN2hQM1FJSHdPejJqcExYNGljVngyc3M3VHdH?=
 =?utf-8?B?ckNuZDc0TjZVZDRwcTJwblp1Qnk0RjZkV1NsVWRRanBpYTlEOWRzdXNodzJj?=
 =?utf-8?B?Y1lQTjZoamRJbmxGamFEK1BjMUVlRWUyS1duc0FFdjlPc1p1dUcyYkR3RTF1?=
 =?utf-8?B?UkVyQWJrSjM2dFFqblJBbjhjK3Zja1ExdS9iaXUrSUE3dlRvaCtOK2d6WGVD?=
 =?utf-8?B?c3A0Ykc5c1FBMlEyMHJwY2kwZ290K3RlRkw1enBXWEkwWm45VCtWV0YzZ0xm?=
 =?utf-8?B?TGVqR3o4Z2QxM3hGalJPVmJmT3huamFZU216QTEvd2hJWXA5a0RFSG9qWHBD?=
 =?utf-8?B?UE44ekdMQXE1akJXTndQU1FUWjEySWZKbGJVUHV6RlA5ekd2dStzdjNCa2lC?=
 =?utf-8?B?eERQRGhkdDh3RVQ2ZVBDTXFjVnhRTU02bEdjVXFGWXZaaldPYUx4RG4zbVNp?=
 =?utf-8?B?RlVaUmtEWFpXcTIzbzBuUjRXTE4wSnZSM1ZCNzZvNXJIRXg0bjJ6YlYyayty?=
 =?utf-8?B?N1N2cTFXRU5hdmdUL1dHSDBKRmg5ajVkTmdlMDlhcEhBeElzWEpTQVFmVmhY?=
 =?utf-8?B?RGhiTXVaUUVMT01mRnh2VjZIMnYrZVg2T00wdG9vTmlyRFBjclZVRUFsQk9Q?=
 =?utf-8?B?b0lIOVNWb3l2VkxHU2QrOHAwZUNZNXAvaGltSmZLWFlNbS8xU2dzbDBWT1pP?=
 =?utf-8?B?RTJ4QkVZZXlnODB1eXk5cW5VdzZUSGJEVFNVbytNN3RRODFOQTZlbEpkczJk?=
 =?utf-8?B?Qk85My9QWklDS0RtVFNwSG5FM211Y0JEWUJRcnNrKzA4bTZ3OStQd3NGeGUr?=
 =?utf-8?B?aHdjSkdPa1ArVk5SQlJwQU5vcmNxV095SUx4TUpKVVJQRWNYMkJlbFZ4clU4?=
 =?utf-8?B?U3FUY2RqbUF0MDdoZHQrQ05YaFh4MzhYTEtZNDFHYlhybGVCR1lwZFpvOU5h?=
 =?utf-8?B?Wkl5NmhtMUd3ZCtaZm9OMjhPTkJFNzdWWmtWS2JETGxNWHlSOEFCdmJ3MVhk?=
 =?utf-8?B?c3F2TmVyakxaRFp4WkhTNzVKVk82TWMwblZsUmNSbTdZQ255a096OG5mQndk?=
 =?utf-8?B?aTl5QWhQcDQvT0FzR05xUW0zTDBORnRBM3BXTXpMblFlMDdReUVWUzZwdnhs?=
 =?utf-8?B?eDhKUHY3ZWhVUXVGSmRMRDBkc1FrS1lmVEZuc3N5S00xVE5VWE5GOFdSNklP?=
 =?utf-8?B?YVpNWm9RTUtvRUVYNnI2bURxTmtZVXpnM05zbmNIcXJScVd0d0F1UEwvNlp6?=
 =?utf-8?B?UmxRNkhBQXYrTi9PMmJqSlplYVVSWGN0WllpQWJodlZxSlNoWm5LeThYOXBI?=
 =?utf-8?B?QVJFczN2Wm81c3E0VVVKYkNCRHk3NVpyR0czS0Z2OEJFUzdzK2ZOUk8zaDJ2?=
 =?utf-8?B?L250VDNXRzB5bmlxZ2J4bDRNcU5WblJ5MFFnVG80TlJybGJoOXJ1QUhFNk1U?=
 =?utf-8?B?M0YxRGprVXJtZktXaDZTdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ViYlVFNDZ4VEQyTHVRYlJCUEpvTFJYcHRvaGluWGkreWpJTnBtZTlQaGdL?=
 =?utf-8?B?MXU4c2QwRklYcE13NmR6aE9wOU14L3d5OHZqRVRLYVZ1MkZCT3B0VGxXcUhy?=
 =?utf-8?B?eHhaRlg3OEpXK2xsdk03dld0ZzZEbk1KVWc0b1orcmtIeG5VdjFFd1pUVWhl?=
 =?utf-8?B?NFZ5UHFybUNUb2o1SzFmb01PSi8zWkJlT0ZHOFEvclFVKzZnOWRJOWRBdEdX?=
 =?utf-8?B?bGF0WXltNHdYT0hMOTVpUU9zRjNtczFIN2xEcjlnMVdWZkhIeGt6cFlrVkpK?=
 =?utf-8?B?ZDN2aGNhc0ZSdnZNMUk3YUpLM3RVYnR2ZFpBNm5NS3lFT093NGNibFEzQW1a?=
 =?utf-8?B?NjR6OERHSklEWldidmF4d05CMTVtSXh2K29hZnlNdjdSSmRVcDBxYXpmYUhk?=
 =?utf-8?B?RSt3Yk56V2tyWGs1YStoSWllS1JKU0FEaHV6WG5lTmxLaGMrUisrMnpBb0U1?=
 =?utf-8?B?d1AvYXB6T0VBQ1RtQm03OTM5VktFcXJOREVaTlk0alRqajhaTi94T1Jra3E5?=
 =?utf-8?B?ZEN6UFZjclJBOWJCVjdOb3J5dlNhNTlXNE00RlNIcW5hcXNYTjF0bmxuWTBT?=
 =?utf-8?B?RHhmb2piNEtxV2MwNzlPZ240Rmt4cDBzaURlVFd2Y1l5OTFxdHY4VUNjbHlZ?=
 =?utf-8?B?SXRqRDVUcWhmNWJNMnUwLzZsYU16eHdZMkl4dkRPajdnWEtNdnRIN2QwZFRF?=
 =?utf-8?B?RFRrbVp5dGs2SGRuaUkvUGVsNjRUQTAxaTFyN1FNLzExVFphck1raHh1bXE5?=
 =?utf-8?B?c0ZveS9PcU56UVFJTFhsNEVsLzFaR0puOXNyTUhCMWNNM2RQNCtiS1l2Y01O?=
 =?utf-8?B?bzZGT0dZYnMzTjJuNGJLUmdMZEN3bDl2SE5LcHdnYm8vZHJpcjU4U2dPelIy?=
 =?utf-8?B?YzhmZlhpMGNjTXNTK0t6N1VmMEpIcWVROTlqalAyNnZYSURpK2ZwUzFJU1FU?=
 =?utf-8?B?Q21NZEhIeWM4Z050N0dvVTJ3Ui9yUUpkTU84a0NZNUx3NVAzTHJBSTVva3M3?=
 =?utf-8?B?MHNSTDBzM2tEQkhMcURUUUxpM05vVVFDYm94Mkx2aU4rRTQrOVdBV3o1ZTU1?=
 =?utf-8?B?ekdTVzZUS3doKzJLdUdaNW9jWVl0d0s0aTR4U0ptWGFURFpKOHl3UG9BMmZB?=
 =?utf-8?B?SkVqcitjRUJYNVR4MEQybnhhTithbm8zalhXS042SjM1b2FBUGtMaUxSUFNC?=
 =?utf-8?B?WWZnZjBLRERVeHJ1amZEUjRtREV6Q3ZoQ1NQZFBoZlhnVzN1WkR1bWw1T0lH?=
 =?utf-8?B?YmhIVTNEOGZpRmpDS2pTRW5aRGNMN083WTZBSUEzVXZmZE9nWG5BOFJ3L0Nr?=
 =?utf-8?B?TUdZSlBHWjRURzhuUUZHMHgzMlgxNi9mTG9TK0lCMzRTV3RtK0M4SHFWZHE5?=
 =?utf-8?B?d3BrM3FvVXpNRFVEb2VUVG1oYU1uN0g4SVdFUXN2dFJzYXBOU3FsQWNhLzJh?=
 =?utf-8?B?d1NCTTlicXhNN0J0Ui9CVkhmV0JZTm1sYm9La3Z6M1RYSHdTWG9ING1iTy9B?=
 =?utf-8?B?SU9tVkkzbzdFeWhZODJFMjNVOWt4cmZrUU5yS0tRaTJwaEFxb1Y5VEwraE1Q?=
 =?utf-8?B?eHpBSW5hWStxQlVHUld6RjdEWW9nSTJvZG5DcGxSaWI5ZkNRbzhHVU92YXN6?=
 =?utf-8?B?aTUrc2NDWmpyOHB3Mkl5ZWlSOUpsRnhDMlNuaTc3cHJ3UCtCbjRvRW9OdEFX?=
 =?utf-8?B?L1Zpb2xWS1QxRHlrYjNOa0l6dXRGRmEvL0N3NENFdnlaSG1iOGl3aUdQZ2tB?=
 =?utf-8?B?eXNKeFRoOC9aRGtCdFVMMEpCSUtWL05Idi9zckNBQUlNNjd5MzdLNHB5NTVp?=
 =?utf-8?B?Zmh5V1RLeUlZaXpYL3FrZ1RZTFRCS0JYQ3M3TXl5K1VTR09yY2RCb1hkdmJv?=
 =?utf-8?B?Z01OczFqZysxMVMzRkdPWnFSRFk1ejkzU2doVUt6SEg5Qk8zcTJtSG9lV3NT?=
 =?utf-8?B?NU4rUEpnSkxxUGRJWXlmQ1ZtNnhKKzVwWWZHYnR6ZTgyVGZ6V3g0aVBqdlBl?=
 =?utf-8?B?YmNaakRMamZ6M3M0K0x4Nk5TcTZ1c1Z4K2YySGpDUEdKcjNQZlJ4NWlWNlVM?=
 =?utf-8?B?SzB6SXFGdkU1T2Qvdnp1T3pUb3FOdis3V2FKbUdtaEs2TTJSY25OTmRKZDJq?=
 =?utf-8?Q?87BsfdDjBuw5qG2xW7VMXWp9l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N39hvcgjqbKrlwksykC4FaKMAddf4SKPP+Dk4GryLwI1MTm/vuhlUXyRdJ2QXjllzszPGPZsOcA8nWCGLQYgvFP49C5KtwckmA4gmdgbsO92eOYwOsGHsiilod7y6Nu7yKi/grMjRHGOl9nML9h2lQ3yAlTxeqvmTm7LgGqz+JdCCSFzDvyY6JkF9K9W0sU6ZtikimEqF92kMK6m+1tUKeL6AKqmAjP6+nQNixnO5MqHjedbxospSNSdxqUrVTtE+k3uIuVufcHBWe+AbzAvrSb+ifmuGaFRboKlTJfE547uZw40HQtW5Kh9hPcwyf1lDKYV0qJbSE8yLjRP4CHUkns6EQdEBEXPULC6SdFJcBpWKXT0XbboSPnK15zs+/HyGG0IRRLiXdFZkBY1+5ChGi6pLeF6vfBuUAy4vGgmL7Nfoi8QLtAEfK9hbiVLwndM8swkmXwNT+THkJBqA5MWrihPKM41WY+uVRmO8QGHc9cYOeCo6UK3cFca7oC5PCTH7ejS6t45eZomo1KhzUxc4hFt90srT/5WnRlYEAJ414z6DA9sbOMRgYmQLzaJTQ8KhwXtcOPm4541NDyr5A6Eq8ZGdfrniOgPBrTOzehbC7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dcb3ad-af48-47ca-6612-08dcace13da1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 19:37:38.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYGdxVzhq610O3OiyAKckkDhGa1UZAQqiTFk0bLqGc15nHL0W6QkE/uHvxe4fhmBxgWh5q2PWYjjDFgnySnP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_19,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=792 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407250133
X-Proofpoint-GUID: cOlISm3LXWof7uCm2CY6RkSbfl0cV21c
X-Proofpoint-ORIG-GUID: cOlISm3LXWof7uCm2CY6RkSbfl0cV21c

Hi Stanislav,

I have a question about the placement of tcp_bpf_rtt() call in
tcp_rtt_estimator(). Why is the call made before the assignment

tp->srtt_us = max(1U, srtt);

How is the attached eBPF program suppose the get the new value?

Thanks,

Shoaib

