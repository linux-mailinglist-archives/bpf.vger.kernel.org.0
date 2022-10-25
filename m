Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C60D2B7
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJYRpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYRpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 13:45:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33598D38F5
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 10:45:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PDcvQR014122;
        Tue, 25 Oct 2022 10:45:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+3rYukprQOYzp/uQhE/SPDg8rpiU2BNq6OKES9jbmpk=;
 b=MJQTXTZVnIq1mI47rOsnqz7IWkFmRtZDPd35KLdm6ZxM8ern618ocC6/JgsEHb2stfOO
 YKBRNKe/X6zXpoWOYSFjRtGQdkuhe7FEhiMdWraIWTPE8CHNCfiEW5oA/cKOaEV6jSS6
 nTLO9lHdDexgXHbPmSgYz5FCW88S1MMkE0E3/+GBBHgLQ90ATVW1EKP/QXRago8gvtQS
 tbE4DVrqO/JrLsxU3weup8PZBHUlTxDVMCNTXOLN5tc1f9WHHDXnb+t87QHzPQXiMRua
 HMUYQkY3ePXl+B1DO5F+Uv9hnWvE+2AE4vi53mz4oPcnFLF0eIOc6n8jdYc4caM+WPXj qA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke36822t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 10:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh2Yef8gZ9rU+Y4D5s22qmGa0BCHweTvrioDsxMhAZFzaO/kj3xNsSvJrY1ncwxljKMU634AvI5I29r068QkLXw1kKn5X+zOwSpVJYYZGqg6GZbZEq23ENcQwclJyxmdGo0iPLWYn9hz7Ei0a/5YZzCcerWuuD4wYLy6a09Uzciyz1PWny+sSs90jdp+Z3nMQNOxDgNJITcLLbIcSL6mMxx58V8BrhY+WcXKHGrCFxv1KuWoDfKorIdgVmatkljvV8pCtaN3ZSkW/c4kDfb4+Tvwr7O5pnUBmf+JT84CzyoE/LIeT0+c4wyAx1eOfPVW2jrAQ+OKjnKyjLVUrNgN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3rYukprQOYzp/uQhE/SPDg8rpiU2BNq6OKES9jbmpk=;
 b=duvg+RHWeEP8o9IBRLvmsLxsqBHn5uaChrukS+pbMbLy1Gnzv8jdq7qLVFOm9/kjIsYN+75CK5lxjMb09k0qhhi3KnXpJWYDZGhPAlmJmPBMShfApAwCTaGb1m/nzu0+/PJ56O82HAB1vL8cn17bsljqg9iuOB2hiGzvtjdHRTAwqMBMzacwnfJ9BG5XfUA5AK7WkUdo5t2t42BoYhWCyrcFMKBAe2RzKOSYB3HNU26c54Df3xLMnD5lhZFVQxk5lE6wIO3mfy5oBZ0DEyaFRLfm8v5yszzXcqtjGWWf/868we5dOnBIfrU7TvkvYTqPYj4o4d+18qU9ci/Tj8c5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MWHPR15MB1775.namprd15.prod.outlook.com (2603:10b6:301:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 17:45:15 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%8]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:45:15 +0000
