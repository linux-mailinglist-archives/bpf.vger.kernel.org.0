Return-Path: <bpf+bounces-64631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E08B15033
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764AA542462
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4857A293C65;
	Tue, 29 Jul 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ehho2dex"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919D1A00E7
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803163; cv=fail; b=DnWuMxo+H/7hX1LshIOKBCDMvPqPpHMQCZ1rcvzJCnx9UM21Xx/e0RcK8raKoiWH/wYNYJudzmqsCoB4K+WPfyq7gAk5De2Y2N4Hok2lCQi2iTyV26ZL+RWNWgNwBLyyxcvee813zWrxYOhul87oVPDa5QF8Rn9Pkl7dFkRHSFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803163; c=relaxed/simple;
	bh=DO0XajtTnEY7LAETKf7xLoptXcjI/hC/XX0Oi4/EtnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uh7iPXUjlHyD9Xt8l6AeIc9g33qLSmSmL1Rw+3GvpcL7heKfK1+juw00rBi6XOFpcgEuxmNBE3ZVJ2tR4AY3iV/T7qA+JdkflzAOxzVNlQupOWqpZcn4/zWggm+I6SZfjQpnScQvJ2B6VpXYt6UqGNfkNPq/mk46vXfA2actGD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ehho2dex; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uboTHkRw+fASmgOezuyMhrKM5XNGHpfDRiC0oetxYg53/Tijukcvy9BWGsO2KyFsYYK+0RhL64DSRL/AddG5OxzIZMQBgo8RtHb3DrEd/qj5oqGXjq9YPltFPhJkmARU3zqFEOUbXrydJ1KzEjYREX2pitgbeqKQAQqe1GYFvu8ImYp8MWbkyfM/cy1mqow3IqhumYBch9BtF9VD0GohlwrLbFpwUhakLMUVpk7WzsvF9gIqmxDSLt70b7eXPPXmlBYJ6TAsw59JXlRaC6Lqpy9Gifudc4JATZ7IKB6XGSQuwHoC8jC6zsjdVpdHuw+FZYTHXGeHqCfAqGz+1rk5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGrxzt/yhdVaWrFBhT2RkIskS9WTjUJvsx1VYxQ7pUk=;
 b=JFkHN1LnMYxZqvBCUqXDBxMrz4SDEdJqKgl00c8NRXcAl0LeecX7thM0b8fMxice8MvQw6Xp/nEL6R1gVxSdXWaRlSG25v2HueQSTOVeUEcadZqVDoYqXlUkXaaWDFDTOCMuQD5JgV+dl8E3vTwuKsJw0lb9eVlq3xDdbki3UTeFxApBS3eWBmzROMHfozwKjz4NACNl0RkYO5Urlg9Ug2cemDXMt8YCIweZZu42CuYVWz4kLFT7QxZ8GuIfXW/RXbYuWqiaEDrnjr/Qd3+5A67v5UTFms6hyMz7zfZFMSWSrxqjY6PEUROzhkJslWWk4hVUzfwQ7ZUQE3TJ3H4vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGrxzt/yhdVaWrFBhT2RkIskS9WTjUJvsx1VYxQ7pUk=;
 b=Ehho2dexo6kJTJROmHXyy8JI8TBhS772IZoy1AKDWuex3cnoIcQvVpm8i4UA9SI2ocCWIbAOtkFUPbavOw4/nQwuz2r2IcFNZ83t/TNgRMQu21U4BlQSt363wBfnihy68JZ/E31d0gJComVaLXiBB4TxEtY2ATIujdFiNt7KrEuak0XgRIob7fcbTRaqfpYW/78wNagmjUhR2eDBUe3Gm60s/0bGohMBVZ5+9S+RBRV7M+l5qcmzcaqek6LgM1pgPZSCXwG9D2XCxLktrToxQqPeOKDApIKjs/W50h+2G3GFBY6O1aTtA6cQuXlcB7khNBycgdVTMQF5bM6sUv3voQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 15:32:36 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 15:32:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 1/4] mm: thp: add support for BPF based THP order
 selection
