Return-Path: <bpf+bounces-53495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53790A552AE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B03188AD41
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3525C6E6;
	Thu,  6 Mar 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I4YowYm3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LMzdbqwA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED025B683;
	Thu,  6 Mar 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281313; cv=fail; b=PBkQKbR8KJj6zhOyvProk1vj67VHmmzo8sOEjnCdnix34kVCl2YEmtII5orZKGcOGOSARDrn7QnGbwlXv2/Ebj2vmrz1kcACCowl8g4refGDfBJbwnWbixyQQzhK0qAIsrqCiw2CPzvQRue+SO1BI10ZPZsfM+AP47l/5fHizVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281313; c=relaxed/simple;
	bh=PRJHcH62SiyWbkJ+tsGfDWfB8kNtw9DoTG68wAZ/k/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TY3irXV2zxiH5hJLHRMKLt6RptSAmAtuHSP80AWZNicBmyv/+HRJQQwa6J9YBQVT05f28VrfwaJfh57aErT0Hap3NsXG3CQw9zW46EYoqp8cZ30MYAMitHit0WAu1sk+sKLAepRzdnM1zVY4LqaEM3UqcJYTNm7lbO7Yxdx97SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I4YowYm3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LMzdbqwA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526FiJQ0023458;
	Thu, 6 Mar 2025 17:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kABXpWbxt5jH/9NNANqIu3E5HlW5B/+hgLYtwkSV8ZI=; b=
	I4YowYm3YyTlUFBkHL37fCSuX3P/pBsRZ0q8pfA+b3aTIlKncmwUC3E59mn6e0Z4
	ROCFb7MA/jAYQpeLdXqIbTT5X1BjBXNFQFnN+9//9IjnskHZ3Lna2x6DyN2Fu5f9
	mbVYlzkqcnxTbgg78FxCTLV7efu34HzLgR8HKWAjXdze7ihT7ncvqZMuQKjuDgwX
	NIgsJRPduwCZ0nzJL+arYpAkPLhGQNp39i7UAo1ATGG68Y68TBkTnCk02PkuKGoA
	H/oTXbDNXTiEvhUG4h5LjPw3FTyIJo5zN8cCYe/P5XTKsU2JxSwiqx8JLqhsW1Ns
	jFVj/ZTi4tPT+iZUrhudwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r4aecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:14:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526GEQ7h019954;
	Thu, 6 Mar 2025 17:14:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdgeus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiTlgWwZKjh20EXKHOKgk/2jl+td4ublX6TVk4x0Tz7/e0WZaLxJse55Vj/MH7NCkBrN8/NmbbHravEHy2SyNwlKmRgIwfd+OV5cScm7EcAf57lrM00CTs0OT7FJ6u37B2LpHC5/eHbDvpRcl5/bWdmYNu85XrRIi88FhANG2hdFinyab+9w/PcMTNLB50TM1CqsUJOqMcnCvRFXh5JXrsZcYkk4AQVV2fJehR2SoMrtUc4I7wu6NgMIAzGGwkEJz5ndJyBm5jsQpEdPJs/vjH9fhCXzGJeSltuUDRm9xsHMQ89HHmRKmRK1Z8svXIi7T298thIXnUQ7PJgPZFocrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kABXpWbxt5jH/9NNANqIu3E5HlW5B/+hgLYtwkSV8ZI=;
 b=hif9RlvjIoSLj0DwDuPFcLw7p/+VhWghjGVcNYuclxMxSHMffbRUc/NvNJaXkJscxaxCJ5L9brRYDHjRotPibsUVZPXyiROBRt0vkPqnHcTqWKlqn4Klo1f3qNcf/cW4E4LD0cLoF44N7IZ0UDI3vNQKiFI5YGE0py9Vt+L5nUSXHyDm3p6WJqmlYvqFT6z5aAWLlDo4xA+2rj8akI9BODr/bvooxLI2H9ZbWQSadXm5lVKiXXZEGjDbIX1HLbrJ1RtxnkVAl0iVcXtAPdrrVh+agAc4cw4+QF+/TbagvEg9JZcsHLS6qqx2HkGbP6s2AZhCCH0QHM70l0gANSoOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kABXpWbxt5jH/9NNANqIu3E5HlW5B/+hgLYtwkSV8ZI=;
 b=LMzdbqwAh2dxfkAgzJOj6GLtaZefTMPHHZYb9wCwWHv6tWG1am7WGJo0ZIFEMl78QhNc9s0jRPXphVIJmay7A7gblzszORWUnjgQdCtBd+9NL6uvMkl1qP6YgrFedd6efaY81U4TAbka66oEdVrPm85PnrOH+o77IuJ33lSbYv0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6043.namprd10.prod.outlook.com (2603:10b6:208:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:14:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:14:47 +0000
Message-ID: <d29261bd-a08d-4519-88bc-96f19edbbc29@oracle.com>
Date: Thu, 6 Mar 2025 17:14:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 2/6] btf_encoder: use __weak declarations of
 version-dependent libbpf API
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <20250228194654.1022535-3-ihor.solodrai@linux.dev>
 <050b81d2c82f57f3e97b27c59198a08b1c8d7f7b@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <050b81d2c82f57f3e97b27c59198a08b1c8d7f7b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BL3PR10MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e382c-be66-4f66-107a-08dd5cd265a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3YvWVVDSHdDWWk1THNxOXFtdEVFc3pldHhBRnllcVZ4YmhwR2Q3eUdFd0Vl?=
 =?utf-8?B?WEVwZlFkN2hxakxTcXQ3SmJxbHdlYWY2ekNBNzhHeXdRZmdlSlZERHJSNEo0?=
 =?utf-8?B?TnRZN3Q2MnhuUWpiNW9kVHd3cGJiaTA4aDh3bklvRHRDbkJHMEFBeTQ3VlpT?=
 =?utf-8?B?elB5OC93cjBoeGRNdkV5NDd1LzJ0S0pLQWRHaVRwMjAzaURLZktDRHc0b1Zs?=
 =?utf-8?B?M0pLc01iaUswVFJLbVNjSFZ6YkdDRG9PM1FNU2phOS9OUFowSjlKZFpLU0xO?=
 =?utf-8?B?TGcxd0xqU3JzU0JWUlpwcy95bDJsN2d5U1Z2QzV0TWppbzA5aEdxWTc2Tmo3?=
 =?utf-8?B?bU9xaDIrL1VmZ081dGZZYmNZNjF4ZXpXakhDa1pDU3V6b1FGeVlQOW5TMytG?=
 =?utf-8?B?a1JnUjVUazc0d2lrMjQrVmZCc0ZhSWhuRXRSNTRUV3NRUEROQTVJUis1REFm?=
 =?utf-8?B?K3E4c0hyREFFN3ZWZ0ZwamM1WjFDamNrcmRFZy8rTWpWYVhmQjF0bHZXSG9H?=
 =?utf-8?B?MmdpbjlwL0dwUkFEQ0Y5ekdEWDhWYUMrSnFMc0s4R2Q1Z2xFYkdZeUY0cXdQ?=
 =?utf-8?B?ZUp2WWRsNTFkdkMrcEpBd2RjOG9OS2l4QmR2TTF1NVNucy96NFZkMkJlTklK?=
 =?utf-8?B?eWRkM1NRQThqWkx6OWlEZm14Lyt4NGpiWSswbDlTSjlGcW4vbm0wTHZuTkkw?=
 =?utf-8?B?b2pOcVZoUnVHNmxjWFJQRTlnbXorM1NIN3pabkNNZWhkaXJ0a25sekhqRjJP?=
 =?utf-8?B?djFJTXRBUVVFc0lFQnhlWDM2VXJOaE9nYmJ2M3ZPU2Z5WUZPU25xWVkyQjlz?=
 =?utf-8?B?bVRlbXZ0RW5yTkdMWjVEWndOQ25tbk4wWDFhZFYyajgzZVIvWStOb3Ruaktx?=
 =?utf-8?B?N3hHcGtQMTJWdXYwZ0w2VU9lU2l6a0xGbi8zZFZjUU9CVVo3NWI5Zi9uaW1k?=
 =?utf-8?B?Tm1HTTgzdjNjL3Q0dHhZeTEzMlRvOENjNS9DQkhobW5XTjFFL1p5YmZkc3h6?=
 =?utf-8?B?SXN3YVMzUStOcUgxWnB6eE5XUXoxRW5kUWFzUnJxZEhOU1hjd1NrQmVJS0pV?=
 =?utf-8?B?TFp6U0R6SUp5eHpVdnlWL3BMcENnRy9RNk5COTVnN2dJd2dIYTRFVVA5aFZV?=
 =?utf-8?B?VzJYWWRDRjZ4NXc4NnVFd2Z1WDFZL29qSGE0Wks4aXVUMGN6VkZkNXRLK1ZM?=
 =?utf-8?B?VnVNRGhrN0U3SnJvWUp4Qk93TC80cDA3T2ViVTlVdmxBZEFlQkUwMGo0cFJJ?=
 =?utf-8?B?SCtFY01ETEdnUEpJaENLSDdkMlNIYkxiSU9JQWRFcENaTzFHejA1R1h3M1FW?=
 =?utf-8?B?Um5wV2dNNVRFL2FuUUJmYlJ4VjBEbFVNakJXaC9JRG5vQ1J2TzlxTkFSWUJV?=
 =?utf-8?B?Y1NsSWlwcXJnR29sY1RxWFNEdVJvRHNCT1FFY2dQb2RYYUd6em1OS0U1blpx?=
 =?utf-8?B?Q2FCMFNOaW96MmV6MFlWVG5NaDI2STJleWF6dUNLbDg0VCszTDlNakJMVEV4?=
 =?utf-8?B?SjdqQ1BTVklndFN0cXBDNlltd2JLY1VERmVNQStjL1I2aVcwQUt2UXpSNXUy?=
 =?utf-8?B?d3BLaWVBQjd3UkNWMmprVk9iMS9DeVJjOVc3dmg3MHFPZUZwaXF2RWhmR2E0?=
 =?utf-8?B?UkJrYTNFMW5DOFpXTEREVGRBTHNzSmE4OEltUEg4RzcwNlQ0R1NXSDYyMnJs?=
 =?utf-8?B?NGNHcmhUaDZlM2pGRDZudXQzUjFvUGMyd3FUcGNJTEo0UUhzOU5BcEkvS0JR?=
 =?utf-8?B?Z09uNjF1aEYyMUdxRVBkdU1BQ3RiKytKWnZDeCtvNitMc29RMWZlV1BocTFw?=
 =?utf-8?B?VXVMaUtuLzJ4bE9PRE5UUlowTVh6RVFOeHFQckhzdDVjK3ZUM1lzTWtvWFBn?=
 =?utf-8?Q?gUmHGOu9Z8CVw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFtT3lpbzF4SFpwU3VIWkYrcWpCaXF1dENNZzMzOW9nc3VkK3QxcjBtYnpa?=
 =?utf-8?B?MG5ScnEraHpKelR6K0VTMmUxUHIwME5DeTBRN0Z5NkpzV0xlbU4yTHFKRG5F?=
 =?utf-8?B?U0VGTGtaR2tzdDhlY0lCZ2d4d3I4VFVMRjV2ZG10UTJteEN6eWgvU3RaRnhk?=
 =?utf-8?B?QkozM3A5R0E2RGxYTzE0ZFJENUI3NnM3Y2loaGF6TjlTVXFMWWlySG81UkpJ?=
 =?utf-8?B?OUFoTUUwYUhHbDFVbzVqZklZbmU5ZFhLNHUwRWJ2bElhYzN1ZzBhQy9zZVV2?=
 =?utf-8?B?UXk0S3Y4QXYycDlPZXJiVHRieS9IQmVBODlPbS9LdXNlU0MvR05TNXhqWGlk?=
 =?utf-8?B?ait4UVh3OU50MU5RN1I5RFlEdHdnbjlaU0t5Vi9QNW42NFRjWFpyaDlGTCtQ?=
 =?utf-8?B?djdvU2FiZHg0WEMrQW5qV01tTzZJaWJMeis0dDZRRzhGbjRob2FMN2xKdHE5?=
 =?utf-8?B?bnlYZmYyTytoMEFWYnRqaHJNSnN3RjhlZDZVR0JyQXRnT2FkQmo0ZWxjYW0z?=
 =?utf-8?B?dk90aEhIRDhFOGxDNlpVUjZCOFN4YlFFcnNMamRIREZRaG92U2lMeThwY1ZL?=
 =?utf-8?B?dzl0c0ZYVnd0YUNEcVlOK2pHSzREN0hrUEt2SUc1b1hrd1F1WUtYTnk4R3g2?=
 =?utf-8?B?d3FwTUN6WDZuRXdPcjJTUkQ4NzhZRlhwVUtXcTZubjdFOWw0UFA4WnBaeGFC?=
 =?utf-8?B?Y1JINHg5UnlySHhlRjN3aHhDaWRFRVZGSTd4SnJIbVcrdkRndXhwZ01iZXBw?=
 =?utf-8?B?bW1uVk0xVzh3eFZDQW5RRW82MUg2V3MzN2xkYUtkNSsrUDRLRkNLQVlmT3Vy?=
 =?utf-8?B?Tm9FODUwdUh5dXFoa2kyTFRXY0RwOUlPazMyV3c5amZVbTJ2WEtNeGlIU29x?=
 =?utf-8?B?Q2lKeFMvRDFjZVZMcGV1cGNleEdhM2VEMC9SZWxxdmI0MjBqTEUxVGdYMDFP?=
 =?utf-8?B?Sms4UmM2dmU5QWZsTkpqSHl3c0paN1pvR3dUOUR2ZUV0eFRTazJYYjNHcG1H?=
 =?utf-8?B?UlQ3ZmlKbTB1dmNIVFlUU2N6Z3Niak1HZlZ3YVh1OXhiem0xY2xzMDBGR3p5?=
 =?utf-8?B?S3BYN25OcllpbE9rbjkxMGdIQnRYQkZ5ZzZqNU1QUkJEem1DbkM5RDh4U3Ru?=
 =?utf-8?B?Ri9rbnhnYTNocTBNNkppSFZQQkp1alJtcHRpS01YVHgvTmZGRXdUZE1adG51?=
 =?utf-8?B?NkFxY0t3T0lNSzhrd09Fd08xMU40UW5jNS9JUEV5aTN0RG9jaWRiQlpBTDlp?=
 =?utf-8?B?RFdFREZZSGpNUlNjWWp6dDc0QjVNNUtQRkpJRjRVS1dBSzdpVFdDWkV2Z09p?=
 =?utf-8?B?Vi9UNXdtRlB4YVovQ09GVGJmZThpYlNqWm13VHA0V013WlJ6YjV6RGowbVNW?=
 =?utf-8?B?ZnE0NW1JanN1ZzhwUTZHajJxNk9wRWRzUVpJc3JZdHB1MHBXU0tCU1F5MkN3?=
 =?utf-8?B?Mk5wZzZDVmJmTUFBeEdabFRiS25TSUVqZkY2QlZzbXBpUVNJa0UvOFYzNnJS?=
 =?utf-8?B?QzZWakR2NFkrOTZmbWRJUjhEMG9aODN2M1krR0QyY1doTk9ZQ014YVZBazRu?=
 =?utf-8?B?T1p3UnMzU1RhNDZENW5hRWduVWltaU10Zm1PVDdVSTZRWUM1N0RwU2M5R1p0?=
 =?utf-8?B?M3V1bjI5V3d3cksrNm84MFNYaVc2UnFFN1pzL2h5amJERGYzSTkzekVTcVEy?=
 =?utf-8?B?Vyt6Vkx1MkxmeXZ4bGozaXJjRHNIeGRseWxhcUswbU9kNnpLU1dOK3hhS25P?=
 =?utf-8?B?QXhSOHpYS0NSdk5rWHMzME5oQy9TeFkxQ215R3kyalpIY0JjTlliSGIrZHM0?=
 =?utf-8?B?WlNCb0owVDhzWENlR1lGREVYYnh4NElZVUpqWHB6SjcweGpTbzNWaWFhQnlU?=
 =?utf-8?B?aGRpaVF3S20yYXEwYzdEb0dscm1NYk5hKzRGTzhId1JQcFhxN20rdnlycGd3?=
 =?utf-8?B?YzFZblc2SVR2ZnJSaHk3RVNFemdNN21wbnpuSmZoNzdKYXY2TVVUdUo0SlFK?=
 =?utf-8?B?S2k2UmI2TkUzWWI1QUx3TURtWTFtU1RrVHJUVGR3M2JqN1NRZFVabG9SU2NJ?=
 =?utf-8?B?b3hhSFpoVGxSUk1qMG4xS1BPdDFlY2s4MG54NzBPdVE4N1VJaFF1M0hLMGhU?=
 =?utf-8?B?em10bU0ycDY0K2thWXF1Zit1SGJ4UFFFS2EzdldNZU5NUFJhNTFva3c4aWxa?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wbzs9wPeY/bUvEa8QlngEBudHxLemuyrs6cZ2K0SpXmDQMNQhU2SJEAhsaiR/hmU+TtIbolCaKVPXTE3kmNCR48afAxofqKhlgu19dxvElev+ey0Ahsb7ZiFWsHk2yyMaNEGjWTiZTZuUffkYpx2z8EnwO+JXbzS0APR67ejxQO0hZLi8z+SJMr+yXNS8SxzcMROc/MUoc+5lp1tC2Gc+oz09Bt+AMYvbgWfQcXfT0mZyeloDdXZ17QeAbMtZl7qRHci7YLIUpBQM9ZrB0nB6RBYVq6F1y5pS1loIN2k8bip7ORI4cKgO2/qT1RY6s6/sZFp4u7Vw6csXcqlmctzOXg65DVYd8cJfBxoGFLxf7g/mgQkxGTwcA47YIr6RRA9CJJ+aljYzqajTWPu2uxjUCnPeR5+0k0MK2wajwrM5KzS3aRZKwC0nWWYyuFpQvUM1Muja+znBI2pb9XfTBbn1umCTGw6CCN9F5SQenjd0JZTZK/j517LrxAMQ37c0KjDkP8+bxYSOTwfbkIUcxvyghZd6APKrh2Qi7JifQjzSwuaaRe8IRJImOsqAhy4V2c75y1erBHWIiFdPJMjLnH4N4IYN3OPqtPUPNzWrd5Zg+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e382c-be66-4f66-107a-08dd5cd265a0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:14:47.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeZqrIrKo/tunRiivVgnkYcYRX2zhBqoluPzHb2zBlgPwRGkTSzdfsV6JpvRs+8CIRZvNP0QyT/KCaCbnQiZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060131
