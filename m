Return-Path: <bpf+bounces-60593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B84AD851F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D001883B75
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B62727EC;
	Fri, 13 Jun 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNZW2e57"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF844239E8B;
	Fri, 13 Jun 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801147; cv=fail; b=g9EVjbALDzsahokshuhhU1yp1AbQCq5BGZfQUg81AmfY6KJRaiVowS7kCHGiUKasohP44bgXmCXwxJyw/EBLSNd8o24yu/EuuwMgke4jmsseRq4xlggRsFe8VykW2hLvG9b3j0nxLW4MNKM66JQYmY7sXYp/lkyNfkB+Amu73kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801147; c=relaxed/simple;
	bh=w6WLLCIyDkM+H9Y+fKHu2fIw2kdSh2hT9Zt18dmsq9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hm5OCRAN4vFu5Fyj6DHNJesKH7z03J6zCCBD18HNVqvctNyfLJQ9QwjfWx8FaQhNIQrTQ+BTX55M4zEaDWZaT+qktrwXj0gH6x9pkbdeeRiGLuSTQCD+Np62VXPKCPgmRFY2a0t8BZvDXB1lWRHh9iCGyJDsY/6CUsnsAuVsKgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNZW2e57; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749801146; x=1781337146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w6WLLCIyDkM+H9Y+fKHu2fIw2kdSh2hT9Zt18dmsq9I=;
  b=bNZW2e57XC11XdmmLC+ghlwjQGghRGfxmEILeokXcNYXx3lAp1GuWrDj
   UtKHbRqQZ8L+Cm0AjxPUfwwrEodn5b5lxX9DuG9CvAmsZLGcVZo+2yQ0F
   oZQFJKa7UFRY0zDIWGwsIJxdxsjkMmkSKnYTXW4tRm11N8cxTmC2EWCNy
   i2ik6a7U3X81YvKSfmVH6VDUXG6jDZggeIcKVEkmgR+YY0SiSiZVQE84N
   9ckBiv1x83zLq47cZC6oe9VzZ8/O8BZf52TB2lK93mZerlRphF+lRwjy0
   RFSkTX4fI6gweFuN92bOhM3XLUONbCjPx1WGvhBkDFkIrul1XzXKLyLWz
   A==;
X-CSE-ConnectionGUID: +yzqvxoHToCdIUkIykhERQ==
X-CSE-MsgGUID: mS7bWbt5QEaw2P2uVH6ESA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51234309"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51234309"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:52:23 -0700
X-CSE-ConnectionGUID: wWQhLD0OR1icxPrSRuZITA==
X-CSE-MsgGUID: CNsKmgBbTtqwm8f2bzfvwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="178657031"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 00:52:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:52:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 00:52:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 00:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3Y2mMKmDC7TXIDQECJ509dR2hqF0F3Bp7JPaexT5xu2bjYdv3WP4veU/qof4R6LKEuPSRLnyS8Iq8pzPLyY6GXFVdyyidP/YM2tVhXZt4Z1Eym3/fcFWaEtlj/Z6Ae8o8IJlBW82DtsI6G366sd7f4LoI8/0+QmTYeX7Sl2dwgv9xaQBu3tgHJlaz5ZpYXgkMdZgCBcs9FYlcVPNCiK095KHMO1/ITHUPEEl+9h+WT+DfteESZjGIPFzM6JhAznlN8NhPPLdyP7Frdd2s/EKe1Gs/yJSmaqxyf6dPEKZdVRZwZ3R3h+SHQKKmLjLBm6WOEY5+HYj421xFfQLJufUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SufQij5w+lX8naf4lveRVfL0J5mHN00/6i3PifPc718=;
 b=IC504OcTxLr1Inp//p9WLV3weMe/Nh1pkPZyYzdGPB767AifMkv/WarOORICxEF8mNEtNdd2u2dnWEJt6dbHVcIcTcG0V69v4y2mQrBPT5PY1eOcm8bCpGmZxpRM1ldvV9paptWF2exzafmYWAChdXBoTO5kMTmpfoOcw17xJPQPAQEZlhjisQ+s5aiVtKzJBPcufEm48097Fu88nzDmd9o0KVXB0AnY1EwsPo8MzNEOpRUrxpnqQdCo6oPGu0Inho9ZGb7LyPngktVU7WnCRnvCSZeRO4Ma9cYrh6SoXvHGSA2ycca4lFHTEfnkpIhNrx4beSnhQxzh8sVgrD119g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 07:52:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Fri, 13 Jun 2025
 07:52:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, "nex.sw.ncis.osdt.itp.upstreaming@intel.com"
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 01/17] libeth, libie: clean
 symbol exports up a little
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 01/17] libeth, libie: clean
 symbol exports up a little
