Return-Path: <bpf+bounces-68378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B7B57279
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948EC17E3D6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446E2EAB9D;
	Mon, 15 Sep 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5BacCsF"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F002E5B12
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923384; cv=fail; b=CEVnYlc8f8VDvZWZJFWwbO0p2+2b4pRNVmp4w8NZXc9Mip+18X/qVY0/3L8Ivpsm24wJG+h05dgVbjYYxz1rT3hNDg0C6jRyQcTMVH81cMQLkqUEZ4+Y7msvYBPCUCKefXkW7oiog7pgq9hes6OVWCTd0wPdyu3/FwwMnwSOqxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923384; c=relaxed/simple;
	bh=yCMKCCTdwWLWB25lfU6ljtCgnDVM6FNP6g5mEf9FoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YT18fz/oBTee968CcCjHUmZs0IY4TFyK8jdH9G45CPwG9pxSO9zpttYAJH4PvwyDOQbywKI1RPK1PBKNctIUuzR6yApTnzwxKT+DfPYOEmH1HZPRRLwkc4QWVGWgtInvy2ApRNgkj1x72OLtzdWybOi6qFJ52HM9iM9EUVbHfuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5BacCsF; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH6Q+GXqHj+Z0Do7Nk7iP/a1ErCr3UImb9P5CIxTOrvav/IBMsK3EoYHD5iU+l/o89uhEdM7Pltkc9FPjhr6+7PlzRP174UWoItke06lig/5N/0xsdjoplA956wA0ESY5QrAGyZf9XBVBr1ZeKqLhrA4b+CaylcZKc6XxIzjVEVgeQ/IduNwmQYW9twGkHIP/hubpW0Og0bl/Hb4XL0jvg7wy4Hon1TsJtP7KrthicSC1siU1DU2QvKsiP5ag10DmRhAXjn5DbdSIfdic1k4RvZ1b6o8R6KjDKnQZlu1rT3KJxH4kGrpruZlqY+bkZGywwNddWOM2UY2Z790Of2ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FxNBvkrrOws3HrdMhSWDvlJyJRMhlrLfIzYd982s3E=;
 b=LFpChSnwHCvbm5poZuBNJ+kVfV1SkQIZ8IIBYkoTWQPZtAnJLSGjTBrjiFcn16hqKT9Mgr8ZOCt5xhS5LD/0ZmQBM40b+m29OKG4SvAd1DmAnAEQyVUn8STIXnx2gTAXHmWriyS4i1Re0VV8nbac2FoPHIoHIXuAptX1uxu8W84PoEhMd99p4sAbUxhdgz8G68agCv9WhbCcqGfJI4SVYidht03nZWrUDk213BLt1r3UJVCC9ZcvoaL18SVZxQzfgF7YUzrB/hU0DP5r2gkZPZMmCuTOSRQelhdx6S2WewmyNXFRCQajOsA96FHdPRwSKSKSLAPZSiZ+9PnuZbPVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FxNBvkrrOws3HrdMhSWDvlJyJRMhlrLfIzYd982s3E=;
 b=c5BacCsFNeZ8ZosvIupHBp1UvBeHwOzcEHerSHhnw/q8YwD3YqsCZ4NFkt+b//Gfwm31btPYRXA+x7TXbOOLuOVzf/igmdlH1O2eu9yBHgYzObM3MgRTfLzC+MycL0MPwOpER7CuirJMZyGOUKJY/YgiOqZ2F2UMPnTv5jofW8lz4nBooY42rPFTPF1yx92g2Ekde1tosA6bSjP5zr+DsKARhN78Z5eWwMtSRSdPM2+K8IMPmTnnc8IPQtWNX6CJHKxZF/svBx4YTZP4+sw6o0JpnUpYAiCT0OlrAB6jzAjah62Q/9CRUqhxQZ+wimSAZ5GMfDnFakNA1cmRMMfFtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:02:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 08:02:59 +0000
