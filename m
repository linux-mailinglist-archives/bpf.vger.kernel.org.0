Return-Path: <bpf+bounces-71698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A8BFB24D
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDA584EE540
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515530F54C;
	Wed, 22 Oct 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFWl+TUU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ghhl6FZR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A621FF4D;
	Wed, 22 Oct 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125022; cv=fail; b=XS8d4QLw5JDKDbwf0NRRh412fllVAfLj3PJmfCismz51dA/4KJgWwROvx/D6B6fsPKyMzApHFgRbg/0K1fBnBbdXjIxxgIODTD9Ht0ZQAy8M3ZrvXVHVDwKWa4t2p2VWf391gqZNtyJM8sB02ARvUeUxCdMlGscAbPLJTVHchHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125022; c=relaxed/simple;
	bh=AJa6sLqjJizRHcWBsZ71FApRtGXv/zkSkXuPShO4UIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFKuwRCytPX8hwdBGaRvptswFc5jtZTMqr7X82Ww4sm7ZfWZZy4KQzUgZCg3SM3fUUJi8gdljFnayQW/cxDodqYM6mY2Ri3tTmexqP46GsdZKqeNJ/6X7CrD3Iztfhk6YdmdyXC0w6EOlKVWT+XaExmce9jXTugcCkUDflHDQPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GFWl+TUU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ghhl6FZR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8CNIM009264;
	Wed, 22 Oct 2025 09:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JjWlUB3yU4uPLvUxJJP5v3a0ZUrtsgrXBjCA2BNFTqs=; b=
	GFWl+TUUSsKcAFPkjx9xasJNc8FO4n8sfwds/2cCgbvcqKupsIZlHoez9Fyk46XY
	IL46RV0pfMDZFgFX2+3PCnL2WWUxJTXMACisazU1AXiJnV0TYjlKhHPqr8mrSZf7
	Cns3RGyIAG3LqQTRQ8FaRS5vAcOPMwsG6MB/IE2K+bmhjAQz38PXL3QOoGWwpboU
	Fs92Mcoxz2/gaZSnoDqx1H1N4hlP5uB3elDHSwtbFtEBMIVYSy71XXZIgnb7gV6c
	MWtPmeh7WwkSoCjvntHVTWBUjxT/YGrR7fMRCay8kphMpDpqBPkOh9HFe0Vsjj+h
	xggiS2XHJQiKXmI5cO9nHg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdpdr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 09:23:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59M72YsC025448;
	Wed, 22 Oct 2025 09:23:19 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bcxhfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 09:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E62fQ8LuYT4trJtuUmsceodcpqge4L9JNqu4jT9qOa5mzJbrcVdylkuinXMoISnh1cTBu2a/ivF2f2ni8k5vtue7Yn+qBucSIwktc8ytKaRA3/Gnaguc1M5UWyxb6k5PalI/iGojNamiXFkHR3h591lLTA7yR1bqlYzd2q+k4tvHoZAnZaN8mCBL5wjEihKJviOM9U9tGjIFvHkimClqaJlCeGzePqajD8kk4eq4dD4xoIfDbniFlxxCyRv5rnVrTjg7M1f+emc6hFcnTiZ3mRtrW6gVfISbrEmLVd4gkgrC4G8jMwj1/1JoLV+5x8K4ckQcehQp4RRQ4VpQ0p3/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjWlUB3yU4uPLvUxJJP5v3a0ZUrtsgrXBjCA2BNFTqs=;
 b=wc4l1H0FiyhkIpCDaSiIMDZuund0rBpUED+bP2IkQL52uEqX0yGD0v9x6HIMBSo0RtHy+DbBwrzW2iUZUyxVOCvms9eeyfYlUL7DC6Pqd+Z9GSsqP5e3kh1wTKtr7Usqse4JQK11Qbk+jKd7W6I8M64WpynAvIo9c88alXy8jTfSo7O2laeKl1p5se3T/Go4xuUlggXyKH7BJRzem5ngorPoaIsraYyhDYtaOmI0K+BuaguqqUnjl9LxzcyaKaKhm60huzV+n7gybD7JesH7502dTnQDE8mMoKMPwrCYcy2p5TXY2w8ih/rCwxJ534eI7Wf+4eEOyMeWoq8eGsiD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjWlUB3yU4uPLvUxJJP5v3a0ZUrtsgrXBjCA2BNFTqs=;
 b=ghhl6FZR+7QFypF0aSyn62iB5/+UT+qzwK//qb2FgdjkKBz51jtON0jLgotU4Iw6f2P/4Qj7b6s3kg0fTNCVWZBXAjLT6fCwQC282P0tyTOdl6hTEa5okvAPw7xW2fqt0JWxJJFqX6W8EFewT1HzBQheNDUWfckyTZTnGBWco3E=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM4PR10MB6816.namprd10.prod.outlook.com (2603:10b6:8:108::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 09:23:16 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:23:16 +0000
