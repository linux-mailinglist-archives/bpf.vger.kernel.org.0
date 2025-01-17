Return-Path: <bpf+bounces-49164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A647BA14B3E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 09:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575B73A438C
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123B1F8692;
	Fri, 17 Jan 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHD3vHxr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZE01xI/u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD61F7918
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102868; cv=fail; b=txSkQRn+PnRHcVhitjaj10vFCQnfL1vFye1vL60w8moSQDgCUmD4jb4B4HzHO8tVf+q5YPs2jy16Hr6e0NFqbj6S5xKckNeBQcsCddhj4c2LNy05v7EokrdAbQzY3nHutrQjza1PE8erL7lZp70l6O8RQ47PzhfWzhV3xUgdiNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102868; c=relaxed/simple;
	bh=/AKXFSl/P7DCq5yaTcE4xViIWgy3z47H/LJmYvqEBSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNOW26SPOVeRsTP4mGXIpa4pPfRdm1t7h3BS7D1I1+QAz/qBKiciiYVS6444YNrkIAN4qlVKTcCM1uBXhsuNz/hmhcge04s1CcHBeYhOST7vRK5+GYf7IG3YdVPEFKiiPqdq2BF0CfaDsvymMmAOSBs8ng5n3ObeswbNRuq0Qj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHD3vHxr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZE01xI/u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H5tpcV012638;
	Fri, 17 Jan 2025 08:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G4g02GAPQ7J+2+HPlOD+noblM+0ZPZInvgz85EL88k0=; b=
	PHD3vHxr32MMIGqEaq4O/ESy5kWs0A2n1OroitM+1Qi9xfgBWbi67doJ/KUEqqv2
	TZnki1Nmw/kryKRIKFbFZLOvOuZwK6rCPejkhHVIEGsRC1/OecindH9W7NSMNuSW
	/ipDp0nNxPWayVyU4q4OdHZo8PfQqDsp/2h1eTbCZrIKmZzJL8z4EFrUVMcmnMeJ
	VJjhsLdl42dK9ClyIYg9ZAKgbNkgxAojbDwFARpo2g7J0RMB6pBoaxiC+Hvq+uH0
	X03NlB2xBK7kTvl2NwFbqQYJFJTPdBA8w2g/QPLUsI/QiPw3K14DOOxaa1VAXJ00
	WFUQ2PGtkWWLnoLGg9DpaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7yc3s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 08:33:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50H6U9Tl040330;
	Fri, 17 Jan 2025 08:33:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3bw3su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 08:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbx3JUsR2la0UNM8xAykEk4VmWgqPyMvYky96O+2z5h3YjM4ecGNs6ECIiRPT+xkPXuS73EFtx4/q9I0uc80FPrQQ/+vkrfHyrQNwyv5kPe7ngrPhU6yZHEpe36uVbP/FIK4sv9Jeneg0a4Si43O2cRKNaAb2CGaBZVpFBAMyWfpbC0WR+RX9G+RzHly1ZpEtBbZUT2HocMtP7RZTa91pPSFANCPmLFkgYcZ/mmrH6jEWFtQm+yl6Fwb7OYlC+hkvjf8ZMuhsbNqWkOMwpq6Bumixs2ezDL/cldSUZXcPTXxRzh5NA/6bv8e80/ZTZ6FtgEvsIwh1qFgWGnudp+4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4g02GAPQ7J+2+HPlOD+noblM+0ZPZInvgz85EL88k0=;
 b=tloztca2x/yVMzMZRtlNYrqcU+kpYmoVN8ZqH5pICxIdSjysA1aVk3Q4HtSbvhmN1t8eBdL9+a3B3zOzDZJ7IC1GgeNzfRC3T8CfQDyoy3XDR2Hq5f8/lA0R1rJ4qiFkLC4i3/x6Mp5pcz69zQ8MvkIxGuJLRrzlVRiTS0mpPhBLWmMi3wZ1oodEnUjMpfnbUHnI2lTw7JT7HlmYklQV0WF/p5rG53ckjADPOMrZ7mGJXr3NKWAOA3FGFfkWM+qyN9MsHhvpqA495gqjqG0Kaenk5CfvsKBS9D32RitOHMsYy7kcHYCrH14WCL7pU9DHf1qplEMbUZWT4SpwMKOvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4g02GAPQ7J+2+HPlOD+noblM+0ZPZInvgz85EL88k0=;
 b=ZE01xI/uCVAkI5LBwNKSBqRj1yYZdMm6VhN6jfAeOl+3jN7vry/dGpjvDf11tFeYmbcYd36uMeBnH/6xg4L+Nm0Sp3Lg1wmKZ0YlMj4JgW+ZCkFiBh+Y89mEJ/UcqupqCb5UTQ9iZ3Hld25D90IRn8esAHFArJUJjv57bTcTDBA=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 08:33:43 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 08:33:43 +0000
