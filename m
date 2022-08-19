Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1409A599829
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347363AbiHSIzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbiHSIzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A22D34D2
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 01:55:18 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IKhdmc017417;
        Fri, 19 Aug 2022 01:55:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=diK1DkRLfsU7uUCTP5XRPhDH82leCoUqCQ45IFyo3ew=;
 b=O9xfElzoyX98Sm1yR4X9VOlR2ykZvV6XgP+R5i0Bayiw90mGXNPJlFNMERq4m0iuuZqW
 eqtqPlGf/qjg8TFbQxlrfdef3YC818mKY+HOlXzCmr1jZgFXY+/61F/vzA3kbxgzYbgt
 6LAtYsBL5sZcoC9/GeJ5qcbV+Fjsvukr+Os= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1sdvvjv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 01:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxnwLYu9zihpVmyzXipXsdqCsCXmVWlQGaw4WxWjcWDdO/KP9l6uGHplyz6s/eAkMjSmvm/bUaIPgRhwQECMr88sCmmLMyjMOnMb7P00aOcgTQY16lFVUnJAGBIh2QEKBd3ijwY/JTSVSIXM/B5rYooqIIxMr1POihLNJhtCAxqEWmh/npaZznGXA+7Z0R2Auj7d1CsbuWGLPMS3mYkl/QLaSQznXAYmkCCBJ5FmUZ0tfttVlCNq9BcO6cYkTAEISzL3NOmvEe8zY57inhVEXNG/ppu1Shcaoeq1PPE3PtHs7OcAcGgZVE5F/2UI9jtDGSmMbc1LE1QC10Ywe5nK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diK1DkRLfsU7uUCTP5XRPhDH82leCoUqCQ45IFyo3ew=;
 b=bj3te1JigGVmF2saTvpjOKjH89pgGbwAoqEzGiThRxx13X2p4Itk4nGO01knP64OWXIm7xKCjI9JDw00WE4hY+Ix/R9y6mNUG8Y/jR8ZsZL1Go4KjQ8q5b63FyKkXRD44hSzmhLItTNjkyZkwwmMSuu3TK0mF6+ZpI+3nArohro24zwRKqBW62YBpnVRkmANieKEVTvM+ooAfZTfKzHTRO0/Dnh1c/JPMORO6/fPG+AV29iwY891WiPmHdMjEj/dMYUAQJ7NsIAxQVUjWnuKvwewQSEy4Uuj+ywCjxug8yg05ZD2ixbSiKCu6pxLhz+FBDyhunui3FpDq0ZfDNOuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2217.namprd15.prod.outlook.com (2603:10b6:5:87::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 08:55:11 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::4081:88e5:cfe2:bd8c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::4081:88e5:cfe2:bd8c%4]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 08:55:11 +0000
