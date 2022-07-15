Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846FD57662B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiGORhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGORhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:37:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293A52FF8;
        Fri, 15 Jul 2022 10:37:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26FGH603021919;
        Fri, 15 Jul 2022 10:37:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L4e3VevE8NibRbFdWM0UnFk/MTSVG+9r+DMlwq0lj+8=;
 b=IHnVGnBySn1XTw67LTrlCr/apstVKIR4CWlihmE1hz2o6FHtqZ5Zo5A/YKM7wbdqBo2v
 9JDvBZ0qbXqwqJn6CcZxV6toiIjCphTou/jJ4FMMNex+eHh6lGD8zT/c7AI2j7did/2O
 0EGmwg1Ty0KtJmgIHhaGeu8LSNObbH/X1+8= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hamy3rc6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 10:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvC6kkrJleevv3vziRe3hRN1iVFHYI7sjumbFabt8bMKQphgJ2RTMoJvR7edUg4ZIWy2CJXdytY0fiCOXK7gv5rpQg+tImv34ClXIGEFgzju3jD7itbpZlecGbT7NJ6kmCyCZYGrRONIXgOyhLPRWJE8MUCS2WIjm398lJJtMuXG0nLjmWDClcuV8V5VEBrIz6EM+u2hprMntcAxNttnleZIduXmkuiHiT2RLNFRIIBj5Q0DwnmrHks1w7NSzKxuLwAnh5LoLUQnpFIgYsZc197gNbXcSnZZZmuVWZGlSS+VjyZ02pXfx1Wa4pS2lIQQVPrBxSRJxIAOwrMb7vShyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4e3VevE8NibRbFdWM0UnFk/MTSVG+9r+DMlwq0lj+8=;
 b=XV8RoqsROORub1EfH2k7xBT33p6b6CrrjynOMi3eYwUV5/YRM1wBFL9tWXsd7I9GJ+DsG64uv9kyGGY01sk+w+AUKwE/O3d95pMSTk1fvjapyJinON5medYYJP91eSOMbVbLz3dV8pr2B3/AeGK60Ey/OVFFx3X0W6gStHHlwBsadrYU0CcNpbWsmMBOhnPmFvQ0Tw9jNCmBXfURNjpnlL/ADg8dijN5zIHi5yCaxiLIkG3nsCdnRKLXhLEr+ln4HNjyr0hPQ/N2s+Ts0yVX7QbAKhRN3Df9U44+TbLa2uEpFaHiR8q9W9ZSVtCe9q4tp9hqZdZrYYCZ1gB48/nrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1243.namprd15.prod.outlook.com (2603:10b6:3:b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 17:37:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 17:37:33 +0000
Message-ID: <17b8d22f-dc23-a383-321e-3adf5117d9c0@fb.com>
Date:   Fri, 15 Jul 2022 10:37:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, sdf@google.com
References: <20220715130826.31632-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715130826.31632-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90a5a005-45fe-4a38-fe1a-08da6688b2ec
X-MS-TrafficTypeDiagnostic: DM5PR15MB1243:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6+QXYvj/0YBeC02+APH9pxw6HQZ2m9Rcj6+271kJp6EfE6Yj1tD6SkCCq37qet92B4vhPMdQnRIh0nHNIUDeih6E6t+XBr2K/PKKjdxT3UR6F9S/D2xim3w1eFBHNQkFX+rSna9w2B6MdBaR0NrZ9m/4GMhXdrkkaUiqv0m67HxhgmCgfsyrtnMXbNJJsc1VwQbWV95IJRPc0yYoJWcLkSzQeIbufh6940A8IW+2Aqk5r92NXBhhAzRtQxBybTSQ5g4jNDwW1HJjvx+e5mBzO4X4gxpkSq3+XKCG8TVDTqssS/lKFP8emXZP9CX1GRSWkyvXljNKWOHVwashtM4AZ5CTxxpxPngrcd2DQQ9TnOj3IeTevVzrVRueBroQ8AlNcHJJeDYSEEWVMtHm5WIeQHhIzJrgA9RMLvkfpRCwataQ286BfdOe2MtDr3xGCvpFwK4R8vokEJ0suxXfmCUpB2jLlNrIQy2apGVufAc48l3/K1DZ0UdCHI6x4Pr/PjBg6HRhnzN2dt8A5tDyZaF+FCKH7Db6BadAhLkqSlZV17MHANLWm5yTx685raxkqUehYn00ZQaHJdzN34vpUzkdhbKUxBYhDwQ85WrdQtYLtnAFY2oo8a01xXkhjdNnX/KpWVo4rHv+YBlHT2kmag6rJ8S5/1HOoOmaPk77lFQqkdYPnTPtWq8mMeYEStFqWS+YsNpXuU7gutW0v1sN9OQKYKHJ0O6aOIhAC7X4LAKq/xCLuOQk2OaDAVeCpvQcHrazCCeQ4x5TDweMzg0VwzIGY99d7JBQsAkO3rtiOo/IHSQRq87w2wctDDL4lhi2WEZ2NyBGuYwaRUFgyJFsvuoOstsJ2EpwXTObR1brDJsCcWS6jwNNZtxntegxoQTpHE5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(8936002)(38100700002)(966005)(6486002)(31686004)(53546011)(31696002)(478600001)(86362001)(186003)(6512007)(36756003)(83380400001)(316002)(66946007)(66476007)(41300700001)(66556008)(8676002)(4326008)(5660300002)(2616005)(6506007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFdtVnBrbnZJVXVKYjUxaGZ2ZkNGUkJ5L3Q1endKWndKNjNvT0p0SFlhWjJM?=
 =?utf-8?B?QllDalNmQzJtYXlYcGdiSk1DUWhteFBwSTZuQkdUaDEvOEk2K3NiMVZROXZ6?=
 =?utf-8?B?aStaMzZDWGZ1K2NwL1paN0ppWGN5Qkd0OGpjU0pneG4rK3ZRNWpQNGxreSs3?=
 =?utf-8?B?YU5qUjBnY1o1KzV4QzhGZHhoMkgrNExEWTNidk1nZDZZeGlTYWMxQ1NXQ2xB?=
 =?utf-8?B?MExZanVNUW0wQTU0OGFWejFKUlZLQ1FVS0MvMDUzQmNuN3JlVHhITnpvZUEw?=
 =?utf-8?B?VndHdHhnRFdGVzFhcWpkYm9JZy9JMW9RakxkLzNLeXVkczhad1dtWnBsR2Q4?=
 =?utf-8?B?L0xuNGh6Um5HMFBwYWdHZXg2cGNvN2QweGI4M3AwOHJlUkh6TGRsRzRxbDYv?=
 =?utf-8?B?cUNGRkI5cmlPWVhXUnE5U05BMEl6WjBMMEFVR2M0anRFTHZvc2dlZExGUS91?=
 =?utf-8?B?dFYwWjUwOWs0UFJtdlpORW95eGorbW1Md3VCYUptR1RFdzBLem1wS3UyQTZQ?=
 =?utf-8?B?VTM5QUpQem56M1p0aGtQMVlXYnJGTEN1Q2dLMFo1RENnOTBUeHpUc2tBU0RB?=
 =?utf-8?B?dHhEeGxLVjVzdlZKZDlkd3VrTDhCTjZFZm05MUc0NU9LOW1SUnAzZjI0cG03?=
 =?utf-8?B?UEFXYTVhblhzWERvaXVMTkpCcDdoZGF2V2xVQ3hUWEFRVnRMOGxFQTVVdVlB?=
 =?utf-8?B?Tmh0ZUR5UzRXOFowbGJxTU9pWVFZTDVIRm83VHlHRnFXSXNSUUVnL2tIRk94?=
 =?utf-8?B?bm0yd1VycGlLaFZ0R2t3RHpRNW5Ca284VFpwbmRlQk93MER2eG83MUdKd2tG?=
 =?utf-8?B?Rkc0UVpEWnZXTlhqeVZwYys3Q0RJbldQT2prOWhtcEtORkF3SVplcXJPcTNP?=
 =?utf-8?B?d01TNFpGeUFhVzVSNXdIMVAyd0ZTZWxaVlZWc3ZKdUpmT0FMcExodVlvcDkx?=
 =?utf-8?B?SmlsMEtXZEQ2b1J3OWdMOTY0RklPcUFVUzNza2tEdjkxR05xck56WWFXQUVR?=
 =?utf-8?B?L3ZMbUhleEZGV2FtVGlsMnhKODlHUmo0OEhTT2dpVWxpSUpSUTA3eVZJbnNa?=
 =?utf-8?B?R3FYYm0yRkx5RzNhNHBDR3dqNmtVcjVIYk93L1JycWpiM0FWdXd5VG1ja1c5?=
 =?utf-8?B?N2xHUithWUhyT2dCREdJalJpOGNtSGp3RlA5WUkxR2lUWmpGaGJ0OHVZK2lX?=
 =?utf-8?B?bUlTdWRPYy9NSFhzcFNFYVU5TDhaVy9SZ1NYazh5VE4rUDBWelRRMitlbGts?=
 =?utf-8?B?V1Buc0R4L1BleTVicElDWXVabUQzcTMzRlhuTDF6bG9DUGt1YlFYWHFBY2Jp?=
 =?utf-8?B?Ykw0N0ZnWHFXUG51Qy9MSkpaZU1ybC9LSGs3RmFSSnI2VGVUUzNaeXR1d0J2?=
 =?utf-8?B?VE53eGJXbk1GaGR0NzcySWxodEdpejR0NHIrQWVIcS8zMnlYMTFtWUc1bmNU?=
 =?utf-8?B?NDB5NmZUdlhuMFBOdHEyMGk4OXJMWXUzcTNReFdDYy90ZzJkdm1IT0lnc0d0?=
 =?utf-8?B?VVpZOHJ3eDN5dWx4WC9tV0huZ3k3WGNJSHJBbzgrVkpyUm9IcVBvNW0xandw?=
 =?utf-8?B?KzBuWlQ2aFRTUmZBcGlLdXhJUEJIZHB6UWFiRHRPWlJQc2h6cjF1RTVDTFBj?=
 =?utf-8?B?bzZYUGo2cWp6dFFpOTVXUVRtenpsQUJUN1Z3L2FoeDh1anVndjdnL05OTkhR?=
 =?utf-8?B?dTlOWURSZmRvSW9YZmZFUHpMczg0Nm5CKzkxOU1NWEd0cXArRlE5YnNDbTQ4?=
 =?utf-8?B?cVF0RTBGcjFVV3hTWXl5bmZuVTJ6c2MzaFRhQytCYjlSR2Q4MGFSNEV5L00w?=
 =?utf-8?B?MDhoZFFjQ01YeTNpelEzZHdSdnZaZEdwMVlCTXhsWFpzUFdTUnU1Z05DMDRM?=
 =?utf-8?B?RFBMNDgxWjFCRFdyL2swcHVDc1JTditzQWhmNFA2NEl5YUNNQ0U3eWY1MTJx?=
 =?utf-8?B?YmxMZDJrM0N4Z24wZnZUU2VwQmVocUJVZ3JBYjNtOHZBOW1pY21kejBlNzUr?=
 =?utf-8?B?MEF5VmdMRkRod0NqeWptaVdMbG5DdUJRZGo0eDdhWWhOckdwaElEcVdtSWJa?=
 =?utf-8?B?NnI2U1ArZWV0Sys4R1dITTExaDEyNlFCUmpyQzlrc2N5eitpS3FmYkFmaTB3?=
 =?utf-8?B?M3VHZ01XYk9kOFF2NE41ZXZxQUdWTzVQdGdaaTF2VTh5Qk5OdUF5d0RrWVNE?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a5a005-45fe-4a38-fe1a-08da6688b2ec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 17:37:33.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sVMpL2fTGBnsmTSc2SJLe7Cl2ujAhPDif7eScrSDOZ5Zo9xTKqtQzWmKN84X+kk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1243
X-Proofpoint-GUID: Anu1Aus9FUdxaceG-Vge2_BmfGX-80vZ
X-Proofpoint-ORIG-GUID: Anu1Aus9FUdxaceG-Vge2_BmfGX-80vZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_09,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 6:08 AM, Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_HASH including kernel version
> introduced, usage and examples. Document BPF_MAP_TYPE_PERCPU_HASH,
> BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH variations.
> 
> Note that this file is included in the BPF documentation by the glob in
> Documentation/bpf/maps.rst
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>   Documentation/bpf/map_hash.rst | 181 +++++++++++++++++++++++++++++++++
>   1 file changed, 181 insertions(+)
>   create mode 100644 Documentation/bpf/map_hash.rst
> 
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
> new file mode 100644
> index 000000000000..d9e33152dae5
> --- /dev/null
> +++ b/Documentation/bpf/map_hash.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +===============================================
> +BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> +===============================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_HASH`` was introduced in kernel version 3.19
> +   - ``BPF_MAP_TYPE_PERCPU_HASH`` was introduced in version 4.6
> +   - Both ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +     were introduced in version 4.10
> +
> +``BPF_MAP_TYPE_HASH`` and ``BPF_MAP_TYPE_PERCPU_HASH`` provide general
> +purpose hash map storage. Both the key and the value can be structs,
> +allowing for composite keys and values.
> +
> +The kernel is responsible for allocating and freeing key/value pairs, up
> +to the max_entries limit that you specify. Hash maps use pre-allocation
> +of hash table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be
> +used to disable pre-allocation when it is to memory expensive.
> +
> +``BPF_MAP_TYPE_PERCPU_HASH`` provides a separate value slot per
> +CPU. The per-cpu values are stored internally in an array.
> +
> +The ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +variants add LRU semantics to their respective hash tables. An LRU hash
> +will automatically evict the least recently used entries when the hash
> +table reaches capacity. An LRU hash maintains an internal LRU list that
> +is used to select elements for eviction. This internal LRU list is
> +shared across CPUs but it is possible to request a per CPU LRU list with
> +the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
> +
> +Usage
> +=====
> +
> +.. c:function::
> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> +
> +Hash entries can be added or updated using the ``bpf_map_update_elem()``
> +helper. This helper replaces existing elements atomically. The ``flags``
> +parameter can be used to control the update behaviour:
> +
> +- ``BPF_ANY`` will create a new element or update an existing element
> +- ``BPF_NOTEXIST`` will create a new element only if one did not already
> +  exist
> +- ``BPF_EXIST`` will update an existing element
> +
> +``bpf_map_update_elem()`` returns 0 on success, or negative error in
> +case of failure.
> +
> +.. c:function::
> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
> +
> +Hash entries can be retrieved using the ``bpf_map_lookup_elem()``
> +helper. This helper returns a pointer to the value associated with
> +``key``, or ``NULL`` if no entry was found.
> +
> +.. c:function::
> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
> +
> +Hash entries can be deleted using the ``bpf_map_delete_elem()``
> +helper. This helper will return 0 on success, or negative error in case
> +of failure.
> +
> +Per CPU Hashes
> +--------------
> +
> +For ``BPF_MAP_TYPE_PERCPU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +the ``bpf_map_update_elem()`` and ``bpf_map_lookup_elem()`` helpers
> +automatically access the hash slot for the current CPU.
> +
> +.. c:function::
> +   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
> +
> +The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the
> +value in the hash slot for a specific CPU. Returns value associated with
> +``key`` on ``cpu`` , or ``NULL`` if no entry was found or ``cpu`` is
> +invalid.
> +
> +Concurrency
> +-----------
> +
> +Values stored in ``BPF_MAP_TYPE_HASH`` can be accessed concurrently by
> +programs running on different CPUs.  Since Kernel version 5.1, the BPF
> +infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
> +See ``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
> +
> +Userspace
> +---------
> +
> +.. c:function::
> +   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
> +
> +In userspace, is possible to iterate through the keys of a hash using

'is possible' -> 'it is possible'

> +the ``bpf_map_get_next_key()`` function. The first key can be fetched by
> +calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
> +``NULL``. Subsequent calls will fetch the next key that follows the
> +current key. ``bpf_map_get_next_key()`` returns 0 on success, -ENOENT if
> +cur_key is the last key in the hash, or negative error in case of
> +failure.

There are some potential issues related to bpf_map_get_next_key() where
if it happened the *cur_key* in bpf_map_get_next_key() is deleted, the 
returned next_key will be the *first* key in the hash table. This is
an undesired behavior. So we should mention this and recommend users
to use batch-based lookup if their setup involves key deletion 
intermixed with bpf_map_get_next_key(). The details can be found here:
   https://lore.kernel.org/bpf/20200115184308.162644-6-brianvv@google.com

> +
> +Examples
> +========
> +
> +Please see the ``tools/testing/selftests/bpf`` directory for functional
> +examples.  The sample code below demonstrates API usage.
> +
[...]
