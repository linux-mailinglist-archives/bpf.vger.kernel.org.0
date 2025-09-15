Return-Path: <bpf+bounces-68391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C7B57BE9
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 14:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64491A26CE2
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273A308F2A;
	Mon, 15 Sep 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TYyWSxqR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cAStJlyL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931933074B2
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940813; cv=fail; b=pZQagbB432Yh9KTPyOz5lgWA3FTZrp0tMst0e/QDR+frP5mkbpJeq/G2eogY19qoPkJDdj1Lwa0jY+EmITUl3tvbvkK7f/c2NyaJGsjLUaKGSUfjfzxmP4+EyXJ+jjDkvCbYYH+nGSx3tm0vbUMq3WJAxtbGjb2Dn3GvIaIBFV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940813; c=relaxed/simple;
	bh=AXHol3TFoWpiGbi5+n+86Vocgz7+kZr8oxrF6K/HN2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ps0rCY7/mKSmG2uyNucs5/UbYjmHpr2spe73Fp49okxvVq49K8M0Q188fRpym3k69mJ5mF7d3icb8Lhznz/ohaYNsgZ5Cnl2HH91+qKHbQuHFoonFhkOjZDwkAdK8n3/Xg+uvAHHrueMFsrUFH5RDw2Fa/vlWU4EO4yX3ErfUk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TYyWSxqR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cAStJlyL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAu0Fe018522;
	Mon, 15 Sep 2025 12:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9ye2lOXTlgMOSG3QgF
	rcmtVvS58wsUqd2ojFdEx0qn8=; b=TYyWSxqRjNwF2ORpCpeWmSpWDN7HYN+8A6
	gJfYMCHtZyrzJFy/6yzhowFvijWCaE8J+bKaD4bhxt5wj1EiVE6rbct1eVvNUHQa
	TPW0rX3r5G8X0qqTBi7ZkRJuoUrJfIPIl4ZCCgSctJoPHHWw1WPescJYddxGCTpE
	XsiDzAks4C+UnRtlSi2IY7Eb5n+DS5RWjpW7wN/lMKJOHqmxg/DlK3EilYpWuk8z
	hl1v50gOkU5bJbHohUaFgzi12SHa/D8DXWYTGgYh12F7JHk2gskRdeyFTeLvJKoA
	6btJZXs7Y4QiPvnM4ncAIvWMVHJVgM2UOPo1CzF2lFYKvhMTggLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w294g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:53:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCn1UN011214;
	Mon, 15 Sep 2025 12:53:11 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b05n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMWAN/HziaSWwdEKsv8CNCyT3nnGDjcWwJweY2ZuRV9rqvyPvgh+IWHXUeLWyPYV2t7kZrNCkTPZwB7iLUnTRoza+5g4CiYy8MVeNUNA9AzdhDlNIBdcQKPWySaj9k6OZd7KtvjlO0rcW8HxJ1AuL+lAYOh592fI1wa6BEfrzzNZrf4iUOPTpMDUR2rYrkSum1fnf3W3Ad6z+4lupiZgqr71q+Oq94RkiWPsltS9Bf049xem66X8aQUX/l8HV3MEgbt6rIrp5yLEfLKQxP5YvUuP6F3qJc4g2qskc01uRfnDoBMLM9BjzVLkNV0Rx8Uotwuhw4sk7740Px5LrkBfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ye2lOXTlgMOSG3QgFrcmtVvS58wsUqd2ojFdEx0qn8=;
 b=qcMNcHcrJzUkWAlEErNX8YEhRsWRqb3kkfuMsCXH60mNxWwhtR0IM3AvD+4J0KMktMFKZxvGTJdPf5121kkVSwoDUpvs2NZnnxYuyhf8hriOZ5e5o4ZQKicxnxUPRJf2XRFfhgRGqvB3iD8+i4bpec2UhMzlKrqnCQVN92kE4C709QXO7F7friZWV8wuScaDubk2MjrPCWSh3WIFivSlFgghJbE4psFkI1a2gkuQnrQBXe+ZNq7BpPGQIcBWM+oSUwSbrxfnlWlseFYZdCS2pcwY/FKOuBBXxtv9RTz8CB4omXr+1oPHSAhzujuNdE7VEQqwEZEvEoQvwBchWVQatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ye2lOXTlgMOSG3QgFrcmtVvS58wsUqd2ojFdEx0qn8=;
 b=cAStJlyLsOb0z/1gy+iKQLdjsfEyfcM2M9Ecs04LPBv/ytPlhhZCrTbchLny67T3M1SQgSgXrPkyImh/Kr8buN02tRdQts7EsnCegPbm8LD8sispJwUDcqPJmtWtUFUEAOmnajapZqC3wl5llCQgDl7Ik5lOxYO3hv66kbGtJ7g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 12:53:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 12:53:01 +0000
