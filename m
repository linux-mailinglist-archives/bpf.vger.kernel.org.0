Return-Path: <bpf+bounces-58942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15288AC42B3
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D632D1882873
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F521931B;
	Mon, 26 May 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZwzrPEw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TjJbvc4u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6066214A6E
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274950; cv=fail; b=C3cepEHqcPQi1DC05CriG5pq7ORKnMJ4q8rl6UUOhs1ltcU3v4fuxy1PKuzBf6U/WkZxumARFZbv940yRx77awgNuDQpUlvVoVlZhrGj8MESxQvm/qasI1gm2J+q5iZxU0pEhxk+nX7dX+YfTZIOMcv5gxgo4iq36DkpG/4/IPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274950; c=relaxed/simple;
	bh=nSHMcB7e2z1Nf76w1pL9bvzTV8gH/ikJbkNLGl+hf6A=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQHmETJcFNUM/OuJ0JJzUcwdaHMZVHhODpmzzK4P/UJZJv9z6gwLBMmAYfam7cilkbZKW07RXxlCRTl5bbMQofP6bus7Y1EzgPmx63POARLnfNum69fanGGhPx7p48ZXciZPKyowetynM5AVsukKfLVz/4/PyPVz9KLXg81moOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZwzrPEw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TjJbvc4u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8twEP005564;
	Mon, 26 May 2025 15:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KhexgVufcfQneSWAa9aZ1C9IKW1/FNSYG04N1LJAQTs=; b=
	BZwzrPEwIJNUHBo9FVH1XYv6fUE8hDtUPd5wkP6vWsyMEtPa7a9H8Osrsxd8lDTX
	3SX9dBDZgN+fOUCQfy1r59E3kX6hAwErUkFMMZP7VS1vDR4+WIc07K35Qy6yPhcu
	fbFSnXKzn1AqDGclcoQuZ9kVttdU17yX1LtX8W9zvTv7cTc6SbSXfLLCAWTJWLhH
	5PnibgZyIS5KHi4gZyeWOxApv3glYYstZ3AETaZp7j6k1Rfc18zSWsfaYgUAU6eI
	jShGK73zKwuEIEL4qCo0HdnGaKDKX1N9d5EfTMVdEapJQw8JH9BP0V24YjHMWbuj
	/YZkRn4Dp2U6+ByycbCIJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0yksqnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 15:55:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDEGtk035722;
	Mon, 26 May 2025 15:55:02 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j8x89p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 15:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyThJawFQ5BIgKq8XfRd9k90e3Y2Hhyh4G8vh1Nf68pcCyaPdWek4fT87RAu+3Ahb726mRUosOc1nn3UqpdHLa3gAZQPKMNRvA74VEo+GqVdC8svI6y/2Fpy1pg0ApAjZCB5HorRpJFVa1+r9cAw0IfwBXM/XWZWLZjZAbJzGuE8HGa2WZVCuhZrwD4ZXt6boWMJfn/a4UIRQFmtGXgsAfvmX7OEO/vXOvoH5dfg3/dwyLEK6AQUpGvs/aCj/X5UpNT21e7RAH0YPPfnvNtv43IDjQzfY8Jp2QhsyAlED3h2mkWOzqdO34L5ry9pnNS9EO3qjoRi3vnUJJ4tvcX+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhexgVufcfQneSWAa9aZ1C9IKW1/FNSYG04N1LJAQTs=;
 b=cemY/sIm1f/reE0xihqVGquTnxvhkCeHbYZiEPhVe5JnZoOxd+XRkEbv+MyUEp7v6/umRn/1JuZindGn97rsJQmzfRi1u8Xj6JZelffQDBkIoRmr2Jum/eXjRqMQHpZB8Q6fma3NJW9JJx4uQzsXN/Lz5wt3puJjdmyVB5KNAGm6mR2mKvEVY2KsL99ilNoaJXg0sAai3DXfM+W1j7WgWlswXfH9kvYcg9QDIn2eTbK/aifua/49cqANG4r3/EQTofrXutPnjrbZk4KxTpikO7OuEZhk6jD+RH4XtzLfgT/dlMmPKfGgg41dteABSVbWUrxqmUc8XqyF+8cYKKcUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhexgVufcfQneSWAa9aZ1C9IKW1/FNSYG04N1LJAQTs=;
 b=TjJbvc4uMxlYJkYHj7Fe3Y9mJopdQLf6cRBRxea9qrThd7ETrP67XYlD1AIxSzJZWJSy0ao3TAdrkgNRC1RGK+uq/nzIFL+bSdP1+/xaAN8+ZtbYQk109lYfWT9MDGWNmxwPnNo+VDAF0dROZVlxFAG39SrWzjaD9qQNahQJ5q0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB7298.namprd10.prod.outlook.com (2603:10b6:8:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 26 May
 2025 15:54:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 15:54:58 +0000
Date: Mon, 26 May 2025 11:54:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>,
        akpm@linux-foundation.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <pzuye3fkj6fj2riyzipqj7u4plwg6sjm2nyw4jkqi57u3g2yp5@jmvn5z2g5i7x>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, willy@infradead.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
 <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0077.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ef6687-1fe8-44db-6123-08dd9c6daa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWxGOElBSTlCQWlBRzg2Z2JCREtMdlh0VHMvK05ZN0dVd1FYaGR3T0YwV3pt?=
 =?utf-8?B?VE5UQ0o1d2VybHcwRWkxQmU2U3hUK3dHd1pHNEJIYW1hUzVHUUUrazVNaDdp?=
 =?utf-8?B?ai9YeW00QmRsRjVmbWR5LzhPMHZwcHU0UWVHK1dzV21pY2pkYlNTelI2b1Jk?=
 =?utf-8?B?YVhYMDF6R2JTZmlHSXFES3lHelFob3dEUTYvS0xwaGdrcGlqaHBsbVR1K0V2?=
 =?utf-8?B?L2JpQ3ZyVStySEFUWXhhM1M4WXZ4c0h1NWsxTGpPQVZJV1lmQ3JLVXpSUnZN?=
 =?utf-8?B?OVdaUkx5RHRDaitwSmVpQ0NucnFIUHJaeDU5Sk8wVzlBcmRmWWNkc2RRb3c0?=
 =?utf-8?B?Z2QwVDEwVXBoWVh4Q0xuSG9tR3hNSzJmWHR4QWRzSVdYUTdTS1AvTnY0Y09N?=
 =?utf-8?B?NTdwNFBVOHc4dVVSdW4vQlJnS1h2SGZTTDFJMnZGN2MrV2hhR1hoaHh6VGdl?=
 =?utf-8?B?bGxQUUpVSjRWcXd1emNKbDlLcHNqejBYeUE1NVFzSjNXY2VMTWNVU002Zkkw?=
 =?utf-8?B?MmNRVGVLL09veTY5T1Q5UUtyODNBSjRVcElXV29XTnluVkNXeDNHVlZxQXI3?=
 =?utf-8?B?aTc4QzVPaEpTajBqalhDYjAzUzB4cXoxV0ZFcXVPa0toSmloUzU2SlN3N1VL?=
 =?utf-8?B?dm5aRE9xcUdYUEFDVnRzZkNDQ2cxMzJ1V1B4OU9EdlNjVzh6NjU3Wkk4Z3hk?=
 =?utf-8?B?WVhlNmw2b2dBVEdRdEo1ZHpoUElOMEk3WWFmV1hmQ2R1OTFQRG44Z1FsWHV4?=
 =?utf-8?B?YnZvTHpGU0c2MnVDN0RDUURocXMzNU1ZWGZVaXFSaTVJRUhjeWgxZDI3M0V3?=
 =?utf-8?B?ZHNxQjc5NlFBcGhDWnFCcC9zcHRiUHYrbFF2bWRwOWRYc3hPWFZVcndmSFZT?=
 =?utf-8?B?TzVFRXMzN0M4K3R0anVJM0djOHRqWUFibU5OZVdudlA3aFJwZ3cza2pDVWVZ?=
 =?utf-8?B?TTU5Q3NNV0owcEc0UjdHM0c4Wm53Z1grU0lZZDAzbmswZGpkOFcxMzV0bUlq?=
 =?utf-8?B?YW85clFSQXdjRkRCZEJUa3JIRG5tTWVlbzZyNFVKc3BWZ3dkZGZ2OU9oZE9K?=
 =?utf-8?B?dFhQWHZ4dlBGQ2lkZVBqMW9uY21tNG9lL1RZT3NnV0lsTCtQeHBOUnhBcno3?=
 =?utf-8?B?OFFPOWNLWWVDUm41NGdWVGFNekhHY1ZRcStteHp0UnN2NG12L1pKQ2x3WFFj?=
 =?utf-8?B?NU5yeHdwaVdzV2gyM1l0K1BGUXlKeVZZNFBvTC92RmdQUHlEMHRTbVl0Z3NY?=
 =?utf-8?B?MkRSemRIU0s5TWVXTSthaHhHOUxjL2Q5U2k5NDNGbEE1WllPTWxPL3hxM0Z1?=
 =?utf-8?B?WnMyN1p5L3pLRit6cWJVMkY1bjVYOUFPdDh6UWVrUVppVUlhb29vWUM4MUhq?=
 =?utf-8?B?VVJYWDA1V3VWZlRjanRWVW5ZRWtkZ2VMa2JTTlkyM2k1WVZHZDFRd2t6R2lz?=
 =?utf-8?B?cWFIOWNKS09EVU5MZ2dQU2xheXB5SlJ5QVpJa1JNWDRZRU55bEhCc2lBb3Ja?=
 =?utf-8?B?dllsQTM2SXEzTDlTZ2NOTzBLY1ZKZjJjajFPRnVxa3VuakR4K1pQTnhZTnRN?=
 =?utf-8?B?eDZoa09sTXYvRnBJYTZHOHA0eUYrd3pjZXNBZ0p1em11bHF5OWJvNlo1MEF4?=
 =?utf-8?B?SVFYNGJxVHc2bmtuUkJHRFhZaWFNKzlUdXdRcTRpMWlFbWxrQTByVDMrNUU4?=
 =?utf-8?B?ODV2TlMvTGZTUEdDZVRBVEV4SERZb0lhcGNyYTRydFR3QU1pTEJ5SFhUUmc0?=
 =?utf-8?B?OGxJY1NQZmNXcFFDY3dTc0pnRm5KTlNRZ2ROSjUyb1FuSi9YRGhzUCtBNUpF?=
 =?utf-8?B?V3JUTlpreklJVXdkcU52dDFTRWExM3lNa1orR09vYXBqYlo5VzJnSHdjVFMw?=
 =?utf-8?B?UlRWa25La0U4MHFkZjNobWpHZWI2THQwWlhrcDZRTHluMVZZOHk3NzZ0NUZv?=
 =?utf-8?B?NncyZ2FKQkQ4WTJMcXVTL21XR3hJV05IVVFDMVlnbnQwY01UV0RkaTJjS3d4?=
 =?utf-8?B?bVhEOURBaUlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRQTTEraEJSRkkxb1VGR3ArSHkySklyanA3WlAraFNua2VWMkxtbkFNRkpU?=
 =?utf-8?B?Ly9aaVNNbmY5SUhGMVNsMjZlUkFZQ21pMHI5ZXY2UytMSDJYWXN3a012SjZF?=
 =?utf-8?B?WmNKaGpMck9vc05QUHdJSVpXajhjUHRNb2o0YWlHemJ2Q1V4cjYrSzFPZkN5?=
 =?utf-8?B?V1JVVTRpRTdFUHFuUU5WS0FLcGVFK3lSQndwY2x1OFp0TFh6UE1TRnhYU1Y5?=
 =?utf-8?B?dU5VdVpHM1lVSWRlV3MyWkhtSWN2TmZsdHk0SFVsTXBLSlIxL3Y4a0wyZ0d6?=
 =?utf-8?B?K0VGQXJpWkJMMk1Hd0NGLzZVTHRmSGxyQ2xZQXlYSDBYZzNLalpnN1I2dy9p?=
 =?utf-8?B?eEVjK3NqQks3VEJqa0pCeWRXZllteDVhMFgxYWZZaHlpdVNkYXo4bUdDZk1C?=
 =?utf-8?B?OWNlMTBqWHJZekFuR0hiS09rZFFkV0ZGaVgyOVNCZklHTnQyWnRUWkNNQXAv?=
 =?utf-8?B?YXE2SGt5NCttYStsODRUd1hUKzA2SHlQV2NXaEl6VHhXZkVONzIwY1NYZEU5?=
 =?utf-8?B?VU5tS0NPdzNzVDJQRVY1U0VJN0RvMHQyZWNrRnpDZ2ZTYlg2ODBYUUVKa1JE?=
 =?utf-8?B?dXd2azZFTUFZdWdJeFNseXZieGVFNUliRUlONnBYTXEwOEx4MmZEOFkxMU4v?=
 =?utf-8?B?UDl3ZUQ4WTVjRHo1Q3pEcDNocHdQOC8rOFo0Q0kvb0ZkdVR6eTVhVTJtUDk0?=
 =?utf-8?B?VFlSVFR0dFkraUhBcWRML1JJZytZbXViamhXNzhoMlJCc05MYmxTUnd2cGcz?=
 =?utf-8?B?ZklJWVhhSFVIc1d2b1ZvaTNPZmtVWlFuTlBFeEl0dFJ3bEZLWWJjN2UvNUN3?=
 =?utf-8?B?TWw2R3V5RjEzYmVjdUVla1RML2xUUis0ZW9HVU1JY3ZUVlA1ZWZlcjJpVUhv?=
 =?utf-8?B?bXAzNkw1enVxUm1LYUFzamJIM3pNdHNFK1hLYlV1cVFZVnJiYjJoa2VOZ3N4?=
 =?utf-8?B?TWd6TjhrZjNXbmd3MTQrZG1EaElkbFdna3lrRzY3NjMvRXRvMnhxZU05MHlG?=
 =?utf-8?B?M0FiT1JrcUtQUzJoQVRCTWMrVC85ZDlYdDZDc0x0M25ub3dSVHhyZ0xpaXpC?=
 =?utf-8?B?NkdycmdLcWlMcXFBQjZwY1RxQVFBWHVZaGl2THBxeTh5Ymc5MjRrZnpSclo0?=
 =?utf-8?B?NWhPVlp4cW15WVhtWXk5K1A4ZmRhakVzVlBDbFE5dFBlSHJoMXVMcjMzY3hl?=
 =?utf-8?B?T3Vmd2JTUmNjRTdhMG1ScEJqWGd6ZGkwRzE5VTlnKzNJNE5PZ3N0bkpyQkFl?=
 =?utf-8?B?T1U3QUVQeExoclNOSmJMbXJBZzNlNCtzcm0zSXkrVUpCQ3ZiMjBXRHBUR0xo?=
 =?utf-8?B?UDZJMmEzcWhLSUVqM0lueUlqM0Z5WUVadUsrQisxMzN4WC9kbkRqRFZITlVD?=
 =?utf-8?B?N2U0Sm90OWpETzNUdURmY3oxYnVoUmtXeGNPejRSaUVFV2JxQ09xWC9YOHZj?=
 =?utf-8?B?VlpVcjhwUjdIQVlibWIyT0REQVlKZGhOd0hlRTh3WktvWW1nM25RVmVCM2kw?=
 =?utf-8?B?VzNVVC9jcndQc3NjcWRrdjIva0w2RVAzeXFHQU5sbWlXYllGQnlFSnBXVmVz?=
 =?utf-8?B?N01ta3ZJZ0EvZWFVcUxqNm9SN245K25XYThsamJiRWFrdno5aXNSOHlUckM2?=
 =?utf-8?B?TjIvTjhnMjN6b2FqR0FkSjNSU1h3ajA5d1dpWlZ5TXZHUXFCQ3FXbDdkSmpH?=
 =?utf-8?B?akJWWDVlN3dmUXRqelpQQmQzVjFNZEhpaWR6d21tTjhua3AzU1JSM3lkZzVU?=
 =?utf-8?B?emUxaVFjbWZLeEUwMGNpZ0pZWFlRRTBGS24rcXV5OXZ5VGI4WkZmSVlTOVhZ?=
 =?utf-8?B?aVE2bmJTaHpqbG1yNTUyL2VxOTArRGlQbXdjekRyUTU1Zk1xK2VhZitXc1lL?=
 =?utf-8?B?YTl5VjBnZjFuT3lIWkdJY2FPUmJnTDVWMnNSN2JJa3lvdXlmYzZBc1RlTmZE?=
 =?utf-8?B?d3JhSlVPV3VCUWc2dSs3dUxtRzRSWXIvb3ArdUM1dGxOVjdrdVVZNXBzb2ln?=
 =?utf-8?B?TlowdXJDRmNvUk00ODZNcGFueU40aTk1N3RZRjBkVzRFL05FVC9OTUZkL05P?=
 =?utf-8?B?ZmRoYVZqaHVDS05zRnc5ZHhoMFM0bUZUTy9YSElRKzh2K1VRVi9Ddy96SHYr?=
 =?utf-8?Q?9jqx5NA+GVujsCCHihJ/7mXLX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	++cPrSojeOiDI7Pxt/PEc5aOrrrHyFtWEPH5BztyIurCG7BJ983V5mYZiY/5xOhN7CmSBn9tEKKzQZxlFmpDNDs5TuykWH6wtk9apUIgjCY5gmxPXv8uYyywvWKpMMcckyQvl/GHGoMDRWL0ePN3z7vYolyQ1PQqToFAqqX3zp34VIzWn/SCENYUG6TBZMyVLIN0bKpuE1hwZbLQew5sBIRtzAv9GgMnRkTRbJ75HYR+8BL63IrfV+TzwXYehfw8CnjDcaooT8Hz2aYibvzPNXqu2RX6b+pXxhT4XHuNaaCE6IbdH5oaK5CA51g6bnb5nAuf7YRTTdFunShr8e5exORJDQnEVddbsSXzN3eDn8YpgKBczbCgYts/OBkIu6RF89NxAr0xbOxbPWRslIzBKUXJP3AXPYQ0NztiihLKtHBwU4S2uju4FeHJm6lf9kMEERc+xhCUtz4ppoo0gxjbF07T1KC6T3L7iahN8pajlcK9hQWHed7iE2v16C+jEVaVxwHD/WgUpwpqDyK/yQJx9Rsq/WASQOzByKkX/hB673ISRPL1ChJMBJVYx6WGAJiaY4wFh7hghOo2wOOCpjBU9KG3+YxrqGddWwuCDs+m27E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ef6687-1fe8-44db-6123-08dd9c6daa91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 15:54:58.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBtmUinSLUZcw175/oJS1sGUDoR40H6Di58Cd122UqX3Hgstr67D7xXV0PnPHcMYndlfYkGsTgXkQA2/56oTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505260134
X-Proofpoint-GUID: esjsY6kjaVEFGmA-vs4XfWUSiFlG7SsF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEzNCBTYWx0ZWRfX0PzBFYOvpMg3 JjfR/G70wlQyZah1rw3Qud4AzXL+StFnRWrNn6ERuagZevoiA+UMA6K3WVsj0E59NyPdHdZdySF I98kbMMUrPwsai8yZCHzkk2pE9vSKgYJ5Zf3OVgyKHkBvmubFFqmMm4G/WvQl57q9n2AgCGWkEh
 IKXsV2l2N05dQehM8ZdFI44duvRY5wi7uCoHfkPyzujmRveB2NJvYC7vdV7eTL8Gfc7mM25z9Md dzUfkC+1tyclqpAa7HzGbh49Gq3JE9EIbZVpU4PC8wM0y5ursEN2yj4fkX3SX7rWKX5F/ednhdd wSeUKxnuFtRVvKObsn5q5uTwQu5aYLp18RPgVkNsTQOmhbGZNSDHcDPlYRbGJWOdvkLYR49NSlO
 cdxbcns15tqag6Aicdi3ZXTkeAAMhOQHXzO1iaUVRPp+YihuOJex8p+q9Rbv3sVp0yf9j+2Z
X-Proofpoint-ORIG-GUID: esjsY6kjaVEFGmA-vs4XfWUSiFlG7SsF
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68348ed6 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=xE8BZNaLe4sqPv1Zkc4A:9 a=QEXdDO2ut3YA:10

* Liam R. Howlett <Liam.Howlett@oracle.com> [250526 10:54]:
> * David Hildenbrand <david@redhat.com> [250526 06:49]:
> > On 26.05.25 11:37, Yafang Shao wrote:
> > > On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > > >=20
> > > > > Hi all,
> > > > >=20
> > > > > Let=E2=80=99s summarize the current state of the discussion and i=
dentify how
> > > > > to move forward.
> > > > >=20
> > > > > - Global-Only Control is Not Viable
> > > > > We all seem to agree that a global-only control for THP is unwise=
. In
> > > > > practice, some workloads benefit from THP while others do not, so=
 a
> > > > > one-size-fits-all approach doesn=E2=80=99t work.
> > > > >=20
> > > > > - Should We Use "Always" or "Madvise"?
> > > > > I suspect no one would choose 'always' in its current state. ;)
> > > >=20
> > > > IIRC, RHEL9 has the default set to "always" for a long time.
> > >=20
> > > good to know.
> > >=20
> > > >=20
> > > > I guess it really depends on how different the workloads are that y=
ou
> > > > are running on the same machine.
> > >=20
> > > Correct. If we want to enable THP for specific workloads without
> > > modifying the kernel, we must isolate them on dedicated servers.
> > > However, this approach wastes resources and is not an acceptable
> > > solution.
> > >=20
> > > >=20
> > > >   > Both Lorenzo and David propose relying on the madvise mode. How=
ever,>
> > > > since madvise is an unprivileged userspace mechanism, any user can
> > > > > freely adjust their THP policy. This makes fine-grained control
> > > > > impossible without breaking userspace compatibility=E2=80=94an un=
desirable
> > > > > tradeoff.
> > > >=20
> > > > If required, we could look into a "sealing" mechanism, that would
> > > > essentially lock modification attempts performed by the process (i.=
e.,
> > > > MADV_HUGEPAGE).
> > >=20
> > > If we don=E2=80=99t introduce a new THP mode and instead rely solely =
on
> > > madvise, the "sealing" mechanism could either violate the intended
> > > semantics of madvise(), or simply break madvise() entirely, right?
> >=20
> > We would have to be a bit careful, yes.
> >=20
> > Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because th=
ese
> > options also fail with -EINVAL on kernels without THP support.
> >=20
> > Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
> >=20
> > What you likely really want to do is seal when you configured
> > MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.

