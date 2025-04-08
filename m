Return-Path: <bpf+bounces-55477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE757A81316
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2242A1BA01F5
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCC230264;
	Tue,  8 Apr 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ+oxENj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DEB676
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131469; cv=fail; b=mS7Una3XkxMXsm8CukfVidiHXDPYux2j/3zlX9B/lGZRlHS7g+ZXWoHvPgGXXLS0y99mE4gfoepI7L2LvFJLMSzyaqL6cZKr4IbDrGgaKlnnld4puL4rcaXr5xfqlpvLA9aEVXZDdIk5GlqAVOLv1NfouZhszcshaiKwQJtq9vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131469; c=relaxed/simple;
	bh=XbF5iivt/i59kPNRNUBpgx10d3CepH8FRN1QU48a8Ng=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=k+37MarH2bjZ1GR6QTVxCc4TcNAbDAiYmtaJnv6ooNdLruw1D6yG1BXFtvG0MNIXVexP2psNaR8PC3dJixUF2OOdcK/2DfE5uFDC+jnG3fm4SWcE3pnIQhptMW0LXyax7xq3W5HbRsIYq5fHIbYqADnFlrQiv6J3mI+88pbTkdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ+oxENj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744131468; x=1775667468;
  h=date:from:to:subject:message-id:mime-version;
  bh=XbF5iivt/i59kPNRNUBpgx10d3CepH8FRN1QU48a8Ng=;
  b=OQ+oxENjVLmdCcSgklxSz/xeAZs+aXrXK30ZxLnRoxeSAPCUgCBV9iJH
   Mfw375I7XVEQR0UNHKDr6jisWKjv77gfq6LPgAKrZxzhnWNLqUNl+YVfd
   QCGSyDSCpdQv6Cw7Ws7pVavMyyNHQdDwDqL6qANXMC4G8ve8iysia1dKH
   /YdGs6NeoVQ7PNt5YYX0bBUJhofujw2vob5kbUK8BHc0NQkgeM/94QgO2
   YjcHLbgeecK2mdC6Ys/2wFYf8BXPLae1AXZSFe5RV621Q4FHdlJgxhTSS
   G1/z3Vj3mhMyO/fKHGWzaSzZN1TbexjCG9M2tSK+458NAql8P2grTCLD+
   g==;
X-CSE-ConnectionGUID: V0Xu1MCMT0C+B9zizdwoUQ==
X-CSE-MsgGUID: AVk0i7yrRhOtjvbTE7CJsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45698334"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45698334"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:57:47 -0700
X-CSE-ConnectionGUID: D7ui698hQ+WDImgFlCKuRA==
X-CSE-MsgGUID: VlECTXSWSyWqdGZ3B5wRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133043310"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:57:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 09:57:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:57:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHcoSopNGj6lnpbKiB6fNQIQ8TxUpeJgJGa1klcUpwVXIKQcpbELHBzZt80gh1cBxgyGmQe9dYptwi+6MQWbM3jUAgpyVQZUO/xuE4RYbCDS2x4YwkItHWIkKp8N8B8OYAXp56UxWtqcudquHuzfHh9sBfGfCCoaqzaN/vV3yv1GOXF6wWYEbLUp0BG4eRFoGm0gmu/8UXhLT9GbPZyWMRkigZ0PNafiyJdgPHmLP+EL3NvGPNpetmncipJCUH8C5jVc/epWiMZHguLRkX5jN1y/2NaAbIxZSZVa6UnreFvEfxMoPDM1CeIOHI67Ws3+VbtXYwptGFKzTF2bTw1NyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tQeqTD6zfnjW04T2kS6KvdWaF1v3q4loOiAMjeQ9Oc=;
 b=pSpJZXh4MiixDvue5S6Nu+kZc4a4r5R5cTEjMexusSWpTvMTlWSn93+hWSHszbvC60hRmtJbZTORLJ7ajFYbFsi55mEQfaHuZwJQt8If1HDbhRNslE9cyP+M+NZuTSOrr5rnRrntGFEOU/1cOyTdLDAKdh37aceTkz6x7xVq+XAAfFm0ce369/U0r+VJTkhNJuTF2slnsCaEnDbtCkFjOUQDuUCpINLJmaeDXbXRMzsLmQcluynIl7ntqVAJ37DcEZzd64y11O3MIUhuddHdaybwbSRN4q9zmWeoX82pZkL+tiAdl+ElO4b1V1tcmXSNj2dt1Rz6F3F5QQXWiG3NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by CY5PR11MB6114.namprd11.prod.outlook.com (2603:10b6:930:2d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 16:57:44 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%6]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 16:57:44 +0000