Message-ID: <f17f816b-959c-40e9-b0d0-80a0ff90dee7@oracle.com>
Date: Wed, 22 Oct 2025 10:23:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: David Faust <david.faust@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
 <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
 <33a601cf-d885-424b-a159-f114c1d3e9c0@oracle.com>
 <4896ef05-da3f-4b41-8b76-0ec901ad569d@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <4896ef05-da3f-4b41-8b76-0ec901ad569d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0579.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM4PR10MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: d30e0e62-e3ac-4c42-b6c4-08de114ca1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFyd01HZmdDZWF2TEVJYm5FVEZKZzFOYVNzdlNsUDhTRWM1eWZqcWxuOTQ5?=
 =?utf-8?B?dk5zTWUvYVAwQzlkRVRXa29EUXVGbzFaSk56TzB6REhVNTBZWmZMUng2QmJr?=
 =?utf-8?B?b0NIWHNhNFhsOTN4VzU2M0NjK3R5dTJ5KzBTSUhndlFDUE5hT0lrTTZPZDg5?=
 =?utf-8?B?QkFWNkhYMG1talYweEQzeUM1T1VUNS9hNTg1b3pqNkQ1ZXY0QjAvWTdpL1cw?=
 =?utf-8?B?VzJyaHdNRnFBQlBpRFJGcERDOHViWkdVaUhycm9YMVJtK09URkRBV21DZnF2?=
 =?utf-8?B?U3ZZYzBuVU5jalBBSjkvbUc2RUNrOXkzelZtVTBpWnFJY2RQL1lBOStYQ0tU?=
 =?utf-8?B?V0x3TTFaRlJ0cWFpcUNmZFJGTUV6RU95blRPVkYxVmtRY0tmdk9wb1N3bFJv?=
 =?utf-8?B?VlBvZ3hhbFJSbENxanlVQVdINHpRYms0cWFNKzNwcm8xQVhIdkxHa2dRQkkw?=
 =?utf-8?B?Vm1abTR4NWR6YlE2VUIzbDFNNEdmR0VFWWRsUE4vL1d1eE80ZHFPdjc4RVhE?=
 =?utf-8?B?SlQrYms3eGlyUS9JdXNwOWxtQkxUSnRXYU9heUViRzF6QlNDQ25ULzNZMytD?=
 =?utf-8?B?NUk2NEJGV1FJZElabGgrb1VqV2YzY3pDTHI1ODNtd3pLVU9HREZHNk1lNDQ4?=
 =?utf-8?B?TzlRY1dqWWdvSlNvaEZWUWltL0ZCTE1TRDVlaXBDSDNncWtzZ0pWbWgzT2Iz?=
 =?utf-8?B?bzZmYVlrWEJLS3F6RkVHRklBd2FmRVhGbVV2OUlSYW40RHhNMitUbDdPR1FF?=
 =?utf-8?B?eUhHbE9SMDlaMGVMTHBTSWJXYktPUTlaaVpWMXBsNE5mOThkaitPSjVYVk0v?=
 =?utf-8?B?YmRERXMxbEI5WmdkVUtKSG1DSG5OcDhkdjBBQUplUjN0OFAwb0NTUEtHdVlC?=
 =?utf-8?B?U1d2UXN5dVlvcVVnV2czMFN4aFdZRy85TmZxazVuWHdPa1I5ZnlJampsT1Z2?=
 =?utf-8?B?OUFBdFo4cjR3TTU4Mi9RWEhKOC9vK0VzNmg5UmpLV0VYWUMvUlRwVkYvL1Bi?=
 =?utf-8?B?VTRpZlhINWRoWHpBc0FhK0RxdUN1cnJCKzhseUlYTnBmSVRsSks4K3ZZa0pw?=
 =?utf-8?B?NXg5aWNoNHBRc1d2M3l2S2JxQ3hiTEFUdGhjOWhsTWVRck9UaFhlVDNOV3po?=
 =?utf-8?B?SmozUUxrbUR4U0VyQkNqd2h5MGZGT0RXZGJmUG9WYmdDRUx0REJkemlDeWJj?=
 =?utf-8?B?dmZueWF4bHZIOXlod3JqNi9aVUxBOWx1bjJTMU9ka3NsejMxTGxjTi84MURX?=
 =?utf-8?B?YlpXd250T2hIcHIyWUNNUTFpcXJCNlpFRis0aHlPVThKdlBwUlFMdGllQTZR?=
 =?utf-8?B?eS90K3NGcHIvZWhERnlZL2tScTZDODh3amIxeVpaTCsvckJ2Wm1IYTNvL0w2?=
 =?utf-8?B?di90d2d0U0tnM2M4WExJdDZGdnJWZnptTW1ub3FIUnVZUkJYTXAyTU5rZlRz?=
 =?utf-8?B?NERQNmxZelQvQlJ2SkZ1Q3ZrS000QWN3ZFNTYVE0NHVjZkFieGlyK1pXZDE0?=
 =?utf-8?B?cnRqQS9zd2FlZEt6Mno3bm1ZUjcycDZ0eWNOeE1qakhYampYSmFJdGFjckI0?=
 =?utf-8?B?Rm9hV1BBOHlKaVhRYmN3RTg0YUhmYTBqem1HYXRhOFpZUG1rb2tQZHFmR1Fu?=
 =?utf-8?B?VFNsUzZKb1dIdEs1bUU5TTBTWEU1SnJnV3ZyOG9kWkJOK29jUlFLUzNCZFFk?=
 =?utf-8?B?amtmVzBPM1BQSGxGVVBJN2l3Y1U0Y0l2bFprRDRTM0FyR2svODlkL0crdEZh?=
 =?utf-8?B?UUU5dDEyeGF5b21xVmhFTjVyUVFXT0ZPZDhwYXFDTXdEeGNEeUQxYjBielVl?=
 =?utf-8?B?Y1ZLaGg0WVA0RTR1ZU5BdzZVQ2xtTVZNS0pwMGRzb20zQThvNVJrdlVTamI1?=
 =?utf-8?B?WkZvejgycVRSbXc4OUcxWmYxZFRoakVrWmVHendpOVJxdnVUNXBlV2thMlIw?=
 =?utf-8?B?MGhYeDUvRHAvMVpmZGJrTDlZZXdlMWR3Uk12TWZqdFB0WTA3TFdyb2JHOGJa?=
 =?utf-8?B?Qk5vcUNKTGxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDN2ZlFlT2NhS1pBZzR2TEp4NnVZUEswMDEvTm8rNUF0YU8zVHRNSGoyL0Zq?=
 =?utf-8?B?SktERmk5MlZNTjhPWFZLWXJBUXdldGcyU1hHT1VGYTNHcm4rSWRzOERMR0Vq?=
 =?utf-8?B?Mi9TWjc2Qy83UHhTV0dnUE8yYitjanlCSnlYUnFCdFpGSmRTRlpZeVc2NWlE?=
 =?utf-8?B?WWgxVFd6U3hXcFo1d2VlR2RGektiZEU5YTJnYkZQUEIyN091aTJBeWZJTldZ?=
 =?utf-8?B?WDJqKzJJcHpYNWdNZjhleC9DZWVDaDRuMUVyZVVkR3o0dGJpNkV1bnc2K09L?=
 =?utf-8?B?SjVmWVk5OEdTdGgycm40dTZxcHdmTXdabVpPbllZaWVwSXZlSE1Jb0NreDR5?=
 =?utf-8?B?ZjdmR3NoSjFESldEeEgwcjhUSWkvYWJiVnVMR2N3bmNoTXM1ZnBaZUxxangy?=
 =?utf-8?B?YS84ZVJwbFk2RGVCS2E0M0U3WHord1h0UjFPVVR2SE9PVWtKNmduNHpIcnh5?=
 =?utf-8?B?TjdGTCttb1ZqQVQ1QzZvTmdrN2kwb3FqWTM5d0MwUVl0NVppWkNCaDNMT1dP?=
 =?utf-8?B?S0t4ZXJSZDA2OWFaSno0cWFuRXNsYjlndGl2eHZMTEY1OFhielNUZnpNWDFp?=
 =?utf-8?B?Qis3aWJOKzlJMUZ3THdnMHpWQ2hUVUVYelZVWERFUGhoaGlBWXFFM1NXYm1I?=
 =?utf-8?B?WFRSZG1HSDg3VURIMVpFWmM2bGhBN1A2N0lzclU0ejNLK0NCRjkrc1R5RkhV?=
 =?utf-8?B?RWJhYm0xR3FJRk1Na0x3ZDFJQUlpM2NVbmZSMUlYYUR0Y0JnRlFET21pTkRy?=
 =?utf-8?B?YXpQaCt0ZnNuODh4Skd5U2JpTFlDdlhsVWNKckZJRndGK3Iva2x1T0ZldzdH?=
 =?utf-8?B?Vk9KcVp6L0lwNDNpYTJnRTVzRWQ3Mkx0YTFlOVFGc0pObWo5VlNRSVJrM0Vr?=
 =?utf-8?B?ZzhEcDBaQWN2VHlrdjVsZ1Y0MGZ4T2g1K28zdUcrZklmYjFCejRiU0FUZkxO?=
 =?utf-8?B?bTFiK1I0Q1BrRzQreGJ1TGZJamhYUVdYaVllNEx0bDNSZ0s0ZzgxVUxlblBF?=
 =?utf-8?B?dG1CODFGajdDM1pTeXM1ZkJ0WDRuVW1HTitEWXhFZXlVMkZzOVlsbFFIcE1G?=
 =?utf-8?B?MTFDYkVod0J2ZzBTZ3Fremk4U3o1YTlFaG5yMi9xQjFPTXpDUjQyZlg1L1B2?=
 =?utf-8?B?WXI2YSs4aDVVN3o0WGM3UkwyWjdDZDJkUUs2VHF2TW5wYjE1RmgwOGs0WC94?=
 =?utf-8?B?V2J2MXlvdWczTWlKVUNwMnU3RDc3U2pQYXRFZGZmcitrTEk0SlF4WjlWQjVJ?=
 =?utf-8?B?NDBMS2RlcGVHcklkNzg5MWdDN3hzaHhFMTM2MVMzZ010VTFNS2tJVFZocFlL?=
 =?utf-8?B?eGk5Qml5czNZWmt0REVnZVhzUFRWUGJaN0ZzRXp3SEl2ci93bEowRTJxdG54?=
 =?utf-8?B?K3NPQkpJalpwT1h1Y2VlMkIyaGVpWENlbVM2aENPdkpObzZvaHNiUHFlcEtM?=
 =?utf-8?B?MGp3Sk4zM0JXRjdGaFBEMmdub1JodGtzOXBJV0NjK3ZjM0RIVyt6WGozWlNZ?=
 =?utf-8?B?RTdQenQ4U0IxVXgyNzVIemhOeDh5V1dTbVU0VEpuNFRGd3hYRlNGdmZDV0dk?=
 =?utf-8?B?ZTNlSzdIL044TFN0QnBPYURGS3lqVE9UVEhUME00VjJzY3JGMjlIdWgxNWcz?=
 =?utf-8?B?RURoQ0poSElTTmRORHhzVi9xaWNLa0MxeEJ3MzAvbDJiZTV1YnJ5NDRyWHlW?=
 =?utf-8?B?WUt0bkR1dGFYbTg2Zm1RbVdrTy9DeVdIVUxBZGV4WjFXdCsyTEhDMUJTczZ3?=
 =?utf-8?B?UXRRdXVvZkx5MWJSNXBhYnN0bWZPbWc4cWliZVV5eVphVTlySWg0Y3F3Mzlu?=
 =?utf-8?B?NmhvU3BDYkZCUHpteWxHbnBVZ1lueURGUG55QzlMTGIyaGN5S1F3ZWVaSk9D?=
 =?utf-8?B?ckZDMG9ZOERsQldkT1k1dWtkSDgvaWZnTzEvMVVBaXYzOGhITXluOFNVRWZ3?=
 =?utf-8?B?L1JMcDZjUFRGYk1mclFhOFBrajkyOGU1Ukk3VVFKczhCVEZUZTl0NDNoWXoy?=
 =?utf-8?B?ekRUOXJ5WkhjTVd3cXNKTmZYbGZkSXBwZnV5TGpHZG5UMnBrVG5tRmZFUStp?=
 =?utf-8?B?TjF1ck5KVk5iYjlyT2ZNUDk5cG9lKzVTTldJVktPL0ZUS1h4UHJRMU9yWmdl?=
 =?utf-8?B?YjltUEhUY1JlRGNsbGdUclRydTFqSmd3dCtOZVlHSE5jVVdRNFVybHpUMWtz?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jfPsU2ExpFZ7c7J7ooUSyCFOTXuUwZOdRBHZsObIR659aGsEZsxJo9khi6Pgt7B9ApF3XkHymqb5EOPQffXv5KCkNCyMjaGWsH50uuoEbNX9nc2RuRuklRoMq0+dIHUgrG2UtHAxUnJWe6YbBk07kbYy0b9DmdLv6O5wRQ+oCOmrBRuSf+e7U/FK971j0cItrzYSLtr2UoNoHSeYPpgshOWUinRbsAaKWeXrqSrMd2FwEMAbXI3ZBx/AuvqqJp22kJx0HeCCz+Sz+eDu5LGIydI15Xq/AjrbM4dS0DhWPvLy1VdDYHI6qaJlR0et7uL3hFD+BjVw016byG/7CTgq74DPXzs3vIhMGD6PFM8UsoL+CrE9K5Wpt0I8eynwUAOos7dJfQeVJKT46jVx5tt+i2u8zaUfxyFgDuv1WxDIe8w56aShXwBx4RRtc6XXGVCnMU7LWHP0aTrIi1vg80iRn2Ntj3y54xVBPTRX0/rss4noEER5Qqlqn9rFNKV+3a//p+dFFdFjB5kM+cHHPEbfq+FY9AypKoXV3JhbhYvtJNb1TQfJSqMGRVsBmAYppVIFVCrWwPlXRQRQoOxswxeSynN1wWXBt28qqdzx98Qp0SA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30e0e62-e3ac-4c42-b6c4-08de114ca1a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:23:16.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mFmgMdaR1QWSE4qR4jRb4SGsAqtsclMgmrR1oK7YCH7McIqncCnD6ga07SiLnu+IuZlrkaaU7wximSEHK+Wdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510220075
