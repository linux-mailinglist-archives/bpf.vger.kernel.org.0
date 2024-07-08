Return-Path: <bpf+bounces-34051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6B929E71
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A321F238A6
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65554645;
	Mon,  8 Jul 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArbiQ0LJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CzSfmMag"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5A50288;
	Mon,  8 Jul 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428145; cv=fail; b=mahqUqhjlYPUUR0oeJXTyufmOX3hn60ARv4Sxpy6Gj3vB/lP3Ne3FJAMjZlE/yQqR3YDyKglJz6lFaVSeoZ9ZLEO1NB46hT+siSlq41fwgcAajokDeIrAWzdUyfcsHhWySkfv1cD4cYYnq1eTZuTGmKpmHBilynpYFidi82el0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428145; c=relaxed/simple;
	bh=cnDO/6UsTeCciqF5GJoRDNckEk+wvGWWW8repTzGUVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/2NZznbgZbzaXQL6O/FkPb2H2uYdMa7W+mwqgKBuCy6YA0UMIP31TqUcylDD/KyJz0Zk6DUjnJddIFzQJDHGQZINYzQnhAq4GbZVU7f130VYKgVVwk0y/rDrdn0oTWhddYkuFCDSJnDNmcFw5ux38BEEiV65kM9utsm3v3OVzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArbiQ0LJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CzSfmMag; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWjI018083;
	Mon, 8 Jul 2024 08:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=iJ74KparJByS1pEp/wNe7YvTS4D5fgUvfyjD2adixO4=; b=
	ArbiQ0LJVNrUt+QQqCNYuGjY9U24pj2QQY68T8cOMHlI5/H+znDFKlu1cU6TZie4
	u4yRIBgcYWD6RxcfSTleKdN8PzdWzJCFxht2OoBIETsWILhES2uzihlE+m0+2+S7
	39YjXBC/F0IIt94VDLD8w1ehzFLVOolxykcWkG5c3g6dTTxxdG4r5nvkC6vRQ360
	6T9rr7hvqnLdVt/oGqj+Krdv1ZZ1yQ+MhyKfwxUD50XUgwy8UjBPOuCw3Ca+vBUo
	eXgmjopNmtE+oYA5B9rK87mCE2LeaQvt5oz/Ar1YaJZ38rO4fpxJC0r52xUmlYXS
	JuRsDCqOD1/8M0GslCxvbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emssgt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 08:41:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4686eRdR005809;
	Mon, 8 Jul 2024 08:41:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx0urg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 08:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYB/ErIokcv5+369h1Db0XvPoRcKxNRsJnJbaox1tde3s72kL2I2/Mbb9lkJz5cXIb/P6SMBTEhQoe+CyIgt5QyYeipPqDB7FYN5sIZhKBv5lAGu9tHUY2O8MfGQETRbBNA5wrmlIjmKZ43FH3ttrkxnwKWOo8S/AjTGNM5JDUF3ALpmxA+xkbF+fPXgPWk3zz14IHIjsI4s+adxM13HH9T3+NALxsi1QLKY1LoUhTBBAaTss94VbMPj7Gbuc5f0rVHk/0KfwlA/hknUkeWCmKL31miGyKZHD4pkI6dhpnC0WyudJ2r4KRJNiRFQyrhih3R0cCEvfMWjCJ4Aix8xZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ74KparJByS1pEp/wNe7YvTS4D5fgUvfyjD2adixO4=;
 b=GbWRcDVDfA4SAKmOfclyHAQGATB/JT8+XQTvLeL/mJVXiHBaYxQvoY+7hxJjOdNPd1efN/iJJkVHjS6oa2ZeWM8bRRTNhcm0HI+3tA0+zpjiVdpGKb/4DB13R5rdd7CLhiNQn1y6nY+EIebNXKXwgF4dOt5N+gpX1x8Z744gHggHZrMnh0kkVA7HS9pgiW5ZL9oduncF0Ueq6s7sSQoOmJyfa+2DtMtO6U4jD2227lm0IVifwRfrW4vCVevFFUFgEOoAZy4E5X1Wvz6/M2FHltrtHnfCWCvRAN97Duws1O1I2gCkDe2ZOeG3tighoLJaQ0aZzFzp8UVV3z8hMtsHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ74KparJByS1pEp/wNe7YvTS4D5fgUvfyjD2adixO4=;
 b=CzSfmMagjvtJijG8jiDrJURcTe98RHY4IwNBxqpGiLl+Ol71hTSFkmdCApuod3bXlZ8vFlu3UmQi6sNneQXAnmtDAJO992qk1Ul2HLMldiFT5jjyzs7W0dVV92YmkyxtCAgIh62/VF1E1KO8s4dzGOxPu7Nv6Q80IoUGa5Hb+kQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 08:41:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 08:41:34 +0000
