Return-Path: <bpf+bounces-58480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D7ABB836
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0508B16F7EF
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FC26C382;
	Mon, 19 May 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJcTs9Te";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dj45LVRe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278135957
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645639; cv=fail; b=c26F/cPZMfAbDomA/DOOwAHxEEhU4muEAEvIZnUwEZkWy7i9O4zqtMPastjSG9ij0GWxX2Lb7WSoMVwm5wGUX0Dz76SYomw0AhCH46yB0/OTQ3l+/7fX+68M1FFvETCl/IsuvALjwyc9rk/u079ezauCDTw9lBc5BUA1RA/7mXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645639; c=relaxed/simple;
	bh=WhU5pDYoc9OnyO291HKLXNhyM6BzCoa/qMFkxRwjKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ok4XYj6XxswkjeSCrNUSPn19wvrzny4/qHWG+SR/1h+acgT9Wg61srtVaSw5u6UFESFK2SYO3I3lqYgzhZk7tHGXnvmPst10TAinavGmqGH/xRDDlvOE/vRBs0/wW3Z7HDvTo7Ow4VwIUL/8jgcMzj/Ot6sXmoPB7iJZyYK+NtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJcTs9Te; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dj45LVRe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ilfU004034;
	Mon, 19 May 2025 09:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tDT7X9VH//EO+572pS
	IKc1cluXS28bQDhqgmXUPNdHE=; b=kJcTs9TeiFVQFfaGgoIuTlJnoq4s4XvJwj
	CSkfHOwxTMhGBwLVuySCz7NTQLvhuxRyViNXkaDaRoQwMMyncSfY/bFDQbda0ZUf
	XAe3hvy5QHa6I7TFYisfsDMR0aDBJMdYxTtLlkHd3cb5IzC7UVr7ADPulo7AzKVv
	pgdjCY7a409l9h5IebTrBakj7h1WRiJhBkHejB+Y6/PD7UTPkRDW5cF0wIoUGNDI
	ZBio4e31QEhPwodzcKwCNavUxDGTURHO7fP1FmHdVDMkg5+VFUbFKM6qnZaMOsDQ
	++Nt9wXTv9D0zHKP6nI1X0u7eddWNi+gmbVlbtPJxUCaWSehcPbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vteue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 09:06:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J8a3O0010783;
	Mon, 19 May 2025 09:06:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6f52f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 09:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPa3bFxfnBTzxktGQMSTCnf4y3LwVsme/cBaJYR/c45Uc2K1rs+wAGIRCl3Lu2BK7n/MJBtXtigYJDIR5be4q6Cee2iS1gIr0C2qnAB5j7NPmrn6oOz74agIbYoEtIRGeknyEX/9mepfSCDEUhU0F+/J6RFtGYPaVtvgmy2CJt2O8U2raN/PfvD1HMCgnQMcLVmzBKABYXmpI0+c/BK1/buUbO2z1VUxyUppO8/ALR7M3NAOt9dvgSPk+DfkVxFW9+glAxQhmqPDb620dilceHtraCcqHSs1L6z86AJ4UydejZQXGfAWRYeWvXRmiSq/LQ7NxHWL9KdX6wUmtCIHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDT7X9VH//EO+572pSIKc1cluXS28bQDhqgmXUPNdHE=;
 b=HREGDGZHYbQKcNMTc1sLpQqlmYaT8/nu4MwFxzHY5haFG9Y550P2Gt0y1EWwekFzvcQMiFXRwGEv+1x8mM85ry00kqTY4EpKgPpctPz4Tyt/2DTyA4B35sQRpF/6YPODxL+g7KnnTT8wU0WomWVn93FSmpxJoO6cDGF6JBMrKpYf6f31rKctrgGXa8E3P+Sa8/kiyjl1epvIQJJ5BMsx7OHkn+Cjc1tNRrz+hqnCGGETHIucxHXNZOVPz5Ch6G5USVFfjmvOmOsMheMAURFodnO8M3UdjcMwdEAuJTlknJmWZAtuQRqJbibjSQd15HGhAHsMUdjx61juVCBy1L/pkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDT7X9VH//EO+572pSIKc1cluXS28bQDhqgmXUPNdHE=;
 b=Dj45LVReXUDA6TZfe+Q71EsxRIOfRp6xlyyYdfnoHlTLfdFenFAV5fW9yw9HhkOIJ1k1GoghWWPA2wv8iQmwhkpoYDMadzKiEy+z/51GrCEmpWiXVoBrA2yWpE++/VyX3gAaFZfQcFGV/Hw9YpPaE8e66rG+Ph/PNQfxwz2nSZc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 09:06:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 09:06:25 +0000
