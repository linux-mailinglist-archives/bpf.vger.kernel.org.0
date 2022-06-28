Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120AB55D9F3
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiF1GTb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 02:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245249AbiF1GT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 02:19:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC236120B0;
        Mon, 27 Jun 2022 23:19:27 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25RJ1QiO018674;
        Mon, 27 Jun 2022 23:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1Q+bzOPeKCVn2q6Px/P4vefyfpsaRFsYDaU856yqzaU=;
 b=H84UuDjlTgdPTo/I4Qbz0rflZ8ypNKnPLh6YZ8xVhtXzMsAjakHHTdMbV0/XsrrDqyiT
 JycKSm6zywVArRaUTo6wH1cMJMUI0ZGiKIHkJKpjofo++Y33iWaOH0ZdIvROb0kd4fKA
 NXAZ86MImf+4l4CRtBm0Z8DiyqH72bIs12o= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gwx1v7ybs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 23:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsvkv+tcA+h5EBrcusp5pMSY/sC/6nRDLATmuBDUoaHp8P5/jMboUrg012eNRj8O9RRpsV+wX43Zw4IkAfrLGVTG+TU+Q4xv93GnHuCz9TB68ubLE7l9C5GWza58nLiqoSljF6BfmrS+/9yD3Lo7ZS7W/GLkMpRvin83A28QdV0MniJCp7FJNxFASdIaYE4cHkFcAirj1qiZ6ZNkGHeqHgPitqbIEQgdVCGu0G2wC59sFKTdnhFZTU08EGAB6zfDyZG1ntX3iu83wVqBH7SnOdEzmdsguIylUaWNvJONsUnDaDgd/zmY2+kM4Oxpzwl0O4Gd0e3v9KBik/yUoRXg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q+bzOPeKCVn2q6Px/P4vefyfpsaRFsYDaU856yqzaU=;
 b=kayMdfdOqE+tC+wI4Xf68mQr1ARuKoJB5SQnHOeKZ36tU+JrbEZm549cXd0naWUtndjdV4xEVIOmTc61RtA0+K1Sdmq25kVEBykUb+p45MfZY52NFR+6AT3R3xyd1xoB3my1ZVJbC1TzyBQg02bbHMUCgMCOOuvYU00A43R2T9teyhAC0+rbbtv34MCULtacx9SZE7QKIVcIPnXZ+GHMscneBdn16XOqFf4NqzLbTb1exm48q38DJlTCOA+5M6lAsXRtjCc74DcphZ4kYsA9Pr/MTsBxiR04lB0+NlV6Ip8UxZPaHxqoVFROdPTgtsRXzDuhi/oeuBb+PPPCJ2VfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3695.namprd15.prod.outlook.com (2603:10b6:208:1bf::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 06:19:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 06:19:11 +0000
Message-ID: <db3d6c00-4536-de9d-1da4-0c99c102067d@fb.com>
Date:   Mon, 27 Jun 2022 23:19:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH dwarves v2 2/2] btf: Support BTF_KIND_ENUM64
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220615230306.851750-1-yhs@fb.com>
 <20220615230317.852304-1-yhs@fb.com>
 <CAEf4BzayE3nEdft-=nhxSAxkq_F1N0o0AdbFU0m=MKSsF+pZ4w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzayE3nEdft-=nhxSAxkq_F1N0o0AdbFU0m=MKSsF+pZ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ef6143f-e69b-46c8-9960-08da58ce1dae
