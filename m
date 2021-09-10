Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1C4070E7
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJS2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:28:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIJS2t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 14:28:49 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIAno9024830;
        Fri, 10 Sep 2021 11:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=JWeE8Gw6X7CcegktPUEqfsMzq3RlojYoOQLIUsOY2uE=;
 b=L4KxmcZl2xIUXyOtt4XPZY2GVHB7AT4CPUM/RQaaUMupHPNIlQfk3jATau+jQh5MyIvL
 MwuVdna1On0bs7JsEX+rrRrwlZtC/9ggQpVujzkGhnGsZvXXQlNBx5LqFc1pPnbwn0KW
 SqtVdDhn74RxgAt50ZS3sO1QdDTs2m1MRsc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgk6pm0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 11:27:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 11:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwvjlAoS3Wl0PWGth6Uv1dA5vWTrWLTjj4GQLF7kNb3iSf+XUB8apOgbY5jUZ5o3RKWGbiYLGQqfmUPxugWZVBgQuDsHqJIdiu8dHUVBAplYLhhfv7RJfCK3XJ3kaW/nzaxEbWuMgXPNu01YwTgAVgd6NIok/xjGkNNX+9QatxoqdlCuzzztEx52pfuPL44G/T+1jYrGdvs/QQ2Z45EzzIz3/YS+xtbJJfZfyX0JHpcl5p97iHMTH02rZN1HIa9LP+o2/L66Md4+6l9jhO8xb0edxYmpUTr8YKLBT/ugWTSXyXBmfTtx7/PSTP8hfUK/60hF2iQhFumkGh9Ug5FUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JWeE8Gw6X7CcegktPUEqfsMzq3RlojYoOQLIUsOY2uE=;
 b=Bb0CK8atKEjwPF3SlnS05igJ+ok7tR4PyrqroiIorEznlu9V8hNsQhTQSzWzZp0o+ooOlYJB/bHMfyD4sw+r67V6TeIcuUaBMBIekc5BMIkKG1yoe/gMjFhWS9HyAHYfcW6KcR9pmLEPPalOnsCf8bFx1n2DxwXlver4x14GWbW24DFNmPxd0vBNau74iG+YYZxIQtHdsjIIWfCNIO4ssX7jdTR2p0j93dF3UwFy8Xap6WSTlz5X6ew7cOrA/IVWRF7blZ7weTI3rh2txW/7rziYRQP3udsC/tqiUDVu0Vc1dN9GxxgpbA/Jo6y93hkJOQwVGZ0ckJ6ghjJCO1yRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5093.namprd15.prod.outlook.com (2603:10b6:806:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 18:27:36 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 18:27:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXpCby8uzfjDX52kWXwjwsop4wLqudGFYAgAA1/ICAAExtgA==
Date:   Fri, 10 Sep 2021 18:27:36 +0000
Message-ID: <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
In-Reply-To: <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64af5241-7c7b-4166-a390-08d97488a9e8
x-ms-traffictypediagnostic: SA1PR15MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5093B297F350330F16E42763B3D69@SA1PR15MB5093.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jT5pCd77bsBBBGQUsSMNH7UhPyOrSt98TGn5ONiIf46D+Y3WMEBUbol7AKyJ0qIUASvRBxm42Ac6hHvMHtPCynHlAiBXMHCzul+/6jAeIo40hQqX5uSKe5jvGAIpwf8+VxoQurKazZZm2/0dFfsev40JTXwcg81PElat3ZWf3F52j4hSclFiXuZpAirCtqZAk8j4AlUXO79eUn++irD9ZIU3zwi4jbe5c8YzE7KsGQKKsFk/7UCnx2dw8TE1vlz6P4Qi1RpTjjRcE+XE/vO03GOd4iwXjGty8LiBzWpu11DVLh4Y5jbjng+DKKVDnq+JcYB5y3TkeCwRBxr3+7TNcEShzJR0fV58CP7f730w239ykKF2cudm+kXGITFyjw46SVx2KD9pF8V/Y5JsekQC1bPoG5CAZf/KCrpF6SmuSyCw3z/mpiGaSekdEsuUpVkNbgX9QaifAye9vF87NVFIetyWUKSCK7IcVUNF/w5KEj/1EDf35sQ3X1T9oZr7FIuY9SQ8G88h8ekW2xhGjJiqoNk+5ZLEiK6Mc1yW5SCzSlZi++66wYxtr+vQiL/PwjE3yfdiiOAyQ1BCfl7Z0NzAdTewyGIF+46PRos0LbbyCK2jGbHlbzHING0Kyfzfbj2QdSF25EAyT00ATMl3fnBLQyCh7/2x2WU323f/SwH3As/nNQ52tAwS2i8MS8cjgNIDNKMXvrYp/jAeWarFH2B/IfJ0d3yyTaE8xUCpFC/z1ml0PMZp9/WacZ48qaNHApqV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6486002)(8676002)(122000001)(71200400001)(5660300002)(6916009)(6512007)(38070700005)(83380400001)(54906003)(38100700002)(53546011)(8936002)(33656002)(91956017)(6506007)(36756003)(186003)(66446008)(64756008)(2906002)(4326008)(316002)(66556008)(2616005)(66946007)(66476007)(86362001)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Qz1T7sNslg3hpm2lKuccFOdegc+cZDqghPntkadBpjM3TcBUw36qeOTP4Ud?=
 =?us-ascii?Q?Kyl0srNwQxA99PGeer0MHzEVPtuuld+RmMbjGmUAMJrxms9iHPhRmS7l5Bg8?=
 =?us-ascii?Q?eGFneo50Ka3La5dgauF9Y/NX8bVHZ4A8ONB13JjbzHrufXYj067gLdK5SN2n?=
 =?us-ascii?Q?rodpjjsO2OHtdfPNAFEdz3ljmWjFzxJ4ZL8O8aI3+fSw8qRYUY3+/dfH0ep3?=
 =?us-ascii?Q?NpGkFomzKKFxzY2KgCNlF9lUNsUKTSHkbxmbvfG6br5Nqa4TWwK2psQxMWHw?=
 =?us-ascii?Q?STWK+HLM3eZR0MqX76l8Ns0YfQ89HZLxnYj7I6AYcmXGp7BXX61381u/DtgU?=
 =?us-ascii?Q?d+2FIVXN2skhMxy8N5XdgJ+vChlJ7AHcW+Rf+q2acCWVs/IPIlZp9z+ayBQ7?=
 =?us-ascii?Q?+JXL80u49BsD8UHHX8hV+SJUmTkMDVqwT6GMWQ4OKctmLIYSW1jnAztKWCCc?=
 =?us-ascii?Q?CClstzyEJ5Aq1qiuitgDrayYZtx1KViMM/7GdBoQNyRiPjUPnPUNjVJI8jUi?=
 =?us-ascii?Q?8B0hBC9UOZBko+NdIEvTTK9NxDnoehw4DCsxYcsYDw1jHyC0PjjGphj2U2px?=
 =?us-ascii?Q?gj4MYJeBNViOF4Vb94RJ3/Nfr7Sw/VBwaMA1XSLjw3Y2tumer/581xl7hgYr?=
 =?us-ascii?Q?RBu5wRZ34kxE6Abm5WnQYVNJA8tL6RsGiMS836k3q0B9g+qaB3m9Po3s9j7g?=
 =?us-ascii?Q?/SpJuAZC50br3Xf5yJDXLi02dCeJuR/DApQ1JeWj8OjiN0H8vvBtakZofzFB?=
 =?us-ascii?Q?q27pHybcETG7RyzefB7QxyhT4awzF/OTT5pfSzAK/lUOM5QjU+oskuBxWHLM?=
 =?us-ascii?Q?aMFCU9+/4mQj7XNECT+awnfS7Tr+uM3xLA7VnXwssbfqG2r1wYOIPIHUfPHC?=
 =?us-ascii?Q?jce/eDq86om7hlaOSeh2dmgLpzk4l+Cm6wCWShEBT5a2O0L1+1Np/UGRWHU9?=
 =?us-ascii?Q?oOmac1rTOrd7Qgrvb61oGdTRnsnUTgPMJ9U3dFpU/tFBHO91o+1JV6WprTEa?=
 =?us-ascii?Q?5MhEjuP1sAYGd2AnSHOjFE1On8g8xj6frLcx7qTF48jRiIRC/nNcWHy6KHoG?=
 =?us-ascii?Q?Ke2S+28I0+JhP4oXzjvLHoelP23HifDjO/h84YrO5lJhWB2TSz2wTWRTS8df?=
 =?us-ascii?Q?UgzFhwdSBCEan/FKFAWpEBTso845jGKf97z3qW7geRdapZqeWY3ZTvZSUUdt?=
 =?us-ascii?Q?AkO77zKiqqLOYf69UuuPzhmQq1bFKf+eMk6Q3rWSJbQ983UqSqXso26RivUY?=
 =?us-ascii?Q?ByxPWworV/p8zCuXX0UlKz3S8If4CFsXcJCZbclfM/seuVK4/voAv4RDTiV/?=
 =?us-ascii?Q?O9/wvXhpo2ZpLjWFiwsT+teUWwgwunVAnVUbQRyrFAMIDtoqTceE+td+SaKs?=
 =?us-ascii?Q?S4enLB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1506AEB60C2C3419C00C58718CB1309@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64af5241-7c7b-4166-a390-08d97488a9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 18:27:36.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSOLOd9U1sagiw2NP9yxPHEo082+UnvMrZLvUQARFOR0hN4Ie8WpiMPfCeSaAsHlo1lw5bVcs3yu5xIGBnKdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5093
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: z1px3JNjJH8jgh_db3Tx75EV76jWoO1r
X-Proofpoint-GUID: z1px3JNjJH8jgh_db3Tx75EV76jWoO1r
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 10, 2021, at 6:54 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Sep 10, 2021 at 12:40:51PM +0200, Peter Zijlstra wrote:
> 
>> The below seems to cure that.
> 
> Seems I lost a hunk, fold below.
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 9e6d6eaeb4cb..6b72e9b55c69 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -228,20 +228,6 @@ static void __intel_pmu_lbr_enable(bool pmi)
> 		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
> }
> 
> -static void __intel_pmu_lbr_disable(void)
> -{
> -	u64 debugctl;
> -
> -	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
> -		wrmsrl(MSR_ARCH_LBR_CTL, 0);
> -		return;
> -	}
> -
> -	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> -	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> -	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> -}
> -
> void intel_pmu_lbr_reset_32(void)
> {
> 	int i;
> @@ -779,8 +765,12 @@ void intel_pmu_lbr_disable_all(void)
> {
> 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 
> -	if (cpuc->lbr_users && !vlbr_exclude_host())
> +	if (cpuc->lbr_users && !vlbr_exclude_host()) {
> +		if (static_cpu_has(X86_FEATURE_ARCH_LBR))
> +			return __intel_pmu_arch_lbr_disable();
> +
> 		__intel_pmu_lbr_disable();
> +	}
> }
> 
> void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)

This works great and saves 3 entries! We have the following now:

ID: 0 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
ID: 1 from __brk_limit+477143934 to bpf_get_branch_snapshot+0
ID: 2 from __brk_limit+477192263 to __brk_limit+477143880  # trampoline 
ID: 3 from __bpf_prog_enter+34 to __brk_limit+477192251
ID: 4 from migrate_disable+60 to __bpf_prog_enter+9
ID: 5 from __bpf_prog_enter+4 to migrate_disable+0
ID: 6 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
ID: 7 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
ID: 8 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13

I will fold this in and send v7. 

Thanks,
Song

