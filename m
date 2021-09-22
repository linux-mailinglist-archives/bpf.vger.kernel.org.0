Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96A413F1B
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhIVByv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:54:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232593AbhIVByv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 21:54:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEiQA020443;
        Tue, 21 Sep 2021 18:53:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q3I2hhcSM6gKPZkiK9wrmltteg/xze5ksYIQdkt5pb8=;
 b=EItPLayeHGJJMmlC9uRnpixXbrmCS72v2Ka05kDWGOeBWmBnUtef2K+PXmzOxyce4BPq
 ujHeksCGjN2jgswOIVkgR4HeBtHpgAQ92neChqz+JcGACfDfODwkfoW5z6m+9tVetvtY
 yS8MdR2PAIfmyTEB/Kaj96quNj8y2cd7tYU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q4w1ek0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 18:53:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:53:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhgDgfKYOtV1Bml1oZwUFp1tIaly17oCZnb1w7qh+L6mZi91RgiUE8fyW0+03O8FLMCDjO8Qtl5TcoEykxd+z/LUxow8vOaxs4XEJm28qbqP8sScE86D1fVm5RZQPD1dSKgF5L0Js3s/ceB5YkvZBh0RKldOEjqcPj1Pm+SOUZhZn8hpKngXQsqNaSsyg6dX1VzYq66lUaDG+pdNzeGh5fYcr4oT5nk4wO3aQM/VjM2xxbokvn9hMcsZqqpdnbjIVu1SKoe43hIynGX9aE+E/y66g3fPw0ZIhmles7klixDFVgfzLR8rgDkDJcCVNLleL7luyNp3y+PetsBA2F3gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=q3I2hhcSM6gKPZkiK9wrmltteg/xze5ksYIQdkt5pb8=;
 b=HgiFgVpsnOJfqCyifnafPv6iFAaH4D5ZzwYKSAi6RQ7GN0D/pC4nD4dKBn29y5zi+M7T4E/aKJQuNEHJBiruM9tAkdbX0E6J8keSN4LM8R5AqL8ntY8p6ez5ELBk4l9642fJo0XHEM/2LSRxowYXALSc2aRga+hHRaFeUJhsjpMEY/l/wxogWiqpp8YdYihz7UV+mmnoYLdDgNiyZvGUXSF2CsepR7eDxtJUPWxIfl4tNoUrZkwZ7Iir4USRihk2tzDvO0wx2P+KpSqkDI2pXoXnkfLT9YloAuiiDDvx/wstDtD8QAWEa2fE3Est3pDhURPTbN7p+XeAWGbqd4Dpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:53:07 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:53:07 +0000
