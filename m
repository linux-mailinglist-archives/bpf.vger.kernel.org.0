Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6B60D1A8
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJYQdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJYQdL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 12:33:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026418E713
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 09:33:10 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PBssdb015354;
        Tue, 25 Oct 2022 09:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tVTe7MhejwTJzSxveRfB+aVlgI18zDy3QElEYoS6W5g=;
 b=dGoU7Pc4z/RepTGQSdV4Mnc+IsoJXpMvT+3Z8+3XuqYiWnpizqtg+eUJFHrcwvpwSgTT
 vG+3T4W9Ka9cN1d8nY9IgJ6on+SzTXQA3zwvlOdfP/+QzLnVQJ1ykvWOW+9ocIwnkbnw
 EoauH9mYehGaxR09Qu7wSbs4amSaWccjSvevaFIproDZL8CIFy/n9G0C4/akjIx+GpoK
 zyW2MpuX78MVwDXdvGJZDySgpYajtbkD6A7luYjE/WEn73Jepdnzy5ctt196MtQ2EuID
 4yMflfJJyUEdIkMtlgdtYI48YJO/2naAI+gscrL+NUbJVEsgOn6lRgZsZuBF1IX+Gs3y +A== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kefbfay4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 09:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P146g9ZIidg6G5ZbpmwbyQlxbIZnIHD5ZYMxFRpV4KMDK5gRdnqHN3zR1MuWg/JOeJNetiFS6E5B3plO53pCbh2eunwdMR8jV37/NFulYvlVzloltl3IJAb/xDBiYfT4CvYWe52Ns5p7nbjtTvL4yK2L5DhCG+My2sQm4p7gziCBuXjBS1YkxlW0Xgz0AxE9/+2vjQ2FKjN7gGjW+qsYkKCCW01DL9OmZUBu9RG+dljpmeFc8rWCmIfAdrp1rTiC7aRT7o5yROhj5fXxUQ6u9k1tPCtZ8H8MAnIQcbMJW7UGhrvyjbLJG1O4Qd75gBbmGsxsr7DtSE7ryo0NaNiz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVTe7MhejwTJzSxveRfB+aVlgI18zDy3QElEYoS6W5g=;
 b=cguDmd63MFB+vBPj0qWIBQ4QU13+qI7BfwT/f9Hby5FKKAF7xg9GtnRQDZmM85eGLMyct8vbd9+ABfESUNv0HVsVQgcniTGp+FA7S07wLE6NtwGAGiXdLvCnN0U+Y+zg6J8KVZKH+BtMJ+ejbOd7t12vvu0WOaEde0cL4+OgiDs18Dsl+kOREOJ91mI0GM1yy8rc+8pqeYd9xLnJnekftRi7/9KMtN4QzcsBGpUb/f8ConNcOf0OAl3/7Lp29Z1cyAuO+l9G2XuijFGxW2DLHfmgO7vykQprnGLD66MwZp1hCGyby+Ws35V3v4kb0QxSt0Yfznba3XwXw06TUHNr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN6PR15MB1265.namprd15.prod.outlook.com (2603:10b6:404:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 16:32:51 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%8]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 16:32:51 +0000
