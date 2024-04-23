Return-Path: <bpf+bounces-27517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F538AE086
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E3BB24550
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05B56B6A;
	Tue, 23 Apr 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ORCZ9CtF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QWJs+O1I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6355C3A;
	Tue, 23 Apr 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862971; cv=fail; b=cOxXZDPxwL/nJfbSud0tOTTk0Z6wEWtgfkXKXwwP/Btdm1TLlN304fDDX/ouZg3mw4D2xVVZlzZznp3QIeFTUp7jOWc8e4T7Fru6pb3lq6MV/0YsV42N8InkqlNRSVpVTGWZRJEVpNJN07gjn3IOmG7cP19LQfjVaWockY3Y+OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862971; c=relaxed/simple;
	bh=EEtG+kfWWnhAIBD94FczwYNwR5GmCo/mXls6Ve++jhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PczATTbkLvd0bAqnoCF1OhU7jKWI64c7HfSQQMWZ7hk/8l8NeV1LuD9b+x42dsWMkCBk/iOZgpxOiwvArXAV17AV91aCugKeJiFTbN3d4K6dIvSIDQSnh6o4fqJXfHB+N2ZCuhYf5XadgO1/QoU586bjhqBsExbxA6fRJGofF2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ORCZ9CtF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QWJs+O1I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7ZEXT004876;
	Tue, 23 Apr 2024 09:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rrnKJathyRsASDuaT1E5MY5l/LVgwnEDi66aWEWm2ow=;
 b=ORCZ9CtFaoGM+x3XlLNW7oja13T/GOg76zFsjUJvmkE4DfFnya2sqorOgl46I2Q7bmmC
 JYnlZdfygr11MGQ+4jq4Slczg4d16LOVmWCRP6gQZkeuERUGKX77BChlOUyfSHOKvM1E
 21FpdtW/HUi2aPBUiKAyMYyJ73/R1xvBzwUcH6hj4Isbhj56NMLRPjiluOADWV5YHG1k
 X+edc6G3bUJbY7GuMZVq7w1g/gIfRCbDE3MoL/Xvr/8vwg2TL51DCmuqH2pKaO9n2wt5
 whSmQbfF6xic5Vm41x2E5JK5ov1OdbgfRU2p+Hx+iDBD7AOgrb//NkVu8ncipf/lYlN/ 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md58ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 09:02:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43N8IeTx025474;
	Tue, 23 Apr 2024 09:02:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45d5b71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 09:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg01N1xBYOKBYUiHnnXZb5wqbnBRSWnDe0kio2oKXZNhelfjFGZ8AgThV8HjLngTCB88lieCKpx6IsJ15iVpEpmLXTwYx6tus7P2kZcSPVihRTOwpLpU3ID8FwgnLz8GCHtua+SR5ZRHC+25uIeSKJ08b7i/ruN3GSK/Wm8GID7otew3XocgorWV8mvirtF9QADDnNkBgtTWCW4OfwcoCYvud8o0fTx5b2R6k9UfeO0Fat95dM3apjXb2U7/u41V6+0UH4Xie0n5LXewufPnbGYuPITLrrSVe749I9YVa8Xao5UOiSQVfoqvWjooOkcne3bkonlnIzEAGsdSSwedvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrnKJathyRsASDuaT1E5MY5l/LVgwnEDi66aWEWm2ow=;
 b=LOrHcWBzHCl/sS+mbqytcrgBpAiRgbzoJUDypCRTCSf4UlP7or3r9e9LuHEx46BjUVZw8wDBeDkOcMR83suxBG226DPCe/Z3ya3770lS0+oE2xeoUZkuarLScySJO/0k+UgCONgbmN6MII/qh1Bn01uJOBiBQf633F6CITSXsPNSDdydPDmzuounBlRTmbgFwDS+zgRUxUsWvTOr+LQVJSBGvUtWWIM0ItWQqRalE0Uvu3una3jYDslGO2avPNC0p0Zdklj+/sUFaPwMTm76xyKPZGqZ1zajkRcO9ZVMd5c8HU9K16s893ojKlLpwOAmmTi8VCZ0+1tZjc11BqLPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrnKJathyRsASDuaT1E5MY5l/LVgwnEDi66aWEWm2ow=;
 b=QWJs+O1I72iSbH0XXOq06Ft13xnr/KaePd5Mk5RcG0c8WFz30PJQeNwU9vTvHaeTnTg7+vJeVZBL0u2xCpTiWb3k8eB/q3LGSWcrC+kne9urbU5Tmq4abfNKbCr+iH0gcICke+ezr+T9WgX5j5TnPm9+qFURxHUy14tKSZlnV3k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:02:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:02:33 +0000
