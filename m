Return-Path: <bpf+bounces-43176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F39B0A30
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC242855BE
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DBC1C07FC;
	Fri, 25 Oct 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQi93Vfg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tTIrb7jH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5F6F099
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874630; cv=fail; b=bMYA2ibY831bSz1jco0eDYeOnGNwKto6ndC93GfyGyAWXz/3YLyCk52SzjXIVbbdeVQm3RZ9ihPeAhwFwy6tHRIGvHiC0iz7XqOlj4Sik9VfJYPR43mSH2Y1z6J4MF+DZ1pWYTjVz49XWuzatAdOgXx8psNSioNop2D5T58gxYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874630; c=relaxed/simple;
	bh=Obp3wxt7z9BhJNSpiT02Qv3hQ9UqxAuOq2X3tl8mM18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXNcSqyDakxsLGAPT269qjLlTbzne3S8CC8tL/KnYFAZ2Z7BThiu67sjlWOUXhtf5FRRzn3RfreJfpXEJBWU/6VUnYI0YetbESXuyKlCIZawtuWZhjjprOC+zZn1A7jVatsA579gtDV+ZCUTrdcjkzl+/35Ek0Yx91KyjTIIohA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQi93Vfg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tTIrb7jH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0ZMn029576;
	Fri, 25 Oct 2024 16:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8cNJTQFPQ4OnzMOs05uPPITbkmuHMtk76L0P/ah7n+0=; b=
	jQi93Vfgp6CJU2k28rvlaT5sPwKlTk0EcK+fgyyGhSPTR8DVaE9jJjyCiRFQjiKm
	bJX9gVEaLTpA6A8yX4wB/sXliBQJyuK61xGgJnN1rfVJYKOTZcge07Qr23lcUqfN
	s5mhaiFXNc78/JpxnaJRN8DByoDqzUj/QNY/mObzFIVL16VNbUvcNNlvzSXvStvr
	In21uPjTNzW2rVnwWMLIgxZPdG/o93lyfHek+IZwubfCHgzw30u3+cdFbqhjG5IW
	n6zsCHG34PlM5A8yZtcr+fWtSkIL4D059V3BReu1kmT79GpJmPY4oZN3Xpc0ABj0
	tocyt2yHbf3f/5bp/92sRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uwcjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:43:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFjbLO020927;
	Fri, 25 Oct 2024 16:43:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnknbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONdQxbHt84T27RnoQ6lexBcaPI+Bg1ZlyKIVohypunkvB+y2p0/NjTzn5yw78sdjUOS9cMB4oLNyMZJAzez4S1KKK/P5OMJkbJs9QRXG+0grf1D7hU4cLEUnm7ps0tKhiilXJfQKNB9xWb5ER9jM2cCxpDMPalOezbijlh29YEXP08sZdP5QA0XKa19d1snGAZ3cOySAKYhp0gq9GOsF+1NTl0WrIcraNH+qqHyrnSR+TDNILWQqAr756stF0u8rbXaGvhuUnZpPDFXhDtzxMufudzFrDTUMdOeQ8EcsoYdTFSr/gk7xuuUbWztvAKVgr+dqyOsiGeWDqZpSidNq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cNJTQFPQ4OnzMOs05uPPITbkmuHMtk76L0P/ah7n+0=;
 b=I76Q83eP4cXnJdHOHxkkB1E8rh2AAEYvmHuuZ6IFVpAGHtx3PhEojKMRxJKEYVyUEDUGWVJYu9EAMwF/xZe8txtJ9whBpQLQID1EOJuTJKVTOe4qnUo9zUX73FRvEi0uzSwQK3Uv1wgr28LbP+JWF7fjs4z78CR4YS5aI2exSRgMTdRekvV7wJ0RCNT/WI+jnrD2w2iT+o6HZuqjgJR76RU+FWWG0Nr05Vu/+S8tF+TjGR6HcF5MYkyRK2zyI93tyc3pAobLmqxIbVWItIfA27zgLy7gIrLCIlJmTWgRNpuqkB/wNBmyS7ue5jmidoB/KePhRjdLbEyrKHO2ghjy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cNJTQFPQ4OnzMOs05uPPITbkmuHMtk76L0P/ah7n+0=;
 b=tTIrb7jH3NJ+m2Zp68EBAjTZEy84EXWmErGQ0VA52co7QZ2TXHaDe7cM9lbXr+cKIxBCwFcg3+ARe9P6S0oA97a0spyd4qa7k15rkEBaIof50IS4VBfQtZwbgWvu9OSHhXuVKotd2hyaaPWlP1RusBsZqWOVzpRX+UtEE4NBNFs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4880.namprd10.prod.outlook.com (2603:10b6:5:3ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 16:43:15 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 16:43:15 +0000
Message-ID: <f12662c8-3a5f-4df9-86b4-0517b113f0e4@oracle.com>
Date: Fri, 25 Oct 2024 17:43:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] docs/bpf: Add description of .BTF.base section
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bpf <bpf@vger.kernel.org>
References: <20241025153850.1791761-1-alan.maguire@oracle.com>
 <CAADnVQJkR4jikUJ2FKANro0yfBTBNNBU-mzd6bxy1DYn79ifww@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJkR4jikUJ2FKANro0yfBTBNNBU-mzd6bxy1DYn79ifww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:208::35)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5fb80e-5fa6-45f4-4e3f-08dcf5141f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlVTMXcyRUdsTVZaalZhMGdlMlByMmhKNmZwelErc1lJOVUrZGF5ZGlIVXdo?=
 =?utf-8?B?QmdxdW8vYlltL0N2MDdhTUZod0RlaFIyMWtFT2dKdHEwZlpEdWtvQWNIV0J0?=
 =?utf-8?B?YTNOeWp6b1VlZWM1YWp2ejFiZlZQcEhsNCttc0FrYmZVVUJmR2V2VUg3b0xM?=
 =?utf-8?B?blR5TUh6dmkvT3luYWRUNjdQM3VPek5UWUYySlBxa3UvbjFVeVlYYnhvNVRx?=
 =?utf-8?B?RHVyNm1TQUlOcXZKWDlyMTRIamkyV0hNcUs0bklaOGc5cVkvYkl6dXd2Z2xp?=
 =?utf-8?B?ZHBsSWpDNEI2amovdVJrbFJBQVlnTmZjRmFVRGhZakpDaTZSdGJieEtYZ2dt?=
 =?utf-8?B?cDFySElKRi8rNEF6SU1IUDBSbGpDcW1lbVhWS240U2VuYVZwK0ZRV2VueXN3?=
 =?utf-8?B?cXpvcEVDOStPSmtaa0pNY2M3TUcxTm5BVFZoZ2p2U1QveWhXcEVLQVFwVW8r?=
 =?utf-8?B?YnRrd0RLcDc2NDAzYlkzYmxkTVZ0dGZ3aGdWdjdOT1RkMTdFVmxvUzNlamx6?=
 =?utf-8?B?VmVhUVRXRUkvWDhBV05VNVd2U0NoQzFwd3ZKVHhjZzcyMVZINlV4VllDN2dU?=
 =?utf-8?B?OWY4MERpalByT2ltTnhGYng0UWI0M0ZEaTVqbHNqcXJNaC9JVFdwaE0vUmV3?=
 =?utf-8?B?c0c1c1dnaEVwR1FSTHFyYmNFcXRvNW42VG5oSklKdm1zK000eUpOZWdzKzJz?=
 =?utf-8?B?VGNHeVdjYVhUN0FVaE5YTEFHRXhzN1E2SUJWSTdLTHpLUy9jRnZpbnRiMEtp?=
 =?utf-8?B?SThpZkxuRDA5cVJLR1B4TmJ5SmVPOWJQM1pmUjkvaVdxOFIzRThLd21uSnVJ?=
 =?utf-8?B?V2lPdWltUjFqMU9XZjM2czZIaXl1MlEwSEx5RE9XYU84cFNOMkVrbFJocHor?=
 =?utf-8?B?QUoybUJjeTlZclZ1dWhjbjZmL0pIcVFvKzR4K29VdGEvMnQ3NHFEcE1vYUxm?=
 =?utf-8?B?aVh5YU9KdnR0ZFFRd3ZZaktuVDRud28xdEg3c0Y0S0JYdXNrZ1crNzhNWFpy?=
 =?utf-8?B?ODFpaGMwazUxRXJYTlU1cldLbE00TEhhYmNycDl6QmF4d1MrSmFKZk96bXpX?=
 =?utf-8?B?MlFLVW9Rc2RzWlFlc05wc0J1c3JqREpTMHFtL3pZQ0lvcnl5MldhMVNYWnFH?=
 =?utf-8?B?WW53UTE4RUhnSXI0cDRxYkJ6OU5MZlhqekdHVlZRLytMVVB5QXBMNGVmRVRs?=
 =?utf-8?B?Zy9NUnVYbUZuYk9Kb0J1WHJjZVRtZzVNWXR2T1dhRnR6MGN1Mm83bFpFWFZP?=
 =?utf-8?B?SW5XZ21BT3NvbVZTb1A2WlBlMFgzaEZXL2xOd1J3bkNwL2dKdk5MenRsTTJm?=
 =?utf-8?B?YmxNbktqWXM1L2tDaTAzajlJQ3g4dUh4S0RTZWtVOG53UEF1bWZaUk1uSkQ3?=
 =?utf-8?B?Rm5LOTV0MnVIam51STVhakRCbVlDYkE4RHlsSmsyNDUyRU5pNktqNWt6RGNY?=
 =?utf-8?B?b0JFVGovY3pwdDBNaEdTdytqUjBTRlhZcjYzaU9pT3hOcjVuVDVPczlDUVdB?=
 =?utf-8?B?QzBiWExDdmM4Vk15M29KZlQ2SXRIbE9ua2ptejI3clp0ancwcW1OQzBja2lD?=
 =?utf-8?B?akVSU0hGNGUzQ1d2Q2Qrek5kVnVuYmVYdVM2bzZtSHBWMi82WVNZdjFMZVBR?=
 =?utf-8?B?OXE0SzlHdDdtblJBYy9GRkNiYzRLeVBaUkN1bmVjZ0VBVHN0ZWFhN2FyWmNz?=
 =?utf-8?B?UVpLQStneWlOL0J6WXRxdkVyZThZdkxyb1FTSDV4MVFEN2hyaTZ2OFdxTXNz?=
 =?utf-8?Q?NepQY6I3esMVg5deAVIhprVrwIJ7J1+34c21l4n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUtnK25lRC90dVRVMlp1NVNUK1pvekFLTWlBL3ErUDRZVG5JSDFlTEh0amRP?=
 =?utf-8?B?ZUFVUDVHQXhCV1NUcXM0OG9ueTN5c3dNdTFSaU1BRkdaMHFMOUdDTXJuUGdu?=
 =?utf-8?B?OUhBcFNrbFc4cjhpaGZLTFVMYWdGbFJBTkw3YTVoZ1FPRjgzQVlOUDJoOFhy?=
 =?utf-8?B?UXgrSCt5Y2NqdVRTbXpsTzRLc1dEOCtmL3NLeE9TeHpkUUs5RUdBZ0hpN01z?=
 =?utf-8?B?djk2aUlmNndHc3MwOHFhRzZDR3M1ejk4azkzZTNQdjFaTXVHZGVUSm1mQ2I4?=
 =?utf-8?B?Q0NhUm9NV1NWbVJQd3RmVGFYYlFpb1VFNXVsay9kUWZPNjE0WndGYUdqY3k5?=
 =?utf-8?B?c04yNitDYlhiUkZia3c2TExtTC8xUTZTc09Ydld2WjV2WVN4anlDcG5tWk52?=
 =?utf-8?B?Vnh3Skk4MVJubkZHdU9RSTJRV0JCZW02dzBjdVYzTHB5V056cHU3VWhqT0dE?=
 =?utf-8?B?UHFlUlRUK1lwRnl1MGx4TXR2aHM1MHRkMTAvRUFGdkhTZyt1ZVJzNFNBcWJm?=
 =?utf-8?B?QThVZEhWQjZsOFZsUjhSWHY2UlVtMzJmNTRrZHR0SjJWVDFJQjFveHQ2bkE3?=
 =?utf-8?B?emtMTHRldVp6cVBjYWdmTnlQdFJvVzdiU2hKeitvTFB3UitOMGNOdWNIMDZY?=
 =?utf-8?B?dWN2T1pNSTE0bjhXT0I4TnpSb2pkNUJnUFk1MkdZSXpjRHVQdzdlenkrRTBW?=
 =?utf-8?B?cFdPU2FFL0NmTUhROHpZR0JJV09pdStMOGx2SVZmTXZldGo2QkQ5OEJsY0tu?=
 =?utf-8?B?c1dienphSHJSOVlBUXA3cDdsOG5jMUdYZklLdlJ5ZUpPdDVMK0dyemV4Z3Ry?=
 =?utf-8?B?bGd1V0tBVDBFbVgvRFR0UGFyemp0TGFIVXlqUi8xV0IvNG0xQ2E5RTV1Mm1u?=
 =?utf-8?B?STIvb0s1QnBjOGhvTTVGdDY1RjJueVJ1QWJ3eWV3RjdNMXQ1ZGRrSUlHaFA5?=
 =?utf-8?B?emY4TDlyTUNvZGZodG5hS1dZSERleVVnejN0QWdRV3lhWFBpYjVUVDlxQ2VX?=
 =?utf-8?B?N0VHY0g2b0txSWdoRTVKYjNiNVhsOFdXZTBKeFRwR0hVckhzT2l0WmJVMlB0?=
 =?utf-8?B?SThnb0tWY0M3dVY0dktFeDZLaFhqOWozaFBVcmUycDNNeEcvYTFQNzRLN2VM?=
 =?utf-8?B?aUpSTXM5eUVUM1FxZVFjSVpLa3RQdFpaRDl0YlpvTUZrby9sTVh3MVYrK3pE?=
 =?utf-8?B?clZsVzE0TS9naE0wT0hKb2ZLUlFkbXMrem1JTTRYWG5yVzVvREQ2SWlEck5J?=
 =?utf-8?B?dEwvdjdFVk1YcGhQNzBBMFN3ZEdTTUxjOXlZeEIrVzF0V0tVR3UxSyt0Mmlj?=
 =?utf-8?B?NVl6ZTYwZ056RjgxTHVNSzFXM1IxWVpjeVhha0ZxNUVrVTM4eG5Rd0RMM3Nm?=
 =?utf-8?B?YmVPRVBvTjRDcjJ0OXVTWUd4ZmJ3eW52YnNRakZsUFd6VUU4WjNNdjJiMUE4?=
 =?utf-8?B?VHRpM3paa2JCaHg0ZFh1bjNQOEhQWVN5SkQxSGprOFoxaGVva0R4QzBJWHZr?=
 =?utf-8?B?ZkJ0STJVOHJRNEJYaW5TdkY1RVpLV2lhaWJWM0t0K1JaQmYzNVN6ekZ2K1U4?=
 =?utf-8?B?bEJLVjluYjRxSGt0VW9TUXFIWnZqUFpLckRrb2FxYnBMcHkxQnZJZGJFU1h5?=
 =?utf-8?B?aWtWVU9Kd3ErT3JXY1BiMXpscUNSQUM2TU5KVTVBYVROVXNhNkdzTnBFbExx?=
 =?utf-8?B?c1JIUHc1YXJ2TU9vdjR6UG9QTGQzMGJpK0JZNGdNeWZWN2V2U01pblNXVUI2?=
 =?utf-8?B?UHZ2RlN6UmY3TWRQM0FJYVFzU2Y5S0xteWJITmdrbG14UUlxdTZWZm84WGlI?=
 =?utf-8?B?SThORG9kMU01MWczc3lCRnliL0pBQ0pNanY5dWY2cWNjd1BhRk8vL3VmRmxv?=
 =?utf-8?B?ZXE0aUxiV1IrdS85cGQ2eVMrc1BJeVBXazllSTJmSkZ0MWRndDB6RGd0YnU1?=
 =?utf-8?B?NDJ4QWVac1pwb1U0cGxNZ3RpNGlNWDRSbVd4TjcvZlJWeTBBeGVIWEorRkNk?=
 =?utf-8?B?QzBNWllabVg1cFFsU1Yva2RVNk9kd0dCWHgyZHFkOHVmZDdlOUttcUFNeWUr?=
 =?utf-8?B?bEhQbThVbkdOMVQxa0YvUEIxbmpKTnJwWjZSb3ZLRHV2OFNuTmZ1NzVBS05m?=
 =?utf-8?B?bjFQdzlUdkxPektpM01aUVM3eUJ6WWZza3l2eFFZak9TckMyelhlNUE4LzQ2?=
 =?utf-8?Q?z0jYLB/pJDUSwRGLvlRM2HQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RjhZtmI7Cv6jyDJu4LVY6Z31eNIxRIcnzS6wkNLlKIAbjUsn8b3Kxiu7fibwE9+B5Idl6wGHVYVOUYIMpcgkI471LmVvyWpEAnSworFJg2D8rA5VAy55hkLUOa7TR721acqmryNCl9JbhQXxdBd6pVOeciCN0NK3ngk9dLYi/+a1PhoQ2aHsoa8dY7RN4O2iyxio929Ex9zEixWpQbzwLhw/dxdsoy7yIbEMPA5/YvUzFWxeU+OUjr8rn1W9AGuc4+ofWyO/XgPYqIrEctD7/pTtc2idIrC6b6Rat18joihfgHu2jRTuQxySwwerLfMB3kUsvGsqRiQX0uDn5HAlzvkbsp0qm6u/at/zaojEP45sdql5rQ1uhnH2aL7jJ8H7/bhboZzZm6bV6eXKSONRVe21spsfoBAMf+WaC0PAQwFLCmd3P+QjcQ7GlacQrJ5ofkWbZ/qqQXmFOTJbecXpGDfj5NOBmbbgAQIa3am+KRLJLyn5TZp+MD3aMuSzmyL1g8mac6r/HfvmK/UhHJyTwKJbmghble4DLU1VX9wO8jD7ihYIXK+AVD1cf6AAbKUluwI25GxEB2vVJth91//0ExuSschlabB5xjT3JsNSR4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5fb80e-5fa6-45f4-4e3f-08dcf5141f16
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:43:15.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6fU8w1sP7SxewsblFPjC2o3mD+2mPpfWVauAT69e7iF9+F1A7kZv02NX1OAxvXAugrb+Vi1AD9lLmDBs1b9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250129
X-Proofpoint-GUID: g9tBsYp25gVVckwESsLkkV71g2YSi7Tt
X-Proofpoint-ORIG-GUID: g9tBsYp25gVVckwESsLkkV71g2YSi7Tt

On 25/10/2024 17:14, Alexei Starovoitov wrote:
> On Fri, Oct 25, 2024 at 8:39 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>> +
>> +.BTF.base sections will be generated automatically for out-of-tree kernel module
>> +builds - i.e. where KBUILD_EXTMOD is set (as it would be for "make M=path/2/mod"
>> +cases).  .BTF.base generation requires pahole support for the "distilled_base"
>> +BTF feature; this is available in pahole v1.28 and later.
> 
> 1.28 ?
> 
> module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
> --btf_features=distilled_base

--btf_features is supported from 1.26 on, and it tolerates unknown
features so we can supply feature names even if the feature is not yet
supported. We could amend to be 1.28 but I didn't want to do that for
the initial push as 1.28 was not (and still isn't) released, so 1.26
seemed like the right number to use. We can update to 128 once 1.28 is
out the door.

