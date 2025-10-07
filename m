Return-Path: <bpf+bounces-70513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E3EBC1A7E
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2EBA4F6FF3
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148B2E1758;
	Tue,  7 Oct 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfEV3QR8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A61CF96;
	Tue,  7 Oct 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846105; cv=fail; b=aLIqMc/ryhfu/y8+a5Z9sZbUXp1t3sPsSJMVCFJLG/4lR+FYQaDQomXY9Q/8KXTjHOowoMZ1rN5LYqaTm/nAQc5Thn8LNGmRBliYFjmebIgTCfNl46CyrgqRMxTZi9F/fLwwCy8DRkT8gY3kTYe55JZM6dJAouyOXu/zP/lAY/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846105; c=relaxed/simple;
	bh=msaiTSL8XBl7U6bbebC+JhPUi3HoaJFICAn8tyk5VV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XmS7KRHiNiG0fKuL6++ZgLSNbzLg8hoie+2U9K5jvqzS6XnVEYQr6LqLNFQoHduXgBnAWwuOvvr+xvwhfEvhG3L7zRL5wVqHAQxPLveFtL9LOIY+Ut41Wz7fwU8Wn04929jQeWNxPKNTzn6pdUz2uvLVgjKrAlzrY3LHz+JYQpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfEV3QR8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759846103; x=1791382103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msaiTSL8XBl7U6bbebC+JhPUi3HoaJFICAn8tyk5VV0=;
  b=hfEV3QR8FjWiswYV/Iy5OFpD/nGo16ycFRYAO1vPj544jRXpZApEhq0H
   1cRKbjxEXqy1R9xmsCk0iMqrrdxl+vVyZI/WpkULjqRl8lUoVbPpRudVc
   7kO5XsRYZpgimZ8oH0hRAlR22MP03j+nZsU5x3GFMxPnCVlGNnQivyeiz
   W8JPxDLaptz2iCfB5+uE13qwNzooKoMGOIT3zG8WvD8K+0QmBi6TcwNjH
   Dgfh7ntOxOqQZhkbOVKE0hJF8Fcs9PAxx2zprmTVWcFd5gSPxv3q74/th
   aK0rETlBSkRnU+dKhQP1C1M+uaSyqArjl6ZlctFfxrEOU4y51G1OcGRi3
   w==;
X-CSE-ConnectionGUID: rGNliwCxTf2uGFeQhNbFCg==
X-CSE-MsgGUID: COz1YgOGSQW32vjk4Lw9wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72641201"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72641201"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 07:08:20 -0700
X-CSE-ConnectionGUID: JZ85SVhhTT6ptetoMJC3Og==
X-CSE-MsgGUID: MJG0jm0ZR7aS5y7FZs7xEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180577926"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 07:08:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 07:08:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 07:08:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 07:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OumAIBP02nq9Ljp8dAXUJGnkJOYDh7gGuO9u3/WZcAnv0v29aLFCygViORWE4Qah/BJMpnzasKfa9pLDaLWacpiv4ZTDGzy6w8aLSQTX5NZjnsPfZweQA82LxHVRod41IcXgrQS7WZWenE2/TFAdMDtewbV3FIrbTcAi8h8O32/dwsyxUk/rvH04g6B9oPEg1l05j+XYo1WtKE4N376MYw+raCegCu9FF2iwiLdKT/CYRvV0gwdZ6PtA/tyfW/dwyzydXjmvqE8HwHFgmuRsglGL04mSOFZtJ5+S4KG7Qdld6MXv3+VvPdM4aVcXCPEE43QLJYMwQRHcwilxRU2/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSIWCEeCh3rQc2zOKxvZFbfsnk/6cmAk0fnwsmS1WEs=;
 b=kbgAjzJr6y9cXnVOoMnQ6/QpNLu9WVJJEb5eCtUCinLLkPY22LMGuZ989mj+bsCe1WNJwkBm6kLd8rC2kQsx5djsGr82Cu31LH3VZD6ozPLacZ8U9w1qVT16n6xUgUW3bZwr0tBDSiBMm+96d+d42q60XByf/+UcbTxNKzRjyI/hyHlNvJVkuiuJ4V66PCxZMLnIT+wSAAePTURbWiWXdVwNtYbKONxDr1zPII6mhv5NPBRMrFkDpEPMGacNguGX38vQ1wwPIXN406hkC5uOQElpLrXKDp1t3bpGSDWgusRN86dA10nqnz/7EPfRYbBNMTJ8snstu7ZhBgfEfeGOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 14:08:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 14:08:12 +0000
