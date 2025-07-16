Return-Path: <bpf+bounces-63414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21294B06E0A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 08:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D473ABEFF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C72877CD;
	Wed, 16 Jul 2025 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iZRfo2g+"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B2A41;
	Wed, 16 Jul 2025 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647702; cv=fail; b=VSJoDfx7BmDfqECJbyr+h4gHuLsY8LeAuocym749QXTYSg1DN7AYrR/wNzwsFvhD6bjV1RY23KtzRWWQV6F1FRRvhPI3YqDblv+RstG1Y4s/P2h9+QtDrgGxwfjhyXCJW4EEMd2Nz8Gy6EA6UDIFgYIIJ6gXtakhX8t4leLYfx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647702; c=relaxed/simple;
	bh=FKxPyaMecKnHaso7Q42xgHAGWfpMSgeOUIqinR1RcAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUdz15+VmMn/Y6AdY8iraVMw8AflSWKWQuZY1w+5YdJsFsudsV0vyMjflBnBsQHxT35NM8w2UIT9UpoHDQ4c5+U+bNNqeL6SAK9pT0uiDSoHmGj1vrq4QF92qS/a0vEzrEwPTxixLdVP75nEgFfPQF8GbunHHyCD8ZCSupiUiRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iZRfo2g+; arc=fail smtp.client-ip=40.107.117.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCjgy9TQ8pmvs2ZntIWY1GDDZVYF3CfDjJBszwhb4Q68SWRD9O59iNM1ENiVVRL3NP5dUnnThcsl1IyeAhZ8H+ELq01H33lToEOLB7xxrf90DDg0k39cUJxuzsBVDGp6gev+r1D/PcCpimMHLn/gWHp/ghoYrKhl/+SiQ7WkU9tJg9n6XLqPNQKsrA49rxhAcgqwCqdktpl9XOtW+0TZ6S/y20o5oKIByduNmy+UXoSRcBP1Fq8dSb8kAP+TyiI5xSOAym7Wc2DM9qefSqdm5cY8IWJWbwSA8WH28HLfuL0sofo4jRCoyviiVhv+RQ3KbDmHgE4jHqUfz8kEHWLm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKxPyaMecKnHaso7Q42xgHAGWfpMSgeOUIqinR1RcAw=;
 b=Bz/rakIgAVFYBI8hOohmaDurAH5i7zab+xEplB5rk6pDGnTrkSzj2cbuTREtNHJ/3dMu8DYquWFnjnrnDgirkS4Gee0LprdHmfJW0o1oEHFi1SyYOz6c1BsYBjd1YCK9I+n5C88E1SjpBlmJUQWfmYNciUcgzeUS4G7gKaADZnHy9ei58aHOuVPamcOjWcyuJah/levxNMk00iu7/pI4KloDR3/85H6UMqzQemz9nxOrHWcPgizpL6wdFCkNJLkqR1Abs879eWW7r9kXhursGK+xkZ0uzuVUjm5W95Oxt/t1z9SsDbD4z+sZVBoJco+LHiT9QYt3yYBMs+3Hv4JnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKxPyaMecKnHaso7Q42xgHAGWfpMSgeOUIqinR1RcAw=;
 b=iZRfo2g+EIh7JEwBs9AQ3M/I8NbeIk0pnwN5LeuRooRgkKvDczonQ+9W0PGem8A5O6W+qvs2KqGIho6tPAqF10ODlMDzbqjIMNYBdAxsIs7FvjLnWu3Tt6Aul7Q4HjJdeh5/pdIz2t2ebUKEe1CYiDPyaDQl1HmHjmBdpiu+xAY=
Received: from KUZP153MB1371.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::10)
 by KUXP153MB1138.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.17; Wed, 16 Jul
 2025 06:34:57 +0000
Received: from KUZP153MB1371.APCP153.PROD.OUTLOOK.COM
 ([fe80::f5f2:4771:bbbb:7e74]) by KUZP153MB1371.APCP153.PROD.OUTLOOK.COM
 ([fe80::f5f2:4771:bbbb:7e74%6]) with mapi id 15.20.8943.012; Wed, 16 Jul 2025
 06:34:57 +0000
From: Vijay Nag <nagvijay@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Subject: [RFC PATCH 0/1] bpf: Add helper to mark xdp_buff->data as
 PTR_TO_PACKET for tracing
Thread-Topic: Subject: [RFC PATCH 0/1] bpf: Add helper to mark xdp_buff->data
 as PTR_TO_PACKET for tracing
Thread-Index: Adv2GTpt5kBvl6oVROeWwhNLCVv6NwAAoOiA
Date: Wed, 16 Jul 2025 06:34:56 +0000
Message-ID:
 <KUZP153MB137161E2B4EC720F933B7F95C456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
