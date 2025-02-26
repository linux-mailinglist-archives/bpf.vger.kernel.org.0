Return-Path: <bpf+bounces-52647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE0A4637D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969723B45F1
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D3222578;
	Wed, 26 Feb 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+y+gm00"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99721221F39;
	Wed, 26 Feb 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581213; cv=fail; b=qZiHjLqiXsRxZaM4HrI7rc9xb4kSwnu2Il8d1FHqrWMTkx3iGNMgSfJg399ZMhhhlVbziz5EzvnGXevNZ8ACHCIV8EHC7bIMjdpQegAc27WrkQwM2Mz8noa+vt29pMu9iaIEttQ0pX8Uw7eR94pxlAsRcIEa4JHYHB+/mNY/M4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581213; c=relaxed/simple;
	bh=HPeRHMlzHwi7ULCpQR5jJpXtwULX4U1c2S8RBiFq1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJljkf65KmBhFvu+mvlyB2tKqtY6ul0pMT2rIkWsfvLtfmaxlp6S7yTKfsxi6wrozeom0tvELBA55gmSIo4RvRlUO7UknkMdCUtiHm/O90WivNn5bEu2Vo3EXfSfKR2CC0yAfT9Py71F/G2UHPn4nbuqdkUsl9Kv3XZVAIl/su4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+y+gm00; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2QSXKNIUoiQk0FfntnvZQPh+DE9k6PIfTcKH4dLppWtzS62AI182ytxzzhd55l94mx5BsBEN3YC7+WYgyRwSK3jWXGqM8NVGqPnHhRP0b6jeoA/Gh4TGUq8L7RiLHxzldjV89HeybLcNcolh9Qz81xJq2o5eE2CqKIuYbM0cpGxCb1JtNM+o/fuhlt62LNB5mX4tQC4pAfK719BPwDjXMqUmMVJH5Pnqg8ucWnsOQSuak4x+GXQ+DM6Q6sUg1HaRPfMFIvmKKuhUSOYjx0M+q5lxeie7O5DYxwPzAgT/xaqIzDCa6R4y6KlyG5JOFGO0c6ixQjTDfBNQiu8Hbj1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUa4cWb/IQGGmpr56nXsle6IjQ6UJa3uu+335S2cg0s=;
 b=EiDoXQeHjKDEGTrfpO7aBeKWKvRG/GttVw3HnCei8qlMBHAVD5zv0w2+4Y7z1PJJwIpzx9du47Grc7jiXawFLopAa0EgGw1ZS3YkibRpag/tihyaQV8uxh1oD8eOwYfePX5uKg2SpiZuggarPVJI+HWx5y1CWZAsvaD5Sid77hFDEx5bAiwiVwDsVORDSQLhCooCRAKqbddZ0NFEzbh+IdCx3c/MEWNsnLHRXDJEVIhMFSWkS8C1dOjCtRZ1/CZzOk+xG/goPjSPPenXLpBIab3dFdX21fjhnbFw/RuTqXBfhVfUoi2tL2v38Xlxp6oh721r1stj5ZrTwWTMU9S/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUa4cWb/IQGGmpr56nXsle6IjQ6UJa3uu+335S2cg0s=;
 b=s+y+gm00vRtEKuIuK3FXi2NSCoolnkUPKC4kf24Q9xP7cIIWuIwDDLfq5IVPR10XgcvR1tjRogbKKumDQVdVpmuqcUtrbrgnMD8i0IOBaKg7wTip9pqPJpO1cjqyf9tfdcL1x0Xo298WOk+LbLZSNwlGjMM3nFQHVDYoswjE+Fzj8QWkffnWxTyOQwMHOrvjLZQL9SVJZGOl56ArBIFbLS59ngN+E+V4VdsgctHF5yccpe1mvEU1zjnNcBH20Y77P0mz0i2mpdWh5MnaYNh8Hwht/TzD8tT4U3uVXTBMRJHThUHLVuKbFxQgy8W6JUf0CiZfom2RvWB3tp6wUC0xiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 14:46:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:46:48 +0000
Date: Wed, 26 Feb 2025 15:46:44 +0100
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
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v2 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context for unified filtering of context-sensitive SCX
 kfuncs
