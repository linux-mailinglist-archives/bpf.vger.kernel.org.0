Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0795873E2
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiHAWXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiHAWXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:23:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5963AE52
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:23:48 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 271KBJMT017388;
        Mon, 1 Aug 2022 15:23:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XYw29fqy0f4DyiXuZLiqeQly+vDSfDJHVxHZ0AAFiO8=;
 b=bmjn6Kh/upR/6jpv+G2TBbmohqj4DzMiqmPn9YpW25k5NQvUbVTJdC+362qNIGIhZ3FD
 obtpfKwuK0ZSm+v5IXuJyBZMELCHk3519njlDmDAp2vbsoCaCYgvyq6IVjn8d3lVtBgs
 fOEMBayRnKU0ZUTXjNDSn94F4BWvddm/N9c= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hn0auyenw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1YIs02tfnY7Z0ugvSCEuyphHIoepGHPEzjboGA6uoaD/7yDNZDtX5pwAlNBC0Wx5xN56ffMSDJ4VsjSAFRgic14FXrtK+tRrnwZg3Xku22RtDzvQK3lAcYlzdBA8RJytriDZdTlTR+tBoRmUELAIK4sEGaCnPM0rPqr/A66rKpesMao5PbiJUg8/197rdARzEiw1kO1/Fsg6LWZ5YtrEJJ8ZBwJ+ll6AQkV7MrLnieuIjTdgpksXGyu9O0Cs0dz531xJqfDxXJBh42QgTffRiJeGD1IWMANc7Eay+K9heN0Zd/zl5HoK2cnbd52VwWzCaE5q+aMZeRkJLXYOcU1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYw29fqy0f4DyiXuZLiqeQly+vDSfDJHVxHZ0AAFiO8=;
 b=mYfjaxBGPy+Y2qC+sF6lpcdOwHZWTQ+2Ng87PzOV75PznFLL/rYZOXgALncb0Pp/AQq6Kk+NkhMP5Lu5KtEg6K8MkNWo4ebQyq+4M9uJOhYZC1+nlsKawU1rldqu5adOJ/Rg+rFOK0BLLscQX8pGXog67mKoELTRruqO6x4nX6/5hF4fBFOy5PJ7HTQ6z5/fSTfnL4ow/F8oxmTJTrdLYWHO1XQ7soM8FZSqhAlY2ZGgH0dVhVBzQ7C+XYZKW849FFhETv8n6xRp0GS7O2sGYPHcGqcBwF1IL2XL9TkU4GDB+i2vbvII4eqhFnr6YUT/nZMdYhbZpI0cnjtEzfqphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BLAPR15MB3762.namprd15.prod.outlook.com (2603:10b6:208:272::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 22:23:31 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:23:31 +0000
Message-ID: <8f4c3e52-ce86-cbfc-5e76-884596ec11d7@fb.com>
Date:   Mon, 1 Aug 2022 15:23:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 09/11] bpf: Add CONDITIONAL_RELEASE type flag
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-10-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-10-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2538c9c5-83f7-456c-3e84-08da740c7726
X-MS-TrafficTypeDiagnostic: BLAPR15MB3762:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL6wiSyl2psuB9thlOK+6UlfuLX6Z+5LJjETFsppqcE0jGAXsCH57S3NTg6Hy3KWbaxNQtDk5/JEL+0nBq5ceu1QYgfBk+IesEjAI1rBLTbK95CQ9JrkRn/YAlVT7rvEEVP7b/Nv5XErJlHIwCAfvvoMlFG/wsGCKk4pnIsgaTY/03tduJp51UWj6dufAnyVEPCGuRciGFX7HdH37wIp9btexEAHC/TxaeRi4dSynyytB7VeNUc8ru+Zg+19NO/xFcaqbX6tjE6KKfCnOG5I0beAJi0EziwNcR3kJCGwBzy5WaUDcvIAKLXICwzTJPS4Widb6FAZOt6JUIHi0QMczht/GLa61JNaISKBMHVRwBpbMGogdRWf0OqtCC1875zpKJNKf/VmV/jt84fb6Z/z9Kf1KvRR4U+7cjLUotCG6enzrAitndMy3nUQ2MsFWVjhGoNxdT4fj+ckbO+QprgGZs12cJJS8CaLWtnubeoWBRUH898LsJkSmK6zbPZMOcwOxpUo7vra0Us06J4VyxAIAQCicRXHp+O9QCeLnPmKkbhpPpxWmiy570PKs+A4baXdyISxwZvNQmzM0On1yXyp61NRjW2JSO8OBBSKCJ5TRkKRGprB7w66x1jsI4716XSNiYNAjomR4/eiP8l4Vrxs8+eoumbAwtZlgnoJvLPVQ6hVgA4UTgchjdd1PJqW3Ywu6/xMfvxxEYpVmMfkf4DkKsFcPbIu3swy8jHVAifk3JtzMoio2JtHr9uFmb8SBUPf/2bWOyav5+h/lVHDGcKIQFUlC6pP0xoY+knOS+/Hu0YpOddfxO8mCxrZnvcy/Kcnm8vsjNq7c27gszxL4x11Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(52116002)(53546011)(31696002)(6506007)(2616005)(6512007)(86362001)(38100700002)(186003)(478600001)(83380400001)(316002)(6486002)(8936002)(5660300002)(8676002)(36756003)(4326008)(31686004)(66476007)(30864003)(66556008)(66946007)(2906002)(54906003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5Hd2tzQnVLWkZOZDNaUFB5Mi9tUGtmWWNkMHRmN24ySkRkQUtwNjJhYVRZ?=
 =?utf-8?B?a0dQYnB0TzYwSE1BbWUxck4rSnc1VHo2aW5lbGhqb1FoS2RxQ0FkMjd0S1pa?=
 =?utf-8?B?eEI0bXNBU2xEekg5aHRKQkJleVpOWU5YbC9PTWZlRzZobnp5WlJKdGdmVms1?=
 =?utf-8?B?S1h5LzhrZEQxR1V3RFNWVmppbGpmYnZBVHhXaWMxejVTd0VQdXM2SVRvN3dq?=
 =?utf-8?B?ZUJZQTBsVFhFblFpTkVPR3J2S29xc3dqUEVybEJ6NGRVVUNLbFpLUFptS0or?=
 =?utf-8?B?K251c2J3R3luazJvMXlhMUI0Q0pueDdDbjBVUHF5RlpqRkhsZGtuSWwwRXZS?=
 =?utf-8?B?NVJsNGlaOTNKTUo0VmNJUnE3aGdES1ZlYmtnV3A3a1hsMkpjYU4xczkrNlNI?=
 =?utf-8?B?ME5rVjlsbStPMk8rL0o1MUpJcnVzazNYaDJVUnlLaVBvTi9BbFg0cnl2SGhM?=
 =?utf-8?B?Zk85Y05BM2h0QXFmL1VuVTZsOUNQY1k4NW9RWUFwU25kclhDRGl5ZWVNRjJr?=
 =?utf-8?B?Qlo1YnZEZ1prdks5NjBwbEdCM3gra3lsaFVjcG1RVVpEVWE0ZE1NbkdaQTQ1?=
 =?utf-8?B?S0JOZmFzVGVJbWxpV3h4NmpDZURMekJzWDVZVWVrR0JTYWI0T1g1WFNnYzNt?=
 =?utf-8?B?dldqUENkYmJ2VGw1V1crR1BTK3pyRjk4ek15SFR3UW9vYmpuUjhOTEZsRjls?=
 =?utf-8?B?MmFQOW9HTWNuYlJrblNxWmJXTlM3K2x0TnlxbXdiK2I0RllKME0vV1ZJR3Zr?=
 =?utf-8?B?OVkvK2xUQ1dHa2hSbnpwNUpJUTljYmxSOEZXMFlocHdkRXZXNXc2eW5IR2Ri?=
 =?utf-8?B?N3R6NFE1Z0pwQ3o5ZklKNGtwQVBWdnd3eXRtTmR5a2lNUlVFQndBUDg3T1k4?=
 =?utf-8?B?b2RaM1NCczNnbVNiOU5XQkVYRnBZNktKWXdSRURWZEJBSDRPK0tyK2tKT1pR?=
 =?utf-8?B?eXN5U0p3WURuQWVMZDF6SVlzTE5rWkFyOWQzLzdpeTNnTk4yczlLakpQd1NX?=
 =?utf-8?B?U252RFU4bW0wcjdKUitwaEc4OVcyTUR1OVYwTmt5L3UyQzFXSGhPTlExc3I2?=
 =?utf-8?B?cEc1aGtPbHdIOTZpV0gzTWNPRU1PMFd4NnA5eWZHTW1MM2pMTjdNZ0N6VFFP?=
 =?utf-8?B?WlRpMVlPMldqbzJtUno0V1JoOXhndEtTVG44ZUgxTFJ2VnBoNGEwaWwwWGUz?=
 =?utf-8?B?VFZnNFRITjZHRHFsM0V5TTJuYXBpdkFiZlBCSkV5d0k1bDVVbzMxOENxZnpH?=
 =?utf-8?B?bm8wZ2svTHg5cm9BTGtHMHJIZGtQRjlmQzJTc0V6SDFRSElWQ29zamZ6SDlO?=
 =?utf-8?B?cHhKRTJGRU1mZDBINGJQVW9Qb01aVTIxb1JNNUg0NzZ6OXh4M1laaVQyOHJm?=
 =?utf-8?B?Y3RGOXNEKzIwU2t4Kzg1Q1NacmJHSGZEdTBUbkRTZWw1bG5PYWJqRmRPVkpk?=
 =?utf-8?B?Tys5NEE0SkJmUktQUVFlTktlWmttWEtzdG9FbmZWZDVxNEZsWGQzRkJNSjVi?=
 =?utf-8?B?MjNRdW1WbU1VVWFraHk2MXMrT1VGcTVjNXV5Z3hKaFYzV0RKbVE0T21GV3Mr?=
 =?utf-8?B?Y1BLcjIvd3hKQ002dFJYV1g3dVN2YlA2NlNYRXFkRlNnaFgxN1oyQnEyRTQz?=
 =?utf-8?B?amlmdlozWjdKa3hIT29OMGtCa1dqbWRBdFdBZG9CZXBWSHFSSXRaYWp1S0tU?=
 =?utf-8?B?dkl2U3F5U05PcmFmUFVQUGFwZ0VISi94RzF5L1FFcklUZThheHM2UHNiMFZ5?=
 =?utf-8?B?SkV4QURHUVJrMlAxSUVna0FxZC9xcnh1YnVuU1ZDL3ovd3BobG8rczErT2tH?=
 =?utf-8?B?VDBUanlwaDd2WUdTNDdPQWNnVkJuRmZBeXpTY3ZoTWNhbGgwQUhEckJtajFy?=
 =?utf-8?B?dWxQSXFCRUhNQ09mNzluc21zdVRodDdKKzMwY1NMYm5BNlNvNkpBeUJyWG5k?=
 =?utf-8?B?YmpmaWd2M1VWWlFPM2VGSzd0eVJ1UGxSUi9OVlI1eVF0WWVrb1Nwbm9tdVRZ?=
 =?utf-8?B?L0haTTBHOFpFK1F1M0lQelhFV0ZVam9lejZXUVJhKzFic1V5NTF5NThRc3hZ?=
 =?utf-8?B?OWNQVUo3K3QxdFB5d3R6SjZnckdlMlNGdWZtVGM1UElZTVJGWUZlK2dIcE8r?=
 =?utf-8?B?OHhTZE1FM2s4akx3dFg0RXVpTkRWUUNoTGIxa0tHd1FVNTRpYUJDOFVEUXBT?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2538c9c5-83f7-456c-3e84-08da740c7726
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:23:31.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOxVvz1mCrXftQMp3aLKLlkzBP/JUBOjujROOpKhADpHSTVr9SMfqjzKoHf+NeQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3762
X-Proofpoint-GUID: l11KBKfdcHdO_9-etVieDwIaCtthxb0X
X-Proofpoint-ORIG-GUID: l11KBKfdcHdO_9-etVieDwIaCtthxb0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> Currently if a helper proto has an arg with OBJ_RELEASE flag, the verifier
> assumes the 'release' logic in the helper will always succeed, and
> therefore always clears the arg reg, other regs w/ same
> ref_obj_id, and releases the reference. This poses a problem for
> 'release' helpers which may not always succeed.
> 
> For example, bpf_rbtree_add will fail to add the passed-in node to a
> bpf_rbtree if the rbtree's lock is not held when the helper is called.
> In this case the helper returns NULL and the calling bpf program must
> release the node in another way before terminating to avoid leaking
> memory. An example of such logic:
> 
> 1  struct node_data *node = bpf_rbtree_alloc_node(&rbtree, ...);
> 2  struct node_data *ret = bpf_rbtree_add(&rbtree, node);
> 3  if (!ret) {
> 4    bpf_rbtree_free_node(node);
> 5    return 0;
> 6  }
> 7  bpf_trace_printk("%d\n", ret->id);
> 
> However, current verifier logic does not allow this: after line 2,
> ref_obj_id of reg holding 'node' (BPF_REG_2) will be released via
> release_reference function, which will mark BPF_REG_2 and any other reg
> with same ref_obj_id as unknown. As a result neither ret nor node will
> point to anything useful if line 3's check passes. Additionally, since the
> reference is unconditionally released, the program would pass the
> verifier without the null check.
> 
> This patch adds 'conditional release' semantics so that the verifier can
> handle the above example correctly. The CONDITIONAL_RELEASE type flag
> works in concert with the existing OBJ_RELEASE flag - the latter is used
> to tag an argument, while the new type flag is used to tag return type.
> 
> If a helper has an OBJ_RELEASE arg type and CONDITIONAL_RELEASE return
> type, the helper is considered to use its return value to indicate
> success or failure of the release operation. NULL is returned if release
> fails, non-null otherwise.
> 
> For my concrete usecase - bpf_rbtree_add - CONDITIONAL_RELEASE works in
> concert with OBJ_NON_OWNING_REF: successful release results in a non-owning
> reference being returned, allowing line 7 in above example.
> 
> Instead of unconditionally releasing the OBJ_RELEASE reference when
> doing check_helper_call, for CONDITIONAL_RELEASE helpers the verifier
> will wait until the return value is checked for null.
>    If not null: the reference is released
> 
>    If null: no reference is released. Since other regs w/ same ref_obj_id
>             were not marked unknown by check_helper_call, they can be
>             used to release the reference via other means (line 4 above),
> 
> It's necessary to prevent conditionally-released ref_obj_id regs from
> being used between the release helper and null check. For example:
> 
> 1  struct node_data *node = bpf_rbtree_alloc_node(&rbtree, ...);
> 2  struct node_data *ret = bpf_rbtree_add(&rbtree, node);
> 3  do_something_with_a_node(node);
> 4  if (!ret) {
> 5    bpf_rbtree_free_node(node);
> 6    return 0;
> 7  }
> 
> Line 3 shouldn't be allowed since node may have been released. The
> verifier tags all regs with ref_obj_id of the conditionally-released arg
> in the period between the helper call and null check for this reason.
> 
> Why no matching CONDITIONAL_ACQUIRE type flag? Existing verifier logic
> already treats acquire of an _OR_NULL type as a conditional acquire.
> Consider this code:
> 
> 1  struct thing *i = acquire_helper_that_returns_thing_or_null();
> 2  if (!i)
> 3    return 0;
> 4  manipulate_thing(i);
> 5  release_thing(i);
> 
> After line 1, BPF_REG_0 will have an _OR_NULL type and a ref_obj_id set.
> When the verifier sees line 2's conditional jump, existing logic in
> mark_ptr_or_null_regs, specifically the if:
> 
>    if (ref_obj_id && ref_obj_id == id && is_null)
>            /* regs[regno] is in the " == NULL" branch.
>             * No one could have freed the reference state before
>             * doing the NULL check.
>             */
>             WARN_ON_ONCE(release_reference_state(state, id));
> 
> will release the reference in the is_null state.
> 
> [ TODO: Either need to remove WARN_ON_ONCE there without adding
> CONDITIONAL_ACQUIRE flag or add the flag and don't WARN_ON_ONCE if it's
> set. Left out of first pass for simplicity's sake. ]
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/linux/bpf.h          |   3 +
>   include/linux/bpf_verifier.h |   1 +
>   kernel/bpf/rbtree.c          |   2 +-
>   kernel/bpf/verifier.c        | 122 +++++++++++++++++++++++++++++++----
>   4 files changed, 113 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c9c4b4fb019c..a601ab30a2b1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -413,6 +413,9 @@ enum bpf_type_flag {
>   	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>   
>   	OBJ_NON_OWNING_REF	= BIT(11 + BPF_BASE_TYPE_BITS),
> +
> +	CONDITIONAL_RELEASE	= BIT(12 + BPF_BASE_TYPE_BITS),
> +
>   	__BPF_TYPE_FLAG_MAX,
>   	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>   };
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9c017575c034..bdc8c48c2343 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -313,6 +313,7 @@ struct bpf_verifier_state {
>   	u32 insn_idx;
>   	u32 curframe;
>   	u32 active_spin_lock;
> +	u32 active_cond_ref_obj_id;
>   	bool speculative;
>   
>   	/* first and last insn idx of this verifier state */
> diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
> index 34864fc83209..dcf8f69d4ada 100644
> --- a/kernel/bpf/rbtree.c
> +++ b/kernel/bpf/rbtree.c
> @@ -111,7 +111,7 @@ BPF_CALL_3(bpf_rbtree_add, struct bpf_map *, map, void *, value, void *, cb)
>   const struct bpf_func_proto bpf_rbtree_add_proto = {
>   	.func = bpf_rbtree_add,
>   	.gpl_only = true,
> -	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF,
> +	.ret_type = RET_PTR_TO_BTF_ID_OR_NULL | OBJ_NON_OWNING_REF | CONDITIONAL_RELEASE,
>   	.arg1_type = ARG_CONST_MAP_PTR,
>   	.arg2_type = ARG_PTR_TO_BTF_ID | OBJ_RELEASE,
>   	.arg2_btf_id = &bpf_rbtree_btf_ids[0],
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4f46b2dfbc4b..f80e161170de 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -472,6 +472,11 @@ static bool type_is_non_owning_ref(u32 type)
>   	return type & OBJ_NON_OWNING_REF;
>   }
>   
> +static bool type_is_cond_release(u32 type)
> +{
> +	return type & CONDITIONAL_RELEASE;
> +}
> +
>   static bool type_may_be_null(u32 type)
>   {
>   	return type & PTR_MAYBE_NULL;
> @@ -600,6 +605,15 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>   			postfix_idx += strlcpy(postfix + postfix_idx, "_non_own", 32 - postfix_idx);
>   	}
>   
> +	if (type_is_cond_release(type)) {
> +		if (base_type(type) == PTR_TO_BTF_ID)
> +			postfix_idx += strlcpy(postfix + postfix_idx, "cond_rel_",
> +					       32 - postfix_idx);
> +		else
> +			postfix_idx += strlcpy(postfix + postfix_idx, "_cond_rel",
> +					       32 - postfix_idx);
> +	}
> +
>   	if (type & MEM_RDONLY)
>   		strncpy(prefix, "rdonly_", 32);
>   	if (type & MEM_ALLOC)
> @@ -1211,6 +1225,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>   	dst_state->speculative = src->speculative;
>   	dst_state->curframe = src->curframe;
>   	dst_state->active_spin_lock = src->active_spin_lock;
> +	dst_state->active_cond_ref_obj_id = src->active_cond_ref_obj_id;
>   	dst_state->branches = src->branches;
>   	dst_state->parent = src->parent;
>   	dst_state->first_insn_idx = src->first_insn_idx;
> @@ -1418,6 +1433,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>   		return;
>   	}
>   
> +	reg->type &= ~CONDITIONAL_RELEASE;
>   	reg->type &= ~PTR_MAYBE_NULL;
>   }
>   
> @@ -6635,24 +6651,78 @@ static void release_reg_references(struct bpf_verifier_env *env,
>   	}
>   }
>   
> +static int __release_reference(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
> +			       int ref_obj_id)
> +{
> +	int err;
> +	int i;
> +
> +	err = release_reference_state(vstate->frame[vstate->curframe], ref_obj_id);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i <= vstate->curframe; i++)
> +		release_reg_references(env, vstate->frame[i], ref_obj_id);
> +	return 0;
> +}
> +
>   /* The pointer with the specified id has released its reference to kernel
>    * resources. Identify all copies of the same pointer and clear the reference.
>    */
>   static int release_reference(struct bpf_verifier_env *env,
>   			     int ref_obj_id)
>   {
> -	struct bpf_verifier_state *vstate = env->cur_state;
> -	int err;
> +	return __release_reference(env, env->cur_state, ref_obj_id);
> +}
> +
> +static void tag_reference_cond_release_regs(struct bpf_verifier_env *env,
> +					    struct bpf_func_state *state,
> +					    int ref_obj_id,
> +					    bool remove)
> +{
> +	struct bpf_reg_state *regs = state->regs, *reg;
>   	int i;
>   
> -	err = release_reference_state(cur_func(env), ref_obj_id);
> -	if (err)
> -		return err;
> +	for (i = 0; i < MAX_BPF_REG; i++)
> +		if (regs[i].ref_obj_id == ref_obj_id) {
> +			if (remove)
> +				regs[i].type &= ~CONDITIONAL_RELEASE;
> +			else
> +				regs[i].type |= CONDITIONAL_RELEASE;
> +		}
> +
> +	bpf_for_each_spilled_reg(i, state, reg) {
> +		if (!reg)
> +			continue;
> +		if (reg->ref_obj_id == ref_obj_id) {
> +			if (remove)
> +				reg->type &= ~CONDITIONAL_RELEASE;
> +			else
> +				reg->type |= CONDITIONAL_RELEASE;
> +		}
> +	}
> +}
> +
> +static void tag_reference_cond_release(struct bpf_verifier_env *env,
> +				       int ref_obj_id)
> +{
> +	struct bpf_verifier_state *vstate = env->cur_state;
> +	int i;
>   
>   	for (i = 0; i <= vstate->curframe; i++)
> -		release_reg_references(env, vstate->frame[i], ref_obj_id);
> +		tag_reference_cond_release_regs(env, vstate->frame[i],
> +						ref_obj_id, false);
> +}
>   
> -	return 0;
> +static void untag_reference_cond_release(struct bpf_verifier_env *env,
> +					 struct bpf_verifier_state *vstate,
> +					 int ref_obj_id)
> +{
> +	int i;
> +
> +	for (i = 0; i <= vstate->curframe; i++)
> +		tag_reference_cond_release_regs(env, vstate->frame[i],
> +						ref_obj_id, true);
>   }
>   
>   static void clear_non_owning_ref_regs(struct bpf_verifier_env *env,
> @@ -7406,7 +7476,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
>   			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
>   		else if (meta.ref_obj_id)
> -			err = release_reference(env, meta.ref_obj_id);
> +			if (type_is_cond_release(fn->ret_type)) {
> +				if (env->cur_state->active_cond_ref_obj_id) {
> +					verbose(env, "can't handle >1 cond_release\n");
> +					return err;
> +				}
> +				env->cur_state->active_cond_ref_obj_id = meta.ref_obj_id;
> +				tag_reference_cond_release(env, meta.ref_obj_id);
> +				err = 0;
> +			} else {
> +				err = release_reference(env, meta.ref_obj_id);
> +			}
>   		/* meta.ref_obj_id can only be 0 if register that is meant to be
>   		 * released is NULL, which must be > R0.
>   		 */
> @@ -10040,8 +10120,8 @@ static void __mark_ptr_or_null_regs(struct bpf_func_state *state, u32 id,
>   /* The logic is similar to find_good_pkt_pointers(), both could eventually
>    * be folded together at some point.
>    */
> -static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
> -				  bool is_null)
> +static int mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
> +				 bool is_null, struct bpf_verifier_env *env)
>   {
>   	struct bpf_func_state *state = vstate->frame[vstate->curframe];
>   	struct bpf_reg_state *regs = state->regs;
> @@ -10056,8 +10136,19 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
>   		 */
>   		WARN_ON_ONCE(release_reference_state(state, id));
>   
> +	if (type_is_cond_release(regs[regno].type)) {
> +		if (!is_null) {
> +			__release_reference(env, vstate, vstate->active_cond_ref_obj_id);
> +			vstate->active_cond_ref_obj_id = 0;
> +		} else {
> +			untag_reference_cond_release(env, vstate, vstate->active_cond_ref_obj_id);
> +			vstate->active_cond_ref_obj_id = 0;
> +		}
> +	}
>   	for (i = 0; i <= vstate->curframe; i++)
>   		__mark_ptr_or_null_regs(vstate->frame[i], id, is_null);
> +
> +	return 0;
>   }
>   
>   static bool try_match_pkt_pointers(const struct bpf_insn *insn,
> @@ -10365,10 +10456,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   		/* Mark all identical registers in each branch as either
>   		 * safe or unknown depending R == 0 or R != 0 conditional.
>   		 */
> -		mark_ptr_or_null_regs(this_branch, insn->dst_reg,
> -				      opcode == BPF_JNE);
> -		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
> -				      opcode == BPF_JEQ);
> +		err = mark_ptr_or_null_regs(this_branch, insn->dst_reg,
> +					    opcode == BPF_JNE, env);
> +		err = mark_ptr_or_null_regs(other_branch, insn->dst_reg,
> +					    opcode == BPF_JEQ, env);

CONDITIONAL_RELEASE concept doesn't look too horrible :)
I couldn't come up with anything better.

But what's the point of returning 0 from mark_ptr_or_null_regs() ?
