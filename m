Return-Path: <bpf+bounces-52637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7ABA45EC6
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36E916A83D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3E21CFED;
	Wed, 26 Feb 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBmlIFPB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E71A00D1;
	Wed, 26 Feb 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572614; cv=fail; b=GOyOFIZ3P1W6r6/tDVYUCRlkDd5x5//uWtUVU4iBzmSFSYW0zsy4svzG8x4nX9vE/0Tn+nMh9LDjrlOXvMogiNQHXqCfF8lUJOPRiKXaNJQqKQcxN6z7VdH9a/hjwdvtMSaEAXufTyGB0dcKsJCLIgkuNr5vu0UxuN7Ee4yCaP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572614; c=relaxed/simple;
	bh=Hn2xBKy30HfVHV/JSQ9/Vb0scpIZq6V3/CfooLvdGYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVeSCuA2w9/BegNjpssAkekePoPlmWZhyzqocp/eEBnfn4ZryH+LJfX5cbINEpYqBR/QQDnb7IGG7xrjXLoHNGrZtB2lkTZ2foboo0u2xNObfUXi0LmgIj3ga0GnlPIA05+Q6OQpRtwsxvsVI+oaSiF4iRXGnLVZ6+DEGHsLnNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBmlIFPB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740572612; x=1772108612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hn2xBKy30HfVHV/JSQ9/Vb0scpIZq6V3/CfooLvdGYE=;
  b=WBmlIFPBF8oMsWYVmsueeiKkfzMoe4avnPZHAkB7KhPQXy9K4nlXLGup
   tPDHxfJIe9A4+7g5pjroIxrrTjEEwVkIpJqrWUxP9/GMJ8tkPhteEhxq0
   qWwNRQEGcvMalV7cV78oUvJgIFLJkGjE6xXtGdV9gb2/gaOiPYFdnvaFz
   6GDMdoKYUTuJuof/Rjy70xd5DhVc1xDD9kMra2ef++Uj3f0B/yqHuCTD6
   AmN+kMb1sHV89UBlH5Stty7frXt0xU1V2ZG9v2ukSpWpOEtfcFu5StNND
   Ai1HfEXlNFv/252c5BJ3+AEiI6GUpvP4/rYcmZWSpR7stUy4Th7AeJMXu
   g==;
X-CSE-ConnectionGUID: WZDg+lLORHy8KkqcMdVkug==
X-CSE-MsgGUID: RNzC5+KGSp+hO1HGwh67vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52405139"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="52405139"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:23:32 -0800
X-CSE-ConnectionGUID: bNGA4f6+Smm/4cO4ix57qg==
X-CSE-MsgGUID: Rh4ESbSfQS2Nn7Bh+rw6BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116535806"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:23:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 04:23:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 04:23:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 04:23:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEHaetvu9JsLk5Q4ai6IwTlGywwCaGYWxoQxOgqZF1o921GcNlRSM25W+GSY5InYbtAZ1wfW7h8XacflY9UwGwtgRg2V0iMANWoSkVORQ5/Ad++e7rg/PgbkwPX3kAfIuN9vS/UxGaryXEn4sntowXvfBBgmHRg6AlKw+2kMINtGxPZ8emkHDV+cP/q9SrjUHIIf6Py9yXf0B8DF3U+0g0EGEJlxVA4ApFns7KKBrFasLvNbVVe5eRJdcBkLnhOtJNhmyDTutLNzqTIxGuwcThiybJnF7mjv8/M5d+cVv37Hx4nm4R32Zd3KycmpTuWNyBmqpThPlDM7apCiku7pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn2xBKy30HfVHV/JSQ9/Vb0scpIZq6V3/CfooLvdGYE=;
 b=MsNYGNbiNiWVfs+SmogQPc0KzDrbgp9W+P02C5YlazXoT1Z5MSruPh87PMhdyttFjIie0UuQIrvshu0sEqvK1yAjs3dpnf1KtMEtGC7SVbHV81Ue+HuLXlDg8cRZGoOtavPYUlp0FWBaYOBpfAGKNI4Y9YSezktTFg9mOIVvdFsMtrlWXXT6NMPDro4dPSEOFORvADJF+ejqaUOGDY8FRhlPBXzQGDpvTx1KnQHkwpJb6ok+XGdxdmboZOtMEoloF53bTLa2tgC213JWe6T0G0HdNFNhq4A04MXLsJYBbCyfoFnLlj+rrPj0eXSFLEJAuM+plvOuo4XKCdm1V334Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:23:29 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%4]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 12:23:28 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Thread-Topic: [PATCH bpf-next 2/6] selftests/xsk: Add tail adjustment
 functionality to XDP
