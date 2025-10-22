Return-Path: <bpf+bounces-71846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3930BFE247
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769721A057DC
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E72741DA;
	Wed, 22 Oct 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqJi8tgC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zZQzyCDt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D526F46C;
	Wed, 22 Oct 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164388; cv=fail; b=fbxCrZaq9mYPmhUg8fOwB8z+xxvC8Ce6KUaVqpIr5fOn72lOo8Ucgr63tSs3cxp07SwyjWj6GwMQ/oMIN6WdE5YYieYcq2inr1XmrpMRN/XplyevOLtx8gFdP0We8IsZB1m8NFI1H6SS27caYddqmIOFALTBmaieU7L8yPBeoCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164388; c=relaxed/simple;
	bh=BlFkIxdb8AI/0lgh+Xo8BOKcKmjFiWiFEo9sdRdK6y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OdNZshvwDQy7mHuJDI5RwpgSFb+aRWdHmxs3r3JxaKv1AfTSFRp5O1LW5QEo/IZgYfWpK67KNhR/NXd9PmmkH0w45p8J0IbbW8PhnlMrWfaYse9C3Nl81fUJTZn8Az7SJJS/vhPJSWg+tDgK4jVahLd3ybWN2HeiGdVBDILacMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iqJi8tgC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zZQzyCDt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MI11Nb003052;
	Wed, 22 Oct 2025 20:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mstAtaydgdb5TVDKmNC4xxtvUFcON3pUovuFusuzNSY=; b=
	iqJi8tgCf5uX7Lf3W4I2WsVGdJfw56diGDm5RH2jQGZZE3D4lwhhU5zXxiFXX/Mu
	id7yNofQ6AvsqUaIBG/4+nbR12ukYyR5e+iK5czsj8xxzbKECy8Lf3dcadwT0EE2
	UYMQbNtbTHSkUGwtjkaQ/JoM/koMbr/BUlPeFWEKyieNmxZzuNg9IIA3OlsY/o39
	6edhW/DZvvyV3vfun1nosUqkyD3UVyCIuUzJjnU85ccMaV4quDCD85YcnDKPIiCk
	Bzk5l1m71og16ns6ejOVhJHfIdro2L74r4Gk09BBWunABQj39op7YKohY4nMux9Q
	L/2I4xud+dcvYIR0+QUm4Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv5wh8ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 20:19:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59MJppYu025365;
	Wed, 22 Oct 2025 20:19:14 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwk85r2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 20:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owU0ixtHiE6y4oJC6kv3sXB7MTENjbTNtcWb1vaBwGZs1vNYaL72a4rU6Ta2to6lLTGiHQZS0moktQDfdaIYbeGIwI6zKlrtNY57wLB56g8E2yHmASJC7cLgcWYKdZ1wUDUr6gUzhUgrP65E0JlJ4ad8Ni55Q6DpYFWtS8DQZIgbEZJ8MuC5eOPSMVRrvdWaU0FyYdJNk94pDuI4V7P4Hy6ycx61BTB14ebIxpRludp42Ub+l4rQpUMY9NnDrhSqxE0Rf5Aa6VUrxNSswelnwOIY/rTMo+iLPiavcHmka/fEFK9oOPkbTdJfvKI68ivgNPBt8qkYjR72GEm3xfBqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mstAtaydgdb5TVDKmNC4xxtvUFcON3pUovuFusuzNSY=;
 b=ScuoCzzSFMhw9uPai5xJX0HalbHAh5uwwe7Shfwbgkn+1GVo+zHMnqZsj3mnhrvWjp/SaLR8u4Jr0u/Y12OwbFkQ8K5Tnb1Z/aMjIXe/YUPJLcibiPYIxk5ka7KFPZoHDLkspkJEw3cOiMkE08rfqeB4pLs8UTcnP/+sZ886dlO+kxEv4lPLd8xupRze/jardckjlHZhS5W21jLFT+MdcKJWDT8LjSwwmLEg776b4YqmXJ/r5aEezcyDrPVGF273lcu1u3LbQy4MUfDeSr7aMjebI/vYYZ/k66K9M8AFUCJy7MylWpFzXNcXX4DWqvH2+c31lWwmT1hq6M1ixC163w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mstAtaydgdb5TVDKmNC4xxtvUFcON3pUovuFusuzNSY=;
 b=zZQzyCDtFY/7PYfNKouF7wDn4x8IDoJ2XM4PmxbNa4MyGQbNX4rFSWpS1YCKzfAYaaFgLft4gvNddktQA48dbGl8FPLBnCy40XqncxiC9ZyplCbHpvZh6XykDvJh90MRSSg3MpbSfd+QHjxWKzcuRdinOE0ap/4AiyOxTTdp6sc=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by SJ0PR10MB6376.namprd10.prod.outlook.com (2603:10b6:a03:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 20:19:09 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:19:08 +0000
Message-ID: <101b74c9-949a-4bf4-a766-a5343b70bdd2@oracle.com>
Date: Wed, 22 Oct 2025 13:19:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
 <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
 <33a601cf-d885-424b-a159-f114c1d3e9c0@oracle.com>
 <4896ef05-da3f-4b41-8b76-0ec901ad569d@oracle.com>
 <f17f816b-959c-40e9-b0d0-80a0ff90dee7@oracle.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <f17f816b-959c-40e9-b0d0-80a0ff90dee7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|SJ0PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e380326-ecab-4a44-0dce-08de11a84194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkxqV2dySldIWU0xcU1hZFFaMFRhN3lwVVBKOUZ2RHdXUDVnYW9QOVlZL2pJ?=
 =?utf-8?B?aUJUZzZMZ3RJNHRoOEovZ2t0dms5SVcxdTN4eEFoY1dvYURaT1ZkWEdUVUZZ?=
 =?utf-8?B?RXcyQWlOZFU5VFBVRzQ2ak9RNlBGVEFJa2ZUdkErbjhUVUdiMVhCeitjamMz?=
 =?utf-8?B?K1k3OUZLMnE5aXFpOEhiMkJJVkMyZnVBNjNmUkhvSUUzM1hSZlhIY2F1eEJP?=
 =?utf-8?B?QSt1UWxGekFkcGJRQ2R4WGp1M2o4cWdhL25YL2hCcEtBb2Nta2R5UUNJdXdO?=
 =?utf-8?B?R284V3d4a2ZhUktXSXNrN2NMdzFwMElldlQzUHpoUWlZWHZFUFJuc25Ed3Vi?=
 =?utf-8?B?MlllOXZmUGZkc0cyOUxLWDJVNXMxNnZOQmVrWktoeFRzRXNqdUlGeE1XOXZI?=
 =?utf-8?B?L2VHOGtqNEZRQmpFczFheFNGV05UcWZ5OVNoREEzdUQrN24zK3lwTmJ3OVF3?=
 =?utf-8?B?VDJySVNLNG1sdUR0Q094a0g4Wit0UTBYK1QrdWprVUZMa3p0ZTRuWXpweTZS?=
 =?utf-8?B?eEU2ZkZ3dDZjQXU2WmFCb3FWMXM3d1M4WFJsaDNhUTc1cVVGbUZqQjJnaTln?=
 =?utf-8?B?YU5sQ1AvNkVOZTZETURZVmZOaUVFOWsxQnlTby9iQjFMSnljS3BhYzJpK0Zz?=
 =?utf-8?B?SXlQMERrWnVnWWpYeG9UYlNOM1NEWUdKTS8xK0w5K3NlWnBDaE9VclRRNU9X?=
 =?utf-8?B?Y3UycjlKWnU1UG5qbUg0SmhRNlhDTkxHOGw1TlNQUXRZaGZWUFRxR2dxdWRI?=
 =?utf-8?B?VlFBVzlveXBaZWJJLzlUbkZnZ1ZRVUVZclFvM2dVempLUXFIaDNTcSt3ZWlH?=
 =?utf-8?B?WG9xbUFZeTB1b3ozZ0lpdnA5WXdwR1Vxai9DYU84UDNZUGNra0RPSWI2WUor?=
 =?utf-8?B?YTBCWjlMRDl0TUduYkYraUI2WWFBOHhMTDVYc2ZkdWRwcENJYlVWbzloKzl6?=
 =?utf-8?B?cUpoT1A5UHdIY2cvQUczM3ExLzNpSU1pU3plT0JTTGE2T1ZweHg5SkwxREdY?=
 =?utf-8?B?czhHTlJKT0UvcDZwZ1J5YkhpaTdOLy9wTXNRcFNyYzljY1JwRXRrN1lhcWt2?=
 =?utf-8?B?RXJjcXFuczRNNU1QbDl3eHRWajZJT1h4ZzhuMFdISHI5Q2pmQXhNbHNtUkQz?=
 =?utf-8?B?Ym9ROEpPakQ5RHM5TEszWmtKN0F1QVNxSzlFdlFBUXE4RTJlU3dOMnJtS2Vr?=
 =?utf-8?B?NWRRejVDWmJLV1R1eFVtSXR2VCtZMmxSNVpwbTd0bXA5aVBMbm1lS216VXdK?=
 =?utf-8?B?MnJkbGZWMk1KTVlndVVHYkVKTnFnKzZ6T0lxMmM0VE5OUGpJaU80NVhwd2hB?=
 =?utf-8?B?ejlPeXBjTGd5dWpqTi9lL2orWE9BRnhabjlJSEpQR0hDTnRqU0trNk94eS9Z?=
 =?utf-8?B?ektha2tvYlNObkpXOW9DL0IxN0VFbExZMU0xTTBuVThTWnIzbTV4Qm4raFdB?=
 =?utf-8?B?NWpLdXI4V2NDQllzQUNiTHBzT2JpaEZMQTJsYWpodGxmbVZNS3ViUTF5N1NI?=
 =?utf-8?B?djljbmpYc0dCS3NmdkpiaHVsYW9NZmJYMFJhd3IyYlBGbnlubUlqNXVRLzV3?=
 =?utf-8?B?R3VpekY4RjhUbnNyTTE3VU9wOS9rbXRRRmlCZ3QweTdpR1prSnRMNE54UG5h?=
 =?utf-8?B?VGZZSG55eURGaEFCczBWNGZlRHVkZC9SRnV0SEVjb2xDVUY1MHExL1pIZ2l5?=
 =?utf-8?B?Ui9RbS9ucGhDQ1NUNllyakE1aUFLK2ZMWnZYZVF3WE51VlhHNWlXL3hMQkVX?=
 =?utf-8?B?UGFQM2wyN1VnRko3UktaSUVoektlcllpNS9yZVpCcUpOb3prRjhrU0JvWlh5?=
 =?utf-8?B?eStpNW1yWWR0V2ROVlFBcGlXSFVWRWxJajh5NUJTZWU4L1FGb2hHalJnUUlB?=
 =?utf-8?B?R0Vacm1zR0dldlpOOFVveFpGcFBNSFBXL2duWDNzTGtySDZ4K3RITjBZVGhB?=
 =?utf-8?B?UG1GcGw4d1o0cCsvWWdQazBtdldMTDUrRFhsV1oyd1BjaDhrak9aUGJ4WFRi?=
 =?utf-8?B?a0JSdzN2bGVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0lUVUVBN09Bc0pvMU03Wisyb1RIMitxWnFYSmlxVTk4RnpYK1Arc2loeXVI?=
 =?utf-8?B?RUxkV0ZMVHFkMVp4bjRWN0x4bjEzamNxNG9STWk0ZU1VWWh4Zy9VZUpGMGhG?=
 =?utf-8?B?WVZQSVc5eUc1b2I1bjhZWWhtM3JXRWlwalNNNzU2WUFlQUlGQ1hrS0lEZTc1?=
 =?utf-8?B?ZWdMSEY4SmpNY3daN2ZjRUR4MmlhL2NRQzI1WlJ5UmE1Q2owTFlWa1FMQTFn?=
 =?utf-8?B?VkNaVExwVEdFbzQvc1pNUkFDN1g0TGc3NjZuUSs1VUZKN3NpNm5Zek51TVk2?=
 =?utf-8?B?UzJqaVRqUGFOV0Z0RkdxUkxHcHBYZVNySmxEZnZpVkVsU3ZhUlNaMjZrWEt4?=
 =?utf-8?B?NmNRVDhQUjFRMG1rTXp4SVA3ZDdsZXBVSHNSYlc1SnBrSEkreFM1SGlERkNo?=
 =?utf-8?B?U0NhUzUydDNqcG9lUllLRW9qbThHSnJ6ejk1UkExU283eTlsRG55NWxJV0Vh?=
 =?utf-8?B?US9qcHU2cDVGZEhDSkxqak16OEx0b0VFRks2Wk5ESFBOMThseEtyd2IvTEc3?=
 =?utf-8?B?TldybmRSaVgvS3dlTjVWOVZNdE00dkdIdzVTRUlDR2FCZVVMWnUxdk92WGdR?=
 =?utf-8?B?Q0JNOEJSbTRjTmJJWHJoWXUydzBrRUE3TTZXbWliQUlmRVlOM0MyRE5zMjRJ?=
 =?utf-8?B?Vm1RclJ0eXpXTi80andJSkRPWE95UllhaGhuNzh4RzM1UDdBMkowQ3VLUHVV?=
 =?utf-8?B?K1k5QSs2a1lseDBPNW82OVJVbk91Q0htSVNLTGNHK01MZ2QrZXBDZXNBWGpk?=
 =?utf-8?B?NnptWWU1REdITFVpVWJDdjgyQ1JvbmVweXpCY1NoTGlmU1gzUGV0a0VaRytQ?=
 =?utf-8?B?ZldhampMMzZFalUwUVppWFZtOGZuZU9YVzc0aXJFSFVBSFUvdGhQRkZWZXlm?=
 =?utf-8?B?VmJuQzlkUHJMTTZZdzdYamlHNFowUDRFY2xDNGQxUzNhYVg0YkIzV3l5dGd6?=
 =?utf-8?B?bnNWQkt2dURqTmxpUkZvczFxQnZZMzVPemNOSkp0NGhPSm84STgrcnl3WkFa?=
 =?utf-8?B?WHV5RnJvWUk2WDFmWU1WUTNZM2NHZlJoQ0J4SWM0djhLOXBybHRXM1g3YVpj?=
 =?utf-8?B?a2RWOXRLOUxKUTUyQk54aDNaM0gxVTZLTUJQbEwyN3Era3pDanhIU25vSENt?=
 =?utf-8?B?QjdCK2JQRTk3ckdUYVgvMDNOT2tjWUtwenZjbDNiSDA3MllqS3B1N2swaFdN?=
 =?utf-8?B?ZmtXYlZKYUJWby9tNlF2V24yaWhDbk9UQ0xHcGVCZTB5NCt0Wkt6YmF5aDdJ?=
 =?utf-8?B?aWIwcTJncTEvZHF6K3JUaFFwOEI5L1NCUFhLTDErVGlxZ2hERFF4UXFmSFFI?=
 =?utf-8?B?WmNDWjREWTkyK1REZFlsVFVQSklDb3FoVHJYWWQ2bWpBNXI1c0o2ZjNFM2lV?=
 =?utf-8?B?b2JTdXR6eVFuQXhMU1dyN1h1WXN6WC9RS0gzR3dneFRPV0VXS20xZ05yNDhh?=
 =?utf-8?B?dUltaHg5eEZxaU9BSUZ4amFMSWUxREF3N0RqS2ppSTlWa3R4OGJsWWg0QUti?=
 =?utf-8?B?ZitUbnhHZUtaZnd1dVNwSnRPSjUrTi9GUGFHci95NG05U0cycDZOZE50c0h4?=
 =?utf-8?B?OG5GWnAxM0tIcGQxaDdLSWRIWkJYTXVzR0FGeml4UUpiOXZOaHByM2tFUEYw?=
 =?utf-8?B?UE05eEorS1VmMDN2TmJGeVN2Mk5INWlBVlA3WVBEbkVYYTJvdTFhckNFdjJL?=
 =?utf-8?B?T240Qm9KOFNVYURaU3JBN2kyNTkxZHkvK2tpTDJSbElqQVlGaldFRmVBaWxM?=
 =?utf-8?B?KzJLaHFrZTd5WHBtQW90RytWZXJQeitXM1FEQUgyZEVLdktFZ3lHZUluQlB6?=
 =?utf-8?B?SmpsaHIrY3NiUWs0YlkvczlRakw2UXFkbW9ZM0UxNWJDWmZTemY3bmVqN2RQ?=
 =?utf-8?B?MW84czRBSnA3Qm5UeXR4aUZnT1hhYWxSQnhFNTNOR2hEQm1kTG5NSloyS2dH?=
 =?utf-8?B?V2ZiUjJtZ3FwakhPTENjcWsyekJZOFo3amhoTi96NVUxQzJxRTJpVFNnLzV1?=
 =?utf-8?B?Rk5IcFFrNVowd012dXJHZ2xSQlJvSkpRRTl0UDlsaHRiV1l5SzgyOEQ1Z0Fi?=
 =?utf-8?B?WFRlT09BaE4yQkpqbWZQaDdhWkpkUlNlSUZINDQzTHo5L3RJb0toWWFTeXVX?=
 =?utf-8?Q?Tv0yLXdx2nDVwKFX5coSO3t6w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UFaAUVlDH2hcrK08Xhg5uSfRH1rOaBTZoA6iMF54uogJS0k5ZaYIEj5zXirvLS6e/pmyec1/iizPE78HuU/ocmQfKys53VUbG/OS8XwoTqc5vnvv+uYOA/gOx1QhCbWBJrM2H0jrOYGeXSIPA/pUjXKzx+2lr2OMGgUDD1RX/NzL4Pd0LdffJ7YIHSPN2wER4iJOfQTkypjA2OmBzH3L3KyQY8kWC5xrPwbXcNoYHYJOV6RvVGbppJ0ymMeZj4ICK4bOX07MNc/uqYfp6L2NTrdxDA9Vuasf5raKnP2w3iXV4cwRw7s7194ksIAW4bYeNn5BxvTG2MvnfAeA/9+CmBmlQbMUOrL66Lz/G/1dAOL8dY5DwLiE0RdNG/Mm8P7boSlirJ3nNq3enwTmK/uOLFKGJv+sYM2hhK17zuUF9LQ4V5tncmW2n5cjRpqKaSyDDntOkQDkcW1j1ieU8S5kCi5kqhOf3eV4V6nZUzRmHS+MV6Z9mzIkdK/ikQj2h5BID/dG8Q6M+AWk4rLBdkXZFvX/xgP3z3tSUyT9MJUI+K12AF9yTGvvjFm/D38ojeIyBtJktS0WWBg3ra+VQdJIYuXV78tTivn7UghntgfqQjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e380326-ecab-4a44-0dce-08de11a84194
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:19:08.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTTo7sGUoPFYmLPt/OsZT68ZZJf8YNZwL03daTwNhzs/GFYTbKgO7dwx7Ie5mia8024doqXZqTFyIZebiKYMkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510220167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX5oZ9+F7AJAV/
 qH6VEf9br/HOzHBDEEGyD0msiat2PpT7HVEsml8z+qPvA/M5tOcjraSHgpMnxS6GXI7jdmTgAF4
 UotwW8ZLdWlwbPftxuf9aKAWE84y/yICKt+pqz1s5XTvUg4QN+RWvVmMphQmxmr/ATE7M8apLPU
 Qa/U4t0L0INhWpwZwIbIsEqy+25pmAsR5HAwPM2KwaIWb+NZUI657TGCtMXreXbUWNmGLoCNnRr
 vCTQSxA5BcPXk1dMzkofv4OSqIzRSWlwBCW8lRG3EMGSVgD8A5GedjZn2JRYV6cSylbjIGHfvhh
 QOH5X01v3hrIGJDfWDBCVubzpZvcx9/eNHDb+ox814m/NQVyu/d+r1zvu3JT7gO+oypRqIIBdwB
 sZFrDKEVmJUEJFOTlEw3QvcJuqjfJSeKsgGtD29VWyOO93Gvd+Y=
X-Proofpoint-GUID: WQt3B_obOqgBvk4fxfLNxw9XrMcIHIGZ
X-Proofpoint-ORIG-GUID: WQt3B_obOqgBvk4fxfLNxw9XrMcIHIGZ
X-Authority-Analysis: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=68f93c42 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=2QkOEfLaE59DAWe242kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12092



On 10/22/25 02:23, Alan Maguire wrote:
> On 20/10/2025 21:44, David Faust wrote:
>>
>>
>> On 10/20/25 13:11, Alan Maguire wrote:
>>> On 20/10/2025 17:01, Yonghong Song wrote:
>>>>
>>>>
>>>> On 10/20/25 3:53 AM, Alan Maguire wrote:
>>>>> On 03/10/2025 18:36, Yonghong Song wrote:
>>>>>> In llvm pull request [1], the dwarf is changed to accommodate functions
>>>>>> whose signatures are different from source level although they have
>>>>>> the same name. Other non-source functions are also included in dwarf.
>>>>>>
>>>>>> The following is an example:
>>>>>>
>>>>>> The source:
>>>>>> ====
>>>>>>    $ cat test.c
>>>>>>    struct t { int a; };
>>>>>>    char *tar(struct t *a, struct t *d);
>>>>>>    __attribute__((noinline)) static char * foo(struct t *a, struct t
>>>>>> *d, int b)
>>>>>>    {
>>>>>>      return tar(a, d);
>>>>>>    }
>>>>>>    char *bar(struct t *a, struct t *d)
>>>>>>    {
>>>>>>      return foo(a, d, 1);
>>>>>>    }
>>>>>> ====
>>>>>>
>>>>>> Part of generated dwarf:
>>>>>> ====
>>>>>> 0x0000005c:   DW_TAG_subprogram
>>>>>>                  DW_AT_low_pc    (0x0000000000000010)
>>>>>>                  DW_AT_high_pc   (0x0000000000000015)
>>>>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>>>                  DW_AT_linkage_name      ("foo")
>>>>>>                  DW_AT_name      ("foo")
>>>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>>>> deadarg/test.c")
>>>>>>                  DW_AT_decl_line (3)
>>>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>>>                  DW_AT_artificial        (true)
>>>>>>                  DW_AT_external  (true)
>>>>>>
>>>>>> 0x0000006c:     DW_TAG_formal_parameter
>>>>>>                    DW_AT_location        (DW_OP_reg5 RDI)
>>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_decl_line       (3)
>>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>>
>>>>>> 0x00000075:     DW_TAG_formal_parameter
>>>>>>                    DW_AT_location        (DW_OP_reg4 RSI)
>>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_decl_line       (3)
>>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>>
>>>>>> 0x0000007e:     DW_TAG_inlined_subroutine
>>>>>>                    DW_AT_abstract_origin (0x0000009a "foo")
>>>>>>                    DW_AT_low_pc  (0x0000000000000010)
>>>>>>                    DW_AT_high_pc (0x0000000000000015)
>>>>>>                    DW_AT_call_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_call_line       (0)
>>>>>>
>>>>>> 0x0000008a:       DW_TAG_formal_parameter
>>>>>>                      DW_AT_location      (DW_OP_reg5 RDI)
>>>>>>                      DW_AT_abstract_origin       (0x000000a2 "a")
>>>>>>
>>>>>> 0x00000091:       DW_TAG_formal_parameter
>>>>>>                      DW_AT_location      (DW_OP_reg4 RSI)
>>>>>>                      DW_AT_abstract_origin       (0x000000aa "d")
>>>>>>
>>>>>> 0x00000098:       NULL
>>>>>>
>>>>>> 0x00000099:     NULL
>>>>>>
>>>>>> 0x0000009a:   DW_TAG_subprogram
>>>>>>                  DW_AT_name      ("foo")
>>>>>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/
>>>>>> deadarg/test.c")
>>>>>>                  DW_AT_decl_line (3)
>>>>>>                  DW_AT_prototyped        (true)
>>>>>>                  DW_AT_type      (0x000000bb "char *")
>>>>>>                  DW_AT_inline    (DW_INL_inlined)
>>>>>>
>>>>>> 0x000000a2:     DW_TAG_formal_parameter
>>>>>>                    DW_AT_name    ("a")
>>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_decl_line       (3)
>>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>>
>>>>>> 0x000000aa:     DW_TAG_formal_parameter
>>>>>>                    DW_AT_name    ("d")
>>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_decl_line       (3)
>>>>>>                    DW_AT_type    (0x000000c4 "t *")
>>>>>>
>>>>>> 0x000000b2:     DW_TAG_formal_parameter
>>>>>>                    DW_AT_name    ("b")
>>>>>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-
>>>>>> change/deadarg/test.c")
>>>>>>                    DW_AT_decl_line       (3)
>>>>>>                    DW_AT_type    (0x000000d8 "int")
>>>>>>
>>>>>> 0x000000ba:     NULL
>>>>>> ====
>>>>>>
>>>>>> In the above, there are two subprograms with the same name 'foo'.
>>>>>> Currently btf encoder will consider both functions as ELF functions.
>>>>>> Since two subprograms have different signature, the funciton will
>>>>>> be ignored.
>>>>>>
>>>>>> But actually, one of function 'foo' is marked as DW_INL_inlined which
>>>>>> means
>>>>>> we should not treat it as an elf funciton. The patch fixed this issue
>>>>>> by filtering subprograms if the corresponding function__inlined() is
>>>>>> true.
>>>>>>
>>>>>> This will fix the issue for [1]. But it should work fine without [1]
>>>>>> too.
>>>>>>
>>>>>>    [1] https://github.com/llvm/llvm-project/pull/157349
>>>>> The change itself looks fine on the surface but it has some odd
>>>>> consequences that we need to find a solution for.
>>>>>
>>>>> Specifically in CI I was seeing an error in BTF-to-DWARF function
>>>>> comparison:
>>>>>
>>>>> https://github.com/alan-maguire/dwarves/actions/runs/18376819644/
>>>>> job/52352757287#step:7:40
>>>>>
>>>>> 1: Validation of BTF encoding of functions; this may take some time:
>>>>> ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
>>>>> sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''
>>>>>
>>>>> Further investigation reveals the problem; there is a constprop variant
>>>>> of ip6_make_flowlabel():
>>>>>
>>>>> ffffffff81ecf390 t ip6_make_flowlabel.constprop.0
>>>>>
>>>>> ..and the problem is it has a different function signature:
>>>>>
>>>>> __be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
>>>>> flowi6 *, bool);
>>>>>
>>>>> The "real" function (that was inlined, other than the constprop variant)
>>>>> looks like this:
>>>>>
>>>>> static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
>>>>> *skb,
>>>>>                       __be32 flowlabel, bool autolabel,
>>>>>                       struct flowi6 *fl6);
>>>>>
>>>>> i.e. the last two parameters are in a different order.
>>>>
>>>> It is interesting that gcc optimization may change parameter orders...
>>>>
>>>
>>> Yeah, I'm checking into this because I sort of wonder if it's a bug in
>>> pahole processing and that the bool was in fact constant-propagated and
>>> the struct fl6 * was actually the last ip6_make_flowlabel.constprop
>>> parameter. Might be an issue in how we handle abstract origin cases.
>>
>> Yeah, I think most likely 'autolabel' was const-propagated and *fl6 is
>> the last real arg as you suggest.
>>
>> I'm not an expert on the IPA optimization passes, but I don't know of
>> any that would reorder parameters like that. 
>>
>> OTOH, I see a few places in kernel sources where ip6_make_flowlabel is
>> passed a simple 'true' for autolabel.  That sort of thing will almost
>> certainly be optimized by the IPA-cprop pass.
>>
>> Note that you may have _both_ the "real" version and the .constprop
>> version of the function.  IPA-cprop can create specialized versions
>> of functions so places where a parameter is a known constant can use
>> the .constprop version (where 'autolabel' has been dropped) while
>> other places where it may be variable use the original.
>>
>> IPA-SRA (.isra suffix) can also change function parameters and return
>> values, but afaiu it does not reorder existing parameters.
>>
> 
> Thanks for the additional info!
> 
> Looking at the specific case, here's one instance of the inlined
> function's representation:
> 
>  <1><be25126>: Abbrev Number: 35 (DW_TAG_subprogram)
>     <be25127>   DW_AT_name        : (indirect string, offset: 0x3bce6f):
> ip6_make_flowlabel
>     <be2512b>   DW_AT_decl_file   : 3
>     <be2512c>   DW_AT_decl_line   : 952
>     <be2512e>   DW_AT_decl_column : 22
>     <be2512f>   DW_AT_prototyped  : 1
>     <be2512f>   DW_AT_type        : <0xbdef11c>
>     <be25133>   DW_AT_inline      : 3   (declared as inline and inlined)
>     <be25134>   DW_AT_sibling     : <0xbe25187>
>  <2><be25138>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>     <be25139>   DW_AT_name        : net
>     <be2513d>   DW_AT_decl_file   : 3
>     <be2513e>   DW_AT_decl_line   : 952
>     <be25140>   DW_AT_decl_column : 53
>     <be25141>   DW_AT_type        : <0xbe019b0>
>  <2><be25145>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>     <be25146>   DW_AT_name        : skb
>     <be2514a>   DW_AT_decl_file   : 3
>     <be2514b>   DW_AT_decl_line   : 952
>     <be2514d>   DW_AT_decl_column : 74
>     <be2514e>   DW_AT_type        : <0xbdfd253>
>  <2><be25152>: Abbrev Number: 40 (DW_TAG_formal_parameter)
>     <be25153>   DW_AT_name        : (indirect string, offset: 0x10853):
> flowlabel
>     <be25157>   DW_AT_decl_file   : 3
>     <be25158>   DW_AT_decl_line   : 953
>     <be2515a>   DW_AT_decl_column : 13
>     <be2515b>   DW_AT_type        : <0xbdef11c>
>  <2><be2515f>: Abbrev Number: 40 (DW_TAG_formal_parameter)
>     <be25160>   DW_AT_name        : (indirect string, offset: 0x3bcc9e):
> autolabel
>     <be25164>   DW_AT_decl_file   : 3
>     <be25165>   DW_AT_decl_line   : 953
>     <be25167>   DW_AT_decl_column : 29
>     <be25168>   DW_AT_type        : <0xbdef194>
>  <2><be2516c>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>     <be2516d>   DW_AT_name        : fl6
>     <be25171>   DW_AT_decl_file   : 3
>     <be25172>   DW_AT_decl_line   : 954
>     <be25174>   DW_AT_decl_column : 21
>     <be25175>   DW_AT_type        : <0xbe100ac>
> 
> 
> And here's the abstract origin reference to it which I believe causes
> the trouble:
> 
>  <1><be2708c>: Abbrev Number: 205 (DW_TAG_subprogram)
>     <be2708e>   DW_AT_abstract_origin: <0xbe25126>
>     <be27092>   DW_AT_low_pc      : 0xffffffff81ecf390
>     <be2709a>   DW_AT_high_pc     : 0xa2
>     <be270a2>   DW_AT_frame_base  : 1 byte block: 9c
> (DW_OP_call_frame_cfa)
>     <be270a4>   DW_AT_call_all_calls: 1
>     <be270a4>   DW_AT_sibling     : <0xbe27268>
>  <2><be270a8>: Abbrev Number: 7 (DW_TAG_formal_parameter)
>     <be270a9>   DW_AT_abstract_origin: <0xbe25138>
>     <be270ad>   DW_AT_location    : 0x18ed328 (location list)
>     <be270b1>   DW_AT_GNU_locviews: 0x18ed31c
>  <2><be270b5>: Abbrev Number: 7 (DW_TAG_formal_parameter)
>     <be270b6>   DW_AT_abstract_origin: <0xbe25145>
>     <be270ba>   DW_AT_location    : 0x18ed363 (location list)
>     <be270be>   DW_AT_GNU_locviews: 0x18ed359
>  <2><be270c2>: Abbrev Number: 7 (DW_TAG_formal_parameter)
>     <be270c3>   DW_AT_abstract_origin: <0xbe25152>
>     <be270c7>   DW_AT_location    : 0x18ed399 (location list)
>     <be270cb>   DW_AT_GNU_locviews: 0x18ed38f
>  <2><be270cf>: Abbrev Number: 7 (DW_TAG_formal_parameter)
>     <be270d0>   DW_AT_abstract_origin: <0xbe2516c>
>     <be270d4>   DW_AT_location    : 0x18ed3cb (location list)
>     <be270d8>   DW_AT_GNU_locviews: 0x18ed3c3
>  <2><be270dc>: Abbrev Number: 16 (DW_TAG_variable)
>     <be270dd>   DW_AT_abstract_origin: <0xbe25179>
>     <be270e1>   DW_AT_location    : 0x18ed3f6 (location list)
>     <be270e5>   DW_AT_GNU_locviews: 0x18ed3f0
>  <2><be270e9>: Abbrev Number: 55 (DW_TAG_formal_parameter)
>     <be270ea>   DW_AT_abstract_origin: <0xbe2515f>
> 
> So what you see above is two things. First the order of parameters is
> not preserved; specifically the original function and inlined function
> representation it is
> 
> net, skb, flowlabel, autolabel, fl6
> 
> ...while the non-inlined references via abstract origin has order
> 
> net, skb, flowlabel, fl6, and finally autolabel (with a DW_TAG_variable
> inbetween).
> 
> And secondly what's interesting here is that the other parameters all
> specify locations while autolabel does not.

