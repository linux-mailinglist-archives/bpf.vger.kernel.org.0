Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEBE53ADF1
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiFAUrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiFAUrk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830226A097
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 13:43:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251ItwHD008404;
        Wed, 1 Jun 2022 12:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ykQuKKZF3XyNJnV6t2k6XpqEuNPksUTIECkWrEXq7WE=;
 b=omLKYzKoM/g+7F+fAzxcUOUaIurwdy9IJrVMyhE+gIXjvpdHr92QXRuAfa1joFJBWIkS
 EgQcOLmNaAp9ZZSt/N1w2QwavgqmoncQtyNP8SUHw3B7pG6+U7ntVaOtiVDfMA2drzbM
 j66gw0GXmkU8QRS2qUoQBwPet0McNI5EtzE= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge5vckhnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 12:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHlgV296VrNG9LuhBMp1MHjtCCJvXWicbQ/cup345QZR9jtlYHzoKIxkzwxteAD++0oSE+9kci6f8V/AjYVevQYqN8a2DNoDJyZv6DEqdVjQSkQDp2iEbeGAeEBjagypKb+aOeY8kfJC+yBkqVun5vx87clTM9l8sIPlwu0jmyNUO+1DSlxpfIFlkrOPP60RjpQnR3hQ7/JHhyJcop9txMJ+d6rlwBsHf4MgXkRrB2KnqybI6mrlbZ9rWAFcLBI0wi60OmnxLpXs5UhuvL5rx8WZAfVc5kAdgqHTJHa+RUqazTWKsr4TqO0DFxBh008OxqDCLJT1WDfTmFWz4voCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykQuKKZF3XyNJnV6t2k6XpqEuNPksUTIECkWrEXq7WE=;
 b=QvykLFbTu9PkmoIAT0HEwKGWNhyWsiQwS9Iqfgwac7Aq80xN+hVM/Mi8TwkJca2f5VtM9MEMryYjDfBrPfaqLBTVp9n1F/QlEeTlYasEo88g26xsfAwUMQakBpbkxSnWkAzxSH7KICse0W4v2I5Jgoa2HfV/2IFaKfGkcxqQPkd5NVGWM4+3YJkE6SgLM3366w7JCv6XAaBd37ues8hbsFBAMSlRx2ajWVsRjn/NCtyAquo4Vc0HFRzbfcMzhEp9xj7+6NK5tHR33xdrODDKNN1wsHVJvEaEu1h9v8EBqtwP2p2ci4HzSwWe0+tczuWh7ZN5LRFzdx4SqIIlqB8oiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2416.namprd15.prod.outlook.com (2603:10b6:805:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 19:09:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 19:09:39 +0000
Message-ID: <5e0c8ccf-26bf-2f82-a6f8-dba07ea99403@fb.com>
Date:   Wed, 1 Jun 2022 12:09:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH bpf-next v3 07/18] libbpf: Add enum64 support for btf_dump
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220526185432.2545879-1-yhs@fb.com>
 <20220526185509.2548233-1-yhs@fb.com>
 <CAEf4BzaJCisZuVWPtriqzZS3T=DehvNC1ouXiTJx=4msSmAoLw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaJCisZuVWPtriqzZS3T=DehvNC1ouXiTJx=4msSmAoLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d99965c-767b-4190-179d-08da440246fc
