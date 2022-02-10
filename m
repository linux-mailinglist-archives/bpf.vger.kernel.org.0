Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403234B19DB
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiBJXzS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:55:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiBJXzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:55:17 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DF5F5C
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:55:16 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrPYw004423;
        Thu, 10 Feb 2022 15:55:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oRv5GVB6LgrvqlGs4vY4Io5XqeLN3yk4lfWkwg9rvPU=;
 b=jbN6ONHFNW+DiKECP3bDtxGWoO5Qp/HgKRUGOpL98chXFkTQwf2eaOyyNSamKpvn7zrf
 bunZhSaBFom7jmYA9sThlWSYyqVkmRqVVhHfYtpayBs60PwR73N3W/crqLtD1pI4c0aT
 qfSTSA768wJx0e6nr4CcHybYmLdso9r4S3s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58y9skb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 15:55:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:55:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+O3U7m4VwktEhJtV9yIiiPVlR54bRtX3jUf9pWtQQJ84I/x93c5NM+8ZHvykGpYifxPZ6Lu5ov58TqL2yYBUXkoILelFYtQqMW50jWfENJ1iw84aKg/uV3a6KmW9RipkpjedY17ECPaVzhaqFf2jR4TyKfbXBVaF0dpnvEwD6f/qb7UQNIdqZ9ZPanhEYcKP61PXEXiDwrwRY6/Ud2JT2NflSGSyBvfottFh9+vEPmSf8tdI3+OuVfuSiTWlLylsW0GzsrGrFzTjLucleBL8G3AC66I2Aj5gaeyvodBLL4gfKGX3me0jo+XEpbRue3DYHEKcC2rdcvFI7qGOS3C9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRv5GVB6LgrvqlGs4vY4Io5XqeLN3yk4lfWkwg9rvPU=;
 b=IpsC8BWEHZflGVvXilGDJSo/bQydgtZ5jpq6DmrtgSh154iHvtRV3n/mF61gbqlgToXT8YnPW4b57OL6GhBjeqbgG5gq/RNsGhzoMculoGs11Q85zM67GLtZQExUk8lo34B58rszJcO051AA+Wq5WkpXhC5oQtjs1A07Gh9yKnrSBk7JEODQ6jdPI8eHNFkZTBaQLWcWjdzAnk+QrbGSb1vUuuJcbdBzSi7TXtu4XVvKKJ6TsD3J2KEeilB7h2i8vpSNOnrKCegaZYu3KfC28XZ+FyxEvb2o5u11gG4YHOFeuaNoKQlwfkkeqziBzNFZrxWfjpMg5W9Zm6rrZi3tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2925.namprd15.prod.outlook.com (2603:10b6:208:f5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 23:54:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 23:54:59 +0000
Message-ID: <e7b471b5-e93c-d9ed-bc36-970b73df6643@fb.com>
Date:   Thu, 10 Feb 2022 15:54:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-2-memxor@gmail.com>
 <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
 <20220209195254.mmugfdxarlrry7ok@apollo.legion>
 <e74b1aa6-7aa6-d814-5dbf-209506e00553@fb.com>
 <CAADnVQLUrz=Hwp-3e9k5RMSiD+a_nhZVHjWzR4cneZ4naQqrEQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQLUrz=Hwp-3e9k5RMSiD+a_nhZVHjWzR4cneZ4naQqrEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c7bc842-81b6-439a-5fd0-08d9ecf0bf1e
X-MS-TrafficTypeDiagnostic: MN2PR15MB2925:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2925351578ACB62155A08681D32F9@MN2PR15MB2925.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8md31OAcjpULcZ/hznp4pDAYM9MfPcuNVIrLzJecKyp4x4eFULTQAZ7aVXbgDLBTnP5gC1ISW/RVQ6YdN9Yq+YaJXIqrIzfeWPFg9bNSRkdbrpl31an1QG5eXPm2okgcQJabbehAIn7tkq0THPOpYWEGZh9e0F0DqR0hgM+siLmJbY6JaqJyDhAH3EPrwz07yxjvPcup/M1X1YU+/vjXBRM2pNfaWOaMQxI01ACWiAnJYeWObHLvCycinynSiIqzbcznyuksUxM/GDUFIZo/H1F54aWZ7z+Kw9SmeEO3n/oC2lOsWYtDuRKDSCnIwUSborxmREaz04fsaGHigBmwhQkx1lf9oUdnge//VJATJ5ntUdeIIdlguYMBnB3qw87HsCzR8mnHUWHmVKZWN8J301wCvBJdSAmUxWsQa+rTk8onK7O4CgqZC/gGSHDrxJeT9+9ZwJWwoMLtNcCeI8rzrAdnT75lgZhQgLUw1ODq/T9P7XB505D2CsIFyO7jE8jdfaWhj2vqyIwy+hQ680kTpyLLyua2QTn6J8t0EcSrJxatxONJKjnrhxmaCMAGYoy68SiJt7fQZj/b0s/j3Bz+JBO9BkaOa8xZb+g3s8S7o52Fljao/YaO/dP+RLUqL63tQfCmIbdqpu/ahfYww1FlARRIuGmYFtyo8cDebnnlVgt3XlG7AhK2lPhWQ3IwnEIU3HgVnZTF0nZ3ENPAGBhcIvVUs9ocKVKdsO2uGzkEbp1xIbpVf7jInY04XdfXcW/B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(2616005)(52116002)(53546011)(31696002)(6506007)(6512007)(6666004)(6486002)(83380400001)(86362001)(66556008)(5660300002)(66946007)(6916009)(66476007)(8676002)(38100700002)(54906003)(2906002)(36756003)(316002)(4326008)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBMS2UxS0FqNjAxeHJMVG9JL2NoS1VVeDFUeHNjVXhncUpBRVVUY1V4bXNY?=
 =?utf-8?B?cDRUeXdVc0h1ZlU1Z29VTHhXcDJzOUhjbDZnQWliak9oU0YyRnh3bElHWUpC?=
 =?utf-8?B?c25RY0xpRXZ6MXRpSGpVS0JDSlg0cXJ6TGxXU1ZYVmlOQmtKSzh2M21FQm5D?=
 =?utf-8?B?YU43ZFgzZTZJdzkyczBsc2NnZkduR3Voalo5Um1pM3RBQUNHZ0hQY2s5cDVQ?=
 =?utf-8?B?eUp0SWREVVpkY3lUbUR4NGVhMVNwcVJmL2EwUnQvVmU4SXFlMW1iWldQb2Mx?=
 =?utf-8?B?Vzcva2NMZitCZEZPNnZ3Uk51NVphM0FnSnhRcXpOYUFkZkQ4VFRKTm5TTkZh?=
 =?utf-8?B?V2phcWhuenNadjJkeGFUVlBSNUtIOWdCTW80Mk90S1h3T052QkFqVUxzdXJY?=
 =?utf-8?B?Q1liVnZsYzl5b3ZxN1hyaUlhLy9UM3Q4QUllU1FkQVBMd1pTMy8zWGZlMUE1?=
 =?utf-8?B?WHZ1WTByRkFVK2RlOGFmb2xNb294VW05UERvWm5kb05RUTcralk3R0cyRVVt?=
 =?utf-8?B?S3JxV1k5NmsyOTg4WWpZOEdvZzV3MVZSdUlJNTVJSlNpY0RzUUFSNndXVVhk?=
 =?utf-8?B?aE5YSzNzMnFzYXhYVkZWdFkxNlpHZEtSOWFKYTkwS3dPMnV1bVlEYWxuQTNM?=
 =?utf-8?B?SGM3ZklsS2tNcHV4L3EvWFg1ZkdiQjlLZFZkenliUE5kdDBoRytoVlFIbUty?=
 =?utf-8?B?VGVQdmUzQnZJanhvdkNqeXpwODFNaXY5ZHlScjREcnpBdGdIK0IrL1RSWGZo?=
 =?utf-8?B?bFp0M2RoczRBVVVoRXlQT0JhZUd4aEpOWHVLMlhZeGJEeDRUZ3BWWGhodDJr?=
 =?utf-8?B?MDQxS1NXaFpiTmduSzJyUU1vaXNQVjhJWnU5c21sTFp2ZE9uN1RzUWRwU3RG?=
 =?utf-8?B?M3NNbTdsSEJGdzhyMWVleVVvWmZyN3ZHdVZ0ekZSVS9keXEwcXBmandObUFn?=
 =?utf-8?B?dDFaZDFsbXpLRUhGS3VUZFY3RUMxRTdoTFE1dzR1UG81M2YxQUU3VU8wdVZX?=
 =?utf-8?B?RXcyNUJjaXVSRzU0QkR3QzRZRlQ2amdWakdia2wxeTN6VFJweENPTWN3SXEy?=
 =?utf-8?B?Z0lCdWUyM1ZGdmY4ZEswV2xKb2ZQWm5FWDFRRkN4NUw1KzJ0TmRyL0tFZEJN?=
 =?utf-8?B?REtZbVM4VkxoN3IxR1ovMisyU1hVWHlWakpRWXQzZTdlWHhjMFQreG1BV1hF?=
 =?utf-8?B?QXQwWk1TQVRVQnVwOXA1aVhrcERKWnFtV2NxMEk2cEJla3BLWGoweUNZWjgw?=
 =?utf-8?B?d005bkpmdE9wTmRqRUxkRjZJWjNJV2pPS2ZZbXRDMVdBbHF2T0dGV3hTT2lt?=
 =?utf-8?B?VkJEdFd2c3B0bmkvSnJrTHRJOFNqZFhCOFFDUFJBUTBXbEkxYllwQzZ5ZFJW?=
 =?utf-8?B?Q3NRVHpDeVZWTlNyb3lkdHpySU91N200ek5zMFFaUnNCU2ZGbnVBME9GUWd0?=
 =?utf-8?B?T3F1KytKNUFLWXViT2ZpSkNnQXJPQWV5R0xhL3pFWEowZ00rZ2ZFeGQ3TGtJ?=
 =?utf-8?B?YzFsV09jZFh2MzI3QmJDSlNTaWw1T0o4KzcvUWR0dUROVW1RTG53NXZ1S2o2?=
 =?utf-8?B?TmlZTjRhbS91Q0JYYWpMSkJZTWRJL21qMWxxQnZ2VnA3eTFtbVIwcUdZK0c0?=
 =?utf-8?B?Ui9FS1JocmRGNFVXYVVlam9WWmNRNGZ1ZTZhQnhBRnpvNkExK2ViRWE3OXhH?=
 =?utf-8?B?TXFsVHZQKzdRUGVJSTJJQ0phdU9tbTBrVVEzQm1ZcFZ2cjg4SHNkWUZteTVS?=
 =?utf-8?B?d1RBTUNlYXM2MURzSWduSWZRUGVObStqeHc0VTgrOG01NVNzM0JGNnM0Ry9F?=
 =?utf-8?B?MGh2VCt2dFFVV0NOMUd4blVFRGhTSjNSY3ZMc2Z0UVRMdCtOWXZDY2dpK0hG?=
 =?utf-8?B?V3BRRk1wWnMyN2RoWitHYXFhNmp5Vkt5Y1ptZzFKaUxTRUNQMHpnNlVucjZh?=
 =?utf-8?B?bnRCTWQ4V2dBampNN0xneHBjbkd3TVNGY3hWU1hJQjRnVDk1SFRGaXpVcDdM?=
 =?utf-8?B?SUdIM3dQT0t2M0pzd0lWTzc4U1FtK0lvcjBJSERLamhtNDhwS282bFZuOXpv?=
 =?utf-8?B?QzR0eCsrcExzY2NWK2Q3cURFMVNEYzZuM1M0djFKemwzVlJDSGdaaVdlLzN6?=
 =?utf-8?B?SFpMWndGU29wVTcrQmxTbXpMR2JWUUlqV2FsbHMxQ2luODE3SnI5dWIvYW1p?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7bc842-81b6-439a-5fd0-08d9ecf0bf1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 23:54:59.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA220xARqhOBetQ2BxFqVUbfNgKD07GPAZRi0G2zJnmF+5K1uAmvKbyxdftcHEgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2925
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fg16cmjX23iHhGlY_sUUK5YpvdzE4NrI
X-Proofpoint-ORIG-GUID: fg16cmjX23iHhGlY_sUUK5YpvdzE4NrI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=960 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100123
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/10/22 2:49 PM, Alexei Starovoitov wrote:
> On Thu, Feb 10, 2022 at 12:05 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>> On 2/9/22 11:52 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Thu, Feb 10, 2022 at 12:36:08AM IST, Yonghong Song wrote:
>>>>
>>>>
>>>> On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
>>>>> When both bpf_spin_lock and bpf_timer are present in a BPF map value,
>>>>> copy_map_value needs to skirt both objects when copying a value into and
>>>>> out of the map. However, the current code does not set both s_off and
>>>>> t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
>>>>> is placed in map value with bpf_timer, as bpf_map_update_elem call will
>>>>> be able to overwrite the other timer object.
>>>>>
>>>>> When the issue is not fixed, an overwriting can produce the following
>>>>> splat:
>>>>>
>>>>> [root@(none) bpf]# ./test_progs -t timer_crash
>>>>> [   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
>>>>> [   16.037849] ==================================================================
>>>>> [   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>> [   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
>>>>> [   16.039399]
>>>>> [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
>>>>> [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
>>>>> [   16.040485] Call Trace:
>>>>> [   16.040645]  <TASK>
>>>>> [   16.040805]  dump_stack_lvl+0x59/0x73
>>>>> [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>> [   16.041427]  kasan_report.cold+0x116/0x11b
>>>>> [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>> [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>> [   16.042328]  ? memcpy+0x39/0x60
>>>>> [   16.042552]  ? pv_hash+0xd0/0xd0
>>>>> [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
>>>>> [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
>>>>> [   16.043366]  ? bpf_get_current_comm+0x50/0x50
>>>>> [   16.043608]  ? jhash+0x11a/0x270
>>>>> [   16.043848]  bpf_timer_cancel+0x34/0xe0
>>>>> [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
>>>>> [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
>>>>> [   16.044836]  __x64_sys_nanosleep+0x5/0x140
>>>>> [   16.045119]  do_syscall_64+0x59/0x80
>>>>> [   16.045377]  ? lock_is_held_type+0xe4/0x140
>>>>> [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
>>>>> [   16.046001]  ? mark_held_locks+0x24/0x90
>>>>> [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
>>>>> [   16.046569]  ? asm_exc_page_fault+0x8/0x30
>>>>> [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
>>>>> [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [   16.047405] RIP: 0033:0x7f9e4831718d
>>>>> [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
>>>>> [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
>>>>> [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
>>>>> [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
>>>>> [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
>>>>> [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
>>>>> [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>>> [   16.051608]  </TASK>
>>>>> [   16.051762] ==================================================================
>>>>>
>>>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>>>> ---
>>>>>     include/linux/bpf.h | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>>> index fa517ae604ad..31a83449808b 100644
>>>>> --- a/include/linux/bpf.h
>>>>> +++ b/include/linux/bpf.h
>>>>> @@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>>>>>      if (unlikely(map_value_has_spin_lock(map))) {
>>>>>              s_off = map->spin_lock_off;
>>>>>              s_sz = sizeof(struct bpf_spin_lock);
>>>>> -   } else if (unlikely(map_value_has_timer(map))) {
>>>>> +   }
>>>>> +   if (unlikely(map_value_has_timer(map))) {
>>>>>              t_off = map->timer_off;
>>>>>              t_sz = sizeof(struct bpf_timer);
>>>>>      }
>>>>
>>>> Thanks for the patch. I think we have a bigger problem here with the patch.
>>>> It actually exposed a few kernel bugs. If you run current selftests, esp.
>>>> ./test_progs -j which is what I tried, you will observe
>>>> various testing failures. The reason is due to we preserved the timer or
>>>> spin lock information incorrectly for a map value.
>>>>
>>>> For example, the selftest #179 (timer) will fail with this patch and
>>>> the following change can fix it.
>>>>
>>>
>>> I actually only saw the same failures (on bpf/master) as in CI, and it seems
>>> they are there even when I do a run without my patch (related to uprobes). The
>>> bpftool patch PR in GitHub also has the same error, so I'm guessing it is
>>> unrelated to this. I also didn't see any difference when running on bpf-next.
>>>
>>> As far as others are concerned, I didn't see the failure for timer test, or any
>>> other ones, for me all timer tests pass properly after applying it. It could be
>>> that my test VM is not triggering it, because it may depend on the runtime
>>> system/memory values, etc.
>>>
>>> Can you share what error you see? Does it crash or does it just fail?
>>
>> For test #179 (timer), most time I saw a hung. But I also see
>> the oops in bpf_timer_set_callback().
>>
>>>
>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>> index d29af9988f37..3336d76cc5a6 100644
>>>> --- a/kernel/bpf/hashtab.c
>>>> +++ b/kernel/bpf/hashtab.c
>>>> @@ -961,10 +961,11 @@ static struct htab_elem *alloc_htab_elem(struct
>>>> bpf_htab *htab, void *key,
>>>>                           l_new = ERR_PTR(-ENOMEM);
>>>>                           goto dec_count;
>>>>                   }
>>>> -               check_and_init_map_value(&htab->map,
>>>> -                                        l_new->key + round_up(key_size,
>>>> 8));
>>>>           }
>>>>
>>>> +       check_and_init_map_value(&htab->map,
>>>> +                                l_new->key + round_up(key_size, 8));
>>>> +
>>>
>>> Makes sense, but trying to understand why it would fail:
>>> So this is needed because the reused element from per-CPU region might have
>>> garbage in the bpf_spin_lock/bpf_timer fields? But I think atleast for timer
>>> case, we reset timer->timer to NULL in bpf_timer_cancel_and_free.
>>>
>>> Earlier copy_map_value further below in this code would also overwrite the timer
>>> part (which usually may be zero), but that would also not happen anymore.
>>
>> That is correct. The preallocated hash tables have a free list. Look
>> like when an element is put into a free list, its value is not reset.
> 
> I don't follow. How do you think it can happen?
> htab_delete/update are calling free_htab_elem()
> which calls check_and_free_timer().
> For pre-alloc htab_update calls check_and_free_timer() directly.
> There should be never a case when timer is active in the free list.

The issue is not a timer active in the free list. It is the timer value
is not reset to 0 in the free list.
For example,
  1. value->timer... is set properly (non zero)
  2. value is deleted through update or delete, value->timer
     is cancelled and freed, and the hash_elem is put into
     free list. But the hash_elem value->timer is not zero.
  3. one hash_elem is picked up from the free list,
     and proper value is copied to the value except value->timer
     and value->spinlock (if they exist). This happens with this patch.
  4. some later kernel functions may see value->timer is set and
     do something bad ...
