Return-Path: <bpf+bounces-74932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B283C689A1
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5183A353EBF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798F3112BB;
	Tue, 18 Nov 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MClTIkc9"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39F2D47F4;
	Tue, 18 Nov 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458710; cv=fail; b=BVMlJ1uyvsZhjf/LByryE2njaJKivCQbYJlxryV2IwsSIpZlQW+AZq/6fYPLu9cRMCvWjS0w4NvBCpBaIZwzTEVvdBvdwBUWfF8hlsNmHh6K/5az8VnfWNGHP/JxQYUca/BrFv8E/vZjdo82w0cctEOHziLP+Wz8PESsYScVZbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458710; c=relaxed/simple;
	bh=tvx11u9hwL++K9h7uqmAJ9pRd27sFp4V5vu1f2FtyrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDjU75XYv0U4yfSPQuPcigWgE5lHiBIzHzS1a1CCJQr/fa3giuhEe+6PGaxHbxBcPNd2kZ4jGCva8RAm5DGcF6lIfs1fU34Dxfr5XE1SywKHilIdppTablgdZQNGJUFgjLmZBfM8zWq5ZF2EqzyzhCrkz97MSI0YA0DqXUjwKoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MClTIkc9; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odEmMISJwFSe8pKJeX+d1VZYQErKtelprKaFUy9gEQQk+GEHkALRJzs2ERCjeMV6qWNZEIXMGMKazwifpbiZg4mF7xy6fWRx7Po0WNNLcXERL+LSvWtdxxFld/C/GJyHONXlF/2ndsDXaZAx6P/cQZ2Sq6ZrfZZzxulU0fUzucp4Buf2V6mQswO6fGW2cznjRtL1wIWT02OgFTn1cxd7dEGF42x5bFqr/4BfL8hZ/0mzHhGAbQsYRnAYvGiQ/YU4BWU9UU7zOC5YvGE3kxBVu4bHf/HuThJwLTyyTVC3j6igY6SZRfMmUcuRZAv7LW/KNu+EKMuOpUD4AhjjneurFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MI2iAwrElnp1q96TEtnhYfVP9ib8wGnaETgEsXHMqE=;
 b=qv80xNnhupHV8DRfoUl70J+QWA3a5TR1KSqlTwl8cyLxBc8C7OcVw9sFvB5ai+w2d+swUn5p7tfSJ8QCeY0yqvbFZCVQhA4vow3XOgdcQdd1bejMIO/ZzfoFhvejRpAf8lov6+di6MBJDENZCfkvIsghQ7vhA7rgavGePVIMBmPdlS/sMWUI8Ji6yajRhYtYBI2hkjY//YHzkb9QqqTBvjHAAs6SdtJE5Rj5abL7Xomin0hAXfiL6FPjWUNEjGYI6uEoo2MuFZ05+4Tztll79ev78j7J2OJfwPk0WnFHovznRdqXu0y6qzDx4g/X4d7h5KfCjySRp8R8OwPpEq0qXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MI2iAwrElnp1q96TEtnhYfVP9ib8wGnaETgEsXHMqE=;
 b=MClTIkc9ifi77h/em/OShRUsaHRSEiNVRLz8cvAPEV0de1ZA/waO7Vu9cza1MTFGRvhLCxHc5TYegk0MJoI39vgdWv2mUdm0nAqzrydLiVJWX+RFks8u1DVYB8DtLY1kJl1XmAgu94QTQVx7o+J56VFaMcgSDelC1+NradY8PZHPI20eL10ws4RPYGqiMe2etVSCICdCMs5de+BG/Q2cehBpExpl0vYx3aW9O+rAX5lU0BWeHytnufq7v2gB06ouhV6fjAXXEAB3Rqn4s7mPhJl2Zcergnn6TMFRfA7X1wdhfB6RbnhLRT013gXYIQgDal1ZHz4dnN5IYUIvKfagzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:38:22 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:38:22 +0000
