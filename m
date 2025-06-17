Return-Path: <bpf+bounces-60828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BFADD7A8
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 18:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518A51944CDA
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704F2F364E;
	Tue, 17 Jun 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKL6wo8B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+UFK/Pi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253962E8DE4;
	Tue, 17 Jun 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178032; cv=fail; b=uU9ZjYOWgRmCcpcwxxK/ifopkee60PYZ8AvpXVJhVzfDKE9Qar/0759p6uszszgeizU4A7LqGUyz958uyo+Ai/GzWyCxtUestul58o6oLf+O6Xv5/YDAnOEdxHDZjmyX8UnoMjguISOTLKsNOP/0YsrxemnUNAiE5woyH0XxHmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178032; c=relaxed/simple;
	bh=FOA5ASpdkl3BF7cNwILqsNVsmRKJy2nk9RaMUagFFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EasdNC3JE5YGYqHmOCJ8jH20YiiQG84iEhGBoJa9FEwo1WaDaOpxnbSGc57mNlS8hPyNIZsiicWkgozD2jInzYg+KnopJBSYAvKxRChuZdPX1vv+nDzWhbRLFjiLnaWeFSTL0lLjS2FMQP3p91bDNQefJVfifuZITc6JYLWlW/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKL6wo8B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+UFK/Pi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEWxHx000426;
	Tue, 17 Jun 2025 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8bfIg8DZcwpJx284CkRt0tGVAQtRaM278w31Dfs0FQg=; b=
	gKL6wo8BWakpBuA88rYHl6csj4yX65vJClq3iz9d0BCWirNNtBCCbAUMJ1In0OnL
	8K0rFR8zRfDgaovJXJ9Gfi1KhI121qrw7uLR3Kk85e3IPPuQhJqky2R5BU7/qeFO
	u31cclHxEcw5yRQjxhISrZXNjFgKjZ1DPmMLX3OvEBUDR7SSiR/NIFNyzM850bZC
	qVXa4mSTCXEl0XdW5pmy4No7BAXBEfrb6Ie22oAzh3IGQgLGVg6YZCCJO3Ecdeev
	MCmiaEI3nvIe2glfX9u/7zc5+k9Ny7glLeM3dsMrn42NRuMrXSoTzNKbyFCkxKJ9
	xLZu9A8wXvBd+ZjGXLmNNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4nsbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 16:33:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HF7ArZ026060;
	Tue, 17 Jun 2025 16:33:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhfqvaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 16:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOGnlAJvTREzzL7zULDK8Qn0douCm8xxnM0hY0MaB9VLj961dHBBFUgXQsInnEppIP5JtGj/ZJtft5D6dU2CPJVS4AjrS2kjBRA6e6GOfa/gj6O543+EWoYzkGTVFqfLQ2lKeymhz1IWNo9ULVNvMsH6NX81DVgHZGQpVXFdoG9abCmlFlDxJaKvN6Bq13l3npno0WPpOEk3IIFfnNNR6XCts+MJPs7VXCrzaQQSFHAhgSNEMUkHY46vhm2w2GCwac/jta1wt2aIcgRneaUoqOw2YCcB6KeeaJ2pJZXKi1l+SY0YU7eSQxSmsZiRijMdx47TFy/zEv49iMFnc5pLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bfIg8DZcwpJx284CkRt0tGVAQtRaM278w31Dfs0FQg=;
 b=vZkx2AbeAeZsb45QD+T1tflnUD5skXdjdmba5ZKYqvC9QjKHXVD4GH5/6m3BI+/Rz4ttQ03IWtAt6OdY3l9lmHE9uVAX/Hl4Ecj0t3BZa6JE9VI+708PX+Whds407bZqEsuMK3a8si8Aqgz1QCj/u8ZRMOMq+HIuYAvLFYn4iLYx7Byhy49BuXmqyz9+1jSvjMcGymkSegL6bE0AFz04gpoguv+vRNRhdfcUFAw8FpFY7+5yH0tWIih3BztUi3SoeWcA4irsTGqRvo+2w+zwpToOvtZoDrlgM7ICCrEddEIX40aFVcY6YQ8Hs+J6gfbj9W0rIadSL45pZqNhFhj4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bfIg8DZcwpJx284CkRt0tGVAQtRaM278w31Dfs0FQg=;
 b=P+UFK/Pi3smXLdtil0EAbLey5SFviln3DGXAMeBOrtnkMDE6Mm3GJ9yPvBQU6E0Tv5wiPLDAVYHGXZuiXnMeZZ29XEZhGpGAaUed9/l/C4nocOltE9sOjeOUKrIUs3zaPsiA5AxAYc0VaOfDnspqj894Fy+ZRuy+8TLzLMuTz2g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB7421.namprd10.prod.outlook.com (2603:10b6:208:46e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 16:32:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 16:32:59 +0000
Date: Wed, 18 Jun 2025 01:32:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
        Byungchul Park <byungchul@sk.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: Re: netmem series needs some love and Acks from MM folks
Message-ID: <aFGYr6qlzVlqhK55@harry>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
 <aFDTikg1W3Bz_s5E@hyeyoo>
 <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
X-ClientProxiedBy: SE2P216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 437ecfd4-f52b-4d52-77d3-08ddadbc9f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVNJbXlqK0JxNmhtbDBRV1hMa25qeWVCTGlYQWYydzNIZFdlUFB6WTZWMlJh?=
 =?utf-8?B?OUdtY0ZhUWNHMndFaWlDbTdsaS9uaG8reEFacEUzQ254bTZnNVNYd01JNHpx?=
 =?utf-8?B?bnVlYjNXWFluYmVrV0hQRFpBaU1DbmJPL0NGUW9ycThkRjloOGVSVldxenZS?=
 =?utf-8?B?VlBoa1luUEd1YjBtcG95aWVZdkxMdVNFR1JyNDZ4WTRnRVh6eDh0bE5iZmFv?=
 =?utf-8?B?OFQ3c3JxRDJNUWE4ZVBPanRTaWorWDQxbkhoMVVCSjlIbHBXZGt3eU1sYWYv?=
 =?utf-8?B?UWRBaGNjY2o2U1BvUU0xbEw5VmlFaDkvcERoUHZDV3o2L2xtVzcwWHFRU0dI?=
 =?utf-8?B?aDg4bThhUUhmZHJ3dVc3VjBCRWpEd0V0TTdGWXIvUFExdHdJVEVibURhWXVF?=
 =?utf-8?B?VWxCaTg1VjArbWFjdVBTaGM5U2QrSGx5dGxSc2hmMG9mZDduRGVqYTFrSWxu?=
 =?utf-8?B?R3BEYTRtNXd3a0pZSlh4eEgrZUE1aFkzdVgyOHV5NTJIeEdIbDBwczdMdTR3?=
 =?utf-8?B?enNWVUVhS0tXN0FWd0FKTnNqbWdMTHVKMjB0dTQ2elh3aERyZitoTGFoZmpw?=
 =?utf-8?B?N1RWc25nVVV1Q1hSNnJNN2QzVkZnMnRJR01wdlNYVVI5U0xlbnBzN2psRDNH?=
 =?utf-8?B?b2dRNGxsMG5NaW4vbnlRUWdhTWlHbWhLRUV5R0dnNWJSSVRQK3g0am5wUXc1?=
 =?utf-8?B?UEJNbHY2c21HZDE1M3ZRQ3Z3TXZUZXZEWjJiNXNicGJLS0ZFZlRBOFVNZUF6?=
 =?utf-8?B?KzVMc1FQYnJKd01vUjU5UEE0Y2lMRXpJUUIyQWVWOG93cmY0dlZjOXZlUTJC?=
 =?utf-8?B?cnVyYXhJemE3U1E1VlhGTWhZS0pwT280K003Yk5aSTM1NXRPMXZXZmNKVlIy?=
 =?utf-8?B?aW5PSVBtTHlLV1ZUL255N3VxY1g5VjlmVEpieHBmR055ai9aSFViVXhWWU1H?=
 =?utf-8?B?ci93N3JCc0ZETWpPeUxRejVZd2NvMUJvNTl0Z0hOM2U4d002TmZWcVo0bUpQ?=
 =?utf-8?B?QUVmZUhTYmNmKzBIUmxaMkp2M2FzWHZRWUtUN3Jpc2RnVTVVUW5UbjZCK09m?=
 =?utf-8?B?VHB3cTlzOUoyNTdocHVvbVZpVVUzNkRRbVA0ZEZNakY5THlyYTZVRk0ydTc4?=
 =?utf-8?B?ZmMvNi9tN3c0R1h6TnMwdVdaRXFCWndZdUtPVkh6ZllNU0hmdGtaN216dG1D?=
 =?utf-8?B?MUlpVlJnbzVWQmkxRmJySVlFQVQ0dTBmQTRmR0pVUk83cGVmRkkzOHRCb1l4?=
 =?utf-8?B?Z3c4VVdPaElWTzdHeWk0RVF5cUFONUh1MDVzbXlSVytGZWZXaWF1dG9nSmgw?=
 =?utf-8?B?S0R5QXVYTS9XZjloVlVQcWdpYzh6SVMyMWxaQ2JsN0dqUFFBZisyeGlBdlRh?=
 =?utf-8?B?NG94M2hHUWVSWkVQQVZMdUphT2loYlltQ0NYNGVyTEhuUkxnRXNTem1HaFR6?=
 =?utf-8?B?bFVMb3AyYkJmNDhnaFhPV1hKNEpWRzZqb1BISG9RRzM2RGsyS1Z0aWZ4bkYr?=
 =?utf-8?B?VEg0Q0htR0JvN3FCSGhiK3huRFNXejJyZE9GWFd3ZFpYUHZRYmFOTEMweVkw?=
 =?utf-8?B?NkUwNjJnNk1QUHBIZ1RMR0Nyenc1VlJFdVlBL1hDUXA0VVNLdFo0ZDk4Q0Z1?=
 =?utf-8?B?ZkRmOWYvWU52VG9NbDR4Ujd4WE5NNThkTnM2UFF2VzFpTyt1aGQ2WUk5VDZw?=
 =?utf-8?B?cWFJVnBrSU1YMWRJQUNuVm5QclpvY1Q1aUp6NFpZRnhwSEVhejVqRWlyN2Y5?=
 =?utf-8?B?ZmFSWlltWVVhMmlVMmNva0VVNGlNVG9hM3hxLzBvMWZleG1mcjFWdmlaV0l0?=
 =?utf-8?B?OXpKU3ZhSWMxMy85aEk4V0U5ZG01aG50M0dmcHhLWUg0RFlMaitMNDBHOVI1?=
 =?utf-8?B?VlhtNEgzZU95RkZORE51dGJWSmZYcEoyaHFrd2ljNGlrdWZrMGJCRkVBSE1r?=
 =?utf-8?Q?Nxejlnc91Vs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFPUXNyRXVsMTNZNkxVdlBQeVJRQ2hFYVNSQit3d0doazFySTNVcWxtemt2?=
 =?utf-8?B?Q3VqR2JvR3F1bjR1eThkdzg0eDBKN2JESzZ3dFZ1RnhlcGJBNEFlV3JIdWRr?=
 =?utf-8?B?Z0cxcnAxTWZQV2dCSDk0cWs3QnhOa0d0RUl0RVlQeE1BM3dhekxrUkN5WGJ1?=
 =?utf-8?B?bEZuL1Nqd0tCL0FBQVF4MFRVemVPTUJMcWU1Q2g1WHAwYVJ2anNiSlVZZ05w?=
 =?utf-8?B?T2djVzhOeWdoQW8vTjBIUC9OYTc1TEhtbXpJRGY1a3FqS2wyTWZPcXNJUkxQ?=
 =?utf-8?B?VEtFeGtIam5MbjYwM2s3djJhWjNhL3QwWjVGVTVveUdoWTZvTWgvczkxZzZl?=
 =?utf-8?B?OVZtS2NpMXptQ09SbWQ1RFN4MmlQVTZrbU0wTkFnWVlINDFKTkZ5OHNMYmps?=
 =?utf-8?B?V1UzQ3pnZnBjYUs5NG95RklWeE5tMzAwb3hIZHJyUHpIZDIySEloaWpFZEN4?=
 =?utf-8?B?Y2dUakFIMjdJWkJ4Q0hEWkczMjRnei9jckRjT0lUSUxCbUJpaU0wU0xmZ1NT?=
 =?utf-8?B?Qmg4aUxoc25wWmoweEFPOWcvaU0yNk5vR2IrQWpoN0NEeGtDVUNnMnF5UkRw?=
 =?utf-8?B?Q0RLL041VE44R2pHRFQrTUFnTlhvNVpLcTM5V1pFQ1VPNDhTdEwxMnZiM20x?=
 =?utf-8?B?d1NkTHVWbHlTTGRQTHREOTFQMzFQM0JuZ3haY3puRzZWM0dKNm5COWtDYWlG?=
 =?utf-8?B?RWV5N0NnWVEvUldGdFBncWE3dlE2c0VwM2lsRVlWbWlCU1VLRlVQZ1N2akdz?=
 =?utf-8?B?V0VlbEF6aC8zY1FHUE1oZWV2K2ovcGwyb09HSm5oK2ZKUUZjRnlVeEVOV2t6?=
 =?utf-8?B?TnNXK3JGNjh3cE85aHlFU0g4a3dDY0JscEh6VlFIYUhoSGRKVDB2Y1oyYVo2?=
 =?utf-8?B?MjhoZ0VNRUF4WGxjamVTaXdsaUdoem9LZi83RmIyZEpLNHd0c0RrNkJia0RF?=
 =?utf-8?B?ZDFQcklvTTBYNW14QWFXYklCTTlsdnhYUTZ0NTU2b3hNSW5jQmhMRml4RFRo?=
 =?utf-8?B?VER6L2VZZW54U1FHeTJIblFpUUVKOGRPaGV0bkdzREpCNlJrbHZNMXVYOTNP?=
 =?utf-8?B?dWp3S1RBdEUrRGIyMld6R1o2T2xsbml2cDd0Zy9vUmdLNnhTdVd4bWliR29V?=
 =?utf-8?B?Ymk3NUU4di9TTThRQ2NvbVlKdDVxM0plbzN2WU85N1VJOEVGQlRqczRlbFdt?=
 =?utf-8?B?RGNFOEk2NzNGeEgzeE5YUXRkQzV2UzNQSFc0QnhldlFXOHY4RWVab01MYWN4?=
 =?utf-8?B?andkZHpSd29meVlXc3kzcGFuZHVHamtlcDk1WDlidk9NL3pQQ1l4RmVJd3Rp?=
 =?utf-8?B?eFQ3SnJGZDJra1pOdzAzYkhGb1pWT1JjNWc0dnpTU2ZwOXlCcnV3UExQbWhD?=
 =?utf-8?B?RjJWNUdrTWFsZEdkd09jOVp2aHZZcXNpQzVITDNEZ21udWlLWW5TbFJVdzl5?=
 =?utf-8?B?b24vMXJtU0VzSDZ6S0RKd1lDZkloS1Jtd29lUnI2NXpKcG1tdFJlU2pEWHBW?=
 =?utf-8?B?Qml4dkpha1ZFS2NINjN2ZGNmTVV3RmpOQm1jZUYxdzhuTXc1aGZWdWxWZ0dD?=
 =?utf-8?B?ODlxMXYrbDA0amQ3SkxwUW9mQitPNXdJS0hZYjlTQTBpMEJubm1NcXJDbVR5?=
 =?utf-8?B?R0M0OTV6R1UwNkRTUHc4cE5JL2ErWUZoUnhpcHA0SzFqY1lvZHRMTWFnZUEv?=
 =?utf-8?B?QkV6OGJ1R01WRGhZYm1mS1R5MytaTzN0NmZ4YmgwM3phSVFQbW1lWHQveDVZ?=
 =?utf-8?B?MTRhblFaM3VRUlYzdmxkSHhaeHJGalY5eVh4dXZLSFlZS3R2TlRCeEFrL2F4?=
 =?utf-8?B?amtYTUJUZXJITU5kNFM2cThrd0t2T2hvbElEWXRwQkFndGppL0dMWUQ4TXkr?=
 =?utf-8?B?eXdyNkFyUk1nb2VTVzBHdzFReUVPOTVCNEhnVzY5WU1zK3BseHJzdi9oK0xY?=
 =?utf-8?B?MzFkTm5PT2lhS0prRmtRei9OeUVOMVF6RUQwcmVTbHlKaytnT1JVZXQ3VGRB?=
 =?utf-8?B?d0RIQmpaWk1iV3NjVExxK1B3ck1Yek02VW9wcThTdXEvTDB5K3hhRVhTSXZx?=
 =?utf-8?B?cjM0S25tRWVrL1Jtc3AwdGp6SHhOemtObDhnMnZvWjFGT2ZUYllzeVFRRmtn?=
 =?utf-8?Q?00nUvTSIZuV1I/LtUv0H33kjw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2ghvvBLGyUbPDjGOwDcYxBIhFZl1SWS9dvHDZEtM1LymBs0F9AqM+8XnejKRz2WWQdjVCiQUUOCeaoEIuaGpkb7eyB7iMQpFeoY9zOGC5So5LZyz5g3VsNKu3oJiISmDV2P76NBuSzU9CKRfjiLFjwIJUIxfsRptOK2a43OyrCHw4H8TxDLvc8MGjLTwEsZbk+YtOPJ7SmpqpeYqriHkZ+++6gKxAB8TxpPe7U0/pG9BoBWldguSJGFLe/q+QBZoNtm5iE3CBhlg2rvCuYe+hBzCS0VPQ73XY/B4+/2uEQUR1U5Dv38ZUhF/fSdGj/CQpiLFUAjiEUh30RjfdrfSkQlr3HZ+3ddPGUT8u7QuhOi45Ex76JO7WW6lI0P1faS3Vg7JwAJyo/zrQGqxrpB4l/Clbwz4h85UOVYvZFgM/2iNyglzJP8es8AmtRNbDLPTIaXa082L9ZdQYmc/FLH/y4GPz2ugKv7jl+u0EM5QncKeXbJT+3gBUB5G2kf2pkIyaxUrLM2oMQpW76gr8e0KXVXF+NqqGgLNvzyb4wQ+IpjSrlOtqh7W0ylKWlMuzxOegSMkbNugzOWubOVqgRnvTxgol3sO1MGnUsTv4rVklI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437ecfd4-f52b-4d52-77d3-08ddadbc9f2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:32:59.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoF0t+XIjWXdLNlwBzI0Pg/2dKSu7l9JD8mqQppJAGB1r1p1n6g1Zf/bkoupfKrKAh+d4i0LGP3KDaCoCqxMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEzMSBTYWx0ZWRfXyOOy5Tw0/lxi KE+99hhWxOFEljtBmEIPN2m0GHyt77eF/gqcjju72xvZr1ye5NKE1mHo9JMsybW82diqnbhNHBv 5hu/TkfFw0Lmy5+G7y9Ufp1j8zPWN+bk/DA5yB2Ns2qjxfytNYFWl3GqP0UGlEL5XrzFMitHAx8
 9WFoRIEM9Zg26z6TJC8GBHLMaRD3lSoGpLDeoI1XZqE8bSVxkW9bc423QQSk2Ptm7HaQo88JmfT Kz2DQCwW2dI9vErvNYPu2SovmSwO5rXpnDaql+JT/nCo5HeY4NBLenP64i6OWOw5nSIZxLwuJfd +jNql2ftMASSEtCR332QL5EsiwcwEablcwjLkAr+78nFiqctVsknOE6bJ11PHPlrFU8dlrfJ1cK
 es3E9N9FbdBMdZUXD4vReItndBj/ygpcmdSr+AGItqReEExqzvgw/sbYLWiPIZ3dLFL2kF8H
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=685198c3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ph6IYJdgAAAA:8 a=mRfcV4GaGE4iUm-VBoEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ty6LBwuTSqq6QlXLCppH:22 cc=ntf awl=host:13207
X-Proofpoint-GUID: om-OPLU5KyVZfXXtT7OKLWkK_TlOwmfH
X-Proofpoint-ORIG-GUID: om-OPLU5KyVZfXXtT7OKLWkK_TlOwmfH

On Tue, Jun 17, 2025 at 06:09:36PM +0200, David Hildenbrand wrote:
> On 17.06.25 04:31, Harry Yoo wrote:
> > On Fri, Jun 13, 2025 at 07:19:07PM -0700, Mina Almasry wrote:
> > > On Thu, Jun 12, 2025 at 6:13 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > > > > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > > > > What's the intended relation between the types?
> > > > > > 
> > > > > > One thing I'm trying to achieve is to remove pp fields from struct page,
> > > > > > and make network code use struct netmem_desc { pp fields; } instead of
> > > > > > sturc page for that purpose.
> > > > > > 
> > > > > > The reason why I union'ed it with the existing pp fields in struct
> > > > > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > > > > from struct net_iov so as to make the final form like:
> > > > > 
> > > > > I see, I may have mixed up the complaints there. I thought the effort
> > > > > was also about removing the need for the ref count. And Rx is
> > > > > relatively light on use of ref counting.
> > > > > 
> > > > > > > netmem_ref exists to clearly indicate that memory may not be readable.
> > > > > > > Majority of memory we expect to allocate from page pool must be
> > > > > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > > > > memory within the kernel?
> > > > > > > 
> > > > > > > I think you're approaching this problem from the easiest and least
> > > > > > 
> > > > > > No, I've never looked for the easiest way.  My bad if there are a better
> > > > > > way to achieve it.  What would you recommend?
> > > > > 
> > > > > Sorry, I don't mean that the approach you took is the easiest way out.
> > > > > I meant that between Rx and Tx handling Rx is the easier part because
> > > > > we already have the suitable abstraction. It's true that we use more
> > > > > fields in page struct on Rx, but I thought Tx is also more urgent
> > > > > as there are open reports for networking taking references on slab
> > > > > pages.
> > > > > 
> > > > > In any case, please make sure you maintain clear separation between
> > > > > readable and unreadable memory in the code you produce.
> > > > 
> > > > Do you mean the current patches do not?  If yes, please point out one
> > > > as example, which would be helpful to extract action items.
> > > > 
> > > 
> > > I think one thing we could do to improve separation between readable
> > > (pages/netmem_desc) and unreadable (net_iov) is to remove the struct
> > > netmem_desc field inside the net_iov, and instead just duplicate the
> > > pp/pp_ref_count/etc fields. The current code gives off the impression
> > > that net_iov may be a container of netmem_desc which is not really
> > > accurate.
> > > 
> > > But I don't think that's a major blocker. I think maybe the real issue
> > > is that there are no reviews from any mm maintainers?
> > 
> > Let's try changing the subject to draw some attention from MM people :)
> 
> Hi, it worked! :P

Glad it worked :)

