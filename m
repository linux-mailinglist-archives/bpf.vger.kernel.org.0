Return-Path: <bpf+bounces-32093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB4907671
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB311F2196E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224641494CD;
	Thu, 13 Jun 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jEZH5gc3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WDcAqrKw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FB13CF85
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292069; cv=fail; b=V//3SfeO/rSZBzhcdczwxbAIU5SQl0fTv885/7r+fg7ja3gyhIMS1HBXiO5K2dER7OT9HsswS2m3XfIvFzHQ1VfQ9UIN478bC/6dr+sNoQt1zRuQ4WL2hVmpeMjvuFGoXhjCn2Lbz14xTY4IqyD8w+pAZaKjnA8Z36ZSUXOIUWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292069; c=relaxed/simple;
	bh=1vMQJbwJaIjEHvHApAXj1eZ862z8P8n8ev6P9N2WSb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j493Nj36zpL+0hWk1SqYRoROMLk5PLJaz8/LL14an/1m4lWvp3dlekfLq3Vq842eeuQ+IEqOhiAkHDyABnvqiBkiCFQgGNJDLLCEtqX4y7mf58QsQXFUOlYdMDG6QLdDzQcYYOXJ4d4Rvw2r4kH3OwJ511ObjaC84TwsjWV/6Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jEZH5gc3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WDcAqrKw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtSUd004489;
	Thu, 13 Jun 2024 15:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=; b=
	jEZH5gc3AOOfdSV5uU0yTAGFs+XxML5oMgZVWV7lMJmxiO5O/bI5myI/7KMYsUm0
	3awLB6jTheWcegSV68rGkY0zX6bleUXggJ4b2dnslo4hLxAvjlMnIEZCVmWagIj8
	bLEH01ATmfWdNmiLjNjFZssx5IJ94FIIo6yl1Oln6f3Yvy6r3qzkqGOGU7Y+t5Nk
	nOr74pmTwsnk7pDGNQkOq5SVdbT7PrTRJfEDTWdVwBHOC6QHt0qHnjMrUFnogij7
	+Gm5lV0uLhWoZQbQ/4qTgWbrUoGs9cf49xVyu1eB3ZJkEIVXe5XtwSGr8dKMammI
	n9Dj1284y7pwgNGXqRtPqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3p9qre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:21:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEvCwt013204;
	Thu, 13 Jun 2024 15:21:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynca15ryu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE+Jjj4nBoSahrp+cqDzD0ykiWKi/MSkPKoT8LLQPhofVorZRnpeBZ8dGwSzRcpX0wPOR/diUFXUV+nP69SmCXyq7pFJwikOUAFJ+OPKx+dqmOLsPczdBKOucS0LOAI9HQ9vQBwaCkQTHt5J7MpZh13aDYmwBh3gJZoW07ec2thYA/9CHMbAMsfuu/WqkSkqntM5E97vl+CZWUaQw6Kjyy8uruUWphZTcW8xfzERyGYYtrOnydrTKlM/eqpDA0YfwWpfnDK+UeJ7gnqJGdiELNtLQiZEiLXOOVdZQFJRNsWXOef+2liViqUAphGwbN7lZrwx+b1JABoyzogENU/QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=;
 b=A7Hpwj3sCu3tmIs+5n+ZDbn28wsLR4VG3KXWl6W3rO+87epAJ/zQwo1sQOQitlK+qBKPR7MKMT/290oNLeJ7Ksl3lRsYaD29HSasos0PDh5t7Zldn7gBZGiz5z5BxXOVjEqz19/ZMdqv8+XLvuVEBz8n1Jz6WdgUrLN9IIn4X9fDZMOFlj4/P4lIGRj678gAuOu2rcAddLOF1Jn1A1+w/pKyWipxbFEAkW/NvVdlphv2S6wY66DqWcMx5Nse2ZkzJBaDdr4kb+Xh+mJId6xQ5dNTOi4/tr9jqdBn74WaSI3EkleZVIO8K2H3QtWBuI4PQdCld7KtrJd2rfw2X9iuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=;
 b=WDcAqrKweH7cDI62R9+h24SeUZ6V9VYVe+CSrwfPnZZWIvIx9usGW1vCq6L9D2CC5XbifH/aiO2hDW8j2tvsGyxyTcDsWrsKYbOaSk0gqKbHXoqP5EF+RhLUPw85YZowlT6jkiyAhAX0TkFHrPGV/JI0gMu/rgMeb1VEEnPOI50=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:20:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 15:20:56 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: Support checks against a regular expression
