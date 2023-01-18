Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE946728A9
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 20:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjARTnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 14:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjARTnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 14:43:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E65867C;
        Wed, 18 Jan 2023 11:43:19 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGUFPY016530;
        Wed, 18 Jan 2023 11:42:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jQDlVbYsATvzxNEN8HFlvylxNNnn3eozlz84EoijsK0=;
 b=WI9Xd1zDyLPk4VeT9RPRal7nsgbn734kkZkPFiKwYrof2nLbwcaAYZnUMUHPF2b2BwUC
 Z8k5Bv3ytDEux5V1D7n+Vi6TX2Fd/LXVIrKxEAI/8LelSrbj+TOtBA9KBhN8yIRH48In
 VNDONzMogIGazPo4vJrHjpbzOuqWJMDzL9Sst2LEQdm/C9UD26NVZFVPcvM6yOYbtdKL
 mADwnurJH8tCr+/5PhviagurSELBpmDP7YBEhqwvFK+C8bfBoCRFaLWvaez+YZaIGp8q
 2qA+AQ5yKLD9hcsLHdwvyF2PzHZa7trMvuFhBQtuPkOH01I186//c+DTyVU8ngRGWP4b aw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5ufesf6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:42:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVNvrWe2Eu++GamhsOGAAH/lfdY2e+TximjlrV8jkziwbsoIrKkdOZ4d2YZdydKFiDL/63G7mXPnT4I3gtVxBHrBgPYDzA+DDtFTrkqnfKU8B/g2x2NRgn6ZbAJ9YPmaibbtAKVjudhIW921ESKZwdH8oQK7FJxjeyPTeMIgWOwFXVzW+ke+acw5X/m7Yxhu0sP68Xvg98sh34qI7UXB4QhGocvi7Bjl881zK+p05KTfzzqOh+gn1Hb56hUvZgMLvBnn24uPovvtiB2WaOCLQqJltS+ByfMqwwxmMcMLmNhHqhF+ntIu5hI0/OQNbPdBbjet4INDkRqMPZgdzIEahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQDlVbYsATvzxNEN8HFlvylxNNnn3eozlz84EoijsK0=;
 b=Soff0UCrXL7WfsDUVzan/DRe6AwZbHv8r8JSyJvhx2gOQAslfO9j9LNYqutRW4lOYc2JRyxyJ0j77kGLxOvVP0tP6fa6DSNXdjXTyAocZ0W2Kn7FoxoIWkNFpFjoWtjn+GazuPOsAp0G4Mw0/5/C7WIK4DcxV4cl2wgyCBaGSoK3c8O8T1YIpeskWdlKTr7XpGZfmVP/QGdFad0UBWHcua01w4uL3aTwKuxMR1zKhoLbhbKx3eCvvCJcWw3USmmEjNT9EMmp6aVs1NXGH6UrNtLwSpmyIuutDcHg2liYfTguwYmChyZVyamwCmc8+nbbfpBZSOq0C3oXCVZe2Nzhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4196.namprd15.prod.outlook.com (2603:10b6:5:350::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 19:42:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 19:42:30 +0000
Message-ID: <2fb5a7d5-d8d0-92ca-122a-965628868deb@meta.com>
Date:   Wed, 18 Jan 2023 11:42:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if
 CONFIG_NF_CONNTRACK=m
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 952ce917-93a2-4368-3707-08daf98c22d1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fby7VYrtzmFVF5UBGsyyCOVQCHa2qPqW3JQuEE3qPaPYraHwzS5mQKcxu1V3dC91+4zIOelAo0Wshq6gjwO5ONjonakZzMtJVjTsDBQwepN08H77Ud4639T5HsTeFpZde3iKSqOtY2V9gaQ458Y2eI07vShcp/F3rczbzPj3VkiQpTtx1Bnzm58F4ClrPQrLVQJeLlveuoYJcnnH84+ng/MF1FIboxMGuFXxfiRF80M6C2sTJ/fcXNQDLwLbLrzelG1QBZesVrEhKluA8O1TGxOpljnwg7Dxt1PYrEzPGMS4PbdT50KCl26ZjTnAat16hS6C7IAEfWuieieBjx4njwjFuArHPSKx1Ucx78msqlzXertMudfZBpxXlhpmq0/5Wzu7+C2X2yooE7OUStQ9x6GQFJTuJtfvWwpdHbh2lFWYwTXey/YuzsU+1hhS+tqOLVoSC665kuZtVLTGedCQDZHYMIWdqCIGghkicUTyec/+U7DdkURsJEZTd83FGJERc3mQoCiHnltGM/GXdmLeutzzyp6gfTXn+gZ48MvTg2i/0nhBoRSgHUq+FtT3wmdtqNrDjSLRg/tIxNp7mvaeUAySCzccrWIU6W/34+q7NveJlLP8mhuRKDn0N1kjWNKOa2m/kQ7HKDMD+b6KICge/9hzeslp2Y2n7y92e5a2ayDDBMfyWFycCTDvhRt8Hx1smoNCVxZwkpgskuUOHWdg/ucjx+cw/st4osS+uIANTUqGOStaZz7VmaPO95zvtm4n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(83380400001)(38100700002)(8936002)(316002)(921005)(7416002)(86362001)(2906002)(5660300002)(4326008)(66556008)(66476007)(66946007)(8676002)(31696002)(41300700001)(2616005)(186003)(6506007)(6512007)(53546011)(6666004)(110136005)(478600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRmRlRjd0IrTmpMK2I3NFNaQVJ4ald5UDJiZzB2UEhmOS9SN3NDajBoblFr?=
 =?utf-8?B?MnVqTmxtVmdNVDhnWXhyNzJ5UTBjMHBKb2tpay9yaGQxMUtyNll1aGdJNGpt?=
 =?utf-8?B?RG9NSVphOTZPanNLdlRlQU1NRDU1K1JvQWY3K0lDZlMzUmFkdzF5aFBHcjF4?=
 =?utf-8?B?WC9iSFpxa0tvOFdNTE9vWlIyaXlUTVZhSUpvT1BqR1JVQmhjTitqbkZaSXZQ?=
 =?utf-8?B?TTYyM0pKMyt5d2tQYTI3MW5uWkFmWjlLRFpzc1l5RXBqMjVEanFQdXJzcXRm?=
 =?utf-8?B?eGgwMDBHYWk4L1dXYjlGQTJTSUFHSjhhNkFPalE5VjN4aSt6S1R0TkRZMmc5?=
 =?utf-8?B?TkdVYWhoWmZtL3UyUWRNWEFIcFNvdWhxRnNZeDdjRDZUNWIyRVIycFpRajlJ?=
 =?utf-8?B?VTZrK1FScUpTL2xaMFBMVW5RZ2ZFeFVVYmZ6UlFGUG5taWNzakk2Lzk0NkJj?=
 =?utf-8?B?UlpsRzhWM3FwRDh3SEczUnRpNVR0STIzT0UxNzBmRFZDVWxwazNWTDhLbnBm?=
 =?utf-8?B?bkJoRU9RSFZ3Z0RETjZURG1Ybkw5OGhLWXQ2dUpIOERXQ1VJTGw1enNDdXRL?=
 =?utf-8?B?NERjSzdEc2dCeWZVUytjTU5hamZjS2JlUTF4V1Qxa0ZVL3lOb05YcHhvN0Jl?=
 =?utf-8?B?VG0wRnJhTThkM3Iza0lNSmErU3UwdmtqRlVocDJQK1UzN3Zsc0NUZ0V2RHlF?=
 =?utf-8?B?NEpzaEZ0UUl6Vm12YzFiY3ZUUjd6ZkJ5TXBGN3pvSDlKMWxCZUEvUnhaTmNz?=
 =?utf-8?B?WDY2UmhWSzJLQ0l1RWhIeCtKNjNtYkJ6QU5yYWVia2VaWVNiajJGalZwTlZm?=
 =?utf-8?B?Qy94anp0eEtjd3o0SCsyQnM0Q2pCVFJhcitkVGxKR2tDdk9BemNKOVdFc0ZX?=
 =?utf-8?B?OTBxcE92NG9ZK0lkUi9ickdLMXp4VDFqMzdFUklPdWhEa1lzQmRIV3NLOVhx?=
 =?utf-8?B?aXB6L0oreXVSWW4xdFNXS0U3Rk9SWXF0Y0RueFhsaVFtWVlkTzJ1eFhyQ1Nk?=
 =?utf-8?B?czIvWDRwMkpNdWhzTG9SZ1VjTWJGUTJQalRkVHFXbFg1VmFPSHA3N0RoWVRD?=
 =?utf-8?B?cUsxY1JNU25iblk1ODZndG9zR3Nxei81QVZhSzE3eDN1NlA4TGcrNUtNc1Ru?=
 =?utf-8?B?VEJFYkNjU2R1Z0RiaFNyaDg2cXFrVW9nRzVEeFVGT28rdG1uWE9yVS9HNXI4?=
 =?utf-8?B?MFNWWEE2SzAyOFBlR2dBcHh0M2dtQ2JqS3VkcUJqMnh4S1g3ZDhtUWsrbTI3?=
 =?utf-8?B?aFR4cjlQR2tpdG9NV0hUbGZ5S0VLVHhESm9XdHJlRjd0VnlyVFFuQzdqU3E1?=
 =?utf-8?B?by9NbUExRWdrQmdqd2UzaHJWQzZLdmM3NUtIdnAwVWkyajlVQVM1bzd4SHJW?=
 =?utf-8?B?R1l2UmVXYmQ4OEFsMitxd1ZGQnRmb2gxVlNJOGZDUU1uQnh0M0ZWdnEwVjRI?=
 =?utf-8?B?OVVPYVlqNzY2NnVNNHpOQXFVRllwVG5oS3dBVDMvc2UvWXhRa0tvMlRzUnpT?=
 =?utf-8?B?cENkem9RTGE5OXdzaERxMTFEVkROZWJiNFlVL2dqMVBIYURoL0lYYktwQXhw?=
 =?utf-8?B?Wks1S0VNQlMxQ1RJT2hML25mZW5DQ0Y2K3gvSExHZzNwT0VQa1IzUWVzdHNP?=
 =?utf-8?B?cE5mdy9NNzE2ckN2WUNmSEhWQWUrZkZmU2xZYThSM1ZOdVFjcjZuU3ErSGJx?=
 =?utf-8?B?SllFcUM5akRsQXVEOFNnYWNHbUM3MXdxcE02b0c3N28vNmovc28xWGV4M2dq?=
 =?utf-8?B?cERpTlllZWJVUTI4SlBpWFBwV09DUEpQL1NuOVROY1EwS2FNQUtIclRuU2Fz?=
 =?utf-8?B?MGZYdXlCTzFQL1AvTmFFRmRVQzl6KzJHTnh2b2xzNnJuanh5TlkxNGhDb2M0?=
 =?utf-8?B?Y2hFYzQrbDlTVENVMkFhdTQ1eHJVUFpvU01mTllDdXNMUkwzUVFRakpDNy8z?=
 =?utf-8?B?YWMvQzh6eWJRYW9oZGdKOEpnQUxIVHY1b0FRWEpwMkRiNzFmVlJPaXlrQjg1?=
 =?utf-8?B?TGtBZzhmYmlXaHo1cjRHaXRDOFBFb3I0Lyt0S2ZVaHpKMGlqaXRLRHQzNUlC?=
 =?utf-8?B?UGM5SUd3Ny82R3NhbDZlT3lvMmxybjJJV2piZk9GWENOUHBXQWRQN0YrOHQ4?=
 =?utf-8?B?ZWxGMHpxT0htdnRzczBiaENQclFrLzgwcktOVGp4VU1ML08zNVJueVAvRUI5?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ce917-93a2-4368-3707-08daf98c22d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:42:30.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+JYBqORqSNduD0pjrFzr0kO6nnY3zomSY2XL8W1xN+l1r59/YJGJzL7mVlpmJhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4196
X-Proofpoint-GUID: ekbRuOhaQoJAp_428p5srl5ujfhBPSB-
X-Proofpoint-ORIG-GUID: ekbRuOhaQoJAp_428p5srl5ujfhBPSB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 11:56 PM, Tiezhu Yang wrote:
> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
> 
> $ make -C tools/testing/selftests/bpf/
> 
>    CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>                  bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                         ^
> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>                  bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                         ^
> 2 errors generated.
> 
> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
> in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
> ___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
> Do not fail build if CONFIG_NF_CONNTRACK=m/n").
> 
> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Okay, LGTM. We will address enum CORE support with preserve_access_index 
attribute later.

Acked-by: Yonghong Song <yhs@fb.com>
