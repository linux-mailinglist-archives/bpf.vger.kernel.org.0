Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF54B1F76
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 08:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiBKHmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 02:42:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBKHmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 02:42:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A161AF
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 23:42:15 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrcKT018579;
        Thu, 10 Feb 2022 23:42:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YsJqA4kXC/7JOpUaCTSEsIS/eDHFflDNkTRHJuC2u9o=;
 b=obyL2Pm58UcTBrCQ9p7Uen+GONtBlhIB9xsqtmTt6ZOQvRZu/91RRmO4RJKxihQxDH51
 jbL+bNVJjA00Gffkwus4zuaCpemvlnpShW2qAPb3+ObKx1mEKmYdT9xtCSOmRRUawbwy
 W5+s2ANdjTlv7mYS2DaSh8LOhKhxuisTvCo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e592ukk3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 23:42:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 23:42:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEVZk3mcSJ0jrl5H9w7IyawdKVso837RtibaKdcSRZ5YXxhuJbCTm9tAVUc34+HfXQQYoSdF66UOS7Vcr6TX6zceyxZjEk+DIrWzgkBQIvGFUGL+ICvvzOKCCrNyMLRAfsrPGhw22d+xw9DBpejWQQZWJT5nKXouxOZ/dyocdxg7dji5HYNUIvFLBUWaoGVkuPNpwHbwATQfGqkhnzEaMT8urIm+jOH6Lmq8LTC/oRVbQsLNt4VlXSzekdktyMLYI0vMo0fd2XMJrFyHgpSqi0uBjKCA9JgAqdjmcldFNX+2TeYATxKEpzx9Jm+xSwwZ7MWPbdms7U7qiUXi6ni9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsJqA4kXC/7JOpUaCTSEsIS/eDHFflDNkTRHJuC2u9o=;
 b=C/EoUbgBWAtjo+q7BNKVIOzvOYFv7Kwv484zx/1l3bsctyIm9Vbwzrt01RbI3m/ZNPjlDWsPPAQ41DTdcfXB+STiqtOcdPpUvOKjYuKxpJamSyXPVnXAjV0w4LV9LTMrjNMg9RwdyPu0X73wqO8II487du87ZJazE3z8DgJ1MbLHEPKihtqVTZXMCMafJa4syu2TZdKqFFIGyl3w094XpTFDCxX2T9ZXoACx+YtwMOESSjLGXSJZpyHNRhcn+OoUnjVKeW8JFavPZRw1uhrgW4Sm7V5ZCrX7kCP8I5QlARflVBO3i29pr7wh40j5PD0PjRfWmYLcSsmkQWnqdoql+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BYAPR15MB2599.namprd15.prod.outlook.com (2603:10b6:a03:15a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 07:41:59 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 07:41:59 +0000
Message-ID: <0f8f8dc4-5f7e-92f2-368f-6a465663aab1@fb.com>
Date:   Thu, 10 Feb 2022 23:41:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf 1/2] bpf: fix a bpf_timer initialization issue
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211073903.3455193-1-yhs@fb.com>
 <20220211073908.3455653-1-yhs@fb.com>
