Return-Path: <bpf+bounces-28276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898328B7E04
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B091C23CD6
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C639A1836EE;
	Tue, 30 Apr 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTUI1cVE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HUpBrz1q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A717F38A
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496251; cv=fail; b=EYCsMifpcojZ0BUHd/RiStCgKxELIJv0nEK08bnMit+aEdZIsE/ymPMHiz79oZxI+PY2Li8OhE73ZvkU027RF8mqXvMrrnsVuWShr2qn+51VfLR+y38lLpKrk86aJcnaUmeQ72lfZZDsvXgaerJwUYe+h01RfKHnd81vxzTHKYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496251; c=relaxed/simple;
	bh=hHnIlQ8ZZVFm4O5gfNuJj3H8QIldaQoC4QZQufy01PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g8U3wjzivICIwL0P4PeJGJfoX998XO0255JYQEeX4n3r5HaQ5yhSC+OdNq1JqZTujeTAA56axqTr9MPvz7sgyaBSvD25erzJKFaTSR5Xybn7zouV1C1jBpD1/XLu4jMrcvefkPH+BG1EjAfJGqPR2lrh+yLvWTZsozBUKezp1dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RTUI1cVE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HUpBrz1q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UGQdCS015801;
	Tue, 30 Apr 2024 16:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vBqpD+zTvbw0xuZx7Dn2FDmYzyazDrqo6OXlTmy/7rI=;
 b=RTUI1cVElFPs2lTVZCf5oBTLQqyitf7ertbvoggDCHySpBqEsxO8ci2Z8b/j0eF6iZV2
 3YXPKLqthpXAvpKe5B8yI3F36rcg/49VSLc7wMjLmUhYS7cJ9HMRVLZJny4GHN1OTGuG
 fGPmBplUmC5ggLc4FSrHdX8+qW/7qlilX/6ODM3iIcsx2lvMhTxvGKHcux9xPLponJhD
 Zf7xFuYBoZCKuD+SC6vkvCORvlGJ9ApPWpXasrgpfxbXN/I+LOFmj8+YOoK2q6O/A9Z7
 sEI631MgYzY+aXLmGbZetsRQ+rw2Jgd/P1Bv4TDEqCxQnQJxQwq7k98i9iJ2deFKknrX zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvnmxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:57:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UG3Z93016695;
	Tue, 30 Apr 2024 16:56:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqte8700-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afXIvLcDj0Emo4lI8DFAhXA8Qs/zKP4xFVx04QyiGe4psoywk41wbgRosUrOs6JAZVWaH+tCCaF4SwbHFp7teUAM845h5dLdzhqpBKelt/CEaCcG4N0l3EYprHqVH1sH7VvQyZcBN1Z5NSiUMxfYMeDryKEV2Sf9ZO4t9UrUsp3ZYPKm6j0VveDvD7BNvHHPx1vNGnSMHFW6dyGcuxhF4mMcxdv0c5jYRdEmpENgknys/x4hgcWiTQg+uc3MiYH/65nyqd1zO20WOthffwLXNnriEtp++MuCih/9MA4IbvA0OYu1gHlbpwBF7A/ByxSlD06lgNBLiFFrHBGpBhwCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBqpD+zTvbw0xuZx7Dn2FDmYzyazDrqo6OXlTmy/7rI=;
 b=n73bUZeTodLMGIlAXTF7MMt6W/pEFiFcLVqc/xSlEKdiyPbMqTWb2CkmeZEtG+WCoOVJex3NBHs5YaD4e2NnSF685FEw0ISW/jwRwGxYinbuRj+yCraaVwdP13elx4jQm9Lc4wEdYMaoFqDgayuTT1jvR+QSPSFicclyxvNnHvm1lvYjmj0N1OHMONJ4wVdujtLbeaNwNH+lcEVEV8XhCJOIyxFMu8yJSVJOo3BJdarPeCEcqnpb3sPb4poH8R4IKCKRHQ+/bmLGcW9evPp2/8sTfVe0Xm1dKtipdxBH8zxkoxzfdDXv1HNH9TAXARX9HkXS7SwfEqcozeSAEACtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBqpD+zTvbw0xuZx7Dn2FDmYzyazDrqo6OXlTmy/7rI=;
 b=HUpBrz1qedGCoQJPw2u3JJpwMfXFlVD9bZ98kH+tz4zLOxcNUnZ04Wj41l//cYG7EzqhJ7HYFQmtbpUaEMNQq97Y3weRYgjOy6mBcUJqvakAgPa+T0nzUEsJKEdOxnqZOFwxbERTIQYDU58JjKb8kPbTf0rDGaq7jpJAjVzGdio=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5604.namprd10.prod.outlook.com (2603:10b6:303:14b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Tue, 30 Apr
 2024 16:56:55 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:56:55 +0000
