Return-Path: <bpf+bounces-37856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ACA95B41B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22006B23FBA
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4E1C9423;
	Thu, 22 Aug 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sjih8Xhx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2B17A584;
	Thu, 22 Aug 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327044; cv=fail; b=iGJAJRLu7Co4U1n88GWJASW7Dn+r1SA+CBHoL3axD158RH88qv2iH3IBHoAe+oec2horhlydqVnb2PA6rqkqxzlSiIQaUFWDj7pysHOJHu/7Od8UIGm7Pbp0YARxcJoBWb2t5gYqoX904noRPmlSpBL7uwkslE4w7Q5E5PLoE9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327044; c=relaxed/simple;
	bh=nRbT8A9Qqw3ozz+psnhtqT/bUwdq6N485W1ix9B4wBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IvDsXi6GR8A7D3ci3dedodbueBLJi6uTmf095a66VAbI035hxiPF5a8f9+3NQj/v+AJfaTQVHemvKyJ9d+ICDJMLd4u56q6F/ZIdCgLg3+8EPLT5oyR65L1eOW4t1roEHYrrS5PUiRFq6KMWaAI5mRwBkGjBtHl17RBKb9oRn+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sjih8Xhx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724327042; x=1755863042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nRbT8A9Qqw3ozz+psnhtqT/bUwdq6N485W1ix9B4wBQ=;
  b=Sjih8XhxONt4fwwfTImW+hRFJvd5Pd08/KZ/1hoCTIdf+qzeY0reQLGi
   FsCYRcTXA3rXhVs8dWiJZUxLq9JpcXQ459Tc1WN4jTfq5N4jpMiExKkA6
   adyOLIBv8YQqPfTPBVVNvd51jxEzVqnc+upNIIP782Myh1IiPXxNzFNJG
   Dn6QIAKY0otioEnHfRUrNQPXMpi6jbbVmLtSVcy6Fsttk4lY3G3QVsx/b
   wyn1iO8Qahc6D3xTN8+lywk3eXLioGb6xPPpwyCx2tuhbxxfUnNScEe09
   TVfIxjYUAlgBOnIwkrM9K1iZTHhFhyJYRRTUt/F4nclt2b0OdVk+/W43G
   g==;
X-CSE-ConnectionGUID: NuyW8XwBQI2PM8oiWkYPAQ==
X-CSE-MsgGUID: ql5dgygJTEek4m+74J7DJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34116776"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="34116776"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:44:01 -0700
X-CSE-ConnectionGUID: Kn5E8byZTpKP/Pv/ldELtw==
X-CSE-MsgGUID: b8HpuHl+SM+ONs3digvPyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="92215109"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 04:44:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:44:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:44:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 04:44:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 04:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn7y6wXwBWC5SMiu+HU8Qt9z14ngIscndps+vcovl4RZvZRJJX3CEhgo6uCeObhyDjyTV9m+zMExlBXGcsPF0a0uRZzHk+xo3wXabBrqLFcXtqaCwwi3XNSKFF2BNsCs+I+pjMsmgfDCGtHhg0IfKm5VmupPuxgll9hNPJigcRwhErDEpHMLH86o2D1gEdXzrHjskSI/7W07asUf3t5/bMro+GCunUf742UPbND4meeQNO9jcJlO/mu8BhGI+6XmJ9rj+D5eQ+UsYzVZaE8LungRNdOLDn6uA3SKAv1+yCzsmIH2xPtTEcG6/8stCpuO2pkMUgeM0TByhRH1DV13yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei2WDf/qAwT35UT9Th0SMO9eSv6LmKclmEgfg4T14F4=;
 b=kVGUiipUrlKTRw0q7fbquWS3znlrwIkW5Os/DUIUMXyh81iePP6R8Wyb73tuKXIo22/uXSOIpoEeVvNyt76LRqfgkT6CyNxGUkikI26NqP55qNJp9wTDwyQay7h10S6Agq1ypW6M+Cofy9ulytIZrs1EIqBF/cf2qI68C3WFxaCJR4YZrPXEX07QzifAqbgnPZnYZf7JOY3QhtnsWOiTFD2zXRWXFkrwxY128itXQ2NILoBB4NjTvmGWRiwtC2+ZQmn8CSfpP3gNqz5gKzs7k2K6yPMQT+0G+mjqBr18RBZxR0hU2qJeZ4dc692eksJYTYckwq7ZFcFD6+ZBjzy+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Thu, 22 Aug 2024 11:43:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 11:43:58 +0000
Date: Thu, 22 Aug 2024 13:43:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 5/6] ice: remove ICE_CFG_BUSY locking from
 AF_XDP code
Message-ID: <Zsckdsyjwfglf6RX@boxer>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-6-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819100606.15383-6-larysa.zaremba@intel.com>
X-ClientProxiedBy: ZR2P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e721016-d0ec-4dc3-e3a5-08dcc29fb5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OvIkj9smZRt+FJAj2cuORImZcy00D5HDeJ/+1qnSar0YZIx0NzwWI+VWr6Tc?=
 =?us-ascii?Q?yglX3cJHeYqUxlYrjic5KHF4sR2OX+uLZTt71Q/pCBFHEK/2O+OoSWZtcC89?=
 =?us-ascii?Q?z07oLk7C8qo67Jt+w0AhzYlM8ajkXDJODzTRNzTtUlWj1rLi4lYaD1LUJC0i?=
 =?us-ascii?Q?jkLuQ4T3qmE6nb91mw6j8cJ0fQpLM4lhVOpyIrSIB3oe9dFuhXjBQXisf4m8?=
 =?us-ascii?Q?QfgEuDat8ze8FvfNeOtKxQiYS+QDOtNevhayZuXlLZ6pSoW8+Uyp+ExChlFR?=
 =?us-ascii?Q?0luJwdZgEHEFUAaATBl08RcJlFNqIYWAT9deWD2NBEs5o4jJEYka1C3UZmV0?=
 =?us-ascii?Q?npTVo85nkF7vK5JhMPBqVjR2u7CxSbO9/9gdFjjUf+VDrwu9zrBN2wTrazMc?=
 =?us-ascii?Q?hDtBnUL07zajJHB/E7YWvuFU00wMMVUxv6C7wvehZK0j4r8ELwkCNkS5PDef?=
 =?us-ascii?Q?e+RviPxiKSSPICmT4OaczUKo+U/aQ7DLcrQniPCfqxoqYI1NOw2uSTpr1B6e?=
 =?us-ascii?Q?eSWMbDC8cL9etiEdU0KSCyzduRmxWavbDHj9OPvIZkNIc39vUcxaNlhiL7de?=
 =?us-ascii?Q?+Oc9+47WfUEQ7QgeHQRaAZQmEmsYIYGYxcKbjIMFqUS6WQz+mV5Ty8pfmgME?=
 =?us-ascii?Q?VL+rxwpezZDKaHV1FQh1DOrE+j1+tQ3ywBkAhcyNmMKRAnutW9tZlUTQnlF9?=
 =?us-ascii?Q?VTCncWMXKraQmWijc+k/A3ULlJDMtOAhZTvMANCTQVIDB8nQSQREB6cNbES2?=
 =?us-ascii?Q?NuNmZOIwYW3HkbH3jxDFeGVyTpcX6XJdovLSDqNudMAHrVlJvcpGL9neylKZ?=
 =?us-ascii?Q?sdS3VVgtvgTGWCJ/lgrAyIghp3hXHPQJmGoRFufiS4Bp+7ryE7QBfvj+r42v?=
 =?us-ascii?Q?dRmPx4Qd2YwrbDLZGp+dqCP4xgC2lA5yPTnRBqjqfjNpk2sOV5wFbmuAyHWJ?=
 =?us-ascii?Q?CSJefsmro5lktYU3b6IdEQuiCOADXmx3iyaDfds9Q5PpAzken3B3wqAXAgug?=
 =?us-ascii?Q?7E3kWay3iICxpea8ErBy9ZLKUteo/XEaulKXmCSVoqNbtfgB7UVv/i5n2gOO?=
 =?us-ascii?Q?yVVbBlhUJKZclT6d2h7Up5JNEg6PBdbd7pmqC2NXjcYTW2loQJQOh66YYJEX?=
 =?us-ascii?Q?mJl8ive4ddZM+RdNwH5dpacHP8Y8Tm5cyi5/Xl7zQC7Zo8qbYbR9zTVRZ0Pw?=
 =?us-ascii?Q?lTDMLkMmBpfRferPOOVw97A7Hrp3/IlKCvODPyER1tHxekjP7uHUHfZJ8/na?=
 =?us-ascii?Q?bYvCB5YgfSXlK6AYt/wWnPXfiRvdUCun5QE1y/skkQSLFHnxczADstwIG9Y3?=
 =?us-ascii?Q?eAkhZIuyvk5A8cYeKpeLpZSxFzGkBpWypTQtv2kD1MlaQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GIkNi5vVA4dLTm9F08tRA0uaa+rv3u+w2zmCluVtD7d6qmSpfjbDQZ3F3L9V?=
 =?us-ascii?Q?zRU3Ji9Gf+gTGEIqDI/oRZkp724gPxs+oAcdea840XY8ZhdEJeX8fx37+Xxe?=
 =?us-ascii?Q?H0o+IvnAb4NhsLNu8sL0oRq4qHOoaAujP8U/K4H/VwCSxmP9OlypCwgu9i0K?=
 =?us-ascii?Q?JkgrIuZwKPaB0Roi/+YOOtiL3Xd/GEKdal36VHKCHYPCxDo7sUf99lvr4nD0?=
 =?us-ascii?Q?WiC+UsZJM17cfpwHWAinVaZAx+M2mrG1KNSMSbkrl5I36UXCx0j3CAb+06me?=
 =?us-ascii?Q?GZbabkAOLCC9Brgt4jE/p1WiqKDq36ZWQEpeU2dM525h0ODpJUnVnxaURr60?=
 =?us-ascii?Q?ENKRoMLGgmofMfjOY1+jWyJxx2kjjvs0u6zhZMyz2mGuvRadotT4BoLK9HjY?=
 =?us-ascii?Q?UIEi6LyMw73YGrZ9rbGOKYRqiopVtbCLOfPDHDHX0OkLH24byPmYxJDhU9d2?=
 =?us-ascii?Q?VHKAPX/faDGyfbcbvlPQXVvRIbKDSL4oqwerWieyMNUgf9uQ4XjnqbclHE2q?=
 =?us-ascii?Q?rf12mDwGWnukosBxM3OiWFNPxz361AEMpbMnkurK/w9eYfGTBem1mOTqvP9X?=
 =?us-ascii?Q?GvJOd295zQNVU42Xw5Q3z9cfDstXp1KvlWvTvDzVi63GwrjvKLIekdWWaVo7?=
 =?us-ascii?Q?8isZCeHJFATEXJyxXvTnlqxtl1ccVX6TmNYW3D62sPkU5zT9UIppQFMLvCpc?=
 =?us-ascii?Q?gHNkImfQHiznIQC+YI8q6HEAtOPU/1sLhhItn3zFTxWEFUNNWGhOsnCmTLbY?=
 =?us-ascii?Q?OHrvN/eVZUjCptLr65ckb3ZT5ceHECQvzlXIRv2lYEF9G0ATzAKIH1hcSpQW?=
 =?us-ascii?Q?73VivkxRjlRe2eJIXmx0JzqGeYtmZfd4msHp4sWEXAgJb/OHO35Vyj6xzjFl?=
 =?us-ascii?Q?YShJyIERSxHIUqMIVjKEtHNPmFToz6so0CVoI3DRdNoz0ExXtQGgmCZ6B9JO?=
 =?us-ascii?Q?WWk7QnfDHaip1oRAd6dvH67ORaivuM9xsqUIwJblgACjk1IoBf5EpeRsJIqc?=
 =?us-ascii?Q?fAAv07qIVM/GdkM5KX6Jfv4WkVSUtWzt5OzWptYMjVGUHjckjelbPKWiIwXT?=
 =?us-ascii?Q?FLAGHqtMDOoEUZIHLSACxzJ56PdtcLNf1ok/NFxx5uw6xlKnZs7akbkkEnu1?=
 =?us-ascii?Q?kiZN/JAtm7hE1uAIvgPB2hMUCKsIh1ew8QykkrmG6QjwDG3kLrAJ44CV1PCz?=
 =?us-ascii?Q?Esq4S9JBYsKxkyigfDp24gRGEdBcrTlrPfq4+V2F3u4l7sQ1pNefqkS45yLH?=
 =?us-ascii?Q?b/XuksoEvtvcJda2nzY7GunmNpObQMmWkDrJgl6VSx5bSJ3G1EZx3/5pAsVC?=
 =?us-ascii?Q?8lwsOUkfD7Ws56JjpC7bWh2L4sAfUz3WmohZ/w6lHoKC+uTPxF5EJButXkm3?=
 =?us-ascii?Q?/1N6CdxCG0BmQTfxivvgXKnUEJ6AWYXyBk3W0EcjkR5dsjq9rhqxzHCDIWw7?=
 =?us-ascii?Q?rCNuHXM7zfl/J8pMf4vxOUpb/QutHCRJCPiOEmTo3kZ0KpTR+WuD6XPVLh4o?=
 =?us-ascii?Q?DsZASR3KpIGZxzB0/+T00Ed/ELcZmzPmketUO8AGIAtNVMatXciboRd33bPV?=
 =?us-ascii?Q?OJpp55xYaak9FlM2qO5oEEpBCcu083zT8IoyVjCPEVbnO88Ooc81WNq94X1z?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e721016-d0ec-4dc3-e3a5-08dcc29fb5b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:43:58.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTUpNGArWAEj5s4KlyMK4wP7ZSd47qq0lrgIlopQcRXGnR88843Bv5nRtmb6Pvu3oGih2Y3Dy8jgJYIlR4f5KMuLcI9f7kFlrWhJWj95xLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 12:05:42PM +0200, Larysa Zaremba wrote:
> Locking used in ice_qp_ena() and ice_qp_dis() does pretty much nothing,
> because ICE_CFG_BUSY is a state flag that is supposed to be set in a PF
> state, not VSI one. Therefore it does not protect the queue pair from
> e.g. reset.
> 
> Despite being useless, it still can deadlock the unfortunate functions that
> have fell into the same ICE_CFG_BUSY-VSI trap. This happens if ice_qp_ena
> returns an error.

I believe the last sentence is not valid after our recent fixes around xsk
and tx timeouts.

> 
> Remove ICE_CFG_BUSY locking from ice_qp_dis() and ice_qp_ena().
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 8693509efbe7..5dee829bfc47 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -165,7 +165,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	struct ice_q_vector *q_vector;
>  	struct ice_tx_ring *tx_ring;
>  	struct ice_rx_ring *rx_ring;
> -	int timeout = 50;
>  	int fail = 0;
>  	int err;
>  
> @@ -176,13 +175,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
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
>  	synchronize_net();
>  	netif_carrier_off(vsi->netdev);
>  	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> @@ -261,7 +253,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
>  		netif_carrier_on(vsi->netdev);
>  	}
> -	clear_bit(ICE_CFG_BUSY, vsi->state);
>  
>  	return fail;
>  }
> -- 
> 2.43.0
> 

