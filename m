Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF156AF38
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiGGXxE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiGGXxD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 19:53:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2481B60690;
        Thu,  7 Jul 2022 16:53:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KPj3B031344;
        Thu, 7 Jul 2022 16:53:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=qtsXDz1RRyNYdAcoa7PlE22ZDwr+fkr/GlY/qaS2jaA=;
 b=Jwep92g08JDmfWFdEcsTs+U2jCkOuFuXZUAEADwcdXkdMV32MY8RwqvAoAQeumdFNbfi
 PzeprBja13thDuMQZfOUBbZPKjcUVZqCcj2TjCAmtFWzPELLqLLDtc0rbjNzNs7O4RBv
 oidPtnSUQY1YcMK0tH/kPZKxGpNGMB5ZqUc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4ucmhpnb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 16:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLf01WnVtlgSjQtLI/F2MK9f9i7TIt6UFcufCeUJSjsSTPuk4X40lTMbzPlnaZCK59p/V0rFJM7tUu6fSQ/Qs1xjMWO2pGJD1ZhQWHmrI2fZuKh3FzPMVqhFhqDA/Q0IOg5HEOyfGZqpmQN6NY2b2LUtrk1dfI9RBLUONeaQYwd9XDqkBTfiQOP9INLDGiDjyUv7ii1b6a90xQTo7t7XUPLl1LLosIjdF1rVrFP9YC1MiheWFMH+4+WybtmPHcMYVIPClIjZix/OIe+67zkrnw2Ict1GXVL7CoRrIot3ywzB4Wscm9SD0wnWaz8d4ii+g6MlcWryCOMlZtw6ANcOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtsXDz1RRyNYdAcoa7PlE22ZDwr+fkr/GlY/qaS2jaA=;
 b=D2LtY1Q8LNB1WOslZVWj4LlehrlRXbNpHJ9aAtfFuE+vLyfcEkEEsEsFdlsaSZvYktcULnmmLfmLcdeV+JlM7Xr1e7HYaE/5bqLlUOyI2rPeR/6b6XFi5Cjdez9sRanOPJ1jsFNmDWZ1hUdnvI0quekcevrurofBRXkN1lDKMTCjnuLl/EsD7zFIw3APSBPxfU6DzK2GVSupZDOhVsjMuV0Byabe+rvuhczXLR018Tsmv0J/HD1J2Nz3z73tNttTUlMZZKD1RkSfCjFYk99PWs5/h7i11P3m3u/fTERvHBUZDQfRNgGHxIxCiAUiUvCxbBgXicF/AtUOw8GBQmgdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW2PR1501MB2010.namprd15.prod.outlook.com (2603:10b6:302:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 23:52:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 23:52:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YA=
Date:   Thu, 7 Jul 2022 23:52:58 +0000
Message-ID: <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
In-Reply-To: <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 199adde3-c375-4d7a-a63d-08da6073d1bf
x-ms-traffictypediagnostic: MW2PR1501MB2010:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNAGR//4ul/v8MSjEI86K/O+s2NRfL2dwRnxOz+eB8cGgL+5133qc735wbXcQYVhNVrnSRhoVPJbqY17M1Lqk8uAlwtq2X23O//ABl6fAq0jnMeHTzxkVmGMHL0Gy2Vk1ftm1SpUGURXgokDgzSCKFMZWB4L9fMPGIV9IRpj47NOUDh2e0bYBc7PBMz0Ji7ehScj0O+DRONYFF9h0gu38pign/SlEyToyTdCuiumcEmV0vXKhpdE2f6mdRRuTGgzYMhAb6neU2QNGvCeBOz7bvUEjUnFhiVz1Nw7FF1Hc3YtckG5sbYY2rySiLqlqXQuj1LcBvnYu3Nki08pKZeWsGAd3qrQ721aVhmHOfBjPpNKOv/D6orIgaDa4NNHLM4kej8fUcdEj6Z3stS5i1KdG4+s6CpJ6gfEbdw/IBJ9FbgTaQrVRgeuNhvE9d78DcSyygPJjq7Njf9NJd7bH0cOB+4t81BcDJ3vdA1kl+LioY90khBkq/3JXymCY6YL86zjvop+RaUm2+REAmity7wdPbib6ZWmp3drVq5BswCKjT683Qa/q+rviLILdq0yLBbWm3Nw7q1mvmvefnU1hw8W5E7euLwv0B2ULH4RHir9rR5e77DHPZ2tsbtHeF/0fFI8uaFgWqL13+wpiZ1eu3fkrlld5kOhJKVjT2ksUe584IajgERezBfCchdv9uOp5p8iPJXWqIlblBz0DOlDt6ZQ1qrCcu+LDxR0LyXbiyoV6GvePNDd2mURv+2etelr10CKXGunQpJIyy2GtJB86IiZwvztjkpFTZYJMDVBYBjATImj/PjCXsdus+P6Pa21wiVzaZHzYgobDCmAo7AvvhSj5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(122000001)(38100700002)(54906003)(83380400001)(186003)(91956017)(8676002)(6916009)(66446008)(316002)(76116006)(66476007)(66556008)(71200400001)(66946007)(4326008)(36756003)(64756008)(8936002)(41300700001)(478600001)(6486002)(4744005)(86362001)(2906002)(6506007)(6512007)(38070700005)(5660300002)(2616005)(53546011)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PryokDnZXhEJwUwEvCpbDxzYTYDty5rnVrpj2MG3ZhwQf0tRzCpngb5qe5uk?=
 =?us-ascii?Q?/SeV9LZ3jl6dsTUuEq+gYGKNU4HFfDh9ryY6a1+BMTETxh85U4gXTPuRYo04?=
 =?us-ascii?Q?Nr3Sg/AHc6Pd9Ahz02X966UyfXT19RxKfysAdkIbw/yW+0EwvljzsAC/u9ch?=
 =?us-ascii?Q?t4vcgyPRY7bGYsTrUxjbJ/QRWgp450h32yCVEGisWoy/8a3NXqfOR2TkK2Ie?=
 =?us-ascii?Q?ECYPQcOQDg7ROfdOyw+DuW9TuGxTtCqL9/lBX0iKYz6w7MZDNNPYgM7sqTXv?=
 =?us-ascii?Q?4mRlJvqqP9TygbdrBqO+EeKyr5JYVU6+Y3FDBTD/ngmEB43kylZNpO6t9HH2?=
 =?us-ascii?Q?aCLcaM3CGcfBapEiFBhuP0bWfOhPnOjz4ydOCJ9qOeaYJxdHnfx+uR9jlfuP?=
 =?us-ascii?Q?YDXqZm+xDSqLcpYM/GYYszUrvHzGTVaKTkRHpHXi9gXXPy9e30x2z6NQEtEL?=
 =?us-ascii?Q?frVxOptZ/jDBaP+6PlNWKQAjOHY8/Yu5f7A+E/3iCiGZarNARM+mKVBBSmBa?=
 =?us-ascii?Q?BXzk0EFw/Hm818FHQCbtb6NnSKvGEvQOqcr4hfw1dlnKDgAX3E5a0Wp2LIeX?=
 =?us-ascii?Q?GtTMfEvRPSKjHCa6Lt6XCsKBl/xLzNP7mfKdVQP2QAn9m1O/Jh1W9o9Q+zAf?=
 =?us-ascii?Q?3+vKcvbuNmiOJT8l7Ta2bQ4i9l2G8KvkTUVsTYzUoFGqF189LjsV3Qa7Ujv2?=
 =?us-ascii?Q?zfe98djtbL1b1/WZKXp5doJ+mZ2m1KBcHNhR3x5A+EfVYzYv6LooWLOff9sx?=
 =?us-ascii?Q?EPsv8ZfyOKL805V380wyL2WBq27G8/vaoLnezleTRulbdK7PH+uZm0Za9f2l?=
 =?us-ascii?Q?OhcHZux8aKUY3esifzEtG1CuMDzbxwLyly8b9r0MbeOETOeAzttRCAShPBT+?=
 =?us-ascii?Q?h2aCqN9X49rqbPObARMGakXJYM5jUxikrXOKMU505A6DHXdFY8KMawmdAIaD?=
 =?us-ascii?Q?3BQ+zik8gVCrUzU2RDFJsYkVeVMfgaACCtr16DUlP9gagnh62nC73z4lNYrT?=
 =?us-ascii?Q?aBdUoyKBG2fF/+qi0HLveHaSWRENRgucPx5gZ55O5x/ZKGHUSadvW6FrYH2l?=
 =?us-ascii?Q?vTwdq5Q6ti5qADGvzDkKyshmPNYBkqhVbosOKnpqlsP3gTuIwf/ljSzVVhTW?=
 =?us-ascii?Q?PFvp9rS7ezKKD2o0k+xUgU9RrHqxPnWCvpyVbbBWbc9PGE8WMU9jU2xyVFlL?=
 =?us-ascii?Q?i4LlBK9fikKlPTu73NB4Ct3c+mR0K2MDYDOtjuhQVjuQOLT01wY1FlMerKJ6?=
 =?us-ascii?Q?qgt8MHOE0FSDsw6ll6RHVE10qOKS5Q/pD5eaJRGoqbX8A1798XaxFrsxiPFR?=
 =?us-ascii?Q?xIyvdySJSpWQf/TADJQVHT+X1k5Z4EP4ilz/02+6FXdiIJnTh+78b0RP3nqb?=
 =?us-ascii?Q?ty2aLCSn8QncCd5dV/9KxBuZOyF5ZEQkrXPAWCAtC+I97R0HadYEytOyzyOt?=
 =?us-ascii?Q?BFYqfZJgrr/syg3CK7EyTL2jRq0LZpn2LkkkL04sVhjlmmaYn+us7OKOZeJk?=
 =?us-ascii?Q?ZpbKqBCIx8KTVFwZi+2IuGGgt9JFrR6VXsDVCeo2EZ0s+wk9vumrau0BaUu4?=
 =?us-ascii?Q?kx3KbwdyCNWnDe0dchj+9pP0BZxLMltUSvoWhMyODboaSEgtiwUB+Uww2C2n?=
 =?us-ascii?Q?UQJEZQVrIv8D+xGlCaEexPc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7681E458D4E82D41953AB3A26FEC06AB@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199adde3-c375-4d7a-a63d-08da6073d1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 23:52:58.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMG6VReO988r4u+mmEcOK5zvgXdS6CVoP2HghhWroV+ztZyMPeMk6hlDUipSh9fcYGHsJztu7AuyPq/URF05BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2010
X-Proofpoint-GUID: aMYR3SAiydsYysZZpZKsUQ064WWpUc98
X-Proofpoint-ORIG-GUID: aMYR3SAiydsYysZZpZKsUQ064WWpUc98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_19,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
>> This set is the second half of v4 [1].
>> 
>> Changes v5 => v6:
>> 1. Rebase and extend CC list.
> 
> Why post a new iteration so soon without completing the discussion we
> had? It seems like we were at least going somewhere. If it's just
> to include mm as I requested, sure, that's fine, but this does not
> provide context as to what we last were talking about.

Sorry for sending v6 too soon. The primary reason was to extend the CC
list and add it back to patchwork (v5 somehow got archived). 

Also, I think vmalloc_exec_ work would be a separate project, while this 
set is the followup work of bpf_prog_pack. Does this make sense? 

Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
more efficient to discuss this in person. 

Thanks,
Song