X-Proofpoint-GUID: iYMp-lEhhjJzoeS3MlirDUph9v9bAqYE
X-Proofpoint-ORIG-GUID: iYMp-lEhhjJzoeS3MlirDUph9v9bAqYE
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f8a287 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=lED_Ue-IKTDqDgYwxTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfXz1PDXuB5rkBT
 jhBx955CWhUYX+5ZrFa05AyvsuOBkJZYpdfj7TXwXqcmAlNGpXlb/PvgP0X2FiMpK3kYDcVgEku
 hlWjGXbv/wpfUe81CpN1nVu51tOpEIf+uiAupeC4ENh40gqOQDK4DU1w2QjuVZS/bVxpX4fA4Be
 d2kqWLl1RYANtAncvE1P283jkT6XbMfbuKhycjeUwT6Mv7fUj21tA1NmnHprqCND9JX7PX4eanv
 wfPJss79G8LZmA6a1d0zIsEhCLU/0JaaZAsAItYsydIJWzu5xSQb964ek9GanVolWuLXSOH5b73
 CIH8bksjJ+t1Rd7K9EI8q3cFBauu+ExGJBgAroZshDqtlaOo+dSnJjLkuN/LN9gfeh/DIpcMn4z
 hy0+q5Rfs6K0FPv5gBU4mV+QF/PmTQ==

