Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0254F0D3E
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 02:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbiDDAZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 20:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiDDAZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 20:25:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FDBAB
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 17:23:35 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 233MqRA2013236;
        Sun, 3 Apr 2022 17:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=G6u4JIfe+y/laUYqjJ5RM1d5mPQ2e+8kvZvacB83KuE=;
 b=MFITZMmpq9hDMeuyg0hgQY5+t/IZt14OyNChu5fcXkXMtqguwhajL7Dt/qX5HW7oilGQ
 AiVB2HnNsIV8ggMZLNyIqilkY27Lw+fN4TaDah5CjgBZ+++PQIGmqQ5bKJ/zdesnTsyM
 bdobKwIXoNMaTKG8IAXYlr2hM4y/omQy7H4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6m0wem4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 17:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXjOQUu62NLNI/RHRj56J9SgEUi1aebkRV6ACgQgLblY2MJeFQAi96YbTUJORyekG92MeYciVeiKYxg8f7dJ1pueFy8S/Ml0Rd7IDfUv51WerWB8vzzwbZ90FZUAjK8xrQy2DxXJwhM+Xms6ZkcEDyBUtL2oLmChhAAwp3BJ5e5UWmMUnAL9/qjqj3mLK4x4JB8eNwD5yHIDRvvWInpOh4QCmZU+EiV6namaQFPaIRLtppUvopooz1cYMnx3KZny0SISpqGQbArNQ6NtUF/61aVI5jGkK33s+F584ReiCl9Zp1akyrYI6oPRVFpNqoLhj8C87WsDlB46kldqNU6BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6u4JIfe+y/laUYqjJ5RM1d5mPQ2e+8kvZvacB83KuE=;
 b=QOKEHDb2r255pLF+ot0B3n6REPWT9VV4LtrbXxYzk6lu5bKssixF+eAJ5jksflQ5zL7L3+rGTBE3lkgid+zOACpZoquyLvR6KvgmvJIWrIZTsojVnZh1IbLR/SLGQsD5XSBPaBj+G5ZEsN/LTGikzgzztLolfCWiUVdxvdmjzMUyg72y4+4O11psiykVdOZ6ZjzlxUTq3mF5QPJZJaNlw+BfgODkGUf+/um1mSvV80Nx1hKkkb7eUSEocFt5rsm1pwBat5bUqTexK8i5ARgp+/8yD/F8hKgwqcIbP+++cXC21AHZogMPynVGEqm4RbmFMU0n64zVk5WfFz+Qn/h2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BYAPR15MB2469.namprd15.prod.outlook.com (2603:10b6:a02:88::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 00:23:12 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 00:23:12 +0000
Message-ID: <375b41da-6f7c-1520-9cad-13e12301575f@fb.com>
Date:   Sun, 3 Apr 2022 20:23:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 1/7] libbpf: add BPF-side of USDT support
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-2-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 214059b7-a4cf-4ae0-4ee8-08da15d14d88
X-MS-TrafficTypeDiagnostic: BYAPR15MB2469:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB246912F78019209CA4D16ADFA0E59@BYAPR15MB2469.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlH0ywFEWooIHdftr2VMyLS9ewux+rR7Ol+o9rWv9uIfq1E9jYcf0yqVrRuWKdy1+6SV/X+DCQSb7GgKcCW2aJ0LOzRPF1ih80WvBld0lZKHGf9pdZLihhYNVTvjGuNlvbh5d7+j9rzwDpFu9potGezs/iSlzwkHWYfFOpARXVtk11VUjoe78RgtUxd+ZJjHeuT/I/q773hfnVtIaXkzKIoGdHe+hV3W3y+Tj5Vi6S8D4KJAnJ5awPF4s9M9YjbYWAF8XZUcXgtdesmmYk8tl3EnABnd+SyBk5CbUNQKW7bnDiV+pNxOmaNwJ/lWFMBYPIZ5nblWPxPq6+LOkc5HSn6jx/43LWtGsEsl4tXenylv+7MRq9pNZnkX8AK8FcaWzFOG/tlvCDtyYmS98lbRGQbUVcwqbVyLe4i5a6k4JX2oOdfQ5KcUt2PY8tY2qERJvfX1wEvWa1yL6dGoOeeE/hOBdRCvsVgsU9Fak1rVJFZLj+6qDBTUa8Su5OKASPhDFPjviCdhbH4BRLQBU6O06GLfkqahjMx3eqdwNqpOBKWCFfDjc11qYuHJ+Pwuidk7/j2Tv13+Ys3EMOlTxo5Vscst9Q8tmbXJ8zP4ktNjqI7gQ99JWGwdS60pMfjpOCwI++3o0+GLfl+VHjNxsr4auXFthlJWyIL5mzdWht6QT4q8yX3igBeDvwtpaSRUCjoo4IdKVuUju6+KAiRngyAlM4Xob9Zu1OtCQjG8KLLX1B7hPxUqlFX6REh55DydMwzTUnEtUyXMem9W1/p+Ywhlxhh4qWmqo3sEx+KXqb+9as1/ehj+RYaDPLFjBCsDNuLe+HaJsbVe+0yrOoE3Wh1/fv5sN3a1o2qOgtFtPAPwnU1BNVLbcnZpH5OmrPQrTHhY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2906002)(966005)(6486002)(83380400001)(54906003)(38100700002)(5660300002)(8936002)(316002)(36756003)(2616005)(31686004)(66556008)(66946007)(66476007)(4326008)(6666004)(8676002)(30864003)(6512007)(6506007)(86362001)(186003)(53546011)(508600001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2kzNDlkMWtFYWFuSzcvclB5bGFCZ0dBbFZPeVEyVjBRdVNzRUVhOVZIQWc2?=
 =?utf-8?B?alc0MytYN21CZ3ZzVWdNbWg3dW9uMHdHay9hZGp4R1Z5bE5QdVN0Z2dqc3pG?=
 =?utf-8?B?K2thVlJRQXNFMkdVcktES3diRUZPTWdZT1ZpNlNJM3k0Mms4Szh3ZkhCS3FD?=
 =?utf-8?B?dzQ0NG9CZE1FRU9mSUxOM29lNlJYdHBlNXUzcDJ3VkcvaC9GYWpPQ2xSMzFM?=
 =?utf-8?B?SGZRcWprVUNRMG5jZkpBTHZyd3FQaFJGS0hVaVhBN3hIb09jSjlCSUxPMWZn?=
 =?utf-8?B?T25XYk5aM1owcTNURnJRSEdoOWRBbVlWeGw4cmdSMS9wVEt5VVQ5bUswc2JK?=
 =?utf-8?B?eHBMTDQ5TTQzU3Z3V0xQSnY4Y2xhZ1llK1NKMytkWmtwSDArbCtON2FkZkoz?=
 =?utf-8?B?c2ZqUXU2OFhpZWptUmoreVVWbDhFd09NUjNFd0oyR29qWmZJYmhoRUpqTERt?=
 =?utf-8?B?a1BoVzk4bXBnQ3BBOEdmbVJTVXl4OEczcDQrWFVCN1hFT09hQTZWcnAyS0tu?=
 =?utf-8?B?bExDejhKaUpUaUkrWVJyaVgvYUYwdjIxdnpORGt5Q1ZTYnJMdTVjY0oyd080?=
 =?utf-8?B?Wms5dmdVRjVkajJNRS85dE45WVVxdi9wVFpFR2lTL0xEeFFPWFVSYytQdXdq?=
 =?utf-8?B?Q3pZc1I4c3lJczRnVkhGNHIxdUhqeHRiY0dQMnBOemxTdXU0QzAzMTRRMWtr?=
 =?utf-8?B?a2U3Lzg4aS9vR3ExVHR1ZzdKbGFUNGtZSWI3cmxxRTlwbzB4TTgxZHl1b2ZB?=
 =?utf-8?B?dGxBdmVEVzI3VVZEalJRV3kxcGd1Zm1GU1dCeGU5NjVnVkdySnNxQ0pUVE9Z?=
 =?utf-8?B?ZjZmNEFmZSs5Z1F0c25MdW1lSU0zallJeGcvZ1hRYms3ZS9salhwbWxJaFJw?=
 =?utf-8?B?OXNNYjFOZFB0ZkVuYUhFc1RjUlpldURQZlorazNzSWRUSks2VE80eGJqWEtp?=
 =?utf-8?B?UmYyb2Z4ZWdwUG5SSE94dHlGSkFpTklSR2ZPV3VqZ1RWbW13VzZzL0pyMm5p?=
 =?utf-8?B?eElJeVdWTllaOGdTdXA1UENrbmRSOTdURjZvR01IUENkVDdCZnFwK2N5VU9y?=
 =?utf-8?B?VlNkZ1RlMnZUOS8vZWFMdTRlR0FUa1JmWWdnZ2FVejBQOXdYcVFKeEFld1Bm?=
 =?utf-8?B?M0R0clM3akVjN01JREJZdmtDWnZSZC9EMHhpNHlwaHRMTXhNTjgvTXo2YkpW?=
 =?utf-8?B?dldoeVA3WWFEM2MyQlZWNWFjMTA4QnlscUlGbENtRHpQaEJoL3cxOGdtQllj?=
 =?utf-8?B?NG54akNpT2VsQXVBOEdXVkZqUUtNamVQbTdHZWIyY1hBVS9sdStWTTd2SUM0?=
 =?utf-8?B?Y09oU0JSSVhnV1gwbDBTS3IvWmQ5aVVUSEM2R1BsU3V1QUxuRjdCRUV4WmxU?=
 =?utf-8?B?QVJETkw5cStjcjQxUDl6MlJnWWxrdmREQnd2V2x0S1VVZy9CeUtXaTFNeFFm?=
 =?utf-8?B?SG01N3dyckFpZkJQcS9pdHFteEdKN1FwcXdJamZqSWtFdzdhbUt2VWMxYlJt?=
 =?utf-8?B?YXlLTlh5SzJXUm9BbjJkbWdUQmJhRDBxNGhaWThpWE9HZWlNeHFlOFV0ZzZJ?=
 =?utf-8?B?RnY2MWlTb3k0dCs3c3hFZlEvZDRYeG1CWEVBRnNBWjgrbURvL3B6UVZPbTdP?=
 =?utf-8?B?YW4rTUdVZFFpVWxEemdScjJYd1BYQjliVUlmUlMvaFpFYmx6VXdhVmRmVUFP?=
 =?utf-8?B?d08ralNVd2NHOFNSbG10WWthK1dpUVoyRUgwNThlS0NpZmltY2dvTHgxSUZC?=
 =?utf-8?B?dDZacUt4OGd6c29jQlRzS1k4Snd0SkhtQ0VQWGozSml3WkVpQktuaHhMcFBt?=
 =?utf-8?B?bXBtUmNIc1NxQzYvbGVNczlPUlJ4SUR1aEZwUSt6RGkydkR6SGE4am4wSm1q?=
 =?utf-8?B?OHJkU1QrWmZXTHc0SmhlUis5aW82KzNRbXVSL3ZOSW5SdW12eFhHVkRPWnhn?=
 =?utf-8?B?RkNseEl6UVMvTnhoa09TTUw4TWpNQWVOcUcyZHpaTGdDeWZab2o5eUsxMHE4?=
 =?utf-8?B?TjFEWVN2L1ZCcjl3ZDFIRFNGZSt2SXZKeWlvMm11Zlh6UkVwYktnYytNRmhJ?=
 =?utf-8?B?M282UXJ3cE5TeE41S2k0SUFpY3V3OVhmSEVocjQ3Q2ptR1N2aTMzcFpaZVpz?=
 =?utf-8?B?Q2RlVUlVOXJENk13c1RwcFl1dUh2QU9ka3NYaWpzWEpVNzdYQ09UcnFvVTZ1?=
 =?utf-8?B?WlZ0YjJ1WGNVTlVqZ3lrNTRpZjNxMEthZUJjTzRWNUF4WTBPeTlLaWMzekFx?=
 =?utf-8?B?dXR1N3JTakUyMU5uWE1rSWdORTZmWVAvMmgyWlVybHpLRTJ5RHY4Q2RZem5h?=
 =?utf-8?B?bnN5R0JaWUlwVnhKbm1WM0pCQ09WVEpFNCtYaWtsc2hIZWE2WWV3clZERXZV?=
 =?utf-8?Q?LoKU+j9bG/M8AWGLQjyfBqRQCYAlpWIosZADP?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214059b7-a4cf-4ae0-4ee8-08da15d14d88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 00:23:12.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/Mck3lkf1X5vV8T8pYXHavaaFDMGFJbkQMGWY+sMbF9pio0Yv4QRPojYnqOoFGbUxHdlp8Y19HiUImqcMI2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2469
X-Proofpoint-ORIG-GUID: 2UJZHRJUbtK9fYYKO1Dhs9pL0MVRK4xj
X-Proofpoint-GUID: 2UJZHRJUbtK9fYYKO1Dhs9pL0MVRK4xj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-03_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Add BPF-side implementation of libbpf-provided USDT support. This
> consists of single header library, usdt.bpf.h, which is meant to be used
> from user's BPF-side source code. This header is added to the list of
> installed libbpf header, along bpf_helpers.h and others.
> 
> BPF-side implementation consists of two BPF maps:
>   - spec map, which contains "a USDT spec" which encodes information
>     necessary to be able to fetch USDT arguments and other information
>     (argument count, user-provided cookie value, etc) at runtime;
>   - IP-to-spec-ID map, which is only used on kernels that don't support
>     BPF cookie feature. It allows to lookup spec ID based on the place
>     in user application that triggers USDT program.
> 
> These maps have default sizes, 256 and 1024, which are chosen
> conservatively to not waste a lot of space, but handling a lot of common
> cases. But there could be cases when user application needs to either
> trace a lot of different USDTs, or USDTs are heavily inlined and their
> arguments are located in a lot of differing locations. For such cases it
> might be necessary to size those maps up, which libbpf allows to do by
> overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
> 
> It is an important aspect to keep in mind. Single USDT (user-space
> equivalent of kernel tracepoint) can have multiple USDT "call sites".
> That is, single logical USDT is triggered from multiple places in user
> application. This can happen due to function inlining. Each such inlined
> instance of USDT invocation can have its own unique USDT argument
> specification (instructions about the location of the value of each of
> USDT arguments). So while USDT looks very similar to usual uprobe or
> kernel tracepoint, under the hood it's actually a collection of uprobes,
> each potentially needing different spec to know how to fetch arguments.
> 
> User-visible API consists of three helper functions:
>   - bpf_usdt_arg_cnt(), which returns number of arguments of current USDT;
>   - bpf_usdt_arg(), which reads value of specified USDT argument (by
>     it's zero-indexed position) and returns it as 64-bit value;
>   - bpf_usdt_cookie(), which functions like BPF cookie for USDT
>     programs; this is necessary as libbpf doesn't allow specifying actual
>     BPF cookie and utilizes it internally for USDT support implementation.
> 
> Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
> BPF program. On kernels that don't support BPF cookie it is used to
> fetch absolute IP address of the underlying uprobe.
> 
> usdt.bpf.h also provides BPF_USDT() macro, which functions like
> BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
> get access to USDT arguments, if USDT definition is static and known to
> the user. It is expected that majority of use cases won't have to use
> bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will cover
> all their needs.
> 
> Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
> detect kernel support for BPF cookie. If BPF CO-RE dependency is
> undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
> either a boolean constant (or equivalently zero and non-zero), or even
> point it to its own .rodata variable that can be specified from user's
> application user-space code. It is important that
> BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value (thus
> .rodata and not just .data), as otherwise BPF code will still contain
> bpf_get_attach_cookie() BPF helper call and will fail validation at
> runtime, if not dead-code eliminated.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Makefile   |   2 +-
>  tools/lib/bpf/usdt.bpf.h | 256 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/usdt.bpf.h

[...]

> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> new file mode 100644
> index 000000000000..0941c915d58d
> --- /dev/null
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -0,0 +1,256 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#ifndef __USDT_BPF_H__
> +#define __USDT_BPF_H__
> +
> +#include <linux/errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +/* Below types and maps are internal implementation details of libbpf's USDT
> + * support and are subjects to change. Also, usdt_xxx() API helpers should be
> + * considered an unstable API as well and might be adjusted based on user
> + * feedback from using libbpf's USDT support in production.
> + */
> +
> +/* User can override BPF_USDT_MAX_SPEC_CNT to change default size of internal
> + * map that keeps track of USDT argument specifications. This might be
> + * necessary if there are a lot of USDT attachments.
> + */
> +#ifndef BPF_USDT_MAX_SPEC_CNT
> +#define BPF_USDT_MAX_SPEC_CNT 256
> +#endif
> +/* User can override BPF_USDT_MAX_IP_CNT to change default size of internal
> + * map that keeps track of IP (memory address) mapping to USDT argument
> + * specification.
> + * Note, if kernel supports BPF cookies, this map is not used and could be
> + * resized all the way to 1 to save a bit of memory.
> + */
> +#ifndef BPF_USDT_MAX_IP_CNT
> +#define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
> +#endif
> +/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> + * the only dependency on CO-RE, so if it's undesirable, user can override
> + * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> + */
> +#ifndef BPF_USDT_HAS_BPF_COOKIE
> +#define BPF_USDT_HAS_BPF_COOKIE \
> +	bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> +#endif
> +
> +enum __bpf_usdt_arg_type {
> +	BPF_USDT_ARG_CONST,
> +	BPF_USDT_ARG_REG,
> +	BPF_USDT_ARG_REG_DEREF,
> +};
> +
> +struct __bpf_usdt_arg_spec {
> +	/* u64 scalar interpreted depending on arg_type, see below */
> +	__u64 val_off;
> +	/* arg location case, see bpf_udst_arg() for details */
> +	enum __bpf_usdt_arg_type arg_type;
> +	/* offset of referenced register within struct pt_regs */
> +	short reg_off;

Although USDT args are almost always passed via regs in pt_regs, other regs are
occasionally used. In BCC repo this has come up a few times recently ([0][1]).
Notably, in [1] we found a USDT in libpthread using a 'xmm' register on a recent
Fedora, so it's not just obscure libs' probe targets.

Of course, there's currently no way to fetch 'xmm' registers from BPF programs.
Alexei and I had a braindump session where he concluded that it would be useful
to have some arch-specific helper to pull non-pt_regs regs and a concise repro.
Am poking at this, hope to have something in next week or two.

Anyways, if this lib didn't assume that USDT arg regs were always some reg_off
into pt_regs it would be easier to extend in the near future. This could be
simply reserving negative reg_off values to signal some arch-specific non
pt_regs register, or a more explicit enum to signal.

  [0]: https://github.com/iovisor/bcc/issues/3875
  [1]: https://github.com/iovisor/bcc/pull/3880

> +	/* whether arg should be interpreted as signed value */
> +	bool arg_signed;
> +	/* number of bits that need to be cleared and, optionally,
> +	 * sign-extended to cast arguments that are 1, 2, or 4 bytes
> +	 * long into final 8-byte u64/s64 value returned to user
> +	 */
> +	char arg_bitshift;

Could this field instead be 'arg_sz' holding size of arg in bytes? Could derive
bitshift from size where it's needed in this patch, and future potential uses of
size would already have it on hand. Folks writing new arch-specific parsing logic
like your "libbpf: add x86-specific USDT arg spec parsing logic" patch wouldn't
need to derive bitshift from size or care about what size is used for.

I don't feel strongly about this, just noticed that, aside from this field and
reg_off, it's very easy to conceptually map this struct's fields 1:1 to what
USDT arg looks like without any knowledge of this lib's inner workings.

> +};

[...]

> +static inline __noinline
> +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> +{
> +	struct __bpf_usdt_spec *spec;
> +	struct __bpf_usdt_arg_spec *arg_spec;
> +	unsigned long val;
> +	int err, spec_id;
> +
> +	*res = 0;
> +
> +	spec_id = __bpf_usdt_spec_id(ctx);
> +	if (spec_id < 0)
> +		return -ESRCH;
> +
> +	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +	if (!spec)
> +		return -ESRCH;
> +
> +	if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
> +		return -ENOENT;
> +
> +	arg_spec = &spec->args[arg_num];
> +	switch (arg_spec->arg_type) {
> +	case BPF_USDT_ARG_CONST:
> +		/* Arg is just a constant ("-4@$-9" in USDT arg spec).
> +		 * value is recorded in arg_spec->val_off directly.
> +		 */
> +		val = arg_spec->val_off;
> +		break;
> +	case BPF_USDT_ARG_REG:
> +		/* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
> +		 * so we read the contents of that register directly from
> +		 * struct pt_regs. To keep things simple user-space parts
> +		 * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
> +		 */
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		break;
> +	case BPF_USDT_ARG_REG_DEREF:
> +		/* Arg is in memory addressed by register, plus some offset
> +		 * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
> +		 * identified lik with BPF_USDT_ARG_REG case, and the offset
> +		 * is in arg_spec->val_off. We first fetch register contents
> +		 * from pt_regs, then do another user-space probe read to
> +		 * fetch argument value itself.
> +		 */
> +		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +		if (err)
> +			return err;
> +		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> +		if (err)
> +			return err;
> +		break;

Assuming either of previous reg_off suggestions are taken, very straightforward
to extend this for non-pt_regs regs.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* cast arg from 1, 2, or 4 bytes to final 8 byte size clearing
> +	 * necessary upper arg_bitshift bits, with sign extension if argument
> +	 * is signed
> +	 */
> +	val <<= arg_spec->arg_bitshift;
> +	if (arg_spec->arg_signed)
> +		val = ((long)val) >> arg_spec->arg_bitshift;
> +	else
> +		val = val >> arg_spec->arg_bitshift;
> +	*res = val;
> +	return 0;
> +}

[...]
