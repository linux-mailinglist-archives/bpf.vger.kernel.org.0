Return-Path: <bpf+bounces-57079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F48AA5333
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B614E6C78
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65D0270EB2;
	Wed, 30 Apr 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mr2tfjCc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YOY2Oj0T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76F1AA1FF;
	Wed, 30 Apr 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035868; cv=fail; b=A2DSL2Zehtb+BUKx2HWyzHujnUv6D5oHYF27ArYhjJyw++c1ZAh/9Tq3xNGcYFY2YK0cqC+e3c+pBqsPy9uocdv/0T5iiNAPDD8XdtmMTdTgi80Preg09zud04PQXCb1/O9ak5yz0Yy+753NPYu4FLyt7ZKN5kitlDCXRPBMoPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035868; c=relaxed/simple;
	bh=DT+k75FjqW1hPMUFgkk9I+2lSYkRcVPpOPYyyE2A3TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ROSl7AOkvCgwC9LyaULtHUo/NioQsZlTcta99X8bX45MQfga/IayRVf+PdWYK2k+vljJaOSRCqWiFF1pSNuY9BHij0qWS84gTxSmruXvX0JzswVjb1bP7O1AMmIvcyBbrFQXQUbSWfRqz3rwl/woNJ9IcXIem4Ljbn4c0q03IDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mr2tfjCc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YOY2Oj0T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHtt3D020870;
	Wed, 30 Apr 2025 17:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vu9Dxu9POBDRFBqds+uIMHytZWR4YVjmfaJciVNwvdU=; b=
	mr2tfjCcBP7F1QqisSTXHxnPDE3bCZCebrv9rJYLWi1wLvOpeebN+2l8wgcwoIOI
	2AGSRsa0vKOzLUFpugOKfhX6As9s5lBjvQEOHIOK12NCXAIehNUywYdyHikc8lyT
	RXexqUA4EQsf7wLVSRPvaBdsLPoEQamP9G6yA1xyjoKAg6KUFt+g1X3N2Wf+wtUw
	O86W+jHzYUXe6mIwwL7iDJcNs9IuDRFlsojMCVmlCscvZYd19Ijmz3ODbok1i1ak
	mRPdu05jwBKKQtx3hHtHH5ogqGU/ER7goNrLuh88hXIadic+H5Nr3Z1WtFw/DvJB
	VbW169IkEarpwqmUPkN0+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ushsek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:57:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHl47p033369;
	Wed, 30 Apr 2025 17:57:25 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbn918-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkGUSAji6cX+KYH74aJGF+NhyDT3HmNoitDXRQG2D8h9tiymDisCsruoBVoAJ+x9HFZMppeJi9nu89YUSSgX9LYhlb1fDgXqZ6095b+/spj8OpZgeFw8EG+yHHCNb36DTsyqlU0gkNXbqDNPeYTED16Z8QF/5J+L4XjhsNBtZPts44VoXPemOd9nUMInptoEpIoi72IcIo5DFw/CHEyZlMGacwR65D7plcoixDNGNHXUM0Kq5cg8x7PlFIuVFDQx32blyyyMyrJwa2waS/G5uu4//Jhkd/cjZr/tsCwS2BeuqQWLfjVrC9tbmvrHcA2QuXtc7BWNqs4+zsAObxknNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu9Dxu9POBDRFBqds+uIMHytZWR4YVjmfaJciVNwvdU=;
 b=KLtrInKcM46t+K6qkWXoyqpVH580LU7vkFKQ1Z26scgxs1m86myJNGMtb8VMxJqK/qV2eGfNvR5ioQhPMIi6Bx8YY8lw1uApIJYrMGJpREhEVaGYaGffhlrz/g9OGo7kOgeAuF/3qvTFQQaD3HpXDap1TMCb6qnLmGlV/s2vD9NcrX9fDuNBQuEPzwGMZeazOLw8A3rNBDzSn+zsRrUn1DmbeTJV/3NCJHzLQ9MGJBeIWZxnJdAZngmF0xmUYlCxZbj10Pzrd/NbLhKJ4ub1PRnWpkX39k/0vsG2dhPBJhdV1WIUOM2g38xs70f4H5zmR1OFzQt6kpFqpgfIycOYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu9Dxu9POBDRFBqds+uIMHytZWR4YVjmfaJciVNwvdU=;
 b=YOY2Oj0TcIYbUIglKW6aIOMo107SFcDdxivwRLHO7MWe02yprKHhWGWNXrIz/wqkpqxgcMQmfQSVVlM8yx2VhjJWeyKw4J7OE+cKTJsKC4oCCze8JJ7AAZjcgSW/KEQ48pBC9VfF0rCRwHm4bcT7h2XJPUp6RpKORiNNDPkuI8E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4719.namprd10.prod.outlook.com (2603:10b6:a03:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 17:57:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 17:57:22 +0000
Message-ID: <4cabeaa5-0a6f-4be0-89c8-b7d0552b0dd0@oracle.com>
Date: Wed, 30 Apr 2025 18:57:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 2/2] bpf: Get fentry func addr from user when
 BTF info invalid
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
 <20250430164608.3790552-3-chen.dylane@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250430164608.3790552-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 44820e8c-b00d-4ac9-2b94-08dd88107534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9YaVdPekNRL1BMOW1iUXFSdEdtUHdRRVhPNjRyV1RqcUZuUFR6MGFJWHBx?=
 =?utf-8?B?VDFER3dyeWxVNzEvNVNDQlA2U0d5SXE3alQzbkltYUwwNWtSTHVzWWNabEwv?=
 =?utf-8?B?OExLVDZXMEZ4cGRjOS81SkdGdU9JNnhNdG5ZWHhPbG5aeFArcWxuQ3ptdFBa?=
 =?utf-8?B?K2VOaDJjWWc1L2dRb3lFWmtaelprSlM3T2dSdk5keVVXeFBvN0dlMjRkL0pG?=
 =?utf-8?B?TFZPb0x3SXZyb3NTbXR6Z3ZHWXp4N1V6NEUyTWMvZENZQ0NYWWVtRHlqY1FF?=
 =?utf-8?B?QWd6ZExObmZtNTlGUW9nSi9meTVBUTNmRjZ4SXhSTmRQTEhlUlNReUdVSTRo?=
 =?utf-8?B?RDJDdVlMQ3p0Q0dhRmNORGExc1B2dnltdlM0ejRLMjdIZ1d5YUVSRmhsWnNa?=
 =?utf-8?B?cW1LN1lLLytkVG9FYXF3aUV6VDAvRlBFQlcvNFNCVHY3Sy9LQjA0ZkNaMzU4?=
 =?utf-8?B?SnVDblF1U2p3cWduNWpDY2ZyUlhpa3p4NDVta25zOXNsSHpTR0JWcVdHeUhq?=
 =?utf-8?B?VmRQY1NaajZOc3hTWTh4anduK1Z6dXJsc3JwRUJUMGRrZjhMTUFrM2M2YTAy?=
 =?utf-8?B?R25jN0FqZFBBTTJSSElDL1NwME55ci9RQ2l2QmFyN3RlUHUzbTNwYlRMTm9D?=
 =?utf-8?B?ZjRQYUJjVnNBZHU5MThQcVFuYVpyc21sRmZwamNoVHFRSFVaSzc5amx5QzRo?=
 =?utf-8?B?THdCaW1KYkxXekFXQ3k2NUl3ekEvSUMxR0dWNHNwV0dOYnVWRE9xdkxmV1ZL?=
 =?utf-8?B?VzYxSWE5S1Focjl3ZStPZ05zUU4yT1J4VC95SlZGemdvRGZSdVV6dXI0ZW1Q?=
 =?utf-8?B?ZDc5WGxjcktKZDZlTHcwTGFoRWMzL3hGaGJ1VTJWNzM1YnJKeFRza09ldStz?=
 =?utf-8?B?aWpXVVBuWEJBZ0w4Qmk0Q2RPOUFkV3VJZ2lOaGk3aTRCeEVpWFpZYXcrV1ds?=
 =?utf-8?B?bXZrYngweUcxUkJUeWhVb3V6L1dDN0E1V0lMZlFRT2FUOGNpb3J6clFQYWhW?=
 =?utf-8?B?d1VCazN3S3dMV1NVL2o1RWkwNE5WZkhWOXNyWHVJbFRaYTlSYkx2d0lOUFpr?=
 =?utf-8?B?NDFwRVJ6MWdLVXJEeE9URmxqL29UbnAzM0FBc2RQWklWWk1mN2krNHcxOWUr?=
 =?utf-8?B?eituVDFvOTdndVRpZldHWTBibFNYMVRKLzhITU9jTlFPR2IreUN2bmVHZ2p5?=
 =?utf-8?B?UGh5VWJHcG5oZTRrcC82ajZxQldXV3ZndXFOUndUY3JOZE1EQmtQYUwvOTFN?=
 =?utf-8?B?N1BPR1VZcXFraXRCVytWRmtJS2xTQ2o1OUVoT1lHSnRDd1NSQjlGNWhYV1R5?=
 =?utf-8?B?OERQNHFQNEM5N25WdHZZS0ZuSGdtOEU2SnVyUDBSeXFoUDNTNEN6UHhDdkxq?=
 =?utf-8?B?WktPa1hnalBzeEJxMU5aNHg4VDdqaDExMXEveXBINWN5OTdOd2ovWkJWZXV3?=
 =?utf-8?B?T2p3NzJjQXVPOWQ3SWVld3Y5cDVxZUF5ZlFhM0p1NGtjdUpzMkJqN1ZSN0xw?=
 =?utf-8?B?aGJPTWJ2WWpmb0ljMjVPTmhGVTh3b2pRd3lqNWFDMDMxK2hjUGc1T0xLREJr?=
 =?utf-8?B?SjJSZ2lFbDcxRUJaMDByc0RkQnNob3ZoQktLWXd1eTVlRTFZSlJTSnlmK1Vr?=
 =?utf-8?B?bTZOUzRSaVpVWTlhWE1CVVBRSkc3VTVjZ0JzZUFqdmlmT2RuS2o4MVQvdWl3?=
 =?utf-8?B?cjlXNUF2cDM1Nm9jTXhkSUMwa041aG1mWTFwNUg1em9PM2o4Nit5STBzWENm?=
 =?utf-8?B?YUdCQUg4S3JUWXhGeTB1alh3K1o5dG43amZIRzc5Tll1b05ERHp6ZkI5N1ph?=
 =?utf-8?B?b3NqeGFvWkorTER2SlF6bk1BTjgzMm13bGdsT0h2cnIyMUJjSzA4NlJjU0Nw?=
 =?utf-8?B?aGhQMm9ZR0QzaW5DRnlpT2tNd05YMEZpYjhnVlpub2NxeWxSYkdwMml6Y0la?=
 =?utf-8?B?enRoZFRCVEhWQVhWd1FyU2VLR3B4bE9GdTl3Z1U5cElHb0RndW05UjB6d3Mx?=
 =?utf-8?B?ckNZbVR1Mkp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5MNEJTUDRqbU9ON2NmSHhuSUtmaGJlb0tqOWYzSzJFN0dBMEhJR3o0MGhk?=
 =?utf-8?B?SGxRaDI3amFkd2hRb2tKd3hPK3BLWkxvRkpsaDUxMEY1dHBRTHdBeDI2eEtF?=
 =?utf-8?B?djc1UnVLbEN1WXFObWRmM2oySUIvd05kdkFoVlo2cytQT2tialpkNGQ5Z1No?=
 =?utf-8?B?SnlVZ09xVkVRZ1EyTlZMNEpMeU1uS01TMHVCOEVvT3FGTlRJakpHSTcxeVg3?=
 =?utf-8?B?b0JVbUkvbXFYQWpFWjBvcGRGTWcvLzlCbE0rcWptWGVRUnBKNFZZeU9DOGNa?=
 =?utf-8?B?WHQvdWJtQXVtQlArcUNQS05aa2JhNzZpZVc2a0djZ203Tk9FRDM5Z2wvbGxp?=
 =?utf-8?B?Z0wvRnYzaFNDYm92eS9FdCtIQTZvTk1Ma3VKT0p3RHhSY2hmSkF6c2FSVUdS?=
 =?utf-8?B?V3FKZGwwMUg2RmdUNHRxNEFJOU81QkNTaGtDZ3NYdzRxYzFNUVdLNGJIUlV4?=
 =?utf-8?B?dUVIOE5ReWVSaURvS25DdjJRY0NKNjVGemdiUmluWVBiUjZaK0EwMVhjaHNx?=
 =?utf-8?B?RlhnOFEvUFB2ZzFPZDVQZW0vUXVaVXV6Smtrd1pjSVlXdFJDei94NU83NzdQ?=
 =?utf-8?B?dXBHaXFmV2dvSDBxVjBFWFJwbG8xb1BCT3hlaVY0cFFLdk8vZVdPWC9ZMnVp?=
 =?utf-8?B?ck8vR2tnRU1ncUQvS1daN1c2QWRlVzdwbnZmOVZDbGRnTkF5OVE0SjNuN0dt?=
 =?utf-8?B?aDV2WGIzTHo2dUV5cUFZZmZ0eDdoRlVsdUxYbFR3RndmaXJpb1grS3hLc2VQ?=
 =?utf-8?B?SEc2Q0NnaytNWUE2OEpuaFZ3VG5HeDBBd0tWTW5STm1oTFpqYXVRdmJaS0la?=
 =?utf-8?B?NnRCOWE2M3pkZXI1TXpMYmZyT01LclVZWnVteXlyYVpsZ3hya2NUekNGYTlZ?=
 =?utf-8?B?Qlh6Qi9vT3FtVlBqMEFNYWZHejhiam45dXRnUEgvbnN1Y29yc0RsOTFEeVk2?=
 =?utf-8?B?TGdKUWpFTXJzaVZydlVaQWUrWXBSZHByd2swYy9pMXc1dGFnWDNrTE42eDJL?=
 =?utf-8?B?emNjcFp3TFlYVmM3b0FxTFpqaE8waFJ1c0YwNE5ZY3ZrYmF4R2d3U0V6YVd6?=
 =?utf-8?B?dmdMZUMwNWV1L0orYmV2QXNwd2VNYVdzSTUvcTAyRFpIR3gzN3RNNmVjd2hN?=
 =?utf-8?B?RW04SzNGMW1GNWtLTHBKRE5hYnM0amo4S0taY2kxWSs1bzdlK2NHSjk3YUx2?=
 =?utf-8?B?TEQ1c2FtM0xiVzdjNlM3SHBIaHNKd0JZeGhpRFlkS1J1ZUorQlRwekE5SkU1?=
 =?utf-8?B?US9paVd5M2tURTNrK2dRNFBFUDVkWC9IYTl2a3FHWGgzQUF6blNxWlNrUnF5?=
 =?utf-8?B?ZXpQMVlYemxOcC9yOVZjTEw3S2ZQb0F0U0FZWldjUVJXQ0NvZ2ExVTVyZjNh?=
 =?utf-8?B?bERPVjloc0l2NDdvcTRQQTlmRUsrZ09QNDZmN3EzMlNFeTBXVUpsS09oWFk5?=
 =?utf-8?B?RDNKSHhZL1gwUERoR28vTktMZGVZQ3dyS2pKdTlFOCsrQmdRem9DVW5Ga2JH?=
 =?utf-8?B?Y1hjL2RuR0FvZGdNeXdPZUlXalkrRk5ESDdvclRJcXlmeWsxVjdJS3VsdjNx?=
 =?utf-8?B?REw0Y1dpYjVVSXNEd0ZiSEFqN1hBV2hlaXlzcnVVUUw5UnYyNmMxOE1nYW9u?=
 =?utf-8?B?Nm1YbE5DYldtSFp0aHZFa1YzdmVsOUE4aWVMQzlaZGJXMkgyOVFuTHIxTHVM?=
 =?utf-8?B?ZWFGSWkxVC8vSnlBdXgybWhZTmJPZ3lrVmVONE5HL1FQcmprd1oxc2htYytS?=
 =?utf-8?B?eFJaQi9yUTJaTklzN1RFQXRlSXQrZHBDdWhHWStxV2JIaW8rWmJqV1lOcFN6?=
 =?utf-8?B?M0gyQ1BoZWF4LzVwaytEOFBNY3U0RXl0VXNRTXRnRFRhWFJ3Tmt2aHBuSEIr?=
 =?utf-8?B?WitzSGlXeDVkRzdUdFhZRExNNXQ5UDJocUszNlFTM213SzVBaUNpeEZOSGZC?=
 =?utf-8?B?NVN2SnhUTjB4YzVJc3RuNkJkOVVhL2JNQTJKZ0hmcVhhbzczcFBUL3lNV0Rq?=
 =?utf-8?B?cmNGcjdaVWprcFNrMVIzbXZrZ3MyNVhCY1VkbjFJbEdCcTJ1cE43QU5ubkwv?=
 =?utf-8?B?NEpRUkxYWVM2MkwzWTlySGxMTlRlNnpvL1MvQ3JYUVVVMWppeGkwZEMzY3M5?=
 =?utf-8?B?YmIwWnRXR3F6eElCbjl4ajhJUlBTcFpSRlU5bmNibisvamJYdVhLak5VUE9z?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CPwuXrTzpiRX2nAD/X8Pf7Q8LyhYl3faOBjqkfajfZOZ8JSlWrCg1plP33too3RWN4ax6BfKYfJlj2PpDfWjtca4dVWwYLfs99Jsk2wouGbShnl9kul5SHBRA0ztOlEvRU091ydbfhr9L6QXj7mj6od4H/WJD9ZbDCh/9l/Q2IVR0xgmU+EJgVRGSj5uwkfA7oiC1LYBVXuQ7cv0hADYrgNvmptMgqT73/UUbo5wVfbLJ5BCtGAllnY7ZTY0L4tkEq/29ZChQWJeXLUNJxUXJSWO/WWPlpgsfvejyEBunDApaVBbiUoWGw+b12gLpbwoeZM+bV6ns3JVMbbb5x4mDGywqVuNiPgVAasL9B4oEHfg7v6/uiezlb1r46o2IymCp+YAW38dc3RAgzfnJBKu7uD1/MkK4hBwYkvRa0zw9nvY3TPswgaTHtRwiItctD9Y0DpbvcL45D/aM0i+nCL6cr28XqyxeU4CZ9ThZ3Jyzy7VcLoDAuWXIhFYnQHVV2UQJA7Ejr3Ri7gpbv2QCMNzRA/d2DTyKAd4Uxof5gvJir8ivsQ4rPZy9jj1Gsvd3beZ29ohcsMZf9k/UnHBx4f5WUPis8cF06ZMXo0t+nmqzB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44820e8c-b00d-4ac9-2b94-08dd88107534
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:57:22.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/bVA1/LINbCai3VE7jjnqaIh5e4vYh5HTBvTtG6/6PoeX/rn9t8LeyT326zxN/11NSDvdlGdBCf9LyjeW9zEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300130
X-Proofpoint-ORIG-GUID: PhwFUxRbmkzKp9LWUDuuAA-ZMASM290-
X-Proofpoint-GUID: PhwFUxRbmkzKp9LWUDuuAA-ZMASM290-
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68126486 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=-c-uzyw6kWc5GvVrwVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzMCBTYWx0ZWRfXxIQ/YCdxfMuz ZGKfawUqTDIYD1vCviczdVpP0RabMqFCl2OfAdY8jhBpuqt5eVCYK4fhaK29LKtwASRnv18yCcj 7zVlX7+6rT9SBNNFgi5R1M+YvWJalSBw30xiIBAg2hTLUUHm2hPlckqcxW1VK4PL0iddWJXD4TL
 BGCJ0dXacN4Z04ajiPA1Sz1bkrzNgA9NXoJ9DhV0PMnekUbxxvKSLmtZe32WrQQdY0mZEMYhLTn aNrteZoqIQ3X27kmmFAo1+SCrUksAgTYQ4u3gGe90FUHgVgQEEwp7RKMLMXNFxXSBXu75KKtPSQ DMe/mpSHzCPGuy8r8DygoasDOMTVgh/pxExaoVP9pDRaDectMzAW7dlCxCgQwpG3XPMcUzWU9CR
 x1P3SA4EWetU7G+cNMpA2hlqERthMnCFkqyKoCVPYZkBvxMlWnLucVQ+ACkaAHgcjMqgmdz8