Date: Mon, 19 May 2025 18:06:13 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH] mm: Rename try_alloc_pages() to alloc_pages_nolock()
Message-ID: <aCr0hQh1VXSDGq_I@hyeyoo>
References: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517003446.60260-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SL2P216CA0221.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a6330e-f252-4c64-5456-08dd96b46ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vy8Pj1g4O3NWdre0X/oPVs8Q+u3tVrTm18Oo8dnbbbqg8rn+m/MbpcMbXKPM?=
 =?us-ascii?Q?ADemagWLn8DldIZzvYziu0uCg2WfpDcrPc5WaXbmWubOf6kwlfh7x8Pq2fIs?=
 =?us-ascii?Q?+SoP2tCX2/ZXFE/kaqGmX6LomVEbMLE5T4VbCkGf1RYopWfXqGwnciFJcKOA?=
 =?us-ascii?Q?o7sacqDWreszkpJvyIb4CiNSAE45BH0z5xG3sruLdqM0OmIcGOvF0lxvdMPz?=
 =?us-ascii?Q?VMdHIY64mrcSppcgBj4PTfGyU9NaXxkkf6QVxWIgGWro2pzegklMNhbf9HA6?=
 =?us-ascii?Q?lGlRrES2Jd/7b9kzDJv7xzQuYPGRcmC4oEg/tmZz27rRpANJ6p+yBgDmugOj?=
 =?us-ascii?Q?HwQ1Po6LJ8zmksN4dHnZ5F08vWKZw6Br5OENhMRsa/V+nrgX+GVpWJ/TEubC?=
 =?us-ascii?Q?w7PoMG6nzhQ8xVkIcdhsIkkDyfzMA9yKepNXajFmPjU9GU9arpJ+zwTxzpBk?=
 =?us-ascii?Q?qsmuR7xRN2fTWdUlS4ZKr8cou1iQv9pPLvveZdd9TfQLFQ3tz7F7VbQ6Fvu9?=
 =?us-ascii?Q?eLY0J9XPamt3bN8YxuO6Rtt9/HTWbmUdXqopAWW3AOjqcLqLI9GOJYwrPYFc?=
 =?us-ascii?Q?FXqHV/BJAtk+o84IRAYbmPvy6pn/djtdONMdFnU00jODaFAU72jJlYE+OXc7?=
 =?us-ascii?Q?Fia3WUA9SdEjq++ikRZBPdaB0HRn9hJXVpDCsHOt20hJUMSf1MBRx5EJSwGA?=
 =?us-ascii?Q?+zqPNHgO/lbcGXM2RwKVXqkz9RKICE54sAyhMm+X5Qvd3dMH5ngrJUnERoI6?=
 =?us-ascii?Q?Tv5wruqdlcf4IvRXlIfr4pusWqAZE95KswYPnnQJ4mNEzkVQYm7/tPYT3QEZ?=
 =?us-ascii?Q?VYAcgAw0u2cfg0Z4q5rgx6SYo2VB8HDOLW2G5ybdUTkuzFgPIX09GqNS8dkW?=
 =?us-ascii?Q?+LBvs7k2cHCXJg/qRy3tsStk15BZiw5ff/ELI4AZzjLzfELtU+QlfSGflyvj?=
 =?us-ascii?Q?KpN3wCdgjtq6yOLP08bqGi5DoHqd6gi/zeoQJVoMCDY2bwI1Bo6mZdUzdaR7?=
 =?us-ascii?Q?pIXG+PnukdwtzYUJX+vTdoXoRCR/EEiy+W6T9LHez27Ly5dQQMGEfgP6GKjB?=
 =?us-ascii?Q?9vr7Oi+cLTihbSk6MlvuGTyHZpaoQh/JccXVzeuMbhr7p+qngK9QNbB82OCs?=
 =?us-ascii?Q?ig6jQTftqf2Eydo4JDJq/B8S9KiZlWy4Dlib6Pkrf821xToht5z5C+pdz9gO?=
 =?us-ascii?Q?ILkBcmtAHjA1fnW8hQsU7C45HEIWXoYQp6G8/iOL1rzsvRSVehOLcVM9wxFr?=
 =?us-ascii?Q?3D6lGSd7O+QUlr2oYTyCmMbaIqgANKP1zSUXilwXeEy0+UIcjZGmXFyKWnDh?=
 =?us-ascii?Q?Q262ZzJnD41ogLcNKr/mGFRdrFIfCvcIoqUK/urnpa0x8wVcgjmMfaQNTvJd?=
 =?us-ascii?Q?Oy264gXBm+R2BESIJ+lRSBHXd8hwV6oTXbpO1GRE5jvtAF3fleD0ejvWnqtA?=
 =?us-ascii?Q?vm6Hn1AxBgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCPlO+Kt0InSc0CUf66c+GttzlwXmy5bTiH2UOEL+0v2JUefVyLyoCzGWVyy?=
 =?us-ascii?Q?Tw0GUuvGie30mQq5jauwmpU+HZzzEW+j3QGVj1PuHiY/KATgLyn9Se9s/HdJ?=
 =?us-ascii?Q?gWLoAVEXfWcg1SfR00OYxt4ZiZqCoMC+Nx+Zy36HQUvq6pnubbJ59e9D9LQ3?=
 =?us-ascii?Q?CiN+dccqXigdS6axBEGf0PFHyIfazihAgPzzHvXdenf6eoYrXWs0wPd+z/s0?=
 =?us-ascii?Q?/IuiJcXaXTa0COXmgP0oATAJSpHIDDJOKvxSKlceM415YJx8U3Ae3QD235RS?=
 =?us-ascii?Q?oOaCX0AbF/3ycNA18qWxACHlthBD9cdLGgVBsKQi7jMDvbjD/q5UewJr8Dh4?=
 =?us-ascii?Q?T8xqqPVkitRHNlLxvO3Kn98zNYOVTl5W62VTXERw1L/7k8Y9vsCfNiHU/gJh?=
 =?us-ascii?Q?LXVnZQ7QUjDc2PsFuk5XbZ+a51TnQGGwFDQNpZAAHKI9anzjPZnOJItmMN8k?=
 =?us-ascii?Q?ByTiVL7q3Zi6zUqzRSsdDBGvXO8XQkMhY5roCd3u5FMV9W4X+gulydhSD8AF?=
 =?us-ascii?Q?Y6N8TRnevjuTxaX7kAgpOODBTqsTumNLlQDgaKAo+1vs5oMmYg16hMc51OBV?=
 =?us-ascii?Q?NODN/s/F5PfiLgT9cb4zV1vRaGRIHKsAYSLKgQAXcsK0UsVaW5Haegtq/Gxt?=
 =?us-ascii?Q?oDX5sDOWU6vUyH/qhkoJ/Wo7BF7E6wgz376yl9snuRDD0YBMCJmQz0xu+hQL?=
 =?us-ascii?Q?yeV0hkgqE0JkKThq+z4Mora/h5wBJqI4TpR5Do0LiiI5NTL9YdoO3eyIGo1h?=
 =?us-ascii?Q?usqmWr2Zq2mxffVfrTFh+9vyeVybHYXRWd/LJm8QfhEN/l5db0rOKOvUvEp6?=
 =?us-ascii?Q?DMZsASy6ih1/dLV3me1q1uUFBcXOc7KWybCYivVOJIA4xpDfL34oGr+GgMB6?=
 =?us-ascii?Q?77CmXIzVYGXzwVXNhWnt4SnWDRzLC37m471tmqkjoVQd6Z/Py5eN98xQN+5j?=
 =?us-ascii?Q?xuWPbSesu+benrAHmXfMl2V+jjBgedZTn4gx/Mjdb4ksckVzjWUPo/MBDTHX?=
 =?us-ascii?Q?5SEEJXVzYI0JWwCtjIwfnnz/vM5GGdoyU3AYmNybObiChkZcP/H/7h2tYWuJ?=
 =?us-ascii?Q?0D84H60axBKZPemGqPZXzoPHFmDfqaygINkltDEk+HYwEYm+oxKy1Fxj1CNg?=
 =?us-ascii?Q?x6HaCbG6muQkkywo1IqgoS0XJIF5EAqn/OAPy76fL9VYn8qtNBE3+ShaJn+W?=
 =?us-ascii?Q?73uWVO9AGytWNDvwJqoAm/Wn9IWWqiliBnaOVG/YqCKOc0a/LbHIfN+oIjlZ?=
 =?us-ascii?Q?6ddhH8Jv7+lR7bDTMziw4OhYKMMmae8Naz+omTV+3aYI0sPuZg2FTjHY1ug6?=
 =?us-ascii?Q?adsbVykAF7e/pop7LMTdHoiq7myytcGFsdOPrZWzWIGnPcSesPC5+mRsxsMI?=
 =?us-ascii?Q?Y1eqsb+pd2WrqpEJVX/bO+lJxc8ZQJUrLccn2u3fnQozaYZUt4aLTocyCRDl?=
 =?us-ascii?Q?uVag+cCYitICc+WWZqSBrg0Sq+cmEy/2lN5H/s7T6M3CjDxTDlBNS+vNJTzW?=
 =?us-ascii?Q?b6iWIga0lyMTmPHvohWxS1Q01Yrk0G+nIdYaF1upULsmX56h39S4zOGPpCuI?=
 =?us-ascii?Q?oqoI6xoMvbMVE2veeDuRj7NF71N+Cyga7ry0XRkO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	An2dE8QlKn/8UPZzTxWoYo4KTSzTeaAbpUmXfNaoWFsiB/ubYw43C7G7V/Jlte4G1zXziuMQnWvV8jQMw8Azs4accXEieN+lkU9tsqu60QNUGC3oiiJfzm8mSVakvkQqq6H2pi6vKL+abM+u5hfJD0ufeOCPNkKq4oqRcuo/t2j7qAW2b5J4Lj2tq7umzy5S++RfuLMNa6F9gRfNrNDLbC8BOU11g35FFmbPZ3NxxUA5ayJuU70HHmjVCbS+kF07Klab/S2h4bz49t6BtPMVeZclK7uDHiJpTejJgSvsJgSDR9M9sIJv5pYVkEHkC8zld2YWGUVCwz7n9iN8w0jckaSpTSeMHoC6EHa7h31B4m3hcFinms+TFc8QISSHzgo1XLxDan7adF8JnYH3WdALAwEpvXN/7dtMH/q12VDSVmSfpX+OsX/+xnie1oRJfHpG+fJBp4AnIM7GdcfigvYkc9AGJajc10zfCnBXYbL55wnYAw+aPQoHorpNU0QRQP16/d//aDVJfvn1lbcWuidW9V0WgjxO8Pylz9d3m/JztD6LXY9CQ6ttyMB9TeqXgTi5TDfybLAN4eAJn75l9VEWsyaWQLBYwmHhd3tFdceOiSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a6330e-f252-4c64-5456-08dd96b46ee3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 09:06:25.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2K/PJN3duwas2chGIEL8w5Xiv/zGbm0hYlbcSoHMFid92wlBxMKNxs9LCTJjYssa2Y12hic/Z4wyhxZpTLI0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=963
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190085
X-Proofpoint-ORIG-GUID: 6phjhpztVuWAjeBcbX2CBO06D7TZEghe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NiBTYWx0ZWRfX2+H2rUOJlnci 5rlYfTzFdI7spNl0A61QwlrTn79hFZ3M5K4odY/X6O9Nr7mohu5voZbzd8AumDp6dAKH0XfviIP y+NqwFCG7uUlsPIks1ySRMM7n2Tt1VGuiFTQLbforzij4VFqyb5tWYhRv+SVgJM4Qv3Bpa7Jl0k
 FDABGV+TkN6yBxzyn/jUhnWALGZ7Dc3OMQ9bdiofFwyNJJAKwkst/GaFl3qNfA6OHDmNbFgBKjJ vZs6TnA9SCqY4Qv0EG7NnQ3hhX8wyjA7ePJlqJ7fLGf9GovuIIFgp3ZX2yZodZRgWfBsyqpfeLI jRlFSnWaRrohimaOSh0/Sem9wtFWlgoaXKh6rDxB4z37W4M9Vq84gGXXanFLs2FxkBkI+pdAeJY
 MsNoI1vDycVxb132qKKu24aeUCkESa0m6lZ970qHD+PfibvwSKIXFybrrb8qS4uB7BoBC7nZ
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682af49d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hol3gUIZIl0Pa47p29wA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: 6phjhpztVuWAjeBcbX2CBO06D7TZEghe

On Fri, May 16, 2025 at 05:34:46PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The "try_" prefix is confusing, since it made people believe
> that try_alloc_pages() is analogous to spin_trylock() and
> NULL return means EAGAIN. This is not the case. If it returns
> NULL there is no reason to call it again. It will most likely
> return NULL again. Hence rename it to alloc_pages_nolock()
> to make it symmetrical to free_pages_nolock() and document that
> NULL means ENOMEM.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Harry Yoo <harry.yoo@oracle.com>

>  include/linux/gfp.h  |  8 ++++----
>  kernel/bpf/syscall.c |  2 +-
>  mm/page_alloc.c      | 15 ++++++++-------
>  mm/page_owner.c      |  2 +-
>  4 files changed, 14 insertions(+), 13 deletions(-)

-- 
Cheers,
Harry / Hyeonggon

