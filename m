Return-Path: <bpf+bounces-68395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6ACB57EE1
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE31A216BE
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C1326D54;
	Mon, 15 Sep 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JJFViHAw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5F30B507;
	Mon, 15 Sep 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946349; cv=fail; b=BwwCosJRGYZi3ZRsxHx3vEuN4dk+ItUY/ZoCCnlRJSw/Hgm3tN1toEkFpbuwfMBzrQXT4DSxy4TttPK0bPtfonAc4AAT6LQnxC2j3ZOXkwbkjL2ns09XuHwU/em6eqv9wqIDfWHYA9GQek/kDmrWf6xPsQFWXlFesdBGDX7g+TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946349; c=relaxed/simple;
	bh=CyrFeU54R0G8R2Ffo13f0I8XDCczVqaLdxL8XjNdBmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=da8dz5VaigowmnJbkth5FPF34X4Ofdvh8ACmiNeLTPGNYTj1Nb6h/vOZeL8/26kejyay+4EosByOATx2xWvFrgV3dPUatgnTEFhwtBqPOM9LY4vdt3+LGUctIQHC6RzsFOidWUaWnd9BnvYyD0EN6IzxvYDENAEb7aEB6fK7JjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JJFViHAw; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 58FEMbk11798455;
	Mon, 15 Sep 2025 07:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=1TA+HHs0j3FrQARs9c/EKVAFbtwHyeMU9SeIgMe4Xy4=; b=JJFViHAwJFd5
	5nrhj8ou3hA18W55woxjfInTvWWGUNsdev19Ci8pf55A5HGYVaT33umXSZSCuR6s
	DGqtmD71fZP4MhjgmJ1yNeg+YOVmjQ0Wg9iAYb6QQYfBiTTxVjzqaw9gL0F4eafl
	fDdhwoS8JDMObdqoWQQoORWSfGFVXqhJlXQDM0ibQKViiYh/MOhxFeVOXNTAWTp4
	LWTmJKFPFO17EGKYYsmDtfuRmZmqnO8QcfXKdmUvIYsKuFkKqDgP3qvOEqNo0WFj
	XhebTUsr/K5cRaatMpP0XaUWZ/fQMAMgrh/B8BzBxuTEJSleaULksuQuZLXv9sge
	uWL/BP0uag==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by m0001303.ppops.net (PPS) with ESMTPS id 496mgtr0p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 07:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYeR/OZR/OapTIXn7UxWJnr78rGkwnxwZuW+r62auLA81MuYCw7tAkVMnjin7/6kbYKNVjzcleDjei9fzz2fNEjBgPun2E02RrdL5Y8YsSuehpMZ/JsLOoH69pWS7eLjVhGxHPcRKQydWHG8WsuuzClT5DexNn/S58luGc2PCGXkt5W4aHkWBDtzBfKnDVqqTGTiGSzZ8uNaWnt0MX7qqHGSAvzI16Dvh84CsDZGTc+2V2egPYYyngg1RvE1uByQwnDaawb9P/6nAeQoFtQSke5HPgfgdb5pVeu72jeUwgIdZfCLZEbq6A5uZ+vKazsQ4RgHFpqeRybpuTHn4BaOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TA+HHs0j3FrQARs9c/EKVAFbtwHyeMU9SeIgMe4Xy4=;
 b=p2W36tJPzNBjaHPZJ3YINpy7auXAX/RKirMvgc5S5pce9qAASUBjhpecqI87T3if2Y5Lh8emGleEgbY/fl9fTpe7u0ZTSRlevB2Tuqp7Y/1MyVhPy3bld3QnGqc+ma+gV8uc2vrlZd/lHQI+5WfG/CjmNTxyz3lvMSKQ3wquxbheERVnnpB+6c6gQBTddUXXMGCO62v8npEInrM/NtDWywGN3+TFZhdEwmOYNEKPbOdu9UqokhQPgYV6vqq5OYY0JpGAmRSkb+WhbqkJ9sDwQK+p6qzsMb3qPFui09DSyEEYPs94bAClzDZ38+thshChmOtJ3p6tv1CljZSoQni4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DM4PR15MB5518.namprd15.prod.outlook.com (2603:10b6:8:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 14:23:58 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 14:23:58 +0000
Message-ID: <3e0c7e92-9158-4dd4-8169-e72dad01fd16@meta.com>
Date: Mon, 15 Sep 2025 10:23:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 08/10] riscv, bpf: Add ex_insn_off and ex_jmp_off
 for exception table handling
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20250913155133.657930-1-clm@meta.com>
 <a806d318-e51b-4e79-8d36-15d9a78af66b@huaweicloud.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <a806d318-e51b-4e79-8d36-15d9a78af66b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0517.namprd03.prod.outlook.com
 (2603:10b6:408:131::12) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DM4PR15MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: affdd6ad-2771-49e0-70d0-08ddf4638242
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VER4SXJZQmdiQVpieTVIS2t0RnZ0MzM3SGZXYnB5elVMblF1MjhWZUcvOWIv?=
 =?utf-8?B?Z0xlQXhBRFg0SW1xeFVKMVhrcHB4YmtQQlNXckRjN1RQVEFJQ3RzdEVvRVpV?=
 =?utf-8?B?TkxrUWVaOVlxaUY5byt2QXdNaHF5WlFYVWwvMWJ5N3dUQkJlL3luOWpyclVM?=
 =?utf-8?B?c3diUlB1T1dlN2s3M2c5NVFmS3R0Vk1INHZCUDhORHJ6SFJTT0FpWXJGTmRY?=
 =?utf-8?B?d3lFMUkvMkdGTFdEOGtzaVcyRWtmbDY5Z2VuMy9vdi9NV2UramRRTVU2UVcv?=
 =?utf-8?B?NDBoaFJONElIL2RrUjNycFpKS2dKUWZGNjZhbTZNS0hpMll2eTIvWVkvR1lz?=
 =?utf-8?B?bFowa2ZrQnlMbnN0UXZIaldMZVVOa2p6Sjg2SlZnSndvNFcvOVR3SkZmc0xW?=
 =?utf-8?B?dUhXUVFibG9nWUFMNVV6b0ZlQk5xem5kRFFQeUtwbEF3UHZkazJLdnpKK0Zz?=
 =?utf-8?B?ZGNOa1pOZm80SFB0alpLVkxUWW5qNjhGbTRYRFZDSnhjUjdWS3ovQTEvZFQv?=
 =?utf-8?B?elR0SlJPbGp3bVhYcmZ0V0s0SDB3MVRjK1ptMDJkdDVpOWRtMjFqUVRsc0hp?=
 =?utf-8?B?UVFSdGpBRXpwVmJRNmthSjFpRVdGMTl5N3ltNnh2SVBmUEk4NnBid1RFeHFR?=
 =?utf-8?B?MFdld2lvTGV6Zm9IZGJjR0pzbGxORnlQU2hvdWo2N0JpeU0rOWVYaFBON1FY?=
 =?utf-8?B?OVJ5OEE1ZGxUQ2V3SURHNTRsUXdaQmJjVGw5ekdsZk4wMDhZbzBlZEhUeVQz?=
 =?utf-8?B?dkdXeWZRekllZ3N4WGdOZFRJdHI3UXlEUzlJazRmQyt0R0t3bENxQmJWWDZ5?=
 =?utf-8?B?RmN2QlRmUUM5TW5sOGIzK29mMXgxUTBTTFErUkFJSnhDN1c2aWRXbHFQZW9G?=
 =?utf-8?B?N0Nnem5mRHhMdUVhTkx6NjlRa0xab3BCVEYrcWx3YkRtWHltZUY3d0FQVS84?=
 =?utf-8?B?bTRrT0tqdGFGbmhqVGczdGorSDdWZitrTG5hN0ZCenprcVJ3eER1bjJTSWlL?=
 =?utf-8?B?ZHJGSW50VU4ydU5rdDAzOW9aQUJybUM4VDY4cXpqcmRIYXJXV0FuaHFXbVJt?=
 =?utf-8?B?Z2ZKMmJwZEtxWGRxV1kveEtmQnpuSEVIRHp5eDBKVDBCWEltL2ZpVjJkWTRm?=
 =?utf-8?B?NkcrUmhsL2JUZzJVTUp4cG1RM0RzaGdQdDV1QkJVYjA2TkZaVVZ6NFdCanNt?=
 =?utf-8?B?ZlB3d28xNlBOWXkrb3pHZGJ4TS9lcDRBRUg3dzRwZGZJTXdXanV5UkVrZzNk?=
 =?utf-8?B?c0FJb2xVakFxM3Bkd2d6NVRiZkpNY2JmY09UZFpmeWFkc3QvV0EwbTBWY0ZS?=
 =?utf-8?B?SWJmSWZGSGFWVlo5UzBKOWwrVlVRaUZsdVkvbkVCdTVTSjhRejNuR3FYV0Yv?=
 =?utf-8?B?eHN2dnZmVllDb3Nwa2lkTGFsSTZvcElsU0o1Z3FwN1ZWcnMvUmlqVTc1bFgz?=
 =?utf-8?B?OXVMeVhhejBnL25qdENZdVpKb084MEcvM1IvT2w0RHplV0oxbkIrbmw4Vnhy?=
 =?utf-8?B?RkwzT3N1cUpJNSs5SHBGQVJYdC9jQWkxNnBiMmh4ZzZYV2Q1SEZibW9DbllC?=
 =?utf-8?B?UTNHZXRpTndEeDhBcUdtUGRMMEdCVXlJaExpSEd1WnJkZ1EzaWo0SU5hWEI4?=
 =?utf-8?B?QmF4VmMyL1dnRWVvSlZZN2o1U0pNZW9lY0RPQUtsZzh6eUMycTBOQ253VmZZ?=
 =?utf-8?B?aXNGSjdidlNGRVovbVVkemZxVTd1b2hVUjhQTUNOWWRTT0pEZ1BHWTZwbjdH?=
 =?utf-8?B?YzFYSEZCbExuVGdLWW9CRXFKb3gvbWN5dnlwNE0yTDdiZU1aTzZJR29lS3RG?=
 =?utf-8?B?a3ZJcTFGTUkzY1lxYmJiVkJTN1BXSTh2S2pNV3FBcWM0a0pSSXF5bUsxMksy?=
 =?utf-8?B?QS94d01QWmdSb1FsUkM0a0laSXBibWFaamp6dUF5N3hXeER0RU1CMFhJRi9Y?=
 =?utf-8?Q?O8YIVIy8Gis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdMUmw0WTd6a0lSQ1pwQW9jQ0ltTEFMMUYzY3VqUDlZV3FkWWJldFNyVEE0?=
 =?utf-8?B?WTJWRDdrNFlKQk9Fd3JTYWw4K0U5NWppczd6SUREdlpMY2V6Q09qbUZwZGFn?=
 =?utf-8?B?QmpGalZXRkhUN0NLVjg0a01KN2xHR0c2M1NQZ3NwQmE3N1VyNENObWF1RlZs?=
 =?utf-8?B?RkcyZGJJQ0U5SE9IaHc3dU1oa3QyS1R6RUtQUzE2Ym5FM0UxU3JKREI2dm9k?=
 =?utf-8?B?VWJqM2hvL21qQzdpbzJBa3FlbEdKVk1YTmlLR3ZhSmZuZzRmSUVYOXhzMGFQ?=
 =?utf-8?B?UEVPWEVvbzdaNjJwRGI2L3RBWVNvZk5BWnhZZlRFTDdkTTAzYzZ5Q1p4UzRs?=
 =?utf-8?B?NzJSVkN0Nm42aGMySzNKUjJqenVMMnppYS9JZTMwNE50YXF6aU85S0QyM1hV?=
 =?utf-8?B?VnY1enFFeGQxRzJ3aHdVOUgzRGdjeEptTjF1LzZFdDF2TG5wUVlvYk92Z05V?=
 =?utf-8?B?TTVGVU10aEpsOUpDeUNSaGx3WFlQUzhpUjRSejFTdDFpOVdIbzFYVS9XYkh3?=
 =?utf-8?B?UkZ6VFQ3cFZuTnhnUGoxUVNTZ3FUUHVlUDRHQjdNZnZwWngweU52VWJYZmdI?=
 =?utf-8?B?c0ZXY0UvVERvRFR3cHRkSDcyWGRNS2R0cGNaQ2cvei9ZS0g5MXJiVXY1K2tZ?=
 =?utf-8?B?Y21DOXRFWFZXWUxUNmNXUkt3c0VrNCtxeFVIRjY3eVgzcjVJVWRCbjZYRytK?=
 =?utf-8?B?TmpOZHRKbWFObDVmb0VremxORVluVmVUL1RWMXVGVXpJK2xnL3BJMkFyZ3lY?=
 =?utf-8?B?QUtFb0llUk9xcXpJWDNWT3B6b2tnOVdmSEhRNnpETko3Yjl1NjlPVWdTdTF0?=
 =?utf-8?B?bnVhUEpuKzZDN0RYRVpvakhxM3YzWWJjaCtnbXZkU3p2OUFGTCtiS2NXeHk2?=
 =?utf-8?B?RytCRHFyRkVRZ01ZdzhLS0xNdHIvbmxIVDFFNnVhY2hobTRjMFBrZHl4WmZX?=
 =?utf-8?B?Q2REdnBxZU1MdENrZHhiQkNPR0JzS29rZ3VXR0tzcEtUZk9UbnN0b1pCSXFk?=
 =?utf-8?B?dytQa3hTRUc5R2ZXOXNXNkJHVCtzYnJNUEd5THpCaW5yL2h4TzhZZElKSGRH?=
 =?utf-8?B?cVlvMDYyb2hsUEVndGR5M05udmltMk0wV2wzZTl6aVVBUjhVaXJzSTQ2UW1U?=
 =?utf-8?B?eFhiRG1KLzBxc3crbzlwWkFQN3lOUHlSUEw1Q3I4VXNUM1FlZEJxb3JISEUy?=
 =?utf-8?B?VDFlMlZ5U2k3MEZxZ0VJY1dwcnV3MnJKTHRINFUxU2tJdWZSUG5PbGxWY0Rv?=
 =?utf-8?B?bEUrVU40OWhoZVVldEtjSDZYbHF5eVFWOElNcUF5MVpFdFptazBmY1pQaGNL?=
 =?utf-8?B?czJiRXF4anF3MjNuSkVJM0Fzek1CVHB3QXpDR1c5b3RLNUZFR2NzcGlsRFRu?=
 =?utf-8?B?UzlhZmZlSTZLcktGdi9aZTk4QjN0RG5RbUtmS0NRTFRTbjZEbUtvc21MN3dt?=
 =?utf-8?B?MWh6OTFNaTlFb3BlM2paUm84U2pONEhmSVhDRjZaNkFnSUswanlqSzlYQTRJ?=
 =?utf-8?B?OHFCUExjdGVzWVFJQTdQd0VJYUpidEhZeGwyS0h3S3pFd2F2cjVjZVc5bTNq?=
 =?utf-8?B?SXFZRHBiU1RyNDArWmZaVW1pL0hNTGJWYXEvQVNVaWFVVzFyaSt0QkRxY005?=
 =?utf-8?B?eHlQNzZ0VEtRU2w3RnBoUkdRZHU5VmdqWWU0WnU2clRIS2VDTloxc1Fmem5F?=
 =?utf-8?B?WTFCUHpwbTJubG01R01IcU52MTBVN29xV2tBdWRCMWlmellXZCtOY1JkYnVU?=
 =?utf-8?B?OTU1dEVZMnBId1JEYVNubnd3Nno3Ry9sRGNNR281TXlGeTE1bWFaOWx2V1ZG?=
 =?utf-8?B?SGxQWThRaFFNMUV5ak9Cd3duNjVRVXNNekVrVzFzbkQxTnFaaW5iL1l0bTMy?=
 =?utf-8?B?Q2g1dHVyY01kZWpnZWJUVzhOVXY2ajk2WW9xY0svekpnVlBzUHBoNCtvQzlP?=
 =?utf-8?B?alF5VVVlMXB2YVZlek9zNGVIWjEwbWg0Q2dTdjNVelNvaFgyRnZxcTBQVit4?=
 =?utf-8?B?bkR4RTZjcWpvUGZmOGtNSzVNWnJEQVUvMFppVlh5ZWVEOXRTNm1udjQ5V1p3?=
 =?utf-8?B?c0pOV2IwejNEdHQ2WUxNZDcwcmpOZXV1Y2xpajcweE96eVkvaHEvb2ZSWW1P?=
 =?utf-8?Q?kPXs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affdd6ad-2771-49e0-70d0-08ddf4638242
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:23:58.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFmng+NdOwMbDQ7Mit+zJ1cEEjkClRqv8jl82C9tbkYFLrRNcXoAKz5GsI2SzBIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5518
X-Authority-Analysis: v=2.4 cv=CfgI5Krl c=1 sm=1 tr=0 ts=68c82181 cx=c_pps
 a=5IBKRMRyaRRtUKQpU9qwqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=gmvczhvCnwrv3RQt7lkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -W0qV7RjCgNgwzdQ0XEpTS3W8xTdgudj
