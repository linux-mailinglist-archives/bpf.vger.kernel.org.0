Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3F64E774
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 08:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLPHDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 02:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiLPHDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 02:03:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528B4A07B;
        Thu, 15 Dec 2022 23:03:48 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2L1SA004917;
        Thu, 15 Dec 2022 23:03:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kzpG9huzSBy+DPwjeSPIsr7VxccXbRE9w0WgeBP33XE=;
 b=CSjJ1Nsr6Ox3ygOifmPmUxvkzuPg4Dlquyy3peBiLI/1OJKZI1dGt5wsidy9XBlZs6K3
 O4uSz/Dwx0IRdUPCQ2D1r5XgWW4LmLyRbBq/cK+M+RL6iAEE0emPm2aBl6Gj82xU5871
 HMucXcsUWKJGX+kaxoQlz828zHBtU5yl7oxh0LPAFfn3LKnPmeRJELpEwiKxyejuy9jy
 qxx0SvJTqFk1mP6SNN/nJSVN9VR4mDwXrk7MgiJm2e/EYxzqG8xrK6Eqikmq0N9ExZX+
 CPjptFJZ/trBkgccSOktedaPFZIn5Wn8BYDBeNosU7St0YHfHsot3+zhnXVSOPm1aeez Mw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mg148g7b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 23:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh4Up7duouhYsLb6yU4OGyTgVijsLkKmRykXapp2gFaKfED0WtOZHO8WxA4GtMY10J2mQDsqEhDucKPAq+MIF0xsevbYUQDefQuVLRhGB03DTHejuh+ZJB3J4X+iiYZ45Xb6hK9XzSoD0jlx8bvjbd2pAAFyZQbV4DP2dfQyv7ABMnPGy2o1nmb3HRJ9MoWM7XdPycPEfTTN6BS5+Y84maCI5AI7D5KQT3DkGv0eLuUcrjBYgakrlhC4OvxxfH+mvVP+oyMOya8dpECXYDhoza//+IeudbeEIFylwO3Hc7s3hi4DKCgAO2z1NTOibSw/lVawLalLumGWJNL2sAPrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzpG9huzSBy+DPwjeSPIsr7VxccXbRE9w0WgeBP33XE=;
 b=FTZJpInzA8j2hxLIwEu6XFM562m8rjGw320T0cZm8WARfDqephTlZWENcQWNkv4Hj54Wv65ALVMDVhqqdMuBWhSrYfqKYa0kqK5K+XycCwJXgFkkf49WB2BBAm2XXQSog/001oieiHnSxJ+gRbtV7UULdJDWbCZG5NrK0axEl57aJt2TpXa8pz2nedFEb8lgR0xxLTOCldZkvp/gzUVHScGP+f2XKDQSNO6i5TROlqhQaPqHY6Vb9AgQeL4j0NPuMgXls/lFrMvFtOTLz9Eo+S1SOn4co2bbSLlwkQeFLmUSUef/ZpFKmGE0ob60tMjOhEuPOJRsxeqXy0sZOlrhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3450.namprd15.prod.outlook.com (2603:10b6:5:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 16 Dec
 2022 07:03:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 07:03:19 +0000
Message-ID: <fa3c59e3-da85-aec3-d7bb-6360c842042c@meta.com>
Date:   Thu, 15 Dec 2022 23:03:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next] bpf: dup xlated insns with kvmalloc+memcpy
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20221216055436.4698-1-sunhao.th@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221216055436.4698-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3450:EE_
X-MS-Office365-Filtering-Correlation-Id: 52afae6b-cc9a-48a0-2e1b-08dadf339cbf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVjF+9lpo0ytt9dVE5sNb5r03nspll4LadxlZXAm2cxGnnOOkPSsuaVzr4oPgI939gxMD8DH96eNIYlepy1G4RvdQL737w4D2mkjVgoTNoRPbv8hlYjDt2G74xAQ8RDlXguca95a1PwkAIF3YFelsOKUIyDkzbXrZwrUyM5VIcXsuADlY+eHDUVwaC5RjeP2CQnFxftYTtBqZ7wZdAbyQnvE2VF7LYwV3EuFvGIdoMrO8pqiVt+kZ/zOYzN66H9l1zD5hqDtVOmoS3fHc/pk76yzuKc8E7mwtNjsdDiMSMCL8Iye0VCtklBsSWeHG0Yu6MP5Ik7Kmu7cdLwb8dsZx3Y/Fp0jK0F0lt52vrw6ZqkB8MQ5jJBijhL3JgDLd496X4XwBGKvdq7GTw1q7JYDAuTKiZRmuagSSitACK7njRYJUXaszjb/2P6SXb8Bv+fpwuwIX3sVOBDjtaBBiSS2LSsHJkWAmDVwVmvUAQWMdO/bx5Diq8NJek73+RedTRRq+ih3zZ78dLQW/YR/3yCtwI9lEPCBBxTyoZs9wCV3rB24mdipwuyy8WKmNQA/t8FA2dPYreGeENdq5CQtW+hXK3vSyiJIYEXuJMA5UGvTY1I6QXeeI7TTbWfitPRGrAdIsPZQSdq2nAVaw3KEl3dyNi70rBRKYSPebrAxmo5IGEyKpn8naCxL9HfMl3YzKDLUdLWFRgL39U3jNqUwHwuHToyWQDV6F7sLSqByZRrHfSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(83380400001)(6506007)(316002)(5660300002)(7416002)(53546011)(478600001)(6486002)(66946007)(66476007)(4326008)(8676002)(66556008)(31696002)(186003)(86362001)(2616005)(6512007)(8936002)(36756003)(41300700001)(2906002)(31686004)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThPSkVmakZzTE9xR1FnL2VSbENtZEZITFR3dWtCVDhObFJrY2ZZTm55Z1po?=
 =?utf-8?B?Wkl4QXdKMWI4a3NBazRKSzN2UEU4L0w1cVlOdnNUcFIvS1dlZFhZeU5HQmVT?=
 =?utf-8?B?ZGx5ZnNvZjNJUGM1SDloVnd0MzRyK01CempCckRobStiUjMzMkphai93MVFq?=
 =?utf-8?B?ZFc2ZUdDdTZ6Nms2alZubWxvTk9jbHEwOG5LT1hZd291bjVJb00yNzJZbXNt?=
 =?utf-8?B?Uk8wVTRqUXNlTlY4ZTBTbWFpOHZrRTBnNFdzbXJzeUo0NFN5UzZCVFQzenpY?=
 =?utf-8?B?UGxsb0RoK1BWWHROeStINU85cVN3cUJOZVJYaFpTaHhnSGE0Q1lDRGQrM0NP?=
 =?utf-8?B?ZmY2d0I1MmdhZkRUVHk2dU5PcmZPbTJXREFMNkloTEYxcjBlMUJYaGNQWEhK?=
 =?utf-8?B?VC9OeE4vSEM2YWNkYzFmN2FVUkpWOTh5ekxKOUQzNUNaZWFZOEUrcWJsRU1S?=
 =?utf-8?B?b0drajl1bnhzc0g5anpYTDljb0R0K2MzK2hSbHp6cDZNU0E3L0xINFQ1alUx?=
 =?utf-8?B?YnpsSDcraExRcUxkMXlSRFcvblJtRW92WVR4Z2Yza2NSc085c3FrQW56RG5C?=
 =?utf-8?B?ejhIYzJiaGVTTC95MzhhRmZuL3c3ejVEa2FWL1g3bTcrTG54SmhLQ1dzTVNR?=
 =?utf-8?B?RlZEK1NrYU5ac09oZUdid3haTmlIY3FFMlY4S3REajBqdGc4OCs5Z2d4MmZH?=
 =?utf-8?B?bTc0M1EvTEVSVTBmS3RIdTBEMGw5d3YwRXE2R2JkUWNYQzZ0ZzdOaXhvY05i?=
 =?utf-8?B?c1J1KzloTUh0MlVNVDFYWURDQjg2NDJQMThGaGxTMVk3enZ3TEhJcHRISUZU?=
 =?utf-8?B?LzlabmxudUlaUVQvUVN1ZGdVUUZrTDFIL0ExNWt2R3lsNWpWUC9tNzFUdW9L?=
 =?utf-8?B?Snl2ZUpWSHlKU3FGeldXcXQ4YjVYbCsrblB6eHJFRHBxQzlaaGc2K2hBOHNz?=
 =?utf-8?B?ck9tMGY2NTd2TVJWbUNXN1MvbTFDejQ1Sks0bm56bU0raWF1Vkx6TUJBNEJQ?=
 =?utf-8?B?QUVxN2lMWkhKMHd2UUJmWW1uUy9HaGxONlVyNE1KOWxnbGRJb1Q4WUJjUno4?=
 =?utf-8?B?T243TmFaZ1NzN2Y2UzlJTHBiTlJsMkY2YmlkTnpsS0NuTjBWSUMwRGdseHMv?=
 =?utf-8?B?anNtSnhmUnAwTVIrZTJzSTRxUU5iT1JJYm0wOFlvVVU2S3ltWkhKWXBVNmU5?=
 =?utf-8?B?Zkw0K1JkeXpKNlZZTWpHZGd2VVIvb3MwZFJseGZwVG02M0J6dFBKOFcrQ0Z6?=
 =?utf-8?B?SjdJbE1jYzRNQkxVbTB4VEZkaHpuVE5nK1A2WGxHbENqMWpSd1VHNHc3RVd2?=
 =?utf-8?B?TXVUQkp6YUVjT3lEV1REbTFRZUhqSlU2bUNpUTcyeGZmelAxK2Z4RzdCMnhP?=
 =?utf-8?B?Y3NRWnJHT0U3WjlNeWVualhMbWF1WCtyT2xza1dTY1NYdjNUUkVKVTNUaFlX?=
 =?utf-8?B?aEhKcE54ai9jSm1FaHUrOGZUb1QwWDRXTWFidnQrN1JhV2JBTnBBcWRhb296?=
 =?utf-8?B?Zmk5TzRPVlc5dG1OS2Voajlrck9KcVBXbm5oaFR2LzMvNWJYVmFISWw5Q3lm?=
 =?utf-8?B?ZktzeHVGNE9ieTRqdHR0TUJFOHR4ZzRpRXV6TnUvazdJNDZFU0pEblNobFp1?=
 =?utf-8?B?ZUdxVHlIeGVtQVFtNHFFc1hpRkNYZzdXVUJidzBlLzAzZFRyOTJBV0xhTGRr?=
 =?utf-8?B?L2N6NTQ1SThlazY1K3U5Q2QrV1luS1ZkdGpMcnFLQUhiWnZzdEI2MjVUcmdi?=
 =?utf-8?B?cEVYdWtNMktVejFuaHg0NlRNOHE1ZmM0Vnh4R3ZLVWtOV3hpWGltMGVFWmdV?=
 =?utf-8?B?eUF2OXVKZ08wa3RjMVhQZGliWi81eStpZUhFRFBxUFNjZXAxRHlWa0YrNUdo?=
 =?utf-8?B?ZXRRdTArTDlpZy90R2ozUmV3S2hCdHU4dzd4b05sTlJPdzY2b2cyeEdtT0hr?=
 =?utf-8?B?dHFIek9ZVk9XemhWUDBlQ1lpdjhKakNUMVdPZThsL1FwcU1hZytEbFpRSlVs?=
 =?utf-8?B?R0VkS3BxTlh0VGlkYjNIcXhDSjBxUnFhdHRTT3JYcDIrR3c1QlZoa3kxTU0v?=
 =?utf-8?B?WXJIVFNpeVdsNUc4QWhTZTY4alZmUlFuZGJ0eU1RdFpUYzJJZU9vK0hXTk94?=
 =?utf-8?B?b3p6RU03TDFiSGNaQi83WnlicHAwNDlaM2NlV2ZSbjBTSmxiSTN5emFubDkx?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52afae6b-cc9a-48a0-2e1b-08dadf339cbf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 07:03:19.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeXibKG1TTcEHZ0qwK9lVyGlPIkimXdLBVR0lBpDKpMEZH0ZnlxWzbqyasengkcb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3450
