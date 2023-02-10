Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696056919F5
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 09:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBJI0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 03:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBJIZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 03:25:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336E23669
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 00:25:58 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A70Mx1012935;
        Fri, 10 Feb 2023 00:25:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=O1iUbIop9jCFcy543DgED2DZiGWq6AOTPfanY9hvhm4=;
 b=b0bX+IV+SWi49165ESHo1ewLzJk7wLdJb0S+lS9nlcw2/gLKMOFThp9ipBqzBWiXZQ1f
 IwpL+UxWQvCCs3c+T+OE9rPCDSk6XVTc1BJGdvkXDEjWygX0qU4xMHk7kY06O9sX6PCM
 TZ83864HvsIBaxE3ljq/WDh5hZJSFlO7n+qE0tBgW4/2p7Fm0EE61pEamF/SGyqdcN8k
 vH4Rk2zK3oNdfqtqz96Q014HtNRx+8heW6HL0XirBo6uVWYH63QOTjV/lQr8/+eSHaSf
 KwyGe5/Oa6SMK9Lyx71ddMjZsn2/60Ufdxt50rUwYBtjrwNVkbNNtYta5C4lSx32iLb8 bw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn0xf6xn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHM+/i7IcZWaTLbCQ2WoqgBfHO3G35Byua2iBEuj4oHVTO2hXeqat1dTs/jMDy+Ucc9LpwyrKNgKB/2qKE+mITJg1uYvmnlrZVVql2p4ZCCaAniBEYYu4TWqi8HAYn/63ERuOXlS7lPBSK1D9HZa1IJGmNYXz+N9nShtqzEt7UxdwlY2PRxV0ZLrNhyPWwt7i7lL9xo+cYM0kQXsRp0cVfzyzxINIuX8HhazzAdnmR+QkV7L1JULA9191vZ+xxnoWk+RaNgZMfwXZ6YpioEfQcQfBKAv7P8S0JMQPzvnYeg0or/lT2MFqQ6gM5jxOE1T++cBlzrzq6lcmgd5Bk+tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1iUbIop9jCFcy543DgED2DZiGWq6AOTPfanY9hvhm4=;
 b=K4dv+PSFBH4345vwbw7YCkgEhnpl8YSaED1/qwfqDGSNjk6ZdWRbCHRtVbTvjrrvmNn7cVVlnMWZ64Edh3+RWndGBPtTbyxau3w0gSPbiPPN/RLqCRwwWJkIiQ9CvA0ccSY6PwsnG6ElheLg9Fbb/yCJsK80I+ffT8UC7yXGkANfbknjDsYau99O1ZDVkNNwG5XMndUtfBWJIi2wUVnPw9lNSNlHrHHz0RpqSfn9PmykaOPbRAnCL0gQx3mdZIjnMyWJSakCyBUE0Qa/7FugFn3B+SwMevjjX/li5fyLrfVxyFX8TW05eo1ag8aRjuJSRAapOK/HbKdUWPY3yhT88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by MW4PR15MB4561.namprd15.prod.outlook.com (2603:10b6:303:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 08:25:39 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::2d1e:2330:470c:28bd%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 08:25:38 +0000
Message-ID: <87fff67e-6f94-e516-28d0-0fe973f61f0e@meta.com>
Date:   Fri, 10 Feb 2023 03:22:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0052.namprd20.prod.outlook.com
 (2603:10b6:208:235::21) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|MW4PR15MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c387340-056d-4a18-964c-08db0b406405
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Vxkp199PTGVRz9QKUfKTfG4br2MEEaSZ92icgzd+yeWDv+zJv7EjkbgQfdV6dMYMqbpUjiO+fmA0YrSqPdRg3UP0IHJ2WVrVCeB4s+PID98R6UhyEvsHqBDZZBEHFdR7IAsuiobVca1qLzp5AGHR5wKJGl6R6cdb5y3CQuIBD2ap1DSXZZ4my4JytkSPbnhSDmhJTG+fij19V9gdNstWXFsjyQ7RTtucFseQadDiVEc4ExujwrgEL3+dgROZxmym+AMMBM4bbRyCQQ2P5S0ehSpon/MWXSTOubnSG9XWO0vdoNplfy2qFgX90eMdXXI2NN59uqOSkzjmBfAx3X7wYPjPQXq982IwIBlWRcUJfG63QnU4WetIixCG7MhvADDDcfg6KGSWuyItJBSgAcl2MCBtrz5qetgMC3AnJshbbVXWkYX38z85PbXRehm8UOIpFQgvNAdn4JEB78YF4bfRducY3lmnzRSvp7cdt6AnsePlLF3lODNZHy2xud4+DGwknTDp7J6NkoPdbldwhvzo0exXtEE6iJHls6yW2yheiowLIbzJSvfrszYzJ7/l3x1WcIcMnbDn/+VN7ikjqVj/+0LvoO/eoCWO3aERbzfWOSipIzADodViCTSohsJkuioRbBXkaBuRGenrfVpS05MZDQusl1r1Bhl0ag8X69lCkSgrkMaa2EIWnmFxSpbb8N6YB/MERlwrn4aQ62REDayCK6lmOZKLDnQL+wEF2iueqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(5660300002)(38100700002)(36756003)(41300700001)(31696002)(31686004)(86362001)(2616005)(2906002)(83380400001)(186003)(8936002)(6506007)(110136005)(6512007)(53546011)(6666004)(316002)(66556008)(54906003)(478600001)(4326008)(8676002)(66476007)(6486002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdOZklhcEpvNXhwRWtCMUh3K3hWV3dzUFpMUUpwLzZWWnA3b1hrV2ZKT3Jj?=
 =?utf-8?B?MkpVL2p2bXFXS0ZlS2FvQUJQNE9OTHVyeHd6Um9IVHQ4OWIxeFQ2cFdFSnB0?=
 =?utf-8?B?S0tXbmR3Nm8rWVpVREFxZElWblZ0dnhVWlcvWHlJYklDdlFFV3hxaGdBbFpS?=
 =?utf-8?B?TUxuaW0reFpqUGt0ZlEvcE5pUzhWQnJFUFBlc3BCUFA5S05EbUN3YmV2clVW?=
 =?utf-8?B?eXBwOUV2RzF0TS94UGs5eU9tRGg4cnNrdmtMbkNtNUxSb1J6ejRtWHpQeXJE?=
 =?utf-8?B?azV6bWRSYXZIendSTU9QdGVpOGFMU3lPUGl3UU5OcWR6d0JUMzRIVjQ0Y0FG?=
 =?utf-8?B?cUt4Q1laUVZPQUNYM2lhazJOMDVUWEQ3Z1NxcStOMTJoanFzZGFQekY4RmhQ?=
 =?utf-8?B?S2Fud3E2S0E3RmE0ZHhPYTFCbGtKT2M5SUFucXdNVVdPcnUvRDYzb0dyYlVs?=
 =?utf-8?B?TWdSNFdtNWtGTE9FTXZsZFRtNlVUVi81LzloVlg3UzlHN2x2dDllNFZtK2Fh?=
 =?utf-8?B?ZzFjdWs3Umt6TlpabGxWS2hIVW54RkFXV0JBZHhjcTZlNGZhemwyOFpBci83?=
 =?utf-8?B?RE9vZm9FcEhhTUlpUEwyZGhkdHphU0FwQ0RVWTZvVFhHZUh3TzU2NlJFYlZM?=
 =?utf-8?B?amFhVGJ5Y1ZvZU9FV0VLbEFNc21VNkFPd1dmbUMraUpYbjB1dVdJVlN4L2Rr?=
 =?utf-8?B?MnJoTzFYbTI3L2d1MVlPZGhQMjIxeS8yc3J3RHVhV2NsVWFvUTRabDNMaFUy?=
 =?utf-8?B?UzlFbGFOQ2V5ajdDRWgzNE9rT2hPV1p3QjhFYzJ0N0VOeHRlSFF6NWdiaytm?=
 =?utf-8?B?MW9FTlVCUk5DcmdBVXZOSVN5MjRXY25ZQVlhQ0RSRjdZdlZDbmo3R3U3MVRC?=
 =?utf-8?B?cjBTeUE5UzZ4NmZheUlYK2VKWEtiZEpwd2dNa3g4N0tGUGdLc3BLem5GMlZV?=
 =?utf-8?B?OEMzcjJrWERBb01MZWs5THV3T1g0cXY3WWkyQzFJTGI4WmQrOFJTMlRJdnND?=
 =?utf-8?B?Mm81VzhISS9GR3lqQUpnc3ZpT3lZNVMwM0dBWVVmUXFrT0Z4eWRwYTUvbzVT?=
 =?utf-8?B?dlVjb1FaZHZQNWN1UHZyNTF5QTN0azhqbjhRN2JsMDNRby9DZlhsZENkZzZZ?=
 =?utf-8?B?TEFXR25xZXNzcU1HSlhHRWFBOG9SYTF6RkJVN1M1K3JrWlNRRkFBbHRvM0VQ?=
 =?utf-8?B?ck9nVDc0NDZmaGRqTjJBYlFET3pyVElzWDBoU1VFNExZSnQ4SXExQmg4ektS?=
 =?utf-8?B?TS9paGxpQ0hhdERNd2ZqdTFncC9lNjM4RC9wN2JtZmVDak9FSm1Ub05yYXRS?=
 =?utf-8?B?NXVMK0JIYkdwaVNKSVdaSnBpeVkxeHpMbFRJeW9TcXh0THNCVWUxYVExZlhU?=
 =?utf-8?B?TDVJeHdQK0RlSmord3A0MTV6WEtpbE0rSnlpaWtwdDIzTS9pWS9MSGJkVTh4?=
 =?utf-8?B?QzdIVmFxSWdxakthN1RMcHY5Y0VwNU9vWTI2Zk9PMXZuUTlXekJqbDhZTG1W?=
 =?utf-8?B?NGZOSUQvZXNPVzVBVytKZEJZbUl6WDFDWTZGbGw5M1VqYjV3NUcrdVp4RjVZ?=
 =?utf-8?B?b2U4UkNPbjdqQzI4UGloOHN0amZaeW5yK3pBWU95Q0dXOXJ6UXFvVHl2WVN6?=
 =?utf-8?B?UlU4dzNiek9uRHpqNVg5bWo2TkZNUks4WGthcHkrc0tWRWhmTTVqclQ5Lzdo?=
 =?utf-8?B?L3JnVU10TzE5MkNYQUFnWnhNU09EQTFEUHU0aHBxQnJ4Y0ZVV2VpeXAra0dv?=
 =?utf-8?B?RFFscklnY3NuVm81THNZbnM3R2hRNTJkdGRmZlM5NkpneGg2VHdNMHNXSnFH?=
 =?utf-8?B?Z2dzQlo1cDM1aVhjcVFtN2NVc2p6L0RZV2piNTNaMmhwZVpIOUdVN2VnOFNt?=
 =?utf-8?B?MW0xOEEwU1lRRlAvc1Y1VlNYamMzUEhuN3dTeHduVFVjdytGRUllby9DK1Vr?=
 =?utf-8?B?MllLa3QwT05ZWkNZTmpFTU9kbmxCaDlYdC9DWm42ejBUbjZvQnJnZWZmT09i?=
 =?utf-8?B?VEwxKzVWd3dtbjg4c3lreWlicUVnSk9oZ1p2aU53bnJHc3hPTmpBMHN5eXVz?=
 =?utf-8?B?elQ2TFNIUERqNGIzWG9KN0YzMEZjN2hFYU5HdnlLTktWRi9mdmd2aWxpRWNY?=
 =?utf-8?B?WkNQT2Q3V29aamFYZEFMRW50YXRzbVVZb0pzZE1aNDdSMmtpcHlMcU1CTk13?=
 =?utf-8?Q?6cvtBjzmAiUsVOjaj4110vg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c387340-056d-4a18-964c-08db0b406405
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:25:38.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXmSTNrvQB8xpBpQcqIIJfxOs5M4syvx3XiAbRSWKkuNqT9RvK46ZrAd3hipgwkvdRkofZO8gJyPqWDwwY3k0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4561
X-Proofpoint-GUID: MfQQ4fXmxo5RZ_jlRCFEpRtfPJOz-u2u
X-Proofpoint-ORIG-GUID: MfQQ4fXmxo5RZ_jlRCFEpRtfPJOz-u2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/9/23 10:11 PM, Alexei Starovoitov wrote:
> On Thu, Feb 09, 2023 at 09:41:41AM -0800, Dave Marchevsky wrote:
>> @@ -9924,11 +9934,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
>>  				struct btf_field *field = meta.arg_list_head.field;
>>  
>> -				mark_reg_known_zero(env, regs, BPF_REG_0);
>> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
>> -				regs[BPF_REG_0].btf = field->graph_root.btf;
>> -				regs[BPF_REG_0].btf_id = field->graph_root.value_btf_id;
>> -				regs[BPF_REG_0].off = field->graph_root.node_offset;
>> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
>> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
>> +				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
>> +				struct btf_field *field = meta.arg_rbtree_root.field;
>> +
>> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
>>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
>> @@ -9994,7 +10005,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  			if (is_kfunc_ret_null(&meta))
>>  				regs[BPF_REG_0].id = id;
>>  			regs[BPF_REG_0].ref_obj_id = id;
>> +		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
>> +			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
>>  		}
> 
> Looking at the above code where R0 state is set across two different if-s
> it feels that bool non_owning_ref_lock from patch 2 shouldn't be a bool.

Re: "set across two different if-s" - I see what you mean, and the fact that
both are doing 'meta.func_id == whatever' checks doesn't make it clear why
they're separate. But note that above the else if that the second check
is adding is "if (is_kfunc_acquire(&meta))" check, acquire_reference_state, etc.

"Is function acquire" is a function-level property and, as the kfunc flags I
tried to add in previous versions of this series indicate, I think that
"returns a non-owning reference" and "need to invalidate non-owning refs"
are function-level properties as well.

As a contrast, the first addition - with mark_reg_graph_node - is more of a
return-type-level property. Instead of doing meta.func_id checks in that change,
we could instead assume that any kfunc returning "bpf_rb_node *" is actually
returning a graph node type w/ bpf_rb_node field. It's certainly a blurry line
in this case since it's necessary to peek at the bpf_rb_root arg in order to
provide info about the node type to mark_reg_graph_node. But this is similar
to RET_PTR_TO_MAP_VALUE logic which requires a bpf_map * to provide info about
the map value being returned.

Why does this distinction matter at all? Because I'd like to eventually merge
helper and kfunc verification as much as possible / reasonable, especially the
different approaches to func_proto-like logic. Currently, the bpf_func_proto
approach used by bpf helpers is better at expressing 
{arg,return}-type level properties. A helper func_proto can do

  .arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,

and it's obvious which arg is being released, whereas kfunc equivalent is
KF_RELEASE flag on the kfunc itself and verifier needs to assume that there's
a single arg w/ ref_obj_id which is being released. Sure, kfunc annotations
(e.g. __sz, __alloc) could be extended to support all of this, but that's
not the current state of things, and such name suffixes wouldn't work for
retval.

Similarly, current kfunc definition scheme is better at expressing function-
level properties:

  BTF_ID_FLAGS(func, whatever, KF_ACQUIRE)

There's no func_proto equivalent, the is_acquire_function helper used in
check_helper_call resorts to "func_id ==" checks. For acquire specifically
it could be faked with a OBJ_ACQUIRE flag on retval in the proto, but I
don't know if the same would make sense for "need to invalidate non-owning
refs" or something like KF_TRUSTED_ARGS.

Anyways, this was a long-winded way of saying that separating this logic across
two different if-s was intentional and will help with future refactoring.

> Patch 7 also has this split initialization of the reg state.
> First it does mark_reg_graph_node() which sets regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC
> and then it does ref_set_non_owning_lock() that sets that bool flag.
> Setting PTR_TO_BTF_ID | MEM_ALLOC in the helper without setting ref_obj_id > 0
> at the same time feels error prone.

It's unfortunate that the reg type isn't really complete for rbtree_first
until after the second chunk of code, but this was already happening with
bpf_list_pop_{front,back}, which rely on KF_ACQUIRE flag and
is_kfunc_acquire check to set ref_obj_id on the popped owning reference.

Maybe to assuage your 'error prone' concern some check can be added at
the end of check_kfunc_call which ensures that PTR_TO_BTF_ID | MEM_ALLOC
types are properly configured, and dies with 'verifier internal error'
if not. I'm not convinced it's necessary, but regardless it would be
similar to commit 47e34cb74d37 ("bpf: Add verifier check for BPF_PTR_POISON retval and arg")
which I added a few months ago.

> This non_owning_ref_lock bool flag is actually a just flag.
> I think it would be cleaner to make it similar to MEM_ALLOC and call it
> NON_OWN_REF = BIT(14 + BPF_BASE_TYPE_BITS).
> 
> Then we can set it at once in this patch and in patch 7 and avoid this split init.
> The check in patch 2 also will become cleaner.
> Instead of:
> if (type_is_ptr_alloc_obj(reg->type) && reg->non_owning_ref_lock)
> it will be
> if (reg->type == PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF)

Minor tangent: this is why I like helpers like type_is_ptr_alloc_obj - they make
it obvious what properties a reg should have to be considered a certain type by
the verifier, and provide more context as to what specific type check is
happening vs a raw check.

IMO the cleanest version of that check would be if(reg_is_non_owning_ref(reg))
with the newly-added helper doing what you'd expect.

> 
> the transition from owning to non-owning would be easier to follow as well:
> PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id > 0
>  -> 
>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0
> 
> and it will probably help to avoid bugs where PTR_TO_BTF_ID | MEM_ALLOC is accepted
> but we forgot to check ref_obj_id. There are no such places now, but it feels
> less error prone with proper flag instead of bool.

I'm not strongly opposed to a NON_OWN_REF type flag. It's a more granular
version of the KF_RELEASE_NON_OWN flag which I tried to add in a previous
version of this series. But some comments:

* Such a flag would eliminate the need to change bpf_reg_state in this
  series, but I think this will be temporary. If we add support for nested
  locks we'll need to reintroduce some "lock identity" again. If we want
  to improve UX for non-owning reference invalidation in the case where
  a list_head and rb_root share the same lock, we'll need to introduce some
  "datastructure root identity" to allow invalidation of only the list's
  non-owning refs on list_pop.

* Sure, we could have both the NON_OWN_REF flag and additional {lock,root}
  identity structures. But there isn't infinite room for type flags and
  currently non-owning ref concept is contained to just two data structures.
  IMO in terms of generality this flag is closer to MEM_RINGBUF than
  PTR_MAYBE_NULL. If we're going to need {lock,root} identity structs
  and can use them to disambiguate between owning/non-owning refs quickly,
  why bother with an extra flag?

* Followup to earlier func_proto rant: I can't use NON_OWN_REF flag to tag
  a kfunc retval currently. So it'll really only be a verifier-internal flag.
  At that point, might as well add reg_is_non_owning_ref for canonical way
  of checking this.

> I would also squash patches 1 and 2. Since we've analyzed correctness of patch 2 well enough
> it doesn't make sense to go through the churn in patch 1 just to delete it in patch 2.
> 

Ack.

> wdyt?
