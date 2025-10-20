Return-Path: <bpf+bounces-71392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC3BF1852
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004E9189A48D
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BCC3191CF;
	Mon, 20 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ET9UAKXu"
X-Original-To: bpf@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D3126DD;
	Mon, 20 Oct 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966579; cv=fail; b=bg4kJ3kVyslOJjf/enJI5N6wC3iilvtpDVKjvzFjIof1ZVSxmH2ceR8pv48CcuKbL5RWn0TghFAs6MSFqBcJYzAUeS+n8FczYeHDuMzmM3eIim8kEEI6zg18anRpSJ9n//iuSIfl9wr1mi9t2VK/EJvTThKBNH32EtPXt/1IgHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966579; c=relaxed/simple;
	bh=xlUWoyOqe7LQvjpDvzAVobQZ+kroMPnWckuGw8MDCSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GAfiCA8B4eyhUfSJGv8gybcsazTMUiH/wWAxZFoeUydNXRF5w9gI4TR60DlvgwuU923wjRYJKzdw+miOJ1huCi+co1b9UxVAka0gTB8yc58v3afs3qkueev5OufOLHmtpW8q2sXe5V0aie14w0B9r18/8kG/sL5Nw+9x7M4onQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ET9UAKXu; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMR0qkI9DpNhssBS/HAWeHJJEdigUjb4zwo9xbJak54EFUJhes6Kb1VhMvBXT/kf6CirZspmUcSZyAVsUUxSw8d9WILSCeDrDqBWcGrgPbShHT2iy4bdOG3giQmp0H1WS3hGTTmeKQKiOfDynfLRmWosO0ZHhBUdQglKYdMKwri33XvFocph5Qeek6iX6xarEjWtlB2LkUHUzu0xCZX7Mnhia9/R7gu7gyNQszatkiUIEDYd0ojce4u2rFp5s9bo3KAoPu3XX/XylOd5fginHzffw0R2Fkam/3wmkiK0XDZ5b0BYRt60J6EWkoA0xHFnaS9UPDZWltFzeUqhRoCNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQHDJrMBJzP+7XXeQHkMCRTgTcqgqlylSum7Wy0jvmU=;
 b=FFM1jHWTxFJF3FlYUN4VwNc/25dKrJvEuazOyiqbTcc7dwqMtiNM3WHlmk/PP7NUIyGY4BB5I7eg/8Gboz+Psn2Jxevex2tQLRR8F92AbqP/OBHWtuX8XtkM79rTHoz9ltLO2kUqljSTeFfwdV/LO1e0hCUdYqCBE7Y0zOeyoZ4CVLm/8I/JlKFyGTFuYYbXG0Y+i5VgaVri1W8/S1BuI1lO7gHZitUFapB6zFQZpMNSx/teVvXMByAB3VZNF82BFnI2W2gN8T3YcTxghReuQe9n7/i9pW7dGc8NX+byuCUqxoBq00cKf+fRWTyHuPvyAlJVew3V1z7Eev2G+0z64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQHDJrMBJzP+7XXeQHkMCRTgTcqgqlylSum7Wy0jvmU=;
 b=ET9UAKXuv1XEwhM+F8GPaggtCKCKeExK0MeDYZHvKN27elJg4t1YIUJv7sC8YXFUQ+gDQXhosRHbR2ShWFWfNAtDO4WR2e1PLWIftgmIhWjzZtjEnwQQANK4Uoa6Y1BOe9u+hlVAnQhbhSfRdbx9HRdNsQ8BwOEZpQACsh61G9beL6GsJalcqJFQmvjw5Sb5fehnuqHTLi9smWxZigt+DyFS2hixRE/+tdnDBseOg7jN+OBVFPiV73jQT4TXz0GK2WnvRYrS6jYiX6Kiuqysg7DzA5gpOy4tXn88eZTRC5mLzMUDv+vNlH9EkkRa2XX252+5vd4Fx7WzmwAM2KL9+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 13:22:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:22:52 +0000
