Return-Path: <bpf+bounces-64038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB26B0D8FC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65FC3B073B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B652E8E08;
	Tue, 22 Jul 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NqjxUtj0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ga7GUNAC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16C2E8E04
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186162; cv=fail; b=Z056EgpxEVqpVK/21A5/Y1Ql3fNUXogdaRxSLiXxnbrG1NUtq9vFBKqTgTlRmOsifZIdURkBjT3tfoZ+2afIlWAsLFj55nqa1EATFmb8p62Gs3dCoWFMFz1Fh05uyYBaQjARphRceuOQnYQMrSEQcnalHSdhlFYoUar4MjCgO0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186162; c=relaxed/simple;
	bh=9Muk1Faj0up67EOOJK7lwzGvhINiHi9twL4sWWufjVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXnbNdHVHAxwuqAzffzj24iTPUGKaRBeItWEM7C0K8UUsMaH0eadWEJ+nOS5SZJ5xScyGZV3hXFqupHttLqcqTBd3uyGHKC1cO/hquZSolhNGqcr77fX2vze8jGlkQaxcctXhHj2a1fg9oein6ymtULLuufJxTl4G4z9WBPr3tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NqjxUtj0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ga7GUNAC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TBnP002534;
	Tue, 22 Jul 2025 12:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9Muk1Faj0up67EOOJK7lwzGvhINiHi9twL4sWWufjVQ=; b=
	NqjxUtj0aCUjI2A3hVRWvoDIUAEZqbjpGz4HZmWzyL8sj4VenOPnvVLIgs8hVKNS
	wfNNYZNpdyxilz875gga0sAaPhIEtkJ6hnrwGxWMQHpG3gmWjcnFUnnZ38wV3vSo
	jEbRnSqfDUKR53agO7frSvHckqQmAaSanyMyl/0oizb+tCumr5erhlmP4U4n4cep
	6Z2F5t59rPJI0bEeXC2KiD7yPy7a+vhSlql9erBlQe4a2jGQiiIoPObLL0FeGmBd
	WzSUriK2V1gUZo0i0NW31SO7wc6F/2QdG1Gw7Cc/DPd/3yDfOP7K/Uqsk9TLxqD7
	CTCEGKXo8E2n6kqVAqruPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpd31x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 12:08:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBA3p3037748;
	Tue, 22 Jul 2025 12:08:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t98kmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 12:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVQh8jN9/hfvWlYf1T1V+5lohLEOD3CJy7ZUMO4eL8RVTfAwTs+X98x7o9eC3sY8vQqW9qK1T2fGvT8HaTVUZB45dlztDVPcFuc3qCaWfPwDMwrx5TWGtFjKLK+sMQ/5GGHV49pN/kmUGCafKEYch8Fw2qi8zr+hKx//Dt1f1e2baiMZYFPUzM01yoKxqKMlm2TxRQL0uus7zd+dZGneoG4vb9TRNaNJKCLtaIicMx67Hr4sEy78bg0JBBEIn0IHK7ZD4Lyt2WkVyrqQeJNAsTRGYLuzBWYWavue0CsGZKty2CjADII2lXdulQ4xX+OIqmmZDN8yycyIhvj0cmqYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Muk1Faj0up67EOOJK7lwzGvhINiHi9twL4sWWufjVQ=;
 b=w4gaYieE3PjLpoth2j4MX7qVPu1ZuksMaPhoC0QZUnzIRS1jFgErZwpOxH1OnwLNe//z3XRh2mn5q588N/dtl5ct6JkC5OjZtmfKj2K3hdgC5EQkW0HEl8umQM+B6twSQjAqOs3nE6PhaqHFTC+ZRWJ5aJtI2m2TSy/eUZK/mi8cm6BPJqH/B2PIEKw8lcgxJbyLjkRoW41RYJKYg0C5wOma06Jkw3IwojVQo6k1T8+0mnIA4ZCvJ0Hghe5ykKKlMqno36/GSjBzsYh2/s+9Ec9NTcakKk3zacNv+0ne/RKqfe8qxJBYxk44vB3teXiUHE6Bd+i4wgo49iUIR606rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Muk1Faj0up67EOOJK7lwzGvhINiHi9twL4sWWufjVQ=;
 b=Ga7GUNACE3PnSLIn2rqifUVOvNJ91k2YIEeC7CmNipDjEvqG70TnfTMqH/o7g4sA/9Sqx0IZzArT/GfqhFVOkEWZ23DxtmqR4rFR0Xw7HDt2DrdY6CxUbIteGrOfZ9LL8X5gugifcK4GaBwqdPenQ0x0UYBxRsGPKj3KGwFFRok=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 12:08:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 12:08:20 +0000