Message-ID: <9492b728-ce7c-41bd-b954-6981bf639438@oracle.com>
Date: Fri, 17 Jan 2025 08:33:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust <david.faust@oracle.com>,
        Andrew Pinski <pinskia@gmail.com>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
 <877c6uqpir.fsf@oracle.com>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <877c6uqpir.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BY5PR10MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f4333b-b88d-4994-ab75-08dd36d1a6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWt0OWx2aWJOQk1DaGo5RG1MRjBtSEVic0E5L1h3c1J3L1pKZFF3WmlLNEhV?=
 =?utf-8?B?OWtzV2J2L3ZGNUdUZHJmRy8zTmpHMmxEOVZLa3pQZHRRSWthbjV3SG91cjZ6?=
 =?utf-8?B?ejgrZTJZdEh1VlRYeEluZW5RbDh1YUNWZXhiVXNpVENKY1BucUxPUm80UXNp?=
 =?utf-8?B?VkpKOFMvQ3dINEtTVHFLdGlFTk1Ka243UDBHQmxvTnB2NmU5elF0czB4NjRX?=
 =?utf-8?B?ZDVzVEh1bWJjSEZMbnkweGpiWXY5WG4rYmgrcDIzYkpZdisxbzFaODN6bklr?=
 =?utf-8?B?R2VhUFFqQ04xc01XbHJZM2ZVYkZOaERLRVVVOHY0U3F2eS9rMms0TTVZTjN3?=
 =?utf-8?B?V29BNFJvbXlqd0F3UGZmNzVKL1krVTE0QUhQamNCU0tDcGpIZ0ttcFNlZHJU?=
 =?utf-8?B?RDBORFpseFdaT0NTT3hzaXRLeDRRNVdjNnY4K3ZuRlg1U2pCUlpqVzNYN2pa?=
 =?utf-8?B?OEVseng4WkwwWFJCNFFaVnl6czFPaEtDUFhieEV2VWk2K3ZFcnI5S1Y1TUIw?=
 =?utf-8?B?bGNudzE2QS9lN0hWV3R5dGNLRDdDYzlJRHN0SFNBN29UNXVGQ3ZsUGIwRUxV?=
 =?utf-8?B?cUVmM2dtSW5MWnlXVGxYMExEa3g5c3FXa0N2dWxtQ001eHYzN3NUU2MxYmdj?=
 =?utf-8?B?aVNMQ1FmVUJjOVFwZ2p4aWdrOGlSK0hEdzhUSEJCV1h3M2dkZzZXS1JFeFE2?=
 =?utf-8?B?LzdSQVdZVHdZdGZDSjhoK3p0UVljNzNyOC85M05qZkdTaHpaTWRuMzYvZlBv?=
 =?utf-8?B?UGRrWCtqRjNESmUxSU5xNG9SekdMYkc3QnhZbEhjT1ZCUENhRGhKWjBZM2Rz?=
 =?utf-8?B?TS9QME80a1hwMmphYzNWRmltNUNnRkRkNzNJM2VDOGdqS1JKZCtvempTN3Fv?=
 =?utf-8?B?RWVYVVdQNDV5MHVXNis3NnpBMVgrWGt3cVpKQlFkSUhWd1MzU2NLOUZxQkRv?=
 =?utf-8?B?YW0zVHlnZjZMQTZlVi9hRUlyYWxGRUMzcWpabGRHbzBRb0RtbkcyU3NjVDZZ?=
 =?utf-8?B?R2pCUW5CRG9IbnFwL0NUTzJtSzM5M2JjUlVBNXBzZ2p5ZWpENEk5WWJSYUda?=
 =?utf-8?B?L0ZZdkRRZzZTcDJPYkwvUHpKWmpCODlYMVIvWVVLMnJVb1pBWG5URWd0TWF3?=
 =?utf-8?B?VFZFM1dNREdJakdpd3hiUGcyakdOTTB4amo3cEVEYVlRb0F3NGU1d0NRRFBs?=
 =?utf-8?B?UTQ3YlZmdGNGWUMwQ04rb3hnNjg0UUpDNU1LRERYNS9NdlBHRTlrTzY4TTho?=
 =?utf-8?B?Vmd5ZkphT1JCeGw2TXVPbUsrdG51SVBuQzVVT291eUtiblBjTjRxTjJGM3p1?=
 =?utf-8?B?VVBWNlVlaEE4bGRRU0F2ZjdnaDRzdXk5VS9rN2loQkZ4Mm10SFpnQTl4ay94?=
 =?utf-8?B?a01YSjhhTTlhMHBNWER5c1lQc01STitTQk1NUWZ4RFJoT2sreEJFK2VvQkVN?=
 =?utf-8?B?d2lUWEl6TTV6NTN0STlGK2ROWS9DNDU0ZE00cEZxLzJnTkczOTZyamkwTUli?=
 =?utf-8?B?cHd1Ty8xZGxkQlZQQmU5VEhscUh0Rm9jZkRYYXIzQ0RCUGFzaXNSQzRJQ3F0?=
 =?utf-8?B?a01UWHYvWUl2SitZWTQ4d0V5dndyUEMxek9kdzB5MmdwV3JmeEFmQXdPRkdV?=
 =?utf-8?B?TjVJSHQ5SzhPNDUxVUI5U1V0RGwyeHpyM1FZYXdlODM5N0NSRTNWbTJkeFBK?=
 =?utf-8?B?UkNYN3NZVEIwYXFUUjUra2t6aUc1V3JIOWZNYlNZNTc1SjVHNjllWDZBd1pD?=
 =?utf-8?B?OENxS1pEb2hVZExZMDQxbjFra1hnS2xQTlR3RjZQbnNrbm51TDRkT1FtSFJY?=
 =?utf-8?B?ZVRhaHNoMkJaVFQzcmRVODFrUm9ReVVjbTFscHJtUmxmTkpRbXhHRmd0M1Ny?=
 =?utf-8?B?RWgwK1d6YlV4QnloZnVoa284QVNVeldWU25pcjZsS2V4TFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZwMlYvQ2tNOTMxWVNjNVdvNHUzMWNxYlhCS21MSjZjWTlqbnFGb3RNLzJ6?=
 =?utf-8?B?bkdBVFBObG0ybkczdGRKUlNPOGtHVzZoR1Ewc0didGRZODFWQTVESkdPbHZB?=
 =?utf-8?B?d0hTb3Izc3M1bXpJZUhOa2lnM0hRdUlrR2VseGJSMHYvaThuWnJJc1F3SklX?=
 =?utf-8?B?alVkV1FqZlBEOVB6TzE0WTB3bENTd0wzdktjajE5cnU1V1piVlQrMWNsbUtm?=
 =?utf-8?B?bVVGTWdrWlh6cCs3OURmR0VKY1NJWTM4VDVQWGNGL1N5MzZqLzRHSHh6OVdL?=
 =?utf-8?B?bG9zRWExQ2IzclNlZ2Fqbm5QWkoxUm9CT2hHbDNMejNCaVNaTzNyS0UrdHY3?=
 =?utf-8?B?N2pCcmFCNFIzdUNOVDZtbHdUV09zTFVmL2lJVGN1T1l5QXVOZU5SMS90anZJ?=
 =?utf-8?B?anRsL1NGK3NzdURscG1nT0hDTGtpVEFUOWtnOWxYZVU4Q1E5UWRTREh1Mjd1?=
 =?utf-8?B?NFc2TVphVlpLM1FMM3BYeWN0YThEU2tyRm1rdHhlallIOE5vK3JkR2ZMZk9M?=
 =?utf-8?B?bFNnUWRlb0tMZVZzMTNWU0Z0U1dKMWtWYU9CU2NCK293eEtTVTRoaU91TExm?=
 =?utf-8?B?alZsK01BOVpRQytkdkN0L05scGJkRzg3R2ZBaVg0ZnBUMWs1RkJqelprc2VM?=
 =?utf-8?B?TG5OYUlGVE54ajVlL2EwSy93cCtINUNiekFodjdMRDcwNWVXa2srT0dHR0VF?=
 =?utf-8?B?dHduOGhzUWV4dVFVOXRPMmVpdGxCRHVvdzhWclpQMDgrUHdvbXJvZXFWa0JG?=
 =?utf-8?B?cXBXS0dsTGdsSzJRcENVNW9YT3g4S3FGZ3dDTjZiZUZDRzU3MEg1RTFnSVQ3?=
 =?utf-8?B?U0w3ekcwT2tqMEFQSmprM0FobjVDL2pkZmV2YVpqR0pCeGJXcCt5OTcvZ3FM?=
 =?utf-8?B?MURjemt6OHk1Z3J3S01NK1oxVjdNbW9YV2lDOCsrMzBESmFVNTR2QzBmOHhY?=
 =?utf-8?B?R3FXaWFROXVIR0hGMGtFeDJ1Lzh5cGVWUzgvcmVWRjgrelF5SDc5S3h0NzRL?=
 =?utf-8?B?K0NYcjhOeFcxc2NRUllzUiszOEJnTGQ4NkZaUU1VUFFGR2R1d1dLS1BhM3Nr?=
 =?utf-8?B?Q1U2NGI0M011RlU1UGMyQi9sQ2xBcVphNk15dzFwOTlEUHJsNHR6M0hYMVB5?=
 =?utf-8?B?aVJha0M3aEpjNlYwR2NOeHhSVnlnTERqVW5mYTd0RzYyaUpJN3NFWmo5R2hD?=
 =?utf-8?B?WUxwNi9xUzY0RllFZ2NMd25nTEpNZW1haE0rZE5HamVaTk5zdmlBSzJxeUQ0?=
 =?utf-8?B?UGloU2kvNC85ZTNOc0FiQjg4aUsrbkhMaUk4TkdHYXQ2T0VNREdvbnJPWm1M?=
 =?utf-8?B?OHRqMEw3QVBYdmFIdGIxV3poV3hSUlhlR1NtbDUrRlE5WWw5bWZLdEs5QnNH?=
 =?utf-8?B?WG9NQThHSFA5RHRGNGJPQ2FBM3lvS2VnRERwYmJ4L0tId0tKUGdqZ0pBazRl?=
 =?utf-8?B?ZE1Lam9oTklPTkhzVnhxblprNXpxd2ZOSFVwOG5vWXEzZ3NYUlRobnoyeXJp?=
 =?utf-8?B?b3lLenFGdDBraWVwZThLaGY0Q1o5NHk0bGNOSldPeHgwWDJXTFgvdDVFUVoy?=
 =?utf-8?B?YmNrY1UxK2JHYjJwVkhsMzBWL2R4dDI2a3VRVmlraTk0MmN1ckR6K3NsMlA4?=
 =?utf-8?B?UWx1bFNxUFAxMlpjSTA4NUJrYllCdldBS3BLMDlWY3FkcWxRU0hSSGlsY2xN?=
 =?utf-8?B?Yk05RGNMbStjckNrVW9wUXh6dHZFQ0dvcnlsTUZsR3pHejc2VEs2b1VveTk3?=
 =?utf-8?B?Qk03WmNsb2J5VkkyNVNSUXJVczNTdGZha2VMbWRDWHV5VU4yQnZqbzN4c1hl?=
 =?utf-8?B?R3NHQWhFdTVtMWlTcmpBelcxR0V3WHI5ajhCSlV4aHRDQWVzYVpSWm5HS3M5?=
 =?utf-8?B?R1A3UXpmRXR2UVYyNEZvTm0xRXBQUWQ5azlqcnphWGpiZ3krVFU5RmZKMWhl?=
 =?utf-8?B?bFVQUE1oL2lzRExjcDQvU1Q0LzdwdE05R0RpOTBqaEdpOEdYM2IyZUtYT0Fa?=
 =?utf-8?B?Wit4RWNmN3NuWkFTSlJVeHlaMzFtUXExcHNtNVhSS3BPQ3JjZlluMUJOWTVs?=
 =?utf-8?B?dVlrMmZvT1M3VjRyTWhtS0o0Tmh6ckVidzFVbi9QbWxtYlNDSlVvdDdQelJo?=
 =?utf-8?B?WlcwTFRIVEhxVTdLSUlwclRIZC9Yc2JkQkxHY1dnY1V3WE95Q3lybG8xb3A5?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GOe7TexPgJBmmJ2zudbL8kWMpn9ixSKweuJYTGo/fyRi54MygQZiEj03b1lhNzqV2hw90A0O926Ic1myTwkWLlkQL0aOaXGNXhy2fkxvlhKq1GPFM6gMx0c5CsQjMEjth2p0eBnRJiwDxCAvLiQq9aCKLAZxv9c7NH75pB5mZMk/i5jrkaDSTXfOQTWathPfglsdTupsf71KOIujgHBT2wq7o4FVXHwafM0lYvAsp7ccw/IxMnpSkI+2Nk6oqWiqeE9BUWU2/0GUTmCAWI0Nw8NPn2YKxC0tYMytAknLCN+ddxY0rrkgDPHt82x8mdliDBhgWyes/Z/h3+ny/c4/kH5y+rBgoOjNQibdmSs08JOgEgV2usT6Ov5A2V1+RoAkxHsnmohoIqtjkZvvvZHmzlSh1gn7ObSP0pJgTweiT7NexHSFkoEcVFlELF7uwJO2nNSzm7A/yr4jaIIaLdmpHOHzGBffb2xCoUPfnRGANt6LO83XRU6aZhW32yrSg+Q9cQ+TcvS4C3yqga4zCOK7npHnICeEtUWUBcih5m4HXe8zkM/WZt8zHrBx41EZvPaTsO1JlwUaQv/XguWNY3DIAkopqb4GNZV0AeUAntuVE3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4333b-b88d-4994-ab75-08dd36d1a6fb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:33:43.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex4l+oAJE0v0TMLzOoHfzZp2Jad7gWQ3yjowp4C1V63+A/8n52TzeW8V0dJVQb5m/iuNu7JcIa1Nul+YA5OQmif2dbraqYRuzmSNdManaVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501170067