On 20/10/2025 21:44, David Faust wrote:
> 
> 
> On 10/20/25 13:11, Alan Maguire wrote:
>> On 20/10/2025 17:01, Yonghong Song wrote:
>>>
>>>
>>> On 10/20/25 3:53 AM, Alan Maguire wrote:
>>>> On 03/10/2025 18:36, Yonghong Song wrote:
>>>>> In llvm pull request [1], the dwarf is changed to accommodate functions
>>>>> whose signatures are different from source level although they have
>>>>> the same name. Other non-source functions are also included in dwarf.
>>>>>
>>>>> The following is an example:
>>>>>
>>>>> The source:
>>>>> ====
>>>>>    $ cat test.c
>>>>>    struct t { int a; };
>>>>>    char *tar(struct t *a, struct t *d);
>>>>>    __attribute__((noinline)) static char * foo(struct t *a, struct t
>>>>> *d, int b)
>>>>>    {
>>>>>      return tar(a, d);
>>>>>    }
>>>>>    char *bar(struct t *a, struct t *d)
>>>>>    {
>>>>>      return foo(a, d, 1);
>>>>>    }
>>>>> ====
>>>>>
>>>>> Part of generated dwarf:
>>>>> ====
>>>>> 0x0000005c:   DW_TAG_subprogram
>>>>>                  DW_AT_low_pc    (0x0000000000000010)
>>>>>                  DW_AT_high_pc   (0x0000000000000015)
>>>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>>                  DW_AT_linkage_name      ("foo")
>>>>>                  DW_AT_name      ("foo")
>>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>>> deadarg/test.c")
>>>>>                  DW_AT_decl_line (3)
>>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>>                  DW_AT_artificial        (true)
>>>>>                  DW_AT_external  (true)
>>>>>
>>>>> 0x0000006c:     DW_TAG_formal_parameter
>>>>>                    DW_AT_location        (DW_OP_reg5 RDI)
>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_decl_line       (3)
>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>
>>>>> 0x00000075:     DW_TAG_formal_parameter
>>>>>                    DW_AT_location        (DW_OP_reg4 RSI)
>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_decl_line       (3)
>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>
>>>>> 0x0000007e:     DW_TAG_inlined_subroutine
>>>>>                    DW_AT_abstract_origin (0x0000009a "foo")
>>>>>                    DW_AT_low_pc  (0x0000000000000010)
>>>>>                    DW_AT_high_pc (0x0000000000000015)
>>>>>                    DW_AT_call_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_call_line       (0)
>>>>>
>>>>> 0x0000008a:       DW_TAG_formal_parameter
>>>>>                      DW_AT_location      (DW_OP_reg5 RDI)
>>>>>                      DW_AT_abstract_origin       (0x000000a2 "a")
>>>>>
>>>>> 0x00000091:       DW_TAG_formal_parameter
>>>>>                      DW_AT_location      (DW_OP_reg4 RSI)
>>>>>                      DW_AT_abstract_origin       (0x000000aa "d")
>>>>>
>>>>> 0x00000098:       NULL
>>>>>
>>>>> 0x00000099:     NULL
>>>>>
>>>>> 0x0000009a:   DW_TAG_subprogram
>>>>>                  DW_AT_name      ("foo")
>>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>>> deadarg/test.c")
>>>>>                  DW_AT_decl_line (3)
>>>>>                  DW_AT_prototyped        (true)
>>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>>                  DW_AT_inline    (DW_INL_inlined)
>>>>>
>>>>> 0x000000a2:     DW_TAG_formal_parameter
>>>>>                    DW_AT_name    ("a")
>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_decl_line       (3)
>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>
>>>>> 0x000000aa:     DW_TAG_formal_parameter
>>>>>                    DW_AT_name    ("d")
>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_decl_line       (3)
>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>
>>>>> 0x000000b2:     DW_TAG_formal_parameter
>>>>>                    DW_AT_name    ("b")
>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>> change/deadarg/test.c")
>>>>>                    DW_AT_decl_line       (3)
>>>>>                    DW_AT_type    (0x000000d8 "int")
>>>>>
>>>>> 0x000000ba:     NULL
>>>>> ====
>>>>>
>>>>> In the above, there are two subprograms with the same name 'foo'.
>>>>> Currently btf encoder will consider both functions as ELF functions.
>>>>> Since two subprograms have different signature, the funciton will
>>>>> be ignored.
>>>>>
>>>>> But actually, one of function 'foo' is marked as DW_INL_inlined which
>>>>> means
>>>>> we should not treat it as an elf funciton. The patch fixed this issue
>>>>> by filtering subprograms if the corresponding function__inlined() is
>>>>> true.
>>>>>
>>>>> This will fix the issue for [1]. But it should work fine without [1]
>>>>> too.
>>>>>
>>>>>    [1] https://github.com/llvm/llvm-project/pull/157349
>>>> The change itself looks fine on the surface but it has some odd
>>>> consequences that we need to find a solution for.
>>>>
>>>> Specifically in CI I was seeing an error in BTF-to-DWARF function
>>>> comparison:
>>>>
>>>> https://github.com/alan-maguire/dwarves/actions/runs/18376819644/
>>>> job/52352757287#step:7:40
>>>>
>>>> 1: Validation of BTF encoding of functions; this may take some time:
>>>> ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
>>>> sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''
>>>>
>>>> Further investigation reveals the problem; there is a constprop variant
>>>> of ip6_make_flowlabel():
>>>>
>>>> ffffffff81ecf390 t ip6_make_flowlabel.constprop.0
>>>>
>>>> ..and the problem is it has a different function signature:
>>>>
>>>> __be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
>>>> flowi6 *, bool);
>>>>
>>>> The "real" function (that was inlined, other than the constprop variant)
>>>> looks like this:
>>>>
>>>> static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
>>>> *skb,
>>>>                       __be32 flowlabel, bool autolabel,
>>>>                       struct flowi6 *fl6);
>>>>
>>>> i.e. the last two parameters are in a different order.
>>>
>>> It is interesting that gcc optimization may change parameter orders...
>>>
>>
>> Yeah, I'm checking into this because I sort of wonder if it's a bug in
>> pahole processing and that the bool was in fact constant-propagated and
>> the struct fl6 * was actually the last ip6_make_flowlabel.constprop
>> parameter. Might be an issue in how we handle abstract origin cases.
> 
> Yeah, I think most likely 'autolabel' was const-propagated and *fl6 is
> the last real arg as you suggest.
> 
> I'm not an expert on the IPA optimization passes, but I don't know of
> any that would reorder parameters like that. 
> 
> OTOH, I see a few places in kernel sources where ip6_make_flowlabel is
> passed a simple 'true' for autolabel.  That sort of thing will almost
> certainly be optimized by the IPA-cprop pass.
> 
> Note that you may have _both_ the "real" version and the .constprop
> version of the function.  IPA-cprop can create specialized versions
> of functions so places where a parameter is a known constant can use
> the .constprop version (where 'autolabel' has been dropped) while
> other places where it may be variable use the original.
> 
> IPA-SRA (.isra suffix) can also change function parameters and return
> values, but afaiu it does not reorder existing parameters.
> 