Date: Mon, 15 Sep 2025 21:52:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aMgMIQVYnAq2weuE@hyeyoo>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SE2P216CA0143.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 319bd61c-6791-4a17-502f-08ddf456cd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1etfDToXfmqutYYyaFxRQH29tUfsdhHf1jSrkSSbVULoqZCOuDzUj01F1vjN?=
 =?us-ascii?Q?I0FTdA/6lXEeN7JG/MF9sjJJICZo5Ys/XRqCcLYNfnJpB9q/bwQCKt8UzaaS?=
 =?us-ascii?Q?MTfXNZ37c47bM61BbDtxCpyig/O1q21oo/LeG3CK+nNuTSinORiUWizn/umh?=
 =?us-ascii?Q?UfifN3YDKCVB2/XmeEzPUzOs/NTCXA7U+w3GenhaSx378ueXbO60SYq/eIU7?=
 =?us-ascii?Q?iJ1bWJDMNjr3XRLIpProAh2CHl/d/WqmHTS6kUK7QB0ZWtLID0mEilfLzcV/?=
 =?us-ascii?Q?pl0PyYqS6ropzb7gbhkR2wPYitKzj6xhBQmcn0750kCxzgMHgcZ1vo7QbgME?=
 =?us-ascii?Q?mLrINX+/oZogytg2/TwVGJetWUb+R308OVTntWR4UYEFHjdyndyF8I/uheqk?=
 =?us-ascii?Q?7qSCJ6XQ9K9hlw578Uqbu+V/6Ux62o0FXXHeIHvq9MkwQjj0S2bh+zB1y0m2?=
 =?us-ascii?Q?FZQD058QU/3p6VZ3hoTSPtj7fN+JbLpSbd25CUy1mY2RPfeQiqIwflqUSfdB?=
 =?us-ascii?Q?CdflGbadG3cA6j5ralPNhCTon8h5SIhQXsgG8Qap4ezHR8yE4kY/TzAUsWcu?=
 =?us-ascii?Q?9ks11O63PuhBacMvblmty21z2pdIVrnGsp3xKvfgCzxF1kN7j+iqedktrjDJ?=
 =?us-ascii?Q?OOjcAK+y+0SD38pjvLhkfWh0pN/+wZwgVsfBQ0kO7fBXK1ELlNWsbi4OaJRh?=
 =?us-ascii?Q?XfllRsbLfGq5gJDNUefmCOh4hwdPAsh7lQZRLIRFTFhHnfO/yNK69wirKEoI?=
 =?us-ascii?Q?usbkCBByUmsEL7dJB6grsDTFh1duuf+LFirGOPUhiXBo6ssrWULbzc7IXs6l?=
 =?us-ascii?Q?KPAAvEDwJj112VTnmQfjlTQOx3rA3fbb48jMdEhmuAVFNB+RRFGs5rGUTMJa?=
 =?us-ascii?Q?jz5d9tml4H+4ZW863CHUD1P4+fl8F6xLFTUY4dRYDrMP7kCsaWzeMZfNe8OM?=
 =?us-ascii?Q?IvKWUUEx8X4QHr9fRvF9zyOQvY5KdziLt4Q5oVWCqWPdwhKJy7SIOjfPP1pj?=
 =?us-ascii?Q?CW7NMzRClpKN1pm+nwgWlIHKQtGuLOnITWmw237pOQomDiH2cgY1GfV17vFl?=
 =?us-ascii?Q?tNCxzOx4yzzxZo1wQ2tdUCLR2u2bbVrlGzq19Gjhq5ylRnYeAsMctXolCS7o?=
 =?us-ascii?Q?rTJIGoXs9Fxp4Y+PviVJ8CNeozKcu8c4aYbli/6jjvFhLLguQQo1hIsbvQnF?=
 =?us-ascii?Q?mMB5XOshovJ6Yj4GwuGMbW1WrRERvZLWGl7ItLKTEzpfoTJkirxJ+30YSdDn?=
 =?us-ascii?Q?jdKLGfbRr4cLDLmTiNoUbfR6Cwq41KAz/qYY0VWtVyKdHVnHcu7zG/RkfOQS?=
 =?us-ascii?Q?mFKJnRdi3qpaTJXYoGQEkOMEVxH4jeccnumfbsRF0r3bNriHgIfVettnapca?=
 =?us-ascii?Q?QxVNXuCkJHJ5OK6/JekKJVRAr2qyw14IFsJGAouUtc6pVaxFuSUA86GP1k4q?=
 =?us-ascii?Q?8oxjxl24joc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhsWCONg/yrFmUnvlByWh3In2lIwmTZNF87kOv/58RWgbmJaiuGLnM/T+d7y?=
 =?us-ascii?Q?xdJfn14Ok0IPnYvEi6ev//jGZ+7G0iyFGpVaAMifmHSP9z2Cr5mhKNA/Loll?=
 =?us-ascii?Q?ypTRxzhXli68YwoiSmO8ojSKpgspz4LHB6sFqSkMCgKXoHkB2FfD5Uimdsvc?=
 =?us-ascii?Q?wyqQu8OS9n2rRzR6ZWfR7Rgq/5tdYBiN8YDimzfcRvl3ngkD70+K0po9NWHH?=
 =?us-ascii?Q?n5HGhHOptg8rzGqCV4q1oxK2bk36W/qmRyVxzHfrf2aOobwXnjw09OpNnXSD?=
 =?us-ascii?Q?ROgb5EPyh2p0EwGQKpqLotMtfYPnVuOdH7ELBlKNQ1QNFMBwsVzNHC/1EgzD?=
 =?us-ascii?Q?5XeWfrls7KuQwns9jHQ+MGuiDWHmn7qyptdqeq7fdhFyT38gmR7D9kt/CVh4?=
 =?us-ascii?Q?Z5dpGHMF+Hjh0u78o0cOiBIHmDQpS2xVcdf0AQMg2Tc24Dkh5l059Zipo7r3?=
 =?us-ascii?Q?URv4/wP4pQl1v1Ljg28Yqt6usKTdbS3+ej5C/x1a0Qe6MBsfvVlQtnYNBKgW?=
 =?us-ascii?Q?ig2w8SL8EGOVJQZYDu3kH1XM07NqcDI/uydaVsQLHwJr5Tk9knVtIcRd2l7K?=
 =?us-ascii?Q?pFRDqBNeBVUbaGia7TUk6f/YJlIX7zeuQx2EY8U6LJmWSpwamKs1C19npwwT?=
 =?us-ascii?Q?6QJSCRm9Dc8OvzYJbfFhf7T1O5QDn8oSiORi9k6BbS/WyiCKHjLOLQVpQ+RW?=
 =?us-ascii?Q?FE80JToC5S8kR1F66n4sNPwCDsxSx0T11BftYM0p5Cw5MGuH/WdRZ9b2StU6?=
 =?us-ascii?Q?PzwW5IVU5a9XtFpqgeqTLoGTBIXtzq+Gz+eKhUx3r38BF3MPLCnDcIChQqbR?=
 =?us-ascii?Q?vx9UzHRL8LOAyGHQ0DmjkG5LoeWHn0OJWknkWURMF2pAc0frLGVAFQ4CUUrJ?=
 =?us-ascii?Q?z05mDZn70lSnNEx+rLzMYValc0EIkZ29tPr8G4mj2lLjNUJDrgqDWeWcFDWx?=
 =?us-ascii?Q?inO9shV7qgZ2CSUTCbhjn8DZ74pR8ABWOFKYwgQa2gstadUPl/wRGpY/5SUw?=
 =?us-ascii?Q?i2qNTVZNWx8asJIq9oryPf4Wk1qUI8tzXb2FAdZmItNoPftrzAhjo9Xd9jNA?=
 =?us-ascii?Q?puzYnT6MhaeD2bgTOg/syJEK4wikJ8iwMMC8M0vLhV5y6Zv77dVfh9bFX2+5?=
 =?us-ascii?Q?KJZCg7S4yWrqDWP6HBw6dDICWU80FeOzDZlRN9f897K+7Fh42yA1OYT1DSdp?=
 =?us-ascii?Q?xa3MUSDALzVSUFvnDriIFCpqCNjceaLfWBTF+ENgdnjPrLnZ+EgTR3XiUoRM?=
 =?us-ascii?Q?/uom3ukbWXXw8dotPsX7ZWJISgWhypwGAy5+bKVGyftyqhaXkXuBBk+yF7lt?=
 =?us-ascii?Q?eboourbSVdRekty5LBeYCdw4U/EdI+KjrQu24Ka9NEYk7FtUnl/vkmo+AzIc?=
 =?us-ascii?Q?9US3senuWp9pV57sIeKZ0FRraa7Yna/SqJpQvDX4g7YJupZ14JZBleGeZOeI?=
 =?us-ascii?Q?21/8ZgTmLQvkcCvdBrnd0zBhnKgu0LBxIPqH42RJ/tt8XUuDjKraBnKztUuw?=
 =?us-ascii?Q?LGWatHiiDh+uOsqMKoQQNPQGTlMDWzIel63m5gSwv27Jo82usXvTTDjr2Iim?=
 =?us-ascii?Q?bf+7YwzrIopuz81+x9wH9uXiJ4elO8saIQ5YJkA+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7XpfTx9Oookklau3GG7rLWMMsSn+u08ZIVJHk9OPT9IoDciAOZ5ySqhdSfn3bI7xDKT/QA9wwS5n8EaKYc50gUFubUnKag1hWv3eD3i3te0JgdVCR1zh8cVNqPsbnub/jMNvYZ3pb8Zsk+mTlXAC+m2Ir5lGWJs2SEGTYMthgJJurXmDODrtOCWdBFAsSIhlA84HKcr2LIuX1ZtACMcgghLuSIwZNLgYJrAKSx9n/b61hD2vX0xTSx+qRCrwhG31KYOMV1gR9r1rue2lID5vYa1Jzid4yR6F9V0O7GDiIVbHhYbop/9FrIUqfGibFPgIjiea9POpuc8BkHaiAHL4kIBwC9srD1ZXp7bCfczMEVml7DziHROBgYMXg7CLfafOyphomDMXW+P3cHeeXYBZIgGMRzARQ0PKl9Gbb6Zuz/ieaY/XAdMi2I2jnu9cRdPM4vxXiXS+/PWADneLxHoEKVCi3Jy5zWXWjudMXTO8Ix9KBuopVIND1GHAxYrlyKpKmPqte6RQqd9tPmQ3xESBQ03vpmZnk0VYnv7OE00R3v/sB+RcxXiVzNngByxwGkrYVycsh+he4wTsRFvQ1hPSuNecClTJ5NfLYPdMHUp4l6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319bd61c-6791-4a17-502f-08ddf456cd7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:53:01.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCdi8fkjTfuerZge7Y1UgUg+BHcGGc4u9NZolR+KxXA+V5kXF6sWPSH/oiv35mPwdQxJAu1I5SNCKHSS0u+muA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX4OZ/ZZ9Irz71
 7SJUtDP00VIGo02GVlCdfUMZHhlbvtcJcr45n64nO4gK9Ks9uYZIHo2FTSb2q+jEPvIbRIJzO8g
 urIHdnafEYkaC4YdgH912sZDMO/idXKBIxU4jT5mMGxgg3YKafUJ25CHbzIkYNpcNh/+HxlWlel
 Ekbe+6s9eIRe6/VtO9LedGMytGcKIzOID+HsRETpdvcKDu28NEsZ/rHn5/+iALTNoqbf30+ImTb
 z9xka8R0gsO+RWOjYv59AmTx68ZJ/Orxx7AFC0+y7T76PT2CMFdc//CdrgAuNgTVzgSIoByBAqE
 0yNpeBTh/Ld1k4qYbmR9P9fClAgNBjhX+MolCjOI6YZyWuWQx7dJBxsf9OGdjUi5B4JPUg3NOZo
 ykcs7Odh
