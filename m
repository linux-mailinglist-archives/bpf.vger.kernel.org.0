Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF0503815
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiDPT5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiDPT5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 15:57:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BF17A9B;
        Sat, 16 Apr 2022 12:55:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23GCM3sX022228;
        Sat, 16 Apr 2022 12:55:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=S+ayeODOQIxJVkWtaHHAwrI1XJG7O8QZJWMpqYXJ7zk=;
 b=lQ4xUrqflpHwDMhbkAQszhwmiPG+Rp4s6sEbi5S6IdksQChyPxmYMY7NTmKETzcgTJr7
 NWhYkUAFdRstggl26tCKb2HCzjaA0KO6lOk7fFrADCa+QkdYcy9vEF0TDkrUHykKsJX7
 GAIJ+RnGX+/AxRE/1AE9NNiumSe80IXKF4A= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ffuax1kbv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Apr 2022 12:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0jEghyczfQf+n+TdiKI7IavZVd7SmMoFFu9w7GH9G/J5B+R4LJLuIUZAdXdfnAiiULmIH2A+a2+7cW96krPVlCd5vf+aCt3QggSejvS/cK1f/nVvjAAdBKqOWzvBtkavRxOdHfF+J3D2nBdz1PVi1ysOvMgRPLFgqmCWiuzCHYv8fonV6A4n92LGq60g7AhreVXK/BtJZujMB0uGbrV0VWgWNWnF/zRR4eKe4USzUZtg//YXQNyFaqg5K300YW3oOZCaCJmFNW40e7yk91OYIF5tHiWOFaWG+ccIfjZsguD+aFA4t7//jvA+pQOKSgGYVyWgKCurvFtIUVOYqskzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+ayeODOQIxJVkWtaHHAwrI1XJG7O8QZJWMpqYXJ7zk=;
 b=UWyDR67w4mFxKWhOH1a8InKfS0uK1f6+xWFXvGvMJsVCud/bUq5wBch0QwezVYDGGvIvIAun1+1/cAOyJzgPB3YxYIZoyZrtg6bJcg9m8+Om15B8j2DUVghQP8fdd8LKRS3sXG0RwQuSy2dzUwVzxG2G8s3G/VeI/iL+cYMPiB2KgxgEg/CqOumsB0erniuCHBAccx27lvW1eC8L41llV3YEMcFd5DEdVb9zuRPCndG5E9crEJHmYCXyGSM8SmOS8fYocorXG3qjBDh1kLM5aynriBVUl4rKt2CN4uZQLFZyitrQ27W4hzEiuyVEzrffs8EtZMuw26NmC/vEr78J8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN8PR15MB2882.namprd15.prod.outlook.com (2603:10b6:408:8b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Sat, 16 Apr
 2022 19:55:00 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%6]) with mapi id 15.20.5164.020; Sat, 16 Apr 2022
 19:55:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
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
Thread-Index: AQHYUOjRr/eYt5HVI0ucQZg4JV/u/6zxVckAgACoe4CAAPedAA==
Date:   Sat, 16 Apr 2022 19:55:00 +0000
Message-ID: <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
In-Reply-To: <YlpPW9SdCbZnLVog@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63155dae-8eda-49b7-477e-08da1fe2fd99
x-ms-traffictypediagnostic: BN8PR15MB2882:EE_
x-microsoft-antispam-prvs: <BN8PR15MB28824EAC4CFF931E0556551BB3F19@BN8PR15MB2882.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ac7W6anENq4Nl81j7X74QR9vHXlb5cnd0RHF1WhiILvTAju4BK2A6T2SKAkrzVgvl+aiuVl9Uk4+MYUVcePHTnJ9SEs0v7qC2yUJoX+/quU4/bRyAdP+M/f2z+CP8b2UF1EtztD3a8xbDopUh+RShksUVQBfoz1EgaTVUYNglwUOg9NF58DSO7iKga84owekVFHlj08ydOR+u6UZT9Vjn63vNUbTh7vmtzt5LBXGDUu7J9YdAPtTdPkzXR3y1c05hGzASuSRCFOrnX8d8qpQoFlFIMIZ3Wt3xzjyYbfNRoOVRuVk6AaWyuyk9fa65zEq81N5lT8Gk3sLnQewD7tPOXXrhgucbkMftB2mvBUs1TFPJN3xCsc3afvVU5mDBhN59jGQjH4r2g2eOUC5uHuvyADtGL6JXG5e9mm69RCgP67yrI3ggj3h3YLTjIj5LJxxEJXbv7xi3UJGWHzGqxLF9VIQU3JRvhINgMRixhufg1xn2USoSNB+cTO0a19H5RBT28Ap6QsD2a8yYmhTvk0/LmFTKy8gTGSDfmKOzayzObNIMnPoGwhm6XO+MIgHhZhgZDxfE1x8bQg287i7ki47kc6WR5yULNBETllJMzAYHFjLD17ajoaWIiUqsx3MpcwwnuNz+Hg/ALdEo8/xN1LqoExMqGXwutJ6wXAv2R71RqLlUxzA4fhHM/dJmNlR9fn8CHa/2K1qw7KLUyXI3ZPVYHWdb74piCa4T47KnMx5d92cvwc5cLLwy0tC08Ueenaw7O9wQ0QbORzlDrsaKYtAJ5UhNlNZVYRgPnUbh1j4U/MN7gaSbwnGR/z7jDCnp203l0PMIiBN6cFPst4S32leW4ZFAOSG27mtG2ttyiCDmOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(8936002)(64756008)(8676002)(4326008)(91956017)(66556008)(66946007)(38070700005)(76116006)(7416002)(122000001)(86362001)(5660300002)(54906003)(33656002)(110136005)(316002)(36756003)(2906002)(6486002)(6512007)(6506007)(53546011)(966005)(38100700002)(508600001)(71200400001)(186003)(26005)(2616005)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LB2lqU+e9hw9MosFMILJASzzJAF1/OVe+FriN+OfuuIIDC0DLxc/+A/W2+tK?=
 =?us-ascii?Q?ca9Kn33QWRhtyg01E5GJCL9wT7gf2zUOcFTvP/pJi6j6FN2JkRuOIRl6jud0?=
 =?us-ascii?Q?r52KRA06JlQwBkwLGm0FwG3q2QEqBd+6IxTVFe0FB6oXFIx4FSX0HOzNIInt?=
 =?us-ascii?Q?wg1kopzBMpvXRPJj6FG3Z/iWCh2LmUmtGcL61+1/TK5wpH43bridh/5v902A?=
 =?us-ascii?Q?S4i7J4gEjoICSpXXGvAF2J45hQe6NBnd/jqUDLS8SjhrTvRRnT8BpETQzDFh?=
 =?us-ascii?Q?tsKxSMh/LADolbek3j23XkDuVVxCF/sGolvapGQZPGqTVesBlPNmn9FLZ9IR?=
 =?us-ascii?Q?R84i3/YXFEW7nrs3IenwhY3ArKeMngFdYwDDBa3iiu2EPtAJmbr5CRpNkA06?=
 =?us-ascii?Q?45UmRredXjJwkOZy3G83hVLCfqtzWFxzw3hnniPzzACM+1W7x5OhB0gRC5T+?=
 =?us-ascii?Q?YBXHa9tfrvTZMyzNOSo76q9eE91/MJrnaVQ98rWf4pcZ8BSDgeQJL4pnkRRZ?=
 =?us-ascii?Q?+9HpdsBDDkBTPaUPfbvmlGJJOeSxNCh0eoNvgW/zsNr38Le5NniSuzvdKBGN?=
 =?us-ascii?Q?SjO2pHIdvRm1X8oVI2ydC93sNh8XL2vgubCnKVbOfs0M3qLt9GFeDS8g+wsd?=
 =?us-ascii?Q?wJTrvQlycMX0oipvZMcx7WEpOQHS6jN7woKHOZJ6hjp8c5bcRji7Lqj+BlB4?=
 =?us-ascii?Q?O4A5d+CygcPQfcRE6gHD5XmL8vo2I1zcYw35BVD4n8daLXqy1YvXZO+ybYSU?=
 =?us-ascii?Q?xSkvseFI/V9ZQ9pJ0fbmZTAxEnpauERbz/JfOagFUScPS+1et3gToMu+NPjt?=
 =?us-ascii?Q?A9J3uKJvaaBVWcuU7zoPCZVQ9TmwmDvXSDElSat17qbHi1rMmnGmT+g93UAL?=
 =?us-ascii?Q?g8vmH5qW5ElKaJu69cqYWf6HULQ03Q3ciVYzd0Gpzepi2AZDx/bJzHbK6fnZ?=
 =?us-ascii?Q?SYN34Q5u3gfAjIyBvG+rzbt0BatNFjjOSX0VSMFzLjFwX5rz0Ir7Z5BvOM8s?=
 =?us-ascii?Q?rt3XhMOFh2VUHYY6B/EnfT1DRlMP5MNRwgKwpsgOC0Q2CQwPG6WrAH+92pz9?=
 =?us-ascii?Q?vaPsvfhIM7ikSCnRDjtuVrZ8yMOGa3/1AaKpE+nSpKtdbzRDve5oxW/+sErc?=
 =?us-ascii?Q?5GP63+1QpJSe0uosI27AcMWQvDzl/H1hwm54fCGm0zqJ+En5DgYBFkwBRJ3G?=
 =?us-ascii?Q?9QZoQuR3yFf5t7Bus8uwUI7te7JNyyNL8ekB4ApoczbwGQCTpQnvowslbMcR?=
 =?us-ascii?Q?bXVDD8Ul43wp2GaJN2IfRMjIL74zOQRWsHR9YoipZDiLR4IjIT6VhMJVkuLo?=
 =?us-ascii?Q?sdxKl8eKIQosBxGcwJRt8zZGPB8lUMofdld0mAkcXV63VfdKawLfXbWlQH9O?=
 =?us-ascii?Q?EZ1oJsc0McMtFYKKmr4solw/bjyeU6bgrvYyHee+/V+tQEREeOftsVqn4+o/?=
 =?us-ascii?Q?LL33G1RpehY1/cCnMq6ejpsk8RAehjml9A0TwZj+6olIO5x/Jjn2tcGfhanr?=
 =?us-ascii?Q?mfMjEy9hG3fvg4+NxVk5WeS8UWVVCYlr+uHu9wM5ytywZPnJj5p52BkveSqG?=
 =?us-ascii?Q?UxxqSJWVy0rxQItQErBYr9s+Vy29KTp4VDIqm1NPWzNvE2bfgYDCgRbbnUNy?=
 =?us-ascii?Q?sF32Mu4LXmRGx6gKUwg5lGvtuNFqvHai+15VkwrUeuls5YHl5hhWJyu9KOT1?=
 =?us-ascii?Q?4QzqSJ+lqnjoqNwv+fNeHOXHUuriMer/nrR5UmxrwRptggM7/pmD5kp8PqiX?=
 =?us-ascii?Q?uiliuJHIHPEPZJm6sPideqJv2MO1uy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAD8ABAD9E1DFB4F8BF7E00F388E316C@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63155dae-8eda-49b7-477e-08da1fe2fd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 19:55:00.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27RHXNNGuJwC25N0VC251Jf1HxFwLcXd6K+jfsyyFfxRVi5tVrFVPvVA+pbHH4r5TEjmpRB0Cu3t3B37LQxydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2882
