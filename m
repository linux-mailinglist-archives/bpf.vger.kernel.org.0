Return-Path: <bpf+bounces-65595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C07B25A46
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 06:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249B85A3233
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5E1DF98D;
	Thu, 14 Aug 2025 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KMKqpAo5"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013031.outbound.protection.outlook.com [40.107.44.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA379FE;
	Thu, 14 Aug 2025 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144329; cv=fail; b=H5kBCZM2Gf1G7BjinUNusuf913ESB/LjGj8LqulSUDFnGbm9f8/X8T10BVe8ZEmE4D+Ttmgpp5nhFC/riSwHc1sr3RAsKlbEoyniPX8aTomK8npVEMvjgFAEVXILQMm+iI0o39qKp/p02kc3/sNm81TmVEOILvObfZaT0QcmS0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144329; c=relaxed/simple;
	bh=tlTBav+nF0lMUfdd2bwdCkxtUVGl75KO0zwkh6T5TRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtDODcsdEIlTmemYrILgj/tN1iQglpL9pznS4/dYg4diqKz6+0vPfBHOou0GujYHYg7AnX3YzGbXc3XoF3QeK61FLCsFbD1q+9P1IvpYiyCMF2DehNfNmMn290zqZG5zmZgPNRVUfOwwWuK+JUaFoSTeWQeis5GKh+FK6p/XKPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KMKqpAo5; arc=fail smtp.client-ip=40.107.44.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbTRkBRpJ21E+HZDau4/VlwoDSLefnO13rGUy+k2eFOoI1tS526x1G7jkFPWKVnG1YxU6HGRbpAXADcmfRF2yoQ3446DkpwLqoyFon6XDcOtiQfQja7smKyJQk2mGFNTnxozxiPIkrwbsQuzCgG6bpWS/rgh30aUkWZNrwzNJTAI1z2/8/Q9m9udzvLuqoRE+034CkrQyfaHPQayWsvsJsw3dSVj/I9Zq/OS7V76n6JkqZvEMDjSvCXUp+QpllqM6Fpy0+Jqyxjq8FWLffvunstM3tk1jb1Y9IG1VJXiyO9FFknza3AA4ZOYeeis+ao3ga59aABkZtWTLtjT7ST16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJzT67HdZE1NAGNXGulSJ85bMeBWfOk2btMqYvRcR+g=;
 b=mzg29D35f9FYobESlTzVkQJeVUQdAH/ioecKf3FYXoZKw6RBnofcGyzScXrz+waVM2AZWCr43wmvOKK6x9BN+R4L7AFjgCac3sUC5LSXkR2DLidGoeOlqKivkt6WlzEemKpz3ro0iberZERI6PaEsP0MyVVZS6BDcJ9jU38QenjJYcPWb5vC+PCfjDMZROcYX/4cIs5E6pTNU1S2CmTD+CPUpDt3ELt6+pRF3CKEecX0spdE3tKwZetUpymq2syYEmEVN8xkd4t3sx5DCaYFJHugNBFxlBmD/G2NGcDHiaEghJ+5v7ltMnaLN/RjHTECixGUta7i36SXv06Ltw/JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJzT67HdZE1NAGNXGulSJ85bMeBWfOk2btMqYvRcR+g=;
 b=KMKqpAo5rnOQqxbN8R3pS8jLdgKZVVNe/9klAtaPPQZWryiZZC4Xq3LO79K2KGSpOHygzItIOJvtBbVGhnYIA5JzeDxBk1mmTaNMZWzeG03D7tFdZnEhtmQrndLmDfMF/tsmbtq4h4jB4nNUpj/fAg/tg2t373S1ueX0uqW+dqjAYIpHkeAoWhubW2scRk8zN7US6GavNNVAxeyHrQJP+Cl/AdLFEQiDcCrlupRj3FcPDmvNpJGq2uFC6xBN+V3MZgIk+/g7sefU/Y938CiYEhl7BDwbUMeIt1bq9Pg1w7T26RqktsZ8abK5PssdLKSCs10XyRM1OGAMPZY4CqY9Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KUXPR06MB7997.apcprd06.prod.outlook.com (2603:1096:d10:42::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Thu, 14 Aug 2025 04:05:23 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 04:05:22 +0000
Message-ID: <abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com>
Date: Thu, 14 Aug 2025 12:05:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] ethtool: use vmalloc_array() to
 simplify code
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-2-rongqianfeng@vivo.com>
 <af057e48-f428-4c34-8991-99959edbabd2@molgen.mpg.de>
