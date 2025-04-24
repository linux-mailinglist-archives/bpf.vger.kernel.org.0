Return-Path: <bpf+bounces-56611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E63A9B22F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918114A23E5
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECE1DDA2D;
	Thu, 24 Apr 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnGsrmd2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE819DF53;
	Thu, 24 Apr 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508459; cv=fail; b=PsHiTJ4HKanWqkoGqiXAeEONuk/RD9+CV8IB1ZkEPBJD4QI3Knk17b/fQIvlFzgerF7ik5vT3mQ4xypS2vwcJnsXVMvEN6jUJJeLwtZDTqwEzwfC0YsytN71jx+baPXewPBL5kAtVP1WsTWLca4luYyAz+9mL7fY+eqgeABErNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508459; c=relaxed/simple;
	bh=X+HtzrPOs4Y+CR+xDVzrFv8aYHxW62dD1/Pa275XPHw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pSUuJxIHToMaVRmSFNsDrU3ScuCVQA52BMY90svD8/ng4htq+NxENokmL8NjJmyXU3iGpdnKIvvCrT5rVYraWHaU9bDSwFNYmvQIF0dMSMEl0VT2uVPaWrmT9p9bUq+ota/qRQJrWLyFByWN+ZooorTZ1BIefwwXa4tBMMcSpKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnGsrmd2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508457; x=1777044457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X+HtzrPOs4Y+CR+xDVzrFv8aYHxW62dD1/Pa275XPHw=;
  b=LnGsrmd2Hb1aOZrj7edDqCxZ4IG8Kl7I+9R948Zvqqm33Ui2mK1QMB7T
   YSnZYkq2To1bx0hq10iUiGM/fCuogQGr6aF1dmh3x9aXuaHn3+T7lPPL7
   2KyTDyT/+Ahrj3VJU+wQ+zcBSck7PXL0Rt5jRu52T1gPSWwo9ek+NMbCY
   sM1ubQFybh+DMrKOu+eLQbb/r1PaRgOk782wrvpbe4pflgOJswqkYUUKs
   ZilRnBG8Z5OQV8FqCRPiEjQJMc3en+2FRGrYrOtu5ZfNfT+gxpzbE2Fva
   joKQV59O6+1YFVwo0oT68YWEOBvzOOLRKLf36YEjDJSWvEg+0lAfmUNGx
   w==;
X-CSE-ConnectionGUID: 0fhqzqZ7QmaXmGB7V2IBJQ==
X-CSE-MsgGUID: pI8NlJn7TnWDfBDrtRIDBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="64680535"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="64680535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:27:24 -0700
X-CSE-ConnectionGUID: boxRt+HzR1aDgoU3K3Gzog==
X-CSE-MsgGUID: 0TZTprT/Tmu0SAEtWChYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="137821639"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:27:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:27:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:27:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMu7j5qfYq399VwW78Ee3mVuhhy86sriftLaQay6T1zbyM7Fh1rCgqkWJqBV09OWzww2HXvdUAeOIHwqcIWH+zZNO9YAEquPOLaVu3pMsw8RoY6BDyNTOx9oiveZid636lg2bxkO7KAibPIYtlhEcl1NPizjosdJCRzvIIXgaNO4o48eEwuXlXGTwtrQ0+XkA2u9aNNpDreqBuszdGdzonrZ41pduK3LXVPUI7ElDRgRgYsezjjtEIK/JMLX7PAnDSyL0jwP401yaQ7n3uMeCG3HgqYhAmK6FhaR6wFDy587Zoic4bSM6ZEcNleWKRgGhcljVlY/LbSup9l5J4ZwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6styIvBoU7pjjEJXxBBrPEstEI86tJUoRs5tzPtXgs=;
 b=jw/EgWaMma6nYoMNKGZFhFoJk8TuxysnUDReNVtlE2LL8IkQeq5cQCbQ28lKQ8WJufrKO8xjgIRQUu/05FBM0HFQihJINr/f/KKaLaEjxfwv1QByM8zfn9rIGOmjUPyUK6cSQ8YmwfQZlo5QZbBbC+XmBg5kCe8jMAxc65ZOxk7xhkV/WwikSwMv5olx53/FPMRmcgbamrT3O8Hx6QFnzJ/xhtW+TcekFaOtuUI20inkhj3zbYmMod4PrrIuoNOVcAqWbX3sNLLKJQ3zC12naFbnXLeHDv4V5eutdsB6a8v68K1zbbY/5Ev/yerxmpiTa5lJy5p2oKS/d9xl0DKCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:27:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 15:27:19 +0000