Message-ID: <15de0caa-48b6-462a-96bd-15c2424d0bff@intel.com>
Date: Tue, 7 Oct 2025 16:08:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor
 validation@@
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
 <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
 <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
 <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
 <914ddb6c-79ca-49c2-82b1-33be1986eff5@infotecs.ru>
 <CAJ8uoz3CeFdAuOd6mjnMBDW45KcY-CQoOUxZt7PB_xAONVYD4w@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAJ8uoz3CeFdAuOd6mjnMBDW45KcY-CQoOUxZt7PB_xAONVYD4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bab3a9-2ec7-4d85-3ea2-08de05aaf35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blJGeHFHQW44N1k2VDJubGR4eXhBQWNDZlFkM1RralV5MEZyV0ZVWURlYmVI?=
 =?utf-8?B?Nk91dGxkNmlQNnMrajB0cDdGSmI3NjZzVThuVmJBUkdXSmdybmJRS2RoN241?=
 =?utf-8?B?ekZ1UVdmdEtFNzlmR2Y1UDhZYXVuNmJBL0RmOUVNSW0wS3FwazFUVDRtbW9I?=
 =?utf-8?B?UDJiSFI2VUJSYnlPbFozUmpHcFVlR2VLR3ZpSDdnZU15WjBYUlNqd3FDdlNH?=
 =?utf-8?B?Z3FTMFlCcTMxSHhqVHNrTTdYMXRQRGI0SmQ5QnRzQndNRkFxUlVHVFhNODN4?=
 =?utf-8?B?SXhCN0ZDSlpnRnJMSjdxcWhHT2pCS3BkeVVoVlNlT09QVGhtcUlWYnFDUGxG?=
 =?utf-8?B?ZnhoVGNoSFM3QzdEQTJvcTlRNlJCOENoTGxpd05KQmJpQVNIcERkUkp1clpS?=
 =?utf-8?B?YVdCeWpCTVBwR3J5SzJZZ3prcTNSY0k1Q3JzeWhEZlFmb3k5WnBvUGd2VTVH?=
 =?utf-8?B?MkZaaDROVk9MdmNudSs0ajdvUFRpMXJtUWhPb3hEZG55T05rbFgzR2tJTGd1?=
 =?utf-8?B?MWdVbmdlWTh4K0dZSmpULy82K29Na0NGNE9SbmJRajhLV1RvengvVzBFWFdL?=
 =?utf-8?B?RHJ0T3NXS29PYjA5RWQ5STRTNDRkWHpPZDZyU1poZGx6ZkZQMDczakpGcWw2?=
 =?utf-8?B?MHFJMWZ6Z2FkSDZPbzR3aENjaVIvcEFWdkEwdEZibmtOR0l5Kzg5VTdhK3cz?=
 =?utf-8?B?cWZFTkZ6aVVycDY5OEFUdkpDN3pyd0dtWXpieG0xZ1h4S0RheFRWS0FncDhB?=
 =?utf-8?B?dXVjTUMzS1FsNTBkbHVnd3dwYTVoWmltVEJ2N0ZzMUhSTnd6UU03YjdRMGlY?=
 =?utf-8?B?VWdjNCt2UWpTWHNwZzVZeHAzZHBnV201UlVkVzdDNEd4SEtpRmxQdzVST21V?=
 =?utf-8?B?a0tETFBrdUFGVzRiVnVNVzZzSlViVy92UHZxaWFENlhRL21mT0tienJqQkg2?=
 =?utf-8?B?UnpBWXc5K2lmRVlOSmRvQkN0K3lHMVBpSGJIbVpFMlJva3Vockc1V2NCRjNY?=
 =?utf-8?B?ZzB3TmRZdW1ScjNKaVZNMVBvcC9pSDR0RGZqUzRJdCtlODV4ZDg0WXRDS1Zn?=
 =?utf-8?B?Q0JMSmNnNW4wVEc5bWEyTnNpL0pMZ2RzcmEyclZCeFozV09VckVBTVV3THBz?=
 =?utf-8?B?VmxkMjlwaWpZYUJvcERZZGhHdWZpU1NSRUk2dkJRd1VMa2F2N3ZoTzZlVHIw?=
 =?utf-8?B?WHRvclNtTmVLQjBocnNRRWpkNDRJbWR1SXYxbUIxOStUUHZ6QVJvL1V0cGNC?=
 =?utf-8?B?ZmRRVWJvZjVzbHBidFJBcHRJZ09nMlZMY3k4OXdTREFRWUlhbmFRZTd4N0Fi?=
 =?utf-8?B?ajltaTFPSUxIdXhPV3RMaDB5OURGUStYK0cvL05PY3NsRWpSSE9OMUlEaDFs?=
 =?utf-8?B?aEtVRTZjVEM2T1p4S21leE1sYm1TcEFIaHp0OUR1TTVNZXYwNE9CVVBDampS?=
 =?utf-8?B?UTRIRWJSU0hYUmVPYW5RNDBreXc5TXVYaEtIbzdXc2pJWTRFNUJ2ZzlQZjAw?=
 =?utf-8?B?d2krQ3MvM0djbGZYWm9xbmcwajZONFkzL1J3TjYwREtaeUlSYW9pT2k3dEJL?=
 =?utf-8?B?dGxDMFhJQVZleTJkVEVRT0w0cFFuTHNiSTdkaEEvQVZ6QlpTblV2SE1nWXZj?=
 =?utf-8?B?VlhXRGNaS3dYOFBZOUJ0NjdIYnU3am43R3lRaHRVd1lPRWo0NVNXNG5xNmdK?=
 =?utf-8?B?MFJmY2t0VmlQM1ExbXJmdi94T3JIMUtJaTVldElSZ3E2dVBmRHhkZFJiVWpt?=
 =?utf-8?B?RHpDSElxejZmVTRuTEpKbm5hQU4rS1ZlSzJWNnNZNTFJNXVITUxhYUNRdGxI?=
 =?utf-8?B?c21VaE1DSko5a2FtODB6NGhobXZJNWhXRC9LTTRGZ0xoc3hoWG9WalZtNFMx?=
 =?utf-8?B?UG1zejVVaDdnc0t2bUZDR2g0aTc5VHFDQXNYQmo3NEg0M2c5cHJzcytyY1I4?=
 =?utf-8?Q?hFDc1QXHZTjxncoQ0XpHzMBMkf0hWKXG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGlBRUp3VzFUWXZXNld1TEFtZkhGRllIWVAxWFV6SXEybm5MMTZzaXlNSnFs?=
 =?utf-8?B?djlITjUxNUtXeVBsSCt6M0tyMjJSblN0RWJuc2dqRjZ2emQ5YS9ldGYrNmJW?=
 =?utf-8?B?UDNLWVdXVGttUGhvMWtWVlpoWWV1QlVuUk1hcTkzWHBSMjVmU25CS0VBZXY2?=
 =?utf-8?B?NUQydTBFU0ZpZEg1dXlLUlk5V0dPdGJuc3RYUlMwOTVJYktrVXNVSGh6L0tM?=
 =?utf-8?B?QVJINTNPa0lONlM0UXFEWCsxa3JWZUpJM05Yb25Ic0Z6R0dkREltazRHbWx5?=
 =?utf-8?B?eUFWVS9yaUNFSVNtT0kwczR2Zlo4dEpHMkUxbmZFWmlJVW5neXIvTFhDcEtn?=
 =?utf-8?B?N2xHQ2VjLy9YK24ySWxGZE9kNlV4NHh5NDdWVHdCZm5ZK1RjNlQxalp2bFpv?=
 =?utf-8?B?cnpEZUM3Qlh1MmZVZUFxVEVzY1hCUmFkOXM0Um93cTI5aTE0V1pDUTdMQStX?=
 =?utf-8?B?Z1VhWHdSc1ZMNkxJSFQ3ZGQ1Zlc4UDgzU0IySzhhZkl5akJmOEtRU2JUdUxG?=
 =?utf-8?B?bE1RalFSZFlQdTJJMkNYbmtSeXdkRGNPck91Q3VUM0kxdVFxTjNpZFBJUUNX?=
 =?utf-8?B?bStXV2lqSUxERTFyVFVxQVcxU0pVTVV6aVN2MVNQWndSWTd1aHV3dWs1NTEy?=
 =?utf-8?B?Smd5QmxqcSszTDRiWXdYT1JGc2cvOUpveEZ4cmtZU3BjRkdsck9BaWRPeUJa?=
 =?utf-8?B?aW1PaVAxZUlxS20vM0hzNlZiZ2FrS2dmWHVtOHM0aTlacGlGelNqOXhlNGsz?=
 =?utf-8?B?NDhsa0ZNbERXbjdqTmE4ZTBoVEVFQzlueVlzQ2NvUk9sTXk1SVhkYlRQaEVS?=
 =?utf-8?B?cG1nQlprMzBkU1pJRkNRZlhPdmcveHZ3cnhzMFVFT3N2RW56RU51cjVHSHI4?=
 =?utf-8?B?czRPVVRlRVhEU3pSYkNYWmlFRjFsZDVXNGpOc3dmdDNmOGNOS2p6U0dmYXNw?=
 =?utf-8?B?UEs5VWx0Qi8vSDlEanZBQkltenIxdmNEK3Y0VlVSQVRneENQa3VmUW9Oam95?=
 =?utf-8?B?V1dLM2FIVGhDQ1VQMTZXWFpRdnE1TVk5NTRPUmJvMnZZNVZVem1tUG1JbThr?=
 =?utf-8?B?aXVSRVNLak8vMnliK3orR2hxY0dXczZ4b0RTd2Nod0VXa2VENW5SY2U4akQ4?=
 =?utf-8?B?dG9LY2hHdmh0WFloY3pRdHVCQVlnSEJDSVJpR1NpT2creU5zYjF1ZFdLVEVN?=
 =?utf-8?B?a1ltcEI2MzJxNUFoRDNRTmRBYkV3b1ozb1NBRnRweWh5UW42bERXL0FhblJW?=
 =?utf-8?B?ZVlvVzdjOWVYYTRnSk95ay9UUzgzTVFmamFlZ1NCTWlkZ3RON2xSbG9rNHM2?=
 =?utf-8?B?K21kNFRnaG11S1QxM1Y2OWQxbUhPaHZhblV3M2pyMjgzQitDTTRmU2hjRGEv?=
 =?utf-8?B?RjlBcnRWWTFRZi9saGt4UE5QZHRwZXc0TEs2LzVhKzNwdjJGU1g2V0wwUlFT?=
 =?utf-8?B?S3FJdDZicXpmZlM5eWg5Vk8wTUxRdmJsdXAvVnY1Q2wzaEw4ck94SUpzTGNY?=
 =?utf-8?B?ektzNll4U05kaWZ0REdvc2htK1MzajB3b0Z3UzVVU1NjNllaRkxyeUROd2U0?=
 =?utf-8?B?Qm1EMk1ZK3h5K3ZUQnhKNmdXQktqMW1lWUVrTGpCZ3o0UDdOYXE0R0lqSmFZ?=
 =?utf-8?B?ME5mUEQzSjNPRVdwQ2dQSisrYTYwUDEyVGRXT1lsREJhU2pHOTFra01PS3Bs?=
 =?utf-8?B?SnBDZjFmREF3VzloS0NnM3M3bVRGVE9qcWFaa2UyMi9hNTNvak8ydzZldmxo?=
 =?utf-8?B?SUlSRk5SV3VEYVUyTDhSM21KMTYvNS9YN2hDeTZjVHRuV3JxRVpLLyszZVNN?=
 =?utf-8?B?bmNqZUY2YlNZcEkwZzNibWxoOWNzNjczVjNwT2FmMFlxSTNYbnd4ZndCZWww?=
 =?utf-8?B?Yi9LeC9JS3duNWxpUTNIalpER243T1JuSFAwOWFVRmx5MktEWmVzamhHZlZp?=
 =?utf-8?B?RDFkSUF5S2h4WVFBS3k0MWFGdU1sRFFZSVhqckQvU29DcWRVNktqMzkxWXBk?=
 =?utf-8?B?ajY1TDkramQzMG8xM1R0QjZSbHErUWFhdjMyaEFLdHl5ZmY1M0t4ZjFiT0pN?=
 =?utf-8?B?VkppV1JtUGRjaHlpcVBqNDFPRW45bHRjc0NmbzF3cjZoOGd3UU9WUlgyOCs3?=
 =?utf-8?B?Rk1SMWJIMnFSRFBwN0U3R3hQVU11SWNPNmEzb2VySjdlZlhuQ2QxWEMxT2F4?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bab3a9-2ec7-4d85-3ea2-08de05aaf35b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:08:12.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGOZyjrQvq3EKdmIggvzhDiS836wPtBlkQRd0odf0Ti9nZcK9aOfaGrzWa+NnKs3YdgNnbcQ1OtjC5AYqbnfgQ/eWEib9jzo2bJsgnDCf8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com

