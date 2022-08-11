Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693495905D2
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiHKRYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiHKRYB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 13:24:01 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53176331
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 10:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M18WghBRyFYIKaaUrxbsZFZU9znRvgousREmNa4lJZ7TYHMqQTRfKRn63lqF8fDUQxpt6MCi9z/pG6i7oCsuAGQKValS4DfJL4DiVR6LAWGzqBXYCAncs5DixSnECJloH2S+RdOyuoH7hMOaGQZxxNfDkqdSkaHnXBPqOBuhc7z9KU+DTUioqpT9tyw+U5WlRhjIot5TL4mZe7uQmlNknLcU8peAejFWEk1CTQkFRHCn6XLq74sJP5aYwm97NpUOEMmhBAZXsogpS0NShvLQmy1lSvQ+xMmDNlwUqjHKavtNljUcjJIOUF+2DddhgqHUFkb0RdHWsgc6wYigpZphLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soENoVqvWts2b81zXEcaHE9axtWyN3BPos9F6vn0qp0=;
 b=iftYM0Bfjgvq3+4ehOFqXYkg+FBbpLKzSLiq/XTSPxGAuvwvbWEgkhc5qFt0aRHt/sgO4IRxltoPpU89vsUwCxyc8/ol2OyJkdwKQpx2QvoB9rbIM6zlc+LvXROVRX5WIYVDVWb5Lj8Fy0Q6wlI5m/HJ9SY/373l+4pOG7wC1E/VbqYl1cRP4NDPPln43e6jMO19zH0IZSJgKxezqe3oRBV5rqAeo4zaSZYZ2j31od6DgByB4gnqO8/Ys9aFHOvOprStxGUMxAihusOFImr/u4yBWsBhxuFa5y3JrdK4clLNZ8Slu65EA5HDLOGACWLmNi/jXs5g9hHw7HfLWrCbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soENoVqvWts2b81zXEcaHE9axtWyN3BPos9F6vn0qp0=;
 b=Cb9rjkEOACJt80VPPMJgD9O3xa6aOp3ax88Tj+rOVrXqnM0RzlSNCIKy8OvIzPYwD1vaCDIsWnFpaaWPD4t0NOyfjzxlsERs+kd3de46OtbtuWX997O3/uRia0d7ur5EnzBdySdOLn0ujYx/hR3nY6f3lpDJrGBS4cajXodNJ4E=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by CO1PR21MB1315.namprd21.prod.outlook.com (2603:10b6:303:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.6; Thu, 11 Aug
 2022 17:23:56 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::414f:481d:227c:c245]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::414f:481d:227c:c245%7]) with mapi id 15.20.5546.007; Thu, 11 Aug 2022
 17:23:56 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Daniel Havey <dahavey@microsoft.com>
Subject: RE: Followup from LSF/MM/BPF on standardization/documentation
Thread-Topic: Followup from LSF/MM/BPF on standardization/documentation
Thread-Index: AQHYq1hAdxV7F6W1kUWgBeu529V1162p83AA
Date:   Thu, 11 Aug 2022 17:23:56 +0000
Message-ID: <CH2PR21MB14649A069BDEACFBC440C623A3649@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <cd33ca74-aec9-ff57-97d5-55d8b908b0ba@iogearbox.net>
 <fa09a9f1-7d99-cafb-3c10-7a3e474d8da6@iogearbox.net>
 <CH2PR21MB14647EC978225E98A3B8AD73A3639@CH2PR21MB1464.namprd21.prod.outlook.com>
