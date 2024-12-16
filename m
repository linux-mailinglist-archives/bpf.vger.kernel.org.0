Return-Path: <bpf+bounces-47042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03EF9F3533
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2509E169BA0
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA11494D4;
	Mon, 16 Dec 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j1tB59Yo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EN44Keos"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EF53E23;
	Mon, 16 Dec 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364958; cv=fail; b=ZY2VhhtI2+UsADW62FhhnhQvESvaEQHbdkSvso4moxPprjIEh/Ug/f6GmsgOTBmaqb3TT90rINKTsIRfYn9T3iK7cEk2hyJC4Qj3vQzAiHc9Zz7sWn4y8vi9vtOMp1qi6+uciFvD3isw4ZP6EhYfW0Gt4o2cY1aq0NuKDeUTa4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364958; c=relaxed/simple;
	bh=KN59O8C8xDv1H8jTPJ9Ul31t10mO0+bxs1bTLL8se9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTsZjanejt9Tjq2kbq64RYi/HFhE5BlJWjr0o7YBWc/9RXG9WRxLsfAzdfSojlGRugAccmoc7mXsI271u8IQyJ18Lz7to+SpUehuPKQyOZsgoPU1pWg5GeBYDTZM8wl7e+1pfQ705M3l49cPKmHh0wP/FfdaTmXMRDkMlIORQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j1tB59Yo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EN44Keos; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtrAZ025538;
	Mon, 16 Dec 2024 16:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LXQcs9FpLLqxhyH4yp+XpbCRNNaJByh28g4YAHHq/eE=; b=
	j1tB59YoFfsw5He90oCBu/Ejk3bU5Da39V6lh0j3mHvl50zcfrgSOmaupxxfOTzx
	Ax1FrdXjkKXVskuBljx8sXQGlZeuI/6BlaNel6W8T/0lnYNNH2on2oVHb0+Xs4IO
	M5Xg9s6Q5ZWnL2DaKF0BSUQV4rrIdAHk30Q42aR2sSRrcVrUa1bu0hcUbDHLuHB0
	Pt8ssjvPE/ABfh50ZQennL2VuEUpBf9wmIMIFcWfWRf9gsEtoa+qLhLnC3GWCOIF
	/EZAMVcsHdJwzBj7p2nY2IqNpdVuPpqgwNUS7ZXCUK0A9nv0qrT/pKbI08yRpG4U
	QymPM7NXKQ4iuKWOi81q9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec3jxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:02:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGFgjLG032796;
	Mon, 16 Dec 2024 16:02:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdfmpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 16:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyBFkAhFbjLOG9x1VWJUJDZqoUhnNnG9h+xhvi5EbYOlnAb2HVhhFLZVTc8cdWCiE8A4l/4VVUCW1eJaf/iZZWm9KUPsec8N9zMTcKOtqsUFbdsiPhQSINl95XKT2GjGggZHt8w76FnmMByROgrRluIYyGHv4ytNHJHLWed8YSholG525WB5tgV5QWGpd5mEaaGzxfVf+tZnPjQ3FeyNwqHWC4IiWb1WoN8SbhIUWrKbQmaRbYZlhI5Wv6a7WEOlYcl4a3suGeHUNKog9Of4OCzJEKiYJs8iBa2idxCL2gboCI2ZyFZJ3RX4xdRe0naC4IynnZS4mW+Yytb7y1dCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXQcs9FpLLqxhyH4yp+XpbCRNNaJByh28g4YAHHq/eE=;
 b=vz88+wsR22HyrYCklkoIG4/usPgd6FP7qiSfZlY92RBOKAYcu8W37e9CR1CnRQSlGBGKhioUBCwv8HkNGvr8W/AJd4jcGCw0vTPp1Y0nHtMVTggAuyOrn+g+ccB0v5NOvj7yR0dNj1FPy2pTAb1OX7+qqf2yTvf+qfu5gJ1Dh6d1tn/uNzMPLx97qT8hq9nKRK3BB5wWaH1hvZt7qQnEQ/3LFPjQgqeSAGZEP0zUjeL6VMN+uqfFihM0oKrBX+t3d7b7y0sOOLK1miSnGpxG2hlhkUeL7oh8267UbIVCpX/jR+vOilqKy6HxlHBzv3fJEJJD7Mmj8LhpgFsHL6T+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXQcs9FpLLqxhyH4yp+XpbCRNNaJByh28g4YAHHq/eE=;
 b=EN44KeosGwtu3hSnHENF9JQAo33FaPczFLk/yv8IT5CUYnX+rpBjXFwmND0ixchOvS+uZUbeMIQB9q7El/ssKdNFX3dQ+BvdCksGTKh5q2p/wQN31QiSyEw3ub/wzcalxDt8EzDObOsDISEgSnSfhwQ2rrs4a1FowGWrUtDNGPY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:02:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 16:02:24 +0000