Thread-Index: AQHbg3dCpV4PPO9/ZkGLxtNR2ycpWbNQd+MAgAe9OyCAAG+dgIAA5q3w
Date: Wed, 26 Feb 2025 12:23:28 +0000
Message-ID: <IA1PR11MB6514C5DA411377F2FB09C8C58FC22@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
 <20250220084147.94494-3-tushar.vyavahare@intel.com>
 <Z7dqhiWcXDszRSYF@mini-arch>
 <IA1PR11MB651473D6A9F11317CA7A01778FC32@IA1PR11MB6514.namprd11.prod.outlook.com>
 <Z75GIb_EtzKEKTaY@mini-arch>
In-Reply-To: <Z75GIb_EtzKEKTaY@mini-arch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: 398388bf-a602-4ab3-f98d-08dd56606016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z1dpWE1BRnVuNHpkYmc4L0RaZ1hscWpyMUpJeWs1Q0JhbnhROXpXVGExdE9l?=
 =?utf-8?B?eVdHRXlqWWt2UXZpYUx3TlJGcGFlSUJ4WEJhbTBzK0lTdUJjaGRnTzNCREZm?=
 =?utf-8?B?bzhJR25HdzFWQ0tIcWgwZFA2dWpodmxueG81clF3VUtFWmd4VzFPRnloQTBQ?=
 =?utf-8?B?djFBMWpOYUZKMEtHZy8rLzhvbUpHQzFjeXVEVXlCMWllcGpsZ3BHUFVod3lr?=
 =?utf-8?B?RDRvYlRZQnRNcXV3dWcxV3laTFFoNHY4Wi9UMnp2bTd2WXI5eDFvZlVPUG9k?=
 =?utf-8?B?dGk3OW1oV0pjY2ZwSWRBeEFVaGFIaG5MUjJ6VFdUNFA1RXF3V1g3ZkNNbCta?=
 =?utf-8?B?WTZlek9xd09STHAycjYxODBsTSttYVZySHlIaU84L0w0OVQ1cHdMMmZVWHdj?=
 =?utf-8?B?QyticW1hdnNWTktjeDVsdnpnYW9XWVcyS2hqRjJzenpRbEpkbnluRWRoc2Fh?=
 =?utf-8?B?Yy9wWEtuZlVXbHdYS0lUOGlXS08xWTZYSUhrT2Q2eE80cWJ1NTZKVTJONldG?=
 =?utf-8?B?NVN2VVJuU2Zuc0V0bGpPVUtBWk94VGdUUllFZjNXS1BmbjlKMzZxY0VveVla?=
 =?utf-8?B?eHZLbUJGbDNuZFh2WWprdzJuWmtSano0VDQwdXM0MnZHY2xGMktPcUp6akNJ?=
 =?utf-8?B?YXZmb1JGcjBtbUxHZWdwVTBFUkh4L1ltZkxoMUVoeUlCcVlqY3FIZjU3Ulgy?=
 =?utf-8?B?aFRJSCt1UC8vL3gwbVFrSnNYc2FIblNreFFvV1BwNXlZZTJRSk1vYUZJMVlQ?=
 =?utf-8?B?NGs0MEkvSlFEOGxCczdMWjJib2JMQ3B3SnFidWtnMzFVYjJGMXd2Z3VCNk9G?=
 =?utf-8?B?NUJjcS9uRVAwNjhlWDIxNlJkT014Z25XaVpsc2dPcjZYbW1kempkODJWTzBm?=
 =?utf-8?B?cGs5ZU13UGhLRlZoT2RhNFFRNXdoYTQ2c0o3OXY4Q3NNdytVRU5vRkY0NFJQ?=
 =?utf-8?B?M2dmckl4R1gxNW85T016ZFR4dGxFSTRhcDVGa2NXTTJrTi94N2FkRHJOQktD?=
 =?utf-8?B?NStybUs2UnRvK2NvVEFPbUVEYnNGMXFzZmlXc213MUhJOWxNNXV1cnY2TmZP?=
 =?utf-8?B?ZHZ4UVBjbjFra2RCNWtjUE5RbzY0eFpsWU9jaWRRSklNVCtqem1ySkE4U3Za?=
 =?utf-8?B?L2MybGxaYWhRVmJzZThPOFhWdCtUZUJuQzBoT3UzZ2tZNnVtazkybFZCbGtl?=
 =?utf-8?B?YTlSSFdJcFQvV0gwendUc3ZWOGQ4eEFJSjFNU29aK1Q4Y1M4U2hxVDVabzdZ?=
 =?utf-8?B?VmdrVHAwbTBmSjY3bThIR1RMUjFOcHVSQ1hLT3hSS1lMZ0hYeGFRenJJbjdk?=
 =?utf-8?B?RGM5Y056OEtyT2pvN1htR092RTRiY2pFQm8wQTZQQmlETWNjKytTMGV6SnBH?=
 =?utf-8?B?QTFTMXpQYW9HbThqdDBFem9LaStQS1hiU2pqR3c5ZHRVaWh3Z2RFR1A0MUtx?=
 =?utf-8?B?UkNNUmxYSDhuNGkxMFV0ZnNtTmxtSTFRcFdmU1cxYkIrc3VzekJMdjc1Y254?=
 =?utf-8?B?b25ta2ZxUHFscU5GcWxxWmI4eTZDRXlxU2x4S0xyeGNVc1VRdW5BVUg2aHZl?=
 =?utf-8?B?dkpxalMrN2lEdm5pblB1L1dxLzBFN3JmUjhSaGwvNDhZRnQwdlZoenB3Y0h1?=
 =?utf-8?B?Z0N1cnJ5bnVPWjdDaGJvQ1l4eUVKWVE4Z0JqZVVva2lRdlBLb2pVZUNMbEFW?=
 =?utf-8?B?NEczamhhM1ZsMDlrUm1LY0xSRmlSeU13d0VlNkVSSjB3ZlJCemMwaFlOMFRH?=
 =?utf-8?B?ZHQ3R2p2UWdHMkMxNUlIVzZuQllUSm1tQk9qRDdDdE1RTExTTkZINXZmUlZO?=
 =?utf-8?B?bXpqQzR4d2s5MUg3NWVTeCs2TkdyalZtWVM4ZEErL2h0MkZvNGRHWFJLMTAy?=
 =?utf-8?B?UXVhSnZNY3hmRXJVcndESWJoaUtVWFB1UC9KQ0VRNTRnRjE0eWNlNDVLTWl2?=
 =?utf-8?Q?xjHNBlet+vTaJX881dTEcWAGLdtsxza2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW1rVWkzdVhrYkNJSCtIU1VVNllkQk51ZWxPZm1pWk5ZRElFWWdwRG1xUDNO?=
 =?utf-8?B?WDBHNXd4RWV1bFA1UHdCaGZvd09GM0ZmMUJ6WUd1SEtjSUpHSWlHUkY0SEVG?=
 =?utf-8?B?S252MG1xQVBMNmJOcW9KSlliUmpmaGFUcTVzSmlleGxPTnJncGFrNkdmVnQ0?=
 =?utf-8?B?bVgzc2Y1Mm1VMmdzWm9ydUxGOFQyVlpyNEJubUlOem9oQ1FEd2tZNTZRV2pF?=
 =?utf-8?B?R1VXeFFhQU5WYXFVVDZiS2cwY0FSR0NVR0RKTnJLNlowYmpXdzZEY044OEtz?=
 =?utf-8?B?bXdhbk1VUFdpV0ZIOUZ4RkZobHJIRjlCbEVrWWxlYzVkRzdJNXFnSDlQdlRI?=
 =?utf-8?B?WVZTMEg2RTYySWhkdk5PeHJKM3FVZWhoVnh3MmxMb0dtYTRHNDJaaDdKZHYz?=
 =?utf-8?B?MEVvdnFBL2tMaDVOaU8xTUF5QVpwcWwzVzFRZlF6MFhGL0toTzV6ZDhaaytO?=
 =?utf-8?B?eG5XemxKOTFGL3FDSTRILzlERUNuQXRIYjh3T0FvRHNMcmVDNEZ4dVEyUDYy?=
 =?utf-8?B?L3J4ZFMxQkp1ZmlqcVJzQkdXMzlzYTBTVGtrRXY1bmlYQWtJd09IaVFXenkx?=
 =?utf-8?B?NTJaOFExUStnc0ZOaHY2MWZkYVlxN25CaytoNE0vVVRzSW00bU5uVk9GTUlG?=
 =?utf-8?B?bWlzY29ZUm9KR2c2RDdiZGVHTnMrbjB6cXlvOExMVGw5QWRIdnlmTzI5Vnc1?=
 =?utf-8?B?TGtXN3haNlJuM0VUdjFSc0NWWVd1UWVkWkxmVU51T3FLcnI1OG1MNjlzbGxn?=
 =?utf-8?B?ZkgzVVpiVTR1Y2x0a3pydFQ0K1VXTlU5eVNiZlNiRzg3RUc1bk5nVzY1SUNG?=
 =?utf-8?B?R3ExMklReWx5ZGxpaU16Y2t3WWxzSUdJNWZpSnFIQkVwRTZ4THRBWDhkbS9p?=
 =?utf-8?B?MGgwSFNwTVNOS285d3JPNXhUQVBLU1o1R1dFYnZlTC9tdGRxdTQ1bEU4V05P?=
 =?utf-8?B?K1RrWjU3b1FaNlJEOVpzTERJWU9UaTROM1ZHbEhGZ3RmcTJwT1M0eC95TGRR?=
 =?utf-8?B?MUNhd3pwNUR2RFc4cU1oeVFPaHZzckJzMUR1VUh1b003a0FnTmpEdWdiUm1Q?=
 =?utf-8?B?ZjI3WWV6dTg5T3Roa0R6bTRscmxoRlJzM2dyUEs4S0hSNDlQSU1yZUlaaDFt?=
 =?utf-8?B?VXprcGg0cTJ3SGVQSGx3ZUNxK1ZvVTFTVys0TXQyYTMzb1ZiMEcvNVo1cHlv?=
 =?utf-8?B?MWR5ZVMrSk9VMXNBUUVXaW9ORFJKVzgxUEh5TzZFUFdiRHFFcTJ2bWQ1SHhi?=
 =?utf-8?B?L2hnVU56cHpTckJRUWJuOVVwZSt6a1IyM2trNVBaT0pXSnAxb2VDSXpiQndh?=
 =?utf-8?B?L1o1eWlEODU1Mm1oYThkYitMaGFqU25mSW9neENLdlVrZUJITDFYRHE5N3hQ?=
 =?utf-8?B?V0dvQSt5LzAzaEM1MVdodEw5KzNJelZmYjFIazUzS0ZGN0VybUlaMmQ3Znk0?=
 =?utf-8?B?K3lONE1RVFZGTTZnaUQ0NHd0Y1ZhVzhvNklkSzN6VC9TdXl2UEoycjY4OStp?=
 =?utf-8?B?THNySG5RV3Nla1ZybFJNM0JWTG9iZHhIVk5XdVc5Q1NBcFNseWdqV1VGQ01y?=
 =?utf-8?B?UTlKZlVBM1ovVW50K0IvdlZQYnJXS3RiL0REWUN3ZkxLck04TUpCS1FPSjF1?=
 =?utf-8?B?TzU2ZXgyTDFoSU5jTUtBZkpHVG92cVVRUExRQ2pCa3A0ZUVKR1ZVUmV5dXlF?=
 =?utf-8?B?SXNUR3FzMWh2bmpVSVJuUUVzMXpGRjZsenByL1g0bC80bzJ2K29QaTZ1K3VI?=
 =?utf-8?B?aG9Sem1uSmFrZ1hST3J4c1RlR3Nmb1R4bnRBYzduOFMwMnozU1J5Qm9WUUtH?=
 =?utf-8?B?NTFuZG9ubWYzT1pnT3B5aVdYclh1UnZ1Q3hMeU9HVDljSm50S05VajBiRG5P?=
 =?utf-8?B?RzN4LzB2OEZsZHh0QW5UQWhLZWV2MzlBazhKUVVoODRmc1FJQkM3NTZaSWdq?=
 =?utf-8?B?eGNzbEw0YmV3c0VFT2EyTlExWmxoMFpWWHF2TXo4N09iL0NuSmh1bU94Nmts?=
 =?utf-8?B?U2pxWitmbUFpY2RwMXZzd2pEVElsSTBDY1hDcmV0S1lQSEdGVjFpRmpaUlp4?=
 =?utf-8?B?T3hXYllmdjh3b2Y2SzFnOC9qTEU2Vlc1RFJHckxZaExuakt2QmNiU3YwTGhu?=
 =?utf-8?B?eU9teXdQcFNrNUkya0VOWVBHYUVKZ1FGZWhxTjFrZXlSM0dIOGxSVEpSb1dG?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398388bf-a602-4ab3-f98d-08dd56606016
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 12:23:28.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5NfSaELpycyh7Ts4lKkrwqsKPo+/7O2qBOjxaUT7AYJiYqOolaN9uPOhcegUwYMOKvFKdyD0nliFrSN/UCk/LsNnHSaINtDe2RqJ5+eQ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzdGZvbWljaGV2QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
NiwgMjAyNSA0OjA3IEFNDQo+IFRvOiBWeWF2YWhhcmUsIFR1c2hhciA8dHVzaGFyLnZ5YXZhaGFy
ZUBpbnRlbC5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBiam9ybkBrZXJuZWwub3JnOyBLYXJsc3NvbiwNCj4gTWFnbnVzIDxtYWdudXMua2Fy
bHNzb25AaW50ZWwuY29tPjsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFsa293
c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxlbW9uQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgYXN0QGtlcm5lbC5v
cmc7DQo+IGRhbmllbEBpb2dlYXJib3gubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5l
eHQgMi82XSBzZWxmdGVzdHMveHNrOiBBZGQgdGFpbCBhZGp1c3RtZW50IGZ1bmN0aW9uYWxpdHkN
Cj4gdG8gWERQDQo+IA0KPiBPbiAwMi8yNSwgVnlhdmFoYXJlLCBUdXNoYXIgd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0YW5p
c2xhdiBGb21pY2hldiA8c3Rmb21pY2hldkBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2Rh
eSwgRmVicnVhcnkgMjAsIDIwMjUgMTE6MTcgUE0NCj4gPiA+IFRvOiBWeWF2YWhhcmUsIFR1c2hh
ciA8dHVzaGFyLnZ5YXZhaGFyZUBpbnRlbC5jb20+DQo+ID4gPiBDYzogYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYmpvcm5Aa2VybmVsLm9yZzsNCj4gPiA+IEth
cmxzc29uLCBNYWdudXMgPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+OyBGaWphbGtvd3NraSwg
TWFjaWVqDQo+ID4gPiA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxl
bW9uQGdtYWlsLmNvbTsNCj4gPiA+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9y
ZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+ID4gPiBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2Vh
cmJveC5uZXQNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5leHQgMi82XSBzZWxmdGVz
dHMveHNrOiBBZGQgdGFpbCBhZGp1c3RtZW50DQo+ID4gPiBmdW5jdGlvbmFsaXR5IHRvIFhEUA0K
PiA+ID4NCj4gPiA+IE9uIDAyLzIwLCBUdXNoYXIgVnlhdmFoYXJlIHdyb3RlOg0KPiA+ID4gPiBJ
bnRyb2R1Y2UgYSBuZXcgZnVuY3Rpb24sIHhza194ZHBfYWRqdXN0X3RhaWwsIHdpdGhpbiB0aGUg
WERQDQo+ID4gPiA+IHByb2dyYW0gdG8gYWRqdXN0IHRoZSB0YWlsIG9mIHBhY2tldHMuIFRoaXMg
ZnVuY3Rpb24gdXRpbGl6ZXMNCj4gPiA+ID4gYnBmX3hkcF9hZGp1c3RfdGFpbCB0byBtb2RpZnkg
dGhlIHBhY2tldCBzaXplIGR5bmFtaWNhbGx5IGJhc2VkIG9uIHRoZQ0KPiAnY291bnQnDQo+ID4g
PiB2YXJpYWJsZS4NCj4gPiA+ID4NCj4gPiA+ID4gSWYgdGhlIGFkanVzdG1lbnQgZmFpbHMsIHRo
ZSBwYWNrZXQgaXMgZHJvcHBlZCB1c2luZyBYRFBfRFJPUCB0bw0KPiA+ID4gPiBlbnN1cmUgcHJv
Y2Vzc2luZyBvZiBvbmx5IGNvcnJlY3RseSBtb2RpZmllZCBwYWNrZXRzLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIgVnlhdmFoYXJlIDx0dXNoYXIudnlhdmFoYXJlQGlu
dGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBBbnkgcmVhc29uIG5vdCB0byBjb21iaW5lIHBhdGNoZXMg
Mi4uNSBpbnRvIGEgc2luZ2xlIG9uZT8gSSBsb29rZWQNCj4gPiA+IHRocm91Z2ggZWFjaCBvbmUg
YnJpZWZseSBhbmQgaXQncyBhIGJpdCBoYXJkIHRvIGZvbGxvdyB3aGVuIHRyeWluZyB0byBwdXQN
Cj4gZXZlcnl0aGluZyB0b2dldGhlci4uDQo+ID4NCj4gPiBNYXliZSB0aGF0IHdhcyB0b28gbWFu
eSBwYXRjaGVzLiBIb3cgYWJvdXQgdGhpcz8NCj4gPg0KPiA+ICMxOiBzZWxmdGVzdHMveHNrOiBB
ZGQgcGFja2V0IHN0cmVhbSByZXBsYWNlbWVudCBmdW5jdGlvbg0KPiA+ICMyOiBzZWxmdGVzdHMv
eHNrOiBBZGQgdGFpbCBhZGp1c3RtZW50IHRlc3QgZnVuY3Rpb25hbGl0eSB0byBBRl9YRFAuDQo+
ID4gIzM6IHNlbGZ0ZXN0cy94c2s6IEFkZCBzdXBwb3J0IGNoZWNrIGZvciBicGZfeGRwX2FkanVz
dF90YWlsKCkgaGVscGVyIGluDQo+ID4gICAgIHhza3hjZWl2ZXINCj4gPiAjNDogc2VsZnRlc3Rz
L3hzazogSW1wbGVtZW50IGFuZCB0ZXN0IHBhY2tldCByZXNpemluZyB3aXRoDQo+ID4gICAgIGJw
Zl94ZHBfYWRqdXN0X3RhaWwNCj4gDQo+IEV2ZW4gdGhhdCBtaWdodCBiZSB0b28gbXVjaC4gIzEg
aXMgY2xlYXJseSByZWZhY3RvcmluZyAtIGtlZXAgaXQgc2VwYXJhdGUuIFRoZSByZXN0DQo+IHNl
ZW1zIGxpa2UgaXQgYmVsb25ncyB0byB0aGUgc2FtZSB0ZXN0Y2FzZShzKT8gSSdkIHB1dCBwYXRj
aGVzIDIsMyw0LDUsNiBpbiB0aGUNCj4gc2FtZSBwYXRjaC4NCj4gDQo+IEZvciBleGFtcGxlLCB5
b3UgYWRkIGJwZiB4c2tfeGRwX2FkanVzdF90YWlsIGZ1bmN0aW9uLCBidXQgdGhlcmUgYXJlIG5v
dCBjYWxsZXJzDQo+IGluIHRoZSBzYW1lIHBhdGNoLCBzbyBpdCdzIG5vdCBjbGVhciB3aGF0J3Mg
dGhlIGNvbnRleHQuDQo+IFNhbWUgZm9yIHRlc3RhcHBfeGRwX2FkanVzdF90YWlsIC0gdGhlcmUg
aXMgbm8gY2FsbGVyLCBzbyB0aGUgcmVhZGVyIG5lZWRzIHRvIGdvIHRvDQo+IHRoZSBuZXh0IHBh
dGNoIHRvIHB1dCBpdCBhbGwgdG9nZXRoZXIuIFNhbWUgZm9yIHRlc3RhcHBfYWRqdXN0X3RhaWwu
Li4NCg0KDQpNYWtlIHNlbnNlLiBXaWxsIGZpeCBpdCBhbmQgc3VibWl0IGEgdjIuDQo=

