Return-Path: <bpf+bounces-29202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDC8C1277
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058C41C219FC
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD416F844;
	Thu,  9 May 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gn1n4TZr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vZWJdlb2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E316F838
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271232; cv=fail; b=i1MQ0VxnLrhiINBq1iCa4hcdFsRbpLK9bJvIwGzf+8PTzkOdXZ0iMM8Y1EBvKik1Xx9kIwLV87fzms8boY55imGLWXXks3dKcY+uc0u39mPlA0HIjfzY9fQqzzxDSRYn84JDH5kl0AUDqUqLjX5AmxRZkGJmdB5fauh5apugjEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271232; c=relaxed/simple;
	bh=yoHlj7CN0h8hbmXtBS6oGe9MMwLVv337/U+xjMx1rsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTjHfmCcS/TJDBItEZdJtRmPRjRxZk3obkETdOWmNJ/cZ7rTnXZsf7AXCQMLPJJicskoldLc1txgYdub862suRTk3VvBAeGMMavd5hKPejSFfjDrzF6XKf2p6nMo2pSNVyBcIJSE4YBxye6HKHDz/3vT4MKjUGnM40uMbf7/LBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gn1n4TZr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vZWJdlb2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449G5LsI011264;
	Thu, 9 May 2024 16:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cl8mZpHXOoxCDENs0ZUdg89prom22t1amb7InJuv8PA=;
 b=Gn1n4TZrRJNAV1CMzbcPugAe4M6NVQGVLr0RlC86qApKxgMJK1D03HNyHwBcJ1XVDLpI
 nQXSzQsl2tcQctVcGysMWEyTDsD+YpR7zjZRNKswLv9QpEZYEuYA9JT6SNFc0QoZ5oGz
 tjpvE32+KVRPDt4f38G7VhY071KqLx8igPWOD4nOMXqDzdXsCC4CSqs9ZQMXWXvvCFXR
 4/xeBxd8r4rieEhbHuSoueIEDhSW7zrX/rCgS2uwIhEoSwVVewoXa8ez731YvNbAjYLN
 BPmQ/Lw+ati9tryuSX+diMTraMubaVSEIZormuSsEtnCGo83TmbVGN3URJ4qemuUGjg5 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y11a483sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 16:13:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449G0ZnS031041;
	Thu, 9 May 2024 16:09:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkesfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 16:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FctxgmRj/8IIHardtBY4c0j+Rs2SsHCnSLgwILyIUGwkdkivlyBqY5RG5EnEImXP0YKvOXGYJl06yBkLVUE0JJHvI7a6YldbI3RLMsVmDq5bolReXn8tsA17UJFquobwxDtO+U8jNgTGMU2klnV3k/5mW1AruA2j2YHRLSn0I2jD3sqWM+ythfB9VER9DrpIGV1aYLUnuYtsmurjsETre2Qhu17jPOQudGflB8a5/huchrWdycPuzRtwzZ46F9GU/LcJqE8iCmE8RGOyhCEoRIvidRm2tHac10m1tBL7+bJJd1zBhQA6ycP7TzIcO4P2/iSTOUmcV0KsH1S62Al8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cl8mZpHXOoxCDENs0ZUdg89prom22t1amb7InJuv8PA=;
 b=BmXS1UGTZCQ9ujFHtvnFFJ4COUMCsZCzWQzq4NsvgW7tr+YzjXkVADEuBmUBCWC+LblcrCcu4QIL1oQZcKZvfHs3S+T+EN0q6t3Gnf9laLUCYrwBUSY5xXQyRco/+rsUAWlbekkYOBI8cwgnX59/aNAx97N0POWnFQfb7XPlEmvRRpylKxc1D0DeC7U6PWXuUOwBzBpOP7E9gUbRidHfqW6bIP8OFte1FLypnWqnRcBMq47RwnANABRGuq/cUtijjA4c2aZ4fWOVX2nhkgE5pThTIUoTOeDsdJKcFPg27SlL59pL+EUSWOQ7T/fhX1TbHqgk2SAdlOUoHg5yTTzu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cl8mZpHXOoxCDENs0ZUdg89prom22t1amb7InJuv8PA=;
 b=vZWJdlb29zjhNZjtjKYm9v37zrGdByvAOim/18fDsYLGkePvh1vCEyawtMrTP0eRh73CiQl5ofG3cCGFm+GOTQqXRcM8nD0gxjMDEfxANI3O1oIA8kYBqSOKg8lIvqXHXyJcSLezx6DuEwtqL4Iq5m5XCj+Qm0t3wnBqO/1FHbg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 16:09:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 16:09:04 +0000
