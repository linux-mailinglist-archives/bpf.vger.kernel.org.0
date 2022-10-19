Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E6604E59
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJSRPq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJSRPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 13:15:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F51127437
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 10:15:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JGXrtJ018229;
        Wed, 19 Oct 2022 10:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Kc1c553yD10HJcOoIhWEZbo+Nnsc3W1dcyk3hQq6nJc=;
 b=QgxgHLBVqVyON8qWi8llOHiXxxZZCJ79v9rdrmf2XQm+MHGHvmRvf/6jO92nSkxDa4Se
 Laj1O5uwSOpym5pLe1a7KlIMsAK7JPcdSYIE/mIiaUDJWShmEbF9io9KcArBO6OcgG2l
 4hLfpEzSUejlNqGMK10kH2N9lLVWjnQC0/SB5xwXXAPce/3XZ7VihiW+vrNUKWdjOXWl
 0j6gBMG5o+VYY6YI5YUUPRU2oi45Apkbgu5Ymrc0j5FoEKbP5X5ebXBshU80+XtrJTz9
 COO7+kaJcrAoNoWj3pI3nyKP4AGi+x6YGhkZ+EpbJaSWY3BPqE3/Ut8ePAxSpjyIlYn0 5w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kag05un3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 10:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGKWgYO6TJEa3ZInUBZIhCQqjbd3CC9LRWtoMTRLIcyFj6Jny2HhxFD1c5FPR+12suC5IwJqCg+BsKMhYKEfBniYliCjpD/kNF9Ysk/7i4hiTa3biRYS0AwHrreRFiujKLe0q+clRVrq9cDn5/9fx7JmCOVDga4ckCtwX8Gy1hqPOxhY+YwU7CtUlVWqk1lQ1RlNM8IHNYBIH+m0xlgagFKLouAUHtGhS+KUQKhxR0SAmNP9mtwe+ram8EGkG9/xGDaNMrDg0gXxZyC5exCOdd8PSEsNO39yDcHTYnHLYArUxx9xKjWV6ZCzMCPRSQUFWDupBwygMcPw5cicxAy4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc1c553yD10HJcOoIhWEZbo+Nnsc3W1dcyk3hQq6nJc=;
 b=k3JoQWnpIrtpCImlKLBc3RZNB9r3zcH5ohNafaeEjWrQwF59iMH23Z3Ay5PnuY1XpyiTEdn1VSCQlUm/bX6R0imefqNWqx6BZYbF++9b7dm/OjunAniqiR1PLtSdWnnkYF66iVIVT5SZszmFWlG1A4v4FO7GSR1x8IV8Jzwckd1+MXUPaUE8r0daYGLb41wgz/l9PGxul5RlpKD2mrEmhf9iAh8xIKNIOcgIYKAknMYlcfpiHw3fkn/XatLrg0cX7C8X8D+T4GXD+xzfRmsSzL9fNlwkVtQJ5FzSSKzyqM0luS6j7f+NwLrAghWB1MftM54R29D4dR2Hicwru7tl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN8PR15MB3138.namprd15.prod.outlook.com (2603:10b6:408:88::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 17:15:24 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 17:15:24 +0000
Message-ID: <582912fa-3d32-7c5a-cf24-fc79899a2e31@meta.com>
Date:   Wed, 19 Oct 2022 13:15:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next v2 10/25] bpf: Introduce local kptrs
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-11-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221013062303.896469-11-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BN8PR15MB3138:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f7ab38-498c-43ba-e5da-08dab1f582bc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDKaOsF557/YMchz5Ejglc84vO7gzKNwpfj6gCY0KY/Ycj5iL0E2TWh4TDSro7m4YRQn7CoA4H9Y3oNfQ7LlzzKUn4WspCcLLPPVZ+2+hXlt6afDPFB6yG4+POvbNhneKVwV85JGL9I09j1Gu4CZ7ZDymbyTL9bV6W/WHV9Pr/DfsJFK1PQi2z0SUWYK7jVqtbSh0wDwO+rYt95x6yY2V7bZZUtSs7xUmnwtf//5dUBsd821xGLCwVEuNvRhJ4+MKU7Y2KcFd3fyNU7TcttpAIxlWbOrnWfYlyorlCjRWJoBEoRj0dhbIIWMz/xD87WwjS4JbHF6ht+JwLlboLL4xDX5AxHGyJ4U4qUmRvbdfnl3eaXwUrMagmLty3dCbvPLhyMLz45faLzGhcn/G7mDk9Sw4jYZGjd7Ac8nLzNeTMnfZDZyj6XaqWlJS/Xr5I8hX10Qm8NtGxmA5QBn3XYd+RtAFgqjyTB/Jw6ERebyR+Pk4411yssdLjji9XznbrI3NF283BW9NIkQcJlpwRTYfwgADYFRk13EFcdBG06XenlHeOY0o9ZYIAiwyV3+Lx0oBBg6phTGM+40Q9y2F7HsiGFj3KlKxKeNYE6cLdhQMWGM4iAG0isi1LxVSr+rwCJFCRnhrbgjRoKcQS5LcVD7Pa6GdtHztSSyqI01i85Ed6aV/8d+NXCguk5Msu6qPFoD/Y6XAMxJMPisfyc9oeHXxRAZtqmdLfNbKNkUAOH0QkTTFnd+pCPlHSvldzpSa/ximBwtMFhd22vvD2NYWlwoOvc6UhtxlF1lFnf31NY9dDzRL2/+2poZeXuKaAcPntm9UhakCloJ76ytg9Thk6J2GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(54906003)(186003)(316002)(2616005)(6506007)(36756003)(4326008)(30864003)(5660300002)(86362001)(8936002)(6512007)(2906002)(53546011)(83380400001)(41300700001)(31696002)(66556008)(66476007)(66946007)(107886003)(8676002)(31686004)(6486002)(478600001)(38100700002)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZQZlVVaEt6MlZmVzkwMUNiM3MzZGJ1aWllSHE1Z3RJMmF4c3V3SEswMVVh?=
 =?utf-8?B?OXQwRHE2alQrMXgzeDlkT3owbHhlK3R0RUpnZElWWHR6cHBzTTZFVUxQNHpo?=
 =?utf-8?B?VTVrV2NXa2ZxOXF2OVFFbkZQMEhUY1lwNGJUWVZ1WXRjMk5xSW1OY3o4Ym1n?=
 =?utf-8?B?YXVoWE5iVE9DVE5uZ0M4eEV2d3ZZM292WmdFblUzMmhYTmYxTkF4Z3lqM09t?=
 =?utf-8?B?RytvUkNDOXA5eHd6MjN3WnhhTExmTGhuN1FNRlo4eEowL0hTbG50QkVsWDZa?=
 =?utf-8?B?UDVrMmFDZTZSelVrZGdSTUl4aUllQWFCZU9Fc2Rlb3lSTm5aQlZHKzZxcmM1?=
 =?utf-8?B?UjZVLzZ0aXRySzBWd3AzWGxjcWVFSFZ0TDRWUi9zTzJUM3pKdFpnTjlnUmlX?=
 =?utf-8?B?SUg5YmNDMFRXS25YNFZ1dXBtRTBYc01MVllFNGkvb3RsR0ZFeExJdmZmTkJD?=
 =?utf-8?B?NGROSlc2NE9Fem8zYkpNWmVuQnRrYnJ3TWh4V3JHaGN2ZCtqWU53dW01d3lp?=
 =?utf-8?B?WDM5a1J2eUJDRlBocjd2MVUrSXV6bDRHUzBMeENYaFhPV2NSdmJIQTFqVTQv?=
 =?utf-8?B?RzFRQUNuSDN3RTl0M3VOUmhSMGErUWJVQ2ZDNzhRVVBQNkhwcGp2K2dQb1kv?=
 =?utf-8?B?UCs2UDdOY0dPRmNmK0g3ai9vaGdaaXpqY2V0TzMzUjlPeEEzT3lMR2o0dkJT?=
 =?utf-8?B?NUFLVEFzVkFKRzAwTkxobGVndzY3MmdGR1N2UlU5MzhVS3hmR2E3M0xLREdS?=
 =?utf-8?B?blhXbWMrTTk0R2lLSzhlRHVVRWJLOVp5QmVZTWF1VGtGdjVHK3B1RVR3RnBB?=
 =?utf-8?B?TlRpMjQwc0dKdmNpS3ZpNXRVOEtRRnUwK05lVkVmanRaY255SGhLN0tkK1I1?=
 =?utf-8?B?YjRnVU15Z0p3OWVjVldPTkVid01uRzN4SWtkZmZGL2RXZ0k3Zml6STFicHhn?=
 =?utf-8?B?R2U0cmxoUUgyMkhHSmRUMldDS0ljZkQrc0k3K2haVFdJZFFOL0dnaXpxWFRI?=
 =?utf-8?B?eTdzancrZmNCYVk2NG9oMVE2V3hYU1lzQ0MrZUR1cDJZNElyUVRmRW9wRkJM?=
 =?utf-8?B?M2xXWUtZNjJjQzhnRmJLcFRPcWtNZnBnOGYxMXB0MU44bEY4aE8rbWN0aDFC?=
 =?utf-8?B?UXR0QlkwMGhWSUk0cFF3RVU2MW1PNW9oNVdOdG5LOFI2Znc2bVdTRTNGTEpJ?=
 =?utf-8?B?dk1ZUkJkSEFyN1lLaS8xWUFHVVkySWxrTDQvaUZqSW9EYVY1QVRsMEZFVjl2?=
 =?utf-8?B?MlVib2hqTGJXbnRnOEQ1ZU1ISzEza21ZN1lmbzByOFA4akdYeXZsaitxMXc2?=
 =?utf-8?B?L0MvZE5vSXl5ZC9JMEt3cklodU1kYy82bmx6S01LU2lHMXE5bHEyMElNYUg0?=
 =?utf-8?B?WHF1M2JTYmIvMTNFVU5PR0dzTnFpQXljNnNDcjZsS09DYjhjR252THlpUTZ1?=
 =?utf-8?B?UzJiOTFMVGE2ZUJRRmdQaElYOTJHWHR6NlA2TDRaRjZscGtKdXplNFFIdUNB?=
 =?utf-8?B?dlE4TzhxSlM3TEIrZDZUUGh2UVRkNkRLajFuTE5ybFI1V2RqK2NjcG9VSWVa?=
 =?utf-8?B?Mlo0d2FQS1pwVW9tVFBmRGxtK3hlTjc0UUZJcTJaNUFsMERVWkhKekd0U1Z2?=
 =?utf-8?B?K3RuL2p4WXYvWUN2WGQyV1lSZzFVWDQvQ2g4bFc4UVNNZ0NKcENUZG55TWRw?=
 =?utf-8?B?cDJPV1RFaVB2L2k5MWxXQ2ZObHJLT3dpZTVvKzlhRXFMeDkyc2c0V0R2Zk1h?=
 =?utf-8?B?RVg4OTFQc0ZtUnJmRlNwZWlCaXZLUVNsMzRCNFlrenRIVGdjMmZmSk95dUpX?=
 =?utf-8?B?Q2NDTjVzeld5a1NjcE5HWUZWMHRlUENBa2IvQzBIbWI4MHBhTmlWdVo0TEFy?=
 =?utf-8?B?a2pvVjZNTnJqUGJwRFNJSlJkb2FuS2crUkl1TEVJaE81c0NXYlRWQmlaVVNK?=
 =?utf-8?B?RUxzNXZSNWpZU09ZdTRJWEQ3LzFIMFA5NS9lbVhxODViZ2dRVnlqa3NmWG5k?=
 =?utf-8?B?djV5N0FobGQ3OXUweXp2TTg2dkdxbWpnRXJQSzNtdjhyQ1paaDUyS0xtN2o4?=
 =?utf-8?B?ZXErL0xvRWwwVU5sQ0wrTGtkQXg0SDRKUzlhWkZKSjZzSFM0TG0rd3VrWktz?=
 =?utf-8?B?S3BwdFVnTUVOSG5Pdmwxcm14Tjg1Y0YxWS9zT3Q1UEszZXl3RVBRdXFaTGgv?=
 =?utf-8?Q?7MzydDjl5JBqaara4YB02QA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f7ab38-498c-43ba-e5da-08dab1f582bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 17:15:24.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vn/7hC74VDB5GfUL92lHBp+LdebzjegSUJmdez/XB47HclxEOP4kbl8cCQRB3gN6lg6DGbeSXPa62622jXvDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3138
