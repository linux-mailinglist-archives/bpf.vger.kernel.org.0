Return-Path: <bpf+bounces-50902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D194FA2DEC7
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA981885170
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38A1DF26B;
	Sun,  9 Feb 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NaqaQsbO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8716ABC6;
	Sun,  9 Feb 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739114582; cv=fail; b=TyxzKJLYIo4aHdwBkO8hYj+eqGxok80LdO0xcN/t2ozRIuN03U68nTnvnAEoeBrFWQ8A6TlYrOr0HVV1fO0PtjwMdb8DFyho4FqeU/cer8QnFzai6eKGxTh9Amxaj2mZGRMmSrfs0XfhA+NMEAimq+JSEbaCWwpB4SyNTAG7jEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739114582; c=relaxed/simple;
	bh=hGTSTRaKOIqz97G2rsSupcEFk/lE74yZRUKHJx29m28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrLb0VBy4jhAvCS86tbpjB40XReMEfMWwHDEAfKHuqfwmCkaOHnKt4X3f1K/ol56Uhp0wih+dq1kKbYTX5PIhhKhw/UhDFDjd7BK+hofST2xwokqeickeXSou0XWbFEDj/QsxDPIO1PuCxk/eGel6KYKbVpayZTNfyEioytImDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NaqaQsbO; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIU5MhhA3HMTdDfmvy1zBWjyGRKka6yUNRG39Btd6xZwfkmjXGfjLy3mIhhpjKxIZv/uJiuuhBgbnvMsTrwqEtW3UkctT45XVesTglqaopNlQU3H4XpKeD8Zkl1Rxn8ahksG2p1EhRvJjzTv+4isJ3s4zEHkF6zYIjija660BgkX/P2qki6rNayWllKslYowXlE11I4B6Rc/7CZ/ILJUG+LtM6O0pSlm9OULoCYbKYlxCVoGwTMVORuJrO6JmARRMN50mErSIg3QUSb7xGYo2MesDAT30+2ql29husY2dFv7SO4o5KXNkCAKOUjzPKhVqjdAhvo2BZH4Sa1oFxaxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mMMZZhvmFja/Oh9yNt7YcADmHd/ITk4Pfi/tvrEamE=;
 b=Nn+vHi3gchq9il0xxvE3yfM8jHuaX147KITPLfayvRYcx0hQF8y9ReeDSrDhv7VkHZK7gGsYTKU5xl8NuKzzWCaN0NfPbTkGBKcpBBBq+vax6QlrZn4iltibKXn2HZhfKM+4SJ3GPa6y3wUpk4EN2OrtNB+7zdlCXAKBPH1r+dBF07w+/0bXdaLg9YExjJo2afMaHR7eIffqT0WlJJh90wxxKWl8y0E0vN21tHScZJDl3T257F/kFc1sRj0kBLJkYz1+VJMYesRGbb2PQaG4ZkI534SyAyIk6HzTkkMWdqn/boCg0HNkQcmhqbNCOXxcOITZ76jmfsrcneueE5ajcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMMZZhvmFja/Oh9yNt7YcADmHd/ITk4Pfi/tvrEamE=;
 b=NaqaQsbOp7tKEbQuF5WbIzWMUlcT6bKuTz4lQwozqMeWAZK8k/j5rrnrY/FEdfc022cGxNUaWtpsxyw+v2PKkUNQQBmtqt+uGdpdRyPWrDlOuGrkL+M5vn7pVOAZw1AGapkgcqv5p3DX7RPeaOtYYnJ7Gy+Vvf6sX+guHf5x4gmZqNYpTJgaMmH4Uvo74St44iTUoOHcwLNhYQ1BddPxGLUAcD3E+DhEN1DOzxePhxMBO/DitIo63A5cCUTiDeBK89iutG6lXWSXUOP5rSYn96Hka+nlfOoPHIg7cRLCT+EIBKLduUNNb0xqUcK2iP3yZEVDuDHkLuknzbGNE4QLAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 15:22:56 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%6]) with mapi id 15.20.8422.011; Sun, 9 Feb 2025
 15:22:56 +0000
