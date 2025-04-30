Return-Path: <bpf+bounces-57075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4DAA52B7
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705041C063F1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95D264F9D;
	Wed, 30 Apr 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiNQLpas"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7525F980
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034658; cv=fail; b=RTeAxN2qYlH9W7FIv9tRVnRwrWv3EFQzz3Ww5r+RRjAb0NRN7KCzFcL2rj0+CCSz88XHM7vRsMjMcfwo6/hesMKn3WPwG0+eklx1qWqaa6eNJ0+z8G0Da9I6OETnF3t5DXx2rsRtNJuZMBtEvE8xBYucmRUWKV2iD1fXJ0wkVLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034658; c=relaxed/simple;
	bh=Wf3dV2DkxF8RNn54/EUdxh2v3hAsHqbDJmF1IHxtdCs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rw0KIxHhughPVxHf47h8xLAwQ/AtIjELOBn57+wgBsMocUofMO8LR30jeHrwcm/vyBwU+M7PpEI6pK04hXfxTjX9ZOrEX6/HWsYbrWiRYiZkP8/OBWJj/qt0mpvoleBEJqM74ITKPebhvnrYfy/gx5bGGVvMMu/GY8M/IIIjkKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiNQLpas; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746034656; x=1777570656;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Wf3dV2DkxF8RNn54/EUdxh2v3hAsHqbDJmF1IHxtdCs=;
  b=CiNQLpaszhsebzp2SgfDZDacTN3yGUEZyNDmzBPRWab2o6RGOcjjLDTZ
   TPwY8HmJVmke7CYwc2Zov2jaFzQR1hN0VcznwHakrHmOyfI3LilL+VYiu
   HD9ZBuuUiG0DmxCu26MgwITfXx2CJd9XjDb4+Kx9I/XE+v2b9p77xJxOX
   9TpkWkJX37RVTxyg6EISjjiJX+wNJdEi/a4uVM4oKA/CcwsUo5sHax5DR
   H+nx86FQ7K4VXtH52gCkbLuS/u9pKgDCiU6yd1i89MJZeEnWpHojav37x
   A97m3YVOJxuEhOz8/aPW7Z6mn+TG1ImPzlTtJrFcg+qDthOE5hdoZspJg
   g==;
X-CSE-ConnectionGUID: 6/NayDcvRDKkNmhnxc7c2Q==
X-CSE-MsgGUID: 0GYm/cI4TiaZSgZF9XDBJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51372875"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51372875"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:37:33 -0700
X-CSE-ConnectionGUID: Y9FL2PA8RDOE++tmowjo3A==
X-CSE-MsgGUID: riM9wpvISuKUftUvZaQtSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="165109600"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:37:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 10:37:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 10:37:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 10:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSFT1Aasc5l/7EYg6vtDJ6oXhADdCP+2uuHDc+EX+f2EYcwFrNZLfDnZcZLogan2XGwzpSVEpt+3lSAN7MA/+SoNHdLTEQaVzXJgn+mSa4srGT2o3NbLZcs1w3tPdB4WhLWIV3QhdZomJoSrVDY1zePHiyDoJjA/xHoMxrdIIkdxcw0HuFmBlhBHqEYu6zVnrxJZE0lDu0Q0b/LoUe4gbxt4cJgMTWPPW0VnMQQvNTmJNAxGnIfPRTUfUQKlGq/kTPL+ITsS9VmR6C5p6vtTSh5rqhfMOd+Tp3HWWxKRwEjG33s4Hi4DsJLm4yBYxLgiZ9ImzW0UzkLPKUNONw+quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Diem7OaE30IxNxxYTHG504nyp5yvI8Umtp/r/V12W0=;
 b=sDnzoF16PvywK5kuUtwNvSRQfrSSWEa81IqRSczDAsYovDEh+yr+enf5ZUPAxzQDTiPfQgGiWVpAnTikwSYoRh5NzOCZqgh9qrciNBrFlAb9gVBylCkUqaAVLZgYBHyNgqIthO1+k4jRcK8+F8yt1NYqviEk8asxLqczdToisZyOXdGTh/v0Bo+O7OHCxWqxhlnbRf8Du11T0jSVjL629vLENDoZJ+jtx//bVD/bR+Z6dIypqen8j5q7YMyySDzsT+Uxyt7aBIdBnOAYaJ531s8A1UbfyQrv3NHhwZ9lUksFPrv3G79rCgXgN1vxFlakOUCP2J+38VyK0F6LjxDXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10)
 by IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 17:37:13 +0000
