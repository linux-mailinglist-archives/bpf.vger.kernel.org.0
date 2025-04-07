Return-Path: <bpf+bounces-55404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2CBA7E0E5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9329018884EF
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0E1D5AB8;
	Mon,  7 Apr 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKDhpClf"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFD1A3A95;
	Mon,  7 Apr 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035311; cv=fail; b=bPa3gAqqSFQRfBWKdPWPMxyzIs1HjqHxlVcojaEvPtfOBpn9x+HUfmv4Gnk+xXusyRryTnAGoFF952Csvtzzajx34B5ETqEMnNxsUmYyBUri5GgIojPWKHI00S2TBYqIwvlKIBp+BYgeabOT1MuXaKmG328d1jDgqjy6NG9n+Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035311; c=relaxed/simple;
	bh=V4+SE0duYCxx5IwkMB/v58/4MoHVpWD6/DvA4NFfwOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaOjbB/C10JGlL/cZ2DRyOZ/itIpCV3o1+RClVzyrakbM7YgGaaQF8tHHwubnGHZrKoKbzbxBF8m1TFzYw7vZao7aoIFnmtcCKVgAnYNwuCUVsq4CqAJViln1WDX1z/Mqubq0J+FkHlKIVWR3HatfSANGQzyx//F4XnuMifnx04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKDhpClf; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgMlB/qLxJeLoLeHOzhEMeifoExuPHztTnqSKmO2A/CjHGAqJs9XIoiR0G/pJpw+isE5Z7cmKZath1kbFs7jWp0tO/07/2tu5286owEnO9FEKQCUWhAZcuz29gyL5luD7FhU0FDWaPd0RHQ6vq1ptBLwyHe07GNujjGXemgzNKAXF6kVNXHjJSWVVCf3VxMrD/QMgfCrHMOva4oFY5cXz0torqWnpqHwxriqrqijE/PJq1HrXC4norzVRu4/l/THvX8A+tntrkuGU/HCMzn5VIomFd4yRbdPeKP1PCDfXj0Y+mCBLOVzvBdqzqB+kkID2NgYDw5LtlFIidoqopkpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/lcQyRUNmFMwh3VcqvJ5iBlcOHf+VeoKF6yz9UlZy0=;
 b=YwLtLQRhZ9hW9zbIcPwHkMBqVmXRK3u4h54qpWMu7MOCJeKxl7Ov3n63FJJd2F64uChEyXcu6hdj+5B/u1fxEwmcREaZMjVVpW+yuNV4Lxvp5v96Kwygz2kf0jEo0r6MMzaxrR5CMYCwqYm43J9NaajmqIgL+AHIFt+ZcI6ptXErTstA0zeMEvQnFChQZ862vc+FD2YfmaPD+R45jIjf7jU+kn4Fi3obxMy+JsSlWFJpWq4OC9SOE222iGyoKe5M5TeyZMUbB7LHbp6tF5yul8zT5kMi9k4P4SFA2E9U06wwA0JVNigeyqyA4A+UTnmUiPrqSftVwmxCLWUFHG0bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/lcQyRUNmFMwh3VcqvJ5iBlcOHf+VeoKF6yz9UlZy0=;
 b=mKDhpClfdCeWTsFfUtle3vbMqmwAt65muRy+M/vfxdAlJNycTgC2S2KXSkPVoUhc2911cG1DesOrQ9LUNSzAIqFCN0xcyXLG1BX0CmPGGU6JKmYjqxdyeKTnqWMVbMLTCkah/tTmsvDoiNoJLNnxyP+Wn+5X9Mt0e0kgjC0y/HpuU2pECQKEgN6h9dnE2dsgQHihaWqC/HdN12cfm/eJTazmiP4zUOuS2akJDMTrj2+mzLUV08zvX88bTEPJHJWC9mFboU9M3gZ84UzZENOMA7pgAPW2aiqeGf3uki3GKQsBKUOMFte1G+4oS08goNAmqAAhVkov+GqDunY0p4ea1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:15:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 14:15:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Date: Mon, 07 Apr 2025 10:15:02 -0400
