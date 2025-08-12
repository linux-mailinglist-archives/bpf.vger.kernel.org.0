Return-Path: <bpf+bounces-65433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF34B22B77
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551ED1A257D5
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9CF28C2BC;
	Tue, 12 Aug 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Isv1v6XH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBDp7Z1T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A12DC34B
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011540; cv=fail; b=qDXmsVOEJDYT1AbEOMbuheHYGC3ENcTKvTy9z9oorf+5/z2TGRbtq/9tqzA4TEvkt65QQYB4uofODpQ51h/nDa7Ok45AD4Zhxom5t/sdECgoWrYhbIPv8+M3VtSnlemtOetsAMb0fFR19hZGQ6GkLmtyL04lz0pRVg4DMmSBWDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011540; c=relaxed/simple;
	bh=RhCxzNai0D5aWtz8C0qmTVY+Ah8HvkMfSUKpwO2AMWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RSLs80xqejdc3CMUyprLYG91sP5qXIB4WWtaQMTNYqHa4o9DJB7bi8Dju4IN4grTR+9Dz6CE2RFH9FO5vDTgHZCOlNV54/Rc65cLmr7R8k0NwrOy9Dn9xoaDWhDwZS43JnwuUc4BNZ0EmxouACKlHBieo1Oz5SFCGNJnLjdy08g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Isv1v6XH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBDp7Z1T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC03g015993;
	Tue, 12 Aug 2025 15:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cZyV7TjPv8lv/tJ+aw6OlCZ763B+e/hTyb6VUVwnkcA=; b=
	Isv1v6XHia/aJKB+jE/Z0BCG6vX372ObcaXFltL3LfFxQNSS2HfAWwmlgz1d4nRP
	OTfdbPHLvg+O+R3DNl+M2yQ5QucJ5ZUiIDYOfD9Ak3IywCzoaBRmZgMUAjyKv/VX
	DXfTAO/sEfPmxXSshUeaq5RZDtGc+TkazLmWaxLE/nyqrTyCbzDl4E2vPpABjCHw
	6HiRqPKImL2X5b4o/RN3XaZ7nMwaAPoWD/k4nV68/iqU/wGgHyYkTxNp8iDfJudn
	AMDNy5lFjc2QVnU7xRXWJyP+lfavZ8QGEc01Y9VBs9bLJjqcRWvSjxRUnibqyd2o
	dc4RavaMvzfrBd32Y+yyeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf50s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:11:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDZl1T006535;
	Tue, 12 Aug 2025 15:11:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs9vvgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8uIL2rwx2P2RJ7++o3mim/rTdf0MyPYth1Vvrm4cbHXVRLdMsjL/HtlLMi8Szxj7+u6jU6A64Pt0a6r91lRRFKwiCdvGcJl0+LGhzN/4XQMz2Ezg5YuKNhNj4Sijv7ADRPPch3L0zr9know/X3m8wf29j1/pLwCk63M3Mn47y6rWboPn8SKJYnZEKSp2/RIGgBU6V8BtVW8hI+UVrjibXss+jQqZ+h49MF39BAkVRF9Rf7f0N7/21+HQ0A+BsG7ir+y3ibnI/F+MBSPCh9qdypPxIrIJ3jCRDoQt2xpVI6W87DBIGQ5fwfFg/0qEg4YxC2JefUNTB5GSJVNgNv73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZyV7TjPv8lv/tJ+aw6OlCZ763B+e/hTyb6VUVwnkcA=;
 b=hFY+9I4P8eOaKNbGu9HEQqS1ecLgw/ivx5AtcdRJiUED6ZuvkP1eL3AAfYZICmlq5QzdUZCnqPr8EJLPff12R/H5FjyGe3h4AS7I2gcdPM5wxvswGqnmhikW/TWrVQchYrkhnzPG/B/9qNUqx/0Ao0ygIhIWpvhXs/uXU+QigC6rlcraIiQots6muRY5i/oDqhXVp3lXIIgBFwKhGhqgO0MPlDxBk11ahCgkvnoB5JtLFt4zHG+Dr2Yg2Zu3MWGQkgY8hVubq/7FdrZodt2JMmFHQqJDpx1k48iVv5B6au37rLUcR3ZZUqusObmgKyx06PTwlIyxpyHZrkGJ7sb+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZyV7TjPv8lv/tJ+aw6OlCZ763B+e/hTyb6VUVwnkcA=;
 b=vBDp7Z1Tm90m6317TdqYIvIzH60wtTMoOyKiWlH8lF6s1pN1o9NIkkDg1DAVxCbwZldvbkD8xWfy6kL53UjNtabDynwWMHXJgYwBvLmyVSnd/TLN1xXOIfkbtwNZZR0H+RElx3PppLSpKQeE2TTyaro3FbidoUEBqcsRAnX0q7s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 15:11:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 15:11:51 +0000