Message-ID: <b2542a3f-8761-4849-81a2-bd5f046017ca@oracle.com>
Date: Mon, 16 Dec 2024 16:02:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: fix memory access bugs
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20241213233205.633927-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241213233205.633927-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0047.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7081381e-13bb-4d38-ce9a-08dd1deb07ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpOaG1DODJWR2VHQ1pCbnlWZmR5L0dIekFGNGxlVzNQREJPbXBzWDFOaCsr?=
 =?utf-8?B?dFBQYlFoVUNZcFozemdmVDBKYy9xTVUxRTIzY3ZtdDA3RkR0K0s5c3NueGtx?=
 =?utf-8?B?N1lhL1J3RGlPWGdjRU1LUzZDV2RsTkRNb2xiMnJ6ei8xSVFBRXBaZmc0Q29k?=
 =?utf-8?B?QWRVcWRrR0NUOTZ3YkxqVUtnZEw3VUZ0cjhlWUFDZjVuYVVrV0toL1dNMUpu?=
 =?utf-8?B?eVJ1am91MEs4MjFsMzUvVnRYb1dHWDdQckptam9zVWtWaU1GV0N3MVR6R0Y3?=
 =?utf-8?B?UlI2bXZ4ZC9OdzVvYVR5TE9SbGRuU3NXbVBBMXVucWFkenQyTTBQQWJtTHZu?=
 =?utf-8?B?SVlpQnlDQVpmb3FMY0lwRGlwUG5FWmtwb0R0NGtRWExYdUFMSSt3dDh0RUUx?=
 =?utf-8?B?WXlKbEdLUjVvc3VHM1NFdGF4R3ZvYzNwRXMvS2VsZ1FGQ1Q4QWhhb2ZhMWUr?=
 =?utf-8?B?ay9MTVNZVjR1bHlPU0Vyc2szSHRnNWhwL2p2OFZoK3ZaWVBqVjNScU1qeGp1?=
 =?utf-8?B?eC9CZFp2NlZySXlxZzVzemxJQjJFKytXU2dYS2RYVmU0eWZsZEZXVHh5L2Nk?=
 =?utf-8?B?dFp0a0kranpkOE9iM3hBN2ZXR1ZCV2NEaHBacWUxZkJGcWFyQ3hhcVhOMDFx?=
 =?utf-8?B?WVo5WUtaaEtuZVN2cnNVT1lrKzhobXdNampvUDYyNWtBSDhWOXAyeGJHbW0x?=
 =?utf-8?B?eXJkZzVsbFhTNVRhOTFUV0o0MzVic1VONU42QlVoSTIvTFZzMTZlc08vWUQw?=
 =?utf-8?B?bnl1VURtNHRGTVJTSE1NamQ4VHFEWWhubytvQUs1YTBJWm90ajJEb2ZSRlpQ?=
 =?utf-8?B?VkIrVWRMTlZCMno3MG5rMGVITGdZckxETTltcGpMc2dvL09OL2YxSWp3Z3RZ?=
 =?utf-8?B?a01DUTVVS3l2ZmlJM0Fua3VKM1RJUGpEK29qNExSUUViTDYzNTNlWCs0WXJh?=
 =?utf-8?B?SXN1NFREQlVVZStVOHZiaXBDYU9NSkR2RzNKTE92NWFMeWdYTkpyZXQ0RUdI?=
 =?utf-8?B?dk03S0ZWUmlsbm55ZE1qcnJ4OThnRkQ0ZTlJWnVwdmppMWxhUHJuMFQ4cHBj?=
 =?utf-8?B?ZmhvcjNXQTY0TFNiQXVjK1NNbWlQSHlBTDk2ZnV2N0F3TzRuRnlrcEowUFNG?=
 =?utf-8?B?UG5TZ2ozNHZjaUhNOCtQNzVubXFZY1V1QkRWMUlpOUltajZBVk9tVU1oUzRt?=
 =?utf-8?B?L0pHMWJEeFRUL0VRd0FNMXB4YkE0NHNKKzdwblJxYVN5dkhsTTduNExwcFk2?=
 =?utf-8?B?MXVLekNuTnNiNVVvRFRGVjdncU9ST01jeXorWEU1eUtXZjNVRHkra2RrNmRh?=
 =?utf-8?B?MWwyWHNnbW9JWnVyRFY5bXZ5ZlJMMW5rSTM5aUZnc3ZGaVF0UXZQa05FMXpF?=
 =?utf-8?B?ZWZITGkvQWdBYmk0NTZNZ1lCMmtkV2ZnNkYxb3doUVJFV1RzM3AzdDJ1V2Rp?=
 =?utf-8?B?c1NSdms2bkpaMFpSeVpGY1d4Tkg3MFZESDVva2RSQkpIc2pOTWVPTG0ra0Va?=
 =?utf-8?B?cnhNcjJYTXJMbHEzbnB1cW5UNFpTbllqUFVIeXpRbjlCYXFROU9KeVVWRi9T?=
 =?utf-8?B?a1BPOWhmRGtkQlp1UG9NWjRJYWZpMWhXOVRCN2U1T0pNR1ZoU1V6ZDFTMUli?=
 =?utf-8?B?b0FDZEN1ZnJvbEQyV3V6d0dDU0JITHVIU1RSZklnZmdiR3JQNkZPMGZWdE1V?=
 =?utf-8?B?a05uQ0k1dmpzMWV3WDQ0MkNZTHZlcGk0aEVEdnJyVS9VUlZ4M3FPTkoxWTRI?=
 =?utf-8?B?bG0xMUExbjRFRGZrdklMUENSai9Tek5ic1JUZGpYbmxLeW5LUllRQ0o4N3NU?=
 =?utf-8?B?WGJCeVFZMjNKMTJnVkFlYllmQWw4K3lQb0NYa2cwZng2bEZ1eTk2UmRpRUVW?=
 =?utf-8?Q?VnUSfxFCFG0rt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlJGYzdPZDczaWhXL0RKZG1ISFBvakRLOFQ4MVgrcldqcVMwWVVOa214ZnBR?=
 =?utf-8?B?MkQwcE1qb1lTTHVka3VNN3ZEd1VLSjl4ektvalJzSEdqeVhaOUQwS0s2akdS?=
 =?utf-8?B?cXhDcmJQUC83Q2J0V0pHTWlhSzlYV3ZnNFRFbmYwaU96M2RORFhEZ0ZDYlN4?=
 =?utf-8?B?RkJWc3cwQmYyTk5ZN2t6MVNkazZsMU9ieTl6b0d0YWNUNVhEK09taTI3T3JT?=
 =?utf-8?B?OUxoUGVUdzdESENuN2lRTnp5OGV5R0kyVWkzUWNOeVpvK3puaSs1YVk5U09J?=
 =?utf-8?B?Y0p1RkFYbjA2Tno1UTRiajZPQnJKV1RwYWwwS1dYZlUzdC85YzFlQ2Nza00v?=
 =?utf-8?B?Q3FwM25rTFl2U0NsbndrZ2RKVmRySmF2N2VuTEZ1Ykd5TkRPZmJvNjN1WHNn?=
 =?utf-8?B?NndMNWt4SFJjUzBXeFZHVEF6Q2dQRDQvSDZxQkhseG4vekk3SU8vbGs4N3Bx?=
 =?utf-8?B?ZXljcVVXVkcyNWdreE5pa1FYSDRmZ0UyTzE3eXh6Y0pBRE1kdTdvZ1ppd3Bi?=
 =?utf-8?B?eWZIR1MxYmZNanA2V3U5WFlyWEtoRjc2eVprQ0FQOGl5cngyWTZJb3p3Q1Q1?=
 =?utf-8?B?MWFrNXhDNzZDcXUvVnBOTnl0bG5oY1VWWTZNMzkyV0tXeUlzY3N4MW5EUWZN?=
 =?utf-8?B?YUF3emMxQ1FVeExmTXNMZjh6NDU1dzhXWERyOGlZd08vRVBNV2RGOGgxc2xH?=
 =?utf-8?B?VEVmKzFlZVB5b3owbUsvZ3pLQVlYVUg4L2xsQWpINjMxZmZPRTlFVG9lS3lX?=
 =?utf-8?B?Wnc2ejdGNXVDaHZQVlR1MGRKSTdlU2ViZVhKNXplb3E2ZmNTNlUrZXNDT3JQ?=
 =?utf-8?B?SjZZZHVmNGo2U2ZLM0RzaUl5YUtjZkgvb2t3Ukx3Mkl5VDRCUmJERmtDM1Bj?=
 =?utf-8?B?UWp4WkhnRmRpdHhaZWJQK3pwYjBrOVlsNkNod2xadVlNc25mdmJjdUx2VGxY?=
 =?utf-8?B?ZjdyRnExN3liQlVoaWxjUFBuSmtiVnJsdE9BNWlMZjBXVjVoRU5QaFZpYmVY?=
 =?utf-8?B?U2dMc0dQS0p0M25pV0tWRnkvbm5PWHpWN2Mwc2xhT3VQWkJTNjBjYW1rM3hX?=
 =?utf-8?B?UlJFZmJXbnBZY3E0WW1qdHg5QmxrUld6SlRFdy9pWWdUZnVNZ1BvVjJFUkJG?=
 =?utf-8?B?S1dFMnNVMWpiTTBlWjJBSnM1OW5XYktrTEhobXJjTmMvSlFrcGd3NU4vbXZN?=
 =?utf-8?B?bEpHU0NCRDFMK3R1T1YvbU1BWE04MkFnT2RydW9xc2d5MVhUdlhuVVV3dHhz?=
 =?utf-8?B?NGpsYU9JN1JuN2w2MWNWWnFvRXVHYTFNVm43b25XYWVBNjN0dk9CYWl1TDVH?=
 =?utf-8?B?UHlKSkVIcDhUZ3BVODVSbU5ZNzVocU5Hc0QwQXQ4Si9FRGNxbzdZekhIR2Vl?=
 =?utf-8?B?R0NqNncyYTJubVFQclJHK3JlUWhIOFVYWk95ekM5RXN6QXQ4cklJMDZRT1NS?=
 =?utf-8?B?UCszVmd2a1UvTWMyWnhobGFvdzJnN0pLZVY2elEyRXpoaklvbllhTjJpN0xV?=
 =?utf-8?B?QW5uZzk5WXA4dndncnlUdmZNMG04VzhsaEFiSk4zYlZubjVwQTE4dHNQakhr?=
 =?utf-8?B?RWpCZEtyNUtKUHJLOGg1aTNtR1NYUlpzTUNjR0VzVitiMHRqMXlXRDAzWjBC?=
 =?utf-8?B?cUx6YjBkR2kycVlhbXpvRWpER0V4WGcyRE5iMzR2ZUI2S2R2TFpjbVRuQjRI?=
 =?utf-8?B?eDdmTDQ0dXFSdFR5eFN6RWordWJ5TjZRWGtvdTdNYlJJMkhUMzZlUmYvUTZZ?=
 =?utf-8?B?NUQySTVRQVIzdnB6NHk3eGkveGh6dXFaQXUxbXkrREhwdE95TDdHMjdGTWp6?=
 =?utf-8?B?UmF1WEw3L2NPN0FmblE1bDlsb3pSRTR3QkFJV01xcGREMVAzK2lYL1pWbEZD?=
 =?utf-8?B?ZEJ2SUV2MkVOREpsUXRjSDJ5VkF0WmM0NDVETWFvSjJ1M3VzVmhVVG9pWFpK?=
 =?utf-8?B?R0VTSGx5c2hHczJQa1QxelVISHduN1BpaTY4eVVrcUFMRThuOE5kdi8zL1JN?=
 =?utf-8?B?cWVRNnNaZFlUbDRPLytZWkg4ZjJpTHRwdk8ra3duc0FzSkQ3ZnZlUFR0Tnpj?=
 =?utf-8?B?aEFkZzRmSFdQMlpEVHM1N2hhU08wU3p5MWd5US9vc2lFcFQxTGhNakRPRHR1?=
 =?utf-8?B?cXlpS1gvN3ExWkU2N1d5ZHF1ekZBaEI2cTc2YmFURmJrNjBUZXBGWEIyUjFq?=
 =?utf-8?Q?KacItN9O/GkwP3UZBivfD70=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QET1FCB5KPIwdiKr3b9Tb0x6QS7jckKswwpX5E6DZOFh1iNfcjajWOW2lZoyBx2mFCkftUEEGTj9jM6ukXF3RahFffj+RNdtH5Ul6bzMMwEAgycWhz9T4KCLSWRXFox3vhZCgi66KtN1ZRbhaFOjZNyABLRqxjr+7pMBwSAghawhRKJV1pZG6OFqy4t6Mlk87Oz6RILmH8HZo9jq9nmVoyZpR+XXj+yD/R5dXzhYf2IeLyvDJgh3MRecL6dmSyh/Hrz4cKok+7Aj9EC+JRIKtJ2WmSPrA4LQCYtZgvw8fLWqXwBdQh9ngnxpQZs8r75wZx2ROpyteeDr/LaDX0fd2dtJbaVjw/cVkFzNU0marfmAB9scnA0DObMOUvNa9oTyHHPP01dEtK+0s6yg09cS+d6WaEuM9SeB0ogGIzgc3cOj4u7sn9VLcTdXhSt6qC5IOmpgjnWcKL4wA8FIz6hL3j4HabxfklzD7a1YVraGcymVce9HjOR8rK1Ac06DIxHw71ByV5ueiD5Id5NIB7jhTmoVQVqXATE6eY3tOifJOdjag0fYAnj+jnMVxz72oYyCCHi4lwsQmSCUxpxAi7d53sE4j9seFIXUa5ImAl5q9H0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7081381e-13bb-4d38-ce9a-08dd1deb07ac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:02:24.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9BNcHubuzQp26swBGlvx2rB9lMcd995RqFjkFraCMtHJTCv1dziROqxDmY2zRg3HfoxR0zimNRn44Qcaba58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160133
