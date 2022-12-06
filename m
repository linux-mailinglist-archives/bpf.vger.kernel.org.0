Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3363A64497B
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiLFQie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 11:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiLFQh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 11:37:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDC2703;
        Tue,  6 Dec 2022 08:37:03 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B6A9AXC003558;
        Tue, 6 Dec 2022 08:36:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=H+M0DGK3aKG13yQQYcn5NNLZloNTmiKDldnmNunbC7k=;
 b=Eo5xDCD0PH3ONMaQYj1dowmodA+RZNho0imRjRtdH9hzBJEy/2Ce+mMwIzhVYQlTeRZK
 +eYhSxLDyMzQbhzZeDiKhg33EqS4kyGyawftee8l+2FSjKLNB2oLx7lqiWvTc7V+DFQv
 fZKC53JBWDLes0oTEnX1hdxcCxTuwfQwLjsO67LXjKjVgZ9jHGyi3eDbxzEI3mfZ5TJj
 wsM5OsaLMi6deV/bxRb3WfddFSNywo+O5b3GFfv3iIILwQLtylEw0T1tHM/UERiK8rEY
 J2zevFDWLTOGCnQgMinP7v1EJVL8HU3YHafJIwCsJ1SKX4YTgSq2TDAroiPhefNYlJWu jA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m9s5pwecu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 08:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K23XAlRep/EqXSv3loJfbKgwfppx/3zEcuHv+T8XPa9FY5QK1FEycvcBlZWxpf5fTz/HtlW4MmG1b5RRcVLBaCxumtkaxz4z4a0b8WPmBkUn4uK5WmHaFMxfJW+l/Glf7hLVETP1Gi1wIWhAkP1CXNuLmTkXg8yWBtcXQpmkz/unal5hN8IapRORYyl/3Qahg9/ftEREdS2Ggi3sNBjU99ykjGWHZ/mA6f6fH9D10cdVxY86m1PboyPZVr20cf404I8Vq0PjuJ4k6Rn/PGEwUcv9AlbA9MzkgieN8yDUcQgCVLkQ9HQXWFn/TEv0oK44FGDzd3Hh2/sjRIHCJsPhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRBLGLcSUR7YI1Seg7FU7sbsKsWRqXC/I0Uhr5tPdDs=;
 b=HgkWLhAVx0IUhP3M6ys/S4c7c0IuyOvlerIU6I6XEdfd+eA7V0PPgBQDwSqkFpTb7FiwodZVVgbecxW+5EjOAjBm5vUJIW3ZHXlKJyv1WHJrsBFyyuakjMfgcB6JcQXGDflHemnxB3yUfn0E6rS8LcWW8ro22BFmanUD0ZlMNewm8HvHUWvgkyh+oILgYcX5gR5F3I4pWgTayYOynw5lTb3xvUfnEbGHlpngtoSgxhb9fv6FSzFWHGCYtCBmcoDv/EfwD6Wzhhwex49kgRNug/x1aek96Z+XAsRDsmrG1i4IQJepqqpHYZsN2LlW7qmq2ibsRx/RHK0yywdVKFBuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3842.namprd15.prod.outlook.com (2603:10b6:208:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 6 Dec
 2022 16:36:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 16:36:43 +0000
Message-ID: <12e622e6-7b6c-50bf-b691-f750dea20655@meta.com>
Date:   Tue, 6 Dec 2022 08:36:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221206105552.74372-1-donald.hunter@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221206105552.74372-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3842:EE_
X-MS-Office365-Filtering-Correlation-Id: c04973ae-7f30-46c6-4958-08dad7a80ef1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyTWwzfkeg2vcioTKK9C1OuOvnmGaVVpcTY2kHU4ytwJar3qKtsKpmcw/i/YP9e1ao66ai2qXVeHtXwYJb1H/vErrQmoyeg5c/UfWXUfQau7nX9fIQ07wJ0O3D3cMJAnr3ruxf23401ZQxwcIcUYFJF49oP/8wvUcuTNMP4bkyCjBla2HqP0Gu3Akw8AlLjp5pJMdpA1mai94ibuUtlHJzCMR2s0UK13o4isRy4JBSH/LwPBtGSzvTSRVaRkToPTa7Qqkzuya8soaU1lW0baIDHuBO1dlYK67dfwI+MkMYVFM3n+tpzHe7TwCnITYygWEgWKTvDaNEieeAiD6Rrba99vqBqcZ3Lzmv7nhrX5EWdgak6CU9eV/V++e6dcDgWMn5f0lSAgGLDWUmJ1g0Oo9ZPKs+AVj9a5MP2N70N7xWFer/Mn5VmVSqt8jxMdX1va+It8MxhSjKXKOXWKv5vVbet2p+U+eTiNKUeHVGvTsdLmqnqrSGnxz8Be0cpZz8cEkUA4Y+cmI1DYdNUVeq9OuCIFZNG2D2w7R7Gb6btgks3gjKmCuNl7lnzNJzTEvSg0BYolg4J+FwPhoBhzST3euhsXFwgZfChVZw7MopshlRqtNx1Aw6xbpahW2zdbQVcOvxYbzHY9MHMrMPPiRNB4Yyzg27kbURf3OUIJJBr3l8xwFWMBOdYarJzWAhMoLROFOrtN4JeMyDs3X9rIQWITlL//vemZjvU6lKNad0bnYVdmDSO+4gq4v0ncmKrRtvMW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(2906002)(83380400001)(31686004)(36756003)(186003)(41300700001)(66946007)(31696002)(86362001)(66476007)(38100700002)(6512007)(8676002)(8936002)(66556008)(2616005)(4326008)(478600001)(5660300002)(54906003)(316002)(6506007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhVSU5WMHh1Rm8rN05JbFlUeVROWnpycE9HU3BFQkxvaGJtY2tHN1dTNHJy?=
 =?utf-8?B?SzBCYkVRbkU0NzQ0Yi81dHdxZUNWYVU5TmVROG1RK2tPWXh3TzVrYlA0RmRH?=
 =?utf-8?B?T3lGNEI0dCt1RC9USmlVVnNSckFkdWpLNEpCaVAwSkNmUWRhU0ZkUkpmWm5V?=
 =?utf-8?B?VFVSN3Z0c2JQOGY5QTNZRTZybFRtcWNRVWxBLzlFY2ZndTVTOVhUNWwvREtR?=
 =?utf-8?B?c2dPVnlqWmh3RC8yTE9CQWMrcnRtc1VPKzh3RXBiWVRFLzRJSDluUGxyTlA5?=
 =?utf-8?B?SXpxWHJ1RUg3N2tTRndqZFo4VWlzdVJQWUxKekhwcDY0eUNSTXAvc084VSs2?=
 =?utf-8?B?dHZ2U3RiSTk3TVFFT00va2M2b0ZCdllQbW04ZnlNaEtRWEVHMVp1bm92Wm1z?=
 =?utf-8?B?MWJDNG84dGNCQ05lSWE2Ry9HMTg2VnZQc2s0ZjF6OXVldnI2OVoyMVVPT0VH?=
 =?utf-8?B?dnBMZmVBUkdpNUJjZ21tUEEvS3Q1eWhtZXVDWUtBY1B0aHVCa3k3VkJCTDE0?=
 =?utf-8?B?dEpFWFc3dWpxdS9ycTU2TFpNcEIxaW5oZm12dFNPR000WmpGZTJnRXA1YzRp?=
 =?utf-8?B?a2RkRDhqUlhpTmYrSnJHOCtKdFNIYW9rT3JoaWNmSGp4N2dFMmZuSU0vWGZk?=
 =?utf-8?B?bUF1ZkdPOWV1dDFGU0tYTGZlbVcxV1QySkI3a2NQK3djZ2pzSmNlV3FVNVc2?=
 =?utf-8?B?enNLMUh6M2kxWjlJTGxDYVIyVWZyejRMRmNLTjhURUtUcENRVGh0M0hibkFp?=
 =?utf-8?B?eVYyQ1oweFJNQVJjeHBoM2RQcUNwYlhucEVXbFE2OHNmQzJQSzZvTFNHTFRj?=
 =?utf-8?B?N24weUxLRGNETjhGUzlqUHFzNktMN2k4TFpvd3JvcGFNR0FaOEl3NStLN2gw?=
 =?utf-8?B?ZTY2NHlkSW5iK0hrT28zMWFoSjFaT09BUTR1REl0MlhMdlhMcyt1T2F1dDdR?=
 =?utf-8?B?S3F0cms0Um5sTHZXNWJYZ3NEYlV2SlpaWHZHdGxwOU9qNmNQRDRQcHNkeTZv?=
 =?utf-8?B?Ym9YWlcxYURUNUZxUFNhRFl0Rm50d0hSYlZaQnNMYWNtdStjZ1dVQ1RBWTVv?=
 =?utf-8?B?MUZBOTFKTGV0K1NGcWlpRDE1SGhhdW96d0t6YTFjdmMyTVJxMFBWNmNPcUR3?=
 =?utf-8?B?VkIxdmFLTlV1Q0loMC9pUHlOTEdWWnVPVDBqbjBWSUZCRG9iSmNrZjVHcSs0?=
 =?utf-8?B?SkUrVXhEYVZCSFI0U0lYczM1QWk1M1h6S05BWmY3YlkxcFNDMkwzakkyM2E1?=
 =?utf-8?B?L0UwazFrbGZ4VCthS0VWQ3hMTUk4KzZLWEhYT0ZmZzBTTS9ZUkw4QWdjTHp6?=
 =?utf-8?B?YXAxM0E4K3IwYURubjMra2pjWlpZQmlsMlMwcndDZkFJRXJYZ0tsK0EzL3lz?=
 =?utf-8?B?MmpsVlhQREFSQzhEVURkYlEzb3B0bC9oYTYyL1U1LytjT0VHL0IwVU1xb3Zm?=
 =?utf-8?B?WDF3bE1tN1NveDNzTFgwVVhJajY1WTZobUVmL3BZOUFncEtkOXE2T1RhazNz?=
 =?utf-8?B?THRKMUp5ZmJwd0hCTGluSzRObGpZNGE2d1hBS1hQVllvZTRXTllLRk9DVmR1?=
 =?utf-8?B?VFg2ZExFUVFVMWZlWGgxRndlYmpaSUdUL1YyNmJjRFFWSE5TeDNXQnVqOUJO?=
 =?utf-8?B?WFlIa2QrdUZ2cDljWjNDRGNOVzVpWXpmaC9YU1hVM2hxbG9EazdKWFV0alFX?=
 =?utf-8?B?cTBnV1ZHU2Ixd3NQWEtkWVcyY0QyYXFxeUlXNExOWjVXRzRZNWlWMzFLMU5O?=
 =?utf-8?B?bjRRbFBhRlphVWttMHN2d2YrRmZScUwxOVNndU12S0J0Z0hiZ2xsMk96aGtF?=
 =?utf-8?B?SWhQV1U1d1crcUZZU1ZnM3puQmNpZVJ2UTZ6Z2VpSm0vL2w5OVBiY1gxRVQ2?=
 =?utf-8?B?a29rdllQYkFNdmdoTm52MEd0R2FRcU03c0J4NFRrWHZreWc3dTdTVjV3QkNF?=
 =?utf-8?B?dUZCRGIrR0R6NWVYU2RvVEJ0YlFWanJRanFLRkI0SzlHTE1ELy9wZWVJU1pM?=
 =?utf-8?B?bjFtOXZRQ1NGckNYNFhac2ZjQjNBN3BXNWJjeDhzcG1MQ1RmUXN0NzZ0TmNY?=
 =?utf-8?B?STRTMHNiRzNzd3ZDOGFJUk1HNnJwdElLVy9nMmVJWkVGWjdqdThPczRBWjZj?=
 =?utf-8?B?R0NJcG80RUdlSlVZWmNBbjd6c283T0lxZDJkbHJZcWV2QnJxdVpWUm9OTFNT?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04973ae-7f30-46c6-4958-08dad7a80ef1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:36:43.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9aBC9RX/VOBkvqbMgNapRjvEkU6RZAQPJLzeCqi7TlH8XVM6OyOodmGb4IXnrI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3842
X-Proofpoint-GUID: qPakB0pD5JrFRH9rPm1ZIVY9sh5nbCOA
X-Proofpoint-ORIG-GUID: qPakB0pD5JrFRH9rPm1ZIVY9sh5nbCOA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_10,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/6/22 2:55 AM, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v1 -> v2:
> - Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
> - Fix NULL return on failure, reported by Yonghong Song
> 
> Documentation/bpf/map_sk_storage.rst | 142 +++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
>   create mode 100644 Documentation/bpf/map_sk_storage.rst
> 
> diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
> new file mode 100644
> index 000000000000..38b385c53da9
> --- /dev/null
> +++ b/Documentation/bpf/map_sk_storage.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=======================
> +BPF_MAP_TYPE_SK_STORAGE
> +=======================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_SK_STORAGE`` was introduced in kernel version 5.2
> +
> +``BPF_MAP_TYPE_SK_STORAGE`` is used to provide socket-local storage for BPF programs. A map of
> +type ``BPF_MAP_TYPE_SK_STORAGE`` declares the type of storage to be provided and acts as the
> +handle for accessing the socket-local storage from a BPF program. The key type must be ``int``
> +and ``max_entries`` must be set to ``0``.
> +
> +The ``BPF_F_NO_PREALLOC`` must be used when creating a map for socket-local storage. The kernel
> +is responsible for allocating storage for a socket when requested and for freeing the storage
> +when either the map or the socket is deleted.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +bpf_sk_storage_get()
> +~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)

