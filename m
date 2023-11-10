Return-Path: <bpf+bounces-14796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062707E834A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 21:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02152814D3
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25A3B2B7;
	Fri, 10 Nov 2023 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cq9XyJX9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kpy5nIgx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD573B28F
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:59:50 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABEAC7
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:59:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiSgX017422;
	Fri, 10 Nov 2023 19:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R/6Y0ZDnLviyHBzSgAD4VsIWeN99C5+RPewhzZzdQoo=;
 b=cq9XyJX9ngrY4F7+vi7VUyrm+u285f19nBjyHHbeibfXBgL6TjWIoMy6A+ol82nIdOsa
 VC1wQq7BZD7pHPe0L6XjwQd+R47Lsav7/CdVJa2gkIsacVPOs27in4MTvx/ul3oyGVpX
 Psh3CEBogsGlVzNbtpsUHX3dO0L6IdrH+8TicN4Od5LoySGwPnVIZQYS3uW0nwG/SVrG
 UJ8vuaq1h1+g0zZEpiao7FbtawDfAqXhCasXz9orKwu8AvEcaieWUuHKhdlcDPKqI2M3
 unis7tf3AGwqqpMpG/E0NQ+y0zmv2Y9BskmpeqneRnkqsM0LMxy/FwRxnhugsqZE2589 dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26xs6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 19:59:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHO9kN023844;
	Fri, 10 Nov 2023 19:59:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w28hu53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 19:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntPiq1aq+BoawP0bziOZ7tvUiXvFriYhHGigw6w6PiWsbnFH+sEXzjkLXBP4HP8OFFch5Jix8rTS5RE/hSe7sN4M9uS5MW+B/odQM4Fq2flcL3tRCVF14HYi57DrnmgJxnhyVcA8YWSCOzTmLo9UvPnzTW26187/HEft8eKZd27PJOoZXilDZlehGPL/pMp8jrgi9VQlc+XqB8wHqNP6FfImyHiZlzmwuau9AAP31nLO/C7PZhXDhGHNDsDZPzohh/4xv5gENbRFyKilzqf/TWtm4zq4E08laz3afZOiJoEibDBriP651obCPom2rVV4POd7fvWwPKreHcXq7qxgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/6Y0ZDnLviyHBzSgAD4VsIWeN99C5+RPewhzZzdQoo=;
 b=l3gQBFLTrFDHGUVOFsf2qXXL52aj0cbxge56IG9/n1Y6XLrg8g0m+pgdgWey99q9oMc9EBBLhbK++wKCr1fs++0pnKG4YoXm3Qo7oQre/U8ybJgEWDouxANFSACE9UxyHl3jdEDleDgDKWKH3unS60uhQ24LY5BIfRYB8syZc2UintOn0/nLGFAxFc+Hr4lCaZIT8jeXcsMCRFpl/wHj82Td7GqgqdDgkRl7gQBdnnlVrywUQ4kr6nwd0urGVyr2sdKm2qP0IfEy3VL5MV9FpnZrGq1WjSD1zkABLvCJ52mvOuKZ875f5rBdOZVq35qqlda6PUrs2J1of746b/vk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/6Y0ZDnLviyHBzSgAD4VsIWeN99C5+RPewhzZzdQoo=;
 b=Kpy5nIgxgpMQtMedOCVIZTFcKOTufiCv7Nt3r4ackzaIvU3GfwNJSB9JA19OlbsWhFSeQtjqW4/b4dPPaueqMzyudQyEtlqCTs0SWGAuwD5cEVsPPN9xQ67Hf4PP5VFP2SRETv1Ex8MBhBxe3pY7CEpBoSfSxUGNGXo7z7d16d8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 19:59:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 19:59:26 +0000
