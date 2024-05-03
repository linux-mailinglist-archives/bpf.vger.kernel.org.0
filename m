Return-Path: <bpf+bounces-28498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD178BA838
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA491C21938
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF971482FA;
	Fri,  3 May 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j8aZdOGf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nSKZ1fph"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1712B89
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723258; cv=fail; b=XjkXA1f8KnOgdB9V4pRzzcHA7B8ujUCIpGKBE02Fo5Iw877yGmb51cJ03ivhEZN8kIzKbYcR82d3N+uQGmFyBDSlmFSHXnd6Q+/3IasP7blpn3Vz2SqDDJ+aITyFD690FLTkAVzw0963qO8PTRSDU+yXE34BHtuI/8ykHGmcI5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723258; c=relaxed/simple;
	bh=KAq2qyPZCUn84FFef1eOXbBT3B0klhzRwfDQ5cuo7/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=gUsFNkjM52bs1gW9t6lQF2yFJM6SJBqy1bDuCF9MNjQN0EaLnd1SLyzNa7aS/q6n8gb/hZ9EM+XuzGWoZcRuG+ToOWCOC0eoVK8oaQqrM+2Q++998RX2yLpH4xOeEK8yDHNjvIRyMMlpoOc+u61uWCxjXcANg8r3O7fe1IAYwDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j8aZdOGf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nSKZ1fph; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436hl64010547;
	Fri, 3 May 2024 08:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=O4mZcBHvqjsqiGt0uO7vOo0VuKDbj9X/EsVkz+wzR0U=;
 b=j8aZdOGfWagj2zqOxOFH2J8wn0Hz3bPNjHzTu73c7BB5PNMbcQXp5rCmbheR97DPIv3I
 qIMFf/o3wbU848Ive8edpgf6JB2YBRb4sWCyYVZue3ZwIbnN+Hpg0L3XO3/dDFYkbSX4
 naMP7RxlmAkyTKt/OI1506d16LyLxm9u/lVtlhgV/Mm9/atXzobw0kqzFuw6qNc7S4bB
 8ODolMVWHux4D6awxLH5AQasHrtdrKaUwROwfKXFMlxQYYnvqO/LCL+SVUEsTqLW0F+4
 rW/pwEUDa/jZc4Ft3FgGiOaDyflgv5zxQxzrrJyDNOTbLoanznddFv6FYmLmE0gdE9FX LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54r2eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 08:00:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4436FOPu034702;
	Fri, 3 May 2024 08:00:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbsub3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 08:00:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+QZLMa5MsYNf0teys02cx8AvR/6IC/MeIYnhjMQbb7KJdayLde5/On8dKrrVUrL/DXsBw0EiZTF6M1QMTYj2WKIpnqcXj2cRvznywnYuKxBwgrB3qrzknKp2leXzeh3V2Bfzf3ZGYi7rZKuEG9IJ1sBkAJw+pDldPKeDBxSxkKE3dG3M3/od8hDaQvdP86q74jU1cQ8oIFh7dC0+pscKbUUbae2k4h0abo03RvNbZ3yJZbRTGhNeqhnGXUG6ZRlKJJNcgUkGLzkLLQmDIJx9Epf/xoMW5uK3PuG3WjcqUvswmr1CkA1OdQRcoGzzcSzDupIZkDmkuu7fTzbjMYxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4mZcBHvqjsqiGt0uO7vOo0VuKDbj9X/EsVkz+wzR0U=;
 b=fgwnlooxSlHByUjnlhPddNSOruq0qi0tvyhydbX2bTGU8xercyshX2q9oTeShWkVne7CsS6HihbrgNAxYwzUapewgMWcJLuC/uUg37g5PQfE5rkak3jfgenTzhekwrKZJdJW9p3CqeLM1rkOCXisNYcVO1gkFABwd2+/Ola3MnK53N8uCHSIXbDG7LuwjGNeIFQCNzIuSbZjGnQ9Ltk8kgfq7KzR0UvD6+5tNDdUrbCmy/C3nt3gis+zMptSXVMUVGDEDQ39kjI6y0e2PO4E1bZpsGltcbFsvvn3K9+zkzuwi0w+/UsBfBuBG3D0YUuCrJFhcvmyovmG/oOdkar0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4mZcBHvqjsqiGt0uO7vOo0VuKDbj9X/EsVkz+wzR0U=;
 b=nSKZ1fphbEIBnC34KzapmnLX/nf7HIWOvPLBKcyfch6PTextUlOuNWFVMJewMJiDJLYTwmrCMXBKnXBb9DFZxJ4aPmDyFDvbwypD0t+vLxRiQYoCz054iaotwvdLfEhZ8aGxAydocQQbAm35ci3+gCf5pbLjhF+x3pZxOX5oVIg=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 08:00:52 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 08:00:52 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next V2] bpf: avoid casts from pointers to enums in
 bpf_tracing.h