Message-ID: <8e902f3c-8f15-73c9-53ff-e24019afb1a4@meta.com>
Date:   Tue, 25 Oct 2022 13:45:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next v2 22/25] bpf: Introduce single ownership BPF
 linked list API
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-23-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221013062303.896469-23-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:208:19b::27) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MWHPR15MB1775:EE_
X-MS-Office365-Filtering-Correlation-Id: fcefddf3-385d-453e-3d02-08dab6b0ac9d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMAPEZy6cBD79xz2PBBUEWJJRm41wIVeEqbMaopQNxKcGYus+StR6rLdJ88ZYXXO+wm4dg7GOp66hoTdTPGuOGHg8aqqsQVbyNE6Sd5+9+iowlvcoFhV3azCi0X58MDiNCuEnCtYiCJ5i+wYz4AevJ6iNtd7sJiIBLh/hxF5Vkj5bpietzU3RnUxTWRgCOAwwEMP8F/0DSOaAcyv2sY6RkXFkbzp6TeCU5DAgzMRciJJREgURMx59+VaABLPGQYPKx7WSjuZu25p2+vyv8WQ6wYjXeqJBjeSaFt0Et9EuQNWZZZJ6D5J2McFsbaASF+DGYHWCHGrvtf21eBAIedL6fvMViJ71zAxbVdNf0e9iPkTZJE0ekZmKf6KZTrKGORroC7gzkXbSNbZ1lcQGK+BlboAp6V1A6PEyRbzUAuxWKfdaUdAT8fA9Tr3X0V7jpnf9slEl7k6vHLzHuMh05obpMenASncaiIc0a8WBNrOFtQevDVzbWwvmNAU+KPqzWPNs+gq/9++KyhWZNviolXuy/mRHS7C/t1RqiTaDiWkJ6K/OKYZcNCrjH8SVbZYmBpJxP0sE6hWMWd+zIlb51T45zZuSqvq6Pkiytb8UUzsP1gErIv1XZSA7L7fYicshOuK2MY+Fi/ktyLFk8TMaGlzuLO5emwrxitXyA36H6dX79OZQB7eaOlxZzDPMf2mLWeJE/amqPg7y++psad6eIRGH6UCWGIVZOVV+5je/EYyYbkrSajp1xkNEPNvTaic+hx5yYs/D/TF61Fzf/Jf3cKyxwYK7vNBIC89iXaj650U6eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(31686004)(31696002)(66556008)(66476007)(41300700001)(86362001)(83380400001)(54906003)(66946007)(316002)(4326008)(36756003)(2906002)(5660300002)(8936002)(6512007)(6506007)(53546011)(6486002)(8676002)(107886003)(6666004)(38100700002)(30864003)(186003)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGQ4ZXBXNVFMZnhLQVJJdEkrS3NTKzlJZUpqSzNud1dpODIrMmJzL0NncTVS?=
 =?utf-8?B?MmNZSGkxY2g2ZkpSVStQd25sNWUvNERQR0RVL2kzaFpQbHQwMHlDQzMxU2x2?=
 =?utf-8?B?VDcvaC9YU1ViTEt6RXA3QnZQTVYwaUhzZERqSU9MVDhtaTJrMlgxK0ErZHI0?=
 =?utf-8?B?V0ROcmVoblZBempjUFFsZ2d3V3JyQ2pVVGZzRmZ2MThsczVEdVlPMCswUjEx?=
 =?utf-8?B?NVZCcHNFb0l3QWxaV3BWOFN3RE5uWU1QUXFUWTV1K1JPR0F0MDJPMnlLbGVL?=
 =?utf-8?B?MDY3OW1yMExkRDhJVE1YUksyZjUzendHVHJYOFM3dFI2RWFubFkvVlhRckhT?=
 =?utf-8?B?VDZrZzVwSnJNdy9EdU1jSnlwS0ZYbnFoV2VuOHU5R1JJT0V0QWNuOFN2aW5B?=
 =?utf-8?B?aTArc0NhNXhZMWZIYy96WC92ZTRUNGUzQXF1NitIK0hveWpOQzFJNi9QN1Ev?=
 =?utf-8?B?WXFUUzhtMjRBNkRITDhlbUp1Yjg2MUZ1b3hNKytBRENrMCszamErbXY2bHdR?=
 =?utf-8?B?VVZHL053SnpVbFR6cG1oMWFCaXRvb3RHaCsrbG0zRTZYT2owdDFmZi9XeWE0?=
 =?utf-8?B?cHpNekRuNTFtdjRWb1NKNlEzN051QktHY1o4TDhJbWpvTWNyVVA0T2ZpVFIw?=
 =?utf-8?B?KzF5eDVpdEh0NTc1blZiNmlZYXFOMEs4MmFocVlpTUM5UkhGUnM1bGdGclF5?=
 =?utf-8?B?YVNOMkFpM1lYZWJvV3c2Wm43UFZJRk52VnVmYWRlZ0F1VjZNSUl0T08vb1hp?=
 =?utf-8?B?aUl1U05GcU1qOTVLUkw3cEk1SjFWSkl3RFFnbitWZ2p6NkZtSkJpb0grUjB2?=
 =?utf-8?B?MGdueExHZ1hGVitaVmY2THV1ZnFhQThubmFtWmZ3Q3MxVUhaVUd1WXpSbnc1?=
 =?utf-8?B?QVpHUm5EQmV6bXhUdmVUb2ZFS29WRG53Q3R2c2lDVVlMbXNJajZZbG5lSGlY?=
 =?utf-8?B?ZUdyTlBHSFB1elJudnpySHdoTi9wRU5NaGF5KytKQ2tZa0dnSkYrQnBnUnJW?=
 =?utf-8?B?Z3FGZzBCM0dkV0QxWVRUS2xTRERqeVNOSmxwZTZ5VFI2ZkQwVk5wbWI0RW5K?=
 =?utf-8?B?TkRjSHhNcEJSQnRaMkwrdjh3anhBWnB1cExVUVNVTEJJdkw5QjdtemlzSWUr?=
 =?utf-8?B?L3k3Ri9EbTFtVDE1Y0xEaFZqWnFDVVloakFDdzAvRWYwaEF5ZEpzZjJjZTlw?=
 =?utf-8?B?dGFFMEVwRWdlTEpBakIvNVlLeEo4YmNLMWtQc09HKzMxMmE1eTN2NzBqZjlk?=
 =?utf-8?B?TXJTLzdkOERqcklUa1ZZQTk5Z2xlRFZZT0hNZEdxeWNmN0Q4KytLd1IvRWlN?=
 =?utf-8?B?VEVXVnErRHNHWktMQVBnYllQci9DUGpyc2ZOVUFzejg0eURWYk1WNjd5OXVE?=
 =?utf-8?B?RE1RWWMyQUdrUVBLblB4NDF2N2hvKzBQN3JVTmtrRVhTcGR2N2RHRG1hYTlH?=
 =?utf-8?B?c3RncDJBUURxMUYxSXIveHUyUWpFL1dSaGd6eWR2eHJML21oVDB1bkphUlRV?=
 =?utf-8?B?L3FVOFgzdlcrNHNqQ2o5eHNsK215RFhtaENUajMyVmhvWWx2L1JhNERmbCtS?=
 =?utf-8?B?dTEzT2JvbFVoanBHS005Z3MrY3Z3Z0ZZaFpJNUdlQlRHVGFPaXd1YVhTa2h6?=
 =?utf-8?B?T0QvSXNkcHA4Z0JRYjF2bEk4WENuOTIwczRMWnpucjVXVThLZm9ZR2xoY2FJ?=
 =?utf-8?B?bkFWNTgzOWJFNzlWZ0IwbG10Y3JNOFZaK0RXUjc1Mm5OSzdQTHlHQ3ZQMVFV?=
 =?utf-8?B?dHdRK2thZytvSDk1cytPc0I0YnNkbExrbWpPSXJvemFnNWNVNW15WmxBTzNF?=
 =?utf-8?B?Kzc1V2V4QzllUGxscllqRVZwTmtPTGFoOWl0K0lzRzVSUXZhdUVsWTJuaWVC?=
 =?utf-8?B?R3dIVHU1R2lKRi9YVjk1bWRnRXpwclNHY3AxSnVQeHh0dEtnOE9keUxQcUt6?=
 =?utf-8?B?LytvS1YvcUs0NC8wUWRUc2RxVllhVmVTNURXVi95RzFHVnl6cUdUYlNkRW41?=
 =?utf-8?B?Uk5heTZQS0Y0T3RtQzI5aU1uOUcvQ3pPMXp0eS9ENk9LamFkUDFxeCtjd3JZ?=
 =?utf-8?B?d05lOUtPcXdxSkZ3MkJyNDI5cStQVXpwN0kvc3VkeG5CTFVLOG1HNUJQTzVi?=
 =?utf-8?B?UFBCYUV1c0pTNjAvTWhDcG50QVhxOWhzYkRDQU5ITDN3SFVoTllJSHNGNlB0?=
 =?utf-8?Q?JGgfgVzDGeTPzSv46NWIstc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcefddf3-385d-453e-3d02-08dab6b0ac9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 17:45:15.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJE1VvQKOPnZrhrHihaKEcnNYzCpKEHPU1cDh9NjRnabXZJCuezQF2kQtNDcL9IK/Mwnmc6j2cicFc1CsjCmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1775
