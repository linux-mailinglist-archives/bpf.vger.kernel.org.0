Return-Path: <bpf+bounces-54387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0724A694D1
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C105F19C4C3C
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2D1E0B86;
	Wed, 19 Mar 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCXxkJu3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A01D54FA;
	Wed, 19 Mar 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401441; cv=fail; b=RC3EISxT41R9dj3ImfJTbVKbKHoljbm9A10++Jje9/F6DjreUXxNx+ZjkuRYDpzXPRns8vID3xHNhCw5jNtEKXSM+anLzL4TzXLHN4zZT1+9hX227Z0W+R020yedHqjruXRJz0f8LN6uRBA40IXVOgcZndIs4nI8BoqIVX69sN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401441; c=relaxed/simple;
	bh=rsLTneYi+xqrEgF8LxSCWswu9VpDYNLUqGzxDRT11gI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1niarUK7Ihp+fANgXAKjG35/lST7qFtzxTPMNbb4ulyPpb2sybzA3fw//iPQOOc55upt99FBBptfy/KJSIV5U/DQllQR+U8HyLS0CP2XqK3/r69DCL/pv0cY0S9S3quKSRUsuLGpy7gMdizDdOIw5pmwLAe7HL3Tl01JBD7OlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCXxkJu3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401439; x=1773937439;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rsLTneYi+xqrEgF8LxSCWswu9VpDYNLUqGzxDRT11gI=;
  b=eCXxkJu3lcH6sX7d7stCFd1MF3FKj1CRnD3xoWPKXBDSjjKyPezKZygL
   hasI1XybWsAAZuvna5eAj59VUqSke3grX3A0QY5wt19Vcg+cF144BOhys
   LuAHKc/LpRxLeGvkTVTp2F8n11v93eRbSif6B2S3Wua0lL82x5CmWzWVW
   6FgLgJCAUYJpoUSdTNis35kNMhU4EdjW2POKGjIkEpI47hDmPZLtgCvVl
   WoI1ljF261EzgZIHsMKsikEAFMZ+0BPxtw/oSceAsuTVtn4zzfL5ZbCeX
   rmUxSvo6h5w+CjfdbHrNEzNl/zwb5WYnM4szqvXzif/6X6uCWgdYtyqgG
   g==;
X-CSE-ConnectionGUID: ARqg/yuNTrGT0R3zjPW/0w==
X-CSE-MsgGUID: XcqQL2ZhR1Sg/H8Fam8RRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="42773221"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="42773221"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:23:58 -0700
X-CSE-ConnectionGUID: Z8w15C9eRbaLc/sksEartg==
X-CSE-MsgGUID: UWLiuMH2Q7GrqnWyQmc6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122410996"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 09:23:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 09:23:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 09:23:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g01xh3/VfQ8rk90bTfec1X58P9KWPBCDZXW9Pbez5s69f5rx4bpzyjA8jsQfb32BcXQ8xzpiu9XVGgbdYY+Q06WdUHKM4PlPueJMTwFtFARU8h6K8c7SzUy4NTKxy0JR92Okbzs6x9qTTwtZm3liXvlZFzvjMt9b6HKHoAELS09sejPCx+isHd9WaeCY5SN+OF6q0HKmpEFdXtLi60E5NlnQfwbyavUir+jtr8rbJRw9wW1WwUHANzpC02e5NntB9HuGNhkZX/HP83ZZGBD5loaYF8RAgEvwO6iNnOzOZ0pHqQNM5mSao05m31ozFLwnlNFpiTAm/JVUg04FWhrhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY6w1iq9o8oYp5wEuIV0lrjGpHcJvwxDPHbqoTZOIUI=;
 b=qL0Ewpjo7PHy0RGLcdxEqaHpmFWKmddVZubNFExPvVU5e4S7qQXlnWbWn/DE82MCkYiLu9FwLefrEwIY7cVEysX5awpyKhyScY5Uxg/IOxRz+2+NwYg8BvQ1rBazToLSiiQ8SmypfXCB3cUQRJF7zB9MwlXCd4mrXihztK4lHQBO0jpfo3Lktjl4ydUFbS6c++wHkhYww6N7PVdDvo9lAvbxiRugEsbTfQNBMtXFxA0Pk63+Y0AECKdagERozJWrpmvjgm3HdWBoiWqlG/vGgtrbS4jTb62AwZHmAjKCvl+wuJbCq2bSESyZUor4iiE4C3DNEGiSVZhw1n1nZsBsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Wed, 19 Mar
 2025 16:23:14 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:23:13 +0000
