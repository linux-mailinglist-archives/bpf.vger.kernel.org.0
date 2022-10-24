Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0D60BB95
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiJXVEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiJXVEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 17:04:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A368F975
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 12:09:50 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29OIxJRC022751;
        Mon, 24 Oct 2022 12:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=bbAERDoczxEcK9NJM9rbQW+BYY3cySbfwei3a5xpQhs=;
 b=cv68081SIeC7DnjJu43mZpGV6OQCfSddM4AqsNifO3EQemYRIyJalSCtHObZ/ncKKB+j
 QrOtF1/hmzVblBWMYL2RZvj2ALvVEfGYQVgrh0kGA9qTcnONHDHUkAFt6keFgUoAiL+X
 6urZKYZV7Fubmuwv99QQgZfB4QxhRx99jC7ii32ckFurZHhMDCb07em3Ac+pdlLMyTeT
 q2AiujQkU9MLnl4lUCNrp1z47F3nPFNI1vTlWJWD7Bzzr/bjNpOcw/NgUirsBVNsJ3Kg
 002Dj7rrJ4j4wkqWVDkmHgHofWAfXiFzGleJsJkkAxBONLhmXQokyyD3c7zuC92teXG8 sA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kcc1bn1mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7naCbG9NKsbKEA1dM1PQV9MVBSNwEzfJQVe9xTbdMjYiH21sGUI5q7WtBvumedtRoA5eJYAPgjeuDkRK5xUs0sVZktj5LL5rvgbL4X7jPNUlCzZZVhN/ccenBMbODtv7xTyiufRrt4BJ57ddxcpZRj45C4wZ/q0lfJfhXlffgrtWxL0C4ohPzNlgtOREztxqRVYKy0/MSL6fsytmeYnkKuoXhauMPjrlShK89RRu5UI9SG86HOneIa/BlVd/LLEzRXBfJJpzOhHaOy4JJPOOVgKqt8dvKWYn43M4VYoPSjsRbCznFkn3HORumw68QSGQ9QxXevxmUQ5z8REmGjTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbAERDoczxEcK9NJM9rbQW+BYY3cySbfwei3a5xpQhs=;
 b=cNX/MZMhq5/t9UZBrYCvX/HMTVEFtZU4XgCoe/zPbKcnTVyVdR2BinPwQzAoypTsoT+mTHGBO0NdPYD56V4FknNV2CCA65mbRIkUBDskpX+Jb3OaK6Z6MxXBl/WGdl2W14WzjEZLfx0DnpGTwv32K4FmWL/z/OHAel37dq+jtL4Yj3+sd7IOi+iFZK/lM7ByWy55iqvRiTtd71FX0YXLP87u0Mv7EPKGfI2ZGYRfZntTS8aUKS/yFkB+3NBH+rWNN7c//OdR5XypDJrDutx72Z4G4u5M5OgA4rlIdkNp+CSw5Z8LvqASYQ9+v8hZHsJ/wfN1rLeGMDjnrEj/buO+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1535.namprd15.prod.outlook.com (2603:10b6:300:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 19:08:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 19:08:27 +0000
Message-ID: <b41cbcef-262a-2f6f-e41a-52c55c48819e@meta.com>
Date:   Mon, 24 Oct 2022 12:08:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Refactor inode/task/sk storage
 map_{alloc,free}() for reuse
