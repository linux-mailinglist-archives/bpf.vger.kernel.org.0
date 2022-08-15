Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A145931BD
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiHOP0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHOPZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:25:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92113F99
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 08:25:57 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FEpre8005028;
        Mon, 15 Aug 2022 08:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=e2UdSdDnO7Vdjth2b3LvVdkUZqlH1zXfJdiDw7Bmk6Y=;
 b=YNX7AzoOtqfXkyzTcrHcqrTU6XMXRQ4OIVax3OnfRjvimsdZKIqArlXluPHwq+T39FmK
 4oXEu7f3M5uM2Jf8xP2ENKXtORlUtK4NByQIs4Olb6xrPWY5kjvKRelbo257/jGQ/Tov
 9hest5l8CU86rt+s3xDGueeOXCrY7X1x/Dg= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hyr9dg8hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 08:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhhPNMeykcEwxzCYYH/fk6LrO05asXpEdkRTlF0IEFi1o2V4r+xj1Wz998rvyhDlpr9cTKXdq7SdWgcMWSEzrM7i36msUFQTp88xAibdzSjuSKrj1Jur8MGSNHJhuSKTwbxCA2dT7/WtW+e8n+MaV+3QgKikAxGuglNzpGqgeScCfbaCpYo0XsErxNdmpnkP6I+BsIwoSOzhQOrbO5Zu9DzXkYbETrOE8ia7lEflXSayrvyDd7oc+CHpN7uJlEmOFeD6BMHWctK1TnjpKKQRPSRDMk1YYEovwF276n3V1SyqyXUTcXe6mvzR3fXi4JlY6nZcjQOkB6RuSrCyW4zpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2UdSdDnO7Vdjth2b3LvVdkUZqlH1zXfJdiDw7Bmk6Y=;
 b=ETT1+fDBohQi6i0atihUgW5YszCeAggc/aHQo9ggyJCHI0LGOiLN/t7IlsfWxhAAcScyd0vilhZ7oaGZvNcc90iv6tennBejCGIeu+9fUaoT5v1p/XGclMGIjG9aZDMtwEiTP1Ie1f5LOJCFW+n7G+hcHz/d+Mv33YFv6Tq2SG4UXy0pZdHYXFjEQm2MqY905ZWiXzZNQ7X4Px7Y0puB2iA0Pf3aQSAt9eClCSSvKMxoNgnC6MgszgmkCSjUahIUIAvZltBmGx2rRbRkDOObOJaFjj/proACb3d9k1VzD9FtbSYbW8RKBKRQbD40vQNeoq58QsVpyQlboadvybjbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 15:25:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Mon, 15 Aug 2022
 15:25:40 +0000
Message-ID: <6ed1689c-1d59-1683-485d-31200ea7f0a6@fb.com>
Date:   Mon, 15 Aug 2022 08:25:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com> <YvlZ+ETaaTD3hwrM@krava>
 <ddc5550d-b820-6975-a4dc-53e3656a66d0@fb.com> <Yvn1vWwU/TMGHjRo@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yvn1vWwU/TMGHjRo@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6230c5e-2ab0-4695-feb0-08da7ed26978