X-Mailer: MailMate (2.0r6238)
Message-ID: <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
In-Reply-To: <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
 <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:408:fb::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd84b3a-d798-4453-38cf-08dd75de9802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3RRR3Uya0RDdEhmcHZWdHEzM01UYWJheStDcGd5MEJzZ2NROXJmYlEvS3d6?=
 =?utf-8?B?czdmTTlDRkx5cVJwYVRuMWR5WHU0WEpIcXZPN1BpQVFGY1FQdWw1WVB2WFZ2?=
 =?utf-8?B?OVRhajRvYnFLcGk2NnRNOGNtR3hmRW5QdkVVSU9RMG41a20zWkdDOVEzUTVY?=
 =?utf-8?B?OGNtYjF6V3ZpMzBGUzVrZkR1Yks1cEJvZVAwVERCUGY4Q1JHZVAvZGp3dkVM?=
 =?utf-8?B?RDNrTEkrV0N4Znc1d1JXbDJNRzFGdXNoNDh2OGkwd0E0SGhUSk4xZDdBNDFG?=
 =?utf-8?B?SG9oZDg5d01yL2tLc0Uvd0xsOWxRcUxpenRzR2ZJd1B4UnRoc3dnZDAxSHg0?=
 =?utf-8?B?Mm5UKzZ0K1ptZ1ZudEc2VEJYZS9acy9tb0RtWlZ5aHBqSFpndUxMdDYxRXFs?=
 =?utf-8?B?TnJzVTRvMmV5U2pRTmVWaTJTQy9jL0lRamtweG04SGFud2hrOU4veE42Nmhq?=
 =?utf-8?B?MEtadEFlU2w5TFFOT25sVFJrNnJDU21RUnp6dEswNHM2eFdGSnFZQWhKWGN4?=
 =?utf-8?B?Tm8yWTR1TWlPUHM0SFlNc2ZoZWRvTHVXcHVCVk4yZWYvT1BudXhUSHR3UHBu?=
 =?utf-8?B?eEdJSHVFdnRjNlNDd3ZKZ08weUxydXlKRzlEemdpRVRlTnlMcWdkMklBenlp?=
 =?utf-8?B?WVJ0YjJ4c0pUazQ1aEZSV3RqTU1mT2pFVlRRWTRCcUcya0RyN09zTXZaY0E3?=
 =?utf-8?B?MXJNTXg1RjcyaTIzVnRSV1RlMWhvaUxjVGg5UjZxS3o3d3BQMDAxTVBwaWMy?=
 =?utf-8?B?V0h2VmFyQnp6Q0haLzY4Qm1MSVI4UTFCcElCTThNZk5nWiswMncyOFNzTlNs?=
 =?utf-8?B?NkY1OGNHZm9QbUlVUTBoWkJYNmpTMEJGaHp2UUh2cFIzYXI5bGU3R3hWS1JZ?=
 =?utf-8?B?Z015cFl5aERrYWJXdFI4dkpGb3lrekxKQWhMd0dXMVYrbWNuNjcvREN4UlNx?=
 =?utf-8?B?WS9hYndmRVZLQ2NscWQ3a3ZLem5FMThaZU5TajFBcXFiVTI4YmVibEtFazMy?=
 =?utf-8?B?THRNdUNvaDByQVdGQTMvV3VOM0d4bkFSSGhEZGVmOGNWZUpJMUpvbkE3UlBM?=
 =?utf-8?B?U2doSlhHSm5kRWQ3RHVzeGl4QUtvN1owUHR3cjVFY0FyNE9MVG9LUGNkbGw5?=
 =?utf-8?B?WHo5a3lLLzlFeDc5and0blN6dW1hdHlLczdPVkFGYzdNMUNDQ08yVjBEZHR6?=
 =?utf-8?B?RW40cndpMVBMY3VwY1VvdGJqWjRNQ21jcWxOY0Jqd01HM0tReWY2YXZFOGs2?=
 =?utf-8?B?YTFBWlE5aWR5MUk4WkdqSHB1WVJKcXRoQzhiN2JrMTZZYzNhT3p0WTNjSDlu?=
 =?utf-8?B?SnhudmF6OHY0WlBTWTluNUdNcWJEREx6QUU1OGd5U2x4SGdabmdGVm5ucGV6?=
 =?utf-8?B?RXZJUFZ0dmgxUjRyaFRSUG9ERTM1T3V5dEJMb1ZyZHZTM2JjdmtNTXNaSUhC?=
 =?utf-8?B?T2F0VUY3VGxQOGEyQklRQ3o1cmFvbG5YeURrNWI5b0cvWXJPaitoWGxOUEpl?=
 =?utf-8?B?MmVJTnFZbzg4bUJiQXRmdXRkYlJUTnZsQ1pSVXBBZ1Eya2VmMUZnQ2g3WDlj?=
 =?utf-8?B?N3FFVzNhb09Rc3hhRCszc0twUjVyMUxTUXlQTDZzNkYwMVRFT1lYL2ZvUjlu?=
 =?utf-8?B?REhqN0xiVTJMbHcyVE9vSmFBU250YWJwM2JVZkJ0NWE3VTAxRFdBUE5Fbktl?=
 =?utf-8?B?MFllUkx4ZytnRnFJdlEySUxMRnhOZ0lOQ3RwNUJwZC9PYnd4Q1pBMTlDVDkw?=
 =?utf-8?B?dnJCTlUralNPenJGREpkRjd2S1FFU1V0OVJYOTdpUDBLdEtzQWwwWWRoeTM2?=
 =?utf-8?B?Ryt1YjFMVk1nZEFtTE1sNW8xS1pERU1MMDBrNno0dE9Zamk4eXg1TFFnV1Jr?=
 =?utf-8?Q?JZT3Qa6uNLabX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y21VZEkvMHh3OVl6WStneS9rODJFdVkwd3NOV3cxTVV3OTVpWWdsYlIxS3Vj?=
 =?utf-8?B?L3R4SU1jY2l5NFFrNlQ1ZGs2ZktEUXQwYm9nVHNRYzRtRDI1MlYveExYd1cy?=
 =?utf-8?B?WjQyZ3NXRFk5WERURWxHbjBCRXNaVi9VbXAzVnVsOVgyYTVCNjhTbU5qaTB2?=
 =?utf-8?B?MWNYZVY2ZXJ0bHpLODV5d253SzhaZk0yMjRuYzB2eDg0MXBMOXVHdk50aUdI?=
 =?utf-8?B?aElucDIwVUhvTVNQMy9iT21DS2s0bkQ0VUJyZDM3QXFIT2piRFRRSTRNa2da?=
 =?utf-8?B?M2VTYXkzaldHei9qQjFBU1NVVFQxcGtYK0gwcUhYTlcwNHd0NmVWdDJNTjVC?=
 =?utf-8?B?ZGd2dEpucURRY2VMUTVuR3VPb3crL2dYZzdtMFh6aVBxc2hLUjV3d1NiaU9D?=
 =?utf-8?B?R3c4b21tNDdqaitlY1dGM2ZQa2Z1ZFFRcUdRM1hRRDhKTTdhN2lhSzVTUFNw?=
 =?utf-8?B?SHBtNWNPemJ0RWMzL3pOYTUwSEg4TXNEaHRESFBpUjZuczFvSHpCNVRVMnh0?=
 =?utf-8?B?M2hUaDJHSU1EQzZDSHo4dFNaZ1ZXOWtyNzQrR0xIc0orb2xZN2V0UWdFb0tr?=
 =?utf-8?B?WGhUcllpdWMyR2dCU1NYc1NsVm9BQnM2aDRlSzYzc3JIbVUwUGJNbVQrNEhy?=
 =?utf-8?B?RnlsUDFlR1BZRmREUFdWeVRtampKQ0UxQk1yZFdhVmFkVk1QRU1LMkwycVdR?=
 =?utf-8?B?TjlZTXdNNVpOUXVucE1vNGpKOHF6MGZFNUtUUCtHNmdBVitFRjhacFh0Ti9v?=
 =?utf-8?B?Vjg0YmkweThocnpna2UrbVE1aDJKS1p3c3dOY3BTa1YrV05mb0lOUytrTjhL?=
 =?utf-8?B?bk9haGFzUjVYNXVYSUpZbUdxais1R1VUR0VzZzEwYW84WnplWTdnbFBnRjdR?=
 =?utf-8?B?SjhvYWdua0R4WE1pNE04clp3MWNtN3FSVEExQ0xqU1BFYU41NzFQVmdpcXFu?=
 =?utf-8?B?Si9sOXRJTDlhYzRhYnRRVURnVTFvbmhHL1lTR3VrMnBqcFJZaDFpTC93RjVm?=
 =?utf-8?B?c2I1R0tDK0JDbDlUSGk0YjV4YmRmNmZUaUFrWnBheVRHc2dMYmxHV2Vjb0pN?=
 =?utf-8?B?UjNvMk5uNzM0UGVkbXl2clA3cFAzejVNV24yUDk3QUE5a2N2bUNxNWhGcHBU?=
 =?utf-8?B?bnAyUHJYWmlFeWU5K085V0pwdURiUHdGVkFmcFZyUnFlNndTNnpNWnhkYjBF?=
 =?utf-8?B?c2ozTjBaN0NjRnhhVlZpVlYvUTA5V1pJN1h5TmhYRy9uZzk3djRrcyt5MHlq?=
 =?utf-8?B?OVRmeHNIT3Bvd3BpelJvaVE4VHJqTVk2R0FxN0M3Rm54bndCTWJtSTl0alFR?=
 =?utf-8?B?NGtJVUQ3aE5CMG1KMUhWZ0hTOVNSU0tRKzg2NCtJSEp5cnNBa0pPQjRyb1Fu?=
 =?utf-8?B?ZjZEajdZaTl2SjRqbmpGR2xGQWlHQTZQdjhwc01XV3hoeEp1WmlocFBGMytR?=
 =?utf-8?B?V1BKWEdUQ3hvTURKWXhhN1VmdjV3clJvdVZia1lPZTJhTHAxcmQ3dWxWbE5Q?=
 =?utf-8?B?NURuTTJaZjRjQ1NqbTBLek5hcktLcnpTS0VxaVdFeVBDUWIzWWlSanZ4Ums3?=
 =?utf-8?B?T0Uxc3FXZ0liWGRDNnhhNlo3OXhhWHFaZGErZW02T3pLeEFoR1V6d291a2V3?=
 =?utf-8?B?eFVPNjR4VlpLZ3htaldyMmdZR3o4RUp4M0FuaFZLb1Q5VHZIRDRhQklwZ0o2?=
 =?utf-8?B?aldEV0xqa0dQanlOWWQ4MytrSUFvNlhnL3IvQUMrR1BaOWREc01Rekg2MVJr?=
 =?utf-8?B?cVBJblFjRlh0bWZ2aGszWlNNS1ZaTHNqREhVMEhXWDlhWXJIOWdIY3hEY0d5?=
 =?utf-8?B?NWVldWJUc0R1WWN3KzN2NnBoakRBem1oaHZpb2hVSmV3Njhjakt5UHQwZEJH?=
 =?utf-8?B?K0R2Z3pZNW9ReWpzdzFscHhRenlqODl5VlROTENXMVhQWDhsK2d6KzdwUmdn?=
 =?utf-8?B?SUUreGtpZFN3emttVHgyRXJKVXBFQ3hNL0pEVVpDY1k5YTBPS255aDYxOGNR?=
 =?utf-8?B?eEZ5MzVTT1RYSjJ1dXUwS01oRW45bGVWS2t4NXlWSW9wb0VVb2p4aGp1Q1hy?=
 =?utf-8?B?azg2Rzk2aFJjQlgya1ppVmFhZ3FPNkdkTDBTZXQrU2VWdCtSRUpLOGRMSzE5?=
 =?utf-8?Q?Hg2vw0vf5/x6csDAkigo0ZdB6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd84b3a-d798-4453-38cf-08dd75de9802
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:15:05.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHmaYY/aRfhYFvmu7KHoI2QmLE0nUrfdIqj9lW+VIpzIgEsLox9bH6UDekCLFcNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

