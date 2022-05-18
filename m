Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427152B27E
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiERG2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 02:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiERG2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 02:28:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB37DFF61;
        Tue, 17 May 2022 23:28:36 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HMwhfN003850;
        Tue, 17 May 2022 23:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=F9pxnxluZaRmagnAWnnGQmQxG8qbsXAiyN5qYuHoqmU=;
 b=VF8qfQ8iJeeo7ZYQw5pr6EGbpwQsVQv72fitXa1UviYT5uDq2pYXuWvLCY76MGKrEuK7
 48giVoQsc4o/fX9KeP4ajiJvv1GfWk3OG7MgBM7vkXHoJ4eHROCkxnTop8A5bNAq8pqr
 T1bQIm5XE1mE79wn2ldvl7lnL1v1+YGdqCY= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g4myhhrbj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 23:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW3rYS5i3iZVhEUpDwpGzhnzZhS3XxfMHncQPyPbQPu3PJd1FQTGxWW6TPr331Pou1s8+IYjggjzCex2/Y2Busrbxji2NUFvacRngkN8p0t3bffv6i+V24S2HsMMw1Z4YQkT9pvQoysFJvYfQdEw+hGsW1Hv50tyfj1dF/P6aDkQyXz9lMJBGH7ajJeh+aLwsyeytJiCkdYaEhbskOwAR+X4EJ6o1A1/FyQBSupT2R7fmPCmJw0XdbNbMLDAMqTBLiDHZKz3xaIl6s+zxBEkqwV1TQBnxTJgYn4Ko1C6+JX4H6lN6MWluMSYKr2fM4W3Pc7v2VyffZXcTK3dih9STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9pxnxluZaRmagnAWnnGQmQxG8qbsXAiyN5qYuHoqmU=;
 b=eYuGBOMvmGmlzRRichEAcvIjO5n2DCK8NKhc83dzaECy5jsaPXczVx4QVeX859xruNOEFb0wdMmh1/sCrXRcTsaVc4yajeL9Pkn05/FzJ78KZptzgUI7H/DI+AqTRZiSeSinfOF5jWLwdKNXkqUzJsHiRrPnEwYoPoCs9bfpn4EZuLS0LtghzTg5bEu0t+JZMW61uXLrj87o3vkwIudRFqhSUxvOnUCJMajWnOe/vox8IDlUouWxV4fdGVlxvbq5rC80crUSlQ5gUBBTTqsCWEqw97xHWwInZ5xzmMyz4iYFuPcAZ/Yz0Y5XLBihfsWIs2Cr8O485PlQttaHysMBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB2636.namprd15.prod.outlook.com (2603:10b6:5:1a6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:28:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:28:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Song Liu <song@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next 4/5] module: introduce module_alloc_huge
