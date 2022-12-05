Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A36642E69
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLERLY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 12:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLERLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 12:11:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587E6B7DE;
        Mon,  5 Dec 2022 09:11:22 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5GXZeb001895;
        Mon, 5 Dec 2022 09:11:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+09G0yrhfLaTK5yTwPbBMAsPG5ow/ebQzpDo6DoQHpk=;
 b=UJ8YWJLLJSh5r821Np3FdUPXkyaRbCZwKdbZjZ8aTqm65kD5GWpmC+IlZf7BQWyLEUdj
 L7OnP2ovNe2JM6R1nIZ0lpv94oae1SdK12T7OiK5rd7aTq2wRJacnekwkTj7fUhH9YS3
 EREs0/K5eaYBj4JJDHMDOZL8ueMnbw3l2Tsh7PoQKOPTMQnTeFqnn+RkWQ4taC17ojjm
 UHlp+sHVllAZIdCa8hWTkvPQWEhWq66jokYTlbgwCE4sH1DOK87tNxnU4jM8fZfqk3vl
 Jz8EyXFJHQVe2bIrXsFLgM9kg+vCSOBXMn4xFR5kWCjvOqvLCH/jIoAYKcQKyBwaEQXb OQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m851tmaye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 09:11:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzwj1RCI9uWVo0en5wIjELcfnhS3jVRSIqFQ6lC6NPBKgBRFd/NKZlwa6Xgw/ENIuNCrx+S5PMjleJox5I7YxiZ6MvwuVkQSnyZUAfUqX5dtioiMpuww0aniSNOX4O05dC8L+41XzNO2g6Daz+A3qzx1Ce7jBnA4JZZ2RCU32nScHpSbiinVBQLVnnPcmWaOjftkZnPJsGcNRsk4xKG0mGQBn/EefmCXmcLbEetjHEwETTPuEmVF2tlhhVimXE1kyKlfiBcsy0PNwWw9tnOGEkO4e5T3AoS/7v7TM4vUDeIEBuxK9HsBUDEHQHKZyQ9zZpnwe+LJ5tLyF372gKEYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3iMjzAEUpiWPaX76gd90/x2e+fgOsTBTphdCfPLJyE=;
 b=UgvEj0lqcK4eyvCZdA2zsZtlJ4gFXx1/m5ZHJxoSvKFUNNl8jAOWtTR5ZOLeluCEHxtJP57e/ru4cQW4H9QxtSdBmiEUIsFeEn17lH17jnx81WqffIGgNzx1cBLLxSsQbUmsVJFa6k7DRYNv4x2X6Ny41adBBlub8QFxdvft9GtD5oSpXTm/YPqs3RL7M0CDjcObzzIdOI+qxuwTCH7DG8w2AYNnbA4lG7S+v/YBOK/+VTIQ2I4dCaOfilwZFhH7hhXeU5nSJUNN+0x8D70W1oogddTkvdysJVmXddCT5HhEn2Lb8CVgYOlLAKnLyXd1HKJtXZTfRSGKq3HH/2C+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2015.namprd15.prod.outlook.com (2603:10b6:805:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 17:11:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 17:11:04 +0000
Message-ID: <074b6d29-de8e-e310-b30e-26916f95b472@meta.com>
Date:   Mon, 5 Dec 2022 09:11:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v1] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221205161555.34943-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221205161555.34943-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR1501MB2015:EE_
X-MS-Office365-Filtering-Correlation-Id: d178cb7b-509a-4c45-91df-08dad6e3b0bd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKkLDfTrPii+sIOuRhYwFomGW6Qam1G/0dqVyrXulqHBMefUi9NnGwa3yEnTYA679jXbyteHxVRrEF82Fl3PEyfN5s/XbrCePd6rXtWTWHWkV1+ouykL5bo77eTViLqj4qs4iV+xrB0arnQua9yAIuQ39vIy/lGuQhl2tDy7xV2jG1BuNFTtKSrfbZizh3MYh1LdnM3kBg/vrb3aGYA9qA7Yz4nysldOlJHBgW1NsoBRs+rVMn+V7oYzu3kHIC+60nJK3xwO/0TToa3tX4+prkpseRs/csRwlb6w9eUJGS8R8+96PecEdbCiLoy7E2wIv6kcS26+BzgDfT0O4k5alax+7n7kHnKpOVkYE+mItUXQPW1FZszXfev9GFdR0h97knmIrPPG6skgLqrTRZQ987oFjq+/xthWfiQbY/ZGuqeL84brNtohTURbcPyI522fxsgS5dE45S4oAJ+QNAorA8bugw2CviDLpQ4AslE6piVArh3D02pvfR/mY3q+aSOMVVcC3gJ6Pr7KkP4BQ11B4RM2NeMEsl2MEcODWKIFTu6ho5Df9WsotBCjiVwvbJ8e2cJRQ5PbgM6EcN7ViYw9sZiYJyktlwfnM2LkyFz1/JeCgInCK73VKtF38ohX//uxsFhhNNdV3xrJ2gDuPgrMy58W/nribN9aBpcnrQKfnET+Y6tzj8C6jrM21zrnzIxffeOHqUSrUsl5uzgMJjwYky0uyUpqtaUC49rVKUr4Ummmr1ba+qIYSnyTg1xdCQRx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(31696002)(2906002)(478600001)(86362001)(316002)(66946007)(83380400001)(6666004)(186003)(6512007)(53546011)(6486002)(54906003)(2616005)(41300700001)(5660300002)(8936002)(38100700002)(4326008)(66556008)(66476007)(31686004)(8676002)(6506007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZnNlNmTGsrWW5qekFMWEo0QzArTi9MUmwwN0V0Q0s1YmxBSG8xSVJaZnpv?=
 =?utf-8?B?UjVHdTUydXBWL21RKzdib3l6SE44c3Q4K0NrUHEyUUVBbXI1ZFVtdU9NaTl2?=
 =?utf-8?B?YnlMTzdRMS9tRHg0UG0xSnRqQ3VFbjNpa3BIV2lnQzNRS3BsZEFDWVI2d2JU?=
 =?utf-8?B?WlVXMldXS3ZFNlhhRnppeElIV1FxVXlGUkxXYjlVZFg2VEVCSDJRUkNacElX?=
 =?utf-8?B?NDhwelJEcXVERzZuaFlqQkQ4OURJUStoRnN1Vkk3eTBkbWZON08xWTJCL2Iz?=
 =?utf-8?B?emxMVWlYTUFaYmJEUFp3cXJNUUlYK29wYmJ2a000VktwVVRNRlp4clJTKzFP?=
 =?utf-8?B?cSs1N0VLaEVEWFZoTHBmTkF4WHVxbWxXSjRLL2lLNnc2R2RXdGdWSjRHaTRU?=
 =?utf-8?B?TjFybWcvYVhlci8vNHlVOU1tZjlicUxVOFRsYU1naVYzcmUxT0ZNelc4aFFj?=
 =?utf-8?B?a0tXRW5XaUgrY2lJbVVuZEhWWElQVFBvR2lNYXd4RXltdTRZK2wrVVRISHE4?=
 =?utf-8?B?bmVtU0pqam91QU9zUlRMTWVPK2N0YWlVL3NQR1VDMXgxTGZhTDkwaUFkc0Jz?=
 =?utf-8?B?UzRrRWRjdkVCTTYrK0R3THpKRVZyZXBDQmZJa0gxY1NQeUgyQW5DNjZNU09S?=
 =?utf-8?B?S25qM3lyRHdKZ0VOYlZTSGpucDNBSzh5Ukk2RWxURDgvcDhPWUxnZCttcG5o?=
 =?utf-8?B?NFFROGc4aVM2UkJhWTc1bkVPNHFaZDZhZStuWFZWbG1ZUnlRbXFtVjREeVJk?=
 =?utf-8?B?UXh3M2tKNEU2emtaV3M0eXVuRXREbWZteTV1bGM3TVVVUlN6alVZeUJRS09S?=
 =?utf-8?B?bGt6WVkya2dKVHBLK0ZQeXhrQmlLblJTN084QXRGT1QzdUM4eCtHdFQwbmVL?=
 =?utf-8?B?ZkpINXRhZHNRc0VqQlArOU9uTFFoS3J0YVQwOEZOYUE5Mmh6S2tZMHkwQ0pG?=
 =?utf-8?B?UGJydjBkYmxwbmZrYXJOM3pmc3hwOExoT2xUZGw1MGM5ckNJeUJ1UGdnSm9a?=
 =?utf-8?B?NkdiZ0JmaEFNUlU3WWh0Z0hSVlZVYUpQYVlab1IrS1FDSllHWWJETzYxZFhF?=
 =?utf-8?B?akhKYldzamR2RXBSUXova0Q3dGhZd2VjVTFKZnlRVWRzdnJETjhqZStmZ0l0?=
 =?utf-8?B?dHc3b280dU9uVUYxVFdFcmxwbDZWeHVYVHBsOWFQWkpmTkVaUU5QcEN2TmEy?=
 =?utf-8?B?Wmx0R0sxTXppY0kySllISW5PdHlKNkdadUJ2dnFCNTVlNjIvaHVTQkF3NW9m?=
 =?utf-8?B?eHUya25vSExLdngrMi8wYW9MVzV4Mmt1NE9SYTRGTitnQnhNbjMraFZwaWdr?=
 =?utf-8?B?aDl4WmxrTkU5ekdzd0oxMzB3MS9USHFKY0xFaFNkUjJBNnNyTGIwaGszYmh6?=
 =?utf-8?B?cEJEUnRsM203M2RiUWRCbFQ2OG1aZXI4ZFNEamV1STBDZ25QVXFYSmM3aW1P?=
 =?utf-8?B?RjBLQ212WUhzTCtIT29rbk1RVG5RVlpFRVQvQWNlS1VzSDh1SlJVaXllKy84?=
 =?utf-8?B?dlEvNy9sL2ovRXd1K2hQSk11dE5nK0Vjak9IcVRQTnlUdHJhTlZmdWU0WnFR?=
 =?utf-8?B?WUpYTDFOTmhVWm5LV0FoTjZmZXIvQ2crSzI5UzlvanpXSTZVcnEwM2ZvR2lM?=
 =?utf-8?B?R2l2cmdDNWpuY2FpTDZyNng1clBHcFF5L3pZbDY2YkJnTnJtbDZuU0JYdlUy?=
 =?utf-8?B?aFVJUVJGbktTSnRQZG5henMvTW5hdXluOXc4REE4ZTB6c3JXQ053MElnQXpR?=
 =?utf-8?B?akdYblZKOTZXMHhOcmVVWlFZSXZWMXhPNDViM1B3SEVrVVMrNU03OWxXTDlB?=
 =?utf-8?B?WFpiRGc3SDZrOGpuc2F2SVFhQkhJaWh0ZVdCRXd0RHJhZThYTk5yMGxyRHZM?=
 =?utf-8?B?SlJvRWtuankvT2YzK0ZVR3RidEgzZWxTTzhpNFZaWExuTnREcW1HMEZxS3lw?=
 =?utf-8?B?bkY0d2VrbmgrbEZFa3JBWk0yYmZTK3JWVkRTZnNjNTZQK1F0MGtPNXB3MXI3?=
 =?utf-8?B?bjIyZnY2MEFrQXZkcyt5NHE5d2tpTGZnU0tselZ1UTFUTkRWZmNpR1hzR3Ns?=
 =?utf-8?B?eG5mRE9Ma2hoaTRXalAyc0MzbWFLQ1JYMjdTcGdKYnAzV1R6Y3FzUE9hN21R?=
 =?utf-8?B?dWxueGZHSzhqVDV6YW1kbkhqKzdmNXE4TVVWaFdZVGJFMmErT3VzZUMwY240?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d178cb7b-509a-4c45-91df-08dad6e3b0bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 17:11:03.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps/KYjKeItW0qBJkoVeMSQGD1Kw2GD+AL/v4/QZBx9nuImfF/TXmJz7L0q9OTTaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2015
