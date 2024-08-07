Return-Path: <bpf+bounces-36602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9A94AF33
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C401F22E89
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792013DDAF;
	Wed,  7 Aug 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhgTz0K+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZaSZRn3P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7E2F3E
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053262; cv=fail; b=MjK2kztwuwH6+5q1aIQBGkMTb0WcsSYneW18zl20RRs2LJDkM2GG8QD2rvD240b6V/Ra/aCykJcHR6BTZXaz30ukVehoEvLtSqOym9+2DU2gFi6/J4IAAZN0wTB7D6HupkNydXf6LCu4ImRxVO110mNiub6tOMO11WaVq6CDcvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053262; c=relaxed/simple;
	bh=1sVNIXiY2h2klY3STfPKc80yKP7Eiwsi2EVGJe0UsD0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9c2MDIBFy+CyvuMjkZxBfmEqzNQhmp97QhmqY9Qj1Ciou6Me5ftyGfb8gb6WrwA7iCEaEUDq+jfJ1OEcqtVJT9jjIzvAzSXYUfCXR6cROuO0hicACs8DcSzUeX4hM+7oneifq3AcNlXkzSdL8/mpypbiGNH98m6PfgUUAnUqCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nhgTz0K+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZaSZRn3P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HMaYF021429;
	Wed, 7 Aug 2024 17:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=8nUnod6WyqHY8Yyi9mwQV4WSmJkYoMZ21Xc2224UTpM=; b=
	nhgTz0K+v80JW8IO6PsmbQ75+sKyy5TIAuK8hAdEAocNIgyNpAbar1hN/fwNCtJJ
	tGSLReiiINehown29ft1mPLsd6ZidfV1v2FkWkROlxi58YYeE31IujyF2ytmYIlm
	xWlcZdrOoQAbtnEYNmWltYKfOU3bv79wn/uo27eQaYrlV7JJBoMsGuGi3zEkHswn
	aXh4R+naxMLx+cBj/apF86LKUk0dmbLm/s+mf6wK2SnlfKqvEDmXtx7+sa0EOY0F
	kWHlZCRxAA7FakbI/cDMzsXWzZMhY007E9p3xckjBXCCHvZ3nPPmXqZsRqAx5tbf
	r6oaB0adHzTAm4/G6NDR+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfar8df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:53:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477Hkh07018370;
	Wed, 7 Aug 2024 17:53:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0aa718-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXFnJtL394+WwoKE6dbHYlglhgQfUd/dwQTmO1B4NIvV3hDW2ECClgPhU3ccqrSep8k6R8qhcFNyIhhOO5CRjcQnu6ar+DfpjVKmgXntdj21SK6vZmj5Z3QVrnqH5tlGHi42tmQ4Ws1tOEX4nCIRNVV8iE8p3JQFhBdKRa1VRZ67y1yFIeU5Y0fD0iqe8VLAZhPyor52E3RJ1udeoklsszucjXh0C/YRKXxNNqtZLcyYrsTiCSxZeE2ELvdmvv4TufE1zZ+RQmMYBelfz8uIjs+altIevKRmXh0XzGYLbfzn2Sf2OzEEu/8IckRqUfxT3lKL3ty98u1Au8La7iLn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nUnod6WyqHY8Yyi9mwQV4WSmJkYoMZ21Xc2224UTpM=;
 b=PiEHrkpENQ+NtuK0uFCgDjDFKpHmE1Wl7KwS9IWbygsR6a01uKkn6X7gM3RtiO/OXAZ0WLCfClKdzAByjYU6OZKdC5VMMQH4x9U0qG+JBjaMZaJoFkPMuGtKtOb7CdapuAnQGU3qGufVy2SAvm1A1I20w2orTTDWwQFkFSLkJBMj+EK89CrMnxLhpdpumakWldzcQ364IOh1flxfqdzitg/bzYALs0cwUnyYMizuxt327j+wuN2JR5R73DQTEt5Dwq2c9F7k0Z6lgsadXCO7RN0Kl6p0qaV7O6Ta1qbdddyLE/xwbJ20Gq5GtDOvFbBL7373jVFdfTPV8lCWQcDHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nUnod6WyqHY8Yyi9mwQV4WSmJkYoMZ21Xc2224UTpM=;
 b=ZaSZRn3Ps9Y+dB7RTyfQjXkLj7gA+xOcD/th3vwqziNEYhzq+s/g20Ga1glWJlmHD+A7AKakFBxTk11RFjbv3aMRct+HEzwQ+MMlYB3asXuqcBWDy5omf4/z8FAHtBHa6+yW+ntAztr5EkT1Na95W3fc6C+cL6thGB/SQvhJYqc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4262.namprd10.prod.outlook.com (2603:10b6:610:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Wed, 7 Aug
 2024 17:53:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Wed, 7 Aug 2024
 17:53:47 +0000
Message-ID: <967f8fd6-409c-4428-9d4e-de1e1ce253fe@oracle.com>
Date: Wed, 7 Aug 2024 18:53:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf/bpf_get,set_sockopt: add option to set
 TCP-BPF sock ops flags
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org
References: <20240802152929.2695863-1-alan.maguire@oracle.com>
 <20240802152929.2695863-2-alan.maguire@oracle.com>
 <adb20c35-1533-4910-be40-d3f149049f54@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <adb20c35-1533-4910-be40-d3f149049f54@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0198.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3f5b8d-898b-4cfe-7dbd-08dcb709e32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1NDNXJ4RWtJb1ZhUjU5Z1VWdTNieHNXVjFVcW9qWFVxTXZmbHJtY3EzZGor?=
 =?utf-8?B?RDBYeDYvSXBjZkt0M2NPd0p6YWYzcXNyb1RQVDdtZG04NnlrL29mNm5TWnJw?=
 =?utf-8?B?RWdjYlc4dmlzRnZROThmNitpc3NoaCszeEZtYzEzQXNKc3hUd0tickxpaHhl?=
 =?utf-8?B?VnM3Y0VlTld0RG03NUk5QWRkT2lWTXRTQkNsUkErTnE2Q1pmdDViVmJPUzFu?=
 =?utf-8?B?NXdUd3BpK1JLTzJBKzlCbkRvKzViU21lM1ptY0NTRlVvY1NqT3dFbFg2c0pm?=
 =?utf-8?B?UUJpekpYdnl3SmU5cTBUQ3NPcGlsUzRhSzYwTGR3dWtQaWtQMExyYkVJVXZK?=
 =?utf-8?B?TlFnclE5TytWK0RmejlhUUNFWVBTZlVmSGE5RHFRVkVqVmFFOXIxUkNQQ0tH?=
 =?utf-8?B?VnlXajBWbnlvV21JVE1lTW1aUXFNM0dTaDhmUFJpVm9lMmlrM25Ga3h0K1Ju?=
 =?utf-8?B?cW9SdFUxR3VXaUhldE1oTGpWd1hQelpUMGpPOHVCeTZNK1ZDdUw4TkoydFZY?=
 =?utf-8?B?UW9GSEVrZEQyMktsemhhOFdXOFlISnd6U3RCWDRkeklJL0pDZGpMU3RMN3RM?=
 =?utf-8?B?SWg2L3BOV0o4S01FSEJWOUU1WkxZTVZZSW1wMFNIYlJjcUw4SlFKRWY1Y2Vo?=
 =?utf-8?B?YVFNdjY1bDU4am5sVHBHS3VnY1A1anQ5UXMyNWtUdjBISUlyT3NSSXhId2Q0?=
 =?utf-8?B?K3R1WVJ3bTlwWStDTEdKTGMrVTcrRWo0bGpCbm91cExCSzF1eEJZeHNRWjR5?=
 =?utf-8?B?azdWWjhMSVljQlpqYTdOQVFRM0VFNkxnL3JJbUxJUTlXSjFnbEZXQ3RRektZ?=
 =?utf-8?B?dm5OcGVYRElabGlJdDh3U1Z2Z0ZEWGxRVEtrNllEWE1BWDBwQVdOZHBFTWJB?=
 =?utf-8?B?Vm1lZUVlcS9FbDlDVmlqaE5EMDRBbVlOK3Zldm1VcG9HaDM0SVJ0STB1dFZI?=
 =?utf-8?B?ckNiNHQvMDYwLzArRFV2dXJwL1lsNkgreC9ML1VYcWRZcm5JbFpNU1BFVFR4?=
 =?utf-8?B?cXNPSE9nYzE4V2hZeFpqbUlJMVl6MlJHYXN1MjFodjgxSUkxWFBaV2hxMksz?=
 =?utf-8?B?UStwaHZBWGI3SFRpdzBkRHlUT3FvK2ZPR08vZlRxMGVONDIyQ2RkRUdVemFu?=
 =?utf-8?B?WnBZZ2pZVUMxci8ySVR4cFRjbzFia3p0Y2h2NVk5VGNLWktzL0dFTG9vTzI5?=
 =?utf-8?B?a3RVVjBrVG1kZlJWUmNkWWNxb3BrV2xvdzc1bDcrTXMwZFNBQ2taQ3Y4c3ZP?=
 =?utf-8?B?ZWJXWWFhdVNUNHF1Zi9hRng5eVd1ODFaSjhhYzVYRnI5cmRDSi91N05ZaTVi?=
 =?utf-8?B?VnZXNktleWQ4OVNvS3BFVE5mZ2ZaNzZua0FwTGxDZldlWGNzVHE2TytVbkNO?=
 =?utf-8?B?U2UzRkNDY0l2dkpobmNVWjBsRWZPNUJQZFJCR3hBTFptSjNiYjZZb2tMUVlm?=
 =?utf-8?B?dk5TV3phUE9YRzZDU2RGQkdUS0pBMDkvZFYxTWtRYTdNT3hNVlZJV1BtdENF?=
 =?utf-8?B?NE0vb0dJVCtlVmk4SGFxNko5WnNNQ3FTZUxJdFZKWTdQNG16dllHYTNSd25m?=
 =?utf-8?B?YTFLVDgvR09CU1QwVTczWXJ2bTJrb1pMdFRscGt2a2hpeVh1QWlhVWQ1dnRw?=
 =?utf-8?B?S05wWVMyUEsxeXcrdjQwdUQ1bjVVTlQ3ampZdnVYNHd6cnNrb2RWTmtIODk0?=
 =?utf-8?B?eDhneWUvL3ByaDZTdGZnZklyUVpscjNTczQ0Rm9vYmdPNUF3cVBWdnk0emo2?=
 =?utf-8?B?K3FUd3FNQmtuTytjQm9RVUJtZG5WT1JTUUVxTEc2WVNlUUN0cFZmdzRuZjIx?=
 =?utf-8?B?cG9DZi91ejVpT3dPalhiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm9zMTNvVCsvVGJpeDJhRTEyaUhpaWRtNldhS28yVUJta0M4d01mbnpRZEg0?=
 =?utf-8?B?RitZM2k4dngwRkI1ZlpTbER3L21yVUNTNUY1TmIzZk5wMmdZSHNxZ241SmlW?=
 =?utf-8?B?QWMwdnEzZFZUb0c0WmorQ0o4dHhaWWxHdStYUGlJOFIreTFwbnNlcy8ySkhX?=
 =?utf-8?B?N2ljZXJhamxhTmhYM2x6dUxCSmVXM2pSa0lNNmlyWUtmZkV5SWc0NmdJSGp2?=
 =?utf-8?B?c3hiNUdVK2RvY0MxdU50b01Bd0VHaWJ3V08wNHJoVjdZbGl2M1FWaW1yc3dx?=
 =?utf-8?B?NXpXZitjSmFzMU1MSmFweng2cHV3OGs4QzBFTDJhZmcxazB1aEhOcERzT0RU?=
 =?utf-8?B?VTROcUJMYjl1d2g1RjF4amg5Mys1UEhwUkI3UFdQdmdMalYxVkpCSXI0N2hP?=
 =?utf-8?B?aWdpT2NoejRNY0dYSFA2RWJXdEUrWEo2NUpnNkpsaEJQWUE4MnpiZDd4cVlv?=
 =?utf-8?B?S2p5RFk4L25wKzVndHNHR0xqRk5BTDhmTGZzYjh3ZzcxaXdMRUZmRElJakZF?=
 =?utf-8?B?d3d3WExoWU5nejZqZHRuc0VodzlBUE9NTUcrck5yNVZWbzgzMzJLM0tzQzNK?=
 =?utf-8?B?d2xua0ZDdEJLdGY0NE5oWTBkSGpiWDlMZGNHb0grRmRWd0VJSDUxbHdFYkJ2?=
 =?utf-8?B?bFBHZHUwNFgzZ1NDTmY1dnNROFQwS2JaeGhnOGttaFp0N2hGU3QwQzJ4N3Zk?=
 =?utf-8?B?QnUxbkZtZ0YyL0U2OExJUXBrYm5rK2FDREs2S2lORDI3K3JGZmkyMjJZaW9E?=
 =?utf-8?B?OU9QODZ1UlkxU00rL1EzNndYN016UEhSVlZQVkJjVUsvbzdDL3ByTTZPTE8x?=
 =?utf-8?B?SkV2UzFVOGh6MElpbG1mMUxGODZMV05LTW5udC9MMnNPSms4aFJ3dFhGMGNa?=
 =?utf-8?B?MlVZcjJTdk5IUEprNGFiSG1WRURrOEVpdGRmY3ZET2lIcW93dCt5VlI3NUxI?=
 =?utf-8?B?dmRHZjI4UzFZallaRi9WcFdqUXpqZUJFUVdlS0pKazdqajlZVFM0TTgyaXBv?=
 =?utf-8?B?TEZxUW9nZnFielhJUnRaVm8rdUxnNG9yL1hrYUF4NjQySVJESDlxTnVrYWRu?=
 =?utf-8?B?VTMxYm9DR0ZCR1R1cGlBVGMyVEJ6dCt1T3lyc1p4MENwc0FnZjZYMGZ5NW1X?=
 =?utf-8?B?elpidGtKc1RQYTRvVFF2REh4cmhwVFVGSEliblMxMGx3SFNPZVB4ckF2RDB0?=
 =?utf-8?B?OGFqK3BrL2pyRUFSSE5Sd3BVVjNJRjhOODdwa1U4TzhFTzkwUldmd0l1b2Zy?=
 =?utf-8?B?QXV3dTZUbHY5Tm5BNWN1SEZabjh0ejVqOGl6U3p3YXJhY1JzQ0NHV2R1c05R?=
 =?utf-8?B?OS9IdXNucXpMclpVQWlmTnd0YnY1T081VW1MMlVsaGNna2lzWWR0K0s1SFhH?=
 =?utf-8?B?Z29xYWJhRFVQWGZZL24xVTJXemgwMHVDd01VeFBhU1N3Uk1VUnVDVzY2eS9O?=
 =?utf-8?B?UXVvS3NCcTFWYmQvQTlGeGNTV0hsc3NtK2pzaHR3cS9MMzMySUlSZUkrTXo0?=
 =?utf-8?B?ZE9yaWdabkNuMmk5R3lMR0s2SUZFdEN4WTlaRlZ5cHpsSVF0dnRyY0VvUk10?=
 =?utf-8?B?a1d4aU11MFFyb3pVSnNka0NieVBmK3Nxekp4NTQrS3gzeGpHajNHMWtKaXFj?=
 =?utf-8?B?OS9ESDV5U2hqWVdBMm5RR0k0L25xUjhjN0czYzNDNUJ2QUw5dFdPVmdzRlRY?=
 =?utf-8?B?b1R0Ympac2x0RnBWOTYzZng3cWo3ZVpRUTVxa2FmZU1wZHRjMGVKK1ZMMi9Z?=
 =?utf-8?B?Yis2WjIrVWI0V3kwUDl1WjRNdm53K2RJRDl4Rjc4bWt6dlRBbUMyQXl4c2Zn?=
 =?utf-8?B?bVFWQU9ta08yd2VmNzZmdXkxcEIra054aWJMWXBCTTR4YW01TUk4NUlLRWxM?=
 =?utf-8?B?dWlHZ1J4NDg5QkU4ZStyTUZULzFoZXVMYnZwNmZyMWp1cVJyYUdMRncraUZ6?=
 =?utf-8?B?aGZjZDZYVzBiRFJQRUFCWlo0bEtHcU5uM2hLZE9wWkZmL1Z3aGlaVEdXSTc3?=
 =?utf-8?B?dVo0RmFYTjZvR3FBeEFleEE3aE00dGUzVmJhTDNQLytDZ2F0dThQM1F2YjlT?=
 =?utf-8?B?eTlCRjViakp4WDNHWWNYZVNNQUM5QkZjNkpNTnJiZmkzekFtWEFqWFRqZ1dv?=
 =?utf-8?B?YTNsbjMxaHdKNGZ4S0RKZCtTdnZVVTcrY3ZTT21jWHZoQmt6NmRMZmtMeWdS?=
 =?utf-8?Q?151q2VYbvxY6Jog9L7Lgitk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sFximGoZddc3TeVqKVWJt+O/cZF6SjlLZ1nM0/QEPWkXn2Q0okmW/G2d7VQEzHUP6YU4nQ0N+adlhHSWUU0ZWeJVUsIQtk7I1fJb8xMC5af9wcOSWawCC4y3am9BLeMOqMQzhFxEvHdhCxbT/JENq8Z70ebHLMZIk/bNU1tsJ7rxATpmzny5PBhFtwyOSTMe+4OmhGHJLGkYP4nKIbEgKjTbiiUL39EZ/Ldq3xfRyuV2OrdqM7YrX1qSISelZ9Ox02UO4ncmZbizdpgEqjGbinlMUw/N1lOupDQfMh7gy1YQ4oWCjSn12E8KBkQZX7oCF1LZp5epdPlRao/4wSGeBFRjsW65K2ESC46bGx8AR9w5qSuoquMGHgxTefeP5WTaIKSxtPreR0AIZeFnJwAx72Cr6643Op14xgzunYofxcZv6Lmlz+VimMHnmKWHOGtH+MwbQ6ceikAEBpubg+PYyrD1sZK6/NDA0NzE/KAOMH2o+daAwECAUoRRNteCTEXSCuUvLMphiJ3Jd4SLZT2NhrF5gPWguEvB5ucYrt/IdC/sLsiBxclAON0muy5lp6siA2xklpCqxq9QRGbHoS3xjEJhuDvhnFJ/UdW+QggfY4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f5b8d-898b-4cfe-7dbd-08dcb709e32c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 17:53:47.6285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSa8zSZo8w7pXRkLtK3xrxy3PhwOdqPbiTYj5s9QkdzJ3LfmjYVpPmwCzJltusZB+CEi6cQnpydvP7w1kBGd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070124
X-Proofpoint-GUID: P5c35vjuIV0JENs4r2fuVdl2KxRZui6C
X-Proofpoint-ORIG-GUID: P5c35vjuIV0JENs4r2fuVdl2KxRZui6C

On 06/08/2024 20:54, Martin KaFai Lau wrote:
> On 8/2/24 8:29 AM, Alan Maguire wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 78a6f746ea0b..570ca3f12175 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5278,6 +5278,11 @@ static int bpf_sol_tcp_setsockopt(struct sock
>> *sk, int optname,
>>               return -EINVAL;
>>           inet_csk(sk)->icsk_rto_min = timeout;
>>           break;
>> +    case TCP_BPF_SOCK_OPS_CB_FLAGS:
>> +        if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
>> +            return -EINVAL;
>> +        tp->bpf_sock_ops_cb_flags = val;
>> +        break;
>>       default:
>>           return -EINVAL;
>>       }
>> @@ -5366,6 +5371,17 @@ static int sol_tcp_sockopt(struct sock *sk, int
>> optname,
>>           if (*optlen < 1)
>>               return -EINVAL;
>>           break;
>> +    case TCP_BPF_SOCK_OPS_CB_FLAGS:
>> +        if (*optlen != sizeof(int))
>> +            return -EINVAL;
>> +        if (getopt) {
>> +            struct tcp_sock *tp = tcp_sk(sk);
>> +            int val = READ_ONCE(tp->bpf_sock_ops_cb_flags);
> 
> READ_ONCE() here looks suspicious. There is no existing WRITE_ONCE.
> 
> Is it needed? The read here should have already passed the
> sock_owned_by_me test. The existing write side should also have the
> sock_owned_by_me.
> 
>

Yep, you're right. Will remove for v2. Thanks for taking a look!