Date: Wed, 13 Aug 2025 00:11:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aJtZrgcylnWgfR9r@hyeyoo>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com>
 <aH-ztTONTcgjU7xl@hyeyoo>
 <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0078.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 252849f9-a518-4b87-996b-08ddd9b290c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S256VVExL28zQ0VsbjZBRlo0TXBwVGhBNlZJbVFMRkpENDU4ZnYvVEZMazBr?=
 =?utf-8?B?ZlNuaHNORmlhRXJHM3hyeVhJcjkrVzJCWHV2QUc2UmxCZmtqUUVhODJaUzVp?=
 =?utf-8?B?YlFNQ0J2VGROeWw5RFVYUmIvcHkvOXNnYTQzZGZEUHhyZWdMbzZlcER5d1dV?=
 =?utf-8?B?YnZnOXhGcFhtV2x3d3RBRFpwR0NlMWZ5RG04bnBsY0lYR0dKc3plbU16MWho?=
 =?utf-8?B?WDZVc1hja2Y1c0tvbk5vdTh2aExJMG5XVmcxcWZMRGNWS0EvSVo1RXhvUjRG?=
 =?utf-8?B?NjN4QjRmcEtNTFBaNG5XZEJLMXdma2Urazh2Z0kvNXF6TUMyR085UGdUdW9G?=
 =?utf-8?B?ZjNBN2NnK3h6U25sUjNvNFkzNjZzUlhQTGVWZUU2alF4YzB0SGJwS29pbE9z?=
 =?utf-8?B?Q1JJQ1E1SXBmVlN1Vmhuek5GMFRFOVROa1FSSlIwVUdjcWtOdnVPVTdJVmZM?=
 =?utf-8?B?Y1UxZ096UGxVc0R1SkNGaXJtOVRDNk9ZSmtBR25OVVA5akJjQUpROUpOYW1Y?=
 =?utf-8?B?aUNTdFVuRE56dlg4Tk1kSjhXWVdBUGFCbHBKNnoxVWRTM2dpUW1BaXlpMFJu?=
 =?utf-8?B?RVBFM0c2YjRFYTIyZVBSV3J6NThzUjkzd0RpcXBoNFJUNmc3cHdnQ1JiVndq?=
 =?utf-8?B?OEtDUnU3Tng4VDE2eERtSEh5aXpjQldFb3loWnVJdDYxY1dxYkhKanJvWVl5?=
 =?utf-8?B?M2F0UWRQdld2dm5WcC9md25YY0VMMjB4K1FScmpIMEpET2lPTi9TbCs1dTBW?=
 =?utf-8?B?N21KcnM4enFTTXY1RlN6UWVFZjc4a0hyaXQwajM5YVpybVVJbEJiL0N6MStr?=
 =?utf-8?B?cVJ4NG1KV1ozWEFIamk5a3lJcm1sSGlwUXdXQmp2c0NqZmsxN2hUREdCOXpU?=
 =?utf-8?B?eXVzTys3UnJSaUkxcHpJMFV1akpoaURVanpUNUtPRWRGdU9RYWV3RkNMY0c0?=
 =?utf-8?B?Sml5MzRGU25QQittdmdDajNYeEpNak0xRFNJRWovUGxXaWovKzZiQ3YwYWJI?=
 =?utf-8?B?SVpRRXhGNjgxT0J0M0srYnFIZEVIa0QzcjFaSXlCeEtXcVVpR1RNOVRUNldo?=
 =?utf-8?B?dTJ3M1BWZWdsbXhYdFdZczNXLytsendFZC83LzNNdVRuMFI2V3d1K0haamw3?=
 =?utf-8?B?WitXbDhmWG5kU3F5M0cxZGdqMnk2NHZiQk9oOGs1VGNmSEFmd0NWazd5MFM2?=
 =?utf-8?B?TFZZNUZYL1ljWXcxMlJydlRLajNQbGl6eTVLTXlHcHZNb0VlSDUyM29vcjcz?=
 =?utf-8?B?b2k2RmU0bUdrNlJJck1MaGd4aEF4OEllcFAzMXdEMDdtZ2QyWDJkOThFSnZP?=
 =?utf-8?B?cXM1VkFaemxoRGZiSUNvZlZtbVpZUm1ndTJHd1E5YXU2QUQzNkhscmRGTFdw?=
 =?utf-8?B?L2VXUHpKWnZvQ2dxeFdHTHl1aDMyZHZ3d3hheE1Ma2JjN3BtcmhGZW1DTmYv?=
 =?utf-8?B?ZGNQVUx1a2I3ZVQyOXV4UXVCSkFIb25TVGdUOE1EcWpHdXIrMEE3OUdKbXkv?=
 =?utf-8?B?cnNzZWQ0cXB1eWtTd1pWaG5RT2wrbFBSYUdhZU9wdUJXVkZyemowMExZc2VF?=
 =?utf-8?B?MEdKK2EraDZRUXZvNW9RcjJuVklUM0U2cmcyRjB3NTVEZkM3TFB6SE1oQlI2?=
 =?utf-8?B?cTJRZzBhK3AzK2ZHR1BQelJ0MnlPWlVmK29jUXJkdTVtSzdGdjhXQm81Tmd2?=
 =?utf-8?B?R1FMMGZ5aGx3WVU0QXpVUGtpSXpKMnhUekQ3ZnV4ZjZNU1Rqd2tsVjB4L25R?=
 =?utf-8?B?VWlLTEQ5dm5oN29vNW8wcnh5OE1YMG83V3FJd2N1OC9DdFIyNzJWbXQzVFVo?=
 =?utf-8?B?MGQ3WWFZWE9pSDJkUlRlMjVwSDZ4MmQ1WWdZYjdEcFNsREJJdklQTUd5QTF1?=
 =?utf-8?B?bmVrc21oREVMZzFJZ1hWM0EzM0ZvYmdkL0Z5TURkZXgvQWcrRGJkMlNZRnNT?=
 =?utf-8?Q?t0VIn5nt2a8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0dGcTcwVGtkbUwvcHByajBTUkloNXZ3bmtqdENhc21vcG8rQWF2aTJHanVo?=
 =?utf-8?B?K1JXbDlaT0J2dDl6cWoxOGsyRDJ1dzU0MnhoYUlSS25qVXhLdlc2T0pvdUtx?=
 =?utf-8?B?dEZoWktsOFd0N1Q4S3NXb3FQQzVtU2xNb3pMTVIrU3ZkMTRTZWhId1VNRGZM?=
 =?utf-8?B?WUx5WHRFaCtlSWNjZ3I2RmRyaFoyNTdNZWFCcnU2UUV4YUxsRnhTK05aWUdt?=
 =?utf-8?B?WjJ3aTNMUTFwRGl3RnlKMzdrYjdEdGRWdTQxM3k1ZnpvQmNaNzlaZ0ZtTFU1?=
 =?utf-8?B?R0hRN0pwWmlyd3NwZW9yNUFJdWo2YVNtQWt5bXdVbmRrbXVPZlVPdHhtQ0s5?=
 =?utf-8?B?ZSsxSks5cFA4Yi82RzI2aFlzaFQ1Z0xKVlZCU1ZrTDMxOE15Um9MMnVBNTFl?=
 =?utf-8?B?MUFYY1BEY295empHL1JoVHRTQ2tCUXBPeUV4alZzRnc4MC9TRm9MaEdmVW9r?=
 =?utf-8?B?dU4yK2ZrZS84cW9XT3FkeFhwYk5UMnhHZWpndTI1UmZRM0dzdjlqblNXc2pw?=
 =?utf-8?B?ZkJmMnVkWjRURVV5eGgxd2wxMmlYMVgrSFlmaVZWRW1MbzlpTG03bUtiWVNm?=
 =?utf-8?B?eVpMRFk2K09WU1VQd3JTN3lHTG5IYmRueXlJbW4zNVg0M1FzV1VjWkpHdXh5?=
 =?utf-8?B?RHdFdzNEZExyUmpDQjlDSkUxS09odGZZQTY2eE9ySFFGTXJFZmpCUXBtRWlo?=
 =?utf-8?B?Z1NGbHVxOWx0eWxja3BPMWw0eE5rZXY1V1U0ZG5RNVpIM2dnOUczYmNkMmYv?=
 =?utf-8?B?TloxUDVuQ0xjTXVlY2UybGJyak5sWm0xckNyZDkvc081NU9IaGl6REwwRE9m?=
 =?utf-8?B?RHNnYXlZczk0M2N3Yk11c2JHVHVtWHZlTmJtWCtKZmNzVzU5V2hOTXY1cCt1?=
 =?utf-8?B?a2tsb0kyUFp3V21ydWcwcmFSeG5LUDJTcklBcnZmYXJZaENyUzVDU1pNYmhh?=
 =?utf-8?B?VHNJYk9rUTJZTDVwemxabEk3VUxGQlpoL1g2N29zalpjS0lYeDZ5Q0JsMytZ?=
 =?utf-8?B?S2NyN3R2UXZ2M3ZzeUh4dVJqckV5anZnVmdqVkZzdUIrZFZ4MzZRcWZTT29k?=
 =?utf-8?B?aytUeTVCaXlDQTBsK3ZQd1d2MmZKTFo2bm5mRDM1Sm5zaEdaYmFQS24xb0l0?=
 =?utf-8?B?Snk2d0c1MWFmN2VoUXZkOGN2ZEN6REkrRldHMmM2alBFWFgyK2dRTU5DWTF5?=
 =?utf-8?B?dHBiZ2lDTTlmNVFNc1lvSnhFMDdQRnlDZVRzQkFsWEFCUEVHUlp1Y1QyQWVX?=
 =?utf-8?B?TXpQQ3pqc3JZYjc5Snh1SThIVDJlb3dkR0toZHd6dnNwdmxLbUMrUWEyUjh1?=
 =?utf-8?B?b1B5eU01SFhOU2JGdXgvVWlHdkpkQjNWYjJCd2RyUFBIbUc2SS85M0kvNUM0?=
 =?utf-8?B?MWc5ejlvVHo1MkFqRGVkL2ZmZVpNVTJzdDBxY3lnL2ozQURkWmxzOEpkTWhp?=
 =?utf-8?B?djdUbm5VaXkrL1hGTjdob3NtQWJEUDZkak1Ld25iUGxVSkpTeVltOXMvV01k?=
 =?utf-8?B?ZCtzQkwwelhtQm5qUmlkYXZZODB6cWFlaDg0SEsvdjdaREtWaklpQktUbFls?=
 =?utf-8?B?SzBnV2tncXhDK01MUnVTRDhpbEYyK2UwVXpaREU0T2JqNEt2UUlNR1pPckF3?=
 =?utf-8?B?TllpR2VMZHF6aVlCQ0FpVmlZWUJmSEJlQXhjOCtDYi90STNzcTFKWld1K1Jz?=
 =?utf-8?B?RTBLVzdaaWlFK1grWXFwakVxc1c4NGFpU09BU0ZQU3BaczV6dDVOQUdoa0N5?=
 =?utf-8?B?enFqZ0JISUhiVlFmY0VsN0I4dFVhcUpHYlBqekVKNEN5T24rU3RkMG81U3Z5?=
 =?utf-8?B?QzB0STY2dWhESlhRMXJmRlExOGRTUXJ1eVNqQmtLRU1uRThaZXNhTDd5b3ZI?=
 =?utf-8?B?blZubUNRRVo4Q0VSRWtVRjVVaWluS3gwS01UL1U3R3BZYXN1aVF1REZFZDhr?=
 =?utf-8?B?ZVRta3FIUnpsd3RqNzVtL0k2VFNwMlRRdlpuVXdmS3diUzZwUzA2RmVkUWdF?=
 =?utf-8?B?VmtTMFFyU2pKdTBZK3Z0TkRzc0RxRjVJT1lITVlBMnhYYXhaYWhValhrZUp4?=
 =?utf-8?B?MDJ3aHh3WFBGUlpSd3hnZGlNZXMrMnNORmhMbWJlOXg0empyQWMwZmlsc2gw?=
 =?utf-8?Q?9evGAdPYD9FoxgiKdkyrHT5Dm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmbKfbXg4Qiv80n9evMEtcPaVp0pkvEwUqB8WJmCDH4B4d4/Ifl1Zg/DD0QzRU6g1c7/5C/+V9GYV84MAh5VGA91vWmGm37my+cLUuRbyFpcyoG8i4LX7O8RYPlk1oVwwOd/bzWXsXHjdnBKDduLvhqICQyUEzk0uLZzHwVpnlC4qgcjJex1d2HueB++5yQFUcY3Oqk8jZzRPWvUb6hWdjD8QzZe2kozWNviyiAjA2djBuuhk4raGT3TiBBbmqcKorvsf0aUfp8MoNkjXJhqtWGHkH6v6+SrkyUobR3zQhDAF2x9dsbh39CkerNvYxFMvg5nIlwo4kidKou3vZtsIzTfF5QoCw4kHjiTJQyajc615ESkUqZpSHHEXcPUp8JrnOn4fJHZdNGLhCig0TH6PfjmrAgldo/3wlFiO5eNgaZzWIFYu5qqMcvn7vUTNhBeDO2tKj5uMgLOrRLar3b5TcNbVrfhrJdYuqmsesOVqtSe20GxEdgehZPLdGNChAsHGxyhBKep1HtPtCzcxMpWoqyoTZangvKfxgZLweq1j7CYKurQWtWYSL4bwM2ZM7b+hGT0HXXiaPNr6T5MHHyDsnCDvjiKsmiibGMfCIoY26A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252849f9-a518-4b87-996b-08ddd9b290c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:11:51.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSB7vm/RSuVYTuY2zNm3N/QgYcVkgrBdUN5M9q5Fvrc25GKHEuu3EmYaJqBr9OfWz7I+RHORQr9PvPxzn5UrBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120146