Message-ID: <b43d0677-5018-45a1-8b0e-00bdc68a09af@oracle.com>
Date: Thu, 9 May 2024 17:08:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, kernel-team@meta.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240509151744.131648-1-yatsenko@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240509151744.131648-1-yatsenko@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 57291f21-5b24-43a1-8c0a-08dc704258ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clZnYU9TeXRqM29KdlE1ajBrNE5QWC9ES2V2L05yNkhSY3dVOEF6RmxCUHZT?=
 =?utf-8?B?anp2WUFTdi93SEZhRXdDbWdqVFg2OVdsanhEV1BtRlBqR3RDMkwySFkwQXFT?=
 =?utf-8?B?TXQyZDhKNDMxbThmWDFjSTlTWHluZ2NPaTRMK3Z5RlRrRmNmN1J3NjFwY251?=
 =?utf-8?B?a0tDY2IyOWIyKy9GaDVIV2RpYk5IWW1mRUIyYmZSU24wemx1Ulkxci9pMzMw?=
 =?utf-8?B?T3FJMHJrT3FrN0pzTk4xeUYrak5Ra09wZ2J4REJadUdZdkFzQnFVckZBUEpz?=
 =?utf-8?B?WlIvVWMvR0FHUlVsSDlPN3FlbzlmNFhVSzN0Qkg2eVh0Q2IyT25RVlBzb0VM?=
 =?utf-8?B?OXZsM0hyMVlmaFA5Y3NxZ0lyVmJBYS9QNXFHSjVpcERjakdGbmg4V3Fscnk2?=
 =?utf-8?B?NFluZjhrd3RMNzRJM0JWODczQ0k5NW10UnZ3ZVNObzBCczRwL1ZTMDhlWFZH?=
 =?utf-8?B?Mll0bHB4WmdRK0VXdXdOTkVvSURMcFZkUDFBTjdrQU5RbHc0TEVheVZDZC85?=
 =?utf-8?B?ODdMbXFHRWtNd1BzbjlGWTdzYVNvcisxcGxhUnBvUi9acXlGcWRueWxZc0xE?=
 =?utf-8?B?eHBBK0xCaWt3Ui8wbVd2OFFGYXdxVjQwc0doR1J4WmY2dExOVjhkei9QQU1V?=
 =?utf-8?B?bXArVVEzaVJEcDJnbmtFYlAyMXllMnp0SzJ1SlZycWQwNEw0SmZyc1ZqSGhp?=
 =?utf-8?B?NmZPRGUwWHZ0clcwOUpVa2VaeHpPcFJaKy91RnFoUlRsUnNMQy9IVHlCM2Ja?=
 =?utf-8?B?eW5YZ29kQ0NwMjU1bCtxRnNCV3Zoc2lpM2MvQWkvMXNlc0syOWJZQU5aSGVr?=
 =?utf-8?B?SEw3S1paQmdJQXB3VFdkYklkQUY2NkJOd25VMDdHOC9WV0VHVi9VQ3hXZWdF?=
 =?utf-8?B?U2h0RGVna3Z3Z1V5cGMrSk9USEVRL0lkYVFjYUZtNS82b1l2aHg5VENGT25O?=
 =?utf-8?B?SkJLd0Z3azhFNWdNTW5mdU5ZKzlZeWd1OGxKVWRCNjFkVVFqK3RwQ0VLSjJl?=
 =?utf-8?B?azJYLzFvRnFhMW5WWFpGRUZIVFBBSjNEcTFuMSt6bnRCdms3alo4RnlQN2Qv?=
 =?utf-8?B?MmU1WnJXQ3poTEgxblhhZ1pHV0x6R1Y3WjROMGwzczJDQ01oSXFzaUtkWHI5?=
 =?utf-8?B?N2VvemlsdnFVUzdjL0wrbnc1Z05NcjFxdTJpa0ZWVThNN1gvV0dsdkJVb1JY?=
 =?utf-8?B?VklmUUZXMEZxS29mUzk1U3M4Vm02Wk5PSEZydDJMMkxseW52QXk2UUdBbndY?=
 =?utf-8?B?NDlsdVdzUXB1ZFFwek04RzRvZGVDZE1sQ3ZVaGdodi9FUkwrSFJtRDR0T1JI?=
 =?utf-8?B?aTJoUDh2ODBLVHRxYjg2VzFZRmVrNk0yL1d2dGY5TW8yeVpVK0ZTMTRibk5s?=
 =?utf-8?B?UWIzMm9CZjZBeUJFVEhsM2VUKzNUV0VjczJaR0hadEd5eTkxTnNDaXBlVTQ5?=
 =?utf-8?B?ekZxOWgyUmNIbDdsR2tsYkg1UlNFM2dwOGdObHRCWkdoVlBrS3ZLMGVOY2Ri?=
 =?utf-8?B?NDlqZ2tiMTBhWjh6ODVTOWdYQXZKUVo3bkdHUnNjdnozMjhnUmpDRGFXUEN0?=
 =?utf-8?B?SmN1Uk9hbG80bUJHbTltaEpFUHJnaHVrOG9PUXAvTlZrVHpFa2xvVWUrK2FM?=
 =?utf-8?B?VEZYblJhRDNBdmgyTm0vNGNGeHlBSGVraWlTWFYrOVpWYWVEUVBIS2lZL2k5?=
 =?utf-8?B?bFVJYUJTNUhYcklrUGdlUlozbGZoYTMyWVFHaUZ2SDRkelV1dzRKNWFRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmZwN2xNSVBEN2lqdzRiMWVjcTIwUmdPT2h5UVJHSHU5Njd4OWhlVmpKanVn?=
 =?utf-8?B?VC9uNHZ1czIyRHlPRWlpbDJoUzYxb2hXcDFXNUVnN3VLYk1ZS3JVYXIxR29a?=
 =?utf-8?B?TFFXSFk5cThCWXFqTERPb0tEcXA5ekU3dlF0UXhidlVFVnIzWUgvaWpWdjE2?=
 =?utf-8?B?OFFkUUdMTlZIeENrRkZ5SnJMamZoNm9aSmxQRnp6dDd3cFpNUlk3d3hWVHM4?=
 =?utf-8?B?VENUU1p1MHRqNE4xSmpmT2VzdnRRVDVsVVgxeDVGOVREditoY2VNajhWMTlu?=
 =?utf-8?B?dS81bVJuWWczRGdBdllMaEVuNHNXQUpXSEdBdERIRzRxbUpzZ1Y4TDZvU0xO?=
 =?utf-8?B?TDlWY3h1YnB4R1hzSlUrZ1VUQmdWRklsdXIyNUdJSDgvQ0NYU0JKcUJIcU9V?=
 =?utf-8?B?Q2l3QUNleFVBbWtoeG1VVXpiYWFaTTJxSkhydEtJMjQ1SjZuejZEUXoydUVH?=
 =?utf-8?B?NnZkQnYzMWVmSzlFSy9uVkVLYnBFNnRFcWVYTlp3UXdIb2hnZk1iNXdGUHQ4?=
 =?utf-8?B?ZVN2UDU5OTY4eEE1L1hrYjkyeUcwTWQvM3hlRmdMY0tOVkhOVXpoM3BWSWxq?=
 =?utf-8?B?NHd5d2FTTXF1bGdCZ3FRVTBpYW15VzFSZDQrMHlpOXhBZ2o5V1RycEpHQUxZ?=
 =?utf-8?B?SU9rMVpoaTJmUHFJVlB1aktSWEZvRW5QM0l3NVN3SVVmRG9ZU0dBRzRnd3Z3?=
 =?utf-8?B?OFhsTE1GekIwOUozRFZsRU9OQWNZOURJTkdybE1HUUxtZkRJaS8zb0RZWTN3?=
 =?utf-8?B?ZzlDc0FpVGxYeWI0VHVLYnYzYTM4M0gwdytDMWtvZ1hZbGRzaXEvS2pqNkFa?=
 =?utf-8?B?YmoyRFFEK1ByREVoenJXQ3NLN2wxK0l3MWtMKzRYVXJNOUdWQmd0YUhDc2dn?=
 =?utf-8?B?SlhLazRnMjF6QXBBOW5LeTVpNWgreGNmVm4yWU5hMThabjA0bG5tMEs0c2ow?=
 =?utf-8?B?cmo4NXduN1lQVW9TSTNpSU9DcGNvaEl3RkVOL3l1VitSNFAyOFpvQ1FXWGE4?=
 =?utf-8?B?UlJQZkVNc1QrcHhnUnZNUXNzemNPT2FDcDdZd3JoNSt4emplbDB0WW5OYTRP?=
 =?utf-8?B?dE9LWVlaVE94bEEvOE5IVEhqOUozREhEdEN2SVdxMjlyd0wxVTJsUGI3UDhR?=
 =?utf-8?B?akVhTmVMSmxRSys5SVJuRDRuOGxnNGhKbU10eHlWaUEzR2ViMEVNSUNVRFdk?=
 =?utf-8?B?QTJkV0hFT1d6WW9vMHhRamEvREkyWHVtSk9oNFpjTUJ3emhxYUVGZ0J1RzRP?=
 =?utf-8?B?Z2I4U0d1Z2tIWlNIdFRwbWpSUkRnWVRsTnJXM1B6RU9oTW84SHM4a1YzdHNJ?=
 =?utf-8?B?SjNVK3djWWl4VVZkdlZMTXdTYW96VWZMV2ZJcHJULzFnZ29ZWmM4YmI1SDgz?=
 =?utf-8?B?SldFajYzMU5aS3p4NXF0UWl6QlNweDZESFJteW5GU3Qvb2tzalkvcFEzQnMr?=
 =?utf-8?B?WWNWQWJjM0JDVzN3OGFhbmw5TWRDT2hUcEhGa0FoYlNvZlVlMGFNQ3ltb2t0?=
 =?utf-8?B?M1FrNlp3M3YrT0xJZU9zZVhBSUdXRldkTWdObHcyQnJuVWFCK3NZcG10NVBG?=
 =?utf-8?B?VUlRMzV2UU9VTDh2MmxyL0JDd1lHS09lbXlNYmVKK0tzNGpndklZS2hLd2dV?=
 =?utf-8?B?RU5IZDJMWHZySGsxYzhET3lIeVNvMy8wc3IrS2pUSGQvbTFIUVZUZmxsRC9N?=
 =?utf-8?B?bW5Mc2xCYXJ2ZDNRK2VMZ3V1OEU4VjFLN2lGZlUvZm1tTkhWUzlabU9JUHUx?=
 =?utf-8?B?blQ0R1N4Nk53bUxkQThzakkrQVZ1V3gwNFFhM0NQeXNCQ1NDQ0JMV1pyNWRE?=
 =?utf-8?B?MDA2ZVNPY3M1d2l1L1pMK3JFa0dRNXoraVZySk5CWmtTcm5TdzJXZ3E2SHg2?=
 =?utf-8?B?NXYwTEczNnRCdGNZSW9wRUFQTUtHTFY0ZnFsZi9QSHNoSlZYY216R1hGaVZp?=
 =?utf-8?B?Q2VwaWI3RkFNbkc0bURSOE5qMm5JV1NscndXNGNKMURqTTFEWlUwRjBlZUxj?=
 =?utf-8?B?T2FrRXhsTDVUOTQ1WkFyZW1EWWRHQ0dOVldGNmVqSXRqZVpOSmtCcklvMGV4?=
 =?utf-8?B?SXl6ZGJTeTMwREhqS1I1VXQ4NTNERFlDRVhVckpoTGpwWXd4ejk1eVlFY2ZB?=
 =?utf-8?B?VDlaYWt3Z0dnd0dmeGN5K3d0d21PZUhXV0p4QW1MR3pyenJhc0JZSmlFK3Nq?=
 =?utf-8?Q?OFHPsYAWccxUtZjY9VW+1D4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UUPPthXpa+G6hQYsKWqGrjwsvGISSCnawGJaY4kjAMwca+8GgEXEWpe5zaWmpQ+GusyQi/1swJbk+H0rcRgBVnL2L+l1xFgKEZ6R8BdAaIYfw2f7wRWRUoEWBn8EElTeHJGl0NjVYSJ3BCAPsaqum3362SawXajuYZCTH+PwbicA+HB3g3GbMDhdHhmvqNWMBWhnpdd1D9fKNB4mIxZTxfVNQRmIjBbYtmvvHKooFH1XXtdmVCSkdN6xKN0s8Kc0uizsoyOrAsGj4LfZiTYpTI4NyNnnGYa/o39WMS/UjSshhvh6+96C8/3NUHC0kzW0KDia81fBjtM3l0cbqDi7Is6v6QPYnMBAvQSIHg8ouzYOF91ottfJjTGO/aNYQiQEmibVJ9jpUa7yeY1Jd/Xx2iVhldL0Q0npV7JdH2yvQP9jLmXx1YAqRsZVI0IaRljhl4yU8ps6XvXAgpg5Da7N/G07/yCFB6UfQuncjR7Q62bt6HnpA+SGvt9hCClhJMphe2mL9X7/B9smoGXYxq6hd7lhGl02bJWjXQfjx1aF0LGFr6mE5Zv8BreAccGLUi3InzYPAMJW9zWhRVcUwatco0H8q6gVkkTSFgZd5FpjMFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57291f21-5b24-43a1-8c0a-08dc704258ae
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:09:03.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OnGwKdjuoh6cZ27dktquIHXQO2SsH38VPg0q4qAiXxM5injjDGAGqT1ypgLGt0QprqB3qo0+ESDfpu4LnaNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090110
X-Proofpoint-GUID: 4zEHnYD7pIZrlWcKGZ9Ao2NFKeGI3_mp
X-Proofpoint-ORIG-GUID: 4zEHnYD7pIZrlWcKGZ9Ao2NFKeGI3_mp

