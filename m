Return-Path: <bpf+bounces-40829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70398F146
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827E21C21B74
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5319F13C;
	Thu,  3 Oct 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="alUqWmy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NOqU3RgO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A419F129;
	Thu,  3 Oct 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965200; cv=fail; b=XJOohr5i2/Y6y5B0CuFh6s+0BdMFY2TqHdx/V0yfbJLWsXvb3nfd7Uw8pP0XcxHlcdVlyshHK0BmA4/OozQ6Jb3bVWRHmvwEEuJ5xHXQHB5sOKBiMoRCdYCpp0XUWoscSh05VbcOUYUjK+Ui62lcUM7sojevzKaICsxQSCDM3xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965200; c=relaxed/simple;
	bh=UA24Nn8NHo7uB3l0nNbzfcuPHD5IuLCqnCCipoIbzt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oHycUDoN1C9iiWIcrxCcxVenYgOGEAftICHDZhS563ZCuQ+bGau2e3zkmdwQ0bEpE3A0CQ+A//e9dBMv8bw0Y0fszFwk/iVgoOhV04qniJUgk4mCrlvSUnOAgaWIYhHCXr74q7n/ASfpN/mcxWmTZ7XQLPYYWjNNPvKK89gF+rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=alUqWmy1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NOqU3RgO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493E6db9010890;
	Thu, 3 Oct 2024 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=9qy/9Jyokl8KNc7tG8HrJU7Meyqa79p6R7+IuB2EiuY=; b=
	alUqWmy1rN72lrMhKFDyOoApqTdWL9DfzsTwXC/v2NTUMUZDpbbBbIDy30EWRpaS
	1f61ew45E12Cn6azC4mOGANsPiag/xKndgcJf10RI+ux111gp45EhaVVniCppwi1
	mNWMtKm4X1VbEjC/XGFJ0x6fsEFFHx0Qf9a1fklcHlM8tnLJ8AuLitVPsx5UN1Cf
	5Dzl62Y/vS3Dq+q09k4PkWrfaHsn5+3IgukSGimCeq3k61SM9oB/E+KVCW8XiW4v
	c5RdiOsJ8tAhjokYDoTQML9qGeN05QnjTQIz3NXsOxtyVqPeQhhp9A2N+tc/2vhf
	yNWOa41CitvoelHRXE6qYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3cdg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:19:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493Do866017314;
	Thu, 3 Oct 2024 14:19:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a89ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NizbZRCa3KKgGQe5yixrhfxyYU2D0DWeX02Eh+JTkXcL6tRrMzYtqWxqXCh37w/l/rnflNEoExamywCvStBISWHO3mW+5n2BjJZl/ySu8M+InOnIL69QZQJVvWs9Vyc8b5cMJoH0cr798OT7Fm6UxaoedzLT/bYx/2pmTKm0rM3yFYmXRZmmLWXieY2fvtxDf7wfMZeJ0PBWfSQrJyclSABSgILKiCDhdNxXHlguPEp/d7d9a5fV4ovPYAqx4mkjq9XREKBseSgvoAj9rfjBtt2fvhKRaZGi+v8yNiTK69lLZLLI6GkKYgh7uJC9jC5rMscqaL/g1eyLVwGA6TEGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qy/9Jyokl8KNc7tG8HrJU7Meyqa79p6R7+IuB2EiuY=;
 b=rY0TkvXZ3LqS7mT2jfYEPdP8CKYXX+9L9GqTrFlHtup4NWnQltMoW/2UiQEH4VxwM8SXyLd4Y6NSLKMtUw5omCyeNDcwcxN+ypn77BEhZV/lo2FtN0EXukWdRh95TO7zlURGVFNmKupEF/1ge1qsxJEPW3Cls/zw1zl2Rqrr6pD8Je3rLyG3oH8ixshOi4rdNLaPRtSBNSjz6mZbK9E4D4fjQVphkpBgfSHUdumWhO1UwlC9UIZ67bas2AFQIjE6PCdl/rxJZTp6P6cL8rmD1uXye8YSPDRDyYGjml70QlqBp8lzOg+oJ1r+n4gkAkX/2K9KLRO1TUt1gnPbobY7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qy/9Jyokl8KNc7tG8HrJU7Meyqa79p6R7+IuB2EiuY=;
 b=NOqU3RgOFqMC0faUZgOEU0ST298ZzaQ5KRhJakY4L/G5okk1ndstbI4q4gEjJqFmKTmbTbxZhNsLBIuhXZTwGwfaUn9Tvcq6EtYfDI++9YWNMy2VEdZmBsz/kihM/z1WUlqnMoB1w7eAIg8iEn2LD+J8xHWJWruyYj//MB/BE6E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6068.namprd10.prod.outlook.com (2603:10b6:208:3b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 14:19:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 14:19:49 +0000
