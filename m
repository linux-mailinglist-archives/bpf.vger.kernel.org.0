Return-Path: <bpf+bounces-74947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C7C694E2
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D0F792B35E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CC34E755;
	Tue, 18 Nov 2025 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6346UEt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49863347BC5;
	Tue, 18 Nov 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468020; cv=fail; b=DE8CQdxSnhpeqUAQUNgTqXMfPuH7/rCyAZu4kJzhszj5AXx76KqHRc9Ompl7auQqPX1SfqaXLI41kyhuiYRXvRE+xVeYVCCc8YfyYme+MfZ3XjcdQo439qAOqvQq/Iutx7rjNuCKzeOMOsF/NuPskk8ZUVC3azYivUWT6gKuTyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468020; c=relaxed/simple;
	bh=tJzWRIK9QB9sn09mqA7en+GG+kADMkTfx+5YH/EEukk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsFBk2FCsZqNwQTV3Yy9tVyRfLHarPjRku7ShXWrEIZtWxZZZav1tuhjXcJLiQEJLUSLZ0SI6GyJspz40zw6nFNi+ZmM9b5WDf2AMHOAx9ERQejCWArdnDH9BaJu239t7DbGguIfpHuCCt30eX6fZ45Wb3Om2Ij773VFn1J38RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6346UEt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763468018; x=1795004018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tJzWRIK9QB9sn09mqA7en+GG+kADMkTfx+5YH/EEukk=;
  b=d6346UEtal8Z66SgkScTXqu5qJE3AMbsNZTwX9xCSNjGagA+k7F69gK+
   WpVDDWGUyAFT9J3QAW3oiLr/CTpnA6tOLxQN+9UB7W9FqNv6awVppXcJb
   LQsNl/FWiyhXi2HnWt+bL8OIbSHGwKaDoa6IcKv3l7IPW4hpdZvy7ONtE
   wQC5RgV5uRhOv4m8gJwTm4AK15fVvwvDGKMmcFdUbLBE9F9dWi1Z7kwKl
   ef4m46pS8FgH+/v7zJr0fGyh7GN2PWnBp5u92c6Rd2tQnZTapDvJI1ej6
   cOlyMGWSOw+B+NJFX5kLeJfgIj2wdc97v6VIPC7jj3kgm5ffvrkWXfjg9
   Q==;
X-CSE-ConnectionGUID: 6PbPNzfER52/K3q7NuMaRg==
X-CSE-MsgGUID: qpJcI/BFR1aR9oE6dLoBtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64487745"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="64487745"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 04:13:37 -0800
X-CSE-ConnectionGUID: hwOZ1dVBRqOoYoQ7AVagZg==
X-CSE-MsgGUID: Un7l0+5ZQNqNAl5j2eF8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221402935"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 04:13:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 04:13:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 04:13:36 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 04:13:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS1YuYYe2vCyGy1RC2i+qwO2Celq9C6I99K2uaZYiCLW/jBiKpQas/cJNpamWUIDNzN0LsSW/VchqA4fYKEgqPHtSmVML8r2oVaqBcJHZuTX9ezvYbOUu/ahCEmYjPNkvg/ZXw39COweD731ohX45NfuZdul37Ye4DU/pLFjluff015ZBrY4y+js0Yiz+Phm6CVxa9lxTG/ZZCe7hb/tsQ3zGUDC35AYOT8dB2s5o6gINlWKXPbWbEgs2BMvwfpTWEhhfFiY5kArDbVaHrVKnbfP4UROr9I2PQqiFn6BDgHctMqE8VESq2/+lHn/ATFeMLjAgqxPv8GOBO7PVg6haA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF8NSxb6dKgiKzmkuH5WiLy3N5ftVXcRSAp07D4ZcyY=;
 b=pYtGlFtqxACKO3coU5P1CS8YVQsyL0DTI22YznFsF9qLBjg7syMTnXrIYaHZT0R7IKntqyBJxe5OwOoqIWUgeNdYjKk+uwI1SvfFWUIC3LOcbu8mnctWM2baouq7nybEOsj+RjLyW7DLeDdHhhA7RBwrtoNrtRC+butPmUOeHKiaJCSPFmPJ2l7kbLVF7WajpjkS67PHlk/Mrr0xlD8RCG5Ihx6o56qKjeDwY6V29jhCchVE/ZfJTTI9Dau92qHIXmn9B15Wtphq5Bp2hq/X2CdpAtlbj36P+llBOS1sLV6Uzvp0DIuz/2tIPj2NqfzDxYOHSKuiZ9LusgvxhKr3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Tue, 18 Nov
 2025 12:13:34 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 12:13:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Topic: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Thread-Index: AQHcWH8M0KdIXy3+xEKWlFehiwCRLLT4Vkuw
