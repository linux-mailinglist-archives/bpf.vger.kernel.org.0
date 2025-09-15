Return-Path: <bpf+bounces-68371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17914B56FAC
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 07:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D854E1259
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 05:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD5191F91;
	Mon, 15 Sep 2025 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G33lIrTV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qj0TTQQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC76FC5
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757913554; cv=fail; b=rMcXcsWwgLkipo1IzT69O/J9iDRD5xuLB7GkWFqFn7BAGP3jEBEN5zmWQosbD2Qi7s1gygzsfPOMZH6WMj9Rr5o7tFo0MjSj7VxmoFZjTjoN3pES0gL0IjkS/mABKiptgxHwAw4JXHmAhIjxOPY+Yqn6j2yA71LpQEVD+av3V8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757913554; c=relaxed/simple;
	bh=rrz41nQv6uLM/elzprcxj67RlxLfNmNzlZUhkGjhy+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SiFLObleggxsERaTGazJMMx1XMJiL3orBeM8b6X8wXSnkIOpqbE1buqP9k+cun7hn4KofolFoRvnraZbqI7uPv0JWz3s5GNWwj/wHGWn8Q12Qu98T3uMqTARHfnADZwbuBu9Mm7ij5hw9PTkIuchsXapqOIp1LKFcEEs79Z3jAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G33lIrTV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qj0TTQQ3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMMTvC004453;
	Mon, 15 Sep 2025 05:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=H7xT36/FlECK44tmRE
	99CDqgRqGXpOpdi1z2nf2Z+oU=; b=G33lIrTV96/5Yvw+U1LD2AREIG4Ts44FUa
	qMSVdXqZh56Q4dwTpBPIYWGkBZhZKBS/yi4+B5jKvNF/i9V+i39l5qNbZ82yqYMV
	8RvXC0IIdcLlcbXM/d1gW4ORODKOaDCu/MV06dkFJp0ffCehXUvVpWVvkd+jtbc0
	IN80ACMoodaC6h80aG9jzL5XwzJ2iHx3jmqAOUGI7zLYeSvPXi9xYVX6sXniHIju
	Ce21S2KRxgSDGHTM5CVh34qziUsPVaLrUt9n/LusO1HUzt1zTIEe+yENCRfIlVqk
	jkFVpL6v5YzKAGU/NjBfoRNHdTWSPHG2Gzec15fU4ak+cSKIy5pw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf1hga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 05:18:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F2xPlw010579;
	Mon, 15 Sep 2025 05:18:26 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2aht59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 05:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIAmD1oG11xLNNKfQwcliDwYG+SkAoMkeSOd8bMn4yRmWbadoEFfxWEGQGC1utGd4DEHXcE5o6IKg7MjMq06cwvjQh1slPc0mYakLEiutcBXVj4mY3F3nW8FAQH8l7tRemztKoOBHNHpocmqxnlt6JoyXDzAdYdWaCFNd4kglzzbX4C4EQgimK0XrjTUyZRF8gWBRq9yFgfZgAajSACs/MA74iUv5VkXCLrBwejPnLdIwxL5rAsqGy+mCB8B5yDM0blJ4fX5I8LtvxqaR1NBc6S7n3d0pTl+lFWPFfCiTIKQFnkDXsZiEgbnoPQkn/DItl4E207g3HUpkfe7exs1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7xT36/FlECK44tmRE99CDqgRqGXpOpdi1z2nf2Z+oU=;
 b=PfjSPDsmDux5yxLWad/e+S0I31qLFtfWPlt7OwPL6/3IhE2c3dtstxNOUg2oLc4bh0oT1L81bhtbg2+LqLrWrEVhCGOx77LhSPsaKzLQmFa6e86gE1vL49Jh3tYXxJyN7ewjN6ywhLeo9gnlRhSjIvwKKnJf6/GAdB7ZxBbTz6iDnMWfKpoOVvg8vAT5fCu45ic8wOZNG4VnjnmLDuTfQ0590rE4106lXj2x8gsFhmte7w4r2nntATAMGFK3225trW1hSwNz/oDD8/39otT+Efer1rrlnylC5BOcjmtvbZk7AARRvVQ2BMjpUPb+xG9YJm+QC26lcHRMVi3NerLU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7xT36/FlECK44tmRE99CDqgRqGXpOpdi1z2nf2Z+oU=;
 b=Qj0TTQQ3cVdnb/4/QhE6PdwL+/cuinBXNe3rpztgC1NRgR6RKXUODuhJvwFX1vaur3USK496aupmhQJVgxoJXxfA1ZFt1Om481gNi0+hx0sxEvDd+xZNMKbrRsxKMwGIEMToBpA822P397MgQP42GG7B/fTHsWSNv73MMPMULq4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5142.namprd10.prod.outlook.com (2603:10b6:408:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 05:18:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 05:18:07 +0000
Date: Mon, 15 Sep 2025 14:17:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 3/6] mm: Introduce alloc_frozen_pages_nolock()
Message-ID: <aMehhq-Ylvv_Bx1A@hyeyoo>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-4-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SE2P216CA0083.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f777aaa-f72e-4b5b-f716-08ddf417416d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iEyp8JhoZIxPyjNgKusvkdSTSkdmTovcdtIZqEsWjWHMNo0rsrfNCPFpVOP?=
 =?us-ascii?Q?5jK/xQHCRbIFNcC/na3DddrzVZWEp5r+anmh6XNf5ZJTC1YIliGkXeUAHZ0H?=
 =?us-ascii?Q?5c6vK/XWGIV8xvlyYUqq+0NrzugcunWqmiDxwTmyJ9Q9MLCX4SrTyFIHVLRW?=
 =?us-ascii?Q?OAC7RoWLX63DO5tBlHpSHKMrsXpsemfpjZ9gsGZTEtgYbcc3WzJIVqYAnLT1?=
 =?us-ascii?Q?7nJMTzdqp7a9NObgHAwE81nAq5FM/xsvSm2RGS6v6+0uhDoEqCLabV62R7DJ?=
 =?us-ascii?Q?Fwdtfy0sSrInh+h43Wk6aXM5UC8UA8BB+XowN3+OKI/z2KfZEivw8wHuQ0Bq?=
 =?us-ascii?Q?vdTBICVAY61W5yYJeXnWYuMHMscYQsZckVBw2E8j9zTTzqZNUKuhyVSUTyI/?=
 =?us-ascii?Q?T/+pf/QLB54BUVkEEEEPaaF5wWAd0NgfElcWEAwPnSwSst9lYHnHyMjUZFBb?=
 =?us-ascii?Q?bzpilsuCxhd/KX+WdCXlJIXNmaHFzZWPk1VKFJ7VmdrlcsKa3VBgeg7TsdyN?=
 =?us-ascii?Q?q3F3xc7Nwi2njrQXexQhdxrKcgQlipDzmfLHcYW6Gw++cfX9MFl48pgpgQqR?=
 =?us-ascii?Q?GG9jygZoaaTB921fBfP+UDCbNmIseJtt9M+RX0fi6W+HLicU75rMV34o9at7?=
 =?us-ascii?Q?Mux91dmKmVSHSr15d2lEZ4oLBzd7m1z8S8+mT6iGRp4xoKGSLkIOIz+t5uxi?=
 =?us-ascii?Q?4UWFQQmy3IDeAVEr6JNpdCMtx3mxFkYRiTyV6rcz7XHFAFJKYo8LkZ8SWVAJ?=
 =?us-ascii?Q?NRcz7rbbu1rVdQbn1DHP1i5QmPvcNQBrAql84G5K1DHqnaJhnIuP+EbdGrzv?=
 =?us-ascii?Q?R6O6dWFITH8WbgGjixKf8MG9xYv8/2YAqfd0yHKoas/tAzNdCXspg3fnWIpW?=
 =?us-ascii?Q?ApHuShFn0Z8ECym1UHlEiOzW++HAxDhSPZzVQNFQA4fKe1qx4/vKnqnEAwmi?=
 =?us-ascii?Q?rMk7iUOYa/XENtaBHpyO8QcYj1OkXBLHIQg7adb6sGT8TJz9XpBPuhMzq8mu?=
 =?us-ascii?Q?KKSme1Ehhdjcg7OCzXsml9a4XBfbDt/6HPUfevgd8T0YwuUVZbz+/peqfoYh?=
 =?us-ascii?Q?gHIiYjzB5cOsy+bIPTgOu/5wFRcS5TCmiOkabrG/K0uQ2kE4W3FmDc62VmFn?=
 =?us-ascii?Q?kUFbATbAaU82/2gnA3x0b4RLYmrgFELnYJvdt4UmEvtpV4QQ7rHJw+54+7UH?=
 =?us-ascii?Q?vXiNIVoC6HJxUCze3OcqvpsIgUvc5+vxMv/rdCMJTG3OrPJUK53jmrPHcQkp?=
 =?us-ascii?Q?+nKzW+ox0tttEfavABR/qq/eCmp2jLL7kKCadyRNbLuqcNt6wi8/022gDfc9?=
 =?us-ascii?Q?Zwt6RaJr7yTBw0X8YbEyjCv1pYmySMGU9oO08ZulbWRd3Kq+rbj+JONS1vzJ?=
 =?us-ascii?Q?ACF8eVa+c4H1jvBmxMys4kbQ8+ZCGsbI7TGbsFMpCGQDPxuyuLcKQZfx7quX?=
 =?us-ascii?Q?YBjpCaKSp50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TEv5Zqsdl301I/Lysnc24X91XVx8xMBiux7j+RWzSIi5Dhg3jIJsrmJevDo?=
 =?us-ascii?Q?fPBgyZvD/iF9Zc5FKn8k4S3RpbVKWMRqV6RujoYkroeR4tIrD9KeN7oFodl8?=
 =?us-ascii?Q?lzzgk5gmum29vtuLORxVO/CtiaJxZK1oMOh7GbzkV5yNNYwfyU7F+5duaiVj?=
 =?us-ascii?Q?vw+tZ5rYtp0HTbzPGZ8pzcXOYZpR8iDlC6DrUNQzIW744LpSIbKFEpCraP3A?=
 =?us-ascii?Q?1GRyzKm/lU5icrdSfx3mlPZ+uPSCB+Sl71AXVjwGt+rRvzxfeVdZtFy821DC?=
 =?us-ascii?Q?RmbUBETtwymXNNDSN2JjxiZo7CWeMX6zV97Dy07ElzkqHYYXkY2ppQuisj5H?=
 =?us-ascii?Q?45JInZuIzGAVWSLtSzDPygAzJI2kb9cEWrg8j4qDVrdYdUj9Fp+8QRITJ2c/?=
 =?us-ascii?Q?BjUinFJqSV20fplQvp2IWvcD2gEKG3PqlIShM6tQhYacMEkkCdPbtXmxO/rN?=
 =?us-ascii?Q?9rJwzmV/CQTZIaM8r6+WFxXkpLbAHJkMifF7o4xt4yFlnTePqhT7GyjQ7rK9?=
 =?us-ascii?Q?P5s8rvTdAwbm69JfhBcWFIuHNvXiJ5Z28wijAsyus3C+0VTekptpy38d7smg?=
 =?us-ascii?Q?Bz7lNq7V8LDDEKSd3XNd1pVgE6l55s4xVD2ijFxIKOPXVzj1Q1rwosyLlklU?=
 =?us-ascii?Q?9f9xxfS1J/TWbpYGRE9hpRcMoZSBKt8tZOwiJ0eOLNB0QXu+OboVDYC4+Zqf?=
 =?us-ascii?Q?awYUJqjw11OScSsj/8YqHtpfJxLLxTYgMYbMtWUebCyjCGQP/wMfuDn3E5gr?=
 =?us-ascii?Q?I28XS1J07GIiSElKV3IL48TiHw7g0DmgyqmHRdQplN1o1bEcMsQaf8rbeMjX?=
 =?us-ascii?Q?WnZ+2D3/6PQS9qaM5TSkMdQvF/pDCfuxLxAR2qBFYHZt3gLWw/WNiDuaMLE9?=
 =?us-ascii?Q?+hXIMhO/tw71crdGlKX8xQx3p5VfPfJPxqJ44iQP4O59LlqsS1RHdhxDa1cD?=
 =?us-ascii?Q?0JaDbKti2uMMbcqTJuuO1rwI4YDKI5YoOgm9Ajn6U86jMIcLeW9x6TccWpWS?=
 =?us-ascii?Q?zpeXk28E2qzjiwM7nKRn2/xz7tXuFkWV1IK41XOsKisdM3+O5QRJ5L7RP7U1?=
 =?us-ascii?Q?OOcIDVUOovn4Zpwt3fasc1SG36qMnQ7q7/5gddTLbgnHiL3nSSYrbgkcQtU+?=
 =?us-ascii?Q?ANQYBCxICrAa/CRMNTveYRjKNpIXH9/jr9QbsjbNvwsPSb9ZmHHI/ZKzEq4G?=
 =?us-ascii?Q?Ny8ABfb1phxNm27QYO+Hb7XcNCdkxHvKtASHQQn8DMWMLvrUnW9BwM1kQ5GE?=
 =?us-ascii?Q?DbTyP9ZSG5B/dGGAS/0dfgigCA/bBs5EY05+Gg0DLNsh+daK/8aqqBQpIqlC?=
 =?us-ascii?Q?Av5kbGseN+8AGt/v/w5NFKn5jcU7yqwHZccRknfqygbwt0TtZ+weeAhLpTtW?=
 =?us-ascii?Q?o3jWGRCTlIRkK27tV8znSZznoOx+HBUW+qy5EeKAPurKdhJUTqGCvKEW6hBZ?=
 =?us-ascii?Q?EUnPowr6ns9/rxIJvISE8WLrUivVI8gd3MTX2uvGm+NeNcPQXziuiYA7KRPm?=
 =?us-ascii?Q?fDkZXIQJt6dlbB8aD5p0XL/Z8UMqM8J9XU4or7POph4sYqvaam6JjmmI1e+o?=
 =?us-ascii?Q?Itfbd8Wf6fN3FJm44VcyhEySmkjp0C7vigjhNT0/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	woqW2WRAtuisPZg7MIB8yR7Y4NYNjGFGJ/VTvsW9Qn3DXp6+eegGT+/i4Y6P+FgOGw8oaBMHQtK100eG65wKla6dwstqWAWYsKa3fRkOk+08UP/t1IVlN0WDjZbVcYPgy/KU0b4md3czq1MLmf0mk+QWO7uh6VROzLoJcfHVWmAHndjf7f/3lvXLoJx5pxEPXaW4HpWUlMoG/yBpv4Q7O0rrkl4hnnnYdvcH6tNVXsX6Tzh+MEU5aO1SQ1nmOpoYA7Jbu9vDJTz/p0kBaACzMXwh8EyOnUOV9TqAtjruP5j+gFKfHAaaO7chaTArKHZ/P93lOcrvvBXvLy9itxl5yTp3kU07Gaya6JidRjgdW/fTwxK315/zPPtyZjDM2X2ey/FBOruVPWamo7ZAfyQeAWry/WaF296DrzfJCr1DPe4gwKOPVS7WJ6vpNUOSwhmLenAxRQPHapf/C4Q2vwJzm72nJRUL5xOD0W+v/hNoxXjwXyquQUHwPo2jc/NP/kbWmN+b+YygpiUOsJNMMJjZ6MqMaso4bw48bYvYW1kvao236Ga2OwmDzUN6VWMQcNdQCditRXQmxIz08/ncwQjXHua+IoCa/z6s0mfaUF3k38E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f777aaa-f72e-4b5b-f716-08ddf417416d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 05:18:07.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhapOkcflluPuL06GSD21Q6bkAoMedwkHdrgi6bgHnjbZIOhb0WYZXyVSemS7B129lVPYfoSC5LSpTkulhGApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150047
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c7a1a3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=0I_QyTRqnXRa98vpweEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX2kY0nm5GLWpT
 lH9PDepBS/RwQqRmY99yqwC/fYF5K4dKHg7DPRdfmnlTi3LeoqKg61nxMUBsG//+TDajaKv9meD
 QePuJ4wLhiKScaM6LZgFR4TZcXgYleRoo0F5Mj6vMMmYgVeMhQmRuizvoYF0lRLSMFUWzssV4Wt
 VXcAVNpTByKt5e7w3p6OEDZD86WdknY14LwvqvShLrTjjex9eh/qngXt/WL9tRwyuJQ0XZPbTmO
 1CrTIJkN+lE1sPXv0xFAqNI3lbYgM2gE3+DhufUtla+Ht5EjDqT6KFGaKsgWrc1pRJNjdtdhUAp
 d5Z4B1amBvzyivS1SlyWYK4QQwAyE/vKJix1/IK39I5UBPlWIfPZ3sSVN+TDFlU2LafT+/8j4E2
 QbNdGf2H
X-Proofpoint-ORIG-GUID: uJQVPCAJ_a_Q8txSCSCDtRwOQlFVfweY
X-Proofpoint-GUID: uJQVPCAJ_a_Q8txSCSCDtRwOQlFVfweY

On Mon, Sep 08, 2025 at 06:00:04PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Split alloc_pages_nolock() and introduce alloc_frozen_pages_nolock()
> to be used by alloc_slab_page().
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

