Return-Path: <bpf+bounces-75173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036BC75177
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 16:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CC173315BF
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BF359FAE;
	Thu, 20 Nov 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEdlXDe5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE962359717;
	Thu, 20 Nov 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653327; cv=fail; b=JtU7NQBVP/Ng0JcK9slurfdZ3nxsXEq/qjqfc4MOPeFwK4tdxfPBlZXHDVsbxAs50sb4G/ACtSP5EhbRsSNf0+Bxa4yOdCalIHdvoizzafSlecfAW+UV3Jv/GYJml+6t4N/0ayWAP6ERfcVUsYG40DSxZ/ebgE0LZ+hzCvbf6go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653327; c=relaxed/simple;
	bh=0U5fkBij30gKUzfHmfOD69P53B6dB77U7Hb86PVsSAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bLVGNT8aOBUynCEh3CNXQDk9cqaYGu1RchzCWMojcjhFIgXto+JKK/bt8xHlj+uWHUB4clucNv07IDJd/dWTGTIgaQ5XVNkiAvzmuI2p1Zjam9fYpJF+bDychxcY3eRgaYtUFr0moOxT6LWdiq2vYtaCcnE5pxYG/ilS8D2QAMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEdlXDe5; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763653325; x=1795189325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0U5fkBij30gKUzfHmfOD69P53B6dB77U7Hb86PVsSAo=;
  b=KEdlXDe5JhrKPrc1PqC/m91B6D2MwQbnE/R0C8m9SXIbaNAvg6urcMqt
   +xVnP57zPu8CjxukNLAImJIfcRVNWt18QN8PJXxBjXeewDqb+udUncK4M
   9BX0qG5QUo/AoT1TKl1NFdecJs7XtlSXVy6XWEESSI5NtdYC6//LHQ+/x
   5mXfOKFOTIX2+JeMP6W89MQaTgOsMtDhckvQLtxpcbwNGt7VgD/aD5wdw
   8thUsSYbwKaQ2WkvzWwZ10iDpAV0lqwCDu4C/kuGx50oKAByQ2/WyuxRB
   3fIo1G9dAZ6JYLuSDB50iMSCKywUzOV1jO71G3HQw0vCuRdTmZ22i/bcD
   g==;
