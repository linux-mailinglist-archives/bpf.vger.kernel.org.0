Return-Path: <bpf+bounces-55397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA0A7DD95
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CF1188F316
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D824886A;
	Mon,  7 Apr 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ObkhDt4Z"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0E192B89;
	Mon,  7 Apr 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028667; cv=fail; b=j0K9fhPhtEV66yRDTCMvnAs+AQoYDCjdcPoJ70Rj88H+NH7wf2mMp3ZrED54J9JHTnIhGafJPQgFe/rWZ7+EZpCEu7DVuyh2goskvvSo8C8m6sjS6MkrdtaR3qN8AAxyySvHZBOfe1spH8+8jrWdW9d4h3zBh+G7mPrNSfrJcA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028667; c=relaxed/simple;
	bh=ux18igd2NOSRUicsYJtH7SKSMKilNcJ3/wh55lAl4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2jeQzqKKqg6w/KstLRCFLLa5/QgTw7PEOoFTTLNmwsvJrUOwZqaJkgVzd9QKMOLpJ8zjj8db8gZXLCa7NIGIW4UPeoPb8HOo7P+UL5YzwbgpbXQSv/iG6GLuGS1UBgkjIdws7CKbBfS8woLQyXCWbzkJ302w2csXXBIpSmn30o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ObkhDt4Z; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkaNAtTQmb92q+96+zpT9tg8cumdRYlr+RmWvnCsKYKH1Zaeq1HQFAR7iaEQZexe1rqgFsvl2NjtdAzROOg5LBxn4QbeFxn202yoeviKd0oXDoc+Afcwh7/Igw75zM3IghTzt2o7haaND4MsyOR7sPX7PYlU89LEaYaxKTD2i4akJoUxQWq42buQ5TxcHfMF3ZOHaXnurHucROYalaXWm2//NZUa/PBhgVD3QQa7HYVOMA9dBzNigR/prk+YYDS6IBzc42tcbuJNVOQp3fiOWET1oC/TR5fi+gIOQQ9MooFM011GpWzlbH1PJksFi8tAFA+CKGqnNzTkfe4IgTG9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+kfU8oMDCuj5ciVMhKyMiRcaP6BNsW2ICX4Y3IH/pc=;
 b=TGc4+tTUOyxDsp2PpZj9mmACAHPwH3NuwPCL94nDo+3MZOWqYSwMPUqoW0HBCJ6KxL3pjJMQvgWVf+yIsDoQfqh4WDV1rBz8FvVHtC5gUN9eCsT2K17vcyzWwsB5M4vGOMo1YjsMwlDNNnFBB5SFlULDttF/YUtHM2Ehv6d13/gp8zKckxfIAJFl2fOdexW+++Ek9Sp7n6m6LjdmiIBqT5aSsZC3Vor3r/3SwZM32xh2J9KuUQwOr3a/ElPfsGB2SqVQ3Lx+eVCTLVO8BlXJge0AKNGovIkcUbCFNh2Sj2WsjM2TrEu0/JaSB/YYdZqPb1eRIWPABpwLgaQD2bYXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+kfU8oMDCuj5ciVMhKyMiRcaP6BNsW2ICX4Y3IH/pc=;
 b=ObkhDt4ZMctuzV5xA9YBwXJdOu/xw1SDbe1iUIU/3eyWcUC3b97/mAajiBeqAmcHUjKgdz20jMSWGj0lB5KAeZ6xEdHbrOeddPPLT1/ORef8Vjq/JLYMsGYXXhEd8hpksFrYUKUeIECefUTdUBDh8TTudEa7ez/aBXdNPEZA6QjBZlRTKwzqL1IDgkAqEGxT2mccdpx/Rq6werzE9DGAgTQB8Jx+LvTZST66/cFB7vu3rmZKJi8gCyi76cYekBoBb1xNy5EbsC84mwFuji+aDHp9sc4JZowDc8UrZDgERsIy4Ms/T5W+08pV3Ds5lgtVLMI1WEbOg8P43MIFnv8lCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Mon, 7 Apr 2025 12:24:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 12:24:23 +0000
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
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Date: Mon, 07 Apr 2025 08:24:20 -0400
X-Mailer: MailMate (2.0r6238)
Message-ID: <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com>
In-Reply-To: <87cydoxsgs.fsf@toke.dk>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:408:113::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1736c1-81bd-4066-3c99-08dd75cf2108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NktKK2c2cEtsNTFMT1hmMWRsT2I3WnlKMXhEclNXK09iL090OUt5YjAzTThW?=
 =?utf-8?B?ZWhQTjBidGRYWFcrYkg4bzRTNnA1YnhYZ2JIVU5RT3MvOEtzRWRpa0RIdVdr?=
 =?utf-8?B?ZDVuVnBxVUpUcEloUnlqWmVIRll5b3NHQktBQjhRVi9zdkl0c0kzaFZ5d1Bn?=
 =?utf-8?B?RHVpR2ttaDZxellHcTVsUXc1NHVLZlUzMVNjV3RiSHhGTlFaUGxLbFBhSkIv?=
 =?utf-8?B?YVhaTGJKMS9xN05KaXFGQkp0aWs2VlJnUVZaV1VKWmJBdSs3U05OVXZrbTZ0?=
 =?utf-8?B?dTZYcjloVVJBeXQvbVpCcEVLY3hySmVmdFVFckZTdVM4QlA3NTZMenh6Zk1l?=
 =?utf-8?B?QWhzTENmV0N2MGpZcDJOQnhJeUVOMVh0OFkvbERpTXhvSTJmVWRxYU1vUXN2?=
 =?utf-8?B?bFdnQUJwdk1acEtsdlJEc25DTnRkUnhMcXlHZUJSUWdOSHVyWlQ2R243eHFZ?=
 =?utf-8?B?NXJMWjhaSHdRUVlobDRSSytsOFZFblpieVd3blh3OFU2cmJ6bnFnZkpScXVs?=
 =?utf-8?B?aHNPcnFkWFNsYng0T3gvYnE2VVlwYjdlMGhSR0lVcDkvbnhTcEtWeG8yQjk3?=
 =?utf-8?B?QU03MTIxTFJBVnJXQjJyQW9sMmVzWHUrNG91UzJ6M3N3WHprZGVJaUNUYnli?=
 =?utf-8?B?cVF1Z2VacW5WVkp1SkZqWFVjVTRpVFFXUjZoMDR1Wndtd0JRamhrcWFlUjB5?=
 =?utf-8?B?YmVlTXYvOXY5K24yeFFOSUJBZUJJRi9WZXdEMzY1c0lOelQxeXdrUlFJYU1U?=
 =?utf-8?B?bXBTR0dqemVkc1pGT0VieVRtUTZLMHVwWnF1RHdhZFlVTm5oMWdEbzlKNGc1?=
 =?utf-8?B?SmRQaGs5OU95SDR1Vy91ZEUrNEpUcUwyTGdaUEdTekszRWxyUlRyT0pnWGlt?=
 =?utf-8?B?Q01vaW1IbTlMdjJDaC9Ya1ZqMmdUdk1XTVdnK0dWcTRuV2dWalJHSmhLU0JS?=
 =?utf-8?B?RDdXc2xkMkVDUWtwT0cySm5nSzNkWGtPRFZWR0tpWnh5OTNNdXlYbGVDZWlm?=
 =?utf-8?B?UEZSUTZXQWZCd2tDSW9PN3M0TGxncVRKZmxGdTltLzYvOEJKWjV3Zm9WMWZu?=
 =?utf-8?B?bGtrZVJueUp1QUxjeTY1L1dIT3NPNUtlMElNUzZzOUJCVEFlQnJQV3pUTmdu?=
 =?utf-8?B?ZFI5RFJET0ZEZ0ZUc3JOaUZ0WXJOeGRrd2U0WnNxd09NUHRzY0p3MHdCU1JG?=
 =?utf-8?B?Z202Um5lRGtUQVNCUE1WRCsvUUgvWTVmR2htc3ZoL1BZcUxrU2QwSzFSRytQ?=
 =?utf-8?B?YXJLVFVJVUFtYzBoeXFFdFhCWDRDc2hlN0dkTXlaaEJPWlFyaFB1SGZTMStS?=
 =?utf-8?B?aGRiY21BbklIanBRanRScjB1d2t0ajVjQ3JWSTFuNzBNRXhXdmdscXAyUVNX?=
 =?utf-8?B?S3hkcFFSaG14WVlxSWNFU2xtZFdLRmRmUzZlVGduYldadzJKRjBSZmlDSmZu?=
 =?utf-8?B?ZHMzTUJLS1ZUU3FWYU91TUlxak9CdlEwcnlYS002WXI4WHFqa01OZ1dKSDlO?=
 =?utf-8?B?bTAxUC80cU0yZFJWTFc2a1hMc1Q0VDFPY1dsTERDTExIaXI4aHYyS3lBZGNX?=
 =?utf-8?B?OTlNbzU0S0w1ZUcrQXdTSEtaMGZhTkdTSUlSeGs2QU5JeTUyQ09jaURRdmor?=
 =?utf-8?B?aG9TakNZdHp3Q0NHOG5OUG43SVRKSUpJQTFjcDFSN3RBWk9COFRzMTJQVGxJ?=
 =?utf-8?B?QmRxVm1hM002Rnl0NnB3bnh0MjNRcmdaQU1rNnhtd21MZjNkZU9Oc0lsYW51?=
 =?utf-8?B?TC90MFRrOW50cWxMcWlBS2lBV3NibE1kdHlpUGlObmU0RXFROHlOcmZEWWdL?=
 =?utf-8?B?QkNjNWZ1SnVxdWhzcE9hU2lPWVQwZEE1dUMrdG5qQkRqSHRkb3FoOVFoc1ZD?=
 =?utf-8?B?MkwyajJVbUgvUzdoVy9kV085d1NHZlVQTmdkTUUvc0RBK09wSmtUbjFCVWJj?=
 =?utf-8?Q?7wgWW4pZvyM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0k3S0RDSUx3OTc0TW9LZnJlNzFvZnZDWm9sN1AvK1lxYWVEL1NmME40ZGZE?=
 =?utf-8?B?eXBtTDA5eEZJcmtPMkZiaGZlc2pqdHpENEhPVTJ2eUdKOFE5bjl2RkxVTFVi?=
 =?utf-8?B?KzNLY0NhMUE0aFhyTUM2d0hVSXliT2s3bzRNblI5ZU5HMGF6OVdSSUJ0VzB1?=
 =?utf-8?B?aWpwaGtSUmtUWkFyNlFHVkxwaEpXNDVwa0ppdHpXMFAzZ2w3RE5QMFF4N01z?=
 =?utf-8?B?QWhZNjU0SUFwTDNqQS9jY0ZDNEc1L2p6VW1HbEF2NlBtMUdyaG12WmlTUlVy?=
 =?utf-8?B?RFBBQW1qMHI2YUNrbXdXVDExT0oweldoaDZMc0I1UXdxZWZTTmhZZ3dnMmhI?=
 =?utf-8?B?dUlXSDhJTXRJWFRhQ3lZTTZBbFBIbXczdGs5QnArUzNrYWxWTTEzbW9GcUFN?=
 =?utf-8?B?cG01S2RGRWxBWkEwekdRRjVEZFM1cjhhQVVVZEp2clRWK1l2bGtBL2ZXaHBX?=
 =?utf-8?B?SDZ6NWFZU1lGbDlVTENORW11cGtkQlM1NWpWVnh1bTQweCs5aS9NdG9meUFM?=
 =?utf-8?B?VloxMHZGaGRvRUVRazljWnFBdFRnWkhZeC9mdmxialJJUzBtK0RTYmJIZWRE?=
 =?utf-8?B?RnIrN1R3S2VJNUhaei9aSkl3c1NZcVloZVpwUVRkVGl3ZjBJa0FnbmNCZHFy?=
 =?utf-8?B?YTlubHZJL0IwSUNOY1ptaFlEc01IUTNqbGRwYTNpdGRSUStRSGdqSGZyOGx1?=
 =?utf-8?B?THJ0MzRjS3NkYXB6NnVNQTdEOFRwRHBZWFdtSlJUWVJCN01OZWRjeW9qdGJY?=
 =?utf-8?B?c3BLZXRUaEtoRjB5c1VJcE1XMmNIN1BpWW5odTU3SiszYmxKSzBuZUgxaWV6?=
 =?utf-8?B?RzgrMVhmUEVpRUtkbjZHUlZ0bFczSHlDTUwyd3VTK293UC83Z3dhL1NIWlBH?=
 =?utf-8?B?UjRGbGRuK2JvNVBSdmVLMmhqYjBSMjdTdTh4aGFrNTIrYlJPNlBYd2RpOGNU?=
 =?utf-8?B?aUVybjhQbm9PRlE0QjU1c2ZTNndPaVBZQlpxcFlRNnVqTHMrbGkycWFpZXdl?=
 =?utf-8?B?U0RvSmJlVWhzVFFXd0JlUXdldEZsc3plWEZKWWpPdStnY29rR1pvd1QvbUQ5?=
 =?utf-8?B?S3YyeU1YdXp4eW5lc2Y5MkpEN1E4VHpIK1BVT3BIUnhjVzI5RmlXYlNHMllQ?=
 =?utf-8?B?RnVjbFZHV3hoUy9CU1QvYjdGMnV5Wkd6Y2RXalBxdkRYVDlsdVh1bVNEMGd5?=
 =?utf-8?B?eDcxWitQMEZNcHZ1VXo3aWpoQlZnQXpyeHM4TmRIZ3R3ODNGakVUZVRlMUtm?=
 =?utf-8?B?NU4yeW5ldmNiVVlpUmRqbFA4ek4wS05aVWw3Y1F5TjE5RGtWRElWYWl5U1Bw?=
 =?utf-8?B?NzVQQnVmam91KzcrQll5L0p5Zk9TaVk4RXhsUHdPdTE4d2tjVTYzWWdoTG9R?=
 =?utf-8?B?SUVlS1BERmZUeXd0QjZvUUVOOFBUSEcwVlNKREJoekROb25nQ2xFOGZTTytG?=
 =?utf-8?B?TUJtdDJoTTJGaTdZb3pObDlMUEF6Yk5iVytMS3dxaGMyNXVTYnZnT01PQVVC?=
 =?utf-8?B?L1phOGN0dHRqYlZ3SC9KOUVzc3R4bVlON2FKNVMzdkNkYzQ2bXN2R2ZKK2hV?=
 =?utf-8?B?dW00T0xoaGtRNVdRVnVrdmpYZ3A0bUlLY2dVMVhsN21EcVhIRmxBOXc4QnFR?=
 =?utf-8?B?R1lmRVVvMERtamhsbDdWbGd0Ri9meGY3K3NEOWE1L0xVNEFab1pPbHNqc2lY?=
 =?utf-8?B?MEtzc014Mnd6QXFoRzFXaXkvblJiSWlFVDdORVNlOVVDcW4vdkVMSm1aNkpM?=
 =?utf-8?B?NXRBM1pMMy9zRngwcGtyc2poZE80bTRqSmpxNkx3eHI2WnhqQ0VDcTR2V0pl?=
 =?utf-8?B?cVFTZ3NyUW91SS9MdEZJVzNqVUx0OC9NSGtBWFp5MDBKTDlndi9iY3Y4OFVJ?=
 =?utf-8?B?ZXQxaFBEdXV5TTFxbXJCUStpbTJtQlNOQXJVMkJ0TmV2ckYySDc4YjJRTUlh?=
 =?utf-8?B?Rk1sSkNQRmVNS1ZBek8xNnFoR3N3T3N5WTl6UmxZelVWTS9OM0s0T2UyV2VJ?=
 =?utf-8?B?R0pxd2o0WlBrdyt5UkozdmRUYWhOdlp2MTZQeTFtZG04UndQZU9FdUdXaG1Q?=
 =?utf-8?B?TFI0U29ucktjbzRzQzF4VnJOZnkrb0daWXRpVW9qSmFiTkM5TzQwVmZiRUhU?=
 =?utf-8?Q?qlhu4u52ll0c1cqkUv0XvJg/M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1736c1-81bd-4066-3c99-08dd75cf2108
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:24:23.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2XxBmnkthnxF7Y0FQB656jvjCTGq/rcmtTl4iy9SxfHyL+9jWHFQSxaA5dFDqmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