In-Reply-To: <CAEf4BzaWaggGZCW4mCA53Sa7xiVARNk1taONaK0gL72x6B=mtA@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 2 May 2024 23:05:27 -0700")
References: <20240502170925.3194-1-jose.marchesi@oracle.com>
	<CAEf4BzaWaggGZCW4mCA53Sa7xiVARNk1taONaK0gL72x6B=mtA@mail.gmail.com>
Date: Fri, 03 May 2024 10:00:48 +0200
Message-ID: <877cgbpbnz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA4P292CA0013.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CO1PR10MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: d45244b1-9661-42ca-a1c8-08dc6b4726fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NWtVUTV0bStqaW9HUHNyWjRiR3NZa2lCTkd1VjFOU25LdW5pdFhGWnBkdzNn?=
 =?utf-8?B?SURnbXFPK0hJK3l5VndnQi9NelRBOG1KU0NXYTlFaksvaWlzU1NocXEzemhR?=
 =?utf-8?B?YWU0bU1CdUtmOVM0c05qYnhySStMdzVBUGdSdVJCYmR6VEtWUFAwcmRtdkhu?=
 =?utf-8?B?TmtGYVovSEE0RmlOUEsrcnRMaGR1QU50dDFZZnVUK0VJUFk0K3B0WS9VR2RL?=
 =?utf-8?B?TUs4N2dtZ3RCMXU1YzBucjRkbVVlOTRhRVdqZHVieTYwcFZJOUtwMSthbFNm?=
 =?utf-8?B?YXhUWlBCNldlSS8xWmNza01tZ1pNZk1LZzNEZFpGYnZpcUdIS1lobFBvdVBl?=
 =?utf-8?B?MkUyQlRLK0VQR1hkOGZ6Vi84Q2NjYWNjbzJoaHgwVGlmVVg3UHNPRGRJK1Rq?=
 =?utf-8?B?NGF1RFVybUJhYTRyNXVCbXloS3V5NFBFalB5aGZuMGpaL2RiSzdpakNFcFc2?=
 =?utf-8?B?MEU5RnVGRUxtU2NxS2MvVTVMaGxmT3hKY2dRdW80MThVek1FMS9mQmFhMmFO?=
 =?utf-8?B?c3dtcTZNMzBVbWlHU09uTGFrdEttTE0wRVpSNDRIckk1eE9xbWE1WkdydkNv?=
 =?utf-8?B?bjVtNCsvQ3pVamxlSVVkN1BUdEh4MjI4Y3V5M2pJemhQcDdvUWcrQ00vSE9O?=
 =?utf-8?B?dTdVRVc5eVA1RjdEWkFqNG0xbStBclpjT3A2cDhkQTBzcDdubGQ1THRHbXZl?=
 =?utf-8?B?S0t5ZUR4MkZXRHU4ZEZqR2ppUnpjOXJ3OUc3Sk9COVNlRjg4K2VXbElwdUNB?=
 =?utf-8?B?OHJvMisxVmhPU2VuNEYrUVdkeHpKRkt3WUNjYWx3dHVPWHdIMzRhNHphZ21s?=
 =?utf-8?B?OS80ZTh6V3g0RE10WWZpaTZWRXUxWWliSnJBQnUvUUhkeWRBQ1VSOVg4MjA0?=
 =?utf-8?B?OTJ6VHUxcG5yK2JHcGdaUzJwTmluQUtWUXMzOWZueVo1Zkd6RHJ5dkxSUlF1?=
 =?utf-8?B?QzRZRnpjVUpGTFJYVWpyclcrd2lSY1UzUlo2dFVTRHY0UVErVUV6Nk1WckU2?=
 =?utf-8?B?SlUzZ2lkTGxVSzkvWVE4cXBFdDBpM1AwVTA4NGlmU3NhZHMzWlNKbzIrTVpl?=
 =?utf-8?B?dFNPTEdkR2Z4bFVYbC9leTVIMDRFSWdDQ0hmNkpzdW5La2ZlbElUbnJmUHNt?=
 =?utf-8?B?TTJ3OEs2T2F3QTl6bEl0UjFMTjZrUGc0TnZrL2VwNEZqTU01MXI4TTU5b0pD?=
 =?utf-8?B?MDNhV1gyVk8vaU1MNWNIaytRN1lyYm84OVRDaGdXOENhMFRpTTlsanoxeThC?=
 =?utf-8?B?MjVKOTIya3dnTnByU3BnaTVnSWRnd29Ua1ExUjNEWGtlUjcvaVpvWWI5K1I3?=
 =?utf-8?B?OVhWZ0kyNHU0aGFvTzFGc0x4RHRMc2N5bVI4OWxQWnIwS0I3NFlyTll0U1BP?=
 =?utf-8?B?U0JZTHhueVlKLzRaTDltcHk0WHNSeXU0UTBEbFpkZGNONWtVUkZNaGVmZytF?=
 =?utf-8?B?RTBsZ2RCQlRnNXlkYndJeXIrcktFQUtwYkJud01XRy9KMXE4MEx3OEMvQThX?=
 =?utf-8?B?UGQvb2pIOXFOK2N5STZzenhMOXQyQU1CL2xQdTJSZDN0SVNzOXRoL1dIbFVm?=
 =?utf-8?B?YmE5S2ZFeStMODU5VzAyd25XT053VENzeStsRzM0TmZhSGd4dDdMb0s5NFhi?=
 =?utf-8?B?UUpoSlJUN2lrUDZtYWVZOEhGOGUyZ0JHOUY0WnpwczdXK3BEN2pOK1BGU0FT?=
 =?utf-8?B?cFl0M0t3KzYvSHhXM01DSWJwb0tBMmRNaUQvZi91QXIxWGlPTGhPVVZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SU9LMWw4QitzSEFCZlBaS0U3RnFaTjRlSzFqTVlvZjBZWEVPWnBFSStSK290?=
 =?utf-8?B?akY4OEVqZ2VFL3dyclg3V0c4bENDcmtlczZFK2tHM3hPd1EyeVFEK0FveFhx?=
 =?utf-8?B?UnJQaGJSZDdSWXpJODNNRmJhV3lmOE9KN1dNaEc1M0ltQ1JpSlV2dFQ3OVd0?=
 =?utf-8?B?YzU0MldKeHJ5amJ3RVM2dTJBejMwb3h6RnpuQ0ltUnZsUkg0dlJpZitsNk1J?=
 =?utf-8?B?ZUgyK3RqR0wvV2RlYS9QdTFXWW54bXpjaHFRZGdrVkhyZjE4UGNmZ0d1THZP?=
 =?utf-8?B?VjU3NGQyMnFWVVJXQUlML2FXcE9Rb2p6Tm5JZ3FpL1I1cUdBRThINU56cmtX?=
 =?utf-8?B?WWYzbGZqVzQ3R1RPSWlPeThFUnI0TFJldEhaVmoraVB1VzQwK3p3L1cyOFFM?=
 =?utf-8?B?cXE3MTJNd0FmKzJZNEJ2V1lVaEJDQWFGcWZRb1NNOE9UZTQ3b0VJK0FCeSsx?=
 =?utf-8?B?elRITTl3Yzg0Q3N1MDc5M3RvUWJDN1VqMlAwdU5BVnJ2UHFhdHprT1MrdU5z?=
 =?utf-8?B?NW9jUmJPL2dlUTlCZHhLLytqaFVhMER2OXJjS2dxUGVVSWgzVjRraHVtaVdE?=
 =?utf-8?B?UU80NkV6MXpOZ0RlNk42RVBieHpmSnMyZ214djNVNElWdC9OMy8vWThiU1VR?=
 =?utf-8?B?YzUxM1pGZ0NoNzNndHNuYjhjTS9UblBsYmg4TlJKYTQ4czZNSm5kWXAvZm1F?=
 =?utf-8?B?NmJVZGRHdG41N014TnhrcnlGYU5TQVNEQ2o4VytiRnBFOHpITGxmODFrZFJQ?=
 =?utf-8?B?NExpQmwyckxvMEZOYTAzVDI2dGhtbStsdG5JVDBKbUtCNUdsTC9USjVzVHFv?=
 =?utf-8?B?ODlRSXZZUlljQW1rRlZVUnNCSkZLcXlES2RITERqUEhidXlhd3JSUFgxaFVC?=
 =?utf-8?B?QU52R0V4bi8xU3FUVmdoRlZVSlVBREgzc2xhME15V0E0M2dzU05md1FuejdP?=
 =?utf-8?B?MWJ1bUFmL00raTUyMFpvQWpwQlkvTWZtK2R1NUVMRndHZDZGMm9zcGZISzNC?=
 =?utf-8?B?dDU3ODNGTUtKeWQ5KzJVL2dtcEYzL1Q3Z05uU3JkRkp6ZFAzcCtVbkJlNlBU?=
 =?utf-8?B?UG1vU0dDVlh4OTVPd2FZRFltd01wSm5ta3VUMUxxVkIyL1NBcWNycSt3MkZD?=
 =?utf-8?B?ZG1sdU5TRDNDUS80R2dGcm14WlJrWDBYMWR5cHEwdVRXVU9nOTVCSWpDVTAv?=
 =?utf-8?B?Ty9oSldadDdXcCtoRENXbkhVL014Z0dZbVpPNWszZGd0M3h3cks0R1lUYzNT?=
 =?utf-8?B?Mmo3THNrNGtULzJIVlZSSmEyMy93Y0FHaTlzZ29QOFBXNitCY1lEejJ2dDZm?=
 =?utf-8?B?RldQNVJ5ODRsUWhVSzRFbVZoaTE1cWV2cUp5UEZWQnptcVVpM1NsbWJNYitE?=
 =?utf-8?B?MzJleU9WYXFLbGlLQ3BUVm4xSC9OTDZ0a2hkWExVL2xlZ3RLNVpZSVlYUVRi?=
 =?utf-8?B?Q0U2empqa0RycUZkNStEdmszaFEwRnVTb1d2TkkwZjVMWjBMY0VHQkwzMEI2?=
 =?utf-8?B?K0VUSU0xeTM4NkFWMysxUFpvM3hmL3N3ZDZpNVZzdS9pWUFnNE9ISGJxd04w?=
 =?utf-8?B?cE8zTGVWZUhZdGRKczNwOEFaaWljU29XRVlJRjZYN0VKMjJWMUxvN2RMNnZZ?=
 =?utf-8?B?RlZwajltZ1NNUEVBanE0ZEQ1S0pKK0VtZ2FhVVBza1l3Zi9HaVFzcDJDUkRG?=
 =?utf-8?B?Q2wwTFA4QWtQYVRwRkdhajl2dHZPZCtQT09Ram1iU2lJVHNQMHZhSEd1M0J6?=
 =?utf-8?B?aGJIRFZhc25nd2E2QmdvcjhyQnFyWHV4TnQxc3FmWU42M1BSZXUveTVIWWRE?=
 =?utf-8?B?SDN0K01CdFRDVlI2b1g3L09BVUdKOFByNlRxeWQrOWN0MVNEdWxkYVZmcWps?=
 =?utf-8?B?c3NLTXA1YzVsLzV5N29FaWFXaktTZUUzSks1RU42VTM1NmVNYm1vdW9hWWVC?=
 =?utf-8?B?Z3BQYVNLWkJ5ZEwwa3JiaGFHblJCVnRmYjVuaENCcWVXS0wzTXQ2SXdlUTRa?=
 =?utf-8?B?QVdoQ0F5NDRxOC9kcitrbTFHTnlHc2JvVnIyZWVkUnNSb2N1Ykw0SFI0VHU3?=
 =?utf-8?B?SVdrZ3k3WWhSNStXc1AzSkF2R0oxVFI5bWJVMHRGeWhtK1RpdG9mcFg5b2Q2?=
 =?utf-8?B?eFk5SkVBdXlJWGJ0QmpNeVFNVW9uNHoyVmdwRjVqdzhRZktaRnBkOTVQQU1p?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KVl2jgZzbmt2RUPwCEJnY/1i+Rp6cQ7TjYZ0/eBFqdl43L4Vbdoxg4cghKMtxoKn4bo7OcA6pgFHHn/CliUaI/EEk83QStaMfUbwzhAZjlNWH3td75/bu8sc8p2q46MXUfWESKorZyQ4bdp1yHj2yRG002+YUrYTqmJ/WyiTB+YsDTqFcVRHAORkDqvR4fuKX5FfcOHB57Rqbpp1OVa84ObUcE6PRwJIql/JT8PiI1fzHiBB+DVRQCqHD5PQJ3PJx4zejM/uJYWr65VOMw6FqMDf7H2yq01FA1ZJ2xmnuZNq3iQ1QzvqYZQOla5hrOXhfbh1ZaY/2YSUPTWqFZ+pCo5MeBA7JDUKfUMqaqDvs7+TWWGgDbvd7bE0HlZUuldJhJxdP20tLnj8K985vLVM2WCEJr5cs8Iuy3wy4A5Inr8HqH004qJihhZcldq6LwDi6CvAJVRMgZUjlHlQ/O8byINfA4sz0H8XNQAUb2RTfEQ5JXhgUiMwtq7FCQPFn39li3/EN2726hP9nNZgBycZdo8cvaDmDvGjJvaC7dxrUe3E6x4j6nhcnCjVnYngsCZGpw6EvBdA+a1yiSGZY3dOq2zx3zm/mj0LJ0zupcVe8JM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45244b1-9661-42ca-a1c8-08dc6b4726fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 08:00:52.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMIQUp9AN013//sog2DfWtjLgGN5RrVEqilpXOXXMeUvmqcnkMJKwhxp7SwkIumaICKq/V29FI7Y6cRsgGv5w1FWiTqt0seS1Pb5sugkc6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_04,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030056
