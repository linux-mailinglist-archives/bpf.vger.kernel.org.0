Return-Path: <bpf+bounces-44507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868C9C3D35
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4707E284802
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75DD19DF47;
	Mon, 11 Nov 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+qNsDhs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ncceRYtS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52719DF41;
	Mon, 11 Nov 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324438; cv=fail; b=QKwLnJZeINynPcI45TuI97pV3bmLaq/A8XJLmOrdMGzoKA57Hb070Bvs+whMMpmYO7uLt01zQ+JMcpanYzKMnVOc8rhEGWQ3qMXbcZsnAm2GkRd6eFAl1ZHvWxmrA9rKT4x9Tnltp3IqpIxcPxoAztAxx05nb9FppsOecxSouTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324438; c=relaxed/simple;
	bh=zStiHk5o8pa0I3VObXXQDfFdf0LFBIeQEmWro0SxGJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amcphArzrG9b3ZCgRZNNwNgKcc1rhch6fybf4n17uXWGwgZI8FU69ETuOlaBT2LQTtuQJy2CEKUeaJIHysgod6JimMOYxOv/wPBOsSW8jeAoXBqfX/68S6ghP5fQzvbWpkVBo+pQNs2o/Xrcao6pjAREHmY6KXNiDRRpMx/8z/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+qNsDhs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ncceRYtS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9sqcX017741;
	Mon, 11 Nov 2024 11:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HcgUosWe4n974lsaMNIQ4kiyo5v8WJ9WHv4xifuOtEw=; b=
	A+qNsDhshS5d1vtf1kEXj0WqGIDV8DdukFolNE1PJ5ftXH8o0CVuFgGMV1pG+yae
	AQbF5VSkM7QOGlSzKU37GKAbYqZROw5xTJ3LgZK1Eiy6MyFB8Plscinh4rRUmY78
	DQq2M2AcM7Y+cwyFBRrFj0bWHASTWglKZ2muKLPYRkOZ6fNXiIpLc6OuRkFPkzKn
	aBgMdc26+S6DacUyiZV+qRbKKiXaK96nN6+AC/h7OZeCeZ5PDZE6Pb7ndm4UaLR7
	5kf4q0f9BWlEbmxTrT7Fo+yDwWBboC4MVDUtjMHigwzAYpeHV5FcSI7d8hwZOssY
	6ewD+IwoCvvnG3amXRBz8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n4t7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 11:26:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABAO7hc025515;
	Mon, 11 Nov 2024 11:26:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66tpum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 11:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrtZWHoFm/V6M+mGDW7wu9UGwnyvi2QSv7Xx65ssRjLmjtKHQ7zBMHv7WcmBddhD+BLyl8rabQjZP94wuEJ5D7eq421MLxf5f/qxtBuK3qQ18Vc3L3zuux8XzDe2oM6s2mfCsNDgwAN7vX+//Mk8VafSc4Fp5w3D5LWUYD963nAvIDwJ9w3DQu8ERycUDZVWOIEVqvBch0ZRoWwFksMQXKX4xbnjC89EnzAbmJbq/q+SHKwE/qwjwHWq2zh+qsjxbc2FGpt+hjyEO5TPK59BBXD/BTIzQLY7t+w8Q9qTfwQ4Z6mZZsW+xCq+7JV1jH9obcF984TDA9g6u42pDULG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcgUosWe4n974lsaMNIQ4kiyo5v8WJ9WHv4xifuOtEw=;
 b=Zuqx8H8XUuncqhfsWMSKlPBlnzNKFZxRVtzU/9zF+ZalL78br4E6dwejeUHix9+54Kr9+VEppzUAaGtmTxVyxaY0170cEzRMQfJILUF7xopFCEO86TXVpW8f8hcmr6+XY8LHFv/IAJL2tflQO7/tZE8ABsmdVYn3ARa7JsyKkZxcxpGo8uNYuWgt7Qo9z8slgLW3IuE7qwqNC2rSPfNN/EdZRxRlmKl4wN6pebmHxdtuunxCUJgrM8ZnGCAul7J9n7zTnaqBpbhXM3FarwU9l/CWXGR4mKR2Gm+dMzdiBPQ/JgBRGWUwjWGVU4CzHc3ssVWU03phZNdFjTThGvka5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcgUosWe4n974lsaMNIQ4kiyo5v8WJ9WHv4xifuOtEw=;
 b=ncceRYtSSW2JZ/GJcdLXFm9ZXoHhfm3Ay2omqyZO6/OE6UOnt299Ml+/JoGj79kSwSDV2obpTEh2efWn1UhSebcAbLe5VcbbfFWLNihXcp+sHJW/2tRgwdR/uh4ERNjc7eCK4mR188GwI6JzIdzRHEh1IBFlxYtOdcqex/vREyo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:26:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:26:47 +0000