Date: Mon, 15 Sep 2025 10:02:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
Message-ID: <aMfIMOF17vFVrfTt@gpd4>
References: <20250915024731.1494251-1-memxor@gmail.com>
 <20250915024731.1494251-3-memxor@gmail.com>
 <aMeuunTYM8c6jp1m@gpd4>
 <CAP01T74DSRE96FYRCMLghkFJdNPgi-PhoOycQ2fXyYhUF5ngBw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74DSRE96FYRCMLghkFJdNPgi-PhoOycQ2fXyYhUF5ngBw@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be365d7-973e-471f-7ce9-08ddf42e493a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgPKioaMQEJjGykwhXOpd+jhFZEI2IdQt8zOWe3oCigQf4/zLQDyOuAY2UUx?=
 =?us-ascii?Q?a2XQovnYhUGML6p71WLEnii7c8M+HWDrX4mCkl6dXbea94hrGQTSFbDi4WDo?=
 =?us-ascii?Q?Cood8khefMwr2oZDk9MnDrr32DLA1hQKWxPghEEqEKpoLGMjfnsVvu3c1MTl?=
 =?us-ascii?Q?zRhTUIcgidPhkzjTohiJGSyLRplD/j01zmUNuggZOWGSPRvLyHe/8ttvyxIB?=
 =?us-ascii?Q?vb0THdzRgpMOT49xTm8GnFUS+VyvQEr2L491cmgn7Vdbde09ZFkDwXO23UqM?=
 =?us-ascii?Q?H1A2avQJmKq2VwOoCQYWsfmQo0ybiNau2Ja2CpQoV3RfbZ34ermTTqOx/Xt5?=
 =?us-ascii?Q?S24E1qEJ/YyOuNPlRiEn480gpwBgw2yFA0czOCM8nq1oWpsZZqEmR9tyGm0y?=
 =?us-ascii?Q?anFJwcXOvuR9G1zraysJJ7kjBGNAzhyOsxokbqZGqASHGdqPhL7rk8W/8UTi?=
 =?us-ascii?Q?SIUT2lVlmJ/7IcRpp7Ug02MA8Q/W9fbXKDNp4r95MFailTFNjGdJE3r8qApr?=
 =?us-ascii?Q?gCTlDYZ19hfuil0Wh/zsiA6ZcnYu8GCB34qpihBAS72lH5ySuQrG1K7nA2IH?=
 =?us-ascii?Q?o/bljz+B67dzyIy4BzULX6o8R3j6Jrd36dTyrclit3LzFS8fpVBXcYFUpTV3?=
 =?us-ascii?Q?M3sslUm0Uwg7JQ+mPTJvfih0hW4h5Yw9VRolyHBUWf58qtafh0u/oMrOD/Ll?=
 =?us-ascii?Q?Gmpl80huY1Ia39xIieP8SuXRjW2O7efV0Z6gn6qi3gnEK8XGyZs3J6EoYY9J?=
 =?us-ascii?Q?wmKfman8Z37Apai1TrGc5R7EFrCQbckwcPNVgMe3Q93MdMZ7VJdlFQsMUFwf?=
 =?us-ascii?Q?QuuF3fpJVSHyOh10FUPiKc5WK5kpOW7H8O9DMABBDXuOgmPOmP2Pu9WultuJ?=
 =?us-ascii?Q?Ao0HdPtGpCKDOmJmiesrFU6nB+HTvDFehludMXMSJof3Cn7SiakNbt+sqFon?=
 =?us-ascii?Q?sCK/b4EAh7KkS4VzgWve4PV09q3uIxZiD/I65GoqHWzHv1ePXzQOIKYRtMYL?=
 =?us-ascii?Q?B4eIgR5p7/1MKllV8nNNV4ukI1j+o3PgqI6eUWyWTNS8FeEYhKnH+4TlJHg3?=
 =?us-ascii?Q?eOn145jwRQftx4NVeN9IKB9+rxVvO0Gzf14hbtrb/hZ6yMp2PCmcElVa/2v1?=
 =?us-ascii?Q?9PDhMblaOgnDAlmI9lGSPeiGVXI04dUFBYSX/CHOoEcL+fGD9QUtEP17+YiT?=
 =?us-ascii?Q?OfljAwsklKlX4UdpBLa8GjEvsuJquPt5NcLJ4nm3NRx6MaT2DpHV5shyT2di?=
 =?us-ascii?Q?FRYEBs73UKgIdmdiRE1HDFQAv108+v/qGwupY+0bsxPGfquoIjoc2EHEjrV+?=
 =?us-ascii?Q?8BWmtOAWLe8Ym99ZPCRVgsHHrZsQXx6gsy3AUi680US9a4nx39AevmpVfu7a?=
 =?us-ascii?Q?EMXHbirrumgN4wKL1WsFW/KlGh6wvfGDm7hufdLTrdosH888fLMIk+mTP8so?=
 =?us-ascii?Q?97tKwlKOXqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wvd7gbQCaaDf36wfwzwgL23m/egEFhwhB+EMDwsW+pEL0gfq/WjKBtv90RbM?=
 =?us-ascii?Q?HgcZUuADKjZHULLWdnN9eH/3dRa4I9qVQp1iahkn0zoClgJpTOQFPYMGX5JW?=
 =?us-ascii?Q?Sju3YaP2Tqm9CiDF6/zWf/gX7EmlwAViGaL/c1Pf6OQUZhSEdtB8WevapFK6?=
 =?us-ascii?Q?wRJ2L64frDL4krEYaL8PSJS+jcy71mPt16nJ7tOanHAsujH91bu/UHc95S0v?=
 =?us-ascii?Q?pTmu6o5Uqx14KTOxfwgPihRonSFjx0LHKDt6flboBLpNekfHSkEJL1ah77uR?=
 =?us-ascii?Q?biBULSpeVzfmiP7VpeWeDJMHd8OEoBVFXzuXtak+hgHR720NHE883Lc5pHhw?=
 =?us-ascii?Q?U+Z3AyGlpXKwjpL9S9ywQWltD3ksTViT7LRrhrKko3hlg8fHlr9Bam1nfWdc?=
 =?us-ascii?Q?rf7pcu5xX+csT74pC+gxmrL6qUTvW5x9uc48/8VLpOcH77pSYRV9waP8Cdq3?=
 =?us-ascii?Q?pS40KchMz68eoHQLS2G2I9RyNQLDFX81lbdPDQ7yOyV5SP6s9+NcC9Os8idn?=
 =?us-ascii?Q?tJ8mba0++yQJGuxXCFK4imd6RUYFRgylMCtTND4e4mhOcrgoea6bMK/lmje/?=
 =?us-ascii?Q?E3Zuj4BS/l/cq0VUiH/OfoStzEgt0TNSA5cFQOUFvmdkp26bau966jS7Z5Cb?=
 =?us-ascii?Q?aHbSKc2F/BDqo7YFmVCXyZHR5baLmgflVkEHntOc5gtqUDV0hST2aAmRciao?=
 =?us-ascii?Q?c9DxLm96IM4mROZpiB1CnMGL+EUk/iSBX/W3Wf7uqts4ngYDB74anQTKd2rS?=
 =?us-ascii?Q?TDvhGGO3GLtvz9gmEMmU7GjY8hKEX4eRwvr/+W4OXdT6w2+Yq7z+TpnhTRz4?=
 =?us-ascii?Q?tCKRKZ3JZuZ4cVXpEz/R7KbkX3XpnZ3hYmyoIUOaKTb5Iy4K1StyGsgOLb0W?=
 =?us-ascii?Q?7b5oy4MeBT7FONUstfhi1nKff0h1rrmWSc99iJagcBUUTUjd1E40OklSMq5U?=
 =?us-ascii?Q?UTiKDNr9E6tAbZMcd/gEOCP0DGI59yvyP8/argLZ0pCKqPsubGUjKRcoKTMF?=
 =?us-ascii?Q?ImFlASNWh/sjKzdvgGF2z5JEeU+hXOCZOBZcc01WhLvrmnwKwvIG5pV105qH?=
 =?us-ascii?Q?TtFmnzMQZfKdd5u12s3m4YPo70EWZayLEIMGHoRJhuaeIJsMTlAeOaZHIWOJ?=
 =?us-ascii?Q?cjc2/ZqUvRm234FRTkKAMoP27qM33gvpTZK3kPYWtow7rKpOhR+LlOGEzLDg?=
 =?us-ascii?Q?sNnk24Ibl5AJ7ECBB3USm59eV1kkasEXLHxebbeGFasVcGXMo8b1tnm60tuA?=
 =?us-ascii?Q?KR5jAQ1NMERu2D38pNHSuHlNILhCBacjrFYZy8gSCT9t7cg7XuXKhzIFmy9g?=
 =?us-ascii?Q?A1iJiYmOB61n8L1pYMuf6uXIkWZnR1aAgz3nWivfI3K3JafOa0sng5Nzbw8f?=
 =?us-ascii?Q?lPr7EdBpG1tQUoGD2n+2k3qfp0peDYxj9sASvei5XwuCu8vCq7D6oYsDDeYv?=
 =?us-ascii?Q?PZEDjhYuMzIpN+MzXkdDM+PsdUk3tQJGOXKYRQeE2SduKT/+AGZdBll2D3CD?=
 =?us-ascii?Q?2mI3rFL7UfwSqdxfGGhzVtNwnmAOCwOdXsbpHenqW7zS7cXWnzl89obs/IY3?=
 =?us-ascii?Q?lFk6IpERlyG6czEdQkcaAU1Vogx2eJbPmUEX8WZ/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be365d7-973e-471f-7ce9-08ddf42e493a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:02:59.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWNBs8+hBJButdmdeZRCCD7g0hHGFMVAgd/FK5qyS+cRYdBbOKCsCrpoiAS9aw4FXOIYZxZ4ZOIAPU967aTQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8