References:
 <KUZP153MB1371D7C7160643B3FC965E6CC456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
In-Reply-To:
 <KUZP153MB1371D7C7160643B3FC965E6CC456A@KUZP153MB1371.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8460618-f4d5-46e7-a533-7cda0b0df4fc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-16T06:16:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1371:EE_|KUXP153MB1138:EE_
x-ms-office365-filtering-correlation-id: 9da9d249-da7b-4c27-3df6-08ddc432e199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qnOd4sXu3LFU6e4NHMbpBGc9sV3mlfGKgFqDGJR0ltcEERaienKEZjTRwL?=
 =?iso-8859-1?Q?kL8Y/5L3psn7akw6E+K+IyEbAMINgixppk6hNmjS5iwAXr51oQzPsdnM8W?=
 =?iso-8859-1?Q?/rtsUIDrB9QXCB4U1U7VBmyZ9Z2UJt0Qoe5QWGasDntOvb6abVcs8N623q?=
 =?iso-8859-1?Q?UvGM/R6XM0a+sYpIvlGVP/CWCf9CwwuLpUe4JCWT9QyKayIvzID1Gyq93x?=
 =?iso-8859-1?Q?85Oq5r7pv8yFZSM35/X21i/80V1XNMwQWrdTIHxiDhefVtOxj8QnsbIgjS?=
 =?iso-8859-1?Q?jjZusRh6OCKAQ3ByhwbvLYjtOFwAybiq1M+dsC8yebSi/0UohVqBx4NISp?=
 =?iso-8859-1?Q?7hRbZlpTpGQ1LnW/B7Y3NbJnXzsG8+jc2DY45QRq6E/bRnJARQoLL80esc?=
 =?iso-8859-1?Q?jLObSGvLJY2RJOj7MaHwJf2aKpJLOdbk0aPN/TKed66ZscII0B/95udr5p?=
 =?iso-8859-1?Q?E1dowCTJ1v8Wu19Paj6NWyISx/hekriYTAgSkdVV+rEXgjDJ/k2zFsoWft?=
 =?iso-8859-1?Q?KyCq17VktkVwsxe/NZVYnoxs0dDypr5GkF4Ot/dxLtM/K533JrQmLnjrZi?=
 =?iso-8859-1?Q?OL5zW9Dzb5WsWj0K6fQwTqYA0i+9qdnLW5Be/4YD9g1A06W8UkPBGHJldg?=
 =?iso-8859-1?Q?V5DDgSzAOpC6JQQ/i1v/u4T2Pz5U0bllQynGeATo4+7vf7D1/7c2Xa5d6H?=
 =?iso-8859-1?Q?ZUnBgkXx7ssJ/u5yYaVrmNJ9w0D9tf3GnLN6sOt70PdedGLumA5NUvZG4n?=
 =?iso-8859-1?Q?JersFk8g89bkzG/0Yjy2Eb889pUZk/Lesgevee96YEMnXUjsEe81wcltMf?=
 =?iso-8859-1?Q?6/KyHpEzkRUfH/P7OjMk6hTjUQHXH1I37itVK4v9zbB5SgnF9MLQWuaaMf?=
 =?iso-8859-1?Q?fFKZyQkgqJ1z4YvVNvN3Pe7c+N2677DkqC2JZW6SdGJheVDc3Q0/o9Zkzn?=
 =?iso-8859-1?Q?bW0oIJ8dpGgCuR3+jta1k9xPQd6eMc+bF6jl4gaMb4os02ezV+fr8Z2riw?=
 =?iso-8859-1?Q?TW9KBYY/8NmIpwRlVcB1p1VWvi+BQmLOGNQKW8lMkBiSDhMeMyddKQjhxz?=
 =?iso-8859-1?Q?ixbaYXu8gXOvU/SXooCOWjBmowlbqil6LB5b9Taui1F/AYB3vCC6M+0/Rd?=
 =?iso-8859-1?Q?cp2pGfF9LmGy3EUsr+BYfJlNGJ0maKsQOxZrqoclT3BB0Xp7YJs0GIMBow?=
 =?iso-8859-1?Q?FZomfzVd9zw3kGAl6ykyqT3mm0Vl+gRA5nx2kmvfWuFsSTobpeJiwvs3SE?=
 =?iso-8859-1?Q?m870WlqrB+osF4dPap7UmHydbFAsqM/u85IBVVXhtdsrdkEurbfcnRbyRF?=
 =?iso-8859-1?Q?ug+shKyqhfFP+zWhZ6GIS6Y+FrRMfXO7FmH5DS3X+45hdAdam+pIX4q4pc?=
 =?iso-8859-1?Q?l1xGQArB3bpr0+03vSeb8pXnFcdanzVWtB2KMMgi4SpJ/z8XoBpuCP26iD?=
 =?iso-8859-1?Q?O9L66gUUFlA2zmiaB1FB7MDxuo7fHCewmqK8HEBLO/7TSp5IFArZiBr4oi?=
 =?iso-8859-1?Q?5RZtczux2wDq+dUUsA6p+S8Yim80hVNDFcOQr5SJk/Vw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1371.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vZTavP6PvY5gbOitWRCgnDjR/1UTzCHVO5TuLbvmRYb5kJlDQQGVrzSs+H?=
 =?iso-8859-1?Q?t8gOViMxPhpMvsNwQ8nkdgEOJHOmCKAQw+J+9faIvYJdsFjq/jWEJk6XVi?=
 =?iso-8859-1?Q?OdHO8LMbNgHRpK7WC6B1nEN0+Ha2YSDwmUqxUExeeJEPRrHj92zkkTCv1q?=
 =?iso-8859-1?Q?YTFRiYzMCKz0f/jFcskftDxwW8zmFFkwz5TeZY1AeMvDfJb7T0RXCp8d9+?=
 =?iso-8859-1?Q?WQ/xlEMfVqZqIfiFeQeJGQDkKU8fdb82aYCsz3aBxBsKbvhn360zuOuVZK?=
 =?iso-8859-1?Q?zBO/+DhDYGzVy6vFbm/2conPutCjK1KkoifywWRQMxDtJj02A3JRexEdW5?=
 =?iso-8859-1?Q?3dtke5EbUrKdvDHWVen+aFgWn1MZTFddyauEv1aPSReg6O3iIYxa+UUNJ2?=
 =?iso-8859-1?Q?wgPBIPerSIqNBTrWl7p3W2ymkTEZ27jXhvoGq2HEDe4H3X0cT0IRESUB4l?=
 =?iso-8859-1?Q?y28DtxXVqXceNdRRPJAW+5cuSm1oFe3yBJRbr38FzpD5hpYfEVvArIGL63?=
 =?iso-8859-1?Q?8u+EjbOQXn1fAR/3T7sIyID3hlwpYr+2kN3RFOu7VkPYuZANWOe0KcZnDJ?=
 =?iso-8859-1?Q?nzVWCQMDcFWB87m1f4pRN/Vm8h3+wxFg/ikW46NKhruQhFPoQ2UWgqZIde?=
 =?iso-8859-1?Q?CPTLyYTBS2O+2x+DrDAZsTqg47O79OP94ZptOPb+jXTFFR8a5CLAph4gmQ?=
 =?iso-8859-1?Q?8vlpIlYBh97rOWA/Sb26ylGdF6yrNj5mXGXSJ6BEjOUT4ujnWGV3RZX7ss?=
 =?iso-8859-1?Q?/XUSGhg+NSnl8vivtVHrQ7KSKaN7qDW2VN0Qx0gSDr6gLbtFGAVBosujee?=
 =?iso-8859-1?Q?6rOGHXDOc4kO8UEQYJEHWbK/hhs+PsWHdZrxiMAh99m1s088tIWPlfUqZH?=
 =?iso-8859-1?Q?x8A5Je0t2BiwwHF++ZTXf1RCBt+jJcU5OdUPQ/xOw8q/XNXc0f79/xG/bp?=
 =?iso-8859-1?Q?TvkYAaFoKWTo8XA4DVvKgufI/pkM32E+tCogRywOFJuLa2ZxCfN6TWkWYU?=
 =?iso-8859-1?Q?2Y21awhv0Diyx/kav4JSZXRFzTp6AjIrxNhEUtFBqsXrzzYAtygTpA4xbA?=
 =?iso-8859-1?Q?T/j0V+LoJvRjr7YzkQ4J+FEAP2lwZa38bljz0bpMuoBS0kihaFhHb9X3Nw?=
 =?iso-8859-1?Q?pSljkAXHUDtDHM3pTvCIAjh1phmaCLYpHpGOlKGYGyEX4lFp7nvRT/m2r1?=
 =?iso-8859-1?Q?C453nJCWcSl6YMkem7NTe/sxa+b2kAVkMcez/GUpAaGEjWYkhREAOCRaXE?=
 =?iso-8859-1?Q?9rxSzvCNMEqrZ1EHLss2s8vTYarcgKTRuNMVT7ZpJBZsrpLIH6WXXqwPDK?=
 =?iso-8859-1?Q?jvnEEnQUsg6XZ/+akNtSvF0qNODkKICaP5nuquXTaUocc5QDHZ7iiU4Al1?=
 =?iso-8859-1?Q?lj7JGNC/2woQth0K8YMeAZeNx8fSZbtYs597NxXVTfsPewpN3R+Vc0JsaJ?=
 =?iso-8859-1?Q?cXLaeOQPnbMcM5iGNEkRFcDzLKO4fbi7C+OHlaUzRe5UtfMbm+FhwxbHNl?=
 =?iso-8859-1?Q?vE8KoF5+5PRXwO9aK0JSl7SIJ2Mh16KtotPW1b078rqn+N3LMmJ0PprmRW?=
 =?iso-8859-1?Q?0n5RAOT5PfkH2gVw3jy0l3RXU+pItKFYy3OuxRJ0NnZUqKnAKugfDa4a4Y?=
 =?iso-8859-1?Q?iGIPuRBaeTvxDTJA3wJ6vUFEdiHHb8/WSd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1371.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da9d249-da7b-4c27-3df6-08ddc432e199
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:34:56.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GU9TOM5J4haY+6q2KsGL9N39l7t0+eYD839EHCQ1WG70X+ofapOg+qauvsdc0TwtQZxOGFOXJuabplpY6/F0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB1138