Message-ID: <8483cbf7-6729-471c-8aa8-f88c9e306fe5@oracle.com>
Date: Tue, 30 Apr 2024 17:56:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 09/13] libbpf: split BTF relocation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-10-alan.maguire@oracle.com>
 <CAEf4BzYr8ONqLuH0q+FFJijx3ADrqn464pf8E4A3s+uJ03cyVQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYr8ONqLuH0q+FFJijx3ADrqn464pf8E4A3s+uJ03cyVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: faf2e0d6-0fc6-4c20-00a6-08dc69368ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eVVGSnB6MW9ZeVRhK3ZHaXVmSTJKTUI3bkNNOWtyNWpPcmtOWUxzN25vNWN6?=
 =?utf-8?B?Mk5WbXQ3Y0VtNE96aEF5TzVyU2JSVU56Umt5K3JjOHpWZHhwSWpiNXBLOHIx?=
 =?utf-8?B?REt3dWs0c0N2dmlvZjJhSGpWM0V6YUw3cUtCckhiNmoyenNNTWdHSE42bHpF?=
 =?utf-8?B?OStSOG0vUVo1TDQ4NnNuSjFpRlpIUFY5QUZ5T2oyWVRWTlVpeDBjZW9hOTFO?=
 =?utf-8?B?ZmJzZjNqZ0pjcnRCUVpjQm9sT0hHQ3dmMlZBTWd5a095SGt3K0g3S290cVV3?=
 =?utf-8?B?bks2aG9GWUdFeEVObXUvUkFNNFpqMitISFNRTDV1WFlvUXgvRm13WW01UHJ4?=
 =?utf-8?B?SUJMbzUzMVBlbDE1OGRCT3JiY3pTT2Y3UUV5bUpqSmRkQ2FhdzQzZFJsdms1?=
 =?utf-8?B?OXFJYUNWK29BaVhYS2I3bjNiRy9uNkhrY3V0MEdPOTVWakVKQVAvVTAyVHRv?=
 =?utf-8?B?cjUvaXF1TnlLWUlpd0krbTA3TmQ5QVd5Nm94V3JsajZMNC9HQmtOS3FkRkRU?=
 =?utf-8?B?amtiM0doa1NlV2wyTGoyUUQzUEhvRVFLZkh2dWo4M1F1YXIwekZLc3ByRkFl?=
 =?utf-8?B?cXNTdUpVK3JyZjJlbSsydjJGckhSSmFFbktyT1l6Smt4STJLdlgxRVVZV2hT?=
 =?utf-8?B?YURSMllUSmt3RkY5WjIzbjcrRGpSTGNCUWlxVEsvd2E1VWF4ekoveXd6aWZz?=
 =?utf-8?B?eFZtWDMwWUIzckY4WEV2azZMNmdJOWhxNlBHc204L1pnWHpQbmdqS28vMVN6?=
 =?utf-8?B?eWNwZEs3ZkhxR3cySnhtajNmL29TMVgzT21xUEtVekJtVWpnekFXZ3J4Z24y?=
 =?utf-8?B?VHJlT0cyalZ3cVkzWXBJK0YyMnRUNzNHWnFLVzZJeGZwY1NDbE04K1ZyOGtG?=
 =?utf-8?B?ZmYwUXhCc1JXVkFvQVBKdG5TUTBYMVdFM0lJUisydWJkSUJ4UHZ5bE94cHpi?=
 =?utf-8?B?ek5BaFk1SnhHZlNkeWU5cmpjSGNjeGw1azN1RFdBcGxzU2xlck9xUE9mN2U1?=
 =?utf-8?B?Zmd1TGZ4NDNtRXpYdlRzVlE4cjBvQzFxMzhOcTlqcExMQUt4UmlPWGp2R0NF?=
 =?utf-8?B?dHNQaW5hMnRuNFo2V2lRbVZybkMwQU1ubmN5Uk1BOWh5RHBZTnlXczZ5RUNB?=
 =?utf-8?B?eEhVeDVtNXNPMG9iM3lHVW8yKzkwcHFCcWdpNkROUCtxTW1weWtNKytjY29E?=
 =?utf-8?B?elBJakRwcEZWd1RaT0RhcW1laURTalMyZ0ZIdUVlSkdjTkhOcERHMUxWVXdm?=
 =?utf-8?B?NWcreVE5N1liN0tZV2p6M3EwT1Y3UTErNjFPVDVBN2VVZkg2eWRXS3VOdHAy?=
 =?utf-8?B?UzJJNUU2Z3c4cW5pSktsT0Z2bE8wc2gvZDgvZU9ZTzZCNnZTZmthWnFXM2pN?=
 =?utf-8?B?eXFEeXZPa2w0emx5d21RM05HZkg1QXBCSHJKd21rak5GZ0hZcW9HeW0rdDVp?=
 =?utf-8?B?aGZHelluNFJrbFNnSG9EaWx3K0FBSTlpYXZqR2twalYraGpvanlWZlZ3Y1B1?=
 =?utf-8?B?RWhsQTNwckVFVFFHM2R0dG10V01SdTduOFJUN25mZkw3ZVBnSjVPZmVxZTVJ?=
 =?utf-8?B?ODhMdzlDMzYvWG02NHYzWTRuYUJkb2tUY0F2Unp1cDhPTng5akZqbzFhOW1R?=
 =?utf-8?B?ZjlUcGduNnNvM2NDNmxOYU9Tb1dLV3FyQ1M5M2U5QXJ4MmJadHhLc0ZrejVK?=
 =?utf-8?B?eVZLOXQ1Vk9Qd0w3MHF6SnYvZUdySHNIMFZsN1NSbG5JYnJMR0xBSU13PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djVyc3ZhWWROK09HV0QyYVNnM1M0aEZMVGxtSkFNNCt1WXdyRmNHK2JXSVhW?=
 =?utf-8?B?dU5iRHhGMDRxS21PZ3d1VDR0MitPRUErZnI5Vm1vRlpUNWtVS092OW5oRXU4?=
 =?utf-8?B?WDFGNXhnb1pqZTZlWldYZXFhODdhUTR0NktqcXZmVlNwajZ0RFl0UWl6ekpN?=
 =?utf-8?B?RVdwZE9saUV2WFJva2Q5VjhEOFJRL2Nlcm1aNTg2OExmT0U1c1lFVHFXaXVT?=
 =?utf-8?B?WHpGR29zSWFIcjlJc3puMi9HcDhHaUZLOFpaeFAyMlJ2TnR6MGtqakFkdmJK?=
 =?utf-8?B?aEx3TWoxcFZIRzVVQTRWWjVrSG84VnZYdDZ2MzltbDdWQlgzd2IvQUJwUUVM?=
 =?utf-8?B?b0FkYU14UkIvcWljMjljSjkwdFV5b2U1alRnQUlOSzg4QzVzcFdMTkdHU0g3?=
 =?utf-8?B?QUMzYks3emdPcEJkbTE1dkpUSGdyck9VUDFTU2szVzZ3TlM0NmZZT3BjSEdY?=
 =?utf-8?B?UUV5blpvUXZWbkdrK1lwdytCa2RSQjc5R1ZGczlIQVNhYzdDcUNOL0hOUHg2?=
 =?utf-8?B?dWVjQnUzc1hQblM4dkJVZUNHNVQ3ZEtrY1JJZjVlRVpSTlZvQ2lnUzUwdjJy?=
 =?utf-8?B?YXpIeFFveEdhcS8zUy80dXhJemZOVktWckpnT3hGOURFZjNjUnBlWGlkakVR?=
 =?utf-8?B?Z1JBRFZkYzRjU3NlT01yS0Z1dUJRbXBxMktxa2s3SEtjNjBOYnhqRHlGYnVK?=
 =?utf-8?B?NTRZTkttMlRXaGNGTUxSVmdGT0FZeHhRVjFnZmQxU3JXUW5SV1JTWXhDUDdo?=
 =?utf-8?B?dHJmTFlMK3BjeDM2cytKRFloT3g5WGthaVRjdUFXR2gyNXUya3U0cXFHcTFM?=
 =?utf-8?B?TFVxa1d4S1pIc0tPL2lOTTZrcXZMV0hNN0pjZ2FsSWwzN2lkalJld3NmcHhT?=
 =?utf-8?B?VnZKN21tQjR3NXVRV203Q1dmK3FmRkJqaUg4NXJDcXYwLzF0TWpwU0lxdCto?=
 =?utf-8?B?bm40Z3ZnbHdWWXI5Ymk5azIvTEJXQi83VmgxQ2haUHNXaGdFNHdYOEQzTENZ?=
 =?utf-8?B?dmxrR0p2V3ZQMThSV21kMXFiTlRZRW1yL0ZTRFVXM3MwMFBnNGZic01oVzlG?=
 =?utf-8?B?c1FTYXM3L09MKzZuL3pJWUJJUE9KcEo3emRZSkVxUXh2TW8xZWNncTVKTm9M?=
 =?utf-8?B?R3FkQVdPNkx6Ym11K09zMFZRUUFVUkFKRXVUU0pMZ2Ixcy96dSswYnN2QUZT?=
 =?utf-8?B?cGtKOU1CcTdrdy9ZdDM5U1BNeUl1cHEvTGpKMDJIQXVkOGZnSnlKWmI5U1VV?=
 =?utf-8?B?OFhjOTFaVUk5MFhFVCtHN0dHc2ZndzlYek8rM2JEb0o0OVU0WUxBRkpueFhH?=
 =?utf-8?B?SWpiTEJHOU9wak9yUGZIZFp4WEt5YWI5S1VoTlc5WEY0ZXhNcjBhU3liblJr?=
 =?utf-8?B?UGlFbGNHVll4dHRCUk1LMWVVUXFLSDNaRGUwR1ZSck9RNFIzVy84NnZWajV5?=
 =?utf-8?B?L05oQzNiS3JxQWNpbTRKWHJieEd0Y00zRG5BcDhQNzZPMmYvV2lZYlNudjRI?=
 =?utf-8?B?V0g1dkxjdG5lVE43dXpVZjh1S0VqM1NYd0pIYzY4SUlFWjNjZDh5MjVWVEVJ?=
 =?utf-8?B?d2hXQ0Q4MW9jazU0cXcxNG9qa0FYckxCTnJOYWY5NVMyZjRqWVEzblpjOFpn?=
 =?utf-8?B?dHA3ZTlUekdYbWF6L0g3Tmw3ckU2SVR2RWJCVjBjSTZnK0pyempab3BOVEFV?=
 =?utf-8?B?dEdjcUhsbXRMVmJVNGx4aEJKUmdpM0tpbG5ndG9TSW5wYXJ6OFFTbmlkNDRL?=
 =?utf-8?B?WldrdXVlSGYxWWxrNGR3T2V5S0QvZnQramFqbHo4ZkRqOVNydWZ0amVEY1o5?=
 =?utf-8?B?UjNVZmRTL2VKeE1hY29VZnpBR08vRnp5VXVsSjcrRlVwbWk0OFY0Q1RyKy9Q?=
 =?utf-8?B?WnNyamhhRWhHeGF6K1hUMGNqMTRSOGpwQTIvN3dQUDJ2QkQ0TEQ5K3hXRmh5?=
 =?utf-8?B?d1NaUm5CcDZTMlU3ZFF1N2YzMEdBSkVZbUNXN29GeVZQc2ZyNHNCWmZyKytZ?=
 =?utf-8?B?dDgzN3FoVjY4M2gwL0d0dCtnZC82OCtlSjhFYnpWejF2Z1J5VUZFVFV3b0Yx?=
 =?utf-8?B?NTgxbm1KZnFNTDJqMC9xSDBxZkNKY0pRZzJMQXNJQWJKRW9ISjNpcWg5aENo?=
 =?utf-8?B?RmowN2gvUlplMlhBVk5DSW5lNW5CdXNCRUozVVc0UTRmKzRDK0txVk95OTZG?=
 =?utf-8?Q?XXZzdqfyZRSM6pnRczhqUnY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CsDq4J+zoOT+fDkTOZ/5594OHoto47jNsg6WQQWSeAOd4aDJMrY1FjW6AenzqjPmmpaEmFMEKawzn6K4lO4d9x5c2vWQ9uEo9YGLCfi/1Bnz/KpSlz/oP/5DwV+aqFeSLNs8s2N/wm5+PlRAVjtmVx1VUVNS/kia+UZfs2c570Io2bb5RPB/zdKjnqTUD/homT4up1swXStjHl9UvHSPA4MdIALCkD1cd3YRx22jLe+hVFWJ5Cht7qElNVc+TX9e75ZFi+X9TNCrSVfzw40Ntb8eXeoGRKinLUA6J+2jply71gNloJDCj1gkieTqgi81yjH7KpzBJl/Co0nxBG4b4YCYTXRS1+cO23BKmxi74zCpaKVxvPFDYqVos7zz/ZO7FiDE0QnL69sHcJfO+VPzrzS/BUsL8Y6jH+MSFxBVJAQEl5UuISIIXJ3moZ6CFQl6nYJZCx72SlKaT4zMOOYdWzNynY141ziviZsmBH13/mJ8OOb4dsfZhtgTMa+9/uRTsQmQoPQUpkaVJTESs3oWJNuTEbnyIo0GZbJly8gEO0vprN6FnmBJxZFzwAqRmH1OqbmpkjGonwCi8MP6lraszFRvTTuCHku7kW+aywCTTXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf2e0d6-0fc6-4c20-00a6-08dc69368ab1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:56:55.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bosM2Js9OVioUCvYF9cS5UKEPcFC8XPfl/+L10FadA2lV3g8kJ7Ur0eWcV3XpFH2c8qvx3LuHK0DeimChbdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300121
