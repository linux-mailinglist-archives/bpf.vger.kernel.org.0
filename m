Return-Path: <bpf+bounces-5186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD27586C2
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE241C20E21
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15782174EC;
	Tue, 18 Jul 2023 21:23:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28E154B3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 21:23:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2105.outbound.protection.outlook.com [40.107.93.105])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294729D
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 14:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEdeQEhiCX9hH2Cq2ia7UZxWllTclMCnjPYmwXSab+GTw+OlheC94TJvzQ6MyRf1eYo9jKe43YCOMy6sZMbq7GPEYYds2Z6J7ochVOsw6mdN7vhs0NsjBw5ox/LE/1huFkMiaKSSxqa7wkYJRMlfkoStNxQOc9WUq43fsrrNjLnqH4XwVQMcQijl8H8fPaCltm1n7V3Ve2JVkDYkK2dy2A95tA+9685HmE1rrnRAcAmAr5QnNLDIaXC+qTk+liYDGvrTuOiDOdMW7nn6KJyEi6ipr+V2x7LSg1yzFjMzqLVrd8nGISyxbCgeHgryMtLG9rM4wuVpoywZXwlC1Z823g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtRW/XEm6hVOrqXP7/LHGwWsN9AmhC8kdUDqw2w7g9M=;
 b=X2sJbIJP0v0bpSfyGQzqeX3fzZM7aT51HmXRySQ4gBy0q9ta+YB3qaUG4dtuj91RW+9lK8W8QMwP8olG5MjkVXSp6N1mSv4Wh/+0e2ya/WMDXlU5bzRH/CAcS4wCRaqqWezyg5lty6fijkNUOacgL0Z6xAZ5abeNjqf7ZAS1Ue+/V4NXF3xBA+kplL9PfdBK9KzkNmgZW/F6ds6YRCcjO8RekpwpeRNCfn9S6anJRyA/E1LGZx4M7IE3VJqBtjW5Q2zGxHURy7cQHK6IuACXqqdmepgJx2qbW0wfKxuvvpPdx1+DDDh8KTwBC0pNAQh+sxhrEIgN6b0kCPFOHa59JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtRW/XEm6hVOrqXP7/LHGwWsN9AmhC8kdUDqw2w7g9M=;
 b=T5duqjHPWdilOeKb+Uk9sC78epUz+O9/Jvxrr8b9PnmseyQTam167yL09HFlJCRYDInOTvROohQGRRqJ1k1PKE7E7Cy8lBapJ5npAOQwSvbAEYPnIaRw9B63kYU1ZMqnsPlCShd3vijR2BRJ7xi+7AZxsKyh1obclaf3ObgJ2f4=
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by BN8PR14MB3377.namprd14.prod.outlook.com (2603:10b6:408:7c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 21:23:35 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::6a2:a57f:edc4:3f0e]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::6a2:a57f:edc4:3f0e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 21:23:34 +0000
From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Santosh Nagarakatte <sn349@cs.rutgers.edu>, Matan Shachnai
	<m.shachnai@rutgers.edu>, Srinivas Narayana <srinivas.narayana@rutgers.edu>
Subject: [bpf-next] bpf: Verifying eBPF range analysis
Thread-Topic: [bpf-next] bpf: Verifying eBPF range analysis
Thread-Index: AQHZuPJYWvZ+B7icCkO0DMuUufoQNw==
Date: Tue, 18 Jul 2023 21:23:34 +0000
Message-ID:
 <SJ2PR14MB6501E906064EE19F5D1666BFF93BA@SJ2PR14MB6501.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|BN8PR14MB3377:EE_
