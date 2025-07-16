Return-Path: <bpf+bounces-63395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA027B06B8D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0891C561740
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB47273D85;
	Wed, 16 Jul 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/3gDYqD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B05270EAA;
	Wed, 16 Jul 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631513; cv=fail; b=Ed9xxYfWNaUDGDHP/YNyCXWB+cc1Z5JV11jj6D1wqahNixa7t4nhIWwedf/BKTEo6VMtiKZ9JrJON5VTXAzeoHuEpyLQclbX3UO6PuPe/wP9H3lYQx3i1THTk4oGyagO72HRD+epiMEKXx+Di3rPd647QWzYu7njYa3UljULuJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631513; c=relaxed/simple;
	bh=hZ+D9Fclx1zTXL9/zTQg/4ukW6G0Yc+dobQa3hF3Lvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PinFE3Zkog7N7oBmfR2UWfLXb5Jj3SjVWcNI0nLjh1lk5SRS+H2kay2uUsZeIN00yb42fGoF9eVwQtuyt+wflQv4DhdGgqZKyYe4A9wxpzivigL5xT8dMxfppimvLzfClJqiPKzvndUnhtkACtLKdTJ+JIyee1ltTeB7x/geIw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/3gDYqD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631512; x=1784167512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZ+D9Fclx1zTXL9/zTQg/4ukW6G0Yc+dobQa3hF3Lvk=;
  b=A/3gDYqD2+a1Pkbl1r6+56zXM9BORG+L+M96er/cIpwFklOboULUWksJ
   nBOFv0/StzANP0tv/lWeLpUWClnB/vfXwlItMhEX4zOBO1YJ+BlmAbMQb
   pXC2pG0Poy9H5v86FT8dY1gr/sn1b/ETUQdjzuWc0GktSvr+ocDwFDNXy
   2sfQktI2F1HsBF8auTOYiRMFxFDazMywh5U5SUvBqeQ3k1j/KT8TRJ/0b
   nJFNDPrMwbjfH3gZ7nTgCmvBD4Hq2EQ/iIciJ20hpxub6kYnSTAKAgoWQ
   rnlf3+mrcaoTr6K/6QIJCk7omNsTD2BA7cuo05EuOt/Cxc1INiqVyVMca
   Q==;
X-CSE-ConnectionGUID: PcHiyCPCRY+geG9gPemadQ==
X-CSE-MsgGUID: qECKTdmjT6eCLd0EFRSNVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54575459"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54575459"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:05:11 -0700
X-CSE-ConnectionGUID: 8yNzrBT7S2W/1HMQ86xQtQ==
X-CSE-MsgGUID: D+xJ6BAEQlSoo8v0Oojw8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158097419"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:05:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:05:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:05:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 19:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5YKnYWkcfD0R05JQy8MSjtuQnnffgQ4ly2nq7I5TN2FSOPNZQBkBxkLaqXeHJ8ZRwEEu7cu+q1pqDaH2wq1ORfGXQ9mdiQnvURtlR0Kl7R41RBlSTTNocBir3Z+WTzBDRcyQHr8ByvEXQR/xJzMnZY2Bp1Ty58mBphbXJcBecExwa1mj27qxCRHP1XPWsEEuGjngfv0HT2MN8SzYrK8inO4TF+qIWB4AiBv/gI8mxcFttbJdzs48+3glWsBUqRMAWSmAQpx+bET14mWPa/YhKklnMmx6iMOHBir0l8H+nMEEOsva7TTudddA07uXPgD8DF4c/AvTj3Q3m5iALX7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF7xMPY5iK6Fvnsw3nbdzBu2lEcGr8ZFf465azifljk=;
 b=vwSKLIG7MFDKMnJ1UEUXTvcasvZTYJ91LUGDYnzkJPt+2GawxizDu6nMx9U9XTmk7Lb8RPzPcv0QL4dX7zSqe1UzB6OmyPlvGyl4MQKCZzTp1Nf428DdRnBX9cpY/UDihZVRimaaZXkoFw4npAATJ4wori/B5n/yv2AbStdPtqADK6iy6nd5Fy7V/Oc2uSvl+ibtUpTOK/ZMJ/5qujsrN7VYTVLyUUcg5ZY5aI5LkJprv44TnyOfqeC85iQKZYeXXNNUXqUwuLxBluvXDNvP5Mn2tSomV1fsqDxVaRk7dfcGWTRjAzmj65SYm4Ix5HYumEYAl3SbSQnQ3t9PR3J2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 16 Jul
 2025 02:05:06 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 02:05:04 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling and
 driver requirements