Hi BPF maintainers,

This is an RFC to propose =A0new BPF helper that will enable tracing progra=
ms attached to XDP entry points, such as __xdp_dispatch, to safely parse pa=
cket headers using xdp_buff->data with native pointer semantics.

Currently, the verifier treats xdp_buff->data and xdp_buff->data_end as gen=
eric PTR_TO_MEM. Consequently, even with proper bounds checks, attempts to =
access header fields using pointer arithmetic (e.g., eth+1) fail verificati=
on. This forces users to revert to bpf_probe_read_kernel() even when the pa=
cket data is safely readable in memory.

## Motivation

There are several valid scenarios where tracing or instrumentation tools (e=
.g., xdpdump, latency profilers) need to inspect packet headers at XDP hook=
 points without writing or maintaining full XDP programs. These scenarios i=
nclude:

- Conditional flow capture based on IP/TCP header fields
- Per-packet metadata collection (e.g., timestamp, RSS queue, etc.)
- Passive flow observation from fentry to existing XDP functions

In these cases, users often write tracing programs that receive a struct xd=
p_buff * context and want to treat xdp->data as the start of the packet, si=
milar to how XDP programs can with xdp_md->data.

## Proposal

I propose introducing a new BPF helper:

void *bpf_pkt_ptr_from_xdp_buff(struct xdp_buff *xdp);