I am also not entirely sure how sealing a non-existing vma would work.
We'd have to seal the default flags, but sealing is one way and this
surely shouldn't be one way?

>=20
> I think this works.  Take the example from a previous thread where
> containers are differentiated by allowing or not allowing THP.  If you
> set a container MADV_HOHUGEPAGE (or whatever flag we used for the same
> meaning), then if a library uses that call and it fails do we want to
> report it as a failure?  I would reason that the library shouldn't hard
> fail if its unable to use THP, so it's okay to return the failure.
>=20
> Alternatively, if it is a hard requirement, then that container
> shouldn't be allowed to continue in such a state and should verify the
> return.  (If this is even a possibility?)
>=20
> >=20
> > > >=20
> > > > The could be added on top of the current proposals that are flying
> > > > around, and could be done e.g., per-process.
> > >=20
> > > How about introducing a dedicated "process" mode? This would allow
> > > each process to use different THP modes=E2=80=94some in "always," oth=
ers in
> > > "madvise," and the rest in "never." Future THP modes could also be
> > > added to this framework.
> >=20
> > We have to be really careful about not creating even more mess with mor=
e
> > modes.
>=20
> Yes, and clarity would depend on the mode name, imo.  Never meaning
> never, for example.
>=20
> So we'd need an answer to David's question below before agreeing on
> "process". If it survives across fork and exec calls, is it really a
> "process" setting?
>=20
> I believe you are seeing it as "setting default" really doesn't mean
> setting a default if you cannot overwrite it, and if you can overwrite
> the "default" then it's not going to work for all use cases.
>=20
> >=20
> > How would that design look like in detail (how would we set it per proc=
ess
> > etc?)?
> >=20
> > --=20
> > Cheers,
> >=20
> > David / dhildenb
> >=20