Content-Language: en-US
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <af057e48-f428-4c34-8991-99959edbabd2@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KUXPR06MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6762ae9b-083b-4ef1-1c10-08dddae7ca1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME1DbmpFWEhmNG83S3NQamRyNHh2YzFxYkxEdXRja2RWQXRLbjllUWJjcTkw?=
 =?utf-8?B?dHJ2Z0xrMlIvUHR3VUxJbFVOR2E3MldLTXM4TTNSZnQ2QXlaMHBwb0NueW92?=
 =?utf-8?B?TnUrRzIwNFJvRE9ubFZqKzQ1Zkhhakc5cTFYQUhnb091ZXUyTnlJUUl0c2J0?=
 =?utf-8?B?YTJwVEVxMVY5NDloTnBwbVN6NG5tcXZhNC9MM0diMW1TcW1qNkpnR0wwZVJk?=
 =?utf-8?B?eW9UM1pXSjVTTDdzV1VZSVFDUS84TnFYTUVwVHdHaE92L0psdDVuTENkL0JE?=
 =?utf-8?B?ZVAvZHJaL0Z2N2ZNeWVhQUdEVlliVGJlaGx5eFhBNVIyVmIvbTZOaVBHNW9h?=
 =?utf-8?B?c0JJWDB4bHZScDhtSFB2RDhrZ0tJRXd0Qml3Q24rYmtZZlBpR1Nxa2Q1ZTB1?=
 =?utf-8?B?cjA4Y3A5dzlnd2FoV1lmTlhHKzdwT1JTU00vNi9RdEpQUXFTc2hzNnNtQ21i?=
 =?utf-8?B?bkxJbjZMYldyN0R5RGJIaHB2ZkRwYVBzL3Q4Z3V1VTIvakpzaFNHRHpoUjdn?=
 =?utf-8?B?OGYrTklreE81UVhqMkp2elY1b1hzQ2k3TG9NNTNQdTFNY3p6dFQ4ZXJGSWtR?=
 =?utf-8?B?S2czaFZxVW5vZkRDVlR2RXpsWEJsRUVnUkMvQXYvYzBjdldwRFBOaUV3aXF1?=
 =?utf-8?B?MGZpWVV4VGhwY0Z4OEJPTTFXcUhaK29IUlg0dGlSNGhKdzFxdTl1eUxYTkJ6?=
 =?utf-8?B?ZCtLSFVUVnpDVlAwNlBuQTZ3TFdPYnVaZ1V0Q1VnOEpzUEJQOVJGNFFlQlll?=
 =?utf-8?B?QkF4V0xqbFphc0ZFS2NISS9OYThQaHBEWC81cTdnVU1HQldMSStuQ3E1bktk?=
 =?utf-8?B?N3VFNURIR2NMMXgzQXQ0QW1EK0I1TmVyQWw1OFRFWG9yWW9LK3ZmUDBhaE1j?=
 =?utf-8?B?T2hpN3pCZ1MvWHE3NGRxb1NOQkgraHJlZVMyYi9MVFdjTHV2MEpTNng4dm9x?=
 =?utf-8?B?cmU3S09McFN5dXViR285VEdEK0U2bVBDVFl6Q1JPTnFKdUI1UlBWcDg0cTg3?=
 =?utf-8?B?UGJCVTk0blNhVWY0RCs5WmtYU1JlTHM3em91QVVBRVYrZmZkSTlwNkFrbmdU?=
 =?utf-8?B?VUtIUGRUVUNEMXdVby94Vzc2d08zY09ZeGpYdGZoMlJHRnRwT0x2UmZubFhP?=
 =?utf-8?B?NFVTUFY1WEd4d1ZDWkRxZURjamcyei94RnIva0ZrYmJBYWFCUTdjTlZUQmZq?=
 =?utf-8?B?Z2RZeW1BeEhIeDNPVEk4NUVVd0lNVEh0OGFNeWc0VkJhWDBOQnZzSFFLV2h4?=
 =?utf-8?B?V0RtUDFZL2srSjdPWVNyamFxZGU5ajhaVkdUQkRwa0cycTZXNzJlc0FEZ0hP?=
 =?utf-8?B?dEVxLzcvTDVRY0ZXcElyL3hXMVZlYVBjRmxhWjVsOUhNclEyZ2d3ZTdqL2lI?=
 =?utf-8?B?ZmxhQTBpZTYrQjMyVnJBZ3I2MGVYeDFXbStuTHhWanZiMkhLYyt3OWtzaHA0?=
 =?utf-8?B?TmtFQXVwOHpkdWhhWjJ3ZGM1MWNUSnc2NGozaEZtMDJORUVuSkdkMDgxRklU?=
 =?utf-8?B?NnI4VTNhN0RZUjEvNkE2Vnl4ZmJFZ2VKaTN0UkNSdS9iOThVdDZpOHBEMW9q?=
 =?utf-8?B?eFc2eU9mSnhzVHFTM2ZnakZVbmxVdW50b0tHeVBuaHFaMVR3RERFS0d4U0Uw?=
 =?utf-8?B?Nk5NMm9pOVF2V0p0S3dSZldCVDNvVmFFQmo0ZXR4RFFKRXBML3BRNkR1cHhF?=
 =?utf-8?B?dzdlMk5NcnZ5dGFUUkdZYUN6K3o3S1Avbm5ObzBoeW42QjRHZEFRZzR1aVdx?=
 =?utf-8?B?VXdINVdzV0Jib3JEbm9XYU5yVGFUZ2h5Z21CRWdoUFdKbWpuQUdiejR5SkV4?=
 =?utf-8?B?MlYxeWtNaWltMkQ1NmVxbTlKUGk4NElxNEVKMHM4ajBtYUdadHpYcnBKdTQr?=
 =?utf-8?B?OUdmOHJtK1FyMnprMGhsOUQ2ZDUySlUzVk0xV0hlNTBMdTJlL2tPVHVBa3Jq?=
 =?utf-8?Q?q0karG0/fCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzEzVnlUVk9DMjBTWVhxUEVQTDVHWjBQdWRhcFltWlc4N29rWE5OWXh0a1dw?=
 =?utf-8?B?eU1QeE5wL1dTNjNsYUlsYnNwVEFJbVArem00QTZXNnlVNjFVTkZUakVJRmdo?=
 =?utf-8?B?Q2RiYU90U0MrNC82UjZkYTdGWWtDMXJSNHZhUitIbkhUckRVVUs0MzlkMUM5?=
 =?utf-8?B?dndlSjB6NkFueWtDcFd0OHliRXZ0ZndxbzNNNW1ETzV1dHV6MjFVSGJPOVF6?=
 =?utf-8?B?dXRkS3FudHQxaTl4U1hyUjFFaWRyREc0dmtEN2pOQjFhNldOdFp6d29VNHNE?=
 =?utf-8?B?NU53cWNSajFZc3hLM0MrVjdUMVAwNm1kditnV1N6OHREOXBndjBXcWpuZW5o?=
 =?utf-8?B?MXNuRGppZ0ZCK2JGK1FpNHlZTFhrMFZPNGVxS0lLMng0ZWZVMUVnN0w0VXo4?=
 =?utf-8?B?ZVdoZGNBckpBSk54TTVQaEFraElKVk1HWVlzbGhHYWxZamNIamtZZFpHOCth?=
 =?utf-8?B?WHVBREhOMU04Qm53bHFVNHF5SkplaE5vTk04L1ZLU3hhN0lLdG0rTjNqc0NI?=
 =?utf-8?B?R243b0ZaNHVoU3ZoVW8xRjJFcVlKMGNySlN1TWFxMGRJZmdqR2J2RGdMSEZk?=
 =?utf-8?B?RWRUSXB4MDV0cEI4cC8vVGYwY0dOaEsrYncyNzUrcVpwblVOUVJWeXNMd2d0?=
 =?utf-8?B?OVpYYmQvVEkyWVpwbXU0elRkekFzWGlnUHRCOE4vR1BYTkZVeGVKQ3J4Q2VF?=
 =?utf-8?B?Si9hbkVNalNBeHN6SXFUU0xlV280ejRBWVIyakJUQ1hraUlic3JYN2Y5eVRl?=
 =?utf-8?B?V1UvMVRRTnZxSUIxTnNwRUgzWVY1bkZDTGdjYXRsTFF5OTgyZHJHNXorR3pq?=
 =?utf-8?B?QnZ4NnlYckZhSDJnRjhHVHU4bFY5azZaRFJXN2NsSzJTckpRRnJRZERyejNt?=
 =?utf-8?B?c0IyMkhtdDljVWpOakdqc3dBV1hDMEhoT1U1REJ4cXhDdldhS1FwaTdOZFJE?=
 =?utf-8?B?Z0x0OXE4OHNnYTVwUkJLNzJOQkpiK1pQK1poYXNPZjFJYk9VTGlnNm1EUzhP?=
 =?utf-8?B?Y0diZDJOV0ZWU29ZU0VwQ1VqazM5Z0g4MGROcnQybGpONXk2MjZmc05PTStG?=
 =?utf-8?B?aGdQaG96Vndkbk1tRnVmUEZsc3Q5WEFIOUFZSjNaSndKWDNXL3RaU1ZoQVdw?=
 =?utf-8?B?cytFS1l6K0NaME1WeThoVi9VOWRXNTBpNkhJaTIzb2hQbEtJeFpteEpzYWZC?=
 =?utf-8?B?UjRFa010VlorTEx4bmlXOVduTU5HMmlIM0hkbzdQblZ0bU9SRUpoRTVaemdR?=
 =?utf-8?B?SWFpTWFTTGlGSExkTVJaVVBSZEUxLzUxQVo2WGNxdE5CQWc5aGptWVZ2Zm1Z?=
 =?utf-8?B?M1JPWVpkcURBcEMxN2pxa1JoRHhuUkV0NTBEUGh3cEhOYmhwK0lyczVMRGlS?=
 =?utf-8?B?ZVNLQy9ZWDdPdWhtUEphSUZCZEtsZ3M0ODBBK0dEM28xTHRDTEE3LzVVbWNw?=
 =?utf-8?B?MVhwOFhvOE9lTlRieWx0U1c1dis5dTZCUkJaS3JnWXp3QjZHR3h3eXFJN0lz?=
 =?utf-8?B?ZWdSQXdoT3ZsMG9aekJ1MmhHckVNU25TMjQ2dTZ3TmNaOWI3RE04a1BudmVy?=
 =?utf-8?B?V0FBTUQ0cFVTOHlsQmsvV3oyb2IySmY2Yk1IaGxpQVhvWFJwMGFpaUwzN01t?=
 =?utf-8?B?RjNSOWFYNXJ2TUxWZHBxdmdMQks4TisxNHZYSFI5WGlJRUJXKzVmblZzTVZS?=
 =?utf-8?B?ZVc1ZWdhZ1RYeVVnUWNzeFVaNFBsQncvY0V0YllIbjFOVWZPOERLa0cxNGdF?=
 =?utf-8?B?K2RWSzZKaDkvYVNkc0dJNkFsZFgvYVFUVnZZTUZNTm0xRS9rVnk2RE9STDVY?=
 =?utf-8?B?TUZmU1pCQ1l5YzZVMVE3UWRGbWFvZVQ3YWwra2gyc1ZKNGJqcmxVcFY0NTgz?=
 =?utf-8?B?QXZJdlhFVHVYdlJiQlA5ZDVCNlQ0SEk0c28wamNTelJMYXFDTm1NOE1teGdG?=
 =?utf-8?B?RUQvYVVGWnZOMG9scUg2Z2xpS3hvTGNjUHduWEdZdWtJNUZUNVNpa1ZCZGVp?=
 =?utf-8?B?dTZaNnBBMW1QeXQ2RGl3NFc1WEpuQUJpdUsxRmdjbVlnU3hUTjRSVTVLVnN2?=
 =?utf-8?B?L3AwazdhZThWeFltbE85ZDE0ditCdGE3RlJZcWZqbGNlSnJGeW81Z2JBR1hj?=
 =?utf-8?Q?mKEH8Es+nDe28mahwSoYycv8X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6762ae9b-083b-4ef1-1c10-08dddae7ca1b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 04:05:22.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arfB02wAnfi7Yi04ONgfCslHdR5I8ZDSeW4P8PupE47hiOIyNiB4VNwNkLtgT19llRGTbxcIkwJVKR67khGf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB7997


