Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7A567EE5
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGFGrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiGFGrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 02:47:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9721B79F
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 23:47:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265JJIqV016561;
        Tue, 5 Jul 2022 23:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QI+NYMgyqZWkxIfkcegzUvk9cB6UBh6V4U2A2z9qjWY=;
 b=Pw7JDZq505GuUQIg8bQvJurZQPbZYbpazWNHDm0qc11040TcSGASqdgyQ1tmCdFA5lYx
 x6wj/+QGjiXdNjNDupsV6XtU/90FwKXCsv8SfAvaIRAeIOoQZ6bVhlwaHHAAIGJAVcBJ
 hHMJaB+fZf8LyNfW7XazTW4i7p6VpmWMnU0= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4ubuug7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 23:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axHm/kvrZfDO7Fz+sZsdF7HlyfAMFSkU0hcCvcggomqLPE+PDtkH2ew5M+lu9AkLrq3w54fztWMf7+biAfxz6QOhGF/AQ5eHSGy8ZscL9f1BxDJa/7/XwW6RgD+Mq7fHIyiPCVCiVjTL3wEZbmsS/Vv7tbbe6BaOVAXpgGazyXuCMpNKUnpMCj3ewnIgnAiEgPftNVFc46WxHGXySyk6EuDFv6hb4Pl+lEZYUpnHFetS1xU4PMqn7dFGDCqKb70zSZzA4pNqSS7sIEJxx2mFf95Whz//XP6p+lXKGei9GOLKYnMjIzT9K/NC2DTFEgfEfEQxbICNCL4LM/MJEk4Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI+NYMgyqZWkxIfkcegzUvk9cB6UBh6V4U2A2z9qjWY=;
 b=BuY+wz0lxJ8ARjRGG5H5yzEYHJMRoip1ItNKQ8aT3hKDaizBJm0RbFa0jrY1kmSUBgNcXwfzuRQ5XDiY8B98hCskw5nKO3pLhJs7/OMnVJ4rZu5GOgZPU3cYQ2nHJg6RNDMCK6iBtqeYJTa/Xoc75OXywquANr192B6GR4Jl5C4K64tJ6qxgCbmefunr5qJSlS4NEeDFqDD+K+wxYwXaq/hCTwooPkY3TqC6NyRssi7WNuNHZyPjgXIqB6ZCYxiLGF4+BQNq47BR5+VCORzrJFoMtcZM839Yk6e2vTC726mn75m4hfnXKiCoVcSPrwj7Gy8GIJcmpCrlOw2kzLj72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB3719.namprd15.prod.outlook.com (2603:10b6:610:6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 06:47:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:47:18 +0000
Message-ID: <a4b0c2f4-4fbf-6b29-521c-aacf6f01973c@fb.com>
Date:   Tue, 5 Jul 2022 23:47:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next 0/3] Fix few compiler warnings in selftests and
 libbpf
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220705224818.4026623-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220705224818.4026623-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39fe3598-beb2-452f-a9ff-08da5f1b5e5d
X-MS-TrafficTypeDiagnostic: CH2PR15MB3719:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DuFl4vwr8a2cRs+HNLvf9J401FIf5f9os09oFYPQxUiGDvwsgq3II4iWh7tnPWdiKYf4dX6+a6e3fWIOQINBGqkgTQ57xp7Ve7NI1FSMWgLaqsidqNuBhkP4k0sts4Sx8nCNLAjvpvDKoQcx3pcDdAGqMEs5Rhdc7YqPl2LrSh9gmZkr1Wv+v863fskxoto3H6BB/JZ7KH99auu4AmG9yrk6pcCXACQkCUz0a0NYXUIEePgYqHapxGOsasT1Xb9ElJNiZ04FCq9oMgM2NFgVGtFclGt9Wpef7BtTulkoE14dyVl+okZNhFHb8ADv3mEyVl6zzmqO+2FYiB5xTOrm/BhPhLASsjEJ2o5oRuZzWek8mBtDq9evvz2VmgW3LxcSqTy7M+sUs76owEULB6663DOWKQSN0d6G6ukTy0CaBWKv8Pp7lXGUNT9IVAEYPnmVNUefwalWHHQ/daw8Aapb05249wJ2U0sroH4UXVgifVzGybwSoAtbiLUnpDdPK3mCIRWQh7dWtLFHpRM3jyafLw/3FeUAdidTvRmNiyf0fT5f3cbC7JZCE/8i2NotlMts5iHw6qYDzBMvtzTlQIE3V4Lgw81mJugaVUayMXToC0eYeZ3eL30hCtq9mPKhMTuT60Yctyw6IcJdWbUeq80nb3vNWkrkJQVMifjHVLEoTePXrM6lGE3ignrzoQNugFOqaqLaTo9qhGgHMuNDFRP+Nzc1oZ01cITKZfLcpdykU8+ZeIIl0b8axaxsw9XrC26yICJlfLEcT2CVPUYGMLijZo4IyPDHHMg2U7CWDF9k6vCY8/pytkDlBC2L8ltLuVfPGB2N4ff6ll+RuM5Lf5dSrS2Y7ZNAmctDvKoQGZoH6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(31696002)(86362001)(36756003)(6512007)(38100700002)(8936002)(2616005)(186003)(83380400001)(53546011)(6506007)(41300700001)(6486002)(8676002)(66946007)(66476007)(4326008)(316002)(478600001)(66556008)(2906002)(5660300002)(4744005)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZlcURZSXVzZ0gxU0lMYWUwNklhS1hFZjdTRjgzcFY5eEtVODZVVjN0Z0hE?=
 =?utf-8?B?aWxqdXpUaStmM1cwczdXbDAwMkEzbWFUUGNmK3Q1UXZUWENqOGx1bGthSld3?=
 =?utf-8?B?bHg0bjFVOVU4Y3dkRDErVUFSOUNNLzV4QzJkaGtoanZxdmhaWDduQ2JpcjF2?=
 =?utf-8?B?Z1lBUTFvckRuREY4ZXR6c0JQMmpzdmpoUVQwYmV4SHNXcktxYlY3ZzhnRzRJ?=
 =?utf-8?B?REdqN1lQWlFXRzJPTVB3dXpDdDU4eERDMVMzMjBDMnBXWi9qWlZvTlgvZWJY?=
 =?utf-8?B?a0lDdFZvalQ1ZkdGaFMweXFFVTRhQW9zN1ZXN1lXNWVrUmlpbG4vMGUvSjBh?=
 =?utf-8?B?QU1EN3dWYzJHTFpReFVObXdYTUZHRktKdzQyaXI0bzdBMjNjN3M5dEdhL3gx?=
 =?utf-8?B?ajl2STBaQmNpTEZmN0h3VkhadnVsenFjN3JvVm93ZTFoa3V1bE9CTldxR0hU?=
 =?utf-8?B?a3B0Z0N2ZHdYbVNzUVlpNUpSZnJ0Q0J6em1hZGRqTVhETDZBQ3BWRVRvUnAy?=
 =?utf-8?B?VTZtM3dRaHNNQVZqSlZMbVRDMWlZZVdJYTBsWSs3SVdCZU1vLzF0N2NDOXpz?=
 =?utf-8?B?YXBaelN2ZGhqRjJTRFVTNGEvRFB3eng4UHBMSTlnTC9jSGU5VVBZZUZ1QkI0?=
 =?utf-8?B?TnNEb000RWhSVUR5UC9Nd0VMWUdobGtRb2MyMktTa1VIcEZ4Z3lBVWtTWVh6?=
 =?utf-8?B?bUVCRHdzckdQc3psU2QrZGNqZEVSWWtrWWdKc0hBWjRVSEh2Ni9sQkRyWkhZ?=
 =?utf-8?B?bERWK2l4OVAvL1VJZTd5Vnc0S2o4Q0hKNU5IWTZDZ2l1Rmt4SlFrMnZWMk5h?=
 =?utf-8?B?UTExYWNwUDd0SURaL2t6dmFmMVErY3BmUkthWVRyWjZEYmJjaXJDWTJBeEhC?=
 =?utf-8?B?eW4zU2hCOVkxZzdDR0dqZWpPendhVkd0R0poWUVYQTAwUWwxNVNvMzhLcW5x?=
 =?utf-8?B?cTNoeUtOYjlmK0gwelJ2M3gwMGRnalVFWVRDeE9Wa3VyWmd1QUVnTTFqc1hm?=
 =?utf-8?B?U2JSUE1adThudmxCMUlDNHh5VXA3WkMwZzI3ZGM3d09oZUxHOGhnV2ZLekZF?=
 =?utf-8?B?OFlYWlBaS25RcHNjNzJ4U0N1ckdrd2NOaVhHNVdHeDRLVFc2SEFScmpvbkpS?=
 =?utf-8?B?dkpGbGtUaUJoY0xYeHhkU25FMTUxdDJYd3N2K214aFhvaW8yVXBtdHFsRWF4?=
 =?utf-8?B?Ym0weHZMdEpPcEkrTHJ4TFpSYjgrNnE1cDVadnFNK3ZDeDRCempzMHZYK0FR?=
 =?utf-8?B?YlVYYXZINFBhTHpQTkdRTHlaamJLbjVnWXpxNFNGVE5lN252VTlwcXhxNVZW?=
 =?utf-8?B?L1FMU3orMXRnTWlLTjVZdEZYUWs2OXVKajRpTU9TY3J3Mzl2MzlnbHZYUWpr?=
 =?utf-8?B?QnZBdUlYK0Z1a2REU1lVczVTYTJvNHlnQVBybzF3bHRjdnBVdFZ4UEx6THhm?=
 =?utf-8?B?bGU0SWdWdExoV2s5QkNhNDI1RjkwQUdzc2ZmL2hTZW1jMHVMNFFkODcyWGJn?=
 =?utf-8?B?cnk5c0Y5MU9YajVURTZsMDFSbWNvUjFKUkRPR3JKbFpQak8rQzFEb1hJNElu?=
 =?utf-8?B?cTlmU0ZybWsvdHJ4RDFZT0ZDNlFXenN5Z2R1SXQ2b1liY01rQ3ltNmsrZmFl?=
 =?utf-8?B?YmRaN3RPQUFpanZSbndRVnM0SE5FSDh2QXljOTFhZkVQZHhYeVlEa2JxcEZn?=
 =?utf-8?B?RzY0eEU4N3ZRNlVTaE5ydzZBcmZRWHVXZlppL3k1ZWhsalVndHpiRXF2Ykhq?=
 =?utf-8?B?SE5EakhVNEZFZnBXQWh6dnJvaUJFV0ovNEpXZjQwdlRoYWFFaHRMRUFKRzdN?=
 =?utf-8?B?cnMwRUprcDgvWGV0WnZuNXVvU0Nwdlg4bXB3eU9pdWJtQXVyclhHdlFlTnhV?=
 =?utf-8?B?UzErbE90Qmwxamx1V0JLaWFhclR0VEQxOWR6NGpuMUtCcWN3Ti9IK2xHK3RP?=
 =?utf-8?B?Sm5xYWZnd0dOKzk4TE42WkVnMlRFbXkyM2k2V3lFclRvZXRWejMwSzMrVXFH?=
 =?utf-8?B?dS9udmxXam9ETytuUjdCMDAvRjIrV0FseWdhZ3dQNU5mdHhqSDhCek1EMlpZ?=
 =?utf-8?B?NVNseDZsU01lSU5Ba3lvTWh2bm1RTXpiOGt1MFJjWG80TWlZYnVEMmx3eGpa?=
 =?utf-8?B?bzFTRnYrbFF5UERGQnNmM29UMkV3Mm1DVWF5QjM4ZzY1aEJpdHRoZ2Jrb3ZF?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fe3598-beb2-452f-a9ff-08da5f1b5e5d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:47:17.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OkvOrwzFnh5y7XUbW9ak8Y41UNVBqfzUIXc+N5wKjlydjYN7DU8vYEZJk0lJgUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3719
X-Proofpoint-ORIG-GUID: yZcrPKEBGfRs8ydRlW_-7K5jsyL83Irs
X-Proofpoint-GUID: yZcrPKEBGfRs8ydRlW_-7K5jsyL83Irs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_03,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/5/22 3:48 PM, Andrii Nakryiko wrote:
> Few small patches fixing compiler warning issues detected by Coverity or by
> building selftests in -O2 mode.
> 
> Andrii Nakryiko (3):
>    selftests/bpf: fix bogus uninitialized variable warning
>    selftests/bpf: fix few more compiler warnings
>    libbpf: remove unnecessary usdt_rel_ip assignments
> 
>   tools/lib/bpf/usdt.c                                       | 6 ++----
>   tools/testing/selftests/bpf/network_helpers.c              | 2 +-
>   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 ++--
>   tools/testing/selftests/bpf/prog_tests/usdt.c              | 2 +-
>   tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c      | 2 +-
>   5 files changed, 7 insertions(+), 9 deletions(-)
> 
Ack for the whole series:

Acked-by: Yonghong Song <yhs@fb.com>
