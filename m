Return-Path: <bpf+bounces-75880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE55C9B893
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44243A6AFA
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A7313529;
	Tue,  2 Dec 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+3nFbvM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jJsy35QW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73127313285;
	Tue,  2 Dec 2025 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680219; cv=fail; b=bRrGy55XF+iH7XxUx/kvE2ai/x7PjyoscxkpayK84IjWhW7r6aYybu6VE7PN6vxEPY/3BRUstuZLEMm3ho+C0XuhFul+gZGbi6eEt8V4Lish7SG0O0fra5Jf2nh/SnGmT4CBtguCeJgLkjo9zFVRNJqNDG2jgsHVr0vFV+vOxs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680219; c=relaxed/simple;
	bh=TxtzLaIbuJR2hqk8AoOUgSgDeqSVbhjskC6QlsNXphE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgIcFoDFPRz1jSyS15NQ6VNLhtV3wwVzwuJrrxjm3FqiRDV2ZkNSXikgj6GoOMyfNZRqPw0d9++IdV6hjRmgBmEU3Fm9P4AUfBzQWWXEdG0FwEkjtcg6ePIr86ZwQUUC/FHBBqiZH7ttDrJq+3TLc4OyF4wlXWZydp0igiwExdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+3nFbvM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jJsy35QW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2BvMgs162759;
	Tue, 2 Dec 2025 12:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Gu6m72HpGY88kRoY09ANkuoRWStP545UjRHgSEh/C+k=; b=
	T+3nFbvMdMFpl4U0pNzdLnZoQdKm+KlcljocUr3RMMaZzKxjdSluKo+AFOF/We2H
	z6zFQBEtVQC/OJb6MMES/0cwpdT/2xHSErp/Q54TSCe2oI1gr81N+VJOXzLJ1DkW
	Dg2Ml9lZMNqUHkVG6VG4bKNBVrEPTe+I6NZSWiaqbe48HTHBlOhYUqtoESG3FxjP
	kSPKHnWnltNpTp7pW7+UtwZi/VV8ZyViYaThR6CVyeXWiQ6XNOp8g73n6zAvhFi7
	WWVTJDTUIyGZ5Iai9o+9nAN6AmZYlUCpU1istZs8X0JF2aoIWj83bNd808A59bRh
	IVh5DRDxdK5pgSocDV2R0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7cp2wd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 12:56:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2B18fr011886;
	Tue, 2 Dec 2025 12:56:32 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9katgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 12:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ8rIy8FuFaPd33+k3noE3k9QlIO8BhVhgqVyJTlX1wIXXW4mFsT0JHz6mVPwp8XQ0+NxTVmSo9AZ+/FyyAb2hNVeOv6cZqpmqamc5kY51pTGZUVxzVSshkxzoGyolwxUxK/dgiH6RFni1VOeOZMmcxdh2/3Pt0ie0UiHkAvetX12XEhKU0HP3pSss5MYXQulF6Y224SbAYsuAMd61lOeSnWG9/s64GbvUuJZpIBFaNajKuLo7yWCIyXsBMU6GX5gmJlqLhywjjYpmWOjSiD6kc6tVJVMqNU+x8wglX4vf+POnjS+HSEQnWh5jmuKYHmkFnAwkau/WzzsKk8RBHUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu6m72HpGY88kRoY09ANkuoRWStP545UjRHgSEh/C+k=;
 b=xx0GEuQ/hdTQRG69A3Uw8bDyo22LQJ8vrZ7+MZAS2eyseRkv+McLHw/8v0KfD4h12zr25fHtX+RsHOAJO/FG33CBCjRz8u3c7sYdN/u8fEyquPbHTXglZUhOFPzMGJHRtrAHt4mH8WwpuLO4ZfhzC4sg6RQVcnn9DJV9iJHpO9mCtQMXbkp7f+lyZyPF7nwFue/zrucbjxVV2qkcJz1ZymYBdr3ZrMkSjk1LMs9oOhY/U+sRedoaObPrAb8aCmCXEBbZTaIRB/ESfLscG08oYHWCaM/D7HEyyDJ+fqEKaX+Z4P8xUZpTlPUFCwYmg8B+/85UilrKfjKLMcJwec/D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu6m72HpGY88kRoY09ANkuoRWStP545UjRHgSEh/C+k=;
 b=jJsy35QWnQg/G8+204+hlWxY2LCFXsDbQq1nND2MUi+06jIFbPHbVYhn6wjqdAo4q39dRpXWte8HRU6IIxNqaXm7cSKHKQH77V4wo7A41cY2kfl4ZJcyrMOT7btTdy1KswQpA3tFhAT6tlqjMVlFEHfod4KRA+jKNyhbbtCPvNE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV3PR10MB8130.namprd10.prod.outlook.com (2603:10b6:408:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 12:56:29 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 12:56:29 +0000
Message-ID: <9e2fb142-4f3a-48d2-a627-dd6469909d72@oracle.com>
Date: Tue, 2 Dec 2025 12:56:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/4] resolve_btfids: Support for BTF
 modifications
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Donglin Peng <dolinux.peng@gmail.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
 <5bd0b578-e9ff-4958-b01c-fa3e9336eecb@oracle.com>
 <362b4519-522f-440b-a2ed-bd233166609b@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <362b4519-522f-440b-a2ed-bd233166609b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV3PR10MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc1be31-aa59-4c7b-6300-08de31a235c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xGbnNEejFneFlhZHFXd2JhbFFXT1UwazBOTldHcm1tNjhhWlc3UHFYVi9Q?=
 =?utf-8?B?ZU9DS0hBeGhab0hCUFJiUjMxU1VqSFZ2TlBaeXgwZkZWYlNTMHBMbE10MTlE?=
 =?utf-8?B?WHdBVnNCZlpYTWMweVlsMFVmamtIaUlDVzdaTytGWEQwOWltOThnZm53SlUv?=
 =?utf-8?B?NFlFRTFNTEdWWVRJcXg2NmxVOGxSVzFpcmFyb2k3amtablBWYUdBcVdzYllx?=
 =?utf-8?B?VzNFeGFGdXNKTE9ucXFVd09hUHM1enFySjNneGw4YjlsUjVwYUluMkl2UnQ5?=
 =?utf-8?B?aStodmVSQzNRcHZsNzVBZENOWjE0dWZRd3lWVjA2eHYrVlliZlUybzRZbVlY?=
 =?utf-8?B?VCthUW8yZ1U4RjRrcmR5cUxvb1FQZjVzRDc2WUptMEtOT3RrcWNlUHZoOHBP?=
 =?utf-8?B?QkVQVHdwb3IrRDR5SlZwNzFja1Q2c21xR0NGcGJRVDhaZmNTTnZIMGk0UElZ?=
 =?utf-8?B?UkxWYnBMZ3QrQ0lFU2J1NDBGamRpMHZabkIvZEhBOWhIcHI1cm5ybHhSU0Jz?=
 =?utf-8?B?enc2M0I5ZXdhdE8rUTNSRDljcWdKWHNmQldjdC9aT3NGZ2xKdnNKczV4TGhr?=
 =?utf-8?B?SG9nS1FVaUhJZGlnL1A5R2diUmpTUzNMa0t1UjQ1MFJJSEh5N3l5OTl3YUln?=
 =?utf-8?B?cktpbXpIQ3BvSFYzS2pNOVBPSWY5OHpockNHRkIrcjI3WWpwRmJYQnVFMWhx?=
 =?utf-8?B?QnRNQUlpeXZOV2FoN3Z5SWpYdWdJYWNtTnJHV0Z3eU12ZFdxOFE4SG1BMXBZ?=
 =?utf-8?B?eDE0WGJxTVdyN0JQcHAyQlp0bGJBNmhrTzlyR1JjaWtSbWp0bkJGNGdYckk2?=
 =?utf-8?B?WWQzdmRXVUtSSWEzbURhYWtSWTdkcm9WdWxmaVhzMFcxYUJTQ0lZWndGL1A1?=
 =?utf-8?B?M2x4cXNIOURFYUZQRmpFWG5sTXdvQ0VKL2ZucS9sMmo2UE9KUGNZTHZIQWZ2?=
 =?utf-8?B?cWZJNFdzMitza2c4bDk0UDRJZjgzYTQ5RjJwalowVUpFcDY0VzErNTNsWnp5?=
 =?utf-8?B?QzRrVDMyZnh2UGk5bXlUdzRZMlJ3YXlSeTc2bnJ0cStxWmM3bWJ5ZWdTd3BG?=
 =?utf-8?B?RE9wdGpDNFNEeUVmK05uZGxqbnFsbUJacDE1bXNrQTEyZEZuL2dyNG1DN0da?=
 =?utf-8?B?eUlHNzRSTkl5QS95N2NFU2IxWHdSSk9LeExrY01zUUJPUW5BUCtwazA3eU42?=
 =?utf-8?B?QkIxdXdHdU9Zb1EreGpHRWdGRlNkNDZrYzVzN1lFcmgrSktBQU8yaWM3QXQ1?=
 =?utf-8?B?dDhEUnhxWWZ3VytyVTFFKzJqWW1VT3pCZkJxT3QyWldVUC9Hd0VJWlo3OEFE?=
 =?utf-8?B?UDY4ZGtXMXpjTEpzSlBJZFFMQVFNSXpyWmxKSGtOck0rY0tYcUtzM2RuMk1m?=
 =?utf-8?B?bDIrTlNiNGJLZ1Zoc0R5d1U0TXFaeFRNZ29GNk9HY1dJbTlQY3RiNm9OaFFC?=
 =?utf-8?B?VTc2d1lORkYyYmlXa2ZaMElaWjNoc0xVdkZQRTVrTjBFajE4Q2JkTHczSzk1?=
 =?utf-8?B?VXJvSmpvMmNiYmZBTTRQTENnV3hidkR6K3AwbjFXUFo5d2NSeG0vVUcwbjc3?=
 =?utf-8?B?aFpTTFF4SmEyQlhybGw5OUlGNEhpV3kvT3k5TGEwVlplVVl5aGFwTDlkMyts?=
 =?utf-8?B?K1NLUlRMWnkweG1LTUVmUTlaZFdpMXRNWEY3d1pRZDNQMlFnRlMrbTNuRkFF?=
 =?utf-8?B?YXNqSWpGVFZqb0wySitMZFZSVVAwRWcwakNnZkwrWkVpdHQ1cVhYb3B0SmlC?=
 =?utf-8?B?dXJPcFpIQWJEeWV4WFdrS0hXOGs2RTdHTHZIQWFpVHBtTHdWNElaczVlSnhL?=
 =?utf-8?B?Zk1IRHFrbVBUaHdLd3V5MlRuelZIbGFkdlJURWNXUmxEVEQyQ0NuMDJVb29n?=
 =?utf-8?B?MGVGYTBuejNVa2dCK0l1cXhJV3UyeXdQdU9jTkJxaVpGM3h0TU01Nmlhc3kz?=
 =?utf-8?B?eXNLTXB6WWdoeWdSeW1Wdm5vdHRLZDdiY2xiRUJERXYrb0NhcktPQjFxR0RI?=
 =?utf-8?B?NDlaaEZmK0xRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVdwbmx1dk5vOHROaFUraFR6engrMGVZNE5jU3J1TWlRaFBNTnFOaHZET0pq?=
 =?utf-8?B?dGtLT0E4YUZ0QmdsZ29zWVMvazJkQ1lwSGhsNGpxUXpyK2Eyd283dHAzZE1F?=
 =?utf-8?B?ZzFzVm5leVh2RUs3TVJKdFM2RzhQZXRVSTh1M1Y0UlpZeXB2aU5kUVdTbWhE?=
 =?utf-8?B?QXRTa1ZHRy9LYk5uQlVKZFJ2ZXFKLy9xemlCUW5HOWhkR2xSd1VUcDhyYkZh?=
 =?utf-8?B?dVZaOG5NdXljc1dNTUxOV1oxQlc2N2tiWU9YV3prdzJlOWszay85M3lwMy9v?=
 =?utf-8?B?MEx6dy8rTzRCVWZrWTV2ak1OcFYzL0NKN0FId0p2cTlZVlFBbGFtQThZVXFu?=
 =?utf-8?B?ZjFmV0krYVFyLzVUc0hGU3NPRGJLOEt3dVd1VFlyNlo1dGtKcWxqSllGYXdp?=
 =?utf-8?B?NHc4eFV6VlZtT1lxZFpjZEhNNlYzR01aVVVwZ3MxQkJkUndoZW9qeDk5RHRH?=
 =?utf-8?B?ZVI0Q3A2bjJiQmtlYlRoNjhtOGRnK0g4emZ3VjlQWmRLRU92bENrT2QyYnVv?=
 =?utf-8?B?cW5mSGIvMTB0SlFVVVRjWWNNWHA0WlFhOVVCMDc4SVNPMlZwKzZ3YWdZOFhK?=
 =?utf-8?B?VFNrMTFuWEVPN0JZRFl2N1JZeTA3VXpuTW5vRkkwYWVDWkFmYkg0Q2JVOFIw?=
 =?utf-8?B?UHRJOFRJTXZVcGUwbmZ4NWtLMzc5MHhOVHJwNm5OR1FZOGZtVDFYaHpLd2pX?=
 =?utf-8?B?eURkZG1kRG5EOFVWbElvVTB1SzRkbTV0VTM0d3Z0QXU4V2pQWlI4V1QrUnVu?=
 =?utf-8?B?b1JYQlExUVM4allNQmtoNHZNUnFZeGpzZlBRU3VuanB6R3BqQlVXQlhLMWJT?=
 =?utf-8?B?ZVUrUnZ2UTBTQ3JMRXdGOGhqUXJNNW8zYXkxcWFBb0hySHQwd0lqQTZnUVQ3?=
 =?utf-8?B?L2FiUHE1S1pHaG1nZTBMRTlHclRKR1pOY1RMaUtsWHFPbVFPbU1FbEM4d0l5?=
 =?utf-8?B?Z25TNTFnbTduajc5NlZJRUl3bklPN0pJbnZSM1RCbTZFa2E4OXMvbldNY0xQ?=
 =?utf-8?B?V0c5MXZtYjFmbjhHVExjNDFWN2V3S2ZxckEydTYwYkxSU0VUUmpLZFp2bVdq?=
 =?utf-8?B?aEZMcENwVjhJc0gvcG9PS3ZwN3RlWENWemJRRk1hZFNaVTdtNjlwVldZSjU2?=
 =?utf-8?B?V3B1dEVnVWkvMVVsK0V3UlAyNDBaaGNQWmpFK0hWT3RLaTZQcGlUV2VwZVpK?=
 =?utf-8?B?Skl3NytMNUd4NFlPSGpoVytwTm9MTHMvSWltLzhRaitYZjNxUFBvaTVFSXV1?=
 =?utf-8?B?TkxDVElCazF1RVQySVpiOUlWMzhQY0wvRXJIMGtZQjVZbHdYcnpnUGVFRDVN?=
 =?utf-8?B?VmlmSVh0aVpRNUMvaThzOUZkMmY0VHRLMUF6bGN5SUlxaXJkY01MdnNScGk2?=
 =?utf-8?B?cmFhelUvVVoxMTFMREs2TFlNSktkT1d4a3p6RnAxR3NwUzVZUmNNRlpxMjBl?=
 =?utf-8?B?bEw3YWcvZ1grRVlSRDJWbVpxbm9oM2liYk44OExycFRSUTVQeE55MUNWMWdG?=
 =?utf-8?B?U0RJSWJGNXVGbTFnMG1UYzFGWGtCSUhvSHBtQnZQQTVvU2wyeExIWjYxamZy?=
 =?utf-8?B?UjFNckFjM3BHbmpCOHdZSjlZMGdkL1E2dzhla3pKcFJNT0NLMWhpNVJ4d3Ba?=
 =?utf-8?B?d0VaRk9OdDc0bWZ5d1JNbWRRbUxNWUVSQnU2QUVLWmJyTVI2YVZIRzk4eTNG?=
 =?utf-8?B?VHpLSjhyYmNzc0UwcHNENkZic0NOcDFVbUZqeTNidllDRzY0Mks4dW1ocElK?=
 =?utf-8?B?T2F4Ym91alRSRjBXMm5kNG82ZGRJaXNhUHd3R2lLMGVGUm9mcVQzSm9XS1dl?=
 =?utf-8?B?a2kxSGdEdzBMV1l6Q0lnN2xlRFBDcnE4WUpLYlZ4dTVFajhHTGx2WXhBOWw0?=
 =?utf-8?B?a280MzZNaXpDcEhrdHAvcWxLMEtjRWxwdXpRb0FiUGpYOUdjcXU1d0hGNzhw?=
 =?utf-8?B?aFc5RGludW02a3NaS3QrcUdCb01PekFKMEtLK2VoOG5SNEQxOFNReWhocVRn?=
 =?utf-8?B?VG5hMG9oZnJ5YzhBUTFBbWVnR3R5TjF2QUNPa1RMcjcxUVhaKzR2UERkWUZy?=
 =?utf-8?B?dTB5NmVyTGdtdnFhLzFTbmdDWEpuOFRLdE9EN0FXNW1vNUZmR05ReXQ3Z3o2?=
 =?utf-8?B?aTFnREkzLzN5czI4czZ0TXRTZmQxR2RuWS9rSkV5WEVPTzZMWWFqbEwrcHFl?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eMQM7bVnheaNhpVMOHpgw5JZH6dH5NkXWR+o4yOujYYZ/Ki2+SX5jriqDJIJUwchve0AK2DUt/pXwv/lO/7QwQAksSqiDDlV6hEfBl/5WRLbUV8JTZl7WRpsqCVv/01DYi5QYcDPd0hAhvR0xkQk/xNEqJ+IoPqE8pmsnPNspChkZsVOtDbk9p0FvoKET8r1affi6KSzh+YXpKvlj26tW1y8Wig7EhuRXDUIZvIFAQPmwEMhd3AGnKueBlrzxNfZPPNaFPggwiyePRsxvZw5Czlad2yowggfZTfj3z8QPlXxeanhC7a5CySu7Z25MFE1BN8I/ewP3oPJ162YWu9Xk6jICiERswrxLlPTt49WhdadTGLQ179s5dvlkZ22gLQb3ULSh1s30ZB8T0lcIhfoU0vkE42TtAZmMNACi0a8l6Yr1fImRgt4jSDw5ezY2eqVOvASx6Vj1dNVN/vCHIU1BzjZtfRA4zwUc2ohXmNc0kyqRMfbimvHV6J07xBF6gwqmUWBFyk0wmnpoFOxKEWkhV2V6svhvNO7alUzLt9fVs/bRpj+JgLHVQxdv59WmpKJRJhzJr6I8EPz2zXs9ajA7HYtajUgRIzZCsvZfHbM59U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc1be31-aa59-4c7b-6300-08de31a235c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:56:29.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5rCSjcHrvcg3J+XE6t8vNRQCpq/VfwsLOGqF4YRNlx/7Q1JW31m8TKhdNenwkQ2sCga4KV/se32cznjUJaq3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512020104
