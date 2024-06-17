Return-Path: <bpf+bounces-32307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29090B512
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E80B3E675
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315D14A4F4;
	Mon, 17 Jun 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2GzzAaf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TrJi2N00"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880814431B;
	Mon, 17 Jun 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633983; cv=fail; b=FfxDmv/cPA9MR2VOuQa3gHg5aN68qc5/b2A1sJEZWnSR4PdVk1oZ7mstspseqoTOfqpU8KP0khjdUXZuY8TOdoabj8FgkXHi+RJmgJpN6c/8DwR63nIhvNVdeS0VeVsTZzLlHsExt0x+M13EfQVWL6K/vge/xtXTxX5dQJHNq8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633983; c=relaxed/simple;
	bh=5NHziQAhXTkaVcaE49iOo55p2SAT2oWKOMWzSBGU328=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQiRNhbyF8/I6FRx20mTeXD0GSNnq9AlysWNd3NFtzbMMNaNrGRok3hfqX/fq5uqSYSCnmtRjOCTv+eY9DefG9KaaiXWwD+lOziJfxjjF+GhpElfw5ddxtzfisV1SxGs633YA/znaPfsXSgZchKRs0etNsauYQWxSChJkoG9CV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2GzzAaf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TrJi2N00; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBUbG018101;
	Mon, 17 Jun 2024 14:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kKdsCvZtshe/by5yX6cNmZgIu4AMmB6E6lney+h8orY=; b=
	H2GzzAafg6P2J7q/t86ivVS168cpoTDDeMUyLvpTI6QXhhObjuXbsnzSucSKxgbM
	u9qLtak2ZS4LnZTpGSaBWCHnO/i1LM+6gIM85HUhB/CIZrobHWlv2aqVez3X5FIy
	RVciyCAb5CPeSsWvuA2FDMOFtLlYphxDiJG+2hwYAvrE6AT36KX8laQ3b8ZbOnHb
	hD27Qy0yeHiV5rnAs18AYDMVXOYORa2qfNc0T6vyXKSVj5lQKTHjTk8g+MB69Dai
	g9+3W9JFR+vm9CXT4WVws40H0gPJsC7O6ZvLby4eyKEd4ev6SqZZiZZgYXbOPuS8
	gmiu3+aAyxigudaQDbq9QQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1veasr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:19:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HDjTko015724;
	Mon, 17 Jun 2024 14:19:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dcsmf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHj+uMR9vMIYshPTL0C/iI5cMxkQomMhAQ2XJ9f3lvyKd1ezSB9wzPWcYd7ZPn26FNyB8cV0HP62esJWe+iocVBm+FNdCgWtXYspZlEgSSjHh/E1n5ArfTSsuXhQX3dBi/OVpdpF/7BtCzBX2/WEZnXa4tM5UXmFfoNZxlHAd91KWYEoGsKA2U2IL1+v10AJmBE2f+PezhzAJn06vEl1WnMVj8BPluXFOBMhyR5jN/VdNZGR7uCpO5OjBNWfoNEKZrisqwx/rJ+OKMt1AhlqcF8LnkSgcDKxchYiUSRcR0szM0MSxHJM94CQAI342mFbNeu4QhiZSGZfeXW4MWjEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKdsCvZtshe/by5yX6cNmZgIu4AMmB6E6lney+h8orY=;
 b=fimWBU15HK814WmmIx8sXwqrb9sHFu/GnFcqVBmtk0YHFhCfxl+MqWi+qsz4HaeCDCBJdkYC3c2z2itQ7GW9To/gTLh8QHCvVy8d9xAK4iVf+U/g87bztxQUFdMsXjKTR06DLvmQOx6FP7QDLNb8duC/+26MyMg/omo7yHVUUrg+4B1EWbwLEXPrIwYcwcAIxkAF3XQSa+LNxe5IQui/eb1cfWEAUNyWahKSP2zOsFduwJ+E03LCQb/DbDBSZsubwkxnN41svhgrF52/3fbW//HYECuAEb2Z8OlrpX3YTBO7xhSujvljNEjNRTev40//QwcNsHIIhNmJK8tp8KoZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKdsCvZtshe/by5yX6cNmZgIu4AMmB6E6lney+h8orY=;
 b=TrJi2N0032wwU5AfgnKIdjsYO6mqtb+CdaFhkVXeSgGkAUuDlst4qxbgD2848k4T8COeTmndphRCVBZXVA8y9UHUeYyutzkoVgbKW/ERo3smMAy5K/uFf7wRnLQrwVfG5e5hlPxe0DKWQDDzRTwPMFLkCiK+tbEqpiyWa7Pk0Xo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7919.namprd10.prod.outlook.com (2603:10b6:408:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:18:45 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:18:45 +0000
Message-ID: <66e5356f-6b92-450c-b57e-7a8644a80ebf@oracle.com>
Date: Mon, 17 Jun 2024 15:18:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Donglin Peng <dolinux.peng@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii <andrii@kernel.org>, acme@kernel.org,
        daniel@iogearbox.net, mhiramat@kernel.org, song@kernel.org,
        haoluo@google.com, yonghong.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240608140835.965949-1-dolinux.peng@gmail.com>
 <4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com>
 <CAErzpmsvvi_dhiJs+Fmyy7R-gKqh3TkiuJCj4U5K6XXJyV6pJA@mail.gmail.com>
 <CAErzpmsBBnGNEgBzUfZyRcSeV1KLuNKvFfhuCap6NFbxG=qoKw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAErzpmsBBnGNEgBzUfZyRcSeV1KLuNKvFfhuCap6NFbxG=qoKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5b08a-3b00-4a72-8f33-08dc8ed86597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0tzRGRkMTlJS2hiY0FsR1hhRlR0dW1IdUNYQXBEQXhERmdCZTF4WGVtVzlW?=
 =?utf-8?B?MytUbjlGSjZlOTBDTGd4OVljZDR4c01PUE1OdWZSSmV3YTBiWVR1ZDMvdWlh?=
 =?utf-8?B?V1pFVVB4Ym5ZUk8wOEppRTgrWkMwUkQ2QXlpK3k5Ym1CeDBhYTJ3dGtPbTZu?=
 =?utf-8?B?ZFRsd0Q4bS9KQzVqckl2NTI4Z1JONjdxTmFNUUtBTzhPcmZwK1hKeDFZR1Ay?=
 =?utf-8?B?WnBhMzNmZ2ZkS1NFZnFpZGlsZzZzaThDQTljZkV0YjNqVkxUS3RGMXZ4WThn?=
 =?utf-8?B?QWJSK0J6SFdTbGNHdGl3U3pLNFVWeUdyb0cyWXMxN0RnMHRNUHRuaGttL2pr?=
 =?utf-8?B?ZWxmRllsYkczWW5lb3hRQzRwYUVHUTRGcUM0eGNFS0Z4cnJrSnlNNlpTZWJ3?=
 =?utf-8?B?UnZWNTJJMVpjUk1NMzRmd1U3Qnd5em1wSytYV1pDUGF1TTAwS1lVbjZYb0Rh?=
 =?utf-8?B?b3pQcHYwNm5PekltZm1CYjE4OGFvWXRsOU40RTU5d1BLT3QveGRkdnpBZWFP?=
 =?utf-8?B?ZW5KUnIySFRWTzZGaXM0dkRLaHhxdExyUGc1THZDZWdOZlZzS2Fud0hNUUUv?=
 =?utf-8?B?dTYzZjhzNm9OK3h4ZDhnVUVCZWlQVlB5SHF5YlZIZmp6UkZTaG5XNjZkaDlR?=
 =?utf-8?B?azdOQ2tRRzgwVEhXUE1ia1JxNmEwMUUwSVFkTlVFbjhnMHNWVnlCLzE2dXht?=
 =?utf-8?B?cXBNY2tYSTQzRDNVZUR1T01ZQTE0Q21yL0FuYlU3NEdaOWJEUEVEVjRKN0FU?=
 =?utf-8?B?d1QxQVJ1NEZLcG9sOTUybDR5V2lueEZ3aUVMc1VwUURLa3Y5bkJnalNmZk5p?=
 =?utf-8?B?Sm5yWUYrc242ZmpDeFZwY21PdDBMbmowdEZBMGNGWnIzYmtDUHQ2OXVWOEUr?=
 =?utf-8?B?WUZqNDZ4UDZlckJpdm9rNjFHdGJqM1orMGthUDRSbS9UZldtRlVGa3Bpc01h?=
 =?utf-8?B?cjVXY1RzMzRhSjJaSTJHVURwalNjc2MxbkFmYnRacGQrL1NWL2lsVVhpUFc0?=
 =?utf-8?B?WVR4blplUndTd01OMmNFZ0MvMytMa1VQTnZheUdDTlUrVWNvUlZVK2lBREFM?=
 =?utf-8?B?Uk4yUldrZjUzaFNvSzFrcHZCc0hFam1BUHN2R29SUEcrejNvWXBjWXFrcXAv?=
 =?utf-8?B?ZndhNU9rcEhBNThsQ0J3YUFqaHVZZU5lNS9MSkhuVDRrQTJTY2JDVTZrcWwy?=
 =?utf-8?B?NjJPMWZSWktoUkZTeU9VRS9MRWpPblVvU0EzLzBibE5qdUVhUDVXNXhJR1NO?=
 =?utf-8?B?YXdNdDFQS0lvSHc5WkU4NTdkUDJIUTdFY1Z2bTRqRmJkbmt5SncyeG0zM2sy?=
 =?utf-8?B?MkN2bDRJUzF0MEh3OVNKSjd5bjNmK1puSFZUMlZiaFFJemJxbkxqc0R6UUU4?=
 =?utf-8?B?c0Uyc0FhUEZPbHJtU1Zxa010OURZRnVJWFNkcUp5WHVITTBuK0FWM1l0VlZO?=
 =?utf-8?B?eUpHanJFdVE1bW8valUzK3o1STV0dUMxY0ZaTWo4Ly9sZWxwNDJ5a2RQZkhL?=
 =?utf-8?B?ZTNiM0ZxVFVvRnpIT1c2RmZBZVBGTExPcEVVSGwwb0tlU2YxUEJLWk5iYnFy?=
 =?utf-8?B?aU9tOGplL3lVVDdoaDAvRXlwSktZT0l6N1ZhajYzUHdCa1hvemxROWIvNXBW?=
 =?utf-8?B?cmFJajcxWnE1dmdBVkJOUzBmOHNTZ3dvRW5WRE4rUTd0cEt5SFZoa0JESURI?=
 =?utf-8?B?RGNldTI3RDZJSzVMVXhrVGdXMC9qNmEwdUI2ZDJKWUVsWGtxN0RFczh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWFRYUJmTENIVEFsc0JqU1czVGJGRnFZU0YwcUdHUGhOcEdjNDNzLy9meVpk?=
 =?utf-8?B?WnVxYU1QOEdvNy8rU2NPWnFjK2wza0lxdzVzN2NnemhvNXlQaGtDbExrK2dq?=
 =?utf-8?B?OXJ4RFFDM0hhbDYyUm81UHhBcjRKOXNjUmR1My9ubnZobm85ZCs1ejIvdjNK?=
 =?utf-8?B?amJZN25JNkQyMlRUZVhpb0FzclpoMWNKdXZtd0RjbzdIVHFNcjFRb3V2UkRG?=
 =?utf-8?B?MDFWSFgwQlVhSkMraXlkNFFGT1AyMUhQTDl4Zm1qTm1ublEzOG11ZGdFTWtY?=
 =?utf-8?B?SWFoeTZOZ3UwcHBzYldETmZJSWZ1YzFMQ3VlTXpZNzBFelM0M0R6Rk9YVm5M?=
 =?utf-8?B?UXhIN1F5N0E1QmsxMVJKTG8xRitJSzNBaGpzMTF6YTFIcWhPckwyaHdnNm0v?=
 =?utf-8?B?T2U5SGE3QUZVck1admRtRXlHN1FLZ2g3bTNEMDJnTEZoditwOTJjZTN1Q0Ji?=
 =?utf-8?B?MW80TGpSV2VCbDNPTGhvRXo0cy9kb3V3dTZQZm5NK2s0VFQydCs2dnJBajBh?=
 =?utf-8?B?dmEzbE51NUgxUmMvNnhlM0xsL2Z5Zk1obTdrSmdzczJoNmdXbk9UcWRzZzZs?=
 =?utf-8?B?cUVwSzRhQVRBUmZiSWxKa0I5U3grT2lPNENlR3FPTVF0Sm9wZlJETkhWM05m?=
 =?utf-8?B?NXFRQTkvVVI1VE5rZ0Jpa3BHQnBndnZIUnZIeDZORlJ0MjF2Zy9SNG9vam5S?=
 =?utf-8?B?Rkc4bWNpeFBJWkdCeVVuU3QxSWltTUFsVVBpNTg5Y2Jya1hvYVJGWGxuOGRD?=
 =?utf-8?B?ZllxaG9TcmhOYWlLa3RhWFk3U2ZGTDdFd2F2Y0xZd1JEUmJZeTBEVUJzNm5I?=
 =?utf-8?B?d1lPMXIrT2QveWpqVDJ4aFJ5TFR3a1pRSE1VQklqTWZkdnJBL2tiOVZPQnpR?=
 =?utf-8?B?V09TWGNvc1FnSXpDV08zWk1DV3ZaZkZzc2krTEFTQlVGVW5rUDhkSUVFWHBu?=
 =?utf-8?B?WHFzWHQxREQ3VWhrMVR0KzlLdnZXQjdIdDJtUzVja2hybmgrSTZsem1CMStG?=
 =?utf-8?B?TGFieFIzSHV3S3ZRcUxCcFZuNXF1dGNTU0NLV1I5QnJsc3NTRE9oWlhSUHlp?=
 =?utf-8?B?anZDRU9JMWtPNm1SM1JPUjhQMmtUdkZaUERxMGNjVlZzYS9lZlNpbGVvQ1Mw?=
 =?utf-8?B?MXlUMThOaFpmQ0Y1dUg3YkdBMjNPYTRKMXExVkluMXFOWjMxc2JUMDhHL0h3?=
 =?utf-8?B?dFJyZXo4emc3djdudnBza2RqV3R1cEhJQXErdmlHWkF4djJUYktROHY0alBq?=
 =?utf-8?B?ZnZXMlZZYzdYV0lmVlg4aVExRXZCZEZ6YVBuMnR5a1NPZm9kblA2RTRJY2VH?=
 =?utf-8?B?TjZjcnE5ZHFKc3pwbzcwWUMwOForc016cUZMbmtaWVE4SWFJTzAxVUxJMVZH?=
 =?utf-8?B?UWhMN2pCbUp5TFN1Z1RjdnRTMW93Nlk3dk5LQlZyMno4WEVMeXNzM0dXb2VV?=
 =?utf-8?B?L0xlOGhFY2pkbEtzMWhTMXF0dHRVcFN4RUVxU2puZm1pckovMjdvaUxNa0Jw?=
 =?utf-8?B?Wm9SMktBUU1ZTVRUdm1mUDFyKy9hV3NCVGVMTWY2S3VGUXJjWHJya21YSllN?=
 =?utf-8?B?ZHoxYjUydmd1SCt0ODNZRzRGOSsxL2RJMVc3QkxhOGFrNnliVE5RMmJ2aTgw?=
 =?utf-8?B?ZURTZnFob2t4VFNFaWJMTVRjblg3S3kxd3JNNndESXVZbzlJUi9YakQ4YTlr?=
 =?utf-8?B?SUR6bUVFbm8wcGExeE83RHBQZENQQ2ZhQ2NINDRxa2xETWpPTng2dVNCTlcr?=
 =?utf-8?B?Q0wyUlJ5bzJ0TlNpTy91ellyK2pVbGlhdEdjbnpOOHE5VEt1YWI2U1BRbXNG?=
 =?utf-8?B?SXVreFFGU3ZvY0ZBakVPNlZpTXZ5RjE0ZmxDZko3NjM3Snk4SlNDeHIxODJv?=
 =?utf-8?B?MkREdkpjbHZpNEpLdnB1SFgrNUk4ejZ1SXJuWUhMZUtDZ1ZNOWZiRGNydnYr?=
 =?utf-8?B?cEcvNWRyTnI2cFROclVnQThKYXA4N29mSzFLQzhtcTVBR1Ryc3h3Tm1kYzlP?=
 =?utf-8?B?NlRJaDNWWkxldkpGblBIcDhSZlhZQ01xaWlmQmlZMUErVTFEU2pJem9TcmJq?=
 =?utf-8?B?VUZaN1RMVUpHY2drZlpVN2VuUThjdDZVbjZRckM5UXhrR3NINVJsakF5T0Vp?=
 =?utf-8?B?UFpSMGNZOUtPOVBxL1Bmc21udXNoSGVKeFdnUVloWUM4T1JTeG5rKzdXMDdR?=
 =?utf-8?Q?joil98U8j7UOKc+fgxaMivQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oM6E6ImXxDERk0NPnUul3n3sLH/tsoQ4yhX6N1z1ANl2qIQYyKlyLScbQ+3uLrRLmFZqXjOU/hLaSmSjIJqxuxQ/OVS9wXBaq0isjY/36e3fD2DzT7RSKAyPy4i4fc0B8Sj9oEpqcbw9uxwsIthufKogGsQwJwt2nVAELlfu92QbsQ0FKQrRH3vKyb4KWO8vURi35dHhlHCmQ8MdF6ecsCTLXRZvgAQ1sNRsV1nryQ6daeHiS41nM0zU3yKqJ+Wmvxkuq/WPdUrDEXUBfUqDwM1zVepyENTtynko2nzi8HtSHMOosSIqsTcH1gd1CwtmRosCYg4IW65nuBTlqRqOc7AIZnRDbu6uAplrXuNjyHPDRS+bztC6FqavA/Ve4/f0giXtfA53IElMy62cR9NuyVVatBUhNG1fPa4FLOIS+LdKmRGHI1BZEtMYB6XgQrTZbMSkZp7+WzYgRtF6bgOTb0xBGxJ3vTbkOfhM8o/At5lmBGsZ1DogPYHoYVGgiVVSaRT6+aHikaviPzkicGBOn8hoXZ1e0wlMQixHmkMRXdnzne3znnp7S3WksZhqoUtuqCKt1vU4mP1dIp7RJJfEMPn1rIMI87h9l1i9dC6HLNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5b08a-3b00-4a72-8f33-08dc8ed86597
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:18:44.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1BGhiJHQ+ozbg2wcH77U5CclT6klASJyxPpIkTbume3rRB/HcVL+zpO/c1LB1nTzCwFK0lU2PwdlkuNvBFmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170111
X-Proofpoint-ORIG-GUID: xCyjxvhNmc6mVrptbqvuDj35j5Sq7h6p
X-Proofpoint-GUID: xCyjxvhNmc6mVrptbqvuDj35j5Sq7h6p

On 15/06/2024 15:59, Donglin Peng wrote:
> On Sat, Jun 15, 2024 at 7:49 PM Donglin Peng <dolinux.peng@gmail.com> wrote:
>>
>> On Tue, Jun 11, 2024 at 6:13 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>
>>> On Sat, 2024-06-08 at 07:08 -0700, Donglin Peng wrote:
>>>
>>> [...]
>>>
>>>> Changes in RFC v3:
>>>>  - Sort the btf types during the build process in order to reduce memory usage
>>>>    and decrease boot time.
>>>>
>>>> RFC v2:
>>>>  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfor.com.cn
>>>> ---
>>>>  include/linux/btf.h |   1 +
>>>>  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
>>>
>>> I think that kernel part is in a good shape,
>>> please split it as a separate commit.
>>
>> Okay, thanks.
>>
>>>
>>>>  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 345 insertions(+), 11 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>>> index 2d0840ef599a..93c1ab677bfa 100644
>>>
>>> I'm not sure that libbpf is the best place to put this functionality,
>>> as there might be different kinds of orderings
>>> (e.g. see a fresh commit to bpftool to output stable vmlinux.h:
>>>  94133cf24bb3 "bpftool: Introduce btf c dump sorting").
>>
>> Thanks, I think it would be better to put it into the libbpf. However, I would
>> also like to hear the opinions of others.
>>
>>>
>>> I'm curious what Andrii, Alan and Arnaldo think on libbpf vs pahole
>>> for this feature.
>>>
>>> Also, I have a selftests build failure with this patch-set
>>> (and I suspect that a bunch of dedup test cases would need an update):
> 
> Yes，many test cases need to be updated as the BTF layout is modified
> unconditionally.
>

If the plan is to fold the sorting into dedup, pahole will inherit it by
default I suppose. Would it be worth making sorting optional (or at
least providing a way to switch if off) via a dedup_opts option? If we
had an on/off switch we could control sorting via a --btf_features
option to pahole.

One thing we lose with sorting is that currently the base and often-used
types tend to cluster at initial BTF ids, so in some cases linear
searches find what they're looking for pretty quickly. Would it be worth
maintaining a name-sorted index for BTF perhaps? That would mean not
changing type id order (so linear search is unaffected), but for
btf_find_by_name_kind() searches the index could be used.

See the btf_relocate.c code at [1] for an example of this where a
name-based sort index is constructed for the smaller distilled base BTF.

[1]
https://lore.kernel.org/bpf/20240613095014.357981-4-alan.maguire@oracle.com/