X-Proofpoint-ORIG-GUID: Q1Ik4qwOHxg0AIe6Gj0vxG6FcmM4Jqyq
X-Proofpoint-GUID: Q1Ik4qwOHxg0AIe6Gj0vxG6FcmM4Jqyq

On 28/02/2025 19:53, Ihor Solodrai wrote:
> On 2/28/25 11:46 AM, Ihor Solodrai wrote:
>> Instead of compile-time checks for libbpf version, use __weak
>> declarations of the required API functions and do runtime checks at
>> the call sites. This will help with compatibility when libbpf is
>> dynamically linked to pahole [1].
>>
>> [1] https://lore.kernel.org/dwarves/deff78f8-1f99-4c79-a302-cff8dce4d803@oracle.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  btf_encoder.c | 48 +++++++++++++++++++-----------------------------
>>  dwarves.h     | 11 ++++++++++-
>>  pahole.c      |  2 --
>>  3 files changed, 29 insertions(+), 32 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 2bea5ee..12a040f 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -34,6 +34,7 @@
>>  #include <search.h> /* for tsearch(), tfind() and tdestroy() */
>>  #include <pthread.h>
>>  
>> +#define BTF_BASE_ELF_SEC	".BTF.base"
>>  #define BTF_IDS_SECTION		".BTF_ids"
>>  #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
>>  #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
>> @@ -625,29 +626,6 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
>>  	return id;
>>  }
>>  
>> -#if LIBBPF_MAJOR_VERSION < 1
> 
> There is an identical condition in btf_loader.c, however it guards
> static functions, for example btf_enum64(). I decided to leave it as
> is, although I find it unlikely that someone would use libbpf < 1.0.
> 
>> [...]

yeah, I just noticed we've got a minimum version requirement of 0.4:


                pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)

That needs to be revisited in the future to be > v1.0 I would say. To
test libbpf shared library support, I tried building with libbpf v1.2,
but hit errors around absence of struct btf_enum64. Looks like these
compilation errors resulted from not having an up-to-date
/usr/include/linux/btf.h (IIRC the libbpf repo ships with a copy, maybe
we should do the same?). The errors are not caused by your series, so
not something you need to worry about, but more work is needed to better
support shared library builds even for libbpf > 1.0 it seems. Thanks!

Alan

