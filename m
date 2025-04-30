Return-Path: <bpf+bounces-57044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA06AA4D53
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3FC4A2808
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70B25B1E8;
	Wed, 30 Apr 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YV0iteOn"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD7248F69
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019189; cv=fail; b=XPT8ud0ROdbPcW4Lv7ekPyW0rt/VYOZuowPA8VGwWa3hLyLvbQg0VjxuQb9+cn6tDX0nZgWiyEYS9t6KPXdjebWuOZblpq/EopK8iG1e3zFYPgMJyBpnenlJY5zTvR4TnRs6ggmntaw4aG6Sv8J/d33MY7b9xE+H96oHC0Weuus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019189; c=relaxed/simple;
	bh=dQ2AB+Z9iBm4gwChmiOfvQDWe3OIr/ZHjnePaQ6144U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gtnfYHe1INaxSGqY7WccDDhSHAVtY87f5Ie/T2JC/2izxXiXCKqBTi2RanFAiSv5Q0MuxCOqAR07Tk0X04+goOjXQxHC3O/51fg+LKGHq0C+1wA+HI3RCKqWcwrKeA0p5vEwWogsklEO9PZD1Q2S4jT1vkzm1jNPcjjuIMaiUWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YV0iteOn; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1apfWAUn9NUENsrpF8D+7o+5P8omPRJ3YYhxs9XignsTvc2haHk7prNDwYH6sqYzg2u2dRT9aW14YAMqvmHU1Dfd2z9S6FIJJ4j6RXLGgJOR/frUQytbH3/tOf2NwC9gpaZgsVkstyhhSq/qcIPicRycGZPQG7KNQEIqCPqfDfYDxbdFTKd3ooru+ALvVWePDus7Dt08iBIFEgSFVpgLxMMRQu6EjmL4iYTjTicjxavpotIXbX+yKmmRMqVL09hkLc7Dew0QfM5NlvEAzX5WtsZlWufiIOrbVfe/osmIxQsxduQRiM1pHJq+7UI6I6dnaE+aAPguxo5PHOrmBei5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr0DUSTKJ338Qi01zDBcWw2I5Gu2X9PtEIh9NBV0pxQ=;
 b=qZJqCZ/7BrjSvngGdS3wMHex++iSoWwjWFn6rodkRgFVoWWmyCRGH+M0YBTt6wIaHR4L6oBIZ6fZioKBYDPDNsl/hemeJdXN8zuxwspLYL8n4fwKgHXkklNYe9CH7CS4w46HrdqILLXMIh2Tqel2Wrl6Rn8gwhuXzUtdjKtX73tL73vcBDeVnRqzxjzCscIOYguLyZxbS3fwg0UhCpvxRTVx3z+twGxTiC2gBoJE3alO+nYbfzRw9WHK4Wa06Bw9FmOZFV9qraNGk0SWJ6rRovOg/awN7LcFKrfb8jULfl7qQnnHNiDxPAJNkawya/3GlhTEnlWelZg66SYhVHLXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr0DUSTKJ338Qi01zDBcWw2I5Gu2X9PtEIh9NBV0pxQ=;
 b=YV0iteOn3Crhh6X2b8RtGDt8rBt6JeS9cf077mBwLuno4LG0dMBj6jyMQGOKK+2eRhdEGI1YWhtYXRfPLsMmck/PMMqfy0ehVpNrfvY0qdOsMgo8KiXCBLCJoe5tgBGaPVyyxCOgwpak0kd0QfA4AJDAuwSKrWyIRiLRI3IaiaARzKAgPBlp4cQQNA+ieYkTIkLm1SLEjcHPzO0ZjS6HlcNYi5VSBq1st+bxdO7XEJk1WAwZWJNRowJaKofye7ZXw8cD8wOllfkPdth/CCsr63UiTImIcYe93uRf10gC+PfgFaBOrKK9viiEGVWZEccm/SZHDI5NLznRqC7fitHmMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.21; Wed, 30 Apr 2025 13:19:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 13:19:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Date: Wed, 30 Apr 2025 09:19:41 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
