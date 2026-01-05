Return-Path: <bpf+bounces-77813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D7CF368B
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500F43049E07
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0166339843;
	Mon,  5 Jan 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jrZeHOJW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tmfWWaVN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4E33344C;
	Mon,  5 Jan 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613885; cv=fail; b=UHWjZumO+GUUpZXgZyvQxkU3o0Lwoz2YyAYQDb0vnhn7FyF2v76oR8AMTNcLsUD79uKmAatDUcLU8Gy+78CWCUamuVCyhE/QJ5CAkK30UeUJOMUD2lNe6Il4IP0lymPbzVbWugQgROj+uD/78Wq2yNJdSqHKGb8iwoOgEZ6Rzjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613885; c=relaxed/simple;
	bh=WmLoLzbAeUfPB/TNka41UvfL8PIurcHuCM5wiYHTx/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QrTVo4vZSXLeLtIEqzXCuS7lUQRCnEoHowgyqPKKnXivJYI9qwAuWcFV9QfpZpFrIgZ0ztWn0B4Xzz7jUWRcZzHX/6t+eC0p/xSacDNg7T24Vg0uz9tXGbPRnax9xi23bMnAEtkiCFRkAWhLiLYfhP3ugu0gJlgj9Q/muesVUSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jrZeHOJW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tmfWWaVN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6050xYWG065215;
	Mon, 5 Jan 2026 11:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YGrcPsg23fdDtymSZC
	Pg56CDHZ/xzfmyEG3udSI+4R8=; b=jrZeHOJWIw7tDmipZQSOKHCsvXVJh9a9qF
	gg6+btp4sg1+GHiq1JPTs4/pubMnvVR44VAF9fXWaGqWpavoelfGa299oMWk6nXc
	0Vne2bC58lw/sUEFybaQWHOxuGj4zxlNT11t9nI2YJKIRbgqRuvLH2E2Z/o/s9J8
	nRBzqx+Eqcn1ZiqT9NyWgnhSq5aQcRBejA/DqD2CZOS9yIoHf+BcseTutjRMOPQ/
	Ru9spPRyhs+M5mEhRxCOYNqeifzuxyROdcd5vhZqsXTYYpNufxO65SvyZWNj9mM8
	IcSegr3s7JafyU5LVS2nL6IQvMviGtHCdP/+NF0kOrGxCfxNdYig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev1t9jgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 11:50:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605A3ZmE026331;
	Mon, 5 Jan 2026 11:50:31 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhhwwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 11:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGP74tTpR5gL+YGSRpKjz+VxAw9upOtjnqSAde+MipJmX7LTWrKhuyTHs8m0wLvT8FtMqDHEmqYcuZgaQX0nJegGjvPcdHpiT0EaSLG+JU1mFAFhaIpBHsP+IX+1+vezVoa5Ah2IhCxPavGWOK/fHxhDC/0F6zsJK0jXtonW9bFaq0nDVVQOrXvhlfdfUxDv0DBIy35ESvBhZorxBwvNPSaIEpNHNUD8OXTvs1Oo9ihevU8qYyj5E0a9tZ+kh6bR8KzEkf0qNtTiQZZJ6DQT/xeYxxQfd3Y6UlRFcUx4qanWSkMed/YQ5O9eVKj1eLbxLybhiMRYXHsjp6PJU8O+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGrcPsg23fdDtymSZCPg56CDHZ/xzfmyEG3udSI+4R8=;
 b=Az+/3h2C6a9KPBfrDPOii4JqKCaStdEKsBfASgRy6B31WlyaWqjGIN92ywRJj3NkV8U2tfVFhGpNTKvUa6TuCVAxCcRkTCU+U/18lYweVFh3NAVuoeCQOFdXzseWRS5txwokxe1nIieN7HjfnuxpVP1FNVXkogpiBRaSp9rWyAz2SlbXE6a+VQYbMZZr/a7UbG05l4DIaueeAobyqLEych25nOmiqOf1RwU2I6wDUKiStJA8ChNUHTciMS7SXXmmRZxXxhxVqCmPbLMn59oDH+v4pfnzONL26/2Mxqi22vrkrw/GyvVa1hlb2ds/DHv8E8x+sZUB6Hvsx6YcIm9QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGrcPsg23fdDtymSZCPg56CDHZ/xzfmyEG3udSI+4R8=;
 b=tmfWWaVNNyDGjhJA0pO/72qnh0whec05yWZwhIoWpbofMghe1nyvsHgj8yOYX1u6UDeFhFsxPAugNAYvff0Qsm/II11dUWFsy2GcvwhL2FPYJRqUMBXPohQW218PAQhqE7KISbiiB21TerxWJ/a9INA6coqmeUDHBO6yPvLzsVI=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 11:50:28 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 11:50:28 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: WanLi Niu <kiraskyler@163.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Menglong Dong
 <menglong8.dong@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, WanLi Niu <niuwl1@chinatelecom.cn>,
        Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH v4 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
