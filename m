Return-Path: <bpf+bounces-45467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18909D6100
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 16:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E8DB21FA6
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AD9148828;
	Fri, 22 Nov 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Har6MaB8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XTFxZh6i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2213CA93;
	Fri, 22 Nov 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287462; cv=fail; b=VRiH6PJUQ4xx7lGNMbb4W+t5pIg8yGexbmP3x80ChNHMBnBcBn663M5jBzRQwLMd2VvYIVu0dXb1R6IRkUWPZZjnqMT3jjemxsgWRwQw1+4nNBloH3kmciDpmYpHweiH3/raY1i3eG7sUzmlyy9e5yX2UOx5+GDbSBp1HcFwAYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287462; c=relaxed/simple;
	bh=GP7hqVtL51sVYlWfROMak+QLMv2J+dLAuVZDmGHGIbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLb13VFzaQ1LcXxW8Mgt4y3jJd4Llz//7erRBEIMO9BvEuwaz9izz5lsYqWa5XMvJhLBrhKYah3ughDV5Fm063KeNDwvne1Ojyarh8wfr4ZSfJGre2tJXO/V59HPfguNavTHVNcGNrPK2u7nBSH3yDTFVycKoGbMY4a/O7aFwWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Har6MaB8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XTFxZh6i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFp73019312;
	Fri, 22 Nov 2024 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ia3pSbjKLY4h0eGGDkBwhqG1uIzj4ULhahlCfasD1/U=; b=
	Har6MaB8B7LZzoHs7GS6SYxrm1IlMey/HH3IUQSF8GLibgflDf19aa7uAeU6edTK
	AwkZoF3T2lOGsb2IW9+E/FgT8BJVSfA50ccZRCVTrubNMPXy0oXpxBLe/YGXAQAl
	hkBI5ZrCCpsi7cMJbcps/Or8nk4k+QptPA8hHhJtPbTFYafPH+TV/ibMBG2QhaLH
	7ag/ubVLfBJ0QPzXl0gHlzvfMGJ6Fkaot0ueOHlKGsNaqKw8r/aTMuAsNN2mfJ0J
	oYwA7SU315rv5RU2bPUOIb6wC/+HAJl10XGUMrkFsro3DqMGd0WQBHgrJw8mRegK
	lg7oFE0VYzcSK9BNaYv3zw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcc7rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:56:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMElTPR007834;
	Fri, 22 Nov 2024 14:56:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudb2v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 14:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTPXsl7AcJmx9oKOnrvfL15WcHsNhAlNj//enrfXkSnGm3RJ6P9P/OBzmACjpDThP5B1X9ms9IEQceiesAMPZaQ2ThddTcbaTcF3V2mRuBazbfslk0vUVR6bi5wVwsCx1HWpomN3xdPbNfXleRXES8bragpTkZpjV8zXRpfla6/vJgAwiE3bRl9DAmw66ETpeHgKCYqN9nzHjN+Cav5+J5WHkJYyPmuvFsX8aXcWUKf1y3iR5T/gK44CkM+1wBcdRqNj3fVcy13vc5Sl7iLCjVk79dm70Ebu+qYZbuEEELK2a9XE+B9MEk7zgiD8ULKubp9lskyetUC7JbXoIfQ+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia3pSbjKLY4h0eGGDkBwhqG1uIzj4ULhahlCfasD1/U=;
 b=sU38qkUd8DkLfmAwdIx9laQ3RxUF/5D0MYDJ4cEOAqELSKYAMNLMFhGEiM4TDYBPIxDBXXleiHKbcYcl97R1eLWJyhbbnUmq+phfMPIG2ONSoeOPUZ/umxhBuvqy+HX+LJPv4bLv8YOPhnkOA9BcwKQI0Y4aGX4xMisRt6x4PICacp64dKjBPXgPQaAhZ4uKj8zGyYizgkF3nGD4G6xAKwY0K0hY/2gCmb5dnCERBnRFzEmXlzCj6bMxLr2dMqmMLAWdXRYHx0dYdvbaagkeNGj5cqzMrI99sY+YrR6w+zaWmqXa+S6MJ5gM8fk6WWVC+Kj+MRGxCYsi3dDilNaEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia3pSbjKLY4h0eGGDkBwhqG1uIzj4ULhahlCfasD1/U=;
 b=XTFxZh6ixt7pCqX1NZ2Dn4WYqGAgyvgLhaNbFJjDEBOL0+qJZLNBj4eL/HBbjjj+anHuUi0Kkyl+NZqJjVlFOmwhzsWVTul996f8ZuB5Slh+nxLr7e5lKd2mvykjLRdbcGFxk7qxizg3U1oLEmi+X77F/PXUSzIKSw9ZOqI6MVE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB7391.namprd10.prod.outlook.com (2603:10b6:8:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 14:56:37 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 14:56:37 +0000
Date: Fri, 22 Nov 2024 09:56:32 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org,
        surenb@google.com, mjguzik@gmail.com, brauner@kernel.org,
        jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com,
        david@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
        hca@linux.ibm.com
Subject: Re: [PATCH v5 tip/perf/core 2/2] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <eebaftvzuscz6ggrybystfa7hjcikfmdl75xzxvfvcu2opmcx5@abzcjldmefny>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, viro@zeniv.linux.org.uk, hca@linux.ibm.com
References: <20241122035922.3321100-1-andrii@kernel.org>
 <20241122035922.3321100-3-andrii@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241122035922.3321100-3-andrii@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0225.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1310e-2872-46ad-3037-08dd0b05dd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?0NgSCrnoJRNABc0wE5zL3E4xlxmCFdvh0fZ1Hi3RHrTj9A1ifgz+uHee/E?=
 =?iso-8859-1?Q?pHwtVzO4wFjblr+yymEu6PwrtOU9RqQlnOUoVUL4tVnFS/6HstGbnVko2H?=
 =?iso-8859-1?Q?5KRh+TPJ6pOFjpLI38WC97PMh8P2GrwlCB+oklCpmnwyCPPyVjy8J+A8TY?=
 =?iso-8859-1?Q?Enr/haJoKk9eo3NrqPL+8wM4zIKqVp7eEE3GBEs7iB4J0KlQMz8OVfe3Pr?=
 =?iso-8859-1?Q?WMq6FVqv9gwwN/d13lf59UgQM4l3JRZ745L72nSyzmYeBLZ3Q86xX4zPIF?=
 =?iso-8859-1?Q?UsoHxF7/UCgzTCtoxgKyIsaXm37TSQSsgGUOlgS6BRD6WGaY8h40JyIsoF?=
 =?iso-8859-1?Q?jBgGZ8CP7LL+tV2suOdHjG1Wz3W6TcW0t/cVOyy22AIWzWoqnW5spAx7wT?=
 =?iso-8859-1?Q?CpZsT4o3v+nNwk3zippqyUUoVWdsGgFhzl7KfWkYlhA3Ikp1ysY3AgDkrs?=
 =?iso-8859-1?Q?lH+9JYPb1l+kBE4Ov3reycb5c24HgtQ+uBgM7JOmuNWFcwEHVDt3E2X996?=
 =?iso-8859-1?Q?75Qlvi0OMA07kTtnSD78Q68XmrMcHxfP7FsPMaJfi2WI7m3TBktujxYJnF?=
 =?iso-8859-1?Q?nOD5KIrJXZ8KFHbn4MMniYcfpNTAyk1C2jeV1BvJo/mabjLjL/Fp+Cblal?=
 =?iso-8859-1?Q?5t8C/XBDthvMIrP+Nz7d22uC/MG0N4xqvaBJw01LrogF0pMjqkThjc78oH?=
 =?iso-8859-1?Q?fCLp+GCZneOdU1XcmxEDfZPGAY6vX+gpyyKfr6HYcIPj/dvWjwboG8D2lD?=
 =?iso-8859-1?Q?CJ9V/jYaPvzZ0S6T188uTGz7FC5U6Y23KRHo3WlLbu27sOnRGaChLOqd4x?=
 =?iso-8859-1?Q?OuUhmSawFumj2iVk2aEIjg+tkRAdBvMEAmVW/Xxo3rG0aO2GAXpv7yevPj?=
 =?iso-8859-1?Q?b65YwtdPl3W7fu/pcYh6etV8sxuZftQljy4o4zn1Ue63HnQ+mswiP5n0RU?=
 =?iso-8859-1?Q?AQ4ZWbruNSC1k7Omgcp+kSx8WcC3UFWxyrWRgrlYO9wqH/Tj9DKNfKLlSo?=
 =?iso-8859-1?Q?/rsz1Nv0/7Xo8l/SW7CQeOuAGVbUHVn2r/bTdcj80BfWGBqzvAvqrAXgxj?=
 =?iso-8859-1?Q?UznEzIpMl4doICo6pQH7Ik4CcDcJ4QFR6gFj1WMnb4ymQXS7IW18kszDjJ?=
 =?iso-8859-1?Q?CoF1nEMk1EEhJeVr2zYdVupKFUHs0ggBq6U8oB+X/GCw6/QSIBI4vCmh3l?=
 =?iso-8859-1?Q?vTjqjDButo6b4RHyczuvNyFOQ8NBSTmzLYZnfew6WbdhJ643ILfTKvX+bG?=
 =?iso-8859-1?Q?QFuK2xETb4qsjLTiMr9x/kxM7u5uC72wlXWw01GVnKiSOJX02lqazg9Tb+?=
 =?iso-8859-1?Q?rMEDtSanlKfNnCR3zvNLTjxPMOVQShDJ9NtoZPpyFfAG3dlXneKxoV3x9p?=
 =?iso-8859-1?Q?Tn1JXHOnyxvmC1Ita4u88xKX06mo7jx0b7yHS/zX6FfqHtXxaVMBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?GMgam8UvwGi0Cr7F3qtY6vwfTyh5msSs/qSDyY+fgBSZl248+7xKAqCefK?=
 =?iso-8859-1?Q?rFW7mb8VFj/bUfORgW7BKqvQ1b9qZZ3kwG2AZKOoWz15BXcaRwhqpP9uqF?=
 =?iso-8859-1?Q?Uj63pPua8krPU/zLV8CAiS0WznEZeHWYU7Y9Cy18VcgzChdEP5gRkH84UE?=
 =?iso-8859-1?Q?2j5TwAp7jQUgBQV01ROxGJ0ikHZqgq6zdh27Z7vC2Z2YlSHWufAp2YA2GV?=
 =?iso-8859-1?Q?ivUupR6eZgl8191X6dIYi87C1v3XnO+6wSSy9Yq/CdUlHncojdDjsdtCmR?=
 =?iso-8859-1?Q?b+BawT47weDxACLNUj1+kyIm0J/8b8YM79rk1NEJNKhpfy06RsVzkWlMpI?=
 =?iso-8859-1?Q?VhA+HXL+zGiBTkvmgXdukICYTlIDci3fn6WVW07sxTo+B0XKuYw2Er8iU3?=
 =?iso-8859-1?Q?hFpOrq7hmRYZtkpm1Yv+mEjCkZY3lxhU1WycysccAVgq6zirnmlHVmePJD?=
 =?iso-8859-1?Q?hY1mFT7/pgQW49N2Ngy1tfoTLmRW+kZMMOnGBOV9m3Ckbni+97NBQYTyZW?=
 =?iso-8859-1?Q?njvVUHY4X6kq8vTB3HwkpqX0IEzDYKcOAMO4AXXZVwTv3CDdpvPeemNP3+?=
 =?iso-8859-1?Q?PzLgd4UEC83C4yu+ANhDCQ49XqHpFaBBgU1Ll0vE/slvMlMGfyxPjSukND?=
 =?iso-8859-1?Q?72Dv8VIL1csUwOfJO5J7x0UYIlWIxVRAdclxmCO7cVKrETlu+qjvZt30vC?=
 =?iso-8859-1?Q?B5VG5m0Mt6b1Q85qfCFCtlYy2rhlLAyKnAZaJ63OycWgIl+mdRxy0Vj+OJ?=
 =?iso-8859-1?Q?J4ERHVc5vHVcj/qiP8SKi0EDMtIz40C5q1SrZAclwmdBoaQiI8GREjGbNi?=
 =?iso-8859-1?Q?2fjexHC+KQ8+xScJGoZH2Bbw0YP5feDNXp1dicgXj5jHxgxxiVUDo9DzZG?=
 =?iso-8859-1?Q?4BevnXOfaLlce1g8EJkQy297Sx9E7qFhLQ0ibR7OQ2tZekeDuleWm914+h?=
 =?iso-8859-1?Q?Qq6ixIB0N/vM+JuVoPLPfSTF6ChDLah2PUPkiXITj9PaxZT33pn+TavBwH?=
 =?iso-8859-1?Q?TKAPv51ISLKGEJUWa70DSl47k2vG8Jr7WLM+voKB4zPdEml7JIHEqVLrGw?=
 =?iso-8859-1?Q?lXtZbqOiiU9HjNE992TX743Xnip1SjiSFjf0W+CikKS10MR8UwrwJokJwi?=
 =?iso-8859-1?Q?gFoTGms3XbozOa5uiSH3xZOsu7vd6cq+FeIXKlYHKrKrGvcdIdb7DSOdkp?=
 =?iso-8859-1?Q?Nh9x/aOR/CR/JLU20x7gQm7ulu5wvBGlQvBI8dzw9YwNNV8p3v1scvL5+i?=
 =?iso-8859-1?Q?hcOLGXiLTWxfpE1Q6yvotzH2AfGqY6YBpEKK7N3tztlRzMNi9HAe+J77qT?=
 =?iso-8859-1?Q?gmKV1Bh5NoSHKPHVX1cGPg+8ceQoMsfdq7CX+NocoUvDBBA+2BLEMF0ldG?=
 =?iso-8859-1?Q?Adpk7aRKYKfqq2LeOX1doyEYWl9GleABdXoL8hIy9lusMr8XUfoBpnjxrG?=
 =?iso-8859-1?Q?1sw/D3E+EwBMfjdlAR2nhY4QzIFd+FsgIo0IIqSpep2WNiMtw39eFcXHT0?=
 =?iso-8859-1?Q?jS1fjxs30HGq0Vb+c8QvD2mNYU59t0OZnUzvZ5RyKfLsZvmLFdTUDoMGjm?=
 =?iso-8859-1?Q?+1C8U9pzNpdwjT/+t4Q/SVwtgWlUNzJRsJcsRNpqgGAExa74nmnbCi3bEI?=
 =?iso-8859-1?Q?sdqYOvj5MZP9WxrREArb/CnD8cecZaBB3P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tg7EwSZOICe/AAhXqV9T7neuVeiyDD8c321Ty2Lrrcy63qzdD1s2Yd0b+l4jd8QjNuyNda3GNKYiVtuSykthnsBaGSEwY2PQ1byKdNP+s/5Y3YVOYeskm9VS58ot7lxLILDrzTYHicNoCxNeQAKvV+OhVig1+VJQtmtF8vkAXrAudsoOPa/RrNJJ63lICXu4WHJpx9l5+PGijat5ppvH6rs5KOj9Gx+UJltjnogGkP5F1buvx3QaB/6/XiWYMKNDDmhvYqLr086fFCD3wFOuf5VmdVNvSQAEtF98tHoaLybhfs0BT5su3ThFraVeCXe+yirUMVlHQVuSAYafYI7HDYCnZPsgMP1CiahsAWUXCjJY9sjgq8HiUCbfVNPCDG/eGI8eI5YRkoj+FjQYX7k9ooQjtL+RMm7O/1zN1cro4i+L4n6kLcxeoHZXq5vu9BwQXgIhPePagkn0HnLzFk47pI69y3j68+uQ0Y4AX3f0yvloBEPf/b9LcnW9dgjEuzGcyy6648+pvPXfaU1PZ/4eCmpmrqnaLNmGTBZw3HauR6a4ZmYncIFaxjqohVqb0/FnSJpQika84v7O+Jzvq46l2gx4vSvmSHiUr3/Eu9l7QJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1310e-2872-46ad-3037-08dd0b05dd66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 14:56:37.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB8nC5kJIS2Ri9gpAKT308wifGIMSS9hTMXOOwjE7O6TqUsuyuTgqbZUV2VIfHELll5V92YWKUv5OcHQfXOlBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411220125
X-Proofpoint-GUID: JeUP2lkikTuDWEEEwKi52Y7x4waU4OEn
X-Proofpoint-ORIG-GUID: JeUP2lkikTuDWEEEwKi52Y7x4waU4OEn

* Andrii Nakryiko <andrii@kernel.org> [241121 22:59]:
> Given filp_cachep is marked SLAB_TYPESAFE_BY_RCU (and FMODE_BACKING
> files, a special case, now goes through RCU-delated freeing), we can
> safely access vma->vm_file->f_inode field locklessly under just
> rcu_read_lock() protection, which enables looking up uprobe from
> uprobes_tree completely locklessly and speculatively without the need to
> acquire mmap_lock for reads. In most cases, anyway, assuming that there
> are no parallel mm and/or VMA modifications. The underlying struct
> file's memory won't go away from under us (even if struct file can be
> reused in the meantime).
>=20
> We rely on newly added mmap_lock_speculate_{try_begin,retry}() helpers to
> validate that mm_struct stays intact for entire duration of this
> speculation. If not, we fall back to mmap_lock-protected lookup.
> The speculative logic is written in such a way that it will safely
> handle any garbage values that might be read from vma or file structs.
>=20
> Benchmarking results speak for themselves.
>=20
> BEFORE (latest tip/perf/core)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> uprobe-nop            ( 1 cpus):    3.384 =B1 0.004M/s  (  3.384M/s/cpu)
> uprobe-nop            ( 2 cpus):    5.456 =B1 0.005M/s  (  2.728M/s/cpu)
> uprobe-nop            ( 3 cpus):    7.863 =B1 0.015M/s  (  2.621M/s/cpu)
> uprobe-nop            ( 4 cpus):    9.442 =B1 0.008M/s  (  2.360M/s/cpu)
> uprobe-nop            ( 5 cpus):   11.036 =B1 0.013M/s  (  2.207M/s/cpu)
> uprobe-nop            ( 6 cpus):   10.884 =B1 0.019M/s  (  1.814M/s/cpu)
> uprobe-nop            ( 7 cpus):    7.897 =B1 0.145M/s  (  1.128M/s/cpu)
> uprobe-nop            ( 8 cpus):   10.021 =B1 0.128M/s  (  1.253M/s/cpu)
> uprobe-nop            (10 cpus):    9.932 =B1 0.170M/s  (  0.993M/s/cpu)
> uprobe-nop            (12 cpus):    8.369 =B1 0.056M/s  (  0.697M/s/cpu)
> uprobe-nop            (14 cpus):    8.678 =B1 0.017M/s  (  0.620M/s/cpu)
> uprobe-nop            (16 cpus):    7.392 =B1 0.003M/s  (  0.462M/s/cpu)
> uprobe-nop            (24 cpus):    5.326 =B1 0.178M/s  (  0.222M/s/cpu)
> uprobe-nop            (32 cpus):    5.426 =B1 0.059M/s  (  0.170M/s/cpu)
> uprobe-nop            (40 cpus):    5.262 =B1 0.070M/s  (  0.132M/s/cpu)
> uprobe-nop            (48 cpus):    6.121 =B1 0.010M/s  (  0.128M/s/cpu)
> uprobe-nop            (56 cpus):    6.252 =B1 0.035M/s  (  0.112M/s/cpu)
> uprobe-nop            (64 cpus):    7.644 =B1 0.023M/s  (  0.119M/s/cpu)
> uprobe-nop            (72 cpus):    7.781 =B1 0.001M/s  (  0.108M/s/cpu)
> uprobe-nop            (80 cpus):    8.992 =B1 0.048M/s  (  0.112M/s/cpu)
>=20
> AFTER
> =3D=3D=3D=3D=3D
> uprobe-nop            ( 1 cpus):    3.534 =B1 0.033M/s  (  3.534M/s/cpu)
> uprobe-nop            ( 2 cpus):    6.701 =B1 0.007M/s  (  3.351M/s/cpu)
> uprobe-nop            ( 3 cpus):   10.031 =B1 0.007M/s  (  3.344M/s/cpu)
> uprobe-nop            ( 4 cpus):   13.003 =B1 0.012M/s  (  3.251M/s/cpu)
> uprobe-nop            ( 5 cpus):   16.274 =B1 0.006M/s  (  3.255M/s/cpu)
> uprobe-nop            ( 6 cpus):   19.563 =B1 0.024M/s  (  3.261M/s/cpu)
> uprobe-nop            ( 7 cpus):   22.696 =B1 0.054M/s  (  3.242M/s/cpu)
> uprobe-nop            ( 8 cpus):   24.534 =B1 0.010M/s  (  3.067M/s/cpu)
> uprobe-nop            (10 cpus):   30.475 =B1 0.117M/s  (  3.047M/s/cpu)
> uprobe-nop            (12 cpus):   33.371 =B1 0.017M/s  (  2.781M/s/cpu)
> uprobe-nop            (14 cpus):   38.864 =B1 0.004M/s  (  2.776M/s/cpu)
> uprobe-nop            (16 cpus):   41.476 =B1 0.020M/s  (  2.592M/s/cpu)
> uprobe-nop            (24 cpus):   64.696 =B1 0.021M/s  (  2.696M/s/cpu)
> uprobe-nop            (32 cpus):   85.054 =B1 0.027M/s  (  2.658M/s/cpu)
> uprobe-nop            (40 cpus):  101.979 =B1 0.032M/s  (  2.549M/s/cpu)
> uprobe-nop            (48 cpus):  110.518 =B1 0.056M/s  (  2.302M/s/cpu)
> uprobe-nop            (56 cpus):  117.737 =B1 0.020M/s  (  2.102M/s/cpu)
> uprobe-nop            (64 cpus):  124.613 =B1 0.079M/s  (  1.947M/s/cpu)
> uprobe-nop            (72 cpus):  133.239 =B1 0.032M/s  (  1.851M/s/cpu)
> uprobe-nop            (80 cpus):  142.037 =B1 0.138M/s  (  1.775M/s/cpu)
>=20
> Previously total throughput was maxing out at 11mln/s, and gradually
> declining past 8 cores. With this change, it now keeps growing with each
> added CPU, reaching 142mln/s at 80 CPUs (this was measured on a 80-core
> Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).
>=20
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  kernel/events/uprobes.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index c4da8f741f3a..3f5577d4032a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2295,6 +2295,47 @@ static int is_trap_at_addr(struct mm_struct *mm, u=
nsigned long vaddr)
>  	return is_trap_insn(&opcode);
>  }
> =20
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_va=
ddr)
> +{
> +	struct mm_struct *mm =3D current->mm;
> +	struct uprobe *uprobe =3D NULL;
> +	struct vm_area_struct *vma;
> +	struct file *vm_file;
> +	loff_t offset;
> +	unsigned int seq;
> +
> +	guard(rcu)();
> +
> +	if (!mmap_lock_speculate_try_begin(mm, &seq))
> +		return NULL;
> +
> +	vma =3D vma_lookup(mm, bp_vaddr);
> +	if (!vma)
> +		return NULL;
> +
> +	/*
> +	 * vm_file memory can be reused for another instance of struct file,
> +	 * but can't be freed from under us, so it's safe to read fields from
> +	 * it, even if the values are some garbage values; ultimately
> +	 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
> +	 * that whatever we speculatively found is correct
> +	 */
> +	vm_file =3D READ_ONCE(vma->vm_file);
> +	if (!vm_file)
> +		return NULL;
> +
> +	offset =3D (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_=
start);
> +	uprobe =3D find_uprobe_rcu(vm_file->f_inode, offset);
> +	if (!uprobe)
> +		return NULL;
> +
> +	/* now double check that nothing about MM changed */
> +	if (mmap_lock_speculate_retry(mm, seq))
> +		return NULL;
> +
> +	return uprobe;
> +}
> +
>  /* assumes being inside RCU protected region */
>  static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int=
 *is_swbp)
>  {
> @@ -2302,6 +2343,10 @@ static struct uprobe *find_active_uprobe_rcu(unsig=
ned long bp_vaddr, int *is_swb
>  	struct uprobe *uprobe =3D NULL;
>  	struct vm_area_struct *vma;
> =20
> +	uprobe =3D find_active_uprobe_speculative(bp_vaddr);
> +	if (uprobe)
> +		return uprobe;
> +
>  	mmap_read_lock(mm);
>  	vma =3D vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> --=20
> 2.43.5
>=20

