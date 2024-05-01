Return-Path: <bpf+bounces-28386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C858F8B8F10
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F17281BFF
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298511B27D;
	Wed,  1 May 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIyS3NXJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IbAuEYkv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE723FBEA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584642; cv=fail; b=s9ZLIl5nqzfI3HvB9BcSVDk4RLUGAR6+8Cxg8F7Lvn2x5zOvwTTLpW/uTHGyzCAelzo91pTC93rxPOpwIUQesXk0k564oyipC6Yr23QwjVZKBux79UnEbISFK4y4P/lidXTkFK/HLJCJ9vvBD98l2d37GLt9cjJAhV9RWlvZNO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584642; c=relaxed/simple;
	bh=pBKNBmGPplPhDk8O7tUPQfO2DBAGc6L7eWWRFRwlwbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHolffCh6XUDfG5VSyclHlaiUZxlGNvizQVJqaM08KyUhLnJOfAB7BY0FO8rW6PILqgaCfWauAwtf0gOMXQamIPthIX2VrFsSh2RDkJXMoOyxb+woIFHaiTZguLvdxk0pWMpU3ZaLQTTgpiAkxSaThX/nzpfe9V3izE4lKb37ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIyS3NXJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IbAuEYkv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441AS3Ek030700;
	Wed, 1 May 2024 17:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=P7nAJLfgchrqy36ZGWPuEEX3yzF+ZJC8zJ4sLS8CKAA=;
 b=mIyS3NXJtYEljLUubAXewM5FbO0UVIHRLHRAfxKEyT3Kd1PV3vdHLqF8/3wfn8+r1yW3
 Wf1nej5GCCAcJbOr4soM/k8HT130tRDkjHj6YHqvwUc3GwTX6MMvvsU9JZS87PjvTDT4
 NPK6rATtzb/srg/51liCqjnFLZIWBu6EuNB44UjW6XElaZ83XbzkMqzDIftwUpLWbr8R
 iRgekDDIGFnR7CaknSmr3YaoMZGC6FBx9QXXL3/7oVHiCRtDaMEiVOyXaKwDjZWmnx+d
 eddkTrbi4WHH0IuA3xRFr5jRHh1JVDsmA5OjvTI4+kikE7BVUwoUrlibtQMF/ofvIsq9 fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2ys1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:30:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441H6LVA034588;
	Wed, 1 May 2024 17:30:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c0uwkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh7W5CH594m9BCNVSY3+9b449+gI6hPi0PhN2ZNob4H2XMTNjIZgDpbRqtV0VoWwazpIwOmb5u3Ox6Tr9ylpj15r3+MvJxSmlpMl+Vl45YOBUj20aG+MXJ2Q68grtONeKeX1coDmdZ+xIiqG1xGyAPxcSyr/Xoe4bppuMuR+ZQwevgM94H4bBpVWAZ7Z0HRSKi0c8FBPh90i8W5y6yEfLz+ezne1rSjGJHhAvOA214zJTA+KQMFCbf1B5h+FXZp77XS3YBaU2tEBfQf4v2ug05BtbFdrAP0/J0GlMfmpZYVX7KtnF5aQmXczEAYo4behq59BcK5pG8SZ7ro/ROn4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7nAJLfgchrqy36ZGWPuEEX3yzF+ZJC8zJ4sLS8CKAA=;
 b=hI5KZf1aFueE2adCACTaymDVFDPY5iXiMZab5jnvbQaopq6TJCxRt2ppSn5qtulF5WG6asl0WxoDuSNinnesi0BPcQn71V8Xw4GST4xiPA7A7pSyNEjtdfeQpKtM7ukz+Q6thjY/tkU5WFpjzCDVZv0p69i7dmML28kguMMdlF5Q/SNXROk4CWyPd14Xfi0weNHl/98jVBVnawSRAhwMnbO6tD/IWdeXO8GN0zMkVlkLf6kfcbTj0PXaIvHHnxJKhhsfATu+HqH504RZ/0EhNfF3zv0QkJZuB1C5F179dqImMpft7KVBqJkX+Apl5bAJo+aU/ITn2k/2zAQW2VX+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7nAJLfgchrqy36ZGWPuEEX3yzF+ZJC8zJ4sLS8CKAA=;
 b=IbAuEYkvjikZENTztBz3+XrZuNOGGuFWj2NALQsQtFQwXhlCjxZriPgpLrWDicvkYHyVYzIuWLrmEA18Kl2gu/L7yjw9ELoMcRkCSN7unpjP4dCKBRhZJVJzW6sFNybY6M4QkzZ80evwo8Jf2P8jEfsnVciesG03kxM7TDj0h8c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 17:30:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:30:00 +0000
