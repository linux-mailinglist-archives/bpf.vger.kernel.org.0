Return-Path: <bpf+bounces-56791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B94FA9DC91
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18545A6777
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8371B25DAFB;
	Sat, 26 Apr 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lHPLO8zp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HfrBnHVv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B551E5B79;
	Sat, 26 Apr 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688534; cv=fail; b=ItakWHK+b0gdJbPmbXZbRngMt9nd77mxF8mwPlLn9jj8HuSPEqN+v/tUz0LK03PQqxz2WOksH+rDb/up3wCmyVOPV4WQL/f8Nb4bOWCo5Dz6V0sY/DTAy8ecbwoWAWavEs4rrPsTRUicU02SwB0yBBmJ6Hggr7b0AmceL9M3yuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688534; c=relaxed/simple;
	bh=5MbRsFaOCoMMkSJp9p5JQHLIoM2OnjeNrP8znaNaKVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zz5+GZiwtdhJC0QMdwC/O5sji5ZtQt1p80gsdnHab2mCKCpLArmTp/PFeOIxRxDooS8VXZds4YI4+xTOz/9Tv2W0QQZb5Z7Qx8jkNM3D4dvNaatd7jNUiH6VE7J/ok959JswUzF/wsFhraHj0pyk9vcQQqml6JCKqCYbNw6lN4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lHPLO8zp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HfrBnHVv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53QHSWIM011023;
	Sat, 26 Apr 2025 17:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RPJWJAsZ3f4NarWxCO+kQEyQMpGp4dh9p31U4lSQgBs=; b=
	lHPLO8zpGAa+WWziyS9xmNdVG6TGUkyHaEvmbkDzNec89Yl0PaupY15jcmSR1pNT
	QQpjy9ZuJUG81XJUvHLMT7gODrH/qfBBqmuPcxbH0cDYD3CtyI5vPjEY2dWCBACa
	YGqjo/CHDXbh4hiG7NLt6dkC6S3PhxRLmV18SpxetnJnhqnUI8JckF9XU6xmle0N
	vrMnlwHPBvGsD7wIWoh2dNoMQYrEufngtB5TAvw3E10bt66iB8MAlOZNRsMh9Net
	cs9I2A+DvegYDOWPz3Q1RrBhjFlHPD0oTaSIf4nl96WkFX84hWaBi88x9BxymQ6u
	4kr2SoRjb7lI8HNwBFFpBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4693w3g01m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Apr 2025 17:28:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53QEpeed015455;
	Sat, 26 Apr 2025 17:28:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx78b5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Apr 2025 17:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waONo8go8puVLi5CpKHcyMc3VXCOg05Rk8ofVSusdJ3LLqZMHhMULJ8YxGzmgjjszhTyXAVmJ9z+AsoupG62L6G18IeBXSE+eozW+OGGGTXv6lQwHI0zRWnzCJnLi81BPBm6v8JlFcVah7VXX9Jg71ZP2yIlTWTNszs62VTukM2oY9TiTavSsQf9ED1y5IOSslEz85l/w3XyjIuJFNaWua1Et7h+udWmMYj4x9m8f73uMkBHYdj4pzczyufRECY88LZw6D527Ayz8AkpWFjNXjYkielID857oDNOBagb98fPSLNT3bMlB1kZux6vgih45zV0kQEuQ38WKpMHXklWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPJWJAsZ3f4NarWxCO+kQEyQMpGp4dh9p31U4lSQgBs=;
 b=f+4KB5BBSpK9qfO84CljqsiFlCkMw0lPqAb1XYM1BI8mzYfdaO8JVxKe4KuVxKv9gGOOAtihNhsB21sJOKfYswdO7bvLhLQmY/anAacuHFv3KJay+cYcvYW991YkOiEfIGvHmk3lf0ZZwMQkDLF8gXYJ8eDZNCVFSfmoWqlwD+RbNwch3407SOnXsmFAjdE904V3Soi60Mnkx29+PcqriX/b3h4/brjxxI/xtGmhk8+icv3BE4iRbvq13Gq/QnmUCqb8lZhL2Vi3UEL3kM7CyPutTUhFKSbnThHSF1YE2dD2xETtfUL9Q730ZPerRgIxCsAhLSDZAvbj0dNWeDv9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPJWJAsZ3f4NarWxCO+kQEyQMpGp4dh9p31U4lSQgBs=;
 b=HfrBnHVvcdIBWXUg7kKJXSuWgUjVsJXZHt07/Uf54sPovtjQgkTOXZaxsZQw+JkDirGlUGhLKNAJDZcfoWlqi0+WCi9lrIPfC1HYqVMxiVOKzG0PNVqCWB1tie+Vs+D65g2M/azzinVlAluwemIJ1kOnTVQC7l3438LDvM6tt7I=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM3PPFC0AC38E58.namprd10.prod.outlook.com (2603:10b6:f:fc00::c47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 17:28:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.027; Sat, 26 Apr 2025
 17:28:27 +0000
Message-ID: <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
Date: Sat, 26 Apr 2025 18:28:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole and gcc-14 issues
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
 <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM3PPFC0AC38E58:EE_
X-MS-Office365-Filtering-Correlation-Id: b687f425-0461-4fc2-b85a-08dd84e7c19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNlNXBtcXBRd3o0L3BkYkg4SnRVbEM3Z08vWi9iZjZXYTh3NFh4TDBqcW9u?=
 =?utf-8?B?OHFLazRoenRkTjNPbm93V3hxRUxUZUY5UnJpL3pML0t1Q2krcC93YmdjTmJU?=
 =?utf-8?B?TzlnNTNNVUZUTm9CVzZHMXNCM3QyS2ZqNDE3MUJXWEdwSW9UQytRWEFIRVpr?=
 =?utf-8?B?eHVsRlZNRWdxUXdXTVdtOGVNWWdLMElUMkIzaU1KcUdEdk1PN2xlWXpvYk1M?=
 =?utf-8?B?OHJOQWt2QlpOUnRRcnRWM1hvcDM5T090THNrVWNOdXJqMFVUMEJrT1ByaDRX?=
 =?utf-8?B?Z2JmREF0a2tpTFhZREJsQTR1SkdJV21yaFNzbG9laHVXQ2pGZXB1TFRuUm8z?=
 =?utf-8?B?KzBEenova0VrZFFBWkI4eUcyWi9DYkR1U0lFbExkMzE3U2w0Nkx1d0JjWTNN?=
 =?utf-8?B?c0NtYlNyWFE2WGMwUHlxRVZVdzZmVnBjYnB0ZWFPUjgxdDBuaDNIR08xU21r?=
 =?utf-8?B?MzJySlhNUjFNdlFWRWtRWGlCMU1Zc2Y5djlpeGxCbllRSEJtc1RYcENkR3Vv?=
 =?utf-8?B?aEVIZUpUQUdVdmdZV2tmQ3RPK0o1TlRkTFQxdkFQVHBKNlhQN3ZDcUFXcFdO?=
 =?utf-8?B?dUQ0OCtqYTVYeGhVcVFPOHZiVkxwaFlLYjk4ZHNsbVZoVjY3eWVNaWh4elJz?=
 =?utf-8?B?dDVURFNjaWFRcEIvUmtFOEVjQVNhVG9HY0crV0dHTDZJTWltQzl6RFRlQXJT?=
 =?utf-8?B?T1ZFSC9HU2lFd09wQ1kwd1RWdVJURStxL081di8xcnR1LzVkVmxOSjY1YWdT?=
 =?utf-8?B?NDd3a0F2K3F0bTlQbnIrUjBROUpheEtaV1MySC81Z0dnRGNDci9Yb3F2Qjhl?=
 =?utf-8?B?V1R6NEFETnVyQmlEMlJpejBTSERaampOTGs4a2RMZjZybDFUdlFvRnU0U09K?=
 =?utf-8?B?OGM0UWkyWEwrc1VjUU5va0NuM1JDb1FTNllBYXAwTkNiT0ZKSVlRcW1WMTVk?=
 =?utf-8?B?dVQ3N3pGSzhaSmd2N0JZc2Z3RFR2WDZ3a1UrSmtKd0V4L29lQUp3UVJSZDMv?=
 =?utf-8?B?L1FPMXo4MVFFQlR6ZVl3eGVRUktjTzFzN1V2SzlCVDJiVmNxNFpELzhTelkv?=
 =?utf-8?B?NkhDYjRZa3VyQjFoNHpiT0xRcFRtcms0YUtRSy9reWw5aWs5N0ZFMEplQXpG?=
 =?utf-8?B?c2VUWmRjYVo4dHJiVlVCNWdLZk9hZVM2VVVVbXIvcGVXTDlCYW9DQnJ0b1Fi?=
 =?utf-8?B?OFR1QWtlNDJnWVJxTVZXZjdYalVvRVF1djkxSno2bU9MNENxN2ZwVVYzTHlF?=
 =?utf-8?B?d25BcFp2NmNHMzY5R0xseGJsRmZ1ZHozc0d5b29yS3BjcHl6aC93UXE5UGoy?=
 =?utf-8?B?V0hXR2RtaGw5RTlHbTAxMkJ3WGJsMFFrdnJPL3BDellyZkRZV01UMURGQ3Ar?=
 =?utf-8?B?WWU0aWVoMFArTW00NXk4Nm5rTFhVSlVRS3FPYWF4ckN3OWR4TGx6Tk0xbG5w?=
 =?utf-8?B?NVZFKzBCVVhUWXBoSEJXNlBNNEk3K0JLdTNsSTRhdC9GZFJhWFE4NWxiendM?=
 =?utf-8?B?RU4rV1BaM0x6QnE4cUZaa0RPUFkycUtKNWZaVHd0UVFUZitZMktURHcveENY?=
 =?utf-8?B?S2xWTVN6NHZ3cUNzL0NMRlZFZi9IekRIK1ZWL1hwY3l5TVRqTUNrVkRBS1VW?=
 =?utf-8?B?eUpGS0tKQyszaFZDbEpkYlQ1L2tCVmtoY1dkdmlNMlQ1SkFtK2NRc1FlMks1?=
 =?utf-8?B?T1o2M2FSeXMzK2tKamNQSzk2UEo0Vlk0c2lRU2x6WHB4TUF6ejhIZHEyYzVj?=
 =?utf-8?B?djhuazdGWHlvc2pkTGtuNEJ0RFJhOVpuNGw4bzdYSTlhTTJ3bVROZVhUYy9Q?=
 =?utf-8?B?amwxVitGTUw3VGdJV0hIc09kQ0lOQXlXVnNwRWJnZk92d2c0cnJFbjFwLzIy?=
 =?utf-8?B?elJLbHNqc2dTS3BkbkVoSklzSmwzb09qNkdCRm9TRkVFZTV2Sm5nVzVZVlBt?=
 =?utf-8?Q?RbVyQG5ExUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkYzMEFmT3dMbjFzUFp3eUdrcUt5R3RETnRjMDQwNXFyYncyMjlvTmRaMnlW?=
 =?utf-8?B?M2JMZGZzdkJXa3o5MGh3V0c3dy9KdExlN05zQTNsRFFNbldrRy9YSFkra3ZS?=
 =?utf-8?B?Yzg1dWtMeW0zL1JRZTR1cGM1UDMvUzZTYlZWUHlRYU56UlhpSmZvengwSG03?=
 =?utf-8?B?SXlOTnhtUFl6am5QL2QzK1dzekFJUWJUR2pHMTQzL2lsRDYzTFRvNUVyM1Zq?=
 =?utf-8?B?TmZnbHFUTXdxcW55bjVBN0xDYmJhYyt4MWRVVldySU15ZjNPZFBRakUvT1k0?=
 =?utf-8?B?VEYvd0l4WlZCOWNEdWx0U3pmdnp3d2ROMzhvcVAycEJsMUlvRFpwZXphYWxG?=
 =?utf-8?B?b2FWbUswa1VmZ0pNR1VoQUxDVC9keDQxa0V2OXdtSmluQWN0VUxPa2szd0py?=
 =?utf-8?B?ZlRWUmNiVkRWUnU5RlZFZGViZjJzUkRiWUZZakl5NGpWUmJpOEp4M0ozTHhm?=
 =?utf-8?B?cnZCbk8xcUE5WmkvSWY4RXdBU00waUJBMGFjNWR6dVU4NUoydmhVaEhnL3Ra?=
 =?utf-8?B?UWl3NVQ0SWoyVm0xQ0FBc2hrcStwZzhXTFVTS3llVFZQcllOZi9tQXdtWTd6?=
 =?utf-8?B?QzBKT0E5U2Rmdm5EU1hkTkI4NlVITVBnY1hvcEpDckx4bnJBUnk2ZWtaOTJ0?=
 =?utf-8?B?dWdJbUtaR21zM2xUeXdKSE9LSUZlTndyZVlDYk5ORFhuUHY0NFdMRjZodGNn?=
 =?utf-8?B?UkxYUUxjVCtDTXN3YTVBZm9YcVZpQ2J0QVRMYStuN2JibTlLWXM0OGs4WGdY?=
 =?utf-8?B?ZUJDZFdQTndKNHhxRjB0MzVjdWNqWTNqcy9UQ3l2WlNHMG1GMUdOdG5KRktP?=
 =?utf-8?B?cXBCZ01hRHdYWmFRR2d5S0lvVVo3ZHJMQy9KcWMzT2xERHN1b3BZcTdTVmEx?=
 =?utf-8?B?NHFuYVJCSWpFWWthdzFLcE9ETGpIejExanhNOTJYNHJyWGRJTmYrYzlhUXJw?=
 =?utf-8?B?TnBSME80NmY3ZGwxMnZ2a21lRC9nbWoydHZOYTMrb1Z0aVF5d0pXRXlCM001?=
 =?utf-8?B?aU82WnEvb0hNYUtjVFYxNHQ3cjd3eFRzaHllK1l6TzIrYmNSOVJWZ3NUM1V6?=
 =?utf-8?B?R2JaOGNWYUFHNEFzNVJMNzJ0VDlSZjFuR3dwU1lzQUtxRHVEMUJpakI3Q052?=
 =?utf-8?B?T2ptY21rcEM1bndVZnZyWUd6cmhqb3pBMkh2S1Zsb09pcHQxSG94ck5IZ3Nx?=
 =?utf-8?B?NzlvdmVXT1Yxbk9qeDltUmRRSmU1bUFtSTRQcG9QOUx4ZmJPaElQYUcrY3VG?=
 =?utf-8?B?dzd1WlF1V1BncWJ4TFY2c2hsOVFYamlXazhKVlA2eFJFbEZoSkp3Z1FiUG82?=
 =?utf-8?B?ZWQ0L2lGM2xGUy9DeFlQSzZPMGZGcmZ1aWp5MXNLU0hvSmt0ZXZZbnNHR1VC?=
 =?utf-8?B?WGpJSUJVSG1VaXBVWnVJQmw0UE5HNDhTNHJ4RjlrV0Nybld0WjgvTTRvb2dj?=
 =?utf-8?B?eTBhTVhtbkMwbEl1M3pNbUo3eklPVlFJeWhVbHBldnBOd3Nna0RNVlE2SEVk?=
 =?utf-8?B?V2VEbStFVXM5cXBpbk5uWFROZ1oxcVQzZTJWTXhycTRwU2NRbkF1LzdGdE9z?=
 =?utf-8?B?NG5EMTc3V2xyZ3dKVjBMc29ZakxzVVc3NEpXZis1ekhEZmYvYklMTU1Kcmdu?=
 =?utf-8?B?TnFlaUY0STNLd0VXNElidXNWa1lDdkVGVlpvUE14MkVQNFdSQm9zNUk4ekZ0?=
 =?utf-8?B?NmU0OXNnNThuc2lWRExBZXhadkZkOFlZVnR2YldrQU9LckFVa25TU3VJMENx?=
 =?utf-8?B?NExaaEZZdDd1T3NBSURXVEZLL04wZDJScHl3MUJ3YnhvOGZkbjhBWmdlNHp3?=
 =?utf-8?B?K0sxVDZZWTkvdVVqRTFkdTgwRitGQjNjTUNjN3FZTzdLa0JiNDJqdjhzR1pp?=
 =?utf-8?B?dU9wRDE0MUpyK0wrK3BON1haTFc1TkgxWG1uRUFleVlJTS9HV2ZmbXU3dDdF?=
 =?utf-8?B?cG83VzJCSW51S0VxOXBLakYxREpUaDM1QjlKU1ZDNW1SV213cnozb210dURM?=
 =?utf-8?B?MGx3OWpaT3JIZzFldzVIajhCVkhSZUFBR00wZFppR0NCSDBBaC91Z0tzV09B?=
 =?utf-8?B?STQvZkQwNzBGSmtwc0FvYXAzQkl3ajRsSFBBVkNaNXNjMk44SXg4TzlhL3J4?=
 =?utf-8?B?RFAva3RFeEUwVXdWSHFpM2dtTWE2cmlOUWlxRDRHM3Q1bE1ab1h2ZFViczcw?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HIOqVbfR9E1HYXHYKhSITjAxz/FmZjVqgHvzqZj89EoUk4wmtVqMUARaFQraUJvepI7HBNK/RZ3lEMQrQ6/UfI+Zi1OsYCH4y40cCAGRk98I9zowa5jiR1dyHa2Hgt+NWZRk4dS380pmqtuoiKmF0MOgQjk5a9UzHu58KqB42IZP2q88HvkTmiA8xY68Jcqfe/TeVuFsYeROgFtncbnvCPnCwoEVDZyvR47gBCj/AkPAWf+CiMBIzMaxEcrMHklFvZiykRXl3SX6ONz5bKCsUeqzZMvrZQqXZ6uMlHNS+HQyjFubLKyhYDaONjoOjcgQ8b4Pbit5109CH5ADb+A6qRgGWg75m2tVrHheLZmRF7pDkZ9O2c4xcVuHg43CjGUOXIMZ7MkwNoGmCT38m0ipHbqUJXmsMfUR3mukaAGu3Gu+T8NsYSY3/BbmAFZCb7vs3VDT4QcSUAf/J5IuGWM+sBHaXWizDmYaiMxH1YPeuSAcbGUgrEDk/6IGeIeemDms3i9OjQDbmDJfgeb6z6lAnTWGiBIRPoM2esg5MNoihSGw0sS8WdQNiwuMSiHdK6G90WpwiV2JSyVT4W1XS/Gqr/GTrBivI75xn8f1GV6xGrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b687f425-0461-4fc2-b85a-08dd84e7c19c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 17:28:27.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLv9krUJhfUehos/WwYzX0BQDzgNGSL2rkoqJ0dYrGgdGXXvFRv3YPr95DCmFbmBicNMD4tcyajwuwgtFfEPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC0AC38E58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-26_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504260117
X-Proofpoint-GUID: GeVhWUpgNS_iPp20NMlcT_isNN0sAC9A
X-Proofpoint-ORIG-GUID: GeVhWUpgNS_iPp20NMlcT_isNN0sAC9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI2MDExNiBTYWx0ZWRfX27pHGuyZ/SDN xi/iTltFngeWpjYZmKtt7/gHe99xO5dK9MJ6VOk0hApH73yUUM3h3iCtUOnzfRPJAm3E08xXUhR VXv1zZnn5I3whqfGknVoBQU2MrFAMuxRYyaHJ2I2WyG9XnlaGO60o1XgvNK67JXammATRQIsnPn
 /2qksJfgWTR3ZSS+69m/QJHYOdcw8SlN/N+/NYQHb+tI3cAw+TMp0JPfjQQKqDgaTscwm7kV940 3E6LTHqPC0JscLjEd9l/7pSbUvpHphV9mDpktSXtZQswILKXs7Wrqugq2oRp3TsToq4h7DUWBbs Nm0wd1gB/2AOxVjpJD3xUV5MqfoLWuDmOT/j6xUu1kYF2LhBJVF6Ran/8TGXo37PC/kGpfcoO/N WC1mqwbf

On 25/04/2025 21:41, Andrii Nakryiko wrote:
> On Fri, Apr 25, 2025 at 1:36 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 25/04/2025 18:58, Andrii Nakryiko wrote:
>>> On Fri, Apr 25, 2025 at 10:50 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 25/04/2025 15:50, Alexei Starovoitov wrote:
>>>>> Hi All,
>>>>>
>>>>> Looks like pahole fails to deduplicate BTF when kernel and
>>>>> kernel module are built with gcc-14.
>>>>> I see this issue with various kernel .config-s on bpf and
>>>>> bpf-next trees.
>>>>> I tried pahole 1.28 and the latest master. Same issues.
>>>>>
>>>>> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
>>>>> When built with gcc-13 it has 454 types.
>>>>> So something is confusing dedup logic.
>>>>> Would be great if dedup experts can take a look,
>>>>> since this dedup issue is breaking a lot of selftests/bpf.
>>>>>
>>>>> Also vmlinux.h generated out of the kernel compiled with gcc-13
>>>>> and out of the kernel compiled with gcc-14 shows these differences:
>>>>>
>>>>> --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
>>>>> +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
>>>>> @@ -148815,7 +148815,6 @@
>>>>>  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
>>>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>>>>  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
>>>>>  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
>>>>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
>>>>> -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
>>>>>  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
>>>>>  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
>>>>>  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
>>>>> @@ -148825,12 +148824,8 @@
>>>>>  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>>>>>  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
>>>>> slice, u64 enq_flags) __weak __ksym;
>>>>>  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>>>>> -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
>>>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>>>> __ksym;
>>>>> -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
>>>>> bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>>>>>  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
>>>>> bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>>>>>  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>>>>> -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
>>>>> u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>>>> -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
>>>>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
>>>>> __ksym;
>>>>>  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
>>>>> slice, u64 enq_flags) __weak __ksym;
>>>>>  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
>>>>> dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>>>>>  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>>>>> struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>>>>>
>>>>> gcc-14's kernel is clearly wrong.
>>>>> These 5 kfuncs still exist in the kernel.
>>>>> I manually checked there is no if __GNUC__ > 13 in the code.
>>>>> Also:
>>>>> nm bld/vmlinux|grep -w scx_bpf_consume
>>>>> ffffffff8159d4b0 T scx_bpf_consume
>>>>> ffffffff8120ea81 t scx_bpf_consume.cold
>>>>>
>>>>> I suspect the second issue is not related to the dedup problem.
>>>>> All 5 missing kfuncs have ".cold" optimized bodies.
>>>>> But ".cold" maybe a red herring, since
>>>>> nm bld/vmlinux|grep -w scx_bpf_dispatch
>>>>> ffffffff8159d020 T scx_bpf_dispatch
>>>>> ffffffff8120ea0f t scx_bpf_dispatch.cold
>>>>> but this kfunc is present in vmlinux14.h
>>>>>
>>>>> If it makes a difference I have these configs:
>>>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>>>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>>>>> # CONFIG_DEBUG_INFO_REDUCED is not set
>>>>> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>>>> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>>>> # CONFIG_DEBUG_INFO_SPLIT is not set
>>>>> CONFIG_DEBUG_INFO_BTF=y
>>>>> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>>>> CONFIG_DEBUG_INFO_BTF_MODULES=y
>>>>
>>>> thanks for the report! I've just reproduced this now with gcc 14; my
>>>> initial theory was it might be DWARF5-related, but dedup issues occur
>>>> for modules with CONFIG_DEBUG_INFO_DWARF4=y also. I'm seeing task_struct
>>>> duplicates in module BTF among other things, so I will try and dig
>>>> further and report back when I find something. Like you I suspect the
>>>
>>> This is a bizarre case. I have a custom small tool that recursively
>>> traverses two parallel subgraphs of BTF types and prints anything that
>>> differs between them ([0]). (I had to disable distilled BTF to make
>>> use of this, the issue is present both with distilled BTF and
>>> without).
>>>
>>> I see that struct sock both in vmlinux and bpf_testmod.ko are
>>> *IDENTICAL*. There is no difference I could detect. So very weird. I'm
>>> thinking of bisecting, as this didn't happen before with exactly the
>>> same compiler and pahole, so this must be a kernel-side change.
>>>
>>>   [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack
>>>
>>
>> thanks for the pointer to this! My initial suspicion was that we had
>> some sort of dups of slightly-differently-defined primitive types that
>> bubbled up through multiple structs in the module case since the level
>> of duplication is so high; a colleague ran across something like this
>> recently and indeed if I dump vmlinux BTF in C format I see:
>>
>> typedef unsigned char u8___2;
>>
>> ...along with the original u8 definition:
>>
>> typedef unsigned char __u8;
>> typedef __u8 u8;
> 
> Are you sure you are not dumping distilled BTF?
>

nope, that's in vmlinux BTF, originating from crypto/jitterentropy.c

> This is the commit introducing a regression:
>
> eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
>
> Yes, it's a "merge commit", but there is a lot of code introduced in
> it. Among it:
>
> + /*
> +  * Use __typeof_unqual__() when available.
> +  *
> +  * XXX: Remove test for __CHECKER__ once
> +  * sparse learns about __typeof_unqual__().
> +  */
> + #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
> + # define USE_TYPEOF_UNQUAL 1
> + #endif
> +
> + /*
> +  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
> +  * operator when available, to return an unqualified type of the exp.
> +  */
> + #if defined(USE_TYPEOF_UNQUAL)
> + # define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
> + #else
> + # define TYPEOF_UNQUAL(exp) __typeof__(exp)
> + #endif
> +
>
>
> And that's exactly what causes this divergence. Commenting out that
> USE_TYPEOF_UNQUAL #define fixes issues.
>
> As to why that causes a problem. I suspect __typeof_unqual__() changes
> how GCC generates DWARF information within any given compilation unit
> (CU). Libbpf's BTF dedup relies on a property that compiler won't have
> duplicate definitions of exactly the same type (i.e., DWARF itself
> can't have two `struct blah` definitions), without which it's not
> possible to deduplicate entire clusters of self-referencing BTF types.
> It seems like typeof_unqual breaks this somehow.
>
> We need to compare DWARF with and without TYPEOF_UNQUAL and see what
> the differences are and how we can prevent or accommodate them.

Great find! As you suspect the handling in BTF btf_dedup_is_equiv()
covers two cases handling multiple instances of objects in DWARF;
duplicate arrays and duplicate structs. In this case however we are for
some reason winding up with multiple copies of structures containing
duplicate pointers in DWARF which have different type ids, which however
both point at the same target type. Adding the following to BTF dedup
accordingly solves the cascade of dedup issues for me:

diff --git a/src/btf.c b/src/btf.c
index eea99c7..2155dd9 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -4379,6 +4379,18 @@ static bool btf_dedup_identical_structs(struct
btf_dedup *d, __u32 id1, __u32 id
        return true;
 }

+static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1,
__u32 id2)
+{
+       struct btf_type *t1, *t2;
+
+       t1 = btf_type_by_id(d->btf, id1);
+       t2 = btf_type_by_id(d->btf, id2);
+
+       if (btf_kind(t1) != BTF_KIND_PTR || btf_kind(t1) != btf_kind(t2))
+               return false;
+       return t1->type == t2->type;
+}
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union
(we'll
  * call it "candidate graph" in this description for brevity) to a type
graph
@@ -4511,6 +4523,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d,
__u32 cand_id,
                 */
                if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
                        return 1;
+               if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
+                       return 1;
                return 0;
        }


Now why this new behaviour results from the inclusion of typeof_unqual()
is something I can't explain yet. Requires more digging to understand
exactly what's going on..

Alan

