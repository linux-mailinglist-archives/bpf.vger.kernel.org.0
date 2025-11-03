Return-Path: <bpf+bounces-73295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3714C29FCA
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 04:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337D7188F993
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C712877CF;
	Mon,  3 Nov 2025 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOIblLIr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bbZns1Rg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFF1F130A;
	Mon,  3 Nov 2025 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141514; cv=fail; b=EH9kX9RDhIzdCyxUhxWMAkixRGIO58/ac3gp1CIaw7wZtcNSERX/2R4/q0lCkzcHdMyDqXzDvwQMb0S34LyKX8fqypuk0X725qsitNnRX9OcTg+EIQWyw9iM6FBVSYm8sesLvQ/ArUSBOMGevNc1/+drJNy2m3ukUS7MBHW4AOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141514; c=relaxed/simple;
	bh=dxI5b9NCvpFRDcdWGKP3sy738i+t4ddcGcivUd5Knbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HB66IVTJPN0esflVod5JlDwMakvqImUbJgowdm9QnmbFJvkSfd4hUcHUhkyqRvN8Ibjoq3tn1UeVEyzqm5G+ybc9q9X/5hQmw9ZO6aAZxUL5k/8G/z7MTYYCTXpzZ+1qNmVyFcv0R7lFodOaP3Sf6ImwDJ+EZK8+54pFSsUmL4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOIblLIr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bbZns1Rg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A32o4LV021529;
	Mon, 3 Nov 2025 03:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=edgCDmWvWTUPNvQknusZvVYf9g5rm/ywalb/PWAyaZg=; b=
	iOIblLIr41Emx5AjPY/UOPoyNP/hEJ/qJRJreSzQQJsSbp5jzHIlLmzjLzoN25hE
	KPtAa2BETiV7NoPSOxVMhVSXgiBICLxBRd60m6l3phk94SHUHizbKNe3GAkwXM6U
	oEFZa6/bu8ak5xAMnGifmzEeVAg5SaK3ENDfTIDjDtz4oPngUx9wf7sdsPR54HR0
	EUfVxMNNi7lxCOVpDNHiN66G1sAD/QcmLhqUzPfexOln4aB3wOqu+Yy5gKkjukPa
	13HDAct3LLP3J+d5n1hrrxbKdooh76Q9WiGxuKc73esKCafRkGXHLbqfP4Xys5JX
	TrotLyl0zJkFDXjRIQmRvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6kxrr26f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 03:44:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2NU5HH040365;
	Mon, 3 Nov 2025 03:44:35 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhbqm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 03:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ1BsOlsn7UqTm4CR0V8oI1VRjTbNnTZ51UCzxh8koaoKY7NEVtywPPSiHPMB99z60pYTPo4Qs01AY5YTPz7d1DOMJcA8JqTpvGB+5VQTtyRJO2WY80VxUk9gOLTy4kQhs9eyni6LFvrv/m6Ugjj5xIuDaZ4HiGoWu+RnOFA+43Zv07zVD6ESb7bZIJbKvCEz6+uOGSPVnmAFHdmDaLlkygcEgLbVSouN/5Fbt6WDUdphSZU/swuvO/jkdjQtm2ZyWPYM5MMzJ5xzzu5TOatNEUcoZJlY5PEBSfSxNOwqNqlhsAivOW4/fBT7inNHOGNtdUoFRPojW2f43rzpfQzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edgCDmWvWTUPNvQknusZvVYf9g5rm/ywalb/PWAyaZg=;
 b=nqlw/LfEb9Six+dSlKE2u2qiXpsvxckxJcCJMVxoghnkh1q+/61L7f3U3uvQq7Im1sVIHrKHKFH5uNU0/CTRvVvDx+rGvIgDhCicj6MYpgBmxuD2sAJuSghwaI+5m3TouWn0ShsgvRW2B+KuRYY1UYQlldULKAzioQ50FPHiw2WN581ZQvZJ/WLWhbNvuLXSW9A4PFziptAaqFz/MZJftJUM+mmBsbd8TdEPWesN7IHA3EOuWP7SyjdTdi7qFnwy8QsxrYc8Xr0tmGIDrUZrgDK39HYHUzLtlqAMYytr4fLIHx/DAyp7PVJXGaHGYtAPSsp/exgF7LitsJJwt6BrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edgCDmWvWTUPNvQknusZvVYf9g5rm/ywalb/PWAyaZg=;
 b=bbZns1RgqdcEoHWjU+fCG0u8XihgQXx9X69nAbl7LBgwgdcUmH7f4fasxexLsVAqWXm86BJbgzKuCJmZ3MNOR645mg1NxMDOYH0d3AlETTHoltznistD+i88fc2YslCEe4k+ALwRkYpMjWiSe8MhT85CVVbepS/aF9KnkaHEheg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 03:44:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 03:44:30 +0000