Message-ID: <b62ba959-9c51-4eb7-ac4c-6abaa5935592@nvidia.com>
Date: Tue, 18 Nov 2025 11:38:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option to
 show operation attributes
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Nimrod Oren <noren@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
 <20251116192845.1693119-2-gal@nvidia.com> <m2seecmz4u.fsf@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <m2seecmz4u.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f170d4-6e35-4fb7-5a67-08de268636e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFdEbDBsWCt2K3dxWW5pblgyd2JidlpnNU9ISDVNSkMzOGdDZFV2amZVSFBp?=
 =?utf-8?B?LzUzWkJpaGhqWW80K09BR1VIUzIxYXp6dFdmZ2xPd3N3S2pHaUpFNDJIdjMw?=
 =?utf-8?B?TkFMZVpwVXN6NEd6T0dKbm5HdEtHV1R6TXpuYzVGb0lERnpIRmdFSDY4eVB0?=
 =?utf-8?B?N3ZaSVRDdUpsakpSUVFTTGFSU2UyVUQwbWZ2WEs1dWV2d0ZIWTA4WkxBa2I0?=
 =?utf-8?B?TlBSQ2poS2NlTktxYXc5TXBGYXoyUUtmMnhaWVpaWDN2ZTBFSytPN1hac2xR?=
 =?utf-8?B?djcreGR6SzZYRU5JUHhLaXpwd05FdFdrSGtBOHVaYUZFazRTUTNkejlQOVVH?=
 =?utf-8?B?L2d0dmZ5eFdLSmZ6ckRIdFU5K3BMcGdIaGMraHlXTlA5UmNrK3d3b2IzY0tB?=
 =?utf-8?B?dEd4NW9OWWM4aUcvam45NGk4azJ4OFF5Tk9Sa0IrNDVyaXRUaUZPOWdVL0J4?=
 =?utf-8?B?c0FMK0MycHZDcUUveDZWRlZuV3l6MnRBaHNJbnBsc1NQMjZoZmRHblhhQnBv?=
 =?utf-8?B?SzhBL2lSVGNKYXlZMEkrZFk1WVl2eStEOEFBMEx6UTg5aVBaZmdOUnROZHNF?=
 =?utf-8?B?RDQvenZzSitCVkxaRDRwSGhGWklDdVBCUFZCaEtxSjJCcThqek5xWDdCaFhP?=
 =?utf-8?B?ZCtSTklMb0hCUk5CQkVNN25zUzF5ZDJKdUZtM1VoYndTSm9qSGRlQ0lkVExB?=
 =?utf-8?B?dVdEWFNobEF3Wk53VFA5d0hjQzRlYnBWVGtRUnpWYjZZL0hPTUxIRkw5ckdQ?=
 =?utf-8?B?WEs4UWhvaWVVMWFGaCtkOGdNeHJzL0poYjdFMEZBeVZob0V6SHdGWUZOa0NG?=
 =?utf-8?B?ZHJxakZxVDRRcENOU0hwcFRlYkJTR3BVRW9Xc0NSb1dxSGFQSkFQWGpyN1JT?=
 =?utf-8?B?aUkxVm53NjV2S2dXK3BTSXU3K0RoS25Tb1Jud2ZaRnEvT05Hd1BobmJkU2pk?=
 =?utf-8?B?cTZVVHQxbUNVNHZ6MTFoRi9qd0IxOElrVXNFTWtGTGxGYnB2aHdFZWZkN3NE?=
 =?utf-8?B?emJMeDYyWEloc0lHbEZSaWlTQkdRd2xaWTlWcFBseDl3cnYwUXZsQTJ2S2hZ?=
 =?utf-8?B?ek5odmFjeFRtQjh6bWlOV1hyaUtGd0dtRDA4Nzltb0pZc3VpeFVoV3BmSWNv?=
 =?utf-8?B?V0FRTXVQREZIa2hTRWZtQ2lvaVdyWFRNV1BCaUpJTiswaGQ4WDhYV3JYUnY5?=
 =?utf-8?B?WWI2Q1QwV2xLTTJjWk96dnhia0FVYkJ1cFdSbGNYeitRWUh6RzBuMTdWN2ZY?=
 =?utf-8?B?Snk5MFNBVkFPUnk5K29qNjYxTVVKZkdXVlpXeWxaRGNmQUdFMmh6b21GRldI?=
 =?utf-8?B?RVQyMTd4dzZGY2xlVTNuWVdzaGQxWlkvQ2NCVmVPZDJ0aVVVRU9NRVBzZEhO?=
 =?utf-8?B?VG1DSkc2MXRzMGM4SEdDY0lhUUlhUjMxMGtVK2hjSlVaY1JDbEFlTndsdnQ0?=
 =?utf-8?B?bktWMDF1c29HWTAyUmdXa2svVmFua3hmN3QyUjA2eHFoQ3E1aWF6Y1dSZStG?=
 =?utf-8?B?TVhyVVVCbUJicUQrWHVuMFlCb3Yxa21seFhaSFZzQmxjWHNmWHlvbWJEOGdY?=
 =?utf-8?B?dnJwaXV6L01IM3RlR2lJbjN0SzJOaDdqdkEvKzdMNTZqSVpSTkJ1Wng3MzJu?=
 =?utf-8?B?VGxyM0lTM0QzY3E1aWpFRnBJanR2TlNSWjc3dzFXTlQ4VC9yNEYzTVVXZWlI?=
 =?utf-8?B?WUdGMlJFOVN2YkEwN1JDazJXREcrZjFiWDFZV1JpSlRuYThZbnphSmNFYmxh?=
 =?utf-8?B?Z1pFWUNPY3gvUVVyQzV1RTZTMlBGajZxdC9NWmhjbUdvREdCeTQwbGI1cStD?=
 =?utf-8?B?QlY0aVA3T0g2Q1RDZ2VnUGJNTmEzOE1GeFVSaVRUZzBzZFZtRVBzQk5DQnJO?=
 =?utf-8?B?UkRmZG1DR2VoNVJQK3FGMkVIcWtTUjh5VjNNUjR2UnEyMzdvbC9JTlZzckxm?=
 =?utf-8?Q?dZE700iCxSFr8whLeqQ/WDl77ogUVQCg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVpEZHFsS01Jb2tITXlzNXJTSnVkd2NwWncvZEtCeFNoV0U0VjZwekpFUXZ0?=
 =?utf-8?B?Y21yazl2eitvOHR3OUJtMFZNOXFaZjZVblpicnAvRmJnNGdjQ0hRQmo3b2Vo?=
 =?utf-8?B?Vy9xOTVyZ2ppR3IzSEVCZ3NhOFBxUHlNa3ZkcHJJemJVNFFYWnlkUjM2ZmRm?=
 =?utf-8?B?TjVDTDlvM1JSZzYrVkRlQWZnNm1YNGYzTS9zSnBQR3k3V1BFQ1FVMGU4NzJ6?=
 =?utf-8?B?NVJubWM5NkFCRURXaTNHcXJ3QVRBbnQ0and3N0JtTGFIYUJ2b3gvMVdMVWE0?=
 =?utf-8?B?b05kN2pldU5lcVZ4M2wwWGZ2QmlXMysrTjRGZllQMVpxZ2J6OUlmemwyenhH?=
 =?utf-8?B?aXZvYU01OHBJQkhtMXRaOEVzRkIrL0hJbHZJTHRnbFpVSFlSbTRIQUtzRTBa?=
 =?utf-8?B?STNRY2c3OGp3Q0xueHlxZmNlUDFFTk83RTFQNGRwVlhER0k0dWwwa01EVk1X?=
 =?utf-8?B?QlJqT3hCd2V6SnNabGJIb0NCLzNnc1dQazFjdW44SkxrTnNoeHNQWjQvbmpS?=
 =?utf-8?B?YWpXc3RlRmFsb0toUDZaZ0k1MktBck5SaElNNTlhMFNzcmw2UWlnZlYwK1l3?=
 =?utf-8?B?dkdQdTIxOG0rV01jTnR1bWVyeitueWNZUXNtQ3gzU2hUQTZZNUQ5dk51YXRy?=
 =?utf-8?B?WVhjMUw1dXBrZFBaODVJME1aK25aY2Y4S3NwamVvemtsM3R2ekZqU3JtWkVp?=
 =?utf-8?B?bzk3R216RXV0bGVTRkNHd29XVFJaR2pEeE5DOWdvaDNycTlXdy9lbDBFMXYr?=
 =?utf-8?B?WDlCcUh3WVd0RklaeUhac3RyZzV3L2xqT3duQVBmVTV2aEc1dWx1V3llRCtl?=
 =?utf-8?B?a3ptWlBmSkhYTk1aS3Y0azlyaHQydkpRckVuaStEOWpSYnN5R3hjRHU4YlNv?=
 =?utf-8?B?amRvQXZxSGs2TThERmVGdXZrV3kweDNXV1l2ZkdDWkZQaG04ZWNaeklDUm5p?=
 =?utf-8?B?YnFxSUNvNEhYQiswMUIxYnZpVVNKR3R0c2ZxRm14YkwzcG10NjVEejFSbXUv?=
 =?utf-8?B?OEpuTTVyVS8xYVBCZmh5WkN5M2hPN0lnaFR3ancrN1paWklXTndaT2dxdU9D?=
 =?utf-8?B?Mk8zbDcrSVJSeU5xSTNFYzhIMklrdlp4SFlhcjdlZDJTc0xUOFNnTVdqZHJS?=
 =?utf-8?B?eHFvQjYvUW9IKzJhSy9PZFFhVkVha3JVZUZPMWVoWHRjMHJkdlZLV1NqSWow?=
 =?utf-8?B?TUdrNHo4M1ZCWENyR1M1ajVSRWluWForNEtLYXpMRVlXTm1maGtVcm5wYTll?=
 =?utf-8?B?V3lzRTFnZXQxTkFPSWRXM0lJWUk4QTRoOVlzZS82VzRsUXVVQjcxd2sxaEt1?=
 =?utf-8?B?QzY3TXRtT3U0UUZMaDFZRCtQb09pQk9Mb0xIOUJueFIvT1lWQjh4b1NlV245?=
 =?utf-8?B?emxKdGdRTVVLMC91UHdEL0FIM3BoZlB1Tkl0ZDRMTkU5U0dES1d5c2pnWlJy?=
 =?utf-8?B?WVAxeWtBa1FPQnlKNGdXT3pKSTgyckpTL0grUjVxbHFWKzBMRVdJQndYcU5o?=
 =?utf-8?B?TWlYZGxodzFvK3E3QVE0OTdja210ampYREZIWUh5QXIwcWtVTWY2MTBjQk5B?=
 =?utf-8?B?MkhBY3JmZW1aRStpdm9UeGF4clRtb1FaRE8zck8zaE5BZHFHYit1ME1mY3gy?=
 =?utf-8?B?L09ETEFBZEphMjdWYXIrMVZjNEtSQUFhMmJPQnBxK2NvYUJWUXVwR2FHdUJt?=
 =?utf-8?B?akRKZTFmZ29SN1NsSmc2Q2dLL1JBMUFhc2s4LzM1cGlqOWEwMVlXa3FtL0pK?=
 =?utf-8?B?VDFLNXVHbGxrWHoxcTZyUmJTN28yN2NQVUpQa3ZFMFJiM2xZTjZEQ0drNTRr?=
 =?utf-8?B?Y0F4R2RjZDdsSWJ4QnRPZXU0NS9oaVZpbE5WbjgzQUt4UTVWNGYrVkphUDQ0?=
 =?utf-8?B?L1M0OEZ0YmppMGhTTHJlcTRuRlpBV3R3RlFHZUhUZnZSek9iSGpxL1BYaWpr?=
 =?utf-8?B?Y2VqQy8xQ0xBdU9GeEVCSHZMNzA3Y3QwaEh4bHBldEQ0VUFJLy9FUWNwVHBq?=
 =?utf-8?B?dmZpazU3OFFsV09taG5mTW44V0IvR1ZlS3N6VEE1YWxBei9aUzArRURGQTI3?=
 =?utf-8?B?Y3NQRnZZYnBycXVyVGpDeEI2ZFBBL2pYdERRR2Q1T2RKNG5QMVhUNXpuSlZU?=
 =?utf-8?Q?v/G07sxyPnWOPNFNvSz6C061v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f170d4-6e35-4fb7-5a67-08de268636e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:38:22.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXi/94j6kqfeZWEFuyX54WDIOjRh7aMXcFbQCoTEpZ5AmuJ12MZn8PBCIBjLxYtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On 17/11/2025 17:56, Donald Hunter wrote:
>> +    def print_attr_list(attr_names, attr_set):
>> +        """Print a list of attributes with their types and documentation."""
>> +        for attr_name in attr_names:
>> +            if attr_name in attr_set.attrs:
>> +                attr = attr_set.attrs[attr_name]
>> +                attr_info = f'  - {attr_name}: {attr.type}'
>> +                if 'enum' in attr.yaml:
>> +                    attr_info += f" (enum: {attr.yaml['enum']})"
>> +                if attr.yaml.get('doc'):
>> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
>> +                    attr_info += f"\n{doc_text}"
>> +                print(attr_info)
>> +            else:
>> +                print(f'  - {attr_name}')
> 
> Does this line execute? I think this scenario indicates a malformed
> spec that would fail codegen.

You're right, removed.

>> +    if args.list_attrs:
>> +        op = ynl.msgs.get(args.list_attrs)
>> +        if not op:
>> +            print(f'Operation {args.list_attrs} not found')
>> +            exit(1)
>> +
>> +        print(f'Operation: {op.name}')
>> +
>> +        for mode in ['do', 'dump', 'event']:
>> +            if mode in op.yaml:
>> +                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
>> +
>> +        if 'notify' in op.yaml:
>> +            mode_spec = op.yaml['notify']
>> +            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
>> +            if ref_spec:
>> +                print_mode_attrs(mode, ref_spec, op.attr_set, False)
> 
> I guess mode is set to 'event' after the for loop. I'd prefer to not
> see it used outside the loop, and just use literal 'event' here.

This is actually a bug, mode needs to be 'notify'.

