Return-Path: <bpf+bounces-37519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D3956E55
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EA51C221B4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7A175548;
	Mon, 19 Aug 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3fHPP/f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/4s09fq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A41EB3D
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080313; cv=fail; b=LCebUdBBKNcuqEMN25H+hOyEoh8i8VwijN3N5Q6bM3KZRlS5eBrnwNKgg7Pf/YTt7mGsdbnFx/y3dX7Mxx3ALhFmobErKkFfdnuVpSuaDuIdR2vGfYIC0qm6vSDDSiCb28rXTHDAFsi+M8ceBuZkV6OW8GnngpgUupqb58lLh4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080313; c=relaxed/simple;
	bh=GTWa1hKf7k5UJLxW58olFcXgwQNBigF2HvpWl9ZD2tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bctsuiq7roFcB1+aCfc0gQKqZ7/SrqmM+TvyUhHTgzuVx5vlWXmeiVSoge/0xmrnuvJGOX6O1Qm+vbLnP6/QPWGEyneT8YQDurMI7rwiY8mF6Xrnpg2Vr0mIAJWeeXVky1riYQzvkg2va8A97Ck2GcpK0+J2pyv4nDjtwbw6FEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3fHPP/f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/4s09fq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6rhm013177;
	Mon, 19 Aug 2024 15:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=dAr6G6+qH7OZf6yq00niXLOhaRSRaiMX8QLUJxbWuKg=; b=
	R3fHPP/f8vOrWoz0zGZnNxM6/yMz2xWHUhvPvUGnKdGO8WtZUrql/8YjJdfDgFuj
	9xJ5EehE8H1uOEmq++KbAyXbftOWbfwaVHADpzleDNalf7cP4rbcuQb5/NgEseO9
	T+f0tFDZcYWLV9LbuP7wmv5yfzNhFWtJhSdE5dmDJ6P8IE2t1Lqdf90l3l0e9OXk
	IxBaYZWcgHZA8KURPm4oi4odx7B95BRqGZ/DckEG+GZThvXJ9LBEoavCHJylRDN+
	ufH/PpVi/aVKEoa44rWQz1N5uBSzoMgb5gKb0od4gWpl0XfGK6VGDar//Vjkn5Hy
	5n3RAgJGB0pxivkwm/hJbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67au2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbHd8003087;
	Mon, 19 Aug 2024 15:11:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 413h8qq684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 15:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOWdIgHPtN4ZOdCTCdYVLOyUBMA11Y1/2CWus4HlZKg8sh7rHCwK5doCAQ66imsvILEHUveT4mNVyukyXDv3MX5gKcOrUzigtqYzlTb62EstNkaJyrcUT61HOFyNNeulUTkvwOyG2XqoDRp39N5QBpk5h5mvHBlmN1w3SQJubQowMS9McW+NmVrIfBtPuzWdhGL74EkyLa0XJ45D/tEfZvUrHmWUdCoR8xNIH32mHrYIDvDTEJRRtmYQSqsWYftsUADAc4VC+P7YsbnlsWGhxgH/vWq0tBFD9D4gSvzm/IRiw3W319hf4430TKd9J90VKYtgOLzNPvAFE/cUzCUIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAr6G6+qH7OZf6yq00niXLOhaRSRaiMX8QLUJxbWuKg=;
 b=obpnc4+dYu7qzKO7svxoQI+cmotwcew1D6b/aAanMEYELp0gKx/X8dBj8bv0fT9NhJVVeL/jPS9mzj3XmBNLZ8At3l2j4GacllHUMMdU+r3NnGdu4mWUC3T/B51rtiX1pU9tMVhqzB1RGEE9gqFM4zxobpLHuWGRfy4iDxAcSGVHXZ/ea7fGixs2/TD//Y4BLSICA8TrDYHQH3AXgbE60VePf0xal2d5PYPmtr5o/O8/8n256D4Ma9Z2xR85qfKaq8cq+bzpicTYGBE6mPvQigY+Kvx9GsKLvQ5imOLkPc5KdAHUntK0a+nXE2nA0RuVcYHQxsFJ3YqDeOAN8uIaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAr6G6+qH7OZf6yq00niXLOhaRSRaiMX8QLUJxbWuKg=;
 b=c/4s09fqwauSkCWUXi6+GZ6tQEPuj0D021ojspERc4C/MjvYdSOu8ubuGSQU/Iyhi2SG7zlujfiGkUgq3rISEXixgZ2o8Q6nMwgyuvtVae5Wn0aesD2LwO62OFoEgV35ywy8BLeOBT4uhqdffk/zY1kc0loppBwoAUBWtlejdqw=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11; Mon, 19 Aug 2024 15:11:40 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 15:11:40 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 1/3] selftests/bpf: Disable strict aliasing for verifier_nocsr.c
