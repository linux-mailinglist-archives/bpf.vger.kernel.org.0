Return-Path: <bpf+bounces-52531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B59A445C6
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FEC1897E3E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301019258C;
	Tue, 25 Feb 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQBTAo4X"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FE18DB2B
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500194; cv=fail; b=CIGef0bSdrbvfhg4jrdZID0HYU/U/qMsU/q+Zy/sFk3ofV9WscJBfg4GI0aqypvvGQpAWLTXjI6ABrLQMyFdUfjCcGM53GX4ZwmiArTqEPR6apz1GNk7nkreBN5ytGL41X+i7gFpWUCUcnBatElci8Ig17wf0wu5BMngESMdnAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500194; c=relaxed/simple;
	bh=+QHM28k95OO8R3lGv3X+6Cj55B7Cf3UnHzDWQEeEoZo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPXrtOfFQ4q/sYM2j1E8HYlHexbKzshVWZMw3zc/S44jbQ04nkgr9VZK4G2SMMP1EhmEh9ZdzSiablBIswUo80xICnPLOl7z290CSpF2dT1RyrlHNklqB8c6l4TGmj/UZqRoQOWV/RkRk8yyyX7gwpa+cP4M9LwK9F2I5fbkKms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQBTAo4X; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740500192; x=1772036192;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+QHM28k95OO8R3lGv3X+6Cj55B7Cf3UnHzDWQEeEoZo=;
  b=PQBTAo4XmrBRGm8Ghrc0JaqOkXaJDDktXD5HmJz7aZAZiWtzoQ48vF8S
   poeUvDEJg0xMJVLgsO1XYoC5Sr1ESULjk2ifHq1ihGLG1gAnWSG01+ZZx
   wErYplBReyQZXYjLh1H9m+X2Ja6rTilax9tPyCXyKXcmLvQS4JVnJfZzI
   YjPyro9lP2tPH/cD9XgtblE+/5R1IwXrLrRNJUKzTOI9lhig/esh6i5i2
   6E5/G0jrn8ArF3nDNrdwDmB6FCSQwzFFoHbiFWInx3S9+Ai/oYNEHlnWn
   L/D9uqfBH+RTyGETfa/QZjlDK7/uGGLgRbBaDG9Hiu7yN+ob+HzDYSOux
   Q==;
X-CSE-ConnectionGUID: LphzyHzqTSqGqWQlrwDacg==
X-CSE-MsgGUID: Uylfm7lfTg+60u3FWO14pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="66682627"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="66682627"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 08:16:32 -0800
X-CSE-ConnectionGUID: vi1iEXS5SPu2LJ2fpzEkfA==
X-CSE-MsgGUID: 82r70j5GQCucqyhtN2y+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116920965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 08:16:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 08:16:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 08:16:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 08:16:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI2nO114fKqA/TYPT0r4Ls//Q5bY3Pli5LCxYhcLTGxE/B82iE47fdTtkLZtDa8i/Fq4QtBZzT7FdNexJWqGQrquR0qbn6CsG7g5mRCM6Tt3J4p/yQztX1gmpH9USRuqGn9XolW3Xzj467V1KyEqqapHcmVuEzsgqy78h38k98nzR4ds+1pUDIq0S3m27oDGm9Xa0Z0kQyXHG0WBz1h7cPwbMecBhQY2CGx/p38k/nStZ4JFiXpKXiVkD79Z004piqxc3khHJUlNMtZAoi8zcOq/Kmeajxwuf6DwyG7Qv3WowUv4pvRqSlzEr1YdN/XIyx58sIl3xBZAbEa5oCeuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuoFak9iOe+m2weAPgt4piC7zlvyw0VqURH21A4flDM=;
 b=tUFDwFf4zPJzynWcDakH4ZwLzfnWFanc8FUFEMaUbTj4l1q0sbJaIqVZ4s8DWPTALF2L4RKqideuG+kMnUWRkZbgw4CBKqRMpQhfYZ6olCFbBfLmcNG24xvL1+v27AJemfZTv5+cZkTdtc7b9W2vqgAj8hTI1oMQYDgHslzzS3lxMTEK+cI+ivmgnfo2k/JtMDOHV0Is6HiEql4I3M09hgqCYQBjTSWg4eFBXgUgpNpjlod3q1RTzKPu9OA5LFdZ2zANoq1uKvr4dIWclUpoCuUfHn5ReXkdaWqEdQnObrRHfvjHhFqXGP73aWw4Mk2nVJWCFzoFSuvGH30xsXbY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Tue, 25 Feb
 2025 16:16:14 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:16:13 +0000
Date: Tue, 25 Feb 2025 11:15:59 -0500
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: Hou Tao <houtao@huaweicloud.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z73svxvnH4dW9PZH@bkammerd-mobl>
References: <Z7zsLsjrldJAISJY@bkammerd-mobl>
 <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
 <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c19ee119-a463-f4bb-d15d-b7fae0a1ff4a@huaweicloud.com>
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: bb57efc9-261d-4eda-2f3b-08dd55b7b986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fCh9fp+eCluf9E06F0in5xp2P7C7olYla+2HvzgxxOKYSKW0J1W9EtiLeZ?=
 =?iso-8859-1?Q?YebH6uvFDoRd2GFhJOcoNEFKc06taveUAOWHmdaKfK+053kAN5xYQjruUL?=
 =?iso-8859-1?Q?XL3gkReIJnapb/tOMwiqv0mQxqRu7oGcSuid/oz8bLOYyA+J0l/5uHgTDi?=
 =?iso-8859-1?Q?C+Dj8IvMiAN6plmMFy8eNXGEA4qvBtyq879yDEv3tpJH/s552a6oipOzEj?=
 =?iso-8859-1?Q?2dmCKCAG/Mdx0K8QvJTF61/YyQtSSB2pihOsKuyI67opYPNjWYYK8T9U02?=
 =?iso-8859-1?Q?uSfnd8F8Kmw+XoS3iK6L28DUqacbkXSnVMdJzPZz9vbOiPKc+A9F6P+fji?=
 =?iso-8859-1?Q?feS+QnQA++eiuMeT/RbjxXCUd9QB5R1qPTjGCWPF/XST0qznMJKULXo6Kr?=
 =?iso-8859-1?Q?d5fMayXBAGbtJa8k4S1Y3hG7mNGbwsV1PLgqzho8MMgfJcRNlJcdOProyx?=
 =?iso-8859-1?Q?vBvI7TlOcsTqpRkJ7EXnU/ieJrNHLV58/Y/jz3AbXS4b1oKA6ROxtI3cFd?=
 =?iso-8859-1?Q?PlJ+5rrx8ME7N4wSPGavPXvpPvP1F3CBMbdbm36pg603+giiftaTyojR28?=
 =?iso-8859-1?Q?4XaLPBo7Vhmi72ZsGwbkg/RY86cG0o+1ednFS0iXVEmDGVmoTHwBCYG1EU?=
 =?iso-8859-1?Q?q2vkTmru9ZMofTzk354z9EwbM5kSRMXDi+7mDsOYb/oQ6HfEZrZiNP5dSf?=
 =?iso-8859-1?Q?JZykNP0YHLBQCN3iQUnwBS//6Med5j3OA0eGlS4KVRhvQTYympkrBNX5Ve?=
 =?iso-8859-1?Q?k3OjStUVMWft5UMTP00F6mtHAXLdkoxb8+FYSjHZ4EubSX+A3xGqNCkA5t?=
 =?iso-8859-1?Q?wSMOTCL1OXTtPyfYBbJcVgX7iZCXEBWr7/veFDayNHC0ZObA86T03fpw25?=
 =?iso-8859-1?Q?Kx69QFQ8jEZU3WprPEd5k9RI6RcLGr3TJFjErXPsx4NmYAWpmnDo1giUVD?=
 =?iso-8859-1?Q?63sPY+2c/BpefXfC1sUwXVW/jNW0dr4Hg4iQuHrc9bY89y/cDa51av5zU3?=
 =?iso-8859-1?Q?R2wpt6QS/ak3SiCu/4XR8gs7h1hqlFNiob//FFyf9acoP7KpMwCf//k1Mw?=
 =?iso-8859-1?Q?Wx2SYEim0GZdrQJd99LN6XvwOdsRJDwPOJDSNDCox8bllylFZMYaP/KFDz?=
 =?iso-8859-1?Q?8VqbfcDvljwfH/KlIGBd3nGBhEUW24VH3Aw5vUfgtxE9l9LfFkHOqpnvZK?=
 =?iso-8859-1?Q?Q/0CsRIG9pPh2NZnAq/47iyfeWBDAjKVP+1Rn9Sy8LW5ni4Ee/2VrLUQo3?=
 =?iso-8859-1?Q?At2YWwiYt9BiLVcmYHWiRv780yQ+/crYBAZgp82hP4EV4+KtrQho+ZH4+x?=
 =?iso-8859-1?Q?hzsBP4tpmnXF8cP7D1vimKLXEWcGxXrHX4P2VUWMzXonXKULqZh1FZIo0j?=
 =?iso-8859-1?Q?uWs99mzH6uISmOSBfw1YVWhvF/4Qw+bxZzeYc5k9Ez1pomAwjrAFX6U2MD?=
 =?iso-8859-1?Q?xltHU98Sfkui6/ly?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bWkNaMmSVP6DH+ifXwsQA5GMgSE792HK83DyOK2kyFGvxqokM+960xVv6G?=
 =?iso-8859-1?Q?Fh7UwXmToN4IZV8cQ/2zkB6guE210IIl+MDCn5Nm7yKY8oMuXoz6DmOkBq?=
 =?iso-8859-1?Q?K+Ketzi09+8av3wWkeZFiih374rdfTbrx9hxS9n9P1We4v63oLJEcHGIuP?=
 =?iso-8859-1?Q?IzzTQfIARibwtpM06v/19x2fU7yMC6RIlvPE3JEZdhi+wIs3TVtibhloiX?=
 =?iso-8859-1?Q?G7repiYgNId+oTG4aoPn1OOpq2iFPEfriKGHIkClA54HmGWhCVRVjdJtKe?=
 =?iso-8859-1?Q?P3Lwt2vZeeD6uWMVXFE8snfAEp1XHNCGS5rYHODzojlVB56beIoX5rIYn4?=
 =?iso-8859-1?Q?4rgcE2Yf2FgKHTBRKyt3eIHsJdprba5oVh2Sl5+79FZLTCkgM/z60aeRWc?=
 =?iso-8859-1?Q?G3YipN+LWnINYVZWvnG1apRHKddZLdJCLc8i2VcWMo3ysxtxX3YWrpnX6i?=
 =?iso-8859-1?Q?oMV1Q++BxNHtGchO6Ix+jj8Kegx0MIC5heOgcsqBYsDSc3VG/s40mTSom3?=
 =?iso-8859-1?Q?9QjSkTT2VowKXwiZLplg7Na7V7kV4LnzxtdZGC0QWTnLMjkAI6o2Oty+5P?=
 =?iso-8859-1?Q?WtRJyj0J8fxguTSLUDPUQc/YQxmW/yXCHuMXJPOIukzezgo/ESLroSqDMI?=
 =?iso-8859-1?Q?cWe8ADsMgNjlBYynrqBTEzRhvBC4XxEjF+Nc1Ykuw8a6Wb11ofsb4te6B1?=
 =?iso-8859-1?Q?JxB5zOWslpBwuDVrnPJgl4MVKKNiNHoU+tRFnFOuQfZxjsTG6GO8LjVXNb?=
 =?iso-8859-1?Q?ceM6xa28W3EC6KX/LtaIuVLtXs9dnHrL4X+mta897Eq9VxEn323B2PdaSs?=
 =?iso-8859-1?Q?4jUoGyr1gQb5OpvFNmOZwtR/Qmm4qteAycEnCFDiCMUrbG56KQGRW0jA5k?=
 =?iso-8859-1?Q?zvWAcugIHdvD7/dM+7BXrvLUsc56LVeDBwUpuZNDLXCxTBiqlosjCO5kF1?=
 =?iso-8859-1?Q?gXzF7UQjUwEzzIJURyjPAqcN5wJAu0eeb4wzZDy0W0+oq8MJbGex4xm14P?=
 =?iso-8859-1?Q?/hrP2m5T+Ewr6qgTa6vL4SXPp42ylH9Zd69m2R21XtHyrXk3b4U703PMcC?=
 =?iso-8859-1?Q?CiNOD8RhdV1dSszbqxuwQL865Iez3DUbLE3QjEGixglF8d1/VUo6SQV98W?=
 =?iso-8859-1?Q?AkIdUYBptXQ5esssCjsE6/2PaXwl3fuPDEl3YjH/x87kkPWVvRezfyBvlF?=
 =?iso-8859-1?Q?dnaDi7ER4GGUWk31MAnHLfHuN5KyCWiYlNrPv8W7EvwdFRG6MKUsAyF38k?=
 =?iso-8859-1?Q?3IaG02xqIIYdlDTu90/1QaBWqoDq/koI0kg2iwWdtkA4wbEvDz0D4wG6zg?=
 =?iso-8859-1?Q?vOiU0RMS6iqfDX3dXEJU6fJ/zVIYoqmTtUdeeQkD5HKAAMBI/9bMix5XV5?=
 =?iso-8859-1?Q?WoYF3ulbF78h19iJ3tVGIo13e9M1N5mqFktAv4ZyZFLzs9n33e/drqbfBR?=
 =?iso-8859-1?Q?b0NYn8WoTuTu/jaRS010NN2SWJDUL0KhmSEUUeAUARGHy50PHJR8FL1/ql?=
 =?iso-8859-1?Q?cMMv69tOguU4mI9bMX+YlI+ZgtuyHbCg7da5Yiy/W1E4FpkfLcsg79RyNS?=
 =?iso-8859-1?Q?rHxxQPen+ntntDwHIuD7oNqce3IlwqZJ1+p2ScZ+SGV4Qevi8C5vQONoCo?=
 =?iso-8859-1?Q?MmZ9CdwTk559qx0FamWmjC0WGGjPELiOQ8V044qdeg+n0Qt/LzMIkZZQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb57efc9-261d-4eda-2f3b-08dd55b7b986
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:16:13.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSqv1G6NHq4uNs561HelHWVg0+dG0TqvyrK2lBUO6NNNKmhc6Y+Y5ZAzeR7TC201EiTrMrIF96rp1IMKKYNb7FOYUpyYeQKqzWGh+EzQ1HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com

On Tue, Feb 25, 2025 at 08:26:17PM +0800, Hou Tao wrote:
> Hi,
>
> On 2/25/2025 3:13 PM, Martin KaFai Lau wrote:
> > On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
> >> This patch fixes an endless loop condition that can occur in
> >> bpf_for_each_hash_elem, causing the core to softlock. My
> >> understanding is
> >> that a combination of RCU list deletion and insertion introduces the new
> >> element after the iteration cursor and that there is a chance that an
> >> RCU
> >
> > new element is added to the head of the bucket, so the first thought
> > is it should not extend the list beyond the current iteration point...
> >
> >> reader may in fact use this new element in iteration. The patch uses a
> >> _safe variant of the macro which gets the next element to iterate before
> >> executing the loop body for the current element. The following simple
> >> BPF
> >> program can be used to reproduce the issue:
> >>
> >>      #include "vmlinux.h"
> >>      #include <bpf/bpf_helpers.h>
> >>      #include <bpf/bpf_tracing.h>
> >>
> >>      #define N (64)
> >>
> >>      struct {
> >>          __uint(type,        BPF_MAP_TYPE_HASH);
> >>          __uint(max_entries, N);
> >>          __type(key,         __u64);
> >>          __type(value,       __u64);
> >>      } map SEC(".maps");
> >>
> >>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value,
> >> void *arg) {
> >>          bpf_map_delete_elem(map, key);
> >>          bpf_map_update_elem(map, &key, &val, 0);
> >
> > I suspect what happened in this reproducer is,
> > there is a bucket with more than one elem(s) and the deleted elem gets
> > immediately added back to the bucket->head.
> > Something like this, '[ ]' as the current elem.
> >
> > 1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
> >                                   delete_elem:  elem_2
> >                                   update_elem: [elem_1] ->  elem_2
> > 2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
> >                                   delete_elem:  elem_1
> >                                   update_elem: [elem_2] -> elem_1
> > 3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
> >                   loop.......
> >
>
> Yes. The above procedure is exactly the test case tries to do (except
> the &key and &val typos).

Yes, apologies for the typos I must have introduced when minifying the
example. Should just use key and val sans the &.

>
> > don't think "_safe" covers all cases though. "_safe" may solve this
> > particular reproducer which is shooting itself in the foot by deleting
> > and adding itself when iterating a bucket.
>
> Yes, if the bpf prog could delete and re-add the saved next entry, there
> will be dead loop as well. It seems __htab_map_lookup_elem() may suffer
> from the same problem just as bpf_for_each_hash_elem(). The problem is
> mainly due to the immediate reuse of deleted element. Maybe we need to
> add a seqlock to the htab_elem and retry the traversal if the seqlock is
> not stable.
> >
> > [ btw, I don't think the test code can work as is. At least the "&key"
> > arg of the bpf_map_update_elem looks wrong. ]
> >
> >>          return 0;
> >>      }
> >>
> >>      SEC("uprobe//proc/self/exe:test")
> >>      int BPF_PROG(test) {
> >>          __u64 i;
> >>
> >>          bpf_for(i, 0, N) {
> >>              bpf_map_update_elem(&map, &i, &i, 0);
> >>          }
> >>
> >>          bpf_for_each_map_elem(&map, cb, NULL, 0);
> >>
> >>          return 0;
> >>      }
> >>
> >>      char LICENSE[] SEC("license") = "GPL";
> >>
> >> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> >>
> >> ---
> >>   kernel/bpf/hashtab.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 4a9eeb7aef85..43574b0495c3 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct
> >> bpf_map *map, bpf_callback_t callback_
> >>           b = &htab->buckets[i];
> >>           rcu_read_lock();
> >>           head = &b->head;
> >> -        hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
> >> +        hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
> >>               key = elem->key;
> >>               if (is_percpu) {
> >>                   /* current cpu value for percpu map */
> >> --
> >> 2.48.1
> >>
> >
> >
> > .
>