In-Reply-To: <CH2PR21MB14647EC978225E98A3B8AD73A3639@CH2PR21MB1464.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8362cfe7-3635-4890-b217-0e15ff5709ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-08T18:47:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6968b174-ec9f-4946-9092-08da7bbe4599
x-ms-traffictypediagnostic: CO1PR21MB1315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzNctSjJrbGbIdCVNFi4f9IY52Qgrim7udIajNdJ9JmQ8rEZQmq0io/F5MytpEYYRxgIHFNadurRZndFOErwvvcAVVYYvGuerAw+cLSltsyhMN7EEZcIR4OgV66r2FsKlKKaU4k8lBftkcb7DKQcJ+OijkIV6zTSEVcaJc6KE/4NGldtlki7gXO6L7fDPfP0GIpanenJev664/S1WGN1/41rTbSyLQAb/Yxv+18sbJSajkJxJrQG8CPGAULM8Kp/YFsX9ATISb+amX9lqbqYPj2HK2kfwz22YroMedVjm/RXy84g2Y/mIQCfl8iVXNIUrWfOOyaybyH0n7A5hJ0xkFrJMI/H6dkc4leT0quFtBErPbpK7hyCB7TvZr1I85hH80cN4rw/WplZLE/pY+M6cTvIu7HvCjDr18bYwHXSJQQhDwRImd2FpHm/2CKWHaiu1injl1gI0/6f5U0b0mmRlbNV/bKwPYmwyVtAMGLnotX7zJYh3d8OU6E6UV6i7cOte+3TGEMC9C7WfYGE23GzHop9zM7LoRFykBoUpmcSEM+pOwo1gRQLAJ0snt0mfvVwd1C6pEoTaHyDHtPrlaBSdOW3qweXLNnM/2qAWJGEgCFr+kSZ/OPnZq2aE1apY+Q/okDgsMph6RjnMmPOcE2Cs6OrQmluUyZIAe2QP2m3HbKWbSUcll+zOKLj0xIOMM/eY751TlDMQ4G/rUxjt6YR84uNTjR/oUooMr9Q4aMINLpRdTt4NJdrH6/jil+0YnWTtYdd1EjPNU/wT+5Z2zvYHqG/PkfylN78isNx0GxD5jNHQLDwCmmMswhDw6xAaRnhm2Li4mEDEKrpSGl+JgOJSvplpf3dO67WkkLpdpRnxBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199009)(107886003)(186003)(71200400001)(41300700001)(86362001)(53546011)(7696005)(9686003)(6506007)(55016003)(26005)(83380400001)(316002)(6916009)(10290500003)(76116006)(4326008)(66446008)(66946007)(66476007)(66556008)(33656002)(64756008)(38070700005)(8990500004)(478600001)(5660300002)(2906002)(8936002)(52536014)(38100700002)(82960400001)(82950400001)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGVIbzhdlibpwbYxvcS/omWBLqs3xl2AFOctHhuVTSR1JLQ8Q7BisnG/VToI?=
 =?us-ascii?Q?cAVWXbAoSaJbIdNNlzUI2oMuXNK5FywZjTjXS+sMKj2iPsBQxzUXbjmjtSlm?=
 =?us-ascii?Q?z5qtzx/6VNwZJb2JWELeEcv92riv7UgvLh8ljSxCDAXdMnMKZCR7GbRyqvHA?=
 =?us-ascii?Q?DeNbLuEw+VBawmMDHaRf3doSCBLRTgfE/llU9uWCQ52w5MDCldTQpqX0HljP?=
 =?us-ascii?Q?urWvsPUIRxveJ3fWzwMSHkdG0d+tgVv6XBwaejpK6gn6uUxVN0QNM/wkVSrR?=
 =?us-ascii?Q?jvnFVgCNCiwBok3hkjLUoCBKHsghdF3jEdecD9oqV+XQ+54+YllmZ4B9VShF?=
 =?us-ascii?Q?5Y0OEUVV0n1BFfnYz2cL307URIhTAPylCTeDy9VAcBnIFb27oLTK3ICYTIq5?=
 =?us-ascii?Q?A0jyXqjNz12yY8rNsfzo+fzZVfR2u31N2nb1gS+2x0CymFVZMqQt59V7JZ+u?=
 =?us-ascii?Q?vu1bCsBVyPBCeEO/ulGtklMTNEiG+Z/Ib/+WpGzJi+yKkWxfuTeNIuhS0XV7?=
 =?us-ascii?Q?UzOstRAdZHVE4CbnXws5H+x5EBil1Mc9sUOq7EmmUp+UP5G5LIwE2MwV1ONc?=
 =?us-ascii?Q?dZdMQh3Jr7rD+GdszAm5Q90aN7ZISvvo/X8Vd+8pgER6Wbg2hCrfzBVo25TI?=
 =?us-ascii?Q?+UuD/tap12disP70UYqcdKFlE9CrCwqowT85Q/dIEMObNw1eqt/CBuZcJqZ1?=
 =?us-ascii?Q?r2b56YuD/z94JH99xdMDFY5fCLDUUEiOk+wOlD8gs6K9RREzAREqQqbZdCWA?=
 =?us-ascii?Q?/Og7kr02s5T3YfWVst1kxBd//2hTyDfEnZLBHhxDqg2THh2JI5O+EatOR66m?=
 =?us-ascii?Q?uIkXexeWrp8sVf/QQOZXIYhha8A6SWiXD7x/aGnf5rbrNzL3mc1oGvVM0A8d?=
 =?us-ascii?Q?nA6B43hxw0exZebZ20MlDQi4S+jplNZD5FLOZQ1ZLcpwBpjBlYb4j/n66EfH?=
 =?us-ascii?Q?6MQxksT/AhKoH0W8j8woh0ScHFRlDPm3C08bgW97zE4P0lrYX0/8aQ61iVtV?=
 =?us-ascii?Q?ad2nom+mgQcwSocL8MfYBy/60DNZczdyPsk2GtCw6G2ehoQ1Wa+bObKMcz5U?=
 =?us-ascii?Q?mLbFflwhCsl1wys8ZnODzOcN8PpJ1vvIlX2ZERNDri2LJ/AdRUxxZVCfSNyR?=
 =?us-ascii?Q?McSjyBlrPAyRGX23X/OlKDJlhx5KDE9L26ztS5hi0eTwq3znrBahNdovXXs+?=
 =?us-ascii?Q?Gw3VkyIK2p/ufdD1FskfhX6sOryt0yDqbLu6ySNPv6ey6f0bUt727gBKBPAN?=
 =?us-ascii?Q?i+NW6YctjCSq6s2IfYaz6TdcF2BwqJODH2N7tVWczzII5zDWuWgfq0l8cWKT?=
 =?us-ascii?Q?8GnlC3tQyZoFWfKT1oaTq55rJ48/OUD9QMrqTzJhBmqAAWC6++cXs1oFkfw1?=
 =?us-ascii?Q?MU1n3LRkDeL9Hhb/Fi0qtKpEdZeMr3b4RZO3VmQRjAvcqERlZ3LztUte459a?=
 =?us-ascii?Q?aftP/vF6ZZBuODxZN213N1ysldsbP9O26MPipkHjduw3OWmKXwKDxEBlbpBK?=
 =?us-ascii?Q?nW6VZECDU3Ki1gUmm+Z5S1oPWTvcWqukd8LW1s+UFkZx33mPTCC0qyAqwD79?=
 =?us-ascii?Q?JZhShxg6m44Luymo1gF27bRZkQawPlyY2xSW0RxMyDjpOR8zEGFOhN8XsC+J?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1315
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Dave Thaler <dthaler@microsoft.com>
> Sent: Monday, August 8, 2022 11:54 AM
> To: bpf@vger.kernel.org
> Subject: Followup from LSF/MM/BPF on standardization/documentation
>=20
> At LSF/MM/BPF, the topic was raised about better documenting eBPF and
> making "standards" like documentation, especially since we are having
> runtimes other than just Linux now supporting eBPF.  And ideally hosting =
it
> under the eBPF Foundation.
>=20
> I'd like to use this week's BPF office hours slot (Thursday 9am Pacific) =
to kick off
> a discussion of this topic, so wanted to send this email to invite anyone
> interested in contributing to such an effort.   Hopefully we can discuss =
how to
> organize the effort and some principles we might use for what might be in
> scope.
>=20
> Dave