Thread-Index: AQHb28JVyUjs0lWBoEaABvNpUeWIurQAuJsg
Date: Fri, 13 Jun 2025 07:52:17 +0000
Message-ID: <IA3PR11MB89860787AABFDDEFC24ECDDDE577A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250612160234.68682-1-aleksander.lobakin@intel.com>
 <20250612160234.68682-2-aleksander.lobakin@intel.com>
In-Reply-To: <20250612160234.68682-2-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7638:EE_
x-ms-office365-filtering-correlation-id: 96cd9c02-61b2-44d3-eee4-08ddaa4f380f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?+o9YYDg6Gs+tXXzx0R07R7o9z8LYue519J9CVCX0reqT0XOq8asdbPcPLZF/?=
 =?us-ascii?Q?s6ex1IB9DURbv0YJ0Qkgnws91hf8+pBF3N2ZW55QoTw+QTL1GDC3bO5jz0xH?=
 =?us-ascii?Q?bglkwL1J/wwCnlRhO9xeX1UvmJJYEecYI2rb5gPL8ZOx5KCuvgvYh+Fg0w5G?=
 =?us-ascii?Q?GSre7Z8DY0zAYYmJUvhmO3nUkJ7czNMHem+q75X0OL9CfqsgMnBnHHUHZ/UX?=
 =?us-ascii?Q?6qLTLBZRgNnIDjXA33XSaWggJDMz0y4RV9RhvRCUIly1zRXgPz/FabmKqfXQ?=
 =?us-ascii?Q?UBFYOmpc293CURF8KEVailonEsNffo7kxZKmBnsrNgFpGxI1JV45VlP8Hm5E?=
 =?us-ascii?Q?UaMOTHsIFl5T+fL/xTAuoBssCq3J4dcRo6p8SRfipV+x5jp7SGGCsTCta1zl?=
 =?us-ascii?Q?EFkKLUrL3h9UvRyPEUbVhFOhN52sX+3uIZRBz6MxHSdOYSFuDHMP8Jupti71?=
 =?us-ascii?Q?t7tIfCxqdGvoSbKdACoiFNwKoFhikNKDAKFpE8RNc8gCsPDEp20fpQ3dTdAh?=
 =?us-ascii?Q?bb43lodHQWZewJbmDiWvqAo07tbHNBPKci+PwuLyxPk+5TOz2R8bknyenmAB?=
 =?us-ascii?Q?X2GqDK7TP1tJm4iVkTkj+ntOmYBo8U3Me44xtOUnWjlZ7LB8WzvqRgzXt9KN?=
 =?us-ascii?Q?q78eFU9GTnpyMoS53xNgmkl9fLdfF3Knq8c1062Mlhjrff+II/WMIcC9Q863?=
 =?us-ascii?Q?TynzKekttb3vy1Ngv8WoyDjmqPX5j0iAQbsPV1gAXDMPaveMFuqSudO2LerO?=
 =?us-ascii?Q?IPiGmAMXTDTFpCju48Mc93gnfTc/8GeQQSC9ZvbOpQy6EtgKInaEfDverz0O?=
 =?us-ascii?Q?KZarNQ3kNpio2fDhH+kSJN7kDEefTivtBGrF3nWIyf5f4yn76zUb3BitfGFp?=
 =?us-ascii?Q?yeVjcNIkKXJbCugRt0bEP+MxoInb3tCs046T+5ADKY7bfxKPSQ8GwgKkM1XI?=
 =?us-ascii?Q?ZUKBJ5HxXAP3qMg0eelSqdKTM+zfPJVhLVOWG+OE745sJGGhPsi90DaYWr+6?=
 =?us-ascii?Q?ZTKyUaZtL0DF/6pCswb+vOiSV43mxiupFh/1Agri8hQKRz5g4Nii5wb3B5LU?=
 =?us-ascii?Q?EDqDdka9sBp9Krc4Tu3BTKAVtRtDnyhGLGCF+pqPl5juN462EjiXktFXo26P?=
 =?us-ascii?Q?3LMHa6ybRC3s8Li79UXbPmPSmkn4NVaqfnKWWoK6GMtJqA7zZgon73tt18e1?=
 =?us-ascii?Q?BK/N5eQJr9/XBA8TI8EpERA/rhZq4kK6jPedtlDDKo1d02oDmFo+dHYJ8e0G?=
 =?us-ascii?Q?KavgiOvBdkbJkEP9I3TYhLqMVXaROU2k3zIY8O9keeowsDIiv3cmAuZxS1wb?=
 =?us-ascii?Q?VKCS8Z7HOzvU8tn/3FbBx9nxF5ZfuiL4lv+KmGfa5YGjwtBrNBjypiZ4wqxf?=
 =?us-ascii?Q?aRipgaE4MuF6O08K3nFIA5C/5vMNo9TW1C465Um5yT6FUoFJV/pL6BptQKMR?=
 =?us-ascii?Q?svQEOhbw12wIQM0EDCjto/zw7NxP2D4eizAukK0yM1dB5RDwGFxDig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?01uQnP1EnJ3xym4/br+cZQcExU/mxH9e+XNNbkgCncpkERYNt5DioIpHGHJq?=
 =?us-ascii?Q?EdLkTjdvm/F+F84z+DREE03yxm4eGkukMV3+PRqNpkx7jaWcBy88XF6MdUIh?=
 =?us-ascii?Q?N+nOZaKk8A2bVNrMzX2inX0NCL2aMxzQCl0eN4g6rg4H5Xxsvp/MsLCLG7EA?=
 =?us-ascii?Q?TpjN6d8X+aZr30JQ7vtDSKT7CqQ/5asMyryA+oBLtfucvquCU7EuELPOcypE?=
 =?us-ascii?Q?p1gyOhvwG6MfSEYOkwaTqGgL4H/TKTIUYywnflYjXQOp9qvQJ0nZ2uOTGO+Q?=
 =?us-ascii?Q?5v80+qp6v/G0O7WLtuycKmC8G7eW5EQLTlnSlLhIbISz6WZNZac/jdXapPIu?=
 =?us-ascii?Q?WUOMe/6TwmgXGCV/oHaUkaSxC/YTXXvef5DhnFrAXH77efAnK3WeEZ1BfyHF?=
 =?us-ascii?Q?nCdylP3vZrrTmNKW+mnOTD7mpHV7O/CDAqfngDzPfOT27p0DmhfIdj7Z+cri?=
 =?us-ascii?Q?2JmG1hZIPmVXtiTIlFhwqoSO+11SMv8ji7zW6uMpRQ60gmJ4jt1FuZ6g0tY6?=
 =?us-ascii?Q?wLfWk0krX3i/u7TDU1qKgDlKGOtIEFLIW0krlTPdtz+neDxLrjqLqHMreEea?=
 =?us-ascii?Q?hqc99107GNQCRCbR9eM6fxkrJKBDMFB7irZKIp3+fZuZKXjzIKOH23M1GeU4?=
 =?us-ascii?Q?waJHcoF9AJbj3IjSDmbAtnC4Kxmtfwj46X17QT0rxg8kBIqsMqKg/PiMv+EF?=
 =?us-ascii?Q?Ap27Yj6HEXMn550xa6bLyD9Bso1FiqyJ6hUj+pBhMPQR6+CMXkbGi5hls0Nn?=
 =?us-ascii?Q?tbIXcarkCYR3v/reyqZJzv3t1Cs7+YtlkMBWM29tXxzzX59GC1FE/X63iyQ/?=
 =?us-ascii?Q?I+jDQv4Dh2GURUs4kzr8uDMtGDkKAIHPdHUPaYaLO+w/Wi8qYp3Cg+LQFk/O?=
 =?us-ascii?Q?RnDfwGUkHHawWOdQdqvhGitxgQ1SW/Sen/EdwpK4dOYjyIu/2VqUMXV2Wggj?=
 =?us-ascii?Q?p/LA712f1BtobiPMiuRCrJx49JoKXc9eU+DEEFJ76WCbm6K9ZGDviHb2uBfh?=
 =?us-ascii?Q?KdU0Z96EdHZc/IPlw7O5t18a9a+bejc7LyJRJ4ZakNl+KKMA+9QqRL0DJwT8?=
 =?us-ascii?Q?NvPIhxGQI+E8EETSp0X3RmhecdC1fFE6Yu7l+THWC16hpAH6KZMfhMOCL1tr?=
 =?us-ascii?Q?gSfpdZQ43NiE5VzDNJT1jAbqlzzGdubu0h1MkpXtiMKVwHvV18k8KMMKv9L5?=
 =?us-ascii?Q?h8vVdhNLlCIaZ1IpbjTKnnw4cBA8E/ctAMlmhxwXrZLiklTZk7NMHliQs9IN?=
 =?us-ascii?Q?Be+Rt3iQjqEthhxSv+iBr63Y+r8dS1CXFfeiNewDNuQ6TH9kP+9emBZGSy+W?=
 =?us-ascii?Q?fMI2gbUxIlHyiwwJz2/mOg7AsRIuYJHKbbKetQXubahRpni0sTCOLyuZtrr/?=
 =?us-ascii?Q?VLsJdtQqMY/uc/87g0fZTN7ui7gDi+7GThLbRNf4XgT+rS4D4oaTVrbQspCR?=
 =?us-ascii?Q?yrvWeVMHxXuxSZV8pu9fcevjTYPFxiPFAXyEUXRg4Y4WxnV0yfPHPxYFA7pK?=
 =?us-ascii?Q?/8cBJKipVX80hXEyyMjZjwHFRiIJg23NhrTbgSfvCHDKsAqkbjxI/xqwzhwc?=
 =?us-ascii?Q?3Iqe9jcm6T7HzD9ejHCSzyKOG7pe2kWkaUBkWewETlN6BIoZ5YzfzQ5RRqdu?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd9c02-61b2-44d3-eee4-08ddaa4f380f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 07:52:17.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfOLf7ig6XPwn7JscUqDQqkyLu3lM3BjbHeF3dMkQZkt1F6Xm7DdMeGjKjLd8QXe4xL9VYut7k4QMxpXAsxTNlrrGOLcKAQeDKu4IJCjylA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alexander Lobakin