X-Proofpoint-GUID: REcsm9R5pSo3VMHG9UIK1nb01JZnL_Gm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE0NyBTYWx0ZWRfX/rIACpJJ/4E0
 kgeoKS8sUbeYpQcE1wGMkSjZFalMNINWhjJQAgVy/lvMlCYw0hsCHz0Cb727oGXMkLnIm1REQjh
 he0GIP2O2U6krin6NSPkYePGhb4idNe5Ejc1GwMZ+HIskML9Y7JeSoCzGHLb5DaU1773OcnqGLG
 if20bsD+kYnWeuhw8LKGBWJj2FYxQJgSZKBKk+JQxqfxCwoRlqB5Hf/gjI6OOgaumowHhfXnzly
 /uo9mmxdEUkySR7aOTqAdH3cnuTTTvLZo5uFQFdn+5chg9LvzXe5vPWqU3aty2mdL9UzbhM5Rc9
 vrlE7LQ89oncnI7swL19wo0R/AoGZBoHwbJS/uqWxYaOfQ5on8+uepBSB73CcAM+xpAods4j7BL
 ZR3gkYpg0amfwHJvYfBnyMQnhjZ9z6KG+n88fWpWQWO2lpCvAKHioAPalVG6KpmvR2fK3Rym
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b59bb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=hkhRO4-oxJtWsY9Fc4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: REcsm9R5pSo3VMHG9UIK1nb01JZnL_Gm

