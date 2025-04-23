Return-Path: <bpf+bounces-56529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB52A99772
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43641B86EFD
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0528DEEB;
	Wed, 23 Apr 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsWD0/ud"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE608F40;
	Wed, 23 Apr 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431371; cv=fail; b=U+QsuGpWlBQk9yrkQCcQts8P8NUrdELrg7y9Cz/Q8dpXPuNh/7I9q3xs0Z0S8ti40Oc2V0vx7LJ+qBf2jBZozUuVO8vGzZ9twvWOBAqK4B2sB3bb7JIFNft/WHBsAp8i3cKWtFdcr5/WGxhsNKjB0s9CKpRd91NjsdOrk09/5M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431371; c=relaxed/simple;
	bh=nVo0+sd4cfSJNJtWmbSK7uQOZUJu6eNK5ZQ0EC0shQ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=htKSfx3ZX9HZfWceP+aT2eigWGFxJwAdy8aIscUdsiA3B8/70SlG34aQ+tO2c1MAU/r9xZ8i63VcvD5rloSvIm7iiO7nE58HQHAg0VO+5i+bBk3ENJbLV4xk1B6Q4h5+oWtd4F6WbpAc95O/lLhkxW7IW2KSywZRxNmHMsFVY7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsWD0/ud; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745431370; x=1776967370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nVo0+sd4cfSJNJtWmbSK7uQOZUJu6eNK5ZQ0EC0shQ0=;
  b=hsWD0/udvKylPK5XSLOVoDxnD0iNqacRevN79S8llppxKlN3ct3LxmE1
   R8GtRmG7EjR35IIrEzxQQQcZvDVot5OhmiM4Z+kaXnGzy9YukeuBdgsVx
   8MNO8tnVNR+rrvW+CaHk9V8TNiRmN22teMrTEywMo+tnUyPKQsb4JKzF6
   vmwtpWsPYRB29tW7aYgWbah8D7xHXWs8XBw9BR2XEASi+jwTbI6tVUKvB
   SWyBSmZ5GzTGdDIqM9blCvXSKNxGypHKGALgug761iXXhmdzeBe7KOkwV
   u18GrmbseMDoX2bdY61DY3BcrLgxQKFTyDmXGhCzpZgYbJlKQ3EpFmnGO
   w==;
X-CSE-ConnectionGUID: tX7vGfDRRli6TLeKObGWoQ==
X-CSE-MsgGUID: pJGvqscPQwOiDBa/KXSnlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57233353"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57233353"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 11:02:49 -0700
X-CSE-ConnectionGUID: rh2r84q1SVGu0o9nujGCJQ==
X-CSE-MsgGUID: AReP/zxpRgyaI4ycoGmv7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132228028"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 11:02:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 11:02:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 11:02:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 11:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtK5tSbo/Lub1LsNDSJ8y8UFO7OIJm1raCdL+yPLjzFuhvXXqziS6aCZSX0+27eJ7c/UNkMmWN2cqE1oa1lO8M5d7CJVJn8mccrQtcNQSgQLTYTFj2XPgfSjGNW/qLCO9bd6EI2oFkKcZQYnvBqLvBrZSrVPtplFdEctNUicAT1ctn5/SeaRo4TTGWmFLRGHV/eg7McMFHGUh7Q2KB2VdCYeW9xjw5IXPsMnHluSmswjLjt9/htPL7gcabyO9VObj4kH1IqQLm1IMut53RWIUT+LshlJtsVImaLJyxtnclj+zLPElkk0T5H5XuBV9WCmIJB4npJRxzfXQbwnWLGhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAFyjYj+dq0q//w7ja3tvE8q8IJ+MYLm/IAqcsTRc4U=;
 b=yn6YLwFh1sL6cdHs8hBFACc2cHIlsLtwomm+frcf5l48nrgW2qx2eauykDPU+cOV4e8UnrZfBzBZ9pj1MszD5/7XUgVCUcvQarKTirHpvmtupZapByJ6R06bjjC7kOD1HSENPLY4gnR3iZcn+wOd/vj/ONVCW59kKGAUswlVxzSh0LlP7MhRwhg5IgO3IN2ZJpvFzkwfoUdj1RevJBiXnhhih9cxxWFdWU1XWDDY8wDDvLL6JAaiXnJOB+ioxrBkB/GxzgMLIcRCAmRcmjqL0W7w2QpFbpSgKh0/Q30s5vaQ8KCQ0M3uOsSNp0dOXhEtEgArNi9UZ06SPbEvs1u6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 18:02:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:02:04 +0000
