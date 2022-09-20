Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E05BD8A2
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITAEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiITAD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 20:03:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749E5244E
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 17:03:56 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsmnl004873;
        Mon, 19 Sep 2022 17:03:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QmZfIZIJRtGkNehABcgbC4p0VlbybC3vHMQPClKYLRU=;
 b=TfIFn0ybpVBsOtFH1bVgR6on4EU924kudnyt7NbpCbvySzaoODR6W1OxzZuDUmpnrPfj
 jz9Mvp9iEff86d5Qv1Rd+5GYAs1FZ4dphOtJwDQoH3E/zjIVWXD7KnY0pUztXajxeSjY
 S0Z+F6yexpdJ6eFGqTlK+iCo5QN5J/sH1TU= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpyt7h57t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 17:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQAVRsCIN/Ko7mITfIm2Tbug+qEmu/HuhaHxdylcAvH1b3qUQiWoUwUDcIdHsOinGLIjEs+fGvarudq2ZBuyJOSfbpd6YoVJ2ISjosowPKgNGRGtzugSZexkD6EzKM0M0fc2T3+Fu8jTHam8IHnOQ7bQfkzbrz04n+buTqMbvRSJPtWdUvyhBhwaiSYZaVoB+8stkRi5zEisinop+eHbOSU6ya7INL9dzH49eojTbXHIAE9GfGF905n1sLmBUFaAUXTe2n9/Y+rQ2rm1XSUuArh2B1R7eotzFvudcp4cqQ4orFz3XmSmoR+N6rMVANAl6jl8WDwOlppcjKWFFM8XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmZfIZIJRtGkNehABcgbC4p0VlbybC3vHMQPClKYLRU=;
 b=KL4Y81xRiUQROKc6AMeAYVosrB7w69ezSzS3PF9WkDgS4KgAMkUndYuL4r0/0PW1QnjrVoERuCnoQTNSMtCW4bvUd3BE0eVgPu+8BOlNbnsaLNzKNeEmQk0yrg4ABHyoQoQGchOcM2FPS+cqLgYiVO2au4bVsnTyWbkIzHru0ukdIm6e7NQMYK3lXWVgkr1ndtFrg9I6pBasTYJI47vJYPFnsuNgieVX9e5iiHVZyL25jtK85RFlfyc27QuQhfhGwPJtmbVXFYObe5jyWKMXL63vP67xRxi4Y2DboS9DDIx0NpjmflCn3bvGoZMaOaBsHz3+x/s4rHY4nzBBq9Lz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5300.namprd15.prod.outlook.com (2603:10b6:806:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 00:03:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 00:03:38 +0000
Message-ID: <475cecc3-aa5e-6c74-d119-99c27122b923@fb.com>
Date:   Mon, 19 Sep 2022 17:03:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next v2 8/8] bpftool: Add llvm feature to "bpftool
 version"
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
 <20220911201451.12368-9-quentin@isovalent.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220911201451.12368-9-quentin@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dad58c0-353d-477c-c9ab-08da9a9b920c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g4BGWiG+/TomZpUEPzrvg70e2H71FSgxeGl6Tn+zaMn6dfzIxZDj4hDk0tSufWBwn1Wb71gSCaE7kdpEUldB3HkNMCu7czSfPLU0ztybM+YrsDvahB1RhsdVLdaTORa1U5PsYvrKlglbtbeGotTLXuL+mNiJnll9rzIgoOLqBwHPawNVCSgT52leQXi5cjh8wq30dgvJQoRv3SdJzrq7qCgSP12+6S/5YzOr728GJ0JtsxNxdziRftGmgUe+ESG1pE/XsNf+0DKVllzeD0JxFGQVNJBTLOMk0OU+pZErrtxtFWw//2+WiIyUwEIgaWt8na1K3j9wJoe08hRa/TaO62QlGLvGPJ5ScHXuRtuxSTCrj7omFrh6SUb1spgNT6ult+NaIsg+TQ3NDwiWCtqpZEheX4VVrAsi39O0JoNLIxA4OLg85jaaAMOSy4uCw5w9aTkmGCelqTuIzqF1wjnEppvJR5igZukgP3StoXuACPBnoJfGmj929aaVJciOX2ifKyNRDS90RqhLfWf55VSxlRGqwmRBznuz9bnjIc0sb105zgSvatrmZ82UZFUXdx/NhRCgj01lXCwyADuUEpXA0Gt0+d6tKbRdfIUy91tQ86oMJZ4VHSSrfZB2MLczllFjXatzednriT8yHoOCdz710pZf32yasq9F/tZ9ojc8f2DSmCUtZV9zFVdfNNCR6w6zN8J4eS+wlE3IpGBo7cMzCA2iUTQKyW8i+0PaFOl4vnxWgc45rWm65M6HiiqER5nya08IvXnFzQ3nMBUN6P4hER/LCHSPXtJzWuPIZplc8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6666004)(38100700002)(5660300002)(110136005)(36756003)(8676002)(54906003)(6506007)(7416002)(86362001)(8936002)(66556008)(2616005)(66476007)(31696002)(6486002)(186003)(316002)(2906002)(6512007)(4744005)(41300700001)(53546011)(4326008)(31686004)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmxCVVl3allFNnp2ZkU2L1JoWjJKZVlaRkd0N1RLdzhiYmV0R1doa2dDY2wv?=
 =?utf-8?B?ZlZMVHNMRXN2R0p2YW4vd21VK0Y0SGtRbTEwVHBuaVNLTEZ2MkxBeHI5dlpL?=
 =?utf-8?B?QitKcnMzMm81RUtSMHI4ZWVyR05KU3hJcm5YYUZiTDJiS1dBQ2VLVTBjVXJi?=
 =?utf-8?B?bnh5VXNlR3lsQ0Q1emVNV2E5RCtGQ2dnamJoMUYrYnduNkZsYU8xbWdpaUlK?=
 =?utf-8?B?Y1NOUGJ2ZVlWSmtQMXlFcUFMZktYUjl4ZGpMQ2NIayt6dFRMRDBCUldFWFdr?=
 =?utf-8?B?S1Z4THpyREFYNG9VQ0hvOFpRMEZpZVVjY0x0N21rL05Vc0RreHFQNGl3VXlR?=
 =?utf-8?B?eHl0VVhoZ09UYjRackpra2hUYWZ1UFpXTklxOWhvYzRPRWRuZXU2R1o3d1hB?=
 =?utf-8?B?Y2JWOU1tY0RHMU9GbHJDK3RVYXgyYXVmZWlzaWFSRS96V2V5dmNLeHNzeHlO?=
 =?utf-8?B?L21ZVXQvbkVhem0xajcxdzRYaG5wVUx2V3ZRd1BSTWFhRFRKbkUxcUE5TSta?=
 =?utf-8?B?STdvUXAxNlRWZnd5VUdJSkNDNC9nNkp4MW41N3ZtRDZLVVJQTDlTTFQxOTN6?=
 =?utf-8?B?dzUwSkdMMXpzREk3RHRJTGcvV1UzdkF6RE9lc29jdG5sRUQyTFhSMlY1UHVJ?=
 =?utf-8?B?UDZ0ZHNCQTBtOVRDbkp6R3NPeExhU3hGTWlVbEtOcldHeWtHMWcvVUJ4dzVv?=
 =?utf-8?B?QTFudGY3NXMrcjJWdWVNbE1OY3lDNlRkY3NnOGZ1VEZRSE1XaHA0UjNkUWI5?=
 =?utf-8?B?b0d1U0tOVVJCT1MzMUNCOUJDckxMWk9FaVJObDlteHcwaytiTFhwcDdJWVpx?=
 =?utf-8?B?Z2hMODVmYXBmdnFCNCtSSVpOSlZLcmNPWjFUOUZvWHc1Q3R3aDBEMndlejJJ?=
 =?utf-8?B?SkhwRm5FeFQ3cFJvclZMQ3N2WisrTUNzK1pwWUVIdXg1QWRQc3g3ZnRKT3Nx?=
 =?utf-8?B?Q2drWUdKY1lVUllTN3BtelNGNHNESU5qKzRHaTg0ak10QnJ4elJDbWdiZ09Q?=
 =?utf-8?B?a05vL0ZxdWREQXlLT05DVnp4b1ZKMFNxYzJkMEZ2czRuSzE3V0FDcUlYTDYw?=
 =?utf-8?B?UFBKYVRvejhkbUlMdW1iRk5oMDFpcEVRMkErV1JJQlZGUnYxMWtFR05KbFdC?=
 =?utf-8?B?S0NLYWxjQkZYSG8wTXNyVmVUa2luU2hTc3dqRkIyTHF1UTNwdWpqR2k1SmZJ?=
 =?utf-8?B?b1NJOGZoSjBEeEkweEl6ZTI3MytLMDlNV2hBbG5QWGZDME4wMWVMQThTVmxN?=
 =?utf-8?B?MmVIN0NBQ0RnR0dKUmF1U2lTRjJSYTg4c1BnNnhQbVhERE9iMXpQbEVKWlNF?=
 =?utf-8?B?S1YrN1hoUWk5Ymh3U0V0MWFYd0t0anl2cnFqZTdmVjFQQnFRSkw2L25xT242?=
 =?utf-8?B?MHdvSEpablVLYVFBeEdwb3d0a24xb2oraGREQWl6UkI4TDNCeWttZWlkLzJo?=
 =?utf-8?B?SmVRTW8rQk5zMDN2M3AyZnVlSDhtUFZBb0JtUXVzTURJRkdjVUNOeGdtWEh1?=
 =?utf-8?B?YWl5alFHVE1KVUNnWFltbUljWHNId2o2OXVaTm1rWUsrMVhwTmU5OE5vZ0tU?=
 =?utf-8?B?bWFtMWZibVNrdXNkVkljK003NEkxMVUxQXlrMUI0UFBGZGVHOWJCcEhUTzBz?=
 =?utf-8?B?emNyQW5XWnpTSzZHOHdBQWd2dXY1QnRrc3Nrc3NNeitBaHdjbUlUUmxPQlZX?=
 =?utf-8?B?RHEwdkE0eGVKVkRlOXVKRFV5WTZBY2Rld3pqbkxTaFRQRGFtczVMNHB0eEht?=
 =?utf-8?B?bld1UzUydUE4WE9FcVp1UzZRZWRPY2JqRFZxRTdzeGhVK1pMSk1HL0FDY3E4?=
 =?utf-8?B?MEwzcVdYSFVIYXduT0g1N2x4NUVJOUVpSjhidGpPT3haY0p1c004dSttT2RJ?=
 =?utf-8?B?UTgvY09hNWljQ0g5Q3dnKy8wL2tweHE0b3hsdXBHWXR3eTB3ejFJT3JiSWFJ?=
 =?utf-8?B?YUNkL29IMmhOODhvTjRjY0J6dnl2dTNJMFdRVmxTRnlIVENBcTI3NE5LL0to?=
 =?utf-8?B?eURFUEF1d1JNL0NlUkdFOW0yWm1mZE5iaGdabXQ5bzkwZndoRzBCSXpBZTZ1?=
 =?utf-8?B?SUhEY2RmV3ZtT2RHejBhWUdGRDBWY25BTmdGZDdxeXJLdjlJdFRVSGc1NzVW?=
 =?utf-8?Q?xnZbbBNNewBdKHGZSgf15VQv2?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dad58c0-353d-477c-c9ab-08da9a9b920c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 00:03:38.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DumQGXyv6KmtrVtI/SvyYab3dKeaSlim/c9by5sJZnXv9d65H6cI89fej0Gxekar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5300
X-Proofpoint-ORIG-GUID: vH698i8sXw0Bzm4hkSUnzEZChqecNAMp
X-Proofpoint-GUID: vH698i8sXw0Bzm4hkSUnzEZChqecNAMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/22 1:14 PM, Quentin Monnet wrote:
> Similarly to "libbfd", add a "llvm" feature to the output of command
> "bpftool version" to indicate that LLVM is used for disassembling JIT-ed
> programs. This feature is mutually exclusive with "libbfd".
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>

Acked-by: Yonghong Song <yhs@fb.com>
