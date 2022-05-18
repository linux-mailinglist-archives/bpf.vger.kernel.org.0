Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110852B2DD
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiERG6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiERG6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 02:58:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C3344EA;
        Tue, 17 May 2022 23:58:51 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I2hTxa032066;
        Tue, 17 May 2022 23:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Xp50F6O/b73wAHFGyhQ+Ue9EELvJt/yILryYlx3rUso=;
 b=dxOnQAgXC7d44iKhjaz2ZmuQCp9BcwvUpbpLAMvpH2zRYv2yttA+IkVfs8wy7u6PBucf
 ZnfoLQAExH3vN5kzpk+/T6diun4Zbtl2CSnxOIxuftPyNJoltoKRTqOWqA6aASiwlv42
 qntY4Dpv3Cg6a3GKISnP4teIizz0uuNv3A0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4ck0e1ha-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 23:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCVKnXoT1YrvsPWA6nw9bRbjGRrYQ79X2GeQE8u8PzNUfxYSWs55o2Dt99XfAcmPB2boHb0mGWbgxYVmKaL3BKjWJi1M05pQXyD+wjRVTfB47KLpSjIex4aBUYzDjAHZNAA8VBV08EqffUfm0trORliPJXcbmfhxbWNACclZPCO2FMepZ0oC0l4rT35QOjLVmLVcgDoJfW7aPWU/8wdPsJwyceLZsp7crPykqQ0lZgRdDPY+bWt8PhFPUCQyOiIwHZYCT/PTIrKvL62/LrUF5iyDMsP/5CLBJDmnPvIIqpsvOvshprvB4f9+pTQwJ6Fk8wLb90v9H2fDkTvtZ0uJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp50F6O/b73wAHFGyhQ+Ue9EELvJt/yILryYlx3rUso=;
 b=H23g+69G4DpYcinYQlRBWmc7cXrvwamxiOETUzzv+nqKrnHxgcvPpcUYPsyxkZv1MV3d8mDxwviVYW5EbZLrAN951BUjkLz+Ri37pS3fVA7iQc375ifFuLbyj+OfvJctAwYiBL0vUBMvWQzZ8vx6K307E/P0ytd5o/wgsSGAm0SwFMyo82u9VeE/NvOEcL0UtAx3INH0bg9aDBIcdIKSLmotg2Jl0VT6SADxQBIOksqYZWnhVMBDJHTRtN9Lz7eRbOkmMMLLLZK5aYKuvFmKgiiNiPgMtLT2QhSrhydc3s4NsPmN1W/nuF3MtJTv0zu/K6XZ8K5x6dzkfeK95WZ0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB3008.namprd15.prod.outlook.com (2603:10b6:208:f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 18 May
 2022 06:58:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:58:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Song Liu <song@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Topic: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Index: AQHYaOeQGQ/WNhSrw0WYR6bm3RcCIa0kN5+A
Date:   Wed, 18 May 2022 06:58:46 +0000
Message-ID: <8370EC6E-C01F-496C-8B7C-D13EF9C474C5@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
In-Reply-To: <20220516054051.114490-3-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d80f0c1-fdd1-4edc-ba17-08da389bdaab
x-ms-traffictypediagnostic: MN2PR15MB3008:EE_
x-microsoft-antispam-prvs: <MN2PR15MB30089BDF90E655D160B26E59B3D19@MN2PR15MB3008.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGsNPWY8EkR355lOXzP9MOfBy1sRKbUaTApGKXtjzjbQr7aXfd302gzLOoIEcYgOEhPK3NdKTQWkXN3M51WrwiHyNU7c/Z3O6zhPYdnjMcz4QQ41nxKBBDjf07zvz16mz08ntP1AFCRjTfNn1XiEGlXnXqfRJ27UqQTnZ30DoCoJBzIPFBykdWEHNB2DP/XJueyG5xFGYAA/oxh0hOu/PnzYkzEDxmxhrl7mmPVvLiIrrw6QV7nXjQD0G4QtmIKsJVj9FnGPMvkIVLGrOEjJanzku9vz7MbLHMyrh1oxJE6JMfbyowdP4nAku14tIc8F/D8J3IXg/xRLIvskyUXdFv2SIePUvXlw7Jd+B5rL2BNrHZ9GG0tJoxYItFuLC4s/UCqMxY67dzQKx2z9uYAEGSJJh8MakT1gnrdXSbhB1m415K10iC6XffFlChXv6UBgaMUQpKkfHZXYQgoUvLqMUaKy1BZf79nlH1mXrVziC1JCBv/YZSFBOS7i66wCbe/FXTnYy3fLDBWw+Xvy9GqNH/jFztjaQaDJ3Dn97+q4U5dcJMjYtVa84ZYfFchXgQK6UyxlHt73krKjgamCvurydwhb5lYofJgaNTEozc7T5WvgjEPo6WmNLiZimqjQ/x8FXF3DVmuf3Ix7n67SeM3+GsMWeZBuipUW7GWv0RliaN9+PodqIR9Uk/IGSVdgWI6nmj0pHc3XlFl4uQCDK9ZyMJrZhZN7fd06Yw2JGCSPIR4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(54906003)(5660300002)(110136005)(8676002)(4326008)(33656002)(76116006)(91956017)(66556008)(66476007)(66446008)(508600001)(64756008)(186003)(66946007)(2616005)(316002)(8936002)(6486002)(38070700005)(38100700002)(53546011)(36756003)(122000001)(71200400001)(2906002)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LBzUVFZNWjsoNT4gQqMmAvOigjlLvv+YPCZNZE265imniZ3SWDFM9php3QpM?=
 =?us-ascii?Q?RDRdeAxeRViq0md0sDt/OO0YzQHdAklvUhGoF1RUmaONsMmV9a7Qbu3VIN+j?=
 =?us-ascii?Q?hcGTYo4bSO3rpwBRUkoHdYD9aSTadlXccGTvZDopxCioo9AcvOsjK5RMCZ7Y?=
 =?us-ascii?Q?rnirpuBCK7C94o3TMcTei09+0oZ0BB1dgydmZvH/2/ChPSZIb3RUuqbwg86r?=
 =?us-ascii?Q?8VlLJ6Fu8OSZfkQ6IbMvHNnYPNQODV+2F4GKFs24+pFoh15Bw9AsnTtO1Ecx?=
 =?us-ascii?Q?giqptpveZXBO6hFX1T4hl63FnaQlqedrOuKl+0nfKLkNJWLO8Ie5W8kCLq1f?=
 =?us-ascii?Q?4ub04iv2OIb3Ehv7/1cRiUATXn/o/3HRpUrk/Cb4hXyzpOB0eJxsfCdo0Vd9?=
 =?us-ascii?Q?ZRsSwXcYObUTm7A8o0EgxCEqHjOh/Jk3+YVPp7vBwz/1OlQfsZhRu2azsc52?=
 =?us-ascii?Q?0wC/XZGNx4kYH8++TzN/2Tg+ZtPh/s/1diE0qfo9WkMvlrZyrR+Xa3A5i/0v?=
 =?us-ascii?Q?uzpWeG/JQWBtgHfCkJINOXNNahtyYPhRS5KGBuiwltJhJ8tx9wjbtgmkbUDh?=
 =?us-ascii?Q?UojM7fY2hrI5U/kAvk+qJfr0OqXH72kiRHT6zxlJZ7FeXGa1ik2et64GvWv2?=
 =?us-ascii?Q?E8YEmdd4b4H5LYggfXVFCfPhXF+o/G4LeYaooAjECdpZd4XJQjKKR1AkSOed?=
 =?us-ascii?Q?w6P5SitKTXc3E7mfzyzJde80Y830SK4R2kqmF2BkLqlvVPUJKiw8gicL7ldZ?=
 =?us-ascii?Q?URYe65OSR4QI8+ZvkLAol0bTjHaxMPIurOC9XYASR0DzI1gsMc8B8lYo3a5u?=
 =?us-ascii?Q?LOgQepi8v6kPGSSxs4/XSvQEfpihHY1ysidufE6M3pCIByK9hkxwiJKhWuQC?=
 =?us-ascii?Q?Ob/9hVUyEdX02hYWjeDhcDKDa76yPQMd6HAwj12xz+v7c1prFrxI/Ro0VJIP?=
 =?us-ascii?Q?RpYCR+Ky2UWFcSbdMupEjyD/uNWbWyjKEZIewVK3YB47YIle0k49TAgC+LSv?=
 =?us-ascii?Q?AY/GT+fo9X8PCDGwFkrAMHEYt3DcsXFIUrL7fG3/7WLtFevwzT053o7x2SUa?=
 =?us-ascii?Q?o/zI/Zoa8DEx4kipuobKo0eVUIlwXmORBSq/HWFJmCutjV3UEckGiVcY5OXg?=
 =?us-ascii?Q?uQdUim9jSmF4Tqko6G05iLvFBwhx+WxcCD6uGpOdgXKdmMhBAaE+xCvERJ/x?=
 =?us-ascii?Q?STb1HGvAXwFEjGpgOTJa3GIKvrJhP8pAblbP1fZuXO7d+BUrLkUMhlEKV51h?=
 =?us-ascii?Q?i4BqaP1rhARim5jABMxrzr11qZVGS+AtUzv2BmbuC4eFiaoJ2n30AYXcNJw4?=
 =?us-ascii?Q?s3ORHoMepIxabANKCjcbOaEXsoKkv28emfJRbLLozYs9GIkPwxnS5X5hi1fg?=
 =?us-ascii?Q?evwGM+qFBTweXIBWP0mW8L5s8EQ1qQ8T2uI2fdtkugxmFPJy4ijlbjtt5T3V?=
 =?us-ascii?Q?LY6VfLxLOPWGfJYjxnbluN1qvh+PzT4U/KzO4v8JGti/gp1h+mLeJfObwtDa?=
 =?us-ascii?Q?TwwOlmFsDKVQN+k3I6DGWclZ7rjobX2lFAMcVNBppYs3VQiifbcwyxtVy1Op?=
 =?us-ascii?Q?kU1+YHxjfO6gsBexZmK7rYfz91QOcahpu0+/swkKUQC3DM5mT399msHqutkW?=
 =?us-ascii?Q?IxkdHEfx3dnPOhMAUeoEMOR03XSlLL5Rz4wr0gCeneJgOMVmsOLuBcB6A6SY?=
 =?us-ascii?Q?Rl2AvgnHTowd+iP4oEeu6/zKb22ECjF9lT1wE6rr7+UCydcYqM01RYF3Jt1w?=
 =?us-ascii?Q?kXH7Ihlu+ak/dNdPV/wK0ysVE/34ArBUUWxUtKrUJa7CxffSBnvm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A01E3D3C7A22B448988692E65429AA9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80f0c1-fdd1-4edc-ba17-08da389bdaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 06:58:46.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BK1ZPzwWMpMCqAGew7oOdr1EgxA/pYHO9u/j0W7Acg+dVl+bX8SF0DfnnhUsP6YLY3K+zkKyoNDoCClPSJr4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3008
X-Proofpoint-GUID: xZmYKC1uVNn2CvrkaTBQ51Mgju59PMHh
X-Proofpoint-ORIG-GUID: xZmYKC1uVNn2CvrkaTBQ51Mgju59PMHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter, 

> On May 15, 2022, at 10:40 PM, Song Liu <song@kernel.org> wrote:
> 
> Introduce a memset like API for text_poke. This will be used to fill the
> unused RX memory with illegal instructions.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>

Could you please share your comments on this? 

Thanks,
Song


> ---
> arch/x86/include/asm/text-patching.h |  1 +
> arch/x86/kernel/alternative.c        | 70 ++++++++++++++++++++++++----
> 2 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index d20ab0921480..1cc15528ce29 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
> extern void text_poke_sync(void);
> extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
> extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
> +extern void *text_poke_set(void *addr, int c, size_t len);
> extern int poke_int3_handler(struct pt_regs *regs);
> extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d374cb3cf024..732814065389 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -994,7 +994,21 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
> __ro_after_init struct mm_struct *poking_mm;
> __ro_after_init unsigned long poking_addr;
> 
> -static void *__text_poke(void *addr, const void *opcode, size_t len)
> +static void text_poke_memcpy(void *dst, const void *src, size_t len)
> +{
> +	memcpy(dst, src, len);
> +}
> +
> +static void text_poke_memset(void *dst, const void *src, size_t len)
> +{
> +	int c = *(int *)src;
> +
> +	memset(dst, c, len);
> +}
> +
> +typedef void text_poke_f(void *dst, const void *src, size_t len);
> +
> +static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
> {
> 	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> 	struct page *pages[2] = {NULL};
> @@ -1059,7 +1073,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
> 	prev = use_temporary_mm(poking_mm);
> 
> 	kasan_disable_current();
> -	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +	func((u8 *)poking_addr + offset_in_page(addr), src, len);
> 	kasan_enable_current();
> 
> 	/*
> @@ -1087,11 +1101,13 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
> 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
> 			   PAGE_SHIFT, false);
> 
> -	/*
> -	 * If the text does not match what we just wrote then something is
> -	 * fundamentally screwy; there's nothing we can really do about that.
> -	 */
> -	BUG_ON(memcmp(addr, opcode, len));
> +	if (func == text_poke_memcpy) {
> +		/*
> +		 * If the text does not match what we just wrote then something is
> +		 * fundamentally screwy; there's nothing we can really do about that.
> +		 */
> +		BUG_ON(memcmp(addr, src, len));
> +	}
> 
> 	local_irq_restore(flags);
> 	pte_unmap_unlock(ptep, ptl);
> @@ -1118,7 +1134,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
> {
> 	lockdep_assert_held(&text_mutex);
> 
> -	return __text_poke(addr, opcode, len);
> +	return __text_poke(text_poke_memcpy, addr, opcode, len);
> }
> 
> /**
> @@ -1137,7 +1153,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  */
> void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
> {
> -	return __text_poke(addr, opcode, len);
> +	return __text_poke(text_poke_memcpy, addr, opcode, len);
> }
> 
> /**
> @@ -1167,7 +1183,41 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
> 
> 		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
> 
> -		__text_poke((void *)ptr, opcode + patched, s);
> +		__text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
> +		patched += s;
> +	}
> +	mutex_unlock(&text_mutex);
> +	return addr;
> +}
> +
> +/**
> + * text_poke_set - memset into (an unused part of) RX memory
> + * @addr: address to modify
> + * @c: the byte to fill the area with
> + * @len: length to copy, could be more than 2x PAGE_SIZE
> + *
> + * Not safe against concurrent execution; useful for JITs to dump
> + * new code blocks into unused regions of RX memory. Can be used in
> + * conjunction with synchronize_rcu_tasks() to wait for existing
> + * execution to quiesce after having made sure no existing functions
> + * pointers are live.
> + */
> +void *text_poke_set(void *addr, int c, size_t len)
> +{
> +	unsigned long start = (unsigned long)addr;
> +	size_t patched = 0;
> +
> +	if (WARN_ON_ONCE(core_kernel_text(start)))
> +		return NULL;
> +
> +	mutex_lock(&text_mutex);
> +	while (patched < len) {
> +		unsigned long ptr = start + patched;
> +		size_t s;
> +
> +		s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
> +
> +		__text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
> 		patched += s;
> 	}
> 	mutex_unlock(&text_mutex);
> -- 
> 2.30.2
> 

