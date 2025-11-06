Return-Path: <bpf+bounces-73802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB8C3A516
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 11:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF3420732
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00902C11EA;
	Thu,  6 Nov 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j4UizR1i"
X-Original-To: bpf@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5C3208;
	Thu,  6 Nov 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425227; cv=fail; b=KqRyXJSBFngoXv+OA61vt++F8kZBJCSM2SmCuCahPdtAJSMTpgICCtu+HhMYFn1xJ2mATYl+ii2WUz9KBgtC7XWZwNtvRnFdUTJWu1Byqm2L48gvizHGqenbmPEGdDbiG6p4JZKtXGj6H7LfM94tKmBo5L4uABNi8xOQvSa+xCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425227; c=relaxed/simple;
	bh=pHQmeiRrUoLnSUd/iW6rILi9Q6VtNTsBPpLQRsiV+4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVGam1TaV0V3vufsQv/4Wn/V5nmprku3H5ae/YjnAAqGN0uezD1E6o7AZ/XxLoBx7D2csAnTNpwCQMFLV7GAnAEuRqAwbtqyzyOavBZphlkdoJdHP0F+SY0TxW9RgnaRMFV0+hp2i0NPSebSOkDIClvdpY28SdXIsUuB2RNz/ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=j4UizR1i; arc=fail smtp.client-ip=52.101.126.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6ulxPa6MjstIPC2FlDoQwFakUQcTAb3njbh6aQeKZD+VSJ5ny+cgtoEah1Tg9hqWCa3OIMd8t1nlKn3tE/SHfC8rTzvuyyJd3HqJQZVzya5cr2EnL/Orc8H6qdx+2BBFuGXU9PfM+1XFX2+LaNgbSdO94uo+DaNcP5Io1UlHgMz66WX2y/ACNltfwMkWcAQqXelfaiB9SpfTU8ZNItIg6nYrIo1f61BDCaj8fTsof2g56Yom/6BcAFwwcGdpFwHeYcFMMY6YNpnuy137URnxoxgMJ7KZt3E5XDiefYM07CvNuT/PN+92XDfDLBY6+1oE19CLWm0YEfmpaptAytcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHQmeiRrUoLnSUd/iW6rILi9Q6VtNTsBPpLQRsiV+4U=;
 b=GE6LJdcgbvqrs4U/znMkp30Vp656LyJxvjPrLywNqIkSyXgQRVPGUn7hfqDIcbbafdaga7Fhd+Fy0lBbKGurYz3Ngy7pJ2zT+cNY0JU7WAWBV5QOeegpEMmKBR0KUeOBL4/X07N2GleZrbnMJI3YTmp4SaA/HONepQ9JXgL7QLnSJm6feXEZ52t6dV5LYMfzMWyO/q99moFHN42tCUeyElzNvwIjgrFAIqdcXhVkkj2wt0Y2i/ub1aIvqApg200oHCAUPO35tJYc3V9FtM2EZ62jbQ4fQWCGe+yt8BCsAoTDOTo+P7wwEVlOk6ucQ/42qpp4R39qzoHXQXgb/1qejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHQmeiRrUoLnSUd/iW6rILi9Q6VtNTsBPpLQRsiV+4U=;
 b=j4UizR1ivU2YJ/D/hdkQYP0GGtn64vMZoQ20RnFvVHJPrXkJxdqXYT9vAZEJqhJ6/p195WsDmK6ToxqnQBvD1aq5YH8AgWLcZV8Ptm0LOtcB3CnJQXdAI9122ehod/fDz0dCmXggFxOZgPMB2cxQ4V4nxc17Akpw3ACexLvIFb4=
Received: from SIAP153MB1317.APCP153.PROD.OUTLOOK.COM (2603:1096:4:28c::19) by
 SI2P153MB0735.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.8; Thu, 6 Nov 2025 10:33:41 +0000
Received: from SIAP153MB1317.APCP153.PROD.OUTLOOK.COM
 ([fe80::233f:27e4:c65e:e751]) by SIAP153MB1317.APCP153.PROD.OUTLOOK.COM
 ([fe80::233f:27e4:c65e:e751%5]) with mapi id 15.20.9320.000; Thu, 6 Nov 2025
 10:33:41 +0000
From: ABHIJIT DEODHAR <adeodhar@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-mm@vger.kernel.org"
	<linux-mm@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Alban Crequy
	<albancrequy@microsoft.com>
Subject: RE: eBPF: Reading page contents from a struct page*
Thread-Topic: eBPF: Reading page contents from a struct page*
Thread-Index: Adw+pGylejxp5FwHSM+VyUupq9syGQAIc2WQBBCkdeA=
Date: Thu, 6 Nov 2025 10:33:41 +0000
Message-ID:
 <SIAP153MB1317964108E3DD30AF49A88CD1C2A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
