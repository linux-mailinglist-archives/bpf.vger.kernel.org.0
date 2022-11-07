Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8A61FD86
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKGS2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 13:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiKGS2T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 13:28:19 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39014DD5;
        Mon,  7 Nov 2022 10:28:18 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GluCp020208;
        Mon, 7 Nov 2022 10:28:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=bVPr2lPfboRzkl5SerVxInAyD2wunON6615FXsTigkM=;
 b=L4gfc2p5xkoEyCdGXOTwezNgAVSZzbKyDPUFr5DEtIrut6P1XzYnymgwyRjPHzhtPlmV
 /cGe2A5I+Q5JHXSprnNDXcT6S3Nyo+Rifc/Krzfe5XMnhDcfGrT/u/klQkOCFKpxuhuG
 IGoDr3B0NOh//ubIaqjb7gGgM2jQwOJ5G2rGrHY3OMI91kaoixO65MQ3Bc4Q0FlZkOJ0
 2aHHN7Cf/m6DgT9uECuuPElPrfo2Wd1z+H9LXGI67mMnyzKxmF7R+3Lc5ZfjvL4cy7Qw
 MZAV9Lw3Y+tTzoF+wCAO6R4+PkW8llFaEOqrAElpb2zrG5MVDKaWv+Ei0V/TgojOrj6p Hg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnnv8rwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 10:28:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/woescAZBofqz9GvjdlRP6ODSWHaT5NYjHdfc5cqSMHVd61dx5T5SeTdZSYmu6PaWYfvXUVt5EHpdAteFS/KaQcX8Ughd21pNCZOG92BXpAyA5L4PH0xjFfOj57TvS/gYs7VwnJA7xANtcZENbhYns8CDssP4q79X681qH87LYZppdm6aqs/QXVP+OgbmvvNZo9pIbyNeET1yGWB7F2rGpnSH9xKlLQkDfBIBDcTEFzg4UaJlLkyXG8ZJCSx6KGgm62CjhVxWt2BDfIo3xVSjwBoBUAXD/WNNQU49EYd8CNhx2YyuoiypEveNBrhaY5L7p35jj5TlL7UqLKkMGfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVPr2lPfboRzkl5SerVxInAyD2wunON6615FXsTigkM=;
 b=Yqc0RGlKUCfQH/kX3wkBuhxFpTETKjIZhRg9S7lP/U/OvVUHXLYsZLtRYdLpQGFjsbDzdyY5CFGUuT1ZJC92/yETinLMbNG5QEjirVEyCLnwrwrTIp0bndxgEivP+8cVFr58VxFqavCtBHZAZe/R2TbdOyiMIi/eQgphJmp8Tr2pOvz8doQ8tpN3WHEQN1i8+HUaOhZyK8tfHQF+zDwU5Oe4K8VE0G1tcEsPU333IEWazbg7CG7ektzNzbhjapru/g3N8zW7crSn3+OvGhMHtgRBglwWRgAQLePNguplsP1xd8LmLsW8Gmxv3gTGVL+yIAEVyYuwabK4JQ+pqei5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4946.namprd15.prod.outlook.com (2603:10b6:a03:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 18:28:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:28:00 +0000
Message-ID: <976d046e-6b10-78bd-4c20-d23f81e5c907@meta.com>
Date:   Mon, 7 Nov 2022 10:27:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2] docs/bpf: Document BPF map types QUEUE and
 STACK
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221107150550.94855-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107150550.94855-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1ad280-0eab-4219-2336-08dac0edccd8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5v4B40fNnuaSsKImIh9jm/BE1DsBsAruxeo4rC/n09ierWQkvtK1pqJI8S7Jk1qNJm9jt4tVHUwM2Wwi+GC2BItCaqgBzjylUSfK+RpDhTFlVw9wl3C4oGKbDyyRLZ5KgmnLAfTTCtt/kGbasHNXassrZitwT9Wr1F3qqInXqGHal0hC8cq1TMeONnCDH+53urp5CS1dRmhT6Ft0RrKs4B/V1S9dWyEO31aOcskjIuhbmXsomDgThQhcFU9F8enKt2UEEyAyNpySHQJzHR6uXL6BYsz70bGanyiyD4l/VrrQaWC/uPgx1KW1i5ep0ZvLrAi5KuDBqxrmLs53Rg7X0JE2D8162GsCPJ0eJTmwJes6CGDDccN4rubjlMBLe7gSVS7i6xTbKEWM0o4+0dXQTXuGWsSgqfH1iiOLRN+GERdSwFOPzDsEGt938WZQ82qc+bznAh/K2lSTG6dsmvXOHBY+7/43Gcqt40z4hSJCjp626S4/2Pd/mbaDfS6DwmVgJrR5zgv8g73fmCf1c9srfDI255GMnmCDY0dNN/dZUvc0DriZO4m8/yt8hBP7vgSEjsz/Gqn4LyQ3vUj6kPqIkM05Bqme+YnmAYTvF6N7xv9BMpR9bhpz4KJxnsuN3kpcrSiXmP+9/cPiI2TSyuIvAsu5Y+pCrej5f/2aJnLINc0QJMcaL96xgT/Uube5SBoFGcS1hVsTF+meEiaD6qKu//nzWABAkKZo4COj5QGluwW9z+mWD3QrtiyHWX6l+2QtgHqovgrJFv+Ka2BOZLTnACOkzQ0IkJT2wAlssFINrmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(31686004)(83380400001)(186003)(316002)(38100700002)(8936002)(41300700001)(2906002)(6486002)(478600001)(36756003)(6506007)(53546011)(6512007)(86362001)(31696002)(2616005)(5660300002)(54906003)(8676002)(66556008)(66476007)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjM3ZVZuU1lOZGNWTk93bHRIUk5OczRUN0tpUGJ3VVk4UVNWN2NxUWhQMlVu?=
 =?utf-8?B?L2ZVckYzMXBDUk9jaWhUa25tSWtrMzZmSHROYWxGdzVzN0Q5ZndBa0JLNG11?=
 =?utf-8?B?RUg3QnUyZ1ZKdXpQdE1xeklMb3ZZUGZIRjZZRGFkTHFVYjNlSmZsQnB1T3R5?=
 =?utf-8?B?NkVZRkxBaGpZWk54aGxnL3hVcXlpLzRDZnY1VjJJRXpKcktjMjJzYTl1cHBO?=
 =?utf-8?B?Um5ER0Jqa3l3ZFI2aGNvS0ZHVjZETzA2ckc1RjNrSk1sRXJnVVEzMjkzdkRX?=
 =?utf-8?B?V0k5NFBwZ0FpL1BmT2RFdzExYkFTcmI0djlxdUFFQWcrK2N3RUVKWkhzVldJ?=
 =?utf-8?B?eW9OYlJ0YjBwVUora3lhS1huMnM3eCtUOUhUYnBNRjY2RnE5SHpjL3FsdFUw?=
 =?utf-8?B?Vm5zNWhFMnRCTjJ5U2NRcEJwV3FDZG8vZ3lLYnF0YnRGV3ZVUU1YdEoxNWtM?=
 =?utf-8?B?K1M0cWduZ2Y2anZ0Rjg5aktrNG9zQzMrWHhIRmNQaXhWZ25mOVloNEZRWjBM?=
 =?utf-8?B?OXZNWmVNU3VkcU4wVUlWbmp3aWNRckN1SHhya09mQk9JYkIvZHFiL3FuU29G?=
 =?utf-8?B?UEdoWTJCSEcvcEoreHRJVFBtRnAxOG5KTGRxSTRSMlJ4cTI5eURmeGtNVVkz?=
 =?utf-8?B?VE4yclpablQxYjRFZ1NVTkJqT0VJaVRwd3o1SU56SWNpVkFJUDFVVGRRMUFr?=
 =?utf-8?B?WnJaT1VzelpPeEROZG5tWmw5TWh3K3hLYTZqdTRaRmt6Ujk2OVVUWmNoTGl5?=
 =?utf-8?B?TmNJTHZveXBjWDN2WnVTVDNmNVBjbW1wWFF3bkhmK054a25wTWlRRkNVK1Q2?=
 =?utf-8?B?emNNbGtWYW53dDgxSE9JSnpPUGdxeTV0Y3lVT2grK25EKzF1djd4S1BKbmtk?=
 =?utf-8?B?Y1l0dGdVbHRkK1UyNFhVV2V6SGhPVHhLNnJ4TTE1aW9oSG9ReFN5NEZydm1E?=
 =?utf-8?B?U2xkVXJmbm02R3RZZmRUaVBvVDBsR09RUnZVQytlZ1lDc3lCbzZ6c01OaG5m?=
 =?utf-8?B?RWNOTWhRZ1ZibHZRQzFhWG5FbUhlcGtHWlNMS3lLNlVFaTA2ZkltWFloaGxu?=
 =?utf-8?B?bGduUEdZYWIvR2FXYXBnc1NkT1pHemxQWVRKKytOVzY2QVRZNW40OVNLOG1o?=
 =?utf-8?B?WFQvVEhBbFdIMVl6dEtWUFh3VkgwUzlweFhXMU00RHdYMmI4Zk9UeGRBcXRZ?=
 =?utf-8?B?b0tDY0ErU3VuRlZRNmpFQkRBYTA1ZkZqbVd5Mk14czU5NWFodnBNNDJ4WG5i?=
 =?utf-8?B?a2FKWUlOZnE0YXpEaXZyREFGbmVWWkdHVExZaTUwWlFMbkI2cUJPbXVkNzQ5?=
 =?utf-8?B?Unl0b25qajFQUTdCY3krdzM5Z2lxczYwbFpwaWVoWnY1QklIM0pOTmZHNWx4?=
 =?utf-8?B?cWFDVjY5NllJRWlCNlZ1bHpIOHd5dnpmTkxjQVJrV1JhZWtiQUdjVnNPWTlI?=
 =?utf-8?B?ZkRpNUtpcUlmYm5IV0t6Y0wrdFN1c0ozMjg2VThhRG0rUmg3RXN6dURkTXcw?=
 =?utf-8?B?dGNWVWhoRE1Eb0pKNjZ3MGVzZVZJMUpHNTIvQkZKTmQ1S2hzNHpQZTBWYjJ3?=
 =?utf-8?B?Zjh2K0dNdVpJT2JCUk9KZFRJRGczVVJuN3hGbktkYWFOZ01DZmxFWXJhSmlV?=
 =?utf-8?B?MG9ZZzZZSEx3c1dITlB2cG83WjlvaEU4NlVNdGp5TVZsS1JaRllFRkNGWHI3?=
 =?utf-8?B?K1dKNHRqY1VQeFR2OHQ5NWM3SHBwYko3S1dhZlUyR2prVThEcHZJdzFWTDd4?=
 =?utf-8?B?S0V0ZHBVdXowdUpYQU9FclFlZlM2Z1JkZTJ5NGxRU3BTTUkxeEtkOTVaNEFG?=
 =?utf-8?B?eGZvRnVMdjd1bWF0UU9QQnJzNGRDRkdldmVPV0NIQ0pIOWdGRGxkTjJncGRa?=
 =?utf-8?B?bEIxRnJnRm5QODhMQ0h5OXorR3dtQWxLYTlpanh5NTZyTFBLdEtYVU5MU1Nj?=
 =?utf-8?B?cXJtdk4zVXV0ZjVlU3g5UGtlL2YvbFVSMDhFa080RzJPaXBOOTcwMm5aQW55?=
 =?utf-8?B?RWxVZjF4bHRGVm5WYUEvN0NvT0tVMzZzZ0huNEVCUnYzV2tqM0Z3dTNpTE9k?=
 =?utf-8?B?bjV3Smc2RkZEYkhXbVBGZW5URHNGRUF3MHFkSWZ6VUdyVTR3ay8xN3JnYVZR?=
 =?utf-8?B?dkZUQWpQQjd4WSt4NHllWHArZm94WmxLWVdSSjNybmJ4RHF4TGxiMjVJNWZ5?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1ad280-0eab-4219-2336-08dac0edccd8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:28:00.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLICZUlCwAEx0NhDtbHoXAXdqnMOtGyNAJ4lybOG40/VEh7jTR6Lh8wWQikCar92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4946
