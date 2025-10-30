Return-Path: <bpf+bounces-72944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75CC1DDF2
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46A24E4071
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A2126C17;
	Thu, 30 Oct 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2OPMs+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JENtYznY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42F1C695;
	Thu, 30 Oct 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783129; cv=fail; b=XIBY7S0c6HVNgCXUv+uDewgncRkzpLWJ9PJbzm05SfalKVYt7dIf6/gQ+j238GA5DUIN4/Vo4G1+PFsbul7aeDlK6Ci2tPBFlzBhDdwBbs9Ytw17pLR4fwUp6rKOylKzS1EFzWJu1VKlr5xU5aeA47dxk398ePUEjbqyHFuvRsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783129; c=relaxed/simple;
	bh=MH1xmUsn1tJz3n2O0IxF4Mqmnq84/9k7k9JT07MFxEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iBEza9tv1kLj5KjkqCWY20mLNsx0eFBryzgodpuFN64WoUk4cUrLLdkspC+4qAu3toV5Jl/JlftXTOvBUKzxN1tuHWPStLMLKhfI+GRVERRLxF94gTeA/jOmX0nePwGOoPuDVqPva8JBPyT1EFVzurcUFkmovEqNNwkoKpCKlAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2OPMs+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JENtYznY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TKKIPq009170;
	Thu, 30 Oct 2025 00:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nWujrSbK+qE/62mSvU
	XPpUtLa6fvNP5eUMLJm7HZMZM=; b=W2OPMs+rFOglneQtOiJDK+HgKNr1n5Sazq
	khgwEkdlz2yeUtVdMM8kJv4FG3Pp73TCsRZcvcK78h6n6moBdF8pOa+uFrHpXeBT
	s32M4yntoWx10it6j47HjOsPiCnTqpBLUqWMjiER9+oilRq6/U/E9uEPt9B5r2f/
	oXurYYGayiLaSgZqKROoU+tWgn/8nqVV8TqxVFP3f33ozuDJTCL0GKIGJ56wVxzt
	vgNqP+ORegUDeyPij5vld7/glJq9+0RMr8dWBLZMAK4+fCzEStLy0bwAI9VXhZlt
	eguvr6c7JQMx5hhUMbvvzBVCuRLAdxNwSaQOyM/s5TNr9hZtMT+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cv9afxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 00:11:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TL4BjW024351;
	Thu, 30 Oct 2025 00:11:49 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33xywm99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 00:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOKB7AHholcoHGjqIGglnxKFdL2futcn0Q2aNjXM+6g/jTkn2toqktYfZ0DJbKEqUu6e/cxKnW4/1Gpp26GGE2tDIU08QyWf/8nL2y8YqA/7puDwBII/mZhpUqsN55HDqlfMZWl0a9n42iMI3vPmrfLBIcZsBWsWhRnLEUhdGk4Gem8Aw0ZSAVTXCz2lkdJqWk+DqkNxVSBGidQQk0y1b2OuuPJiu526+AcBZ2Gz37fUMm+YchzEvOE0OteBeUfjGhlaYkxTDdjDn5wQ1b4vQeDxHGiQPYTbJu5Fv4Au0KxE8S7qFw3k8ExxYmdShnftzF/iqvtJoGe3Q+m+koDGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWujrSbK+qE/62mSvUXPpUtLa6fvNP5eUMLJm7HZMZM=;
 b=OdnCK+3EtYvRtjiv+orMFLZbhr96aw4lFSjSlIVtpjPTYHhdXiII4a5jt36dpOVQ+UqEigGXuubCeV3ldpH0a6fL+E9m95k8nuVt4Vrwfue3UAULZVf+B5mbh14i1AReia4+qzCLG45t2ea4Ni1JoDDzdqD2fsVNpt7M4AO7hCTN2LpClCe4A45Z7fWg64chZNDGR7WdmzroZV3BFTtJkobN+ow5VWD6dT58FGL2UCMPpJqlvonz0rsD1mp2ZA+pnQM2ZI2chUUIDTWg6ZXaqoOYAgaNwFqLBSMI1xqaSzuD6HdkE2wbjzPLpeHe5ZbthcVRPyl/IUhKbf/+tzw57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWujrSbK+qE/62mSvUXPpUtLa6fvNP5eUMLJm7HZMZM=;
 b=JENtYznYH6Sj3w+mfd4LB53nzdEQT7MVq1YGik/hY6iH+kUix0VwkuuNEKRkVUfJHt0qoZHanZA4Qi33BsFq1PoXroMU5vhSXjvYrD91zKp752NDiS/P3Fb7iP/nX53SQMR6iX3oycT9FfrUHE5Hv4IhsQG4h95TNxmrjPVky50=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6354.namprd10.prod.outlook.com (2603:10b6:510:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 00:11:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 00:11:46 +0000
Date: Thu, 30 Oct 2025 09:11:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC 08/19] slab: handle kmalloc sheaves bootstrap
Message-ID: <aQKtOw82R5ONMWvM@hyeyoo>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-8-6ffa2c9941c0@suse.cz>
 <aP8NMX48FLn8FPZD@hyeyoo>
 <982967fc-5636-46dc-83a1-ed3f4d98c8ae@suse.cz>
 <3b6178b4-ee0b-46b1-b83e-15a0dadda97c@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6178b4-ee0b-46b1-b83e-15a0dadda97c@suse.cz>
