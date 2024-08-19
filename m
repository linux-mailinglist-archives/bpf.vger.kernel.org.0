Return-Path: <bpf+bounces-37513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E5956DCF
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AC1C23646
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2A173357;
	Mon, 19 Aug 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlcipYMi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B01BDCF;
	Mon, 19 Aug 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078894; cv=fail; b=qb1xeMczePkqdxk6fP6YhWEwQpebO4OkGjJSV+EcLIbl1TIycX1uZ/ltq1txJGwJxRPkI29rut7aREgwJYtD9i6SmZEwZxTf4TPZ5O6cgQZg9qpIT5KL4a0zl/4XX9Rt9YbTuKiGPed7f6C7OoQ6vmvVeX3twa6Sgjv5nHY34HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078894; c=relaxed/simple;
	bh=MzMa9zExWv/tuMej2N5A462TXr9Y/wZkYpKdZb1ap70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQZ7ZXIRz+i6rCGzVnZpI2tQg+KxH4/0V410W+LWd4q8/r+/77msR6Iqyl4c/JmtkXAB45lVwkNx35e9MJYdMctevO2jAQaTgBqK2NR9t/pHEyA7j9rxb+zjtL17AZI6XaVMZhoYK6U+Xe43oEah2g7ttGXDyhWPRnnaH3Sble0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlcipYMi; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724078893; x=1755614893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MzMa9zExWv/tuMej2N5A462TXr9Y/wZkYpKdZb1ap70=;
  b=XlcipYMiXBFln4aFjK93dnRbqJQ0ADwXoKVCfuFpmvzKSaLmyYtXFFPi
   EY7XHOeOKytUeWjOa0C7zXrU8UPWE5Ci8dQZ6m4/tLd4roHH3cEoSdO2c
   /I60mhKZ3G2wD/zch3qrG/ItCYMLEgTmb645O1TfRvP0RWHDNrg/vz41+
   LCjDt3deD/7bw+TuXpGunkciOl1ywiL3yMXsJXlGOYnbn387gDRUGFyU6
   Qtb+Mi3d6Ekdt6pbGuGneM7Pp7FDueRfEtmqwFqNMz/D7K+qAY5/EyX46
   2IzTJ6YdCwT8fDmL4zKuoC70fe61pJ6sNjLrfYtvT1EKTxKiyhO4DH21V
   w==;
X-CSE-ConnectionGUID: P6SNSWzmSLGddxTMM6B7SQ==
X-CSE-MsgGUID: bLC3OV/YQ5KwxnJDF7WmEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22472375"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22472375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:48:12 -0700
X-CSE-ConnectionGUID: /2ylPBYuSy+IBbKqIM7WcQ==
X-CSE-MsgGUID: 2uEo3zusRtumuKYmQZ52/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60708117"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 07:48:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:48:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 07:48:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 07:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb2fQE6BLUsOFBMMq2RjjkJZg8g9J+sNGJeRJ2uubXqKUvNxoVZYydR9AMNPzdJVKj7IbjJR7FCXrMFOmtwEwP9F0XoSGCaI8q8qENAti/kaiVNK2HHqp5/UbN7+EhbOgi/Pz7ORBg1JDLfD2iP+vK2R6LyhcFs6hkTpJRwFZQhxG60RDmeXXb9HQXvn5/Z9rQs8rdgna82tbZ4dYmKIwUJzSqf48nTSZ5fFf9XoEsb51qmD5R7xN05ZJX4wv3OL3aAUsSJj/MUdzYG/F8JWVMgNCozjVwG1M5YqHX65FqivJh3tMBxd6FNJ3OaPeg14zJdoKDxkS//5cKUZQBDjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf3yf/FTavg5GIcC+0khqYSood4fwsblT/3nUDZzbMg=;
 b=JNPpDjhwi4ky011HiJaAjtrHZ2piuqZYJFtDjC+sXzTN/nbZ4AnhpbYoaEmVTD7NrJzrT2wNsV8+F7IaKzGd0RduTlkQIHke0LQcQN/gYd8K02TKl0IY0UjjJoVwMxjawb4kG+23e8l50/88t/5SaziOg9nIQ7Es94bFjj8uCDMgk1+BiHgNBD/gY5HIIqf7FQmlTbRYMVvnFcGNlQxvtzcLll/eQcPhuNlPaF0cYtDd124GIw3HwhjM50cOKpLyzzQgn27B8Zu7t2iuuMYjCAKKXP1fSSov+XkgKmbwf+x9czYyD1aeSeXS5ZY96TVri97pOcvFkJoof8Fnmu4EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:47:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:47:59 +0000
