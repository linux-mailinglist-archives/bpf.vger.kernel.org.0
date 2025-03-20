Return-Path: <bpf+bounces-54490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC43A6AF3C
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE017B2ED5
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D92288E3;
	Thu, 20 Mar 2025 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NHTSaE+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hosn1rKI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215531E25F2;
	Thu, 20 Mar 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502905; cv=fail; b=QBpLA4CG/ovZxCYPDqwHihjXnq3O1/AI//5OtD5ekQU90jFmKWDrILG50dCywXcgihzlNvGNdUw6ycjZv//ZXzaJW0s+LgmXuc+er/c+Hv7qQgyNqaP5/eGUvaRcVN/evMRwGjhJhSnTDGnS3WkC+Wt3ZKSregyCoilB48Gn8Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502905; c=relaxed/simple;
	bh=W+JcKpMgYAvlGbumAAfq1ny/Nbp/rOLZNi/8h6squWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEkAWyrtlI43+YtSCQOk3jLznuvF6YX1i29XYOPU2JA1pp1nK5tEbFNHCrb091cF9TefIrxUR0T/P+0xKFqTXYT+uw/QISRk+FAsPVieS+q16Vks/fezV0Oad6Jrsidwv0exDaHDamwC8dHqB95thtTmTliM9VwWne3k3UnFyPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NHTSaE+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hosn1rKI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KJNGlv009674;
	Thu, 20 Mar 2025 20:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=srK0TJ2HYSUp3MG8bAJcx1QTinHJFRP/zKQyOLJ0+gs=; b=
	NHTSaE+npgHlXXqyB/hH1M8UMAjJZOLYWwrfxWb5WSs3VvFTa35sYl1GfEsWAqJ/
	uLdg6xKAcdCXgfMI62ma5zbtRCy2WGfNWabgdNOabcZs/54OpGjC1NNH4eO/lb9a
	qcdMk0RTZdl67lOsTOMJTVhfLZTTeAIvYluVYQ3Tej0Piu3FlZ/1VFlOsuN0IkxP
	qfWAtZrH5eZkdvMjo2QvPSGU17GqxRU5yCKyQGMSEQIrGc5t5Ne6IQhpcdRrwaNM
	XMzzkJXqQM5hPmIyqE9fVZuITe0KUhBkA7hZovEAZ9PDZ6RxOtXNSBz1Mx+qU71y
	2kkybtSrqKhEwJTi/HqLVg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8pyb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 20:34:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KJqZpr009632;
	Thu, 20 Mar 2025 20:34:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm3880c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 20:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7FfKUlZQmGJJZxaQ7iFjsjIUwdMn355JXJeo9ZN18PugYAmyt0cDC0oc++1A0zko6C/bwOXSIImu0sOBxBEsG/+t4NxXEtMacx7p1LzYkZckmhVOa0gDLS+SaJcRN3Cv/xE71IMjTOO4vj6vP8Wj6eANLfuSDPKNH8BOprWmU/0NwmPR9iRH1NR6UVRLkrvyHq8lXDbCRIev6uS9Gy75sFsDqCLc3wtUukVU9j9YBKRFXI57qj8fuVnKHFGHWY8/QnpyHgJX6ga4ReQvdXJ7I1b4h5rpK5EqVLpTklps1teuIsWt58XDcIKYZ7/nqpm4DS2e8+/kdKDgtA+y2C5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srK0TJ2HYSUp3MG8bAJcx1QTinHJFRP/zKQyOLJ0+gs=;
 b=plNqqcOhuY8ZKmrvvcWX+2FvK1XK3WaWE3iCDpCsObF9sVm9o6Iw8D3k8D8auC4wA9XgxJ2fIueq8aenQEbo/nV5yCBF5aq0ykAirEeaMYmp5F5mgqEyAKsadTKw0gjob1NrqtWcIYfs935J5Ged7ASjqqP0o2qcrBR1j+2eNz+bVrDOwV0RhdhB/TlWLTJvhndzbSxhU8oDkXIR1tsRyzDh16fltqH5CRYlZRvNN1iyvvp7b+HI3FuW60SSqIfO8/AX+KLTD9COcWvScHp2e/6XSqwD2GLZDYtaZiv0aQj4YThKxXMmaRLJIFe7cxK08cxpYpgwUX/CjxdWooYhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srK0TJ2HYSUp3MG8bAJcx1QTinHJFRP/zKQyOLJ0+gs=;
 b=hosn1rKIqYfIsngYhD7VI2tQSenqgxaVsNDi2yG3KOTxSSSK7ur7LkkUEmU38V8nvuQWNfItYAxOVfGKl8ti5icH2auruyBe+ZQtnKg2twR2L+FtQf/NAD8EYr3G4U5HgfOFSjAvzPuC1GJZmjUhOSAGZPX/VuygOPu6v3aC4CI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:34:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:34:51 +0000