On 7 Apr 2025, at 9:36, Zi Yan wrote:

> On 7 Apr 2025, at 9:14, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> Resend to fix my signature.
>>>
>>> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>>> "Zi Yan" <ziy@nvidia.com> writes:
>>>>
>>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen w=
rote:
>>>>>> Since we are about to stash some more information into the pp_magic
>>>>>> field, let's move the magic signature checks into a pair of helper
>>>>>> functions so it can be changed in one place.
>>>>>>
>>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>>>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>>> ---
>>>>>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>>  include/net/page_pool/types.h                    | 18 +++++++++++++=
+++++
>>>>>>  mm/page_alloc.c                                  |  9 +++------
>>>>>>  net/core/netmem_priv.h                           |  5 +++++
>>>>>>  net/core/skbuff.c                                | 16 ++-----------=
---
>>>>>>  net/core/xdp.c                                   |  4 ++--
>>>>>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/t=
ypes.h
>>>>>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224f=
eb26173135ff37951ef8 100644
>>>>>> --- a/include/net/page_pool/types.h
>>>>>> +++ b/include/net/page_pool/types.h
>>>>>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>>>>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>>>>>  };
>>>>>>
>>>>>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp=
_magic is
>>>>>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserv=
e bit 0 for
>>>>>> + * the head page of compound page and bit 1 for pfmemalloc page.
>>>>>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avo=
id recycling
>>>>>> + * the pfmemalloc page.
>>>>>> + */
>>>>>> +#define PP_MAGIC_MASK ~0x3UL
>>>>>> +
>>>>>>  /**
>>>>>>   * struct page_pool_params - page pool parameters
>>>>>>   * @fast:	params accessed frequently on hotpath
>>>>>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>>>>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnec=
t)(void *),
>>>>>>  			   const struct xdp_mem_info *mem);
>>>>>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>>>>>> +
>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> +{
>>>>>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>>> +}
>>>>>>  #else
>>>>>>  static inline void page_pool_destroy(struct page_pool *pool)
>>>>>>  {
>>>>>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct=
 page_pool *pool,
>>>>>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 =
count)
>>>>>>  {
>>>>>>  }
>>>>>> +
>>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>>> +{
>>>>>> +	return false;
>>>>>> +}
>>>>>>  #endif
>>>>>>
>>>>>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_re=
f netmem,
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced8=
5e0d198947be7c503526 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -55,6 +55,7 @@
>>>>>>  #include <linux/delayacct.h>
>>>>>>  #include <linux/cacheinfo.h>
>>>>>>  #include <linux/pgalloc_tag.h>
>>>>>> +#include <net/page_pool/types.h>
>>>>>>  #include <asm/div64.h>
>>>>>>  #include "internal.h"
>>>>>>  #include "shuffle.h"
>>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct pa=
ge *page,
>>>>>>  #ifdef CONFIG_MEMCG
>>>>>>  			page->memcg_data |
>>>>>>  #endif
>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>>>> -#endif
>>>>>> +			page_pool_page_is_pp(page) |
>>>>>>  			(page->flags & check_flags)))
>>>>>>  		return false;
>>>>>>
>>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page =
*page, unsigned long flags)
>>>>>>  	if (unlikely(page->memcg_data))
>>>>>>  		bad_reason =3D "page still charged to cgroup";
>>>>>>  #endif
>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>>  		bad_reason =3D "page_pool leak";
>>>>>> -#endif
>>>>>>  	return bad_reason;
>>>>>>  }
>>>>>>
>>>>>
>>>>> I wonder if it is OK to make page allocation depend on page_pool from
>>>>> net/page_pool.
>>>>
>>>> Why? It's not really a dependency, just a header include with a static
>>>> inline function...
>>>
>>> The function is checking, not even modifying, an core mm data structure=
,
>>> struct page, which is also used by almost all subsystems. I do not get
>>> why the function is in net subsystem.
>>
>> Well, because it's using details of the PP definitions, so keeping it
>> there nicely encapsulates things. I mean, that's the whole point of
>> defining a wrapper function - encapsulating the logic :)
>>
>>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>>
>>>> That would require moving all the definitions introduced in patch 2,
>>>> which I don't think is appropriate.
>>>
>>> Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywhe=
re
>>> in patch 2.
>>
>> Look again. Patch 2 redefines PP_MAGIC_MASK in terms of all the other
>> definitions.
>
> OK. Just checked. Yes, the function depends on PP_MAGIC_MASK.
>
> But net/types.h has a lot of unrelated page_pool functions and data struc=
tures
> mm/page_alloc.c does not care about. Is there a way of moving page_pool_p=
age_is_pp()
> and its dependency to a separate header and including that in mm/page_all=
oc.c?
>
> Looking at the use of page_pool_page_is_pp() in mm/page_alloc.c, it seems=
 to be
> just error checking. Why can't page_pool do the error checking?

Or just remove page_pool_page_is_pp() in mm/page_alloc.c. Has it really bee=
n used?

--
Best Regards,
Yan, Zi

