Return-Path: <bpf+bounces-70665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15754BC9A19
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA473A3203
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAA2EB84F;
	Thu,  9 Oct 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBwXgWwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221D2BDC35;
	Thu,  9 Oct 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021437; cv=fail; b=k4gdcQuY62jG+kQKInAqb7YqiC1gAYgdpyUzWywunUsG4XO/ii2Fj4xpOyrixTcJymALRbNEnpAjCe8UTCp3E85qGWUVNborXtJ21YbHZV2+1XjKRncpaU8Lo1H2Ixxosr0Ii/81ACcxRcYxkVOyGuT3hUX+O6gJLVOn31g5/ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021437; c=relaxed/simple;
	bh=LHGl6oXbur5d04tUdJFFXGdMefPfa/q44UxhNDxiPA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDdaqS6gxa3448PmoxYML88rU7wsEca6zBki/rL9wxPOfcwWZNXkygF9XrZQR1J0oT0BhjhX/H8OyIjWwoDaj2xM63PtOqo8OyXitDkRELSotwN6gjASMVoX6nuvbavur5QDb0Ni1Qr53pIETYjPt0w3UL5lYgJMYhe9ztIcqKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBwXgWwJ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760021436; x=1791557436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LHGl6oXbur5d04tUdJFFXGdMefPfa/q44UxhNDxiPA8=;
  b=WBwXgWwJkLYuCB1mrL1Nyzp6pEL7vl94006SCmk4h9qW+/PJIQjBKfUY
   iQLeEzNKpDiceV6vu2PeMsuGrBQY36zyxzvOCD255Mw+abY243xViueRy
   5phelrokpJW7Z1fNWftkyw6A7hvwI6DvxxWfE511P8ARS07kfIijXj+qm
   rU8N1aYEVOvmQYC4+0HP/gM/HZl/taK2Iuqd0ENk7Qlc29EoU3FWOp0NQ
   UpaYilWrVK3cXcIGv8rJhFKaNSpD+qP2EOTwhixDi7GrXYvnxAAXa0Lrj
   A7ytw3suYxAlFbcSp+WGdeML0agL0jUE4MREUXqq5opGYms519jDU2mjq
   w==;
X-CSE-ConnectionGUID: iARD2TZNQVCcJMtjlkP21A==
X-CSE-MsgGUID: +MBSgcEqTpaiQS0asY0FsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="84854307"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="84854307"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:50:35 -0700
X-CSE-ConnectionGUID: MzVembvfT9GUTVCnC6zfDg==
X-CSE-MsgGUID: wbDEew78QS26taJ4H5rpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="185858474"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:50:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:50:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:50:33 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:50:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi7cCrZdKOLDqUkLU/ur3nSSth7O1585vhQSCbhg8sUWI5ngM0ilEWypC8QjqyM6lzJ8/bHjKSqcfV4S7oF942GGyjC+zRDsn6ZvsZ6T/xfwL3tPvPXUsl/DAdmC5L7WwqjYQChH3sqM/pfoAK8Yjge2nO6eOhoxt8V07ir+pNL2B+O4rRDpCXOxtA0QFbnxHNHdacmp6/4Cn8MspU9HcCqIZPrQAAL7i5vojd1pIGKp3XIIn5B+Ixxomgi7wo6iLNQLl+62GhmdoxAlYy+opnt8BJif4tdXY3MD557sFVvbfxA8TLejRlKliDmQRllYkZlk4/3GUjwIjlX6kjQ6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQdbN4KpEUMJ8FjDroRqIjT36U9QFJhKHy/RG8Ya1f8=;
 b=kCxbUz9YI5Zk+jvhm8eQ+/WNze7OALcOzU7PbXQcRxh5W/NQwf8FRSrdks/HRpWXpOS/oci3XxeSG2b/KzL3A6efIFtA6vCebpZ7Nz6mPV790RDu0/SMR6wTjLUKumZBpNSp+IX+tpyNbGPVF+XaWIbSyyDnm/cTeqVxjMI3quFq/4cY5cr/QYfNBMBq/5QyXnpD4wLdlhMDPaWkggjCg94zFejLx4QJZfD9fYjAJht65bVwvMLhIth15Gvq5JVFp2ObJxHX2lJD6wSH3V2Y4EEi8Lqmpn2eD8WwlQN4QFavmr9AZ3OZXAYcLA4V97sdgNQzxzNqxrq4fKoXeFzQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:50:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:50:30 +0000