Message-ID: <ddce6361-8682-b8d4-956a-e2225f16b6ae@oracle.com>
Date: Fri, 10 Nov 2023 19:59:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix pyperf180 compilation
 failure with clang18
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20231110193644.3130906-1-yonghong.song@linux.dev>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231110193644.3130906-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 38884dbd-0c1a-4d84-07da-08dbe2278b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EH6Oav5XiD0dTggA3qZdKS0jRnybuWUc72vtwKk5ZLlEYAxwgBWZYnAuydDIfzyO3YD90wUl8sPuLb15UhvXUzC0uqB3/TUhf24+6rIhlGToZgsrzKjnuB9vvoEF5nFT8HW3FIhyR8rG/sxCSzqnCO052tdQ22DwOqCsWJs7u7zOWMyFWjnGoDgBqtDc49x+j8SknvvMbT42tI6zHefFAuWUwjAbum+m6SksElt5YfKwjs5pzSJnj5O4NvH188IfhW9p7i7igGtqcWkiPRLRukD0jquPCTqqAk7VqBO2LZ3RuBts5uWMmHWKpW7akJRg+zg8xKK6JNnpZF8zRKrR6ppzO8DxMJ6ckzQx38/Cr2ke3fhdP1tRazOS8V6oMtff9KmOxcV+JIHNeMyUNTZz99W2jQTQnS7EhX/8ZPCZ5XcZOnDr6rJWCXrkwQRzTkWTS/FiaByezPAgGPgsNN05OReAcZHzQloENPmYhg++FvDklIuWNpEL0pSg9hX3hbFsdLHYkivy6HYb9CFShmFyNOAgyfUM0CHZsEUdafipqD/ql3EhMopISYVJ5BfNQLu435GOI0tVvMcxTaqkdjbsVPWfyUA0TrJQraO8JuaXD3ebDFMfV9xY6kzIFDhB5+bAyBfMxoxyLR/w4sHO020VuA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6666004)(966005)(2616005)(6512007)(6506007)(53546011)(478600001)(2906002)(6486002)(41300700001)(83380400001)(5660300002)(44832011)(66946007)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(38100700002)(36756003)(31696002)(86362001)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2QyMGdYK0lhaEl5cU5aSDFVcHVKZlNMS0p0YklnRlE2K1pFWEEvQTEzTnY4?=
 =?utf-8?B?MlBlU2krbkRZeVhCSGttY3NiN1lYZENIOVVCNVNoVEs0b1dGQ3VCNDd1SWhI?=
 =?utf-8?B?S2VwdDE2a01CSlgzSnBTczNsOFUvNHlsVGdMZTV3Zis5M3g5bEpXL0FOc0U1?=
 =?utf-8?B?R3h6aStjUEYzRklzcUtENlZ4NmlZNkNHclFOUjRXM01mN0pPNVg0cTZjZ2ZF?=
 =?utf-8?B?ZW5NNXpXZGVMVDJGa25EYUt1Q05HczVKRVdGaVNPcjVRWTJzMTFnblZ5dURt?=
 =?utf-8?B?eURhL0RQMjh0WDhUSzl0UXpndE5kZnNBWHdGYnFLVDhYaDIzcyt0UXdTYWpN?=
 =?utf-8?B?YnZ3aTNPMG9JS1NVb3RHL05nQ2UxWHFyK0ZIbUVJd2kwckVUL0QxckpHNDNv?=
 =?utf-8?B?TnF3aElEdFlQZyswUHg1R3lMdHVVZ3NOWURDdStLTTFqTEkydW5ubWJ0aXpj?=
 =?utf-8?B?Um1lelhxNlpsaVMzellqYmRRZDlERUFWMHRQWlNnQ0lyeHZZbDRndmprOFVD?=
 =?utf-8?B?S0E5bVZlWjlTWjlNSFRRV1FGZ3dlWU0rVkhpdlpiMnNod2pvS0pHM3cyU3ow?=
 =?utf-8?B?Y0FiYlcvWHNKc253cXRDakRvUi9qS3hMZzVIcXRFWkJkUWxRemtpZ2QxcSt1?=
 =?utf-8?B?elhVbFU0eHBUcXlVTnZxY2YzM3E2RVJTZ3p4WkJFVkRkRlNRcnJiV0MrMlBS?=
 =?utf-8?B?VVVNOEF2TkR1L1Fac1FsY05QRDlDLzdtbGo0S094TTBnaUo5Q1p6dldLSFdy?=
 =?utf-8?B?cVh5c1ZNTVpIWnM5N0VvQXBqclNIbkgzdzk5NGdYa2NBTEJ2ZXZhenZ0SFhl?=
 =?utf-8?B?ZW50ZW1WaEpMb0dsRERMNmNiN1pHR01EK3M2SGdWVlBuVk5LallEZm9xclUv?=
 =?utf-8?B?L1ljVkd4Zzk2UXNmTFF1YnVZRXJodVRJL3NEdlFwMC8yMmxhSm9qZkZRZCtG?=
 =?utf-8?B?SmNCeVo0Z3YxVHJoc0IvVGJac3Z4WTZ0TWx4cmxLOG5oRkRVb0VSYlg5enBT?=
 =?utf-8?B?bVo0OVVBU25kZjk5cVJMdmhhY1hHYVBzNnRyNFRwa3FVUVFPU2ViMjgwUGJk?=
 =?utf-8?B?L3JvYXRBN0tndGloaENHQUZtVm55M1Fvc0RQdTU3Y0dhWkQ0YlJsclFKdlRs?=
 =?utf-8?B?b1lGZGdNV21kTXpIc0Y4NWxWVTVCTU9HN3RkNUwyVGgvcVN3c3U1SWI2d3hB?=
 =?utf-8?B?NTY3Nnc4a0FGRE5pU3YwTGVKenFmMnFkWkZEdTlzcWFSaEhMYkpHcFo2L2Fu?=
 =?utf-8?B?Tm8yd1VKMnE3dTNEbHlqeGdzRkxlWTRwRVIxcnVWU2lmMjBja3lUY0s3VnZC?=
 =?utf-8?B?b2ZpZllVTUNZN3gvVTk4RWdIM1NwY0VvV3gyS1Fhb3Z5RW5HRVNjWlpoc0hk?=
 =?utf-8?B?d25uZmdTdk5yZkJjUXIzNUpZYURtVjdkdVJrMW5MeFJydnN3U0JKNzlqZjlD?=
 =?utf-8?B?Q2xlNnVDdjB3NWhmQ3ZvUXdoUG42WlVraHhkS1FXdjllcy9IV0xTYktrMFJK?=
 =?utf-8?B?TkJ3alpRT2xNRVdsVWpWYzl2RHFBNGtWRENYL3V5QzNrbU5JU2N6d2RxdjNm?=
 =?utf-8?B?RWd6Q2hMeDI1MjlKMFZoTkNKZXVmbEx1T0VBLzFxeE1ha2UwMEc3YW1kazU3?=
 =?utf-8?B?RnZMeENzdm9CZlMrWUQrdXFaUTZQdkRXRXRiSGthbitNTS83S2FQaU5jMm0r?=
 =?utf-8?B?RWZpQ0pZTUdHNHdoK2F5MENZODJLTWgzOXF3by9lRWJFenM0aUp1MU9IQm9P?=
 =?utf-8?B?SXVSRnJCWVp6Rm1jcG16K1cwQmRCM1kxWHBFdXNEK2RwanFjaUxLUG1oQ1Bj?=
 =?utf-8?B?QVFEeXlhN1lwdjB6UnJ0aWZKaHBqQ1JKU1JCS1JJbEZ2cklqcXl1U2w4VzJE?=
 =?utf-8?B?cWkvYnh5Mm9tcFFpMDBCblVpY25yclF0WHowTWJZQlRTMWV6TEZnRno3Zzkr?=
 =?utf-8?B?cW91RnNFVnBscFloY2pWUGFiZHlOcE5kT2ptVHJvYXJPN243ODVXTDVqVEhn?=
 =?utf-8?B?MEVnOGdpYjVLNTh3K041bG1KSk8zNGp6b1cwZGhmb0lKamJFZDVuYlFoZXlM?=
 =?utf-8?B?L1hoelIzZ0t3YVgyRlZBR0cvVzhSdEF5akRic3Q5MzR4bHB5aXJhZnVSYzhP?=
 =?utf-8?B?bEY2UmRZM3V3Z0VBTHg3ejh2YllBendBMy8vZjVVN2ptTUhVZTFkVlZXSUZO?=
 =?utf-8?Q?0WhooZXopSu5IvyHcHhWwFo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YC6AFvmOOt6aSt8MckKUhRze3Xai9Umh6kKr6aFBHWvfDY+dY10vA9IhmVUKsFSBZa2/ZsFMqakw4JvAKZkBTmCrSRRrP9gf1cPGy786aaOIW4L+Wn4F/rlAk8fmWLXDjOnuReoaT5P5PYFGau37KmIJg4erIxLyKvN/jwDiLSysZPeI4dgbepLHPmLyGbB8f9GXJhSagIeKJeUUJSo3Ps2s78ldotm5DjYvygOccIN6nXcuXIg5z4NJVfU9B2luUh/d2/RlljtqpqqivnT/ngjy40lrja/ef0ZYUT52Og5UdBBDK+h9QrxcGmIcKiyhxm+dV2RrzRhA7BBYsVsCt0/TZupgE32y8yeuy7Z0jwanp7FmCHiIL5ysNpSphgZCQGfeN9eVhanEOREv5vXk7M2gwrjNbJsP5irsGtel50ZWj4T7wVo3HcP5kbEN34SqksNeCwC9q0k/0mBPYkb1rmllusq6GNgocnbwCQR11OSVDn1+lpdTrveXEt8FUQNSXnTsKih7wJ6BzXgJbMlzuH7kXIVGcgsHjgcferTIGH0d6BO7fZp/3vMISmcyoWzLoPi4kaysTJGhNiFcBELN0U5iw7ITycaJssylIUJv/sp2gHnlzoOO+p87OVbfBR1bE43z5wAyYyO1jeH5hYEm+y5Uv/e5QzJYHRSNRUlE6OSO1d3AwDUf4OT75Ndk7kBnI3G/5a7yEvWB1P/w18pHTiCY60OxhwfItyTbGVkmXsGMeKtYwETrhgThwo6VBFlzMI9CWwKqKF3Z258a8Ro0uPfaebscyIabjAxP2t5pGzSZ0p9T7kldf8rl9QGHs/htFMjrKJoFCPlSxcWJE9TISUuSoFSykZuybJby5wnCD9ODvIbRQoig/ZV9I+Stf5bA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38884dbd-0c1a-4d84-07da-08dbe2278b0c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:59:26.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jbFYKSie0Z+F1snCYVhEtagkGFpPhAHIGGLZK+MrlDXkn5MZZqeHdxQ5H+av3ioqBXgWZQ2EYhkTOu5YZ9Lsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100168
