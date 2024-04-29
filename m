Return-Path: <bpf+bounces-28170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF58B6487
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDCDB22453
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474418410C;
	Mon, 29 Apr 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bm+dPgzp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cSSzGPHh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA571181CE1
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425829; cv=fail; b=o6VvZjBYP2U4VI8CkbVhAllkoltA3K8ysgCG7DMOkJpT6JI7LYodUKWoGSWBXE1LQ2fvYoJmGyLQLa0+NMu4twXj7JVO/L8VrIxlmxCBuE8t/U5NDnl6e1c8J1e9sKfpcaX4pbLSw2pzLCmB0pS1miuW+1VoQOmbTcfuXV2d4NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425829; c=relaxed/simple;
	bh=C1QgBYla+LEzpbFbQTnqC+/5tLYIIffgrXEhs6aX83Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDXfdxL7cVziozqpCcbxSKI/znkWDR8zNwP0sygkvLnko3qV+GK3Kg4DUrav+j8s0yY+GQvY3w2ao/SgR6Vr3EOCTVeDFwKMcYgaRNIAiyCEVLyxyadsCx2q6oGCVijqbwObRBX+YQFiEl5kBWprAoIMZ4o9yEWmajeLvpYunAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bm+dPgzp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cSSzGPHh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFg6A015469;
	Mon, 29 Apr 2024 21:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xsnL++MmLOo1Fs7S8xQ575NKiGIAAkMC1NZQHDvYYG4=;
 b=Bm+dPgzpAOat617C4XB0JLiKhPPGS3rc8PemDmJ2qNjJw2ZudLdWN0gZ8xvL2hKUpzLF
 ojpuYkw3+gDkz0Ineyc2I0qlYmyyFAC0A3gjpyUnrGK3hc9FnFIr3y3PQK/NO2NQwasI
 jWVf+uLbBwdNez22HkJvDpNsClNWAQDeN8WIL5KJn/DOuAawJwcIs4JJxerm7948x+KT
 ZS0yUOJvgJLtjv6LAq+8b+HGKIk9fDGu+WHHpySe/0rFlV5CUaz1gbrSd9/gju3mWeHo
 xPRyN2bR6zUmsZesCPJRE6IdnkXtBlKVzg79mH477Hi8/CkQb1bDBaiPIpqvGQJWT4ne +Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ckrhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TK3Uuu033171;
	Mon, 29 Apr 2024 21:23:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6qyce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTQB7BEJL9a3Av914CVDEN70Sf40A2FNxotXdzFrPWFBi1il9fV20lxK2wgtYW/Yx5URFKzISYHuFNGOKEvpg6AqD7PWYHXF6lisw6BvRrIb20zK4Lw8pIpUYf0VOJHdDIJBGVsyq3pdxwaMehiv5EFpLC8DFPcW3hukr95aPYHqHHRNLtmHHqJkJkhxopvsbsSDd4F3BLBlSmbC2IAi19tkj5J2OhA09m3I7S0d/dnWl9L/zvyUzn1bm5TpjK+wJIcLn+eSzHW1oj7XFHUGSJt1lN2/SfAXkysd03FYGo9uCezDddIQ9swkzeOAUMecISd02++YG5fNEQBiLK3A4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsnL++MmLOo1Fs7S8xQ575NKiGIAAkMC1NZQHDvYYG4=;
 b=NpHGxijbZD9ZSlor6nJfxO8H67OODzZgVpk7nRoVpfcOg2Km2l+CPzp/u+TaOGgFP76jyexcYLyNtboTWVrIlK4gGCHie1UzElDYK9vyeQxVX8Xn/NxsQ2pqOOnxOtdAdPBloowkfik/o7sldXktRtOE3iellPu/ErQiPYj6OwIFU6oJtr3JY17xr1rAEaPNLbwtxqNZi9Cc5wIc+f9AZ4lUoEOBL7aPxiWvRsLY/0wmzveczIKyvVbnRSxJERDsXYECXTKOGN84ztsaXwi4P32hlWqWMS5JxQA6kgfZR5lihu9eSAaP+yoS2xAmBlA8jXlMbfOaZha+hxYVU94S1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsnL++MmLOo1Fs7S8xQ575NKiGIAAkMC1NZQHDvYYG4=;
 b=cSSzGPHh3A38yguR21+fYvlvh9eT3K+IebhRJRpsQ4I3mL0UPv+jnAtAir5TPYYuYsR/PCF/390VM5Ty8slhXb42MXXqJdJjFbkw08nU3zZ7GvKcbr4/uYmOnbmoSQb+WiZ63w4pbaJ61X1mqVQZyhSDjmh+RKOsU3STU6btQPs=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:40 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:40 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 4/7] selftests/bpf: XOR and OR range computation tests.
