Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E556D230
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 02:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGKAax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 20:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKAaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 20:30:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF265EA;
        Sun, 10 Jul 2022 17:30:51 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26AIjAO0012568;
        Sun, 10 Jul 2022 17:30:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tS61yjxlRmPd/JoVbyD1apTHpxea1CE8idAxU5JAJ18=;
 b=FksO+6tHoyJojaC2BT+XGIUu8oTi0XlGEyLAsX+p0aYpwuCtv8aH6xM1dvHdkbsPYQOT
 Bu2JLO6U8jCW+vjtr7Xs9KeEUwuNg76yhQyDa9GSVva9s8OFJDLm/qXd3cvA6kXnDPsU
 q9F42xMXHuoTBQ4WUmLOFb8E+2MgXCbMOQk= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h7903wx2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Jul 2022 17:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExLIUqu1hFngdxXrs7NWfocXqzO6IWALbm6Im9BD73BjKZe6AnfJDr4TAzHsu5mPEr2Eo/Pig8oOy5ot6jD66/E42n8o4TqaOMguVfvyapG4tVYXWQuqQAD2NhTeA/1g2Y+wGyOHaaLdPZKV9JWXVFHWT7pDU/m5vavid95kItYXH4S5af4KbBswB5HpW4GwNPLJ2z/3Xm1PBBUzhNCRnl1hPHUbLMJdzvu63RGqSQ6C/NvJru8NSJgZrvuBmZMjy1a1IZO1+ioLqkSu0HKWgqeNpANLIbModoSQ9nkQAzjL5OHyN1j9phb8Upew+R/2Cfsk7ero6t9jsjTyeDlmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS61yjxlRmPd/JoVbyD1apTHpxea1CE8idAxU5JAJ18=;
 b=BHvbZHpP4XYIr8pNkUycDWiS8i9rtq+rQq0Lh0xzAsAceApuYAt0tLFP5+tcG7uu9FPd3Y/UdX8o3CHwo9YUi2Dddsy/6hY/+9QFF0yIkYnjScNpj0PEy2un0cs/flYSKpkR3UorgGxIT1vzLR6EEV9dYipqhC6I5zWGMevxGgBuES3rN4fibK5lytOaRNiDzhLdnkySTOh++BF1p6dM0kB1KWORUwORrdB7Hszp5JSYKsBt6mQIF6n9UeihDC8giaK1OK2ivAiFAOSJDn66DJDlE+2QZ0glYr1GN/kTqHDyUs41MveC3IQaKFa4ebiAv/0jK2oYOcs0m5hg0H4CLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1395.namprd15.prod.outlook.com (2603:10b6:404:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 00:30:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 00:30:23 +0000
Message-ID: <186a5b4b-f73e-a6fa-8502-7472ea058c28@fb.com>
Date:   Sun, 10 Jul 2022 17:30:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1657490998-31468-1-git-send-email-alan.maguire@oracle.com>
 <1657490998-31468-3-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1657490998-31468-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75914c42-ad5b-4309-b674-08da62d48b35
X-MS-TrafficTypeDiagnostic: BN6PR15MB1395:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8GQL9li3U+bt6AY5VYBsM3V67ojBsA+3ZJ9Y7vW3gU9PERj2QzA2mcRMAbvA4kwgYSZn8/LfXb0htGa6WfWAioE+BrgMh7jcmhDuSgFOshMFgdnjRL4oQ9Uq8rzhTjJq7WOx1xgnWYmFAJEOXu46o5gPXf43shSMgKOb/OMrluj7VebpUBNEMNNIUQc/ziG0NuHnRiv6GFjlIkWIri7fWS7GiAf2xPY3hKDd2r3mWEAqy1BFPChm6xI2flJEs3+YgR322QStiotAWkma9rAklwAq0Fh9cc5v+VN33HsFaP//eFKby4Xh9OZUk7uPe/33V3sQ81Qs8Ky8YT/wmJYTYkrk9iyzD8N451Y0Zc7yZ+UTq4FYdL2UQHVbvDu1H65KAuGQgpkucXEPAIWjnPBN/WXMILMzkcd/nqaIQNPl2HhtPRqYyeZimrpKsoVGmVtCfC8uFrU3btZXlZ795rlro1URJn4NhGcj+x92dVKH4JQu7zTkD82vc+UUsHKDTbdAJHHFR37ookJCmWS1b8pg1/HMj3w8TB9LV6PMIxZ7VqIwcAph1TNhiOc4Zs1sw8bJTHyjPMMkGW/uaQybtVw4+qG7Q3XHRi9AVOoXzVdVIZnzUt+O1cnlUoq9Sex0oyrzRTHuvk/+E9CVOV9xdK/IqBMwEplP8XrWpVYUlwsIvpUBzIqqM9p8Sal6kubpaokPAOrP4Zs8mR0Vk1+JyXvSBACiiKgb3gEHzKZloqNmVm0KFUTrWl+f7F8Rp/r3Jh+K18eQXqBIq/4Knz6FzczFVx3NhIP7gIUpYttxvDXRH4cFUynSf7VuTsy63Ka8oMnWn3y4pKxlxKWQbnOXTfVEg3S+cGebo9qbcQtmJ3FHzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(38100700002)(86362001)(7416002)(5660300002)(31696002)(8936002)(4326008)(66476007)(66556008)(66946007)(8676002)(83380400001)(2906002)(186003)(2616005)(478600001)(53546011)(6506007)(36756003)(6486002)(41300700001)(31686004)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1tbXhGL29mVzZ4SktZNTIzQ1BiMzRJb2RxZWluc1JoaEdqcmZqOUZiUi9r?=
 =?utf-8?B?bllpYmlCdjExZFh5T3JjSU1YR0c1RS91UGRYeEkrdXh4OGVvMTJDNU9wb2Zj?=
 =?utf-8?B?UE5NYXYzQ0JXaWVLbnpxNjNQWWM3aDc5Z0FMMlgxQTVmNmtMTWNVaks5Szhj?=
 =?utf-8?B?b3ZZbWtSNytjNGFraVplTW5zV1RNZmVXbEdDV2NQNHVadUZudUV6UXIzRWkr?=
 =?utf-8?B?MW45cWQxdTJnT2Rna1JZSFN3Y1Y1d2dkaG5Ua0dZanBjeGN4emppZy9pTzU4?=
 =?utf-8?B?VklYSnlqR2hRY2RsN3NHQWdSbHgrSTJxTDBIUEhCalZWL2dCNHFuS2FDbCsz?=
 =?utf-8?B?VzlsaWJoMVR3T0JSaDRRakx0a1hpTHJaRldOZU1Tc2dzUEdKcVN5OGdGbjds?=
 =?utf-8?B?MlNoMmpmN3J6aUFVOHF3TjBNRUhKYkMxd20rd2tTcCs0Uk92RDRKOW1kWUJo?=
 =?utf-8?B?b29Za25uSTE4UTBHMkdEZGdqalRocmhKWmQ3anlYSk90Mmk5ODA5Y1NtRDBo?=
 =?utf-8?B?YmZRb3ZjdnVQclNKcmFXdmlCSTkzdHBlMmFTTFpZUTM2clEyVFpVNkxveFIy?=
 =?utf-8?B?U2F5RW9weFY5WHFPc3lXc1lCdXBKaEtRRGlUR3czc20wSXNoR0RWYlRTZ01l?=
 =?utf-8?B?OTV3Q0Nsb3F5VDQvcWVxejV6NGtiV2JjUzV1Y2ZrclF5MWR0S3VRejZQSUpI?=
 =?utf-8?B?T3M0a3UzbSs1eStqc20wZ2RmdlJUeHJpUDhYSGNkOWZRVnc1Wng4OGdSa0h6?=
 =?utf-8?B?TktRUFZYenJTNUYxVDNWaS9jZDhJSzRVY2gwNko4dFVIRjh0U1dRSUtvMEJv?=
 =?utf-8?B?WmtWMng5TVJYTEtsLzhiWGM5bGJwcEFXTTAwSDhiOEpuMXFMQVkyMmRkM3Rz?=
 =?utf-8?B?alQwUDQrTjdhNkJRVFRvZDlhUnBNeHZGcTNxS1k4L1hMYVdjVHlFcVNaRHJ0?=
 =?utf-8?B?TDRBRnZGQzM2TlNpSlduYlJVQ2E2SkJEQmFwc0hvZHlOVy9pWmttZEhHMkd6?=
 =?utf-8?B?bDdvVmI2dkFGOCtFUmtaTGtuZHhUcFpReHBWekQ2TDFUZVNLT3R5eS9WWVpV?=
 =?utf-8?B?VzlNNndVZE9JdEJyeEFuSnY3UzNjektJdWo5T0gvMWdSTFZsNFNVeWJsTHh4?=
 =?utf-8?B?RVpiQ1kySDh0Vi9Wd2xHQ25qcGNFMnFYclNDdDRxcnB3N2xRK0YyVll4WFg5?=
 =?utf-8?B?U3FQbnd3dlN3V2l1clZyM0g2K0g3bkR1Y2VxaUYySXJ5b1U1YUhzVkNNa1NF?=
 =?utf-8?B?RDBleGF2MExPOVdxL09hMVZycitBaEZsYWZERDdtYUxyUjUrZ3BZQkFsMk1H?=
 =?utf-8?B?OC9qdUUxZkc4VzRYRS9oZUE5U2VKYUxxb1RVQ0pzWkY3cE9sUDg5YU8yUFFm?=
 =?utf-8?B?ZHJyM29jTjhHcWVlVVlUTytFYUdQbXpzWG0yZE90dVUxbnp1UmNtOUxOdGg0?=
 =?utf-8?B?ZUtQSWIwWXFrWm1CWkc1UkVKZHBNVWovdmw5T0RzNzE3QnRTTlBXVlg0L1pI?=
 =?utf-8?B?Tk1sNUYvcHp5c1J4M1VVbDc4OUEzRjVlZFdQQVZsZ3NudWVMVDh6cEpXSU5U?=
 =?utf-8?B?ZFpLZ3M3Qno4Nzh4U0I5ekJPckpmV2dqUndpdVY1cmQwOUMzRGFIdUwwNGZx?=
 =?utf-8?B?UzIxMUE1bG1zelRXVHhXWWYrUGpsTmswSVhqeHg4RjBuY2VRVTRCYXZxZzFP?=
 =?utf-8?B?MzhrMGorVEFUZFdMeHhmaVN2YTFaT2oyS2hjYTBWZEJ3NXo3VHlBVGR3UDMy?=
 =?utf-8?B?ei9mQkpnUU1ZWHk4N1QxdnhHOTRTSGpSYlF0Ynl2UDVIZ2o1akt4azBPSmdE?=
 =?utf-8?B?cXVJMXQ4Q3N3VnJ4SUVCdUk3TXo5N0J3YVljdjB0Y24vTlZZaGFwSUIva090?=
 =?utf-8?B?K2FKVSt3UUJNQW5Hbm5SMVJ2K0pYaGJrT3VhZHlsWEhodWgzYUIwZ1k5OUs5?=
 =?utf-8?B?OFI4WVFiak8xNXlva0hSQk9XVEVWT1QwcytVbjJvdU5OWVpXWVltVVRYYWRm?=
 =?utf-8?B?K2krcFlUTVRyK1QrTzIxd2E4YTA2TWxla0F6ZGFUZnFwZjNVOWRGanl4NVNX?=
 =?utf-8?B?djNNS1pDeXNYbEI3VFAyYWlOUVFUWEw2Y1I4bzVhQWZUZUs4eGVEaHJ5eWx3?=
 =?utf-8?B?V0IrNW11cEV1NEs3eGVXa0l1ZFFsaGROeGFZNTJQd0xISElMNXV5bGtKN0Q3?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75914c42-ad5b-4309-b674-08da62d48b35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 00:30:23.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlEyyMnbXonyHWL79UKM+LnqSWJqlEp1CBIvq6TTa4uUt8PwKJgKg3gAHOu3sP5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1395
X-Proofpoint-ORIG-GUID: lqSa-yi3rlZPyrkjE8SIkFC8R0eNsedp
X-Proofpoint-GUID: lqSa-yi3rlZPyrkjE8SIkFC8R0eNsedp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-10_18,2022-07-08_01,2022-06-22_01
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



On 7/10/22 3:09 PM, Alan Maguire wrote:
> add subtest verifying BPF ksym iter behaviour.  The BPF ksym
> iter program shows an example of dumping a format different to
> /proc/kallsyms.  It adds KIND and MAX_SIZE fields which represent the
> kind of symbol (core kernel, module, ftrace, bpf, or kprobe) and
> the maximum size the symbol can be.  The latter is calculated from
> the difference between current symbol value and the next symbol
> value.
> 
> The key benefit for this iterator will likely be supporting in-kernel
> data-gathering rather than dumping symbol details to userspace and
> parsing the results.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
>   tools/testing/selftests/bpf/progs/bpf_iter.h      | 32 ++++++++++
>   tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 +++++++++++++++++++++++
>   3 files changed, 122 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 7ff5fa9..a33874b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -27,6 +27,7 @@
>   #include "bpf_iter_test_kern5.skel.h"
>   #include "bpf_iter_test_kern6.skel.h"
>   #include "bpf_iter_bpf_link.skel.h"
> +#include "bpf_iter_ksym.skel.h"
>   
>   static int duration;
>   
> @@ -1120,6 +1121,19 @@ static void test_link_iter(void)
>   	bpf_iter_bpf_link__destroy(skel);
>   }
>   
> +static void test_ksym_iter(void)
> +{
> +	struct bpf_iter_ksym *skel;
> +
> +	skel = bpf_iter_ksym__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
> +		return;
> +
> +	do_dummy_read(skel->progs.dump_ksym);
> +
> +	bpf_iter_ksym__destroy(skel);
> +}
> +
>   #define CMP_BUFFER_SIZE 1024
>   static char task_vma_output[CMP_BUFFER_SIZE];
>   static char proc_maps_output[CMP_BUFFER_SIZE];
> @@ -1267,4 +1281,6 @@ void test_bpf_iter(void)
>   		test_buf_neg_offset();
>   	if (test__start_subtest("link-iter"))
>   		test_link_iter();
> +	if (test__start_subtest("ksym"))
> +		test_ksym_iter();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
> index 97ec8bc..4b23a08 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> @@ -22,6 +22,8 @@
>   #define BTF_F_NONAME BTF_F_NONAME___not_used
>   #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
>   #define BTF_F_ZERO BTF_F_ZERO___not_used
> +#define bpf_iter__ksym bpf_iter__ksym___not_used
> +#define kallsym_iter kallsym_iter___not_used