Message-ID: <984fe517-44e5-4767-a521-aad4891d5f2b@intel.com>
Date: Thu, 9 Oct 2025 16:50:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
 <CAL+tcoAWf4sNkQzCBTE8S7VgH12NPyqwiYDiig+jv0KGYAhFTA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAL+tcoAWf4sNkQzCBTE8S7VgH12NPyqwiYDiig+jv0KGYAhFTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0320.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4262d395-9a8d-4740-43c6-08de0743314a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUdOMHJRWStWbzBNWElLWDNjQVBHNzlsS0pRUk11bnJRaVdGWnovOTkraE5H?=
 =?utf-8?B?VFhCL0JISUxkaGxjb2hNeENtOTdRYUpWYUJLeFpsTG5XdFQ4MFp4WE9nb2Zn?=
 =?utf-8?B?WExXUjdJTnl3clovVGZ2YUhiTmhqZURnLzQ3QWVYQ2llT1hVelVyVThFYmw1?=
 =?utf-8?B?ckRyWVV1RzVGL0dQMVVEV0FLM3J3L2tYbzFKTjg3UVpLZFFsZzN6TVhncysv?=
 =?utf-8?B?TjFVL1BPUWtqYTV4QmlxaGdHS3pUc2d6WjY4QkRSM0tnT0wxendJTUtvanZE?=
 =?utf-8?B?bU9vcGs5QUVXMWFsWm1WNk04YUNvSDlrSU1UM08xMkhrbmVsNGFNSkxnV08y?=
 =?utf-8?B?Tll5TzVuWUdVQm5HK0RzTXBaOE1tWTVLY1FqZVJ3d293SHQxVUVlc3JodHpu?=
 =?utf-8?B?aTJjM1IyemY4TDMwTktIQkh4RG9vTEV5eEVPdDhjcTA2b3FJL0VwUUc3K0pR?=
 =?utf-8?B?RmMydmNGK25mNnRaVVlWVi81QkRNRHA2SEloc1UzUTI1RWxuZHN0MWpkR3Fy?=
 =?utf-8?B?VlhsZ3I3eitZZmNDRHJ0Z25BZndtZEliMUFNc3I5NTd5NG45STMydXpiRFNR?=
 =?utf-8?B?TTZVeG9JZEhxOVBwYk5QbVFPdytBQWtiQ3NrM2JydFZHbE5XcXMzWnNTMWN6?=
 =?utf-8?B?NHVaMzcwTS9nalRCZHRjaGMvbTA0UVVBU2UzYld4cFpDY21CM3FyNWZTcDhh?=
 =?utf-8?B?NFdvbTJJTWtQaWhKVlFONGlLWFVUeFlUYlFHZjRNUHNnS0NRNnRhVGdvZGd3?=
 =?utf-8?B?THg3dVlVUUxlOHc5K0RCWVo1Smdob1g0T1cxRjhNSVhKL2xCUFg4V1dtMDB2?=
 =?utf-8?B?MDg4NFhpNUNvNUt3VEg5Tm1zRjFUUlYwN0NWZThTUEtkOFFTWEpMMWlnUkdR?=
 =?utf-8?B?QVB4eTRoUmJ1U1l6UlhZSVFRaDc5ckVablNkcHh3ZkNTRE9xRlg4UC94ZXJ6?=
 =?utf-8?B?VSs5RDAreGtwaUxPMmtZQzlkZmpoOFN1UkU2aExZOUFQRXkzNTNqYVpGaWlT?=
 =?utf-8?B?cWFyaFpUMWozbWViTnhDWnhRREhTMjBobkFGcmo0a3Joc3hVNkp0WUp4NEcr?=
 =?utf-8?B?YlVQRnVxS1JPREhkZFE3KzBCUWJ5d0tnR01xV0Voa1pUTlVGL2IzbnFKVVQr?=
 =?utf-8?B?YjMzTEhlL256SFFvWTRMdjZnenNYdUUxRi9DU2FjSmVyRmgzNXlXb0Z2eEY2?=
 =?utf-8?B?WlVRZ2UvdlZuN2xEK1pjSW03VVh2ckx4Z0hxMDM5dFp6S0YzVVFKVHpKWEhV?=
 =?utf-8?B?ejIzK1h2ZGROOGdwMzRtR3Vsa1FaN1JFR1AwUlhOZm5tWU9WUnNFcFFHakxS?=
 =?utf-8?B?dCs0Y3RFQVFubmZ2RmRPTkNIVXFMTStzcGVWNkN1bUhCTlhsSjJuY3lFUHFE?=
 =?utf-8?B?NmpYU2hRUlphZTM1R2hIbm1hMmx1VXFzNVNFRXhaM2V1Nll6ZFF0cWFqc2p1?=
 =?utf-8?B?QnVjbTJUV3d3aDVBUGtDc0Jqcm5tdkFId0JvVWlVQWtkTmxnYjMvWFlONFpE?=
 =?utf-8?B?Mk5nWlh2bGhvS2U4SjBSM1lUeWNPdHhwamxWY1NvV0kvUmhiNzVSeEZrc2gx?=
 =?utf-8?B?VVZNVjNKdCtBZ2ZYQ2RaR1NGNW5SWmp3WktQOXZPSUFNWFRKdWZ0dFd6Y3BF?=
 =?utf-8?B?TmhmWjkrZDZsdEZZRGRMYkxQRHlUSENCeDV6TUVKazZGNzNxcDBhbzFKSng5?=
 =?utf-8?B?WnBNWTk4eFN4SFovVHpLeWEwUHBNdFlHN3UvVGRHNTVuWUVYUjEyOWJJTTND?=
 =?utf-8?B?MG9OdDYrZ3IwR1NqRUV3N2p1b0g1K0lQb3dsZkIwZERSbHpMNG4zM2RGc1g2?=
 =?utf-8?B?dUNNcWw2SURHM1duVHNFM0RBNWd3TkNRcTE4SEFrWkdiQ01sdVA0aFFCaGQ4?=
 =?utf-8?B?MFExV2tWVUF5TkI3QmQrOUROZTVidHBTUTYrbGxJNDBJVEE5U1MyL29OOHBD?=
 =?utf-8?Q?/EFGvmhkI0x0yP1ShTUS6S7qZiepBAqW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjcvTEpWNnRtcnY3Q0dxNWs2SUdUVEdCcWJPSnV1RWFRM3RPQkNiL2JMeUNO?=
 =?utf-8?B?WndPalVyRmplUVBNVTlsOUN1ZnRjbGprakVwTGR4QUNWZlRrWDR3Zk9sc05E?=
 =?utf-8?B?TUlENTRQSERDR3FBM1M2bEU5d0dDNnJjRkdJSk96b21NR3JWOVZUYzZBclVh?=
 =?utf-8?B?UllDY0JURnVQVHVzajlmUlZUSnVsZVdGQVNWZzM0ejExL0l4dVlzNHhHaUQ1?=
 =?utf-8?B?UzdjUTR2OXRUeVFHWnRuSUNtanBhR3ZFSVdKazNNckVmNnJOeTNGMEVpNUJp?=
 =?utf-8?B?QUV1SWszWjZsTmVuQWN3eHNjRGNNRVo4MmxaTDNrRXIzVEdidXZCT0RMaGo4?=
 =?utf-8?B?bnJPcjhhYmxwajByTG5Fa0J6TCtkTE9ydkJodE9ycEM1TGlWamhtYnpudndo?=
 =?utf-8?B?ZUovYzA0ZUdKclN2WEo2bm1TSjlVMGdMb05Hd0VTdVU0ZFlzOWYxNUpPaEpP?=
 =?utf-8?B?TjBlaUl2NXd1YUdydUd3NHdYU1pQSEkwVE9iQzJnVkhhQUpaTVdIeUNlTnc4?=
 =?utf-8?B?cmxGeDF2RUFxMm9Rb3A3QjZBVzNySEFPKys3Qk4vVVVMMWlIakVNRmdaWUVY?=
 =?utf-8?B?cmJJcHVxQTRWQ1ZEalU4YUJBVFJJQXM5SlFiSmEyTHBtUWoxdFpHWEFCR2NP?=
 =?utf-8?B?RVpnbkFSWjYzOU1JQVppeGNGUDBRRkYxak53bnVXZlZpdDIxMWs2ek1kdWpQ?=
 =?utf-8?B?UWNOV1VYS240UXdWTnlIdFU1TVl3SEZoTzZiRWVjd051MDB3Rnc0eHB1ZzZG?=
 =?utf-8?B?SHp0a0hTcHBOUkZkVk0rbm1PWXVuemgweUVZSFROVW9WdGhYTUI0WDJ0Nnpo?=
 =?utf-8?B?OFZxSExzS0xIbjZiTWRPOHNHVFBJQUg0QW9ZYkFKV2hKN04yc2hQdVY4bWxn?=
 =?utf-8?B?VlJpeGlKd1RmeFc0Qlo1cDBaWHlzdWN1WmxZdW5QSzg5QXdoMnM3SDBESEJy?=
 =?utf-8?B?c25ETGZOM3JXMVJsc3NaOVhFTjVNNGpkdmgrVjh4M1lDYTJMdkxxVzRReWVs?=
 =?utf-8?B?Yk5OeWVkUEhkdC96UUM0VXZBQTcvM2FFdW5SdEx4VzNVNEFZbUd2b3k3dUY4?=
 =?utf-8?B?TUgycXVoME5KWmVtYm5qT3c1QWRraTV1KzRwSTcvRjB6eUZPM3RmWDFRdncx?=
 =?utf-8?B?dEprVS9NZXpQcklVMFZWanRHMjR5ZXhyNGNDRXNwa2tzUVY0RHdEYXlsd0pT?=
 =?utf-8?B?RlQxZThFSUp0MG1mb3NoQno3blFhb2grWWZWdldCRkZ6ekxOV1h5bEpYaTVZ?=
 =?utf-8?B?M0t5RjZWZkVaaUVkQ1JhQkVjR0VtTDRKSExlVlcvdnc1dEllSkMzNkdFMERl?=
 =?utf-8?B?Y1gwbjU2K1JjYnRRUFZZMElTdlhWVnEzRGRHT2ROM0M0KzRRaStwQmR2cThl?=
 =?utf-8?B?RnFMWnB4S1hpSXZGbkREeUFOTzBaV2o2UlY3NE1BTHVzY3Y3WllVU05wd2Er?=
 =?utf-8?B?ZEJWSzhZNENFRTJZbS8wYXRkSHo5dHdoblo1bEJJaEZPZnJ0cGVBdWhYWnlR?=
 =?utf-8?B?ZURmSWtZbUpiQkZzeVdRM2xDTUJzUTRHRTdOMU5IWEZsT08xVHBkUFNYcm9y?=
 =?utf-8?B?ZXpBUEtKdndDV0l2dzRQRE5RWHhGakJwU25pMWswYW1rMmdFN1RWY3A1YnlE?=
 =?utf-8?B?akx5OFJWZmF0MGFtZTRtOXA2WVVIVURNVXJjV3hSVnh3OVJ6S3lVRERrVy9s?=
 =?utf-8?B?bnFvSDhxdjI3cEFxV2c5dGJzZWFCZ3ptVEF1TVQzdVg1VndjcWo2b1R1WDFO?=
 =?utf-8?B?VEtYUVF1alRPaGdRTGgxY2ZMTUxBOWtQRGlqVVF0eDNwR0tVeUh2SUNUYnF6?=
 =?utf-8?B?ZCthSmhRbFg5WTVENjBtQVBWQy9jc2MrSWkweE96bWRoVWEzR1pqb29lbzRE?=
 =?utf-8?B?SDNCd1k2cFhPR29IYnhxZ0JyS0V6VmRwRFU0RXFNTVZCY2NrWElVUjFNQTZm?=
 =?utf-8?B?dnlXUlZvSWFGU3g3NndjMXRkSS9VNDFTVXl3bXVLR0JzU1Nqb3VuVzNnYXNE?=
 =?utf-8?B?SUNCUUJ6dENVV3FFeXgrYWZ3NENTK2FTUlVZWlZFc0cxTmhUYWZSZ1MvZENq?=
 =?utf-8?B?Q01yWE43L3JkY2w0aTNadVNWTk4rSE1zWW80Y1N5alp3VEdKREpVMGxLRlJv?=
 =?utf-8?B?aitJYm1MdmdDZExURDBnYW9rRTdkQTJXVk5SNTgxZHVPL2hPU3UrUFYwbmxY?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4262d395-9a8d-4740-43c6-08de0743314a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:50:30.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZHroyoyFhtIftyXzndmT91iKWbEDZrF8i0LjVlx4C2EkzOijS8bGEAB2YWxg+wwRZG2RENJLh6LWxfXIpmb2Q5hnHCLh0cI1Yx4RxtX/Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Oct 2025 22:02:23 +0800