Date: Tue, 22 Jul 2025 13:08:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <cd63510a-05fd-43e5-b020-56499ee5b867@lucifer.local>
References: <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
 <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
 <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
 <CALOAHbDMxVe6Q1iadqDnxrXaMbh8OG7rFTg0G7R8nP+BKZ9v6g@mail.gmail.com>
 <fa81148d-75ac-490d-bca3-8b441f2afe1c@lucifer.local>
 <CALOAHbAkR_A48r6Y_vikAgcifnK9cBhgAc5t=jdi0jTN695m-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAkR_A48r6Y_vikAgcifnK9cBhgAc5t=jdi0jTN695m-A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a68b41b-dda2-439e-7662-08ddc918730f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0t5K2hIT2RtSmhhL1h2ODhrTWlGNzZBZ05pZW10Tlc2bTNRci9GY21SRkRq?=
 =?utf-8?B?WFNuKzBQTldCbSs1RVpaYUZ5dlRjc3dyNUdsTU55dGJPcU91RGNyRjNCMmxO?=
 =?utf-8?B?RFZoZ2YwMXZUOTBxL21CcGlFek1haFpRTyt5aHdZTmorTmR2UUhweXFOQTJC?=
 =?utf-8?B?eVFRaDRxM2ZlaDUrbnliVzlFdzFxcUMrMmVsOFBHaitWN0FGUklxOUl3UC9r?=
 =?utf-8?B?Wk9ZN0tnSktudGVtSDMvZTN0bjJCblRmYUJnc0doa3FtVi9IR3huTEpGRDlV?=
 =?utf-8?B?ZU5pOGFvcWJaSlZ2TCsxZUI1bE8xOGg3WUdjVDhDZ0FuU1ByMVJ4Z0sxMmcz?=
 =?utf-8?B?Y3JQb1dZQjJpR2JHWE9KS0h4Nkoyb2dMdTZZWk5CYk5LWVpsa0dhS2tzbC9W?=
 =?utf-8?B?NkZCcGtkUTdpS1Evb050ei9qd0NqN2hieGhhcXFrTzJQMkRhMWNkSEpONjh2?=
 =?utf-8?B?blpMdWJsTlQ2RERpTUdlbEJldGQwb0FzcGtVNEhVd1p6Q3J0RXBWS0VtMS9r?=
 =?utf-8?B?SjRzU2VrOTF2d0ZFU2xIam5sazR0UXZzeVMvNVZSUDhLMnJ5d1dIUm4wM1NG?=
 =?utf-8?B?aUUzWDFUUkNnWEM4ck5xREpRVkRDU0ltYndtK0VtS2ZBNjZyaWZPenlKamVz?=
 =?utf-8?B?YzdzV3JOWGo1RitjaHZ1M0hTdzNPNExFbHJRT1VkbFltbFdCTkw0ZnBhMXBJ?=
 =?utf-8?B?Z1VDTTk5MWxiQlU3NFNtSnlFd1pxek9EUlluWlN3L0VnZURPVnFReXNmWUVE?=
 =?utf-8?B?NVRlM0dpdFJ5MnB3blVoTkwxUFNLSmtmN1EwUmh2NUV5QUZwSEFESUJuY2Nl?=
 =?utf-8?B?LzI5SnlMQUFoeEdaTktmN0dkMmZyRTlXZUtrYWp3RUFQT3ZER3FkOWdTU3pj?=
 =?utf-8?B?bmhCbFRnNi9sNjZhRlFOZnBtQmNPZGkzR1VJZlBIUEwvWDIxbmV6YWxIUzlr?=
 =?utf-8?B?UElaTEYvTnVocWdQVklBZ1NNWFVkSGpjRmZ2RGFOTHJYSmN2UDNodXk1aThD?=
 =?utf-8?B?QlI5RzdaaFN3dDdqcWJtZ0FiYlRxN1g5bjRudE8yOVRSb21pazJIWHI1YlBv?=
 =?utf-8?B?bzk1anU2M0VXWXpaaUxqaDNKNThybjVjT0ZVVU9CZ0l0TVQwcm1WVURsRWtu?=
 =?utf-8?B?UFlmMHhEcy9sNzV4OWZrTmsrQlFFem82Q3B2THdNaURQaFY3OVpXdnVxcFl3?=
 =?utf-8?B?VDIyeXVVTjhZSHhDdHU3aHYybFV2M25wTUVTTWoyeUt3ZzZQVE9wRlhnTDVM?=
 =?utf-8?B?cHNvQ0hBMG92eUJEMW5FMTB3em1Ua0pvZUJIUGxVWlNMN2hid1dMM2pyT2xn?=
 =?utf-8?B?NnpKYXl3VG9pY0EzdVdlNE9SNmZHVXlWc2NlVVB1ODcrMWJ2c1ZGaGliL0Mz?=
 =?utf-8?B?L2NpZGhuUlUwSnNJVVk4bFZ6UW1peE8wc2k2NlJVYVZRSDNISmJGa3JtRlUv?=
 =?utf-8?B?eTJaNStLdU9tZ3BnTCtDdEhvc3BHZU9sVG9oV3Bzd2c3aXhBdDJpd1VQemlU?=
 =?utf-8?B?NjJHOG9RQnJxWlU3UVh1eXlnRHFuT2IxUEdYTVp3U1RydVlCSVpnam51RTVn?=
 =?utf-8?B?TXFYUHY0K2ZkVXBRRzM1R2FVWUI5cWJoZkRCMGtDNFBPMTNsV2xPQmdRcHRX?=
 =?utf-8?B?M1BXbzNnZmxya2QyaWtFaG1GeDltVUFpK3ZqU2ttVU1WRUtRK01NbGFjUE9Q?=
 =?utf-8?B?a3FVOHpRL0hTSE1uV3AzNlVRQ0tkODBtak02eXBBaFN3aTN4ajB4d2JQNGdP?=
 =?utf-8?B?dFpNQlhpejVCRlFWS3VkcFlkOWc4L0VRbE56UkJsNURkZTNCeExhTys0Z005?=
 =?utf-8?B?VVkxbjdCN1RadFlEMVRZOHp4dzJOSExtZXhSZkpmWWdtS3N4cXpnK3B4bDFq?=
 =?utf-8?B?RkZjc0k3Qjg0VVhzL0pxZmlVN2ZBRTNwQk5mUkUyMkdRcjF2K3lVd2sxckMr?=
 =?utf-8?Q?9UjJiHlWJwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG52ZnpjZWdHTlFYTktieEZqUTJKMmR1emIvNWRIMmFuYVdCUDhML0lVTkxN?=
 =?utf-8?B?anJSYkU1alRtdW14UUd5Sno0a0NQdnRoVHNLOEhNUE9sTXRYUkI0WXFvSGQz?=
 =?utf-8?B?d2RuWEQwa3RMU1FaQnMrZVA0b0ZQcmpBekErNmR5OXU3ZE83RWdENWFyRmxP?=
 =?utf-8?B?NzNGSmxLbUtVeUlkb1FvUUdURUtVMXVxZDVUZFpBc0xKeVBzNXVpbGVEeVUz?=
 =?utf-8?B?K3JGUkJ2SnpGUjdSdlYrdXNmdHFTZDhMS3g0L1YxOFlKZDRWV01HWmUwbmhI?=
 =?utf-8?B?YXI4b2dsUCtkTUVzSzgrQ3B0RWEwSktrN0NvdWF1aGE1aU9NcitlRjQ0akVn?=
 =?utf-8?B?ejZmYzhRcisyY3Iwa2dER0Z2MWZzZWU5UlRXQWNkT0NBeUtiV3F2bjU5TE1C?=
 =?utf-8?B?di9hU29lN0Zmcjl0RnhlaXordGNtNVRRcDA0OXFuLzA4Qi9rYTVST3orWDJE?=
 =?utf-8?B?UVlvZXNWVHN2RzVxVkRJL3k4MXVxTXA4dHZCcG50eUljdEtXN1dFMWgxZEFV?=
 =?utf-8?B?QWd2aURZNmgwcGNQT1hNZy9RNVBQU0RFNEtZS3N3TXdzbzh4WGhQT3RkeHlj?=
 =?utf-8?B?QXpzRkljMWVPTmVlWjdvUzZzcXl1SFJTTlczZUxGeHlUMlV2MWFBQWJvcWRU?=
 =?utf-8?B?d2dGQjhJL0dNbzB5L1ZJcjQ2bXVBV1VRK0hCQ05weXBhaWRkbHBRSmpuQUV4?=
 =?utf-8?B?c2RaK1dtUjBqYnJRMFhPWXR3S3hBUE5WQzZoNGtXR1ZaaFZSQkVYMER6VHJl?=
 =?utf-8?B?YzhKRHRwOGxJNGN4dCt2SGFLRUNlck9FbGsvaVA5cjM3ZUtRQVo5UVBCVDd3?=
 =?utf-8?B?SVBkQkhya2tiQVM5dDJkcU1IeGF6c0VFVGJ1QnJuS0hkeWxFVVQ3c01sV3Ix?=
 =?utf-8?B?TDMwNU0wamtsYVRTNE4rMzl4cFY0TjRmbDFWUlk1QmVaeXMraFZiYlZ2a2VQ?=
 =?utf-8?B?amVZN29yQ250TDZUVklvTjhKM25qQmV6VUpVWDk0ZUg0eTBBTzF0R2FuQzlY?=
 =?utf-8?B?Ym5odS8wN0ZvM2RqOGN5TEVYbmhiai95NlFJSjJDQ0NDelBTNXVrVVY3V29T?=
 =?utf-8?B?clB2bi92a1BrUWZOaEsxVHhCcGl4ajd5Uk5waHNSZUZSUlgvRVkrc2M3eU10?=
 =?utf-8?B?UnZkUjRMZlRLNnlIQ0hQMWdCV3VEL0tKNk9lK1Nmb3k2amtGWnRoZGl0Q1R5?=
 =?utf-8?B?N1F5TXFQK3h6cUYvS1pyZHpjWU45SkpMN3ZsR1JLS3R3V216cWY1T0h2aU5J?=
 =?utf-8?B?K0dCelRINmRWd0JEZktkSnRBQmlRRE1BRlBYNTFjR3E0bkJJaTA0Wm81UXl5?=
 =?utf-8?B?YTNlMFUyUElNeUNITmdnRDRYeEdZOU1PMU42OWlvOVJBckcwTnhadlQ5UE90?=
 =?utf-8?B?Qlc4c0xjQncyTEZGYmVmTmFMQmxsQktwd0IyZHFaOEM5UWlrT0tlcEY1WEVm?=
 =?utf-8?B?cTJPb1VDMkMzOVYwQmkwNSsyQVpibnZKeUlEUTFXaWZFbTFuekJhSzJvaW0y?=
 =?utf-8?B?SnhDWDZ6dFhFTzc0ZzFPZEpHa2ZBN1dlVEMzaHh6Uzl0V2J3SFlJaDN6TFR6?=
 =?utf-8?B?M3ZKTjZUc1pQSE1pUS8zMURuMmNhOE9DYTM1RVYzb0NyQlVRRi8vRUd4dEpK?=
 =?utf-8?B?RU5aNU53UndaSDgzSktxMktpdmhGa1lkR2hQT1JJYmRlMDBrSi9lVGY0Nmhr?=
 =?utf-8?B?NUt0WGZGS2xRdEwyRlNPT3ZLVHRqMGFITkFCNGFDbDhpaEF2NHBhUkhVcXk0?=
 =?utf-8?B?dTJZWHZQWmdHcHhxZVhCZDh4ZnN4dUZHaFg5WFpYcEtCbU14K1Z1c3VzRXRM?=
 =?utf-8?B?VVl2ZGgyMkUxS1RrVEgzVlRQNGxOMzZ3WS9NYzFyblQ2NWdmRnU3UE03YndQ?=
 =?utf-8?B?Zkdncnlsa1ZBa3Z2ZW9WUEYxWVRrNVVtVGRRbUVkSExIK293ZllRUGJGbTVD?=
 =?utf-8?B?MFQ3S2JDMG9sdEZGaW1hQ29vTm1pQUxkVHlGZlIxRnlWbFBzSkhvT3psM1Jp?=
 =?utf-8?B?bFJQWUhWdHJyTm5qYmlYN01OVmF1N1YvQ0JJVmJQRWUxZVRGd1Q4Z21ZdFNp?=
 =?utf-8?B?Nm5jZG5LWnZ4ZXhBNEtjbTdDelJGYXpxeDM1UEVBdU5GOTU3aGlVdUN0cmVv?=
 =?utf-8?B?UzVwV0NlNHo5VFhIdUUzM0NiWmpxVnN5OFhvbWdzUzhGbnJXdTNrRXV6N0J6?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HyXNMaUW4IXrXV+wfbydgcLBQmJMXih0Ld2UN/9ErhXHLbpTD5c7Y2JaWcAJnK+oK7K14rIPdhWESqYUwNwznTGQmtZrhe23V2gB88SR8CGLueLwjbyaFS7ZUNnlUrzgYcJzsCImz8nG3FnQ+JkANB29B4wdCgFd+CZ4RgyJ0OgGZ+W4EqWJmEY16copSiXq+tE0ZyyJyJn4BiNUtVQLddc0Rud6YcjsLtnY29XLoRdSODrz0L6PHTk6o9DS+iKpn1jPqaaVUgf9AOTTYBvvsR0TGl0/IY5/NnDD5gTZk4kTcM/9zWqatdM0agBmQhHOVc1G/po9+emgKKXto0kmKc0Yw4ftqqRE6AnPMmHu86+9vdp10M8wf9pxWrF6nvhTN+i+axJB6teiMu4/mrZiARt0k8GOYxqRJWx6qujer5JD2ZgVVVfoCKDSpiR7C6mzKgoiATMZ46Haa9X1lQleA0EQ5g2sFUbKrVaOz+hABPEl4hdWNPpi7H3ROpHqO4X82gy9qdEsWBWD0ADgIIy4zcrDiWbzxbojzSi9sKN3xAXAz2xmQG1WLX3gcZUa/FpU8tLY/XIYLiAvObuilDpt5GlgXtVfUJDIKbPn0wW2ExA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a68b41b-dda2-439e-7662-08ddc918730f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:08:20.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stXDpnmIZKSs8yIeftWere7hohIqDTm2w483utAuFu7HhgeZsF0Kzggof3HdjGzR+y2PrFfzg8UPEdPqkiFGgyOC9V06V4sWG3Wzc5ggMis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=966
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220098
X-Proofpoint-ORIG-GUID: 4hLoHhL-DKe33USkt8tYnJL3TjkhDKKc
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687f7f38 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=d-Ffn_m1-dV11KwYmpQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: 4hLoHhL-DKe33USkt8tYnJL3TjkhDKKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfXzp8gW8ZMrZt3
 03UeVtviwIbzpEppewi+uo0wiZET3Bj42pkf6ZaVAZqoEByz3xfuDw8EQeSYzeCCEKF3zHZ2rIf
 B14Vd7jjwMqJcvpvUbKZFNvddUtfqnvvpzjKuSOQ+DIsrA1IryOSIJ1xhBoFSP4wOSA+AXxqpdo
 ivbKdmQzGciOagrKNE8r4YXUZAVEaftLjqTqGOWyHzcSSHRyFNJHPJHpV/7V+s3EzcPuIN+R4kD
 JmpiIkgOMyJ/sUYFjbLJZfUDD2J+pxfl+QUCbdpamfX8+Pz1HWV0Q0h5GNHZvlj5i4iGFvOdYFj
 iUF3fVQPXZxQVmL070ToQLvlUFAY+Z7RQtj4DxA3/pe68XTkaX+FsgYg9GXBl8pH3YGkQpIRzmq
 D6Sjwsm/nsJDpnSqFhoXDYR138YHDnQJFkFyf/aGskWFzqbAedqlZJbHh2XbEFS7tUKPvbfL

