Return-Path: <bpf+bounces-48257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F7A06067
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507EF1883835
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760691FDE38;
	Wed,  8 Jan 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zv2M9OVp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZAxAEHfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7B199385;
	Wed,  8 Jan 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350818; cv=fail; b=pwh3KjeTCrtYFelASAtQAbV4gucseVaiur4cExAW1AWvFw3OIQ1Ebq9egR9C141j+eF4i90cplMTjko8bx3HD1kfX5Gme9MjR6L0se5zmHA72HohKz8QdgUmURlXiuQEmnXf1yGXhUyrw9EXiQd0vFjgQn7//WGrtlAsj8D1gP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350818; c=relaxed/simple;
	bh=j7ratI07kWf+jF76COjwBCB/Qb2mGs2+78h+nsRmqj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j/1sPJ631T4KjLgNJ4fbivh1SnZepOVHENj2L1EKwbcnsAduFS2YMbZbxvQxUUOYlM0/aRGju/1QDVvGOnx49eS/kaF6xUswEldNmPFx3lagypkuv7Kyth5eDcNfJpN9PdxIRZOoLxJtF42wLNs43an40LIQMi6I2NhGq8kAypA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zv2M9OVp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZAxAEHfQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508FNPlL004965;
	Wed, 8 Jan 2025 15:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eTVQ+iCHb3fHtG9T73OjPC7SHYPtMhkX/DOtidSh6Cw=; b=
	Zv2M9OVpEbPX/PZAUdlKEHGavs30q8k6sFM8f4mn751dsza1TIl7DGCmRGHEx2+1
	ftA2lGnMlGfSE/I7KW7LKjBl5qyKgZMGsgSvR9I9dvO0WNiYGQKyyK0PoyXLZ31b
	Y/Q95fn5AgV9geJpGMDS+d7BppQuRoKqOwofelwzsGFnSp/8xUhxeghiXSvSfI28
	SrMb1kThlnBFRR9KcvbiUiWw5KBY/gdRSYRSVH0D2nDjhCsYY8vN+apU7SudEZu2
	PGbjfRDo7lxdMJtqmy3Km3M6andS48TDwQkkfbA1PlID7YlQbzjoRJWUBu4ZE1xQ
	lj9CKNVUUwzDPm5FQFsgsQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc78vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 15:39:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508EosMu011049;
	Wed, 8 Jan 2025 15:39:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9qryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 15:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i05G6ukWhQzYPIvGUkf+4u+UEcqB6uMmBIbILcrEvd/gdv2ib5O788vleBo1A/ro1ge/gQT5moyWe9KNsoyVIqaHvc2UNDDFdTwLHdjGPV7G4Qj/tkIPjepeTyMqp/DNIrFi+LEo3+9g97Hdl4eKYMRiJ0Z6rGftJjLPLEpLHno/I7NXPqP44UbZRfGvGaSNX7nSf+gZyJKL0wmtiFrLfCn1kZ5zKsDC/bODd/jYmsaVTLG9Hv8Rb1WASMS3cQaR64IP8v9UKIDk4MlnkImKjJOvvKNQ5Qr37wgOzaXg8AdG/lEj0pwx5zDXYo37a+sDmQmZAZNMt+bgIqI6cJBaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTVQ+iCHb3fHtG9T73OjPC7SHYPtMhkX/DOtidSh6Cw=;
 b=sNgglpF5PQiZZSlbJPYyielGh9rnJd28jsSD04A9h1NGjfBvRtMbzh2M/NcDBT7JhTa2o/b8ipX3+8WLQk2HSciC35G5RYB3Zw42kkm7NoHWlynyvwdHHHZg+vTqMB04g+vOhCMWQKQDYWa18Y5Po5RJlOj7AGf/vSxFFgWgL+16UDeXN3nx+LVaNuUmnDXLJ0630DYs5KSK4C8tCobvO9KIxxftcGqFMw74vO2AIzNfrS4041Jy5pZfIhKww9IZgJB92Z6D8m59OES+O/YqWk84oSpIR65VpePqC2ID44WmCMo8WeGZDZtl13LgdC1Z6cNp8CnlbQdCMNTaBh8cbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTVQ+iCHb3fHtG9T73OjPC7SHYPtMhkX/DOtidSh6Cw=;
 b=ZAxAEHfQAkFocryp6+Qt+b8ZCA3yoYJC/BITVl0TL9ei0YySzkW18xLaaoSM7yDGB1CTCxWrlme38JY7yJlwL7WVV6UPM1Pnnc6BzydsZvjIxhkZiWyxhVi5Y+bMh2e164nbaoIdwnyRNKw8QRKxgVNPL8mCuOVZeN9z3zFpHGc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 15:39:56 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 15:39:56 +0000