Message-ID: <196c771e-8a73-4acc-8190-1f646a696554@oracle.com>
Date: Mon, 11 Nov 2024 11:26:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/3] dwarf_loader: Refactor function
 parameter__new()
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180513.1197600-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241108180513.1197600-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 892e9ff5-f620-4c57-9f91-08dd0243ba70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0x5TkxWWnZYeERXVStGS3FVSCszUHYxTWNzZ0FJbndVTGVWZ0RSZWRiWFFG?=
 =?utf-8?B?d3VpcWoxSnBDclFLMmhIUGowd3JOUTNnbW1CYVc2ZGFvb004U0lMV2x4UkNK?=
 =?utf-8?B?QmhGMlduMDJYRE1LNnNJanZpT084Wll4UE1HVXpIYlR1VjhrenRzRGJKU24x?=
 =?utf-8?B?dHpIU1hiU0Q1azZRVEdmWWtmV1pCY2NUMnMrdmYrWjN2TEgyK0RrY2pHYXoz?=
 =?utf-8?B?RU90RlBKQW5NSDdreGJtRDZXQnZpbUZnV1pxQTV2SVBIUXFBNGxJUjJ1Qy9Y?=
 =?utf-8?B?VWRkeU9mNXk4M3ZURFc0Vm9VYmRTT3g1bU5RUlR6V2Y2bjNPbVhMMldEbmlV?=
 =?utf-8?B?REU3UXJvdTRFTlpTektyZXI2QTlMdjF2L1lNUXVwOWdNQmtvMzEwYk1vOCtQ?=
 =?utf-8?B?a2tVTmV0OEw4UDk4Y1Q5M3BnN2Jicm1KRXhheThIQnRiLzVVL3ZWNTFtb3Ns?=
 =?utf-8?B?Q2JWa0cyYkFHQ1p2aisvaFdEL1lpTWdVak9BYmRqM3lFOUZEMTJsVjY1Kzdk?=
 =?utf-8?B?dUJXb2NybTVoQ1VOekdPSHg0ODFHYWd2Mk9HKzZpYkFWTVY1REo5TE1LVys2?=
 =?utf-8?B?a0tlSlBVVXdKL0QycVB1TjROL0tlTTdieVZVU1diQU16U1FiczYzcEIvMjV2?=
 =?utf-8?B?eFVvT0ltR1JQVEZua05LdExabVkwYTRWMFBDdUMyYWphQU1pWlNpTlY1aGJJ?=
 =?utf-8?B?UFBZZW9qbFl1UFFkN2JKMHVSTEhKTWtVbHdHV0ltemkwblRqRVQ1SFB5VmNh?=
 =?utf-8?B?blROMUxoelcyend0M1gxRUlUTW9TSDFUQncvQXZYeG1tOWdmaTBvb3laYkVH?=
 =?utf-8?B?OGZqT21vOEIwMnU4ZHBLbHh5Zzk3THJvZURvVlNRLzJaQkUvbmtMeVFUOEFI?=
 =?utf-8?B?MzVnbTlvaUxpeDBsb1pYR1VBV20yWStGOThVcXhFcW55N2JtTVhnSDJDRjZI?=
 =?utf-8?B?ckY4eW9Ma09aWHpEcnhPRlBpNDVZbzFFMXNybzd2cS9Pdjgxb0RnM3Nydzkw?=
 =?utf-8?B?RTNrQXkwZDdONHg5dlo0VkFlbHVVTlFQQnFHS0hNM1A0RDdSODBDK0xZa1Bq?=
 =?utf-8?B?Zm9xNDIrYW42b3FFSXNOZktrWDVuYmQzdUNlWXA1cStsT1pMa3FnT2FsNDBl?=
 =?utf-8?B?cmM4eGgrcmFzL3dkbzc1TFRQZnlTUzBCTC82cVdPdTNwc0Ivc1A0SU4zaEIz?=
 =?utf-8?B?cndCdzZlWnYra04vWmdQYlZLb0VpZEtkb09MaGFjWFNGSjZoT08rRitKZmZC?=
 =?utf-8?B?TUlIdlpST1BGUy80a2JYNU93N0NETDZ3bU9zUFRNMTJrNUZ6WTF6b3FnS2cz?=
 =?utf-8?B?ZnJFRG5TMXBPbE83UHB5RjNiVUFhY0N4M0VDbXhvUmtsV3hXeWQyWFZORnZD?=
 =?utf-8?B?TzRrNTRpajlMVXgzejNPZGtQUFVTNWpYV1lXSVBCUlFOdG1qODBkWkRYTWxW?=
 =?utf-8?B?ekxaZFZpcHFpTjBqS2pwU3NRdVdaalV5dnpGSzZsN1FWWDRrODVnZlFMZXV2?=
 =?utf-8?B?eWh6SnZMZGtPNzI3dTZIbWxQNjJndDAvRkE4Nit4Nk5YVXVmcms5ZmpJNFNh?=
 =?utf-8?B?N3NyR3VWakI3aVg1aE8wRUxNQTJKbVowaVhHNHdvU0IwbHhKZlZ2SWtBQ0NO?=
 =?utf-8?B?dDNXRHVRaWFsVjc2ZWNtWXBIbUJKTERnTnA3L2xnMWxzWW12MzdBOTBJeDdO?=
 =?utf-8?B?aWJzR2huZkNMMjFWWEszbms0SW5sQmdzNnljSHVwQUlSZis1OHpBNlppWEZ0?=
 =?utf-8?Q?N95K3OviXaMwTEDOkKjPa9VTU0ahyja2MLKVXXc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzIxR0ZNMTFqTGVRc3IyL3pIckt2KzAzWWc3M01ab2svSy9mMDR0V2VqSlRB?=
 =?utf-8?B?NTNUR0x6RDd3RUpkWmEvV291MVRnSnRrZVo0K2k5ZXhIaFF3blliZnV3aklX?=
 =?utf-8?B?RnU0UEl5eGhWbEt2Njd0L3oxTzA1VHUxdVlPbGpub0JUNEYybFVPbDZ1eWhR?=
 =?utf-8?B?MEpEK24wK0pFQktHYS8zZFd6cUlZN0ZTaUpFQWY0V2RqdWdpWU1wZ1dGVFg4?=
 =?utf-8?B?MUN2aFUwcHBmR3JVc0dseDU4d2N6dG5MUVZKV2NJZDdIWnd5Vmt0cEtwSG00?=
 =?utf-8?B?djFWV2p0SS9JUTFqS0U4MUkxc3QrUEY3YUM3MENUZzFsNzQ3R3k4dHpMcWJD?=
 =?utf-8?B?SGhHNUwzQ1NwY0t0bGFyOGRoZ3lmOGVSc3FFL1JyMmo0L1daYzNaajlvRkp1?=
 =?utf-8?B?N3YyS2VFZi9GdEwxTi9icUNHUVFDMGNxUXYwN1NGWW1Nc2tjMzhLRmk2elU0?=
 =?utf-8?B?cldLVGFtNEVydEZ2NW1kTVBVUWE3b3FUZGVFTmdaUkRWN0VaRmxuUDlwQ25X?=
 =?utf-8?B?R1FvTlF6ME5nUGVSWHU2NVEwbzNjcnhhMHJRRXZrWUcrRGdsdXpaNWUzWWRM?=
 =?utf-8?B?Tk14aE5rUmliUHc5ZkVpSWRWWGkxUEJaeHRQa0s5MGIxQWFMUlpFbkgwdGo3?=
 =?utf-8?B?NnRzUlJoOVRUUG5hQmcyZzFZdk5BMGNkVXZ2V2tQbmw1M05uZDA4QTc1aGhT?=
 =?utf-8?B?ZkFWQ1ZBa2JFU2dxMmRUeDhScGhQSWY0elUxVStiNGZ4YmI3VWd5eUFsVWM4?=
 =?utf-8?B?bFl4MnZhazZSbzBleStUVktsM3FadHpVN1BRekRoaGpYV0d4WU5hR28ySnJx?=
 =?utf-8?B?ZWUyZGlTdHZOR2ZpNmdnSVBPN0Z5TjFDQy93OWlaSFoyQi82aHB2dDIvZStr?=
 =?utf-8?B?VmR6RnF2Mytha283NVFjTXBuQ1E1dURjNER4WHNSZCtObkpiVWVnSTE0SSto?=
 =?utf-8?B?Tkh0U1l3VmlzY3QyNWhvc2lxRkNBZGdDSzVHYnZQWUVrTDZUbG8veXJPc29w?=
 =?utf-8?B?V1RESnRsVWprNWI2M2xMcXREaE5nbnJibllKbTR5YXorQlBpbEZJOUtGMUVt?=
 =?utf-8?B?ekNTYzJYdXhTOE9DV1dGa0lKdlloNE1jaTcveEYzMUwrNFlhZmN3YmdVK2Ev?=
 =?utf-8?B?VGs1TEYwRGFxTkp5ODZ3K1A3N3QzQU9kaXFoREJUM2F4dFFHbWZ3M3BYa0k3?=
 =?utf-8?B?UE9GMmFEMTFDS2FjNlRXQXNjVklCbHZjK3pIQ1gyazBFcmczREtKc3ovSW9q?=
 =?utf-8?B?OXkyaGZ1d1hJUU5VVzZ6VkpIQzFTV2VxNmNORUxJL0FnWU9xK1VlQkE5SHlr?=
 =?utf-8?B?amExQW12OXJLVC9IeTVnemxOZEVzOVFUL0R1S2kyNzdtc1RqaDRaalFyZmFx?=
 =?utf-8?B?QW8vVDBDNmpoTGdxbC9hcHhVVzNQb2FSZC9UUzZyUm50eEZUQzVlaklycVpm?=
 =?utf-8?B?b1FCRVh6dXBGZFR2NGRMN3U2cmUyTTVpR09FYUFiMVA5R3BKOElma29pUVVX?=
 =?utf-8?B?eUFXeHJ5dE5LcWVuV0kzQURuaGhiUEEyb1BERkF2Njl6WDhxZlhqeGZmYjlC?=
 =?utf-8?B?aVRzRU8zejdwOXRSSjNBbjloMFVCd2Z6WVRyQklVN2FaQ28yakluZnh0M1E1?=
 =?utf-8?B?VjRERjJrU2M3RG5VMXFaNm83TmgzS295bkdaTy9lZS96TU1URGdBVVZYTEZu?=
 =?utf-8?B?WjArdVhEZTExRUtOQWgyYms1NmFuYXprTXR0dkw1UitKczExUHpBek0rZHdz?=
 =?utf-8?B?N3M1TWcydmZWN0xacnNEOGFzbUdqN1Y1dWdhTUNvWVhjaVlZSFY2TFZNYU9U?=
 =?utf-8?B?MDBkSlhkRGk4WXkvSmpZRFhvTnh0SUVCNzZJNXJ0QUVmS2t6SXFmVjczYWRC?=
 =?utf-8?B?VkxkUENydTFuaVBoMkJSZ1FlRVdsZHRnRXpObG9WVWw1M0JTVjE5dWlHd01s?=
 =?utf-8?B?MzlOY1JtWnVVVzdSN2NKamUvajNHN3E2QUFla2lqU1RhUGJVdFR5dXhKaFZz?=
 =?utf-8?B?cXVHbENZVEd4aEZsdlE3WmlSUmI0OU1RQXM4dnZyWk1TVkxDUUcxUU1ZZ2NW?=
 =?utf-8?B?M29wM3ZBMlFsOVNKYU4xWFhnR3puVU41NU1kQ2JWL2VFWXVQM24rNVhHcFRz?=
 =?utf-8?B?V3Y1RDNOd1JVOTZtendGSXZqU2tvbzdXUm9kTnR0NmFJUlp5NzY2b2JRYlZQ?=
 =?utf-8?Q?wvEUrWJ8W8tA0hOV5U7U23E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UhFF2/wjmoJjnlIvQoq7U5snJOcH4ejFsCwt/gul3H81h1YUOfxzrGcTw4ob0BbxRzNY12Lf6HpaI00AG11tayvR/odBr2+RhWmDeFvmC7cDs82YgN4P7kkxquT2f4TQKgmEniGRoDo3B1ZOXViE12zyZZ96wrDn+xEo/MMqs6lph4j/YnCh6EANEZyVhSd8X9Mr3ooIq1busRkVqdrOzZRchBd4IKaXdmis7XOooPOME7aZ/QVStpUkwEXzvQmSuZ5oUvMxUXHU02UDRh6at0JuMR5aHvYg035HoMry3lte2CQhLk5aSg91mppkH2pRJ7YtYj39lgSuAsaCwonDBNeR8tTDOklrUoy3W8FQVBXnZJgD/+YM/ln600pcXN/Beo1J+rTbqo4YZcBgsC6oejZ6mvwZZq8BBr5ZonTGEIjn/TH/qWelLleCB8lLfe52fxzujkABwxmsxtz1YsDdIge4r++ueNsPsNaiKDQ7YIFbPD1xWG08TzP5qud4KttcqI/vm0/6vfypCeb6nv80g7nZnOI4OGldikBpXYIsYmEiR139rN96/z0HQqrRV7/6KJMMVUKL0xzCDP9Su8Jm4ct7zAtiygsjU36Q7kL29PA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892e9ff5-f620-4c57-9f91-08dd0243ba70
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:26:47.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etP3OqJpHxWZ6OegCKqltf2/1ezI+5TuZD8voSWIzaqPCxYfqcyNImNX9NnLGOTvcLoNdVIFbQYQ7Qwy3RjQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110096
X-Proofpoint-ORIG-GUID: czgmCQoJkYQRXKrNU_ULlHFKcMjUyRGG
X-Proofpoint-GUID: czgmCQoJkYQRXKrNU_ULlHFKcMjUyRGG

