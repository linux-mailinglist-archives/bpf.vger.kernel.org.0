Return-Path: <bpf+bounces-59285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F936AC7C6C
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C53B30AE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57F28E57F;
	Thu, 29 May 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbMK8Uot"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83014E2F2;
	Thu, 29 May 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517114; cv=fail; b=e65fcXb4XyGtfhQbjCCDcv3lUnJv65oibLGLuHPj42nDEhABiplm+A0qAtL+eg2ORONJLj2zq8KtBoDUpO+xnUSZIt5NyHjsRQiV3B6DE2KZZZK4V90KxADuXFa6Z5ED1Xb22i7uBe+AUM3t/T+fUykR57c2+9S4onNlvVGgrKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517114; c=relaxed/simple;
	bh=HtnSi5NOQkKLthtL4oDSXHuVN/QLyk9v8VIIRSyzw8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TLKwGezntzJmEEBVi2qGt/G7tggjAu0KTTcEyHB7TrXlVCBHYQxbbY8JDZcVcFYUc2uIKggjurrMUceoi9rEySaRcohanIWj/0uGPJ9GFx11Bn47bKTCcyJ7PnVpYP8ASstaKXNQQWDXfKYnZMkG6fLOeUTDTfZPXB+5gzO92tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbMK8Uot; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbsZCfUImagc2eOCYtLFM5JezdD11FnFRtf9BlZieRGCmu5SejOkqL8resmDMgeUxf5Trs16olYIOK7NI2DrL1/umbYZITIG0dTi7ibHqaooB+1tWkuQB9frfFnfwBHz7ueU9MEyEMEKgYd1eWKZSLr/bpjB8xO+n5prRbooghNKjvd2+HkVpwUhoMxoGrqde5nkk0N6iLXD2SgE1EWt4+ofxJ6+NmBtjE46WkPeGs5K66yHKAv69bBJTtFlkm73mdQEHiw+PdNe5vLjdu8Bl5o38lXNNd60KxbvnlX1Y6w9MF5Q3OnuE7Ly1eQapGB5Olqm2Y2HVcSIDWnZPfNJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KMT7OOhCo/E67mkAVo1CdLy0xx6KI9GU9rNGsWn12I=;
 b=oBfl55UfZi1wsHUplkKs2uG4jxwHn69YBsTMJiNJAMvm99EnE0WGZxb2XVh+SyGeqzRKwkjcgKh103tvIkZ+q6yuEd01cmzpcWSOgxdpPDekg9aY81Lnyhl1JJC1AAoptcHHTdJTK0tu7Ydauv4MsjUfvutjgX73ex0+2o9n6k4noAzrVZ+vrxAchoVyQ2QjHG5159pLy+fSV5WwLJXudHk3AdMbgaZvBlUB801/VywxVEqJDhbQo2ZACnaufNFepShItnqItPyW4j/sYcTW55WzZmFnNQXWUmmlK3PwMrCxdEfsUPamFCvPVxbudG8X+WNIe+iOKFDiOanYTyrPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KMT7OOhCo/E67mkAVo1CdLy0xx6KI9GU9rNGsWn12I=;
 b=BbMK8UotjtTLnT6G77MKISaEHv1eP7Tq/e1YQZQcKqDLGwWMUqbKTsLt4k58FtOSRpI+077Hg49XN8c/fKqvXAbpDi1Kmy6lY97Vm9c7nj9nTuxaurYsPyh7bVYARiqLiKN8YUyKdhW8ZG+Pm4FmGzSgtKnhqNi99Av625Ji7oFPLTP8N6Q/Zgx6uNOFouIaQnS7Z2uPZQUI4flruC3WIFwNNS075Zba2QoKKDGZOlX/HefMRXAk9r5AxaeEwnLV3nxMIQcqUcimu/PKpsMyLBa+8LMN3w1oLCVe7TREr1FlLOuObqAzYuYY9/UNeJwjxPIEyQXzgZnhuq78h+eJ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 11:11:49 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 11:11:48 +0000