Date: Mon, 3 Nov 2025 12:44:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
        bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
Message-ID: <aQgkzTLZqojS1tbq@harry>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz>
 <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
 <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
 <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
X-ClientProxiedBy: SEWP216CA0006.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: b9842b8b-19b1-442d-71d3-08de1a8b4b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZoZktYTlNQemNDSTFmY0FXM2hUK2g3WFpEQ1NaWEVab3JEUStDV1pGZUlU?=
 =?utf-8?B?TDJtcEUzbnpWM1JwZTY2ZndYUHJ3bStMN2djNUZkMGxnenpxTUR6MTkxY25T?=
 =?utf-8?B?eUtPb2tPbXpmdVFFZ3VaZjR2RDNFOERVcXVXQnlZWnVtbEduSzg3b05RVyty?=
 =?utf-8?B?V3NBSUJCN1R5UzFBTjA0amk4SGpvU3FueUVBVVB3WDdRazRpYTFKaW5zODBQ?=
 =?utf-8?B?TkZOQkx6eUhFNE5oNVJiQmNrN1dncEJPUkZtbmxOSGhZN2krRjNUK2UxNHN5?=
 =?utf-8?B?NDRFSkdmSnl0b1lHd3UxMXJZd3ZlRk9CN3Nxb1Q1Y01hTnJnVTJYN244bmRT?=
 =?utf-8?B?Tk9yN1IrejVTMFBkNXNjUWpGWHo2eE42U3NHa1lBRHZOeFJUbkdBVERXZWlC?=
 =?utf-8?B?c0VBSXU2YzE4eVhIbVFRbUlEcmZGSTNBT1NsSjJjdkNtS1llakNMWDdsQmpz?=
 =?utf-8?B?U3N1RjVsMzRVaFNCanZJWG05MVl0VnZtVVdyWUxYTkN4alpQUnAwRW1Remds?=
 =?utf-8?B?c1B3UjA4R3g0bjRCak1nVUg4bzd0VWlpdlV3eThvWnV0dlA5K0tteEZ3eEtE?=
 =?utf-8?B?SzY1V252SXo3dVc3OHFDb0FaSDJ3QVBOZ2srWjh0TmF6aTIvbDRRZmo1WTly?=
 =?utf-8?B?a2lBNWZCNVE2OFlERHBRM2lJaFRPLzhUMW5NMTJnRFpXK0ZlR1VBZVVhZER0?=
 =?utf-8?B?b0RXSGpJVWpUODRQTE9PTFlDV0xQRW1uWFVEaUNLTnRoanMxeVFybWYxajU1?=
 =?utf-8?B?R1FHNTd1MnFwT3ptalBiYWRjRi9DSFRLd3pDaTNnNkdlTHE4eHNFNWsvZ1di?=
 =?utf-8?B?SnV0ZVc0YXBzWm1ObTdpYVZobElrYUR2b0ZrMnlxbVlNYTNhaHRoNmpsNlp4?=
 =?utf-8?B?N0tQUms4WjFNaVh3M0ZkTktNLzBBcUNPOGROTjhQaXRFaWdnWDNyYlRmQTR6?=
 =?utf-8?B?MTk0Q3h4R3I3ODFLbElHMXh5M0ZmS3RzUWJab0FSSGhicEYxMHo1WE1mNnRs?=
 =?utf-8?B?QVRLNWZmSm8rZlk4SDVrd0Y2MnpTc1lhNXdNTXNWZ2hWcmxUb3FOd0lhSW5D?=
 =?utf-8?B?ZXV6bGYvQmFMYUpqN0JXeHVDM2VqMkdubzBJVnFYNDloRE1oT0xGTGJjWmVT?=
 =?utf-8?B?NncrKy94SFRPQk5IbUN3c0J4RU1JUGk5bjNMUkJESjZYR1pGN3lTb3EzcUNp?=
 =?utf-8?B?ZmxacVE2d0pvTGRqMHhuamNmOU1vY09IK3F3c2Q0cC91RENqWmhxc2UxbGY4?=
 =?utf-8?B?Y1cvaEg0Vm0yZVBqMitBK0RJdVM5RjRkUkNHRnljdGg4U0ZVODRRcENJSXAw?=
 =?utf-8?B?eTIzU05FMGp4SE9HSUl6UU5DbmY0c0h1T0luOVFSd0dDbTA2VEIxYUFMYXZy?=
 =?utf-8?B?ZHZuaVBCaE02UDBkb3p5QkRDbUcrTlVHeW9QMHJkSHNHWmt6a3IxY0xCamRM?=
 =?utf-8?B?ZW9ncWNYR3lMeHNPKzhTdXpjOTl3WTFDRXY4YXV5MWtVNXJYRmFDVGF2Y2NS?=
 =?utf-8?B?c2xEeFlzNWl6N09mdlowUGlzUXBzNndWVUNiVkN6d1BRa2NiK1ZqeDFNWUtI?=
 =?utf-8?B?MkdHbklreHNrZGxOTmk0R1NidUJBb0FRZWJqVDY5T2Eva1ZQa01adFhRc3BT?=
 =?utf-8?B?V29GUktVZ0o0TW5FZnlDNEFsTmFGdDdydkt4bEJEWFQ4ZDQvc1VmZzRkRmRX?=
 =?utf-8?B?ZEpxZStxQlVzUk52dENYSytiZThjUlVtcFF0cVNpVXI0TjVOaEsyZUVYMmRK?=
 =?utf-8?B?RDhSZ29mVFNDRDZna2xyMVFPRUlEMHROMWtGWkp3TGFHMnVGNUxUQm5FdWRk?=
 =?utf-8?B?UEgyZXhxRVE5aTNFSmkyUmJNZlBWQWNxdmtvVG5MNmtURjNMQThHTW0wWVdR?=
 =?utf-8?B?eWIybkJzNXl2aFBETGJwTTB3dVh5VVpoRkpmenVVVkcwMkFVOTBZdmFGQmZF?=
 =?utf-8?Q?Wt4WWFXg+d8RhFFUsI+zWa7RPLk9u33v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjl3anpxbHdrTXk3VjREeUEvKytWQlF5M1Q4cEF4TWtTeG80TmJKR3U1NWNs?=
 =?utf-8?B?emk4VVNXYkdGQjl2eG5KWTFlQW1ubjNST2FiS3NoWUdhN0hLendvS0lSZm13?=
 =?utf-8?B?QVhyUXUvdXJHQjZ5WXZ4R3FUNFo1a2FVcGtGd3pQTjdBWmVuWHFzUGp3ZnF0?=
 =?utf-8?B?TkZUOTZUTGVYTVEwT2Q4eWdSdWhPWUtrOXpSTDJSc3hPTlVUZlE0QmJBRUFI?=
 =?utf-8?B?WklHazFmSmtaZXkyc082dUtESlFxV1pmeUhoNVBDdEtES2dCNlBySWw4TU9q?=
 =?utf-8?B?TDAwUzhGUHJidXhPRGZZckF6RjlKQysxUEhqUzhnd2o3MFlULzk4djhBb2J0?=
 =?utf-8?B?dXRzSVBkemsvRldRZHdMTnYzSkEwUllRc0d4VUt3N3luMUdIMzhVRzJWQk5L?=
 =?utf-8?B?TUhUU2wxOHRoUjVrb1M1OWg2SDBwUHV2cVVqclVXb2ZEa2pwY0w4TlViMkY3?=
 =?utf-8?B?WFFaWWcvWEljTG1taUNsajA1b0hsUVhXZURpeFVDVzJBRmRZd092R0VjYnZL?=
 =?utf-8?B?UGthWHBYT1Q5SnUvaEc5RTlLT09jMkMyM3VJc3ArdVgxUy9BZkk2dGZPdlhO?=
 =?utf-8?B?OU5BcUp0cDRNM2N4a0VYUVFMWEgvdS9ZbFFJZlhxajBUTjFhVFFaTloreHJW?=
 =?utf-8?B?ZXl5VUFNVUkzK3QyTDdvWTlpN2lhV3I2OTAzSUMybTlHK2N1TGVYejhXSzVi?=
 =?utf-8?B?Y0FvZEswV29HcHU1bU12Y1FYa1BBM29BVGFralRwR2NVRjd0amFoMFArNWIv?=
 =?utf-8?B?YnNRUmNhOEw3L2FqdUFQMy9vTFB0U1lXMlFBSllsWDB5SHJ6QU94T1ZuY1Q2?=
 =?utf-8?B?cXYySTl4YTBodUx1djNoWGRjZ3p5V3hBVHQxaGJTQy9Jd3RnMGcvYVRCS2pa?=
 =?utf-8?B?ZUlsWkxHb2hERmdrY1VzRW51ZmExZ1BKVmhST2ZsQWRUZ05HNVhwWW5vdnNU?=
 =?utf-8?B?eUYrYzNQazVnc0ttSlhTV0NSVWFQRHdJYnRpRWMrSHZBTytlbmF1aGtsQURz?=
 =?utf-8?B?SUlXT1J6T0pnTmVxV1NhU2pQcGs2Y2sxcmV1VFJQQitJeHBuRHJMbFdDYnY4?=
 =?utf-8?B?MjhDZmp3akpHWWpYMU5EWDJqdVNmOTRYS2lyRitmek9iMkNrWWMwNUJxMDJY?=
 =?utf-8?B?NDJ4TzVpU21GbEQzQ3NuVVJrenJubk9RTWkvVERvYzE2YkhYZHlNMk1UcWlI?=
 =?utf-8?B?bVc3V24xbmF5SlU3d1lsc2lvTnpUdTFrODRUWko2NVBkTkl4SnFpZzBaVnQw?=
 =?utf-8?B?dW0zNW56VjBNUCt6Vk94TzY4ZGsvZlY2RllITWduM21vOWVSYk1kbFFPL0dR?=
 =?utf-8?B?elZJK1hWVHJSdmV6bUdQOUhJcXJxQUZvekwrYzN6eVF0a0prZ3ZreVA0SFNq?=
 =?utf-8?B?eWRyb2J4bVUyOUN3T1V1WEk2SHo5OEhxR1J4N05Ydk56cmI2VGRSRUc3QXhh?=
 =?utf-8?B?aiszUUt5allEeWRTb05OK2kyWmhPeFNraGwrUDUyRngxRTBDYnBDNVFnRXZB?=
 =?utf-8?B?UmlucEp5amtqTU10N3ZFdjB4UmtzVW5hWFVwdmhTWi9EUWowRmtTSGhkQkYw?=
 =?utf-8?B?cTRNNkVQQi9jM3kxTmpvcW9hM1RzTE5lZE9Ba0VIMkt4bVU4MFhnNzZmWTd0?=
 =?utf-8?B?NVo0TUY1WEhUZmhra29PR1pyRVpES2pJOXBiMkRkZzJwWHhJVjZKRjU0NCt0?=
 =?utf-8?B?Q0k0bjk2cW1rMnFMbWdrbTdvRnFOcUtzRkZYVXdsUHpHRzZjeVA5aVpXMG92?=
 =?utf-8?B?UTRoL1l1eTh2MkZkRDFTc2dHL0FzeFY2NSsvcW82d0szRXJaSkhEanNNeUw3?=
 =?utf-8?B?ZlpyaEw2UnBtYjJaZ2l0cWIySFpIK2tnS1l1bXpBKzVtNXFjb3B2KzVHeldI?=
 =?utf-8?B?ZUNKYzZycEVHTHdzamdXNEZuaVNJRUpRcHRaNll5dHlDVFRMbUZrQll0aXV2?=
 =?utf-8?B?VEVKYWdoNnNNVnp6UEg1YVhVdnpMODZSR29iRVgxV0lwanBZKy8wd2c4bWto?=
 =?utf-8?B?aVJ4QUpzdTJhbFBWWjVSeWJ1SUhaSXRob3lab3Mwd2pBcFF6ME1Pcm5xSXpl?=
 =?utf-8?B?NzhJNWxRV0R1eWxxOFZqQ0g1bjd4NzhtbHZYTjlMQ3RSSzl0MWZmQVZRRDMz?=
 =?utf-8?B?U1dRSFU1TFlMdE5ZTTNLbktnUTZQZXkzVCtLemVBNWJHeHU4VmZxbXg0RGZD?=
 =?utf-8?Q?M2w+yZnJSi/666M+Cu2KxyHiF6/Z4YbkW6/egCAk/HZa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W5QGABo+nWlvJyF1XSVXw895quU5nppMwhLpbWljXFb0Do4bX8sdZk3K22H10Ru5QKCHqkJOPJQtSJDMU6G7HFVLsMh/I4AmmQLHZ4COzbaC8W2LcLpePtsy/z1bQjxO70oDmtLyy5RdYElqk4hLMiyF2Hj1FkgQa0874f3veS9NwdUSzMn0rD4ho2I2vRbvg9WVFOhfa+zByHaKFPCzI/7uSddqjK92kknP6F/fSTIIOf5m07sL55ImsZE+FzBsHHCgqVir3kzFm5gwuY0oz46FiFgBGV8MwFxsOhFEVoxVTpbidm/QVsVYuCFhaf4R7GbwEE701MOlAwnQnA4MKl/HrG8iJChghQ+yVqZAudQ2pPDCbgD9SVx+4TlPe544h6JJmQj35BsCAcOOb+aUFOfdg8pYAWThN5C1pQ/AuWaToXcCUE8J5tUQ2etvG7rl9hb9Zo50QWvIjvN5Rq/Xg04i9t+geK6QSjdG69PqOla/kyDAHef1fOwbJHAGXkJYFaNqHpcLWzIk+AKgCYipCq9/+yprI59Px5qNqwlyBm/Ae10r1Xxm8SLDffH0Fi+5RqD+DaecaIWNmDS1m8zycHvLoY9+aYN2csTRkoN449Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9842b8b-19b1-442d-71d3-08de1a8b4b5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:44:30.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6APQFB3RHADPR6kwHb4pbICk/YpgzMnOvul2YgHAea3LO9OmLsFJo0uYqwlfWsvAwy2v/TUFnI/tQoBHVpuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030032