On Tue, Jul 22, 2025 at 08:02:15PM +0800, Yafang Shao wrote:
> On Tue, Jul 22, 2025 at 7:55 PM Lorenzo Stoakes
> > >
> > > While this is not a strict requirement—maintainers can remove kfuncs
> > > immediately without deprecation—following this guideline helps avoid
> > > unnecessary disruptions for users.
> >
> > The documentation doesn't state this, you are surely just inferring it?
>
> As noted in the other thread, the maintainers ultimately have final
> say on this matter. I'm simply sharing my perspective here.

Sure, sorry, I was probably being a bit too succinct in my reply here :P
see other thread, I think the situation won't necessarily be quite as clear
in practice.

>
> >
> > >
> > > --
> > > Regards
> > > Yafang
> >
> > Overall I think we need a different mechanism in addition to this, such as
> > a very clearly described CONFIG_ option that makes it ABUNDANTLY clear that
> > the config and thus the related BPF hook may be removed at any time.
> >
> > Ideally with 'experimental' or such in the name, or perhaps even tainting
> > the kernel.
>
> Agreed.

Thanks, discussed in other thread also.

>
> >
> > We definitely need something better than what this documentation is saying,
> > sorry. I am not in any way confident in relying no what this document
> > states.
>
> The documentation has always been difficult to understand ;-)

:) I think it is being rather too cautious or really circumspect in its
wording, and could do with being a lot more direct, in my view.

But I suppose since organising kernel developers into agreeing on something
is like herding cats, it might be difficult to get agreement to the point
where the documentation could really be that.

>
> --
> Regards
> Yafang

Cheers, Lorenzo