Message-ID: <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
Date: Thu, 20 Mar 2025 20:34:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: efcaccfc-66b4-4dc2-f0be-08dd67eeaa5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djI2V0pINkJ5bTJpMzJPVTNOd1lzdXdmaS85YzJ4SUtLTFJiMDk5TFJqL1kz?=
 =?utf-8?B?N2ZtSUc4THBYY3FBanJrOVVCZTFLS1dSZkVyN1NtTTJJT2JhM3NkQkxCWTQ4?=
 =?utf-8?B?d2xRVjlKYjFYQkMwMmJJbHRGRTd3azVpbmhVSWRmZ1hiV2phL1dudEpIeTJS?=
 =?utf-8?B?enl4WWFDK3NSUTVNdHgrMDZRL3k3Z0FCRlBUMndiM2ZhTjBqbkZKZURNTGJt?=
 =?utf-8?B?RzgvRWNFWjlvTjhJTUpIQUZPTklraFR2aXpGWm4xUzl0RnMwZGhRUXVDclJ3?=
 =?utf-8?B?elhBczJ3dzViYlpPOXZkbmpqSTRjeEJHR0U0SVNWSHpYMVErZ1gySHFHeVRS?=
 =?utf-8?B?N0Q3YkZsUDloTUoxY3RTazd2Rk1VbDlVYXY5dndsQnZkQlE5RUtoVTd1d09N?=
 =?utf-8?B?dVBSb3Z1T3dKc3IzVzJycm9mNUFYY244L01VYnhaNDkva2ZqbDM4R2ZRM1hu?=
 =?utf-8?B?dWlOZjFxeUN6b1c1dU9Gak9DZjdYTDVxWG5LRmZiTXl0OXkyTnJ1ZlNVamx4?=
 =?utf-8?B?a1o5RGZyNkN5RFM1bVB3MjJBc0s5UXlZWFVFZHp0RzcxMVNFNDZFRDJnM0sz?=
 =?utf-8?B?dUY4ckVpUTlIZU1NaVBSZzBYSFUrYzRRU2tkZkNpZnAycm44Rk9CNlZpbVdE?=
 =?utf-8?B?cWdKVVcvVUpUa1lPMXY2TVhydVJ1Z2l5Y1czOFQ5VDBWNUEzdVVaenZpVkJR?=
 =?utf-8?B?SXp3WFJseEUzZ2Z1eFdOVVZ1eHZsN3RoUFYrRXQ5V2ZvTU5PME1MVkozV0E5?=
 =?utf-8?B?bmVaYVkybUZNZnZZNnU3YVo0Y2lFNkNMc3JwUEd0eUFqYXJ2cVNWTzY1YzV0?=
 =?utf-8?B?VTlrTEIxSGxESXQ5bGRvYWt4T1JDWmlPWDZvdFBDZzdsL1Vwa1BKWWNWK1k2?=
 =?utf-8?B?dzh4VE9wQW1VclQ0V1RXZFpUa2RDMWt3cldsTDB5bU5ySnJsTHRGdlVkenJS?=
 =?utf-8?B?Q29weDBseGlnVmN4VkUzWGJKbCtyUjBRWWYyOUxyZmdKblhvVnpIMWRNYUpW?=
 =?utf-8?B?S1MvSmZaSTdVcDdhVWY5TkpjUGdaQ1FpdVk1WTJVYUlVUXQ1WUp3alU3SERP?=
 =?utf-8?B?MUJKTStSQW1wci96UDE0aEMyOWFpSVYvM1JwS1lDK3JzekNYQWtwMWxCTTJw?=
 =?utf-8?B?WFRhVk9UaTR4ZHBLTVZuQkNxRVBDRjlJNUs5N2s2V0dsaDJiSmdhaFp2SStu?=
 =?utf-8?B?SlhQc2NCQk1QNmh3V21TNWNRWmhCMkZiWElVd3gzUG1uSkVxd2ZhQjhQQjhB?=
 =?utf-8?B?QUVkZXhHd1JPYXVyUHhOL3JCejNLQ0R4dit6TUJjN3plVDlwT3ZzZFVSWVM0?=
 =?utf-8?B?M2JBTXBzMWlGcm1JcjBGMUVSUU92MUFsSmo2QjhxZXR2V1UvcTQ5SmZLY05G?=
 =?utf-8?B?ZXhmQ2IyMEZmSnN1WUFJN1MzSkxPdlRrSnczL0kvQk9uL0c2U2pSZW1nT0FN?=
 =?utf-8?B?bEhWWWwvdmlhQ28rOGNMajhSVFNEL3BCV3ZTaXArUkRxUGw0alNaVmVLWTQ0?=
 =?utf-8?B?Sjc3MUdwVkUrTkR4UndQeHlwQmhVYzVOdjFKMm01Vk1RVkRzcm1uZ2RSVThs?=
 =?utf-8?B?UnBSaE1CY3hZUWZlbzRDWmRudzZrWU9KMURvcVgwaW5laFl5VDJIaHRMZFRu?=
 =?utf-8?B?TlhMekU5dENEWU5xWlRjVDlZNHhQSTRLR1BqcGp2MHdrY21uWTlLZGRHVUha?=
 =?utf-8?B?RDlpaTBLNXloZnFpWnJwZXl1NWd3V0RFWWc0SlEyMkwrS3RvMDQ5WGVCMmpG?=
 =?utf-8?B?Y3BCVXBiczd2TkorTjNWMGJ5RlN0OGp5Zk1ZWWdlRklzd2RhbzR3Z0kzQy9r?=
 =?utf-8?B?R3piM1c4UWdPdldweHBNVlFLRGI3UzhJa2dWUVYweFdMSW02VEFQVVBOL2s2?=
 =?utf-8?B?M0l3VExjZ1kwQmxaUFI2c1Z1dHJFaTFvM2lLRThoZGcyWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzJUcFNyeStTMlp2TnQxRjZ0VEdFRFZ3SDFXbkFTaldObjlDelVZTXNjVlg3?=
 =?utf-8?B?V2VYVUJubStWV3JPUXQ0OGhPUmlNVFhyZVJPa1VvQ1lTREtka3RzUjFydmxT?=
 =?utf-8?B?dGt0eUFPY1h0UjlhMHBjZDkzbC9wVWlwQ0NCY3FBQk5tMFBvU1AvT1J1Zzdq?=
 =?utf-8?B?K1hySU1HSTkwSlZFTXBORjJlZlp6Y2VMR0ZDMElRYTZvcW9ESzdZbnZseDBy?=
 =?utf-8?B?R21UZS9aSFM4Zlpkb3ZrOC8vVHFCTDRaZUNtRS9aM1gzV3YrS0xtKzZWWStP?=
 =?utf-8?B?bE5pK2VnTlhiUGZhNHljNUVOL0F6ajlDRDBZOVR3S2E3a09qTHhEcTU2a0sx?=
 =?utf-8?B?eStlU05ObTBjMjRIbnRaRU5kODRlTnZnbjdZUU95dXg5Zjl6YkV0ODVLOXVv?=
 =?utf-8?B?ajZDd0xvSitpYVp5S1ErZUNXdklCMDhYZldzTlc4NWNEN1pNQ2xuRzRscVZs?=
 =?utf-8?B?ZXRER2RseENJNTRldm9PSG9hWkNJMStnZzdqb0FsSnI3b3JGZFJyZjhFVFNY?=
 =?utf-8?B?a3dlajZVYW1yaldmQ2p4cWdEMjZicFdnN3g5VFlEc1ZaQzZndHdtaVB1TVNa?=
 =?utf-8?B?eHBvSk9xdUc4M0JYeTVTR3hXR09zbWFKY1hJNDdheHNqN1FycUpPSXpHZmFF?=
 =?utf-8?B?eHV4Vk9OOHhIakZmQmJROTQwdWs3SWRlS0pnMmVEY1d3MUVLVzIzdjVJcDlV?=
 =?utf-8?B?WVN0SFAyUFMwd01JWlhCaTZyVkdWWCtiVFZEaWsyOWRXeDUrMFh6LzFvVURY?=
 =?utf-8?B?VFFQV295WVlDbTZ5YTl2STRvWnFva0VndjYzaHBReHAzU3NPZHN2aGJoaFJQ?=
 =?utf-8?B?cVNGejRlcTcweTRyY3R6NU9GOC8yZldReWthdlhXRjZ0bjdNSXUrRHRMVHlq?=
 =?utf-8?B?VkhFSGRENnVLeDJCcXJMMXd5aHBrRTF1TVppRUVzNzhpOGZnRCtIbmwwa1hP?=
 =?utf-8?B?SjdOeDBQcGVrR0hmNStUQTFFMGdLRkc5UUpaUCszZENsUXhGRE03TlRCTTVt?=
 =?utf-8?B?NHA3L1U5Rzc3dHh0R3Q2UFVQV3JtTVpYV2FLaCsrZ3ZOc3FQdHRvUUxMSnlu?=
 =?utf-8?B?cnVSQ3NaS1RMa1ZZUDBrNHBVT09DaTh1b3hDWUFtaFV3UDJpZVAvVVRDbzRH?=
 =?utf-8?B?RXBJMmVEc0d1RWZGQ1AvVXgrb1FIdy9GV1ZzSDJHcXQvWVRXRWpjWndMS0Iw?=
 =?utf-8?B?d1NMTXFHNFlHZ09vaGhuQ3M2aVJJTWFRTk1JbG16Si9pbkJTWk1Pd2Y5b0J5?=
 =?utf-8?B?U0FFejI3Rm5jd1FLeUR5ZDVqd0Zwd1NkanNidUV5WVlLN3VJdUFWdU0xTEU3?=
 =?utf-8?B?cTdwVkxLYlNGeGQyM2w3TGQ1eUYwZXowdHI2T252cUhTYm1VUGs3ZTN6L1Ny?=
 =?utf-8?B?UDQ3cmdhY2NISnhmRXJCRkhiaEtldXZRWjI1NDQ4dm9jMFE5cVJReG9lMHpx?=
 =?utf-8?B?UGFCeUhXeTdWcEpRcUkyS0huTVdpdlNJMW5mZndEOHRyVTlqam1sVGRpc1A2?=
 =?utf-8?B?Q0JIN29sMlpnb1d3dG80cTRSNUV6TmNCR2d5c1U0S0VmOGFoZkNRaG9Rc3pT?=
 =?utf-8?B?SUNBVm1qUnRCYU03a2U3NDJtUDE4Qnl3MVppQVY4em5iRGEzTUlNSThlRTF1?=
 =?utf-8?B?MXNDMHFxOTloR2Rwc0RNcXNHUXIwcTVsWWlvT09pNFpMemVXVzNjcno3T05n?=
 =?utf-8?B?bGhUYi9zamxITlFmc041M0xxZmQ0Z09QWjhXVmt3a0Y2d0R2eWpYVkFzU3hv?=
 =?utf-8?B?OGR0aUdZRG4zNW1STjZtTERVNnpHTExoc0FMYXB0QU0xNldOWFgvemtwcTJE?=
 =?utf-8?B?MGRJdm5HQzJrK21ZVWViVkprUFlzVEtrd1k2SDhCTHJvbUtCd1YxUXV6Rk9z?=
 =?utf-8?B?NTA5Zmx1bmxteUxBOHcwQTI3eSt5bSsxYkVzWUVpWVdZTlZSYXZtSHAydWk0?=
 =?utf-8?B?U3Q1MndsRy9sVThTRUUyd0Q3WGwzMzhPYnFIQ0V0bTg4WTJGKzh6bDdsYXhU?=
 =?utf-8?B?TjJyUnN0c1VkYno4R0c3NWNnRmx0azBtVXVQcHR5bHV2enNCUC9aalJ4SnZh?=
 =?utf-8?B?aXB0SElGSXlMeHFrMlJHa3piMjZZZ0s0YnNPdGRBUkZLVzNkZUYwZFdsMC9n?=
 =?utf-8?B?MGhDRk0rcStxb3IzZERyZUI0dmN1Ymptd3FQNHUvcCtrUHZScWtId242WHA1?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QarpZopHqeZ2JW9WZW4kYzD5hyUAcuabdcjj0hFSGAMavBM7fyolUK9/MIibWbl/FznN60pTAiAIHEd1IQ4l4FaPTfabCVR8GG5Y1Ym+QsNt146Q4RETVNoFuXCymv0wY3tehPpPlS2F5lkkXnbEq+2Cb8F6vUZE1XcPu5mllmSkzF7DsrbCY9WosMZcluW/sjCOCdF0EtWwXBENd1LQ9FSgPDTqY2zFjKXcOzzSoc7lhMloc+OHW/f0rQnrM0CKIJxMaWbYLfNJ3hGb6Jz8jOOr390PMgrJR+E+mRv+6MwqYlbUvgNMh5X7MkLPcBKBxw0bXMvNy7zuAWTPPWc7aCzgO+gVGK9HijbVvdIPISHZ2pdFaURknM49eCQkmTItB3CHHQu168RvYRyR+aAPn+0TeEf84svOYJmtjWHj302/ZX7VGzvKv9M8d3PTR/w2WYTDgyahlwL299N9CIR7SOgYagwUfLEztKO4dTFgOKiiT4Z+BbC9JE7AxIwgUPXE1dZHIIblrtLn+SknTIKLcUZI8KW3Wn3v0tx+WP2d2BPDnzAJD8KWViEvrwFVsQj05EIy6T7Qs5wap+WQ1cqnrBstXKT+U7XKfXlcf9G15qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcaccfc-66b4-4dc2-f0be-08dd67eeaa5b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:34:51.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F68GtuvMn2q5n5l8GHWOPbMYVKBd3cxvTnSb9sf1wsw653C/NfoJJNZTFFlYECPGZ5Ux7OVff9nNM412lDbD6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200132
