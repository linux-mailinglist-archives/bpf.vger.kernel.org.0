Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B552D64653A
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiLGXkJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 18:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLGXkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 18:40:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157F8AAEE
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 15:40:01 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7KmvTH025302;
        Wed, 7 Dec 2022 15:39:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PO6q9YXQQxsVue59wY27Rk+lsy6iIsT2S7+bCHhtwFA=;
 b=ltztFhQmcit3IE7NKC/jeJZbMiE5cT3zOoyXHdq3MMlgFb3wvasUgS9u5nfME/hDmoYz
 i585IHpJnfwYSBmjdjKb4xFpdEN8TKwwPTzaMsFJoquU6Aqfw9rg+w1WfVZ446gU+GGn
 Ni1Dxu45mU41LB5QJ4WAmlG7G1HGHwQy9Ybgz08bxOaivQeOs5XzVCuNTYearvq7Nu/b
 T0N8i6f/oRKTtG+TmFj2rvoxkVG38pKDLYve1TFm2/AzOwf0O3Ppgg2JQlKUWy6IgNNh
 1HftX5LGW/XFIRM1T8e2qnEfycaVuv4QlRkgfxyykklqQapBFQia7F7b2DRwaLYNtdD2 xg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mavtemdpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 15:39:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccdp/MF/LQ505RzI7SEKsuRNPeqJIT54D5TpPetpTtBRLUI7rYkcHPmxRisaqgAglEM8AIn7ao2BGD+xrzOJv6/xzNJXBSHNAt4YG7tbmxEOeZBMjU9aDBi+ShTHQFG3K6tAN7wPqq5Py43/o2RF0jl0pGVYE0iwT79ktxK7Fvx3NFLX67ILyb/Uha9/wMLe3TLQXAqW5WVYzG+x9O4VDV1gfoxQsTqC2Sdh2WYwUiHuauOiudqPf3f1ib5tGmq6mR7jn7MdvtBH1BFYCssb66hH78TtTgrn3e/HHDFZroTl96PksWXYh8bBxzqW3znWKo/L7Buc/jNDsENHvfns/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO6q9YXQQxsVue59wY27Rk+lsy6iIsT2S7+bCHhtwFA=;
 b=CA2I4Gbj6IM7Y4iaUyrotqfxfMu8khdWAv+pxSy/LkljU9Vn7rxttnJIYmBaJ6prXEJDex81vm22oG5s8mFEk2noNiMlZLouKERCsMYJOEYHY5xAtDRElNBKP2GC0uJERQQwVfJztlukGY0NhQjksh+zylni47/oUPOaR1ksIHb1PuJGYxbIKv6jLkV96DEMewUvKHmn2GGo/y28R3ke0tz/cBVNoqNIlhK2CqvGIeGGtIrcVv8n6LmFimWA7JDNWj8bDUxerk1D0TGfn5lHRYOVbSaA/b20sqrrcl0AB0TBcc6DMCEGcVnDr9aO0BMntVxrUgW+/g6N5umn7VBGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by DM6PR15MB3163.namprd15.prod.outlook.com (2603:10b6:5:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:39:41 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:39:41 +0000
Message-ID: <ea0259d9-2f29-bfbc-011f-810d3e2654a8@meta.com>
Date:   Wed, 7 Dec 2022 18:39:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for
 insn->off < 0
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
 <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
 <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
 <20221207180621.zkuztvz7hx4niout@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207180621.zkuztvz7hx4niout@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:208:2be::28) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|DM6PR15MB3163:EE_
