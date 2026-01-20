Return-Path: <bpf+bounces-79552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B920D3BEDC
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31B6E35D1C1
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 05:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60C3644CA;
	Tue, 20 Jan 2026 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AzIyA6+e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N5+bAiHF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D5346A12;
	Tue, 20 Jan 2026 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768887459; cv=fail; b=q011mEaVROLrCqUaFVkiXdfv7m8KtOuuNsvaqy87n/utIN0nxxy4gGvkI6uQgiFoIXt+5FTv6s0EZ3RCxC6LwVNnN0sfKcrgZbOnSswICWexOfsPqVjFlUG+jSc5Whpjqsj2aNLDiIrGs4APs1IIqdWQiKjXniHDzBaDHApMeTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768887459; c=relaxed/simple;
	bh=mpvf+WPYlVVZ1nqH+PTX3rKu3UyTZqAnETU6d+mVPgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QhGt1NdvTthvtC1y9k7mY9cPO4y2R/vVBAOhjhPdbYsZnAHZ0jt0XSSOvVUHx68G+yf0O8jJT5KpMo8eeTzJOSKK3CBNfDg/t41hVFUOV8auQRQhTdS2aRm0/+6OyDctn/0Hq0SZrL7a29MMNj4OK8aINRdShZOWEG39H4dDpjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AzIyA6+e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N5+bAiHF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K3mY5u3021113;
	Tue, 20 Jan 2026 05:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6Lw1vMCUBFMzP98hEO
	hbgZ6QP29q0BLC35G4exCG0tg=; b=AzIyA6+edipRDhrLqGl+uTt6DF+h6fFkKy
	JVsuPJP4Yi4cpUqHz4UbZJsJ4txE50myJfucHkRu1u9xYhRUVDRCWCVc9+bsewgm
	cND/5vSh9b28hlv5ZP3DB+gFugG3qFOfRrASCPDP8ef0whi+owAub/satk7FgQxp
	+HRcutMxegSYaI0hyXR1ozEXg47kfXmy6u/Ag3ZcSDolRurHSXRedbwMh9AbEX3W
	9vid1W/qk9+8y0riHIbbAgtfElFy1tG0hma5y70X6VsoAa5Oa/NlLY7x7rptynPS
	PXVIK3Nh8/zkDxVHhEDgbypfskFloprane5vgsPSTrgnmoBMBpAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9k55v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:36:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K4ApD3018914;
	Tue, 20 Jan 2026 05:36:03 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrpxhq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwwQVbWSNcFsgJFaeUwHmWtxksdFJrrLU2U5++dg0ma8Tw/vTBqToSXdB1BFvGWjkWE9hdWKe+ZUv2G+1zUagkDEeWp6TcLuXDu6S3lmNobiJgIxLozLSeZZCoLruJypuJ4vgmDuesY+PNUbvPDeLkzT7H5LBDIw8oCL2mLOlICk4ByXewEoZprTNgo6YZZAxooM0xkUBs7PY0i0PN9nsgTEhQmI4sUkEPGJVajppr2+h0BI4BfjTKB2Ikhj/lg7St7/C55iFGZTbaPQZ5E/IBVx+bKOU4sm7MpVm7N8JjoaqZtrzvnD6jgufIAFj+2VnZZznc3CAulXNEdoJFYCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lw1vMCUBFMzP98hEOhbgZ6QP29q0BLC35G4exCG0tg=;
 b=PtXkWCS2M1gUT8Xh18sVX+3RsdyHQ/P5VVTDECSoNFvZzYOwt501ssJfJoW17lDeaowUs3w8p4xVv26SrG/w3cs8trjjzW24ev6+hv8c2KRDDi+FrspCaBHCkXCpr6uHfbSmmmjUuc/ewmw3HySLrBeXSQ0C9b3wDSCW6Skimve17NCV3fmXVncG5m55qwMs1lhBZ31dH/nZs9B16Wlyom3/3aI3KHKPnJjqirJsfxWCqTKJW471ttKBHTBrfH7DPTu5f809eBvlZ0Ld2WreaASL7Rz66paiFf8bD0rhusn+njQRySgAiJOD08cF8PdQS/vfuBqQmdtKX9ShWQeUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lw1vMCUBFMzP98hEOhbgZ6QP29q0BLC35G4exCG0tg=;
 b=N5+bAiHFvGbLS/FAG69B/6OcSDQsX+B4t/sTKjmdckx/Ogr1QMJ8ZmA2Iqa8upWTAOYOD/l7CUq0vXrZ4ObWEIy3tc0uJ8r0PFzsXbdK7UX0Pk7LxftqnDRr+rQ1Fi/zf5SGSvFM1qUmJI6KCSn8aIfwU+jnuM8YuDNROw2Oix8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7769.namprd10.prod.outlook.com (2603:10b6:408:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 05:36:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 05:36:01 +0000
Date: Tue, 20 Jan 2026 14:35:50 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 12/21] slab: remove the do_slab_free() fastpath
Message-ID: <aW8UNjNBXf651a_1@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz>
X-ClientProxiedBy: SL2P216CA0170.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a16174-3a8d-4575-9acd-08de57e5cbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1fwlUfBpu5t9XR9fv4TC9CMyYwkGT6eQAGm4OEg87WWiixti6ZSawgd4uiOF?=
 =?us-ascii?Q?UmA2AbjGKEdWYF0xcPXrxgOJ0DjtJG7Me7VVTrUeKKtY8Rg5yjtOo/qLOzF2?=
 =?us-ascii?Q?jqjjtPkqh8YyiBXFm8DTrNe8B9sGpirH1dRVUhej+jCWQ5dGKogjwmzzNsqn?=
 =?us-ascii?Q?bhmqweX85mshtFfOXty/kZPcKyOxgF86O/66t9QeUqs9n5zvijRYrisacbw/?=
 =?us-ascii?Q?v1CDe3O6q4ZPoRGRKSMLmltXYPgLiplzA4Ld0iCJLl1ojDy4vCsxpGa0PGcY?=
 =?us-ascii?Q?wfdg4myE8ZCyRyl67+o/I1Tra2pSdPi2XHscaxbmv6VPfBC95Jt5+npKpqF5?=
 =?us-ascii?Q?l/a/pzDt3VBjB0pMO1RQyQikZDlWEuDcGkVvTUhy0KLi3ukNTHfDMdKSFn2d?=
 =?us-ascii?Q?uVCayVd5rWIfGPmDUZIIMn55Hu1zUYU22DR7q0uDXxKoiGSCAjZdE27qE3Pf?=
 =?us-ascii?Q?ADDuRxHdwcOOMJz6FO5+y9YM9ji3CUSrvR0l6xhCKlYr925jOeRZVhfaYwqw?=
 =?us-ascii?Q?NlhNKlHzeKoCXZuz02bprnsBZP6qUTrbbRXpCeMOt5eh7kbMyR8ULEmVECEp?=
 =?us-ascii?Q?9M3QbBLVkpbe+JMGgIGgXY5DYVkvUQlXDuajS4o9ZEZ0wiy+r6AvuiSTfdkT?=
 =?us-ascii?Q?raDW7r5WPOen1lJL2wAgnJ9GBMPMRo/iriRf1f50Z604gPmf21ZSPODcW9BM?=
 =?us-ascii?Q?kSjTrswaLVuLKSds612G4ZdhUo0k/BJiYkoaZ22YyEcAZWQg82VgV+FLPYLs?=
 =?us-ascii?Q?dFxn+sxbHYKIMcfglwXCtsBPOU+HgJc1QPyWdhDUDKGphyuHd74OlHy+Xyyq?=
 =?us-ascii?Q?D6UiJTmjlk3I6FTDZGy3poLfLsLI+1HrcyjgofVgSUmbCEKFiMClHI3Hvc5k?=
 =?us-ascii?Q?rVRz4iozKP5+0+XFTHHYvUBsv7IVZCrDjit37lJEhd25mCEAA0GDvDkYdfXP?=
 =?us-ascii?Q?aKq5QXTujfcsBf58ggtxtKm+VIoULoV6Ul8UxjAtQs/oqeVGdNDUJpQQlLD7?=
 =?us-ascii?Q?EoeZaPrBfTyKDG7Jw3URnt5l+WQWaptLGN46SFIQN7Ms9NNptuAxZwJAb5Gh?=
 =?us-ascii?Q?ncVx8SvYWBvLATJse8ePl1hB13sEngdtQCSoj++AP2NO7b3IeLiYlDthmX5E?=
 =?us-ascii?Q?SQHAzf1EIgcyrUi3fthwMWa53RM9XA9ma4cMqBXE67uUQoLJSm6x41jouXVi?=
 =?us-ascii?Q?543fEygpmS+uav2w10rJnKjpH6Dn/pJrb8J3sZnxMgnC9yhbGdRQICJzfBt9?=
 =?us-ascii?Q?dUOjVDRBX5iBpS1cA4yB9/d8Nmz9qfYs6Xc05dQvR2gzGcFKPyAlDc77XtAF?=
 =?us-ascii?Q?lAjc/7AqEaDi6bGqaBEnB4Pyfb8rJcppEc7O68Ad1y1uGP+XgvNO/mnriyr9?=
 =?us-ascii?Q?6IJDva0Sgw78V3kO0b5dU9Ha7UeoZcggPWJIlmMf6acDzC7kOEaZ8efKIOXo?=
 =?us-ascii?Q?J7dOMCqZKPoFs89Z5b2v3u3igmtAFoVoIZlCXQe77IY/AFPmuqkWTyJlm67N?=
 =?us-ascii?Q?AA2uIea1PsGSTL9uzZdhRGllf2R91jRXZjAylbWRpJvwW14I0gbm2S1eID1/?=
 =?us-ascii?Q?xldVMZ39/k9I27j7vF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zeRZ42z7l2nQWCy/y12BLUss1xb+a8JOHgO+kRUZNrLEmkudHXdVQG0YX6/W?=
 =?us-ascii?Q?6Utv/V+8aWGeiBR9Ay3rNJF3xy5AJMUIybN3g7bvASqESZdQkUYXPmt3Iti5?=
 =?us-ascii?Q?d00sdwZIrssxViiVB6+wD/pEVFyh1YZCuw9y0x3ohsxE3CNlyKtAUsIJgTte?=
 =?us-ascii?Q?Jh/RaBaE6myoZ4JDCWyGLbQn7gJS7eKyNSEsy25idOnZavggjWKMVzZtcYUk?=
 =?us-ascii?Q?i4p2psUf+2iw3swMItPDEHJsFb63uIkMCY9xbAQmuUdfW30q6jR7V159Xpma?=
 =?us-ascii?Q?Cwpnre/t83KjLtfxNQNHCeYzdYUqAgeP8edk4oj5f6WD5g3aeRWBmEzJ/Opc?=
 =?us-ascii?Q?iPnm95TN6MyZ56K0JFwxzdXlC/viduV3/ccR2C2V5gvqbHSfxeFz2cEuizqg?=
 =?us-ascii?Q?CLndN2MkLlDJTjaO05p1SkoqjWjrjc75A2Qtn0ZJHz+v/Vx1R4fQXEjdgjqJ?=
 =?us-ascii?Q?EifaOCYhLaMRT9qr0RhDkmmkL39feY50jhhjv8DBoKPYzmLLyILpEqxeADwJ?=
 =?us-ascii?Q?46p2UHfbODUilPZ2vOpUif3TjpuW4e4Re+TMhVBrfegAjtxsckzS7x9DcQKJ?=
 =?us-ascii?Q?7BhDYI4dxVKhQsELUJBEv84RvMJN67NX/+MAAeAF+n2lMnQR7QN/HmJC5FRg?=
 =?us-ascii?Q?3zLiqRPgZ45pnaV3EmIZ5UuwkP1zWPsjM2rNYhiPEHrY0CMbrfk9NN4hfiEp?=
 =?us-ascii?Q?yQAT1E41OHDYi0ZpRegDPvKLFhWOWFxgjL38+mFKG/CPHgVFdPm4P31ASJDu?=
 =?us-ascii?Q?gBdN4wq1q0XwQOj4/EeM96yKotlZ2IxqtnHRGPcuDhQm5ogNXeOvRlWQjL0P?=
 =?us-ascii?Q?D+/Kdd1k0OCkY82IN5xwBFEiQ+zu/4oD+DLkT3etIr8y5EnXdi+LZM0Ksvr4?=
 =?us-ascii?Q?Y/3rWnhhnt0DR625PYPWW8JEcQBBQYAuNi55m7aQHwpTnGqC3ieo3W69bVT6?=
 =?us-ascii?Q?jQ7P2c6cKLvlZ+3z/HPcgoQdJ/q/6WwIxdfq0g0q+Wr510wO0AHJSP2TjVC9?=
 =?us-ascii?Q?7K50tYgc4Mk+7ZsM6q15wwX1weh8PfnO0upxqHKhkynAnMlKbThLkldCO2de?=
 =?us-ascii?Q?ebC70Gk+GPQYDF3K2jjvYRaPZTEeeHvnpSNXulZARZCC9PBmoB2yiee94EcR?=
 =?us-ascii?Q?1sofWkrIspu320HYlItQWfgRgDQ2sGeiwZe4WhsyI1uaNDNT2XtSCeXJyYA5?=
 =?us-ascii?Q?yJb6bPv5I7r3gfRIe+jPjTsHXRntqWc6WPzswxa+9w6FZE2o51G856BsHXuA?=
 =?us-ascii?Q?57ExYsPXUJHLZo8VnyKSzstAn3AN7+LIp1FAJ6YnOWhW0BklIbB23dJ3EXMU?=
 =?us-ascii?Q?7///YEg1/OaMiFO6U2TO32tKqvvYKfcykW+zeuw94nBuJ9tin8ZqxjMH0JXX?=
 =?us-ascii?Q?Z9sci9pC5flssNeeU8EVl7tXmEk+YzNXAbVgYMlj+4zxRDpf3+jscx9k0Nal?=
 =?us-ascii?Q?nOs6A8lRJwSFTqiJmp1hIX4oi3nV1jBepYdDnI9jhM6L9Gs12P5LzORAgZKy?=
 =?us-ascii?Q?h0rMEJEXiKn01lMnEKoNgLDNCUPdCq33fsYLcX9YEZoXZVyRrFSPXCuZaq7U?=
 =?us-ascii?Q?/AjpJdSL+LzteIa0AoEj2phMnX+p6ikskKYevlJHy5h3cTCo/a94r+dzBcwX?=
 =?us-ascii?Q?LWsH2S4sxC89YJZn5VLJDElrxFQZ4eMdFa1lBz4sx8IgcEYyFuDQcl01JCeT?=
 =?us-ascii?Q?HacwxcHi+aOVoUvmPWjUENTNt1kljCQbKV9qJ3xA3bUObap3+gaR3xMClpWl?=
 =?us-ascii?Q?secavgtz4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FIpIQ716WtdOjjy0lJ7oTucmnLvC1bnqF+K618zW/7Ezoa063CY0hVPmiI91epecG37QwxnSsk+0nO71UL8jyEFZdbNx2pyANSu1kfTS5LdtOmEHl5YEQuDFUhau5d66vOiroaF4+tOvI8R4wS0aRledoLwJzgLC9CN9t3X9S8bSqlg9bly9UyStPPEvXujsBaXrDP9F3d/EeOMTpBs9TKFBJ4L/tYAno6D1arJ/K3ryZFVBN+yjNqucaMhisE+fbYk9KcnzZeb5w/5fjx46LaTKr5SSCsanui95NBQxwoza99pJviH1SEn9/5uO0HaQw8YJDKBd1VzRDEunm1jAFVQc9zOva7WhqKSGLEI3Mp/yCJbWI7eKkbFo4cVU6OprPaci/cPbgJnJ6YkSw/V+O+uIHA6LP6VHxue9VHMx1qwR2Md9wNrujUTfbaf52SGdEZ8CeX9ekFbPSrbUXYiRr3QdkCIzziPy2+Ea88DVJDesCLXVQheGCAU7/BCLbFUIC8CdV3B8VU8icIwqj4mbyxTx63T1XgIat51C6Xcqqxqje720SIKQsqlzlZ3jZBDnPPIZamO13AsLpkPnkkfCUldfdiYV16pwR+l+bUA1tD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a16174-3a8d-4575-9acd-08de57e5cbcc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:36:01.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMSdnCJBi6wvhbRDPdoVZuTUE9hKCYRaczE26AE+KKT7sgbCWGUTFGLqBnuzAuTN3GPYzWf2H+2GYDMlFpCVCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200044
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=696f1444 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=mmuLHaXanjJjNhj-MCMA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12110
X-Proofpoint-GUID: 6J4yZcSZub-Rux7FAgESBNxrWEBbPlkx
X-Proofpoint-ORIG-GUID: 6J4yZcSZub-Rux7FAgESBNxrWEBbPlkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA0NCBTYWx0ZWRfX7nBrOs6DOxW0
 dCv1DnaKHj7vrJCqZQjgk/LB7xkJ3Sjck4BBwVNzEzkuktmenxHXy/3/ldveLYh8eCq2bq8beNi
 Ej9M+Wka6W4b2DjBfY6NibNU6FCaxHwQLAUcHv4MhVzBO5uGTQSvia9E6zkUfYj4R+3vS4h9Bl2
 b+SU3Vad7+kBab6PVfZo+lsmhHUJnktzrw063x2z+nLvtulCVW6m1H5MVjrfGCZn794g4rXW59l
 +Yyufk6cJ8IUa9r2/CtI4u/h4bTK7fLE5gbj2pixHJVzqTa6vWZ7oSxIjqRkFJsr6sJs0KeVSHv
 uKC5g4b+xFILsWTTXzJl8OnHg4PWaaECLRqfKOeSEf08JfMxjV0x7Yn7+uO8w56xpuWB5ViFh/4
 V76h3a9vl5xdneLjHFNfLUn9jwqoc5EFI8FJNgwMNY9TGkB5Ca7ln544fDCVnDLoT1IWbhnGzq4
 cf9o0y4alQhKZ+sooHTYCufB22ywL4i5Wu/fjWhM=

On Fri, Jan 16, 2026 at 03:40:32PM +0100, Vlastimil Babka wrote:
> We have removed cpu slab usage from allocation paths. Now remove
> do_slab_free() which was freeing objects to the cpu slab when
> the object belonged to it. Instead call __slab_free() directly,
> which was previously the fallback.
> 
> This simplifies kfree_nolock() - when freeing to percpu sheaf
> fails, we can call defer_free() directly.
> 
> Also remove functions that became unused.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

The alloc/free path is now a lot simpler!

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

