Return-Path: <bpf+bounces-46744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD59EFEB2
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D38B287658
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 21:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87D1D9A63;
	Thu, 12 Dec 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKFKs2ZL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+rAoLRU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DC2F2F;
	Thu, 12 Dec 2024 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040202; cv=fail; b=ctBe3PmYN+y3kmkHaCIKc8EnXFpE7QmxmXPs6jPsVcGAWKAyqQN9Bw/rYInKx122eJa+2h4OOMAtEIREfoH0ORazs+uXZySC2t39NV0YoPlvAuDEcFTExmbdF0Jj6b6K93jiURdJMusT6JjkhWOBXQXxdN9o2yMS3UldCK+C8Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040202; c=relaxed/simple;
	bh=pyPMddn0eENSeccR2Pw1/xiEeqcLGGb/XsKAG0PADLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=CSWgS/3vvWOjg9r+f+Q1WU5rk1nDe1CCTh0hO8pc2ddFSiRLJRpEW9s2JEZ8qxTcfLiBDjfA21ejcJo9+V1aTLXQFBULCE9Av5mrWiJzAdvfiUu0WoTgkr7iA7x9/TiLpTZgqX58D0lhlt59MyMtxfYbg2N5Ro8riIWvbpfeHcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YKFKs2ZL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+rAoLRU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCLjwSX002524;
	Thu, 12 Dec 2024 21:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A6NakWSAF3/53SVmJPMNWhCEdizR2swmygZpjgPbFYw=; b=
	YKFKs2ZLefB+lJkQMi4S5uao0vn7fTaajQV10eSVWNl5O3Pz99BRBKUt2Zu5vhTT
	w98MbiMGCvnOYaNVLZSkH+H/piW6hn/c/veNqFj+NSlPfOEJsbmTbkO+N69s212Z
	UH0MhKGBjo/RxEzkq9Yrom176GrRxdMcITVo/bx7jJ1locFvmESx9P8QMWJcecET
	1VffoT1oIh4MChFXwWrj1V1BayUcBBVJ9bLLT6gxjMuZZOqfKjg5DYwDKSQHjmwm
	iTZN1BVJhKMYs/6OGbIt7Ze/e1T9Wddz24cemGh/9mFds1hKvOhDOkZxuihYhj/U
	AK/rA7PtS/fjUwbUHBTeyQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewtcbh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:49:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCKGVZY036233;
	Thu, 12 Dec 2024 21:49:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc0sn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guIXAM9kU0vuJf60omKrzFvLUDdr6FzCkZ5UzSpaJCxGL0dk/+dFKo4p2GtdYLp1pd+/DNZF0/cu4GzfYcXh9IYS9QTJCUY6SkC3FLkzZaq7JLBhOMOwCDFjO+WBTVZQweu59hXdix3lfUAK7zeHUVJs/ABuXObCe/FikC4HiSEthyL5Vei7ogmQ5b0zWQnSN8FbZkSCNYY7LQJDIFXU8TXqkOhMjz38ZIqLMQf03pICsiyrg7e5fVS5gg6rD6UO8tZmiWY9ElcduUO/h/XFeQ2Z+rNDohVgRnMOpwlHcvkLTO+lcUKgNGZK4FCnTFaQ6eK/dZvlPZBgD3Vk/P4TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6NakWSAF3/53SVmJPMNWhCEdizR2swmygZpjgPbFYw=;
 b=DU3sVzZFTmn+5bWp0Q/eV0Ahy4ySdx9ydF2JRhtxIcqqDzvOo5Nqar4F0BRW72ghpPWHelX6KmqpOz2F7lYPvRdpAVc16mBebfVg1Yn13qwLKbA+HTCVrKIW9XGKU6y73G1SeJs9ZcBnQ7eelB0CrGLsDGsU3HIhWw1ayj11bDmsmsVJcfBeVeIqLUvJ/PZh3jEAox8Ck9/kevyaLsBFJn8k54tdsUO8P0240zgMWZZ0aMvvKtJA4/9c1QkoW0Qn/D2D07GkkJS2tMfgM5JrwfGvfvIrBrny0N7jWsnwpp+LSamZcow2818deefT6/ri7DiDZg0DgPlYh+yJ6DU+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6NakWSAF3/53SVmJPMNWhCEdizR2swmygZpjgPbFYw=;
 b=e+rAoLRUWkSh/T0tJP8bneMIkUfxaf3bk2LGYAcakQMygRGj8CjsvLFEjGHlrTU2nVjZxKAqSeaRzTmLf+783AXKOCrGY/F0k8Rtz91G54pnzjL4MorVhhlqptk4PZLZf227D5XajeEUofTqh2W/hGuLf5s4+2yT7tWP5Z673ic=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:49:54 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 21:49:53 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, alan.maguire@oracle.com,
        bpf@vger.kernel.org, chrome-platform@lists.linux.dev,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on
