Return-Path: <bpf+bounces-40828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2E98F0EB
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E490281FCC
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97B19E7EF;
	Thu,  3 Oct 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5mftppK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ru0ns6+Z"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EE19CC3D;
	Thu,  3 Oct 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964000; cv=fail; b=u9qjbMXQzf9LBE+wEYlqlBoIBuYosjyPKPYYImrvwHxHYMNVv9QG1xUQGF9ad3/Hqa+8PX78V1xFyCXDlgpvZm2Ojv4iJ/wzduY7oRWQuNcKvguxHmABNsRQ0slOwgURDsyyY2sd3gRd35TpnUby4RWfbudUX+Qqp/La5JF1pis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964000; c=relaxed/simple;
	bh=5WxxZ72tZVJRRmanR0VddzVBZSQ61hneOZTOj6wqeNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sfTBanNLydYAobl4DlDWGiaw7MK4Avwuo42anhV5SdLEU0j4Lt9OjFSMDY0sqxoZCPoJ/WlxnkWhkxQqh7PfOVPpMH1abDROJcE1QtxI+pm5txENRB3NmYgyvR/tQcdwYyeVsju1i8yOhZcfaYxw5ovWXSe7dPD6M7cD3ecx49k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5mftppK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ru0ns6+Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493DxAjn027990;
	Thu, 3 Oct 2024 13:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qdWEqlqYIWbd2N7mLQlrCgGIAZnWGw8HJUdWt4kZakE=; b=
	D5mftppKqoT0viBNEJ/KTV49n2znjw/3rF7NXiU3M6QTPSB/xMYbRUxyL38PYTeu
	u9tSa607KWEumS6joeP3waTLIiEjyQ5fYPW0O47QXV1qYj0/mJ2dmSqI7D3p66By
	g4YmQKMThbDPK3SpcMMaUCgvDyhNQp7HdXqGCqhh81D3IlrAqlHMOQXgVanpz46V
	nX3n+6FdmHPa9JFFDOxx+aKIThWi2P86of4dCCMOpC5go26/VsFe12dLrUGpX+hK
	dfTjJWPalQffWNar0eknry5lf+q6dk4cRt701j7RcGNYObX1cOP9VGMU1Qt/VbNp
	jqpgcxSyvI1E4+2TrN2Mfw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt49f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:59:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493CPKrx026328;
	Thu, 3 Oct 2024 13:59:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88aahm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 13:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efQM0Yzp+smaEKLvq+kc1EcRPfJeKGDAjKZ2AvfJXHc4h/9I9bdTFwXFVS7Txk+YQcEtT8yeRlOcm7Hw6GzMfYJ9kvLnlZvkFcAvSU7OC26GJMKmV/MiuFYWk8xUN2yrA+W/9iD9/9dzBpXADUrZA4IHvAvpD+VZvHdXEwpcGvRSN+EHQHpQC7E7Bk1RH/vS48it+CDp8V/8l2VusW2RHzUtEHn6XdG+GF7HgYnrnKXserZUMBLQVs5in65lsqVUBO5LKCZ1F2b6ojPT57LobVk2sLTQEwbW2ZBLeDStHW+bJcuCYBnsU7YrmJLe8s2rVKuXoZ/xjjHpDyKt4nGoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdWEqlqYIWbd2N7mLQlrCgGIAZnWGw8HJUdWt4kZakE=;
 b=malV1ssSXLaNa9RVv/Oh7bSYjMcj0VeO08OikcwjFxg4OGNbCYI8X13uEYpUHuWfp4pt1OMohsDorMp4zU8RJkXmb+vVh3hbWkmgf3E1EZ1ilUU2edTn/Cd0oMERiOSjF6sBDKTCoDhmo9FAXXKbBkbhNP9U6hLL28AcXUo2W56yYefbyroh3HMWWNcQ5yWYhRI09NedfcnT5tf/g20a9FZLeEVOuyN+yDeT7QD4lepIQ3ZISBNLoWr2pS0wPBpiiQPWARhFryS0LJgCZ9HLmyql7Ayk3inL6p/b0EvjzmNCffhvyI7SRdL06GyFLJbTN3kFCd+PaNVL1eSZXbY8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdWEqlqYIWbd2N7mLQlrCgGIAZnWGw8HJUdWt4kZakE=;
 b=ru0ns6+ZZ5RmKWaEVUkLc8INUgicl5KDK5ap4YbzE6FwQvUbPfk0apUEAS3SVWE4Armgd6neKFQ0gqBYhwDvE+H4muh5t62Ay4FggYZUGGeqFOb2GKenDTVuVgP/zW/TZ7NjGWRiBrRB9h6lJU7JkghI76Jrv3sUf8/Gk/Bwtgw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB6722.namprd10.prod.outlook.com (2603:10b6:208:440::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 13:59:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 13:59:49 +0000
Message-ID: <00b14c22-a920-43bb-adea-98759db17d04@oracle.com>
Date: Thu, 3 Oct 2024 14:59:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 2/5] btf_encoder: stop indexing symbols for
 VARs
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-3-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241002235253.487251-3-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9f48c8-32ae-4142-ce24-08dce3b3a59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHlybFRSa3lqR01GYWljNit3QzNvY3pGNnVZSCtkVWQ5MGluSEoyS1lrdzAx?=
 =?utf-8?B?b0ExQUZtYWIxcGtMYy93R0Y0dUlWcTFqNFZaY1g4ZVRKbWw3UXM4ODQwa1E4?=
 =?utf-8?B?ZHZQN0JYd1hvWlFEbFlienRFTGFBWjdrSVM1YXk1NTRvcy9sUkkyN1Nucm0w?=
 =?utf-8?B?dnVBUktiWVoyam8wM1l3S3NRMXF2bUN2cnJKU1p0Z0NTTUs0TW5vN3k3Yndo?=
 =?utf-8?B?YmtnZXpBRFFXUDY2MWRBajhCQmpnQ3FGV25PTTZHSHpRdkJXS0RvTFBWVGZK?=
 =?utf-8?B?YllabklkV1ZkaWpKcG9PSDVJdE1RM0FPU1pnWXM5SVBIMXNBdUdWUzZ2TGZm?=
 =?utf-8?B?cDVLYzE3cnVUOC9obnJrQkl3Q0dYN0JIKzgvckQ2a2RDSWZXWVZvSXJSZjhS?=
 =?utf-8?B?VTRIUGpPb0xRWEp0VzNJUFhIN1pGRlFIL0FXbk0rbEh6eTRERktyZGJsWElu?=
 =?utf-8?B?b3VNUXNHRTMrMHVFWkQ1RjRNamZsS1p2UlVTRjVlV254Sk02REVxdGVjaGpp?=
 =?utf-8?B?NytQdnVRb0JWdEdGU1pHWWpIZzdqNjE5R2U5WGEwWTRacWdDcEF3L3E1dUFV?=
 =?utf-8?B?MmJtdHNXL2hrRGF1UHhLaGliYnVvNHZic1hIeXhtVnF1MmlWdFc1cTVzdFFR?=
 =?utf-8?B?QmpvUUN1RXY1NlV4alZZN2w1aGQ2dnd5OXFvMHduQ0l2TTJyK3VqNUdNYksz?=
 =?utf-8?B?UkJiTmMxakdHNUovVFY5MjNybDJTQSt3dG56L3RzQlZDR096dG1jZnRkalRl?=
 =?utf-8?B?M3B3RnF3SVVxa2R3aFdvSlJuYWkyUlY1ZGlxZ2F6RS9vQUppT1ovWDQ3ZlBq?=
 =?utf-8?B?MHQxajQzRG11YnpmTDVlR2ZsQ2QzRm55RlpMcmxhNWVBRS9WaHZyV1Q1THZo?=
 =?utf-8?B?RDFjRHZIN1NrYXVGSlpPcStsSW1qWGt0dmN1MTY5NXpRb3NtZStoeEpDempV?=
 =?utf-8?B?dlpOYy9RZ2tSN1F5LzMrczU2RUFMRDZHSkFWTFNQeFVndC9waENMQmxwTXpm?=
 =?utf-8?B?TXhZa0RVc0EvdGo3R2c4OHpCQjlYdmkyWVYyOUxnWjhRNVZXTkZVOE1DWjJ6?=
 =?utf-8?B?SVc4ZVBYa3pvdWI1ZHdvUzNuM3ZvUEIvYTRRd2pYcVIxSU85RE1ERkg5YUZl?=
 =?utf-8?B?QzlSdmZqcDBQTEVtYlY5VkJGY3IzL1BCVjdDSTYrU2Q4b1FmRmdwV2RocTRR?=
 =?utf-8?B?ZzYrUVBsL2I2ZEY2bW83TlY3UWZCT0hGTnYvc21QVDJWcDNYV2dIWHR2M1VW?=
 =?utf-8?B?d25wMkpQbHdmZFBiKzE2NmpNOG94dnFBVC95c3NQMllZTXF6enk1bVNJQmZL?=
 =?utf-8?B?ZCttSWdnbzNJR2orWWhIalRMZDVpdGNjTXpLZFNmTSt1dkxqa3V3NUYycFdj?=
 =?utf-8?B?RkZSMkJXbWZQbXJ2WktpQU9ENVA1OG9rZGgwVTBkYXQyOS9PWGFSYkJ3THE2?=
 =?utf-8?B?V0FCU1FLY2tVYm9JZGRyeCs0Rm9BSDZ3dHJGTlArL3d3TUh2Q0U2NjZReTEr?=
 =?utf-8?B?dWY1WXRQaStrSXJIQW5NSVRVc3c2c2xVZC9ibWFTNVY2aWl3RVc5YTYvaEV0?=
 =?utf-8?B?NVNzdUlla3ppbFUrOUp0b2hYRWtrSDMzUXk5WnNRK3hxZ3lUbHAvTDRCakJi?=
 =?utf-8?B?QTluUUIyaXNEYlVZNlN6QWtUbFpkOGZpMFNCZzljKzNTMUhFZGtZaEs2Witv?=
 =?utf-8?B?ZFhISGpIbGQ4amMrNFJEQWFNcEhRaUNUeU9WS2dVNEdEWG1JMkVnN1lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlZDYmkzc0Uwei94Y0Uwalo5MlY3Vk9LQ2ZZM2dFZW52UE1nZUJVT0o2V1BY?=
 =?utf-8?B?OTlMYzNURE84VUVLTTI4RHo3SEYvMVRpVCswc1A5SFJ1ZnhnYjgwd2R1RXli?=
 =?utf-8?B?THJIaXVmNFdPS0hDeTladzhuTjdLanRBUk9rMjRtdDlNczI0U3IwbEZab0Fi?=
 =?utf-8?B?M3BMQ1NLWGVOWUNDbmsxc1FnajZqSE5tSTZSdldjaXdFeXZ4VVMxc3Z1OFpJ?=
 =?utf-8?B?LzJFZTZKYUoxdWo2Wlh0V1RtTGlzMi9LV1dXRk9kdVVLRG9NcnJuOURRYWhr?=
 =?utf-8?B?MjBhdzZ4WWkzVkdtdFZkeFVOMmNEQTZ5N2lkZkxZWm1MRTIzalNkMG9LNEdK?=
 =?utf-8?B?UXp2WVl6bEdDWjNodTMvVUw3Yno0OTJhSDBjYUNRcklkSFA1Q1BsSUx4N1lk?=
 =?utf-8?B?OXBRUi9WK0NBaW9RaTVsN2xDY2JVVjR5QXZ2bW5UdjlvNFNrU0I4OUlKSnVU?=
 =?utf-8?B?Tkg3TUIwOXdQekpYdW1IT1JSS3IwSlRJUzF6MjhVMzQ5R3h3RW9XdzVHSzN3?=
 =?utf-8?B?aENMT0VCOFI1Um03Nm04LzRxeDFKRmVaMU8waGo0K2VJQWxVYURteHU4R3lU?=
 =?utf-8?B?dTdqZHdYbkp6QkE0elQ4VkxOOUJHSkVuSnc0b3h5QTVZcmVuQThKbVpJcDdW?=
 =?utf-8?B?cXNqdnhmNjdxRDRQWnI2eGQ1RHZZdzRVRk1McFB2Q1ZsRTJzRVRWK2lrM0Fa?=
 =?utf-8?B?bmk2ZEp4dkV5dzZoSVAxMU1KdGtUYkxWcUtBUjJZellqQmlxcmVUa3Btb1Q3?=
 =?utf-8?B?eXBNVTlwbjlZU3pUMGcycFV3amZFTGVYWWdncGZrSEhadG9DdmdPLy96dHB1?=
 =?utf-8?B?ZHEvMytPNGx3Y1pYS0Z0bEkvNFJWM0FRenpla2lLcllmNWNva3lROUJCckRl?=
 =?utf-8?B?SEpEYmNrT3lmUW9TaWd4ZE9FNnFzZEVNYXRHaFMvYlRwemJ4ZmRqUHQra2lE?=
 =?utf-8?B?UDlKcVQwUVpGNmNaQytEMVNxMktnME54WTB3blV1MGdBRHkzbDBQVnNRR0dv?=
 =?utf-8?B?UmNIUjUvbEZIQlJXZSt1M3VGckIxYWlHV0NRb1ByNkNBVFY1QmQ3b3B2aTQy?=
 =?utf-8?B?TXR2OUtrUko5bmFVaTkzdXpyaU1vc1ZjZWpnVzE2MHdiMjN1MHRGVlFiWXFx?=
 =?utf-8?B?dkNPSzFwSUVIRk92S01NMEI2R0s5TzdjY25xdlNkdmNvMmFHNGZzd3ZBajZY?=
 =?utf-8?B?V09jYi95ZklHZ0hFWDRGZTkzTXdqSndxUk9iaWFDdEh3ZjVCTDZnUTBUWVlB?=
 =?utf-8?B?ZEU3ZEFHTzdhOW0yTnJrS2w0Z1VwUUExTVhYSmRVK2IrRGsxK3NsV1BvWHh0?=
 =?utf-8?B?VTMyVFRlckd6WnBqMHVRekZGdVZmY01PWHFSaXQwRTUrNFN4Mk5zZFFqamVI?=
 =?utf-8?B?bTZnMU5TZDJ5Tk5rZGZSek5NZ0RIdFZmWTIrREZnWEs2TE54aFl5bTM4K0dq?=
 =?utf-8?B?czVPRXNVTFJWWmJHQ2xOUDlDVkNMbXdZTm14VExyRGovd1h0Wmg0OFJWOEFQ?=
 =?utf-8?B?ZklHNXh4ZnNQUTFpVkd0cEtPRHFpOWdmenE1ZVpVOVFzOElqQ0ZJckh0Rk92?=
 =?utf-8?B?bFJ2QjA4bXp4SGVuRkt0aWdsOFUvaTF1SHBDYncxY2lMMjR2R3hpVktLY25H?=
 =?utf-8?B?WG1wR1Rvb0IxUlJzSVk2T2xCM1g3MGFwQVZCWmVIZTd6eGsrTWFqMUd6cUFh?=
 =?utf-8?B?N1R2Wk9PbzcrQnNvQlJEdm4zTWpzVHhhRkpFb0VTUWtzSkJSRlJzYnFSRjBt?=
 =?utf-8?B?aUkzeWxNWVV3c3gxYy9UZXJJTzBKRmgzYTZGMTJ5eWRyVkNTTHZLTkZKa3A5?=
 =?utf-8?B?cG93M3l5NWd3L0U3MUMvTUx2bVlMVkxNRm9mVkdWZFJKVGdmWmZkZGdocGtu?=
 =?utf-8?B?T1JHN1RidTc0MWFLZTNHbHFIcFZic2ZkM2tnenhGdDNuUXJpdHF5eWNrQWJo?=
 =?utf-8?B?TEk0U3F0ODdiOUJ3VE5zTDFXdVBLRjNHQjRCajNJR1J4NGlEU1daSGNIc2Qw?=
 =?utf-8?B?MXVrRnpWMEFwTnNGa0JDSXVXaTF3ZXFTZWV3a2NOa3hycmhHVTUxWnVORklz?=
 =?utf-8?B?aGpoUnpqdW01amNiWGc2aEtoc1p3bUdVLzdmQnpmTUk3aVJEeGM1U3NiZnF0?=
 =?utf-8?B?bFkyNU9GcWpBZ3B4ZEkwKzBjYzJNWFlaMjIrM1ZSRU9VK3lYOW1mcHU1TkpE?=
 =?utf-8?Q?tfW5S4oNz0NaTXzGrdzhlFE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rQrvkwAMqScBW7eqD38VsPo04OcIK+/hYi0Z6FvyWTubzdFSZNSmx8dSM6WELhZYfU0Xx/xnXCSHubwVckzkm1p/bkIxAZtDi3a2x03CrisXO7ziH612J5j3DRzLrjidTrtg/KBvHrL+rp4Mwqxaf5R36Aj1dkRYoTTGOGX+eSu9F/uhPFNI8rpP47UZABkvOkQlLtvlgmGXbW8AydX0nsRq0dp9hFMDaiSyu+Kzg3LGJrE5PWfeNHVo93mWMGc+CVpPtOjZXPzs44nfQOEldeC8/15pTR9B41DikaQzuE7pqBNbynWG3moRwa85kJDSr2QRJrB9xCf8CPhEAiWhD3mgS3jyvjLkTYqQSBxAFFR38JZwk1IDfzc39m8MucQYxqDJQySIJSXaYpyy/ryIpSW8u4xPeaLwiA4AYkkP3TjeJcQkxgY+1a3F42Vp6U5QjMdaPOkqDdoAT5XcRr2cbT7Rr7j0j0+CvL8xlRk214ldbYhzyRNm+/766/EJBdrrD/yfxe35uaTW/J7KfCmcx6Ws1Hj37pmkUdJepuhpokNIdcmgxDx6oRH6hc+LhUvLrj5hCgEu1SoMVOQO9DU0LjjeVPSUx911UbRbeHGMBV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9f48c8-32ae-4142-ce24-08dce3b3a59b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:59:49.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFp0L1B0EW6eCxmkX+xUgEdRkKZD0JD1UBTylkIfISzlv2gHIQl6sxrVv5L23/zTrrR1ulI/dQ5XSvY/0GGMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030101
