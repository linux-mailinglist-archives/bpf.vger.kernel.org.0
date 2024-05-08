Return-Path: <bpf+bounces-29050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13E8BFAB6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898831F25430
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774D8286B;
	Wed,  8 May 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWODrHAk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FOjRfJTz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E97E0E8
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163235; cv=fail; b=geAnyoLCnEmqFTAlDM7nnAXxgQNtHoPlzdff0erptpk6iPDPUqV85x2bEalAKcTc4/eL3c0/l5M3fvHn7G0B0hMwL2AkF3ZE95uv8yWSlWAdR62X0QZsgFftb3XrcEBX+In34z7hipQT36TKjre6z589OvJuAYu04IKeHFfz9Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163235; c=relaxed/simple;
	bh=mgaa5I/B8WwhiWSHsx7/BYmHx1BLpKEUZukH8AhBDGM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UrSVxupoeThcdl35LW/zYoGnXvvp9envAAakp9Q0EZcwLyl5lYlhnc/NwqGuDCn/D1S7NYh+yOyhKOB9kydFqSZUugEnx3evnTV/9SiTfPCnHGdNU8TT4+PF0P8CPb8P/Be+MH/o0jInoNbVOOznvgLATht4d2QK9Wh3C76z3A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWODrHAk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FOjRfJTz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4488niSj015451;
	Wed, 8 May 2024 10:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DouNTpDorsdwpLp7n7QBxqMPEeTdOJSVYnnIQHV+0ZU=;
 b=eWODrHAkSQXzYHOL+fzGDnOLrMh/9kuGFgSCFXwE167t8w7moTnHdPCZGCLNSeXJ3IbT
 VOZQ0ssya2jnXgv1jczDMnCTbEoQny5084jkm3zWScYK6F6W0Q2lxGfBnUkgzNK+EWtt
 wnQLsV3cDPSZ6B9hxJ+KRBUaT9CJMWcKXjX/ALjHuqaun8yeCwsWB6z+2SOdbODNrenF
 Ya1ASOM3pV25rjW9bIStihlYE/Ug5US9zavcGJutiHKEFHvbXKpWnEs2svUDKfr71mco
 eSlgmyvVvVKLvuFxnKR06C7oMwuWk6ObwyNW45B84Bdeik8H9mJZLReHIQMnUAxHDrZa pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv1bph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 10:13:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4489JtfN030946;
	Wed, 8 May 2024 10:13:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfku891-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 10:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK/W97Xca+MnXdfz9HRz2Z1Z2gZRlMAoJ/lnqEkD+JUXAjbc0jRYpN+1Yo1VoODwQmwZpo/hfqXDPfcY8tJ9v0kuAU87RvHPbmEccIPXogsZzuOWVy1/5MYVpirfzYUCFQs2utC+mvDDF46A1mVsbfzCnDH5/DyVW1Uu+G6mvVH88BWXWROSEmMu17OnGOZQUy8xdDDdFjUKkvJFVvhVeoTt0WaH/baaBMXEuTXTFdrWjy54rRZTYy/WfVLrAHGDEPerP3KXCHArUo45FSjMiEcAl61ly+tw/owCykWY4/t76N9tDUNHx+pbTVOSVOfdR2AzQdnqfZtY/tS1fWULlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DouNTpDorsdwpLp7n7QBxqMPEeTdOJSVYnnIQHV+0ZU=;
 b=K96ltVeRe2Rroybgh163MFZZaTUPwJxQvFHQRJ7IohRV2TJElrRlcH0AdQCQgEg9feErZDzAjecnzYlukw3dblspB1o2bXElaM0Fxtyr7WPnSa6effDVLjHWZHClYhSik7JljCscbbAtsvA2TYSw9j+jr+AsW5tbq5q2uB57N2P1eX0K021sCr8BLKTDxhodWLNi4JrHZ8Bk5kSsB1Dxo4Y3y4sGBT6Q/S8RxjU9RfOU7c/G5VYTs4pvEKOd031R1/DeVYIj8lEpiZ1w/uzPcrd8wzNxeEilaq6yHcKtF6g6eJQRxALsniTzn6PDcu3chQnS63LKp95d3KmaayGqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DouNTpDorsdwpLp7n7QBxqMPEeTdOJSVYnnIQHV+0ZU=;
 b=FOjRfJTzo/wV+p8Ls1ClkWtgFuSYDGNZb4vhsNgn/KLNHnf+Atbh8388hQNiglC14gHwzVHQh+Q3FgD1XwyEtg6dMDDLkmHzubP2p8HsXb/tN5XxcCsC6m0PUBNZt3U9NTYqQUFLgI0SBjVDP0xM1iPv0NprZhH7ejwoOl8EZUQ=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA2PR10MB4521.namprd10.prod.outlook.com (2603:10b6:806:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 10:13:21 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 10:13:21 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next V2] bpf: avoid uninitialized value in BPF_CORE_READ_BITFIELD
