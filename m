Return-Path: <bpf+bounces-42419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74209A3EB0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441E21F24A31
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9398C42AA3;
	Fri, 18 Oct 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esY8MAuP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBE168BD;
	Fri, 18 Oct 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255717; cv=fail; b=rzLzTusCreYFxVtRIChyv7euLpFvFnxcPrnMZZP9AcwQP8OVEzaVTXQ4rKz8RR6u4p1FjfB9iWROGo7/RT7g8eHvOzOoPns7D751O+aQg/oHTMgaxogYWSa7JS22D1Q/o21YzIeiXyFSy+4pO77AHXXkOEBHpAvpaEYCrSu6obQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255717; c=relaxed/simple;
	bh=MYPUsikWj7/RbrCXioY67PI1k4bEV6VgHqjPIqaPI74=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gF4O8k+qNIuR9uxrexDRnOVFR++s3NFZ2t26v+4gtXWPK6Antqy4+c6aY3A6sydafJdEbYjrREMF7WLAoq8dK2n/oazTqrlpj59muidHFuJ0IBEIYcdtcpZ/TESEQEEwOZIdr2ZcsXo+KI9dm9bV1VDEv3aaqqrlUds0o6OlaIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esY8MAuP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729255715; x=1760791715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MYPUsikWj7/RbrCXioY67PI1k4bEV6VgHqjPIqaPI74=;
  b=esY8MAuP7RpBn595Iw1XoVmaTwEJ4I36D+l7Eu5YR3wcQMavLRJwUMd1
   ZdkpTgu+lNMDlXXLlH/n6lvK3Ps6FoRsp6igOcKjqaemD+uYmTJSZVHKt
   gSZpuYAP+jqwhJap/z8QU3kZawad6v1VOFg7jhQ57ThgAJwT3JWrFKSct
   gY9L4OZYLYjiiEYGOcfP7CNFWRDHB0xMdWwcFvudQDMWPobyPmOWK7x55
   G5axo6RUnrPWDay5Ix2Zp0ms5fBzIf2fCFVyC5I+Vuzm7VgzTrP5E1O+7
   gi/57jGMlPim3PI96wy+XAouRU2r+xMKm4TWwgbLCEOR3B03t6W4o1szK
   w==;
X-CSE-ConnectionGUID: rWf+gH5mS3qQCE1maI27dw==
X-CSE-MsgGUID: 81JejMRhQBO97yKA4MRzTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28943114"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28943114"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:48:34 -0700
X-CSE-ConnectionGUID: Wefmje0iQpuhZbac3C1CCQ==
X-CSE-MsgGUID: Bp6bYPdhShmE4Rzu+pvxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109682179"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 05:48:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:48:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:48:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 05:48:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 05:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9ZAZZMY+EdnAUEYaTnWUFSI6Pgy1W9E1cZyRzlfsTg8TMuK1Wk6OX6fVeNJPCJe9SgNqfYqRGLG0rWxwianPbJLCISzg4eHMYXJFWWhzgfyO7JpNKFmxUeH+XRASMwt8pClIUYp28cuFA7jTfclJgDtNIU/5m9LP921LQ+zxL3QLfDafCDZJZKDNH8BTyONTEVIkMQzVC4MrAeJyvSocKVa+5gIDi/KKD8yuhQ6Kk9lRddFr7ygpSJpJrz1XpySvlTvTdQv+NOHz19+6T14wRu8+bdlS7labnGKbuycUo2sg+qYDl84XszDH0DQ4DmTJh6fsxavagcYF9cqloLojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r39drF1Q0hr6MZpS2R/QsIMtA7DSHih13E9hu9Ct78=;
 b=p3ZBEtC2io2iW5qHGmvZRe1CbNDMa3hsPYS5SisFRqQsNU8WncmxB7noDh/S+9PdXOjKt7/28vbFCKP3YudVRIDkoFAZ4x+OVTpppyvL1uvz/HVTULlS8kvKgszOViKZv+aYdXPPpEDgiC8ohJKYCfIZOiJtaEh/OFTr17sSL09RYFEM6jB67NNsfR0s9Qg3R9Sn+ssGsl0sGM3sdwrItNyi7Q7LlAt1miIlCHdUi+4OyZqqTbf7UDBzLDPWDf/g0kno0esx0hMYjpRbllkLBQ3Gpdcp5RxpLdTUq4ShYk41m/pWFd11hXsExWkn0StV20nb1UDVo2/OzOr3/ye4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 12:48:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 12:48:30 +0000
Date: Fri, 18 Oct 2024 14:48:18 +0200
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
Subject: Re: [PATCH net-next v2 15/18] xsk: add generic XSk &xdp_buff -> skb
 conversion
Message-ID: <ZxJZEn43W4y8EwsD@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-16-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-16-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d8a784-2629-471a-d2c1-08dcef732b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WHRdFGy45uOe4Tr/apW0IGZdNKTtQ+eEEbsfnjpZeEYUDp0DRBCXotFsQYz1?=
 =?us-ascii?Q?6iNVjLu0/ww75Qzs4p1pkQ+fdnOajRXf8pkUkUcWVPhmsWEh4WJf0YDlvMFo?=
 =?us-ascii?Q?0HvXDii4+bXT2saed7EGRxX7CjwFpWaTfd9eGdR4F8gos+WwjRuP6M5vC15H?=
 =?us-ascii?Q?oqy7xfwh2/zk2IHGx6qh+H4Qe5Umcf2nCavAVUdtcR8VXEPNLcrNncPCC1zc?=
 =?us-ascii?Q?HD0vj5lN8ruKckXxCc5jpMDvFc7ZFWvlX/jy13Hp8cPg2/33MDolfaZ0t9LX?=
 =?us-ascii?Q?Jezq9sFRZOt7Xt0m3NzqGNoUhkgiaWjeEohXOrgTf1C3FrezamJ1ppHiGWa5?=
 =?us-ascii?Q?3dnNp3dScoLMcWuKfXw8vhOuV54WFafofx5Ee6a58xBI8KVuzVpUY+EkRDzC?=
 =?us-ascii?Q?yO7UAUuYz2UJSfaW4k+I1Skx5zhnp53acbO34UvqxZU2uT/00MBpw6tDRbPr?=
 =?us-ascii?Q?xQzX1F4RrL0B0DBgGc0kE3YT+KiIoUJ1R2b5r0/6rfat7/Z9NJvyPo2Tgcb0?=
 =?us-ascii?Q?WbMVoddEXWf7TDGBKSv+243rD7v/THQWzYXfdjXvCIH8vpcuhL2lFFXXiRsm?=
 =?us-ascii?Q?63ztLH/ZSbPzEYL1GNa3fy8Qq34VD3sx4TL0l8rEFBGDxLN5mkL3eHeEhkU/?=
 =?us-ascii?Q?G+g71Pt9j2XsE2ry7M37vTcdXqpkC7kPM2opSbtBw68SnNDoJqPGIa68LeZ6?=
 =?us-ascii?Q?iY/HBMbkMWnipXDm2nnLUdl5bdJrwR4y6NMOOpYgoSjD9h+/nTxgpgExx0Bd?=
 =?us-ascii?Q?s2I+oLkxLtY61md5PN7mbmiyY957Q3mhnCcXqGY8A3eQVRy0pMXBjjeL2/1n?=
 =?us-ascii?Q?C5yQ2TXveDncDz1yO26C7owjX+KKx/aGpBcteLFW42vrJ5AgWFkJ/X/b3cTw?=
 =?us-ascii?Q?2SeFa6Y8nQeKyMnkaY4B0xWhLtBij8cl+eQw/fYPsQts+aDvK+1YEttGXZgi?=
 =?us-ascii?Q?FZrjFN3BMFQVvm/FRWGGctAlnSrOPwYVM48VE9S6SP1XsjDLN0aUHgaGmwS1?=
 =?us-ascii?Q?SPO2+M570pimj+xBEpFy1/bKlfWvtag+Aqtsr0W+O1KUeQ9Ta/JBm4sPHfZ7?=
 =?us-ascii?Q?5XYgMJI01Yftz2zOGxe4KkJcQU1xEr38qzpW9XfPhtyZr0S+ZNNhh/5X34oG?=
 =?us-ascii?Q?rF+DXwlc9CEd98Xp1gPu20XfiFm+mp76U/U6p7zvCs1nn8BycDmUNbJipj8A?=
 =?us-ascii?Q?h6qWn7E5l/utKJqveKX3FUvPIt+5yuZBXHWZgR0Sm1JQ35ScCaHYDPYWaYFj?=
 =?us-ascii?Q?zNNs1Lwwr0re28XA0UXyXgJ+osXVuIwHkPTG1jSXfepk7eUIjFoyCEoGkO17?=
 =?us-ascii?Q?yMnH2GzIqPPIsvpantM570qI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prv2Mfv2RCAK21DftbEI1vJ+Ih04uGqsFGR5dibSaAR+cm5sXgsKxIoE6ibm?=
 =?us-ascii?Q?tsCiumtDJVrcNj8B4ylwEIiQry4PRqgoD3gBmjFWcT8B4hCSjfDiK6avfEfO?=
 =?us-ascii?Q?q71QNL3b0d4oGiED4WhL00zvXj392qeS7vciNm6e00MCaOD3M4HYR6mexO8P?=
 =?us-ascii?Q?4ctio4LqtmAQIUaKNFu8c0kwz5BboqXXC/NpjT0h5rviPQFRv1vCSM1jmaUd?=
 =?us-ascii?Q?dQFRV9lHZWpbUd9i9a2iBe8/TAp446zMnzpnzHDWjDSXe7tX9mX3s90EzJQp?=
 =?us-ascii?Q?p69YfU/yYwfYl6dDmat+9vp+dUHujd5NxT6mf20pJ5GnNROSDAuii7P0tgt0?=
 =?us-ascii?Q?iursVs1ch998qoha7ZH+EfxQmD1MdKSP8SovVI56j4TJc0GwAa5ZkrlAbr/K?=
 =?us-ascii?Q?28D38GcdIdOMpRnb30yOuMxZ3iTH70OPAFndh3ldnpoNb6eHBkYmAZQoLFxw?=
 =?us-ascii?Q?mjJTM3g55R+nN/EnWYYqWasiVOdjAfMbIGI8aSINiEJcL/C0wKtf/YPPpuNf?=
 =?us-ascii?Q?WsZnldJ9/MfZsi6Mv7AZmH0yAoQHI254DV0cfLWadE66ZOs5FLIqQpWKGA6V?=
 =?us-ascii?Q?O4YuUGGo3W4BNRLsK+eyIIe1sF26EITG6S/Bs5962R5C9yYx4PFHTFV+WULs?=
 =?us-ascii?Q?p7Wf7sjDhWALQRcpfEnUyexp5ooO4l/qcTDZuRLP1iialC8hLWdTxVi9BMNw?=
 =?us-ascii?Q?+S5vaPvk8MBtXizsyzwkRyW85uvuYHsfVp3xAHzviLUYLF1MA5KKcvB3/H4Y?=
 =?us-ascii?Q?ZWl/2FRrZJlWZkVgHHICFIgB+HAIrxOE+pU+WL7XNrisYJdha4Z5+NkoiGQx?=
 =?us-ascii?Q?fQjmdlhtcJYLMca7iwRbE2nYr1otSzoY7mv9z1j6wK9N70EpL/39mvU7o7u1?=
 =?us-ascii?Q?sSM88yse8/Vjm22DHVRTCj/Z1CxskSSG2O/maNcg7gu1RX9PkL3OQTSki6qo?=
 =?us-ascii?Q?wN6F8J1eyaGgTjMzjrdYZzgqUoHV4ilNOgEB//BeIFppR0yPZpKUmuFe+/Xz?=
 =?us-ascii?Q?MtgtwhIUD/RBs2roMWQ9eOqhmawv7e3Zg170gW3hUJRszoRyPjqA3b+6Xowu?=
 =?us-ascii?Q?snYjkvfMrmHz1/gv3iFzoVBJW7Rzr3sC9VNggt3MFsPb00vGQMaooOZKN2Kh?=
 =?us-ascii?Q?twcqk3FlRkz4J4US0vnzP9jvIfbDkBAto0Y6it9azqR1TFnP5KoEGI6iQwZL?=
 =?us-ascii?Q?eF8i+RllsKCeSN2fXLoZwpSU2maO8fd+DMILDCkJaocHCXnLhxFFaaUZPj2l?=
 =?us-ascii?Q?Q/neX4ACgMR2Y7Lx8NoazqNVWdLQoMNodJ56ZA47PjMZyEdgjjN++hBAV5BW?=
 =?us-ascii?Q?RDGUdBcwonxS3k+RVGl+5P7e31gyYpNk7P3dVEvnOQCbF4UVndE4vFJeNDa6?=
 =?us-ascii?Q?zR/OZ6KzhqQIT8gV2FXaQGk109Hv8uX2/Jas+XKpz8uq+QvvobURxsua6YSk?=
 =?us-ascii?Q?scnfhdlMhMWUeFgzuPsusEYHEWn8S3cVByz4opFgHCn4gUf0U4vmpmdATvt9?=
 =?us-ascii?Q?n5VKBhONWibh4JNHJpURiWf5STMZT6tW/w3Wwbui/q4ZjO0UoMS11/kv5b5w?=
 =?us-ascii?Q?kjvWpUDEVyM28mdMuBywRdiLRBBwsXuXhOgXMM3bu7oFEsIbBqZE1ysSvJvb?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d8a784-2629-471a-d2c1-08dcef732b54
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 12:48:30.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eonigm0CL4dOVUBKaLgd4euHp7OxknyN9bPS4UcJwjs6YWHPnQWE8z3wWbsYmAY3cU04iUECSXGbKCtmXYSA4O/ObUY2D3XCybwdKo3In40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:47PM +0200, Alexander Lobakin wrote:
> Same as with converting &xdp_buff to skb on Rx, the code which allocates
> a new skb and copies the XSk frame there is identical across the
> drivers, so make it generic. This includes copying all the frags if they
> are present in the original buff.
> System percpu Page Pools help here a lot: when available, allocate pages
> from there instead of the MM layer. This greatly improves XDP_PASS
> performance on XSk: instead of page_alloc() + page_free(), the net core
> recycles the same pages, so the only overhead left is memcpy()s.
> Note that the passed buff gets freed if the conversion is done w/o any
> error, assuming you don't need this buffer after you convert it to an
> skb.

AFAICT looks good.
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

I have to switch the context now so I'll finish reviewing the remainder of
this set on monday.

 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/xdp.h |   1 +
>  net/core/xdp.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 83e3f4648caa..69728b2d75d5 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -331,6 +331,7 @@ void xdp_warn(const char *msg, const char *func, const int line);
>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>  
>  struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
> +struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					   struct sk_buff *skb,
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 371c26c203b2..116153b88d26 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -22,6 +22,8 @@
>  #include <trace/events/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  
> +#include "dev.h"
> +
>  #define REG_STATE_NEW		0x0
>  #define REG_STATE_REGISTERED	0x1
>  #define REG_STATE_UNREGISTERED	0x2
> @@ -682,6 +684,142 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>  }
>  EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
>  
> +/**
> + * xdp_copy_frags_from_zc - copy the frags from an XSk buff to an skb
> + * @skb: skb to copy frags to
> + * @xdp: XSk &xdp_buff from which the frags will be copied
> + * @pp: &page_pool backing page allocation, if available
> + *
> + * Copy all frags from an XSk &xdp_buff to an skb to pass it up the stack.
> + * Allocate a new page / page frag for each frag, copy it and attach to
> + * the skb.
> + *
> + * Return: true on success, false on page allocation fail.
> + */
> +static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
> +					    const struct xdp_buff *xdp,
> +					    struct page_pool *pp)
> +{
> +	const struct skb_shared_info *xinfo;
> +	struct skb_shared_info *sinfo;
> +	u32 nr_frags, ts;
> +
> +	xinfo = xdp_get_shared_info_from_buff(xdp);
> +	nr_frags = xinfo->nr_frags;
> +	sinfo = skb_shinfo(skb);
> +
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +	ts = 0;
> +#else
> +	ts = xinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
> +#endif
> +
> +	for (u32 i = 0; i < nr_frags; i++) {
> +		u32 len = skb_frag_size(&xinfo->frags[i]);
> +		void *data;
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +		u32 truesize = len;
> +
> +		data = page_pool_dev_alloc_va(pp, &truesize);
> +		ts += truesize;
> +#else
> +		data = napi_alloc_frag(len);
> +#endif
> +		if (unlikely(!data))
> +			return false;
> +
> +		memcpy(data, skb_frag_address(&xinfo->frags[i]),
> +		       LARGEST_ALIGN(len));
> +		__skb_fill_page_desc(skb, sinfo->nr_frags++,
> +				     virt_to_page(data),
> +				     offset_in_page(data), len);
> +	}
> +
> +	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
> +				   ts, false);
> +
> +	return true;
> +}
> +
> +/**
> + * xdp_build_skb_from_zc - create an skb from an XSk &xdp_buff
> + * @xdp: source XSk buff
> + *
> + * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
> + * head, new page for the head, copy the data and initialize the skb fields.
> + * If there are frags, allocate new pages for them and copy.
> + * If Page Pool is available, the function allocates memory from the system
> + * percpu pools to try recycling the pages, otherwise it uses the NAPI page
> + * frag caches.
> + * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
> + * On error, it remains untouched and the caller must take care of this.
> + *
> + * Return: new &sk_buff on success, %NULL on error.
> + */
> +struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
> +{
> +	const struct xdp_rxq_info *rxq = xdp->rxq;
> +	u32 len = xdp->data_end - xdp->data_meta;
> +	struct page_pool *pp;
> +	struct sk_buff *skb;
> +	int metalen;
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +	u32 truesize;
> +	void *data;
> +
> +	pp = this_cpu_read(system_page_pool);
> +	truesize = xdp->frame_sz;
> +
> +	data = page_pool_dev_alloc_va(pp, &truesize);
> +	if (unlikely(!data))
> +		return NULL;
> +
> +	skb = napi_build_skb(data, truesize);
> +	if (unlikely(!skb)) {
> +		page_pool_free_va(pp, data, true);
> +		return NULL;
> +	}
> +
> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +#else /* !CONFIG_PAGE_POOL */
> +	struct napi_struct *napi;
> +
> +	pp = NULL;
> +	napi = napi_by_id(rxq->napi_id);
> +	if (likely(napi))
> +		skb = napi_alloc_skb(napi, len);
> +	else
> +		skb = __netdev_alloc_skb_ip_align(rxq->dev, len,
> +						  GFP_ATOMIC | __GFP_NOWARN);
> +	if (unlikely(!skb))
> +		return NULL;
> +#endif /* !CONFIG_PAGE_POOL */
> +
> +	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
> +
> +	metalen = xdp->data - xdp->data_meta;
> +	if (metalen > 0) {
> +		skb_metadata_set(skb, metalen);
> +		__skb_pull(skb, metalen);
> +	}
> +
> +	skb_record_rx_queue(skb, rxq->queue_index);
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)) &&
> +	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> +		napi_consume_skb(skb, true);
> +		return NULL;
> +	}
> +
> +	xsk_buff_free(xdp);
> +
> +	skb->protocol = eth_type_trans(skb, rxq->dev);
> +
> +	return skb;
> +}
> +EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
> +
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					   struct sk_buff *skb,
>  					   struct net_device *dev)
> -- 
> 2.46.2
> 

