Return-Path: <bpf+bounces-61130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A000AE0F97
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2861BC3F52
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32C248F43;
	Thu, 19 Jun 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlF6kJuC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE121C185;
	Thu, 19 Jun 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750372093; cv=fail; b=S/8U2hUytq2MGDv0Ek7tLIRLdg4zqVuLgGp3wWBuTRXKDqZ9sVoGnJL74mRae8MaPqMbRAa+nhOFTGaaPwfIEBSEFuZf3bc8/FDeGxYyhlUNf4qlUyLaXRTvqW12amQ0BlxsMmW+5+/KDv01htnaNHb7i3n6otXDiYEV5Q5Jyk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750372093; c=relaxed/simple;
	bh=GGYdacQK3qOG5e07i0BFHps1SIMYIoj5PcWROh/xCdw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vuxyne/szqBxhFY4T/rKNizikrvGGwghjzUhW/KA2qoYYZIftHSoqB6iaLwjEmTifu4dG8SIvFcHz8SwNIIpDEHHvMFF8sYe53ASRMZG4RdcLDq57VCVEKj0Y202W3qL+us/ddauSgx2N+rutns75k4CZpSjrMbZ83BcQlcfq0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlF6kJuC; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udQ3uwl6mBZR7rmJwiLJc4j8L/vqaBmaKhue08IzGi7jo1afFM4G8t3WbRxgAh7TnSzig7TRu70GBVMJ6ovrHTAXVzJWJKk8ULXma4DtMTC5ylg/ReqncOJWreWNwdvAPiz7ZhcNOddpQ01pErGKOSv4Eh9El+monFpd81kUbljDO6O76tEABpHE6ItSRn6HVXfiq6Txelj4LA1HvZCiGnlkpREvOdQV+paoP3qYi3uu//XMndl4nmm71KbwJ+OqPr3/pfKMNJiVXAJCdKnvasUK2GxWpLKXudGuy4Zge4lPiFYsMLzxNVOLmnHvdhepvUIxgZldgP63XsQLKK7PAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oVQBD4blW3oroKDui60kST0hsfumhfu5XG+4aDZ6tE=;
 b=XPDDvOknJYZuamZ+SnJqMCQV6qgrzeA9xqy4Gm7jYErQ2CFlSHTz0pRULm9mKqNH2TVYu7+oD61Yr8pBBKj6VhTvDPl6dYS4GeX+v1VwnDr+QtKXXRBaWfX9TPXem75lq3GIssysY5svgGH+4n8H6lTFWN2tVc27Eg6QEBIJstikrucvoV+XcivXZLnrp1uEkZ2MN0yA+yhvsF4zeME5Wyw84oi0ehgJ4bhmy2oE2H5lIEHgOEmFHzQnTKNnGpv1tluukaEhnvJjxdyGG3ouIBPY1E/GNWED1nJeuEDdJtYlwvsXfERO6Y06HX02PU1hOt78aJ+6oXY/ZrgKoxZKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oVQBD4blW3oroKDui60kST0hsfumhfu5XG+4aDZ6tE=;
 b=NlF6kJuCB6D64gncNl4ELlLoos4NuV7/X/GMH+7eZEebKJcefKc3zj37JgvztB4ZGCsEuxKHjyubPnmyWsruJZ+je5lhTSMg2C3HfQQY26MNwMv5V+DNK+PQni+fJ1X+m5xa/CiqEljshWz1Nl2FjAEO/E0lcAp3HKC3XMCE6GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 22:28:08 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 22:28:08 +0000