Message-ID: <97e1275b-c876-4ea6-997f-45ea43fd9207@oracle.com>
Date: Wed, 1 May 2024 18:29:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-3-alan.maguire@oracle.com>
 <c3564a5e0b159d559ecd72ad0849aabfb54a672c.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <c3564a5e0b159d559ecd72ad0849aabfb54a672c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 54efb548-5030-4a0e-0a3f-08dc6a045436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?STY3NkdSalRRcVk3WHduZHZtcyt2U0IxOThUZDdqQlBFcHoxcC92MTMyQ0My?=
 =?utf-8?B?aWdVTXFUS3FpVnhpb25GZERaSXZkUDVMSXVjVk5jRkV3N0tuczB1bytxZVZN?=
 =?utf-8?B?dTFMYzc0Y1kwNENwL2pBSTl4QXNxdjFzZHc4cDhITmZ3MHVZSDhrQlE3SXhs?=
 =?utf-8?B?NUZzWlVROEQyYWFaZXBPVlg2WktsYldoclNDam0zQ2ZRSUVqNC9yVFRwaEJB?=
 =?utf-8?B?QUU5OXZ5ZDJ1RER2T0Q5OHYzNy9aV1FvUmtPNm02Y3A0a04rOGRaVzdIZjVw?=
 =?utf-8?B?VTQrQURhMm14cXlnRjVFMVJOcDVXVDNuWE9MdncraEloZGZzWm5VTHJHYlVv?=
 =?utf-8?B?NGZFSGFGTHRidDMvSUwvcnJURy8yV29yWnV2N0dhUERFa2NJcjZxOWNIVVBW?=
 =?utf-8?B?a0YwL0tNZXphU0tOWEF3SDJXWHpIdTQ4SmZKbnIrdmEwWFBVRjQzbUpDZVVa?=
 =?utf-8?B?K1JVN3RmZVVJclNqd0RIZk9YV3VVRU5YSklOR0paem05Q0crUlVvS1BEZllq?=
 =?utf-8?B?UUlxRE1Xck9WZnZJbnl0blRidzZhTkRQVG5xcmFsb2hHdzV5Z0tJeWNxVnlr?=
 =?utf-8?B?ekF1NmszU1ZEZXFWTzNtZG5rQTVxRFVoaEVEWGkxRFZIT3F5NGpDTkJiWXhH?=
 =?utf-8?B?aWU5RWFxMUtXZ00zYjk2dythMjdZdzkzQnd4TTRNOW1mZGc4VHVaRjYzVzRo?=
 =?utf-8?B?Q1RJSWdwMitESUJsV3Q5TDZCZ2IrcmJpUUxNMXBuaEFQbFNDekVBYnZGTnl2?=
 =?utf-8?B?ZGVKTXZpWTRYY1pGdXRGTmRmREx3c3Bsd3J3cGhtRDczc05lalk2dksxL2RL?=
 =?utf-8?B?azdKSGdYSnhCaHhHb1l4WEJzQ3p4R3dFQit4UnQ5TGhZY2NCNUxrNzRrYkMv?=
 =?utf-8?B?b1N4Q1pOYWlTcFJwS1dVaERtMGxVUXkvT1l1TXhxbDhkZHFXQVJ5bG4zaEtD?=
 =?utf-8?B?QzEweFVGZ3ZEQzVwSVhpeFcyU2Q3MmNiTUhEa01rRHpMUzNtK0FsOHoyRzUx?=
 =?utf-8?B?dk40YXdVSVNmZmlBSGFEN2M3NGdjTmRkZEhGRC9COFR3UmtNNWl6anhjaFJy?=
 =?utf-8?B?elR4R0pKR0dNN1R4U3ZMTEt1dTZHazVrNkRoNGR3Q3R6LzdCSjJrZHVrTGt1?=
 =?utf-8?B?dGFkTTI3QkdzN1daSU5DQkxPTUE3V2QyblAwS3lRVFlIQ0NWdENtZDFnTjNJ?=
 =?utf-8?B?UVlQVHJxUHBqYzVPeGlyNHNaaFhGdDFsN01aemdoRzF2R0lCZFE1UUhzV1JL?=
 =?utf-8?B?cEhnM1hvSkdzWnhFangvbE5TWUJ5UnBtakV2L0tramNucm1OR0oxMmhwNTQ3?=
 =?utf-8?B?L1pUYTZIZ2lYSStYQmdCVzlzTFd6MUczZFlRbE9jb2RtS0JGTGlBTDF2bFph?=
 =?utf-8?B?TXpOc2ExZ3JjRW1UdEpHVjludkxPeUFRR1Jwd0dlYzQxYmU3bUx3dTgyRnJh?=
 =?utf-8?B?RkttTWRoOW4wSHZkMk1uclVlMWw0ZlVkdW5uUmRvdWJOVm9pVENPc2hVVXdm?=
 =?utf-8?B?SDVDVTh6OFpSeTQ3ZzRnVkZsakVaRXprcWluVjQzZFJpdCtqaU9kbU9zdUZ5?=
 =?utf-8?B?SEc3YzB4K21wQUFIWmt5LzR4eUhLN0NGZDJPSTB2MXZqL2txT3hXcmh1V2RQ?=
 =?utf-8?B?VnpiQVFJTllqKzF6WHh3VFNHcEhMMnhJbVk5cml2YmlhSUwrSUdOQUtRUkVy?=
 =?utf-8?B?eDBZbExBWHNWeXNOQmVUcnFZcStwVmVzZjJxKzRjbU1OSG9kOTgvUmRnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RTFUMWk0TXRBSllwSjdXR1Y4cmV4QzkwWGZzMmVwcER4RmJUTmkxbnlJaUhi?=
 =?utf-8?B?STlheWx2cE13QkpXbmlUSWd3Z3Y4L3pJT2JGVTBoZ2ZmbXkySDZlbHZRRFd5?=
 =?utf-8?B?YmQrb3hPRklGMVE3bExkdGpYR09TbFMxSTRpTGc3UStoR0pWL2dZSlJoM1Bu?=
 =?utf-8?B?ZW1ORnpsZXcxUC9VTFg4OGRDbmJtSExPNVdBQUZnSW1aUmYyV3hxbnMwTjd3?=
 =?utf-8?B?R3QyTmY1UGs5Rk9MUnV4RTloTk95SzFyaWhOWFBpT0hSWE9NNlJOQTdTQWtF?=
 =?utf-8?B?TkM5VlBodUlSTVRkZ0sxR0xqZEI0RjhWaXp6cVFnNlJlS3dPVGdlb3pmd2RM?=
 =?utf-8?B?Si8vWTVaaFovNVFKemp3aFdpRm9laUhrSk9iclBaUU4wMGhJYmIzNmdRaDQ4?=
 =?utf-8?B?VFV6aTVUeURxSEdIbDRKbmhBQkZiQzZycFpGemJvelJDajl3TURIdGw3RlZS?=
 =?utf-8?B?N0tsQnhQTGNoeTRBMkIwMGloS0tBV1dYemlvUVI5Q0JVUkU4TG5HWGFKajd1?=
 =?utf-8?B?cWRuZUdMaDkwK04xLytXcDJyaVczWnp2SXEzeUpkbElaNC90eWpSV0w3bW0w?=
 =?utf-8?B?UzVSdnBwL2c1Z1o5QUh4dlBZN0ZCTjZ2VUpwbnlWc3VhRG5URTJGWnNyV2dh?=
 =?utf-8?B?clU2dkFjN09CSmZwdlhyaXIwZVY2VlZWWEhLUTNVRFkzaVIyQWwrbnBlSHJp?=
 =?utf-8?B?SzR6L3U2aS9aTnhSUzFlSlh3UE9XaEUvc2tMNG5Zc0pwWjJBVSttTnhTcHJa?=
 =?utf-8?B?SXB5VlBZQUd0VU9KbkYwYjYwak9GTDhXdWlyK1dMZ3NKeEExSDJVS3lsVExC?=
 =?utf-8?B?YkhRSnBxalNLSDZFN01RcUQ2V2k0bVpvNHVwUGZBMklqeUFqWUlqNlBrd3NH?=
 =?utf-8?B?R1ByeWpkOXM3M2hWZjlSUEdPWDdEQTE5ckFUaFR6c3FzTVJ4ZDRPdXhzKy9U?=
 =?utf-8?B?Si9IVldGbGxOdVZQRjRqdDlmVENQbCs1RUMvM24zemRISk1LNHFqdTE0TzI1?=
 =?utf-8?B?SmtuTForUjFzVkdhSjkxRlhKUnZLRTg2VGgvQUV4aThxV0ltSWZYbmV4Wi9R?=
 =?utf-8?B?Z2k0ZTRYZmZ0VnY2SHRUazJBL0pyQkJNaVlmbjdHME9ubW55dk96c0d5M0pS?=
 =?utf-8?B?SFJNdG55Y0FJWExLOHFMT3FMU0ZyZklXUEpMeGRwenA4SEZmTlhrQUxiamMw?=
 =?utf-8?B?V28rbVZOaG5WSnBYL0RGMnNKcHF0czMzOHJQV0V1Nm1ZTUIxcVhyTkpmTE5B?=
 =?utf-8?B?QUJPemI3cGhRSmN4SnZ4cDJPTk1jS1dGU3J2NVFkUkVEamtvUjRnbXFHTjVM?=
 =?utf-8?B?LzVZK0FWb3VaanZpMTY1MlczQ2plRTcvTkt6UWlLYW1kSjRyaGpJR1JDQzRC?=
 =?utf-8?B?bzQveWZqNzZIYXB1b0pkNGd0L2ZIN1p2a0x6YmVNZjlzQWR0RjVXcjNFdWNm?=
 =?utf-8?B?cG5JdE1VQWNLTjgycWNnTHRrazdUMHk5TUdIMjdiM25BNWdEV29ET2podFRn?=
 =?utf-8?B?Qkhqazc0N3JoQk5ydTMyS052UmJrWmtNYk9Rci9qdEU1Q2VxaFU1QjV3TUY1?=
 =?utf-8?B?ZUJKSmk4a254d21SaUtPRTV5UVh0YTNpcVVHcCtCbnRYUGg5SStCVytjRlV4?=
 =?utf-8?B?ekgycWFiVGN3MnV4azFRUEVCMG1zQ0xCR3B4SEg4TlBpdTUxTE0yWDBvU1hS?=
 =?utf-8?B?R1lTTDZJSXFHbTk5WnJZbHhUZ1JEMlNGOFA0WVpKRU5HMVRRbU90eDJwd2NT?=
 =?utf-8?B?M0VLa2dRVWNIYkdFV2QvZ3ZmcG53NzJuYmdLL2hVaTVCUmpNWFUyOGE5MG9m?=
 =?utf-8?B?cDFOMzJ1SVVtbEdxVU1DeEh1N1Z6SjRmVkRHOVlGdWlqMFFNQnhUYS9wRFBM?=
 =?utf-8?B?WkZjdi84VmJLb0R6OXAzVFNvVVJwazM5YlR4U2dGL3A5dE5xTWwxOHJMOXFl?=
 =?utf-8?B?QlNUT3Fja0tvTDM4WE1aVkdDWFJNazBpRnAwcUVxTUtLZTBHZG9BK0JSRzNi?=
 =?utf-8?B?K2l4ZktLQTJpdFFWcDRkOTNYdWpUZ1Q5SDdUMnlRQWhXQVJSRDluLy9JUW1D?=
 =?utf-8?B?THBVUHJkTEdHQ2xkNitpUU1ZbGsvWVBRN01LNVpxZm5ocHptaUhhR0lwRTdU?=
 =?utf-8?B?QTlBaXhqbmYvVmhSVDZjV1dwcU9ZOTA2TWRCWHNHcTdFa3Ira0ZIbGt4SUt6?=
 =?utf-8?Q?v9DswgWnKa5o+jizGfc832U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RL0W3ZuYSe+l5+xFrM0oBNGgBB3m25kMsN+JJFTNkMRTURzmXvPHHrJ361/oXfkyNIu5u3kS8DhKx0fWeiAmdVEYmb4bRBiclgCUEyN1RoK8h6I1BwQq65hZLeb9qkGMsncEq3dtUg8VpE1GD1k7wzumiIRRpdPokiTDoF+XOk4BDVdIahQpB7h49eLrOi6XZclVRBrMH/6ZmM+/m63rMtlhEz29rgPQZuGda+9flbcDKAZLHNwE5KQfeKC4rFDZDRdsT+OExEKkR5BDd/gc3uLYxkbMPS5tDvgK1L0GW5tvtVIncHwiJFjhnMr533cIRCcA82Vc5O/7XcD3U18JJNT/TomWuuVvuTF7xbi8ebasQWZv1SdvfFnRz+j8V3h5JFTSh0Lzt2b6O4MwkcVfUAxY1w/BflpprcLJw7ruMDOCZ/5MOAQtvnBffxl9jKXlOmVKbDBrp6gaz0FlJDqOk8XccSQBEJ+0QNye3aWf4ueHgrDCoS+HDVAydKQEV2IHfzgo10U42C7R8I2fz4RqT1VG9OawKxQJmX8aX/c95UKXdVePfNGhC0NyyGliy66iDqWzd0cxt9LKh8Y9udK7rQoHvLMMnG3tMC24KMmTA9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54efb548-5030-4a0e-0a3f-08dc6a045436
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:30:00.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N131swC1jZaxFzM6LJkGDONyJJ/NrrSJkFR8ur1lp2dUUDqQfqNjq40ueWn6iXPAElxfZOAwDDROOo1H21QH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010122
X-Proofpoint-ORIG-GUID: 5g6kZPW5aLeFo8pCzCZjvgUXELrpjAVH
X-Proofpoint-GUID: 5g6kZPW5aLeFo8pCzCZjvgUXELrpjAVH

