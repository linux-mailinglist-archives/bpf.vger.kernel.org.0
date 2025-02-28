Return-Path: <bpf+bounces-52866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2FA49615
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CCB1895EF3
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27925B66B;
	Fri, 28 Feb 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faGyJFbD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C772566EB;
	Fri, 28 Feb 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736585; cv=fail; b=CQ1/L+Jzmmx4hyG57RrI70VM6l+O42jhveX/EDz9XYbtiTqGDQTRd2tFUk3LqsDLjpy3V08WFMCznAdZ3gkpXElKL7zHK3yvhBdwYNLR08XSmCDCzABr7hDQCcW2ThRTcaH1xm4RbKiTUXpkSMFji2UCDhj2gpyHfQ6QV9KE0to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736585; c=relaxed/simple;
	bh=QViquCHm6Mtw6J6rPTesVyvdzU+juztoNWhmbgXESJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0rGr2g1+xn5OkwwAoGaTVWvsRrCRXmyuHcGJjjtbILJVo+2DxHY9dPOIwxMSqtngI26TSmhsKY8SyV7f1cgHlNQfyNIC4Lkp7ImoA43tG5g1WWbpuSOzAgeQJz1J49r/4D5rcsTA7Mb7ph7eAP5knIRcEZKU8raTXAEK83nWRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faGyJFbD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740736583; x=1772272583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QViquCHm6Mtw6J6rPTesVyvdzU+juztoNWhmbgXESJ8=;
  b=faGyJFbDLQpAhmouvYWxlz6nojM2+e97qNgXvf/mMIPCBTQigD3OG2ad
   nnHRpE7CFf9HYGLaHGE6rCWcfPZkFmV50qKnjYb3KoWzCqt8oesC9xFaP
   R6gdZNDn1tt4huNRTbq8uAcjtXka98RxsKVFfLk49WoVumkTmEuATCE1h
   ptQDhOa7IEQmSThE5U26buNpeuOGE+7MVfncXLT8K4MRbth3RCJzCmaH9
   8toQuH7isUuIa6UeDIwO0dnryDPK6omJ6Jta/L5HrZICiOAEEQZSbr5Yx
   etRVMYtbS86OGQJpRV1+x7wQlolDjD/nvssK4I6bUa7wlHh0WzF+FHD/K
   A==;
X-CSE-ConnectionGUID: wKhBx8fGROGRgV+1puGxDw==
X-CSE-MsgGUID: 2PBg1p8MRm+slXOAIFGx3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45310609"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45310609"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:56:23 -0800
X-CSE-ConnectionGUID: o8sbqIUrSE+RR6OKUVOjTg==
X-CSE-MsgGUID: njzDV/cRROivv4GO4pKVbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="148107166"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:56:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 01:56:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 01:56:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 01:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB/9XaLAAcZ5/IVbwR8qlRwcqSNTkGrSyFDbIzbAmJQlk+i09ehOmMH7npSzMF5iX2GTLkKJNkggWIVa2XUnNy4+ypYOxazAt1nl/gPPSGanLD879WjmNLbkAqJ6LrYpS8sg+xT5acybjmEpx5aD+zZeyrQZtoGopPSM5JupfVF0SSLCKft4UJOEyWCMrfKypMkBRmOdtShNzf3CgPCtYoAtfzxxB+XuT45AIoZNOF3gPDk0UrO+0gfc15Gzi5jHly6Al2qLLO8XldzPT+KiUo2XnVeaD91EfYmT6BYM5yjh5qoOqQUl+nkBEtJr/u+YMlgXAbY7/cSSceQ2m3lyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf8sX6U14C/aoAIqtFqFrkv9vpNUeof7MJKh9DNuI6w=;
 b=um4isaAFXOB/JTlJHin2WJR8Rdm4yC+JH9bTUA1E+5NudszgOkWAt4XfOPSnxrsOXjXlTnjmzViTLbjC01lfNd3SSiSk3ZaI5huoTzoxYxV6+cNteS94eEi8/TQCxjoZ0YyVukGvmVX1jl3T4gpj2D2YwFfX+zbG2nxlgvMRj06u5uJ9ix0j6EO8aVroe8/qm6yigy5Yzre4IUTqKC/Y0YlImmrur29JEE7RW2JzsmNlB+yqE6jYaUsq6Zi9zygRBq2CFstvIfqyZv32lMvNJHgT0UXrNwaZY+00pQ/OZM+JQ8ds/YFGy/A4Ui0j6r0QaHmxeiurw3SJaFcxSU3/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:56:19 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:56:19 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Topic: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Thread-Index: AQHbiSfBClADKJ+qnUOZXYXidi1MJ7NbdpyAgAEBbdA=