Date: Mon, 8 Jul 2024 09:41:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Christian Kujau <lists@nerdbynature.de>,
        =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
Message-ID: <4597fb15-a7ed-468b-a7e3-48618e6ff18e@lucifer.local>
References: <20240612-master-v1-1-a95f24339dab@gmail.com>
 <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
 <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info>
X-ClientProxiedBy: LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: b93730f3-9204-4b8c-c436-08dc9f29c5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3JUNnBTTWxmQUxIMHdCbUo4RVRleEFNVzUvRWdVckFjT2Q0VEh6dDVKYUJC?=
 =?utf-8?B?T0tDd1N2dkUxSm1zTGhjbGMrWE9qTFdtamM3a0tqZ0FEbWFjSVBiVk9keEdk?=
 =?utf-8?B?RC9zbVpQaG05UTMzRUIxWWhFQ3dHRzZlclE0ZmdlWGc5UGtPWmowZ1NQa0Rs?=
 =?utf-8?B?ZEh1THFreWxlb0tSY1lOK21NTDl0eHVWMitpdkxzVFZrbzNhNndsV0NlVEE2?=
 =?utf-8?B?UWtzaVJwWkdwWHMyOWhaa3FSeHk1WXVDUWdpc1BNKzljK0VoaFdrcWtMdkdU?=
 =?utf-8?B?VkZLajlGSnhxckhEbFhTam5VbTZ1N0l3NHhlLzZwREZXOUxGLzF2RHMxOTds?=
 =?utf-8?B?MUNGWlRyRjMwMm1nVy90VWIwT1I4MHZvRzBta2FFRGdwc3hQUjF5eG5aTDVJ?=
 =?utf-8?B?SVZDeFdpbHNGNTUxNERCYjZxcVhYbFB2eGhtc0lXcGRvM0pZajZFWUhTaVZ3?=
 =?utf-8?B?d0V0ZWZ0N1dCS05UczdWamdsQnlUTy9uMFowTGxPcjJLczQ4aTA1MitiZXVM?=
 =?utf-8?B?YWhDUjlSbkpiM0hoMW13akdGNllKcnZOSXZkbVIvK0U5OXNrOGJrNW5mOHdr?=
 =?utf-8?B?Q2tCSzhJQi9nbjgwb0ttNjdlOFdIbmZTRk9pZHVZcGtiMEJlM21HeEJqK0tQ?=
 =?utf-8?B?Q3BQOUdYeTRGNHJyK3MvV3loaEZlOTQ4MWxUaUVwbFRXcmZ1ckZ0TTZvbGVy?=
 =?utf-8?B?WUFBczdua0o1dXNKc29LQzBydkdQbGxFMStXY05aeDRtRFdRbzgyZEw3U2tD?=
 =?utf-8?B?Yy80WXl3L1JNY28zR2UyRTlRWXJJUWJRY0ZyTitBZzhpNW44MGw0N1dOanRL?=
 =?utf-8?B?R1RsSFJNcTlQSHVGN0ZNbDJGKzBhc0xGclZCeTlKRU8xN1dYSmNGWmJjL21J?=
 =?utf-8?B?VVhSbzdtQmx4VzdaaVkxOXI3YUxCWUk1VWVOcEEwWHdSM2xiYkk1UkFkaG1G?=
 =?utf-8?B?bUV5d0t6TjVnbnZGQUFWZ1RCOGt3Z21UeFcwbDJCR1MvTzdXNkJmL2ZCdlhs?=
 =?utf-8?B?N1ovc2x4UU9KSFZMb3FpVjVKUTdnQVNPWEtYNGpicmRvR0ZNL2xOeHd3ek82?=
 =?utf-8?B?M09KMWZGMDZ5RG11aFJGcmcwOSs5bU1IUkVNUWlabVljdGREQ0FwYVBtTW9s?=
 =?utf-8?B?clptUjRDSkpsaG4yVmNtTkptZVlhZ0VIWlpzRUxIdmZwYnVkcnV5MXdpcGlP?=
 =?utf-8?B?V3czRWhYQ2RYdkRkMHViRnNPb2UxUHBhMU51bFNRT2FPRUxqcS9DWFlOS3RZ?=
 =?utf-8?B?L1pjek5iYmhYdWJROVBTai9PWVNZck1QSHBOazdRT2Z5TVNuMzhvWENDOE10?=
 =?utf-8?B?cEJTOFNhWlJ0R1lMdWVBc2pDdHRsU1dTZW9lL0Q3V3J3OWQ5RGRuamhwS0pI?=
 =?utf-8?B?SjdQcGxIYkZzMVBDczZiZlVHWGVDc2dMTjhLZTVCZVY5bldFdzAyTUM0U293?=
 =?utf-8?B?anpVcUg5Y29BdHYwcDloNklKeXdiSWVOc1pzZ1hNQlpXTzRYN3h0NTRwUnFW?=
 =?utf-8?B?UzJqY2JHZ1l6YWpoUmZZZXlkVzR0U3ZuNlhyekFwY3d5RTcyZXc1NUlSU3Bo?=
 =?utf-8?B?cCswYk9kNTBtdW1rVXVsQUtDb2JnUXUzR1A1ZGp0ZXdPQ05tVFY5TWlMZGM4?=
 =?utf-8?B?dkNLdzlnc1IyVUFGb3pJZm1ybTl0cHpqTE1NMDlwTmJ0VVpUSmhManVLZmpU?=
 =?utf-8?B?M1ZBRVZudjJ2aDdwVGsvSU1JNitVNUh6N216VlpVTkpMME9aTllVNjZjcllD?=
 =?utf-8?Q?eeMEhSfwASVlXBZc6Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3QrZlZjak5BRjllTytIcGQ3Y2dmTjNiMVBTQWxURWRoLzBsU0QzLzdMK01U?=
 =?utf-8?B?SWtENVRNdlpkdC9QS3pYbDNHVlcwb0JJdnA3Szl2cUJNSzQxbGdldG9SZmZa?=
 =?utf-8?B?SndDSjAxOE8waEFkUUtwWmJsUXVzQ1YvejRZN2J0bFgxL24xRkxaNDVBOXlJ?=
 =?utf-8?B?TXB2dThMK0g4cEZ1NFFRbU5lYkJnU1krRlZXNFhwVFpVRWdaelhUV09nQXdu?=
 =?utf-8?B?bm1qL01JK001cUlSck5uVW1YWEtJUm55TGJjZitaTUc0SUFOMVBGREIrT1hN?=
 =?utf-8?B?QlN6bjlZNFdPWjNzTEh2OU5MOTQvcGVpSVk1K0lPZ25jM0JjcWhwd0tYMllq?=
 =?utf-8?B?a3Y2SWRHQWlKUkU3ZktlK0tYWDRJWmgxMnEzd0wrVWJYMDlGSjZ3TlEvb1hy?=
 =?utf-8?B?QkZmNFZsYUVzYmxrRHpScml6TnYvaUp3UmlZVWJ1Mk9lekRNMTFtTEpKUktv?=
 =?utf-8?B?U1ltbWZCaXZEZ2IyM0VYdzZDUUhEVzhJc2JvOEFrMjZucHhZc2xGbW9nRGMv?=
 =?utf-8?B?VFdiUmowclFBWkRSQTNwWkJEM3hJQUlTTXlMV0Zvalhuend6VEdqSFEzdVJt?=
 =?utf-8?B?TGplNEVoM1JEVjVlRm10QjhjQXYzZVVKWGZOekx0dlhPSGNjWlhzdDBRQjhk?=
 =?utf-8?B?UTIyWVlSV1FaRnozdXJJZlhxaHI0ZHI2N3UyMFNBMys3VktMZmRZVjBwZmVT?=
 =?utf-8?B?UEhqc1R6bVk2SmJBazV6dmhaK3c1dktUTmZ6V2srVW11ZGZyNkQ5TUNqcEto?=
 =?utf-8?B?WVVCaDVoMUFQOVhEeHVhaTd6SENjYlZtYnlzdFpLY0NRNGlGVGZTU1QzM1FW?=
 =?utf-8?B?OWxkYm5mN25uZ2IrdGx6QVdGY04rY21yZUlUdlc1WEJvdmRzZWtRUVVrOFBo?=
 =?utf-8?B?SWZ5WVBsWTBrTTg3ZGJNdTdZYzZiZ2JZNVRUanBGT1UvQXZWckdndzZYbEoy?=
 =?utf-8?B?NFZKUXRoNkhSeUdTMU9DR1NmcDdhTWovSmRKR01EOU5uWmNrV01FcTIwZmlU?=
 =?utf-8?B?RFdwV3ZjZjNiMzloN1M4YUoxMjFXLzRmUEdScnNwOGFsZGNSOFN1NDBnVUtr?=
 =?utf-8?B?eWRCQ2RoampuK1pGK29wcWl1TXk0NDRTcitNNXlpL1RJVS91alIwOVN2Qlht?=
 =?utf-8?B?Sy9Xc3V2QlI0ZUVsS21tZndNVlhSajVGRnZoQTQwM1ZmcUhOZDh2R0lJVm02?=
 =?utf-8?B?ZjdGZHg2RjZ4b3dXRXNXd3BrMmdGQW5wMzRHMFQ0S1NWdVNTTlRjOHAxcVJ5?=
 =?utf-8?B?aEl0UVhNUHl2VXRyYVFiZUcrRmN0YTlOWVpFNUJDTncvK2lOcTIzMEZWckgr?=
 =?utf-8?B?RkowUHdRaGhPK0them1qWnloMzVmSUg4SERsSzNkYWorMmlkOVkyUXJRZEhR?=
 =?utf-8?B?U0Z6eVpicWV2b3YybG8zdVVzUUxzNmZuNGVpSXVEZGtQNjVHRkFFRmQ0ak51?=
 =?utf-8?B?ZTdZdEgrTksrWDRBWVA3OVAxSVFXTUZrV0kyZ1k5VEI3a1QyYXpjOWhOOWJu?=
 =?utf-8?B?UjcxbThPS0Y3eVJabW55MUliTis0cURMdWdCaUxDWWhlSXV2TzRZV3ovRlNk?=
 =?utf-8?B?dWFaSW5xSVRLQjFZZ2p5R3VzdC9lazA2SFV4RCtMbDl4aG5MZHc1dnk5UXl1?=
 =?utf-8?B?N0xaZUgwOU5DdTNJK0xhQURxeHkwTXpNMHpKSjZ3ZWcyek5sa3BZUTBRelJH?=
 =?utf-8?B?MkRHOVhZZWlMWExQSjRhRU0vUnU2UDlmeUM5QnBPT29ZcHhKQkNIR1c4Zjcy?=
 =?utf-8?B?MkJsdnQ2MDd0eUZBM2ZGdCtyZGZMd1IxZDJDSThoRnNJTUpQZTRTVVpaVWU4?=
 =?utf-8?B?RE9qbHR4V3JRa1Y0Uk9WbXplTWptNzlQeEgrVjVYNTZuTWhNNjZFdWZtZXRa?=
 =?utf-8?B?eHRoZTJvcnN1R3gxZUdKVDJCRDhwSXAzZVNGZHlHVWV3bU5scWQweEp6SDF0?=
 =?utf-8?B?ZktUTnVwWHBlQmg2enA3UVZuU3M3VTVxdGtIY2tmdVd6dFJpcVI3bkVkZm01?=
 =?utf-8?B?a3RhVHFYS2lYeFgrQ2hWTDUrYXRFeVpudUZzZGViRy9YSHpGYzBCK2lXdG9S?=
 =?utf-8?B?bVorMHBDNmVpZ3VoNXNyN1dFZERURmZ5UnpKdHdJY2RUOFpSV3p1bEVuOFlv?=
 =?utf-8?B?QWVFS1YvZm1qLy95alJRMzFsTlNubEhKa0RDMTEyS05kNERvU3Frd2V3T01H?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9j62cxveR81cFfgLIvRUpvTyg3TZc0fE5yOU2tbFjCEyYew6H32GINTaSSquplb5TdECAix+fnHKWdDA2OXSBwik3hv24s4sli1qB1enMXWYTI8eDnnqLOuIxnORWT3YV1g2euov5xF1ABGK2ZU4yPa9PYzb6b7Va5x+8r8Z3R0VD14ErcnoCtF32Qz4Mq5F/Te3dVDsQqwpFEPhK/OeKv8x1UsyceN0zb3NXqjO69eveW6GxgHtNnvMmKs6Pxzeqrstku4Nd9NT8yePubE7+uF50iy/2H5Eq4gJDBNVjE9BReX2cgA2OoGbAtgDvkPUdI3M4bU4gjYcmw7eghg9tYu2K7aOq3aD/jijGyCLYXzFRtqt5xYOmPn0nAfROynVEpbXdXXHAMWIi44klckyfK4R23IrdiGBE+myQise17493ExV9w8Lhzp/IvwU3pHK9SRqbVxqe+lXD/BHCuwwV8v2F5SLEzue9SounWBQ1H6T37LpUNLjououC5Dk82j9rJBHFUOul/es1OU/ED1Hqxn2aRtGJKX39CCYcMl+bbIuQeT2nIsXywj7MvZ59jj3fA3L36ZWF4AypVBUDoBONYhx7Powr0rh/dObiddjmRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93730f3-9204-4b8c-c436-08dc9f29c5cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:41:34.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCtqItD251gqElHVliW1Lsz4dLu3VPvieiXxvfaByw2qEi1r8XJboDQCvXJRDAayWsP08+YGTYPqwcLWA3XyRzQc/NsdKMW2OmOuGfjaxsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080067