X-Authority-Analysis: v=2.4 cv=ZfgQ98VA c=1 sm=1 tr=0 ts=692ee202 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=E5KlofcYwjDTSscN1Q4A:9 a=QEXdDO2ut3YA:10
 a=U-CovGJQSHYA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: c4TOOd_JJs7dRlTsXUpWynh3-pART9Nd
X-Proofpoint-GUID: c4TOOd_JJs7dRlTsXUpWynh3-pART9Nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEwNCBTYWx0ZWRfX4rs20WRQC4Pp
 6ymrZ0i6Hxfo1zSkogmgeeFSPcE0ja16fD7NeuUYFo/5ePFyhhcVGgkT6cRKGu/ZrKg/932XJTb
 X6M1YBgTS1cqrMsuUGnQoZA9VZMuj2Yo4HqexGQZu71/mGXWzyjLPeESP+NH8c179vlVnm8Z6vl
 fn1rcDhvFGmqAeps50JvzSNVrplEJv6+5mLh0R8xrnZhGgg/Gl2R0lPoUHNYkuWbCYQExRcKzQr
 VHWyDznwDQg7CREkHx9xG0wOuxNKPORPs9nWzwLFCCLKeF1FlpWfJrlzpDo6vFQ/W0iEcGFdITM
 GsMdBB6U7o6LivSpRno32JTWqCbbABNVCYmQW5TQba7Bu+ZZXP2wsmpPQxEQZxHcBCVge4C+kvK
 wZ00N9SYCM+aliMqeIIVAoCqQt+DOVYgKH0Bl6HVQXA3zRki/TY=