In-Reply-To: <Z1qrVu2Pv6qXI9tD@krava>
References: <Z1LvfndLE1t1v995@krava>
 <20241210135501.251505-1-laura.nao@collabora.com> <Z1n_wGj0CGjh_gLP@krava>
 <Z1qrVu2Pv6qXI9tD@krava>
Date: Thu, 12 Dec 2024 13:49:51 -0800
Message-ID: <87zfl0mv0g.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN1PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:408:e3::24) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b840872-3452-4817-af8d-08dd1af6e959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym5PMEJEeWxFb1RkajBRY1BxWG5qeWMyemVQTmxLazBsWlBVSXVOOTlGd0s0?=
 =?utf-8?B?aE1McWVlRWFBMnZmeUgyT3RVMThlUWIxclB2RmpZOXhsSU5JOGlYV1crbDh6?=
 =?utf-8?B?aFBBRkNwc3REVTZqbHJRb2NhV3RsbjZZanFDTjRsbDkzRWhVZysvdkVCc3M0?=
 =?utf-8?B?REZ0WDRqRUF2V29sR21NakE5Z2dpeU1MeDR5Rkh2OEFJV1A5b1kxRUFtaXkv?=
 =?utf-8?B?K0Z6L0pINlRYL1dtZHFhOEJCcEZHZXExZnI0VXdWVERudlJ6MmpNUTZyVHo5?=
 =?utf-8?B?emZkZVFLSHF0Mm9LWmFMbjNML1hmUlNCOEZXWlNkeHhKK3dUYkw2aFZ2dElE?=
 =?utf-8?B?SUF1UVo5YW5NNjhaVGZUUDlmZWVEanU1aHkwWTdJaUw1eTdVY1l4eURUa0h0?=
 =?utf-8?B?bExnakQxTEZXUlJtTlY1dlpnVzhJdUZxR1kyeFlnekRjd09RNTJMdnhBZElH?=
 =?utf-8?B?VnJ5dXJyNk9vKzVidmpQODZSSW5aZkh5dVBQT1pJSklyeVNtSU0vQjArckVC?=
 =?utf-8?B?aFNnVkpXcnF6UC9uN3NkTHdXSnIwMWJZTS9oTVdCdEZNWTlXaGxvYmpSRHBt?=
 =?utf-8?B?Z0MvYng1TDZDS0QrNDYxWUpuOWhpL3NLRGlYL1lWVjlsaUcxbWs0UllLVFhx?=
 =?utf-8?B?K3QrVzdiOU5iZnZHTEVaL2tyaExDcVVxVEZoNmNkbi9BcFNxRDZnQkFhaEx1?=
 =?utf-8?B?WEk4Zm5aMHZSOFF6ZmVWYjlDTXdGbFduQzR1dlNwdHlQdDhZUjVzRTBpcnFx?=
 =?utf-8?B?YWtHOTFySSszNm9oRFpOYllNbEQzVDNxcHFBNWgwU0dnV1kybm8xK0x4RVBZ?=
 =?utf-8?B?NHZ4SW4vWTBrUjdHclhyMWVyT2VKS3JHa1F1eVZOdkZ2WEI0Um51d0ZiRnNY?=
 =?utf-8?B?U3huZ2I2NklET3VUWmEvbG1yU2dTR2o2N0dsQlJqVzd1MEJnNzZqNkNCb0RX?=
 =?utf-8?B?aWI1bElQd0puYnBhK1M1VkZyci8vRlJrRGI1QnJCODRLZ25TNERQOTRjN25K?=
 =?utf-8?B?TVI3U2x3YXlZN2ZXajVuYnNwblBQU2dibTM1NERVVnVKRG84VWt3c3loTXc0?=
 =?utf-8?B?TG1pMkNYdDRlbjRwVnBwZG9zbzJhc1dBUFdHSkpCMUdhbDBCNWpjbHNCeHha?=
 =?utf-8?B?bFovTTd6cDdRemJlQVZVaFZjNjhiUjBZcDZTTDBxZUExdlA5UmJmMjRqVEcy?=
 =?utf-8?B?OE10elZRay8rOTZHK3IxMUo3NFhScTIxV05ER0R3WWVrSE9PMGFlcDFKUVhM?=
 =?utf-8?B?MDBYNjNocU84ak83YjBtMjRkY0pSK0NidXJxSVp0YmlyTFIrcTQxU3lRZGhq?=
 =?utf-8?B?dDl6eks1c0IveHU1MmViaU9UNFFVOTI3b2RTV3IzUy9xL01hZTZ3cDhGK1M2?=
 =?utf-8?B?QlJkem9uM3hWSERpRmlBNmNhYXJmRDhwVk5zMjNVdU1Jd3hiZ1hadEdEVnl6?=
 =?utf-8?B?ZUpMbDVNM0lJNjgzRHNrQ2ExTzlPTjJNNCtnNXp4c25namNqNzFGVHk5NlZW?=
 =?utf-8?B?WElWK2RGbEp0NEtHWGdMZ2hnWkxHQlB6bjRISzJuckxhR1FhRDl3akpicTdQ?=
 =?utf-8?B?K3RrdzlJSEdSUytqWFNMSlBHaThBWTJmSG5jWjNtVXBPS05jNkE3YXoyaVZF?=
 =?utf-8?B?eUE2alpueldJMkdOamJIb0E3R2w0dC8xejZpUlYzSUk4eVJiZm9KaldscW5s?=
 =?utf-8?B?NFRMcEFpS01DL0FDRnRCWEg1K2VPckJKYS9ta2MwZjViUUpGT2c1dC91VHk4?=
 =?utf-8?B?UFNvekovL1lFMThLcHBEMk9uVXBhaDR6Z24vSmk5RjVkUWtRYi9reTFwdVV3?=
 =?utf-8?B?dHJDeEJkUzlLYzQ1cmFOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJDRkhzdUE1OEFabmxIbzBwb0dGdlpoQnJ6MXdFbGVoZlNTWVpjVmZZSTZk?=
 =?utf-8?B?L3lITUxMZlJCNDV3Z0RBdTFxczJETlRFRmtYajcxMWlZdE4xWE1jdjJGWlF0?=
 =?utf-8?B?SUVsNkNFZVRQbFJFREkzWWdaUExnbWk3bXB6NnRhTHBiUGlkaU12VHZvK3Fm?=
 =?utf-8?B?cE1uU3cvWGJlS1lXVHQ1c1FxZlE2UnMzYVl5UDVBRVNHUTIwc3ZwUjErTzdJ?=
 =?utf-8?B?T3BWZkZYNHltbEpCYis2Yit3RzloU2NvRks2STVjVWZ2SDNNV2ZHNjVNcy9H?=
 =?utf-8?B?MVhqUkVzRklJOEV3QXV4eE5OZW1XZWUyVHBYNk82citzTjVpdEZCRW1IYURk?=
 =?utf-8?B?TUdkUjdCMWNJVkYzWGZCVmNNZjlTeWJld1orTU5wZC9mS0VlU2lFWS9rTDN6?=
 =?utf-8?B?WHY3ZEI1YStuSUV6V3lvSWJlU1NDQzJYalJJUDl3S3VkN3hDUXdQazVPRE1u?=
 =?utf-8?B?bEhIWTFnWjY1KzZLTVdvOFJhL3ZPUWpMWFlKT2ZBcWYxV29PVHoyNjZTbjdC?=
 =?utf-8?B?WlRiQmtIOWJoZXBXazV1VXZxSUJMU2pEckF1ak8rc2F4OVNMcmorMEZobWds?=
 =?utf-8?B?YUY0Vk1CdGV2NDBqcFJaTDhlWXVMcDFmUUt5KzlCN0lucE5sektlMkFvRHJE?=
 =?utf-8?B?RlRJSkFIU1l1QTAzQXd4TjhSQVJOeGFFazRpWVhwaG5TWi91ak0xMi9iWVNN?=
 =?utf-8?B?Vm5USEhQOEhPU0RXL2laVDRHMXNCeDUyY1BZVGs2QWRobG1mZk5jV3U1MFFY?=
 =?utf-8?B?Zi9iZSt3RWExVXM4UkhvaTBDVmFZVGlSM2Q2QjUvZ2JkZnJKYy9CRk9aQUdn?=
 =?utf-8?B?dFZRY2FYejRoa1MxWkUwQktMT3BrdEdpczZGSGNKTWprV1cyK3hYNUkyOFhS?=
 =?utf-8?B?THJYYkQ5NHkyZTV5akhsaXl6SEpBZ2pZb05OQkY3enY3RW1XZHJRVDNXODhJ?=
 =?utf-8?B?WVJ2K1hraHZEbXZ1eFZib0hndDhpa0ZoS3k2TmRlcEQ0ZDNZOG44T0MwNE4v?=
 =?utf-8?B?MXI3UXpuSG1ZQ2d3YWRsRkpoRTR1ZHdOUS9ISHlKZGVmQmVDRFFRZENhMEx5?=
 =?utf-8?B?TkFRM0w4QzJIWnltNnBPNDBpbUNCcVNkRlhuVmhVdkliamhLWEJOL1ZkaFgv?=
 =?utf-8?B?dURVUTNHQUpYY2Vpc0l4T0pTdUVuUHZua3R1ZUpXc05HdlpaOHorUmI5ZkZN?=
 =?utf-8?B?WVRhbE9OU1IwaDNFVjhVYzJPc01YOFRrZnJEWlBMUHg0dWphUllhVFhGOE90?=
 =?utf-8?B?ZVFoekVFU1JaTUhOdzZVUUNlVFJtOFdJdkhMT2YrbXl3Rm9DQTE2SWYvSEhm?=
 =?utf-8?B?ek9zeTc1NHBDeVJ2RmtvdDYvVTkrZjUrVFVOdktMVU1NR2hyUGZadC8zTU9I?=
 =?utf-8?B?SDlxNTU5UCtHT1B3NmVaUmg2OGZTakRzZEJJQVkvMEVUUkFHWWtuTEpXaWVp?=
 =?utf-8?B?ZE9OMnN0QzVRM2NFTXVhWklyckRMWmd0TnNBUXh0NUVud3QrUHY2OTdsTTZv?=
 =?utf-8?B?d3czUmJ5VCs1MjRNZFAxMDZ5WEJQb2V2NHFxdVA3VjNkdEowNlJUVWV5eWsy?=
 =?utf-8?B?emV3ZkFibEQ5Q2xYS0FmbWJTWVFTU0ptaVdUbXJuNEYreHdjZEVwcnF3eDhw?=
 =?utf-8?B?cHFsWFJYNVllaG1FODlIU1R2djFtOERGMS9FMzRuVzA4NFcreW5mTUN1YjJo?=
 =?utf-8?B?eDN2TitpcHZNVUVKUFlmdWNHR2NaaFRzWk1HZHAxWlNCWE9OYkwrR1VCOEN4?=
 =?utf-8?B?NHNkeVRIeTVSQmNyTkJ0ZWZ2NmRWdFBDb2JIVFl4SUtvaFNCa2JqQ1pDc05X?=
 =?utf-8?B?Y0tHS3dPS1FFcDRJbDAvUTVXWEkxdFIyd1UwNTF5ZTJlLzJ3aGhtVzg2S3dE?=
 =?utf-8?B?Q3NBVG9WVHVKMjJMdVJOSFQ0aVRHWHIrdisyQ2RHekhoQTNWRmRYUm8xNDhh?=
 =?utf-8?B?T3BrY25kK2pXSEE2UGFlRHg1dG1mMi8rd3Foa2V0ZGczL2k4YzBXSjJud0Y1?=
 =?utf-8?B?ZHFqcVFkRzFHVnhEZ1pRdzVBdURvdkYyVkJkZm50RzcrK0gzMFNrL0dnOEsr?=
 =?utf-8?B?RUM2T3ZxU0plTENmYUNLR1JkQW9ta24yU1B4S3JpMGtrcTBKMWMvSzZyVTNT?=
 =?utf-8?B?Q05NTjNHVHIvQ1V3UVh5L3BYMEpsSFdFbmtja3ZJWGZXdUNsS3l2dUtSZkNE?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hhA+cSrLw2JzWXnHHz86ZgjQvzK/eV21WXUskb238cHQpWMO0mItOdRnB9D6IUAGY1QlkWp+68s8hWMzeHDGMmvNgUUNIL8yN0CfL6a5mSNbXyyVnfFWsyT9rShCrfEbVdcFCNnr13uP2/z3kDRi7NZ7Rh2QrNy3VtJ9fPg23aX5csfPP5UautGkZxYUpM8l8omOM85zfRTbU+rYQ1riy1Yz5UAUaca5M7tk/1IPqbj2CRFoHhMnrxY2tSQ0YO69LrxCDJaU6HRvZQnYP4/TxjW7J0+iY8qUF8ojBwIWz64Pj9f3fWV7hzFHFQFjbjcZEHdYKH9zqlQ+wkhxKawQAYiMQ8LU+aGKQeOvIQ38mUZDmCZ36rH2txe3nN+plwwq7lqON4vr97SYJXjd5AvETJIgeXF6dkADHNf7UmHOnCAud2ibtn9YS5SWi3IVJ0DY2/Ee/YlMncPmAiCndigT02l+li6HpMVTj7cSVo4isuCZ/ybkNFa1EoWLbNfJVyOCxhU/X97Of2FoA9MjugWK2Dh5hv8YZ9sYThQtjlClq2ahINjs9Hs6uzYfpJEh7cSpJDwsmxAOWDlCMsy2Y2Az9XaKjVdxNjzqIOZhBJdqLi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b840872-3452-4817-af8d-08dd1af6e959
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:49:53.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uVoTGcDOYUc9Zf/mH6CVVUfn5/U6ta5oH3uGNQ9mxCfaubCw1uI/9ltMWVdr0qguICO9pwp9FFvEtxPQ+JDtt/FH0+EAiBrEyNWErWG9/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120158
X-Proofpoint-ORIG-GUID: P55vrvp2vnFig2jffjMKENTzzrYE6UU4
X-Proofpoint-GUID: P55vrvp2vnFig2jffjMKENTzzrYE6UU4

