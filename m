Return-Path: <bpf+bounces-65049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B6B1B292
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5703A3BFC5D
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20124886E;
	Tue,  5 Aug 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TiQibQnU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vJ0NAgHh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333724BBF0;
	Tue,  5 Aug 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393082; cv=fail; b=FOf2zhfXlWd3mApwyF9/M/EARU518V2/o65CjnfXqtpSgh4o9PC8/VbM9gdDc5ApTyaNWfhS02eK1NRBq8GwI/ramq/+KWYloUFCxmavVlnXxyZNgwU+HZFUB1JHnmabtQo8QDMuXNU97+tchWHL5iQIrTLge3KHz4g/JLhBscQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393082; c=relaxed/simple;
	bh=rzJ++W/FPUIEteKbMNUEMZSGQ5MH7HOaB+ABDcDrQLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYBhWnz3KWGWGJUk9WewPPGr0VY6Y8E66AEgPPttS+E5mhXHq9TiMIESmBHaik8cFkOoKMmxH5cQ6+JSIT1+mN6WTn6sr/GqTFDGKLgj9kd4sV0PxdKPg4LIcaDU88KvfnEYVgcMdqXOLthC3zcZQvg1HYXEXXrkMnGpe08FKxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TiQibQnU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vJ0NAgHh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759H21t026670;
	Tue, 5 Aug 2025 11:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HTRapHEj1mv0F93k7doNk3/QiRmrPw3yuRjk7q5A488=; b=
	TiQibQnUFPxeGiO5O9sXvBMaeop71Q+IjU5kyd561wdTl3MyZrICJnZMNyOYHxH8
	6W39P3hS4MfJAdS3y8e3tHJMgu+pZyM0eu7c2TPXd4gZP1M84fr4uyo0U+3VtG5E
	RqN+BMh4l7UqoYRYWpcgTRAzRLdiFuB7kqO6gkxqwctuSB4pT9oj1FzdsIP/af9Y
	IkblpfDNjzQl1bcu/seP1lvYZpSWBsIQe5Yd60a1vpDQu61c/aWKer4ih1qJFQHc
	LTX9OR8nd4SAXrr2xycmeOLfx5R8oCFPmbCDy3kvo7RqDQZkAJFrA8AauSWw/Y8A
	077qLmjolCedNP7AgnFmow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvfvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 11:24:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5759ZvfN013476;
	Tue, 5 Aug 2025 11:24:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7msmavd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 11:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4EcCiGynOS2STOZoCKMb43z85ngkPmHacv2P3d5uDMJcnWGztr1LIv3K2OHDZygrIUX6pr3LAuhlXK3LKK4+G6pY3vxpS1s4I4OiFiEUIxthu0cvgVkSr5VukRUCPi/ZqnN0yRVkihxukg1H9mkqOJQLFpmZJ0BKcBXwphRlJhR/ZNF8xHlVnJBxYSrf6q+KKg+VlIHmhFcYRr6nFHtaz/WAY4DELzFxoqUezgq2flVVQPzHN4qykOAC9Uj7p7QczYwvTmNWQAOFbN8drdhgksMEXpvUkQRdt4jy2Sj1glc7irkQImDrdsa9Dcg1rXv262FmTAELK7gl8xHCZ1nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTRapHEj1mv0F93k7doNk3/QiRmrPw3yuRjk7q5A488=;
 b=SPzZ6Dj/SgrbbiniJA79xI0SCvwXdQJMDkCwLe3RkkgTCE+WtRTVpYkrIVbD1AvQm0U/7Jos/UIuVtIdNxQUCVGl18dGvUEITla8j6gWyxusfHp+E7z37aU2iZTnvmCshoEvvZj/DPt8XD0XnxnYyP7trjdfnfT5/qw4ItKDLItHoOiHC3C2zUx2XiDay8ad00iMuWLeSVpIfJx5dofecL6KcjFSRVgg1+w1LuZ3uXa2Za+8hPv+sIBIMyLK2fCQxf4GaJtpbzdHhOsBAHETNdyD0v/Ul249uUfwLYKyT2S1MS+V6vRF4epYER1v7SbAIohmqx4Q8Q+2pnOzFxKeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTRapHEj1mv0F93k7doNk3/QiRmrPw3yuRjk7q5A488=;
 b=vJ0NAgHh/GpBR6YAGt4WPMwqcOw7rS9pKzoosl2GbbdvM59gmKRPESWCLMGEciWds1OMJW3odYT6VR/bDl9yPWjhpSkFnrGB9Z4KK2awLVcF31s5vqf0XN8qI4RVNRte+FuCh+yqefnxy8F542yU4P7+Uaf8myNY1Ewro6rWmZ0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 11:24:12 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 11:24:12 +0000