X-MS-TrafficTypeDiagnostic: SA1PR15MB5078:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OossFGtVgvbYO41fwuuL6W44Ck1Pdp0qN47DVBRJVXEZghYoGzG74KHKwubrQq1F7uK3TlxzSVoUNjA2VgHXuPGW1jNs3Vsw9TfxzY5c6OGMTvHXs+H2Iotvp6uOpdxQVS9us1sQFBWvQlV+mVGPCdXJxXXpqkrY9oKNC7IB7rB+QBbUuy0D7oxkWezU6sbBXWD43d2xFrfp69q+lrJyDvWaQimkxbEVs2kV9jmN3hC6/a6MLt5m6D/010B0YLdXO8WKUxz+KggYO91Gwpz+gLTtLbfIykLYYrjdAiKmDTTHlOKqvKXKuHCKEdPHmOKpuUaufVlAQLRp6JyojG/1HqqYobn7ex3ZnjR7xgi/hsv4+b752bKo3H0iP6lNo8xFhSi9hHNyvl0Tag5Qn6AsTOmiWD00pScD8nZCvL07jb5dzAF8HjMoQOxpa/Y8Cx1D57EcSJvmhj2UqR1pTP/7rFmAKyV/JRHf3ZJNJjfjtBcEZgmE4sZ/d0LVhihUH1doJtWIaakoeUHC/njWEw8TMvUV+B5XHbwHSQ64tvanr74FGs+Fc9pGdB2W6B81LapnmbJ25exShQl0sJpZ4GTx7c6VNuhtZBh9k1C8RxuXdDGZMyZUqpJbwwKZcKPJI2mOMCCi15dHGAVf8NdiMHvljr9jv3v94tcD6vyXah7vnzy38IDrG4alVnlj+GJkPt5w9UdjTKssGv7HTRjbqUaE8gbWs28nWhw6Pv13ATCWOPqeWJ0s03vQ87LndX3iMOIsntIg2+SYQqjnXZPJo/QNX9iT6kgbcIsptaW6LxMI7bhH5lOieXZjW6lMo9/TqieWI3MqcAo0lpHYcu6Lumwiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(316002)(66476007)(4326008)(66556008)(54906003)(66946007)(8936002)(38100700002)(2906002)(6916009)(5660300002)(31686004)(86362001)(186003)(41300700001)(31696002)(6486002)(6506007)(36756003)(6512007)(53546011)(83380400001)(2616005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVjcTc0N2FDN0lGcm56UmllN0pUUTNsOXBodXdMc2NnTUNGb1BtVWMvQUVS?=
 =?utf-8?B?SEp1UExMSFFEaDN6UFFvTmhLVzlNVzhKV2cvQ3BRaVdlN0NkTEJmNXhqNEQx?=
 =?utf-8?B?eFFqdEJ5WFdEL3VLZnpKUEJZL3BYWlZXa1RRbHNhSmVsVWNaL2xLYjArRlBC?=
 =?utf-8?B?d3VVVVorUTdyL1pDaSttL01CVzdpTUl5eERBcHF2cnJhVEowY2NMU3hTMnQ1?=
 =?utf-8?B?ay9tQm9NeWNxZ0kxUUxUTUlzRHFHT0oxR1FYbmo2SHdnM2tXQ1JYWGhCR0p6?=
 =?utf-8?B?WldmWmhka0pndzBIWEhtNGl2TjBuekVTUk15NzlxYkplVG1VWWpFTjduYTI0?=
 =?utf-8?B?WHp6V1ZFR2xGOU1IN1hDUWMxaXUxNlNLTGJJUitkY1JIUzBYd1V6Zm43TTJk?=
 =?utf-8?B?U2NjSlY5cU5hajhjTzZLTldzeHdqNkRuZmlBSE9TaGRNc1NmdktYRXFZaWdF?=
 =?utf-8?B?RzRLMTJmQWlhOU0wZ2I1YzBocFZpRWpWeGtybXdtRXpRQlcyRElZWFA4TTZi?=
 =?utf-8?B?RnVMUnFBOUNPSWJSTWIwRVhCeVQwS3FtOVhXWXJiK1pYWklBelZnalRNN2Uz?=
 =?utf-8?B?UEYrK2lnVUpvV05Hb2ZVekdLUTlvQXdtM2ZmZm03b0hLbGJoMWJ2a2NPYmpH?=
 =?utf-8?B?VjdFaWFLSkpMT1dpN3U0VzhqUVIyaXRZYnlIdEc2N00yemdzbEZyTnJXU0l2?=
 =?utf-8?B?TkdUQjVMejVhNGZxeW1OOVBEUFQ3RWtQYVBUdXVzQVNja3NOc3M0K2dMRWN5?=
 =?utf-8?B?b25nVldnb0MyOEdqY216VXJDRGtaaENQRy9lZzBsY3hjd3kzNnpZKzZzZ2Z6?=
 =?utf-8?B?ajRrM1VqS1BiL3NKeFZpam9ycGR4QTZZeldHenJUZmtKa1dOamtwWFQ5N2FC?=
 =?utf-8?B?bE9nMzVpcXI4Ry9UT2trb3h6YlpTTk5kL1dWNGkvQ3daZ0JOMHQvV3pBWFEz?=
 =?utf-8?B?YTJYZzJjRFUxYlNnelc1eXE4dHA4WWt0SmlqSUZoVmVVMXE2OGJia1ArSDdk?=
 =?utf-8?B?VEpWeHZJZWtSMDhnWkR3WWZCMmo5eFZyZnp3VXNUUFRQWitnNUFtWU1wTHJn?=
 =?utf-8?B?dWhsZFl2R1dHdjZGWFNYZHF4YkJybG54d0E2TFRSakl0SlZFTHlZYzI3dThk?=
 =?utf-8?B?Vjgza2xGZmJ4RkRXamtITkRsUnNHTUs1d0pnZHBTSk02R24wYVJCMCtKWFRm?=
 =?utf-8?B?MVhldVB4cUVQNFJYR3NUWUlDV09tTUh3VUFtRFN4dGQyL0kzRk1TY3U1andP?=
 =?utf-8?B?djkxWGhjWTRyNS9ZUElXaDRReHp3TmhoaytaSjJMa1Q4NVBzVlRTVTVzckpN?=
 =?utf-8?B?NXQ3ZVFWMzJKeC9WWnhDd2JFQnN6N3B2ZVBra3RxYXpLaUNGbnFEc3kvQmZC?=
 =?utf-8?B?N1FPUFNCcXlrS05LdHpkSmpMVEZUenpqRG9qUFpXYXVJSllFRWZucEZ5N2FR?=
 =?utf-8?B?SjhaWjJGQ3FTSTVaSlZQcThZL2dudlFrVFM1ekdjL1R5NUZtWDZKS0dhSmNk?=
 =?utf-8?B?UXV1WDlIbUQ5ZE5YOG1NN2tFaGd6RHhPTVFoY2x2VWtpVGo3M1lQOHF6bTNy?=
 =?utf-8?B?UG1jT3I2S1ByQ1N4TWJOekhhR0NWNVFhaGdoaWZPcHA2VHppOXVFczJsMnFh?=
 =?utf-8?B?K1ZjanM1OVIrN0JySlFPMzB3SlZpWGxObHJwQlBlVzNrNWMzeUxJeDJDMVAw?=
 =?utf-8?B?Y2VPVjIxa05vN2ZOQkVsd2s0QzVrdzR2dlYza3Y1Q2tsM2w4TlJGazJwRGp1?=
 =?utf-8?B?cmlydG1yRXR2T1puTVVXRkF0dlVrcElNVVJnNUNac3BjRTY1UHZXYkZKZUEr?=
 =?utf-8?B?NUM5OUtsRDc0S252Y3VpNkNwWDhDSVJ2amYzRnpLWkNUV2RrajdVL1NSQzNr?=
 =?utf-8?B?NE5IaFNXNENNcFFRb3hhVGlvbXd5cldaMHBoMGo3aGQ1bUdBOWROUHFkKzkx?=
 =?utf-8?B?MGxNKzdSUkZxUW9ldkpyRy90emFoVlFRWjRpSnNrNDBwUXpGSytLQ2N0WThW?=
 =?utf-8?B?KzJwUmN4ZFBxVUd3L2Y0RXd0MlRiMTNkSDZpKzN4RmV6akJscVQ1TXlFb08r?=
 =?utf-8?B?cUo1cDJteFFiZnN2YnlxWkRFUHRSRXlhWmhCcTRZQW9lOXFnN3BMRWpJQm8r?=
 =?utf-8?Q?4vTjQaCa73cc5aNXk+2oZT+jV?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6230c5e-2ab0-4695-feb0-08da7ed26978
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:25:40.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAsH79YFdKI1f60Iu3QQw/2eN+CUDvIlYfLIHGH9Ib0p+1GnH3pY7oepFVg5UA9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-Proofpoint-GUID: OOSlTpl6riot4FcbS6EXf6xOHQwUXK-1
X-Proofpoint-ORIG-GUID: OOSlTpl6riot4FcbS6EXf6xOHQwUXK-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
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



On 8/15/22 12:29 AM, Jiri Olsa wrote:
> On Sun, Aug 14, 2022 at 10:29:11PM -0700, Yonghong Song wrote:
>>
>>
>> On 8/14/22 1:24 PM, Jiri Olsa wrote:
>>> On Thu, Aug 11, 2022 at 10:24:35PM -0700, Yonghong Song wrote:
>>>
>>> SNIP
>>>
>>>>    }
>>>>    static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
>>>> @@ -2020,6 +2081,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>>>    	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>>>    	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>>>>    	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>>>> +	int struct_val_off, extra_nregs = 0;
>>>>    	u8 **branches = NULL;
>>>>    	u8 *prog;
>>>>    	bool save_ret;
>>>> @@ -2028,6 +2090,20 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>>>    	if (nr_args > 6)
>>>>    		return -ENOTSUPP;
>>>> +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
>>>> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
>>>> +			/* Only support up to 16 bytes struct which should keep
>>>> +			 * values in registers.
>>>> +			 */
>>>
>>> it seems that if the struct contains 'double' field, it's passed in
>>> SSE register, which we don't support is save/restore
>>
>> That is right.
>>
>>>
>>> we should probably check struct's BTF in btf_distill_func_proto and
>>> fail if we found anything else than regular regs types?
>>
>> The reason I didn't add float/double checking is that I didn't actually
>> find any float/double struct members in either vmlinux.h or in
>> arch/x86 directory. Could you help double check as well?
> 
> ok I checked on fedora's BTF and could not find any
> 
> still the check might be good or at least mention
> that in comment

I will mention in the comment. thanks!

> 
>>
>>>
>>>> +			if (m->arg_size[i] > 16)
>>>> +				return -ENOTSUPP;
>>>> +
>>>> +			extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
>>>> +		}
>>>> +	}
>>>> +	if (nr_args + extra_nregs > 6)
>>>
>>> should this value be minus the number of actually found struct arguments?
>>
>> In the above we have
>> 	extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
>> already did the 'minus' part.
> 
> there it is ;-) ok
> 
> jirka
> 
[...]