x-ms-office365-filtering-correlation-id: 262ed741-4c6c-4b9d-716b-08db87d53e5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LnwmJFBWXPzwUY+uxypQbP7r1WGgAeTLyIuwXqiQMC/Xug8r+tpDvUop2uU3j36oL8Wy034I7iItc1erhtG5qEV7CN4VpJtKKqlKhcmAsHGD6tqCeAUo+cjYCtslEhoPCaCU4ZU39UoLo2f2RWmjKDsKEDN4O2cKTLcm1DZQfmqLPvkpm+pUe9QlPgVh2l7Bymf2Mw80BM3LiHGXrYEqccesOc2QEKwqMQi4veMrb5mdHKAgtv8n/BaJkG13Clpe2Iic9FXZTImlNEYYSpKD16j7/ZIM15grcaZEamR3wYqHmN2j2cgDnI9OPagwMZZr3InPsK6FaYi+ph18bHEnvS1enu8SCRa5nJD38mCBfHl/V9Bj6Tm2JzmGSvyMbYSgPbDE02PS9PspbuJW/ugc6U1PLrZGur0QBKEQLOfLrDkHCLW/+qTEu/Np0AmhTG9qAiRbVn74cUfhlk6WzKJ6u0eske7myc8WnP+VKIhXH6zEdJyH96vc3Lbt032hcNOBuyXE59EnWo/JsLgWsRs6gLC0WzyMS8toiZgJPY82PnzbqJnm/vLFajseRD69wh5CL//MZ8+6xbO8EEDzqVLQVyu1NgJpRoVdJlZHQ+kc3r0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(66899021)(71200400001)(478600001)(7696005)(91956017)(83380400001)(54906003)(33656002)(86362001)(75432002)(38070700005)(55016003)(15650500001)(2906002)(44832011)(186003)(26005)(76116006)(6506007)(107886003)(966005)(9686003)(38100700002)(122000001)(66476007)(64756008)(66946007)(4326008)(66446008)(66556008)(6916009)(8936002)(41300700001)(786003)(8676002)(5660300002)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Um3WXz+H8YfTGk4oH/lix5FhCiFA5Uo8T0tLyQafT8gPJacsEO/qORnUSS?=
 =?iso-8859-1?Q?MAmetfa3rFLyn12zlWUM76pRs0MNCeWH7zR6Vwyfip9ycFQDa2gkHZd9VJ?=
 =?iso-8859-1?Q?unk6BlL9W4frdmru7bKGrl00piE9X2eIGAJyC9hL02cIy1utBzjj+GPh57?=
 =?iso-8859-1?Q?qtzC010n85UYSHe7g4ryZ1mKdKkEMkv3YBW3z1MM4/reOG43BLpOM0YGIo?=
 =?iso-8859-1?Q?B48n+jjFXP5XvhpNR9b50KtffZaOl5hnRIrirbD4O9KKuxnEi/UatQgt3J?=
 =?iso-8859-1?Q?FVh4RAOIHecBbiDH/cLALQ/ZxMB5Tv8aOWvNC4kW3GBtkIUKOUNSrEQeTO?=
 =?iso-8859-1?Q?ampmEo7XGTJX2j/e+CR+gKJLqfbACPfg7J1SnP3aDB2ChiGG6hiuBc8LcX?=
 =?iso-8859-1?Q?nPHZncywlfSRq1vqFeWTtDypDqHQEvYrH/g38dL0VC3cAjoDd8V5C7VvMn?=
 =?iso-8859-1?Q?DPCBmo8VPaeTHO7uBEDiMCw9ijUgress7rUi595VzL+9mS+SNNcWHaib+b?=
 =?iso-8859-1?Q?WEKFP+uOJcJDO6QbcERXqve8VwJswVO16wsJlR60MJmrBgw5T//ep3sDzG?=
 =?iso-8859-1?Q?ILlotQ1/Vf7WiONgbgTHbTPwj6yM+EQojwww75Kb4g7IEhOP5IXBPgOvSr?=
 =?iso-8859-1?Q?dqRTghNq/eEkGxvto0shNpcYXBoJqDxoyEgDCs64D1pYdQJ+lJUEFvz1mc?=
 =?iso-8859-1?Q?kjEx1PSAJhBNZjVo5CCov9rtsWjdZxJ/MfOOdliK+qQFa1xa7dFuZnqWUJ?=
 =?iso-8859-1?Q?cOPkg7FHhKtP/avN9aLTDa9FM5PWJ1GKPtzRR1fOCbO4fPde0YjLIm52HW?=
 =?iso-8859-1?Q?aOj2R9PNdVxMMC2b1NlKL+g0iAYdf7EsRv+VBqbeiu8cb0JvlmGTzqKi/U?=
 =?iso-8859-1?Q?lIMkAoSY9xnr/QlOH8Vg1vO3tdw7XMNR4YN+mBhGHM+ZERhLOwFwJkqex7?=
 =?iso-8859-1?Q?e+GvFQJFGU7E5X4N6NWInUSHid0/fAbZQgcbKHXwWEQvOt60meIj3KAjis?=
 =?iso-8859-1?Q?pf7zwtkJobSf4N9leWmBlvb7PdQ1JklBSL6D3a68c1XNPyvDdC1vNVroxs?=
 =?iso-8859-1?Q?xzEX8kL1ycD/iw6nLPMd89iO+DYKjVwyGz42fVK9ujgaWx0sGc6NkYDQCN?=
 =?iso-8859-1?Q?fyU3bj0bGOgZfsNd7rlE8027zFFPCaQWg1FxfLSEk4UX2rec5KUVyBn3Ty?=
 =?iso-8859-1?Q?zLw2dx52LexF74jotiI+t+nKuKEpKIbepYCuGzZ+1qEoJtlpN/X24tCw7j?=
 =?iso-8859-1?Q?3+simL26PxTJppUnQLOCJT2K4KyM3eFcLyN4Pf/occqJPSbUoCrUIWDvMD?=
 =?iso-8859-1?Q?4Ch+kvj2S9hvMqEPZJoZ+Lw7SeVRMI4irZaIqNAVZ+dXHnVdhVuLz0/SFa?=
 =?iso-8859-1?Q?Nx70P1KlZ7nYLIJYGesNnoq/IaIIdugMB/WLkUBmDoKd7vzshXZ17s9rPb?=
 =?iso-8859-1?Q?PJIHMlGxwOSSqczu9ZIUQrb8hSNW5WVgWQFYG0mzcmyrAFGTeaMxwqJW1u?=
 =?iso-8859-1?Q?dVz8LxiVUQ/+Hs3R5h+Tev2K23O6bUqhEk2AY3LRPC0R6wSSE12HlNV8Fn?=
 =?iso-8859-1?Q?xPxPJcPjpFJ8262VRm30JMWh491LgIcsmYsPaTedOaf/nPDIQlXu5+Vz+Y?=
 =?iso-8859-1?Q?CRm99s7M3AdwE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR14MB6501.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262ed741-4c6c-4b9d-716b-08db87d53e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 21:23:34.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJevJpb2EUnPmU9aIt191ha5vZryJaglBj4XvwNqndP4b7VQIbhlIuMCQmfnnEjvUYV4bIYO6iPlp0rN8hYMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR14MB3377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,=0A=