X-ClientProxiedBy: SEWP216CA0012.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a12f45b-9ac1-48f1-5714-08de1748e9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ml3xS+FR9mInBC9keZpXOzjGkNjneqxI4Kx7CGSL5cYTVshBCtNSbLOnh6Yr?=
 =?us-ascii?Q?C7e7lRn5V3lKMFV2HLA65fzlVjpYi0HQB9pQVeksYCiKdxJY/waPnXth5JJU?=
 =?us-ascii?Q?DIq01gbmoJWJGadYa53GYYTUoIVl6hYzviJ3c9ty9ePz1HTy/rpD8jzJAuWD?=
 =?us-ascii?Q?YEJe0NTMBEIzLInlo9P7un8DMU4qr7H/oU+YvYyDzZchJbPD4X31AUPq3e/Z?=
 =?us-ascii?Q?d5924yYFZ5AkTAW5V0aZvRVp1SAL5TZd5LdtjePLFOF/wHQIYw+z2Ly9fSiV?=
 =?us-ascii?Q?ig2CuAcB7+8VxI9EL9AUK9t/1cjNSCjYLh13uvQ3ewXeJp2O08WFstQV4xB8?=
 =?us-ascii?Q?2zuWJgyq6rNe6qvRH4YJP42uAp5ZHUL+iD+y8e2E7GNizvYTFVAB42K0T0DU?=
 =?us-ascii?Q?p3TAqTjZ9Xs1GV8k2J6/+Q0hIj0FYl07UrYlccPcoXUsDt/aa8l1rD5hxmlU?=
 =?us-ascii?Q?pB5AIUmGNRkBoR4NRjhdGCXX16N8GRDZAHp/dYH4MG/7cr8kYR3ZTUm9rnqw?=
 =?us-ascii?Q?7zvDZeZ41zLxWvYj08Yrhsetf7DoL7HJ35sYUzFUYRG4hEkiZUkGCLEfX41Q?=
 =?us-ascii?Q?DqdEUwfS0M6nKaArm0DP63MFXtmgs1G2cqOR+jVQHrkl24LRmMx/k4pk5gNq?=
 =?us-ascii?Q?9jv0tesggrdSMkdKkq9fFB4PzfvAsB6jGvY2+1P4pQ5OSAvaUhMjRb6Pw5cz?=
 =?us-ascii?Q?8VcpGJEl+dysZXryFLSPkSV3bCuKM0hDrn1SL+ysth/v34r1cmDjeIbAiRiv?=
 =?us-ascii?Q?o68y6tNPQ+tqktjJ6uXMEFXxGdM7a75csnylK+jgHQnHyJoU0+WwnWX7StWp?=
 =?us-ascii?Q?CRSOtHCbQid3IKAuys3ZAHDKLzR/Y+zlASfjDKRgg6HxZbttGaoC4P8Q2ONZ?=
 =?us-ascii?Q?CI4PmTQO5JICix+FNapob7wmyvA2AuhnA+2rGBDzUr4IA7RZM7sdp+LX/5il?=
 =?us-ascii?Q?gYF7vlPZpEPQS464iVsNCzJDVZgNAq9WSyjF1l5OWmRP5+sLUThiXxb+vuVy?=
 =?us-ascii?Q?2ge5gLVbprEyEq8REdBXhIczrb64VvU7egTknrnf6ZLHhcJLWZ/uSlSe/ou6?=
 =?us-ascii?Q?UkK6hAg+vHuC8Ok29ptUfEMWo1zkYcOMjXvITeGF4Te1WxgUPt9iCfkW0NGe?=
 =?us-ascii?Q?ZBXI3n0BhQzL8s5mXio9WWc4AxLvMGFCs4lX0A3JAf5dn4CMCa5uOeIGCDcB?=
 =?us-ascii?Q?oj9lWLET7xruBgXrA/gk559Yv42f034NGs9l+Kx9LML6tle7B9yj0vXn19jt?=
 =?us-ascii?Q?gr61u9y2OygMsZp5sPZoVXdcfIbm6W/auAevB9+DLU2+1uR2998KmTTrfbeL?=
 =?us-ascii?Q?ja/JNkddZLpWzQfv7vUxiQV1IhTG0PF9bSgKbMUZHbpnbcFQkO/uITewZgxW?=
 =?us-ascii?Q?68Le+eczzHbSH1gjbtnkq9diTTjdvyGV2R2wT0VSHOLYB5fkniULsUgqFc8a?=
 =?us-ascii?Q?6phXgzMIN/GS2GnOqOpvXfabs8a8sXRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uY8PPttl5SAui++OzHAj3WNxC05fGq13sgOLtsFCLPqBsMqM4m/0DxklLLVK?=
 =?us-ascii?Q?M1FV4s6yoWELBt+nQB/26R4xBMbRlmABuEIUVFTQYfoolkCPujrQaanSQ+Fv?=
 =?us-ascii?Q?8gaebyTnTH6NHybUGmw2AVgTFRK2KmjWFq0aKHRyx6IhBS+ntaZqFW9taWaD?=
 =?us-ascii?Q?S7CcJPIY5Z3eXmtf2aRT617OUf3uhLxOQ5c3HUMV9lvjRB//B4vzB6i9dl1A?=
 =?us-ascii?Q?tJ+6xcwFUnOg/AJaOvDnnjBEOe4moRvehcFFpUrW23mKIm35JIocbtg2UWxM?=
 =?us-ascii?Q?0wMFZrnkGFQ83mEAAKn9KML2SocIJYmH++YNE6S+cF9mQtqNyD6BR3txuTIZ?=
 =?us-ascii?Q?jwS0f6I5K30fJt+x/PQlSjahI1qBZjSzbyUp0XN8S+rX/CMRT0nZfGgEJSsH?=
 =?us-ascii?Q?CSzlfpbxFlSK/u866nLJig9udrm5hUdTcn4E8BYve3pDRoqsaGaci51K7pAK?=
 =?us-ascii?Q?Kif7/vwRpJhEiA/AGhUcQR4g3ntNkSYlh0+79J5wiWxF5hxPqeg+F5LGiloI?=
 =?us-ascii?Q?rTO5fsfiUTqYJHwAARi1OnXasi6IjM0b40QXpfgVUjB71gPByTzXy4XlpJea?=
 =?us-ascii?Q?TP/mvjDXUBxQL7Q47rkXkceqKKsXvYm/pKooB/Luta4pfT0vGbV5qKwV12SQ?=
 =?us-ascii?Q?Jz7SWQRC+vN+rENQBIhtgfA/t4z+CG1Jl5vLKXpsNX3Hlt1Mu6/gItEEbKPm?=
 =?us-ascii?Q?cfyBQ3awVyXJuBK5gxJRYS+esbRtH3bmCZ0vhKk4mSOiWJsrFgo7wsFUE+g7?=
 =?us-ascii?Q?IPii+8m9ktrjeeY8+wpG0yooOIPQdCwUFoKRBz0SZZ9c224aMB4X9wYZP3D2?=
 =?us-ascii?Q?KBev2izJBZtMdxpkfue8YpcE2xYiu11alYDAlooydehj+/esTMwaeFshWPDz?=
 =?us-ascii?Q?hm3ZJ6ZE23n7x07LrwB2Ib+imuox5duK9epHzKdDKIveR+/wdDY93y9B3uS8?=
 =?us-ascii?Q?3Rwhc2uf6pv9l0ZjuMcuzunvFoMX1BTId47L+Ea2xLIsoOon5+qn4AplXoEj?=
 =?us-ascii?Q?EPLiGv7r0qjM0qF6fkpAvBGF8IvWNiC9vaGlO2FvbDD9uPHVCzyjsYFBUlyr?=
 =?us-ascii?Q?WJ3l3g8U2LegAmsQARuuFde74FqWLfaodsf0QQLvNuQ3W5hdVo5JelqyIh0J?=
 =?us-ascii?Q?IO7PEHiQ73DJ6pD5h1nMFFVv3Q4oINInPA7zampF5sHaEHYHZ1jztM6ErO0W?=
 =?us-ascii?Q?X5ZZx7ymWOy0XHhotpJ8DkqHFstuLGdb79mdY8xoC6Wxa6kBneYlTnFCfEZN?=
 =?us-ascii?Q?W5SaWszcKZr32sIXyEAiQc4exjZ305F0BTp1h1hU2FPFz9Zj08NlsoMGEqH/?=
 =?us-ascii?Q?TYOsirUTi5hfDue8F7TnLiYYaUa2hTOf2eRO1XKSSUHMxW4UBbTL78pAILG7?=
 =?us-ascii?Q?v4JLxaD4h1cHZKX3/31z+yuXTVa5OYPTROO//n9iiJ7tyV0XX2+0VZl3GPYv?=
 =?us-ascii?Q?/ApiAXcBin6xOqstzy9fJS1tsED+Luy9AK1bZ0pc3d/ZLYnCwXVCm831jU7c?=
 =?us-ascii?Q?V2JL16iy/6ecs8W5YNzTuZbfua7PCgV3fIsPk3a7905f4MfKckozMwsYt7Xt?=
 =?us-ascii?Q?bP2PoBdi4pvlAlfkjIJMlI/pmtbIV5tVzBc7gx7V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dlKaLxMPlHEE3vTN4uq4pfnOow3prsgHNH8jMuLzcz6fKrB2nGaU9hsZ/DpU2CQ2KWrJryyLCEbcLg9Li+hyWMuhMnWWsAN624hoOV1wpmsgzldctYDeCCSH3PVEgNjtYcDqm9/+gDTTyLmqluufV6xD/FzdL3VOA3YJWbnxiv3LH7kw1dIn4HRmyjo5A7WJotutk6QfcakLKnLhClLZNNcDUBDlWzLWghw2t3KPpPYEUMFiI1ZmyekhfhkDXRTUTg5/ITPwLptNcj1VI9n1RKvR0V5hC/gT/uC9F7GdJvQuZRJshpOgmabqVLfx0KHaJlv6nORkUnbBsyWiJXZq/UXuzlNj2FElq2+ury75ikWX5/P5R+5zYF5D3lwrhSmV7U6smaWeo/UNWqPwX6vnJWj7grMkD95zHfZqUzzVzYgiPBQ24adMyG/+7ZqC5e6wxB7ZAlQUg0207mAOUprQ2Dls0BFRIZGOjgAgRhXz04OErdwCXU/cM6TnpYZZw6jsBgVeWGWqkN7WnBPjYCNjs5n+29Kt1h8N4Ljx2Xg743Okts+ShyW781FNOCmtuMTtyInvrBVIf7KxqV8WT78d2BHZupi+yHnGSqY6QTr0Nog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a12f45b-9ac1-48f1-5714-08de1748e9d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 00:11:46.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1FEythPwyDWxuW9l/4qzyOL0FBlF3SyFnMka3eRs65lW6KC9SdRrSu2AXnAzUc6C5DFAstyif5jideUS+CIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290195
