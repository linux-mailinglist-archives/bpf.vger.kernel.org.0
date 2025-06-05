Return-Path: <bpf+bounces-59724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEC8ACEEB4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A73D1700CA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B359D218580;
	Thu,  5 Jun 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sWz6+tXq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DOwhqSAG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEF1F4C94;
	Thu,  5 Jun 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749124213; cv=fail; b=qAdFcAVYyFkc9rw6ZMzuv7kOD4fSd3a0Xh2YJrxv4Nr++wguMf+T7RU8wF9J8FaqlhSLP4lt5bXNDzvFUvblgHpfh0hNP1WChIlfnV9gVUTu2zZHN7zAV6/mBfMbRqGjpyu/F2gobovizqHTbBzSudR8RjaCl/3bQo0MCn6Wo5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749124213; c=relaxed/simple;
	bh=fxA4wSv9GmuQEEf5GpRMUmwwJXGDw94JoxkHDVCzwU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKwq0kOfTZHhT0NFKcKPXj1JdtQJlfDS8EPjWfmHAsq7hB0czHG8dHPGz9j2Ubx3rqS/M6xJbeE36VqhpvU1fxFDQHRJUPv2rYG+PMO/BtgLhWdPkJMiuVdRL0RITetRv+OacC1G+EP4ID23p24Raofr05SpmcIjMw5rlClk3lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sWz6+tXq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DOwhqSAG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtVQp032027;
	Thu, 5 Jun 2025 11:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EnxcGRKN+r6RQQdFD+
	8N9gXFIsmo1XM0t4fZhAM99BQ=; b=sWz6+tXq8JkpasSJOwJP9aXglMvvL+P+L+
	AeiB0/7yYGAwqFNMxvPAjPfycfC6slSCST6w/PtmrHrypVBpUIclsp8LCQFgGELD
	2pdkr45vIAjFMe6eFKrOJZF2yUm4cPMen9eVs6wCsiSO8E14loHWyrgkIbPk5WOb
	2UF380f+X07Zgx0vck4p7d0aYlb73/HNPVb7EnR04IlD1PUOAoryLQ2EoWPV6aY5
	F4kkqhfnNyuhG0R5lxG1Zai1mCzaqTaUo1VGDtnO1Xtu5/w8m7WZxy3zFtlforDu
	q2mj3BOai26QtS0ygjjsEYMKRCH1Xee1r3554tUCmrFcjwpUc5zA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gdwtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 11:49:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555AR4Fj030722;
	Thu, 5 Jun 2025 11:49:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7bya1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 11:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDv1RByLdJCU4HphX5+HksTnbos53sj9+dujoT/7Sqyn1y4ZMTASbuFwVnYtz0ctH1ktYH+YZ5TPeFOfttV+WNFI0H0wdnRK8rl1dfMFIq9XQ2WLmQO84mtyOqhrdoaA3eFt1FIwVoibzv3cbg8vSd4qXQVoodtu8vuiS1w8CebS3kyywH9BoWzwsOdlsnsEmYiQqpJHilO3cupU/Tq/AXbdzblwtncTFdDYSv0dwwOVkEce4yBTojNKOADzoi8GuCXeRH+SOcKvj/NweyKE7B6nF8FgxZb+YiwdxilbwJgFYKbABYEy8Rbb+7q3ZORLrgdPEzxvzDGjkUnVca+/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnxcGRKN+r6RQQdFD+8N9gXFIsmo1XM0t4fZhAM99BQ=;
 b=LbDDOlYj6KAl7srY09qDpMqKalNJkHFtGaQd7tWlxTRpXWwpArRvPiTvQyuoX+vAjrlildOHNaonR5zoR0sbtVHj10lrFwjbx4VuyNdrIdTju+nUJPXJJGvIKimorWR+R6eJSQnu/Jpbtl21vm5ihR+w7JgF0OGrEgqXYBf77hSmZAF229yhQms+73KNEEAd8ut7B4axdLtnF6SCGK409vku55Tt2Q/rcE08obZiT3oKCT/faZ9BMIvmBYrZ7FAfkV8u5XrH+MW20sJyfKKJajjz1kkxIb0sFCaQZFk11GgIODxHQvMBxF6Sn1EoytKUqOd+2tgGOqw7evFYujQavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnxcGRKN+r6RQQdFD+8N9gXFIsmo1XM0t4fZhAM99BQ=;
 b=DOwhqSAG0oeVqAsGVsyEa3utZn/mF5PQHl9yH35OlYKMm3BNnoDd8pcrbwfHY81iuRnc6T1vjhT8AMLSBRM2kx0DmK0qZDOv1lUkC8OUQGSK/BBaX5yNFJwL0mfCP9CbfnjUK5Cq/uWno7jgaCmOUGOBkR7dPQ1qDbenekYQKUM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7678.namprd10.prod.outlook.com (2603:10b6:610:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 11:49:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8746.035; Thu, 5 Jun 2025
 11:49:24 +0000
Date: Thu, 5 Jun 2025 20:49:07 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
        almasrymina@google.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
        tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
        saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <aEGEM3Snkl8z8v4N@hyeyoo>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com>
X-ClientProxiedBy: SE2P216CA0110.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d25e340-caab-4df7-282a-08dda427040c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e70xONWDps7iPSG3cnUWMazy7zyvyjaugq4Huhyxdo5aSpQSbyBOpQCNOXQp?=
 =?us-ascii?Q?VmdLzcq/GUO6pPvjIKv9Xo3emrbWnzYqxcUEkgnlQ9LB6odKSvXYyQK47Mpd?=
 =?us-ascii?Q?n4Lr70XIlsl8tpFCjHHdpTBlBxV7zJZAAqtyaCfhieGkeHnAxwT2ncq3SjDV?=
 =?us-ascii?Q?IYDpByXW9eg69NX1LZ89FjKdX8+m5B2lF/tJyIMyVMC6RPr3H8L2ylwYT5YC?=
 =?us-ascii?Q?8v+H3ZdITwYA6q88Jdys5vFD/E+vxS20bLb8MMqhWH+FyxK5UTo/hPgZJrNk?=
 =?us-ascii?Q?j2SJ+IEcStAQ96mR54XPjfi8xVnpN3cyhRHiH12+rRtli0IY6GFJi1aAx4vq?=
 =?us-ascii?Q?pD0MY1wPXflSD7FEx36QAdEqyBgwNpYkhzmUW9TlkfETiU+15yFSfwk1gHeV?=
 =?us-ascii?Q?vygc42kagqgbdFJg68x/P9lHADmVbl4JyTbZKCSXqVS7TUXj41FRz2ABt0oY?=
 =?us-ascii?Q?T/fE3F7PHBxBHdz0lbAiaUr9OuFPSGAKrLgZmiJp6hmVdFFe8X436EE0blmm?=
 =?us-ascii?Q?DzF+0YFykeEmbrCWMWE+9eiQ51Z+Grv3V9F4Dc0Ea/Ycs0rhO8aUfzShK7tq?=
 =?us-ascii?Q?J239ejj4LOOpBWVl2Ntrm27RaJHoqM5VW1Hqvo8Me56GtEj62n9jpncf+68Y?=
 =?us-ascii?Q?GTKAZX5dd/2RaPu1irzCy0j6vgoh+jRXo7CF6afI1oxBiWim79yDjMTal/Oi?=
 =?us-ascii?Q?NyqYrDllxn6O5hLwt2iaBJRQ6esdaleevCH1zc2sXt8XV0sgXJP6o0lky1xL?=
 =?us-ascii?Q?v/chWU2XGr0he+gdaSW0JO7By3X70Wz4dAb4nFJfjvFtNi5gmcnZL3Z8GBaU?=
 =?us-ascii?Q?OhtW0AwyazUy0C9Aj2Bb4bIXDhXpcH59bZdeogbdWWbLQHL49u68ffHzPa8H?=
 =?us-ascii?Q?x31QSaCevkNz9gSo710SZ3/+5f3XswK18n61JBfSX9B8GMcEr4tDRoYb8pUb?=
 =?us-ascii?Q?zP5YbNbIzqqofsFbiZ5eGesG8Xw8zTrB8qKrnY6cGFMKJJvEvehi+PuqQHFC?=
 =?us-ascii?Q?OeaoOhsfr2hOOx1TG88LKW9PmmhPAff/h7sVmEqdpfGF3KrbOGF0QUdy0JFg?=
 =?us-ascii?Q?UU09sK9RAysi243ICb83QcG3kvIUKPWHYa2HHDJLe2vkRRNIr+DUBKkrLVSX?=
 =?us-ascii?Q?pVsUxC2YqppoLulxPUBe+yZ1fazwAujOoIXUZNpAX/2/DJv3JO4dikdSkgOT?=
 =?us-ascii?Q?dDbE3WIP8BJmdR4lxug949AAb0cX14KhPK8utyy/IpDEgTQrZa5z8TLNCytf?=
 =?us-ascii?Q?lDpD/abOpfkMCmC0TqL/YOkOMRggS3JkXDd/AsN/kz32fDIcaMG+wcJ1fC93?=
 =?us-ascii?Q?RzAGy+rAYscdUAURwFe2hmH5z4L7BLIxcgW73FKIepphomENi2wUzXiPGBZm?=
 =?us-ascii?Q?Jwko1R8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PotW9JXiW/slQlMJAKdII5nJhIZ73wW0hj8gefv4BsTEykpdsViLn/Dq+kQx?=
 =?us-ascii?Q?rhtocpzxV4LX9nMR8tp2q+j5hH1Fh+iQGDoUqQIJxgcVevPQ7sJozPV+WiEO?=
 =?us-ascii?Q?G15t2WI8HeNYwS4it4hU9ML9EuuqYt+zwm85S06M4bNF/l9zA9RCoJWsQ6hO?=
 =?us-ascii?Q?Fx5hivaSgjNh5IixC2hPDYpe6ULjAaal3QD/cVoCQjjxyo5c6IwB1XoXxos+?=
 =?us-ascii?Q?ehhxNUQQD+wK9y8cnA21UOgTcKOsuWmsXal/0h5ggOM79am/pzfS3Uz13Dyw?=
 =?us-ascii?Q?fyKmESgKJEiTxM2gzRvIRioWampijTEw046/k9R/hKwoQEWl0W3a5UVME5/s?=
 =?us-ascii?Q?2BwkBl11xh8AN3aPbA0hJAcyy0BkZv2IQGy6OMPaFrJRWYVeEd4nRkA/bFf1?=
 =?us-ascii?Q?VxA70oFQMgpXPGCctlgaerbLX3bIgylaA8LO+xJ3XLOvZ90AuBEPAo0l/x4m?=
 =?us-ascii?Q?SvzFB6PzSZLfymJCm0f0wxxr7Zr1zmjowElz25wowof9leBXAkquv70Fwj+X?=
 =?us-ascii?Q?TQvokfgKzrAGSpkh3jasHlcZAjpYiydEfrDb48vKQ2t6XQIONK/mlCsiLkjn?=
 =?us-ascii?Q?k+lFMKamwerWnQHe+0QoKXIEKrVw486qjQc7kZ1MpmYMlN8kED6VC9VUFPur?=
 =?us-ascii?Q?L+19LTlG3qSfmwYNwPVrw3N1YUiaor+07mDLLkmBlsYU07Un8mWwBiRAJig4?=
 =?us-ascii?Q?isphTAr5QZyIEWD6mSWAlK2j+DjOvRhEIW5piOR1FzKRhSfobTy6vIVsVygx?=
 =?us-ascii?Q?scJH+PYTT3rt04zBmqdwECJr34EEeAoMwtNBcZRAJYwgP+fAT1l3KrzahubT?=
 =?us-ascii?Q?NpTFkJVbVtY0YdSKY+QOFmdH5VSfb8uogeCShFDCM6IpO0vi/H2bDObnMxWF?=
 =?us-ascii?Q?WXah8rpVbG8xnF3YvNmgYdfOKxfaUOxlqJEx71Z0NoiFu3HYhiNDP69725kX?=
 =?us-ascii?Q?kyiasFcL+lk1YcnAoT2/weCG/yKw+/wjG0Eau9n+nECXaJ+DukBW9SvkTS6I?=
 =?us-ascii?Q?ZPL/m8hwgizBTIDeNAkGqDUjaCKuRB1XC2UAYxmHIhesi+ybmmbgI3ieRG29?=
 =?us-ascii?Q?kby4kb7v7TzZ4GnGMkirTAVxkP7wbaU6zFJFGEQmvr/WOSjKO0uICUzIuAch?=
 =?us-ascii?Q?zrnaE0+WTO1wNgyTINKqEKb8FPVZFDq3smGAW917KgTkzbuq9PJp98F1wbD6?=
 =?us-ascii?Q?oWK8P9oZQSoQxMjSP+R0MgZ57Q7snZUtmqkvwfnHTVQCbxXrt5Wcj6ICO9Ss?=
 =?us-ascii?Q?QoOTx8nxH74ZLjlRuwemBGwxiXGUHUyvth8ka3vn9sDOdd9wBiUAG17qam0o?=
 =?us-ascii?Q?MFmZHEy7JpV4Eq9Yl2uYzv5oBd2QHVkar7GMEdAJOJH0VT+ZQ5gNoJPwwUDr?=
 =?us-ascii?Q?KSZalslJXQAFA/QwcJEUpXSUbQmq7ujLRiS4y6WJy+jNrtKSo4L5UARTsT0B?=
 =?us-ascii?Q?vVyCztsOMDlcXKLYmqL+P3IJutf1+N6+oZdyZoJYC091FGnNwQD00oYDamJW?=
 =?us-ascii?Q?7eB3MQyqnsrLOMSKuopmHGMLSNhJVG5e4vtwNskrs3IwQ9RxuMfnnKTSBBCn?=
 =?us-ascii?Q?KJ2qowDy0lZb8EpqgUu50FGz/z7pfB+dMjQ8Sd60?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sRe8ldlqNnyvFLH/CrSIpl4g4CEMzPq+P5iR4LKzXFoy4ZaVCmrapOMm2xyzpgUntfWyb2qqdRFsh0Nn9FDpWZuCCXkPu2j/kD+j2hoKXL+HcvVoUlkJUZguzpoECcmp7D5KeFht7M5ZpNoA5ldS/Bnsa/C7DM+//yzms757qAkSApVcyZoe5cO4JC0QyHjHY/w15oHdtoIt4ilJ/3ng4D26arxr5B6tqck+4NCbUUdAwez87Y5FU3fAQioe4FqBKTZMMMGM8ylz3oy7Z+FHYoE2ov1JvsGJOnaoVSnTPXrjobvJBSWLIHDG+tfhBNyEi1+iVggUWI6KBj/XW/ORfb+iFbunOgoqEUqOEA6V0Va8i2knkuS4NVkpUsRKA+ZSNkB3ZgtD9HhGsPsBoI/qqcUs9ZK+ZppE8Zpv90dZHtR7eiBmcFRfMClif53F1f1LGV3foiJx110rnxBRRI3KytUNxvLrk1FeJyRResUxv7DBPgU4aKmOVfsuc637tweV09GEFW0tGPLy0KvDcBin2SksAxp7uCXFZ2L8rrjc3NnmlVElT1wbVd3VeudrOeuUSfO9YB1Axiqj6VN9EjBr0L20jcJY5CmIX7u5JS9MYIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25e340-caab-4df7-282a-08dda427040c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 11:49:23.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BP9GyfWHnc9quK/KhaiwIig7F5lPb2TrltkbxCFVkMjKaiH1kvUFhtT5fO5UROD/7pHE5Wr2VbC0B86qc6Ieg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEwMSBTYWx0ZWRfXzFhA0COZqd/H OUmnV9351YsfZszUWGcebF7HNpLjRPw6MfHgaeavIjFlF99ckStI9xMGRZ3Vkk8w9z9dXgKBfAw B6re/89kkH37cXV968DgxchQivgTAN2VpHG/0/+0MV1vUE4L2GtJY01pQhhEt8PHgh0ps5DlAlD
 3NVFSFFzR1bf9tPWrRFFgMPD+hoBGZ1sjw3qzDL5FCj5Z2Wt24d/4e5WpBVzxiF4kLTTkS5fUix CX8orBqYF+Is5B4Hiot3LzsRAdOAX48FB0nK56HAFp9a+2MsYlHD2AsTK14aRsPsf/hCV4a/20q b8a2TVgj4a3RVyk7m557EIUE2da4skmGt3vGBgYZRy7PXqAiNzh2BioJXUmeBRsfjbsuRs1d9Rb
 xCnWBtCH4DmIeQY1N7wX5/Yr1sN7q9WzCr4oT4aFSTlKsYW9bfUdSJLuHvDRQH9G1ZiVEFlo
X-Proofpoint-GUID: wSgV9f3CH-CTD0RrRMk8v6F2bqV16OMF
X-Proofpoint-ORIG-GUID: wSgV9f3CH-CTD0RrRMk8v6F2bqV16OMF
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=68418448 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SiqW3_QkAAAA:8 a=lUEG6gl_fbCJp_hllMAA:9 a=CjuIK1q_8ugA:10 a=0-oVHmElw7bdUHZZ8WX8:22 cc=ntf awl=host:14714

On Thu, Jun 05, 2025 at 11:56:14AM +0100, Pavel Begunkov wrote:
> On 6/4/25 03:52, Byungchul Park wrote:
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> > 
> > To achieve that, all the code should avoid directly accessing page pool
> > members of struct page.
> 
> Just to clarify, are we leaving the corresponding struct page fields
> for now until the final memdesc conversion is done?

Yes, that's correct.

> If so, it might be better to leave the access in page_pool_page_is_pp()
> to be "page->pp_magic", so that once removed the build fails until
> the helper is fixed up to use the page->type or so.

When we truly separate netmem from struct page, we won't have 'lru' field
in memdesc (because not all types of memory are on LRU list),
so NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic) should fail.

And then page_pool_page_is_pp() should be changed to check lower bits
of memdesc pointer to identify its type.

https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

-- 
Cheers,
Harry / Hyeonggon

