Return-Path: <bpf+bounces-66131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34912B2E8F7
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F51CC47A4
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C412E22A3;
	Wed, 20 Aug 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CbW5delE";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QQ1WAocO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5632DE702;
	Wed, 20 Aug 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733396; cv=fail; b=C+sgGCnuSvpmMhglYyYOB9huZeYDbxUMF4ujAGXrxBDAuIQO4ouy99rCRUjThg7xhtshOMBHQutgDzwT0lTyvu1gs9XM/qj4VAHD3aorgbEnOlhooeYwujahXp/E2EsppLPQeKcRsV05qffhQludoVFOQH7f0IRpfjWTIE50jMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733396; c=relaxed/simple;
	bh=l5oPbn577nu71DRgsAGOGKHPL0Bnskv8HnVA7Z63NFc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qri6kcPPi0wEpN77QpXqCAnhfG4biXVZI/sCPKAkSlne3sgJfV/JrI2HlvDfxQzAImOdIfWePw1HL93q5bvRstOFjrknAFDrOxM4792uamoUnXSWx75oUbV4JokzYKWnQsY8mxoxFW4QuzjU4GvxNP7G5kX5YL8r9W7pJ9a0zAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=CbW5delE; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=QQ1WAocO; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57KI9GK51866936;
	Wed, 20 Aug 2025 16:43:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=l5oPbn577nu71
	DRgsAGOGKHPL0Bnskv8HnVA7Z63NFc=; b=CbW5delEXtQKFnO7LlnFcXFNa0CFo
	effU/Gn8UuQ3UK3IIXMwmkXuhW1QbylyPOOlgUNqqn3wzX3fLTjF2TvXrHDMOycv
	sY9wNiaMl8jvYLUnETCQ98MMWkzpAe28XizIVsQvWCvjSCd9XJ/+qqpyGPl60z/3
	XCRUP4n81uYwrkSbLEeL2BcDsoy3lQFdke3KIwQPRWAV9R6Y3/Aki8OB1K97XXjA
	f/NxKIWn6o8CFvOd7UrPvBXLRuckXZmf2sS2l3Qq+m1/9NIaYX93/1flEN05xMQc
	3pROJCQIc/QuESIu6GtERO6Pt3OJHT+SaV2rGHzZ/FyGcH/QtGwCgE4nQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye6ub5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 16:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgElHBgOkCjDGn6KEE7XbbObcOuveGF/GV7bj+mtXE6Pu+Mp3eKHN7RgoMPrVIIMR9pspEkfiX/qanqbCBShSXqBZfsDgSdyakNedaybVT82SrOGKzHmQRYQ9wUXcbAJah0rIV7EqarqLXCboTbMv+lhQA/zxijLNUJu71mxWi0VjtjItlZmK+ff4HG1VxaV+2T38cFqVKdHbFutswPWZE8n3i2lavNlS9Kn+6Tk8HTQJ/+BBEeqrzA7UoWUdmWackV9D3Gjh8gWJCGqiOMfqA/X5JspLGOZwvMfthhUElBwKAPKehkuWCpTTkJQ1/LPzHdrbjw5LECih14f66be5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5oPbn577nu71DRgsAGOGKHPL0Bnskv8HnVA7Z63NFc=;
 b=phafADNpxS28QkrXhcr4VChH14+v5lQ1kTJ8DmiCICVulo2FRzlgmVnXoY2xddCtcqTIOrN15GtEc/m0cXmd2j62UFCGEMlO3XWN1C/g7VyC/0K65VhiTyAKip5JzZ30IMVeeQP3XNKgCRyuAtpIEPpUORYni4HXyz4lpbJf3ja6TDEzzCGNapIvYWCgnpmRxcNyDesqCGv/42avk2f/3b/4sMBVgteAaZUC06llGC9LDdIH5f9kXRkuRg0dDrCb2/xCE8SPSf0O1O2T7v/bHuyogJtQeh1QV9eurlYlP0YotWBO2l3YHSd5NIOWVjy6e/aEC7o1k3GcRT92RtX4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5oPbn577nu71DRgsAGOGKHPL0Bnskv8HnVA7Z63NFc=;
 b=QQ1WAocOgK841ttWUWBPR5dDU1TN1l6k+/kTucLMFEeXKOQpd3PcRIbqtQyKblJEitXJMEcPUeEhcAFsuZjBxs0/eBeBh4edaUt2u/poej2PQRqOe4arAZutPPNcC2YunvY30kd3IhQFu+yuR0lguBokve/mBwJ8GpkzFQE5io/sui9n+EJhfw2JmuIqX8RueK/S4SU0nLkt2HpePqopaazuZ4kDeuUUXN5I5ODf30EGwOTjAuAcpa4UZWGvD1bwY6aMC0tMGslhygsD/YKtcJqn7U8Oi7oqu3zvzwBDLfzqRCqGPW/o7iZ2mwYwO11lxkX5beOMxP05SaZpqQi6Cg==