Message-ID: <95822772-34fb-4fa2-82b5-0e143e56f2f8@oracle.com>
Date: Tue, 23 Apr 2024 10:02:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 0/2] Introduce --btf_features=+extra_features syntax
To: Daniel Xu <dxu@dxuuu.xyz>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
References: <20240419205747.1102933-1-acme@kernel.org>
 <uhpbft44tp3arrmvdryd23hfobndoubu3c33d6bntsuyovrtq3@r766mv2yfdqw>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <uhpbft44tp3arrmvdryd23hfobndoubu3c33d6bntsuyovrtq3@r766mv2yfdqw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6088e7ec-aa04-4599-b746-08dc63741ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dzFLdGRycVdpa2dwWGtxeHVienZVQTVuVnMwdjJHRFFqVDBLUmNQTmJOU2t3?=
 =?utf-8?B?V3VWVzFvbDFxU21GUGlXbGh2aHphcmh4aGVza1pYLzdmakxtelppMW5nQlNr?=
 =?utf-8?B?T2cvMS8wMWhPSmEyMngyY3RDNUZ0MWJ0bkgvUEd6ZUJHaTFKTjVqeStZQmNI?=
 =?utf-8?B?VEN4eUNFc3hCMmpld3lWVUE3TzdvVW0rdWFyOUlNSlZtTTB1Z1hyd0lhQ1FM?=
 =?utf-8?B?WWwxSGtEWmNEYzRoUmw4VmVIcVNUVm9BaUpqMjdUcE0za2YrL2VwYVh0RUJ0?=
 =?utf-8?B?UlJ2OUtaeE96NnBZTVlLeEg0SFhINnZ4N0s0NC9UckJ4QjRVMHdMMDJNV3RI?=
 =?utf-8?B?ajhaS0daR3N5NG5aMm9LSFlXSnlHZVY1ak8xMlM4M2RPSWxkNTZobHpNTlVJ?=
 =?utf-8?B?RlVoSmJqbHhlRkV6a3lERUhQclY3b3BQSHk2Mlh5a1dZYmFLVlJGSXZpVFdq?=
 =?utf-8?B?ZTB1eTRId1FLM0EzYmU1UXN5ME1LRng0eFNCSk55aE9ENklBRHhPREk4d2dY?=
 =?utf-8?B?TThQTWQyQ0hqYkl0ZXlQOVRjaHRYb2lnRm9nQmdNT3d4aFptVmoyM29SeWRx?=
 =?utf-8?B?S3I0S0VsTWhoNVlPY0d0a3dMd21SWHl4SmZCWFBGdDRTT2NySlRhZ1BQUWJG?=
 =?utf-8?B?OXFHZC9MWW56ckJOTm9ERi9Mc0F6M1JSRDVmTWYvUTZ1THBJL3V1Y1M4aU1z?=
 =?utf-8?B?dVQ5bG9HVndnU3VWbWF3MUdGV3dNYlh1YnRYbkFLQjNaUlc2TzRieGFkbkZu?=
 =?utf-8?B?MFF0em5xN1FyOFYxdHN0bkJrTDVKWnJVektWOGR4Y3VLMldWY1RSVXVwZHV0?=
 =?utf-8?B?Um5LRFYvZ2RwNnJCQjc4NWFOMk1XY251NzQ2TXdwa1czclhFVk5RZlNzSndE?=
 =?utf-8?B?dlJnNE14d283QlZlTWdvZnRnRW10UTV3U01SNndrTXYvUGFQQnFxT0dERXhn?=
 =?utf-8?B?YUg3c2JQRzNqSjFFQnNiRnFIcGZIZ0pULzFRUUo3MVltMmtwa2JZckx3cGt1?=
 =?utf-8?B?ZXduNDJyYjVoQ1loMlpTaHZsNzN2SlNVRC9qQkUxTzV4RnN3dll3QmdmK01Y?=
 =?utf-8?B?ck1iWHR3R3VkNE0zK1ptVXMzVTFGQWkwUjVnUG4yeVVJZHFaa3h1VnFFeGk1?=
 =?utf-8?B?UVREQmdpSUlycG1UM0J4VzltZ2FFZDNWcFJmVEdzK2JjazJ3SWZ3d205VkM1?=
 =?utf-8?B?eXRadnNMNlZaWjJMNmxNWFBZVlcwa0hKcnFyODJsVFEzU1JtdVN4SlZabFZw?=
 =?utf-8?B?VzBDMUpyWHdxNFhiZ3J3bE5kUUxLRDVWSkRHeDkvYjk4NjhyMXF6VkE3RHY5?=
 =?utf-8?B?L1FFTHVrMmdVSGI4Z0hoZWJDZ1JuQi9VMG1tb252V3g1NXBXUmNMT0dZWjM3?=
 =?utf-8?B?cDViVGJOVU1TZ1ZzUTlmaURGdUROOHBaSCs1Uklpb25zM2ZaZGdhUTBnVzQr?=
 =?utf-8?B?RS9DNzRHL0ZUK2xSZUJkQmp5NmZUcks2QVMwZldoVzYwb083WnM3VjJ5SFBr?=
 =?utf-8?B?WWxGRUVhR0JFVGR5T1Z1RHFCQmg3cmtJMnlpeVBqeWU3SXRMb2ZpbEk0N3Vz?=
 =?utf-8?B?THkvZWN3UVYwb2Z0Nlo3OW43b1ZZM0Z3SHBsbWNQZ3lQVkRmSWU5T0RCaHdS?=
 =?utf-8?B?QnFtQ3VGQkpDc0ZLZUNSazR5UWUxSW1EOWFXTkRsM2JJRE4yMVV2R3JlUit6?=
 =?utf-8?B?WmhhUERLN2xjS0hUZnZibVdmdTdBWldZSHFuU1F0WkRGdDF2dVRzODJnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlNRSFV6OExHRW84NVFHVE9qTGl0dUZOclA5NktiN3Awdk40Qm5LN3U5MG54?=
 =?utf-8?B?RkZTYTRGa0dHQUh2QU5WSU1VdXpXSC9aaXVIa0Q3c1pDdVpMZEJtaXVRWEsy?=
 =?utf-8?B?RFFsU1crdE03TzBsZDZEYVUyQTY5UUc4NXhqM3pJeXpxbVkyZmpNNkJ0SjJU?=
 =?utf-8?B?RktBeFZXdnM0L1NwQkJiZGRUbnUxODJQQlpManI2RDU5ZVFZUUIzeXl1YXR3?=
 =?utf-8?B?SDNYMVdpMkIwZUUzY2xjbFM0eXgwYVpnTGdxd3JzU3EyZHhhZ2s3VjhUOFh2?=
 =?utf-8?B?NktNN3FKbndpUUVjZXFCbnJYOTRrd1RWaFl5MTlkMXJVYVZuNis5VjhkK3FW?=
 =?utf-8?B?dURCZ1RsTXpRb2NPd21pYlZOcEVmeElHa1hjRUFYeUVlOFNWR0NIRE85a285?=
 =?utf-8?B?T2lpSWwzZDE5NkpzVzVzUCtSTTc0OHlVQ2pJSGhhcC9VdnAvMU5tcFlmeWdW?=
 =?utf-8?B?THAxMUg3alZmdXcrMFkwZ0crY0xYQmU4K3QwRnZ2SkluSkpZVFpySldwMFBM?=
 =?utf-8?B?NGd6U0RYYnRuaVpuRTFKd1FzNStwYlFIQUE4MVlWd2h3TStVaUxoQlMrTjA1?=
 =?utf-8?B?UllkK2dDUFZrMjIrZWdjOWNGV2NCdURvSjVCaFQzQXFZbnJzRlAvd2dEbGJQ?=
 =?utf-8?B?MDNKK0xGT05aUWZJVzlYaWVNQ2cyekxQcVF1WFRadzI3eU12SHp5RE1YVjl1?=
 =?utf-8?B?ZWU3bmlvbGc0VjdGME9ONGtEK0JGNkV6WFZpRFI3UUd2NWJ1alU0NmdiQnAy?=
 =?utf-8?B?RWlwSDRTeXROSWZTdkRsNktRdEtXY3ZzK2c5Y1NoQXlyRXNFTklJZTh5UGV0?=
 =?utf-8?B?QUtBOXQwRFhHVzVmcFFyNGEva3ZoRGJBaWUvNWRmSTRITmdyb1pFc2ZSNUpx?=
 =?utf-8?B?aU5wZHZuek1lUUpING0vK3grcjI0eDc0OWpVRlhRN0hmUjZXSkoxallYbmdX?=
 =?utf-8?B?SkE1KzBLZ1pYd0RacS9ZT281cGRMZTFZYUJWcTRaa3FyLy9kYURVbEtROExs?=
 =?utf-8?B?bjNVRFpCdWhIdFVxcElvUzY0b0tKN0JWSjVoRE9WTHViaUxkNGlrMjBhMUlr?=
 =?utf-8?B?ejJCK0dvUk1VYzBJQ09HU3JGVUF5K3d6aW1SY3VQdUdpbnJoRm5jekhkVldm?=
 =?utf-8?B?SFNHYXQ2ajF2a3RSR0RYRUk5dGJFYnZQUWdSVXZTTTh0eDJ3bk1BUTluakdQ?=
 =?utf-8?B?YU1hVnF5Q1QwNCtpYlpkcDMrUHlXSTBXYTlWaGw4QjBtdjNnQXhJdGFSZTQ5?=
 =?utf-8?B?Tjl3dWZ3N1NEVFl1QUtMcGtpT0xHb1hvMUJiVGY3eGhiQXRTK3ZkOW41Qmdv?=
 =?utf-8?B?WVAzb203UmEzSzZ2UmxucUdiNkNqNVFFMjcwTFo4MXpGYTMzODNua3NsSVlK?=
 =?utf-8?B?VlBON1B5Sjg3T090bHE3aVdzV0ZaSFJETG1kZjlWMytmTG5EeTYrdVJQN0dp?=
 =?utf-8?B?dkFud09Cd1FZbWRzeWdzQ1lLMjE5OVd6b2VDUlZpc01rc01Jbm5qVUhkTzUv?=
 =?utf-8?B?dWVmZTZ6NXZjN2NQQ1NyRDZlZ09OcEoycjVNekRkekJHMmJhMk9hdm90ZFpl?=
 =?utf-8?B?Q3htbnl4NDU4YVNIUkN4aUdEcHZINzhoV0xBZHpHaDd6M0thQnNLei9hdzRz?=
 =?utf-8?B?bW9OREkrdWw1c1ZveUtJblk2VkhCK1JEZzJhVHVYeGlEaU1BNXZhbFYwd216?=
 =?utf-8?B?RUFLVjcxd3VBV0piUkprUWczdk5BVFN4RHg0OTJyck9aT0VKQzVCTkZSWWJn?=
 =?utf-8?B?Q0dmanlZTUh3ZFlMY1pkSjBobzFWNjYyZnJIZ2xUUWVrK1dFZXNhdjl3WFB5?=
 =?utf-8?B?VlRWNGVJU2RwbTExUVQxSC82NXNnSDQ2RmZ4Y3ViY25vWXAveWsrRWpNOGpP?=
 =?utf-8?B?TGpvUkZwK0Y2SnNjU3NZcndSVEtWUWRIVFBSSG1jRGIrSExObDlLV3ovNVov?=
 =?utf-8?B?KzJjUVlzeS9XS0tiQ05QRDY1bVo1NExnUU9xUnFUQzI2SU9EMVFETVVuYlF6?=
 =?utf-8?B?WXUraTVTbFpIdll3ekpPY1AzYXUxeGxmRmdsVFRZS2V6RTFsemZRMHlLQ1Vn?=
 =?utf-8?B?TFJhVDg2eDdvc09VbVZlL1g3TExCT2hCci9RejRFMUhRdnJnSW91dGd2U3VH?=
 =?utf-8?B?Vy9Idk1iSnlBcWRzai83WXkxc1dKQjIzOTJEOERDZ0F2aUsvam1BaElVa09C?=
 =?utf-8?Q?YykH8aNkA/Px9lkFtaKgUcQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6IpqOn7jZggA1tG8VYKvnnKDOjEsMOdiwnDz8LXKchOVtlqjge4kK/AiuvheBgz7a2C1aruAPxX28ew3RNRFJTpo62TP/IxElMrhOnXNsd8DDHbEZad6vQfNQaiphlNgvwvqtWezwIXNaQzidURdwWl4cZpSopBbAI0b6iG72lwLc+yWXQsh8yaHAi33LcToComQHQ3IA+I3oXRQSycM1WdVbsHvP3Mb1cWKU+NKsI87nQv0WUPeFTBtTnA2hLpUAkd5bas/eB3gLFSFjoiUx5J7tBfYMkFD0KGVAsy1IwKjlV/TtLrg7c63fuYR/wV6t6NPfEJqdYdIbGU7lEckajceeV2XRwgJTEFAAtEgRg8P/D1aGB2qsidK8NtSWbxsptDpv+fE1jkA9ItBVwwKNgHsg2ImRhb7rr2zp4zOJl0xvU1lx4LULCC7aJ/1bIfaRDzhfcFJVWSJJEU438jItpU2cf3Q0fZCXTwKtjfi5473TQ1eObHbabrJzN+CE0qyHkWzWv+MJMc5S/6DUk+thWg/18BF8HBxqu+8+QIs4N0V4NrekKujxA45n7283cTUA6aB8vLbmTyKXnfQzXVHfwRDz42zEWqurQNpt9A397A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088e7ec-aa04-4599-b746-08dc63741ce3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:02:33.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdUjFEAX7tEYOLcNrB/1qvgPaXvTSblOeLmqTXwOjYBPmVOdRagEtYMeWJp5NZChtHjjOjh4FGbQrnQB6PBvqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_07,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230024
