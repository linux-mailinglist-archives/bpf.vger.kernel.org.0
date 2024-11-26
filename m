Return-Path: <bpf+bounces-45621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A69D9BD7
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840D6B25798
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA31D90C5;
	Tue, 26 Nov 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVK1tosO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F671D63CA;
	Tue, 26 Nov 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639178; cv=fail; b=iFPQBDs6K75ZQSfxuw+4NUxWsyBGgT/lSpAwThCE7jOf1T8HBxe30mA/LOxdPHwHQCmdJp9NDgbBTdL5bcB+aSudqKE7pDfzUU1C0IT0Aj/5b2i2m9e5mjJ8ACaeRl82osamWi5hwLNEUB8Xua/g2KoOdLyMUXesf8WRU+KTZq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639178; c=relaxed/simple;
	bh=Hi2SnnOLsRT4grBbzTswGPq83POrdqI5mKneHeOgmAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqgjaHtcVd52iQ/kcueTEgXMVqCGK5MxryLEOnkw42FavMeo0R0HZn6+8+gh0xI79ilEJuz0W9vomtE3/Ev6F18akgmosbbfa+EujJs8R2zUf2FDGJDa00mMZbtYTEJPLOtTF/z//lxT6JFypsjsRjEPZdqpsK9+ZqOiHv1dxAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVK1tosO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732639176; x=1764175176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hi2SnnOLsRT4grBbzTswGPq83POrdqI5mKneHeOgmAU=;
  b=GVK1tosOcj9Ot6rS/vuxA4r8Q3yOxxLO1x89GN12kdhg/hzvZYZ/pKDi
   3lt6iE0ty7Z1yFcuPYvdCy22u6b7SpWUqjH3Ez6nVjJa/Y+51GrBpW/Oe
   ckSe/xDiMx/6ZMGojotFack0gICgxsj4nqlYK4EENb5XIo/GWTfi/8uvf
   fu5uCC8Vnp9oF1ibEIAXJ4JUmXPPd8ekHuDJp5Nd3hYpwSMqx+V5aVWoW
   myWoJiuhCjsSAFA5WtdjNbgbUBLii1QKxmItcH/ozf3PuKSIg0/sOauXI
   Y/7ARetwTgx1rJg1n+Q8KP7Y/Kmc3jshRtzceH1fwG5jx7W71uHtJyitB
   Q==;
X-CSE-ConnectionGUID: QRgIy9mDQNqGxt8KgTxj3g==
X-CSE-MsgGUID: 45bED9uPT8qKaUbPgfQmOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32940756"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32940756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 08:39:04 -0800
X-CSE-ConnectionGUID: Oh4P0+qbT8icwaxj5HkN1A==
X-CSE-MsgGUID: uO+xXtEuRzOCImjp2NaQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91830141"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 08:39:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 08:39:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 08:39:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 08:39:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS0Ap7GkQSWc6++taXYqNHJ/iVhrvdqth3ZkZucPv3qt116pfbKdAc30vLMaYheCbqAb869CL02V3jvN6tqEBEXYCue+FV806UBTqBpMgaVV+rkUr8EMpSQdd1g1Hstzc15THo5hklJIJeuiRhuQx4SfIbKme4KnK76wwfezHYDOEWfkPtYJ3IjQcvxGZ8mTHkaGAoBPnjtX3y9xLYf8r1Gez6DRZ2Ag27gxCdgHHuo2WXq+mJ8+HfoVdp1wBbZQwGmN2tTt2XrCdCw8D30h5PkSFIX2nXQnnxuhHtwuyNhLtSzQFKTEQfy2lyrjMxr1Kdb26ddoy8E88HZPi6UsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr8FDqMX0jNQlSw2aMlkaRD7hznOz6hJhJowPTwynlI=;
 b=cKy4UXfihfrWZ75mpD/jtuAcAK97d8/yVdNcj0uEAYeOdjYjITlRl4cbns/qo8JP5Fb+KpmQWcM7stQZ+1mbXCiiI0tbdTldnKb2WZTZ0djXs+pM/mEcwrMOA9QWQhpU2GDX9VzejVlUcq7pBi1+ND98TlajHUvlbgevVXsRC6XfahA4f6kyod23hgUEG+snqr7HW8rt77jy13/EQBdBwLTWZU+4Da3Yxcqx0YyLnejYC3x4vbaZh51Y53bkOG+GOnZUFm85NHXLCU/y5URw8xMbHh4iMKSXYlydTngVNjJTuizuggwwbtd31ez2P8py5RpQeh43pwUwE7qq9fujww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 26 Nov
 2024 16:39:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:39:00 +0000
