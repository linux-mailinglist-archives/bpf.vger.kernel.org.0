Return-Path: <bpf+bounces-71179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF6BE73DF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E188F4F23EB
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071E129D279;
	Fri, 17 Oct 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODBX+Uh4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gXIZZOB3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1525F984
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690667; cv=fail; b=Q1qb3I9Dxyk/PXg4CzV0jZKZ8yszqV9X1dFXK4V9bXvh/jdKygI/sPWjn3UhsBSydXEiiJPL0POqb1aMuQgLBash/Uf1QOOYIFAlwbYlBy9LopggsQsi0QDqLUGvoNXP09Csysl5SrMi99djxrDstXmLIPzDXOaBd9BX/8xAabg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690667; c=relaxed/simple;
	bh=/UGdFPO0oy+xHznqjaS4/mjBNmeavbxHOSbEdRucynA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lOe97TQcKq0QVqYhQx/jyDomeIjL1MqnR6Dhk36cW3t2HklJCYCZ7VviiD9Hf9vDuVOZVmuQnPoyAWs2ZwWSi5Dhnr+gKD1C17K32l1U4fPaCZXTtZJeYLqUDC7Kkckct4j+vjXZ2U+UfuCYCwuLsgKGqJX3JytSkPl4xk93UIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODBX+Uh4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gXIZZOB3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uJND017716;
	Fri, 17 Oct 2025 08:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eNAzj4d5W0+O1u6y8EY1bh7vXXQZskbpJxZAnA+ih/4=; b=
	ODBX+Uh4d6sS0Gtf8L4zvCVCs7gmP+SSWhiSdGkMXksxoeA1aPcLk4+Br0B4/asa
	WxIJuGAgoWPQ0frFrksUP+VZRDmF5CyPWVx1F6KWuxHmS/k6e1IiW/wtuuTYw0+o
	GFQdsjQMMP11WtyPh9WTTk0VmX7UvYHRD8uwOlor509EtOQN+IsccEyJccmhSfv9
	B4sHlcYdFl+eP/yzGU8UEH07bpLd/Mil7G7Eny1I5dbYc2sz2n8L82o3WAJxM+yH
	MLceDugv/8V+FGTxMk8k0YPwXU+U9+u2JZz1d1TTN5N6PWRWafPkWVf76bV2FxUn
	07ItSXRjNX1BpFx3KuuGKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59jk98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 08:43:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6wlHE024919;
	Fri, 17 Oct 2025 08:43:52 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpct8ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 08:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBExGsXhKoiAcqf79fd6vYZRtc4rXP+vyzeASxcl11xfR4cRyuRvMdprxEiZSCz9sfJIUzmt6Bw0PgTEMOMIso1CXRayunS6R+ghqlhMrRKKwHpg5a6Xp1Qw/fLASJ5YEhFZmEfgDUI3AY2m4KxUlwvSjHm38NwiMSTa02t7mFK0/VH6/Df2aGKkDdIE0kya0K9ljhoMBwgBsHlwjB7AAg41AYj/pBnZ+PgET5fIzDhI0cxyKmx/3/8I6LaOvg7aWp+/mAXaxJgBrmj51K34iqZwSnMnhOPEhI2JQ9xAARG9RfHbLDkHPxfgDvI2QsP7Qaarc7LllFnkuYyMEQp9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNAzj4d5W0+O1u6y8EY1bh7vXXQZskbpJxZAnA+ih/4=;
 b=CBFwGFIXsgvD8HG7tUHLxa+Vmb4j2RoPMVyM+DH4iiVf78iwqHmH6q9bJEBIwjz0e4v2H3dMDUgV18P8Btc8wGRNeDSBvTpR7tOPaG6Q+aJSSzafbqzhP2hx0QAm5P05xvwfvsWx2JsbUhHOlUZZ9OWdAgOS7MfHZ5awwG8IvNox28sNjjt56vPkyBsx3mCOyT4eK+N44ccEFky945zU/dP3r05z+ObLPg/PvUf8ih1/OpVeRts+97b15ViQaXDZ5Z8O8PcqAvM+cabXUHvswCWRmGIsMOeaqHvtvucltDAqSd1YBGzyZfO+aK8T9gp+4lJ/1ZEDjNHX2czpc7f0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNAzj4d5W0+O1u6y8EY1bh7vXXQZskbpJxZAnA+ih/4=;
 b=gXIZZOB35tnEkmNUbfvYkKfAtQd3NaJgjrzefCd7vubjluOue6rzr4dxEdUyoisFevzxebN+nSBhMlN+5K0DP8cZ7c2CG+fHL7ktDf5+d3c1cM/B+P/F1RPh1xGcBE1h49+FKckhO+xkQdd0e05S4I+RJ6qCxcAABnfJ6AMzNEk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 08:43:49 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 08:43:48 +0000