X-Proofpoint-GUID: mf0SPXlH6Zhbge1lMkOeO1HF8JcI0UXc
X-Proofpoint-ORIG-GUID: mf0SPXlH6Zhbge1lMkOeO1HF8JcI0UXc

On Mon, Jul 08, 2024 at 10:20:33AM GMT, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing the regressions list and people mentioned below]
>
> On 12.06.24 16:53, Alexei Starovoitov wrote:
> > On Wed, Jun 12, 2024 at 2:51 AM Mohammad Shehar Yaar Tausif
> > <sheharyaar48@gmail.com> wrote:
> >>
> >> The original function call passed size of smap->bucket before the number of
> >> buckets which raises the error 'calloc-transposed-args' on compilation.
> >>
> >> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
> >> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> >> ---
> >> - already merged in linux-next
> >> - [1] suggested sending as a fix for 6.10 cycle
> >
> > No. It's not a fix.
>
> If you have a minute, could you please explain why that is? From what I
> can see a quite a few people run into build problems with 6.10-rc
> recently that are fixed by the patch:

This is explicitly breaking my build in Linus's kernel (and subsequently
mm-unstable where I hit it first).

I have gcc 14.1.1, and can easily repro this with a defconfig on x86-64 with:

 make mrproper && make defconfig && scripts/config --enable bpf_syscall && \
 make olddefconfig && make -j $(nproc)