On 01/05/2024 00:06, Eduard Zingerman wrote:
> On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:
> 
> Hi Alan,
> 
> Looked through the patch, noted a few minor logical inconsistencies.
> Agree with Andrii's comments about memory size allocated for dist.ids.
> Otherwise this patch makes sense to me.
>
thanks for taking a look! I'm working on an updated series incorporating
the approach of limiting distilled base to named struct/union/enum
types, hope to have that ready by the end of the week. It will also OR
in flags to mark types as embedded as per Andrii and your suggestion.
A bit more below..
> [...]
> 
>> @@ -5217,3 +5223,301 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>>  
>>  	return 0;
>>  }
>> +
>> +struct btf_distill_id {
>> +	int id;
>> +	bool embedded;		/* true if id refers to a struct/union in base BTF
>> +				 * that is embedded in a split BTF struct/union.
>> +				 */
>> +};
>> +
>> +struct btf_distill {
>> +	struct btf_pipe pipe;
>> +	struct btf_distill_id *ids;
>> +	__u32 query_id;
>> +	unsigned int nr_base_types;
>> +	unsigned int diff_id;
>> +};
>> +
>> +/* Check if a member of a split BTF struct/union refers to a base BTF
>> + * struct/union.  Members can be const/restrict/volatile/typedef
>> + * reference types, but if a pointer is encountered, type is no longer
>> + * considered embedded.
>> + */
>> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
>> +{
>> +	struct btf_distill *dist = ctx;
>> +	const struct btf_type *t;
>> +	__u32 next_id = *id;
>> +
>> +	do {
>> +		if (next_id == 0)
>> +			return 0;
>> +		t = btf_type_by_id(dist->pipe.src, next_id);
>> +		switch (btf_kind(t)) {
>> +		case BTF_KIND_CONST:
>> +		case BTF_KIND_RESTRICT:
>> +		case BTF_KIND_VOLATILE:
>> +		case BTF_KIND_TYPEDEF:
> 
> I think BTF_KIND_TYPE_TAG is missing.
>

It's implicit in the default clause; I can't see a case for having a
split BTF type tag base BTF types, but I might be missing something
there. I can make all the unexpected types explicit if that would be
clearer?


>> +			next_id = t->type;
>> +			break;
>> +		case BTF_KIND_ARRAY: {
>> +			struct btf_array *a = btf_array(t);
>> +
>> +			next_id = a->type;
>> +			break;
>> +		}
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +			dist->ids[next_id].embedded = next_id > 0 &&
>> +						      next_id <= dist->nr_base_types;
> 
> I think next_id can't be zero, otherwise it's kind would be UNKN.
> Also, should this be 'next_id < dist->nr_base_types'?
> 
yeah this needs to be fixed; also isn't worth range-checking this as
it's got to be a base type AFAICT.

> __u32 btf__type_cnt(const struct btf *btf)
> {
> 	return btf->start_id + btf->nr_types;
> }
> 
> static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
> {
> 	...
> 	btf->nr_types = 0;
> 	btf->start_id = 1;
> 	...
> 	if (base_btf) {
> 		...
> 		btf->start_id = btf__type_cnt(base_btf);
> 		...
> 	}
> 	...
> }
> 
> int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
> 		      struct btf **new_split_btf)
> {
> 	...
> 	dist.nr_base_types = btf__type_cnt(btf__base_btf(src_btf));
> 	...
> }
> 
> So, suppose there is only one base type:
> - it's ID would be 1;
> - nr_types would be 1;
> - nr_base_types would be 2;
> - meaning that split BTF ids would start from 2.
> 
> Maybe use .split_start_id instead of .nr_base_types to avoid confusion?
> 

good idea, will fix. thanks!

>> +			return 0;
>> +		default:
>> +			return 0;
>> +		}
>> +
>> +	} while (next_id != 0);
>> +
>> +	return 0;
>> +}

