Return-Path: <bpf+bounces-75320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DE6C7F441
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3988B4E25B1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF32EB873;
	Mon, 24 Nov 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MbZc+8t4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZsQlIi90"
X-Original-To: bpf@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE722D7A9;
	Mon, 24 Nov 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970814; cv=fail; b=mWkpf6fjkOi61FFYwk9eVhWQJWepLVmYEoEcr/YZJuLbZlyM4/1/eEgr9hnPddIMh51kuB9A0vHQr8zqyCPuaFxkkQ/6tHAbsN0md21lGe84aqSkXu1GKC4eVy/IMYYsFk91eAHdggblXpdxsA7IZR3jGjEUY0CQI4DJzMKBiJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970814; c=relaxed/simple;
	bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVSHhAHRrVoJlqd+P4oHXdcgswcFcNPF1YrHtJRlf/rCMcSPXRNsOmdjTqU2+zE4NTrQSond7nb9rNIHAEEHHekYF/mvhIZWeqwGCJC0pYlR+3fhb9GMi1F/J/6bDfHkE+V1a6zfXexctHPnSK9jDE6bMjx/9RBI7rTcfQsPGaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MbZc+8t4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZsQlIi90; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763970813; x=1795506813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
  b=MbZc+8t4HrWxeecQktdHkyE3h2ZV3G8UzdBYKF9Bg/gKoapy520VRXf1
   xm7i9NG9cJWpB5bwKFLpGWEJ9ssf5UvzMu+N2Z5kIxUyQAd6IMaW9SzA7
   YfKi8uI6iQERG2xeOs7uA1IWL+t2UaBROeq+LBvLE85NpVhrDwEm8iT5t
   O8cDPBXjC+Jskbk76a31X7dQenfWg2VtCz5y7pHFgWpHMlcQc4isxjbi/
   aKnmk1K90K0V81xgAvbMxg2G1tUozfAkxhhoOjn/KgF+2TUxh5ays6RLX
   tg2s2SHgQWpbm2P0PpVAFAJ/6DIHurd/hD09dH4SnMBUTZfnQC5Q0R6fe
   Q==;
