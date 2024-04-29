Return-Path: <bpf+bounces-28166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EB8B647E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A991C215C0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B81836D7;
	Mon, 29 Apr 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZ6XP87v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FXIuJrb2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA5141999
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425813; cv=fail; b=Pfhia3BMfIm4LdE+hw8IuRSUxN0eLNIDBE9BfIMstA93d9UHgLK13Bu17ofkxFkqWCqAnj+tiglY5fv2Z2PXyQlwRwkZjhVoH7mxdZ0UhSnFahscX1DytmR4NQk9ZXfJVhDBGn8x1xwQooiGl+v1Gxg8dnFZgFi1InpAAun8dHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425813; c=relaxed/simple;
	bh=WRs8dd/N4EwzwCuXW4w7fAPS7n5FU+3UL6VZ+zQJKPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnQOStMuOu+Xn4EnvKiz4grsZTsvjhOlPzHrpZC4onT4tH7k4zRJ4DvOAoSmwTMeMNvBIh9q68MPfRwtDE2kt6ciCBH8HEHtL82fgbc27cp/QJHOeOTZlLBDrZHwVGebfv88fOOo0NTeK3qhAxZOgnPKaZFozyqLnLTWrCIDc90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DZ6XP87v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FXIuJrb2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFxGx002944;
	Mon, 29 Apr 2024 21:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GF0jG1TNPg+xdDAKilPbXz7r0c2+MRy1+GFXWe7UgXM=;
 b=DZ6XP87vTLVtxylTcl6uThIetaztdmmh9IKw3ExJMKhp999cS0e+B7EaOhmOL2XPhB2R
 /rEDcfii9PEfSa0mDwOzDgNCbYkdHqTfDYmIkWGi4JKRR0QrjymOw1fu08D6sJnmt75V
 ho2LJjI0l6WgoUX1sfUnKlMMLmiL5jLWYpK5kbw8PWSFMcDggLGTpMSH/Kj2c9UL8RZz
 lVRABhg7VOWl7T91in1Kh4l3RHHGQPPDWZ1y/s+KAMZGv0Fr32w2rJz9/N+tklx/Zan/
 beAvB1YGkqh3RgkOj0oVTX29AcI+vnmSd8nL7ig/aBt+14nUHMAROtew8+kR8z9hQJwt nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54bpdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TLMSvV005063;
	Mon, 29 Apr 2024 21:23:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6g6hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG6aMZ7VdFlQTurGiuMj/993CONg92r9RBLedxbgiwNUNrkgbgI7Fvi/WEiuiD49rc+KISvzjP/P7vOTy2hs8PKDf7qSC+6VjJG8yUqj23sk7Ksx6nuPIEAAjORIZXB8Rypsh59rXvK+MOw9NrRKBELVowld9OtDQraCugVxF30wFYC1Cu6wTIGHfXAv3ySSdfNI34LJMLL+1W9vIgJrjszTT0f10RDpLs2kSOENm1H8aH28mNxV6YsgCf/TEdoyLp4BAtJhLBIHszcdWPqbJYNigsTxrwiZBmz21GUqalqYG0/f6wJFJ6nhTgZ/8+14GXRn9uwziSXK4UruhJtpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF0jG1TNPg+xdDAKilPbXz7r0c2+MRy1+GFXWe7UgXM=;
 b=MjckQ/DjtH9EwjPNg0cqKN36hKsXeNYrPIGBS1IpITPpeRo/NkGDtwHjUSLKXBwLgUohU8NZ2VDijxqlV0qBS4XG+A62a3iTsyzj9FvMtVRW+5w7LQpWoyl8LE/PCJJue6XJoYyndE9r05zdFaW+YR/qvMOjHYN1FSbIl+ybcMpbCDoKX3QlHzsBUmmt83vIGLRa+Dq4xJCHBNTmJBcPsD4t7m6nBFQs8VVsIZHPvWy6Ejj29I/sdfU42kms458P6q+x05ppVp1NN5u/A0XV/0+V/nYQJh2iyo8NNpLcfEzVfwFJqRsYY6H6menWe+ulm2alCftIxnCfhQxyYxDWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF0jG1TNPg+xdDAKilPbXz7r0c2+MRy1+GFXWe7UgXM=;
 b=FXIuJrb2/CLAS8ms98zmuTYfs7xp/cZI5bbXCa5HiOJV3RA8L6aSyQ5l4M0VYuOUVOHf38bVHRViImWRDAzNrQM779olsOqop+g1hS/Sw/hM0g4jkJOfoEOefSRttnAvV1B4K4co87fX+DyScTibK0/XrWrcmMgZhfohMniP/As=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:26 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:26 +0000
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
Subject: [PATCH bpf-next v4 2/7] bpf/verifier: refactor checks for range computation
Date: Mon, 29 Apr 2024 22:22:45 +0100
Message-Id: <20240429212250.78420-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7ef4d8-8c76-44f7-8596-08dc68929bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qVD2vCNs0rGfMGwZe6uMeZU23HXLABxMVhpuLPOnIsTqNT/5z09WY9Jxglfy?=
 =?us-ascii?Q?V07E/MQNQWY+5mxXxX3PoeGB+JWigJdjH6QjtJR7bnHf/I00pCPitucN0bPo?=
 =?us-ascii?Q?WI0dowRV0cEMGJ5L9YlJ/gry/p48t911lcwmqq0W2BXermoQIfj2rq+SH6Tu?=
 =?us-ascii?Q?uGzlkGbKVVOu7+Gr99A8X0vQshrDMKyqvuSDrLTM4ELl7775P1tQaNA7MEGf?=
 =?us-ascii?Q?O1HALfQKVv7mt8PECaHhD8b6BLDTkqCC5SKnnogE1Nb1qvD28RbahFjW5MEM?=
 =?us-ascii?Q?W6jSUvRzOIfH8BFpBJ+mXWGP/HYh5CbKOWnxX1M2n3ahWTnOwsxEWsle4HVN?=
 =?us-ascii?Q?LfN0w517SJu/RAIQPvm/BA0RMdbY+aqHzJ7gDzYsuLVMNB208k71kElmwlZa?=
 =?us-ascii?Q?A+vXW6QWWy1xmrIkJ2XYWq9CSgA0zSQ3x+PKt14UWtsfd6/5FZSUJyOVNot0?=
 =?us-ascii?Q?BX2R3TMbcQH7g9o//7QyTj/HNbQhbYfKg9cvhkEWp92XjR2Whm7KodBlkcna?=
 =?us-ascii?Q?PHTfAOfl1JicwHcy3BWuBLC/1FaxqFkkYBX6o7TB9PkadNjP/Jsp5sSC5D+b?=
 =?us-ascii?Q?8sOsFt1z3SOHyW3egn6XoUwQYY+BOyENJBoBIBfUzLPVKd1e/zIkv/dI3lqX?=
 =?us-ascii?Q?2Fw92lmDos8OL1V8ucUlTZv7MWCm0ft1hnfCR4pbNjLUMXTiwLaDebj/lzpz?=
 =?us-ascii?Q?voxTsKJbQnkDgbX0FzFS15rRFR4vahPq8bmw0vpxVamzaEMcjSHoOgv5bzcK?=
 =?us-ascii?Q?+H1GgWJY+CKUqWi8QHhcsmV3C1HL0keWd9gJ4Yd+cCbEAE1KPb0FxB/ztfhe?=
 =?us-ascii?Q?ryUHWsuBoeisn8tqlr2zQUZPFRr+r72mDoXE4PcIZ3Ko5W42i3qRiK+AoyXI?=
 =?us-ascii?Q?aivmHoRM5AAw2EK1MuyMyQWQ3kdeNrUItshMmoWuJx9Dlvr2+fDK73G5Tf20?=
 =?us-ascii?Q?I16m0++r/hh5GBhvHiL4DibyzXaBSeEheZk40tM2zoHRMzR70bWLIvDBeUwW?=
 =?us-ascii?Q?A0fhkJsYiM5dzDEJc6jXLyzTkf57YYWfF8qS7pkMlsGvEP0kqQakZEVk0BjA?=
 =?us-ascii?Q?3/SBVn/s/zZfT7/J9TmBZ31HfSAT7N1LUiEUnbfMw35NPOfUYte6JlyT6JZl?=
 =?us-ascii?Q?JzwI9Na2rEjlc64pfwb6YXFXFly+bs35C3fIqnqtRUzhIQ40b+uWyMA4wobF?=
 =?us-ascii?Q?mIMakTOlkZzZIjUc+1K91tM04J3FXdcVL0ZrZ/4HVMVqRd1KvliPtU94lWXT?=
 =?us-ascii?Q?NX5wu64wozPXngojrVkjtRPuX8BTE2Vch/K7oRPsUg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UHoEfTr7UWxulw/xe8oALdt2mwBUjZuG4z5jBcI5U/sGK10duaC9slLBmRig?=
 =?us-ascii?Q?u58QNkvFZpxQH1tc0zNnRjExWJ120oPfX+hk5PI9VgxjDS8QRGA1BFVu/oFx?=
 =?us-ascii?Q?HzVio7sxYcTtkR8ZIiaERbgOUGQ6XbKyfmLpVq76uMeDOChZeVktMzqKTHhR?=
 =?us-ascii?Q?UvDqULVMfkdYr81E/TdaE71RN1jvf4kyuk/3bBoGq/0Kzm0Jr8VU7qSm7jg+?=
 =?us-ascii?Q?JTJzLyUw6QTGQnh/m0pkVvGlHpVocPIWntkxYQvDqkdwNde9Ul1phuWSVPRc?=
 =?us-ascii?Q?+3eAngMI5rY19B0GzndVdXy1gCkBCA2JxPjYoIlC8XQ2nbBzLDb0fYBYV974?=
 =?us-ascii?Q?s4f/1vWAHafWZMu0/lu26E47Iq6Js4T3Rbs0blI1nJEpMUu36jznDAWbdBph?=
 =?us-ascii?Q?J45IL8fGVsswP24FAcHcnUdVlLpUHC+FBBVwUlxK7/dOW0PNK9Lpr+SuaxrM?=
 =?us-ascii?Q?aWg8a2yX4J6EZg2uGzip4tzXMbWNrZVNtxH0mLqET0uGkq0kPh9VMhyYsPZS?=
 =?us-ascii?Q?7PncLIE62UimFnniVVqxC3m3dDT6toUg3Y6wWWzbj58rV7TdWQ/R51C46Hd1?=
 =?us-ascii?Q?jDvJ85pGos94++R9nrOgqB1brTD/IQK0YkAIGZON9G0J1gDNyPngwjgiN9o7?=
 =?us-ascii?Q?Lo3NblRver81n7V9SY2OtFt1oBBK2aJ/l0wtm4jdiCQ4pUKsEd8yT5fzEYIB?=
 =?us-ascii?Q?q2Kzb43xk/AwXvI38EOeZj6cikJYZ5pvD1K1/rESB0jyMRFDh1NA91yEwnwj?=
 =?us-ascii?Q?4w+RSrbdDgps1in9CGG5P+doHJFIIeNI9MJiXayYWgSUhnrNCXLuhxoZ+EOC?=
 =?us-ascii?Q?pXVUdBIa8Kyd8tle78ieFP/Sb28ZpLLZYHmVD1kANqB5oPZKB5qT32LPmgEB?=
 =?us-ascii?Q?lratB5XGQdcytjfoZw9UZDdx+KYIJgz8SIb2lcB/f55U45e7xSlhVtJDctgL?=
 =?us-ascii?Q?FZ27F/vlmOcNEu1IJVr0qEHV4akYyHFSmZb33L8uLJuXUxZj4YX9gFCNybw+?=
 =?us-ascii?Q?ysx1HejfglpoXB3h/4qQKMPyXkrX0Uw323DjxMkFLD0tmMUBc/aSh31JjEcs?=
 =?us-ascii?Q?gsZuDLJu5WAmNNxo31XpZpAXJuAsxV3koMj+z+EzXktlhdzGs6EaVjc85crK?=
 =?us-ascii?Q?DG7CrIKJWCcJB8/vu03ACLJabqY/5zHtX31LGSRNMUMqc5JBD3btJlkBeK80?=
 =?us-ascii?Q?gcpfr/Yw0L64E6emML4N4dfKXIFgJQZMVXp+r+nREsXWRYxMJ4nyBeLGSaUJ?=
 =?us-ascii?Q?qCkLXw8eID1ZvNNAWiQq9gM38fENcs4uLu0JTmQVI6IGX2pA2ddJW+RjGq+U?=
 =?us-ascii?Q?Pi3xFB+Jp8BhpSPQcTq2NzEa9yKlWAue2ifgbhLEB+lO2YE6kB6cikkQA/NE?=
 =?us-ascii?Q?8YE8W+Jn1b8IEche49QS+CcuoeQiVRlSjWsOUUTuT4IHO3PIXXefp1kA41aY?=
 =?us-ascii?Q?DVvlRnnuzlOgak1XQogkyTXQFXcKDzk6/5zN8BStHYwz9VEtLUT5qzgfyC3A?=
 =?us-ascii?Q?QBNNzNgqWMuzZmsuYLMFihJnzj580yDR+Y2m3UlN6+1Y8SseTtuJcK9EAshE?=
 =?us-ascii?Q?L4caPKuNJ8dy9oOuC0a9JJc1Fh4Hqbk7ZLkQxItoDt2NuJRvoMKjYh6bugj7?=
 =?us-ascii?Q?KB+6Pp9e7RgQC7fuPkGTjrQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eBybUoO8Gy2bY/yYmsqJ5r890bIx7zd+IqXc37nnIpNTFWAoi/N7M4zVlwtP0UM4HD15X64tLLWFc0NFMDznpPxNl+00N8B7zJWLWB1vFWyRlG/FSfkNRdfvUSmzSyQc9bIdOD/Vh72+OAO3zrg29hY44DUvODtEzWYAOLgGnp443pjtco9hstIpnlaAkPJVtrHaKTu58U79Khby7xOHC+TQDapuyRg7NqGQjqWE1In4Jkv9YeKfUA1BKdOrAynVptZ7ZjApWyrDgHmFEM904kIxAK55kaqrvQKCFebsFPW6DZ+ARBB/zH2O8vbMFuCkcSz3nX0PqI8FuFAvRS9BGYZ+1uonipMsxMntOfY806Vap5yBeolYp/f+GPhaujRTzR9d067v6Mx4KDnBlXvTwVwgoH23JGME5UBln3uhAvtXNoSTQrZmFNr7tJ9pesFXpzIwLshJPqMvI5VsTe0X8RnpVQk4Dy9rDdYRBTL+GtmSsF+EnwDz7JEaWmN2lRUGEhr1H0OJ4VQ2y01V1296Dpay7cYOAHAF3xxkLl2PLNXG3SAW88AJZm/UED6aZNfkAndb39aNZ7k2/8s4BLIC9RXRhseFk37sQtePTvu8Llw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ef4d8-8c76-44f7-8596-08dc68929bab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:26.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhreFzKtS4+8sb+vTTjB/474kLgfAdiCoD8G2e6odvPvDEhPvYzri482ZxDNophmmG3UNkXlb0RnruL1O1Ypd2G2Q3l0QIWOBDFz5jf4g5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-ORIG-GUID: siLPwhy0UXmSHw_mb6aUbcT7hV_Ma-uU
