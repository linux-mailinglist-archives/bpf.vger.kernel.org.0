Return-Path: <bpf+bounces-28431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CB8B9A40
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 13:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAE8282455
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D369956;
	Thu,  2 May 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2rwRNgX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JK4724i8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AC524B8
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650735; cv=fail; b=daidg+7s7jIpJPq15jtyVTaKV7+/z/eBjdNEJ72YEVUC7JZ9Ps/p0dlJUSVNDKSdPixvE7zl138xHBdLgCQ9ibnd610SRFRHDug1vfSi6YsQqS5Yto4PbI23MCu3pQilsEsqy7go6rJ4kuBs4UMT8YWkIshH6wjGWYb+N+YUyfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650735; c=relaxed/simple;
	bh=LcSQwlhiLdUtq0OQXA/uHmZDLAnUmYGZUHQLBF/mrSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eD08ywKUjxFhVNRaOLGCTmyQKyWonbE1tSSQXW9sVZ9646e3IvJ0ZB9VI9/LnbsLjzxg1DfkTYWSSYpNparVPlMNGtlIL7FV9K1Q0zYFUHdhhN/cSLXZFvTpFhbTQE213RVNoyMzr6zzrCxidQKGQo+xjlsXKzGto0TMu0a67Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2rwRNgX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JK4724i8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44283wiF023983;
	Thu, 2 May 2024 11:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=X5vp+uMg8S0Bb6ycR28Bb0dAmAPxh+YjMWf/H+nHsi8=;
 b=I2rwRNgX2U7KRu4uXnt8+0eR3bfEeEf6UZAqwV1iYzQvjrV5927mN18yLaTRvPbMH9Wq
 /gxta6iQKZsCttGuHJN8HJj3Y6eLqpVpikBeNs9MzqTOxXAC242jSDSzLARR8slKb+nA
 mzhOLtDHSRChEYDD3ZPoy9xsAwcj9wOVfq1n2oSLmHbjOIpPUnx923XHa2Rsm6sPmzQx
 dTb3tqPSITWOzW67QAUvjpHjZ6qh2CofkFjN8MEvUDJycsyweGPSkDfJxnnxx+izG5oI
 kpuEiNCh5SdZ4Tvpo4y48JrcIEp2PXbgrc59Oqxv5kDILWWrtnE4nXpNf419DBCkUObi Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdey98s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 11:51:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442AdqDr039936;
	Thu, 2 May 2024 11:51:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtaxfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 11:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMrUUETvSk3s72EdUZG5GbMfKoEjO0ietbH2kCbcuXnVJ8tNAasAC8HYqKEFN9CtnRxcJGP0HbkaXmtB+7yL/Hv76kIFdyBH5CffHFtL+ZR2FMqxibnIqMOqUbiPByDZTnvE/abiTPt8gxzHzmfXwFWZJ3UO4xfwU3MN7o70vio0g/6M0oyqHxUHfrvR2gqVhjkUhv6VU5THDPSkVg3N/QdifqFRX+epb4jo/tMgXCGJR4DWsGFbWV5pVPpvaMk56gBw8UfUtGM9Y7qabFUpU9oAKgWos8GsX4P5VPW/k1VWAbZY2kZYb1Cw47Emd9Y+AhuMsM9wdJusyLLnKAHeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5vp+uMg8S0Bb6ycR28Bb0dAmAPxh+YjMWf/H+nHsi8=;
 b=FJxRBZ4WZ0O/EQ2V89lE6IPp21i7cyA00yqzND6Mw8nf/0uQmHaGcZSW9DkGvtndcRjrjY8Edal83LvszmYs6nbOYms0nc6hNm6ly+VyGogWUkydLMpKxAx5OTwJbWfIOKyeEUIxcdV2WsWKDHwjndJgc6eLPVEr+mJNmAkUg3qpab2YNdsyMDF8WaVwq28leS2aT2osuZ5kk8StA3yDnXmQwRHzH3MeRlLfws72PjxSN3/+AUnXx06iVp/qj9q+ZO8zwnOe5SuQGxlCipz5JtHU3LrGzZWVJ1DotkESorwK4McGsvvP31lkY+RapcgR7AZxYGEeBZz91LyiTaWN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5vp+uMg8S0Bb6ycR28Bb0dAmAPxh+YjMWf/H+nHsi8=;
 b=JK4724i8xPVuY/pmVJxiwalL8NwZL/Faa7cPHHRBKs/fr2I1VAcmq8a1ZCKCE4PSqQ8oQtyLCXcXgM4dgS7QRH3wi900bR9L6M+KB/vkrzn2F4SDFVu2nK3IPzXl9diqojkdZYLjoqzNdDaZ6Pt3F4vhlT2aBlRdsViZKK0WVbA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 11:51:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 11:51:45 +0000