Date: Mon, 19 Aug 2024 16:11:27 +0100
Message-Id: <20240819151129.1366484-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0997b389-913f-449f-8c44-08dcc0613a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6N1kVSmrfBB443MdtKHVS0rE3tj10jRlNoxuRKM7s6+9yYjs0lhnZKiy7fI1?=
 =?us-ascii?Q?InsDNyoYV1QQiMp+VP9zcMwxQRxkpAFbK1UdrtyW1L5v8tU423CNNo7LzpFs?=
 =?us-ascii?Q?JZ+eXuxBTW6HE9lGGXTiLm9uftm2oUKim/uq7SA7hs8rypW95O8kB/MKsak2?=
 =?us-ascii?Q?KyeldoPDXSvyQ9W0nA8zeEEnacpqr2axQqphyBmMPCtb2bZjVIbsAsfRuWgX?=
 =?us-ascii?Q?wOdjYh0pNrEU5jRdAJcgIxbK8AHVbrchS6VxnttoXEiYg5TrH+dcTPzzAs/P?=
 =?us-ascii?Q?nxbb2f3rNFyTmnP8VFYAuAZxGg5SbsKY2dLYss/PoacF47lRv/Qw1ujTt5Zq?=
 =?us-ascii?Q?grMeFMdE1DCyI1KWQss2+m7q+2PA9yv+Auy15PuNZ9Pu2UC/sJWm7ME7XjZN?=
 =?us-ascii?Q?p/IpMmD3gcDsi+g0dFlvOfXZEPtq/gxTQUWGW4oSy2q2RrYTckxO6lHjFVoh?=
 =?us-ascii?Q?I1xKtpRSr3neesfFsNGvW4YMSNm2DKeuiA/0ScLCKX2c551C0CAkIqGWD4HX?=
 =?us-ascii?Q?cesrEM5kcyL7u7QYRNO/7TFoGBKANZ0WEUSEQG6n7XZn7LX+NH0tiSdLJ2Pq?=
 =?us-ascii?Q?lzO5XQEouC57KasKc0OzC3mgEKYolJtxOZ4J2MrZi1hRBL8G7prjT01tdgO7?=
 =?us-ascii?Q?l7VUA51yrO1MKC33OqbSNAHFwpgD27UsZc9YKPO18h5urk0s6/eqMsifbqmq?=
 =?us-ascii?Q?cFag9kUkAlVn/BdgAt0h0pXTyjNl3Ir7ApiC6c7MU+381orvYqRV29dyY484?=
 =?us-ascii?Q?lXOz7m1HKBcqjLHMcxyMZXaaOxKfShAbtUgP5idyDwlw5VoKPTxi71UWux08?=
 =?us-ascii?Q?nMOfOGVTdLIB+S0v967iMmxblyY7s2h/Py6hmXtjouQIYK1/4VPd/DiwG+nV?=
 =?us-ascii?Q?7GitzShgbg3J+ny44M09KdaAdLCZD0RAvxpmunOUKpouD0If41/dAE1ilSGk?=
 =?us-ascii?Q?IaEUYqnqo1HFUuIfsRHS23TPxHuJG/gIkRE+R5Utc2TZjp68tIVJtoHdsFJS?=
 =?us-ascii?Q?Q5xQX4kpJL+gT7dz8ClH4KCsNZ3VplgYT5EVPP66w134sfT2vAp2ayaYA951?=
 =?us-ascii?Q?bf2cDfGqTkFLiRKK09+iY67WsoQOLKwQXqpavpoDDD/rRtpbdBdg8UOw0ZYN?=
 =?us-ascii?Q?L/nVrQfEHTGyheIL4iKw+Fo9ijAjdA/DFtiUdFSlNWCwUifZ/RAYaiMrVl1O?=
 =?us-ascii?Q?aDbij/b5hy6v7QSh+4iUAGWMqvbycAa0DwRBfEv07/+Y5GZVx2aD2rqy7tQ0?=
 =?us-ascii?Q?JCA9O3XNGkk/cyXvI1rp2tZPSJuld6NEiPjDxeKL0TuOIZZLja3obR63Ydhv?=
 =?us-ascii?Q?uFVWZr2UjWu/OM4qP7R/aOMDOMixYfqv5qnR2OD2sFqUhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8rnXfS1mIJxab9P6BxUIJzZEtZxdYqy5IKMbQmnN5vyG0PHGn8i2GDwcVZKv?=
 =?us-ascii?Q?OK4SqYTPnuIucamKQtQmPXI56ufRYbjQ+evRUUBzwca12Zg80a1Tys8JEOGV?=
 =?us-ascii?Q?JFuodFqtmiX0LS5NRcDZ8dFowyeGc6MxvtXSrh3uT6kH9rQqaxiYIkuEk0vG?=
 =?us-ascii?Q?KX3cs9YPduRaz36PhVRnahedYUJxGPI2BfcrdZcY0asfM7Cdyx1OsHbUDfOc?=
 =?us-ascii?Q?6P1Hfscxwp/LoUuJaNf2Ep1ZpmgWG8LxVBWYMpMsmzMMVozljW/LdjfxHYkP?=
 =?us-ascii?Q?cFwZ9JfgupJ75jX2Qs+OEh57vLXmm6xYcgf6LUuT4BJLWXq5hFpqBnzGvdTm?=
 =?us-ascii?Q?BMCro3y3XRSy1u2iClKCyMNlsa+6PtrlOYY4n7URrMLoIUtHPaEeN75IZgga?=
 =?us-ascii?Q?lE/4RYu6o73kThnAO6/hj/g/2svzv6W2+xGm/zSTB1mx8paBY/908Pu65k7o?=
 =?us-ascii?Q?JFBBu+5JrpM3sc1IzV1wyeO+IWax6A7B/vU1gdSGZa2M8EkHSEOY8iTZWn8j?=
 =?us-ascii?Q?jnNXvWaAepvhG30hXl2BN1KCfMwbnIqr5CFj4RBuYKrpaMGowG+9mALulSU7?=
 =?us-ascii?Q?QgcVzCmCqZDKuYrdx6He2t4VK7hLsSb5MSs70k8+DOfiQzmqL/RohAt3u9i8?=
 =?us-ascii?Q?snQukFsJVtlAdA4fNk6V6/0bX+Jh+u0Ajz6FVNE4l5tDDlREY9T0Njj9JN74?=
 =?us-ascii?Q?XkV1bcvH4mtENeHi+kA5+bnp31/4BdP5DJ2BEOXWz3XU7+9yhrbdEWkLZBGf?=
 =?us-ascii?Q?n4LziWtW+DUnbVt8X5uyWQchfRC7WrvAcbNW8wQ/9Zq4kq54eCDFNpozpEAg?=
 =?us-ascii?Q?HZfRDrX+SlgPE72E/Zsx0gcTPcI6ws3jCx1lXygYyp9HJf9OKhw1uQAr8hbb?=
 =?us-ascii?Q?n2XZ77OgZxh1dMCpvLZmXTx0fvUVDrLbeHablGMntPbQ/hWAhGgzaqYYzJLC?=
 =?us-ascii?Q?FLgRMTXW6Vz9F3w/FNNikeaijVVr0rOLSekX/MPh5ewE3vVwEtvLYcrAXyGS?=
 =?us-ascii?Q?EZN86HCK3XeAeb6zgvJZLp1s5xjPCO1h/KvBHxeD9skkOpZcPS22TMaQPdvO?=
 =?us-ascii?Q?JLvUU8TpKf5r9Mt7Y0iISQgfzANgRZAq2khF0e5kRTa/YpQIRNxgn12WYbzL?=
 =?us-ascii?Q?7aCzSBO9sVCBB5fu21o7VP4f944meyVSRrt7nu3d76lqIhOULJS94ZiVI/J3?=
 =?us-ascii?Q?hrJ+3XmXY7cjDmD1GSq46crxHYHR2NpmTJa6w/sezI0vQKkbbSRfrW0JsJnT?=
 =?us-ascii?Q?8BSN8AhL+Vho3BM0trU23MSratKQwrZmACNRYVwBUV83TyI2xnur3abQYbbq?=
 =?us-ascii?Q?iUKTJgEAiRLnE6MKtFk+J721p9rbi74e0xmkXtfii6GDPVSXVEbJXs+LrBQj?=
 =?us-ascii?Q?PAr7t27z3z33UE5Xtclb6ILz0UohkwtQTOM93832tt1OrfajbGx4bDDVuwRr?=
 =?us-ascii?Q?ZBWbBeqRFjII7kLbIZvF6bb+1Kv35LP+LYtfwastuiO6K7FSt3WwzKqk8AFe?=
 =?us-ascii?Q?s03qEkvPtbYH7XmtlEHoUNK/EDbxt3HhPSUq9SRGza/D18hrbTw/2nJaaxSW?=
 =?us-ascii?Q?0boReN2i7hd/16yTYlxvOvwwFcdCJJGLgt3n8eK25cYNZZBsNya/WrUnEGGp?=
 =?us-ascii?Q?1oznOfybly2GR+aAL6FRaLo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QkEVSjdUJADYpDwxBkb7wTnVcjMYfEOFJGAABAfNcZW+aGJ+QcYnx5r4k9gdLFUm4NLjc6BLHcaNRFN1BIuAknoDJLykm0eIngF7zE2OryKCwUhSmzypnjwaGEHYVo4P9xss30QNDas0j3lUZrS5+pqfmZOzpuKFtpIrNeHFx8cLTYMH5oITFD7yGS2HLbZfV/zZ/Q5MgiDDfRSwSPpw/Q+9o19Fue/HWDhsT/EiRmBoadOsGbnHQQN99coPBOYyjMfjszaSp4YyECzqs5Xfnvovwk7bxzGz7aH9JHG+5Sn22tEv/w+8ceFU6LUM3AiL4XVlMljd+rjOR/oj7YC7NkesaNeHOQIb2B5I5jvsF2K/kvXWwhmN1JcupPRq+fKkIQ2pfRc+jimr6+65Pd6AKYFxHxqGlRirX1urag2CMNF1SkumGV10k0BQfa5mmPFkeMVu/l90H0e7tOwv2xyOTRDVaLr2NG1UzGyzXC0+88iOM9Pyn9daje5VAJb03UCMgf0DSDvqvl10C5POkCSzEQ/dsYtZVm/lKqWd8w1n6Sovhj9wF1YE1DqAX3sjix2sun/OrWXsARxunRoRFY4HGr3LmM5Ydd/Lz8NevqaTG4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997b389-913f-449f-8c44-08dcc0613a50
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:11:40.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGT1AGhCK4AID71DoEaOYd38Er0Ft0sUFWDbk1F/v1h+lptp680FHZpQqLpOyKawywfNVNeCt4FzGLSuf9/1AnLT/EG2sMmzvDGYyHGj788=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190101
X-Proofpoint-ORIG-GUID: hKfkBf1T5icImY2odoJYbA1Nd8iF9yeU
X-Proofpoint-GUID: hKfkBf1T5icImY2odoJYbA1Nd8iF9yeU

verfifier_nocsr.c fails to compile in GCC. The reason behind it was
initially explained in commit 27a90b14b93d3b2e1efd10764e456af7e2a42991.

"A few BPF selftests perform type punning and they may break strict
aliasing rules, which are exploited by both GCC and clang by default
while optimizing.  This can lead to broken compiled programs."

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 00bde031a469..ded6e22b3076 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -58,6 +58,7 @@ progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
 progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
 progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
+progs/verifier_nocsr.c-CFLAGS := -fno-strict-aliasing
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.30.2


