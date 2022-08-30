Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A096D5A6931
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH3RDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiH3RDY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 13:03:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128F9FCB
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:03:22 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UFrTre007652;
        Tue, 30 Aug 2022 10:03:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=caxYI/xPr0G6ml87zTYfjabGvUxXQ7wNTgCduAHFR78=;
 b=Dqwfty+CNUWirGwz8wNoruQIGdyNXXwfvX71Cm/jssjeyFwFvkY7bRSizBaTMpwJMeuY
 Ipaun6vR+kHK2l0HTrw7jku+M+XZk2pXQ76YvZwX1iJIPfeA3jb7xuR3VUctS6bJCIq3
 mSdPdnq2AmFdxTy9ofYTZdgndgXhDJ35oPI= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9yk0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 10:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkK8hlZ+emPpTYsmNLBJ7nU+frsGe7PkPMip0bml2tmGNd68J59IZiVhNIOaQX2Z+rH1fBrebAF+E/3zj/Jz7bi1/Jry852JDWX4c4WB+e03gdpvgFZ3fHsOqrC1ZaYDiUwtW1TJiahMTPPSW0+XObJpMibc/cxrPZYV00it16MaEGmyF/PlxDC3hp0RgT0v1Tq7gIetPpuUthmlraoyg7EpOmH1OCiX17/iwZAmXE3DAm76hM4a3/8EFlk9z+ZVF/xLH8vvmu8jLLkh8EgOKEPJxnY+i2XwbL2bMYCZwLqZDgLF5aUAwOB3tMJav83Bn0vMsTM5iYJ0icSU/7IDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caxYI/xPr0G6ml87zTYfjabGvUxXQ7wNTgCduAHFR78=;
 b=VkblyiAXl+IRJiJaBD72F6+zYEfn5sP+uQkhWNCyxjeEp9r2X8DuhqX4Rk1Qyu6o2wCjkr6wv/cYMAPVc5yhPNZ3QI7JcxXzbaYsHTPRRt57fwBuUb/AXD/ffEtsUHlTiplVDOn5ObYhkLLLaf1z4+wzhtjuhgUHQeO+P7gD+UVGtr7Fj5u6bFwf4iL37dTvVZCjD6miAE5MozZ0l+MpW6QoHKWPGjSfgH7OJbk7qd3oYKJ4n39ntnDntgX3D6ggMfaz0ZXxxbt9LVPsqUzZ8MpRUVEel3ubg1SSw5lIz/ygS9HtMoa9yL2sIbEI7+4KeJf2deCCavOZgGic41Lxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5247.namprd15.prod.outlook.com (2603:10b6:a03:42b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 17:03:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 17:03:05 +0000
Message-ID: <0f254eba-e178-ecfb-c862-7bab26e8e87e@fb.com>
Date:   Tue, 30 Aug 2022 10:03:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Allow struct argument in trampoline
 based programs
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025443.143456-1-yhs@fb.com> <Yw3+XcnFkT16Z3dx@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yw3+XcnFkT16Z3dx@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: facc6990-78bb-43b0-6ce1-08da8aa98171
X-MS-TrafficTypeDiagnostic: SJ0PR15MB5247:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYW8Uy1TjfMlBTQQB/fv+20zsmZ24NKh/pzxTC3qhhmF3TgDrQctXtqZYVuQDp8bluBbMwg2DvePQRbk/4epZG1zbhM8oQ6UWN4lWHuErU90tTqsadPfn/7o+v+ZARpF9x5AyUhQJjuRYCslJVWcHnrQ6ViUu6n+JU+TSIDFcV6JHrBtEpXPRuoiYTn2SA4fl9lmEE+sCdyjurIf4KVgULPsTzkkgAje0PcbOPy/fA6la8O64f63ltg9nCjLsmA2zHGtnpn+HHVDY4+hgZkhLezxqE4PBtPP74FMftOxE59T6wWFkazm0r+Zt8an1vmkJvWUEpszBgMGKqEkha6/qKt8girMOEh7t7srs11olV1bKnJQaJdXYlz4ZRLrqX0R60hRu9Dq1w3L/6O/DYZZ6dcwUMD5FihcQjHLz7vsghTdH4AMMycFYQIJbYWAolRqiaf+iNGwtiGUoUKyTtMUV7RGn/YeDW/qna2se+IoGSzkLhLMHa9aDNH6AffhnLphv1nWYDe6y9xfHTmdyNHvYSb4qvVP36p9KkqZnPZp8ZdfMR2h3At4vITG3Pe9isBQHkvGvkQ7QBunuA6m2lwgwQC8mLvspyjdSszgYd8AUP3X4i+ruSbq70RAsZzPQB8yrlLXPHLGfW2iAWa4Gg6snraiDsa0mgbjOmMROOpQNdCIYqeqEDSSkdkVpm04VpsC2ooHp+O5/EivHmgusuz5rDPcqqmRxxarT1vNyYb4p7LB89eenv9zzyYNET+J/PS7m1sMbNQckQxscSskIz8sgtcOebHh8JDih2A3q+EktCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(186003)(53546011)(36756003)(41300700001)(6506007)(31696002)(86362001)(2616005)(31686004)(478600001)(83380400001)(5660300002)(38100700002)(66946007)(6916009)(8676002)(4326008)(316002)(6512007)(6486002)(66556008)(66476007)(54906003)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5WNEFrbEpjNnlXcWpGOWJKcklzUStEcWo2YW1FZXRYM3lnWFRlM0o5SjBw?=
 =?utf-8?B?KzMvbmk4R0hWLzhsZkJrWjE0QzBaK2U5eWZxc1J0dXdXTjBNWmh5WGk0RFYx?=
 =?utf-8?B?R0hEeGpWaEJyOVAzSC9QSHVEZnBhekVaUkV5V3RSYjhnTVp5K0ZjMzVrTWtN?=
 =?utf-8?B?QVF1OU1vMHJpci9PaG5DM2FuZ3k1TS9nY0V0Qmc5aWhjak1Id3h2eURObnRZ?=
 =?utf-8?B?MGpCbjdMcnVtSDJOaHNMS3AyRkRYT1krQnNJWDEwaEhqTkVEajNMQVR3Ymp4?=
 =?utf-8?B?T2J5TnQvZ3QzM1UrVldoNU1UR0N5V3lsOHVPby9VNDAyL0RUQjhmNThkMDNl?=
 =?utf-8?B?eDl5UXNqTit2OTM5ck03eVRId2xNSm95ZDBUY3hndXFUaFlMSHlTdTlnT1dR?=
 =?utf-8?B?ZXNSbVBrck1FYmdBRk1uNFp0MGZYQXpEZlkyd2ZkY3B6Tmc5a05vWjVwbjh0?=
 =?utf-8?B?dHlYUFpkSDFDWTFtYmo5aGRLcE15N0kyRmJGckg4UFBKdTVraUNvQVcrbGJG?=
 =?utf-8?B?TUVtU3ZEOUtyR2FnZzc4TEsyT001ciswOU5POWJ3dVk0QVE4b2w2bnhRb3U5?=
 =?utf-8?B?OCt4cEpBR1F1N0Yya0d0RWZSWmJ0TWFOVGR2bFdwNlJHOEo3c2cyOVRmTk15?=
 =?utf-8?B?b1E5ZTU5Z0JJWjBlZHhOY0p2MFN4NW1xWnJZVmYwZXpzeTJKUnNEcHZ4Q0xE?=
 =?utf-8?B?Z3hLWVdIOEJYaEo1R2QyT1I5aFIvcE5DL3BKVTlMWGtZYnZmQTBPOTNlSGw2?=
 =?utf-8?B?WXdNb1d6aUpLMWhlc0kvR3J2cG40RFVRL05FaDcwc0F0V3RyS1pzQUpXcUp5?=
 =?utf-8?B?dmtJVVV0QUFDcEYrMmx2Rjg1RnpRQVNaY0F1S1V3NWt0eGpMaHRlVUwxTUdk?=
 =?utf-8?B?ZVJ4OFRDSUtrOXpOK25DYjNmWllCdnlLTXorUFQrMWN3WmRLeEQ0MDZLRytL?=
 =?utf-8?B?dzQzeVNMWDBBSXBrMlA2Ym9aR1ZPRkFmTU13SFgyclQ1TGxjSUxPMFNRQ3Mx?=
 =?utf-8?B?aUxxSkZJd3preWVBYWttZ2tMRkozY2JvYm5XR1J4eU95QStnNWNoK085aWtk?=
 =?utf-8?B?RTNudUZiNUdnN0NHYk9yUEhVcUdSWWZxckozY1FZaUR0aVpGVE9rSGpneS9i?=
 =?utf-8?B?Tk53UDlCOUxycXBWWHZVS3pSaHlNak5uWWRLbjdvaEs1Y0dwNDlGM1REZU16?=
 =?utf-8?B?YXZ4V0tPbWhPanNTV1pKNnB0cVlKNmxYdzZQNG9lNnU4eFNSL0YvQmlETXF2?=
 =?utf-8?B?YWhUNXVoOWxEU1duM2tUQUJsRTlqYzlZK25KYlo0ajlnSlNxQm5oN3VrRGVq?=
 =?utf-8?B?NUw4TWpNa21YeVdEd3NRRFNPN0hqMkNJTkNJVHdmbkdUS29NMXZsY0RSaTFX?=
 =?utf-8?B?bytTb0NkcHJjTnQ5eTNaUE1PT01GUHVYWnI1NXMzVHhXWjlUcDFHN3Y5cmJ3?=
 =?utf-8?B?ZUNvbndtUEJuWkovVFA2TlJELy8wSTJ2Y3dYQ3ZDR2VaUjNVL2ZaNmZsN1pj?=
 =?utf-8?B?NG1aNGNSZkRJMmw0NnJ3UDh0VWNrQUJhNXNIL0JyV2hTOTg5RFFQdlgyVjYy?=
 =?utf-8?B?MUk2VU04N2F3OU9YR3BxQ0U2cDQ0c0lDSWFnTVo1WER6c1MzNDI5S2p6MzFQ?=
 =?utf-8?B?L2dnQ2E3aUFUbnhjYWdMdVJHQ1lnREh3Z2p3TVh3V00rSVVVR0FkbW5QZXBw?=
 =?utf-8?B?WVpYK3JJeVZWaitXL0wybXEzR09CdGprQUwvWnh2Z3l5cEFyK0N2SVBvUmZ6?=
 =?utf-8?B?MUlxallweVgzRDdXeVROZUFYRG9oVDlrSFNEUWswdk81WncvQjdLR2pPYmJN?=
 =?utf-8?B?SUMwVjNKMGNDR2FsS1U1d3pVSVRFOXROSVJ3dFp0d04xM3dvWW4vRDlkYXg2?=
 =?utf-8?B?WHhsVEtxMmRQNFZtQVY3NzZCZmljT05sZmtSeEdHZk51dG96b1N2cWRqbkZl?=
 =?utf-8?B?YkFGd3NrZXI0SmlXQXFPSlYwM1BYT011UGF3TGlhaUVDZTdpR1UzS1hsYSt6?=
 =?utf-8?B?TnRHWUQxREFPTUZJWjFTamY0cWxUYVZPQ0RScytjWmNIc210a09kTW1WNDNa?=
 =?utf-8?B?TkdQbGtRUEtXeFZqVEd4a2RXbTlqUkRGZitiVm01WmpDUVpiWm4ySktCdEJL?=
 =?utf-8?B?ODlIdGZnOGE5dGFFS2R3T29idkJYZGZ3UkxHdGZhTWVreVFYNWNtaThic0l1?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facc6990-78bb-43b0-6ce1-08da8aa98171
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 17:03:05.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgBvReqn68X05UD7kmFJSa1a5Dr+jTDwroukIEr0XOfISFxE+Hc/LdEsLhT/Ndwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5247
X-Proofpoint-ORIG-GUID: CMrwtwnFew1YonKV1YHa2_9MQOR--Ce9
X-Proofpoint-GUID: CMrwtwnFew1YonKV1YHa2_9MQOR--Ce9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/30/22 5:11 AM, Jiri Olsa wrote:
> On Sat, Aug 27, 2022 at 07:54:43PM -0700, Yonghong Song wrote:
> 
> SNIP
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 903719b89238..4a081bfb4c8a 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5328,6 +5328,31 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>>   	return btf_type_is_int(t);
>>   }
>>   
>> +static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
>> +			   int off)
>> +{
>> +	const struct btf_param *args;
>> +	const struct btf_type *t;
>> +	u32 offset = 0, nr_args;
>> +	int i;
>> +
>> +	nr_args = btf_type_vlen(func_proto);
>> +	args = (const struct btf_param *)(func_proto + 1);
>> +	for (i = 0; i < nr_args; i++) {
>> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>> +		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
>> +		if (off < offset)
>> +			return i;
>> +	}
>> +
>> +	t = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +	offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
>> +	if (off < offset)
>> +		return nr_args;
>> +
>> +	return nr_args + 1;
>> +}
>> +
>>   bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>   		    const struct bpf_prog *prog,
>>   		    struct bpf_insn_access_aux *info)
>> @@ -5347,7 +5372,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>   			tname, off);
>>   		return false;
>>   	}
>> -	arg = off / 8;
>> +	arg = t == NULL ? (off / 8) :  get_ctx_arg_idx(btf, t, off);
> 
> is the t == NULL check needed? we relied on t being defined later in the code

t is defined earlier in
    const struct btf_type *t = prog->aux->attach_func_proto;
so we should be fine.

I guess I will fold
	if (!t)
		return off / 8;
inside get_ctx_arg_idx() to make interface cleaner.
Will do this in the next revision.

> 
> jirka
> 
>>   	args = (const struct btf_param *)(t + 1);
>>   	/* if (t == NULL) Fall back to default BPF prog with
>>   	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
>> @@ -5417,7 +5442,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>>   	/* skip modifiers */
>>   	while (btf_type_is_modifier(t))
>>   		t = btf_type_by_id(btf, t->type);
>> -	if (btf_type_is_small_int(t) || btf_is_any_enum(t))
>> +	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>>   		/* accessing a scalar */
>>   		return true;
>>   	if (!btf_type_is_ptr(t)) {
>> @@ -5881,7 +5906,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
>>   	if (btf_type_is_ptr(t))
>>   		/* kernel size of pointer. Not BPF's size of pointer*/
>>   		return sizeof(void *);
>> -	if (btf_type_is_int(t) || btf_is_any_enum(t))
>> +	if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>>   		return t->size;
>>   	return -EINVAL;
> 
> SNIP
