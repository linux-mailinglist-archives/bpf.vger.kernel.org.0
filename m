Return-Path: <bpf+bounces-33040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF1916198
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDA9285BE2
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C51487DC;
	Tue, 25 Jun 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MA6zMrSV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pM/nevzU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637D1B7E4
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305249; cv=fail; b=otX7x5Fkraq4V9uArOx61f00slgsb9SoxwpRWECFhR03UoMK84nL91P4qXasSU4qZs6vM2VdMEmw1MuuuR5CPuDMYLF9koyzqcgb3187q8PQiPLaJJ93smexklNagMEVKLE8HUZe7a5BQ/BHi/j0twFI8Zj6Mi/dV2Jaf9of9gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305249; c=relaxed/simple;
	bh=wq5jIgWEJdVDD+toSV/h4gN6useukYhb0q3QMGrWw9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dS9W9F4OrCYv0wuRXaCq+iXH4fZ1OP7D2J3erwavOoy8LAAdVMPMzU6eBw0Xvf6fWDkxHvM6ly8uwwiMZ4xDfGwv07Rp/YXmBUHFTxDGZI90vl8+gV0t1no4rD+oa8VzNPSDIVZlqPcqkUfO92yblPwF689h5NGFqQSMqYz1qqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MA6zMrSV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pM/nevzU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7tVhZ025087;
	Tue, 25 Jun 2024 08:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=J+8EAYOUNJUp9+ZslmtDFBiQg2TIGW6htBiwOrv54AM=; b=
	MA6zMrSVxXsFPPjwETy30w0JPiEROdecUI0iaFNAOqRyyZ/r1KtvMFqUsm3FPxfU
	n/c9KnWO8tLPm1KOTv9U8SeRpxcDUMPeIg60bhJISrT5olXnI2hfAEMnIGgGQu9c
	Xmclb6EkEZv5SCUED6WL4ydor09ckQWtRvr4EFw0LnSIpOJ85dre3+qkeTASUCSQ
	x06jtRCVE6J2ZuvKTxamZZ+7rR4xH2FWi66NqmFUOKEqLHazqxIaWV1BN+SnasUs
	cw+ngnWZB7kmqrapMTcosEcBWlZxmNkRAqkcehEy6L3r9fEEPfwOlkzyVo52X12s
	tRxG7IAfXTGYo7D8JnUx8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg97yqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 08:47:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45P6wwqd023381;
	Tue, 25 Jun 2024 08:47:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2drbqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 08:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh1PNK8KFtX76A/Y4RbsmGoM/0Rkpd5wDGfyvx2/YlPAmEtCvZgAAeJrYLD8DzXB/MPsXHpL8fXEnAitcX0rOTgp9P9Wsm/LKRiPO8w7RnzpT3x1QdN6MxIzJ+HtsabZmqQ03GUSdKxbdiV67U4vlSGvr4z0tihMMn08HcZoNaksLl7j+PvOX76Hodf+WrTgpjVFwJCRqhFI3ktHGHsjolOsUE7uD3ZkmOybHophrdBnCPtfU+pxxK2eKI2J3htqBAPvmUOBA3ubwSPsSvY3OSr+4lUxYysKhZXR9pznLj3v2x7jgsPWUoXt2HXIZwai1BrZ2jLIBBWK/kDdRIO87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+8EAYOUNJUp9+ZslmtDFBiQg2TIGW6htBiwOrv54AM=;
 b=fe2iRun02EVOqRQAhCIdZ87QsBSaY87NMGMllx8eVT7vpCxSioYS+qZWy+a7etLJF9zQR14eRL9YcivPQSPxCu13275gdT7X94pkQDJFFntk1J3L1PEQOiZrvQAIFqBFkWg9U4+bF9V6/iz4W3PLUWwIIBgDwh6dt+yDxwWYk2cVDAgHGJS8Fp+31HpPg6c0dSTVuhymAxER+Z6SSEQMcSaxQmVsKPNRF86QBGZNcPFo3LhhL26MXtxF2pDANQLs34OK4jsILU+5w8PNBSfz9zHyf9hZXyU+USuJxQvdrXOkBbiYAFUIKb/zT8n3uYpJV5xDzbuOKP+SytmvBfid6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+8EAYOUNJUp9+ZslmtDFBiQg2TIGW6htBiwOrv54AM=;
 b=pM/nevzUjGVlwyKzg8jY4jUSuqJNkmVddsOt4O42oG86j1olEysyYGD9Hp6nyZZB+Us/Qedz1JHJCIoCRjDohYCqDKKEeOymHjbAAe0/SWeLGIqf3kRxNsJ7bFZSI702hUuHhXF6CSVuvfHQ5JDc4yeehVHbr1+wXfRGwHbpclw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6058.namprd10.prod.outlook.com (2603:10b6:510:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 08:47:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 08:47:03 +0000
Message-ID: <808ae131-447e-433d-bd01-f04898b87497@oracle.com>
Date: Tue, 25 Jun 2024 09:46:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20240625052741.3640731-1-jolsa@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240625052741.3640731-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 739e9c65-d46e-495c-f520-08dc94f36278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eVhSQThOL1ZhYTNGOTdsMnFnUkU1blB2cDNZZkVzcUlUSFlnR3gwcTNIZ1RL?=
 =?utf-8?B?R25JQU1wdjdReTIxUjgwdXhoS0VOT3FldEtJWDNOTy9PV2w5RGd1TTRjeXdY?=
 =?utf-8?B?dkx4aVc1aDFDK004RUhVdmJ6cEQ0RWZ4YnRCak5KSjJNb1loTCtVL0EzMkht?=
 =?utf-8?B?MVBjL3pmcktMeDNCa0FSUElTWTNVdHo5U1ZPV21ja093YVp6NGVqUFd1Yi9o?=
 =?utf-8?B?OEpGZ1pxZ04vaWh0cEJ4QlE4bFVSc1p2RHBneFRzRWFORTFHMkhiZEs0UGZJ?=
 =?utf-8?B?VlU2SEthRGRMUy8rUzFxRnM4MlRlbytOZ004VkZ6YkFxYW9naWJWVklIVit4?=
 =?utf-8?B?emNyK0R2Tk40M1BGVURGQm5GYTFvMk9qcU1oamFvWGc1eUNETjk5V1FMOE4r?=
 =?utf-8?B?YUpqTVYyVHBGcXQ5QjJ6RG82aTdnWW95S0g1UEozVkZJMFVKVldHeHBvRnZz?=
 =?utf-8?B?R2piRjlGOUlabmtVa1NUamRGVFF0cGdiVFIrZ1NrT2NPb0tSQWgzQVZUcDN3?=
 =?utf-8?B?WWJDWmo0aVdrQTlqWStjQ3c2OVZTNlJBMTdLdG9hYm8yaHB0TE9mUEpFYm42?=
 =?utf-8?B?N0JacnRPYm10UHhDbzJZVjY2bGRxSUd0UnVrcHBWOFd1bkR6VnozOE9JTytz?=
 =?utf-8?B?VjlFUk50YmdhTWs3a2laMlp4SzlzR3ZOU0UwejczNU1ZTGFST0dKQmIyc2FF?=
 =?utf-8?B?MUpnbS9yOU9vNWhHVW5paGR6TGdJRUtaa1dEMGhxcFhpNjRoTXZkU0hDbVZC?=
 =?utf-8?B?eUdtMHhhYWJ3UGJiOEZIcVFLUU95djJSalVHK21qVU1lVzJsb1k1RkpQc3ZS?=
 =?utf-8?B?cURtZVhtUEtOWVZQSzR0UDB2SWdrQlhNdU9jZXJpZXQ4VlMrcWpXMHVIRlZQ?=
 =?utf-8?B?bEJtRytaY2dPajF1VTZGV3RHd3pJRnZuSWVXT01jdWhkVzN5bnlyVFFja04x?=
 =?utf-8?B?ODhqUlMySzlnQklJREIycUdPTkVQNUZ2R3RpRnRhQ1Q4bGMzWnU5WWJIVXR4?=
 =?utf-8?B?a1ZrZkxJcWpQYlpEU1gyNUhoeXFrcWduVkkySUtXbG56S21PQUNvRzBqMHNj?=
 =?utf-8?B?M3BVRFQzblBVSGk4cEJTWUJpaXZYc1hqZmQ1YllKNGNOWCsyUy92RXA2T3U3?=
 =?utf-8?B?cmJVZkIzQnhja29qSks3VElJcDB5VXArMkIyQWhsVFVVN3JpNCtyTTdMSzBT?=
 =?utf-8?B?c0ZiaitmUEtqSWN4SDc2MGdSb0dhZkVDREtZekZzZm42TFRRZFBTWDB6ZVVN?=
 =?utf-8?B?dWxJOE91aGxKUmE4TWUzVW1TZ3BzMWViTDRsNlBCTXZ4OVRiRGRqYW9lSDdL?=
 =?utf-8?B?SFdlL0daMFhhQ0t2bDNhTzBUUXNkS2tsOHNRMjM1Z0dnSmNRWGhnTHFRSjNa?=
 =?utf-8?B?WHJEb2VXN2E1NkNEWFhpOWxQRko5Ym1HQjcrZHJMQjhZWlB0L1BYOTR1cTFj?=
 =?utf-8?B?ajd4KzBlblBIQTVXSE93RmJpUUppR3R1UjBtd2hJS3Y3c2hRaDdjeHN4cHZv?=
 =?utf-8?B?a3JGcVgrQ3lHT2NsR3dxcHlPYzFYL3lveENRSVVNcHNYOW42S2Z3bGc5T2RO?=
 =?utf-8?B?eEhneEs2UEZxd09mcHdGemxVTmRHMUt6TDNBemFCaFFSalpNMU9nbXpma3Br?=
 =?utf-8?B?VEQ0c0tSa204bS9QTXFpOTRJbDBrTjJlV3lCKzVRM1FkK1A2am1qMnZTMmI4?=
 =?utf-8?B?Q1pWejNGcXRYMkxhSlVYcXBIcTBWZC9ZeXdOczQyZlgzUjBSQ1RtUWVlQ2F5?=
 =?utf-8?Q?9//jqr6kolsvXYASb0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUNHSnVTUEl1azBYRlN6Y1dyK3NUdk5QUGpnc1J5V1hxbHY5WVBycTdTeGZC?=
 =?utf-8?B?SjJ0L0MvNk9NTUlCa2FIbTE5ZXVZK09xMmZyVTFSZEdWWFF3ZmRUMlROWjY0?=
 =?utf-8?B?NXVNOERmMlJ1Y2F1aS9iOHBtRzhSRmlVRHRTUU9OK1loOHl3NXNLbVNWOWFF?=
 =?utf-8?B?YVVRNUlMQk0ySzJabHpHb2s5UWJSUlhOcXFnbWFJZzJScDIvSjFRdFBjVElX?=
 =?utf-8?B?QmxFdWowRFBhV0tDK1JQRGd6ajM1eUV5U1ZpUkRMOXlJcFZMdnI0VFlhT1kv?=
 =?utf-8?B?d3RaTmMrMUZTNDJoRVBXNjlEWjZ0Tm90QXVpdFlSZ3FmRWFVMmRMZ3RLQXNG?=
 =?utf-8?B?UHlrVGx3RUYzZUF4YlQ5aDB3Q0tySktiSEloeFUrN29KWXd0UXdsTW8yK2o4?=
 =?utf-8?B?ZXZGMEpxQm5QcjMyMGNoZk1GVFZ2Qk1EK0g3T0R6U3VvZUhFLzBDKzd3MlRm?=
 =?utf-8?B?Q28xTnpuUmVTTXlXK1NBdTlDTklIT2xNR2NwNTZnUHNJQjJ5SGdkU3Y1Vkhu?=
 =?utf-8?B?MXJQMHE1NCtNVmVJUXRtTVBENkdXZ1QrRkN2Y3FSNWtqTHd4QnJVVmMvTElv?=
 =?utf-8?B?WHE1Zlp4MFlwYUJIUU5aTWs4cEJuTXdjbXE4b09RWHk0SXJmZCs0T1Q3THls?=
 =?utf-8?B?NVhKTjd3QUdLWlQ5clJoWGdMbS9KQ3UySGdQTDJhYjJMTmlvR3VKeEw1U1h5?=
 =?utf-8?B?SmhwRVFxdUkwUGxMTG12Zytsa0VRTFJvWXVuenVSRFp1TGZDUHhTZVpld2dY?=
 =?utf-8?B?ZUYvY280ckZieFZSNy9lZFdlakFRQVkrYWNkcFpxRXNadXdjaGNhOXlOaVRa?=
 =?utf-8?B?dy8rZGZiMytOaUtTWE9LMEJrK2gyemNhVG15SkdDSVl2aGljcUlydTNDaHR4?=
 =?utf-8?B?WExycDc0M3Axd0NRbWVCUFllZElzNTRBNHVzbTM3RXQxUm1pWXhWbmxKRmd5?=
 =?utf-8?B?SVFMMW0zWTliK2xDMnZuaTh1RzRjbUwyVlhhL2pvaTRoWDlXc1VvMThNeTBH?=
 =?utf-8?B?L1RQSXVFZjhjY2pXSU9YcTBnRTNBWWlFYnlvWWR0MDUyMlBPdnNPUm9mZGt2?=
 =?utf-8?B?TDBXOE8wQVp6UEY4WVAyZU1lWEZBbS9mb1dyc0Zad2dBUGNpeGJ2Q0F0V1Q3?=
 =?utf-8?B?bXpZc1ovVFRzMTZ1SkZSMnNocUk5UjlTbCs1aG8vTWp3T1VabjdoOTl4aW11?=
 =?utf-8?B?MndYc0M2dEhyaWFRMk9xaXYvdjQ1TlZWL3d0a1BFZkFibXdPUXRsayt2S2E5?=
 =?utf-8?B?THpKZm94UDNlaWtUTkNJb2kxUjdmaWRJK3lEdjN1M3BLbUY1S1hxTjNPYnd2?=
 =?utf-8?B?Uy9DSHdjTzliZkV1aXFTOWhSWStpZldpWENzK1RzdFN1dGFIVlFNTEhuczNM?=
 =?utf-8?B?d3pPcmUvTWRkRjFpM3ZOa1dLVEhpcjlnbnM3Si9NanJEeW9saEdCR3ExdW1n?=
 =?utf-8?B?OHlUWFlmWmNQTnVlTnFFL1NKdkI0NU8yMkpVSVdLVVNWMFM0bHk2eExzSmRP?=
 =?utf-8?B?dm5hN0xKWVRNNjg4OWp4eE5pNFV2aG9KWXdwMUwxc053UWlDNUN2Rk9SeWRh?=
 =?utf-8?B?SUJyZDdxcjNRYWVXck10ekxFU0F0V2IzRk5ldmlBNkZxZjZMZktUZ2o4clNp?=
 =?utf-8?B?c3F5aGtrMlZ3c2R2aTBYL1pnRmdhdWk5Uy9tbTd2eGRaS2xKbWpObDhQblhM?=
 =?utf-8?B?TEJPSWUxUlcvZW1CajRuSmw4NTNnZkJuSi8xYTlZM1U0eVlzZ1hHSXpLSWNs?=
 =?utf-8?B?VFhmcTI5cVJKL2FzWHo1bnl0Y0puT0N4N1hhaDRROXVoVWxMSmR6S29iRURK?=
 =?utf-8?B?YklJRWdYQTB2d0dsL0tEVGhsUjhuaDUvSnV1VG01ZGUwQ0ZPVWMzMGtGeThx?=
 =?utf-8?B?emZnV2MrdGRDY3ZPcXF5S1pIWFYxWUU3RThEYUFBcm94N1BKYWE4dG9zYVNL?=
 =?utf-8?B?UHUrNnQwNC9GOXNpYzBqWXFYL2FzZjNKemNNei9yWWtFU2ZzazhaczFLdXdT?=
 =?utf-8?B?YnQycGU1b0pxNVY2UU9tb3YyUG9ZWGJTdUNnVVdsSnIyeHZ1VzFHU3pYODFi?=
 =?utf-8?B?R3lTNERlbXIvcWgrc0ZPdkY2RkF2cFA5aGVCTmRGOS9zQ3F1VkJVS3BZcFlp?=
 =?utf-8?B?eDJQb0Rad3psQTJaM05lZldlNFRGYzVDN0ErTDA4c042cmtOOWxKYStmalAw?=
 =?utf-8?Q?P/y31C3jmYaQ3xuseetrbLI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z/hYFFYahhd4jluCQ3fGoHqbZY4neC8+pllonuh6WuI3PA+HhBvJ4O0w8FhU5jtEXiwkHpRfkdVU+z9wZuvT3csoY9ACu1RF1BGmNrtjwxcPDseyPnUXmZsdBX5EII6cltDle3QwNScrKarwPaRFI+7pTJ21PhggiZ/52o2myPwPnaAH5eSh6aYUz7LgHyYPLj+uRqcwRdYuySMi1WjKCdPKifbxLS7NrPU8gLjmL28cu7BA2ruDsJlJkRzPjGilFJLYx7/v1bI/n1AhZscYyrNGumuaZ4ySyLBM39TSuOY6zpdORTfA9s+X/BtZvdsfBIrMX+CmUdzjltvCL9A9/hYL9wDv/j5rzBNcIIIqDzhXEA3Pf3kR/Jb9QTEuYc+4e2bNm+zgn5F8T5ZIJ4kTIiA3VI68ynn7g+tC/C/jnhjCslmtlWYbQn5oz50xrYjniTf1wIKRVXppOwUC/GeJ/oh7+bz+IHa/oR2Ttr7heCfVetpHu1snplB0Fpw2rF8/a/BImM4ZzpLpYaZg2BPaAi58SZcAg/MR4JNZCWGyifQmKwUN5NRVwS5HM6GgaDpQR28JH5AqppIN7QH8bzNJTEw9gRKoWXrrB27frfgys8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739e9c65-d46e-495c-f520-08dc94f36278
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 08:47:03.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1lzcZSK9n50H+yjnRJIWnwq9clbSpCJVAVow5AS5GJa7Hzufhv78U05WqQLG72LA3rKREa58ywOZ/UIj8IFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250064
X-Proofpoint-ORIG-GUID: Fm5MRP1RSQ9FUQwSBBGUmFvF1ZfkpVoA
X-Proofpoint-GUID: Fm5MRP1RSQ9FUQwSBBGUmFvF1ZfkpVoA

On 25/06/2024 06:27, Jiri Olsa wrote:
> ARRAY_SIZE is used on multiple places, move its definition in
> bpf_misc.h header.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

good idea ; one very optional nit/suggestion below but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h                 | 2 ++
>  tools/testing/selftests/bpf/progs/iters.c                    | 2 --
>  tools/testing/selftests/bpf/progs/kprobe_multi_session.c     | 3 +--
>  tools/testing/selftests/bpf/progs/linked_list.c              | 5 +----
>  tools/testing/selftests/bpf/progs/netif_receive_skb.c        | 5 +----
>  tools/testing/selftests/bpf/progs/profiler.inc.h             | 5 +----
>  tools/testing/selftests/bpf/progs/setget_sockopt.c           | 5 +----
>  tools/testing/selftests/bpf/progs/test_bpf_ma.c              | 4 ----
>  tools/testing/selftests/bpf/progs/test_sysctl_loop1.c        | 5 +----
>  tools/testing/selftests/bpf/progs/test_sysctl_loop2.c        | 5 +----
>  tools/testing/selftests/bpf/progs/test_sysctl_prog.c         | 5 +----
>  .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.c  | 1 +
>  .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.h  | 2 --
>  .../testing/selftests/bpf/progs/verifier_subprog_precision.c | 2 --
>  14 files changed, 11 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index c0280bd2f340..ac6ab1b977a1 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -140,4 +140,6 @@
>  /* make it look to compiler like value is read and written */
>  #define __sink(expr) asm volatile("" : "+g"(expr))
>  
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

nit: would it be worth bracketing the #define in an #ifndef
ARRAY_SIZE/#endif? A few cases you're replacing (like
progs/linked_list.c) have the #ifndef/#endif protection.

> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index fe65e0952a1e..16bdc3e25591 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -7,8 +7,6 @@
>  #include "bpf_misc.h"
>  #include "bpf_compiler.h"
>  
> -#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
> -
>  static volatile int zero = 0;
>  
>  int my_pid;
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
> index bbba9eb46551..bd8b7fb7061e 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
> @@ -4,8 +4,7 @@
>  #include <bpf/bpf_tracing.h>
>  #include <stdbool.h>
>  #include "bpf_kfuncs.h"
> -
> -#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
> +#include "bpf_misc.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
> diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
> index f69bf3e30321..421f40835acd 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list.c
> @@ -4,10 +4,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_core_read.h>
>  #include "bpf_experimental.h"
> -
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
> -#endif
> +#include "bpf_misc.h"
>  
>  #include "linked_list.h"
>  
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> index c0062645fc68..9e067dcbf607 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
>  
>  #include <errno.h>
>  
> @@ -23,10 +24,6 @@ bool skip = false;
>  #define BADPTR			0
>  #endif
>  
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
> -#endif
> -
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>  	__uint(max_entries, 1);
> diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
> index 6957d9f2805e..8bd1ebd7d6af 100644
> --- a/tools/testing/selftests/bpf/progs/profiler.inc.h
> +++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
> @@ -9,6 +9,7 @@
>  #include "err.h"
>  #include "bpf_experimental.h"
>  #include "bpf_compiler.h"
> +#include "bpf_misc.h"
>  
>  #ifndef NULL
>  #define NULL 0
> @@ -133,10 +134,6 @@ struct {
>  	__uint(max_entries, 16);
>  } disallowed_exec_inodes SEC(".maps");
>  
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(arr) (int)(sizeof(arr) / sizeof(arr[0]))
> -#endif
> -
>  static INLINE bool IS_ERR(const void* ptr)
>  {
>  	return IS_ERR_VALUE((unsigned long)ptr);
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 7a438600ae98..60518aed1ffc 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -6,10 +6,7 @@
>  #include <bpf/bpf_core_read.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> -
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> +#include "bpf_misc.h"
>  
>  extern unsigned long CONFIG_HZ __kconfig;
>  
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> index 3494ca30fa7f..4a4e0b8d9b72 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> @@ -7,10 +7,6 @@
>  #include "bpf_experimental.h"
>  #include "bpf_misc.h"
>  
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> -
>  struct generic_map_value {
>  	void *data;
>  };
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> index 7f74077d6622..548660e299a5 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> @@ -10,10 +10,7 @@
>  #include <bpf/bpf_helpers.h>
>  
>  #include "bpf_compiler.h"
> -
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> +#include "bpf_misc.h"
>  
>  /* tcp_mem sysctl has only 3 ints, but this test is doing TCP_MEM_LOOPS */
>  #define TCP_MEM_LOOPS 28  /* because 30 doesn't fit into 512 bytes of stack */
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> index 68a75436e8af..81249d119a8b 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> @@ -10,10 +10,7 @@
>  #include <bpf/bpf_helpers.h>
>  
>  #include "bpf_compiler.h"
> -
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> +#include "bpf_misc.h"
>  
>  /* tcp_mem sysctl has only 3 ints, but this test is doing TCP_MEM_LOOPS */
>  #define TCP_MEM_LOOPS 20  /* because 30 doesn't fit into 512 bytes of stack */
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> index efc3c61f7852..bbdd08764789 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> @@ -10,6 +10,7 @@
>  #include <bpf/bpf_helpers.h>
>  
>  #include "bpf_compiler.h"
> +#include "bpf_misc.h"
>  
>  /* Max supported length of a string with unsigned long in base 10 (pow2 - 1). */
>  #define MAX_ULONG_STR_LEN 0xF
> @@ -17,10 +18,6 @@
>  /* Max supported length of sysctl value string (pow2). */
>  #define MAX_VALUE_STR_LEN 0x40
>  
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> -
>  const char tcp_mem_name[] = "net/ipv4/tcp_mem";
>  static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index c8e4553648bf..44ee0d037f95 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -9,6 +9,7 @@
>  #include "bpf_kfuncs.h"
>  #include "test_siphash.h"
>  #include "test_tcp_custom_syncookie.h"
> +#include "bpf_misc.h"
>  
>  #define MAX_PACKET_OFF 0xffff
>  
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> index 29a6a53cf229..f8b1b7e68d2e 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
> @@ -7,8 +7,6 @@
>  #define __packed __attribute__((__packed__))
>  #define __force
>  
> -#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> -
>  #define swap(a, b)				\
>  	do {					\
>  		typeof(a) __tmp = (a);		\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index 4a58e0398e72..6a6fad625f7e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -8,8 +8,6 @@
>  #include "bpf_misc.h"
>  #include <../../../tools/include/linux/filter.h>
>  
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
> -
>  int vals[] SEC(".data.vals") = {1, 2, 3, 4};
>  
>  __naked __noinline __used