Date: Thu, 24 Apr 2025 17:27:12 +0200
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
Subject: Re: [PATCH iwl-next 06/16] libeth: xdp: add XDPSQ locking helpers
Message-ID: <aApYUEjA3Jcklazg@boxer>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-7-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415172825.3731091-7-aleksander.lobakin@intel.com>
X-ClientProxiedBy: DB9PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 436e8f5e-1566-4dd1-0db2-08dd834480a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gtmsG11rTQwM2fZ5DozXwM6kBR3ylyXRVnCe1kVpFYcfngrtZZE/WakYOPzZ?=
 =?us-ascii?Q?eyQew0lhCU0ptF1LQ0u0r7VCTUJzyQvGLrxT5hXBckTc0Uzp4vco/P2ieOus?=
 =?us-ascii?Q?A4JtWwYGp2Ex6ZQsKYVjJyvnzLCTg/JqPNxy9Y0Vq4FgzHGscSyolEtgN/AZ?=
 =?us-ascii?Q?ljDJskFoEvdPiCwWKa6cmD50DRFYY2tyCoV3OD9O6BYQrhFhaRD8lPA5pR1n?=
 =?us-ascii?Q?HUkZrNPkbyXhGf2NPCLWzwYFeuD5CYOn8PTwBSxjzx5Lg0t9WE9su2FRTgIh?=
 =?us-ascii?Q?cvIoVgEGC8vBYMNQIovgH1cw8Y6mIUfR3xTn6Sxnpq37i9QNGmg/h4R7H+ZP?=
 =?us-ascii?Q?ku5YHGwXDZQ0YNrGB1nNZ7SUw8sy8/tjLt5d6v8v9Es9j8ysxLbOUiBly4QO?=
 =?us-ascii?Q?tSA4wK8YrDH+EuaBnwuFfcHTG6EjF62Ph0uqphz+Z9DpdupNzmkOX4IgyKM/?=
 =?us-ascii?Q?i04BDTQ0vduRDqA1LFmR2HWWP9ycAT7zzWBcQ5FGjLaRHeJfH4tv+CeEkZXM?=
 =?us-ascii?Q?m46nmn/WDRvoiDuPt9eK8sQYnmwxmipLtWvMGoA9MltpYO9B01zJNHBo4C/8?=
 =?us-ascii?Q?GK7pGon3ct54zBnjWQqcXPDxjYdEkd/aDHDFBKBS6yVHvkGKyi6tfAvucEon?=
 =?us-ascii?Q?xu3s6XHk9v1nMb2cF5nvgJPHkDHH7gwX5zX6yQsVfAP/gq50iLUSOFI03aIN?=
 =?us-ascii?Q?U2OHpXNi5ixQS3eT3UuOuhxEdyasR84zJXSVJKh40tBeNmDvx0n7mFdHBI61?=
 =?us-ascii?Q?ogZsFPUlZBSMYSBkfVl9PMs2vLYop0aql3QWBpZh9Tssdo2jnszr61HL3hlo?=
 =?us-ascii?Q?EgEcpkjr0/0O8Bv+uiZVKxaBi+VLLIn0ySUFyuqmn0z/0wZplgNP9wXVkV+K?=
 =?us-ascii?Q?5QbrCkl6g3bBZz/ijkUTU/i2Q7igzAlgcH5nnk62hwbsgasQivIkby4Oku2J?=
 =?us-ascii?Q?rw1XEisU1YAzZmDAoFGmgBENMtdXXz31daK68wVHCHr1Id9FWA7FaLclAYlI?=
 =?us-ascii?Q?dQpWHV8GlW1kAruwCe64py5Kr72hU6HDC8aCOK4aTuaJAwAsgt/FSxps03eG?=
 =?us-ascii?Q?WoT1RCoq0y3yi/GkGdi4cNL9kzbMd60cxiHpwxypGxe5XO05bQASSOFdrN1k?=
 =?us-ascii?Q?TtKkahFqV2WY5Tt3HnYbYL5ekwP3czHxHBYxZa6nRv5Cs6oNOGhde/LtBZub?=
 =?us-ascii?Q?UH2xadWI0t6ny+6X4+d2JmI86vMCTUpOfGqFtAih3bdan23T8yt5MzpVIWt+?=
 =?us-ascii?Q?N5rXr5oi16OjJSei/7eCekuLSxOZuTRR7ybD2WMsJZuKwcH7MYUW977H0wXD?=
 =?us-ascii?Q?EYiNsgN4zeL7jXbMcxcK7fQTyVBfqtBHRaP1bHLJw3+loV/XUjNlV89h+H5D?=
 =?us-ascii?Q?GBq7v2l2PrCwvA0mbFvBoqZyGxSUKco4li0y5aQ5jkeoBLyaxf/y8akSZau0?=
 =?us-ascii?Q?RQ9R0tVYV7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1CxSfa4Bt7pnffJScT6R9Tj9vCJ9kibZ9U1VtNgvs0uWidjNzkFPcCSY63o?=
 =?us-ascii?Q?7qRbtFIH9SUAQCi7GNh19/5m8MFivO/a4DNdUtcQwgyPG9DA2RMIp46hCzjh?=
 =?us-ascii?Q?vnRz9y8hMOpTygJRTOMdSFLFT0+/DjvJgndw9XT2T6cjH/VcbFf9uz24xZl7?=
 =?us-ascii?Q?xmVU2oICg8SKFO3EAEn1uS+ZhJqig6LJ6tEPExhR/5gOedeJc4MqBe4PWSUP?=
 =?us-ascii?Q?2vpv8fJMO9N+0xJ2+BFKjXrq6xo08lNsQ7sA83SY/ptGNsHeiFbQxEYpLl2m?=
 =?us-ascii?Q?F912t7eyxCJrw50DhdxL8IOf88jExTT9zloenjfXZs83Sv2vd0scKynfq9cJ?=
 =?us-ascii?Q?EApA3yAdrxS0Mkbxgvdg07LDWDsIZZtGhSsc001h9DoBLN1qspmujgoGzU06?=
 =?us-ascii?Q?XgCUuNE+Jft6D6xKs7q2rcPH6FWaYGp9QoiqmB5gp/vWWKuteabysnHQPPQQ?=
 =?us-ascii?Q?PO+RvYjjZhrbxTWQuY9LouyVciZEltiPoyUeKiqj8FE+o4dd1K7JCeIIO0N5?=
 =?us-ascii?Q?+2hQFwFkKs4GG0gQibvzFXTvzcOF8KbdMZfK0miOUfGGrzpAz2qHhhX7kut7?=
 =?us-ascii?Q?DvVdLgItSaqn04dbwjQzU6ECsDM+dJAy34ZBf0S5jdiaf4L+hXZx57SEtNXb?=
 =?us-ascii?Q?ESiapp5S/TkL+Prg7u43M5NzJrQc4OE7iedFmSheL2nyzP0GJqdSq5DIzsCu?=
 =?us-ascii?Q?hiJKjH/xycoGI7HCspNmqGG4T27sTr6gHLezAF5mEBOFTnHnLT0Pmn5yy/ML?=
 =?us-ascii?Q?ql7fyxgEua+hpEXpBcMVObpFko6Hdvgsl411BuC7y1RyFYbX+OqDzKMqYQu4?=
 =?us-ascii?Q?SJHuNT4ikAPUkos3N2TTLc0vzIzwdckhtGJv29N3fP2NOQeC7b4NaWysXXxi?=
 =?us-ascii?Q?ZnrbvuRQuTMQ6OXwP92HUOeXkiQFUcl9iGM3wtBCLC+fZRzzbB0TJXQNJjQs?=
 =?us-ascii?Q?XB2tkRcCDk5Hksa1VpUYIwtvGvNkWp0+DYnBehGyYZwal62+tBChBxFxOqqV?=
 =?us-ascii?Q?X5DUlYvL9n4DO2X1B7cNMgjnZgUD/GtDMU4iX+qg7h6OXIlQBIYI2y/ATd6U?=
 =?us-ascii?Q?0jova7BWkFSNDaPszIEdTFzs0KyWWyllZ5yejn+kfDroqX7yPt/Khcl1GkSl?=
 =?us-ascii?Q?+jTS1KtpXALTw4Q+neWt0Sjw4P4KXxPugJYajM9AKwmRL0vPQmI6/ezHC2fZ?=
 =?us-ascii?Q?qUHvP3eC13sfYY93yXCkrAkWRj8cQNy1wQeW+fin7hvMmZ10zrVm4Y43Ehsb?=
 =?us-ascii?Q?Wf2lneSV/sroueMgiWxKjsZojzC/J9a8VGwqwaQmafT+J1N7c634nfJOnq+6?=
 =?us-ascii?Q?A19yvkSIyGymGNsBfXRo5r2noELkXdB8xQ21aqHR0BMvIISKksJ43NdZf3zI?=
 =?us-ascii?Q?eNTzlxTsdAKwG9ocOJCtOTfYud2yupuslNNEc91eB/dQRaw9fBS+T9SkSGxc?=
 =?us-ascii?Q?sygB79Q40kbMD6Prr1VcmuxADS5s9iK+OU4GoPppF0quj2rVzM+0h/MdMtol?=
 =?us-ascii?Q?t84Tq0qFs84EVyPNVJYu5+FKxyPYTM0SaSg32OcwgzFJUmKYctfVhlvIAktr?=
 =?us-ascii?Q?gGkacOdnZeIBC19QG2kbm1bJ0+Ye+2uwcxE37Zv/vHZV5iQIZq/Iw4vvJdn9?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e8f5e-1566-4dd1-0db2-08dd834480a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:27:19.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc3opSi097o0dKGdi+6pnNNIQRpLNTklwU7eoyyNDKmS52LoeM0qO7+zXKikJrwFgBJ9uqjED9ABZ2aBwZ7KIbH/9WFpoXPMvhdqhq04ARg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
X-OriginatorOrg: intel.com

On Tue, Apr 15, 2025 at 07:28:15PM +0200, Alexander Lobakin wrote:
> Unfortunately, it's not always possible to allocate
> max(num_rxqs, nr_cpu_ids) even on hi-end NICs.
> To mitigate this, add simple locking helpers to libeth_xdp.
> As long as XDPSQs are not shared, the whole functionality is gated
> behind a static lock. Otherwise, each bulk flush locks the queue for
> the time of cleaning and filling the descriptors.
> As long as this particular queue is not used by more than 1 CPU,
> the impact is minimal (runtime check for boolean twice per 16+
> descriptors).
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # static key
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

