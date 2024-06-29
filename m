Return-Path: <bpf+bounces-33425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3471B91CC01
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C8E1C2141A
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ACC3C092;
	Sat, 29 Jun 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Farnwjd4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3bcDMGc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FD803
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655499; cv=fail; b=nDrNTgzqBnMbHDRyxo5Ac0BC8LQ0L6dqLtuVoxcw/gdTXPW0icfrIKty63y+8V2sLYM42cW80TYEv77U4TQBRswU31FBazgQZreaimvAoh+ybyKhvnZ+dftT58avvuHxY6wekTK3OviUtvC3qJoRb23Gj13ohwlp106epX5sfF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655499; c=relaxed/simple;
	bh=1WSzHDDk6u6n/1/RCMFQ94YIQxSG+STJPLj1uuNqR6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTHPBJp555st5VMa7aNRvlK+IU8h7lCEvR4aPVj7qIBQwW7k5TFSU0wn14OgM+yvza1/pGRTB8IiQZbYzuDFD+EpSirON/JbgcXcQapsUpAvSQRRsm1diMsQzX8gN/aVtMb3w3FWXpA7nJK9ORc8sYriP+hz9ZSbJbpGE3RqC0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Farnwjd4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3bcDMGc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T4vsUw007067;
	Sat, 29 Jun 2024 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=R3qZerV9fxcgaKxHkLE8a3K6zbZ0hb49NQUZziPlviA=; b=
	Farnwjd4gEkX8NlicQ1x+lcDg2U7SIPJKiKKy+jhf2Cv9vG6PqM8ONIv8JqZu+S8
	EHjikXuSj9wBUfyZvSv/pUO8aTI3jg97UR6H1mO+jnOsDy2nA/5jz2aN1oOIM34L
	F90Hk1VLNWNiIRyMSo9gmUZ8cscdXe3yOogr5UjtFJFCyuBo2lwL9wO8P3aEvkEt
	A0qpCQlhGEDlnN0fcO5m8T/wz1+p9WZdXeIBe1P+LJYVbCk9Gf5zplvgyRwB/EW7
	IslETzJCjGYxBQtjr2+MCbPSE1rG6rYcf18ysavpg/6fKiLsSUYGPoSEGzYx3SWC
	WKVDVWjQrqe4PWqgnnzN2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0gavn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 10:04:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45T8nc7q023108;
	Sat, 29 Jun 2024 10:04:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q4q5ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 10:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItGhmPlW2DXilYMbcp1eVfP68bzzByhoFjFc81tWvqMM77lB+rgQ2zpr25Hu9h1O3BcZImT5ZVBY4BBWc11mAhNKDP1+vMw5lFBMamo4TzDf6NcsFkA8o4KFMe3bZPp2Cjp/UWw/Qy2eZzzLWMOWD77YKGQ0yoVIFkKwXd5y3fHG12vBJP1UVfLGxHiLET9kEVd/d/u8ySzWFdgmKUrgmv8zquzY3YsN2h2RQgttfWRb4N1BF1fi/TLRgEx0jMxHesoQUD5/4CDzX7QvZ3geNddELlkPviYjFzXf/IVN00X3DxLAv8josjfsuyTz6cpIAYEgK/gDHFsziG1tKnJw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3qZerV9fxcgaKxHkLE8a3K6zbZ0hb49NQUZziPlviA=;
 b=gFWxfEs4JmU8WneMk0Zm+nFzYOPxD0RT6PmM3k1Z1UwZVcoUYTLxJEi5PBbg9u3eiuO35h0VXmwPAXyZNKvUfKoWXC3Gg3No33yswPPCyigUThpchO3VAQuNFW08Xb0P4HGRS8MILwkn6tT9W5LukfbDjxiEHAKj+8RdPlKYTrezpoMNFWQsf7qnseVebFQrJMDOBZ39MYBIt4GnsDeCdEWy8hZi7cKXUKhm+T5FIoU8CPUf6pbqjhXcMVPPzmkrkYZ2P7k9GmGBFrpN3V8AoxHriHVhVDSyt5CL692sjpjdUd6BqKXIGA1wXL/I+DCsq4gHqi1e4ehPm3BdE09VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3qZerV9fxcgaKxHkLE8a3K6zbZ0hb49NQUZziPlviA=;
 b=J3bcDMGcEegDoFY2ATe9T3dzk8L2LB9It7lcdaJhuJC0oo4Av9bkMRFTKZPOraAwKJLjJdmbAJFmf0vGlBix//A51QUpFXqgi3KEeYyB+TsLUgHERqr+1wwDw6NYF1yV1wc+/jROcPmjjRWizf2ayexE+z8jfw3Y9rUhSfCx0CY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sat, 29 Jun
 2024 10:04:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.022; Sat, 29 Jun 2024
 10:04:28 +0000
