Return-Path: <bpf+bounces-64074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD3B0E0F8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929221C25557
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B7279DA1;
	Tue, 22 Jul 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFd8LJZR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eOJt7hbb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4771E835C
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199607; cv=fail; b=QiSVaIYaBfczdiQUTW2t23H06MO7bWch5ZtgRzOI/U3y2AP5lDLp74Yi6rtec1cS3qvmOe0V1Y4nkFPRBqoTzwYLxLQmOkYP/JLEgWyqpLY0BE5tdhube+XbMKwim6LmTzB6/ddhQIk3JkTZuyoLJT12PtWPFh2pHVvJGAqMOBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199607; c=relaxed/simple;
	bh=5f5mu1tl1lav07hkEGh/qkOF8qsRw276URZqQfc6oT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hmcrc7DEFwJk9sto6wBr6K9vRkjCPBFZkJUs33BTjv99RmLT6y87DEtBhkekATFFo3X5trDNjMu2KPv23DhIYpwtknK2VRo35Lbs9y1B7RzHdPTRjvgwJyYfsb9+vjwmn6EAqPBpgNhDegBQwW6QX0cNkZxlfaDbu5HY/bZN6tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aFd8LJZR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eOJt7hbb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXqYg012095;
	Tue, 22 Jul 2025 15:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MDcB5pvWi/iSlkIofV
	9NKDViIgXCXvvrmB2kzI8Udpw=; b=aFd8LJZRXUbIcbovyPsUg6vXQDbSSeCqjg
	JYumWDOJSKOQ76qpZIxG+K55YlrDx0L4Hv3sXqXQ8FJBa6VcN0SDrqDcA/1T1nLT
	iVjePtrTYwVAwjOyEEbxmgsjHk8FeAGD0DW8nVEZ/D8Vs9WmGJv+B/gdjkjaovnP
	lL17wZp1Sq7R8wcawuH7ON8CsiIbzldi9IFmbrOE2f7nqVWIhGa/z82OlO0yGH/V
	BAs5QdHW4BIhm8bt7TGQKEcK/uhKfxPZP4RDjNxqAgHE5HxI48itB2hA9PO/PmEW
	5pOvyzqKHKBEsrKrYqeopAdxI6kZfu1YW3Pe45X53GnodJGIBkhQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056edp2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 15:52:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFn53f011336;
	Tue, 22 Jul 2025 15:52:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9fq52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 15:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVbSefeGAf0wDJWqsquvj+BImzhNi32h86kyEJTbKEXWn/081w34yDSgMdUUGZ7B5sqQQhvDyqKnw2gpO1zVkdJDktvOuXuWQEGKC4YmZT9apnf/+t/ZsQIX8elBv2UEPErN9TdKdoKx8AwwYQLpEi6q+OFoxlIQedTio/FJqHaRYBn3jdR4Ee1Y3JWJW1pqlquBIg8LJ2sAYRiU8TgezNGhDvFQFkksK4Zau7hzufrKA4Eh2PVg3HlvPEp+PL+LLu4QMDa9mtIrqrmrhd+mPEho5PldQKtp+WIbN8SSCampVj+9ISjqxHEHnuqW3Uhv3Kld0dwPUsl+TSdjXhlCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDcB5pvWi/iSlkIofV9NKDViIgXCXvvrmB2kzI8Udpw=;
 b=gRgH6mMck+cHMxxVOwLVy5iPiTss9fwEdeBQOaklXy8I736Ari9kLkkyXzPX8QjGwPQikv8xurn2HiOEQb3Bgx52sjtEW9g4qIwDqdY3FtNstu6Rm3s9wyD8gjk4RH/SNQHPGuECUmctHDGt+CesIvkLT5jw2kbm8QetCJnxaOGXFkNXgi5uGqhr2igRNNM7Vipi3YFhXL5tX+3XR6hKSlS1g59ob1mlhHQxdTiiIPNnuG1nTrdfezxW9GWxH+m7zyqcwPI/+7+N3awlxTckThqVwfNj8KiLUjIypSnyRyOQV3e6EwtLQbREdzlltf1jygw2ELOzlQJtHAysd62Otw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDcB5pvWi/iSlkIofV9NKDViIgXCXvvrmB2kzI8Udpw=;
 b=eOJt7hbb2TS18sTZ7jyefsFdTKrYst8CxAT4uavRAxzKa7i5O2uihYHvW+qRTOW30aEVKMXNOqjasqxI/3Pnq1xUlRQMakypyUDrPEwDdlZ/LkoNma4L0YsVa0K8CFXMhs4xdbbgwxUfWtSGsy1dxb50m+06FsaF8TGKJxGhdrY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4444.namprd10.prod.outlook.com (2603:10b6:806:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:52:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:52:39 +0000
Date: Wed, 23 Jul 2025 00:52:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v4 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aH-ztTONTcgjU7xl@hyeyoo>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
 <20250718021646.73353-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718021646.73353-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SL2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:100:2d::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1f2a4b-d9fc-4571-ebda-08ddc937c8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGUa5Xt/idfQLbQPzrk+Ay8vczo/0gRVl6R+nHjUwmfGdSGZjIhzeIb6+xuQ?=
 =?us-ascii?Q?IS5Ez/a8S+YyQa3vcgn03hV/RK8hhaszKMn27fZl5+COvQvcoag/h56WKOV3?=
 =?us-ascii?Q?jsBu8dN/hgz6PJNWkZQsDTdTC6cTJkpTUjSfsCJGdjZcUuXfyr3zY+UMa3W6?=
 =?us-ascii?Q?zlD6spQpFGVihGWZjp0PhIZm/9OHfdAvR8yL/gjN+LCqf0RJhOhmWQdGQxJJ?=
 =?us-ascii?Q?sOU1Ht+zNR17RqgbDkc5s29iZ7JBFjQw3tsHwqBX+jym+3rFdCB4+LhkR2gn?=
 =?us-ascii?Q?9EJKdFDUBhtiAUyWzVJKAyluUnnpqptzwa2mJKtYI9sssulMzRv1nPgOcwih?=
 =?us-ascii?Q?Dm2KEEo55URbgIs0kKdKtc6VniHti4x6AsAsMJebF3V0CIJiEaC8Q1eL5BgG?=
 =?us-ascii?Q?3ZSd1UtIhy95fE3hmSfexSGjbUTycm3pbCPhJyG4P4ihEqMpDBDfoJx8j5ou?=
 =?us-ascii?Q?0fez3UJE3nJtiaSmS7zD2WIG1TCG3xb91fAeWYOPSqOmROl3I95pkMgCwI1B?=
 =?us-ascii?Q?6q9X6Oi540NkYo2lZXdiVg24V6pxy71d9eT0gykyuD1W02uKfuN59df6SvVj?=
 =?us-ascii?Q?dPdK9yK4osyu/EeCTd4/BvnE2Ys+SwTsvKywd+634U0AslCYV3UT/5j88jvN?=
 =?us-ascii?Q?cLXfuFKeDbEkPA3lGI8J7X0XnpxC5B3IEi7qZMm1tHALLzd7LmWttlMPXg59?=
 =?us-ascii?Q?ZDHN9JNlFUiXdp9YNi0kHOcozweV5CeFYWu6uleVVlsWn8rIIR/MYhUUE9DI?=
 =?us-ascii?Q?+xIE9wb1aBgCrTQ9YoGmyy9Ke5F4DDZ9a1gNwbiWvbJiO7EZF/cC2T4JE9QX?=
 =?us-ascii?Q?T8JRPeuMsgzcrmqnJrnWiEYzaOT9sy6ELttfTRlGn3qAR5I9CKcgRK0Nh+jP?=
 =?us-ascii?Q?pOj0hYN84VI8EFWAW5uWm5jyU11I+s6AOnEWZwdrgtUxtxHOzlcp7jjFc3IM?=
 =?us-ascii?Q?2y3oaXNiH5BvIpF4AJG9gI2LUl/lxm/PzRg6xSpNXhLmiA25O85r4kErs3lE?=
 =?us-ascii?Q?E69lvqolNKJ3lVe6qeJDM2qlpPKqp8bzHP9WJWLTBCFnnmHbr9XOXVLEC06G?=
 =?us-ascii?Q?Dwvu2Tml1+PAo37i+n0xznGXrS7fFtmTLhZaaxAQD2biBHKNr23M1FTMXUUi?=
 =?us-ascii?Q?ISGfHDRjbDDyiqLL5Z3uVMVgoVoSdS/y24Wr/QfJssC1unEK3bpcBO4dpf8k?=
 =?us-ascii?Q?JaLuY3ekwhyW8x32WHxJ5iEJSBwVYqL36GbTrxnxPzndmdW9q5iKX1gJB+vy?=
 =?us-ascii?Q?j+6NmF51jPb2pAx/ivFXK++a89c3MkL/cbgza9Kfpw8fqdxcBjKV/LiR2xbi?=
 =?us-ascii?Q?6c5o1LrJEqdch+80b/3wo70rvuT23Mow7zPcudujuysvqZE7JfZT5hHeb/HJ?=
 =?us-ascii?Q?u7C782Qgp85xRp827YybjY37XLb+jOvs6Rg7h7Bm8KPADyWn2psZ9XANYOda?=
 =?us-ascii?Q?qmBqFbj2MaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fg7jak+Y42Lw4ohQNbwrcuQGSBLbWG4E5Wcn2vtKEBdXZJVNZVKJJnDfvY6j?=
 =?us-ascii?Q?1eSGvF0t8laX2AWwTXUyxUiciEKjDY7O3w34d+yFYdnOFKNE7bjqDM1VaUwU?=
 =?us-ascii?Q?5bwjhQiA+e8U7ryVNQ33dwQ7gqdwbR4FJp68gQV3dPF29ymPSKB7eTmZPsuc?=
 =?us-ascii?Q?bWUuAcDwfuGujdvN1FRq//mfFIiecZGnE1UiNHCnxYCd5nTJDBZEomkQbeNW?=
 =?us-ascii?Q?oHr9uGC8afvhehbYHVPQh6GzmUJM6+b+yQzaKcjZj0i93IkLXr8IVA3iHCsG?=
 =?us-ascii?Q?bEvXTdBpYaU1v6rm+7oGOLafXR7uOfYIi6nwybMLcGPD7vIV6//ukhp+jprp?=
 =?us-ascii?Q?l7u4TVlpbje7JnuBJZvjDIoumdnkXtmVV38cMLX8FN9uL5FIZ8iNdJq/NJgJ?=
 =?us-ascii?Q?1nAh9wdA5WV44/n7qy2k4s5PJF/VynTewIfQc68RQtzyaW4RnX1uMrsfELG0?=
 =?us-ascii?Q?MTaXiI9uJqBdd4fsFoKRd7ERMtpwWkjGLP8JqVA6t/9/5LrbZg6vsrAK+5mS?=
 =?us-ascii?Q?2LDHRYE3b7XNbPE9D2zy4TjFaXhlQheQTEI+d22HGySYUC2KA45QvG9BPAk5?=
 =?us-ascii?Q?hbM5lbYi15R/duKdt+VTjpwVCScxEhHxtsEcmkDCjY5cgMLei5ggh0Ut/ivr?=
 =?us-ascii?Q?kv0qLFISGIR8JXZmua6GdVQKjw9G0Bodh7Pl+4dS+SHjnjqd8iFTgqXrmx4V?=
 =?us-ascii?Q?fTo3wgvFAKqFVsDcSmMgExEREDPjj4lHSaKvte5uusqCdj4+aSIKS294Ztev?=
 =?us-ascii?Q?AQjhOC/8CLBcAq7+r51YO6f0C6RRhfC8lhDruE2N5VQfByBjYcuFrYucdktn?=
 =?us-ascii?Q?reYtieuxuTmGIvKXeE3uK8ejNlAbDVuHld9QYLNcInf1IC8OAIC+FOk6Z8Kk?=
 =?us-ascii?Q?2mXRQXNGvOhpHncFiegXTL8nhG2NZGz0dB4XaPwGMezwz5WvHn2b/ovjP4jL?=
 =?us-ascii?Q?Uh+GK6VER2MZIck5KtfBHh1I46nFgSO369tXtdWj8yofFdVN9N3AAgW8yvmz?=
 =?us-ascii?Q?tctuYhfFS2MYPg09Xs45jX3cmeYtBPxiER1Dc7VMRNHDLub4L1v6IALF4pdm?=
 =?us-ascii?Q?A2K+79X+cM0fqYvVN2dIuicJ7e12DLHyOrS22cQDD0Q7iDq+GA/W1R9QXG3j?=
 =?us-ascii?Q?mgy/CyZVykFUPqqnGI+uLibAyLw4/jKtoUdirs6XdN//6Rmpeat36eEUpEc1?=
 =?us-ascii?Q?H0lflrDOm0RJjqgq1+SBV7IdRGdcvKl74RuUGW3NATluxwR6wD3/WXLAcq+v?=
 =?us-ascii?Q?SmGdJygCy2tfuweNfvn+48KV5J6qfOxm7YsfH5v7KEOaaEiJlZlV+AO1Kk++?=
 =?us-ascii?Q?2Z0tIipksqiYWa/oyWlrqFHd4bi5WrtiNWrxHvrkQDRSsXCaXX7WhwbOT7Y+?=
 =?us-ascii?Q?nuaiGovHkW770OC/NsUlvWnFgxS1kzQ2Qve6bX1T4g70p/y5AmO9f3Z9+I3a?=
 =?us-ascii?Q?iM4xtv6BgmkM9cxbZbaMvx48vvbmXFUR1xu+G8a1tdcklM6AptospY7EdHPX?=
 =?us-ascii?Q?fmp7FtWnL4fvNzcOisOxkQ3KB5xFJlzVggFdXIYTMqmWJ2hg+fHb12qrnS+7?=
 =?us-ascii?Q?gvZRneLJFiYYSyLdBS2GIoRAH1T/JiVPrriQlLXh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WOOpLaz33vGc9bugILoXrguSz7HYT5fYDBk5ITy4zayZWwW78pHyuYkfmZuKf2i6K0R+O0K6GTSKRCaBgJNLqwi7zxmQ/1ilEwhnEGAqK9S52YLtZ+bihrv2Xv4tcjg0fwnFFS0hsaU4/bGQHkmJ93Y1JeweIdU+RIJoQeVIa1McTk2gG+nYQYCSLNnlc8wvS4tnTsclNBykjcloHXoE7nORnHKoFzOxHoWGCReDxP8UqKu7GlhLVYUuJgbLdSufWTkUe/zc01Q9HbBq8pBKBzqGhRP0kQubT7hf1HVh8MmqsTfZk5pQCbtiDVnSxxQ27cN4jq2luTN4khjyB5iz8GSiThffNX5nCq7qFSsfyCbVLh6+Y5TJ9EC0wbJtd32YttfRZz1tvQombhAzf8NIPshJp27Y54B9RVJHVlVwVXEGzCLBtuOLuFc8hKzFda1e2uipIAaPxWhq5ib5qEh3+fRHpy9vIK1lPC2FGt6FoXtslbO+cktGk7ImXzy/kSesf2HSer7/K803ZhlKkExhsJHV0cgcdacVZoJoTS8Y5p2/E3i0wcCDby8FJw2MrQlmWGQJg1CtnURwX3zL06Wvb9aPhSoXeclZpRA2eJtDBnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1f2a4b-d9fc-4571-ebda-08ddc937c8d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:52:39.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWBUeuGSJzj3/l6fus+j9QGxftzfJJLJfrNNjJ9bW70NSWHZJKo1/HDFu1hgiELTtkN1Jzo7xxxDN0uBRjtC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220132
X-Proofpoint-ORIG-GUID: WdkcDZgEx2JtIaHZy84jBua8JbxD6Bg4
X-Proofpoint-GUID: WdkcDZgEx2JtIaHZy84jBua8JbxD6Bg4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzMiBTYWx0ZWRfX7/Ri7he4OdyE
 fAn4umQ1isei2ARnNOCcEkV9VkGZMGi9Y5S+XxpmpOCUUpFoBMT3bm1c85MqXC7W5tMzYiurDyA
 k8e+ViMWONHGsWWxduJZYqeqb/2wPLvmZuX6QE/MJjsHhaOY8WaGHHzr9XFid4aUQIDMON9O4+w
 gmZhgh6AYG7Rda2xhKN4efM/9fJeeqmWpZS4df7CYEU8ourqmBTDyOU8Whaj8/4WhOrRqe1Rjhq
 Lk2acPpGCDmvDq4xtjHZr7QXBqnHyCZpn9r+aiPRac2arb+xe0FiljuUDKzJSNsj61sTtFEZx9G
 +hcACiY6N3UnnA0eFkl5agx9C7iVBkFuRwaq56JEqZM2hhMca9laRWfPhCrL8Y5E/6W+mnXx5xE
 Qp26Bgcb0UrbD55BLYBvQmC71OXqI6VEyvu5I0tWHRnAXf7+Esxi//yKljQLnQoFelurMce7
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=687fb3cb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=9DrY-jTiF6E8YAaknh0A:9 a=CjuIK1q_8ugA:10

On Thu, Jul 17, 2025 at 07:16:46PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> kmalloc_nolock() relies on ability of local_trylock_t to detect
> the situation when per-cpu kmem_cache is locked.

I think kmalloc_nolock() should be kmalloc_node_nolock() because
it has `node` parameter?

# Don't specify NUMA node	# Specify NUMA node
kmalloc(size, gfp)		kmalloc_nolock(size, gfp)
kmalloc_node(size, gfp, node)	kmalloc_node_nolock(size, gfp, node)

...just like kmalloc() and kmalloc_node()?

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

A question; I was confused for a while thinking "If it can't be called
from NMI and hard irq on PREEMPT_RT, why it can't just spin?"

And I guess it's because even in process context, when kmalloc_nolock()
is called by bpf, it can be called by the task that is holding the local lock
and thus spinning is not allowed. Is that correct?

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
>  include/linux/kasan.h |  13 +-
>  include/linux/slab.h  |   4 +
>  mm/Kconfig            |   1 +
>  mm/kasan/common.c     |   5 +-
>  mm/slab.h             |   6 +
>  mm/slab_common.c      |   3 +
>  mm/slub.c             | 466 +++++++++++++++++++++++++++++++++++++-----
>  7 files changed, 445 insertions(+), 53 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 54444bce218e..7de6da4ee46d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		        gfp_t gfp, bool new_slab)
>  {
> +	bool allow_spin = gfpflags_allow_spinning(gfp);
>  	unsigned int objects = objs_per_slab(s, slab);
>  	unsigned long new_exts;
>  	unsigned long old_exts;
> @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
> -	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> -			   slab_nid(slab));
> +	if (unlikely(!allow_spin)) {
> +		size_t sz = objects * sizeof(struct slabobj_ext);
> +
> +		vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));