Date: Thu, 29 May 2025 11:11:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
	Mina Almasry <almasrymina@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Message-ID: <phuigc2himixvyaxydukgupqy2oxpobj6qo4m4hb6vsr5qenfd@7q4ct2c5gjdq>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <aDXi3VpAOPHQ576e@mini-arch>
 <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
 <aDcvfvLMN2y5xkbo@mini-arch>
 <CAHS8izMhCm1+UzmWK2Ju+hbA5U-7OYUcHpdd8yEuQEux3QZ74A@mail.gmail.com>
 <aDeWcntZgm7Je8TZ@mini-arch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDeWcntZgm7Je8TZ@mini-arch>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: b143d0f3-a332-42be-3d25-08dd9ea19b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1hoa2xYOVFLS2srOHh3NGlCcWRIUHowK3VJVTRNQzVHcmx6dVJwWnU3am1V?=
 =?utf-8?B?WDQ4d1h5OFg4cTdGcHE4d2g1SWlhTDVIOU5rem9IaU11OVdqb3pIdlVWTjky?=
 =?utf-8?B?d1YydU5tTVhLVUVMWk9zNXRjQklkb21vdHYrOXlwMURMNUVwMjBOTmF3QmhP?=
 =?utf-8?B?bVlCRVlQbTRkcWxVUFl0ZEY2OXoyVTZuMytBdGFNUkhJSW5HZXVKdVhKejBi?=
 =?utf-8?B?bCtQTk9NTHhhcm9zV2hnR3NjcUlTWDQxU2tmbnpiNEFLWmF6YnN1L3d0VEJu?=
 =?utf-8?B?ZnA3MitQNnJ6dWNWQ0NKanZrOEpaQzI2MzBBUGVzWDNkTGM0TXc1bE1VT0ta?=
 =?utf-8?B?Z0NmZEpKVHdKdk44VklLSktsRkwrRnFGK3daN09veWFMNkJDTVdSMlJTRlVa?=
 =?utf-8?B?ZDl0U1FQSXhFRXZ5Qjg2MnFsUmpzZGFzR1FsVDJqd3NTbWpvOW5FWXNTVzNr?=
 =?utf-8?B?Y0ZHbkt5Y0lKUDhpYWZ2bXVmN1JmM0MxR1VqU3dFa05nU3VSNnBBd0grMW12?=
 =?utf-8?B?ZDdqbVFlUjd6QW01UlE3K3pHRjJRU1NFTmJ5REE2aXFnY1FJaHpLaDA2a0FZ?=
 =?utf-8?B?UlowMFpmb1dzVEJwU2d5dWRGZUdIV1VxSlQxUUhCVWllTXVpN0tYaVJpOXVv?=
 =?utf-8?B?akFYTzU5U21YMFRjWmtvNUEwTDY0b3I3MWJOc2Z0U3NVQ2F0VWVXYkJvL2RC?=
 =?utf-8?B?OXhOWVAyRENvNk43NVl4M1RkMjZnUkpzZGxLVlNXeklOVXpEVnk3K2pGSDh1?=
 =?utf-8?B?eW9mOXVnbWF2RHZCaGxtTmNERnYyUW9TTnljZjg3OXlGaUhLcWwzUUJhc3Bh?=
 =?utf-8?B?V0RjVEx5MUwzbDBDVm9DVTRoaW1hMFd2elZzZ3c5NGM1U1RHTE5tOUtkWG05?=
 =?utf-8?B?a0xnOVFNMklXM0VmVnRvMFpBMU0wdjhiVzlYczAvRnhreTJWb0JPS1pNcHZi?=
 =?utf-8?B?M2FpbXpxYWE4Mm1raUlHb2xTNUZaR0tQbDJuNzd1UXVCRVAzOCtVZFYwdjFP?=
 =?utf-8?B?aEJPQ1pEMWVKa1ZLTm03bEh5RHV5cFVVeHRlclhHYkxMYTk3SU1OUkFha1dU?=
 =?utf-8?B?QmJ0VTcwYmJUUVUrenE4L2p3d2J4bTZ5L3NjMFJ2dkZNV1V4NVJ5NDBqZWtK?=
 =?utf-8?B?Mm45b3diZXYxM1l5aXQyalEvL05qUGdtSXRzenNVczFyZWNrTDRzY3ZyTmQz?=
 =?utf-8?B?bmpiN0hIOC9OZEhrSHI3UDQxTC9pUitUZEtEdm5rSUJmemIrUEFHb1RTaGk2?=
 =?utf-8?B?YStlVTVBRjgvbmNoZlBVaVFaQTdERExsbVlGeWVycHRUbzQrd3duU3c0Y3hu?=
 =?utf-8?B?cGVNeHg2Z1ppd1lwMWNCVk9PVHlKV2JzZHN5N1owalh5dkRIQ3JXZHRYS1Rw?=
 =?utf-8?B?UitqaVI3QTBPVGIrbGlkdE9oWlBLL0g5VkxOTDU3S1BPeURuK0FIMmlFRHNm?=
 =?utf-8?B?d0Y1VGdySkNVVUlDRXBCNHlzRkIvYzlvNm5ZaTBuNFdVQzVkeUVmRnZVUkpq?=
 =?utf-8?B?dk4reGtNd0VpVkhwYjN2djhGSUIxbCtRODY0UCtVNkRjb0VvYzRZaVVuMGtO?=
 =?utf-8?B?bHpsZ0tZemh2UWxadVBtN08yRGdObmlaRDBZUFRyV2pFRk4zRkhCbG5NVjIw?=
 =?utf-8?B?eWhEaGhnQnpPTW5HTzExdnROYXh6cERqNXNhRzhvcWdBR2JPTmQ0RXFPd0lB?=
 =?utf-8?B?OEsvTXhFbytnUzZPcDVkdlQ1dGdndDVwa01nbVh5ZEVic2RkakUxR0QzZzlS?=
 =?utf-8?B?YVYxc1ZzQnVjbWhzRFBNOWxnTlhwWGttNnJBK3RmcW1Gd01jR2hoMWQrSGh2?=
 =?utf-8?B?cHVXdFh6dU44S3JvakJUNGdYYTFKT2hjUVU3QXVxUlRnd05zV0RUREdyazZS?=
 =?utf-8?B?cktkOWJFajc5UUpHVWc4Rnh6OW5yQmFxSVBpVWRHWmlMbnN0N0lkdkpPaUN0?=
 =?utf-8?Q?i71c+jT6s/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3Q1QS93T3dMNDJSaXA0Nk44MDFzWXU4VFl5cnhlaWZKWHRPY0hwUXhNT2ZV?=
 =?utf-8?B?UWNIVUY2c1haalNzTUl1cHZYMVNUZnRvbFRYNWZZeWpxUFF4YVJmNjhaZXRy?=
 =?utf-8?B?b2ZRNXV1ZFBVK3JOMWZLTmxRU3FCSzcrK0FZa3RjTXhTZTA0ZHkyTXVCeHpZ?=
 =?utf-8?B?KzUrak1aK3JFaTNBTkFJRzFMUk91SU1raFpSc0tRZFc5d0o3SDZZZkY3bXpk?=
 =?utf-8?B?TndEcXUxWmFiV2syYVF3WDJzcWlUNS9zWHQ0cTgxVUFUNUg2SnFuai9GNHRj?=
 =?utf-8?B?d0Y3U2pJTExDODRWNjVCc0VlMnhZRm5wUTY1UVloY3VlNjhqc1J6a3JINCt4?=
 =?utf-8?B?Sm9sZEZPYjJLZTl3NzNZalBNQ05tMXYrb1ZDWHFOT2NWN1Y1dGVGZU13QlFC?=
 =?utf-8?B?clZrNjJ5ZjZxamt4Ulo0TkR0Nnd0M1ZUU2hwMnpYeDFRSkZLeCs0YXZWZnNZ?=
 =?utf-8?B?N2dOQW1WTDJhdldtaGtaZnRqSklUZWd1UTY5WnpQQkc5TnY4ZmJ3OEU2ckJ1?=
 =?utf-8?B?U3JoczhOTDNGM0N0eXYzK1hyUm4rSUhSNjJXQ1BHZkxqT2xtNmFkV0dBQlJX?=
 =?utf-8?B?NTV2SkFaVjUybFlETFpKbmJWK01OeUcyeFF3QjFsYXN6NnkrM0xqQXJJVVJQ?=
 =?utf-8?B?em1EWVhOOHFUMmhjNGhtOER3ZWJFYXZvNDc3WEUxQ1FEb3FKY2ZwZUVyRnhr?=
 =?utf-8?B?R0F4SkhwdEFlS2ZlWHdnczFScFJGQzdpOUpVSGtac0hUbzZCUngvUUJVM0lI?=
 =?utf-8?B?ekJIZ1RZdGM1TDh4TFBYYmlETTZ1Y3pieWJwVklDRHloUTc4dUk3UFlId1BS?=
 =?utf-8?B?REk4MUdLNG1NSVZYcHNnanBRejQyeTRPZzJFbEFxMS8xeHlIc0Yza0ZXS2Jm?=
 =?utf-8?B?TnVuT1dUSTBYOG1jaWI2UXlDbXZQNjM5TjBvdWlxWDdLYTZRb1h6YitacUJy?=
 =?utf-8?B?WCsrVnVLQ2VMM0RXOHFCdjZTQWhrREovemtkS3RBRHc0Ymg3S0V3bXQzUmtG?=
 =?utf-8?B?eWRWZHBGMnQrWlFDa1FCc1I0cU02d1F4QU5Bc0dGSGE3bTVzNmpKUWxwVGlM?=
 =?utf-8?B?a1pIdk1jWlhzMHM5Y21QanRqMXRQNGNLaEo5ODhXUjZ3ZlByc0FYY3pmRVdh?=
 =?utf-8?B?TC9OMy9xbDR5cXBUT1dkY0F1Y1pnYjRMN2Rkaml1aTliMGNxd1J3YkV2MEVT?=
 =?utf-8?B?cTNlcUpGNFpOVUFsc1VzZVZ4OEZpODU1Z0RhTEVMaHBxVm5vVWVReVE1UW1O?=
 =?utf-8?B?NW5xa2xSeWtyeGU5YXp1STVvSHkxeEFSdVpBMmJ0UXNRc3ZoSHBSTkZvOWNZ?=
 =?utf-8?B?MW5Va3B2dnB1Ty9OVlJCQzRoRHA4NzUrV3lveUZPclFZSVg1WERqdWszTGt2?=
 =?utf-8?B?NHBxWHZ2R09kWkJoamQrN0U4VWtyOHBIMTk5UXNFQVNiVUkrSlBrbkp3aWxT?=
 =?utf-8?B?K1VlZzhCd0xlUWp0cXV6dGdVa0xXYTV4YWxtazF0TGh6RjNieitWVkFhQk42?=
 =?utf-8?B?a1ZhNlN2eVVrbDhTVWtPcnZnRWx5anhHZ1cxb3lkUVl0RWY1L3ZtMmt2b216?=
 =?utf-8?B?bjJhQ3VDMzAxdlViYjFON043YmlqSU82Skx0cHdHQ0swY3MzVTNGMk94ZUlO?=
 =?utf-8?B?eUdsdHR1MlVoK1JkdmN3VkpmdzRXTHZKTGJ1SXplRGl6K3FKand5KzZZdlNo?=
 =?utf-8?B?MTBqdEdPdjZjTnpJaXJjRGg4aXV2TkpjT1RQWmlxZ1dKUW5nUzl1VjV2ZitE?=
 =?utf-8?B?d2pMaTIxTkdRR21BQkxvVUF1bWNVK090U3FHZDB5dVFIUGVwczN1YVVwTnYx?=
 =?utf-8?B?a3YxRjBxdUlFM25CbDFNbnZ1bmJwZVcrTTRLR1YxNUx3ekdUNno5dlJyN0ts?=
 =?utf-8?B?Y0Z0KzZRZVN0R3hHWTVpTkJxNEdTNTJFT29ZNjdCZ1RMNVNwOGQ0d2NrV2Jm?=
 =?utf-8?B?YnRhWU9ONTR0TWRVaFBYdnNUWEdtRkRHODVZa2NGbG1sa3B2cFpidERmaVVu?=
 =?utf-8?B?c2MyRlMzTXpBb0RNcHZMdDhOaFNWcExTTFd6dXpoam5sSnU1bGNwclp5M3Q1?=
 =?utf-8?B?NGY3OVFvWVpGaWdRekYyb0k1L0t3c0Y0aVRjejJ3YVRCQzRLd24rRDVlVFh1?=
 =?utf-8?Q?ntM0ljUcMh0+S0RFjXs96Q3bg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b143d0f3-a332-42be-3d25-08dd9ea19b13
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 11:11:48.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HteyY1PhPexkb/7y7IIXE78SbPR1KW3sy+ksB9CRmLpMGBS486UXHCQtIr10atlAu2OkuuN7iKBck3fm4PkX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932