Message-ID: <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
Date:   Fri, 19 Aug 2022 04:55:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: BPF Linked Lists discussion
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.next, andrii@kernel.org
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::28) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae231868-27da-4cfb-0f52-08da81c08645
X-MS-TrafficTypeDiagnostic: DM6PR15MB2217:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EbT5EioH7mSYfgDrxNbsKtxapHyV6MmuDgI28foPor6tYeVF5u3i2ZukJMe7QHt3ed5qUN6T8pUq/FnQoijqtPYox2NtAU0dm/VnebIjbQ8s778sgSB4UGNnjmtyiX5Y8wDF27fexOgO8sQt2PUZVTyccfg9xyIWzDufLfFevYmmn3/d6y7CqViTC4q2MJPSqpqtxajSw5sPAxTu6TLKJxzutXoYBSbvoDxe3NwDB9Jo7OU/6yvne4Ixr/t1fgiGdw1jVu0SkbyI57zGga+We3mJzkUkh0lPxa5BzQpSplcxwcgstFl27Avlpt4EC4Apltlb5hMrjGmXYa/9/2Zz/ScrgQ/Yh8iAN0ZU8Q8U0sRrQS+aT4oX+MpbhTuZJzuI3HbNET5QQ6F5BMBsDSMLGoA95zH6IljUGGgtIwnOBWvtmsH7KH1MlhsN9AXMIo/qiEGzwBso326nFocHGT8Cjw9PlDX0MdL4v0qBEB+/+6FkzGBNRgkpkL+RCjM/1ahaUlO7hfDegbjDRhONMw2buVhZJEYa5JlijFTDX6nforblx9iLf3sVtPfvXjDq2HTwLw7DLNZDO+/trj1zzHsQq22cuxmvdhZ8NMlisWUjH491BuPvZ+y7nc5sr/lJalupqFNK/SROoe4AGKIL5MmVAtupNgjHa+mYhcnFuflN+DBu0MfG9vGA/S0CqCR2lcU9g6FTzFxyxm38JHZyZb68bSGaGGhWGbsYWKusCB0SsbBjm+K2UBBDyHpkPeh7l3qsFv/BADselVVoWwqwy2en7RahTARcsmM+WG0bb3Dh/MWQVTjQZEb6xX9OFInJh9CdC/b/+ZP9VhLHDjDwy6myQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(66946007)(36756003)(66476007)(4326008)(38100700002)(66556008)(8676002)(31686004)(31696002)(86362001)(3480700007)(83380400001)(6512007)(6506007)(966005)(478600001)(6486002)(53546011)(41300700001)(316002)(186003)(2906002)(2616005)(8936002)(5660300002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJNQ3RnWFhJVVUzQ01UWU9saWZHRFJkeWtGNjU4b25YVFJnYWxPUzJ6V0h3?=
 =?utf-8?B?d1BVY2xzUUwwVTFEckgrZnlRL0x5QTVYMU1wTng2dlBnNisyVzZrY2NIRXJM?=
 =?utf-8?B?cVpwRGRmV29CTFZhcU9OU1Q3MFl5QTZwaFp0OHJTOC8weklHUU5CcWwrTDdB?=
 =?utf-8?B?M3NOZUVVKzVwOU0zQzdiZ0hvc2gzYjA0aFNtNFlXVzE2dFdEMk80YXNmQWZG?=
 =?utf-8?B?aDlqNXhaTzhFZjNaR21YY0hUTWp2My9MVEc0cm13VENsV1NzMkloM2g5MEI0?=
 =?utf-8?B?QjNJNlcrK0ViOFU1UHF6UlgveEZvYXp1cGEwNDEvOGFzN0Jtc2c5K1BsZGx1?=
 =?utf-8?B?RUFVWEV1cWJJWnVoMUFVM3JoeWlWbVplYkpHdFl2Y1hNTStrb095MjNvSFhY?=
 =?utf-8?B?NVEzS2JKRnd0eEVaaDl3Qk9ZUXdVZytwL05SdHpUY0xobGJmaHRaVTY0anpO?=
 =?utf-8?B?akFKMjFWaWh0WExoZDE0cG5IdS9vcDVVMmlNdFVFWnBSN1ZTeEZ2NHZBVmgv?=
 =?utf-8?B?K2JCNzhvNVJyRm94U1JpU1VZdm5tSVlxQXVmbGZVU0ZxdzJMMFYrbEl6MXFO?=
 =?utf-8?B?dGpFUy84TXc5Y1BXejRsbXB5K0xHUEM1VlF3dUtEUmMzYlgzYzNUWUlVQmpH?=
 =?utf-8?B?Q0FpMlQ0YURpdVd0QVc4RzVyRmJZU0xEMFdTY0poQUxnaHc2b1FhMUpEOElo?=
 =?utf-8?B?VWc3azF2dXRMemFlY1N5K3ZXSDExUW9kTlkvMjBsdytZTkJSdm1udXJFZDlx?=
 =?utf-8?B?VWw2eWJJSURHVmtFK0NJenB4clMyV0FnR0JhZ1A0VkN6cDVrWGo5WEhFTCta?=
 =?utf-8?B?ZmpxcHpFTGxzMm82QWJxVDZmeEV4UUNINEk5OUR2cC9qUzIrc25xblBXY2FF?=
 =?utf-8?B?WEwySTRnWDExTWl6T2xEWDU4aDR4U3U3WEQxajRRM1puekpmNWNVeGQvWGhR?=
 =?utf-8?B?MjMzZVhib2w2MHUrU1dDc0g0dlcybVBKamtweTRWUmsyc3QwcktnOHVoOHhu?=
 =?utf-8?B?eDUvWWx3ckVMM1NYemtrUG5lQXhLOEl1Rkx0anlVUXArbjI5REFvSmtrYUNj?=
 =?utf-8?B?SWl6ak9MblQwVXkzbzd4YVR4UGpoUkUxV2tkNU1CK2ZxRXk3NzkzamZ0VlMv?=
 =?utf-8?B?c3Rob0NjaDJDaEhwQzlScGRhNi9XN0paWU52MzJvQVQ3aUxuaytGVnFBN3ZK?=
 =?utf-8?B?WHF0QTN2RDd2TWZGcGlNZ1hoN3NmQmZpeHMzTHZSLzlhQlRsaUJKTGE0cEZx?=
 =?utf-8?B?SCt3Z3Bvb2ViaGMxNUhydmZsOWVyVERSYUFMQjFVTmM5VzRrU0RqZFZzNEhi?=
 =?utf-8?B?SkptUUdpRFh5T09tVjFNa2s4ZUNQaElFaURnMWRkQUpmVGJVWmxZL012TW0x?=
 =?utf-8?B?dXZINFdpdG1xbnNnZzNnT3BMYVNsSEdIeDIrMUZqZjEveWZMU2xFUktuLzNO?=
 =?utf-8?B?cEwrK0svcjRXV0kxTXpjbGR2aW0zVEVMeTYyR3hPOUdsM2ovK2l3Q3QzZlNZ?=
 =?utf-8?B?ZCt6bno2L01nRllZNXUvRUIxOWUycEpZZTh0K1BXc0tVNnp5WmJQQXBiRnFM?=
 =?utf-8?B?WXNtSGVyYUhpYVMxVksxdzZpU3J4SEdVZ29VOEpxWTlGTEZRQ0NCQW9TUTN3?=
 =?utf-8?B?bkJ1RjFJcjRzWVQrTXdhYndmTmV0dStldFhiWHBHWjVhNk55T1pXTDFoSmlS?=
 =?utf-8?B?Wm81bXRZclE2WU9VQzNreHVNcnAyN1hXUTAxOUtPMituQ2NLMWJ1Y1F3cWh1?=
 =?utf-8?B?Sk5MYTJoVzlBanhEVE4yYktSenViREt4VUxTc1hwYllCcU9FbVc3bHB5Tldm?=
 =?utf-8?B?NjlVREh6TGpwQ1ZCNkxuZnVQd3ByUjVwbS8rVE1kWGRVSlR0UklWZFV1VUxV?=
 =?utf-8?B?SDB2OWhPT3lRY3VhMVpwV2FLemZ2NnEyaC9udDlrL1VyaURSTGJNWnFzUjdl?=
 =?utf-8?B?Rm9uTGIwZ2draEcwNDBTelg4a1hGS0podjczQ3JXV3pNSWlwMmtzdy9VVnRC?=
 =?utf-8?B?NjlDMmQ2T3lVVEMyOHdPTWRYZFBGYWoram5pdHpDY3hPWTI2SktHQllFa0Na?=
 =?utf-8?B?V1lmSS9oU1RTTlVpS1ViUE02cU1NcXpKZk1tTDFpZjZaZERnN1Y2UGZIVzEz?=
 =?utf-8?B?OWtCUGxVNkFuZDFTZEUwMUlIcjFjdzMrWXBGVTl1SkhNTUV4N2dyTS8zYW5w?=
 =?utf-8?Q?LyXUfYsvVKm62zmPrHg3DRk=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae231868-27da-4cfb-0f52-08da81c08645
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 08:55:11.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+XtRG3Xj078m5L1Gs4XQbZEoos2+td8VbjvK7YPBWAwzYcn4kuPgwGqjD9y8H5fCqSY9JCG4SSe8bgtN++WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2217
X-Proofpoint-ORIG-GUID: fknw7SB0G0euAfQkQXp4OnnImFROoIcd
X-Proofpoint-GUID: fknw7SB0G0euAfQkQXp4OnnImFROoIcd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_04,2022-08-18_01,2022-06-22_01
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

Hi Kumar,

Alexei and I talked about locking and a few other things today in regards to my
rbtree work. Some of this isn't a direct response to your ideas/notes here, 
but hoping to summarize today's discussion inline with your code samples and
get your opinion.

Also, some inline comments more directly addressing your notes.

On 8/17/22 5:04 AM, Kumar Kartikeya Dwivedi wrote:   
> Alexei and I had a meeting where we discussed some of my ideas related
> to BPF linked lists. I am sharing the discussion with everyone to get
> wider feedback, and document what we discussed.
> 
> The hard stuff is the shared ownership case, hence we can discuss this
> while we work on landing single ownership lists. I will be sharing my
> patches for that as an RFC.
> 
> 1. Definition
> 
> We can use BTF declaration tags to annotate a common structure like
> struct bpf_list_head, struct bpf_rb_root, etc.
> 
> #define __value(kind, name, node) __attribute__((btf_decl_tag(#kind
> ":" #name ":" #node))
> 
> struct foo {
>     unsigned long data;
>     struct bpf_list_node node;
> };
> 
> struct map_value {
>     struct bpf_spin_lock lock;
>     struct bpf_list_head head __value(struct, foo, node);
> };
> 
> This allows us to parameterize any kind of intrusive collection.
> 
> For the map-in-map use case:
> 
> struct bar {
>     unsigned long data;
>     struct bpf_list_node node;
> };
> // Only two levels of types allowed, to ensure no cycles, and to
> prevent ownership cycles
> struct foo {
>     unsigned long data;
>     struct bpf_spin_lock lock;
>     struct bpf_list_node node;
>     struct bpf_list_head head __value(struct, bar, node);
> };
> 
> struct map_value {
>     struct bpf_spin_lock lock;
>     struct bpf_list_head head __value(struct, foo, node);
> };
> 

Will these still be 'bpf maps' under the hood? If the list were to use
convention similar to the rbtree RFC, the first (non map-in-map) def could be
written like:

struct foo {
    unsigned long data;
    struct bpf_list_node node;
};

struct {
    __uint(type, BPF_MAP_TYPE_LINKED_LIST);
    __type(value, struct foo);
} list SEC(".maps");

I think we're thinking along similar lines with regards to the BTF tag, but I
was thinking of tagging the value type instead of the container, something like:

struct foo {
    unsigned long data;
    struct bpf_list_node node __protected_list_node;
};

'protected' meaning verifier knows to prevent prog from touching the
bpf_list_node. Currently my rbtree RFCv1 is just assuming that value type will
have rb_node at offset 0. BTF tag would eliminate this offset requirement
and allow value types to be part of multiple data structures:

struct foo {
    unsigned long data;
    struct bpf_list_node node __protected_list_node;
    struct bpf_rb_node rb_node __protected_rb_node;
};

Not a hard requirement for me, but nice-to-have: support for heterogenous value
types in same list / rbtree. Map def's __type(value, struct foo) wouldn't work
in this case, I think your __value(struct, foo, node) would have same issue.

But I think this should be possible with BTF tags somehow. List
helpers are ostensibly only touching the list_{head,node} - and similar for
rbtree, and we're both planning on explicit in-prog typed allocation.
If type can be propagated from alloc -> reg state -> helper input ->
helper output, helpers could use reg BTF info w/ properly tagged field
to manipulate the right field in the value struct.

In that case the tag would have to be on the value struct's field, not the
container. I do like that your __value(struct, foo, node) is teaching the
container what named field to manipulate. If value struct were to be part of
two lists this would make it possible to disambiguate.

When we discussed this Alexei mentioned existing pointer casting helper pattern
(e.g. 'bpf_skc_to_tcp_sock') as potentially being helpful here.

> 2. Building Blocks - A type safe allocator
> 
> Add bpf_kptr_alloc, bpf_kptr_free
> This will use bpf_mem_alloc infra, allocator maps.
> Alexei mentioned that Delyan is working on support for exposing
> bpf_mem_alloc using an allocator map.
> Allocates referenced PTR_TO_BTF_ID (should we call these local kptr?):
> reg->btf == prog->aux->btf
> reg->btf_id = bpf_core_type_id_local(...)
> btf_struct_access allows writing to these objects.
> Due to type visibility, we can embed objects with special semantics
> inside these user defined types.
> Add a concept of constructing/destructing kptr.
> constructing -> normal kptr, escapable -> destructing
> In constructing and destructing state, pointer cannot escape the
> program. Hence, only one CPU is guaranteed to observe the object in
> those states. So when we have access to single ownership kptr, we know
> nobody else can access it. Hence we can also move its state from
> normal to destructing state.
> In case of shared ownership, we will have to rely on the result of
> bpf_refcount_put for this to work.
> 
> 3. Embedding special fields inside such allocated kptr
> 
> We must allow programmer to compose their own user defined BPF object
> out of building blocks provided by BPF.
> BPF users may have certain special objects inside this allocated
> object. E.g. bpf_list_node, bpf_spin_lock, even bpf_list_head
> (map-in-map use case).
> btf_struct_access won’t allow direct reads/writes to these fields.
> Each of them needs to be constructed before the object is considered
> fully constructed.
> An unconstructed object’s kptr cannot escape a program, it can only be
> destructed and freed.
> This has multiple advantages. We can add fields which have complex
> initialization requirements.
> This also allows safe recycling of memory without having to do zero
> init or inserting constructor calls automatically from verifier.
> Allows constructors to have parameters in future, also allows complex
> multi-step initialization of fields in future.
> 

I don't fully understand "shared ownership" from 2) and don't have a use case
for complex constructors in 3), but broadly agree with everything else. Will
do another pass.