X-Proofpoint-GUID: S41S2f9q3KD60RaOOsPrH0phHTocE5St
X-Proofpoint-ORIG-GUID: S41S2f9q3KD60RaOOsPrH0phHTocE5St

On 30/04/2024 01:14, Andrii Nakryiko wrote:
> On Wed, Apr 24, 2024 at 8:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Map distilled base BTF type ids referenced in split BTF and their
>> references to the base BTF passed in, and if the mapping succeeds,
>> reparent the split BTF to the base BTF.
>>
>> Relocation rules are
>>
>> - base types must match exactly
>> - enum[64] types should match all value name/value pairs, but the
>>   to-be-relocated enum[64] can also define additional name/value pairs
>> - an enum64 can match an enum and vice versa provided the values match
>>   as described above
>> - named fwds match to the correspondingly-named struct/union/enum/enum64
>> - structs with no members match to the correspondingly-named struct/union
>>   provided their sizes match
>> - anon struct/unions must have field names/offsets specified in base
>>   reference BTF matched by those in base BTF we are matching with
>>
>> Relocation can not recurse, since it will be used in-kernel also and
>> we do not want to blow up the kernel stack when carrying out type
>> compatibility checks.  Hence we use a stack for reference type
>> relocation rather then recursive function calls.  The approach however
>> is the same; we use a depth-first search to match the referents
>> associated with reference types, and work back from there to match
>> the reference type itself.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/Build             |   2 +-
>>  tools/lib/bpf/btf.c             |  58 +++
>>  tools/lib/bpf/btf.h             |   8 +
>>  tools/lib/bpf/btf_relocate.c    | 601 ++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.map        |   1 +
>>  tools/lib/bpf/libbpf_internal.h |   2 +
>>  6 files changed, 671 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/lib/bpf/btf_relocate.c
>>
>> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
>> index b6619199a706..336da6844d42 100644
>> --- a/tools/lib/bpf/Build
>> +++ b/tools/lib/bpf/Build
>> @@ -1,4 +1,4 @@
>>  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
>>             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>>             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
>> -           usdt.o zip.o elf.o features.o
>> +           usdt.o zip.o elf.o features.o btf_relocate.o
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 9036c1dc45d0..f00a84fea9b5 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -5541,3 +5541,61 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
>>         errno = -ret;
>>         return ret;
>>  }
>> +
>> +struct btf_rewrite_strs {
>> +       struct btf *btf;
>> +       const struct btf *old_base_btf;
>> +       int str_start;
>> +       int str_diff;
>> +};
>> +
>> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
>> +{
>> +       struct btf_rewrite_strs *r = ctx;
>> +       const char *s;
>> +       int off;
>> +
>> +       if (!*str_off)
>> +               return 0;
>> +       if (*str_off >= r->str_start) {
>> +               *str_off += r->str_diff;
>> +       } else {
>> +               s = btf__str_by_offset(r->old_base_btf, *str_off);
>> +               if (!s)
>> +                       return -ENOENT;
>> +               off = btf__add_str(r->btf, s);
>> +               if (off < 0)
>> +                       return off;
>> +               *str_off = off;
>> +       }
>> +       return 0;
>> +}
>> +
>> +int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
>> +{
>> +       struct btf_rewrite_strs r = {};
>> +       struct btf_type *t;
>> +       int i, err;
>> +
>> +       r.old_base_btf = btf__base_btf(btf);
>> +       if (!r.old_base_btf)
>> +               return -EINVAL;
>> +       r.btf = btf;
>> +       r.str_start = r.old_base_btf->hdr->str_len;
>> +       r.str_diff = base_btf->hdr->str_len - r.old_base_btf->hdr->str_len;
>> +       btf->base_btf = base_btf;
>> +       btf->start_id = btf__type_cnt(base_btf);
>> +       btf->start_str_off = base_btf->hdr->str_len;
>> +       for (i = 0; i < btf->nr_types; i++) {
>> +               t = (struct btf_type *)btf__type_by_id(btf, i + btf->start_id);
> 
> btf_type_by_id()
> 
>> +               err = btf_type_visit_str_offs(t, btf_rewrite_strs, &r);
>> +               if (err)
>> +                       break;
>> +       }
>> +       return err;
>> +}
>> +
>> +int btf__relocate(struct btf *btf, const struct btf *base_btf)
>> +{
>> +       return btf_relocate(btf, base_btf, NULL);
>> +}
> 
> [...]
> 
>> +               /* either names must match or both be anon. */
>> +               if (t->name_off && nt->name_off) {
>> +                       if (strcmp(btf__name_by_offset(r->btf, t->name_off),
>> +                                  btf__name_by_offset(r->base_btf, nt->name_off)))
>> +                               continue;
>> +               } else if (t->name_off != nt->name_off) {
>> +                       continue;
>> +               }
> 
> btf__name_by_offset(0) return "", so you don't need this if/else
> guard, just do strcmp()
> 
>> +               *tp = nt;
>> +               *id = i;
>> +               return 0;
>> +       }
>> +       return -ENOENT;
>> +}
>> +
>> +static int btf_relocate_int(struct btf_relocate *r, const char *name,
>> +                            const struct btf_type *t, const struct btf_type *bt)
>> +{
>> +       __u8 encoding, bencoding, bits, bbits;
>> +
>> +       if (t->size != bt->size) {
>> +               pr_warn("INT types '%s' disagree on size; distilled base BTF says %d; base BTF says %d\n",
>> +                       name, t->size, bt->size);
>> +               return -EINVAL;
>> +       }
>> +       encoding = btf_int_encoding(t);
>> +       bencoding = btf_int_encoding(bt);
>> +       if (encoding != bencoding) {
>> +               pr_warn("INT types '%s' disagree on encoding; distilled base BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
>> +                       name,
>> +                       encoding & BTF_INT_SIGNED ? "signed" : "unsigned",
>> +                       encoding & BTF_INT_CHAR ? "char" : "nonchar",
>> +                       encoding & BTF_INT_BOOL ? "bool" : "nonbool",
>> +                       bencoding & BTF_INT_SIGNED ? "signed" : "unsigned",
>> +                       bencoding & BTF_INT_CHAR ? "char" : "nonchar",
>> +                       bencoding & BTF_INT_BOOL ? "bool" : "nonbool");
>> +               return -EINVAL;
>> +       }
>> +       bits = btf_int_bits(t);
>> +       bbits = btf_int_bits(bt);
>> +       if (bits != bbits) {
> 
> nit: this b* prefix is a bit ugly, maybe use enc/base_enc and bits/base_bits?
> 
>> +               pr_warn("INT types '%s' disagree on bit size; distilled base BTF says %d; base BTF says %d\n",
>> +                       name, bits, bbits);
>> +               return -EINVAL;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int btf_relocate_float(struct btf_relocate *r, const char *name,
>> +                              const struct btf_type *t, const struct btf_type *bt)
>> +{
>> +
>> +       if (t->size != bt->size) {
>> +               pr_warn("float types '%s' disagree on size; distilled base BTF says %d; base BTF says %d\n",
>> +                       name, t->size, bt->size);
>> +               return -EINVAL;
>> +       }
>> +       return 0;
>> +}
>> +
>> +/* ensure each enum[64] value in type t has equivalent in base BTF and that
>> + * values match; we must support matching enum64 to enum and vice versa
>> + * as well as enum to enum and enum64 to enum64.
>> + */
>> +static int btf_relocate_enum(struct btf_relocate *r, const char *name,
>> +                             const struct btf_type *t, const struct btf_type *bt)
>> +{
>> +       struct btf_enum *v = btf_enum(t);
>> +       struct btf_enum *bv = btf_enum(bt);
>> +       struct btf_enum64 *v64 = btf_enum64(t);
>> +       struct btf_enum64 *bv64 = btf_enum64(bt);
>> +       bool found, match, bisenum, isenum;
> 
> is_enum? bisenum is a bit too much to read without underscores (and
> I'd still use base_ prefix)
> 
>> +       const char *vname, *bvname;
>> +       __u32 name_off, bname_off;
>> +       __u64 val = 0, bval = 0;
>> +       int i, j;
>> +
> 
> [...]
> 
>> +               if (!match) {
>> +                       if (t->name_off)
>> +                               pr_warn("ENUM[64] types '%s' disagree on enum value '%s'; distilled base BTF specifies value %lld; base BTF specifies value %lld\n",
>> +                                       name, vname, val, bval);
>> +                       return -EINVAL;
>> +               }
> 
> What's the motivation to check enum values if we don't really do any
> check like this for struct/union? It feels like just checking that
> enum names and byte sizes match would be adequate, no?
> 
> I have similar feelings about INT checks, we assume the kernel module
> was built against valid base BTF in the first place, so as long as
> general memory layout matches, it should be OK to relocate. So I'd
> stick to NAME + size checks.
> 
> If the kernel module was built with an enum definition that's not
> compatible with the base kernel, it's a bigger problem than BTF. Just
> like what we discussed with STRUCT/UNION.
> 
>> +       }
>> +       return 0;
>> +}
>> +
>> +/* relocate base types (int, float, enum, enum64 and fwd) */
>> +static int btf_relocate_base_type(struct btf_relocate *r, __u32 id)
>> +{
>> +       const struct btf_type *t = btf_type_by_id(r->dist_base_btf, id);
>> +       const char *name = btf__name_by_offset(r->dist_base_btf, t->name_off);
>> +       const struct btf_type *bt = NULL;
>> +       __u32 base_id = 0;
>> +       int err = 0;
>> +
>> +       switch (btf_kind(t)) {
>> +       case BTF_KIND_INT:
>> +       case BTF_KIND_ENUM:
>> +       case BTF_KIND_FLOAT:
>> +       case BTF_KIND_ENUM64:
>> +       case BTF_KIND_FWD:
>> +               break;
>> +       default:
>> +               return 0;
> 
> why this is not an error?
> 
>> +       }
>> +
>> +       if (r->map[id] <= BTF_MAX_NR_TYPES)
>> +               return 0;
>> +
>> +       while ((err = btf_relocate_find_next(r, t, &base_id, &bt)) != -ENOENT) {
>> +               bt = btf_type_by_id(r->base_btf, base_id);
>> +               switch (btf_kind(t)) {
>> +               case BTF_KIND_INT:
>> +                       err = btf_relocate_int(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_ENUM:
>> +               case BTF_KIND_ENUM64:
>> +                       err = btf_relocate_enum(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_FLOAT:
>> +                       err = btf_relocate_float(r, name, t, bt);
>> +                       break;
>> +               case BTF_KIND_FWD:
>> +                       err = 0;
>> +                       break;
>> +               default:
>> +                       return 0;
>> +               }
>> +               if (!err) {
>> +                       r->map[id] = base_id;
>> +                       return 0;
>> +               }
>> +       }
> 
> I'm apprehensive of this linear search (many times) over vmlinux BTF,
> it feels slow and sloppy, tbh
> 
> What if we mandate that distilled base BTF should be sorted by (kind,
> name) by pahole/libbpf (which is simple enough to do), and then we can
> do a single linear pass over vmlinux BTF + quick binary search over
> distilled base BTF, marking (on the side) which base distilled BTF
> type was processed. Then keep a pointer of processed distilled base
> BTF types, and if at the end it doesn't match base distilled BTF
> number of types, we couldn't relocate some of base types.
> 

Hmm, so are you saying something like

	foreach vmlinux type
		binary search for an equivalent distilled base type, and record the
mapping

? Would be great to just have to iterate once alright.

> Simple and fast, WDYT? Or if we don't want to make pahole/libbpf sort,
> we can build *distilled base* index cheaply in memory, and do
> effectively the same (that's perhaps a bit more robust, but I think we
> can just say that distilled base has to be sorted).
>

Sorting BTF is something that's come up a lot. We should probably do it;
more below..

> For STRUCT/UNION we'd need to do two searches, once for FWD+name and
> if not found (embedded struct/union case) STRUCT/UNION+name, but
> that's still fast with two binary searches.
> 
> A lot of the code below would go away (once we keep only named types
> in distilled base), so I didn't spend much time reviewing it, sorry.
>

The only concern I'd have is that the kernel would I suppose need to be
skeptical of getting sorted data (in distilled base or elsewhere), so
we'd probably need to validate sort order I guess. We could share some
of the mechanics of sorting in btf_common.c to do that specifically for
.BTF.base, but thinking about it, as part of general BTF validation we
could mark BTF as sorted or not. What would be nice about this is that
once we knew BTF was sorted,  we could speed up btf_find_by_name_kind()
by using binary search on the sorted BTF.


>> +       return err;
>> +}
>> +
> 
> [...]