In-Reply-To: <20220211073908.3455653-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84f4711-454a-4368-5fba-08d9ed31fc35
X-MS-TrafficTypeDiagnostic: BYAPR15MB2599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB25991E4A0E5835273815C676D3309@BYAPR15MB2599.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7/5Y1n055vkBwmum5upkPSVFwzGFO3wjYV81eHDzd0FHBSH4SSrTnGOunxEQaoZeLZCao6PAkf7O7No1ZfXYnShJn+mvCv2iB9+87cZv2Ai2Y/a3dN/df6STLRqXgXMkidmepxNdSZb14skP/xqENNh93PjumhVGHVW1JWZSm9HhqegurLbNa8ZWkHz1qM5XshHfm2C+duJMGAShjsKj6BwklxMq/jNT1YjDISGZh/emBgFby/0GMkKB/PfFd1nTTB2RnDzMy2iFlaI7gDAvYn0fzORKd6bZ92mi7mVXA/uysl6gG4dZ34dSKG5Js7jDLapVmTcZsH5Sj0QZYwI7QS8sWQ137dBade6HNo3QqSgfxvxDLZZfrp8I2xtb65WWqH2mZ1f1VfVoCuwMGMcZYoDlHmW2Y39GISvObJUrRqo5Uael4Sv/ZplVJV04Z/PeAh0K1He9zRyC37H8zM46C33aJe5Y4i43RqbIN5+6aYULWczni29Xd2fvQZAjVgVVXM3tyCQV2VWmw+Gj/kwGwRtzekdTbn6fLBwG2ysiOoudRCZT6/Ro8hv6SdGTNVG5T8p9/fzO/1WY5Z2R0NBuPaJZcAXE0Zp0KRIRObO+kHiwMaTsdTmKaSxRFP+ygeBv29WyAuEgnnLdFjkp1D98QfutVywWgrgQrMGXVWUp8Td/9TtghEMKBgIFewpN0ybU8xBE8trzb+ZivkY8ZS8KUslC7AS4zXQncuVmLuurhnZnnizWN0ED03kQ5QZRFvnsD9mW0rYGid7IB+M/Ejh7StbI4cgV/tiCtq7U37qvA6cLSvavvph9Ly/s1bnwNV8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(31696002)(966005)(2616005)(38100700002)(508600001)(66476007)(66556008)(66946007)(316002)(8936002)(54906003)(86362001)(5660300002)(6506007)(31686004)(4326008)(2906002)(186003)(83380400001)(52116002)(6512007)(8676002)(6666004)(36756003)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3AvUkZTMDYwT1BUdmh5emY0VjdGVmVXck5BbG4wMFZkbVVhenF6blQ1VzZF?=
 =?utf-8?B?eFF4YThCbzBQMHFlMEwzK2VHemtyMHp1MGo5bi9yQmd0RTV2bFZaaGpEMElH?=
 =?utf-8?B?dzZ1Y1JjUFA2QjM1djR6TWk2eXVxR3NpWm9UaW5KOFFWQ2V2eW5iQWp5SGtF?=
 =?utf-8?B?VVdpUkVSd1JtQzlYTUtnbjE0eTAveUNvc0poczQ5WTBjbGllWDVlVmpDVlVC?=
 =?utf-8?B?czJxUms1U2xPZ3Z0THEwSFVYNE9mVU8rRUR0eEE1U09TZmJVNzZXUFdaU29G?=
 =?utf-8?B?V1RMK3lBNXZ3MWF0T3ZuaWJyZnRNRFE2UW1vY2haMVpXK0t0RlVjRS83cklq?=
 =?utf-8?B?VjNQWVd4RDNRZ2xIWWhIMlFiRHllL29mMSthK0ZPRE1SeDIrZ0NZeWtyMnQ1?=
 =?utf-8?B?ejE2OFdiZ1dadGdIdVB6dEphenV2Z056bUY3d0FPSXJTbW5PeGttYmlaTS9a?=
 =?utf-8?B?TW5zaSs5ViszalVDVzhSZk1Vb2ZUS3pxaHJ6Z1JMSktRbXQ0QlduVk9JQ1JW?=
 =?utf-8?B?dEdocTFPNDJTNUJRNnhXL2JWR2MxNjZJMHZ3L3JjV1V3ejlQY1Z5Qmw2M1Uy?=
 =?utf-8?B?TktsRno5SUNRbHR5RFJ6MUJmR1pXdjUxSFVpMUZ1Y3RwYnVQQ25haTZnS2s3?=
 =?utf-8?B?eVE3dVV4RVZqSGdRR1ZCYkU4RlNDeXQxWnFzZUwwd1MwSURSOUE4ZklPRC8r?=
 =?utf-8?B?RXFDUEV6ZnRyU3IxSVE1Nkg3SVlaMWdQSzVvc1QrQjJWakJVTnFsRXc3aEVK?=
 =?utf-8?B?V1VucjhJM1VMYU9KU1pyZTl4blFXTFd6S0prVWtlWFNrOVVkTCs0REdHSCti?=
 =?utf-8?B?L2VoVU9PTytLQzVXL3dEbHJRWXVJMm4zRHNMNFZIdEZ5UWpUQVVSZGVRdC9j?=
 =?utf-8?B?a0tXZnZuRkFMcVNEaFVZOFpaTlNTamNNMjJ4bEI4U25JRUVjTzFYSWdMUmZT?=
 =?utf-8?B?WDI0bUswZGpHcVJaUFQzSjVuNFF5dXNtUVF3WUxzOXhhRDdkelJIS1ZmTVpt?=
 =?utf-8?B?enJyalBBUGpKUVhHWElVdDAyK1JOREJhekFWU1FHY1ZRYkVFdDh4d25TWDEr?=
 =?utf-8?B?MTZzQnJJSVFuZTV2NW5pNU1VdmdSaSttZXlDYmpFUzg0UW9UK3k1NGlXdnV1?=
 =?utf-8?B?b0hMbDZEVldMc3VCZWk0bWhCV1dySUhKTEZoMWcrWGdxbW10cEo1UVhzZ29a?=
 =?utf-8?B?b1Yva2drTTBnS1d0NDBtU1AzbFo1emd2TGdxYTFkME55ZDEybGV2TVhpSWhU?=
 =?utf-8?B?MEgzOUtnaWNwWXYzUkt4dmh2L1V2dXA5dlZmK3d3YTVLYzdadVMrN1p2Y2JE?=
 =?utf-8?B?dVhTd1c0VTNHTERVVlBHZ1RwNGhhLzJTK012eXQ5US8xbXdyVHBqTUl1eng3?=
 =?utf-8?B?aTFiMVh2U2duVWRDOWNiQ3F4LzJraEZmWHR5aTdxL2ZKKzNUZEMzRXJReFl5?=
 =?utf-8?B?TTlUVVZLeHdEdnVrQUFjK0ZqaEpXZjV1bmtaUzNxUnJpenliWTZhUyttVXZ2?=
 =?utf-8?B?Y0h3cHNZQmVLQU9WT1ZjQ0g1ZFlLTGQwT0Z4Z2kvQmJoSHg4RlFkenBiUnB1?=
 =?utf-8?B?K1Zvd2Y0YTdpSXMrOXpNVXJXSXRUbTV4a05tb3YvQjdUekNMUjM0ZTJYQkxD?=
 =?utf-8?B?NkM1VHRDUkxlelQ2bXJ2VHBtNE81NzQ4ZXdmTVdWYUZueldzbTY5aENRWG15?=
 =?utf-8?B?MWo5VEFTTzd5UUQzZTlRSmtCUktMYmwzUk9BRzVQSE9BQ0VQb3QwQUwybFNq?=
 =?utf-8?B?Zm50WVVjM052RDVDYS9pK1BJekNzZUY1cWhQTVBUL0h1blhOYkgzUTRRbFhn?=
 =?utf-8?B?azAyY0wxTW1RMGNEZmtBUWVOQ3FQOUE4ajdBY2ZIbU85R2VNdmtTN0JJUzBk?=
 =?utf-8?B?eFVXckdwejVRd0QrRFJmM1BBMlZuNzdmR3R0Y21qQ3VYTndlQ2l0RUFkbGNT?=
 =?utf-8?B?Wm9Bd2I1UlRtb1QrN3BNczAyWU82dERNREFjTjhGTTNxbmY2cVBsN09wdlhP?=
 =?utf-8?B?ZmxMVDdOZTd2LzMwWFlTd1RwVWlsQnlnclNMSnIzb0RUV3BFQ0NObW5lN0pB?=
 =?utf-8?B?VUpmdVpjUEIxYkZ6ZFArZUk4NHNoTnJPRHNJc0h4MWNMZlN2V3Q2UjNMWGFr?=
 =?utf-8?Q?cwMLlys6F1twRW142WHdkuCAy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f4711-454a-4368-5fba-08d9ed31fc35
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:41:59.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1vRleZdtWhGkOsF6lXirzCNi3feEIgn1mnEjSEZ9khVpSsD9x2G6DFjUZ2rmf4w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2599
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MdJxE7151L3oVOq7Vv8-4_ZZA2wC2nBK
X-Proofpoint-ORIG-GUID: MdJxE7151L3oVOq7Vv8-4_ZZA2wC2nBK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_02,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=718 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110043
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



