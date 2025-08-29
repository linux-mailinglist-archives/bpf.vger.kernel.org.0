Return-Path: <bpf+bounces-66973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3792B3B91C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC280189EE40
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9643093CB;
	Fri, 29 Aug 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1C1sH95";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qIfZG6gQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA41A0BD0;
	Fri, 29 Aug 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464214; cv=fail; b=k9Hmk1Ylv7AH540bNYOJk86WQzjXSXRNwi/aCtAQhmwbDZ7XB6zYjKeU2bMl50OjytkpykpJZ4VOLFyM7h+w+kwTOGpsFyq4967J2wmuCc9sYFTAa2QmSKevNPwKAkW46kQS7dzI9Ezuq07V73JkBwIzusJ50KMGfvOLmyLa3Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464214; c=relaxed/simple;
	bh=/0g+VDLWlQQBes5R6ZXUQXwjYyntaBCdYFI0jqWwTFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWykHI41OVz6YtjpNGZwzKahlSl+90HTtmBUySMXMhz1NELQrKcaKD+AnjJ4nb1OYP6vLggPnjkPenllb67c2PdjeYqcqI3Tc5oQpmbyLjLbcbI6jz3/bcWDPxVOfBJvyECmHz/4bAD44au9ZqxRX7xuxrmXTnzZGTocr1I3hS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C1C1sH95; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qIfZG6gQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAYCQp004678;
	Fri, 29 Aug 2025 10:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k7RA8xts4UWzSO7AXtPh+sjbXVzuzRlV+sL7pRf6dA4=; b=
	C1C1sH95lqrhm/FKvAdLt/4KmnHBdSEL1P6irjP4FI2Hd2GI2mU+ZiKq7J4xaIRg
	KiRCFfoHP2vfBMZPwPJFJy9PdSULs61IG/rLcZpcrg9mLdDTIdxeXZ/CA+z1bm8L
	80stMTObAjrFwn7r1JqW9WZmkqBZPaDWK3WP7DbPp3eXph9aNUa7GeCR6JTQkjJG
	fd+dFUh56kp4VENkjww+yAAwX4nRAUJo3Z5M7W4cBcHQjeeBzRrUbMlcSga1/Jtx
	njC3ozfhToKKTLqKW0NFcbEierpkj0HlXVsLp9EsdbaotMsDu05WQKDjjp4EFDX9
	rgSo1juRXDZ6+mhC9rUsLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twgxxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:42:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAUEem014754;
	Fri, 29 Aug 2025 10:42:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43d06vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muAnt9id1T1tX+cjo5YRw4rozxd38DABFBaSEdh2cyPHL1gtToieN65ZNqyr3KaGz+KWLJ3e7SkEtMgrbZwqsQI+hLapLOiFGT8H9d5o93vOXI8u7BsNQ0XYp0AOpRYSqTFIXKjW8Eh9zOg51+Gbluoe/pShBRfkIDPugq+GYNpvkpvhsGBhS9aomgcjlyOb7CIUogPP18Jv7P9s+etiFYBcMLYlsIIb8gb3Qw7mbWQha6G7IoMuNvuP9KHPQ2jTDwi8/770pt75tKSK5KdoCsJ47s101/rjcPr7W1HbI9A35Y/a3XSZLAHw8Xbb/r4g0QzzwiCxcGP4rqAnxod2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7RA8xts4UWzSO7AXtPh+sjbXVzuzRlV+sL7pRf6dA4=;
 b=viAjNpLuJb039vN5RiJoNOHQAkuosvM7QiD0YQIbEoiNv5yxpzGryE0O2O4jKfCjsOjCwWw62eZYvGs1bouDtOEh6vZF1dF/a5pB47d49LEOja2hvRhbp2oHCmCEzCqDslUXM7jqH++sXzOhVAuIm7zszOCSNTnT7GvePEZW4xQLWDXBjVE22i10IA6mH3+vIkLlOWFey4kUc+viqOfUSvUMaTL77pVSwRJ2iuVsz7yTpz9CTIUXj/qc2n5yG/oF6jHe4YKeAfG5ePyVGkgYqGJ64lyagIo76YyjD9ALMUDUkADfVs9tAGHnMqd/GUAcrSOuhH3XGd+PaYXBj3myBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7RA8xts4UWzSO7AXtPh+sjbXVzuzRlV+sL7pRf6dA4=;
 b=qIfZG6gQnYHgq8DVkYcgK7cfp5McHgfA13rVl2iHvefalmiaAP3jyuIeIINq6G58ml/n5cceqP7F2GtNiq8WMdExzB1PojJ7KgKuxbLKL7T7GFL8OumKbcM24G9oJ76xoZJhlS+77jdvTkiahmNQC3H4MLtcaoaDtUEEVf+DUTE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 10:42:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 10:42:48 +0000