X-Proofpoint-GUID: it3LnOIf2W5WbEPXUR7OFxJOfnhRSmN0
X-Authority-Analysis: v=2.4 cv=BKS+bVQG c=1 sm=1 tr=0 ts=69082523 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dCXvVEcayhHa0GlPrMcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAyNCBTYWx0ZWRfX6qf0p/2VOm+H
 0O3ZAQ1RITpBV/17RDyKmqk+DvHMuu96NAvYb5gIjPn+PVOsWhFO6SZNV7p3iSat2ihfCFD9Eu7
 qzTixrtj59nePSPmD1lJr6M0tl4aKAvUXGkXKSZnBPAZGcXXZiMuUgOLsmSACDYyljWdORREqmo
 8S6gvL716b2Qd2V5hG39/6lLPT2leFvFkdiBeNetLxsIYyGi3YJfixCx4MsSo54xyp5BXtJG3Ow
 siVAJ00ibjMca3Top9AkD1NgE+h5jl/7P2PZ6g8OzmaMfOZe8BuNRJssIgHiX8isEfy8sU0ypn3
 ybFcYGVHQPUjP2nSxjSfrq7F27IsLZWFOUIKwLAQeKcLv3orvbfPpKym4jo2vJBHw5f+ST4Iso2
 Tk2U++UPcwA4fHf7RmZvgwfRzz23Qp9bbJVoFQ0W6HYPz3e5G9Y=