Date: Mon, 20 Oct 2025 15:22:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
Message-ID: <aPY3n5vIlzfTZMru@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <CABFh=a578RNXxjtze1TxAcPBkx9_M58qBc=6E4o-uFJx0DB4Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFh=a578RNXxjtze1TxAcPBkx9_M58qBc=6E4o-uFJx0DB4Jg@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b708b9a-16c8-4886-43bc-08de0fdbc5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWt5UTdBU21scytrWGVuVjEwUHZHek8xdEErMUR1RlRHRm5EUFZTdHlGR0ti?=
 =?utf-8?B?WEFyeWlneUlER1JVT3BDN09ra2VkM1BXQjVYdmtJdE1IODQ1aDV3OFUybTRv?=
 =?utf-8?B?cXJubjV2NThocHJTK3BnM2VmK2p3czJLemRrL2w5VytzS3IyL2hNS0N6Q0h4?=
 =?utf-8?B?dE5tTmpmdmthTkhTeTJRa1Bvd2NlR3ltS2VQT2pkenRxRTZ0WTZZalJoekxG?=
 =?utf-8?B?Syt4Qmx5cC9BOFE5UkU5SjYveDdEMVgrcFZwRkZTZTBCUXVWUVVDKzdybzFO?=
 =?utf-8?B?bkhZY0xCeGRZS2tTZG8zaGgzVUtPcmpBM3FzUkE3RllpWWR1OXNPREV1TzY0?=
 =?utf-8?B?eEEwZjBZU2RCbVhWakQxaW1vV0s3V1RGdW5ldU9qMlZzNy8vSkhZWjg2aGZ3?=
 =?utf-8?B?ci9iN1BxdHpTM0lSSDgvTGVwakEzR0Q4Y1F1N3BIWU5mbU5uNFBUVVIvR0Yw?=
 =?utf-8?B?d2ZKNnVJSFpHR04xd3FKN1lqVjJjbHhWTlN6RlVwZVpWKzhUUVRaaGlTM3dS?=
 =?utf-8?B?S01DZktudVlpdCszb015TElGbWd3dllGR1ZBRUtkMXlJYm9URnVGWExmbUp1?=
 =?utf-8?B?TXVYQm93U2xRWVRtNDB3NFp3Z2psYTBNazZtamxFZnA5cWcvWnRhakpTb2pp?=
 =?utf-8?B?d3dhd1RwcEplT1MvbDFkWXMzVmZ6YlNld1doWHFnaUhZbXVPcG9MVGcrYXY2?=
 =?utf-8?B?dlJxZG5MZmRwUytuWGtPL3NWZEZEY21PaURxbU5TZHRzMXVYa09MNnAxc3pQ?=
 =?utf-8?B?QnhFcnVsTGwzd3Vyb09ITVBTaXdWVmxXd0o4YzZwblNuaFJ3b3J0MnZ5UGdZ?=
 =?utf-8?B?aDJFWXQzVlRnaDZuSEpXNi94ejFoTWJtVSthdkxnUTJPbGVCZjVDTnc4TDR1?=
 =?utf-8?B?N2pXMkFZV1lwNkFRbjRXQnpjS3pPMmxXMEhQdk42ZTRvcWRPREpQMFNqUSs4?=
 =?utf-8?B?dmVkY0lnSnA5aGpWUEdwY05CQ3JuWnJFbUJ3Z0hIajA5UE1aQTRJQjh1Q1g2?=
 =?utf-8?B?VUJjSVdMYW1LeDl3WE5lQ2xzU003c3lSNnZhc2hvZ25uTnJ0TkdPaEozclBJ?=
 =?utf-8?B?ZXgwYU13OGJrajY2dE5tcVFuMDg4dklmN3ExNDFxTWk1MGIwK2cvV0NlWGxL?=
 =?utf-8?B?M0NIdHpocTJwK3UvTVpvL0hXaGRiZDd6c0dEY2dvdXlRcms2d3Vob2d4ZGEz?=
 =?utf-8?B?akt2T1F0MjYvMHFmSGMyWTU4NG9NcVl6ODN4ZjcxZWFwKzV3TE1PYnc2UFps?=
 =?utf-8?B?TGcvbjJSMmxKOGcyQ1I2RERuSWxIblliajhLdEE2RXd2ekxVbm1lVk9mTnEy?=
 =?utf-8?B?Wnh1dGgzRlIrOVZzaFZ3UzN2eGpORmk3QWFKV1BPbUtoZnNjR0ZJWU1abUFl?=
 =?utf-8?B?ZDFwWm5RUXJxc3haWUlJdjQ4cDJTMTJaaktBRlRBRVYxZHhNQzFDclptMGcy?=
 =?utf-8?B?N01sRTMzUG8rbDZ3YTZUa1c0Kzh0Nm1IdE1ta3BLMi9nVnVvS3ZkcHZFT0FF?=
 =?utf-8?B?VWFaRTE0VHVsUUVqNHFzUE1lSVJCVHNVTjlUc2dnbHlOd1hNTHJxNmRyaWlG?=
 =?utf-8?B?bWVHWXQ0ZTAwUVZncThxVHl4eFJVTWFLYjFxRXdONVFpL3VBVVJNMnltN2NS?=
 =?utf-8?B?N0NicFJ3YzFJeTJFNUFCS1JGOUZpcmxzd0o4SEpMeXYreW5MMUFudlhsQkdO?=
 =?utf-8?B?ZG0xdHdSd3RyaEN1ekRsM25obkJwMm9GM1F2MnFlcnREZGhVZXlaU25BTDBS?=
 =?utf-8?B?aUlEdEpDNlhmZjY0K25RNCtuZ1lCd1dnZGFLaEs3M0ttVTZTZm5RWWlsU2Y3?=
 =?utf-8?B?aXB5UG1LdTA4Vk1WLzlKa3lPdTBGT0UveG1paFgvdENhM1VHQ29uUVhYMEtS?=
 =?utf-8?B?bWdkM2g4RXlJU0cyZG9jR0pjMHZGQnJKZG42cG1iamJPdmxUOUg3eVY2akM4?=
 =?utf-8?Q?QL/CqL4b51vwAX6r5A5jIqm0AHUXxpJs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHFuMVpYcnBBU2RaRFdpQTJ4SkczWkdudHNLbXhFcHZTYWRrRkVEdlFKMXVK?=
 =?utf-8?B?TS80dDJxVjZyNkRseXVYNkZDdnFDd0N1NmpJSkFzV1VPWUJGL1lXNE56d1dG?=
 =?utf-8?B?d3ZqZjN0UzhaNGd1dVJPQjVkTDBmNGkyMXBoOE9pUTdCWUhKMVc3YWtnWkdF?=
 =?utf-8?B?SUI0M2t5NlJXbXRldmNSYjNWRkhrN0Q0N3g4enJ5OFZORjBhRVBZVEdJelB6?=
 =?utf-8?B?dUhzVmdhc0NEbUFlVVpaYUVhZVl6NGhjOHFuTHhrUFcrTksyalo0WDVwRTVk?=
 =?utf-8?B?VXVrVDJSTWhOWk84MTVvc3pnNTlkRVcwd1J6ZS83T2g0dmhpcDdxT2tkSnRG?=
 =?utf-8?B?VkRSRU5qZVhoQTVMRzRyd0xQeSt1S2ZhZFBrY3VxZTM5bnNMdndXem5Va0Nh?=
 =?utf-8?B?NyttZWdmbnJSMXliVUFYZUtFRys2SkZRQzE0ZENIcTN0YXBYcUJmak9TT2h3?=
 =?utf-8?B?eDU0THQzUytxVFJGSCtjMjVzQ0JONGR5YkllRUd1c2d3aDhIYll6Y3JGQ1Jk?=
 =?utf-8?B?L2xEdDJ3NXJ2b2lGWjVVaUZ6RDg4UG5vdmdxeWFMN2Q1aGUzbXRydGNHVnBV?=
 =?utf-8?B?V3hKN1U3bk5MQjdKNmpTZjB6aG1vNGdDTVc0YklzZVhiUUhSeEl4K3BNZ2RH?=
 =?utf-8?B?OHoydG95bkJ6NDF2NXRXTTVMb0NObTNueUNXa1NvcUY3TVQzdUIyS0ZVejQ5?=
 =?utf-8?B?OW5tRldkNXVSU2oxRGxXOU1VVmxkUk5QN2lDS1lRa2VobWhxV0RUdW40VGFZ?=
 =?utf-8?B?QzdFSTNMSUc4M3ZvVmIxTUlLN1JCeURicEU4TE5YOFhaNWRQNmplT0JoOFVZ?=
 =?utf-8?B?RU5VbHc0OXdGNmR3WW1jaGVnc3c2djJkUlhnb29MNzIydytsNHI2Vk5jaXdx?=
 =?utf-8?B?Ri9jK3pOb1JXK1lSZC9UWU94c3NwQjZya2p0TXVDM2xlZzg5NkRVeG9pUXhh?=
 =?utf-8?B?aE1KSXNPcER2Z1I3MzVIajZFMnhBcitEMS9Mb2g2U2RPY2h4S3ZXMmJueGU0?=
 =?utf-8?B?WC9lTVA3SVlWckJTbkF3TFU0M1VTbmkrbGl5WFFqNVp0YzJlS1pTSml6VGtS?=
 =?utf-8?B?cExhNUlQY3krd3RFaEZqV0VNUHUrVUFRZm9PUTJBeWlSb2RHREtLK2NjUU9Q?=
 =?utf-8?B?dG4zOVpPYzE3L3RQdytWU3pZbXpoL1R0MVpwNk14RkdqQU5lQklxTk9LcXlv?=
 =?utf-8?B?Q3NQK1FOdXNtUndIWnNsRDlMc29tY2E5UkFrc1J2UWpJVFg2Y2E0NWJldUwz?=
 =?utf-8?B?YkR6UTNxMkpBNnAxaG1YSER0SkRxOTJES1A4MjdySURuRHFXOFprKzBoc09i?=
 =?utf-8?B?bXRwb0V1Ty9BaUVkR1lHRmZINVFZZGZBZXlpdjAvdGRBWUhmbGVKVklsMktm?=
 =?utf-8?B?Wm52Nkh3TXF4YkNkUyt0RTFQaHpYd3hGWmlzV3VqdXlMSkI4UFkvNmh1T1o4?=
 =?utf-8?B?Y3J3OVR5QjVRbWxmL3RIaTNEVTNGM1loV3pvbUQ3a2pPTnFTNFMxWmJ2OHo2?=
 =?utf-8?B?Si9lRkxIV1NneTBnOHVZeWFIU09OTmRzd3dUbzNBSkdrYkdpKzJCRVBJY3Vn?=
 =?utf-8?B?SG1yUVBnREdoUUdDejBFMklZM1ZJcEU1a1ZYSEJhQzRQWE11QWlPRnc1TS96?=
 =?utf-8?B?K0VjZCtabWFhMUozR0dFR1VYbkxWc3VsY3dzRmlXSUZxWXQrU2hIaU9iVDBQ?=
 =?utf-8?B?RDNyVDFLTFJaTk01T3hDREkxTTRnMHRZSHY5ck93SGZQVHRXcVdTMXo1cWJR?=
 =?utf-8?B?ektkdGNYeEFSSktxelB4WHRQNXJ0TXdxQWs1QjF1c09kRXlnRjFiMGNZNFJM?=
 =?utf-8?B?VWxCVk1EU3R3L1pWUFJMckk0T0NtcmUvTXBSSlNlNk9JcFNVMzBFUCtNUzVa?=
 =?utf-8?B?OGxpMzNWYURFdHhDQzVUMk5KUWtqSExMbE5nQXJBeTQ4UnVaWXhRUXJhMzJB?=
 =?utf-8?B?b2pyMVJ4WHVPdFJ3Qi9rR1hRT2lDZmN0QWp2TUdmZDY2Nnp5enpPeUhDT3FI?=
 =?utf-8?B?ZENMM1VmZHpUSHdmbEJsUkpQNWcwY01PUzgyQUMvVFpEZ2dDRHdmOWNNTXdi?=
 =?utf-8?B?TFB5dkc5alYyQ2FETXZuM1dKRFFKM044YkpiQjZNd0VsaFU4YUhlb1lYVDdT?=
 =?utf-8?Q?IXGLyn5hTULoW2GXo30bQFvU0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b708b9a-16c8-4886-43bc-08de0fdbc5f1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:22:52.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omt2bHZZms6Hmx0vLHaPYE53eNqYGcaFxcyFMcPKPAq6VniKQUjB6cBXyY9EC63BK+02XjurXgUej18EcKbHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532