Date: Wed, 23 Apr 2025 20:01:57 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
Message-ID: <aAkrFcSpxwdb+2tA@boxer>
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
 <aAj8DfHJ_XZxrDSJ@mini-arch>
 <6ed8452b-f370-4443-94ce-f7d65cd51a9e@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ed8452b-f370-4443-94ce-f7d65cd51a9e@gmail.com>
X-ClientProxiedBy: DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: b68832cd-6da5-421f-3c28-08dd8290f41f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eVUE7O+h2X83r2t58xZy5Ac4miS6RO6BNYEhNcF6LTnmN36gBO/UKZQ/wnA5?=
 =?us-ascii?Q?RbKwj2k6D8bx7H2cu8SVru4QNd0PHmKawjOc83N9j2L8KcI1s0mnxUuLFv4+?=
 =?us-ascii?Q?tycaSlPdauC1uLEcY22ViH0xWi7tPXgkRPozjB7eIuwxR/icP2kwg4O8LtQP?=
 =?us-ascii?Q?J8IfwF6vp3x7BMQXAwxP7aIfzvCJxbeMiu65CqLsA0BpvDtyU8W3/Uug3XHf?=
 =?us-ascii?Q?vgV/blGettZOETi9zplPG5scThswhOK/9sspJ3LZU6TY9XO2xy4boGDVqpnw?=
 =?us-ascii?Q?wZeMKRUfmeUutcS4hTLdzR0yipn2sXOvzCyWiiQM4yVhZAG45qJl+c/2RDhE?=
 =?us-ascii?Q?kj93g2QPpckq3CEr9yEkdL9OBl07s7rKTqoEwQN2FnAyuRz9hgjgjiJ6x2pj?=
 =?us-ascii?Q?ooNZNkhA0jdHipsVZ8DhC4bJgqDz80GPfNZRq40SxPJvaZPh3Vt6zv3wEwM4?=
 =?us-ascii?Q?+Ofwi5cpNaXxPOlwLIUXwn99xtwt6+EHmSspZ7a6jsTgZKLGbrlgDzsJEogq?=
 =?us-ascii?Q?oZbmBqaXYeJDTrwdYUKJazS6x4RAJYWPwCRkNsc3Vg/r2wOQGfYLzMw6qlCK?=
 =?us-ascii?Q?sXFP5CDGDyHbPKjBHBGVnPVa5FfCzdqaMgmwUHbKlritGonrR0YwRkni3nFH?=
 =?us-ascii?Q?u/augkvdNzSm/jc9v5pftGuSCakVfIahpkmu7zxhZdk91QxZB+QwWG7d2TmJ?=
 =?us-ascii?Q?IwJ+gZvdw5ha+3PICJRv5rh0anLjHbA2SIs75r9Etn0OqbcIIYM6jwOYkyY9?=
 =?us-ascii?Q?oishNPa2FPskNjkrcot7LaIXnpe0jjn0nOuqsFgJFqXDHOIMgXs3QKHTsBET?=
 =?us-ascii?Q?pLCHNz6UWNuc+54ZlcobwkDrYAHV9XWzDkXofXKKRLPiirkONb11nJTcosVO?=
 =?us-ascii?Q?wHvSHDNFMmgpRRJWpBWU4Hp+e6qDKscQvwY4DCoMfXHuo0+LqDdXzuyw8ei0?=
 =?us-ascii?Q?G/OSJ4lu4kq4yErF4A+2kATAKjYPqx0I0+2i7MBr/vAHWsXAE/bZsS87DUfi?=
 =?us-ascii?Q?Q+CznnpfHQYh2qjaxrxSnHYTadfXGTg+uT+PNKZHCZa95+86WQm7Plt0Hy2j?=
 =?us-ascii?Q?KzY4Kx9jyG4aDIz9gR9M7L7+5Plqs8oTfxWiylDD2pLGF3izS5ztPo6b6xh5?=
 =?us-ascii?Q?+rx3qj7Qnp9v68Y8JNhzayIeGO/NFILLY9QT3ZFVMQIH7AwnwMNEKIxvwZx6?=
 =?us-ascii?Q?jIreU+v3/1a0m4p3k/1nK6WTmEFCyIRk5jx5MpNgvImEP1DHFU2kiaTrAuil?=
 =?us-ascii?Q?TdXhvTFbj817TyZdWwbPsiV55JS0tIa2HLM/mIK4xL7Pw9IJwUrLuNJEwFJC?=
 =?us-ascii?Q?VNPL+wVhVsX/6kHxnGqGc1BBPbttgzeJnj31E+SIWHOAR/HzefhgDAFWNEne?=
 =?us-ascii?Q?KO7bx7fG/ZkCrWFpf1ckGzYIUK/Igx/1iJb0H/U1pBDJdtxUWUR/30JlYgFi?=
 =?us-ascii?Q?bXma3j6XhK8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uM4Lsl2MjwmPSrSkKmJ/FhHQRv5H+AnPWsR84Oqxw8FZMJFQA6eILWBgzDQk?=
 =?us-ascii?Q?K+qaRP95jJNI92jLPqBpCt8VucIrvbml57ldBE8uK51W+PQPNcgoPA5L2N5X?=
 =?us-ascii?Q?/81mkTCj4zXlpag8THc5dwSFkP6giQRvLjbECevWyoPD4Gr2LS2YQ185OtGA?=
 =?us-ascii?Q?tQmFLLqTPu37cEcSapAU9Syt0p8w1w9XQ6DLqNkL/AMXBDgUhqRfGlzYzdCh?=
 =?us-ascii?Q?EWubIQWhm9jYPW5O2ZDAsRsOyH1dFidKHIRwsWcrd2t3eFH0J82g+R70hqs0?=
 =?us-ascii?Q?BYmw4DDacmh7d+451RyJRnGp1wCMs57Xiz6+ck5VvXG3QVbOQ8WygYcUynOt?=
 =?us-ascii?Q?o0xPEIU/oG8Ac4nQDmLp4Q6rTjmBsI5MpMQUEspOqLflJJba/jR38VtYQPVB?=
 =?us-ascii?Q?43DQV3eTabsSFnWRTQBHzO2uK5Q0u3MmO7JpdxoNY76y3hoRMlA5JaQW1Vq6?=
 =?us-ascii?Q?P7AIbAw4tnOKIAicY7cqglWB8PImHggWciTtMbjEBx3lls5OmysC3648IeHm?=
 =?us-ascii?Q?GkBVQJtlVU5e6duwNxJY+4zickNmDwXz556K69MJA4yLz6GPj0LiN1g854Gc?=
 =?us-ascii?Q?KTWAX1bzR9PlA6C8YmETsqptHXKZuDSku0CXHKUzLO9346LFD2DO0RvNNOKu?=
 =?us-ascii?Q?u8183snjHES9IUtcctmUyGNg2aQrEDthpBHyeVin1RV4WUr3Ofi97IoMns3y?=
 =?us-ascii?Q?IhZL/BaaWL7p1yUwLZw5Va95urYKHL3YrqZDk5mJFJnTs+O8Ev+6f9mc5sq1?=
 =?us-ascii?Q?oXtUqCEud+4FVLJtXzEmj6vToTz+li/Rh1N7R6fRxjo+U0CbtopnUwRwzk1e?=
 =?us-ascii?Q?FmjAWmBNt0v8DieR/rhyr1YkXwgXBtOx0CJGwEs2eh9kuwaBieI+s419UG2v?=
 =?us-ascii?Q?VCrRQpgLxJpA2UP7h5VZGm4eEc46pN1vNNhjwYOcfK/uhr+RsWr3sCAn810X?=
 =?us-ascii?Q?6aP64CKpIaaDB60aP2do1O8UkBE8Ply4fmQSKQFLMnL6dknwzjBz9mNGIUwJ?=
 =?us-ascii?Q?4Sbq1yU3ta6TCkKBMEm9bCCJyZlhZH8fvkPL+DEDdjsZa21HAyltnUPS3YDj?=
 =?us-ascii?Q?6cWkOTyEMhf4Euzfs2Ke29IYxqP4wp487LDDKDipUbPHgu+AY+kUw2gP45po?=
 =?us-ascii?Q?0SbLMHP24Y3Udloc25tb2oXaalv/xhx3zWnDtJyzxJyTI2yQ9mXRriu3uXle?=
 =?us-ascii?Q?XbunRNB6DtYi7O1SC0QBoN31LZe/HrQIyB9WkpC655Y9Zn2e4SPdjKJf7Ehj?=
 =?us-ascii?Q?mEBVyPhBlin58f9rRP2nTM5iTYQvX2ol2f0IAkcRLCwS9SIS6NOWjE5zRr9s?=
 =?us-ascii?Q?I10OnDShEaMVLLMjkNhEAvlaTugDM7uyiBF15MkjtEVXbPveU/beEELEgDEa?=
 =?us-ascii?Q?Wx/sFbA0hc17TqlAJq7Ub/lEa/Ubal0epSaaXnAXRiJ2uqNoQX7rPRSLrUKb?=
 =?us-ascii?Q?XyCxogpkFqajzF+okeB/5rWAIJ4t1S6h5kwDiL9xEoY/BrgwbNho+ZTyYnMa?=
 =?us-ascii?Q?5FUCt+k44RS3uIsDWTkvEeFTocVailKSrGgwu5BALoSr0Hg/Zvq8OIuKMAof?=
 =?us-ascii?Q?1chiFf+VQlLOWs3gHBegNOE1Cem0SW0E0ymDY8iPMEBmV3WwCjHK031nS/Qu?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68832cd-6da5-421f-3c28-08dd8290f41f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 18:02:04.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMAkxfA5dZ7U3ydyYopTcOTfOuEHJIqoykkAXPJ4Ds3ZrjGs4Kx84o/nUgITCSrEBnF2C8samNfPzUKbqX0IKjQO32ZGEU9+XlVCwYIC9c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
X-OriginatorOrg: intel.com

On Wed, Apr 23, 2025 at 09:58:16PM +0700, Bui Quang Minh wrote:
> On 4/23/25 21:41, Stanislav Fomichev wrote:
> > On 04/23, Bui Quang Minh wrote:
> > > Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
> > Can you please share more about how you've hit this problem?
> > I don't see the caller of this function (xdp_build_skb_from_zc)
> > being used at all.
> > 
> > Alexander, do you have plans to use it? Or should we remove it for now?

libeth xdp support uses this:
https://lore.kernel.org/netdev/20250415172825.3731091-15-aleksander.lobakin@intel.com/

> Hi,
> 
> I've been playing around to add support for zerocopy XDP socket with multi
> buffer mergeable buffer in virtio-net (this TODO: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/virtio_net.c#n1312).
> In that case, I'll have a XDP buff with frags. When we have XDP_PASS return,
> I need to convert the XDP buff with frags to skb with frags, so I think the
> helper is quite helpful. I used it and got packet dropped due to checksum
> error. Debugging the problem, I've found out this issue which makes the
> skb's frag data incorrect.

Nice! I'll take a look at patch content tomorrow and probably ack it.

> 
> Thanks,
> Quang Minh.