Thanks for the additional info!

Looking at the specific case, here's one instance of the inlined
function's representation:

 <1><be25126>: Abbrev Number: 35 (DW_TAG_subprogram)
    <be25127>   DW_AT_name        : (indirect string, offset: 0x3bce6f):
ip6_make_flowlabel
    <be2512b>   DW_AT_decl_file   : 3
    <be2512c>   DW_AT_decl_line   : 952
    <be2512e>   DW_AT_decl_column : 22
    <be2512f>   DW_AT_prototyped  : 1
    <be2512f>   DW_AT_type        : <0xbdef11c>
    <be25133>   DW_AT_inline      : 3   (declared as inline and inlined)
    <be25134>   DW_AT_sibling     : <0xbe25187>
 <2><be25138>: Abbrev Number: 20 (DW_TAG_formal_parameter)
    <be25139>   DW_AT_name        : net
    <be2513d>   DW_AT_decl_file   : 3
    <be2513e>   DW_AT_decl_line   : 952
    <be25140>   DW_AT_decl_column : 53
    <be25141>   DW_AT_type        : <0xbe019b0>
 <2><be25145>: Abbrev Number: 20 (DW_TAG_formal_parameter)
    <be25146>   DW_AT_name        : skb
    <be2514a>   DW_AT_decl_file   : 3
    <be2514b>   DW_AT_decl_line   : 952
    <be2514d>   DW_AT_decl_column : 74
    <be2514e>   DW_AT_type        : <0xbdfd253>
 <2><be25152>: Abbrev Number: 40 (DW_TAG_formal_parameter)
    <be25153>   DW_AT_name        : (indirect string, offset: 0x10853):