> On Thu, Oct 9, 2025 at 12:59 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> Turned out certain clearly invalid values passed in &xdp_desc from
>> userspace can pass xp_{,un}aligned_validate_desc() and then lead
>> to UBs or just invalid frames to be queued for xmit.
>>
>> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
>> can cause positive integer overflow and wraparound, the same way low
>> enough desc->addr with a non-zero pool->tx_metadata_len can cause
>> negative integer overflow. Both scenarios can then pass the
>> validation successfully.
>> This doesn't happen with valid XSk applications, but can be used
>> to perform attacks.
>>
>> Always promote desc->len to ``u64`` first to exclude positive
>> overflows of it. Use explicit check_{add,sub}_overflow() when
>> validating desc->addr (which is ``u64`` already).
>>
>> bloat-o-meter reports a little growth of the code size:
>>
>> add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
>> Function                                     old     new   delta
>> xskq_cons_peek_desc                          299     330     +31
>> xsk_tx_peek_release_desc_batch               973    1002     +29
>> xsk_generic_xmit                            3148    3132     -16
>>
>> but hopefully this doesn't hurt the performance much.
> 
> I don't see an evident point that might affect the performance. Since
> you said that, I tested by running './xdpsock -i eth1 -t -S -s 64' and
> didn't spot any degradation.