X-MS-Office365-Filtering-Correlation-Id: 78565edc-5cff-44ca-bf37-08dad8ac4fd8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAg2hmNrlGdKjWZODcutYj4AMLcuhi6UDg4GwseSZVzXqUsHXe8HjQYtMrUzpnDOzmKmHFjQJZze9Do0kQLLUWRxmdGiCxCaTfLynlTKv2GSt7To68wlioHS6wzCeTIsYkumzkhoGe6lyOk9PmWSLzGRlBg2lsoOJklO/2uDPgpx+8qfMxKnzIx0JQRT7DLvZzd273u53Kj7dYvxCLwEW1ZPtpkbgu0Noqbd+VAV1Ii+fRazZdymIO93zcbftA4jNbpqLxMLnm4FxqXPnovgQLaYDfwPO9KUcYYAw1V16g3IHioTls23lsOvdQlI+JrtotZ8v321esCh7pJWMMK9b0uOuUwrDvdslnScvvz4JvHizaOmyL66bpwUUeTPlJsJATWH/Fo9CtKzK9wUKTFOIfBdGfKbtQWAOge8Qa1E+d/yia7zkPg7tso7r0GyfsJyj6SAfXygc0/AbeF2J4XAuukrNe+DIDtiWhp5X2eqXzk/0XgIhNXu8WikwBrHVU6ApFHl3XgbMpwyx8v8wja3M98A1t7Igs3xf/bk6BuJszlF9/UOYVRwc6z2SN2pYfNH2kZLOfMeIK8yQwx/dvcpMH6wFdd452Q5c7Dt/IxiEOfRpJxzW9OfnlUJBJ9wpWG+MJfNU2LyCIu+VjgrPjDsLgAU9rOPOxDqeMixp5de6I+yP+p2DAGUSnwGaAdQ8QWzLIeW+SGdI1g6d+FLhLzR2RuZ0vz8fhX5AUehbkghNl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(6916009)(2616005)(186003)(6506007)(53546011)(316002)(38100700002)(83380400001)(6666004)(4326008)(8676002)(41300700001)(30864003)(6486002)(2906002)(66476007)(478600001)(66946007)(31686004)(66899015)(36756003)(54906003)(6512007)(66556008)(5660300002)(86362001)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhHeWNqTlk3VDU4akNEaWhGY0U4Rkt2U2VmOEVHYkxGUzBWVFg5R29pTVI1?=
 =?utf-8?B?aVlPK0Vncy9PdG1QdEdFMWxOdXZqYk1pbnhHQURDV1FqTTREYXVQK0QzeFh6?=
 =?utf-8?B?cS9aMlpWNXdWNTBLWUNrVVJ5dU5rSWpqZ1J5c2NSd1hpbEZkK1FEU0JjdS9Z?=
 =?utf-8?B?VUUzczhzRExQdUNPWlhrRWJJYkV3QkZWZWkvMlZ3Zk9uMG5tMXQwM090dVF0?=
 =?utf-8?B?ZkNUY0FvZ2NSWEtReEV2bTJYT3FaazVrK29iZHJJSE9KckVFcnQ5Um5sM01n?=
 =?utf-8?B?SFlkU21zZ0ZobHhlTFRuU0ZaL0cxMjlvTTdIY0FuWHNSbkxicElaT1NjL0V4?=
 =?utf-8?B?R1FvbkRsNWxaRlc3SHJheTQ2bURtYk5ZbEl0WGdyejcvdktabFJxdGx2cEdP?=
 =?utf-8?B?VnRtY3FYYit4QTk3Nkc3eG5iSmI5VitZSEpRNGRDTUhVTHozN0tYZ21taWtD?=
 =?utf-8?B?SlJaRVUyMVRSbnNSTmx0clVCYUhCb0pCV2hhWmFWVGplVHkreUhZWFJ1Yi9X?=
 =?utf-8?B?V0ZPcTBuM1RwZFhnREE5U05FT01HQ1FsdTQ0QkZFblRVcjN3d2huOUUzSmFk?=
 =?utf-8?B?bVRQalQ3TDd1Lzl2OFYrL2ZoT2p2aEN4Q01KQ0VQRHhqbVZpWnNic284SUE1?=
 =?utf-8?B?VGZhUDdMeGw3Qi9JMUt2U3NFVi9YVWRDN3VwRDRXOURMK1hFSnRDNFRxREY1?=
 =?utf-8?B?YXdyR2o3N2UxNjI1dFBwOFZVNTFNeHlTa3M5c1pta0hKd3RRSzBEOHpnV3lC?=
 =?utf-8?B?ZkF2Rkg0Z2szWnVMN29remw0bEJGUmtPZXBnY3pybHcrL2NueW1qSjBLaitn?=
 =?utf-8?B?NlBTZ0dTSi9Sc1pFY1MyVlVmaUZRZVB4WkZSRkdBY3dkelpGR2Q2amszazMw?=
 =?utf-8?B?aDVtQWFQQTNwNXZoTTl0YzM4RDBOL3Z1c005ajloOFBaUG9GdE5tVWFMeWNN?=
 =?utf-8?B?dEhXRzJwam82T2N0alcyQkJvcnpneVdaejRVK0ZPTEVQSW92eXZ4elI2TnFK?=
 =?utf-8?B?T1FhZHphWGVZWldUelhlZ2xCUWhvc0p5YUNhRVVhV1JHQVRXR1RnQ3J5Wmps?=
 =?utf-8?B?RG1OUitSMnU1ZWtYeWdyeCtXbnU5Z0pYNm9oTzFGYmExaUpRdWdQSlByanpJ?=
 =?utf-8?B?SDJlQi9wRHZZOVlyTi80dzNxeG9aQXI0SEFWSDBmd0RaQ2xMekNHV0FobTNt?=
 =?utf-8?B?UEVUOU5zOS9uM0VmdXB4ai9XdHltS21ydjhsUk5meS85RlE2UXlEcUUwQWRy?=
 =?utf-8?B?MkVWUURLSFptOThCMDRQTFRaQVh1bklGa0tKdUw3QWVLdlgxbnhuVDE5N2VU?=
 =?utf-8?B?NDE5SVUrUUNKbVRZcm5GQitLdmVYS09VdkUxdzFWdmdsYzloTVcrYVoyc0lz?=
 =?utf-8?B?dW90eEl0U3p2Q2s3MCtuakM3aW43M3FVOVY2R2V0eEtTN0tidTlyZUpIU1J4?=
 =?utf-8?B?enI1ckd0WEUrUERCdDgvem9PbTZ5dFN4TmFETjBiMDAySXlSTlBsaXJGY2J1?=
 =?utf-8?B?eE83a21Qd1dIMURIQ3l5YjJMcmNzQ3VjRXduTS9nZ2RzTnF6RStuem91RENi?=
 =?utf-8?B?UldMN2x4a0RVOFZnRUpsOXpLWUtCOU4zV3J2YWtndWhhTGxUdGx6N1hDOCtM?=
 =?utf-8?B?NXBvR25YNUhFS0hYa2IwcW9yOWpxcE9jSXFlT0poVERHVXlVbi9vVGlLcjcr?=
 =?utf-8?B?RlJFSDFqVVBNZU1PZ1J2c3dPa3lvQ2dqemwwaFVkYUVYY3FSZzdWTVNNSDd6?=
 =?utf-8?B?dnBRYmVrRndFSlcwRTUyM0RLS0VMUlJtaXhBWEd5YnZlK3o1QWozSlF4em1W?=
 =?utf-8?B?Z0k1dTFHWDZRM0FuS25BNExobWlvRXJaODhOcXR2ZnpUeVZaVThvVS80dmVk?=
 =?utf-8?B?YVRVZlBhcFdJMGNFemxJK1p5WVVvZXBSZmJQMnVGUlFXL1VENFErS3l3eWhJ?=
 =?utf-8?B?QUloYkZrQlJncXVZeHRDSkxGeEh3d3dIdk1VcDYxcVBwZUVGOVQ1MnZ2cnF2?=
 =?utf-8?B?TWxmMUlyZzdFa1FuRHVsUElGd1RFNVNZRU9rSWJRSElvNEpiamJaTm5XT0FT?=
 =?utf-8?B?NmR6QVM4dS91d3BqeGpBU1ZUM0JxTDlEZ25LalB5ZU1aZmhVOUdyNnNWcS9N?=
 =?utf-8?B?QVpjQVhmZWZLcXFscjRxckx0YTRXSERZYW9tdi9nbHF3SDhJWWI5ZW1WOWZI?=
 =?utf-8?Q?rKqZZo/cbRo9n5ulD8Bc/4U=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78565edc-5cff-44ca-bf37-08dad8ac4fd8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:39:41.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J1BNF/aI1ESot83/Ddh+cNs+cNBpaqNy7kbf8GlL0LtwcBp+imf7vUHCGnxEqYe1lg+xe6SSbciK6McP67+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3163
