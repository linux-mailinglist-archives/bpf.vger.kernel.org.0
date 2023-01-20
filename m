Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B816755AB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 14:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjATNVz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 08:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATNVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 08:21:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B49B119;
        Fri, 20 Jan 2023 05:21:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KBujWb002250;
        Fri, 20 Jan 2023 13:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ajqGftXE6X1SyzHT54uifZyy46o5+gw0GcsoEyk/mNo=;
 b=LHzuhzyF4TwSogL+dtT1CroLaxrszCy77Zy7YxAjhgnwO8nRH/G4WvMv+4q/kC4ZZQpI
 M97rEyvgFALNRZ8QC4OxS3mYd0of4Gr350nQHou8yiA2gwYzIPWIam3Kup98JWhtI19D
 k0vheIMUWHBZola7lkqH4sDSNHttMeCgXnDrfihHQjbRH+gUTVz6fOoHHIOOv+QPcd/s
 PTN8uhoF/3mR94Upr5Uqu3+zehYbAyoaKFo7L3k5lyc0DtAmUgyuzBlj9T7d5C0rVPAG
 pDwKlg0sHr+CRFPkx5782F/LxIdod87+1N/gXSW6NJdy8dfZchWyAZ0f49KsJRpKsRwN uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6ccmdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 13:21:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KBgSsJ007723;
        Fri, 20 Jan 2023 13:21:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgef55c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 13:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHVP1Rdh8Mtv1PWmapFp4ZJEP+8fOliHT7PlN+oUa23hzzqWSmbUCSYNCjyF+6WGEcGdBKVDnk9lDdfC/6gVGt18C6z8dWWe2cV0ORtCRDELZlZAjh9kXWCnWsyJE5omq9YYJ57OEDtqe5k4dKdW+7axqFGe5u0ykQhnvTSS4X+CkCBoUV/ZvlNbOVyF/q5/bjoFuooixCxIVlHhOYyWIWSLupxsseBbfwV7mWCwJTCJHUnRp/+1ymc/ssjn3SY8RGSKIJbjZgWMbqHiXnjElw/WNZUA2dY5C88rtOJPGYOT5Ojb8cgdkYtv2w0iiOl97yBaRfHL1IvEVDwfZwqSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajqGftXE6X1SyzHT54uifZyy46o5+gw0GcsoEyk/mNo=;
 b=kbiGew128WvXYZJdVk032UwAvPXD+SezHPcUkSWxFyA5naatgJZpMkjwuKgeoAE2V8Lso0fWTw7Jq62dWa0T7IqDUx6SaFtYPAmL99B7MJqhN/POlmIZX/ssCwHjHKYKvfaI0wL1oq+3MIVmwQKuVKP6P7eKGfpk56M0hJRtwepOKdYMvc053ftuDHuROMqGhNBcEyZW+OjjTtFnpNuSOJb92xLiOTbvFZp/v5LtYtwdMvWvxhKBduaW9KgriMZ/dMZfieOuv0G3LTTrBnC3ZDL0RsLyyGSZm2ipFcHn1ihyM0HIonc6/3STObond67/OcJCf1fV9C+jaBqktLc4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajqGftXE6X1SyzHT54uifZyy46o5+gw0GcsoEyk/mNo=;
 b=ZDkPG4DsLzCYbpmajoxFfSWNkFxw/cF1KE9urkbjTEs0RZfhO09vE5I6baHEUS93RaPtEY3zkroqEA//zRJUYjDgRf2Bo1jILYcy37SCh/m1RAIOGlmWTQ5Sw3fnGhOia0oKe43Y1k6KvstU0GltPXwviZ4wggmWyxM1eloTskA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN4PR10MB5797.namprd10.prod.outlook.com (2603:10b6:806:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 13:20:56 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 13:20:56 +0000
Subject: BTF, pahole and static functions (was Re: [PATCH] libbpf: resolve
 kernel function name optimization for kprobe)
