Return-Path: <bpf+bounces-56027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA0A8B162
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 08:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC53719041C3
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4523BCF7;
	Wed, 16 Apr 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDARp+Y5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C083231CAE;
	Wed, 16 Apr 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786521; cv=fail; b=a8iyonkyH2U9BGsjkVDYRChPVg2mpop5Pt2FztsfWbwsnWCcGslZWfgXHsZlvupXWhZoMHJC4TyQgdtrIxY5twEATZzBc2QibA7ikqcSuZijX8FX4qFfw8FtowmBMi80jE2uVzs3ORFXQgmvkN9hFyf+7dMMc6pwQu8qfBzI1No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786521; c=relaxed/simple;
	bh=Kri7+JDfFdNTuMUOy/zkceYwglMoALUnVyKAPZEL9EY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bK8Pxqn7sj2YzwaUkYjBa3cEAv7bs1jooTJWXfFeRBRyMERIuROsUiwPd+Ytxos0CcroZPmG/g7gzE9HTLAczYUoclnPV+hjcmwtXjI4bWXHstTZUDDYpNnuqf9d61L1LLhYg0XxnJZlCFBbCigekf7ZRxv/rJPs1ML3ivhLAI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDARp+Y5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744786519; x=1776322519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kri7+JDfFdNTuMUOy/zkceYwglMoALUnVyKAPZEL9EY=;
  b=lDARp+Y5GPkV1a3rCgekz+GD7b8MMimsAGEWG1Ib+VIH6fNtqavQ2gEu
   huu1STaMC7nek6I+EOPsHp9CpndTNK3l7Z4VTFbioXfq89kkQyBndgoHu
   v+DnTAP28ZRBPXuUNT+VlBut1kNh7TtgPwNocMD3dK4K++nGZDYAz2Fa2
   Tq/tKecdGxECeHP9jzrWB/1iNmC9gfh2wnzcKj14yelreMDsnxrkF0ywd
   2eo/DulqyJG45hxeZsQt+oz4uLxE1QjJ6aTaLXA/DGw4SOFChOPejZzVK
   D8EuJ1xlD3h7Wx+Zm3rWQVkyv8s0tOWQIRn2Vpz/KFyOWSusKCF0YtyLz
   A==;
X-CSE-ConnectionGUID: KrEijQ0XSeels6lQuQC+NQ==
X-CSE-MsgGUID: Bo2w+k7IRf+g24GZP9RV3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46240602"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46240602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:55:18 -0700
X-CSE-ConnectionGUID: 14L0F+FDRM272rMgLeEJoQ==
X-CSE-MsgGUID: r/lGqPDcQW+U0fkqjIMXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="131263885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:55:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 23:55:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 23:55:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 23:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf2Wezv3AYuCZdgPgRzpoRB9Z/q6uhVbT8g1MIPujjWHBPT9b64eqqWVEXsq+V50YfihIX9CbhFPUZyMj5tiziTSzxCfTB2fjuCazpdVXIv4/pQ/TKrFoQ84BNiFt/ueJIwtH1GQOxqebU7P63Lo8Fo8RWqLAw5JvwBbcn8fYoXzcvoDEtJOqab/65SH+kgZrMhyGOjNvA3KP/IkyI3G04xpKiZygthPLbWvTiKwK5fXtTKBNxeWTXg+JntnsOj6k8VJFjzHhsNsRtO9N5uo482gr5+UmEvKFH/c0nEJKt2Syw000DeLS1Q0jx6VhFlf45UOJP6Ucv8Mg4exh2pszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PofXvbOfdCTd0W21PTK9xE4Qh4U4BgqOzHuabjbM6FA=;
 b=Zc3nL4Cp/70MkloAop52EmYBqwUAAK4SJNIFZYq/0mcJ+QBC1nO8s6PVJkFshAMZBfmzHzVmNWPXcCyPzJC+C31t5YDWOibpEszlsivtDErB6WpH0XdPzrA5twazeCAeiguu/tbFIuYp/bRgOpX4TSZv6eDCI+wp97NADme1+qlKP+g8py2NQQLhfqXjfaF622zZxVHSULRjl35oVbX+cl6coHFFjgyZogBQJrIdD0S2tRM3bcB8f0CnzGxkRJdLRP1MoUpTUJ0w7edg5tPQNQ9xtKnHraHqEj5ZNiaBy/zR3/4nsBzJzb1/34/CWKKcmDjQQ3ffn5C9OBFKqVmTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 06:54:40 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:54:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mina Almasry
	<almasrymina@google.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 01/16] libeth: convert to
 netmem
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 01/16] libeth: convert to
 netmem
