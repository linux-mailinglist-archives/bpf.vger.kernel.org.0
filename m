Return-Path: <bpf+bounces-64182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700AB0F7D9
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE12176BF9
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DB1E9B19;
	Wed, 23 Jul 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HtvqQXCB"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060528DB3;
	Wed, 23 Jul 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287053; cv=fail; b=fFowrAq9CgPzKr6LT6GlDniUkZ4jdR8Oc/fJugyvDtYBrpgWYZmKRfZPzI1+23FViLbPCe293gho8AA8h1ZECs/R9AjCxaidKfNnXewfWvZjfq2gThUuU+5emL+faHlySFc0lQMFunXRAkwr3qO6LfheXDrfT3Jq0eFhEekHk50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287053; c=relaxed/simple;
	bh=UF8oQ9BZ+UueSJcFa6rfcCeZgQLyISWi/8q/ofFY/10=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ewN1rzrAKRxdl6iEizLlv6r1eTR0FBSbX32fLThkj7ejgd4JbiyJZLVZeuKpbJaKOht4T7puthTJRt1BV9iPsMJ2N9sfIwnHlkNwU8WlRAiFB6j7tHQas9k4wtFqMcmaO/Sut/byNv5usUxFzAbTrf3G53v61cNbCjOFN0jhX0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HtvqQXCB; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbDcr75AfYkQ6tY/yxFIfED5ArV7jEjjalFeVtZcq21b6z78BCAaKKrAfC3NqzUZ8lYCduAVCFgbIKJwBCgFguqEhNbh1WqOVoyCcPNDyWc8mwI13t9JlpiV0Yd5oyfmV1gmV+Qt5ETpCv+d1B3L/yfVLwHCIypmPeMdgK8pRRgRktn2PaySZ/XxzXlLsuDaEqFCh/3gw65bCTCtdzhv0FdeAsHxcPE3TzfUt1iINfHJMeVvWwgJqC8aVix09lOkr43aKUT+XoXBJXVz2Dsm/geSzl8m2qi9M6Q/Z1MzR8Jz19bBh6n93MMs7AJyswChemq2TDLbMzXK5s0MwkwD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy9KD9BxnU0ryTx5aVXj+9gIJMoORQ2GmqHStYYReeU=;
 b=RYzSI0NLAp4um2eew1f04u4eFBih6ofg4pi2I0cormwRbYXox/VbKLXazdPQyAWVUviPgub7XNCo+i9aXwpP5S5bDcNxRK0zM/t2MpxJO1L69HehNLXD4S2mruuJyM92ddldYaxVf7C3te5ZbR/WX0J8cqTKhVUVpRlovbsqDD82/AJ3WQML+CBSHSI10ApP474HHDbq+U3K5ROHti5Hh7+LP6UHU/DUZRARI3x9CdtnpwDuA+YraUiJIFMhTEfYc6o5eQoQVNRGP5xUVwO2L06XdHMWBVmBME3CsUjjLwAm7GXgQSMVHKuAI9TbjHW4ZAO9LGwVAN4l9S+8EAf6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy9KD9BxnU0ryTx5aVXj+9gIJMoORQ2GmqHStYYReeU=;
 b=HtvqQXCBPPjN/jWMecJwNM5fxu1atxNCBabR1Qx0Qydcb8XKTeGYKQDgYkis2a8cKBJxi5mTLfIsq20Od9OW8Rd3CmcqKgDUjhr7sKTLaeWQ09/8HEHEDZK9G5NhLEd3H8gWNTFxxPH7LW18OjqO9RKxNn4HZIaUFHHqkX03DkBx5PlvGR0b6B/urKuFuE+Bn3KWbw1CQ5uO0KnxWfKML12bqP5xy+SI9h6zoGObEJFSt6Mh4JW5e6U7KLkIep7TrqqZWTO/wcjNeanBgZ0ZDlu1Mb33FUa4QDZhL8U0foIaa+mTtSOuSPekppi4sgbdePnUygR8hTViAef9Pn6l3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 16:10:48 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 16:10:48 +0000