In-Reply-To: <20260105071231.2501-1-kiraskyler@163.com>
References: <20260104021402.2968-1-kiraskyler@163.com>
	<20260105071231.2501-1-kiraskyler@163.com>
Date: Mon, 05 Jan 2026 12:50:25 +0100
Message-ID: <87eco4nuri.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: d61cd332-2843-40ea-d902-08de4c509ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1rq3UljqTST0WGgfRUAU6rnHCmy9Ja8zFQ4mVS5eVNNFP+PE/fUTQvvKnr2?=
 =?us-ascii?Q?u2rN4LgHv1MYoHebm9YotHZ8nVLcpfBLa3T7ndv8ht5IXGRrsN7AADyifFbJ?=
 =?us-ascii?Q?F5/FW+rv6mfBGYB0wxfPyoMHTAdp/y/SAhokkAwPcoqkHk0W8TxSl9Z7CaeQ?=
 =?us-ascii?Q?3dBFvPE8nCloBoeVgXO7ZKVYjA/ge8Cd4M42ZGIm69iYUyDYmHAiV2j+wJiJ?=
 =?us-ascii?Q?6+yyE/DNI6jCXVZB/MDtr1JDNWHA/obwLIHFOwD9VHXpchqdqq7wBBB/nI12?=
 =?us-ascii?Q?+cA6wKsxD4CPAnlH8lY+GW449bJCTCZWjQp1OjZbv1NRo6jhTdNcCwBSUsQY?=
 =?us-ascii?Q?cEEXX7NXjpFY1hHEPxm8S612ww+QSz7AfwndO2GVgd+SgyGahSaZLZRg4vT9?=
 =?us-ascii?Q?/NEU8BzPGQynn3J+DwKLyh9s7XMb0hRFsXfv+beQS9ufMJdOLdTtNUpLytNs?=
 =?us-ascii?Q?cSpEFKcqaL/45I6WrMhDH/a6DK26ds7Z9/Ogm+pFU/CiaKrLaMEwftZvBpgP?=
 =?us-ascii?Q?QZvuRCrTsj4IaBymS7t5sohcotw6yOLWioT3/SELQly4eZtaxirT3h76HDY1?=
 =?us-ascii?Q?k8ATKSVMMXsnvo7qX8ZrWOBCSO+xoFd17OHSF6yMk5QPOG0c3KL7QdCzeN6A?=
 =?us-ascii?Q?FetYSpjJMG/Mwh/xfCz0xG66EbVgwdUuHRW4a/tSBvMy70plc36uRNhzqZ52?=
 =?us-ascii?Q?NbUO6CAWcEkBBGbsdLt5w+LpEPpfRirxFCxVVV39ZcAosZH69YBlGEkDoiT3?=
 =?us-ascii?Q?xQUmuyRZxh4vfKiTfmHpVUTy3/7zOfKNeIWQNCATOgaer6PEKKbrtQ8kWkji?=
 =?us-ascii?Q?tI1LdVdXMTZ28XUgVrLx5lynL2ZqVUeoByWdZrymdA1QTbABFlItLY5Q82Jb?=
 =?us-ascii?Q?oXgY6Y/nyubH0VtnlGL4hUkY/pbFl4WzsuIk9kHE5nQCovMbYnwz4zSVd68p?=
 =?us-ascii?Q?9U5TllSzlR+masWqUT3JMH2/AxpGZjxIVo9w9uV6tqZhiIL9ASABtLtL4DkL?=
 =?us-ascii?Q?pl7RgU9SrbG3YiBMKNMQZWEpqHq1eBq/ka2BGrnxb6jSEm3jN7hLWc6LXDCF?=
 =?us-ascii?Q?4UggMM1kc/utd4ZC84sTlBC8fU6Yruf5Jxa1avijr+L35QyvEVUK86N8tl0L?=
 =?us-ascii?Q?O5hziVrAtGLF/JAWAY2NtJQvULVRh/iD6xZ2LnAmgy+4ZekvqXanFvr2fUgn?=
 =?us-ascii?Q?dq6HV4jvTY8GT+IPg2dys/4x4W+rZKJc4EEYJoULOXK4PWThses7LeW0BW9f?=
 =?us-ascii?Q?DGnuFknd8Gjg88IZIRqqbdX/RB9nuBgYLmMM5MWj+3v0E6LbEZ9E9Rb9TKXy?=
 =?us-ascii?Q?5w5a/ywJJh1iA83A8K0Qk5JV3hUDZj9M+XnOSoS7oGBdqbNTYbrGUuKbKync?=
 =?us-ascii?Q?/pzLscMmwhMnjxbI2g/ZmoX81BG9Nw+WoOVJiS9FKW6XE8yPbbIWyHIfQrmC?=
 =?us-ascii?Q?b+tG2KvSKcL24vAHnh8OeYkYuBvTL+iR4KSrK3sD0kFOosD8TX+teQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvjk87VZ5rq4H8cPmc09vYmP0IGxHb1BzoJHe9eRI/3bru+baMoZunwniciz?=
 =?us-ascii?Q?BAdBOBi9O68nYyMDE+H1am5CjJsKQS4NdlVoOBrPxVgGLDCfIsBCTmShKi9h?=
 =?us-ascii?Q?2+LJ+I4lk17w1ib1FXB0wzAx0EQPqu/WyZHxcpygurXDOZhPL5cLVCiGluL6?=
 =?us-ascii?Q?cMJ+aw5u66qTSTCKvAGwlIzRhq8S697bBI5hTOmm1Lef6Xb0zvDUJFsgazwj?=
 =?us-ascii?Q?1omREFz5DzIGb6TYvCi2wqhhc0wHPa+ebuykKal55UudVz0/EOGUzQhqFOja?=
 =?us-ascii?Q?jlAV/8GZyctT9ndIAeROry/MEn6dDRPCx7SH+rR5M0wj0obWM1DH2PXjCSPM?=
 =?us-ascii?Q?aWzHDdxU2gEAYVe047pMnx8x+2yP5vS3QXu20et6/x1P7BI1NtUUB06jLWZ0?=
 =?us-ascii?Q?m3vdLqrus1rG5BZtsP9PwRzARMhYjKbgntS+77k4dQUjpABGCFs04i5BD6qK?=
 =?us-ascii?Q?lyw817CDW6eg2eFfnbTyE8uAx0GgPR3W01TWMlXwAb+0nf11pt5ERhMwxghg?=
 =?us-ascii?Q?UvSfZX7Y+8eOFtbWIu/F4pSQD8S8cO/FlnMHp+WkoJIsiF+OjLvdopjO/ln8?=
 =?us-ascii?Q?a+lpFknK1becz4Kz4fFHVzWsxOa140mlmb48zNxlxYsRIvvbGqRiv0SXffk5?=
 =?us-ascii?Q?E1R7hXhmo1DJh/E7tuY65ZtwRJJ5mkTFKJfB19KhhaB3QF4sef6KYatB/Nwq?=
 =?us-ascii?Q?KAQQU3r56UXDd5wbep2NXJG/o+iyafjWZCHLa2DnMqQBkSpnAW2k5h8+mEVY?=
 =?us-ascii?Q?V6e19bUcAUmwjGrTJHtLEQmni5wTwNda/qWKJpTcB6Ko1XM2RCevvFNqKOWn?=
 =?us-ascii?Q?y/INb7AQoRlUy9EWkTSOwbRteSzNmnhii1B7rGE+4rL2opGXPAdIVCafAPzv?=
 =?us-ascii?Q?8xVbDQFqPF8trTlLIdLx0tro4nFgP6LCJCQ8pLCvP0lmzi0TZGz+FjDHLfMQ?=
 =?us-ascii?Q?33U2M+sScSu8iwCfleTElSfp0qN2LxEYyLLONyJkWV6I1RkwtOdN3ybN4YXg?=
 =?us-ascii?Q?/5wZdNMkgYZghUS7qgnrhVCNIde/BG7V0WxtLaLgcuzBsNgR+Z34tbHEhZ8g?=
 =?us-ascii?Q?MRp9PQSAfsCtZmy2eBLjbUqHDGPuJ5fPphszu5MR/5YSiEBfp23GQvYIBSy4?=
 =?us-ascii?Q?kysNIiWC/vvGVObIsg0SeyuMheM6swC0XjEHzTClSrHJp9F5FSzVbuLa3guP?=
 =?us-ascii?Q?HKdYQf/msRHSbV3tOz0gnFduODdzgtjVyqIqPIurNtCAM5iK19YsnvePLhsi?=
 =?us-ascii?Q?GiYnaKEk8lVhG/hIA7cV5nNQgNP+m6OCiIns0QpzE4dggkSCtHbVbt4UIcQD?=
 =?us-ascii?Q?9l+6PKZhmCnN/5PA59R2GIXL6rlpu2mpmpGqtPYuymME3c8pW/tFKEO3XNwU?=
 =?us-ascii?Q?oXmuSJ2hdvQi7x7Hbri+JbXxtxJ+RXPN0kGqJUpaEqCY3APYbtZr8u/Egp74?=
 =?us-ascii?Q?7vBjTqRvMrjApHUFY4Xh+CRAwlaNkHz5ItCUvQZiFeLeStbFGyc7ackJB0iX?=
 =?us-ascii?Q?HJb2xyjmz3qQv42Stk6C+h9NxUp7mQCBC7DWb4Kx5n/pOVmHkeGhj2D4bK+Y?=
 =?us-ascii?Q?BZO2hrbM5nrwdXU4Eg0UsgAwKh/Lx79WYq/nHnBmaHERuwLMhWrMCK8A9mJH?=
 =?us-ascii?Q?xz8wfFUMVwdfDsjQOXrrmIUbMbp715rkCjDgPro67GHA7wOiPdF4M4S6XtBh?=
 =?us-ascii?Q?d0NVVltJE78eON+b+pCK88JYFZmPrQrgJ5voGmycL9zdzJi0OKmnZb5skZEz?=
 =?us-ascii?Q?Z1ehdgmUZImtiqYWO8qNL9fv5d2ampM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Snlet3zHLNwAFMDbZLSI1+ewQItqWyMG1Hsynnh//3fNG5X2Iudy8HjL8+jPezLh5uEOla8BruWZrKU3NzltlwsaBG+6nBpkmTbGPTWf6uDOKNRaRVj4NX1YeLSzDckCiNjZ92gGWeToDeuQzn4ldotffqJQBCG7Swrw++z8L6arU0W7SkR5AnPrrVmuylyY3u/awODYVq9ihG5Q8UnKiIq5JxsxAVwcMpHqSfHGeZuuQfdPsjS+JIf7icPeCQ0aAK1GwFEkKEVju6UL0h3mVuyT6MMTOqKj4cXiJWE7iHbEPb94tFBkss1zJnzi12friduk7Fg5PDLAZ1YJ07aW1pQicHO1gODL3U+iRfWVTEaqzGlEey9JD2jIujh+0K8a7lIfGKDLtKlgJO8lhtGThDxbkdeJLZyiJW7UPZjuh9C9XvaIS6JGbQamg19QGxoT4wpl83vke1drRGw5qmjj60WhIEMY4/rC40ki8tdsPzbE1tiBEUnK6lRXcfByc3H0wlRHaBFX6bJGsXEHPszNrewE4rMAkKYvqWvuToZB2BwnxKKj20D2BhLYdegcu9gocb26RIB2lWR1flI24AXA1cqMX/ega/S9nOhj8B8UDq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61cd332-2843-40ea-d902-08de4c509ebe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 11:50:28.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snkbvusv4xL3MnOqJO4j8M3IA5C7PodJylUodN02JRIiRd44OFzA/aqvpE/ucTThrBmcFP+u7nxYD82Aic5rYIMYH7mCYa7dnih6XOznedI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050104