Message-ID: <f2e1fd61-7d3a-4aa6-9d36-a74987d040fe@oracle.com>
Date: Fri, 17 Oct 2025 09:43:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location
 information
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-2-alan.maguire@oracle.com>
 <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9df121-6443-4fae-a709-08de0d594a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE15eU1wa2cyM1FqZGhlOEFXdXEySitZdmZQQ3dka0xnZVZrU2toZ3lIdklI?=
 =?utf-8?B?ZEVOQ1owQkFqR005UVRKbDhJdTBFMnZweEMxcGN1Ty8wc2NhUXZpRm56R0c2?=
 =?utf-8?B?ZEJoSFE1MzRDbEZHcDVUUmMxT0lqblpZc3dNQjliVXdwa0VkdkFSN1grV3FX?=
 =?utf-8?B?TUJrbisxOWorQjFNMDRjNVRDeCttMDVMTGhWd1JlUWMzb0UvVnNMVXJRZEdZ?=
 =?utf-8?B?MXByUUF6NWZjR0pCVWYrK2tzeWFIWEE5NEgzekJBNlk2UzhFK2JPY1VWZ3Nt?=
 =?utf-8?B?ZEJZVFVmUzk4cVlQSGhRdWk5N0IwMVZOdEF0NFkyRnFVck1oMXdDejEwRmpm?=
 =?utf-8?B?dFAvbEdmY1dQVDVuNTZjc3dicGdxc0NjY2hZM2EvUkFvQUhxTGxLcE9nUGVN?=
 =?utf-8?B?Qzc5eXhXSkZzSlNXZ3oxaTdQb0dOWmR2cDV6MWd5eU56RlFGMURNT1VMZHFy?=
 =?utf-8?B?emxPVlN2QWNlZnpQNUpCdk1BYm02UzZOS040OU16MTB4Q3c4K3Rlb25yNUk1?=
 =?utf-8?B?N0lWVnpDVTA3bk9uQlZXRkJqb1ByQWhWWmIzbVlybmZTVzNzSnEyRU10U0Ft?=
 =?utf-8?B?Q2hHbVBEdXFRUXU2ZUltTE5MYWQ0ck0vZTg3cnRUUU12RjBINFdTZnQ5SzQ4?=
 =?utf-8?B?dWszb3BCYm5MOWNndzFVbFAvRE02REZ1NXdNaytreFkybEJBcGZ3cHl4VUJ0?=
 =?utf-8?B?MThKYW92K3FSTG9MaXBhSFIvNHBKNVY3SVVrR25meDVXbUF6K0lCNXJ6NVUv?=
 =?utf-8?B?Y2tWWi9uVXlCbGRBMkl3bktBejhIV0JRemtGY21CcElGUG9EYVFEZHRWQ29w?=
 =?utf-8?B?K1F0RlBtWXg0TUluL1VPZmdCL2ZaRnB4T1c3TlNLRGt4OFdzdlhxWE1hY2tI?=
 =?utf-8?B?Q0RsdkkwRWpnMnU3WE1KNTVsbjFSa3pncXIvV3JHTU5UaTlHeDRhU3lzZURH?=
 =?utf-8?B?ei9rbk4wcGswQVE2SHRBNWdtU2E1WmlCT3RkRW9aNzhLWjFOYWIxZzYxVy9W?=
 =?utf-8?B?WDFISGlaWStVdmtrZUxibEJESlBmSWhFMXFIYXFLdXpaY3lERjBKMTNDUDIv?=
 =?utf-8?B?UGFOWks3Tk1uV245R3VCVEpBejl6UFVITFRGT0x4QXdOZ3Q4eVpJTFRlZTFD?=
 =?utf-8?B?dTh4RVQzaitjTHFCMnV2TmMraHJVWjNlaERZVStFUDVjZnlzVG92SUQvdzRw?=
 =?utf-8?B?bDExczh2aFQyWTY2QVRhT3BJbVBKUGZneDJhbksxM1pQd0ZMVmFaZmdBbFhm?=
 =?utf-8?B?ZUp1N2grYUlHT1UzYWluV29wZng0ZGdSc05WVzNYWHRuUzZUTmxpWHkrd2pq?=
 =?utf-8?B?S3JPYVMyVGRzcjNtRHBabHlYS1RGa0Y3TEJkMVBRUXRDU2NDUldZNmVHZEpU?=
 =?utf-8?B?K3I5Q2dLU0U2SWFnd1JEUjRNS2d1bWdQMXIwL1YrVWVyTVI0UzJzbSs4MnRL?=
 =?utf-8?B?bmtzRDU4bGZ5WHZQbldVZzUzeEMvU2ZyZFFiRTRKeFp1dmFQd2duRDNzMzEr?=
 =?utf-8?B?c1prSW1KNm9FS0lHeW5iTVh0cnI0bHFRdjc4LzF6WS94T1J6a0lNOEtrYVJv?=
 =?utf-8?B?Q2xJK3F3Rk1iT3ZLVHQxcU9WV29XR1ZKUDh4RlAvRjZDT2xJRHVnc1JsKzEz?=
 =?utf-8?B?ZElWSzU0TTlEZ3FveU5OMDM5dHZDT1BVT3VoY2hNOG1USWkwMXZuVFBPazMy?=
 =?utf-8?B?WmRmOE9jZ2ZlSVVoU3doc0Jubll2WjlFQks2M0xhSTl0SzBIOS9wZGVwN1Nw?=
 =?utf-8?B?YlVMWG9hQTJzTWVsZnpZeWRrNVRRNXRyMy95MzN2Z1NIWGZVMTh5WmZCeTNQ?=
 =?utf-8?B?SFM0SWQyZFY1OXRqQ3ppMjh3b3pzYVMxOC9MNHlZdmlCSjdQNlRPakIyeDBD?=
 =?utf-8?B?ZlBNaUdHM0lxSHppYi9mdGJxZGRZRW5DWmt0Z1FxenhUaW1VTE96NGtsL2lT?=
 =?utf-8?Q?Bw8M0MWLcssOOarSiVkJxfV6jW2uNjbT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUdRT1hBSzlCOVRoM0wxOVNsdUJtR1dzQzFlS0VucTJuMU5xSGdycFBObU9K?=
 =?utf-8?B?MGNaa2xMdXNqNDQrYmdZRkNaendMWlp4RGdDOTkwWUV5M1EwVzRBUnpEV3Vw?=
 =?utf-8?B?Y0hZcnNnYjNSOHEzWXJ3K2RvV1RZenBPT29yODlTQ1k5aVAvUWNYQlJLYVdF?=
 =?utf-8?B?d2lmcGtDSDhROXNCclAyaVZIakR0dG5qMVZOZENXbVZrb2hOZ1QyalNITnFI?=
 =?utf-8?B?MDZGNGVOTjNhdmhkNXEvc0hleUJwSXZtMW9zQzdGWEhiN1hWYjZFNGpUZlpT?=
 =?utf-8?B?UzFKc0xuNkRpT2dkUGZVeWNTRlpLckJmd1lOZ2ovVnk2emVBcCtpd0lqT0Ur?=
 =?utf-8?B?RDl5bnd0VzJNUkNXTE9vajNjWXBhbkduMVMyQW13Tll0bE5nVGdqWU1TYXZy?=
 =?utf-8?B?SFVvYks1cWJDWk84MUxwT2RTUXpkZ3JSVVNrN3FwUHEzR2pJbUZqWk9uVE9L?=
 =?utf-8?B?azB4UHpPOTN3SXlsWEg0eXAwKzRFUjVsdWpCeTg1NGR2TmNmdTU4cWxaOWhw?=
 =?utf-8?B?enhIdWY5Z3dMY2lpSFl3bUVtUGU2VkVpbXliNEkvdzVtMEIxV2JDTmlVa2RZ?=
 =?utf-8?B?N3YvdS94RDFFQ3F0U0xIenkyRE5zbEc4S2ZNYUxYbThaK0c4MDVrY3hlYXpE?=
 =?utf-8?B?TUc5TW03a1REL3YzNS9LRzdhNnlHdmdxY2g4aVNIdHkzWFNlSFhNSXJ5cTcr?=
 =?utf-8?B?dE9QRVNLUU5GWkt1TVNLTjB3STlsN3grTk9zbWZYaytqMFhKNUdmclUyaTlw?=
 =?utf-8?B?VTZweXJIVVpJaVpmSVNuWFhXS1JQZzRmZ2JlalFRZFc0ZW5QTVExWTRNYnkx?=
 =?utf-8?B?SmU0Q1U3MXl2WG0zS2RCSzZKeHlORmw5Uk5sdlZnSnozTjYwby9YUjQ4bkxL?=
 =?utf-8?B?VDN1bHZnQVViOE9OMlhTd21XL0RQajVDK0lWMUNEcFBnbDJ4TU5TS3hKd0hM?=
 =?utf-8?B?QlhpS1A3T2l5cnY3UlhHTHlFWWY3U0RCWS9nY01oNlNXNklEVFBTMFkyaWdS?=
 =?utf-8?B?UkxtMjJaZkwxbldpNEMyQlhWOWFsbGk4V3N5UGUzRGN1U0paaWFvSTdBcmV6?=
 =?utf-8?B?TlRtSlFmR1pyU1JoUGZSaUtpRCtqa2p1ZVRRZno4NzFJZUJxeDRCNW5TUEdz?=
 =?utf-8?B?WXlHNzFqeVBLNXNpLytpU0RUSENGWnZtYi9WMkxHb3hLNlNlTXNWR2dZS1BL?=
 =?utf-8?B?S2R6U3JFR2F4Z2FBekh6a3prUVpBZ2dlWVRrNjV2d1BlMXkxVitDMXhFWDhX?=
 =?utf-8?B?L2EzUk9tamlsVWlRME1uSzR4cDJMZ1k3dnY2SXpIdkx0Ymw5QkliWjl1N09L?=
 =?utf-8?B?T1FQTURGb3RqTWp4OGJtNWZsc1dNYXNMaFRzODhvMWREVjdkUzRod2VPZWhP?=
 =?utf-8?B?amdJek1XTzZCL3J2a1ZIaFhZaDVmUnZ2d0FMdEFpNFJpQzg1a0l5T0lWNmJ6?=
 =?utf-8?B?Q0Rwc3FTbjl6eU1uYXB6amx1QTA5K1czN2tSMVpQd3paL1hySVlyeC9ONVFF?=
 =?utf-8?B?V0lNOWlGUnFyaWR3bWhlRXdHVFhrT3BncTNwaFdpbjI0dDhBcjRZRnNKbGFL?=
 =?utf-8?B?MFhEVGxBRXFHYWREOFp2Q3duRnM1SGIvWndqdFVRbjFJS2k5L0ZTMEp3Vnh4?=
 =?utf-8?B?V0hBR29OYS9ydkE4UzZiRzRraEVtckRLRVJTWmlNdXVkYzJEVE9vdXJKWENk?=
 =?utf-8?B?WHVxVXkzNWJJM3ZDYkptbS9jYkY1L3FGS2FLc0tlQldLZ1VhWVplMHJMQkVL?=
 =?utf-8?B?aVExTXEwRnE0c0pldEw5R3RaYUJJZDAxdEgyV2p3NnBQa2lka3ByNzI5ZEcw?=
 =?utf-8?B?RjNDbXUyb0V3WExDeWhmZFZ3TW5ieWJHdmFheDA0TTdxdy9CQ1E4ZVlmbzh5?=
 =?utf-8?B?MW4vaytNK1RvaEdFNnpyVi9yVTVvdFdUVmRrM0JrWWtyL3U2aFJJd3hkeDF6?=
 =?utf-8?B?R01TVitRSlU1a09uRCtrMkhvR09UazJINy8wTERYUFlDOWJFNzBGL1h3NWFQ?=
 =?utf-8?B?WkdnVXl0elRFQ0FlNVV1ZkoxYUcrbXRVTVFKT0t6Z3dUOElCd0tYcnhrcnY1?=
 =?utf-8?B?L0h2K3hqZGF1NUdZYnFRc3VxQnJUVG9qUUFlZXRuWHN0QTBOb1JFSHkyTnlz?=
 =?utf-8?B?dXd6M0JrSEFoOUZoTThkRkVyZlFRKy9PV2RWdE1ZTk1YZFFuNk9FNWhQUzBt?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qgY4PiT8QT24bukcMz1kepg+oOQU5kjPL/Huj19dntMrduDXPbZSnDbS2Cip5YKBNC8hAEN2RCT1aVCLl98b7iUbPLE69caBkJ5SawBjwiBgb1uShfYUd9OOR/W4IcW47tqWDFuaPpuNRDkrrrXaaf/agVJuu7E2AEcQ6Bt2vi2R1WnQ8zzU6xUOked7kefA9KgS/fQqhkM0XAqDu3IrN93o7K+XS8e/4QuIOoC6CmfOdSyJsDFabm4wB5zJMdq2hBupDyHleCs07tzCfdp3sV0YF27TrGZRel23K1Nc8JASsEjclG7S7Ho3zwgPUyQaItJ0n5nwKGr63JpSIUHIjjx94w/4HREjB3pT58G+ZHyHu6azpIvkIPYlkKuHioWT70RyOp108c6JGcZ6KRxX7BH9QLywBIc16LF6wnFi5cbwjWoYIj2gyXxab7lEACu9W5mG4gGUYPco1PgN6BY31tWPs0vbnk39i0oMkOoihT4BEOXXdzzw99Xdei3ZiXpMkN/fkTnmhaZ/Seq0W9Xz7hQrr6uz5jBgMpF3E/hp1Kf8yn4FT7BtQVM82JpM/T+wmjCLr/8fOeoH2fCFJTshiOb3o00039Mo2+LF5c44pm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9df121-6443-4fae-a709-08de0d594a7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:48.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2jnf24eU3tbzQ2SJ4p0SIi3VPdTeE1uljyGyEC+t7OJS2477HYne95yXI/u5AnjLM2Tr7p7S2C5X2mchqJKFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfXxTOkhpxWbIRX
 azYTKk1YtHXKxOO4po/zgM5Q9VYfILosuHh5MxAfR3AkQDCgArOAhieFYdRQOfGK875NyOGiLoz
 vDDGpeYcBE4mN69mpFxTdKf14xHi12diCA4n2Kk6TTKbfKs59HhB+HkZYM2lMWtQbdsC1OjLP6m
 LpAyBZpFMvgObSEGrhxrxioFxzE6GOsJXmqmC46BEYaeFVArRJbRbwpiEcJlQDrmouEbtognwps
 4hwwXU3z+X8+WBJi+lQltpRa6iaiiuVUxnGXrm+XaeJLrQ/bw8UeNG3UvqJgLJK5f3d/rG3JUbZ
 TbTXPvqBMoLzdJBKQ2bvaZVhpVe8ej+D0jRUmgtNmP7IPyS0QsrFtUVvHDnWgIv6LE9ZIVtEb49
 PgDyBRrfZcBIil1dgPpUhNxBHRU7Ow==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f201c8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=vxQ4P0egtjIOrwp0uvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V_TLcCA7IZr3NNu8g9S_YMf5aV1C01CO
