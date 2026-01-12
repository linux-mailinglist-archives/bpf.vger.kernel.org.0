Return-Path: <bpf+bounces-78556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1124D133F8
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF058303E40B
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AA12836B0;
	Mon, 12 Jan 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V7Vdb5Cf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6726ED3C;
	Mon, 12 Jan 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228641; cv=fail; b=ElGP9MjhvasimKV3j6FcT+NgRMNQUMCj8bYNxY3OTQb2pzIFHWx71qDcGumf2BEaDo6eIUU/5hxjD+mDrVJZgZLcKJ91CxYPGKFeA4lJB7J3nY+3OTKek4LjM157eav2JJH4/gyuYAMadzfZtGOw1mjWAlFCzPHD4sZLJclk//A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228641; c=relaxed/simple;
	bh=WHkhuoZjUUYuRSpoKqxHGgP4M8sbIkL/xRVe4L5WUog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G56wiIsNQ3lzgwOvi/BK/2EXZgwF9OVxT5hbPeMSh1cKxm7ViIZHuM5IesaG9ncT2/QXeHHawchjz0Ap5TS8ut4XnclpTnJGd56W6cUGlShLHKJUG5HRi+4bSy1wIWnf4vgyFF1ot0ZhGxrS92L1wK2lXw1Aos++PxvCODW3Tx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V7Vdb5Cf; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C7LntO2887736;
	Mon, 12 Jan 2026 06:36:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=K6j1zOoD/nuFEnfyPLBjrA+c3yjXLvCGe7cws4XKYCA=; b=V7Vdb5Cf2oN6
	wm4tON2vQySperwc0twYrygx/EUfbNdeboMy5seCG4BycEl+ITo9ACNUnl1ASiCs
	eTiHHCBfLKUcS/j9kWPMbh4LkxZGerhWyvd6YQ2EB5hnfdXQcxOQrvhA6Btb4g/R
	fSfsQnsf9fg3G1EqftPkMDAerYiQbDlRpjqvEncWoGe9t6Mi77zoplIKtE0C5csl
	RaBabVWJGFxaG/AppDkbn0wRj6Hd39PGaF9mSVOeLf8KlbmPznpgJ4XCF6SoMltL
	egN5F4XqxfAyC+BBLe+YJ/IlEk9vG/MY6lMe5P1mj8zHOuD2Rj+oadNjOCGxn73G
	V676KOpQqA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bmvghj78c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 06:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0y4ccl4Gso59QDRtWqgkIWt83VyRSVARJjfMGO7nemwFtGbaA4CYxnc+zb8kj4DRjw6MojcVSSsCZq+Y2qVPX1Nna0QBON9y61WDij31dhvxi1m7Q25Rn3k601BeL0pPAhuj+mFKhF3I5FgNnfuGmr2OYnDSxVgWLa7KISRVaILo5eS9deOm5P6Lz6b9uXTBMxJmv8Pt36cGI7u44QIhoR+4n0HUHy1KeB3+R01eyMK28zZAQI5OArbc0KaNZCq8vMzcKdsl9CFWTN/DhS6APEx/LBiqAm+OO/GFvQ6ELggz30gZBodEhEA3LBp9G9QBJS+AnzYIBvilaINqFdzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6j1zOoD/nuFEnfyPLBjrA+c3yjXLvCGe7cws4XKYCA=;
 b=Z4C57mNs3WAyOYfgAhcwWpyLkyNEpTUfXCb5Fh7Bqj10ja6R7CHMUEvLZUiEWiYpmCmHMuxZ9lVtKbtj9iS2BkBXGoSYjfK9g8KQvu0ZuY341KqzDGREoyYb+oz9YxboGK5t3T8BDnWY+PI8GkFKmgzvQe277VE2x34ZsuR6nBz/9aObmK/tYRjfQehfcvjs1XWELzSZNeKKP0coR27+pdjK9ED7esTyxZj1ZK77ZyVaE+l8AOpFiQzTysa7HgTRUnA/9YITFW0JrmWvTaXl1sWcAKdh8e0mKdR2Al2ePK0uIz04BewmoiDdJSS+xONTFF5u6KT09nSmYZGGDZBpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV8PR15MB6685.namprd15.prod.outlook.com (2603:10b6:408:259::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:36:36 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:36:36 +0000
Message-ID: <a4b0be3f-bb6f-42d7-9176-a2bc0dcbd3a8@meta.com>
Date: Mon, 12 Jan 2026 09:36:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>, Harry Yoo <harry.yoo@oracle.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com,
        Petr Tesarik <ptesarik@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20251024142927.780367-1-clm@meta.com>
 <28e6827e-f689-45d9-b2b5-804a8aafad2e@suse.cz>
 <9a00f5c2-7c9b-44c3-a2ac-357f46f25095@meta.com>
 <01cf95d7-4e38-43c6-80ef-c990f66f1e26@suse.cz>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <01cf95d7-4e38-43c6-80ef-c990f66f1e26@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:208:32e::26) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV8PR15MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a218747-ef81-4cc2-c65a-08de51e7fd44
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJEcG9VTE1jUjNDV3lhVlpGZ3hVTS84T0Z5a1lCaEI3a0ZhUkhEN3VFN0NM?=
 =?utf-8?B?VlJmQ3A1a2s3eUx2NityU3ZJTXBiV2pWNkIyczlRWE9PdDNaY29lOXRkRmhi?=
 =?utf-8?B?L0hhbUozek9Ob3RCK29hMk4zdzRzSm1HYVlhTSsyZmZkQTVmd3JXSmg4UUxt?=
 =?utf-8?B?RlZRSXg2QnE5Q1c2azY5c2NxZmJMekdtTGlUM3JsUVIwYjhoRFdRQTdKWDJO?=
 =?utf-8?B?Q05zLzZYZVI3dzRSVkFjLzJTSVVpYVAyS0JNU1N5RStiUE5GQzJZV2ZnRUg5?=
 =?utf-8?B?Z1VWV0Z1ZmludFEzbWdKcGpqUXNBVTZyNlRPL0kxWFdPbno0b3N3cjYvenpa?=
 =?utf-8?B?TFJlVXYvK2M5d1ZKdDgrdjE5TFJOQ0FDa2Z6bW1ZWDRWWm11UFpabTNzQnpr?=
 =?utf-8?B?MElkWjgvbmkwOXFWSjhTNzZyUXdBVjc5MytqYUhIM2pLa2hRQURwdXBNTkda?=
 =?utf-8?B?bTlhL2xLaVdHSFRiNjY2WmlEZGNGbXlXcnJWREd3VC96cUJNY2g0TVZiWDhE?=
 =?utf-8?B?V3IxOGNtdmpzaEdTMm56Q21SSXJDakFKTlRWcEdMQmtGZGZ2bEZNZ2lleGRC?=
 =?utf-8?B?cnR6QktoUjNiYlJJWEJPeUpYeUZncVU3UUhOTlRDMHVXUGd0NHBKSkg2WFhN?=
 =?utf-8?B?ajBnV2tTZE4yRWQ2MXlBOUVUMWIvYThxL014d0YrWHNwNTlSOUdRTEtoWktn?=
 =?utf-8?B?RGpWZmpRdFR5L3pURDREdk9EQy90SDVsb1RVVDQvalhUKzRaK0QwMGFFcHB4?=
 =?utf-8?B?QWtwbE1JNkVHVWtudFE5THBSYWw0MHhlRC93U2hENDFObWdtVlBQWEVDNVFV?=
 =?utf-8?B?d1UyRG9Zdm5odHpCZithMFEzTmpud2F2OEtwUjU3NXVoRmI5MWVLT3llRS9u?=
 =?utf-8?B?WUhGNFZlME83bDNnWDFlWEVaNWE3R2xJSThUUTNMSkJxa0NhbmQ2QnZNT3lQ?=
 =?utf-8?B?ak1CLzZRME05SkltU1NMWktySHNoSkJobVA1QXJkQW91MkFZZUczRXlCTXVh?=
 =?utf-8?B?cTFRcTZIRUhXRzFlSTM2ZjVYZDMzcGYzbWJkNlI3OXdlcGVwVk94YXJ6eGNw?=
 =?utf-8?B?aWxHQTR6dmNKbGF6VWREbEZLZk5SWVFZZ1lOSWV0Yk0rTEVMdXJpdlV2SzJz?=
 =?utf-8?B?R1lCY0gyRHRGaytESGJrWTV0dGFDbTk0RU00bG13L043VzVxRmUzajZYM29u?=
 =?utf-8?B?Y3lXNHcvaGh4VXVsRk9PSU4wYWxuRlVnd0tWaDhlc2orZWd2dFNSbWJYemlC?=
 =?utf-8?B?UXhieEtTSUtzVXFuZUcvVHBJZk82WWhFaGx2bW94YzR2RGxhblhWdjIvUlRG?=
 =?utf-8?B?QzJpUFExMFlxZHJzMmVYRUNlVUR0V0dMNGZXODdLTkM0alF4d1Urblh1MUt2?=
 =?utf-8?B?MlViOHJIZzZVNVJhQkl1OEl0c0lOMnJCNVpDd1NPRFFCWXVIN3U3Vk40bGVy?=
 =?utf-8?B?T3gwTy9oM255ZUQySEwyTFBUZW1scUVHQ1FqRjBPVUxxY3MxR3ljZzdCWU1z?=
 =?utf-8?B?d3JOM1owUTZ3VmJMZzZXVEMxREd1a2ZmQnhpY3Y3a2hFWXJyWnNIQmVvSTNK?=
 =?utf-8?B?TDErRGtBMG9vNEdreWVJOWRPdDZoYlk5UlZnS05aeWVkYnh0UDJmQXYrNXhM?=
 =?utf-8?B?QU9ta3RIdjM4SlovQm5ZRHlNUFVHZm1peVNIL0xsMkNIVDZibmJvUGRsR0Jo?=
 =?utf-8?B?UnpGd2lnTm1xZHpRZnpuVWVEWkt5QzRJS0pQc2hXVzJNU2o2UnNQSlNvVFE5?=
 =?utf-8?B?eHNtTkc0eFpkL01ubWNZTDFwSG9ucmF0M01tM1YwYkdPRHRabENhbituSFQz?=
 =?utf-8?B?Yy8ycUFmRjJIdHoydnVVY3NyVWZzd3ZUMFlubHlrSFRvNWhIbGRPdXhVWkVv?=
 =?utf-8?B?QTdWY1FZM0VOUDNIUTNFbTZ3T3B5MmY0blhnRzZ0b1JuQVorL3V2SjN5eW9H?=
 =?utf-8?B?bjRCMmx2V0MxVlhCUUE4SW94eW1aR2tjODRxOENvWTc3WU5NMXRWS3dZVzh5?=
 =?utf-8?B?SDZYOEdZOWdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG42Q21JUnZHVXE4N295TmFieEMvRDl5d1FUMWl0alhKeWljN3oycndObTVO?=
 =?utf-8?B?a25QcjRZZjAyQVA3cExVaCtWMjRITStrZDhmUGZVY1MwNksxMTBCK3V1Z1E0?=
 =?utf-8?B?c0F4azFnZS9rY0gxQkhpWWo5dWM0bEZGb2FmaUV5NW9aUjAvQzRzZ29TUE1K?=
 =?utf-8?B?cCsvbWc5OWJnbHJCT3lYbCtLcjNteDUra2U1QmNITUZ2Nnh5Q28zeWw4UW1W?=
 =?utf-8?B?alVxYVJFNms1WVFmZUNmS1hLZFF5aVFhMkI1QWZpSVU3YmJpZERuQm8vMlhs?=
 =?utf-8?B?NkNwUCtkaFhYamtJSHI5N25YR2hacmlyZ3A4T0pqOE5VeGc2M3lzczFrZ3ky?=
 =?utf-8?B?SDBTZTA4T25WRElabmRRMytta2tKY2tOV3IwaWx2ZTlRTklZVHpob2xLZVlw?=
 =?utf-8?B?YUhIbVNCV1liY0JLRFkwYTB0NXpVWFg5cjAxLzFoRmVoNmxQZHc5MWdoU0hX?=
 =?utf-8?B?U0JTTmQ1RTRFUm1iRE9TR2kzYWNLbmdvMzg4L01VNDA5L3U1QnlWQTh6STdh?=
 =?utf-8?B?TG02dkxrenNnQVRjYW5SamdQZG5xRDdwOHlESit5SEFKdC9wNkVQMkNsQjFE?=
 =?utf-8?B?Wm9uakUyVHBLSDNXZENDcGJkaXVPa1F6akVxM0xXRWNPZU8xVDdDeGRUY0w1?=
 =?utf-8?B?bXZMVXZpc05yaDJtZ2FtUHIxblovL1dEbTVsUUpsWlU2QzFiNDZsOUEwVzZ4?=
 =?utf-8?B?bk5zM0JxdnRwYWVUa1BpWStSU3kvMXZwNDZHYmtGand3NGJ1cjFucXp4YldL?=
 =?utf-8?B?SktuK1FIYmdWczE1Z0cyMDJqME1vUkduUFpqTnd3NjNGbDc1VTRzdGt6MXVE?=
 =?utf-8?B?cktodkZyOE0ydzZmWDg4VU9WQkwvRGkyZjZ5K2h4RGpUWU9NbjNvTFU1MGd3?=
 =?utf-8?B?UzdMcUlqK0V6T2pyV3h6Y0E4ZUM1Ny9QWExvZWljVVBjbFozYTFMQkVPWnoy?=
 =?utf-8?B?VTA3MFBBRzRGa2dJSW94dkluTG5La3k4NEtSYVBPUHlXakcraTNleGQ4VVFR?=
 =?utf-8?B?VjZGZGN0bDBBOWpOWGNWZDRIODVML285UkFRcnIrK1pRRm1Rc0FpbzFnQll6?=
 =?utf-8?B?UTgwR0dsUlhwM3liYTRtSkZubDBZOVBkL2lJSGRueDhvM2twbXhVemxCTlBO?=
 =?utf-8?B?TlZVcy9haXNjQm5xTDJYNUdVUTVGWlVuRFM4bzU4VUVQdTVXSlJHeE9aT0JH?=
 =?utf-8?B?ajFHSTEyZk1QYSthS3E0THhPdXl4bnRSQ1IycjM4SmxXUFV6RmVYKy9JVTh4?=
 =?utf-8?B?UlZMNVVUVndhK3FvaSt2cjJqeW5ndW52c2h1c0pDZ3Vmek9jVm12VXFLZDJz?=
 =?utf-8?B?U045NXpFaFRtRTBvajF2NHE4SkYzd2F1NnMzUTZObXlhcUc5MEZNTFdSaGJk?=
 =?utf-8?B?czBhZkdXeHFzNHBXb1V6aUxXU0RBS2tEdXdLd2M0dGsvTWZ5amdzcFhyYlhU?=
 =?utf-8?B?TldKZjI3eWpEYmdIVHh0azYrUmoxQ3NiekNLOVFCcVNiV2ZBSG1LeEpNWVNO?=
 =?utf-8?B?UEZkUHM2Uks4ekowVWZYNzM1WU5hWHVqY3EyUjludmlJYm9nTlFZT2tReVow?=
 =?utf-8?B?NVMrbWRkVWc3a2o5WTEzaFlJQWtrUlR6cDFOSWhPci9mVmFqZW5qcGdYVDdV?=
 =?utf-8?B?ZUlnSk5XV0ViekNpM0xrbkNXOG1DZHM5OGl1QlV3cDhzbTRiRXdXbkF5c3Vk?=
 =?utf-8?B?TUEvUW5yV05yM3lwR0Y2QnkwSHFSUGM4ZUprWnhpSFMzakdGbnMvZnN3WWpa?=
 =?utf-8?B?bG5xb3JsaTlZSFlncWhaMVBwaDI5WldTODd0SXJnelJQRkkyU0FwNDk1QUFO?=
 =?utf-8?B?R1pYTzN0QkJMaFJkcHVZQVNuWjdnd1h2ZnVpcVdXTEJ3blRaRnlYNWE0akY0?=
 =?utf-8?B?VEtvbTdsTzZiRmpxY2EzNTA4cGFzTXRUT2o2cFFuaGRsMTlUTldyWG92Tnht?=
 =?utf-8?B?QjRQSk1VenVrczlrdkhsekFBTFVtTmNWQ1FNUUliTW9jSzZsZHUvN1RqQWo0?=
 =?utf-8?B?ZWF4Y0pkK1VuMC9XNkhSZ3hGd05SR3YzZk5pRmh1ZFpoVFc0MXBWV0xJVmov?=
 =?utf-8?B?Z3ptQUpuWE12bWloQmRLLzI2NG53RDYxV21RallnYXZIdmw4M2FwblNFUlZt?=
 =?utf-8?B?N1M0ZW1QOXlIK2lHbkdzQm1PMmhDNWJlVlBabDQzSjc2L29HMlRBcDJlb2Qz?=
 =?utf-8?B?d3VRb0JqbTJHMy9NZFZZelIwKzhiaitCcVFORUhhd3U2UWFEMDhpUTRWRy8z?=
 =?utf-8?B?U3E4aUpQM2ZJdDBRV3hhTWtpeDlOY25hWlF6cXlORWFIZk5pdmJkUXRSbXhN?=
 =?utf-8?Q?YRJHS6TOzQLH/9ZY8x?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a218747-ef81-4cc2-c65a-08de51e7fd44
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:36:36.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92/JWhzUMYhoJPOU9FhYdTl3LO5B7t1rWu1dIFzGwY8Zwq4mIkFLEzlEJTqBxZWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6685
X-Proofpoint-GUID: x8P60_g23T6WH0_VVkdEgcd_LEuEeKCc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExOCBTYWx0ZWRfX3EPCS0R3Jxcp
 VpmH+H79FkvNGKzs5t/D0qjIntBoX98t6Z0gIAl6Ec3b7/IJdRVsJW3C8gzWxaaONbiVqG6QKt1
 4MIE4ZRkmGP4I06BHU0VskKVPFm110MCUwZz3+jgsy6O38N9oBRy/fci4oPoWBDTol+OPSwRQKk
 BLhIlvdG/a9R4RvpIXvTyehnuHdZlzENMOADCuwQwRVbA1vsvf53DQYXmnBAjY2E1OOlEPGflvL
 NWUpKWTvjrUuBLXNJWsFbRd+uvvAzLzM4zfEaM5TButvRw5Kq7QLcvItjYGmvRdXzxNvyJLXE0H
 lqOhsTZLPsU+jNH/tsJxVKN36LX2+0atPw5UEJYc4kBK3I6gDsDPf2BeIdR0Xv4EziRojVeFXDo
 flVPqayAGnz3oZCSZi0iN4LNmNajiamhEg/nL8FMnHxBCc4FjCwlUeLY09alGFUN6eKFoEdWkPq
 K/bQrbZvEFjK9yQFn4A==
