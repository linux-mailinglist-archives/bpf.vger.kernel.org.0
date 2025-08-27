Return-Path: <bpf+bounces-66681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA455B386F1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DA7ACE25
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB32E040F;
	Wed, 27 Aug 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kzxwjlBs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ASKtooR+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FB2D0606;
	Wed, 27 Aug 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309719; cv=fail; b=oOrzKt89jArqQOUi5DJP7bke+MuU55a18gi01Avgg0m1w3+C0yTa/wsbSMpXzD6R0qIr1a9LEFomP0FJOev5MEAdItVBzrRZGul4WkI4Z6kMp5juO8MH2Y1pwlKrnmvoUrdsZ7WW7WYwy8cWzEWrUBU50UPzPLi4is/HcOZZGTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309719; c=relaxed/simple;
	bh=+L0l4Bq0JXb9K/3kbQ4FrSj5uoPFxcujV3nVYBrm0xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iY53WNThhfdUH294+XqHjJJI7nq/sSmI4dZRkPdxFr11IFi6AfFVlixSYoU0iqAXG+IcwxjHqoWvwMm/7uBZgIlKPSbzZ5jdkI6rrIGMb/QNCRgddHYJZTR4MF3i0u5F76upuTPZ+ROC7/lMmycwFHsDxII2492KQ9tojk3No/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kzxwjlBs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ASKtooR+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7uFu0028663;
	Wed, 27 Aug 2025 15:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jqsbcGPQC/t7DiWQil
	2p9m6RobPmjc82mLdVLbVEolQ=; b=kzxwjlBssv6jAJajKfaq/TtDFwrlO8TTwH
	j9mpFKPJLTvcxyAsIz6uhG2ncjLs2irmpuDR1P09/Bi5eExTMuTcPxmSbtazErqt
	/ai5/WTYWk9SwOhpsgXLHOIObrPeFNQFP75oCPaQx16xWXGdEuxlXpqScNvT16zd
	20dQuqtoTlvMX1TqRVtOpD1XJtunCc+xmZIoFl7jbhJZ9Qjy8Rvqm7TmdIG05WaI
	6XjCQWHBuMSw6NnoUEWlW80LTB4hpetLQtcqPO61fb7uL2HjfavXH8/RuD4/1jX9
	dFXz33aizYjDSJUUThZsXGc/uVZES/6jG0r4j+RZ4qaXt9hWZEOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678xrbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:42:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57REimjY012170;
	Wed, 27 Aug 2025 15:42:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43asnn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCWngTgUN0qDDro4YLlmtTn1Rk96HSRGu15pe8l6fl2aZyyqP+sCNFSjb9h69TI5ZTV21aI6Yh9eOgAuSnZU1sdyciGJak4+mz70jkuZfje6CoqxKMuBNZbctht9sX94XQVHdS01IaowOk9Rjf3Nx0aGqXm7KANZ+gQc8MJrDEm/MZzzRYvIg/Qs8WE9N0NyyDQciLBZO24D2sVlWFTma0havyJ19ssincrIoX8X495PGqwak4azzqyxf/Pd0lSYWPtSauVmCtGYCbpkzOq3uJR5SkWFjp8aCrUoq25uh4tHGRBVDBUmaDIqRZEBuD/6R1/TlsXnyfxlYGKi7KJJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqsbcGPQC/t7DiWQil2p9m6RobPmjc82mLdVLbVEolQ=;
 b=GQkMvw4rOjHzWVvl1Prh9XQHVQWf8VNFtvfCwwULpK/mPnBOoEvJtrl6LB4mcKAYBji9BXyCDMtucVTU/LizW2lVud13LhNTlVdjMl/OVWpYrufBy5UjiyKP4ZCJ7FZtkGLj1wVqRM+hmrpuSq4uFEE4jlkxxK+P7dS8DVWAEyHAjvvWe7ChlVA+1iOsHwKNLWFavFDsn+gNRLPj6QGlphXwbQpVg6a1sixVz/Mmb9javdqo6OcB9aFxZXKeFIkh+MAxP0PyHHgt6vnv0ly50HKqdz1+G+vhWUfB4HPqxOjDcYhfrXC6EmZGynY54ydZ957g/usbCYBlSmt/GqEfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqsbcGPQC/t7DiWQil2p9m6RobPmjc82mLdVLbVEolQ=;
 b=ASKtooR+GngCq5ZxvuxkBixVZKL74aDEuWiVlOg/Fti4pxASFX0MsrTEIkbxX+7ZNlD7hDYQgAvby+qGU+PMmAV/EFl+jbJB5ilkftsXxt5Ggwu4mcKOPsEoZpfgTyVzdkROgmUUR/8THh6CfFy4hxahQ34hoqY3ib6U7w+pUCw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 15:42:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:42:50 +0000