Date: Mon, 19 Aug 2024 16:47:45 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 5/6] igb: Add AF_XDP zero-copy Rx support
Message-ID: <ZsNbERoOV+Y2xg6t@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-5-4bfb68773b18@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711-b4-igb_zero_copy-v6-5-4bfb68773b18@linutronix.de>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a9eb68-53d4-4529-a34f-08dcc05deb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Noc4cP6KjHVPMLxsonvbIEX8F+6jyobySrFgbXgh0WZIj0JWe94iASDMhHfw?=
 =?us-ascii?Q?mc6FyvYsPWVZC0eqVw6IzXxk7fl+JQe5B1iymIoQDJ1kzzyBJssXKH4gf7j/?=
 =?us-ascii?Q?FA4O0SRYVWK8A4SL4rYwEWVkVxBfWWAEAiHAq1+rnMV5TbKHleiOicnmtAeD?=
 =?us-ascii?Q?Jweq7f4l2vw7X4HAx4U6qxtZu1jMP7XOfBmmN+HUz4rzW+zJC+0e29LSrZVD?=
 =?us-ascii?Q?B8QOFGhEd+0nC2mu57vnDC3LCH58v0wPYfreMYIyTlHsgmRpaSCW56k4qdPP?=
 =?us-ascii?Q?NKIh5cgT51qyFTmGleuEugSfIry0GSLxF/2YN8/a76/qQWbp7eFVVTQViGGY?=
 =?us-ascii?Q?K8J2mD9oluflonBnFPsZ6CSscCQ/OzjVdLrjInWXJ536yCTaMKhR/NxwCcsX?=
 =?us-ascii?Q?vGanU18Q2icHpIq+Lbd8+hKIo4PYBZNpJm5SYJAPoqllzlfYoEPvuvtlUP2r?=
 =?us-ascii?Q?+F+4q4/8LkxqU8Y6VWEKy61rGDDIO6ccIuGHe1nu6xi6U5OkHQe/XSP9zUP8?=
 =?us-ascii?Q?XUXjU1ADVZDkSbls0dVVJQ2718gGr3vPQZCQ2fUyhGbEzEcO+eTZDrZiydeo?=
 =?us-ascii?Q?lEEl+/ewE19eizwtiIlhjVqa6ZqOZTv0PZXmAX3o/Yo25JKuWxlgz1hTjV6l?=
 =?us-ascii?Q?Vf9a2MNjtDsJMB+QS8vyuF5N/M541cMaunR2Q4TNCuD+DQ8O4UN5yN7Xmg3A?=
 =?us-ascii?Q?hF0ObE2XQ+uPUnFIrEJnsGbs6QvLFcjPeviANKoNkM2zh8Oo1qSP2JFwfu2F?=
 =?us-ascii?Q?5ImF1t6oEJFsj+pqtoSzrcPagXV6akOj3t9Vg6U0jHI2YJMoh/LJP97TMTf3?=
 =?us-ascii?Q?PJPXAizB5X8uwthGxWMUeHBjk6w9p9cVXeu8eCchs1r3TIV+68fth+UqK5Qh?=
 =?us-ascii?Q?Tg24z7s1qKU+l3vN0sUfnl3UMiIdU3UuiIN29Lj7jxD40E9tqkoCnB5QMj9e?=
 =?us-ascii?Q?pfo0pBsNrYVzpeL/nwntWN6+xIWSj0jAU+cf9aJm65IzKy5zH8TdfpsgqSgO?=
 =?us-ascii?Q?cVMP6bREdMyD0cNQ5OeTd6dZBoZ59pDEExq2icXOQ3zFtr641M0qYC1ncXTV?=
 =?us-ascii?Q?CvwrtBWyFi9nAmwn1D2e5e+yJXT++ht6yU4AJ7hgbFM3niZ+bHDrVnlWcxpc?=
 =?us-ascii?Q?iw7KH3UDFYaE2bG9Te9YPTK9j0Bgy8KnPLuIS/AMwHuHrwe0hHOjMTVgH4ZV?=
 =?us-ascii?Q?daVLfvqgZVZO6UnyrPhkU4LJiLZS+GQgJtFcVyWZZSPy6AiZWI7BZkr9THgx?=
 =?us-ascii?Q?7H8SbGnSHPGE+5twOqzrr3d62U6oxHKlVk9II0l4xg0ZMapMHz5TQuAn6YUm?=
 =?us-ascii?Q?EOoysLrcEPhXuA2Gi+q7/WWYGkXeexj1AF8fQUlC97UIvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFOYyoQcFRVI4oBc2oznRd3zg1E7DdKDx9dvzLkNWCXWynuPWl8Evg77YAWm?=
 =?us-ascii?Q?zivL1/YReH8U98wPPY9OpAp+KyLl4blsOrYK30mdnfPnBAw0K84GOcW4I8NZ?=
 =?us-ascii?Q?7eiHKu/nZZ+3RkwHaer9DwnegcP+m1fGGXH9hlCtylY4S386ogZcE/AfQiqk?=
 =?us-ascii?Q?1OHJ5r6+4CCtfmRZvV7u6MKlo6qj9PO9SwjWyB3hKOXANfYxF1DnIh3meG0b?=
 =?us-ascii?Q?88pO1fgmiUBuFQ3cYe3GgeqF5ciE3+UEcHS9C2evR0BKr7qQRp960L7co/GF?=
 =?us-ascii?Q?CptV0a5Jdu2oSupLJcIHH4ujZcIlB1ko7Sqddjz3IdwKjxolP8QcGLlBNhOo?=
 =?us-ascii?Q?ijT3M2ngRKaa+8bAqwzELQ9N592lbTPDEcYeZrjNlrRIOoJyN8Muj/uJHZ99?=
 =?us-ascii?Q?COouIn0sgusZE9P0upKVIJrKmjb7s9UDHPSrbDEVGufs7108EMttwRXOcICl?=
 =?us-ascii?Q?bYmmY5U0rS62aZqEo5wCCoqRkn3yWb3rxL2/aIcp4eZLuuiNOs0j9wYvjlIz?=
 =?us-ascii?Q?RWMfkgFcSegTcGkhVSuOFaAlSwQS7LlHhhENUEp+mKE+p8cLCnfg5SiqhzL7?=
 =?us-ascii?Q?LC7crG3SO9yosn/JQxZd1q6BC38SXn2qX0AQd/Msf1kLEf0e4jpUMJYYK70P?=
 =?us-ascii?Q?4pu12HTx3HwUbwLi3NxZ9A3CGQQ4TVY0DESCfNaJI0LfQkm9AnEPVqhcmf2P?=
 =?us-ascii?Q?i+H4t+cOIjCkYTKZlqRi2Zob9dt4cmPfmRcZxbfFsrHraxcT2t+PMlfWIxiI?=
 =?us-ascii?Q?WCYz6FhYjt8A5mNrIBjtgHLmWY3H38H18bpMmXCwQ/z3JHaaKKeidW+MlcrL?=
 =?us-ascii?Q?Qo35mAUsv3sKJvNr7f8P7Nna9zFxfIS04Uei9V3koUoTfdVsbf+JztMWGo75?=
 =?us-ascii?Q?LIKoekdoeJ+wSkhZ1LVR54oTf00hnwlPlUUEYk+5+J09EVqqGaLwMLTSxIOq?=
 =?us-ascii?Q?dJ34dMOxhp/DLOky0eYFRzYfkcVqJZEf404yBKeJfxc2MhoP7CaN3LF8CW84?=
 =?us-ascii?Q?15H7D2E1SmKWBEzG+bBm4IP1+FNsuoq0UW6pN/X9vIgQvrZ46+W4RQItMUay?=
 =?us-ascii?Q?JxK1x9p/fYOezbvU9g5v4HGaO71ZhiCUJ5mNS5me6LicIZufSIjCvUmx41py?=
 =?us-ascii?Q?K6fNpbAI4tYWlgdCN7RhprVyINZB/Hdrdqsdnsu6s3/jZJJ9+AKUglqGl89N?=
 =?us-ascii?Q?5B51AsXJzaArDWz06P/TGWc2I+jPFe4NhvSCZuF+AoY0AaOtwh4yCLpTcZ3a?=
 =?us-ascii?Q?cWh9J7K4HmCVCxJ18kaol89hmnnHsueyD6WTGL0x+/zbvel7QXXb0z7y5CtY?=
 =?us-ascii?Q?9SNSGt+oN25w1IA1051se91NLGbatloARiw4EhKXweuIAfOM4C851uMwIn1+?=
 =?us-ascii?Q?uSuCuGE82wjfyVxrE2oF7x7t2sdTutNUmy6Wj6FC40VkQ6bUofikMQiqmCtK?=
 =?us-ascii?Q?UpF71217BLGF/iVZqCTih+cRf+eygb4KaKqEDin87+EHQ+0ZFG8Vk8ieVJ99?=
 =?us-ascii?Q?0T5zxgv8+IeuQqd2QVo3Y0+KWvCFYnfQHzKSjbp2E9Ldj8mKZLwxqV7gYYjZ?=
 =?us-ascii?Q?Hg//uODuhjQ1UBdAavO2PiQFNlXPsX9zkRGTUma17CRzYbdNeHCFQbVJOFL6?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a9eb68-53d4-4529-a34f-08dcc05deb1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:47:59.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPH7ODHsAacfzUu2RZj2sjvpwrcMu7RS09jUPOb1Q9kynhzG+H7N9IvceLz97o4fVpMGADwYoixxFbC37lc5ZyXf9KM2j35Gi4mol02FMto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 11:24:04AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy receive path.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc().