FYI, below are today's notes from Daniel Havey...

Dave
-----

Interests:
o	Dave Tucker: maintain rust libs for bpf.=20
	-	Lots of questions about basic things. Not covered anywhere centralized.
		>	Want to put into kernel documentation
o	Christoph:In the NVMean computatianal storage
	-	Able to execute programs on a storage device where you have NVME and run=
 them on that device.
		>	eBPF as the binary format for these downloadable programs.
		>	No cannonical spec for eBPF
	-	Is a girhub repo sufficient?
		>	Maybe, a website is preferred - snapshot of pdf
		>	Just need a stable reference
		>	Under eBPF.io
o	Jim: User space NVME drivers
	-	Agree with the above
o	Dave Thaler: Microsoft eBPF architect
	-	Cross-platform - how do we keep track of the different run times
	-	Not diverge - coordinate
Questions:
o	Christoph - verifier, what is in the classic instruction set. Intricate i=
nteraction
	-	Yes, verifier expectations exists as a starting point
	-	Linux kernel and Prevail
		>	Uses of uBPF which do not use a verifier
Scope and Organization
o	Cross-plat or Linux or in-between
o	Might be cross-impl vs run-time specific (version specific)
o	Something limited to a single platform or imple
	-	Does this effort care?
o	When does it become standard?
o	Impl or OS specific will get complicated
o	Interest in generic run-time specification
o	NVME perspective - certain eBPF op-codes Linux specific
	-	How does this get impled in the spec?
o	Impl specific opcodes are a slippery slope.
	-	Will get us in trouble.
		>	Avoid going forward.
		>	Let's not make room for vendor specific stuff up front.
