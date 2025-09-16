Return-Path: <bpf+bounces-68498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FFB596BD
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2281A3A8438
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354021D3DC;
	Tue, 16 Sep 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZ8fiS7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lKXPYdee"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFE2192F2
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027521; cv=fail; b=e8fegVI5c5HNVeRRzdroefyg568Km77mbtMsSgiAKJaRGeTENLleOKXLckPmoci+PTTq4m98HG1sCWMgKZM9Zwmjhm8KvHQ8SdntH+VsTpymQrQaINFgLvKbZlxn7euCN6lsDuYXZq4T/YqkOz5Geg5D/hpRjUdFWCKSHDFzegU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027521; c=relaxed/simple;
	bh=c02CB+pTd+fprB3JeLJ/ITJpicu4hmL5gV8iwReM9Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YgZr8Bw2ALqUns0BBrFdSm4p1ND4+2aNq1T93qZh+4wYGplwJipNKDNV9N9HjodnAyN724tXwpgPNLeqdsk+o5VSzPG7eYylbFsaeeUxze9qmRgEy14S+hXOYM0TO4YsPpOfBJug3KJUSW/itNN3+wDkg2Y3faF10Ra/RKgLlEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZ8fiS7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lKXPYdee; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G1g0sj002433;
	Tue, 16 Sep 2025 12:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6Q6tOb7d3ErJfegv1T
	bPcWALzOI6Y8yKALqqkSlRwaU=; b=gZ8fiS7h7RyAbXDEPQoP1qrLK2pjmchPTk
	7MD997thhtbDp3+25psJ/L5yaka5wjJ26uBxpaa6KvGc8aoRsS6+DiQGjO7Cjg0l
	TMcuvk97pxxber4UNYS6H6jVwQPIkDNKWEJE5fzANfF64BoFmwMNNYDqnhcOO9DU
	ebU0zMztDIFxO6DBTorE8cn5+YcA5MczzvQRBt28AcNbW5IYB7pNqzc87T2/iXnd
	24Zu0AufUFvi99t1yyjNJ3yUGEdqA4venjtJhTwKL387IhmUqLIBxiR+nEbGompi
	UZS3BQBz3zivmqRibZ3MTEli8YtIUxV0y2FLeZvTN51C3z4OeDyA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v4hcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 12:58:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBnEQD033667;
	Tue, 16 Sep 2025 12:58:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cb2dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 12:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzLUSiwjfzzegXyAVPPl37/z7AgpjdipuVT724K0zTdhv9X6Oo6UzaqCN0uozyME0XvO7s53H9wb+teqrhlkWpanQn29xA9mpJY4z0uL4gXMDuiGD4r9EM+vUL+I5cT09pta4ZRJil+6QqDFSct7X1zKX19YX/xaJY14lLBV1gtUQ/GwCTEYgvo6RvAKn4B+aoHlpR7szIbuCtuZqEuOfpkVLbApFrHpTr7YxMWjbS718P85X8cTVd7gjwYQ4Vp13g3UvBLYXxkKfY+p+DXVTp23kpjqhHuUPUmeNJ5j0Vcji0bUkV8T22US2FDTITjIftbjZaot5AmKp2g0CLe7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q6tOb7d3ErJfegv1TbPcWALzOI6Y8yKALqqkSlRwaU=;
 b=OIcXKI/0OAzsOIRWdw+9Xp8H+sBQ2EIAIHFMbviaSKa1GU20zOEMvH5aSQG7sIn1Jb99kLqBNLwm7HJ32gzI/kncO7htwtOWEDxJIU7/ND87g6cFbaQjF28wx5n32xUqsKZAww8qqJ0OWFMhFgbmo0sBMgwG4/lcB1QIt4YQUtYIiYszCN0ek72zsJDaDVruZ9/SWckWZA1Eej0CJ27H0nzGlngGmtlS8X0z+kxILccP4pcIRkf6tZyrFVulvTmHr+JPOVcRaUrvhU4d/JNuvz7fTAq9DUFoJy6eIWJvGy7mvKwCBIxXOE83xhwpomlEMZ+0ZZCT8aCviOcO3hUDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q6tOb7d3ErJfegv1TbPcWALzOI6Y8yKALqqkSlRwaU=;
 b=lKXPYdee9fgfVNTQTFb5slnubrCh9ZnfgL4PWxvZF723XjD8Tq1hqOA6LWrri9Q2t8tj3mdHHFpKLiG1cmi3rAUsgDH9YgmFLpmz+z5W6fGkY7M1Hych9b/lu3tQaw4jCr2jU+WEInZoMS4FrNumq1vjaQK/59svtHLwiRGEp0o=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 12:58:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 12:58:13 +0000
