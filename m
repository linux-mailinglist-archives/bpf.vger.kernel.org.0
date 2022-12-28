Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84265862C
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiL1TDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiL1TDq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 14:03:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F014094
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 11:03:46 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSE7d8j020975;
        Wed, 28 Dec 2022 11:03:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3TwoOgF571zOCkOvpIKHCFZAzdPsCarr3HjqCZz77gA=;
 b=dwBgAP31VxbelTQdP+u9QkrYq/gNpoAvdjig+cnVWxx1V5pBs511KzsJ0/lDtYEgJrFl
 zJ301Db7gsy6aCAhpdVi1mUcibDH9QVUxAHm2owbRmJ54kReMCfIzSExs/zawjQeJVh9
 ntO7/BZ4yi3d3ful6RJVhbigktlK4kFbZPMd4v1pB4d8f+QXxiD/liRHh73NZRTY3HKP
 F6mk9GIBSCmHSdA9lf/6leJrczcLruwZfDm+Y69NmZQT6H40vMHBZL5wOl6bT1xOUqeD
 T+iVuH+EWZbW6OTbax6FyeDwCpxU5OJwYiqiM5m5DbngWKHmybrkmirqSAUq16eN/pR/ Hg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mnxbs5f4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 11:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzVsCoVmuoKF+TF5bFBjzW2ZyATNl4BdKOTWVtZiA29A5MvZGSOyAGbkFvQUKclwi/LJS0O0U4lUDgg72CIrLapysxOq+JvUMrB0fanqFI3FPjUhEGFpZDDo3T7TPO1KObzGft3pZQg99n/KUnCElTGQ5vgjVv7FjekYpzB8ayAJO13VjkpYg9Efm2Gk0KnzeF0zDNqJhTmyjI9mrrCCp2PbfT3AqfQZ9XZSbKtjR/1M6qSLd9hZeXdomWVwVgDW0yuj2gEa6pDuylnbyVcRTStP0ShjVIr7CmgLdconYGxkfG4GE20YHl3nynxGmFEL3CEawv6FLFZmgBgnHoGVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TwoOgF571zOCkOvpIKHCFZAzdPsCarr3HjqCZz77gA=;
 b=bfU2DzBcsVYlXLmMcZ43P66Q9uzUBICfl5MSAm6ndh3rN3T4hNKkfB8RalgEqVGwbQ31XD/NBjHpkVAfhOl8qpbHQnSyKRr06gkwqk5RDYjWQQb6pYDdHrvUkuRc9JSnWvnbIdJCv/LKSx0Qz0iGQuQY9Mov7rljX0f7xGJv9YQHfkxeATNi3Gjtf7U+Fq6dAQ8nqiHFAf7qafZrOhJUBlZDjr5F5FG+w+SY9NjG2SRzoUEAHWNLgiHYWkuSDQkBJfxp38wO5QWgDIYahz2eD2D73Y7VRTLjMEtLyCESLwLzjTm5hIgQs21dvidhx4vIocMKS1qp1XwnHpce7VzYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4807.namprd15.prod.outlook.com (2603:10b6:806:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 19:03:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 19:03:26 +0000
Message-ID: <a797cbbd-3035-716f-f19d-e317cede1af1@meta.com>
Date:   Wed, 28 Dec 2022 11:03:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 2/9] libbpf: make __kptr and __kptr_ref
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
References: <20220509004148.1801791-3-andrii@kernel.org>
 <tencent_BB1AE2BEC1B8D07716D9E5AE0AEE2BDAE806@qq.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <tencent_BB1AE2BEC1B8D07716D9E5AE0AEE2BDAE806@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c92907-932d-4866-7f92-08dae90632ec
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ld24lqO3p1nfcoBQ30XXm/v28r5KJoYzMUzFJErMdXHaUceLsY/87gikvGISlJf15/TCzdTF1hbf54pIiPtPkvcNQYAfUyQL1xqsbps3GO7K3/ohQSQi/kS9z+vsO8YlWNyyRdDJ6FzH1UnJerDBrQitID88BkRS6kHEkeA3AjpmOilVp7599Zj7CNx5zPIS387vwsYVUw27ps3QpZP7Rd12Xh1gO1+LK/dnq5ZQ6EO+LKqMSOedBgLkHOD30sV1VIsyTM/fMjnqO4BGxoPMKLD+vZac0LO5pb/EizqepgC9Tg/8u4rLtjpSubw0ad8rCanPFEsYNWkKZ066jczee4w0UX9JBLGKf+el8EoGr70fCXoypC/QcBOkfTCAxtDB/5JEaYhRn6QCeMx1IDq6Lo/xEKgKrQ1hWerP0F8bt0iZsNwupsOu5jsmfXeBcsn636P8s6Zg96YMph/WM9aCS5DY1OxLyJ7x5Fgf7HQzlZ9yldIpKgbrtmwtry1mSsrOAdcM9PbBmFFkFTn422qXT26BMKGlyTtUn03ENClRNTdbYkTGiwlfhlRKAXuzp/gwExhZQ46MbzM5a9sLgqfMnqGUenytTCqHBcx6agZdHH5CyxW+8ngK0BGjqoKkyhmSSBisGmqoL+S/jb1oiu7Yt3+RH/kZxK9gq6dl4pOWNZZVqUcecVS0fiNPijNtQ0sPOpjeb6D0DLPk5OfU73rv4CxVhm0QJa67H+epFPdclQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(83380400001)(2906002)(316002)(36756003)(38100700002)(2616005)(6486002)(478600001)(6512007)(6506007)(53546011)(186003)(31696002)(86362001)(8676002)(41300700001)(8936002)(4326008)(66476007)(66556008)(31686004)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJ2TDAvM1BXOGFpVVI2dUpBQmtERnJockZaTVdKNzk5a3YzM25yYjY2bkVU?=
 =?utf-8?B?dGQ2bVVvazI0NEhXU0c4VUw2bmpJTDM1UUp1cG84Q0RkZnl0WjFVQzNrRjlu?=
 =?utf-8?B?bmFpNkFMeTEycCtxdUZZeVhqUytDNndDTVRvcWRIM3F4SzhUSG1lTEEyUllM?=
 =?utf-8?B?WCtJQ2ZCNFpoWlo2cGc2ektjb3UySDE1T1lZdDhzOEZQRmNTVjladStLNzh1?=
 =?utf-8?B?SUdyV3ZYb0xFOGRDKzB0ZERyaFJVY1RHc2g4bWFsMU5XOXhSS0tYU2luNXBT?=
 =?utf-8?B?Y1RkakNxQkxLRjkwUmN1czNUb05xMmZuMlRnMDR0NnRhUHgzRytiMVIvRlY3?=
 =?utf-8?B?VFYwd3V3OHpVQUVIOUp0VTR6NVlHdkFaMkZTWlVneEkrZ2gzelhEaWdaVldm?=
 =?utf-8?B?VHNBblViRWdmR3VQUW1zTUtuTFAycGt2VmFLY0xEU1F3UGlrL1J6ZWJGNU1k?=
 =?utf-8?B?aEpwanREc0hZalhPN0gyem5Lengyd1UxN0I4MFo5SFBHR1VYZlV0c1oxdUs5?=
 =?utf-8?B?YWtCSXUxdGZMOUVlekdOOHZ2UjVucTFiNWlhN2t6N1B6dnRNNGNzUng2Mlox?=
 =?utf-8?B?L0RIOG9pc0duNERtcUtlVlJHTnloa1FXSmtRRmR5SnZjS3ppZlVqOEZGUTVq?=
 =?utf-8?B?SWo2TEpBZTJYVzVXcGZGZTBOZ2Z0WTVCU2VkczNoYkdzT3gvMkRjQ0JseXVp?=
 =?utf-8?B?MnUrUjAzTmp0UEVBakphWWxSU0RsS3dnWnFvbnp4STBYbnpNNUR3ZDVPdE1S?=
 =?utf-8?B?cTB0ZUxDandUb0dMeDZ1YmYvMllHbzZ3RE5TNDc5OU9wRGJsd1pYVDg4V3pW?=
 =?utf-8?B?YXN1UFc2WWNGMXBoMmZic3JJM0t5czlGZzcvQ3V3emgrSHlVdXBWTExzb2Zr?=
 =?utf-8?B?UjNGV3pKSUJEWDhQQnhEL0VQTmo5OW03TFlUcGlGRDUxeGhJdFFjRFNibjEx?=
 =?utf-8?B?RjlKODJveU1XR2ZndmpBeXhPMUNSdkI3a2d4dkwwMmtvb3VXaDZHdXlyZEJ6?=
 =?utf-8?B?aUtuT0hKNGZnU1pJWkxSWGJYakorTEF0U3I0S0tWK09ZNmtpY0pxSkFTcHMv?=
 =?utf-8?B?YjJWVTZreXQ3TmRTZUNrTzdKNTBwaGpldFZ6aXl3c2ZrQ1hxV2ZnMHF3L3Yw?=
 =?utf-8?B?WkdLN1hZMWNkNSthZGNsejJlcVZ1VlRzVWVEU09XNkdwcFZLVmdyMFhkNmRD?=
 =?utf-8?B?NCtGRGpyUGFDR2FHczI5ZmRWQnJ5YkxMKzFMTk8wQlJWMURBdCtOU1M1VUVz?=
 =?utf-8?B?OVVHd2tYYkJxQmdwL1EwTnZGN2w4OG55TkhhRWNKTTNzT0tQTEtLekoySmpO?=
 =?utf-8?B?clNKMlM4VmxtWTJ1UWh4V25SZnJ0S0t0QnY2Wmg2VE93a3BXeTFoanFRQTA4?=
 =?utf-8?B?TCt5Ry9EZzMrY2R4Ty9RTis2Y2g5VHJucHllTEZBUnR4MnBnUzd5VHlBZ2tn?=
 =?utf-8?B?TTFEbXFQcHdHeDFhZlRJVmdsU0Y1L1Z1ejE0VUFxKzExVWN5OGluWkRWU2FL?=
 =?utf-8?B?ZXFVb0JYWkk2bEFYZFlNUVF5bnM5enh4Z0VBZlhSMGlMSHBrSXUvcVllUW5M?=
 =?utf-8?B?QW9Dems4cndEc1hUOHU0LzV4cFVldGRyVUk4Rk96SUJ6Zk5FOEpLam02T1NE?=
 =?utf-8?B?UFY4VGJrazR3cUNUMTdvUHRJeUU1UEl3VTJxM3BZaEJIaDkybXhualJDNnAx?=
 =?utf-8?B?a2h6elB5WVBCdC9xanFtZFdzZkwvMnIxQWVRUVBOWXVJeWIyY2gzMzROYnFX?=
 =?utf-8?B?N25nb1lYdC9vbk1pTkRDdjhFZ2VCQUxlOEM5QWhxNWNnQ3N6bHVpSFZ1b2JJ?=
 =?utf-8?B?YkNjbVlzbjBrajdJZ3FHOFFPMCthOHhZSnU5TVl5b3VEVnBqKzhhdDJmUU0z?=
 =?utf-8?B?Z1NsK3FXRTluWTNNcTVoVUl6MjUwZmlxUDhqVTB0dUZ1SFBibGJQNUxHenhI?=
 =?utf-8?B?RFhRU0FUdy9hVmJER0FPc1dIMERkZFVnZFpMWWFLdWw1aEg0NUxmNnlVQUtN?=
 =?utf-8?B?QzF1QXlPdlJUNnNDczNYb3RRZVhlRkI1eDVzOVFYK1daZk92dHdIL1B3VzYv?=
 =?utf-8?B?STNScmpneDJrbzZEY3BNbjJDd0ZoZExtSW94T01JQjJHYWQzeGt0K0ZDQWtZ?=
 =?utf-8?B?RDNIQXRQMDcvemNXbktVczVYWTN3QWdEMlMxN1F2TjllSjNhVVRPQ29vTHVR?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c92907-932d-4866-7f92-08dae90632ec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 19:03:26.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPo+/Epu95PJ2RstFZyoxr7nvDAdwm2JdkdUMQD9BnpXanHoSByd5w6Oz/3plhQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4807
