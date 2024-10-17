Return-Path: <bpf+bounces-42302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA759A22F3
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE371F22AC3
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC01DDA31;
	Thu, 17 Oct 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieMF+fmV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A61DC19F;
	Thu, 17 Oct 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170313; cv=fail; b=H/+2wHjqBUvJJtW751xlf3De4VnNXLDWP0mkkN9PR6lTMm68K1ObCo1YdcRNDlKtiz3YLpShduVQmnPc4srDCZZhaDRZ/37w+hJYpOU8vX7tcbVUQI76WT9CSJHEd7xu8L5Ugw016p5Kb+wS1/saf8zD/UjAAutSZi829tUisUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170313; c=relaxed/simple;
	bh=kPTf91ugEcAa411ThxkhdCRC74D04S5IUknCbT/W5Vo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKzJgMrHrmpATi6DMrZ/BexnyikC5c2+Cd0MHTPMmnC5hhj/B/hqEg+itxyatqC+6vryP7mcG0KlBQgAxl/AZyXBIkYtSliZDuTqR8xLerHJ8vnyTITKIMMtvRE33Yb5eV37NgpGLlm+hjIZrMktwB0Hjhg6T1mEPKcsw6bdE3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieMF+fmV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729170311; x=1760706311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kPTf91ugEcAa411ThxkhdCRC74D04S5IUknCbT/W5Vo=;
  b=ieMF+fmVkZkqrWp3T+KTwAHM47cvzLGPbVBmeWhmd1TAwdiVcGu3iqfl
   jz7V/DA6xZHPizGu/SfUwqIXmP5EYv8O287651911/c3QtqwesD4GoBwB
   gK2noc6qGYKtSUepD+s6pXyvIXNpZXEoAs00G1JUupRfbH22F2bwdPuMT
   CvWrJZDJ/+hMYr0MWgA8BhL6CR7sNZ9EfeHrYrGQUzYHMZsbZR2LPjvZe
   afe+PTt38ufy2Q/fXzkJ1PN0YYPaNJm9PKlmt2QW/A05A8SG6KoCtgxBl
   loNmHHpjFaLWwharIeJtqb3hUP+cFcMoHBxX3nqIi/KeAwTEdqCqriWX1
   A==;
X-CSE-ConnectionGUID: ffMVGRlPQyawrfuk+kvsvA==
X-CSE-MsgGUID: +IvhUbl2TO2V3WWprcRXJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28092929"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28092929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:05:10 -0700
X-CSE-ConnectionGUID: 47qPE3YvTveJYWzeZn0T2w==
X-CSE-MsgGUID: A/dUatSWSHe6Om6zVa8z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78438029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 06:05:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 06:05:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 06:05:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 06:05:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 06:05:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 06:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gni3U59pvb/ilYTUpTYXewGuONfaUGhIfxsGpzGeX/h3HZn9tTV9BknLJ97+83JUYhKn3PDzIsl9VyHP2Mg0kSiynH5LqDtmu6A1aRO2eWF4z0Yo3CaEGmB8FfexDZKNmmBs9l/TnWWl1Igv6zLJVNCel07DfE3pF83zxRk+oAegxQUCUCRp/fS/ZGbvz4Jk39CgixqyofrHVL4Eb5ZIg6QrhXNuFSnYqGJyfTw61eDbxzAP9L32/QxfSfGjjtQtdSv3uUftuoz8St+Qfv/Xa/mRR33YH+Z6pnctQpaWUHcnNn5jiwTBw/J2N0ex/CiTmq4dVAw7D6xk5VLNDgKypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JrA46q5RCnJtDi2p4Hxi5fGmSsEIfgLP+wQsqEys8E=;
 b=NqPVd/Az6EotOKZWBtM3jWpSU9JiLTVKJql7iWCRPTIY1firbImr9cnwl3qn4q70tyBucLPD1xZjjEL9odXbU1HyEQO1A/hbX1y6ObQE2xcOrEFgzeA9Ip6BSlcL7AvhgX98zzcwiWvJpwkiY4kNxjQFibMkXGJxBteDZ7zVE5kBEuh3pNTwqM+jdUZI0RlTqDdGnxyUaaNZCWSVZhn6t9H4/yv/6svbrVIfJh261hb9vDEeo3IQSJWuWX1vsj2Kn9IPlb+1a/pnNeMrM9f+8s+b1GY4Gi+EiPxOdcgB4LlPQEu8gLT097fUIY3A6hZDy/3jBYtGTWD8dFLgvp8sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:04:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 13:04:37 +0000