Date: Mon, 29 Apr 2024 22:22:47 +0100
Message-Id: <20240429212250.78420-5-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::24) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3b9449-ee75-46c1-5354-08dc6892a3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zR7UmqiAo375DpoM4v7+/QnhKpt0xRofBECSAziIZQu3WXb0fWk1qbnbx3Ys?=
 =?us-ascii?Q?v05C/buesVPQm2mctuKABGkz6IFZv4pI1UdqGssOMt9XxKN1/LQetjv9w0Yz?=
 =?us-ascii?Q?BOEVYeozkMnA7QgA88D3xt64pKJE7EZz/ptMU1gW6TvrdEFyXgIF9pafX99Q?=
 =?us-ascii?Q?cq3HQ21QO8buTL8sVVXiY7NsXXQyrFDuPSeBfoJGmVSvjGTdBobMARyIDlSB?=
 =?us-ascii?Q?D9VVuRB3ZGB+UrIYdK3iSZcSqCKMt/P3MaYCy/ctNyfU8yYiJ4tcgWhBoKlC?=
 =?us-ascii?Q?Io/mx+5YgpmhbzeMmSzkuJhG0zNKaVsQfdpkyDALtl1G4TWvOkPJYMJZ+q0/?=
 =?us-ascii?Q?AUSdB8dM6A1cXpl2ohs2/vWLNJWk4Inx4dSpqunw2nYmiEnhc60saGa/hcoD?=
 =?us-ascii?Q?hG9W8D7wDrl4+Kp+5bB2q0hHZgcYMaLpExPwgKTjGUrMgoCtDU0MXK9eiP2t?=
 =?us-ascii?Q?yxyhJnCyBSanUVGrbZ+SRWzg0SS1r2abiYfokmDWVxWGonX5UdWf3kKEc/tl?=
 =?us-ascii?Q?yocjFriNYOin3w8cEHhhdRHdQbN7TFlA9N4BZFNdlf0/Qokj7WXv7r1uGF9q?=
 =?us-ascii?Q?c10iOP/fa9ylQ8XFs5zeO2Opg7VXQBORID5EJD7YSNrZoZwpnVrWSHZunPQ+?=
 =?us-ascii?Q?X0Hm6uU6hHy1QoD5Q2e6o9XVJ2rOA5/OPuj6EPxddfTqdVB5xD1Bp+ajTTfn?=
 =?us-ascii?Q?ofWWC/xZNDt1Vy1oCwvloJrAUTeYO13R4M698+LI625rxNPNg1ECOoNMiNzN?=
 =?us-ascii?Q?ux1z6m2iQPflLU27RLwM723AOh7woF6n0jYM5aySY/k8HR4jJdsawl1+zLnU?=
 =?us-ascii?Q?6YxloovJgBHKpCN84GtZDEpQRMYe7Yd8UIi0K8ZekXrqyPD9/vp5KZpa7Nfb?=
 =?us-ascii?Q?hYyKkMDOB0ENhWhNgHaUWPm+I/NmyOTJ7EOfR2r3EQun/hP0qd6d7Z2EkerD?=
 =?us-ascii?Q?1KIQLPKjjTcmB11mgP7XnzMpzjfjRpwGO1+Rwg4toUZbMy9/PmrJbiPp8DKc?=
 =?us-ascii?Q?SoEvBAf9P71Kn/MSoWyjP25FFAd0Cwiv9Ya40GwLYPIDJbb1ZF64cCsegRlE?=
 =?us-ascii?Q?884jIiS9VPlDcTIJgfrv7PdmRVNlBLHRk1vMJ8K7nHZx5ud0VRyIwTMAv05G?=
 =?us-ascii?Q?rLOWvP83GB3U8tEMqo5CaidCP/oB0RGyHSiGh5FX+HK6W9lVRZrmBpZdKhjs?=
 =?us-ascii?Q?M5m6iO9sBc7qJt+spXd8dI53lLev7XYFjnBcoN/CS4ezjW7wv32/1OxY4F9w?=
 =?us-ascii?Q?NZtmS/s9Snb90lnRotdmrWNZouJnN/i0Zh+hQ6oYxA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nLEOD+tYBEaGu8aN+aV/9+1MFW6LK4MFlfOZsBM1yWqesHt9oFc4EvKTPFil?=
 =?us-ascii?Q?So9VX1DUlnUYCUNzSF+kmxTWjVf8VYDcf0oqaQPfj0SpN0z8BBbKi5o70b8m?=
 =?us-ascii?Q?rKkn1V18V2aLZUsymNXvYidzz+qDTpirZ5jreqyg3hAjQW2sLcg7JRiEtbcH?=
 =?us-ascii?Q?Wixu6mTh5uR/DaVVIlCARsR4/tjpCSsA+yPUt5OJCeq7Zt5aMckEKEs3FNNP?=
 =?us-ascii?Q?/rUD2+J81Q5Zj3j4KDmnYjfDzK8F7Jmj6ryyBoD9ImlmG0Fk08A6NAy+u/ko?=
 =?us-ascii?Q?Rhu78Tmt+3MmJnB/8Sv6SsNekRCyECrWAmCF2C3pXwQ/BCUAp+EtXqcJ04hu?=
 =?us-ascii?Q?2hZg9O3M5qwl2LoYk5fvlRPe7aALnQJX+DB5zMEPUqkCZ+XmQ7ZY8rJtx6tt?=
 =?us-ascii?Q?KRHW5mp1f2u+0fiCvQO6ulRDJjYiBsIhqbIBSNBRqpIqJkwerdh5lXo17p3p?=
 =?us-ascii?Q?Fo94jPtj0uqqhNBnEYZa7PUrH3DjaK4FcvHz0VUyy+CJtwEDDFPq0dVvNLUk?=
 =?us-ascii?Q?Ix7Sh1v75ROG/yD9azYKoSpE52a5SqCmYzQ6VkYnTy4qgNbCWE2LwOH5vehq?=
 =?us-ascii?Q?GvLxVuLOK9PVN3WuuWocHxKS2sOmepEevQaFM2wM7xTFEcHBQ/fGMSetn14E?=
 =?us-ascii?Q?YQDft0nwCpmPMXhFghxCHbGNHDtOvGogphTS/nP1VNhyauRyi4uFpYBeGCbU?=
 =?us-ascii?Q?SqpBFG2KF3Lj1VMoUmhD38EJrNffkyoNLjo0lDplUnUAyzh9HeKmFjmxIj8N?=
 =?us-ascii?Q?rt84dGXWUscGbYsrqW5CDk+7lrHNe8qyIQSFOLSsMnufDNPDw9m4WC9+/nVi?=
 =?us-ascii?Q?5yS0+YG98ZRtHCc14CfvNb6KxNzNpDP6/RzwB74zRkSNOsIPye1fiFep8TVS?=
 =?us-ascii?Q?8+xWqB1kQjbay+lYsvfc58aMln14KLKqXC0/MFx1tXCWNbo5OBLKCqsjLdOy?=
 =?us-ascii?Q?pvrnG147PMj13/fLnabKPZMbOI3fVJpl2Nlia17sLQ3F2wo1MYNHGv8D61Qd?=
 =?us-ascii?Q?Z3exB9soNKaxgxmOkqAw3q26KvKR21PA2SkfeMw5w9rrO3QQI49UhW9QFKgW?=
 =?us-ascii?Q?6m1PaB1dtNhWH9jsQ1pXuzBzAdOJLG89JaLSa2bpWv23M1YGsez3pk/xDgKW?=
 =?us-ascii?Q?dmjPnt+KTQcFA0G3dE//Mgju8SSC+baOj2xHzETkZkJrpCtz6EW2si5pQ6EI?=
 =?us-ascii?Q?/vkqko280497Hcg49fXojca2+nFyeSvzMLtR8nWjjSBA4JUJ4HCBktHiDGfZ?=
 =?us-ascii?Q?UnwI4h754wBCD6Bxp/0/FhD5hj3bhlcoUH6VS0CHIg9fLB3Ic6UFUlscZl99?=
 =?us-ascii?Q?rsiI/EMXCdDQNJwqUjo4uO/oS6rFCCpVv3lxxBroOEWoAIk4t764i6tkF0gL?=
 =?us-ascii?Q?qblo6rlP2OvDiWRr2XNxGeEwi0hDXBw+MTEJr+6UlN4CP7oCD2jYbagvtK5K?=
 =?us-ascii?Q?27TXsx+qEtJ3uXv4vEG+plT34B28c/Kwq9f3mV3gVim+aWg/HSDcJqSwDDET?=
 =?us-ascii?Q?usWJTP4DSj67JjnySxgdwHTh1lhBLQ/YEd1YRhiEAGXl+7N5u2VW/ws2UsMg?=
 =?us-ascii?Q?AiG5NnYpsMMQ4PQyzOGtPz0RbnzgQbfjiRFWMPaO2tgAOH+H0my3TxsZ8eZb?=
 =?us-ascii?Q?NUUc4nLkf3xD7ut9kAWCVJE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gnURwY0OfSVB+RJbhaXMhG+mlNIxAaDLJ3oCGd8PclqV0WRs/lQ3e77vmKZW1GFFGr6f/MoQ97v7lfJtldjRTXB5rg6XEBOUXbuClkjkaIga5lJgUD5NG19I1DpSlNrTuausRGzZLUFI4Gm3MMAKQG7eq5oxPspv34H9CFl/CMBqpRshqtVXcZiwEjF+VlZF1DkLvNAGsvYzLw6yfCgfuC6hMPebkbX0SkFnPup8FCDd+F8bUevYa9eBhNNHtowZIWyP+8xEGuTMXQZwJF1a5E8R9tiH6ktm4KmGU2HtKUvyzLfJOne6erlozY36S4Ai7bsNmzN8MTEnPQCWfd11FRwcmUl0nCtLdLKDfIynfg8rx3K4BhePQMRZ3lcmHOvzDF2miWesCxEni7LNoP1qlvuh/E3bDrgoeQk+yvUvx4ab5+BtKjzHohgX+zjMsiyQeHF0VsyIojiMo+Fi7ORhJIyTpkRVA72UaSj8srlQD6rDU152MB2VDScoE7//BNYjK2v4EaJ+XMAEbOT0VYrdbHXlVOdtt0s5a/aBMA4bGyHU/YnewC5fT0n7RmARkXvGmeLioaECHpsEYhzSwI/hTC4i1fmL5QdVQEv4Kvn7SBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3b9449-ee75-46c1-5354-08dc6892a3d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:40.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15Pzf1quirrYulUItyro3pXNab2T/9TwmFnTBdgZUII4rlZy2zLGWiKKhNHLfdUhKVI0zQftD2FjP/JdC2ye97csmqQdhFcDXmfZOAuvqS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-GUID: _L__vg8NZLwAB71WAPuJ2M0Uy2_uqAkz
X-Proofpoint-ORIG-GUID: _L__vg8NZLwAB71WAPuJ2M0Uy2_uqAkz

Added a test for bound computation in XOR and OR when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 960998f16306..7d570acf23ee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -885,6 +885,48 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const xor src dst")
+__success __log_level(2)
+__msg("5: (af) r0 ^= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__naked void non_const_xor_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xaf;					\
+	r0 &= 0x1a0;					\
+	r0 ^= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for non const or src dst")
+__success __log_level(2)
+__msg("5: (4f) r0 |= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__naked void non_const_or_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xaf;					\
+	r0 &= 0x1a0;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