Jiri Olsa <olsajiri@gmail.com> writes:
> On Wed, Dec 11, 2024 at 10:10:24PM +0100, Jiri Olsa wrote:
>> On Tue, Dec 10, 2024 at 02:55:01PM +0100, Laura Nao wrote:
>> > Hi Jiri,
>> >=20
>> > Thanks for the feedback!
>> >=20
>> > On 12/6/24 13:35, Jiri Olsa wrote:
>> > > On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
>> > >> On 11/13/24 10:37, Laura Nao wrote:
>> > >>>
>> > >>> Currently, KernelCI only retains the bzImage, not the vmlinux
>> > >>> binary. The
>> > >>> bzImage can be downloaded from the same link mentioned above by
>> > >>> selecting
>> > >>> 'kernel' from the dropdown menu (modules can also be downloaded th=
e
>> > >>> same
>> > >>> way). I=E2=80=99ll try to replicate the build on my end and share =
the
>> > >>> vmlinux
>> > >>> with DWARF data stripped for convenience.
>> > >>>
>> > >>
>> > >> I managed to reproduce the issue locally and I've uploaded the
>> > >> vmlinux[1]
>> > >> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one o=
f
>> > >> the
>> > >> modules[3] and its btf data[4] extracted with:
>> > >>
>> > >> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko >
>> > >> cros_kbd_led_backlight.ko.raw
>> > >>
>> > >> Looking again at the logs[5], I've noticed the following is reporte=
d:
>> > >>
>> > >> [    0.415885] BPF: 	 type_id=3D115803 offset=3D177920 size=3D1152
>> > >> [    0.416029] BPF:
>> > >> [    0.416083] BPF: Invalid offset
>> > >> [    0.416165] BPF:
>> > >>
>> > >> There are two different definitions of rcu_data in '.data..percpu',
>> > >> one
>> > >> is a struct and the other is an integer:
>> > >>
>> > >> type_id=3D115801 offset=3D177920 size=3D1152 (VAR 'rcu_data')
>> > >> type_id=3D115803 offset=3D177920 size=3D1152 (VAR 'rcu_data')
>> > >>
>> > >> [115801] VAR 'rcu_data' type_id=3D115572, linkage=3Dstatic
>> > >> [115803] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
>> > >>
>> > >> [115572] STRUCT 'rcu_data' size=3D1152 vlen=3D69
>> > >> [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64
>> > >> encoding=3D(none)
>> > >>
>> > >> I assume that's not expected, correct?
>> > >=20
>> > > yes, that seems wrong.. but I can't reproduce with your config
>> > > together with pahole 1.24 .. could you try with latest one?
>> >=20
>> > I just tested next-20241210 with the latest pahole version (1.28 from
>> > the master branch[1]), and the issue does not occur with this version
>> > (I can see only one instance of rcu_data in the BTF data, as expected)=
.
>> >=20
>> > I can confirm that the same kernel revision still exhibits the issue
>> > with pahole 1.24.
>> >=20
>> > If helpful, I can also test versions between 1.24 and 1.28 to identify
>> > which ones work.
>>=20
>> I managed to reproduce finally with gcc-12, but had to use pahole 1.25,
>> 1.24 failed with unknown attribute
>>=20
>> 	[95096] VAR 'rcu_data' type_id=3D94868, linkage=3Dstatic
>> 	[95098] VAR 'rcu_data' type_id=3D4, linkage=3Dstatic
>> 	type_id=3D95096 offset=3D177088 size=3D1152 (VAR 'rcu_data')
>> 	type_id=3D95098 offset=3D177088 size=3D1152 (VAR 'rcu_data')
>
> so for me the difference seems to be using gcc-12 and this commit in linu=
x tree:
>   dabddd687c9e percpu: cast percpu pointer in PERCPU_PTR() via unsigned l=
ong
>
> which adds extra __pcpu_ptr variable into dwarf, and it has the same
> address as the per cpu variable and that confuses pahole
>
> it ends up with adding per cpu variable twice.. one with real type
> (type_id=3D94868) and the other with unsigned long type (type_id=3D4)
>
> however this got fixed in pahole 1.28 commit:
>   47dcb534e253 btf_encoder: Stop indexing symbols for VARs
>
> which filters out __pcpu_ptr variable completely, adding Stephen to the l=
oop

Thanks for sharing this. Your analysis is spot-on, but I can fill in the
details a bit. I just grabbed 6.13-rc2 and built it with gcc 11 and
pahole 1.27, and observed the same issue:

  $ bpftool btf dump file vmlinux | grep "VAR 'rcu_data"
  [4045] VAR 'rcu_data' type_id=3D3962, linkage=3Dstatic
  [4047] VAR 'rcu_data' type_id=3D1, linkage=3Dstatic
          type_id=3D4045 offset=3D196608 size=3D520 (VAR 'rcu_data')
          type_id=3D4047 offset=3D196608 size=3D520 (VAR 'rcu_data')

In pahole 1.27, the (simplified) process for generating variables for
BTF is:

1. Look through the ELF symbol table, and find all symbols whose
addresses are within the percpu section, and add them to a list.

2. Look through the DWARF: for each tag of type DW_TAG_variable,
determine if the variable is "global". If so, and if the address matches
one of the symbols found in Step 1, continue.

3. Except for one special case, pahole doesn't check whether the DWARF
variable's name matches the symbol name. It simply emits a variable
using the name of the symbol from Step 1, and the type information from
Step 2.

The result of this process, in this case, is:

1. kernel/rcu/tree.c contains a declaration of "rcu_data". This results
in an ELF symbol in vmlinux of the same name. Great!

  $ eu-readelf -s vmlinux | grep '\brcu_data\b'
  12319: 0000000000030000    520 OBJECT  LOCAL  DEFAULT       21 rcu_data


2. A DWARF entry is emitted for "rcu_data" which has a matching location
(DW_AT_location has value DW_OP_addr 0x30000, matching the ELF symbol).
So far so good - pahole emits a BTF variable with the expected type.

  $ llvm-dwarfdump --name=3Drcu_data
  ...
  0x01af03f1: DW_TAG_variable
                DW_AT_name        ("rcu_data")
                DW_AT_decl_file   ("/home/stepbren/repos/linux-upstream/ker=
nel/rcu/tree.c")
                DW_AT_decl_line   (80)
                DW_AT_decl_column (8)
                DW_AT_type        (0x01aefb38 "rcu_data")
                DW_AT_alignment   (0x40)
                DW_AT_location    (DW_OP_addr 0x30000)

3. In kernel/rcu/tree.c, we also have the following declaration at line
5227 which uses per_cpu_ptr() on &rcu_data:

5222 void rcutree_migrate_callbacks(int cpu)
5223 {
5224 	unsigned long flags;
5225 	struct rcu_data *my_rdp;
5226 	struct rcu_node *my_rnp;
5227 	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
                               ^^^^^^^^^^^

With the new changes in dabddd687c9e ("percpu: cast percpu pointer in
PERCPU_PTR() via unsigned long"), this expands to a lexical block which
contains a variable named "__pcpu_ptr", of type unsigned long. The
compiler emits the following DW_TAG_variable in the DWARF:

0x01b05d20:         DW_TAG_variable
                      DW_AT_name        ("__pcpu_ptr")
                      DW_AT_decl_file   ("/home/stepbren/repos/linux-upstre=
am/kernel/rcu/tree.c")
                      DW_AT_decl_line   (5227)
                      DW_AT_decl_column (25)
                      DW_AT_type        (0x01adb52e "long unsigned int")
                      DW_AT_location    (DW_OP_addr 0x30000, DW_OP_stack_va=
lue)

Since the DW_AT_location has a DW_OP_addr - pahole understands this to
mean that the variable is located in global memory, and thus has
VSCOPE_GLOBAL. But of course, the actual "scope" of this variable is not
global, it is limited to the lexical block, which is completely hidden
away by the macro. But pahole 1.27 does not consider this, and since the
address matches the "rcu_data" symbol, it emits a variable of type "long
unsigned int" under the name "rcu_data" -- despite the fact that the
DWARF info has a name of "__pcpu_ptr".

The changes I made in 1.28 address this (unintentionally) by:

1. Requiring global variables be both "in the global scope" (i.e. in the
CU-level, rather than any function or other lexical block.
2. Requiring global variables have global memory (some of them could be
register variables, despite having global scope -- e.g.
current_stack_pointer).
3. No longer using the ELF symbol table, and instead using the DWARF
names for variables.

With #1, we would filter this variable. And with #3, even if the
variable were not filtered, we would output (a bunch of) variables with
the correct __pcpu_ptr variable name, which is unhelpful but at least
helps us understand where these things come from.

Rebuilding with GCC 14, we can see that the "__pcpu_ptr" variable no
longer has a DW_AT_location:

0x01afa82f:         DW_TAG_variable
                      DW_AT_name        ("__pcpu_ptr")
                      DW_AT_decl_file   ("/home/stepbren/repos/linux-upstre=
am/kernel/rcu/tree.c")
                      DW_AT_decl_line   (5227)
                      DW_AT_decl_column (25)
                      DW_AT_type        (0x01ad0267 "long unsigned int")

This is the reason that pahole 1.27 now recognizes it as
VSCOPE_OPTIMIZED. Without a memory location pahole can't do anything to
match it against the "rcu_data" variable so nothing is emitted, and we
don't get the issue.

I'm not sure if this adds at all to the discussion, since the overall
answer is the same, an upgrade of pahole and/or gcc. (Pahole would be
recommended; GCC just changed the generated DWARF and I could imagine
other situations popping up elsewhere).


Thanks,
Stephen

> with gcc-14 the __pcpu_ptr variable has VSCOPE_OPTIMIZED scope, so it won=
't
> get into btf even without above pahole fix
>
> I suggest gcc/pahole upgrade ;-)
>
> thanks,
> jirka

