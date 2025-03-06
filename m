Return-Path: <bpf+bounces-53470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F82A54C44
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 14:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7C170EB4
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA720F062;
	Thu,  6 Mar 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPTgW/ie"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4E204C28;
	Thu,  6 Mar 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267823; cv=fail; b=npRvV7l1e8TuiQwCAZ8uxh/C1EEJDfi1YtO7YvRPMn7lZMFsO0OgIERaBiWJzOIVMrQB4PYC3tkS3pzCTOvtv6kKHek/GG+VGX5qGXDfflD1OQ7g/6ilpmrFirnW7WPFOoeVotdpu7G3S4Mgmk8NkPZlYGO3LUCZXbZs9C4H9tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267823; c=relaxed/simple;
	bh=Ypr90x3XVD891V+HoyolNhjrTQqRJuCwxCP0c1ST4cE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3HxjB6KSi8fYcX7uzT3tXHGXh6CMH4RcHyO68O0HEt0aLPkEUaslWTuWIS07VrM5AAQCBtSYxHjFRgKT/pV/+5XNGJk5EYYsJsxFiGRd0AkXTHVaLeElZ2XHcGbYPUMGzeUQeeuqAWjcsDzzDc0egWHvBM4EJBQoxvHVMbXQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPTgW/ie; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741267821; x=1772803821;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ypr90x3XVD891V+HoyolNhjrTQqRJuCwxCP0c1ST4cE=;
  b=jPTgW/ieMdUC9KJaMR/sIwYWm9/lXFqAcCmwTuP/XDkw13jV6jCq8ogJ
   2JbP+39Rn4HBwUw3mUFCD1cRm9TN8s0g87EbHlyU3Y8JWm9YzMlguGTh6
   G0sMEeWtruphwBR+gcz6sZE8lB8IJxbctxA6CU94pBdL1m/G2kjyJ2W1y
   7EGxM1yozoLSDHQ7AfuJtkWCdaskGEWVML72KatGSTOvWZWyQCucWaaEq
   G65rUQjnAQYdFyvFSnaPLG+n2gJfOXut3QsqneYoIu1IbzituarElXkSn
   5UclauJC+l60+9u6xhL4q7dHJfIvV8H7YWqUq2vuIaln+rNv3Qf2cNzPO
   g==;
X-CSE-ConnectionGUID: 9+JPrlagQGuKZIZgEGOYPQ==
X-CSE-MsgGUID: jv9zSkhUS4m5FD3MSWJyig==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53673473"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="53673473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:30:19 -0800
X-CSE-ConnectionGUID: ffTairnwQ2S0ymQ0gxP7eA==
X-CSE-MsgGUID: z7UVphlNQRyhG13Ktq1QLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="124109793"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 05:30:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 05:30:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 05:30:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 05:30:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZF+Uy6col/rhBNbS3byZga7PKz8A8p4YOFtYZhwhx8KN8uuNGqp4Vdl8irzTCAAgWdKYmC8uNkUIAUSivOZdERrol7CP7uDZQviFjy9t69PIMlnshal0m5FbYA/zGrdnbuI71pTBcDJq2vSrjsZfUUtDE93FM8mO1CRz8YbM67ph6vjayKEpVj9XCfORJuN1s2GlL5dniAwCkX3MN2JtV8nTC0xeXteqfjRfDk7vfZz+7mEHmvgyAYWHka1IHgcF9uIaCjRn5hMYZq1UT6EtNsSwkAZvHJ2J+e3d1VpfmVnbukposKJh/Jgv+j5P3P/5K2YVpEOswQFlKr0Y56wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/b8tDwlFw7E2EvjtcKHXdZ9y8uaTS2n0q6kA7p80VU=;
 b=cX9q05iyMpgkg2K/UNlcqy2T6He6DSOsSZpF2fr39zaBgh4gvIRKrqTftcq5yjcoCtvb1ZPcsiMJJXJIRE4MvLd2wFrjc58B0fd8UcxAoFN1ztrW2y/jE9PgdpvgqG6xZEVNTU0CbbHgbSN/Sm2xe2wnNkiz1YSpBovvf/5nwbMfCE/44ZzFyM9b2av9uw0TEkbcqkv19Sy2xTOHZrPEGfWB+v09A0VH8NMTAJMXMuAUzMHty3t4I5YC9ZGdobCs4Fbp60zdLCjkM3hdsu2FDgbPCcweNUURSPigqyDXLTdFAW0tHZtnF0nmlMBp78OiD61V3aRM+ymMzDh2hozu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 13:30:11 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::5461:fa8c:58b8:e10d%5]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 13:30:11 +0000