Message-ID: <624840f7-423a-44cd-a2c0-9b7e3b3f8555@intel.com>
Date: Tue, 26 Nov 2024 17:38:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 12/19] xdp: add generic
 xdp_build_skb_from_buff()
To: Amit Cohen <amcohen@nvidia.com>
CC: Ido Schimmel <idosch@idosch.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	"nex.sw.ncis.osdt.itp.upstreaming@intel.com"
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241113152442.4000468-13-aleksander.lobakin@intel.com>
 <ZzYR2ZJ1mGRq12VL@shredder> <ZzYUXPq_KtjpNffW@shredder>
 <59d1cb78-8323-426a-b1b5-e5163b29569c@intel.com>
 <LV2PR12MB59435D8F548C8DA2E317DC6FCB262@LV2PR12MB5943.namprd12.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <LV2PR12MB59435D8F548C8DA2E317DC6FCB262@LV2PR12MB5943.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0205.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cfe407-6b8a-45f0-0481-08dd0e38d4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXAvRmRkckl0Zk56RGZXdENySHduUEJxNTlTL2p1dVNUY2p0ME1wZlNaR3Bi?=
 =?utf-8?B?eHdEaDRKWGpGQkI4TWVYZjhTcW1Sbkxra2oxNTVnM3ZrWGM3QmpIeWhYekhv?=
 =?utf-8?B?OElERjk1MjBuSUdHeHBIa3pqTDlCNGQ3TXVmV1BxWDZxRGN0eXZENFN1ZGN0?=
 =?utf-8?B?N2xqdU4zS1UzQUZkSnkvaVJXdDg5UzhXWFU1dHBIMW4yVjFKemdpQ1JnZlVl?=
 =?utf-8?B?YXBOZzBQNzdtK2tPUk92RkthSjZIbDl6Unk0Z1NmQ3ozMUJKRFVPa083azJq?=
 =?utf-8?B?OGhQMkNUWkdWWkJ3OC80RUNjbFpWdnBpNGRmSytrdDBTUWpWaHY1aDY2R1Z3?=
 =?utf-8?B?RFljYTEzVTRKMy9vNFBWV2hVWkR2ZS8yVlBhcFdFVWRSSmJxc1J3RzN3Q0Rv?=
 =?utf-8?B?TmRFYzRDNDRDSGY5dFk0Vm80aTJzdjFGRzQ3SUxqdFRwZWc3b25QeHM0dlRP?=
 =?utf-8?B?bHkybkdmT04yektYRXFhTm5CL28rN2tzQ2JxODMzOTV3WGxGSjN2bzI4d3pL?=
 =?utf-8?B?VFhaSVFIc1pYV3pFZ2pSbXZjdlpuSExOTVBBWjQ2ZHprd1lKOU1mdmoraStp?=
 =?utf-8?B?VThwVTNDV0kxaFE0R01OeG1FZEc4ODdWYWJPYnhEcG93eWpVVFlRdTlQbUU4?=
 =?utf-8?B?TDFNaDMySm5HN0xOMW84dm5KTFpTYnUreVBkNWNSdkpwaFBKZDlTTGVLSUtW?=
 =?utf-8?B?MElqc0hzUzhaYkNHRG1tTmNoR0pia2RlbjNGTlZLSk1PbWFWSjhqcjErSzBn?=
 =?utf-8?B?T3dud3dZNEVhdisvTGRXUFRCdVM4SVpMU0wrNUdXOE5QNTE5cnUxbThzOUVZ?=
 =?utf-8?B?dFlodEtaOUR5N08xekFET3lJRE9hTEhtYlM3aGdTTlJ1R09RcTNSR3cwYmM5?=
 =?utf-8?B?cnFNbUJyUkR1bk45eW9pZDVvb3JoK0VKcVZUTy92R2lQZ0pXMGdMTWVxd2hz?=
 =?utf-8?B?alhTbVhTR1BMQVlHM1o1ajlUaGpyendHQnBVeTBvUFdxdlVuczJmaDhlSUpP?=
 =?utf-8?B?S01pamRUdk9tejZ6WlpKNENnZmsxQ0VOYlM3bTF2c1BOR3J3R0hyQ0tWUFBa?=
 =?utf-8?B?bTk2V0FESHpqb0UzZWhDYldIak0rMTQrOFd1YlpHTzZ4Sm9saFZzbHArdFlK?=
 =?utf-8?B?RTZRR3l2MytOalFFVnY0Ulc0emNoWHNqK0t5S1FKZnQ5SGxEa2ZUT0I2MHNG?=
 =?utf-8?B?dGtacDZONWd6cG5hS1JBeDBXQkY4SmlGcDljcnM2VFh6WFJCNkEzbEVwOFM1?=
 =?utf-8?B?N3lNMWlrOEFVZHBMdW54VDZzQlcvbXA5b21jNGZtVnFTdlBBMlpqYjhQNUs2?=
 =?utf-8?B?SkYrcUZEMkpvai9qMG5kcFkyZzVWZzJCQlBjU1dBU2NFQTNPVllzOWx2cXcw?=
 =?utf-8?B?dHluRWtWdWlGZ2IwYStHY1o1MTV2a0RLYU9qdnpZNFI0RzVjejRndW54eC83?=
 =?utf-8?B?RkpJZFpPemxkY0huOHR0QzMwYTNpYndlUHZlaFIvdlg3T2w3ME1UU1hma1o5?=
 =?utf-8?B?dHZiczFTY0liOGhtZWR6YW45Wk5GTE4yd2JSMWpwSU4zLzc3ZGljemd0VDQz?=
 =?utf-8?B?eldpUWdkTWRYYWkzY01GM2s0U1JHdExpeVFHV3RISGxESUhkbVQ2bEd1Zm9q?=
 =?utf-8?B?bXcxSFB1S2tpN1JMeXF3MUM0WlNGQ1k2Y0hnSTlJb01waDJaMkFLcHlNZC80?=
 =?utf-8?B?K1lYYzBjUTFreDBMc2t1SDZNNDljd2cxSFppV3BZWWNPcUQ3SmN5SWpVY2ZZ?=
 =?utf-8?B?b3psdUUrSXhlck5MY25ERTFOdENra3NEMkIxZ0E3Wlg0RVRIR0NqcnZKOHY0?=
 =?utf-8?B?c3Y3VE1BdXlkMkNPb0dYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVk0WVppamIzZFdtOVliVFA3MkxyancrUEx6MkN2R1BLMno5RjdFY2wrbGZz?=
 =?utf-8?B?N1FSQy9CVXgycU5yN2JwOFlqMU5ua2oxVkRIMTJORUNvclFkcDhWSmRubWIw?=
 =?utf-8?B?U1FsS0V5V25rQXRIbGVJSkdld0NOQ2hIUmR5UGF5M05vZGJFUjgxUnNhSVpL?=
 =?utf-8?B?d0lHekRCVFVJV2N6VGVSNXRCdytOaHJWU0NIbEZ0bmpQZFRyU053bS9FYW05?=
 =?utf-8?B?TWhlUDBITmgxOEhTeE5XNFZDSGZMMEduZWQ2TlBlcSs3VmJkMVR3b0NKN3Jl?=
 =?utf-8?B?L05mVTgrRDBkQW9hN0czNGwxZjV1WlQ1eVFTMDNTbk40MVY1RFErN0pSTDAx?=
 =?utf-8?B?TlRlbVlWRmxwY2k0Q0lSVjNDKzNTajhXUFZLTml2aWFTSHBpZUo5WVNIODVB?=
 =?utf-8?B?MytxaFZiL01sbnFSbWl0ekpSL25naTVhUng2c1hNR3oxVitpNXZUVjk1OFFK?=
 =?utf-8?B?ZzZFN0RyekdXbnkwbGVJcEl2aFIwaC9PaEpQNzBLVkZKbHBMOFF4VXVWWDFO?=
 =?utf-8?B?VDlEdVFYWFFTSnEwUDhtNjFXWnUzZXE0M25QanpkL0RFMVNwNDlPTThWVU9l?=
 =?utf-8?B?SFFlMFdwUDRBVFZROHlaMlp0V09qVmNyTnlwa3lXOWdvdEZ3d1RqQXFwUGpm?=
 =?utf-8?B?eUdVY3VkalRiV1p3MWxYUVI1SkZYaFJGblpqRTRHYnh0N0tHN05ERWpmTXBG?=
 =?utf-8?B?YmR2Qllmczh2TkNvbEpXTXlsNTM2VnB1TElKRFkrSXhkd1h2VkN4TGYrS1VJ?=
 =?utf-8?B?Ly9ibk9zZTF0aGdzOVBaakFsdUVHODVyK2hsbG9yNmczK3kyeGVqY0F4Qmhy?=
 =?utf-8?B?Y2tlcE4yRkl4VHVUYWEyV2h4ZUFiVk53dllnSFo5ZzdYdDNlWGhUeGhPOWpw?=
 =?utf-8?B?ei8wR1I0NEVJcVBaZGVyYkxlZmYvTjlnNnRjL1Mrc0dQMVRYRnV3bGR3cm1m?=
 =?utf-8?B?L08ydzNJSHNuUk91NGF6cThKbkhZdFdBZGVLNTJlTFFmOXJKcjRMcURWaGln?=
 =?utf-8?B?Z2F2R0J4WUNjOXdweFk4OHR3TjMxMkw4K0FVak9uZFBGdyttdWpPb0FTZUpY?=
 =?utf-8?B?ODdOcEFMYm0yaXlZL3ZTazdPNTN3UTVTeUNjUk9NbWYyaHI1VVArTndTWUEy?=
 =?utf-8?B?ZlJ6VC9Gdmx4RlpiNGwyaGJla1lwNkhrUmtPaHVGdmVJaXU0RmF0d0ZhRVNk?=
 =?utf-8?B?T0FpZkl3Mk4yTitQcUlTWUdvYjBNU0dYRExhNzhDK3pyYzdLRHhzSm1ORXRI?=
 =?utf-8?B?anhndzk3cXdCcXJkeGJkekplb3JmMmtWTmRiWk5Kd0dmZkxJdURpOHlqcUdw?=
 =?utf-8?B?Mk5DR3BtQ1NEelY2WXhySE9KclhCeThkRmFablF3OEFHbWpYZlNXa3lQYS9v?=
 =?utf-8?B?OVowS1NmR1h1UDQyTDhoT1c4djJMZ0RlSUhGT0prKyt2cTNhc1JVTXAzaU85?=
 =?utf-8?B?eU8weC9PdEVDSXRCWUo3cEJKYTRuellLR2U5Z3lwRHIzK3IvMnE2Q1JHbi9L?=
 =?utf-8?B?WS9KOUdRTTFDN0FsaWNLYlRmTkJsT0JTa05ObllKak5FUlpTNGIvTFFraEZB?=
 =?utf-8?B?VGR6eDdWZWpxQkZESlh4RWZxVFA0ZDRWT25OSkw4dmVBd05sUWFjckhraU9p?=
 =?utf-8?B?R2lLL2lTRThWR3M4OVA4azJ5cUlZcDJZK0VhcDd3KzlRY2RocVI3YitUdkVi?=
 =?utf-8?B?UytWOWhUVzVEUnZORXNneUVZUXVmYVFpcWwwVDFMZXJ1SDM2WXJXSnBNaGtV?=
 =?utf-8?B?Y0hmNDl1WVNNdjRnTVZCZlFsbHRyVk9wYjR1NmdHOGpJTFc0dWxNOTEzejg1?=
 =?utf-8?B?TlZudmJwUllna1B2bVp2cFdub1Rvd3g0UFFuUTlWQXRxQ0tQYzNHL1l2c0VV?=
 =?utf-8?B?dS82YUJHbXFmSFFDTks1MTM5eElURmFnaXUxRDlJN1Zmd3orSFV4VmNBcHF0?=
 =?utf-8?B?aEVwWjhpQVJzY2I4dmJjVUZkQ3p6U1E1U3BmUUUrcHdwZHgzaWJqM1dsbUx2?=
 =?utf-8?B?QXBGd1pKZEZJSmJHSGpBT2R0eVBEZXI3WC8wemp5YnJYU0xvdldZemlzdmQv?=
 =?utf-8?B?UUNhQ01OaVhCZnhCMnl1UHI2cFIzY1BzZGd6ejZxZVdPYkhYcjdMSXc2Tkxr?=
 =?utf-8?B?ZVI5dlBRa1RjakNTSyttZmkvY2xxc1ZYRko4NVVMTzZxb3hWWExwV01tRFR1?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cfe407-6b8a-45f0-0481-08dd0e38d4a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:39:00.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlvrcXKMJeelYLaHq0fea6ipj6SEeKR5cgoNizAktV0SdNZ+b0mhYAy4dshOe3qEaVPjL4eJQLVjAD4Uyxl9TOKazl5g9ZMSa3R+L9iDCEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