Date: Tue, 29 Jul 2025 11:32:30 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F204238B-5B11-41DC-AF9B-4D2AC11ADF5E@nvidia.com>
In-Reply-To: <20250729091807.84310-2-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
 <20250729091807.84310-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a25ca-ad77-4171-1f0a-08ddceb52517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW4rd0NQY0crTXhsclVxZmRGNDdyWXd1TSswWnJyNzNxendOZmZDektsTDZC?=
 =?utf-8?B?V0pIZzFYMVZweUpHeSthb3RtcVIxUGJHbXdUYzZ4alZ2WUtnSjJXNGtyYTZo?=
 =?utf-8?B?QXRUNk9JNHdOVWR3TXprQjZXcHdyZEJMZndKay9oR2xQdnRJQUtXUUlmV1B6?=
 =?utf-8?B?OER4NHJ1cS82dlV5WTJieUlzbWhwS0dlQ21QSVVwSmJMWjJ6SWlGU0ZJWTgr?=
 =?utf-8?B?NzJ2NXlWZk9zYXQrOGpma0ZVWnNUVEVXTXMxWWVGbFpCYlM0VDhIcGJtQlM4?=
 =?utf-8?B?N2xXYkNZb2pWNUkyMFZ3WTQ3eVZrT3ZoRUEvT202ckFQbjNHd1ZpTFdCM0w3?=
 =?utf-8?B?alpGRXAwMWwvanZ6My9rR2ZER2dlcWRMTWhCTUJOa1RVR2d6TjR2M3ZPVTd5?=
 =?utf-8?B?VGY1eTFFQTZKN2dzSmdlTU1TWlJTNERQTXhLK1dRUW9LSldiNWpVTnBMMTBO?=
 =?utf-8?B?Qzg2SE0yTEpQc0xWV0lRUVp1ZnU1SDh4Q1RqdWt1RWNIK3ArckpUemV6am14?=
 =?utf-8?B?U2t0ejFIT0pEUnM4bUFsMk5BdldUeFhRL3AwS2FxY3RSLytIOGgrRllyNk40?=
 =?utf-8?B?QmFGYThjWk16dDBjQ2M1Z0VyaVVncC9WSU9tTitYMWZkblF2MXFwUjFJZm9S?=
 =?utf-8?B?aHFDdE9sVi9hR1VWYktrV3JRcytKc0xMQ1dmUWpjeHhrbERWbGZIZ2RWWkQ1?=
 =?utf-8?B?dmJmQjdOV2xDbDFLa092WVJuRmlJMVp2b1VLRmxSN0hpc0l1Qi85M21rU24x?=
 =?utf-8?B?R1pYdm1wSjhUTzg2Slc3WG5yeFFUdithSnA2NS9mOUYrd2V6eXU4MGl0Qmha?=
 =?utf-8?B?Zjc3WWMycFNPN3JRSEFZdlJVaXN6SnlHei9RaUJpbW1ma2ZnbWtwWGEyVWty?=
 =?utf-8?B?R0RJbFFjSEtIVGptZE5kVFQ3T29TZitKNDBoSVVNU3M3TWJ0THlDK0JvT0w2?=
 =?utf-8?B?dDNMNGhJU1Q1LzVkUGRyaFA0VkRCbmFtQ3ZtbzhJb1E5OHYvVDMvWDYwZ2FT?=
 =?utf-8?B?SFJQV2JyQmc0ek01MUhtNnc2R3NpUkRYWGF0UnpQM2d3SUxUdDdNZldodHBQ?=
 =?utf-8?B?TStYQ3Z1dUUrdzk2aEhIb015NVNWMEhkOTNRRS9rdHJtVmdkMDhGRmQramJB?=
 =?utf-8?B?dWhNWFZNVzNRd0JJeHYzMzhoZjZRNWdxSWFLQVgvQUZmQlBIQjU0bkxMNW9u?=
 =?utf-8?B?Y3JUT1lRcm80TTlCdEhqNGFpeHphcEJxakxKc0NBajk0VGYyMTExaXNxUk1S?=
 =?utf-8?B?L1ljVHp6SmRqVU9UcWZCMWZTTDVZZ0hCU0J3TWt3NVFwNFJ6WGlQbVpwTzZR?=
 =?utf-8?B?QmpZWmhUcGJwT1I4ZVRXamk2NGpoSDBuZkpwbjhhd0JPSzlMNGVGbiszQS9P?=
 =?utf-8?B?MWx6MGlUNUR0aDl2ZDVCVnVvZ1JieE9VRVVFU3J3b3BKczZURlJkbTNiMkZi?=
 =?utf-8?B?V3NPQTk5dkdFSGdER200Q2M3SzFBUWJUYU43R1Q2N25OUURlb1Rxc2FuR09x?=
 =?utf-8?B?ajhabTJ5YTRyQXJaRnhxcHVWT1RycmdvamtnNkN6REFtaEY1UlhUZ2JNeldZ?=
 =?utf-8?B?TWJHb0Uxa3FKMXV3VTArSkFRZnlVQ0gxRnBFY0dvZklsK1hyVWFKQ0N3dUdF?=
 =?utf-8?B?b3RwU0hyVlUwQUZCdy9jbzZLbXNMdG0zYm9sUGthZEJIMnNTUWhsMFlZWlRG?=
 =?utf-8?B?SEVPZTIrMGRZVll1Q2pOekE2ZlM4a0gxcXJNL053QWV4QU5Yajl6ZjV1cDFh?=
 =?utf-8?B?K05yQVRSbXhtd3ZTbHRpYWhkVHY2MWR3WEJTV1JlS21GVHQxbitVdFlzV3dS?=
 =?utf-8?B?cGZKL25CS1dlT0JvR3YvYStUOHp2Y3FQVGZWa010MHlwZ290RHBZNjF5bUxC?=
 =?utf-8?B?dWJtMUYrNXNLZVFwYUN5TDh0NmZKYU9UaDYrMjRDdDQ1L2NXdEpMYW5aVnNX?=
 =?utf-8?Q?O4w5TgI34tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2NZbFRjYzJDMlg3aG0xTlkvNjArZnFRRnFBcFI4RS9hTUR6dEZkKzg0VFYz?=
 =?utf-8?B?SkFjYzVkUTg3RTM2WWVKZHZBcEZ1cDFLTUhOOWlnVFlIZTd6NGNQeDJpaXMx?=
 =?utf-8?B?aGtxdFI3Z21HWVhZQ2FkWnI5ZnloOGV3YmFjeE42Qy85RDdIUlYycTkySVc3?=
 =?utf-8?B?cUFqd0VUMTM0Mzh4QnJ1QWFiOS9RcUgwaTVvcVNEcGpHNitiQkxyYTk0TlBC?=
 =?utf-8?B?eW8yTngxcGI3MG4xU1dHNzFBekFZeEpGckxkUGhkODErQVJCcm5QRUFIa2pn?=
 =?utf-8?B?SVN6bVdTRFdTMXhaNnlNcHBMd0JRRXM4VU0wVmJWeDFhOWdPYkNMYVpZZ1B5?=
 =?utf-8?B?VTdEcXRFa1hGRHJwUnpSYlhwUWNXZ2Vvc082MjlNbEVZMkNSOENFOUZGY1Y3?=
 =?utf-8?B?ZHVLMXptcTRVZmo0Q2dsQ0Z0V0tGTDhDVVg3a3ZGVWt0TUtyVWF0SHgxalcy?=
 =?utf-8?B?bGpWcTJSUS9YNkozSnlaUS9LTWdsSkZjYjRBOWxxYUxBUHIxajY3em1ldWVn?=
 =?utf-8?B?VHZ0ekNUeHFrT205OWRUTTVmKzUwUmRNbzVjUG9PR3BJTGxWdGFwSk41NUV0?=
 =?utf-8?B?eTRDbS9WTnZhT21FWEFHbGZxRGkzemVkTGR0K3RiMkZ0Vmg5bkx1a2c4R2I0?=
 =?utf-8?B?MFlmV05rY3NadEN2L1NEcjRkbEppUFZNUmM2M0FYcWo2a1FucnhGRWphZExV?=
 =?utf-8?B?YW4rOVVmaU5NMFd6U0JjaVJBSzZaaUQxUTMwUTc4dnJrL2toaXh2dlZOMkJy?=
 =?utf-8?B?L2lSNktkeDRETWlNS05tbHdEV2dzV1VnSUxsNTBsYWJLczRWTm9pUkVCTUR0?=
 =?utf-8?B?WkxEZXBwN2JiOUYyeU9BcE03dFFSQ1VITFIrUnJmSEpYZUNFamY0NjBkUDlK?=
 =?utf-8?B?bUFNL0dhT2dxVDNWY3cxVXlyUy82Rys0WW1KdDFsSm9LbE5FYlNyQkRBZ0tH?=
 =?utf-8?B?WUlkUXlzZFgvVUE3RDNaSUZXeWJldHZoYkVMa1ErWVRyNkl2S3kzaFB1cU9q?=
 =?utf-8?B?cVNwbC9UMTFVeWVnQm9vTUlFYjladmwvM0JvTmMxVDRLZjNxQmJnb3VZd3J5?=
 =?utf-8?B?bmttN1VLTnRBOGZjeng2Sk5zeDgwZEsxbTNGd2V0RGZleUsrK3Z4S1ovK1VX?=
 =?utf-8?B?ZVFqby96MUVUZGRRaXlqTkNkMW1zNldwYUtLL2haR0x4T0paYlRnTGVPTmR1?=
 =?utf-8?B?UGFWMDFqZzMyR0lTLzVKOTVySk1weit4dkFwbmQ1S0JwdHdPTllOL0pxQ09x?=
 =?utf-8?B?OGxFQ0hYb3hEUUoyR1hCUXRSa0NLQ3NpaUMyNWZaaHBDRmJjOXRFcmRwdTlm?=
 =?utf-8?B?QVdwMkRpNVZMTW5YekZoSnp2dVhIZVNsSmd3Qkhlc1hlbWhGVmpZVXlBa2x3?=
 =?utf-8?B?VmVQNFZGQmRuOGZUWDJHM3FLdjNmaVhVa2Z4d3Iwc2FBUDdwK2VNM3NVcnhJ?=
 =?utf-8?B?RmNXM1BpYm8xY2NPMGlsM2lZRUZ2SlN6ZmdLVmk0Z1hhT1NQYTJpM2M4bUtY?=
 =?utf-8?B?eG9lOFZSNktOSFk0bSsxWUtTcGUyTnBuUkpQRFJ3ZXpqSXV1NXR1dnRoSWRt?=
 =?utf-8?B?UXRuZzU4dGowR0J1dzdqMGhLWDZjVGcxYVJ2cGMwN05DanczNFBDWWxESE5D?=
 =?utf-8?B?a0JQZTJ3QjNJYUtDYng1Y1NCbzVWbVdrZ0dJYU1SQjIweUhjQkV0TlF3RzRs?=
 =?utf-8?B?eWtHc0xBS0t1WjVpeVBDeHZkSzRINEMybGNucFlSWWhQUFY3SlJvNzVGSk12?=
 =?utf-8?B?N3pnY0xRYk5QVUlVR0N0NnFQalB2SURuNHJ4TWhqNkltSnlxbHY2bGptTWcw?=
 =?utf-8?B?czRJNDc3S2NPY3Jzcll2RWZtd1dLeFkrQlRBVCt5MHZWWjVsZ2d6RUVFOXdO?=
 =?utf-8?B?elAxUjgxWmdveE1nS0NiSnZiWHdpYTFwUUErbHczUkF3czAzQ1hzZ3JHNk0w?=
 =?utf-8?B?VTIrRVU1U1NRT2JCblpJOS91d095UnhCMTk3bkRKSHZ2T0dxMENadjM4SEVT?=
 =?utf-8?B?Nk03UVNCME4yanA4RXRCaURSa1diQkpwVEFWT2tPbmZUSWVEbS9aaXJLTmE5?=
 =?utf-8?B?bktVbk9QUmlzYy8vRG8wL1NyT1pialJ5Q1BpWmNzdWFuSEx0cUNMRWJNOHli?=
 =?utf-8?Q?eZ7A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a25ca-ad77-4171-1f0a-08ddceb52517
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:32:36.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1mrqFffKbLlWuLxiXlMV9zhVeM8NbkRjZSV3CG8PUpv5FsgaznesMu9GOvznOq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