This helper would:

- Return xdp->data
- Mark the pointer as PTR_TO_PACKET in verifier metadata
- Allow safe pointer arithmetic and field access (e.g., eth+1, iph->saddr)
- Maintain strict bounds checking via xdp->data_end

This approach allows safe, verifier-friendly packet parsing logic in fentry=
/kprobe programs that work on struct xdp_buff *.

## Example Usage

SEC("fentry/__xdp_dispatch")
int BPF_PROG(trace_xdp_entry, struct xdp_buff *xdp)
{
=A0=A0=A0 void *data =3D bpf_pkt_ptr_from_xdp_buff(xdp);
=A0=A0=A0 void *data_end =3D xdp->data_end;
=A0=A0=A0 struct ethhdr *eth =3D data;
=A0=A0=A0 if ((void *)(eth + 1) > data_end)
=A0=A0=A0=A0=A0=A0=A0 return 0;
=A0=A0=A0 if (eth->h_proto =3D=3D bpf_htons(ETH_P_IP))
=A0=A0=A0=A0=A0=A0=A0 bpf_printk("Captured IPv4 packet\n");
=A0=A0=A0 return 0;
}

## Alternatives Considered

- Using bpf_probe_read_kernel() for each header:
=A0 - Works, but incurs copy overhead
=A0 - Prevents natural packet pointer-based idioms
=A0 - Not ideal for frequent filtered tracing

- Teaching the verifier to infer packet provenance on raw PTR_TO_MEM:
=A0 - Complex, error-prone, and hard to generalize

## Security Considerations

- The helper is read-only and does not modify xdp_buff or data
- The returned pointer would follow the same bounds logic as xdp_md->data
- Maintains safety via verifier checks against data_end
- Pattern is similar to existing helpers like bpf_xdp_load_bytes()

## Open Questions

- Would this helper be preferred over modifying verifier logic?
- Is this useful for skb- or tc_buff-based tracing too?
- Should there be constraints on program type or attachment points?

I am eagerly looking forward to your feedback. If the idea is acceptable, I=
 would be happy to submit a working implementation and documentation update=
.

Thanks,
Vijay Nag