> 4. Single Ownership Linked Lists
> 
> The kptr has single ownership.
> Program has to release it before BPF_EXIT, either free or move it out
> of program.
> Once passed to list, the program loses ownership.
> But BPF can track that until spin_lock is released, nobody else can
> touch it, so we can technically still list_remove a node we added
> using list_add, and then we will be owning it after unlock.
> list_add marks reference_state as ‘release_on_unlock’
> list_remove unmark reference_state
> Alexei: Similar to Dave’s approach, but different implementation.
> bpf_spin_unlock walks acquired_refs and release_reference marked ones.
> No other function calls allows in critical section, hence
> reference_state remains same.
> 
> ----------
> 
> 5. Shared Ownership
> 
> Idea: Add bpf_refcount as special field embeddable in allocated kptrs.
> bpf_refcount_set(const), bpf_refcount_inc(const), bpf_refcount_put(ptr).
> If combined with RCU, can allow safe kptr_get operations for such objects.
> Each rb_root, list_head requires ownership of node.
> Caller will transfer its reference to them.
> If having only a single reference, do inc before transfer.
> It is a generic concept, and can apply to kernel types as well.
> When linking after allocation, it is extremely cheap to set, add, add, add…
> 
> We add ‘static_ref’ to each reference_state to track incs/decs
> acq = static_ref = 1
> set  = static_ref = K (must be in [1, …] range)
> inc  = static_ref += K
> rel/put = static_ref -=  1 (may allow K, dunno)
> 
> Alexei suggested that he prefers if helpers did the increment on their
> own in case where the bpf_refcount field exists in the object. I.e.
> instead of caller incrementing and then passing their reference to
> lists or rbtree, the add helpers receive hidden parameter to refcount
> field address automatically and bump the refcount when adding. In that
> case, they won't be releasing caller's reference_state.
> Then this static_ref code is not required.
> 
> Kartikeya: No strong opinions, this is also another way. One advantage
> of managing refcount on caller side and just keeping helpers move only
> (regardless of single owner or shared owner kptr) is that helpers
> themselves have the same semantics. It always moves ownership of a
> reference. Also, one inc(K) and multiple add is a little cheaper than
> multiple inc(1) on each add.
> 
> 6. How does the verifier reason about shared kptr we don't know the state of?
> 
> Consider a case where we load a kptr which has shared ownership from a
> map using kptr_get.
> 
> Now, it may have a list_node and a rb_node. We don't know whether this
> node is already part of some list (so that list_node is occupied),
> same for rb_node.
> 
> There can be races like two CPUs having access to the node:
> 
> CPU 0                         CPU 1
> lock(&list1_lock)            lock(&list2_lock)
> list_add(&node, &list2)
>     next.prev = node;
>     node.next = next;      list_remove(&node)
>                                          node.next = NULL;
>                                          node.prev = NULL;
>     node.prev = prev;
>     prev.next = node;
> unlock(&list1_lock);         unlock(&list2_lock);
> 
> Interleavings can leave nodes in inconsistent states.
> We need to ensure that when we are doing list_add or list_remove for
> kptr we don't know the state of, it is only in a safe context with
> ownership of that operation.
> 
> Remove:
> 
> When inside list_for_each helper, list_remove is safe for nodes since
> we are protected by lock.
> 
> Idea: An owner field alongside the list_node and rb_node.
> list_add sets it to the address of list_head, list_remove sets it to
> NULL. This will be done under spinlock of the list.
> 
> When we get access to the object in an unknown state for these fields,
> we first lock the list we want to remove it from, check the owner
> field, and only remove it when we see that owner matches locked list.
> 
> Each list_add updates owner, list_remove sets to NULL.
>     bpf_spin_lock(&lock);
>     if (bpf_list_owns_node(&i->node, &list)) { // checks owner
> list_remove(&i->node);
>     }
>     bpf_spin_unlock(&lock);
> 
> bpf_list_owns_node poisons pointer in false branch, so user can only
> list_remove in true branch.
> 
> If the owner is not a locked list pointer, it will be either NULL or
> some other value (because of previous list_remove while holding same
> lock, or list_add while holding some other list lock).
> If the owner is our list pointer, we can be sure this is safe, as we
> have already locked list.
> Otherwise, previous critical section must have modified owner.
> So one single load (after inlining this helper) allows unlinking
> random kptr we have reference to, safely.
> 
> Cost: 8-bytes per object. Advantages: Prevents bugs like racy
> list_remove and double list_add, doesn't need fallible helpers (the
> check that would have been inside has to be done by the user now).
> Don't need the abort logic.
> 