X-Proofpoint-GUID: OqM5rHSKiHJrrEEiNPkRudJsFYmqf5iR
X-Proofpoint-ORIG-GUID: OqM5rHSKiHJrrEEiNPkRudJsFYmqf5iR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_13,2022-12-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/26/22 3:34 AM, Rong Tao wrote:
> Hi, Andrii. It is much better to get an explicit compiler error than
> to debug the BPF Verifier failure later. But should we let the other
> selftests continue to compile?
> 
> I get the following compilation error, and the compilation is aborted:


btf_type_tag and btf_decl_tag are supported since llvm14, could you 
upgrade your compiler? If you want to truely test selftests, you should
try to use recent compilers, otherwise, some selftests may fail and
some others may be skipped.


> 
> 
> $ make -C tools/testing/selftests/bpf/
>    CLNG-BPF [test_maps] cgrp_ls_attach_cgroup.bpf.o
> progs/cb_refs.c:7:29: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
>          struct prog_test_ref_kfunc __kptr_ref *ptr;
>                                     ^~~~~~~~~~
> /home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
> #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cb_refs.bpf.o] Error 1
> make: *** Waiting for unfinished jobs....
> In file included from progs/cgrp_kfunc_failure.c:8:
> progs/cgrp_kfunc_common.h:13:16: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
>          struct cgroup __kptr_ref * cgrp;
>                        ^~~~~~~~~~
> /home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
> #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cgrp_kfunc_failure.bpf.o] Error 1
> In file included from progs/cgrp_kfunc_success.c:8:
> progs/cgrp_kfunc_common.h:13:16: error: unknown attribute 'btf_type_tag' ignored [-Werror,-Wunknown-attributes]
>          struct cgroup __kptr_ref * cgrp;
>                        ^~~~~~~~~~
> /home/rongtao/Git/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:178:35: note: expanded from macro '__kptr_ref'
> #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
>                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make: *** [Makefile:541: /home/rongtao/Git/linux/tools/testing/selftests/bpf/cgrp_kfunc_success.bpf.o] Error 1
> make: Leaving directory '/home/rongtao/Git/linux/tools/testing/selftests/bpf'
> 
> Best wishes.
> Rong Tao