Date: Sun, 9 Feb 2025 16:22:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	changwoo@igalia.com, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for
 scx_kfunc_ids_unlocked
Message-ID: <Z6jIS91qpNYtvRXr@gpd3>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8fdcf6-a7b1-4e66-7595-08dd491da133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVA2dnNhVjJ4NFVkRTcxSnM0MGRHQnE5RE9jbWxBclVqQ3hUYkRiV2VHa01F?=
 =?utf-8?B?Y0Izc0E2RkVLczhRVWVQSDhiQ3UycHQrNjdrdFlUVjRERkNHTW9uRWkzVmF4?=
 =?utf-8?B?NTU2QkZLUjJLd2oza29hZ1pZS3NzeDY2d25WVUl2UDJKMldBNThRelBBeG9N?=
 =?utf-8?B?NFBmVXhJdE9EU29PakZ6clBYSmVDREtFOXNiSXhTY1RzSXIwWlNwQ3VCWDN0?=
 =?utf-8?B?cnFObVdjbHM1N25WTVJDUDBNbFR4VzVRVm1tNnowZC81QnpabWdNY2VnQjd3?=
 =?utf-8?B?blRUL3prWlJQZytVa0VEZm5MVTZYSTZ1dVJDMkR5VTVDaHNDTys0d3hCVHFP?=
 =?utf-8?B?N2tMSmtnM0NhNW5rcW5waDVjVTJTaGhwZGxwNEcyYVUydFBUYk1Bc3YrQ0Zw?=
 =?utf-8?B?dlJGOEpGRjlIT2ZyZFBXVjZ2RGZwMHdzUkVNbXlnZGdveXczOGF0YW9zcWta?=
 =?utf-8?B?VnJraTZDbVZLcWs1QzV4OURhOHI4M0ZYdHRMQ3hMNndZaWlER2U1MkwvdDhI?=
 =?utf-8?B?d2RuYlFMUXFheVRlcG9KU1F0TEpOeUtNVTVxNkxMaG5Ibnl3L1FRVjY4T3hq?=
 =?utf-8?B?U0tncmZUVEliNXg2UDN1MVE2OTdIbGdrSlR3blJwUEcrZ0R3dlFMK2p6aWIz?=
 =?utf-8?B?U2Q2UTZxYit4ZmJMTEhab05pQ1UwbEJKcG15WW4vOGhiNXVjNjkrVW84Skx1?=
 =?utf-8?B?TWlTalJCZGF1bnIvOG5vL2dxbmR3LzlZc0I5OTFURHg1bHlqdzdDZHowRWlI?=
 =?utf-8?B?K1JsbWlkcWU0S2VpL3J5bjZxeElPL2FnS0M3UHhEczJGVURrczk3d3dZYWll?=
 =?utf-8?B?M2R0NHNuQ2UzNFJoTzE3YnlrZFBpTllURS9QRDBRR2VCOTNSNDNsY0h6SHh3?=
 =?utf-8?B?YVJuVXhxcGpYRVpuSjFSMjFQOVV4NTJlbXR3TUR6UEsrdVpoT0haeXZDRnlr?=
 =?utf-8?B?RmFZaCtiTmN0RkpkNTBVTHJyQXlTNlNpTXh5WTZoK29KdkNZd0xHcjJWbnd3?=
 =?utf-8?B?b21ncmxnb29lYkdhaDQwOFhTT3pNOC9YaytvNUhONHE5SjZ5SkdXaUZYOVN3?=
 =?utf-8?B?UlVFQmRoSGNaclBRdGtQek1WRGtHRnF1dUQrY01ieEJUNitvdThYNW5rNmh6?=
 =?utf-8?B?OUxBaHJzODVjTVN2M0k3aS8wS1R0b2FqQnZ0YVlLSk9oMHBzTDdGMGJVQmlU?=
 =?utf-8?B?OCtzZkZLWjFTaHlPVTBNek1tR1FzZFMvbWdmWDBnbmwyZDRMd1FJak9hQi9J?=
 =?utf-8?B?YUZKYVY2S0JLd25TRTBINm5ZSkFYZlRlRyt0TENOZ2p6blFMQndkUmlPZHor?=
 =?utf-8?B?QlViTmFGMW91T3BHRXo2VFRqeVFVSWhqT3JGbDNPK21QMzlNcStzSklIdjR6?=
 =?utf-8?B?aEpXZE85L0NOYnowZzZJbHNLK094TDhzQmFhSTA2a2wwQkRQNTFOSkRnOU02?=
 =?utf-8?B?cjkveEVna3hPTk9hS3JsYi9HM3ByM0s0bUZPNC9FQ2tGTlI4TDFEOC92TE1F?=
 =?utf-8?B?M3pwK3cra253SDV6VXhLdEpqanNnWU9tdTBPbXl5eHlFSFVGWDZTUGlmOVEw?=
 =?utf-8?B?bmlndkVjbVF4OUlucHNFWkZSSGFCZXJtU2hERHp1NmhkUnhJZE5UL0JaMk5N?=
 =?utf-8?B?d3VERWNOYy9rL1ZIZkkxQlF6UjNQZlFqYUZBcGVlOTJNakJyOTdBTEhTOVhq?=
 =?utf-8?B?ZWVLd0lyU0hndnFPa1JYNFdxS0VsbDVsZlJkT0JPbFVxa3Z5RDNEd0R2LzFq?=
 =?utf-8?B?OGw4UlYzM2QwTTRTSnk0WTBQMWkzMFlvRzVpdXQ5b0V6YTJmcG9HWmliSnZo?=
 =?utf-8?B?L0ZHenhaSmE2aWZ0YnZwMkY1c0hybGhabHgzYnZPd3RycVNjM0VnYkJNZVBF?=
 =?utf-8?Q?fK8p3J5TZnCfQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmlvY1NVNkV1a0k4bmh5RDJUZm01WEVER0VQVXVnMFdsUHJwV3BZK21vV3Y2?=
 =?utf-8?B?V0Vzb2QyUkM4MGhvZTQzbERVMkdPSzM2a2NwL0ttYU9YK2d4RWZPQXpaZGd1?=
 =?utf-8?B?Qzl0RmVVaFFxanBUOFY2TVczY00xeitJYTZWaGN2T2tGVW1HbndVUkk4SHZO?=
 =?utf-8?B?ZmxaUFBLTVFhQzNuRlptN3hPUXROQlpEYnNwVzl3RmVBRTV1TWFmcUFnVDNP?=
 =?utf-8?B?R1Zhbkc1TW05aThUUXI5RnVObVdKR2RrNzlHUnE1NXoxSGtBZ0hGSmVGdlBr?=
 =?utf-8?B?NzI5ZmRtSEY1VzJnb0k1WFN5OHZ0MXhiNTVQWWNneWhieEJIUFBYRitGWVVF?=
 =?utf-8?B?cnR3ZWk5V1Zsb2Qxd1c4bUlXSyttRHVDbWk2MzQzdERBVEd2V05KQ1V5Nzlk?=
 =?utf-8?B?Mi94NjN6a3lPcVhtci9ZWGt2ZVc4QlBZdjg3VVNrVFNoYzczSk5ERGZnUXNO?=
 =?utf-8?B?VlRVVXZ4Q2xpeFlqUlo5T2VFMVdyTmNDbk9DN3NIL3NZMUt1UTdTVHc2N2hG?=
 =?utf-8?B?K0pndEE3LzNaYW8reEdtQlZhRTVtbU1TbGJLdk5SeXdsM002bUF4WW05VUJK?=
 =?utf-8?B?R01rem5NU0dFSGkrN3JFNkFBSWdPaHNSVStZWkZ6TUVtQmVnOERxVDVFOXd0?=
 =?utf-8?B?bFdSS00rOXU0YUx3djArZnNnNlRuTTYwTy9qN3JBU1VSSUxKU1QxeElKREMx?=
 =?utf-8?B?ZlJrZEROSVZ3RG5aMndGQmtWMzRUTDFRczJ3Uis4RnRpUy9VSjlhcjFHU0hr?=
 =?utf-8?B?ekxEaU1NYW9MZ044NlNWQjF1cHZObmhjZHRCM1FpbnJvZHhDQkR0VFpDMWhV?=
 =?utf-8?B?NDJJb0xDY1pObTBxMFZ0WEEyQ2h5QnlPR29HQllrRnlUZGk2SEhIWExzeTE1?=
 =?utf-8?B?Zml0VHl2VDQ3SXVjemRGT0F3ZkRBdm9wMFZ2cWE4QlFaZUg3SS9qWDNJT1JS?=
 =?utf-8?B?bExRR1FqNkFscFpQb1BCNlpmZWIwcWtBeHVML283ZWZDZi9KckVXdjFVNTlp?=
 =?utf-8?B?MUV1U1dYMmZlenFKYnoyaWgwQlozSGpPKzZaSmNodEprVE1zdGlzdTRlL1dl?=
 =?utf-8?B?QU55RXJEUG9zWkFlRG1iK2ZHT3FSck55djhWeWJIdmsyVXVBOFl3czN4ZXpS?=
 =?utf-8?B?NHM2cGJ6UURaRjY5TURMUGJ3bjZueU1GVnRGbnJUbFR1SVhzTFVqbHY1U1ZP?=
 =?utf-8?B?TGQzZ2k5b0RVTENwOHlqZExZSGtYRTNHREg5LzI3OTJPTGlkelNkTGZUdjFJ?=
 =?utf-8?B?Zk5aTnVISGxWTDFUV1ozbzRjVXNnbDNjOEpnaDhhcERGZ2dCVzUyNXR4VzZR?=
 =?utf-8?B?OTQ5OUtIU3czZll5dEUyandSekZjS2hGVzI3S1duY1BYSUhXWlJnQ1Q4WkNS?=
 =?utf-8?B?WGVYSlI4WkFLY0FkMkRjSmpaT29vTFkreUw0M1hqbGVYWVBJaUh1alVZTXNP?=
 =?utf-8?B?UE5Kc0VzUmxXWFMvVmdJSmxuenY2Vkw2T1FpczIwWmtTeG8rY1VKWnJndDlo?=
 =?utf-8?B?aFR4ZlprOXp1dDAvTW1TN1JZaCtGRVhBdVhpUHl3dXM1UnRqVjJxWmV2VXR4?=
 =?utf-8?B?WGloWnJwbSs3WDd3cGVwVDZxbHI5em03Z0VwdkNCY0dWTUVUY0RScng0STBj?=
 =?utf-8?B?Mzc2VXlHVU5vd1JKUnhsSWxjNFhnYWVTL0ZzMWh5RUdCaC9GS2I3Vy9ScG9k?=
 =?utf-8?B?enM5OHpEWXBMeU1aeWE5TkN6YktYNTlWM0RuNjN4ZDBOdE5kM3NZMnRKaHND?=
 =?utf-8?B?QXp0Mm5odnNkb0x1Ump5SW11TnRTaUJ3TTVSUTZ4ZXZkNW5GVFJVQ3NlTkc4?=
 =?utf-8?B?c2VTR3BOUkc1NE0vYXZ2RHVPeEMzZFlWWDM0YXcxOWZaUUkyWnQvV3hHUDBz?=
 =?utf-8?B?SnZObk02UmgvcTVnNHlOVjlqOStVQ0xXb3ozU0Nsc2VpajNLejBaVVVKS0Uy?=
 =?utf-8?B?M2tTMklmaSt2Sks2Um9Za3ZUUy83ZUQydEd6Q2p3VFhiSXVZb3dsS0duaTEx?=
 =?utf-8?B?ekxMTlB6Y093YXcxRGx0Y1I2a0p5ZC9RRUNYbWttMzVteW90anMxQlhKY0F1?=
 =?utf-8?B?eFVCNmhZQ3lwMzBLcktRMnVrT0UzTXJrSzhTUk4yWjNUNjVJNUNnenRNdytw?=
 =?utf-8?Q?ZcsvimItjtwPFpw9j8wfiz1SS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8fdcf6-a7b1-4e66-7595-08dd491da133
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 15:22:56.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUXhxTbt93R8j/DtwjeJlIp1vtm3++dGZzNl8BaY2DdGVkrVi9eT9IK0iyI6FIrX7hKAZ3E2vKSXavxkX203cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