Message-ID: <5a926464-62bf-40b2-8ca4-a7669298a8ea@oracle.com>
Date: Tue, 5 Aug 2025 12:24:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: Ihor Solodrai <ihor.solodrai@linux.dev>, olsajiri@gmail.com,
        dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
 <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
 <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 01651921-1662-4166-c48d-08ddd4129a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d210d2pIWUtvaGZyMEIyd0NRUDNZeEpLcWJuLzBQTytvMVNQK2JyYjNRS2lJ?=
 =?utf-8?B?cVpuZjFnaVRyTDVhZysxOWR6T2RVaThQL2JWTmJqMUo1bFpTNWtBSmlEakdy?=
 =?utf-8?B?UzNZR2dIejRkbE9iWmorUTRwL3NWcFZKck5UQjFOK3ZBcjRsaEVGUDVVQWNo?=
 =?utf-8?B?ZUZJTkxMQ0YxYXRLVHFnTzFkMkowbytnVnFuSEFlZ21kZFI4SjNuSTdGSXV0?=
 =?utf-8?B?OEhBM0ZoTzdMRld3VUo5NzJIcEpjM1YvUDhnTTFjd3ZZSGp3My82ZTREM21a?=
 =?utf-8?B?VlNtbTNJamY3R3hGT0Q5bWZyc0VPNnJUZGJROWt3czFvNXMvSE1nUEtDRDJ3?=
 =?utf-8?B?aC9aUmdMREc5bmR1WmxXbVJ3SWtMdGJIcHNmSFlDWWJkNVZnWXJkcHhxQVQx?=
 =?utf-8?B?VTNQeDFKQWx3NnFmYXBoV1RhY3BZZ1EzTGJVQ1JwTnFUTVR4dXl0Y0krcGwv?=
 =?utf-8?B?UWx4dFVzd1VDQUgvU2NQTUFubVdRTUpSaGgweVVnOWl6RU51R25Vb3V2NkI4?=
 =?utf-8?B?SXlNcVYzeXF5d3BUQVVydjZSWmxoQ3lnYVlGNnczMUxNNk44MExoRDJlQ2Vh?=
 =?utf-8?B?R2c3NG5uWnRCQ0pjQmNjaENXZjlkN29BR1p5M0w1b1Q5TlRJcldKbjNRenMx?=
 =?utf-8?B?M3ROWlJjdFVRTkNSbDFsbU9SSThyd2hTRFlaODNtcHF4eW5sc3JmZFE1SGly?=
 =?utf-8?B?QkluVmJkakw5WThCVHo2T25GemxxcTJTc0h4SHQwYW9ERUhnSENBNWJ1WStQ?=
 =?utf-8?B?TVRkL1FqTndwejJBdzZHby9lMDBXV29SRzFzSkppelBTdmFsWXR1QlliSndW?=
 =?utf-8?B?WkxKd0xDKzduamhPdzNEMFBPUVBwNlBIckp4RGVDQmZSdEwzWXV1b1lPendh?=
 =?utf-8?B?Nnc0OU5lemtJT2xZK09rTGNzL1RWR2VJaStuZ2xYK3NSTXhLNlViOVEwMnd3?=
 =?utf-8?B?QUxRZFR4eENERlVTNEd1dDNjRmVaZXJiOVVZbHcvdkRCOUF0V2hheFpPMlpY?=
 =?utf-8?B?Qis1V2FaVmR1dnkvbDdXWkR4MWZhazd3cDdwVVhKRDlXMkdHVlNJdVBxNjdL?=
 =?utf-8?B?SzlFUWkvdFVUbDRBNkJSSHJ3c2pOVHVyKzBYWjF5M0lERnlub2pkUkcyTWdI?=
 =?utf-8?B?RjNUclR1V0tHYkVhS0UwTHhrYlZETmxXdnpiQWRXdkVWTkhFb3l4ZyszNzlz?=
 =?utf-8?B?cFpsMFhOR0ZNOTlOei9NTTJxZXFDY1JUWFQ3TmpkQnY3YXRHWFlnV0pTSXVv?=
 =?utf-8?B?ankrdFJoR0FzeWFTU1hGdE4rZGJ2KytoMVNqaEp6UEtQV0k4aW9odWp0M3J5?=
 =?utf-8?B?YVpQQlV1N2puL3M2V3dDTTMvb1M3MDVPSXM0bWJMWTRGQU9JWHpxTGxCc1oz?=
 =?utf-8?B?YTMrT01uS0xkUFRIcTZ5WERWdHBTaGI5WjBEbWJiTlFZdTZPK3p0U2lMTVds?=
 =?utf-8?B?UlJ0WDVBdDlGMExlSUlwRURmR1A0VVFhVWZxd3p2WTFZbTNFQnlnK0NxVWUv?=
 =?utf-8?B?cWdWYnlJNU9OSmtiemQvaXdBNVg4L1ladG9YMWF1TTBKUUR0U0tjNUFYejB6?=
 =?utf-8?B?TDkwWDdnWXlrWTZDb2RCRmt3aUVaczk4Vk4vTWR0djI4SmZXeTl4WjdRcGZC?=
 =?utf-8?B?dTFNUTR3TzlpQ2VGRStWd3RWbzl3UG5HRDlZbW5DT3AvcTJoc3FNZlV1WFNT?=
 =?utf-8?B?NVdrYkpFblB4RHVpbUYrR3V5ZjJnb3VZM0tuaXFUOWFzODZmclpra0pxUGM0?=
 =?utf-8?B?N2QxZW1aQnJnWHcwdmYrRGxqbGd0R3dGM3ExQUZHTGlCSHUxa0l2dCt6V0Nv?=
 =?utf-8?B?UGlEUEJjS3J6WUZTc0pZcjlvbEg5elpEUkE3OTZPVU15TStOMmpERW1jZmxy?=
 =?utf-8?Q?lYa1OjYcteGLp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2U5ZlZValM2NWU2NkFwQnUyaGZJTCtRNjJYNzlXRFp3cDNJYURCajRrUFJO?=
 =?utf-8?B?bXpIek9NUVhkWitlczFVQlJzekl2WC9vejdUWHdnRHcrNmxKN3BaM1RPbDRZ?=
 =?utf-8?B?cFd2SFhUTTd6M29rK1FtRHpjK1orRW9VQWM0bWJybFV3cHRta3dmK2J6MUF1?=
 =?utf-8?B?L3I5TkY5dEtpU3lCVGlEMmpISDZkOXJHQWxKNm1ENTZrbmZrUUZCaUsweE00?=
 =?utf-8?B?elRVdlFHNWRMUXhvT011VHBuZDF3YU1VMW5vS0JpaGpRSUViZkNlRkZhRnZk?=
 =?utf-8?B?MjNnK1RORFA2TVpsQXNWVFN2Ty9vMnlHQ1kzc0txdzl5ZkhBN2NRZCtrRTRH?=
 =?utf-8?B?TENkZXZHTTlGbkxEMVNNT0tPQWJZM2YyOFhvL3MyckNXcWwyVHRJUytpUHJS?=
 =?utf-8?B?ZGUxSkhwcmhHd0JncE9QYlZTVXRmVURsdmFETit0Yk1KSnlORVQyUzk3S0tU?=
 =?utf-8?B?dGRjWnJnRkZvSU1pM2M1c1I3RDlLaXpKeDZ6VjgyKzYvVnRiSFJJTFQ0bU9U?=
 =?utf-8?B?WFk1RHJabVArV29UMjlKa24zc0l6a1ZZYTIwUDRmUTlBVmo2UFJyZE1QOXRW?=
 =?utf-8?B?emJyZ2pPYkx6TEJzOXFhY05TRnJ5cGtLRitpMUhNQThKTzduMWFXb0FWUUZG?=
 =?utf-8?B?c0RNRXJpRmNiTUFCY1lSTWxJWHAxYWlWdkVpNjRYZGR4bGc3c2Z1WjVtcnk0?=
 =?utf-8?B?U25DM2lXcDJUdXRVWG1qbG16bzBWVk50VWZZQkJ3ODdHamRhSHZQbkxzU0Rq?=
 =?utf-8?B?dDJEQ1pLdkFFNlNENS9kVGZkQWtWTlkrSTJIeno2NS8yckdkUXp4NmpJZDB2?=
 =?utf-8?B?dWlMak4yVDFUQ084Y0IvM0dUR0kydkZZaitsQ1FVdVZ1blRpQXhFQ2FNM1I4?=
 =?utf-8?B?ZngzLzRqU2cvSGorUEludUhWU3gzK3hNRW54QlQ3cjlOTzBHUFdWQng1S2Vh?=
 =?utf-8?B?VWl4aUtrcFRrWnBmM25hOE9tQk9hN2FoLzE5Y1o5b1oyVEhjTnNuSVBtNFBG?=
 =?utf-8?B?alVIelhGTld0WFFTVExraVlydStraXRmTUVkUVBQRE9jUnZGeGYya3dEZlNm?=
 =?utf-8?B?cjIwczRKS2FWanh6bGJNMnh4RkRFWFZiKzVuR0czUUJMLzd2UU40VEpSVWZO?=
 =?utf-8?B?UDdTNThMR2U5Tm0rQ2xlQ2xvUGdhdE5RZlRFakYxcXU0eG5XaDNTaEVuVzB0?=
 =?utf-8?B?NU9POHVsYWN3bHkwaVFRWDNpeVRRQks1aWdaWWVzT0pxVHZXQkpwTGN3ME5x?=
 =?utf-8?B?TmZhSlNSRWZacktqdnNxY1poTnVMMG5xWk92bEFYeHEvQ3JsODB4akVPZm1I?=
 =?utf-8?B?eHYzUzYyRmo3emtGVVBuaHltRDczb1JLNGZZT3hSSC9PV3gwNHorK0JZamxN?=
 =?utf-8?B?emd4ZEJOelJnZTk2RlExem5WV055NGZSYlVuZE1CV1NjdWExQTYxbE1IbC81?=
 =?utf-8?B?OXA3ZkVUN1QzcFdVd1BuWlg2THhNT29HNThNU1NxRlFOM3ZLclE1ZVp3aWUr?=
 =?utf-8?B?dVd2NXJKczhEcVJiekd3VVZMOTIvS3ZkYysweG1rVUlNb3ZZY1o0YUFCejFi?=
 =?utf-8?B?Y3ZhcUpiM0tsak81V1drM3p6YlQyTGllbm4zcDdMOU52b3ZHdFNmcDZKZ2VU?=
 =?utf-8?B?UzZJWnhtZ04rbFprN3FqMWpTeHlUcDB5bGV1MGhGVkMrTlFWeEtRRlRIandJ?=
 =?utf-8?B?NU5Xa0xUUXVFeVZ4NnJXYkdSS1BmeXZaOThvNml1Q0RPQVgrRXY5UkFjdUtw?=
 =?utf-8?B?eGV3SEc1VnFXSmkrTks1bmhNSFk3TWJlTTl3djRrTkZ0Z3RHdmxPOE9waCto?=
 =?utf-8?B?eUE3Y08wMm80S0o4cWI3Ti8xZFFqZlpUQjVnVGllTWxFQnBDeGhLcGJxYmpN?=
 =?utf-8?B?K0FLTERYUUpUd281ckFjbXRhRGZpSVBJT0kwTVRiaVh3ZzdsRlBaNy9EbWN3?=
 =?utf-8?B?K3VITW1jMzVkU3Z0cmNHNGJENVArSlMxWUJOMW9TS09VcHJDb3IzVldYY04r?=
 =?utf-8?B?Mm9yZndEL1EzcFlaYVFVNGhVcUI4dmp5WXpBTTJ5TGJ0VGc4NDVwd2F1MlRR?=
 =?utf-8?B?Wk9zc2VBUlpjLzBOUmVkTGZuaFZsai8rVXpuZVlTMkJEbmlqbUt0WjZaMzFL?=
 =?utf-8?B?d3N0QWRCa0JrNzFvcDBBTVhXVEVlWEw5RUg1YnVSMFowRWxZMWVrTVRteWpz?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GIYh5LJveYv31oJ0MsTA6GeGimY8mVqmGDh1/zO8eSkX0YDVyciLZDwjIlsPjL+q4rwp38YljrQA39yi2od5/U+wnLF+uNCfxhFElFCU6h9JJ2Yt9A6poMka8D2l56GR+P/epvU5M0jMKPRvrC8Hw8H44tYy6CA+MLcNAONMRqoMdr3gTGDnXYXggsa85ZP7nAhpn6x+FmgXjKhsXFnao5Cvz3nnTAwNrhVLdymB27YIeNUWzwfBBfdJoSPc09K+vMqdV1IVp82fS+iwRT/ltgp+4zf7TsTfhOu4Opc4X2jJq4ep4Fa6tWuSqAjy1aQe5vK+qtjh2LiCgHTvAXpG/Q8kCZBALSK/eENx0qQtth+2syAo7qt68yKfUksknyaB5Nuu/HDeS5FOA7Z/GbqI7Psf/FhqbjtfqT03FPNIQWWNuTOkvdrH2bbZSU5cBWM8BmQSszOooo2mhI0dNsjiYyVr5l0QRUNdVMDL0H574YAtmbFniCQf0lXWhIq+evWrA2k8CoLpMRO2vA5nzw9wdhrtzNk1EEXItwK7NWeeUfIgMVDMdhFM5Wc+OAPFkpY5wSS4H06+LSrRPOPGaO2l0wwX1SmERpEY5pwpP2TmCZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01651921-1662-4166-c48d-08ddd4129a3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 11:24:12.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZDtc3PHmqouTT/USpy6EmnRKcTgncGtfYGM5WNf8LCtF68SR9g48v++YDIglMFnKZvdjjcr24s2RtjjlcUA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4MyBTYWx0ZWRfX7Kv6ihkGBeUw
 l4jd2SLccWK8bozJFQZsi9Y3AkwasELmZxdQUUKXivTPeV5NTKQTpP0sFMLvRr2g6dLXOO+5eQk
 t0i+HMnhEyIJ31VvOE/vnCHXKn5FA+jbIELP+GDXRomvWLmD9wTC8bcyPd1dbbef2/fCI2DtLmJ
 t1YLsCV6rMVmzHa9zY0DHd4kW+0o+7q1s0h0IVlY9qZmfGxhYJPjerXl89Zz4PBJurmbvijpCcG
 R9A4Bacn7XzVBNmH9KIa73BbRmOBg3VuItrOXaY10jN9861nDP8w5r7HOAo1a1Xp8IHnmYW99MN
 Mpes/bxy1+ZeNf3Ppd9YGG3aBUImcghXH1lhOpqOGurbCySh3sDkWny5DrOZYxiMH30x2g/aIKV
 ysQvaOIfV63pUbn7gftC9arystEUrVZzJTYpB7rpPIYCyqheEn49gS17b55fNCgJlyTQab42
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6891e9df b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=2f69L5GJcxvdaajLMbcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13596
X-Proofpoint-GUID: v-J5aLTFl60mUSOo65psomqd9nm5bJj-
X-Proofpoint-ORIG-GUID: v-J5aLTFl60mUSOo65psomqd9nm5bJj-