X-Proofpoint-ORIG-GUID: PFWvDkoAlRnCPILGuy-4dKaZmRPRU3wh
X-Proofpoint-GUID: PFWvDkoAlRnCPILGuy-4dKaZmRPRU3wh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_09,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 7:05 AM, Donald Hunter wrote:
> Add documentation for BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v1 -> v2:
> - Mention "libbpf's low-level API", as reported by Andrii Nakryiko
> - Replace 0 with NULL in code snippet, as reported by Andrii Nakryiko
> ---
>   Documentation/bpf/map_queue_stack.rst | 120 ++++++++++++++++++++++++++
>   1 file changed, 120 insertions(+)
>   create mode 100644 Documentation/bpf/map_queue_stack.rst
> 
> diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
> new file mode 100644
> index 000000000000..6325648bf0c7
> --- /dev/null
> +++ b/Documentation/bpf/map_queue_stack.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Red Hat, Inc.
> +
> +=========================================
> +BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
> +=========================================
> +
> +.. note::
> +   - ``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` were introduced
> +     in kernel version 4.20
> +
> +``BPF_MAP_TYPE_QUEUE`` provides FIFO storage and ``BPF_MAP_TYPE_STACK``
> +provides LIFO storage for BPF programs. These maps support peek, pop and
> +push operations that are exposed to BPF programs through the respective
> +helpers. These operations are exposed to userspace applications using
> +the existing ``bpf`` syscall in the following way:
> +
> +- ``BPF_MAP_LOOKUP_ELEM`` -> peek
> +- ``BPF_MAP_LOOKUP_AND_DELETE_ELEM`` -> pop
> +- ``BPF_MAP_UPDATE_ELEM`` -> push
> +
> +``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` do not support
> +``BPF_F_NO_PREALLOC``.
> +
> +Usage
> +=====
> +
> +Kernel BPF
> +----------
> +
> +.. c:function::
> +   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
> +
> +An element ``value`` can be added to a queue or stack using the
> +``bpf_map_push_elem()`` helper. If ``flags`` is set to ``BPF_EXIST``
> +then, when the queue or stack is full, the oldest element will be
> +removed to make room for ``value`` to be added. Returns ``0`` on
> +success, or negative error in case of failure.
> +
> +.. c:function::
> +   long bpf_map_peek_elem(struct bpf_map *map, void *value)
> +
> +This helper fetches an element ``value`` from a queue or stack without
> +removing it. Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   long bpf_map_pop_elem(struct bpf_map *map, void *value)
> +
> +This helper removes an element into ``value`` from a queue or
> +stack. Returns ``0`` on success, or negative error in case of failure.
> +
> +
> +Userspace
> +---------
> +
> +.. c:function::
> +   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
> +
> +A userspace program can push ``value`` onto a queue or stack using libbpf's
> +``bpf_map_update_elem`` function. The ``key`` parameter must be set to
> +``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
> +success, or negative error in case of failure.

Besides BPF_ANY, BPF_EXIST is allowed as well?

> +
> +.. c:function::
> +   int bpf_map_lookup_elem (int fd, const void *key, void *value)
> +
> +A userspace program can peek at the ``value`` at the head of a queue or stack
> +using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter must be
> +set to ``NULL``.  Returns ``0`` on success, or negative error in case of
> +failure.
> +
> +.. c:function::
> +   int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *value)
> +
> +A userspace program can pop a ``value`` from the head of a queue or stack using
> +the libbpf ``bpf_map_lookup_and_delete_elem`` function. The ``key`` parameter
> +must be set to ``NULL``. Returns ``0`` on success, or negative error in case of
> +failure.
> +
[...]