X-MS-TrafficTypeDiagnostic: MN2PR15MB3695:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT7gubKgQRtjhAD196tMfEkvF+oHINpoOMgdxUut6vpp53WS0GhjESknbFhIkj5d1jYOXrti1iz2U7t1aRVmKRlZNNr6icX1xMNPBAC7rBKgI+BakDOcEk5RhG9MkL4SKJxRcsFNkkFNBNxKie+SgnTeTsM9w8E4gY2/8XnWa9secC0dFdZPR48Ada0iaGriT9sArUYnEy7A2FoQZKmO6ZDO49d0Eoi5tW6rWwGKsWuQwK/y0zE9iaLLv5DUYGY67SN5Ub5M5I6/BY3XjaMevKiapkHDVXKtm9jd0ULm8MIexdhypybhqyLxmLQrrjhukNXQL/swjb9+kl28XClT2jlS/EyCb/gdMAXV3gdtBsFzD2iR/2F7f+5b9QdhtBeIau4CFNXknL3257E8SDAQv6w+t3E2yfETWcoGSv34i8SjWj8mVgKYj7P98P/YpN2st+Q+8ODcy423iHNG/hr8p1w0KigvFtCmSZSTVGIlz7LRw40206m76gd3gC3wLlIdAAPfdWHhWwLYU6+8wIdRgGthV7VYD9WqoB4aHFe03tD3EMeu/fISu7Re1ESpU52LFw0iEa2bCcsyvwGYSITEftIkGVdx4apubjmqA88rhjEb5mnZ69syJLa7N8lVNJmuIEj5nEUKFeLPvt6ryXndllXM6ngi6FUJQIn7GTwGUQCBr/dqmZ276XNtpKRU44w7IDJz0X15GQNfxGNTQehnXebQyUJKnc9YcHTKur0NWsSBQ7CtVTGkhqv88wNlqJ7pgSKe1DY8hLMxNKhSngNN0e5Oe1oEj780m4wKI6/We1bIniiHn6WWLpD4UcAetjebVjwMvqCFkJVi6txzAvaSztIkeR8PWtXaw+rwsrGLUf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(31696002)(478600001)(8936002)(86362001)(41300700001)(5660300002)(6486002)(6512007)(53546011)(2616005)(2906002)(186003)(66556008)(66476007)(4326008)(66946007)(8676002)(6506007)(38100700002)(36756003)(316002)(54906003)(6916009)(83380400001)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJoRkpnOGNPUGx0MDYvSTJ5QVBRSHcwTWVkWG90eGNpdHB0U1hnU2dGb1pq?=
 =?utf-8?B?QXJ4WWc2Y3pPdnFaVDZ5ekJIenlIOExPY2pDeHBsYlRDQUVrNGNCWnpkeEQ1?=
 =?utf-8?B?ZUNhY2MvYUtOcEliUExJU0piR2dLa2hVdDIwRlFaSVhmVDZ5N0RMNlFtUHln?=
 =?utf-8?B?bFdnWXMvVmFUMmVvQkdtWURtY0diVWVaU3Z1NGtuWFpIdDRZWStZZHNUVE1o?=
 =?utf-8?B?bTVPbjlWTkhXbTU0WGdTRWhHc2dpbVYzeXpocXFmdXhxbWMyT3kwZDhXNDR2?=
 =?utf-8?B?NG5teVJJRElGc2RzMHFvdDUwLzVjYmdyNS8vcmVNQ0hxakR5RHFpVzVqVmhy?=
 =?utf-8?B?TzBHWHB0ek5hSlorS0xkbi9lTkIyK2dMbnNTWGFvandjSmZnTndVajRIZDhU?=
 =?utf-8?B?eDc5M0NzS3I4RXlTZS9Ja0ljNUtORk5GdmpjVWphQWdEbUMyd29BS25sV3ZQ?=
 =?utf-8?B?RWxRYnB3UEJnVXVaaFlZbUtOUE9nSlJ1dUZ2M0EvUW5kSndzUVFEUjhzQklv?=
 =?utf-8?B?TDFmZXZWVjV5RWhJNjhRaXhQWjRFZmQ5Y2RQL285MUxCL2U3azN2R1hveWU1?=
 =?utf-8?B?bFVpV1p3eUlkblloRHpKa01OUk1GWjdiZEEzQWFlVTh1QUVJaUluUkxUNjNr?=
 =?utf-8?B?dnRVOXdYMC9aZC81UlJ5ZnRzdlZNODZ0ejhLUXJLL0NFTGF0MlpZUUFQVjV0?=
 =?utf-8?B?dWdPUXduWEtxZldBUkFwRTZ2MXFjZkhVMDF4eGNPM3J5MGM0Tll6TmlaZXFJ?=
 =?utf-8?B?L1FRRXoxVHVxZmFtTzlMNGFFck80dEp3bUN1amI5UUFOK2o5a29aNU1NdlJr?=
 =?utf-8?B?ZHBWQ3h0dUZEMTJSQldYVTYvOTdGQTVmYU5iWUZ3a09XUUtRL0VXY2RlU0xo?=
 =?utf-8?B?NVk1S0tSNUNZNXZQeUs5NzRuQnpmdGhaTTByWld0UjhYN1FaMUd1U0VCcExP?=
 =?utf-8?B?SERmVXdjMkhLTlNGUGVVY0FyS0RlQU93a3ZTOVdwbUJzd1ZCajhldFZhTGFK?=
 =?utf-8?B?Y3JxRjQxamUydEQ4ZjV5SVdKMFY1WjZ0VlR1SXBaK0RWOHpaYjlJeWJlYVdt?=
 =?utf-8?B?cnJuYVQ2MHczNEVVUmpobXdaODIzaGlNNHFTWGwzNDU3Um13eDhDWllBR1Q0?=
 =?utf-8?B?Ti8rb1hpMjQ3dFZqVVZUaFloVFdZSFhxeUM5U0puSnR5UXlNM0ZIcTNrMXcy?=
 =?utf-8?B?K2JuU0tSZnBhR2N6b0dZRTNxc09YNE4zc0J3OWREd2NnSUVoR1ZRczFBTlF4?=
 =?utf-8?B?VHZLejJYV2Z1RjMzMGZ1Q3V5dmo1ZCtCZENaN3FNbGdFNjE3dTVodlVhSU45?=
 =?utf-8?B?RlVGQlBWcXdYY3hOUVFYRGxMSnQ3WG9RMUgrck92b2FNc0dVajFhbW43Wm0z?=
 =?utf-8?B?dFV1aXltaXhTRjE4S2pwbmQyY20wNXJvaXJsTDdJNmpvdC8vRFdkanFLZEpS?=
 =?utf-8?B?T2p1bTdWa1dMY2NLNUR5dlRPRHZhV0xBK1k5UDRZR04xeGcvYnZFekRmL3l6?=
 =?utf-8?B?WXZQaHpoZzNXdlhiRitidmlkUHJWS2IxYk1OWmtMZ1h3eWVWV3pRV09majRR?=
 =?utf-8?B?N25RL3VacG5hVW91NUtibEp1TW9HRzFSL0V2RHk1R0ZoaXlVSDZ5VldBRCtL?=
 =?utf-8?B?MDVSaWpMUzRrK3p4RGRMVVNFNkwvV3pZQjdWM0U5ZG1HNlJ1Y2tRSXNjM05U?=
 =?utf-8?B?QnVwTGpJRHFld0s4eUx0bDZxM3FKa1pUeFNFT3V3VUI4TllnY3VweXYvTGlB?=
 =?utf-8?B?Qm5rekJEeStORTdqc3JKT1dlWlFHbEhvaVVILzNhdXBQZG9lZzYrRnBvZkhV?=
 =?utf-8?B?bHFiUDNZSkVTOGtQcXE3Y0ZxekUxTFNTTnpVUzVVaVpTSkRlVGpoRkM1c0Nw?=
 =?utf-8?B?bklDTFJHRlFFSnJFNXBZeXdkaE8yUS9XenRSOGRnYlJ3MHVTM3U2anlWcDNz?=
 =?utf-8?B?bDVCQjZleEpZZmgzQWpMK0JhQU5NaGxXV05RSGhId085eE1DUTBCb2VQUGJH?=
 =?utf-8?B?UzhqNDMySmZMcm4rZVR5cmVaMlQ2YWRXcmloVWdHa21VeTI0TmNVakxXRXQ4?=
 =?utf-8?B?bG4razRRNXdTSDNmRUd6UVRjN21GbDNCTkJRWkxvRkhQWmd0U0pTLy9tT3Fx?=
 =?utf-8?B?QkRpaU1YTEMwc05hVUlKT3BYUjRRc0FvMzByQlVlTkZRLzlxc2tjdVdNNGNm?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef6143f-e69b-46c8-9960-08da58ce1dae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 06:19:11.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvoJaLJCPIL8Jllc8Ba+I3M6Nx8F5gPLIjY/uBogWz5GKFAN3Bohqm6qNdebpNiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3695
