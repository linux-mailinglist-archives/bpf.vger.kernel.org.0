Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF74EBA27
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 07:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiC3F2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 01:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiC3F14 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 01:27:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDADA1AF7F3
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 22:26:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22U0cV0f005114;
        Tue, 29 Mar 2022 22:25:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WmtjP0eJnX9Q8qOANx4r7xh5mijvvQxiH28wPoh47RA=;
 b=eW/AtKxAnca9Ud6KnhcVEwvswmj3Ho4IxH2lEXGDZ7HDG8Vwrmx7bSOr+rwnXRQSy6jG
 gEUrwRgZ8OlzMsueLMzasjerJ/xuM25wnORnyKEx0Ow+LOiFODoZUzl/WQHS5BdG7NWK
 EeFUMlnVlrF3yR6Ms0t//+CXV2LBL7WdCl8= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f3takg4fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 22:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0F5h0jpgjRxU5jpzz6LmjXCRayfT02S6ELHghGN4fsOKErvZRNdWTcg085v8RfyTpwp1AfF8Tt0Cp8frlguq9dtuPloNLRfNEh7O8R5xdZxCVuwuQy9Kqt5daYZMhE0cDIMyULx8Ntss3CM2ApfOfgLF3utquJUENHjHE29a3evcTDYPJ8foZSF41QEVNqbRTsqCbaek17GHRu89C5tUaLdN6E/g+O5YKOcIjYjTWuo+6usZ8St9IJwpr5TDvEL/QGtHXa3qiF4T1Yv7LmLQa/XlauIPGX7MGKUzpdOYRcdSh35uIhgOTczNVSjGOMBxEpvwL7bytLwFwBYHS9VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmtjP0eJnX9Q8qOANx4r7xh5mijvvQxiH28wPoh47RA=;
 b=DMWl8AklSnQNflStF+h2gWHDTKOvjQVOBOSeTf3pc30oRAZG2SjqIiTBMcCxwXJb8PtP8R+5izZPRB84EN1/0jmJZHDX+X+IvRZ4rmndxvHPcRqkesGtH+rmBLkq8z3XP5H1CsQHh3nDltbqUZuTwCSIpXBGXomyoKlBLPCgFtmMaTQx8eVGTLVDKbb93LCg6m7XY2Qx49OO1HnZ07JnJoWNIO32tP8jAgeFKP8Oo4QEuQ7vLteSdRd6R2TXYdcn1HlOr5DN3mYuqlYLVllXSkeWbn0Bvjs042KTZdb3lMpDVx0tDMc6N9RfjfWS/xb0CAnyaZH+9sFwaT5qDhIMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3528.namprd15.prod.outlook.com (2603:10b6:610:6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Wed, 30 Mar
 2022 05:25:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5123.016; Wed, 30 Mar 2022
 05:25:50 +0000
Message-ID: <3938092b-c835-a562-3b4e-5732db65d800@fb.com>
Date:   Tue, 29 Mar 2022 22:25:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf 1/2] bpf: Resolve to prog->aux->dst_prog->type only
 for BPF_PROG_TYPE_EXT
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220330011456.2984509-1-kafai@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220330011456.2984509-1-kafai@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3831f037-70bb-465e-78aa-08da120dc0d2
X-MS-TrafficTypeDiagnostic: CH2PR15MB3528:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB3528751BBA2DF4069B52EE34D31F9@CH2PR15MB3528.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vxEC3n8Cn0Z25yOKxkRZYPYZqKD1H4jK92M7/DkY2RUgK25kwGQTT9Gq61lNww7gjRK6IAfxMOMiGOM9Ln/0NRNcVdoapQRSTRKRaRz4f2ECEKOsYqfzWA5NvT/bIn+N4J5Gvu3NJ04CPM6woV0+zgN5LzcG2Xl0145PPsrUc38jfHtf9Ma9eKXgLjzW9zk+0IMskYOG3Fmsf7+RbwzDebK9yCTyM626CQleRfQ7kyM7Q/OwxBUt4r8aKvw+TkNV7mqNAeJHSY35FyzI6NT2+aGxHZm/R/zrIEDj/icN7NjQ+htItZGy0gQrgWmjNi0yaqbE1SHXLkpo6oZAQ9s7r2WthmCZpvnEWTwSmGhBW5o/WJiJIikvcef0A7ETBhbnSmGY7e7y7TSo+SPM4PSJkwYJ+A2J4Tb8Llh0ikJxTBZ4O7iUqaLE4v6febUJbI9gP9/dwcVSJgKNzMBClsr893uRPbP5hvAY33SqK4M9KHM+gFGxFYnTJw9pQFmigVz//FURcVUdQ1ZB/Y4YFI22L/zKN555e+df+rPANGHGqr/G4kURBenB8WTTaRKvfdlv7D1OfLLZue2Qr2v5toBicl7ceMlEREI8SDZEA5VWetiV2byCIrqBF6f+MoMHmp2MTvzHOOvtBup6fr8vJgoih5sbzPiPKGJogeHuysAOM7uqra4xZcknd6kpCkNpHFoun23TJlV6xXxFp/qThOqHsrDncOzpuKlCRukl0pjBk1ZVP72ZGXq2UdWjaXatUol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(316002)(4326008)(508600001)(66556008)(8676002)(66476007)(66946007)(53546011)(52116002)(186003)(31686004)(6506007)(5660300002)(36756003)(6512007)(83380400001)(2616005)(2906002)(38100700002)(86362001)(54906003)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlV0YnlGSTdMOHJtVWNENXhuQ3NGMXk0RVE2TWVSZHRRUDVhK0FVU3NKYjFt?=
 =?utf-8?B?WDNrUmZyNFlHdmdmMGZoWnY4QVVSRHJuSUhwL2tnNysxZEhweVI0enh6Uitz?=
 =?utf-8?B?aEl1TlMvdnNBZ092WG1iVzNON2Z2dmZrWGgyckkyeUkzcVRNVDVJczNTOVND?=
 =?utf-8?B?clUzQWhHZDA1UWVreWRBL3ZUZ0hQREE4UFgwdFFRQ3MzNG84ODREY0RaenNp?=
 =?utf-8?B?R3kzYmFPbnRPSlZ5bG5WeWhKNk5lT0t5VnlPR3pBRDhTNEpib1oxM3BobDlS?=
 =?utf-8?B?NWV0SHJtbzV2Z1laaGpPRmRNZ0lORTg4VlV5NSt6SzFPc01sbWVlVXBaeDZO?=
 =?utf-8?B?T1lBUU00VVdiNUtWdmM0ekUvREFQMUIvMmptSTQzMEYzb3FncDd6dVkxMExi?=
 =?utf-8?B?Q1JGMDBydlhBL0p1L2J0SVJyTkttMnVPc0FCa29VdUJsbVA1K2k0Y2FIRDFL?=
 =?utf-8?B?RGJzK1h5ejdqeWl5WE5xbjBJNXg2SEtWWWlnRVRIbExtVjR4dkUyMnRPdHBs?=
 =?utf-8?B?bHpEU2VBR3p0L1lXdVpDLzJrME85S0ZCeVJ2Wko2Qm5pTjN5YjZLQitrM1lx?=
 =?utf-8?B?SlgxeHdGSENRRnN0U0c3dnNncExlYXpOSFhrOTM5YjRJc29BZVNyNW8rellz?=
 =?utf-8?B?Q1VTa1BTTm00N3JhVHlld0tOdE5RNFVjNlVrOGhudUxabmF6WDhGRlk3cWVn?=
 =?utf-8?B?Z1ZwUVFrMk9ISlgwVXJjZ2xYWjRhdjZndEk5clJSek1Yd2VoVWFYdFBrb3R1?=
 =?utf-8?B?ODZPRVRaYlYvSmVqRFVTRnRpeGtaSDVsVGJTYVFydllESnFlKzVPcVdlTGh4?=
 =?utf-8?B?SC9aUEkwaXYvcjZlMEg3Y083dHdSVUF1WDgvZmxOYXB2dXhzSS9BTFhYd1Ro?=
 =?utf-8?B?TE5DYm1VQXVEamRSVkhtY1puaG43Ymh3blpFalBSc0Z5bmovRG81SmdHUlAx?=
 =?utf-8?B?WEgySENTSVVNbzBYY1RsVmVNNnJpdEhmdmhFN01pcnl3bTZCTlpJTnBoaitW?=
 =?utf-8?B?RWxwaDNwOFlTeXkrSk1GSVJTTjBSRUpUeVhKZkZleGlnWU0rQVBoUk9VSllV?=
 =?utf-8?B?ZXlIY2l4eXBDYW4rT0ZhZnhPUyt5MUdERjRtc1gzWWE0d1ZWa0hqTkY5Y2NK?=
 =?utf-8?B?eCtIZmVaSlp0aFlhODlLUWx5RmwzNlI0Q1NsaTNCTnlUSEdUdFl5Z2RhUjU4?=
 =?utf-8?B?REhuNTF6ZFFoQXBBM0pYN3pSZnhRMnBnTm83dytMV3c0UCtLS0MxT0hTRy82?=
 =?utf-8?B?bk10dW5uKzY0MXBQV1ByNjF5SE9NUVM5cGtrNUVCWkN2aEVNNjMvRTVDOE4z?=
 =?utf-8?B?NkptNFZuVUc2dURWVHFxMEdxVzl6VXRmcHhVcDUrVzlxcUh2Njk0UFk2NVQ5?=
 =?utf-8?B?blVvSWVxN0NJMHJFMndkUnRybkJ5UVZBemo2K0t5UDhlM2hLaXBCbFg3UFhK?=
 =?utf-8?B?Q3RueDIvN1FtRTZ4UWRMREhpOFl0MjFCN1hzSG8zY3h4TjVmMmt4Wkd1Rjdj?=
 =?utf-8?B?Qlh5U1hQNUdkdWxjZnVzeWwwQ1J3MXl3UGpJYW1sR3FuUHY4ek1WY01WZHlz?=
 =?utf-8?B?UWdCSC9GaEI4MldpTXFESTRTUEN1Z2dwL2hOSFQ4U2F0b3NpMElZeHV4T3M1?=
 =?utf-8?B?ZEZmVXk1Zjl6dk5od216b2Q4bUJVUjNOR2p0dzFiU0kyaGJkczg5UzZWdFM3?=
 =?utf-8?B?QWVJdHcxK1pFbnBxYlZ1a20rTkF3SXZOYmpINXB3ZlV6UDIrMHRDYng1SFV6?=
 =?utf-8?B?NWhFcm14b1lHcVE1KzM4NUdZTHZzemtCN0wyVGwxa0hQbGJkYWtJa1FBd2hL?=
 =?utf-8?B?bXBOYUdmV21MUWJXUnJWQktNZlI3ZVZHTE9UcVNjaFp2ZzRqc0hhSTNsanFP?=
 =?utf-8?B?QUpieE5HNlE4WkxManhBMTdPNXNCZmxJUEo4dHR4WXdzMVJja2ltcE52cm1X?=
 =?utf-8?B?dncwNS96K3pVVjZJemprQXJFWE9ycGUvT1hMaEVPQ0FrT2QvZ2JoaGxEejBL?=
 =?utf-8?B?enMyWElONWR1bGRnM1lXUXVsa3VrME9JdmxiLzZ2SUgxSjRtNll0S1BncWh5?=
 =?utf-8?B?THRhUWFkV1JGWW1LYytyN2xJcGs0SkN0TFloY1NleWk5U0tsd2xLRnR3Z05M?=
 =?utf-8?B?R1NPczJlVFAzQzBYNThKeU1IVHd1djdKT0xrT3BoOThsRHRiZ2pNRTkyaTRh?=
 =?utf-8?B?RlBPSDZyRVh1NlF6MDdPcjdoOG5LR0dEQ01adUkzUVNwZnd1UlZoUUZKYjR2?=
 =?utf-8?B?VVVlWTRadHJUUGs4alFVM3N3RzdBRWhIbUthRGNSOHFENW4yUEdySGFHM2NR?=
 =?utf-8?B?YUtwVjBkZXE1UW4zdlQxZ2pRNmc0RURTNEVESkY1V002M3BuR3hYTnVwNHpG?=
 =?utf-8?Q?0eC1gapbnyfGQ6gQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3831f037-70bb-465e-78aa-08da120dc0d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 05:25:50.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 940u2xuJUDyLU0Y4TCGgkt8ZORmr9+PWyUUui2uCADtUbglKIKPGQvrX+GrZw9HS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3528