Date: Fri, 29 Aug 2025 11:42:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 03/10] mm: thp: add a new kfunc
 bpf_mm_get_task()
Message-ID: <868e7a44-b55f-4ff1-9f25-28d17374d2c4@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-4-laoar.shao@gmail.com>
 <5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local>
 <CAEf4BzaOA-3NtwTmrPgveqbW16m3KZAAA1E_xn_qjtiJBGsE4g@mail.gmail.com>
 <4ee47412-2a33-431e-b667-2daf25bf0b38@lucifer.local>
 <CALOAHbBUCKTO+LX=5r_hW3+uBHO-J_gcQXyJEkasM7Em+37b+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBUCKTO+LX=5r_hW3+uBHO-J_gcQXyJEkasM7Em+37b+Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: d4641c70-e44f-4d50-fc68-08dde6e8cbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU9KM0RRTmUxN3owMUZUYzllQjdKdjFTUmxnWnpoNkkvV2ZSUUhxU2VYenl5?=
 =?utf-8?B?TWNqSTRwZjNTTWlHVkhGSzJrZzlBbmQrU2lZL2pzNTlOaXJsN0w0MU02enRJ?=
 =?utf-8?B?VXVHV09wVlVxNjA2SXByRE81a3J6QlE0RGhPTU4zSkhxdUlCNjRMVWRDY09m?=
 =?utf-8?B?UG1LZlB6VUJQM3hUV3F0ZGU2ME9vSTJPc2FWMjFMWXNOSkQ3clgzUDBySlpu?=
 =?utf-8?B?Ung5TGl6bDdFL3pqclpDaCtNZGFMcisvck9zd3lmV2U1T3FMTThkbTh5U0Nz?=
 =?utf-8?B?cUhVUGpTKzNsQzNTMm16ZWxBWHJqTVFZVGVkRjF5RWJnTnVMemc1aWpadWsw?=
 =?utf-8?B?NUF4RkdDaFpjUnVOWVpBc3NmR2FNTzVwT1FYYncrMWdaQW5MR2VCdW5FOGFy?=
 =?utf-8?B?bnhKN1FLaGlzVSsyRklzeDZIa2w2bmh6ZHgxZjFxVVVWbDd3TFFuK0NKUHVk?=
 =?utf-8?B?QmVrZWdBM2t4c2NQSkllYnZlQzhtSlE1cVNjNEtOZWdxT0l6aWlibytBSmho?=
 =?utf-8?B?L1N3YzZvbWEySzhROUFqTnREYmZxT0wvVEZuZ3R6c3NNQ0ppOFRqOU5qV1Bv?=
 =?utf-8?B?WHVCWis3aGVaeUkwTnhXTUJhenhSbDR1b0xNdEpxK0txV3p3azFXanBTU1NK?=
 =?utf-8?B?bU4rYzU3Z3E1dG9uNnF5SE9XNXArbVBQb2JRK2ppTkNnZHZrT2EwTjhpZFRX?=
 =?utf-8?B?ZUtQS0o1RXJmWlBDY0JNdzB3ZUNBa2dWYkpIaHZNK1pFTGo3L0tnaVJ4UjM5?=
 =?utf-8?B?SmcyOUhoM0N1Tk5Vem5KWVhJd1NXZTVUdzBHbDhnRE8vWWdDaXBwSDBXQ2Uv?=
 =?utf-8?B?OEJ2QjZyN21DYmJaRkJPM3BtelFEeXRkY0IwYVY3TUlGVmhwbVhaYlpDNjEv?=
 =?utf-8?B?MmhqVjFVVUZ2dThBajlSK0I5cVFmK2crR0haMDRteUNQY1JvZmVwbC9KTFBj?=
 =?utf-8?B?eGRTcDgwenNwQ3FIb2JDdHVRVkpYYUhjOWdhVWE1Q29EUGt6SldBbkVMaXhk?=
 =?utf-8?B?QVdWKzRwWmV5dFZpZ202M29hRmFqakx5YllJSThHakdvT1NkeEdnRUNscjJM?=
 =?utf-8?B?bWZ3a05ZaUttTVZDOTU1ZTRESEd1UitxZjk2akJkQnRQRUpSRW9rT1NPZ1R3?=
 =?utf-8?B?MTlzVXBmNGJRV2phaFNOOVI2VURzRGh2bVBOV1o4UGsxRU51Nnd4bEUxbno5?=
 =?utf-8?B?UDZPK2cvdjRLRFhCemM1M0ZTUk5kNlNXU0h0RDkycDZXSFdKaW45QlZwWGxq?=
 =?utf-8?B?Z2NMNERjWnA0L09zbXVnVkRjVUFDdnlDWVptc1hPNHhEWkxPbk9vL0VLS090?=
 =?utf-8?B?eVdlcUp3eHA2ZThlY29VWnNLbGJEeXdIMmg3cGQxSnlwZVkrQ1IrS2o5ZUJJ?=
 =?utf-8?B?UEY2Nmx2WFo3RUo1b3VKS0FZcHZ0Q0xWV3R1VHdLOENIZllzbE5ZZUw0dno4?=
 =?utf-8?B?R3pMUnZDZG9TQmszcUFsYXduOWpKcWhWc0l4QmQzTUNOZ0hRSUx5N2tzRVlX?=
 =?utf-8?B?NHFCRWNBUmtGRXZkS04xQm5nSFd3cTVEaUtYM2xGWXRkTXpkenQ5bnNXYlZO?=
 =?utf-8?B?elFUelZhUlBPUlN2eWJqaEVmaHJQRVlId1lXSkx2ZnFOWnkrN3p0b3BMM0VK?=
 =?utf-8?B?NEN5bkdSK3F0OHNaRmlMQVY3Q0VtQVNTVGRWeEpuVVZhMXJubXB5Ym9qNXI5?=
 =?utf-8?B?Q1lUUVJhdmdRQXhmcVNjVG5MSE1sR3FRS0h6VmRpS3ZtTklvZ3lIUlY5K1Yy?=
 =?utf-8?B?ZWZob1VrTnpONEhqbkRLWDU3YkVTTG1HZnhGOFI4dlNNdTlhNkp1S2ErZVNq?=
 =?utf-8?B?MmIyc1dPTndraktGYkt3VER3bUZ3RFNXT01XTllMUGNtZ1UyWjc1OW1OeHZx?=
 =?utf-8?B?dVd2em4xOWJ4ZUZ0aXVHTEw3L2ZFeUNyZEl1aUt2NjBuVmxYYjQyQW11OVBi?=
 =?utf-8?Q?9iVr4xsqk20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFCcFQ0djR2WTR4ZGtNYldIeTdlNjZKUktJZjZHdmk5L2U0emJMTDhsZ2Q1?=
 =?utf-8?B?Vkl6cmQ0cHVqOHZidzcxVUVmTzFETXEvQyt3TVVQN2Z3TnlCbkxFOTdzanlF?=
 =?utf-8?B?YlllVFFkR1Y4QndBTVFMN0dCQXJ6YzI2eVZUODlhRi9relhHd2ZXVUR4Tzg3?=
 =?utf-8?B?QTF1OU1ZVDhIOTFqVkxkQWRJaVh1Ty9QR0hlVXpseTBObmV1ZVRYaDhDRnY2?=
 =?utf-8?B?czNrUkhaZTdFL3YveElWTjZ2djl2aXlYcFM1bU4vTEl5YjdIQnZSK2x6MnZC?=
 =?utf-8?B?NnVEb08vdDZ4NE1KUmRrclZTMDQxQk1GcnRUa2t1cTVUY1lEYlVDdFJKWWtX?=
 =?utf-8?B?NjhpTXFZZXRKT0EyNlVoSnlPTEZuemwzWFVQdlIrelNWSFJRQ3ZpbGplU2tz?=
 =?utf-8?B?RURSZm1tS3h0aWN1TVMzK0QwOUo1U09SaUZaZUJHZzhrQzkxRWZpVjdIakJ4?=
 =?utf-8?B?Q29FT1ZPSmQ2OHV1Y3BJWVNaWjd5ZGs3Ty9QdnpQZXZCREorTi93ditKNzJW?=
 =?utf-8?B?czRIdXAxQ21HUElTM1FUeEVUaDBkNmdkMkVlOEMzeTZ1cTZpZFJSblJZM0Zp?=
 =?utf-8?B?OXdMc2MrWjlVQzNaSWVBbGl2K2VYWXRlY3pMd010TEluS2RGdG5uR0pGaTdK?=
 =?utf-8?B?Z3BDbXFJeFk5eWFKMkdyRlFheXFZa2tvcHByZHp6c2ZpOGlVTEVQTHVidVI5?=
 =?utf-8?B?TUhWRzFFT05OMFJPOG1DTXZXUmVwZmwxcUt1dmdDNVlqM3lsVlRIZDc4TTlG?=
 =?utf-8?B?OENOWkYweEk4eVFwRGZ2SHRWNUJ5U3VFS2NtK29KajZRTHUwK0ZBT1Z2d3Vi?=
 =?utf-8?B?eEh0QnRYK1FEYkpzZ3BxSlRxS0ZzVGZESUJSemJCTmlFRndsQnYybTgvN2Ez?=
 =?utf-8?B?TTFzd3ZWRE9OOXpBdFFBUy9kU21vVXdJRVVaQy9yNDlxcTc3d2tNSkRVL0dO?=
 =?utf-8?B?NzBLRWhQUGNtaHdaajlKSGtBbWNKMkswMHMyRjNwNWh0OU1DK1lISXYyMkk0?=
 =?utf-8?B?dHFuQzhEQTdzT3V1OGJvdzdOcG1HZFZOL1pOMm96RGpGdktlMUVGOHdYN2ZD?=
 =?utf-8?B?WEdRYk82bzNvUVdDS2FJNUlXcnRzdElyemM2YWJ1MkpxbU1BQ0JGTWpnZU1T?=
 =?utf-8?B?MkFvSjRJLzlIV3BvUXRDckhySVQybGJKL0l3VjdFMjQvNDhnWEI3YWhuSTVl?=
 =?utf-8?B?T0dkUXpPMnh5SUxOUEJibkFPbnhqZGpobVA1bkZwQ1JNeEptUExISXkvRU5C?=
 =?utf-8?B?VVVKaU8rVTZSU1JYcjhCbmdncG9lZDlFOXpSMUpBb1h5TDJpRXdQT2RWOGVK?=
 =?utf-8?B?eGtQL1JQT0tnZmErZHE0cjJGNWVRTFMrYUFGYlc3eS9KNkxWRWFVU0FLeFBr?=
 =?utf-8?B?QWFDVEM1N25icmdvMGFFSGF0aURLakpIQTl1VEZNSzBWQTJVREtxS3kzTDNs?=
 =?utf-8?B?cWtlZTM5VGw0eGRsTjkrVk53ZE1tWU4yMkNUMlgyMkpQc0ZpOW5hSGlsYURO?=
 =?utf-8?B?K0wweWx1RE1zcG50TmVQbnk5K3NGeEIyenpnb3NaZFI5RHBteTQzTkxOM1VL?=
 =?utf-8?B?MjBkbW1JNWUzTFptT0dZVFVoV0VQcHdtK2g2UE9ZOTBORXM4cXlVVVNxS1Jw?=
 =?utf-8?B?emlSME11K3c0WUtEN0l3Y0MyVi80aUxsaEV3bWlYN3VkVzkya3Q3a3NEZmFq?=
 =?utf-8?B?cVppWlFwdG1aUGY0a3l0U1p6czBxYXh0QmJTcHRtZk9CYmFSNTcra2R0dVRj?=
 =?utf-8?B?MGVWb1h0NmJZZ0FkaHNmaG1rNEVsTnlZV1FEYkgwc2dPSWlyekFuekdUQjBs?=
 =?utf-8?B?V2NUT2t4ZFNqZUdMQ0c2REhtTjFjNHJJWFI2WXN6eHpndHk3VEJWQXNwYTB6?=
 =?utf-8?B?NDJJZkFVSkU2UFM0MEJWcDhLTnVHaFE4T1dZZWJTSlAzQk5QNHppTWtWWHh3?=
 =?utf-8?B?VHRzbDhkZndwQnpja0VLcjlNL1ExWityVGZpVG9XS253eWpGUG51OGUwZHQ1?=
 =?utf-8?B?ZGJlSStqV3FJQlJCN3RENWJGR1BOMU0rVkUxQm1vQjFQSmJBTDEzNjJrMEZ1?=
 =?utf-8?B?R29YTG5wRVB5aEd6TFFTWk1TZ0lEcm5zMFdENkVSU1AzWFpiYTBvUlhydjRz?=
 =?utf-8?B?bkROcEFmYW92WnAzSWJrQWRxUEE4ZFdaVGpFOXZCRzg3d1Z2WmlHU2ZZZkNS?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1tCX4r/NJqmqQaa9POsbe9FPZt81RCjKtowvoMmZxMZ2ItfZMDsXGz9OsUPIGjj1isxLXj+4FdhEtQBET7pq+xkhjDeiWdzlLPuf+0fMbxM12/tPLvGbNU2hdH/cNZkOoAm1tDIP6QZLCzoDWkGm/au9pqZIlDGJajIBL9RIOYQcizp/3LdHmJhWK9NFqGOmYPZ/zUEh20aHb3I7MFceuTUdaEu/5jDKJ33EW1s7/9oSXunugBKYaEac2kvjzpB/9uvUqV4MPjOgaJyDFR4yzi/hqgPhgaIERdiw/dcOuvvDDMNai9CMbu9CdHYj+iZsTomk8euFr8EqLS+CMihppq3NCrbQpBt2jp79ZsMxBE2BKsZO1NMLhd00lZLgH8/6r7pXn86UA3boA6tfEjh8yKwcjpyDQjrKY483qGznqaj4ZyoH7X0i5yUBQqZutqZiEhux9+1nbi3NXq+bumac5RFOilO3YrOtELzl1nLizk4zbdm6r+SQIwUo/6U8bjkgM2MCpuPr6/NFjeF3FVLFNQB9sd34GVqKWRToZ3jXZzaxrXM4WFk6Uz9bO5BYH3+yY98pdJKWEQJTX7Tp1ZWg/6n/SH9A+utONUByzjT7n58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4641c70-e44f-4d50-fc68-08dde6e8cbb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:42:48.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQTnkBIpVFE2lwBlTUh3ptmuNiLiBjcaDP6jU7oMyEF7mMBnKjcckxtFBQSmIa1yXGmx1EWFOchPcNBwNNQPclqQ2hZuJFbUEw+vQgu9ekA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290089