On 29 Jul 2025, at 5:18, Yafang Shao wrote:

> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
> programs to influence THP order selection based on factors such as:
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, or other
>   paths.
> - System memory pressure
>   (May require new BPF helpers to accurately assess memory pressure.)
>
> Key Details:
> - Only one BPF program can be attached at a time, but it can be updated
>   dynamically to adjust the policy.
> - Supports automatic mTHP order selection and per-workload THP policies.
> - Only functional when THP is set to madise or always.
>
> Experimental Status:
> - Requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> - This feature is unstable and may evolve in future kernel versions.
>
> Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.=
com/ [0]
> Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer=
.local/ [1]
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h    |  13 +++
>  include/linux/khugepaged.h |  12 ++-
>  mm/Kconfig                 |  12 +++
>  mm/Makefile                |   1 +
>  mm/bpf_thp.c               | 172 +++++++++++++++++++++++++++++++++++++
>  mm/huge_memory.c           |   9 ++
>  mm/khugepaged.c            |  18 +++-
>  mm/memory.c                |  14 ++-
>  8 files changed, 244 insertions(+), 7 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..5a1527b3b6f0 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -6,6 +6,8 @@
>
>  #include <linux/fs.h> /* only for vma_is_dax() */
>  #include <linux/kobject.h>
> +#include <linux/pgtable.h>
> +#include <linux/mm.h>
>
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -54,6 +56,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
>  };
>
>  struct kobject;
> @@ -190,6 +193,16 @@ static inline bool hugepage_global_always(void)
>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
>  }
>
> +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> +int get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, i=
nt order);
> +#else
> +static inline int
> +get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, int o=
rder)
> +{
> +	return order;
> +}
> +#endif
> +
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index b8d69cfbb58b..e0242968a020 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
>
> +#include <linux/huge_mm.h>
> +
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern struct attribute_group khugepaged_attr_group;
> @@ -20,7 +22,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *m=
m, unsigned long addr,
>
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struc=
t *oldmm)
>  {
> -	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> +	/*
> +	 * THP allocation policy can be dynamically modified via BPF. If a
> +	 * long-lived task was previously allowed to allocate THP but is no
> +	 * longer permitted under the new policy, we must ensure its forked
> +	 * child processes also inherit this restriction.

The comment is probably better to be:

THP allocation policy can be dynamically modified via BPF. Even if a task
was allowed to allocate THPs, BPF can decide whether its forked child
can allocate THPs.

The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.

Because the code here just wants to change a forked child=E2=80=99s mm flag=
. It has
nothing to do with its parent THP policy.

> +	 * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> +	 */
> +	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags) &&
> +	    get_suggested_order(mm, 0, PMD_ORDER) =3D=3D PMD_ORDER)