I think it's important to be a little careful, the actual inline
sites shall be reflected by DW_TAG_inlined_subroutine DIEs as direct
children of the blocks where the inlining occurs.

The first subprogram DIE above (be25126) is the "abstract instance"
reflecting the source code, and the second (be2708c) is a concrete
instance reflecting the ".constprop"-suffixed specialization of
ip6_make_flowlabel.

The autolabel param in the concrete out-of-line instance lacking
location information indicates that it has been const-propagated;
it is no longer passed at all (see note on AT_location below).

I think this case falls under what is described in the DWARF5 spec
as "out-of-line instances of inlined subroutines" sec. 3.3.8.3.

> 
> The problem we have is that
> 
> 1. pahole does not attach any significance to reordering like this and
> does not detect it as far as I can see (I've also observed similar
> patterns in inline site representations where order differs from the
> original abstract origin function)
> 
> 2. pahole also does not enforce the need for location info for a
> parameter (implicit assumption being that if no location is present it
> is in the usual calling-convention-dictated place)

This assumption seems incorrect to me. Based on DWARF5 sec. 4.1:
4. AT_location "describes the location of a variable or parameter
at run-time.
If no location attribute is present... or if the location attribute is
present but has an empty location... the variable is assumed to exist
in the source code but not in the executable program."

