Return-Path: <bpf+bounces-32886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C89147DB
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481311C2221A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A453137759;
	Mon, 24 Jun 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hl7V5aRj"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9A2F24;
	Mon, 24 Jun 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226437; cv=fail; b=HRbtRrPlyGqbJNXn3N3j3OR+YkAgHV4vSJsMSACg1y3sCMvaGkgHg7wS2H8kGmWea4GMsb49zdUFKEzXAR08ehRIfe7OJA5Vxvdy2W5w0Dt9eaQSBz0Q7e1SJSEFocYv1UW53gs2vv3GJqhfb/Ke9sDrKzV0uA5h06v2xqC1BXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226437; c=relaxed/simple;
	bh=wEAi9DlIeWUP8xCBjBFu3TnP0Ld2Evz3ARniFn9dbrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NH41CyBjitQz4+NZI2nGRTyjv6VfrnIsYfDPT/rh9ad/OVObtS164d4cFBjouZ0n5vit9px3W4yH/tq83FfzaZ+iPYIQOc8VrRS/61ua5nRPLZQCsnBXWfxZFZSKFOdy5EXk/oaUXVy5VLvAl3cuTkfz+mMj6IDnFr361lcZp28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hl7V5aRj; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0yIlVfbKjmeNQ2wwbbVyrNYrZTP7ItKc5f3Z8lZ8SUBYIrpypGUkke1VYO98ZyLbgy6KD26LMfJRwc6h/bzQql1iLaKVdhpv4L1hbSbO+L/N5ZxWdeBybb47vKd/BXpB48aUJN+nrbeza8Tzd25zps6XvsPoahE4tRmEpwOybJnS1YtJQZaz4GvyPSMvIiGuolIbRVGmn3e6y9a649ixwlzNNBboeFINcZk0pY33yyDSec8AjA/hmMkkcFKkrCeZO6GvzXVvIe/v3x01Rgn/yxFCRivx9tj7+hSaSBY5sbXJIdckI4XWoyFlg5uTrhCeBaPAb8sN6+C6DvhYgSxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paD137QzPFq1tWJCgr5jmdYXC7lF30qWrL8US8AWHfA=;
 b=J+IwEX/tDJMeQNa30lLLnno6/JcJ3mf32N6lhfIDVdOATkDiZ5mI/YUGw4IKZym2XMZP/85B6h+3zlq8JxAf6qGlVDo1WcwkQj5HHnT8IetsbblAtXDEBxvVnGQg8U4PvYcjG1UgF6IHAeDYBwWS3zs59FoLMPnxWYnvwJEM/VFs3AORvMMyEAxTF++oHnNUfuL+tl6KmRMXAQOhrhP7ieYhKLdpO5k3fvcdEM2PcSi83hCjknnNwekyCr67NyCrtdgffDYatiVR90wf2UwTqGi4BXC3VojLEizkuw1woHAa/4QK9BVbmTAGiauKp3ULBF22j4nMrYLui0ii8jZShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paD137QzPFq1tWJCgr5jmdYXC7lF30qWrL8US8AWHfA=;
 b=hl7V5aRjpXezGa4npXHEC6Uvd9G403TD6QfBFR5NorBHCkh2w2NYbfm99RA4tlKKEBG4pDFZd8Pq+5PAhMh3I5JWkMNHWTmSbRpmMv0DP9P8OVYq5Scql+f4VpNy4AYhCVTKlJQkq1sZU/pTFX0BWPZF177t8mBiuqNGs29+yIaWOEb98R+gbicJ4OFvWhFptAgppO6yzKgxK/UPXFIA8VRAWO7fnv3LE7d2AtBEpCfuHhG4MaeitThaNl2fq8adK4uwfD82VD1JEYCP1RQhk+KsMxvjnpMGUSyt8i41DoCDTccan+P1LOQNZs/+0GrjXX6kmgdKD8lYCAGOr66PNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Mon, 24 Jun
 2024 10:53:52 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:53:52 +0000