X-CSE-ConnectionGUID: OX81HUf4SISpiWlBZ9y58Q==
X-CSE-MsgGUID: /Ow9qk2ATVOglo19w69dtw==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="136608908"
Received: from mail-westusazon11012059.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.59])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 15:53:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjAyXY8hz1b3vUMRObSocaWuNh5lw9jTDjzbcTI+vvZMCargIFA8HQyN7ZgwAe+SR2UvfNjowVkr9B/+Ym644KyamQjVUCJnd53kdGlJZQQXKD+QpS3ZkWyOdd9SoRQ6bMXGUdzgH0eGEn+w0E9VXluKoywb6j38esEGtT4LNB9Jqxki3L/fRraPWDrrVGs/iuapVlxck1kflU82MQk7lef/UfQ/LH0PEf0nDROlHS97ftARjBBx4F0/fsQPtcwaIp+WM5EUKcw/tTUrM5P3Z7u9e1ozxMvmymhewbevlI8nqnRRE+MvC0QsuSE+dg7PMPTl1gG44FUNezh775kIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
 b=Lzb9K3jNaIyLDsIWoOOTaCKVbQcHXT+FRUPFTUrtJcFznOD5xkyMFRMxoooza2gTpAWsyIzJ6W6gyW0H40X9w+hrxTkd5gRCYN9lQO5XvhL+0wuP4Gsn35yXvAP4k0W5ROO15Ghwy+frsw3/T40nO0MbYLHebEtc9d95zvYVusbZhDd+FaCqsdcxmblcWbcYBzjdZAbRu0R7YvVRS/eh6mObDUxwU2G4BbwF/COnpY2jfdCAJHU50xVAJ2ZQ1hjcpZmj1MukHsDHJNFL4pbgWJnSm8CwyG6KRghYa99WwTwdYD7RXW1TuEarnBylSe38E7YQqo5dQnnOhFhvwAhC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YW1uuXnDntCl31Iv3xSCDomdDENuAx0EqwAh8B2LDs=;
 b=ZsQlIi90Mvkre/PmMtzWjMe0I+c73kf8O+grzJNAgyrr8d8tCZLmUpL2zzWwfE2TdLV6JSvDaEDHI9jMilaHKkObHbaTT0WfphE2+J+tJvGEomSq9qSK94UOqor3ZRnRJBzalFJRmzE3MHTPzxL3rucSUUMzsfkJzOH15DOm+VQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7288.namprd04.prod.outlook.com (2603:10b6:510:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:53:24 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:53:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
	<snitzer@kernel.org>, "mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>, "yukuai@fnnas.com" <yukuai@fnnas.com>,
	hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kch@nvidia.com"
	<kch@nvidia.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>, "cem@kernel.org" <cem@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
Thread-Topic: [PATCH V2 2/5] dm: ignore discard return value
Thread-Index: AQHcXO4vrmBXkc7TXUW0PzYu9kO4TbUBdPSA
Date: Mon, 24 Nov 2025 07:53:24 +0000
Message-ID: <a0dc01ea-246f-45bf-8ec3-62ce44d76b05@wdc.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7288:EE_
x-ms-office365-filtering-correlation-id: d9f930cf-6fcb-4435-e347-08de2b2e8b89
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2p6L3JsU0owcHVmRHRLZExQSWY4K25LRHhXTnFjSTBQN09mZTcrVUg1dVVF?=
 =?utf-8?B?eTh0ZTdkWk1pK0hCUklEU1BqazJETWN3WVdieGs3R2c0LzhpN09rSk5qWndt?=
 =?utf-8?B?L1ZiN040N29YRkwxS2NlakxKY3hNb0FYUlQ0c0hJbFJLL1AzWGVEUzZJc3Nx?=
 =?utf-8?B?UmFudWRGRkxQMU4vdkluWU5UclAwMUtnZTlEdXVEYi9pM3ZzTGpsR2I2T081?=
 =?utf-8?B?NGt3bVM4RmVhdDF3NlJDVDBTYkZyRVE1dFJIQUMraVVMd3F3QTV0RGRrRGR4?=
 =?utf-8?B?OVRLcjVaNnVxcFZOSmRoVXVpUnUvb21VWXpnQTNEV0Vha05EZkJGRWV4aVl3?=
 =?utf-8?B?YzRYQnl0YkQ1ZkZ0TGI0dEJIaWQxTG9rbHY1SlVCcjRxYW9vZ2kyRE0xLzdk?=
 =?utf-8?B?UGJKRE1rT0Z4NWloV0Jyd3N4TkdGRm93bEdZL2RuQWR2aHFIeUsveW9CZHl3?=
 =?utf-8?B?UFhZOGJ3alBidk5oeFlTUkQrWkRkSEFBYTRHUU9PREd2aEg0Skh1cStMTzNw?=
 =?utf-8?B?cFQ3TDZzK1grdEVZMElvY25la2ZpNU9LRGxHbU91YkhpTFZrWlZ0d0llUkNu?=
 =?utf-8?B?TGVVSHNaQTBvaE8ySzlFeFR1dFpqWnluM29NQlVwNS9Hc1p5TU1wTytRdEFt?=
 =?utf-8?B?T2dwcEEvTDBXQmpyN05BanU3YWxQMEdleGxGMzRFcG1xNWhtalFTVjBhcnF0?=
 =?utf-8?B?ekRud3NtOCtOM1hXOWFCNmZCenJUYlptVzZ5YkxidnhmcjdGYlhFcklmbU90?=
 =?utf-8?B?aEMwWkVXZGRUUE43UFNkUzFLajFDK013OGkwelloNGkxQURtUFIxN2RZc1Jl?=
 =?utf-8?B?RzlHVnBqWkhTd0dhc0Fndzg4NVpDa3orL2lyNWV0RnNvdy9iL09ONERQcG5E?=
 =?utf-8?B?MndvSU1xcmJVSDFSaW84dzlmNERwam9ReFhzT3FDUWU4L3NBQWRsdDcvcTM1?=
 =?utf-8?B?eTBibjFNa2hxdVZDTHhkc0RrM1FQV24zVytVcFNZZ1lzaHhmNGMxTVZjRVVE?=
 =?utf-8?B?Z1VBdXVXU1ppa2p5ZisrUFdxcWxDa2xEWnlPVzFCY1Z5bEI3VnJWSEsydXBt?=
 =?utf-8?B?OHpiTVI0R25CV2diUzJTUXR3aTBuYUUwR09qRS9PL1h4OW1IYmE5VlRjaTBU?=
 =?utf-8?B?V0xZenNOYmc4WksyRExsdHE5emZMclgzandKSGRHRjJyMWc4QldleVJzazRY?=
 =?utf-8?B?Wkhsdkp2QVRUZ0tENW5rRmRSMCtGUm5NSmprT0NSUmdkV0xaUGlscjNPRzdy?=
 =?utf-8?B?czF6bkxUSGsxY3AvZHdCRm1jSzBVWDFRb1pnU2Z3S1RZSXJCVlRtVHI5bUpn?=
 =?utf-8?B?eHlIS3Q1dUN3eExUSTkvTDdQYkJOa2RnSWpISHBSam00QjRwemQxZUVmeHlM?=
 =?utf-8?B?aUVjT056eCszL2lKL082STh2SHcwMWt2VW9DWmdQSzlUSGVqM1V6MzIyY0pz?=
 =?utf-8?B?V3BHQnFaS0ludUhMZkRHQSt3UmlIM1kwMWpwdENRUlRlSmY1azhXNlg1YWMw?=
 =?utf-8?B?RlFiaDUrUkkwakJQTEhrek9ER3ZzWFRlZWIzTmx2ZjdlUzd1T0Roa3JlVVdr?=
 =?utf-8?B?Mjdxc2dQTko2aFpKYUxWWFlTZjZNOGhKaWc3VW8wK2NTRlJUVXp4RG45Vmho?=
 =?utf-8?B?WHU5eVgvK3pzeEhpSDAvQnNrOC8zT0prb3VISHgrMWRaZmdHZUc1UEQ1REN5?=
 =?utf-8?B?TjdOeDRuWTNGVUdGVDV2eXdYSVZjYm80NHJzYWVCVkh5N0ZlNDhhVWFjTHY2?=
 =?utf-8?B?QjFBcnR5a09Sbm9jNURXV2o3ZG00NmtUYVBSRE50RUJ2STJmeWhyMTljckpB?=
 =?utf-8?B?VlFKSGIyeTVaTjhDSEt0UmREc3BTTWdBeXR3cEpFeThRaEFzajl5d015NXZ3?=
 =?utf-8?B?T3c5R3dIdXBXOTFwYytwVU9Zd2tvSHU5ekhzMW94NlFHV2pUQWRkMThHWE1J?=
 =?utf-8?B?a1N5YnhEYk0vQVd4MFdyU2VsNk9DVWFGOFpTZk95a3l2Wi9GWUdDZFFkSHZC?=
 =?utf-8?B?T0NxTzNDVHZaN2ViNFJCSnBHaVphZ1dzcmZ4QTd0aHVCQmg3SFlvalFUbzJM?=
 =?utf-8?B?dElNUjEyMzByNGhGSjZGb3hoTThqMis3QnpiUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3dCdkhvekIvYWsyL2N1cENTajRLL2hCRlR0TmZIaVFSTmZBUlFMTlUvaHF5?=
 =?utf-8?B?YXVxcW5ENTZEYjU3RGZXcGl3TGYwVlc3c0xiZUk0eXVEbElhSGE0eVluMHJE?=
 =?utf-8?B?MWVMZGY0dzNWeVpZbDNLVklmTW5KWUZRUmREM0dCUnJsRUtBSDNvTnY5S1JE?=
 =?utf-8?B?SHlkTzlRQWYzMDdvY1c3eTZ5dkc3NVhmaGZNdVNseHE1VGZEZ2Z3UExlVUJF?=
 =?utf-8?B?ZEZ6dG02ZURPUFRmRC9CbFF0Zkh5TFdaMVBjMkc0U2FoaU9VQklSU2V1Y0tX?=
 =?utf-8?B?aFVwRDQrTE5Nei9jNzFkQVYwcnhsdTlKaGRlOEk0YUt1Z2lqb2d2QnkreS9T?=
 =?utf-8?B?cHZXc1BOUWpUbG4reVpKK2F1R1I4UDVjOU52MFgzZUNWWEloMFdnUldXME1q?=
 =?utf-8?B?eW8zZGJHZ2ZJUEh5TGpWR1NYa0hYZStmK3lzVUJMYmp3cEprUjhtbytTUEpv?=
 =?utf-8?B?cUxtUkRqUVdCWXNxb2d5eHRFQkFlWUllQXc0TndubHhPRk1aVFh2cFdMbk1h?=
 =?utf-8?B?U0hqWTJuS3k4cXJBSFJzN20vMGE5TWxSV0FISkpGWlMzUEhqdTk0S2xOTUxM?=
 =?utf-8?B?cUFIbFE3bXNVZ0lOKzVnZXhscnBsQitxNXRnS3lkZDBmOXZGWnB5eXk2QTVv?=
 =?utf-8?B?Y0ozVFRYUjRxVzh0NzB0QStvWlhzRll0NjYzZFRLZ0l1bGEzY1NBaWVWS2lE?=
 =?utf-8?B?VG9Wa1dSaGZSR3VZWVVOeTNqLzdFbk9ONnhKZ2QzQ1hqQ2dSQ0lIbzkwUGhS?=
 =?utf-8?B?eFE4MlhabFF3NE5GUWNrWFNvbUdTNm1lTFArRm5vZFo4WmhjU2JqNEJORFhJ?=
 =?utf-8?B?UWxzQWtBSUUwZkJ0YW9JKzJDbE8waEZndjFBTHUwL3NOVDdtV3dXTmlQZUNV?=
 =?utf-8?B?Vk9waExPcHVibmdiVHN3WVpCbEZMdnBCMlRFUzZ5N3BXeVJjZUZ3MExITDQr?=
 =?utf-8?B?RzVLS0pyZXJ6NFVzbHZHUGZibEFNb0g5djEzUG5BYzg4anEyV3EzanhydndM?=
 =?utf-8?B?aEJtTS9NWFpvVE05OXJpa05lSjJDamJlYktHS1EyUjgrekVQNlJCYUJabVk0?=
 =?utf-8?B?SHZMR0QzTmgwTXl1K3NKbmlrazd6UGZBK1NXalczMSsrRTlJcDloT0VIU2Zv?=
 =?utf-8?B?V0lSL0RoNVBVRzdCNE5pdHhYbjVTS2ZISitkYXdoM3ZJWmhtOEFkQlZlMXZV?=
 =?utf-8?B?L3pDa0JDcC9tRlQxU0loNyt6YmdDNVdNeXBRYUdaaGlzM1JkOWFUN2UraVhT?=
 =?utf-8?B?OFgyaHNxVDJGMmRndFowbWZacG1wOGk4ZGFVakcxMzhjRHUvTXpvVFlXcDlG?=
 =?utf-8?B?b3hZRnhVRHp5WWs1NkVwaHdiMzVhL3dkSjJCSkFqTU96RDVCWUJGa2ZrTnhP?=
 =?utf-8?B?QzNqTXVCMGhrRzZOR01iMlBJKzNZampjNHNNTWJhcDZJZmZVajFYMnFOYXE1?=
 =?utf-8?B?UXFzZFFYVkJObnE0RVg5L1RTbFRKeHVVUEZScWlyYXhTM3NsYTBEQldlczNY?=
 =?utf-8?B?QjNGQXk5cWNENGR4eU5wOUZCbXFhenRQaHNqUk92bTlyMFZoNkxET01SeW4r?=
 =?utf-8?B?OUtOU1lXTk92anZLdUwwblU2R2M3RXd4S1pHN0RJSnptMU1oMEtRR05RZ2Mw?=
 =?utf-8?B?VG1hK3hER0pqTG1EZStlVnlObmJyb1FUZXF5dzZVUXd3a0dNMzNBalZ4eEw2?=
 =?utf-8?B?dm5HaER2OU81SVVlcG93Ui9wQUFTTFphM1ZjWG9GRDE5SVdJa2ptUWpNYWdX?=
 =?utf-8?B?K0FYMUphTEp6dVlLNm4wRXJ6aHZlTmhnczNBM3IveWczSCtCcTBVaGVRaEl2?=
 =?utf-8?B?dWltOWRNdDNWSlR5Qld6ekR2bXNmdmNrWVdoU1lHSmNId25oTkVnTFluaVFv?=
 =?utf-8?B?dC9oQ1k3WS9SSVE5bGRlek00LzYvYW5UQVVndU1tbjdHUkNFVDNUVGhhSm81?=
 =?utf-8?B?bFpkWmpmYy80QlhpcmwwWkRhTExLL01obmtZY1dxYjNsekV0V2swMDV0N1RF?=
 =?utf-8?B?Z1Q2QnZlUmNGMGx3MU1DZnZWVTlJV1RHSlpMQ3ZYRHRUYXRhNzRGZ2N5NE9B?=
 =?utf-8?B?eDNscjFVU1BqWWprV29yY1Q2clB1a0FqOE5QbDZmTDlvOXZsdDBQQzNsWVRa?=
 =?utf-8?B?U21FSHJpT2w2Z24xeFl0T01BcHJtTEkvVGVKWTNWN1Q4bkR5WjlzTVhnUGtu?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <955467246AECE24F9CDFE7DC19106064@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UXs+nDgGP7UGAYi/6Mhi90XbRtU8kAn3gE5oa3MxAaio1/XLocgF517LQBG0zxdqjT+My4Oy7+DJsK/QvTeKp+vbEGnwHfqSx04LuxsR0ZGZUMtGwwV/GMssSKw3tG32f4f1nm/vwmHkRIiRqOMR9zANNSvUNmeSMPNFZ8DYF4+gtJNzV6wT+IkBShedfN80otLrl7p2EJWxxFOt+5m7D2n0u8vHjbX53KhxXuAnqqJ+TVxKS2EUvydya4KjGPNyvjnJ/rA7CvE6INA4UHYuR0WaRhgyDfnk+t7E0IRu59JzxA9jd3J6xzy6GSbpPdd5M+JZUQX8a7vVFNIgT9YWMifJjfX0inL7IcWKNS2eiVIlmFgOH5au3T0GjpBxvNmgGWvVm4h3LNT9JOnLRoj8t5qFSGqSwuge8cn7AlrA6uDHgTYYTmMPKW3feNC+UOzFXUfm1QCvho91Rk3hOLGYAWHmwLerN4+BIp6E1SaBakbniRORe17BF9bxhLMYbZYwZuK0DW9PibIy7zQRfqH9oPZczD8AV88EmU9ryiLqi3teiXqVPh0Y5xUzQsn6pDPmbXIk7lO+oDEpBHEbKLTuATTJX2IGuc7PU5OBGM7ipBzaTboFM6kVyyxoNvVcx5Uh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f930cf-6fcb-4435-e347-08de2b2e8b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:53:24.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4FeiKt82VuqgiqiCYBzVUSsjRmjh/ReE9m7bIjW8JVMivHTjbQswnAM5RST2cI+UwYNhQg0JcoR/UvAS1SDNiXPZg5xxEJ4xbghoCl5JC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7288

V2l0aCB0aGUgdHdvIHBhdGNoZXMgYmVpbmcgc3BsaXQNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

