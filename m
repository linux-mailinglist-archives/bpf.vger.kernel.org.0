Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AC6E4FE2
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDQSJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQSJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 14:09:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BF10D
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 11:09:08 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HEbXG2013227;
        Mon, 17 Apr 2023 11:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NvohMWfUKq1XiQP3XQvQx1aPV7Ob7sfp+kPIgRjgY4g=;
 b=IfrwRO22hMwBbE+V0l1sAXqWKqJjTK7aZwvO1cdxYdpapdUTgx1xRE4Iw4ynepy39XqB
 HTYydFbcBdlI2+gu+vRAqJ254ym3IUXKf7th2VIpXua7y9AbsiIQyrMqDSTCxQ3GOXNT
 JvYh+zexHwqLiqp4k/HXvjrmbZXm4K1VxHwKFlAJSJKWAynvdQ/tSt9qpfb4ePrhmARH
 K4HnBOMhBA7VcVGjsyKLq41AU8C+pmkDh9qEdx7xQ5OQAMVA6pQZOX1lw9eA+G6OQec6
 AGFKFbP43NR3IrkNIJsVWqWz8r8A6qZ6RJpAANPNjhMLLWb6LG68zPLLUUP8y6B1WVjD eg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pysrwjr20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 11:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aquyv2RyeOrAGcCb0cGMISP+IocXqJEM8gxlCzcBiDSqYvYrjmm3/ls0xHhH6gCDwbNZYBqhq3m0un++mEgkIlxqTt8WzQqMaOU+ZVkPwxaLG7QPuywJd5+jbPVsDhlem1zrTZeAdLpdmqmNgL0gmq9iQu2kNKkB9iylaeI5ZPeEXCICfDusGQOTgplUqsJenEbqT2fDxTABREASYChnSq580K4pFtv3RpWU27kjGVGGYjZYG73Xl35RscmfPRT5M4YLkfU8p6uODlyMgYypBIS3i1G7FS1pHpN+xUU9kggSTMCaYR6Tb/yFdGkxRwbBU3/oKHNKxIcLFe8h520PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvohMWfUKq1XiQP3XQvQx1aPV7Ob7sfp+kPIgRjgY4g=;
 b=YsJA64jwKBpTwO+Nsv8feaZ8RjVXbP3tpejCfS/VYxc8fk7Qrc+4PT4qefvH+1v8qqzCkZXbnK3fP9hlMa0/EhboLndbB5L1uxhySONSUtUKXnDX01tgrgMxULO9rJSEcQ+ElRQwL1Q6R+O25GsynC+lY1y5XBEv1m0Xh+kq3CdEq7t3um7XJnrknqBllvfoRRA/8hLK5RgTdL7NJxFmz8zrygSNWMRGYfDmZa1rTBY+r9otD9AiX0qKNT0XkEXo58Kxq/xxb9eOwqCineZyNeAR8IMzIw0DRcRPVCjOikUoAd1cBrq7Gfz4B/Di/q0pM45dg2AV67p8TZoK/dZESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SA1PR15MB4625.namprd15.prod.outlook.com (2603:10b6:806:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 18:08:15 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b26d:c096:654:edd3]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b26d:c096:654:edd3%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 18:08:15 +0000
