Return-Path: <bpf+bounces-29440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23328C1FAB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F5128366F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4F15FA83;
	Fri, 10 May 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fdWguG9e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hBYV46P/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D8C136
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329634; cv=fail; b=qQhGE/+Uy+p5/HzqU26J4DmH3UR/fIwLQeAXGsGb6iVh7x+GmuXsojmMfEdTwNeFcpuPHle90QP4TEHdEn0H/pVH8ebHcSnBoxTtaEpI5QrrrHkFdvyj/S0yiVYq/eVkadpY0k8bZ/n0Jhi7LtZWG+zelt6FMRlHn5JKwPZxMk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329634; c=relaxed/simple;
	bh=K8mgF9CcXN02Z5mfj1CA6lqsAVOveXUUrkzlWh0sdEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=ZjRGNRQNFgs5VqB24urlzu0rl/MTTyQIrtSLNHiGSZlWPZ4qhWb7/VpkYfikOKlTI0vmPJTOyV1tM1AJWI5Hafw+6qtyggXRcxpxhunrb6pgDiI5V58j3xwl76G6fu6VAYiURiHN8VVQJHzlKnhOgc+EzL1zYNFPJLFOnVSSD9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fdWguG9e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hBYV46P/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A8NLXK008749;
	Fri, 10 May 2024 08:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=D4+dVBLJRhhO7TOmlW4df2tji6cBImltAJFZYpdbfSw=;
 b=fdWguG9ezhg9ll8bHionMaMo/F3zMPf+vZLBYEChpKtAA0oy+70eY5FjOkvrV7Is+d55
 sMTBHR0a+XlcUmA6hd+BX1uoYorsmvhPwLPrfZHpyPgJ++xwm/TYAi3Scctn3vRd+n57
 5Pw6s56yUwyZslfi8Y27I+kndcvNMOCBy0L9HRkZHFfFwTP2jo3SHDWcHBGybA/cycI0
 NhT9GOnbe2x5NFM0pMhiQdpJf+Bb912Gbp4UySPJJ5uiICMy+2Nc/BQRHx6f/Frgwv2u
 h6w7qoLKwg/E12NoTZc67VqDHbg6TpJ7DiUu6j+Gj5y6Fl2bP75zllNWI7Qtl1IHYQY9 /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y16p00pa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 08:27:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A6KHFH024358;
	Fri, 10 May 2024 08:27:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfqv43a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 08:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRXWO5JCEI/8Tmpbo23mV7QHgHvNyzGRU7Et9Jm7ooKCcXWunNkAuOsiH4W0x1PTs3W+Zn5ePlXrbkEHagq0zksMQy1GJi3rpCbHDjbc0n/xHtq/yStJJjkQjhwNUFTTIRacoF2Qo00PzmGZFhcV1y7C2NyPVi9qPUPBa+Be92HPrBh8oscldbgJYOqprKUwYXA1LLKB7L+im85jFOzYskFADOiACsixmBXs3x00KKNGauLoqhD9eGeJtuAZLZ/JXO66Ld1GAB/D9sffJbjQ5+WkQysytk1/h/4JD0VUW/Qi3x9qPukLVRjlM4dZeXWRkNqxsqqRgIcUDM9triRlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4+dVBLJRhhO7TOmlW4df2tji6cBImltAJFZYpdbfSw=;
 b=YWloCy0pZbl3f8Onl16Il9MiacwzsAdUo5tlhXEvSarhtm5acgHttpyhMZpFxTQbHgCQBD8ySFcDBTNVMUN4j/qfJ0AtaUUG0AOw144fzMWU7f5Q87PaOoXT9hF4S9O5gfLG6tcdrfoZssDikLHFDJWsqvt0Q2OKMSOi0KIPEjfQ4BePt+RIrCzcmeqxm8x485g4uANfFlqCFftUKZ9inP2B9rfBf9326o1bqekBShhPWPXCkc1MEaSx2o37519QRNq6HYUl5iKzsqKd9U3ivYwQBe8E/vvgWQnCVmDnvpOO8Icqjnx7tuVuL7RJ8XTB3oyb4Tf3plABoPKk09zH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4+dVBLJRhhO7TOmlW4df2tji6cBImltAJFZYpdbfSw=;
 b=hBYV46P/cn6JGLTJPREq8766oxobEDhCZTrPKJni5iSFbdeU3x2thjjFKXsNYhBW74mNtKe08OBr3HiEw6LQyDPkkPWPh/3hyN5DQrt2vSVOFlQQIjk6n5ESf0E4wr6aczbLjvUiOOGmm6fwAjZPQ9IqUtNHfKrPJ3ijXhNqbWI=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 08:27:04 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.045; Fri, 10 May 2024
 08:27:03 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH bpf-next] bpf: make list_for_each_entry portable