X-Proofpoint-GUID: KZCORCaDMpHu-GLEoZuafKUhV1aa30NJ
X-Proofpoint-ORIG-GUID: KZCORCaDMpHu-GLEoZuafKUhV1aa30NJ

On 10/11/2023 19:36, Yonghong Song wrote:
> With latest clang18 (main branch of llvm-project repo), when building bpf selftests,
>     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=1 -j
> 
> The following compilation error happens:
>     fatal error: error in backend: Branch target out of insn range
>     ...
>     Stack dump:
>     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
>       -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idirafter
>       /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -idirafter /usr/local/include
>       -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 --target=bpf
>       -c progs/pyperf180.c -mcpu=v3 -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
>     1.      <eof> parser at end of file
>     2.      Code generation
>     ...
> 
> The compilation failure only happens to cpu=v2 and cpu=v3. cpu=v4 is okay
> since cpu=v4 supports 32-bit branch target offset.
> 
> The above failure is due to upstream llvm patch [1] where some inlining behavior
> are changed in clang18.
> 
> To workaround the issue, previously all 180 loop iterations are fully unrolled.
> The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is used to avoid
> unrolling changes if cpu=v4. If __BPF_CPU_VERSION__ is not available and the
> compiler is clang18, the unrollng amount is unconditionally reduced.
> 
>   [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Fixes the issue for me;

Tested-by: Alan Maguire <alan.maguire@oracle.com>