o	Is there a use case for impl specific?
o	Decide on the subset of eBPF stuff that is compat amongst runtimes and do=
cument stuff that is divergent and call it out.
	-	Hashmaps will likely behave differently anyways
o	To be portable you cannot depend on details of things like what types of =
hash is used in a hashmap
o	However, functionality should be cross-runtime
o	Abstract concept should be documented
	-	How they are constructed without impl details
	-	Too much impl detail is baaad.
o	Subset of the Linux API and make it a standard?
	-	All of this sounds like a subset of the Linux API?
How do we deal with things that vary?
o	Capability variation
	-	Multiple versioning
	-	Language that is MUST/SHPOUL/MAY
	-	Manditory an optional or conditionaly manditory
o	How to define and split up the run time?
	-	Hashmaps - part of the program type?
	-	Instruction set - bare minimum and extensions
	-	Extensibility by naming extensions and having a bitmap
	-	For runtimes - program types. environments that support everying that is=
 minimum and optional
o	Let's just use MUST/SHOULD/MAY and multiple versions
Components in scope:
o	Initial in-scope too big to be practical
	-	Remove everything except ISA
		>	Prog types in Linux that nobody is using - don't standardize on them
	-	Need instruction set in the ELF format
	-	Verifier expection - exceptions, etc.
	-	What is the job of the verifier vs the runtime
	-	NVME doesn't need as much verification
		>	How much verification is the min?
		>	X86 hardware has a built in verifier.
	-	Kindof verifiers
	-	Some core aspects of verifier make BPF powerfull
		>	For instance: safety
	-	This can be static or dynmic
	-	Probably a MAY
	-	uBPF doesn't have a verifier because probably everything in there is saf=
e?
		>	Or unsafe depending on your viewpoint.
	-	Abstract - mention that there are maps, programs and helpers?
		>	What is eBPF doc. Should this be official doc?
	-	Standardize the parts of ELF format and BTF(?) because the instr set alo=
ne is not suffiecient
		>	BTF carries some of the info for the prog to be accepted by the verifie=
r.
	-	Can't document the ELF format without talking about BTF
		>	Could be a SHOULD feature
	-	You can have an ELF file with nothing in it.
	-	FE relocation - should be captured in the spec
		>	BTF can describe variable nature of an NVME command
		>	Instead of raw bytes using BTF to describe might be more flexible
	-	We don't need it initally
	-	On Windows side: No support for BTF except for debugging purposes
	-	Debug info for reporting errors may be useful for NVME
	-	Good to have BTF so people don't start inventing their own thing.
	-	BTF is a low level format that is portable and easily well-described
	-	Load time, meta data
	-	Run time verifications that are not captured should be described by BTF
o	Compilers - are they in scope? Do we describe what the compiler should do=
?
	-	This probably boils down to details.
	-	What is in-scope, but not covered here
	-	ISA, ELF, BTF and low-level should be very clear what is expected from c=
ompiliers
	-	Are we going to write code to verify that you have complied?
		>	Yes, we should do this.
	-	Verifier should be what is checking that the prog is compling
		>	A verifier test suite
	-	Compliance of a BPF program not of a runtime
	-	Stay at the self-test level
		>	If some parts are interchangeable between runtimes great, but don't try=
 too hard for this
	-	Is this a valid BPF opcode, is it handled properly, etc?
		>	Syntactic correctness, can be executed independently of the platform.
	-	Take all the progs offline and dump them into the oracle to see if they =
are all doing the same things
		>	KP Singh - Yes, I can write this.
		>	uBPF can be the basis of this
	-	Impl JITs - set of values that you load, do some ops and compare the out=
put
	-	Give examples in the doc.
How do we org this effort?
o	PRs and meetings if needed - use office hours
Current doc - most cannocal source of truth is the kernel repo
o	Do we move the source of truth?
o	The source of truth for Linux and the souce of truth for cross-plat are d=
ifferent.
We should move it so that there is only one.
o	Are there legal issues with this idea?
Don't move it, keep it in the kernel tree
o	Keeping in the Linux is a barrier for non-Linux peeps
o	Github is a barrier also.
o	License is a real objection.
o	We must spec license X (MIT?)
o	License is not a strong enough reason to move from kernel to github
o	PDF document somewhere in the eBPF foundation
	-	How does this work?
	-	Do we snap when we have a version and post it?
	-	Host release doc at the foundation.
o	Need another ad-hoc meeting to keep discussing
	-	Something cannonical must appear on the Foundation website
Do we need a mailing list?
o	Can we use the existing BPF list?
	a)	Use the list
	b)	Use the list with magic tag? <-- This one (bpf-doc)
	c)	Use another list.