X-Proofpoint-GUID: BCOn1CVYXG4e31ZJyG2WaTotwl2bCm16
X-Proofpoint-ORIG-GUID: BCOn1CVYXG4e31ZJyG2WaTotwl2bCm16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 1:06 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 01:46:56AM -0500, Dave Marchevsky wrote:
>> On 12/6/22 9:39 PM, Alexei Starovoitov wrote:
>>> On Tue, Dec 06, 2022 at 03:09:57PM -0800, Dave Marchevsky wrote:
>>>> Current comment in BPF_PROBE_MEM jit code claims that verifier prevents
>>>> insn->off < 0, but this appears to not be true irrespective of changes
>>>> in this series. Regardless, changes in this series will result in an
>>>> example like:
>>>>
>>>>   struct example_node {
>>>>     long key;
>>>>     long val;
>>>>     struct bpf_rb_node node;
>>>>   }
>>>>
>>>>   /* In BPF prog, assume root contains example_node nodes */
>>>>   struct bpf_rb_node res = bpf_rbtree_first(&root);
>>>>   if (!res)
>>>>     return 1;
>>>>
>>>>   struct example_node n = container_of(res, struct example_node, node);
>>>>   long key = n->key;
>>>>
>>>> Resulting in a load with off = -16, as bpf_rbtree_first's return is
>>>
>>> Looks like the bug in the previous patch:
>>> +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
>>> +                                  meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
>>> +                               struct btf_field *field = meta.arg_rbtree_root.field;
>>> +
>>> +                               mark_reg_datastructure_node(regs, BPF_REG_0,
>>> +                                                           &field->datastructure_head);
>>>
>>> The R0 .off should have been:
>>>  regs[BPF_REG_0].off = field->rb_node.node_offset;
>>>
>>> node, not root.
>>>
>>> PTR_TO_BTF_ID should have been returned with approriate 'off',
>>> so that container_of() would it bring back to zero offset.
>>>
>>
>> The root's btf_field is used to hold information about the node type. Of
>> specific interest to us are value_btf_id and node_offset, which
>> mark_reg_datastructure_node uses to set REG_0's type and offset correctly.
>>
>> This "use head type to keep info about node type" strategy felt strange to me
>> initially too: all PTR_TO_BTF_ID regs are passing around their type info, so
>> why not use that to lookup bpf_rb_node field info? But consider that
>> bpf_rbtree_first (and bpf_list_pop_{front,back}) doesn't take a node as
>> input arg, so there's no opportunity to get btf_field info from input
>> reg type. 
>>
>> So we'll need to keep this info in rbtree_root's btf_field
>> regardless, and since any rbtree API function that operates on a node
>> also operates on a root and expects its node arg to match the node
>> type expected by the root, might as well use root's field as the main
>> lookup for this info and not even have &field->rb_node for now.
>> All __process_kf_arg_ptr_to_datastructure_node calls (added earlier
>> in the series) use the &meta->arg_{list_head,rbtree_root}.field for same
>> reason.
>>
>> So it's setting the reg offset correctly.
> 
> Ok. Got it. Than the commit log is incorrectly describing the failing scenario.
> It's a container_of() inside bool less() that is generating negative offsets.
> 