X-Proofpoint-ORIG-GUID: GWpIHw_R6EdMf0fXi7_4h8_Mx-XvmjJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX7n37KGll+A9f
 yqLO42aOFpwDvm1d0pxxNeyHYYl5ZrAdQkVTYIUQepU2uHLHibgk59Ji7ayJVssVR51mFXz0fA9
 /sVeTUtysUt9PAWdc5ESx/pzD6++7+zK7nn+j4+c074aCnOw57XxGv/boOOVNrmOeSHVpKWmRwu
 SUBeLLbM4p9oQqEqzv0NdUikesB3fAet1TNKsfmisqjRKNe0tUZ6ZSERmbFb144h+HPhi9GkUsB
 eSnRvEQaAOYdkOBZCAxCMyrS9K0dyu2GFMm1ApbGZa28hk9lFS/wsuHbNbjJ7jW7DelJ93b/HB+
 ExCa0tJqR2GgQHNNn1ok3/Mfyt/ZGU0xG2Dt01kq1jhAamL9vLdVo4fSKNu/b6KS1NG4HMSm6Gr
 3Pgv33JyIq6kfTVQ2cVPUgxiQQDfww==
X-Proofpoint-GUID: GWpIHw_R6EdMf0fXi7_4h8_Mx-XvmjJ0
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b1842d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=IyrIm8NlDI8fC1_FnIcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13602