To:     Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
 <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com>
Date:   Fri, 20 Jan 2023 13:20:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: f462c1ff-02f2-4aa5-4230-08dafae929f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJ430zbUyZuNx9qYD4caku37cOagCANytybIDRBsDcTPqWNiV2/Ldmyevnl/y2hW4nZPrpI0VWKjA1CncmrO7pP0sOfm7fGicSQ9EjTgXQVrhwb37X/o2b1uH+gX1sq+63EzgxggrhHRwtGjJ934LmnB+VUXM75ZFe8d9yM5J0/836LA6urPrF9iMjawNSbCMQj/aqLa4172yfjiBloAL0X63eNOTZ7J2BpOqdxZD3/GZRzBrkGBAc4uUvl29PIDNzSbqmyScMEyzj5pa/L3m/fBB6uD/w1WTcYNyU2Zl8L5Uo7/8ETQrfhqkAIe2VwH9faKvU5VUQ3b1WCWj1OVTYv9fP6q4r6AhI3QVxjz3AEYnmJhf0iw8pCiqHo6mVBiD1hfslo9D80gRlA29dal589UEvnQPr+1Ul6s1KSeBiq7Mjhs5jRMs8WKWQbEzd8nMqN7vmfisq05hWb7nRQcExZr9j+DALk3K4HqhB2tZlA7TLhZQYWu42AMyjxU1Hk6jmtLZU6vMV6f2ba+gC0OiRYIS4JbeH2yFQI6VI6srCA9HAxsmJuwHmKF0vq/vFpvUbhFlYe+Mgs6uYwea2DynAIjN9RC0Bb8zipFx4PYs1at0HZmwhu8EpmDUvLA41h1+n4zFl5FWE6bEWom1tq6jxnRHrn3D1eF3X40zlpniGtgV05QHRz3pkjFrZT8VgJXeFz9cvyeo1ngzy9RnvBOzYJrltaeO215TjI2LYxksBKPK6HjPD5kpphUL0tuqfVuYmJEn6rGbc5+a4nd3Ie1fh56tGKwFcztHbOHWL+rA3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(478600001)(6666004)(966005)(6506007)(6486002)(66899015)(53546011)(86362001)(2616005)(31686004)(31696002)(83380400001)(110136005)(5660300002)(186003)(316002)(4326008)(8676002)(66476007)(2906002)(6512007)(66946007)(66556008)(54906003)(41300700001)(36756003)(44832011)(30864003)(38100700002)(7416002)(8936002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhwTzNVTCsvZnprU3p0eEgzOUt0d3dMdW9MZUhTVHg1SzJHMHl1d0Y1Q3ZZ?=
 =?utf-8?B?REUwZ1RxeXBEM1B0U05yR2RYTHErYzg5cXFyNzFjZHNsbVo1QkZkMVJxWEZG?=
 =?utf-8?B?SFNQaWx2cmZ1V2phSjUyRWhpWHhGZmJFRFMxOHNPRStVWkRvcVE5ZWpITDRS?=
 =?utf-8?B?UnovMm4zb2JmRlhGZ2lLWnhQTmhuRkd3dld5U2o0VkNtUW9GVlRoT3pJWkkv?=
 =?utf-8?B?ZnRqWDhmcmV5VkE0QktHdVFVTWpLcHpMTU45cThjSGdUMDMrckxkUFlBbUYr?=
 =?utf-8?B?c2ZKdU54RkhUSlpNNllmMTJJTjRnRVZOZGhBSHcyVHZCT1o2OXF5YXQxZ3lL?=
 =?utf-8?B?ZXZSbjFyNVB3KytPMm42V0JrdXdSeW9XMGJVK0JCZERoNlZBbVFVK2tFVERk?=
 =?utf-8?B?N2hRNzc2Umx3MUVLVCtscGFNMFpUVlk2MjMzUEprTmJxSlVURnJaYkpRZjRz?=
 =?utf-8?B?U2xsS0xqZHp1dmVUMzIvNS9MZkNrSFpMempnckV4LytRb2VJMjU3RVdMNW1V?=
 =?utf-8?B?N0haZXd3L2ttVGZ5bGtKMlgwY09pZlNMak55RWwwa3h4WVVGLy9BWG4rL2RM?=
 =?utf-8?B?a1RUVm4yU2tRRG96MEhsc2ZkeTdiT3dIODdBOTNVZyt2TWozZmtKb3VzY3FK?=
 =?utf-8?B?YTRveCszNXV5MGVvSnZJVGlGMk5SdmxHM0lEQTZVU2x6VzIxcWRrdjhKL1dm?=
 =?utf-8?B?aUVoUTUyRDlIbkZlclJTR3d2YTRqOUZkeUtGU2ljdXN3TUJ1VUl4KzE3NFY5?=
 =?utf-8?B?WW9tTXhEb0tKMlE5cmpmMXVSeXZzNUdsR3JETHBacG5La2p0SFI2ZCtJWnRC?=
 =?utf-8?B?Wi9tQ3RqazBPdE9HWWd5WEorSzNxNm1XYmEwelY0aUswYjRmZDlwQjB4cG9k?=
 =?utf-8?B?VVFWTEQ3YXBsUXZoOFVrTGZiVHlFWGtvYUdLbytQSTduVHp0YVNlRjZBTGJj?=
 =?utf-8?B?N3lLVGx5T0NlNTU1dDBTQkpnMTZQcU1nTXErRVlHaTZsN00zMzhjcy9Fc013?=
 =?utf-8?B?bGN2VURRNWlLb0hIS08zaW1PUW5EOWpMWnBRclFrMHBIQjlSUGVVZHpMTUxl?=
 =?utf-8?B?QTdqMFdUa2JLaTVxUWNJWUZwTFdaMTI4bkVTZlRBdGljaDJINk5wZUx5d0dv?=
 =?utf-8?B?OEZjNGY4bVlDUU5ES3lKWnJZNCtlWEVaNUoxdm1WdkRoR1lIUTUrTnorbU5P?=
 =?utf-8?B?Vm9DdS9malBBcHpVb0o1eGljRDdlWWplWGttWnFvZ0s3VU52MjFGRWxoNlNX?=
 =?utf-8?B?ZHZ6ZkdMWnJoTEFhNUwwUGZqNlg3Mzk5ZTd4cGdwdnZEeTJQS1ZnQ2lMaGly?=
 =?utf-8?B?aDVhYzdGc04wQ1VyVXpFNjJET0FGMk5lZFZ2ZEFYT1N6WDBrcFJzREdubm53?=
 =?utf-8?B?bkQwUThheTVPVkwyczNpRDBWaVltaEt3WmhzVVlzeUNER1VWWUpGUlpia3Av?=
 =?utf-8?B?eGwxMExFSnpJOGV3VVlZSFoxVGc0Um1FUGZGMWFoV2RaK1hmd0NvU2xWNkIw?=
 =?utf-8?B?MlVWT1pWcEZFMDlWZkx6MlYxanJJVnlBeDJ5a2U5c0NjdXBST21jU3RZem15?=
 =?utf-8?B?WnpVUHdobzQ0TWx1QXZ2T2hBMVBVTTVCZmFvNzQzZlpHUk5OcmE4MCtjUXEy?=
 =?utf-8?B?UnJoenNHd3ZmM2hLdHhTOUZUMzA5KzBsVDNrckN5bXpNeVlsSzFHNEV4OE9W?=
 =?utf-8?B?WmkzM0U1QkJHVFJVbXc1QVRGeFBSeDBBRHR5L1NxbVpSTXpYdy85bGQzYXNn?=
 =?utf-8?B?bGxIU3d2NEhXOVVGWUFLS1BxamhUWklyZ2lRdHdjdU93TjIwZVZqdXBSTG5P?=
 =?utf-8?B?ZkhON3IyYVF3WWhvTDYzL29lOUFxK3BaTkFKRE1hdDk4Qmt2a0tJWG9Lb2Y4?=
 =?utf-8?B?QmRjVGduTTErcTNRR2pIbm93c2hrVnJHZTlQdTNFZXE3OGlnaVIzLzVLalUr?=
 =?utf-8?B?b3UwQXFueVVvaVFDdVBTOHdkRjE0RktIbjRIQkhLU1dTY3B6dmJ2RzliT1Bs?=
 =?utf-8?B?Q1AzSHJ0VnZHbU81a3NpNnMwRDYvWkpMUFBtdW5MOTlrNjdYRHR1RDNTZ2VY?=
 =?utf-8?B?WVFiemFkSGlVdEpINzVqRElpWm5GY3Uzdm80YW1FQXhDVjQzZDNWdUF1dnhs?=
 =?utf-8?B?QTcvUW5GR0FuSjArblk3YkNXQWtac0owNUt5QTBXa2F2L3Q1aEFROG5mUkgy?=
 =?utf-8?Q?q+gwJK0HKI68dgh95qhy3iE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NEs3YmM4SUVRMVlDOXk2VGY3RElnOG1wbGlRVU9OV1NFd0pFV0ViQzkwRFo2?=
 =?utf-8?B?TGlWTWpVNGs2anUyTDhtNlk5bEpZTVoxWG43MDJlRElMajJaekFmM0JQODJv?=
 =?utf-8?B?UWhMaDV0Q1ByMW0wUnVkZVhmYndPQ3Rlc24zSUtHUGFXVWNQdzV6dVYzZFpK?=
 =?utf-8?B?VGtnblNWZnhYektXZVlnWWROd3ZrMTV2S04rNlBIN24weU16ZkVSV21vanBr?=
 =?utf-8?B?OWtLVk1ZdXJheEs3MGRnMUJpOVJ2eGw3Rkh6TCtkWGZETTRkMmlYYVlpSnQw?=
 =?utf-8?B?aFJ1NVprelFEczREYTVsSGdxZ3Q0bUtNWVpQL2ZPbFRHUnBWNmRURGRKTEZ4?=
 =?utf-8?B?MVJRSWNtMzVWVGh0bVhndldsdHVpRHZad0p1VXpxL205OW9rNjJHeTl0VmxE?=
 =?utf-8?B?amlxcEVFWjkzdVliM2QrMWFQYnBudEM2UzhJbTdZNWNRY3VURUk1TFNoMVBh?=
 =?utf-8?B?V09tVEZzQmFYYVlFNVZrUERxTGFENlJpbVEyV0xzeWNSWUxwVWxLMVVYRlFz?=
 =?utf-8?B?SWlWQzNCbVVuZEdSSS9rOUNsdDU1UStVOUI4dDYzakxYSVVCYWRYdGExNFdQ?=
 =?utf-8?B?bHBRYXAzdisvbUkyNUZVWWtnUHZsaC9tNzQ5MWNUOG9ZZXdML3NGSXpDd3gw?=
 =?utf-8?B?d3dhb3pmVHJaa3Y1VVBnSFoxTUF0MElsVXg0YmYwaWFSUlYra3p2eDhiRXMw?=
 =?utf-8?B?eG1HaHhidFhPQnQ0MjZjMmFJWjdkUm5vM2FRNUZOOXkwOUoxajFsRDJoZ0Ns?=
 =?utf-8?B?SDRsbm5jdEJNc0taT29DVFlybTFla2gyeDkvMElkWEdSTWVzWmpPSnR3enQ4?=
 =?utf-8?B?QnQvK3pxM2VFZWlLdWZ0S1BaVFcvaFZBLzkwaS95MEpOQ3dNdkVRQ0NreUhX?=
 =?utf-8?B?Q3B1Q2NjU0owS1NIOEZ1d09WVkE2VjVZeTZBRkpNVlIxb09pKzNOZlNXbkRo?=
 =?utf-8?B?elRFQkNDQVZpalRSeG5pcm5YOGVxR1lUSjR5V0RkQmJHZHVOMDJOTXZYQjR0?=
 =?utf-8?B?ZzdiSFQ4bS84SStwdHBEYldkbnh6bk1zV25yS1hkdXFXRW5PWkJtM0E5cTFQ?=
 =?utf-8?B?SVZRRWxpNkVUbitjNHl2bmtoUzV5S2N4dDVKU1A1Mkh5dXpxQ3ZnVStkUWJk?=
 =?utf-8?B?SWJYcWZ2TWhwOXVoUkpBOGUxQXVlaFhsZDE4TlNmYW9mWklOaCsyeDdVOGVu?=
 =?utf-8?B?TTBxdVUveHlLdXVBSkFkeFloL2plZ05aZHVMVTdWeDJBZ0ZCQTRSTUExTTZy?=
 =?utf-8?B?SGIzVVV0L0dkY2I4L1kyMG9vMUFQa1lTK2tkMXlNTXE2RURiNzV3TUVXVHdJ?=
 =?utf-8?Q?ecthT0rrGKwuw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f462c1ff-02f2-4aa5-4230-08dafae929f1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 13:20:56.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+pw0zq85v34E60Bry8e3X8TsqlOPhqOCcQgzjJSyjVpc6Mchrju7MEP5hYUzoQEdyNJ+wb5pBA87dTvshlcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200126
X-Proofpoint-GUID: O3h0DA26HrfSp4AUcaIYWBcUR1puDoon
X-Proofpoint-ORIG-GUID: O3h0DA26HrfSp4AUcaIYWBcUR1puDoon
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 18/01/2023 18:15, Yonghong Song wrote:
> 
> 
> On 1/13/23 12:00 AM, Yonghong Song wrote:
>>
>>
>> On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
>>> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>>>
>>>>>>>> The function name in kernel may be changed by the compiler. For example,
>>>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>>>
>>>>>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>>>>>> should conside this case.
>>>>>>>>
>>>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>>>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>>>>>> retry.
>>>>>>>
>>>>>>> This might produce incorrect result, so this approach won't work
>>>>>>> for all .isra.0 cases. When a function name is changed from
>>>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>>>> uses the original function signature, the bpf program may
>>>>>>> produce unexpected result.
>>>>>>
>>>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>>>> by default and offer an option to users to enable it? Such as:
>>>>>>
>>>>>>       bpf_object_adapt_sym(struct bpf_object *obj)
>>>>>>
>>>>>> In my case, kernel function rename is common, and I have to
>>>>>> check all functions and do such adaptation before attaching
>>>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>>>
>>>>>> What's more, I haven't seen the arguments change so far, and
>>>>>> maybe it's not a common case?
>>>>>
>>>>> I don't have statistics, but it happens. In general, if you
>>>>> want to attach to a function like <foo>, but it has a variant
>>>>> <foo>.isra.<num>, you probably should check assembly code
>>>>> to ensure the parameter semantics not changed, and then
>>>>> you can attach to kprobe function <foo>.isra.<num>, which
>>>>> I assume current libbpf infrastructure should support it.
>>>>> After you investigate all these <foo>.isra.<num> functions
>>>>> and confirm their argument semantics won't change, you
>>>>> could use kprobe multi to do attachment.
>>>>>
>>>>
>>>> I crunched some numbers on this, and discovered out of ~1600
>>>> .isra/.constprop functions, 76 had a missing argument. The patch series
>>>> at [1] is a rough attempt to get pahole to spot these, and add
>>>> BTF entries for each, where the BTF representation reflects
>>>> reality by skipping optimized-out arguments. So for a function
>>>> like
>>>>
>>>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>>>                                 const struct in6_addr *gw_addr, u32 tbid,
>>>>                                 int flags, struct fib6_result *res);
>>>>
>>>> Examining the BTF representation using pahole from [1], we see
>>>>
>>>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>>>
>>>> Comparing to the definition, we see the last parameter is missing,
>>>> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
>>>> where the callers have a struct fib6_result on the stack and pass a pointer -
>>>> is reflected in late DWARF info which shows the argument is not actually
>>>> passed as a register, but can be expressed as an offset relative to the current
>>>> function stack (DW_OP_fbreg).
>>>>
>>>> This approach howvever introduces the problem that currently the kernel
>>>> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
>>>> that introduced optimized functions containing a  "." would have to be opt-in
>>>> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
>>>> without that change.
>>>>
>>>> An alternative approach would be to simply encode .isra functions
>>>> in BTF without the .isra suffix (i.e. using "function_name" not
>>>> "function_name.isra"), only doing the BTF encoding if no arguments were
>>>> optimized out - i.e. if the function signature matches expectations.
>>>> The 76 functions with optimized-out parameters could simply be skipped.
>>>> To me that feels like the simpler approach - it avoids issues
>>>> with function name BTF encoding, and with that sort of model a
>>>> loose-matching kallsyms approach - like that described here - could be used
>>>> for kprobes and fentry/fexit. It also fits with the DWARF representation -
>>>> the .isra suffixes are not present in DWARF representations of the function,
>>>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>>>> and not add the suffixes. What do you think?
>>>
>>> Sounds like a great idea to me.
>>> Addresses this issue in a clean way.
>>
>> Yes, the second approach seems a reasonable approach. If the number
>> of parameters for the *actual* functions equals to the number
>> of parameters for the defined function (abstract_origin),
>> we can roughly assume the actual function signature matches
>> the prototype. Although it is theoretically possible that
>> compiler might change parameter types, e.g., from a
>> struct pointer (struct foo *p) to a int value (p->field1).
>> But this should be extremely rare and we need compiler emitting
>> additional dwarf data (might through btf_decl_tag) to discover
>> such cases.
>