kernel/bpf/bpf_local_storage.c:785:60: error: ‘kvmalloc_array_node_noprof’ sizes
specified with ‘sizeof’ in the earlier argument and not in the laterargument
[-Werror=calloc-transposed-args]
  785 |         smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),


It's kind of surprising no build bot caught this (maybe somebody needs to
look into that), but it's proactively causing problems right now, I have to
keep the kernel patched in order for it to build.

So a fix of some kind is needed, urgently.

>
> * Péter Ujfalusi
> https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
>
> * Christian Kujau
> https://lore.kernel.org/bpf/48360912-b239-51f2-8f25-07a46516dc76@nerdbynature.de/
> https://lore.kernel.org/lkml/d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdbynature.de/
>
> * Lorenzo Stoakes
> https://fosstodon.org/@ljs@social.kernel.org/112734050799590482
>
> At the same time I see that the culprit mentioned above is from 6.4-rc1,
> so I guess it there must be some other reason why a few people seem to
> tun into this now. Did some other change expose this problem? Or are
> updated compilers causing this?

I suspect the latter. It seems x86-64 defconfig unables CONFIG_WERROR by default.

>
> Ciao, Thorsten
>
> >> [1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/
> >> ---
> >>  kernel/bpf/bpf_local_storage.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> >> index 976cb258a0ed..c938dea5ddbf 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >>         nbuckets = max_t(u32, 2, nbuckets);
> >>         smap->bucket_log = ilog2(nbuckets);
> >>
> >> -       smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
> >> -                                        nbuckets, GFP_USER | __GFP_NOWARN);
> >> +       smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
> >> +                                        sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
> >>         if (!smap->buckets) {
> >>                 err = -ENOMEM;
> >>                 goto free_smap;
> >>
> >> ---
> >> base-commit: 2ef5971ff345d3c000873725db555085e0131961
> >> change-id: 20240612-master-fe9e63ab5c95
> >>
> >> Best regards,
> >> --
> >> Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> >>

