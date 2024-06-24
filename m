Return-Path: <bpf+bounces-32914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED5914EB2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AB9B239C6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E341428F3;
	Mon, 24 Jun 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YaIfDgNy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjesu64x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CB142E6F
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235860; cv=fail; b=L3r6c1q+AOZmvRDPJgK+HeqfqjNsHWQKollpNP3/f+00mt8ID6MeqcBkUZTN5VKGDhGrVt3jphkdxYUI/PwpeWG/wlvhpSiTEHADHT9ZUrR8Fzl7Mu6iHsDJmlJDFomIfAM+KTlcDoEimmTcAITDN6wSF91b51eS/Q9H4zJfH/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235860; c=relaxed/simple;
	bh=qlbw5xhRHqyoHv5M7yj6wM1KDQAKJfCE70gCUNe2rJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSNYFggeKoXzmJYRqdcyum0giY5sbFPVHZV8iDI2QGEmdQ+UbGHqPU1/bxQ6YCfmfVgW9JXpi8PReQb2MYM9UEBYfO2QyywpOyFxgLztT3W5PnWKTm0dWZ/hEvpgAlETIRNGAKBXtYJUFjypdAr3TGzcs74ktuBing0z60fFjdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YaIfDgNy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kjesu64x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O7fR8A024148;
	Mon, 24 Jun 2024 13:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=g/qn3ELRABFhXNcWbrYgmuJWmI1VIR/vUUd/kdr2f8I=; b=
	YaIfDgNy5R9cmdcqZcw294kjDYobDI20n87M6QGKSaqdPnkJy/pi9A/XSjwcKUov
	LV53hb2a2OM86iuBhXihmLT3CoWDPyJwyHjclRMc1UV0cEIFyf9UrulFilWCwTHr
	ahRG9ZSSjfaSHN+4FeURo5C9YCrWKJykDpx0TSCzeva4EWFHw73N040/yaB/A0jc
	7htSmbGrKFxU5Z3apNwxxqHNiYpc8nW79czNeJdlkomLwIRLbL2iDqXfAIviV4Hz
	T/MNlkDcJSF0raWq8s4ufBxX7TYG5/+SunwSrJGq4tCbVK7/s7GDNfcu8ExQEbne
	cMOwyec9DV1DTnIAgqYOrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn702nrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:30:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OBsS5E001507;
	Mon, 24 Jun 2024 13:30:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn26pu7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 13:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj6KQxKylzhpjGxz+3T0JHuJOkQS68S1eilh1Krw1seLM/oS1ZUqif/L907xcFYLyIbZ+NzYSTnJc6wc1uLvEd8fxiqSegshpdZJOzmlmrqLJIvV33R1LU/Dxyc887Qtb8sri/UIn2e0Pid2BhaJNRwfFqkKWzIEONaxR3XX9OhtoFAYmKEzwexNvbGONv5U1aZ8yISXvg5rcOMK/y6GcOHkAtVWAJDTHlktbA9uRXU1qPvqXwz39j0fUYHts41E4qEx8JG2nPClXKupRqd7EfXiq68aWpwYNyJ6/scEmAMauoX+mQvvRHjNT/2nYzUHo9A5SshqWrxkZ8X1A/sW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/qn3ELRABFhXNcWbrYgmuJWmI1VIR/vUUd/kdr2f8I=;
 b=PhydDNtFfmWX/I/m8J/wGvj8yaEhSnoxZSe2FGgieMEqngfJPjWdNM0u2PBKOpG9KfL9UnRgUdfNz37e74k0P8K8RVpHlRHrFyGYHZJ6RZBy1Nqo6rN/tM0BamcZD4gkr03FguJI+mqZpzH212uxPDKYNsuD0oXUTo6I7YXm4eQbu7gZyg8eT8S9gIfGEpX1+ebyqPEseWxSu/XfrqvNPkwutD15jxVVD18FxX3/YG48LBTxq70VruRpcvKpEjQ4SYxrAvJcbdFe8JqUwRRXjzvY/gPQRCKKul/TWZ6+RmZw456RrKAzD29NYOz3WWtN7sBP0FQUYpEEGHn/odczMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/qn3ELRABFhXNcWbrYgmuJWmI1VIR/vUUd/kdr2f8I=;
 b=kjesu64xvirHWxPxpv1tfcll7I8IZr7VYHen7K428e1OKMTpPPexJRSVvNTI1gaMvWwOQmbgmJRPF2+H+Ojsa0h7m0ROJA8g84kBsUHx8xv+nq3KdIvsDKCL8cBU2/saOnAYi3bTvWtrnUEl7k+rMzNdgedcxtsLE34YVFur1OM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 13:30:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:30:50 +0000
