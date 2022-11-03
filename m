Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F316188EA
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKCTqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCTqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:46:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55F1CFF4;
        Thu,  3 Nov 2022 12:46:21 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A3HvLjD017965;
        Thu, 3 Nov 2022 12:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ndhEL4Par18ws2nje3EV8I4WgBcnwvTyaWkNFBF50i4=;
 b=DV50w9gG56RRGIJxh5REzWA/vD7Dmr4KLZlxRY1/wMAF+nA9EJB+q3UH8ZzsuPcO+Tkz
 /EMO+NNujSGfsNqz1IxZVbvP9Npn64zvNmKgvpSX+SKWBBuZDQzs7sIO/VrCzczgtv4d
 /nefBPMGVy0fmX7BSo/vdOpzmlJZZif7OBQZwNHIBQfbUjt230VfVDpRbvSGM8FuAyoN
 ++bbOGuw91m7+Zpa6WIQG6MSR3mXfEhy5lAhJbiiuqs/BH467egYYT0ez1MezAmyhqVQ
 wzPg2q/CgYpZsHI5n2XpuCy+JSKSvUqe0QhopQSt2vfZ5zdKOivCYyxz5c9Ee/G7xMkW Yw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kkhd9t1fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 12:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMtF9FiznOkKtG5Py4Yo0NYaYSQrQNMmTAidebOU58Poiv4uZflutifysj3MBI9RtPTK6MNW+iy6WYiErDGhlwC6+axeoaiRHChJJW2xWieyoqyXYxWRa72/hi9yOlXL1hy6IFgeuu2SNdlTAdBn+suP1othfLFWYJGBIpIyGr2ZS60BaAAuQVYmRSBXdc2JGtzJMP4OhR8xWMWxIvZZN4VP2k6rUhXGg1lHZFlsbbwwKZIgf06JGsGG63XjqXU46//sbpXcUpEIx3bQqZZXL9gRoVd5TpHv9sgwd8czjyc7TKKWWxpax1DD2Z3eT1Du0eYTA9Ah88HN1k/nNOyIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndhEL4Par18ws2nje3EV8I4WgBcnwvTyaWkNFBF50i4=;
 b=j5r7Jc6X35PbltLfYtqD8DjDwadopouho3QI2wBlzfabvIAcpiBGzYC2V/ahneJ+cArTvuN/0GIxPNzHM+o/Gs0C+2+S580p4DpD7YJ4g/xxDnPUYUjUutlNjbQMfAdVSfLM7t6YlTIf/NL7NgIF2XeWDmLPCKwkB7527PGMsWFPHerU59gih/sjGAzAo38Wd3RnJAE3M1zPUwnnbA2tbhaIV0iY/HQJsubW2+6OkUDbuNCp9mU0zc1Qa9ILFCSkJoaWbMPP8vUPWzirbJUN9M/VdjvDF20Vqai6yYIZplzIlAl9AsPWgFkMjiuogNfaSecz3My3cNAiuP6NdazWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3778.namprd15.prod.outlook.com (2603:10b6:208:254::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 19:45:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 19:45:50 +0000
Message-ID: <5b0152db-8a8e-0d8c-0304-8c48b735c3b7@meta.com>
Date:   Thu, 3 Nov 2022 12:45:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20221101052340.1210239-1-namhyung@kernel.org>
 <20221101052340.1210239-3-namhyung@kernel.org> <Y2DuzmnUm6NIh25a@krava>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y2DuzmnUm6NIh25a@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3778:EE_
X-MS-Office365-Filtering-Correlation-Id: aded7644-60e2-4b63-6c53-08dabdd402e7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3e3fG0lQIqd1vh7JnanBV61kp1bT160QYi2+/FcDjDBkEBMcRXOHJQg5bOSfEs0wWzd0CxJM5BKqjxouStPErkOjZ3Zf28HBUShsf7S25fUqWBrxF5tG2EX8C7dfTSpa3NVQw3QaIy/SrD807aRWwkb6rwKkNGfc339W/gfRQ5F053ifTVVb8kb05ykOE3BbmQ9Me67x0BGWnQVCYKyeSCuFsaV6NW96hicKY8o3IZr7dq1SQYW4OaD6frpgdS1gAdDUsQ/BbXTqPyY8C+HbUVlLiPbjbFDSn7WG97vfGaINoZCPr9VE2Kxqh6507Ql8ZnJAm+TZtgU/y6HksEXYXjBtRfx05SXp8GtftEYTuRNGT9blFJrm3fJt0N254TVTbLy+1AAbONeAvwZaAT3KXZf/jZciA//VJBCM9o9zHv2dSz9O2zTUADDN3pk7gqkjjiOeLb7UVmxSmV4Tq5Ew7U9sOz+iHC/+hdiQ1b7UmBr0BNxRZEEtyNAzPGCuHkXNPtFVAAcpL6totwpcvViJ3TMdIX1WX4Z7giRS5ag9S0ipR9uRLycG8hFHedLd7huJpZvuSR6r71/pPeSbABIUGtaFb03dFOtLxu6DoYVgYMiAOogM6VW30IJVqpb9PsIB2Zcg97eVISGsy9Q+8ak37xOmwEVun/xPxyAp6vwV4OVnZqa4E47dso/oHExpQirNwgdPQO14Kv94mIvFa6chYpKXwV7Kf1MU4LE2wF9TS5QDoHoka34wZkRjm/NyMuE9VlNNxcDRwdeUca55hYN4yK2Z7MKEcY77uvWi8WOk50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(186003)(2906002)(6486002)(83380400001)(6506007)(4326008)(5660300002)(66946007)(66476007)(66556008)(478600001)(8676002)(7416002)(53546011)(36756003)(38100700002)(86362001)(31696002)(8936002)(6512007)(316002)(54906003)(6666004)(110136005)(2616005)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFKUVFFVmNTaGVpZlNPMGpBb2d0QmZJNnAwWmt5RjdhYmFmSmxBUjl3Z2h0?=
 =?utf-8?B?U0lWMHBaejgxK2ZqcGhoZ1JsanZWNGN0cS9FV1FqSzBNSlpLd1BBMjdYNUtI?=
 =?utf-8?B?K1gxWFdrTDhKbkRoNlB1SGVTWGY5VEJwSG9GTHkxSmR3dWk1U0I5ZW1uenQ2?=
 =?utf-8?B?enE3d1F6N2xhWk1yQS9FNzBLWnlPc3dWSG9YdjN2d2JtNVpPZVI3NTdRR2NU?=
 =?utf-8?B?Y0JUZHh6UktrdXl1bzJ2a3RSZ1g5T0xyRzllbml1Mm1HRHdVTjNxckdCMGZq?=
 =?utf-8?B?dWlVMjk5UkVpZGgrcTBIZEh5NnNDbVIwT1ExV0xydE5LblpIVXJJZTd1WVR1?=
 =?utf-8?B?enhHQ0tUVGFyaEwxSmRNT3ZDVW1rbjAvMnQ1RTVjN1I5OGxMc3pNc3cxL3I0?=
 =?utf-8?B?MWQ0RFVBbjhjakFnOFZWQUtLZjd5S0Rma253T1MvRnhkbHRZd2xyZ1JLQjhv?=
 =?utf-8?B?elhRSlZTdGRBWEdiT0dYbWliRmpZc0pKckdxYjIwWWlUcmh2aG1PaHhJdkIw?=
 =?utf-8?B?andYZlpJNG9RcGZtc2pESytWd2JIbkNDV05TMm1xTnVWRjVOTUV4aVNRQVhh?=
 =?utf-8?B?ZDZPbTZOdkZLcDMxNGJVN25SYjRkL0dkRDFyMTJFTWkrR0Vsdy96Z1p0THdj?=
 =?utf-8?B?VlFsS1dqMmt6d3h2L1J2TTZOU1VPRGtBTkZrTnlrc1RsT0ExNURKUk5nZThD?=
 =?utf-8?B?d1Jram1yODFSUGZ0eFVwcE1TUFZKSUxWbTZ0NHZQU1FwNENyUGk1MTEzdGda?=
 =?utf-8?B?blhyazdGYWc0UExIVllQclluUkRIOG9jSE0xcFU2MWkwd2JFd0hxY3F5cUln?=
 =?utf-8?B?L1hJbGx5RkNlL3MrS0NIcUFRcHZlY0lOKzY3enJWWVlzb0xEN0M1VHRGcDJu?=
 =?utf-8?B?T3JlT3htdWZsYTlaVTVoekZQbUNpSlBLdno5eDZhazNYeXRGclFUbmd6TkZq?=
 =?utf-8?B?ZkZhK3YzQ2JxczBYaXc4d01XemV2Kzh6eXBad1Y4NUlVSFBMWEdEd3RFVTI1?=
 =?utf-8?B?eHdQTVpnK3BsZ2wzUDYyL3pmL2s1MkQ1Y09hckRYTXBXWmdaVUZoVUh5Y0gy?=
 =?utf-8?B?eEtxWUdNU0lXTDdrM2NiOEhxZ3lRZmJtc0JsLzgxdTI4TjRlSFVXZktBTGtO?=
 =?utf-8?B?bVdSWEpXVTJHWXZvSW5ra0lUTTVYVjJPYkxUWURZRTlGZHovTVVZSEQ0U0Nt?=
 =?utf-8?B?bURtUlVFU2RGcm4zRE0vcDRFRExKVXFDaTRkUkJFYUJEN2hlbTVKT2FlR3o1?=
 =?utf-8?B?QmVOeWtQaXNDWEpUYjhBM1FqS2MxS0NCdHlzR205YkpSWDIwWHpDNEkvNjd2?=
 =?utf-8?B?V0YxTG0zMGhKS3FCeXVJK3VaSmFpV2JiV1hNKzlHNlFLbDRFWVhVRGZRRkJn?=
 =?utf-8?B?Tml2alFHaEwwRzkyNkN4ZkgxVzRXZDdHZGEwUXF6SFpmUGY4dDhFSisvRnhU?=
 =?utf-8?B?RWhrTERnR05QMFVEWUx1dGtPeGtZVm9TbENNVE9ONXJIVFFqbUNWRUxUV2xI?=
 =?utf-8?B?ckFYaXd3bkdycWhaU2x3MHNlVVFqYStHbHhyYVhLb1o3ZGJSWjJOeDBCRjdi?=
 =?utf-8?B?MVR3UXNUWDAwT0pUQWZXT2draW9Gbjk5ZHdRRFBJVGZoaUNwcy9zUHJOaTJr?=
 =?utf-8?B?SkVlR1JZbXMrcTU3ZXhSNHdOQVNEcHdwZk80cGdiTjduVnV0V2xaZVZseHdT?=
 =?utf-8?B?K1FBZzFtRTh2RVdJTzYrVjJlVDc5VWpENDJnR3RkU3FJOEdKV1Y0WFdwY1Zh?=
 =?utf-8?B?WFMxb2gramhGQ2V6VDJUQzF6TTlDOTFWYU1DeTU3Zzd5dXhYdE9MSUx4cHRa?=
 =?utf-8?B?aFIyckdqT0JvNkRyc0txVjJnVERUakZ3ZytzSDBiNjVFbThXbllSOG1mUEUz?=
 =?utf-8?B?ZEwxN2FkOWhMS0pzQVpZT1dOaWNXaiszRkNjMWpLdk9FNm1Wa0MvZmRTRkxn?=
 =?utf-8?B?ZkRWZDlydHFONlFXWnhab3AzaGpmSjg1Q0kzYjgyajZKeEZjU2V4OUhCd0Zy?=
 =?utf-8?B?R25reXFDaHNzMXdBOTg2VWw3YXhRMnZKTnc1ai8waEZHeGFKZXZ4aTYrSVc1?=
 =?utf-8?B?dFBZdjNVc2NVd3dvaGVycGJzalhRRktETi9PSTljNzlZTnlXYUpwbWVkdjhi?=
 =?utf-8?B?YVFZS1VCY1AzS0p5K2tzZGt6QllQek1jNnhrWnBTNGRibzFkeHBKZjlkNkh5?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aded7644-60e2-4b63-6c53-08dabdd402e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 19:45:50.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMNvDIT0G3RIh9N5roQqvmbR8wuVQnQr3Uo70h6d5v1Xm51RmxmNSK5Wome3yXXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3778
X-Proofpoint-GUID: GMER0uJoIlt3_FYgp4FS8Hk16VpMffIq
X-Proofpoint-ORIG-GUID: GMER0uJoIlt3_FYgp4FS8Hk16VpMffIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/22 3:02 AM, Jiri Olsa wrote:
> On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
>> The bpf_perf_event_read_sample() helper is to get the specified sample
>> data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
>> decision for filtering on samples.  Currently PERF_SAMPLE_IP and
>> PERF_SAMPLE_DATA flags are supported only.
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   include/uapi/linux/bpf.h       | 23 ++++++++++++++++
>>   kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
>>   3 files changed, 95 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 94659f6b3395..cba501de9373 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5481,6 +5481,28 @@ union bpf_attr {
>>    *		0 on success.
>>    *
>>    *		**-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
>> + *	Description
>> + *		For an eBPF program attached to a perf event, retrieve the
>> + *		sample data associated to *ctx*	and store it in the buffer
>> + *		pointed by *buf* up to size *size* bytes.
>> + *
>> + *		The *sample_flags* should contain a single value in the
>> + *		**enum perf_event_sample_format**.
>> + *	Return
>> + *		On success, number of bytes written to *buf*. On error, a
>> + *		negative value.
>> + *
>> + *		The *buf* can be set to **NULL** to return the number of bytes
>> + *		required to store the requested sample data.
>> + *
>> + *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
>> + *
>> + *		**-ENOENT** if the associated perf event doesn't have the data.
>> + *
>> + *		**-ENOSYS** if system doesn't support the sample data to be
>> + *		retrieved.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>   	FN(unspec, 0, ##ctx)				\
>> @@ -5695,6 +5717,7 @@ union bpf_attr {
>>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>>   	FN(cgrp_storage_get, 210, ##ctx)		\
>>   	FN(cgrp_storage_delete, 211, ##ctx)		\
>> +	FN(perf_event_read_sample, 212, ##ctx)		\
>>   	/* */
>>   
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index ce0228c72a93..befd937afa3c 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -28,6 +28,7 @@
>>   
>>   #include <uapi/linux/bpf.h>
>>   #include <uapi/linux/btf.h>
>> +#include <uapi/linux/perf_event.h>
>>   
>>   #include <asm/tlb.h>
>>   
>> @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
>>   	.arg4_type      = ARG_ANYTHING,
>>   };
>>   
>> +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
>> +	   void *, buf, u32, size, u64, flags)
>> +{
> 
> I wonder we could add perf_btf (like we have tp_btf) program type that
> could access ctx->data directly without helpers

Martin and I have discussed an idea to introduce a generic helper like
     bpf_get_kern_ctx(void *ctx)
Given a context, the helper will return a PTR_TO_BTF_ID representing the
corresponding kernel ctx. So in the above example, user could call

     struct bpf_perf_event_data_kern *kctx = bpf_get_kern_ctx(ctx);
     ...

To implement bpf_get_kern_ctx helper, the verifier can find the type
of the context and provide a hidden btf_id as the second parameter of
the actual kernel helper function like
     bpf_get_kern_ctx(ctx) {
        return ctx;
     }
     /* based on ctx_btf_id, find kctx_btf_id and return it to verifier */

     The bpf_get_kern_ctx helper can be inlined as well.

> 
>> +	struct perf_sample_data *sd = ctx->data;
>> +	void *data;
>> +	u32 to_copy = sizeof(u64);
>> +
>> +	/* only allow a single sample flag */
>> +	if (!is_power_of_2(flags))
>> +		return -EINVAL;
>> +
>> +	/* support reading only already populated info */
>> +	if (flags & ~sd->sample_flags)
>> +		return -ENOENT;
>> +
>> +	switch (flags) {
>> +	case PERF_SAMPLE_IP:
>> +		data = &sd->ip;
>> +		break;
>> +	case PERF_SAMPLE_ADDR:
>> +		data = &sd->addr;
>> +		break;
> 
> AFAICS from pe_prog_convert_ctx_access you should be able to read addr
> directly from context right? same as sample_period.. so I think if this
> will be generic way to read sample data, should we add sample_period
> as well?
> 
> 
>> +	default:
>> +		return -ENOSYS;
>> +	}
>> +
>> +	if (!buf)
>> +		return to_copy;
>> +
>> +	if (size < to_copy)
>> +		to_copy = size;
> 
> should we fail in here instead? is there any point in returning
> not complete data?
> 
> jirka
> 
> 
>> +
>> +	memcpy(buf, data, to_copy);
>> +	return to_copy;
>> +}
>> +
>> +static const struct bpf_func_proto bpf_perf_event_read_sample_proto = {
>> +	.func           = bpf_perf_event_read_sample,
>> +	.gpl_only       = true,
>> +	.ret_type       = RET_INTEGER,
>> +	.arg1_type      = ARG_PTR_TO_CTX,
>> +	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
>> +	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>> +	.arg4_type      = ARG_ANYTHING,
>> +};
>> +
>[...]