Message-ID: <ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com>
Date: Mon, 24 Jun 2024 11:53:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/30] sched_ext: Add scx_simple and scx_example_qmap
 example schedulers
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
 brho@google.com, pjt@google.com, derkling@google.com, haoluo@google.com,
 dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
 riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
 andrea.righi@canonical.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-11-tj@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240618212056.2833381-11-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0340.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f02ef56-0820-455f-9645-08dc943bef7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHhrVmh3R2EyeFd0UUNhWE1MSkU5dmw0d0NIb1cwRGdkM0JqcDN0ZHM3Q1VB?=
 =?utf-8?B?RVNXUWsvTXNWSjU3a3g3RWtTL2c0VEhwSzg3RWJaUlM1aDJjY25MNGhGZ051?=
 =?utf-8?B?YWhYVkwxTmN0SWpOWS9LSjNlcXlZREloUXgrR1JHdUFaODFzUEM0alNaUlJZ?=
 =?utf-8?B?eTkySjU5dmpqYzQ2ODRLNGw4QkI2MFpUNXNXakwzelkwZHc3czF6aURub1pn?=
 =?utf-8?B?c3pqMWxhTllNVzkyTVlzYXd3YmxmYjJnWTNQQW8yRSt1WE00dStsZ0xYRlJ3?=
 =?utf-8?B?bVl3WjJlUHFEeG1zWW5ZRFg1dUswMmdLeDI5YkdvRE94S2JEL09CQUp1SG96?=
 =?utf-8?B?d0J3UzlMSDRaRTg4bjF4WWxYM1QyYmEzaVpRZUFaY1BBVURobllEaWkwQ09S?=
 =?utf-8?B?QU1QQkxERk10SERSRC9Gbyt2R2ZhMnI3Zy81NzJaUTlKdGhQM2tVeG9WT2xC?=
 =?utf-8?B?NEViRCswU3YvTkhueTd3bzg3aEZXQUpLVm9nMFZVbHVNbitFekhDcGJjNEg0?=
 =?utf-8?B?SGZhQy9JT3Y2ajNtK1EwbkVBb1R5dTFXV3NTemxWR3dKRnYwcUllYTF3dDlz?=
 =?utf-8?B?YjNjQTVvYVVteUd5VXhIbU9VNVgrUTExalQwNkcySm1pZnNDSkJiQkZKYjN0?=
 =?utf-8?B?YWJqQ3pmZTA2TWd4Zk0xU1ZiYTEwOU16YjZtek5aWEpWQzFBK1dpRXBGNlpB?=
 =?utf-8?B?N0ZpQkRiQnB2ZkRKOTBDMnBQcE9ENXlzWTMxTUt2ZzJtREtVT3k1cGxabmNG?=
 =?utf-8?B?MVZHdkhraXd6bGh1ZkpydlJoN2FGNzhvOCsyZEs0bDh1UnV1UXN4R2tWcXJR?=
 =?utf-8?B?RHdGN2Rqa0RlckM2U2lPM3cxWXdudzI4SnhiWlRHaGRJcXdHdm1DZStFT2FD?=
 =?utf-8?B?M0pzUFJYNjlPVWxLWlBBTmZOdjFwYThhSW1RaHZ4TXV4amNvR1pDMlNBdGFr?=
 =?utf-8?B?NFhmeDl5NVhMYitibTY0QlVqTGlvVUlVenNtRFdzRVpxcmZQc2Fsb1FidkNl?=
 =?utf-8?B?RHhDMEMvdUprZW8vMXFNcStDc3NuNnlYUkh3eW9zU05ra2hZVmR5TzU2T2hX?=
 =?utf-8?B?N3hHcFNPL0IxTTMvSjZ3WUJoWFVxMklHZ2kxTStQMWxrVERibU5TTU9aMHZn?=
 =?utf-8?B?N1I5SnBtOVdzbkVnMlpGYS90c2tvMlc1NVcvSWFxdkhyTTBDVnlCR0huSFB2?=
 =?utf-8?B?WnpOSGhGcXFwQTlkVFdScTdvcWFiZDVjb0lCMlNPK1lTaXNnenZ4OHdCK3J0?=
 =?utf-8?B?a1VrYVVnOU5INVRkdC8vcURENHdQejRFc1ptRjRwaHlNWlY3dFl2UFZCZDAy?=
 =?utf-8?B?Ukw0dSt1c2p0M0t1MllPZ3VDLzBVeHdzdzl4ekxVVDlhdmlMSWZXUlJLQkR4?=
 =?utf-8?B?TXhKMlc5L2xMdkFjcEVPbG0wdjZjVytGMWs4cjBFZGhIK1ZpWkFIQnluWHpV?=
 =?utf-8?B?SnZxR1lqNWhielEyU2h3cU1FTU8rb09jS1lLMm05NXdvK1hQM2pPYzNmTlpk?=
 =?utf-8?B?LzRpQ1NjR2hnNVQ3dW5SYVRPQVFLNWlSWnVoT3AvOGcvdWZWNjJSTEZSa0Z4?=
 =?utf-8?B?YjhxY1pjR2FwTThkVEh4NjZZRzlnVTgzVFRSNWI5ZUJhaUp5Tm41dXMzQUNP?=
 =?utf-8?B?VU5UR21nY2NiQmR5Vlo2UXZTSk5rVjFyTmNnWDMxNG12eCs2dU5LeHZRcHZS?=
 =?utf-8?B?a1g3T2czSkRpZ09UNC81L0orRkF0cXZ0NUUrY0ZLL0hxdDdLUXJMR0tYeVk3?=
 =?utf-8?B?b2N3WGpDdW9qeXduVnVUcXlEbDFmYjlDRDF3ZjdCWGRRMmp2WFJGdUN5Tnhs?=
 =?utf-8?Q?IqnxjchGvwKRdcqy5xVLgwdDEDhRPNw1ZNzvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmQyamJBL0xHeXdrZlJFdmt0OWxKa090WDEwbFhiY0svMU1rTmJlV2p5VnQ3?=
 =?utf-8?B?VzFPSk4wY3REd3lDViswTUtuQmxGQmViK1VTOC96eEltMFFoQXdOdkFtcGhB?=
 =?utf-8?B?MDRUOGJBaVhBZEVYQTJDRU1VZVJTcFA4UVRWMit5TWNqeldQY1lEWVEyaXVu?=
 =?utf-8?B?bm9IU2RKTEo3TmkvNmE0ZUQ1VHpnRjhHVmxXSG14TExKSzd4UXh1RGxBaXk2?=
 =?utf-8?B?dE02Qkt5ZWcxZFpQNkY0NUdpU3dLWCtnb042MStuZG5CZ2hPajI3ekhXSkt2?=
 =?utf-8?B?aFNCVUdaenovRElCR0pndmh1SjZnbFIwNVRUK0F4QkVhUTZqVVVNeElsdE0x?=
 =?utf-8?B?eVVuSHFEOUUvTllJWExMcXhpend0bkVUd3orZnVjbnZGcjJnUG1QbFlmVDZr?=
 =?utf-8?B?UzVzNnhQdXBmN0ZjUThkRWZVdVpvTE04dGpNeHBvMlF4NUdiaklLV05HQnQ0?=
 =?utf-8?B?eDlzR0R6Z3E0UzYveVdyWmJENTMvenRJa1BGN0dEWGRVUDdJVWozcHNxM01C?=
 =?utf-8?B?b0xSaTl0UUNKMllON01NQkFWVTgzS3VyT0k2WS9vTEFyZDJsTUlZQVlMOGYw?=
 =?utf-8?B?ZGdKNnk4VGlIdGNWb1FMUjNVMGIwUEZEaVU4bjQvamR5bkIwRFQySU1oWWZR?=
 =?utf-8?B?eFVXNjZka1RFUUZzUmR2ZGtmMDlvaEdrZXdIaTE3Qm9PRlVFUXJudXBLaTY2?=
 =?utf-8?B?SENRbEVhZTdybmZSK2dOMm0vU1BnMmlydnNGelFMMm81QjlWRXNvS2hMT2Vp?=
 =?utf-8?B?bmVDZGJWNEpkZVp0TU1SeWZ6M0NIUEx1ZEVidzRoYVpnZ0FLeFlkaUtLNE5L?=
 =?utf-8?B?cWxEeXNURmhnS0ZFOHY4OUt3V1Z5T1RhU21TVmQ4VDVrQ3BtWFJvQm5oV0Uw?=
 =?utf-8?B?UEZKcmJBczZlQlFtSXkyZDNia2J3dW5qT1dWL3cyVEJOMkI3WFgzSU5QTGNQ?=
 =?utf-8?B?aTAxUHB0ZU9wT0dzOHFHOWcwemw0VWVHUUw1VVVxc2VxMHFaQTlKUHQva1Jv?=
 =?utf-8?B?SmJmbWVDVHd3N0Q4c2pZSy8vN1p1L2tSQnBRSk9YYkFwNjhadFYwdXczN3pR?=
 =?utf-8?B?VVJYUHFHOTJJWXpBV0ZGeWY1dEQvaUxtTC90cS9ZUmN4bXZ6WFBSQUpFbUJY?=
 =?utf-8?B?UVJGclZqdXY1OU9mVWx6VnZIK0VrcCtsakZpWjVCWGJURkRML2duMFc0dmg1?=
 =?utf-8?B?S3ZRK0NJTlhVWTdxeFJvMU9NU2liVXRFR2tFaVVVY0Jkd0lRa3k3cmxSVXl3?=
 =?utf-8?B?dysvc2VrbU0rU1hVdEFtN2lDaExRb0cva2VDUzFzOXBCOWNvRGNVN3dheGpM?=
 =?utf-8?B?MzlKaFVWN2JuWkFSSHRpS0wvMHZ0S1kzSHFsaTNCR09vTXFPWUcrZzJKVUJz?=
 =?utf-8?B?QjBrTlo3REdUZWlNeDZRTDNUNVhJTWw3VmduenRkTllHeERyYlVqY0NxMzZV?=
 =?utf-8?B?UGRRRERjUTcrRGNNaEx1YzU1b2J1elJUVXdhTGZLaCsvVi85SFNWUmg4VWlh?=
 =?utf-8?B?cFl5M3lUOTBPKzdqNEtaSVluMXZ2RWN0ZFFtVnJsaVVTeW1SQTNpekdoKzI2?=
 =?utf-8?B?OGt4bEZpM1c2c0Y4cVhsUnJYY2MrV2F0ZlNhZ3UzUTJVN01BMTBvNGJCSE9K?=
 =?utf-8?B?Y2RKTzRpZitQeDV6N3VkenE5TngrSm9DSGF1d2RHaUVZRHM0cGFnL0tjVVMy?=
 =?utf-8?B?L0ZvN2FZWEZRK3hNdU9BQTRWSTQvQWV2MEZLMUxtNHVpek4vK3doMFBUVUtm?=
 =?utf-8?B?RHM2c0xoMnVaMC93LzdGYzFab1J4UGIxaWVTNHk4bXhBNXg3ZXZ5VG9NOG9w?=
 =?utf-8?B?bGxoZ1VKOTVmMmloY01VZWh5STRyd0djaGJydWVTWmJ6UGdoem12RENHeUo4?=
 =?utf-8?B?QldZWHI2NDNyNjJ5SFZvZUxBa2ZmM0I5NWNaSFRxY2lwRGszMjE5bktuWkxG?=
 =?utf-8?B?Z2I2L3JpUjdwczg0dkFqekk3SERqdzM4T0hpNmdTMWIyekVzVmZGZ0xwaDA1?=
 =?utf-8?B?YnZuUWUwbnhvRXhXWGlKdDlxTDdrNUREQnA2UXptSmhSTCt3bnlxZFEyaHNC?=
 =?utf-8?B?ODA1TEUvMlNDMzRxZjU0aUI4YzduWGgzSWdaWXluVDF6REFZV1pxaTBhKzNj?=
 =?utf-8?B?ZHlHNWxZS1c0NXF6RHNNMDlJUmcwM05wQzU5OGZ3S2hWU2xSdFdiUzZVeG15?=
 =?utf-8?Q?KivB2n9q3FEnrGj26nUPXLk1q5YyUsI8Fp7dZPHHmgBP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f02ef56-0820-455f-9645-08dc943bef7c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:53:52.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XJ6+ZBS0x0MRN85Nqij2gg3uugI+D59emVPQbeMqldxAyLSFkRdDldEYb8kY6sFysY6oJ3V/JUtRgf7LLilvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

