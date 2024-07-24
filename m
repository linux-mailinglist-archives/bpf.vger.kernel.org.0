Return-Path: <bpf+bounces-35552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95693B6E3
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 20:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB718285262
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74CA16B75B;
	Wed, 24 Jul 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvnYwIL/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26A16B732;
	Wed, 24 Jul 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846277; cv=fail; b=LtlE0iKXMguYKHPUw6rH+Y+Ew14mwBxGzgBzcjvrJUyUkqohZFdpn3HWcSfVzCQv/8xiRVqeBECHRwDYYIRNf/FHHxYNkDOlPLdFyqAvCMScfBg7QnGVosj+b2qQa5URxOI6TNwa/Ex4DjnQhJjtpw2s8SOowF8K+Xc9YmLEI0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846277; c=relaxed/simple;
	bh=Y93+MneUHovgYjZNsyetk1ZmgO0DG9OYHBW6CBIlRNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcY/vf8W0DYt6QD7lTKZwU4px6OAvH9lBhVjfrARaDW6OONqA7osZolOJt2SUXrn9zxKge6yxWe7wLh+QaEqtz0uykmx3+Rswk4Tgqr9Qj5jRX01nKBx7YoIL63T6QTm2j6t8BiNkhlUoCkDriSM5FKsYpSTK0yQJyMUTyKZF+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvnYwIL/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721846275; x=1753382275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y93+MneUHovgYjZNsyetk1ZmgO0DG9OYHBW6CBIlRNk=;
  b=fvnYwIL/HsHv9M8SGlSMBMkRcZFVyDtbmBuQUWlBCd2UpLC257Xm6qzp
   i2XUlL9WQmJUpNJnFnxPlwM25v6I9Kvr+HNp35Dmnwvw9EvFosq5030aE
   HiMVPzmWnU7pVBWeLHmGKrmY8umgZJlkcKP9V55on2/8vzSRU80cBTv+U
   7eO/9N+E0+16VzfUPMcy5y9dobCYH+FoppWM+ey1ndOvYOD2xgCrFHNLZ
   GbYqHyWAQvEJm/3kZH4oR0FI30BdevThZl+ibk7Sww8wRcV20ZL+q3mio
   0bWPRfSRWKN0cHYj5lvs2siLzqEpc4MfN61FK/YURcKRKlyRqYdx0akuj
   A==;
X-CSE-ConnectionGUID: 83/qvaraRhSnYQ+b4jgE+Q==
X-CSE-MsgGUID: RPJWZ/j5Q2OSzqJKvFavcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23410243"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="23410243"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:37:54 -0700
X-CSE-ConnectionGUID: SJs7mbPyQty7ro5bEimw/Q==
X-CSE-MsgGUID: D0jFyn5VR0mljEqialX61g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83275153"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 11:37:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 11:37:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 11:37:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 11:37:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 11:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+hmkyTKs/IOEE5TRlsFJQkFrOsas6prdxqaQXj1nvwD+SJNdp+fQ33hRfHAEIr8cg1iXv510NZ6LPRkKUlziT9GoG72hoRqlZ3snni6vcF/bHONEwsxgaDupFumASVHSFQOBzst6kPNh0KGTLWFX14VIiT/+URlvEPgdTcr367gLc0clfVVhcaBzomGHAbaQwiEpm26fwDtigo6nlBovCMPe9Dl/beMzznVS8oKjYmO9jqBdjKsQiMY+x8eXecASXjBevCXUY5CNzgThJp8gv2B2vJbk3pRtKPS+oDMhgCXDxV7yUXQNiAuu1+2xerGherKGTKmYkbeOhuyfbh0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GThk/QWjez+f2moD3aEBvu/1eSFnLbvwrZKXnuWtfD0=;
 b=uda7oIrJY8CD5G7QKWUSCEB6MO6wZ+ntQdNQPWezbydc8DXEj9pjkUgsxEm4n5Sk5PeOn7dSS0S01u328pQ+ZuRjasLXd8+ImyXUnb2nXaWEfXFg9H2BzBZZRRaqeym6MQFhgey2CIt6kLTzhyb8qUZDY6cY3WlXw6EfgcrLrDfvypPoyY7Im+RUy9zoS4Fgm3qKKFWNOVKZqlWZ8VxOulfBZ84UArmnf1svqiECJQ40boJW5tT5VuraOSs5yV8UoodW3sIzhJRrGZ1yU9l5pYmQm/CCeN/oeZrsQGypPeJmIEijEmhN5XUxmWHmR/dDAaO5E8t0N4FSGzag+9E+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Wed, 24 Jul
 2024 18:37:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:37:51 +0000