X-Proofpoint-ORIG-GUID: LVUQQfcfaTrLkwIncECqXOx0ujycsmQW
X-Authority-Analysis: v=2.4 cv=CKknnBrD c=1 sm=1 tr=0 ts=695ba589 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=_h3aBy8qMJS52DN5VkcA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwNCBTYWx0ZWRfX0d/UVPltisrX
 8Owynqui5aIQ5Rz1daw6D9oOIfIJpkYoJAti7MVdmU6A+mmG1EG3D9qEYfZfUewSGbp37QYgROC
 7nMy2m6f4OuF6JUBEge/+bEl5DMaXvkSdBuDNT9yrO9ptlhvnrEHgCoyEpjYppBdbnhhquiY5PH
 iGjGmgrmmI96jXR5Vw2htefDRPhT5mpuIzlIzMfdZ6YZCqgoCxjeIZRgr9yIrUz6u8bRN5bEk5k
 cCn5015NIGaFk4wa1jq47J03HYsVe9bG5eyHPQ9HOW0csfxd0gGggPtQcA99yoxxmu4PfvA/CqO
 8ZBNeZa4Wu93c6QuIh5EScNaWEBjLfgeHuJOnylz8bAae7YwyC0H9+8BDSkqmpFNQsmpwgFUQGr
 IF2WtQhW9GSrVqrKhP00dGNl7ZSqKlh8v9uWwa9TaYc443ZLzBu1gHvwRPGXruU6YKNWnTqwCDN
 +S1ChcFIRii2BSyt92oocoFQEsLYt7VQ9Nl3eATE=
