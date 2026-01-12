Return-Path: <bpf+bounces-78545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E3D1253A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D723073FA9
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C673563EA;
	Mon, 12 Jan 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aek407+a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3252352C5C;
	Mon, 12 Jan 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217585; cv=fail; b=s0gIiXjjmxn7S3H4YFNwTB7y+QkxIJMr0/Qxs3XYMf22AnmRq6BIS38ejeddHBp3kwye3oUM1/EGcFXOFRlOByuTnjmH2HR5PcVH314ZVG11/4rBlJQ4qSllYJEBsYZX8Cot4xR+cPEJbP/9gG+2FygDsGHyuyVeA6GZDtgYdu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217585; c=relaxed/simple;
	bh=MIp35ndt8nPl6nVqBJIZ76A9Z88eznWzHmgfY90K1EQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TojLx2bbRQyoF1r4bdW+zXz+iouD57RMnotXLvbqECj1UxUi2Y0n/JBUB6+jD7BIsEUHtUCZwSyBjEaMeFouyLfgC50lv/Gkp92HUh9sE7cc8IfJUTH1qDJBUz1PQsBVKKpS4QTtDea4ax8VgraLAWmxf56tcb74Tf/1ipCDnp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aek407+a; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217583; x=1799753583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MIp35ndt8nPl6nVqBJIZ76A9Z88eznWzHmgfY90K1EQ=;
  b=Aek407+axqB0m3G5LUdtzM2TPDLQnC6B+ZWbBpM8tV+6nNdmBV9hf1Pn
   s4QOgFqyCs/pqb71xWPfWlmcTAR3I4NZ01/wm0X69nbMDw9jaErQur0f1
   Ye+x5IvCbHKC3t93zU6xXAEWdc26L3Ug05AIYU3EzEPxl+GfnVosuq+sC
   MxrKv3ZAwwnhyTfihqULreLMENOP7btDEOgxkwcYtabahM52ZGnY/SNL8
   +N/LOHwlgwfGTHUuv0al5f7jIfifKu7zVvUvtgyzOVVBlBrBfiE87TXrz
   PXBaEWKBxCQXo8DX1qGgKgbr4KX1G3WoQHFFAh2WAGIM3EcFTpWdrN6HO
   g==;
X-CSE-ConnectionGUID: r+MuxlSWT1+otZHq/4cQcQ==
X-CSE-MsgGUID: V5pM7le5RlGI7EGaNE1Jxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68694077"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68694077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:02 -0800
X-CSE-ConnectionGUID: A0sJRrX1TKS6k3pmqhr8Yg==
X-CSE-MsgGUID: /fMFlMhySyGEuxm23CpT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204085350"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:33:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:33:01 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaEmEa9HkzTV8d9zCBFNs9dUFo4A1jdAmKRvkXFOcrMOArsRQ/UVZOJwKcxwXDAAuXn7rzgT5cRwgsQqFtF0qxLn8TLVxkacxUjNpxJDbcd6ZgC2ncX9cSGzf3lYr/3RaMfsxz9WQAGiIa8yEfqPx/4QquW9bmpQLWH7ek5aVntMYmRuYtFlZkAlJpQVkVv35qYnd/qQU7V6xXtpRpwzUgA+UmInbIC4z30FpyIM2nFj16LD2XpX8VkyJPH306p03BSJtFxhEFLU+RFcfP3IwwpeBxTQpnn/2FEKMPHFCLdlttQWeHNWs1NuPqPuySo/4e100KWzAnod7Yyhs7ivdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIp35ndt8nPl6nVqBJIZ76A9Z88eznWzHmgfY90K1EQ=;
 b=eIdiWq9KnCrbd/70l+CEs17ffU4itCH9R/aPYWn7LGMyWBgStwBIVL+Q4GlTzImvuWPxjutQuyQiGZGMpWu8siFWW/Cwq36FHDlohRqvgzkKuTjelq8fjMlfk7T4ZTsmDZ0J7KqqLoDaBgS/hl+Z4ib9P68szzFq8md35u72vquGpNrP2SchlJRI2h/pLWohI/4XbpucPxRfzI7l9Ch2cO3e3RbWMipBenZlrASaLCnZ9CtfzkLJje+Fc8y+IUcGuh5LjrXaTPFSblHbCP9LAZYDxttVEgxM3NDUz3Cl1IQRV11vMxw8hNXIaIYayV5q4P+o8x6QBtDf93/E3xV+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:32:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:32:59 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 07/10] mlx5e: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 07/10] mlx5e: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTmnJdoQY/tFk2/+BoVue04IrVOaXZw