Thanks! I've prototyped a solution at [1].

The key problem is pahole processing compilation units separately;
the issue is that for some functions, they have optimized out
parameters in some compilation units but not others (NF_HOOK()
does this for example).  It's a pain, especially as we want to 
preserve parallel BTF encoding as much as possible, so the
best solution I could come up with was to save information on
functions that had a suffix match in a global encoder binary
tree.  Then, when we are collecting threads, they can be safely
added prior to BTF merging, since at that point we have
recorded if they have optimized-out parameters in any compilation
unit.  There may be a better way to handle this, but I think
we are stuck with comparing binary-wide to see if the
parameters are consistent.  The code is (I think) careful
to limit this to cases where "."-suffixed functions are found.

In testing this however, I think there is a wider issue with
BTF encoding of static functions which may require a similar global
comparison mechanism.  More below...
 
> I checked with some compiler guys at Meta. They confirmed that clang
> might have the same optimization (eliminating some function parameters
> for static functions), but clang won't change function linkage name.
> So that means, clang won't do static function cloning and it will
> only remove function parameters if this can be applied to all call sites.
> 

Great, that simplifies things a lot.

> I checked the clang (clang16) build kernel with latest bpf-next
> and didn't find a single instance that a static function's parameter
> is removed.
> 

Excellent!