X-Proofpoint-ORIG-GUID: x8P60_g23T6WH0_VVkdEgcd_LEuEeKCc
X-Authority-Analysis: v=2.4 cv=Va/6/Vp9 c=1 sm=1 tr=0 ts=696506f6 cx=c_pps
 a=p2N+vRIgjjfURKXzpqLMRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=5_0c9pttrcqhkZeFVeIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01

On 1/10/26 10:41 AM, Vlastimil Babka wrote:
> On 1/10/26 14:20, Chris Mason wrote:
>> On 1/9/26 3:16 AM, Vlastimil Babka wrote:
>>> On 10/24/25 16:29, Chris Mason wrote:
>>>> On Thu, 23 Oct 2025 15:52:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> [ ... ]
>>
>>> By the way, there was another bug in this patch, causing a severe memory
>>> leak, which the AI unfortunately didn't flag. Petr reported it during
>>> performance testing and it took me more than a day to find it. Oh well :)
>>>
>>> Wonder if things got better since then perhaps, and your or Roman's tools
>>> would find it today? :)
>>
>> Yes and no.  It didn't find the leak until I changed the prompt to say:
>> "there is a leak, find it".  I'll see if I can improve things...
> 
> Thanks. Hmm even if it has to be done like this, it could be a substantial
> time saver vs finding the leak myself.

Finding the missing break on the first pass was tricky because claude
consistently focused on concerns about potential NULL pointers and
mostly ignored the loop flow control changes.

I think I've fixed things by expanding the loop analysis and also
forcing it to make a more fine grained list of changes to analyze before
it jumps into the review.

It caught the missing break 5 out of 6 times in a loop, so maybe?
That's probably the best I can get right now for a generic review, but
claude will almost always be more reliable with extra directions like
"there is a leak, find it" on top of the review prompt.

I've pushed out two new commits to:
https://github.com/masoncl/review-prompts

9a44c271 CS-001.md: pay more attention to loop control flow and memory
allocations
7fad3996 review-core.md: make change categories more fine grained

Thanks for flagging this, I think/hope it'll handle complex changes more
effectively now across the board.

-chris