flowlabel
    <be25157>   DW_AT_decl_file   : 3
    <be25158>   DW_AT_decl_line   : 953
    <be2515a>   DW_AT_decl_column : 13
    <be2515b>   DW_AT_type        : <0xbdef11c>
 <2><be2515f>: Abbrev Number: 40 (DW_TAG_formal_parameter)
    <be25160>   DW_AT_name        : (indirect string, offset: 0x3bcc9e):
autolabel
    <be25164>   DW_AT_decl_file   : 3
    <be25165>   DW_AT_decl_line   : 953
    <be25167>   DW_AT_decl_column : 29
    <be25168>   DW_AT_type        : <0xbdef194>
 <2><be2516c>: Abbrev Number: 20 (DW_TAG_formal_parameter)
    <be2516d>   DW_AT_name        : fl6
    <be25171>   DW_AT_decl_file   : 3
    <be25172>   DW_AT_decl_line   : 954
    <be25174>   DW_AT_decl_column : 21
    <be25175>   DW_AT_type        : <0xbe100ac>


And here's the abstract origin reference to it which I believe causes
the trouble:

 <1><be2708c>: Abbrev Number: 205 (DW_TAG_subprogram)
    <be2708e>   DW_AT_abstract_origin: <0xbe25126>
    <be27092>   DW_AT_low_pc      : 0xffffffff81ecf390
    <be2709a>   DW_AT_high_pc     : 0xa2
    <be270a2>   DW_AT_frame_base  : 1 byte block: 9c