From: Amit Cohen <amcohen@nvidia.com>
Date: Sun, 17 Nov 2024 12:42:11 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Friday, 15 November 2024 16:35
>> To: Ido Schimmel <idosch@idosch.org>

[...]

>> Regarding your usecase -- after calling this function, you are free to
>> overwrite any skb fields as this helper doesn't pass it up the stack.
>> For example, in ice driver we have port reps and sometimes we need to
>> pass a different net_device, not the one saved in rxq_info. So when
>> switching to this function, we'll do eth_type_trans() once again (it's
>> either way under unlikely() in our code as it's swichdev slowpath).
>> Same for the queue number in rxq_info.
> 
> With this series, maintaining 'struct xdp_mem_allocator' in hash-table looks unnecessary.
> If so, xdp_reg_mem_model() does not need 'allocator' when mem_type is Page-Pool.
> 
> Is there a reason for not removing 'mem_id_ht'? With this patch, the nodes are no longer used.

They actually are. xdp_unreg_mem_model() performs lookup and calls
page_pool_destroy() basing on what id you have in rxq_info.mem.
__xdp_reg_mem_model() calls page_pool_use_xdp_mem() which increments
pool's refcount, so that the pool can't be destroyed until the
xdp_rxq_info it's connected to is unregistered.
xdp_rxq_info is 64 bytes on x86_64, meaning replacing xdp_mem_info there
with direct PP pointer will blow it up to 128 bytes (64-byte CL) (don't
forget that xdp_rxq_info still needs to have mem.type set).

> 
>>
>>>
>>>>
>>>> To be clear, I understand it is not a common use case.
>>>>
>>>> Thanks
>>
>> Thanks,
>> Olek

Thanks,
Olek