Resend to fix my signature.

On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> "Zi Yan" <ziy@nvidia.com> writes:
>
>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>>> Since we are about to stash some more information into the pp_magic
>>> field, let's move the magic signature checks into a pair of helper
>>> functions so it can be changed in one place.
>>>
>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>  include/net/page_pool/types.h                    | 18 ++++++++++++++++=
++
>>>  mm/page_alloc.c                                  |  9 +++------
>>>  net/core/netmem_priv.h                           |  5 +++++
>>>  net/core/skbuff.c                                | 16 ++--------------
>>>  net/core/xdp.c                                   |  4 ++--
>>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
>>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb2=
6173135ff37951ef8 100644
>>> --- a/include/net/page_pool/types.h
>>> +++ b/include/net/page_pool/types.h
>>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>>  };
>>>
>>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_ma=
gic is
>>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve b=
it 0 for
>>> + * the head page of compound page and bit 1 for pfmemalloc page.
>>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid =
recycling
>>> + * the pfmemalloc page.
>>> + */
>>> +#define PP_MAGIC_MASK ~0x3UL
>>> +
>>>  /**
>>>   * struct page_pool_params - page pool parameters
>>>   * @fast:	params accessed frequently on hotpath
>>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(=
void *),
>>>  			   const struct xdp_mem_info *mem);
>>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>>> +
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>> +}
>>>  #else
>>>  static inline void page_pool_destroy(struct page_pool *pool)
>>>  {
>>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct pa=
ge_pool *pool,
>>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 cou=
nt)
>>>  {
>>>  }
>>> +
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +	return false;
>>> +}
>>>  #endif
>>>
>>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref n=
etmem,
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0=
d198947be7c503526 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -55,6 +55,7 @@
>>>  #include <linux/delayacct.h>
>>>  #include <linux/cacheinfo.h>
>>>  #include <linux/pgalloc_tag.h>
>>> +#include <net/page_pool/types.h>
>>>  #include <asm/div64.h>
>>>  #include "internal.h"
>>>  #include "shuffle.h"
>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page =
*page,
>>>  #ifdef CONFIG_MEMCG
>>>  			page->memcg_data |
>>>  #endif
>>> -#ifdef CONFIG_PAGE_POOL
>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>> -#endif
>>> +			page_pool_page_is_pp(page) |
>>>  			(page->flags & check_flags)))
>>>  		return false;
>>>
>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *pa=
ge, unsigned long flags)
>>>  	if (unlikely(page->memcg_data))
>>>  		bad_reason =3D "page still charged to cgroup";
>>>  #endif
>>> -#ifdef CONFIG_PAGE_POOL
>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>  		bad_reason =3D "page_pool leak";
>>> -#endif
>>>  	return bad_reason;
>>>  }
>>>
>>
>> I wonder if it is OK to make page allocation depend on page_pool from
>> net/page_pool.
>
> Why? It's not really a dependency, just a header include with a static
> inline function...

The function is checking, not even modifying, an core mm data structure,
struct page, which is also used by almost all subsystems. I do not get
why the function is in net subsystem.

>
>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>
> That would require moving all the definitions introduced in patch 2,
> which I don't think is appropriate.

Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywhere
in patch 2.

--
Best Regards,
Yan, Zi