Date: Wed,  8 May 2024 12:13:13 +0200
Message-Id: <20240508101313.16662-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0494.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::13) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee85561-7efd-4c72-e657-08dc6f477cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3wtm1Q/INueayYeQ/UNeueGbI1BwOq6ThG/c6243fjSW5iu/ORRgjB5mmmXq?=
 =?us-ascii?Q?3t80N0CPaJ/XbcjCUm/8f4FmvHvwr/BawO1aukrDugQ51RnNC9ONJFkdo9T5?=
 =?us-ascii?Q?1Ou4e+Pkur4UvHMAzwM26eGTmUYgUFxBNFndfqd3kLQrUDW+PXUM5JG1taGy?=
 =?us-ascii?Q?ofzNbIVqooHSuuwKWDzfLFm0ar0M3h/JXNwJbesEnHGgonLsrM/+nhkvzdIj?=
 =?us-ascii?Q?ylRQ9ESzhWP49NVLhhxBmED4JZTtA5VvQogW9QAcb1Bd0ktk0pLg1EgrfTb4?=
 =?us-ascii?Q?9HoiBcGZ2NTxz/FlViPG3DOpoUOueF0TkkNfoGpmVnIpm4Rn6faung+G/Btp?=
 =?us-ascii?Q?yahJPZ1S0deF8YUJUU+Tj3PoQV2W9Fkk9WH5sePN/ODqiCv14SiY9JLMOP/K?=
 =?us-ascii?Q?0JiszYzoYuPFNHv3NFUji57iAp3LxZ/cMDmUid+Btv+tjXEHi7ozEJh1iPSQ?=
 =?us-ascii?Q?PjVx2Rqjht18FSzIu+Ys7+dR1HvahvVJzriGJ3hKaYrAfRV5vYBR71HeIPiY?=
 =?us-ascii?Q?fCveftclIUpYoiI60tNRTVxqXXRhuVpWwzlVQAiUIVFkZuH/G5gl6ef2kpXF?=
 =?us-ascii?Q?AHInRYKUVEH6OE8FFtw3/MIatqaC9Ybt3v8lQgn1TLbWi57xcQ2CG1teE90p?=
 =?us-ascii?Q?d2dFPi0/iABJguNUu2/VrdQa0PXYLAjGREkF9N3jFRnP1dlfdkaYsKZYVpwG?=
 =?us-ascii?Q?Uuav+x5j4cy5JEJqGtcEmx/hfi05vAybRW9CaDQJxDJr0B4DFgEU3ODUdqlu?=
 =?us-ascii?Q?/aRk8unvh+jzZuuowbJCJgMg6oL2LDIQ0tHN+MRkOiytt7wQ79j6hLELTZP7?=
 =?us-ascii?Q?fqTOcNsgns28GMV74rnTQMbpjmb/GmIaGndPk5zrQqn1wbVLInMLTmm1gOR4?=
 =?us-ascii?Q?WH0tW2m0rNpe98OuXxogigLGJ/OBxAAyapL2ugcWgTV5LNy9OEvuQD75NpY6?=
 =?us-ascii?Q?UpCDRIW3lQVq7TFSHQIeC1O3MfYoOaL5QbZyeS/yImtKGVwVqWufaY45u7YM?=
 =?us-ascii?Q?5ZCPYv4Et22sK0q0jGN3J3vgl0adGqdxyRxxDzdJsKjesuNnN+KV0q9+KYGx?=
 =?us-ascii?Q?V8wag5q58hdmKVjYdIG6XOa8LAvJBtjXfRGGEINKlzxm9E6tkZd7leM+F05x?=
 =?us-ascii?Q?chNd1DpaF36vEe58TAO8PJkT0UllLp9WGyyrFlxh4XJFCLLFbyMp5IAnvPad?=
 =?us-ascii?Q?U6yZT8bEqEZk6HbWSJfGuRQbkXeszAa//rboJq2Zuu6YR+ylEixnV13i4wT0?=
 =?us-ascii?Q?ijoaJR6i6aDVVUiyS9apLaEtHbgvRtzb0VNHphYdaQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3yU3AJ+FCA5y30wV4DIi9yyJU1Oze0mD1PT2bYnTCaikbOMVQbC9ebQ5RY5M?=
 =?us-ascii?Q?p3e9yBE4BNIlcq8oWZlfhtCQ1H710Ml8xTq0OZpd+xV/E2l+8XZM4em5qt2W?=
 =?us-ascii?Q?v5ec48/WpUWr2lnCIIURQDEpfVdk+u+UJj4tyVa8EGDMme/rWD+qFy4h5FR+?=
 =?us-ascii?Q?pZuu27+lAzsiCKh3BcOXrYHcv2BC1eyhbtZW4RgT9nUxyX8bmAGjFGBk5YvO?=
 =?us-ascii?Q?GxebYUoZLbgtBek0/0RqNh6VnoqaMHVEEInWFCbPmT+svf2GT/LrGgNb08SL?=
 =?us-ascii?Q?jXnc9NZtpyBUhQIJk3yd+T3XT4uguJYCYYnx1ZdilBqLNefup4W8RBcJU8m7?=
 =?us-ascii?Q?q7GBLUsrkUzoTNS42d2BvXa7MzWTcsEBlk9Gj2BdRmoy8NsY61l2xTZsYUNw?=
 =?us-ascii?Q?SFBdwxIbUvVuIwAZqmWnGKkEmnHDHrSD+Ou2UqRzt0s0rOZFtBHXo8UBtlta?=
 =?us-ascii?Q?8SVXGhFJsEYw6afmCb1WePfMkAnOTGfC19lAT7inn4HH1p/JRTKW2LuenNL/?=
 =?us-ascii?Q?IwIQX26UHWBUF+H7h/DP5RZ/vwSbytKoXmwvmLmqdTbWu0M5OO8U2y4ZwhyU?=
 =?us-ascii?Q?8iNvlORHWUTlBEn+tc+U3Z0g6QYC1qnOaq6/HY3oQVxWL2ja510A2ksx/bKX?=
 =?us-ascii?Q?Zt+XryO5kIFbJ3QZFSpy2aRr7BPTRN463PqU1iWByM4uEp5kabdNLOnxjGP/?=
 =?us-ascii?Q?TYC+jBPSHituxuAx+24p+8Vj7x3Qrpv1ovKuHQZzQbIz4H2iGKR+q67CZfiq?=
 =?us-ascii?Q?nMZu6WGNzkxXeuwRac7BK+YgJnPSmzgnOgdOB+lMtyX6UVuxMwN21OOe+GsQ?=
 =?us-ascii?Q?55Q55z063PjQK4BUFrhSp5n33w6o+Z+YyL1ZytTNW8TK6Cr/dViqMl1v0C3J?=
 =?us-ascii?Q?B01lm+OGCmCpLYRCZoSQwdLC2UYsFnDMwdUeJngl0atdBldyj4DvYB8xpZtB?=
 =?us-ascii?Q?sO4dAaY3ltN/g54WpHfhKE+XAvcb1o7msb4uyYPeNk30mehVxYK/GOznHLhs?=
 =?us-ascii?Q?tcuhiOb/xY7kKbIaCeQrH0wsw2w0V8y/DWM7eTiM4Zvlb+PRKQTJ8TOWW3wr?=
 =?us-ascii?Q?HZxOYJl9zt+OPzT2eEeXSHuLDTpj58hvXafxQrhHDQGNp9650eV4jxAazvPa?=
 =?us-ascii?Q?x7gbG5f8ApxZbxWYvtKQEE+Dt3SSlCqGoNPFwr14XCnDFJJYb32rMz2BsYqf?=
 =?us-ascii?Q?Qv+JAF+Ldj5t49lLMvYCM+xrKaINGmGols6Q4Wag9jkKVApWU2cbMrKx0v3j?=
 =?us-ascii?Q?xrMe2idGnbQ9srQk8A6FgfMTaU7E5XZI8zY+1H+7yVZ9AJGhLbUsSmTZTkHS?=
 =?us-ascii?Q?+4LBilYN20ZTMhgbYGUQrXDVlAYOWQP3Arwirs/oUf5+nPTzLZciQjuBr4YG?=
 =?us-ascii?Q?ofO1LGLBMO5oykWu0BykbwiQCCJrKy9bfTXC3Q2QcZCpsBA+aIXecPTnaJcG?=
 =?us-ascii?Q?rQMOAp7TNy8MDMg8Q/KHyBw8zA7JB7ibhQ+eLwIpsVwnu1wd185cirAPV+26?=
 =?us-ascii?Q?ToVkfiN+uv0X3jbGiy+c4Dg+2eEmHNT9W1905Fxu4pJA3jPjlq9G+umie6Xs?=
 =?us-ascii?Q?B38tkzWJODYdIKtN4L/bAGYsMfi5uYEjVVF/OIwVX9Jn0sQho/ZQXyHZD2YP?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nxTxYD+EHwWu8Fdpws5UxSvqcLPa0wE+uVmnR84xvUK4V0yet5xs9YohXgTcaFqQgaLeWSoF+BkH/CmOmgxob6NEzLnQAmvcFADZK9dz4A8R7wIpksY0Z9Cbw4YK0LTL9rfU/3OahfHcj5Gmg5YeFlt6yM/B7kc5leHhj5ffYkKVwMVyUxy44EoyW4uhbSMPJP50g/W1izVF6SawGCgK68es0nNW+PeGl9jMOjgWOohBKKqZ6MhVLFOWThGI+Akr0AJY4VIYN7HYlErKOH5+Wqz69EHf5wPQlE4oej2yLHyxjpSBNolPo9RQUv8kA1MFC5fyeITl1CqhXd/tIStltpUzkanXdD6UeUBDPtIyRUhoNokYiOigA67L9SyWl5WGkwrEDQ4YvP6e6TpagEHT30tBQy6Sn1S9WWXe6H2DKRS+y/0agXb7l12/EdKndq00yIdeFFWySwX+6vDByOs5KSvgFWLqRsM5YhjKGWk0v6MPTc05WvBpShE1eUpRQ8PVvH6BR1O0pWXpd5yaC4btmYZ4oY8mSq8Lvl4HFAytMh4Ip7ijMIMl1IOmUA3MUabklQB+XMumJbFasI+uzUm1cI62CVTy9rubqTCiEUXzL04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee85561-7efd-4c72-e657-08dc6f477cf3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:13:21.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4xSDYOjOw6YK6mGS5c3au7bAMr5p0KuIN3/EewXsTNfdhgY0JCQvtP2TUVQy7UZVVY4J2J5eiX/HjZWi3WICHnGTQzx6FrYAmWvzfCC2Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_05,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080073
