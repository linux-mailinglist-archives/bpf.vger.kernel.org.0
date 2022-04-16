Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D345045AB
	for <lists+bpf@lfdr.de>; Sun, 17 Apr 2022 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiDPW2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiDPW2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 18:28:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0C1EAD5;
        Sat, 16 Apr 2022 15:26:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23GM7Yco012894;
        Sat, 16 Apr 2022 15:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=baKYCJQLmPKkGSSbQe3wctxLX2GG55EcnJsTKwCf3W0=;
 b=G0vciNEXAEiJv8c9TIzx3bQ5aL+hQ3wdiSDJKea+h3cDyO4YwyHz7MAOrCaWz5z477JI
 nA4WSnTni/ON337SrBtm2OOkTYJ9xvhd5C0rKwRet4meERqeXtm7Vwhzv2RSJclW1Dyf
 a7lt7i/jwEJH0dBjkNfn57VPYYKEaZc2z5I= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ffs4nja8y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Apr 2022 15:26:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE/Sd15RVFdj1tDQ4+SO5DC6N14EcirCTLukesZqr7gL5wdvEGrL4ynzE6YmGtzgYtrBSAURRMMfqqYI/LsUpFUciVjI6i7PRs8Hp3CCtk8Xfy4+nQ2n+Q+Ai0zS2FuxaXfUv5iQCphQVlZqfFiC9N0dJQ+8l0la8Q61MGAOSsVW6vhXuH9v8OgcMRiFcOniBE9+B3kp8dsP0xeVvXPOUkepae6gjnUecl1B3JHhjbm0KNyH0SHT+tlKr9LDyq/gnOq64NHPd1WIxMvQ1tX1u5qr/t5FpF+fD4kH6rKuEFr0tAFt4eFJiBW8nQ41oPkr1lV3ugNdpe4/K20dNwtcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baKYCJQLmPKkGSSbQe3wctxLX2GG55EcnJsTKwCf3W0=;
 b=gDkYK7FcudMJsakifGwJl4LJbM6x7OWXGya2calqNApjF9UsDTXx3wEoCxRMVeysYLxM4uArm799cHTGU32GQgI3YRNm2ciiCce7fwEjJhXSwWcq0tVYILUEmf62A/eCAdMMF94hyLrfpQpXz93jM3zWFLO67ewHKvWKOc/NtLN/eFjuN+JLEBpkdA1r+39QFuWfhKFqAIAUyjtCzz38TBZbNvRspTqZBcl3Qm+fdKJTdcO/8c6hwHv1lZMVNmFPms3Qeu4Ch2zejaoA3rl0gCh7YHRX2k8jWlexrJxzh0uhZsvVI5Wl1w5e+VuHfFXdwPH14krnxa4OFZMH7rQKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB2779.namprd15.prod.outlook.com (2603:10b6:5:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 22:26:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%6]) with mapi id 15.20.5164.025; Sat, 16 Apr 2022
 22:26:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjRr/eYt5HVI0ucQZg4JV/u/6zxVckAgACoe4CAAPedAIAACgKAgAAgN4A=
