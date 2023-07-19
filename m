Return-Path: <bpf+bounces-5279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DB7595E3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4551C20FE9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA614288;
	Wed, 19 Jul 2023 12:48:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76007107B6
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 12:48:57 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955231986;
	Wed, 19 Jul 2023 05:48:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JBj6ij018633;
	Wed, 19 Jul 2023 12:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cYuXfjalpb0wA9Fhyt4f5qq9Tl02quM3q0RmgxC4sio=;
 b=ZOWRfSifaTKvzYfPZ+rPSdiBNTzaIMoob4O7FBznSo8Mfj3v5t9v83y04mji3jc0witB
 CyS1tjhaocQbkeU35GhP9Jgi8cHjG0hVicE2bnaFwCmEemOAStB0mSJOSsAxUS3pRVak
 yBTB13QczxuCoLhXi8/g1O93Wr84c4zNCzcl1BWOklQqB50lbrnMx9CuSPoQVh50ZuP4
 BFaLjBcyeZRz+5Q6JAyEWXyfE/EEaj3a4T3B0LqxRMhDnJtJ2ryNcusNsgJIe5JaUonv
 ft0NVqT0f4MYRURU08+zykSN+xYhbMzVB0NtRuAnOxgsWKn371x1aMCf3SbYy1hUwzwe Uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run77ycj8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 12:48:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JB6YDn038185;
	Wed, 19 Jul 2023 12:36:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6s7sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 12:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqmo7SLgQbrF2GJsAH7HS0FYh9zCcLxjgoprWF4zefsBQkcj7AX4ch9eBIKmAKOzWQzWVfU2ShQ7t2d8y6KPO/jdwoefXTy+BrEFmfJOFcnXlMbmmS1z6f/yPWF9/mQZP+aIT71Ua2fcWalzPN7Sm4JEmiATFWwhtVv3HM0ecx+3uq0+E4iFxRpvLSlIDFv4f5h/HDhDK3JOdCwMDJbdLUIXJCcptF7x9jpZ9ltgTEtQ6ax8txxACXl6nb7i3+qV8SQAbnnWUgFHiR3nB0fVtFRAU6Be26RiYXeJU1Tu8LXamhXI+TzQZVgRjj2dsg15TRCABSgl61hrhwNyZBzd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYuXfjalpb0wA9Fhyt4f5qq9Tl02quM3q0RmgxC4sio=;
 b=nklfE9w7DGlPjn60zlo9Jluu0fn2S/qJES9zq5bSgCDwboD2I2pKCx9yTdrSYsUX2HT4s6m0a59fKGU/46+zlOU85tCMkq034dZKUTQslMESdcQbuhYDmqofXbbJOixsRTAG9o6Kh9lVwkyc7YPE2y2Gd1o2yUt1RR3tRoka5QmjEUUyjYVVkP0niyeURqwaqaUdlbkwJqRfPrxNMsZbQM3i/Lq49NBJp6fNWuF1rJsVhoCVNgOfrhUa8ZaL4sAnZMIujPxQm6srJdnbjXj8sWqV9BIogcTvRk4qD5a2MXY0lYQ5k64nzDWTPY3L0hDzR5rDt4H143FV212jsOrXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYuXfjalpb0wA9Fhyt4f5qq9Tl02quM3q0RmgxC4sio=;
 b=nFlR9i7hwibIeDsldtNQD9TGCiL/kC2ZP6v9i/2zgi4+F4nVn7nf4GNQq/VQQv2iy//rLbBfCrIlCRX+5WxA8tgytf/+dggfjGlUM7rVcaMVFdWb9lluQHw9gigvCLBWQwkbX8Gwj8Fn7brRiP46ZP6WgWcVfljh0tdSRkocvNI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB7829.namprd10.prod.outlook.com (2603:10b6:806:3ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 12:36:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 12:36:53 +0000