(DW_OP_call_frame_cfa)
    <be270a4>   DW_AT_call_all_calls: 1
    <be270a4>   DW_AT_sibling     : <0xbe27268>
 <2><be270a8>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <be270a9>   DW_AT_abstract_origin: <0xbe25138>
    <be270ad>   DW_AT_location    : 0x18ed328 (location list)
    <be270b1>   DW_AT_GNU_locviews: 0x18ed31c
 <2><be270b5>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <be270b6>   DW_AT_abstract_origin: <0xbe25145>
    <be270ba>   DW_AT_location    : 0x18ed363 (location list)
    <be270be>   DW_AT_GNU_locviews: 0x18ed359
 <2><be270c2>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <be270c3>   DW_AT_abstract_origin: <0xbe25152>
    <be270c7>   DW_AT_location    : 0x18ed399 (location list)
    <be270cb>   DW_AT_GNU_locviews: 0x18ed38f
 <2><be270cf>: Abbrev Number: 7 (DW_TAG_formal_parameter)
    <be270d0>   DW_AT_abstract_origin: <0xbe2516c>
    <be270d4>   DW_AT_location    : 0x18ed3cb (location list)
    <be270d8>   DW_AT_GNU_locviews: 0x18ed3c3
 <2><be270dc>: Abbrev Number: 16 (DW_TAG_variable)
    <be270dd>   DW_AT_abstract_origin: <0xbe25179>
    <be270e1>   DW_AT_location    : 0x18ed3f6 (location list)
    <be270e5>   DW_AT_GNU_locviews: 0x18ed3f0
 <2><be270e9>: Abbrev Number: 55 (DW_TAG_formal_parameter)
    <be270ea>   DW_AT_abstract_origin: <0xbe2515f>