X-Proofpoint-GUID: LVUQQfcfaTrLkwIncECqXOx0ujycsmQW


FWIW I tested the reproducer with gcc-bpf and got no pointer conversion
warnings (not that I was expecting anything different, but just in
case):

 $ bpf-unknown-none-gcc -std=gnu11 -I./tools/include -g -O2 -c text.bpf.c -o test.bpf.o
 $ bpftool gen skeleton test.bpf.o -L > test.bpf.skel.h
 $ g++ -c test.cpp -I.

> From: WanLi Niu <niuwl1@chinatelecom.cn>
>
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and using integer subtraction for offset calculation.
>
> Use struct outer::inner syntax under __cplusplus to access nested skeleton map
> structs, ensuring C++ compilation compatibility while preserving C support
>
> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>       |         skel = skel_alloc(sizeof(*skel));
>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>       |                          |
>       |                          void*
>
> error: arithmetic on pointers to void
>       |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
>       |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>       |                 skel-><ident> = skel_prep_map_data((void *)data, 4096,
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                 sizeof(data) - 1);
>       |                                                 ~~~~~~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>       |         skel-><ident> = skel_finalize_map_data(&skel->maps.<ident>.initial_value,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                         4096, PROT_READ | PROT_WRITE, skel->maps.<ident>.map_fd);
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Minimum reproducer:
>
> 	$ cat test.bpf.c
> 	int val; // placed in .bss section
>
> 	#include "vmlinux.h"
> 	#include <bpf/bpf_helpers.h>
>
> 	SEC("raw_tracepoint/sched_wakeup_new") int handle(void *ctx) { return 0; }
>
> 	$ cat test.cpp
> 	#include <cerrno>
>
> 	extern "C" {
> 	#include "test.bpf.skel.h"
> 	}
>
> 	$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> 	$ clang -g -O2 -target bpf -c test.bpf.c -o test.bpf.o
> 	$ bpftool gen skeleton test.bpf.o -L  > test.bpf.skel.h
> 	$ g++ -c test.cpp -I.
>
> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> changelog:
> v4:
> - Add a minimum reproducer to demonstrate the issue, as suggested by Yonghong Song
>
> v3: https://lore.kernel.org/all/20260104021402.2968-1-kiraskyler@163.com/
> - Fix two additional <obj_name>__<ident> type mismatches as suggested by Yonghong Song
>
> v2: https://lore.kernel.org/all/20251231102929.3843-1-kiraskyler@163.com/
> - Use generic (struct %1$s *) instead of project-specific (struct trace_bpf *)
>
> v1: https://lore.kernel.org/all/20251231092541.3352-1-kiraskyler@163.com/
> ---
>  tools/bpf/bpftool/gen.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 993c7d9484a4..010861b7d0ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  		{							    \n\
>  			struct %1$s *skel;				    \n\
>  									    \n\
> -			skel = skel_alloc(sizeof(*skel));		    \n\
> +			skel = (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
>  			if (!skel)					    \n\
>  				goto cleanup;				    \n\
> -			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
> +			skel->ctx.sz = (__u64)&skel->links - (__u64)skel;   \n\
>  		",
>  		obj_name, opts.data_sz);
>  	bpf_object__for_each_map(map, obj) {
> @@ -755,13 +755,17 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  		\n\
>  		\";							    \n\
>  									    \n\
> +		#ifdef __cplusplus                                          \n\
> +				skel->%1$s = (struct %3$s::%3$s__%1$s *)skel_prep_map_data((void *)data, %2$zd,\n\
> +		#else                                                       \n\
>  				skel->%1$s = skel_prep_map_data((void *)data, %2$zd,\n\
> +		#endif							    \n\
>  								sizeof(data) - 1);\n\
>  				if (!skel->%1$s)			    \n\
>  					goto cleanup;			    \n\
>  				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
>  			}						    \n\
> -			", ident, bpf_map_mmap_sz(map));
> +			", ident, bpf_map_mmap_sz(map), obj_name);
>  	}
>  	codegen("\
>  		\n\
> @@ -857,12 +861,16 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  
>  		codegen("\
>  		\n\
> +		#ifdef __cplusplus					    \n\
> +			skel->%1$s = (struct %4$s::%4$s__%1$s *)skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n\
> +		#else							    \n\
>  			skel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,  \n\
> +		#endif							    \n\
>  							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
>  			if (!skel->%1$s)				    \n\
>  				return -ENOMEM;				    \n\
>  			",
> -		       ident, bpf_map_mmap_sz(map), mmap_flags);
> +		       ident, bpf_map_mmap_sz(map), mmap_flags, obj_name);
>  	}
>  	codegen("\
>  		\n\

