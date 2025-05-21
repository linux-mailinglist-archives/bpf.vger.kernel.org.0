Return-Path: <bpf+bounces-58678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C64ABFDFC
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F84500C60
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592629CB26;
	Wed, 21 May 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVG8E4aN"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B3221713;
	Wed, 21 May 2025 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859833; cv=fail; b=hWEeyyiBvT+yZaUWDdHH6C1RVHGtBEqdsgxHxIQ7TIjVpcDV9ATVxhUtKgiXNRwQxNOFXgaQhTzScS/pbzY6FFXPRPmbFl70Q6l3OJPR4NLKAqCGLMG4tw+sh9RyJ7+GUOceTyLe9WlU4a7VpMDFBsFgQvtyWUup/L4yyH0vmGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859833; c=relaxed/simple;
	bh=X8Dmd3brm0NYJU60liJ29FCbevGp/xiJYCpabyWt7Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJH1Q3LYZg4awiqCTNTENmCnpKWGR5qX/tiCl0CIY6mqZtECzFA9qAxt4JskpHr232OFV2fteBirs9NW0PTR1yBMg4Lea/oH2QWw5DH+OzrE941RtjvKyxqAFxKS5ysbQLiZ1O0yRmJLk/69FH78nDqy4txS2o8bMjDWnjx2sHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVG8E4aN; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Smev3S5B7UaaGcDB0CiBSNKt7JJ1nD8deFEGb8UATDJlh19KISYxn3OTZ1VBYCrg5C+VxnlX1yfIjcM2cylRk/5NrBWfGWV5FAZZmSXkQV3X+3iAfs/dbiAM11Xc+nwUxcwLL0FByBQ7/ddIl+W9HwNIYXAu6k2W+4rGU5SaWUOvp/7zj/mlyw5rnb/wzuiMOsayswr/4KkMqXqidEhocU2iGE9ZTJrEGCW/JYqgIkhI5YloPlHclJgp9x5L69A6I12KwkAmsypT6N+MP1iOku119cBGw1SMAzoEn27DwiVrUN2putIzL23wu5x7uO8uM1WzcHYBgL+6fUBEyCRbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Dmd3brm0NYJU60liJ29FCbevGp/xiJYCpabyWt7Ws=;
 b=J2n8ZsK9f4kyqEtKH71GYRYFCHMvA5D4SSLsdcQzCfFlRg9QWyjTRlWXZDtzCjx/iordnynXI1YOxGqqrjqd1iOM0Cs6o8GY5BrF6QOozTTU4EIx74ndUMhEPwCzVdw2b+hB4Mqyl02RQcU3r6b3YEpgdKk64sXTLa9Gk9KH7dSA91gkUXfXaT1P1Q1vGmX6s0ZqWXP19sEqV4xwHf35+QUeMXrdLQI4EL066hbEeaUoxdYR9DBHR+gaodOQn2TNb46OIojlLpHBV3PxdNv803ityEZ2nUcqbiHRUZmpZ6bj57cVVp+2+ylqeSkDnCfRHL37vVldLgjcE0Y+1CfOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8Dmd3brm0NYJU60liJ29FCbevGp/xiJYCpabyWt7Ws=;
 b=SVG8E4aNzngPca6hI+KzqP++58BlCFjWXYCXKr6SHZpRXS1SMaW06y/dUJCIUuw5bO0r+3hzd3PmAcVAzFEA+0tmxuLAe+4Dwu02NgZ3J3AL+7i6RSziIoLKgniFIOXhZeeXLpkqnf0XfGhciBkiFqu11hMh+5R7lTxAOU8HYKnLrnvX64xsr3Gr+5WBL5QngDtBTLkwXNLvnax22AF6wNegWN10FWMU3v5iBqR1j5pafQXhwJcJiPBaua3WVYjH9yRS0P9YK8lVsAgtiv2FxdXlLeXLMeQU15CDT3/xu+I+/+iF3SFyE4QCTG5XRHlzrGw6hGQHxM6PTrqbyUUBxw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB8556.namprd12.prod.outlook.com
 (2603:10b6:208:452::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:37:08 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Wed, 21 May 2025
 20:37:06 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org"
	<hawk@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"leon@kernel.org" <leon@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mark
 Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 5/5] net/mlx5e: Convert mlx5 netdevs to instance
 locking