Message-ID: <bb84f844-ac16-4a35-9abf-614bbf576551@amd.com>
Date: Thu, 19 Jun 2025 15:28:06 -0700
User-Agent: Mozilla Thunderbird
From: Brett Creeley <bcreeley@amd.com>
Subject: Re: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250619094538.283723-2-fourier.thomas@gmail.com>
Content-Language: en-US
In-Reply-To: <20250619094538.283723-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: d455919e-b6c8-4cf2-87b4-08ddaf809123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmJQQzBWS1NOaGgrM0xBLzgrM1BXK3JkWDE1Q2tuNjF0b0M3T29SampXM0lR?=
 =?utf-8?B?Zk9nQTZSUVRJMDU2V2tTN2tXRVBpbkwwUWsvNHZMbFJMdTRKMEZPUWVyZnpn?=
 =?utf-8?B?ZjBYblRTVVZuTEEzcjlQa0VEOHkyOUtjLzFtakhHd1MrU3Nld2xjQlVUZ29o?=
 =?utf-8?B?aHpDZmpGa3NCUnBELzZiZTVsNG1BTHdEQmRBY01RQ0p1anlsbHFETG5pWjBj?=
 =?utf-8?B?LzFFbWJwdjBLajBscWVMa2FmdHR4RElNQWcwT3RXUk1lT2p2dnZQRkROcklX?=
 =?utf-8?B?Q1ZTRExUYTBoMDA5MmpXMkJ0TXl0dW9pMTZLK0VGeDR4Z1lKTi9jbnFIc1ZE?=
 =?utf-8?B?RC8rUUdRL0tNVkRuVGdSNlowVTFFZ2tqL2x3TDZCUC9hUWFxcktaWENsSXVF?=
 =?utf-8?B?aU1vaElHTVFxZExJNzJVbWJHbVQ2bDRWd1cvbE96SnJZeGQ3dlV0OTZtMFh4?=
 =?utf-8?B?SWEvbFUrTm9JSVhicjlJMnpENGV2NVI5aTl2MTQ3ZUwvaUhNQTFRMW1PU0tw?=
 =?utf-8?B?UmsyYkhmenFDemxDcW9XaW5YS2hnK2R2dndYSmZWdUcxSi9pY3BWM3IyY2pq?=
 =?utf-8?B?WC9OTzdHKytOYXZDZ21jMjVMai9XSkxmNUJwNDNTbE1icXBjNFR6dWpxTTVw?=
 =?utf-8?B?aWJPUVJ3dWRGeWJwd2tJS3VOZitqVEJMc3B4d3NOazNqd1BKTkkraXFMMUE1?=
 =?utf-8?B?REl1TXNuZW9PN3B1WWJDeU1kZ3ZyUEZzWUJ6OWxuZzRTSEdpbW9XVUIxVDVM?=
 =?utf-8?B?ZXorUUViVHY5VzhNR0NqWitIQ0tvM0VTR0dyZGV4eHE0QnZuUDZMWjNmT2RJ?=
 =?utf-8?B?K2k0KytXNEdoU1Fua1lxYW5pU2FabVoyTXVGY2VWVGd1TXNOVm5xRW9TVlNM?=
 =?utf-8?B?d3dTeXNkSnkwd21zcVo2Z1JhVTB5UlU3d3JUU3ZSM3NRdlRESGlmbzdGNUdO?=
 =?utf-8?B?dkdrN0Exem5OR25lU3VIWjQwL1d0UjR0UUR5bVNHREdZQXRSMmREUEJ5c00z?=
 =?utf-8?B?K1BUSlhzdHRHb1VaS1ZtRnNjcFF3ZVp5VFgxL1E3U1dDOS9mSTZ3SXdQNWE4?=
 =?utf-8?B?SG81b0o1L2lyL2VMMkxva0VISm4yWUt3ZUZpM3Yrd1NIYmNKRWY3cUNXSlRI?=
 =?utf-8?B?c3FLTU5jdHduVzhsYlZac2Jsa2xsa1NxUUhXaEJodStoeTJIa3dQREliZVlu?=
 =?utf-8?B?ZysrR3BQa05UQU1FZ3hyMEo4aTV1M0UzMmQ4THJBM1piTjRWNjB6YkoyR01J?=
 =?utf-8?B?RW9keVlDbVRnTk1VYmt6dHhnWkJSQlQwcXY2QjUyamZPYzNHbXBJNjdHRzB3?=
 =?utf-8?B?dXU2NVpGRHFINktSSFFMS2M4TDRWclYxUkcybGJ2djFmOWNjUHcxWWRQa2FX?=
 =?utf-8?B?ZWEzdnNGU2NFWUV6cHJqNllFb1NSYTZHMlhWN2o1cEx5M01QRUtnZ3RDY0ZJ?=
 =?utf-8?B?NlhraDlURG9kMDNBVjlJdjFDWHZRWkZkeFNQdXRMTjFTT1o0UkJLTm40KzJS?=
 =?utf-8?B?ckNwTERHam5jRExKakM5OHNCZEhpdE9wQTc2eTZpMVZBUU55d0pvMDNEZ0Rz?=
 =?utf-8?B?a09NZEg5ZmM5R1FXY1pQNGVWRHVFRU9vUWdKeGhZQmJiUnRUV1Y2NmllYkRw?=
 =?utf-8?B?d3docVh0NXFxL2ZJd01SSjNvdGxnSkVuRWpOdk1VOGQrL3FBcEVYQkVhYU00?=
 =?utf-8?B?eG0yZEJoRDZKUUtlMDd6TUlmZWpyaUZNS2F6bkxXNHNzSlJaVitrYlFZemp6?=
 =?utf-8?B?N2NhNXJPMEphdFVzWmZSM09idlVCSWNmd0dwa29TbGl6L3Y2cktBYldST08x?=
 =?utf-8?B?byt0RjhCYlRIUHpDbzM4RTFtNEFFMHNtVWhuUVpWWmNZSmo2Y2FGRUNwSmdq?=
 =?utf-8?B?blVzZ3huVVdrOGdNUWpsMmZaZFNtTU5YdmtPMHdzbC8zMkRSbUR4dnJRa09O?=
 =?utf-8?Q?tmdlOzQ6xxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhFcTFPak5uSFVRRGNITytTNkpmTllELzVZL000NFliNUVEMVFMMUpQbkJB?=
 =?utf-8?B?Qm9jbEZZY1oxWHVOQ3dxaVNtUWhJeUhBQ21UUXZoVTFRZ2pvMWY0Nkh4RFMy?=
 =?utf-8?B?RzRwM3BLUmxmdEwxbUdsYTE5anAwdGdEckNYcGdTcXcyMGV6cXUzNVJWU21J?=
 =?utf-8?B?cWZSNVdvUGFPZldZQy8yU1JCSkVHUjBwSEdvYTBVelEvUUJOS0Z0TkNWdHVi?=
 =?utf-8?B?T3ZQR2ZkRU8rZkoxbmp6em1MN0FHYnBRUDVUc1pxcHJwOCsybUdBTjhFN3Vp?=
 =?utf-8?B?Y0VuS0xES1IrL29GYmVFM0drL29VS0Erekx4ZEhQSENuVkJNS0JXZlFlRWFM?=
 =?utf-8?B?cEpsQkY5NG41bW9iVno3Vm90UzhCVEdpaDdIMy8yVFBPSU5NS1dkZDdMSko1?=
 =?utf-8?B?bXF4MElIeW1reVlHaC9MbHZvZkNHUndBZytyS2NiM3c5S0RlVGlvUjcxWEhh?=
 =?utf-8?B?ekdqMDQyekVnMUR1YXJvODFJQlREUGJnakc3NHVVS282OW9hVVBxQmhjaU42?=
 =?utf-8?B?UldieGVYVzhRMUprSlRpUkhzM2FUVDhYYzA5bGhVMnlDK1ZXNnNkNXpBMjVH?=
 =?utf-8?B?ZENGZERrbldDWlJucjduUHhBMDNWalhtY2pidDc0eEM5dlVyaTA5aFZJZEYx?=
 =?utf-8?B?c21maUcrUEpIYVR1MWp3clZCT1FpMnJtSWU4cDBUdmFBdW1Qd1BRWHpkZzBo?=
 =?utf-8?B?c1JNNnhBbUdNNkp3MDIyUW03dUNYeFhaSnhpYkd4UXJocUcvTkpGKzEwVGZC?=
 =?utf-8?B?eE5ZQWRsTENWNWFYTEV2Z1RuUjdpQTdGSUw5ekRlbmZETkgwRnY5NS9Fd1RB?=
 =?utf-8?B?bUw0eEZEK1RDWEtUcDJhaS9EUnhpbGdOd1RpRzBQV3pISXZuYUdjQ3M0eWhH?=
 =?utf-8?B?WXNrbDFDdU5vcU5ydlJVYmgvbDV3Tll4cjVtUGNRNFE5TVNFcnVONmorVHRN?=
 =?utf-8?B?Wk9RVHJvQzJjc3NpSEFicWNlMWc2M0hCc0lyWGFzSjh1cXJMOE9kY2tUUVlv?=
 =?utf-8?B?MHBHMHVpNFpleEN2WUlYTnNYZFcveGJIeFhaVE1JU0IvUlZXWEh2dHZWR0lF?=
 =?utf-8?B?dW1Ja3l3a0dpR0Y4RVFFcGlqWDZWMkVDTVVtQktkdnk4VE1OSC84bzZQMTRi?=
 =?utf-8?B?UysvVnI4VnovanlpaGxWaFMyNXJoQUkzZ0N6ejl3ank4V3FTc2hCNENrcWJY?=
 =?utf-8?B?UWRZd2VHMktHSHlOblppRGQ4RTA3RHJmOWRTeFZmU3ZVMUUzc1haRk9qeStC?=
 =?utf-8?B?SjBzQjdtZEJpUzkrUXh5YWpFRFdFdDNmZDNpSG9CV2RuTHVEZGhZYW4wemZH?=
 =?utf-8?B?dHE0MmJmbHVxb215dTZ2cUhVWVEwOW1JU3gvak9wZzYyOWRqY1VsUzVYcTJE?=
 =?utf-8?B?WDdTZmZUL0xMbUxWT0JYNE0zVFNNQnovTFNVWTVvbWx6N09mV1dPYVhvNjBt?=
 =?utf-8?B?VDZINmJkRUVWNXl1STFRTWFacDRPczVONjRGa2EwNEExOTdONWdaR2x0b21P?=
 =?utf-8?B?WjBVMWFZb28yZ1RMaUMySU5kcTUzZTB1clRHTkJFRUFJSXBqbkwwTXNtQUI4?=
 =?utf-8?B?OVRZYTE1MTh6cktaMXVYNEU1Vlp0R3d3LzZoMEd2UTNVd0ZHTG1KdGI0SmJw?=
 =?utf-8?B?cmpjRUZoSlA3UElPbFozdFNkRHJBZ0E1Um1aZDRPeWpVY1BnZFl3OE5FNEVO?=
 =?utf-8?B?VzI5cUhyd2VPQ3U1RUxRdGxQMDRYcVRyQm5Fb2FvTkEzYU1zYWk0MmluWWtM?=
 =?utf-8?B?dzFsdi9NSkNDNlZPOVdRRG8zeC9rK25kZGEvd0pnYnhrNHdBejVpQ2FMQk1w?=
 =?utf-8?B?R0xkQXRzdllZUjB6bkJRNTcrcitkWEhLK2VwdzRVK1RPY0tHSGRpNFFlbHMv?=
 =?utf-8?B?emhOeG8zb3ZBL2ZBbWM0N1lmeTRpWXovanhRYmZ2R01vcnZ3TGczaUc2aFp6?=
 =?utf-8?B?RDV3b215M0VSUklhZyttdHduN00wUkpBZU82OU8wNnRIUzM2WkUwZ1FTR1Jv?=
 =?utf-8?B?WGNlMDlXaVNwSlpCd0R4YjR3SUNtSEtSZWI3bTErdlFTQloyZ0Uvd3AxWnRF?=
 =?utf-8?B?cVRrOHdTNFhrYjUwdm51bFQzUWl1azZNdU1JTVM2c2RiWHdIYXJjQWtzZkNB?=
 =?utf-8?Q?1Q37Q53SBI2je3Qrg/P0afNYB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d455919e-b6c8-4cf2-87b4-08ddaf809123
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 22:28:08.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPIhiouTpa57epYBr5KfozzjQ3Vbuh6nje/RGiOzKUgcjgPiGYICwsntnkz4jWi+oG8Z3o0b3asoclRCo0EUNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784