Message-ID: <8455bc79-a684-476d-88bd-9f7ff9ffa637@oracle.com>
Date: Wed, 8 Jan 2025 15:39:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Donglin Peng <dolinux.peng@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@kernel.org>,
        Zheng Yejian <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
References: <20241223201347.609298489@goodmis.org>
 <20241223201541.898496620@goodmis.org>
 <CAErzpms4g8=3486Uv-PPxiA0GSkNQQm1Ez67eo-H3LtAhTAJCA@mail.gmail.com>
 <20250108135217.9db8d131835acfb6ce4baa88@kernel.org>
 <41a44111-fa49-460a-afa3-2bad7758c60e@oracle.com>
 <20250108102443.415495e1@gandalf.local.home>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250108102443.415495e1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::26) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd8e2a-2605-45e8-e33c-08dd2ffab3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RvbGhlc3dDQVYyLytRQk9RbzhoMGk0MnR5anFpN2RzeHZmMFpNc1lwcUFn?=
 =?utf-8?B?cm0veXp1b3ZZT2tNSnd3L1BlZUdiMnVaeUJzdGNJSDM1NlJkdmtvMTVYV05C?=
 =?utf-8?B?b01xN1lOVU9xOHB1YmswRlAwOWlrQWNST3h6T1p4dTFNdU9jd2xJVmJHZU4w?=
 =?utf-8?B?OVhpQWF4cmZsMnJtQ3BTRTlSTjRZT3NhUlZBY2tVUCs4ZGFFT0VCOE0zOE1q?=
 =?utf-8?B?M1ZNNklaZnU0OHZWM1dzQ0tjQmNoRWdjdi91QnNnQm8yTk1QUUdnallDRGk1?=
 =?utf-8?B?cmVCM2djdmtHajdXU1NLdm9tM0dsbGR6a2pVektNNHlvSGpObXgxdk1XeEJK?=
 =?utf-8?B?MkltVGQ3cjRtZmVIT242bmQxS1FhRW9Ec3Y5YXpURXJ3cVBBV3VzVlEvT29J?=
 =?utf-8?B?THQ5SEhkZ3RFOU84WnY2VmZtVUZXbzRJVGtpRmhPaHd2WEhUZ2xWa0lITU9U?=
 =?utf-8?B?ejR3UjRoc2ZvQytZeHhoVzh4TXhqZ0FEZWZVbXZFVU9wdUUranFwdFNnNnVR?=
 =?utf-8?B?Y3Q3MUV5ZGRrRjhBcmRzcVd6b2hGSG42dTlJZDlrbEJKdTRQanhoaW10eWNL?=
 =?utf-8?B?bkgvNVphK2xpTWFYRThQUTVqOGhhNlBqeDhBUE1WNUZaSGhVdGp2dkJrRTdP?=
 =?utf-8?B?MFVBMjQ4cGZ0RG5TOW9hNkRTZnRTUmdlRlYzNEJpd3VFdDJIQnpBaFh2SWpu?=
 =?utf-8?B?WGFBeFVhbDZKNS81TGxtYk9OTEFqZjhURkdMTDVUVlpNUExNQmdtdDk0aGh0?=
 =?utf-8?B?ZkVpeDVRczdPNmViSEpMdFhSOWUwZitOVWo5VTdVdytHVXF4YUg4M2xQU1M5?=
 =?utf-8?B?SkI4RWVmOGJNNUxjeWFoajVnYjVEWXU5YXM4eXlnZ1hFVUxMd09kL3JnR2Qv?=
 =?utf-8?B?alhLRGs4UC9HcUZzUXZud3lhdFBPVVIwOVRYL1ozclExeTZYSjBIY2Q0Q1JN?=
 =?utf-8?B?VmlNS2p4Nis2OVFaR2gxNjZJeUJJanZCQmJ4UHhHU05IN1hqZEFzQURhSWVN?=
 =?utf-8?B?UDluNlZZYnZzamEvRUpZT1FlK0ZyTnRXY0p3VWRpQW1ZdWZ0UU43Zlo2ZFNp?=
 =?utf-8?B?WFRSNGJLYWlSaDF5NDg4ZzFLTjZoLzZENG1yaGkxYjNYaTNsWkxNeHcvTUtG?=
 =?utf-8?B?NlNUUlVzU3RDeVZucnpjemcvdytUUUhNbHlqUjlrMmFzVndLeXhkMFdncG4x?=
 =?utf-8?B?MGZvYU1ySjFZaENXUmp3NlNmWlhPZWZCM0t1TWlTSzBmQzlFV2MyaFZkbzRh?=
 =?utf-8?B?eU0rT3hidm5HdUxON3pTNEtWcTZWUkhTdVdsRnFaMlBKbUU2MWRhSEpqalhL?=
 =?utf-8?B?SFl0MDZ0d3J1RDZJOUg3ZGhNeFRZWFFHN1hOWXBSRndpZXhrYkp0U1BXV3V4?=
 =?utf-8?B?enI4c3lFcXhIQUE4MzUzb2tWZEY0VjVNa2lSTTh5ZUEzcEZuRmNRdFhVVE8r?=
 =?utf-8?B?eGtwWWxnSmJoLzBpUlN2cUlXVEdmNmRYZklSdWRYVG5FdjQ2WktQdVJ5M0d4?=
 =?utf-8?B?bHVmWEI4NUFJSHVGd3pZdCt2a2RWNmZHNDY4MW1xUkJsQTJ5Y201ZkRLdXpQ?=
 =?utf-8?B?Qm96d0M3S3JyektLTFJjNkk3VktDT0t3ZVczUmFZcmRBK2tLQ0R3QXBoZ3E5?=
 =?utf-8?B?YldFVlVFL0JpWVBNNDk1VDF4QXNKTVNlNGcrZUhGZk1uenVyYzV5RENYa0h5?=
 =?utf-8?B?aVV5RnRnWG5qd3V1K3BPTFl6WjhLbVNrcVVjemdCS0plTXdQdGxrbE5aQ0M1?=
 =?utf-8?B?b3R4VWdkKzhkVlhNWDhBV1RVVnMyTDJEOWZkTWl6RlJtb2ZDQ0pVQkQ2cDJ6?=
 =?utf-8?B?Z25hMm5qTFJsMXp5dUp4SnZPRTc3bkdJQUppRG4vR2NnMEl0Wnp4MXdyMmtL?=
 =?utf-8?Q?mvcx9Fe3zYh9w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blJZRGRhblVKQWJPeDM4OXlCNlpuYW1NODVGTEh5QkRxMzJJa3VvWjJ5OEVM?=
 =?utf-8?B?QVpidDBhTEsyOXR0amhWbjlRaGNkMzZnMXBXMnpqNy9Ic0Y5YjJYdEduUjFN?=
 =?utf-8?B?QUF2eUlBSk9pT0c2LzE2K3hJeHdEemdNcjJmNjZhR2hjTnM2VGZwdUJCNzJU?=
 =?utf-8?B?OWJIbUc4THh1MGg2allwS3A5cFZ0SytiM1F5OVpDSGZPWC9XODlOQlgxVjR0?=
 =?utf-8?B?SUdZSkR3ZWF4K2ZUckc0NFJVdHRUanNHWDhBekgyZHZCOThwV0lKUXZLV3ZE?=
 =?utf-8?B?UmJqRjZqVUJBWFIyL2dvZW9EMU13ZTR1Ty9aNzVuUFROUXdORTZWTmlkNlZM?=
 =?utf-8?B?TGVoVDFocXBUOXVoeVlyTmV1c1crbnF6Wk9wT2ZJVGNjUXJNYm9qYjJDOG93?=
 =?utf-8?B?V2E5eDhZVWFPSlhHTEp3U2hpczlYd21CbkRlS2JhdGN6RCtRKzI1bTBhazNK?=
 =?utf-8?B?US9JVzNjLzdEMjRqcW1sb1dTY1NMZTJsV0RaK0QwOEY0NUswLzk0enRMNHRl?=
 =?utf-8?B?ODlHQWlvS0xCNDdVVjRJRjIrZ3RNVmh2c2VUNitpM01GOWdOUnVIanZtdDVG?=
 =?utf-8?B?U1BwVTJsZkpYVDgrcHBJK2o0YndkTjZERGhGR0I2ZDUxSkpYSE1wczFOc2Mx?=
 =?utf-8?B?OUZESUFLc0J5a3V1RDdkUzFQNitIVzRwTkVvQkE4dHVwTXVLbDdzbk5aeURG?=
 =?utf-8?B?dTZoYjRxTGZ1SzNuWVJUdDlsTW12OC8xYXZlaFNrRHd2K0dGV0Iyc1RyRWJr?=
 =?utf-8?B?Qit4N054eXVORm9pWktkQmphdDlFenVhNFZPbFdiQncyNEJsSFBJSjhIdDU4?=
 =?utf-8?B?emp6cXFTL1hHRCtlMXNoZUNWYlZPOUFWeG1pQXh2VUlMbXRuaVRDTjRMaGYz?=
 =?utf-8?B?bjgrdENqNlhMT0c1T25qRXpoaEpPVGxWL003d2tDaHJHQy9sOXJpRlliekhm?=
 =?utf-8?B?NzdHK0tRbGFSd2UrcTBRMlFsaTVhckVFa0tVWlNxd1JjUHJMcHQ3QjRiRnBS?=
 =?utf-8?B?U1pQWnVwUElCVUl1T2FsbXhna1dOWkUrcjJYaGRUQi9kZkhPMFZSTUMrdDZl?=
 =?utf-8?B?NFhub3h5TkZvQ1NJNWQzbTdZTWhlcG92WTF6UEdyWjR5Y1d0aGRIT2JUcEx4?=
 =?utf-8?B?NEd0cXVKb1NFcFljNTA1WGgrWndQbGZzUVN3YmNuTytXVS9WQjVYdEZUdkZ6?=
 =?utf-8?B?L20vYVZWeUFxSmhlZkprRS9sbE5KYTREQ0Z4cWRVWVFpOFFyV0gzOUtFQWsx?=
 =?utf-8?B?T3QvRytzSnlyNlFYbnp3MkJYS0dxTG0xeHUvWkx2TSszeDdrNE5lbXcvYXR4?=
 =?utf-8?B?NFoxMExhUE9jNDk4Qkphc2FMODlnc2NaQXYyeGdEaVAwOWFZK0xyb2pFSW5u?=
 =?utf-8?B?Rjd1QVdTWDRsWUNtSjZCK2ltSmw3bTQxWFJnOEhKUndhWDdDbW1LYTM2Zlp0?=
 =?utf-8?B?L2ZtUGx0Y2xpTkEwOXcxUHh0YUN0NDI0ay8vYTVBNGg4bDRkWWhkS1kyd1VP?=
 =?utf-8?B?dERIdXg0UDdYK001OGdoTzk5T09kT0J5bjhUdEJFYW5qT1NnSmxuR0gyc1hl?=
 =?utf-8?B?WllDdi81TldDaENKRUNGUjNQM055NGJjV2cvcjlnZEVxaUVUenZLTWh1eDhU?=
 =?utf-8?B?aUIyWWtpYTBYbjVZbnVWS2VuME1IRDRCc1FRS2tERUwyZkhyL1lZa1hBODh1?=
 =?utf-8?B?Zm1UTnlRZkRKTVgxTlA1dUxPUUxEeHpNZ3RUZUtXdWVYTGJicldGQW9tTmt1?=
 =?utf-8?B?dHdybGJWd2w4V2xLYW1uL1I2RENpU2x4ZU1XYytVdUJ5enRueWFOdmJNbEZU?=
 =?utf-8?B?dk0rZVVVVVZBQ3ZlS0tvNWUvYmNnR21taUxNTXJ6K1NLMlV4TDZqbVdpdXpo?=
 =?utf-8?B?VkVUUVFlUWtVM1VRc1ZFbHY5YmFTdGo5RlpzUGdRM3ZVMncySXZHMWdIYnlR?=
 =?utf-8?B?N0s2eVdzZklBd05iOWM5Z0JsdUovdUdwczdvTVVFckRRcE50d3Jvc21hdE1j?=
 =?utf-8?B?TGZIN2dScXgwdHM5SHE3MEIveVFidUNIRS91K2JqRUJiMUpQQkpBY29TdmZp?=
 =?utf-8?B?NTNxZWVRWEllQjVaLzJmM3JxZUZDa0pOS2luR3dmeWl6NURvcytCeXRwMjdz?=
 =?utf-8?B?TUZENkZBVVBXQzNlYUZmNWF5Q1h6aVhmMmRYSXI0dU5LNzhQSUx4b2orc1Ru?=
 =?utf-8?Q?NqWl23bUR5FKStYfyJK1PP0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QQThwN8aV8wkmvul3FfukdaSkLNEZ7NQTtANMVrbkq9PpqIonjVdpM9/9POc3GzrSGkd6Q+fnUzJuv4oYk3LjH1JT6lfbvtzoUQ+8mwGvrrLbqYsE4dXfvUAYF8H+jgP7L5JNqjcKDXuH0A0tjAOFoV6YiQgfZWCfajh22LGRImuK9NsBR2eCO/BfAqI/bqt0bkHsBFBjnqM6okhCIDFJ9UJoQcba45+LvmCj8rnS3d2tZMhiZjRRI9tzaB9zm8bnTg/9y1xzVTf3sALjzXnkvlg2hOIryY+BMOf3oOZo6Ja/ifZE+FxpjU3Qr0xl0qhluIlCWbuaY/u5olY0vyQtP2vTH6QwkD3BW+grjixd1rbAVbSKbZ149vZgQNfUMxJAHxwO6DnLRbl0eEk7GuniKRgsgfdttH9dedvYX80Osxa1/NZpeZBmd9Jtb4Zr01LEO9nEaeUZjXgRgYw8703LBgIAW5p4MGT/NxtWgXHkq1Ei3IvnN7LUGdk5kKeOG4+XhVCphXTTbn5+9Wd3VXs3FLDqpLnNv17NDO3FGBQIZLQyhY0pC3FR21SdwWSjIGDa0ocmPg3SUR0cwa4pWpv+4ljx9A5V2y9ko6b64ur7rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd8e2a-2605-45e8-e33c-08dd2ffab3c9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:39:56.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkXxJFpdkTO52ZRywypAvCTqmzt8SdMjfTHOPGKSqIE0WBlmiUU5UPu+ldSgO6L0N15kYBFMOHzbInrNhmhl0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_04,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080130
