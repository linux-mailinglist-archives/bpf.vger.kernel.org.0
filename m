Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86058D071
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHHXYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:24:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C51ADB3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:24:06 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278J4mY5011534;
        Mon, 8 Aug 2022 16:23:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/swjDSzJo5IlFqUN0+KHdYiMu4GnHUJ3W6EkgwCADHc=;
 b=B2nAiouzehKEUdQEuKGgmSbPDxaEFvQIAcpd0SS8Xc6K1FFL/h1MdrPKhq3GLn1WbZfR
 NbgnXf+IdGdrp4zN3c9DihdtAfPQkRKGSQBhfNxF1ZBz1ZllFqQzFJGUQKZ1RqUrzs59
 /PhVcqmCOSnvDFcNewqq21rBIWAOIGFCG+0= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3htxr4nkja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 16:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcjiqYy88j69LUbpadwukr1raAxZptt38oBItT1uByVRVYzKSA3v2QyGdGAQziBJ4K2wVUhC7yv6uspR9bKW/hAZ6xlu8ddMNlOpnD82ybGueti2OchXwRmx/KcL0nwH1UPVlTi8VJe4YeiZy28tmgqqEBSQ1dHfmmQ9bBTUzDdBZYtMvcR0ZTqrwTIlMmTCz4+9o5IS9hGRk8MkB1Q34t1lJRGoJmDAlYtUpbp1DLuUJ2DlnhxrrwWzSo9JnUs0MAkLCW8qLgkkYbIfnBr7PoKJLur9iLxOnlJlp5WOsd8hgN20k0ZOUcIrknJQGxFyX9ZWcO+PYKSwJYRvmUsXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/swjDSzJo5IlFqUN0+KHdYiMu4GnHUJ3W6EkgwCADHc=;
 b=ZFAJKuxTF//LoMfFhH4T1UaTf2Ju9RB/pCp5IXNzBTVxKbOSDTEojOqisik6Wc9w5D5YdKRm9h4hoW06d67rUEhIYt3Wtp+DkSFL1q4EfLGVnjJ0LyLsDw9bRPavI8VXuNJfWDUmne2eUaE+Ps87efZGMgD5h+q1jg/pnCsGjG8Z/+rl77/ZtFX0dRGkRuKf3tD3GGioamIV7K4Cr5Agg0mdJUJkcBqX9YGZa//HSJWLN6ns6ASso/cfffkZdYRyK16EmXIkuU6pO1Y5HdNEWVfOyyW83yJscharTnTRswYOFmFSJrB1Ot1Pg5EJF7sC0GIslt+6oML60vTHS7ZS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1756.namprd15.prod.outlook.com (2603:10b6:4:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 23:23:48 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::fd9e:186:4e22:21eb]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::fd9e:186:4e22:21eb%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 23:23:47 +0000
