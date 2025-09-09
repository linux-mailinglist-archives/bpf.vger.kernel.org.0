Return-Path: <bpf+bounces-67927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D2B504AB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3738116AC4D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04C3570CB;
	Tue,  9 Sep 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="APwEFjB7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0911187
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440221; cv=fail; b=pZkX73eR3s4y4BXDDXii5AnGAOb70+AWvp1NUtjVoJ/NOBEHv5dkUgmO9JvK2fkE+VYbLjl8Q4NqkZi/qSxOFT0wVTeXqjreY43dgaHarl6EPMMuAcZbYH67gWRbCWK2QmW2qJXCdNDGyt6RDho1s8yIKMaNk+QWuvFT8x5vubU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440221; c=relaxed/simple;
	bh=u5iIP/XLA5ucR1w3PHq1HmTN+BHMHAUulWLK7KyiGAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLb7oklZxiNEUNx+UC8yOMrg1Mrw7kaHjp+40cby703rfbKDufN6O1Yw5Stv+bXP8IRTtGluXAzfO2R/cwDetmR6E5PrZlIb1NduiFdWkBboM2odxW/KA0aS9PWYR5+B2isAgJwt5I6F2l53VB4DD3eCq7PjxQttX6YX6BO98xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=APwEFjB7; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 589HTN3X2986544;
	Tue, 9 Sep 2025 10:50:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6admJd29jjsE/1xbR0DZdCUrRM7B46Ly10RkzXH8hr0=; b=APwEFjB7yf7A
	sDmGZXybWbv60CyUg0PMrWwzVbsjnGHbsHc3fGbXpsVb1O2GEWrm6kjuYaDm6U4/
	rsgInvT78WrEJLybd0QSwUzf/xwbn5lg3yNhfd7kimnxKafd1e9pM6Pr9HPY1dJK
	4bw3URxCqSM83igAr3mmFBEEETPwYBSfIfP3DNxvz1rt1XJVjbTunJIqeBcn1z1j
	gK/A4VQfiXiIKIDXBS9Vh9PyTPkS43Rnb7mJpXqb+aZ0bJlM4D2m4GFpboHMWxpQ
	1vdl4gDjYrDcc9gOTE7JVE8QqC3eNsIfdMqXTb7Gp291R/S5qIJyEnRSVT07edX5
	/NXEI1eCRw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 492kv0ttv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 10:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtXJc+Ms107ilemtu9XOMyyaJrrACG1B6x0e75RnZbcvrjqCyP6LdXU80Jx/XGuoiNUZKpDeOPW5WNOp0JHYVNeZYvqY99e+q9wrHPciEqCuF6lOvotwy9yulIssRegUR9Q3hOg1xiNzohBh6+Onm1Eite9bmokknLfBPTbU4PW4wfhJS+tnuZLmV5V40ed4eqmJF75vIptxlun6R2aBkC0NYW1lbwuxUNdtpOziVZ3InEQf348nyqpEaA8g44E8JfBGOX2fc02dUeVyXf1NRLZVpHwnRPP65hD+yYV8A6PoUQkpKx18BY8HSacReDllTJkMNjUYOvUyzHl9rbZExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6admJd29jjsE/1xbR0DZdCUrRM7B46Ly10RkzXH8hr0=;
 b=M2Ltft0Illp2r/FLpCxlv7YEfqmpgdgk5W1J9pBPAeNTQKh60hP2zHFyLaYjodjVfe8JXCRrA6QNaNTlylx5ByIkAFkQpceVxWm3BBdnTNq4qyMxoneBaruiLCXz/mGIrufhH0S6eVH1FrEApfTTsyuEIWdIpjAAEgeV9a7fgdYWGXagIe3Jr0qjzaMsWtNTJRocUbni648l1GgZHGT/JSnEio0BxTIjKhfi32Zc1MARPvEQRJ0FnC533UsZ1U/91D5o231z3K7aWipqtOrEVocWbZUtID7r94nW2inrYIoaWOZQm/vgkTuX8u+HunCtL3HGkm3wazmI0f3zSxsgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3785.namprd15.prod.outlook.com (2603:10b6:303:44::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 17:49:58 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:49:58 +0000
Message-ID: <5d6226f6-c3ae-4e68-a420-76f553a462ec@meta.com>
Date: Tue, 9 Sep 2025 13:49:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
        memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3785:EE_
X-MS-Office365-Filtering-Correlation-Id: f61afd4a-63e0-446c-d44d-08ddefc94af3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clo3T0ltUURDM0ZWN2lSVTlWVWFTYzFEWUxmNXZ0Z1JiSFV5QnNkWDI3YmlZ?=
 =?utf-8?B?NzFvODJGU3hoSDFiRGx3NnNaQ1pUMFBGV1F4a01IakpQcEhtWGZZc2RzL0RW?=
 =?utf-8?B?NEtlMm5jR0ltUmkveVNydXh5Zm94R0R1cEM1amY3V2N6Z2lhZmJBQVpHY0ov?=
 =?utf-8?B?WHJlQnRiUnpGVGJKc2pNSWp0QlRHcjRBODVRYlJyNnQxWFFwQitzaGRYT3Ri?=
 =?utf-8?B?b25zSHBDQmpCV1RLTVptUnAxQitNUXFPWC9kenhXS3psRGJPWUNwbVAvQXlP?=
 =?utf-8?B?RmJqRGhrYWxWZmpDQnpzdVVhSWhXNkY3UFBNNTFINW1kWFVEU2hlWTRaQzIy?=
 =?utf-8?B?bHFJNWZMZnROVEFVbTJXdmg3akZ1aDhqd09BVTRhNVRzdVVQc1RHUGp3THJ0?=
 =?utf-8?B?a3pvWk5PcGt4RldzMTlPUmhqamUwTnNmVXd0NWVHOG5saGNITkpVQ1VLUm9I?=
 =?utf-8?B?WjBTbkE3UWtRZm0vdnpSSjhoZWhCblA3OWxLLzNZZy9FZHZNYTJPVFZMNVJU?=
 =?utf-8?B?eVdsV1JvT0xhYktBWVgvSHJvK1pXc2liN3piYjlXMklTUGJjOUdUOGZiT21O?=
 =?utf-8?B?a2I4VTJpaFJUWFo5a09JYVpKZi9pQnc1OFl3bDZxTjZCVGVwbW1sVC94K1U3?=
 =?utf-8?B?eDYyRmMwTmdVVnpmVUJlODJwOXpmL05BM1BneTFNeldTdHlaYzAxT1Y3SndU?=
 =?utf-8?B?eFVNcmNrNFJsdDJHZVBIQWlldEZ3T0l1amlTU0N1UFZzanVQVUdQRWIzak9K?=
 =?utf-8?B?V0VoYjcxaU9mcVNzcGpnMUZKZGFhVTh4akpSNFRwdDA0VUM4STQyVjlpVHlM?=
 =?utf-8?B?cHF6RkRqeFIrNlBmdERpYmFqTXhCVlVpS1czczljUWxGVlRWdUt0ZkhBTFY2?=
 =?utf-8?B?US92UHdDWXlMNmlqYWp0TEJDdHNpOGR1MkQ1S04vL0RuZ2tYYUR5TWN2L0pO?=
 =?utf-8?B?dEtjZ2UrZGtNMHlIZ0lWREhEdFI2QXJObjNBNzhuajkyVnRjUjFSMnVCeGhm?=
 =?utf-8?B?TXg5bjlwR29lb0ZKQzhPQjZseGVURTZQM3NNdER5YjN2ZmlzS0NyK0pzRHlM?=
 =?utf-8?B?V2IrWjVsYW92UExOK0Q0T0kvM2phSi9GMWkycVpGSWxhZ1BDVzJIVWNrT1hY?=
 =?utf-8?B?bnY4em9NY0V4YWg2YVBBdVhNNXN3eHRqWHNpbTNab2paeFh4MlQwVy9sWVp4?=
 =?utf-8?B?ZjNRV2wwaTdXbkJkbFgrNjFuRUhIUGJmNlFUaGF4UVFRYU5JYm9pcWdyWWxH?=
 =?utf-8?B?YTVxVEZxR0ZxbHI1K0oybC9CRGhhMXp2M3Z6aUpibWFDMXhxZ3hLRC85MFBY?=
 =?utf-8?B?ZDJ2VHJmUCs5d2R5VWVpRkpRSXJpRDFvVk1FMllXOXhLU3BocjhBMHFMMkJk?=
 =?utf-8?B?V1NXSTV6dkxsbjl2R1V4Mm1iWHZ2YlMrSHNTWEJqaDdISzhXTThMNDNlMExO?=
 =?utf-8?B?N2FqUDQxNkRkTFZJbkxwc3NqTU5iZ3JIZGtrZWZCSXA2YjJXb0hBZFFrTFlT?=
 =?utf-8?B?dDhweFRLZUZ6TjBDc2h1ZGNTL1RETURvQXorNVc3TzI1Q3o5ZXF0T29SMzhZ?=
 =?utf-8?B?TTArSWRnYlBodldlVWVEakNLTmJXTXNFT3JrQ1Z3b0tpTDRNT0NLZ3kybzhK?=
 =?utf-8?B?b2cvYTBEcWYvUHhzZWxyNlQxUTRMZzFpQnBmT2lxS09mTkxzSlZVQ2Q1Y3ll?=
 =?utf-8?B?dHVENVd1UEVXbEcvYlFMTE5mbzJsRWdFU0pFcG1ob1BmcVkxVmNjT00zSnU2?=
 =?utf-8?B?M3dreHJqS1dwSVJud1FjS1FaZXdITjdlNWJZUlYzazIxejB6c0ZyV252MEc0?=
 =?utf-8?B?dC9HbDBNT3VZaGtNaTJTV3NRUUY5RExRSTJVMEo3eDdKcHBtUkl5MHR2T1pE?=
 =?utf-8?B?TVJtb0t3WThzYU5hVW9xYnpMOGFkdXpjcGpGSTIvOEdId01SbVk2MnZ4YzFi?=
 =?utf-8?Q?pjwDbnBpWBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtuNFFkaVZLM1dERkdDUE9EZFpGTzE4R29OekJPc25IUldSZnFUcThmUjZz?=
 =?utf-8?B?TEttWmRMNkIzaEd4ZndacHgxTjlsVFU2QlZLOCtnQ1p2UytQUXpMVGxjckUv?=
 =?utf-8?B?cmwyaTNKQ3R5UzVOQ1VyTUJ1VjdhSkQzQlhhWERHd0l0Tm4rV3BLQ1o0ZjRy?=
 =?utf-8?B?cHdQRTR3YUVuMW1UMGN5Q1E4Z1NRVkdHejZOWnFabUhKais0a2RJQ3pUeml4?=
 =?utf-8?B?cW14eFdXY1RPV3NmY0Z1NFVocDd2bU5YWUo5QU9aMFRnQnVtdlg1OUtURks5?=
 =?utf-8?B?SHB1Q2t0ZWZWVnNxR3oyejVEaG1rZ1pzd0hDQzR4NnJhN1FYUGwxcldTU0tW?=
 =?utf-8?B?dVRwVWhEVllMLy9wTEVRWGlpTEx0UkJkOUFQVUY0VWRmREtrSysrY0hYY1hS?=
 =?utf-8?B?MlNYeHhmTzRaWDdJeW1FdVNWWXU1ekhOMkVjWVMvNVZjM25VWXdCdERvRDNr?=
 =?utf-8?B?SDFRQllPQkhtTUtNYlUxUzZvMDBzZU80clM0cnhWUkYzZS9JdTdmUTBOREU4?=
 =?utf-8?B?ZVAvdWt3NzNUcGJRWEl2emorN3JFdFhaNzdGUG9jYmNBQjRuWVJFOW5Hc2Qv?=
 =?utf-8?B?dDZMc3oxSkpCRm5KYURoNEZIbjZ3TFBsQ0pxQ0lGZUdTbHN3MXVUY1ZFQkZw?=
 =?utf-8?B?aFdER2RXV3IrSmdlZ04rM2VpQ2hKZnNQSDNxZ29YYXZJMTV4RnZ0c0pxMnhC?=
 =?utf-8?B?ZWhPK2pZZmFMajFHVGttTGI1VHZmK05uYkU2Y0ZlZk1EMHlRVHZVcXdXMko5?=
 =?utf-8?B?VXZrTTF4ditPQTV2eXhyWmVJMnU0TUhKZytOYU5Nd0xWMGh5bVdxL09wRmps?=
 =?utf-8?B?aVg4MDRIRU5BanUzSjlESENaL09GUnp4elQyN0g0cU5zdVF1Nkl4WWtkaStp?=
 =?utf-8?B?akRONURuRDIweEJ4cE9iRFNtOHpVbnNvUjdUbUFMR3ZONkhlalN2M280WjNM?=
 =?utf-8?B?c0lxNXAzK2JZdkNmSDc2elkwVE5CUEFrZUtmUmRDYWxWUmRkZDBFMUVkMmNm?=
 =?utf-8?B?Qk1jNlBsdTQyRW5rOFl4MU5PRXo5M2hqL2paWXFQL0RlMXZFUHpnRDc1RjR2?=
 =?utf-8?B?dEI4OU9wVFNadDN0Y29xRHZ6LzdHRElDWllWNitSYnp4azVWOHRqamdUWVVh?=
 =?utf-8?B?ZlJWZHFkcTloaVNncUYwOFNaU3NiRFZLSnJ3dXEyYUFLdW9vL3V6cStCN1lt?=
 =?utf-8?B?c3N0K090U1NSSTNTem04dFVmMzJPN0RXaW5veVVnY1NNcXZPdU1uQXNiVFZG?=
 =?utf-8?B?QzBiTTlxWjNRSitpdmhEeGRJU1lHRnhJTjNSR1RIc3RrZWxyRi9OcVRwZVhT?=
 =?utf-8?B?cDNhcUtzT3B3SXo4T0dvaThTaG5uR0gwVTFkcXlkWExpN2ZFaDUwUE16L0Mw?=
 =?utf-8?B?eE9mTEIwbjA2T256SFhDeUdXNUU3eDBvcGt5ekxvUEdJV1VIa2N5THVSQTJV?=
 =?utf-8?B?UVRLNTgrM003dzhxNVpUS1pFbmZrSGF2bjBLYzRSeUlEc21Kbk9YN3I3WXpa?=
 =?utf-8?B?R1RtK0JkNElqSlJOMjQxRXBqbGRYN3Y0R1dKQlUzQnBMODlaWHd0d01NK3Z1?=
 =?utf-8?B?SmprUWx0dHJ0RitNbS8wRWhiY1NQOHhqNDVHY0tCV0FPb1ZZVUlabUxwdGp6?=
 =?utf-8?B?bW01UldlUjVKZ1J0dWNDZEJvbTBtSDZnUWY3Q1g1alFlc3JXS0FjRHloc3Vk?=
 =?utf-8?B?SS9WN0d1NVUvUkZtRmVIa2ZmcndBZExhWXE2NEVEd3kwdmdBMlVuYm4zNkkx?=
 =?utf-8?B?SGgwclNiRjVmbWl1WEN4NitRa2hPcWl4RnpwYTdiUFVja2dObmJmUkNZbldx?=
 =?utf-8?B?T3FJU29rbkZFSHRDTjhhNlpYcUlab2o0MVl3Z0p2Um5TVXlGZGhRRmMzRTFZ?=
 =?utf-8?B?WFYwaFdpSSt4Q0NDc0d3R2RRekxrUWtNRW5WUEdpejRRMlBWNmNQNldjWWgw?=
 =?utf-8?B?bGRqU2ZEZy9YZVBpcGZoSkJrYUgveUQ0cGZMMVlxMHJTNXNWR3BDN3FucGNs?=
 =?utf-8?B?VXRwUXJuQ083cDV6ODF3ZjVvZE5xV00rMmVIMU5DZ2NDMFRhWmpqeDMrWDhl?=
 =?utf-8?B?Y0FmK0dsdUd1ZGVNZWRoZE9SajFrQUNXSDdlY2xEaE1Hd3Vzc0VlZmdPTUNI?=
 =?utf-8?Q?XOYZk+nIrzA0i1b/8iv71zQnx?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61afd4a-63e0-446c-d44d-08ddefc94af3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:49:58.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRjvrnis1BeLdHMLmkFnBMiCZVle2e+7pvM1vCXLDQ3PJ/U84xrCqByXIaCEGqSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3785
X-Proofpoint-ORIG-GUID: ImpBIIYaLtYjIEN1UlApqm2htHaz_vpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDE3NSBTYWx0ZWRfX+QwIUEnB0bRS
 RXhYGa2R17U0SfMADT323sJvtNd1jWSzNU7pF/Y0TXyVZMrMBlDSeaq5pflPTjr6S390G4hhSt4
 ey8SYYDpF/ZMKwN74bDXuyTidlCNhhamSOcdEkmZCJcHZtWsBlVS1MgDFG/yW47hcChHwjFgQ3Q
 0i59l2+Zo1LnSlOztZ8M/p2da4eyIEMWL0i3YJGsUpFsdf+a3kj4ET9XpzREggnB+qYP/ZRmSQz
 jlLSD4V0JT5QaLHrWZ1PQGpfH+K+EF4cn7DMg6p6ZL+hCgt+S1IwQn48YQ+dYz46zGT2KRCuEbb
 Doo23OiLNoby/IUNyZBiOS17s7Fh0SfoGPE30Zj8Ef6a1RGSX/9qyM3U0yYExc=
X-Authority-Analysis: v=2.4 cv=UsZjN/wB c=1 sm=1 tr=0 ts=68c068c9 cx=c_pps
 a=hZh1fjB8ufCiIpe4ZEQT7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VabnemYjAAAA:8
 a=sjpi5061lUOx9tHo9R8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ImpBIIYaLtYjIEN1UlApqm2htHaz_vpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01

On 9/5/25 12:45 PM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Implementation of the new bpf_task_work_schedule kfuncs, that let a BPF
> program schedule task_work callbacks for a target task:
>  * bpf_task_work_schedule_signal() → schedules with TWA_SIGNAL
>  * bpf_task_work_schedule_resume() → schedules with TWA_RESUME
> 
> Each map value should embed a struct bpf_task_work, which the kernel
> side pairs with struct bpf_task_work_kern, containing a pointer to
> struct bpf_task_work_ctx, that maintains metadata relevant for the
> concrete callback scheduling.
> 
> A small state machine and refcounting scheme ensures safe reuse and
> teardown:
>  STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY
> 
> A FREED terminal state coordinates with map-value
> deletion (bpf_task_work_cancel_and_free()).
> 
> Scheduling itself is deferred via irq_work to keep the kfunc callable
> from NMI context.
> 
> Lifetime is guarded with refcount_t + RCU Tasks Trace.
> 
> Main components:
>  * struct bpf_task_work_context – Metadata and state management per task
> work.
>  * enum bpf_task_work_state – A state machine to serialize work
>  scheduling and execution.
>  * bpf_task_work_schedule() – The central helper that initiates
> scheduling.
>  * bpf_task_work_acquire_ctx() - Attempts to take ownership of the context,
>  pointed by passed struct bpf_task_work, allocates new context if none
>  exists yet.
>  * bpf_task_work_callback() – Invoked when the actual task_work runs.
>  * bpf_task_work_irq() – An intermediate step (runs in softirq context)
> to enqueue task work.
>  * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.
> 
> Flow of successful task work scheduling
>  1) bpf_task_work_schedule_* is called from BPF code.
>  2) Transition state from STANDBY to PENDING, marks context is owned by
>  this task work scheduler
>  3) irq_work_queue() schedules bpf_task_work_irq().
>  4) Transition state from PENDING to SCHEDULING.
>  4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>  transitions to SCHEDULED.
>  5) Task work calls bpf_task_work_callback(), which transition state to
>  RUNNING.
>  6) BPF callback is executed
>  7) Context is cleaned up, refcounts released, context state set back to
>  STANDBY.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 317 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 109cb249e88c..418a0a211699 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +static void bpf_task_work_irq(struct irq_work *irq_work)
> +{
> +	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
> +	enum bpf_task_work_state state;
> +	int err;
> +
> +	guard(rcu_tasks_trace)();
> +
> +	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
> +		bpf_task_work_ctx_put(ctx);
> +		return;
> +	}
> +
> +	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
> +	if (err) {
> +		bpf_task_work_ctx_reset(ctx);
> +		/*
> +		 * try to switch back to STANDBY for another task_work reuse, but we might have
> +		 * gone to FREED already, which is fine as we already cleaned up after ourselves
> +		 */
> +		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
> +
> +		/* we don't have RCU protection, so put after switching state */
> +		bpf_task_work_ctx_put(ctx);
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Do we want to return here?  I didn't follow all of the references, but
even if this isn't the last reference, it looks like the rest of the
function isn't meant to work on the ctx after this point.

> +	}
> +
> +	/*
> +	 * It's technically possible for just scheduled task_work callback to
> +	 * complete running by now, going SCHEDULING -> RUNNING and then
> +	 * dropping its ctx refcount. Instead of capturing extra ref just to
> +	 * protected below ctx->state access, we rely on RCU protection to
> +	 * perform below SCHEDULING -> SCHEDULED attempt.
> +	 */
> +	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
> +	if (state == BPF_TW_FREED)
> +		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
> +}
-chris

