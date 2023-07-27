Return-Path: <bpf+bounces-6070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DBC7652C7
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B451C21619
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB5F16406;
	Thu, 27 Jul 2023 11:45:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A5E57A
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 11:45:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013202109;
	Thu, 27 Jul 2023 04:45:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0tuXt023519;
	Thu, 27 Jul 2023 11:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Q6Pk0Pmh/HQq2+RmH+acbXg6pDTVQWRF604R1YO5/TI=;
 b=hFaaNHxA4DN1q5whsLT0MQpV7EVLx4+lKlw5gomOk8M8ddpqTRrhnVwOIhgg916aBwhl
 lY70XtMR1TWsJUiruEB6DqbAoXIQRqY0UJ3PDAKtKc+5JRLoK133hHpjjSagY4SeuJmR
 M/8farNELl8sTQ4TOCi6g4sDot/QgMcxp5Wldx+DnJ3KhEl0U79qlAp7PxapHzU+AkxN
 ewzFj2GB/wLTI1E156E2Mvs04jL9vALLLqZXeWcisdP+BY6xQaF0YonSvFwSp87x4W6P
 KSXCWHQh8ZW9OTbUk90e54SWHptWG9vaa5gEy87366wS+m0cLJQSsglobJDAOvc5kvjb 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3sh0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 11:44:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBYgH9030529;
	Thu, 27 Jul 2023 11:44:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jdu86c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jul 2023 11:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOPBoKO84f5MU2ep0rHInVEKA8zQwcfHkiZ3f1JKLbezWCD49b2aGR+YIKFo+9H83BZQrbm409F1A2Wwgmpr6+b0nP4IvGkwX5gcTL5BWaWAwS5fB1ooDJZqZvXT848Efr1a2Oiy1X3LSRcZESyR3bb4++bv+1eArhCL+tDW6eOS5cU2kde4ebo8ImlCWAqC5D1Wb8/glhRnB0tBD1pzIU2jU493h8Ua6llFIk5D/qsOB3t7wUkBlBotxRLZ2/gdXf69Oky1x84t38IxTvAmKNP3781YTAwiuwUmBhxBv2LrYTQRJCLQZTqpmsAMQrusRRBsrzoWzRXgybHMYcHKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6Pk0Pmh/HQq2+RmH+acbXg6pDTVQWRF604R1YO5/TI=;
 b=IaE0oxCxqdlCETrt6ykDFCeP1WHO3Mwis7EenUKVPAbQnBor4fBWmn5CC8rzfFNZnIdIb7BGQIh5/HTYaIUv54k42ml3NaJg4LjSQC5iUcjoEn0VGxhGxl4FBRr7XuUG7iQGKhIPOMP2iJKICeBSq1bWp9v2Ba0X/1vEpbnLwDYDMcZq8lbbdRX/CVv3/Bf1rwreePriedzJ+kkwWSl7ANg4yDhaEKPqXUjQaMBoK7G3AF5EKE13roV5Zx4OE1pbw2/42tk/toxf1G+ByF8a/BAhO6l883SzWmiQIzaDnpyaBIZKMYaf2AxAZNQjkBGeFnYz72l1wv5c/O48yi5UmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6Pk0Pmh/HQq2+RmH+acbXg6pDTVQWRF604R1YO5/TI=;
 b=N4jdsPN1gn1mhR38xXkjDC2WYo5eSC/VAbBzYEPjfJyDY31RapqBkj19pbXjEaOFbgnyD9EFHCpPD7uk7juIIof7XC+dom8L+rsT3ilexcCQmp913CBxYCD5tP9FGBrb2/UbLBr8tKqkNjzL4pW8D40l1n02f/6GumrF7bjUp2o=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7654.namprd10.prod.outlook.com (2603:10b6:a03:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:44:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:44:03 +0000
Message-ID: <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
Date: Thu, 27 Jul 2023 12:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: ed57cbe0-6817-43a0-9016-08db8e96c683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bndeNwbC1zV1GhounQFp3EauB+GDmFhPM4Z/n6jIumY/5EJ541+6tMYA6SUD44IIphRALxrIl2TVxNbC3v2cqSJezkZNdsHndxGoYBcrd5rR+zvwtSHiS8yP7Xpv9vVrJmcqWoHbftBZWU3lYPuYppH8qJKY524OR4UZQIRDQYUvIF3mRR03euTc1hvBek91KPIlIQZXfFX9NtSJdNIf3gH257jhBWnyfBDcFIlEr9SYb9rdwTkcO9uI3Y2DjABoFAEW8f37Ezu0vtKBy6w8vi/whPJm6tZg2pxxdvA/3ZO7jQV44ba7f4nhrdguQogwOZ5JPmNpLG+KZGolWYHw2wpwFN31acYMD0xsd92qpPdQioT1QUveAO4DMARaOBvHmpJtfF7Nt8A6ZULMIcFLESjEQmZYfJkdiEG/x0DsMl88t625NYr5zZPkOamV6Mr/TI3Q7FCMZdYsDnpxLkA07PaD9p+nA1zQSwldgkPrx2pbH3rrAMA1MEIf7tM2H2uQocizrGq9Cck0T4pvKZ0vJYt42BZsNde6LyWHpWUgQCmKIfH0sN2Q5kimsV+hntO9WtEo5rlgAV9WK8UmzaTiVCYCqRz2qw3ZhaXGCwTsncnT+sBUr1VUQeY0zMAzvCoNK4+hFvIRLnYRYCqH2w14+w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(316002)(41300700001)(8936002)(8676002)(53546011)(6506007)(66946007)(478600001)(66476007)(6512007)(66556008)(4326008)(6666004)(6486002)(38100700002)(36756003)(2616005)(2906002)(86362001)(31686004)(31696002)(186003)(7416002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWJXaHFuczVJNC9OeTdGeCt3dUJkOVZncnhNNnhaRWYrVmJNd05UTFQ5Ymll?=
 =?utf-8?B?bHNFWGhjMHh3dDZsRml6TUJpZGVrT2pWb0ZSbHhvbWlIS2cwRmVHbmhzbVlK?=
 =?utf-8?B?UkV6RnJ0bGpLZ1paYjdNVnh5QzNXa2NTZEJMbGxOVnhDUjk2SHFLbkR5eXh4?=
 =?utf-8?B?NGhrTE5ubXRmYUx3UnpUbG1ZZGlwVmtvcVZldzdrNmtuQnJvYXE0Q1I4SGY5?=
 =?utf-8?B?U1pZb1had0p1S3I3eTdJYW5KSzdKTGVxTTlkdi9NazBvYnJ5TkpBbWhJbzlY?=
 =?utf-8?B?VTNCSFdub0Y0ckVGcmE5elYvYVJSL04waVE5M3B4OUluS2NVODJZN0lYWGV6?=
 =?utf-8?B?ZlIwb29mUFloOVRkRUk2dm1rN05SODdiUkltcDB0Ry9UcU1BckZkaXgvejBx?=
 =?utf-8?B?eHNzeER3KzdSVEdLa1liQmk2SlhmM2hHWUtRdnBVTEEwOFhGbFpaeTIrMWo2?=
 =?utf-8?B?RUFhbGdja1pucmFwajJWQUgycDN4Q0ZqUGRnMnNrc0FwMkNub1B0N2xqanpp?=
 =?utf-8?B?bWplUS83bHJuRjE3SkcwblFsNHZDRjIzYnlyQTQrRnJzSEFTQkkyRElhb0Vx?=
 =?utf-8?B?OEtvTk5WT0pMVmx3bTNtRXNkMUIwWjFWRkk4emtBVzU4ckhreXd6c1JjdExr?=
 =?utf-8?B?eFJIVTBPVkpnSWRnWDVRYXpiS1FtZnNsU1RGTmptdlF6Q3NvY28xeE9GRHdW?=
 =?utf-8?B?Zk5ORW5CZUlqM1REcWRGTjBoVDN0ZmVpMW8rbFA4QWpuRFpiQ0pCNmVUT0gw?=
 =?utf-8?B?TmxEWXpwSytyWVhSOTVZTCt5SkpqeUJNZmZReDMrOEtSQlFaR3ZEQ3U1eVFE?=
 =?utf-8?B?LzBhRENQa3lBSVo5NDRQUXVoTE5nbjBhcm85ZDhDZkI3cXVFQlRmdEl1ZjlU?=
 =?utf-8?B?ZWxRck1jZ0MxYjFzclI4RGZ1b01tNUJWcUxEaklqV0pZYjBSNFpSZ2V5bmJy?=
 =?utf-8?B?d0NBVEFESDdrT1RCZGJRQTRKZldyRXhCVENkRHNPRlpMdEphZ1pOaTRoRjdv?=
 =?utf-8?B?bmxxUTlldGRzWkI3aUlQZHJJRFNLT1FGaW1GdHI3YmdudElNb29GQ0dQaEs4?=
 =?utf-8?B?YWRsZHNqMVltcFMxTGxlVWRMWHM2MkJUUWpBZ3BubnBFQ3JtZkNtY2QwSXhs?=
 =?utf-8?B?L0lSM1o4ZzZUUFZTSHVyT2JsZS9qWm9DaW92LzFlL3JaNnVPc0tsS0tSeGkz?=
 =?utf-8?B?cUpXeGRVSlhBSkhTVkFsek9Xcm9lNWJUK0I1bjBsN3RCUVI3RmE0RE83OGxk?=
 =?utf-8?B?ODBxOC96NkpSZGwvekFCTTFnUzAxMUdWMGVKaWFtQ1lMamNQaHQ3VHp3VlBO?=
 =?utf-8?B?VVNwSzNkVHhqa291NjdHZDFUUDFHeWVmMHhEdzdaSitHNFRjYUgvSFpLbDZP?=
 =?utf-8?B?cEJsd0Y3aEFhRHNEM0xMRkhwODlOQmNtYmhsU0ljNG16Yzk0Qnl2VkM1a1Rp?=
 =?utf-8?B?YlNSTGNMOGRSYXVGWk9JY0tMbkovUG5aTEFiQXh4QmtuckJCYzN3eE5mL3hh?=
 =?utf-8?B?cVBIRGJaSlU5QzNCbTdJZFY1SkNRS0IzbXpUeUgxQTEvbUdXYkE4Q2FON2tV?=
 =?utf-8?B?YnYyb2RDL05RWXg4bU1mTGl1bDNvMTE4REhMZ1hWdnBjUjI3LzdnblpRdXdm?=
 =?utf-8?B?aUw1MXhmM01jbXF1OUc0MmVMbkdwWHJPbDU3ZEFRZi9qNlA0a0RrdmtoYzJ3?=
 =?utf-8?B?VGE2K2t1MEp5YW5xY0lLMzRQV2F5NUlhRDJPVUUwY2QwSjdVemh1QXdZcERR?=
 =?utf-8?B?MGpteHh4K2ZlbWtKTzNaMks5Mk5pZk94QS9Yd1QxbEpNK3h1dlhHMTlZOUtm?=
 =?utf-8?B?VFAySUVzcVhERVVuUDNjS3hjeXp2U2MxK3dVcFVZanVJRnFueVpNS2EzVHFw?=
 =?utf-8?B?anRRTmxhYXZHQ09zZEpZaGdrNjlIZ1dPa1NmRFU2cTJ4NnJRRnAzbWMxS0ZG?=
 =?utf-8?B?NnF0NDFBVnRwVjhqejkzbERzQVY0OENTQnZUNzVkTmFQblZkVk51Q1FpWW8y?=
 =?utf-8?B?OXcyNUVaKzlnK3JyN0RETjlNWm5RVzhRcUZpdmpPVjBmdVB6VTRlM3VBL2xJ?=
 =?utf-8?B?dENoSGFJck5LRjd4dW16bjFucy9EZXArVS9ySTRJMXpISjJUOVlnN0JHR0ww?=
 =?utf-8?B?eXFHS2oyV0hkWno4bk03TGxwVGV1cnQ5RnlUOVlKb0lHc2tHcU1FM29JMFN2?=
 =?utf-8?Q?f0QCmjVsRbyRxZvbMHnnSVI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f1JE03ILNMkF74uKVkAmm7bNXGHwarEj1fwuPpC84cvt4Mqj8fp4onAXWsej4T54X3HjHyRYN1habJiUoxl8U4ZblyhraQCmzhaRdHWcD0WepCLzxOQOXEPKmeCjtM4nqdKmuzeSyn8Kwp07ySB3vXRkFJPGmhDaz4FJMvlAVdoLsQBex4yt174hB7WUeKh7/PGmr656A+xK0NXm4D4aAxyaM+tEJ9VXoVyJnr86NFHocB7KcO/8LWs5ex/ts7eYs5uGRsn9SKpvc0sprcIifvydkO+tLEnESOjaXrFzGjy+nYnnIeH1cyLEhVqZru95JF6xA8agcY5QVcBDKzoa2iCASLLhRZpqNkySlmZurXTkxVHFhY77gc22jvkqN/36Wnreyccga4ZzKFLSRKcMI8hYxFOv4ptnMdH19YzIOzGwGndmSAe0K7eoUhw+pmOkJK629fHN28n08RaMkm9kLRjHCvwQ3wQBhjpyp84jAwqg8d09WXDR9Qatg7yNx3Si7d7XNMH5ib1b2tCG0bYn4piua4Nk+9MP1gBqUHFcFt/LvM2sY42Ur506c6lZUvrb83Tuh0A18mgeTDoKSSgloO+Gwdf7TMPM0Be4Q0D6hGhX1KHGAW7L3C3B1aQDk1OoXrBlCHOn7/eKkRFUDZ8zW7D/l0jP8MgG8xSXdGwudxWUSaZrin17vvJqKHAU1Xu5RWvgXKM/m6z9JrbdFkS1Rf3ikRDfu7XtpM/rR1Ns9mZd4W5G953wcrkm5YmfzE/S6Xym3lbuuAJ9IpzbJh/hxHFKbJr8prykrPe8lsqfSg2YfgMAkeonThy0UNaV6d0H269P2lcbbWGYi6I4383BLkuJqHPfPyZ3dlC/KpUqbpGvJDjXoYOJA2xcWQoBloWw32TCHtuaOLbkRCtN5hFXc3OG4ElCfvpjqL5ASXyH/VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed57cbe0-6817-43a0-9016-08db8e96c683
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:44:03.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6Q3apCmfMh0YALYpCD3R18WktYsu2KJjugklTiXT5DLQ1XfKxIKA2J7OdQMn24DXY9/hA6M2P2FjC7cjEP6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270105
X-Proofpoint-GUID: 1o2IzdSE7MBijBucTshVFhNgnWoQOyKC
X-Proofpoint-ORIG-GUID: 1o2IzdSE7MBijBucTshVFhNgnWoQOyKC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/07/2023 08:36, Chuyi Zhou wrote:
> This patchset tries to add a new bpf prog type and use it to select
> a victim memcg when global OOM is invoked. The mainly motivation is
> the need to customizable OOM victim selection functionality so that
> we can protect more important app from OOM killer.
>

It's a nice use case, but at a high level, the approach pursued here
is, as I understand it, discouraged for new BPF program development.
Specifically, adding a new BPF program type with semantics like this
is not preferred. Instead, can you look at using something like

- using "fmod_ret" instead of a new program type
- use BPF kfuncs instead of helpers.
- add selftests in tools/testing/selftests/bpf not samples.

There's some examples of how solutions have evolved from the traditional
approach (adding a new program type, helpers etc) to using kfuncs etc on
this list - for example HID-BPF and the BPF scheduler series - which
should help orient you. There are presentations from Linux Plumbers 2022
that walk through some of this too.

Judging by the sample program example, all you should need here is a way
to override the return value of bpf_oom_set_policy() - a noinline
function that by default returns a no-op. It can then be overridden by
an "fmod_ret" BPF program.

One thing you lose is cgroup specificity at BPF attach time, but you can
always add predicates based on the cgroup to your BPF program if needed.

Alan

> Chuyi Zhou (5):
>   bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
>   mm: Select victim memcg using bpf prog
>   libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
>   bpf: Add a new bpf helper to get cgroup ino
>   bpf: Sample BPF program to set oom policy
> 
>  include/linux/bpf_oom.h        |  22 ++++
>  include/linux/bpf_types.h      |   2 +
>  include/linux/memcontrol.h     |   6 ++
>  include/uapi/linux/bpf.h       |  21 ++++
>  kernel/bpf/core.c              |   1 +
>  kernel/bpf/helpers.c           |  17 +++
>  kernel/bpf/syscall.c           |  10 ++
>  mm/memcontrol.c                |  50 +++++++++
>  mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
>  samples/bpf/Makefile           |   3 +
>  samples/bpf/oom_kern.c         |  42 ++++++++
>  samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
>  tools/bpf/bpftool/common.c     |   1 +
>  tools/include/uapi/linux/bpf.h |  21 ++++
>  tools/lib/bpf/libbpf.c         |   3 +
>  tools/lib/bpf/libbpf_probes.c  |   2 +
>  16 files changed, 514 insertions(+)
>  create mode 100644 include/linux/bpf_oom.h
>  create mode 100644 samples/bpf/oom_kern.c
>  create mode 100644 samples/bpf/oom_user.c
> 