> 
> Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
> is enabled.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg(),
>        RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
>        move stats update and xdp finalize to common functions,
>        READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |   8 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 132 +++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 297 +++++++++++++++++++++++++++++-
>  3 files changed, 399 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 8db5b44b4576..348f32f4c11c 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -87,6 +87,7 @@ struct igb_adapter;
>  #define IGB_XDP_CONSUMED	BIT(0)
>  #define IGB_XDP_TX		BIT(1)
>  #define IGB_XDP_REDIR		BIT(2)
> +#define IGB_XDP_EXIT		BIT(3)
>  
>  struct vf_data_storage {
>  	unsigned char vf_mac_addresses[ETH_ALEN];
> @@ -741,6 +742,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
>  void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
> @@ -829,6 +833,10 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		       struct xsk_buff_pool *pool,
>  		       u16 qid);
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 9234c768a600..063ba0144dfd 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
>  
>  		for (i = 0; i < rx_ring->count; i++) {
>  			const char *next_desc;
> -			struct igb_rx_buffer *buffer_info;
> -			buffer_info = &rx_ring->rx_buffer_info[i];
> +			dma_addr_t dma = (dma_addr_t)0;
> +			struct igb_rx_buffer *buffer_info = NULL;
>  			rx_desc = IGB_RX_DESC(rx_ring, i);
>  			u0 = (struct my_u0 *)rx_desc;
>  			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
>  
> +			if (!rx_ring->xsk_pool) {
> +				buffer_info = &rx_ring->rx_buffer_info[i];
> +				dma = buffer_info->dma;
> +			}
> +
>  			if (i == rx_ring->next_to_use)
>  				next_desc = " NTU";
>  			else if (i == rx_ring->next_to_clean)
> @@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
>  					"R  ", i,
>  					le64_to_cpu(u0->a),
>  					le64_to_cpu(u0->b),
> -					(u64)buffer_info->dma,
> +					(u64)dma,
>  					next_desc);
>  
>  				if (netif_msg_pktdata(adapter) &&
> -				    buffer_info->dma && buffer_info->page) {
> +				    buffer_info && dma && buffer_info->page) {
>  					print_hex_dump(KERN_INFO, "",
>  					  DUMP_PREFIX_ADDRESS,
>  					  16, 1,
> @@ -1983,7 +1988,10 @@ static void igb_configure(struct igb_adapter *adapter)
>  	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
> +		if (ring->xsk_pool)
> +			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
> +		else
> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>  	}
>  }
>  
> @@ -4425,7 +4433,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index, 0);
> +			       rx_ring->queue_index,
> +			       rx_ring->q_vector->napi.napi_id);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);
> @@ -4721,12 +4730,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	struct e1000_hw *hw = &adapter->hw;
>  	int reg_idx = ring->reg_idx;
>  	u32 srrctl = 0;
> +	u32 buf_size;
>  
> -	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	if (ring_uses_large_buffer(ring))
> -		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +	if (ring->xsk_pool)
> +		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +	else if (ring_uses_large_buffer(ring))
> +		buf_size = IGB_RXBUFFER_3072;
>  	else
> -		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +		buf_size = IGB_RXBUFFER_2048;
> +
> +	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>  	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
>  	if (hw->mac.type >= e1000_82580)
>  		srrctl |= E1000_SRRCTL_TIMESTAMP;
> @@ -4758,9 +4772,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	u32 rxdctl = 0;
>  
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> -	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -					   MEM_TYPE_PAGE_SHARED, NULL));
>  	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
> +	if (ring->xsk_pool) {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_XSK_BUFF_POOL,
> +						   NULL));
> +		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +	} else {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_PAGE_SHARED,
> +						   NULL));
> +	}
>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> @@ -4787,9 +4809,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	rxdctl |= IGB_RX_HTHRESH << 8;
>  	rxdctl |= IGB_RX_WTHRESH << 16;
>  
> -	/* initialize rx_buffer_info */
> -	memset(ring->rx_buffer_info, 0,
> -	       sizeof(struct igb_rx_buffer) * ring->count);
> +	if (ring->xsk_pool)
> +		memset(ring->rx_buffer_info_zc, 0,
> +		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
> +	else
> +		memset(ring->rx_buffer_info, 0,
> +		       sizeof(*ring->rx_buffer_info) * ring->count);
>  
>  	/* initialize Rx descriptor 0 */
>  	rx_desc = IGB_RX_DESC(ring, 0);
> @@ -4976,8 +5001,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
>  
>  	rx_ring->xdp_prog = NULL;
>  	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> -	vfree(rx_ring->rx_buffer_info);
> -	rx_ring->rx_buffer_info = NULL;
> +	if (rx_ring->xsk_pool) {
> +		vfree(rx_ring->rx_buffer_info_zc);
> +		rx_ring->rx_buffer_info_zc = NULL;
> +	} else {
> +		vfree(rx_ring->rx_buffer_info);
> +		rx_ring->rx_buffer_info = NULL;
> +	}
>  
>  	/* if not set, then don't free */
>  	if (!rx_ring->desc)
> @@ -5015,6 +5045,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  	dev_kfree_skb(rx_ring->skb);
>  	rx_ring->skb = NULL;
>  
> +	if (rx_ring->xsk_pool) {
> +		igb_clean_rx_ring_zc(rx_ring);
> +		goto skip_for_xsk;
> +	}
> +
>  	/* Free all the Rx ring sk_buffs */
>  	while (i != rx_ring->next_to_alloc) {
>  		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
> @@ -5042,6 +5077,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  			i = 0;
>  	}
>  
> +skip_for_xsk:
>  	rx_ring->next_to_alloc = 0;
>  	rx_ring->next_to_clean = 0;
>  	rx_ring->next_to_use = 0;
> @@ -8186,6 +8222,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  	struct igb_q_vector *q_vector = container_of(napi,
>  						     struct igb_q_vector,
>  						     napi);
> +	struct xsk_buff_pool *xsk_pool;
>  	bool clean_complete = true;
>  	int work_done = 0;
>  
> @@ -8197,7 +8234,12 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  		clean_complete = igb_clean_tx_irq(q_vector, budget);
>  
>  	if (q_vector->rx.ring) {
> -		int cleaned = igb_clean_rx_irq(q_vector, budget);
> +		int cleaned;
> +
> +		xsk_pool = READ_ONCE(q_vector->rx.ring->xsk_pool);
> +		cleaned = xsk_pool ?
> +			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
> +			igb_clean_rx_irq(q_vector, budget);
>  
>  		work_done += cleaned;
>  		if (cleaned >= budget)
> @@ -8861,6 +8903,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
>  	rx_buffer->page = NULL;
>  }
>  
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
> +{
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +
> +	if (status & IGB_XDP_REDIR)
> +		xdp_do_flush();
> +
> +	if (status & IGB_XDP_TX) {
> +		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		igb_xdp_ring_update_tail(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +}
> +
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes)
> +{
> +	struct igb_ring *ring = q_vector->rx.ring;
> +
> +	u64_stats_update_begin(&ring->rx_syncp);
> +	ring->rx_stats.packets += packets;
> +	ring->rx_stats.bytes += bytes;
> +	u64_stats_update_end(&ring->rx_syncp);
> +
> +	q_vector->rx.total_packets += packets;
> +	q_vector->rx.total_bytes += bytes;
> +}
> +
>  static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  {
>  	unsigned int total_bytes = 0, total_packets = 0;
> @@ -8868,9 +8942,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	struct igb_ring *rx_ring = q_vector->rx.ring;
>  	u16 cleaned_count = igb_desc_unused(rx_ring);
>  	struct sk_buff *skb = rx_ring->skb;
> -	int cpu = smp_processor_id();
>  	unsigned int xdp_xmit = 0;
> -	struct netdev_queue *nq;
>  	struct xdp_buff xdp;
>  	u32 frame_sz = 0;
>  	int rx_buf_pgcnt;
> @@ -8992,24 +9064,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	/* place incomplete frames back on ring for completion */
>  	rx_ring->skb = skb;
>  
> -	if (xdp_xmit & IGB_XDP_REDIR)
> -		xdp_do_flush();
> -
> -	if (xdp_xmit & IGB_XDP_TX) {
> -		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> -
> -		nq = txring_txq(tx_ring);
> -		__netif_tx_lock(nq, cpu);
> -		igb_xdp_ring_update_tail(tx_ring);
> -		__netif_tx_unlock(nq);
> -	}
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);
>  
> -	u64_stats_update_begin(&rx_ring->rx_syncp);
> -	rx_ring->rx_stats.packets += total_packets;
> -	rx_ring->rx_stats.bytes += total_bytes;
> -	u64_stats_update_end(&rx_ring->rx_syncp);
> -	q_vector->rx.total_packets += total_packets;
> -	q_vector->rx.total_bytes += total_bytes;
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
>  
>  	if (cleaned_count)
>  		igb_alloc_rx_buffers(rx_ring, cleaned_count);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 7b632be3e7e3..2ae16ae99193 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -70,7 +70,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  	 * at least 1 descriptor unused to make sure
>  	 * next_to_use != next_to_clean
>  	 */
> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +	if (rx_ring->xsk_pool)
> +		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
> +	else
> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>  
>  	/* Rx/Tx share the same napi context. */
>  	napi_enable(&rx_ring->q_vector->napi);
> @@ -169,6 +172,298 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		igb_xsk_pool_disable(adapter, qid);
>  }
>  
> +static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +			     union e1000_adv_rx_desc *rx_desc, u16 count)
> +{
> +	dma_addr_t dma;
> +	u16 buffs;
> +	int i;
> +
> +	/* nothing to do */
> +	if (!count)
> +		return 0;
> +
> +	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	for (i = 0; i < buffs; i++) {
> +		dma = xsk_buff_xdp_get_dma(*xdp);
> +		rx_desc->read.pkt_addr = cpu_to_le64(dma);
> +		rx_desc->wb.upper.length = 0;
> +
> +		rx_desc++;
> +		xdp++;
> +	}
> +
> +	return buffs;
> +}
> +
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
> +{
> +	u32 nb_buffs_extra = 0, nb_buffs = 0;
> +	union e1000_adv_rx_desc *rx_desc;
> +	u16 ntu = rx_ring->next_to_use;
> +	u16 total_count = count;
> +	struct xdp_buff **xdp;
> +
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	xdp = &rx_ring->rx_buffer_info_zc[ntu];
> +
> +	if (ntu + count >= rx_ring->count) {
> +		nb_buffs_extra = igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
> +						   rx_desc,
> +						   rx_ring->count - ntu);
> +		if (nb_buffs_extra != rx_ring->count - ntu) {
> +			ntu += nb_buffs_extra;
> +			goto exit;
> +		}
> +		rx_desc = IGB_RX_DESC(rx_ring, 0);
> +		xdp = rx_ring->rx_buffer_info_zc;
> +		ntu = 0;
> +		count -= nb_buffs_extra;
> +	}
> +
> +	nb_buffs = igb_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> +	ntu += nb_buffs;
> +	if (ntu == rx_ring->count)
> +		ntu = 0;
> +
> +	/* clear the length for the next_to_use descriptor */
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	rx_desc->wb.upper.length = 0;
> +
> +exit:
> +	if (rx_ring->next_to_use != ntu) {
> +		rx_ring->next_to_use = ntu;
> +
> +		/* Force memory writes to complete before letting h/w
> +		 * know there are new descriptors to fetch.  (Only
> +		 * applicable for weak-ordered memory model archs,
> +		 * such as IA-64).
> +		 */
> +		wmb();
> +		writel(ntu, rx_ring->tail);
> +	}
> +
> +	return total_count == (nb_buffs + nb_buffs_extra);
> +}
> +
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
> +{
> +	u16 ntc = rx_ring->next_to_clean;
> +	u16 ntu = rx_ring->next_to_use;
> +
> +	while (ntc != ntu) {
> +		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc >= rx_ring->count)
> +			ntc = 0;
> +	}
> +}
> +
> +static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
> +					    struct xdp_buff *xdp,
> +					    ktime_t timestamp)
> +{
> +	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> +	unsigned int metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +
> +	net_prefetch(xdp->data_meta);
> +
> +	/* allocate a skb to store the frags */
> +	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	if (timestamp)
> +		skb_hwtstamps(skb)->hwtstamp = timestamp;
> +
> +	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> +	       ALIGN(totalsize, sizeof(long)));
> +
> +	if (metasize) {
> +		skb_metadata_set(skb, metasize);
> +		__skb_pull(skb, metasize);
> +	}
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *igb_run_xdp_zc(struct igb_adapter *adapter,
> +				      struct igb_ring *rx_ring,
> +				      struct xdp_buff *xdp,
> +				      struct xsk_buff_pool *xsk_pool)
> +{
> +	int err, result = IGB_XDP_PASS;
> +	struct bpf_prog *xdp_prog;
> +	u32 act;
> +
> +	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +	if (!xdp_prog)
> +		goto xdp_out;

Reading prog per packet is inefficient plus pool pointer is only valid
(non-null) when prog is also non-null. This means null prog for ZC path
will not happen as you trigger it for non-null pool pointer state.

Therefore please read prog one time at the beginning of rx zc clean
routine and use it for current napi instance.

> +
> +	prefetchw(xdp->data_hard_start); /* xdp_frame write */
> +
> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +
> +	if (likely(act == XDP_REDIRECT)) {
> +		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
> +		if (!err) {
> +			result = IGB_XDP_REDIR;
> +			goto xdp_out;
> +		}
> +
> +		if (xsk_uses_need_wakeup(xsk_pool) &&
> +		    err == -ENOBUFS)
> +			result = IGB_XDP_EXIT;
> +		else
> +			result = IGB_XDP_CONSUMED;
> +		goto out_failure;
> +	}
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		break;
> +	case XDP_TX:
> +		result = igb_xdp_xmit_back(adapter, xdp);
> +		if (result == IGB_XDP_CONSUMED)
> +			goto out_failure;
> +		break;
> +	default:
> +		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +out_failure:
> +		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		result = IGB_XDP_CONSUMED;
> +		break;
> +	}
> +xdp_out:
> +	return ERR_PTR(-result);
> +}
> +
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget)
> +{
> +	struct igb_adapter *adapter = q_vector->adapter;
> +	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_ring *rx_ring = q_vector->rx.ring;
> +	u16 ntc = rx_ring->next_to_clean;

I believe that at some point we said to avoid stack-based variables
smaller than 4 bytes as it requires the compiler to produce more
(unnecessary) insns. please just use u32 here.

> +	unsigned int xdp_xmit = 0;
> +	bool failure = false;
> +	u16 entries_to_alloc;
> +	struct sk_buff *skb;
> +
> +	while (likely(total_packets < budget)) {
> +		union e1000_adv_rx_desc *rx_desc;
> +		ktime_t timestamp = 0;
> +		struct xdp_buff *xdp;
> +		unsigned int size;
> +
> +		rx_desc = IGB_RX_DESC(rx_ring, ntc);
> +		size = le16_to_cpu(rx_desc->wb.upper.length);
> +		if (!size)
> +			break;
> +
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +
> +		xdp = rx_ring->rx_buffer_info_zc[ntc];
> +		xsk_buff_set_size(xdp, size);
> +		xsk_buff_dma_sync_for_cpu(xdp);
> +
> +		/* pull rx packet timestamp if available and valid */
> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +			int ts_hdr_len;
> +
> +			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> +							 xdp->data,
> +							 &timestamp);
> +
> +			xdp->data += ts_hdr_len;
> +			xdp->data_meta += ts_hdr_len;
> +			size -= ts_hdr_len;
> +		}
> +
> +		skb = igb_run_xdp_zc(adapter, rx_ring, xdp, xsk_pool);
> +
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
> +				xdp_xmit |= xdp_res;
> +			} else if (xdp_res == IGB_XDP_EXIT) {
> +				failure = true;
> +				break;
> +			} else if (xdp_res == IGB_XDP_CONSUMED) {
> +				xsk_buff_free(xdp);
> +			}
> +
> +			total_packets++;
> +			total_bytes += size;
> +			ntc++;
> +			if (ntc == rx_ring->count)
> +				ntc = 0;
> +			continue;
> +		}
> +
> +		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
> +
> +		/* exit if we failed to retrieve a buffer */
> +		if (!skb) {
> +			rx_ring->rx_stats.alloc_failed++;
> +			break;
> +		}
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc == rx_ring->count)
> +			ntc = 0;
> +
> +		if (eth_skb_pad(skb))
> +			continue;
> +
> +		/* probably a little skewed due to removing CRC */
> +		total_bytes += skb->len;
> +
> +		/* populate checksum, timestamp, VLAN, and protocol */
> +		igb_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +		napi_gro_receive(&q_vector->napi, skb);
> +
> +		/* update budget accounting */
> +		total_packets++;
> +	}
> +
> +	rx_ring->next_to_clean = ntc;
> +
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);
> +
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
> +
> +	entries_to_alloc = igb_desc_unused(rx_ring);
> +	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
> +		failure |= !igb_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
> +
> +	if (xsk_uses_need_wakeup(xsk_pool)) {
> +		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> +			xsk_set_rx_need_wakeup(xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(xsk_pool);
> +
> +		return (int)total_packets;
> +	}
> +	return failure ? budget : (int)total_packets;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> 
> -- 
> 2.39.2
> 

