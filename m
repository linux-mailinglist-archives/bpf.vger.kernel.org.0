Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE066E2A2
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjAQPqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 10:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjAQPqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 10:46:02 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E723125
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 07:44:07 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFgkb6016949;
        Tue, 17 Jan 2023 07:43:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=oi9FEdszlhZpoOSdHPCHBtEDBDNhAPqpoGfNO+y7rLk=;
 b=WNC9ZJmRBekc/GLmBGsDKSUO6/cfodKROo2dvRzc5i01JwE128e/nuGr4xJYych6tfIi
 ZpfyyxwsHd/xv0hOYjnmS2DzfiInCm7ZmSYEBmQWHX7QnhXGhHTskID6D/tbrbRen5V/
 YZgfY7WD66LVtF2IZ31a4Ypsd9EIsnKeWFHi4R7Iwi4s2otTCodFkfyxiyBnChE/Jt37
 wwAjeBM4LxjUevPW+sAapWix3iJzBX6fTsNQfuh4gtIkxMPGATAhFg7R4JE9kbxMPBy4
 pS6OESYbboZW7DnkHnYALPEiEIRV/MtFRfSMTQwjg9L1DWTcm4B3XxBGu4WF/ScEO/V2 fg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n3u16cyh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 07:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD0PAy/EZ25Jm4uApbI31TVR5GNlm+w4s7uxzodWEpjMEsJhJYww7L2MlisrM9FZ0gZF+qwp4FaSCJ2THAsVX01lzCLVhsIETMA352LUcPJ6OV8htPbPkwzcv1PC+uCEbpAOfZ/MBjkjXZ/ugxSuwuloXHWJU5XGcReqtV2On7RSpHNswtyD1OSaMxgJMYzc1vMR7eCXKmRywtqbc+jucI4uU2sE4hO+q6lH98fK7iwX/M5zvaX7MRdtvH1//5vQkahGsyLsTSDLMj1VaZ7Jr8WUE+neWfbI6ysP0O6Ta/Njkrr/sC6k9XsIWZxsYPxBa+FURBAqHcbBNuQVIL3afQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi9FEdszlhZpoOSdHPCHBtEDBDNhAPqpoGfNO+y7rLk=;
 b=GnUV2F8FXxHrrf/bGIKWeHEeP+RkJgVDDr6rGSWSfcPeiSZ26NLFIE/3Tb60qQAfb19haYEhGimhKkTvwk371e5x5sud3yobLg8kAvpS/GHEOn5E9FYDu8l0HzemlCav8a6SEdcWp2kzRPMDqB0d5PZ8XOvHVemaofLHsQ58OVSkpz468Xr9joLWgNnq1QCnsnlh9uww1S+lP3SyLjQ61EP3Air3GHhCFmp/KCqRXp6AJsVN1Kvu8Zxa50wCx92Cyg26gtu2GUtVteOjbGH0Eg02ZHWtuPwTtOkbU9jLwR3RHYjQ3jDEkAu/m9cWZcVp+Do8U7cpZzBUqCqFjjRufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4176.namprd15.prod.outlook.com (2603:10b6:806:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:43:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 15:43:46 +0000
Message-ID: <5ea1c791-eac4-b984-d0c1-1740d0a79ff6@meta.com>
Date:   Tue, 17 Jan 2023 07:43:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Do not allow to load sleepable
 BPF_TRACE_RAW_TP program
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20230116132901.161494-1-jolsa@kernel.org>
 <37b0ea1f-0c28-2858-550f-27f89563e588@meta.com> <Y8ZoVLIkqKeP3DnX@krava>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y8ZoVLIkqKeP3DnX@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN7PR15MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 66feea9c-46f7-485d-f922-08daf8a19ee8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9M/5s14fL0MhwtD35zFIAo8RjLiqbnAZxtAVV5w+LsHxZuK3hk9feC0FXOYBg+jEcRk3fpbzNp1mJ2eangabSrEMa4gjkljlWxYZW5vV70cu0t8VzLZAFsf+oyqtxz6pJU9PF1YQrTgAlbtcsgiAD6QgNnk2TnX4GI8mFGbii37rz993wnKK7J2nE5fIsFqmPK9J5C2VlG5MZmlLXZwUBACFIi0z4Z5sXFCSPEFnUNQxTrcpckcZKVsZxmmKR70wazBMOCXVFGfoSvJeOzAhLTTL/B/m0YLE8OEBPGb7sxAFLv07s/9toXoOK5WMFvQPvOancAkUfMiW9o01AqpszA190Rqkd2TYu+v2ebLfe3XHGvTc+i+peNfjdcHuryEcdv52NyqyUqt+cVd+uQBh6yRvz06wIFIzIFulaPXwaFfngbXyAaxFg0SExUELZMQaH+EV3Ue4oVi8LSaaAbh4OHLm7lz32zWacn/GxYjWM+J4xz1CN5rTLLQzGaDskj8PHjrXXtGyw1wShjy/G2n41gOVgc/BSHyG2HWoeP/0Ud5LkTqOZI2vF2IpAt9p/uWAxaPIdJeH0Pif46robIexNHk67/BR/QaQKZQatPh225mgyYFbr3AEZd4uczDH8S8I3hukAzOfKwYrgJjeoQ7WoiJKPvjXZYlm0BSczBkaLQCF64Nuv1ReHmJmukegMoznw88veh5ZwpFfWAvI6umyxu0VU55DJVqv0HzLZ7V9TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(31696002)(36756003)(86362001)(8676002)(53546011)(4326008)(6512007)(186003)(6916009)(66556008)(66946007)(41300700001)(66476007)(2616005)(316002)(478600001)(54906003)(6506007)(2906002)(6486002)(7416002)(38100700002)(5660300002)(83380400001)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpISkVTSzBMN2E4VnhNbXpFeXdqcFlnWUlnUmRaMmxnVk1DYUd4RGdzcmQz?=
 =?utf-8?B?SlhiaW51Z2lJYURCcEQ5VVNtUDhKT1dHcmNFVFBjQ3A1VCtuYVVqK1NaREh5?=
 =?utf-8?B?UWZmS3VpNWRLajkrblNMS1pMOGhzSHJQY014Ui9xOTVjbGs2UWtpQmoyTWRX?=
 =?utf-8?B?YmlWT2psVFJKVGJPRHhWWXBZVVg3cWU5VFozekprWlNLanBhUndaRzMwRmEv?=
 =?utf-8?B?RjNFS0wwN0UrVmhhMWZZSGpsdnRVUVNnVVRWaUhVeTJrTHExZko3S1drK0hZ?=
 =?utf-8?B?dlhUc08zcU5GZ1Zua01yWGhacWd1aG9POFR6RklBWnNjeGZ5bXVwRU9vVFhL?=
 =?utf-8?B?cHkwQ2k0TXF5YjMrc0VtMDdEQm9JUGx4RHNKUjRvOUlrRWN1cHlkaUtmVkNC?=
 =?utf-8?B?VEE1Y3BPdWcvL2tiQ001cS9NWStEUlpLUWg4RkdhKy95ZEUzNEFmSmU3MkRy?=
 =?utf-8?B?VnhLZXR1anF4RS9Db001MW9IUFFCZG5WSWVKeS92L01uTEhadGFyUWNZSTh6?=
 =?utf-8?B?YXo0WE95NTNYeDZNQm8wc2FNL0VrdENnZE5TRW5NcXpuWlVOOW1iQXd4aDlK?=
 =?utf-8?B?TnVaL2FZZ08wL1V5L2I2bDJlT1NMd3hjaDlWR2RLdm9yeGZDbVByU3lzZFBa?=
 =?utf-8?B?aENydHJxQUtOMXUzWVZlNmNkV3BjUVVxbEo5SnN1WFkxYjB1aXJ5S2xxNGxp?=
 =?utf-8?B?YTRibUZiRTN2cDA5TlRQWDBPbmNrR2V0WVFta3pVQUpWK3ZhS2ZPUjdWeXFr?=
 =?utf-8?B?SkpkNFJOeTI4ZFlaNU5NQTFtYWt4NWROZFFFM1pTbVhHa002WnYwWGNMQ3k2?=
 =?utf-8?B?OURLZFlwNW9MSVFaUXNaZUhHOUVXWkdHWjVlK2FtUS83eU9UQXlrM2JWTFBN?=
 =?utf-8?B?N0Vwbks1NUJvV0NQMzFSa1lwNmVyeWE2ZmZtUjc0UU5oTlh5YUN0NzYxUXJw?=
 =?utf-8?B?bnI5dzRFcWpDRVdPaFJzMk10dnFaZmJyMmxqTXpiTUx5b1RzKzFBZmRrbmFM?=
 =?utf-8?B?UVluL2EyQUZ2NElENExKdWE5azlTbm11TmRRdDFLVjdYeTVWUXFSSjV5cW52?=
 =?utf-8?B?N2cxd1dWS2xPdzVSeW9Tak5CYk1jR1RvMGNWcWE1WjlHb1IrZWJ5TGJWQ1VK?=
 =?utf-8?B?OVp6cWFpVkcwV2VsMDV6Q2pSYlIwOTdGcjZZVXFEeW9sK3RWaklQZC9ETWE5?=
 =?utf-8?B?TjRpSFM2RHNIOG0wU3FCbjBtNHUyZjcxdUhwcldKeEhFbFkvWWQwVlN1ZzZ0?=
 =?utf-8?B?c1Q3ai84UTFGMjZrcmdwVytyem0vcUxUYVRGZFplTmtGcXUwZlZueG9rK1Y0?=
 =?utf-8?B?eUZ5U2toWG9tTUd2cTl2V25mTXRyRklCU01kL05rUzhybGx3c2RyRm5uRyt3?=
 =?utf-8?B?NnFNazBjWFkvTThZbUpwT1pOcEdKaUNMaHFTbGhWTWVQRmdiU2o5NFg0QTFC?=
 =?utf-8?B?bFZXL2hVWDMrYWF2c3F5Y3dFMEk0TngvdU5oNmd1MU1mbmFpUzNVNkVReS93?=
 =?utf-8?B?STJ3VzJyRjg4Mi9KekF1WTAxWmdwWHhxdXZ0QitPMkh5VzR5RUFCclJKcDhI?=
 =?utf-8?B?ZzVTQkVUc1o4bktCbnhxNHZOQTUzZ1lzZFpmdWpvZmNOMnNaMlpSck84cDkx?=
 =?utf-8?B?YllrMHFqVi8zQlVEV3NSNk1aQzJudTZuTSthZjU5Qi8wYVM4TW9WeXNCdWg0?=
 =?utf-8?B?dUQ3RVA5RDJkTkhCWG1LZUtRMXdBdkEyYy9CaG5nQmhmekpKOEdMVlZ5cmpn?=
 =?utf-8?B?MGhBS0NoTEdrZTB3QjRrdTdYdm1nUC9CMkJRYXZIclFXVkxRdFlIWHhjTUxj?=
 =?utf-8?B?NllOSlhqTjJmb21oLzkvUkg1ek5PcDl0aDRvaEpMVVRjdFgyL3B4dkRIa0t4?=
 =?utf-8?B?SmJReStnQkQxVVlUMEYvL3FOU2JOb0dQQ1lsWTNJWFdNYjdsL0xSaW1iVlc0?=
 =?utf-8?B?bjBIeGlxZVF4Qkh3dzZOOExyVTNvcmVPTTM4Q1oySVcvcVR2eW9SQTF3M1d4?=
 =?utf-8?B?V0poM3FqYWtBUmhQcHltYVZ5UG9Hdys4STZmSWVFWlhEelN1OUVISWRlZXRt?=
 =?utf-8?B?bzV3MHZXYUdUWjFtcjlidDlUZHFxczhUMHAyOFVHTTZtQUNUTnJtT3c4SzZ2?=
 =?utf-8?B?amczUGx6Z0UwbG9uVDhTQU93dFhNbmRoNld1QUV3bWszNUsvT2laZHUwc1Uy?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66feea9c-46f7-485d-f922-08daf8a19ee8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 15:43:46.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI61nDqJvtALmBlHhtNcgm1dGEt7tsHfpj3NUJjeSRdaQfEBrL6sXb+HG4VOHLZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4176
X-Proofpoint-ORIG-GUID: YxMvW1NMyG9-zT6J-kMhaD7FtMWyBKly
X-Proofpoint-GUID: YxMvW1NMyG9-zT6J-kMhaD7FtMWyBKly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 1:20 AM, Jiri Olsa wrote:
> On Mon, Jan 16, 2023 at 11:17:56PM -0800, Yonghong Song wrote:
>>
>>
>> On 1/16/23 5:29 AM, Jiri Olsa wrote:
>>> Currently we allow to load any tracing program as sleepable,
>>> but BPF_TRACE_RAW_TP can't sleep. Making the check explicit
>>> for tracing programs attach types, so sleepable BPF_TRACE_RAW_TP
>>> will fail to load.
>>>
>>> Updating the verifier error to mention iter programs as well.
>>>
>>> Acked-by: Song Liu <song@kernel.org>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>
>> Ack with a minor comment below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>> v3 changes:
>>>     - use switch in can_be_sleepable [Alexei]
>>>     - added acks [Song]
>>>
>>>    kernel/bpf/verifier.c | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index fa4c911603e9..966dbfc14288 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
>>>    #endif
>>>    BTF_SET_END(btf_id_deny)
>>> +static bool can_be_sleepable(struct bpf_prog *prog)
>>> +{
>>> +	if (prog->type == BPF_PROG_TYPE_TRACING) {
>>> +		switch (prog->expected_attach_type) {
>>> +		case BPF_TRACE_FENTRY:
>>> +		case BPF_TRACE_FEXIT:
>>> +		case BPF_MODIFY_RETURN:
>>> +		case BPF_TRACE_ITER:
>>> +			return true;
>>> +		default:
>>> +			return false;
>>> +		}
>>> +	}
>>> +	return prog->type == BPF_PROG_TYPE_LSM ||
>>> +	       prog->type == BPF_PROG_TYPE_KPROBE;
>>> +}
>>> +
>>>    static int check_attach_btf_id(struct bpf_verifier_env *env)
>>>    {
>>>    	struct bpf_prog *prog = env->prog;
>>> @@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>>>    		return -EINVAL;
>>>    	}
>>> -	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
>>> -	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
>>> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
>>> +	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
>>> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and kprobe/uprobe programs can be sleepable\n");
>>
>> actually kprobe programs cannot be sleepable. See kernel/events/core.c.
>> perf_event_set_bpf_prog(...)
>> ...
>>
>>          if (prog->type == BPF_PROG_TYPE_KPROBE && prog->aux->sleepable &&
>> !is_uprobe)
>>                  /* only uprobe programs are allowed to be sleepable */
>>                  return -EINVAL;
>>
>> So I suggest to add a comment and remove the above 'kprobe' from error
>> message.
> 
> ok, is comment below ok?

Thanks! Sounds good to me.

> 
> jirka
> 
> 
> ---
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa4c911603e9..ca7db2ce70b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16743,6 +16743,23 @@ BTF_ID(func, rcu_read_unlock_strict)
>   #endif
>   BTF_SET_END(btf_id_deny)
>   
> +static bool can_be_sleepable(struct bpf_prog *prog)
> +{
> +	if (prog->type == BPF_PROG_TYPE_TRACING) {
> +		switch (prog->expected_attach_type) {
> +		case BPF_TRACE_FENTRY:
> +		case BPF_TRACE_FEXIT:
> +		case BPF_MODIFY_RETURN:
> +		case BPF_TRACE_ITER:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +	return prog->type == BPF_PROG_TYPE_LSM ||
> +	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
> +}
> +
>   static int check_attach_btf_id(struct bpf_verifier_env *env)
>   {
>   	struct bpf_prog *prog = env->prog;
> @@ -16761,9 +16778,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>   		return -EINVAL;
>   	}
>   
> -	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> -	    prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
> +	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
> +		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
>   		return -EINVAL;
>   	}
>   
