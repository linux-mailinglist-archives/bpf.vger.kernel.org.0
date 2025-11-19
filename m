Return-Path: <bpf+bounces-75090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7331C702CF
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BA334FA315
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D433A6F0;
	Wed, 19 Nov 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8qJQqIf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F52C21C1;
	Wed, 19 Nov 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568708; cv=fail; b=mT2OS4XwtWC4yFMJs0XElzvNRpxiS8f04zJN7jP+UM30SF64NV8dtRDiEKl7rYRyHVpKDv0eCMBQqHNX10gkhOrGtEkdGdJPM5OgZq37LlyBIT/Wi/tAySy41az95uikxpV7rfHf/oWpXFkteM2LG9uYlSJKbFhIUw8I3AbtRKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568708; c=relaxed/simple;
	bh=mU7wBQPNfO6uestsKnG1LySyRbH5icZsUeSbwTu4pwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gQbwto0jNustr5NpJI/Y6T4JOMClWeMFjWo1bxu1ES+vFscreGGCicqAORHy7bBcZep69vkmAOcBpp8puGOoUnhlEiG46niTOoVIlgSxim7cQqEOTLyb8FLiIjGsIUATihu3g832g7aEPBeZIKlJOqRthOaVLXQPVtpVyCli9tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8qJQqIf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763568707; x=1795104707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mU7wBQPNfO6uestsKnG1LySyRbH5icZsUeSbwTu4pwk=;
  b=C8qJQqIfqqShLC0a7BtYoV76mt2p6WeuIUFVvmquTqXSV+MUuIJiJ1Be
   9oOfk+W1nIKvyfkVDK7NJWO9H7cnlRL3vF0u0bKf2D37lDNHRbduGU9LJ
   L35m36rIrW4K1zMAumTFlMAkmuRyq3h4Yw4XD8VX4FaHjE676l8ceH48k
   jPgxLvdN1joJ3Z2vvOJ3p6dIY2Qj2EtBYsyw3FtD36+MkHOZyFC6KE6dF
   RkylxTAAV9YEm9l2CaRdeLWXgd++8ixzhoYgodjcvm7+12E3xKBirr9fq
   Lquax8bABKvX2qCHXiJVp2Fb7xPdPzAwdqB62roKGKH+dzTY/r12ceDne
   A==;
X-CSE-ConnectionGUID: ZIszyUWBTU2DGr1wPyBc8Q==
X-CSE-MsgGUID: dKF2xSkWQ1mYHKlfsLOm+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65648987"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65648987"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:11:44 -0800
X-CSE-ConnectionGUID: X6TwLZ5xTomBcuLYG51Q4w==
X-CSE-MsgGUID: zvqyTWHhRqSS11bwmRpMiw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:11:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 08:11:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 08:11:43 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 08:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbJnfoc5LKxv8Lc81PUAQsJ/zdtcwt313CyQyTbDzCuy0xDmUwy5G0krMMxJ3zLObOE7aZX379hpbN8MUOeueOXq25QwcXCPw4T9PjxSMd+f9BrO40w+qxRRP9aZ4k0dMH/8MnWskdvQLLDJwX1BOpK7vHhTMsUMwOtFwdYmdgCqc9dLo78Je5S2AtWNJXPB7QbEuqYxyDe0BgFKj/ixdPTNbG5/6Zo7/s+J1iDuhDE+odzsGK+KCB8tglhmcERE/LtH+VFY/DJBeanz5iqt2g2bKPNkZIqIroVxHAXPNh1eMStDUE/jvkcuMX7MfVk7RZS1Y7wO1yN4FrOeEUB/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y8QuI0purhzwBmriFkwO8Zd6roaXnqy9kWR/aqocd4=;
 b=tMqSAVWox/u2weSFfkjbj2s2wjiZZnZ/5B8HgvsmFRmT3w4mRx8gyApnTn0Pmot6eifJ9+iV0jQ1UMJb8wl3allp3PJLRafayCPsvjQSv6Y4TRtCsEb7fXSPLPy06N9kJ4z6mNH/sYufkDMx4D+U9H9CB2wYa3OeC6iXpzQpVlLk78wxe94HaocZ2UAZr4PsEaYmCJmaDq6CvPPUVtMdWGvfNNmQcQiGWRKcvLz5cuuWHmQ2ldxPN5ACiRV6LqNQwYIFqoqBf+/x7x2rTv432Bm8Jygkh9klbRIgoRBDEodVsQoUgdYZv5yel0suYmkTx8xXKSIgfln7hD6CAvyFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 16:11:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:11:35 +0000