X-Proofpoint-GUID: bJxexOqTTyc8jVwJJsSQTGpDj6NRE0P1
X-Proofpoint-ORIG-GUID: bJxexOqTTyc8jVwJJsSQTGpDj6NRE0P1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-16_08,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 15, 2022, at 10:08 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Fri, Apr 15, 2022 at 12:05:42PM -0700, Luis Chamberlain wrote:
>> Looks good except for that I think this should just wait for v5.19. The
>> fixes are so large I can't see why this needs to be rushed in other than
>> the first assumptions of the optimizations had some flaws addressed here.
> 
> Patches 1 and 2 are bug fixes for regressions caused by using huge page
> backed vmalloc by default.  So I think we do need it for 5.18.  The
> other two do look like candidates for 5.19, though.

Thanks Luis and Christoph for your kind inputs on the set. 

Here are my analysis after thinking about it overnight. 

We can discuss the users of vmalloc in 4 categories: module_alloc, BPF 
programs, alloc_large_system_hash, and others; and there are two archs
involved here: x86_64 and powerpc. 

With whole set, the behavior is like:

              |           x86_64            |       powerpc
--------------------------------------------+----------------------
module_alloc  |                        use small pages 
--------------------------------------------+----------------------
BPF programs  |      use 2MB pages          |  use small changes
--------------------------------------------+----------------------
large hash    |           use huge pages when size > PMD_SIZE
--------------------------------------------+----------------------
other-vmalloc |                      use small pages 