I noticed this happening with container_of() both inside less() and in the
example in patch summary. Specifically in the rbtree_first_and_remove 'success'
selftest added in patch 13. There, operations like this:

  bpf_spin_lock(&glock);
  res = bpf_rbtree_first(&groot);
  if (!res) {...}

  o = container_of(res, struct node_data, node);
  first_data[1] = o->data;
  bpf_spin_unlock(&glock);

Would fail to set first_data[1] to the expected value, instead setting
it to 0. 

>>> All PTR_TO_BTF_ID need to have positive offset.
>>> I'm not sure btf_struct_walk() and other PTR_TO_BTF_ID accessors
>>> can deal with negative offsets.
>>> There could be all kinds of things to fix.
>>
>> I think you may be conflating reg offset and insn offset here. None of the
>> changes in this series result in a PTR_TO_BTF_ID reg w/ negative offset
>> being returned. But LLVM may generate load insns with a negative offset,
>> and since we're passing around pointers to bpf_rb_node that may come
>> after useful data fields in a type, this will happen more often.
>>
>> Consider this small example from selftests in this series:
>>
>> struct node_data {
>>   long key;
>>   long data;
>>   struct bpf_rb_node node;
>> };
>>
>> static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>> {
>>         struct node_data *node_a;
>>         struct node_data *node_b;
>>
>>         node_a = container_of(a, struct node_data, node);
>>         node_b = container_of(b, struct node_data, node);
>>
>>         return node_a->key < node_b->key;
>> }
>>
>> llvm-objdump shows this bpf bytecode for 'less':
>>
>> 0000000000000000 <less>:
>> ;       return node_a->key < node_b->key;
>>        0:       79 22 f0 ff 00 00 00 00 r2 = *(u64 *)(r2 - 0x10)
>>        1:       79 11 f0 ff 00 00 00 00 r1 = *(u64 *)(r1 - 0x10)
>>        2:       b4 00 00 00 01 00 00 00 w0 = 0x1
>> ;       return node_a->key < node_b->key;
> 
> I see. That's the same bug.
> The args to callback should have been PTR_TO_BTF_ID | PTR_TRUSTED with 
> correct positive offset.
> Then node_a = container_of(a, struct node_data, node);
> would have produced correct offset into proper btf_id.
> 
> The verifier should be passing into less() the btf_id
> of struct node_data instead of btf_id of struct bpf_rb_node.
> 