Date: Thu, 13 Jun 2024 16:20:36 +0100
Message-Id: <20240613152037.395298-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613152037.395298-1-cupertino.miranda@oracle.com>
References: <20240613152037.395298-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0399.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::27) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c88c6c-4b4f-4b98-b04f-08dc8bbc6c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YarRQnz3SJ15ZZMarHXbLYXkNwPznYgutQU5QgpVNKNo8oLX+20XoIPnPVt+?=
 =?us-ascii?Q?Bm8OEbxWT8m1Qrf669SOCQnahU1xI+Upfsz3uos9JPOpf397ekTSM8B8Yowj?=
 =?us-ascii?Q?191k3pqKExXwiEM18YIe87DFecaODQ6nCSmKrVfayxMD8aR4zqzJfrJfKb0c?=
 =?us-ascii?Q?63sShTiRKhiOrL/G5ginLW6rxVnJlcq0z3fyywp7XYSLDXQT404gMZaA4U//?=
 =?us-ascii?Q?8nFacJwf2T6kMQ0N53YOoFH41InjLzWxlvk0r3gAby+jsoNlbZ2mwLG2O16M?=
 =?us-ascii?Q?JtyxQS5BsmZQUYDSKJHOhk1iZ1YWIL2+ejwy18tB7aWS3E5eEPCdWSmEB1yz?=
 =?us-ascii?Q?xD1ZhLo0Hd+ppHGXENNSMdHZjSlFWynUF5TJ9DbwYUsmAc1ziE64OxoWTco4?=
 =?us-ascii?Q?p+ZDYlc99c7hp9FYGlxi34Fw5IhNNH4Sp/0cHCVKkdQISbvN44se+sX6146L?=
 =?us-ascii?Q?2PIXfseisXhQGF3MuaTyKJTXMAlJ/iYMbZQ+4vHXbhGtW6AtUDKNv5S5OIn5?=
 =?us-ascii?Q?kVVFoo76matrZTBUN+W5Mw91PUl+KtG2QcHeh007koIEAV96oNbNS6zEGrTN?=
 =?us-ascii?Q?5k8v7VrXVCszmGyhytYSae0WlOuX22w6uCgxmLvgBerd2OaHgJ2QhaevvbA+?=
 =?us-ascii?Q?zneZo4HOiffy1xcEs6noGVlCrBZUmWXebyIN7kf/hw5ZVypcbwZcoTQ8X4vM?=
 =?us-ascii?Q?YxHGxfxuNGngKyEylBTjdEUPupdguaaSqK1QBFwz5LYJW+F08973xb36eEpS?=
 =?us-ascii?Q?N8my12u/nGZJM1dLmUOeDiem6uuyitq39xmsF2WwF5dA6O46mZAjbpEDGkPN?=
 =?us-ascii?Q?LkvKV7vvqT+ZLcdsf7aNvkDwQ4iPgywEyHzanPGHabMXLcg3YsPX6i60eETt?=
 =?us-ascii?Q?DEYYRcAK/RpnVK8Rhxe/bKFohZp+BHpaVTNifeqOhwQZj4Oz67WthQFmsGyx?=
 =?us-ascii?Q?72FjpxkTUDnXvwjDKDqCK1wCc9hRsmRHOPQuSZTpaEqYeVjRQ5vkn0hA9W9F?=
 =?us-ascii?Q?jhLoecFRulBrOFTjx/IaKZSPzMt+90clOXLSuZlkxJHZft+Lw3g9Yp4gnOft?=
 =?us-ascii?Q?lxTdJoMbdcJvwTUBFhHeSRt+D2bn5cOBL1mid/h22GzMKHT3VcRlSpdyGDPS?=
 =?us-ascii?Q?LPxF8MLmVY17mqP7jdK8nifTC9TKCJV3Eat1AFdyXwN/8dKRvUV2mk62BuRB?=
 =?us-ascii?Q?a6aS8136fVfE1xKgkl+bmiEPW4s2zkhaPk8AWsWjDN9k9xrF1EKNK6x6Wcfa?=
 =?us-ascii?Q?5+7LIBs73x7tbrm6j/n4q41vDDjBAlcUtP0Nvzpnt9UWxlLcyDFEOI6fk8vu?=
 =?us-ascii?Q?ilpBWAdv+7gBMwMcEJwP5SgU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eO+auG037ARW41RZhY90/n9UM7KLx+UgA6N/e77NgzrNxyAy1PQOZrUvwp7o?=
 =?us-ascii?Q?daRngZTiaxBWnPfFKv7xzj+Xpw+N178k9nrE1tbaKl92yxPJkkaVKBbcaIF7?=
 =?us-ascii?Q?prDd92S+Y4s+K6oWH7+1xCwqI3NcbwrVBpG+aaJrs1dkLErSKg2vv4XbDb0o?=
 =?us-ascii?Q?lqFQHt9sQ91xLAbbLUgDElwVPhsbd/Q374C/fA043kP9GOQoO38kdx60wgYj?=
 =?us-ascii?Q?/9BVygfv70Z4bq2jX0Q5dSe6ylVSRX9SAlGif21X9QSMG5NbbIwS38jTo4ny?=
 =?us-ascii?Q?IKjbDvtW6u0kZ97XDntSbrCWOTaYSp5TtJHdcGBkHhABdHuA+H7vJi2l49KP?=
 =?us-ascii?Q?uP+oj+fbJ06NvZ1FLrYWh1U1X5qU/+ZgL2C0iWd/BO2/0SFwOWezxGrQkph6?=
 =?us-ascii?Q?IDRbGWVG4jl+vTdEQXWym26n941sh2cdUUGds6yTEqJuiD6DkajrJajZY6TH?=
 =?us-ascii?Q?taC0qJNFwa3Ccvu+ueCqMDtC6x1EqHeevHtv1IkeZji6xVwCt+KIB/RytIhI?=
 =?us-ascii?Q?TeavZ1mDr5EmXxb3+9aV/6aLIlovyBNfVMpPtOUu41jMwowfx8u6vYWTzyYM?=
 =?us-ascii?Q?C+gx+gWyJK85YSNFgu9cbxPPfz4PW5CuKuw24oFDoLUrkgGExrZyGvLbmKiT?=
 =?us-ascii?Q?N0K2FfgCpCD1i9PdqXnX0iG1idcJGmWzfubtK6heqyvAf6cbtRZKnLiOCLg/?=
 =?us-ascii?Q?YkpqkbQo/+xNmjKj25iRWlnTr3JhgxA6yVayKnX0FQXDcbph13rttOFoLMMG?=
 =?us-ascii?Q?SL3dui/91jvOl6bOmwPqG/HEnKGp5kYZMhiB1nbRRg0iU7EIZ708nIxRtmqC?=
 =?us-ascii?Q?vxdzAeuvWelnDuFrNu4onCjJFuOx+MFfrmpqQse0BAGMjqahpFryaGKcuQB1?=
 =?us-ascii?Q?bVDPTXUc6fWNSJBiDSgXSxAJ1bWZx/156woOykghpmF3b+RlOg9l7Sire6Zj?=
 =?us-ascii?Q?3XsW0AKviqPOHdE6TTMkD7eWvLwaEy8CVDPd28oUV4kV8onFbHxDr0WEYMey?=
 =?us-ascii?Q?OWNXpqIxnRd8pFyaa37nPHhQn3suslnMDUnruvWRk2T7XJiWnnCNjiIk1f9j?=
 =?us-ascii?Q?7/lG6iNitObLyDCWTSkdNR8FeFXtBT1V94uPNhTAMtfs9qkayeBD6NBsoPS0?=
 =?us-ascii?Q?tgtUuR+oI8NogLGkECpChksrMxFWS34BbaGI9wsm0e6FrDJk3x9dtK7vHUTZ?=
 =?us-ascii?Q?4pooGhiMH0YjDXGhZpP+sptbZ8nET6Q6L36S3cyiL19mlnJRnBa4Zrb2bTTQ?=
 =?us-ascii?Q?6sYtm4TsKO9hIHv26b77UfxXXvT52EoY+apuXZ1YYiUaLYwBZfaDefHkaztb?=
 =?us-ascii?Q?KTyhOeBo5/T0BAkUpOVxwCvzMJid8suusd8Fw99nJ/1S6s0kII+7B9UuaLtX?=
 =?us-ascii?Q?zX/9WBXAtAvjxgh/QUsa3r/mcUNigwhOIUm3/RAoJH6IBZECYD1M8zH3EA6T?=
 =?us-ascii?Q?hiWzelD1Fq1mZJaN3BDeBJYPkW0bBYwkzWOeffmQvLdX/K9vBcE6HkymLAiQ?=
 =?us-ascii?Q?Fj3m3dtVJhu91fAuNZHcQbofQ+4trSNnX9iaaHRKemt6aV8V1Tazir+g1m3P?=
 =?us-ascii?Q?ef3IPibyzC7my+Taeb9nea7jAL9sqTU0eahghtgML99WCqgSvQGqV5idvLvT?=
 =?us-ascii?Q?qi9JhbeBQy5Oo0LK+N4hY8E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BtCin+6bmjf2Wbi2jscqTydsQ4jp9n6T4deN42UjtOwVqdN9DKrm625ja+EV2xq7FK68NoG4IFXYaudX690d7uwk3eiknBtfMXx/1cQ1HFFX8mQ2p9EW9tesVI28f1g2KN0PE2CBHEwuoy7ekP982LwP0mb4LLZwOBR9N+M3oJ9mzAxDY0aX/Ym54cXYIIAJ9tcWtASeLaur9iK03km9jjoMXUpqIbw2SfDyu0H6krghQGY6DCCoME9eukMLrpQhl0mdTeF/4VfFjswWJa8K6pT8RRBzL9UQ9PujyLzN6BXiwn79rieEKevY1YPLCvYgeg90FgfpKq2ofyFkoY6ZPSxojO2TKTN10wh4iEbP2uavYFSGi3TKP/PZHCA7OWlKL+kpOzUysQLdrx6de14H/cW/oKEjx58AlzCmmJWTv/iG+Zc8Fn5If6Wh3gxgd17aGBK9jjh5dnvlicmHwXMHsyodsvxwqSyGz5zUZAN3Mwv2ZqBh6Y85YAEMQ/WE7xQ39R/QULkKbxqJvcHJXUk9ozIw8Pnq2UgpmZnt2kBQxoawRUxcYoX8F/AVaR04p7BXnEyiWG9ZvbiauhOi7yjnWmMfXg+kY6sKs0F8p5dtbAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c88c6c-4b4f-4b98-b04f-08dc8bbc6c4e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:20:56.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyI4kLLhbr0InHrO0fH1clgBuuaUMyQlXflNMoeG9p1GC2Qi3HdwYItwlfPKmO+9LHt36HDrE/VtiBlolBJILf9HlUkBFAl5C7CzinFjHJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130111