X-Proofpoint-ORIG-GUID: it3LnOIf2W5WbEPXUR7OFxJOfnhRSmN0

On Thu, Oct 30, 2025 at 04:35:52PM +0100, Vlastimil Babka wrote:
> On 10/30/25 16:27, Alexei Starovoitov wrote:
> > On Thu, Oct 30, 2025 at 6:09 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 10/30/25 05:32, Harry Yoo wrote:
> >> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> >> diff --git a/mm/slub.c b/mm/slub.c
> >> >> index e2b052657d11..bd67336e7c1f 100644
> >> >> --- a/mm/slub.c
> >> >> +++ b/mm/slub.c
> >> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >> >>
> >> >>      stat(s, ALLOC_SLAB);
> >> >>
> >> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> >> -            freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
> >> >> -
> >> >> -            if (unlikely(!freelist))
> >> >> -                    goto new_objects;
> >> >> -
> >> >> -            if (s->flags & SLAB_STORE_USER)
> >> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> >> -
> >> >> -            return freelist;
> >> >> -    }
> >> >> -
> >> >> -    /*
> >> >> -     * No other reference to the slab yet so we can
> >> >> -     * muck around with it freely without cmpxchg
> >> >> -     */
> >> >> -    freelist = slab->freelist;
> >> >> -    slab->freelist = NULL;
> >> >> -    slab->inuse = slab->objects;
> >> >> -    slab->frozen = 1;
> >> >> -
> >> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> >> +    freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
> >> >>
> >> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
> >> >> -            /*
> >> >> -             * For !pfmemalloc_match() case we don't load freelist so that
> >> >> -             * we don't make further mismatched allocations easier.
> >> >> -             */
> >> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist));
> >> >> -            return freelist;
> >> >> -    }
> >> >> +    if (unlikely(!freelist))
> >> >> +            goto new_objects;
> >> >
> >> > We may end up in an endless loop in !allow_spin case?
> >> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> >> > held in the process context on the same CPU)
> >> >
> >> > Allocate a new slab, but somebody is holding n->list_lock, so trylock fails,
> >> > free the slab, goto new_objects, and repeat.
> >>
> >> Ugh, yeah. However, AFAICS this possibility already exists prior to this
> >> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we should fix
> >> it in 6.18 then.

Oops, right ;)

> >> How? Grab the single object and defer deactivation of the slab minus one
> >> object? Would work except for kmem_cache_debug(s) we open again a race for
> >> inconsistency check failure, and we have to undo the simple slab freeing fix
> >>  and handle the accounting issue differently again.

> >> Fail the allocation for the debug case to avoid the consistency check
> >> issues? Would it be acceptable for kmalloc_nolock() users?

I think this should work (and is simple)!

> > You mean something like:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a8fcc7e6f25a..e9a8b75f31d7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
> > *s, gfp_t gfpflags, int node,
> >         if (kmem_cache_debug(s)) {
> >                 freelist = alloc_single_from_new_slab(s, slab,
> > orig_size, gfpflags);
> > 
> > -               if (unlikely(!freelist))
> > +               if (unlikely(!freelist)) {
> > +                       if (!allow_spin)
> > +                               return NULL;
> >                         goto new_objects;
> > +               }
> > 
> > or I misunderstood the issue?
> 
> Yeah that would be the easiest solution, if you can accept the occasional
> allocation failures.

Looks good to me.

-- 
Cheers,
Harry / Hyeonggon