X-Proofpoint-ORIG-GUID: UQXUSXRhxdbgBKTGAaeDHsteuhhp75q-
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c80c38 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Zhgu7mjA8aSw3ZpTjPoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UQXUSXRhxdbgBKTGAaeDHsteuhhp75q-

On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_trylock_t to detect
> the situation when per-cpu kmem_cache is locked.
> 
> In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> disables IRQs and marks s->cpu_slab->lock as acquired.
> local_lock_is_locked(&s->cpu_slab->lock) returns true when
> slab is in the middle of manipulating per-cpu cache
> of that specific kmem_cache.
> 
> kmalloc_nolock() can be called from any context and can re-enter
> into ___slab_alloc():
>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> or
>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> 
> Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> can be acquired without a deadlock before invoking the function.
> If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> retries in a different kmalloc bucket. The second attempt will
> likely succeed, since this cpu locked different kmem_cache.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current _task_. In this case
> re-entrance into the same kmalloc bucket is unsafe, and
> kmalloc_nolock() tries a different bucket that is most likely is
> not locked by the current task. Though it may be locked by a
> different task it's safe to rt_spin_lock() and sleep on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> and (in_nmi() or in PREEMPT_RT).
> 
> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> spin_trylock_irqsave(&n->list_lock) to allocate,
> while kfree_nolock() always defers to irq_work.
> 
> Note, kfree_nolock() must be called _only_ for objects allocated
> with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
> will miss kmemleak/kfence book keeping and will cause false positives.
> large_kmalloc is not supported by either kmalloc_nolock()
> or kfree_nolock().
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/kasan.h      |  13 +-
>  include/linux/memcontrol.h |   2 +
>  include/linux/slab.h       |   4 +
>  mm/Kconfig                 |   1 +
>  mm/kasan/common.c          |   5 +-
>  mm/slab.h                  |   6 +
>  mm/slab_common.c           |   3 +
>  mm/slub.c                  | 473 +++++++++++++++++++++++++++++++++----
>  8 files changed, 453 insertions(+), 54 deletions(-)
> @@ -3704,6 +3746,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	}
>  }
>  
> +/*
> + * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
> + * can be acquired without a deadlock before invoking the function.
> + *
> + * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
> + * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
> + * and kmalloc() is not used in an unsupported context.
> + *
> + * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
> + * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
> + * lockdep_assert() will catch a bug in case:
> + * #1
> + * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
> + * or
> + * #2
> + * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
> + *
> + * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> + * disabled context. The lock will always be acquired and if needed it
> + * block and sleep until the lock is available.
> + * #1 is possible in !PREEMPT_RT only.
> + * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
> + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
> + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
> + *
> + * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
> + */
> +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
> +#define local_lock_cpu_slab(s, flags)	\
> +	local_lock_irqsave(&(s)->cpu_slab->lock, flags)
> +#else
> +#define local_lock_cpu_slab(s, flags)	\
> +	lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags))
> +#endif
> +
> +#define local_unlock_cpu_slab(s, flags)	\
> +	local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)

