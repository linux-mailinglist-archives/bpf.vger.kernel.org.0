Return-Path: <bpf+bounces-61211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBFCAE23B5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE1189BEC0
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A22EA728;
	Fri, 20 Jun 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bMGAPmEy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34145293B42;
	Fri, 20 Jun 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452304; cv=fail; b=uvvOfkoRog82dJnzjmJKPIcdAS1fac/H2KxHWJDhojhcLoqbUyHpja1BIkVTQGWtWhIvzK0pf1VeB8qAsRZO+wzjvF6rHmhnm0XX+EJ7XjjQQRx4f12lqRrmbhPu4o4udPy1CeaalUewh/RNrb30iV4AuaqSIWAKtJE/5cineI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452304; c=relaxed/simple;
	bh=H8vUPAez+ab8PvEiTbyNhi74YUh/kEz+mGmxuq3DCqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMT46RFU9VF6jkjLS07O0C+uZqKynayWQy8NpK96t+KHV+HQqkYHAGTyD2YLmxs+/6iJ5NGwpMjda7nAqKw82YQA/EiyjgoCsQ3O4HfPQqPDG1Kk7njtHeGcgQ5LNI54vnDKwkWGImpgz69myY1MPh3YONZPqTOK2SfvdTCg6PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bMGAPmEy; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrSjGuufRP5ocEX5X3ccGBkfDhzy0odOdkW1L6ZiqDdUp2lgTuWmOAaUIcUmEwEBUYHP6iMbQ/ZnTsKakHjzEkzJF1QjOeRM7oTclm/JitHhOStcay15W6f9+WGwv+KWNg1w7i36PsLWWXl7aftQxA3FZVoXULsOaIhlditFPKLuc8AsKF9uX5LAZjCwSlHFIOsftZBWzaYJ0e7kb3YVSDaenEvFzdKiJb3vQNlLg8nsunK1E8HzDrVpz2CYEOhSxWAlxaJkdLgHyc/SI2ijVVE5lVV7RnCXWiB8zX9+66nJ3qpCR7obK7EfzL7saxVIqmgTFGyiBU3I7hN4b1yENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sQGo1SBNFbHhTNSfWNoqnt77mkedFPnuPtYANHfIfU=;
 b=sAml0Aitt/eIpgfwkEv7rZHxlIS/7mx8X8wS9GGDdcN4ChtfJOilVp/SlO41a/sT9kzAh7h4ypqylOqdiKCRkof5d+Am5hzGI0wD7clojt27wVdJDakMNuHLI2mAWB+NcALu7rcIX3V9RJM+gUAZYtUC5fzCkYXWbzZSC+kDTY/crsf/20qZu5vnapP7kLzUdpiDC2n3nUG6+SdjiTLpNuh8CbhvZbCdeFmpIaYFQIpNSOdRGauT0ICJT/KRsckFw4IhYGXj54yRoe8HLoFXfFsm0hGpz+4I2v51gfh5ar9aMlS8SGnVMYWf6evC6ZN2PbwuX6Txfa++5zN5hmVXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sQGo1SBNFbHhTNSfWNoqnt77mkedFPnuPtYANHfIfU=;
 b=bMGAPmEykVKHd0/kPJnMir1pU/A7ReKFg1wgfVNBdYj5otvwflHn+8HacGIBPBLEYkzzOKVEZTVxfVxyfGZOr4i2YZrnRL1A1Zo28KkGOGXAeEJsvgcd1OEg12ZfdMDoLBn9EViPWOtpOHzln8SQc73F4/A5/6i46UPloMGaGH7rsGiw4uwdQLl1UEzotCncN1F7VM+6Iwx9xY2iKR85xKUtfxNNnVX8LCQWFyYtvEMqHsXuL++2k5hnfXfXJss3fZ28GWsmKx+gbz7dYKC67yT4ebEDg/wM8B0+RrlS7ByDOlJcTouXG020L2MLxqL7HHFrN40pFLfMPRdD5m+Egw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.24; Fri, 20 Jun 2025 20:44:56 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:44:56 +0000