The verifier is already passing the struct node_data type, not bpf_rb_node.
For less() args, and rbtree_{first,remove} retval, mark_reg_datastructure_node
- added in patch 8 - is doing as you describe.

Verifier sees less' arg regs as R=ptr_to_node_data(off=16). If it was
instead passing R=ptr_to_bpf_rb_node(off=0), attempting to access *(reg - 0x10)
would cause verifier err.

>>        3:       cd 21 01 00 00 00 00 00 if r1 s< r2 goto +0x1 <LBB2_2>
>>        4:       b4 00 00 00 00 00 00 00 w0 = 0x0
>>
>> 0000000000000028 <LBB2_2>:
>> ;       return node_a->key < node_b->key;
>>        5:       95 00 00 00 00 00 00 00 exit
>>
>> Insns 0 and 1 are loading node_b->key and node_a->key, respectively, using
>> negative insn->off. Verifier's view or R1 and R2 before insn 0 is
>> untrusted_ptr_node_data(off=16). If there were some intermediate insns
>> storing result of container_of() before dereferencing:
>>
>>   r3 = (r2 - 0x10)
>>   r2 = *(u64 *)(r3)
>>
>> Verifier would see R3 as untrusted_ptr_node_data(off=0), and load for
>> r2 would have insn->off = 0. But LLVM decides to just do a load-with-offset
>> using original arg ptrs to less() instead of storing container_of() ptr
>> adjustments.
>>
>> Since the container_of usage and code pattern in above example's less()
>> isn't particularly specific to this series, I think there are other scenarios
>> where such code would be generated and considered this a general bugfix in
>> cover letter.
> 
> imo the negative offset looks specific to two misuses of PTR_UNTRUSTED in this set.
> 

If I used PTR_TRUSTED here, the JITted instructions would still do a load like
r2 = *(u64 *)(r2 - 0x10). There would just be no BPF_PROBE_MEM runtime checking
insns generated, avoiding negative insn issue there. But the negative insn->off
load being generated is not specific to PTR_UNTRUSTED.

