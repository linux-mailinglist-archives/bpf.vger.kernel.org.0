Return-Path: <bpf+bounces-59116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E875BAC6114
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764199E51F0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4FC1FBEA2;
	Wed, 28 May 2025 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJ1gqT2b"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182451F7586;
	Wed, 28 May 2025 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409058; cv=fail; b=iu1BVwGUFhkLDY9wrYA+WwbsWN9w8A2mZHiIql2drbQiclq/Ux10Y4Ubyxno+I3oHTYF4b5n3m1DRcrSSUju/gNVDKoOhs1/0nBwIBgHE9ue8RwgOGANQc+lVC26mfw0velYdcoH4cziQ3Jy/cq+xLBXgoK9xpRl+MS4RG7lo04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409058; c=relaxed/simple;
	bh=aqmxzerIVFOuItXNW+6vYLf/LADHhLwyW6ZzW9gK+BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+e7hbxKYGol70UO/gLDQOPc0k0142waYv3TzrIkJGYDK003+qX2SXF2COPg5y/mWMVDgWUOKFjY9hZjvNscHSYBlq9oAl9IxBmtomrm/t9qwlpttZZFwVh/AW2u7SnYwS0U5Jvz5IuuTJpTrnaWVTkU6iQybuDBe8+p/YLUA9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJ1gqT2b; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RP3i0IPEUTVXt4NB22xQPQNOl6ORbZXi3MHe4rBmTOh7njleP3pJXO3QzzjTgOVaPU+waxGdKWGFs3cTQxDdDwVz2fPcLdwPcWUOrehWYbIS78osuMac6PMG5bWHvqUnWBA1w72ia7OWJmkOXzesidrJMwpKFX1ouBPUSqsDuFmkh0f5pZwc14tsl7vP1K8OLYiGVG4S0R3OlOsN8tg1xCUeNj1xrvbh7PjourfTMAwRYI9/y8pxShXyt3cNUCfzXMVyB5V12gnt3ByCozOMMGTnn//JdeUIxbXF9u0axOWTI5yv1NS+Hbu1VFDekqxafiueAbke5JJPb0lj82HRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3dfMH+WJlw8HWmeR2oYjvcWOkxIW7Klnsw7YPOQrfQ=;
 b=I8X/7k802gzR2rWQWk/v3yt+Bs3UFuK++rNHqXJ9NRTPzKvLxU3FoaY48ZCdR5FVu/0O1eODD/bqcZPt//+ZUoJfJQCR4OAcbovF+lopk6tNNzVgomq5mp1xqOkPf0cdqzRmzRciTLhYh6WkguyDDj+/UMX2GPWzytS9YfW6EbgtE1qZiBVGorWNTTV1Dvqb1qsAGsO1SX52PA+6ky6AONLNVjUYjF7zO7jXYRbHnAHFcmmLKluZIsAPOwCQ7BBH3oTuJPAypYLuJ5f3H53HoobwwMVUzBCKUryqYuiOcB8i8Kds2YpC0phJLTg8EdN55Xl4QrT84bPudz5hKSKpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3dfMH+WJlw8HWmeR2oYjvcWOkxIW7Klnsw7YPOQrfQ=;
 b=IJ1gqT2bX1ABhcoCPI5NSl2w61DLXbq5jhKRVvp+xgLLi62fx3LaMHhGw7qhnwgLfSYzYOnFOWK4xfSObufiiTt18yLKtqwP76Lm/1+qPB0U3S7SP4BENgA24vAxox2G/WG4G7lWDj4KQ46iY9CMPgCTPO3bzCN4jR9cEzjppA9lKB1P6LcSOVTTUMyH7dytSXIvQlrm410ScHjzSYqY1rHm74q2GiPsMQnWubUOSKvDYO8XNzerNv905vibWMPY2IFxfznvekTEH0q+wsRrMsZLpPDR3MTCVtJY/j/ZObLdtiYkxD1sLNjEYIg7y5PtyUOB58hZYAxZIYVRfskEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 05:10:54 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:10:54 +0000