Date: Wed, 19 Mar 2025 17:23:05 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 12/16] idpf: implement XDP_SETUP_PROG in ndo_bpf
 for splitq
Message-ID: <Z9rvaVu460sZkUXD@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-13-aleksander.lobakin@intel.com>
 <Z8r/0NOkovItGD1E@boxer>
 <428cc7b6-fc80-4028-a9bb-ce65646005f5@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428cc7b6-fc80-4028-a9bb-ce65646005f5@intel.com>
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 123aec1c-d387-474b-b593-08dd67025877
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzcyUWNxNUcwanJLdnJ3ZTM0d0dLVTRtVERiL01FU1B2dGdNNytQRldyK3pu?=
 =?utf-8?B?WW01YlJKMlRDQnRYMEFYa1NKZ0VYWGVDKzVtR04rZmxLMFFUQXo0NEs2STYz?=
 =?utf-8?B?Q0pFSU1yS2xudjkzUUNOWklBMVJnRzloSnBWK2E4YjF5TUpsSktaVVdlQWJr?=
 =?utf-8?B?MWprRlNYRy96Y003anJITHU2ZWdvd29kSUZHNlBEc0gzeXJFRHFMdkZid1Iy?=
 =?utf-8?B?ejh0NXpsNkJ5MUpQZ3BJcFA2bGZRV0s0MnBFczdUc2RyNGNoZkpvbVNvZDZM?=
 =?utf-8?B?V3BHT3N1cGU4TGtMZ0d0YnRIQVZ2ckJCdjdoa3RlQVRSTTNLUG5GcUtKY1hJ?=
 =?utf-8?B?TTQ0Y1B6eVB3M1NUNTBVMGhUcXYvTGZQcDcwTVdvTWJiKzBveGVZQzJkb0Ux?=
 =?utf-8?B?MXdCUHNBOFFrcjZzNnNobmJrQ3dQdlR6TkVON0drZmY3Q0NwNk5WbVMvTXNC?=
 =?utf-8?B?eDUxdlpaUkovRnRZc01VeGVwZUpETjA3dytKVFZrMGFrYjVpdXByNzk2Y2JO?=
 =?utf-8?B?Wmg0NzR2Z2NWbFV6VCsxM1pnUEdRVVVnMlFzTlhVbWVKMzJVUTF1dXZHa1Az?=
 =?utf-8?B?VFNVa2VZa29qUXV6UXpuamMzaHdMeVd4RFIxNGNMR0dMbVR6ekp0bUt1S2Vv?=
 =?utf-8?B?MWl1Nkxta25WMnhKZlpmWHBLSjRNVUlKSHd4U2dQNko2SXE5N1FKRWlCRkp2?=
 =?utf-8?B?Z0pCZnp6UEpWeHk1cUw5V01EZW1GN3hxYjh4ZjRsSnE1ZGFpOER0dmFzZ2Rt?=
 =?utf-8?B?UG1DUTNlSTB0cENKdENXNE0vaHdXQlFOdFVlWVQ0ZDhIbjJXcFRqU1kySll0?=
 =?utf-8?B?RTIrOTJ2cFhVTnlSb200MHI0SjFvWmhZYlJHbWZYVXNEVWFCZWF4Y0hGTjdh?=
 =?utf-8?B?K0hNY1N3VnQrSC9ud2J6NWlsbDlqRDBnL2RFZmRpVTZadnZDd3pwcUdnRlZv?=
 =?utf-8?B?T0tISzBEbmNUSi8vVGJQSVM5ckNGQVorM3VrUjM4U1RkWldWcWhud3FIZWQy?=
 =?utf-8?B?MVJzdmdDMlpEazZRUW1pNDg2UkJCbm5QK05yZVdoa2NLZG1EbUNXVm1SbmxT?=
 =?utf-8?B?NTNibXkyWWp5QU1BTXJQUDhxWGpoaHVyMkhSMlFCY1hydjNPK05aVi9YaVZh?=
 =?utf-8?B?UXZWaUd3aTRXaWNWK1NuTTA1USszTGZiZ3RobGFWNjN3ZXpROFZ6MnR3dldE?=
 =?utf-8?B?NmdGYmh2eU9GZ0x5WDNTaVQ4NjFBcDRxeEQ3MFF0S0NqNTFRVWV4SUpaa25V?=
 =?utf-8?B?UXR0QkVobHRBemI4UisxZmxvTmthZmJRV3FTSTg4aDcvZTBPcWkvdjlBS01P?=
 =?utf-8?B?MERWNVBaekRUMW1IcCtHNVVrMTFhOFBOZXczT1pBNXlCbzBCbUZhcWZxdDhC?=
 =?utf-8?B?RmM3c3g2ZGhQSXo1TG1rRW1aVUhXM00zb0dSNS9YZ0s3bmxIRXNBRmhqTjMz?=
 =?utf-8?B?U3hvckxJWUtUNnJkbGJmOEY2Zll4T25vd0lNOGU2bTFKcTBPRW10TytoaE45?=
 =?utf-8?B?QWdhRHAzM0FPRVR5Vys4ZFRsMWpuNmNaSzEwU2Q4b0VBN1ZQNGExZS9oeHJM?=
 =?utf-8?B?cThJUEhyY015TlZyWHVvZ0pGRlFqUk1ScEpzeXV2YlJBSjZ1YStoZ1A0Y2x0?=
 =?utf-8?B?VW54UlJCL2hlM1pzY3ZQeHB2SXdKcFN3eG1TeHhZd1owa0JKT2VQejZyb1Bz?=
 =?utf-8?B?QmVHMCtEM3hrL1dJS1ArVWx4QkpZQUVpelExa0dnU1kxWmNZYzR5WmY2aGd1?=
 =?utf-8?B?bHpvTlFOc0tZOTJ1RGM0c3ozZHdNbGZ1QkJ3Q0ZzcUE0ZExsWkU2QWVUS3F2?=
 =?utf-8?B?enhBWVNxdEwzT0RFQzRSMWdwcmd6YitpZHNrbytIUm1KbHozbEpyVnkxSkFq?=
 =?utf-8?Q?W9d+aIk2EQzFS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEYzTzJ0NjloN3pMVlZnYTM0cy8yRjFhY1dJQlpxRk12MVBjelpWczBLc3Ax?=
 =?utf-8?B?eW8yZGpkYUpKejVXRG5ldXo1cDkrSnladkhjam9aU2FNb2VTRHlQTHJlRDJV?=
 =?utf-8?B?dldaK3Q4QWdBT2hJekg0N1puWHNpZ0FZNmN2dlBBWDJWTFVFZVY4MXVRNWpC?=
 =?utf-8?B?aXBFa1pLeC9PdUdSQnFFcGhpUnJHSVdneGhROVFPVmx2cGVrY2hTTmNQSktX?=
 =?utf-8?B?VENqaUFmU2FwdCtHaVc4ckYzR2Q1MWFoWEpKR0h3S2NuVDFNK1JYNWFXK1NG?=
 =?utf-8?B?V2J1ZUFPandPMFhiTkpJbTVxYzIxN2Z3NFNPNURNeEpIQys0QkhIUXlqUHZC?=
 =?utf-8?B?KzBGdTRYZmpUR2VKbXZZY1M3UkQ0MkVqWkUzV0ZaOXdKS3Y2czNwcHFwUkxK?=
 =?utf-8?B?Y0RoRVlTZnZHYXR0ZGt1TWt4cmlZUUdBYmJzZnRnemNOT05VbU9sMGlXbnM0?=
 =?utf-8?B?NHdQWndNV0dvNW1QNEhtbEovR24xVFVFRzBTUEo2blIxUVNLenFORDIwd3RJ?=
 =?utf-8?B?Q1gydTVZbnNDN1Z1T29YSUxiMWNpd2lsYUdWcC9oQlZ1N0w4dVVSZURNa0gy?=
 =?utf-8?B?QnF1ZXJjU1FjNVhJWHlBS3cyTDFvN0l3WG1iRHJDRlpEcHJOdTdqRk52K0RC?=
 =?utf-8?B?bFBFaW45NlpkdWVGcWZzVzcrOU85RWE1bktqVDlrNUFnUDBqRyszaGdveWZY?=
 =?utf-8?B?V2Q1bFhEbnI3K2ZCSURocFVLUk8waVBBVjFsSThReEswZHhaME9jZ0pVUXJy?=
 =?utf-8?B?bEpYdnYwYU9QZmtvczhTSzE2WUU3bnNmakRKOWpheXF4M2ZyY2pvSnEwQ2hp?=
 =?utf-8?B?TnRDNDQwaDFFVlAwSTViYXRhNHl4VGw0L1d4VGFma1BNb3J1Zm5qTml3Q1JL?=
 =?utf-8?B?ZlcvdEprb1JvTHdoR1pibXZMUGhzUlBHWFpLV1RWa3FEUFcraWcxeFB4Tmk5?=
 =?utf-8?B?UXJFTU8ydjdYcHJqUFErcTYzd2IzdGVGTlVNRDFwYVEweHJ5WmZQMWxhcnFI?=
 =?utf-8?B?emdSRVBNZUR0NjJOL1VCVmY4akNiZHExT1B0ek5PSFYyRUhNMnNsa3RpSDVL?=
 =?utf-8?B?dWRIV1NQczdJZlNQMEVwcnpiaHFpMU9XVks2Y3JLMTJaVEIvS0s5eGdMaTFK?=
 =?utf-8?B?c2JuY2tBUHV5a1RpOENzenB0SE5TbUphTnNJQnFXL2dFeGJLb0ZDL0hSMUlm?=
 =?utf-8?B?dWNOU28xSnFrUU5neXFGbG1UbmV4SzBDTHlWamt6OHNNYTVZNVEvWkJVTlJX?=
 =?utf-8?B?eStwUTV5YTNvOTdLaFF0a3IyQ0NmczRjTTRjS0ZqVG1GeVNpZVRJUVkycllZ?=
 =?utf-8?B?Um5HZVJJQ3F4RVdoaVczSSt6RHFzUWpXL3Z5QUQ5elh0alI0YmJDZW1jTE1C?=
 =?utf-8?B?VEFEQS9Rc3FGVnRRS014WFk0WDRJdHlNVE0zSmVyNWNwNTNYN3BEMHNjcmV3?=
 =?utf-8?B?WlVpUmptS1NDVHlYeWg2N0hCOWRncFFGdzNxVVYyYW9TcWN3bjhkRlVwbWYw?=
 =?utf-8?B?eEY0TmdNQ3ltOGZKRlYvTVQyUDBWci9kTzgza1d2TUl4Z1IzY1JHSkdsMTJs?=
 =?utf-8?B?U2ZDOEVhSjJ5RVg5alJOaS96Rmw4ZGx3SUM0bm5pVUFYRnJnenpzc2tqYlQ5?=
 =?utf-8?B?N1h0L2szRVVxSzB2ZWMwWjhWcGRXRHJKNDZoTi9TVE9HTlVXVm9Ka0FXbXND?=
 =?utf-8?B?VmYzbWRZZldscXE5TTBHUEFHU0VON3hvamM0RXdmV1ZuWWNLRmU0UVFFMmlB?=
 =?utf-8?B?d2ttUkU5UHhVSm5QOVJHUWFGdWZ4WHNHbXZycENvWVZkQ1FMTWc3c2lXK2pS?=
 =?utf-8?B?ZnkvNEtQT0ROOUpkeWQyNjFEay80R0xuOWt5REdZZ01BTGRvZ0NxdXZxWW1R?=
 =?utf-8?B?TWloVTg5Rk5iSmpYc3hPQUgzVlN6WmJRcmNiK202WGFxcWNnd2VLcVpkOXh4?=
 =?utf-8?B?L214c3gwSDVEK3JkWEVaT3A3Z3ZuNzdNdHhTakRMV2krZ0crdWpqSUxOTVp3?=
 =?utf-8?B?eXpIVVcxd3NNRktrWlcyczBlMHgzb01NRjhma3EyOU5QVC9pOFUyd3B0MUdz?=
 =?utf-8?B?dlc3bEJrSWQ1b0Eza1FSSnlkZksyWHAxRmV0SXN1VkZUVUxMalJnNmgxbjVO?=
 =?utf-8?B?aFVMWTlTNFpqTFE4YjhxNUNjc2ZJK251M1JRY1hpdTRNT2w2YlJzZnR4YU1Q?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 123aec1c-d387-474b-b593-08dd67025877
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:23:12.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63QTXm5JqCBlr2q+0+PSnm0CQjL3ew3Dg4vkHLG7wNVoG0KfVTIh9pd4utK5Q8yqBhoH9j4K7yqrx/+eWm+sUew5Iyda35GkAZgl+GanLPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com

