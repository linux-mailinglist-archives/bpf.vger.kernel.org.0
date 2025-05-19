Return-Path: <bpf+bounces-58483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17EABBD38
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 14:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5381886266
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C27275870;
	Mon, 19 May 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CyH0OGkb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kypvAxWB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1126FA74;
	Mon, 19 May 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656164; cv=fail; b=GfmPoRVOMrmToTTbABgLco0yT+RRpX33CyLzH9MFD+4MTFevJnGBSh0MpAnFf7BSSyBy9yD70ixSX7FoyimtNC0YrmJTahEMtRuZFSX4yL+77DbAAml7ncpHlNY70H9BUnf0ToM9cG8QV+Xl0dI1UPORi+FGQghHZoFUXxDZWO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656164; c=relaxed/simple;
	bh=98zQKZOIFGvlrohQSoDpfn++PfokxsxM3hHn8ndac6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRwrCwnspZmo7MRToJCpcLn6tNL5qNtnZjhMKmzrbKtTT1daPmucLrOM6YwQivpfYhwOS6Vxsbh6KrVwe6BBRnate4CvXasG7s2JBf5aCIxqgNJYXDtUZxkwvBIm/ZI2QwCqt6S9IF/S6WJED5KP0GHd5ykc80UNPmgvxq7y2b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CyH0OGkb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kypvAxWB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6j0kD015330;
	Mon, 19 May 2025 12:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e7JEqulqYgBi/g3xifLP9Eiqy1SO0c7Oe3vx/lYqc+0=; b=
	CyH0OGkbpJe8deTb64GAxWVeoPlK5N9Qe6g8L1ihEU01KuXJBsg3+i6MbnvZvwZ1
	b2TCF3brfXbN5czdnsN7rJ7h/fOifoKB/bciUncd6GG4ojKmyfvErDrz3am8BPyK
	fR1ZsDMZkLxGT1+cJQ5j8G+BDrHamOjDfP0FWz89Zbu0QdTbfBPwmyrViQInagUr
	rcMSoLdUeXmOV/G5BH2On6gegNB264ElS/FUA6pGJUqaMf/q6wNZpwMfw/qneIUC
	2Z/jO9tih+Smt+b0AU7O/1tYI/LriNUZ5WiTho1awXvchCe9WnX0RXlt9rFR9QNo
	U6hVBKHkD/mCpPHunYRTug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge2ts8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 12:02:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JBkke1037232;
	Mon, 19 May 2025 12:02:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7bhpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 12:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBVuCSljLQN+HXc+T3f3sTytZj2FfpT3kHb2EqrDVDhSlbPAJe/Aq984481lHsKrUOkNL/FitdUj1qdWbXFfCb7PUchnBPTbQampI7963AcmzIOyVdeloS+PiHTntmSrblL0rQps6crOtl/ne0yKQTkH38BzTc1JlDmvzSsaT+VPK/2XpY+MKRdKyBCdaDvmaun5O95HunSOgmKzzn2RUleyk0+eRqu9bP1/18osPJDxlAYsoZ4QZdpyFtDhZB89wr0h/pPxMkTTK0/nZJNWiR43DBfI13rgAB2l3wfrY/kRoXPdF1PEgiwztu4+eY1Rsl9CwmF9XZ5I1uAxFJ4/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7JEqulqYgBi/g3xifLP9Eiqy1SO0c7Oe3vx/lYqc+0=;
 b=VHDX9c7fOCYReMwghZjmG3p22U9+0NcZ/NZUg4ZreTNKB3oyoeo5+8SrlbvJ0S+nK0Wgh7OYpxMdck5GRJwr1XO7m3hFB2AB/D7RxY1rU3LXNC8vXVzUhMA7YM+B3bhb4teleBzepJhN3vy3SfnECE3QGO+/5szU6iOa3FROQQtIm6Y74vVrKaF25p4dJ/KyHahTG1TJ88VDcdmpR5fuzCNDco1Nun20opkKZGZ2XVHIt8kFrKgtLxylhcbAme5DrDtld3ud/9/6/SbuK2gOPzQrUwI7UoCjJjdugu4GrpTKRRKjepRV4xkMlQ5q/AVBDxJQBEO5iEhWIvoPp5/kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7JEqulqYgBi/g3xifLP9Eiqy1SO0c7Oe3vx/lYqc+0=;
 b=kypvAxWBMUemHWdt5ACMTGIberS1dkXKdjL2fFOhwDfqnDJdwl5Og+dtqFKn7xYx7dWew/KTUuIaz/Ia/RdP5iJlOWlkrj6h2acPdvFe9eghQPn6bv/vJhFiuOqXUhj4gXVF4CDK6/0hKHr1lYdUvBVhjGwwclMzkX2okkG5Nxg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6785.namprd10.prod.outlook.com (2603:10b6:610:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:02:15 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 12:02:15 +0000
Message-ID: <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
Date: Mon, 19 May 2025 13:02:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: ttreyer@meta.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, yhs@meta.com, andrii@kernel.org,
        ihor.solodrai@linux.dev, songliubraving@meta.com, mykolal@meta.com
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f317aa-385a-49ae-4fab-08dd96ccfe0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TytOcFBlUlpmZ2JCeGRFbzYvQmRyY3MyU0FST0J0MVZyTWFSTnJQQnZrRXV1?=
 =?utf-8?B?dUYyb2l6aUZTQldPczBwQ05sOUlZTC9SMWZkMTM0TWZxdDBhRjhGZld3TndV?=
 =?utf-8?B?dkgxZUIxUEFXNUVDODZjZC9YNU56SDlLVUl0aDRZZ0FVcTByb1JPMFFjSG40?=
 =?utf-8?B?eXhoM0JlcVJ3ZFp1U0c5R1c3c2xtaGVURHZqUm5Lenc1YkYxWUVhUW5sbkxa?=
 =?utf-8?B?bEFtdFdIY2RDQmgzanNvZHYzUWYyK1R6ckJPSmdUcitzaStPYlRySytDNGFr?=
 =?utf-8?B?ODQwTUdGVkNKZUhkV2FmdDZzQTBDb3k5UDg3eGhkMWVUbTRVaktRQVJDVkpX?=
 =?utf-8?B?eml5L0NVQWJQYUFDZ1pIT0dkYnNQOUUvVFZRanZib3ZsbGJnTlc4Skp6US8v?=
 =?utf-8?B?K1BqYXZHOHJRSzlleUtvQ01YdUlYVHhUN0gveC9DSlE4V0pMaEpQUU90SlV2?=
 =?utf-8?B?ZEtsSnJib3lWN1ZFUzhLeHRzemRjNW1DTGxNQjdSZ2RNbFp2N0VKZ0phZ1Q0?=
 =?utf-8?B?QmdFbDRkNGh5YVZrbERsWjVLRlBwQ3ZzRW5SMkZOVjExNDBqVlp4eGt5UWpX?=
 =?utf-8?B?dEJ2ZTN6d3NsTlp0NEdTQUFXb1RsQnVlcW5tQ1J0RzJCcGtpay9ZMEpXeEZP?=
 =?utf-8?B?T0VvRmFyYXJQQkJJWTBWRnpJalZwVVZUMTFBaks0cmVpQUlsS1JVcXdyMitI?=
 =?utf-8?B?V2l1cm93ZjFiekNkYkJXV2w0SU9pVHlKRUF1Y3FWbDltZkJrYnF6UzNaSThF?=
 =?utf-8?B?dXFsd3dNOHNiTHZ6djBxNWN4em9seGhRb1V6S2Vtc1lDWmZRbWM3cUhPTnVM?=
 =?utf-8?B?YmxnbEM1a1FOZlVhL1EzZ3ptTkZCUEhodEN1TDZWam1ONlVPak1YQ1hxMzlr?=
 =?utf-8?B?N0UxYVBVdE9oZzVVcnRXTDBKUnVLSkFsMkxwWmZ6NUtBU2U0YzNvZDBhalV1?=
 =?utf-8?B?aEdMUHJ1c2lUVWh4VnVpUG5PRFNXaE5JVnFYSjlMcFlOY3VzWUxxTmRVTlhW?=
 =?utf-8?B?ZXYwVzBzYXR3b0o4WWRMa2tid21HdHdnT1M2Z1hPTmdray9uM2hySDQ3Sk5n?=
 =?utf-8?B?V01zMkR5UVE0WEp5aVVnQjNYWmJaaFNhSnI4TWRnQmM0cDh4TXpUaVZ4Y3hU?=
 =?utf-8?B?M1pZNGFzOFhxbjlEMUF0RURRa2doUElaMXkwd2M0RWxiLzZBTmVGSDAzVG93?=
 =?utf-8?B?dFVpeGZRMTJPeDNhSjhnMXFnU2xuVUtkYVJkNyt4VVdqTFdqNTRvdjhjZEVG?=
 =?utf-8?B?RUJUWHA2bVdtbktiMm8yR0xOUTBTd203bi9hZ2tBZnh5TVpPVjFSSS9vSVFM?=
 =?utf-8?B?bG1LQi9UNU43T2RQdkNCdEtLSmlROVc5Ty9vZnJnSlZ0bVgyRHpHam55SUJw?=
 =?utf-8?B?RUZYZGdnb2Z5UzZpRUFJQW9SQlNTcFNsWld1eit4cTlVVm5mMC81Z3B0d1lP?=
 =?utf-8?B?SEhadEJTS0xiOFVpUTRsK1FYSnlvZFNjV0s3eFA5MVpyclRKRmhmc1ZoZ1hy?=
 =?utf-8?B?N3hwL3c0TG5OSFMvR3hZQkJRekpyY244R3RYTWhuRnNrR2wvMGhYdnlETHpC?=
 =?utf-8?B?dnVodmZUNXJoQldRZzJ0TzRiQkg4M21YdkRCZEk5UGdRRFYranZrUTNXcHJw?=
 =?utf-8?B?ZU41Z3hjdnVaTUN4Wmw4ek02ck9LdWRlellVQ2JxTVJHRkRVR0ZyL2E2TzRY?=
 =?utf-8?B?SHIyamRTOW1JY3N4VDdVdjNSWlNJUERPNGZWTWVPYkhId0JnN2VPMkNNb0lO?=
 =?utf-8?B?Z2E3eVpPcmRSazR5UGdmRzlpbEloUnBuYUdhcCtqUFFQb2NqYjFheGx2UGUr?=
 =?utf-8?B?eW92a0tBZEIrTjhWbVkvd0pDZUVvQ2xubnRiMFgzVjZRcHBRN0JWNVdvMlRD?=
 =?utf-8?B?Z2NObXNqVkpKUUhZOEJFSUpiRy8yU3I3Q3NFenhoVG5iNnJiVVhTaXdwdndE?=
 =?utf-8?Q?VKEQG8lE9ik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9CUjYvNnE5MlRsUjJkbTFEenBsYVc2Skp5K25LK2lCRUxTSXJsb0dCWGN4?=
 =?utf-8?B?eHR6WW5tQWhVc1BmR2FzN2JmY3VzR0luR2lqTncza1VpU0lySUlyUXNPV2pj?=
 =?utf-8?B?SmJEZjlhbEZxT01zZzl4TC9kL0hEdDJzc3N1U2lYaHZrVGVZWHg5UzdVMDg0?=
 =?utf-8?B?U240YzVMRTcrZzB1QzNaQmNML2ZSdGxDUEVTSVBoV2RXNlJKS0VBb3lDK1N2?=
 =?utf-8?B?RHRZYnp0RHJCOWRMWXJuQ0JPR3FDUEc2cFpweERqWlZBb21vTGt4NUdxLzhP?=
 =?utf-8?B?cUdBVit6cnNQQjVzdkx6SlE5aUswZ0c1eXc5N1V2VnZWcHRaNWEzTFhyeFFt?=
 =?utf-8?B?ZkJLRWlKbWxld21ydC83cy9mZmkvajJvOU9PT2QwZE8wQjFQaGgzTFRMVUt6?=
 =?utf-8?B?a0tZQzkvc21scm1DR3VSaDRCbGkzUHdyQjlKWVdBK3dtcnRhUDFYSXlsci9Z?=
 =?utf-8?B?T3pYQjdvbG8yYStiSCtpckpkUnJXV0srZVNRWE9IVTN5UlZON0JZdEFqSEFz?=
 =?utf-8?B?dUVBdlpjT3RPMWp4MDdmNTVIdTVBRkFrdEJSTWZYYlhYK1VQT0hJRytzV1F4?=
 =?utf-8?B?eEc5eWJ4akpBZFgvTk5pdXZmN0VRUUtQNEdCUzdNVFVNTzZ4MlFrek43ekpI?=
 =?utf-8?B?ZEQxamMraUthV0NhdXl1UHIzUnY2S2QxSlBvRk9wOG5PMGtmMnFRQ2F6K1ox?=
 =?utf-8?B?clN5d0tkQW1Dc1JqMDJtbGFBSlhzTCtSaTRTd0xDZENZeEVNa2lVSWRkWFlG?=
 =?utf-8?B?MmpKVkxNZXRxUFBhbUp4M09DVlNFMGJPMVhYZFRWaCtKVkJ2TTBoc3pHNWZU?=
 =?utf-8?B?SFh1c013cEZwdE1FaEppYmtlWmVFVHNXMXVKTUNSVkVWcXFSeTN6cVIvY293?=
 =?utf-8?B?dGtVbUlUaXd1WGQxdmxtaDVNYTF2R0pRTXpVUDlkQ0crTjU3djk5aHZTZi9a?=
 =?utf-8?B?azZTY1lhdEdqUXVMK3ZaNjhBTy9lYmZ6YmowQ2pVVVVqZUZiTHFUWTZSbUVu?=
 =?utf-8?B?VW9ZRHIyVDcxWlRsZGUyREJVZzRWbTdXNGZQV2xoZmhUa3lybVh2endSdmdu?=
 =?utf-8?B?NnJ5L2tocG0zY1NJbTk4ckYvTWlJQ2hhMk9DOEZCNFc2eEN5bnhaTFNRSkd2?=
 =?utf-8?B?c0w2SXFLMmxzbE9sMnJObTJLejA5azR2V2ZGZzlCWExtY1BFWEU2dHNlaEo0?=
 =?utf-8?B?alNLQk9jMTdZUE9mcW4vZm1lRGI3UmlrVW9OMGR4Ulpua2d1b1kwYWtWQUFX?=
 =?utf-8?B?VkN5K29pb2RHVjFwMUtSTjZ6c1FxNWtha2d4NHBVY2xjWVZkU3JmK05EajM5?=
 =?utf-8?B?ck5EWCsxVkFJWm5qQmlkWjBjMEw5M3lwbnVpUHRZb0xrdDNRSFBrS3IrYldT?=
 =?utf-8?B?RERpSndKZFBLTUFjdTdleHIyNFFXcTQySDB1TFhpUGhpNVV4b2g2ZHJQemlT?=
 =?utf-8?B?TTV6T2pVQ2tFbHZ6RmIrRmdXczlrS2N1QVdIQTN6Um05M0JoUFNWOE5POFF1?=
 =?utf-8?B?cGlYUUxrdVpOamVDU1E0MXBJSEhOZUo2VXdYTXBGZVgzUy9URGZLQnc3R3R1?=
 =?utf-8?B?cUdqajJCWHloeWdFbUQrbVNEVzQvR09BRkJ4RkxtWHFzZGdCbDRuTnp3alZ3?=
 =?utf-8?B?S0FZdTZ4MVVNd2dQdFczQWVIZiswclh2WGE2ajBMcWVNV1pVNHNPNkdLcVYw?=
 =?utf-8?B?WTFoeEw4akljOGwybVF4alhrZmFaV0FETnE1aXlVVElTcXcxbkZydkZyaWI1?=
 =?utf-8?B?UWswbFM0bGt4Vkh6dXFiQVhacG9STk14UnJhTmJUWTh3djVpT2k1dm1jQW9V?=
 =?utf-8?B?QnlqQzlTZVlBUnZmclNLL2dtN3BlcTVzWHR5Q3ovZmRsKzZkMVE0dERSM3JV?=
 =?utf-8?B?SmF3RWhLanBNR25yOFRrV09malBUbDVFTytQUUcvQVF5ZjYwT2xjMzF6emdV?=
 =?utf-8?B?N3RhNUlYL3lyRmhNdG1JTGRDaGhTeis0b3p5TWZodHRFakxRLytXTmc3Tkty?=
 =?utf-8?B?anNSanhHaTltb1orNzBBZGJrWm12TFpBckFLc1VQNkVKUTJhN2hRMHNSK2Vl?=
 =?utf-8?B?NnJNMmNYWllrKzJQdTFWV01SQ0ZoenFWQ2NrSlU5LzhwbDhkRk5tdGFIbThv?=
 =?utf-8?B?RldTTWNScCtUZ0pkWnFRQlNyY3AzQ3Z3TWNneVVpVzlKd3lQak5yN2RpZ2JP?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6DRKUIKBpFreaWvnx85xk1GYzgvCQb5zvpjyXcxB4hMrH+5GoKD1CcosElGB+YivuuWPn/WevOgM/sk6ZXwbMuC9L7077dG2qRCIHbbzsL+sQXO6nOZhloBm+/Z9H3nHMPiG5W1Yp0R8rVxUb4QA1Zyrhn7APB06j/TphkZKDG2Kawr6ZkODHW+TYepBhOQeL36l8mrFBsGvEUZiISRvwpKu8Ovny0sEIguDalAzWLUAzFzoZilnmZW3mSHVNegPBzPoeQ4YgJhIFe+8B9rW+w3x7x2graj2WSmcZEWA/9aZd8ytrlAaByKrJWa6RLDwO4ZVRQtvc1hwHi8JZCzi1j/paC1bwNrYOIphyOcIjCcQtTtxSLui6+S5291blP7Aws7GMhHm6R9Gt3F9sqw5+o3ArolQTxfXxu44Yrcs+tgb6/0C8hsvUDEFfDnxgdQDdve07JREjJLwufzIb+dI1UW12OAYofkI8frkT9HHeO75V989Y3QFESaUJCyfhOHZiorw7pDUtWoTCLBUp7UJ/IpAgnp3m36b21omG97gNQUnCB/WnCNrOWWbo131chbAiVOLp3waiEnhvRaVZSzugWYYtXDRyL/7UX9Mk1P6TQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f317aa-385a-49ae-4fab-08dd96ccfe0b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 12:02:15.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPHZlZ7Dui1J1IvqWHnnncymY/ecYKCRVmSkW+PhGRWUotCaCnv07RY4gMtY0ygsjvoLNfyXWFrG2bxBN2g7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190112
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682b1dca b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VabnemYjAAAA:8 a=nfwdvwjwITu5WpyiivcA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDExMyBTYWx0ZWRfX5gbOzEUcCz/t 6JvBZq/11sdbZoXxq/sHCVheO7cIMjnNXCCFhsweld53iRO6+c4rXDc08z//j5KKZD4thALRUbs WdbOOEd6fdxq2POKM1mJfbtsltV3kULgxgQCiHjhtSj7aIt9E6dhi6EWs67r2u9phA2i4sjpJBG
 yaibYugNVUx7Xa5jEaAs26OjMGqfrJC5WA8GYZDvW6OBO0502MI1EvsiU/tunIc/rqw3Yx6wf77 c7VwXzBdhdXguqvN8cw5i2i5JBZ4mgQi8E6akMuow3XlUzKUAgF/vTxVGs8Mr0bBqevGrCtnMty TdenOw2IWfij/HwlSL/n2aD1YcRnHDzepLInDTyJ5Y3L9pcs9BWqCcvL0XQn223LrEYZibxRasp
 9zsfh8NzumP1ssckPwrOWUX/UYcDIUkjKW9ANHubCA1/TKNrUV+A3tQ1QZgaiu0v1W9AF6TD
X-Proofpoint-ORIG-GUID: FR1W2LIdGeIb5FdAYSOtj5V2Mq-N4Ydt
X-Proofpoint-GUID: FR1W2LIdGeIb5FdAYSOtj5V2Mq-N4Ydt

hi folks

I just wanted to try and capture some of the discussion from last week's
BPF office hours where we talked about this and hopefully we can
together plot a path forward that supports inline representation and
helps us fix some other long-standing issues with more complex function
representation. If I've missed anything important or if anything looks
wrong, please do chime in!

In discussing this, we concluded that

- separating the complex function representations into a separate .BTF
section (.BTF.func_aux or something like it) would be valuable since it
means tracers can continue to interact with existing function
representations that have a straightforward relationship between their
parameters and calling conventions stored in the .BTF section, and can
optionally also utilize the auxiliary function information in .BTF.func_aux

- this gives us a bit more freedom to add new kinds etc to that
auxiliary function info, and also to control unauthorized access that
might be able to retrieve a function address or other potentially
sensitive info from the aux function data

- it also means that the only kernel support we would likely initially
need to add would be to allow reading of
/sys/kernel/btf/vmlinux.func_aux , likely via a dummy module supporting
sysfs read.

- for modules, we would need to support multi-split BTF, i.e split BTF
in .BTF.func_aux in the module that sits atop the .BTF section of the
module which in turn sits atop the vmlinux BTF.  Again only userspace
and tooling support would likely be needed as a first step. I'm looking
at this now and it may require no or minimal code changes to libbpf,
just testing of the feature.  bpftool and pahole would need to support a
means of specifying multiple base BTFs in order, but that seems doable too.

We were less conclusive on the final form of the representation, but it
would ideally help support fully and partially inlined representations
and other situations we have today where the calling
convention-specified registers and the function parameters do not
cleanly line up. Today we leave such representations out of BTF but a
location representation would allow us to add them back in. Similarly
for functions with the same name but different signatures, having a
function address to clarify which signature goes with which site will help.

Again we don't have to solve all these problems at once but having them
in mind as we figure out the right form of the representation will help.

Something along the lines of the variable section where we have triples
of <function type id, site address, location BTF id> for each function
site will play a role. Again the exact form of the location data is TBD,
but we can experiment here to maximize compactness. Andrii pointed out a
BTF kind representation may waste bytes; for example a location will
likely not require a name offset string representation. Could be an
index into an array of location descriptions perhaps. Would be nice to
make use of dedup for locations too, likely within pahole rather than
BTF dedup proper. An empirical question is how much dedup will help,
likely we will just have to try and see.

So based on this I think our next steps are:

1. add address info to pahole; I'm working on a proof-of-concept on this
hope to have a newer version out this week. Address info would be needed
for functions that we wish to represent in the aux section as a way of
associating a function site with a location representation.
2. refine the representation of inline info, exploring adding new
kind(s) to UAPI btf.h if needed. This would likely mean new APIs in
libbpf to add locations and function site info.
3. explore multi-split BTF, adding libbpf-related tests for
creation/manipulation of split BTF where the base is another split BTF.
Multi-split BTF would be needed for module function aux info

I'm hoping we can remove any blocks to further progress; task 3 above
can be tackled in parallel while we explore vmlinux inline
representation (multi-split is only needed for the module case where the
aux info is created atop the module split BTF). I'm hoping to have a bit
more done on task 1 later this week. So hopefully there's nothing here
that impedes making progress on the inline problem.

Again if there's anything I've missed above or that seems unclear,
please do follow up. It's really positive that we're tackling this issue
so I want to make sure that nothing gets in the way of progressing this.
Thanks again!

Alan


On 16/04/2025 20:20, Thierry Treyer via B4 Relay wrote:
> This proposal extends BTF to list the locations of inlined functions and
> their arguments in a new '.BTF.inline` section.
> 
> == Background ==
> 
> Inline functions are often a blind spot for profiling and tracing tools:
> * They cannot probe fully inlined functions.
>   The BTF contains no data about them.
> * They miss calls to partially inlined functions,
>   where a function has a symbol, but is also inlined in some callers.
> * They cannot account for time spent in inlined calls.
>   Instead, they report the time to the caller.
> * They don't provide a way to access the arguments of an inlined call.
> 
> The issue is exacerbated by Link-Time Optimization, which enables more
> inlining across Object files. One workaround is to disable inlining for
> the profiled functions, but that requires a whole kernel compilation and
> doesn't allow for iterative exploration.
> 
> The information required to solve the above problems is not easily
> accessible. It requires parsing most of the DWARF's '.debug_info` section,
> which is time consuming and not trivial.
> Instead, this proposal leverages and extends the existing information
> contained in '.BTF` (for typing) and '.BTF.ext` (for caller location),
> with information from a new section called '.BTF.inline`,
> listing inlined instances.
> 
> == .BTF.inline Section ==
> 
> The new '.BTF.inline` section has a layout similar to '.BTF`.
> 
>  off |0-bit      |16-bits  |24-bits  |32-bits                           |
> -----+-----------+---------+---------+----------------------------------+
> 0x00 |   magic   | version |  flags  |          header length           |
> 0x08 |      inline info offset       |        inline info length        |
> 0x10 |        location offset        |          location length         |
> -----+------------------------------------------------------------------+
>      ~                        inline info section                       ~
> -----+------------------------------------------------------------------+
>      ~                          location section                        ~
> -----+------------------------------------------------------------------+
> 
> It starts with a header (see 'struct btf_inline_header`),
> followed by two subsections:
> 1. The 'Inline Info' section contains an entry for each inlined function.
>    Each entry describes the instance's location in its caller and is
>    followed by the offsets in the 'Location' section of the parameters
>    location expressions. See 'struct btf_inline_instance`.
> 2. The 'Location' section contains location expressions describing how
>    to retrieve the value of a parameter. The expressions are NULL-
>    terminated and are adressed similarly to '.BTF`'s string table.
> 
> struct btf_inline_header {
>   uint16_t magic;
>   uint8_t version, flags;
>   uint32_t header_length;
>   uint32_t inline_info_offset, inline_info_length;
>   uint32_t location_offset, location_length;
> };
> 
> struct btf_inline_instance {
>   type_id_t callee_id;     // BTF id of the inlined function
>   type_id_t caller_id;     // BTF id of the caller
>   uint32_t caller_offset;  // offset of the callee within the caller
>   uint16_t nr_parms;       // number of parameters
> //uint32_t parm_location[nr_parms];  // offset of the location expression
> };                                   // in 'Location' for each parameter
> 
> == Location Expressions ==
> 
> We looked at the DWARF location expressions for the arguments of inlined
> instances having <= 100 instances, on a production kernel v6.9.0. This
> yielded 176,800 instances with 269,327 arguments. We learned that most
> expressions are simple register access, perhaps with an offset. We would
> get access to 87% of the arguments by implementing literal and register.
> 
> Op. Category      Expr. Count    Expr. %
> ----------------------------------------
> literal                 10714      3.98%
> register+above         234698     87.14%
> arithmetic+above       239444     88.90%
> composite+above        240394     89.26%
> stack+above            242075     89.88%
> empty                   27252     10.12%
> 
> We propose to re-encode DWARF location expressions into a custom BTF
> location expression format. It operates on a stack of values, similar to
> DWARF's location expressions, but is stripped of unused operators,
> while allowing future expansions.
> 
> A location expression is composed of a series of operations, terminated
> by a NULL-byte/LOC_END_OF_EXPR operator. The very first expression in the
> 'Location' subsection must be an empty expression constisting only of
> LOC_END_OF_EXPR.
> 
> An operator is a tagged union: the tag describes the operation to carry
> out and the union contains the operands.
>  
>  ID | Operator Name        | Operands[...]
> ----+----------------------+-------------------------------------------
>   0 | LOC_END_OF_EXPR      | _none_
>   1 | LOC_SIGNED_CONST_1   |  s8: constant's value
>   2 | LOC_SIGNED_CONST_2   | s16: constant's value
>   3 | LOC_SIGNED_CONST_4   | s32: constant's value
>   4 | LOC_SIGNED_CONST_8   | s64: constant's value
>   5 | LOC_UNSIGNED_CONST_1 |  u8: constant's value
>   6 | LOC_UNSIGNED_CONST_2 | u16: constant's value
>   7 | LOC_UNSIGNED_CONST_4 | u32: constant's value
>   8 | LOC_UNSIGNED_CONST_8 | u64: constant's value
>   9 | LOC_REGISTER         |  u8: DWARF register number from the ABI
>  10 | LOC_REGISTER_OFFSET  |  u8: DWARF register number from the ABI
>                            | s64: offset added to the register's value
>  11 | LOC_DEREF            |  u8: size of the deref'd type
> 
> This list should be further expanded to include arithmetic operations.
> 
> Example: accessing a field at offset 12B from a struct whose adresse is
>          in the '%rdi` register, on amd64, has the following encoding:
> 
> [0x0a 0x05 0x000000000000000c] [0x0b 0x04] [0x00]
>  |    |    ` Offset Added       |    |      ` LOC_END_OF_EXPR
>  |    ` Register Number         |    ` Size of Deref.
>  ` LOC_REGISTER_OFFSET          ` LOC_DEREF
> 
> == Summary ==
> 
> Combining the new information from '.BTF.inline` with the existing data
> from '.BTF` and '.BTF.ext`, tools will be able to locate inline functions
> and their arguments. Symbolizer can also use the data to display the
> functions inlined at a given address.
> 
> Fully inlined functions are not part of the BTF and thus are not covered
> by this proposal. Adding them to the BTF would enable their coverage and
> should be considered.
> 
> Signed-off-by: Thierry Treyer <ttreyer@meta.com>
> ---
> Thierry Treyer (3):
>       dwarf_loader: Add parameters list to inlined expansion
>       dwarf_loader: Add name to inline expansion
>       inline_encoder: Introduce inline encoder to emit BTF.inline
> 
>  CMakeLists.txt   |   3 +-
>  btf_encoder.c    |   5 +
>  btf_encoder.h    |   2 +
>  btf_inline.pk    |  55 ++++++
>  dwarf_loader.c   | 176 ++++++++++++--------
>  dwarves.c        |  26 +++
>  dwarves.h        |   7 +
>  inline_encoder.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  inline_encoder.h |  25 +++
>  pahole.c         |  40 ++++-
>  10 files changed, 765 insertions(+), 70 deletions(-)
> ---
> base-commit: 4ef47f84324e925051a55de10f9a4f44ef1da844
> change-id: 20250416-btf_inline-e5047eea9b6f
> 
> Best regards,