void *bpf_sk_storage_get(...)

> +
> +Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
> +the storage from ``sk`` that is identified by ``map``.  If the
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
> +storage for ``sk`` if it does not already exist. ``value`` can be used together with
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
> +initialized. Returns a pointer to the storage on success, or ``NULL`` in case of failure.
> +
> +.. note::
> +   - ``sk`` is a kernel ``struct sock`` pointer for LSM program.
> +   - ``sk`` is a ``struct bpf_sock`` pointer for other program types.

The above is taken from uapi header. The above
    ``sk`` is a kernel ``struct sock`` pointer for LSM program.
should be changed to
    ``sk`` is a kernel ``struct sock`` pointer for LSM or tracing program.

See bpf_trace.c
const struct bpf_func_proto *
tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog 
*prog)
{
...
         case BPF_FUNC_sk_storage_get:
                 return &bpf_sk_storage_get_tracing_proto;
...
}

> +
> +bpf_sk_storage_delete()
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
> +
> +Socket-local storage can be deleted using the ``bpf_sk_storage_delete()`` helper. The helper
> +deletes the storage from ``sk`` that is identified by ``map``. Returns ``0`` on success, or negative
> +error in case of failure.
> +
> +User space
> +----------
> +
> +bpf_map_update_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
> +
> +Socket-local storage with type identified by ``map_fd`` for the socket identified by ``key`` can
> +be added or updated using the ``bpf_map_update_elem()`` libbpf function. ``key`` must be a
> +pointer to a valid ``fd`` in the user space program. The ``flags`` parameter can be used to
> +control the update behaviour:
> +
> +- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
> +- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
> +  exist
> +- ``BPF_EXIST`` will update existing storage for ``fd``
> +
> +Returns ``0`` on success, or negative error in case of failure.
> +
> +bpf_map_lookup_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
> +
> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be
> +retrieved using the ``bpf_map_lookup_elem()`` libbpf function. ``key`` must be a pointer to a
> +valid ``fd`` in the user space program. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +bpf_map_delete_elem()
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   int bpf_map_delete_elem (int map_fd, const void *key)
> +
> +Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be deleted
> +using the ``bpf_map_delete_elem()`` libbpf function. Returns ``0`` on success, or negative error
> +in case of failure.
> +
> +Examples
> +========
> +
> +Kernel BPF
> +----------
> +
> +This snippet shows how to declare socket-local storage in a BPF program:
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +            __uint(map_flags, BPF_F_NO_PREALLOC);
> +            __type(key, int);
> +            __type(value, struct my_storage);
> +    } socket_storage SEC(".maps");
> +
> +This snippet shows how to retrieve socket-local storage in a BPF program:
> +
> +.. code-block:: c
> +
> +    SEC("sockops")
> +    int _sockops(struct bpf_sock_ops *ctx)
> +    {
> +            struct my_storage *storage;
> +            struct bpf_sock *sk;
> +
> +            sk = ctx->sk;
> +            if (!sk)
> +                    return 1;
> +
> +            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
> +                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
> +            if (!storage)
> +                    return 1;
> +
> +            /* Use 'storage' here */
> +    }
> +
> +References
> +==========
> +
> +https://lwn.net/ml/netdev/20190426171103.61892-1-kafai@fb.com/