So what you see above is two things. First the order of parameters is
not preserved; specifically the original function and inlined function
representation it is

net, skb, flowlabel, autolabel, fl6

...while the non-inlined references via abstract origin has order

net, skb, flowlabel, fl6, and finally autolabel (with a DW_TAG_variable
inbetween).

And secondly what's interesting here is that the other parameters all
specify locations while autolabel does not.

The problem we have is that

1. pahole does not attach any significance to reordering like this and
does not detect it as far as I can see (I've also observed similar
patterns in inline site representations where order differs from the
original abstract origin function)

2. pahole also does not enforce the need for location info for a
parameter (implicit assumption being that if no location is present it
is in the usual calling-convention-dictated place)

The combination of 1 and 2 leads to the problem observed.

The DWARF spec appears to mandate source code order for parameters but I
couldn't find any equivalent mention of abstract origin parameter
references.

From the above empirical case and others it _seems_ like the ordering
_is_ meaningful in cases like this. How we extract that meaning without
breaking other things is always the challenge though.

I've started experimenting with detecting location misordering in
abstract origin references in the work-in-progress location code since
it does more extensive parameter location handling. There are a fair few
instances of misordering detected, especially for inline expansions it
seems (likely due to more frequent argument omissions at inline sites).
I'm hoping detecting misordering combined with enforcing location info
for misordered cases might be enough to detect and handle cases like
this, but as always the worry is other stuff gets broken as a
consequence. I'll report back when I have more data.

Alan