Thread-Topic: [PATCH bpf-next 4/5] module: introduce module_alloc_huge
Thread-Index: AQHYaOfZiwTcmeu5vU2QcADgdRaNIa0kLysA
Date:   Wed, 18 May 2022 06:28:31 +0000
Message-ID: <E899DAFD-EF63-444E-9873-E963002C2EFC@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-5-song@kernel.org>
In-Reply-To: <20220516054051.114490-5-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e51aae-f239-4d16-8992-08da3897a104
x-ms-traffictypediagnostic: DM6PR15MB2636:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2636ABF93D52913543F91881B3D19@DM6PR15MB2636.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHimTuNmqenEOGO2sWVenNjw7ai6XIb75qUbkzMGa5bpmNAcMnolc3AUOb03Czhpb26Nw+R14KPTCN1LOObd320yljmlvc3TGlgTwrP0hYqu6OKP+etK3YlITHImduKGt4L8aktyWF8I3c6x6oYYi3rG4/N97KkJEua5uXxxTFJqgNV0PAQe+3fZIgKl3GtU73BGMgd1goHFOeDJibIkp86mUqryMh2iCmCmGiNEXfTAYx92YAdfydp5R3o+SJTunKsrCglBTofscXV/Hjr9rn/ULqtRHtcGShY/k1j9y5GXsVwzMnD2z6U5Xv0p7jVKD7v1NaAQyoFxH6U7hsYqEVuKfgqYzIA6yBdHtcAa7NMJETe0DTRLAtnYlMS/eJPAkN1pvBQXxFXfCdIEYTFfB52vVx5CSlzXDUn0x3TUmU0LUOu27j+5kPRldh00U2Sa/O+nybE3ml0UIllbKHg0pjThJa3WoWhme9ShfUCQrJCTpKyjRugC+1FlKW2ecatzAcbYSJFQds0j56dQkduYMCFVOcJhuuFHj0giCz2mdOfzb3rakRujLqlImj2Yn6dV6WaLmGH1KDl5D8nU1ZHY4MyVK252L3gdEip9kM/AJjHwJBTHwHxd5Ql64S0lRW7z0FIfcdD3++Sx06Z2xOJiLhRilsmDfABM+iyZRAcQP+Po2xeHi+hAYfTrOcH+oT1ePl2U0m/6ns5JZ6YFcAUaavmjCXNDc99y6S1MMs73dJdxfSL89+8phTypCpZRgSyX4bSLgtZpafXs4n38nfh4/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66556008)(64756008)(66946007)(91956017)(8676002)(6506007)(71200400001)(6916009)(54906003)(86362001)(36756003)(6486002)(316002)(508600001)(83380400001)(38100700002)(2616005)(38070700005)(122000001)(186003)(8936002)(2906002)(53546011)(66446008)(6512007)(66476007)(5660300002)(33656002)(4326008)(7416002)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j3Ugbgw2lz1VHAM/r5uzvmhxMeh7b/dysMhMX7zdr5r7QlhlPmoOyJHXnn8P?=
 =?us-ascii?Q?fkEw1L0pBtWky5S+TBk5JwVWOy6FdHYl7tnPut/QmKOc9iYr2ET5Jz2RPWm6?=
 =?us-ascii?Q?XXFj/bSq7tCOor34VCgZTeif0HLbhLFub318rT5MFJu8ZhGSP7WUaxeaejAX?=
 =?us-ascii?Q?8RK7xg0cz+idD58y2b67E4D6M6PLxWOvCszYMTmPG3dr3mE4fcChsA6dSpgD?=
 =?us-ascii?Q?+UF4PKgE+XZoUKV6Zm9WCzy7M8ob0IYbEIzaGy+PEPoQfJ/iZkyaO4ZFb0OP?=
 =?us-ascii?Q?8nFakCh8iCbPuudXHQMk78SXbizwePJT9/2SF2x6tqDHBn9AwAgNgKaMhls9?=
 =?us-ascii?Q?RWzDuzEClHk82hj8l7lvPEE3UDB5wEU6vJRC/gad8Y2g5K7eIh08NF9YhTx9?=
 =?us-ascii?Q?fTZ2zSV9AodtTdGVT+MPH7L9zr4PY2PQkxLZxJzMzRUPqo6MxA1Z8ombPgho?=
 =?us-ascii?Q?le6ys/PBUQZ2pAauPmiqR9LnXkTBcdXQLNQWvSQunPRNxo6kaBc3bx7HyK0T?=
 =?us-ascii?Q?E/GKgGi7TR7XXBS06vEAHIGI9rXU7cEaZSxSqU7OKQfuqeUQawfE78g3c8HZ?=
 =?us-ascii?Q?BYMyt/JgwcIuL6kzVHpic0QtwDvknb2uJIfF6necKWgojsN3WpJ0JjkO+Bsj?=
 =?us-ascii?Q?FOQ5CmdrSbRd9/YSvEb42bQaTlvcd1q2uhvh6swKNXVa/r1RQ8PheAuEMI9v?=
 =?us-ascii?Q?UCatJvkP53fZFCYp6qcFbKN+219XQOqRB0kGbU9q9WO3Upu4w8g0IM5UA2mi?=
 =?us-ascii?Q?ix1FIRVjdNgtuvGtnBPL+wy0j5rlnArcWVPzwLwhx+mQo23SUdwRXwP4IjI6?=
 =?us-ascii?Q?a/fVT1cUeYH70uSTuja7gdHxeNJSe1hcXMBw7CsLhK8L40P6xfNX1M2XOOC3?=
 =?us-ascii?Q?NcDVyvkSN15kbaNaY8iqev3LliDQhbRlQIGsa10JC0bZMgFGTNBlo3A5gR/g?=
 =?us-ascii?Q?ZgN2pMv5hkNgFPBu30Im3qLPZSYsQCaI9dHnPLOUG8mBG7GMW0o+gX7pqSCS?=
 =?us-ascii?Q?vWORPeIyGYpkFnI2x7IkQBL1V+xILqLboHD/V94ecNke6T4LGcMcXFunZyrV?=
 =?us-ascii?Q?gigA3FFLO48JMg3+abfAd4TFwPSTdlJVBl4gZlmYCBy9Z1I1FcHwP2gRUW30?=
 =?us-ascii?Q?/dintf06gOhTJsadyt8MvMvGQeoVocrTMMR5BPfrERgU3B+sX73yL8ac88Bn?=
 =?us-ascii?Q?IeHfO932q/fIudeUXtBYYjsnQwsv6YeAIigb+qcAxgeFjxRnT1lXu1kzJkl1?=
 =?us-ascii?Q?tQ/bscEgB2GDVCJ18miMN1S1KNPG+o3crlLTbeRWMP4tmEnydngS+Nit+6/d?=
 =?us-ascii?Q?5ihpyLcpg2FnpGBAQescrSTypIsInIegYGvWdNHjsBnWD/GWEk2atJTHcnz0?=
 =?us-ascii?Q?4jpghGMigIhxROetyWDznkGUD/pFIVmLtCktuhXHfEB+KOlVYEdYpWtzC3iv?=
 =?us-ascii?Q?Y0t66jmhQJzuzwYFzlqLZugKy19ciDfsIHTomjaTR7TAZX5vhxQR3RUJRa8a?=
 =?us-ascii?Q?Qm0fxtrloKJKpwhmtUKGazT24AP3UxznqEVAi+6ijopAvkethjYwUDNcKq1j?=
 =?us-ascii?Q?8yURjUrUcZr5NdWVmv3+8imriaPEd1CtLB9uBpymwl10g4JoWGrLwqXCMiaL?=
 =?us-ascii?Q?15d5gZz0tJdmg605BqUcibCe4Jq1vzNo32+8dExl+cBu/bx3pwxG+8Jg0uhs?=
 =?us-ascii?Q?moytfjyFMvlJvJ4yIOUVnS6Y9tWozObvdAV1dt3wy4HYEbqtxPGIhuw/E27r?=
 =?us-ascii?Q?lzo5VRsb3GYOWX5x0W/E3s1tHQ/JkMYDRQ3QySCCdwfEPdxHlFmv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E941A21B813EDE4895B32E2E75E42C38@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e51aae-f239-4d16-8992-08da3897a104
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 06:28:31.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qn/THYGD75kSmrDHm1LYMKyzcFHSXJFiRoSjfFl3S5fcpzbfOWlLfGPrBno7o1nA5kAWeyA10uFooMTybZ9NRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2636
X-Proofpoint-ORIG-GUID: 7neGzMv0wzZazoLXkZJj7LcP1Hyzy8AT
X-Proofpoint-GUID: 7neGzMv0wzZazoLXkZJj7LcP1Hyzy8AT
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

