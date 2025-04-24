Return-Path: <bpf+bounces-56574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712CA9A4C5
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 09:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68DF9234B4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0F1F3D44;
	Thu, 24 Apr 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGgFOESV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IkEncoaH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88E74C14;
	Thu, 24 Apr 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480963; cv=fail; b=fWyQ7aRpJ0yutDKld7tT2BQ6MpOxKpX2iMQkWsxmLUjX75fu6nWhyTzwWEjjdlmX3zWFyanwA9Skw6hN38Bfamf/LfVN4V2p3geWdPN9A2XY0KuBfRTmsLlPkztqRwisPPtkya5nyK8n2XoiN8Dmz68Y38vquvBGEa1oz8yY4lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480963; c=relaxed/simple;
	bh=N+gzwA7u6m8SQyivrCNROw/dgPVnsWrLFNqLvyyfyJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B4p8SFDs1dQJaDHaa3/f38rVbutA5FrdF20iTyYz4WdWnMUTjfrzcl9Bf3MUM3mI724Ibv5rGW1+AzEa6yGEDyHxhPq7feUXY65utLP+gpInBVcAMJMIKwiEptsPcq8qhNH1S5YuYacbIuCXP0a5gx0n4HNDuRc/UHWaNke/Qx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGgFOESV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IkEncoaH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7awmc008933;
	Thu, 24 Apr 2025 07:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cmEwAgyrS7xSOtIdh/JG8JGBZcCo8vP8VhdExHZb6lw=; b=
	aGgFOESV0n1apzuTYsNuCGq18xU/RFvtfQ+D7K7FCetSoPxCbRbPCAitU3QWMR3b
	j0dQZdFcGLvZYFGVRHkXlga9HWAf9qz2YsS0iJbicsHDQUAoGJGUA03OG8Mv857g
	Bo+4X+qIGp4bfP7PptF0CkLThj1SWTJam2Xn24kYZuGMOEX4pb84YsWt1L5C4ti/
	IjhffwNfvdHXSlaSEopq3r8nGhA4yS3JJVxZ4wDlbnHeyHtiW5tUy5f9rD55kwCV
	O+wuWWPSoCUSrzwxlUKxhwEI5QWtRGw44kG71Jt+pHnyPBMoqQXyOFXEcqn1zQlo
	hm1/5GF4l8IouPrpcBw1EQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467h2kg0fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:48:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O64gMI031064;
	Thu, 24 Apr 2025 07:48:54 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06x4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 07:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNLuB42OJDNyM4od6Z8OoLsR0P6lKTH9sH78nKpikP0UC78F4kOUb2LrT1nLz7YDEY4l8kBUhm7jtOoxcHWnInKSR3w41IaOTHcNaxMXsQe4iHcOWes1E1dv/G/IcDwYsUhVOBTv/l0q7d8RY0RCiTJCFlHO0KXfw2Pqn0NpPl4s64OP5j+UxyRxw39j+y/i9bLY/eYzJ/MzXthiV8g/TxjPW2NfPcfwNbivSJ2HePmVBNRiqmpex8/lOQOYpJr+gVDDsYSeXlENWWDnkPqhlT2DRoS1l8ge5wYWmZglZRGvInKQxGnqaS/jUFo4SvgsUMQqVIBm6HdNLRcK54iyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmEwAgyrS7xSOtIdh/JG8JGBZcCo8vP8VhdExHZb6lw=;
 b=Eel00LQhIwVUBOzAWVtCJp5Sp1Uzjrx/mXgD5QyCm//27DIOd3I4AoKAo0/RCdOQ+KtXBe6YLVSQDk2dzBrsEU26x39oO84+ZNKbuESVwxHbOACFOLbbw+7m483rRItX4MQlg3XTK6gQohteJ3AH5EVcPrnQpqs9mtnlnyAz8/sHruE20zqx+FnoNPNCgsszbbePBSUjLGuVMqx6YTrJKHindIst+uz3Pr7fZl39J0Ayg9hAEfPCwHKgA3H/HedPtLTZUaGDD9iQuoDCLVyDdvczbJ1kquY2LSu6VI1o1aguohq1fy+gM/S3vSALPlnjS5WsFqQl69SQ5dGuAEZa/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmEwAgyrS7xSOtIdh/JG8JGBZcCo8vP8VhdExHZb6lw=;
 b=IkEncoaHqtU/9wIU7E2hSKln0z6BH70ELBst1MTwjm3BbVUQUrVQBQ8eevxPrl3AeWTdlS1hUQ04w6Z6pCiUHPqp2rle5/FQiGILma42DotBFWqTHX5g37ENwrQs4Yf1N9iVtnDy377cCYCsGJC/Fykd6s573HLXD2Q6h+3DbbE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA4PR10MB8423.namprd10.prod.outlook.com (2603:10b6:208:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 24 Apr
 2025 07:48:52 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 07:48:51 +0000
Message-ID: <9a577a7a-d55b-4017-b1ab-e6f2980f58b0@oracle.com>
Date: Thu, 24 Apr 2025 08:48:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole v1.30 and libbpf: Introduce kflag for type_tags and
 decl_tags in BTF
To: sedat.dilek@gmail.com
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        bpf@vger.kernel.org, sudipm.mukherjee@gmail.com, cavok@debian.org,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <CA+icZUW31vpS=R3zM6G4FMkzuiQovqtd+e-8ihwsK_A-QtSSYg@mail.gmail.com>
 <CAEf4BzadoMS7RPL26J2U_NyQUXnwVEmP+TxHU6D8R4AKvWSGsA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzadoMS7RPL26J2U_NyQUXnwVEmP+TxHU6D8R4AKvWSGsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA4PR10MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 156bed49-b7b1-41af-fb1a-08dd8304746e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlZoTzNCK24wOWl0aGtiUTNXOGQ1TEIxTURCNmFFbG13SGJYdTNndG5TZVdW?=
 =?utf-8?B?SHNuOXUybVZiNFczQUczSU56OUxkaVJUdTZDZ2JBdTFkRkcrRFNGUjlaMlI2?=
 =?utf-8?B?dFBIcDNXbnRpSlBTc2hDeWVIVWJqQlBETUQ4MFhicXhPQ0kyOEJpRmNweS9K?=
 =?utf-8?B?Wmd4NGZzWXl4NXE2RTFyVkw5ZlNGWDdsQ09VL0FtRWJKMkJ4ZUN2R3RrUTZ4?=
 =?utf-8?B?Nzg5dkhKWWR4enBlT0k3b2MrQVM4SWJoYmRjZ01zVXY0YXZKbkFDb0U4eFZJ?=
 =?utf-8?B?TE5xbm5CeEw2WU4vRVJ5U1ZBcGErbkJsOUNUTEpLck1QZnVHY1ZiSUxFbEFr?=
 =?utf-8?B?SExIOHBobE12dyszQk91MFRneVF4TnVrNXYreW9tSnJXcCtuSlljQ0FMc2g1?=
 =?utf-8?B?eXdvUStWTWViTnJTVFRxYXRUS21WdFNxaHcva3pDa2FPaFdkNE5BdG1qdzkr?=
 =?utf-8?B?Z2VGM1hRdy9DNUhVclFvZmxKNDBQdTRSVGVBTjduL1ZnWnZ0OFVLa2hWeFo2?=
 =?utf-8?B?Z090VlU4Rkx3UVU4SnppM3N3UjV0QVdoTlJVT2JsWUdaRVR6cmJpaWhLdGxz?=
 =?utf-8?B?ZWM0bDdZYS8xYWJSYTIvcU1vNWtlZml6VjFPQWxRZE1pckRnZ1hQc0lKVzFu?=
 =?utf-8?B?MVpLY3krVjVrcUFVRXBSdDEzMU53aGZpbHFGS0xhb1J0UkZCd3JNZzh0QXdm?=
 =?utf-8?B?REtYblc3MitMbE9HMSt6T0FMdlBma3VuNllUek56Tk4yT2ExRmd3RTBVdHEv?=
 =?utf-8?B?cFFpMVVHY0g1SEdHTXBZa1AxeUhobmhSYUJwTzltd2ZWMTk0SkdCZWxaOWJN?=
 =?utf-8?B?T2RXVnpJNm9PSDQrcjBGV0hNSG9NVGRldDNGcmlyc3dvd0g3VEdsWmVWckZI?=
 =?utf-8?B?dWpVaTJFVUN3UTU3d3N5MXRNY0ZzSi9yems0UnIwcFYzZWMzWnhuOWswZG9i?=
 =?utf-8?B?czU4dmpOU0Y4Y1hqTFY3MW5aWUtlam9kUVBUcGNteC80QVFrZDVuQWRkK3dC?=
 =?utf-8?B?MkpGMFpZWG5lMUxTUWtYdFBQK1c4TjdjYS82WnViSTYwYVk1N1JvOXBNeFBS?=
 =?utf-8?B?Y3locjhXYUdQa1kwM04xRTh5NVJJc2ZzQTFQd0FuSFpJZ1g2WW83VVFENXRx?=
 =?utf-8?B?R0tEVUdoQktlWmZQQlZpUEsvc2ZoZkRld0lyTkVwZWs1Z0RYZkkwV1pmazMw?=
 =?utf-8?B?eGFINWpyMUZlMzRMQkdoYitqWi9wcWV0bzFQcVpJMG84d2pUZU52a0gyeE9t?=
 =?utf-8?B?d2JDUGM5NzBZREhMZUh0SHMwSi9yOGVyc1MvcTlJQWM1UGpxa2NCMHFnVE84?=
 =?utf-8?B?QWtHZUNVaTREcnJKaGNWNEJ4RHlvcEZXTzBZN2lMdVpkT2crT25KT3ZHOGEy?=
 =?utf-8?B?SU1oQ1poQXk1TzZVSGNveDlsN2JLeks0UFpPMWxvMFdLd1VMQTErMWNCVWt5?=
 =?utf-8?B?U0E4dU0zV3FzYWFTU1ZSQWZNRW9zZmtjejRhNjN3c2VqRFdSNkNzakVLbXZs?=
 =?utf-8?B?QW9jNEZ0Um44Z1NBdnE2VUIrcWNNdEFLdmtDZmUvT2dZU1VQQkxjY2J0Zm00?=
 =?utf-8?B?cGpwaVVNbVBlbUNlMXFtU1V6TlpTaXJIci9SQ3N4a2F0MzhSKzRrbVpTd2xk?=
 =?utf-8?B?NjZYNk1aNDFYY2RQVUUvTUFRL2tqcTFndnI2Nk4yZ3Zza0FUcU1tai83TzFV?=
 =?utf-8?B?ZU1ublNvbEppTkE1MUpTVWNRTnBkcEhZY0lHVzFMTXE3NTZqZXNhZ0RERSt6?=
 =?utf-8?B?WmZKc0JHODMzcFNacitDMWtYTVZEQk8zNTl0N0tvQjV6aWpZcHVxYnlXQXZm?=
 =?utf-8?B?RjcwV3kydVdJY3MyVWtsc05wRnFzb3JMN1RpSGRqK0t0MDQ4WDIzY1FtNUxX?=
 =?utf-8?Q?3qKtivCfV3JGt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RYUHI4ZVhkb2MrMWM4T2V0R1haRTRsK3ZVazdmQ2ZqdG9KUkhtR0JuNC90?=
 =?utf-8?B?eWFQQm5UWFVkSDNudVRKUGVoU1lZT2p1UkxkTlI2bTB3MGRlaEJrQkxEcFVP?=
 =?utf-8?B?ZUhWVHdMWEVXYnVEb3NvbSt6V296MTgzN0hMRTJmSzBaR0E3VjNoZ0o4R2tP?=
 =?utf-8?B?NnhRdjhHamYxaitVZmZCSk9saWFleC92bk4rNTMycHUvMzN1SkhkNWNhdXEr?=
 =?utf-8?B?aGtVRmhha0Zha1dJZFM1cDh4MDRPRW1YcExSSEFxRXNmaW8rM0VhY0oxQW0y?=
 =?utf-8?B?MnRuaHFYRUpzdjZmeDBJU2NOMy85ayszbFM5Q1p5RGZIWmdUUXF3RmRwWUlw?=
 =?utf-8?B?VWYrRUFQM3VwTkllNFVDQTFVZ3M4OEFUa0NFRjZOZ3JmejI0d3dHaXBHSFYr?=
 =?utf-8?B?cldwc2o5QTQwZktFTkVoWDhJTFBjYmFJcDVZQngwSk5ESWdhdXZZNnpkVURU?=
 =?utf-8?B?YUdMSXEyb09zWW9YVlVGaVJKUDRONWY4NDRWM2o2K1djc081QWJZVHQ5andZ?=
 =?utf-8?B?YU9xZjIrcGZaaDBtYklnU3drVHNJcmN6Rm1xOWt2UWVFbjhnOEFoSVBqdHQ4?=
 =?utf-8?B?SGxaNVkvdlA2WHB2aVFVSmVpZHJuZTdkMm9JYTVqMVNGbmNkTWZnTlZKVXlD?=
 =?utf-8?B?NXFtclBTZlZ1M2Y1Tjg4b3FkMFJPQ0MwN21Bc2pQTzBiUHpGajBjeThNQ2R0?=
 =?utf-8?B?a2htQTF4TUxxZUdRZTVBS21KSVAxcTJnK3NISzZNTUthNjhtZTN5MUhHd0VU?=
 =?utf-8?B?WWJKOXZyWFlJei9ReEw2UW9wbm9wUkt0MFV3TU5hRHVJSm4yUndxRU1nR2dI?=
 =?utf-8?B?U2dCNlBCL0hubzRWdkRIcXUyekRKVWlCNDBYNitKVXR4cGpTTjRzU21POGZl?=
 =?utf-8?B?NHBXa2NUOFNlcHY3RndwQ2FET2x4K2RJUGh6cWw1dHVqL1NzamFXWXZ0V0tT?=
 =?utf-8?B?anFUQUtKdjlxSTM5b05WYU9ORVdzNWNxM0c3UDh6T1BWdU5VQ0RPeXozZTB3?=
 =?utf-8?B?NzBkcjNXMUhZcFJNck10WHN2MGVIY1J3cE5PaFBFNE8xM0ZSM2JHcEZKZzd0?=
 =?utf-8?B?ZDBhQmswTElIakVkTDYrcSttRmVuV0ZTVFhrZUJlL0xtWTJQYzBISkpIZ1V1?=
 =?utf-8?B?bmhVVTR1VThhRE5iQzhXRUxpQUpUc09aMUtHY3laSWFneWp5WW5JZEo4UXlL?=
 =?utf-8?B?NG9ZUldNakViZ0wzVjlUSUZVcStGMTRkVWtqb0x3bkIwalo1WllsUzJYaUww?=
 =?utf-8?B?UW9BV2V6Y2x2bnhhK0dhNXJRZVFxb2R5VkxuWDJpYk80ajRWTVVPcFZRaFY0?=
 =?utf-8?B?NUNwa0ZHUDRSb2xHNzV4eVRndVpNRHMzdXAwOEJCL0d5aStrSnZTekZybDBk?=
 =?utf-8?B?aTBPcDB4MzY3SmpIQm44R3NjMytFdUY3VXd6RTQ3b3djVFd0RzNVaVdVWklq?=
 =?utf-8?B?TkxwdGs1NEx6NFNmc2VjcHRwWFkwSmNmQllPWDh4cmhBeW5WRzlyMVY5NmVT?=
 =?utf-8?B?ZXY4bnFUUHVRMDNmQU1QbFRCREp0ZDE4ZHpzSzlZY1dUUnl3WDdHT05pZnBH?=
 =?utf-8?B?WjBHS1hLUkhmc0laZnNCc2R3OVZDYmJaTFplMjZCQXpIVkpScWU3eWFlWHBY?=
 =?utf-8?B?cUR4blM0Z2Rya25MMGdnUkFyOTdRRVRSVm9LbmtpWWxnUUVMdllEb29CYVZQ?=
 =?utf-8?B?djdHOUltaXJYUmJKZDhrbC80RjVpOEZOdVM5M1dqNnVidmtha1UzUENGNjdN?=
 =?utf-8?B?bVRVdlJSWjlMWW0vMFdnU3lIM1pZMldNZ1loVU44Y0Y1TlFwSElCQjRDc1Zi?=
 =?utf-8?B?RE52bkc4Q2ZGbE8yVHlxd3JhWTZreWR3T3A0NGxhcnljRlNGaE9YMVh2ay9H?=
 =?utf-8?B?ekh0ck5SREgzTTBSZ09TeE1GUFFvOEpiaWVJWCtIa3ZBWVkvM05uaC9HalBH?=
 =?utf-8?B?djRpTW1hU3JmazNaUENzcGlZUndoUFdJSHlaR29OVlF3cTNaQXVvcXZsbWVB?=
 =?utf-8?B?SldsSm54U0lsOVY3T25PbHBMYW55OE5WTXlnSGFkZ1VXNU9abzVPZUwyTzRE?=
 =?utf-8?B?aGZ1SnBZWGdGVmVCTmhBbVpNc29QUkRCQ3BNVkZ2SmEzTFB2NkVKV1ozaCtH?=
 =?utf-8?B?SVVNd1RvNWdoejNCRHdhVHk0WEhOcjZleC9MTFFmLzFXVHp2S1hYSktRMkYz?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j+uOY1QCLSTqcsHbxAaxUS+AfRHYR6UPSEpY3t0Wrmv4iPELIXAinIVR5I1KqKuiNzOpvvo7gz9cufgpotipSg3wZX5CowGByT61c569P+6nS4bifQ2tc3omFmfCWfo6Sv+lAx2WWtUiloC1GKgmYZD8vYyMF8PDYBClVOK+R/WGmS6AeHPSXHpAWkniSyy3UwViRZOVUBPIYh3FsDT+6pl2WtyPH4PYu5c6Q53xZrG2gelMnO0uu7IzeAHItALkT32HbLICky+8Gcendm/4b+h2bd1iX3QyvPRiydde+YpjYsD2ErMqUgd6b+ZpzpFFntyWhHA6udM68lLaxaNsjC/dvNzKAWru3WwwVhzRhXoV/m7zC7S/npjZRJqKp7ANihZHLmXsG0UERc53WmVv7eXypakC4IOjGqwCG2Ty1uHFSoGWfSTH8zwW4EyW3nzYepjEMRiBFT+KGK03rEURAvncn7SpIUOHbMjAQnZsaJayB1IIqJgT0h8JccIvlQGmrZAgZeXQ0cyJBtA2u0fK2cjoAJVQzmahETn0HNPTeHCBTp+u+5gXpiFhWA/LtS8kp1TGsKuhr5Cyuo35LN5sPm63R1v1Vd03GwfAx1z2fJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156bed49-b7b1-41af-fb1a-08dd8304746e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:48:51.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXSFGxeIknDYnl8sZE6WgQmEZzrJGkxa/3TOW2tvWSByocjaW8q6mGQxxVR2B3WEKbgiUj7vLtahgGiKi9gttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_03,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240050
X-Proofpoint-GUID: Kw30saZ0rDG0fCJJc0BsUJ9pQbfx_rzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1MCBTYWx0ZWRfX/OapOaycWCdB AMt9G8r3rRR049j62q6O2yud1Lb9mZaaWbdg4TrS6qrw3JmiR2ndL9sqgz7x3UoG356IU5rREPp 17HZpWkMmbIiHkChnl0BVOK0RkOiG+2+l+gIAjNuO0hbkB4Xm3PyOjl+uSxtLHYaLGR0Hhll3kw
 tHOoMZkGcZ3j/wu2NXHw/xn4oHxE9k03+M1faNUGlgfpkXrtUpD2HnNwJGbdsOwU22P39o0Z48M om6/knmYTE00QmkPodqt1bD4fKAbFiolDTW1MMR4+Ul/D8/QKduVW6LPk9TZGVUF+/iwYfa0aRR jNkuvAaBGeFVemeACYx2KKnofY21SUp8MZ+E1oS46JzFrOy4rMKQaNKsau+qjq67enIWnEnI+NN Q92Ongl1
X-Proofpoint-ORIG-GUID: Kw30saZ0rDG0fCJJc0BsUJ9pQbfx_rzO

On 23/04/2025 18:50, Andrii Nakryiko wrote:
> On Fri, Apr 18, 2025 at 11:58 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> [ QUESTION ]
>>
>> How to check if libbpf API functions
>>  * btf__add_decl_attr()
>>  * btf__add_type_attr()
>> work as expected with pahole v1.30?
> 
> What does it mean "work as expected"?
> 
> Can you be a bit more explicit about what is the problem and what
> doesn't work? I didn't get that from the below investigation notes,
> sorry.
> 
>>
>> Looks like I need Linux version >= v6.15-rc1?
>>

hi Sedat, I'm presuming you just want a way to test these new APIs using
pahole-generated BTF (if that's not what you're asking, as Andrii says
please do let us know what you're trying to do in more detail).

There are two aspects to this; can I generate those attributes, and can
the kernel handle them?

For the first case, type attributes are currently generated if the
"attributes" BTF feature is specified. Whether you have this
functionality in pahole v1.30 depends how you build pahole; if you use
the git submodule, you will have the required function. If not, the new
functionality Ihor added should dynamically detect the presence of
btf__add_type_attr() in the shared library libbpf.so for cases where the
"attributes" flag is specified. If your libbpf.so does not have that
function, the feature request is ignored. btf__add_decl_attr() isn't
used in pahole yet. You can run

pahole --supported_btf_features

...to see if the feature is supported; looks like it is in your case
from what you sent.

Now the next issue is whether a kernel can parse type tags with kind
flag set; only kernels that specify the "attributes" BTF feature in
scripts/Makefile.btf should generate such type tags, as these are the
kernels that can validate BTF containing them.

You can see type attributes in action for vmlinux BTF by running
"bpftool btf dump file vmlinux format c"; a few of the arena-related
kfunc parameters should have address_space(1) attributes associated with
them; example

extern void __attribute__((address_space(1)))
*bpf_arena_alloc_pages(void *p__map, void
__attribute__((address_space(1))) *addr__ign, u32 page_cnt, int node_id,
u64 flags) __weak __ksym;

Note that you need a matching bpftool that also understands that the
kind flag set means an __attribute__((address_space(1))) ; otherwise
these will incorrectly show as
__attribute__(btf_type_tag("address_space(1)")). So make sure you use
the bpftool from a kernel supporting the "attributes" BTF feature.

It would be good to have a standalone pahole selftest covering type
attribute generation; if that's something you would like to contribute
that would be great. We can't really test the decl attribute from the
pahole side until pahole starts using it.

From a libbpf perspective, looks like bpf selftests have test coverage
for btf__add_type_attr() already as part of prog_tests/btf_dump.c.

Alan


>> dileks@iniza:~/src/linux/git$ git log --oneline -1
>> 51d1b1d42841c557dabde5b140ae20774591e6dc
>> 51d1b1d42841 libbpf: Introduce kflag for type_tags and decl_tags in BTF
>>
>> Add the following functions to libbpf API:
>>  * btf__add_type_attr()
>>  * btf__add_decl_attr()
>>
>> dileks@iniza:~/src/linux/git$ git describe --contains
>> 51d1b1d42841c557dabde5b140ae20774591e6dc
>> v6.15-rc1~98^2~87^2~5
>>
>> Currently, I use Debian-kernel v6.12.22 and want to build a selfmade
>> v6.12.24 (when it is released).
>>
>> If you need further information, please let me know.
>>
>> Best Thanks,
>> -Sedat-
>>
>> P.S.: My investigations
>>
>> [ DEBIAN PAHOLE ]
>>
>> Debian/unstable AMD64 ships on my request pahole version 1.30-1.
>> This version was built against libbpf-dev version (1:1.5.0-2)
>>
>> Link: https://packages.debian.org/sid/pahole
>> Link: https://packages.debian.org/sid/libbpf-dev
>> Link: https://bugs.debian.org/1103000
>>
>>
>> [ SELFMADE PAHOLE ]
>>
>> Prereq: libbpf API version >= 1.6.0
>>
>> dileks@iniza:~/src/pahole/git$ git describe
>> v1.29-16-gb45268b74da1
>>
>> dileks@iniza:~/src/pahole/git$ git log --oneline -1
>> b45268b74da1 (HEAD -> pahole-v1.30, tag: v1.30, origin/next,
>> origin/master, origin/HEAD, master) Prep 1.30
>>
>> root# /opt/pahole/bin/pahole --version
>> v1.30
>>
>> INFO: git describe should report v1.30
>>
>>
>> [ BUILD INSTRUCTIONS ]
>>
>> VER="1.30"
>> PREFIX="/opt/pahole-$VER"
>> PREFIX_CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=$PREFIX"
>>
>> echo $PREFIX_CMAKE_OPTS
>>
>> cd ..
>> mkdir build
>> cd build
>>
>> # NOTE: See upstream commit "CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR"
>> ##cmake $PREFIX_CMAKE_OPTS -D__LIB=lib ../git
>> LC_ALL=C.UTF-8 cmake $PREFIX_CMAKE_OPTS ../git
>> make
>> sudo make install
>>
>> NOTE: Do NOT forget to run `ldconfig` as root (see below).
>>
>>
>> [ LDCONFIG ]
>>
>> File: /etc/ld.so.conf.d/a-local-pahole.conf
>>
>> # pahole lib configuration
>> /opt/pahole/lib
>>
>> root# cd /opt
>> root# ln -sf pahole-$VER pahole
>> root# ldconfig
>> root# ldconfig --print-cache | grep pahole
>>
>>
>> [ PAHOLE - CMAKE LOG (LIBBPF) ]
>>
>> [...]
>> -- Submodule update
>> Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for
>> path 'lib/bpf'
>> Cloning into '/home/dileks/src/pahole/git/lib/bpf'...
>> Submodule path 'lib/bpf': checked out '42a6ef63161a8dc4288172b27f3870e50b3606f7'
>> -- Submodule update - done
>>
>> Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=v1.30&id=fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43
>>
>>
>> [ BTF FEATURES ]
>>
>> root# /opt/pahole/bin/pahole --usage | grep feature
>>            [--btf_encode_force] [--btf_features=FEATURE_LIST]
>>            [--btf_features_strict=FEATURE_LIST_STRICT] [--btf_gen_all]
>>            [--skip_missing] [--sort] [--structs] [--supported_btf_features]
>>
>> NOTE: --btf_feature*s* (all options plural) VS. commit 40e82f5be9a7
>> ("pahole: Introduce --btf_feature=attributes")
>>
>> root# /opt/pahole/bin/pahole --supported_btf_features
>> encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attributes
>>
>> NOTE: Supported = attributes
>>
>>
>> [ LIBBPF API VERSION >= 1.6.0 ]
>>
>> Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=v1.30&id=fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43
>>
>> commit fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43 ("pahole: Sync with
>> libbpf mainline")
>>
>> Pull recently added libbpf API functions:
>>  * btf__add_decl_attr()
>>  * btf__add_type_attr()
>>
>> root# llvm-dwarfdump-19 /opt/pahole/bin/pahole | grep btf | grep add
>>                DW_AT_name      ("btf__add_type_attr")
>>                DW_AT_name      ("btf__add_enum64")
>>
>>
>> [ pahole.git - lib/bpf/src/libbpf.map ]
>>
>> LIBBPF_1.6.0 {
>>        global:
>>                bpf_linker__add_buf;
>>                bpf_linker__add_fd;
>>                bpf_linker__new_fd;
>>                btf__add_decl_attr;
>>                btf__add_type_attr;
>> } LIBBPF_1.5.0;
>>
>> -EOT-