X-Proofpoint-ORIG-GUID: O4wzhyPyxWcrX8Ay1TLZIdhSciHKAX0h
X-Proofpoint-GUID: O4wzhyPyxWcrX8Ay1TLZIdhSciHKAX0h

On 08/01/2025 15:24, Steven Rostedt wrote:
> On Wed, 8 Jan 2025 11:19:11 +0000
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>>>>> +       trace_seq_printf(s, "(");
>>>>> +
>>>>> +       if (!args)
>>>>> +               goto out;
>>>>> +       if (lookup_symbol_name(func, name))
>>>>> +               goto out;
>>>>> +
>>>>> +       btf = bpf_get_btf_vmlinux();
>>>>> +       if (IS_ERR_OR_NULL(btf))
>>>>> +               goto out;  
>>>>
>>>>
>>>> There is no need to the retrieve the BTF of vmlinux, as btf_find_func_proto
>>>> will return the correct BTF via its second parameter.  
>>>
>>> Good catch! The second parameter of btf_find_func_proto() is output.
>>>  
>>
>> One thought here - with btf_find_func_proto(), we will try kernel BTF
>> and then proceed to module BTF, iterating over all modules to find the
>> function prototype. So where we are tracing module functions this could
>> get expensive if such a function is frequently encountered, and it also
>> opens up the risk that we end up using the wrong function prototype from
>> the wrong module that just happens to match on function name.
>>
>> So I wonder if we could use the function address to do a more guided
>> lookup. Perhaps we could use kallsyms_lookup(), retrieving the
>> (potential) module name. Then maybe modify the signature of
>> btf_find_func_proto() to take an optional module name parameter to avoid
>> iteration? None of this is strictly needed, but it may speed things up a
>> bit and give us more accurate parameter info for those few cases with
>> name clashes, so could be done as a follow-up if needed. Thanks!
> 
> Well, every place this is called, we first get the function name from
> kallsyms. Perhaps I can modify the code to get the module name as well, and
> if it exists, we can pass that too?
>

yep, that would be great! One thing we should probably think about for
the future is ways to stash module/BTF ids such that we don't need
lookup each time, but I can't see any obvious way to do that currently.


> -- Steve


