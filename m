Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B464E661
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 04:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLPDfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 22:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLPDfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 22:35:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A14379C8
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 19:35:19 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2J0qJ003331;
        Thu, 15 Dec 2022 19:35:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZHuC8Irpj/MFH0syYATgBvOTQ6wvAIPbKoMWVQn+ogY=;
 b=bx7fFxajJZWNTDnXBpLSV+wifgLGsXWO39mf29AGRXWykLl//hpdBUbsUNSpErRHJrrP
 UCUV15hn8WiOgnuKqqGGtH5bF0IGCf6NmXFM/jnXxXax5urSIA632ksY8HdwdUn9yjmL
 7CQaqziwIDG/lktrqeN7Pugv4BWoNyIWzJmRVfEP8XvUZ0WmnevxlUf1iW2Yu1iD3De7
 sDDZvRcdbeMSqLAG1ROh6jPZzJXBK+eg5SDsIWJ1wkzqyDW1JyfsKvuA/OfyHZ0HB4xV
 1+gAq1B7l0ij49u1ZXh6Hc8nxmPKo6qLLExlWoIISPFCArZngvlMvHU18rIWKKYGoI2B RQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg8rkbtsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 19:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guwQXN4DsOj3zlvI7ksGB6O8qaoqdX+POyrJI9BI9KUsmGI6cc4tlF91QQP5LI/yoQNIo6pPaib/LTvaEHQPePvcSYCYuq8VTq8QCxctQLKTmg+gBEFS4oiL4+Ce993R5Do3ZyejJ7G0NeHdLLkPnf7v252xaqZMjDjXvtPpdQv2p77j02tq/pP/cKLxV+uV3buvY9zXRhg7RTZPnyVtK9R0xztyfptxS2ULLgHA/IRceQk86SMTI/TEmXYTx2SXlSSMmUliz0UIJrWTKvMSwxkbr+J1XPV/cvxXKWIHp8ZOhVJHBSbnoZFF6wCvt14R70VTagf0Bd+FcvZOqk+TYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHuC8Irpj/MFH0syYATgBvOTQ6wvAIPbKoMWVQn+ogY=;
 b=fybOADn44rLObVmx1fHSH6iVq4q4J6SVNYnegfAdkn59Uv/pweXoETZp93Tn8pAMRXRugS8tNyfPeeQig7/QPsfRC1NiiXfl5wDJoWnmWz3eiwo0uq0CAL5vBIGZsPCVB4b2jn7Cy8Dllr3694BU5hzf6kYpt3NeIyt9wwbIvZHS39ilCIzKXoEQNL25/hMFihLULrKRv2158BH4kBGowRw4LtLgJzIYrDNo6stsq0rr2cyhKDSrM6rQC51ACkMzM0/7Br+NUy3tGU7OrRTz1+/qlsZ+IjVXaDWC+3vjUPn69UX0dChfdjO7P01/EtVxHHHFfn053R15PH04eefnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4805.namprd15.prod.outlook.com (2603:10b6:806:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 16 Dec
 2022 03:35:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 03:35:02 +0000
Message-ID: <e2daa940-ec64-6b72-c8e9-b3157162af5b@meta.com>
Date:   Thu, 15 Dec 2022 19:34:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add verifier test exercising
 jit PROBE_MEM logic
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20221213182726.325137-1-davemarchevsky@fb.com>
 <20221213182726.325137-2-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221213182726.325137-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6226e2fb-8399-49d1-6e6e-08dadf16840a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMfBiuQMY/V+5xmVoC1Gj9ENUw3pU3txfn9RoISToSN+Rm7mkupTwKE29TAcn2m582vu/+e2XfsmHLwlP9BGLO1XlkYFEyLUnMSqbIedRMZxfBSLt9KZSI+iigUSs3S3mR1ab9/eYB0TQnGjfuFm3zN8DXKFXJT2695yLUxiJmZSG8mD14LV0Vmqm5pXBoH1lKimd3q//kugMxcHMqUydwOvwdNfqD5dlZ5bQQs2CYgzH7A8tNSJHSFFmu1fKk6VnEPt5Q+ccIp0KjaBFOuXAr2eguhZlqoFizqxm/jHP2PNykmk4snFUkWlTUNQIakFrOiVKamPqxi5AR7F5yOV/BnXy8m041P67xzlgix/Aj1iPFMevz5PlQ8vS3bYXGqWidcsnx97039Wpk3AVwPsHriMsx3w42nMHcTat66oiBi3XC8MjieACQwfYfYgqRi6/tARw4umOtkSTGkQC5IIEE2iQGgjENRNzunrrsPPcrO4fKDQ7bqmP7voD+b7UMjMJgp85wAOpgAbagWvWgMx69KXyXhQ7PgExWBwnWMK5/OLytL9XeTPMejAP4z9Vt8mt+1KWOAZDd+hzbWDy+WQwRTtYDuwFj1DFQ7siAriKF/1hpAxx6/jV6nDjb9tX/6T7n/hgP3jyWyJr3sbHqaBeH2TqZPp5VBiXn73XX0P+VhiOZ0ieHHcuF3XACTbpf+R2J8JUT51+5ISnwoIXVY46MxBnl75E7W/s9ys5lA8gJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(4326008)(31686004)(6512007)(53546011)(38100700002)(66946007)(41300700001)(83380400001)(186003)(478600001)(316002)(8936002)(54906003)(66476007)(8676002)(6506007)(66556008)(6486002)(31696002)(86362001)(6666004)(2906002)(5660300002)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZwYVJKNk9tcElaL0xLVmZTdTBpWHVqMW9rRFZaVXo3bDlyYmkrTVZSZVBp?=
 =?utf-8?B?TWUyWXRwMXMvT2VxcGFIbkd4V3lvcm9EMUtydVQyWEx2ZStnNURyblA2cVJJ?=
 =?utf-8?B?MEpMQnM2dGNYWk5CQ04yc3NBRVB2UDluTVVIeFIzYnpDdE9LMyswbjBMZ05W?=
 =?utf-8?B?K3RYZjJiNklSSFBXdFl1MU9qY2hEU0JPOStPNWE1aEhoUWFkdXJzSVBQQjYw?=
 =?utf-8?B?bExUdHkrUTUyM1orSW5WdU42b29MMmRyQ2o0bVEwMzFOc2JDaEJwTG5jQ29s?=
 =?utf-8?B?K2M1bTdYc29kSjFFOHZLcml0QU9FMEVjaUQwR211Y3dZbXpabEt2MTBjdUdz?=
 =?utf-8?B?QmRoNWEwV0xaSmN0cTAxZzhwVVVhMDFKQ0taTW1BTExid1V2QWtHNk04THRG?=
 =?utf-8?B?aE5IS054VVA1a2IwWWpjUGhBYU0ycjRkQnkwM25sMUVaZm85L0UzRHNKRHRh?=
 =?utf-8?B?OEVjQi9zenB6a21sVHU4TGJFd2F6NDBqQTlrazZkTExGazJTM0E2ZWROL2tN?=
 =?utf-8?B?QU9PQy9TMDRob3d6dTNWSUpVT2V0UUNhK2VDT1JHYlc2VSt0Q0U1VEFBcjIz?=
 =?utf-8?B?WjNOQ1UwZTNtMi9obExqUXdnYkVnajBYTVJHcTdyM0lWcmE2Rjg5NXJ4WE1W?=
 =?utf-8?B?UENMaWpzbXBPdWVOZFlqYVoyRVpSVkRMYXR0cnhxRmltcGNHTUFEY3Y5Y01E?=
 =?utf-8?B?aHR3bzJadmNGeGNrUnc0aFJ1bHNSU3pKTUd3ODFlaW9oa29IcEpVWjNvd2Zw?=
 =?utf-8?B?bHl2SURKOG92M2t0dFFiZ3FoVitCK1FiQ2JXRlc4SDNuL3ZteDRVSkVmdUZ3?=
 =?utf-8?B?WC84TnNLTHI5MU05cXp3YTcybE5MaDBWZ3pzeVpoZlR3YldHbWwxcTFYQ0Z2?=
 =?utf-8?B?aXlSTW95bzlXMTQ5SHU0SW5Pa21DQUluUjlLK04vUStNdTZqRkdtZFNlS0xj?=
 =?utf-8?B?Wjczc0tqMWUvbXVrdjRvSFk2VWZKMTJFaGtVUWdlK0JxNTFRUnVtamdMNnlQ?=
 =?utf-8?B?SFR6Tm5CS2ZhMkJBbC9LbWhncVVFSEtjRThEdEZ3U3JIWDhjS0M3UnQ0Wnhi?=
 =?utf-8?B?aDZJdWhHVG1JZElicjJONVhuc1p4YVhpb25qMlVzS1BibmZ6M1ZWbm51Wlg1?=
 =?utf-8?B?bmhFUWdsMElUTmFRSXVHaGdKbmg1NjAvd281QVdMYWJDcWxnYXlOa3dVRlVJ?=
 =?utf-8?B?Vms5UzhIdHE0SkRyMkxqS2xvcXpKTzBPTWxvSlhhTldkdWNzMzVSWUNNZ2tl?=
 =?utf-8?B?R1E5ZXVIRUR5dFo5eHdGUUdnOGdFOTdFQm96clFuY1hMSVVYYlcrVVQ5ell1?=
 =?utf-8?B?YWlUbHJqdzcrc29IWnBES0JCTmpXOC93dFMxbVdMeWtUdklhZmZ3ZkYyVW9Z?=
 =?utf-8?B?cC9YNUYrbVZBTHpvcUtaY2lNODhTYTJJQW5mQTdNQ0thMVlwaVpiMG04WWIw?=
 =?utf-8?B?NTJMV3VCQ2xsc0gwRnExYm9FandNNnV2ZGEwOEQra21yVWs2VkVsZ1pPR1dp?=
 =?utf-8?B?dWtyMnJLVG4zdE5EVnZxNmozVlVJcmJHaEJwandZb0YyRC9GOW9jLy81QzdZ?=
 =?utf-8?B?eExjSVRuSEtGUFNHWm1PS3ZadnhMV21MMjlKL3dJRDU4dFI2TVJaYi9TdnZk?=
 =?utf-8?B?L3ZWams1YU5EVmRXdGFablc2UXVBZCtYMnNLRXZyRG5GOUNFQ1k2MkVVOXpy?=
 =?utf-8?B?MmlaTHpiWTNrNXFWd3YwZTBRU3dTYmZwOFBmeHNGRER3TFExUmxueXFTbXdw?=
 =?utf-8?B?Y1ptQlI0M2RuWUorQjZCVys1bjdSSTVHck9ONmhjb24rMWNvcFhSUzRkZVl2?=
 =?utf-8?B?V2luMVBIOHN5Y2tZK3RPWXJqWjBlbFJtV1FabFBLN0lSNlJybk5LZEFSMkV3?=
 =?utf-8?B?Nlc5MFVtYlhBdDJENW44c29FaEh3TTdCU0tLMC9lQ29jS0hLSmNRT1hXbzhL?=
 =?utf-8?B?c0g0ZXp1aGwrTTgray9ob2R6WnBTbXpPVndzaDNpYW8rSytZbnFUS3ZYSHRF?=
 =?utf-8?B?b2RBM3I3SXdXMmJHZnBwVVRqMkpZQjdJejVqNHgyMXBaOFhFTkhxN2hZa0E3?=
 =?utf-8?B?YjN1UnRIVmN6QmJ6UWFOQWJxdVNzY3QwRitPaUJCUXQzR1dNZ2oyNTNFaEw2?=
 =?utf-8?B?dkkvQnM2SDFTWjdQaGREdVF2dFBKZVJ3Q3hPWS9ucWo4NXBSemdGZHkxQ1F2?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6226e2fb-8399-49d1-6e6e-08dadf16840a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 03:35:02.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDj30qwXO9xfDnSspSsln9+6js4mUjCg1uGxWZrOBC5c2ietHh3tTJX2eNjXkDJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4805
X-Proofpoint-GUID: _gLIgXhzBcJcJwtrdRA8KJ_9ra81Vw4t
X-Proofpoint-ORIG-GUID: _gLIgXhzBcJcJwtrdRA8KJ_9ra81Vw4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/13/22 10:27 AM, Dave Marchevsky wrote:
> This patch adds a test exercising logic that was fixed / improved in
> the previous patch in the series, as well as general sanity checking for
> jit's PROBE_MEM logic which should've been unaffected by the previous
> patch.
> 
> The added verifier test does the following:
>    * Acquire a referenced kptr to struct prog_test_ref_kfunc using
>      existing net/bpf/test_run.c kfunc
>      * Helper returns ptr to a specific prog_test_ref_kfunc whose first
>        two fields - both ints - have been prepopulated w/ vals 42 and
>        108, respectively
>    * kptr_xchg the acquired ptr into an arraymap
>    * Do a direct map_value load of the just-added ptr
>      * Goal of all this setup is to get an unreferenced kptr pointing to
>        struct with ints of known value, which is the result of this step
>    * Using unreferenced kptr obtained in previous step, do loads of
>      prog_test_ref_kfunc.a (offset 0) and .b (offset 4)
>    * Then incr the kptr by 8 and load prog_test_ref_kfunc.a again (this
>      time at offset -8)
>    * Add all the loaded ints together and return
> 
> Before the PROBE_MEM fixes in previous patch, the loads at offset 0 and
> 4 would succeed, while the load at offset -8 would incorrectly fail
> runtime check emitted by the JIT and 0 out dst reg as a result. This
> confirmed by retval of 150 for this test before previous patch - since
> second .a read is 0'd out - and a retval of 192 with the fixed logic.
> 
> The test exercises the two optimizations to fixed logic added in last
> patch as well:
>    * BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0) exercises "insn->off is
>      0, no need to add / sub from src_reg" optimization
>    * BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -8) exercises "src_reg ==
>      dst_reg, no need to restore src_reg after load" optimization
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