I agree, keeping track of owner seems necessary. Seems harder to verify
statically than lock as well. Alexei mentioned today that combination
"grab lock and take ownership" helper for dynamic check might make
sense.

Tangentially, I've been poking at ergonomics of
libbpf lock definition this week and think I have something reasonable:

struct node_data {
        struct rb_node node;
        __u32 one;
        __u32 two;
};

struct l {
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, u32);
        __type(value, struct bpf_spin_lock);
        __uint(max_entries, 1);
} lock_arr SEC(".maps");

struct {
        __uint(type, BPF_MAP_TYPE_RBTREE);
        __type(value, struct node_data);
        __array(lock, struct l);
} rbtree1 SEC(".maps") = {
        .lock = {
                [0] = &lock_arr,
        },
};

struct {
        __uint(type, BPF_MAP_TYPE_RBTREE);
        __type(value, struct node_data);
        __array(lock, struct l);
} rbtree2 SEC(".maps") = {
        .lock = {
                [0] = &lock_arr,
        },
};

... in BPF prog

  bpf_spin_lock(&lock_arr[0]);

  // Can safely operate on either tree, move nodes between them, etc.

  bpf_spin_unlock(&lock_arr[0]);


Notes:
  * Verifier knows which lock is supposed to be used at map creation time
    * Can reuse bpf_verifier_state's 'active_spin_lock' member, so no addt'l
      bookkeeping needed to verify that rbtree_add or similar is happening
      in critical section
  * Can benefit from relo goodness (e.g. rbtree3 using extern lock in another
    file)
  * If necessary, similar dynamic verification behavior as just keeping lock
    internal
  * Implementation similarities with map_of_map 'inner_map'. Similarly to
    inner_map_fd, kernel needs to know about lock_map_fd. Can use map_extra for
    this to avoid uapi changes