Date: Tue, 16 Sep 2025 21:58:04 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, shakeel.butt@linux.dev, mhocko@suse.com,
        bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
        akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
Message-ID: <aMlZ8Au2MBikJgta@hyeyoo>
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz>
X-ClientProxiedBy: SEWP216CA0066.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: f101fe90-5f67-4df2-e09c-08ddf520b1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E2nl9n9UAB5Fmc83G5UdD4NM+zuQK0VP5y3JBGBLCOpexxxcs5fMJhfiKrHk?=
 =?us-ascii?Q?/i9CAlZUxqlueZXekFbji8EkK0bnJFlXBNTwZxP8RrEUkEGkIZZ04Y3wJFRg?=
 =?us-ascii?Q?0qkKuWMGiG/PHvrAxj9mlkPNw/HMx2YQVCuaGLaT4bOVuykglNrure2Yezy9?=
 =?us-ascii?Q?vzMX8SH89DNOW8Uaz0BmAGJtABu2fKX8LIGIfL5DZANx7rzloOIiJsr/wpVG?=
 =?us-ascii?Q?W3/9ExUEHxv5/IofAoMnHXsOWhEtE3k3otBsAJBgv1E9AlsMb8RT5S8WDyXU?=
 =?us-ascii?Q?pyPvUXe9Rtx2lGWxmNhQtGxOhhnOUyjJ7INp9rxVc8bwahXDMnbxS3FrM4Sj?=
 =?us-ascii?Q?143AhSk3Sl7VXRyBxeEGGdF9HBU9nmUmXuvkVM4ZiFfwNjeNaHL4nL8N+GtO?=
 =?us-ascii?Q?ZPA4jAcIdpepELmDmTTkPAfDLCERFukdb/GfMl4wARPCtoYc/UT/JlglEpbr?=
 =?us-ascii?Q?vA7MaE+rdxxpojO0t+yAZAi5c87QKFpVnrLP40WzIrtkS2TcfNo66RrGJCjT?=
 =?us-ascii?Q?OmUZlJZ4Z9c5ywSsr6Z1IIrrCITUZtJ1+VitsgVBCa4/dzPuLwow5KC/Fv5U?=
 =?us-ascii?Q?ZVTZQdgJ7yXqL01y4wyKfsQcjmRyGLdUC6zduvGER+x2B0jLkEo1HE1xTEWA?=
 =?us-ascii?Q?QIPz9ECRYh3lIa2yHjHIbyidKO7NtViAI+DY8lVFyIS520q6iywGyCEWTeM/?=
 =?us-ascii?Q?PVUlbdajulZZBBtuZaqS5waW+iRSeTDn0RVn99PX2JRsoIf7FLxUja/88bQs?=
 =?us-ascii?Q?nMdCUBEcqotLCVa8ChVpOUFluN5PbcO4H70qE8e49RvjumY7Pb/pwwy2QXpp?=
 =?us-ascii?Q?GaoBfZIb5nU8K342Mp6TN6itVR3nMkwKe9OFRHB4D7CtAH14rVA2iRklSj29?=
 =?us-ascii?Q?XXkQMKbPqojY3cTCajOkBrXg8aqRGk6TZpTL0lmTbxgBjQCouFk1JQpaxU+S?=
 =?us-ascii?Q?XSLieLUnucNtFHaym1AxpTrw+paHgEI0lxvfLYS+EK5Id84M20uAgl/YLElZ?=
 =?us-ascii?Q?ija2pZP5fNAeBo+329xe1dvHK1B/ByhQh6TSd55lfudzxQLJRBHVeHfdMm8I?=
 =?us-ascii?Q?Re0r9+Z9+8zN05yffYl7FiqgdYWyXMwSq17vNen1/CgS1lsVeMHF3xunkgSG?=
 =?us-ascii?Q?jvMeMJzLRib9y3oVEU/s1Rptc8u3u7zWEWfHgWnK0NyQMJWFrDRtHc/NXcP4?=
 =?us-ascii?Q?a+wipMtVqnv4Icnbh6x0ojLEekBPZGR5DBpqu2LDCnBzoELly191DwUJIDKV?=
 =?us-ascii?Q?DGnwwQJjTJBzCTxqDsZBY0rh8B4nhGuwH3RXgwPzXUf3jYQEaw4pxdloqvRJ?=
 =?us-ascii?Q?NuS5gnbzy1Xd7aj3fffmkARHNrsvPZUFQ6FeerWZKbPDxhw7oHmM3BV3/XB8?=
 =?us-ascii?Q?0FyuKOE87PIBzqWK8uWG2VAfBz8CtOb+esp+ACseSSSQZ6dl53Ou1hWrpQlo?=
 =?us-ascii?Q?lryrnDVJIJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1uyCROtG6CZ6JY9+lGkFk48nQopLdnITzDELrmRtnU18xgN8a7UNcsWoSam?=
 =?us-ascii?Q?Jb09TOx9nQ+2m4FNno61qhCckV3HnIRMl7lmIgTRhlOEgzM+zx6F4NX0bNrs?=
 =?us-ascii?Q?HP4gjiS1NizSwhfJiKTIthTzQDXZh1KnuWXrAnIpt+vqVUo8ThmP+KqIylXo?=
 =?us-ascii?Q?QWiO0BdjYCSLBecqzaGuPrrp/dAIhibwEA/fU0HXF8hJCI7KJA3iYyYlFNKY?=
 =?us-ascii?Q?yBsdWXdpA6aiwOIsJ28kcl9jOIFkBznsHXKOaPf0oZ/VWRjsTM5qBpBQNaIJ?=
 =?us-ascii?Q?NUioemxD5KtPD5uNbG0SDeGoaOpuOx8ucWVGUpCwLvk3tATD+5/vZnkJgxMk?=
 =?us-ascii?Q?sbeb24IP6+umth+RWtZfV3hEMMczhWSmUctCZ7uR5+ArPEq+svG7oYGTrREI?=
 =?us-ascii?Q?MG10qXx/6UcDEm2JptqO5acn9d93WllGKb7AMq3uAaNRcM8BNil9A3to3I/H?=
 =?us-ascii?Q?hxmJuVmwa/5cknCwNpThXRTAloFTECieYmRtbGOsGnpQ8qT/MAsbmimIuvHz?=
 =?us-ascii?Q?Yz/vPLOtW+XpQ6E+wkjyxLEWCCvzzzD1GVbui9YwMaHju5l83MPsWAgZl5bC?=
 =?us-ascii?Q?WiwBNborJ7+dF+YMRsI//OGya7E6nVofFBLNtsEG9xxorBrpBWFeVDLoDsC5?=
 =?us-ascii?Q?ALgd+++aqsbrgQmfwrqOqcnILbkNBcr1n8lSz3W8GJPzq1mf1RYUGb8tEOiy?=
 =?us-ascii?Q?4kjyvNj5UMqR3UNk7ngEIUnkzlfOFgeLXQe2P17IGYxcpi4X1cEKEydLdW+4?=
 =?us-ascii?Q?0T+NdRs/bxef6XXtapNVtT/7WCaP3/0ktjCJyh6MkX6DpFhLimZyU944ye+D?=
 =?us-ascii?Q?ks7+KPKMzSaIfzrW7U+XYkOMVTDAKJSbw+tjxN8tye3T8gkA6+xF1E1hdf7p?=
 =?us-ascii?Q?jFE8cMh04n9AWjYf2E+otkHANmFXuEYps7gtWFM/dc6jGM4frkNW4lURf7Zk?=
 =?us-ascii?Q?DFnqZ3dfc2qRL0Ganpu/xsPwDQ/85iEC/UdxsFWcBp0JpuAwo2qiyklANae8?=
 =?us-ascii?Q?lh4vA91apgvkmlkVCTPOcIpsvPQ4NQ/R8/aceaT9CQGiJUdRqG7Yo5v9yrkb?=
 =?us-ascii?Q?yKmi3gEuvPtI8wi6QWi793bSzbJc/nA2hnfDxeKtPKE0ylplJaBia6PqJqdI?=
 =?us-ascii?Q?03WtR9vGCKcH3dTy1CytE6Kba2cmhIUjujsjp32Vv/edYSXaNee+Dl9hgGmS?=
 =?us-ascii?Q?/Bdyb50wJWG2I0Fa/c4jyIFsYbHzdM9CFw8qK+8zx+3Kjy2EM0mKpCQlztKp?=
 =?us-ascii?Q?jbWbpy+hBBzHMstJt9J8Ct8mMpDfaNrIPyRFFjzAuCvU3BgGKHTK2zNkuaGW?=
 =?us-ascii?Q?FJ2yaGzfxWTO5r3TXYeMT/HY6Yvbn0AgxUKwp6jGSwl5pC6ntUeglkWl/3ZV?=
 =?us-ascii?Q?tSwCaxXT16W3Zkzdi6pn7yQTWQp7HPzotvLFXzJ96mNX0l44f6KD8FSj2S/V?=
 =?us-ascii?Q?RiUhOl4B8teTBg4VpPAgJwxAfa7c1JwHh55g6KFzarZrAqLzpbx8G1YY5hrU?=
 =?us-ascii?Q?o+wmoNNqIPfig7f3NVV0njtZpBPGC6nQNsi2QjUB4Bn+tjh2gnDIr92W+jDA?=
 =?us-ascii?Q?2jBxXcQHizQhaLXSDwfSQK3QIOquYBwmS3EJ6Nlm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GHB2PJ+BIlorYsBazx5NdiGxEBHb2BEdvIP9C4M+mNs2HxmNxZayllapaCpkusvQD5xDmgSY3t7NkSUxrnLjABNgJbjJn6DEUVZuV0MUdB2Bfi1NqzPMAC3R7CRvY8pCaM7ZSrNkBpWGBNV1stgqxA7Lb+GiJolPZuoOMtY5cwrI7VMLI3Fc6zUoOAJJ/dY//AMclW3OBKf8ZMH5OUsnqhspm67bt6vjFTMvvjdjBX2wom8aEJs8x/X/Fes3CbWkCdEtY6B3OVYAbMl92L9Nfwlc2iSeCo36pGBp/Q2mfAvpTJzeNTfxlOiMHPS9bh/K7HTSQy0iVOJ9WcxKVjQp86AeRjch1++KuUSJe+LVPwHuYacl+N2dV+l34ch3jjFfTxt9I0uKpK46kJQSjEXE9f9gXet+4tXviYbD5PxY2NfMbpGy3ob4dmed7e8BRuUzBrTU39lAi+wsxdiKOMx+lUUqcVUP/u5Kcl3biMAcnVZgHH+h+uQtWTrCARy0B7qHKJP3C6T6icb8lYNSmtV/KbHPy09aJuBiXUnw5WBd37zQElB80frwZTCjT07Uiy8UISWXIYkBvBe4SB1bPZxUPF00EF5r5e2OuEBzqekryxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f101fe90-5f67-4df2-e09c-08ddf520b1e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:58:13.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MG51v/C0+MZElZrWDFOJvolanm2GIASIyCyyno50gA5CDKKnGSlFLLvsfhsWjUOFR7O6VyyXpTLR5BHV3Hclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160120