From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 7 Oct 2025 15:52:52 +0200

> On Tue, 7 Oct 2025 at 15:34, Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru> wrote:
>>
>> On 10/7/25 15:44, Magnus Karlsson wrote:
>>> On Tue, 7 Oct 2025 at 14:11, Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>>>> Date: Tue, 7 Oct 2025 11:19:19 +0000
>>>>
>>>>> On 10/6/25 18:19, Alexander Lobakin wrote:
>>>>>> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>>>>>> Date: Mon, 6 Oct 2025 08:53:17 +0000
>>>>>>
>>>>>>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
>>>>>>
>>>>>> In theory. Never in practice.
>>>>>>
>>>>>
>>>>> Hi Alexander,
>>>>> Thank you for the review.
>>>>>
>>>>> It seems to me that this problem should be considered not from the point of view of practical use,
>>>>> but from the point of view of security. An attacker can set any length of the packet in the descriptor
>>>>> from the user space and descriptor validation will pass.
>>>>>
>>>>>
>>>>>>> option is also set, then the value of the expression
>>>>>>> 'desc->len + pool->tx_metadata_len' can overflow and validation
>>>>>>> of the incorrect descriptor will be successfully passed.
>>>>>>> This can lead to a subsequent chain of arithmetic overflows
>>>>>>> in the xsk_build_skb() function and incorrect sk_buff allocation.
>>>>>>>
>>>>>>> Found by InfoTeCS on behalf of Linux Verification Center
>>>>>>> (linuxtesting.org) with SVACE.
>>>>>>
>>>>>> I think the general rule for sending fixes is that a fix must fix a real
>>>>>> bug which can be reproduced in real life scenarios.
>>>>>
>>>>> I agree with that, so I make a test program (PoC). Something like that:
>>>>>
>>>>>       struct xdp_umem_reg umem_reg;
>>>>>       umem_reg.addr = (__u64)(void *)umem;
>>>>>       ...
>>>>>       umem_reg.chunk_size = 4096;
>>>>>       umem_reg.tx_metadata_len = 16;
>>>>>       umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
>>>>>       setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
>>>>>       ...
>>>>>
>>>>>       xsk_ring_prod__reserve(tq, batch_size, &idx);
>>>>>
>>>>>       for (i = 0; i < nr_packets; ++i) {
>>>>>               struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
>>>>>               tx_desc->addr = packets[i].addr;
>>>>>               tx_desc->addr += umem->tx_metadata_len;
>>>>>               tx_desc->options = XDP_TX_METADATA;
>>>>>               tx_desc->len = UINT32_MAX;
>>>>>       }
>>>>>
>>>>>       xsk_ring_prod__submit(tq, nr_packets);
>>>>>       ...
>>>>>       sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
>>>>>
>>>>> Since the check of an invalid descriptor has passed, kernel try to allocate
>>>>> a skb with size of 'hr + len + tr' in the sock_alloc_send_pskb() function
>>>>> and this is where the next overflow occurs.
>>>>> skb allocates with a size of 63. Next the skb_put() is called, which adds U32_MAX to skb->tail and skb->end.
>>>>> Next the skb_store_bits() tries to copy -1 bytes, but fails.
>>>>>
>>>>>  __xsk_generic_xmit
>>>>>       xsk_build_skb
>>>>>               len = desc->len; // from descriptor
>>>>>               sock_alloc_send_skb(..., hr + len + tr, ...) // the next overflow
>>>>>                       sock_alloc_send_pskb
>>>>>                               alloc_skb_with_frags
>>>>>               skb_put(skb, len)  // len casts to int
>>>>>               skb_store_bits(skb, 0, buffer, len)
>>>>
>>>> Oh, so you actually have a repro for this. This is good. I suggest you
>>>> resubmitting the patch and include this repro in the commit message, so
>>>> that it will be clear that it's actually possible to trigger the problem
>>>> in the kernel using a malicious/broken userspace application.
>>>>
>>
>> I'll add the repro from this e-mail in the next patch version,
>> the full source is too long.
>>
>>>> (also pls remove those double `@@` from the subject next time)
>>>>
>>
>> ok
>>
>>>> I'd also like to hear from Maciej and/or others what they think about
>>>> this problem (that the userspace can set packet len to U32_MAX). Should
>>>> we just go with this proposed u64 propagation or maybe we need to limit
>>>> the maximum length which could be sent from the userspace?
>>>
>>> I prefer that we do not set a limit on it and go with the proposed
>>> solution since I do not know what a future proof size limit would be.
>>> Somebody could come up with a new virtual device that can send really
>>> large packets, who knows.
>>>
>>
>> The limit is already checked in the xp_aligned_validate_desc() function:
> 
> What I meant was, let us not introduce a new limit. I like your
> proposed solution.

[to Ilia]

The netdev and XSk maintainers prefer to fix this themselves after a
quick discussion.
Let us take over this topic. Thanks for finding this.

Olek

