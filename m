Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F8601921
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJQUOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiJQUNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:13:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739497D1CC
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:12:34 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJOw6t009294;
        Mon, 17 Oct 2022 13:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=iNfYrOdh1yehPXX4OYsyh+18cw62u9XOMYnAQqijZ+s=;
 b=iPLlt3UiaHB3uH7I6L2QDXtcK68e8yYJRRl4HasoHsfMLsgLsO318NOE9pn2hW1VaOBA
 eCVwOyO903rhEY1RnzGcj3PnLNyYRX+M17WO9x74gJpkXLk1CBiID9Wua6Nf6++v/YU1
 VSIn5CVIk6u7kcqpisikHNk44vt4iyjUJxRfS3ugnqhCMCHsRXNE0l7lTc46JPkBlmJF
 bhXT9l0SUq2CWar0w4JDqKlwaJ+viJ42Nfo4XM7DhzedWQeUscBJhb8fQkFbEfoNKnui
 YaJ/gPe12/9f6ciufe4pUy2M8y383GLcQ/pfnVijHh3u46X9TN4k8OS+VrEYQKBYFXNE 6A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k96mcvkw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQN2G1IW8xc1dkqCBaf9XLsBIfEonxrQ6eTPWm/b6weacHjg1gCj44Oq1F5hq2ZW3whPWNbtpTl5Ve6XRLPyL93PQCOkXZAt6H/FRItvvobCV3W15z/zRO7DPB+9OmICibJp/jP9BRuMfPbjvUhFAfy5uTe42hDxOa9lms1eilzk7aH/h5hyTJ2nwGvYPBwEB7Agxsq4j6jhsu4whPyOtJ1BZbclWq9JfMoscKs9ZspVnh8m+HSxm7APc6vOGas1yvbWfYnLab08Y8RqiInjO+3YDjzsFw4URAb0uQ0ZP2OK8k8OIaXfU76BDJULVjlnkxW7r5CvFPFfyY5v342z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNfYrOdh1yehPXX4OYsyh+18cw62u9XOMYnAQqijZ+s=;
 b=Ot8a4iY5cyRzfZE9XbgLTwDpl9dLBGBahzOQrEHvzxRA61vOv5UudstivOg9VdUqp1y7byQHLdDN0SSey2HB9VhAtv9GsiDzf517WEac9FvmbtQj0N3wOgMPFW4kNz79pOrmYkOoW9wiaRczGWJzBrLY1wlzH20YFebzCuO8TCG3Wr6fIeNQbHojA7isST9r0g8cnAe3NhLuC9yhGORFoAaLKETBvV7bTo4bAWLDa00alL3sFtTng/Chb/Lg9Xgptq4/+azTMHE1QRlSfqlvK1vcwb3CNPcJIrbPMDXyeJprhN1KFlnZ+91216VMtW0OKSX/7Cq49aJUCvJ3428MIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1898.namprd15.prod.outlook.com (2603:10b6:4:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 20:10:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 20:10:31 +0000
Message-ID: <09abf562-ac9a-f702-aec1-7e4eb9343882@meta.com>
Date:   Mon, 17 Oct 2022 13:10:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, sdf@google.com
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3448b451-80d5-4525-3d06-08dab07ba471
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8qIPgVxY4ivQE8aYCjsuWizbqJL2C1O++xmelv+Iv4mQf91Ke6F08vzxjnMo+5LKqS8wGXCVPCsegkaeaax8+nb5ti4io/FWHD+0i0vTOanmn2tFepcvbQGLCWENEtd6F3MlYR70i1f2fMkqMIMpRwK4Af7guE2SN5ckc/U0culdWNsdcJpz4na5W6bz57SBFWOifm62YCBPqjc24dsAtRObQ4vM9CUbH96aZIOtNjP5NhvbELPnfWIEuX/BNYKe3cTAL4dm+LCKLqWJkP3r8OnFJB8Y8Mnf4N5/zsV/kfBxDdEY1un5rT4y8houlDFic5rpTx1D8ff7IbCxye8O1GDmNYvpkLIsEcgK58YTZvkizCl5ofY14Rk8w+wxNniqNhzr4fJZM9cBD+ldtvu89zFi7nvU5O2w/cEj1UcjFUI2Mq4J2cc/yoDqAezsPfqE1O+rvJnqp80wD8qJQtkNb24afWocTjIR4VRS1YrvesCmyzeDOfyOIpv3ztS5Ez4F/U5R++8fpN2cOcCC9ZKyRfpXfRkAOyZuKPlLWzQbh6TeMaiBB9O9kn3turXufUJPgC/nVgB4Db0K9omHulnpBQ1nlHqlQq1fI6X64Z1VBpi8daimP5eP28u+Ocb0Ac8HRcfz90AW5VZ3pqzntKmyyZMw59Sv/HzWTzqeHrdVVAJuEdpVdN+EFJnZ3JiEwKvqgaTYks9pi0BKQLh0f1Slr234KNUQZzgKLtQpFNyw9MOJhzbTo0cUL3n2yVmRR8ps3TO4kKqgQSO+sl8kM3IIIWlyIRpz7OLXIzeYO5DxdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(31686004)(478600001)(38100700002)(6486002)(316002)(5660300002)(8936002)(54906003)(4326008)(31696002)(66946007)(66556008)(8676002)(6666004)(83380400001)(41300700001)(6506007)(53546011)(66476007)(86362001)(2616005)(6512007)(186003)(30864003)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnlFd2ljNk1NdjdoZXVzVWg1d3phaGhBV1FoeU1WWFRXWUJFZk5jOWpTWlNa?=
 =?utf-8?B?QnNGS29sYnQzcWdMQ2Y3M1lIVTNqTWVQTTMxRUNLSlpXRmxXNXNEdkFhZ2My?=
 =?utf-8?B?eGlJS3pKUDBOWEYxMTdXWmRFQTZLclQwQjYxeDlBdmo5NENlVWovNWo2WjRk?=
 =?utf-8?B?SFZMYlZOZUFxNFdPV2liYlpUYUdxVm5ERXdZbGFrdUFjdEFKRVQwaFZ0TTVG?=
 =?utf-8?B?cnVBYWFnUTQvcmZNbzlERnBYMGM0YStPelE3Q3BIejZTTWV5dlNPRC90RGpP?=
 =?utf-8?B?MHpOSlRBcDlzeVlXeThlWkM0V3FDSlo4MGxzbFFlY1ZqT1BEODRpODliOHZv?=
 =?utf-8?B?TU5DeDI0THFiWVlTSU4wSnYyZ2o2d1h3QWR1VktPMmFaa0t2MEVKZk9KY2Q3?=
 =?utf-8?B?djUwMi9RaE12ZUxRUHJTNXIzaEVHYndQK2t0aWxyTmxOT1FMMEFxd0FGRWMr?=
 =?utf-8?B?b2tkRCtxSlBEQ1dBTG1HeGI3WmJMUTJKcEpzck5Wbkt1a1ZnVkREWmtXY2FC?=
 =?utf-8?B?Rmd2L3lqeldHZ3VRcmlWTGJhSFhScXFmL1ZMaG5YeDZwQjNkRFdaSzhpRjFl?=
 =?utf-8?B?VXVoQWd1N0kyblA3YnQrWjlCUGhPZTRYUkFWYTFOdDlKTVhJbk5ZWWpsQ3VW?=
 =?utf-8?B?OVdYUTMwVXJGcVVGd05aRlFxT3UxME0xOXc5WFFIZFQ0MVF2b21lTHF6azZk?=
 =?utf-8?B?Um9SR0YrazhESWd5bHBTMnovUmpSN0lsL3ZpWmt2eEp0bC9DSkJCUDVMY3Br?=
 =?utf-8?B?R3NubUx6TXV4c0dLWkU5MUV3RWhua3ZTTVV5dnVSM08rUmZPUHNhaTFSamZI?=
 =?utf-8?B?S2ZJMmpadTMwRGhydHNTR1oxcU5sOG5abDZwdjRDVmtXWWE3RmZoTitvMFFB?=
 =?utf-8?B?VFpyT0FtT3JjdWpKbXVtN1NFVkdEbmdQTUNZQkU4TjZUMkkzR1JEMnp5VjNG?=
 =?utf-8?B?YWRwcFhDMG9LdVNqa3B4elJTWEtPaWZXVm4wMzF6OFdOUm1ZMGxEZEVBdnk1?=
 =?utf-8?B?U1RiOWFXcTdXOXluY0k0ZHc4WmtuVFhYWWtkRmhDbytCdkl4bTA3dHhZSS9V?=
 =?utf-8?B?dHUzSGpJZk53TFdoTDBOZWpwOEwwOGl3Uis5NmRUTitYQmtmejhnczBUYWMr?=
 =?utf-8?B?RUM3VWIyMitaNkk4OHZIeFE2ZVpTQVZySFJlVWljbkxZeWJ0d0hsVHVNNzdF?=
 =?utf-8?B?dmVMK1hmaG9iU3NlSlJNb1h0Rlc0b3M5RXlWazh4Q0RKRjR1ZzlUWEgxVjRP?=
 =?utf-8?B?SmQ4Z1p6MDZqQlAzWlBRaCtjS1ZLanRZTnoyVVplbnZhc2ZzOC9YRHpYazM1?=
 =?utf-8?B?QW9qNVdxb2d5ZkhLajVxQXdkZ29lVjR1NWw5c3hPRyswS3JrbXRBQmM0L3Y4?=
 =?utf-8?B?NlpJTzRRY1hSaXJmRWVPMUZUa0dtWHJ2OEJZZ2VDbElNL1lnVlpCQkdGUVht?=
 =?utf-8?B?czdsY01NNFZZQnlDK3ZLZ1M1ZncyaXhSK0h6UExrQnpFbmRLVUE0NVZubjZh?=
 =?utf-8?B?RUR4M1hvdHc1VThOZzVWdzVhRmVtUkdEcmpONnAxYzMrODlNRHk4bWRuendq?=
 =?utf-8?B?WTZqdWpRdnBZR2Exam4zMUk0T3dQUWVMNzJoejkvNmJvOFJTeGxLVTNEL3pW?=
 =?utf-8?B?WkhwZU50QmdncmlsMVRYVEI1bys0S2I4R0tTM1ozWmwzVnQwWS9TRExMT29K?=
 =?utf-8?B?Y25PSVpVR29TdGtNOUZaUzZXZGNPUDB3NnRrdm1YUkJSOGVTUlY2SHAvN3J0?=
 =?utf-8?B?aUI0Q1BXR0ZMWDhNVWs2bXNRYUFleVR1V09MSkdvT0ZtRno4VzVQOVIrZ29H?=
 =?utf-8?B?M2d6RERlTnNQMFAyVmNqU2ptbE5ucUthWElFc2wwSGN0SXlDZW55VlZNU2NE?=
 =?utf-8?B?c20ybm1SU2hMbGtyVSsraHE1alI5N3VZdHNKdVpYWm53MkdhQU5pVll1V3RD?=
 =?utf-8?B?SDFocDVDL3p4TTZZajJsWWQvbE4zZnNwazhYakZBLytzZjFQT24ydktlKzhZ?=
 =?utf-8?B?OUNOZVNaQnRWdlQ0TnUyS0E5QjVZTVVLQms2Uy9HSHRSdzlySlpnK0dWSU5x?=
 =?utf-8?B?akVLT3JYUWNlVFFQTGVHVDZ5dmlBMXoxRTNxS2x0OGo5NlBPUkFRVDdqQjNp?=
 =?utf-8?B?LzdydVpDU0RuOWUwZVlSaUpldUdaWWE1Q2UzdWhiaTZKNkovcGRCME1DNUNx?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3448b451-80d5-4525-3d06-08dab07ba471
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:10:31.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Sprz9Loj5a+hf8UxZf9wTRne84h1t9uL2m/Fyqjdm8dkoS4R8qaQDXXQzVJ8jJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1898
X-Proofpoint-ORIG-GUID: 1-VxXWjXm43JKiI7qvl7L_9-lP79LFb9
X-Proofpoint-GUID: 1-VxXWjXm43JKiI7qvl7L_9-lP79LFb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 11:25 AM, Yosry Ahmed wrote:
> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
>>
>> On 10/13, Yonghong Song wrote:
>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>
>>> There already exists a local storage implementation for cgroup-attached
>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>>> attached bpf progs wants to access cgroup local storage data. For example,
>>> tc egress prog has access to sk and cgroup. It is possible to use
>>> sk local storage to emulate cgroup local storage by storing data in
>>> socket.
>>> But this is a waste as it could be lots of sockets belonging to a
>>> particular
>>> cgroup. Alternatively, a separate map can be created with cgroup id as
>>> the key.
>>> But this will introduce additional overhead to manipulate the new map.
>>> A cgroup local storage, similar to existing sk/inode/task storage,
>>> should help for this use case.
>>
>>> The life-cycle of storage is managed with the life-cycle of the
>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>>> is deleted.
>>
>>> The userspace map operations can be done by using a cgroup fd as a key
>>> passed to the lookup, update and delete operations.
>>
>>
>> [..]
>>
>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
>>> local
>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
>>> used
>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>>> helpers are named as bpf_cgroup_local_storage_get() and
>>> bpf_cgroup_local_storage_delete().
>>
>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
>> cgroup storages shared between programs on the same cgroup") where
>> the map changes its behavior depending on the key size (see key_size checks
>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
>> can be used so we can, in theory, reuse the name..
>>
>> Pros:
>> - no need for a new map name
>>
>> Cons:
>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
>>     good idea to add more stuff to it?
>>
>> But, for the very least, should we also extend
>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
>> tried to keep some of the important details in there..
> 
> This might be a long shot, but is it possible to switch completely to
> this new generic cgroup storage, and for programs that attach to
> cgroups we can still do lookups/allocations during attachment like we
> do today? IOW, maintain the current API for cgroup progs but switch it
> to use this new map type instead.

Right, cgroup attach/detach should not be impacted by this patch.

> 
> It feels like this map type is more generic and can be a superset of
> the existing cgroup storage, but I feel like I am missing something.

One difference is old way cgroup local storage allocates the memory
at map creation time, and the new way allocates the memory at runtime
when get/update helper is called.

> 
>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>    include/linux/bpf.h             |   3 +
>>>    include/linux/bpf_types.h       |   1 +
>>>    include/linux/cgroup-defs.h     |   4 +
>>>    include/uapi/linux/bpf.h        |  39 +++++
>>>    kernel/bpf/Makefile             |   2 +-
>>>    kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>>    kernel/bpf/helpers.c            |   6 +
>>>    kernel/bpf/syscall.c            |   3 +-
>>>    kernel/bpf/verifier.c           |  14 +-
>>>    kernel/cgroup/cgroup.c          |   4 +
>>>    kernel/trace/bpf_trace.c        |   4 +
>>>    scripts/bpf_doc.py              |   2 +
>>>    tools/include/uapi/linux/bpf.h  |  39 +++++
>>>    13 files changed, 398 insertions(+), 3 deletions(-)
>>>    create mode 100644 kernel/bpf/bpf_cgroup_storage.c
>>
[...]
>>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>>> index 341c94f208f4..b02693f51978 100644
>>> --- a/kernel/bpf/Makefile
>>> +++ b/kernel/bpf/Makefile
>>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>>>    obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>>    endif
>>>    ifeq ($(CONFIG_CGROUPS),y)
>>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgroup_storage.o
>>>    endif
>>>    obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>>    ifeq ($(CONFIG_INET),y)
>>> diff --git a/kernel/bpf/bpf_cgroup_storage.c
>>> b/kernel/bpf/bpf_cgroup_storage.c
>>> new file mode 100644
>>> index 000000000000..9974784822da
>>> --- /dev/null
>>> +++ b/kernel/bpf/bpf_cgroup_storage.c
>>> @@ -0,0 +1,280 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
>>> + */
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/bpf.h>
>>> +#include <linux/bpf_local_storage.h>
>>> +#include <uapi/linux/btf.h>
>>> +#include <linux/btf_ids.h>
>>> +
>>> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
>>> +
>>> +static DEFINE_PER_CPU(int, bpf_cgroup_storage_busy);
>>> +
>>> +static void bpf_cgroup_storage_lock(void)
>>> +{
>>> +     migrate_disable();
>>> +     this_cpu_inc(bpf_cgroup_storage_busy);
>>> +}
>>> +
>>> +static void bpf_cgroup_storage_unlock(void)
>>> +{
>>> +     this_cpu_dec(bpf_cgroup_storage_busy);
>>> +     migrate_enable();
>>> +}
>>> +
>>> +static bool bpf_cgroup_storage_trylock(void)
>>> +{
>>> +     migrate_disable();
>>> +     if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
>>> +             this_cpu_dec(bpf_cgroup_storage_busy);
>>> +             migrate_enable();
>>> +             return false;
>>> +     }
>>> +     return true;
>>> +}
>>
>> Task storage has lock/unlock/trylock; inode storage doesn't; why does
>> cgroup need it as well?

I think so. the new cgroup local storage might be used in fentry/fexit 
programs which could cause recursion.

>>
>>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>>> +{
>>> +     struct cgroup *cg = owner;
>>> +
>>> +     return &cg->bpf_cgroup_storage;
>>> +}
>>> +
>>> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup)
>>> +{
>>> +     struct bpf_local_storage *local_storage;
>>> +     struct bpf_local_storage_elem *selem;
>>> +     bool free_cgroup_storage = false;
>>> +     struct hlist_node *n;
>>> +     unsigned long flags;
>>> +
>>> +     rcu_read_lock();
>>> +     local_storage = rcu_dereference(cgroup->bpf_cgroup_storage);
>>> +     if (!local_storage) {
>>> +             rcu_read_unlock();
>>> +             return;
>>> +     }
>>> +
>>> +     /* Neither the bpf_prog nor the bpf-map's syscall
>>> +      * could be modifying the local_storage->list now.
>>> +      * Thus, no elem can be added-to or deleted-from the
>>> +      * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>>> +      *
>>> +      * It is racing with bpf_local_storage_map_free() alone
>>> +      * when unlinking elem from the local_storage->list and
>>> +      * the map's bucket->list.
>>> +      */
>>> +     bpf_cgroup_storage_lock();
>>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
>>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>>> +             bpf_selem_unlink_map(selem);
>>> +             free_cgroup_storage =
>>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>> +     }
>>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>> +     bpf_cgroup_storage_unlock();
>>> +     rcu_read_unlock();
>>> +
>>> +     /* free_cgroup_storage should always be true as long as
>>> +      * local_storage->list was non-empty.
>>> +      */
>>> +     if (free_cgroup_storage)
>>> +             kfree_rcu(local_storage, rcu);
>>> +}
>>
>>> +static struct bpf_local_storage_data *
>>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool
>>> cacheit_lockit)
>>> +{
>>> +     struct bpf_local_storage *cgroup_storage;
>>> +     struct bpf_local_storage_map *smap;
>>> +
>>> +     cgroup_storage = rcu_dereference_check(cgroup->bpf_cgroup_storage,
>>> +                                            bpf_rcu_lock_held());
>>> +     if (!cgroup_storage)
>>> +             return NULL;
>>> +
>>> +     smap = (struct bpf_local_storage_map *)map;
>>> +     return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>>> +}
>>> +
>>> +static void *bpf_cgroup_storage_lookup_elem(struct bpf_map *map, void
>>> *key)
>>> +{
>>> +     struct bpf_local_storage_data *sdata;
>>> +     struct cgroup *cgroup;
>>> +     int fd;
>>> +
>>> +     fd = *(int *)key;
>>> +     cgroup = cgroup_get_from_fd(fd);
>>> +     if (IS_ERR(cgroup))
>>> +             return ERR_CAST(cgroup);
>>> +
>>> +     bpf_cgroup_storage_lock();
>>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
>>> +     bpf_cgroup_storage_unlock();
>>> +     cgroup_put(cgroup);
>>> +     return sdata ? sdata->data : NULL;
>>> +}
>>
>> A lot of the above (free/lookup) seems to be copy-pasted from the task
>> storage;
>> any point in trying to generalize the common parts?

