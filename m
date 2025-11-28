Return-Path: <bpf+bounces-75696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E3C91F7F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D18784E3688
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0159131984C;
	Fri, 28 Nov 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TTH7sCB4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rd3TO2w1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36530EF7B
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332370; cv=fail; b=mp1wTvvknTDwDMvRutA90jJyFwrMX+zI/2XJAFanGA8FQuyccNYgpYZmIfAE1ADWRTsH7VAeugGCeYH2eiSGTI9F5NCv3f9FB29o1lkosomrvusZfFPj8kjBe5ukKeVBqwAc0WpeA1WxjeGLY2EaJe/Q7tczVbpyrv4VDfOKJm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332370; c=relaxed/simple;
	bh=OVXrJTX8LvqWUwGPTJZi/RCz/pt9tExW/rM4WIYjro0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odHCisWnBUPpT/bedldJlBJ16Kc1EYUxL9b9EKppTlidmbL9nrlNu5e2v28tUzMdmkZSAghph/h93uwhuheJ+vQd3rXJolWY3WcrYevEiGu6udgnLSssZyiIGMXED7TVm4lgjFpIhWG2OyAStEYQBxwdVoCIwt033Wu3sHXV3MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TTH7sCB4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rd3TO2w1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7uVg42969907;
	Fri, 28 Nov 2025 12:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7+VInqMUjTTk9BoJgt
	L9lv5I7L3CAjv+7uNe6dhkezo=; b=TTH7sCB4Hh89gQnOluwLWgOhxo6FfwWngU
	JJcr/HeRXPP3aJ6WZQMK5/sdB3mqYe6i6/remddPF/IesZuC5M6BTtV1slrTPlp1
	46wag2IKoKyO28pjxf+3rog58OlhbldNI0lLmWpot3YKiGVSReTPgsxIjd0zmdk8
	SLTkxm+qqBLnQHoDGPznJYdONdty9hZVwtWikAc49RrkFInC1c1LnEMXGsPFyhy5
	ETh8vGwqEPt8m03nMeqJjTTHBABQrfPE4pq4uUxuxABNRZwK23kKmc0wdI9NHlFA
	4dMM2thylxy8so13sVyPA0VBkAEFKJurLh2/Q4pKtxk7Lrt/iS4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4apm7vhqwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 12:18:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASAnwMw032105;
	Fri, 28 Nov 2025 12:18:29 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3md8axj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 12:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJx7xXV9ozh2d08iw8sLx4p2OyTPqO2YSnrTe72feF7QBbl+zImu+GJTPwPeB+R5bv+vz1QOBa+nN0PYJmsDRyIFDnxQCup44zJdUVbExgrpAc4JEgtBBg/HuK8aB38+uoO8qt8B+FUJPmrvQ16EXXuVcIkkL7tfp8JBBH0vauXKHuiaARVog2MLwXWQqlduw/1samUFY60GYAVwQbRYfR44AtcvBqrKoccjJw+VIZch/kuEaYnVUCRVgX3TADy0F2qt77J/yyQ2fApj1dasHXYERqmOXMV8kzciS4HVPRl+5FTev43l5tARNy2+DO8vJ3hHRb+KOKR7bU9feNsz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+VInqMUjTTk9BoJgtL9lv5I7L3CAjv+7uNe6dhkezo=;
 b=r7+tDdjzVEV0ho38OaEaEtZjELlS791FkwtZS9SbaEBhkSlLFMo9rWN70DX7sEhZ2P+LIDHVpIajJzBFnE67BtJ6DGCCDcqpWA4z4mcmKBEaLQnscArYH7oh1qEgF8R8g9vEg4AfQW6K63mFiAxvC39oysj2bSL4Z1xqh+T4JmUl7TCx2TY2JK+7BI/5Jbfhptk+jwQ0ohMM77M8t/vbQ1ZjbShobOZBBz4XvYt8hlhb8tKnEyiqhLUNzowUIP0fOGI2XjCJ0ZXvyOSxlJxSRiOHfQIqwjyaIbsaUz75AcISySkBSZy/VhAw1PWUNl+n9PsZu4xusMOQ547cuGYihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+VInqMUjTTk9BoJgtL9lv5I7L3CAjv+7uNe6dhkezo=;
 b=rd3TO2w1DS3l1m37tftmLWiHwuJHbQrnXXCCMBOPWxxukdbK9zl5RhmtWsa7qx5wOiQ9ZXgJdy4XHS2VffW0uzXqj2zWZjkS15m3Sly5FKRKsTi6/h4YsREvu1g3VZhb1kzZ9VpAjDfHEEKpdFiZev7JSdVnDBqT/4N3s7tI1bo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB997712.namprd10.prod.outlook.com (2603:10b6:806:4c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 12:18:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 12:18:24 +0000
Date: Fri, 28 Nov 2025 12:18:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Liam Howlett <Liam.Howlett@oracle.com>,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com,
        Matthew Wilcox <willy@infradead.org>, Amery Hung <ameryhung@gmail.com>,
        David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Barry Song <21cnbao@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
        Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
        Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>,
        bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
Message-ID: <600a793c-4000-444b-bb5c-2023f7198903@lucifer.local>
References: <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
 <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
 <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local>
 <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
 <f60522c2-e10f-45b1-9501-9b1e4223d8ce@lucifer.local>
 <CALOAHbCVGX3C6mbbH+e5bB2=Cnz-UVbEVBXZWP3fvhqGe9LSXg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCVGX3C6mbbH+e5bB2=Cnz-UVbEVBXZWP3fvhqGe9LSXg@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB997712:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d72e37-3e63-4dfb-6e4d-08de2e783a33
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?/0Qep2i7OQHh0Q8lWNkMrB8N7DPtpiBoUXrQwK9bW6GQQbFa5D/ubnFtqEEL?=
 =?us-ascii?Q?xQ3qO+zsr8sjWLRyqX5ZINcQ3vKUpqQinLW2VXDdVcMf+9u23YjCLxdgRZtG?=
 =?us-ascii?Q?KQqUbGZBPsSOkLTYQOgdCviNu/7b/NSGSzaCLT5Y8jl+ltB4SertsRUAkPoN?=
 =?us-ascii?Q?fnfOu2MbFnXmokvb9j2K2YQ1I9q20TEtKsDcciSH5IFdTa+E8kpYEwo/a0sL?=
 =?us-ascii?Q?8LrB45KdS5ezgXbradECH/XJGfq6WJQ9uUPqQAnvg5U0RhjzMvz++yVcB3MA?=
 =?us-ascii?Q?L7o2qIFa1x5CYDx710H3W2xxpODSGUvYM2FRjI6vKwIgnTtobUlRsUiK5Yk+?=
 =?us-ascii?Q?wxmx2U1FuYzNEgFseBxApePura4+lLApam5AOYMsVS5Blf/cYa1kvPnxDXp7?=
 =?us-ascii?Q?g15EkT9GtoOLamGOIgU2m2V3RA0/b6elDnEKU3QsiHbaBzF7fhCtK8iLOPKV?=
 =?us-ascii?Q?lAisU0dBmPj5QBJUPaY5qB9v1dfENRAozXmtf9Lc1JZ24pGH3a2NbQTeE0WK?=
 =?us-ascii?Q?dYL7aq9zyyD9L66SihKEIF6yfiHumNHMZhYl56oSjKxlJ2chwz6JmBIs8KRE?=
 =?us-ascii?Q?9j/fKw7axzmRGomDq+oThXnuEcw403f/38t4jLQw5jWC4kkP41dCxhis04v6?=
 =?us-ascii?Q?LpL6Sj6v7BCcHjGJvg3r8gJnrAYtaeoF2qxXG+4sZ2RKwrW054j9zl12ky6y?=
 =?us-ascii?Q?fn+oUBPVH5HNpoKVzi3Ol36zQQ2lAZdVfhnXk3kc5+RnHZcMbtnOQbkRdHjO?=
 =?us-ascii?Q?AFhNikrm3mlK2LG6GwkZW0sXCW1AXgzQau2yqGEZXgzYZTC3iX5Ao22fn7DP?=
 =?us-ascii?Q?W/Z+K3NIuikjn9ebJaAgpeYeQhNHIxkJpXdvvMZVVnI259s3KjqZpgXkJjXv?=
 =?us-ascii?Q?jTyWxtRc+z59Ci5gzumOx0bU2oCFgagW8LW2EQQ5Gag2liS4PAHKan+CwGGI?=
 =?us-ascii?Q?GzS8XGo51wTw2xlc/MfM9NQg587Zaxn//l8UlbAebug7rnQkW39q+a6rTyc9?=
 =?us-ascii?Q?EkpQCcaS5QHlqDeOBV8a/nc54CcoFOqu0wResGmvrvzBsRhM8LpmfCILwz8S?=
 =?us-ascii?Q?R9UGSMdEEV/oE/ojNsufdLTVEm3Wg6TBYZdmb4Ak7JYWiZl1PvItCenQsyzT?=
 =?us-ascii?Q?DAK9WbBJ/8T/2OU9uX16Aw75VS+B5h8Cue3pncXymjMw8a8ujD9OaEXX9zDX?=
 =?us-ascii?Q?izvLnNrm+l291m4c8AuLB6V+k6S/3B2wZmuvT7C48xbjKV1Yk9eOa+qHs+cN?=
 =?us-ascii?Q?kDVnJWTpGWf0fjdnOoLfTssVYe2NuTIe+vipT2DZUQNBClp/0AKYFbAKzgqN?=
 =?us-ascii?Q?Vy/EYn/+Utxy1tDk4p04di2isjXd4wHhrEIccFertM0ol2EybgtXzzD70z3J?=
 =?us-ascii?Q?iJvPNR4E6MU+vHxHoAUkscsAjpK+6Mp7c14vH5RhDGF7Dctod8MbS9eMC9c+?=
 =?us-ascii?Q?LxiRS+U2wV2KNmgPkLhbuoy8rCB5FcKDdv6YkOnd4htb3bB4IoUm9w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?81GY1eTeMvPJtpSECprho6VIHhxwj97gSBXscQkTF6fQqskMToIPHsmfbotd?=
 =?us-ascii?Q?YOFPkjXbKRRNrjmUDCmQ4kI3kzz1Yf2riDou3gm4zpSWjqLUPCjoJcwSJqSW?=
 =?us-ascii?Q?2aGkc9G7Toz1DMZ76cIHFPh8L6+hISlsmW6D37i9mDZYaPBf8jaufbTfi7G3?=
 =?us-ascii?Q?mf+Sb39zmpZxktJyEPOGURWKK18eSmGndLkpNkd2C5miqe9mJ0zFqY3NrY4s?=
 =?us-ascii?Q?i2nddIbR3Cb1wgbEgXLyfyMsR1kbLHWYX3rkmA1L7gu8JcFuImX0HUbUq9Kr?=
 =?us-ascii?Q?lZLdb4mLY+pPyQd95hZQ9RcMxgwnv7PNUBQmclvFuhl+bLMZqBl30X+U8uwa?=
 =?us-ascii?Q?WfW97/6JUI1uNLng9oDXDiButBKgSJgg3Hbo+bMHqvsVq6eu0EKNqxoSljwG?=
 =?us-ascii?Q?TsON+ZPGoNOZCfeiWDoGDkROaVqd2/DhYtdF/c+59+Ag0/l7I6+kNa8g4R6A?=
 =?us-ascii?Q?ZV9uhfVcORluxcSSy6kETWJJfNeGwpeIrIoCpW1iVH7xHzV7mNd34MLHMCPr?=
 =?us-ascii?Q?9R6Ztbpuuwn7iILYncGem5rC5YuMtJ62DrmvBGDfW1iPN6HDTV3k2Z1SP4+k?=
 =?us-ascii?Q?mymFviiZ3FPHDhCf1zdfzjEMiY+IviJ+wAGpaHK22lF9TcdCJu+TCRl4Ur6M?=
 =?us-ascii?Q?AaqLaUab586uvwPDJpeUsvldTx3TdwvpaDQ2YHcz8NR3Etk1QD1Ycm4V7YfA?=
 =?us-ascii?Q?6iTg2+Z8oH6lMDvI9lls7u2ZUT7/vebT2QkCIqzMONSUBu4z95nBA1j1+9xJ?=
 =?us-ascii?Q?B8OaoqJnbKPdN8LmlKezbHM2SyBqop6K67W5RxLSnGoBHLX7pdytdbzBUFfI?=
 =?us-ascii?Q?+zTdXgWx75bF/4/dxTgXtoh2uHXPTNy317yaDzPQWMTsflMjYNF7anxxHGBl?=
 =?us-ascii?Q?EdPuOi1tbOZU46SUoWIHX4e+TSWO5LPTMTwZx1++Fo4Mcd6yrzU2TUKvlRm4?=
 =?us-ascii?Q?1eIZHaBVBeRxdtgjjvX/vMu8bPDmvl6/ZLKyDFFD7xKMopJ6Blisy6GUkXl7?=
 =?us-ascii?Q?MNJqsZc7kYpKBv6rRgrL0wt4KU895031F2hSdyVGAj/C94Dc3wcqpZ+beetD?=
 =?us-ascii?Q?/NYMrASDosDnnfDfw6KV1XxkT99wjUK4ol1Gs53Nza6QLvwmlH51snxE2t3/?=
 =?us-ascii?Q?j4X29QS0yBT+vC0Y663bXnkTcYHoSpyDqwmLW8the+ErC7SchkclHiT5BW7c?=
 =?us-ascii?Q?hHLm1McHg7r98mm6jPBA1ojpM1OQ9F0BYLN/6Z5kaolbHCznLQAf1YUvfvo8?=
 =?us-ascii?Q?jAW7r4bdNPW0yIr4v6sy025X0T4xSybVWaM+PuxPmpY5TXVU6VUhZyNYiwBe?=
 =?us-ascii?Q?swtC61cBMBZcJNWO9fPWgzPFnWOfpEY54kkkMpc4Q2E3tpMvFXs3LAX6EpEp?=
 =?us-ascii?Q?sOH14Qq4M/mg4asa903GiWLnYJvw038h3BTzqGYmUD/PjFncliUPvB8M/sg5?=
 =?us-ascii?Q?3hPaMQrwcET9HoPyIRi/fW9FJCDjDbYctmAkFP32gcLMcpMzlh+tK3yf8MPg?=
 =?us-ascii?Q?tVewXIzlWa2z2OhlK41aZ6bzRyEdbqXIpSF+9TiFwxvDBcW6p3hfwCdTuY/s?=
 =?us-ascii?Q?fHpvC3Om7Cm+kCiJYJSMySWOLE6ZbW0F9rQ+ELvv3qGfTA6znC7LPJakjzg3?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nC2T92MkvFtmx+cysjaPQ+FvYMF9EAHDagpb71wA0nmYLmLC0KJt5m8QoEsGCMdUDhtTYQfMrnbv8llKx1NsT+7UffFFJ0SzDTvB9GYD7lJnGeqCIXMF2nUIggRksKNmbM7sYEkahsLNrNIeh2csNaUi0JmjWBLXZbaHdAHFcSg2ygypn9qQwd1yqh3xTSApQpyoQMK42R6K8leHlan9LNc1NW+3v8U+lue/pikp9ty+v1zke5FVcurYO00w0V+ha2UItKEbSmI5jtaUEF/mlhQuJgGSf7fEgyKYIZLAauv8tvP9m5rSnGQi3hWYNGmRGAcnxSq/CtZAz3R2sp7hj6LC3/mxght7HVmuW4gLDri8hPX7kdM4WZJgt+mfWuP+5c+RuYA4PrJu0Vn4fh1pio1ucWLcYn6qN2lyIQHCRF8+gZQu8RWn3IoVfujfDGdlRWN1QI7hSPA9YpfdQl0YPiyuyxl6vYWGELALCy7bul3KV/Hfi0PIs0qBRszXdTkKGi6cTAoGzyaqgg56qlx6KIWIdvFnLJWXVDgeuWbLhxEQEqFUOkVUUO0QY4DATdncamnbYubqbkREsZ551gSXN27yddJW/l4VG/UeJV2K0Uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d72e37-3e63-4dfb-6e4d-08de2e783a33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 12:18:24.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEujLLz+/M400dSMqjbr7fUT9KG0NoCmx4ot8qlNknn2cRUrqLi63pxYAE6uYo6N1exfmVhCtXLL+Lq59KR4NEnuNzokF1IvmVFL8ASInhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=855 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511280090
X-Proofpoint-ORIG-GUID: p-ikRxDlPLyMgX3r-S0Mqy6Uk5JpJ26a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4OSBTYWx0ZWRfX2+fGLkAY6XPR
 SoRLkxY2febpUnNGJD1psx0r5KOzciWkImCTRzn7dygF6TQkKdpx5oI5uuraXcr3ghVXsfTLf51
 mldmOce6Po1F5+8GIuTUZdgqQW+Zmwx4kQqoH/Z+vnndYqNZsGhZsj7uEx6vunEje2ZRFEJoQl6
 gfM5Z76flFjzDYwwy7CFPu4nNAhk3EpMruyQzu3YMOnBROe57obqq3oy9T18KjDED+ipJOSOm7h
 hfh0qAeSAEtARGrti9FYrVM8ZARGyK0MqRgavFt5HfXR2ZWU8LwMSeR55Pk5UKw26hmvG0EVh6P
 P0pYlVtWwTjGAvReESLYKtCOdzVR37Y+dvEUbH8+pS7QeZbKSzvvJoriXqT5Mbr2HLKoUv5Ko7e
 zi66JNNmBPt1/a6FcOBsS4N7iQ2A5A==
X-Authority-Analysis: v=2.4 cv=A9Rh/qWG c=1 sm=1 tr=0 ts=69299316 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8 a=JfrnYn6hAAAA:8
 a=iPbr6uFINzrz2maRKg8A:9 a=CjuIK1q_8ugA:10 a=yzZZxD1ETDaWDB-n6lAJ:22
 a=e2CUPOnPG4QKp8I52DXD:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: p-ikRxDlPLyMgX3r-S0Mqy6Uk5JpJ26a

On Fri, Nov 28, 2025 at 07:56:48PM +0800, Yafang Shao wrote:
> The CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag was changed in v9:
>
>   https://lore.kernel.org/linux-mm/20250930055826.9810-1-laoar.shao@gmail.com/
>
> The change was suggested by Randy and Usama:
>
>   https://lwn.net/ml/all/a5015724-a799-4151-bcc4-000c2c5c7178@infradead.org/
>
> At that time, you were on holiday, so you may have missed this update.
>

It's moot because this series isn't upstreamable, but... :)

To risk sounding grumpy, in future do please make sure to check about changes
that contradict things maintainers _explicitly_ ask you to do.

You can always off-list mail if people take time to come back to review.

Thanks, Lorenzo

