Return-Path: <bpf+bounces-30093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A38CAA8F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 11:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B56C1C2185C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A715676F;
	Tue, 21 May 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoAmuXWH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f7sQ2vpx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475A2EB1D
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283002; cv=fail; b=r+7rGkTy44VhPnXBgb44M9crpfZupKJiLy/VXcRfc1DYMXfD8spkoevlF035vyfxQ+x8YOCk9IdTw8Ysr/QgQbgL73V8BizX6smxykfOACYPR43kWJTN3kT33xZD/t/rLrWP29otdimXF0EH/BCbDiDKtkYcwjYNdpLY7LMxLcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283002; c=relaxed/simple;
	bh=/GgwC4HyH7KP4i0hOayFHJMzA9S21yoSNcSr6gnG0vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d98yUCB/Q72XR2z/t9FPgw1DUArL6oRrPsQnjh1+tGiSIh1gUyuScZDR9IlHHtD/2CSq5oUNhXC4tCjSShtAHPCGU/kUq8ElCWwFnAWapaTWN7WikT+cHhvzlUjftW4umOVgnttEAZl9b5vBHfkQkeK7eEw8J/7xsFr4ohFj6io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OoAmuXWH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f7sQ2vpx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44L7xbYS023200;
	Tue, 21 May 2024 09:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CbX1NtkSDBSpYN1seGgSxwpm9n3S1ddVQtfvF4gjERY=;
 b=OoAmuXWHtEVBuEBRcb5p/LiYeu2yUURXYeXp1IYJXqfbzT6N3fNjFusLXlQ8kfjiI85w
 p+UQt5xApMMBakMW+XZnP9NDQ6Wt2ciIGjnQfrixRKWmPT1PKR4YCYbThN8aSM2NZtaw
 CM75aNwf+8R3PZ/0Yy0WJ0wDSL2dojPk7Zj1MJd1tcvJCXF3KJsCkbXaZ/GrucpRXwWS
 QAG+6QOqSERQP7Mpcnyn0F6k0QoU0+YSiuI05CABMgEvBbF0Ocod1/8f15QzuPlnA6YN
 rKDaotMszFCCr6I5AYVnwer5zdf4vVHt2SRcKElcU0iezp77sIlDI3cavhJH9nG/z7hv HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b4gys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 09:15:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44L7dxQb002381;
	Tue, 21 May 2024 09:15:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7e1cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 09:15:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7uqCg5QvXN7W/11rDmpLNaVOdxdh7mqxO1grqY8wji6igEvp4qNZuV0NQGQlli0AMaG6DTqgHTtTZSzPbj+L+192ZnlaX1oboW9SMv5SlyNpgKrzzCyzePXgTZNIs3hqXy7whFAzP8HSANoeCUZgfEN/5JCNZeDUVcE/K9yhnVl9lcNzWaOs5k+/GkOsGE6ndyZkTpWs4Q7FFFrdVHgxRUeNzY+o0oGAMngZcFVK3OagoBVIlU0eIvbMt7dzbwyb9U9Ysi8cMu6LjGmbqEvFF0s6iwrtmhntCrSYKnaIWE7y4zKuw8EyWG3CEeFq/q5FOatwMWr7UuuHhStXzt6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbX1NtkSDBSpYN1seGgSxwpm9n3S1ddVQtfvF4gjERY=;
 b=QtMUut8h2ByoAiSkuJj1jCTsbI2mFSbM7SMw3t3IObFlbLFUiqVlKrWrFp6lRixTrUvFi32/kCDHDaCM7Ruy1cs+1n6tIS9Fx1QrnMJSSg10hz6VrkDix/MllygdwknqlZFEfSvuP6DCE5GidUzghdsgh9iIpH4JhgiYFKhKFfZhhtsQo3IeZk4oxCwAWYC8zIyYEoRD42VFPzP9QbuRC39BxV81WHOx9FXP8yPNbkGFvCkDtHORFebvoemE1KkQOmWu2yW2QDYxnUiKAI/HLqo2sfDqAQK2aOj/8PG5MM+7ChjnS2ZtIMGgHxSG0VA0KoDPMefKkiSEQirLjSpBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbX1NtkSDBSpYN1seGgSxwpm9n3S1ddVQtfvF4gjERY=;
 b=f7sQ2vpxpa6XDSdhyImPNNSt0Oa2gBVGrNc93yzSixWpJrpC+7JRtoiVmjl20K7ATExYXCTmkYNj+cm3LX9MWyu5V1pU7wbmN4PkeN4A3aBfIJZF8iR5ea0bwAlxHB4GHsO2GntcnnSYArzP8L4wN9CaA2jMKczsZAxWDuUNqko=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 09:15:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 09:15:53 +0000
