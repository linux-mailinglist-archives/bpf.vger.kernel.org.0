Return-Path: <bpf+bounces-36529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6B949C55
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591E0285416
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0430176230;
	Tue,  6 Aug 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unl.edu header.i=@unl.edu header.b="s5FuQlYt";
	dkim=pass (1024-bit key) header.d=huskers.unl.edu header.i=@huskers.unl.edu header.b="RNOtWky7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00246402.pphosted.com (mx0b-00246402.pphosted.com [148.163.143.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE639FE4
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722987262; cv=fail; b=m8I4MvJKDhM94fr2B9Avv5krIxmy5f9EsKBPPRd8kkwebJStEJ0wsUBlOh0xpn6Wbn46McO0ThIeTRQxIdgflldrzNFIdpiDssufC4Mw0CyOsFJ7kRku6S82/LNX0sd4GosPzmL/NFJsnTZdwQP9CM5bKum4JLxKEbfQXz6cVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722987262; c=relaxed/simple;
	bh=4a74DTpSKAjkxKCRrHYUnooWBQxMaW7AUuUaWTwCuxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=un0LNNMGsC/VYHJXhSHx37U0P0QCXRFWOn36Y8+WvKduvl27RJxiDhOTpinVxcAehGRzlO3SC9vNFcp+sgiow7OLxKoD54nB5vYeUDuy1Tv/zb7b69Z9HafBA3tG71inoBNNXZ6kt0/Yt1to4NujeBxfAoVBJ0ITofOGxBvsPvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huskers.unl.edu; spf=pass smtp.mailfrom=huskers.unl.edu; dkim=pass (2048-bit key) header.d=unl.edu header.i=@unl.edu header.b=s5FuQlYt; dkim=pass (1024-bit key) header.d=huskers.unl.edu header.i=@huskers.unl.edu header.b=RNOtWky7; arc=fail smtp.client-ip=148.163.143.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huskers.unl.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huskers.unl.edu
Received: from pps.filterd (m0412004.ppops.net [127.0.0.1])
	by mx0b-00246402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476IR2Pe031197;
	Tue, 6 Aug 2024 17:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unl.edu; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pppod;
	 bh=G5dPJIGqnMtfMRIxgTXQkqyWu+iMnZ0TOI7ThM31B/w=; b=s5FuQlYtatVO
	e4tydUxZpoilSBnTzaoFzUSJ3tUHn8qVErkoULcreeBxQUTN8/BU4H52HOrc64Y9
	ncQBK7fZeXeYjGWGYYX/TQAA2dOUCZ4cxAAqAKj2pVMbmo91PBtdqa7Muo7BNoiq
	yfXcnlwqV7bvxPQUsORxoL3MHzqi+cy6j0xLARpQVC+sc1kZ7M4nCmvmBfHo6yFu
	6B8ifTqeBEzhv0oapft5OzVBVSYUs/LeLQn2AXgwLrWy/j4nX6WYnxn6Qjq83fgY
	Kx66e2eP8iGcuV/LCVi7pKbmD6ouWU969ABN1SommbosiHFusl2fSf8EcQox6SBD
	17BPnWmRgg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx0b-00246402.pphosted.com (PPS) with ESMTPS id 40umnhsx8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 17:55:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kORpe6QzPWnarlR2LZoaUBow9piycxWU2bs3QSULpXhkoxXeUnTdOCFMAL721hdCvKRBUIUk3S2n/MbvLWXHReTJaMjXNYOip2BuBGEsKn7j8DD11a4PGKkeySygy8RRPSJ0XGzVlSRI3sNFpSLjHb+XIRfi4CEn/J5avWQC5QQpVsKjYysLC4OgUl8xxaOyXpDUaRKS7Mz8mdjoq5GvmcAmCTBL/XnQ4xLi/wGAAaje2R/wD7MCJcOI9rCaChfBa+uthaNBEQcjydccGyzoxbg8aftXUnhqGfEEciEBXj/LbNVuaIjonD9o9Y/Ipsv1XTZZSjfcmRKUwMN8zy8L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5dPJIGqnMtfMRIxgTXQkqyWu+iMnZ0TOI7ThM31B/w=;
 b=dDktON/dUw9tr8OeMv0HwzLZy957119FUYGP+5kdODs38ynnRu/sjSY4kPK198MzyLaeETv28iCzaUchCx6Q7TGPsByd+UwrkYzSwKapWM0wKtLJVShx4SgrXxAPOi8w8aB6rGypudFdusaBbKi46KACObQ+I7AZtaG8PFi2orUEQlFuJC1TcDeTKLS0QTTE5pcoWXXNW/seRtZcnb0r/L44VKIlGgiuuFJqMZ89UCaz6XaKHpZQ2YRAV1j/0htqg7umrQ0aY8fTm0+8sbVb+pJaA4QgwhXmT36daAPS1xTE0hI4iZHpHI94qgWZBtirAulS3nRfyF5VS6Evf3cUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=huskers.unl.edu; dmarc=pass action=none
 header.from=huskers.unl.edu; dkim=pass header.d=huskers.unl.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=huskers.unl.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5dPJIGqnMtfMRIxgTXQkqyWu+iMnZ0TOI7ThM31B/w=;
 b=RNOtWky7rjj3dqdi+IU27UMGXnrJC8kNPyD0umU7VL8/yUbg/IHI9lEoBGWVgI7RUDcF9I6b2bEr3yj/bTLhJy4MWjCu5gvGr2LoIvZdTN5CGlFNG05jEKSzPs3Po4rBILrRUAHQhvjVDJByb0BYGdoSzVq86euj/PM2PSYYdL0=
