Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AC502D5E
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiDOQBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbiDOQBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:01:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC399ED7;
        Fri, 15 Apr 2022 08:59:15 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23ENteX5001344;
        Fri, 15 Apr 2022 08:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Q4f6+CYDMILdmpPw/S4FhFMHsxqU+erd4alHDF7mtvE=;
 b=RXshzK68Gci+UsOPe6hDjwNHRHyWxxpbPjm/7fJalOhPHQEmIxKnDUlWw4rq8nByJy3t
 1Y0EbYe3tzKtvXNhhtUr1udEp0T7WKj06Jzw6D2rE1yZj1+iUCbizePzBqRcF1Zu4C14
 3GItEeTLZi4PBVMdEEn1/zhgBVc6HoSQ19I= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fewgpkkwf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 08:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJzPIrLgDowNjmmuLnJwf8VM46AvmXeytOAIC5GOirHKFOSSqLQ+bD7fZSmWxsZypsQC1lh3w4Xb5fsquutWwcYicZIw1zdc105qji+UuUzq3Yks0YPMioXkLpUCnIF+P3fn36H/Z3JUtzOV3FoutrDExoImvYxSmMDX8n/XVIYu4LxssYqwXK+IibYhmX1e6Mq5tWC2vJX0+u2wWRI0ifjTcvSBp9KSLIjDid+f7H1uYOMpPl2WcYggllij7wrdNtPbvTjGi7AYWSkHrI5K79zxeP/hVzTiaQ+nJkDEMIFwDLr22Dd4GEiocP8tG5c7L9Q+IrjIPcovYsJR2Iw4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4f6+CYDMILdmpPw/S4FhFMHsxqU+erd4alHDF7mtvE=;
 b=efBbJyTRS4XhsfqaIBgDYfBwZDOMRhK/XUMPeXHZJk956ptHFVT+yTAh0DOszcRlwTRKoYlr6maNjIe7HfFxwuEqZVrOte2Jiigql20qlJiqOFdZT0J2wtdiHTGQ/f04G9b6XqnCtSzYDLYPj+YRGCAF1I0G0k6fuhcAmydBt4U2nX0e/OwMOcCPl8idzbaztgMeaxggPcMM6mqxYyBy9RWMa0OBnQeeOx7NUHpKbxnJm4ichx/baZFOS4PVc6+D933a/Vggj22255ZceaVNcTC/EBOWC7i7ufy1bovPxQEjCNq9K8lKj48JCPerC3UNoL9+RdC6VAnOw5xX4mAwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN8PR15MB2628.namprd15.prod.outlook.com (2603:10b6:408:c7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 15:59:03 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:59:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Thread-Topic: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Thread-Index: AQHYUDvAnvLWkEyvukCyKG12yDXWaKzwhM4AgACeKwA=
Date:   Fri, 15 Apr 2022 15:59:02 +0000
Message-ID: <E12590A1-ED97-43BF-9977-B69FE44CE423@fb.com>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-4-song@kernel.org> <YlkRlm6rrxcMAupN@infradead.org>
In-Reply-To: <YlkRlm6rrxcMAupN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c28496f-fae2-4ede-942c-08da1ef8dcc1
x-ms-traffictypediagnostic: BN8PR15MB2628:EE_
x-microsoft-antispam-prvs: <BN8PR15MB2628E9587EAB4A37D18906D9B3EE9@BN8PR15MB2628.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQKWQCHAlYsGkPDu59ROsoKL2s9e+RRfbYpu2t9EAwkqD/W1ILc58mGp8QfFEIMtJpCCqfc0L2ZFiT4gBSrzNAco+lGDYZqhkM3qey1SuLwWesbVBVR3yY0YM/txKQdMxO58zv0Lqk3KJG2oXVvaGBGq7ganQw89bPGMHKJZksdGAw0chjyoQZTTCcdwMDiftRBz3sV/KU/Gg0gJb1u47aysJLLzRGcd7zPSOLPIJdLBfFyIctFbkYWOTsD2ZtJjELELjvGElKuGvUqWPFtG9SCCh8Yqd9GB9uYcOvESwz45rfpTLj5i4/IB+jlGtxEGFfFZQ5Ve6jJm4gOddckVL4uXFjBHJUORAedPnBSUtYa8Ck5UgPTx/tZKVYP2eOwZluz8yuLesPnEvGq8fHRSIFQ8oICjY7K6qqfACyhl5YZEgquywjslJXRYcxfpGO95qN1g7i3E3g5lAjWGcyCrUXY+hBsS8RJrfRDsxlksypuKe09WNkPshr4fG1rIFgHbybmwYOJvsb6sJpc7o8POEgGWRhd7o6eK7PH0yYeadfj7mFKhN4i4WenCq7qD2VUAcBKDEGKDWBzL2M41l9zjkS02i+BkRm/vNF3rL+EM2WAvAk15IOOz7X3FzG6cI4E361AeFDsyfS3GPVFg/qz0CwRSvwRi6au57L0xXVsRQ/3YupG+ZrHp2yi/KB3n6xvLj3j724iL5pjabl3u7T9S+i3LUTQiGX2W3DIQ6EFzXDTVi8SVi6a11hMAJ7ThyqregkX1xIBve0W6LzuhvxkSRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(91956017)(2906002)(5660300002)(7416002)(8936002)(71200400001)(508600001)(66476007)(6916009)(8676002)(66556008)(64756008)(36756003)(86362001)(316002)(4326008)(38070700005)(66946007)(76116006)(38100700002)(54906003)(53546011)(66446008)(83380400001)(122000001)(186003)(33656002)(6506007)(2616005)(6512007)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2h1+LlNKj9ZzYYLd4fiBX8aaZTApwYPxtYi0b4sAbmVO+pna5LUq83k6o02?=
 =?us-ascii?Q?WpA+zCCZjyC7Udiou6E31ItscXeeh/QoS7ronL3GgrjvB20dxKPO3VoHyTy0?=
 =?us-ascii?Q?PU4e/2jMJRXEhnQ6LbN+ryUIy2ttDP7ovgNXhcDb9/aioYlEMYzdnxIGR+lB?=
 =?us-ascii?Q?2fdv0TMlM6RdKmp8/ftFy7B2juHTZ+7LvgfZZar1aW0Q5jE1AZ0WriIqLnpP?=
 =?us-ascii?Q?cLO51Uqwz1a21ji+DQ4d7ZGoJetw4v6xjfEWlf0DXVYZeRLid/F+Up2w5+Rw?=
 =?us-ascii?Q?2BKs2NpfbF85A4VXZC2xo6vnqUekDnMDXdGx+8hNYO8IwJLzWQDt8gb2xdiH?=
 =?us-ascii?Q?D9vyV2LKLNoRB31e0aJFS3sBt7/mk4ySQH2Z2LZUkT32KS7r+QCg5DoVkt1j?=
 =?us-ascii?Q?unzzRBf2dKsSL5Xyu46VxmYaFC/QCfkaeQv1hzmx1f9NX2OxOji9V+8ZOG+r?=
 =?us-ascii?Q?RWH03qLT4dMZWZoQRBZEIYD+XmU6BzimN6W0svbWoCFnp6x0zbX3852a82Ug?=
 =?us-ascii?Q?sLN7gyjPzx7fmkxgbZ5x42NmWYcVuCRdjNyjFIR37bqMEqbkiOIoarYkFOMx?=
 =?us-ascii?Q?QQ6mnXEko/YewWxbVivCXRqGVzMo0c/BAtoSG2kGMeIDWU41YQryeo+MD/Au?=
 =?us-ascii?Q?LNBbT70DcM/5YGP9IDmASLW5mnIrdPriTQHZRBws5tAa1oQqCXyw7hS4lQX3?=
 =?us-ascii?Q?XO/EO8J6fhAuO2iRbNb044oTJwOP8sJREAM/I7mpn5jea2yjotvbdZkpr5My?=
 =?us-ascii?Q?tQ1leDIRWmQEYD1S3i1mMxYsgym1akg+b+f4m5BGFq6ZxtNSy8pjsHD1JSgk?=
 =?us-ascii?Q?xCkjpfk4iWG0Imd9fuDTjC+Z8b45wejflyD5eQYa7FD6BIgJnlc9/bcEQPK2?=
 =?us-ascii?Q?wl+F5RVqzfBTZt8wV1qi96wxUoR310z4SfXzGxsJGQuZ0NFSEOcd+ssh7QCp?=
 =?us-ascii?Q?eFGq9TOfohylnD9Z5GLpW0QgCftoxGXf4+pL7dExjgJzSwueOry4F8wet46Y?=
 =?us-ascii?Q?DAVZY3wDI3RQIA5HchbIR57pKETC/7TyfObUY7UZZqJAnDRrQMRu7jFyZiLS?=
 =?us-ascii?Q?XNKjVzjY954Ua51Axdv3hT87ZesLmxZ5/HCOBMNzz87btX3MMBNQIW1dQR2o?=
 =?us-ascii?Q?SDytq30HLsEiqJoZCEadkT++XpcEi9+PYTeGHDy2Wfc7Qg+w3NGo5wkoX0xO?=
 =?us-ascii?Q?+4zbqM70F5ZUSKBGCoML7bj3yIYNNswo00S2rXenItwjiud6/mLea9Uby5DG?=
 =?us-ascii?Q?fbyjr1zY4UhwGsUWYqmwyHVLBRLIuHlj2uaNhOYO5AlI3WSpdDf4YH8FmuU7?=
 =?us-ascii?Q?jBN+NEXAk0kKRaRhDT5NX7q0NOK3+G4PlpKMMB702RoHu7SxGEWnHX3OCR7C?=
 =?us-ascii?Q?c1w5rd6wROTGuaq14o5SbTOX1OIojAXUfPhJDUzbKqpSM/1yaC8hdIIqWjjP?=
 =?us-ascii?Q?s5DFmrBA9XbtjUXU/Zu0ydcdtFQvIJ7766cap0O3u8sjRdYBfwaraWsoUYWX?=
 =?us-ascii?Q?udUWFlinj6bYynxTrdXkMS8RmWm8gVkpJMLBMWAAbqEtxUIgq7CuNVpacmEB?=
 =?us-ascii?Q?1BX0r1A5P8aVn2rjBDElJyePQM2AjMo2qFcJeaXyL8goNIpdBrtYD1g3Zvpm?=
 =?us-ascii?Q?vciQszsITEXbTaHmEHgBD9dX6yoaEoJCg3C4r0t3gBtd2LDTk38updpIgxHz?=
 =?us-ascii?Q?aduIub/OnJfkBv2Pf9PbyZLbH+C3Xxo6OBZ1dZUoRiGVzCEZbhXYGd33Abes?=
 =?us-ascii?Q?9dCgBFQGbRAeXA08kbGSHz2bV2euiHdjXTtoZ7gD8EM8HqCsI3Vq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACFB51FC4C6CC7458EC46E310D7E9055@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c28496f-fae2-4ede-942c-08da1ef8dcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 15:59:02.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kG1PHisiLyI6bmwngTHzJBe3cwuyV8wgyYa+EYcNsS4wDDsJ3Rdi21rxtAhVsxdMXrAayybR42H2QvCpbOv/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2628
X-Proofpoint-ORIG-GUID: 3iAno2ZIb91sr-cSVqHCfEgxwTxyIxh6
X-Proofpoint-GUID: 3iAno2ZIb91sr-cSVqHCfEgxwTxyIxh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_06,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 14, 2022, at 11:32 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
>> Introduce module_alloc_huge, which allocates huge page backed memory in
>> module memory space. The primary user of this memory is bpf_prog_pack
>> (multiple BPF programs sharing a huge page).
>> 
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> arch/x86/kernel/module.c | 21 +++++++++++++++++++++
>> include/linux/moduleloader.h | 5 +++++
>> kernel/module.c | 5 +++++
>> 3 files changed, 31 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
>> index b98ffcf4d250..63f6a16c70dc 100644
>> --- a/arch/x86/kernel/module.c
>> +++ b/arch/x86/kernel/module.c
>> @@ -86,6 +86,27 @@ void *module_alloc(unsigned long size)
>> 	return p;
>> }
>> 
>> +void *module_alloc_huge(unsigned long size)
>> +{
>> +	gfp_t gfp_mask = GFP_KERNEL;
>> +	void *p;
>> +
>> +	if (PAGE_ALIGN(size) > MODULES_LEN)
>> +		return NULL;
>> +
>> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
>> +				 MODULES_VADDR + get_module_load_offset(),
>> +				 MODULES_END, gfp_mask, PAGE_KERNEL,
>> +				 VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
>> +				 NUMA_NO_NODE, __builtin_return_address(0));
>> +	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
>> +		vfree(p);
>> +		return NULL;
>> +	}
>> +
>> +	return p;
>> +}
>> +
>> #ifdef CONFIG_X86_32
>> int apply_relocate(Elf32_Shdr *sechdrs,
>> 		 const char *strtab,
>> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>> index 9e09d11ffe5b..d34743a88938 100644
>> --- a/include/linux/moduleloader.h
>> +++ b/include/linux/moduleloader.h
>> @@ -26,6 +26,11 @@ unsigned int arch_mod_section_prepend(struct module *mod, unsigned int section);
>> sections. Returns NULL on failure. */
>> void *module_alloc(unsigned long size);
>> 
>> +/* Allocator used for allocating memory in module memory space. If size is
>> + * greater than PMD_SIZE, allow using huge pages. Returns NULL on failure.
>> + */
>> +void *module_alloc_huge(unsigned long size);
>> +
>> /* Free memory returned from module_alloc. */
>> void module_memfree(void *module_region);
>> 
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 6cea788fd965..b2c6cb682a7d 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2839,6 +2839,11 @@ void * __weak module_alloc(unsigned long size)
>> 			NUMA_NO_NODE, __builtin_return_address(0));
>> }
>> 
>> +void * __weak module_alloc_huge(unsigned long size)
>> +{
>> +	return vmalloc_huge(size);
>> +}
> 
> Umm. This should use the same parameters as module_alloc except for
> also passing the new huge page flag.

Will fix the set and send v4. 

Thanks,
Song