On 30/04/2025 17:46, Tao Chen wrote:
> If kernel function optimized by the compiler, the function name in
> kallsyms will have suffix like ".isra.0" or others. And fentry uses
> function name from BTF to find the function address in kallsyms, in this
> situation, it will fail due to the inconsistency of function names.
> If so, try to use the function address passed from the user.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/bpf.h      | 1 +
>  include/uapi/linux/bpf.h | 1 +
>  kernel/bpf/syscall.c     | 1 +
>  kernel/bpf/verifier.c    | 9 +++++++++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c06..fd53d1817f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1626,6 +1626,7 @@ struct bpf_prog_aux {
>  		struct work_struct work;
>  		struct rcu_head	rcu;
>  	};
> +	u64 fentry_func;
>  };
>  
>  struct bpf_prog {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 07ee73cdf9..7016e47a70 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1577,6 +1577,7 @@ union bpf_attr {
>  		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
>  		 */
>  		__s32		prog_token_fd;
> +		__aligned_u64	fentry_func;

since it can be used for fentry/fexit (I think from below?) might be
clearer to call it attach_func_addr or similar.

>  		/* The fd_array_cnt can be used to pass the length of the
>  		 * fd_array array. In this case all the [map] file descriptors
>  		 * passed in this array will be bound to the program, even if
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 9794446bc8..6c1e3572cc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2892,6 +2892,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
>  	prog->aux->attach_btf = attach_btf;
>  	prog->aux->attach_btf_id = attr->attach_btf_id;
> +	prog->aux->fentry_func = attr->fentry_func;
>  	prog->aux->dst_prog = dst_prog;
>  	prog->aux->dev_bound = !!attr->prog_ifindex;
>  	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b..507c281ddc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23304,6 +23304,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			} else {
>  				addr = kallsyms_lookup_name(tname);
>  			}
> +
> +			if (!addr && (prog->expected_attach_type == BPF_TRACE_FENTRY ||
> +					prog->expected_attach_type == BPF_TRACE_FEXIT)) {
> +				fname = kallsyms_lookup((unsigned long)prog->aux->fentry_func,
> +							NULL, NULL, NULL, trace_symbol);
> +				if (fname)
> +					addr = (long)prog->aux->fentry_func;


We should do some validation that the fname we get back matches the BTF
func name prefix (fname "foo.isra.0" matches "foo") I think?

> +			}
> +
>  			if (!addr) {
>  				module_put(mod);
>  				bpf_log(log,