Date: Fri, 28 Feb 2025 09:56:19 +0000
Message-ID: <IA1PR11MB6514D321A1123B8C280875018FCC2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250227142737.165268-1-tushar.vyavahare@intel.com>
 <20250227142737.165268-3-tushar.vyavahare@intel.com> <Z8CtO2enntB/lrnp@boxer>
In-Reply-To: <Z8CtO2enntB/lrnp@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|DS0PR11MB6423:EE_
x-ms-office365-filtering-correlation-id: addb84fa-d237-4347-1404-08dd57de262e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Kzp4TpR9tV0TsMYFtPiKn7rhx/SUGK03XuCCRxwGrRpGwIxcpnnI/kilMZwE?=
 =?us-ascii?Q?o5FsX+avklNZgr16TKmOWBV4YXabgUUAioDKHuvPffE08bs1/jUZNa6u1Hdn?=
 =?us-ascii?Q?HngALB6UaGZUuuejoQSjBQL6rgOaZJMYG0UyQnB9ma0gWiZT/Vqdikw7dC4o?=
 =?us-ascii?Q?LCK3rEf4E1dCZLVaVHlO0X4XSMBg3qG5++xpbJsuoC5BQJ3/6EgQrcMTrHFt?=
 =?us-ascii?Q?5goUEbcLRYLa4JhKRb72WkJVD96MWg0ELDIUmGZeV72i9SnoVtYzXfUZZq6H?=
 =?us-ascii?Q?X0/krlV/0Om2p9CRxgfsolHFAX/N03FcKHh5tVon1P9hXCso1NMnSIu70VcZ?=
 =?us-ascii?Q?kLsGhL3wEtgdB4+1g6jRus9FioObAhpf1yR//pEZv/bumqwUpLNZO9ehPL/+?=
 =?us-ascii?Q?wZy07x4hRnDL2sz6GZ038p6Bu/C5pUPs7kdq93Pl30sRgBJm+My3aI5IsgL2?=
 =?us-ascii?Q?A4Dgxfcz7m2IGPzoVmdLX99z88JOAOZuPs/80IuLUd0x6uIotGBsdjjM1Jbq?=
 =?us-ascii?Q?Oay5yTyCVZK7/SiYxhpbNAkGRkec7v5idiMK7dLcvQLDoREhvki8JFEqBu5k?=
 =?us-ascii?Q?xZn1iylqXi8I5fxYHDUlaQ6yrelYSkYKmgE5xxfw3Rje1aCX7lfFRgfEYk+n?=
 =?us-ascii?Q?7EhtyCy2hQMu2hxFZR0TN4yJO9vD7rI5gINWxJqzIDHiH7cY9Ype8xWB8WDZ?=
 =?us-ascii?Q?02Cb/S9vN0Jy7sR+TdhOKhIUi5zq2dGfoD5rmdFoWJGorrA9pG1kiqEiUcXV?=
 =?us-ascii?Q?3fytdAf60KGOeg0gBRtOzboZGtsDhq2Gh9hvWosRShxKwgcfyNYED3Sjc0b+?=
 =?us-ascii?Q?sw5Iyjiao5VUd0wixmPyozsrDqUgoRZcBRzoznAPcwamIVcP8DAtDwSpwIPz?=
 =?us-ascii?Q?uoiNKLKgGQLf9+fyeGIDlYvSRrAsRi1XPnEUe1PjZWWRIPADjVds0xcZg3AW?=
 =?us-ascii?Q?OWnb/eyKQDgCT8Y4ekqirb5nSldkw1DD0R+0CFlMsVHAb5JSqgczFDmKwYWJ?=
 =?us-ascii?Q?9hae7u83ZP/MXTCA9Vg/nO9HfsTy9ud0Ub+TLT6PfV1xsA7lw1VfNlifS5oo?=
 =?us-ascii?Q?b21/njfZJEpZAmWpgFUG0GqebZMPy93k7VFKlBCjADF0kTzChxtfOu5Q3PNZ?=
 =?us-ascii?Q?CiSwwCZpibgwjbKK/R0nCeXObZ2P4vKWNzMZ9Yx3ZLn+ysKZnqyvF0EJl0tw?=
 =?us-ascii?Q?ZmfHxPpfuF2G9L2aor4PEjZnlFWWIenALCqxEX0cxN1D79JVoWy5UZTkmBSp?=
 =?us-ascii?Q?Z+dtYrq4IjJEH9avqSngFL1SsiUlfnaBx1XMfFDEPTcEcU9JdbilmxP5JuY4?=
 =?us-ascii?Q?+zaAqJQaHEysOZxev62L0MxNwRp/VLl2TKtU7AdEzDFEiJAPo4HjvZb90y4r?=
 =?us-ascii?Q?EWPtW7iBT6ha/rfl9mAtf11sPVrk5tzZD/wxFI6aMk4p6TlGiw7d3+8lXCso?=
 =?us-ascii?Q?0l61/XOeGUkrXk4WxkTikN+x1+RST9ul?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4t8EBZpzPY83xBo9CoUVOtE1aH29XDwa9NDeiL92rkPho1Hgl2mb8Gu9f2IN?=
 =?us-ascii?Q?Ja9YG8ZLoOPhkr4KSjOaIg7I4Po8DTBhjmjxt9OEeqb/x73AfhEipWSuhiO2?=
 =?us-ascii?Q?H8y7pRjh6SKx3pTKD/nnxHbOcutmIU2mduTSl7S5tvmf+pFBZxA31ohNVZRZ?=
 =?us-ascii?Q?Bkn1wrxRNQET1MlPaGtzWEARmNrCdrR1YlP1QwOkQK4xS+udimF4erzMMdT7?=
 =?us-ascii?Q?nCMJHmHqw6TR6nVV0kwA03D0dWVkPQ8ojTaYiyJV9HFY8+756c9mLtB+nkk9?=
 =?us-ascii?Q?YZ3l75VbNILlU9PX6ga6YXPT+WLfNNjhuCE02KVX7su18RxSAsNMayyYoFW5?=
 =?us-ascii?Q?d1F9OtEhJfs2UhKqEPtCa9zL3vYMJkBcmbPAs2B0PmhWUn5bOaWO7gvhQw2N?=
 =?us-ascii?Q?m9XzEKoPw52pehlsf1UCguBc8SXaI/2vJfADpSbpWlFhH35D0USC3LCUWxng?=
 =?us-ascii?Q?2b/IYaSFWyX6uOCaSVK5B7Ud6Xg7v6ehn7sLMRYK0doJVQw0JIpBntRQ6hGk?=
 =?us-ascii?Q?xR1LfVqjUVx6DwEQyvqaDIFiCoTs9PoKBe2Us3m7soOkQRPkG3cvubhEFQzp?=
 =?us-ascii?Q?WwJo1sJX+fMp9oDD+98i69H4fXqj2WgJrsqzrCGvbQjObFqfi4YUfr1tXmEX?=
 =?us-ascii?Q?Dl2Pt/pRvqWe8vpVl2aBzzgX7Ibd67cROoK7HW7cdEYYTfInzGvurcSplJGX?=
 =?us-ascii?Q?4AEtMy7fcpW66i5aVi7ZtL2NANW1fP44MuSvM6tHEKOf89Y7b0wpF7ncZIyF?=
 =?us-ascii?Q?6mnk++JwHCl666plh1s0sNmgwtdCzo9uPrN5Ld8a54xtEHLp+xOXgR0zii5G?=
 =?us-ascii?Q?FsjXlAeU0yt4cEmKVnkjy+6zibFhuyhRjiL+fNL9JNTZ7R2xSrkv0yyVQ70c?=
 =?us-ascii?Q?4kCHGp6WrIN1rttbdCO2gP6fNpvYTyIquacW5qTpcdzBYN4152eQOWRZR/p6?=
 =?us-ascii?Q?Sp0rS53etuR7ZS2CL5RCcTqCDN34ai/BEoeZdvlSQKAq8lX90JhoUUdSf+t8?=
 =?us-ascii?Q?/Lw3Smjc2mGDs2N9lxaK17KqEtiORDFWbRWSSk+i1VbqbBGb4wQDV6kZWaEZ?=
 =?us-ascii?Q?SvC0YjXKc40lkn3ZE2zngjfIRed0WjA1zHYFuJCA/dJ3FYizWpOS/fUlfZj6?=
 =?us-ascii?Q?mC8Fi+7Ax+ngoTm/R9OMFvi/M14zIrPtVQxdbd/qdzhfN+IPOgbqUUQwj5Nh?=
 =?us-ascii?Q?db9coO1eRws/dcnEiVKoFuY/3ugeMzf9KHKRZ2rB04k87NqIp+oKOvoSI8d5?=
 =?us-ascii?Q?1wLuZXvxhrLGB5Kh5TB5p4nGrN3Eba8eing6HXcEC9e9y8AgRsLhh/viyzjR?=
 =?us-ascii?Q?/Yjf+IbDr5TJnB1seK2N4TXv+tHV+qDVUd8DwAOLRZNmKfkFPsqjksEK7KIe?=
 =?us-ascii?Q?G5IL433aKKXcRTagtjhGiuJjj9JBdKAh+jWNXuIHvddTViiK/tPUS+yrrVtZ?=
 =?us-ascii?Q?TRS5gpBlfuPItggFWH9OlowOvPr7BGYekL0KMCbMkwXkjigpBQWVllIBepLE?=
 =?us-ascii?Q?8cp+8Sz8VggOJCThOi2MOGIlsYImC3+rQQvAimiy31UWlK3zB01z1wo2pTRh?=
 =?us-ascii?Q?v2N2kDGZnBVQP01qvBd3fQmSDRTaXvbRf+x2U0h7XfICgk2oZ4C+JKe5FvlR?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addb84fa-d237-4347-1404-08dd57de262e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:56:19.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXJKwikeIHRPulugXKutMN4C+o9KsLfnPKCD0Grldgk4aeMVeFUthu4L5ZTbFQJQRSxpizWDiY9AtYPCK2qroO4rFac1cIqKot16WBbAjgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Thursday, February 27, 2025 11:52 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org; Karlss=