X-Authority-Analysis: v=2.4 cv=NfrrFmD4 c=1 sm=1 tr=0 ts=6902ad46 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pJD_9mKSOZQm4ju_ODEA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 4yIH-ZvDEJklu381jQoOvI8a5ZthlHHB
X-Proofpoint-ORIG-GUID: 4yIH-ZvDEJklu381jQoOvI8a5ZthlHHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzOSBTYWx0ZWRfX34aPXk6zGUY1
 eaG8v7pmHycuEJZAKOUC8dDkOkUp6d70ITDhkDY7Nt9996Tuh7lvrsgDb3bXiAMPICFW/AngDmD
 bVrfSG39HrXOWhre1zt14XY3lhgvJ2L1r0qJRuQpNG9SagQPEg39Fnf/xLLZBEkR8J2sm1WIn2S
 IzFC3Ls2IBVLFHciqOSV93v91Pqj9IGPPHe7j8cO2wHnyAZ+lCW4Raai+nYIBG8WEgA6/TgJBie
 JxWVQOhSzPyf5gqCB1S/sQK9qbAwTEH8f+BtROZcplHPftFuF7Xg+qMYWHeuO1VvxpIMA+qQSbg
 gend/qlttTUTSEjg6jdsaDSkhJVC54zOXtMgO9hypeZnubgQfjoMm+EwfuczbKIqve1qMtg8oIe
 8hthiauwbEZN+uBVKebjHf1qkkHTPA==

