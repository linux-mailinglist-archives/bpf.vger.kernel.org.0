Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF96E634C03
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiKWBHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiKWBHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:07:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B46DA4F2
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:07:16 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNVeN3010269;
        Tue, 22 Nov 2022 17:06:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XTEPq2ZyIr6xSKXFNrpGi1zCoJlTK5hlYgVqAM31G4E=;
 b=MhP2E5KQAmdJsoL1REQ3s7O1d5u5eLYQNJcliCaXAv9TeP0104aoQ9zh/4Z/J/ijN39O
 nrGq7HlxbgXprs3GfE/V+0zDFeZUj4lpaajSfEgBsRXv1uG1Mz/okd8toxb94fFlY4F7
 U5YWPBJIQTCBqKcUE72jXO8xvqgaN61sGsQsFlvU2g8snVxQdQp8bAIhRdmmwliYrHZs
 ntfXGsEZqvZM3ly1O7ryYSPBNHAFa4bE3rcTMPD6lmo6676cc1Rp17wUL996L+EQ9tsV
 GlxH2Wr+nju5hOh1M+U36GqNWlcH1XKBE7cSe1U65PgxE9GOd9/bn7WPujJJOU6yqHIW mw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0javh3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:06:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oaw1Nv4JQheh9iKJZaaUchzaG8RXVB7q0tc3GzyzLYDOKPMORThvD7xaeEGZtXtCO/3sOPuXHfiSIfEmIt+6utZep+XopdCvGMLepLlYGCvSwW5eJis3vFfD8Xt52pSKyqGIcHOmf1+tRNADkNY35DLqcC2ggJ5lSHwkbFwQ28R99RI5Utm66xfl/C9FsjqlTSLQSCjVTkKzLgVHsxvT3yjCkPch0eww53yb6BkWtrdhKiTp4hN8Obml8RrAqNvcKPsy+ki0GyRotgnTlppsTY7V3cDkmMSoqeepk9e1UvBc9ZW2+gC6EqSVJk8hDYvUB7m9238Z2esjapQl98b4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTEPq2ZyIr6xSKXFNrpGi1zCoJlTK5hlYgVqAM31G4E=;
 b=fic9tKnmmvl9rixth3YLG5I4TNGBra6On6UCMZLDlhXdvwp4Zdsn6XM7M82NUorfkns74G2YhIUnhJXV1d3Wy2atdDQJ++ZWpKzl67d/mv7a3SoINglK2VTOCU0nDBBiB0PelEBC/4fzW+S3+GzzGnBP7TpFmCtkZ3hmzSFukrUyZ1mDIY6ztPM2H0OzQjK+zRv2WVkmKwt5ixkskCTJja63DTwyy4++3SfuBuIoOeNqNzxFQXdsthBRpMRuj19j96kLlRIse3I3ZpyBie1zyYRfGqdtTE5bBDSienPMZVFt1PYygkoSbgxYzGz52OkAgfkxp/R200T4V5fKeG91yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3385.namprd15.prod.outlook.com (2603:10b6:5:164::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:06:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 01:06:56 +0000
Message-ID: <200910d3-23f2-e7e0-a03a-85d781d7341a@meta.com>
Date:   Tue, 22 Nov 2022 17:06:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195335.1782147-1-yhs@fb.com>
 <3ee3af12-0542-e33c-2e9b-c6838de6ba64@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <3ee3af12-0542-e33c-2e9b-c6838de6ba64@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3385:EE_
X-MS-Office365-Filtering-Correlation-Id: 7700e3d1-103c-4f83-3feb-08daccef0444
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYB9AVhbkN2rAM6bdJQS+lZb6k+EZToqLe4NU7dFdVVNJxgQz6THDSv+CpNlFi0FD/Mi0l+GfmMxw9qnMbKnn4Td6Ii8LQ1lCM7xSLSsUCdpDAF3cynX3tgds5pQQ+TWYMTCDLsn2WMSQ8oal33u+whB1Naa+jgIPF442RqKk+tbntzcPMinV0W/thI0qV6m6v9rOyvnO1q71yeZtn7ffQCbl6APQhJhGAnXq/+Zm3jX8sG9z8LRlq2nf5m12E3Jc05qt710JsAjhBqZFbl4/zNIVJOlcTuAiG6oA6baSbOWzAtq0GrVJhiYlkOFAiQPx4XIH5dyXJO2xCP6lSdOqODFIiVd9ToAw7kgtuvQFxSuCF1Dl7lOtLRrYpl6otyxTZVhtt2B3nh1Qn6HHdr58lVi7B7kq9s/M9hZhgn+yjjc+0/BLL6MEX/xdCOscQdeG7+qA2Gx9QX9VP/CESmHEMHermaVr5c8PSupb7Ua+9lAltFhCWvig5daQmfSEcl+/pk/TUMkppbyBRJwOELsN87sQEpKkjqQott+thTCBc3OnjKwF0080pKrbTxg/dFx2I24sHVbY15XF4G90A1kvytmnrs9Yn0VUoiFFuf4ap9mb4poA1D2fJuG4VHzjfylnoMOWrIBg+5k59DsAQNG73GZ4Pbemo9ivcSjKUicwMz4l6jYa9zCYIlojkAN+04mVZAh6iES2LgYLt2RXQQHtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(83380400001)(2906002)(31686004)(36756003)(41300700001)(66556008)(66946007)(66476007)(186003)(2616005)(86362001)(31696002)(53546011)(38100700002)(6506007)(110136005)(54906003)(5660300002)(4326008)(8676002)(8936002)(6512007)(316002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnV0RXVuV2NqVDh1Z1gwUzZHQVhidWRVdnhqRUZSZWQvS0lUSjJVQkFtRzNR?=
 =?utf-8?B?RlU4bzVnTmcvWVZSL1RCMGZNcEdUVXJZT0ZuQ3lvQ01rb2VGQzRNVmRZNHg5?=
 =?utf-8?B?cnk0blA0MGo0MkN2SGVJdTVaNlVWZ2c4QUNWWVN3a3FkTWFaK0xIOFB3VmtL?=
 =?utf-8?B?UEVSdWNuS2xCdkZhcHlqcnk2VGpocVJBZCtoZlg2eE15Y3lLWUczZW5nVDc5?=
 =?utf-8?B?cGVkS0JoczQ5SmxMQ3gwRFlsS011YkJkZVRjMzI0dkIxYnBGeENwUVloalps?=
 =?utf-8?B?UnluN05YM2V2OXZtcmRRV1QwdkNFbHJtd1FpSWQrK0NCa2E2K1RTeWhXdnU2?=
 =?utf-8?B?cEVLemVOQkg2Z1JCMkVmQ2RPV3cvbzBBSStZNjR5Y1M0Nk5KeUlwdUpLc3Bh?=
 =?utf-8?B?NXM5cVRUSmNCQXM0RXVkbDJ6QVphK3ZFb1ZzRzhGei9MaktqYkxTSlUzOVFR?=
 =?utf-8?B?SjlqRWF4a29Cd1NvU0M2LzVxNjkxdUpzc29YMDR6d3FlRm5xdVMxMWoxY2xk?=
 =?utf-8?B?dy9kV0JFQ3BCd3RDMFBjM2JCYTJHSTB2QWo1bTRYRjNmMEQ2ck5adEtNckFz?=
 =?utf-8?B?cXM1N3ZRTVVyYjBiZFg3VkdkVUhhdGJMWmU3NlFEdjZHMzRvT0lOc1AzdzBi?=
 =?utf-8?B?YityaVIwTzltdVZ1a0k5SXpaVTF1QXE1Y2JGd2FrZG0wZEFiZ1dKaDFTaHQw?=
 =?utf-8?B?TFptK1R5L2tnRTQxS1hkcHU1MFpSV2pqeTVrbThWZGpJQUI2cVlPdmY0UG52?=
 =?utf-8?B?SFZyRVJndjVQYnYzUWdpVlZrRjgxNzNLbTFWb2RlWU8wdDFETVRKNy9WUnJs?=
 =?utf-8?B?dkVOU1Fvc2ZmaTBkd3N6WGtNRzk2NWRGUzZjYzJjQzdaSlFvZ0RMSnYrblR6?=
 =?utf-8?B?Y2lLR1FtNjZaV0hnMWMza0M0Y0g2Vk9nWkoySTQ5YnlvcExrSzVGd1h2QVFu?=
 =?utf-8?B?azZ4M1V6OUtjSnNCekwzVVZZblYyNEgwcHdMa214c0VsVm5Ib3BWMmEydno4?=
 =?utf-8?B?UzFGWWVuS0NTYTUwQ0FKMjY4WVhjNmdkM2ZSQ1daUCtLbXpqNGgvUFJyNC9I?=
 =?utf-8?B?QmZoTzBIU2VaQzFjWlphOVgrdE5oUkNBVGp0WEpZaHNia3VRTXluWDlmVWJ0?=
 =?utf-8?B?MElNUGRXVm51aGlTRW9scjAvRFBkeEhaRGVHdXY3RzlOSExJK2g4UGZxdlls?=
 =?utf-8?B?Y3pvUGtkZ0t0TzUxS1Mzdkp6RXc2RjF0WWxVOVM4Vm92RnBvQjVPQWhRN2M1?=
 =?utf-8?B?Mi8xVk8wNGJNN2xDQlgybSszL3ljTVhCRUpTY0lrV2xFOWFqU2lEbk85ZUlr?=
 =?utf-8?B?eElncm1lS0lMZldGMUZxaHpBTkVDWndFUFRyM0hId09nYWFuZTR5OVRwMVFM?=
 =?utf-8?B?UndNYkdTMWhmak9jMU5LL09wOVZoNWtkbXRqejVkTUlaeUJDQmV4MS8xeDZu?=
 =?utf-8?B?YXo2N3RKYlNKVmt3T0c3NUM0dUYxOWNLOTBJUEMrWjhDSCtPR3ptQ1NBVGxv?=
 =?utf-8?B?Y3NBUEUrYUFjVFBoZW1MdmR2TnFXdThnSDltVENDSXAyWTJ3ZUdZTkg4UWl1?=
 =?utf-8?B?VXIrUDZ1ZWtBTFFYYUYrQUtkM2s5OWpXUHg4VHNEcURDZkZPWmdtb3o1TlJL?=
 =?utf-8?B?aFVlYys0SDNZc1VIblY2anM3c0hCb25CeDJJM1hFbFI4MUFnYkgrR24rSjd6?=
 =?utf-8?B?VVdqQ1ByMDNjWUxkK3M4Y1lmbWpoamcrUlFvL3dOV1Q0b1I2UHJqMjVacWl5?=
 =?utf-8?B?UTA3QkkvOElGeVA0TXE2ck9ObDFVV28yTUFwTkxtaVR4YmxNaEFuaHlGUEdx?=
 =?utf-8?B?a0VpY2FLSVF5NHc0VXVCMnRhTWF2U0F3bVd6MnNPc0gyQytMUlhzaFhEWkdZ?=
 =?utf-8?B?U1YyenJTMU9pQWRzb0VHNXBnMEpyUWRwS2JseTNONlNZNGkxRCtQN1o2RlA2?=
 =?utf-8?B?NUJaVzY3Tlk4OU1rSnhySFd4VEFRUlNiWFphWW9LMURKNW1IV24zSzF3L0RS?=
 =?utf-8?B?RjgrWjY5b1ZxMWRqSzFzWkcvRnlGRC9aNjRwMStSb2ZPMW03L3lycmVOcWJw?=
 =?utf-8?B?VjFEelM4bW1iWjc3ZHlXN2xUWjlkT0tXbSt6Z3B0UWRacEtXMStEQUZMdXd2?=
 =?utf-8?B?OHZQVW5kbzYrMlZ4WTlmSDhLSFhvWU9zMzZPR3R4eHRvREEwdWVUZVVHalpw?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7700e3d1-103c-4f83-3feb-08daccef0444
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:06:56.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85A0h/2t6SwDTTj+oqFQJqZsJOOVzFpmoYBhhb601yD+gtzErQ0q1iJEIgDQrY8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3385
X-Proofpoint-ORIG-GUID: deOsvHs7Jx50r_CVpKHJNhyzEbxpxU8N
X-Proofpoint-GUID: deOsvHs7Jx50r_CVpKHJNhyzEbxpxU8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/22 4:24 PM, Martin KaFai Lau wrote:
> On 11/22/22 11:53 AM, Yonghong Song wrote:
>> +    if (flag & MEM_RCU) {
>> +        /* Mark value register as MEM_RCU only if it is protected by
>> +         * bpf_rcu_read_lock() and the ptr reg is trusted 
>> (PTR_TRUSTED or
>> +         * ref_obj_id != 0). MEM_RCU itself can already indicate
>> +         * trustedness inside the rcu read lock region. But Mark it
>> +         * as PTR_TRUSTED as well similar to MEM_ALLOC.
>> +         */
>> +        if (!env->cur_state->active_rcu_lock ||
>> +            (!(reg->type & PTR_TRUSTED) && !reg->ref_obj_id))
> 
> Can is_trusted_reg() be reused or MEM_ALLOC is not applicable here?

Currently MEM_ALLOC is returned by bpf_obj_new() which takes prog btf.
currently MEM_RCU is only enabled with btf_struct_access() for
vmlinux btf. So if MEM_ALLOC is in reg->type, then MEM_RCU
should not appear.

But I guess we could still use is_trusted_reg() here since it
does cover the use case here.

> 
>> +            flag &= ~MEM_RCU;
>> +        else
>> +            flag |= PTR_TRUSTED;
>> +    } else if (reg->type & MEM_RCU) {
>> +        /* ptr (reg) is marked as MEM_RCU, but value reg is not 
>> marked as MEM_RCU.
>> +         * Mark the value reg as PTR_UNTRUSTED conservatively.
>> +         */
>> +        flag |= PTR_UNTRUSTED;
> 
> Should PTR_UNTRUSTED tagging be limited to ret == PTR_TO_BTF_ID instead 
> of tagging SCALAR also?

We should be okay here. flag is a local variable. It is used in
below function when reg_type is not SCALAR_VALUE.

static void mark_btf_ld_reg(struct bpf_verifier_env *env,
                             struct bpf_reg_state *regs, u32 regno,
                             enum bpf_reg_type reg_type,
                             struct btf *btf, u32 btf_id,
                             enum bpf_type_flag flag)
{
         if (reg_type == SCALAR_VALUE) {
                 mark_reg_unknown(env, regs, regno);
                 return;
         }
         mark_reg_known_zero(env, regs, regno);
         regs[regno].type = PTR_TO_BTF_ID | flag;
         regs[regno].btf = btf;
         regs[regno].btf_id = btf_id;
}

> 
> [ ... ]
> 
>> @@ -11754,6 +11840,11 @@ static int check_ld_abs(struct 
>> bpf_verifier_env *env, struct bpf_insn *insn)
>>           return -EINVAL;
>>       }
>> +    if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
> 
> I don't know the details about ld_abs :).  Why sleepable check is needed 
> here?

Do we still care about ld_abs??

Actually I added this since spin_lock excludes this. But taking a deep
look at the function convert_bpf_ld_abs, it is converted to a bunch of
bpf insns and bpf_skb_load_helper_{8,16,32}() which eventually calls
skb_copy_bits(). Checking skb_copy_bits(), it seems the function is not 
sleepable. Will remove this in the next revision.

> 
> Others lgtm.