Patch 1/4 fixes the behavior of module_alloc and other-vmalloc. 
Without 1/4, both these users may get huge pages for size > PMD_SIZE 
allocations, which may be troublesome([3] for example). 

Patch 3/4 and 4/4, together with 1/1, allows BPF programs use 2MB 
pages. This is the same behavior as before 5.18-rc1, which has been 
tested in bpf-next and linux-next. Therefore, I don't think we need
to hold them until 5.19. 

Patch 2/4 enables huge pages for large hash. Large hash has been 
using huge pages on powerpc since 5.15. But this is new for x86_64. 
If we ship 2/4, this is a performance improvement for x86_64, but
it is less tested on x86_64 (didn't go through linux-next). If we 
ship 1/4 but not 2/4 with 5.18, we will see a small performance 
regression for powerpc. 

Based on this analysis, I think we should either 
  1) ship the whole set with 5.18; or
  2) ship 1/4, 3/4, and 4/4 with 5.18, and 2/4 with 5.19. 

With option 1), we enables huge pages for large hash on x86_64 
without going through linux-next. With option 2), we take a small
performance regression with 5.18 on powerpc. 

Of course, we can ship a hybrid solution by gating 2/4 for powerpc 
only in 5.18, and enabling it for x86_64 in 5.19. 

Does this make sense? Please let me know you comments and 
suggestions on this. 

Thanks,
Song

[3] https://lore.kernel.org/lkml/14444103-d51b-0fb3-ee63-c3f182f0b546@molgen.mpg.de/