nit: Do we still need this trick with patch "slab: Make slub local_(try)lock
more precise for LOCKDEP"?

>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
>  {
> @@ -4262,6 +4342,7 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
> +	bool allow_spin = gfpflags_allow_spinning(gfpflags);
>  	void *freelist;
>  	struct slab *slab;
>  	unsigned long flags;
> @@ -4287,9 +4368,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	if (unlikely(!node_match(slab, node))) {
>  		/*
>  		 * same as above but node_match() being false already
> -		 * implies node != NUMA_NO_NODE
> +		 * implies node != NUMA_NO_NODE.
> +		 * Reentrant slub cannot take locks necessary to
> +		 * deactivate_slab, hence ignore node preference.

nit: the comment is obsolte?

Per previous discussion there were two points.
Maybe something like this?

/*
 * We don't strictly honor pfmemalloc and NUMA preferences when
 * !allow_spin because:
 *
 * 1. Most kmalloc() users allocate objects on the local node,
 *    so kmalloc_nolock() tries not to interfere with them by
 *    deactivating the cpu slab.
 *
 * 2. Deactivating due to NUMA or pfmemalloc mismatch may cause
 *    unnecessary slab allocations even when n->partial list is not empty.
 */

...or if you don't feel like it's not worth documenting,
just removing the misleading comment is fine.

> +		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
>  		 */
> -		if (!node_isset(node, slab_nodes)) {
> +		if (!node_isset(node, slab_nodes) ||
> +		    !allow_spin) {
>  			node = NUMA_NO_NODE;
>  		} else {
>  			stat(s, ALLOC_NODE_MISMATCH);
> @@ -4374,8 +4460,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		slab = slub_percpu_partial(c);
>  		slub_set_percpu_partial(c, slab);
>  
> +		/*
> +		 * Reentrant slub cannot take locks necessary for
> +		 * __put_partials(), hence ignore node preference.

nit: same here.

> +		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> +		 */
>  		if (likely(node_match(slab, node) &&
> -			   pfmemalloc_match(slab, gfpflags))) {
> +			   pfmemalloc_match(slab, gfpflags)) ||
> +		    !allow_spin) {
>  			c->slab = slab;
>  			freelist = get_freelist(s, slab);
>  			VM_BUG_ON(!freelist);
> @@ -5390,6 +5504,94 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>  
> +/**
> + * kmalloc_nolock - Allocate an object of given size from any context.
> + * @size: size to allocate
> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> + * @node: node number of the target node.
> + *
> + * Return: pointer to the new object or NULL in case of error.
> + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> + * There is no reason to call it again and expect !NULL.
> + */
> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> +{
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> +	struct kmem_cache *s;
> +	bool can_retry = true;
> +	void *ret = ERR_PTR(-EBUSY);
> +
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> +
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> +		return NULL;
> +retry:
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return NULL;
> +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> +
> +	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> +		/*
> +		 * kmalloc_nolock() is not supported on architectures that
> +		 * don't implement cmpxchg16b, but debug caches don't use
> +		 * per-cpu slab and per-cpu partial slabs. They rely on
> +		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
> +		 * attempt to allocate from debug caches by
> +		 * spin_trylock_irqsave(&n->list_lock, ...)
> +		 */
> +		return NULL;
> +
> +	/*
> +	 * Do not call slab_alloc_node(), since trylock mode isn't
> +	 * compatible with slab_pre_alloc_hook/should_failslab and
> +	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> +	 * and slab_post_alloc_hook() directly.
> +	 *
> +	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> +	 * in irq saved region. It assumes that the same cpu will not
> +	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> +	 * Therefore use in_nmi() to check whether particular bucket is in
> +	 * irq protected section.
> +	 *
> +	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
> +	 * this cpu was interrupted somewhere inside ___slab_alloc() after
> +	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> +	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
> +	 */
> +#ifndef CONFIG_SLUB_TINY
> +	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> +#endif

On !PREEMPT_RT, how does the kernel know that it should not use
the lockless fastpath in kmalloc_nolock() in the following path:

kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()

For the same reason as in NMIs (as slowpath doesn't expect that).

Maybe check if interrupts are disabled instead of in_nmi()?

Otherwise looks good to me.

-- 
Cheers,
Harry / Hyeonggon

> +		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
> +
> +	if (PTR_ERR(ret) == -EBUSY) {
> +		if (can_retry) {
> +			/* pick the next kmalloc bucket */
> +			size = s->object_size + 1;
> +			/*
> +			 * Another alternative is to
> +			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
> +			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
> +			 * to retry from bucket of the same size.
> +			 */
> +			can_retry = false;
> +			goto retry;
> +		}
> +		ret = NULL;
> +	}
> +
> +	maybe_wipe_obj_freeptr(s, ret);
> +	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
> +			     slab_want_init_on_alloc(alloc_gfp, s), size);
> +
> +	ret = kasan_kmalloc(s, ret, size, alloc_gfp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);