Message-ID: <d726f112-6152-4860-b3df-ad27e29e9dcc@oracle.com>
Date: Thu, 2 May 2024 12:51:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-3-alan.maguire@oracle.com>
 <c3564a5e0b159d559ecd72ad0849aabfb54a672c.camel@gmail.com>
 <97e1275b-c876-4ea6-997f-45ea43fd9207@oracle.com>
 <ccd4170425217114afa41e0b3dab41fd5f47492b.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ccd4170425217114afa41e0b3dab41fd5f47492b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: facc94bf-694c-4e77-23f8-08dc6a9e3d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUg5RGtyRFQ1OE5aenhNK2RaY3FSeE92Q0xpdXZMTG1DbmpZTEU4NkJXcVpn?=
 =?utf-8?B?TXQySEV3Z3BVM0Q5UjZkZDRSRVRtbm9sM2FDN2JPcGp0aWVxbGxueE5vT0Yv?=
 =?utf-8?B?M2ZkdEtuenhGa0EyU1Z3TVRFT1dGUm1IN1hIM05IUHdnamZCV1NFSExvRkEr?=
 =?utf-8?B?djRweHlZclUrOHhhN283ZlZOa0RJd0Q0Q0FBRUFUaWRnNjMyUXpKV2p5R05D?=
 =?utf-8?B?ZnVYb25yWHl2NEhCZit3NHBXYmd1Q0FxdGdYM0pNNzFJWk9ISDcwdm44R1Uv?=
 =?utf-8?B?TUVhTStML3pQc0cvUWxudmlxY0tCZGYyTkt2U3RFMXlML1lHdk5PazN1MGUv?=
 =?utf-8?B?UWlsVnZjQm5ETk1LNzRJdEVRZ08zM2ZWeDZvbmpVbzU0Y3RoVGJNWUVsTmRt?=
 =?utf-8?B?Y1Y3d3FMM2VvdStyVWlWU2FKY1N4TVJaNlYwUjFOZ3BpZStIL0RhWHlKaDJV?=
 =?utf-8?B?NG9sUXlDNjBybWdtNFNhaXphSnRpclkxQTF0K3FOQWVxWGdIMm9aZVl1eFF5?=
 =?utf-8?B?SUZqZHJpWHpGT1J6ODJKQ214WVptZnJaR09DVTRBYkJMRWpyc0x3ZU1NbnV2?=
 =?utf-8?B?cEV3blloRFhrNDFRcmdSa1o3YzVHRTVqN2dleVV5dFJzT04xRVA2RjlGQ0Fo?=
 =?utf-8?B?Mmtza3RiN0JHdzR2cFpBZHhVWlFuUFNKcG1ZZlpackZsTVU3TkJYT3MxdnhO?=
 =?utf-8?B?a08vTWxQeVJJN0xKSjVDTlZsUUZ2ZmpHNmpXaVFueUpTSmpuay9NR0lEb0ZQ?=
 =?utf-8?B?WmQ1RWlGY3lwK2hDdC9EbkJGNHZyNnk0WUJwb1k3VkU5cms2RWZPUWZINDJG?=
 =?utf-8?B?TndIZVdvTXc0U20rNkt4RW92cmpibnJadTJyQU5wZXVBa29Db2w3UCtvaGY5?=
 =?utf-8?B?U2U2UDY4ejhMZVdRT0RjSWlLRXYzMmlyUkRLRytTWWhkYmlwcGpXblluREtO?=
 =?utf-8?B?bUNYNjJoa21QZlVwVjJGalBpRGpDeHFBSDNMbWgrWmpHaDhteHl6UVNDdmNn?=
 =?utf-8?B?SkFHVVAzcTJUYmRQbERsaDlyMi9wZmZHUk5tdDd1aTI4SFNVeWxMRDZuY1dD?=
 =?utf-8?B?Vzd6MHFjd2R4L1BoTmF4NExKOUdnek9GbnM2bUt6NkhDU1RodkhvdFRiSkpN?=
 =?utf-8?B?Qk9XTkxINXBtYk9oN1JheUZrTUx0RmxudkJDSGlndmRQMjNZU01DWFhiS1g3?=
 =?utf-8?B?YUs0NkQrV2swNWFCcVMzQXNlMmorUmxrbVZuMUpXd0JrZUFhVTI4dFVwVTBs?=
 =?utf-8?B?L09lZ1pyMVZXaHVaQzFrQTlKbGRRZGNycTRld3JoWkE4dHNLU2RSNURTRDhD?=
 =?utf-8?B?QmtuMWl4ekRNdmlZN2wyYnZ6SXFjcmJkeXdnV3k3WGRvZzFXeW5sZUZkd2pR?=
 =?utf-8?B?Y1QvdkZqeWRlcERvVG1BWkpEZEh4ZGcxS0VNZ0hKZ0xrdEtsblBOMG5yR25y?=
 =?utf-8?B?cEZYVDJtVG0yaUt3bGVWQ0dUT1RNbC9mOUtlbFZSU3UvbU9zRHpZclRGK2Zp?=
 =?utf-8?B?aitRYlBPS3dGai8rZWRJaFVtOGY4SFA0LzRTYmZ2cWxNZXBFejIzankzbm5F?=
 =?utf-8?B?bGc2eFJHWUtuTEhOcmVzNVhWL0tsMWp1aCt2bForQng2Yzk5VjM2MmVxTnNU?=
 =?utf-8?B?NkZCczd5c1V1UFVEbE42bjZ2S0plbGVYc05kQXJwWmNoeVdFeEE2QmVBRTE0?=
 =?utf-8?B?ZlZKWGlJSUNQQXZiYkJGRXFnZ1BDM0dSMmZWcHpQN2REZVlPNlp4cjBBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cExUcWd2VkxST0Urb2V5R3Yvb2Q0OEN1QXdTNmJvY3VRUnlRcVN4Y3pack9s?=
 =?utf-8?B?RStXTWxYYWZtd3RuelZKQU1HdkJkM1dwYW83NlpXQ0ZXU2xTZ1F3WTdqS2dB?=
 =?utf-8?B?cVUrQVlkR2w4Q0ZOTUVCYUg5NnlBOHhRVFBoMWxET2o1c3l6dytibi9qb20r?=
 =?utf-8?B?bndtaWE2WkRGWURkeFcwWnF3UkdGU2VMdlk4TDFMYnhSL3hxZWRTcTZpMXZK?=
 =?utf-8?B?bVczRVY0NDVUZ3RQMHB2ck5sdk1NMFRTNDdUSkYzV3Z0QjZQdjBIZHBubm9G?=
 =?utf-8?B?Mk9yTkl1RnlqN0R0R21zeWFweTkyUCtOTDFsalBnelE5MEhPTk1BZVRDd3hY?=
 =?utf-8?B?Ym1HV0dQa0RRK0poU2luOVdGckRpSDNSVm50aGU4cXNLdlV1Ri9nWG02akJi?=
 =?utf-8?B?Vmdsd21EU0cveFo4WEJMRFRNSzB3cmVOcEIxYW51d1RwQXVWMzBVcytrWHFo?=
 =?utf-8?B?TjFjdFlVMXBwTEJZOUxIQ3BZdXBXeHZGTWxCNXhVWEVPWFpQSHZPWkVPbURW?=
 =?utf-8?B?aVRhWnhBWld2QW5mRWJCQWdCaDRzU09DR3ROQUErd3dJNSsxSDArb1pJLzBj?=
 =?utf-8?B?TTNxU00rUEwwY3JmajNlR29MT0xvTjROeDZMT3ZMMnBLTzg2WEgremZEc29q?=
 =?utf-8?B?Tk5QSS8wdlkxT0ZsRTRsc1BpYzZVanA3UGRwei9Qb1ZVNW9SRmk3WWxEVVB5?=
 =?utf-8?B?cVJEQzhiSGh1bnVMdmFkRVkxTlc1T3BxVnhFUGtDV2VXbEpudlY2cXRKN2s2?=
 =?utf-8?B?bEhlUVBIdzcvUXdpWk0wRmRFT2tad3FHLy9jZGhqWlBocUZwWWl2YWVmTnky?=
 =?utf-8?B?UjlHVnp2enBtYWVSQkdpSzFSWjRsTllRNlpvZ1lkUzNlV1V2SnZDTXJvOVFt?=
 =?utf-8?B?am1aNjVRK0p1ZXpTT2RQcEEzSFNzeU9XK1FJRzlBWkliZEc2Q3BtNFdnNWc5?=
 =?utf-8?B?UHRBMFFPMGcxODZCTDBOM3VZdTlZcmxDb3RFb1ZBTlJ3SVQ1aTBqS09ZWFcw?=
 =?utf-8?B?UHFJckhsUGVaVWpiV1ozMEx0MzZYMGpPK2luaFIwZ0l1aEttS0RmZkx0c3Zw?=
 =?utf-8?B?NEV5RFZJWVlrYWdFZW4yb0ZqSTBuenlBR2FQWFM3clRpODNkUmlmcUxaM3ln?=
 =?utf-8?B?L053Y0ZuN1FYNGxPTWZuZW5ZeHNtdUliYVhBWVUwUWxWUU5OWFFCRzB3K0k4?=
 =?utf-8?B?WHhzbUpQc3JmOFNBc2pYVjR6RjFZSXYvV1ZvWCtZS0RRWGRQTVRtMFBTKzJi?=
 =?utf-8?B?RmJJTzdkWHEzNTcrRHlOd3VNTzJ0RVkxdlkwZXJiWDlyUkc5ZWRzSk9TRjhu?=
 =?utf-8?B?WkU4M0JOemxOQnBBalIwTm8xR3M0UHhMYzJCVTZWS1NEOFo5YXpJY3RweFhU?=
 =?utf-8?B?MlBHeFhCTGg4eXF1TGhiODA0c2dYU0ZCa2ZMK0tXSUgvcGw3TytsVnc1TjVn?=
 =?utf-8?B?blN3bE5vcjlXcDc5bVlTSVBBV2JpOENTcnlHTEVRdldMN3Y3cTR6QVd5V2FH?=
 =?utf-8?B?UTRtVWhYaWtaSXpKNGsrK3psZlJQUkRKRFlkdnZwTU5ialZuNEZkQXJvaXJR?=
 =?utf-8?B?V1ZUMTUzQ1dLaGpyUUlFOUxrUGFGeDhESHNiUllSQ2F5ZmtsWEdGdndHNTFl?=
 =?utf-8?B?bXltdXM2b2tJRUNyYWh1c2svVnA5TFVqeUlmanBNcm92VnBYWDdGRjhHS21Y?=
 =?utf-8?B?YU85N2xKWmRVTDJsUVhBK0JVakV0aGhub0RqQ2FmYSsvMUlWWFFMMERLYVhs?=
 =?utf-8?B?N2JvZHJiaEV6aUoxMlJGd0JtVVNlTW9LRkd2eVB4b3JFQ2FBdkNNVkdqY1Jo?=
 =?utf-8?B?SEMwQndOUEwwLzVJT2NJVmVISlVBSFVvd1g1aWt6M25ZVDhZRFlXMmJPbERV?=
 =?utf-8?B?Z28rQjhXQnlNSFkvVks5NHpMUFErbWNNSEZzVi9Id0QzN0JuWUM4WkFsejZa?=
 =?utf-8?B?OUhOeklETGpWd2RQTWVaRUdUd0JXNVAvU2pydTBYOGR2YzhXNDZhc29ORWMr?=
 =?utf-8?B?V3JpWEwwL0NudGNyVG9DL1FBMGI2b3hoZ05zWUNLR2kvWTFocldrdGJsdUFW?=
 =?utf-8?B?YUFScmlhbEN0MEFFZm85VDJsMnJSQUxlbEFuRHV2bGIwNHc3OG1uT0ZjVHFT?=
 =?utf-8?B?WTRycmIyZVZ6dDI2cUorWWpJVWZhUFljc0hJNHh5Q3NNUVZKcDdHNktML2gz?=
 =?utf-8?Q?c9dUfLux2CQTujpJYYnTFdI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4NklmrbD3pXqNPNWY/BhM1aJmfWdm1IQeydF96RUblq8hXx2ByzkDc0ZD4tWyY3Ywh6RJtFViLTROgX1KYpYPc/gBxlC0i14M6h+6xaOF8WAtGg91T4Ct6IiQoGKlDJCgORj44n+D050oBbxY3zZRHu7WaCYODk4G4wJm5o+I7QbpZJmo8iBgB4pdqMMjWs/eVrAov9o7IlTFyHUtQE0HhnJe18FR7FM4Dn5neSMsoenF25OVeZnFT6PSmTihVl0a7z/oLO2MoMzTrYGISYMQAaQ9ehQ0svHFZ3m0Tr+sDhQyxVjiFIrNiUhTs1kxO+k90iGmsU3I1gaCuRA56P0NfYnbaeyZzwl0d3BBPowDp0bO8trA+5E7Zh+z2UwfPFOq6pmhrhQzIZtK832/+P8KBxgcBXPlXudVFCK2xXyO5wyYSuMLZn/PNzLM/P4V9BHWEqCQ0otO6o519OvOaHduw/KORpdeS4yD5XFTC2DZ3P/oncSEGB31xErOhOYI3NZX9jzFbRIh0qzxeyUwOF/xbTOkg20ivM1Q0AVfoPhaL0aWgpj+Ou/iUGEH6EESBQO+k+nA/mhIiiKd19CWWC2lOPpOIHeb+kVUX1GDKuPUfQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facc94bf-694c-4e77-23f8-08dc6a9e3d86
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 11:51:45.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGqf0ggJfaqQU7V15WCib525QeFdV5O0mWVUBgwNaw/sCGmBUXRpzNIczANdphD6RdLSN+rWfeyQLlM0+w0HMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_01,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020074
X-Proofpoint-GUID: fMW9gos8mrk_EW7jNHEIrB-jm_qCa6Uk
X-Proofpoint-ORIG-GUID: fMW9gos8mrk_EW7jNHEIrB-jm_qCa6Uk