In-Reply-To: <CAADnVQJRpCX+vmwCu3xYz+V4Bq1gn3vnCAZk3CAJcB3KUq_-Cg@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 9 May 2024 14:48:58 -0700")
References: <20240509084650.17546-1-jose.marchesi@oracle.com>
	<CAADnVQJRpCX+vmwCu3xYz+V4Bq1gn3vnCAZk3CAJcB3KUq_-Cg@mail.gmail.com>
Date: Fri, 10 May 2024 10:26:58 +0200
Message-ID: <874jb62ht9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: f38eb3f1-d302-4a92-0805-08dc70caf84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmFsd2xEWWROTENXQ1A5MzBxaVFaUjF0a2JGcjRPNUFRQVdGZ3k0R0tjZGlP?=
 =?utf-8?B?dW1VYmlCVFNFK0p4SXc1TjhTbTNFRWtBNmozd0ZmbFJ4UGdxOUlXYXg3WFpP?=
 =?utf-8?B?cDltdGp3bEczS3V4UTErL2w3cmY3UjNGRTFHc0ZYR0NYdUdHdGRLMnZ4Zkpz?=
 =?utf-8?B?SGZDWHppQjdyRXlocFphc3EyRnhJQTJLUXdCSWJUYzdVclhiSithbDhlbyt4?=
 =?utf-8?B?Uk5xK29zNFA5cUJoL0trODZheTRzYStSU016Rk9zS2lGYkRIdENGekFCU2dw?=
 =?utf-8?B?WXZJa3l1aXZ3dGhHUnUreHhzK01mdlFjdWp5SUxLTWFWWVUrRFN5Ync0TCs0?=
 =?utf-8?B?ckVqK1ZNM0tpVjNVRWxmWkNSOFo2L3Q3UWhDVDAzbkJCNnh6T3QwdFcxb1Fw?=
 =?utf-8?B?OWtUUGJkMVZ3M01EbjNHbjlCWjJ0UTVuNFpjNTZFNWdFMXN6MEdBRTd1S3Bt?=
 =?utf-8?B?VGZjS1Qwb1gxSlNEUTdEbzl3ZGFoK0ZJMGY1VVZPdllLUWNJNVErWXhsUkdW?=
 =?utf-8?B?dGNsVDRiRExsZk94VEd6MjM5Znp3M2RrUzdzMUVSYmdLbC84WDdadkFkQ1ps?=
 =?utf-8?B?YXN1aWk0M2I0UFNyNU0wb2kyWERVT0ZMSkdxTHUrRTBFN0Mwc0FpQzhDbUtj?=
 =?utf-8?B?TmdJam5UeTBFU2gvN2hIbzVSSFJibEhjSUx1SmNmaFdjbjErQWlkOExYQW9Q?=
 =?utf-8?B?eFRKbW9ldS9RRlhKSS9QRHV4NjlST21xMGZYRkxXMFlocDlYQVFmMENFVDBu?=
 =?utf-8?B?RW9XTVZmbmc5YmtsdFZjTjJVRTh5SGJpUThUNlFoekRGV2pXY2FhWDRkVGJF?=
 =?utf-8?B?bEllWG1mYm1McmNyODEwWDgwd0RFemVuNnNtaWNLSjgwZFZ4WlVTYmNteEFI?=
 =?utf-8?B?MGNmK1lQZStBcllma2FVMjhMNVN1alp4bVdMQk1TL1FIbHUwOXNKN25FVmk5?=
 =?utf-8?B?MW80SHNjdytlSVBkZGVaWHZrRFQrakdsc25vWitZd2VZWllIbE55ZkNDKytJ?=
 =?utf-8?B?a3o4andBWXFCbTJtSFhadmFFZkZZRnc5RWM2bTUzbUVTamNBKzFneWs1Zy9Q?=
 =?utf-8?B?RlY4S1RrcWRnSTk4U1Z5V1AxUE5nOXA2ZVBqL05EM0FJMjNKUXo1R1lvUTV1?=
 =?utf-8?B?cm1keGtpVlVoODNZZWpjazVYNVZjNTJiSjBKUG1qWTBMNlhEYWVPMnpCdjlq?=
 =?utf-8?B?bXFEOU5Kc2ZzdmRHMGE2NytkQ2V4b3J3VVNLeWcxL3hGSUE1NXZ4QmVvNTF2?=
 =?utf-8?B?SUdVUjd3NStSNE9yeForSmh3aXorUlprY09MZWwrVVExeDVmRTkxSWFnYlcv?=
 =?utf-8?B?N0V6RjhEZ045OStaZm1vWXhPOUpDNkpXRnBVRllaMFZzZkxkdkQ0TndSWjZj?=
 =?utf-8?B?QUNkN2FjT1VidUloaitGVGxrSnRtd0M2a0NVdC9PL2ZobkJMTHpYTkZPQUpv?=
 =?utf-8?B?djFhMTZ6d21yRXk2bFNmdWRZWk54Rm9nK3gxM0RtMnVKRTh0U3JKYjQzRm5r?=
 =?utf-8?B?TDV3aVBLb3lyRG1QYjRpbGdNVnBkTnhjN1BxS3lYRlhUSis0ZERNTm1XWTlG?=
 =?utf-8?B?NGtvaFBLdU1ZS1VMVFo1dHQ4bU0xdWNibDBRT2ZUMGlleGo5SjVpTFFiMzNV?=
 =?utf-8?B?QW01MGFnTEk3K3Z4YjVJb1Njc3g5TW12VXZhOHRiYTc3NnBLeE5KeXZNN0FB?=
 =?utf-8?B?YzZkVTk2alpEa2Jvem5rNzBKdzFUc1ROTUpOYXhISDhCQjRrNVlsSG53PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFU3M2ZaRFJyaWVEeGVOalRMTUsvdVhZekRWbTFaMUZmNXhiK1k0NFMvR3gx?=
 =?utf-8?B?ZnI0NnVCVzd4UFZyd0tiNjBqWDlxVlpiTGNLZHdBclcvQnIxQmMvOFRXSVhO?=
 =?utf-8?B?bndsQ2xVSVlUTEJKbG5ObGQzbWpUWnVZUmV5Ti8vSTU3OHpDNUVRSVdYMXEx?=
 =?utf-8?B?cnZZbThXb2dpdTUzM3BpMXRpMkU4R1dqM3NrRzJtRkF2SUZ6NlZxTit4bzV0?=
 =?utf-8?B?VTVhdGtqVTQxYVFqVGd6S3U1em1YeUJwTXNScG55OG1nZ3UxZU8xc251MXVQ?=
 =?utf-8?B?RFdXbGJ3N2htOUE2SXNyRlRjUkNJVUl3SDRIMlBvbUhwU3hDQWVCZmRZcTN3?=
 =?utf-8?B?RXNrYjhQV2x6MzhNcXM3TWFXdUVKZHMzajZaVmx3d2ROK1ZEWkk0MVpRTEsv?=
 =?utf-8?B?MjRQWHhZL3ZNdGIvUWRVR0VkTmswSlV2N2Q2enh1SXFUdnZiVi84NG5nbXNY?=
 =?utf-8?B?TTZPb3liQnFCaXY3UlNPSjV0S1VvUDJ6OEYvMnFzN0F1YjB4T1QyT0FUQVpw?=
 =?utf-8?B?OFY5WlRSWFdvQTgwajBYb29mMkhkR0Z5cnFsbTNuWk02UWdXTGF3TWw0bEpV?=
 =?utf-8?B?ZmlvM1pqQWVXOE85Uy91S3ViVzV5cG92b2RhNEx6b0htSEJ3dlRDZDlsQjBa?=
 =?utf-8?B?SFhLYzhkcU5sOGFsbjg4OUZNSHNTVDA5TmJRallZTnE4eExYU0lmZlNvYStp?=
 =?utf-8?B?U3BOMDNuRUxpVE9rblN1Y2JPL3FORHFSWWVpN2pzdTVpV2hZMmJ1MUJNdHZl?=
 =?utf-8?B?VW5qMTNpVmhGME5LaW4ycTRjcUh5YU9vQXdiR1FPdUh6c056VkM0WUhOTEs0?=
 =?utf-8?B?VWw0bUE5b2RKVWo3NGo4NTNSWXhaR3Uzc1p0NTdmSHViRWRVT3hwRTNnN0lL?=
 =?utf-8?B?ZHMyS0hnWDY3OVVPcVlub3BDbHNYQk9KMDhJdUtZZ0NVaXJRZEE3MWhrNzBH?=
 =?utf-8?B?bWIxTnEveWZ1UVZ2YlBrTUxwSEE5VTlZMnE2VWF5VUkraUxCUDdSRFllRzJT?=
 =?utf-8?B?bmFsV0FqQVNIc1lHQUFBSkk4RGF4VjVNMm1LWURSMHFnTHhCMzJEbEpBRXA3?=
 =?utf-8?B?N21lYUNpVkhQakpFWTRLNHc1aFBaS09TVEczYi9jY2xvVHkvSzJ0TjdoVGRS?=
 =?utf-8?B?d1RBQ05RN1UydWVhK1JDd1FnNVdvU1c0SHYzT3lOQTZ2R2ZzS09OSjIveUZ0?=
 =?utf-8?B?UWhKbll4U2lLNmNsTzg5aXd4Q2daOHh3RHN5aktHNExFMVVHdWlJa2x5MHRW?=
 =?utf-8?B?QUQ4cEpoblRUZU80MVE1cTd1ZzhPUzYvbk1qclgzZzhNUlNWcFJoQXBUbjdL?=
 =?utf-8?B?eEREQVlxUUFTNSt2OXVtQzNabzEwT2FTNExLVm5ES3JQWHZkZlNOSU5tY3RU?=
 =?utf-8?B?UWY2a1Rpa2xCalNuRUpFS1c2RVpmcWExZURFRkFjcnNHRjNwcWVrVGVEKzZs?=
 =?utf-8?B?Sk5hSktiS3BnMEx6WGZrWkVhckw2T0VFUmVVeVc0K2lWOVp0WHZ5U0dLbVBI?=
 =?utf-8?B?MFRIbURZYzJpODRBWVM2N3B1RXM4cGxHM2F3VU01Y2xlOHFTeFJxYnhtYTBa?=
 =?utf-8?B?YmlkV1krSzU4dFd5UFNsUkt5V2R2OVRtcDlOcUtTcTY5YlFPZnc5cG11ZTBD?=
 =?utf-8?B?TmlMOEJKZXhSRmRnclRkajRiUzU5T2VRei9qTm5Od0VzcTdYUWp1NVJkVWxR?=
 =?utf-8?B?Z0JodHhEQlNYMk9SY242cThlQ2VmemF6cU8zdEtieGZwWTVnMzQzN3JDM2xE?=
 =?utf-8?B?MWFzRDUwVEp5RktraS9CSHlIQUhYR3QrdGNKdXc3ZUNGeVZjK3QxZE5GdWZX?=
 =?utf-8?B?cDJsazVhbzdOWmJ3RkJVQ3dvSFlCMGhjeHdQNFFxVjdKTDAxY0MvcW5zRkNF?=
 =?utf-8?B?N2drV0VHeHhNbDNrTXRyNGF0U09sSHlqZGZxUFVXTnM1cVVVdEQ0aFlCcDM2?=
 =?utf-8?B?RTBPbSswc3RjY2M0RGRQb2VNUStXQmhFd2hnbGdhM1dvaUEycU1ZTXhUdStQ?=
 =?utf-8?B?Yy9RbWdXZDd4NksxbURVYnJiNFBXT3RuNXFOTjVhbkh5bk1YSkdYczNyblpK?=
 =?utf-8?B?ZGd1bkUxNU5yWFE2N0dkTldjRnBoZDZpQlppUXNhM1Z0VnFnSnRWVm4xRnBq?=
 =?utf-8?B?ZFRoUk9tbW9qeWZEVUVVTGhadkNQeVdwUGE1YkF5djl0YkpIaVBvODRZbk5Z?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TJ+puG0AJrE4dRXFsqRpYebc+H3RibN99c/HUwkJlhDZu19KCxYZZ0Fss4zPkExUt09MaacYcS2QPT3VRnZmjHsbIEwHVbCOSZ1cKc4KRfbob2gW6g5CnF6jFk0Lo/KUte6zU9tXIMp/7H+hXASaKFHrniFbphw/BfZa3AoEw5Ho/6KwVJFVFoFVY/LTS8K2Pe8m1Y/dVoloXt16CsB/kaQsZMwOML+/xamp6fSOmItt4COYbJs+YSU3UWHYiS9Qk1yspb7a8kbBcrSwLuXxTIUZ3pyj89huTTc6ngD82MhKdk3h6Hwt5Epf3qBHsD8SyfBgaFvO3J4UfxTFbzV+c3L518AtSEDtKpMkA+atnoxLZVgWQTWLNZavRk+jk9IZtRMSe8DplJvcZQOn/lXUoGb3MvWc84VRUijgGUY+n5bgBfZVMZk+ivuxTZQFIjFtf2Jmr1pyX0dEinV0SCEDkuWh03KggeJiNEIBSN3LBCLDvw2vshmwfxWyVyFHxhXJsc/PBBf/pawabOUnJDGGwzcyF1xrSb+QtcoVNRVpBUawHemj5gL5k0MxwRfpeoHGCsLHP+iubg9I/KNhDNDDf9GhH9vQ0kDtD0SA6fkZl0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38eb3f1-d302-4a92-0805-08dc70caf84a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:27:03.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tYy5ckDcVrAq9wDgXqb6Sfa1ZtNFGLNW/Nk3Ghz2CJRVPlvnZvlrwMydTJ2wvIgB8b8leRKWWIF0smbNV9Is1xw+CzczFKQemEaxKS7Cr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_06,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100059