Thread-Topic: [PATCH net-next 5/5] net/mlx5e: Convert mlx5 netdevs to instance
 locking
Thread-Index: AQHbyklaQVifLVVgpkiWqJ470WzyJbPdZ16AgAAkSYA=
Date: Wed, 21 May 2025 20:37:06 +0000
Message-ID: <4ced8f1c8228eeb80f78677a46c3ba7ca3de2bc3.camel@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
	 <1747829342-1018757-6-git-send-email-tariqt@nvidia.com>
	 <aC4bAXlevrV5venn@mini-arch>
In-Reply-To: <aC4bAXlevrV5venn@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB8556:EE_
x-ms-office365-filtering-correlation-id: 4d6c1642-234f-4d29-d693-08dd98a7403f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1hSODV6OUVYRlovd1YramoySmxVenhkc2dGdXRJbjlmZjdvMm1VeGx2aEZM?=
 =?utf-8?B?WnU3N1B2enhxT1c1VnB3c1hPeW5KMlB0ZmlmZnl4SG5Ra3drL3plbzAzOWdz?=
 =?utf-8?B?Y25iNTNJeVJwUERxNFo1K0NwMmU3THh3UEp0bzVIZlp0blNldWRrMVVaNEll?=
 =?utf-8?B?bWZvY2kveENMRzlKL0xMZ0ovNWJwY0htK0V4aStJMW9WY25IcldwRkhHc0Vz?=
 =?utf-8?B?U3RvN29WY0NWbG5SMG5wNW1JRHlIRk1LdlZhVmNyR3NZQUxTcUtrdm05Tm4x?=
 =?utf-8?B?NHZDWi9ZeDZlNnNZZ3BRR1BiSEhmWHU3Wm1sWkROc3Z4dGgvamVCbExwM3A0?=
 =?utf-8?B?S1RLdndqQ3RSRkhwQXR3cURjbS9waUhNNzNNQXBCWjB6dHN5WEVxR0lYbHFW?=
 =?utf-8?B?NVlGSkQzdExuSERYbWVrQWRoZFp5N1Z2bFRjRFc4RmJQTjB2OHZXeGtkcjd2?=
 =?utf-8?B?SlA0bkIvRE4yZWJIdkM4RTNJZkRiZGhMbnJGc0N6b041WkpRb2laS1FNV3Zu?=
 =?utf-8?B?dXQyNCt2bitNUkhudVVsMlFOZzZZNTBPMjRqRnlQdlBQYytvTUgyT29KUTFG?=
 =?utf-8?B?Q255QTRDMXJKckJyYlJxQzNIaWF2ODNEeUVBOFZzOU1JN0lGa2x1ajl3SnlU?=
 =?utf-8?B?dy9OV0grYTFQT1lKMlNnTWNVdXN4TXpRR0NKQ2hRK3RldTZmcWdSRWxaYkVI?=
 =?utf-8?B?d3VTcnhoeTk1UlBCMlI4ZDhvdFQ3cGk4Zlk1bXJ0alJLN0NzV0dJRENIRlE2?=
 =?utf-8?B?eWkrdURmcDFkcmJ0YTlKR1Q5NFRLWTBySFNrMTJSdGxvK3NIQmcxOWRKTjZM?=
 =?utf-8?B?ckQzNUhxbWV4Z3JrbVcweWtERTgvdU14c2Zsd1N5MDNlcSs2aVJ2RFNIOWVo?=
 =?utf-8?B?Y1dhRWlMVjVhM3RMbi8yU2lEMkFwUnVBeU9FeFZvamR1dktaM1RWczdoVzFz?=
 =?utf-8?B?dk96eDlZMmVyeFBGVENhOHI1Zkx0RWhkYTN0VHY4NzBod2ZPY0tsWlFSdThL?=
 =?utf-8?B?dTNTM2MyTENwZUExcEt2VG0zcmFrcHd0ZzFJNlBLdXZWWERpN01CTWh6VDZR?=
 =?utf-8?B?dFZOMXB4Y1lVbU1KWW1rM2lwV2JXMHlSSmxweE13STB5M3hXTVNZY0hFdFJS?=
 =?utf-8?B?NUVsV2w1V200RGpSY1VEdFpLVFN0OFlseTkvZEd4M3d5cEV1NTZqaFltOExR?=
 =?utf-8?B?ZE5sYU1id1F3RmluQWNObmE0S2VQSHN4VlJ3ZWpBZzA2TlR2NjF6VU51TkJN?=
 =?utf-8?B?RzA2UU0xeVQ4SDJEaGw5MmFWNjdCeW43S2o4djBTOXJSMEtqNDdGMWk3VjZL?=
 =?utf-8?B?eG1sR20ybi9KWFFyRTYzcDE4b3NDUlFrd3N1N0VSK25WUFRidUxQVlMyRVZL?=
 =?utf-8?B?WW1Pb1BwSDdhRlk1azRjY2dSemhBd0IxeklUa1QvaDNJNFZmZUJxSjFxVGxL?=
 =?utf-8?B?QmEzWXNWMjdOb0FkODlYK0R1ZExGRGdMaDBwcWRDcHR0NnE3N0xTUkt1aXAx?=
 =?utf-8?B?R2lwR3pUeHgzZ1ZWd2RJcVdDWkQxWXJsOERjWVhEWnZNcGRscHFBd05NcEpl?=
 =?utf-8?B?MFVlUEhKNW5xYWE4ZGlaZUVsRE96amxjNEpvTnZvTkxPNENzL0h1bTRMOGhq?=
 =?utf-8?B?V1RPVi9KY1JVbjduQVVQdEJJcGc3R1N1bmdYUGJBQVRKQ2xvdFd0Y2FiK2N0?=
 =?utf-8?B?Wlo5Y3czWGV6ZCtMYkhZS2l1S3NLaTcyb2t2MXBoQXNMUWE1UzBCdDcyK1Za?=
 =?utf-8?B?V2dtK1pmdDJUNXlFT0lhc2ZYU0VRL25rM1ZPaFl1R1ByaFkvWmZaaVVkTWNl?=
 =?utf-8?B?UmM4cG5URTA3c0NaSlIrQm9aY2lGVVFxTjRDVWljQWsybnl1TFdrc0lMWUdD?=
 =?utf-8?B?dkNnWnhzM2ZYeEgyY0s0eTRCOFFqOXZlbE00Yzc0b0tjZS9hTlY0R1VtK01V?=
 =?utf-8?B?cHpXckV5cUZKc2EzeUxKak44Ry9mNUZVeWl4L2xkSWZqbnFSRU5ZcjhjTnhu?=
 =?utf-8?B?V0Mzamg2OTlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djk2T21oNHJYbEoyZWg1Q2NWNVBDY1lBTVZMejJzZUFReUpWY01QenhHMFBU?=
 =?utf-8?B?TFMzcUlLK3Q5MkMyd0E4ZEhFNEJmajV2VEZ0Y2pYZmFLanFUajdqWFlpOWpD?=
 =?utf-8?B?QkxMZFNKWkYyMmFnSlNnNFR2TG9ZZHZ1eTB4aU14V2YwMFNyNXNRWGt1bU5P?=
 =?utf-8?B?dnB6SWNqbE0ySVlpS2lRMGRJV0lNN1hVRVNQQW1wcGRvdE9KdFg3bWNnTTNT?=
 =?utf-8?B?YmVsa1BEYnZFNm9WQ0hRTXVJOStXTUl0YzVaVVdmU3JNaE9Vb20rTDNIUnVU?=
 =?utf-8?B?MlJEa3FvbEVEcVd6ZWovWnJrQXRxQ1h4eC9PNmROZTdlSExLc1RRU2lVd0kw?=
 =?utf-8?B?YkpXUzl0VjMvZnc3bWt2K254SnIxUEV2TTBrRFVTeUNCTWZRRlo1aEN4YWJV?=
 =?utf-8?B?a2FmLzNBZUEwWkYxWXRWeHhOdmhuck5rOW5wLzJ0ZnZXbW1BbldzOSsxZlhJ?=
 =?utf-8?B?RThHSFJPRk82aG1ETUViZHczQUVZbFY5NytBS1hWcXBkK0pyUk1obUJlZzVZ?=
 =?utf-8?B?VXdqcWVDcXNFV3hGMmJ6akdQbktOb0h1ay9sd3hUUkI1a1NTZGVIVEREaHhY?=
 =?utf-8?B?QzEzVi9JL3ZpVHMycjZzaUdnZVltd3UybkxrNHlkV1BvNGsyc3hQUU15YnEy?=
 =?utf-8?B?WTVEcjBBd3pCVGpsMVdFRUx3L2xqMnd4Z01md3ZxUHozNStIZXdvbVVYQkhH?=
 =?utf-8?B?V2tsTTQ3L1AzNmx2TnZPbkVLTlNSSlI4Zi9SOGJmNzhmMEFMOCtSenprSS9E?=
 =?utf-8?B?SjV5Qy8wbjNpaFZlQllQaUZsNzc5RVZOTVlzOUN4UEd6UFZuVGE0d2Rxeks2?=
 =?utf-8?B?WjFVcjNQeTdaaWhObFpnRXZpZGlMK1VFcC9OU1paV3d6aWdJa2NBU0dLMGVh?=
 =?utf-8?B?K3IxOHRFdGFKcUd1QjQyMDV6aDZmN2tseGszY3IrbXZ6VmwzVlJwY3pBMXp5?=
 =?utf-8?B?bGdoeXliUzNYVFlMdUNnVHpLOXFaMU9jU0JuUWllVEMwZ1hWL2NpQ0c0bjJC?=
 =?utf-8?B?RXFjTkEvZkhBQnc4WHMvMW5VaXhpRmJYdTBzNEFhdXVDR01tb1hQWi9lNVN3?=
 =?utf-8?B?TXd4azVOeUd2NllidlplYktmZUhJanhqU3RVbWVIdUFFelk0d1RrQVk2cjdy?=
 =?utf-8?B?bVBlVTRTVDAyVlhMYkpMclhmRTgzZ1JnSVNiREx0L3grVU9GdXBvWDFoS3pW?=
 =?utf-8?B?cFdhaW1ZYUdXSVRMMG1mYXFaOE5IM3hJcnNEbUszNmxBSWFSQ2VBL05aWldh?=
 =?utf-8?B?MXNiNGk4d2NMNS9VZjhPNThpT2s2T0F2TW40cWNqRGJIRGFEMmxkTHNQQ2Vh?=
 =?utf-8?B?NG4yRTZadkcyYVo5SGdQV0wxSVJQV2dPQlN0cHV2TTBrTkVFcVRzN2psZWRI?=
 =?utf-8?B?NFl5TFMvampjZTBScWRGYlNRTlA3R0hKcGpSTzlERzFTcTcybVh6Z09UMnh3?=
 =?utf-8?B?eXZXZWR1TjVUU3Rrcnd0Rm9KNDdHbndGOXM1bEFNYTFMbldneUp2WGtkbUdG?=
 =?utf-8?B?bjE0YWtPWUt5WXpjdmRGaS8xWmx4d0RaSWxONmxrdU5OYmdvVW0xT2c0VWIx?=
 =?utf-8?B?OWFtOGFjSTV6ZGlHczU4TGJ4WHJjUTVPOU4vaXpUOGk4b3B3RFBqWUFRbVl6?=
 =?utf-8?B?S1JkY0tza24vSGhYbjYzL0lNS1FZejJpQlpYTXZkUVUrbXRVanJCdlpVTVdt?=
 =?utf-8?B?WS9qWUVUVDlvWGMyd0tJSW5oMHo4aSt6VWIySXNGeTdsTDEzcmpnS0FxLzE3?=
 =?utf-8?B?YVZqSEZnNHQvMWhaOC9CMlVlcnNjdVQyeDhNMWF0MHl2Z2tFdlVxMHBZdHJu?=
 =?utf-8?B?VmtQNld6ZGI0VW5yd0p4SUxsNklIL2ZIL0VhNVJCNGV5dmhKRkZVVzAyRXdL?=
 =?utf-8?B?dDB5eTB3UzJOaTU2eDBqeHg5aGFzUXlick9ZVEJ0eFNCa0MvdlJoNEFpS0Yy?=
 =?utf-8?B?VVhRN2dhMkhSRFU4a0M5M1hIQ3hKalhhSlhNVElhelZPcytQL2E0eHBOSnpH?=
 =?utf-8?B?cCs3bExFVmIrT0drZjJ2d1R3azZkMWdoOXkwaEEvREN4ZXpvS0xPUjF5elVi?=
 =?utf-8?B?b3FWaXU0QjliaFVFVWIvTkpLVFJETkIwNUQvQzR0QVJZZGFYVVp1TjdDT0V1?=
 =?utf-8?Q?J+ddP7Cqe3zzguRh1PVks/MXr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <070BB0193EC257489D03758E5A61596C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6c1642-234f-4d29-d693-08dd98a7403f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 20:37:06.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2tNgFv666KECMKXrCzWhssb2sP3lbRPajnY1OC0KIuA6x4YkFQfDbp9U+Cw7gWmH+Yr6/zFBhZ8wzsZERMhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