X-Proofpoint-GUID: GhsGY-NOGkfracihYLgyFpYyH8JgR8ZL
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c95ee9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=sSRawksTRETSTNy7ju0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfX55I2JvMpYJQb
 N9uAB3YejuGBe8GI6CgZJgivdA39lSAH88Ktx5yDQrteaINp5s3Hcek0Ugc3xA8/gkPLhXgwZF+
 XgUSUPp/useSIjHcP/19Me5sMmNwJb5jOkzXaXQtUBTgRotlaK2IZlWu8CMdSO/ki2qAbSOebB0
 IrIwQqUSflQp1ST7yvD+O/KHy/riumJtn0sufGaS+RIi/vkoOZ9YYLr0R9dBQhJAdcll8bfLLQx
 E9+GDvMqMCgF5km/tNChhR/JVUPvzpneIvPTF658NJ8MLlYEXg6Rcc0vqAzPvTlr24uQyqvs3k+
 nTl8fgnAJX6liz5yk8JQgFcyCDx5jZSgFhy0JLuuvrTOaPVyEMIhHvdJP7gjjejRGOBDDLAY0d4
 ednkkzoM
X-Proofpoint-ORIG-GUID: GhsGY-NOGkfracihYLgyFpYyH8JgR8ZL

On Tue, Sep 16, 2025 at 12:40:12PM +0200, Vlastimil Babka wrote:
> On 9/16/25 04:21, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Disallow kprobes in ___slab_alloc() to prevent reentrance:
> > kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
> > kprobe -> bpf -> kmalloc_nolock().
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> I wanted to fold this in "slab: Introduce kmalloc_nolock() and kfree_nolock()."
> and update comments to explain the NOKPROBE_SYMBOL(___slab_alloc);
> 
> But now I'm not sure if we still need to invent the lockdep classes for PREEMPT_RT anymore:
> 
> > /*
> >  * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
> >  * can be acquired without a deadlock before invoking the function.
> >  *
> >  * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
> >  * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
> >  * and kmalloc() is not used in an unsupported context.
> >  *
> >  * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
> >  * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
> >  * lockdep_assert() will catch a bug in case:
> >  * #1
> >  * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
> >  * or
> >  * #2
> >  * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
> 
> AFAICS see we now eliminated this possibility.

Right.

> >  * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> >  * disabled context. The lock will always be acquired and if needed it
> >  * block and sleep until the lock is available.
> >  * #1 is possible in !PREEMPT_RT only.
> 
> Yes because this in kmalloc_nolock_noprof()
> 
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>                 /* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
>                 return NULL;
> 
> 
> >  * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
> >  * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> >  *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
> And this is no longer possible, so can we just remove these comments and drop
> "slab: Make slub local_(try)lock more precise for LOCKDEP" now?

Makes sense and sounds good to me.

Also in the commit mesage should be adjusted too:
> kmalloc_nolock() can be called from any context and can re-enter
> into ___slab_alloc():
>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> or
>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
>    kmalloc_nolock() -> ___slab_alloc(cache_B)

The lattter path is not possible anymore,

> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when per-cpu
> rt_spin_lock is locked by current _task_. In this case re-entrance into
> the same kmalloc bucket is unsafe, and kmalloc_nolock() tries a different
> bucket that is most likely is not locked by the current task.
> Though it may be locked by a different task it's safe to rt_spin_lock() and
> sleep on it.

and this paragraph is no longer valid either?

> >  * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
> >  */
> 
> However, what about the freeing path?
> Shouldn't we do the same with __slab_free() to prevent fast path messing up
> an interrupted slow path?

Hmm right, but we have:

(in_nmi() || !USE_LOCKLESS_FAST_PATH()) && local_lock_is_locked()

check in do_slab_free() if !allow_spin?

-- 
Cheers,
Harry / Hyeonggon