X-Proofpoint-ORIG-GUID: 9dck2Y7gQkgDrsH8Yn-wPZzI6SDHsdcK
X-Proofpoint-GUID: 9dck2Y7gQkgDrsH8Yn-wPZzI6SDHsdcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_10,2022-10-19_04,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
> Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
> type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
> type tag in reg->type to avoid having to check btf_is_kernel when trying
> to match argument types in helpers.
> 
> For now, these local kptrs will always be referenced in verifier
> context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> to such objects, as long fields that are special are not touched
> (support for which will be added in subsequent patches).
> 
> No PROBE_MEM handling is hence done since they can never be in an
> undefined state, and their lifetime will always be valid.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h              | 14 +++++++++++---
>  include/linux/filter.h           |  4 +++-
>  kernel/bpf/btf.c                 |  9 ++++++++-
>  kernel/bpf/verifier.c            | 15 ++++++++++-----
>  net/bpf/bpf_dummy_struct_ops.c   |  3 ++-
>  net/core/filter.c                | 13 ++++++++-----
>  net/ipv4/bpf_tcp_ca.c            |  3 ++-
>  net/netfilter/nf_conntrack_bpf.c |  1 +
>  8 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 46330d871d4e..a2f4d3356cc8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -526,6 +526,11 @@ enum bpf_type_flag {
>  	/* Size is known at compile time. */
>  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>  
> +	/* MEM is of a type from program BTF, not kernel BTF. This is used to
> +	 * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
> +	 */
> +	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
> +
>  	__BPF_TYPE_FLAG_MAX,
>  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>  };
> @@ -774,6 +779,7 @@ struct bpf_prog_ops {
>  			union bpf_attr __user *uattr);
>  };
>  
> +struct bpf_reg_state;
>  struct bpf_verifier_ops {
>  	/* return eBPF function prototype for verification */
>  	const struct bpf_func_proto *
> @@ -795,6 +801,7 @@ struct bpf_verifier_ops {
>  				  struct bpf_insn *dst,
>  				  struct bpf_prog *prog, u32 *target_size);
>  	int (*btf_struct_access)(struct bpf_verifier_log *log,
> +				 const struct bpf_reg_state *reg,

Not that struct_ops API is meant to be stable, but would be good to note that
this changes that API in the summary. 

On that note, maybe passing whole bpf_reg_state *reg can be avoided for now
by making this a 'bool disallow_ptr_walk' or similar, since that's the only 
thing this patch is using it for.

>  				 const struct btf *btf,
>  				 const struct btf_type *t, int off, int size,
>  				 enum bpf_access_type atype,
> @@ -2076,10 +2083,11 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
>  	return btf_ctx_access(off, size, type, prog, info);
>  }
>  
> -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> +int btf_struct_access(struct bpf_verifier_log *log,
> +		      const struct bpf_reg_state *reg, const struct btf *btf,
>  		      const struct btf_type *t, int off, int size,
> -		      enum bpf_access_type atype,
> -		      u32 *next_btf_id, enum bpf_type_flag *flag);
> +		      enum bpf_access_type atype, u32 *next_btf_id,
> +		      enum bpf_type_flag *flag);
>  bool btf_struct_ids_match(struct bpf_verifier_log *log,
>  			  const struct btf *btf, u32 id, int off,
>  			  const struct btf *need_btf, u32 need_type_id,
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index efc42a6e3aed..9b94e24f90b9 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -568,7 +568,9 @@ struct sk_filter {
>  DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>  
>  extern struct mutex nf_conn_btf_access_lock;
> -extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
> +extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
> +				     const struct bpf_reg_state *reg,
> +				     const struct btf *btf,
>  				     const struct btf_type *t, int off, int size,
>  				     enum bpf_access_type atype, u32 *next_btf_id,
>  				     enum bpf_type_flag *flag);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 066984d73a8b..65f444405d9c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6019,11 +6019,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  	return -EINVAL;
>  }
>  
> -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> +int btf_struct_access(struct bpf_verifier_log *log,
> +		      const struct bpf_reg_state *reg, const struct btf *btf,
>  		      const struct btf_type *t, int off, int size,
>  		      enum bpf_access_type atype __maybe_unused,
>  		      u32 *next_btf_id, enum bpf_type_flag *flag)
>  {
> +	bool local_type = reg && (type_flag(reg->type) & MEM_TYPE_LOCAL);
>  	enum bpf_type_flag tmp_flag = 0;
>  	int err;
>  	u32 id;
> @@ -6033,6 +6035,11 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
>  
>  		switch (err) {
>  		case WALK_PTR:
> +			/* For local types, the destination register cannot
> +			 * become a pointer again.
> +			 */
> +			if (local_type)
> +				return SCALAR_VALUE;
>  			/* If we found the pointer or scalar on t+off,
>  			 * we're done.
>  			 */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3c47cecda302..6ee8c06c2080 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4522,16 +4522,20 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> -	if (env->ops->btf_struct_access) {
> -		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
> +	if (env->ops->btf_struct_access && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
> +		WARN_ON_ONCE(!btf_is_kernel(reg->btf));
> +		ret = env->ops->btf_struct_access(&env->log, reg, reg->btf, t,
>  						  off, size, atype, &btf_id, &flag);
>  	} else {
> -		if (atype != BPF_READ) {
> +		if (atype != BPF_READ && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
>  			verbose(env, "only read is supported\n");
>  			return -EACCES;
>  		}
>  
> -		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
> +		if (reg->type & MEM_TYPE_LOCAL)
> +			WARN_ON_ONCE(!reg->ref_obj_id);

Can we instead verbose(env, ...) and return error? Then when someone tries to
add local kptrs that don't set ref_obj_id in the future, it'll be more obvious
that this wasn't explicitly supported and they need to check verifier logic
carefully. Also rest of check_ptr_to_btf_access checks do verbose + err.

Similar for btf_is_kernel WARN above.

> +
> +		ret = btf_struct_access(&env->log, reg, reg->btf, t, off, size,


more re: passing entire reg state to btf_struct access: 

In the next patch in the series ("bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs")
you do btf_find_struct_meta(btf, reg->btf_id). I see why you couldn't use 't'
that's passed in here / elsewhere since you need the btf_id for meta lookup.
Perhaps 'btf_type *t' param can be changed to btf_id, eliminating the need
to pass 'reg'.

Alternatively, since we're already passing reg->btf and result of
btf_type_by_id(reg->btf, reg->btf_id), seems like btf_struct_access
maybe is tied closely enough to reg state that passing reg state
directly and getting rid of extraneous args is cleaner.

>  					atype, &btf_id, &flag);
>  	}
>  
> @@ -4596,7 +4600,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> -	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
> +	ret = btf_struct_access(&env->log, NULL, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -5816,6 +5820,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 * fixed offset.
>  	 */
>  	case PTR_TO_BTF_ID:
> +	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>  		 * can be non-zero.
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index e78dadfc5829..d7aa636d90ce 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -156,6 +156,7 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
>  }
>  
>  static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
> +					   const struct bpf_reg_state *reg,
>  					   const struct btf *btf,
>  					   const struct btf_type *t, int off,
>  					   int size, enum bpf_access_type atype,
> @@ -177,7 +178,7 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
>  		return -EACCES;
>  	}
>  
> -	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
> +	err = btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
>  				flag);
>  	if (err < 0)
>  		return err;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bb0136e7a8e4..cc7af7be91d9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8647,13 +8647,15 @@ static bool tc_cls_act_is_valid_access(int off, int size,
>  DEFINE_MUTEX(nf_conn_btf_access_lock);
>  EXPORT_SYMBOL_GPL(nf_conn_btf_access_lock);
>  
> -int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
> +int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
> +			      const struct bpf_reg_state *reg, const struct btf *btf,
>  			      const struct btf_type *t, int off, int size,
>  			      enum bpf_access_type atype, u32 *next_btf_id,
>  			      enum bpf_type_flag *flag);
>  EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
>  
>  static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
> +					const struct bpf_reg_state *reg,
>  					const struct btf *btf,
>  					const struct btf_type *t, int off,
>  					int size, enum bpf_access_type atype,
> @@ -8663,12 +8665,12 @@ static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
>  	int ret = -EACCES;
>  
>  	if (atype == BPF_READ)
> -		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
> +		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
>  					 flag);
>  
>  	mutex_lock(&nf_conn_btf_access_lock);
>  	if (nfct_btf_struct_access)
> -		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
> +		ret = nfct_btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id, flag);
>  	mutex_unlock(&nf_conn_btf_access_lock);
>  
>  	return ret;
> @@ -8734,6 +8736,7 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
>  EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
>  
>  static int xdp_btf_struct_access(struct bpf_verifier_log *log,
> +				 const struct bpf_reg_state *reg,
>  				 const struct btf *btf,
>  				 const struct btf_type *t, int off,
>  				 int size, enum bpf_access_type atype,
> @@ -8743,12 +8746,12 @@ static int xdp_btf_struct_access(struct bpf_verifier_log *log,
>  	int ret = -EACCES;
>  
>  	if (atype == BPF_READ)
> -		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
> +		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
>  					 flag);
>  
>  	mutex_lock(&nf_conn_btf_access_lock);
>  	if (nfct_btf_struct_access)
> -		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
> +		ret = nfct_btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id, flag);
>  	mutex_unlock(&nf_conn_btf_access_lock);
>  
>  	return ret;
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 6da16ae6a962..1fe3935c4260 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -69,6 +69,7 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
>  }
>  
>  static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
> +					const struct bpf_reg_state *reg,
>  					const struct btf *btf,
>  					const struct btf_type *t, int off,
>  					int size, enum bpf_access_type atype,
> @@ -78,7 +79,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
>  	size_t end;
>  
>  	if (atype == BPF_READ)
> -		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
> +		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
>  					 flag);
>  
>  	if (t != tcp_sock_type) {
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index 8639e7efd0e2..f6036a84484b 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -191,6 +191,7 @@ BTF_ID(struct, nf_conn___init)
>  
>  /* Check writes into `struct nf_conn` */
>  static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
> +					   const struct bpf_reg_state *reg,
>  					   const struct btf *btf,
>  					   const struct btf_type *t, int off,
>  					   int size, enum bpf_access_type atype,