X-Proofpoint-ORIG-GUID: utqYVuoqpydcDxB7ZNhc4M4wwVq5u5zz
X-Proofpoint-GUID: utqYVuoqpydcDxB7ZNhc4M4wwVq5u5zz

On 23/04/2024 03:29, Daniel Xu wrote:
> Hi Arnaldo,
> 
> On Fri, Apr 19, 2024 at 05:57:43PM -0300, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>
>> 	Please take a look if you agree this is a more compact, less
>> confusing way of asking for the set of standard BTF features + some
>> extra features such as 'reproducible_build'.
>>
>> 	We have this in perf, for things like:
>>
>> ⬢[acme@toolbox pahole]$ perf report -h -F 
>>
>>  Usage: perf report [<options>]
>>
>>     -F, --fields <key[,keys...]>
>>                           output field(s): overhead period sample  overhead overhead_sys
>>                           overhead_us overhead_guest_sys overhead_guest_us overhead_children
>>                           sample period weight1 weight2 weight3 ins_lat retire_lat
>>                           p_stage_cyc pid comm dso symbol parent cpu socket
>>                           srcline srcfile local_weight weight transaction trace
>>                           symbol_size dso_size cgroup cgroup_id ipc_null time
>>                           code_page_size local_ins_lat ins_lat local_p_stage_cyc
>>                           p_stage_cyc addr local_retire_lat retire_lat simd
>>                           type typeoff symoff dso_from dso_to symbol_from symbol_to
>>                           mispredict abort in_tx cycles srcline_from srcline_to
>>                           ipc_lbr addr_from addr_to symbol_daddr dso_daddr locked
>>                           tlb mem snoop dcacheline symbol_iaddr phys_daddr data_page_size
>>                           blocked
>>
>> ⬢[acme@toolbox pahole]$
>>
>> From the 'perf report' man page for '-F':
>>
>>         If the keys starts with a prefix '+', then it will append the specified
>>         field(s) to the default field order. For example: perf report -F +period,sample.
> 
> I think for perf it makes sense to have compact representation b/c
> folks might be doing a lot of ad-hoc work. But encoding BTF seems more
> like a write-once, read mostly. So having `+` notation doesn't feel like
> it'd help that much.
> 
> As someone who's not seen that style of syntax before, it's not
> immediately obvious what it does. But seeing `all`, I have a pretty
> good idea.
>

One thing we should probably bear in mind here is that for kernel builds
we will always explicitly call out the set of features we want rather
than use "all". So the "all" support is really more of a shortcut for
developers who run pahole standalone for testing BTF encoding. It is
still confusing though.

The +/- approach seems fine to me especially if there are precedents in
other tools; maybe we should also switch name to "default" instead of
"all" at the same time tho? The notion of default values internal to
pahole (when BTF features aren't explicitly set) isn't exposed to the
user, so I _think_ we can get away with using that term. We could
probably do a bit of internal renaming - set_btf_features_default() ->
set_btf_features_minimal() - to call these the minimal BTF features or
something similar..

> [..]
> 
> Thanks,
> Daniel