On 6/19/2025 2:45 AM, Thomas Fourier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Change error values of `ionic_tx_map_single()` and `ionic_tx_map_frag()`
> from 0 to `DMA_MAPPING_ERROR` to prevent collision with 0 as a valid
> address.
> 
> This also fixes the use of `dma_mapping_error()` to test against 0 in
> `ionic_xdp_post_frame()`
> 
> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")

I'm not sure the Fixes commit above should be in the list. Functionally 
it's correct, except there being multiple calls to dma_mapping_error() 
on the same dma_addr.

Other than the minor nit above the commit looks good. Thanks again for 
fixing this.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

> Fixes: 56e41ee12d2d ("ionic: better dma-map error handling")
> Fixes: ac8813c0ab7d ("ionic: convert Rx queue buffers to use page_pool")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 2ac59564ded1..d10b58ebf603 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -321,7 +321,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>                                             len, DMA_TO_DEVICE);
>          } else /* XDP_REDIRECT */ {
>                  dma_addr = ionic_tx_map_single(q, frame->data, len);
> -               if (!dma_addr)
> +               if (dma_addr == DMA_MAPPING_ERROR)
>                          return -EIO;
>          }
> 
> @@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>                          } else {
>                                  dma_addr = ionic_tx_map_frag(q, frag, 0,
>                                                               skb_frag_size(frag));
> -                               if (dma_mapping_error(q->dev, dma_addr)) {
> +                               if (dma_addr == DMA_MAPPING_ERROR) {
>                                          ionic_tx_desc_unmap_bufs(q, desc_info);
>                                          return -EIO;
>                                  }
> @@ -1083,7 +1083,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
>                  net_warn_ratelimited("%s: DMA single map failed on %s!\n",
>                                       dev_name(dev), q->name);
>                  q_to_tx_stats(q)->dma_map_err++;
> -               return 0;
> +               return DMA_MAPPING_ERROR;
>          }
>          return dma_addr;
>   }
> @@ -1100,7 +1100,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
>                  net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
>                                       dev_name(dev), q->name);
>                  q_to_tx_stats(q)->dma_map_err++;
> -               return 0;
> +               return DMA_MAPPING_ERROR;
>          }
>          return dma_addr;
>   }
> @@ -1116,7 +1116,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>          int frag_idx;
> 
>          dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
> -       if (!dma_addr)
> +       if (dma_addr == DMA_MAPPING_ERROR)
>                  return -EIO;
>          buf_info->dma_addr = dma_addr;
>          buf_info->len = skb_headlen(skb);
> @@ -1126,7 +1126,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
>          nfrags = skb_shinfo(skb)->nr_frags;
>          for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
>                  dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
> -               if (!dma_addr)
> +               if (dma_addr == DMA_MAPPING_ERROR)
>                          goto dma_fail;
>                  buf_info->dma_addr = dma_addr;
>                  buf_info->len = skb_frag_size(frag);
> --
> 2.43.0
> 