Message-ID: <b5ffed37-5a2a-4bcf-bdc9-532e72aafebc@intel.com>
Date: Wed, 24 Jul 2024 11:37:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 5/6] ice: remove ICE_CFG_BUSY locking from
 AF_XDP code
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-6-larysa.zaremba@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240724164840.2536605-6-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe79302-6b0b-4a9a-ae10-08dcac0fb938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1AxZ3RwRW1ySGRzRGQzK1VtSG1MMmFRamVkNGN6ck1ibGVuNUFHOHBvdkdj?=
 =?utf-8?B?am9kUmNxVUFMdVlPdGQ2cVY0bWVNNnY3MEIwS1g3bE1RQ1lWVUhjTHJjVWZW?=
 =?utf-8?B?UTFhcVNQcks3RGJUYytxa2lrazNGWXRQemxKZW51NnpDaDBSWHJVbzJ6NHBB?=
 =?utf-8?B?ZTJqQ3lXR0xsUFhTeC9FVnRJYkFWOCtGQzVUUnhEWkFnUHg0WDEyWVZqeHdk?=
 =?utf-8?B?UktaK0hRbTQ2STNUYllPTjFOb1BBNWZmc1h1dGcyRzNIZXF5VDdNSGZXQlVZ?=
 =?utf-8?B?dGxDN2s4dHp2dzNyUFVobU9xeUhXcXpmQ08rUVBiR2YycGxFTW84bkQ3TTYw?=
 =?utf-8?B?Z00xRTh5ZHlpRFYzSTNsdkZiOFFYUERaQ0Z6WVNHeGdmanM2bFBkdElzYWg5?=
 =?utf-8?B?QkhlRG5zWEJPV2gvd20xQWdQVWVieTVVeU5IOFRwRTN0azRtZHRHRXM2TVZo?=
 =?utf-8?B?aW5uOW5rR1F1YU0zRExNMUI0dFpiNmZ6N24yYXY4bXF5UnZ5b29TUGZLSkRr?=
 =?utf-8?B?eHFOdGhEeW9iN0d3bC9kL0RRRyt1d2VndE0vQkREM3FNT2k3MkpPTS9lKzFl?=
 =?utf-8?B?SlRNa0Joc0NBSHAxaTg4WE1XM2JjMUFvSmllS3VuL1VzZ2JadmtQb1VXbC8x?=
 =?utf-8?B?RkpJblJSZzNKdHcvY004Z25ZTHdIYy9rb2Z4V0hoamVKUFpoMTcvRXkxZk1K?=
 =?utf-8?B?Z1FVWDN6NjY2QldGZ3UxY28yY1FBQkx2aVJWMmpiWXNsYy96NitudHkydTNo?=
 =?utf-8?B?ckRaakJ1ZlVNWUk4VG9lcE1WVHZBNFlMV3VkMFRSWis1cmVjSjNsZzZ5U2ps?=
 =?utf-8?B?T2tJWlhXODF3K1lTUDYreG9NeW5wNXBTYityU25aVDJ2Wml6Z3hmRmR1dGJt?=
 =?utf-8?B?WGZ6YzlWMURLeGZJNzRoUjhyUGlsME5zRkcweXpJeWFwZzF4VDZNRWtzd2pl?=
 =?utf-8?B?TWpZb3VqSkZSb1NWNjl1YUw4MElGdStqVnhJc0dLby9UKzZwcVdwUmg3WTlz?=
 =?utf-8?B?cTI4SSs2ZzJSMS9iaXB0emdOMXFOWlR1dHhzMlh4OWcycnBVVXowMTgxa1N1?=
 =?utf-8?B?QjdHZEQwZ1FaSlZEaldXV1JiODhEazRtTkVaR01tTlVDS2MxRWxqNjl6eXJa?=
 =?utf-8?B?TmxMc0Y2K2lKSUhEazBZUzlPUDRaL2l6a0FEL3Exc1UwQ1lhQzZyalBCbHVU?=
 =?utf-8?B?YmczVWgyKzRoSHpsVmMzMXhFWC9XMmREYlY5UFFITElhdndWcmlMZnE4eW5j?=
 =?utf-8?B?RVU2Umpxa3pjSERCOS9LZDlpZWpZU3g1aEZPTklFUjhYSWxhOHBwRFlIQzNQ?=
 =?utf-8?B?cWtOY2pBWVcybGY4blMzOHFCd2tscFowWTBUUEhwOUtNMTNRaGN1RW4wVVQx?=
 =?utf-8?B?bkQ5aDlNKytYMFdyZDdHMUhmS0I5dk1ZdkNZeVpYS3JYM3BWajdpTVBZeUlW?=
 =?utf-8?B?S3VJaHl0TWUxbXVuSk9BSmdKK2pZQ3FBMDV4V0xEYnRlNjRXQVVoUVBwMWtk?=
 =?utf-8?B?YW01RUVyTE1HUFczSVFoMnlaQjdVTDl3UFk5SEFmUVVQTU5zK0Q4S1JESlV6?=
 =?utf-8?B?cFVtWFNyUnl1Tllxd1FCelBVNEdCdWhENHl6WFZUY3JkZm1GdGUwdWdFV0F0?=
 =?utf-8?B?Tk5xZnJlaWhOUXpqZVZxcmI1d2FtcS9zcE1sUWNFVEozVlRMZXBkNjMwQ09v?=
 =?utf-8?B?SEUwVUUzYXZHdXVoNlJRdVJWOWpZNklSUm9oaUNLeFF3Vkh6aHpvSHFoYzRS?=
 =?utf-8?B?cTVMbHBPVm9NdVNkRk9EbVZQMnQ0UHkzSUxjVjI4TUV0bTliRkoyOGRUcTJX?=
 =?utf-8?B?UXkxTFpqYVRnNXUrVll1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlZa3FVMGNCUWgzVmVBSERUd0E5UUJodmtwc1dOMjYwOGhPMUJYdGxCRDYx?=
 =?utf-8?B?MEZmRWdUQXc2U3pTVEpsbFNTZzV3RlYvditKaTlraHVLbjBMU0svS1RzSm1t?=
 =?utf-8?B?TEJKUlRSVlBOVEduS1JLaUI0RjZCRHpuVzlnWENONGxLN2R2Vkhua2xLUHlH?=
 =?utf-8?B?MkxLbVVhbU1QK0R2Rld5aWY4bmVDeVNSWENHdldyazVVZkptWVAzYUdLdDVU?=
 =?utf-8?B?Vm5zWG1ndzFFSFVXQnZ6S3ArK29wY0plOEd2TVRGMW91MVZpR1RWQVNidkQz?=
 =?utf-8?B?aU9SSytTWGoxME0wS2hHUEFucTBRM2svY1ZsSzFXQUc2TWNRc0JhbkxqMDdj?=
 =?utf-8?B?UnM5Zk9sTmZ4VGQ2VEVSSEgvbUZ4TDQ1MVg4NDVySjRBUUFQMVRudENlK2to?=
 =?utf-8?B?VHhJQzN5dEVlTGVHS3R5Mjl2LzlFZXdnd1dYY2VRV0ZiZHp1ZWlHUmxjdVY5?=
 =?utf-8?B?ZFRDZHpHUkszc0VsSHFYQnZFVG9TMS94MjJ3S0l2NGFvelpuOUFiYmQ4Q3Vz?=
 =?utf-8?B?TVdPSXJzTnRZOTVSVis5NnVpcVhHbXZ0RVo3d2dvTFBHNko5d0o1SW9BUExB?=
 =?utf-8?B?OVAwSHM0SFhjR2gzbm1KcUJYa2NTaC9TTXdRejFYalJ4VmNpcnhZQTFBYTY3?=
 =?utf-8?B?Uk1vanRQSnc0Q1hMSnIwd0NGVWNMdElBeTBRMEtJRk1ub1NKdzgvWTdwUGtU?=
 =?utf-8?B?disxdUlFTVJ1OVdvc25EM3RDdUhrY25qdzFDdURiL01mRUdTUGpHc2RYL21h?=
 =?utf-8?B?VjlXRTl4RG9PSDZyNlR5SEdsQ2huTmpjZjVpNFdSektaRytXUWJxT1AvYjkw?=
 =?utf-8?B?UEtyenRodWpuV1A5N2d2dytDNGVJdGMvN3AyOHd4L1dGeFlFZE5MMHYwY1pD?=
 =?utf-8?B?YUNNUlo3QUNWTkhoMDFBUlBrVGw5aU5NV2lVWlo0SjM0NXNBclN3Rm44eW44?=
 =?utf-8?B?TDJPQVF1eTZoMUZUU2RmLyszcHhrYlc2clpyL0lWd0RrOXBZbFJFMnBlU3Fq?=
 =?utf-8?B?YkIzYTJQbTl4Q0E3aEE2N25DaGxrNzJ5aTJ3aUxDTmtzZDJEVTB6RFFaZkwx?=
 =?utf-8?B?T2RmOVVQd2JJVUxRdHowR29HMENaUjkvK2p4SE9JZXZma2dSL2FleTlhWG84?=
 =?utf-8?B?MFFQZDJxc2hRY1p4TGF0WXJERFBlRjNCNEtoa0cwb3BIZVdyNkh0bHJIUFh4?=
 =?utf-8?B?MUI4MmJGYUdUbVlXYXlURzJrWUlhYlNBTnM2ODEwOXBQMEZSUDhlUjZ1bDd1?=
 =?utf-8?B?bDE3djAxTXg3bTJkalBJWUlqam56YnpoOHpMSUhTR0FmQkE1eWZqVGlRMUg5?=
 =?utf-8?B?RVEwc2U4R0F4R2ZGYzdCbjVOeUx0SHUyRE80NldLTkQrMEFVeDJ3bDgxQTRK?=
 =?utf-8?B?YUJ4NG5YWHZzOTlLaWxkTjlYYzFYM1pSMU4xVXJYL09RRVkxVWVOZEtEZ0ZR?=
 =?utf-8?B?anRmOGo5WjZkaUpkQ2crZHMxTEVrak03U2tqOFZLN29yMnFqNEc5TVFpOE9X?=
 =?utf-8?B?K0xkUHM0MFlqZHNrVHowa1hiaDI2Ymgza1JSbnJHaHpFdFNnNWJ2YlNHcjRS?=
 =?utf-8?B?TlU0QnJrcS9jdnk5Qzh4SGlwdzBkTHo1ZmpLSDNJa3lhRzQrMG5mR0UzTTRs?=
 =?utf-8?B?eFlOVm1SQzNPL1BLeXF4WmhsN1VUaUN2eHVrYVVsWHRnN0tubGZPakhtMjMz?=
 =?utf-8?B?Q1dUR3psWnhQMW1SSE1yblplRVpGeXQ1dkdtdEF1emNyT3RwUjJDYnhMNWFF?=
 =?utf-8?B?d2tFdkdicXhpQWV2elgveDlGS3p1bis5MXlNLy9EM1RNTit4eTJyOGc0M0NR?=
 =?utf-8?B?ejFwaFhDUy8yRHAzdCt1emgwcHFmODZuT3ZsWS9Wd2RSM2MvU3hvcEc0SGdU?=
 =?utf-8?B?eDFTQ1NYTy96b0ZraXFsdnlDd2Fwd2k3MFdSampMYzU0dk9HWUppVDMzTUdW?=
 =?utf-8?B?dkpINVpWNDBvNDd4dERxaWVuNXE3WWQ5UGhvREVCNnlpMS9PeDdmMzRjNUht?=
 =?utf-8?B?dGZkQS9XSlc4YlBQTVY3UVBUWTV4bWVpQmRIWDB1bG8rRFBCL292Q1hodWs1?=
 =?utf-8?B?S2t1L1E0aCtEN25TS0IvMzV6aEx5cWkvSU5hSDhaM0ZqdHhyME14dG9tb2xx?=
 =?utf-8?B?S0orZStpT0hWcmdoSWM1ZFlUdFd5Qk9zcDZpZHZURGsrdmFFaDVUUFhsSGdQ?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe79302-6b0b-4a9a-ae10-08dcac0fb938
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:37:51.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EivSw6VuMf6Xvq8fgOTV8k2nRCI+7kW82KWF4Bf1N9gtzcsaLKWfan5+OLvvkwOURkWsR7PBaZHUme64IUkdSBI1WfUTP0Qx7ZZsHG1WIgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com