>>
>> [ below paragraph was moved here, it originally preceded "All PTR_TO_BTF_ID"
>>   paragraph ]
>>
>>> The apporach of returning untrusted from bpf_rbtree_first is questionable.
>>> Without doing that this issue would not have surfaced.
>>>
>>
>> I agree re: PTR_UNTRUSTED, but note that my earlier example doesn't involve
>> bpf_rbtree_first. Regardless, I think the issue is that PTR_UNTRUSTED is
>> used to denote a few separate traits of a PTR_TO_BTF_ID reg:
>>
>>   * "I have no ownership over the thing I'm pointing to"
>>   * "My backing memory may go away at any time"
>>   * "Access to my fields might result in page fault"
>>   * "Kfuncs shouldn't accept me as an arg"
>>
>> Seems like original PTR_UNTRUSTED usage really wanted to denote the first
>> point and the others were just naturally implied from the first. But
>> as you've noted there are some things using PTR_UNTRUSTED that really
>> want to make more granular statements:
> 
> I think PTR_UNTRUSTED implies all of the above. All 4 statements are connected.
> 
>> ref_set_release_on_unlock logic sets release_on_unlock = true and adds
>> PTR_UNTRUSTED to the reg type. In this case PTR_UNTRUSTED is trying to say:
>>
>>   * "I have no ownership over the thing I'm pointing to"
>>   * "My backing memory may go away at any time _after_ bpf_spin_unlock"
>>     * Before spin_unlock it's guaranteed to be valid
>>   * "Kfuncs shouldn't accept me as an arg"
>>     * We don't want arbitrary kfunc saving and accessing release_on_unlock
>>       reg after bpf_spin_unlock, as its backing memory can go away any time
>>       after spin_unlock.
>>
>> The "backing memory" statement PTR_UNTRUSTED is making is a blunt superset
>> of what release_on_unlock really needs.
>>
>> For less() callback we just want
>>
>>   * "I have no ownership over the thing I'm pointing to"
>>   * "Kfuncs shouldn't accept me as an arg"
>>
>> There is probably a way to decompose PTR_UNTRUSTED into a few flags such that
>> it's possible to denote these things separately and avoid unwanted additional
>> behavior. But after talking to David Vernet about current complexity of
>> PTR_TRUSTED and PTR_UNTRUSTED logic and his desire to refactor, it seemed
>> better to continue with PTR_UNTRUSTED blunt instrument with a bit of
>> special casing for now, instead of piling on more flags.
> 
> Exactly. More flags will only increase the confusion.
> Please try to make callback args as proper PTR_TRUSTED and disallow calling specific
> rbtree kfuncs while inside this particular callback to prevent recursion.
> That would solve all these issues, no?
> Writing into such PTR_TRUSTED should be still allowed inside cb though it's bogus.
> 
> Consider less() receiving btf_id ptr_trusted of struct node_data and it contains
> both link list and rbtree.
> It should still be safe to operate on link list part of that node from less()
> though it's not something we would ever recommend.

I definitely want to allow writes on non-owning references. In order to properly
support this, there needs to be a way to designate a field as a "key":

struct node_data {
  long key __key;
  long data;
  struct bpf_rb_node node;
};

or perhaps on the rb_root via __contains or separate tag:

struct bpf_rb_root groot __contains(struct node_data, node, key);

This is necessary because rbtree's less() uses key field to determine order, so
we don't want to allow write to the key field when the node is in a rbtree. If
such a write were possible the rbtree could easily be placed in an invalid state
since the new key may mean that the rbtree is no longer sorted. Subsequent add()
operations would compare less() using the new key, so other nodes will be placed
in wrong spot as well.

Since PTR_UNTRUSTED currently allows read but not write, and prevents use of
non-owning ref as kfunc arg, it seemed to be reasonable tag for less() args.

I was planning on adding __key / non-owning-ref write support as a followup, but
adding it as part of this series will probably save a lot of back-and-forth.
Will try to add it.

> The kfunc call on rb tree part of struct node_data is problematic because
> of recursion, right? No other safety concerns ?
> 
>>>
>>>> modified by verifier to be PTR_TO_BTF_ID of example_node w/ offset =
>>>> offsetof(struct example_node, node), instead of PTR_TO_BTF_ID of
>>>> bpf_rb_node. So it's necessary to support negative insn->off when
>>>> jitting BPF_PROBE_MEM.
>>>
>>> I'm not convinced it's necessary.
>>> container_of() seems to be the only case where bpf prog can convert
>>> PTR_TO_BTF_ID with off >= 0 to negative off.
>>> Normal pointer walking will not make it negative.
>>>
>>
>> I see what you mean - if some non-container_of case resulted in load generation
>> with negative insn->off, this probably would've been noticed already. But
>> hopefully my replies above explain why it should be addressed now.
> 
> Even with container_of() usage we should be passing proper btf_id of container
> struct, so that callbacks and non-callbacks can properly container_of() it
> and still get offset >= 0.
> 

This was addressed earlier in my response.

>>>>
>>>> A few instructions are saved for negative insn->offs as a result. Using
>>>> the struct example_node / off = -16 example from before, code looks
>>>> like:
>>>
>>> This is quite complex to review. I couldn't convince myself
>>> that droping 2nd check is safe, but don't have an argument to
>>> prove that it's not safe.
>>> Let's get to these details when there is need to support negative off.
>>>
>>
>> Hopefully above explanation shows that there's need to support it now.
>> I will try to simplify and rephrase the summary to make it easier to follow,
>> but will prioritize addressing feedback in less complex patches, so this
>> patch may not change for a few respins.
> 
> I'm not saying that this patch will never be needed.
> Supporting negative offsets here is a good thing.
> I'm arguing that it's not necessary to enable bpf_rbtree.