X-Proofpoint-ORIG-GUID: rZ4eZbgushrmzMLGRiuYGltjSGGq8FBw
X-Proofpoint-GUID: rZ4eZbgushrmzMLGRiuYGltjSGGq8FBw

I remind that just as bad as the decl_tags it also misses a solution to 
the attribute ((preserve_access_index)).
Something like #pragma clang push/pop is not viable in GCC.

Jose proposed the patch in:
  
https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/

Maybe you could accept his patch in the meanwhile, and work on the 
intended improvements later. It would be passing more tests then roughly 
half.

Thanks

> 
> Thank you for getting this up and running!
> 
>> Hi everyone.
>>
>> GCC BPF support in BPF CI has been landed.
>>
>> The BPF CI dashboard is here:
>> https://github.com/kernel-patches/bpf/actions/workflows/test.yml
>>
>> A summary of what happens on CI (relevant to GCC BPF):
>>    * Linux Kernel is built on a target source revision
>>    * Latest snapshots of GCC 15 and binutils are downloaded
>>      * GCC BPF compiler is built and cached
>>    * selftests/bpf test runners are built with BPF_GCC variable set
>>      * BPF_GCC triggers a build of test_progs-bpf_gcc runner
>>      * The runner contains BPF binaries produced by GCC BPF
>>    * In a separate job, test_progs-bpf_gcc is executed within qemu
>>      against the target kernel
>>
>> GCC BPF is only tested on x86_64.
>>
>> On x86_64 we test the following toolchains for building the kernel and
>> test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.
>>
>> An example of successful test run (you have to login to github to see
>> the logs):
>> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/35736973856
>>
>> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.
>>
>> Effective BPF selftests denylist for GCC BPF is located here:
>> https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>>
>> When a patch is submitted to BPF, normally a corresponding PR for
>> kernel-patches/bpf github repo is automatically created to trigger a
>> BPF CI run for this change. PRs opened manually will do that too, and
>> this can be used to test patches before submission.
>>
>> Since the CI automatically pulls latest GCC snapshot, a change in GCC
>> can potentially cause CI failures unrelated to Linux changes being
>> tested. This is not the only dependency like that, of course.
>>
>> In such situations, a change is usually made in CI code to mitigate
>> the failure in order to unblock the pipeline for patches. If that
>> happens with GCC, someone (most likely me) will have to reach out to
>> GCC team. I guess gcc@gcc.gnu.org would be the default point of
>> contact, but if there are specific people who should be notified
>> please let me know.