在 2025/8/13 0:34, Paul Menzel 写道:
> [You don't often get email from pmenzel@molgen.mpg.de. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Dear Qianfeng,
>
>
> Thank you for your patch.
>
> Am 12.08.25 um 15:32 schrieb Qianfeng Rong:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>> simplify the code and maintain consistency with existing kmalloc_array()
>> usage.
>
> You could build it without and with your patch and look if the assembler
> code changes.
>

Very good point, the following experiment was done:
//before apply patch:
objdump -dSl --prefix-addresses fm10k_ethtool.o > original.dis

//after apply patch:
objdump -dSl --prefix-addresses fm10k_ethtool.o > patched.dis

diff -u original.dis patched.dis | diffstat
patched.dis | 1578 ... 1 file changed, 785 insertions(+), 793 deletions(-)

 From the above results, we can see that the assembly instructions are
reduced after applying the patch.


#define array_size(a, b)    size_mul(a, b)

static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
{
     size_t bytes;

     if (check_mul_overflow(factor1, factor2, &bytes))
         return SIZE_MAX;

     return bytes;
}

void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
{
     size_t bytes;

     if (unlikely(check_mul_overflow(n, size, &bytes)))
         return NULL;
     return __vmalloc_noprof(bytes, flags);
}

And from the code, array_size() will return SIZE_MAX after detecting
overflow.  SIZE_MAX is passed to vmalloc for available memory
verification before exiting and returning NULL. vmalloc_array()
will directly return NULL after detecting overflow.

Best regards,
Qianfeng
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