X-Proofpoint-GUID: HeO8kO997QWHw1huD2A-np4LnTZMApfL
X-Proofpoint-ORIG-GUID: HeO8kO997QWHw1huD2A-np4LnTZMApfL


> On Thu, May 9, 2024 at 1:47=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>> +/* A `break' executed in the head of a `for' loop statement is bound
>> +   to the current loop in clang, but it is bound to the enclosing loop
>> +   in GCC.  Note both compilers optimize the outer loop out with -O1
>> +   and higher.  This macro shall be used to annotate any loop that
>> +   uses cond_break within its header.  */
>> +#ifdef __clang__
>> +#define __compat_break
>> +#else
>> +#define __compat_break for (int __control =3D 1; __control; --__control=
)
>> +#endif
> ..
>> +       __compat_break
>>         for (i =3D zero; i < cnt; cond_break, i++) {
>>                 struct elem __arena *n =3D bpf_alloc(sizeof(*n));
>
> This is too ugly. It ruins the readability of the code.
> Let's introduce can_loop macro similar to cond_break
> that returns 0 or 1 instead of break/continue and use it as:
>
>         for (i =3D zero; i < cnt && can_loop; i++) {
>
> pw-bot: cr

I went with the ugliness because I was trying to avoid rewriting the
loops in the tests, assuming the tests were actually testing using
cond_break in these particular locations would result in a particular
number of iterations.

The loops

  for (i =3D zero; i < cnt; cond_break, i++) BODY

and

  for (i =3D zero; i < cnt && can_loop; i++) BODY

are not equivalent if can_loop implements the same logic than
cond_break.

The may_goto instructions are somehow patched at run-time, and in a
predictable way since the tests are checking for explicit iteration
counts, right?