Date: Wed, 27 Aug 2025 16:42:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc
 bpf_mm_get_task()
Message-ID: <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-4-laoar.shao@gmail.com>
X-ClientProxiedBy: LO6P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 958b6581-826c-4e17-38a0-08dde58060d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2EAR7mrANo7nHC9bONPRnnF9OmwmfN2KRhXDcEakySYlOR1PjyNRpFla2u3?=
 =?us-ascii?Q?gUf18dEJ6AWYEpsKLSohj3+EclK9PGgoHiSSBfTNFFovUZ7pfudCvoF4vTvk?=
 =?us-ascii?Q?0w6CvotUkdVa7JAPO1xP6wZvMFy4znqibPJdWRdHhEkExXprsN4eGe0dv2hc?=
 =?us-ascii?Q?GpG/RvlFoU0NtAL5B0f6/5fzl1cMDQnFknxpoPRZafIgL+EJfDuhBJ/3a94S?=
 =?us-ascii?Q?Wkl7qnjD8fYqcdN3JnB5+e5kdrs3Co9NpUlm2rdVLgj8lU3Fxba6fJQH+n1N?=
 =?us-ascii?Q?l9X7U28/ed80HG5sT/Tqq4WE7yQSeHRwZZP5CsVA/01ZxsOtdYPMdsyJ7pxg?=
 =?us-ascii?Q?TRq4WNhyk760otJZ8OjXftyXeIKHJVPvgYl9fym++BQyLO8EXhmu+UljaJEQ?=
 =?us-ascii?Q?WkyXGvJi2cpP0NrHUdxH3TQ6mhflFaPDyOVH2hwSKsP+P7Va8PSvSsaJ79hE?=
 =?us-ascii?Q?Urn5b30EB5FqPGKTQhnA9c2TiDlRhaeV5cCxeG4zNg+SguhrTFBIkwnuMte/?=
 =?us-ascii?Q?AwFsCi8wNtDyMSZC7UqSRIxgoUa5HZwcdeXkRt3JExV3MNOrJGGjDnH43Bf1?=
 =?us-ascii?Q?i1Vy3z+GxgrTn3M9r6SCDmn1k2M2jKrP4GcJg6GU+rGGlQebkM+tPKb0s6mR?=
 =?us-ascii?Q?bFFikihmSTWkeuKeP/9Y1KbmD7StOnj+X55OmV6a5AwMOHRm022df4mYc5jg?=
 =?us-ascii?Q?coEucPD3DQPqCAJNYFMqSE3qjp7PGjw9pyGp047/e+wMD7wRsVZ2SVkgOZ+E?=
 =?us-ascii?Q?AduZEpnAl8RbeTpLHeWIWi5sGFBDxfy8j2t5++pWoK4vfmb0qBmLPw1mk5LA?=
 =?us-ascii?Q?NwoBC7+1QuiR+tyXz/VAsoY12kS9USnF8HB2JYG8DYS8YZL+DFF4djUlz4ER?=
 =?us-ascii?Q?bjEGmZUmaaeoqJog18PPpitl/LsgQRidWefAWCBR2MaARAcOTIVrS/p2G7i2?=
 =?us-ascii?Q?LOmFwFYWMbIyIUAa3RHGh87brFZQW7cD14BiCwU6eUXhozwNFEDfj33580vi?=
 =?us-ascii?Q?zLDMu5ZT9qq5lbgpvNxLy3iwyLpW0lkt8N/Cs96fpB+OqSrV8yPe2/aPswpe?=
 =?us-ascii?Q?45NuHmrqPuVtYy97BDy2gYwIHnXKXlVMEdwjyahuojnMBNB799nnQgMf1BmU?=
 =?us-ascii?Q?iXGBB/46XP5rvtyzO2j0jsnou9+xZn4eWBLNgACcSwYQ3rtq+Iw8g0dbqa3q?=
 =?us-ascii?Q?R0TlwWWk0nW4CKbmYfbN6bwIX8VsX9k6ubSzK8wErADGLAqAXn1yOAEdEME8?=
 =?us-ascii?Q?A6dkDNq5pJwarPmrqcRkGGAxnB8MxeWjmGIEt/GIM94JSsXEb8c3saJ3TSCl?=
 =?us-ascii?Q?GAeFOMhPJRxv86OMlWp/OxOyY1tD8SJ+p/3tcKEzEIU6ZA1aD6w2ufCk97gM?=
 =?us-ascii?Q?embw6lXPmx7/lf3jA3BRSXR/a3IJ7BC8CWLaOlubk944Ld+W86GICJMih42u?=
 =?us-ascii?Q?opwQNB4+yok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m2S7lTkjojElW0meiTok4a0PgcFnDz27Wy3OlAgmAXZ5e2ZI/jaz3O660jQ1?=
 =?us-ascii?Q?50QokHaJlfKcybxngJXGkriN39dS+vuY6CRgfYqxD7XQfaVCNTBRZjr5Dyfu?=
 =?us-ascii?Q?G1NTw/IBVOlM/NenfJJp10+AiOdVNGXLcsO80W7ZaNLjaf34oj1e81KtmAVB?=
 =?us-ascii?Q?vHl3i9Y9C29POLwbP40Y83mDG4KnFqRudewrt8Uic9G3dOIVjLmh2TrdbzE7?=
 =?us-ascii?Q?HGzErp5oBUlcGlA17YztkSG32tJ54HD57o7pnKzxq2H+XtrVAOal6dvKadPd?=
 =?us-ascii?Q?LuFL1OTUwjNUqQOJrCjkrjrRVDdQC/Bqa9+84q/M06hr7tN4y3GgxjiJTIau?=
 =?us-ascii?Q?Ir4hayOI4aH9tVlXRhmGD1gSFcWFRVAdVsCegRZ3YpKcduLkc3Rdrn5rHMr0?=
 =?us-ascii?Q?mDjKoFva24DyYc1HDRAJdBX2j+FSWizmFDT2GhjcjVTlRn0fsm9F30nd2m3F?=
 =?us-ascii?Q?11sClYW6OCNaW98ukppdK9zpDmROE+G9b0E+UQZJGiRDjZkZQf0/Yzt1Ffq/?=
 =?us-ascii?Q?iAwX/gUCoL3HUrqU08BqzhYaq6ECeEEFz5zo+GisSXheJ3zYYOFeOYFqnIzl?=
 =?us-ascii?Q?PiCQF6Sxz7r2Gsef4dNWkBBr01jx00uVl03ETSAUaKoSzWa4EbicrqT+epV5?=
 =?us-ascii?Q?8ydA9V4btvLyZYGuTowGGK3Ihl1rGdWl/k6yo49Kh8oEq1t4sTYb1kcvAG2F?=
 =?us-ascii?Q?GduPFNEU/lOSU218yKCFW0w4Fb6cdhm0xnPgQdnFs8STFXxhv8eekaSLmS/q?=
 =?us-ascii?Q?DB7Pq8ANR8Mc4D45sjw2FWZshwtKXodTmKhaLESjesw2VtymDsJaTHgVdDwL?=
 =?us-ascii?Q?gKFBhIkqDVilz5HgYnWTw002W52COtVBuyBYfbOo8tEHAA1sSAEJzQQ49/Lc?=
 =?us-ascii?Q?ZIB3dahcoUeu0irkqmpSe1LeRdH6j1GVpOXQvfJr8/Tp1UFB5TlDRruQVR/s?=
 =?us-ascii?Q?zjtF6ilju+LWVmXx1TQzCv8Q5uwC6KN8ZGo7IZsIw5tykBuzEzGJxtu7rnJp?=
 =?us-ascii?Q?B4L/lJGCHxSZ+j91MSVAJy3FHzT1u0ZQG9oZIUB13gmKnUqoUilu3jZopigf?=
 =?us-ascii?Q?Hhu6OVtw1P/5szuUy2Mk/jhTogG6RCJb3TdO/pFqfScGkWPbo2qjj2jBm3ni?=
 =?us-ascii?Q?70wEu1wDJ+4BLl4J7ITLKaimKW1XH98seHiDuhSfCB5248yrA9woMF7llGeq?=
 =?us-ascii?Q?EfOaKMCY52vc8ApPGi0VDr65syPRC5ppejyoyNJ1uP3cuaA2u3Lmvj/YMGyY?=
 =?us-ascii?Q?WsBiM5gZ6TFUaVYyA/FhnZ1Y4i9mdP3VM5TEK8EG5LkNtYjR1V0VswSewmga?=
 =?us-ascii?Q?gHLXZPRGbmaXmmx4eE2bp+CnF4BlOIwqYg4nDuto568q66RCllj8dn0ZojfZ?=
 =?us-ascii?Q?2GDzD2zzKbcjO2NdeheXYR784KrVNqKIaeVtnVxTIzK55eWYz4TJKCoSfi1K?=
 =?us-ascii?Q?xG7y1Kdy+55TWU18iyqSR/twBYfZofbFDGwW0wNomKBO9FBod/qQsJYmfIKC?=
 =?us-ascii?Q?ovOp1h97cm9Sq+DirOp/S6DWU66ZeI8hzT+qhJDi4rIQRyOR6IssJJRmdMSK?=
 =?us-ascii?Q?Y6NG+imglhBX1MrPMxb8YvmNrPGWFB88NsOpLEGNTcYCNbRSsNoMAPEGMlsZ?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNsGtBIF9IRTB3j4xVSBaXPQR0svvDRerEWyjqden+FF5wj7pPafeyH7RX8dxpHk7VAqIhVSvM+w+Ei+OsLOw9UenyNg4hw0+twYdAWy9j1d87gKWtyHJPYFU4fRzIOP1ccxP4dSS0wp22Ak+xUMuns++0VkseIsNKBqc9/APMLU5uFBVMpsuXdde/JytSMLguOGxpx3wqPmy55PkgxLoAgUGhfpBD4uxCQ/5h9B8VmC97tTEwYjWm7cfeqWM3JquOxRoEv4aTISAfhUl6cu+u1pG5deC/luhHFr6a9N94Rr34ARCcadT2c2qgnIxRc0ed9BoeohtP8G4aOsSAkFU0Ka+G+caXPDHp1h2T9gPFgKlnZRVG0m2+3qwAJLNWv1dnCquYkOHRYiiVUH41fb6TwvzcNBPAugCjrmEUMbModPgcz8m35t2yXaQKUh6qmwVVKdrDy2R3bF9gn2qm5vpyHuWhML3B5VxhWsQgPFPK5OjJyh1nWBYka0IX4ZyVcgff5/zHq0Oguld5crx/4DIYEQJM3/Vko7GvCnWYGLLdQvkDQGFiRxQ0Le4HvPHIFNwTrT/0aA+V09ZfnM7i4ff7Vw+N160UZTBnUx4mAdGWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b6581-826c-4e17-38a0-08dde58060d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:42:50.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izPsqExG2QggQA32BmjRU7VKX4WKmYPSUARcvGCapNV6u620RLpNZJBlleKSVU4+DEymVcVYWZVjMmBiH7Zf+ycJd1d1aqIUWkVoQfqSebM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270133