On Tue, Aug 05, 2025 at 07:40:31PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 22, 2025 at 8:52 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> 
> Sorry for the delay. PTO plus merge window.

No problem! Hope you enjoyed PTO :)
Sorry for the delay as well..

> > On Thu, Jul 17, 2025 at 07:16:46PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > kmalloc_nolock() relies on ability of local_trylock_t to detect
> > > the situation when per-cpu kmem_cache is locked.
> >
> > I think kmalloc_nolock() should be kmalloc_node_nolock() because
> > it has `node` parameter?
> >
> > # Don't specify NUMA node       # Specify NUMA node
> > kmalloc(size, gfp)              kmalloc_nolock(size, gfp)
> > kmalloc_node(size, gfp, node)   kmalloc_node_nolock(size, gfp, node)
> >
> > ...just like kmalloc() and kmalloc_node()?
> 
> I think this is a wrong pattern to follow.
> All this "_node" suffix/rename was done long ago to avoid massive
> search-and-replace when NUMA was introduced. Now NUMA is mandatory.
> The user of API should think what numa_id to use and if none
> they should explicitly say NUMA_NO_NODE.

You're probably right, no strong opinion from me.

> Hiding behind macros is not a good api.
> I hate the "_node_align" suffixes too. It's a silly convention.
> Nothing in the kernel follows such an outdated naming scheme.
> mm folks should follow what the rest of the kernel does
> instead of following a pattern from 20 years ago.