Message-ID: <1fd2d7bd-e831-4e4c-89f5-4230f0a71cd6@oracle.com>
Date: Sat, 29 Jun 2024 11:04:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: fix error handling in
 btf__distill_base()
To: andrii@kernel.org, eddyz87@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
References: <20240629100058.2866763-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240629100058.2866763-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f51d1d7-bc5b-42a4-d22e-08dc9822dd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUIrSjFOeXdZTjRHUlBTNExoZXJnTDh4dXFMbFpoMlZEM09lWEFnWC85VFlV?=
 =?utf-8?B?V29ZdU9LM1hRVjViZzg4QXNQdGhiM2hHSkdYckdoMDRoUDlpZFRjczM2REhQ?=
 =?utf-8?B?NHJOQ3loeTZwOHV4VHhoYjhnZ3N6aktia1d4MFMvZ1FZSUNKdzJoRXVPUGxx?=
 =?utf-8?B?d3FQdXZ4SSttV2owSysrKzBwTHVjRGNocHhWV3RVQXdTZFJGQ2VlcGpZWXg4?=
 =?utf-8?B?b2Jrd3gwRWFNRVZiWDRwdzVpRU9YV1VEcWNCdHhqSXJtRXdOQmZVZnhKcFp1?=
 =?utf-8?B?NzE2bVFlNENlY1dDK2d5cnRaMGYxZHNBck9zS2pldDRLRXpoN1NGbUk0cHBP?=
 =?utf-8?B?OS9aMXlzSE9aRm1LS1cxeHdKK1RKMlRtaW10L1N3TW9SblNVQXJtT0NhRys1?=
 =?utf-8?B?aFQwdmE3ejlwVTNQZzNyOUt0RS9vdkY2MVJLYWJtU01lYVFiM2xlcllwVnFH?=
 =?utf-8?B?eWZVY28vQVM1b2dzcGMwK1dLU01xMFhOL0VlQkhub2JhY3hXUGRKbkxyV09Q?=
 =?utf-8?B?UWJISWU1NlVTRFhSd3dVS1BLbHZ1S0RKS1E1NnVYbi9USTJFZDhoNWczNTNV?=
 =?utf-8?B?N0RMWVBTL1NHdmRCb2ZKeFVKdkljYUJXakNnSkd1NHBlSEI0eDZtNlBZOHV4?=
 =?utf-8?B?d0pLOWhzZkN2WkttcXVpeXpSUUVneUpmRmtaRVB3ay9jUzNpUU1MT3pubGg3?=
 =?utf-8?B?U2c4ekF0aU9qR0QrbmxwY09kcXVxR3hobWxiUzA5aVZBbk05SndweHo1NVo4?=
 =?utf-8?B?YVZNVVZweVFzSTByTlZtQ0k5dWp5RFRHOW80YWhmNkpGR1ArMk03aE15Y004?=
 =?utf-8?B?SVZ3dEVkTlRQY2p5RWxFWEVuR0sxWFZVdjJ1Zy9BenlYZUxhQnoxdEVmc3Z2?=
 =?utf-8?B?SEpBQm9oN2o4VFNDZkY3aUtIb1FnUTF1bUlpVElmaGFkVVIzNmYvNzhrbTdV?=
 =?utf-8?B?UGxVWVp6SExsejBweklvb2RuamF0TXliRmZEcVZHZUNlbmZtODk0L2FJTkRh?=
 =?utf-8?B?NmhHQ3VUMmszcDZVTHFsS2p1ZlI2U0RnN1Ara1ZCUFg4Yzg4SmIyMUtWYUpI?=
 =?utf-8?B?LzV6elhhbGYreHlEQlNFYjVBQzV6VkVleHpjZ1VkS1Z4K2JlZWpSam9RWnpq?=
 =?utf-8?B?cmg0MXZPWTZ0aTRyUEUyb0R5V3JhRnVNQ3FMQktLK2gvSjNkQnlHMnVpMHBR?=
 =?utf-8?B?RmNnaVEwUExKZjRFa1FEWkxibmJtT1B1TThKL1c3VXZZWElzUlY5ZjJyVm1F?=
 =?utf-8?B?V0RLSy84V3ZLSFRzWEVUK1BzaHhNeW9BQXpnY1lkYUtIVy92czlLQlY1QkhL?=
 =?utf-8?B?QmdEYkVqa21oVThJUDZ4WGh3VDhvdmNrMmhONmVNcEtXTzRDSmhwYy9NbGpv?=
 =?utf-8?B?ZVcwQ0dHYjFFMk9jZnNrOW9pZS9hdkNRaVlGRVFpNFhDaG44a1MwWXEybUVn?=
 =?utf-8?B?OWVSZjk4TEJESmRuOUdnRG1Bd3JKV3VLa2Jkdm16WHhSRi9QMXBBdXRmZDdx?=
 =?utf-8?B?WUZzZGxNYnZBVGN5V0UzNVRpZFE4QmtOK3ByVDYrL3dmVnMydnprZEpqY1Nz?=
 =?utf-8?B?RXNXNk5PcUpzdy9KcWgzb0dYWmdnSU9oT2tNQzgzS0l4U2hZZUNXRVorUUZB?=
 =?utf-8?B?eGVkRkpoeksyamdaSDllL0RCL3g3aGozRlhFSENLRmpUYnhxcmtWR3FqMFFt?=
 =?utf-8?B?ZlpiUFZRdFQ5RjdJZk9QQ25qRVlqUHY4aXZRZWtlMDY0TnB3enJ3YXVPMjFX?=
 =?utf-8?B?MnRRNk9ORFlmMkpicGtwT1pxdjFzc0syNU9mU1Y2bEVlWk9qSHMzSnVmb05J?=
 =?utf-8?B?bGw2U0FQU09pbDFOQ1Vtdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTBsNElabVV5L2J1Z2I5SHlGWG1zY1ZMZGZEWUFEeTR6a1N6WVYwdE5FMXps?=
 =?utf-8?B?eSt3anBxc0pUM3BQSzhVSEY4c05MRnBESm1ubUdXaUFLTjA1WUswWEQwTm5L?=
 =?utf-8?B?ZUhZdnczUmN1UjBjcU9CaVpxamFhSVY0dy9tbVdKSWRGMkxkZW5RNTZjeXdn?=
 =?utf-8?B?bXZ5ZW5hKzNDS1M5MmZiN0V6Qy83OURnNTVvSi9lVWptbUJHL0huK1JjREtx?=
 =?utf-8?B?aFBnSVdVanJWUGp1djQ1MllMdU1xbGZOc3hUSHpuQ2J6eVU3SXlTcExON2I3?=
 =?utf-8?B?R3prUFNEY1ZGUkVWS21TVkZIQmh4SmhPNzIyYXNSTFd2eDhaMmVIZ3cxSFlV?=
 =?utf-8?B?M0ZpWUlMNTZyQmMxOWJmWFNBWS90dEpVeVBRVDJzQ3ovVTBRelR0N1JKc0FV?=
 =?utf-8?B?MUd4Ry85Mk1pbWIwc0x0RDN6MjBuc0xyLzJZUWRZeGlWamdodGZ5M1VQOGJ0?=
 =?utf-8?B?ZkMxcE11bVVkcTlZN2FrejhMY2I4alQxTDllWUcweE80TmdrU045QzltQWl0?=
 =?utf-8?B?VjFGM2NpYjlPNFdaTkplRjh0NU9vaVN3RndzUVFiVC9XOXhHajJncDloZmwx?=
 =?utf-8?B?QVB1bmxiNWtGZytaLyswc25NT0llUlhGeGRRNXgzZHB3dTZVWjhTM24ySXg1?=
 =?utf-8?B?RDU2bWs3cGVNYndESnlLSWpxdVFybi9jSlNUVGFNSU9ZcDZNSDB6eHQzd0xG?=
 =?utf-8?B?dzR1T0NlOUNIWjRuUVNocHUyeE56ZFJaOTUxYUFTb3k0NUFBaWFCUlZySDZs?=
 =?utf-8?B?SjNaeC9SL1hjL0d2UFFUVndQaVZ0dlNNM2xVdlFibWJmZXpsdWZjN2JvMDkx?=
 =?utf-8?B?MlZBVHV3Tks1dzhlZGlGd0xFdjFjWnBzNGZCaTVrMnJuZ1lLN0pMR3FwUmJ3?=
 =?utf-8?B?Zzh6SHNadkxJWnJtYXdxbGVyQUhwd2NTN3Qwdm45ZEwwUVhQcXZwSExQemZZ?=
 =?utf-8?B?R1dsUzc5d1Fid0NtdTdBcnNCalJJc29HZTBBQTdOdERIV1J4Q1RzbkdXNWt0?=
 =?utf-8?B?clhKMWkvL0F3dTVBQTY3bXA2OCtMSzJicXBhTE5ITDZ2UXBrNzMrK3hFNDl4?=
 =?utf-8?B?TkR2R0lQQ2VkaXcrblFSYWY4Kzd0c3NJMFV3Q2ZKTHhKbmgrdTVJVzRsL2tx?=
 =?utf-8?B?NjU4T3M1QXNYQmYxM2dKcy9PdFprY09wbGhQYkdaQzVVWEM1MWtvd3FPMDB0?=
 =?utf-8?B?dWlvSytLTHNRdVJSYXlxbW12eE5NSlJ6YXJOVDAxSmYzSHMyRDhQY3kwNE5H?=
 =?utf-8?B?RkJmcktHYldFU2VJM1JreVVQZTAyUFRFNXFwblgvd2ZQakRSYkJubkM3VjY5?=
 =?utf-8?B?T2ptYmsvclJFMk9qMEJwWThFT2dHcnFwYTFMOERuL1ZoSW1QejBLTjFQMDRX?=
 =?utf-8?B?Rko2WFIrUWpsN29uMC82TERLSmhuczlrWm5lVlhyR2JQSnRwRCtITDNJZnd2?=
 =?utf-8?B?alp3MWxsYm54RDU3VG1uQitwQnZrUjIvR2ExMkJITzdNQ0xTdjFKcmRxQlJN?=
 =?utf-8?B?a1QxZDlTNS9zZHVZLzkwMEc4bDR3YXpsNjhSYXpQUzIrYTd1Q09DQUZKRm9h?=
 =?utf-8?B?NU00UFIzckFqY2M0ejZLL1drTHFUeGRmUktwZi85WFI5dmFNU0EzSkhBTTgy?=
 =?utf-8?B?eUkyZmliRk9mQkxrb3M2SjB5cFZQWU5uTjl5OG52TmppSERDN2p4U0VTVWZO?=
 =?utf-8?B?aHo2b3RrVHdYTmtqTUdaOWE1VS9PTnZ1MGlqWDBWSGFXckFqMUkwbjBrQlFv?=
 =?utf-8?B?T0VDR1VBaHE4VHgrcnZDR1lwODNHdzRPWWpVMnp4TFVTMWhlSkRkbXgwcVB1?=
 =?utf-8?B?N3pFRTVTOXVCMXdqZTJpcU1ydkh2Sld1Q0YzcWJIaHBySjlGanFVbkJCbG8x?=
 =?utf-8?B?b3BwekIra2ZDcTlkOWViSDNOTnNkN0tqYitTSFYyRCtzWkgxYVgvZlZHV2ZT?=
 =?utf-8?B?dXh6eHBmRzdjdkN1aW9XcEtRVndrOUJURnJxb3o5Sm12dW9iczJ6Q3dFMWZW?=
 =?utf-8?B?UEVKQk5QMUVZMnNYK1BnNGpOZkd3c3VLSVpyRms1c0F1T2hZVEVTSjg2ZEk4?=
 =?utf-8?B?RXpCcTdGa0M4enJGcHpqSFBSVUxmc01TODB1KzZNQndhQ3o1dXhOZklIWmN2?=
 =?utf-8?B?dEVSZGZmV3BGdmNZeTUwUHlaeFNiZDlXTkxmaktOcXNGQnNnZGZwZFlDaXVP?=
 =?utf-8?Q?W6jxaW8r1XiW7X3+m7q1SHI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k1OQ0H0gvXr1r1ff0PA789uUxYycLDNsOLV0bc4u7UsyWHZnLMhA8UzvdAj3yaF46J75Rk42TLfLtxFiCnFTx/5v/kd18YVhlKYCrK3eC3jAPa/EPRdxa6+Rxk/8imDUwme9wtYph95HSe3SZ0dSkxyU9bSDdLTh8Lvt0uAfXEkGjR6vvAxREAvRV/0i/WGo7iPZ2i7Gi1njb3oRecUjTOYaE6DvjSVoaHX/IkKteQZJ1VNOsF3jRR/fbXGgS6GuwjoTKuthO0PPJZ4vWlKPuT/+cE5I7eWzqFj4eBa4RRMTOfS1ZZ4OFssRASSVNNMLHIyB5qucJWVNGIf4wgOqXk4iW/wTUnzRA1/HgbV8w/tXC5igY1zGSj/FjXbdQqqc3MuAOWEXa9aXQ6fopgufsCiuzkjz1NO1rVvM3t0GmjSWijPBGrMJQTMUp4demdw+cJlmIe3ssM4YJQ8Fk2mU3W6Pz8Dbevde7W3mRlnutvJciOhDgvZ8puYpVRoX+ri7Xi0US7/M1OfJFWLjpCfBAt3DaSREkeX+UGVXPG5bglEI9+K/ZhFZFAkf4llxa9JiwG5vBmpzEQaPlaKx//dVxl1ShQZES5RFiVgSt+BJ2Vo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f51d1d7-bc5b-42a4-d22e-08dc9822dd0f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 10:04:28.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXQo85NnLfEAEOAOADGecU4z1Th5975IlaZfGvyZ6MOvB3XnCQvZfbVFiCB8LWX2+lwhw2EGbGOcG0xFPAg5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406290074
X-Proofpoint-ORIG-GUID: 8bqYG97xesAn3pBT4KYhGV_NlHBaBGi2
X-Proofpoint-GUID: 8bqYG97xesAn3pBT4KYhGV_NlHBaBGi2

On 29/06/2024 11:00, Alan Maguire wrote:
> Coverity points out that after calling btf__new_empty_split()
> the wrong value is checked for error.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

apologies, forgot

Fixes: 58e185a0dc35 ("libbpf: Add btf__distill_base() creating split BTF
with distilled base BTF")
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index cd5dd6619214..32c00db3b91b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5431,7 +5431,7 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
>  	 * BTF available.
>  	 */
>  	new_split = btf__new_empty_split(new_base);
> -	if (!new_split_btf) {
> +	if (!new_split) {
>  		err = -errno;
>  		goto done;
>  	}

