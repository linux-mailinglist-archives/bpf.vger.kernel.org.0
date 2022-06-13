Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B91549CB6
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiFMTDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbiFMTCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:02:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD3A207E
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:36:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25DFSdot017462;
        Mon, 13 Jun 2022 09:35:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WNtWSkov8I7+M5fAFTNloK38AbchTNYdxNZqX2xnT5g=;
 b=TF/NPoXs52uA5gZ92Andc79Sv5cd3mou2mw04kbgBLXGWBOF8Ic/M7e8kmnb/RnE6GuZ
 /gn5ZD7G2lzXMeNoA4PukzLtB5za73AGPaqxcDunb7je5NstYiI7T/wJHjgFfCoAa4HY
 kxp/k2ANrN5KC/gGf1oeXhaLEkd8ozIyBLo= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gmpqx1tm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 09:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0Zy/ZMv60/WycWS6ZWlr5bhzLGqyRIHJBqXudXBPgOOl2NVUvKzyyXtsFbjY/jDs+xeRxaBRmWd20gmP0fVIuzlgcJk3wN3HUgUACZxcClKFV85kon4KbfP6CfVFbYmIShXIfN1O3qDauwW2d99KWtlOCQQl3B6mOj+y3FWCNnHyNT7mchQrtamazxUy2a8JTo+FOxDhkG19WJWCbXyyMSTCb46tF3SMAqWsc+unIEnb3yIdTXu9hPUHzN06s+Z3DKJDmFXUhreFB6LaIBEFgAmPPOQa5itYoPRKhPbSraLm7hTOctYY3MGWDUbwq4vqInr6GJrk2VVVmdPhLYiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNtWSkov8I7+M5fAFTNloK38AbchTNYdxNZqX2xnT5g=;
 b=XSMqpn+70gxCFKWKh7TklLfbyBc7kIHpxhWox84zItGTZr+UBAfUo/g4trjBWLdTkJrwJHI7QJzIYBZSF6WC8beSZZU4LqTvzLPfJKq8aRPFmumjkQ1mL3I9hmrqfgDNadXjKfayB8b5pcZLJCCcX9jT+Y/KJyNLNR7NQvaMq2DAmSkIg+jL7g8O/wnLmlMAAqPa5nqAvfiqBs962K0Ur/kdwNwqKaIFlDQjsiDkaCP+sIgku+XVto1dEWrNrtCNyZsUABqEd6knzi8UQ/e4ZKr9bV9j2lhL8h1zEolnXm+W9QSwcQv121RACL+9OFSD57BawmKoQyai5GLDPB+18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3330.namprd15.prod.outlook.com (2603:10b6:408:a3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 16:35:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5332.017; Mon, 13 Jun 2022
 16:35:34 +0000
Message-ID: <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
Date:   Mon, 13 Jun 2022 09:35:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        joannelkoong@gmail.com, brouer@redhat.com
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
 <87r13s2a0j.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87r13s2a0j.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b51f66-b8bd-4112-4c5b-08da4d5abd13
X-MS-TrafficTypeDiagnostic: BN8PR15MB3330:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB33302BE516E93EA8F28E6A43D3AB9@BN8PR15MB3330.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhqZuoL++R8VlcdCMFT8LXXrdBmlQmI+Sd7dha8YBxyuAqW4/xoVQQoL5c0Ct4pGwWyBlU9CoqnjPzrrRBwHviGPkksPtsKN+daNu0bj4KX5lfprboKevnoD+oBSsaoHnb8zlDpCwx9tgB9L1vSfJ1M+wKkZ6sV8G1ALbDTMzY4+b8H/sbj3hvsILDNCxlrM2iwUsf7CEZIeBVT/1vEe/cQMkGIrESTnDqvcSZZognh0V/ivPaP47BxZZPwV26W14/6j8zlHKgPopbjTsdFtFFTQ3DpbR5tv+TuqjC4D84nmf+555lXCFITgZjn4ld65Gqb028U9OzUV+MYlDIgtH/HhzNbQ7NPmZlv1npKWzxcTPD4g4IId8Ij0M/r2iJ0ApAGROw7fIu5jPUco1rwtILh4mnMsvxRcTpmloW/jU9+rOMiL2ELiKFUON4XfFMii0YwQygHXf87N3LWbkxkt6ray4sVufON69G/mPo9oI59Bc+X4HMyhqgukGoENHvi0T8VLupk9lacC9zrY3Pao1G2CEeGnAnU373rZUT9zqYt3sC+ASuXCxI57EwL5KKl43kEtyPeJv1GMeOOozW9kq0Pl3OSJ8rYyjID699qaElATGCiya0wR5EcoO59MQA57e/DmTRJDtUOyjlIN+wazAocRXeYrbkYKNRhRPONPheRfqN/QHqYe8579QQNhbnnroAS05Ol9PINwsL3HANgy+Z/V0OnvSJIoU/UlkDqUdcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66556008)(66476007)(8676002)(4326008)(2906002)(66946007)(31686004)(6486002)(5660300002)(83380400001)(8936002)(508600001)(6512007)(6506007)(38100700002)(53546011)(31696002)(36756003)(86362001)(110136005)(2616005)(66574015)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RoekExZEQrN2RwbE5IeC9ZcDJncXBJejBkSnl2VEF0MnZ1cXVFbHlhaE5G?=
 =?utf-8?B?T3dlSWFhc3h1R1ZWbDFiWERsWUtlYS83NUlpVVpDeFdJOHBTMkwxdlM1Nm40?=
 =?utf-8?B?cmxvTlkzWERnWHNYamszSjl5V1JCd3B6akswMkhoNlNReUlKME1WWEt1bVMr?=
 =?utf-8?B?cG5pTjdiVzVKSUFiOXRJUmhUK1RiRFE1Mnc1TXY3UTN4b215QzBLaVg2NDg1?=
 =?utf-8?B?dTUrclA4U245WnJsRTNia0tPbHhTbnpJcHEyTTNWV2lYTlZIQXJiVmRFMldv?=
 =?utf-8?B?S3cwRW9SVnNlTVBPeE1oZFZkajcrcEYxVzN0QzRqUVpVZ0VnazdWZGxtc1Yz?=
 =?utf-8?B?VUNOV1dkQ3VYUEpLUHEyYUV0VCt1Tjl0U0hBdUdYY0lENGRxdDJ5VmhHMkM1?=
 =?utf-8?B?R0k4aG5VNGtsMVBOdjBnTVlDUCtrL3B6M2E4R3hnYi95dkwvMmJ1UjNDQmVU?=
 =?utf-8?B?Wis3UzdvUFdBWW9uZjMxVFZsd0tuN25zVlRyY21lT3VXM1pOem15ZVJtTnhp?=
 =?utf-8?B?dmluTytVM0N1V3J4LzJmTGpEMURBQjlDSTdGVkdDcDZ1NktOaFlwMXdhcE51?=
 =?utf-8?B?bjMzaytFVG5RcHhRbEhJQWJFN2JaQVh6SHQ5L25kanFwVGV2amJ5czJaNE5j?=
 =?utf-8?B?SkVnUjBlbkNySTVCR05JWTlWQ2YzWGhxS2hIUElVd3g0UE0rYW5KQTdGMWlU?=
 =?utf-8?B?SDR2VlRGeUJ5SFFVSS9WTzJaYjdVbk5sSFBkVkdTdmVjWW1oQ3ZEODM1Zm11?=
 =?utf-8?B?d2tqY3hXc3ArNlZFeXNEa2tWNm1YN3lXNWFRTzE3enlMWFpQYmRlQ3ljdXRJ?=
 =?utf-8?B?cHF1dk9lY2hSQklWRDAvaGdOUll3cFg3M1F6Q0RQVGR5Zzc2NGhYUWtSdWls?=
 =?utf-8?B?R2tURlk2R2E2bE42YThJU1VHMU5jTFhMYUZERmZGWkZXeE4vREpTbURud2t4?=
 =?utf-8?B?SDE0ci9TcVQ2aVVqdDVHT0VVd21aZ2I1T1ZTcnBZVWJ3cjQ4ZXc1UndtNWQ5?=
 =?utf-8?B?cnFqcm5xNk1FTUVybGRJakQ2VnV4VUtNV1dNWThIWkNidDdONk5sbjV6RGtN?=
 =?utf-8?B?bDF0VjIxRnFEcEF2c280QXo0UTFyNTN2L2JlU0R2akg4TkZmQmwxdkdGMFRJ?=
 =?utf-8?B?dHJPR2hpZTR2dk13NlYrTk13RVBJV3hnVHZSTW00dFpDWjJyWWFZSHZkbjRR?=
 =?utf-8?B?bENDeUc3RTFuV0htSjQwclI4RExrQUhpQnM4d25tZ2F2Tk5mbVJpK2xFbmYy?=
 =?utf-8?B?Qzh5NFE5czV5eWlmWExUc2NFUVZ0dnZhQm02SnJPNHhrLzJVYy9tdGl0K284?=
 =?utf-8?B?WlEwNUZBSkI5WTRBS0JxVm1DOEVYcjNacElBVGcxaCtBQnpoRStSd2JTYWN4?=
 =?utf-8?B?VXFOeTZXK3B6L1VVTVJIRSt4ZEJGaDBKY2Vvc2ZFZ3YxcURPY0RoOHBSQnFv?=
 =?utf-8?B?anc3V3VHVi9SMmJaWGNRZVM0QzFIcURSNzZ5TjV4UVBsSzhmTTVnQmJCUU1T?=
 =?utf-8?B?bnUyQWh2K2p3cWRpTnZWZUNyRlhsaGFTVGJVWHE3OUZrMFZrbVBJNGxLWlVi?=
 =?utf-8?B?eDA4aDhUN1A1OEpyUElqTTI5M3pjNjFqUEhxWWpONERoWWdRdWUxQjlaUzBN?=
 =?utf-8?B?SFZDWm1DOHpsd0JyVEswNEF1T096QXdtTHJCdytBemkxK0RWaUxXanF5dW50?=
 =?utf-8?B?TmFJMXl2MlZmOFkxd1c0a3lURnlaQ3dGTnVJNFF1eGRBVExEeWdtcW5kSWZz?=
 =?utf-8?B?MUdrM2JLN0k2em1oWVQ0d0dHQ0drSk5lcnBGdlVTbUdlSlJtUkFNZW8vVFlJ?=
 =?utf-8?B?L3Z5a3QzTUFjQjdOSUVxR09kU2lQa1Jmb1hTZWhmZG9PU1B6R1paRGlsVVE0?=
 =?utf-8?B?ZzFid1ovTzdaRTk5dkNlZDVIOXVzZ2FocXVyNXZ1K1pBMGJVZ0VodU1NTGlk?=
 =?utf-8?B?ZW9sZG8vaERQbU1XckpNemtBdVg4Yy96N3NIMXdNc3JhNjFKRmlibWYrTkVO?=
 =?utf-8?B?YmZFR3V2RndKMytLYUZ4L1BoeDFKelVBamFDUm5JTW5kQnJrckdVbzIxZFk4?=
 =?utf-8?B?MGJuQ05CNDdWaVlRN29ZeTVpM05xSDJjS05BeXhqWlRtenZpWGRTd1B3SmI5?=
 =?utf-8?B?ZmNjRGlyUzc4b1BQU295ejI3N3ZzKzVtaHBRZ2NjWTRESVRlSmdQYkxTZUVt?=
 =?utf-8?B?VFZaVUI4KzQxYW5SV0xLeXNWeVRsUVJMbmRVT3I4dldIRVJoVWxFNlNoUVBo?=
 =?utf-8?B?UDJGeEpwZ2wxbytrQnJrRysyd2R1a1ZleXlRVG4rQnVsRGliSVRnV1JCMGN0?=
 =?utf-8?B?d3JqRDdvWEV1WWpYNnFIKzBTY203Nk5FYnlETXU5cEJQOTFXN1VCWmVJS2pk?=
 =?utf-8?Q?rEHvIoFRCcDUeyw4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b51f66-b8bd-4112-4c5b-08da4d5abd13
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 16:35:34.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2VuMQk78ixYvLJxqJtC6TkLSp8I9GnXI8wqOSMY6uKuHlAcOfR5ximuOpB5B4Fq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3330
X-Proofpoint-GUID: OuMUbt8kepIRDpIRniXZHjK5Ms_MlSET
X-Proofpoint-ORIG-GUID: OuMUbt8kepIRDpIRniXZHjK5Ms_MlSET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_07,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/13/22 2:22 AM, Toke Høiland-Jørgensen wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com> writes:
> 
>> Below recursion is observed in a rare scenario where __schedule()
>> takes rq lock, at around same time task's affinity is being changed,
>> bpf function for tracing sched_switch calls migrate_enabled(),
>> checks for affinity change (cpus_ptr != cpus_mask) lands into
>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>> recursion bug.
> 
> So this only affects tracing programs that attach to tasks that can have
> their affinity changed? Or do we need to review migrate_enable() vs
> preempt_enable() for networking hooks as well?

I think that changing from migrate_disable() to preempt_disable()
won't work from RT kernel. In fact, the original preempt_disable() to
migrate_disable() is triggered by RT kernel discussion.

As you mentioned, this is a very special case. Not sure whether we have
a good way to fix it or not. Is it possible we can check whether rq lock
is held or not under condition cpus_ptr != cpus_mask? If it is,
migrate_disable() (or a variant of it) should return an error code
to indicate it won't work?

> 
> -Toke
> 
