Return-Path: <bpf+bounces-58744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A17AC12BC
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1F717766C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81419ADA2;
	Thu, 22 May 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VTvGRsHR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC317D346;
	Thu, 22 May 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936599; cv=fail; b=H9UryR5zJsmedHSvqQxRRgrWesccIdkxasN3H2ltNF0rR8jaO6Gdg6JtEUrSPN8QPOIMcl4Sd5jWzV6p7+GiCiVzUdUUCHhw9V5+2K2yhyp9BhwYlylXmeHu+5f5YeVPBcIWabD7SnYp0rKOEUEGNwBbzUp1vc93cERQPxoHcPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936599; c=relaxed/simple;
	bh=NpHkML+j8iNV/OhKmIllQkd/B+l/I8Nt3ICrvPGxE+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bjrq9NPLyj22DwwhIIUZmoix6FSxthD2FFRHzXs8OpbrJQ8LJev4U+pkUPbqfAEa+gbpW45+0qinLsWYzY5UpxKRm1pHi0Egfs71tRu/hfIj4xTkWQgAHjzEFKGp7LMlmCsaXtoPs8BBHjpsCJpM/UcQr5XhNZNB9N6uplyvcPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VTvGRsHR; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MH27wM002219;
	Thu, 22 May 2025 10:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-type:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2021-q4; bh=Fb0DBak
	vWBDBGHfKhdUx0tuZZm6X+HPyB1/YUQ8XNkA=; b=VTvGRsHRV5kZ5yFGdZ/PO++
	WIwITQM8+yo9OOUPngHrZUQbxvPupvCL2Bzf7JWuYd4rp7gydT8vBJpQ/Jd5KrLv
	C7GqW2W4dvHhHkOz8R1Zsr6MVxXxQO6za0uQRcoRmXW7NTDEaxxTPx8Kxgi+x9sP
	hVw7tx2u1/v1avLoXIFdGTya2knhSWsoBVCAlCOOv/AEnUT4LtnDCtaUj5SJwrlx
	BHVHBG36FuETS1SoSvyz1lZvx4Skezcl7cM3FslrpE3g2h5gkUywtSXJt4t1P8co
	m3SRhjdxhY7Jl2WBxBVv6TkFCAe62xOLSEJ7mUxDYXMByq5biKioHQqEusLy+iQ=
	=
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sxxfvn5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 10:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww5bHVK15QtKWft2mLchsXxQxsJHMQ7pKmBX4cLk7c9phxCNB5/acIpKwr50Ds3WkrCoaEeD6FRcC9v0PVg5OQ+Nc6a+4pZSIFcbLXuaRueoUsVtXBxvNQrfSLzI+HKlJwA2WkQ54Up40L7X5f5A5HpMLjUtIEC6a6vJzsQqrFoVHqE3hj7mXLcdI9mdRBX1ai7ISXzeKr4IYFwwtMYRb1+COeDul6gPyZAazt9S7AfbXPGA3boEtXkaI1K/q6g58OruXXBFQdgS9IEL9rzavX1ub84FfKsiQD+omWdHMC1b8iVsK9Q3PY7rcC8+/QHVXvjqLt6iT2Pv+LxMl2dWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb0DBakvWBDBGHfKhdUx0tuZZm6X+HPyB1/YUQ8XNkA=;
 b=xb7LJfYCfoNEo99CNJrW7mJzQ8gRAkuTkMh0F1L439H4E/yLb47f1YWeMJV1qj6ta6A4uVX90NkWatm80JLTYBUJtr91OlzCeYQIohYuPsihsSQXyPiQnNUdmpYLmV4kmvQ6Z+6Rc6bkLUeOailFfqjoozT0UFFoksWa773zd4QVkMMEJBa+j6uxeweQsDzC7PDt7Uq9O3XaSAUumv1lnYHzcTQY/8+o3xBd4q3VcJA/ZUOYipstNsTPvk1/gblbz+1pKdE8iztynQkFFXi+4Ec+ITb5VWh1/TILsFxvPaFROkz1UAXgRL+yj+p3FMo/Sqqy5aQWIhyLG14Jf+5qcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com (2603:10b6:a03:4c1::19)
 by SJ0PR15MB4327.namprd15.prod.outlook.com (2603:10b6:a03:358::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 17:56:29 +0000
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029]) by SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 17:56:29 +0000
From: Thierry Treyer <ttreyer@meta.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        "dwarves@vger.kernel.org"
	<dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        Yonghong Song <yhs@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu
	<songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>,
        Daniel Xu
	<dlxu@meta.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Topic: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Index: AQHbrwS3AlS1roAfS0S+1p7h6I+KLrPaDacAgAUZ8gA=
Date: Thu, 22 May 2025 17:56:29 +0000
Message-ID: <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
In-Reply-To: <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5671:EE_|SJ0PR15MB4327:EE_
x-ms-office365-filtering-correlation-id: d274c881-93b1-4aa2-31e2-08dd9959fad1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6/8lr3oQX5AZea+xQFfxrqr/l94w075kwxpLtWaOJBru18suJ8Fb6rQGNfXr?=
 =?us-ascii?Q?9Jcsh7wdVXWeAQv8copKoC1PZvLqUzYQKFsZT4+vttF6XjaVSNbm4oqgvRdm?=
 =?us-ascii?Q?+LiGPdwgAj0tc7mfmGyKd31cLRfQy5XiXtaTCiHOO0NVJCrvBvbeinY8Wd6K?=
 =?us-ascii?Q?HotawaJ0/u4SYawuDBil24ihhBGjE/N3K3pC47Wv8QzJ7+UzZCF0JzR2CQO+?=
 =?us-ascii?Q?apAu4rkYHz0KviXLgZOXS09vI1C/Pezdg96PDvZ0W2wZ4uyTmaDeFvLF5rv5?=
 =?us-ascii?Q?WeaP4G/QF2f5fnUWqzaZkyPJZ1M9mYlxaOYcPA3oMJ8bUslGftw2f8qLItRB?=
 =?us-ascii?Q?G/ZUDsvCVr7ZQQ+vVpzfUFXt5dUGVsfIj5egFt6pYknktlFI3qx4nmVE9wlJ?=
 =?us-ascii?Q?NJbdUyagSAhBKVYOTL+QMgzy5wvAvHoc8xS62z773wGWiR+/q0BIYGPfdaln?=
 =?us-ascii?Q?Ju4KOp4QaKl6GiSNFvuMTCvBUNm1d4iPlBUTgJ+pDGCPFiJAzz2GI73besyQ?=
 =?us-ascii?Q?xELpGa3yMoqtVeGbEoQ0AylLwqlzwNQC0UpqwtpsGXJuCLyBpYr2sMdaft79?=
 =?us-ascii?Q?r9juxxS8a1Jp1CcMsxbhC6f0MvZGHhVmhPPFdj+ZzQVC9zpEzWBr9peizOOi?=
 =?us-ascii?Q?2CZNxMTagvpv4AAkmHTt64clANMReZsWbvd6jQmyLMfHQEQDF4ryxMvgxLEq?=
 =?us-ascii?Q?v5dNLrHz+E5Gk9NmbOQTKnN8/dWw8YhfNovCpHLJCYJroYCHT4LZjK1WHc9j?=
 =?us-ascii?Q?usfbMvQJcv0cJrYfS3qEZkcFTdyuRzuxautxX81JGSjIZ6JAYMYuANgIWL9M?=
 =?us-ascii?Q?S5Ap+TVYeSuoz0DppkC0mmBY7knBLk5jhJ81NHup5NdKx9zpr05e6YzC+MEd?=
 =?us-ascii?Q?NaAtxfNPs111mHf0/pT+e/G9KZFttrCeY395s1iFbjdU7NzZkFNemiU6vgUz?=
 =?us-ascii?Q?dVwE9xzhOZXIiPcHh4UM4pF8HlbZ+gRTpockd0HsRqlx8N6/UxFkAadzjq6w?=
 =?us-ascii?Q?cbVxj4IkiBS1NfhlbCZnT5za0Sa3xSpTsSdLBCQqXJ/jLhUfTxx4XGZWyeER?=
 =?us-ascii?Q?tNBauLDIAi85b37XnVtWd4nwIb6vR/eH3rDC+gOOs60fCpv9QAREDkeXkFwA?=
 =?us-ascii?Q?gUWLvXyrUNkx7JMIXDw9qUDg2BxeZExcio2Z4RXnd+R9Pu1oFSv+HZNduicY?=
 =?us-ascii?Q?aSKkXj/B0pPlUkRlViWM+aH5vHa9IwbTPpjIeFUOYyCCTiNeolyWn94VidtC?=
 =?us-ascii?Q?Ya0lra/efMfdEMtUgTJZf7dky1/vA+fL0en7DPdmOUHuhfSaBu7By5iz7YP2?=
 =?us-ascii?Q?9hz/ckvuh4RBIOF6Q+tJXEvKATzdgjVHPPMIkbNdZ4iYVvO0jULFBK70EJLx?=
 =?us-ascii?Q?7zDPi+yPknhC4+831/W9KtEx8H69a/0A79EkzXLiUnUBLuG2HLUsHOSdnwxk?=
 =?us-ascii?Q?FIkNVgspsoUgKypid7fbHOio0vicgDfcCEih7GNmg/cVyu7tKu6g6Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5671.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6RMjd92p+DtxKmLgQXOOIBcX31pzcJje253a0m/pbokUKNVROe5fGY1nOxNJ?=
 =?us-ascii?Q?JaCJz+637G2Mii7En6bNUYhWuti+F0CGNLC0015QCxuZr2pcnkklZG8dhw0E?=
 =?us-ascii?Q?3YLcayEQweoYyLvywLGbMWeG7oNQkWm2pqCRjk9ADOUxCO6SuCXiUqyH8sym?=
 =?us-ascii?Q?iptkkqqLiczEHAl1sA1sjIHs8GCF9xbDnuQd36Z49v8jeVDZ3hT63FL3IOYp?=
 =?us-ascii?Q?Jdc4gOE/yey/IQ7HNayMh8ZGBON28zbBu5x2nudFnxkN09gepnXFU49x0nys?=
 =?us-ascii?Q?0Cp+je+oguTkyQX/DVAzX27+Xk+3pZYHD547R4Ax0o4z/1ijK8jO5xwElePX?=
 =?us-ascii?Q?OxGXLxsnSL+kVm8Smjd2N2b4E9q3bUNy5FesRMNio8C0K0HWrWHvCTLbJkKD?=
 =?us-ascii?Q?njMloSHNl2AMVJpSth3qWuEsfVlk32K6l9ewW/ZzUl6GH6+stpLRE3q/Vtus?=
 =?us-ascii?Q?MR76/4EBKSDvfRcmDhSkSS7ODUfFfV7OkzJahR98cU/h5JXI3hwPex8oWutK?=
 =?us-ascii?Q?fOgnPTHsVCoT26uv5sgRbM0+hp/SbiDOQfD+k93yUIDsle3T5wXybNPu0ai+?=
 =?us-ascii?Q?0oRbZ+pJFQG52reW6lXdEnCkt4qWL5lCA6ZueQwc/loaGbFchchZjfjHSemt?=
 =?us-ascii?Q?mI0Xekn0T9KcScwhhGEz5BZCwKC3eIfJTmk65FLnPNnkE6rsA3pLiHgLcIxp?=
 =?us-ascii?Q?qA0xFj5kjbZJRT5ujizO+spNe8i+tuvdfgEfRuYqC6DgvZkricZDII9CuEj9?=
 =?us-ascii?Q?eT8Rmh8nBFpLSCya/GNB8FFlqF7TCZ9Ag7EqhLPJCzVw8sbLGVBgQOCqlbjF?=
 =?us-ascii?Q?QZiPXDxHYkwLvjLlO8M7qSuCrfhbLkWm+Ef3YItirt9/Pt5svm33dqMqbYTe?=
 =?us-ascii?Q?/kwkwR+Y27A1/2QtoQP3LLyo+Gj/oMIETiZMx5XbcJEn5WyT2zP/rYDx0QOt?=
 =?us-ascii?Q?WZxs6Z1H90J9VnAblaNyIR/SeEZjixHr0vHy9tnLXkP0R0vHwKz0U/tcwtQV?=
 =?us-ascii?Q?3lQD9BJiZKy01DsYVE40uXlAXpR9lz98SxjKj+2NxKm3Zx71Pq+0ErY2yEsL?=
 =?us-ascii?Q?UvIgU1Awz2kCumWnlMsjRvBBXis3QF9pjAASwv9xR0xWWL6JSlWV0cthf24K?=
 =?us-ascii?Q?wg4LNHMYZPREdvW7yeZW7WnX/gfMp1sW0K9mNp0AJyEVL9oqQD9sVU7wILLT?=
 =?us-ascii?Q?tUbJ5qXcodFzLKhytXKbSXlNAdZ05k8FWomYx1iMHl8YiNw26NLjlAK4+fOc?=
 =?us-ascii?Q?CoU3OBdQG+gaAzpqmKGm8CLMZO5qtnWgZLoRJ/XiAC2sHQahMS2qF2/bjiKT?=
 =?us-ascii?Q?rZqqUkUafX/xmDtshI8RhsZfp4muImjP192if9/3sbRCblnS4quUUrcON190?=
 =?us-ascii?Q?5awCrls9KbBvYR6VIPA7qtWmyIqsd7aemaQQHP+fQ+2MxIU0zFdcMpvCGLxQ?=
 =?us-ascii?Q?oCQcZ8F1sF6XQhQXz12c4j2Vnrenh6ohV17IAvaC306QkvjsNutoJ1WScl5K?=
 =?us-ascii?Q?mJrc7oKHkqumFFY6i55kWbNt5GCebCNs11/swFFZN33g435cRSc7BLKV12co?=
 =?us-ascii?Q?06cUkC3HKlhpKSY4AVNhLmAzlAG4sy10JrOFPwkJ70FsiBTuZU2hejo++lmg?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1408F5B3A3BD744C85CBFCF416DFD4B2@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5671.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d274c881-93b1-4aa2-31e2-08dd9959fad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 17:56:29.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pFf6qtkYg9LqHRh0pzMxHyT5e77VTxLPbATh7JVbdXNbza1GvIyJtZtGjUufmVZBKRjN/6Ga8ncUmAJVNSLTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4327
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE4MCBTYWx0ZWRfX07iRzlNkUbIb LxeOcDBjcc8hutqkq1d1OqcZxd1M/sqgsdaPnMMdt8b9gzPiKM0zFsQ/F5jNrisldiIRJPWgAG6 HR44yFKOsIoFj94BlltF8I7ju89M0/25PR8nLKEAqDSg9DH1veqEvVZtW2xyPPGJ31TyCoTmLYM
 jx8wAKbUh/dM3waWA+s4lJT/46Og7eYNkuyTopYgjgBnxSltwBBQXXuNnGuoglgjF4LxHuujSvF c6rgKl6cJ7DflLXAY6A4D2cl4FBtQBCPGQUycfY59YXjbNLacKNLie+LdAVCc5VwS+tyrY+wqjZ 8gp001yJrYm/WjG0t28HvdAfd1FOOjgP9iCetge1qYGgF2hAWyPkT+/Ugg4zgG/Y93GAygQsyEC
 07B0lgoQefVpgEEyipavJiYlgRPLu1m91Cn08lLYdrc76UQgEdNuOOFRCi5poVZzJNU+o1KJ
X-Authority-Analysis: v=2.4 cv=Jfa8rVKV c=1 sm=1 tr=0 ts=682f6554 cx=c_pps a=saJovQ9iJe2malDXQQFA0g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=pDGZBajjjjAXv3KN1G4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uLu9tL8pQLvNIqvjdsiLJAaNEOLF18AN
X-Proofpoint-ORIG-GUID: uLu9tL8pQLvNIqvjdsiLJAaNEOLF18AN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_08,2025-05-22_01,2025-03-28_01

Hello everyone,

Here are the estimates for the different encoding schemes we discussed:
- parameters' location takes ~1MB without de-duplication,
- parameters' location shrinks to ~14kB when de-duplicated,
- instead of de-duplicating the individual locations,
  de-duplicating functions' parameter lists yields 187kB of locations data.

We also need to take into account the size of the corresponding funcsec
table, which starts at 3.6MB. The full details follows:

  1) // params_offset points to the first parameter's location
     struct fn_info { u32 type_id, offset, params_offset; };
  2) // param_offsets point to each parameters' location
     struct fn_info { u32 type_id, offset; u16 param_offsets[proto.arglen]; };
  3) // locations are stored inline, in the funcsec table
     struct fn_info { u32 type_id, offset; loc inline_locs[proto.arglen]; };

  Params encoding             Locations Size   Funcsec Size   Total Size
  ======================================================================
  (1) param list, no dedup         1,017,654      5,467,824    6,485,478
  (1) param list, w/ dedup           187,379      5,467,824    5,655,203
  (2) param offsets, w/ dedup         14,526      4,808,838    4,823,364
  (3) param list inline            1,017,654      3,645,216    4,662,870

  Estimated size in bytes of the new .BTF.func_aux section, from a
  production kernel v6.9. It includes both partially and fully inlined
  functions in the funcsec tables, with all their parameters, either inline
  or in their own sub-section. It does not include type information that
  would be required to handle fully inlined functions, functions with
  conflicting name, and functions with conflicting prototypes.

  The deduplicated locations in 2) are small enough to be indexed by a u16.