X-Proofpoint-GUID: crQ5SFCIQ2JXRyk7NGzj_vLEz0f1dBW3
X-Proofpoint-ORIG-GUID: crQ5SFCIQ2JXRyk7NGzj_vLEz0f1dBW3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/5/22 8:15 AM, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>   Documentation/bpf/map_sk_storage.rst | 138 +++++++++++++++++++++++++++
>   1 file changed, 138 insertions(+)
>   create mode 100644 Documentation/bpf/map_sk_storage.rst
> 
> diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
> new file mode 100644
> index 000000000000..abb0c60ec5a4
> --- /dev/null
> +++ b/Documentation/bpf/map_sk_storage.rst
> @@ -0,0 +1,138 @@
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
> +   long bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)

the above signature is not precise. Please use the one in uapi header:
   void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, 
u64 flags)

the type for 'sk' can be either uapi 'struct bpf_sock' or kernel 'struct 
sock', depending on program type.

The same for below bpf_sk_storage_delete().

> +
> +Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
> +the storage from ``sk`` that is identified by ``map``.  If the
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
> +storage for ``sk`` if it does not already exist. ``value`` can be used together with
> +``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
> +initialized. Returns a pointer to the storage on success, or ``0`` in case of failure.

``NULL`` in case of failure.

> +
> +bpf_sk_storage_delete()
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +   long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
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
> +                                         BPF_SK_STORAGE_GET_F_CREATE);
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