References:
 <SIAP153MB1317241365710DEACB37179BD1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
 <SIAP153MB13179A10B5ED98547C7B86F1D1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <SIAP153MB13179A10B5ED98547C7B86F1D1E9A@SIAP153MB1317.APCP153.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: SIAP153MB1317:EE_|SI2P153MB0735:EE_
x-ms-office365-filtering-correlation-id: a6754c24-29da-46ac-32df-08de1d1ff46f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AJ1qThclW2abT5p5NGojN+ydcfIsiOoHHY7nnmwyHSgC+75YnEloWo1CaULg?=
 =?us-ascii?Q?OUG3gFV1sOBhNRufi7UqeiMCpFSnw5EciwXIX4RCSdqQlWz4slTsSV57JPkW?=
 =?us-ascii?Q?6uz4HWwJpaMbiV4EpTCiKemRplYaMU8bE58gf/NRsn/fF48gAJQnH1YQdYm4?=
 =?us-ascii?Q?4MYO6Ea3seyhmcPOaDghkqsaigK0t9xdjRSi+2ojm+6/NgvF/gPmjxWK1nhk?=
 =?us-ascii?Q?M+XCYj6sIml+4hj656Qlv7hJ1pzFxzWrdJzfXrwj7UwyltiekfROl6JaKJBh?=
 =?us-ascii?Q?e5/0ulKeDEDsslIG0xW/R2bX+Jxtg8nvblJzXej2lGA9e2QDqT4u6DkNccde?=
 =?us-ascii?Q?7U8gw9wFDYb1cHwGKDn4HfPqqS659i8Jw/IGFsTH4k2/DMKi97ibtEBJTR8X?=
 =?us-ascii?Q?tVfEa5RWWb1tlWyvYteT39BKKiSawpOYDpG3Pf0aXMkY6vOUhE4FnNhQoHQD?=
 =?us-ascii?Q?xVgIlBCUJlH5hCF4FddaSXgNPCYd6HcQUnLoTlNadBQ2/O4OkSLbM/BXINkR?=
 =?us-ascii?Q?V0HDR88gz7nUkfU5AR+xz2J0WtsoXNMNtNcfUtxMq2+Wc0oE1GswAnnsycu9?=
 =?us-ascii?Q?ZME2iozoG5RaxEgOZanKm0meGUj6861AudCelFZWPd53j/dhaxvhyLrcHQ81?=
 =?us-ascii?Q?9I1A/rJGjt0dN4Rh9b2x2kj6IJr8CuP//OdH7ZOee3q2yAAvu2ENCSeyUxbL?=
 =?us-ascii?Q?DwcayH0fOEhN8iowgGDaXTWaFZ9CeRv2WbcSwtWVeliguahEEctuJPSwjULk?=
 =?us-ascii?Q?VDDvHNn1jbdVJKlKSUZmJXycC1oBWdIu0u5ls3xN/HQvuzZCSmQElD/izxxu?=
 =?us-ascii?Q?9wA+3JT3/ySqzFzLisUnYTCv8bwAmwnbX5pJqDSY6pX8orW85K9FJf89d0yF?=
 =?us-ascii?Q?VSB5IiYGBmQERV4v7KquJBoAEP5b30I816epLGwRMa4v7aiIveUSM3fEtFXc?=
 =?us-ascii?Q?+REE0pqfX6IvafUG70vs6AXaEPuYE2trfAM6ES4RR8VnT4FYTgSlLYxRKJNL?=
 =?us-ascii?Q?h3R/IgWWwyqBuLpbBk2OY8ovCoMA+rB8eUfsoAxfh27N/IY5tUGs3KEDMEys?=
 =?us-ascii?Q?tEvsJx0DmvTtMMEY69vT6gcuEqIq1uz7NC86wo9ksGFF5+f909G4Tr+n6Giz?=
 =?us-ascii?Q?qEdyPa6YYxKqDH2oPipa5XKr4aw7dW5UnGSKP6EbfNiLzPa03+FGNXGBQ8df?=
 =?us-ascii?Q?cpbaGlhA6U9lMf+wULzg+0+WxRhKg7mSH64xjzZhp/SrsWCP/nXmGZZ708ta?=
 =?us-ascii?Q?InbZbH5AwXZVUv6k5y3QmKe9eGzlJb++3xisQhdf7p0S2/t9Piplic3BR3I4?=
 =?us-ascii?Q?sb1cn1cO4PqAEynSC5TqgaIi2PaJOsFvfwY+iGf2R0wmB9CtB69KE8R56qGt?=
 =?us-ascii?Q?DTM04y2C8g2mKWujqhTt6UbtPUiBz+dNfGhy/xH2EDXGaCeqNdkLRx5euefc?=
 =?us-ascii?Q?2MS7bVrtYvkm7VStglgxce/jIrfSBTEH7PNmYv0b5z0zp7czPEI4oI1LO6c0?=
 =?us-ascii?Q?bCS7zStJJSFfiMhNfdbe4rmfNoL+alzF0eHt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SIAP153MB1317.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nYJJmFR+s3oiFFgIE+EVaFNfDIC1vtNZE3ZMsHHBeScz7tigC3L2QY0l4LvF?=
 =?us-ascii?Q?8QG+0b3g5PagZHlbz/WVzmV0Qub1/EkQnQ1PCFBGKzxtbKxNTu5OBl83tmLX?=
 =?us-ascii?Q?Lcl2kaU7vAsDBEU47LA2ClAShfzhArm4HErwxuTSis/DuhPfwo9eBZURtN4H?=
 =?us-ascii?Q?9K+UpgXvJOmPplqqvY/0asCYqmLNUqlkk8gZuPjvkHGNO01IQjIv3RbRWfsS?=
 =?us-ascii?Q?/Q8FwzMEs5Qzxablo9/kpzibDLQMK2eSI/JIkpke39f07A4+fHa+9VcEBJsA?=
 =?us-ascii?Q?89p/QosnQ2arsAfwpbb0HfqQl7edfKWwJOevh67TTqgKhAT+eRHzqr8tEqt8?=
 =?us-ascii?Q?KsPvKuc/k+uyR4gsKS2HhTNOiNKF4kNh1vYBaIlp5dGt3x8+vlPOYk3+YEw5?=
 =?us-ascii?Q?IHh2siUc29n3dOpTYq0mdBb0yyfTZ+5CdL1G/1EhMTQmLSbNCKtYT5lXL0Up?=
 =?us-ascii?Q?mX7cfsunZenoqnOR68p5mEqtLb1+SLep3om0fIygng9EGpL/jracgsGAfrd6?=
 =?us-ascii?Q?y5KmkayYTPEPSFW4Rm957APsfe5AWxdJaH1rbe2NOPHeR4l8j4rOY0Lcbuta?=
 =?us-ascii?Q?syMONGlc+Y5YU8Eh7G9aIkFSTd2oIZLOaKCl5k1nibD52YOs0/dB3STUPZj5?=
 =?us-ascii?Q?zmdg8nssH19dSqSCU90nw3IYKcgxv4ptRJZPSon04EnWbHj1ZDV9fILveJgp?=
 =?us-ascii?Q?S9DcgucDT9CMv7h5VLCt9bNfMx3784gxtuPWwwg7N0E4l3fUDmXN7o8eT6+a?=
 =?us-ascii?Q?tKT4kxmnrVOPLJxnf9B9ivzIiSUisGcHLL4ZsxCbrJULYWeTXGPIaLgnRlUY?=
 =?us-ascii?Q?A4zfZUBbjz5Fwg/cdx7gmrHhaazV6NteP1ES15yuYnovHRP2C8Z+n8YOrNMj?=
 =?us-ascii?Q?8reV55OmzeM4I2kdHbfDE5E+bF1lxL4p1dUKrWnAYLQawtd8lLv8sJyNX3r2?=
 =?us-ascii?Q?2CMnDoeae4lUsZeRhFtBTblKAoFN3qUzcBjEU/s4UoFPAy6pm2JEp5pZXRKU?=
 =?us-ascii?Q?7q0lLjlYGZouByyl8nN+abp+0YHN76YbGYdilot5jJcvL0tdNdwD/wdwzXkr?=
 =?us-ascii?Q?AhceHyJAApr8vLLQhFeHjElSjLIwurvfSeVU0rRMltrQIGo7KgUqcwIXCqMe?=
 =?us-ascii?Q?b2rozi0asGdMSBykwyg2JGOrb7F6K0BhxTgkM1ZSgeZqcyGUcI5E3Ak9RVaJ?=
 =?us-ascii?Q?Hp3A11G8IzCsZnybHWI5X5aa7QnePDz+g2cAiLs8IqbjfY68+ztBkwG5+m36?=
 =?us-ascii?Q?E4KTcFHjrf3RXl6oaqXLKHacJ/5B8q10ts6Nx+lqf8vT2F3Ynuqt51rMZEgT?=
 =?us-ascii?Q?HEaiAcg6cC4wArfCgM5b/pBv22oITOz4lYIdA1pJb7Ckbkn23zF4sr7K/KSp?=
 =?us-ascii?Q?fpMZhYBsdK302NQnRpN3b2PV3xWRNGPFMFNsA2Kg2Vhn2BZ/nZydJd3gkHTf?=
 =?us-ascii?Q?V+QexHC2KWvi1oJT0SGjuB5ppxychQlkmpL2zK7CyhccxBLwaY75+obJjPqr?=
 =?us-ascii?Q?fuPqkawmun2xMhqGSjju0t2n5l5D1T6hMl8a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6754c24-29da-46ac-32df-08de1d1ff46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:33:41.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eThOryOYjwfpMfXCiK57wI3BJwUlQnYargQcE0gM7acw1rRIQNep4HiRDMLUg1+HgAppdfIoj1CROjK52Y0UwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0735

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