On 08/11/2024 18:05, Yonghong Song wrote:
> The dwarf location checking part of function parameter__new() is refactored
> to another function. The current dwarf location checking only for
> the first expression of the first location. One later patch may traverse
> all expressions of all locations, so refactoring makes later change easier.
> 
> No functional change.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 77 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ec8641b..4bb9096 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1157,16 +1157,56 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
>  	return pack;
>  }
>  
> +static bool check_dwarf_locations(Dwarf_Attribute *attr, struct parameter *parm,
> +				  struct cu *cu, int param_idx)

Nit: I think this should be renamed to something like
parameter__locations() in keeping with existing naming scheme.
Could also include the parm->has_loc assignment there instead
of keeping it in paramter__new().


> +{
> +	Dwarf_Addr base, start, end;
> +	struct location loc;
> +
> +	/* dwarf_getlocations() handles location lists; here we are
> +	 * only interested in the first expr.
> +	 */
> +	if (parm->has_loc &&
> +#if _ELFUTILS_PREREQ(0, 157)
> +	    dwarf_getlocations(attr, 0, &base, &start, &end,
> +			       &loc.expr, &loc.exprlen) > 0 &&
> +#else
> +	    dwarf_getlocation(attr, &loc.expr, &loc.exprlen) == 0 &&
> +#endif
> +		loc.exprlen != 0) {
> +		int expected_reg = cu->register_params[param_idx];
> +		Dwarf_Op *expr = loc.expr;
> +
> +		switch (expr->atom) {
> +		case DW_OP_reg0 ... DW_OP_reg31:
> +			/* mark parameters that use an unexpected
> +			 * register to hold a parameter; these will
> +			 * be problematic for users of BTF as they
> +			 * violate expectations about register
> +			 * contents.
> +			 */
> +			if (expected_reg >= 0 && expected_reg != expr->atom)
> +				parm->unexpected_reg = 1;
> +			break;
> +		default:
> +			parm->optimized = 1;
> +			break;
> +		}
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  					struct conf_load *conf, int param_idx)
>  {
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
>  	if (parm != NULL) {
> -		Dwarf_Addr base, start, end;
>  		bool has_const_value;
>  		Dwarf_Attribute attr;
> -		struct location loc;
>  
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
> @@ -1208,38 +1248,9 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		 */
>  		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
>  		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
> -		/* dwarf_getlocations() handles location lists; here we are
> -		 * only interested in the first expr.
> -		 */
> -		if (parm->has_loc &&
> -#if _ELFUTILS_PREREQ(0, 157)
> -		    dwarf_getlocations(&attr, 0, &base, &start, &end,
> -				       &loc.expr, &loc.exprlen) > 0 &&
> -#else
> -		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) == 0 &&
> -#endif
> -			loc.exprlen != 0) {
> -			int expected_reg = cu->register_params[param_idx];
> -			Dwarf_Op *expr = loc.expr;
> -
> -			switch (expr->atom) {
> -			case DW_OP_reg0 ... DW_OP_reg31:
> -				/* mark parameters that use an unexpected
> -				 * register to hold a parameter; these will
> -				 * be problematic for users of BTF as they
> -				 * violate expectations about register
> -				 * contents.
> -				 */
> -				if (expected_reg >= 0 && expected_reg != expr->atom)
> -					parm->unexpected_reg = 1;
> -				break;
> -			default:
> -				parm->optimized = 1;
> -				break;
> -			}
> -		} else if (has_const_value) {
> +
> +		if (!check_dwarf_locations(&attr, parm, cu, param_idx) && has_const_value)

I think it might be easier to follow the logic if we moved the const
check alongside the location checks in the separate location check
function. That way all our optimization-related checking happens in one
place.


>  			parm->optimized = 1;
> -		}
>  	}
>  
>  	return parm;