Message-ID: <bf1c4d27-e2e0-2309-d2eb-f83e5a387adf@meta.com>
Date:   Tue, 25 Oct 2022 12:32:49 -0400
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
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BN6PR15MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bd8c91-4cf4-4a25-6317-08dab6a68f22
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOvbTsaXI3L4EAsKwpkOdAHD1PzmdH35gLzSIkXA3FDSA+TbvrqNL8iqoqMkVIG9upA+5t0FOJw1W90Re9k0g9xtfb8dErIsmf+NIPjmzDbAm4MQxThBUM6FDRlKYZJ3uFzQ9+TSbatOl48UIcdQbTkxzp0adOJB8lTPHrdoWakGguZRGmxzKj9FhenyDBkK7adBWCIjS0xuUMDUIwIYiViWwYTqsHaiKMihmiBkdQCbIrKGHGZhyrmKqFF830fTeRaSx/kCb2VpgQYmN/m4rIAXndLKb0vGdtFemY1d9Yrkm2H55gPTa6hGHz+MBRWKbbwxNdixXFpBUjxXe6meUxM4hGk+KzIgnGI+8Q9yyJupDYeuqqbDSt9dfK+4dHNrZuY+/e4f2+uPBL77H8IVofa6CInIWXu7ClhE+MMYuSsfVChHxuinXJSPC4TLghV5OvhuQuGzFQCC2HUg/GWWuIDSecND3APb/+ze8aU80X1rDdEFxP9iRxd/YKDu85DOxMqGIBrp8p45pDKvvsb8wHswS8cvr7YOMSyvYF/o43x0KyR1w7cfAvj6RmGGguOCbAp8G9rZkXiuxieldR5rXvvSmp3d8rorjxRfgkZ+Q3Aed6c3mcxx0YNJj+QR+aMaXXMq8lwQ7V/mkX9TkzHsDEj9Dv2HdNbDnuH0SOIXI8lNjMYuX+rFqKAoJZyAxaGhswRJCsSUlkPIluOQUY5jdey28uqDrDRWsRO1fiJ6IBYebjMnaIw5wPsoMKSJ8YL/VTpSfr5vVgdRIy9piXeRxx364wQYR8eO5hJh3CmfAjB8GylhMOubaSbX8Qf5FYYo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(83380400001)(86362001)(31696002)(38100700002)(8936002)(5660300002)(66946007)(66556008)(66476007)(8676002)(41300700001)(4326008)(2906002)(53546011)(6506007)(107886003)(2616005)(186003)(6512007)(54906003)(316002)(478600001)(6486002)(31686004)(36756003)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5qWGNTMmtxc0VwMEljOFVlNEhvNExsczhrRjRsVVEzSnNtaTRaemRvOUxa?=
 =?utf-8?B?Y1RKTHcrSnJ6RTFFNGhaUXUrdkxJK2R1SWplQ1R3TVljZTZuVW9BZ3dCUjhw?=
 =?utf-8?B?YUQxNVIyeHhOWW9SdzlGTk1JazlmLy80cjVqc1pwVlRYOHNBVVoxc3lVc3VQ?=
 =?utf-8?B?WVpuV3A5MFdBZDVBdUUvbktGK2RMS1h4LzUzVVRFbnpiNms5QklRNXpONzdV?=
 =?utf-8?B?d2UzUTMwRlAyRjFQRGFZSzk2VnRlTXpBSFJIUzJ1aXRqOXhzSzN6WnR2R3Jl?=
 =?utf-8?B?cTU2NVBLZThySXZOQWh2Tm1uR1o3SXJLQVB4WmhsSDBEcTVkOXVsU1FvaDJq?=
 =?utf-8?B?OGx1V0doWTJTUFplNU8zYkw2aGdFQTlsT1BYMVpQaFB6eDdrbFlqQjN2aFNE?=
 =?utf-8?B?R2crL3FnTHBiRWdSNlBDL0RkdVFqYWhRMWg0bmNtWGQ2WXJCajFtbXk2eFBW?=
 =?utf-8?B?VVFBZmJKejZwcHFrTlg1ZTFtMzNRNWpsaUxLR0d0RXdPWlppZ3ZMYVcxcyth?=
 =?utf-8?B?RG5kK2tYWi92OS9UVHIrZ2xlb1dMVXE4SnJvVkJJa1BaZlpkN3FOb0p2bEM1?=
 =?utf-8?B?alM0TjJTdVR3ZHVLM1ZMOGRka3h5S0x6Zy9OUDhDUm52Ykw4V3kxVStKdW5q?=
 =?utf-8?B?aEJrMW5GbTN3TGhyV2t4bWQxenA5VHdkMlV2Skxzd3o2cHk2U1YvWGh6Q0Zm?=
 =?utf-8?B?R2g0RlU2dTA4QnJDaXU3TnRYamZ6amJHVU5jRUNWRjVLUmJvaDdmeGZNbmRN?=
 =?utf-8?B?cE00RjJ3eUhCSkY5cmNqd1UzZHgzaGtrM3JBMEUrWnh4OW11MUhQU2t3WFFa?=
 =?utf-8?B?cWthcXd6S295VVlSL0d1T250eFcxLytLSHArem02Y1lUNC9Ib2djK0taOTBv?=
 =?utf-8?B?czM5QnhQdnV0aS9WVGVrL0xvaEJmSmN2THdiNERzeEFPMi9wS2NMYktNMkpB?=
 =?utf-8?B?RUlTL3VyZDc3VFNibmpiMGZORVdHazQrVm5QWnZGVXc1clhhQ3IxRE1JemZO?=
 =?utf-8?B?UnI0WlpwS1RNSEtkaGdRRUFUM3BOLzBPUUFkYnpEREx6R29rUnZjc2VtSzVq?=
 =?utf-8?B?KzM0aERXSUM2ZVdIU2twZnkrRFNEVWFFQnRKNlgwMTJUdDJZOVVRS3lyVDRE?=
 =?utf-8?B?THQvdndMMUZNVWpvdTVZbW81NVNYZXgwRVhFRHVZN0h5c3ZJTlRRYUtjdlBv?=
 =?utf-8?B?aHhvNE1ZeGZWTC8wYnFIVWU3NzFpMTJaNWJ6ZysxUmdwd1REaEZvV3JHd0x0?=
 =?utf-8?B?YnNoclZBbWdsdDRJemJwZFNTMW52dUtKUHFIUnNBV2tNMUpWZ3ZZVnUvaDJH?=
 =?utf-8?B?MGl3Y3VOaU9VWDhyOWg1a2hNRGJudjgvOHdHSDR5cDBiNmJhSUZOV3RXTHV1?=
 =?utf-8?B?aFUxQzFNWlFZOUJPQjhxcjgyOFUyR0ZjRC9YZVM4dHJJVGNSdk01OWVKL0Yx?=
 =?utf-8?B?OTlHUVBYMzMzaEcyeG5wUm0yeVZiWGNqMXFxUVVlMkZlYWozRVQ4S01Yb1FV?=
 =?utf-8?B?U21ST3lERXdrelFOWjJvSmtSZ0FqM2t1ZWVkVzZ4WlFqWjRPMVh0aEJCdldQ?=
 =?utf-8?B?c1NxSWJKMS9OVFlFbTQwUllkR2dRcTRGSW5oSDVoZ1REcVZ5MHZZQjIxOXNO?=
 =?utf-8?B?MHY1RkdtMEd3Q21XZUFFYzh3Q08zZkxyWCtLOU82akhZd0RHOXFFbGxqbHpt?=
 =?utf-8?B?bXdYeWRWczRkR3FoN0JlTlhDeTBDZXNvQzlVOHJGY1BqTkh5dm94anJjZXBi?=
 =?utf-8?B?MXhkYkJUNjN3RUkvbUVQay9GbUJ1bWR2TW1IRlY4Y2hEUVc1eUZjYjFvQzBu?=
 =?utf-8?B?bDQveisybU9YOFVwYzZNWkNFUElwQXJVSzVoZjhDNFg1Z2cybzBZc0k2blMz?=
 =?utf-8?B?NklSSGR3c1lubzI0c2ZYc2k5c25tZE9SYWV2K2lmMkFxM210cFlxY292Nzlm?=
 =?utf-8?B?SG4rTEZkb0N2dldyVFVuMVlURGRpdEZ4VWlYRTFnTTRET01Kd21MSnVrdzJ2?=
 =?utf-8?B?WFRzMndndUt3N1orM3F6YlgyeVNmYnQvamdLbHFVQklrWGt5TUZCeXB2dnZH?=
 =?utf-8?B?dDBNeTN2bVZOejRXUkxLR2NQOS9MNGhMcGd4Ni9DRDQ4UWFxZ3pnNytVM1hW?=
 =?utf-8?B?MDc5bVF4K1hyQ05SS0cvQXpEVnhpWTBiWlliWDFtUFRINS9NcTBqQXFsKzA4?=
 =?utf-8?Q?FVdkyd82HoOaHUWr+m3e3Ls=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd8c91-4cf4-4a25-6317-08dab6a68f22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:32:50.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ci7/zYfx95W+W7VDn1XJ6nw8ec0g5z1fqnzzEIli4D9PlXfmHx0x7gRuWPTcy02l/J4AYa+czid7k7BzaTpu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1265
X-Proofpoint-GUID: 0mF3wPim_tPd6Nplmar-oe1TWaXJ8BbM
X-Proofpoint-ORIG-GUID: 0mF3wPim_tPd6Nplmar-oe1TWaXJ8BbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_10,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

One nit unrelated to the other thread we have going for this patch.

[...]

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

Can you add a type_is_local_kptr helper (or similar name) to reduce this
type_flag(reg->type) & MEM_TYPE_LOCAL repetition here and elsewhere in the patch?
Some examples of repetition in verifier.c below.

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
> +
> +		ret = btf_struct_access(&env->log, reg, reg->btf, t, off, size,
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

[...]