Message-ID: <13926373-1beb-16f4-180e-f529a8c9b0a7@oracle.com>
Date: Wed, 19 Jul 2023 13:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <168960741686.34107.6330273416064011062.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dbd366-b31c-473a-b378-08db8854d49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	acllR9G9RrND2SuiiWjl2Q/9OQ1MK2AFAXRxLnDXNmDj6QMbzEtqn4KS4dWmeMroHOK06SXw7M+V7U+nVENppfz88RQOpK9K4TJgZ7lHHT+A09cntkc2XV9DBmD6dAH70pySNaPzgtKWni/yywWgZKSwBJgk3PmH3sb2qPdDu0qrs1BbbUZxoEWSSyeabK79n8IAN5PLxVE8VMO2N5lHuZaN/rYie0+VAcpRAAnGdK4dhB1+18UcthyRfIDRKTRKX+pIv8cVXN8mXSw2V9687510VbYEtZnIwv1LXKWPye22UmgkOcHxoGrPm3pF9ZQ1y/FY8eVQ0dvCA0MysL0g5wkO660xzosKJR/kV82iT2Asuduw9V0NwnjTNxTNNAtT1hr/F/LsO8x2cl6vxVUpCHLrfPmxKND3D5phHlIWYIuAwmsLjr7jibl8J36jR6xIqvzJSbHX8zQoB/VosJHnU+C5s7bHGGHhOC11qTWzQYd55BRcW1c9YrfN1HJDykmwSnrHWl6xhVB46ERAbj/vHNOwUqcXu3lrKc3IHWLE8sZ69hoSyR9JWROBkOmoAQDYDfG45VyboiYeq+emneJiERNN9frncYdSyEGVo7/e5KGO9jVMs0YZmTIEWVKSimD8LmHn+IF4IRS7SUn17ttv6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(66946007)(44832011)(6512007)(66556008)(6666004)(6486002)(66476007)(2906002)(316002)(53546011)(8676002)(8936002)(4326008)(36756003)(5660300002)(6506007)(2616005)(38100700002)(186003)(41300700001)(86362001)(478600001)(83380400001)(31686004)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjU4R3R1aEQvS0dnSTlYUGdxRlIvNUprMGNRRDR4K2N0OXNmYzZBR0UyQUdR?=
 =?utf-8?B?Q1lvR256VlRkUEc0VXQ3bzlmUitscHA3UUFKak5hblZjWjEyT0YrVCtydTM0?=
 =?utf-8?B?cFlINXB1Z21hM0lBYS9GcUJUQUxra1c4MUlZWXhVenVDVkFoR0xFODdhOHdn?=
 =?utf-8?B?UkRCUmh1YzN3L05VSktuR1gxWDBlcldmV1M3RU4vblBBUXI2eVhuSjFEb0M2?=
 =?utf-8?B?ZFBVd2J3WXFULzBWRUJHNWJiRTYwbnp3di83cVdwYW00VWRueXRMc1Y2cG5R?=
 =?utf-8?B?akVITFc3SzdScXpyZURDNTJFZnNENXpORDFMMlBrSld2VnhsUkgzRnFJTGRO?=
 =?utf-8?B?Y3FtMzhzM2NoSC9JdkRLelRzenNONk13TGNZNWFDN1hGMlZFb1JjVnRGdTBL?=
 =?utf-8?B?Wk1ISmRTcGJPYUJaZllDL1NMTWZTWkgrRzVrQmVyNWRwbW9xeERKMUtzM3pP?=
 =?utf-8?B?Nm4wblQ2UmtDVmdqbE43clZHNER0VVJ0QkZTOFZ3SjJkR1pZUEh6bC9EVWVC?=
 =?utf-8?B?Sms5T29FdVBLK3hjQnRSaURvWHlIUDdqWnRhbkhkdzhZeUYweklXeGhnNjdi?=
 =?utf-8?B?RHVSVUNFMUtBWWFlZFpqR3RXbWJuWTVEcVZpem5KM1JLSkdDc2dkYXlyeWhF?=
 =?utf-8?B?SDBzcW5uOGUvT0ZFL0ZGZDdRQkJFZE5heWtoTE55OHhYNVdVQzhHaGFtZmVI?=
 =?utf-8?B?NmpaemtheEM4YjJGZThtSlc3aFN5bnM5RzdhSllVZys1bmxSa3hoekM3VEY1?=
 =?utf-8?B?Y1gxN3BXSU9VWEZXWW9BU2JxZlMxdUFXUEtadmxWeHByWkY4WURXMEhZem8w?=
 =?utf-8?B?OCthRks4OWVoQ3dWOU9YcEpUb2lReFBHQ3BBeFVwTmZmQ0pCY0FPQXp1ZE12?=
 =?utf-8?B?RWRVeW5yK1VaN3RmMFVERVZnMlVaZ0cyUzFPaHZFdHAwU1pxdC9EQ2NlM0xI?=
 =?utf-8?B?dzNOWllaVXhWN2x1Z0QxWVcrY2JnTVBZZFVONGN0TVkwRVNoV21qeFVTN1dM?=
 =?utf-8?B?OEZUVDNIeWpmK2lwZ2FGT2ZrbGhEbkhJUW9CaXRYeDFzbC9kTjQ3Wjd4V0h4?=
 =?utf-8?B?bkpHWlcvZzN0SUJiQlgwNGI4ME1WYlJHU250dUoycFBGeXJXRHN5NG5ud1Ax?=
 =?utf-8?B?YzhaTzZwR3FpeU5DU0prUTJtQytHQmhoNXY5aC9zM2dqZkhjcGRNbUpPLzdW?=
 =?utf-8?B?Z0YxdlhDY01iOXJla2k3TmhJbHlxaVZzUHJRbHRYd25HRFNyR0crZjZhMTRG?=
 =?utf-8?B?dGlmSjUxaVc1RS9YZlI4bHdiaGU2SkxaZ1ptb3hTazhYSnBCS0U4VUYwUktv?=
 =?utf-8?B?bkJUMkU5aTBZNWd1SnVsalBOUlFEZHRDQnUyQ1pHTFVJK08yTTBWeFRhSlR6?=
 =?utf-8?B?b2dEOGQxWnVLYzVSNklwQ05SMTEwVnRsbUl3d0Zzazk1cDRKVUFKdHMxdG5E?=
 =?utf-8?B?QVJqaFVVcmN2elVIb2ltRmUxWGZJM0EwMUhWblNISFVTTllPdnRRb1hxSHI4?=
 =?utf-8?B?bkF3SDRkYllVVXVIRlcrN2gyV3d3UFY5L3pDeWdhS0lKcW5BbGVoRi9sMWRH?=
 =?utf-8?B?NEx1Y2Jxa3RQZ0g4OGEzcmEwNVp1QnRLN2VnMXdCMTQyZm5lWkxkZjZJNkxm?=
 =?utf-8?B?ZWlsUzRHWGJkUUhUeERqUzdCRVhJZFc5eVQxN2txb00veE40UWNGUWIzN0F6?=
 =?utf-8?B?Y2o1b1BFT1c3UmxwamlqWUZ2TTJMNCtTek9RSGhMUnZYRW9hOTNjVXNsZG90?=
 =?utf-8?B?aU5HYlpNWksyNEZwNk5BRkRieHVJeWpONHpFRmQ2ejIwZlZYenQzbmpobmtK?=
 =?utf-8?B?M3hnQURHSEYveWxaZUpiMk9aS1hGWDdwWDVwbXExcHFDNXg4UXd4SXBHRU5p?=
 =?utf-8?B?MzU5RExPRmVraStLNzBRV2c1OTBQZDRRekNBNE84Q0NjTjRLMVRUcWNoa3Bo?=
 =?utf-8?B?M3paSUY5SmxyV01sRk1Rb20vTkRMbGpJRENkSSswUEd1MmFyaUt1RWE0czl4?=
 =?utf-8?B?bURZelExbHRMUWZ2NkQwTTU0bDhqTklKUlZjOGE3VVFvajFMakUzNGhocEt5?=
 =?utf-8?B?aDE4OStMVmpqa21idWhhQy9XeURQTmdMYTZ1WjNuVkJvQzhEbDBrUTgvdVlY?=
 =?utf-8?B?Y2lWRzFkRURDU1VZTVgxbkF1aUpYMWZzczhLdzFDYXpVbkRIdno0bkhSS1R2?=
 =?utf-8?Q?R+YfvnYvFRQLn3RjrC54fYQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n70VPr7ANNv0k9JWYaR2/OkDyn+V2pDQMacXS5NTkaVvIv5hzZ8k4ogFqlB5YTSedjxfkR81nnGleN8unvNyPDiamXYQLdcEYeF8iajD+HRKifh+axv/MHCqLdGu772J/3STrBe3ju6YfBPNDDdEBTPwbNVdEd5mcUWEwQGEsbkgWLMXLAYfeVLlIKqx3KM+pTVwOY/TB9h7SrJDtYqEKvqQTBNaOqwe05amuSqraNHX0AVR0E7henaBdlSXn7QLgnlkD7/wVCdxrPA60/62FFRkiMgguVN4cM4VZdgL6euv5SEzuiMpKD4tot6+yjnm3aVJQY+gSixxBr41T+r/rmk2s+iS0YjTf8Geks+IbeujNoVKriq616O6lEgfRsLvmuLUAtQPflSY+Up++Tt/9ivFy/LZcG/m6krZZOYiavMk+Y3+5Rb7WHQ7NmJSnZIZFg8DjBVm/t5Im9GorcdQW0DY/j94qBjvTnCRfNh4t1LtvYCFjvQakpT624bxqsNJUqAW72baw1ke7QAg1we8mz71WiMVJuFtQdLGdvjAjqIX2ufgyhe+tDF4uu1eC0gXCyGI+NWzLcxRWJs+EupCm31dF4h+XVu2MSbLnuut00HOUDynFvyIbPMmLQHWJYY0ha8j/zVBmQgVSz4qRZgpHZtd+slYNC79VkOn64LfIEEH7+jfOmr72S613v4APBxOqWI4oaJ7wV7+T6V1nU/09Ojvk1iy8Ya3xSGV9FAf6q/hj9d68g1o0KmFC+uI73EJ+kRcyn7mG/8jzoHmOLb4HBs7kDjHnN5FobLOimzw/8PbJpuBVLSNbJCEQe9JbWHkHpFCarMFJPpsByxNN/O/vuqfaKLregbPQdFqBpzfbVF2OWufTgxNIunaUlCJa7G0AxZm1imqvW/jwooOUDvIKw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dbd366-b31c-473a-b378-08db8854d49f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 12:36:53.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/84/uji7hebHHfPwIRF/ucHiHzlMlkE6qv/cOhzxuUTv96aw2V9NxIAJRop+bkt9JyYjOLXANO7dsePUSQCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190113