X-Proofpoint-GUID: Lmag934sJ-bynrI2lKPgS6Dm8aBF3S1X
X-Proofpoint-ORIG-GUID: Lmag934sJ-bynrI2lKPgS6Dm8aBF3S1X

On 03/10/2024 00:52, Stephen Brennan wrote:
> Currently we index symbols from the percpu ELF section, and when
> processing DWARF variables for inclusion, we check whether the variable
> matches an existing symbol. The matched symbol is used for three
> purposes:
> 
> 1. When no symbol of the same address is found, the variable is skipped.
>    This can occur because the symbol name was an invalid BTF
>    identifier, and so it did not get indexed. Or more commonly, it can
>    be because the variable is not stored in the per-cpu section, and
>    thus was not indexed.
> 2. If the symbol offset is 0, then we compare the DWARF variable's name
>    against the symbol name to filter out "special" DWARF variables.
> 3. We use the symbol size in the DATASEC entry for the variable.
> 
> For 1, we don't need the symbol table: we can simply check the DWARF
> variable name directly, and we can use the variable address to determine
> the ELF section it is contained in. For 3, we also don't need the symbol
> table: we can use the variable's size information from DWARF. Issue 2 is
> more complicated, but thanks to the addition of the "artificial" and
> "top_level" flags, many of the "special" DWARF variables can be directly
> filtered out, and the few remaining problematic variables can be
> filtered by name from a kernel-specific list of patterns.
> 
> This allows the symbol table index to be removed. The benefit of
> removing this index is twofold. First, handling variable addresses is
> simplified, since we don't need to know whether the file is ET_REL.
> Second, this will make it easier to output variables that aren't just
> percpu, since we won't need to index variables from all ELF sections.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

