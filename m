Return-Path: <bpf+bounces-67852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F8B4A836
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95C33BD692
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1429ACD8;
	Tue,  9 Sep 2025 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gV2V5swR"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE728D83D;
	Tue,  9 Sep 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410122; cv=fail; b=jNel3LVX0jw3+4HNiyYTWCLfYkfm8CUHi+Zs5vwQHg5tggBG2fx+rxQYVdx+6CsuGFWPH0SRNkn0OEXa9gya4/f9LRquhAGEEwCRuYpm6yakVRSLHij8tDlGvqF4SPWUBQg6Mmow+Jr6Gf0G41Tzr2JSFCIqasKp+OjRhYUUU94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410122; c=relaxed/simple;
	bh=Qr3zmAm5+rTbYRSmoE5+d2RxbRyOFsVuQ1LLpp2EdRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l59lcpJHJ0VijUjpD6X5CZPR7XywuE4xzK/1lQY4vULKdn3WPGJFKirp85yzmXOfkL4FgmY2KfufM+0kpYGawxw8yb21BBDQiro1NVcMXjXmj2lq9Zkz3K3K6WbEEBxzX+ibW2b9ItUwPEwa6UbF9KWJ7gBmJYdPfN0y04DTQ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gV2V5swR; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKhFm0T6eJF8L2eSgtQnfeZ2HMW4o9ocqosCIRuyYzA8n15c+K4+mMQdqt1D2FEWc2jll5TcACXLKX1lkr7u7yxxcS0cVaMtdaGS6GAiEEDW2PrAcJ34XykKMIT36gbovQf9/AnLqwoIBEvs38sgpCyI8VHKS0G3yFTVumKHHIytvvYM2RpM1XOn1kTW2tcJkapp+dNESSWypD032sNDstdLpIeXPdmzTPNT13TVWKN2pk364eXrKKq6K+OBOQ0CnGEsfKGMzhh38quSGfq6uP1ByTD7Vd4+BVRYJDg4d41PnCOCRREBBI2b4maMGnt9gmyAFJP/k8ubYxkSuqNiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TweMFLypZwJbhzIKqPvPEVL8+HBb1UcVWqR5BTaMbkQ=;
 b=trhhS0JxHh03xWfTrEdhO7xo94xU0fQviHZQBfX6ZwOsVsBHdi+mcujD2zPVO+FeRnQFLdh0uVH/CPpCn7dWz5DiRXcgGgD4VAb9cIG4sufn0nTCfxJQ85ddYsv7yT1QSQ4r+IJef/15axcjkM0eRLiNlGitJq5Wb9GTaEXwxntocTZt5lYYuMAqx4f0j9M6mO9CJLf5qqJ5WZJ/YAfDZr3Zbb/JYrdo56ythDY3YNytj/LXEE2aC1gmIhjQzFwlg0ZJn3xFRbmNtdyJRSRITAO4YWbKoVxD/hKN19WIV9g3Pr8BAMDb+DBtBebuQwMAgCYv1rWoxOXkR0lPLXiHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TweMFLypZwJbhzIKqPvPEVL8+HBb1UcVWqR5BTaMbkQ=;
 b=gV2V5swRMaJQJlxf5apiDI3gTrsF+2KCCZorkgxZwqerwX9a/El2TQgzt7FC4Ej41b/26pFdyT7AJ+lT+5cxexILQQVRMuXVHyu4p0XmlConzZbedrECbKX+3sPZbv0Etm1shHDSYfTNBzNPJ4YWZQ6bIuMNtC7poRCB7T0yUx2oFrq6jRhJd9FfZdx/gEkxNq6RYxTQs0xie6FCiCCRpMnKBdCTbv7I7CAEmHtC8TJDjaDP5E9YU4sbrjezStoCoyZLgNWVO+0q38EAeqciyrjdopnsbJbU+dpsRW/MO4e+dmRZZd3w5U4hTyUzF0e9Es0qtF7GvdCRiz8XN3tErA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:28:38 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:28:38 +0000