On Fri, Aug 29, 2025 at 11:15:17AM +0800, Yafang Shao wrote:
> On Thu, Aug 28, 2025 at 6:51 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Aug 27, 2025 at 02:50:36PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Aug 27, 2025 at 8:48 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Tue, Aug 26, 2025 at 03:19:41PM +0800, Yafang Shao wrote:
> > > > > We will utilize this new kfunc bpf_mm_get_task() to retrieve the
> > > > > associated task_struct from the given @mm. The obtained task_struct must
> > > > > be released by calling bpf_task_release() as a paired operation.
> > > >
> > > > You're basically describing the patch you're not saying why - yeah you're
> > > > getting a task struct from an mm (only if CONFIG_MEMCG which you don't
> > > > mention here), but not for what purpose you intend to use this?
> > > >
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >  mm/bpf_thp.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 34 insertions(+)
> > > > >
> > > > > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > > > > index b757e8f425fd..46b3bc96359e 100644
> > > > > --- a/mm/bpf_thp.c
> > > > > +++ b/mm/bpf_thp.c
> > > > > @@ -205,11 +205,45 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> > > > >  #endif
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * bpf_mm_get_task - Get the task struct associated with a mm_struct.
> > > > > + * @mm: The mm_struct to query
> > > > > + *
> > > > > + * The obtained task_struct must be released by calling bpf_task_release().
> > > >
> > > > Hmmm so now bpf programs can cause kernel bugs by keeping a reference around?
> > >
> > > BPF verifier will reject any program that cannot guarantee that
> > > bpf_task_release() will always be called. So there shouldn't be any
> > > problem here.
> >
> > Ah that's nice!
> >
> > What specifically here is enforcing that? Apologies again - BPF is new to me.
>
> The KF_ACQUIRE and KF_RELEASE flags enforce resource management. If a
> BPF helper function (e.g., bpf_mm_get_task()) is marked with
> KF_ACQUIRE, the pointer it returns must be released by a corresponding
> helper marked with KF_RELEASE (e.g., bpf_task_release()). The BPF
> verifier will reject any program that fails to pair these calls
> correctly.

OK that's really really nice actually! :)

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo

