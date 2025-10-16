Return-Path: <bpf+bounces-71130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC38BE4F53
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC76F359517
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E222D4C3;
	Thu, 16 Oct 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N+1c6v3+"
X-Original-To: bpf@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023125.outbound.protection.outlook.com [52.101.127.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAE1A316E;
	Thu, 16 Oct 2025 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637449; cv=fail; b=XdaVj3PZk+Q7k3gUpDbxtLbEnf/0NPp2d2c5ftWx2867PReJ/dfosm8B4PNzQD/eg+6ih/UOCAQ+Kj3/gnruJqZ4i5tbDwWfW5OBPv9ZCjuhtM+cPn+vuS5PFJVRpn1RP7X3njLsPsDmiyxKi48mzpzyFQXuY3FdprVNbvE+mYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637449; c=relaxed/simple;
	bh=EJsVJmq3QAzkqV2GNLOJGRMRBxE9cmnyOBGJxHf1MuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJEXDZVrtE0VOPjasdQr5IgudfdDTp/vp/TrnfdCg8jwVMab+61JAQWn5tc9M2YpOmev75InmcYm5sZ7YBV5RTc1DR6S8x61nWYMLnSlInM3xIAS6U4BxZgmJ4StIINfzc+rtVxNw9Bzi0XtOPebH/eb2BMQAohQd5aEGU47sGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=N+1c6v3+; arc=fail smtp.client-ip=52.101.127.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFD96Xq2pJINxHnBtBar7Pliz0dP3C5ThL+RYKrGSKChfekfPTfk1ykzR9qOL8pdx3gqa3GBXwi/37qfZ+9ndSM7+MkQInGAU4NtORIo8ijL8F5fDYTX1oLqtntRgXVEIVEOgCI3/8gZ4uSyHXSAQaqMmTn7fVC/OVa/zRpWUbLFYBGSH4a6vMWFm2aFFej1hDbrYpM6ocr2hWocMW9icoLtxX4+JwyYRPezXV83lKDL5VsJIjpMxVuTD7vY9PEBgbotDfItXRZVRyN0D1/lJFCIA+MGkYI6OdaXcOuOSZgVPTdr6s0AkPBIMXTEqXQcNn4MII3wb/OFLgm3o1kX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJsVJmq3QAzkqV2GNLOJGRMRBxE9cmnyOBGJxHf1MuQ=;
 b=UBNFlNuYpYPtEuVg0hUSfgJqZ3AkBYiheNgR2HCgX6vXCO9bx81P9DLLOcZWLpRx6Y/oa8XCjun0VfjCBagLxg69DXDcbFNmz0AxsY9jM5N6h/9ttRJJvqwcE5pwUMW3jKC5xdbvH4DY6WDZQs/cLnRjQ8RvR4YbkzNEZI46Nskn0uyfq9NWc9K3stOGc2n85F6OjBRwKoGbea+Lc+fMbNcJXG0XsbDkLya5QLZjEB0c6nzeElMP+4ToHQ3HLsN6div+224g9Ks/j/o8hjCVD0d8+CtLnxOyQiBOChlvm+K/wQrWdlxRCaqaurkdVoj/RfxIcdQx38/Cp9ZmBpdqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJsVJmq3QAzkqV2GNLOJGRMRBxE9cmnyOBGJxHf1MuQ=;
 b=N+1c6v3+3ZRVLaf0Dz0BjAC8vJd0EkjuWMP2tMueNE4hcQFcS9H1+w5iAwNyEdDQ17qvB2oxrhgTBNtDYsLIlPTV8Qkn+ET4lYSW6zfEkXoX8g8A+AQC6cJsnWSFCdB+HbrJVe/9tHhogb3NYap+yqRV6Th/YjeaZ2tq8KrW5Cc=
Received: from SIAP153MB1317.APCP153.PROD.OUTLOOK.COM (2603:1096:4:28c::19) by
 KUXP153MB1226.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:12::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.4; Thu, 16 Oct 2025 17:57:23 +0000
Received: from SIAP153MB1317.APCP153.PROD.OUTLOOK.COM
 ([fe80::233f:27e4:c65e:e751]) by SIAP153MB1317.APCP153.PROD.OUTLOOK.COM
 ([fe80::233f:27e4:c65e:e751%5]) with mapi id 15.20.9228.005; Thu, 16 Oct 2025
 17:57:22 +0000
From: ABHIJIT DEODHAR <adeodhar@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-mm@vger.kernel.org"
	<linux-mm@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Alban Crequy
	<albancrequy@microsoft.com>
Subject: RE: eBPF: Reading page contents from a struct page*
Thread-Topic: eBPF: Reading page contents from a struct page*
Thread-Index: Adw+pGylejxp5FwHSM+VyUupq9syGQAIc2WQ
Date: Thu, 16 Oct 2025 17:57:22 +0000
Message-ID:
 <SIAP153MB13179A10B5ED98547C7B86F1D1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
References:
 <SIAP153MB1317241365710DEACB37179BD1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <SIAP153MB1317241365710DEACB37179BD1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ed1e3fd-99b7-4d6d-98f3-de1c9110a046;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-16T13:51:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SIAP153MB1317:EE_|KUXP153MB1226:EE_
x-ms-office365-filtering-correlation-id: 98dc808b-878d-46c6-8660-08de0cdd752d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EoMRxlYauCi8bwVXzLWI47d2HVXwNSFpXz9o+2r/URc7aKVGUKA6ZaNywhJc?=
 =?us-ascii?Q?NEYgY9PAOMab0mhYaAKdpiHJcGC5duUNfpqB9r3UF47MwyhlcwC15mULrEB6?=
 =?us-ascii?Q?9jyqp5GpupNYuErg1kop4QalRNev/LA9ligGwdv0kIHq5mF91Z6xpceePz9H?=
 =?us-ascii?Q?/xEqk+VeVIeZCedeoMnHnxnWH/uHcuO3fNiANiZFCkPszzgFwzAwySAu6AlH?=
 =?us-ascii?Q?gRrC0fWHj/KmUkjsCHBj8S6M2dWOSuv2JP/r6ekkDddJ1SmsO1W0Dt0AAxHo?=
 =?us-ascii?Q?0tYN5Syg7d7bQRaUC2cWfV0LO+EO5wcwe0Mn0GwO7VanYXWasFPxSIqSoG42?=
 =?us-ascii?Q?mqOH2zAEz40H8EkibcKTsirV3odpQb3H9iNPCO50HifYz+ZHLaJk0SpR0Bys?=
 =?us-ascii?Q?6Wkv7gBf0fp9D9w1LG6Fbusj9wVuV4VPI5juvprzQsW+sl//EG0PpZQADB2F?=
 =?us-ascii?Q?o7AHiNRfelVzRZMR8UXLo9/xZ+1vgZLln/WKU8/qe8oqedlOGk4v4CUOw4iq?=
 =?us-ascii?Q?jznTATpYAgz5O/RsUVA5tS5pXP8IjQE618zAVifU0TMOz5F9FkLS28SLwuBY?=
 =?us-ascii?Q?byzA28MtOdBlwELMNyW/Ov+9K8CrAaWjY4WQlxgO0RhHOY7a+l5k5kGGzjni?=
 =?us-ascii?Q?pGHCBceqfgr3FIxUIiJ0Eiyt+IA3I4FR66E8Sn3Q8/GztuyNREDFQzCJ5km6?=
 =?us-ascii?Q?keC8Z4lB69mS3AQNVNjbbC3KVy0eNIPMTBoI47dvYDo9yiH7nX+pWK9k8r3o?=
 =?us-ascii?Q?dxMmbSZEkbZ1RyvTEo24BJEG2ursKz3S1n4rxqaHk0mZGNPJsiWCmhN8k1LJ?=
 =?us-ascii?Q?hLXyvW6rhrSfwS330GUoxwxhKCmPrYt/h28zl0jHqC0obOu+SNx4tK5LDz1x?=
 =?us-ascii?Q?wqAKvsZ3Y3SEo/oHqKxaTzjKXdGK/G2WWjgTdEhFnDvbzE64Zn1uIf2Cej2C?=
 =?us-ascii?Q?SosbGDtmO895ngQw5+MHDnQxC9e2cJbNeAEcv0VPf1zMxPCpWHyy284Shhh9?=
 =?us-ascii?Q?BaY/EK6mNwUo78SedlNOyf6+utdk7/hvdZ7yCHhk6Kajm/cLhFshqKICh4z8?=
 =?us-ascii?Q?MEWfhd7dWKRJmXS4h4RKbwmRHbhKcpFIbwcqLFOzhbTGxQpb2uUqWeB3uR7s?=
 =?us-ascii?Q?w71toUnnefe+M/0EkwGjw2Jc5wtg8nMdnJ9+YdURJQUzOEkWuHsLuDedALkY?=
 =?us-ascii?Q?GIqqXexIAvB1L7Ec2RdvHh6Fa1A765TIiQPR5oYcSm8Dc+Xrv3B+5GAHZM1i?=
 =?us-ascii?Q?LQwA5hQrAKDCPIw8cvtQKlNFEaaq/VM4Jd6LgYBDgGY2bxLvwvaygVrMte7B?=
 =?us-ascii?Q?9Omtt1Wz4cb+gScQHIBZIKOt0ydnkPCZR7f3V4Z1GHxWFZKMpQn13fvpAofe?=
 =?us-ascii?Q?AdkNqTtE79zfaeZIB623V/wkGz0vHIydwKgYcsSCuWENZXj6Pqbe9BppQ9yx?=
 =?us-ascii?Q?fThTEXCGGIDFrZHMSX/NGPQ5Ps8XXeJIvrmOJ8vq1WHxf8/wcReQIlLofK75?=
 =?us-ascii?Q?FJLxLW7KgBr8zzMexdmqVsoy7FIYX7uHNv84?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SIAP153MB1317.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jJuT3my67Dlwd+RtBmQtLXplOp6UvhHgILTn/elaBKcXg7laG31GUJvKqxjo?=
 =?us-ascii?Q?DRLfP6f6ZRvewu+rxZsDBJWnVWO9V+u3xH0hOpx4pqU6ZwJyRU1V9Gcjc/L7?=
 =?us-ascii?Q?Q3fCIwIRm4odqFAq3QHeqMR4h99bf0x+tAFZ72eNFEMgPrSNyTNyaQQsFZ9n?=
 =?us-ascii?Q?VhKcdZLHfS/NEVS/z/1AOYt956SFUIsONeB4NC6E3aAwoxMwuSj6P4qTtU3h?=
 =?us-ascii?Q?2pFBubLEmTK3sNmgwR5qkOpYPWGBJ0fGoy9gXgQGjmhQnvDa00vpB1q6QB7S?=
 =?us-ascii?Q?xl276dtaohxhy9TNyDpjuwp3ICNwzVvv/JIuSdoxL3d79Y9LFT8x01mOD8GO?=
 =?us-ascii?Q?ZKuCEr7gSW7+K4HuF7XmbSgfDKCXCe1Q8T2LciPiCya+Bv0fmk4XSJY1PJ1Q?=
 =?us-ascii?Q?7cEh88D/XZu9pN0it8IIPu84Yzh6aL9oy6DB3uEZP9Nhzt47r01Yxq9QytMk?=
 =?us-ascii?Q?p9mbFJih0vcFPHJ2seIDPQdkuD931NMemetw0c8/ueH1z8Fz2gmo+Mj7vkCY?=
 =?us-ascii?Q?Wlbcbjoqndxq+fbOInZj4+gUeX5HPhcYPqE9wL1b33NICkuvJUuBuC9LiByS?=
 =?us-ascii?Q?Z8KBgUwYVoHSC5npn5ZfstAK9Qn44YQ7L2Ky9s0IRhTL8ZQ2dqM4ICHggdIm?=
 =?us-ascii?Q?Tvlkh3Y2JjV8Jk59YQBBth9YoLiz9vt5sVzumwpwa811ylACySYR78w7cwaC?=
 =?us-ascii?Q?xwC7GLYGwk3Tc62e0xIJV5AjAnntZRY8CKX2P0P1S9Ol0qHkzS92fsslqIH6?=
 =?us-ascii?Q?GY8dnLbdNIb1Dn9bUC7z61ajxbdBhic61lPyTQLIJHCGr45cYzbsQpTmxSbb?=
 =?us-ascii?Q?0DIrMG2lZL6Bxo9mah+pnu155cwMFRv+1dLL/mLrNO8JhyzEAK8e21gcOEmO?=
 =?us-ascii?Q?rNae7b24OAx1Rjv6MAL0WUL9gnFdv3Ljjphv5OWbixr9JmBHL6oEZGAnO0+S?=
 =?us-ascii?Q?hbS3jH0Mkm7Wbj8OxWISgwE8g7qKBEeMO2B099mR7FwIKZyz34C43BJBNemT?=
 =?us-ascii?Q?Cu5DPosKRO4abBDM956fV2u9DpkOd1GHkRVQ14IdLvXbaNm2WThPBs8/7rfv?=
 =?us-ascii?Q?MocA5oPMGoe8rgnMOi6CL0OhFbc7/+VCDKUyzzMDYzEDBnoZx0wO42zHclKO?=
 =?us-ascii?Q?MTVZx8E0tDY1XArKDL7tb3jVa6jcYRIxZ9QSXH79BFpgFSP64RG0KIbFtbgw?=
 =?us-ascii?Q?HEadG41p59O9OsYgfigQ1q651auCMqUzmSADxBMwqcgvsY23PK1PXf8lt1kn?=
 =?us-ascii?Q?dio1g0C+n6BjdaBU3Pt3BPOW14MGE1OapTl58Xuaq9Fi4kI7MtWLv1YExzpN?=
 =?us-ascii?Q?DU7Ki9v/zcqzx8u9GvLfoJMbFupiEnIq5CzHKDCIsJHEf2jShZRCmYjf8hsG?=
 =?us-ascii?Q?H8W04y+Y+mw0pY74Q6VofpxDxVh9wfeFIH4JX9FSu9ux4IStpFwHQM29tl6O?=
 =?us-ascii?Q?MEduORtxzUIgeA/7p5EDyVrGJr1MCbanjE620xeUJn5GffkNDCF76jFP4Br+?=
 =?us-ascii?Q?ZuVj8GqBansYD/ZMZrPNGCQeHGIeDtqxjyY9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SIAP153MB1317.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dc808b-878d-46c6-8660-08de0cdd752d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 17:57:22.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWJo1R9sVGbgULcztVtAhZOoiqDUHPBgHJ0w0Ek6+BhF87bgkX3mptA9qUbkOh/19JEKFgy1t3JZcUXYuEN3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB1226



From: ABHIJIT DEODHAR=20
Sent: 16 October 2025 23:21
To: 'bpf@vger.kernel.org' <bpf@vger.kernel.org>; 'linux-mm@vger.kernel.org'=
 <linux-mm@vger.kernel.org>
Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'alexei.=
starovoitov@gmail.com' <alexei.starovoitov@gmail.com>; 'daniel@iogearbox.ne=
t' <daniel@iogearbox.net>; Alban Crequy <albancrequy@microsoft.com>
Subject: eBPF: Reading page contents from a struct page*

Hi,=20

I am writing an eBPF program that attaches a kprobe at submit_bio. In this =
context, I have access to a struct page * and I need to read the page's con=
tents to copy the page data into an ebpf map.=20
I am planning to use bpf_probe_read_kernel for this purpose. The problem is=
 that bpf_probe_read_kernel() requires a virtual address, which the struct =
page * itself does not provide.=20

I've investigated how the kernel solves this internally with functions like=
 kmap_local_page() which internally calls page_address(). On x86-64, this u=
ltimately relies on architecture-specific macros like:=20

#define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))=20

I have a couple of questions:=20

- What is the current best practice to access page data in eBPF? Is it allo=
wed from eBPF? If not - what are the reasons for not allowing it?
- Would a new helper function, perhaps like bpf_kmap_local_page(), be consi=
dered a useful addition to eBPF? This could return a temporary, safe virtua=
l address for a page's contents.=20

Any guidance would be greatly appreciated.=20

Thanks
Abhijit