On 7/24/2024 9:48 AM, Larysa Zaremba wrote:
> Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
> because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
> state, not VSI one. Therefore it does not protect the queue pair from
> e.g. reset.
> 

Yea, unfortunately a lot of places accidentally use the wrong flags. I
wonder if this is something sparse could help with identifying by having
the flags tagged in some way...

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Despite being useless, it still can deadlock the unfortunate functions that
> have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
> returns an error.
> 

This wording makes it sound like other functions have this issue. Is it
only these two left?

Seems like there are a few other places which check this:

> ice_xsk.c
> 176:    while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
> 253:    clear_bit(ICE_CFG_BUSY, vsi->state);
> 

These two are fixed by your patch.

> ice_main.c
> 334:    while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
> 475:    clear_bit(ICE_CFG_BUSY, vsi->state);

These two appear to be ice_vsi_sync_fltr.

> 3791:   while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
> 3828:   clear_bit(ICE_CFG_BUSY, vsi->state);

These two appear to be ice_vlan_rx_add_vid.

> 3854:   while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
> 3897:   clear_bit(ICE_CFG_BUSY, vsi->state);

These two appear to be ice_vlan_rx_kill_vid.

> ice.h
> 299:    ICE_CFG_BUSY,
>

This is part of the ice_pf_state enumeration. So yes, we really
shouldn't be checking it in the vsi->state. In the strictest sense this
could be leading to a out-of-bounds read or set, but we happen to luck
into working because the DECLARE_BITMAP uses longs so there is junk data
after the end of the actual state bit size. The bit functions don't get
passed the size so can't have annotations which would catch this.
 Obviously not your fault, and don't need to be fixed in this series,
but its at least a semantic bug if not actually trigger-able by
anything. It looks like VLAN functions *are* using this flag
intentionally, if incorrectly. Its unclear what the correct fix is to me
offhand. Perhaps just creating a VSI specific flag for VLANs... or
perhaps replacing the flag with a regular synchronization primitive....

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 5dd50a2866cc..d23fd4ea9129 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -163,7 +163,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	struct ice_q_vector *q_vector;
>  	struct ice_tx_ring *tx_ring;
>  	struct ice_rx_ring *rx_ring;
> -	int timeout = 50;
>  	int err;
>  
>  	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
> @@ -173,13 +172,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	rx_ring = vsi->rx_rings[q_idx];
>  	q_vector = rx_ring->q_vector;
>  
> -	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
> -		timeout--;
> -		if (!timeout)
> -			return -EBUSY;
> -		usleep_range(1000, 2000);
> -	}
> -
>  	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
>  	ice_qvec_toggle_napi(vsi, q_vector, false);
>  
> @@ -250,7 +242,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  	ice_qvec_ena_irq(vsi, q_vector);
>  
>  	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> -	clear_bit(ICE_CFG_BUSY, vsi->state);
>  
>  	return 0;
>  }