Message-ID: <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
Date: Tue, 21 May 2024 10:15:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ecd0ce-9efd-48f4-aed7-08dc79769d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmNTTm9salZmZFFaaFk4NnhLK3h0R3VOVVJtTy9JZHd2ZE0vV2p6YnA4RFVr?=
 =?utf-8?B?TlRmQWg3R3IveThYVHI0dEZnSVZzNDY1cGt1NkJTd3AzbTR6L2lHUVpFbE9j?=
 =?utf-8?B?VkhVL29SblBtYzNZa3granlWd2FSMGZFT1NHUmxmb1ROSWVLa3pudzVuUStM?=
 =?utf-8?B?SWkyMHMrL0NUNU1hMlhoQ2RrZ1lOZy9VVXhGbmJJVWF1djlUdzV1aXZza2RD?=
 =?utf-8?B?eVpIaFBEVjVxQTRyRElDNCszSXYwYU1aWCt0cTVqOThNdUNlVlRhWmtsa3Ar?=
 =?utf-8?B?UXN2Smw1TEZBTm9HQm9UbTNDS1FHU25FNkxlQzVHTFNna1VTWVFPczFLWFB0?=
 =?utf-8?B?dE53WnZYWGpMcnJjQXkwZGkyR3NkSHZ2bVFBelgvUEtTcUtJVzk4d0hOdXBQ?=
 =?utf-8?B?VkFEcTRNUUNZVkcvN0prS1YrTFBTVEtuS3JEWGprUERqcWY5L2xodXBjYmFT?=
 =?utf-8?B?d215K21aTDRRdFg5SG1OTTlDRVo2Mkt6bUwwLytMZE03eThPMHRxRXp2dndv?=
 =?utf-8?B?NVlGSENza2pPM3BuWDJTekc0WnJGQllwSFZYUmlJN2NSVTlQWjZnTWNRbjA0?=
 =?utf-8?B?RWdzdE5sSytvOEFnODRGTFFBZzVWM0FldjViY21BaE9kL3k3MTJpRFNJUTVT?=
 =?utf-8?B?VW5SM2FHOW1ha3djcG10bEpVWTVsaUpqeU4zZG9aMXE2TG1STlByZHNVc1F1?=
 =?utf-8?B?YlFNR1Z4K0lvSWNMSC9Dc0cwbnpUek1oWDhuYmFrdDNORzIvcDNFK2w5eXZM?=
 =?utf-8?B?TGwzT0ZDRnordFZCQWF5Ujg0SlRJWlV1NnBvN2lhRHhaNGFOT3VLZStuTUpy?=
 =?utf-8?B?ZVBuMWRFRGh6R05lc2loeFpQdi9XSlJOeHFRM2ROYnhwbXJEMU9EeEE3bktq?=
 =?utf-8?B?YUJ4bVdBOU85Q0MxYTBZdEk0Z010NjJSWk1YdHQ0TldaaXc1S1lyQjRLbTAw?=
 =?utf-8?B?Q0Y1NXA5WmkwQ3p1d2l6M3MwVXFKaVlLaHZVQUUzK1BGWTUxeitSUW9QeitR?=
 =?utf-8?B?QStVcklhSGJKN1JtTUROTGtscmhiMkVBTGVOQkRoby83bVRUbVJ5TDBqamdH?=
 =?utf-8?B?SnFyVktWZWV3Y3IvbHVvaWpWT05WOENyVytGcEdTZGxjc3Rrc2lZS0lFQW9O?=
 =?utf-8?B?MTNiTlNUYmJ6MEJ4YkVWNVBKdERLc0ZOWGlySXJWR0UwUzZyK3huZ0E2Z3I1?=
 =?utf-8?B?L0ltdHNmMmo3d2M1OVUvR1VWUjQyZXZIdUdoeXdOVENSUTBkM09oVXA0RE80?=
 =?utf-8?B?OVo4dU1XNTlqMEtQRndwRGF0cER1SzlVdGdnVlZiQXh5L25WbFBuNG9OdjdT?=
 =?utf-8?B?Zldja2ZRcWhPbmFpZTQ0S1k4eFdBQWh0WXNlTjh1UVlocHd1d2I5M241SU53?=
 =?utf-8?B?VUN6bEFGTHhseG02VGpQSkRXL09udnIwcmdLMmxkcTFSWlFqbFEzYlB0cUda?=
 =?utf-8?B?NUM3T1NDc1ZqRjRqVkNqdEh3REIzcGt0QzlhZzQwM2tjWlcxbFZkaXBueUQz?=
 =?utf-8?B?SUs1ZnRYQ3owYkNJMTZTMlJTWlRHMXJGcXg1N2xzS1hFVlQ3L0Zxb3UzU0Y2?=
 =?utf-8?B?eEpUWU5yMElTb3U0cWxNdnlsR3hCdzU3YnBHcmE5OURHQ1ZXcWErTGFOL0x4?=
 =?utf-8?Q?bR/z513GttV8VMxOXHSqfAxEHZxSJu30SkX9FH1zWEr0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3FUb0JHazBYWnFYTUY2OXE5Z0d3SmZxaFBKZmFTbldNYUVYR1ljNlVNNnhu?=
 =?utf-8?B?VGhqMnA1eFNDTThtQWhONGcyam1RQndrUEc1amVzUzhEMjNIcWs2M1M4WU5X?=
 =?utf-8?B?Yk5NdHMzQys1c3FmMXhmSWNIQW5CQUkyVzExZkdlcmhzWldQbGhpRGtFeThW?=
 =?utf-8?B?MmwvS1h6SllUanIwcEZTTWJhVHN4ZGdjWmsxTzhTazNXYXRkbWVaQnA0eFBk?=
 =?utf-8?B?eWora2xRK3d1NzZwSGlSVHU5eVl1K0JkZ0JFSkJQUlk2Ry90cEZIU29uSjJZ?=
 =?utf-8?B?NHYwNWdqdXY1NERNcGV0c3dGSUp1WHFUUmZGWHFGRlN2T2dOb3c0RnJDV2kz?=
 =?utf-8?B?UWJiYlR2b3pDMVl0dmpicll3dk1pKzI4bmRhL2lrVytqanRGa2JlZVdXaWZa?=
 =?utf-8?B?Y2JsQXcrWmI2NHdDSkRIRnJlenp0WTVmRCs5OWliR1QxazVSdVd5Y2pvblNk?=
 =?utf-8?B?NlllalpYUjc0Ry8veEx0SFVYc0tsRmlPSSs2N0VKYU1nTUtGc1ErcWFpZ2l6?=
 =?utf-8?B?dE5QcWZYeUNLVlNVTDdtVUNiWi96aDJBdHJYWnI0YlE2YUl2OGo5bjJKNTZP?=
 =?utf-8?B?V3UzNU5kaXQ0MTFEVitmMnJ0WGd6M3NZUVZrUXZ0K2hTaWlGVFp1L3NMcjhz?=
 =?utf-8?B?RFBBWWtIWjhSclVxc3MxeGxrdDNYZS8zWEUrVnJ2NzM2RFhuOGRzaC9NWEg1?=
 =?utf-8?B?bTVpQ3RDNzRnTFpqVXdHNDl0TVFuMmhpandtSTVqTDEwbWpXd3g4TDVxeVJl?=
 =?utf-8?B?WFo2VEhqSXErM0lRWER6TG10OXY1QzVwcFZsUC94ZUdjcEJqQTk1YlBESkdq?=
 =?utf-8?B?L1N6eU0zNlJJSnpzRStPWHF2b1dReFRxZWZXVTU1RGlEd2dzYjhkOGpYaHE0?=
 =?utf-8?B?cHVHcEg5NjN6VEtnMmhWbTZmUEt6YnFFL0kzR1RmajZud1BxblFWdUhjWFVH?=
 =?utf-8?B?d2F4TFd3cHRDdm5MV0JhekpQZExxMklzU2R5VFMwczQxNWIyNGd2cDROdkYw?=
 =?utf-8?B?NW11UmxULzl6VnMxaWFtNmluYUJuanp2aHF1S3YwMGxjMVUzd0xSS2FpSmtQ?=
 =?utf-8?B?c3lSM0FuYWdJaTRFa3hXc2J4dVcrYVJwQ0VMR0d1aWdKYno4a0E2RGFqM1VJ?=
 =?utf-8?B?ZlNraGZtL3U2YWN2VzZpMC9QdFZMeWh1OWs0WkZDYlhIQXBSN0drNDJPdC8w?=
 =?utf-8?B?WWgzYWd3RVMzbmIxQVNTMjUrVWJyeG56TzZ6ajZ5TGhxZDJMYlhNVmc3YnlX?=
 =?utf-8?B?ZEdXTVpqdStCWjEyOE13b1QzNllZTGN4aU9iZjFBdUNPcHZmbFZ0TDJOTUQy?=
 =?utf-8?B?LzRxQW5iL3R0R1V2Zk4rRTF4cFAzNWNmRFVLRWRXZmhkRS9UNzFjaVZIdDZY?=
 =?utf-8?B?NDRhYU9IeUttd2VNL0k1UkRlcFhCNUFKVWkvYUZDUFNaZzBDSmU4MUM3Nlcv?=
 =?utf-8?B?RmptZTNwaGE3Q1A2bjErOEZHRHAxcnhraG1kci9vR0JicXgyelQyakl0SXFF?=
 =?utf-8?B?QXVZaU5wQzV5N3Y5RDFRTC9wbVN0cEUrVTluTjdQNStOWHU3dGlueWVpaFFZ?=
 =?utf-8?B?L2tZZnpJYmVKYTBEaHl6SXRreDdXYk5lNHNNY053dUI5ZzdlRzk3cGxWMDEw?=
 =?utf-8?B?MmpsaTJRRFhVUDhWZW90eSt0dVR4b2tBSVdiR1dudG95Wm5oZ3R0ZWhwc242?=
 =?utf-8?B?S0RBd3JrWjh3aVNhZm16dHNRSzNUaFYrNmpUUDcvOXZHSDZVQXBsZXdjektU?=
 =?utf-8?B?cGxkK1ZjYWdKVmllNTR5SkpYdjQ5d0w4OWZoYVhSZnBIYVo1TGZBUkNwdURL?=
 =?utf-8?B?UzRCb0ZZanEzall1NTBJOTI5SXIxeFJYd0RKOFc3b2NYT0lodlBSenVmdkpJ?=
 =?utf-8?B?aGJTN2t1dXJZNHlYRG1FdmhrdnlubFJKZU15MnpPT2g5eGtxb3BOS1dSYndH?=
 =?utf-8?B?RUV5M2hYbVp6S213cTVsV2NsNHlLRlBHd2lDSnBvS2ttSWNYcmVGQkpnQmky?=
 =?utf-8?B?bU9hSGVQdndOK0VWcFFiTTh3dHhGSmk5ZDZOWjRLK2pnK0VNTkw5VFJBWXdF?=
 =?utf-8?B?Mi9pMjk4ZjZUemFmS1kzeDhPYWw0UktRTDFkY1BmRDVON09kOVptT0docnpZ?=
 =?utf-8?B?ZU9HYjdwazdFNlJrU0N2SDh0aWNlZS9welB3Wm9ObFVaazZoQlBjbVEvbkt3?=
 =?utf-8?Q?1xRVDbxtuJFlPaR7hopEpdE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DyRupTqpKpg+rFjorboFJjnzzo1oSOZuKCygBsZesZYIoJ7cRVE5SIbbAI7ewjOYlilnqR+Pkb5B0r1OGBdDyf3L6Pd2p0E7XDG4WYEr7OHhmIeIzKjHHUgE+uNLDkMiTOPn+BQkQ+DeP5Ym2usf/HsqKml1Tqzj/Ml2LAYxZ+wVwkHtfPTIxq4A9+p7JlZwteP54GYIciGW4HW8RlqMcXJf8LNBGx5ZUvQqZ5XE0+mliR21Yr7ndn7/1eYNCKfivqnOY4XlJBbZLOgXswXuM1j/szWJ0vhnCfWwVVq34Ofds1myYKUBL7f5vhLjek9q1mi8t6dyd5LjiKW2Ga9Z/H9PEMwn4kiFbYMKm98NQQhIPZaRgo1qqj96RdB7aMmFvi1WofHnqv8p1hDjP7FK/M9B9z6e1pPmH1phkcE4U1/2GvpL8GD8QEQhGSq9hEaOxOhQs2jdilOJncexxhU8nIxlosEFbIqQkrAGJMlLrrdwcwR6ok8Ol2NDTSm4G/XuVH5w9oOSslxQ+hLRWwzhjAApvgfjeoWcCuOvjyUDe1+HWaltnao/z3Pq9Isgbm8ssFuFN2Csuqpm7fngLZzEdvotWh6Ew7mPp9z9DY9/bFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ecd0ce-9efd-48f4-aed7-08dc79769d8d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:15:53.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6GOHr2lVrt3cDXWOvegkiOyxLL45n4PKfGyrb0PgNbcuRDqeW0LaX22MRLPLmNWcmRVKmqWnQbP88wKgJM0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_05,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210068