Message-ID: <a8dc965c-94e8-4941-a292-f14eb76831d9@nvidia.com>
Date: Fri, 20 Jun 2025 16:44:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] Add a deadline server for sched_ext tasks
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 bpf@vger.kernel.org
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::22) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd27917-bc9e-4e65-1d82-08ddb03b5104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2VMS2RYT2pVTGZ4L3RCYVNZem93WWc4WEpvQUVVaWNGQm5WNDY5eVNQMjdS?=
 =?utf-8?B?S3J2bVJETjlWQUYvZUJPUWFjT1VYK01vOUhrMDFWL3lxNFhWZU9jM2t2WTZB?=
 =?utf-8?B?clFleHliUTRORmpQNTBEVWFhejFkT2dPeGhjZlZDMFpRaU54ODRvcG91SnVE?=
 =?utf-8?B?MHVmY3k2SjBsaXJhZDlSS3VmRHlEaVB4d3A5Mk1KbmZlcHBXOFd4RUpSeWZ0?=
 =?utf-8?B?aGkwaEwxQ1ZKVVpOa0hrZUFWcVgzcy9mQXAvRTFIWWFVaVhzRlVmNDdqa253?=
 =?utf-8?B?RVNIN094S0lFWDdOdnB5Nk41dWQvOTc3Wm1KaTM2MC9zT2FuamoxU3ZkMWJy?=
 =?utf-8?B?dEZaenRBcDY1TS8wVlphVzF5Zm5rRnZGWDZuUlhuUkJ0RDRtd0FYVFUydFNN?=
 =?utf-8?B?VDd4SG5ZcjM0dFBCUktoVmRXNmw2bFpveXhEQVBQVWluc2xEaWh1RlRLQTUv?=
 =?utf-8?B?L212QmJ0TTlyTHBCd0thYmRTOHZJcW5naWptemIyaG85eEFQbk9IMUk1c3RD?=
 =?utf-8?B?V2hhOFBDZndlV1kyeVhoS2VNY0lTbzkweGdKSUh2UG9Hbno3Y1huNHFhMjhn?=
 =?utf-8?B?TFkzZWpITUhCWGF0a1AyVSszQktIOTNiMjIwcTE4dE45UFFIUnF0eVZVYlB3?=
 =?utf-8?B?dXpuYStFMUpaazl6VnpzaWRVdWZDQjA1Uzd1TDErL05DZHl6UFQxblVnQURo?=
 =?utf-8?B?cnhIMGlVWHpiOGVnSXd0Sy8zZmY3NGJZa1phUTJTaTFBQkdWcENzOGNmTVJT?=
 =?utf-8?B?M2RodXUwc2dvQUdiTHU2bXJkbjJhZlVkUGVoL0ZNQVVzb1NVVElOK0hkRkZp?=
 =?utf-8?B?Z2tEdHllK2M1MHlacm14WjlXaWlHMW1Cc3BOR1B3ZjY2ZzJzRkE3b1F2VzQy?=
 =?utf-8?B?STQ5bCtzZlZMWko1cExwTDFDNTJ6UzVQYXFwcGRrTWlNSS84ZkVFbFVjVXA4?=
 =?utf-8?B?SGpEM214dmZrZHJrSW0wY3ZSb2VSQm5WUWg3bEZubSs0RkxNazhtSnhIK1Rh?=
 =?utf-8?B?bzZDT1d3ell5TFVvWWtBOHkxdDk3ckRMRlpFV1VmSjEwTWFKMDNROG9BK3B2?=
 =?utf-8?B?dTEvTkM3NEMyZ20reHVsTExjZnpmd0ZUR2xMRWNNTkVzbnZPMFoxNCtWcWgw?=
 =?utf-8?B?YVJ5MVhGUzJudWVrcW50R1J1SUt6NmdXTTBSYWdrWGZqSGtnc0FrNlNhMU1p?=
 =?utf-8?B?Mm90c0VDc2lEeUMwOTNWaTVIYVVvb0ViL1R6RngzZDVIRUJ1b0sxT1ptVS9y?=
 =?utf-8?B?SnNub0dQT1IwdzVXSDFNVittZVZxZlZsaGxSS3RFWkFJWHFLNTNKOW5MaUZF?=
 =?utf-8?B?bFFrRmRJL1podC9Cam1hMzhWdFVCR2phVW1nR2QvT0luZ05nMHRhNmR4NTVu?=
 =?utf-8?B?c1dQOUlDV1lGTTdVejZ0cGUzUjNOSkQvQ2JKOGVaODNXbHNjUXJabG15TUE1?=
 =?utf-8?B?em05M21pdTlIL3NaN0VscG44WVZ0VksyZEFnQmJJTDVVQUtQUzZHbklTWWJ6?=
 =?utf-8?B?bmlwaFdURU1PR0pTbTVaRUcxQ3FaQVQrRW1KZ2s1bmtaeVhkTHRhSTZZWFJu?=
 =?utf-8?B?TGpwaVA3Unowbmx5cHpNZVNwOG1Ba2pzSldrN1BUUmpOcEJNRzlMamVkK0Y3?=
 =?utf-8?B?b0txQ1Y0cXlxclVGaklBRG9rYkl1c2NiQVhNemhvOUpnNEd3M2Y3TlN3WGNN?=
 =?utf-8?B?NHltOUtJSXQyQW5YdmJpYmNUWmEvU0NvcG1ENkhDZkhjbGgwUmVONU1HTnha?=
 =?utf-8?B?MnNGZUN4TDZyclhpcWpDK1BIT1czdVVaanMrc01tVkhrUTVZUUsrNmtTUVBO?=
 =?utf-8?B?eThBZWUwc2twUVI5RlpxMFFZUVFyOHRLVkFFUGtmcXhDWjFWMVhTczYzUS9N?=
 =?utf-8?B?MEVWcktzVEVrSTdxdGZmLzdDQ2JmQWp3NWxGbVNCVlE0dnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQ0dUlUVFZ3aWVSMnJBdE0wMXpKdDNVbnRoOXdFbGxWZ0cza283SFV5VWNa?=
 =?utf-8?B?QmNDOTcrQ3NqK1UybDZkdkk1NGlsMEhDWFhwZmJ1QmJISlBlNW9pU011YUxP?=
 =?utf-8?B?TUVISDQzNXRTOWZDQ2xWQXl5SEJmLzRINENHVWJra3E2elBtaUVXRHdxV3NE?=
 =?utf-8?B?ZEpaT2hyZXBaemd0NFV5cVlOZ1ZCditkNlFDOWg2QWtBRjA5UHEwSnZmNkRX?=
 =?utf-8?B?N08ybml5bUhpc05OODNUNFA4c2Q1eHZBSnJ0Z1dTQko4MlRVS3YrZmkzeWtu?=
 =?utf-8?B?WTBIcktCalJ5OEJqTGF0TFh0dXIvMlo5N0ZpNWFIM2g0NmZOQlBHSGNTdTlV?=
 =?utf-8?B?ZnNReWN5bDU1T0pQeGF1eGpXRUQ5eVFNMnN0WHFXbFNrYUliQ1ZXM0VaME92?=
 =?utf-8?B?cjVvNkhBb1kzeWNpZStyWXFVREczc2xacTNYYXEvTmx5aFRYM0RwamR5c3c0?=
 =?utf-8?B?TEJ0Z01Jc00raS9hVWdxRm8yQXpneFJCTWFCYWpLM0paTk0xQmlOdFdEMU5K?=
 =?utf-8?B?bW9CajgvY2x0dE1xeVVxSmxNL2IxZk1rbk16azI4RXo2alRubk02M1NKc2ZB?=
 =?utf-8?B?ZmsrNDNLNW1Wb0h5d3QvTmhpWHYyOGhsQmF2b0VyWlBkU3FmbDRvaVUwbmhz?=
 =?utf-8?B?alFHOXNKNWZVUE5xNzVISnBOVk1jdVJKcDBFU1VwS3h5Q3Y4Qk5kT0NqS0Zu?=
 =?utf-8?B?OUd4UkI1L2ZuY1pHNWt4bjJ2ay9sL1JLVkEyd0lMUEV4cUJWbHpYVzN1c0o1?=
 =?utf-8?B?cW50UGpPL2pLckcyUUVoUnJRODFwVXV3aE5RUWRtYVEwK2hoeEE4dlJUeFAr?=
 =?utf-8?B?REhaRUZReW0vS2c1N3BTMkNPZFdUREYvVjgrTjlyMVQ0UTdGbGZUSVFZbzNW?=
 =?utf-8?B?UWloZlhnRXJQUXkwZkQ3WFJPeW82Njd1V0kxTkluVVRFYjFDdWhVM0JsYmd5?=
 =?utf-8?B?OWViRUU2S21PYWd2OXlSbHJTS0xtMmQvY2U1ek9JNmN2ZFlLM1IrcHNtOFJX?=
 =?utf-8?B?U3dmSTNiRkFOOFEwQzNmVnNLeDNZMHlEVGw4dVZBcDM3VmJhS0JORlAyUiti?=
 =?utf-8?B?SWoyOE53Yi9Cd0JUVkVBdlRrcDVVR3VJMkhWQ1lIRXFNK0pmSTVoUk1ienNR?=
 =?utf-8?B?empIMUZuWG9uaUh6anYxUDBhd0RwNjU5RFpXRU1sTGRGeUlUQlk0ak9SYU13?=
 =?utf-8?B?NWMxamFRYXVBV3VCbk84UWJVUmw2N080VUJIc2p5dnNXY3FpMmcrVzhpd25R?=
 =?utf-8?B?TmxUTFMwWW1nYUpvdFhNMVF0eTJvQTVlaUtkemFmOThvNXZYSHprckhUUWJZ?=
 =?utf-8?B?NWVFZlRyZ0I3dXRKOVBsWTVvUmxXUDJYampNdGJJcWpQZmJYdkhQVlkzek9O?=
 =?utf-8?B?Qm41TUtTbzBGNEtubEJrOTZlbVVwNDB3TkM5TnFPdnBGNFcxOVRHNlhBbjk5?=
 =?utf-8?B?VFY0K3IzdkZmelp6ZVVldCt4SkVYaElZUEFrMFpQZ1dGeG1tOVcwajFSd3NW?=
 =?utf-8?B?enJicy9oaFpNMmFqZjRWV3RsWXB1KzJ2Nkk2bzlCZExXZ0Z3OFBOWFgrM1JX?=
 =?utf-8?B?OVZZSUpJdjEvVFdBemc5bGJ5azJxMVk3V0s2dDJ1WTJlbEZ2RjZSdW82RC9M?=
 =?utf-8?B?WitkTG8wbnhqOEpmMmZ1b20wbldWczVCQ2lJNHJyZ2tVbVdqZHJFRk1zN3pF?=
 =?utf-8?B?Smp5N3RndDhMVnM2cW9palNlRExSNUhURHVuRHkxYjd5OXo1TmxTN3cvV0lM?=
 =?utf-8?B?UndPQVlZNzE1Qm9reG00ZVB6a1hySFNNaUFNejhVT2NGZXBKWStGWitEQi9l?=
 =?utf-8?B?YXN4cXRrV0NEVDVPUFRrU0JwblRad3FCS3c0WCtRMVJlZWVRckxEOUZhT2N6?=
 =?utf-8?B?YTI0aXFQcUFlbHplM0RBb2ZZTmVJd3VtT0hXcjkweVdBNDRFcXFDeDlxQVEv?=
 =?utf-8?B?TzZaVG9PdjBkWGJnRjdWazFEdW9NZWtLNkhISUJhSkFSa1BwOThnL09pME1R?=
 =?utf-8?B?VndRZ0xLZXRBemVUbTBJdC83Vm1MOGJ0K0t6SzZiNmZ2MzhPVG50QjJ4L25U?=
 =?utf-8?B?YmtxRWdQeURGeU52dmYzY3oxNFlSeVphKzJ1cHZNdElNZTRlQi9UbHpaYlI3?=
 =?utf-8?Q?k4n31uR2vFAcridlChh+d61WX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd27917-bc9e-4e65-1d82-08ddb03b5104
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:44:56.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/9jZryeNi7VZ2t3XNumV+TzI/Njq/gQDlJST50Mtp5A8q6rDZTI9XRwcyudiSd3yxQYH1mMynGDL0tQr+PjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256



On 6/20/2025 4:32 PM, Joel Fernandes wrote:
> sched_ext tasks currently are starved by RT hoggers especially since RT
> throttling was replaced by deadline servers to boost only CFS tasks. Several
> users in the community have reported issues with RT stalling sched_ext tasks.
> Add a sched_ext deadline server as well so that sched_ext tasks are also
> boosted and do not suffer starvation.
> 
> A kselftest is also provided to verify the starvation issues are now fixed.
> 
> Btw, there is still something funky going on with CPU hotplug and the
> relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
> (./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
> something is off in dl_server_remove_params() when it is being called on
> offline CPUs.

Sorry that I forgot to delete this last paragraph. The hotplug issue is
completely fixed now (since v4).

There are no more open issues and all tests on mine and Andrea's side are
looking good now.

Thanks.