X-Proofpoint-GUID: LTPoIO4MCeiNlTv1oTXb3e_Bjwxpqurt
X-Proofpoint-ORIG-GUID: LTPoIO4MCeiNlTv1oTXb3e_Bjwxpqurt
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68af277e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=xJ6ztnz1zjBCtSHedloA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX59WEMfeWbdFV
 Ki5cv4fZugka58C6qxUJDlXeGUbfTV0GpsgeINUtCeJRkC1hTtpvWaaAWAajgqRflFqFfB/BUV2
 8WweN7X9satgn5yCiOmEm8nm9KrEbcnUir2vsDAkz8zvb8QPn0aAiVVMcQ4jFeFtCBcNPMCvXnx
 1IBBaGQqwJQzmTu2KG7Uuq2JGFvLiUROKrzH+wND6qc0bVPxLVyeMTnLCr1O6qAmiOuiOcKWi41
 TpbV/MywgAnzZnSX/0KE35irKPpoZS7LwezsMPK/8yfCIUoFwf70o2GJ/NInuMNtu7+LrEuN/8H
 nMDXZ/QeJ1Vjw2UMg3mbtWHqInKHBvnM1+eSmdtFUcGx8kwep5ezfDuDMWpNAn9ajRYKy07/CpS
 VqDti9W6ivK1Mv/wq9S80CUOWmuGgA==