on,
> Magnus <magnus.karlsson@intel.com>; jonathan.lemon@gmail.com;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> ast@kernel.org; daniel@iogearbox.net; Sarkar, Tirthendu
> <tirthendu.sarkar@intel.com>
> Subject: Re: [PATCH bpf-next v2 2/2] selftests/xsk: Add tail adjustment t=
ests
> and support check
>=20
> On Thu, Feb 27, 2025 at 02:27:37PM +0000, Tushar Vyavahare wrote:
> > Introduce tail adjustment functionality in xskxceiver using
> > bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet
> > sizes and drop unmodified packets. Implement
> > `is_adjust_tail_supported` to check helper availability. Develop
> > packet resizing tests, including shrinking and growing scenarios, with
> > functions for both single-buffer and multi-buffer cases. Update the
> > test framework to handle various scenarios and adjust MTU settings.
> > These changes enhance the testing of packet tail adjustments, improving
> AF_XDP framework reliability.
> >
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > ---
> >  .../selftests/bpf/progs/xsk_xdp_progs.c       |  48 +++++++
> >  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
> >  tools/testing/selftests/bpf/xskxceiver.c      | 118 +++++++++++++++++-
> >  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
> >  4 files changed, 167 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > index ccde6a4c6319..2e8e2faf17e0 100644
> > --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> > @@ -4,6 +4,8 @@
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/if_ether.h>
> > +#include <linux/ip.h>
> > +#include <linux/errno.h>
> >  #include "xsk_xdp_common.h"
> >
> >  struct {
> > @@ -70,4 +72,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md
> *xdp)
> >  	return bpf_redirect_map(&xsk, idx, XDP_DROP);  }
> >
> > +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp) {
> > +	__u32 buff_len, curr_buff_len;
> > +	int ret;
> > +
> > +	buff_len =3D bpf_xdp_get_buff_len(xdp);
> > +	if (buff_len =3D=3D 0)
> > +		return XDP_DROP;
> > +
> > +	ret =3D bpf_xdp_adjust_tail(xdp, count);
> > +	if (ret < 0) {
> > +		/* Handle unsupported cases */
> > +		if (ret =3D=3D -EOPNOTSUPP) {
> > +			/* Set count to -EOPNOTSUPP to indicate to userspace
> that this case is
> > +			 * unsupported
> > +			 */
> > +			count =3D -EOPNOTSUPP;
> > +			return bpf_redirect_map(&xsk, 0, XDP_DROP);
>=20
> is this whole eopnotsupp dance worth the hassle?
>=20
> this basically breaks down to underlying driver not supporting xdp multi-
> buffer. we already store this state in ifobj->multi_buff_supp.
>=20
> could we just check for that and skip the test case instead of using the =
count
> global variable to store the error code which is counter intuitive?
>=20

Thanks, Multi-buff is supported it might be that growing is not supported
but shrinking is supported. We have difference in result for shrinking and
growing tests. We are handling these cases with the existing 'count'
variable instead of introducing another variable to indicate or access in
userspace.

Here's the result matrix:
Driver/Mode	XDP_ADJUST_TAIL_SHRINK	XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF	XDP_AD=
JUST_TAIL_GROW	XDP_ADJUST_TAIL_GROW_MULTI_BUFF
virt-eth DRV		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
virt-eth SKB		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
i40e SKB		PASS					PASS					FAIL(EINNVAL)			SKIP (EOPNOTSUPP)
i40e DRV		PASS					PASS					PASS				PASS
i40e ZC			PASS					PASS					PASS				PASS
i40e SKB BUSY-POLL	PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
i40e DRV BUSY-POLL	PASS					PASS					PASS				PASS
i40e ZC BUSY-POLL	PASS					PASS					PASS				PASS
ice SKB			PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
ice DRV			PASS					PASS					PASS				PASS
ice ZC			PASS					PASS					PASS				PASS
ice SKB BUSY-POLL	PASS					PASS					FAIL(EINNVAL)			SKIP (Not supported)
ice DRV BUSY-POLL	PASS					PASS					PASS				PASS
ice ZC BUSY-POLL	PASS					PASS					PASS				PASS

> > +		}
> > +
> > +		return XDP_DROP;
> > +	}
> > +
> > +	curr_buff_len =3D bpf_xdp_get_buff_len(xdp);
> > +	if (curr_buff_len !=3D buff_len + count)
> > +		return XDP_DROP;
> > +
> > +	if (curr_buff_len > buff_len) {
> > +		__u32 *pkt_data =3D (void *)(long)xdp->data;
> > +		__u32 len, words_to_end, seq_num;
> > +
> > +		len =3D curr_buff_len - PKT_HDR_ALIGN;
> > +		words_to_end =3D len / sizeof(*pkt_data) - 1;
> > +		seq_num =3D words_to_end;
> > +
> > +		/* Convert sequence number to network byte order. Store this
> in the last 4 bytes of
> > +		 * the packet. Use 'count' to determine the position at the end
> of the packet for
> > +		 * storing the sequence number.
> > +		 */
> > +		seq_num =3D __constant_htonl(words_to_end);
> > +		bpf_xdp_store_bytes(xdp, curr_buff_len - count, &seq_num,
> sizeof(seq_num));
> > +	}
> > +
> > +	return bpf_redirect_map(&xsk, 0, XDP_DROP); }
> > +
> >  char _license[] SEC("license") =3D "GPL"; diff --git
> > a/tools/testing/selftests/bpf/xsk_xdp_common.h
> > b/tools/testing/selftests/bpf/xsk_xdp_common.h
> > index 5a6f36f07383..45810ff552da 100644
> > --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> > +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> > @@ -4,6 +4,7 @@
> >  #define XSK_XDP_COMMON_H_
> >
> >  #define MAX_SOCKETS 2
> > +#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align
> > +the data in the packet */
> >
> >  struct xdp_info {
> >  	__u64 count;
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > b/tools/testing/selftests/bpf/xskxceiver.c
> > index d60ee6a31c09..ee196b638662 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test=
,
> struct ifobject *ifobj_tx,
> >  	test->nb_sockets =3D 1;
> >  	test->fail =3D false;
> >  	test->set_ring =3D false;
> > +	test->adjust_tail =3D false;
> > +	test->adjust_tail_support =3D false;
> >  	test->mtu =3D MAX_ETH_PKT_SIZE;
> >  	test->xdp_prog_rx =3D ifobj_rx->xdp_progs->progs.xsk_def_prog;
> >  	test->xskmap_rx =3D ifobj_rx->xdp_progs->maps.xsk; @@ -992,6
> +994,31
> > @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 a=
ddr)
> >  	return true;
> >  }
> >
> > +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx) {
> > +	struct bpf_map *data_map;
> > +	int value =3D 0;
> > +	int key =3D 0;
> > +	int ret;
> > +
> > +	data_map =3D bpf_object__find_map_by_name(skel_rx->obj,
> "xsk_xdp_.bss");
> > +	if (!data_map || !bpf_map__is_internal(data_map)) {
> > +		ksft_print_msg("Error: could not find bss section of XDP
> program\n");
> > +		exit_with_error(errno);
> > +	}
> > +
> > +	ret =3D bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &value);
> > +	if (ret) {
> > +		ksft_print_msg("Error: bpf_map_lookup_elem failed with
> error %d\n", ret);
> > +		return false;
> > +	}
> > +
> > +	/* Set the 'count' variable to -EOPNOTSUPP in the XDP program if the
> adjust_tail helper is
> > +	 * not supported. Skip the adjust_tail test case in this scenario.
> > +	 */
> > +	return value !=3D -EOPNOTSUPP;
> > +}
> > +
> >  static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 le=
n,
> u32 expected_pkt_nb,
> >  			  u32 bytes_processed)
> >  {
> > @@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void
> > *arg)
> >
> >  	if (!err && ifobject->validation_func)
> >  		err =3D ifobject->validation_func(ifobject);
> > -	if (err)
> > -		report_failure(test);
> > +
> > +	if (err) {
> > +		if (test->adjust_tail && !is_adjust_tail_supported(ifobject-
> >xdp_progs))
> > +			test->adjust_tail_support =3D false;
> > +		else
> > +			report_failure(test);
> > +	}
> >
> >  	pthread_exit(NULL);
> >  }
> > @@ -2516,6 +2548,84 @@ static int testapp_hw_sw_max_ring_size(struct
> test_spec *test)
> >  	return testapp_validate_traffic(test);  }
> >
> > +static int testapp_xdp_adjust_tail(struct test_spec *test, int count)
> > +{
> > +	struct xsk_xdp_progs *skel_rx =3D test->ifobj_rx->xdp_progs;
> > +	struct xsk_xdp_progs *skel_tx =3D test->ifobj_tx->xdp_progs;
> > +	struct bpf_map *data_map;
> > +	int key =3D 0;
> > +
> > +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
> > +			       skel_tx->progs.xsk_xdp_adjust_tail,
> > +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> > +
> > +	data_map =3D bpf_object__find_map_by_name(skel_rx->obj,
> "xsk_xdp_.bss");
> > +	if (!data_map || !bpf_map__is_internal(data_map)) {
> > +		ksft_print_msg("Error: could not find bss section of XDP
> program\n");
> > +		return TEST_FAILURE;
> > +	}
> > +
> > +	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count,
> BPF_ANY)) {
> > +		ksft_print_msg("Error: could not update count element\n");
> > +		return TEST_FAILURE;
> > +	}
> > +
> > +	return testapp_validate_traffic(test); }
> > +
> > +static int testapp_adjust_tail(struct test_spec *test, u32 value, u32
> > +pkt_len) {
> > +	u32 pkt_cnt =3D DEFAULT_BATCH_SIZE;
> > +	int ret;
> > +
> > +	test->adjust_tail_support =3D true;
> > +	test->adjust_tail =3D true;
> > +	test->total_steps =3D 1;
> > +
> > +	pkt_stream_replace_ifobject(test->ifobj_tx, pkt_cnt, pkt_len);
> > +	pkt_stream_replace_ifobject(test->ifobj_rx, pkt_cnt, pkt_len +
> > +value);
> > +
> > +	ret =3D testapp_xdp_adjust_tail(test, value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!test->adjust_tail_support) {
> > +		ksft_test_result_skip("%s %sResize pkt with
> bpf_xdp_adjust_tail() not supported\n",
> > +				      mode_string(test), busy_poll_string(test));
> > +	return TEST_SKIP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int testapp_adjust_tail_common(struct test_spec *test, int
> adjust_value, u32 len,
> > +				      bool set_mtu)
> > +{
> > +	if (set_mtu)
> > +		test->mtu =3D MAX_ETH_JUMBO_SIZE;
>=20
> couldn't we base this on BPF_F_XDP_HAS_FRAGS in some way instead of
> boolean var?
>=20

No, it is being set much later. Test framework needs mtu to be set to
enable multi-buffer.

> > +	return testapp_adjust_tail(test, adjust_value, len); }
> > +
> > +static int testapp_adjust_tail_shrink(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false); }
> > +
> > +static int testapp_adjust_tail_shrink_mb(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, -4,
> > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true); }
> > +
> > +static int testapp_adjust_tail_grow(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false); }
> > +
> > +static int testapp_adjust_tail_grow_mb(struct test_spec *test) {
> > +	return testapp_adjust_tail_common(test, 4,
> > +XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true); }
> > +
> >  static void run_pkt_test(struct test_spec *test)  {
> >  	int ret;
> > @@ -2622,6 +2732,10 @@ static const struct test_spec tests[] =3D {
> >  	{.name =3D "TOO_MANY_FRAGS", .test_func =3D testapp_too_many_frags},
> >  	{.name =3D "HW_SW_MIN_RING_SIZE", .test_func =3D
> testapp_hw_sw_min_ring_size},
> >  	{.name =3D "HW_SW_MAX_RING_SIZE", .test_func =3D
> > testapp_hw_sw_max_ring_size},
> > +	{.name =3D "XDP_ADJUST_TAIL_SHRINK", .test_func =3D
> testapp_adjust_tail_shrink},
> > +	{.name =3D "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func =3D
> testapp_adjust_tail_shrink_mb},
> > +	{.name =3D "XDP_ADJUST_TAIL_GROW", .test_func =3D
> testapp_adjust_tail_grow},
> > +	{.name =3D "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func =3D
> > +testapp_adjust_tail_grow_mb},
> >  	};
> >
> >  static void print_tests(void)
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h
> > b/tools/testing/selftests/bpf/xskxceiver.h
> > index e46e823f6a1a..67fc44b2813b 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -173,6 +173,8 @@ struct test_spec {
> >  	u16 nb_sockets;
> >  	bool fail;
> >  	bool set_ring;
> > +	bool adjust_tail;
> > +	bool adjust_tail_support;
> >  	enum test_mode mode;
> >  	char name[MAX_TEST_NAME_SIZE];
> >  };
> > --
> > 2.34.1
> >