X-Proofpoint-GUID: Wrs_zeBgk1S2lTNM3UNh0FYNwei2t4n5
X-Proofpoint-ORIG-GUID: Wrs_zeBgk1S2lTNM3UNh0FYNwei2t4n5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_10,2022-03-29_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/29/22 6:14 PM, Martin KaFai Lau wrote:
> The commit 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")
> fixes the verifier checking for BPF_PROG_TYPE_EXT (extension)
> prog such that the verifier looks for things based
> on the target prog type that it is extending instead of
> the BPF_PROG_TYPE_EXT itself.
> 
> The current resolve_prog_type() returns the target prog type.
> It checks for nullness on prog->aux->dst_prog.  However,
> when loading a BPF_PROG_TYPE_TRACING prog and it is tracing another
> bpf prog instead of a kernel function, prog->aux->dst_prog is not
> NULL also.  In this case, the verifier should still verify as the
> BPF_PROG_TYPE_TRACING type instead of the traced prog type in
> prog->aux->dst_prog->type.
> 
> An oops has been reported when tracing a struct_ops prog.  A NULL
> dereference happened in check_return_code() when accessing the
> prog->aux->attach_func_proto->type and prog->aux->attach_func_proto
> is NULL here because the traced struct_ops prog has the "unreliable" set.
> 
> This patch is to change the resolve_prog_type() to only
> return the target prog type if the prog being verified is
> BPF_PROG_TYPE_EXT.
> 
> Fixes: 7e40781cc8b7 ("bpf: verifier: Use target program's type for access verifications")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