X-Proofpoint-ORIG-GUID: UKA9BX05X7OlgZEYg-S2BPUVAm7RfO6X
X-Proofpoint-GUID: UKA9BX05X7OlgZEYg-S2BPUVAm7RfO6X

On 20/03/2025 16:32, Ihor Solodrai wrote:
> On 2/28/25 11:46 AM, Ihor Solodrai wrote:
>> This patch series implements emitting appropriate BTF type tags for
>> argument and return types of kfuncs marked with KF_ARENA_* flags.
>>
>> For additional context see the description of BPF patch
>> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
>>
>> The feature depends on recent changes in libbpf [2].
>>
>> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
>> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
>>
>> v3->v4:
>> * Add a patch (#2) replacing compile-time libbpf version checks with
>> runtime checks for symbol availablility
>> * Add a patch (#3) bumping libbpf submodule commit to latest master
>> * Modify "btf_encoder: emit type tags for bpf_arena pointers"
>> (#2->#4) to not use compile time libbpf version checks
>>
>> v2->v3:
>> * Nits in patch #1
>>
>> v1->v2:
>> * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>> post-processing step is removed entirely, and kfuncs are tagged in
>> btf_encoder__add_func().
>> * Nits and renames in patch #2
>> * Add patch #4 editing man pages
>>
>> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
>> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/
>>
>> Ihor Solodrai (6):
>> btf_encoder: refactor btf_encoder__tag_kfuncs()
>> btf_encoder: use __weak declarations of version-dependent libbpf API
>> pahole: sync with libbpf mainline
>> btf_encoder: emit type tags for bpf_arena pointers
>> pahole: introduce --btf_feature=attributes
>> man-pages: describe attributes and remove reproducible_build
> 
> Hi Alan, Arnaldo.
> 
> This series hasn't received any comments in a while.
> Do you plan to review/land this?
>

Yep, thanks for the reminder; I hit a wall last time I looked a this
when testing with a shared library libbpf versus embedded but I can get
around that now so I should have the testing done for both modes tomorrow.

Alan

> Thanks.
> 
>>
>> btf_encoder.c | 328 ++++++++++++++++++++++-----------------------
>> dwarves.h | 13 +-
>> lib/bpf | 2 +-
>> man-pages/pahole.1 | 7 +-
>> pahole.c | 11 +-
>> 5 files changed, 188 insertions(+), 173 deletions(-)
>>