Message-ID: <fa4fd174-065d-4a04-b080-ffe04d31313f@nvidia.com>
Date: Wed, 23 Jul 2025 12:10:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/4] srcu: Document __srcu_read_{,un}lock_fast()
 implicit RCU readers
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, bpf@vger.kernel.org
References: <ce304859-e258-45e7-b40f-b5cacc968eaf@paulmck-laptop>
 <9FAE52D6-D073-43D9-93D3-3E49006943B2@nvidia.com>
Content-Language: en-US
In-Reply-To: <9FAE52D6-D073-43D9-93D3-3E49006943B2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0609.namprd03.prod.outlook.com
 (2603:10b6:408:106::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7bf031-8975-4e62-f45a-08ddca037cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEsvYXlRdHNGcmE1VmdKNWdFZUtjUzNMNHBMV2EvaGFIeURkaHZFaGgrVlNN?=
 =?utf-8?B?MHlDNmp2ZVJhZUR4dHBFWlErNVd5WkhIOUZGRklzUDhrM08xQUJsRzNZbU9o?=
 =?utf-8?B?T21XdWpqSGtEVVY0UkVCU29ZK2krTnkyb3FoeUJwSWtCYjhrMzhwQ1FUWjFE?=
 =?utf-8?B?bHZ6L2ZwaUpiVEpYVEtuSjJraXhQNkFMSVpXVHNaUXhNTUprOGx1Zlp6OEdX?=
 =?utf-8?B?a3NMNkJQR3ZtL1dIc1dmNmlKdmFNd3ZXUE11Mi9RUXFZWGJBUXlacnYzSGQ3?=
 =?utf-8?B?cEx6dE5oNzN3YVZqakJ1VXBlY2ZmeXdpWUVhSDNIdXkyWnl5SitEdUY5Mld1?=
 =?utf-8?B?d2lYamRvaVdsNWxBeE56MHlKU0pWcCs4SXA0c2lwcnVHdU02WmtYaGhWa2sy?=
 =?utf-8?B?RG1LNlJySnFhYWZOUFB0K2FSYmd2cnF2bVJ3c2ZHTEdhc3R6YnlzL0NTNUhQ?=
 =?utf-8?B?YnpRWHZ2ZUZGTDNXcDNsbzNBRlExYk02MlVUQ1ViODBxZ3p5emxPNkw3Nmw0?=
 =?utf-8?B?cG1IdS9EM0hPTzVxMndQQmV3bFB1b05ORGx5ZS8vc01lYzI1b0cvWUY1M1px?=
 =?utf-8?B?bHd6QmdIWkg4d0crZWxGbXFOTkIwcW90TFlMZG9QYkxEMTZ0YmQ4OWxKblQy?=
 =?utf-8?B?REl0WXluY3dyTFE5OWViWm5RRDBDTlhWaUFxRkQ3SDFOLzJyb0tFSWxUT2pt?=
 =?utf-8?B?dmRmZGhlZnlUb0hOT0F5cDI5ZmJwd1BlVWFBS0JIWUdwbzdGd3BFTmdxKzRj?=
 =?utf-8?B?VnpDYmlXWFFwM2dZOWUvWDhRR3FSMnRTQi82L1dtTzhUMDNLMzdXTzNzTXk3?=
 =?utf-8?B?MVYwUzNENEcwdzRTK2JxeC9IQVB0MXIzNDRMR1FvQ3ZEUXZRWWVIdllvU3FF?=
 =?utf-8?B?eVVGbGhIVkRxL3A3QVA4M2lTdlg4eTRjWHJnVHFMcWJIUWlFSjlDcHZYRVIy?=
 =?utf-8?B?UWpsYnNoOTNJelI2UmxadGs0emFjUENGVW9zVjlITUJXVURLenE0YkhXb1p2?=
 =?utf-8?B?bEFsSVJyblhDSjlqUlpsYTR3WGkrUU5CWjQ0Y3M4VnFOeEthcStGczN3S2tF?=
 =?utf-8?B?KytYWldQUktRWmgxWkx3a0kyQVhXRUI0VlZzQUhQbzFVemFnT0xOWjg1bERU?=
 =?utf-8?B?SFNnaDlIT1FrL3FvS2ZVV29scjZvMURtdkkwZWdXeUNrNHhBT2dncmtURUNY?=
 =?utf-8?B?YUc3S3FEQ2pBNzhLcHhXQWp0a1Z0Y3NMMXROcmZQcHV4aXJ3YnVOREdoNnB2?=
 =?utf-8?B?UTd0NXhUUjJUMXA1VmRTcEhxRFh4eVFrWWNiZkswMWMvcEgwL0YvY2l6blZv?=
 =?utf-8?B?K2cvblpTMTZ6aEFnaGZyaDloVUVXY0JNY3NTTFhBc3N3dmdlM2xIUXRQRkhj?=
 =?utf-8?B?d1d1OTR2ZWVPMkcxQ2hKQ05OdUJMSTRRZzRiQThaY2dKdi9OU1JWeUg0NzJq?=
 =?utf-8?B?OUduNlBUUGs2bHlKcmQzTWJlNHhWSWtwdE0yeTIrOEZ2SVU0Wm5nMHZRU3ZS?=
 =?utf-8?B?N2tHTW5kNnJHRUFoQXh3eGxjc1pZbTVkR0VlWWhwV0dIM1cyMTBvL3NBNjY0?=
 =?utf-8?B?NDZrSlIwRzZtZjNmOXhqaUVWYjQxQlRONFQ5ZVYxbm9xZ0tDSXFSYkJxQnZJ?=
 =?utf-8?B?b25VVkt0UWZmUkoycis3ZDFLOUZGTHkxelhDRGNGdW5TTitscGtYbS94cGw0?=
 =?utf-8?B?NExKUExtN25SMVZqMUV2K0lneWoxblBwV0R1dnRhR3FJWldBZng0M1U0cUpK?=
 =?utf-8?B?QlNjVFJDVVJyMUQ0Qk5yazZOMGhvN2QyNVZCRzlmcEN2WmVJRzBrb2J6UlBP?=
 =?utf-8?B?QlNZZDRJRllBUCtTM3VwSi9JSkpQUWM2L2dvYzhibklUYmlxR2R6cjhZaThC?=
 =?utf-8?B?UmRHV09FRjk5aG5sZnpTRDBPZ2xOQVVYQmM1eGw5VzdhaVJ1ME9ZbnZBdWtR?=
 =?utf-8?Q?9Xu0c60j/70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUd5czE3ekZUc2ViMEg1SnFhWXQ2bTlBcisyYlEzbDU1SEFiZnFiY3RpSm9E?=
 =?utf-8?B?ZFpza1NtYWlETzBUekJ1SDZlRmdoQTdIbk1ZU2I2MXpFUDQ4a0kxbUhCakNo?=
 =?utf-8?B?NHpHVGp5STZSdXpPckNuRXlONlVVTTBUMVpnOU0rVUJhbVFnc20wSHdPQ2h5?=
 =?utf-8?B?UlhCVXJuYXk4LzgzQlh5YU9NUGtsYlEvNGo5L05lQ042NFMxUmJQbHVVMjFW?=
 =?utf-8?B?bmE3REJPTnladjlpUXVkK1NYN283aklZcnZpSC96SkR3YUMrdURqSmJOVUo2?=
 =?utf-8?B?dWpRVDg4aXpJODVXL2J5RU1Rc0VsVzVNUDdNazZmS1hCK2lUczZnWmVVNmo1?=
 =?utf-8?B?amtqSUtKWHhlWi83ZnZ1QXBHUlJaQ2RLMGF1bTUyN0pXWk5tK0xiNHl1Y2R3?=
 =?utf-8?B?a2pQdXMzQk1JaDNybXJWemsvdVk3aUJBSkdzdzM0Vkt6S1VhRTI5UFE1MVJ1?=
 =?utf-8?B?TjVQZ21YYlVjTDIvNVF4Q1RZODlnT2MzbS9KVVhraXVsSjVUcU4yNzhMVStJ?=
 =?utf-8?B?cWJsMkpRaE1WaXVrbzUrUm1aUnRtSWNQS0J0R1RuODVJYklMQWc3M3lVblhy?=
 =?utf-8?B?Zm5pT3VoR0R4bnpqek1SZlFJcE9UMEdmYjI5Q3VLaTIxbHYyRmhZV04vWVNW?=
 =?utf-8?B?SlFNbzJ3WVRLNkY1UHdCSlg5MFlqc2pBT2dVRkVicEdVS1BwN2pvT2w1WVBP?=
 =?utf-8?B?ZHFOZjRpM25IeFBqenBwWFZBSk5UZGZVSWlwaitpUitzeDFrTlVuN1hjSjhI?=
 =?utf-8?B?dXVMbUl5eDJIZG4wT1l3TGJ3SWVtQ2xrQ3lHNjNPam1rRWNYbVdneGdoN01B?=
 =?utf-8?B?TlpMcWtiTlorYlF0dzlZQUdKRDVtQ3ZQOHh1R3JrNUN4VGk5eXdCemdpbVJi?=
 =?utf-8?B?ZlkzWTJ5VE5xNXd4eWZLZ2R0SjVjYjFyRFQzOHBMcVJ5aW9rcmV4K1dmMVRp?=
 =?utf-8?B?eUlqMnB0VFVMWXFYVWl2cjEwUndYaC93MjZKTTg1bER2ZUo4V2JiUHlEYTl2?=
 =?utf-8?B?blVTYjhia0FwQ0t3czFkRlhFcWdHaHcwUnpJZm9aODdWK0pWYXRpTlRYZUI1?=
 =?utf-8?B?Y2xDNmx0c2xYRU9pbFhZNUp5c2NGaUsvY0RBc1NaTjJUUjBRVzBRaFZ4UmpC?=
 =?utf-8?B?dnhXRFROYW14UHNDOGt4QTk1U3I4YU1nejVJdk00VTR5MTltUnNxaFNKNkhE?=
 =?utf-8?B?bjczREJSMHNxN2pwczRGbitVK0tPMzdVUS82WGpCWnR5SHViZnFhYzZINTNV?=
 =?utf-8?B?TjJoaHhzOVVCZE81MDh5MzlveUVpREhxbFh1SVRjcTJxNmRKQkRlcDBjWjlL?=
 =?utf-8?B?VEhnMzBicTJYeTlXZW5ZQjZKK0ZkMi9lV0NDUUVOcmJLNGo1RDhDSHZPTi9t?=
 =?utf-8?B?TEpiRmQ4Yno5MkVWMnJPRDBEUFc0bHRFQkRuV1B3RE1tWWFvNGtwQVBJRXpZ?=
 =?utf-8?B?Zjl4WGE3d0c4RmVWV2U0aFNVak9QZWxSKzNBYkZFV3lNRWN4US90KzFGdWd4?=
 =?utf-8?B?Zkp0RVNYZVdWZWZKaU1ua09VTEtQU2p0eThLcStmWVFhOXgvWVJsRFNac0J6?=
 =?utf-8?B?eG9HOG9XS0pDNkpMd3VwMGdVd1pOS3Z3aTdPUjZ0ZS9aUlhMZHhQeVo3UW1O?=
 =?utf-8?B?emxQSlMxNlhUUlZnUmxtd2oxYlJZUkxEL0k4ZUZmMlk1YlV2ampJVldtWCt6?=
 =?utf-8?B?ZzhaNWllN0dZWDh1SXNCSi9JTFByUC8wc0dycGlZcjFFajQ5eHZjQzNXZVhV?=
 =?utf-8?B?M3ltd29wemJjWjcySnFsajBpNVllaS83Z1Vac0ZjVGhFRE5jcHMzSVhxbHdj?=
 =?utf-8?B?bnJJSk1QU3IvSU9kQ0xWSUJqdWdHU3M0MUZGdHJUbzBoUVZsc3dObStMeGIx?=
 =?utf-8?B?MUJkcDI3T2ZtVHlESitTb1RiM092azJDMmpHQWxkVjBHeU5pa3dyK3V4ZWtx?=
 =?utf-8?B?WVNHNUI2TG1KaWMwUkNScWduKzRQNkNncERWZngwcEdPNGRzNXB6T3FiZVhJ?=
 =?utf-8?B?YTZWQ1lLUjBKS3c3Vm1hQVo5V05CZWYxczZyQi9xZkdnL1czNzF1QUZwUUpW?=
 =?utf-8?B?cnphc0VPSHhnZVVLRTN3S2ZPYXJDZ0ZXUUUwTGR1TFFRNFJua3ZDNS9lTG5C?=
 =?utf-8?B?SUYzTFFtNnVYVGpCYnFrcjJFSmtuSGpNak9hV1FwcDc5d21laVVLTVF3TTZN?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7bf031-8975-4e62-f45a-08ddca037cb2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:10:48.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppZFAi+0TU7kdsxWiRdJ/EMwxLhRu3XEKOG+K+uKVSQiWmA7D73gz+wwouVyW4AQNaWguWDjEmuT0ht9q4DvZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675



On 7/23/2025 9:32 AM, joelagnelf@nvidia.com wrote:
> 
> 
>> On Jul 22, 2025, at 6:17 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> ﻿This commit documents the implicit RCU readers that are implied by the
>> this_cpu_inc() and atomic_long_inc() operations in __srcu_read_lock_fast()
>> and __srcu_read_unlock_fast().  While in the area, fix the documentation
>> of the memory pairing of atomic_long_inc() in __srcu_read_lock_fast().
> 
> Just to clarify, the implication here is since SRCU-fast uses synchronize_rcu on the update side, these operations result in blocking of classical RCU too. So simply using srcu fast is another way of achieving the previously used pre-empt-disabling in the use cases.

Hi Paul, it was nice sync'ing with you off-list. Following are my suggestions
and where I am coming from:

1. For someone who doesn't know SRCU-fast depends on synchronize_rcu (me after a
few beers :P), the word 'RCU' in the comment you added to this patch, might come
across as 'which RCU are we referring to - SRCU or classical RCU or some other'.
So I would call it 'classical RCU reader' in the comment.