That's a new scheme from a very recent patch series that did not land
mainline yet
https://lore.kernel.org/linux-mm/20250806124034.1724515-1-vitaly.wool@konsulko.se

> > > In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> > > disables IRQs and marks s->cpu_slab->lock as acquired.
> > > local_lock_is_locked(&s->cpu_slab->lock) returns true when
> > > slab is in the middle of manipulating per-cpu cache
> > > of that specific kmem_cache.
> > >
> > > kmalloc_nolock() can be called from any context and can re-enter
> > > into ___slab_alloc():
> > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > > or
> > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
> > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> >
> > > Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> > > can be acquired without a deadlock before invoking the function.
> > > If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> > > retries in a different kmalloc bucket. The second attempt will
> > > likely succeed, since this cpu locked different kmem_cache.
> > >
> > > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > > per-cpu rt_spin_lock is locked by current _task_. In this case
> > > re-entrance into the same kmalloc bucket is unsafe, and
> > > kmalloc_nolock() tries a different bucket that is most likely is
> > > not locked by the current task. Though it may be locked by a
> > > different task it's safe to rt_spin_lock() and sleep on it.
> > >
> > > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > > immediately if called from hard irq or NMI in PREEMPT_RT.
> >
> > A question; I was confused for a while thinking "If it can't be called
> > from NMI and hard irq on PREEMPT_RT, why it can't just spin?"
> 
> It's not safe due to PI issues in RT.
> Steven and Sebastian explained it earlier:
> https://lore.kernel.org/bpf/20241213124411.105d0f33@gandalf.local.home/

Uh, I was totally missing that point. Thanks for pointing it out!