X-CSE-ConnectionGUID: 8u/wxVGIQT2se4BTFAXc2w==
X-CSE-MsgGUID: T8EumIdHRK6beSzeG+Or+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65621070"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65621070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:42:03 -0800
X-CSE-ConnectionGUID: 266fN7WARFqqHAKHOp63Yw==
X-CSE-MsgGUID: yPJUzScZR0mfhjFXBTDYOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191654039"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:42:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:42:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 07:42:03 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:42:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My5tVtkk4UmBI5Tsgd9ZZOQZacsDOm8TDNBh6AM+zLkxwukoPIQEU9qWu+KFeNhNevk51muPlhbBKKz9N7u+zHGK/6iZQ7RH3Rtq3+hXuSpE6STr7Bw8fe104zrixy3l52hvryFbrAKkU42JgvyqXLT1BjdD9tk0+NbrusGpr0qa4ASaLqXqVpCLvtc9/l/PswF3eLUklA/lHOIH2w+DcvFDkAUg1iS3O8xwo6UScYvn+NRu5tX21C8d1QX+p32laILK1Wk9H5QqeaMvF29b7cQgH8fjzeMIEPBn0rXxTBUZnP1XY+bekhjI2C2fVAwgb9sO3jkc6Bfh9ThQTrhysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jkb7ABMH24puvw4WLFylERjDcFlvxTmO/23C5rHrO8=;
 b=CUzqfbHEVMQC5EP8EIENicOEmfD9ji6RCpPbv4pJKd8VmLy12UUo3iUGN/mUZ7m/HyOd5AqYpEOdPcrty1hW2gLeacnxUFa7C+arQzfieBBvOYDiuGy+ij+NxfelHqzpZ0LeiqidCXSSGBBhf3fMG9yk0aJ/PrFZsX6C3iLlHTIaNxset9nsPQKXfyVycQPWdROmt9DAcxm4qTnA082/3ZbvdGOMhOL07YqOwB0SQfluUE7EklTK/BICuk4Y+aZy8i5uWKh9qbh1l8j37IFQoCgtyq+w2ZmrJ3vMeMzJkETXDUa05LqBYmtgmtJnYg8sP/3NOF6/0WuSfz5qBqDF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 15:41:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:41:57 +0000
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
Thread-Index: AQHcWH8M0KdIXy3+xEKWlFehiwCRLLT7tvAg
Date: Thu, 20 Nov 2025 15:41:57 +0000
Message-ID: <IA3PR11MB89862528ED688EFF82B0FC25E5D4A@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6523:EE_
x-ms-office365-filtering-correlation-id: 0c15063b-e2dd-428f-34ce-08de284b56d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fgsDDQtmkp4fyaBxeDbsPdHnHmAGVXUjY/dA7xtEnWDbgW0HMKFQcjCv8bVC?=
 =?us-ascii?Q?kXOab+UHbrTQFI7TI7z3Es74iYpfnx/gh6nM6B0JV9tCiI+9EvJSICnX9+wZ?=
 =?us-ascii?Q?4WsEC8LuGz9qo7elB5fOmn1nhcNRUciPsMN0oJlBL872dsfLu00gePzpCgkC?=
 =?us-ascii?Q?CFe56yt4alpt4jj/EOwgrnh+AA0wVkndB8PG5v3SCxQG3gpbg3TkrjSItc0y?=
 =?us-ascii?Q?+ByVWxy2h+UY/rC1DBxf35wdU9+2xHq9bNAV5f9mLn5NkMoVylXUPjFzyo4x?=
 =?us-ascii?Q?B1ZF2XFZ0grNwTjwAConjqydTCNbV/WE+MX0abCPDX83AC49azMMq2s2mcsl?=
 =?us-ascii?Q?xLzSwFG7VX2F6JNYj8+rmnhIguH/Lf58EAGyGwCHRX9DhhI5MKitjSlH4KkD?=
 =?us-ascii?Q?TE0A1wOzCyYnoEwzS9HUVgFT0a7bETR6hseC7hGKlziqr4KXTjBAKhm6H3ln?=
 =?us-ascii?Q?aki1g1H609CCMJIy5Kj85DekWRRUiE62DZmOL+ZuZjgOS393gkwfgBW7nUoQ?=
 =?us-ascii?Q?7uCSbPE8CGhYh9slSlsF7znyCfJonWK5Sp+w8HANM7Vaqu3jdcG8+siFPel/?=
 =?us-ascii?Q?3iUKVtGt1cW/O4RaEX6mgbRUnT/3c/9qzfw3cEwXl8PGDToosnP8oC1bVPPu?=
 =?us-ascii?Q?9QJQczR/GUA8TV2vxr7h3I5FE2nKk+9qgcdynaNUnDq3R3KyXHZfw6U+JyzT?=
 =?us-ascii?Q?pjaoJaVrgNAASw3GrYXgGupJRZKw+1eNLNwWyOOJF/wttSIC4jXC4cSWFc9N?=
 =?us-ascii?Q?IPdRw+9SkbTeMO8UlbOlM3kkwGvlbP6upAhwa1UUG84pqrH0lgAZfHs6oxVG?=
 =?us-ascii?Q?Hs+woS2BcY7i9VTwCuOgljZEFTPHHTBmRSzko8UU+ZPy9NPCi/4UOStTnqD2?=
 =?us-ascii?Q?rR+/Kb7vPLXsps48tnbhy7FCv4xXY1vWcYEDcPtWd4ZpxP1hUsaQAzzBBlaW?=
 =?us-ascii?Q?1yJQ3EjqyJxHf1zbgDApckMSx646Wgpe8pgMDhdqv2t4C60zgw6TajE9ShQt?=
 =?us-ascii?Q?jT2Gs9iJikgmsRl2tIC4yQkzp2DRXDxH/puR4iZHYSMNi7ZHxhvJWa7Z0PdL?=
 =?us-ascii?Q?6li9e67Zy/MIbE0P22HgMh12vmluu1UalMyqWEb2EkJd5FW52NFMRkf/7BnP?=
 =?us-ascii?Q?O6Ls1uuFISChKk4UsMkopexSLhNXIQ4O9cWWzTlmtdAT4kcXGP4KcQ8ZhNgX?=
 =?us-ascii?Q?pawZD4xPUUXk8/nl38iIC2E2wtN3yFFBK0002GhoQmjuXK4l4nNF9yEQKiEV?=
 =?us-ascii?Q?8C/OQett9GhWWomWGoFft11dipAkzBKpkyoBoDpBdjCpOLi6IcNyuq3+FpVo?=
 =?us-ascii?Q?vOBvc61Bh0OATJTL311SPE1+w4ZrjAXcmZlSE+Ol7/KKXvgCi2wGUhPZgE8A?=
 =?us-ascii?Q?5ppx3T0mOnRskbZS60G9RvnfdDdVOr9Pe44ZiOTbD0As8ypu2Rx1v0Hs/lwJ?=
 =?us-ascii?Q?ZCmnydYREWVdxn67Q9OnW1lfRyvxYmJRm75qqN7g1GZvm7uLfT2TjbBIIS2Q?=
 =?us-ascii?Q?zvsa6dK56MXHSxVSBjCPpbZyc8s0KD0W/+/S?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqMdIief8LzjrAsTwnfTTrET2jilRBbJ80Y8AEJZig5lYD2kTA9GI/mzO5P3?=
 =?us-ascii?Q?lyPO4M7pSRiErKY/HnjgBa7l2ghcKMn1xYezR6fo4MJauc7eIsqvo7vB5pp+?=
 =?us-ascii?Q?lIn7NfVeqpngVp46zWh769+0ZQBp9Wg2X/D009VNWgy/N4nntH78+RFSS5E+?=
 =?us-ascii?Q?8yMIB8ZXOACz7ez91YbS26/MkW+1fpHnsoJyQAkg1xVqLyJCXZD/flyQlzl3?=
 =?us-ascii?Q?cJ3GesrU+AVmKLBFIgkvKFSU2m/8M6RbBG2zdHorJbx1zH1/39gwjadEhOrs?=
 =?us-ascii?Q?pcnG4ljuyH97GePou456eGzRcoMfYce5QQ+925Vec5baI6z7oOXUAwEqvSBw?=
 =?us-ascii?Q?JdTeHhfVyXfBEq37fO9uck1d/a//LV5PU+858bHcLTs/aTFaNfiIaSwcHdXM?=
 =?us-ascii?Q?kN72I8QryzKEncbTAmu4Q69XxGOxS/iUVtAJjsFON9SrAbnIFtaadfM4QZqL?=
 =?us-ascii?Q?1dlbGGMyC3OKSZCpiM6XVHUssnC6R9HzFjtJt5uOZpEpCLauFXWk1dN4+Q+n?=
 =?us-ascii?Q?Yx16MhZTp1AfkgXp8YB5b0rqCSQGs3nDHK+1MveLtpxQQ1nERFcqPGnCmi+9?=
 =?us-ascii?Q?Qa1LKf8v4yWqVCr70s4YLAGqF1xx8mLc2jkzSK5m+SuTGJHlYRaSf4fVdR8Z?=
 =?us-ascii?Q?80eB0arseYydd632qXxa180oSH6lEJ5/jdlVF8pBIRgAcGf8JEvQHUrYcWrD?=
 =?us-ascii?Q?5N95odTyATrWKGtSwKtTGvizlJnrF6RlVbSUWvDX+rINavg6s+UG414Mdq/u?=
 =?us-ascii?Q?gezMjAWYkkS3M8aBPBUubOGFqSZrjikxX8M2tv3uyYvgHDGy/cI6iZD5ZKL0?=
 =?us-ascii?Q?Q+uSc+8wb3eP/dk78bqy0f1a2Dio9vo7rd0BtWK6u4zX6RnYgX2nXVuq8iPY?=
 =?us-ascii?Q?G9E18cQi4epHyhrpnWFiL1glQ+D1Gl2Q+VsmEkay4k1afFfkknRHD6bR9gFx?=
 =?us-ascii?Q?aJ+gIq7oIl9eL/9n3rRK0VwfEaSSfVfE1DPie0QFBQNrAchkWJj2/HGtPSWz?=
 =?us-ascii?Q?d+Ohl9BV2sOcCcC89vS2gxrN/4QaGnHLQj1mjuKbX4g1LMY6FVJ3ZZwuBPOi?=
 =?us-ascii?Q?R0pn+iVgqpBRgtzKCJxUbN+CLo3W69bDFDa7OGo3ACgHX3I4rbUbFHAuca/8?=
 =?us-ascii?Q?frsluQLT6YY8WDvIlJ6F34ZlO7zmHD4DEiqKQ/eM/Qxy7Nk+Opsw6mssp/wE?=
 =?us-ascii?Q?l1j1fphfWt+XbpIJFoZak+QYwP9WwFeOgLlfQmqebkTIg3JynIrfKcFHvweI?=
 =?us-ascii?Q?CLMZe1SZf5Pg5EJkZ9jtBa7JTHTummw71GEVEeDm+GTQFzsJlWkqjzspaJJ/?=
 =?us-ascii?Q?79qT/rheZvCy4zErhX1Ht8H0MwcZuI7J/Lyf/vcKvLskCe+cBdFXq7RlyMPh?=
 =?us-ascii?Q?Z+Ljii8bQKTzB68VUt2HICdXCuRWdT3SJjt8Hqtx7wShpH5WtZWrVErqqA/9?=
 =?us-ascii?Q?Uysdxr9rToq2/oWIGPHVo5dqktdLVM6yjrUUTxzwJiizkPL808sl4JxgzzR+?=
 =?us-ascii?Q?PDX7KYBzPRVw9mCvKI3R2UX2xKo8xr/TQ0m6fan3ClV/27t+a9aizGzI//r0?=
 =?us-ascii?Q?lhYCR7f+cUIZ8lro1j7yXQl/MsbCUlFj95Z7I0v05TY1Hwjszas+YxWw62tl?=
 =?us-ascii?Q?cw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c15063b-e2dd-428f-34ce-08de284b56d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 15:41:57.6866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/YfYAgzeRsx5yTRgqGltJqqCLJAHE5qrfT9W7waUxmf5mZOsC0taxCsad5CBfPDtdC2Mf9mnhMURvCxUBzkyLBGhSIsAzA6NVZ6/9UY8Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6523
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
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>=20
> Move the common logic to i40e_clean_programming_status and update both
> i40e_clean_rx_irq and i40e_clean_rx_irq_zc accordingly.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++-------

...

>   */
> -static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring
> *rx_ring,
> -						 const unsigned int size)
> +static struct i40e_rx_buffer *
> +i40e_prepare_rx_buffer(struct i40e_ring *rx_ring,
> +		       struct i40e_rx_buffer *rx_buffer,
> +		       const unsigned int size)
Now i40e_prepare_rx_buffer() is used solely for side effect, so returning s=
truct i40e_rx_buffer * could be misleading.
Can you consider to make it void?

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

...