Alexei and I discussed possibly allowing raw 'struct bpf_spin_lock' global var,
which would require some additional libbpf changes as bpf_spin_lock can't be
mmap'd and libbpf tries to mmap all .data maps currently. Perhaps a separate
.data.no_mmap section.

This ergonomics idea doesn't solve the map-in-map issue, I'm still unsure
how to statically verify lock in that case. Have you had a chance to think
about it further? And does the above seem reasonable to you?

> We can also use this to jump back to owner, lock it, list_owns_node,
> remove safely without having to iterate owner list.
> 
> Idea: Make it optional, so cost only paid by those who need this
> dynamic removal of kptr from kptr_gets, only this helper would require
> associated owner field.
> 
> 7. How to add such a randomly acquired kptr?
> 
> Same idea, but requires a cmpxchg owner to BPF_PTR_POISON. This can’t
> be set from list_add or list_remove. list_owns_node will see it and
> not return true. Hence, we will have exclusive ownership of list_node.
> 
> Safety: Verifier will force to either add to some list, and make
> pointer unescapable, or reset to NULL (needs a store, makes escapable)
> (otherwise if you move it to map, it will become unlinkable on next
> prog execution, as we lose this info when we reload from map).
> 
> 6,7: Alternative approach: node locking
> 
> Be able to lock kptr so that its list_node, rb_node fields are
> protected from concurrent mutation. This requires teaching the
> verifier to take 2 levels of locks.
> 
> Requires building a type ownership graph and detecting cycles to avoid
> ABBA deadlocks when loading program BTF.
> 
> It would still require checking the owner field (i.e.
> bpf_list_owns_node operation) inside the CS (as someone before us
> might have taken the lock and added it or removed it), but it becomes
> a simple branch, instead of having to do N cmpxchg for N fields to be
> able to add them.
> 
> 8. Insight: Need a generic concept of helpers that poison/unpoison  a
> pointer argument depending on the checking of the result they return.
> 
> if (use_only_in_one_branch(ptr)) { … } else { … }
> Poisons all copies of ptr. Checking the returned pointer unpoisons.
> Returned pointer stores ref_obj_id (currently only needed for
> refcounted registers), which can be used to find candidates for
> un-poisoning.
> Generic concept, similar to CONDITIONAL_RELEASE approach from Dave,
> but can apply to do all kinds of other things.
> E.g. if (bpf_refcount_single(...)) does one load internally, simply
> check to downgrade to single ownership pointer in one branch. Some
> operations then don’t need lock (like adding to list_head, since only
> we can access it).
> Same for bpf_refcount_put pattern.
> if (bpf_refcount_put(kptr)) { destruct(kptr); kptr_free(kptr); }
> 
> 9. RCU protection for single & shared ownershipkptrs
> 
> Idea: Expose bpf_call_rcu kfunc. RCU protected kptr cannot be
> destructed, cannot be bpf_kptr_free directly. Only bpf_call_rcu can be
> called once refcount reaches 0, then it will invoke callback and give
> ownership of kptr to the callback and force destruction + free (by
> setting destructing state of pointer).
> 
> For single ownership, once we remove visibility using kptr_xchg (it
> can be only in one field, because of single ownership allowing one
> move from/to map), we can call this helper as well.
> 
> 
> In shared ownership we rely on bpf_refcount_put's true branch to call
> bpf_call_rcu.
> 
> Callback runs once after RCU gp, it will only be allowed to destruct
> kptr and then call bpf_kptr_free, not escape program.
> 
> I _think_ we can avoid taking prog reference, if we do RCU barrier
> after synchronize_rcu in prog free path? That waits for all call_rcu
> invoked from read sections that may be executing the prog.
> 
> Inside callbacks, regardless of single ownership kptr or kptr with
> refcount (possible shared ownership), we know we have single
> ownership, and set destructing state (with all possible destructible
> fields marked as constructed in callback func_state, so user has to
> call all destructors and then free, can do nothing else).
> 
> Alexei: Instead of open coding bpf_call_rcu plus destruction like
> this, associate destructor callback with user kptr. Then
> bpf_kptr_free_rcu automatically invokes this using call_rcu, and BPF
> map also invokes it on map_free.
> 
> Kartikeya: One big limitation is that now BPF map must take reference
> to prog as it needs callback reference to stay stable, but to solve
> the reference cycle it must release these kptr on map_release_uref. We
> then also need to check this atomic count like the timer helper before
> setting the kptr in the map, so that such kptr is not set after
> map_release_uref again, which is a bit limiting. It would be limiting
> to have to pin maps to make this work, we may not even have user
> visible fds for such maps in future (as we are moving towards BPF
> powered kernel programming).
> 
> 10. Verifier callback handling is broken
> 
> Loop callback verification is broken
> Same issues exist now as were anticipated in open coded iteration
> Fixing this will open clear path to enabling open coded iteration
> https://lore.kernel.org/bpf/20220815051540.18791-1-memxor@gmail.com
> Alexei mentioned that Andrii is working on how to do inline nested loops.
> 
> --
> 
> This concludes what we discussed yesterday. Apologies in advance if I
> forgot to mention anything else.