> > 
> > > So I'm not 100%
> > > sure this is in line with their memdesc plans. I think probably
> > > patches 2->8 are generic netmem-ifications that are good to merge
> > > anyway, but I would say patch 1 and 9 need a reviewed by from someone
> > > on the mm side. Just my 2 cents.
> > 
> > As someone who worked on the zpdesc series, I think it is pretty much
> > in line with the memdesc plans.
> > 
> > I mean, it does differ a bit from the initial idea of generalizing it as
> > "bump" allocator, but overall, it's still aligned with the memdesc
> > plans, and looks like a starting point, IMHO.
> 
> Just to summarize (not that there is any misunderstanding), the first step
> of the memdesc plan is simple:
> 
> 1) have a dedicated data-structure we will allocate alter dynamically.
> 
> 2) Make it overlay "struct page" for now in a way that doesn't break things
> 
> 3) Convert all users of "struct page" to the new data-structure
> 
> Later, the memdesc data-structure will then actually come be allocated
> dynamically, so "struct page" content will not apply anymore, and we can
> shrink "struct page".
> 
> 
> What I see in this patch is exactly 1) and 2).

I believe 3) will be accompolished with a follow-up patch series from
Byungchul. The previous series was 18 patches, but divided to two series
and this is the first half.

> I am not 100% sure about existing "struct net_iov" and how that interacts
> with "struct page" overlay. I suspects it's just a dynamically allocated
> structure?

Yeah, that's indeed confusing. As mentioned here [1], it does not
overlay struct page at all. It is dynamically allocated from slab.

IIUC net_iov mirrors netmem_desc fields because netmem_ref might be
netmem_desc (overlays struct page) or net_iov (allocated from slab), and
by mirroring netmem_desc fields in net_iov, page pool doesn't need to care
if it's net_iov or netmem_desc when acccessing the common fields shared
between them.

[1] https://lore.kernel.org/linux-mm/aFDQ9X2WsXszNJ5M@hyeyoo

> Because this patch changes the layout of "struct net_iov", which is a bit
> confusing at first sight?

Yeah, better documented.

-- 
Cheers,
Harry / Hyeonggon

