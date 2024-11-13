Return-Path: <bpf+bounces-44719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA039C6885
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 06:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A461F23BC5
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335A1714D7;
	Wed, 13 Nov 2024 05:13:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020111.outbound.protection.outlook.com [52.101.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24F15A858;
	Wed, 13 Nov 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474833; cv=fail; b=oiC7dNz5VXX+kZIkar3rm1ZONsg4jv3jCtDr8QtC30BNLyQ7RN/kCJ/nTQe7CIa7r/I/oA+fiB7KKYzPmtx6BBh2+hvwzrCp85Ce//UQKrk8XOrYgfn2JxgQ7Iy8WfHcB1gj8xAasp4A7mkyXNTKx91MCaLpW9HeCDi4Z0HTVRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474833; c=relaxed/simple;
	bh=48MgdR11/uvaDtQjqemrDJKQaqnyYdqNHJM4UyB+P7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oaT69VM+DINfcjnBaRjS6dX7EMQZxHvG4NCdNMigDxHKIu+cA/D27MOHlIdK57boluPWYJHo2zb2NSYcabmNauG83vhMV5Rt7C3ik7RvnzP46VSDTkx6KXOuq41ty7DnPVXZks8A81KiCLaOtmBktzCiVJZNANvbd6eid8ieO1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLrLveV+xII8B6+x7JWfe8PmFvMOjkGCDdBwwEKYylXc1zRoZZ84ho/NRHJ1bfAInokpzLVYPTtpLRHs0xQfxf4r2pS3kB1gq6DvusC9qEg7BR/8b13DAZZHqHVXI0NGSgCpIC69R7DZTcn3x6pn52MLA7A/nVbAe/9UgbQN2547NWRPBj19KSJK9Ai18ff4Cax3y9QfoQ9R8VcSGblvWHd076O/CugC+uf/o4ebAHLQQ6FHiDMOkICuqJr1W/OnaXTKnIdP7ILgGzSDroqhyR0TYZKJDgbVrPQgt/yzkn69oCAN7Z3jCkEHFGYHewO2+SgMH5QZWT7/K4v54VaKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48MgdR11/uvaDtQjqemrDJKQaqnyYdqNHJM4UyB+P7c=;
 b=MPUlaQZC0Nws3q4GeNOSsJXmtrSfvzS4jSvdlOMT8LT+z7zLE0LIbgUv5h5wZR7ihHwl+QXtMcucAg6o+kjcoAirUKOuwvBp4MC2mFq/z6uzVZyaf9X1QQjmLuYljsnf3a20LK59g0pxdePZl8ouMcGZJAELle/nk5228uk1u8zl+gxpFRoZ/2w3SUBJSaQ9MUGc6Kq8H2FptWprDP6kC4OLbern2uzk3YlwJqj0XMKl3kjVlefoXyi9kUJBO8BxECUjXoJG1wsKJTefOuf2KJqExuAdhNfCDmlrPMKGYPKnx0B1fihBEKzumHOJWMUy6YButMJDvGvIOGrgu1zDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB2081.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 05:13:44 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 05:13:44 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Shahab Vahedi <list+bpf@vahedi.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check
Thread-Topic: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check
Thread-Index: AQHbNETnvCBHpr5gOUWaxHleE6A6YLKyQxKAgAI3NQCAADApqg==
Date: Wed, 13 Nov 2024 05:13:43 +0000
Message-ID:
 <PN0P287MB28435A985BADB4B4D857223AFF5A2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241111142028.67708-1-hardevsinh.palaniya@siliconsignals.io>
 <e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev>
 <6454497ff35d2a534cd34b7635fb044e4033fe6b@vahedi.org>
In-Reply-To: <6454497ff35d2a534cd34b7635fb044e4033fe6b@vahedi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN0P287MB2081:EE_
x-ms-office365-filtering-correlation-id: 12064089-c393-43bf-d395-08dd03a1f1ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rJXl2wd5tIGvVpillalphRNo51nBwroHthiLgXrQn51edGLZOUNe3Swkka?=
 =?iso-8859-1?Q?5dnMFWqN8hiRdkyl6Sh60Cv57aAW0Jh+GwT6v+xDMlk/vW2Kn2oS3orJ/N?=
 =?iso-8859-1?Q?uluz9aRD3u9uv50Qbcmo00hCNZC13mOX14X/BSeq5Db10yyMeW53JvfQFB?=
 =?iso-8859-1?Q?4/6hOJFrpbX6Z2MnPUsHea/jctta5+UQ2TXDYLEFli/EfH4hClNdrQXhVu?=
 =?iso-8859-1?Q?SHcp0m8SpfIYBcHSSXatf/CN5Q5I+F8mbFlxZbIKPaPHUrSnNs6qpqLHsa?=
 =?iso-8859-1?Q?nNlJ28z3IaEJJJtiIupEZ1HFUJ7LJbdD8xgETcnKoXNUPZx1fk9fL888YL?=
 =?iso-8859-1?Q?9MwdZV16GUhB5LnQsy/pm584likyqv81oGnF98NfFOZ5T6ertwhJOvuRpi?=
 =?iso-8859-1?Q?S9cJELiZOegHDgg2Lu77yojRMCbVrgvUIuR3otqE5xNpuN8o6vdLU+h6s9?=
 =?iso-8859-1?Q?XtfJldN3n7mW5SIJvi0Xa3UVOZlX2MIa1xP6p9AKHnOSNrnDfiXIpVSC80?=
 =?iso-8859-1?Q?ORlyhDCZMoPE+yB21fxNQz+UplnxBwEbaDCy6kGI3FDOPijkDjnFKe55A6?=
 =?iso-8859-1?Q?XzpgQH/T6L2W6h5Z6se2Y89csrhr83rUD+eo1+jhYUjIgtIeq10z+N3bRk?=
 =?iso-8859-1?Q?Z9AaPtgt8z4MQmooX9/lCRvjzfXy/xMFk/gG94O8ZKxGWydoncuoEF++e9?=
 =?iso-8859-1?Q?hxhTHdaI/6GgbPeiEQSymdjo+lKxiHSz+IupqKO8tSxEIiQJBIjg5nSxRc?=
 =?iso-8859-1?Q?egP0pYna0i5iyTB33nEVrIzUxVCf6Xgp7KK4pBvUIBCq7j+nUZ8yN7XYAK?=
 =?iso-8859-1?Q?m1+hkgUxBVxiQidEAL/KfI9wLMO9/Ifk9bmPo47RarG5KGhVMtQ2HUk+uh?=
 =?iso-8859-1?Q?PhsWvGgmoYLzvaDlzSGggOaQ9xONoDdpQtwPMzc8Ne4kW4fACTEL8M6mFT?=
 =?iso-8859-1?Q?YUkIOUWpD2G+b93iv3wXpfJgiHtDq+lzA7vEenilXjHl10KvBKoBkGdPtA?=
 =?iso-8859-1?Q?HWERQTD57D1M//+ws1zCIBl/sBC90uBemM4tds9WNaKkqNTnQ1mLggogAy?=
 =?iso-8859-1?Q?mNWW8iAUaHYNVLF1zWIyL3D7IoAooxYQpjwMvjawRaZeHLO0Ew7mPnwNVQ?=
 =?iso-8859-1?Q?CWsU2NLEemsItsVSA8dbcm7ap/rOvmt2n2v/Smf7aiYD97qDzzK59jytYw?=
 =?iso-8859-1?Q?aMS29xl2EQJYb/4Iv4n1nEPcG8tkUYPACaMjfv8rb5UOZPDL51Gw4dAMV9?=
 =?iso-8859-1?Q?dqlyC+xDrSVO8bFZVKVubfKgVmM+t9hZeiecLYgBpdnBr6zQIrJ1CXA77p?=
 =?iso-8859-1?Q?qR/ex1TW7xoPwJjOV/gwoMWyFlVVRM7kes4GQ/Efq43EVVo76X/XSJB52k?=
 =?iso-8859-1?Q?GuwaGucy3+VRj48F0nh/gdX2CV5cHmQRaqvxOLWM3tiGohvWJYdXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?loqeo16jb0BuW9w+pAF22/xu7+gyrNP6qdS0ioP0s7JCDP2cv0lLKVtPn0?=
 =?iso-8859-1?Q?c/ItwefXJxCnwdVXegm2w9or3gdTn1vVxjWgP79eyA3cCOWTRtaBAjXKnI?=
 =?iso-8859-1?Q?HbEUC4Mfch/RnXsOaJDHpptpwSLMkiS495QKtALiZFOYHxFe7t7qiMZ2uB?=
 =?iso-8859-1?Q?lBZkbOGVPFpLonQ5jKTNwLM9BpAQtYrKDyCBSSVjpng6jUThgJCvomhXeI?=
 =?iso-8859-1?Q?UvK/w32xHPFvMz7e+G4/K8nbXUs20YGiISq+6JbQe9CEsH0JouObuZV84c?=
 =?iso-8859-1?Q?/rUg3GIU903yZWs+8sW6CYcg85CN20qehUISnfOWniqgDMdmywzXjy/FnI?=
 =?iso-8859-1?Q?ACIdyLiz3sPk+Dp3wP3XCDRQbAWkWw9JiCwdir1CEFabxFtgs5a+wnXAH+?=
 =?iso-8859-1?Q?E5Scw7/7zQ/Nq4BBy7IVNHHIw8w2E+nmCCRsJ54XST7S8aw3EtfWnJqa16?=
 =?iso-8859-1?Q?QWdw82a2ZSVRItH8VIGT243x/6kpAiCb2P6P7oui0cUsCYPa9nTf4ugRUt?=
 =?iso-8859-1?Q?hOkD7FKC9bYwbnLw03B7n0xk4nVQHii4O/ytLTAABpDhDcIf3tofcO+8NP?=
 =?iso-8859-1?Q?DbaJY5Dfgo4uaNJDxSuaoOfZBmk4uSA3gT5cxTJApo8JG9y+RKPUi2gSrv?=
 =?iso-8859-1?Q?Td0XeP0ejWYZbMEmeVft6j0+DGN7mzhtdmd/ttCgu8z7SMW8RG3EyMy+5z?=
 =?iso-8859-1?Q?NrkkAfBT2N7eY/4XeH0CKBu6ceaGiNw2J9M292S5pSxts86uwOyuTIRBpD?=
 =?iso-8859-1?Q?jEK3mOLnjA+45zZ6VF0/GkhdoyeG9rCSnrmHCD7aOJO07avoLomPmnQxPa?=
 =?iso-8859-1?Q?9Lk76Cns2HNXsQkaZwEALA09k4Ry7yvkPExVcDaN3bkgF8capS0+HreNoi?=
 =?iso-8859-1?Q?FkI+4oWpULTEd5nRWEpKMKZmY7xJR+KNhTcTkYFt7FESWnMYOXyWGT5qCi?=
 =?iso-8859-1?Q?JSTBZsgrjbeAGql2HgQjC4D7ET1bwWOgTpggawxMz9DCjzUZeQjXTcmRV6?=
 =?iso-8859-1?Q?ssWLDslyaRnjbhQbbwhYmbdwyQ9M4w5a/KnwkEmKAHf/HswHcTMuUQIcdc?=
 =?iso-8859-1?Q?MNPgigdgKyXHMjb/naBlyZcS2wJDQ+RfOCmDBK6vUCp8wwHbUEHbjAZ9to?=
 =?iso-8859-1?Q?jkOKuUp6c9Matg7nbD1JCudfjLrQBYqxEy/jNevAceHyrYeluhAWYsVTBv?=
 =?iso-8859-1?Q?C3AX8jg6HpFE3Wh1Q9TVNyDLCsQ7vKVlXp+wir+HR0Giz3PYHYQtpT3IOZ?=
 =?iso-8859-1?Q?R723gBn0wPORVBScwLnGjGuq1zErFkcs7ftNlysuaducT9a5idekRmTMBV?=
 =?iso-8859-1?Q?t23YR62sELLcPKFxX8F/E2Tu+sRslu6E8CbhN1PvLS5Du1Np3VTz5Qr831?=
 =?iso-8859-1?Q?aagVGTbWSCiBj5/+009GiMfkGIiXGBdpg9+ucbfevBiUsmYjrxcQVJkl+p?=
 =?iso-8859-1?Q?RfN7vrVIVSXI20xInjB0nNV3rdegOo0sss1IP3boX9KvZv45ffytdBcEC5?=
 =?iso-8859-1?Q?ctW3plb5L3zOTk0kOXkhS6X/S61lB2orIWRCN1S44+uM0nDFu652sV/Dc+?=
 =?iso-8859-1?Q?q3sAOEUa18D12A8sDWi7kVW91rLeR0udBQFiPwfD3IyxJga/emj/c8yZtY?=
 =?iso-8859-1?Q?tYhMZACm1lhbFzpuuGS/Bl01/deqZTkniitZJOooeU2OStTwVNda58GJgh?=
 =?iso-8859-1?Q?xwgZG0dfet2dOKoRbMs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12064089-c393-43bf-d395-08dd03a1f1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:13:43.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBcHK5amjlcvxD/yH1Y2mCvcElIjklTCPz+X9Ec+klr7F83h0WA1JIHbYCIHTJ8FBvRFF07L2l6oht7pDuzogF+RP1/BAb3aY9MOP7bYJAGp5e6Ixw8hC4sQAcLm29Vo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2081

Hi Vadim , Shahab=0A=
=0A=
Thanks for the feedback=A0=0A=
=0A=
> > The original code is obviously optimized out, but the intention, I=0A=
> > believe, was to check if the jump is conditional or not.=0A=
> > So the proper fix should change the code to check cond:=0A=
> >=0A=
> > - if (ARC_CC_AL)=0A=
> > + if (cond =3D=3D ARC_CC_AL)=0A=
=0A=
Okay=A0=0A=
=0A=
> That is absolutely correct. If a new patch is not submitted soon=0A=
> I'll try to fix it myself.=0A=
=0A=
if you are okay with that then I can proceed by submitting version 2=0A=
of the patch with the proposed changes included=A0=0A=
=0A=
Best Regards,=0A=
Hardev=0A=
________________________________________=0A=
From:=A0Shahab Vahedi <list+bpf@vahedi.org>=0A=
Sent:=A0Wednesday, November 13, 2024 7:41 AM=0A=
To:=A0Vadim Fedorenko <vadim.fedorenko@linux.dev>; Hardevsinh Palaniya <har=
devsinh.palaniya@siliconsignals.io>; ast@kernel.org <ast@kernel.org>; andri=
i@kernel.org <andrii@kernel.org>=0A=
Cc:=A0Daniel Borkmann <daniel@iogearbox.net>; Martin KaFai Lau <martin.lau@=
linux.dev>; Eduard Zingerman <eddyz87@gmail.com>; Song Liu <song@kernel.org=
>; Yonghong Song <yonghong.song@linux.dev>; John Fastabend <john.fastabend@=
gmail.com>; KP Singh <kpsingh@kernel.org>; Stanislav Fomichev <sdf@fomichev=
.me>; Hao Luo <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Vineet Gup=
ta <vgupta@kernel.org>; bpf@vger.kernel.org <bpf@vger.kernel.org>; linux-sn=
ps-arc@lists.infradead.org <linux-snps-arc@lists.infradead.org>; linux-kern=
el@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check=
=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
Vadim Fedorenko wrote:=0A=
=0A=
> The original code is obviously optimized out, but the intention, I=0A=
> believe, was to check if the jump is conditional or not.=0A=
> So the proper fix should change the code to check cond:=0A=
>=0A=
> - if (ARC_CC_AL)=0A=
> + if (cond =3D=3D ARC_CC_AL)=0A=
=0A=
That is absolutely correct. If a new patch is not submitted soon=0A=
I'll try to fix it myself.=0A=
=0A=
Cheers,=0A=
Shahab=