There is no need to do kallsym_iter. This structure
should appear in vmlinux.h for all supporting bpf kernels.

>   #include "vmlinux.h"
>   #undef bpf_iter_meta
>   #undef bpf_iter__bpf_map
> @@ -44,6 +46,8 @@
>   #undef BTF_F_NONAME
>   #undef BTF_F_PTR_RAW
>   #undef BTF_F_ZERO
> +#undef bpf_iter__ksym
> +#undef kallsym_iter
>   
>   struct bpf_iter_meta {
>   	struct seq_file *seq;
> @@ -151,3 +155,31 @@ enum {
>   	BTF_F_PTR_RAW	=	(1ULL << 2),
>   	BTF_F_ZERO	=	(1ULL << 3),
>   };
> +
> +#ifndef KSYM_NAME_LEN
> +#define KSYM_NAME_LEN 128
> +#endif
> +
> +#ifndef MODULE_NAME_LEN
> +#define MODULE_NAME_LEN (64 - sizeof(unsigned long))
> +#endif
> +
> +struct kallsym_iter {
> +	loff_t pos;
> +	loff_t pos_arch_end;
> +	loff_t pos_mod_end;
> +	loff_t pos_ftrace_mod_end;
> +	loff_t pos_bpf_end;
> +	unsigned long value;
> +	unsigned int nameoff; /* If iterating in core kernel symbols. */
> +	char type;
> +	char name[KSYM_NAME_LEN];
> +	char module_name[MODULE_NAME_LEN];
> +	int exported;
> +	int show_value;
> +};
> +
> +struct bpf_iter__ksym {
> +	struct bpf_iter_meta *meta;
> +	struct kallsym_iter *ksym;
> +};
[...]