Date: Mon, 12 Jan 2026 11:32:59 +0000
Message-ID: <IA3PR11MB8986CEBFE19047A341A5C89BE581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 61225bf4-9580-4878-254f-08de51ce56b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bklzWnNTS3hKa21UY0p4ZHlCOFRzeHQxNG1lKzdUMHVBb2ZXWmdhOUt4N3o5?=
 =?utf-8?B?cGZnVzBSMTlaeHRUU1ppMks2WkwxQzk5RWxLbk5kcUhMcnFXSzJXeUQzTzd2?=
 =?utf-8?B?djlxRkIxS0pHRS9lTXNGUWMyUnZ1YXUyNFcvTC9HNWxDckRMZS92WWtmK0Zn?=
 =?utf-8?B?alVGU2t2M0tIcFliK2lrUzJlUm1qZ3JraWJIcFMyZU1TN0VJcGRMbWxwVmt3?=
 =?utf-8?B?bDVhZjN4d3FaMlVtSTNnQURHMzFlQWFIZHJZOHA3UkQrakNwNDZDVTNuT1hU?=
 =?utf-8?B?NlhpcjU5Yi9mWU9idjAzNHJ0ZFFwbEVJcmVVcDhINjlDME1MVmJ0OURCNzJn?=
 =?utf-8?B?M1dzeUFsWGJmczN2S3g4ZmJXSkYvQks1Y3FjNURKS2NHQS9TcUhoY0h3SllT?=
 =?utf-8?B?NWlrOGphOWovb3poU3lCb3VpK29EWFhnWjdNRlhuMjF5ek1KcUxuWEtFU1Rx?=
 =?utf-8?B?OGtOMXZ4MEhlTXA1QnRJWmNyYUZueG93TzVmdjM4ODNYaU9SaitNR3E4Unha?=
 =?utf-8?B?WnNlNlhMRUN0dGVmV0t0d3dtZWVwc3UzWTluWW1USWhXZ1czdHdxbktSWE5t?=
 =?utf-8?B?Q3lvNG5xelR4N3NjbWdCR1dRVnV1dHpXQTM4dnZuY3VQVHZhQ1VmQVJ6cy9w?=
 =?utf-8?B?WDM0eXc5czB6a1JYcmJ3OUxscEdWaGJ2Y1Nlcjd5VjBoSlAxWFVqVEUwUDRi?=
 =?utf-8?B?SWZtMlRCY0paelhydmtycTVVNEl6dVZjMXJwSjJlaGUzRGpnaHV5MG9nNkV0?=
 =?utf-8?B?YVNGUW1obDJBSUp4Yk1GVS9OaHplOWdPcEV6ejcwTUJoSDRzTDBHQ1ZhT0Uw?=
 =?utf-8?B?T1EydGVzVkRoQitmT3dyMGF5TEVxbkkyZmluejZXNnRRTEpjQWFhd3NTRE1S?=
 =?utf-8?B?RWlkT3lOYXptZE00ZEtpN3J3TzN1L1RiM2wwRkh1eGhFb1ZMSEtJbnlscTZt?=
 =?utf-8?B?Nk9VakFjeldIMDlnaEs5ajlKWjRpUzl1dXdUKzhoWHY2S3hvWThWSUlINmNa?=
 =?utf-8?B?U3l5anFVK0ptd2Y5NHV5Y0t1TjZqS1FMUWFtTGpCSTNjMnAzWUZaRnUyU1ho?=
 =?utf-8?B?MEJwWEthR040RGp5NnNBU3VIbGxZK2xlYjFEMExFOWpRc2pLRGp1MFdwQTda?=
 =?utf-8?B?NlJJL0tyMkxleU9iQU5qVHdsdmpYTTBPWEhXdlRoQVJKVVBUbmtPUHN6OSsx?=
 =?utf-8?B?M2F2Tnp0WVJ1bGtIMk1qRVlrZ2hyUjVmMTRQTDZVMHovWDkzUkJtc2ZybE1a?=
 =?utf-8?B?NXdRRkxsVHNPZXA2QTYweTdHenNDOUVVeEpRWVl5d1VINWlRNmM0bVRyTHpu?=
 =?utf-8?B?WGRUd2lNcHdiN1N2TEVxM0x3dlVXTlk5NlNKUWpWVmlzL0ZPR1lYcDFSSjVu?=
 =?utf-8?B?VHBFQWxPVHZiWXIzalhGZ2JQdWV3cGs3MUUxZURNU2p5NWNTK3plSXdlVEVT?=
 =?utf-8?B?cy96ZjZ1YmJsU1ZDNWdmbEppNUthakMxUWRWR1hVQytMa01rNWIyaWlFVU5m?=
 =?utf-8?B?OTlDQ1RwL2ZMclFvOTRzbGo5MU13V0dUNk9hZWdZa0wzWHZxL3NmdEpJTW0z?=
 =?utf-8?B?d0c2WWQwbTlrRm1uYUpES3l3WlBrSkNCNUk0Q09FNFozYS9xVThUaVlwSzc3?=
 =?utf-8?B?ZWpMQ3B6NjkyYnNrUUlJa0RZTkdON2gyMzJVK2NDUmtkUndURHBoVGphVzB2?=
 =?utf-8?B?ZFY5a0habE5wYWVwV0lVMGdTN0ZtZ0ZmZTdXVytiM3VTTTRjL2hQQjN5c0o0?=
 =?utf-8?B?eVJ3TW5XTzF0T0VJRmZzeXROWHNqcHh3Nmw5Z2paMmx1dzJjZnIrbmpGSWlH?=
 =?utf-8?B?QkNEWXRsQjh3S1Z2T0ZUbGpDT2JCT0ZNOGo3d2VBK0FmaGppRXZPV2s5S3VD?=
 =?utf-8?B?ZVlXR3N0WStvZitnQnY2K01FYnIxdnpOQUxpcDkzZHFHeGxrV0dzcldGTHpk?=
 =?utf-8?B?WTVjNXlDMDRRK1djUm9FbXpZVGZkUU1GNHZ4YjhWQ0Z5TlZtY0xLYURIQzVr?=
 =?utf-8?B?eXZsMHVOaGFZZnQ5ZHlLVlAxWWkyM09EckFXNXpSQ0hzbGdIK2YrSU5nNHZT?=
 =?utf-8?Q?SkcVP3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WStrc0p6U2k0TFRWVHV2aGdhNnl5bGZCN085amVQcWphNVl1bnN2YVB6T2dm?=
 =?utf-8?B?Qmt2bm1PVjNMRjVCRGYrVyt2bVBKc0lTRElWNHJXc0tDWXNqb2E0Mzk2UFh4?=
 =?utf-8?B?bmtjV2oybmtiYXVVWE9jM3lWWTZHNXBxaHlOUG5pTmVvZEY5c1RYYkNzajZZ?=
 =?utf-8?B?bGZ6UjdyT216TlBldmV6L2hCMDVoYmFiWkFjMkFwbi9wQWZwbUZQU2U0SStv?=
 =?utf-8?B?bkJBOWhIZzRvRDA3enBrOVBuZDZnQmsrRERQakxwbWN2cUdnME5PTEgveGpE?=
 =?utf-8?B?M09Kc0h2SXBFeVRzMkpGS1BqM1hKcTJlMHRUNEd2YTVmT1I1VmdITGI3R1BW?=
 =?utf-8?B?Rk9OY3p5VzJJa0duWTRvVnh2OTZLUEFwUmRyY3kyMXVPWWhBbFJlRkFLeGdF?=
 =?utf-8?B?ckZtc0lPd2tGRjlHbDNPQ0pna1JOd3NGVUlmMXIrVncwM1A3VlFDcU9BZFhn?=
 =?utf-8?B?dkJzRXoyVHh0Q0pQUzJBeEQwNmNlRlhBa1gxdUZHYzdEUFFWZFZ6M0l1L2RS?=
 =?utf-8?B?bVg3eVJ2czEveldVTTA5R3c3Y3NBQ08rV1plaGZ2WE9QZDdsdVFab2E0MUNI?=
 =?utf-8?B?M3JndGkyckVLNnBtLytrTEtMQmdXemhUSG5leDhCZHA2NHc3dk9qaCtWREZ4?=
 =?utf-8?B?Q1VnczY4bzlRYk1Ebm1RMUJiQlJCVmpsOWxJZGNScU9KMFUxd0U4VFdYcjB3?=
 =?utf-8?B?VU11RlZGSnUwdkxsbmFxMlcraTJEKzhoTXh2bkhyQjhiOGhHeU5LTUtBYXkr?=
 =?utf-8?B?TlJ1ZGZzZEJESnJNTElKaVVMNDRMYTRkWXdBdjFVZzFXcjg2d3JRSFFNZjFO?=
 =?utf-8?B?bEF5R09YeTc5Si9VaEFhVkxkSEQ2ZFhXeXI2bUhVV3k0VkI5clhJN2hFUXho?=
 =?utf-8?B?bXJtVWlsVjJpelI4dGRxdmNuQzZUb0ZhMlYxTEZXZ2IwZEZKUHM3L3FZZ0Nq?=
 =?utf-8?B?TTBBTnZJbnBaZklpZnhxeXpjOWNDdzZXaysrRUhrbTFVd3NSZHFXejV5bTRo?=
 =?utf-8?B?M3U2UGRQYVp3QW10NTYyeS9aKzFwVGoyZ0xYK0I5NUNYdmxDdGJCZG8rKys2?=
 =?utf-8?B?NG9rVFgzZndSRzhpSVNKTy9RRnYwT2JwcXJtVkJ4QUprb1FFeWk0cEFkZm1B?=
 =?utf-8?B?TThEVFJwcFRhVmNXcWJhOTUxSWIycnIxcFdQajRnRU43S3BXdkl1SFpqdVZR?=
 =?utf-8?B?ay8wUWpwREFsQXZUM0NkZ3NRQTY3WG1ob3pLM05GUjkrTGtSWW1kOFhORFlW?=
 =?utf-8?B?V29hRVliQWFoaSs0eXFSR2VlSCt3eEZFc2RiTSs0WnBpN3M5VGJ0d2huWUxE?=
 =?utf-8?B?VUplSjBzdG95OHNaT3pyZzdOSHhDQk0zUVdhRHU3OGpucmdzVUpsQkVtZU9D?=
 =?utf-8?B?cC92MFcrSHduYVJZZVIwNGJHWml4OXYzM3JuTm1pTGRFN0crdW9SVGtqVVhQ?=
 =?utf-8?B?cHRTUk0xeVhUei9RRmdQcHg0bGlxUTN5RGlqSE1zbnhxL3lNOEdOZVV5U056?=
 =?utf-8?B?R2pLWFJnK3Zocnd1cjNwOC9IWUppOXdlQVNnWmdTNyttRFZvR1FvRXVnVkIy?=
 =?utf-8?B?b3NDL05TZTJIRTl4cTJpR21lc2NtVU9DS1N1bURjOWlPZnBrWTJiaUNLT21t?=
 =?utf-8?B?NHBNZ2h2MnFLN3hTK1dGbzZHYlVreXgra3JiQkVGbEpNUXJ6Rmw0QnpqRzF6?=
 =?utf-8?B?Vlk4cDU0eVZLZ1pSS1BjQWhXcld6KytlcExodkFCdjU0MElZTGRwaDk3TXdH?=
 =?utf-8?B?MVczQ1hNNTVzalFsUzVOSi95cll2TXFNRzh1cThEVHUxRDZtalRSam1iK3Nq?=
 =?utf-8?B?dHd4eitlNkM1dzhWRk80Y2Ria2pPa1kvdStyRnBZaXJ0ZnpqUnBVeUpRc2hP?=
 =?utf-8?B?K25jWERQeTNRM2w1UXBXT3ZVbUgxN1V4WEJObCt2RVJsN3F2NUs5TjFxNjFG?=
 =?utf-8?B?bUZGa1hIRTNJQTFlYk8wSlVrMjRsb0RqNjRBdnZzRzVyTFlRTlNZWTZXVXBT?=
 =?utf-8?B?bWxCUmsyZ01pZjRVb3JDcHlKWUdxbEtBNFhQZ3ljRUVkSEJTSVJVRFpDUWxp?=
 =?utf-8?B?eTN4dkVmdWFOTjZNWVRzL1dIeU9VZC9oRmE3NXpxN2g0Yng0NEVsWDZya2hj?=
 =?utf-8?B?QlQvajBpdU5GazlrbnZvMmhteFhmN3AzTy9rWmNhTExzMHQxcy9uOGpsN1c3?=
 =?utf-8?B?MGVnQklhMkdQcGlVRFFmRDJZT0pYVmIydU8xOHF6SnhJdVgzaldGUFJldEZ3?=
 =?utf-8?B?cjVGNUZiWWlNWkkyYVY5aUY4aDFHMDhsTVM2dUx1VTdEa3RuK0pYeU8vdFhH?=
 =?utf-8?B?Y3cwbHc1V3l4NWdzRkYyM3Z1WW5CUDZsUU9kVmFoZEdUQWtUbmg0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61225bf4-9580-4878-254f-08de51ce56b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:32:59.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNa05YI9GwvOdgOw1ApjaOWnXKn6Lvpttpixesi57mHKgcAQE/E0WhWXIOLWxPVvMynyF+SOs8x5j262PraFeby0WDMlwAyBEJwktzzZPVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA3LzEwXSBtbHg1ZTog