Date: Thu, 17 Oct 2024 15:04:25 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 14/18] xsk: make xsk_buff_add_frag really add
 a frag via __xdp_buff_add_frag()
Message-ID: <ZxELWQeV7uBVN6YP@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-15-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-15-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR2P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0beba5-384a-454d-5f83-08dceeac412b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MpLGyTkUntQZizuwTe8UvdHUMCVPGF4sDqZ7N4xtPvxHcu8ACH3F6juFUuvP?=
 =?us-ascii?Q?oSNGEu1sTnXK5gMn8+k6kpse15AGsnDMPfd2EyJx0yjgQM4z5ChNwOppdO0f?=
 =?us-ascii?Q?EpbmdgQIcGzRG2mKoxbYb1EU38f12RIhDiwVeV3utCJ1cMl3ADerG5KdsGWh?=
 =?us-ascii?Q?L+T671zJYdep4TA4l6y88r0eQKYpgsR7OlOtGX0LNNo9G/xp6zA1vLkyxjgF?=
 =?us-ascii?Q?frGLBQN9k5oTfHjbMnUMbZus6vk2eTIXh59Mu9ZQJ1PSJgeiH0B4uKsHZh/j?=
 =?us-ascii?Q?Wi5Jx522HTf3FpPJjrXBGTxViYHdNnI/LREC3jpnZr6OGFe7wIxPJ1g5csM3?=
 =?us-ascii?Q?ex1MoMj6/l+Ot4MErYXdbKdcbQyvwKNXNhvHQXU0PYp5m6btW1VvAO0K2ybU?=
 =?us-ascii?Q?LZm39z7NX/TU0+PundlaUrqNgxgiCVQMzZLMej8Xa12TfDF/3KtHK3URSVyj?=
 =?us-ascii?Q?nqm8egt75oz22H/v7uZUCP0G+rF1S/a/HsoR1JjX5NbItGTji4VopHSYYF15?=
 =?us-ascii?Q?HyOWFo88Xk51lhuy/nyskGyBzW5x8YDtNjDxQCvVdn+otrJnDPmZ6aKyVEM5?=
 =?us-ascii?Q?Ef0YN34nZDNGdDaihhfSS5ws6wdETdVZikbS4a75J40/itPxnobXToPfpEJy?=
 =?us-ascii?Q?4nPDVImVRnPvlLYUDzg6mGbjfasmQ6Qai66D4vZUiL91CfrVHJBpTcRydEnJ?=
 =?us-ascii?Q?VANvXMlJdo4Jc2lfcgLLFY22pbCtuE6l2l9mFnuESvTNI4/sbR5zBFdjvLjF?=
 =?us-ascii?Q?6lCB9C8HiJvMgCi+zdDllq+86s/y01HKYF2jrdu6Lwidy3Xi5QKI3NqQG0Zd?=
 =?us-ascii?Q?mP3j0fVibCFaLnFa901HJPkN30k2I6hZbylfBNY+GaRbliuvUaakvOxfyG7E?=
 =?us-ascii?Q?JIhgP7Q7dJ5uhue+LrRig7PYKEGvrO1AL4misJi/x98w3olZyFW/qCOvnXfu?=
 =?us-ascii?Q?HgRRKrl1eN7/SqxPPpQLyUykXvH9GcrA9M5Ft76NYcyQ2zS4rmpMalt7B3ve?=
 =?us-ascii?Q?os3yqCraD4V5sw7cy+SputlKd2Py03m4ZNPyymvisZSB2JswJlZtehANcLqk?=
 =?us-ascii?Q?v4eP5KzEAcIZJKpon07AgNpOe2D9K0PdEek30i15mA/gJxGb7+uFhN5fW6FE?=
 =?us-ascii?Q?3hH1Wg+7xyDa7PN2olJeV7uNy/dZeHNs9hDfuZjIavXs3ci6w9kagES6a03O?=
 =?us-ascii?Q?jXifaNUhFZX1Vn06gjEGONA5z6YmEHD4Vwy0zrqsQwoU8FmEZOKlr//stKty?=
 =?us-ascii?Q?9bbt0JRkgbCzbEDe0OGhOZrFDC6++k3ed6zbKsdMNaF2PsqBuj/5UNtSt2Bo?=
 =?us-ascii?Q?VnERoLgjI7pu3O2fxhYLGAMQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hp5C6rpDqG1jIKj0+U8VCDi9fSPZRsfbtbpiS7/mR3pF9ezfQdPd2SCFK6R?=
 =?us-ascii?Q?7TjEIWV7DRSC0yzRyUPWTZYf1C0lTP2eLlGI3aZWfdy5osSZmq71xoA2O81B?=
 =?us-ascii?Q?VUA+VMIHk/DjmKNKlxcOYGucW9I4eBTT2FEoMUNNNR6h4aq0sE4xr62gggh4?=
 =?us-ascii?Q?BaAVa+E4Td9H1p9lrL/6N8WF0Ze5NwX9vahr84bj6Rl0/Nurq6kTyCKA4DA3?=
 =?us-ascii?Q?ldPwRf4D9++5zURt+3uUv6HL0keUooBfvsJQMwcdkNi/A1Ag3WJiwVyQVa1x?=
 =?us-ascii?Q?HRaWgQWmoDlT5sVB1BSpBdfG0kJFEBnFtCG9+pBkN0TrgW1Z7tkGxYgNHzTF?=
 =?us-ascii?Q?ZB6zX2UeljqOrj/No62gXPuzCWUj/e6xw8Yci5r0EP3kKz/0AGORlxUK3nUf?=
 =?us-ascii?Q?rMPQ/DSrEP3BmQ8Z0fjoDNtlFkN2YWmi7vVvDbiXcPiJkdzJ7SxciCUl1POX?=
 =?us-ascii?Q?ZE1tszQkTLFgNKKZUh2cRqaucjb5Pz6qzdGrjIrVIb4lS6rM5acZJlmBimjX?=
 =?us-ascii?Q?2xkjb7PLu2cwjU8DEGf49oh2bU/c6QMUTXIMFXajWSMRgxZOpTT16+LbJFbv?=
 =?us-ascii?Q?yyIw4opuOwnelKHqJnqOEn+++QfZTQda7hXtWsbuoDj4F8EmoHoYWJIsRUzy?=
 =?us-ascii?Q?9eaJujxFhsaGfmvzGkXfCWGFjy4J9TQfigcNpLsCpCwDDtOXhXZ4TLMyOJ/X?=
 =?us-ascii?Q?yZfK+gnBGQdj/DEKKwLHjp15Jxn1mQWbW7asTloyvpGmGxdGEiee5kOacnwa?=
 =?us-ascii?Q?HtEOF+GvSDbMBC6bELMAursqXRWBcsRydDp9BaGmiq4ESxXKY5ErailkWNb7?=
 =?us-ascii?Q?RsR9aIwDUDZ/0t47oO/vccpUrMxaDLF4d9FUUDB8syRjXfW7IRF1274Shqt6?=
 =?us-ascii?Q?VPY5CkT9P9MNSDHdK2kNf2h5OVQwldVtyJJJLxzk07wPdVFu4iuuTB1zJEE3?=
 =?us-ascii?Q?C9oq5m688gxkFWUNSiV+uT2YRQ+kBv7hpnXnaD7tr4m4cRbdWURmTFzmET2d?=
 =?us-ascii?Q?PPkLKcmpzIJgybGUyPHqdAsJZp6IQYs3kUYB8P7xiM5v5me8g45IQdtWOc+h?=
 =?us-ascii?Q?PiInBWLAv433NxO+dyUqFql0ehI/xVJ6jcjGSuV9HnALaVxmXLJVX0irVJbe?=
 =?us-ascii?Q?XVBht2/WDomP0wzPPpUJHboSQ+dx6RctCZsrq6CXjJFodlHAG5aimkcBeNK8?=
 =?us-ascii?Q?AWgGWby+lBb9W5IDkSLTsIpXa9hEUfJEoKF5mhBSwLic/ONCiQxfYzlKZ/Z6?=
 =?us-ascii?Q?2lV+WTGh1baAIa0qB8mxNuQ/ljIG0V0MDSAJe+LPTLTZQqsP8PaXrgPWEHAX?=
 =?us-ascii?Q?jRmLen3JJTSY4ma7IHNKKEkzYdpIzoa/41BtIU0Kml2yEYYoZ83H6xYb/ULY?=
 =?us-ascii?Q?ffZLXKZUpibe43ReRr/bwNeDrP+BhmIyZfhJ39UW/kjZLw5qMRPWhkb0f7LH?=
 =?us-ascii?Q?ZWCUtLU5ZmC2TtM+Ys/klukF0J+gLjq4OTvlpTxZ87p93FzLoKdmA8dfUmJI?=
 =?us-ascii?Q?fNKNNY8A0vXJ/AYcl0T39hcg8gMkwyavPvw1Lee9U77FdpVwVIAP8+N/7uNQ?=
 =?us-ascii?Q?B3JjSTvUxtrOM8P83oTPVskVy9Ewq04CK/k5uY5x87NQIUPpQh9KT7qpHDwH?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0beba5-384a-454d-5f83-08dceeac412b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:04:37.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRgHVg/RMVnL/8/II0mGXdxCXzJ3wKGvFj8G4y7bSsB90zFnaljbsxRO/sfXXTErZXuGxcBqpUPCvbhg5/6ui9/40/zLcL5x3wgOLJ9HJ3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:46PM +0200, Alexander Lobakin wrote:
> Currently, xsk_buff_add_frag() only adds a frag to the pool linked list,
> not doing anything with the &xdp_buff. The drivers do that manually and
> the logic is the same.
> Make it really add an skb frag, just like xdp_buff_add_frag() does that,
> and freeing frags on error if needed. This allows to remove repeating
> code from i40e and ice and not add the same code again and again.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Me gusta.

> ---
>  include/net/xdp_sock_drv.h                 | 18 ++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 30 ++------------------
>  drivers/net/ethernet/intel/ice/ice_xsk.c   | 32 ++--------------------
>  3 files changed, 20 insertions(+), 60 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index f3175a5d28f7..6aae95b83645 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -136,11 +136,21 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  	xp_free(xskb);
>  }
>  
> -static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
> +static inline bool xsk_buff_add_frag(struct xdp_buff *head,
> +				     struct xdp_buff *xdp)
>  {
> -	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
> +	const void *data = xdp->data;
> +	struct xdp_buff_xsk *frag;
> +
> +	if (!__xdp_buff_add_frag(head, virt_to_page(data),
> +				 offset_in_page(data), xdp->data_end - data,
> +				 xdp->frame_sz, false))
> +		return false;
>  
> +	frag = container_of(xdp, struct xdp_buff_xsk, xdp);
>  	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
> +
> +	return true;
>  }
>  
>  static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
> @@ -357,8 +367,10 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  {
>  }
>  
> -static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
> +static inline bool xsk_buff_add_frag(struct xdp_buff *head,
> +				     struct xdp_buff *xdp)
>  {
> +	return false;
>  }
>  
>  static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 4e885df789ef..e28f1905a4a0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -395,32 +395,6 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  	WARN_ON_ONCE(1);
>  }
>  
> -static int
> -i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
> -		  struct xdp_buff *xdp, const unsigned int size)
> -{
> -	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(first);
> -
> -	if (!xdp_buff_has_frags(first)) {
> -		sinfo->nr_frags = 0;
> -		sinfo->xdp_frags_size = 0;
> -		xdp_buff_set_frags_flag(first);
> -	}
> -
> -	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
> -		xsk_buff_free(first);
> -		return -ENOMEM;
> -	}
> -
> -	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> -				   virt_to_page(xdp->data_hard_start),
> -				   XDP_PACKET_HEADROOM, size);
> -	sinfo->xdp_frags_size += size;
> -	xsk_buff_add_frag(xdp);
> -
> -	return 0;
> -}
> -
>  /**
>   * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
>   * @rx_ring: Rx ring
> @@ -486,8 +460,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  
>  		if (!first)
>  			first = bi;
> -		else if (i40e_add_xsk_frag(rx_ring, first, bi, size))
> +		else if (!xsk_buff_add_frag(first, bi)) {
> +			xsk_buff_free(first);
>  			break;
> +		}
>  
>  		if (++next_to_process == count)
>  			next_to_process = 0;
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 334ae945d640..8975d2971bc3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -801,35 +801,6 @@ ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	return result;
>  }
>  
> -static int
> -ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
> -		 struct xdp_buff *xdp, const unsigned int size)
> -{
> -	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(first);
> -
> -	if (!size)
> -		return 0;
> -
> -	if (!xdp_buff_has_frags(first)) {
> -		sinfo->nr_frags = 0;
> -		sinfo->xdp_frags_size = 0;
> -		xdp_buff_set_frags_flag(first);
> -	}
> -
> -	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
> -		xsk_buff_free(first);
> -		return -ENOMEM;
> -	}
> -
> -	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> -				   virt_to_page(xdp->data_hard_start),
> -				   XDP_PACKET_HEADROOM, size);
> -	sinfo->xdp_frags_size += size;
> -	xsk_buff_add_frag(xdp);
> -
> -	return 0;
> -}
> -
>  /**
>   * ice_clean_rx_irq_zc - consumes packets from the hardware ring
>   * @rx_ring: AF_XDP Rx ring
> @@ -895,7 +866,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
>  
>  		if (!first) {
>  			first = xdp;
> -		} else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
> +		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
> +			xsk_buff_free(first);
>  			break;
>  		}
>  
> -- 
> 2.46.2
> 