Thanks for testing!

> 
>>
>> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
>> Cc: stable@vger.kernel.org # 6.8+
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Thanks for the fix!
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
>> ---
>>  net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 35 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>> index f16f390370dc..1eb8d9f8b104 100644
>> --- a/net/xdp/xsk_queue.h
>> +++ b/net/xdp/xsk_queue.h
>> @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 options)
>>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>>                                             struct xdp_desc *desc)
>>  {
>> -       u64 addr = desc->addr - pool->tx_metadata_len;
>> -       u64 len = desc->len + pool->tx_metadata_len;
>> -       u64 offset = addr & (pool->chunk_size - 1);
>> +       u64 len = desc->len;
>> +       u64 addr, offset;
>>
>> -       if (!desc->len)
>> +       if (!len)
>>                 return false;
>>
>> -       if (offset + len > pool->chunk_size)
>> +       /* Can overflow if desc->addr < pool->tx_metadata_len */
>> +       if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
>> +               return false;
>> +
>> +       offset = addr & (pool->chunk_size - 1);
>> +
>> +       /*
>> +        * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
>> +        * (pool->chunk_size is ``u32``), @len is guaranteed
>> +        * to be <= ``U32_MAX``.
>> +        */
>> +       if (offset + len + pool->tx_metadata_len > pool->chunk_size)
>>                 return false;
>>
>>         if (addr >= pool->addrs_cnt)
>> @@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>>
>>         if (xp_unused_options_set(desc->options))
>>                 return false;
>> +
> 
> nit?

Yes, probably doesn't fit well for this particular fix. I have no strong
preference and can remove it if the community wishes.

> 
>>         return true;
>>  }
>>
>>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>>                                               struct xdp_desc *desc)
>>  {
>> -       u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
>> -       u64 len = desc->len + pool->tx_metadata_len;
>> +       u64 len = desc->len;
>> +       u64 addr, end;
>>
>> -       if (!desc->len)
>> +       if (!len)
>>                 return false;
>>
>> +       /* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
>> +       len += pool->tx_metadata_len;
>>         if (len > pool->chunk_size)
>>                 return false;
>>
>> -       if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
>> -           xp_desc_crosses_non_contig_pg(pool, addr, len))
>> +       /* Can overflow if desc->addr is close to 0 */
>> +       if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
>> +                              pool->tx_metadata_len, &addr))
>> +               return false;
>> +
>> +       if (addr >= pool->addrs_cnt)
>> +               return false;
>> +
>> +       /* Can overflow if pool->addrs_cnt is high enough */
>> +       if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
>> +               return false;
>> +
>> +       if (xp_desc_crosses_non_contig_pg(pool, addr, len))
>>                 return false;
>>
>>         if (xp_unused_options_set(desc->options))
>>                 return false;
>> +

Same here.

>>         return true;
>>  }

Thanks,
Olek