Hi Emil,

On Sun, Oct 19, 2025 at 03:04:22PM -0400, Emil Tsalapatis wrote:
> On Fri, Oct 17, 2025 at 5:38 AM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > Add a selftest to validate the correct behavior of the deadline server
> > for the ext_sched_class.
> >
> > [ Joel: Replaced occurences of CFS in the test with EXT. ]
> >
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> Nits listed below, but otherwise:
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> Code review aside, on my VM the test alternates between 4.81% and 5.20% for me
> so it's working as expected.

Yeah, that sounds right, a bit of fluctuation like that is expected.

> 
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
> >  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
> >  3 files changed, 238 insertions(+)
> >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> >
> > diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> > index 5fe45f9c5f8fd..c9255d1499b6e 100644
> > --- a/tools/testing/selftests/sched_ext/Makefile
> > +++ b/tools/testing/selftests/sched_ext/Makefile
> > @@ -183,6 +183,7 @@ auto-test-targets :=                        \
> >         select_cpu_dispatch_bad_dsq     \
> >         select_cpu_dispatch_dbl_dsp     \
> >         select_cpu_vtime                \
> > +       rt_stall                        \
> >         test_example                    \
> >
> >  testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
> > diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> > new file mode 100644
> > index 0000000000000..80086779dd1eb
> > --- /dev/null
> > +++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
> > + *
> > + * Copyright (c) 2025 NVIDIA Corporation.
> > + */
> > +
> > +#include <scx/common.bpf.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +UEI_DEFINE(uei);
> > +
> > +void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
> > +{
> > +       UEI_RECORD(uei, ei);
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct sched_ext_ops rt_stall_ops = {
> > +       .exit                   = (void *)rt_stall_exit,
> > +       .name                   = "rt_stall",
> > +};
> > diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> > new file mode 100644
> > index 0000000000000..e9a0def9ee323
> > --- /dev/null
> > +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> > @@ -0,0 +1,214 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2025 NVIDIA Corporation.
> > + */
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <sched.h>
> > +#include <sys/prctl.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <time.h>
> > +#include <linux/sched.h>
> > +#include <signal.h>
> > +#include <bpf/bpf.h>
> > +#include <scx/common.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include "rt_stall.bpf.skel.h"
> > +#include "scx_test.h"
> > +#include "../kselftest.h"
> > +
> > +#define CORE_ID                0       /* CPU to pin tasks to */
> > +#define RUN_TIME        5      /* How long to run the test in seconds */
> > +
> > +/* Simple busy-wait function for test tasks */
> > +static void process_func(void)
> > +{
> > +       while (1) {
> > +               /* Busy wait */
> > +               for (volatile unsigned long i = 0; i < 10000000UL; i++)
> > +                       ;
> > +       }
> > +}
> > +
> > +/* Set CPU affinity to a specific core */
> > +static void set_affinity(int cpu)
> > +{
> > +       cpu_set_t mask;
> > +
> > +       CPU_ZERO(&mask);
> > +       CPU_SET(cpu, &mask);
> > +       if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
> > +               perror("sched_setaffinity");
> > +               exit(EXIT_FAILURE);
> > +       }
> > +}
> > +
> > +/* Set task scheduling policy and priority */
> > +static void set_sched(int policy, int priority)
> > +{
> > +       struct sched_param param;
> > +
> > +       param.sched_priority = priority;
> > +       if (sched_setscheduler(0, policy, &param) != 0) {
> > +               perror("sched_setscheduler");
> > +               exit(EXIT_FAILURE);
> > +       }
> > +}
> > +
> > +/* Get process runtime from /proc/<pid>/stat */
> > +static float get_process_runtime(int pid)
> > +{
> > +       char path[256];
> > +       FILE *file;
> > +       long utime, stime;
> > +       int fields;
> > +
> > +       snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> > +       file = fopen(path, "r");
> > +       if (file == NULL) {
> > +               perror("Failed to open stat file");
> > +               return -1;
> > +       }
> > +
> > +       /* Skip the first 13 fields and read the 14th and 15th */
> > +       fields = fscanf(file,
> > +                       "%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
> > +                       &utime, &stime);
> > +       fclose(file);
> > +
> > +       if (fields != 2) {
> > +               fprintf(stderr, "Failed to read stat file\n");
> > +               return -1;
> > +       }
> > +
> > +       /* Calculate the total time spent in the process */
> > +       long total_time = utime + stime;
> > +       long ticks_per_second = sysconf(_SC_CLK_TCK);
> > +       float runtime_seconds = total_time * 1.0 / ticks_per_second;
> > +
> > +       return runtime_seconds;
> > +}
> > +
> > +static enum scx_test_status setup(void **ctx)
> > +{
> > +       struct rt_stall *skel;
> > +
> > +       skel = rt_stall__open();
> > +       SCX_FAIL_IF(!skel, "Failed to open");
> > +       SCX_ENUM_INIT(skel);
> > +       SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
> > +
> > +       *ctx = skel;
> > +
> > +       return SCX_TEST_PASS;
> > +}
> > +
> > +static bool sched_stress_test(void)
> > +{
> > +       float cfs_runtime, rt_runtime, actual_ratio;
> > +       int cfs_pid, rt_pid;
> 
> I think it should be cfs_pid -> ext_pid, cfs_runtime -> ext_runtime
> 
> > +       float expected_min_ratio = 0.04; /* 4% */
> 
> Maybe add a comment that explains the 4% value? As in, we're expecting
> it to be around 5% so 0.04 accounts for values close enough but
> below < 5%.

Makes sense, I’ll add this comment (or something along those lines).

> 
> > +
> > +       ksft_print_header();
> > +       ksft_set_plan(1);
> > +
> > +       /* Create and set up a EXT task */
> > +       cfs_pid = fork();
> > +       if (cfs_pid == 0) {
> > +               set_affinity(CORE_ID);
> > +               process_func();
> > +               exit(0);
> > +       } else if (cfs_pid < 0) {
> > +               perror("fork for EXT task");
> > +               ksft_exit_fail();
> > +       }
> > +
> > +       /* Create an RT task */
> > +       rt_pid = fork();
> > +       if (rt_pid == 0) {
> > +               set_affinity(CORE_ID);
> > +               set_sched(SCHED_FIFO, 50);
> > +               process_func();
> > +               exit(0);
> > +       } else if (rt_pid < 0) {
> > +               perror("fork for RT task");
> > +               ksft_exit_fail();
> > +       }
> > +
> > +       /* Let the processes run for the specified time */
> > +       sleep(RUN_TIME);
> > +
> > +       /* Get runtime for the EXT task */
> > +       cfs_runtime = get_process_runtime(cfs_pid);
> > +       if (cfs_runtime != -1)
> > +               ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n",
> > +                              cfs_pid, cfs_runtime);
> > +       else
> > +               ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
> > +
> > +       /* Get runtime for the RT task */
> > +       rt_runtime = get_process_runtime(rt_pid);
> > +       if (rt_runtime != -1)
> > +               ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
> > +       else
> > +               ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
> > +
> 
> Minor, but why not
> 
> if (rt_runtime == -1)
>         ksft_exit_fail_msg("Error getting runtime for RT task (PID
> %d)\n", rt_pid);
> ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid,
> rt_runtime);
> 
> since ksft_exit_fail_msg never returns?