X-Proofpoint-GUID: siLPwhy0UXmSHw_mb6aUbcT7hV_Ma-uU

Split range computation checks in its own function, isolating pessimitic
range set for dst_reg and failing return to a single point.

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
 kernel/bpf/verifier.c | 136 ++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fe641c8ae33..1777ab00068b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13695,6 +13695,77 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, bool alu32,
+				   bool *valid)
+{
+	s64 smin_val = reg->smin_value;
+	s64 smax_val = reg->smax_value;
+	u64 umin_val = reg->umin_value;
+	u64 umax_val = reg->umax_value;
+	s32 s32_min_val = reg->s32_min_value;
+	s32 s32_max_val = reg->s32_max_value;
+	u32 u32_min_val = reg->u32_min_value;
+	u32 u32_max_val = reg->u32_max_value;
+	bool is_const = alu32 ? tnum_subreg_is_const(reg->var_off) :
+				tnum_is_const(reg->var_off);
+
+	if (alu32) {
+		if ((is_const &&
+		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
+		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
+			*valid = false;
+	} else {
+		if ((is_const &&
+		     (smin_val != smax_val || umin_val != umax_val)) ||
+		    smin_val > smax_val || umin_val > umax_val)
+			*valid = false;
+	}
+
+	return is_const;
+}
+
+static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
+					     const struct bpf_reg_state *src_reg)
+{
+	bool src_is_const;
+	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	bool valid_const = true;
+
+	src_is_const = is_const_reg_and_valid(src_reg, insn_bitness == 32,
+					      &valid_const);
+
+	/* Taint dst register if offset had invalid bounds
+	 * derived from e.g. dead branches.
+	 */
+	if (valid_const == false)
+		return false;
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+		return true;
+
+	/* Compute range for the following only if the src_reg is const.
+	 */
+	case BPF_XOR:
+	case BPF_OR:
+	case BPF_MUL:
+		return src_is_const;
+
+	/* Shift operators range is only computable if shift dimension operand
+	 * is a constant. Shifts greater than 31 or 63 are undefined. This
+	 * includes shifts by a negative number.
+	 */
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		return (src_is_const && src_reg->umax_value < insn_bitness);
+	default:
+		return false;
+	}
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -13705,51 +13776,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state src_reg)
 {
 	u8 opcode = BPF_OP(insn->code);
-	bool src_known;
-	s64 smin_val, smax_val;
-	u64 umin_val, umax_val;
-	s32 s32_min_val, s32_max_val;
-	u32 u32_min_val, u32_max_val;
-	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	smin_val = src_reg.smin_value;
-	smax_val = src_reg.smax_value;
-	umin_val = src_reg.umin_value;
-	umax_val = src_reg.umax_value;
-
-	s32_min_val = src_reg.s32_min_value;
-	s32_max_val = src_reg.s32_max_value;
-	u32_min_val = src_reg.u32_min_value;
-	u32_max_val = src_reg.u32_max_value;
-
-	if (alu32) {
-		src_known = tnum_subreg_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	} else {
-		src_known = tnum_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	}
-
-	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
@@ -13806,46 +13836,24 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_xor(dst_reg, &src_reg);
 		break;
 	case BPF_LSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
 		break;
 	case BPF_ARSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