Message-ID: <676de326-df44-45c4-8ca2-3d1a2758abf2@nvidia.com>
Date: Wed, 28 May 2025 08:10:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
 <20250522155518.47ab81d3@kernel.org> <aC-xAK0Unw2XE-2T@x130>
 <20250527091023.206faecb@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250527091023.206faecb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: e47eef2c-7132-4e7b-67f2-08dd9da6055b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzNka2pOWmNqSjRET2NaUlJDZWg4NWdtQmxHTk5Zc2RSek50QXNvcnZrK0pt?=
 =?utf-8?B?ditJdmh4V0E1U2lITUJMZzNWWC9mUC9ibDNTdnd0Z3NmeXM4Ni81SUE4M045?=
 =?utf-8?B?WTgyWmYzOE9sMkJhQmFEZE9tY0xBUHhLS21HaFlXT3ZpT3UyalUzVnZDbFZC?=
 =?utf-8?B?RGNjOStRYllabWZJR1ZqMDlqbkRuUE9IdHdzRlVRa2p1UlBFWVZybktWUXBz?=
 =?utf-8?B?RklKdm9ESUxwOGg2SGVNR1Z0d0E1S3Bnb0hXZTVlMFBlTHpaZVFyQ1o3Q1R5?=
 =?utf-8?B?ZUZxaWp2S1paeFc2d2dnaFRibTZVanFkNUVhYlFuUFVnZXhlQmJNSXZDeEdO?=
 =?utf-8?B?eVlrTjJtR2dvMVhGUWZXOEpGV29mNTFnUDVoUHpNcms5MFBBakZxdUdmaWhP?=
 =?utf-8?B?cUtFR2xqUld4eGh0SVp5WmNCeXZrVnVGbVpxVno3eGZGOGpkTmNTUDE1TnNp?=
 =?utf-8?B?UUN2NWIyR0pvUUNWRkJCS2JueVZvbjhTbWtPQm9XeUpBVUhEZVJ1Y1E4bVpR?=
 =?utf-8?B?dFhsN1hMTHBpZ2tiV3ZWd1JTTmxFRUhlNmltS2JVeHp4SU5INndVVWFvWjdz?=
 =?utf-8?B?MXExMS9LZEQzd3FOaFZKYy9TeEFiQW43QWo1Z08zNWlRYmhTdG9TaU81aXRv?=
 =?utf-8?B?TXBHdW54TG5RUUdXL0IvRkxBNjhscjVRaEl5TklyeGtvVHc0bEVGMDFkR2Qz?=
 =?utf-8?B?SGFDM1czMkZTUmV1STd2bWVvd0h5azhyOFJDNjc4aDEwYWRDYXh1MXI1Z1Y1?=
 =?utf-8?B?ZGFTbmhGNis4U2hMVFJ2ZUZubnY3bHpCVHM3YXlIcnAva2F3YWMwbE9lamhy?=
 =?utf-8?B?Z0dkNElMZjBweWdpTjU4QWRhcUdncUlBRG8vQjd6TGtIRmY2MjRXTGhadWFt?=
 =?utf-8?B?VEhPQnc3MVpYRWdMRjdMRDlRY0xmUFFDODkycjd6UkVGYmxXdEtjemN2Nlp4?=
 =?utf-8?B?WVZjZkVYc014aWoxcVZuaXJ4Y1FpQ2FjZE1oY2h1dDFsaW9sTTFVNmRuRFRG?=
 =?utf-8?B?YTM2YndkejVIZWtScUVFelVabkxQMC80ZURpc2t4ZmpDMTZCZVhBSDNOYmJB?=
 =?utf-8?B?Q29JRDl0TFAzZ0lXY1JOdHZIV0F5K2JxNVJjRkpLZ0U2VmRnZDNRWnowWGt5?=
 =?utf-8?B?bGUvQmpoRFRpbkwyVndSdUZlMTlMZ01Hc2pHTitnVzFYRVVnanFhZnlEcklO?=
 =?utf-8?B?TDVrSzBXdTJhTXNWbW1YL0hQa3VnaCt0eUlIMndhWlJtWVBJcWdYS3lXK2dy?=
 =?utf-8?B?T091WHZUMUJKeGl0dGRqOXhrVzlxNVpOTGI3dmFGZXV5eDVpdStsd3FQbnJm?=
 =?utf-8?B?cjZyMXN6NWk2bG83b21JMUJNLy9nNnBSYXpQTm0vZEJ0c1gwRXNETGpBaTNP?=
 =?utf-8?B?NU1PbHdCeEpNOG5CeHhSWjhrUDVjZDlITlRzSHlhUE5Ddi9jaWZGS2RHWE9U?=
 =?utf-8?B?TEV6QzNlOERWWTF1U2xSMFEyRW50UkczOFo4SHpWbE5INjYyS0wvbDZ4b2VZ?=
 =?utf-8?B?NmNLU0RndENVaUJBdmNmRFBVNmdKbzJnb3lKM25vaUs5YU1rYjJKQUloc0VS?=
 =?utf-8?B?czhXMG5SdnRzT1Z5SEJsRFROSVVMb1NPaHZJRU4rdHdrZVpmeUF5TTBRa0pM?=
 =?utf-8?B?L0l5bG4xTjNPbXdqRWFzOXNac2VrV0JneGg4WmhqY1YrZHEvMnR4Mjk0MTNj?=
 =?utf-8?B?OFRPQm1TRjB5V0IybDY4R0UyQXJWYnBxWWxYd0pSWVVKQVRHMTkxN21tR25G?=
 =?utf-8?B?ZmlNZjVyUUhCQ1lwbGd0eDUxQXFXL2I3OVZZTGlsTm1KSURqNldUN1pZQ2g3?=
 =?utf-8?B?cGJLZTRCUkFua05hMEUvRjY0VXROcGMxSGJUUUdNZWZKV01qdGRuM1RjZmlv?=
 =?utf-8?B?QWtvQWYvRCtMNE51Q1pPcStaZDhYZ1NwanhWbHVXZkJaNFFuSXJraERpTjdo?=
 =?utf-8?Q?c8TgkhrkhWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tMY2kyRGVvaWJNVFQrcjdDRmVVNFRFRUREdm9NdjNWQ29jQWR4dXZ0cUhv?=
 =?utf-8?B?TEkvbzNFREJGUEhnNlVXSnp1UXFDbnEzSVQwblExc2VxTWhCN3p2RVNHZ1FF?=
 =?utf-8?B?VWkwWlZQcXQ0ZnNvdkQ5UkJPSnhaSG1FYXNOOWluV0hBY05wODQ3VHFUN2F5?=
 =?utf-8?B?b3NKckZ0Vjdjb2dXK0k3YUlIYzJhRHdCYW5ZS0dNZVp1SnRIc2JraTN6cEtB?=
 =?utf-8?B?Tmtxbm5raDR2L05XM0w5NFJkbFZ3ZVMzWkJCanl4a1lsTXlCd2Y1QmxlTWl2?=
 =?utf-8?B?MTJRT3NWTytrMSt5bzZhT1crT2x4bTdJd05XTzVSaWM2QWZqZUdMcHJSYWtO?=
 =?utf-8?B?NGdXLzNwcGRIWEF3UHhNRE1Lc1RMK0NEOTNOKzNTUnpxVnNmK0pUTlFGMm5y?=
 =?utf-8?B?TkZFOWFTVlVKTytZMDhmQUNvYXZ0N2JnT2JMT21HeklISW9uRGd5Z1VWV3VG?=
 =?utf-8?B?V2dFK05ZdS9NNTNmZGR3Qi9nMnFIcjFDa245RzZBQXFxVVFodlVyTlg3Uzh3?=
 =?utf-8?B?WUtSRi9lNDhOajhVZkgyazc0bm5lUUxzclYvZU5EZ1E1NjdVTFo0UWN2U2xx?=
 =?utf-8?B?MnNiYlNpNDZiNG9wWlBrU0NvWkxrZmdEMXVQenNZLzFJdUNyM0I5aTc1aVk4?=
 =?utf-8?B?VURzQTBnVndoSENPaVlLS0ZpVi9SM2VRQUhFRW9McktPTkFiM2NueTJpVWRJ?=
 =?utf-8?B?d3pucmJDY0NTRDAvM01uNUZQMTJDTmtqUGNscUh1aXhHdFcrSW9WcDRFK3Zp?=
 =?utf-8?B?QlBDQXZJRnJSamxTZWF3Z2VaZHFXbTFVaENTMHlYbGFLaXBKWXB3bDg1dS8v?=
 =?utf-8?B?eVFvSEZ0N2VVWU8wNlhDTnBzRnlKYTJ5Y3JKWVU2RjJRcjFtYWRqOHdjOG5B?=
 =?utf-8?B?RHkyZnp2R3hDVkRYRmpycUlMNHIra3ZrRXRhM1F6TjB2ZzFqdExDRUxhSC9M?=
 =?utf-8?B?eFgyZ0g3RVd0Nk05Qmh1WWdybVNZVnpDeUZYZG12SGFEbEVaN2x4S3BkZGpB?=
 =?utf-8?B?Y3FvSUhza1VZZDdRVzFJR2x4TWEweTFRVnVSelU4NCtla0wrRTdFSW5tMmRt?=
 =?utf-8?B?WHJZdGx2bGo3eGFGdjNXZkdXSXZvRk52ZEw2RWIyQlEwMlZLbHdDQzE3YnZu?=
 =?utf-8?B?ZUdnWEIwQUJFRXplQ21JY3lKc2Q2dlFmTmFTV0pDMlQ4K0VXcEd0RWp3L0x4?=
 =?utf-8?B?Q2Q0NE1JcWxNTHdmMDBkRFNMVzNla3hQUGlQM2RobWVzSDM1YzFCMWRZcFVz?=
 =?utf-8?B?VTVjQjdsMzN0OG5sMUxZbWNpQzJpVHVWanEvUDJqKzZEOEx3NWxXZ3p3bmxl?=
 =?utf-8?B?dmZuSGtSMStGL1lTTktOSDhtb2ZaSkN3M1JsVlVtVjg1bTNwNWd5NkU5ZTUw?=
 =?utf-8?B?Ri9VYW56M2JCSno4RTVWclkvRVJWSnk5R3NKYi9qTFIveENUSmVwSURrSlVm?=
 =?utf-8?B?bUx4NFpuRTFibXU2c0FkdHNOcjlHckdnaGJTTlYwbWJWZkxWdDJqNFRwbWxB?=
 =?utf-8?B?UFhBcWlGczMveDlVSmtZUE81bWtWVlRpL2xSTEFWRHh2WXlUeE9OYWFnVHND?=
 =?utf-8?B?cDdoNXR4RTUrTUpYZmtsekpzZFhtZERXRWdCRlBOeUtVZXUxcHJpaXkwOWZs?=
 =?utf-8?B?SjFtQTFuenhKaCs5Y0pOQ2w3amxrOFBvcEdHUDFNUElGaHQzYk9ZQzgzcU1P?=
 =?utf-8?B?SExSTDlvZ1pUcU9Hc2hjNlg0ZVFVMTZKRGxBZmVnbjR1V3ZDTVNvS2xtaTNa?=
 =?utf-8?B?cU5TcEkreW4vMXNOdTJrR0VJVkJDSk40VytKOXFmUThiTUh1Vm5rSnFXSmZ2?=
 =?utf-8?B?eUhaMXB3WG5FTGd0bUFmZGRHZ2RlNFdWSnVrVkZCT2RrcE9kNXIwUVhnKytJ?=
 =?utf-8?B?QUJEelZ1TnhYSXRGbCsyNEoyTzJmMTBVV3MwZFNlQnp0OFdkT3owSXcrMWVE?=
 =?utf-8?B?UWFGSWJLdjdOU2ExRjRzS0pkMDdNb2EvWEV1bUZkWWhGaXdLVVoydThhdytw?=
 =?utf-8?B?WFoxWTVwTmNHdGVWUU54V1c3RFlwQTZVQ0dodEkwdWZFMTJ6Qjh5OUl6Qzcx?=
 =?utf-8?B?T2Nad1NvMjJBZEYyalZrUFZ4VkExWFY0SWROV0p1L0gvT3M2Y2s0ZzZGYzJr?=
 =?utf-8?Q?9N3RYd+9k3P8JQ6ACVx/DSfL9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47eef2c-7132-4e7b-67f2-08dd9da6055b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:10:53.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM9sazUomzaolAljJwNSSZqSCkDHVirYU3UeLPGpXyiHPw7Ne5KUGjbL2MK4kpxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

On 27/05/2025 19:10, Jakub Kicinski wrote:
> On Thu, 22 May 2025 16:19:28 -0700 Saeed Mahameed wrote:
>>> Why are you modifying wanted_features? wanted_features is what
>>> *user space* wanted! You should probably operate on hw_features ?
>>> Tho, may be cleaner to return an error and an extack if the user
>>> tries to set HDS and GRO to conflicting values.
>>>  
>>
>> hw_features is hw capabilities, it doesn't mean on/off.. so no we can't
>> rely on that.
>>
>> To enable TCP_DATA_SPLIT we tie it to GRO_HW, so we enable GRO_HW when
>> TCP_DATA_SPLIT is set to on and vise-versa. I agree not the cleanest.. 
>> But it is good for user-visibility as you would see both ON if you query
>> from user, which is the actual state. This is the only way to set HW_GRO
>> to on by driver and not lose previous state when we turn the other bit
>> on/off.
> 
>    features = on
> hw_features = off
> 
> is how we indicate the feature is "on [fixed]"
> Tho, I'm not sure how much precedent there is for making things fixed
> at runtime.

Isn't this something that should be handled through fix_features?