X-Proofpoint-ORIG-GUID: -W0qV7RjCgNgwzdQ0XEpTS3W8xTdgudj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDEzNyBTYWx0ZWRfX/R/B5GPrEwVE
 uooookOod9FQnyX+yKy5+TqiOiSekj0jTIBetHQ90iH1mJtDB/B7KBmc64HyaRwL4PHlrX7mRZq
 oKsFBFLaZGCddZTOJqgQIE0FNTTZuCTZ6mlOkU5HAcGgwFaKprbyWvtv2OXY5PuPkp0i0S4vGDt
 jESC/DmsJMEBuOa+jncVX5aCSO8hNurPBVnbox9Ail0EHHLBACh1fxLIc0K1ERRXpkPTBjs3moj
 9grWJ+Q46WMjUhwfzwCxZXNJy0vOKLb7q9as/aU1b9Zy14OEfm8WgNXDIXZ2nK1CgbvplRbzUh0
 WovwKjoqyorAplXEnUly+xC1nBjflE5wqCKVRjFy3q1AjLZ7HbHoUqxJC77i/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01



On 9/15/25 5:39 AM, Pu Lehui wrote:
> 
> 
> On 2025/9/13 23:51, Chris Mason wrote:
>> On Sat, 19 Jul 2025 09:17:28 +0000 Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Add ex_insn_off and ex_jmp_off fields to struct rv_jit_context so that
>>> add_exception_handler() does not need to be immediately followed by the
>>> instruction to add the exception table. ex_insn_off indicates the offset
>>> of the instruction to add the exception table, and ex_jmp_off indicates
>>> the offset to jump over the faulting instruction. This is to prepare for
>>> adding the exception table to atomic instructions later, because some
>>> atomic instructions need to perform zext or other operations.
>>>
>>
>> Hi everyone,
>>
>> I've been working on some patch review automation, and I recently ran it on
>> the bpf-next branch.  I don't know the verifier well enough to decide if this
>> is a false positive, but Alexei asked me to kick off discussion, so:
>>
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>> index 8e813809d3054..56b592af53a64 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>
>> [ ... ]
>>
>>> -static int emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>>> +static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>>>   {
>>> -	int insns_start;
>>> -
>>>   	if (is_12b_int(off)) {
>>> -		insns_start = ctx->ninsns;
>>> +		ctx->ex_insn_off = ctx->ninsns;
>>>   		emit_stx_insn(rd, off, rs, size, ctx);
>>> -		return ctx->ninsns - insns_start;
>>> +		ctx->ex_jmp_off = ctx->ex_jmp_off;
> 
> Hi Chris,
> 
> I'm not sure if I have misunderstood your intention, maybe just for 
> talking about reviewing automation? But the code I checked in the 
> bpf-next branch is inconsistent with yours. The code here in bpf-next is:
> 
> `ctx->ex_jmp_off = ctx->ninsns;`
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/riscv/net/bpf_jit_comp64.c?h=next-20250912#n553 

You're right, the review tooling got confused because it only indexed
the x86 version.  Sorry about that, thanks for double checking.

-chris

