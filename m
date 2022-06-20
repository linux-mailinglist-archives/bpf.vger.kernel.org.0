Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3C5524D2
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 21:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiFTTtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiFTTtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 15:49:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612121B79E
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 12:49:49 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25KJ00KK029576;
        Mon, 20 Jun 2022 12:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=V7DstFxI3eu28juSMrGPA0uXl8ddJoPYCYemxF0vegE=;
 b=lFL9fnqiSBRl/m49tKD18E9B+Rm9wvMo58Y9EtBesfHB56CQ3AQHS+SHXQYcHWNm+h8e
 dZCcS59RyRVd5kbqxQf3TrPMK4EnBYedONusvHOwk6gi1LlXrh1+Tl7HFAomXnV0YDYB
 jaCT+okOVhZdQ+VWmWN2SuOxtJ2HDGjdg1E= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gsa78ke7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 12:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9nenbjoA2eyLIK1JVXGJQKTM1xjzSzjOLLcSsHRVRULh5TuzSZK8KJnO4EhwIF36LW0gQBTLNTE7YeTWhe/GEq1CoqwC2gNx5wCL0nqv3V/zsmNiL4Tfvu67Qff8mqK50kyg0b0TcZjHSXQ122CdjNpRHj1hhRazhvmKyzhmFy9abyaqlL70oAS8mkY9SlD6mRqhiIYWCcyLPZmkeIXfH19R6F+S0aEe7CtwaJpq/DYeeiExFUGGbYC6IYgGCnfprfpRazvR3bTelUcSBlK9SQa1afwfI/mrTOklSvFclmKa9g2CAnG6PeMyKzgFYbOgjlRue31f79Ig+zgl07D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7DstFxI3eu28juSMrGPA0uXl8ddJoPYCYemxF0vegE=;
 b=Cq4U9qHUnCfq6vpw4CHqLfNRQTCrdyOgseG0xKe3dz0fYeH3eyDjCcaOOYdjSTfRoVrTInZRs5y/jVT19MrnhL0Bmdelq/DERj+xwl9lTJLrdOw93c5KxBdXe/WW29ktbFLp0orWyGcAo+/PdzoNOJ5GXVbnBgKF2BJH8Rr21EL8joMFnpoLQa9f30bur0U7mOLQuOjD6sCUVZyrOAidxFvkUeGxJ36U5w47UI6uPRTV+FFpxraNjbHrW148HoTF1LXBJ896PQdKmWdZNaH1QdGoGjjun58r7SeVIzczC6biOlJLDNNzlppKTyJJGnk85ceNMDmN96Mbca/+1YiWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MW4PR15MB4746.namprd15.prod.outlook.com (2603:10b6:303:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 19:49:33 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::2197:2f04:3527:d764%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 19:49:33 +0000
Message-ID: <eb3c6419-c412-2c36-d3ab-1259999325c5@fb.com>
Date:   Mon, 20 Jun 2022 15:49:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
 <20220608230226.jywist5cdgu3ntss@kafai-mbp>
 <79b4e95c-437d-45c5-c7a8-c077f692c18a@fb.com>
 <CAADnVQJ+q6gmSt6E7YmhrdbNbW53tAwC3JKHEF1ts7VBU=x5GQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAADnVQJ+q6gmSt6E7YmhrdbNbW53tAwC3JKHEF1ts7VBU=x5GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79fc8fe7-262a-491b-d1d6-08da52f5ff3f
X-MS-TrafficTypeDiagnostic: MW4PR15MB4746:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4746463FB86954A463495412A0B09@MW4PR15MB4746.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Npd+9DuHvjhszUvpLeyMG++Z0TmwrI28BOIIFB+GD95plwWpLqmvzCh2zEImFiERngPiRvzNiyybq7QTIFBhC49aqjB7w0Wd1Z6axGIKCuJWuYChaG5c4jRPc3u4HFxHptLkQRowQImL3D5eyHqIxc8xTXp7EY4nQol6AcZd2QwVKgqdCUQCxhwmXDsxB32JBCinsZv1wBWW6Pzp2ZDOYmOZidUfT7Ee678xIFLn+IRCbtJMjn7NljMOxkM7HZKcLfNePi+BagklGsxO8WlvAfwc8ceV8+k6rpT3Lr9DAuKUNGn+L6pO2PvyF8GqFrRFBviX+2OoP2KlaH5yYisHN4HQPrKRybWcIKPiFx1kDapQMCkUB50YysiNPkdppCag+dOdEAa1hLYdFdKWrenfZY6CUSilfXTiYuanwSxgfztQQgZXLEud5Oe+YwhhOEYhbeD883W3JKCzrYxrJ9ddvTLJbcRqiba7A3iXwzXYpxek9d5dCHXP0MSYAAjbzT4LvHSp+qG3jQED11/O24lqWe66tQe1XdDbpOGkPM3vyBLsaPa69eooJqukbCVStNPXhAumPJK3TIrc9iAsL1fY61aPpWRh86CUfOTx+F8Cp2mHDbKu+vQbRsFj8aVK6xJmsJfxLUfNQtmCrfZMSirpZFRHxIIC/z7509gWhkT5stulATbjQM4+5GCtannqb1X9Zoq+WTwW3afQm4SiMh7w1qJQtUW5PjumhrbNW1dXvvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(31686004)(36756003)(83380400001)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(5660300002)(86362001)(6506007)(2906002)(6512007)(186003)(31696002)(38100700002)(53546011)(2616005)(6486002)(41300700001)(478600001)(6916009)(54906003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNLUVo2ckwvZzYvTi9mVFpjMk9wa0ZXQVNLbERVVU5UbHZvVExmVzMrQmVU?=
 =?utf-8?B?V3AvRnhtTVMycUdHR2tmWjhXaysvWlpORWR0WW9RM090RG1KbjNPMGdqRG50?=
 =?utf-8?B?R0RCY2hQRFpXV0syZTRPcmpwc2EzNnZzd3Y2V244R2E4QUtoT1pUenQvanUx?=
 =?utf-8?B?bnBVSlVUZGJ5c1FIS2dMRmRzeGJFQkMxV1B6b3ArbkdMS0E5bDJ6QVBoc0hm?=
 =?utf-8?B?bFBTcjhTbHRHeXpsOGpwYnNIYUw2dG0xZTdnYmhNK1QxQ096YlhWbjNpUm5F?=
 =?utf-8?B?bk9lMFNQb0ppQlZqcm1SSlRmdlRRUTBINUJoUEpadktkN1UxODViS3l4M2s3?=
 =?utf-8?B?c05IbTNCV2p2NHVjeUd3OEhJY3d3NFNHSlJSRC9qSFB6OGtiejV1enp3QVBE?=
 =?utf-8?B?czJVN2YzY1lOQms5b0JnaGxNYjZjU3A2aWdkNEQxN0QvckhHSnI0MmJDejBU?=
 =?utf-8?B?bER5b2dJbEl2Rkd0V3JKa2JSZVRXTVBnN0xybnNiMkQxK0VIZjdrMTJYYVo0?=
 =?utf-8?B?ZTRtMmF2RFE4cWpIeUtFTVlXZkg5bU9VSU53RkJ3WE1OaHh1TFAyNXlqYlVG?=
 =?utf-8?B?a2RjcjJmUGNWOC82TTRDdWNuK0FubUErMzluVTU5NkZHRWVoalg3QUJLQ1pH?=
 =?utf-8?B?Rk1sazFvUjZ4VHJTNE9jREtmRnlRQVFuM0k5ZDBVY0xqZXN4c1dQNytGclU1?=
 =?utf-8?B?Sk9pQTVNY3VtQnAvVVZoRnZSNTdDTi9Bc1dKV3NkV1o1aE9hc0xRWXJLb3pE?=
 =?utf-8?B?VkhQWTFYK21PcDZKR2FYeUo1Z0VSRmN5RE1XZFhJM3RYdlhPTG5hUE9mRjU5?=
 =?utf-8?B?NE9FQ1ZUNkpBRHBsaUo0aXVCdmZPQ0habGNOekdZQnExR1pBUXVHNUJlL1R3?=
 =?utf-8?B?akRhOXo4MzBxNWh4emhrSU9wOWtOR2k5VVd4VkxrVGorM2lnRzRaam1vOEJm?=
 =?utf-8?B?aFB0MmRyNTEzcm9sUmc2SVBhdVBSVjQ3U2YyMVBlbjU5VUJQeWY2ZzRHVEpU?=
 =?utf-8?B?RXRzZ3hTTFU4d2tpQVcvS28zOTdqcysxVlphTkdRVDJSRjBlMlJrUXlQKzcy?=
 =?utf-8?B?MHJrbUxZSEFkYUQwa2VjcThXcm9XWGZHVGFtQmxBTEZuTU5RVUltMDQ1WWlB?=
 =?utf-8?B?dVNPclhLbmN0Z1M1bGpEQWVSd0hqNlJ1Q2lGbzJ4NTlyM09XVXVQMnlLKzJK?=
 =?utf-8?B?UXBtcThCUXdpSGl2aGErU0d4T0ZFTWl5RHJ0bXZNQnorN09iL29TSEEzZmt6?=
 =?utf-8?B?TGxZMmFvaG1SenNZVFlhRkZxd1R4NG5LclJxenlkRDQ1NkRsdldrODFxZVdK?=
 =?utf-8?B?bmUwSUxtV1QybTRGak9UTVZjSWVrdm9oMFhNSkl5U3lRZmZmbjVkYnZCUjdi?=
 =?utf-8?B?eGNacy90bnFxMnM4cXhBN2dXMi9nSDFMQW1JRVNaVjBMZXNJS29FVklYWEh2?=
 =?utf-8?B?NHgwUWN1TVJDV1JmQ1RtVndHQVY1dUxQbFZEbW1tQ1NOeFI0UUV0WXpMWDNS?=
 =?utf-8?B?S3RNc0xSV3B3N2YySzR3R3B6aXFSZUc5MlRBZE5pR1VmSnAzaEhsZ0tMUHYr?=
 =?utf-8?B?UU9SckE2alNSeGgxS2Fscm4yUXVUeXg4SEdqYzRZdWdQMTlhd0VQTzFqRnFv?=
 =?utf-8?B?dUxOWEk5aVlvd3o2S3VVVTJzU2dSRWNSNm9pQ1RCM21SMk9qMDFtOTRjK29U?=
 =?utf-8?B?d3JGejIvZytBUVBHOG4zMmRoajFrbjRabm9yQzRLOGZCTW1WeFJvbzZ3MHZy?=
 =?utf-8?B?SU9sZG5oVzJNVElpanhFcEdSSFQ1R0JkR3NCYzIyMjFSc0xtQWtHMVg1SFNI?=
 =?utf-8?B?VUVuM0xtdVhZZVFyRHJIR3ArVzl0YnUwRldQU2NCYktFRG1ZQkZ0cWFLZ3h3?=
 =?utf-8?B?a2ZNaGwzWUthMEVYeVo4NzJyRmZaWHBxRWlRTGVsN1Juby9rMFZwejJPYU1E?=
 =?utf-8?B?OXd1WmwxRFZ0aVlZYVh1OTgwNitJOERjWlJOWlVTSE85d2xSNGEyaGd3bG4z?=
 =?utf-8?B?OFA4TVpxWXhjU1dCcEJJOWoxdHFNbU1sV0VrbEwxS0VKdEVpQ0UzVGo1YytT?=
 =?utf-8?B?WTFuRXUrSFFhVXc5ZHZmU0lCT29URVhYTkhJOUNHUEwrMStiV1hJYm5MaVg0?=
 =?utf-8?B?QjNHZlhrM3lMcDM4MWsrU21VcnM4dFRpVEY2N0dUKzFYMnZ0NFZMMEpPdmt6?=
 =?utf-8?B?N0V6R1NQNDRGQXpwYUlHMmU1YmNUMmh2aDJPNks5QklIVE9hZU5uT2t2bkpr?=
 =?utf-8?B?SGcrNG1IeDRSUUNuQXFBNEtvYkJ6UjRad1BqejZ0M2w0NjRmbnZjUndPbHFK?=
 =?utf-8?B?MFFPUURmRmFLVWU5ZXRpTktQRWY0RzhwbzVxcnlGWVpmeG1IZHdSMXlBeHBJ?=
 =?utf-8?Q?8/2R+d42IZimOmLV/qpwSoPMP3tFr+ZDywoBe?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fc8fe7-262a-491b-d1d6-08da52f5ff3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 19:49:33.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXKhjs303FpmrTRrbDvS2Ca0dJsQfyOOY55bc+fUDDmjL4gmoMG5kyg00jY1UxC2SPW0NU6HmNC3pzlCkrPcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4746
X-Proofpoint-GUID: K-g3U6o9JkQvqhNnAB-bap9f8xVSJrqg
X-Proofpoint-ORIG-GUID: K-g3U6o9JkQvqhNnAB-bap9f8xVSJrqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
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

On 6/9/22 11:49 AM, Alexei Starovoitov wrote:   
> On Thu, Jun 9, 2022 at 7:27 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>> +
>>>> +    if (use_hashmap) {
>>>> +            idx = bpf_get_prandom_u32() % hashmap_num_keys;
>>>> +            bpf_map_lookup_elem(inner_map, &idx);
>>> Is the hashmap populated ?
>>>
>>
>> Nope. Do you expect this to make a difference? Will try when confirming key /
>> val size above.
> 
> Martin brought up an important point.
> The map should be populated.
> If the map is empty lookup_nulls_elem_raw() will select a bucket,
> it will be empty and it will return NULL.
> Whereas the more accurates apples to apples comparison
> would be to find a task in a map, since bpf_task_storage_get(,F_CREATE);
> will certainly find it.
> Then if (l->hash == hash && !memcmp ... will be triggered.
> When we're counting nsecs that should be noticeable.

Prepopulating the hashmap before running the benchmark does indeed have a
significant effect (2-3x slower):

Hashmap Control
===============
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 21.193 ± 0.479 M ops/s, hits latency: 47.185 ns/op, important_hits throughput: 21.193 ± 0.479 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 13.515 ± 0.321 M ops/s, hits latency: 73.992 ns/op, important_hits throughput: 13.515 ± 0.321 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 6.087 ± 0.085 M ops/s, hits latency: 164.294 ns/op, important_hits throughput: 6.087 ± 0.085 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 3.860 ± 0.617 M ops/s, hits latency: 259.067 ns/op, important_hits throughput: 3.860 ± 0.617 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 1.918 ± 0.017 M ops/s, hits latency: 521.286 ns/op, important_hits throughput: 1.918 ± 0.017 M ops/s


vs empty hashmap's


Hashmap Control
===============
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 33.748 ± 0.700 M ops/s, hits latency: 29.631 ns/op, important_hits throughput: 33.748 ± 0.700 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 29.997 ± 0.953 M ops/s, hits latency: 33.337 ns/op, important_hits throughput: 29.997 ± 0.953 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 22.828 ± 1.114 M ops/s, hits latency: 43.805 ns/op, important_hits throughput: 22.828 ± 1.114 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 17.595 ± 0.225 M ops/s, hits latency: 56.834 ns/op, important_hits throughput: 17.595 ± 0.225 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 7.098 ± 0.757 M ops/s, hits latency: 140.878 ns/op, important_hits throughput: 7.098 ± 0.757 M ops/s


Bumping key size to u64 + 64 chars (72 byte total), without prepopulating the
hashmap, results in significant increase as well:


Hashmap Control
===============
        num keys: 10
hashmap (control) sequential    get:  hits throughput: 16.613 ± 0.693 M ops/s, hits latency: 60.193 ns/op, important_hits throughput: 16.613 ± 0.693 M ops/s

        num keys: 1000
hashmap (control) sequential    get:  hits throughput: 17.053 ± 0.137 M ops/s, hits latency: 58.640 ns/op, important_hits throughput: 17.053 ± 0.137 M ops/s

        num keys: 10000
hashmap (control) sequential    get:  hits throughput: 15.088 ± 0.131 M ops/s, hits latency: 66.276 ns/op, important_hits throughput: 15.088 ± 0.131 M ops/s

        num keys: 100000
hashmap (control) sequential    get:  hits throughput: 12.357 ± 0.050 M ops/s, hits latency: 80.928 ns/op, important_hits throughput: 12.357 ± 0.050 M ops/s

        num keys: 4194304
hashmap (control) sequential    get:  hits throughput: 5.627 ± 0.266 M ops/s, hits latency: 177.725 ns/op, important_hits throughput: 5.627 ± 0.266 M ops/s


Whereas bumping value size w/o prepopulating results in no significant
change from baseline.


I will send a v6 with prepopulated hashmap.