=0A=
We wanted to let you know about our upcoming research paper [1] on checking=
 =0A=
the soundness of range analysis in the eBPF verifier.=0A=
=0A=
Specifically, we were able to use abstract interpretation theory to check =
=0A=
whether the verifier can be tricked into constructing a range or tnum for a=
 =0A=
register while its concrete value deviates from it. We have checked soundne=
ss =0A=
of the kernel's cross-domain analysis (4 different intervals, tristate) =0A=
starting directly from the kernel source code.=0A=
=0A=
Here are our salient results:=0A=
=0A=
(1) We have showed that the range analyses corresponding to all arithmetic =
=0A=
(except multiplication), logic, and branching instructions in kernels =0A=
starting from 5.13 through 5.19 (the latest we checked) are sound.=0A=
=0A=
(2) For kernels where our analysis did reveal a bug, most of the time, we =
=0A=
were able to automatically synthesize proof of concept programs (PoCs) that=
 =0A=
manifest the soundness bugs. Frequently these PoC programs contain more tha=
n =0A=
a single instruction to force the verifier into a bad state, and can be =0A=
nontrivial to write down manually.=0A=
=0A=
Our tool is open source. As a starting point, the PoCs generated by our too=
l =0A=
for kernel versions 5.8 and 5.7-rc1 are available at [2], to help illustrat=
e =0A=
the deviations in the eBPF programs from the kernel verifier's analysis. =
=0A=
Adding PoCs for other kernel versions is also doable given more time. The =
=0A=
readme shows how to run the PoCs and trigger verifier bugs. The first examp=
le =0A=
is the case of a PoC for a well-known CVE generated by our tool automatical=
ly =0A=
and with fewer instructions compared to a well-known exploit.=0A=
=0A=
It is also possible to follow a longer sequence of steps to replicate our =
=0A=
entire analysis starting from the kernel sources [3].=0A=
=0A=
We look forward to hearing any feedback and comments for improvement. We =
=0A=
intend to continue working on hardening different parts of the eBPF verifie=
r. =0A=
We also welcome suggestions on other parts of the verifier that the communi=
ty =0A=
thinks are particularly important to harden.=0A=
=0A=
Thanks, =0A=
Harishankar Vishwanathan=0A=
=0A=
[1] Verifying the Verifier: eBPF Range Analysis Verification, by Harishanka=
r =0A=
Vishwanathan, Matan Shachnai, Srinivas Narayana, and Santosh Nagarakatte. =
=0A=
Appearing at Computer Aided Verification (CAV) 2023. =0A=
https://harishankarv.github.io/assets/files/agni-cav23.pdf=0A=
[2] https://github.com/bpfverif/ebpf-verifier-bugs/blob/main/README.md=0A=
[3] https://github.com/bpfverif/ebpf-range-analysis-verification-cav23/blob=
/main/README.md=