T24gV2VkLCAyMDI1LTA1LTIxIGF0IDExOjI3IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA1LzIxLCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvaXBvaWIvaXBvaWIuYw0K
PiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2lwb2liL2lwb2li
LmMNCj4gPiBpbmRleCAwOTc5ZDY3MmQ0N2YuLjc5YWUzYTUxYTRiMyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvaXBvaWIvaXBvaWIuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9pcG9pYi9p
cG9pYi5jDQo+ID4gQEAgLTMyLDYgKzMyLDcgQEANCj4gPiDCoA0KPiA+IMKgI2luY2x1ZGUgPHJk
bWEvaWJfdmVyYnMuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9tbHg1L2ZzLmg+DQo+ID4gKyNp
bmNsdWRlIDxuZXQvbmV0ZGV2X2xvY2suaD4NCj4gPiDCoCNpbmNsdWRlICJlbi5oIg0KPiA+IMKg
I2luY2x1ZGUgImVuL3BhcmFtcy5oIg0KPiA+IMKgI2luY2x1ZGUgImlwb2liLmgiDQo+ID4gQEAg
LTEwMiw2ICsxMDMsOCBAQCBpbnQgbWx4NWlfaW5pdChzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRl
diwNCj4gPiBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiA+IMKgDQo+ID4gwqAJbmV0ZGV2
LT5uZXRkZXZfb3BzID0gJm1seDVpX25ldGRldl9vcHM7DQo+ID4gwqAJbmV0ZGV2LT5ldGh0b29s
X29wcyA9ICZtbHg1aV9ldGh0b29sX29wczsNCj4gPiArCW5ldGRldi0+cmVxdWVzdF9vcHNfbG9j
ayA9IHRydWU7DQo+ID4gKwluZXRkZXZfbG9ja2RlcF9zZXRfY2xhc3NlcyhuZXRkZXYpOw0KPiA+
IMKgDQo+ID4gwqAJcmV0dXJuIDA7DQo+ID4gwqB9DQo+IA0KPiBPdXQgb2YgY3VyaW9zaXR5OiBh
bnkgcmVhc29uIHRoaXMgaXMgcGFydCBvZiBwYXRjaCA1IGFuZCBub3QgcGF0Y2ggND8NCg0KSWYg
eW91J3JlIHJlZmVycmluZyB0byBlbmFibGluZyBpbnN0YW5jZSBsb2NraW5nIGluDQpkcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvaXBvaWIvaXBvaWIuYyBhbmQgYnkgcGF0
Y2ggNQ0KeW91IG1lYW50IHBhdGNoIDMsIHRoaXMgcGFydCBjYW5ub3QgYmUgc3VibWl0dGVkIHNl
cGFyYXRlbHkgZnJvbSB0aGUNCm90aGVyIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCwgYXMgd2l0aG91
dCBhbGwgb2YgdGhlIGNoYW5nZXMgd2UnZCBlaXRoZXINCmdldCBhc3NlcnRpb24gZmFpbHVyZXMg
ZnJvbSBtaXNzaW5nIHRoZSBpbnN0YW5jZSBsb2NrIG9yIGRlYWRsb2Nrcw0KKGUuZy4gZnJvbSB1
c2luZyB0aGUgZGV2XyogaW5zdGVhZCBvZiBuZXRpZl8qIGZ1bmN0aW9ucykuDQoNCkFzIEkgdHJp
ZWQgdG8gZXhwbGFpbiBpbiB0aGUgZGVzY3JpcHRpb24sIEkgY291bGRuJ3QgZmlndXJlIG91dCBh
IHdheQ0KdG8gc3BsaXQgdGhpcyBjaGFuZ2UgaW50byBzbWFsbGVyIHVuaXRzLCBhcyB0aGUgY2Fs
bCBncmFwaCBsb29rcyBsaWtlIGENCmJhbGwgb2YgaGFpciBzcGl0IG91dCBieSBhIGNhdC4NCg0K
Q29zbWluLg0K