Message-ID: <1f3336f0-c789-71ab-1974-b280ce28da06@fb.com>
Date:   Tue, 21 Sep 2021 21:53:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-9-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-9-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:208:134::35) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by MN2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:208:134::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 01:53:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38b8f27-b4e7-4c4c-b712-08d97d6bb962
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB40391130148B003F2F3612C1A0A29@DM6PR15MB4039.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efBzsUOKqzonxbNO7Dbmgz6UTtRyaXzBf6TlofIJOmUN3cTlgFs94KLa0dDcRV3XNvXBslO01ALVE64dMJQarKGLigcKel1WyIQi+YENjX25+4eSh9PIRrc1KeUkeFxsbo15B+iSCPi8DUVFVCf61lGtR+NIqEUjbKSv1b5G0Cu/lpZpggL+78FcC9pKawfnSTU8uCoEyxVfSdSxiz3o++m3gUlelnn9UIjqgqVZavRpMDVKDkLqLEnTI2m6bikAbjViOUABYWC8ipYyODrGY6JdB7jccTE9HqXnpq7WTTvV7yGpobw56iTHO51ytMgnHqVa4KKwgr9yCxrm+DdmcEc5+Fb32uoJuQbGah6unhSoyEAayqosHWwv+xGh55xfW7DHhXBaDunCC+lz225OigZwqg6HQ80UBP0u9Hz+7wkkSDps4AnYWadHW5gmuLJSXSgxVxxLSOg4OHOs7vTiV7fi3SICB2ZRMPISKbAcz9p+e39n0TUCtuAnKS6vWFiEJIM2FT4XcuZc1dsBGb+vzZ7uf86aQr+kRpcVzOfFPqM9tin599V1vT28JMOLrYdhP9m+nOPHhieBBP2oF+U9LVZY1zubwD6zOGrb7FhTAWY0mKtiOl2Cv+udcGllb7MuDQa5fc60y3H97Bb5NQiVNDfzh0SgvDLCzoLrWvuk+DV+SAOm8oWZ23L6ulJGxgi7zdQKiF/DoQKb4+4jspcy44ELZJwSkyY7VtELyuEhdQ6LMN1CB9CE82NckmcFcQ3Ff6oDVWAQ21bDco6YRsE99RmKh7EaatO1S6qOH3QCLQFJY1nw90tl7gsp+QtmF1ISZvaNXuiFovhy+Y3AM0xzbhNTGv6GRJdjskOP4GRbTaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(31686004)(966005)(6486002)(2616005)(86362001)(38100700002)(83380400001)(8676002)(31696002)(2906002)(66556008)(66476007)(66946007)(4326008)(508600001)(8936002)(5660300002)(53546011)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE8vdXVqcngxcVpkVFpCOWVNOUhyK1RTMm9UdTJOMUxpSUVOMWd3Y0dPSEs2?=
 =?utf-8?B?aXRRVysxQ1FYblJQV0dkUFdBcDVOeWkyOHhtZWVtMjNPOTRUbmhzTDNUNlI4?=
 =?utf-8?B?Mi9ESSsyL3BhbVRhMXhGOHpTT1VROWFiVnhOd0hpaGNsdkJMbzJ6b2lGNFAx?=
 =?utf-8?B?WWE1bWZHV1FsbkEvUjk0c3YreGJOakxWcFNMK2xMZWFoVGNPSTRBc3Y2bnc4?=
 =?utf-8?B?T3ZxeU9iTXRYY0Z5b0VVQm9IRG1XOGNUenI4S0d3dmdKb2EwUXBScCtvb2hW?=
 =?utf-8?B?VXVQOUlaTFk4TlRLdUVYNjFoRWZmN3JlUnY4SkpvRGV6dzlKNFBJaDZTQ2to?=
 =?utf-8?B?V25TS29qUzdPMXB2ajVFY1p4TlBGQ3RiNE1rcUplQ3VBaWNMTGhoTDdGL0F5?=
 =?utf-8?B?K1NGODZPbzlUbG1XZXlSZCt6WEttZnQ2ZGExT3N0OE5CNklyN2FNcUdPNUgv?=
 =?utf-8?B?L3c3WWhrT29tcGZBTFhHZW9rczFPM3FDRnVTMDRsZVU5QnordTRSdFQzNnIw?=
 =?utf-8?B?YWhZRlJWRzYwb0RWQjVIU1V4NFpNZHdtUDZhb3BLWW5iYzJrbTNCY1NkRjln?=
 =?utf-8?B?Qk9hNVI0a1lTOVZPZUxCL2drV01CT09OZFFIRHVtY0JYTFZ0R1lqM29pZUEy?=
 =?utf-8?B?YWYvSk50SkNNbWtZb0lQVG5vUFAxN1dnb1JrV0J4dXJ3dm5sanV3QTc4bVB1?=
 =?utf-8?B?b0k2L2VNN0YzbXBsekZVbHNlZytldG5sQm1GakFWMWxRMU5kYlFRUUFac0RC?=
 =?utf-8?B?OW1iTFdpbDMwNjYzODNheU8yY0Z1YTVWYndOSHhTeEVibEtiWHNsZTBhNGFs?=
 =?utf-8?B?b3o3VTRVMnp6VG50L3FvcGFXOVkzeHlNcVdOcnhid05FeEFLNlFGNHJQWFBR?=
 =?utf-8?B?U0l6RzhMK3JnazQ5N3JNM3c3cDluZ3pTQmtsNGFsdTRzVUlmL2VIaTRvcldO?=
 =?utf-8?B?Vmw1aEdJNTZXMEVxYmtSSCtTVzB3dkJRMnQ0UytMRGl2aktjNjdHK2N0YUFP?=
 =?utf-8?B?ZkxPN1Q5SlJ0WGNSYmhqeEZBYlRBajBPc0ZpeWZMQ1c2YlZnWXZKMUZjRkhr?=
 =?utf-8?B?OUJGUWhVY2NjbjJCK3I2NXNQVmYwN1F3K00rTGJUMG50bkMwYlhrTWk0UGFL?=
 =?utf-8?B?TG9FbENOSk8xMnlSTGlQalhnWVd2VHFTazBxeVNUSjVNNjQ5OGFKV3kxeDU3?=
 =?utf-8?B?WXdXaUc2Nk9qN3puVjNqWk9Ka29pMmsvbnV1NllZb0ZPSlRKdFlrOWRYdUdZ?=
 =?utf-8?B?cElKcnZ0S0VZeTkrN3hqcStZSFRyVWd1b0d5WnloY1k5UXhEUVZCeG1vQ1BJ?=
 =?utf-8?B?bGh6RllNQjJQTk84SVlOeDhSTTN5QVpQb3I0WmxEL1RJN0xTUFJCUXBsTHNE?=
 =?utf-8?B?bS9GWnllRURLSzM2WmxxM3NLVUR2L096c3BhZkg5MzZ1S2hCVERwQjIyemMy?=
 =?utf-8?B?TFAySi8yUlViQVNCU1poVm1Zc08yQVFlcFEvbEpmY2ZBaHBtQWJUcGV6Tldn?=
 =?utf-8?B?UTlMalRUa3hzRCtVODMrNVQrcEZiWkh2Z1FUckFJM2h2Q0Y1VEVPeE5yS0F6?=
 =?utf-8?B?SFYvMnpFTS9YVzMvT29mRnE4MG51akFUTjFCYjhBbXhWY2NVS0xPWittT0pv?=
 =?utf-8?B?RGNHcWR1aThlZXhCZXgvQzI2Z3NYMlViektrM0d1bjd6Q0dvaVYyV1J4OVRT?=
 =?utf-8?B?S1FCVndpL29ZK3NNeXdScExxUE1KbFVabmIydUYyS1lZcHZyKzVUL1M3Vkpq?=
 =?utf-8?B?UzRZU0NPTGNET2tFak9Vek5PYkZ4MXJNNHY4RmtPS2lvTThEUjByeTNFYTRn?=
 =?utf-8?B?Z1RrQUVzZ0JCeGV6ZEtXZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f38b8f27-b4e7-4c4c-b712-08d97d6bb962
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:53:07.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wszqb+mpjh0PoToiwsOHHvvkTDTfzOJMxJHp8q6DazK7bIkOehYfiGMNEkXsIvP7JHFwIbQ/nG8ZjbTieim3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4039
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 2b4mZrs0eurfT3eIPUxXm_WiwVUsIp6I
X-Proofpoint-ORIG-GUID: 2b4mZrs0eurfT3eIPUxXm_WiwVUsIp6I
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Implement strict ELF section name handling for BPF programs. It utilizes
> `libbpf_set_strict_mode()` framework and adds new flag: LIBBPF_STRICT_SEC_NAME.
> 
> If this flag is set, libbpf will enforce exact section name matching for
> a lot of program types that previously allowed just partial prefix
> match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, now
> in strict mode only SEC("xdp") will be accepted, which makes SEC("")
> definitions cleaner and more structured. SEC() now won't be used as yet
> another way to uniquely encode BPF program identifier (for that
> C function name is better and is guaranteed to be unique within
> bpf_object). Now SEC() is strictly BPF program type and, depending on
> program type, extra load/attach parameter specification.
> 
> Libbpf completely supports multiple BPF programs in the same ELF
> section, so multiple BPF programs of the same type/specification easily
> co-exist together within the same bpf_object scope.
> 
> Additionally, a new (for now internal) convention is introduced: section
> name that can be a stand-alone exact BPF program type specificator, but
> also could have extra parameters after '/' delimiter. An example of such
> section is "struct_ops", which can be specified by itself, but also
> allows to specify the intended operation to be attached to, e.g.,
> "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not allowed.
> Such section definition is specified as "struct_ops+".
> 
> This change is part of libbpf 1.0 effort ([0], [1]).
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issues/271
>   [1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c        | 135 ++++++++++++++++++++++------------
>  tools/lib/bpf/libbpf_legacy.h |   9 +++
>  2 files changed, 98 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 56082865ceff..f0846f609e26 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -232,6 +232,7 @@ enum sec_def_flags {
>  	SEC_ATTACHABLE_OPT = SEC_ATTACHABLE | SEC_EXP_ATTACH_OPT,
>  	SEC_ATTACH_BTF = 4,
>  	SEC_SLEEPABLE = 8,
> +	SEC_SLOPPY_PFX = 16, /* allow non-strict prefix matching */
>  };
>  
>  struct bpf_sec_def {
> @@ -7976,15 +7977,15 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
>  static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
>  
>  static const struct bpf_sec_def section_defs[] = {
> -	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
> -	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> -	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
> +	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_SLOPPY_PFX),
> +	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> +	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>  	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uprobe/",		KPROBE,	0, SEC_NONE),
>  	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
> -	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
> -	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
> +	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_SLOPPY_PFX),

Feels like the mass SEC_NONE -> SEC_SLOPPY_PFX migration is obscuring some
useful at-a-glance info. The equivalent SEC_NONE | SEC_SLOPPY_PFX would make
reasoning about attach behavior easier IMO.

> +	SEC_DEF("action",		SCHED_ACT, 0, SEC_SLOPPY_PFX),
>  	SEC_DEF("tracepoint/",		TRACEPOINT, 0, SEC_NONE, attach_tp),
>  	SEC_DEF("tp/",			TRACEPOINT, 0, SEC_NONE, attach_tp),

[...]