X-Proofpoint-GUID: uHf843fWi-tLwvoqDo3kOyD3JBvnfTcN
X-Proofpoint-ORIG-GUID: uHf843fWi-tLwvoqDo3kOyD3JBvnfTcN

On 13/12/2024 23:32, Ihor Solodrai wrote:
> When compiled with address sanitizer, a couple of errors were reported
> on pahole BTF encoding:
>   * A memory leak of strdup(func->alias), due to unchecked
>     reassignment.
>   * A read of uninitialized memory in gobuffer__sort or bsearch in
>     case btf_funcs gobuffer is empty.
> 
> Used compiler flags:
>     -fsanitize=undefined,address
>     -fsanitize-recover=address
>     -fno-omit-frame-pointer
> 
> I stumbled on these while working on [1].
> 
> [1] https://lore.kernel.org/dwarves/20241213223641.564002-1-ihor.solodrai@pm.me/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Good catches! Two nits below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..520ff58 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1793,6 +1793,9 @@ static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct go
>  			goto out;
>  	}
>  
> +	if (gobuffer__nr_entries(funcs) <= 0)

== 0 should be fine here since the return value is an unsigned int

> +		return 0;
> +
>  	/* Now that we've collected funcs, sort them by name */
>  	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
>  
> @@ -1954,6 +1957,11 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  		goto out;
>  	}
>  
> +	if (gobuffer__nr_entries(&btf_funcs) <= 0) {

ditto here

> +		err = 0;
> +		goto out;
> +	}
> +
>  	/* First collect all kfunc set ranges.
>  	 *
>  	 * Note we choose not to sort these ranges and accept a linear
> @@ -2607,7 +2615,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  						       ", has optimized-out parameters" :
>  						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
>  						       "");
> -					func->alias = strdup(name);
> +					if (!func->alias)
> +						func->alias = strdup(name);
>  				}
>  			}
>  		} else {