X-Proofpoint-ORIG-GUID: kAmCWH1F9JMxE64nzuqbQVCD3l_zGbJd
X-Proofpoint-GUID: kAmCWH1F9JMxE64nzuqbQVCD3l_zGbJd


> On Thu, May 2, 2024 at 10:09=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>  [Differences from V1:
>>   - Do not introduce a global typedef, as this is a public header.
>>   - Keep the void* casts in BPF_KPROBE_READ_RET_IP and
>>     BPF_KRETPROBE_READ_RET_IP, as these are necessary
>>     for converting to a const void* argument of
>>     bpf_probe_read_kernel.]
>>
>> The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
>> tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
>> convenient way to define entry points for BPF programs as if they were
>> normal C functions that get typed actual arguments, instead of as
>> elements in a single "context" array argument.
>>
>> For example, PPF_PROGS allows writing:
>>
>>   SEC("struct_ops/cwnd_event")
>>   void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>> That expands into a pair of functions:
>>
>>   void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tc=
p_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>>   void cwnd_event (unsigned long long *ctx)
>>   {
>>         _Pragma("GCC diagnostic push")
>>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
>>         return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
>>         _Pragma("GCC diagnostic pop")
>>   }
>>
>> Note how the 64-bit unsigned integers in the incoming CTX get casted
>> to a void pointer, and then implicitly converted to whatever type of
>> the actual argument in the wrapped function.  In this case:
>>
>>   Arg1: unsigned long long -> void * -> struct sock *
>>   Arg2: unsigned long long -> void * -> enum tcp_ca_event
>>
>> The behavior of GCC and clang when facing such conversions differ:
>>
>>   pointer -> pointer
>>
>>     Allowed by the C standard.
>>     GCC: no warning nor error.
>>     clang: no warning nor error.
>>
>>   pointer -> integer type
>>
>>     [C standard says the result of this conversion is implementation
>>      defined, and it may lead to unaligned pointer etc.]
>>
>>     GCC: error: integer from pointer without a cast [-Wint-conversion]
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>>   pointer -> enumerated type
>>
>>     GCC: error: incompatible types in assigment (*)
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>> These macros work because converting pointers to pointers is allowed,
>> and converting pointers to integers also works provided a suitable
>> integer type even if it is implementation defined, much like casting a
>> pointer to uintptr_t is guaranteed to work by the C standard.  The
>> conversion errors emitted by both compilers by default are silenced by
>> the pragmas.
>>
>> However, the GCC error marked with (*) above when assigning a pointer
>> to an enumerated value is not associated with the -Wint-conversion
>> warning, and it is not possible to turn it off.
>>
>> This is preventing building the BPF kernel selftests with GCC.
>>
>> This patch fixes this by avoiding intermediate casts to void*,
>> replaced with casts to `unsigned long long', which is an integer type
>> capable of safely store a BPF pointer, much like the standard
>> uintptr_t.
>>
>> Testing performed in bpf-next master:
>>   - vmtest.sh -- ./test_verifier
>>   - vmtest.sh -- ./test_progs
>>   - make M=3Dsamples/bpf
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>  tools/lib/bpf/bpf_tracing.h | 84 +++++++++++++++++++++----------------
>>  1 file changed, 49 insertions(+), 35 deletions(-)
>>
>
> [...]
>
>>  /* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to B=
PF_CORE_READ from pt_regs */
>>  #define ___bpf_syswrap_args0()           ctx
>> -#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void =
*)PT_REGS_PARM1_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (v=
oid *)PT_REGS_PARM2_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (v=
oid *)PT_REGS_PARM3_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (v=
oid *)PT_REGS_PARM4_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (v=
oid *)PT_REGS_PARM5_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (v=
oid *)PT_REGS_PARM6_CORE_SYSCALL(regs)
>> -#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (v=
oid *)PT_REGS_PARM7_CORE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args1(x) \
>> +       ___bpf_syswrap_args0(), (unsigned long long)PT_REGS_PARM1_CORE_S=
YSCALL(regs)
>> +#define ___bpf_syswrap_args2(x, args...) \
>> +       ___bpf_syswrap_args1(args), (unsigned long long)PT_REGS_PARM2_CO=
RE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args3(x, args...) \
>> +       ___bpf_syswrap_args2(args), (unsigned long long)PT_REGS_PARM3_CO=
RE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args4(x, args...) \
>> +       ___bpf_syswrap_args3(args), (unsigned long long)PT_REGS_PARM4_CO=
RE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args5(x, args...) \
>> +       ___bpf_syswrap_args4(args), (unsigned long long)PT_REGS_PARM5_CO=
RE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args6(x, args...) \
>> +       ___bpf_syswrap_args5(args), (unsigned long long)PT_REGS_PARM6_CO=
RE_SYSCALL(regs)
>> +#define ___bpf_syswrap_args7(x, args...) \
>> +       ___bpf_syswrap_args6(args), (unsigned long long)PT_REGS_PARM7_CO=
RE_SYSCALL(regs)
>
> I undid all the line wrapping you did. Yes, they are even longer now,
> but at least the pattern is easy to see when all of these macros are
> single line ones.

It is much better this way.  I really hated to split these lines.

> Also, I took the liberty of doing similar transformations for
> BPF_USDT() in usdt.bpf.h in the same patch, as you'll probably run
> into the same issue (not sure why you haven't caught that yet). Please
> double-check the committed patch, just to make sure I didn't screw
> anything up. Thanks. Applied to bpf-next.

LGTM.

The reason we didn't caught that with GCC is that none of the current
uses of BPF_USDT in the selftests use enumerated arguments:

  progs/test_urandom_usdt.c:
    int BPF_USDT(urandlib_read_with_sema, int iter_num, int iter_cnt, int b=
uf_sz)
    int BPF_USDT(urand_read_with_sema, int iter_num, int iter_cnt, int buf_=
sz)
    int BPF_USDT(urandlib_read_without_sema, int iter_num, int iter_cnt, in=
t buf_sz)
    int BPF_USDT(urandlib_read_with_sema, int iter_num, int iter_cnt, int b=
uf_sz)
    int BPF_USDT(urand_read_without_sema, int iter_num, int iter_cnt, int b=
uf_sz)
    int BPF_USDT(urand_read_with_sema, int iter_num, int iter_cnt, int buf_=
sz)
    int BPF_USDT(urandlib_read_without_sema, int iter_num, int iter_cnt, in=
t buf_sz)
    int BPF_USDT(urandlib_read_with_sema, int iter_num, int iter_cnt, int b=
uf_sz)

  progs/test_usdt.c:
    int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
                 long a6, __u64 a7, uintptr_t a8, int a9, short a10,
                 short a11, signed char a12)

  progs/test_usdt_multispec.c:
    int BPF_USDT(usdt_100, int x)

Thanks!

>
>>  #define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_ar=
gs, ___bpf_narg(args))(args)
>>
>>  /*
>> --
>> 2.30.2
>>