Message-ID: <Z78pVPKTEIh-utFE@gpd3>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080D59AD7DD5B59E1FB14E599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQKnJCdW5OCs338W4ts_mn6JVw7fD5U6w5o6dtc4DSJQrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKnJCdW5OCs338W4ts_mn6JVw7fD5U6w5o6dtc4DSJQrA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::32) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 38244d4c-85a0-439b-5ecf-08dd567465cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnJHRmFqaWpiREFub3cyVHJrMGw5emsraFlHZ3V3NFVTaHI4bFpTb1Ywczhq?=
 =?utf-8?B?MXNUS2xOb0FvYjBMYVJlQmUrTlkzS3A1WjF2ZzlIcWk5VGdaMURoQ2ZHcW1K?=
 =?utf-8?B?UStJVjNPcktzdzQvc1EwRlJCaWZDR3NuK3JvTkNFSGw2ajdObWN0SW9XMEpH?=
 =?utf-8?B?K3V6V282NWdQaGxTdGZKaXZvSWlZTzFoMUgxRkt2YjFGV2FVTjhyVTNIYyt2?=
 =?utf-8?B?QkQ2ZE1Nd29wY2xSbEp0RmMxb2RWdjRpNWVOM0llc2p5T2ZGbmEzK2JId0xq?=
 =?utf-8?B?azFTUUd1OUI3YzRRM0RTN3VJeDlvYkV0c25hZ0dLZ3F4Y2JLbThwVUFyV2N1?=
 =?utf-8?B?TkNTQTBIUGs3YUd6NFBXd3FrVURORWx0Q1FIM3VzQ2RCazFIZ1JqbDhQaGNG?=
 =?utf-8?B?KzRaU210ODBua2pRaWhOdTB4aUVXVTEzZWlielJlRXhCamVzSElNMlZkSVRQ?=
 =?utf-8?B?TGt5ODBPdkNPMmhZWnllNWpHUE9YSlJqYlBJQUtsakxwcGVlNDhXTG41aXVy?=
 =?utf-8?B?elpqT1hVR0U0NzU4VThSOU00dDF0REUwSjhwU1k1WVJPb0Vzb2dsVHlPbU9o?=
 =?utf-8?B?WjdqODZMRG9WZXc5dC9peGJXT2hSWENoWjBLL1dMdEdTNklEd0JKQm5QQTJX?=
 =?utf-8?B?V3l0MklZMFV1Ump6N1pqY0pLUDZKL0xaUUdoL2oya0JCUy9heGNpRnZFRlZy?=
 =?utf-8?B?c0R0c1pndTBIRGQrdHNjdlRjNEdVcC84allBTTZieDUrc0lSdnpWQWRCV3pF?=
 =?utf-8?B?U3VOcUs4LzFlV21YbFIyWDBmamI4Nms0ZVJTT3BGOTBIU2lBaXFuVk9TTHJI?=
 =?utf-8?B?TzNWbkpaRXNBcUVPU1dxem1NSEpLa1VWMHB2eEEyRHZ3ZEVPakhQNXI1M3hR?=
 =?utf-8?B?Sk9LYlZHbFFGK29NVjZ3VzkwTlFqcVlxRVRtT0VHdVFJOTFDaTNKMDlUTUVk?=
 =?utf-8?B?T3A4TWVPZEJZQVFCSFZaeXBWNWxObXYyeXNKa25vcnpxUjRVYjhqaHozT3Vi?=
 =?utf-8?B?UHFEK1RDMG9tMVFicEJBY2FNQVlkRnhQdk5QNkZQRlVWU3dBNEZRbzcvejYr?=
 =?utf-8?B?YUtpM1RhRTJpZ3orT0xqZzVhdmlRRmxncVV6VWp2Q1RFeEp5OWZuY0g0dHZN?=
 =?utf-8?B?YW8zWHpBRHZZdHhFeFIzcWdXRGNubEhHZ2hLMEtUQkdLN0FiQjk1bldxVmVZ?=
 =?utf-8?B?VnZzVUh4bzRyYzMrWVFzZHkxQ0lQWkVKcVRqc0xzUTBacWliby8xdXJrbzBM?=
 =?utf-8?B?bjFMRkdCb2oyNU1TekVvQngwMzQyQVJ2STVQN2lCTWJOWlZSMHpwandTdG1l?=
 =?utf-8?B?eUJaSTdYOUVMZGd1Nk0xZEZUMHZLRlRPV291dHNZUkZFL05OM1NMZm5HcEJP?=
 =?utf-8?B?TG8zMEh6Z015bW4ra0FDNUFUWmxMRVFwbXZ5U0ZEMWExQ3pKaCttck9SZG50?=
 =?utf-8?B?SElGYko4c1hWbFoyWnlHdFgzd3JaUVVqbFVpOHJqT09QVndGNGJKdHVHV204?=
 =?utf-8?B?NTQyc1ZNQjlpaWhuODA0LzZpUXZVTFFiTFRvYzRzK29jZzl5cTF2K3VYK0hE?=
 =?utf-8?B?SUVKNTJHZUY1anM3czdZd05Gd3d6NFZaeGRMZEpWeGtva1h4UmJWVkN1L1RB?=
 =?utf-8?B?V0pXMUVmUTFra2E5TU9EWmlHN2ZKV1JJZlFpSXV1bThuWnQ3RFhCK09KajBK?=
 =?utf-8?B?NkgvdVNiUWdLM1pKa2VBSTZmV1JtdkJ3dkFXbmxJLzlTR1JCM3Z5Y2kraGZl?=
 =?utf-8?B?UXVwa3A0VzBYd2h5eXI3MWs0SmdlTDBjdG5FcVN2WmZhaW8vcE03eTYvRUhr?=
 =?utf-8?B?M3dFYnZXZFl4NTlxWDZtb1dEanJkKzVBYlE1YWtZNnU2ejFPbk91RlJWeFpW?=
 =?utf-8?Q?6estemo+6W3ad?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTNlQUlsVHk5OWVpMGQreFdSaFJoeXNKRm02VzdZc00zd3UxTnJoRTV6L1Y1?=
 =?utf-8?B?TjAxUHNtUEpyT055Z2M3WE9KVTlucUQvMUlibmdLeUVzNnJnWXZlL29KSzZ0?=
 =?utf-8?B?dXIzajhCd3J0d2tYWjljSDE5Q1JQTE5PaUNJTWNTczRvM3M0YU5FTGhPV29z?=
 =?utf-8?B?dm9iUjZwcVh3Q3VsYS9PRlMyenF0WUJFa05RS0JPS2FHcTZ4YThSRWlBU2F6?=
 =?utf-8?B?YjEvU2hETlNGQlVuTXMwQ2ZtWmNvZlE2bGNxSjJidEozdFJxY25aSGRiSlFl?=
 =?utf-8?B?dE1KN0loY045Um96Y1Y3Q0E5ZU0vVE1jNmZNUStLQmltUzZEbm5vTVExcTEw?=
 =?utf-8?B?V21ORDhnZlVPQXBsK25RUjUzNmNZV0VJc0R6VS9iWHdCeldQQ0lDRi9sdGFY?=
 =?utf-8?B?SEpoWnNMR215NFZUR0kvdXZBM2duNy9qTGJEbVVId3dobmtXckpqYk1CVVBp?=
 =?utf-8?B?RUY1TnBNbFNQTW9ETnErM1VYdm44VE55MUlRYjduR2s4T1lKSTFrVnI1Q2ww?=
 =?utf-8?B?VDJzOWZuZmxkT2JIZlptS081N2JaNW5wYUYzZEZ3MnlyTzRuWVhzYU9iNVlv?=
 =?utf-8?B?bHM3TU1yMkZKU3pWaXNQbWk1WERLU0JlbWVaV1F5UG1iSzhaenQzTk9IQ201?=
 =?utf-8?B?TnE5M2JvRUJCbExJcURBWittcENxemhPc0JNd2FKR3NzeFVCMTZCc2o0TGtE?=
 =?utf-8?B?OEhnbnVnMDcwMVF5QXprc0lUUlgvdXVyb29HRHlOUFA5YW9VYjRJUkhnZFBw?=
 =?utf-8?B?MUFLVk5CVlhacnVuaCs2TlNxeER3SmVhdkJLcFA1c0hBWVBLMjZsQ3NJOEsx?=
 =?utf-8?B?VlYrZGwyOXJGUFI5bzYveisxRTY0RitTZFhBTGFrZ1hyTE8xVTlDeEFYVHlG?=
 =?utf-8?B?blJMd0pOMEMxZ2svY1BkdFRuUDl4WHRDaW5YM2lEelR1UUthaFpWRTVJNkdF?=
 =?utf-8?B?ZWliMy9DZGhQY0RWRkc3eGlpWmhDWlYxQW1XbkdxVFc5SjBKT1E3NzIxaThk?=
 =?utf-8?B?VnVEd05wNkdxMmFsUHQ5MTBrU3FTa2tHNCs3VEtMTDkrazNUM1hvd1piYmUx?=
 =?utf-8?B?K21KL2dNYUlZelpoRmJlWkFQUXY0cXlGNEZvQUJWQzdhZlFXeUpaSTlwNzFN?=
 =?utf-8?B?QWp5T2FDSDhJNlRzckFoeE9ZUWdZeEZDL2U0RTFNUndGWDJSamRQanhINGZT?=
 =?utf-8?B?OTlXVlJTeUc3cGtXajNIQzR2Um1wMXVJbjVwdzZZNGJvam1naUQyWWtHNnBG?=
 =?utf-8?B?WDEvN3B1WjBRWEhRYitFbitvbW1jTVJsLyt2WGRsRm9qZEhZS3cvUk5vM0Ry?=
 =?utf-8?B?Q1l0Y3YyaDVKd2YwdlFRZFU3dFF2MmpDWTYzamo2aStBSy9Ga3lXbk1GdmR4?=
 =?utf-8?B?cDVKcTRNV0h3bFVxZTY0WjBJODFNVFpjMU5SYXVBU1VXWG00Z1VHeC9Ycm5W?=
 =?utf-8?B?Si9RS0pzbmdHZXZmbDE3Y0RpTUhTMUY2a1pxSnZrUVdrVjJNUXN2aEZIZ09p?=
 =?utf-8?B?TFZwNUo5cXh3RW5DV3hDN3VzVStIdnhURFhOcHI3RDBXcGZLT0ZkMUtuREg1?=
 =?utf-8?B?bDhuVXovK1BkL2hUemtvS0hmc1JVSFowRUMxZFNoSGNnMW1nQU0xbm1ZZC91?=
 =?utf-8?B?OFMva0FwaGRkQmRIcFJ5aHBpUzFtVHIraEZ4QzhlNlY1S0N6NkwrcjJWaGNu?=
 =?utf-8?B?UDVFUWl2NmdYejB4M24vUzJYYjlDNDFoZE9EVDE5cWl3RyszY2Q4Y2xSYnpU?=
 =?utf-8?B?c1hzNTMzL1U1STNmWVlWam43cFpjdVNyNlVOUjNsYnA3REcyS0FOdlN2S0kx?=
 =?utf-8?B?WjY5MG9DNDdlNzN5SDlWQ2NUSFZrWjNuSHhnYjJ0bnA3SDNTWWFkL25UQW9W?=
 =?utf-8?B?WDBIOTZPeEdNa2hCZXZYOFFrdEQ5bkhwNlBwSmxoYzVPVyszcStiaWhUOUth?=
 =?utf-8?B?bnVLb2FCNlcxUGRJOXdPM2hQNUt4Q1dSTTQ0ZGsxZm5YL0QzSHBLeDR3ZzZK?=
 =?utf-8?B?QU9TMnBnWlpHcWh3cmYzTEw0N3VLSHZYYm5OVzROSnk1d3JYZENmTzJYNFhh?=
 =?utf-8?B?VnRBZ3NISUV2RmZ4cnpERDFTQzEvSHBubUxSN2F3NEQ5dnBTeGJmRXVzMUtt?=
 =?utf-8?Q?jecOt956HcXP+XZDYReVJJcL2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38244d4c-85a0-439b-5ecf-08dd567465cd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:46:48.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02/r0POHMB7zA6A/WXRiQBT55yZI+PbRiP+u6GFnRcQRw1bCgr+Y2sCBv5od3pWSj1jxhaWZpCRbcfiYkPFCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