That is true. Let me think about this.

>>
>>> +static int bpf_cgroup_storage_update_elem(struct bpf_map *map, void *key,
>>> +                                       void *value, u64 map_flags)
>>> +{
>>> +     struct bpf_local_storage_data *sdata;
>>> +     struct cgroup *cgroup;
>>> +     int err, fd;
>>> +
>>> +     fd = *(int *)key;
>>> +     cgroup = cgroup_get_from_fd(fd);
>>> +     if (IS_ERR(cgroup))
>>> +             return PTR_ERR(cgroup);
>>> +
>>> +     bpf_cgroup_storage_lock();
>>> +     sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map
>>> *)map,
>>> +                                      value, map_flags, GFP_ATOMIC);
>>> +     bpf_cgroup_storage_unlock();
>>> +     err = PTR_ERR_OR_ZERO(sdata);
>>> +     cgroup_put(cgroup);
>>> +     return err;
>>> +}
>>> +
[...]
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index 8ad2c267ff47..2fa2c950c7fb 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -985,6 +985,10 @@ void put_css_set_locked(struct css_set *cset)
>>>                put_css_set_locked(cset->dom_cset);
>>>        }
>>
>>> +#ifdef CONFIG_BPF_SYSCALL
>>> +     bpf_local_cgroup_storage_free(cset->dfl_cgrp);
>>> +#endif
>>> +
> 
> I am confused about this freeing site. It seems like this path is for
> freeing css_set's of task_structs, not for freeing the cgroup itself.
> Wouldn't we want to free the local storage when we free the cgroup
> itself? Somewhere like css_free_rwork_fn()? or did I completely miss
> the point here?

Thanks for suggestions here. To be honest, I am not sure whether this
location is correct or not. I will look at css_free_rwork_fn() which
might be a good place.

> 
>>>        kfree_rcu(cset, rcu_head);
>>>    }
>>
[...]