Date: Tue, 18 Nov 2025 12:13:33 +0000
Message-ID: <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
 <20251118113117.11567-2-alessandro.d@gmail.com>
In-Reply-To: <20251118113117.11567-2-alessandro.d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB7603:EE_
x-ms-office365-filtering-correlation-id: 05980013-d2ca-456f-5a41-08de269be526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zBnotsfSK8MXve+fc1X4s/5cyn1YbEa4502Tzly+fwbIamOSjw1VT2SWRUcF?=
 =?us-ascii?Q?wQ9g/AFLqliVqWuQ7yPdmuY7o022ZaL0L2bmvlD8cjUFEkFj3geaVGrtj7MF?=
 =?us-ascii?Q?PZ2GqUIut8/c4mH2l7cw4v0muPoba9QZ5Wh+YX17FIg5cFv5cd96wINF9VaO?=
 =?us-ascii?Q?AT8bTkmcj0FjroGb3mrZDpEcygE4djedPsFQd8c9+G150PAUJ823QSkrmNeZ?=
 =?us-ascii?Q?DVAJ6FA8jBJj3YvsEsRQ6zzjKduUmxGnr0bTJzsDv036pKEWbGB5bJOQQOtB?=
 =?us-ascii?Q?uk/pbB2xwKCme82o66JnWtoGlSzbiwNJJ4Si6LeKbK9pGzO9Jf3IaWGYupyu?=
 =?us-ascii?Q?CaOfocjmm2gAPHCNaK9YdUjLGTe9Q0QKVL8BoI55Xe7VGpjpgOjHXUguZGLf?=
 =?us-ascii?Q?jg2TesUL89JK+4AbcF1aBti8V19YYaBXIo5mr3Dz0gDBO7q5yKTKLueTk5ST?=
 =?us-ascii?Q?GMJtAOvSnrTzcLjVdubThwzxoinHA+9b+L8vjAtR/aNTykRKLv4yqlk3hRnx?=
 =?us-ascii?Q?fkHo64KZiZxLJoeMxnUg7C7u7P8sNsy8lwcmbKCho3EqwneOB0CNbAeCER5y?=
 =?us-ascii?Q?6yEhbmSh755GVqIcp4Z99o5lZvY0l+hjKUJzyRo8APrjkGnCa4M5uwre2pfT?=
 =?us-ascii?Q?cx7swGQq048uFX52C1zXgnAQ/4ShgK195I7DPZSoK/1HUkYTG6cW0pBPY1hS?=
 =?us-ascii?Q?hGgmvn9JdIu2GdLTMNPrIGhG4fhIcB66976AqT8AR3WfGQNqmMPEXAO+Ntn8?=
 =?us-ascii?Q?6REbY8ERBgmq8J7Nae6AAfFs0Mb1Ij93dCkwPubJXqW2HN6FEccs2UFw8ubM?=
 =?us-ascii?Q?nHRZCtO8MADwAT+kjdmVoFujwncHgvlhi1UP0e9YSIp/BZD1WrJCulkHZXCK?=
 =?us-ascii?Q?sGhfKuPUkagMn2TxQuXH9YlWwoiam/LYgGa5VjxGK3fzBKo68lvOmHD8TuOn?=
 =?us-ascii?Q?E1n41Sl10iICvGQ4//pnU6S7+HMN2VQPKukU66GX6qPB9SUvHki/Id6pV8D9?=
 =?us-ascii?Q?tuPFlEd77ENijdABD5SOr6MdCQ9zxPk+xbBgOyIouVtepOR/iIrauqs8rVnz?=
 =?us-ascii?Q?i58v2iK4zLp58aFayfYlRYFrVgnnA3+Zq3w5El6GiDf9n8j410qkebMGcyJd?=
 =?us-ascii?Q?1/pvx4LyOrvh6i5IeTbeTq0yQbg0u/8emyEbZeYjDvpthHXQGpei8AqueRgW?=
 =?us-ascii?Q?d97keI6zFkUTY/xbbgzizaLTSSz3KqAviYtkBmUsB/hmqjLFlF/N7Pr3LGAB?=
 =?us-ascii?Q?r41ZNK+EdUqK7FTpFO+8UzRCf2nRRBaaiGWqyUGOYQF2EilF/Wa2BYhWaBup?=
 =?us-ascii?Q?prUpqXSSvSPrR5wLTKufu4fO4H4LVMdqjIFC50W5NhS5iYtPDVS5ch0mksaK?=
 =?us-ascii?Q?I6+4CCYayE70GmT8MKyu5Hkg9ltk0Vgs3PxbtSsepr8qoi4808Jvq//lkcqN?=
 =?us-ascii?Q?qEMHF/uDinO6s3Vbz5fWJ48iG9deWKayOnLuuDztbmgrE2ssrA17l9i+hzRC?=
 =?us-ascii?Q?6y5UkrcRvSBGSvXMNvMa8MkkR7QBMqq8Woos?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IWanE08YFiDgC8x/O9X8GpUacMd+GhoKvvduphetRk12yPCZvNsI6brGTGca?=
 =?us-ascii?Q?wHLu50tmy1YXpJwBEDrE9zI9pqRcDnA6dcNMBfJI5kcWmDW2imjNIRFsuXWT?=
 =?us-ascii?Q?+S2ha2sT2nl6MrK1JfZR53fWi89wkUEy42WrBizPc43y/lR19+F5UGyoASTa?=
 =?us-ascii?Q?TYkL96sal6IYt2oKSCPf7Kl1LkXtnlsYIiNsrt90m+ohI4eedUMjAuqgIorN?=
 =?us-ascii?Q?7OXMRsN6eYztKH9xFWv1cIctbZ2LhlyyHm8Zw/nsHYJEVYjnv64WNAeMVmrF?=
 =?us-ascii?Q?Q1XKa8heufHetgPJI3P5vuz2QPHgwGKaozFOFdgTwYfR1FecqcRx73UGYVh0?=
 =?us-ascii?Q?yp+kAbvJGe7Gj+4L/+BFrjDbBtNxbQ1mVZksMmlfwvazvGF4zPL6+9BPqYLo?=
 =?us-ascii?Q?g2mvMxsWeF6wGoVN+uh4j4Yhu9ZG2xzJeC9oA/tjCzCJAjrcVvIMv2HCi0yu?=
 =?us-ascii?Q?JmP7g2w6ZQeJlqELiSw/iUJBLh53KdM2yHydoJ+96zMqXoUFKbf6G9fdtOOc?=
 =?us-ascii?Q?chGJLoQXF6Jq0pqtLNOV6c8DU3DpjNwyHcx2MRlP0rn4NNnc99IUs8R6mYjH?=
 =?us-ascii?Q?n0VFdqKNqS1LilB4LJKJs7L6o0s6OGaJ9fUxDk11kEaxDQdOrFUu/ot7tnZU?=
 =?us-ascii?Q?+KHDzwpY1aoVh/M86v/mbNSEaeddmKM62JAhwFSx3ooARb8+jmq5jHcI8C74?=
 =?us-ascii?Q?GhjgK8eiWHRPegRbbd6o4wEk745Wu6dsdYweXDUh7E6S0aEkudCoLSDqSmS3?=
 =?us-ascii?Q?IcdU3+0lJH2XBmkk0B9HEkVbTxCdCNYZJG5w0dXodANEdJE/iKjXVjbmkFT5?=
 =?us-ascii?Q?pv3HHsz8ujutEqSv4v3u9Vr6YTbIBtNDhJ8UlcOx0FrKm37rm5qRjR+vPkoz?=
 =?us-ascii?Q?3rrDgyFZVIkeAPXXJuNq7yukWVVOZppNNaadvNzleKxgWvWvOU+6m9Q6l2SW?=
 =?us-ascii?Q?pTcjRnwGTChDPx/Jfetc24KAUC/YxA5fsQ0pG63yKN24Y9q/GYPFbp+vuTve?=
 =?us-ascii?Q?kLQVBrjT9/k5fR9OXkQ5yg4VG+Mdh5basOz3oFja61VgVy4iB4z+wN1XLf8J?=
 =?us-ascii?Q?JbkWWdT9DSgoMd4R0csYuSk/wMgA9ku/8/DdZZR4spR+Ra+rAf06RHkqMA92?=
 =?us-ascii?Q?YGM3QjrVe8sIPAD10CmzflVa6KI4CVbunQEax4nd+gwuCPrObnUwRPNhQhjW?=
 =?us-ascii?Q?fJysbrUEcVnMv71qdwpuT6QyO9vAbiHpFe+Td0qr7s71jozg3l6IOUOnk3nq?=
 =?us-ascii?Q?zT9YWvR12MUabqe+ZF2YZV+xcQERFl5/okSpcXv2zsVht3ILoyAYnhlPleuf?=
 =?us-ascii?Q?VlZ6WJ1AcB1neTlunMfiz8uL7DjcwM0AeJOkZmYx9+FWA8W8PnU16tu4fcho?=
 =?us-ascii?Q?OGubleCYBjj5BPXzxnn5uR56zCeUreYigbqz1aowmx5ZMaeMs5+fZY3VkmBa?=
 =?us-ascii?Q?SX+xckage7rx+Ls6/H5B3Ep7jsE9OtS/ynygw8Ve0ztEaYLbUYGmW4YbLrYy?=
 =?us-ascii?Q?HJl+Aa70nFh3KcUGO1JKiIAxGo4qWWHXFtq0pCz74FXYEYmi5+ycfGkmuxMw?=
 =?us-ascii?Q?R/2tqJyIv4qHlQ1QujWjKhfSubKcX+qvXQm7w+mkEMSVekHHoec5OURV2Bbs?=
 =?us-ascii?Q?fQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05980013-d2ca-456f-5a41-08de269be526
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 12:13:33.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8bluh9IO6hIU/zHnGGHCIlYKj5A9CwaBXYZPSl6UcmaEgjU+1u8Mh069pD6ONGpYm0RvR4gBGu20s/dsw93bmatUHT14/30WZ9iorJszQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alessandro Decina
> Sent: Tuesday, November 18, 2025 12:31 PM
> To: netdev@vger.kernel.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; David S.
> Miller <davem@davemloft.net>; Alexei Starovoitov <ast@kernel.org>;
> Andrew Lunn <andrew+netdev@lunn.ch>; Daniel Borkmann
> <daniel@iogearbox.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer <hawk@kernel.org>;
> John Fastabend <john.fastabend@gmail.com>; Paolo Abeni
> <pabeni@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Stanislav Fomichev <sdf@fomichev.me>;
> Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; bpf@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Alessandro Decina
> <alessandro.d@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
> next_to_clean on status descriptors
>=20
> Whenever a status descriptor is received, i40e processes and skips
> over it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
>=20
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
>=20
> [ 5866.367317] BUG: unable to handle page fault for address:
> ffd31c37eab1c980 [ 5866.375050] #PF: supervisor read access in kernel
> mode [ 5866.380825] #PF: error_code(0x0000) - not-present page [
> 5866.386602] PGD 0 [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI [
> 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted
> 6.17.0-custom #1 PREEMPT(voluntary) [ 5866.403740] Hardware name:
> Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025 [
> 5866.412339] RIP: 0010:memcpy+0x8/0x10 [ 5866.416454] Code: cc cc 90
> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [ 5866.437538] RSP:
> 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286 [ 5866.443415] RAX:
> ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1 [
> 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI:
> ff2dd26dbd8f0000 [ 5866.459454] RBP: ff428d9ec0bb0d40 R08:
> 0000000000000000 R09: 0000000000000000 [ 5866.467470] R10:
> 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8 [
> 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15:
> ff2dd26548548b80 [ 5866.483509] FS:  0000000000000000(0000)
> GS:ff2dd2c363592000(0000) knlGS:0000000000000000 [ 5866.492600] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5866.499060] CR2:
> ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0 [
> 5866.507079] PKRU: 55555554 [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e] [
> 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e] [ 5866.526022]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70 [ 5866.535623]  ?
> srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800 [ 5866.551493]
> __napi_poll+0x30/0x230 [ 5866.555423]  net_rx_action+0x20b/0x3f0 [
> 5866.559643]  handle_softirqs+0xe4/0x340 [ 5866.563962]
> __irq_exit_rcu+0x10e/0x130 [ 5866.568283]  irq_exit_rcu+0xe/0x20 [
> 5866.572110]  common_interrupt+0xb6/0xe0 [ 5866.576425]  </IRQ> [
> 5866.578791]  <TASK>
>=20
Commit message lacks test description.
Please add how you validated the fix (kernel version, NIC model, reproducer=
 steps).

> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>=20
> Move the common logic to i40e_clean_programming_status and update both
> i40e_clean_rx_irq and i40e_clean_rx_irq_zc accordingly.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++-------
> -
>  .../ethernet/intel/i40e/i40e_txrx_common.h    |  5 +-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 14 ++---
>  3 files changed, 42 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index cc0b9efc2637..fe2190f4b9bc 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1386,22 +1386,36 @@ static void i40e_reuse_rx_page(struct
> i40e_ring *rx_ring,
>   * @rx_ring: the rx ring that has this descriptor
>   * @qword0_raw: qword0
>   * @qword1: qword1 representing status_error_len in CPU ordering
> + * @next_to_process: pointer to next_to_process index
> + * @next_to_clean: pointer to next_to_clean index
>   *
>   * Flow director should handle FD_FILTER_STATUS to check its filter
> programming
>   * status being successful or not and take actions accordingly. FCoE
> should
>   * handle its context/filter programming/invalidation status and take
> actions.
>   *
> - * Returns an i40e_rx_buffer to reuse if the cleanup occurred,
> otherwise NULL.
> + * Returns false if what is passed is not a status descriptor.
>   **/
Please use kdoc Return: tag.
Kernel-doc is incomplete, please also document what 'true' means (status de=
scriptor processed).

> -void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> qword0_raw,
> -				   u64 qword1)
> +bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> qword0_raw,
> +				   u64 qword1, u16 *next_to_process,
> +				   u16 *next_to_clean)
>  {
> +	u16 ntp =3D *next_to_process;
>  	u8 id;
>=20
> +	if (!i40e_rx_is_programming_status(qword1))
> +		return false;
> +
>  	id =3D FIELD_GET(I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK,
> qword1);
>=20
>  	if (id =3D=3D I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS)
>  		i40e_fd_handle_status(rx_ring, qword0_raw, qword1, id);
> +
> +	if (++*next_to_process =3D=3D rx_ring->count)
> +		*next_to_process =3D 0;
Consider using u16_inc_wrap() instead of manual wrap.

> +	if (ntp =3D=3D *next_to_clean)
> +		*next_to_clean =3D *next_to_process;
> +
> +	return true;
>  }
>=20
>  /**
> @@ -1971,19 +1985,18 @@ static void i40e_rx_buffer_flip(struct
> i40e_rx_buffer *rx_buffer,  }
>=20
>  /**
> - * i40e_get_rx_buffer - Fetch Rx buffer and synchronize data for use
> + * i40e_prepare_rx_buffer - Synchronize the buffer for use by the CPU
>   * @rx_ring: rx descriptor ring to transact packets on
> + * @rx_buffer: the rx buffer
>   * @size: size of buffer to add to skb
>   *
> - * This function will pull an Rx buffer from the ring and synchronize
> it
> - * for use by the CPU.
> + * This function will synchronize the given buffer for use by the
> CPU.
>   */
> -static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring
> *rx_ring,
> -						 const unsigned int size)
> +static struct i40e_rx_buffer *
> +i40e_prepare_rx_buffer(struct i40e_ring *rx_ring,
> +		       struct i40e_rx_buffer *rx_buffer,
> +		       const unsigned int size)
>  {
> -	struct i40e_rx_buffer *rx_buffer;
> -
> -	rx_buffer =3D i40e_rx_bi(rx_ring, rx_ring->next_to_process);
>  	rx_buffer->page_count =3D
>  #if (PAGE_SIZE < 8192)
>  		page_count(rx_buffer->page);
> @@ -2450,6 +2463,7 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>=20
>  	while (likely(total_rx_packets < (unsigned int)budget)) {
>  		u16 ntp =3D rx_ring->next_to_process;
> +		u16 ntc =3D rx_ring->next_to_clean;
>  		struct i40e_rx_buffer *rx_buffer;
>  		union i40e_rx_desc *rx_desc;
>  		struct sk_buff *skb;
> @@ -2480,21 +2494,15 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>  		 */
>  		dma_rmb();
>=20
> -		if (i40e_rx_is_programming_status(qword)) {
> -			i40e_clean_programming_status(rx_ring,
> -						      rx_desc->raw.qword[0],
> -						      qword);
> -			rx_buffer =3D i40e_rx_bi(rx_ring, ntp);
> -			i40e_inc_ntp(rx_ring);
> +		rx_buffer =3D i40e_rx_bi(rx_ring, ntp);
> +
> +		if (i40e_clean_programming_status(rx_ring,
> +						  rx_desc->raw.qword[0],
> qword,
> +						  &rx_ring->next_to_process,
> +						  &rx_ring->next_to_clean)) {
Wrap the call to i40e_clean_programming_status to stay within 80 columns.

>  			i40e_reuse_rx_page(rx_ring, rx_buffer);
> -			/* Update ntc and bump cleaned count if not in
> the
> -			 * middle of mb packet.
> -			 */
> -			if (rx_ring->next_to_clean =3D=3D ntp) {
> -				rx_ring->next_to_clean =3D
> -					rx_ring->next_to_process;
> +			if (ntc !=3D rx_ring->next_to_clean)
>  				cleaned_count++;
> -			}
>  			continue;
>  		}
>=20
> @@ -2503,8 +2511,7 @@ static int i40e_clean_rx_irq(struct i40e_ring
> *rx_ring, int budget,
>  			break;
>=20
>  		i40e_trace(clean_rx_irq, rx_ring, rx_desc, xdp);
> -		/* retrieve a buffer from the ring */
> -		rx_buffer =3D i40e_get_rx_buffer(rx_ring, size);
> +		i40e_prepare_rx_buffer(rx_ring, rx_buffer, size);
>=20
>  		neop =3D i40e_is_non_eop(rx_ring, rx_desc);
>  		i40e_inc_ntp(rx_ring);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> index e26807fd2123..21d9ed878bf0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> @@ -7,8 +7,9 @@
>  #include "i40e.h"
>=20
>  int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring
> *xdp_ring); -void i40e_clean_programming_status(struct i40e_ring
> *rx_ring, u64 qword0_raw,
> -				   u64 qword1);
> +bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> qword0_raw,
> +				   u64 qword1, u16 *next_to_clean,
> +				   u16 *next_to_process);
Argument order differs between header and implementation (next_to_clean vs =
next_to_process).
This will compile but is misleading and dangerous for future maintenance.
Please fix argument order to match.

>  void i40e_process_skb_fields(struct i40e_ring *rx_ring,
>  			     union i40e_rx_desc *rx_desc, struct sk_buff
> *skb);  void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..f8accc266c2c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -440,14 +440,13 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> *rx_ring, int budget)
>  		 */
>  		dma_rmb();
>=20
> -		if (i40e_rx_is_programming_status(qword)) {
> -			i40e_clean_programming_status(rx_ring,
> -						      rx_desc->raw.qword[0],
> -						      qword);
> -			bi =3D *i40e_rx_bi(rx_ring, next_to_process);
> +		bi =3D *i40e_rx_bi(rx_ring, next_to_process);
> +
> +		if (i40e_clean_programming_status(rx_ring,
> +						  rx_desc->raw.qword[0],
> +						  qword, &next_to_process,
> +						  &next_to_clean)) {
>  			xsk_buff_free(bi);
> -			if (++next_to_process =3D=3D count)
> -				next_to_process =3D 0;
>  			continue;
>  		}
>=20
> @@ -455,7 +454,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> *rx_ring, int budget)
>  		if (!size)
>  			break;
>=20
> -		bi =3D *i40e_rx_bi(rx_ring, next_to_process);
>  		xsk_buff_set_size(bi, size);
>  		xsk_buff_dma_sync_for_cpu(bi);
>=20
> --
> 2.43.0