On Wed, May 28, 2025 at 04:04:18PM -0700, Stanislav Fomichev wrote:
> On 05/28, Mina Almasry wrote:
> > On Wed, May 28, 2025 at 8:45 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > >
> > > On 05/28, Dragos Tatulea wrote:
> > > > On Tue, May 27, 2025 at 09:05:49AM -0700, Stanislav Fomichev wrote:
> > > > > On 05/23, Tariq Toukan wrote:
> > > > > > This series from the team adds support for zerocopy rx TCP with devmem
> > > > > > and io_uring for ConnectX7 NICs and above. For performance reasons and
> > > > > > simplicity HW-GRO will also be turned on when header-data split mode is
> > > > > > on.
> > > > > >
> > > > > > Find more details below.
> > > > > >
> > > > > > Regards,
> > > > > > Tariq
> > > > > >
> > > > > > Performance
> > > > > > ===========
> > > > > >
> > > > > > Test setup:
> > > > > >
> > > > > > * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> > > > > > * NIC: ConnectX7
> > > > > > * Benchmarking tool: kperf [1]
> > > > > > * Single TCP flow
> > > > > > * Test duration: 60s
> > > > > >
> > > > > > With application thread and interrupts pinned to the *same* core:
> > > > > >
> > > > > > |------+-----------+----------|
> > > > > > | MTU  | epoll     | io_uring |
> > > > > > |------+-----------+----------|
> > > > > > | 1500 | 61.6 Gbps | 114 Gbps |
> > > > > > | 4096 | 69.3 Gbps | 151 Gbps |
> > > > > > | 9000 | 67.8 Gbps | 187 Gbps |
> > > > > > |------+-----------+----------|
> > > > > >
> > > > > > The CPU usage for io_uring is 95%.
> > > > > >
> > > > > > Reproduction steps for io_uring:
> > > > > >
> > > > > > server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
> > > > > >         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> > > > > >
> > > > > > server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> > > > > >
> > > > > > client --src 2001:db8::2 --dst 2001:db8::1 \
> > > > > >         --msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2
> > > > > >
> > > > > > Patch overview:
> > > > > > ================
> > > > > >
> > > > > > First, a netmem API for skb_can_coalesce is added to the core to be able
> > > > > > to do skb fragment coalescing on netmems.
> > > > > >
> > > > > > The next patches introduce some cleanups in the internal SHAMPO code and
> > > > > > improvements to hw gro capability checks in FW.
> > > > > >
> > > > > > A separate page_pool is introduced for headers. Ethtool stats are added
> > > > > > as well.
> > > > > >
> > > > > > Then the driver is converted to use the netmem API and to allow support
> > > > > > for unreadable netmem page pool.
> > > > > >
> > > > > > The queue management ops are implemented.
> > > > > >
> > > > > > Finally, the tcp-data-split ring parameter is exposed.
> > > > > >
> > > > > > Changelog
> > > > > > =========
> > > > > >
> > > > > > Changes from v1 [0]:
> > > > > > - Added support for skb_can_coalesce_netmem().
> > > > > > - Avoid netmem_to_page() casts in the driver.
> > > > > > - Fixed code to abide 80 char limit with some exceptions to avoid
> > > > > > code churn.
> > > > >
> > > > > Since there is gonna be 2-3 weeks of closed net-next, can you
> > > > > also add a patch for the tx side? It should be trivial (skip dma unmap
> > > > > for niovs in tx completions plus netdev->netmem_tx=1).
> > > > >
> > > > Seems indeed trivial. We will add it.
> > > >
> > > > > And, btw, what about the issue that Cosmin raised in [0]? Is it addressed
> > > > > in this series?
> > > > >
> > > > > 0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com/
> > > > We wanted to fix this afterwards as it needs to change a more subtle
> > > > part in the code that replenishes pages. This needs more thinking and
> > > > testing.
> > >
> > > Thanks! For my understanding: does the issue occur only during initial
> > > queue refill? Or the same problem will happen any time there is a burst
> > > of traffic that might exhaust all rx descriptors?
> > >
> > 
> > Minor: a burst in traffic likely won't reproduce this case, I'm sure
> > mlx5 can drive the hardware to line rate consistently. It's more if
> > the machine is under extreme memory pressure, I think,
> > page_pool_alloc_pages and friends may return ENOMEM, which reproduces
> > the same edge case as the dma-buf being extremely small which also
> > makes page_pool_alloc_netmems return -ENOMEM.
> 
> What I want to understand is whether the kernel/driver will oops when dmabuf
> runs out of buffers after initial setup. Either traffic burst and/or userspace
> being slow on refill - doesn't matter.
There is no OOPS but the queue can't handle more traffic because it
can't allocate more buffers and it can't release old buffers either.

AFAIU from Cosmin the condition happened on initial queue fill when
there are no buffers to be released for the current WQE.

Thanks,
Dragos