On Tue, Feb 25, 2025 at 09:24:27PM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 14, 2025 at 12:13 PM Juntong Deng <juntong.deng@outlook.com> wrote:
> > +static int scx_kfunc_ids_ops_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +{
> > +       u32 moff, flags;
> > +
> > +       if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context, kfunc_id))
> > +               return 0;
> > +
> > +       if (prog->type == BPF_PROG_TYPE_SYSCALL &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> > +               return 0;
> > +
> > +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> > +           prog->aux->st_ops != &bpf_sched_ext_ops)
> > +               return 0;
> > +
> > +       /* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
> > +
> > +       moff = prog->aux->attach_st_ops_member_off;
> > +       flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
> > +
> > +       if ((flags & SCX_OPS_KF_UNLOCKED) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> > +               return 0;
> > +
> > +       if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
> > +               return 0;
> > +
> > +       if ((flags & SCX_OPS_KF_DISPATCH) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
> > +               return 0;
> > +
> > +       if ((flags & SCX_OPS_KF_ENQUEUE) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
> > +               return 0;
> > +
> > +       if ((flags & SCX_OPS_KF_SELECT_CPU) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
> > +               return 0;
> > +
> > +       return -EACCES;
> > +}
> 
> This looks great.
> Very good cleanup and run-time speed up.
> Please resend without RFC tag, so sched-ext folks can review.
> 
> From bpf pov, pls add my Ack to patch 1 when you respin.
> The set can probably target sched-ext tree too.

Thanks for this work Juntong! I'll do a more detailed review later (with
this one or the next patch set without the RFC).

Just a heads up, if you decide to target the sched-ext tree, you may want
to consider sched_ext/for-6.15, since we moved some code around (no big
changes, but some functions are now in ext_idle.c):
https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/?h=for-6.15

Thanks!
-Andrea