X-Proofpoint-ORIG-GUID: -I8qKDkhnPi0Qevr0SuhszJun6uu0BBn
X-Proofpoint-GUID: -I8qKDkhnPi0Qevr0SuhszJun6uu0BBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_09,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/27/22 3:30 PM, Andrii Nakryiko wrote:
> On Wed, Jun 15, 2022 at 4:03 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> BTF_KIND_ENUM64 is supported with latest libbpf, which
>> supports 64-bit enum values. Latest libbpf also supports
>> signedness for enum values. Add enum64 support in
>> dwarf-to-btf conversion.
>>
>> The following is an example of new encoding which covers
>> signed/unsigned enum64/enum variations.
>>
>>    $cat t.c
>>    enum { /* signed, enum64 */
>>      A = -1,
>>      B = 0xffffffff,
>>    } g1;
>>    enum { /* unsigned, enum64 */
>>      C = 1,
>>      D = 0xfffffffff,
>>    } g2;
>>    enum { /* signed, enum */
>>      E = -1,
>>      F = 0xfffffff,
>>    } g3;
>>    enum { /* unsigned, enum */
>>      G = 1,
>>      H = 0xfffffff,
>>    } g4;
>>    $ clang -g -c t.c
>>    $ pahole -JV t.o
>>    btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>>    Found 0 per-CPU variables!
>>    File t.o:
>>    [1] ENUM64 (anon) size=8
>>            A val=-1
>>            B val=4294967295
>>    [2] INT long size=8 nr_bits=64 encoding=SIGNED
>>    [3] ENUM64 (anon) size=8
>>            C val=1
>>            D val=68719476735
>>    [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>>    [5] ENUM (anon) size=4
>>            E val=-1
>>            F val=268435455
>>    [6] INT int size=4 nr_bits=32 encoding=SIGNED
>>    [7] ENUM (anon) size=4
>>            G val=1
>>            H val=268435455
>>    [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
>>
>> With the flag to skip enum64 encoding,
>>
>>    $ pahole -JV t.o --skip_encoding_btf_enum64
>>    btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>>    Found 0 per-CPU variables!
>>    File t.o:
>>    [1] ENUM (anon) size=8
>>          A val=4294967295
>>          B val=4294967295
>>    [2] INT long size=8 nr_bits=64 encoding=SIGNED
>>    [3] ENUM (anon) size=8
>>          C val=1
>>          D val=4294967295
>>    [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>>    [5] ENUM (anon) size=4
>>          E val=4294967295
>>          F val=268435455
>>    [6] INT int size=4 nr_bits=32 encoding=SIGNED
>>    [7] ENUM (anon) size=4
>>          G val=1
>>          H val=268435455
>>    [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
>>
>> In the above btf encoding without enum64, all enum types
>> with the same type size as the corresponding enum64. All these
>> enum types have unsigned type (kflag = 0) which is required
>> before kernel enum64 support.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
>>   btf_encoder.h     |  2 +-
>>   dwarf_loader.c    | 12 +++++++++
>>   dwarves.h         |  4 ++-
>>   dwarves_fprintf.c |  6 ++++-
>>   pahole.c          | 10 +++++++-
>>   6 files changed, 79 insertions(+), 20 deletions(-)
>>
> 
> Sorry for late review, I don't always catch up on emails from older
> emails first :(
> 
> [...]
> 
>>          size = BITS_ROUNDUP_BYTES(bit_size);
>> -       id = btf__add_enum(btf, name, size);
>> +       is_enum32 = size <= 4 || no_enum64;
>> +       if (is_enum32)
>> +               id = btf__add_enum(btf, name, size);
>> +       else
>> +               id = btf__add_enum64(btf, name, size, is_signed);
>>          if (id > 0) {
>>                  t = btf__type_by_id(btf, id);
>>                  btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
>>          } else {
>> -               btf__log_err(btf, BTF_KIND_ENUM, name, true,
>> +               btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true,
>>                                "size=%u Error emitting BTF type", size);
>>          }
>>          return id;
>>   }
>>
>> -static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int32_t value)
>> +static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int64_t value,
>> +                                    bool is_signed, bool is_enum64, bool no_enum64)
> 
> It was quite confusing to see "is_enum64" and "no_enum64" as arguments
> to the same function :)
> 
> I'll let Arnaldo decide for himself, but I think it would be cleaner
> to pass such configuration switches as fields in struct btf_encoder
> itself and just check such flags from relevant btf_encoder__add_xxx()
> functions. Such flags are global by nature, so it seems fitting.

This will require an additional struct definition. It should work but I 
will wait for Arnaldo's comments as well.

> 
> But other than that looks good to me.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   {
>> -       int err = btf__add_enum_value(encoder->btf, name, value);
>> +       const char *fmt_str;
>> +       int err;
>> +
>> +       /* If enum64 is not allowed, generate enum32 with unsigned int value. In enum64-supported
>> +        * libbpf library, btf__add_enum_value() will set the kflag (sign bit) in common_type
>> +        * if the value is negative.
>> +        */
>> +       if (no_enum64)
>> +               err = btf__add_enum_value(encoder->btf, name, (uint32_t)value);
>> +       else if (is_enum64)
>> +               err = btf__add_enum64_value(encoder->btf, name, value);
>> +       else
>> +               err = btf__add_enum_value(encoder->btf, name, value);
> 
> [...]