On 09/05/2024 16:17, Mykyta@web.codeaurora.org wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
> 
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
> 
> Type ranks
> 
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums/enums64
> 2. Named enums/enums64
> 3. Trivial types typedefs (ints, then floats)
> 4. Structs/Unions
> 5. Function prototypes
> 6. Forward declarations
> 
> Type rank is set to maximum for unnamed reference types, structs and
> unions to avoid emitting those types early. They will be emitted as
> part of the type chain starting with named type.
> 
> Lexicographical ordering
> 
> Each type is assigned a sort_name and own_name.
> sort_name is the resolved name of the final base type for reference
> types (typedef, pointer, array etc). Sorting by sort_name allows to
> group typedefs of the same base type. sort_name for non-reference type
> is the same as own_name. own_name is a direct name of particular type,
> is used as final sorting step.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

This looks great! Not sure if you experimented with sorting for the
split BTF case (dumping /sys/kernel/btf/tun say); are there any
additional issues in doing that? From what I can see below the sort
would just be applied across base and split BTF and should just work, is
that right? A few suggestions below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..09ecd2abf066 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_ENUM64]	= "ENUM64",
>  };
>  
> +struct sort_datum {
> +	int index;
> +	int type_rank;
> +	const char *sort_name;
> +	const char *own_name;
> +};
> +
>  static const char *btf_int_enc_str(__u8 encoding)
>  {
>  	switch (encoding) {
> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>  	vfprintf(stdout, fmt, args);
>  }
>  
> +static bool is_reference_type(const struct btf_type *t)
> +{
> +	int kind = btf_kind(t);
> +
> +	return kind == BTF_KIND_CONST || kind == BTF_KIND_PTR || kind == BTF_KIND_VOLATILE ||
> +		kind == BTF_KIND_RESTRICT || kind == BTF_KIND_ARRAY || kind == BTF_KIND_TYPEDEF ||
> +		kind == BTF_KIND_DECL_TAG;
> +}
> +
> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
> +{
> +	const struct btf_type *t = btf__type_by_id(btf, index);
> +	const int max_rank = 10;
> +	const int kind = btf_kind(t);
> +
> +	if (t->name_off)
> +		has_name = true;
> +
> +	switch (kind) {
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		return has_name ? 1 : 0;
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
> +		return 2;
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +		return has_name ? 3 : max_rank;
> +	case BTF_KIND_FUNC_PROTO:
> +		return has_name ? 4 : max_rank;
> +

Don't think a FUNC_PROTO will ever have a name, so has_name check
probably not needed here.

> +	default: {
> +		if (has_name && is_reference_type(t)) {
> +			const int parent = kind == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
> +
> +			return btf_type_rank(btf, parent, has_name);
> +		}
> +		return max_rank;
> +	}
> +	}
> +}
> +
> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
> +{
> +	const struct btf_type *t = btf__type_by_id(btf, index);
> +	int kind = btf_kind(t);
> +
> +	/* Use name of the first element for anonymous enums */
> +	if (!t->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64) &&
> +	    BTF_INFO_VLEN(t->info))
> +		return btf__name_by_offset(btf, btf_enum(t)->name_off);
> +
> +	/* Return base type name for reference types */
> +	while (is_reference_type(t)) {

The two times is_reference_type() is used, we use this conditional to
get the array type; worth rolling this into a get_reference_type(t)
function that returns t->type for reference types, btf_array(t)->type
for arrays and -1 otherwise perhaps?

> +		index = btf_kind(t) == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
> +		t = btf__type_by_id(btf, index);
> +	}
> +
> +	return btf__name_by_offset(btf, t->name_off);
> +}
> +
> +static int btf_type_compare(const void *left, const void *right)
> +{
> +	const struct sort_datum *datum1 = (const struct sort_datum *)left;
> +	const struct sort_datum *datum2 = (const struct sort_datum *)right;
> +	int sort_name_cmp;
> +
> +	if (datum1->type_rank != datum2->type_rank)
> +		return datum1->type_rank < datum2->type_rank ? -1 : 1;
> +
> +	sort_name_cmp = strcmp(datum1->sort_name, datum2->sort_name);
> +	if (sort_name_cmp)
> +		return sort_name_cmp;
> +
> +	return strcmp(datum1->own_name, datum2->own_name);
> +}
> +
> +static struct sort_datum *sort_btf_c(const struct btf *btf)
> +{
> +	int total_root_types;
> +	struct sort_datum *datums;
> +
> +	total_root_types = btf__type_cnt(btf);
> +	datums = malloc(sizeof(struct sort_datum) * total_root_types);

calloc(total_root_types, sizeof(*datums)) will get you a
zero-initialized array, which may be useful below...

> +	if (!datums)
> +		return NULL;
> +
> +	for (int i = 0; i < total_root_types; ++i) {

you're starting from zero here so you'll get &btf_void below; if you
zero-initialize above I think you can just start from 1.

> +		struct sort_datum *current_datum = datums + i;
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +
> +		current_datum->index = i;
> +		current_datum->type_rank = btf_type_rank(btf, i, false);
> +		current_datum->sort_name = btf_type_sort_name(btf, i);
> +		current_datum->own_name = btf__name_by_offset(btf, t->name_off);
> +	}
> +
> +	qsort(datums, total_root_types, sizeof(struct sort_datum), btf_type_compare);
> +
> +	return datums;
> +}
> +
>  static int dump_btf_c(const struct btf *btf,
> -		      __u32 *root_type_ids, int root_type_cnt)
> +		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
>  {
>  	struct btf_dump *d;
>  	int err = 0, i;
> +	struct sort_datum *datums = NULL;
>  
>  	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
>  	if (!d)
> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
>  	} else {
>  		int cnt = btf__type_cnt(btf);
>  
> +		if (sort_dump)
> +			datums = sort_btf_c(btf);
>  		for (i = 1; i < cnt; i++) {
> -			err = btf_dump__dump_type(d, i);
> +			int idx = datums ? datums[i].index : i;
> +
> +			err = btf_dump__dump_type(d, idx);
>  			if (err)
>  				goto done;
>  		}
> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
>  
>  done:
>  	btf_dump__free(d);
> +	free(datums);
>  	return err;
>  }
>  
> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
>  	__u32 root_type_ids[2];
>  	int root_type_cnt = 0;
>  	bool dump_c = false;
> +	bool sort_dump_c = true;
>  	__u32 btf_id = -1;
>  	const char *src;
>  	int fd = -1;
> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
>  				goto done;
>  			}
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "unordered")) {

you'll need to update the man page and add to the bash completion for
this new argument I think.

> +			sort_dump_c = false;
> +			NEXT_ARG();
>  		} else {
>  			p_err("unrecognized option: '%s'", *argv);
>  			err = -EINVAL;
> @@ -691,7 +810,7 @@ static int do_dump(int argc, char **argv)
>  			err = -ENOTSUP;
>  			goto done;
>  		}
> -		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
> +		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
>  	} else {
>  		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
>  	}