Message-ID: <1052d7fa-3c36-6995-7455-1287fd8fab90@fb.com>
Date:   Mon, 8 Aug 2022 16:23:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in
 prealloc_lru_pop
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "toke@redhat.com" <toke@redhat.com>
References: <20220806014603.1771-1-memxor@gmail.com>
 <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com>
 <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
 <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com>
 <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27a74a7-1bd5-4266-2e16-08da79950b72
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE8520Z5mNin7U9ZEYiGgHZ5D9CeLt6pdnOHEC0FknozmdjVf+a9RF7psm6sX5wYddusWZz0+DvjuLWaPk7fLRYQrQk3Oe1twT89tRTWDKwcit84Aaw2XipT9yy3cW5eaOAIM+QDzt+KCpme27PgqnOvYgNj30M3SgRGGmmIQEXXcR9/EgyVMYWk64s8CMGgjRTqMZBPvMWsfNBIyk6+tPGw+7mpZX2mpwuFpD3r6nliarepvS0GNbqzMalWglcl7xG82eV1gbfl4Nf6LUYj4dlljQuVTqVhK090U34ABVDaKrK/RWoHLe7Vbh2PeP1wpyhpqDiaPcFrqQOt8K5sMN4eISemc6ghWpW3Aa3U8c8O9Pzv5LZ+sxtHhwP+9p85ifn+6eQTSSddHwYvr0f20gg+yltz6+OoEuIF4vp+35ZklNh0Ft9VY59RTuPUohSRufLynV9mt5A6sk4mdh+2mD+njqniZ4/A6yIyNLrd+4N8ANqrcWAeNqDexMiwWWwMumXvmsC9r09Y4EPfh4lsgBEb5TVTm6lckstGgRJ/ZP/OC1pB/hgcVwKhntK2sx1Thuvh/uzcYBWJoG7vSrS6SNgeOvrtXRXupiEKMEWIkkH1R5Tr0aPzIubVzJZAr3JtjBr/rBtiOBtK6KtJiC9CYu5H/9AGkrjSXjnWcgcp5ZKSB7IkN7NzZM4gJW45pnEh1nQYm5T3GoC4Uu8gNreYFPnad5L5wv0TPP2XhBZZPXCDZlu3ESBUt9peTYO5yRdWF0Zzm5RF36kgath0O9/DmrjqOEqq90OhuQ5yfKreEcj9eVNU/OuwNfANEkWg1i8A+DqkxcYzfLcw8tqRcz7pmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(2906002)(53546011)(316002)(6916009)(186003)(2616005)(6512007)(6506007)(41300700001)(83380400001)(36756003)(86362001)(31686004)(31696002)(54906003)(6486002)(66556008)(66476007)(8936002)(66946007)(5660300002)(478600001)(4326008)(8676002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5adUgvbExYZVN0OHE4L2Z1SW10YXRIMlh2Tjg3M0FmUEZiTDRpVXI4dllk?=
 =?utf-8?B?bG5HY1lrL1VyaVZPc1h0VjRaYWNUb0J3c3c3UXdjaitieTBSL01KbWdML2gz?=
 =?utf-8?B?ZVF1RVdQcWcxcjhWQ2J1cUFuV1c0T2lvR0FpYlNqRjRuRzdlVEVEMnZOY3VG?=
 =?utf-8?B?bzk3OWhSSVJRNW5tQ0c4TGJHaWFNQVd4OTd3K3pxSXhoQmszTktJL2NjVmRL?=
 =?utf-8?B?WVMvVmE3L1k2U1BZbWNieTU5Skw3dzRCWDZPa1ltUVF2aXdEQnR4bExMaEtN?=
 =?utf-8?B?aWlGVENqK0ZiVGN3KzZRbW0xamsyZjZjZ01oNXdJSW9sbWYxaFRraFRLMFl3?=
 =?utf-8?B?MmovdkRrbUp2RTh0QzcrUG5YYVhDUVdiS0dRZWlUMDRUN082SW1QUTBEckVN?=
 =?utf-8?B?eEtvQ05idWdLeFpsMG95L1NHMUlXMk5SWGxEYlh0UkhqN3dnN3JrQmp0dTRS?=
 =?utf-8?B?bDFZVytTSm0yYXVUVGQvbWxDSlB6eHB6MnVKekRKT0F4R0hFbkxjZFFKZ0o5?=
 =?utf-8?B?N0k1QkwzeXYzM2QxNnJGWnRtZ0FCZHV6WjFsVHg3aE0zajNtTWtGQWRIQXRD?=
 =?utf-8?B?L0VkeVpybGtuUUJNYktVNDd6SDN3VnM1WXVGUGlNWXpsTEdxRGU0SmJldzdX?=
 =?utf-8?B?K3RwY2RuZk5oa25qR09rczdnTTRwenRoOXJjaTBNeFNrRlpYalh1MlRhQVJq?=
 =?utf-8?B?b256Nmg1MXpMV0JEUXoxdlFqbS84dDU3VXRCMEErTjVLei9QWUl2YVM1d01m?=
 =?utf-8?B?Q1o5dS9EQmF5NE5XY05PZVJiQnRyY0lmVVo2NTYvYkRZMnhDb2JFcFM2Q3Zk?=
 =?utf-8?B?Vy81ZmhGOTZRNHYwLzlKWmVvY2lrVGw3NWtic01wK2d0dlkwZGJDdjk5akUx?=
 =?utf-8?B?amQzV21VdkNvaVJtNmR4NXRRaklVdHBFNlpBdlJiNzZIOEVjK1R5MjVIQnZ4?=
 =?utf-8?B?SUtjNHU0amIrTUIyV0ZtQkF1alBMbUZXakpoMHJqalBibEViNEEvczlUUHFP?=
 =?utf-8?B?WkhHUVgrM1FONmwrUlJna01HaTl2dS9KSUI4OHhoOFRyMENVTXg3Yml2R3lR?=
 =?utf-8?B?NGhSQm9tOEd4Yzc4cE52Q0tWRkpFeWJod3N5ei9FMGxGeDBjWG52b0NtQ0t2?=
 =?utf-8?B?cWtiSmdyRXQ0cUlvZ1pmQnNoNmNyeFJzTzh2MHNPa09NZkUxS1lNbXh4WGFJ?=
 =?utf-8?B?ZElCcVphVUR3MkRDbi9aUEw4dEdIQ0NHRW84c2dDanJlMXp2SitVTkJJSGJy?=
 =?utf-8?B?OEtUZTA4ek9BUVFSb2Z2WGZLSnJsOGxhY2l2Y0c5SEZXV3FtY0tmZ0VBdlJT?=
 =?utf-8?B?SE4zNU1vRUtPZjhDenJQZmJublJGNEkyeVZLQklvTmZMZjFSb25WOUd5RWVq?=
 =?utf-8?B?bjVlNC8wOXFzcjJRNFllRVF3QTNOaU9WOXZ0a2t2Q2EvUmZlcFhYVlhGa2g3?=
 =?utf-8?B?MlJYMnJ6cnQ2YkE1eGk2ajM0NXNxYVpYZkRwcjQxc3ZqVGJFeUNDc0N4bFl2?=
 =?utf-8?B?dnBISm1tUUFmS2xOdGJ2L2toOGFvWjZjamkwMzlQQkYwWC9MUnVBNmlUcmo5?=
 =?utf-8?B?STNrT0lDNkJ0enRkeGtzaGFXZkNUMU1MbjBpL3dFaWJ0dk95RjZPMWh2cUJQ?=
 =?utf-8?B?YjBVNUVNWFZqMEx5bUhwbVlUN0RFbEtwd2pMSlgvajI5YUFPK3hjc2czdStt?=
 =?utf-8?B?ZllsRFlET2ZiRDNWMjk4UnV2b05BQ2hKVjdleXFZK1pHcm1UejVYeGdMVWJl?=
 =?utf-8?B?MzA5akJlWk1Fb2FKczNsSzFiWkh6VmRlQ3ZFdE51K0pRSlJtNkpsN3BxeGpa?=
 =?utf-8?B?ZE1rNmFaMTBvVkMwT00zNndZcUdVYUI2NUdsUHhWcUp1eTR0Vi9pa281bDh1?=
 =?utf-8?B?TDRURWN4RHNPSk5GWnU2NWU1WHUxbk9ucXNJMTZoUGdCYzdTQ09KRkMxcG1P?=
 =?utf-8?B?aW1hUjdKUjhBUU1URUh0bEl3eWdpQ0h3bm83QnFXaS9jdVhTWFJQR0JEaTFY?=
 =?utf-8?B?SDRGTlc2KzBwNzVJYk53enMzeHl3TWNZbFlNcW9JcFVDWmZxcWFhYU1wby9j?=
 =?utf-8?B?cEFIdEs4L09CT3k3SjBZc0tZOER3QlVNV1F5YjV5YWtLdmZleDFTcEgwMitp?=
 =?utf-8?B?czhtZkNKR2VWbTlsQzFEakJPOUt2Y1JHY2N0TWM0UWQyblJJRFZmUzNibjJN?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27a74a7-1bd5-4266-2e16-08da79950b72
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 23:23:47.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8jlAdlpiTWJ7bPHB2U2QVtVzWZEN9F/cFBdlM4zmElw4jmdZyOOeSqotfkziqmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-Proofpoint-ORIG-GUID: HDegFNrOXKJ2KuKujIzyWDCHhCpHk37y
X-Proofpoint-GUID: HDegFNrOXKJ2KuKujIzyWDCHhCpHk37y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/8/22 11:55 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 8 Aug 2022 at 18:19, Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/8/22 4:18 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Mon, 8 Aug 2022 at 08:09, Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
>>>>> The LRU map that is preallocated may have its elements reused while
>>>>> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
>>>>> only check_and_free_fields is appropriate when the element is being
>>>>> deleted, as it ensures proper synchronization against concurrent access
>>>>> of the map value. After that, we cannot call check_and_init_map_value
>>>>> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
>>>>> they can be concurrently accessed from a BPF program.
>>>>
>>>> If I understand correctly, one lru_node gets freed and pushed to free
>>>> list without doing check_and_free_fields().
>>>
>>> I don't think that's true, there is a check_and_free_fields call on
>>> deletion right before bpf_lru_push_free in htab_lru_push_free.
>>> Then once the preallocated items are freed on map destruction, we free
>>> timers and kptrs again, so if someone has access to preallocated items
>>> after freeing e.g. through an earlier lookup, we still release
>>> resources they may have created at the end of map's lifetime.
>>>
>>>> If later the same node is used with bpf_map_update_elem() and
>>>> prealloc_lru_pop() is called, then with this patch,
>>>> check_and_init_map_value() is not called, so the new node may contain
>>>> leftover values for kptr/timer/spin_lock, could this cause a problem?
>>>>
>>>
>>> This can only happen once you touch kptr/timer/spin_lock after
>>> deletion's check_and_free_fields call, but the program obtaining the
>>> new item will see and be able to handle that case. The timer helpers
>>> handle if an existing timer exists, kptr_xchg returns the old pointer
>>> as a reference you must release. For unreferenced kptr, it is marked
>>> as PTR_UNTRUSTED so a corrupted pointer value is possible but not
>>> fatal. If spin_lock is locked on lookup, then the other CPU having
>>> access to deleted-but-now-reallocated item will eventually call
>>> unlock.
>>
>> Thanks for explanation. Originally I think we should clear everything
>> including spin_lock before putting the deleted lru_node to free list.
>> check_and_free_fields() only did for kptr/timer but not spin_lock.
>>
>> But looks like we should not delete spin_lock before pushing the
>> deleted nodes to free list since lookup side may hold a reference
>> to the map value and it may have done a bpf_spin_lock() call.
>> And we should not clear spin_lock fields in check_and_free_fields()
>> and neither in prealloc_lru_pop() in map_update. Otherwise, we
>> may have issues for bpf_spin_unlock() on lookup side.
>>
>> It looks timer and kptr are already been handled for such
>> cases (concurrency between map_lookup() and clearing some map_value
>> fields for timer/kptr).
>>
> 
> Yes, I also took a look again at other call sites of
> check_and_init_map_value and everything looks sane.

Sounds good.

> 
>>>
>>> It is very much expected, IIUC, that someone else may use-after-free
>>> deleted items of hashtab.c maps in case of preallocation. It can be
>>> considered similar to how SLAB_TYPESAFE_BY_RCU behaves.
>>>
>>>> To address the above rewrite issue, maybe the solution should be
>>>> to push the deleted lru_nodes back to free list only after
>>>> rcu_read_unlock() is done?
>>>
>>> Please correct me if I'm wrong, but I don't think this is a good idea.
>>> Delaying preallocated item reuse for a RCU grace period will greatly
>>> increase the probability of running out of preallocated items under
>>> load, even though technically those items are free for use.
>>
>> Agree. This is not a good idea. It increased life cycle for preallocated
>> item reuse and will have some performance issue and resource consumption
>> issue.
>>
>>>
>>> Side note: I found the problem this patch fixes while reading the
>>> code, because I am running into this exact problem with my WIP skip
>>> list map implementation, where in the preallocated case, to make
>>> things a bit easier for the lockless lookup, I delay reuse of items
>>> until an RCU grace period passes (so that the deleted -> unlinked
>>> transition does not happen during traversal), but I'm easily able to
>>> come up with scenarios (producer/consumer situations) where that leads
>>> to exhaustion of the preallocated memory (and if not that, performance
>>> degradation on updates because pcpu_freelist now needs to search other
>>> CPU's caches more often).

Thinking again. I guess the following scenario is possible:

      rcu_read_lock()
         v = bpf_map_lookup_elem(&key);
         t1 = v->field;
         bpf_map_delete_elem(&key);
            /* another bpf program triggering bpf_map_update_elem() */
            /* the element with 'key' is reused */
            /* the value is updated */
         t2 = v->field;
         ...
      rcu_read_unlock()

it is possible t1 and t2 may not be the same.
This should be an extremely corner case, not sure how to resolve
this easily without performance degradation.

>>>
>>> BTW, this would be fixed if we could simply use Alexei's per-CPU cache
>>> based memory allocator instead of preallocating items, because then
>>> the per-CPU cache gets replenished when it goes below the watermark
>>> (and also frees stuff back to kernel allocator above the high
>>> watermark, which is great for producer/consumer cases with alloc/free
>>> imbalance), so we can do the RCU delays similar to kmalloc case
>>> without running into the memory exhaustion problem. >>
>> Thanks for explanation. So okay the patch looks good to me.
>>
>>>
>>>>
>>>>>
>>>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
> 
> Thanks! I'll summarize our discussion in short and add it to the commit log.