On Mon, Mar 17, 2025 at 03:58:12PM +0100, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Fri, 7 Mar 2025 15:16:48 +0100
> 
> > On Wed, Mar 05, 2025 at 05:21:28PM +0100, Alexander Lobakin wrote:
> >> From: Michal Kubiak <michal.kubiak@intel.com>
> >>
> >> Implement loading/removing XDP program using .ndo_bpf callback
> >> in the split queue mode. Reconfigure and restart the queues if needed
> >> (!!old_prog != !!new_prog), otherwise, just update the pointers.
> >>
> >> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |   4 +-
> >>  drivers/net/ethernet/intel/idpf/xdp.h       |   7 ++
> >>  drivers/net/ethernet/intel/idpf/idpf_lib.c  |   1 +
> >>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |   4 +
> >>  drivers/net/ethernet/intel/idpf/xdp.c       | 114 ++++++++++++++++++++
> >>  5 files changed, 129 insertions(+), 1 deletion(-)
> >>
> > 
> > (...)
> > 
> >> +
> >> +/**
> >> + * idpf_xdp_setup_prog - handle XDP program install/remove requests
> >> + * @vport: vport to configure
> >> + * @xdp: request data (program, extack)
> >> + *
> >> + * Return: 0 on success, -errno on failure.
> >> + */
> >> +static int
> >> +idpf_xdp_setup_prog(struct idpf_vport *vport, const struct netdev_bpf *xdp)
> >> +{
> >> +	const struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
> >> +	struct bpf_prog *old, *prog = xdp->prog;
> >> +	struct idpf_vport_config *cfg;
> >> +	int ret;
> >> +
> >> +	cfg = vport->adapter->vport_config[vport->idx];
> >> +	if (!vport->num_xdp_txq && vport->num_txq == cfg->max_q.max_txq) {
> >> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> >> +				   "No Tx queues available for XDP, please decrease the number of regular SQs");
> >> +		return -ENOSPC;
> >> +	}
> >> +
> >> +	if (test_bit(IDPF_REMOVE_IN_PROG, vport->adapter->flags) ||
> > 
> > IN_PROG is a bit unfortunate here as it mixes with 'prog' :P
> 
> Authentic idpf dictionary ¯\_(ツ)_/¯
> 
> > 
> >> +	    !!vport->xdp_prog == !!prog) {
> >> +		if (np->state == __IDPF_VPORT_UP)
> >> +			idpf_copy_xdp_prog_to_qs(vport, prog);
> >> +
> >> +		old = xchg(&vport->xdp_prog, prog);
> >> +		if (old)
> >> +			bpf_prog_put(old);
> >> +
> >> +		cfg->user_config.xdp_prog = prog;
> >> +
> >> +		return 0;
> >> +	}
> >> +
> >> +	old = cfg->user_config.xdp_prog;
> >> +	cfg->user_config.xdp_prog = prog;
> >> +
> >> +	ret = idpf_initiate_soft_reset(vport, IDPF_SR_Q_CHANGE);
> >> +	if (ret) {
> >> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> >> +				   "Could not reopen the vport after XDP setup");
> >> +
> >> +		if (prog)
> >> +			bpf_prog_put(prog);
> > 
> > aren't you missing this for prog->NULL conversion? you have this for
> > hot-swap case (prog->prog).
> 
> This path (soft_reset) handles NULL => prog and prog => NULL. This
> branch in particular handles errors during the soft reset, when we need
> to restore the original prog and put the new one.
> 
> What you probably meant is that I don't have bpf_prog_put(old) in case
> everything went well below? Breh =\

yes, best to check with bpftool if there are dangling bpf progs on system
after using few xdp samples, for example.

> 
> > 
> >> +
> >> +		cfg->user_config.xdp_prog = old;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> 
> Thanks,
> Olek