> Sent: Thursday, June 12, 2025 6:02 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Simon
> Horman <horms@kernel.org>; nex.sw.ncis.osdt.itp.upstreaming@intel.com;
> bpf@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 01/17] libeth, libie:
> clean symbol exports up a little
>=20
> Change EXPORT_SYMBOL_NS_GPL(x, "LIBETH") to EXPORT_SYMBOL_GPL(x) +
> DEFAULT_SYMBOL_NAMESPACE "LIBETH" to make the code more compact.
> Also, explicitly include <linux/export.h> to satisfy new requirements
> from scripts/misc-check.
>=20
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/libeth/rx.c | 14 +++++++++-----
> drivers/net/ethernet/intel/libie/rx.c  |  7 +++++--
>  2 files changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/libeth/rx.c
> b/drivers/net/ethernet/intel/libeth/rx.c
> index 66d1d23b8ad2..c2c53552c440 100644
> --- a/drivers/net/ethernet/intel/libeth/rx.c
> +++ b/drivers/net/ethernet/intel/libeth/rx.c
> @@ -1,5 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH"
> +
> +#include <linux/export.h>
>=20
>  #include <net/libeth/rx.h>
>=20
> @@ -186,7 +190,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq,
> struct napi_struct *napi)
>=20
>  	return -ENOMEM;
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_fq_create);
>=20
>  /**
>   * libeth_rx_fq_destroy - destroy a &page_pool created by libeth @@ -
> 197,7 +201,7 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq)
>  	kvfree(fq->fqes);
>  	page_pool_destroy(fq->pp);
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_fq_destroy);
>=20
>  /**
>   * libeth_rx_recycle_slow - recycle a libeth page from the NAPI
> context @@ -209,7 +213,7 @@ void libeth_rx_recycle_slow(struct page
> *page)  {
>  	page_pool_recycle_direct(page->pp, page);  } -
> EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_recycle_slow);
>=20
>  /* Converting abstract packet type numbers into a software structure
> with
>   * the packet parameters to do O(1) lookup on Rx.
> @@ -251,7 +255,7 @@ void libeth_rx_pt_gen_hash_type(struct
> libeth_rx_pt *pt)
>  	pt->hash_type |=3D libeth_rx_pt_xdp_iprot[pt->inner_prot];
>  	pt->hash_type |=3D libeth_rx_pt_xdp_pl[pt->payload_layer];
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_pt_gen_hash_type, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_pt_gen_hash_type);
>=20
>  /* Module */
>=20
> diff --git a/drivers/net/ethernet/intel/libie/rx.c
> b/drivers/net/ethernet/intel/libie/rx.c
> index 66a9825fe11f..6fda656afa9c 100644
> --- a/drivers/net/ethernet/intel/libie/rx.c
> +++ b/drivers/net/ethernet/intel/libie/rx.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>=20
> +#define DEFAULT_SYMBOL_NAMESPACE	"LIBIE"
> +
> +#include <linux/export.h>
>  #include <linux/net/intel/libie/rx.h>
>=20
>  /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a
> parsed @@ -116,7 +119,7 @@ const struct libeth_rx_pt
> libie_rx_pt_lut[LIBIE_RX_PT_NUM] =3D {
>  	LIBIE_RX_PT_IP(4),
>  	LIBIE_RX_PT_IP(6),
>  };
> -EXPORT_SYMBOL_NS_GPL(libie_rx_pt_lut, "LIBIE");
> +EXPORT_SYMBOL_GPL(libie_rx_pt_lut);
>=20
>  MODULE_DESCRIPTION("Intel(R) Ethernet common library");
> MODULE_IMPORT_NS("LIBETH");
> --
> 2.49.0