> I don't think I can copy paste the multi page explanation in
> commit log or into comments.
> So "not safe in NMI or hard irq on RT" is the summary.
> Happy to add a few words, but don't know what exactly to say.
> If Steven/Sebastian can provide a paragraph I can add it.
> 
> > And I guess it's because even in process context, when kmalloc_nolock()
> > is called by bpf, it can be called by the task that is holding the local lock
> > and thus spinning is not allowed. Is that correct?
> >
> > > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > > and (in_nmi() or in PREEMPT_RT).
> > >
> > > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > > spin_trylock_irqsave(&n->list_lock) to allocate,
> > > while kfree_nolock() always defers to irq_work.
> > >
> > > Note, kfree_nolock() must be called _only_ for objects allocated
> > > with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> > > were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
> > > will miss kmemleak/kfence book keeping and will cause false positives.
> > > large_kmalloc is not supported by either kmalloc_nolock()
> > > or kfree_nolock().
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  include/linux/kasan.h |  13 +-
> > >  include/linux/slab.h  |   4 +
> > >  mm/Kconfig            |   1 +
> > >  mm/kasan/common.c     |   5 +-
> > >  mm/slab.h             |   6 +
> > >  mm/slab_common.c      |   3 +
> > >  mm/slub.c             | 466 +++++++++++++++++++++++++++++++++++++-----
> > >  7 files changed, 445 insertions(+), 53 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 54444bce218e..7de6da4ee46d 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
> > >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > >                       gfp_t gfp, bool new_slab)
> > >  {
> > > +     bool allow_spin = gfpflags_allow_spinning(gfp);
> > >       unsigned int objects = objs_per_slab(s, slab);
> > >       unsigned long new_exts;
> > >       unsigned long old_exts;
> > > @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > >       gfp &= ~OBJCGS_CLEAR_MASK;
> > >       /* Prevent recursive extension vector allocation */
> > >       gfp |= __GFP_NO_OBJ_EXT;
> > > -     vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > > -                        slab_nid(slab));
> > > +     if (unlikely(!allow_spin)) {
> > > +             size_t sz = objects * sizeof(struct slabobj_ext);
> > > +
> > > +             vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
> >
> > In free_slab_obj_exts(), how do you know slabobj_ext is allocated via
> > kmalloc_nolock() or kcalloc_node()?
> 
> Technically kmalloc_nolock()->kfree() isn't as bad as
> kmalloc()->kfree_nolock(), since kmemleak/kfence can ignore
> debug free-ing action without matching alloc side,
> but you're right it's better to avoid it.
> 
> > I was going to say "add a new flag to enum objext_flags",
> > but all lower 3 bits of slab->obj_exts pointer are already in use? oh...
> >
> > Maybe need a magic trick to add one more flag,
> > like always align the size with 16?
> >
> > In practice that should not lead to increase in memory consumption
> > anyway because most of the kmalloc-* sizes are already at least
> > 16 bytes aligned.
> 
> Yes. That's an option, but I think we can do better.
> OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
> Here are two patches that fix this issue:
> 
> Subject: [PATCH 1/2] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
> 
> Since the combination of valid upper bits in slab->obj_exts with
> OBJEXTS_ALLOC_FAIL bit can never happen,
> use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> instead of (1ull << 2) to free up bit 2.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

This will work, but it would be helpful to add a comment clarifying that
when bit 0 is set with valid upper bits, it indicates
MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it indicates
OBJEXTS_ALLOC_FAIL.

When someone looks at the code without checking history it might not
be obvious at first glance.

>  include/linux/memcontrol.h | 4 +++-
>  mm/slub.c                  | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 785173aa0739..daa78665f850 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -341,17 +341,19 @@ enum page_memcg_data_flags {
>         __NR_MEMCG_DATA_FLAGS  = (1UL << 2),
>  };
> 
> +#define __OBJEXTS_ALLOC_FAIL   MEMCG_DATA_OBJEXTS
>  #define __FIRST_OBJEXT_FLAG    __NR_MEMCG_DATA_FLAGS
> 
>  #else /* CONFIG_MEMCG */
> 
> +#define __OBJEXTS_ALLOC_FAIL   (1UL << 0)
>  #define __FIRST_OBJEXT_FLAG    (1UL << 0)
> 
>  #endif /* CONFIG_MEMCG */
> 
>  enum objext_flags {
>         /* slabobj_ext vector failed to allocate */
> -       OBJEXTS_ALLOC_FAIL = __FIRST_OBJEXT_FLAG,
> +       OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
>         /* the next bit after the last actual flag */
>         __NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
>  };
> diff --git a/mm/slub.c b/mm/slub.c
> index bd4bf2613e7a..16e53bfb310e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1950,7 +1950,7 @@ static inline void
> handle_failed_objexts_alloc(unsigned long obj_exts,
>          * objects with no tag reference. Mark all references in this
>          * vector as empty to avoid warnings later on.
>          */
> -       if (obj_exts & OBJEXTS_ALLOC_FAIL) {
> +       if (obj_exts == OBJEXTS_ALLOC_FAIL) {
>                 unsigned int i;
> 
>                 for (i = 0; i < objects; i++)
> --
> 2.47.3
> 
> Subject: [PATCH 2/2] slab: Use kfree_nolock() to free obj_exts
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/memcontrol.h | 1 +
>  mm/slub.c                  | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index daa78665f850..2e6c33fdd9c5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -354,6 +354,7 @@ enum page_memcg_data_flags {
>  enum objext_flags {
>      /* slabobj_ext vector failed to allocate */
>      OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,

/* slabobj_ext vector allocated with kmalloc_nolock() */ ?

> +    OBJEXTS_NOSPIN_ALLOC = __FIRST_OBJEXT_FLAG,
>      /* the next bit after the last actual flag */
>      __NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
>  };
> diff --git a/mm/slub.c b/mm/slub.c
> index 16e53bfb310e..417d647f1f02 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2009,6 +2009,8 @@ int alloc_slab_obj_exts(struct slab *slab,
> struct kmem_cache *s,
>      }
> 
>      new_exts = (unsigned long)vec;
> +    if (unlikely(!allow_spin))
> +        new_exts |= OBJEXTS_NOSPIN_ALLOC;
>  #ifdef CONFIG_MEMCG
>      new_exts |= MEMCG_DATA_OBJEXTS;
>  #endif
> @@ -2056,7 +2058,10 @@ static inline void free_slab_obj_exts(struct slab *slab)
>       * the extension for obj_exts is expected to be NULL.
>       */
>      mark_objexts_empty(obj_exts);
> -    kfree(obj_exts);
> +    if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> +        kfree_nolock(obj_exts);
> +    else
> +        kfree(obj_exts);
>      slab->obj_exts = 0;
>  }
> 
> --
> 2.47.3

Otherwise looks fine to me.

> > > +     } else {
> > > +             vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > > +                                slab_nid(slab));
> > > +     }
> > >       if (!vec) {
> > >               /* Mark vectors which failed to allocate */
> > >               if (new_slab)
> > > +static void defer_deactivate_slab(struct slab *slab, void *flush_freelist);
> > > +
> > >  /*
> > >   * Called only for kmem_cache_debug() caches to allocate from a freshly
> > >   * allocated slab. Allocate a single object instead of whole freelist
> > >   * and put the slab to the partial (or full) list.
> > >   */
> > > -static void *alloc_single_from_new_slab(struct kmem_cache *s,
> > > -                                     struct slab *slab, int orig_size)
> > > +static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
> > > +                                     int orig_size, gfp_t gfpflags)
> > >  {
> > > +     bool allow_spin = gfpflags_allow_spinning(gfpflags);
> > >       int nid = slab_nid(slab);
> > >       struct kmem_cache_node *n = get_node(s, nid);
> > >       unsigned long flags;
> > >       void *object;
> > >
> > > +     if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
> >
> > I think alloc_debug_processing() doesn't have to be called under
> > n->list_lock here because it is a new slab?
> >
> > That means the code can be something like:
> >
> > /* allocate one object from slab */
> > object = slab->freelist;
> > slab->freelist = get_freepointer(s, object);
> > slab->inuse = 1;
> >
> > /* Leak slab if debug checks fails */
> > if (!alloc_debug_processing())
> >         return NULL;
> >
> > /* add slab to per-node partial list */
> > if (allow_spin) {
> >         spin_lock_irqsave();
> > } else if (!spin_trylock_irqsave()) {
> >         slab->frozen = 1;
> >         defer_deactivate_slab();
> > }
> 
> No. That doesn't work. I implemented it this way
> before reverting back to spin_trylock_irqsave() in the beginning.
> The problem is alloc_debug_processing() will likely succeed
> and undoing it is pretty complex.
> So it's better to "!allow_spin && !spin_trylock_irqsave()"
> before doing expensive and hard to undo alloc_debug_processing().

Gotcha, that makes sense!

> > > +             /* Unlucky, discard newly allocated slab */
> > > +             slab->frozen = 1;
> > > +             defer_deactivate_slab(slab, NULL);
> > > +             return NULL;
> > > +     }
> > >
> > >       object = slab->freelist;
> > >       slab->freelist = get_freepointer(s, object);
> > >       slab->inuse = 1;
> > >
> > > -     if (!alloc_debug_processing(s, slab, object, orig_size))
> > > +     if (!alloc_debug_processing(s, slab, object, orig_size)) {
> > >               /*
> > >                * It's not really expected that this would fail on a
> > >                * freshly allocated slab, but a concurrent memory
> > >                * corruption in theory could cause that.
> > > +              * Leak memory of allocated slab.
> > >                */
> > > +             if (!allow_spin)
> > > +                     spin_unlock_irqrestore(&n->list_lock, flags);
> > >               return NULL;
> > > +     }
> > >
> > > -     spin_lock_irqsave(&n->list_lock, flags);
> > > +     if (allow_spin)
> > > +             spin_lock_irqsave(&n->list_lock, flags);
> > >
> > >       if (slab->inuse == slab->objects)
> > >               add_full(s, n, slab);
> > > + * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
> > > + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> > > + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
> > > + *
> > > + * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
> > > + */
> > > +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> > > +#define local_lock_cpu_slab(s, flags)        \
> > > +     local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> > > +#else
> > > +#define local_lock_cpu_slab(s, flags)        \
> > > +     lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags))
> > > +#endif
> > > +
> > > +#define local_unlock_cpu_slab(s, flags)      \
> > > +     local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
> > > +
> > >  #ifdef CONFIG_SLUB_CPU_PARTIAL
> > >  static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
> > >  {
> > > @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >       if (unlikely(!node_match(slab, node))) {
> > >               /*
> > >                * same as above but node_match() being false already
> > > -              * implies node != NUMA_NO_NODE
> > > +              * implies node != NUMA_NO_NODE.
> > > +              * Reentrant slub cannot take locks necessary to
> > > +              * deactivate_slab, hence ignore node preference.
> >
> > Now that we have defer_deactivate_slab(), we need to either update the
> > code or comment?
> >
> > 1. Deactivate slabs when node / pfmemalloc mismatches
> > or 2. Update comments to explain why it's still undesirable
> 
> Well, defer_deactivate_slab() is a heavy hammer.
> In !SLUB_TINY it pretty much never happens.
> 
> This bit:
> 
> retry_load_slab:
> 
>         local_lock_cpu_slab(s, flags);
>         if (unlikely(c->slab)) {
> 
> is very rare. I couldn't trigger it at all in my stress test.
> 
> But in this hunk the node mismatch is not rare, so ignoring node preference
> for kmalloc_nolock() is a much better trade off.
> I'll add a comment that defer_deactivate_slab() is undesired here.

Wait, does that mean kmalloc_nolock() have `node` parameter that is always
ignored? Why not use NUMA_NO_NODE then instead of adding a special case
for !allow_spin?

> > > +              * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> > >                */
> > > -             if (!node_isset(node, slab_nodes)) {
> > > +             if (!node_isset(node, slab_nodes) ||
> > > +                 !allow_spin) {
> > >                       node = NUMA_NO_NODE;
> > >               } else {
> > >                       stat(s, ALLOC_NODE_MISMATCH);
> >
> > > @@ -4572,6 +4769,98 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> > >       discard_slab(s, slab);
> > >  }
> > >
> > > +/*
> > > + * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
> > > + * to take sleeping spin_locks from __slab_free() and deactivate_slab().
> > > + * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
> > > + */
> > > +static void free_deferred_objects(struct irq_work *work)
> > > +{
> > > +     struct defer_free *df = container_of(work, struct defer_free, work);
> > > +     struct llist_head *objs = &df->objects;
> > > +     struct llist_head *slabs = &df->slabs;
> > > +     struct llist_node *llnode, *pos, *t;
> > > +
> > > +     if (llist_empty(objs) && llist_empty(slabs))
> > > +             return;
> > > +
> > > +     llnode = llist_del_all(objs);
> > > +     llist_for_each_safe(pos, t, llnode) {
> > > +             struct kmem_cache *s;
> > > +             struct slab *slab;
> > > +             void *x = pos;
> > > +
> > > +             slab = virt_to_slab(x);
> > > +             s = slab->slab_cache;
> > > +
> > > +             /*
> > > +              * We used freepointer in 'x' to link 'x' into df->objects.
> > > +              * Clear it to NULL to avoid false positive detection
> > > +              * of "Freepointer corruption".
> > > +              */
> > > +             *(void **)x = NULL;
> > > +
> > > +             /* Point 'x' back to the beginning of allocated object */
> > > +             x -= s->offset;
> > > +             /*
> > > +              * memcg, kasan_slab_pre are already done for 'x'.
> > > +              * The only thing left is kasan_poison.
> > > +              */
> > > +             kasan_slab_free(s, x, false, false, true);
> > > +             __slab_free(s, slab, x, x, 1, _THIS_IP_);
> > > +     }
> > > +
> > > +     llnode = llist_del_all(slabs);
> > > +     llist_for_each_safe(pos, t, llnode) {
> > > +             struct slab *slab = container_of(pos, struct slab, llnode);
> > > +
> > > +#ifdef CONFIG_SLUB_TINY
> > > +             discard_slab(slab->slab_cache, slab);
> >
> > ...and with my comment on alloc_single_from_new_slab(),
> > The slab may not be empty anymore?
> 
> Exactly.
> That's another problem with your suggestion in alloc_single_from_new_slab().
> That's why I did it as:
> if (!allow_spin && !spin_trylock_irqsave(...)
> 
> and I still believe it's the right call.

Yeah, I think it's fine.

> The slab is empty here, so discard_slab() is appropriate.
>
> > > +#else
> > > +             deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
> > > +#endif
> > > +     }
> > > +}
> > > @@ -4610,10 +4901,30 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
> > >       barrier();
> > >
> > >       if (unlikely(slab != c->slab)) {
> > > -             __slab_free(s, slab, head, tail, cnt, addr);
> > > +             if (unlikely(!allow_spin)) {
> > > +                     /*
> > > +                      * __slab_free() can locklessly cmpxchg16 into a slab,
> > > +                      * but then it might need to take spin_lock or local_lock
> > > +                      * in put_cpu_partial() for further processing.
> > > +                      * Avoid the complexity and simply add to a deferred list.
> > > +                      */
> > > +                     defer_free(s, head);
> > > +             } else {
> > > +                     __slab_free(s, slab, head, tail, cnt, addr);
> > > +             }
> > >               return;
> > >       }
> > >
> > > +     if (unlikely(!allow_spin)) {
> > > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> > > +                 local_lock_is_locked(&s->cpu_slab->lock)) {
> > > +                     defer_free(s, head);
> > > +                     return;
> > > +             }
> > > +             cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
> > > +             kasan_slab_free(s, head, false, false, /* skip quarantine */true);
> > > +     }
> >
> > I'm not sure what prevents below from happening
> >
> > 1. slab == c->slab && !allow_spin -> call kasan_slab_free()
> > 2. preempted by something and resume
> > 3. after acquiring local_lock, slab != c->slab, release local_lock, goto redo
> > 4. !allow_spin, so defer_free() will call kasan_slab_free() again later
> 
> yes. it's possible and it's ok.
> kasan_slab_free(, no_quarantine == true)
> is poison_slab_object() only and one can do it many times.
>
> > Perhaps kasan_slab_free() should be called before do_slab_free()
> > just like normal free path and do not call kasan_slab_free() in deferred
> > freeing (then you may need to disable KASAN while accessing the deferred
> > list)?
> 
> I tried that too and didn't like it.
> After kasan_slab_free() the object cannot be put on the llist easily.
> One needs to do a kasan_reset_tag() dance which uglifies the code a lot.
> Double kasan poison in a rare case is fine. There is no harm.

Okay, but we're now depending on kasan_slab_free() being safe to be
called multiple times on the same object. That would be better
documented in kasan_slab_free().

-- 
Cheers,
Harry / Hyeonggon