On Fri, Feb 07, 2025 at 07:37:51PM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 5, 2025 at 11:35 AM Juntong Deng <juntong.deng@outlook.com> wrote:
> >
> > This patch adds filter for scx_kfunc_ids_unlocked.
> >
> > The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit,
> > cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
> > cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
> > operations.
> >
> > Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> > ---
> >  kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 7f039a32f137..955fb0f5fc5e 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
> >  BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
> >
> > +static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +{
> > +       u32 moff;
> > +
> > +       if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
> > +           prog->aux->st_ops != &bpf_sched_ext_ops)
> > +               return 0;
> > +
> > +       moff = prog->aux->attach_st_ops_member_off;
> > +       if (moff == offsetof(struct sched_ext_ops, init) ||
> > +           moff == offsetof(struct sched_ext_ops, exit) ||
> > +           moff == offsetof(struct sched_ext_ops, cpu_online) ||
> > +           moff == offsetof(struct sched_ext_ops, cpu_offline) ||
> > +           moff == offsetof(struct sched_ext_ops, init_task) ||
> > +           moff == offsetof(struct sched_ext_ops, dump))
> > +               return 0;
> > +
> > +#ifdef CONFIG_EXT_GROUP_SCHED
> > +       if (moff == offsetof(struct sched_ext_ops, cgroup_init) ||
> > +           moff == offsetof(struct sched_ext_ops, cgroup_exit) ||
> > +           moff == offsetof(struct sched_ext_ops, cgroup_prep_move) ||
> > +           moff == offsetof(struct sched_ext_ops, cgroup_cancel_move) ||
> > +           moff == offsetof(struct sched_ext_ops, cgroup_move) ||
> > +           moff == offsetof(struct sched_ext_ops, cgroup_set_weight))
> > +               return 0;
> > +#endif
> > +       return -EACCES;
> > +}
> > +
> >  static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
> >         .owner                  = THIS_MODULE,
> >         .set                    = &scx_kfunc_ids_unlocked,
> > +       .filter                 = scx_kfunc_ids_unlocked_filter,
> >  };
> 
> why does sched-ext use so many id_set-s ?
> 
>         if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                              &scx_kfunc_set_select_cpu)) ||
>             (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> 
> &scx_kfunc_set_enqueue_dispatch)) ||
>             (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                              &scx_kfunc_set_dispatch)) ||
>             (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                              &scx_kfunc_set_cpu_release)) ||
>             (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                              &scx_kfunc_set_unlocked)) ||
> 
> Can they all be rolled into one id_set then
> the patches 2-6 will be collapsed into one patch and
> one filter callback that will describe allowed hook/kfunc combinations?

I think the idea was to group them in different sets based on their context
usage, like scx_kfunc_set_select_cpu kfuncs can be used only from
ops.select_cpu(), scx_kfunc_set_dispatch kfuncs can be used only from
ops.dispatch(), etc.

However, since the actual context enforcement is done by scx_kf_allowed(),
it seems that we could have just 3 sets to classify the kfuncs based by
their prog type:
 1) BPF_PROG_TYPE_STRUCT_OPS
 2) BPF_PROG_TYPE_STRUCT_OPS + BPF_PROG_TYPE_SYSCALL
 3) BPF_PROG_TYPE_STRUCT_OPS + BPF_PROG_TYPE_SYSCALL + BPF_PROG_TYPE_TRACING

-Andrea