In free_slab_obj_exts(), how do you know slabobj_ext is allocated via
kmalloc_nolock() or kcalloc_node()?

I was going to say "add a new flag to enum objext_flags",
but all lower 3 bits of slab->obj_exts pointer are already in use? oh...

Maybe need a magic trick to add one more flag,
like always align the size with 16?

In practice that should not lead to increase in memory consumption
anyway because most of the kmalloc-* sizes are already at least
16 bytes aligned.

> +	} else {
> +		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> +				   slab_nid(slab));
> +	}
>  	if (!vec) {
>  		/* Mark vectors which failed to allocate */
>  		if (new_slab)
> +static void defer_deactivate_slab(struct slab *slab, void *flush_freelist);
> +
>  /*
>   * Called only for kmem_cache_debug() caches to allocate from a freshly
>   * allocated slab. Allocate a single object instead of whole freelist
>   * and put the slab to the partial (or full) list.
>   */
> -static void *alloc_single_from_new_slab(struct kmem_cache *s,
> -					struct slab *slab, int orig_size)
> +static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
> +					int orig_size, gfp_t gfpflags)
>  {
> +	bool allow_spin = gfpflags_allow_spinning(gfpflags);
>  	int nid = slab_nid(slab);
>  	struct kmem_cache_node *n = get_node(s, nid);
>  	unsigned long flags;
>  	void *object;
>  
> +	if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {

I think alloc_debug_processing() doesn't have to be called under
n->list_lock here because it is a new slab?

That means the code can be something like:

/* allocate one object from slab */
object = slab->freelist;
slab->freelist = get_freepointer(s, object);
slab->inuse = 1;

/* Leak slab if debug checks fails */
if (!alloc_debug_processing())
	return NULL;

/* add slab to per-node partial list */
if (allow_spin) {
	spin_lock_irqsave();
} else if (!spin_trylock_irqsave()) {
	slab->frozen = 1;
	defer_deactivate_slab();
}

> +		/* Unlucky, discard newly allocated slab */
> +		slab->frozen = 1;
> +		defer_deactivate_slab(slab, NULL);
> +		return NULL;
> +	}
>  
>  	object = slab->freelist;
>  	slab->freelist = get_freepointer(s, object);
>  	slab->inuse = 1;
>  
> -	if (!alloc_debug_processing(s, slab, object, orig_size))
> +	if (!alloc_debug_processing(s, slab, object, orig_size)) {
>  		/*
>  		 * It's not really expected that this would fail on a
>  		 * freshly allocated slab, but a concurrent memory
>  		 * corruption in theory could cause that.
> +		 * Leak memory of allocated slab.
>  		 */
> +		if (!allow_spin)
> +			spin_unlock_irqrestore(&n->list_lock, flags);
>  		return NULL;
> +	}
>  
> -	spin_lock_irqsave(&n->list_lock, flags);
> +	if (allow_spin)
> +		spin_lock_irqsave(&n->list_lock, flags);
>  
>  	if (slab->inuse == slab->objects)
>  		add_full(s, n, slab);
> @@ -3164,6 +3201,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
> + * #1 is possible in !PREEMP_RT only.

s/PREEMP_RT/PREEMPT_RT/

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
> +
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
>  {
> @@ -3732,9 +3808,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	if (unlikely(!node_match(slab, node))) {
>  		/*
>  		 * same as above but node_match() being false already
> -		 * implies node != NUMA_NO_NODE
> +		 * implies node != NUMA_NO_NODE.
> +		 * Reentrant slub cannot take locks necessary to
> +		 * deactivate_slab, hence ignore node preference.

Now that we have defer_deactivate_slab(), we need to either update the
code or comment?

1. Deactivate slabs when node / pfmemalloc mismatches
or 2. Update comments to explain why it's still undesirable

> +		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
>  		 */
> -		if (!node_isset(node, slab_nodes)) {
> +		if (!node_isset(node, slab_nodes) ||
> +		    !allow_spin) {
>  			node = NUMA_NO_NODE;
>  		} else {
>  			stat(s, ALLOC_NODE_MISMATCH);

> @@ -4572,6 +4769,98 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	discard_slab(s, slab);
>  }
>  
> +/*
> + * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
> + * to take sleeping spin_locks from __slab_free() and deactivate_slab().
> + * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
> + */
> +static void free_deferred_objects(struct irq_work *work)
> +{
> +	struct defer_free *df = container_of(work, struct defer_free, work);
> +	struct llist_head *objs = &df->objects;
> +	struct llist_head *slabs = &df->slabs;
> +	struct llist_node *llnode, *pos, *t;
> +
> +	if (llist_empty(objs) && llist_empty(slabs))
> +		return;
> +
> +	llnode = llist_del_all(objs);
> +	llist_for_each_safe(pos, t, llnode) {
> +		struct kmem_cache *s;
> +		struct slab *slab;
> +		void *x = pos;
> +
> +		slab = virt_to_slab(x);
> +		s = slab->slab_cache;
> +
> +		/*
> +		 * We used freepointer in 'x' to link 'x' into df->objects.
> +		 * Clear it to NULL to avoid false positive detection
> +		 * of "Freepointer corruption".
> +		 */
> +		*(void **)x = NULL;
> +
> +		/* Point 'x' back to the beginning of allocated object */
> +		x -= s->offset;
> +		/*
> +		 * memcg, kasan_slab_pre are already done for 'x'.
> +		 * The only thing left is kasan_poison.
> +		 */
> +		kasan_slab_free(s, x, false, false, true);
> +		__slab_free(s, slab, x, x, 1, _THIS_IP_);
> +	}
> +
> +	llnode = llist_del_all(slabs);
> +	llist_for_each_safe(pos, t, llnode) {
> +		struct slab *slab = container_of(pos, struct slab, llnode);
> +
> +#ifdef CONFIG_SLUB_TINY
> +		discard_slab(slab->slab_cache, slab);

...and with my comment on alloc_single_from_new_slab(),
The slab may not be empty anymore?

> +#else
> +		deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
> +#endif
> +	}
> +}
> @@ -4610,10 +4901,30 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	barrier();
>  
>  	if (unlikely(slab != c->slab)) {
> -		__slab_free(s, slab, head, tail, cnt, addr);
> +		if (unlikely(!allow_spin)) {
> +			/*
> +			 * __slab_free() can locklessly cmpxchg16 into a slab,
> +			 * but then it might need to take spin_lock or local_lock
> +			 * in put_cpu_partial() for further processing.
> +			 * Avoid the complexity and simply add to a deferred list.
> +			 */
> +			defer_free(s, head);
> +		} else {
> +			__slab_free(s, slab, head, tail, cnt, addr);
> +		}
>  		return;
>  	}
>  
> +	if (unlikely(!allow_spin)) {
> +		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
> +		    local_lock_is_locked(&s->cpu_slab->lock)) {
> +			defer_free(s, head);
> +			return;
> +		}
> +		cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
> +		kasan_slab_free(s, head, false, false, /* skip quarantine */true);
> +	}

I'm not sure what prevents below from happening

1. slab == c->slab && !allow_spin -> call kasan_slab_free()
2. preempted by something and resume
3. after acquiring local_lock, slab != c->slab, release local_lock, goto redo
4. !allow_spin, so defer_free() will call kasan_slab_free() again later

Perhaps kasan_slab_free() should be called before do_slab_free()
just like normal free path and do not call kasan_slab_free() in deferred
freeing (then you may need to disable KASAN while accessing the deferred
list)?

-- 
Cheers,
Harry / Hyeonggon