X-Proofpoint-GUID: GjlybChWd8NoJQsEBoikhjZoKsRDMC0H
X-Proofpoint-ORIG-GUID: GjlybChWd8NoJQsEBoikhjZoKsRDMC0H

[Changes from V1:
 - Use a default branch in the switch statement to initialize `val'.]

GCC warns that `val' may be used uninitialized in the
BPF_CRE_READ_BITFIELD macro, defined in bpf_core_read.h as:

	[...]
	unsigned long long val;						      \
	[...]								      \
	switch (__CORE_RELO(s, field, BYTE_SIZE)) {			      \
	case 1: val = *(const unsigned char *)p; break;			      \
	case 2: val = *(const unsigned short *)p; break;		      \
	case 4: val = *(const unsigned int *)p; break;			      \
	case 8: val = *(const unsigned long long *)p; break;		      \
        }       							      \
	[...]
	val;								      \
	}								      \

This patch adds a default entry in the switch statement that sets
`val' to zero in order to avoid the warning, and random values to be
used in case __builtin_preserve_field_info returns unexpected values
for BPF_FIELD_BYTE_SIZE.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index b5c7ce5c243a..c0e13cdf9660 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -104,6 +104,7 @@ enum bpf_enum_value_kind {
 	case 2: val = *(const unsigned short *)p; break;		      \
 	case 4: val = *(const unsigned int *)p; break;			      \
 	case 8: val = *(const unsigned long long *)p; break;		      \
+	default: val = 0; break;					      \
 	}								      \
 	val <<= __CORE_RELO(s, field, LSHIFT_U64);			      \
 	if (__CORE_RELO(s, field, SIGNED))				      \
-- 
2.30.2