X-MS-TrafficTypeDiagnostic: SN6PR15MB2416:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2416BF45DE92F3F41A3F4FBAD3DF9@SN6PR15MB2416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKNHMEg0VGpxVmVDWiBt4MGMiyi+69iTq9oUflsS/2kaOZ5mEfWE3MzvejTX63BlOLOueKxqi0ACakXD2cMRIgBfs+K7yycQs4V9atbDi4H2prMkEFGbGBu2JSdYvm58BoJgcD8pOpSvpFmSLtUHXU6DMAie6RVVSVphVF8LGYg6GlsGuRSidODQvuFzW1hFfP73dNcS0bdnaGW31cOffKTQn1PkrkLahlzi9NX6vf7SR7pg5v6xIbL6mcM9yLa65d8Rz42rIb6rbbtcCPs+0DqSF8EFx90EMorL/q9eJqcsnBTEA26UPvXZSaKcP9K8uLiQV/ZP4cALkaJ3r20hLgXGdEtcta/DykqzuLN5U7P3NrLtf5Bf5i0yRBzRrTh/GpkAskQBuYFmXLDBFIkUUGX6XYhiTrhLkdh29mJcVoP2adijuzAHW12M29ZSOJ3Gc2e3i1eKAVOrxZKGUAGJcjuhVwKIJQfpvq2m8yVTp59O4OrUyMzF3NKHNw9qypw42gHbyTPSQAlYkB0rUZDrQtE78XHHGJ+HNls4tFGIbJA+ezhkpChyGmDp9GOH2HP2DbcpSfub0K4zD+w/UutTxj+JRO2FFD9ttFsnrweM5VQpv09+yAKxREnYKlsk8ssy+Y4Rprv+uEJakA8LqxwW2WG54IheoyCbWqzG5SR2X9XOhUr+FqxkNdpyg6nv3wVPyPvf5Ev/86Xzovpd2a7qexCyn9owr7ZNckbeUU/qYJ7VjD4xdYuLDJOzqgp0pc0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(4744005)(31696002)(8936002)(186003)(2906002)(508600001)(316002)(6486002)(2616005)(6916009)(83380400001)(86362001)(52116002)(6506007)(54906003)(31686004)(66556008)(8676002)(66476007)(66946007)(4326008)(6512007)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpoTnRkaUNtL0swVWIxN2pta0VVQkF2YXJKbmpkTGRhL3FSbVhZc1NnSVh4?=
 =?utf-8?B?a2NndnRCVHhjU1UyenFubEI2Ync3RHNELzRBN2hoUEhKUEs4MG5ONEdoaTFq?=
 =?utf-8?B?QzZ6eGxhNStDeW1obzdtNlBWZ05tdzRWRXZhcWdENUdneW5kcjZDclQvRWNo?=
 =?utf-8?B?WE9KSkVWMU9rSnZkeWVNS3J5WHp6SmpGMFoyZTVHUlFQNnZ6TnFKb1g2aklv?=
 =?utf-8?B?Yk10bG1HOU1OcEYwUkdkVTd2eXFLWGdFQzFmaVVtNFI0SE0rZFFHYUFkZjBP?=
 =?utf-8?B?QTRmaGIyUmViK2lSRDdPNjlxRllaQUtOTnlWeWM2c1pwemdQUnQ1b1p4azNH?=
 =?utf-8?B?Z3NyTmYyWW1EKytDU2Z2VWV5RjBNeUdvMGsvR09IejVOUFl6Y1E0ZGpwUVY4?=
 =?utf-8?B?bEp4QmdiWENsTDk0N25SMHdKSXVVdzd2R2JIYW5iQmFCSHNKOHpReXo3OWVR?=
 =?utf-8?B?NFBwWUNtL0RkYWtJcm9vY0wyeks5emRXUnBqS3RKNVdHNzJMRTRzRWNZNTcv?=
 =?utf-8?B?UG96eGZiNExHcVlDbXY3OHFCM01kR3QxLzZ3WXIzMmluMnA2bGdwVnVnWHZy?=
 =?utf-8?B?MHFHZG1tQWgxWFFZbkVSZFZ0RFpXZnlpeVFuaUF4a3FTVkhhYzIreDF1QUU1?=
 =?utf-8?B?ZnpET255bnp0YytmamJoWENSSENHd2xPZUdkZG00d2hHV0pMeGZhZEYzN21V?=
 =?utf-8?B?SjcweVNYNkNKZkllTUJkZlU2WndqeXI3SytxWlByL05sMW0zWXF0cGRpTFdE?=
 =?utf-8?B?OTk2dUp1N2x4amZtVzhpaEIvNEd1QnVaQ2RyVzMySGQwL01nSFVjaTVka2Vu?=
 =?utf-8?B?MFVsaHlTT3NOVHR1eWVxenljZWJtWGtnL3R1Q08rYTRNVUFuMW5YVWROMEpw?=
 =?utf-8?B?WEZwVzkvTTdlWU90ckJkOTd0NkZ3RGhSNlFoTjlQWTdzNGdiUUtDak1FcE5P?=
 =?utf-8?B?Z0NtM0V4S3ZJRStOSDZyVlZGd3R6Z20zWUxPRzdFWmJ3bFJQeUoyRnFHb29q?=
 =?utf-8?B?eWdIZWdKNFY4anRmd2tnSFhhSzhwcHZiMWNidi9pVE54aXYwaEdGUjNLQ2Np?=
 =?utf-8?B?ViswNWZrR0RzTTlxZW1QUldKdlNxZmFPaW9RK3RjSFRIUTFvYW0vYjA2VzNF?=
 =?utf-8?B?NE5wNzQycEl0amFLdG56ZVp5bTU4WXh3emY4SGNBNldZR1ZneUNsOWhLdVhm?=
 =?utf-8?B?U2JxL2MvYmhsSjdhL0ViRmxScnpacHhZcGk3cmgwNDlKV05Ea2JILzRtNm9Z?=
 =?utf-8?B?QmpFeElpMVBNYTh3bHB0dHErektaUHlGRTZHbnRRTEp0ekFGOHBXbjlGdUU2?=
 =?utf-8?B?U1h2UEpCalR1dVJRZkdVZUsyd09GZkVlV09mdEJsQ1Q5STNEMTllYWxjWE1x?=
 =?utf-8?B?bnFveGRaS0E3TE5ESnpjMjU0QlVkc2ZlcWpLYVJMWU9uMjBaMVZvUURKT0U1?=
 =?utf-8?B?SWVnWXdZV0t0aytjOGRiMjFXWjNLdm90ZlgwMW8rOC80NS9CYkNtSG9DMWZo?=
 =?utf-8?B?dUlDWlpzNEdyQ2ZWMkdpT0E5TENiRTZGQWtRNmV5Vld1RktBdGdCVG5EUmN1?=
 =?utf-8?B?M1ZFZ3FzdXRrVXRRL3Q3TTRIWDgzMXhtd1gwcW0vN1BFVkRqSjdGeUZ0N3Jt?=
 =?utf-8?B?Unc0K3hMcUF1LzlyQWF1T1pSU0E1TWhlWnFOdnFacExFZXZERUtEdWdjL3dS?=
 =?utf-8?B?Z1dweUZCS3k4NUN1OEhQWlNNbUppSWdzTEtHenFheW04YzFSSEsxR2JzdU5V?=
 =?utf-8?B?ZjFQNzkrSTRMRCs1L1pPYVVYM1Z0dFp4cHZveUJZYjAxWTNoMmExWkdGSXJP?=
 =?utf-8?B?L3RoYlJWMFRGdWZnVk9nZUVhZG9iK05RSUtrVWhzL1Z1Vy82M2pNZHpnZ2Mw?=
 =?utf-8?B?LzVKMktTNUhnSWd3WmNyYnVsVnExY01sYnVFWlRvb0I5eU0zN253V0NCT3RC?=
 =?utf-8?B?ZmtQTHhFTXVpN0svbXpJak5kcWV3cUhMNGlKMmNBazc4UUhra2lHakdteDNJ?=
 =?utf-8?B?bUVhRFFYQ2JTM2c4ZG41MU15Yzl2cXUzWldRalNCamFYU01kMTBGL2ZwZlRC?=
 =?utf-8?B?VXk1bjBWM2g4QnpYd05NTjhlZWRBZE0yVGgxMjFNNnNDSmdLZWU5VjIwUDMy?=
 =?utf-8?B?WkV5YUJPTDVNQ3R4UnA0TGtFUjJFdSszQUljNC91cWZJRTdodkJGYTJTQjNm?=
 =?utf-8?B?Q3BaR05XLzlaVFM0b1MrZHVmMGRqdjROaHVLUlhPQ21qL215dGQrM1pidm1N?=
 =?utf-8?B?WDllZHZadVdyckVtU3BObGlmOFpHcXVwYVB3ejdFR0xVWFpSclJaOHFLUFZL?=
 =?utf-8?B?cWNqcVV3MVpIUFppbXZDdGN6bnRNd3VUV010U0dnWkI4M1BLdVhIMkhoNHlr?=
 =?utf-8?Q?lNaAgaBa/iIVgg4o=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d99965c-767b-4190-179d-08da440246fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 19:09:39.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X3Gw4Bbxyxoc3NiQFieIwlgkyWnM6dzNZB2OSlHSvFM/6V8vBm+ykR15/c/Dato
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2416
X-Proofpoint-GUID: VKuLvWBTLoi_f9nMFQR-KWABhnrjIKCU
X-Proofpoint-ORIG-GUID: VKuLvWBTLoi_f9nMFQR-KWABhnrjIKCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/31/22 4:57 PM, Andrii Nakryiko wrote:
> On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add enum64 btf dumping support. For long long and unsigned long long
>> dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
>> in some cases.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.h      |   5 ++
>>   tools/lib/bpf/btf_dump.c | 128 ++++++++++++++++++++++++++++++---------
>>   2 files changed, 103 insertions(+), 30 deletions(-)
>>
> 
> I suspect we have bug in btf_dump_get_enum_value(), we unconditionally
> sign-extend values. It seems wrong. Can you please extend that part to
> take into account signed bit (kflag) and do a proper signed/unsigned
> casting? Thanks!

You are right. Will fix.

> 
> Other than that, it looks good!