Q2FsbA0KPiBza2JfbWV0YWRhdGFfc2V0IHdoZW4gc2tiLT5kYXRhIHBvaW50cyBwYXN0IG1ldGFk
YXRhDQo+IA0KPiBQcmVwYXJlIHRvIGNvcHkgdGhlIFhEUCBtZXRhZGF0YSBpbnRvIGFuIHNrYiBl
eHRlbnNpb24gaW4NCj4gc2tiX21ldGFkYXRhX3NldC4NCj4gDQo+IEFkanVzdCB0aGUgZHJpdmVy
IHRvIHB1bGwgZnJvbSBza2ItPmRhdGEgYmVmb3JlIGNhbGxpbmcNCj4gc2tiX21ldGFkYXRhX3Nl
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFNpdG5pY2tpIDxqYWt1YkBjbG91ZGZsYXJl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW4veHNrL3J4LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvZW4veHNrL3J4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvZW4veHNrL3J4LmMNCj4gaW5kZXggMmIwNTUzNmQ1NjRhLi4yMGM5ODNj
M2NlNjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9lbi94c2svcnguYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg1L2NvcmUvZW4veHNrL3J4LmMNCj4gQEAgLTIzNyw4ICsyMzcsOCBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYNCj4gKm1seDVlX3hza19jb25zdHJ1Y3Rfc2tiKHN0cnVjdCBtbHg1ZV9ycSAqcnEs
IHN0cnVjdCB4ZHBfYg0KPiAgCXNrYl9wdXRfZGF0YShza2IsIHhkcC0+ZGF0YV9tZXRhLCB0b3Rh
bGxlbik7DQo+IA0KPiAgCWlmIChtZXRhbGVuKSB7DQo+IC0JCXNrYl9tZXRhZGF0YV9zZXQoc2ti
LCBtZXRhbGVuKTsNCj4gIAkJX19za2JfcHVsbChza2IsIG1ldGFsZW4pOw0KPiArCQlza2JfbWV0
YWRhdGFfc2V0KHNrYiwgbWV0YWxlbik7DQo+ICAJfQ0KPiANCj4gIAlyZXR1cm4gc2tiOw0KPiAN
Cj4gLS0NCj4gMi40My4wDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3Nh
bmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