Received: from PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547]) by PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::fffc:36ac:37ac:1547%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 17:37:12 +0000
From: "Preble, Adam C" <adam.c.preble@intel.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Looking for feedback on kfuncs for dentry_path_raw,
 get_dentry_from_kiocb
Thread-Topic: Looking for feedback on kfuncs for dentry_path_raw,
 get_dentry_from_kiocb
Thread-Index: Adu59cWMECpSFptnTYiCDPRb074Pbg==
Date: Wed, 30 Apr 2025 17:37:12 +0000
Message-ID: <PH7PR11MB652381F4B833B4B5CE2AEABAA9832@PH7PR11MB6523.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6523:EE_|IA3PR11MB9302:EE_
x-ms-office365-filtering-correlation-id: 2c5baa73-63d0-4bb2-e1f6-08dd880da444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oI3FUD5YRV59RC39FFyBFDvdDgfJxzBc2POM/wL2LDK+SDQa7z5t379qvzxu?=
 =?us-ascii?Q?ERTiRaV9zBTValLRBSLJLFDS8jMDTvA2kwBV7X2fPjG3ttmeiwEQ+iae9CNq?=
 =?us-ascii?Q?bOC0kvt8OV7hbHAoqDTb9QkMWhz9pU/75DrKrZXmysL1u/3tgySmh0s/q7Ov?=
 =?us-ascii?Q?SlIGLIw6C/6LWIMovWUMsSfInbiJn+iU7pKwPd9SbWR8wpJGVTQv9eNg85sr?=
 =?us-ascii?Q?0BYakxProAOB8+UJR0YL4fiIFbXodEG/BFZnn1EHLwDpDhYaMFyZMeojP3EE?=
 =?us-ascii?Q?5xcY+cy4D2+DwhXQ0hPgF5PtlCgU2DBejxjBuVQGW54FqCJw4wKmrLtL0SBi?=
 =?us-ascii?Q?gz/aoC93tagOM4IwwmpuOyU12DIg/2eb3QGTRmYzxiyagQ591CmX01D16jQA?=
 =?us-ascii?Q?j+Yf/oEJ7qRTlcDSmkeNHd6X9KGY994mPNmM5i+jBFOaBLX8wwmNfM3PIiOt?=
 =?us-ascii?Q?6i/Qj1eduGCXhQmLpTjOftJ3FRZNobmhmZJuehzniPIKEtz8mBdYdc6CTKyT?=
 =?us-ascii?Q?d71FwPUHtvt0kKya7XOSW61J4fvKbTogDNldORfikfhP03HriKoLdSy47ER0?=
 =?us-ascii?Q?zLA/3FJbH7ICEmdstq9M8kP1/3EbHD0+ZJc8WTFL18MWFyQmf2u79ocvQueH?=
 =?us-ascii?Q?5kN/C6GC247GLwPltG+SZDBJoRIUiDSdRbS9BdqXqVvbK5ZYrvnF2tz4T79d?=
 =?us-ascii?Q?ksi/nuJJ6lP+eDqCPDqCsL22IpJ8uNKSD/ETdp0NoWyQf7CjqM55yEmxuKjR?=
 =?us-ascii?Q?zzXBQ7bBUvMv1uWV6PqKH50qWnvuWchNwFEfOr7xYnldNrqNrLU0v+83IIxe?=
 =?us-ascii?Q?KucWu4u0SnnzOs8ZIaM2xWhdVn8Y8tfTA8BbhYRgNCd5GejZCmJgG8Dxn2w8?=
 =?us-ascii?Q?DtMTh2osgb0MazI8ZzXXX/BuqAsRNl53FKkBXPLYwRv9kmprf4JEp/tnXlqQ?=
 =?us-ascii?Q?XXOGhP5uf76yg8eswhgv9vkamIMYZubHLCBiZR/TY+u2zfn4FmB/qQBVJP++?=
 =?us-ascii?Q?4a4atRFyu63rDw8aGkVg+W1x8T+NF/vXYnWgMYUHKl76w0EOWt4khbinckkf?=
 =?us-ascii?Q?o3QODIsu8Xi2PPQoKBATZmNHXv0xS+M9TMsLCBPIph1lPghmDySXqYp+HP6a?=
 =?us-ascii?Q?M6IsnGR8Ctg0yBCxTJ1vHbrOy+pmnKKUJlHNPWEfHssYlZ/hiztruAyXPzKo?=
 =?us-ascii?Q?HwFvvf/jFqsty1YEJ6hdmg+RGkmEUVcil8X+vkOdcw4vyXP+Aag4gC6kWvPP?=
 =?us-ascii?Q?HWodbgdnzZ9DsNsUW2+rGa6TSsjkDMfW4jtgrM8dFyeCHeRFVKUjLTq8mRQi?=
 =?us-ascii?Q?KnSsXVqwZWQg21liHFAN4dl9CmrMY7YVim3E0bBuXYCwBJLgFZm63w3X1LXh?=
 =?us-ascii?Q?CqnqhW5iO2Q3aUcYkz5VdNgvWT7QbQV1DWSNzr+PaD1kpahPCCq8h8bzRvJt?=
 =?us-ascii?Q?RBOC1Z65fwCQ808+PkdmXQ53fMF35GRhl2dczB8XqW2zgjjF8Wc+iA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+MbqM4I4SJfWZ7qqOisqF5HDE34jYJ2+GTliwslW7tk0OkxTW9JFjvpmYl/?=
 =?us-ascii?Q?XUrJ4x2SVGOyReclYfOOkRT2RawUbuLPCk7oXzYZhoYbCD/umWZvjTMieg+a?=
 =?us-ascii?Q?3Z2FvlgLSC6V32IBmUkqqJD3R+OtYf3Snj4SGERrIbQr22r3aZm4DlCI3h59?=
 =?us-ascii?Q?reRU4Ghp30AQmuslP5fDKBvwbzN9HwdHVlLZyMNsKD3KtaAOGF0Y7Pdc1wGz?=
 =?us-ascii?Q?b9RtPwFXYA65fo31kUCWXg5ZxDZcOe06CpwqZeHvynFKaSI4PLZHbyoKtfib?=
 =?us-ascii?Q?bdkxj4EHTtjEbbRUlgHPOXEF9TQ1QhPeoEnKLMEZjDzeW3NctL0fEKYtH5go?=
 =?us-ascii?Q?zCtUlg+p29xtfBnfSDm94rJmhmOq3v9DQJ+CCZo59/64Km+msq+WVC8WvM3U?=
 =?us-ascii?Q?L3fhIa0danMeAOqLr0ONKLQV1tNqLjmQURh9WSfl7WY4om2GwVQn60Mlfj4L?=
 =?us-ascii?Q?oWL9nxvS4fmHTWUzOlx1aOIplN2quRX7wRPox6mjkJCNQpo4vA8hcqvg8/7H?=
 =?us-ascii?Q?4wLtKlklOSCmLIsnnHPsTXnpglWaAZo38II8kXk4P2lUQUV7vTu1FbIiAhUM?=
 =?us-ascii?Q?eKtS7J1nEtSqlkdIsTsY8mAkV+yBbG3k+LZ718eGBGNw1UYhszSWMbbt4wVF?=
 =?us-ascii?Q?Gekw2wJIy3i8j1aXcbBhtQx/GXeaHztfc40ZhJG9uyE7VyTy2PTwuIKjaOFd?=
 =?us-ascii?Q?1uhcrZhLeB26k2FDHU6YSrxmCn52yHN/CdKNeF9CquhG8adoywHtSOZzBAvZ?=
 =?us-ascii?Q?Zky8tC9uK20kbaNodXPJy7WrdPC3X2hO7giCuaiObPC8xkKR0KWimylgwwtv?=
 =?us-ascii?Q?XRBXRYiFhb/2Vn3smVFObiNffT/DJ1KXiJfnxeY6w2Pj1bdjuV57TEwkKJxt?=
 =?us-ascii?Q?tH358bZwQgguRyzzzcaQOkrV1FhPYg54U7WBmAb/0NxmeciVx/ahvSJ+vhaj?=
 =?us-ascii?Q?szFcyahr471sFUwgRxARP45V16P7299P6z63T7pBnRcHYq1nd7CkM1D6UqCk?=
 =?us-ascii?Q?RsFZacF+fzt4ftBFj1BEQoMpkGj/Xhf+pYdcCItOSI0/LUu+pltCRlZRgxwI?=
 =?us-ascii?Q?971flntUqZd1+DwsbBZLOR9L5PdIlvb7DkOmW7ierzaOr0KLNBpJHbXmltIL?=
 =?us-ascii?Q?I6hzxjWOYvkFfee1kj9u4mz9YsnRIA4MwMLU+inVSky6aVI1O4i7cGm4u19K?=
 =?us-ascii?Q?qyp7PekZGuRTxYNzYbzdxXW0ZAmZ3oiBTv3PD/keN7HFyY94pu6kjPM6NX2L?=
 =?us-ascii?Q?nnQCWnXS4YOLGrtoLMCzhnMiMjcrTN8riMMyYql+FZ4ppDIU5EwAZY/lggv2?=
 =?us-ascii?Q?bSj6nKedo+SA6+EMZAwL5HjGCgb0lefs7P6v448zPIScT445Aa1o9R6o27JA?=
 =?us-ascii?Q?k3gVTLGThvTRK6sZOCIicq/o2h3xyLn79yH3uRtcvT5ZYSlfdygNBSPovy1J?=
 =?us-ascii?Q?Fl470R79HX1kfII0d6XdN/xVUkqWruk3rzhtYsZB/EkZ7RCIPRmuisrtEk7y?=
 =?us-ascii?Q?Skk+I7fig3Mxy3sZGf0FyOPfcQ8tEfqotSsiy5w++t2FkZH0tHuQpRqIytHl?=
 =?us-ascii?Q?x/qIWZeXBy7XVWG9grQSSVqJNSGqFgfbzo1+96Mj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5baa73-63d0-4bb2-e1f6-08dd880da444
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 17:37:12.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+4oLzmyHaPUjqIt8bxoyPnGgcbE8umGUNGOftTNL0F5/rqEW1c9Qv+Eal14Cm41BYw8RNi8mKc0sRR/+WD0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9302
X-OriginatorOrg: intel.com