Thread-Index: AQHbrivs845r3kkl7U6rchf8fWL8BLOl25Bw
Date: Wed, 16 Apr 2025 06:54:39 +0000
Message-ID: <SJ0PR11MB5866A2B6D3DD4BF861DADB2BE5BD2@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-2-aleksander.lobakin@intel.com>
In-Reply-To: <20250415172825.3731091-2-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MW3PR11MB4697:EE_
x-ms-office365-filtering-correlation-id: 30aeaa81-018c-414b-1aeb-08dd7cb38f34
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?BQZGptlBWZN+GQlTzjYiUwjCjue8Ra2r5ogIT3nDaDFTZhU+bYfiCmQSxJCe?=
 =?us-ascii?Q?JBFKrBQ4im4RY+/lNvh3wEK0AjydSuYxV3fxMrM4lvUhUfe7hBlIhXaPGBjf?=
 =?us-ascii?Q?y3DWNRbxyCPjcNJWsaSTyYlLH9sTBX9YAvtzc5tRt1ayZZlWIemvpBlX5DG7?=
 =?us-ascii?Q?Q4DHObBlwd4QQX0UG3UzQ7qyLF0zVwKDyiN7UYyMi8nZkf6S3ybNx3voT96X?=
 =?us-ascii?Q?szhPRcFfFbmyByW4XDSsV1g8fi6jTxtYU2fMtlYdAx3K3VTZivmCt4AvjX5e?=
 =?us-ascii?Q?7CBo4w/F6eHdm1D8MG+WkFLc2fjHLWSui36QNCEnyxsbVSg9DDpGm478PQdU?=
 =?us-ascii?Q?5YbfzvWpTMU4iNmYv6+67zvGyYsJ0DQMxzDEK6kgHhKdkY45UAS2G9IBNwh1?=
 =?us-ascii?Q?6xqPdApkTTf+kEaJVNyTiAiN4lOV8/ZcgY7QpFb/EcoBp7W6SekfnFSdWh2B?=
 =?us-ascii?Q?kcIoiev/QckYKaylgNNCBzZ7BqQa84o2fSQJFmfkgcJWK9NY3n1IW9zOMvcc?=
 =?us-ascii?Q?2GQvxqCD7HQ8RIkfOYEOSXit8oErVtU+y+dDLFGW4Qk0PJn58avQW22q3wNi?=
 =?us-ascii?Q?nin1pxnCktpGKibtRQB/4vmCYqPP7ty+dQe1m2HPjwidz3fdHjoEOnjSHpIe?=
 =?us-ascii?Q?fkkoa+KI7+gwdWH5+PDGfH3pE23CRr5lAlSLstef3DvOaxIKjeX3WGoXNEQN?=
 =?us-ascii?Q?SFJClWL3RCCTf6xBxwVA3cbFKzQI0mQYbSmZ+3onfHR/0Y63DHDZM/ioH4uG?=
 =?us-ascii?Q?7se/jiJtO8Dvhclxq+HGVvl5qA9LmeieBnpksuqF58i9yMQon7m2xsdUyhHd?=
 =?us-ascii?Q?Dsey3MByUIV+ZtNKyTr4MayGg12bz5UGI/MV8vMVJUOHvPL/h6f04zhxo7kT?=
 =?us-ascii?Q?rKlAYHDA7PzIBi/joAhuZXL9uiKjUja5ssEutH5Z2gbQ+hnFvjX2/bcol0tX?=
 =?us-ascii?Q?Q1GL0ND+5zhk4x60NiXOQSoxEbjE2ERrOyYveGEn9l+e4zLp4q4beTLlEIE7?=
 =?us-ascii?Q?qDjXsTeyOSbB49/1luZoJTc44P3ATQPk4sxpml3fovWzhOgUwrMPapixGVXE?=
 =?us-ascii?Q?n0S9wvU8HxdV8vpEmK0B6ZvpZNeCe7XlEkiV7R5XCXHi8AH49UC1O7Zo83Ky?=
 =?us-ascii?Q?8oXSmySut7y7EIUv0T/LrQ5iURAqAec7AH+pJaGYBesMQhnZBE9gJQx3jPuQ?=
 =?us-ascii?Q?fstdTMGgvmUcsElMvVwN0M6MC0xCjWEr5hGcg4vZSzm31pT9brbxb+bI6+mE?=
 =?us-ascii?Q?YkNv217vx6R0eekLVio1a9zVPjVgoT595hkknHaKP/MV4iE/IRFLA+fWJGSh?=
 =?us-ascii?Q?N9rgK0++kNic4CW5vP32vjQu24uphiTuUIs/Z0a9rhUqFniFAAtwlcvMIzD0?=
 =?us-ascii?Q?tm36e0tvkU0FWNyt23ycwL+B0p+rU+TTLx+SujnHA0vIgWx7cwykUhrXzxWR?=
 =?us-ascii?Q?fOY70dggud3jEmjhOLXAI9vZeH8MDPjNVnrC1JYpxlVuvfX0YeLY+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xzxz5BiFBYeWoqaEuxf6yrODlvJeEqKw5jbM/8IWb+uNXVJTcbsG5rKmYGFL?=
 =?us-ascii?Q?olgFzh5LyQ1XUdTm1GEmkZuPZP3AFtshTjWVz7tKQTL47MOozCyFlGRn7hBW?=
 =?us-ascii?Q?MSuf1964Eruqd6ztrW8Glsto52F+tNR4wvzNKa5GUbRwr93iocbv1tLRHd65?=
 =?us-ascii?Q?bW/pddPq+W78KAxTpExpC45KY+VN6piDK2Sh/XOoFRrN3h7b7fyePh3wlLdm?=
 =?us-ascii?Q?ewmxoifSNzNhtaaXCrVsYxY+DhVZELOJSFzq7KIZdNmA5jGBjqntmZSG7Ilh?=
 =?us-ascii?Q?DTEqLTMIUe9KsDAI6YOGj9FBP0NwWBaMg1Mq2Tc8IK8qojT8z2UVtaCqolp0?=
 =?us-ascii?Q?qvneZYDN83fGEyYUvOuYIA51ayVjnzpTEkK143Z+pRiPaA16wL6MnR1/Wv5A?=
 =?us-ascii?Q?i1vMcNFdeGKr68O/pyOtBIfdDD5BtSAz9iIXiisizlCL9T5KRRjHwinR5uW+?=
 =?us-ascii?Q?yjWPN3SjJDPefQNwgZVYXQdXS+4ouJj4vcYECZ5zMNlQepekXRlLXLT/bIEu?=
 =?us-ascii?Q?2wR/vq3id32pvOLwS4F/UUCxdapKHckYX8cIA82fU+JsFD9WRyKw+jeHk8tL?=
 =?us-ascii?Q?6NCaJ/AK8kdmaei7PETxxU2gWtaXTivULj3w6E7DFBg7dmyCNti1A2TaBd3U?=
 =?us-ascii?Q?m52uajxIaYttCCttmz3gtXCUJ7HGJv4ss8i3XZb7Csa0amTlAR77Kk9IpLxV?=
 =?us-ascii?Q?t8N3CzzxK1+ya92FXKlqumeLjYovSeR3dsog9KUPEH1aIKWwQGYME5mk5Sg8?=
 =?us-ascii?Q?EiQGwb8eMsT6/y76oh5dAEMwFBsQJeQRUF3/uUIfUtOKUpLJLpCohwu6bWlB?=
 =?us-ascii?Q?5+aMvNkZXv8ee4nGxxVi6ZaTDcCUqB0SAL6McsIc8XQ8ET5MlQHAXgbaZVXC?=
 =?us-ascii?Q?CbefYsqkUmwwWvnXBETVBsvQp1XIJTl0167XnmS3CPpipPtOnVCGduLfBTli?=
 =?us-ascii?Q?rZLsS/4vI48P9czUVECazwfucXptxZipJuaMJyKYb5Wq1yoGE+P2LPFwqPMR?=
 =?us-ascii?Q?Jvt2u3lBEwa6Mh9IOupqyX00xrZiKAp8320xTumURO9e3KRpRYsOHtSKtE3E?=
 =?us-ascii?Q?+Mu/ro6hr5LQXdJ8fH9zOYCfmZndpX42pFUDHFgHpzVDA52iYbqr+7Wuu3eb?=
 =?us-ascii?Q?yFGPObxAMBfWHqJb9N+EEBOftTv+7MD4zkU1mSz8PWiHGMXqxVMhwMyeCewM?=
 =?us-ascii?Q?HSiryx+251M3g/f6gT8WQDf9LTU9Bu+YPT7bQMYvnURxbx6DmCf7hoNgMfEM?=
 =?us-ascii?Q?wdEAlRX6eY8qKmNLZBArkVG5ljAA2/n8xj/SE21UPhj9MPFoUjRt5wZbfPmQ?=
 =?us-ascii?Q?bqIFEP02ROqVkjwSBCr31tZziVfNIEExaFYjM4jNwI/4+4MEfDpx/EpUs/rd?=
 =?us-ascii?Q?FNBHOIEamfifshEYS3nquvlwYBXr2gyuBgbkpsftIYg6Fb4Y/Vh7sSLlZhZm?=
 =?us-ascii?Q?WLJkIwkiN1LhF6ytvDzQ3rkcL32mSMclC0ZmhuaRlPerDYI3C34B8jQRyxPF?=
 =?us-ascii?Q?3NHigEHlzx1mKkLFVx86KsEA4sszyb4XANRg80jdnqQ+2CqMHj7QQgtnWe+W?=
 =?us-ascii?Q?u9F7/yIJJQo5Jw4hLvP7RMYndcglte21g2D6t+1OtP6LUU67NalUoHpoudnI?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aeaa81-018c-414b-1aeb-08dd7cb38f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 06:54:39.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T24WXBzYH8D+GvPc9cGTPq9Oc45GkBqyScObe9mHHGrmWn71qEytUiIr4TzO1MTbkCYyTGkNPWjDShyw9oFtngjt2HqgsEXYzZd09jSfvmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Tuesday, April 15, 2025 7:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Dumazet, Eric
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Simon
> Horman <horms@kernel.org>; bpf@vger.kernel.org; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Mina Almasry <almasrymina@google.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 01/16] libeth: convert to netm=
em
>=20
> Back when the libeth Rx core was initially written, devmem was a draft an=
d
> netmem_ref didn't exist in the mainline. Now that it's here, make libeth =
MP-
> agnostic before introducing any new code or any new library users.
> When it's known that the created PP/FQ is for header buffers, use faster
> "unsafe" underscored netmem <--> virt accessors as netmem_is_net_iov() is
> always false in that case, but consumes some cycles (bit test + true bran=
ch).
> Misc: replace explicit EXPORT_SYMBOL_NS_GPL("NS") with
> DEFAULT_SYMBOL_NAMESPACE.
>=20
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/libeth/rx.h                       | 22 +++++++------
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 14 ++++----
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 33 +++++++++++--------
>  drivers/net/ethernet/intel/libeth/rx.c        | 20 ++++++-----
>  5 files changed, 51 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h index
> ab05024be518..7d5dc58984b1 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
>=20
>  #ifndef __LIBETH_RX_H
>  #define __LIBETH_RX_H
> @@ -31,7 +31,7 @@
>=20
>  /**
>   * struct libeth_fqe - structure representing an Rx buffer (fill queue e=
lement)
> - * @page: page holding the buffer
> + * @netmem: network memory reference holding the buffer
>   * @offset: offset from the page start (to the headroom)
>   * @truesize: total space occupied by the buffer (w/ headroom and tailro=
om)
>   *
> @@ -40,7 +40,7 @@
>   * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
>   */
>  struct libeth_fqe {
> -	struct page		*page;
> +	netmem_ref		netmem;
>  	u32			offset;
>  	u32			truesize;
>  } __aligned_largest;
> @@ -102,15 +102,16 @@ static inline dma_addr_t libeth_rx_alloc(const
> struct libeth_fq_fp *fq, u32 i)
>  	struct libeth_fqe *buf =3D &fq->fqes[i];
>=20
>  	buf->truesize =3D fq->truesize;
> -	buf->page =3D page_pool_dev_alloc(fq->pp, &buf->offset, &buf-
> >truesize);
> -	if (unlikely(!buf->page))
> +	buf->netmem =3D page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
> +						 &buf->truesize);
> +	if (unlikely(!buf->netmem))
>  		return DMA_MAPPING_ERROR;
>=20
> -	return page_pool_get_dma_addr(buf->page) + buf->offset +
> +	return page_pool_get_dma_addr_netmem(buf->netmem) + buf-
> >offset +
>  	       fq->pp->p.offset;
>  }
>=20
> -void libeth_rx_recycle_slow(struct page *page);
> +void libeth_rx_recycle_slow(netmem_ref netmem);
>=20
>  /**
>   * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA @@ -
> 126,18 +127,19 @@ void libeth_rx_recycle_slow(struct page *page);  static
> inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
>  					  u32 len)
>  {
> -	struct page *page =3D fqe->page;
> +	netmem_ref netmem =3D fqe->netmem;
>=20
>  	/* Very rare, but possible case. The most common reason:
>  	 * the last fragment contained FCS only, which was then
>  	 * stripped by the HW.
>  	 */
>  	if (unlikely(!len)) {
> -		libeth_rx_recycle_slow(page);
> +		libeth_rx_recycle_slow(netmem);
>  		return false;
>  	}
>=20
> -	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
> +	page_pool_dma_sync_netmem_for_cpu(netmem_get_pp(netmem),
> netmem,
> +					  fqe->offset, len);
>=20
>  	return true;
>  }
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> index 422312b8b54a..35d353d38129 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> @@ -723,7 +723,7 @@ static void iavf_clean_rx_ring(struct iavf_ring
> *rx_ring)
>  	for (u32 i =3D rx_ring->next_to_clean; i !=3D rx_ring->next_to_use; ) {
>  		const struct libeth_fqe *rx_fqes =3D &rx_ring->rx_fqes[i];
>=20
> -		page_pool_put_full_page(rx_ring->pp, rx_fqes->page, false);
> +		libeth_rx_recycle_slow(rx_fqes->netmem);
>=20
>  		if (unlikely(++i =3D=3D rx_ring->count))
>  			i =3D 0;
> @@ -1197,10 +1197,11 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
>  			     const struct libeth_fqe *rx_buffer,
>  			     unsigned int size)
>  {
> -	u32 hr =3D rx_buffer->page->pp->p.offset;
> +	u32 hr =3D netmem_get_pp(rx_buffer->netmem)->p.offset;
>=20
> -	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> -			rx_buffer->offset + hr, size, rx_buffer->truesize);
> +	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> +			       rx_buffer->netmem, rx_buffer->offset + hr,
> +			       size, rx_buffer->truesize);
>  }
>=20
>  /**
> @@ -1214,12 +1215,13 @@ static void iavf_add_rx_frag(struct sk_buff *skb,
> static struct sk_buff *iavf_build_skb(const struct libeth_fqe *rx_buffer,
>  				      unsigned int size)
>  {
> -	u32 hr =3D rx_buffer->page->pp->p.offset;
> +	struct page *buf_page =3D __netmem_to_page(rx_buffer->netmem);
> +	u32 hr =3D buf_page->pp->p.offset;
>  	struct sk_buff *skb;
>  	void *va;
>=20
>  	/* prefetch first cache line of first page */
> -	va =3D page_address(rx_buffer->page) + rx_buffer->offset;
> +	va =3D page_address(buf_page) + rx_buffer->offset;
>  	net_prefetch(va + hr);
>=20
>  	/* build an skb around the page buffer */ diff --git
> a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index eae1b6f474e6..aeb2ca5f5a0a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -1009,7 +1009,7 @@ static int idpf_rx_singleq_clean(struct
> idpf_rx_queue *rx_q, int budget)
>  			break;
>=20
>  skip_data:
> -		rx_buf->page =3D NULL;
> +		rx_buf->netmem =3D 0;
>=20
>  		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
>  		cleaned_count++;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index bdf52cef3891..6254806c2072 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -382,12 +382,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport
> *vport)
>   */
>  static void idpf_rx_page_rel(struct libeth_fqe *rx_buf)  {
> -	if (unlikely(!rx_buf->page))
> +	if (unlikely(!rx_buf->netmem))
>  		return;
>=20
> -	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
> +	libeth_rx_recycle_slow(rx_buf->netmem);
>=20
> -	rx_buf->page =3D NULL;
> +	rx_buf->netmem =3D 0;
>  	rx_buf->offset =3D 0;
>  }
>=20
> @@ -3096,10 +3096,10 @@ idpf_rx_process_skb_fields(struct
> idpf_rx_queue *rxq, struct sk_buff *skb,  void idpf_rx_add_frag(struct
> idpf_rx_buf *rx_buf, struct sk_buff *skb,
>  		      unsigned int size)
>  {
> -	u32 hr =3D rx_buf->page->pp->p.offset;
> +	u32 hr =3D netmem_get_pp(rx_buf->netmem)->p.offset;
>=20
> -	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
> -			rx_buf->offset + hr, size, rx_buf->truesize);
> +	skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags, rx_buf-
> >netmem,
> +			       rx_buf->offset + hr, size, rx_buf->truesize);
>  }
>=20
>  /**
> @@ -3122,16 +3122,20 @@ static u32 idpf_rx_hsplit_wa(const struct
> libeth_fqe *hdr,
>  			     struct libeth_fqe *buf, u32 data_len)  {
>  	u32 copy =3D data_len <=3D L1_CACHE_BYTES ? data_len : ETH_HLEN;
> +	struct page *hdr_page, *buf_page;
>  	const void *src;
>  	void *dst;
>=20
> -	if (!libeth_rx_sync_for_cpu(buf, copy))
> +	if (unlikely(netmem_is_net_iov(buf->netmem)) ||
> +	    !libeth_rx_sync_for_cpu(buf, copy))
>  		return 0;
>=20
> -	dst =3D page_address(hdr->page) + hdr->offset + hdr->page->pp-
> >p.offset;
> -	src =3D page_address(buf->page) + buf->offset + buf->page->pp-
> >p.offset;
> -	memcpy(dst, src, LARGEST_ALIGN(copy));
> +	hdr_page =3D __netmem_to_page(hdr->netmem);
> +	buf_page =3D __netmem_to_page(buf->netmem);
> +	dst =3D page_address(hdr_page) + hdr->offset + hdr_page->pp-
> >p.offset;
> +	src =3D page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
>=20
> +	memcpy(dst, src, LARGEST_ALIGN(copy));
Can you avoid 'unstable' API __netmem_to_page()  usage? For example:

- dst =3D page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
- src =3D page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
- memcpy(dst, src, LARGEST_ALIGN(copy));
+ dst =3D netmem_address(hdr->netmem) + hdr->offset;
+ src =3D netmem_address(buf->netmem) + buf->offset;
+ memcpy(dst, src, LARGEST_ALIGN(copy));

>  	buf->offset +=3D copy;
>=20
>  	return copy;
> @@ -3147,11 +3151,12 @@ static u32 idpf_rx_hsplit_wa(const struct
> libeth_fqe *hdr,
>   */
>  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size=
)  {
> -	u32 hr =3D buf->page->pp->p.offset;
> +	struct page *buf_page =3D __netmem_to_page(buf->netmem);
> +	u32 hr =3D buf_page->pp->p.offset;
>  	struct sk_buff *skb;
>  	void *va;
>=20
> -	va =3D page_address(buf->page) + buf->offset;
> +	va =3D page_address(buf_page) + buf->offset;
>  	prefetch(va + hr);
>=20
>  	skb =3D napi_build_skb(va, buf->truesize); @@ -3302,7 +3307,7 @@
> static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  			u64_stats_update_end(&rxq->stats_sync);
>  		}
>=20
> -		hdr->page =3D NULL;
> +		hdr->netmem =3D 0;
>=20
>  payload:
>  		if (!libeth_rx_sync_for_cpu(rx_buf, pkt_len)) @@ -3318,7
> +3323,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int
> budget)
>  			break;
>=20
>  skip_data:
> -		rx_buf->page =3D NULL;
> +		rx_buf->netmem =3D 0;
>=20
>  		idpf_rx_post_buf_refill(refillq, buf_id);
>  		IDPF_RX_BUMP_NTC(rxq, ntc);
> diff --git a/drivers/net/ethernet/intel/libeth/rx.c
> b/drivers/net/ethernet/intel/libeth/rx.c
> index 66d1d23b8ad2..aa5d878181f7 100644
> --- a/drivers/net/ethernet/intel/libeth/rx.c
> +++ b/drivers/net/ethernet/intel/libeth/rx.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2024 Intel Corporation */
> +/* Copyright (C) 2024-2025 Intel Corporation */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE	"LIBETH"
>=20
>  #include <net/libeth/rx.h>
>=20
> @@ -186,7 +188,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct
> napi_struct *napi)
>=20
>  	return -ENOMEM;
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_fq_create);
>=20
>  /**
>   * libeth_rx_fq_destroy - destroy a &page_pool created by libeth @@ -197=
,19
> +199,19 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq)
>  	kvfree(fq->fqes);
>  	page_pool_destroy(fq->pp);
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_fq_destroy);
>=20
>  /**
> - * libeth_rx_recycle_slow - recycle a libeth page from the NAPI context
> - * @page: page to recycle
> + * libeth_rx_recycle_slow - recycle libeth netmem
> + * @netmem: network memory to recycle
>   *
>   * To be used on exceptions or rare cases not requiring fast inline recy=
cling.
>   */
> -void libeth_rx_recycle_slow(struct page *page)
> +void __cold libeth_rx_recycle_slow(netmem_ref netmem)
>  {
> -	page_pool_recycle_direct(page->pp, page);
> +	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
> false);
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_recycle_slow);
>=20
>  /* Converting abstract packet type numbers into a software structure wit=
h
>   * the packet parameters to do O(1) lookup on Rx.
> @@ -251,7 +253,7 @@ void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt
> *pt)
>  	pt->hash_type |=3D libeth_rx_pt_xdp_iprot[pt->inner_prot];
>  	pt->hash_type |=3D libeth_rx_pt_xdp_pl[pt->payload_layer];
>  }
> -EXPORT_SYMBOL_NS_GPL(libeth_rx_pt_gen_hash_type, "LIBETH");
> +EXPORT_SYMBOL_GPL(libeth_rx_pt_gen_hash_type);
>=20
>  /* Module */
>=20
> --
> 2.49.0