On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> associated task_struct from the given @mm. The obtained task_struct must
> be released by calling bpf_task_release() as a paired operation.

You're basically describing the patch you're not saying why - yeah you're
getting a task struct from an mm (only if CONFIG_MEMCG which you don't
mention here), but not for what purpose you intend to use this?

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> index b757e8f425fd..46b3bc96359e 100644
> --- a/mm/bpf_thp.c
> +++ b/mm/bpf_thp.c
> @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
>  #endif
>  }
>
> +/**
> + * bpf_mm_get_task - Get the task struct associated with a mm_struct.
> + * @mm: The mm_struct to query
> + *
> + * The obtained task_struct must be released by calling bpf_task_release().

Hmmm so now bpf programs can cause kernel bugs by keeping a reference around?

This feels extremely dodgy, I don't like this at all.

I thought the whole point of BPF was that this kind of thing couldn't possibly
happen?

Or would this be a kernel bug?

If a bpf program can lead to a refcount not being put, this is not
upstreamable surely?

> + *
> + * Return: The associated task_struct on success, or NULL on failure. Note that
> + * this function depends on CONFIG_MEMCG being enabled - it will always return
> + * NULL if CONFIG_MEMCG is not configured.
> + */
> +__bpf_kfunc struct task_struct *bpf_mm_get_task(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_MEMCG
> +	struct task_struct *task;
> +
> +	if (!mm)
> +		return NULL;
> +	rcu_read_lock();
> +	task = rcu_dereference(mm->owner);

> +	if (!task)
> +		goto out;
> +	if (!refcount_inc_not_zero(&task->rcu_users))
> +		goto out;
> +
> +	rcu_read_unlock();
> +	return task;
> +
> +out:
> +	rcu_read_unlock();
> +#endif

This #ifdeffery is horrid, can we please just have separate functions instead of
inside the one? Thanks.

> +	return NULL;

So we can't tell the difference between this failling due to CONFIG_MEMCG
not being set (in which case it will _always_ fail) or we couldn't get a
task or we couldn't get a refcount on the task.

Maybe this doesn't matter since perhaps we are only using this if
CONFIG_MEMCG but in that case why even expose this if !CONFIG_MEMCG?

> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_thp_ids)
>  BTF_ID_FLAGS(func, bpf_mm_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_mm_get_task, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_RET_NULL)
>  BTF_KFUNCS_END(bpf_thp_ids)
>
>  static const struct btf_kfunc_id_set bpf_thp_set = {
> --
> 2.47.3
>