Note the second para uses "variable" but based on the context I think
that it applies to parameters as well. i.e., missing AT_location
does not mean "in the default CC-dictated place" it means the
param is not actually being passed at all for this concrete instance.

This is also reflected in the formal_parameter lists of
DW_TAG_inlined_subroutine DIEs representing where the actual inlines
occur.  I would think pahole should check every inlined_subroutine
to see whether that inlining has elided formals.

DW_AT_calling_convention indicates whether the subprogram does not
obey standard calling conventions.  Not present is equivalent to
"CC_normal" - i.e. obeys standard calling conventions (3.3.1.1).

> 
> The combination of 1 and 2 leads to the problem observed.
> 
> The DWARF spec appears to mandate source code order for parameters but I
> couldn't find any equivalent mention of abstract origin parameter
> references.
> 
> From the above empirical case and others it _seems_ like the ordering
> _is_ meaningful in cases like this. How we extract that meaning without
> breaking other things is always the challenge though.

I think the ordering and absence of AT_location are interrelated.
In general:

"1. An entry in the concrete instance tree may be omitted if it contains
only a DW_AT_abstract_origin attribute and either has no children, or
its children are omitted." (last page of 3.3.8.2)

If a param like 'autolabel' is optimized out so it has no AT_location,
then there may be nothing left except the AT_abstract_origin and it
could be omitted.

I do find it odd that 'autolabel' is present out-of-order with only
AT_abstract_origin here.  I think the more reliable info is that
it has no AT_location in the concrete instance, meaning it's been
optimized away.

> 
> I've started experimenting with detecting location misordering in
> abstract origin references in the work-in-progress location code since
> it does more extensive parameter location handling. There are a fair few
> instances of misordering detected, especially for inline expansions it
> seems (likely due to more frequent argument omissions at inline sites).
> I'm hoping detecting misordering combined with enforcing location info
> for misordered cases might be enough to detect and handle cases like
> this, but as always the worry is other stuff gets broken as a
> consequence. I'll report back when I have more data.
> 
> Alan