Storing the locations inline uses the least amount of space. Followed by
storing inline a list of offsets to the locations. Neither of these
approaches have fixed size records in funcsec. "param list, w/ dedup" is
~1MB larger than inlined locations, but has fixed size records.

In all cases, the funcsec table uses the most space, compared to the
locations. The size of the `type` sub-section will also grow when we add
the missing type information for fully inlined functions, functions with
conflicting name, and functions with conflicting prototypes.

With fixed size records in the funcsec table, we'd get faster lookup by
sorting by `type_id` or `offset`.  bpftrace could efficiently search the
lower bound of a `type_id` to instrument all its inline instances.
Symbolication tools could efficiently search for inline functions at a
given offset.

However, it would rule out the most efficient encoding.
How do we want to approach this tradeoff?

> 2. refine the representation of inline info, exploring adding new
> kind(s) to UAPI btf.h if needed. This would likely mean new APIs in
> libbpf to add locations and function site info.


I currently have a pahole prototype to emit "param list, no dedup" and am
close to a patch adding FUNCSEC to libbpf. I was wondering if it would make
sense for FUNCSEC to be a DATASEC with its 'kind_flag` set?

Let me know if you have any questions or have new ideas for the encoding!

Have a great day,
Thierry


> On 19 May 2025, at 13:02, Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> hi folks
> 
> I just wanted to try and capture some of the discussion from last week's
> BPF office hours where we talked about this and hopefully we can
> together plot a path forward that supports inline representation and
> helps us fix some other long-standing issues with more complex function
> representation. If I've missed anything important or if anything looks
> wrong, please do chime in!
> 
> In discussing this, we concluded that
> 
> - separating the complex function representations into a separate .BTF
> section (.BTF.func_aux or something like it) would be valuable since it
> means tracers can continue to interact with existing function
> representations that have a straightforward relationship between their
> parameters and calling conventions stored in the .BTF section, and can
> optionally also utilize the auxiliary function information in .BTF.func_aux
> 
> - this gives us a bit more freedom to add new kinds etc to that
> auxiliary function info, and also to control unauthorized access that
> might be able to retrieve a function address or other potentially
> sensitive info from the aux function data
> 
> - it also means that the only kernel support we would likely initially
> need to add would be to allow reading of
> /sys/kernel/btf/vmlinux.func_aux , likely via a dummy module supporting
> sysfs read.
> 
> - for modules, we would need to support multi-split BTF, i.e split BTF
> in .BTF.func_aux in the module that sits atop the .BTF section of the
> module which in turn sits atop the vmlinux BTF.  Again only userspace
> and tooling support would likely be needed as a first step. I'm looking
> at this now and it may require no or minimal code changes to libbpf,
> just testing of the feature.  bpftool and pahole would need to support a
> means of specifying multiple base BTFs in order, but that seems doable too.
> 
> We were less conclusive on the final form of the representation, but it
> would ideally help support fully and partially inlined representations
> and other situations we have today where the calling
> convention-specified registers and the function parameters do not
> cleanly line up. Today we leave such representations out of BTF but a
> location representation would allow us to add them back in. Similarly
> for functions with the same name but different signatures, having a
> function address to clarify which signature goes with which site will help.
> 
> Again we don't have to solve all these problems at once but having them
> in mind as we figure out the right form of the representation will help.
> 
> Something along the lines of the variable section where we have triples
> of <function type id, site address, location BTF id> for each function
> site will play a role. Again the exact form of the location data is TBD,
> but we can experiment here to maximize compactness. Andrii pointed out a
> BTF kind representation may waste bytes; for example a location will
> likely not require a name offset string representation. Could be an
> index into an array of location descriptions perhaps. Would be nice to
> make use of dedup for locations too, likely within pahole rather than
> BTF dedup proper. An empirical question is how much dedup will help,
> likely we will just have to try and see.
> 
> So based on this I think our next steps are:
> 
> 1. add address info to pahole; I'm working on a proof-of-concept on this
> hope to have a newer version out this week. Address info would be needed
> for functions that we wish to represent in the aux section as a way of
> associating a function site with a location representation.
> 2. refine the representation of inline info, exploring adding new
> kind(s) to UAPI btf.h if needed. This would likely mean new APIs in
> libbpf to add locations and function site info.
> 3. explore multi-split BTF, adding libbpf-related tests for
> creation/manipulation of split BTF where the base is another split BTF.
> Multi-split BTF would be needed for module function aux info
> 
> I'm hoping we can remove any blocks to further progress; task 3 above
> can be tackled in parallel while we explore vmlinux inline
> representation (multi-split is only needed for the module case where the
> aux info is created atop the module split BTF). I'm hoping to have a bit
> more done on task 1 later this week. So hopefully there's nothing here
> that impedes making progress on the inline problem.
> 
> Again if there's anything I've missed above or that seems unclear,
> please do follow up. It's really positive that we're tackling this issue
> so I want to make sure that nothing gets in the way of progressing this.
> Thanks again!
> 
> Alan