Hi Luis,

> On May 15, 2022, at 10:40 PM, Song Liu <song@kernel.org> wrote:
> 
> Introduce module_alloc_huge, which allocates huge page backed memory in
> module memory space. The primary user of this memory is bpf_prog_pack
> (multiple BPF programs sharing a huge page).
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> Note: This conflicts with the module.c => module/ split in modules-next.
> Current patch is for module.c in the bpf-next tree. After the split,
> __weak module_alloc_huge() should be added to kernel/module/main.c.

Could you please share your feedback on this patch? I guess we need
to address the conflict with module.c split in the merge window?

Thanks,
Song


> ---
> arch/x86/kernel/module.c     | 21 +++++++++++++++++++++
> include/linux/moduleloader.h |  5 +++++
> kernel/module.c              |  8 ++++++++
> 3 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index b98ffcf4d250..63f6a16c70dc 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -86,6 +86,27 @@ void *module_alloc(unsigned long size)
> 	return p;
> }
> 
> +void *module_alloc_huge(unsigned long size)
> +{
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				 MODULES_VADDR + get_module_load_offset(),
> +				 MODULES_END, gfp_mask, PAGE_KERNEL,
> +				 VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
> +				 NUMA_NO_NODE, __builtin_return_address(0));
> +	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}
> +
> #ifdef CONFIG_X86_32
> int apply_relocate(Elf32_Shdr *sechdrs,
> 		   const char *strtab,
> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
> index 9e09d11ffe5b..d34743a88938 100644
> --- a/include/linux/moduleloader.h
> +++ b/include/linux/moduleloader.h
> @@ -26,6 +26,11 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
>    sections.  Returns NULL on failure. */
> void *module_alloc(unsigned long size);
> 
> +/* Allocator used for allocating memory in module memory space. If size is
> + * greater than PMD_SIZE, allow using huge pages. Returns NULL on failure.
> + */
> +void *module_alloc_huge(unsigned long size);
> +
> /* Free memory returned from module_alloc. */
> void module_memfree(void *module_region);
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 6cea788fd965..2af20ac3209c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2839,6 +2839,14 @@ void * __weak module_alloc(unsigned long size)
> 			NUMA_NO_NODE, __builtin_return_address(0));
> }
> 
> +void * __weak module_alloc_huge(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +				    GFP_KERNEL, PAGE_KERNEL_EXEC,
> +				    VM_FLUSH_RESET_PERMS | VM_ALLOW_HUGE_VMAP,
> +				    NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +
> bool __weak module_init_section(const char *name)
> {
> 	return strstarts(name, ".init");
> -- 
> 2.30.2
> 