Hi Tejun,

On 18/06/2024 22:17, Tejun Heo wrote:
> Add two simple example BPF schedulers - simple and qmap.
> 
> * simple: In terms of scheduling, it behaves identical to not having any
>    operation implemented at all. The two operations it implements are only to
>    improve visibility and exit handling. On certain homogeneous
>    configurations, this actually can perform pretty well.
> 
> * qmap: A fixed five level priority scheduler to demonstrate queueing PIDs
>    on BPF maps for scheduling. While not very practical, this is useful as a
>    simple example and will be used to demonstrate different features.
> 
> v7: - Compat helpers stripped out in prepartion of upstreaming as the
>        upstreamed patchset will be the baselinfe. Utility macros that can be
>        used to implement compat features are kept.
> 
>      - Explicitly disable map autoattach on struct_ops to avoid trying to
>        attach twice while maintaining compatbility with older libbpf.
> 
> v6: - Common header files reorganized and cleaned up. Compat helpers are
>        added to demonstrate how schedulers can maintain backward
>        compatibility with older kernels while making use of newly added
>        features.
> 
>      - simple_select_cpu() added to keep track of the number of local
>        dispatches. This is needed because the default ops.select_cpu()
>        implementation is updated to dispatch directly and won't call
>        ops.enqueue().
> 
>      - Updated to reflect the sched_ext API changes. Switching all tasks is
>        the default behavior now and scx_qmap supports partial switching when
>        `-p` is specified.
> 
>      - tools/sched_ext/Kconfig dropped. This will be included in the doc
>        instead.
> 
> v5: - Improve Makefile. Build artifects are now collected into a separate
>        dir which change be changed. Install and help targets are added and
>        clean actually cleans everything.
> 
>      - MEMBER_VPTR() improved to improve access to structs. ARRAY_ELEM_PTR()
>        and RESIZEABLE_ARRAY() are added to support resizable arrays in .bss.
> 
>      - Add scx_common.h which provides common utilities to user code such as
>        SCX_BUG[_ON]() and RESIZE_ARRAY().
> 
>      - Use SCX_BUG[_ON]() to simplify error handling.
> 
> v4: - Dropped _example prefix from scheduler names.
> 
> v3: - Rename scx_example_dummy to scx_example_simple and restructure a bit
>        to ease later additions. Comment updates.
> 
>      - Added declarations for BPF inline iterators. In the future, hopefully,
>        these will be consolidated into a generic BPF header so that they
>        don't need to be replicated here.
> 
> v2: - Updated with the generic BPF cpumask helpers.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>


Our farm builders are currently failing to build -next and I am seeing the following error ...

f76698bd9a8c (HEAD -> refs/heads/buildbrain-branch, refs/remotes/m/master) Add linux-next specific files for 20240621
build-linux.sh: kernel_build - make mrproper
Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-4.15.0-136-generic".  Stop.
Makefile:192: recipe for target 'sched_ext_clean' failed
make[2]: *** [sched_ext_clean] Error 2
Makefile:1361: recipe for target 'sched_ext' failed
make[1]: *** [sched_ext] Error 2
Makefile:240: recipe for target '__sub-make' failed
make: *** [__sub-make] Error 2

Reverting this change fixes the build. Any thoughts on what is happening here?

Thanks!
Jon

-- 
nvpublic