On 01/05/2024 18:43, Eduard Zingerman wrote:
> On Wed, 2024-05-01 at 18:29 +0100, Alan Maguire wrote:
> 
> [...]
> 
>>>> +/* Check if a member of a split BTF struct/union refers to a base BTF
>>>> + * struct/union.  Members can be const/restrict/volatile/typedef
>>>> + * reference types, but if a pointer is encountered, type is no longer
>>>> + * considered embedded.
>>>> + */
>>>> +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx)
>>>> +{
>>>> +	struct btf_distill *dist = ctx;
>>>> +	const struct btf_type *t;
>>>> +	__u32 next_id = *id;
>>>> +
>>>> +	do {
>>>> +		if (next_id == 0)
>>>> +			return 0;
>>>> +		t = btf_type_by_id(dist->pipe.src, next_id);
>>>> +		switch (btf_kind(t)) {
>>>> +		case BTF_KIND_CONST:
>>>> +		case BTF_KIND_RESTRICT:
>>>> +		case BTF_KIND_VOLATILE:
>>>> +		case BTF_KIND_TYPEDEF:
>>>
>>> I think BTF_KIND_TYPE_TAG is missing.
>>>
>>
>> It's implicit in the default clause; I can't see a case for having a
>> split BTF type tag base BTF types, but I might be missing something
>> there. I can make all the unexpected types explicit if that would be
>> clearer?
> 
> I mean, this skips a series of modifiers, e.g.:
> 
> struct buz {
>   // next_id will get to 'struct bar' eventually
>   const volatile struct bar foo;
> }
> 
> Now, it is legal to have this chain like below:
> 
> struct buz {
>   const volatile __type_tag("quux") struct bar foo;
> }
> 
> In which case the traversal does not have to stop.
> Am I confused?
>

no, sorry, I was! You're absolutely right, BTF_KIND_TYPE_TAG needs to be
accounted for here. Thanks for catching this!

> (Note: at the moment type tags are only applied to pointers but that
>  would change in the future, I have a stalled LLVM change for this).
> 
> [...]