X-Proofpoint-GUID: V_TLcCA7IZr3NNu8g9S_YMf5aV1C01CO

On 16/10/2025 19:36, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
>> to help represent location information for functions.
>>
>> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
>> location; either via a register, or register+offset or a
>> constant value.
>>
>> BTF_KIND_LOC_PROTO represents location information about a location
>> with multiple BTF_KIND_LOC_PARAMs.
>>
>> And finally BTF_KIND_LOCSEC is a set of location sites, each
>> of which has
>>
>> - a name (function name)
>> - a function prototype specifying which types are associated
>>   with parameters
>> - a location prototype specifying where to find those parameters
>> - an address offset
>>
>> This can be used to represent
>>
>> - a fully-inlined function
>> - a partially-inlined function where some _LOC_PROTOs represent
>>   inlined sites as above and others have normal _FUNC representations
>> - a function with optimized parameters; again the FUNC_PROTO
>>   represents the original function, with LOC info telling us
>>   where to obtain each parameter (or 0 if the parameter is
>>   unobtainable)
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  include/linux/btf.h            |  29 +++++-
>>  include/uapi/linux/btf.h       |  85 ++++++++++++++++-
>>  kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++++-
>>  tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
>>  4 files changed, 359 insertions(+), 8 deletions(-)
>>
> 
> [...]
> 
>> @@ -78,6 +80,9 @@ enum {
>>         BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
>>         BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */
>>         BTF_KIND_ENUM64         = 19,   /* Enumeration up to 64-bit values */
>> +       BTF_KIND_LOC_PARAM      = 20,   /* Location parameter information */
>> +       BTF_KIND_LOC_PROTO      = 21,   /* Location prototype for site */
>> +       BTF_KIND_LOCSEC         = 22,   /* Location section */
>>
>>         NR_BTF_KINDS,
>>         BTF_KIND_MAX            = NR_BTF_KINDS - 1,
>> @@ -198,4 +203,78 @@ struct btf_enum64 {
>>         __u32   val_hi32;
>>  };
>>
>> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_off is 0
> 
> what if we make LOC_PARAM variable-length (i.e., use vlen). We can
> always have a fixed 4 bytes value that will contain an arg size, maybe
> some flags, and an enum representing what kind of location spec it is
> (constant, register, reg-deref, reg+off, reg+off-deref, etc). And then
> depending on that enum we'll know how to interpret those vlen * 4
> bytes. This will give us extensibility to support more complicated
> expressions, when we will be ready to tackle them. Still nicely
> dedupable, though. WDYT?
>

It's a great idea; extensibility is really important here as I hope we
can learn to cover some of the additional location cases we don't
currently. Also we can retire the whole "continue" flag thing for cases
like multi-register representations of structs; we can instead have a
vlen 2 representation with registers in each slot. What's also nice
about that is that it lines up the LOC_PROTO and FUNC_PROTO indices for
parameters so the same index in LOC_PROTO has its type in FUNC_PROTO.

In terms of specifics, I think removing the arg size from the type/size
btf_type field is a good thing as you suggest; having to reinterpret
negative values there is messy. So what about

/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0,
name_off and type/size are 0.
 * It is followed by a singular "struct btf_loc_param" and a
vlen-specified set of "struct btf_loc_param_data".
 */

enum {
	BTF_LOC_PARAM_REG_DATA,
	BTF_LOC_PARAM_CONST_DATA,
};

struct btf_loc_param {
	__u8 size;	/* signed size; negative values represent signed
			 * values of the specified size, for example -8
			 * is an 8-byte signed value.
			 */
	__u8 data;	/* interpret struct btf_loc_param_data */
	__u16 flags;
};

struct btf_loc_param_data {
        union {
		struct {
                        __u16   reg;            /* register number */
                        __u16   flags;          /* register dereference */
                        __s32   offset;         /* offset from
register-stored address */
                };
                struct {
                        __u32 val_lo32;         /* lo 32 bits of 64-bit
value */
                        __u32 val_hi32;         /* hi 32 bits of 64-bit
value */
                };
        };
};
	
I realize we have flags in two places (loc_param and loc_param_data for
registers); just in case we needed some sort of mix of register value
and register dereference I think that makes sense; haven't seen that in
practice yet though. Let me know if the above is what you have in mind.


>> + * and is followed by a singular "struct btf_loc_param". type/size specifies
>> + * the size of the associated location value.  The size value should be
>> + * cast to a __s32 as negative sizes can be specified; -8 to indicate a signed
>> + * 8 byte value for example.
>> + *
>> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it represents
>> + * a register, possibly dereferencing it with the specified offset.
>> + *
>> + * "struct btf_type" is followed by a "struct btf_loc_param" which consists
>> + * of either the 64-bit value or the register number, offset etc.
>> + * Interpretation depends on whether the kind_flag is set as described above.
>> + */
>> +
>> +/* BTF_KIND_LOC_PARAM specifies a signed size; negative values represent signed
>> + * values of the specific size, for example -8 is an 8-byte signed value.
>> + */
>> +#define BTF_TYPE_LOC_PARAM_SIZE(t)     ((__s32)((t)->size))
>> +
>> +/* location param specified by reg + offset is a dereference */
>> +#define BTF_LOC_FLAG_REG_DEREF         0x1
>> +/* next location param is needed to specify parameter location also; for example
>> + * when two registers are used to store a 16-byte struct by value.
>> + */
>> +#define BTF_LOC_FLAG_CONTINUE          0x2
>> +
>> +struct btf_loc_param {
>> +       union {
>> +               struct {
>> +                       __u16   reg;            /* register number */
>> +                       __u16   flags;          /* register dereference */
>> +                       __s32   offset;         /* offset from register-stored address */
>> +               };
>> +               struct {
>> +                       __u32 val_lo32;         /* lo 32 bits of 64-bit value */
>> +                       __u32 val_hi32;         /* hi 32 bits of 64-bit value */
>> +               };
>> +       };
>> +};
>> +
>> +/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
>> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
>> + * a vlen-specified number of __u32 which specify the associated
>> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
>> + * location.  The type should either be 0 (no location info) or point at
>> + * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
>> + * represent a single function parameter; in such a case each should specify
>> + * BTF_LOC_FLAG_CONTINUE.
>> + *
>> + * The type field in the associated "struct btf_type" should point at an
>> + * associated BTF_KIND_FUNC_PROTO.
>> + */
>> +
>> +/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
>> + * containing location site-specific information;
>> + *
>> + * - name associated with the location (name_off)
>> + * - function prototype type id (func_proto)
>> + * - location prototype type id (loc_proto)
>> + * - address offset (offset)
>> + */
>> +
>> +struct btf_loc {
>> +       __u32 name_off;
>> +       __u32 func_proto;
>> +       __u32 loc_proto;
>> +       __u32 offset;
>> +};
> 
> What is that offset relative to? Offset within the function in which
> we were inlined? Do we know what that function is? I might have missed
> how we represent that.

The offset is relative to kernel base address (at compile-time the
address of .text, at runtime the address of _start). The reasoning is we
have to deal with kASLR which means any compile-time absolute address
will likely change when the kernel is loaded. So we cannot deal in raw
addresses, and to fixup the addresses we then gather kernel/module base
address at runtime to compute the actual location of the inline site.
See get_base_addr() in tools/lib/bpf/loc.c in patch 14 for an example of
how this is done.

Given this, it might make sense to have a convention where the LOCSEC
specifies the section name also, something like

"inline.text"

What do you think?

> 
>> +
>> +/* helps libbpf know that location declarations are present; libbpf
>> + * can then work around absence if this value is not set.
>> + */
>> +#define BTF_KIND_LOC_UAPI_DEFINED 1
>> +
> 
> you don't mention that in the commit, I'll have to figure this out
> from subsequent patches, but it would be nice to give an overview of
> the purpose of this in this patch
>

This is a bit ugly, but is intended to help deal with the situation -
which happens a lot with distros where we might want to build libbpf
without latest UAPI headers (some distros may not get new UAPI headers
for a while). The libbpf patches check if the above is defined, and if
not supply their own location-related definitions. If in turn libbpf
needs to define them, it defines BTF_KIND_LOC_LIBBPF_DEFINED. Finally
pahole - which needs to compile both with a checkpointed libbpf commit
and a libbpf that may be older and not have location definitions -
checks for either, and if not present does a similar set of declarations
to ensure compilation still succeeds. We use weak declarations of libbpf
location-related functions locally to check if they are available at
runtime; this dynamically determines if the inline feature is available.

Not pretty, but it will help avioid some of the issues we had with BTF
enum64 and compilation.

Thanks!

Alan