X-Proofpoint-GUID: FAHtEU5Grg_ct5zGxRJRvVDCvMDtewg4
X-Proofpoint-ORIG-GUID: FAHtEU5Grg_ct5zGxRJRvVDCvMDtewg4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Move generic function-proto find API and getting function parameter API
> to BTF library code from trace_probe.c. This will avoid redundant efforts
> on different feature.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/btf.h        |    4 ++++
>  kernel/bpf/btf.c           |   45 ++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.c |   50 +++++++++++++-------------------------------
>  3 files changed, 64 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cac9f304e27a..98fbbcdd72ec 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -221,6 +221,10 @@ const struct btf_type *
>  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>  		 u32 *type_size);
>  const char *btf_type_str(const struct btf_type *t);
> +const struct btf_type *btf_find_func_proto(struct btf *btf,
> +					   const char *func_name);
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> +					   s32 *nr);
>  
>  #define for_each_member(i, struct_type, member)			\
>  	for (i = 0, member = btf_type_member(struct_type);	\
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..e015b52956cb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1947,6 +1947,51 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
>  	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
>  }
>  
> +/*
> + * Find a functio proto type by name, and return it.
> + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> + */
> +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
> +{
> +	const struct btf_type *t;
> +	s32 id;
> +
> +	if (!btf || !func_name)
> +		return ERR_PTR(-EINVAL);
> +
> +	id = btf_find_by_name_kind(btf, func_name, BTF_KIND_FUNC);

as mentioned in my other mail, there are cases where the function name
may have a .isra.0 suffix, but the BTF representation will not. I looked
at this and it seems like symbol names are validated via
traceprobe_parse_event_name() - will this validation allow a "."-suffix
name? I tried the following (with pahole v1.25 that emits BTF for
schedule_work.isra.0):

[45454] FUNC 'schedule_work' type_id=45453 linkage=static

$ echo 'f schedule_work.isra.0 $arg*' >> dynamic_events
bash: echo: write error: No such file or directory

So presuming that such "."-suffixed names are allowed, would it make
sense to fall back to search BTF for the prefix ("schedule_work")
instead of the full name ("schedule_work.isra.0"), as the former is what
makes it into the BTF representation? Thanks!

Alan

> +	if (id <= 0)
> +		return NULL;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +	if (!t || !btf_type_is_func(t))
> +		return NULL;
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(btf, t->type);
> +	if (!t || !btf_type_is_func_proto(t))
> +		return NULL;
> +
> +	return t;
> +}
> +
> +/*
> + * Get function parameter with the number of parameters.
> + * This can return NULL if the function has no parameters.
> + */
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> +{
> +	if (!func_proto || !nr)
> +		return ERR_PTR(-EINVAL);
> +
> +	*nr = btf_type_vlen(func_proto);
> +	if (*nr > 0)
> +		return (const struct btf_param *)(func_proto + 1);
> +	else
> +		return NULL;
> +}
> +
>  static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
>  {
>  	while (type_id < btf->start_id)
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c68a72707852..cd89fc1ebb42 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -371,47 +371,23 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
>  	return NULL;
>  }
>  
> -static const struct btf_type *find_btf_func_proto(const char *funcname)
> -{
> -	struct btf *btf = traceprobe_get_btf();
> -	const struct btf_type *t;
> -	s32 id;
> -
> -	if (!btf || !funcname)
> -		return ERR_PTR(-EINVAL);
> -
> -	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> -	if (id <= 0)
> -		return ERR_PTR(-ENOENT);
> -
> -	/* Get BTF_KIND_FUNC type */
> -	t = btf_type_by_id(btf, id);
> -	if (!t || !btf_type_is_func(t))
> -		return ERR_PTR(-ENOENT);
> -
> -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> -	t = btf_type_by_id(btf, t->type);
> -	if (!t || !btf_type_is_func_proto(t))
> -		return ERR_PTR(-ENOENT);
> -
> -	return t;
> -}
> -
>  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
>  						   bool tracepoint)
>  {
> +	struct btf *btf = traceprobe_get_btf();
>  	const struct btf_param *param;
>  	const struct btf_type *t;
>  
> -	if (!funcname || !nr)
> +	if (!funcname || !nr || !btf)
>  		return ERR_PTR(-EINVAL);
>  
> -	t = find_btf_func_proto(funcname);
> -	if (IS_ERR(t))
> +	t = btf_find_func_proto(btf, funcname);
> +	if (IS_ERR_OR_NULL(t))
>  		return (const struct btf_param *)t;
>  
> -	*nr = btf_type_vlen(t);
> -	param = (const struct btf_param *)(t + 1);
> +	param = btf_get_func_param(t, nr);
> +	if (IS_ERR_OR_NULL(param))
> +		return param;
>  
>  	/* Hide the first 'data' argument of tracepoint */
>  	if (tracepoint) {
> @@ -490,8 +466,8 @@ static const struct fetch_type *parse_btf_retval_type(
>  	const struct btf_type *t;
>  
>  	if (btf && ctx->funcname) {
> -		t = find_btf_func_proto(ctx->funcname);
> -		if (!IS_ERR(t))
> +		t = btf_find_func_proto(btf, ctx->funcname);
> +		if (!IS_ERR_OR_NULL(t))
>  			typestr = type_from_btf_id(btf, t->type);
>  	}
>  
> @@ -500,10 +476,14 @@ static const struct fetch_type *parse_btf_retval_type(
>  
>  static bool is_btf_retval_void(const char *funcname)
>  {
> +	struct btf *btf = traceprobe_get_btf();
>  	const struct btf_type *t;
>  
> -	t = find_btf_func_proto(funcname);
> -	if (IS_ERR(t))
> +	if (!btf)
> +		return false;
> +
> +	t = btf_find_func_proto(btf, funcname);
> +	if (IS_ERR_OR_NULL(t))
>  		return false;
>  
>  	return t->type == 0;
> 
> 