Message-ID: <6c19a052-e1e0-46db-b1ff-63f193809ee1@nvidia.com>
Date: Tue, 9 Sep 2025 12:28:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Jakub Kicinski <kuba@kernel.org>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <CAMB2axPpaoDfFEBzNTaTjp4GnFKtWy0k-sTez56ap+FBZzLFeA@mail.gmail.com>
 <20250829170929.28cfac72@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250829170929.28cfac72@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA1PR12MB6186.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a70a34-b90f-4717-a78e-08ddef8341c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXJVaDZ3c0NQd2tSR09VM3lWeGRvWkNDajA2dVdOZVBWTFB5WjlVR3Bja2NS?=
 =?utf-8?B?RkNuQnp4NkRMeTJManBQaFY0dm1sbkdYK2xsWTRrRGpQa3FJUmdMdUc5OEgx?=
 =?utf-8?B?YURueW1DanA3U0VnaUVxYm1oeURwMHFSSXk2eTlGTFJUbElUS2h5M2pTUzBR?=
 =?utf-8?B?NUd0OEFlRHF5cUt2VnRyZERpa0paTGo0aVhySmxpL1dXTjY5aDIvOXlHdlhi?=
 =?utf-8?B?eFRHZmt3T2VqSHV2NDMzZjJuWGU0NWV0ckFYVWdwVTNyWDl4a3NrYnQxeE9O?=
 =?utf-8?B?VU9yZlZqQW5ZVnozKzhRTGxsdzFXTTdoWHVCdTlmQU1wZkxKblFyMWhMbEc2?=
 =?utf-8?B?UmE1bjB3R0hjN3ZsM1pnVklQZ1J3dlZic21pSm9YOUdSSU1SeW1uUEl6RmpV?=
 =?utf-8?B?c3d1N2Exd0NaMndoZXM5cW5tSGNMSDJ5NC90Z3p4OWdmNVRMd0NHZkpWNXgr?=
 =?utf-8?B?S1NOc2JPU2VUSjl3NDJ6czJnMm9MZjB4ZGp2RGdTNUQ2bitycThwcWgyaGNy?=
 =?utf-8?B?YVg4RjAvT25HKzVldk9xK2EybVZQZmhHK0wxQUVHUkVIVmxKNUdvMllPV3FU?=
 =?utf-8?B?dGt0ZjhaQzZDK081NER2ZnQ3b1hvREk2b0ZCcWVhTmxiYlJYamRVVkl6aHQ1?=
 =?utf-8?B?Z2RNQ1B4TmZUNjNqK3VtL0JZYnZkeGNPNjRKZjZ0Qkl1eTFpSHYrZERyTzYz?=
 =?utf-8?B?SVozSzBzbkxJaDRSVGlxOWtJLzNqdGVqL3kxZ1hjYmhxY0JuTURkMjMzT011?=
 =?utf-8?B?cVlRUExxaEIwMTNyd2VVUGgrY1hxT0UvblJiS290YUI3eHVHMmFDM1JUQUIz?=
 =?utf-8?B?aERlOFdjUWJtLy81UlpodXRZNFZaS0U4aTh6azAvS1BYQ0xFZk9ZQlZaNlNh?=
 =?utf-8?B?Vk56VkZiVm9nRDJQNG1qVTlkaExUdjB3ZUVIVmZJZStscnZCcGdpZVFIT212?=
 =?utf-8?B?MU5lVzNSUXJyb01VR2kzYXZwbUJZd2tDR2JSeHFFcGU3M1ZVYVlJOGlPNSti?=
 =?utf-8?B?ZVNoeVpWWkt3eUlaUWNqUlFFK0I4WjNwSGZqY0hkaVQrUUtpbE91S0R0ekJl?=
 =?utf-8?B?SmFjb0wzMnRpYmJ6cnlIaWlrUjZsM1hQT3lLcm9uaGJTVElkcTkvdFFXRnh1?=
 =?utf-8?B?enZsSDNUQ0hSdXIwWHN6bjFIRm1GaXNqcGs0Y2pZRkZ1NzZVSXg2Y1hpWlRL?=
 =?utf-8?B?QjhKdzZrNHAxWG5ZZlczRUVQcWhMNW55azladlVwVUhvVzVEcGhSQkxFZi9j?=
 =?utf-8?B?NGpveGZBRHVva3JNRkNSUEZ3WHVFQW54VTJPaHFYYmNWMGpLdjdrc1RSSjBq?=
 =?utf-8?B?aEZEbFdyeWlsQ1FLODR6YlUzSklDUTNJMHFrUmVrZ1NEUXMvNWNkM3VOMnlI?=
 =?utf-8?B?ZWNJeFQ0d0NaYkhSUmxQZzFlQ2NXeFJQUmtodU1zcS9yaW1yTVdGZnFJczZt?=
 =?utf-8?B?QlFpbnFLWXdZai81SmVJa2N5OXpOUUJEMzlwSVN3bjFhWWNaalhzNWZ0SUxI?=
 =?utf-8?B?NG01TnVycXdGdC9kRmgyMmo1MTBhZUxuZ1d6b0hsUGcxbUZJVnlhcmIzZlBB?=
 =?utf-8?B?ZzhPbngyTmlTakZ2MzViY2pvdWVLaWhhWGd4amNKa3lrcGJkNlhGYnRyMUhr?=
 =?utf-8?B?Z3FhUC9SL3NDcHZkd2JZQmFvZnVieW1oK1E5NU81MTRzVlgvV3BYeFM5L2Jj?=
 =?utf-8?B?SFV2MmlsTEF4d1ptUDZlby9vL3ZDNk9YVlpidk9mOHpGa094ZFFxYVlPcXRz?=
 =?utf-8?B?bU5FWGRFT0RYRCtZampqS1Nlck4xM0V2cXpGbzlQM3dQKzQ0THhHejBFV1U0?=
 =?utf-8?B?UVpMcTZVZGtoUEMrS0c2TEg1eHVVY3o3Rzc2VnZyeFVyTWtSQ0JRMkxrd21i?=
 =?utf-8?B?UnhIcFVydUxMeDRzNWxvWlhNYkJqM1pMMzJBM1ZHeGJsSUdSZWl3QVlkUFpP?=
 =?utf-8?Q?dwpLkASIlIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODQ4Qkh0L3NCSnYzQmd4OWVaRHlRVmhSUkVsS3ZMTnRlU01hWGJpU2FFcHBm?=
 =?utf-8?B?UDhDOW51NUNIeWk0a3g5VENmZUlBbFJMaGNCUVRoMGVDcGN4WXV5aytWV015?=
 =?utf-8?B?RTlzNDlrUWNjQmlGSE9Lc1JoT0lmNXJ5YUVwcVRYNlNoVXo0VGdrOGNubzBI?=
 =?utf-8?B?Umg2a1kwb29nMmlDc0dSSTdQeE5iUlJRckR1eWhoaTM4TmVGSWFsQUpwaDZG?=
 =?utf-8?B?cW1KZVNKdWxtNk1SVyt5NXdmR0FIQ0I3dnlpVXA1eDVuT291Tm92eUxES3Jt?=
 =?utf-8?B?Q2lYZ1dpRGI5bVhKcU9YLzQvdHh0QTl5RzI3TE1tYUlQYzMvQkU4aHg3RWRv?=
 =?utf-8?B?cVdDZXVCZ1JIYVl0SFFJRmNsMFkwNTRqZW5Rb1BzSlViMzQyWnc2eUFrb0Za?=
 =?utf-8?B?SXloYXlxR002VTljdzRRSUlMNldXb0pjRnJ2SEMwRWNpVHNkdWRMYURKaE5a?=
 =?utf-8?B?ZGJwNmJSZEFQQ09qeHhpcUxmMENRS0EzOWQyYisvZ2xXTHlqUUpjWEsxR1NU?=
 =?utf-8?B?aHdpQVZGbnJFUVZTeXpWV0FLbjFJb3RjYzBJZmtZWExkVmU4a28zRkY4eVNo?=
 =?utf-8?B?VWFtZThaL1pVWFlzb214VXZWUHp4b1RiRTVwS0VlYTcyZFUzRnlmRnVWMkNN?=
 =?utf-8?B?V01kMWdaVW5rbTNtNnkyblo2MVgxc0htcjhQeERPTVdSck94eEFSdTlYYUx6?=
 =?utf-8?B?QlZsV2pTVC9KYjFRSURZbGlHaEgzNGZtZVpOUi9yVjhaSzRMVU85U1Y3SFlY?=
 =?utf-8?B?dUt0eVNhRkY4Y1ljdTRTMTQzK0hiMzh4Q09hbXdrZW9jU21GY2JTZjlsZi92?=
 =?utf-8?B?MjlaUWhOUlVzdHpPQzBldXZSckNORUJ2Z1JlY3IrcmxINWNZUnFyOEFjWmww?=
 =?utf-8?B?eVB6T0xIZmRTdUMyRlUzSC81eTloM0swaDlWeVJCZmFOTnJwa0EzYmd6WHV0?=
 =?utf-8?B?eXN4ME5XV1NrWUV1dE9EQVVkOXA2TE13a2ZCeHljdVY1QURMNEpXckU3anE5?=
 =?utf-8?B?d0N3YXJZckpoVTdWWUNGUGRxVlhHampTZUU3d3B0MkcvT016bkMyd0kzdzJ6?=
 =?utf-8?B?N3Y2Wi9RbWd6TCtXYUV3N2RpMHBkWWhybWJvTEN2V0l5RGZNNVA3Qm11MmUr?=
 =?utf-8?B?aEZFKzFCV1U4cE9pa2VYUDJSNkFQSzZrQ21xT1UrZk5qbXBQN1JUMUxDNGJ4?=
 =?utf-8?B?Z1FSNFN2bm5GZUN6SG43dUVNalppVm8wUmZqR1RZSjVYWmo3SkxRUkREUFJk?=
 =?utf-8?B?UGVsOHU0Z1dCN3FpN0crWFk0SmlBS0x3aDhFZCtyMVBzUTVpekJVQmF1dFRu?=
 =?utf-8?B?SXF3ZDlRcFFWMEdPTmNqQUVqNTViYmxPRW5jM2MxVy9HZ1JTaHNacDJKRFBu?=
 =?utf-8?B?dXlxNlY3RWl5S2UzYUNWU3UzajJYcXBWZkRwQXkvNU5raWd4d3NDVCt3WXFw?=
 =?utf-8?B?M2VuM0tPVnlpZ20rSTRYc2pmaE5YWGxLTnB5Y0FHQTNjUU5TMit5TTRWWm9Y?=
 =?utf-8?B?dmtVZnpkdjgwSVRmV3Nwb0dTcHNSNUdvOGRMaGpnL0swemRWYmNiRmJxVGdK?=
 =?utf-8?B?RXE5U091bDRnVnlJT1lSWFZIVVBnZGpKZzc2R2RxeUtFSEtQcit2UlhzU0tz?=
 =?utf-8?B?enlncmhqN1lmRG5FdlJEb1hSQWZRTSsvVWJhSDNlYzZWNmoxbjJCZDV4OVli?=
 =?utf-8?B?aTYvbG5iWkpPQlJEcHJPS041djV4RlJEVDhTUE9ubE5TRDk5UnhQRWpQNU50?=
 =?utf-8?B?dE1GZlQvd1J4NVhkWmZmcWxMUXdtVTNKMjMzRmI0THY1cXRRcXh1WUE5TWR6?=
 =?utf-8?B?R2FHcG9VQ2dXUkZPVE9pQWg4QVZUZ1MzYXI2R1VvQ09RV2xNZVRtUHpvNEpl?=
 =?utf-8?B?REJ6NFVyNzJtblAxUll0Wm5Qd3dGcFpKZE4wVGJOd096WFdYVUtTeHRrVll5?=
 =?utf-8?B?b0lQM0VhWVQxTS9uY2xxWE0rdmQwUnZIMzUzWUhldng5RFc2bDB2TWxPditV?=
 =?utf-8?B?OXJYcWZZOXJlS0FKd2xWSWxpbkRRaFc1c0FVTFNwaVpsb1JQbTBtZ3FmZkpY?=
 =?utf-8?B?dnBCKzdrcWVRV1kvUTZXU2Jib0JFNitvV01Lc1F3cVFDMnUwVlVKQkN2ZVlR?=
 =?utf-8?Q?Zs6lTy6cSWYs1mB+L7gTOElcO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a70a34-b90f-4717-a78e-08ddef8341c4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:28:38.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8KoPWwnpqhn9Jc+geg5h+nV9+FcJBNQ2JrgojanVCxohxeAQcYuwjGg3OUaGrjiWyOIheVqlL4Uiwlc4mIq7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On 30/08/2025 3:09, Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 00:26:29 -0700 Amery Hung wrote:
>>> I'm currently working on a series that converts the xdp_native program
>>> to use dynptr for accessing header data. If accepted, it should provide
>>> better performance, since dynptr can access without copying the data.
>>
>> I feel that bpf_xdp_pull_data() is a more generic approach, but yeah
>> dynptr may yield better performance. Looking forward to seeing the
>> numbers.
> 
> To be 100% clear, being able to push and pull custom UDP encap headers
> (that the NIC may not even be able to parse) is one of the main use
> cases for XDP, for L3 load balances. dynptr may be slower or faster 
> for reading and writing to the packet, but it can't push or pull.
> So this is a bit of a side conversation. Sorry if I'm stating the
> obvious.

I agree that they are aimed at different use cases.

To explore this further, I've posted the mentioned series as an RFC. The
cover letter outlines where I believe each approach has advantages. I
would be happy to hear your feedback.

https://lore.kernel.org/all/20250909085236.2234306-1-noren@nvidia.com/