Date: Wed, 19 Nov 2025 17:11:25 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
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
Subject: Re: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Message-ID: <aR3sLeEpPGK0iP+3@boxer>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
 <20251118113117.11567-2-alessandro.d@gmail.com>
 <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aRy+xA5xSErIb61j@boxer>
 <aR0UKHeilBX5oTg9@lima-default>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aR0UKHeilBX5oTg9@lima-default>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: e837dadd-94d2-4bf3-99e8-08de2786501e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ussAJAD1PBPjfC+VojJ2TFsWCGBpiHT3+iRzOJLdKps06TbT+vY415vim6Od?=
 =?us-ascii?Q?+X8NlcW4LHAELw5HK7QZqkTBwvD1N/pMHMclE2uwLiTVamr45ZyKTttjmoS7?=
 =?us-ascii?Q?PKrQigJWfPhJBe92gI17yetlakgFjcMgQJgTUMWyngZfIHM0qxiQ5FkXHJVE?=
 =?us-ascii?Q?pKvS/maXsWAeWnklweLFwPCpfN6SIqX9goqw82dk0XOWP2Z3Mj/cJiMx8/m3?=
 =?us-ascii?Q?w7UvKWD+MhmY43UXwzxgcNe6wEES9cH5fpQx+3Fn+9IGCfsJ8RzKJI0XkSbA?=
 =?us-ascii?Q?D5dJUlHRBQPSNvLZ9RfYf4A/DWw8YCGo4rshs+dWmPtvOfa3VCj/aXatB9nM?=
 =?us-ascii?Q?m1aiLUiQc5Jv1XA4k6iwvX1TcRSD1O2sXUYJotT7cNsH6Z4Nqx9Ol8ycmqC+?=
 =?us-ascii?Q?2XUMWEfZ/EsO26oMo+o+n4kfEwtO2Zn6avaz+YWu1slQzOEERP9kP09+9IhY?=
 =?us-ascii?Q?x/ce0zIuZW/wWy/GU6gIoJ0Z441EA3aKzMo2PwFvIUjxrfjC0wh7Z5ToJXP3?=
 =?us-ascii?Q?ZvdnkzW6SqpS20XP7s3vzKT7xUAciGe6JWE+X1xyUXRxXFP7GJ8wF3TXjoaJ?=
 =?us-ascii?Q?KRoZkpvr0cDgpWtrooKlIia8RPdTFxiwoL1UDtkoJtkcydv7ZQSCpzFhXSRK?=
 =?us-ascii?Q?P2vM4nEc+oudofqI/TiMUhWx3mibKG7/W08ZmdeP35UgeZUjPF33Wh3Clc1p?=
 =?us-ascii?Q?VDKRQgWncQlTZoqzmePZXzE7qkC2Wj6IqDkbKd0laIRb6bJxKEHh34Cm4gRK?=
 =?us-ascii?Q?HwoPzoj+qGQ08p4D+BCJen+cNdpoppOvluwxUC6w+iIk/Q40X0BBvWFy5uFK?=
 =?us-ascii?Q?UO3JNlbeuW+mDEaseDcH2qRfyhp5wJShmlaHBGOLNhDAkW7HiVqZJwsXMRqV?=
 =?us-ascii?Q?yAwqAJoE7qWJW2clYgdIi1btUuaidMBTECTLurWyz14tZmUo21ffZI1Rlxxi?=
 =?us-ascii?Q?B+JmZAeKFh2Fscd/TpzpdO/X+3vP5owh19amNX3X03TYP03/CIPw41DzLm2a?=
 =?us-ascii?Q?P/m8Yhhg2jvo1KR8E0MMarpI/3UvgqY2HO+pemo18l9E8XftQPAQ3oQgaJSp?=
 =?us-ascii?Q?yDKlAH5nZcQVsCk8/cmmp1WtqkP3wl8BenQsNIDkXvirNvS1ReDfadUBOmJ1?=
 =?us-ascii?Q?Xco9SLKrZlLGNCakYaCGSXufRrmeJWYgIRtrm7ehevWMPtP2+6mIqqJrHP1V?=
 =?us-ascii?Q?AmW/bVgCBv178IR8LQw+kA+Jr2fh2+c2BrumJaea/pfbOKKkAgeHsxtYY1xQ?=
 =?us-ascii?Q?3XAAP5xniFcfvKFa8FrJY94IlVLwzrnQfSJlWxl5TvW86plMewpGRxpwG9rO?=
 =?us-ascii?Q?k1jLpX6mNAKkqNmSw/z2AoThShTr1BO8BrKCFYd9wDMLRYvHYzFSzs65ODAJ?=
 =?us-ascii?Q?yWqPG3Xv0CU+Z1FbvyNEjhOP/HN/jqNnIPo0fbV7OO5kAFFNR+9nAG2jKkfj?=
 =?us-ascii?Q?ZEcJhgF0CL1DFHtnFhcOq9uF1eYGtF8a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4srV/YlEe2nkZUYUSnuEBj7liGkLJQ5t3CNtOqp68gul0N7RyJGoBVU8Zyug?=
 =?us-ascii?Q?+iUMfWV90tNLqDkxTCk8x4P+gGywfODHrx1iGHkUnKeuIFqDYur9giNLs5zb?=
 =?us-ascii?Q?okdoSCsD9Lz3flJ5bpOuKMFDqd0qJSVmdmWuIE+dEY+Mg+UgpygN3ke+VWfW?=
 =?us-ascii?Q?FMC5gCt2kOgNMjn5UG4GQy1WeLhmSNDbM1+5huvY6eihynRUCxHgUqsrzNeG?=
 =?us-ascii?Q?laKhJtLhA8WlY6dzzjCkWTTFLGE1GA5Bst+Q2uhon/89gVUurySAAm0DNguK?=
 =?us-ascii?Q?ULhr6Sfyrrd9Tp4b1KFZbFxlp0iL+aW8kgMVgkeEiB3mI1aosESXWRlae8QX?=
 =?us-ascii?Q?UJfJujvK680SduUi95kDVpGMipJM7cGsVHjzy/WpW1TzwKCnwYjOBnCjlWpd?=
 =?us-ascii?Q?EAjeOpjoY8X4dhymhp+UaxTNQRMc5swg8atXcf0LpZgczrD5qSoqfMOUkQT7?=
 =?us-ascii?Q?iWznyTnK2QA/3dn/O7obSIv1XPk+NzzoME1Y6iKwGJjnLf688cBX2lPjs7a3?=
 =?us-ascii?Q?BqdmDVe6nKF2xWfvUlp+DewaYb+7yITvgQsYO8Ro7tPTwYVIX++1fDfdeJb5?=
 =?us-ascii?Q?3cCeCPLoBDmv4Ho/AGxxhJJbEk9D4MtghQ1f2iDeuzl9X4I5ixpp0vpUbGpX?=
 =?us-ascii?Q?OsL4TO6F4rxoYr960vQxXCDNPSTt5Qh+IsAfQSysV8G7PLEraTyu3/aHhJ9j?=
 =?us-ascii?Q?5BIw7aU2woK7PDjkuUMUUuYSGPm173Zk8SthxX0f5q/RlcUXe/6eO5sd9oCi?=
 =?us-ascii?Q?8CyhOq67LgOfTaQFPC4zO/GOu/NaJ7cENSfXbiVjbzFyw5D27dCFsXHnPL9F?=
 =?us-ascii?Q?FsFOBfnUthC7KahnQXv5ly+85ykGUL3754V+6gUXGS3xrDf7qPXMujhEl2rD?=
 =?us-ascii?Q?aK279tsyNdppDLDtlrm/aa8Y5XmOAyHWNdBSGXK5ZiuxFWM4b3OQwO4EH2kf?=
 =?us-ascii?Q?rXCu7JMtlBD4bcZVWkU4vPZPKvYRbZvzqoOaBhktduonYZNZqJPX8zptvdst?=
 =?us-ascii?Q?6O3ut3E9M6ouWCuweZrCVPKplf48Bk3F9obAUKQxubjyyaRJOfCAoFw1nIOR?=
 =?us-ascii?Q?Hea3dP8ou1YeXwAk1Xh2vTrJXc6lHL/RXdsQgGMNLofDdBeNtVUsIHTf7iuB?=
 =?us-ascii?Q?yq2P3955WY3JRe1jTG0OHIRsEyK0MV/8KJ4eWoz92JmNrsxn/EXOmf900/8Q?=
 =?us-ascii?Q?A8+HtQa8PxzOcP2DsyuWzi6Rwdz0iWrxr9OeqUIlNQbVRUtuBG+oU+96+DSw?=
 =?us-ascii?Q?uoT7oA+c/CeC6yRi76pzxxpojUgcY+ePenDYf1wy75gVEut0CzVNY+iQPZhF?=
 =?us-ascii?Q?+jvGhMvHy9g7Lu80wG7kS1ea6yXgHN6+MgQrzKVG64LCAubk1fVWmIfWbVeq?=
 =?us-ascii?Q?whbV8ezndgDMgSveovzXc0aTbmLcP/yBysxn6afPYNXA1sIgDdkXDfJticgW?=
 =?us-ascii?Q?i41NZpfgGtec3qVySyzXTCGY5Q46Da3/d0okUde2CH4vxRBZTg9+raQsGE/D?=
 =?us-ascii?Q?dvK06NR1h/yiIqYugWujFly1PwRgYxxhNi8Yqddv/2dpT4uz/OgX2tPUEVMW?=
 =?us-ascii?Q?rb5U2Becrh7uYay+K+/+P92P+X7TW04EN/sl1rwLksJ039Y8pfgmShv0zO4e?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e837dadd-94d2-4bf3-99e8-08de2786501e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:11:35.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcUkTHqIen6b19CKIDRe5I8BmKI3GstF5a4tXooBBtv03v61tOFLGDBxGZ5UC+Wv01+3VCyL3Q4zt9qfLiQxDpgJpoPcEP29kVnWNWVc8WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

On Wed, Nov 19, 2025 at 11:49:44AM +1100, Alessandro Decina wrote:
> On Tue, Nov 18, 2025 at 07:45:24PM +0100, Maciej Fijalkowski wrote:
> > Repro steps would be nice to have, rest would be rather redundant to me.
> 
> Yeah unfortunately I don't really know how to _manually_ reproduce.
> 
> I don't know why I'm getting these status descriptors, but I'm getting
> them reproducibly every few minutes on ubuntu 24.04 across 3 machines

Might be a HW quirk, I don't remember. Other example I have handy is HW
that is served by ice driver can sometimes produce 0-length descriptors
for jumbo frames and we do handle this in driver.

Describing your setup in commit message would be enough, if you ask me.

> where I've hit this bug/tested the fix. The machines are doing ~300Mbps
> of UDP traffic, some of which is done using AF_XDP. The AF_XDP code is
> TX only, so it's executing the build-skb-in-zc-path all the time as all
> the ingress traffic goes to sockets. 
> 
> If you have any idea on how to reliably produce the descriptors I'm
> happy to give it a try. 