On Mon, Sep 15, 2025 at 09:13:15AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 15 Sept 2025 at 08:14, Andrea Righi <arighi@nvidia.com> wrote:
> >
> > Hi Kumar,
> >
> > thanks for looking at this! Comment below.
> >
> > On Mon, Sep 15, 2025 at 02:47:30AM +0000, Kumar Kartikeya Dwivedi wrote:
> > > Add a kfunc annotation 'KF_RET_RCU' to signal that the return type must
> > > be marked MEM_RCU, to return objects that are RCU protected. Naturally,
> > > this must imply that the kfunc is invoked in an RCU critical section,
> > > and thus the presence of this flag implies the presence of the
> > > KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will be
> > > made to make use of this flag.
> >
> > I'm not sure we actually need two separate annotations, I can't think of a
> > case where KF_RCU_PROTECTED would be useful without also having KF_RET_RCU.
> >
> > What I mean is: if the kfunc is only meant to be called inside an RCU
> > critical section, but doesn't return an RCU-protected pointer, then we can
> > simply add rcu_read_lock/unlock() internally in the kfunc. And for kfuncs
> > that take RCU-protected arguments we already have KF_RCU.
> >
> > So it seems sufficient to have a single annotation that implements the
> > semantic "this kfunc returns an RCU-protected pointer".
> 
> Yeah, that seems reasonable in general, but we already have iterator
> APIs (bpf_iter_task_{new,next,destroy}()) that collectively require
> RCU CS to be open throughout the three calls. That's why I just
> cleaned up the internal logic for KF_RCU_PROTECTED and made KF_RET_RCU
> as what you're suggesting (i.e., fold KF_RCU_PROTECTED into it), which
> I assume will be most useful for the majority of kfuncs that are not
> iterators.

Right, my suggestion was to fold the KF_RET_RCU semantics into
KF_RCU_PROTECTED, even if the kfunc doesn't return anything (assuming it's
possible). Then annotate both iterators and kfuncs that require RCU as
KF_RCU_PROTECTED. This should handle both, right?

In any case, I don't have a strong opinion on that and I'm also happy with
KF_RCU_RET and KF_RCU_PROTECTED if it gives more flexibility.

Thanks,
-Andrea