X-Proofpoint-ORIG-GUID: ZKALw_u3wmN-CRSoStNInHtnGqyT6taN
X-Proofpoint-GUID: ZKALw_u3wmN-CRSoStNInHtnGqyT6taN

On 18/05/2024 03:38, Eduard Zingerman wrote:
> On Fri, 2024-05-17 at 11:22 +0100, Alan Maguire wrote:
> 
> (Also, please note that CI fails for this series).
> 
> [...]
> 
>> Also explored Eduard's suggestion of doing an implicit fallback
>> to checking for .BTF.base section in btf__parse() when it is
>> called to get base BTF.  However while it is doable, it turned
>> out to be difficult operationally.  Since fallback is implicit
>> we do not know the source of the BTF - was it from .BTF or
>> .BTF.base? In bpftool, we want to try first standalone BTF,
>> then split, then split with distilled base.  Having a way
>> to explicitly request .BTF.base via btf__parse_opts() fits
>> that model better.
> 
> I don't think this is the case. Here is what I mean:
> https://github.com/eddyz87/bpf/tree/distilled-base-alternative-parse-elf
> 
> The branch above is a modification for btf_parse_elf() and a few
> reverts on top of this patch-set.
> 
> I modified btf_parse_elf() to follow the logic below:
> 
> | base_btf   | .BTF.base | Effect                                      |
> | specified? | present?  |                                             |
> |------------+-----------+---------------------------------------------|
> | no         | no        | load btf from .BTF                          |
> |------------+-----------+---------------------------------------------|
> | yes        | no        | load btf from .BTF using base_btf as base   |
> |            |           |                                             |
> |------------+-----------+---------------------------------------------|
> | no         | yes       | load btf from .BTF using .BTF.base as base  |
> |            |           |                                             |
> |------------+-----------+---------------------------------------------|
> | yes        | yes       | load btf from .BTF using .BTF.base as base, |
> |            |           | relocate btf against base_btf               |
> 
> When organized like that, there is no need to modify libbpf clients to
> work with split BTF.
> 
> The `bpftool btf dump file ./btf_testmod.ko` would print non-relocated BTF.
> The `bpftool btf -B ../../../vmlinux dump file ./btf_testmod.ko` would
> print relocated BTF, no need for separate -R flag.
> Imo, loading split BTF w/o relocation when .BTF.base is present
> is interesting only for debug purposes and could be handled separately
> as all building blocks are present in the library.
> 

This is a neat approach, and as you say it eliminates the need to modify
bpftool to handle distilled base BTF and relocation.  The only wrinkle
is resolve_btfids; we call resolve_btfids for modules with a "-B
vmlinux" argument, so in that case we'd be calling btf_parse_elf() with
both a split and base BTF. According to the approach outlined above,
we'd relocate split BTF - originally relative to .BTF.base - to be
relative to vmlinux BTF, but in the case of resolve_btfids we don't want
that relocation. We want the BTF ids to reflect the distilled base BTF
ids since they will be relocated later on module load along with the
split BTF references themselves.

We can handle this by having a -R flag to skip relocation; it would
simply ensure we first try calling btf__parse(), falling back to
btf__parse_split(); we need the fallback logic as it is possible the
pahole version didn't add .BTF.base sections. This logic would only be
activated for out-of-tree module builds so seems acceptable to me. If
that makes sense, with your permission I can rework the series to
include your BTF parsing patch.

Thanks!

Alan
> [...]
> 