Ack.

> 
> > +       /* Kill the processes */
> > +       kill(cfs_pid, SIGKILL);
> > +       kill(rt_pid, SIGKILL);
> > +       waitpid(cfs_pid, NULL, 0);
> > +       waitpid(rt_pid, NULL, 0);
> > +
> > +       /* Verify that the scx task got enough runtime */
> > +       actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
> > +       ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
> > +
> > +       if (actual_ratio >= expected_min_ratio) {
> > +               ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
> > +                                     expected_min_ratio * 100);
> > +               return true;
> > +       }
> > +       ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
> > +                             expected_min_ratio * 100);
> > +       return false;
> > +}
> > +
> > +static enum scx_test_status run(void *ctx)
> > +{
> > +       struct rt_stall *skel = ctx;
> > +       struct bpf_link *link;
> > +       bool res;
> > +
> > +       link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> > +       SCX_FAIL_IF(!link, "Failed to attach scheduler");
> > +
> > +       res = sched_stress_test();
> > +
> > +       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> > +       bpf_link__destroy(link);
> > +
> > +       if (!res)
> > +               ksft_exit_fail();
> > +
> > +       return SCX_TEST_PASS;
> > +}
> > +
> > +static void cleanup(void *ctx)
> > +{
> > +       struct rt_stall *skel = ctx;
> > +
> > +       rt_stall__destroy(skel);
> > +}
> > +
> > +struct scx_test rt_stall = {
> > +       .name = "rt_stall",
> > +       .description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
> > +       .setup = setup,
> > +       .run = run,
> > +       .cleanup = cleanup,
> > +};
> > +REGISTER_SCX_TEST(&rt_stall)
> > --
> > 2.51.0
> >
> >

Thanks,
-Andrea