Received: from DM6PR02MB5275.namprd02.prod.outlook.com (2603:10b6:5:49::17) by
 CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 23:43:09 +0000
Received: from DM6PR02MB5275.namprd02.prod.outlook.com
 ([fe80::7daa:90db:aeb2:c284]) by DM6PR02MB5275.namprd02.prod.outlook.com
 ([fe80::7daa:90db:aeb2:c284%7]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 23:43:09 +0000
From: Vedhachala Shanmugam <vedhachala.shanmugam@nutanix.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Aditya Jaltade <aditya.jaltade@nutanix.com>,
        Glenn Chen
	<glenn.chen@nutanix.com>,
        Tejas Sangol <tejas.sangol@nutanix.com>,
        Arun
 Olappamanna Vasudevan <Arun.Vasudev@nutanix.com>
Subject: BPF - Inquiry on Handling Backpressure with sockhash and
 bpf_msg_redirect_hash
Thread-Topic: BPF - Inquiry on Handling Backpressure with sockhash and
 bpf_msg_redirect_hash
Thread-Index: AQHcEitXR25G6fXeq0+urtAFh6rf8w==
Date: Wed, 20 Aug 2025 23:43:09 +0000
Message-ID:
 <DM6PR02MB527577F56A616EED992C1F2E9433A@DM6PR02MB5275.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB5275:EE_|CH0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: 4f5c8ff1-f551-4496-4af3-08dde04351be
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?8VjHxbaF0h4RgzZ6HiCBjedHgwgepPTfTbxGJSfQl7OpY0JVXqvURyct?=
 =?Windows-1252?Q?h+9jCGOVNaRwE3T1mGMWzcjCiWBuQm7QsKkCF+FqhANS2/QdRdLsSK/b?=
 =?Windows-1252?Q?XyztsKvCIuTJdaQbMZi2IYXjy5ODVzr1sFQm7DJFC+L2+/TsO0WRbkUO?=
 =?Windows-1252?Q?jMJ577kuvzYJphIJvVf0tRd65LUYj/1iUli3JRLp57qV4pE4Z5y+goxB?=
 =?Windows-1252?Q?nwk04ldIYnJsp+ONwyGFCi1P72Jtxizb2/0WaWg3Ux3UGFW6e/hQdS++?=
 =?Windows-1252?Q?fx4+xb8FFkr3XvwVqd1ODacxCVu9NzzH2AL5xM+kGt2GPa2RmVNSXlK3?=
 =?Windows-1252?Q?UhQZ4zqgbeoYJHEFvCtqdOBlgrqqPWnLynMm6haa4b0H5fjl7RSYiFW9?=
 =?Windows-1252?Q?KFMSP1M/jV5j9OnUZXsHIYW5JaumsnHt0sXvoYwnRXi4SLqQ8jRxICUq?=
 =?Windows-1252?Q?dtNkbPvAjbMuuLl4UqPWP/BLmQcpcOG/4fWA1k/Ovar4oen3VolTGV3J?=
 =?Windows-1252?Q?qghkMdZh/5d7Hvu2Brn1adMhO4LuZldmJQ2632ePMDt5G2Q4C2PR0UDk?=
 =?Windows-1252?Q?JJkiE0jAmXFFCvlMjj+l9iaBvWpitoP5u+EWAcFGGzI5I4cVXXXOcms+?=
 =?Windows-1252?Q?LxtAHvhUlX5yiU15CAIIlIVrFcw2+tKlyrqcyzyEPbZBdgIipmVDDJIH?=
 =?Windows-1252?Q?bOoQSrXjq3ikYIV1CLnpZko2E4kGs2zrQ49Bm8qPqwomXbkthVo5Kst2?=
 =?Windows-1252?Q?fj/fs10B5sCta5KC2QRhuA+B5yP/W1q+kcWSveuSz6EuZoRql4L+vAXn?=
 =?Windows-1252?Q?jI6rF688IWYMUhjXXDF1vFaxVfkP29q97id7RFUCwKPQg3/ANPZNz+iQ?=
 =?Windows-1252?Q?Fbp7mu298mf9vh2ZKd1hjuwwnUWM3dCUjiN0V50jDrinXkP3DstyMjWr?=
 =?Windows-1252?Q?mpWfO5KX2abyHxnYYXFPRZ8WSXh4fknL54P/xnQAfplhRtmmKbdCCxMs?=
 =?Windows-1252?Q?UI4pPApxvh0ZcX20u2e0nEhH/tHCZMs5SqkgeyYawIcsL0yBLnnq7xZh?=
 =?Windows-1252?Q?efnGdvlDkpd1P1hNJClK2nyJZokISnnKIAlq6mGhgRky+3K23kiC3OVk?=
 =?Windows-1252?Q?pbbIHgjmtvPFELeatgOmrwgugwZ0Eskq20HnCWOq35/pf9P+a6RmmoAt?=
 =?Windows-1252?Q?JkW/UfG98JDaEmEpDdLDIAUqcF93AjgqH1NvDcvuUyDx3H5Z/QB1q7mT?=
 =?Windows-1252?Q?QpX45MSXEndGZcxQpk5cCIoH819gTyY4k7i1Y1XWSC8L/MBaaDH+QOd4?=
 =?Windows-1252?Q?d+TtZFbCx47Ym20wAfgcLtI8DWv4sRC6sxyAavSYPJGkoPd5A3fbkkuA?=
 =?Windows-1252?Q?BM/JkQsIwd169YbpFWNMyB0Rf16olm2QwXt9W7z+7TtRfMrkLsldmjqe?=
 =?Windows-1252?Q?9wqQ/YJyUsOl3WWUvX53hNfZ8uP2T4siSNmAdROCTiYUidcUZpFXp2eH?=
 =?Windows-1252?Q?MVwlT2G/jrBt1RPP4vP+4YHflKPzd0dvIHh5tjFAcHWUsjRJJfkKlY54?=
 =?Windows-1252?Q?99Qn8XBypfM6nstFU1NyChDJG+cqEYPol4lAO8wgdtC5OEhcKSczUxVf?=
 =?Windows-1252?Q?/zIPZ3tNFkL9WEFRPDf+j3ul?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5275.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?SptU/TOtIiq4JDw56xGNQwpFbsDVARXgTVOkPtsh1Cp6mCoHP3SeVkrg?=
 =?Windows-1252?Q?J2BFgPTd1PHztnyFYN70pPXnqeq9+uF6S0gVIABRu/YJ+/gaL0ihYYug?=
 =?Windows-1252?Q?yWV8wSVEYIl7UmsFv4qIYemqWCltl9JPNhTDrTaWKm7Y3VJpaJVd0YMZ?=
 =?Windows-1252?Q?BNtQ1OWPDr5czbgLlTtfRJCCa2y3G+dNVYQ9tEhZvQ/2aT55qCf9pMIf?=
 =?Windows-1252?Q?HRj9CPgQIsB+ZkLZGnxgx16kt8AUTvlzjQOB4xp03rvWutWgIXjll1lH?=
 =?Windows-1252?Q?hYy1V0aAhpg1T2ClJQZ9gwTBFZtWFH9a2i/zZYaXTjwxZGnc73LRk1uw?=
 =?Windows-1252?Q?BzCN+33eJzzexgHDqdKyoR0ggPlov1O1L1nWxGivIMM8Ah7cB2n3CwcB?=
 =?Windows-1252?Q?rxdoNxYAK0MIMWxZdyFk85nvctlIpCgSv3W7g8gpcX8SVDKrrfRM3qbc?=
 =?Windows-1252?Q?oYsNmxqgwkDc1UxzVcInUGOFicOGywN91/pvlcXNCc01HxQ1k45maxMm?=
 =?Windows-1252?Q?KNVHOqPlhNqEYEGyLyHawSc2X92X2P04DeAeZVSuPtxT/AdJ3fF6wI+G?=
 =?Windows-1252?Q?PZQsa2v1ev2uMjtM4rEhplsWTmrhzHAa9okkA9QasvppnOXWXRorvTOn?=
 =?Windows-1252?Q?1jeDbSfJY12ju8Ttfgt2q8aMRaiBqrPqym8pV7O4uM2gkKOMCB8eR9NK?=
 =?Windows-1252?Q?tXE3E4O1iykOsndUs9xb6kCN7EO8fCx5WzyxmZQQISLeL9IEJ9zXmZXv?=
 =?Windows-1252?Q?0yOBwwtqBNmyptEHACdfixndRcoqK0hSRnN0ViakrrmPQgIbeCzrjjs+?=
 =?Windows-1252?Q?V9E4OYtIm9Oe+Tnf7XEq9V0qsHNBhEiSrjGpAgDgjnvLl5ehlgYzTJ+W?=
 =?Windows-1252?Q?kcJ+gUZpAai+JZ6euPXEqh9nCTzfzUgMHhCsrlQNOK2fdQngeWLDUJxN?=
 =?Windows-1252?Q?UDGCJigJZE8usYTVpRN9yoQzr2VlHBr4IzOu48ebThte86c66dItA6xd?=
 =?Windows-1252?Q?IpZOO3Xj+ANWtkLwlIojx2uKzdKbcmoPDtggSqC1OPxcMjNp5i81iqcz?=
 =?Windows-1252?Q?gUiazdvFoREra+zySPhGibbsb+9DcWQrN5QRLYMDvhxS9poxHvFQ0b/N?=
 =?Windows-1252?Q?hlksRMG+JBcCJkfs8zZfqk3OQOEoCMoUSGKCWZgBICPHal4r3sTH7qxT?=
 =?Windows-1252?Q?9qjqxckGsgW2KZ7lj45AAvHPOQ0qDL3f3EHGnl1BPWaCyQtDDj/KMeeV?=
 =?Windows-1252?Q?CfG+Q0qxNpGpX9x0acBuJUvFCjfZ9IPSJfdbSDv7tLSkU3sK7DDxzu+c?=
 =?Windows-1252?Q?FNdGsO4G0CphjXTEM2ITF80F+dgYdonmT3VjjiFYcfHGLOlnyUJubBqA?=
 =?Windows-1252?Q?zSBJK9B5j2uwVEkFN2LOfluF8M9sRzKZifRcxM3VfD6rFO58MErXsGwu?=
 =?Windows-1252?Q?uq3OaUaTfewa1ptZTjbx2t7WFy4vRwIglsLo5cu34RFLZ5k7helI9QRS?=
 =?Windows-1252?Q?cZx81nJvCEpjBJYZDWkv2z5eD8xyafADZqpv6wFXA/uBI5LQlqIjozWU?=
 =?Windows-1252?Q?dZwd8u3Lj47UXnGrfvr6rRaKK6poQHg2N3dFLhdz4ZJL9qOiKvVAmyDq?=
 =?Windows-1252?Q?Wm+anXyIvAe0IGMGo8WRMfnrvVUf2XVag7qj5JRrwFa6M3ToTll9d+r1?=
 =?Windows-1252?Q?jNLJnSQsiN+E3Tj/TwHDe5KzxuIR44/2wAGv3+7SOS5zZG+bZf0V6g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5275.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c8ff1-f551-4496-4af3-08dde04351be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 23:43:09.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2kb1Yrq65Td6lBnMAMoVmLOmPU/VtdFtgkLngNtya2zXxtgO9Swytsutc3wMTvBqBb3hDGoFfXX6Gdy9bqX/eE+1SfgMkDqfWrjw9lk1BUIoWG+LaFIDH+1TT0BkWww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDIwNyBTYWx0ZWRfX1I7pT69rawzv
 q59sG2snDL95TXtpgHffiVceUThPGTW8y77vRfMQhEyrNCOt4/vH9p8t41RevDrhGAxDnI20P3q
 7hEHKSGIc0FtlVXZw+nDCXvGfFew3WqaZLy2ZhxG/oBJ9Z12UJG2zjVM7JoKpvVI+nZG6e+put5
 y89FqQppsQgh24B6fUzJ2zEk5LCUaLNq1FgitfN2jUX8Mse1UcLxjDFt61bl9dX4seELS1065w9
 0Z0PTi7QSMJFM9ErdZhc/mE2x68JWujXG2EHuTcBYVAdVsjJ8x+JwcRg1pj9iR7ze0YJ49S0NKk
 vV+WgE+IJW3Kh3a5/l12YfS4qbMOBOESYaLndR60JqhiOqVqfrAdUqQSKLd9C2hv6ixkheMNIqj
 zdsnA6tDSyDvgc5xpQi8DMejpoJZpA==
X-Proofpoint-GUID: lDN8aHwjPLtL3dLeEqWX-ZWttFZBLmcU
X-Proofpoint-ORIG-GUID: lDN8aHwjPLtL3dLeEqWX-ZWttFZBLmcU
X-Authority-Analysis: v=2.4 cv=dv2Cy1g4 c=1 sm=1 tr=0 ts=68a65d91 cx=c_pps
 a=pLrcdidqXQUtHPSGa6K+0g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=SLom-PTZkLuEY5y5LHoA:9
 a=pILNOxqGKmIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

Hi Maintainers,=0A=
=A0=0A=
I have a question regarding the use of sockhash for localhost socket redire=
ction, specifically when using bpf_msg_redirect_hash with the BPF_F_INGRESS=
 flag in the sk_msg program.=0A=
=A0=0A=
Since this redirection path bypasses the TCP stack, we=92ve observed that b=
ackpressure is not applied. Our servers are designed to pause reading from =
the socket under high load conditions. However, with this redirection mecha=
nism, the client-side socket remains writable, and sendmsg eventually fails=
 with an ENOMEM error.=0A=
=A0=0A=
To address this, we experimented with using probes to determine the unread =
msgs on ingress and once it exceeds a configured threshold, we fall back to=
 routing packets through the TCP stack within the sk_msg program, allowing =
TCP to apply backpressure.=0A=
=A0=0A=
We=92re reaching out to seek any insights or alternative approaches that mi=
ght help us handle this scenario more effectively. Looking forward to your =
thoughts.=0A=
=A0=0A=
Thanks,=0A=
Vedhachala Shanmugam,=0A=
Nutanix, INC.=0A=