X-Proofpoint-GUID: LdzE9pWuwRAlYtRx5fma5UiQIG_rY0yM
X-Proofpoint-ORIG-GUID: LdzE9pWuwRAlYtRx5fma5UiQIG_rY0yM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/13/22 2:23 AM, Kumar Kartikeya Dwivedi wrote:
> Add a linked list API for use in BPF programs, where it expects
> protection from the bpf_spin_lock in the same allocation as the
> bpf_list_head. Future patches will extend the same infrastructure to
> have different flavors with varying protection domains and visibility
> (e.g. percpu variant with local_t protection, usable in NMI progs).
> 
> The following functions are added to kick things off:
> 
> bpf_list_add
> bpf_list_add_tail
> bpf_list_del
> bpf_list_del_tail
> 
> The lock protecting the bpf_list_head needs to be taken for all
> operations.
> 
> Once a node has been added to the list, it's pointer changes to
> PTR_UNTRUSTED. However, it is only released once the lock protecting the
> list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
> active ref_obj_id, it is still permitted to read and write to them as
> long as the lock is held.
> 
> bpf_list_del and bpf_list_del_tail delete the first or last item of the
> list respectively, and return pointer to the element at the list_node
> offset. The user can then use container_of style macro to get the actual
> entry type. The verifier however statically knows the actual type, so
> the safety properties are still preserved.
> 
> With these additions, programs can now manage their own linked lists and
> store their objects in them.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   5 +
>  kernel/bpf/helpers.c                          |  48 +++
>  kernel/bpf/verifier.c                         | 344 ++++++++++++++++--
>  .../testing/selftests/bpf/bpf_experimental.h  |  28 ++
>  4 files changed, 391 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 0cc4679f3f42..01d3dd76b224 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -229,6 +229,11 @@ struct bpf_reference_state {
>  	 * exiting a callback function.
>  	 */
>  	int callback_ref;
> +	/* Mark the reference state to release the registers sharing the same id
> +	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
> +	 * safe to access inside the critical section).
> +	 */
> +	bool release_on_unlock;
>  };
>  
>  /* state of the program:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 43a7c9999e94..71e0f19f738a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1768,6 +1768,50 @@ void bpf_kptr_drop_impl(void *p__lkptr, void *meta__ign)
>  	bpf_mem_free(&bpf_global_ma, p);
>  }
>  
> +static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head, bool tail)
> +{
> +	struct list_head *n = (void *)node, *h = (void *)head;
> +
> +	if (unlikely(!h->next))
> +		INIT_LIST_HEAD(h);
> +	if (unlikely(!n->next))
> +		INIT_LIST_HEAD(n);
> +	tail ? list_add_tail(n, h) : list_add(n, h);
> +}
> +
> +void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head)
> +{
> +	return __bpf_list_add(node, head, false);
> +}
> +
> +void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head)
> +{
> +	return __bpf_list_add(node, head, true);
> +}
> +
> +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
> +{
> +	struct list_head *n, *h = (void *)head;
> +
> +	if (unlikely(!h->next))
> +		INIT_LIST_HEAD(h);
> +	if (list_empty(h))
> +		return NULL;
> +	n = tail ? h->prev : h->next;
> +	list_del_init(n);
> +	return (struct bpf_list_node *)n;
> +}
> +
> +struct bpf_list_node *bpf_list_del(struct bpf_list_head *head)
> +{
> +	return __bpf_list_del(head, false);
> +}
> +
> +struct bpf_list_node *bpf_list_del_tail(struct bpf_list_head *head)
> +{
> +	return __bpf_list_del(head, true);
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(generic_btf_ids)
> @@ -1776,6 +1820,10 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_kptr_new_impl, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_kptr_drop_impl, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_list_add)
> +BTF_ID_FLAGS(func, bpf_list_add_tail)
> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_del_tail, KF_ACQUIRE | KF_RET_NULL)
>  BTF_SET8_END(generic_btf_ids)
>  
>  static const struct btf_kfunc_id_set generic_kfunc_set = {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a8cd04c18ac5..96cf576784c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5485,7 +5485,9 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  			cur->active_spin_lock_ptr = btf;
>  		cur->active_spin_lock_id = reg->id;
>  	} else {
> +		struct bpf_func_state *fstate = cur_func(env);
>  		void *ptr;
> +		int i;
>  
>  		if (map)
>  			ptr = map;
> @@ -5503,6 +5505,16 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  		}
>  		cur->active_spin_lock_ptr = NULL;
>  		cur->active_spin_lock_id = 0;
> +
> +		for (i = 0; i < fstate->acquired_refs; i++) {
> +			/* WARN because this reference state cannot be freed
> +			 * before this point, as bpf_spin_lock CS does not
> +			 * allow functions that release the local kptr
> +			 * immediately.
> +			 */
> +			if (fstate->refs[i].release_on_unlock)
> +				WARN_ON_ONCE(release_reference(env, fstate->refs[i].id));
> +		}
>  	}
>  	return 0;
>  }
> @@ -7697,6 +7709,16 @@ struct bpf_kfunc_call_arg_meta {
>  		struct btf *btf;
>  		u32 btf_id;
>  	} arg_kptr_drop;
> +	struct {
> +		struct btf_field *field;
> +	} arg_list_head;
> +	struct {
> +		struct btf_field *field;
> +		struct btf *reg_btf;
> +		u32 reg_btf_id;
> +		u32 reg_offset;
> +		u32 reg_ref_obj_id;
> +	} arg_list_node;
>  };
>  
>  static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
> @@ -7807,13 +7829,17 @@ static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
>  
>  enum {
>  	KF_ARG_DYNPTR_ID,
> +	KF_ARG_LIST_HEAD_ID,
> +	KF_ARG_LIST_NODE_ID,
>  };
>  
>  BTF_ID_LIST(kf_arg_btf_ids)
>  BTF_ID(struct, bpf_dynptr_kern)
> +BTF_ID(struct, bpf_list_head)
> +BTF_ID(struct, bpf_list_node)
>  
> -static bool is_kfunc_arg_dynptr(const struct btf *btf,
> -				const struct btf_param *arg)
> +static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
> +				    const struct btf_param *arg, int type)
>  {
>  	const struct btf_type *t;
>  	u32 res_id;
> @@ -7826,7 +7852,22 @@ static bool is_kfunc_arg_dynptr(const struct btf *btf,
>  	t = btf_type_skip_modifiers(btf, t->type, &res_id);
>  	if (!t)
>  		return false;
> -	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[KF_ARG_DYNPTR_ID]);
> +	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[type]);
> +}
> +
> +static bool is_kfunc_arg_dynptr(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
> +}
> +
> +static bool is_kfunc_arg_list_head(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
> +}
> +
> +static bool is_kfunc_arg_list_node(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_NODE_ID);
>  }
>  
>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> @@ -7881,9 +7922,11 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
>  enum kfunc_ptr_arg_type {
>  	KF_ARG_PTR_TO_CTX,
>  	KF_ARG_PTR_TO_LOCAL_BTF_ID,  /* Local kptr */
> -	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
>  	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
>  	KF_ARG_PTR_TO_DYNPTR,
> +	KF_ARG_PTR_TO_LIST_HEAD,
> +	KF_ARG_PTR_TO_LIST_NODE,
> +	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
>  	KF_ARG_PTR_TO_MEM,
>  	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
>  };
> @@ -7891,16 +7934,28 @@ enum kfunc_ptr_arg_type {
>  enum special_kfunc_type {
>  	KF_bpf_kptr_new_impl,
>  	KF_bpf_kptr_drop_impl,
> +	KF_bpf_list_add,
> +	KF_bpf_list_add_tail,
> +	KF_bpf_list_del,
> +	KF_bpf_list_del_tail,
>  };
>  
>  BTF_SET_START(special_kfunc_set)
>  BTF_ID(func, bpf_kptr_new_impl)
>  BTF_ID(func, bpf_kptr_drop_impl)
> +BTF_ID(func, bpf_list_add)
> +BTF_ID(func, bpf_list_add_tail)
> +BTF_ID(func, bpf_list_del)
> +BTF_ID(func, bpf_list_del_tail)
>  BTF_SET_END(special_kfunc_set)
>  
>  BTF_ID_LIST(special_kfunc_list)
>  BTF_ID(func, bpf_kptr_new_impl)
>  BTF_ID(func, bpf_kptr_drop_impl)
> +BTF_ID(func, bpf_list_add)
> +BTF_ID(func, bpf_list_add_tail)
> +BTF_ID(func, bpf_list_del)
> +BTF_ID(func, bpf_list_del_tail)
>  
>  enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  						struct bpf_kfunc_call_arg_meta *meta,
> @@ -7926,15 +7981,6 @@ enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	if (is_kfunc_arg_local_kptr(meta->btf, &args[argno]))
>  		return KF_ARG_PTR_TO_LOCAL_BTF_ID;
>  
> -	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> -		if (!btf_type_is_struct(ref_t)) {
> -			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> -				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> -			return -EINVAL;
> -		}
> -		return KF_ARG_PTR_TO_BTF_ID;
> -	}
> -
>  	if (is_kfunc_arg_kptr_get(meta, argno)) {
>  		if (!btf_type_is_ptr(ref_t)) {
>  			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
> @@ -7953,6 +7999,21 @@ enum kfunc_ptr_arg_type get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
>  		return KF_ARG_PTR_TO_DYNPTR;
>  
> +	if (is_kfunc_arg_list_head(meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_LIST_HEAD;
> +
> +	if (is_kfunc_arg_list_node(meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_LIST_NODE;
> +
> +	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> +		if (!btf_type_is_struct(ref_t)) {
> +			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> +				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> +			return -EINVAL;
> +		}
> +		return KF_ARG_PTR_TO_BTF_ID;
> +	}
> +
>  	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
>  		arg_mem_size = true;
>  
> @@ -8039,6 +8100,181 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static bool ref_obj_id_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
> +{
> +	struct bpf_func_state *state = cur_func(env);
> +	struct bpf_reg_state *reg;
> +	int i;
> +
> +	/* bpf_spin_lock only allows calling list_add and list_del, no BPF
> +	 * subprogs, no global functions, so this acquired refs state is the
> +	 * same one we will use to find registers to kill on bpf_spin_unlock.
> +	 */

It's unclear to me what "only allows calling ... is the same one" in this
comment is trying to say. Are you trying to say something similar to your
comment in the process_spin_lock change in this patch? e.g. "bpf_spin_lock CS
does not allow functions that release the local kptr, so this ref_obj_id will
still be valid then". At least to me the language in the other comment is
clearer.

> +	WARN_ON_ONCE(!ref_obj_id);

Can this be a verbose("verifier internal error: ...") + return?
Same for similar 'this should never happen' checks elsewhere in this function
and patch.

> +	for (i = 0; i < state->acquired_refs; i++) {
> +		if (state->refs[i].id == ref_obj_id) {
> +			WARN_ON_ONCE(state->refs[i].release_on_unlock);
> +			state->refs[i].release_on_unlock = true;
> +			/* Now mark everyone sharing same ref_obj_id as untrusted */
> +			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> +				if (reg->ref_obj_id == ref_obj_id)
> +					reg->type |= PTR_UNTRUSTED;

To confirm my understanding: since ownership of the thing this reference points
to has been transferred to the datastructure, it's now necessary to mark all
instances of the reference PTR_UNTRUSTED to prevent them from being passed
to helpers/kfuncs as the owning datastructure could make it dissapear
at any time? Or because arbitrary kfunc might mess with bpf_list_node internal
fields?

> +			}));
> +			return 0;
> +		}
> +	}
> +	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
> +	return -EFAULT;

You're returning -EFAULT here, but the fn return type is 'bool' above.

> +}
> +
> +static bool is_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +	void *ptr;
> +	u32 id;
> +
> +	switch ((int)reg->type) {
> +	case PTR_TO_MAP_VALUE:
> +		ptr = reg->map_ptr;
> +		break;
> +	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
> +		ptr = reg->btf;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +	id = reg->id;
> +
> +	return env->cur_state->active_spin_lock_ptr == ptr &&
> +	       env->cur_state->active_spin_lock_id == id;
> +}
> +
> +static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
> +					   struct bpf_reg_state *reg,
> +					   u32 regno,
> +					   struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	struct btf_type_fields *tab = NULL;
> +	struct btf_field *field;
> +	u32 list_head_off;
> +
> +	if (meta->btf != btf_vmlinux ||
> +	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
> +	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail] &&
> +	     meta->func_id != special_kfunc_list[KF_bpf_list_del] &&
> +	     meta->func_id != special_kfunc_list[KF_bpf_list_del_tail])) {
> +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> +		return -EFAULT;
> +	}
> +
> +	if (reg->type == PTR_TO_MAP_VALUE) {
> +		tab = reg->map_ptr->fields_tab;
> +	} else /* PTR_TO_BTF_ID | MEM_TYPE_LOCAL */ {
> +		struct btf_struct_meta *meta;
> +
> +		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> +		if (!meta) {
> +			verbose(env, "bpf_list_head not found for local kptr\n");
> +			return -EINVAL;
> +		}
> +		tab = meta->fields_tab;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> +			regno);
> +		return -EINVAL;
> +	}
> +
> +	list_head_off = reg->off + reg->var_off.value;
> +	field = btf_type_fields_find(tab, list_head_off, BPF_LIST_HEAD);
> +	if (!field) {
> +		verbose(env, "bpf_list_head not found at offset=%u\n", list_head_off);
> +		return -EINVAL;
> +	}
> +
> +	/* All functions require bpf_list_head to be protected using a bpf_spin_lock */
> +	if (!is_reg_allocation_locked(env, reg)) {
> +		verbose(env, "bpf_spin_lock at off=%d must be held for manipulating bpf_list_head\n",
> +			tab->spin_lock_off);
> +		return -EINVAL;
> +	}
> +
> +	if (meta->func_id == special_kfunc_list[KF_bpf_list_add] ||
> +	    meta->func_id == special_kfunc_list[KF_bpf_list_add_tail]) {
> +		if (!btf_struct_ids_match(&env->log, meta->arg_list_node.reg_btf,
> +					  meta->arg_list_node.reg_btf_id, 0,
> +					  field->list_head.btf, field->list_head.value_btf_id, true)) {
> +			verbose(env, "bpf_list_head value type does not match arg#0\n");
> +			return -EINVAL;
> +		}
> +		if (meta->arg_list_node.reg_offset != field->list_head.node_offset) {
> +			verbose(env, "arg#0 offset must be for bpf_list_node at off=%d\n",
> +				field->list_head.node_offset);
> +			return -EINVAL;
> +		}
> +		/* Set arg#0 for expiration after unlock */
> +		ref_obj_id_set_release_on_unlock(env, meta->arg_list_node.reg_ref_obj_id);
> +	} else {
> +		if (meta->arg_list_head.field) {
> +			verbose(env, "verifier internal error: repeating bpf_list_head arg\n");
> +			return -EFAULT;
> +		}
> +		meta->arg_list_head.field = field;
> +	}
> +	return 0;
> +}
> +
> +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> +					   struct bpf_reg_state *reg,
> +					   u32 regno,
> +					   struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	struct btf_struct_meta *struct_meta;
> +	struct btf_type_fields *tab;
> +	struct btf_field *field;
> +	u32 list_node_off;
> +
> +	if (meta->btf != btf_vmlinux ||
> +	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
> +	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail])) {
> +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> +		return -EFAULT;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> +			regno);
> +		return -EINVAL;
> +	}
> +
> +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> +	if (!struct_meta) {
> +		verbose(env, "bpf_list_node not found for local kptr\n");
> +		return -EINVAL;
> +	}
> +	tab = struct_meta->fields_tab;
> +
> +	list_node_off = reg->off + reg->var_off.value;
> +	field = btf_type_fields_find(tab, list_node_off, BPF_LIST_NODE);
> +	if (!field || field->offset != list_node_off) {
> +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> +		return -EINVAL;
> +	}
> +	if (meta->arg_list_node.field) {
> +		verbose(env, "verifier internal error: repeating bpf_list_node arg\n");
> +		return -EFAULT;
> +	}
> +	meta->arg_list_node.field = field;
> +	meta->arg_list_node.reg_btf = reg->btf;
> +	meta->arg_list_node.reg_btf_id = reg->btf_id;
> +	meta->arg_list_node.reg_offset = list_node_off;
> +	meta->arg_list_node.reg_ref_obj_id = reg->ref_obj_id;
> +	return 0;
> +}
> +
>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>  {
>  	const char *func_name = meta->func_name, *ref_tname;
> @@ -8157,6 +8393,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			break;
>  		case KF_ARG_PTR_TO_KPTR_STRONG:
>  		case KF_ARG_PTR_TO_DYNPTR:
> +		case KF_ARG_PTR_TO_LIST_HEAD:
> +		case KF_ARG_PTR_TO_LIST_NODE:
>  		case KF_ARG_PTR_TO_MEM:
>  		case KF_ARG_PTR_TO_MEM_SIZE:
>  			/* Trusted by default */
> @@ -8194,17 +8432,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				meta->arg_kptr_drop.btf_id = reg->btf_id;
>  			}
>  			break;
> -		case KF_ARG_PTR_TO_BTF_ID:
> -			/* Only base_type is checked, further checks are done here */
> -			if (reg->type != PTR_TO_BTF_ID &&
> -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> -				return -EINVAL;
> -			}
> -			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> -			if (ret < 0)
> -				return ret;
> -			break;
>  		case KF_ARG_PTR_TO_KPTR_STRONG:
>  			if (reg->type != PTR_TO_MAP_VALUE) {
>  				verbose(env, "arg#0 expected pointer to map value\n");
> @@ -8232,6 +8459,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				return -EINVAL;
>  			}
>  			break;
> +		case KF_ARG_PTR_TO_LIST_HEAD:
> +			if (reg->type != PTR_TO_MAP_VALUE &&
> +			    reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
> +				verbose(env, "arg#%d expected pointer to map value or local kptr\n", i);
> +				return -EINVAL;
> +			}
> +			if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL) && !reg->ref_obj_id) {
> +				verbose(env, "local kptr must be referenced\n");
> +				return -EINVAL;
> +			}
> +			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case KF_ARG_PTR_TO_LIST_NODE:
> +			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
> +				verbose(env, "arg#%d expected point to local kptr\n", i);
> +				return -EINVAL;
> +			}
> +			if (!reg->ref_obj_id) {
> +				verbose(env, "local kptr must be referenced\n");
> +				return -EINVAL;
> +			}
> +			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case KF_ARG_PTR_TO_BTF_ID:
> +			/* Only base_type is checked, further checks are done here */
> +			if (reg->type != PTR_TO_BTF_ID &&
> +			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> +				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> +				return -EINVAL;
> +			}
> +			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> +			if (ret < 0)
> +				return ret;
> +			break;
>  		case KF_ARG_PTR_TO_MEM:
>  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
>  			if (IS_ERR(resolve_ret)) {
> @@ -8352,11 +8617,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
>  
>  		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
> -			if (!btf_type_is_void(ptr_type)) {
> -				verbose(env, "kernel function %s must have void * return type\n",
> -					meta.func_name);
> -				return -EINVAL;
> -			}
>  			if (meta.func_id == special_kfunc_list[KF_bpf_kptr_new_impl]) {
>  				const struct btf_type *ret_t;
>  				struct btf *ret_btf;
> @@ -8394,6 +8654,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				env->insn_aux_data[insn_idx].kptr_struct_meta =
>  					btf_find_struct_meta(meta.arg_kptr_drop.btf,
>  							     meta.arg_kptr_drop.btf_id);
> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_del] ||
> +				   meta.func_id == special_kfunc_list[KF_bpf_list_del_tail]) {
> +				struct btf_field *field = meta.arg_list_head.field;
> +
> +				mark_reg_known_zero(env, regs, BPF_REG_0);
> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_TYPE_LOCAL;
> +				regs[BPF_REG_0].btf = field->list_head.btf;
> +				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
> +				regs[BPF_REG_0].off = field->list_head.node_offset;
>  			} else {
>  				verbose(env, "kernel function %s unhandled dynamic return type\n",
>  					meta.func_name);
> @@ -13062,11 +13331,18 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>  
> -				if (env->cur_state->active_spin_lock_ptr &&
> -				    (insn->src_reg == BPF_PSEUDO_CALL ||
> -				     insn->imm != BPF_FUNC_spin_unlock)) {
> -					verbose(env, "function calls are not allowed while holding a lock\n");
> -					return -EINVAL;
> +				if (env->cur_state->active_spin_lock_ptr) {
> +					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
> +					    (insn->src_reg == BPF_PSEUDO_CALL) ||
> +					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +					     (insn->off != 0 ||
> +					      (insn->imm != special_kfunc_list[KF_bpf_list_add] &&
> +					       insn->imm != special_kfunc_list[KF_bpf_list_add_tail] &&
> +					       insn->imm != special_kfunc_list[KF_bpf_list_del] &&
> +					       insn->imm != special_kfunc_list[KF_bpf_list_del_tail])))) {

There's some similar special_kfunc_list checking in 
process_kf_arg_ptr_to_list_head. Can you make a helper for this check?
kfunc_manipulates_bpf_list or something? Similarly for
KF_bpf_list_del{_tail} check in previous hunk, maybe
something like kfunc_acquires_bpf_list_node?

> +						verbose(env, "function calls are not allowed while holding a lock\n");
> +						return -EINVAL;
> +					}
>  				}
>  				if (insn->src_reg == BPF_PSEUDO_CALL)
>  					err = check_func_call(env, insn, &env->insn_idx);
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index c47d16f3e817..21b85cd721cb 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -52,4 +52,32 @@ extern void bpf_kptr_drop_impl(void *kptr, void *meta__ign) __ksym;
>  /* Convenience macro to wrap over bpf_kptr_drop_impl */
>  #define bpf_kptr_drop(kptr) bpf_kptr_drop_impl(kptr, NULL)
>  
> +/* Description
> + *	Add a new entry to the head of the BPF linked list.
> + * Returns
> + *	Void.
> + */
> +extern void bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
> +
> +/* Description
> + *	Add a new entry to the tail of the BPF linked list.
> + * Returns
> + *	Void.
> + */
> +extern void bpf_list_add_tail(struct bpf_list_node *node, struct bpf_list_head *head) __ksym;
> +
> +/* Description
> + *	Remove the entry at head of the BPF linked list.
> + * Returns
> + *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
> + */
> +extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head) __ksym;
> +
> +/* Description
> + *	Remove the entry at tail of the BPF linked list.
> + * Returns
> + *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
> + */
> +extern struct bpf_list_node *bpf_list_del_tail(struct bpf_list_head *head) __ksym;
> +
>  #endif