Message-ID: <13c63055-4612-4c25-b509-d76c83db430c@oracle.com>
Date: Thu, 3 Oct 2024 15:19:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 3/5] btf_encoder: explicitly check addr/size
 for u32 overflow
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-4-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241002235253.487251-4-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BL3PR10MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdd1c7e-d2f0-4f5d-cab6-08dce3b670b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDRPYWdRajRBWXJlL1JGMklDdnV2Q3lhRVczMVF6TkFGVFh2aThLU01qZHRx?=
 =?utf-8?B?eENzbi9RUU5GaTIvZldCLzNNdDRENjYrdXFIS0NBMlE4VzQwd3RxUXJuOFRl?=
 =?utf-8?B?b240VUVpNEMwTUc2TCt1NzVLS2Q1Y3BrMDhoaE9Rck9nZTgyWG9zZzhjdEZ2?=
 =?utf-8?B?YU1wMUpTR3VSdUpIdW03M3lINWRaeUhKL1k5ZFNEeEMxN3hMSHAyLzBob21w?=
 =?utf-8?B?OTQvZ2Nqd29GSXl3QzFtWVlNZUVxRXFwYVBNREVNSFZhaHNYTW9uZXk3Vk1F?=
 =?utf-8?B?YkFMMzR2bFZXZzhIWnZpL1M4U3NEM3pxZVhXejhNNmdnbnJMd2hVVEcxOExu?=
 =?utf-8?B?VnpidnVpcURTclhHVlQ5dzQ5ZGx4cXZsVXFLdnB4cDlWbDZiV1FMQ0h3UjZz?=
 =?utf-8?B?MHlVNWVBeTlhVFJYZG5XNndQZWNHK09YL3VZeFRZemRCcks4b09PR0hvWFB2?=
 =?utf-8?B?VUl5TlduL05VTmhmVERSUWZSeUtrVlM4RlgxSEpWK012ekhrbklrQW83ZDJV?=
 =?utf-8?B?MGJMaElvUXg5amgzUHFmRzlmV3NEMHBOZGp2a1pwVE1FNVJqeWRtck1ENC9l?=
 =?utf-8?B?L1lKbDdUTnlod3NlOHRldEsyVlhIckRMY2hRc0dTVVgySjhwU2EzT29GZks1?=
 =?utf-8?B?d0xRRitSZWMxSnkrVk1PUmI5MVdqV3hmOFhRSHgvWGVtSVBpWXZnWGtidUVN?=
 =?utf-8?B?N3ZiU3UzS1VJekQ5RlhMQ1hrd0hRVFlqbVRKUFdzc2xIVW1XeUh3Rk9ONWZm?=
 =?utf-8?B?a1NZelUzdWNCc3g4bHZnRGdkVVF6YjJpRmNnSnplZDdlMm94amxkVW95SmJJ?=
 =?utf-8?B?Z21ySWtwL1AzT2xmcTlBNnB2VnFERWdIOGZHVnpwSFdmQytkMHd4ZUdqVTls?=
 =?utf-8?B?QUVIZEtKeng4ak4zcXhBK2RuZjM5RGd5dndsRUFpamMzYmg3TVhTV3NXODR0?=
 =?utf-8?B?VDI5QW9xQzdyelMvaTExdXc0Q0ZXUkVkQ3RLL2ovcFloUm8vWmtNK0NUdUtD?=
 =?utf-8?B?TjBMUlR1Zit1UU5sWmY4TGg5TWdnTnI5cjNoVXNtbWN0UlhUa3orK1dVb3Jj?=
 =?utf-8?B?Wm10NWc5Wmg1ZkxCUjBiMlFKaGp5UEpqSmpRY3Y4Tjh4SUlQNVA5MjBGazN0?=
 =?utf-8?B?U3Y2VmViREVqZHJhcHppWnlyNjlRKy9pd1ZSN1VsSTdnRVg2Tk5MbmZEOUlH?=
 =?utf-8?B?RVlkQ0E0bU0yWVZTQTFoMXNGdTk2L2kxUnI1dUVadlh2NlJoNFhJa0xvcUt0?=
 =?utf-8?B?ZjUvYVc3Mm5zbG85a1dkd0xSUFIzNzNXUEp2c295eldYV1dJdnpEWFhVNUZV?=
 =?utf-8?B?QzZlUllObXAyWVBlUVBEb08wZ2xhL3lYQ3VMM0ZVVitVdmxCQXM0NlNlT2Nn?=
 =?utf-8?B?aFNwckJCZGYxWkhac1lHd1R3V1gyWE8xWmdxZHdOWmp4SktYaWplbUs0RUVP?=
 =?utf-8?B?U2t1cWUxd1N5ZVhRczhqaU1pTTR3SHpmVUgxdmRhWDlJYU40VzYwRW56S25T?=
 =?utf-8?B?Q1JHUGxRZGx6Nm5sazhBd29IY0prYVFrUnlPL3pvVjcrem5NWkZMamhBQmpw?=
 =?utf-8?B?bzJxb3F4Mm5nZFFvc3RVOFFCYVNoRnpTYXN4SmRaQmk1dHExNkZYRXBBeS9Q?=
 =?utf-8?B?T0p6R0I4bmJtYXNRbkVTT1paU2VWZzNkNFlqVXJYZGRTVHZwWUdRbTZXMFlJ?=
 =?utf-8?B?cDdzbTZjYUhtUDNzNWNOaGQxQWZ5aW5IQXhpaWx3T3hzQzdBblYrZDVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NpVEJoTzM3K2s1cEpUN2tDT00wUWZIcEFUT0ZjcjJtakU5U2ExRXRTTnNB?=
 =?utf-8?B?dFp2RERNRjR6S3JSaTUrRk9LSkF3OUppVFo2enQyUkdWWWJPNko1UEN0YkM5?=
 =?utf-8?B?U0FLWXVhVHVHWnozUVBrRVI3M3JOa3N6OGlwcWlVRTkrMGY5djRPZEdVWXNm?=
 =?utf-8?B?QnRyTGRuUGlrbjNVTGcyYS9SbXNsUkpmYUVLU0lRT1BBakhHRFFkell3R2lD?=
 =?utf-8?B?SEVIdnhQY3hMbXdFSEVBR1JtamM2ZnV3N1RmRkYvOGJhSlFxU2VOZ2tyWndR?=
 =?utf-8?B?cktBUlRmMCtMRzB1b0pKWVZJcDl3aUxQcjZMdG9qbUd6Q01vMzFmYkZsOGFN?=
 =?utf-8?B?RjU5ZzE2WEpOM2tpQ0JQTFFHUlNVWm5wN3JVTWY1VkhSOVhWRncrOXg3NVIz?=
 =?utf-8?B?dHhFWWNNdDVwd3hERjIvQ0V0RklRTXI3WTJHQzNNQStneXRNZ2dwTXFvUFJa?=
 =?utf-8?B?ZUdkbmlpTnh4eWNBODBsM05mMGdRM3JmRnhpcklFd3lRV21EUHcrVlZyek5D?=
 =?utf-8?B?MTdFMlVjM3RtZnhLcTdESVFHTlB3RXM1cUwyektlcGU1NU95bTdVRzRmSDlh?=
 =?utf-8?B?RnZZaDByUWdVdzNrN3lkV2VIOU5Dc2tnalRUeWdaMEhWdFlvZUcvYlVNNGJa?=
 =?utf-8?B?cjdHSzhDY3hudVZVb1R0NkhtUkZVaWxHRUdHMjRpSXoxdHVkcWZ1RnFTVzM1?=
 =?utf-8?B?cUhPNldrYUhDVmZ4NTNEQ1EwdGVkZW9JTkdJSWpXYkdFbnJXZVBsckRZK3Vh?=
 =?utf-8?B?SVR5SnpoT1YzNk5hSm9MUTdpNTdwcDNTODJJMW9nejM4M2ZTVEEzR0sxcU4v?=
 =?utf-8?B?ZVowUFI5Ti9ja0Rhc05ISWRMc3NicDlObzN2enYyWmt6R1ovNk9TRFJZQlVx?=
 =?utf-8?B?MWxsZUdqSXZSRkhHODU5cFhoZXhNWFprcXFVS3NBWmQzSThKeGhEUmlLRnRn?=
 =?utf-8?B?ZWdXNlNPRnJzaC9lWG1tdC95SDBmWnJJZGxsalIyZzJHK00rU1kzMzJyckUv?=
 =?utf-8?B?SFFOaXdIR3lFK1pwbHNDN2w4eFFSMU9USHB4bWNsVDZiR3F5MVg0L04rdUY4?=
 =?utf-8?B?SkFXaVkwb2pTSXdnVGVFbmtKV3lrbWVGODd5Wm1hUzVRRFV3Tnh0VUR2NHUy?=
 =?utf-8?B?aUdhSlM2TzVsQUxZQXhtR0Q5VmJ5WUVKS1N3ODlHWTJkdmgxMTh6c29FMjZv?=
 =?utf-8?B?RFQ3Rit3Z0s4Zzl0WCtYKzFiWnFlQzFWQ1BZVTRSS2JodXYvQkVpdi8zTENL?=
 =?utf-8?B?aWYxVllYL2x5Z3lNK2RsemxGM3BDbzd2N0F5SkJXRjR1VEozQjlrdDdvanZv?=
 =?utf-8?B?REJMOEphTmIxV3VqVzF3L0FCaDg3UnBZdkdqN0d6RTlwdElQbUo1WGozUklW?=
 =?utf-8?B?THNWeGcxUkRqS2xyenlFMys2c2pHZEtxWFZkYmdMK28vRVBOWFdUUWN3NTNJ?=
 =?utf-8?B?SUE3OVJya0JPQlJlVnZMODFsc1hIbXd3Vkk3UUZDNzFjeTNTVCtJbTFmUzJX?=
 =?utf-8?B?ODZiWHNmTDcvSWp2OVhMdWV1K0ZPcW5hUmpmMmZGSFVaSjFSTFBGNTh2L2g4?=
 =?utf-8?B?dUVsQlp4RmVZUUN1ZlBSRlNvaWNsVHBXVVh3ZUQwL0hvdmlIVUJNcXQ0cjVH?=
 =?utf-8?B?U1YxNFpqaUkvUlFmU2tzK0ZWaGFnVzVvMGd5aEUwMGxCSFo3bU5UQ1RlaVpz?=
 =?utf-8?B?elV6a1VXQlFNckJZVnp0ZnF4T210TzhST3lKZDdVSXFmbkNXOTlEazZ3R0Fp?=
 =?utf-8?B?K2RzejUwYUVFRW1qMnVzRkNhOHhwQU9SbEVucThKRVNJd2xPcWVYK1JpSWNj?=
 =?utf-8?B?S2s2QW52Y04wWVRuVmZwRTBiaHREdVl6VVY4UWkwVXBLcG1SenBuRFVnWUxa?=
 =?utf-8?B?NTNkWndXSG5WcHcyY29TTXdVRjkzYU1yUVFOM0Q2U2UvRGgyQUZHNXpZay9F?=
 =?utf-8?B?KzVzVXpPMEtaSC9WS2Z1aEFMREJnVnlUTUh6QUdmd3NIYzdTV1Y5NFY1blRv?=
 =?utf-8?B?MkZkeG5HQkxSbzJ0TDVEMTZlbGd1UitneHBLYmp4eTd3cTEzYzBJTk8rbmhm?=
 =?utf-8?B?a2VncGI3VXhhMnB2a0JkNHFDaXhvMDVkTDg1VUhEbWhiVjBmdmlha0dZTWhZ?=
 =?utf-8?B?RHNxT2lrcHdYRW1lQUJLRHFmVk9TL094VUY2eWRPaUUzR3l3RzN5cTNMMWY2?=
 =?utf-8?Q?Nik76swLVfOORYs43zThoos=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t/jsV9wr68ellzD+nFyp1tGw9qEw+t9iOoPizMOf6Nlq3Vtinltu8oIOFVFa34rCdSU8nHHSyMnFROOynCPxK96PwjOfHTUKSKq4x+w1xhnC0D38KyK1LE7/cIbCfhVMYnqKZi5psSuEes7hMMU2jfIsmi92Ge1nGmX2NGk872+L+Qd/EljR6yIUziylvsc7Yf3Aty5Dd0S34XzCCVcnnGBQlcEULEKXkWpnMt6UVV8zXpc9dlvh1UR/oVUH4UI7ZHzDqLg1zA+8UZASZ6GgH4b3djsWNovKJ7E1PRneybrUsARWuBB91+EjAX3dnpXNc3iHo2zDtv4qhfijkWHfO0CYRjc8RSo7uPe7kpHJh9Rw2aZJ2qWVJWCOnPBHzgbbvud4jdCQZ9kpCKK39JHeXbT94aUNQ0HWin2XeXQRplIvddONYbRWJyvJc3bEU3keLTVlBm7+kZfS+dmOiT4eeqBgZZ4TIs/CRS3DDHr/cI9EnQNjpPW/ChGf+v+NybaRorkpJp9436sLUuj6EjUeZQVnALelIqo43XIbHqYrtUzew7M+ngBO77UeMCIrsal/k2N66yDBgNvr7MXJTOTpRhncwiK/lG5L/gAxsMD8vbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdd1c7e-d2f0-4f5d-cab6-08dce3b670b0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:19:49.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWcGPcqv3fUdzPRvz84XewlFR0Wklm2VwCVcnvRSXbBqu3SnU//PkFHwcbMvUKT3/lh19IZ+s7sHbaU2+mkuQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030103