Will it work for mTHPs? Nico is adding mTHP support for khugepaged[1].
What if a BPF program wants khugepaged to work on some mTHP orders.

Maybe get_suggested_order() should accept a bitmask of all allowed
orders and return a bitmask as well. Only if the returned bitmask
is 0, khugepaged is not entered.

[1] https://lore.kernel.org/linux-mm/20250714003207.113275-1-npache@redhat.=
com/

>  		__khugepaged_enter(mm);
>  }
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 781be3240e21..5d05a537ecde 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -908,6 +908,18 @@ config NO_PAGE_MAPCOUNT
>
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>
> +config EXPERIMENTAL_BPF_ORDER_SELECTION
> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> +
> +	help
> +	  Enable dynamic THP order selection using BPF programs. This
> +	  experimental feature allows custom BPF logic to determine optimal
> +	  transparent hugepage allocation sizes at runtime.
> +
> +	  Warning: This feature is unstable and may change in future kernel
> +	  versions.
> +
>  endif # TRANSPARENT_HUGEPAGE
>
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index 1a7a11d4933d..562525e6a28a 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
>  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) +=3D bpf_thp.o
>  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
>  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> new file mode 100644
> index 000000000000..10b486dd8bc4
> --- /dev/null
> +++ b/mm/bpf_thp.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +struct bpf_thp_ops {
> +	/**
> +	 * @get_suggested_order: Get the suggested highest THP order for alloca=
tion
> +	 * @mm: mm_struct associated with the THP allocation
> +	 * @tva_flags: TVA flags for current context
> +	 *             %TVA_IN_PF: Set when in page fault context
> +	 *             Other flags: Reserved for future use
> +	 * @order: The highest order being considered for this THP allocation.
> +	 *         %PUD_ORDER for PUD-mapped allocations

Like I mentioned in the cover letter, PMD_ORDER is the highest order
mm currently supports. I wonder if it is better to be a bitmask of orders
to better support mTHP.

> +	 *         %PMD_ORDER for PMD-mapped allocations
> +	 *         %PMD_ORDER - 1 for mTHP allocations
> +	 *
> +	 * Rerurn: Suggested highest THP order to use for allocation. The retur=
ned
> +	 * order will never exceed the input @order value.
> +	 */
> +	int (*get_suggested_order)(struct mm_struct *mm, unsigned long tva_flag=
s, int order) __rcu;
> +};
> +


Best Regards,
Yan, Zi