I was trying to use an eBPF script to dump all paths being created, opened,=
 modified, or deleted. I hit a wall when I couldn't figure out how to extra=
ct the actual path from anything and figured exposing dentry_path_raw as a =
BPF-accessible function would do it. I was thinking of sending this code up=
stream, and I've included a patch, but I figure I should ask some questions=
 first:

1. Is this even the right place to be asking all this? I assume the d_path.=
c maintainers would also have a word or two (probably linux-fsdevel), but I=
'm focusing on if these kfuncs are even sensible.
2. Actually, could I have gotten the path from something without writing an=
y new code in the first place? I was kprobing various vfs_* functions that =
would give me a dentry*.
3. What's the etiquette on ignored pointers? I'm designating the dentry* as=
 an ignored type.
4. Should functions like this hide behind a build configuration constant?
5. What would be the proper workflow for formally submitting it as a patch?=
 Is this mailing list the best entryway? I expect actual file maintainers h=
ave final say, but I wonder if other people get brought in for BPF stuff.

This patch is based off my work on 6.13, but applies and on 6.15 (based on =
8bac8898fe398ffa3e09075ecea2be511725fb0b). An allyesconfig build pukes at t=
he vmlinux.o creation because 6.15 is really big for some reason, and it do=
es that for me regardless.