X-Proofpoint-GUID: 0pdpA4-3UJMhec9EHmFgNOjjJx6cCO2S
X-Proofpoint-ORIG-GUID: 0pdpA4-3UJMhec9EHmFgNOjjJx6cCO2S

On 03/10/2024 00:52, Stephen Brennan wrote:
> The addr is a uint64_t, and depending on the size of a data section,
> there's no guarantee that it fits into a uint32_t, even after
> subtracting out the section start address. Similarly, the variable size
> is a size_t which could exceed a uint32_t. Check both for overflow, and
> if found, skip the variable with an error message. Use explicit casts
> when we cast to uint32_t so it's plain to see that this is happening.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 31a418a..1872e00 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2250,9 +2250,16 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  
>  		tag = cu__type(cu, var->ip.tag.type);
>  		size = tag__size(tag, cu);
> -		if (size == 0) {
> +		if (size == 0 || size > UINT32_MAX) {
>  			if (encoder->verbose)
> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
> +				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
> +					size == 0 ? "zero" : "over", name);
> +			continue;
> +		}
> +		if (addr > UINT32_MAX) {
> +			if (encoder->verbose)
> +				fprintf(stderr, "Ignoring variable '%s' - its offset %zu doesn't fit in a u32\n",
> +					name, addr);
>  			continue;
>  		}
>  
> @@ -2285,7 +2292,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>  		 * encoder->types later when we add BTF_VAR_DATASEC.
>  		 */
> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
> +		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
>  		if (id < 0) {
>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>  			        name, addr);


