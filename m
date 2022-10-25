Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977760D504
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 21:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJYTyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYTyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 15:54:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9791F107CCF
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 12:54:18 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjj3A001666;
        Tue, 25 Oct 2022 12:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=DAlFjQUdDN/V19k9UbQnm2F+qavTNSP5nCECQheTTIs=;
 b=KQY78+NWF3XA6Fkbw5ldpM+WDLODddBZLMG8m/tZ9qW2MZ/eYe5e58uonGQdhFFFXjie
 zGVuneQj48tJSxML4kAXuEk8aeu1BjfGdVdHAxRy+EnX5cA+h3if2k2W5Xea7yyf+xyp
 HOLbKMCW9Q3sm7vvzBwSsId91kRYTyhVK1HnuuSXQmyUfGHKyMIbEHQiEzTGYbJFhsT5
 MB8WOBTEALv0rgqOh2BcVZg6bOJJ0+s7ltD243/Bm/nWEcYaoHmCYMyEz3YEszqho4oy
 TNVkxuC2/xHeEDttlGHWIuH/h6getPEGHOOxRK4bkjw+emp/7ickhk8pomPsqJ3jNNHE /A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke747hft7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 12:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/FpqXO9E8UxLh7U8ZrF3iElF9l9P2OJA2mLj+wl+82i7KY0SD74q6vrXhntSRufZWxNcp988JmUgNlox4yDYRw132JNqnZrTCdCGC5XHwYEPIclwPVl+NoNpNSej0mXoYoh5UJS6tTM8GwYUxeOWs6MoViq7lnjbFXi8o18iC/fHUixZQPp+va5aeScoDVFgi1fAfIFLOBXsC1VHonsuNAxQS8m/aA3PGChnD98X4vQ47PaPh4e2ihuLOgp6jfjnaOyrQr3+7cLJshLJglWj9adl7pSsFTiIJ7aZb/MmE9UwCPAjzMk8ltVmXPVapumvSV7SMGVVSHhdggusg1y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAlFjQUdDN/V19k9UbQnm2F+qavTNSP5nCECQheTTIs=;
 b=DhfIVicQBpQEhMGWyikoiVlDTdCxqAF30G3Jj6AcolQrj7crhAZdNnJ7bu5FQdimncbe7pwRUrkl6isLWV1o2GkTVDGbY5h+Ay0gFF1TWNodIpGMpXVFQPFNUF/jih6lbuzoMSX6Ac76FWnh1GYw9PtBXVvKk8/FlrZZG+64paqbwYQh/rkPffXXldCPL7j807IhkbyfOoNfKJlonsXjJRbwDRzw8EV4/BEGukRNxXgC7tmrdzxXYswEM6O3amNyrE9CUuqMQbAdRF/ifJGDJ+hVN7zTEp4Zkakbz5Kusk1L46RKF3CT1c5oH2KZV3srypRD02oeiDTkPSF+6rVAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4161.namprd15.prod.outlook.com (2603:10b6:5:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 19:53:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 19:53:57 +0000
Message-ID: <5fc082a3-1aff-edd6-ca50-e9d99ea99743@meta.com>
Date:   Tue, 25 Oct 2022 12:53:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180530.2860453-1-yhs@fb.com>
 <dba4c448-ae08-f665-8723-c83c4d2fb98f@linux.dev>
 <CAJD7tkafC5BPqUxUWc3UUrphe0wKaRe=HfLvkyPk09+EV8ndCw@mail.gmail.com>
 <5dd7b50f-3179-75c2-4125-ee872f225129@linux.dev>
 <CAJD7tkY_HgX_Lr9j-OfPRWkg0hSGooATLCs589k5UiX9t5k97Q@mail.gmail.com>
 <f136c13e-5386-ea21-69af-d48127c75752@linux.dev>
 <CAJD7tkb-tvLbJm2-Zq4YKFZ37ZW==sbHTHOxtdeSzQpDcTcTtw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkb-tvLbJm2-Zq4YKFZ37ZW==sbHTHOxtdeSzQpDcTcTtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a006692-733d-42a7-2c1d-08dab6c2a73d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ7IUjXCtgVIlA5ugPbEChduOGjgqMRV17yP2c97QQDLP1Z+FL0s9oV7TNu+fxpS7FLVfVcx5/hEr9vDpOrtKAuh8+nRqj3/SQwIc6rrOMLQcmEImQVSYYc9HpAyd84S32d/kzzG3neK8xM4VwMK0Fwqj3x5djivk5bt6enhsBhH6LSJvz01rEYTTgnQwTz4zCg73HzB+et7vWZbGIIW3PL9qTKwCMm4FXH6FJoYPkBgQ9Mmr2ZqEM5Ih5wJ9sSgBAyIuFmtrT7MLbyt5AsrgopH9+Olv8EWrWVDfR9uaiLoIDfRej4ymuSA7OWOugAGzcbMbv107CNsqmP0Jki3WSMjy6VgKR4CzN0LARv+QLiV2z10Y6ZdeA/jhwGG599ze3TlaixXhJoqzjRZCVe1ci/lrq/uUcjaWMzvsa3uJFjnB1tjNf7KPaeu8c8cCVZhaz2Hq7IGA/qj5k/iqtyMU8WnQGjMMoOSP4kN+Rgu4KsobxU9fLK72fCprZ5iVT7Clc0Zd2ItjJhdnto2xsIFpCxBY4ZPi8UFRHrJV/pd8ySV6XzN6XfF6h8lzR8UwOguOvSJvCoOiGt2Hf1A8p/RO8b6JrItEFTrgzGaHI0oiVbzDG3CkrN7NFsZ2eQvxy769nrhVGf9/454Sr/BEokbrYM4Vc4PUc/D1/sHiUQFA9GGXKemyp56Ru5JYL5rAocFh/oJ7afqnD8y3/DrTYQ7pqsmJafeb84xMfuKQeamFemySuI8LVHsfkaSP2M340rBTcss/3yqfk4DrhH3vJMjmVf7cjdwDNS1ny/7GbgoyN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(6486002)(66899015)(86362001)(31696002)(83380400001)(31686004)(478600001)(8676002)(66946007)(53546011)(66476007)(6506007)(110136005)(66556008)(7416002)(54906003)(41300700001)(4326008)(36756003)(6512007)(8936002)(38100700002)(5660300002)(2616005)(2906002)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZlRzBMQUQ5c3FSL3ZBMlhDVzUvRTlTV1JxWFppVHAvcGZIRk9GNXdNUlpy?=
 =?utf-8?B?b2RiOEtUVUVPdTh3VWNyZ241UHB3SDFKeURmc0tSVVdyamc3Ni9nSGRFWUVC?=
 =?utf-8?B?MU1aNjlpQ3o5elBLRktsRU5qYW5RcHdvaThndzQwN2h6RThYUlhvVHdQQUZD?=
 =?utf-8?B?bUZsYnpYZFdLMnJGM083Y3lBUC8wOFNHK0E2empCaE5mUE1TR3RvSEc2Ykgz?=
 =?utf-8?B?Q1NqNTRpRS9IVFFiemlPc096VW5Wak4xbTllRVJPVXhtTjBLNWhxTkNteGgw?=
 =?utf-8?B?SUpsL0MyVy9KdmhLbXBGR1Zxa05SQUN2V05pczBCK0s3U3ZTaGhaaUxMRGdo?=
 =?utf-8?B?MzFFdWhSZ1hpRXFnSXkwMklhdHN3SG5pWHlEb2NIUUNpbWFMTjQ0aHNoSkI4?=
 =?utf-8?B?MGxlT2I5OEtHenZGZjVwbTc1SG9jS0t4d3d0Y29NM3ZxWXBzU0xPdHJvZDJS?=
 =?utf-8?B?VmRMNWVpMDNkVEtjazI4bVBreW93ZCtZSjR4ZDFXQUNnS2UvTjhFa1NENmhu?=
 =?utf-8?B?aHN3Z0hibXdtNEFyWHUvMmRjRW5QVGlMUzBDbUx6OTdGbUdQUktqaVpoYUlY?=
 =?utf-8?B?M1F0cmUxWTRzK1d3ak1uaGdwemVpeTNkdW93dmdiaS9XdjJxbEhnR1VmZlJB?=
 =?utf-8?B?Q1ZDQnE3WG81REZ4c2h2OXREZ1hWNFFGT25RaTlaZ2NqNnlrbkxCNkNDTlk4?=
 =?utf-8?B?VjdtdlBPZ21lRUFEQitIZUlyc1pOTU9yRCtHVEJpYmFwejFKSVVEMk0xZ1RG?=
 =?utf-8?B?VGxtNEY1VjFTRWlUZitjdU5nZ211YUJlZmFtS3JmTUk2cFNuT0xIK0ZiU01s?=
 =?utf-8?B?N0NCaGc3VFh0NWUrSmNQVFord1pEcUFhVXJaZll5SzlvUVN2UEs5ZkM4MC9I?=
 =?utf-8?B?em5DbUxKS1c0RGUxYTdEUmQ5RmpyZ3BiSXA2b3Q1dGdsMmxITWE5Y1R2RTZH?=
 =?utf-8?B?V2MwbGk5aGZvRm1HNEZCbkNPTTIycWNyZlhIVTkweFJpcTlqWXBKcngyblYy?=
 =?utf-8?B?ekd1TytubUdXUkN5Sk1hWFJuYm4yWHRtcnl6NGhMaDV3d01FbDAwZ1VyWm5R?=
 =?utf-8?B?dS9yR2xET2dxZzVqTytsTUNaZVJUeERtZnZjRm03Sy9yUjh3S283N2hvblU2?=
 =?utf-8?B?VC93MW5seXY0ODcvUjZRS3E0Mi9HVE5rbk93Z0FkMG51TDIyZWdYYmg4Uzdr?=
 =?utf-8?B?SHpiWVhzNnpoNmZQbFFwOXBmMjQyVHpBbDczS2lDVVN1QS9VcWgwRmczWC82?=
 =?utf-8?B?NzFsR2pJeXBBTHdrenIwcno2ME5DVUI0VFVpdi9aNVFUZmdpcGJBdDZMLzEy?=
 =?utf-8?B?VW1iUVlqTjh0L3g1WlljdUhhK1NYdkZvK0pId1VOaHpzblE2NUd4UmMzeVpl?=
 =?utf-8?B?OVBkQjFzWTdsaSt3V0NvUFkwUlUxekt4L2ZJbitmVDRoQjV1Mi9LZnhKOHA4?=
 =?utf-8?B?S3A0TmRSaGhqQTBnRUNvU2hBaDdKN21OZTMyeWFwek5sOVRPL2ZEWTBJRmZX?=
 =?utf-8?B?TnVpeHBvVnF1aXhhRmhGenZPRTM1M09QL1k4dGFRUHl2SEZtd05HM2xJVEd0?=
 =?utf-8?B?MVdWL1p2dDhDZWJrdDVaeHE2LzYrYlNBRktUaG9Zc2t4RjFpejVlcnAzbEZj?=
 =?utf-8?B?aE44ZDg4M01rR29VcDVYeDBtKzhGeHE5VmI2dFZqWC9RVGdVbnljaUtFbEtJ?=
 =?utf-8?B?bmpsQkYzN2hhL2xNM2RqUVBtU0cza3A1NWhPR29SdkNvRng4WUgzV3Q5clpi?=
 =?utf-8?B?THM4SSsyZFRzUXVzVGx3NFltRVk4RzdSVVQ1YWdIaVl0UTYzU0QrUVIwQkpo?=
 =?utf-8?B?TkNBUDh6cEpZTklNdnBuMStyV1dIRFpEZ2lqUW5GbVFVNGl1TXZpZzlXeE5T?=
 =?utf-8?B?bGg5eW03d1RTOXlXY1VFRnU4SDBqSHNGUVh0U24raDh6b3lhOVFyMnVSV0M4?=
 =?utf-8?B?VW5VWnlZenZKMjlJN3g3TFpjTktndThhb2wrNmRBN1J0TzNabC93aXlSZ0Ra?=
 =?utf-8?B?dy91QlJZOFc1YnRLc1ZaSCtzOFoza2dXamJzd2JRWGM0TjNZZzhwVXp0NklW?=
 =?utf-8?B?OTJyZHgzTGlQNnp1dEU1V3hmeVlZZjhQdlFtcjNxZHNqZndHVE9VMlZ3N3lK?=
 =?utf-8?B?Uk1BNGVaMTNOR1F4c2ZoNTEyNmtIMnVoWkJuSU1xY28wbUJidWxIY0ROZ3Jt?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a006692-733d-42a7-2c1d-08dab6c2a73d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 19:53:57.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrk0VpCf9wbmqPL2woxYDds1Tz3Kp0z6K1kTsV1jd/X605RTazw1Ue5OqPZ6Ue8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4161
X-Proofpoint-GUID: icO8HZ__FF3wIgjpRhjkrtCjIvx_ZS6b
X-Proofpoint-ORIG-GUID: icO8HZ__FF3wIgjpRhjkrtCjIvx_ZS6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_12,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/24/22 10:44 PM, Yosry Ahmed wrote:
> On Mon, Oct 24, 2022 at 6:36 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/24/22 5:48 PM, Yosry Ahmed wrote:
>>> On Mon, Oct 24, 2022 at 5:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 10/24/22 5:21 PM, Yosry Ahmed wrote:
>>>>> On Mon, Oct 24, 2022 at 2:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>>
>>>>>> On 10/23/22 11:05 AM, Yonghong Song wrote:
>>>>>>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
>>>>>>> +{
>>>>>>> +     struct bpf_local_storage *local_storage;
>>>>>>> +     struct bpf_local_storage_elem *selem;
>>>>>>> +     bool free_cgroup_storage = false;
>>>>>>> +     struct hlist_node *n;
>>>>>>> +     unsigned long flags;
>>>>>>> +
>>>>>>> +     rcu_read_lock();
>>>>>>> +     local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>>>>>>> +     if (!local_storage) {
>>>>>>> +             rcu_read_unlock();
>>>>>>> +             return;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     /* Neither the bpf_prog nor the bpf_map's syscall
>>>>>>> +      * could be modifying the local_storage->list now.
>>>>>>> +      * Thus, no elem can be added to or deleted from the
>>>>>>> +      * local_storage->list by the bpf_prog or by the bpf_map's syscall.
>>>>>>> +      *
>>>>>>> +      * It is racing with __bpf_local_storage_map_free() alone
>>>>>>> +      * when unlinking elem from the local_storage->list and
>>>>>>> +      * the map's bucket->list.
>>>>>>> +      */
>>>>>>> +     bpf_cgrp_storage_lock();
>>>>>>> +     raw_spin_lock_irqsave(&local_storage->lock, flags);
>>>>>>> +     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>>>>>>> +             bpf_selem_unlink_map(selem);
>>>>>>> +             /* If local_storage list has only one element, the
>>>>>>> +              * bpf_selem_unlink_storage_nolock() will return true.
>>>>>>> +              * Otherwise, it will return false. The current loop iteration
>>>>>>> +              * intends to remove all local storage. So the last iteration
>>>>>>> +              * of the loop will set the free_cgroup_storage to true.
>>>>>>> +              */
>>>>>>> +             free_cgroup_storage =
>>>>>>> +                     bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>>>>>> +     }
>>>>>>> +     raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>>>>>> +     bpf_cgrp_storage_unlock();
>>>>>>> +     rcu_read_unlock();
>>>>>>> +
>>>>>>> +     if (free_cgroup_storage)
>>>>>>> +             kfree_rcu(local_storage, rcu);
>>>>>>> +}
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> +/* *gfp_flags* is a hidden argument provided by the verifier */
>>>>>>> +BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
>>>>>>> +        void *, value, u64, flags, gfp_t, gfp_flags)
>>>>>>> +{
>>>>>>> +     struct bpf_local_storage_data *sdata;
>>>>>>> +
>>>>>>> +     WARN_ON_ONCE(!bpf_rcu_lock_held());
>>>>>>> +     if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>>>>>>> +             return (unsigned long)NULL;
>>>>>>> +
>>>>>>> +     if (!cgroup)
>>>>>>> +             return (unsigned long)NULL;
>>>>>>> +
>>>>>>> +     if (!bpf_cgrp_storage_trylock())
>>>>>>> +             return (unsigned long)NULL;
>>>>>>> +
>>>>>>> +     sdata = cgroup_storage_lookup(cgroup, map, true);
>>>>>>> +     if (sdata)
>>>>>>> +             goto unlock;
>>>>>>> +
>>>>>>> +     /* only allocate new storage, when the cgroup is refcounted */
>>>>>>> +     if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
>>>>>>> +         (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
>>>>>>> +             sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
>>>>>>> +                                              value, BPF_NOEXIST, gfp_flags);
>>>>>>> +
>>>>>>> +unlock:
>>>>>>> +     bpf_cgrp_storage_unlock();
>>>>>>> +     return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
>>>>>>> +}
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>>>>>> index 764bdd5fd8d1..32145d066a09 100644
>>>>>>> --- a/kernel/cgroup/cgroup.c
>>>>>>> +++ b/kernel/cgroup/cgroup.c
>>>>>>> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
>>>>>>>          struct cgroup_subsys *ss = css->ss;
>>>>>>>          struct cgroup *cgrp = css->cgroup;
>>>>>>>
>>>>>>> +#ifdef CONFIG_BPF_SYSCALL
>>>>>>> +     bpf_cgrp_storage_free(cgrp);
>>>>>>> +#endif
>>>>>>
>>>>>>
>>>>>> After revisiting comment 4bfc0bb2c60e, some of the commit message came to my mind:
>>>>>>
>>>>>> " ...... it blocks a possibility to implement
>>>>>>       the memcg-based memory accounting for bpf objects, because a circular
>>>>>>       reference dependency will occur. Charged memory pages are pinning the
>>>>>>       corresponding memory cgroup, and if the memory cgroup is pinning
>>>>>>       the attached bpf program, nothing will be ever released."
>>>>>>
>>>>>> Considering the bpf_map_kzalloc() is used in bpf_local_storage_map.c and it can
>>>>>> charge the memcg, I wonder if the cgrp_local_storage will have similar refcnt
>>>>>> loop issue here.
>>>>>>
>>>>>> If here is the right place to free the cgrp_local_storage() and enough to break
>>>>>> this refcnt loop, it will be useful to add some explanation and its
>>>>>> consideration in the commit message.
>>>>>>
>>>>>
>>>>> I think a similar refcount loop issue can happen here as well. IIUC,
>>>>> this function will only be run when the css is released after all
>>>>> references are dropped. So if memcg charging is enabled the cgroup
>>>>> will never be removed. This one might be trickier to handle though..
>>>>
>>>> How about removing all storage from cgrp->bpf_cgrp_storage in
>>>> cgroup_destroy_locked()?
>>>
>>> The problem here is that you lose information for cgroups that went
>>> offline but still exist in the kernel (i.e offline cgroups). The
>>> commit log 4bfc0bb2c60e mentions that such cgroups can have live
>>> sockets attached, so this might be a problem?
>>
>> Keeping the cgrp_storage around is useful for the cgroup-bpf prog that will be
>> called upon some sk events (eg ingress/egress).  The cgrp_storage cleanup could
>> be done in cgroup_bpf_release_fn() also such that it will wait till all sk is done.
>>
>>>  From a memory perspective, offline memcgs can still undergo memory operations like
>>> reclaim. If we are using BPF to collect cgroup statistics for memory
>>> reclaim, we can't do so for offline memcgs, which is not the end of
>>> the world, but the cgroup storages become slightly less powerful. We
>>> might also lose some data that we have already stored for such offline
>>> memcgs. Also BPF programs now need to handle the case where they have
>>> a valid cgroup pointer but they cannot retrieve a cgroup storage for
>>> it because it went offline.
>>
>> iiuc, the use case is to be able to use the cgrp_storage at some earlier stage
>> of the cgroup destruction.
> 
> Yes, exactly. The cgroup gets "offlined" when the user removes the
> directory, but is not actually freed until all references are dropped.
> An offline memcg can still undergo some operations.
> 
>> A noob question, I wonder if there is a cgroup that
>> it will never go away, the root cgrp?  Then the cgrp_storage cleanup could be
>> more selective and avoid cleaning up the cgrp storage charged to the root cgroup.
> 
> Yes, root cgrp doesn't go away, but I am not sure I understand how
> this fixes the problem.
> 
> In all cases, Roman confirmed my theory. BPF maps charges are now
> charged through objcg, not directly to memcgs, which means that when
> the cgroup is offline, those charges are moved to the parent. IIUC,
> this means there should not be a refcount loop. When the cgroup
> directory is removed and the cgroup is offlined, the memory charges of
> the cgrp_storage will move to the parent. The cgrp_storage will remain
> accessible until all refs to it are dropped and it is actually freed
> by css_free_rwork_fn(), at that point the cgrp_storage will be freed.
> 
> I just realized, I *think* the call to bpf_cgrp_storage_free(cgrp) is
> actually misplaced within css_free_rwork_fn(). Reading the code, it
> seems like css_free_rwork_fn() can be called in two cases:
> (a) We are freeing a css (cgroup_subsys_state), but not the cgroup
> itself (e.g. we are disabling a subsystem controller on a cgroup).
> (b) We are freeing the cgroup itself.
> 
> I think we want to free the cgrp_storage only in (b), which would
> correspond to the else statement (but before the nested if).
> Basically, something like this *I think*:
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 2319946715e0..f1e6058089f5 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5349,6 +5349,7 @@ static void css_free_rwork_fn(struct work_struct *work)
>                  atomic_dec(&cgrp->root->nr_cgrps);
>                  cgroup1_pidlist_destroy_all(cgrp);
>                  cancel_work_sync(&cgrp->release_agent_work);
> +               bpf_cgrp_storage_free(cgrp);
> 
>                  if (cgroup_parent(cgrp)) {
>                          /*
> 
> Tejun would know better, so please correct me if I am wrong.

Good suggestion. calling bpf_cgrp_storage_free() after
cancel_work_sync() seems a good idea to ensure all pending
works are done.

> 
> (FWIW I think it would be nicer if we have an empty stub for
> bpf_cgrp_storage_free() when !CONFIG_BPF_SYSCALL instead of the
> #ifdef, similar to cgroup_bpf_offline()).

Okay, let me give a try.


> 
>>
>>> We ideally want to be able to charge the memory to the cgroup without
>>> holding a ref to it, which is against the cgroup memory charging
>>> model.
>>