Date:   Sat, 16 Apr 2022 22:26:08 +0000
Message-ID: <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbb97aa2-6b77-4993-f33e-08da1ff81a9d
x-ms-traffictypediagnostic: DM6PR15MB2779:EE_
x-microsoft-antispam-prvs: <DM6PR15MB27792E569C0BCC8FABF33B16B3F19@DM6PR15MB2779.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXyKXtSvyZ7i7qK/JMpn/6hxhTMuMndHQPxTNNm0uAD2yMBX+JRM8PBEL9XYn3VUZIpFChR4V50FLrH+59OarUw0YvSyMCvtSjC4oiU3gxEgKmo9SfcVFdx6mtEtfXC4uiCGZsCBplr6G5PnoQx6XNmbHvYkvGCMujwuSQWjm0RBMiSyt1g5b1fnNirBkgvZNSnpwLFTCdEsxpUmFqCm2HREjKNyPEDVYfFxkN2WzZ/eFAxghuCfmnJ0/Ep7ptsmxOER+zHz+oRfgmx0gsbraUIlQBtt7wS7nfl/BfDvuryDY7of+YHSpX3M88RYfH9fGw8qysvX/L2/A4nMI8IExqYDm6DkbKTpFEHMYSq/GdyT6Czny7KVK6doV/fmGmgNp6lUqxzzs12JlUwCP4kTjQAlt5JHSU3YIfjJNbYGC9XsCxIilD8KWX7m1M/2nWlNJ0rlDgtdFHmIDQ2kS8I9gnPrgckFvysFqmeRWzw0hMSOVAoVSRnoBXv6BvYWwf9Unve6xpHcRfiEuDfoIL3estxErxWK35x2ewQTuIGWp5Z4cn2xSk7wIkR7S27kzIrkkRMme/ruF+o/384KOsZJiadzzFMwffQUCr7K+vmuSX+5ZjNgR5f12WXtlxl1LWf+WIVmr1AoiFkiG8pFR70tNCtafvNAQsiortSOxbIeeMZ6z12RAsj8Kq8o01yiJpm467C3OUqw2KtVXWRE6sQ0FKkJZkqK1inIKy6kevR806zIBP+coQ2hoYYZVCV8o7jGpVjTEHzHduSkYcc6W8xFo9J1beeYp37SyZm6In0uusCwMACwS9Q6a6qEUDtYSFI9fDiqpDiLGj8bBrnVReMyfUaqyXGDeIKrcNDp+U0rOFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(2906002)(6506007)(53546011)(7416002)(33656002)(966005)(86362001)(2616005)(64756008)(6486002)(91956017)(6512007)(186003)(8676002)(4326008)(66556008)(76116006)(66946007)(66476007)(26005)(508600001)(66446008)(71200400001)(54906003)(38100700002)(316002)(6916009)(122000001)(38070700005)(36756003)(83380400001)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nbB/K38lLO9mtb2SXFJW0cT6edhRNYd5NFExNSvrTmNaUf3lY8Bkgx/CJ525?=
 =?us-ascii?Q?gLjkEfIUdEFrD00WaykF2EqbVibUA1UoZ+EQh3x/pYv2VQcBF+8G4QpP1C48?=
 =?us-ascii?Q?7AfY3IXz8HNGaflBFYnAPZOZZ7vOyVMzdaL2KKIVy9WOWe+Clp05MOqqreAB?=
 =?us-ascii?Q?t/K/RW2P7Lm5HtZdgg7HWgaNkDr+081DWfNNhDO5UL7LQtLRl0eD+D47YaDE?=
 =?us-ascii?Q?qTsos+8Xc/x18TyMN2TG9PUayx9nqqXlBWYWK8LUN9pdk7/87xCvdt4dYykw?=
 =?us-ascii?Q?AeI5BICmgh60NweMxUCaig7Qo16sm2quwaIO9ecc4H1OAaUAhmNfDJUbudLb?=
 =?us-ascii?Q?zXQYSFqEhMup14+GJZQZluy0BVDsPAp2wqFP5bRDEJnEswkXuwbA3jaGxhef?=
 =?us-ascii?Q?lpcP2ng+V4EKSsz1xXDf6a8lOOoPgWdE0Bxo6+ubkF6L4HffHI3JqAv26WCO?=
 =?us-ascii?Q?7R3XWnA4Myop+m8TTduSH/AnTc/b/ox1WcRjW1FcuCAlGSI42lclxA2HrJQB?=
 =?us-ascii?Q?XORgeDzh5L7ISeUjxhSaSMnqB4BVUWSSXkHtwF30JziGDmvn0kNbcBFcwH05?=
 =?us-ascii?Q?XBFkwUhekU3nso0FE2nWLwjPgFGHEQuCFihWQxhTrJWq1YT0tIR9OA6tbyEX?=
 =?us-ascii?Q?zQh6vFsVV4CbgWszDSNyQgb9SnEHH8J+RBrUSruzbT85oU5jkXxaAvQ8unGM?=
 =?us-ascii?Q?0H3TDZoLrc7CwFChjmEvs+PRxGg78oCp/kSKBYXKx3RcJaECytKmn1GCUXQv?=
 =?us-ascii?Q?jmuxblrHDBfZ6YXD/Hk8m+eT30ZaKITAXV2PAWOr0+sCOiE8PEElo/o2VZBz?=
 =?us-ascii?Q?8c6yC+qO2tHwUwQqMw7vxFGOynPKosUepkdayoM4bW5hB4Dzv4OqLCna9iXg?=
 =?us-ascii?Q?Yjh//7fmrnziKMq1fyakE2UDTs3Dr7QmPr3gHx9SZOjRF0kxZ9e1KWtJo+lY?=
 =?us-ascii?Q?TsKUsVhMq6DF9bki8VJ5ieX5lxLQnnNsG3P8mb6+i6h8xMYfrW/hWNRouJJL?=
 =?us-ascii?Q?f4OptiNuN6ReC80zloAGSxvD3LVHHHtGAQwCHxuY7Y6z4bQVIxalRflYNWYD?=
 =?us-ascii?Q?+kgEe0RLprIaLMSFTNx9jU4K2BYKMYMmFBODu2gjJjP4Dis+N4U1FH25ol7i?=
 =?us-ascii?Q?n+H4LH+INy0Q1BNK/WwxKO0N6ktrrGMAeMMOCEyrM/+wzq6gnB8RDrcf1zJe?=
 =?us-ascii?Q?QrK4K/rH/O1sOxV2uQMxwdiOBeNwQPlZmQ46ZQdMy6KDiwzI0Qg9d2/6wPzi?=
 =?us-ascii?Q?JNC0ISDqlosptoQH7XWmLYF6QqWoZlb/6rQ0YstnBxxECB+KonGfbZmP9059?=
 =?us-ascii?Q?vYz377Md/qJcx/ICihP+p07FkyfuKm/ba5O0HOt5wXnn4vO2sgz2Rhd0/pUI?=
 =?us-ascii?Q?NlrCoMRArM7xnIG7/ELQUFcSlzL6NyS/NP6f4j+6mZFyVv0VFBwSZparoM94?=
 =?us-ascii?Q?IJzTtTE+dfHJ1ltweHCrRIomo5T3dBpZHIz6H9eN4M5qNusDlpMnVbt2RZPA?=
 =?us-ascii?Q?+efptb4xWP+GRc61oQwvzBGLsXeRt+EfUc7JS32oQA3tOSVtsfdO2mTu0UcW?=
 =?us-ascii?Q?VZCQJYUfjzZpCTN1goZdjzy4PE74T8Knaxc2H94fXocFx0ybBVs3h6EwWE5U?=
 =?us-ascii?Q?wdlImeNrbMYf6Q26CvdEDfkKsi3SY6kx4zhl4GSiQNtP90VjxOtylKa19Xwn?=
 =?us-ascii?Q?3aF7euWKgFXzjpDDZobHhK2zSbY2jCp4KJahcfKb/2Ii1NASbwpX01dXDBa/?=
 =?us-ascii?Q?+udGXF/xGae1x9GGULpNCFfqnd0hWWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F6AC032C4D77343ADFD365BAC516D8C@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb97aa2-6b77-4993-f33e-08da1ff81a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 22:26:08.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWwH4SepcRAuW/a7xsI4hO2lmK4/dk3qOXuDQY/DiG92vuUTYKsRP0Rr+ybCshsp0l33VACi8eTJi4teaISudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2779