The test is quite complicated. Is it possible we could write a C code
with every small portion of asm to test jit functionality. For
b = p->a, the asm will simulate like below
	p += offsetof(p_type, a)
	b = *(u32 *)(p - offsetof(p_type, a))
Could the above be a little bit simpler and easy to understand?
I think you might be able to piggy back with some existing selftests.

> ---
>   tools/testing/selftests/bpf/test_verifier.c | 75 ++++++++++++++----
>   tools/testing/selftests/bpf/verifier/jit.c  | 84 +++++++++++++++++++++
>   2 files changed, 146 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 8c808551dfd7..14f8d0231e3c 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -55,7 +55,7 @@
>   #define MAX_UNEXPECTED_INSNS	32
>   #define MAX_TEST_INSNS	1000000
>   #define MAX_FIXUPS	8
> -#define MAX_NR_MAPS	23
> +#define MAX_NR_MAPS	24
>   #define MAX_TEST_RUNS	8
>   #define POINTER_VALUE	0xcafe4all
>   #define TEST_DATA_LEN	64
> @@ -131,6 +131,7 @@ struct bpf_test {
>   	int fixup_map_ringbuf[MAX_FIXUPS];
>   	int fixup_map_timer[MAX_FIXUPS];
>   	int fixup_map_kptr[MAX_FIXUPS];
> +	int fixup_map_probe_mem_read[MAX_FIXUPS];
>   	struct kfunc_btf_id_pair fixup_kfunc_btf_id[MAX_FIXUPS];
>   	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
>   	 * Can be a tab-separated sequence of expected strings. An empty string
[...]
