Return-Path: <bpf+bounces-79594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C5D3C5C6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2A9D5A8ECF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1C3EDAB3;
	Tue, 20 Jan 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FN4vjs8R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HMT0yf+U"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5D2EFD89;
	Tue, 20 Jan 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904890; cv=fail; b=bRrUVxpUGBgkvtOhg6mHvYuZuHq7sXU8qLEr5bK+9EDks/tEntUsBuCaeaHPK45ZdN5f8ceGKpE3dEZ5T4nUVA/hVU/4S9l4FQXhhEFgpmcxIrJqe1e4tDnkmVDZNHlzT2g8tzrpJkyo7/2AfSm1GI04zlzoIHNhPjZDSANvZpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904890; c=relaxed/simple;
	bh=7qNUX9vPUYawIRwuCJoz/b3dJa+fvx3iV1XFn3Xk2Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YScUkNei/V9k4ZGFG/gHvmnf7PQc83lFFfPWhsxhVfip4zsArCu++B08xEE72Og7oYmUVwbAzY5qX8Yu0XaFwlvS7x8EetUMpQ4yJvNKjLIKslmz+rzoRKfpmgK+mNKpzjdeOIf7IA/9VG2pD8CXNlFg9HetebuNtFW7pveY6Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FN4vjs8R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HMT0yf+U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7uonG3429731;
	Tue, 20 Jan 2026 10:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=o2BKGh9/23XiS6S5hx
	Zt8TN0AOtCEQf/nybxvw3SlSc=; b=FN4vjs8RscmmFKU8QlPYbg8+ZNxiAdmEWi
	jK/KAfPBebCckpfYah/AjEklxFYh5Vm7JPhJ3epUSRKiFQQZP1htQ0q0IXyjalWT
	honk1yf/tw6TaYwAFMNTuTAJDl1jKjGVTDc9Ze73fJOI46QXZD/34qfJlexz5HP9
	ctz5bYUYPLaOnj0r8n/w5I6aB1btHpMPar7oUS2jIVXS2oKcffqC2g7XJn23uewL
	F7hO9VeZ+8ISnQnv3FW0tMjz7+ZxjOuTTNWceIOIIYzfsV+bI8xQr5k/R3Q+IRJH
	GpqbMVPD+eUrlVPiBf/6FeMFkM5VS9cJS6gQOlurKIvXAS8a7fxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5kaa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 10:27:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KACP3F022647;
	Tue, 20 Jan 2026 10:27:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd6vfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 10:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2JPG7NDdmNIsP7G02WGzgp27kUQsgpySEZTIJwIZuWwwaIV8/VvH06gJxfd2hxSoHttNDM2CqwrjQ5w1LXgCof4owM5iU+Ini+aIy+F6RTTHgRSd1KQWPs3o5eVmuLbCHOgfLvC5YkZaZjisRQdZ6THIWe1fLsfzf9ErpXe/XdyDlaoDg0ON6jHGK75uXhW2HtX6KTwY8AMTPDlUb0bfVpTtjyOMkxgnzGYTP9w1JxZwO9D+7EJQNzy3x/Pbw6CcYYxG5al6q4TS4R2rR/ZCtvwPrGXOcARm8fXsHKFspZD2eebdkKrYCmFvuH+UzF3HFmWz4tu/Og4aBnk5CZbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2BKGh9/23XiS6S5hxZt8TN0AOtCEQf/nybxvw3SlSc=;
 b=WwTL9ZWamwdyc4OjjmqoJ9qyyuzX08JnY87K43rbUDvqnax47Rf0j6LzfcGuGFS6X7U7UDphMaO0zt4HLuXuJFHNe+usZ9eWE78DOTGmI5ZEdmLku879H6HxNiu6rGEg7qJfcRIlBagKYpf+iGTZBJgQf5y3hTrlpTUBkkuiqOmwTqfHDlDvtnloexW7BCWijlgKZ3dCDl231FdxE57tOX9wewwuB4+gg0R5p+jo74AP0Dclaqm9AytYGlymssuRCd4Q9iOqRhzZdDFpQ1wg+cNWE5q7LDpmyBnAP63IxGcFskqYeHABflTSNafQSHy3keXHoJ+ogwc+S6fgVMQHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2BKGh9/23XiS6S5hxZt8TN0AOtCEQf/nybxvw3SlSc=;
 b=HMT0yf+UQ6uv/t992JlvAZhh0Q2SJuSOYybTa/3j1sHQ3vLB/RtLbDmfBb5AHJrtiKYWJLh7ZzEcJnWEqAVqJWp2pnHFzpzRrhWaFnsMtcJ+xKUY2zrKPBe/VpycA1fOFJKsDLsjuIVv8DyXPB1bsFBUStFIXuifvZMJVLPT/Do=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB997653.namprd10.prod.outlook.com (2603:10b6:806:4b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 10:27:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 10:27:42 +0000
Date: Tue, 20 Jan 2026 19:27:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Message-ID: <aW9Yl-nqLjAJyBkB@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <aW7pSzVPvLLbQGxn@hyeyoo>
 <2232564a-b3f7-4591-abe2-8f1711590e6e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2232564a-b3f7-4591-abe2-8f1711590e6e@suse.cz>
X-ClientProxiedBy: SE2P216CA0139.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB997653:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d11efa-a74c-4f87-0473-08de580e8b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lOXcOzbnqiiBOYMSzS2IlOnc2lDXIwJsXqYH3yqm/SvoxGiyLstVVc5bf79e?=
 =?us-ascii?Q?srzOBKPgeXzYKG/11B9W6JsUd3r+j4jhoXiRgqVAU0WQNUWOTU7/gzTiLfS1?=
 =?us-ascii?Q?dtpPM/4R1hqKfn1X71DK4JIY6LLOscOC97amJsSdcVXX8wNj4cNh+3xfjzK5?=
 =?us-ascii?Q?XTp1JlzaBpS3oKMytV6pABjV+hsmO8CE/d3UNn12DISu05x81N7v+Xva2gv8?=
 =?us-ascii?Q?cLyPJBrNk1Fv+O9d9h22Jii/QbO4QPJkCT4sQVU9T7+77hjuzSREN1LUoCVn?=
 =?us-ascii?Q?IsoanM8S2yTV6VCvZrhMQ3MNdVNo7AYGAjWdGJKvT+e8QlRBwCX8h/l/3gKl?=
 =?us-ascii?Q?Np/klRpt0DaZOlI3IsptCPpb95b0te+OTKKKq4OpV0TGT8693ZbEB8sgIPea?=
 =?us-ascii?Q?MwtQhYLxAKF/fA+L1mR7sir9sDlo3FQKusvzFC1owranC4DL/+SWL1fOKCy5?=
 =?us-ascii?Q?Ip1S9Y5lNP5MCGtkzCoUZMoNtzne8UF35FHoIDe0HWypZo57gVHZtchjzruL?=
 =?us-ascii?Q?Y4B5co0MvqdG4gnD80pL6tcqtrbgdYR93G+qwytb4JIZs4rnFKulLudnh1aQ?=
 =?us-ascii?Q?37PWlAiH9LOkxCCkZfzG33hZCUHkkUHeWV3f3riq36n72YZGhCsawTc4uFIN?=
 =?us-ascii?Q?NL4ypCKXD7hi8d8+1L8MBRAAVzbilm2unWn5nYc/5nd9q0SVycGUV7MsgDZY?=
 =?us-ascii?Q?9EdNVbWEopcMonE2vt7IeDffM6dG0ebAa2NE3WKG6d+boiKSukV5JusvFrIX?=
 =?us-ascii?Q?iB+sAjsskzMqLW8drQlV3H7gNIrmDQeKXd7enb1VQ6txDRfXkejoUMdkmw4i?=
 =?us-ascii?Q?S9UlOugFFK2fGE3QIVnSG7AUR2aI5Ntu4PpnEj1gW1zyCASrgSC1iQtygJ3S?=
 =?us-ascii?Q?9ZmXDxwDya0BXG8OUqa+HsptK3HkYrNnCU573YAS7J3o0yPTQO9gMevtq6lo?=
 =?us-ascii?Q?p+9Q/hTI0Z/fbJuGVgemY+zvg8H4iPrE4b7uoTWS79ALRtwr6Rxd6BaM5N4O?=
 =?us-ascii?Q?7Unaf/4ldnvFb67KCUcGxBLWdG8Dkpxc4oAcbK2Z2jhBkUKajQm743bTofM9?=
 =?us-ascii?Q?BC1aKwwkHvH6p464GNHzI0qVCSBBzhpBB083CrMWeMb0Amnt5zmhEj2Q2VtR?=
 =?us-ascii?Q?AGSp4T9n8ajPiv5bgtBZKYaTQxWUdfLPq/IyisxhzkBKnZh10F6AfAn14gBL?=
 =?us-ascii?Q?DmA74EnjqD8ArL4bncbbhFlQXBWV7RO0I8NAl6ZYi+NzplCRJODkhlZ5JCYs?=
 =?us-ascii?Q?aeQMzB4pP6Wbr+GUUm1or1sqIeEdgo3r9DIw7tA72I512I2KKzCqnDgQddyW?=
 =?us-ascii?Q?G5KODRQ0Ww1eVjVwwsZg0Ggq5KT4MaXaO0/+fXZVvRTvT/FL7Ft4cWaTD/09?=
 =?us-ascii?Q?rpGBSM0hMB6bsuOdpyEVSIjXtE2O3Pt7x+R3+f93HrRCel8qzFLle1YtXgGh?=
 =?us-ascii?Q?8XjDlnQ9vgDzuXRodpFVEX5DtEHIJeuz7ugqB8H/9AX+5uUkZLp3pCP7Yfn4?=
 =?us-ascii?Q?MLOUt3K+Q1UDIpSdFdBreabVs4W4IGZPZsewE/R8uyMHfIH6a+DLNq5++Rka?=
 =?us-ascii?Q?AUEj/vvDJFhfjfDEddc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3V9iqvCbeeyN5FycS0Sv6y9zCHlUvLx+Hm9A/kXDZUat6sN9eKCdnN+phnr?=
 =?us-ascii?Q?jPD9bef7hvQC4EkcHi9ziOBYZMfs2dMhqnG6NIvbv++MPcIu3ixuf2zywpuB?=
 =?us-ascii?Q?FfRPs75twBb6K7ZwpXdK5wdT/RFWgesDNx4Epou4EwQo60Zilzw7lm4/2iqU?=
 =?us-ascii?Q?16jV6mqYldvjtg8QOXK1DNXqwdcfa76O2Q2eFElpfMOW9IGie7u8j2ye7JkF?=
 =?us-ascii?Q?WeWPsg0iz9kg13REIYOH1oIuUQoTXsDUAnSBc10NrE9HGULYBP+KEEaV7I6k?=
 =?us-ascii?Q?X7lvjQ3tu4u1kZpqEgZfU0L/gHngwZeAnAJkLbQVA6MiR0teiF0hsXBIfDwf?=
 =?us-ascii?Q?97taon1C0w2eYKuEXdHtEBhsDUzqWFTf37fzYJPdFoZ8WL/skG66kWBFuME3?=
 =?us-ascii?Q?4CjZq1drpa9AMVyJq2yMv4oQPTrhhjabrKULWV3B3Q7rrlostrQLimM9Kb+i?=
 =?us-ascii?Q?oRnDnQstCsNvKQKHNFTWxD6teC2VM6abAfFPW9MaFBpOXUJbVQAiSeduNi+C?=
 =?us-ascii?Q?XqSOBZSut0yg+bWM3EBZ0aEp1qCPlp5essq1dV6z1EvmF8MtY3QyUMcQn7tC?=
 =?us-ascii?Q?jwnFd6uSk0JapnMrdDJTxaGcBCfOHb8T3movlQaab5UQMldziFE96b/wgx9C?=
 =?us-ascii?Q?bCudxs86sRhaVw+RueG/MLvgHDCCYsf4BGEV1XgIdLiHnFCZj4O1QUgZih8a?=
 =?us-ascii?Q?C2JEUWrsy1Rv8EGrjVSlYBnwAiY4V/vaeTnhVRAscKKAl8XOAwNlTuTUmizT?=
 =?us-ascii?Q?XGZnLD1wV56OLmGtg1mL7j7c8+suoKaQxDFdgWuavSdHAnbrzfJXm7omQf3W?=
 =?us-ascii?Q?fKEOVk8kQKXQzPihx+87g+6gd8rkq1qQbk6VbN500PZoY9wfP5Ezv5I+s3XW?=
 =?us-ascii?Q?ELCDrp5AaQqasOGGhJnPw/L2ZyWFCG6UEnP5PSPYNds5rogiRcR7DvRg+Ud2?=
 =?us-ascii?Q?JFaf4Y79Cztg+4KjsKuw9uyajXd0v4Wp5TKWFjvReZpnfnZ4hmtPFk+GWU2s?=
 =?us-ascii?Q?EYK9rC/K0hgYYNfTAADXnhYySL7U3BFsKQ74WPfKOTahCk+SzcNnhIrJuIVi?=
 =?us-ascii?Q?f3UBdrk5HyqqacTEpVgOQat1o10G5dLxbuIYFyNML5UBESMu+fwCgqUnJOi+?=
 =?us-ascii?Q?D0hGQGhUAODmS5FWyOEOcQs217pEGY58jiubJAR0se+IToQQ0lR5UY4vrVKK?=
 =?us-ascii?Q?jS3LuPUhC842Dkp7epPf2oanjQYXQ3nWxd7rvEZWO8fRJNj/sBJcjxncj8ty?=
 =?us-ascii?Q?YDcKIQ20Rk1zc/UlLj6i7LtzB+uGWcmn7VO4us83q8hC2XJTvCsdjXUaIYh7?=
 =?us-ascii?Q?FRGg2Cp5eXmzZ5YRpxxBkkjQ89bAW0/WMbrGlnPbJOQe5LklGFixCFrwcPIn?=
 =?us-ascii?Q?zaA+3yLU6G+MgD+xA7p28M3SNr1nwVkVNtjnDc/JsM8h2kPtDzZaE5ykqmK0?=
 =?us-ascii?Q?vz30aJrIPRs1uVZb5zzHK39Gybyiy0Z2F+v42zKOBlb+ulPpqgof0Qhx3uhs?=
 =?us-ascii?Q?w+hVGnamNTIus00ae+dzBl4Xl0whW+G7N0ikKiAdz1ya7QXX/u/kPK4alssr?=
 =?us-ascii?Q?hAxiiu/TdhuWnxHgaP9j5RXh7IQQadwGTrjCG5Dy/NBDb8fjR4+1XqKGs0G4?=
 =?us-ascii?Q?blf8LOIYOYD5ljTUXq4jCYx5dcJVssBt6kPDfKMrfYmEpkchIgcuC7Uj5vU0?=
 =?us-ascii?Q?kZiyST2Gjghgk6oykJA2T5fIsAnp1LqMx/KQBygKN64dyKwtzbguEaX4qKvH?=
 =?us-ascii?Q?UC1PEGrRbw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0bApUOFiw8xJfqFjTRTx+li8U8L0snWhasHV4PFCSv1/ZERjTKa7oIFsp8bby3QMgWyWleAB+9c1i0ywUPoywPIhnzhIiL0GoxW90wJV/BJlaqZ1lufLX3/cjBKi30hhsrDZLIuB5BsM9Tr2sU/dr7wE6o/RWIHqCnsHWpuvpucK6k2+YMo31cNGK+F3by5Qr+7B9E+fqxzh80/IPF0Ck/ux1uK05mN8wkHzGz2allwvJTSPKE2E6f1p8Nqcu/hmraepHQSIBhuIRbDv802j646tS37XkH5Kqx/GR4ydTgFML3+SbGjmmdBC9Bhosb3GJg/xR2EAB3PvkJgbXWEyZLNXTr8+KWEeaAM8G4IsbAoOVMKqtxLLQVxeoCCONvV/jFGqwQ+w3XS8V6RLwV+mxiTrzzqfPL0pse8s//r2Snmg6st7/DR/gnI0XFQ/5/xYMSklH/ADxsbQlH8y9wxCHSddspXQJRINyIJvEFwR8KG6TCocUx4vNYk/7iOJiM25e4XmnCc4kw5Elt8A+DoQnM1wGRRYsNhlpN9gcJY8qaCSe/tFrCB2VG2ejHvePZz9sniJcVUGU6/xVjZzorOge2hhCR9x+M4tVb1OoruHNGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d11efa-a74c-4f87-0473-08de580e8b32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 10:27:42.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUBo1kKnCiK85vS9rChv+lW7DZ7gjMDMwrt8Q3pgeJff6yiVdjWC4hnEV/vXZitxvQwkb6iTXZm4urWYTE2pjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4NiBTYWx0ZWRfX/EEC5k4w/u1L
 KKtMcbHqg+2RwGZaGNUhvlhKCCklfo1nJR/y5ojxbR6yaEvYyABzJKo+f3YlWQERqUkkl7JBqBN
 uY7lMfdxyhuftwo6HSW1SrOYrKkQpFkx8wZFxirqjAePQ3ugH5ES5UoG8/WXB/KdIpUOpEAT/rO
 ANsqKgZNTMIxzZEzYzimGUNpGCK6Gtnc2lnTXS6T0R73qjwWLakc2rAOdyQ3fOTGLYUyqtdvgmq
 BlXyZDgm5vLvofdtnS3Xg3qHTdsUKt5p8fiH2PjyFySyIpm+VyWs31cYpKqDa+TKNab9HYDJbOV
 hvCwIHaGLdhrAXBK2FObpIgmk87UKyYl7WQlKQpdNnvWBYneAxrB1sO8zKugnVHleMAt1feMkmZ
 b0HFfBMEYWHvSKZedF3bXL13tXzY9xPI3EYGuUNzNCO8HjJ12GYpfM2GkwKDxZYq7QI2sWhHXWt
 Mb54CfaOWkO/mUwAZYUqrxAARzgmluocQy49zlcs=
X-Proofpoint-GUID: 9yAgxKl0TpOZLdRv7bC_TDwiG4tQul3f
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696f58a2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rA9XHZvkmEaODEes7q0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: 9yAgxKl0TpOZLdRv7bC_TDwiG4tQul3f

On Tue, Jan 20, 2026 at 07:33:47AM +0100, Vlastimil Babka wrote:
> On 1/20/26 03:32, Harry Yoo wrote:
> > On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
> >> At this point we have sheaves enabled for all caches, but their refill
> >> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> >> slabs - now a redundant caching layer that we are about to remove.
> >> 
> >> The refill will thus be done from slabs on the node partial list.
> >> Introduce new functions that can do that in an optimized way as it's
> >> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> >> 
> >> Extend struct partial_context so it can return a list of slabs from the
> >> partial list with the sum of free objects in them within the requested
> >> min and max.
> >> 
> >> Introduce get_partial_node_bulk() that removes the slabs from freelist
> >> and returns them in the list.
> >> 
> >> Introduce get_freelist_nofreeze() which grabs the freelist without
> >> freezing the slab.
> >> 
> >> Introduce alloc_from_new_slab() which can allocate multiple objects from
> >> a newly allocated slab where we don't need to synchronize with freeing.
> >> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> >> the cache is a non-debug one so it can avoid some actions.
> >> 
> >> Introduce __refill_objects() that uses the functions above to fill an
> >> array of objects. It has to handle the possibility that the slabs will
> >> contain more objects that were requested, due to concurrent freeing of
> >> objects to those slabs. When no more slabs on partial lists are
> >> available, it will allocate new slabs. It is intended to be only used
> >> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> >> 
> >> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> >> only refilled from contexts that allow spinning, or even blocking.
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slub.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 264 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 9bea8a65e510..dce80463f92c 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -246,6 +246,9 @@ struct partial_context {
> >>  	gfp_t flags;
> >>  	unsigned int orig_size;
> >>  	void *object;
> >> +	unsigned int min_objects;
> >> +	unsigned int max_objects;
> >> +	struct list_head slabs;
> >>  };
> >>  
> >>  static inline bool kmem_cache_debug(struct kmem_cache *s)
> >> @@ -2663,8 +2666,8 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
> >>  	if (!to_fill)
> >>  		return 0;
> >>  
> >> -	filled = __kmem_cache_alloc_bulk(s, gfp, to_fill,
> >> -					 &sheaf->objects[sheaf->size]);
> >> +	filled = __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
> >> +			to_fill, to_fill);
> > 
> > nit: perhaps handling min and max separately is unnecessary
> > if it's always min == max? we could have simply one 'count' or 'size'?
> 
> Right, so the plan was to set min to some fraction of max when refilling
> sheaves, with the goal of maximizing the chance that once we grab a slab
> from the partial list, we almost certainly fully use it and don't have to
> return it back.

Oh, you had a plan!

I'm having trouble imagining what it would look like though.
If we fetch more objects than `to_fill`, where do they go?
Have a larger array and fill multiple sheaves with it?

> But I didn't get to there yet. It seems worthwile to try
> though so we can leave the implementation prepared for it?

Yeah that's fine.

-- 
Cheers,
Harry / Hyeonggon