Message-ID: <e4ff46d8-c4d4-4c0b-bea1-c0ab9aa6517d@oracle.com>
Date: Mon, 24 Jun 2024 14:30:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: skip base btf sanity checks
To: Antoine Tenart <atenart@kernel.org>, andrii@kernel.org, eddyz87@gmail.com
Cc: bpf@vger.kernel.org
References: <20240624090908.171231-1-atenart@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240624090908.171231-1-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 765aec34-aba9-4173-ef48-08dc9451dd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SzYzeHd4cFVCVGtBWFVWZFR3aVEzcEl1SzJ6b1ZTaitpVVFaTml0TW5OWGdy?=
 =?utf-8?B?L1pDUkhEYWN2aE0yLzNHWWZQa1ZiZ0FUYlJITGdTZndwSkpUbHNzM3MxcXRu?=
 =?utf-8?B?MzFBcWMwYXVqZm9JTS9iRzFIL3hITlA1b2pLWlZqWjNLUEU4UE9kY1VwVVhI?=
 =?utf-8?B?NEp6R1hnMEsyRFlDZDdVVHg4aHRFUWE4QUtkWEJyZ2tERlUyZEloKzhQWk9m?=
 =?utf-8?B?TDVGbWhuV3FhTGgxMDlmanlERjhubmkxb0tRQTNGUkZlNHpzYmpsL0hFVVFB?=
 =?utf-8?B?QnBiRTREZUJQMEIzcS80bVh3dk92c0Z4TDZJSndvR1NhK2NHaTNla2tPdkE4?=
 =?utf-8?B?eC9uWHdmZG9ub0FHbEl2aFIreld6T2NQak9pZ3JFY21JUEUrcXJCUUlaeDgw?=
 =?utf-8?B?YVlpT0FBQmlxejI3UjhRNjdLTVIwUERBUFVTRm9XYTJyR1EzS2pVQ2dFOHZ3?=
 =?utf-8?B?K2JnZmJCSTB4MGVzakhBL0FUUlBHRG0wUVROSGh6bXI4WW9zNk1oSU05VHV4?=
 =?utf-8?B?YVVDSGRUbzRyWUN0Y3FFczJoU2d1V013dld5Z2ZOeE5CZjlKSXc3OHkrV0Ny?=
 =?utf-8?B?YXlFbGtZWldWRHJtRHRpVCsxams5WEc3eUIyLy9ONGxJWHRJdm9hcDJYYnBr?=
 =?utf-8?B?SDZFSnBwcDRlT0NTNkdrN0xjNmdFdlZpb2ZvYUxaR2lGa3Vod1ZPaFRDNmlE?=
 =?utf-8?B?STVHS3NYcWRWcVIxMW56YnZaU2VUSXpNT2xDV2NwVjBUYVh4NHUzaWxtTUs2?=
 =?utf-8?B?bllRMWFmTGJpbm9oUUtLVFhWRzl0N2piTTZCaDMxbDhYdFFvaGlOaEo0bVlt?=
 =?utf-8?B?c2dRb0o4T3RmQ2NJWkRwcTg1RDRTdGd4Sm5nZUZQWlBEVTR2dEtFdHpseHN3?=
 =?utf-8?B?NjMvZ0QzQkRQc2tJQUFlQys1SHlabWg2Rms4RDNYb0dVNU1iQ3huc2tMSWlI?=
 =?utf-8?B?RlZhbzl1QkdsK1pPRjNUaXlkSkszQ1NnZzdtbHE0TXRUOTB6ekhvTG9POEdx?=
 =?utf-8?B?TnVERVlxL09FTitOU3BGNWl2eVZmMkVBSzcxek1QSmFmWnkzbVBBTENXMWdv?=
 =?utf-8?B?NWVRbXUyVlN6aDB6MFUzT1RNUi9PUUxUb0ErQTFGM3ROU2xUa3Z1dXlvRTk5?=
 =?utf-8?B?R2k0T01NODA5L2xoWVNNT1RhVEhRY1lqTGxCUHZZYlU2T3ZiUi9wSGpmQUJX?=
 =?utf-8?B?TEd2SGJLM2lkVWtIMk92K2tRZVJYWThZM3RmSG9rUEJHa3lBWStJTmNRUUNr?=
 =?utf-8?B?ME0xdkZNMjBZbmJxemVYNU5lRVhjeGZyejQxSUduSEVmMW1mR3l6dEFENTdY?=
 =?utf-8?B?bjhXYWk2MmdmRVk2YVV1djJ1S0g2MEJlTWkyTllOTW8zSlU0V2FLRkpMODlv?=
 =?utf-8?B?Z3VvSExaR3E3VlB5c1MzR3RSeGJrYTBQdkNGWmJwUEo3eWIyZVBjZXNSTEcv?=
 =?utf-8?B?Wmo0cGhuRjI3QTNOcXZKRHVwT1NuRE0razl1ZmdmOUVuRmZLc2NSQ2RVbU5X?=
 =?utf-8?B?dVRiMzJkSEF1bWxHQ3d5TEZ0QVZON29BUzJDOXc2eDZEVGI5WXZ5ZFdPOGxQ?=
 =?utf-8?B?T24yUFI4ODc3MjlyQVcrVTdha3NCWGEzMXFKKzk5ek5KTUxsRENoOWZvRVpy?=
 =?utf-8?B?WEJxalVDc0NCRjVFVWVOZHVtaVJUTXMrZm9YR24zdXBNVEN6S2xqWFRzd0R2?=
 =?utf-8?B?V1lNL243WloyaHN0cWRReE1mQWJpTllOc0ptNHloMDcyUGtmMWk5aThPRlAx?=
 =?utf-8?Q?R0zUYoM5t0vWexjlVQhYGUzz4kI/f7IliGBWWtF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1BZQzF6dmpNNHNtRzlVRTIzbUtwMTNpM2ZNZXQxd212ZVR0N0FndWQ4SG5w?=
 =?utf-8?B?clJwR0Jac0tIUS85UEppSUg4UDV4SCsyWmJOdHpVY3N0bXpVb1V6Z1NrYkZh?=
 =?utf-8?B?U2FCaTArTXhXYlJlMnIwSk40THFOSEZTR1ovajJEbGRPZXdsSHBPd01pWG5I?=
 =?utf-8?B?R2JDam9CUXNDWi9PWndCOVNCOERCZGMwTDRyZnRXVElzODQxUTU3WEw0SDZr?=
 =?utf-8?B?UlhOOEZPcHRNak1CNGhJWGpSbzY5UXJaQnkrREdFWHo0dytIUkgxSEx6MHEv?=
 =?utf-8?B?d09zb0JrbDdFeHFLSDlJYmUxV0xwT2lSTGdXbjEza3NoaGNTVXZXUGFNNW9N?=
 =?utf-8?B?b05RNmxYQmlhekNVM0NONWx2ek9QcTJ0Yk9zR1E1eGpzRlJzUWlVNyszOW1X?=
 =?utf-8?B?SEZDbG9nOVVZT3JqTzNQT25hLzB3QWlyNjExTExjYlM4TXlieVBxQWF0bGZi?=
 =?utf-8?B?UE1vUnZCVlVvNmN3SVBYUm5qYUs5SVZFaEtlNE5FdGFPUkkyeWRrcGFpWkEv?=
 =?utf-8?B?Lzgwc1lGcHFITVpTZmNxU1RkNXZTTVFJNmxwclFBNmlQcDFuTCtzcytvcGJi?=
 =?utf-8?B?RjlTcXZuUXZVamFQY0xQS0xrR3RlYXF5UjBuRldRQWFVSkNZR0R5cEphckhJ?=
 =?utf-8?B?UFJ3elFJU2xGNFRqMWs0dmZNTHVib2pkVGlDUjZOQ2N6Z2RyS2FqRFhBb3lx?=
 =?utf-8?B?eGJwbDBYbm9OL3hzdFQvdnRsVi9lNUoyQnQrUnphYzlsRU5HOW9LZ2FCMVRL?=
 =?utf-8?B?ck5oaVB4blFlTmRxaG4xU0RkUHllRGErN1dYaXpJbTBpd2EvNkZuYXdnNnN5?=
 =?utf-8?B?WURZdGFMenEwaGQ1N2pNNkl4Ym52RFk5N1oxVmhlMTBES3hhVjFZejhpOXAy?=
 =?utf-8?B?aXZlTldsVC82TWFHMjFSMUVLZUNJdTZOYjJxbm9BK0ROVDlSVDNNRGFVNHRx?=
 =?utf-8?B?WnJScjFjcjdySy9vUks1V1RPQ0p5SkR6cU1BS1JwSzN4TkdCSzdCMG9VRzRj?=
 =?utf-8?B?ZkowQjcwSjh1LzdtQjQyTXpKU2NGM2ZOL01EL3JHSTd0eWc0cFFURmhGekln?=
 =?utf-8?B?amhVb0VzUTlnYVdrbnZSTGlrME9uWGlLcEx2WFEzdWd3cC8xYkROV215VENn?=
 =?utf-8?B?QmhUWmo3QTdZZjh5ejBNdWlPVmd2OWZGU1NEWFpRNURsVmxNRk5iV25NdjBi?=
 =?utf-8?B?bVVESk12b1RZZytWL2NZdmdHaUlsUzRVd1NQek15RlFxNEVMZ2F3VnlzV25l?=
 =?utf-8?B?eHVyRlBWNTNUcU16K2Z5dnhzTlgreVQxd2cxK2MvUTBhdUp3VWRZZG5TT0tF?=
 =?utf-8?B?YVZOZkF6UGptcVpYWXlsNnZJRHdINWFwKzJ1MzJRc2VPbDM1NnJrblFqOEti?=
 =?utf-8?B?Y3Y3S1RFbFpZUDM4YkRSTFZqdDJOWG90VDk5ZTN3R1dIY3JqOGh1eVh5WFl3?=
 =?utf-8?B?NDYxdFBNdVRFeWhFQnIyMloyY0ttaHAyMHRzMDRnYmx1TEIrSS8xUENac3hv?=
 =?utf-8?B?YmZPUGVuWlYvVU9GdHpGWmRLbVBCZHh5WVVkY204TlNIZzg0TVVabDVzMG1E?=
 =?utf-8?B?SEthTjExY1AvVy9raXhrS0oxVzlGNUxKVnhRd3UydFZQQUY3QjN2VVFwUVk3?=
 =?utf-8?B?bEt3QTZYVStnN0lCdHYvSzh6TzU4TnQ2dGMvS2FOcTloNUtJck85QzUwdnVO?=
 =?utf-8?B?bm1janhLL2tqeHJEaDBEeXB3SXFpdXRTeGVvWFVWQytERHpQTUtKeE5OMGhO?=
 =?utf-8?B?eXlzbzlyWVpBaXhQRUltck1LblVudFJHdVRMWkc5aFNvWkl6TjI5UWNDa29y?=
 =?utf-8?B?eWdSSlQ2K1NFRjNhdWpyeEpRVHJIU3ZTRi9xVFFkZEM2OFMxR1RncjE2U2tk?=
 =?utf-8?B?WmNBY2JTcXB2UnF6d2pOT0s0N0ZmaGM5eHVmbkV2bDFIdm51aEtIc2QzeTZh?=
 =?utf-8?B?YnhoUVEyZGlXZmxQUHNnUTdkYmJvUTRpUWxvMnozNVU0dUEyU0dZb0RxeXFn?=
 =?utf-8?B?dUhVU3B3Zm9wRjMzVlpaSDhodG5uMzJwTVB1dUFGWnJqLzEvelgwVEVMWUVP?=
 =?utf-8?B?QzVQNmc5NW5iU3hvVWJhVmorUzdXUllTTWk2S1J5OUhSaW5YTzQ0UmFwRVVw?=
 =?utf-8?B?RzNLNjdhdGVNYkQvUXhKRVp5akRlS3YvWFpJcGovd095dG5aNGhMVzFMS2dY?=
 =?utf-8?Q?TfutNA5Td0X/H735tYep6xc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aUysarj97w5OQ4arEP8U6qQznVlLSi/eCUcW80FncbVA3FYIGAdoBuBtaCL8xu4XbOKaoCN30+JzpdO42ayojWT+8znLEmKG+rqAHQl1hvHeTrDyUwesArO6p1P48BP8Y3Y1MZsPkVp95waJP70sLucRM2DZvOsoX71DFPoez/FAp/9AkA2qdWT7xim5iUAXemjcpWdk1v7S1K1BXpCfePRf/bZnCrQgsUeWQQ7DnAvCiIcqepQjD8VpKJjGU5ieJaD3pyNnWz4EKGStwvA3fpZXc1ujWzoSt0ajG2VT5qM3RFqqxcoi97IRCbnnQMqrjRCz5C+krpweQgIO1t6gv8CwjNT96wafVCHfD196qHMlzjw+o/o0MwXonl8gyUE3pvAdo26tWs8FTb7VE1uAE1YfII4Nfn7QKr+6Tl8cXf4X691ZmrM33BbjRdyxOiPznbRiH9tVkLx3oIONqKAai/U/GMkkRl5vSZEnKAIxeAmUkXKS/U25f7/KF7d0burdfnj2uhg4NEAPVBA2psy3tFX74MCmVFcFNMTJGulr/K4vAkOXFeW567BkGdeb9r6kFnn7XzkXwtv0AUsXw8GpFsNN8OhQnr8G+n/wjSeEyJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765aec34-aba9-4173-ef48-08dc9451dd39
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 13:30:50.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqN6j5jQG8YrTsYAr3Kpz8/e67mGi8MGZSLdXWKicsoRJzgHIH6CH+je1/BvdoxbsrSLIUYUdmEljRBOqAi+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_10,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240108
X-Proofpoint-ORIG-GUID: 7tLPjathAIDbR7H2lvtDkcl_ieH0nl83
X-Proofpoint-GUID: 7tLPjathAIDbR7H2lvtDkcl_ieH0nl83

On 24/06/2024 10:09, Antoine Tenart wrote:
> When upgrading to libbpf 1.3 we noticed a big performance hit while
> loading programs using CORE on non base-BTF symbols. This was tracked
> down to the new BTF sanity check logic. The issue is the base BTF
> definitions are checked first for the base BTF and then again for every
> module BTF.
> 
> Loading 5 dummy programs (using libbpf-rs) that are using CORE on a
> non-base BTF symbol on my system:
> - Before this fix: 3s.
> - With this fix: 0.1s.
> 
> Fix this by only checking the types starting at the BTF start id. This
> should ensure the base BTF is still checked as expected but only once
> (btf->start_id == 1 when creating the base BTF), and then only
> additional types are checked for each module BTF.
> 
> Fixes: 3903802bb99a ("libbpf: Add basic BTF sanity validation")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

This looks good to me.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..142060bbce0a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -598,7 +598,7 @@ static int btf_sanity_check(const struct btf *btf)
>  	__u32 i, n = btf__type_cnt(btf);
>  	int err;
>  
> -	for (i = 1; i < n; i++) {
> +	for (i = btf->start_id; i < n; i++) {
>  		t = btf_type_by_id(btf, i);
>  		err = btf_validate_type(btf, t, i);
>  		if (err)