Date: Thu, 6 Mar 2025 14:30:00 +0100
From: Francois Dugast <francois.dugast@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Gomez
	<da.gomez@samsung.com>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, <linux-modules@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, clang-built-linux
	<llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <Z8mjWEUj6YTLqbm3@fdugast-desk>
References: <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
 <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
 <3ehu3r4hlsf7cpptofz2y5aq2bazidq4buxbddqj6gzvzd3eh3@wzlnbvdsc6ty>
 <e6jybeg4y6q6zqyhqma7q4icw7jllieq5rwwi5pguy242wioyp@hkelxx7tnzlg>
 <mghfn2piuln4oxg2zkmukjcjbt2hyieqsgfnckfzvjwrcbi4eh@vwh5nsvwajjq>
 <zmyiypw5dvqir2lxxmdqvpr6qfrol2xem2usu2b5t223txm4k6@7hkupacsf5sh>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zmyiypw5dvqir2lxxmdqvpr6qfrol2xem2usu2b5t223txm4k6@7hkupacsf5sh>
Organization: Intel Corporation
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|MW3PR11MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd7664d-9c4f-44ef-04a0-08dd5cb30505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3BQNjg2RktQK0FvWVFTZmNoOG9IWUc0SFNIajB2REJWOVBxNVorZis0V3Vs?=
 =?utf-8?B?Wlpwc1NiQzJYb0NpTzVLQXMrNkxJMFlOY1NzazVtVmpGU3FRQVZ1NW5UQzZw?=
 =?utf-8?B?VDMrWFpGUnN5WXFJWVNiUTgvdXNkUHh0bE1JSW1DOHRyNStkQVIyeGtsR0Vn?=
 =?utf-8?B?UHJ6U2JFYmhSdURQeXV6blZYbTlFVWUxUGgvQnloa1oyam5oTjJYTzliMUUz?=
 =?utf-8?B?YnFzL3FtdklyZ2J6Nm96U1dTTCtYTTY5UFhoMjdFN3pEUWdFWDVkOEhFQXpw?=
 =?utf-8?B?M2JaQlN5bjhGOFg5Q2dyMTY2YlVKc1laWHVFWllpcHozejVOUnJLWTMwNVlH?=
 =?utf-8?B?dWZPM2ErbHoxWUZSdVVJMmpuVHhlbkdJWDQvWVhQbUhaaExkQmpHVTlmZC9v?=
 =?utf-8?B?RDB3Ym1TY0hkQVMrNndZS2x4M29HZ3QxYWFSSWlYUlhhTVhqWDZySnQzbFFD?=
 =?utf-8?B?K0NMNERVbklVb0NsYUpHKzZrWWF6ZFNjbWIvaXFJY1RxVENWNk95RDE5ZTBZ?=
 =?utf-8?B?SWZBRE0vaVM4RTYxTGtRY2FyZmZqWi90eE1NY0xJUFNZemoyVGRqMnNXY0tC?=
 =?utf-8?B?eUdEcHpVZEsyT05tVHdMQnp4YVovUjBBNHYzQjZ0MytEM1NEV200TFN3cmR6?=
 =?utf-8?B?SnFyOStNbkVleGpiNTZvQk4vN0NuUC9NSWk1Z2wwcFhhVlljMjluNitEejll?=
 =?utf-8?B?TlN2Nm1uWHJZV1BGNmNJeW9rYnZaUVNsYWY3eDJVNWRNUi9YQnVhU0xOYlVu?=
 =?utf-8?B?QUhDM09uc3hQdUt0eW1SVEczWURFdW5yRFlESVNmU1lVanc0czc1enZnR2NU?=
 =?utf-8?B?N2E1OGZ4cW4xM3U5NWVXWTB4WTBUdzh1a1ZCWERMZG9DOHRjNS9JQkl3eEU4?=
 =?utf-8?B?bFVHUTZKYkxEK3dzMmJ0YzlPeFdrZzlUWE1Tbjk2aFN4cGNIY3lTNmRvVkJ3?=
 =?utf-8?B?Ri82WG5GLzFFUE16aVlqSW56UmFVMmF3WjZtMkRkVlRhNGYzYi92eUd3eVZD?=
 =?utf-8?B?S2ZUdGJCOVpBdHVzeXo5UHc1MzNBWXVCdDg4TnBLdXROSHBnTlVDT01iMnBE?=
 =?utf-8?B?QjBpWnR6OVJyWlNneFZudWNVOG4xMGMrSHphZUFNblpvNnpVc2VmUHBlY0pH?=
 =?utf-8?B?Ukx4b1BWOENlWlYyNVZFSEVxeUliK1oxSERNSVFlc01kZHN5NGdhTDYwY1Za?=
 =?utf-8?B?dnR6UjJzaG14UkhSczdaWmFNYXdFV2E2czBydGJja1k3MExjaHNVVGFlcEMw?=
 =?utf-8?B?QUkzdnFNZG81eFVIL3NUaDZaZllYemRrWWsxc2lnOTZNdGNMaFkvUGZlSDVS?=
 =?utf-8?B?WG9uTFZNZkFycmFlNy9JSDQ2UE1pNEVjRncya0ttL1gzQnVGY1E4OVZFNjJl?=
 =?utf-8?B?TCt3bGYwK3BtRXdBV2dkN2o2STRHZHRpbzhad0djRnUyZGtpU3htamErZElV?=
 =?utf-8?B?Vy8vZ0tVV1U3WThMc2NhdEs4QWsyN2xzcDl5SnB4cnpkVXl3SkoxdjRYU3pO?=
 =?utf-8?B?S1A4NW9XVko2Y053aDNWdHp0Q3AwQVZ3QlZOQ3RUeVU0cnhJbjdmWlJyL0V3?=
 =?utf-8?B?a0FzbjVBaW5BNEthY0pqRmlYRGQvOTAwVXdvVG1OVDV6M09kMGxobXlINjhp?=
 =?utf-8?B?OHpkUUtISE1ReU5ZYkxmdFNVYlcyd1pkNVE4Unp2RlRLVmNBMlRZaFFjeUNn?=
 =?utf-8?B?QTJRQ0RQR2pxSlZaT3RMM0RFbmdrZXRUTVdBRUJieW5UUFBUQmhmNHVRUzlW?=
 =?utf-8?B?ZEVuMmt6NmNidHhVSXRoRmxRemFmMzBVVjRadXhIYTl0YWthUm9tWGlBSzVy?=
 =?utf-8?B?MG5FUElCWVJzby84eWh2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7828.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZ1ZEJ0eGtXaHdUand5VTVMNjRlNjVzWjA4c0l6Vkd0MVIxTGhIZ1lQczRG?=
 =?utf-8?B?dVVYMjcvS2RrN3crMVVpc3orV3RNR29rU3pTWHhUVWFobkZGWDlmVVcwSWRP?=
 =?utf-8?B?WXN6RVdldHhLejYzNE5xT1NiWU5laFFFbzdxVTVQeXJ1V0wwQnp0QUV4T0xK?=
 =?utf-8?B?U2pvanJHWm9xSWNxN3RlSk5UYXc1Y2trUkNrZThUb0VtN3FHL0U4SkhqOEpR?=
 =?utf-8?B?VE03OWQ5VTVZUTRvRVpqcVFvVnRyak5NSVNOQ1JVdnpXczBmbWpPbG1zMGUx?=
 =?utf-8?B?MjBtalh6M2lpMUo2V2hudVdjbmU2cWJIZ3p2UWpiOUN3WVQrY2JMaDRSR3M1?=
 =?utf-8?B?Z1V1U1NWbmVINlIvM0RHdTdWTmczSlRTR1IxM1Z2RWxEY05UV2tWWEJyNitm?=
 =?utf-8?B?THZrT0JFb1lMRFBic2QvcUV3MTVXcVEvNTJNd0tsQTJlS05XQ2c3cURPUllN?=
 =?utf-8?B?RmJJR1NkZEpMWHpVNlV1dU1Hd2YycWo4YlJ4ZWhVNXBBeGdKd1B3RjRNdHJI?=
 =?utf-8?B?V3lpWk9qUDUwdHB0blgxNy9ZL094cnZXRVF2NmN3Tkw4NHN4QUc4M2gzOEo1?=
 =?utf-8?B?aDNsOTlUczd1b2l0UVJpLzFyRG5BdnJDY05OY01Pb3pFRFFNT0Q1WmFoTDhL?=
 =?utf-8?B?Q2hWM2NKYlhuWEh6SksvckRwakFDY3hnbnFyRUt2QnJXVERwRFhvajFodVo4?=
 =?utf-8?B?Uy80T3p1OGtnNjF4MWhPRzFlMVBSOFVUVVpTencyWkJRd1laVUJpNDVlTSt1?=
 =?utf-8?B?NHdMZ0ZUZmxLM2lQVzJGZTVOdDI2Y2QwV09aN29UUGVjaU1jLys0YnUwSzNS?=
 =?utf-8?B?MytRK3JrSUtvYzByMno5Sk9rcFFqRzUyaGZwWU9WUUt3NVhlTW1oRWlJRzYz?=
 =?utf-8?B?bXMyZ1lDbjN4YlpaSE5YdzhKK29LTnhzK3FGMWhOZEJ1WW5MQnUrWjZYcklK?=
 =?utf-8?B?Y081VGUrY3dzYjNRSlR2N1hDRGZKbm1nMWo3WjdJa1pwOS9wVVdEZjQ2Z0sr?=
 =?utf-8?B?WE9QQ1VkK2s1OEViY2ozNmtEcUJ3TStVb0orNm5jY2ZTUnNYajJ1WEtHYVRi?=
 =?utf-8?B?UzJlZzFmaFFLRHk0TE5kd3hPU29PazFNeGlaVXJhWU9QVzAzNUhCV3VvSHhZ?=
 =?utf-8?B?MldFWHltcUd2OG1LcThsOEsrUS9kRmptK0NFZEFuNmxYZzRaQkxJSWhuL1Ux?=
 =?utf-8?B?UkMxV09VTFVyNm5lQXRkS2hpd2ZMano2cjVtNGxLVEo3YndLbC9TWEd1YXY0?=
 =?utf-8?B?dkxsdXRkYnA5WXhHejNybU1RZS9venU2TGxYMnlNaG5FRlR0eW1lRlBpMkZN?=
 =?utf-8?B?ZVpDRG5NMENkM2V0Y2YrSUtXRW9IaVJ6TUk5YnlDYm5xWVNlVDcwZlhhZXJG?=
 =?utf-8?B?UVdyN1hKRGhDYVpnVVlOdEJRRGtmTG9CSllHWDhXSEZpZkZwWjREUHBaYWNY?=
 =?utf-8?B?c2FlQ1FvdmZJOXhjUXg3M1VqRC94MG0rNjZKemFRMm56SkZqSlBKcnNlZWJK?=
 =?utf-8?B?ZWlnR044U1hmck96aWVUUjRvVTlwd3RyZTd1K2V6ZVluMXZSNnZYYmtGNkgv?=
 =?utf-8?B?cHlmVVJCTDRwWEcwWURvZ043bGVtRDZIK1JobUZHYStXenJacFJBUGhydXRr?=
 =?utf-8?B?WUE0Ty9sejNsZk91RXZjWUg2N0p5azFOZUpKVThsNWVjT0FlUVgwcTFtVWk5?=
 =?utf-8?B?Wkw3OUp5YkNFTUtOUTVTYU1VZ1N1bkI0V0U1SHZUUnhpbGVlQjZHNlQ0dEtN?=
 =?utf-8?B?NDM1MlNZSGMyek5RR1VYUXlybHdVUmhobXViOXl3alUrd1RsMWwrSG5JM1lz?=
 =?utf-8?B?WFhtaVJuVUgwMC95eHl1TWFHUW52d2x6T3FxTC8rUTlrU1RFOXBXNjRmUW9P?=
 =?utf-8?B?OXFOR3EvRU5EN1BtcEhxbVRxTGdZVzM5VnhRa0YxVXI3TmxHNGVCVmgxWjNh?=
 =?utf-8?B?M29ycU1EeS9lNUh2SW5uR0FRZWoyM2RGV1UwcHdjbmpXV0tCczNwV3JUZy90?=
 =?utf-8?B?RjkxeEsxa1pmWGZULzlLNTFyN0V4aCtUNERQWU15OVVsZUdFUU5WM1NpU21Z?=
 =?utf-8?B?ZXJJWTB3enhJdnVSc292OUI4MEdrZ2w0Ym1yL2R2MDRDUXh5eWliWFVkYlNP?=
 =?utf-8?B?RFFZb1Vra09HY0dRSmFKWUt5T0JHclIvbDU1M1FLQ1ZUenh4QVRLQzYwdStM?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd7664d-9c4f-44ef-04a0-08dd5cb30505
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:30:11.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwslvRMZc0B5EwcHV8cF6Sb8WsEhwcnNINp18WM7OughixNAvVXn3zVzL6WjDGGySvLMzCw5GglsdMWQ5hLtlCcCEPvjY3lI54B8giHIFPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 03:08:25PM -0600, Lucas De Marchi wrote:
> +Francois who added most of the error injection points in xe
> 
> On Wed, Mar 05, 2025 at 11:06:57AM +0100, Daniel Gomez wrote:
> > On Fri, Feb 28, 2025 at 12:48:38PM +0100, Lucas De Marchi wrote:
> > > On Fri, Feb 28, 2025 at 10:27:17AM +0100, Daniel Gomez wrote:
> > > > On Mon, Feb 24, 2025 at 08:43:45AM +0100, Lucas De Marchi wrote:
> > > > > On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
> > > > > > On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
> > > > > > > On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
> > > > > > > > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
> > > > > > > > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
> > > > > > > > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Add support for a module error injection tool. The tool
> > > > > > > > > > > can inject errors in the annotated module kernel functions
> > > > > > > > > > > such as complete_formation(), do_init_module() and
> > > > > > > > > > > module_enable_rodata_after_init(). Module name and module function are
> > > > > > > > > > > required parameters to have control over the error injection.
> > > > > > > > > > >
> > > > > > > > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
> > > > > > > > > > > brd module:
> > > > > > > > > > >
> > > > > > > > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
> > > > > > > > > > > --error=-22 --trace
> > > > > > > > > > > Monitoring module error injection... Hit Ctrl-C to end.
> > > > > > > > > > > MODULE     ERROR FUNCTION
> > > > > > > > > > > brd        -22   module_enable_rodata_after_init()
> > > > > > > > > > >
> > > > > > > > > > > Kernel messages:
> > > > > > > > > > > [   89.463690] brd: module loaded
> > > > > > > > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
> > > > > > > > > > > ro_after_init data might still be writable
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  tools/bpf/Makefile            |  13 ++-
> > > > > > > > > > >  tools/bpf/moderr/.gitignore   |   2 +
> > > > > > > > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
> > > > > > > > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
> > > > > > > > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
> > > > > > > > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
> > > > > > > > > >
> > > > > > > > > > The tool looks useful, but we don't add tools to the kernel repo.
> > > > > > > > > > It has to stay out of tree.
> > > > > > > > >
> > > > > > > > > For selftests we do add random tools.
> > > > > > > > >
> > > > > > > > > > The value of error injection is not clear to me.
> > > > > > > > >
> > > > > > > > > It is of great value, since it deals with corner cases which are
> > > > > > > > > otherwise hard to reproduce in places which a real error can be
> > > > > > > > > catostrophic.
> > > > > > > > >
> > > > > > > > > > Other places in the kernel use it to test paths in the kernel
> > > > > > > > > > that are difficult to do otherwise.
> > > > > > > > >
> > > > > > > > > Right.
> > > > > > > > >
> > > > > > > > > > These 3 functions don't seem to be in this category.
> > > > > > > > >
> > > > > > > > > That's the key here we should focus on. The problem is when a maintainer
> > > > > > > > > *does* agree that adding an error injection entry is useful for testing,
> > > > > > > > > and we have a developer willing to do the work to help test / validate
> > > > > > > > > it. In this case, this error case is rare but we do want to strive to
> > > > > > > > > test this as we ramp up and extend our modules selftests.
> > > > > > > > >
> > > > > > > > > Then there is the aspect of how to mitigate how instrusive code changes
> > > > > > > > > to allow error injection are. In 2021 we evaluated the prospect of error
> > > > > > > > > injection in-kernel long ago for other areas like the block layer for
> > > > > > > > > add_disk() failures [0] but the minimal interface to enable this from
> > > > > > > > > userspace with debugfs was considered just too intrusive.
> > > > > > > > >
> > > > > > > > > This effort tried to evaluate what this could look like with eBPF to
> > > > > > > > > mitigate the required in-kernel code, and I believe the light weight
> > > > > > > > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
> > > > > > > > > suffices to my taste.
> > > > > > > > >
> > > > > > > > > So, perhaps the tools aspect can just go in:
> > > > > > > > >
> > > > > > > > > tools/testing/selftests/module/
> > > > > > > >
> > > > > > > > but why would it be module-specific?
> > > > > > >
> > > > > > > Gotta start somewhere.
> > > > > > >
> > > > > > > > Based on its current implementation
> > > > > > > > and discussion about inject.py it seems to be generic enough to be
> > > > > > > > useful to test any function annotated with ALLOW_ERROR_INJECTION().
> > > > > > > >
> > > > > > > > As xe driver maintainer, it may be interesting to use such a tool:
> > > > > > > >
> > > > > > > > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
> > > > > > > >
> > > > > > > > How does this approach compare to writing the function name on debugfs
> > > > > > > > (the current approach in xe's testsuite)?
> > > > > > > >
> > > > > > > > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
> > > > > > > > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
> > > > > > > >
> > > > > > > > If you decide to have the tool to live somewhere else, then kmod repo
> > > > > > > > could be a candidate.
> > > > > > >
> > > > > > > Would we install this upon install target?
> > > > > > >
> > > > > > > Danny can decide on this :)
> > > > > > >
> > > > > > > > Although I think having it in kernel tree is
> > > > > > > > simpler maintenance-wise.
> > > > > > >
> > > > > > > I think we have at least two users upstream who can make use of it. If
> > > > > > > we end up going through tools/testing/selftests/module/ first, can't
> > > > > > > you make use of it later?
> > > > > >
> > > > > > What are the features in debugfs required to be useful for xe that we can
> > > > > > port to an eBPF version? I see from the link provided the use of probability,
> > > > > > interval, times and space but these are configured to allways trigger the error.
> > > > > > Is that right?
> > > > >
> > > > > I don't think we use them... we just set them to "always trigger" and
> > > > > then create the conditions for that to happen.  But my question still
> > > > > remains:  what is the benefit of using the bpf approach over writing
> > > > > these files?
> > > >
> > > > The code to trigger the error injection still needs to exist with both
> > > > approaches. My understanding from debugfs and the comment from Luis earlier in
> > > > the thread is that with eBPF you can mitigate how intrusive in-kernel code
> > > > changes are to allow error injection. Luis added the example here [1] for
> > > > debugfs.
> > > >
> > > > [1] https://lore.kernel.org/all/20210512064629.13899-9-mcgrof@kernel.org/
> > > >
> > > > To compare patch 8 in [1] with eBPF approach: the patch describes
> > > > all the necessary changes required to allow error injection on the
> > > > add_disk() path. With eBPF one would simply annotate the function(s) with
> > > > ALLOW_ERROR_INJECTION(), e.g. device_add() and replace the return value
> > > > in eBPF code with bpf_override_return() as implemented in moderr tool for
> > > > module_enable_rdata_after_init() for example.
> > > 
> > > but that is all that we need with the fail_function in debugfs too:
> > > 
> > > $ git grep ALLOW_ERROR_INJECTION -- drivers/gpu/drm/xe
> > > drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(xe_device_create, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_device.c:ALLOW_ERROR_INJECTION(wait_for_lmem_ready, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_exec_queue.c:ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
> > > drivers/gpu/drm/xe/xe_ggtt.c:ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_guc_ads.c:ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_guc_ct.c:ALLOW_ERROR_INJECTION(xe_guc_ct_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_guc_log.c:ALLOW_ERROR_INJECTION(xe_guc_log_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_guc_relay.c:ALLOW_ERROR_INJECTION(xe_guc_relay_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() is used to conditionally skip function execution
> > > drivers/gpu/drm/xe/xe_pci.c: * ALLOW_ERROR_INJECTION() macro but this is acceptable because for those
> > > drivers/gpu/drm/xe/xe_pm.c:ALLOW_ERROR_INJECTION(xe_pm_init_early, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_create, ERRNO);
> > > drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_prepare, ERRNO);
> > > drivers/gpu/drm/xe/xe_pt.c:ALLOW_ERROR_INJECTION(xe_pt_update_ops_run, ERRNO);
> > > drivers/gpu/drm/xe/xe_sriov.c:ALLOW_ERROR_INJECTION(xe_sriov_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_sync.c:ALLOW_ERROR_INJECTION(xe_sync_entry_parse, ERRNO);
> > > drivers/gpu/drm/xe/xe_tile.c:ALLOW_ERROR_INJECTION(xe_tile_init_early, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_uc_fw.c:ALLOW_ERROR_INJECTION(xe_uc_fw_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vma_ops_alloc, ERRNO);
> > > drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(xe_vm_create_scratch, ERRNO);
> > > drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERRORALLOW_ERROR_INJECTION_INJECTION(vm_bind_ioctl_ops_create, ERRNO);
> > > drivers/gpu/drm/xe/xe_vm.c:ALLOW_ERROR_INJECTION(vm_bind_ioctl_ops_execute, ERRNO);
> > > drivers/gpu/drm/xe/xe_wa.c:ALLOW_ERROR_INJECTION(xe_wa_init, ERRNO); /* See xe_pci_probe() */
> > > drivers/gpu/drm/xe/xe_wopcm.c:ALLOW_ERROR_INJECTION(xe_wopcm_init, ERRNO); /* See xe_pci_probe() */
> > > 
> > > That is different from the patch you are pointing to because that patch
> > > is trying to add arbitrary/named error injection points throughout the
> > > code. However via debugfs it's still possible to add error injection to
> > 
> > When reading the patch I assumed the block/failure-injection.c was needed for
> > the knobs in sysfs/debugfs. But I see I was wrong and these are only needed for
> > the arbitrary error injection points?

Correct, ALLOW_ERROR_INJECTION() is sufficient to make a function error
injectable and controllable with the debugfs knobs. Arbitrary error injection
points might also be added using only ALLOW_ERROR_INJECTION() and extra
functions:

    static int should_X_fail(void)
    {
      return 0;
    }
    ALLOW_ERROR_INJECTION(should_X_fail, ERRNO);

    int foo(...)
    {
      ...
      if (should_X_fail()) {
        // error
      }
      ...
    }

But this would introduce a lot of dummy code, which the
block/failure-injection.c approach prevents.

Until now, fault injection in xe has mostly been used to test error handling
during probe and during IOCTLs calls. Errors are unconditionnally injected in
each function one by one during tests. This is why probability, interval,
times and space are configured to always trigger.

Besides, function-level error injection points have been a good fit in the
driver, hence the absence of arbitrary error injection points.

Francois

> 
> yeah. For working with ALLOW_ERROR_INJECTION() we have to refactor the
> code so the functions follow its requirements. When that is true, then
> we can simply use the fail_function/inject to trigger it.
> 
> > 
> > I see mm/fail_page_alloc.c has a similar approach with should_fail_alloc_page().
> > 
> > > the beginning of a function by annotating that function with
> > > ALLOW_ERROR_INJECTION. If a function is annotated with that, then if you
> > > do e.g.
> > > 
> > > 	echo xe_device_create > /sys/kernel/debug/fail_function/inject
> > > 
> > > it will cause that function to fail. There are some additional files to
> > > control _when_ that function should fail, but I'm failing to see a clear
> > > benefit. See this example in the docs:
> > 
> > Can you clarify if _when_ (in debugfs) allows you to access function arguments
> > of a given annotated function with ALLOW_ERROR_INJECTION()? It seems that might
> > be the only part that can be moved out of the kernel and handled in eBPF. Other
> > than that, I don't see either a benefit of using one approach over the other.
> 
> afaik we can't change the behavior based on arguments when using the
> debugfs approach.
> 
> Lucas De Marchi
> 
> > 
> > > 
> > > 	Documentation/fault-injection/fault-injection.rst:- Inject open_ctree error while btrfs mount::
> > > 
> > > Lucas De Marchi
> > 