From 2c8b5d111ad7c75f41b4c1ff330b1c856e535632 Mon Sep 17 00:00:00 2001
From: Adam Preble <adam.c.preble@intel.com>
Date: Tue, 1 Apr 2025 18:15:31 -0500
Subject: [PATCH] d_path: BPF kfuncs for dentry_path_raw, get_dentry_from_ki=
ocb

We were trying to extract paths from dentry records when using a kprobe
eBPF program against the following functions:

vfs_create
vfs_rmdir
vfs_mknod
vfs_symlink
vfs_link
vfs_unlink
vfs_mkdir
do_mkdirat
generic_write_checks
notify_change

Most of these functions take in a dentry pointer, with
generic_write_checks taking in a kiocb pointer instead. We expose
dentry_path_raw and bpf_get_dentry_from_kiocb to extract these paths.
---
 fs/d_path.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 5f4da5c8d5db..6487eac09596 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/bpf.h>
 #include <linux/syscalls.h>
+#include <linux/dcache.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/fs_struct.h>
@@ -368,6 +370,58 @@ char *dentry_path_raw(const struct dentry *dentry, cha=
r *buf, int buflen)
 }
 EXPORT_SYMBOL(dentry_path_raw);

+__bpf_kfunc_start_defs();
+// The dentry argument needs to be ignored because the verifier can't veri=
fy
+// the integrity of the pointer coming in from kprobes.
+__bpf_kfunc char *bpf_dentry_path_raw(struct dentry *dentry__ign,
+                                     char *buf, int buf__sz)
+{
+       char *retvar =3D NULL;
+
+       dget(dentry__ign);
+       if (!dentry__ign)
+               return NULL;
+
+       retvar =3D dentry_path_raw(dentry__ign, buf, buf__sz);
+       dput(dentry__ign);
+
+       if (IS_ERR(retvar) || retvar < buf || retvar >=3D buf + buf__sz) {
+               if (buf__sz > 0)
+                       buf[0] =3D '\0';
+       } else {
+               // dentry_path_raw starts at the end of the buffer and work=
s
+               // back to the beginning. We need to bump it back to the st=
art.
+               memcpy(buf, retvar, buf + buf__sz - retvar);
+       }
+
+       return retvar;
+}
+
+__bpf_kfunc struct dentry *bpf_get_dentry_from_kiocb(struct kiocb *iocb__i=
gn)
+{
+       struct file *file =3D iocb__ign->ki_filp;
+       struct dentry *d =3D file->f_path.dentry;
+       return d;
+}
+
+__bpf_kfunc_end_defs();
+BTF_KFUNCS_START(bpf_file_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_dentry_path_raw, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_get_dentry_from_kiocb, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_file_kfunc_set_ids)
+
+static const struct btf_kfunc_id_set bpf_dentry_task_kfunc_set =3D {
+       .owner =3D THIS_MODULE,
+       .set   =3D &bpf_file_kfunc_set_ids,
+};
+
+static int init_subsystem(void)
+{
+       int ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_de=
ntry_task_kfunc_set);
+       return ret;
+}
+late_initcall(init_subsystem);
+
 char *dentry_path(const struct dentry *dentry, char *buf, int buflen)
 {
        DECLARE_BUFFER(b, buf, buflen);
--
2.34.1