On 26/11/2025 19:01, Ihor Solodrai wrote:
> On 11/26/25 4:36 AM, Alan Maguire wrote:
>> On 26/11/2025 01:26, Ihor Solodrai wrote:
>>> This series changes resolve_btfids and kernel build scripts to enable
>>> BTF transformations in resolve_btfids. Main motivation for enhancing
>>> resolve_btfids is to reduce dependency of the kernel build on pahole
>>> capabilities [1] and enable BTF features and optimizations [2][3]
>>> particular to the kernel.
>>>
>>> Patches #1-#3 in the series are non-functional refactoring in
>>> resolve_btfids. The last patch (#4) makes significant changes in
>>> resolve_btfids and introduces scripts/gen-btf.sh. Implementation
>>> changes are described in detail in the patch description.
>>>
>>> One RFC item in this patchset is the --distilled_base [4] handling.
>>> Before this patchset .BTF.base was generated and added to target
>>> binary by pahole, based on these conditions [5]:
>>>   * pahole version >=1.28
>>>   * the kernel module is out-of-tree (KBUILD_EXTMOD)
>>>
>>> Since BTF finalization is now done by resolve_btfids, it requires
>>> btf__distill_base() to happen there. However, in my opinion, it is
>>> unnecessary to add and pass through a --distilled_base flag for
>>> resolve_btfids.
>>>
>> hi Ihor,
>>
>> Can you say more about what constitutes BTF finalization and why BTF
>> distillation prior to finalization (i.e. in pahole) isn't workable? Is
>> it the concern that we eliminate types due to filtering, or is it a
>> problem with sorting/tracking type ids? Are there operations we
>> do/anticipate that make prior distillation infeasbile? Thanks!
> 
> Hi Alan,
> 
> That's a good question. AFAIU the distillation should be done on the
> final BTF, after all the transformations (sorting, adding/removing BTF
> types) have been applied. At least this way we can be sure that the
> distilled base is valid.
> 
> We certainly want BTF generation process to be the same for modules
> and the kernel, which means that BTF modifications in resolve_btfids
> have to be applied to module BTF also.
> 
> So the question is whether btf2btf will be safe to do *after*
> distillation, and that of course depends on the specifics.
> 
> Let's say pahole generated BTF for a module and a distilled base.  If
> later some types are removed from module BTF, or a new type is added
> (that might refer to a type absent in distilled base), is the btf/base
> pair still valid?
> 
> My intuition is that it is more reliable to distill the final-final
> BTF, and so with resolve_btfids taking over kernel BTF finalization it
> makes sense to do it there. Otherwise we may be upfront limiting
> ourselves in how module BTF can be changed in resolve_btfids.
> 
> What are the reasons to keep distillation in pahole? It's a simple
> libbpf API call after all. Anything I might be missing?
> 
> 

Nope, I think doing distillation as the final step makes sense to me
too since we get a clearer picture of the types that the module references.
My only reservation was applying distillation to every module (rather
than just out-of-tree builds) but it sounds like that's not needed from below.

>>
>>> Logically, any split BTF referring to kernel BTF is not very useful
>>> without the .BTF.base, which is why the feature was developed in the
>>> first place. Therefore it makes sense to always emit .BTF.base for all
>>> modules, unconditionally. This is implemented in the series.
>>>
>>> However it might be argued that .BTF.base is redundant for in-tree
>>> modules: it takes space the module ELF and triggers unnecessary
>>> btf__relocate() call on load [6]. It can be avoided by special-casing
>>> in-tree module handling in resolve_btfids either with a flag or by
>>> checking env variables. The trade-off is slight performance impact vs
>>> code complexity.
>>>
>>
>> I would say avoid distillation for in-tree modules if possible, as it
>> imposes runtime costs in relocation/type renumbering on module load. For
>> large modules (amdgpu take a bow) that could be non-trivial time-wise.
>> IMO the build-time costs/complexities are worth paying to avoid a
>> runtime tax on module load.
> 
> Acked. I still would like to avoid passing flags around if possible.
> 
> Is it reasonable to simply check for KBUILD_EXTMOD env var from
> withing resolve_btfids? Any drawbacks to that?
> 

None that I can think of; sounds like a good approach to me and is basically
equivalent to what we do now. I'll take a look at v2. Thanks!

Alan
 
> Thanks.
> 
> 
>>
>>> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
>>> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
>>> [3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/
>>> [4] https://docs.kernel.org/bpf/btf.html#btf-base-section
>>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/Makefile.btf#n29
>>> [6] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/kernel/bpf/btf.c#n6358
>>>
>>> Ihor Solodrai (4):
>>>   resolve_btfids: rename object btf field to btf_path
>>>   resolve_btfids: factor out load_btf()
>>>   resolve_btfids: introduce enum btf_id_kind
>>>   resolve_btfids: change in-place update with raw binary output
>>>
>>>  MAINTAINERS                     |   1 +
>>>  scripts/Makefile.modfinal       |   5 +-
>>>  scripts/gen-btf.sh              | 166 ++++++++++++++++++++++
>>>  scripts/link-vmlinux.sh         |  42 +-----
>>>  tools/bpf/resolve_btfids/main.c | 234 +++++++++++++++++++++++---------
>>>  5 files changed, 348 insertions(+), 100 deletions(-)
>>>  create mode 100755 scripts/gen-btf.sh
>>>
>>
> 