2. It would be good to call out specifically that, the SRCU-fast critical
section is akin to a classical RCU reader, because of its implementation's
dependence on synchronize_rcu() to overcome the lack of read-side memory barriers.

3. I think since the potential size of these code comment suggestions, it may
make sense to provide a bigger comment suggesting these than providing them
inline as you did. And also calling out the tracing usecase in the comments for
additional usecase clarification.

I could provide a patch to do all this soon, as we discussed, as well (unless
you're Ok with making this change as well).

Thanks!

 - Joel




> 
> Or is the rationale for this something else?
> 
> I would probably spell this out more in a longer comment above the if/else, than modify the inline comments.
> 
> But I am probably misunderstood the whole thing. :-(
> 
> -Joel
> 
>>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: <bpf@vger.kernel.org>
>>
>> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
>> index 043b5a67ef71e..78e1a7b845ba9 100644
>> --- a/include/linux/srcutree.h
>> +++ b/include/linux/srcutree.h
>> @@ -245,9 +245,9 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
>>    struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
>>
>>    if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
>> -        this_cpu_inc(scp->srcu_locks.counter); /* Y */
>> +        this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
>>    else
>> -        atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
>> +        atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
>>    barrier(); /* Avoid leaking the critical section. */
>>    return scp;
>> }
>> @@ -271,9 +271,9 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
>> {
>>    barrier();  /* Avoid leaking the critical section. */
>>    if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
>> -        this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
>> +        this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
>>    else
>> -        atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
>> +        atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
>> }
>>
>> void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>>