X-Proofpoint-GUID: P7rebQ_i1aNKhYwZB4c9FY37UO-m_Vzr
X-Proofpoint-ORIG-GUID: P7rebQ_i1aNKhYwZB4c9FY37UO-m_Vzr

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect do substring matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 117 ++++++++++++++-----
 2 files changed, 98 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..c0280bd2f340 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..0670540b36b8 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -46,10 +49,16 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	const char *regex_str; /* regex-based match */
+	regex_t regex;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect_msgs;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -89,6 +98,16 @@ void test_loader_fini(struct test_loader *tester)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
+	/* Deallocate expect_msgs arrays. */
+	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
+		if (spec->priv.expect_msgs[i].regex_str)
+			regfree(&spec->priv.expect_msgs[i].regex);
+	for (i = 0; i < spec->unpriv.expect_msg_cnt; i++)
+		if (spec->unpriv.expect_msgs[i].regex_str)
+			regfree(&spec->unpriv.expect_msgs[i].regex);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
 	free(spec->priv.expect_msgs);
@@ -100,17 +119,37 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct test_subspec *subspec)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msgs,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
 	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	msg = &subspec->expect_msgs[subspec->expect_msg_cnt];
+	subspec->expect_msg_cnt += 1;
+
+	if (substr) {
+		msg->substr = substr;
+		msg->regex_str = NULL;
+	} else {
+		msg->regex_str = regex_str;
+		msg->substr = NULL;
+		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
+			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
+				   regex_str, error_msg);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -233,13 +272,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, NULL, &spec->priv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, NULL, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_msg(NULL, msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_msg(NULL, msg, &spec->unpriv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -337,16 +388,13 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 
 		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+			for (i = 0; i < spec->priv.expect_msg_cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs[i];
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
-				err = -ENOMEM;
-				goto cleanup;
+				err = push_msg(msg->substr, msg->regex_str, &spec->unpriv);
+				if (err)
+					goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
-			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
 
@@ -402,27 +450,42 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i, j, err;
+	char *match;
+	regmatch_t reg_match[1];
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
-
-		expect_msg = subspec->expect_msgs[i];
+		struct expect_msg *msg = &subspec->expect_msgs[i];
+
+		if (msg->substr) {
+			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			if (match)
+				tester->next_match_pos = match - tester->log_buf
+							 + strlen(msg->substr);
+		} else {
+			err = regexec(&msg->regex,
+					    tester->log_buf + tester->next_match_pos,
+					    1, reg_match, 0);
+			if (err == 0) {
+				match = tester->log_buf + tester->next_match_pos
+					+ reg_match[0].rm_so;
+				tester->next_match_pos += reg_match[0].rm_eo;
+			} else
+				match = NULL;
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+			for (j = 0; j <= i; j++) {
+				msg = &subspec->expect_msgs[j];
+				fprintf(stderr, "%s %s: '%s'\n",
+					j < i ? "MATCHED " : "EXPECTED",
+					msg->substr ? "SUBSTR" : " REGEX",
+					msg->substr ?: msg->regex_str);
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.39.2