a few small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 250 +++++++++++++++++++-------------------------------
>  1 file changed, 96 insertions(+), 154 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 652a945..31a418a 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -93,16 +93,11 @@ struct elf_function {
>  	struct btf_encoder_func_state state;
>  };
>  
> -struct var_info {
> -	uint64_t    addr;
> -	const char *name;
> -	uint32_t    sz;
> -};
> -
>  struct elf_secinfo {
>  	uint64_t    addr;
>  	const char *name;
>  	uint64_t    sz;
> +	uint32_t    type;
>  };
>  
>  /*
> @@ -125,17 +120,11 @@ struct btf_encoder {
>  			  gen_floats,
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
> -			  is_rel,
>  			  gen_distilled_base;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
> -	struct {
> -		struct var_info *vars;
> -		int		var_cnt;
> -		int		allocated;
> -		uint32_t	shndx;
> -	} percpu;
> +	size_t             percpu_shndx;

nit: feels odd to specify the shndx as a size_t ; libelf uses an int as
return value for elf_scnshndx(). Not a big deal tho.

>  	int                encode_vars;
>  	struct {
>  		struct elf_function *entries;
> @@ -2098,111 +2087,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	return err;
>  }
>  
> -static int percpu_var_cmp(const void *_a, const void *_b)
> -{
> -	const struct var_info *a = _a;
> -	const struct var_info *b = _b;
> -
> -	if (a->addr == b->addr)
> -		return 0;
> -	return a->addr < b->addr ? -1 : 1;
> -}
> -
> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
> -{
> -	struct var_info key = { .addr = addr };
> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -	if (!p)
> -		return false;
> -
> -	*sz = p->sz;
> -	*name = p->name;
> -	return true;
> -}
> -
> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
> -{
> -	const char *sym_name;
> -	uint64_t addr;
> -	uint32_t size;
> -
> -	/* compare a symbol's shndx to determine if it's a percpu variable */
> -	if (sym_sec_idx != encoder->percpu.shndx)
> -		return 0;
> -	if (elf_sym__type(sym) != STT_OBJECT)
> -		return 0;
> -
> -	addr = elf_sym__value(sym);
> -
> -	size = elf_sym__size(sym);
> -	if (!size)
> -		return 0; /* ignore zero-sized symbols */
> -
> -	sym_name = elf_sym__name(sym, encoder->symtab);
> -	if (!btf_name_valid(sym_name)) {
> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> -				    sym_name, encoder->verbose, encoder->force);
> -		if (encoder->force)
> -			return 0;
> -		return -1;
> -	}
> -
> -	if (encoder->verbose)
> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
> -
> -	/* Make sure addr is section-relative. For kernel modules (which are
> -	 * ET_REL files) this is already the case. For vmlinux (which is an
> -	 * ET_EXEC file) we need to subtract the section address.
> -	 */
> -	if (!encoder->is_rel)
> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
> -
> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
> -		struct var_info *new;
> -
> -		new = reallocarray_grow(encoder->percpu.vars,
> -					&encoder->percpu.allocated,
> -					sizeof(*encoder->percpu.vars));
> -		if (!new) {
> -			fprintf(stderr, "Failed to allocate memory for variables\n");
> -			return -1;
> -		}
> -		encoder->percpu.vars = new;
> -	}
> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
> -	encoder->percpu.var_cnt++;
> -
> -	return 0;
> -}
>  
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>  {
> -	Elf32_Word sym_sec_idx;
> +	uint32_t sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
>  
> -	/* cache variables' addresses, preparing for searching in symtab. */
> -	encoder->percpu.var_cnt = 0;
> -
> -	/* search within symtab for percpu variables */
>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
> -			return -1;
>  		if (btf_encoder__collect_function(encoder, &sym))
>  			return -1;
>  	}
>  
> -	if (collect_percpu_vars) {
> -		if (encoder->percpu.var_cnt)
> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -
> -		if (encoder->verbose)
> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
> -	}
> -
>  	if (encoder->functions.cnt) {
>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>  		      functions_cmp);
> @@ -2224,15 +2120,54 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>  	return true;
>  }
>  
> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
> +{
> +	/* Start at index 1 to ignore initial SHT_NULL section */
> +	for (int i = 1; i < encoder->seccnt; i++)
> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
> +		    encoder->secinfo[i].addr <= addr &&
> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
> +			return i;


nit again: for readability this would benefit from brackets after the
for () loop. because of the number of conditions might also be no harm
to rewrite as

	for (int i = 1; i < encoder->seccnt; i++) {
		/* Variables are only present in PROGBITS or NOBITS (.bss) */
		if (encoder->secinfo[i].type != SHT_PROGBITS &&
		    encoder->secinfo[i].type != SHT_NOBITS)
			continue;

		if (encoder->secinfo[i].addr <= addr &&
		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
			return i;
	}


> +	return -ENOENT;
> +}
> +
> +/*
> + * Filter out variables / symbol names with common prefixes and no useful
> + * values. Prefixes should be added sparingly, and it should be objectively
> + * obvious that they are not useful.
> + */
> +static bool filter_variable_name(const char *name)
> +{
> +	static const struct { char *s; size_t len; } skip[] = {
> +		#define X(str) {str, sizeof(str) - 1}
> +		X("__UNIQUE_ID"),
> +		X("__tpstrtab_"),
> +		X("__exitcall_"),
> +		X("__func_stack_frame_non_standard_")
> +		#undef X
> +	};
> +	int i;
> +
> +	if (*name != '_')
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
>  	uint32_t core_id;
>  	struct tag *pos;
>  	int err = -1;
> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>  
> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
> +	if (encoder->percpu_shndx == 0 || !encoder->symtab)
>  		return 0;
>  
>  	if (encoder->verbose)
> @@ -2240,59 +2175,69 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  
>  	cu__for_each_variable(cu, core_id, pos) {
>  		struct variable *var = tag__variable(pos);
> -		uint32_t size, type, linkage;
> -		const char *name, *dwarf_name;
> +		uint32_t type, linkage;
> +		const char *name;
>  		struct llvm_annotation *annot;
>  		const struct tag *tag;
> +		size_t shndx, size;
>  		uint64_t addr;
>  		int id;
>  
> +		/* Skip incomplete (non-defining) declarations */
>  		if (var->declaration && !var->spec)
>  			continue;
>  
> -		/* percpu variables are allocated in global space */
> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
> +		/*
> +		 * top_level: indicates that the variable is declared at the top
> +		 *   level of the CU, and thus it is globally scoped.
> +		 * artificial: indicates that the variable is a compiler-generated
> +		 *   "fake" variable that doesn't appear in the source.
> +		 * scope: set by pahole to indicate the type of storage the
> +		 *   variable has. GLOBAL indicates it is stored in static
> +		 *   memory (as opposed to a stack variable or register)
> +		 *
> +		 * Some variables are "top_level" but not GLOBAL:
> +		 *   e.g. current_stack_pointer, which is a register variable,
> +		 *   despite having global CU-declarations. We don't want that,
> +		 *   since no code could actually find this variable.
> +		 * Some variables are GLOBAL but not top_level:
> +		 *   e.g. function static variables
> +		 */
> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>  			continue;
>  
>  		/* addr has to be recorded before we follow spec */
>  		addr = var->ip.addr;
> -		dwarf_name = variable__name(var);
>  
> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
> -		 * always contains virtual symbol addresses, so subtract
> -		 * the section address unconditionally.
> -		 */
> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
> +		/* Get the ELF section info for the variable */
> +		shndx = get_elf_section(encoder, addr);
> +		if (shndx != encoder->percpu_shndx)
>  			continue;
> -		addr -= pcpu_scn->addr;
>  
> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
> -			continue; /* not a per-CPU variable */
> +		/* Convert addr to section relative */
> +		addr -= encoder->secinfo[shndx].addr;
>  
> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
> -		 * have addr == 0, which is the same as, say, valid
> -		 * fixed_percpu_data per-CPU variable. To distinguish between
> -		 * them, additionally compare DWARF and ELF symbol names. If
> -		 * DWARF doesn't provide proper name, pessimistically assume
> -		 * bad variable.
> -		 *
> -		 * Examples of such special variables are:
> -		 *
> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
> -		 *
> -		 *  This is relevant only for vmlinux image, as for kernel
> -		 *  modules per-CPU data section has non-zero offset so all
> -		 *  per-CPU symbols have non-zero values.
> -		 */
> -		if (var->ip.addr == 0) {
> -			if (!dwarf_name || strcmp(dwarf_name, name))
> +		/* DWARF specification reference should be followed, because
> +		 * information like the name & type may not be present on var */
> +		if (var->spec)
> +			var = var->spec;
> +
> +		name = variable__name(var);
> +		if (!name)
> +			continue;
> +
> +		/* Check for invalid BTF names */
> +		if (!btf_name_valid(name)) {
> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
> +					    name, encoder->verbose, encoder->force);
> +			if (encoder->force)
>  				continue;
> +			else
> +				return -1;
>  		}
>  
> -		if (var->spec)
> -			var = var->spec;
> +		if (filter_variable_name(name))
> +			continue;
>  
>  		if (var->ip.tag.type == 0) {
>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
> @@ -2304,9 +2249,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		tag = cu__type(cu, var->ip.tag.type);
> -		if (tag__size(tag, cu) == 0) {
> +		size = tag__size(tag, cu);
> +		if (size == 0) {
>  			if (encoder->verbose)
> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
> +				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
>  			continue;
>  		}
>  
> @@ -2388,8 +2334,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> -		encoder->is_rel = ehdr.e_type == ET_REL;
> -
>  		switch (ehdr.e_ident[EI_DATA]) {
>  		case ELFDATA2LSB:
>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
> @@ -2430,15 +2374,16 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>  			encoder->secinfo[shndx].name = secname;
> +			encoder->secinfo[shndx].type = shdr.sh_type;
>  
>  			if (strcmp(secname, PERCPU_SECTION) == 0)
> -				encoder->percpu.shndx = shndx;
> +				encoder->percpu_shndx = shndx;
>  		}
>  
> -		if (!encoder->percpu.shndx && encoder->verbose)
> +		if (!encoder->percpu_shndx && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
> +		if (btf_encoder__collect_symbols(encoder))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2480,9 +2425,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
> -	free(encoder->percpu.vars);
> -	encoder->percpu.vars = NULL;
>  
>  	free(encoder);
>  }