Received: from CH0PR08MB8662.namprd08.prod.outlook.com (2603:10b6:610:190::22)
 by LV3PR08MB9483.namprd08.prod.outlook.com (2603:10b6:408:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 22:55:54 +0000
Received: from CH0PR08MB8662.namprd08.prod.outlook.com
 ([fe80::59a8:55f7:b002:71b4]) by CH0PR08MB8662.namprd08.prod.outlook.com
 ([fe80::59a8:55f7:b002:71b4%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 22:55:52 +0000
Message-ID: <f98a6451-eabb-4f48-8975-bebcc297593b@huskers.unl.edu>
Date: Tue, 6 Aug 2024 17:55:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Assistance needed with TCP BBR to BPF Conversion Issue
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <CH0PR08MB86628C12C14CCAB20681BCA38EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
 <CH0PR08MB86623CB07E3EB7CC3D370AF78EB42@CH0PR08MB8662.namprd08.prod.outlook.com>
 <996212bc-c9e8-4486-a7ce-1869599ff01b@linux.dev>
Content-Language: en-US
From: Mingrui Zhang <mzhang23@huskers.unl.edu>
In-Reply-To: <996212bc-c9e8-4486-a7ce-1869599ff01b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::16) To CH0PR08MB8662.namprd08.prod.outlook.com
 (2603:10b6:610:190::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR08MB8662:EE_|LV3PR08MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 228caa28-52fe-4bdd-59f9-08dcb66aec33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REtmRXZnR2xnZnBVQUZ4bzZHektKSWRWbnBKdXRCYXlBL2FPMTlBRXJpc1Ni?=
 =?utf-8?B?ZDM2UWg4MFZUeHdEeGF0dWJhV0lZaUNCWW1EMzRMZ1pBdUJvTjhUanpjZGZH?=
 =?utf-8?B?d0taY1pXS1hJVG1ISzBUMEFiZittWllCTHg1SVA0bUliQXp3c2k5cWxXRlNo?=
 =?utf-8?B?Ui9uUTBTbEszckpLVitJVjlhR2J6dzRvekU0UDNUQVhkSFBNM0JaZ3V0M1By?=
 =?utf-8?B?aXRSQjlQdjBVdjl2NzEzUTVGYVVCdGdJcHVXU3kxSkozOVB1R0xYcTc5d1A3?=
 =?utf-8?B?RDhNanl0TnhXR0lUaGQvQU5rS3VkR2ZLZDB2TlJiTHNRb0lkTmx1UmpkZGdH?=
 =?utf-8?B?NjhkMzVkME5sdVNFRGVIdnBqRHI4dGFNai9Tb2tmOTR1bkcxa2U1RjBjTmM2?=
 =?utf-8?B?SHFBdWQyaVZORHBHMGtwQmVWNmluRUJNeitEbW95cVd1UmhwdmNYOHVGNDRs?=
 =?utf-8?B?a1ZIanpLNlF4RnBPYk5lYS9haUM0ZlpBQ0d2U1IrRDRKRTNKTDdxYUF0Tlly?=
 =?utf-8?B?Q1JwQytuMVd4MmFyM2EwcjhBSFoxbjlmYlVkby9nK1hWc1Jadm9YekJqbkNm?=
 =?utf-8?B?Yi9FTFMzZzRnUFhMQm1qZUE2VHArbFFCSWxVN2I0WjNQYngzdElGTVhkeHkw?=
 =?utf-8?B?OCt3SWtpQjJxN0wxUGdkY2tLcmE5QnA0Z3Fkd0lZZHdzcTViZFFGSGJ1WlNR?=
 =?utf-8?B?YnN0cnVDbno2b3NMZmJod0hQUjVMb2dybm1RZHNZa1RTVlB5M0xQV1A1cjBJ?=
 =?utf-8?B?TmZsMW42dEtXeE5YdFdLOE1IVlo5bC9pTDN5U243SHBMQysxdWZudG56bFRW?=
 =?utf-8?B?Q2oyMFBRRERHSTdLZ3F6cVJscVBvM2dtQUJQRTdvMnlyNTRJZGZndDRkOWRE?=
 =?utf-8?B?cWZRTUE3R2FjK2d5Tk1MQWFZVElnd3pSY3ZyaVNhWjdJNXFUMVlNR2swTlJF?=
 =?utf-8?B?Vk5CWDRlLzZSaExzVTRZU0xvZFl3NWZVWjVFNGpNT1VxdlJSVml0NEdNWTZt?=
 =?utf-8?B?Z1ZzT2JranVFMUxqVUhmVmNVdGVScWNkTUQyVkJ0Q2hIR0t0di9GUHF6MGc5?=
 =?utf-8?B?VTQ5bjI4RE0yL2E2Ny9NaEx3elhnc21wZ0t0dlFsc2t4YzdzTkVPWWQ4dnM1?=
 =?utf-8?B?Y2tJUnVvZVYvWUJ3QWtuOXFQV2VCbGhybFlXdlBrQ2xnZTdVbVRGcEh4NHR2?=
 =?utf-8?B?ZjZlS3N4RXVuZVRveWQ3bHFhalZOWFl0a3BSRUVnV3pzS2Z2SFc5WkVmVDVM?=
 =?utf-8?B?ZUhBcllhWmNoNUovN2lDSzB5dDRCbVkyODVTakdCbkE1WDA2MEl4MTdCb0NI?=
 =?utf-8?B?NTYrK3dhcmtyWFJaNnFFZU0zakNJb2w0TDMwbkFRUFFlWlZFSTQ5ZFJNelhG?=
 =?utf-8?B?V2ZXTG96eE9WMEs2Z0VWcENjY0VHZnA5aDd3ejcxMnl1aXJRb0tSVWFUWVJD?=
 =?utf-8?B?U2FLMk5UMnkwaEJNVEhYYkhQS3ptU3VoS05VU1lGb2Q0ellZQ1luaXNWYUN6?=
 =?utf-8?B?elJUN2UwM08vbnpLNVQrYU9YSjBOeG9uR295aGFaZDA3dmxocFJuelN3L29M?=
 =?utf-8?B?dlFUc0dPLzlvcHpzdFNsRmtNL2VRbFpnTGc5ZzE0ZXdUVEFoZEVYZzI0SDNI?=
 =?utf-8?B?RVlpZHJZbWtsZlBZWTV0Q1hrZWZCcHJEdmhNN0JwN2FxTWs4SnJqd1o4VHZB?=
 =?utf-8?B?c0hycWxBdXRSVkdDVlc0TEdIbmhWakh3Zmh5SVE0RlpIekpXMHFTNFM1ZUxy?=
 =?utf-8?Q?nyzZviZ3AMf0fG+UGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR08MB8662.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpOcU16enE3RldOS1RFbzF0T0tBWnYzQU5oS1Fnb0JmWlMxc3MvNERxNXh2?=
 =?utf-8?B?Rm5VeWtwMHNTWFBrZEQ4Y0l1ZjdjLzhSdWVzWTVlcjk3TGVrWElueW1CVDVr?=
 =?utf-8?B?dkVrazBsajc1OGwvNUdJYmtDbi93elFpbk5SZ2F1Y2dFZ044Q01iMDlGWXFo?=
 =?utf-8?B?MURsbGh0UnlCaDNBdCthUGxIN01DYlBEdVIzUHd5Qk5PNnREUS9UUWhZaWxP?=
 =?utf-8?B?WTJwVnNEQ1pDME15THVYbXIxZWlUSmhuOEMyNmV3aTA2TldyQXQ4L1VUQTVp?=
 =?utf-8?B?ZWpMSEkvTXhqQnRtRWlncmU4bXd5TkFLbDNFMkxXK0k4WGl5a1BrRHdwQkZQ?=
 =?utf-8?B?c3M1amcyMnE0cFN5MmwrRVNJZGw3N0tsWktlRlNRMTJaS29aOS94cnZ4NVRU?=
 =?utf-8?B?ZWtjd1Q3MzBDVFV6Zk5uYmFjTUJtaU9GaUxaNFZEcUVKUldLRUFJY3lCcDBq?=
 =?utf-8?B?UXFrbVFJcjVraG5TdU9icFhvNFU2TjlDd1pnNnc2eEVHSGhuVmMwZXR1L3Rl?=
 =?utf-8?B?QTN1WjcySUFPKytXTG54WUpNZmM4MTdWTzJpUXI3NGxKWlJ1OTNKalBpK0g0?=
 =?utf-8?B?NHBUN21QQ21odUdQaHJHMHhDUytmMG5zeUF3Sk9rWW0vdHZBUmVrZUdubytF?=
 =?utf-8?B?QWd5U3ZFZllackp2MnZsdHM5ZEhrekd0eGpzejYzVk9LSWNjbHU3OWtuc3RY?=
 =?utf-8?B?d1pkcDRlS25OODRyRnlSQ1hBVVk3bTBQMFRQbUhRK0c1a2txM3c1dDZBYXoz?=
 =?utf-8?B?eThwUkJIc1hpQy8vQmhQY3pSdkpBZE84MDZ0QXdNdGQwSE1mb3hsK3hBcEkr?=
 =?utf-8?B?dlI2ODNvNkZIWVlEb2d2RVg0Z005MTJ0S1lTVktFTS9UVjZHYjZncXE1Nzd4?=
 =?utf-8?B?NGtBdzM3NHR3R0ExMWkyMGpXTmhiMVBrL2FDbFZHWHIrSTlVQnE3R2ozeGl1?=
 =?utf-8?B?TkZmWFFVUVBVVHgzNjRGVllrc0pqcHVtSDZhaEJFWmtmZnMyNDFNd2djL0hS?=
 =?utf-8?B?cnAxRDNGZWdoUDBhM1hxa012YUdORkJFZDRZaUs2NEkzN25STU5Gd2tLaW0z?=
 =?utf-8?B?MXpyUUdIVVNGT1Fza09NSUtmcytsanNZb3FCS0NDMVliaDJEV09KOGVVclZ6?=
 =?utf-8?B?NG9zTXNqUlhSNWRmalpGTExIbUlFK0RWaWhTZlF3SDlVOCt5UDZxc2FKaGZO?=
 =?utf-8?B?dGo1UjBVVUJ1MDNEMTY0WjV2V1VHSWFmcEExK3lCYU04QWxuSlRSdU9sOU1m?=
 =?utf-8?B?dndUb29WeGQvSWFTYWZEeUNIaU9UUHdnWWxJY2QvRXhaQWVSNFRGdHMzWDhP?=
 =?utf-8?B?V09xTmdUcHBlWGF4RTNCWXFhV0hkWEFqdGhSOERSNDBRSVZLVWduY2pxTXoy?=
 =?utf-8?B?MkpIT21yWXdlb2lBT0pTcmRJT2d0L1N4Z0llMDJqZjNLVFJDQUJVUkpxUGw1?=
 =?utf-8?B?T1lzMkpVSHgyVXlNazk3OStpQUd5dW5SOFZSeEhlVmpja0tKM1UwY2NWWHVu?=
 =?utf-8?B?S0lqN3prMDVVcEdmQUNHcDRQRzRoY28yWmIwMGl1RWNWN3pveGovSUhrVmh4?=
 =?utf-8?B?d2VhZWxxVGFGQzQ1NzZkRVRVYWlxaGxLWFZDWG5ndzFwc0JIM1JpMU5waDJ6?=
 =?utf-8?B?QjlSNHp0U3Zhdkc1eTlpbU9UWXFMdEd2Wk1Jd2dUUTlVU2FSUVduVytEUG15?=
 =?utf-8?B?bFBqcmEzU0JiSVMwNGJwaFlMeTUxemRveFR5V1JFUkhrRjZqL2V3Z0U2NnIw?=
 =?utf-8?B?Y0F5M2JlOW8yTnU2aTRmOTgraDJvNG5UTDdveHRpaEtGOEdueXVDWXFWZnJ4?=
 =?utf-8?B?Ty9xK3dQRUNwdVRTak1tVlRjaG1PRnFjSmxtUVFvMWpnT1J3UWtMTzFJSG8z?=
 =?utf-8?B?Y2lJRlpVYTFYaUtRVDYwWEdMQlJJem5SVUpodW5GRGg3ZmlLNlB4RVhWNWh1?=
 =?utf-8?B?ZEIxQVM3L1krc0Y1TzBmWE9LMWUxRVNUMFdwZHFJZ3JwandYZ3V2dlhCbmU3?=
 =?utf-8?B?alBsck53SGNraHk1b1JaS3RDQ0tTbDE1UWpCb282cENhQlVRYVg1eGpqR25S?=
 =?utf-8?B?OWpDMkQ1bWdockdTdll6c3dEaE5lVWFGQ1lhMEgxOExGY2tvYy8yY0JmelR6?=
 =?utf-8?Q?BUWfCFmE6CJ5CWREKjD+cBEc1?=
X-OriginatorOrg: huskers.unl.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 228caa28-52fe-4bdd-59f9-08dcb66aec33
X-MS-Exchange-CrossTenant-AuthSource: CH0PR08MB8662.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:55:52.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fddb01ad-4983-436e-ab35-1af043b818c9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrMFPXUJYCrTG+1MXjWIWengzYBgsUPPcVztgKq0jgIW4zt0HcdciUz6TIMbQ5xRxcE2BkEQHyJHA6j4osquNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9483
X-Proofpoint-GUID: uUvCzLVn9KFZiWGJqMsda_Uw1k7NSc01
X-Proofpoint-ORIG-GUID: uUvCzLVn9KFZiWGJqMsda_Uw1k7NSc01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060161

On 7/26/24 19:23, Martin KaFai Lau wrote:
> 
> On 7/26/24 2:15 PM, Mingrui Zhang wrote:
>> Dear BPF community,
>>
>> I am a student currently trying to use the BPF interface in the TCP congestion control study for faster Linux system integration without compiling the entire kernel.
>>
>> I've encountered a challenge while attempting to convert TCP BBR to BPF format and would greatly appreciate your guidance.
>>
>> My modifications to the original tcp_bbr is as follow:
>> * change u8,u32,u64,etc to __u8, __u32, __u64, etc.
>> * Defined external kernel functions
>> * Removed compiler flags using macro (e.g., "unlikely", "READ_ONCE")
>> * Borrowed some time definitions from bpf_cubic (e.g., HZ and JIFFY)
>> * Defined constant values not included in vmlinux.h (e.g., "TCP_INFINITE_SSTHRESH")
>> * Implemented do_div() and cmpxchg() from assembly to C
>> * Changed min_t() macro to min()
>> This is the link to my modified tcp_bbr file https://urldefense.com/v3/__https://github.com/zmrui/bbr-bpf/blob/main/tcp_bbr.c__;!!PvXuogZ4sRB2p-tU!BA6ki-oKpxnuXh_P59nyMhh0dAGCRX8CNj-ekJOijmRTOZw6IZFuOcQvG9h5ZphbzlDn0tAcc4SjLAMU-8SHeSqCRISnKos$
>>
>> I use "clang -O2 -target bpf -c -g bpf_cubic.c" command to compile and it doesn't output any warning or error,
>> and the "sudo bpftool struct_ops register tcp_bbr.o" command does not have any output
>>
>> Then the "bpftool -debug" option displays the following debug message at the last line:
>> "libbpf: sec '.rodata': failed to determine size from ELF: size 0, err -2"
> 
> Good to see works in trying tcp_bbr.c with struct_ops.
> 
> It is likely the .o is invalid. Are you sure the program was compiled successfully?
> 
> From looking at the following lines, the kernel you are using is not the
> upstream kernel.
> 
> extern unsigned int tcp_left_out(const struct tcp_sock *tp) __ksym;
> extern unsigned int tcp_packets_in_flight(const struct tcp_sock *tp) __ksym;
> extern __u32 tcp_stamp_us_delta(__u64 t1, __u64 t0) __ksym;
> extern __u32 get_random_u32_below(__u32 ceil) __ksym;
> extern __u32 tcp_min_rtt(const struct tcp_sock *tp) __ksym;
> extern unsigned long msecs_to_jiffies(const unsigned int m)  __ksym;
> extern __u32 tcp_snd_cwnd(const struct tcp_sock *tp) __ksym;
> extern void tcp_snd_cwnd_set(struct tcp_sock *tp, __u32 val) __ksym;
> extern __u32 minmax_running_max(struct minmax *m, __u32 win, __u32 t, __u32
> meas) __ksym;
> extern __u32 minmax_reset(struct minmax *m, u32 t, u32 meas) __ksym;
> extern  __u32 minmax_get(const struct minmax *m) __ksym;
> 
> They are not kfunc in the upstream kernel. Most of them don't have to be kfunc.
> Try to implement them in the bpf program itself (i.e. the tcp_bbr.c in your
> github link).
> 
> It is hard for the community to help without something reproducible in the
> upstream kernel. Lets target for getting tcp_bbr.c compiled in the selftests
> first (under tools/testing/selftests/bpf/progs like the bpf_cubic.c) and post
> the patch to the mailing list. bpf_devel_QA.rst has some guides.
> 
>> Additionally, the new algorithm doesn't appear in "net.ipv4.tcp_available_congestion_control" or in "bpftool struct_ops list".
>>
>> I did not find much related content for this debug error message on the Internet.
>> I would be very grateful for any suggestions or insights you might have regarding this issue.
>> Thank you in advance for your time and expertise.
>>
>> For context, here's my system information:
>> Ubuntu 22.04
>> 6.5.0-41-generic
>> $ bpftool -V
>>       bpftool v7.3.0
>>       using libbpf v1.3
>>       features: llvm, skeletons
>> -$ clang -v
>>       -Ubuntu clang version 14.0.0-1ubuntu1.1
>>
>> Best,
>> Mingrui
>>
> 

Thank you, Martin. The kfunc you mentioned was one of the source of the problem in my code. I found and will more carefully read the documents for kfunc. 

I apologize for my late response. I have been attempting to implement the non-kfunc to functions changes and fix other potential issues. 
This pathch could compiled in the 'tools/testing/selftests/bpf/progs' folder with 'clang -O2 -target bpf -c -g tcp_bbr.c -I ../tools/include/', but still failed to register as usable TCP algorithm.
I appreciate you again for your support.

Thanks,
Mingrui

---
 tools/testing/selftests/bpf/progs/tcp_bbr.c | 1441 +++++++++++++++++++
 1 file changed, 1441 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_bbr.c

diff --git a/tools/testing/selftests/bpf/progs/tcp_bbr.c b/tools/testing/selftests/bpf/progs/tcp_bbr.c
new file mode 100644
index 000000000000..8060f11d40b0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_bbr.c
@@ -0,0 +1,1441 @@
+/* Bottleneck Bandwidth and RTT (BBR) congestion control
+ *
+ * BBR congestion control computes the sending rate based on the delivery
+ * rate (throughput) estimated from ACKs. In a nutshell:
+ *
+ *   On each ACK, update our model of the network path:
+ *      bottleneck_bandwidth = windowed_max(delivered / elapsed, 10 round trips)
+ *      min_rtt = windowed_min(rtt, 10 seconds)
+ *   pacing_rate = pacing_gain * bottleneck_bandwidth
+ *   cwnd = max(cwnd_gain * bottleneck_bandwidth * min_rtt, 4)
+ *
+ * The core algorithm does not react directly to packet losses or delays,
+ * although BBR may adjust the size of next send per ACK when loss is
+ * observed, or adjust the sending rate if it estimates there is a
+ * traffic policer, in order to keep the drop rate reasonable.
+ *
+ * Here is a state transition diagram for BBR:
+ *
+ *             |
+ *             V
+ *    +---> STARTUP  ----+
+ *    |        |         |
+ *    |        V         |
+ *    |      DRAIN   ----+
+ *    |        |         |
+ *    |        V         |
+ *    +---> PROBE_BW ----+
+ *    |      ^    |      |
+ *    |      |    |      |
+ *    |      +----+      |
+ *    |                  |
+ *    +---- PROBE_RTT <--+
+ *
+ * A BBR flow starts in STARTUP, and ramps up its sending rate quickly.
+ * When it estimates the pipe is full, it enters DRAIN to drain the queue.
+ * In steady state a BBR flow only uses PROBE_BW and PROBE_RTT.
+ * A long-lived BBR flow spends the vast majority of its time remaining
+ * (repeatedly) in PROBE_BW, fully probing and utilizing the pipe's bandwidth
+ * in a fair manner, with a small, bounded queue. *If* a flow has been
+ * continuously sending for the entire min_rtt window, and hasn't seen an RTT
+ * sample that matches or decreases its min_rtt estimate for 10 seconds, then
+ * it briefly enters PROBE_RTT to cut inflight to a minimum value to re-probe
+ * the path's two-way propagation delay (min_rtt). When exiting PROBE_RTT, if
+ * we estimated that we reached the full bw of the pipe then we enter PROBE_BW;
+ * otherwise we enter STARTUP to try to fill the pipe.
+ *
+ * BBR is described in detail in:
+ *   "BBR: Congestion-Based Congestion Control",
+ *   Neal Cardwell, Yuchung Cheng, C. Stephen Gunn, Soheil Hassas Yeganeh,
+ *   Van Jacobson. ACM Queue, Vol. 14 No. 5, September-October 2016.
+ *
+ * There is a public e-mail list for discussing BBR development and testing:
+ *   https://groups.google.com/forum/#!forum/bbr-dev
+ *
+ * NOTE: BBR might be used with the fq qdisc ("man tc-fq") with pacing enabled,
+ * otherwise TCP stack falls back to an internal pacing using one high
+ * resolution timer per TCP socket and may use more resources.
+ */
+// #include <linux/btf.h>
+// #include <linux/btf_ids.h>
+// #include <linux/module.h>
+// #include <net/tcp.h>
+// #include <linux/inet_diag.h>
+// #include <linux/inet.h>
+// #include <linux/random.h>
+// #include <linux/win_minmax.h>
+
+// #include <linux/bpf.h>
+// #include <linux/stddef.h>
+// #include <linux/tcp.h>
+
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+
+#ifndef UNLIKELY
+#define unlikely(cond) (cond)
+#endif
+
+#ifndef WARN_ONCE
+#define WARN_ONCE(x,y,z)
+#endif
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+#endif
+
+#ifndef READ_ONCE
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#endif
+
+// Borrow from bpf_cubic
+extern unsigned long CONFIG_HZ __kconfig;
+#define HZ CONFIG_HZ
+#define USEC_PER_MSEC	1000UL
+#define USEC_PER_SEC	1000000UL
+#define USEC_PER_JIFFY	(USEC_PER_SEC / HZ)
+
+// Borrow from kernel
+#define NSEC_PER_USEC	1000L
+#define MSEC_PER_SEC	1000L
+
+// Const value define
+
+#define GSO_LEGACY_MAX_SIZE	65536u
+
+#define MAX_TCP_HEADER	(128 + MAX_HEADER)
+#define MAX_HEADER LL_MAX_HEADER
+#define LL_MAX_HEADER 32
+
+#define TCP_CA_NAME_MAX	16
+
+#define TCP_INIT_CWND		10
+
+#define TCP_INFINITE_SSTHRESH	0x7fffffff
+
+#define TCP_CONG_NON_RESTRICTED 0x1
+
+// Borrow from bpf_cubic
+static __always_inline __u64 div64_u64(__u64 dividend, __u64 divisor)
+{
+	return dividend / divisor;
+}
+
+#define div64_ul div64_u64
+#define div_u64 div64_u64
+#define div64_long div64_u64
+
+#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
+static bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1-seq2) < 0;
+}
+#define after(seq2, seq1) 	before(seq1, seq2)
+
+#define max_t(type, x, y)	max((type)x, (type)y)
+#define min_t(type, x, y)	min((type)x, (type)y)
+
+// Extern functions
+
+// DIV and cmpxchg
+#define do_div(n, base) mydiv(&n, base)
+__u32 mydiv (__u64* numer, int denom)
+{
+  __u64 res  = *numer / denom;
+  __u32 rem = *numer % denom;
+  *numer = res;
+  return rem;
+}
+// From macro to C function
+//https://lwn.net/Articles/847973/
+__u32 cmpxchg(__u32 * ptr, __u32 old, __u32 new){
+  if (*ptr == old){
+    *ptr = new;
+    return old;
+  }
+  else{
+    return new;
+  }
+}
+static __u32 tcp_left_out(const struct tcp_sock *tp){
+	return tp->sacked_out + tp->lost_out;
+}
+
+static __u32 tcp_packets_in_flight(const struct tcp_sock *tp){
+	return tp->packets_out - tcp_left_out(tp) + tp->retrans_out;
+}
+
+__u32 tcp_stamp_us_delta(__u64 t1, __u64 t0){
+	return max_t(s64, t1 - t0, 0);
+}
+
+__u32 get_random_u32_below(__u32 ceil){
+	if(ceil > 0)
+		return ceil -1;
+	else
+		return 0;
+}
+
+__u32 minmax_get(const struct minmax *m){
+	return m->s[0].v;
+}
+
+__u32 tcp_min_rtt(const struct tcp_sock *tp){
+	return minmax_get(&tp->rtt_min);
+}
+
+unsigned long msecs_to_jiffies(const unsigned int m)
+{
+	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
+}
+
+__u32 tcp_snd_cwnd(const struct tcp_sock *tp){
+	return tp->snd_cwnd;
+}
+
+void tcp_snd_cwnd_set(struct tcp_sock *tp, __u32 val){
+	tp->snd_cwnd = val;
+}
+
+__u32 minmax_reset(struct minmax *m, u32 t, u32 meas)
+{
+	struct minmax_sample val = { .t = t, .v = meas };
+
+	m->s[2] = m->s[1] = m->s[0] = val;
+	return m->s[0].v;
+}
+__u32 minmax_subwin_update(struct minmax *m, __u32 win,
+				const struct minmax_sample *val)
+{
+	u32 dt = val->t - m->s[0].t;
+
+	if (unlikely(dt > win)) {
+		/*
+		 * Passed entire window without a new val so make 2nd
+		 * choice the new val & 3rd choice the new 2nd choice.
+		 * we may have to iterate this since our 2nd choice
+		 * may also be outside the window (we checked on entry
+		 * that the third choice was in the window).
+		 */
+		m->s[0] = m->s[1];
+		m->s[1] = m->s[2];
+		m->s[2] = *val;
+		if (unlikely(val->t - m->s[0].t > win)) {
+			m->s[0] = m->s[1];
+			m->s[1] = m->s[2];
+			m->s[2] = *val;
+		}
+	} else if (unlikely(m->s[1].t == m->s[0].t) && dt > win/4) {
+		/*
+		 * We've passed a quarter of the window without a new val
+		 * so take a 2nd choice from the 2nd quarter of the window.
+		 */
+		m->s[2] = m->s[1] = *val;
+	} else if (unlikely(m->s[2].t == m->s[1].t) && dt > win/2) {
+		/*
+		 * We've passed half the window without finding a new val
+		 * so take a 3rd choice from the last half of the window
+		 */
+		m->s[2] = *val;
+	}
+	return m->s[0].v;
+}
+
+__u32 minmax_running_max(struct minmax *m, __u32 win, __u32 t, __u32 meas)
+{
+	struct minmax_sample val = { .t = t, .v = meas };
+
+	if (unlikely(val.v >= m->s[0].v) ||	  /* found new max? */
+	    unlikely(val.t - m->s[2].t > win))	  /* nothing left in window? */
+		return minmax_reset(m, t, meas);  /* forget earlier samples */
+
+	if (unlikely(val.v >= m->s[1].v))
+		m->s[2] = m->s[1] = val;
+	else if (unlikely(val.v >= m->s[2].v))
+		m->s[2] = val;
+
+	return minmax_subwin_update(m, win, &val);
+}
+
+char _license[] SEC("license") = "GPL";
+
+/* Scale factor for rate in pkt/uSec unit to avoid truncation in bandwidth
+ * estimation. The rate unit ~= (1500 bytes / 1 usec / 2^24) ~= 715 bps.
+ * This handles bandwidths from 0.06pps (715bps) to 256Mpps (3Tbps) in a u32.
+ * Since the minimum window is >=4 packets, the lower bound isn't
+ * an issue. The upper bound isn't an issue with existing technologies.
+ */
+#define BW_SCALE 24
+#define BW_UNIT (1 << BW_SCALE)
+
+#define BBR_SCALE 8	/* scaling factor for fractions in BBR (e.g. gains) */
+#define BBR_UNIT (1 << BBR_SCALE)
+
+/* BBR has the following modes for deciding how fast to send: */
+enum bbr_mode {
+	BBR_STARTUP,	/* ramp up sending rate rapidly to fill pipe */
+	BBR_DRAIN,	/* drain any queue created during startup */
+	BBR_PROBE_BW,	/* discover, share bw: pace around estimated bw */
+	BBR_PROBE_RTT,	/* cut inflight to min to probe min_rtt */
+};
+
+/* BBR congestion control block */
+struct bbr {
+	__u32	min_rtt_us;	        /* min RTT in min_rtt_win_sec window */
+	__u32	min_rtt_stamp;	        /* timestamp of min_rtt_us */
+	__u32	probe_rtt_done_stamp;   /* end time for BBR_PROBE_RTT mode */
+	struct minmax bw;	/* Max recent delivery rate in pkts/uS << 24 */
+	__u32	rtt_cnt;	    /* count of packet-timed rounds elapsed */
+	__u32	    next_rtt_delivered; /* scb->tx.delivered at end of round */
+	__u64	cycle_mstamp;	     /* time of this cycle phase start */
+	__u32	    mode:3,		     /* current bbr_mode in state machine */
+		prev_ca_state:3,     /* CA state on previous ACK */
+		packet_conservation:1,  /* use packet conservation? */
+		round_start:1,	     /* start of packet-timed tx->ack round? */
+		idle_restart:1,	     /* restarting after idle? */
+		probe_rtt_round_done:1,  /* a BBR_PROBE_RTT round at 4 pkts? */
+		unused:13,
+		lt_is_sampling:1,    /* taking long-term ("LT") samples now? */
+		lt_rtt_cnt:7,	     /* round trips in long-term interval */
+		lt_use_bw:1;	     /* use lt_bw as our bw estimate? */
+	__u32	lt_bw;		     /* LT est delivery rate in pkts/uS << 24 */
+	__u32	lt_last_delivered;   /* LT intvl start: tp->delivered */
+	__u32	lt_last_stamp;	     /* LT intvl start: tp->delivered_mstamp */
+	__u32	lt_last_lost;	     /* LT intvl start: tp->lost */
+	__u32	pacing_gain:10,	/* current gain for setting pacing rate */
+		cwnd_gain:10,	/* current gain for setting cwnd */
+		full_bw_reached:1,   /* reached full bw in Startup? */
+		full_bw_cnt:2,	/* number of rounds without large bw gains */
+		cycle_idx:3,	/* current index in pacing_gain cycle array */
+		has_seen_rtt:1, /* have we seen an RTT sample yet? */
+		unused_b:5;
+	__u32	prior_cwnd;	/* prior cwnd upon entering loss recovery */
+	__u32	full_bw;	/* recent bw, to estimate if pipe is full */
+
+	/* For tracking ACK aggregation: */
+	__u64	ack_epoch_mstamp;	/* start of ACK sampling epoch */
+	__u16	extra_acked[2];		/* max excess data ACKed in epoch */
+	__u32	ack_epoch_acked:20,	/* packets (S)ACKed in sampling epoch */
+		extra_acked_win_rtts:5,	/* age of extra_acked, in round trips */
+		extra_acked_win_idx:1,	/* current index in extra_acked array */
+		unused_c:6;
+};
+
+#define CYCLE_LEN	8	/* number of phases in a pacing gain cycle */
+
+/* Window length of bw filter (in rounds): */
+static const int bbr_bw_rtts = CYCLE_LEN + 2;
+/* Window length of min_rtt filter (in sec): */
+static const __u32	bbr_min_rtt_win_sec = 10;
+/* Minimum time (in ms) spent at bbr_cwnd_min_target in BBR_PROBE_RTT mode: */
+static const __u32	bbr_probe_rtt_mode_ms = 200;
+/* Skip TSO below the following bandwidth (bits/sec): */
+static const int bbr_min_tso_rate = 1200000;
+
+/* Pace at ~1% below estimated bw, on average, to reduce queue at bottleneck.
+ * In order to help drive the network toward lower queues and low latency while
+ * maintaining high utilization, the average pacing rate aims to be slightly
+ * lower than the estimated bandwidth. This is an important aspect of the
+ * design.
+ */
+static const int bbr_pacing_margin_percent = 1;
+
+/* We use a high_gain value of 2/ln(2) because it's the smallest pacing gain
+ * that will allow a smoothly increasing pacing rate that will double each RTT
+ * and send the same number of packets per RTT that an un-paced, slow-starting
+ * Reno or CUBIC flow would:
+ */
+static const int bbr_high_gain  = BBR_UNIT * 2885 / 1000 + 1;
+/* The pacing gain of 1/high_gain in BBR_DRAIN is calculated to typically drain
+ * the queue created in BBR_STARTUP in a single round:
+ */
+static const int bbr_drain_gain = BBR_UNIT * 1000 / 2885;
+/* The gain for deriving steady-state cwnd tolerates delayed/stretched ACKs: */
+static const int bbr_cwnd_gain  = BBR_UNIT * 2;
+/* The pacing_gain values for the PROBE_BW gain cycle, to discover/share bw: */
+static const int bbr_pacing_gain[] = {
+	BBR_UNIT * 5 / 4,	/* probe for more available bw */
+	BBR_UNIT * 3 / 4,	/* drain queue and/or yield bw to other flows */
+	BBR_UNIT, BBR_UNIT, BBR_UNIT,	/* cruise at 1.0*bw to utilize pipe, */
+	BBR_UNIT, BBR_UNIT, BBR_UNIT	/* without creating excess queue... */
+};
+/* Randomize the starting gain cycling phase over N phases: */
+static const __u32	bbr_cycle_rand = 7;
+
+/* Try to keep at least this many packets in flight, if things go smoothly. For
+ * smooth functioning, a sliding window protocol ACKing every other packet
+ * needs at least 4 packets in flight:
+ */
+static const __u32	bbr_cwnd_min_target = 4;
+
+/* To estimate if BBR_STARTUP mode (i.e. high_gain) has filled pipe... */
+/* If bw has increased significantly (1.25x), there may be more bw available: */
+static const __u32	bbr_full_bw_thresh = BBR_UNIT * 5 / 4;
+/* But after 3 rounds w/o significant bw growth, estimate pipe is full: */
+static const __u32	bbr_full_bw_cnt = 3;
+
+/* "long-term" ("LT") bandwidth estimator parameters... */
+/* The minimum number of rounds in an LT bw sampling interval: */
+static const __u32	bbr_lt_intvl_min_rtts = 4;
+/* If lost/delivered ratio > 20%, interval is "lossy" and we may be policed: */
+static const __u32	bbr_lt_loss_thresh = 50;
+/* If 2 intervals have a bw ratio <= 1/8, their bw is "consistent": */
+static const __u32	bbr_lt_bw_ratio = BBR_UNIT / 8;
+/* If 2 intervals have a bw diff <= 4 Kbit/sec their bw is "consistent": */
+static const __u32	bbr_lt_bw_diff = 4000 / 8;
+/* If we estimate we're policed, use lt_bw for this many round trips: */
+static const __u32	bbr_lt_bw_max_rtts = 48;
+
+/* Gain factor for adding extra_acked to target cwnd: */
+static const int bbr_extra_acked_gain = BBR_UNIT;
+/* Window length of extra_acked window. */
+static const __u32	bbr_extra_acked_win_rtts = 5;
+/* Max allowed val for ack_epoch_acked, after which sampling epoch is reset */
+static const __u32	bbr_ack_epoch_acked_reset_thresh = 1U << 20;
+/* Time period for clamping cwnd increment due to ack aggregation */
+static const __u32	bbr_extra_acked_max_us = 100 * 1000;
+
+static void bbr_check_probe_rtt_done(struct sock *sk);
+
+/* Do we estimate that STARTUP filled the pipe? */
+static bool bbr_full_bw_reached(const struct sock *sk)
+{
+	const struct bbr *bbr = inet_csk_ca(sk);
+
+	return bbr->full_bw_reached;
+}
+
+/* Return the windowed max recent bandwidth sample, in pkts/uS << BW_SCALE. */
+static __u32	bbr_max_bw(const struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	return minmax_get(&bbr->bw);
+}
+
+/* Return the estimated bandwidth of the path, in pkts/uS << BW_SCALE. */
+static __u32	bbr_bw(const struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	return bbr->lt_use_bw ? bbr->lt_bw : bbr_max_bw(sk);
+}
+
+/* Return maximum extra acked in past k-2k round trips,
+ * where k = bbr_extra_acked_win_rtts.
+ */
+static __u16 bbr_extra_acked(const struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	return max(bbr->extra_acked[0], bbr->extra_acked[1]);
+}
+
+/* Return rate in bytes per second, optionally with a gain.
+ * The order here is chosen carefully to avoid overflow of __u64. This should
+ * work for input rates of up to 2.9Tbit/sec and gain of 2.89x.
+ */
+static __u64 bbr_rate_bytes_per_sec(struct sock *sk, __u64 rate, int gain)
+{
+	unsigned int mss = tcp_sk(sk)->mss_cache;
+
+	rate *= mss;
+	rate *= gain;
+	rate >>= BBR_SCALE;
+	rate *= USEC_PER_SEC / 100 * (100 - bbr_pacing_margin_percent);
+	return rate >> BW_SCALE;
+}
+
+/* Convert a BBR bw and gain factor to a pacing rate in bytes per second. */
+static unsigned long bbr_bw_to_pacing_rate(struct sock *sk, __u32	bw, int gain)
+{
+	__u64 rate = bw;
+
+	rate = bbr_rate_bytes_per_sec(sk, rate, gain);
+	rate = min_t(__u64, rate, READ_ONCE(sk->sk_max_pacing_rate));
+	//Modified here
+	// rate = min(rate, sk->sk_max_pacing_rate);
+	return rate;
+}
+
+/* Initialize pacing rate to: high_gain * init_cwnd / RTT. */
+static void bbr_init_pacing_rate_from_rtt(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u64 bw;
+	__u32 rtt_us;
+
+	if (tp->srtt_us) {		/* any RTT sample yet? */
+		rtt_us = max(tp->srtt_us >> 3, 1U);
+		bbr->has_seen_rtt = 1;
+	} else {			 /* no RTT sample yet */
+		rtt_us = USEC_PER_MSEC;	 /* use nominal default RTT */
+	}
+	bw = (__u64)tcp_snd_cwnd(tp) * BW_UNIT;
+	do_div(bw, rtt_us);
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   bbr_bw_to_pacing_rate(sk, bw, bbr_high_gain));
+}
+
+/* Pace using current bw estimate and a gain factor. */
+static void bbr_set_pacing_rate(struct sock *sk, __u32	bw, int gain)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	unsigned long rate = bbr_bw_to_pacing_rate(sk, bw, gain);
+
+	if (unlikely(!bbr->has_seen_rtt && tp->srtt_us))
+		bbr_init_pacing_rate_from_rtt(sk);
+	if (bbr_full_bw_reached(sk) || rate > READ_ONCE(sk->sk_pacing_rate))
+		WRITE_ONCE(sk->sk_pacing_rate, rate);
+}
+
+/* override sysctl_tcp_min_tso_segs */
+// __bpf_kfunc static __u32 bbr_min_tso_segs(struct sock *sk)
+static __u32 bbr_min_tso_segs(struct sock *sk)
+{
+	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
+}
+
+SEC("struct_ops")
+__u32 BPF_PROG (bpf_bbr_min_tso_segs, struct sock *sk)
+{
+	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
+}
+
+static __u32	bbr_tso_segs_goal(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	__u32	segs, bytes;
+
+	/* Sort of tcp_tso_autosize() but ignoring
+	 * driver provided sk_gso_max_size.
+	 */
+	bytes = min_t(unsigned long,
+		      READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift),
+		      GSO_LEGACY_MAX_SIZE - 1 - MAX_TCP_HEADER);
+	segs = max_t(u32, bytes / tp->mss_cache, bbr_min_tso_segs(sk));
+	// bytes = min(sk->sk_pacing_rate >> sk->sk_pacing_shift,
+	// 	      GSO_LEGACY_MAX_SIZE - 1 - MAX_TCP_HEADER);
+	// segs = max(bytes / tp->mss_cache, bbr_min_tso_segs(sk));
+
+	return min(segs, 0x7FU);
+}
+
+/* Save "last known good" cwnd so we can restore it after losses or PROBE_RTT */
+static void bbr_save_cwnd(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (bbr->prev_ca_state < TCP_CA_Recovery && bbr->mode != BBR_PROBE_RTT)
+		bbr->prior_cwnd = tcp_snd_cwnd(tp);  /* this cwnd is good enough */
+	else  /* loss recovery or BBR_PROBE_RTT have temporarily cut cwnd */
+		bbr->prior_cwnd = max(bbr->prior_cwnd, tcp_snd_cwnd(tp));
+}
+SEC("struct_ops")
+void BPF_PROG (bpf_bbr_cwnd_event, struct sock *sk, enum tcp_ca_event event)
+// __bpf_kfunc static void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (event == CA_EVENT_TX_START && tp->app_limited) {
+		bbr->idle_restart = 1;
+		bbr->ack_epoch_mstamp = tp->tcp_mstamp;
+		bbr->ack_epoch_acked = 0;
+		/* Avoid pointless buffer overflows: pace at est. bw if we don't
+		 * need more speed (we're restarting from idle and app-limited).
+		 */
+		if (bbr->mode == BBR_PROBE_BW)
+			bbr_set_pacing_rate(sk, bbr_bw(sk), BBR_UNIT);
+		else if (bbr->mode == BBR_PROBE_RTT)
+			bbr_check_probe_rtt_done(sk);
+	}
+}
+
+// extern void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+
+// SEC("struct_ops")
+// void BPF_PROG (bpf_bbr_cwnd_event, struct sock *sk, enum tcp_ca_event event){
+// 	bbr_cwnd_event(sk,event);
+// }
+
+/* Calculate bdp based on min RTT and the estimated bottleneck bandwidth:
+ *
+ * bdp = ceil(bw * min_rtt * gain)
+ *
+ * The key factor, gain, controls the amount of queue. While a small gain
+ * builds a smaller queue, it becomes more vulnerable to noise in RTT
+ * measurements (e.g., delayed ACKs or other ACK compression effects). This
+ * noise may cause BBR to under-estimate the rate.
+ */
+static __u32	bbr_bdp(struct sock *sk, __u32	bw, int gain)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	bdp;
+	__u64 w;
+
+	/* If we've never had a valid RTT sample, cap cwnd at the initial
+	 * default. This should only happen when the connection is not using TCP
+	 * timestamps and has retransmitted all of the SYN/SYNACK/data packets
+	 * ACKed so far. In this case, an RTO can cut cwnd to 1, in which
+	 * case we need to slow-start up toward something safe: TCP_INIT_CWND.
+	 */
+	// if (unlikely(bbr->min_rtt_us == ~0U))	 /* no valid RTT samples yet? */
+	// if ((bbr->min_rtt_us == ~0U))	 /* no valid RTT samples yet? */
+	// 	return TCP_INIT_CWND;  /* be safe: cap at default initial cwnd*/
+
+	w = (__u64)bw * bbr->min_rtt_us;
+
+	/* Apply a gain to the given value, remove the BW_SCALE shift, and
+	 * round the value up to avoid a negative feedback loop.
+	 */
+	bdp = (((w * gain) >> BBR_SCALE) + BW_UNIT - 1) / BW_UNIT;
+
+	return bdp;
+}
+
+/* To achieve full performance in high-speed paths, we budget enough cwnd to
+ * fit full-sized skbs in-flight on both end hosts to fully utilize the path:
+ *   - one skb in sending host Qdisc,
+ *   - one skb in sending host TSO/GSO engine
+ *   - one skb being received by receiver host LRO/GRO/delayed-ACK engine
+ * Don't worry, at low rates (bbr_min_tso_rate) this won't bloat cwnd because
+ * in such cases tso_segs_goal is 1. The minimum cwnd is 4 packets,
+ * which allows 2 outstanding 2-packet sequences, to try to keep pipe
+ * full even with ACK-every-other-packet delayed ACKs.
+ */
+static __u32	bbr_quantization_budget(struct sock *sk, __u32	cwnd)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	/* Allow enough full-sized skbs in flight to utilize end systems. */
+	cwnd += 3 * bbr_tso_segs_goal(sk);
+
+	/* Reduce delayed ACKs by rounding up cwnd to the next even number. */
+	cwnd = (cwnd + 1) & ~1U;
+
+	/* Ensure gain cycling gets inflight above BDP even for small BDPs. */
+	if (bbr->mode == BBR_PROBE_BW && bbr->cycle_idx == 0)
+		cwnd += 2;
+
+	return cwnd;
+}
+
+/* Find inflight based on min RTT and the estimated bottleneck bandwidth. */
+static __u32	bbr_inflight(struct sock *sk, __u32	bw, int gain)
+{
+	__u32	inflight;
+
+	inflight = bbr_bdp(sk, bw, gain);
+	inflight = bbr_quantization_budget(sk, inflight);
+
+	return inflight;
+}
+
+/* With pacing at lower layers, there's often less data "in the network" than
+ * "in flight". With TSQ and departure time pacing at lower layers (e.g. fq),
+ * we often have several skbs queued in the pacing layer with a pre-scheduled
+ * earliest departure time (EDT). BBR adapts its pacing rate based on the
+ * inflight level that it estimates has already been "baked in" by previous
+ * departure time decisions. We calculate a rough estimate of the number of our
+ * packets that might be in the network at the earliest departure time for the
+ * next skb scheduled:
+ *   in_network_at_edt = inflight_at_edt - (EDT - now) * bw
+ * If we're increasing inflight, then we want to know if the transmit of the
+ * EDT skb will push inflight above the target, so inflight_at_edt includes
+ * bbr_tso_segs_goal() from the skb departing at EDT. If decreasing inflight,
+ * then estimate if inflight will sink too low just before the EDT transmit.
+ */
+static __u32	bbr_packets_in_net_at_edt(struct sock *sk, __u32	inflight_now)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u64 now_ns, edt_ns, interval_us;
+	__u32	interval_delivered, inflight_at_edt;
+
+	now_ns = tp->tcp_clock_cache;
+	edt_ns = max(tp->tcp_wstamp_ns, now_ns);
+	interval_us = div_u64(edt_ns - now_ns, NSEC_PER_USEC);
+	interval_delivered = (__u64)bbr_bw(sk) * interval_us >> BW_SCALE;
+	inflight_at_edt = inflight_now;
+	if (bbr->pacing_gain > BBR_UNIT)              /* increasing inflight */
+		inflight_at_edt += bbr_tso_segs_goal(sk);  /* include EDT skb */
+	if (interval_delivered >= inflight_at_edt)
+		return 0;
+	return inflight_at_edt - interval_delivered;
+}
+
+/* Find the cwnd increment based on estimate of ack aggregation */
+static __u32	bbr_ack_aggregation_cwnd(struct sock *sk)
+{
+	__u32	max_aggr_cwnd, aggr_cwnd = 0;
+
+	if (bbr_extra_acked_gain && bbr_full_bw_reached(sk)) {
+		max_aggr_cwnd = ((__u64)bbr_bw(sk) * bbr_extra_acked_max_us)
+				/ BW_UNIT;
+		aggr_cwnd = (bbr_extra_acked_gain * bbr_extra_acked(sk))
+			     >> BBR_SCALE;
+		aggr_cwnd = min(aggr_cwnd, max_aggr_cwnd);
+	}
+
+	return aggr_cwnd;
+}
+
+/* An optimization in BBR to reduce losses: On the first round of recovery, we
+ * follow the packet conservation principle: send P packets per P packets acked.
+ * After that, we slow-start and send at most 2*P packets per P packets acked.
+ * After recovery finishes, or upon undo, we restore the cwnd we had when
+ * recovery started (capped by the target cwnd based on estimated BDP).
+ *
+ * TODO(ycheng/ncardwell): implement a rate-based approach.
+ */
+static bool bbr_set_cwnd_to_recover_or_restore(
+	struct sock *sk, const struct rate_sample *rs, __u32	acked, __u32	*new_cwnd)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u8 prev_state = bbr->prev_ca_state, state = inet_csk(sk)->icsk_ca_state;
+	__u32	cwnd = tcp_snd_cwnd(tp);
+
+	/* An ACK for P pkts should release at most 2*P packets. We do this
+	 * in two steps. First, here we deduct the number of lost packets.
+	 * Then, in bbr_set_cwnd() we slow start up toward the target cwnd.
+	 */
+	if (rs->losses > 0)
+		cwnd = max_t(s32, cwnd - rs->losses, 1);
+		//modified here
+		// cwnd = max(cwnd - rs->losses, 1);
+
+	if (state == TCP_CA_Recovery && prev_state != TCP_CA_Recovery) {
+		/* Starting 1st round of Recovery, so do packet conservation. */
+		bbr->packet_conservation = 1;
+		bbr->next_rtt_delivered = tp->delivered;  /* start round now */
+		/* Cut unused cwnd from app behavior, TSQ, or TSO deferral: */
+		cwnd = tcp_packets_in_flight(tp) + acked;
+	} else if (prev_state >= TCP_CA_Recovery && state < TCP_CA_Recovery) {
+		/* Exiting loss recovery; restore cwnd saved before recovery. */
+		cwnd = max(cwnd, bbr->prior_cwnd);
+		bbr->packet_conservation = 0;
+	}
+	bbr->prev_ca_state = state;
+
+	if (bbr->packet_conservation) {
+		*new_cwnd = max(cwnd, tcp_packets_in_flight(tp) + acked);
+		return true;	/* yes, using packet conservation */
+	}
+	*new_cwnd = cwnd;
+	return false;
+}
+
+/* Slow-start up toward target cwnd (if bw estimate is growing, or packet loss
+ * has drawn us down below target), or snap down to target if we're above it.
+ */
+static void bbr_set_cwnd(struct sock *sk, const struct rate_sample *rs,
+			 __u32	acked, __u32	bw, int gain)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	cwnd = tcp_snd_cwnd(tp), target_cwnd = 0;
+
+	if (!acked)
+		goto done;  /* no packet fully ACKed; just apply caps */
+
+	if (bbr_set_cwnd_to_recover_or_restore(sk, rs, acked, &cwnd))
+		goto done;
+
+	target_cwnd = bbr_bdp(sk, bw, gain);
+
+	/* Increment the cwnd to account for excess ACKed data that seems
+	 * due to aggregation (of data and/or ACKs) visible in the ACK stream.
+	 */
+	target_cwnd += bbr_ack_aggregation_cwnd(sk);
+	target_cwnd = bbr_quantization_budget(sk, target_cwnd);
+
+	/* If we're below target cwnd, slow start cwnd toward target cwnd. */
+	if (bbr_full_bw_reached(sk))  /* only cut cwnd if we filled the pipe */
+		cwnd = min(cwnd + acked, target_cwnd);
+	else if (cwnd < target_cwnd || tp->delivered < TCP_INIT_CWND)
+		cwnd = cwnd + acked;
+	cwnd = max(cwnd, bbr_cwnd_min_target);
+
+done:
+	tcp_snd_cwnd_set(tp, min(cwnd, tp->snd_cwnd_clamp));	/* apply global cap */
+	if (bbr->mode == BBR_PROBE_RTT)  /* drain queue, refresh min_rtt */
+		tcp_snd_cwnd_set(tp, min(tcp_snd_cwnd(tp), bbr_cwnd_min_target));
+}
+
+/* End cycle phase if it's time and/or we hit the phase's in-flight target. */
+static bool bbr_is_next_cycle_phase(struct sock *sk,
+				    const struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	bool is_full_length =
+		tcp_stamp_us_delta(tp->delivered_mstamp, bbr->cycle_mstamp) >
+		bbr->min_rtt_us;
+	__u32	inflight, bw;
+
+	/* The pacing_gain of 1.0 paces at the estimated bw to try to fully
+	 * use the pipe without increasing the queue.
+	 */
+	if (bbr->pacing_gain == BBR_UNIT)
+		return is_full_length;		/* just use wall clock time */
+
+	inflight = bbr_packets_in_net_at_edt(sk, rs->prior_in_flight);
+	bw = bbr_max_bw(sk);
+
+	/* A pacing_gain > 1.0 probes for bw by trying to raise inflight to at
+	 * least pacing_gain*BDP; this may take more than min_rtt if min_rtt is
+	 * small (e.g. on a LAN). We do not persist if packets are lost, since
+	 * a path with small buffers may not hold that much.
+	 */
+	if (bbr->pacing_gain > BBR_UNIT)
+		return is_full_length &&
+			(rs->losses ||  /* perhaps pacing_gain*BDP won't fit */
+			 inflight >= bbr_inflight(sk, bw, bbr->pacing_gain));
+
+	/* A pacing_gain < 1.0 tries to drain extra queue we added if bw
+	 * probing didn't find more bw. If inflight falls to match BDP then we
+	 * estimate queue is drained; persisting would underutilize the pipe.
+	 */
+	return is_full_length ||
+		inflight <= bbr_inflight(sk, bw, BBR_UNIT);
+}
+
+static void bbr_advance_cycle_phase(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->cycle_idx = (bbr->cycle_idx + 1) & (CYCLE_LEN - 1);
+	bbr->cycle_mstamp = tp->delivered_mstamp;
+}
+
+/* Gain cycling: cycle pacing gain to converge to fair share of available bw. */
+static void bbr_update_cycle_phase(struct sock *sk,
+				   const struct rate_sample *rs)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (bbr->mode == BBR_PROBE_BW && bbr_is_next_cycle_phase(sk, rs))
+		bbr_advance_cycle_phase(sk);
+}
+
+static void bbr_reset_startup_mode(struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->mode = BBR_STARTUP;
+}
+
+static void bbr_reset_probe_bw_mode(struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->mode = BBR_PROBE_BW;
+	bbr->cycle_idx = CYCLE_LEN - 1 - get_random_u32_below(bbr_cycle_rand);
+	bbr_advance_cycle_phase(sk);	/* flip to next phase of gain cycle */
+}
+
+static void bbr_reset_mode(struct sock *sk)
+{
+	if (!bbr_full_bw_reached(sk))
+		bbr_reset_startup_mode(sk);
+	else
+		bbr_reset_probe_bw_mode(sk);
+}
+
+/* Start a new long-term sampling interval. */
+static void bbr_reset_lt_bw_sampling_interval(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->lt_last_stamp = div_u64(tp->delivered_mstamp, USEC_PER_MSEC);
+	bbr->lt_last_delivered = tp->delivered;
+	bbr->lt_last_lost = tp->lost;
+	bbr->lt_rtt_cnt = 0;
+}
+
+/* Completely reset long-term bandwidth sampling. */
+static void bbr_reset_lt_bw_sampling(struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->lt_bw = 0;
+	bbr->lt_use_bw = 0;
+	bbr->lt_is_sampling = false;
+	bbr_reset_lt_bw_sampling_interval(sk);
+}
+
+/* Long-term bw sampling interval is done. Estimate whether we're policed. */
+static void bbr_lt_bw_interval_done(struct sock *sk, __u32	bw)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	diff;
+
+	if (bbr->lt_bw) {  /* do we have bw from a previous interval? */
+		/* Is new bw close to the lt_bw from the previous interval? */
+		// diff = abs(bw - bbr->lt_bw);
+		diff = (bw - bbr->lt_bw);
+		if ((diff * BBR_UNIT <= bbr_lt_bw_ratio * bbr->lt_bw) ||
+		    (bbr_rate_bytes_per_sec(sk, diff, BBR_UNIT) <=
+		     bbr_lt_bw_diff)) {
+			/* All criteria are met; estimate we're policed. */
+			bbr->lt_bw = (bw + bbr->lt_bw) >> 1;  /* avg 2 intvls */
+			bbr->lt_use_bw = 1;
+			bbr->pacing_gain = BBR_UNIT;  /* try to avoid drops */
+			bbr->lt_rtt_cnt = 0;
+			return;
+		}
+	}
+	bbr->lt_bw = bw;
+	bbr_reset_lt_bw_sampling_interval(sk);
+}
+
+/* Token-bucket traffic policers are common (see "An Internet-Wide Analysis of
+ * Traffic Policing", SIGCOMM 2016). BBR detects token-bucket policers and
+ * explicitly models their policed rate, to reduce unnecessary losses. We
+ * estimate that we're policed if we see 2 consecutive sampling intervals with
+ * consistent throughput and high packet loss. If we think we're being policed,
+ * set lt_bw to the "long-term" average delivery rate from those 2 intervals.
+ */
+static void bbr_lt_bw_sampling(struct sock *sk, const struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	lost, delivered;
+	__u64 bw;
+	__u32	t;
+
+	if (bbr->lt_use_bw) {	/* already using long-term rate, lt_bw? */
+		if (bbr->mode == BBR_PROBE_BW && bbr->round_start &&
+		    ++bbr->lt_rtt_cnt >= bbr_lt_bw_max_rtts) {
+			bbr_reset_lt_bw_sampling(sk);    /* stop using lt_bw */
+			bbr_reset_probe_bw_mode(sk);  /* restart gain cycling */
+		}
+		return;
+	}
+
+	/* Wait for the first loss before sampling, to let the policer exhaust
+	 * its tokens and estimate the steady-state rate allowed by the policer.
+	 * Starting samples earlier includes bursts that over-estimate the bw.
+	 */
+	if (!bbr->lt_is_sampling) {
+		if (!rs->losses)
+			return;
+		bbr_reset_lt_bw_sampling_interval(sk);
+		bbr->lt_is_sampling = true;
+	}
+
+	/* To avoid underestimates, reset sampling if we run out of data. */
+	if (rs->is_app_limited) {
+		bbr_reset_lt_bw_sampling(sk);
+		return;
+	}
+
+	if (bbr->round_start)
+		bbr->lt_rtt_cnt++;	/* count round trips in this interval */
+	if (bbr->lt_rtt_cnt < bbr_lt_intvl_min_rtts)
+		return;		/* sampling interval needs to be longer */
+	if (bbr->lt_rtt_cnt > 4 * bbr_lt_intvl_min_rtts) {
+		bbr_reset_lt_bw_sampling(sk);  /* interval is too long */
+		return;
+	}
+
+	/* End sampling interval when a packet is lost, so we estimate the
+	 * policer tokens were exhausted. Stopping the sampling before the
+	 * tokens are exhausted under-estimates the policed rate.
+	 */
+	if (!rs->losses)
+		return;
+
+	/* Calculate packets lost and delivered in sampling interval. */
+	lost = tp->lost - bbr->lt_last_lost;
+	delivered = tp->delivered - bbr->lt_last_delivered;
+	/* Is loss rate (lost/delivered) >= lt_loss_thresh? If not, wait. */
+	if (!delivered || (lost << BBR_SCALE) < bbr_lt_loss_thresh * delivered)
+		return;
+
+	/* Find average delivery rate in this sampling interval. */
+	t = div_u64(tp->delivered_mstamp, USEC_PER_MSEC) - bbr->lt_last_stamp;
+	if ((__s32)t < 1)
+		return;		/* interval is less than one ms, so wait */
+	/* Check if can multiply without overflow */
+	if (t >= ~0U / USEC_PER_MSEC) {
+		bbr_reset_lt_bw_sampling(sk);  /* interval too long; reset */
+		return;
+	}
+	t *= USEC_PER_MSEC;
+	bw = (__u64)delivered * BW_UNIT;
+	do_div(bw, t);
+	bbr_lt_bw_interval_done(sk, bw);
+}
+
+/* Estimate the bandwidth based on how fast packets are delivered */
+static void bbr_update_bw(struct sock *sk, const struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u64 bw;
+
+	bbr->round_start = 0;
+	if (rs->delivered < 0 || rs->interval_us <= 0)
+		return; /* Not a valid observation */
+
+	/* See if we've reached the next RTT */
+	if (!before(rs->prior_delivered, bbr->next_rtt_delivered)) {
+		bbr->next_rtt_delivered = tp->delivered;
+		bbr->rtt_cnt++;
+		bbr->round_start = 1;
+		bbr->packet_conservation = 0;
+	}
+
+	bbr_lt_bw_sampling(sk, rs);
+
+	/* Divide delivered by the interval to find a (lower bound) bottleneck
+	 * bandwidth sample. Delivered is in packets and interval_us in uS and
+	 * ratio will be <<1 for most connections. So delivered is first scaled.
+	 */
+	bw = div64_long((__u64)rs->delivered * BW_UNIT, rs->interval_us);
+
+	/* If this sample is application-limited, it is likely to have a very
+	 * low delivered count that represents application behavior rather than
+	 * the available network rate. Such a sample could drag down estimated
+	 * bw, causing needless slow-down. Thus, to continue to send at the
+	 * last measured network rate, we filter out app-limited samples unless
+	 * they describe the path bw at least as well as our bw model.
+	 *
+	 * So the goal during app-limited phase is to proceed with the best
+	 * network rate no matter how long. We automatically leave this
+	 * phase when app writes faster than the network can deliver :)
+	 */
+	if (!rs->is_app_limited || bw >= bbr_max_bw(sk)) {
+		/* Incorporate new sample into our max bw filter. */
+		minmax_running_max(&bbr->bw, bbr_bw_rtts, bbr->rtt_cnt, bw);
+	}
+}
+
+/* Estimates the windowed max degree of ack aggregation.
+ * This is used to provision extra in-flight data to keep sending during
+ * inter-ACK silences.
+ *
+ * Degree of ack aggregation is estimated as extra data acked beyond expected.
+ *
+ * max_extra_acked = "maximum recent excess data ACKed beyond max_bw * interval"
+ * cwnd += max_extra_acked
+ *
+ * Max extra_acked is clamped by cwnd and bw * bbr_extra_acked_max_us (100 ms).
+ * Max filter is an approximate sliding window of 5-10 (packet timed) round
+ * trips.
+ */
+static void bbr_update_ack_aggregation(struct sock *sk,
+				       const struct rate_sample *rs)
+{
+	__u32	epoch_us, expected_acked, extra_acked;
+	struct bbr *bbr = inet_csk_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!bbr_extra_acked_gain || rs->acked_sacked <= 0 ||
+	    rs->delivered < 0 || rs->interval_us <= 0)
+		return;
+
+	if (bbr->round_start) {
+		bbr->extra_acked_win_rtts = min(0x1F,
+						bbr->extra_acked_win_rtts + 1);
+		if (bbr->extra_acked_win_rtts >= bbr_extra_acked_win_rtts) {
+			bbr->extra_acked_win_rtts = 0;
+			bbr->extra_acked_win_idx = bbr->extra_acked_win_idx ?
+						   0 : 1;
+			bbr->extra_acked[bbr->extra_acked_win_idx] = 0;
+		}
+	}
+
+	/* Compute how many packets we expected to be delivered over epoch. */
+	epoch_us = tcp_stamp_us_delta(tp->delivered_mstamp,
+				      bbr->ack_epoch_mstamp);
+	expected_acked = ((__u64)bbr_bw(sk) * epoch_us) / BW_UNIT;
+
+	/* Reset the aggregation epoch if ACK rate is below expected rate or
+	 * significantly large no. of ack received since epoch (potentially
+	 * quite old epoch).
+	 */
+	if (bbr->ack_epoch_acked <= expected_acked ||
+	    (bbr->ack_epoch_acked + rs->acked_sacked >=
+	     bbr_ack_epoch_acked_reset_thresh)) {
+		bbr->ack_epoch_acked = 0;
+		bbr->ack_epoch_mstamp = tp->delivered_mstamp;
+		expected_acked = 0;
+	}
+
+	/* Compute excess data delivered, beyond what was expected. */
+	bbr->ack_epoch_acked = min_t(u32, 0xFFFFF,
+				     bbr->ack_epoch_acked + rs->acked_sacked);
+	// modified here
+	// bbr->ack_epoch_acked = min(0xFFFFF, bbr->ack_epoch_acked + rs->acked_sacked);
+	extra_acked = bbr->ack_epoch_acked - expected_acked;
+	extra_acked = min(extra_acked, tcp_snd_cwnd(tp));
+	if (extra_acked > bbr->extra_acked[bbr->extra_acked_win_idx])
+		bbr->extra_acked[bbr->extra_acked_win_idx] = extra_acked;
+}
+
+/* Estimate when the pipe is full, using the change in delivery rate: BBR
+ * estimates that STARTUP filled the pipe if the estimated bw hasn't changed by
+ * at least bbr_full_bw_thresh (25%) after bbr_full_bw_cnt (3) non-app-limited
+ * rounds. Why 3 rounds: 1: rwin autotuning grows the rwin, 2: we fill the
+ * higher rwin, 3: we get higher delivery rate samples. Or transient
+ * cross-traffic or radio noise can go away. CUBIC Hystart shares a similar
+ * design goal, but uses delay and inter-ACK spacing instead of bandwidth.
+ */
+static void bbr_check_full_bw_reached(struct sock *sk,
+				      const struct rate_sample *rs)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	bw_thresh;
+
+	if (bbr_full_bw_reached(sk) || !bbr->round_start || rs->is_app_limited)
+		return;
+
+	bw_thresh = (__u64)bbr->full_bw * bbr_full_bw_thresh >> BBR_SCALE;
+	if (bbr_max_bw(sk) >= bw_thresh) {
+		bbr->full_bw = bbr_max_bw(sk);
+		bbr->full_bw_cnt = 0;
+		return;
+	}
+	++bbr->full_bw_cnt;
+	bbr->full_bw_reached = bbr->full_bw_cnt >= bbr_full_bw_cnt;
+}
+
+/* If pipe is probably full, drain the queue and then enter steady-state. */
+static void bbr_check_drain(struct sock *sk, const struct rate_sample *rs)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (bbr->mode == BBR_STARTUP && bbr_full_bw_reached(sk)) {
+		bbr->mode = BBR_DRAIN;	/* drain queue we created */
+		tcp_sk(sk)->snd_ssthresh =
+				bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT);
+	}	/* fall through to check if in-flight is already small: */
+	if (bbr->mode == BBR_DRAIN &&
+	    bbr_packets_in_net_at_edt(sk, tcp_packets_in_flight(tcp_sk(sk))) <=
+	    bbr_inflight(sk, bbr_max_bw(sk), BBR_UNIT))
+		bbr_reset_probe_bw_mode(sk);  /* we estimate queue is drained */
+}
+
+static void bbr_check_probe_rtt_done(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (!(bbr->probe_rtt_done_stamp &&
+	      after(tcp_jiffies32, bbr->probe_rtt_done_stamp)))
+		return;
+
+	bbr->min_rtt_stamp = tcp_jiffies32;  /* wait a while until PROBE_RTT */
+	tcp_snd_cwnd_set(tp, max(tcp_snd_cwnd(tp), bbr->prior_cwnd));
+	bbr_reset_mode(sk);
+}
+
+/* The goal of PROBE_RTT mode is to have BBR flows cooperatively and
+ * periodically drain the bottleneck queue, to converge to measure the true
+ * min_rtt (unloaded propagation delay). This allows the flows to keep queues
+ * small (reducing queuing delay and packet loss) and achieve fairness among
+ * BBR flows.
+ *
+ * The min_rtt filter window is 10 seconds. When the min_rtt estimate expires,
+ * we enter PROBE_RTT mode and cap the cwnd at bbr_cwnd_min_target=4 packets.
+ * After at least bbr_probe_rtt_mode_ms=200ms and at least one packet-timed
+ * round trip elapsed with that flight size <= 4, we leave PROBE_RTT mode and
+ * re-enter the previous mode. BBR uses 200ms to approximately bound the
+ * performance penalty of PROBE_RTT's cwnd capping to roughly 2% (200ms/10s).
+ *
+ * Note that flows need only pay 2% if they are busy sending over the last 10
+ * seconds. Interactive applications (e.g., Web, RPCs, video chunks) often have
+ * natural silences or low-rate periods within 10 seconds where the rate is low
+ * enough for long enough to drain its queue in the bottleneck. We pick up
+ * these min RTT measurements opportunistically with our min_rtt filter. :-)
+ */
+static void bbr_update_min_rtt(struct sock *sk, const struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+	bool filter_expired;
+
+	/* Track min RTT seen in the min_rtt_win_sec filter window: */
+	filter_expired = after(tcp_jiffies32,
+			       bbr->min_rtt_stamp + bbr_min_rtt_win_sec * HZ);
+	if (rs->rtt_us >= 0 &&
+	    (rs->rtt_us < bbr->min_rtt_us ||
+	     (filter_expired && !rs->is_ack_delayed))) {
+		bbr->min_rtt_us = rs->rtt_us;
+		bbr->min_rtt_stamp = tcp_jiffies32;
+	}
+
+	if (bbr_probe_rtt_mode_ms > 0 && filter_expired &&
+	    !bbr->idle_restart && bbr->mode != BBR_PROBE_RTT) {
+		bbr->mode = BBR_PROBE_RTT;  /* dip, drain queue */
+		bbr_save_cwnd(sk);  /* note cwnd so we can restore it */
+		bbr->probe_rtt_done_stamp = 0;
+	}
+
+	if (bbr->mode == BBR_PROBE_RTT) {
+		/* Ignore low rate samples during this mode. */
+		tp->app_limited =
+			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
+		/* Maintain min packets in flight for max(200 ms, 1 round). */
+		if (!bbr->probe_rtt_done_stamp &&
+		    tcp_packets_in_flight(tp) <= bbr_cwnd_min_target) {
+			bbr->probe_rtt_done_stamp = tcp_jiffies32 +
+				msecs_to_jiffies(bbr_probe_rtt_mode_ms);
+			bbr->probe_rtt_round_done = 0;
+			bbr->next_rtt_delivered = tp->delivered;
+		} else if (bbr->probe_rtt_done_stamp) {
+			if (bbr->round_start)
+				bbr->probe_rtt_round_done = 1;
+			if (bbr->probe_rtt_round_done)
+				bbr_check_probe_rtt_done(sk);
+		}
+	}
+	/* Restart after idle ends only once we process a new S/ACK for data */
+	if (rs->delivered > 0)
+		bbr->idle_restart = 0;
+}
+
+static void bbr_update_gains(struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	switch (bbr->mode) {
+	case BBR_STARTUP:
+		bbr->pacing_gain = bbr_high_gain;
+		bbr->cwnd_gain	 = bbr_high_gain;
+		break;
+	case BBR_DRAIN:
+		bbr->pacing_gain = bbr_drain_gain;	/* slow, to drain */
+		bbr->cwnd_gain	 = bbr_high_gain;	/* keep cwnd */
+		break;
+	case BBR_PROBE_BW:
+		bbr->pacing_gain = (bbr->lt_use_bw ?
+				    BBR_UNIT :
+				    bbr_pacing_gain[bbr->cycle_idx]);
+		bbr->cwnd_gain	 = bbr_cwnd_gain;
+		break;
+	case BBR_PROBE_RTT:
+		bbr->pacing_gain = BBR_UNIT;
+		bbr->cwnd_gain	 = BBR_UNIT;
+		break;
+	default:
+		WARN_ONCE(1, "BBR bad mode: %u\n", bbr->mode);
+		break;
+	}
+}
+
+static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
+{
+	bbr_update_bw(sk, rs);
+	bbr_update_ack_aggregation(sk, rs);
+	bbr_update_cycle_phase(sk, rs);
+	bbr_check_full_bw_reached(sk, rs);
+	bbr_check_drain(sk, rs);
+	bbr_update_min_rtt(sk, rs);
+	bbr_update_gains(sk);
+}
+
+// __bpf_kfunc static void bbr_main(struct sock *sk, const struct rate_sample *rs)
+SEC("struct_ops")
+void BPF_PROG(bpf_bbr_main, struct sock *sk, const struct rate_sample *rs)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+	__u32	bw;
+
+	bbr_update_model(sk, rs);
+
+	bw = bbr_bw(sk);
+	bbr_set_pacing_rate(sk, bw, bbr->pacing_gain);
+	bbr_set_cwnd(sk, rs, rs->acked_sacked, bw, bbr->cwnd_gain);
+}
+
+// __bpf_kfunc static void bbr_init(struct sock *sk)
+SEC("struct_ops")
+void BPF_PROG(bpf_bbr_init,struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->prior_cwnd = 0;
+	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
+	bbr->rtt_cnt = 0;
+	bbr->next_rtt_delivered = tp->delivered;
+	bbr->prev_ca_state = TCP_CA_Open;
+	bbr->packet_conservation = 0;
+
+	bbr->probe_rtt_done_stamp = 0;
+	bbr->probe_rtt_round_done = 0;
+	bbr->min_rtt_us = tcp_min_rtt(tp);
+	bbr->min_rtt_stamp = tcp_jiffies32;
+
+	minmax_reset(&bbr->bw, bbr->rtt_cnt, 0);  /* init max bw to 0 */
+
+	bbr->has_seen_rtt = 0;
+	bbr_init_pacing_rate_from_rtt(sk);
+
+	bbr->round_start = 0;
+	bbr->idle_restart = 0;
+	bbr->full_bw_reached = 0;
+	bbr->full_bw = 0;
+	bbr->full_bw_cnt = 0;
+	bbr->cycle_mstamp = 0;
+	bbr->cycle_idx = 0;
+	bbr_reset_lt_bw_sampling(sk);
+	bbr_reset_startup_mode(sk);
+
+	bbr->ack_epoch_mstamp = tp->tcp_mstamp;
+	bbr->ack_epoch_acked = 0;
+	bbr->extra_acked_win_rtts = 0;
+	bbr->extra_acked_win_idx = 0;
+	bbr->extra_acked[0] = 0;
+	bbr->extra_acked[1] = 0;
+
+	cmpxchg(&sk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
+}
+
+// __bpf_kfunc static __u32	bbr_sndbuf_expand(struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG (bpf_bbr_sndbuf_expand, struct sock *sk)
+{
+	/* Provision 3 * cwnd since BBR may slow-start even during recovery. */
+	return 3;
+}
+
+/* In theory BBR does not need to undo the cwnd since it does not
+ * always reduce cwnd on losses (see bbr_main()). Keep it for now.
+ */
+SEC("struct_ops")
+__u32 BPF_PROG(bpf_bbr_undo_cwnd,struct sock *sk)
+// __bpf_kfunc static __u32	bbr_undo_cwnd(struct sock *sk)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	bbr->full_bw = 0;   /* spurious slow-down; reset full pipe detection */
+	bbr->full_bw_cnt = 0;
+	bbr_reset_lt_bw_sampling(sk);
+	return tcp_snd_cwnd(tcp_sk(sk));
+}
+
+/* Entering loss recovery, so save cwnd for when we exit or undo recovery. */
+// __bpf_kfunc static __u32	bbr_ssthresh(struct sock *sk)
+SEC("struct_ops")
+__u32 BPF_PROG (bpf_bbr_ssthresh, struct sock *sk)
+{
+	bbr_save_cwnd(sk);
+	return tcp_sk(sk)->snd_ssthresh;
+}
+
+// static size_t bbr_get_info(struct sock *sk, __u32	ext, int *attr,
+// 			   union tcp_cc_info *info)
+// {
+// 	if (ext & (1 << (INET_DIAG_BBRINFO - 1)) ||
+// 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
+// 		struct tcp_sock *tp = tcp_sk(sk);
+// 		struct bbr *bbr = inet_csk_ca(sk);
+// 		__u64 bw = bbr_bw(sk);
+
+// 		bw = bw * tp->mss_cache * USEC_PER_SEC >> BW_SCALE;
+// 		memset(&info->bbr, 0, sizeof(info->bbr));
+// 		info->bbr.bbr_bw_lo		= (u32)bw;
+// 		info->bbr.bbr_bw_hi		= (u32)(bw >> 32);
+// 		info->bbr.bbr_min_rtt		= bbr->min_rtt_us;
+// 		info->bbr.bbr_pacing_gain	= bbr->pacing_gain;
+// 		info->bbr.bbr_cwnd_gain		= bbr->cwnd_gain;
+// 		*attr = INET_DIAG_BBRINFO;
+// 		return sizeof(info->bbr);
+// 	}
+// 	return 0;
+// }
+
+// __bpf_kfunc static void bbr_set_state(struct sock *sk, u8 new_state)
+SEC("struct_ops")
+void BPF_PROG( bpf_bbr_set_state, struct sock *sk, __u8 new_state)
+{
+	struct bbr *bbr = inet_csk_ca(sk);
+
+	if (new_state == TCP_CA_Loss) {
+		struct rate_sample rs = { .losses = 1 };
+
+		bbr->prev_ca_state = TCP_CA_Loss;
+		bbr->full_bw = 0;
+		bbr->round_start = 1;	/* treat RTO like end of a round */
+		bbr_lt_bw_sampling(sk, &rs);
+	}
+}
+SEC(".struct_ops")
+struct tcp_congestion_ops bpf_bbr = {
+// static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
+	.flags		= TCP_CONG_NON_RESTRICTED,
+	.name		= "bpf_bbr",
+	// .owner		= THIS_MODULE,
+	.init		= (void*)bpf_bbr_init,
+	.cong_control	= (void*)bpf_bbr_main,
+	.sndbuf_expand	= (void*)bpf_bbr_sndbuf_expand,
+	.undo_cwnd	= (void*)bpf_bbr_undo_cwnd,
+	.cwnd_event	= (void*)bpf_bbr_cwnd_event,
+	.ssthresh	= (void*)bpf_bbr_ssthresh,
+	.min_tso_segs	= (void*)bpf_bbr_min_tso_segs,
+	// .get_info	= bbr_get_info,
+	.set_state	= (void*)bpf_bbr_set_state,
+};
+
+// BTF_SET8_START(tcp_bbr_check_kfunc_ids)
+// #ifdef CONFIG_X86
+// #ifdef CONFIG_DYNAMIC_FTRACE
+// BTF_ID_FLAGS(func, bbr_init)
+// BTF_ID_FLAGS(func, bbr_main)
+// BTF_ID_FLAGS(func, bbr_sndbuf_expand)
+// BTF_ID_FLAGS(func, bbr_undo_cwnd)
+// BTF_ID_FLAGS(func, bbr_cwnd_event)
+// BTF_ID_FLAGS(func, bbr_ssthresh)
+// BTF_ID_FLAGS(func, bbr_min_tso_segs)
+// BTF_ID_FLAGS(func, bbr_set_state)
+// #endif
+// #endif
+// BTF_SET8_END(tcp_bbr_check_kfunc_ids)
+
+// static const struct btf_kfunc_id_set tcp_bbr_kfunc_set = {
+// 	.owner = THIS_MODULE,
+// 	.set   = &tcp_bbr_check_kfunc_ids,
+// };
+
+// static int __init bbr_register(void)
+// {
+// 	int ret;
+
+// 	BUILD_BUG_ON(sizeof(struct bbr) > ICSK_CA_PRIV_SIZE);
+
+// 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &tcp_bbr_kfunc_set);
+// 	if (ret < 0)
+// 		return ret;
+// 	return tcp_register_congestion_control(&tcp_bbr_cong_ops);
+// }
+
+// static void __exit bbr_unregister(void)
+// {
+// 	tcp_unregister_congestion_control(&tcp_bbr_cong_ops);
+// }
+
+// module_init(bbr_register);
+// module_exit(bbr_unregister);
+
+// MODULE_AUTHOR("Van Jacobson <vanj@google.com>");
+// MODULE_AUTHOR("Neal Cardwell <ncardwell@google.com>");
+// MODULE_AUTHOR("Yuchung Cheng <ycheng@google.com>");
+// MODULE_AUTHOR("Soheil Hassas Yeganeh <soheil@google.com>");
+// MODULE_LICENSE("Dual BSD/GPL");
+// MODULE_DESCRIPTION("TCP BBR (Bottleneck Bandwidth and RTT)");
-- 
2.34.1