Date: Tue, 8 Apr 2025 12:57:41 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
Subject: [PATCH v3] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z_VVhVfEIxNasewR@bkammerd-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BN0PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:408:ec::25) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|CY5PR11MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: cb891b41-160b-48ac-5d40-08dd76be7afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3apKzUI18LaeFNXFL2lzBzvOslrzgIY/9vFY+sS0YJlaAX/0Fciiaoh5/UHl?=
 =?us-ascii?Q?EmyVpMjoD8oX/DjL38HZ9UvAjoZ7IQdtysUu+pV8Hsac+uA6R06Eq6K6IDtU?=
 =?us-ascii?Q?w0e0bDQHOcf7a+LcRtE7AjriO+bCJCavpasMCuZahpnkx+JSQdCQmyFX6cQa?=
 =?us-ascii?Q?Dk6cm2xCQV7kbWSi36nlCTWIV+hO0RXzQW5VEiVZ0TNqTXxweGlSNIPYZ9ly?=
 =?us-ascii?Q?/2lOnMY/DxomTeEsC333mwzpJFcb5SImL4cxPnH/HhtrIxlN+g1jhYy0Xfyb?=
 =?us-ascii?Q?top73GR8tRdowAT2x2AhupoBDXvLqF1dR+KQG83q6XN2FsR688tqKhKsaosx?=
 =?us-ascii?Q?LibI5k7nvSyuY2y4KaPkapgU1wWWgIaYkUBWpMNM7bxVjS5skv3zQMr4PkEk?=
 =?us-ascii?Q?RCqPHfA7H5by+cvXu1X40dwJVsfLKSZZRP4kGzpsGzFvK5sdRroOAvpVS6EF?=
 =?us-ascii?Q?ssSWw1wGxvM8jtcaIMKJwbymeSgEShszh2L+sWcZarEXm0n4KnjtVfdkHhvT?=
 =?us-ascii?Q?l03BvcwKjlLCzACOT+Yyu9oa1VfjlxclEljDJaVJnprSJMSTDBN0KWOCWhF3?=
 =?us-ascii?Q?SxubdJlFKeACpRDa57q8RaRN+VqT/F3/kDfUgF1rfr/Ih4HfPh/Gqo4VCOt9?=
 =?us-ascii?Q?cqgq4A/Q/xbP4vLl0Fp88sfvMW3ciKuW7CQWMgZ+mL6N4TNXNSh+Ex+/spfb?=
 =?us-ascii?Q?xrW1FL23sZfbvoy8MpdF2IGVjQqX00bvAL0IuVDpuBmQWXnle9kCQfO3WTeg?=
 =?us-ascii?Q?dLLFoliywrVc6qEpf7knD+djV/Vkbt0IRLcmb3Rqx1stqHKrwD4qwThbmPRL?=
 =?us-ascii?Q?dj490O9l232I1FpaypklcdYP1SrM8JgWbWT2BgcpNCStcmD71PvjQi0t6oY5?=
 =?us-ascii?Q?Z6sydzmRR/WX55Qo56SQOsU5fEo1bIHlA2+qUx4pr8JKvyJGIBJTXNhhxQgo?=
 =?us-ascii?Q?yHgBJRw4c/NDmU2ZfpjMpXYMMeLfCY7dFpb3UxTLClJbLh7sFUoCbNOHsvcm?=
 =?us-ascii?Q?v9R541PEYye8vnNyu12yVNcs9mkvAjp7OaeovxcVIW8d7RacQgUdkyKG7AJR?=
 =?us-ascii?Q?H1pFrrYotoMX8S1C9GCQ0AYidaOFkFF3YGtNviAl3mnBybXyT8nNVPzytgED?=
 =?us-ascii?Q?fKb/p6ff0XzcaEdpuwkt3JzLH1qhPXd1NPV6fNM/4I9+GMuekwONSUs1uVAU?=
 =?us-ascii?Q?mAq8d4WSrGJVA3rFGezn+5uq/QSJ2/bGHUbudTLPmdXYxKOzuTfqr5EEV18o?=
 =?us-ascii?Q?OiPrpQE8i/sxqzCEu8AqQUGkbxS5VJo1CCuufTrhW0ZiGtxvGRoQltCpnelz?=
 =?us-ascii?Q?7kCf71Ea0calEEMlQZV/WYIv0IOgHtSuEbb/F8rSsWWZmSmzolRJTX/Z0b98?=
 =?us-ascii?Q?+b/IsW+AwYJU9t8wfmVwLXcbzutffE/qXoAwpCb33hg3dF0FvZHOE5tj4H71?=
 =?us-ascii?Q?1SrMUUKBB30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Dr/7XPPE6ExJUsXXN5ls2HIwOunhXBpx7Bb5+wGeKHauxmUYCpmVdo72aT/?=
 =?us-ascii?Q?a3oJzP0sdU+kJ6sJ78sz4jp3logHiDSgu6CWDeF8ZNQNmQd1YQMSeQCjEqAO?=
 =?us-ascii?Q?IGr9+BUBSAQEhHSdE0TdP2zJQztc3qao9oFzmx1C8b1N1H9EPrgB8/VbQrfv?=
 =?us-ascii?Q?p2jVq05LTBLGXOAF/IEt/9RSt4OZISgQgErTuNXCqzGbSwgOJ+mC9OZxoIV1?=
 =?us-ascii?Q?N5VrASo3Nrk7TU9SF2Du/1OhsWNZrXGEdNFXAgrSRBll+urvRkGehSx3VBrG?=
 =?us-ascii?Q?UCqbcO9c0+HCg7++js4Y0Bh0qyI/KUd3qFCzqAsRh63Lq5yX5vQa4MIQKfUv?=
 =?us-ascii?Q?C16C++A501vdwir+WBGNKWCLcTKJ0tQw5h3/p5oeXowjTgdZm4Nt4iEBX4Ch?=
 =?us-ascii?Q?I91Smy+L5Hbc9nU+WIKFAXhsUy/tkKrh4d+SmlaWXrq98Kx6hINQ8S5SVpPr?=
 =?us-ascii?Q?mdr51lIpj4N/vHBSrDzz5W2InxoxP3875y6GErQMmKRIdccfYLJk1zVVfMcY?=
 =?us-ascii?Q?3bRnSfPaQ+2DqRyATbWE3dxDQ+zSJV0g5vET61PZUQqty0iSWeKdunlDvcTT?=
 =?us-ascii?Q?pR8yE5KoKoWY8h0SFJ7X00L5IuvTWn5i2bnt41CajGNx9KbQ/FCCrVXYDYyv?=
 =?us-ascii?Q?2y7q236Rc5PZ4tpDZE4geLVlEcT/CqOPmflUmzLhj7PLM/XbqvONrPsaKRsd?=
 =?us-ascii?Q?ulbtbMpq0ypbeXJpgYSXICgWNEC4J4xEnLgzhgPIZqqbGMGP6XqUiPYvoqNr?=
 =?us-ascii?Q?QM8msdXdNYppMf3eNdEkOMrA2kF6s/GoVMUDkdIDVodQ2yibqth3+3vG+rSk?=
 =?us-ascii?Q?vEf+iVlaD4DGcSbyfLRzNTZM4vABDKL+3xAF5PD00vobExwZFgp4Qn8WMEq/?=
 =?us-ascii?Q?eTCyEXspAE1nN0ErXf+qXs+XDdUarVvmnrtpErr3rYoYACqlyoTQDIWq9CrL?=
 =?us-ascii?Q?FgBGVKD7nyJIV45bv2xCh5rpBHTdTlfVkabiRMcwN7dW+xf3oAoWK9BD8xim?=
 =?us-ascii?Q?CRNtQtVenYvmZGnPmDjzu36MBUukkWCpNdGd4+Iy7B2YL1HQq//eCvteNEJ8?=
 =?us-ascii?Q?q1DcZ1mIapvgjRHRu7VzCoKQI6rv3Cc5JPc4wLOP8osbC9D2xT+rpJjM+SsB?=
 =?us-ascii?Q?gEVjiLo5kAAdwua7vyZfGUsrz33UeoqHqRAiVWU0kqi95ZMBPbw+VgJOvctV?=
 =?us-ascii?Q?dQ+Ep2A+HnORBWt5WQ8nRUo0sYtp78qd30UicWtI4MUoS2s41X6OLvFmXrFO?=
 =?us-ascii?Q?bWltX6anJL+6o/h+ltHBuUkaS15CLVTpDXIBCFHVgVaeOvxTLNriP/JG+zpi?=
 =?us-ascii?Q?dUfjLdNNd4Yv/4xu+4SlxwGdFmz2nRqsa+xISz8Mcfm0QXYRHaVcrBqV4VCC?=
 =?us-ascii?Q?r6rcVsl9p0784LU/VHS61uBn2ztouPbSPELr2bB9TBA7mXfHYBpAXZw540XM?=
 =?us-ascii?Q?X7A/603sBL5n3gj+jqXATMrTTXawJr1PNLvJ4XfzhPXO3l+elNxEGMkgldGl?=
 =?us-ascii?Q?70KeCUApp2Np7XcZJ7j3RYAvRsHT85xYUDp0hKPrhmZFUAPEH7cZViGgBtfR?=
 =?us-ascii?Q?GH1FxZspWTtZ+KbxVrWmixk8GnHPuEEMZa9xNb9fP7OtKSEbOWrm0nifi3nU?=
 =?us-ascii?Q?6XCY6XNrDaznQIaJwyi53wA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb891b41-160b-48ac-5d40-08dd76be7afe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:57:43.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLXnXe6ImbLeoAACSSaqNasNtUp/xuPTTj8Wsu+5jMTkEnWs0fN4tMCrdTbmbIZKuc96UTOGjUl5v5i1UkLUA1mb+8Kfw34kbvWzI1BaAFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6114
X-OriginatorOrg: intel.com

This patch fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element. The following simple BPF
program can be used to reproduce the issue (v1 typos fixed):

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>

    #define N (64)

    struct {
        __uint(type,        BPF_MAP_TYPE_HASH);
        __uint(max_entries, N);
        __type(key,         __u64);
        __type(value,       __u64);
    } map SEC(".maps");

    static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
        bpf_map_delete_elem(map, key);
        bpf_map_update_elem(map, key, value, 0);
        return 0;
    }

    SEC("uprobe//proc/self/exe:test")
    int BPF_PROG(test) {
        __u64 i;

        bpf_for(i, 0, N) {
            bpf_map_update_elem(&map, &i, &i, 0);
        }

        bpf_for_each_map_elem(&map, cb, NULL, 0);

        return 0;
    }

    char LICENSE[] SEC("license") = "GPL";

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..92b606d60020 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
                b = &htab->buckets[i];
                rcu_read_lock();
                head = &b->head;
-               hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
                        key = elem->key;
                        if (is_percpu) {
                                /* current cpu value for percpu map */
--
2.49.0