Thread-Topic: [PATCH bpf-next,v4 1/1] doc: clarify XDP Rx metadata handling
 and driver requirements
Thread-Index: AQHb9Vhr0Aafvgr6uUyDGhiaxQBAhLQz23GAgAAlxZA=
Date: Wed, 16 Jul 2025 02:05:04 +0000
Message-ID: <IA3PR11MB9254FD76B5402AE44F2CAC13D856A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250715071502.3503440-1-yoong.siang.song@intel.com>
 <20250715164913.3ed08273@kernel.org>
In-Reply-To: <20250715164913.3ed08273@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: 1df5db3f-c3d5-49f5-d050-08ddc40d2e3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?heGII9kUbB/cHAZtDogeyth/8ULpb5tF+wE8VzBxwUI9liAQtGnXCdWT1y91?=
 =?us-ascii?Q?Y6s6KATEMDHm0pV8ACxaYgpIH2sVZN/kNQMcNgFIwM232NeAU9W1NGMomR0f?=
 =?us-ascii?Q?xGcWocltvHpiJpACErfmxKXFB5FzTk9QCNqFTP59jytNRstZohWnKT/H4ls1?=
 =?us-ascii?Q?qGvCOCGQ1a6k+Gpc0Q2rcgGBTzTFMyVN8NV2shHzKAe53BCDiucjlUMFeiU5?=
 =?us-ascii?Q?hPdkqsACf4rqvOweSi1zHpcZINUGYIrz3E3icRjP3ksT+oChgmS4cD1QGv8u?=
 =?us-ascii?Q?bgMAoDFXCNPqysLwU12GWk+SVOHfV9rweUQxqg0rljUKNyVyAu0zfxe0sfWa?=
 =?us-ascii?Q?ezdLwNM9CYLhw96NgInwLO3BIXg5iblYDEPykOtJ4WL+RHz24ULY9XoxMnJU?=
 =?us-ascii?Q?VOTPu3a4rS9owkqI6SNM8G0vKvTKNS8S8KzzqffjDgMPSwW3flukVN7H6KHc?=
 =?us-ascii?Q?Mj+FRSzOoBxHLETEChDI98ocQDdBjXTwKjVPIv/ozt/9zHVd5KigmYJQfogR?=
 =?us-ascii?Q?vFCTF+GHkl1ZgZsGvQouonO2v2hbHtcG94l38sQFyNEECebW9mhJwSxlX1kw?=
 =?us-ascii?Q?WCUV8RlZJ0Gtmr9T2vmV9w5+tnLFHfQvf6W4xNtDsUt6tTvFoKlWAM4rfWHd?=
 =?us-ascii?Q?o1YyQLofti8N3u3SyKfPl4bYRcVmeyn7koW7+cqXhqWuDGouMJoVID21lsU5?=
 =?us-ascii?Q?hWy9TRvNUY38XheSa9YvVZaMMg2TsMU+AVEcUGu2qm+NOkwJDfugHAtTxnX8?=
 =?us-ascii?Q?dYXTbQc7K0S/i2OGxexFOCDi00+RAHGf5NUI7lfPnfExfZ8xQABfX1IJjJpg?=
 =?us-ascii?Q?hm0QqmcVKUnfWB8/QyXxOcFu1wumqREbLGdtkFMv6tm3MGgC/kjtS4P/aOcP?=
 =?us-ascii?Q?wnuKQLD7nT1w4iadEgrv26KvjmuRbqTQx7T86ljNlzgcP3PUg224ZFptzJyq?=
 =?us-ascii?Q?kzE5rLbrnfnkcnygSz3fBTSgmGwjJ7RylCpWN/+f7l3k5M6FONmBSeZ07S2z?=
 =?us-ascii?Q?w+bt0lU/b2U0L1jz78fTYd84WFua0r1o8+L8HcEOVPsBDaYUqtcVsG152cPQ?=
 =?us-ascii?Q?di8mLJHONf0nq+ADFaOTq5dUujCwfcmwlUVsAYNm2n1ldY2NOJOkut69iqE1?=
 =?us-ascii?Q?YfL4J4U7ehZoZHkUANA9kAmGuSKTY7CS49H+g+M/yu7w7v5A6DjMAaoH7lp1?=
 =?us-ascii?Q?MO6WD1pDvboMcHA379Ppy22hjfWP7K8z34ljutZJLiH7lTUxV2yj9SYWfJ4x?=
 =?us-ascii?Q?aYlbVrLyTcU4hEsEwMnpv5Btxq64OVOtDl+V4Jz/38fcWsrEUsUIyntCx0lu?=
 =?us-ascii?Q?nG4fySxXppVtEZ3NebdVZGvplQ5oR7hUok0U1EkHCpzwDgQx9h4tfQsZk8LF?=
 =?us-ascii?Q?tMputdqQxLL7/RD3Crmnc3aBQ6qJ7BNcfe4pnKus9FthJv43/M0Yun9STKwi?=
 =?us-ascii?Q?Or1q3m17j0l7MRDV3vV5CGG/aJDrVgkAJz1DivAF+x/oBQEtD7hpd/u0kvN9?=
 =?us-ascii?Q?j0nKRZnNFwntZQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sP6lauBqM8wg7phw6SYNYt495db+wbGfF0Drk/vD2VEYxRX5Ucw+nPhOhqCX?=
 =?us-ascii?Q?9+2KkkB4WejdFljqZl1AhRa8B5Ge4i2pKVJ/5QMJYhKWUSiSBSGlkqL1HX71?=
 =?us-ascii?Q?KHdHkp0d4uuB+FyYkQnBpmGGoZalyaHTZrCHdX6hGVkb8Cc0fuig5UCkQ06J?=
 =?us-ascii?Q?w1hjYbv7waEcDt9Z5nPD9Ul6VTViTGMCvBnnyYSGEnk/pNXf6at7vLRtKsUX?=
 =?us-ascii?Q?Kwk+aX1D9XFTceuqViG51K3BiGstyf9EJcJZfBaYuzanrHAP5oHvrDU4A9ds?=
 =?us-ascii?Q?2sBzWv079bJjKU26OMH+YT0nVc37Pe+lNBWu77dQE3PKpmVnloLdRZ0N2E25?=
 =?us-ascii?Q?ULngny/kFfGTubeJAk2+3D2f9TJWA3QjjrAGQ+bef3F6VKJBx1SzPFOJtAn1?=
 =?us-ascii?Q?ATMQmroHYUrlXLBGqK83IC2hfFGds86h3hPy0VNHF1hfeejAK5cLGgvXidUp?=
 =?us-ascii?Q?zI4HxHIOnrjJMQmLBM/S4HzaqBGr/1c2E+beoeYe9jIlX+hQfOeuNz8wrQbm?=
 =?us-ascii?Q?cZEThODSUc8OehSMJbYTYa8g1mwTD7uPhORkO45ydhsIdyCgS89lqOePAiVd?=
 =?us-ascii?Q?MIzefLdZwp4dm1fUlciRPmYLK/s7LUwce5hZC5kZzo6VE5kCRWc/fctSMbnT?=
 =?us-ascii?Q?nygsubG1iR/fUmJldJrMIVq2rB6ht5G/HJze48T4pKI+BgmG5Ppf12AxzdCa?=
 =?us-ascii?Q?v8hfuHdXx9eK7GxEAyr67n/Fw1/7jrErfLoVKGFrVC1DmQHN6nkiuIn0fvkI?=
 =?us-ascii?Q?TADMvHc6X1Q3JRtk4jnbBggW3JRIN5qa+H+Kpf9z6rS50gAVDkHLedHH5GqY?=
 =?us-ascii?Q?F89OMTjGklkOCEcXyluAZWj3GeyTKqindPdGou6NpnLnXdspAOrTtPPi2G0W?=
 =?us-ascii?Q?mamxs/yGEv2YvOvtVjRf6XMyrdAFDRMV5qTVhLvZiEDhO+oRBzBHa1CkPlKn?=
 =?us-ascii?Q?WK0O2MtOtoQUDq/gkalY0l3rj384r1C/E24QfOwr6cT7eVCz7akCXuxcOkAD?=
 =?us-ascii?Q?OC14KxFrOLM1tWNpqBg3Pe/WYI5P+z9rrLaLwXECaHis0+j2cSi4I4motdaD?=
 =?us-ascii?Q?X0ktgLGZOlz0QSXGcT+gfa3a5TVTcOHE5ujRGRfbSnutdBVQSpDEOZSaK3eo?=
 =?us-ascii?Q?z4ghZ2L0su0gJ+8wzkBxNOCr1hHd03AZQ0UULqPi9YFzKbifuUT1wff0wNWE?=
 =?us-ascii?Q?FJ1eUVg1A79Z52oKPXB2kKzW0EuIY1zTEzj/B9su5u0xWViRbhh2Y6RuBfA6?=
 =?us-ascii?Q?BQWd/g2KIynn6WpOGAlcLdZ2wT9D+N2wq0MOOgJduhrBfMX3FOANgdJbdkGY?=
 =?us-ascii?Q?oM7zJLZkluoh9aVARmKhJzc4YTTvbJRanvTSZMpFw+VQGf5npJ6VsG4bk0gv?=
 =?us-ascii?Q?oCzoViJs99NS07j7b9PFTF2yeRgVWjmejxYBg8OdIA0c1Qtk7u0GOZxm/4r8?=
 =?us-ascii?Q?xFypklKWFK6qcKYWKEk1B6QoIg98JwJo6euKklq4xRsnJOiKjH0N1Dfyu/WZ?=
 =?us-ascii?Q?zO3mghhVicOBUq4JvNoqjQrvR2d2pVv1cgsdj4Tkn30hw49I7v6G/ynU8UMM?=
 =?us-ascii?Q?qMoI1Qi2qxCwXrQBkjND3l1C44SFr8tUoMV5JJ0UoCLkDszDZX5ZjnqTy/Cu?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df5db3f-c3d5-49f5-d050-08ddc40d2e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 02:05:04.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFAbv2HKzY8nRHYMQPq7LJt1JK66B4osG7IFf9Rm2KMfTqJ+zVF2eaHs+RB/taNKLeiVEJWLCb8h+HIUeejW6UicmOlIRuwqc/8yPogBcyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

On Wednesday, July 16, 2025 7:49 AM, Jakub Kicinski <kuba@kernel.org> wrote=
:
>On Tue, 15 Jul 2025 15:15:02 +0800 Song Yoong Siang wrote:
>> -An XDP program can store individual metadata items into this ``data_met=
a``
>> +Certain devices may utilize the ``data_meta`` area for specific purpose=
s.
>
>Calling headroom "``data_meta`` area" is confusing, IMO. I'd say:
>
>  Certain devices may prepend metadata to received packets.
>
>And the rest of this paragraph can stay as is.
>

Noted. Will rework accordingly.=20

>> +Drivers for these devices must move any hardware-related metadata out f=
rom
>the
>> +``data_meta`` area before presenting the frame to the XDP program. This=
 ensures
>> +that the XDP program can store individual metadata items into this ``da=
ta_meta``