Message-ID: <5eb35bb6-2720-620c-f552-fa810e7ca1fc@meta.com>
Date:   Mon, 17 Apr 2023 14:08:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 bpf-next 5/9] bpf: Migrate bpf_rbtree_add and
 bpf_list_push_{front,back} to possibly fail
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-6-davemarchevsky@fb.com>
 <20230416011106.hloajgkq5c7tctju@macbook-pro-6.dhcp.thefacebook.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230416011106.hloajgkq5c7tctju@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SA1PR15MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: c2228773-c538-4b9e-d21d-08db3f6eb735
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scBHpwrkRzO8ih6tUw7+vjCRmtLreip42RncxJpTAkRL9W1mdE06u9Iq0Xufc3AhZUyhYfnQXpRgpBSzi4Cw1CEj6ecltesv5oZ8M/GsLtMK13Q1nXcU3lTWMoZJ2UyIjrZzqgBnzPyABhG6pTqS0ifXrtafGSWWkWN72S+sytRtmUGAlflRgqZy023Gk7R/u37quHXEVlqFbWZoIDeRUYJWwaH4YrFqPo7QpwDHe1i/GECkgWdrYxtAc+F7PCNw2kqwjGMZqsaGWwLD1IAs2yq6QJvSqd8VNVsUxrtyKnz68sBrLFecyuoLfu1vlLx7/MCfNWTnE/ni5IeYE6WGgSxVZAOkl/KfCLk9gpBdwz9f3N1G5j0bz17m8J6fgPA/zf/v7nv7kopu03BKT/MvGmjme4t5cEh/H4oWs8xT+84Sdll6t8WTZytmAZX5f5axqZctvSU8zB6U+aBdyL9NzBEGlThMZOmRiJxGxYPa9rSDvi15pvsQ9gKOomI1QQOeu930TA28wb/4Ukrdkkm2dV1sa8jPZY7Q4Gmf6rXSPMQmm3p24x9vLq0W75GlXTOKYjvCpmavWVAffHTVcdw1N2yVJ+5f6w3SmuDhhr5j+tfmHZVtscsuj2fL2UQSuMwg29ueR4/JoTBkcCMpKfwE9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(31696002)(6512007)(31686004)(6506007)(53546011)(478600001)(86362001)(2616005)(186003)(6486002)(66476007)(5660300002)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(316002)(110136005)(41300700001)(38100700002)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNpZ0pPUGtOblZQOGRLdGlkcERlR2EvaHVBakRGYit0Vnl5YjZLcGY3dzZW?=
 =?utf-8?B?N0k1M1JNUElyRmpUM0FNNzBrOHhJdTVFR29uNkJKTC8raFhja3Q4dXdQYkpE?=
 =?utf-8?B?b21ua2lVMUdlVWZNTEZVbUxnLzhoYXpZTDVCdm5JSXJkc0pXM0xDN2w4SGhn?=
 =?utf-8?B?RWJVTXovc0lIaVpCZGtBVWpSdzVBT1ZUM2ZaZ1R1d3BaWUdkcVc1bnRLZWla?=
 =?utf-8?B?bjI1MjVsd2RHZWFjRm0yQXV5MXBZc0doaGVMN0R6eTlTdjc0YTd6U2FlWWNO?=
 =?utf-8?B?bEZXTlgvUHF0WXFLQWcrRDgwYVBFclZ2L3RaUzBCbUV5YzhXVGk4VlVTME5T?=
 =?utf-8?B?cWIxTzlNb0ZIMTdtdDhsNTlNcjJJVWVsQ1o0SzFQbldvbmVvbjZZdzZDVW04?=
 =?utf-8?B?Q2JEeldCbC9EeHNqdm4xRjF6aHV0YU81SUhvUVdNakZwRVpLRzdXOGlodnJh?=
 =?utf-8?B?amlET3JvTTB4UUhKcEFmUmpqNlpiU3BhYW0wY2dXRjE2dTc5ME1zamdITmZm?=
 =?utf-8?B?clBEZytrT2ZpblFPeHBoZUxoZGdFZThEUVNRTzUwcGdoRlpSODFnT3RWY2hv?=
 =?utf-8?B?WXYrZjBmUEU1MldqUGxHdnM2TlQrNUluUVJFRmQ1VWVSR3I3aVhkL2U4aitP?=
 =?utf-8?B?OERKZHhQamtWeUwxQWxxQkNBamU4blFIYzJ1ZFNtWXlZYmt4MGVCVmdzSXNw?=
 =?utf-8?B?QTU0WW5VYmZnZG0wN2U0K2RwamdHcGtZWnRwR25iYnA4M3lYdWZ3TFlJTElI?=
 =?utf-8?B?RmRUbjlwYkFtNzZ1QzkyQkp6cUs5UlU4amJ6TE56MjJqdXVWL3p1dWdvblNr?=
 =?utf-8?B?RVpzQzFFRHlLdm9VY202MzZhMHpVNXh6a1g5eGhDc1dGbk1SVjQ1TTZsNkJ0?=
 =?utf-8?B?SUFneXBOK2szRmpZaEpMUHUxMERxMEljZjJ3NGNYelV6NEVQQmQ5MmlMRWZ6?=
 =?utf-8?B?eHFWUDdMS1kzcWNsd1NZWUIwbWE1djNhSDBCNkphUFp1aDhXRFFuYWpIaHJh?=
 =?utf-8?B?Y1J3dXZDNGQvVm00Q3A0OFRJZXpiV28yQnR2T21uQ1Rqa1dCMjF5a3pMOFdN?=
 =?utf-8?B?V25TcG51N01VY2t1U2JLR1VNK01xR016R2crZGxTd20vYUsvcVUvWHRnQWp1?=
 =?utf-8?B?WG85Z0t3ek0zK1RNek81TjVuOThaK2ROalhYV3hJcTZuTllsOHpoSTlFNGh0?=
 =?utf-8?B?d0xGL2VzUnJNL0RWVG5sL3gxYTM5MWJBaWdKY1o1eHFWY3hxWDFGbTExbjFp?=
 =?utf-8?B?WHJrNVlVOFBrNkRLcTFWOURLRzNUdy82UmpSTVRvTTMzaDI0NTVEeGZTYjRF?=
 =?utf-8?B?MGUvcnpQNlpVSWJYR1ppS2dERExLUGc4TkRuam9kcE9jQThFVlE0U1J1SlZw?=
 =?utf-8?B?cis5RXBpOFd6UkJKUkFCY1VHTWx0cTN2TEFiSTBWa3dkT3A1cXVyUk1JL2FF?=
 =?utf-8?B?a1h5Z0l3YWQySzFPTUJUc3l1bGVLODdXMFVpdjRpNWI3RUxOMmZUYzl0Z3Fm?=
 =?utf-8?B?OUVoWDVUbnBNcWI3MzcxbVNUeWZXdndpZ1RHaGhWaVdPVitZQm1QM1RoTlJS?=
 =?utf-8?B?WFp1WlFtTGFUUUVjQVR2Y3lBMGZEUU82MSs1ejgyL1dGZ0JZUmtsNGtuLzRp?=
 =?utf-8?B?MDM2aWx0SVpXL3hKSHNBbTlSc3AxR3hmbXBkb05nbEhsOEhWaUpqSXBPOGtm?=
 =?utf-8?B?cEQyc0NBOXRxL0R0UkpDNFVrWXMvdVQ3RlR6TVE5bC9TQ1VySjYyeWpTbG5y?=
 =?utf-8?B?QkRhRnhDRDhKeVNpaS9CTklLSHYxajVjNUFTS1pPZUNycVFYb21KeG84cGpL?=
 =?utf-8?B?aEJVdUN2TGNOZkVsVVpJVlFCdWZ0aG1KZHhNRjhWUUQ4NG90eERnT2ZwQkdX?=
 =?utf-8?B?VEQxRDRDd0tSczExMHBONEppMVlqNXZjVXg3Z3FTNlVxYlhjbkdaYjdrSXdO?=
 =?utf-8?B?cmlzTWl0VmVkVTJIN09qQnhyUDRrbDhieEd6ZnIzUVNNN0pDT0RMVk9YbERF?=
 =?utf-8?B?YjI2V3dxYW1OMHlLdU5QSy9pVzJFa2UxZjVxeExVTHlDUTlBMjAvNkxNTU9K?=
 =?utf-8?B?ZUt3N0VJOHNuOGRacWJUbGZoTXhEMXVjTDBDS0tIYllwWkFSTStHVWJCWGhZ?=
 =?utf-8?B?Z0J2NGtIZjQwWXIzMkI3dWc2NFRIcVpDbGs5Z3N4WGlCb1ZVK3BRRW1kWEJV?=
 =?utf-8?Q?7Xu9sAxlY9j0m5N3s2IboQk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2228773-c538-4b9e-d21d-08db3f6eb735
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:08:15.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqAFshKFUTGYFZDu15ROIJOAttRGOBl+quwUGsJuHrv/smEwADrcXBGF3BEC2XozVrPy+jUcKaZtMR0D6lE0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4625
X-Proofpoint-ORIG-GUID: 7nkfoC_RClWPLte_kAjXdDgCzJ7u_tQB
X-Proofpoint-GUID: 7nkfoC_RClWPLte_kAjXdDgCzJ7u_tQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_12,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/15/23 9:11 PM, Alexei Starovoitov wrote:
> On Sat, Apr 15, 2023 at 01:18:07PM -0700, Dave Marchevsky wrote:
>> -extern void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
>> -			   bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b)) __ksym;
>> +extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
>> +			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
>> +			       void *meta, __u64 off) __ksym;
>> +
>> +/* Convenience macro to wrap over bpf_rbtree_add_impl */
>> +#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
> 
> Applied, but can we do better here?
> It's not a new issue. We have the same inefficiency in bpf_obj_drop.
> BPF program populates 1 or 2 extra registers, but the verifier patches the call insn
> with necessary values for R4 and R5 for bpf_rbtree_add_impl or R2 for bpf_obj_drop_impl.
> So one/two register assignments by bpf prog is a dead code.
> Can we come up with a way to avoid this unnecessary register assignment in bpf prog?
> Can we keep
> extern void bpf_rbtree_add(root, node, less) __ksym; ?
> Both in the kernel and in bpf_experimental.h so that libbpf's
> bpf_object__resolve_ksym_func_btf_id() -> bpf_core_types_are_compat() check will succeed,
> but the kernel bpf_rbtree_add will actually have 5 arguments?
> Maybe always_inline or __attribute__((alias(..))) trick we can use?
> Or define both and patch bpf code to use _impl later ?
> 
> @@ -2053,6 +2053,12 @@ __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node
>         return __bpf_rbtree_add(root, node, (void *)less, meta ? meta->record : NULL, off);
>  }
> 
> +__bpf_kfunc notrace int bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
> +                                      bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
> +{
> +       return 0;
> +}
> 
> Only wastes 3 bytes of .text on x86 and extra BTF_KIND_FUNC in vmlinux BTF,
> but will save two registers assignment at run-time ?

I see what you mean, and agree that smarter patching of BPF insns is probably
best way forward. Will give it a shot.