> Also, current libbpf kprobe API supports to pass a function address
> to kernel. So user space can always do their own /proc/kallsyms search
> and find func address for either regular function or function
> with .isa.<num>/.constprop.<num> suffixes.

Right; one way I've done this is to have a special "okprobe" section
name where we support matching with a "." suffix as well as with
the exact name. Might be worth adding that support to libbpf itself
if the above approach lands.

The bigger concern I have is in testing this I hit a problem which
at first looked like a parallel BTF encoding problem, but on
deeper analysis looks like a conceptual issue in how we handle
static functions.

To demonstrate, generate vmlinux BTF twice, once with a single thread
and once with 2 threads.  We observe a different number of functions
that end up in BTF for the exact same object:

$ LLVM_OBJCOPY=objcopy pahole -J -j1 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
$ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
57596

$ LLVM_OBJCOPY=objcopy pahole -J -j2 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
$ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
57714

So we see 118 more functions in the latter case. Why would this differ? If we sort
and strip out duplicates, we see that the cause is multiple copies of functions:

$ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|awk '{print $3}'|sort|uniq|wc -l
57596

Once clue is that each encoder maintains a function table of ELF symbols, and 
marks a symbol as generated if it has been added to BTF.  As the encoder
traverses CUs, it adds to the encoder symbol table.  In a single-threaded encoding,
we will see only one instance of a function in the final BTF because the first
match of the binary seach of the function list will be returned.  With multiple
BTF encoders however - each with its own internal representation of the symbol
table - there will be multiple instances of functions added to each individual
encoder's BTF fragment.  This is supposed to be okay because BTF deduplication
will handle merging these.