On Wed, Oct 29, 2025 at 09:06:45PM +0100, Vlastimil Babka wrote:
> On 10/29/25 21:06, Vlastimil Babka wrote:
> > On 10/27/25 07:12, Harry Yoo wrote:
> >>> @@ -8549,6 +8559,74 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
> >>>  	return s;
> >>>  }
> >>>  
> >>> +/*
> >>> + * Finish the sheaves initialization done normally by init_percpu_sheaves() and
> >>> + * init_kmem_cache_nodes(). For normal kmalloc caches we have to bootstrap it
> >>> + * since sheaves and barns are allocated by kmalloc.
> >>> + */
> >>> +static void __init bootstrap_cache_sheaves(struct kmem_cache *s)
> >>> +{
> >>> +	struct kmem_cache_args empty_args = {};
> >>> +	unsigned int capacity;
> >>> +	bool failed = false;
> >>> +	int node, cpu;
> >>> +
> >>> +	capacity = calculate_sheaf_capacity(s, &empty_args);
> >>> +
> >>> +	/* capacity can be 0 due to debugging or SLUB_TINY */
> >>> +	if (!capacity)
> >>> +		return;
> >> 
> >> I think pcs->main should still be !NULL in this case?
> > 
> > It will remain to be set to bootstrap_sheaf, and with s->sheaf_capacity
> 
> ... s->sheaf_capacity remaining 0
> 
> > things will continue to work.

Oh right. it's set to bootstrap_sheaf in init_percpu_sheaves() before
bootstrap_cache_sheaves() is called. Looks good then!

-- 
Cheers,
Harry / Hyeonggon