On 2/10/22 11:39 PM, Yonghong Song wrote:
> The patch in [1] intends to fix a bpf_timer related issue,
> but the fix caused existing 'timer' selftest to fail with
> hang or some random errors. After some debug, I found
> an issue with check_and_init_map_value() in the hashtab.c.
> More specifically, in hashtab.c, we have code
>    l_new = bpf_map_kmalloc_node(&htab->map, ...)
>    check_and_init_map_value(&htab->map, l_new...)
> Note that bpf_map_kmalloc_node() does not do initialization
> so l_new contains random value.
> 
> The function check_and_init_map_value() intends to zero the
> bpf_spin_lock and bpf_timer if they exist in the map.
> But I found bpf_spin_lock is zero'ed but bpf_timer is not zero'ed.
> With [1], later copy_map_value() skips copying of
> bpf_spin_lock and bpf_timer. The non-zero bpf_timer caused
> random failures for 'timer' selftest.
> Without [1], for both bpf_spin_lock and bpf_timer case,
> bpf_timer will be zero'ed, so 'timer' self test is okay.
> 
> For check_and_init_map_value(), why bpf_spin_lock is zero'ed
> properly while bpf_timer not. In bpf uapi header, we have
>    struct bpf_spin_lock {
>          __u32   val;
>    };
>    struct bpf_timer {
>          __u64 :64;
>          __u64 :64;
>    } __attribute__((aligned(8)));
> 
> The initialization code:
>    *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =
>        (struct bpf_spin_lock){};
>    *(struct bpf_timer *)(dst + map->timer_off) =
>        (struct bpf_timer){};
> It appears the compiler has no obligation to initialize anonymous fields.
> For example, let us use clang with bpf target as below:
>    $ cat t.c
>    struct bpf_timer {
>          unsigned long long :64;
>    };
>    struct bpf_timer2 {
>          unsigned long long a;
>    };
> 
>    void test(struct bpf_timer *t) {
>      *t = (struct bpf_timer){};
>    }
>    void test2(struct bpf_timer2 *t) {
>      *t = (struct bpf_timer2){};
>    }
>    $ clang -target bpf -O2 -c -g t.c
>    $ llvm-objdump -d t.o
>     ...
>     0000000000000000 <test>:
>         0:       95 00 00 00 00 00 00 00 exit
>     0000000000000008 <test2>:
>         1:       b7 02 00 00 00 00 00 00 r2 = 0
>         2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
>         3:       95 00 00 00 00 00 00 00 exit
> 
> To fix the problem, let use memset for bpf_timer case in
> check_and_init_map_value(). For consistency, memset is also
> used for bpf_spin_lock case.
> 
>    [1] https://lore.kernel.org/bpf/20220209070324.1093182-2-memxor@gmail.com/
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Sorry, missed Fixes tag:
   Fixes: 68134668c17f3 ("bpf: Add map side support for bpf timers.")

> ---
>   include/linux/bpf.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c1c554249698..f19abc59b6cd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -220,11 +220,9 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
>   static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>   {
>   	if (unlikely(map_value_has_spin_lock(map)))
> -		*(struct bpf_spin_lock *)(dst + map->spin_lock_off) =
> -			(struct bpf_spin_lock){};
> +		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
>   	if (unlikely(map_value_has_timer(map)))
> -		*(struct bpf_timer *)(dst + map->timer_off) =
> -			(struct bpf_timer){};
> +		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
>   }
>   
>   /* copy everything but bpf_spin_lock and bpf_timer. There could be one of each. */