X-Proofpoint-ORIG-GUID: gsB44UVeoGKse-r4QkzAtHIvTKxBF4Wu
X-Proofpoint-GUID: gsB44UVeoGKse-r4QkzAtHIvTKxBF4Wu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-16_09,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

Thanks a lot for your kind reply. 

> On Apr 16, 2022, at 1:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Sat, Apr 16, 2022 at 12:55 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> Based on this analysis, I think we should either
>>  1) ship the whole set with 5.18; or
>>  2) ship 1/4, 3/4, and 4/4 with 5.18, and 2/4 with 5.19.
> 
> Honestly, I think the proper thing to do is
> 
> - apply #1, because yes, that "use huge pages" should be an opt-in.
> 
> - but just disable hugepages for now.

Hmm.. This sure is an option...

> 
> I think those games with set_memory_nx() and friends just show how
> rough this all is right now.
> 
> In fact, I personally think that the whole bpf 'prog_pack' stuff
> should probably be disabled. It looks incredible broken to me right
> now.
> 
> Unless I mis-read it, it does a "module_alloc()" to allocate the vmap
> area, and then just marks it executable without having even
> initialized the pages. Am I missing something? So now we have random
> kernel memory that is marked executable.
> 
> Sure, it's also marked RO, but who cares? It's random data that is now
> executable.

While this is a serious issue (my fault), it is relatively easy to fix.
We can fill the whole space with invalid instructions when the page
is allocated and when a BPF program is freed. Both these operations are
on the slow paths, so the overhead is minimal.  

> 
> Maybe I am missing something, but I really don't think this is ready
> for prime-time. We should effectively disable it all, and have people
> think through it a lot more.

This has been discussed on lwn.net: https://lwn.net/Articles/883454/. 
AFAICT, the biggest concern is whether reserving minimal 2MB for BPF
programs is a good trade-off for memory usage. This is again my fault
not to state the motivation clearly: the primary gain comes from less 
page table fragmentation and thus better iTLB efficiency. 

Other folks (in recent thread on this topic and offline in other 
discussions) also showed strong interests in using similar technical 
for text of kernel modules. So I would really like to learn your 
opinion on this. There are many details we can optimize, but I guess 
the general mechanism has to be something like:
 - allocate a huge page, make it safe, and set it as executable;
 - as users (BPF, kernel module, etc.) request memory for text, give
   a chunk of the huge page to the user. 
 - use some mechanism to update the chunk of memory safely. 

As you correctly noted, I missed the "make it safe" step (which 
should be easy to fix). But the rest of the flow is more or less the 
best solution to me. 

Did I totally miss some better option here? Or is this really not a 
viable option (IOW, bpf programs and kernel modules have to use 
regular pages)? 

Thanks again,
Song