Content-Language: en-US
To:     sdf@google.com, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180524.2859994-1-yhs@fb.com> <Y1bTL/v1UjyPDWVA@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1bTL/v1UjyPDWVA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MWHPR15MB1535:EE_
X-MS-Office365-Filtering-Correlation-Id: dac4e810-63a8-4ba9-b7b8-08dab5f32196
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QClFfjLSk3SRsg4LG7QnS5Gp7WYOwCxKNXc3L5yhf1wogyiy7DNnZB8XNBBsdMWOValcZPL1fQ3UUoJyN0urfCku+LvFoe6s149SpQQQyrSg3sgfXhBeVUcRey2J/NHzy9EgcUQu1SQwkgFETNXNMTh7Gxsf52KTxL6u0pwFf+7ce7u/GbRPiI70HdH9mXqrYaQPLtkRdOocZrT81agzV2MZc1Tutm87OG9RBfzme+UlqCmmHj2Ds4rg0St0mbOHRGK7/TOUso96rVyTHDBZ0TzakhpRjXWK5X5lInp9soh2EegioeKEpqIn31435kskJPONKjRYCplCGpXhMohUnaf4ROnrm2PA4dHS3sZxA/tC5CZLM5TXh6MQ93Qpp7YA3hfH5XiudUoBRWuRrots1arfDiDCHM2s8UxUGLBcEsy5kHHmLQeS9Ia3h/taG89Mpe5rkvPOY5Gndh19zZ9AnH5H/CijE5H9xoM+tncaD+6yrX0rZkjCq2+6KdyXkKo+gy2HDCOztbGf9A80EO3eNf+mTM6+oF4WFeN3320S6Z/rjoDBfMEQFcT7T0Ci6CShGAP/FY8v+yXFn51zjXpKyERMyw0rQnsebB20fDOA+OxLk4DgETyllFT53l99QA9ZN8S0zMRLcTmm8uADKQnOwVnBu0sd7o92c1uKQmuIJ+iLygutCwzDPd2tCXzb3KpLHueqCKzYIv18f1/nLWYgkoY3A6VoDvyVw7Hee+7xSwQndXEMzNWlj3rc4GNNshoPlFRNiMFVWni8fAZRMsmY5S1j6XTXxJQlKWdwF0zpl2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(31686004)(41300700001)(2616005)(186003)(6666004)(66556008)(66476007)(66946007)(2906002)(8676002)(4326008)(5660300002)(54906003)(6486002)(8936002)(6862004)(316002)(31696002)(53546011)(83380400001)(6506007)(36756003)(86362001)(478600001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhoNnlyNGgzS21iMVk0cDJ3aEdlZTA2STlmZmVweGJsbUYyQXArYUdhaFp0?=
 =?utf-8?B?dWhiV2E5NzU4OXBybGVXVCtkUXlmQnJMZWVyNUVMVXVRbnVhWjFCYTlVZHND?=
 =?utf-8?B?ekZ3YWt6azhXVm12WnpZZ1ZXTjZ6eDEzMXMxK0doc056RFMxd3hSWmpsRWI5?=
 =?utf-8?B?VFV0Q2VaZ1dqbFM1Nko1L1BQUnpIRkEwaVF2UEVoQnR5dzNweWZ4NlQramRw?=
 =?utf-8?B?U2cybTIyaUFnMGJQbWYrbFNsdHZhZHpnU005Z2swTkxkQ0hEajZCN3dwcS9i?=
 =?utf-8?B?NitoYzZHd0NIZUxNV3hPUmg0K0tTblFXb2hjRldJNU11akR0Skt3RnFjNzZ6?=
 =?utf-8?B?YU4zZEd1V3pwc1l5OW9vNnVEczdUZTdjbUU5bFFEOXdibnZKMzRWSzZjZU94?=
 =?utf-8?B?aXIyUkRudFZuMVZaYi9uZis4NGJwNS9NVDFyTzZWaTkyTHVXOTVMRmpLU0Rp?=
 =?utf-8?B?Yjl1bFFVYmhQOGhpTVhmTGlBVjVnZU55ak5WMy8rb3RLc3F4K0tqZ0pSS3FJ?=
 =?utf-8?B?emtLRzJlMTU0Nk1xbnYyRWppYS8vVmhiR1UwN1pqWXpJOVU1TS9CNjJMK0JF?=
 =?utf-8?B?ZWxTeEkrdlBzU3NRV1h3bDJQcm9oaGQrZ2RCNjdGNlRJWmVrb1QwTjFVUHpj?=
 =?utf-8?B?NlMwMml1YjZ1QUNQUWtCMk5Sc3p2cCt6R2ZYTDdYWWkrOHAyVW93ZEdUT09Y?=
 =?utf-8?B?ZkVYeWdIL3BWMkQ1MXJ5Ri9QM3R6N3A3U3NNQURpTGJCeEd4WE5WQ25iK2F2?=
 =?utf-8?B?Z1NiNndkSU1Ta05jTjhpSFk0M0c1WlA1OC9UM3VHVjdxNFI5d1JpWC8rY3Ax?=
 =?utf-8?B?d1ovTExkRDFXOEdaVnRQUk5VdmYvdFFjdWV0cVZsZkJ5VXpwSC8xU3VSczBT?=
 =?utf-8?B?NlJTaDUyOStjdkVwVTk4TjhqQ0d3ZVY0cFRxRE5Yd0pIMlh1Uk9TSmtqaFlS?=
 =?utf-8?B?aHQza01IZmQ2TzFUQzNlZzNZQ09iM3lPejNxUWNndmNSNDZhKzA4b2JNbDFo?=
 =?utf-8?B?ZHpQbGpPVmNYeEFvaU9pVWl0Ly9HelNPWjZHSW4ybFVuZ2RmTHZiSTV0czB4?=
 =?utf-8?B?dzNUaU5rNDg0R0M5T3o4NkFzKzVzU0JUaXRSWWdwbVNWZGpKbjhuaUxPTFQv?=
 =?utf-8?B?am0xRGROdGpvSWx1cmlCbVNKNS9tWE92YllibHRkUlFDWk84WHlJbTI2UmVT?=
 =?utf-8?B?T0NxK3Ric3V2eHNxY2p3bHFTdFg5WTRrc2taV3VYYm0zZUF1UitZbzdzNkg1?=
 =?utf-8?B?VGFRd0Z3WFRtVjJxTXYwS1JUa3B0WWgvRlhoWWFtRDBNeWtkNmdueGVOTjlv?=
 =?utf-8?B?K0NIRzllbThKbnNrd3pha0hkbDRIV1dwQkdIT3hPTGRqcFNKYXd2Qjk4VC82?=
 =?utf-8?B?QWVsYzM4Nnpybjg2NkovQWVINk9qUjIzbDlKYzU5cTJhNHd3MndXeUFaQmJq?=
 =?utf-8?B?ZzdjWnU0a1RicUpXQ1NBY1ZUWlNGN2dyTWJEdDR5RmdZeHN5YUYxaWFDYm9Q?=
 =?utf-8?B?dVBWTk0vdWd2KzRJUy9XT0g5bVR4cTNOR2tDbzZ3QzhKWS9nK21KYWJWKzFK?=
 =?utf-8?B?TXFzNENzUGNSSDVCUkd3RFNTb0RXam1kdTFEazlwMUllUnJIZVZrWUx0bFZw?=
 =?utf-8?B?WXlkSFRqSDlvNWxDSTRxOUZNR2NlOWRzeE1FaTlDYXVQRlovanl6bUVGbWJp?=
 =?utf-8?B?S3pxQXhoRmxNSk1Cdi9lc3F4a3d0WjRHUTg4RzRIS0NNaTZzU0V6VEhGdkw2?=
 =?utf-8?B?b2R4L2d0RjE0d2pEVTJveG9mNmI0SUFuR2kzNG9JY2xBV3daeURXNllLV0p4?=
 =?utf-8?B?clF6LzJFVmZ2a1FZYWc0eitjNFljWjRNYXpFdkcwOVNhWnZnY1JXcFY0Ti9I?=
 =?utf-8?B?Q3cxRjBXSGZNZGdZa3ZnY3pyeTB4MzRBdW8yN0VoVytOaEFOVXE1VHAyeXZo?=
 =?utf-8?B?a1N6N29tZ3ZmZGJNbS9UMXhwcHJGeEdSWVpRemJzYStZOThYeERGQjNOMHpi?=
 =?utf-8?B?cE5TRm1ZVTFEdm9FNmRWZWdIQlhEV3dPRmRWNnl2dU1Rd1d5VjlqVVM1ZjJR?=
 =?utf-8?B?R3NuWlpleTNHK0JDR2VHQTMxRjU0cWNubGhEcUh6WEdLR1pnbW9GRm1xZlpV?=
 =?utf-8?B?eUlMNWdmQzBiS1E3Ulc4cDVZa0ZBNnRRMkw4azBSc05xNkE5UjRpVmcybnNX?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac4e810-63a8-4ba9-b7b8-08dab5f32196
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:08:27.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/2d7SW2ZiPNfRcukAtnib+nQZB6gPUbjiLnjE8hNQNu7L7ic3pye5bDFoZ/tZrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1535
X-Proofpoint-GUID: _ZPZwy9IwfULqgDJ7BxRl8TK5n_f7_UT
X-Proofpoint-ORIG-GUID: _ZPZwy9IwfULqgDJ7BxRl8TK5n_f7_UT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/24/22 11:02 AM, sdf@google.com wrote:
> On 10/23, Yonghong Song wrote:
>> Refactor codes so that inode/task/sk storage map_{alloc,free}
>> can maximally share the same code. There is no functionality change.
> 
> Does it make sense to also do following? (see below, untested)
> We aren't saving much code-wise here, but at least we won't have three 
> copies
> of the same long comment.

Sounds good. Let me do this refactoring as well.

> 
> 
> diff --git a/include/linux/bpf_local_storage.h 
> b/include/linux/bpf_local_storage.h
> index 7ea18d4da84b..e4b0b04d081b 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -138,6 +138,8 @@ int bpf_local_storage_map_check_btf(const struct 
> bpf_map *map,
>                       const struct btf_type *key_type,
>                       const struct btf_type *value_type);
> 
> +bool bpf_local_storage_unlink_nolock(struct bpf_local_storage 
> *local_storage);
> +
>   void bpf_selem_link_storage_nolock(struct bpf_local_storage 
> *local_storage,
>                      struct bpf_local_storage_elem *selem);
> 
> diff --git a/kernel/bpf/bpf_inode_storage.c 
> b/kernel/bpf/bpf_inode_storage.c
> index 5f7683b19199..5313cb0b7181 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -56,11 +56,9 @@ static struct bpf_local_storage_data 
> *inode_storage_lookup(struct inode *inode,
> 
>   void bpf_inode_storage_free(struct inode *inode)
>   {
> -    struct bpf_local_storage_elem *selem;
>       struct bpf_local_storage *local_storage;
>       bool free_inode_storage = false;
>       struct bpf_storage_blob *bsb;
> -    struct hlist_node *n;
> 
>       bsb = bpf_inode(inode);
>       if (!bsb)
> @@ -74,30 +72,11 @@ void bpf_inode_storage_free(struct inode *inode)
>           return;
>       }
> 
> -    /* Neither the bpf_prog nor the bpf-map's syscall
> -     * could be modifying the local_storage->list now.
> -     * Thus, no elem can be added-to or deleted-from the
> -     * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> -     *
> -     * It is racing with bpf_local_storage_map_free() alone
> -     * when unlinking elem from the local_storage->list and
> -     * the map's bucket->list.
> -     */
>       raw_spin_lock_bh(&local_storage->lock);
> -    hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> -        /* Always unlink from map before unlinking from
> -         * local_storage.
> -         */
> -        bpf_selem_unlink_map(selem);
> -        free_inode_storage = bpf_selem_unlink_storage_nolock(
> -            local_storage, selem, false, false);
> -    }
> +    free_inode_storage = bpf_local_storage_unlink_nolock(local_storage);
>       raw_spin_unlock_bh(&local_storage->lock);
>       rcu_read_unlock();
> 
> -    /* free_inoode_storage should always be true as long as
> -     * local_storage->list was non-empty.
> -     */
>       if (free_inode_storage)
>           kfree_rcu(local_storage, rcu);
>   }
> diff --git a/kernel/bpf/bpf_local_storage.c 
> b/kernel/bpf/bpf_local_storage.c
> index 9dc6de1cf185..0ea754953242 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -98,6 +98,36 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
>           kfree_rcu(local_storage, rcu);
>   }
> 
> +bool bpf_local_storage_unlink_nolock(struct bpf_local_storage 
> *local_storage)
> +{
> +    struct bpf_local_storage_elem *selem;
> +    bool free_storage = false;
> +    struct hlist_node *n;
> +
> +    /* Neither the bpf_prog nor the bpf-map's syscall
> +     * could be modifying the local_storage->list now.
> +     * Thus, no elem can be added-to or deleted-from the
> +     * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> +     *
> +     * It is racing with bpf_local_storage_map_free() alone
> +     * when unlinking elem from the local_storage->list and
> +     * the map's bucket->list.
> +     */
> +    hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> +        /* Always unlink from map before unlinking from
> +         * local_storage.
> +         */
> +        bpf_selem_unlink_map(selem);
> +        free_storage = bpf_selem_unlink_storage_nolock(
> +            local_storage, selem, false, false);
> +    }
> +
> +    /* free_storage should always be true as long as
> +     * local_storage->list was non-empty.
> +     */
> +    return free_storage;
> +}
> +
>   static void bpf_selem_free_rcu(struct rcu_head *rcu)
>   {
>       struct bpf_local_storage_elem *selem;
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 6f290623347e..60887c25504b 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -71,10 +71,8 @@ task_storage_lookup(struct task_struct *task, struct 
> bpf_map *map,
> 
>   void bpf_task_storage_free(struct task_struct *task)
>   {
> -    struct bpf_local_storage_elem *selem;
>       struct bpf_local_storage *local_storage;
>       bool free_task_storage = false;
> -    struct hlist_node *n;
>       unsigned long flags;
> 
>       rcu_read_lock();
> @@ -85,32 +83,13 @@ void bpf_task_storage_free(struct task_struct *task)
>           return;
>       }
> 
> -    /* Neither the bpf_prog nor the bpf-map's syscall
> -     * could be modifying the local_storage->list now.
> -     * Thus, no elem can be added-to or deleted-from the
> -     * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> -     *
> -     * It is racing with bpf_local_storage_map_free() alone
> -     * when unlinking elem from the local_storage->list and
> -     * the map's bucket->list.
> -     */
>       bpf_task_storage_lock();
>       raw_spin_lock_irqsave(&local_storage->lock, flags);
> -    hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> -        /* Always unlink from map before unlinking from
> -         * local_storage.
> -         */
> -        bpf_selem_unlink_map(selem);
> -        free_task_storage = bpf_selem_unlink_storage_nolock(
> -            local_storage, selem, false, false);
> -    }
> +    free_task_storage = bpf_local_storage_unlink_nolock(local_storage);
>       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>       bpf_task_storage_unlock();
>       rcu_read_unlock();
> 
> -    /* free_task_storage should always be true as long as
> -     * local_storage->list was non-empty.
> -     */
>       if (free_task_storage)
>           kfree_rcu(local_storage, rcu);
>   }