X-Proofpoint-ORIG-GUID: FcrBA5F2Vm4lVGcok8cCmepSF5wM14j2
X-Proofpoint-GUID: FcrBA5F2Vm4lVGcok8cCmepSF5wM14j2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_04,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 9:54 PM, Hao Sun wrote:
> Currently, kmemdup() is used for allocating and copying xlated insns
> in bpf_insn_prepare_dump(). The following warning can be triggered
> when dup large amount of insns (roughly BPF_COMPLEXITY_LIMIT_INSNS/2)
> because kmemdup() uses kmalloc() which would fail when allocing size
> is too big, leading to failure in dump xlated insns:
> 
> WARNING: CPU: 2 PID: 7060 at mm/page_alloc.c:5534
> Call Trace:
>   <TASK>
>   __alloc_pages_node include/linux/gfp.h:237 [inline]
>   alloc_pages_node include/linux/gfp.h:260 [inline]
>   __kmalloc_large_node+0x81/0x160 mm/slab_common.c:1096
>   __do_kmalloc_node mm/slab_common.c:943 [inline]
>   __kmalloc_node_track_caller.cold+0x5/0x5d mm/slab_common.c:975
>   kmemdup+0x29/0x60 mm/util.c:129
>   kmemdup include/linux/fortify-string.h:585 [inline]
>   bpf_insn_prepare_dump kernel/bpf/syscall.c:3820 [inline]
>   bpf_prog_get_info_by_fd+0x9a3/0x2cb0 kernel/bpf/syscall.c:3975
>   bpf_obj_get_info_by_fd kernel/bpf/syscall.c:4297 [inline]
>   __sys_bpf+0x3928/0x56f0 kernel/bpf/syscall.c:5004
>   __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>   ...
> 
> So use kvmalloc()+memcpy() to fix this, for small size of insns,
> this is same as kmemdup(), but this also support dup large amount
> of xlated insns.
> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>   kernel/bpf/syscall.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..06229fddac0d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3831,10 +3831,10 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
>   	u8 code;
>   	int i;
>   
> -	insns = kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
> -			GFP_USER);

Does kmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | 
__GFP_NOWARN) work?

> -	if (!insns)
> +	insns = kvmalloc(bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
> +	if (unlikely(!insns))
>   		return insns;
> +	memcpy(insns, prog->insnsi, bpf_prog_insn_size(prog));
>   
>   	for (i = 0; i < prog->len; i++) {
>   		code = insns[i].code;
> @@ -3992,7 +3992,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>   		uinsns = u64_to_user_ptr(info.xlated_prog_insns);
>   		ulen = min_t(u32, info.xlated_prog_len, ulen);
>   		fault = copy_to_user(uinsns, insns_sanitized, ulen);
> -		kfree(insns_sanitized);
> +		kvfree(insns_sanitized);
>   		if (fault)
>   			return -EFAULT;
>   	}
> 
> base-commit: 0e43662e61f2569500ab83b8188c065603530785