On 01/08/2025 21:51, Ihor Solodrai wrote:
> On 7/31/25 11:57 AM, Alan Maguire wrote:
>> On 31/07/2025 15:16, Alan Maguire wrote:
>>> On 29/07/2025 03:03, Ihor Solodrai wrote:
>>>> btf_encoder collects function ELF symbols into a table, which is later
>>>> used for processing DWARF data and determining whether a function can
>>>> be added to BTF.
>>>>
>>>> So far the ELF symbol name was used as a key for search in this table,
>>>> and a search by prefix match was attempted in cases when ELF symbol
>>>> name has a compiler-generated suffix.
>>>>
>>>> This implementation has bugs [1][2], causing some functions to be
>>>> inappropriately excluded from (or included into) BTF.
>>>>
>>>> Rework the implementation of the ELF functions table. Use a name of a
>>>> function without any suffix - symbol name before the first occurrence
>>>> of '.' - as a key. This way btf_encoder__find_function() always
>>>> returns a valid elf_function object (or NULL).
>>>>
>>>> Collect an array of symbol name + address pairs from GElf_Sym for each
>>>> elf_function when building the elf_functions table.
>>>>
>>>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>>>> when the function is saved by examining the array of ELF symbols in
>>>> elf_function__has_ambiguous_address(). It tests whether there is only
>>>> one unique address for this function name, taking into account that
>>>> some addresses associated with it are not relevant:
>>>>    * ".cold" suffix indicates a piece of hot/cold split
>>>>    * ".part" suffix indicates a piece of partial inline
>>>>
>>>> When inspecting symbol name we have to search for any occurrence of
>>>> the target suffix, as opposed to testing the entire suffix, or the end
>>>> of a string. This is because suffixes may be combined by the compiler,
>>>> for example producing ".isra0.cold", and the conclusion will be
>>>> incorrect.
>>>>
>>>> In saved_functions_combine() check ambiguous_addr when deciding
>>>> whether a function should be included in BTF.
>>>>
>>>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>>>
>>>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>>>> CI-like kconfig) that are now excluded: all of those that I checked
>>>> had multiple addresses, and some where static functions from different
>>>> files with the same name.
>>>>
>>>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-
>>>> b1cb-10266c72bd45@linux.dev/
>>>> [2] https://lore.kernel.org/
>>>> dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>>>
>>>> v1: https://lore.kernel.org/
>>>> dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>
>>> Thanks for doing this Ihor! Apologies for just thinking of this now, but
>>> why don't we filter out the .cold and .part functions earlier, not even
>>> adding them to the ELF functions list? Something like this on top of
>>> your patch:
>>>
>>> $ git diff
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 0aa94ae..f61db0f 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
>>> *btf_encoder__alloc_func_state(struct btf_e
>>>          return state;
>>>   }
>>>
>>> -/* some "." suffixes do not correspond to real functions;
>>> - * - .part for partial inline
>>> - * - .cold for rarely-used codepath extracted for better code locality
>>> - */
>>> -static bool str_contains_non_fn_suffix(const char *str) {
>>> -       static const char *skip[] = {
>>> -               ".cold",
>>> -               ".part"
>>> -       };
>>> -       char *suffix = strchr(str, '.');
>>> -       int i;
>>> -
>>> -       if (!suffix)
>>> -               return false;
>>> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
>>> -               if (strstr(suffix, skip[i]))
>>> -                       return true;
>>> -       }
>>> -       return false;
>>> -}
>>> -
>>>   static bool elf_function__has_ambiguous_address(struct elf_function
>>> *func) {
>>>          struct elf_function_sym *sym;
>>>          uint64_t addr;
>>> @@ -1219,12 +1198,10 @@ static bool
>>> elf_function__has_ambiguous_address(struct elf_function *func) {
>>>          addr = 0;
>>>          for (int i = 0; i < func->sym_cnt; i++) {
>>>                  sym = &func->syms[i];
>>> -               if (!str_contains_non_fn_suffix(sym->name)) {
>>> -                       if (addr && addr != sym->addr)
>>> -                               return true;
>>> -                       else
>>> +               if (addr && addr != sym->addr)
>>> +                       return true;
>>> +               else
>>>                                  addr = sym->addr;
>>> -               }
>>>          }
>>>
>>>
>>>          return false;
>>> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
>>> elf_functions *functions)
>>>                  func = &functions->entries[functions->cnt];
>>>
>>>                  suffix = strchr(sym_name, '.');
>>> -               if (suffix)
>>> +               if (suffix) {
>>> +                       if (strstr(suffix, ".part") ||
>>> +                           strstr(suffix, ".cold"))
>>> +                               continue;
>>>                          func->name = strndup(sym_name, suffix -
>>> sym_name);
>>> -               else
>>> +               } else
>>>                          func->name = strdup(sym_name);
>>>
>>>                  if (!func->name) {
>>>
>>> I think that would work and saves later string comparisons, what do you
>>> think?
>>>
>>
>> Apologies, this isn't sufficient. Considering cases like objpool_free(),
>> the problem is it has two entries in ELF for objpool_free and
>> objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
>> the ELF representation, then we could potentially end up excluding
>> objpool_free as inconsistent if the DWARF for objpool_free.part.0
>> doesn't match that of objpool_free. It would appear to be inconsistent
>> but isn't really.
> 
> Alan, as far as I can tell, in your example the function would be
> considered inconsistent independent of whether .part is included in
> elf_function->syms or not. We determine argument inconsistency based
> on DWARF data (struct function) passed into btf_encoder__save_func().
> 
> So if there is a difference in arguments between objpool_free.part.0
> and objpool_free, it will be detected anyways.
> 

I think I've solved that in the following proof-of-concept series [1] -
by retaining the .part functions in the ELF list _and_ matching the
DWARF and ELF via address we can distinguish between foo and foo.part.0
debug information and discard the latter such that it is not included in
the determination of inconsistency.

> A significant difference between v2 and v3 (just sent [1]) is in that
> if there is *only* "foo.part.0" symbol but no "foo", then it will not
> be included in v3 (because it's not in the elf_functions table), but
> would be in v2 (because there is only one address). And the correct
> behavior from the BTF encoding point of view is v3.
>

Yep, that part sounds good; I _think_ the approach I'm proposing solves
that too, along with not incorrectly marking foo/foo.part.0 as inconsistent.

The series is the top 3 commits in [1]; the first commit [2] is yours
modulo the small tweak of marking non-functions during ELF function
creation. The second [3] uses address ranges to try harder to get
address info from DWARF, while the final one [4] skips creating function
state for functions that we address-match as the .part/.cold functions
in debug info. This all allows us to better identify debug information
that is tied to the non-function .part/.cold optimizations.


[1]
https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:pahole-next-remove-dupaddrs
[2]
https://github.com/acmel/dwarves/commit/e256ffaf13cce96c4e782192b2814e1a2664fe99
[3]
https://github.com/acmel/dwarves/commit/7cc2c1e21f1daeb29aa270fd9f23ef1ba99fcd4e
[4]
https://github.com/acmel/dwarves/commit/893f14c2a854c240a927294996f449a3ad63eaed
> [1] https://lore.kernel.org/dwarves/20250801202009.3942492-1-
> ihor.solodrai@linux.dev/
> 
> 
>>
>> I think the best thing might be to retain the .part/.cold repesentations
>> in the ELF table but perhaps mark them with a flag (non_fn for
>> non-function or similar?) at creation time to avoid expensive string
>> comparisons later.
> 
> That's a good point. In v3 I exclude .part and .cold from the table,
> and store ambiguous_addr flag in elf_function. If anything, we should
> be doing less string comparisons now.
> 
>>
>> On the subject of improving matching, we do have address info for DWARF
>> functions in many cases like this, and that can help guide DWARF->ELF
>> mapping. I have a patch that helps collect function address info in
>> dwarf_loader.c; perhaps we could make use of it in doing more accurate
>> matching? In the above case for example, we actually have DWARF function
>> addresses for both objpool_free and objpool_free.part.0 so we could in
>> that case figure out the DWARF-ELF mapping even though there are
>> multiple ELF addresses and multiple DWARF representations.
>>
>> Haven't thought it through fully to be honest, but I think we want to
>> avoid edge cases like the above where we either label a function as
>> inconsistent or ambiguous unnecessarily. I'll try to come up with a
>> rough proof-of-concept that weaves address-based matching into the
>> approach you have here, since what you've done is a huge improvement.
>> Again sorry for the noise here, I struggle to think through all the
>> permutations we have to consider here to be honest.
>>
>> Thanks!
>>
>> Alan
>>
>>
>> [...]
>>
> 
> 