In-Reply-To: <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0690.namprd03.prod.outlook.com
 (2603:10b6:408:10e::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d26cbf-4057-4fb1-e633-08dd87e9ab98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVBiYWlmWWd5UTc0a2FaQlB5VkNLOEVSaGZ0clJXWEhQd2tPaUZWRzVNQkZW?=
 =?utf-8?B?UUw0OHMrRys3NHJEejhVK2EzL0RsOW5ZOEJFbDlUYkh6YmxpRGtKQ2IwVm9y?=
 =?utf-8?B?SjdwZjBiSFZJVnF3b2l4K0QxQjdud0tFb0xCZnErdnBVa2VVWmJVTEJhazEy?=
 =?utf-8?B?SDZjVUlyTzlHMEw0b3gyQ0I5Y0JTR24zUHBrVHJia29yVHdORkl4NDBvenJU?=
 =?utf-8?B?WHFXeGhsTUhzNHpIeHozbDF3amVrZU14dWgxQ0NyY2ZjdFdRMzB5TVVHM1FD?=
 =?utf-8?B?TFFOZnNYb0Y2ckgvREl2b1FJZzVhalhiN0Q2bHBmRXZXengwN1lYRE9icVZs?=
 =?utf-8?B?TnBKV1FVMjdLSnFmbGJNYWwxQm1IQ1J6NndPMUltU1Z0ZjhabXpJeDFOTXVD?=
 =?utf-8?B?bTBKanlEVC9KaU5SYUEyTVRjUTNGOXU5aXJsditpeDdYdHpGOXBsZ1hDYldH?=
 =?utf-8?B?aHJoSWx0c3ozOGJLcFd3U0pHWVFROUJ5dVgwcDBYU3k4SWFvVzVNLzlPVXNq?=
 =?utf-8?B?SVJpMWM0WFZ3bkpVUHdmVWwvT2Uzd2xYSE1lT05wVUxKdGJodHpITlNtQUZD?=
 =?utf-8?B?M251SDZFUUQ3TktITzFTc25mbUk4NUZVK3FIT1FmelVGMnZyWWdOSnEwcEhs?=
 =?utf-8?B?US8wR1VvcWdzRTFuSUNsZVQ3Z3hqTTZDRlQvT0hDYnFTeEZ2aUcyckY3TmJP?=
 =?utf-8?B?d2tvajU3amxEalB4THhKNkgxWEw3MDdsdk1XSjBkdmJWWjNVQlg3b2YxdCt6?=
 =?utf-8?B?NXhHUUs3Q2o4T2VVcmhvNmtIMXl5U0JyVU1HUGlEcmt3Wm9FbWM4VXFLREx6?=
 =?utf-8?B?WmtGNW1LVTBqbzZUYUNjMXVYSmNwK3hiYWhDRVQwWnptTldDNVlvbi9WLys0?=
 =?utf-8?B?VFd3eHFUeWZ0dkJudmQ1Nm9aRU5OSkZCQXI4RUlBOUY0UGV1SG8vVWt6dFVh?=
 =?utf-8?B?VFFlMEtTTVJVVzU5K2JxTkxlcUhlWnhUME1BTk5Jamd0ZEhkTHQvaHA5NGNm?=
 =?utf-8?B?OWw2YlEvR04wck5YeUNsTHhhODFwSWo3aXZUK21XZWRiYUpIOGNRNGhHeGdx?=
 =?utf-8?B?Q3BqOXpzRDJKNE15Z3VDQkZGZVdaUEpzSnV0S1czQzhZQW5VOVVGQ1ZUNUd0?=
 =?utf-8?B?TDYxdnNHS0k0TFJQQjhkdCs1NEZCTHhZM055RVgwWkMwMGh5V2kvdGYyTklE?=
 =?utf-8?B?QzJobWh4VGdYUzdDSG4ybnc5R3BIZ0dDNXU4ajJLaWV2aTlGMVFScDhEL1Qw?=
 =?utf-8?B?L1VIYTh4aXY1YjUzbk1qK3h4YkM3YmtwQWFzUFVjeDNxSkg1cEwxbHdFdnFO?=
 =?utf-8?B?MWFZd3l4WFFScWVBd1NuUkJtQ2R2dmtCQkdhTjBtbWowekcrS1hVYWFiRGlD?=
 =?utf-8?B?TDA0aE4wWTlEdzh6bEJJWlBnaTBncDJaS1JkNGFTZnRHbW9rS3RGZUJoUzFh?=
 =?utf-8?B?M2EvK2hoUHFIYnJ1MEtwSWtSSjA4cVg3cjFzL3JPR2lCOXRRaFd4MWI0WjJH?=
 =?utf-8?B?Y01JZFJJTHdTTTRsbWtsVXd4VmtRM256SDNScnQySjdiVHF0eWJudW9nLytK?=
 =?utf-8?B?Zk0xVUJWVm5kR2U1MG16Y2U4cnZpMU9nVXQwQVRNemVUU0E1bDk0SXk5eU9h?=
 =?utf-8?B?OHV3QlZBQUFSYUNrdGhDTFZmTzQrTVFNTmJVenpEOC9HejdNdUdkVFEwWnhv?=
 =?utf-8?B?QWlaRnVCaitwT1FHSDRoZFYyblpYMk9BTlZ6Wjc2QnNUVjUrck1TbUdnSDU1?=
 =?utf-8?B?TkNTYWNrNXQ0YkxzaFJoUzNyeGhkRTJlODVUY1F5NFVoZzEvUXlHdHd1NnlE?=
 =?utf-8?B?ZTNVS1g4NmY1enpaVG0yMHBVRGNmNmF3Q29jMXJjdjhEczZVc0FvZmNvTVdI?=
 =?utf-8?B?VXVCTEhQdjQvN29QRytCbVBRYTJBVk1IREVLaWVSNS9CdEJuWGlvVFFwTVFT?=
 =?utf-8?Q?Cid36BlKC9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVpBSWZFbnBGU215YThWUE1wOVdjOUVJaHNUNElmYkxXTW9iam0va0YzSSt3?=
 =?utf-8?B?OXJHbGdHSlltcWpqSXdQZFdIRFB4Ri9DdTVMOHVIeVNpa2tGSUI2VjZMdlB6?=
 =?utf-8?B?MnptR1l0RUN5ZU5adWJSWkx1c0htN1g2MlByd2M4ZHZndHpBMXhvMFRIY0VX?=
 =?utf-8?B?ZUZUTmthdGs4ZHhXY1lud1RKWWdvOS9TOEd1S0RLODJhVlE3bWdqRDRpODVK?=
 =?utf-8?B?SjRqTFdRL2JVTHREa0lrdGljM1ZrbGFrSGk5MlB1WGJFcjREUmVqSU9DUHds?=
 =?utf-8?B?d083dEJwQ0RnWnVtSG5Rdk5KNHNjV3FyRUJYRWF2bGdPam9mRnhicWpxa0FJ?=
 =?utf-8?B?RGhoL2I0dnFUTDdYVUhqZXg0SjFtSGlMU0dHZjhDN2JQOGtTazhIUWZZZkVE?=
 =?utf-8?B?VGw3ZFl2enNIeHZSRVgrQzFSc0Q4MjJMWWtiWVNJNW1ZSUpESjZJMFZZWmk3?=
 =?utf-8?B?TlBUNFQ3dmhRNlhGOFFjUE8wSkRIWUZreDZZQk8vbmNiWktaUWpwZ0VxVklD?=
 =?utf-8?B?Mk9LaWgrcUVxQ3ZHV0hwR2dVaGY0a0JIbWhiN0NuckFvYXh2dHh3M0ZwVWh6?=
 =?utf-8?B?SUxybUdTZ1pKc1lOOGx3TC9wdEswYUlucjhCMFFxNmxNUXppdXdoS3IyaUdX?=
 =?utf-8?B?a1NGSzRxeGkvWWpJREN4M1NJeVl3c3RneUJjamt3SkxhZWRBb0RuZ1BicXVi?=
 =?utf-8?B?b0VxK25TZEwwV0pBbmo0T1dhTU03VEtzQWhQWkVmSDV1VG5KNGlxcHRzREtK?=
 =?utf-8?B?eXhvUDFkM2hBcDRjNklxRWs3eGx6RTBtRzZ1SzVWOU9GY3I1d29BK3E0NGZL?=
 =?utf-8?B?R0NTOHo2WlBhQmJHcVQxbzVGSjhFKzJrZ3ZPT0Jhb0ZVOVFIVlNldVlrbW5M?=
 =?utf-8?B?RERTZ2hrQ24wMG5URTUvUzZrcXlkUURCT0IyRFFPTnFvMkJ5T1RIY2t1OFVp?=
 =?utf-8?B?UWtSV3oxbFV6eVVGdnp5d3B2aGJCT0w5Q2xGNGtlb2pMdTR5Q3VuYVRKa2Nl?=
 =?utf-8?B?STcvdXhYTFcwaXYvQ1pBK0R4QlhiaHpIck02NEkzUHpYZW1Ta3pkRVA5cWJT?=
 =?utf-8?B?bHAzTmZuYTZlY3VpR3EzS0c1N3JEUFk2MmJoOWhEdFNUWnJNbDFqeCtBczVh?=
 =?utf-8?B?bkJSOXplcUo0RGpJVUhFR2tkZ2wwQ0tyNU9Hc01CZWl6bFFlbHBvZ3ZIaXhJ?=
 =?utf-8?B?WHV5bUt1eXhRVE4yT3RFbFJMSHNDMlBkemxsNWthTG4rNjJLSGpud0dGbS9T?=
 =?utf-8?B?cmY3SW9YdlZDd0VkZ2Vya2FlUFpRVStTQzhOV1ZrVVR0ekJ0Lzhld3V6OFQx?=
 =?utf-8?B?TlV6eURSQk1EelU1SFh1MlZDdkhBTk8xYTd4QmVGb003QUZJWDdNSXN2UTZ5?=
 =?utf-8?B?UStjMllaVXU2WDU0eWdvZnp2THlEYjljcWlvRURxVTFxZkp1d2NOS0JCd0dp?=
 =?utf-8?B?QnI3dS9xemtUdGhleCt1bEtBd2czZDM5K2F5eUdWc2c3dXRmbmZDcnR4My9n?=
 =?utf-8?B?NUx4OG5ZYU9JdE9Nclh5Z2VDUDV4aVdPSHJOazJPb0VNUnlUdEFQdGtGZENW?=
 =?utf-8?B?SEJPZ0kwVWIwbTFzdStqbnJVaFA4UXl2UEt3VDBhUktIZGZTK2duUDVPVU81?=
 =?utf-8?B?Q2ZJM3lCNWRrSWh3bGVERDhoNVBqbDhtb1E4Z2FHMFNOUlpCVXdWRkZqZEVm?=
 =?utf-8?B?VStSTUdKWU0vRzl2Zm81OSs2aEhDQ01XT2VrejQyTlFFMUQxdTYwNFhGY3NE?=
 =?utf-8?B?d1BmWjZqZDVlYzFEVFR5aHJhRlQxR2loY1U1TGpzaWgzNnN2dmdOQURYYkdK?=
 =?utf-8?B?Rkhqd25FSlZMZW1XQ0txelZDM1c5R0x0dXh0cnNKYXgxSEVBMG5xenI5dG5Y?=
 =?utf-8?B?MWRzaFNZejYvdVZvY1VOVlJ0TGw0WHJyemxsNGdWaElVTWpuV2o1ZTlaZER6?=
 =?utf-8?B?WXZNVVp0dVNnU2tqVllpRG55WGQ2UXl4alhBTTFGT0pSZmRuV0Q5RXpZSHlB?=
 =?utf-8?B?U2xiWFc3Y2wrRGYwV3pucEs0ZHNLVTZ1cDZKb3cvUnRuSytoa281UThUN00y?=
 =?utf-8?B?U2FmYmpJM1cvU1Z3bHVBVmcxN2NFNllUdEExY0FRWWtnZ2kyLzR2bVZmdUdR?=
 =?utf-8?Q?heEClO8laTYdQDYVXDtnOXPJV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d26cbf-4057-4fb1-e633-08dd87e9ab98
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:19:43.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN85em+uaym+xzNmuLt962ZIKXeUhUsklwKtkycfoaPROWCKyR4bUSTWamIE7lom
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

On 29 Apr 2025, at 22:33, Yafang Shao wrote:

> On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> Hi Yafang,
>>
>> We recently added a new THP entry in MAINTAINERS file[1], do you mind cc=
ing
>> people there in your next version? (I added them here)
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/MAI=
NTAINERS?h=3Dmm-everything#n15589
>
> Thanks for your reminder.
> I will add the maintainers and reviewers in the next version.
>
>>
>> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
>>> In our container environment, we aim to enable THP selectively=E2=80=94=
allowing
>>> specific services to use it while restricting others. This approach is
>>> driven by the following considerations:
>>>
>>> 1. Memory Fragmentation
>>>    THP can lead to increased memory fragmentation, so we want to limit =
its
>>>    use across services.
>>> 2. Performance Impact
>>>    Some services see no benefit from THP, making its usage unnecessary.
>>> 3. Performance Gains
>>>    Certain workloads, such as machine learning services, experience
>>>    significant performance improvements with THP, so we enable it for t=
hem
>>>    specifically.
>>>
>>> Since multiple services run on a single host in a containerized environ=
ment,
>>> enabling THP globally is not ideal. Previously, we set THP to madvise,
>>> allowing selected services to opt in via MADV_HUGEPAGE. However, this
>>> approach had limitation:
>>>
>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
>>>   third-party libraries, bypassing our restrictions.
>>
>> Basically, you want more precise control of THP enablement and the
>> ability of overriding madvise() from userspace.
>>
>> In terms of overriding madvise(), do you have any concrete example of
>> these third-party libraries? madvise() users are supposed to know what
>> they are doing, so I wonder why they are causing trouble in your
>> environment.
>
> To my knowledge, jemalloc [0] supports THP.
> Applications using jemalloc typically rely on its default
> configurations rather than explicitly enabling or disabling THP. If
> the system is configured with THP=3Dmadvise, these applications may
> automatically leverage THP where appropriate
>
> [0]. https://github.com/jemalloc/jemalloc

It sounds like a userspace issue. For jemalloc, if applications require
it, can't you replace the jemalloc with a one compiled with --disable-thp
to work around the issue?

>
>>
>>>
>>> To address this issue, we initially hooked the __x64_sys_madvise() sysc=
all,
>>> which is error-injectable, to blacklist unwanted services. While this
>>> worked, it was error-prone and ineffective for services needing always =
mode,
>>> as modifying their code to use madvise was impractical.
>>>
>>> To achieve finer-grained control, we introduced an fmod_ret-based solut=
ion.
>>> Now, we dynamically adjust THP settings per service by hooking
>>> hugepage_global_{enabled,always}() via BPF. This allows us to set THP t=
o
>>> enable or disable on a per-service basis without global impact.
>>
>> hugepage_global_*() are whole system knobs. How did you use it to
>> achieve per-service control? In terms of per-service, does it mean
>> you need per-memcg group (I assume each service has its own memcg) THP
>> configuration?
>
> With this new BPF hook, we can manage THP behavior either per-service
> or per-memory.
> In our use case, we=E2=80=99ve chosen memcg-based control for finer-grain=
ed
> management. Below is a simplified example of our implementation:
>
> struct{
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __uint(max_entries, 4096);      /* usually there won't too
> many cgroups */
>         __type(key, u64);
>         __type(value, u32);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> } thp_whitelist SEC(".maps");
>
> SEC("fmod_ret/mm_bpf_thp_vma_allowable")
> int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
> {
>         struct cgroup_subsys_state *css;
>         struct css_set *cgroups;
>         struct mm_struct *mm;
>         struct cgroup *cgroup;
>         struct cgroup *parent;
>         struct task_struct *p;
>         u64 cgrp_id;
>
>         if (!vma)
>                 return 0;
>
>         mm =3D vma->vm_mm;
>         if (!mm)
>                 return 0;
>
>         p =3D mm->owner;
>         cgroups =3D p->cgroups;
>         cgroup =3D cgroups->subsys[memory_cgrp_id]->cgroup;
>         cgrp_id =3D cgroup->kn->id;
>
>         /* Allow the tasks in the thp_whiltelist to use THP. */
>         if (bpf_map_lookup_elem(&thp_whitelist, &cgrp_id))
>             return 1;
>         return 0;
> }
>
> I chose not to include this in the self-tests to avoid the complexity
> of setting up cgroups for testing purposes. However, in patch #4 of
> this series, I've included a simpler example demonstrating task-level
> control.

For task-level control, why not using prctl(PR_SET_THP_DISABLE)?

> For service-level control, we could potentially utilize BPF task local
> storage as an alternative approach.

+cgroup people

For service-level control, there was a proposal of adding cgroup based
THP control[1]. You might need a strong use case to convince people.

[1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asie=
r@huawei-partners.com/

--
Best Regards,
Yan, Zi