However, this does not take into account the fact that the same function name
may live in different CUs as a static function with a different function signature.
Could this explain the extra functions?

It seems to account for many of them. To take an example tcp_in_window()
has two representations:

122435] FUNC_PROTO '(anon)' ret_type_id=122409 vlen=7
        'ct' type_id=65074
        'dir' type_id=2170
        'index' type_id=6
        'skb' type_id=2012
        'dataoff' type_id=6
        'tcph' type_id=61910
        'hook_state' type_id=29004
[122436] FUNC 'tcp_in_window' type_id=122435 linkage=static

[66683] FUNC_PROTO '(anon)' ret_type_id=372 vlen=4
        'seq' type_id=23
        'end_seq' type_id=23
        's_win' type_id=23
        'e_win' type_id=23
[66684] FUNC 'tcp_in_window' type_id=66683 linkage=static

...one from nf_conntrack_proto_tcp.c, the other from tcp_minisocks.c.

This raises the conceptual problem - what do we do with such cases?
From a code perspective, it's totally fine to have conflicting static
functions in different CUs, and one approach would be to retain multiple 
conflicting function signatures; however this is not really useful as
there is no mapping from BTF function signature to site.  As a result
we have no way of knowing which signature applies to which function site.
So perhaps the best approach is to eliminate such inconsistent static
function descriptions? The actual amount is small, ~100 functions.

Assuming that makes sense, the next question is how.  One approach
would be at BTF deduplication time, but we have seen cases in the
past where BTF did not fully deduplicate identical structures, and
in such cases, multiple copies of a function are present which
have multiple (but identical) parameter type descriptions. If this
happens, the danger in eliminating both is we might eliminate
critical kernel functions due to a type deduplication issue. One
way to avoid this would be a comparison of number of parameters
and (failing that) parameter names; such a comparison would not
be subject to issues with identical types leading to identical 
function definitions. Not 100% foolproof, but would work in
nearly all cases I suspect.

Another approach would be to re-use the mechanics introduced to
compare static functions to see if they have optimized-out
parameters to compare function signatures.  So static functions
paradoxically have to be stored in a global tree and compared
to weed out inconsistent duplicates.  Luckily, these comparisons
can be quite superficial; for the most part number of arguments
suffices.

What do you think is the best way forward to solve this problem?
The optimization-handling code gives us a way to deal with this
by postponing addition of such functions until we can guarantee
consistency, and I've roughly prototyped a patch on top of [1]
that works, but I think first we need to figure out what to do
with such inconsistent static functions before determining how we 
do it.  What do folks think?

Alan

[1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:btf-optimized
