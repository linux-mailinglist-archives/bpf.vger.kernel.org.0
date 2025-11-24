Return-Path: <bpf+bounces-75380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05156C81FF8
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8053634935D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528F299A84;
	Mon, 24 Nov 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BupqdjxI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qYRGfeAx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287F217722
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007251; cv=fail; b=FbOtAihGNGuwbZTkCx6Hy0gCt1vrb/r8TTAgvzmchkTMNRFvxKM9eldG3lg2V42FSxKxVYvW/v7tcTYNn7hFYxh1hKbnpMs7BF8sWZx5/2K2L/DHeu47fd2fvVIGOiV/1z6ndSq2zMstckWSboUtRqPVnridFpnf6dYrP1kG+YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007251; c=relaxed/simple;
	bh=1wxQLhPel5Qv59Bpe/G2EqE/I9rmbtOerb/wcKZB7Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKyltQYfgc1y+a7dyZMYxh4ZO7OwE6sKuKla/9w7wQ/oQLDC1Jwf1bCaJedjhqDpvRW+8zJcrEUpXDVMnSdxCdtY1uaafNOSVaCjGAUnTAKDD3NY1GPxZrtuMBDuyxikxlbEoNUjT0UJ8nNJOvZSkvVwTK8Scjg7CWhwe2KRmaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BupqdjxI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qYRGfeAx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVI7T1038446;
	Mon, 24 Nov 2025 18:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=; b=
	BupqdjxIqNKFgY3hzZUkUsCWsD9aBWbswjexhfO6FmHxaWjnV9s6ESuq/pTk4wH2
	7SZZtUqpvptFwrfSUl28phWzWVuz7p/nMnBeznrCkp1tOwkA+H7vvY13Ap98PeEN
	8cVoadMUVzF63PRLjeJBcvRrwuGDKplmeyQ6LHi+7FjzUJYGjkuXovrIxV/HG4yL
	mu0XQY/GjdtP058/Cq6y7ro04/0HOx5+huhKowYAj21/8i/6HRn/MOLXtB88y3i3
	gl5dX8C+UsyYFTBF7B+ve0R5TEiB/nZ4b/jIJvMn2Kt7CuNeJHs0EzDbxLKcJFYs
	AJHwR2LQkq/8+XK/eaM8kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkajeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOG3vKQ018887;
	Mon, 24 Nov 2025 18:00:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8dwnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGQusBW+KwryGEdYPIEFvgSDkpowavXiUmX423EU41sYS5FeDn6gxKETojd0nDoItTfcpfE+1kNztQeOWzJe+LacmJhzRnKGneMHbRLzOspwJSgvqTV3Ir9fQsjeU3dRqjirjtDggV/7n3AZJ6CWebEAsagtcH4zbWL1EsInGpGnT4WXtodqaD5ymEdPOqHDeqh7jhCjqb/fGWKEeX/xVER41fCNQL10ToiTDm7R9FdM+ZoZ0BCN1d7AGiotn7ARCGbFC0EWbL3SfE0c1PAvB+2qNDwrm8nLk+wk98yyhPtSpvuK9VzRAd2NMkLpqQuoWB+E/Jx3vBQ7ugnUa3M5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=;
 b=BmqqbUac7I3RrbjqFd5vSRsZtMEpytTyd2X3+eUPy0Z+lY57HhwXBCNncm8jtHWCsqJvDC1E11Tdwn75DqDABkWp57uJnlCK6ByQRhGvt8CI3EykIBQQUuQ2zvJNRwqPuDYKhLsisCWv8JQ0SuUbPWp+5+etVxKt5IPEjfy2IVjgg/kHUNkpVujYlWsHVFij3+ugVZnanhP43sHY/aMPPM7lHwTYCAAAMnhiFbbna8r9f76OYZno3KgaQkCXmN09s4wgVtKasVwntOqNXVkwDRf9tF/Gdl9ibgQdqWzc2RThfy1sdcaejmPE6BpvbtQ6GBrI59vKtEfs0Vf4Eq7MLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRg6jjoFwl4UtbFdZ5oGH6oApklBLdKIkNIPuZ7ItiU=;
 b=qYRGfeAxOzUPR2oxZdaebDg8G6mQmWaH1p/whG1nfvpPup6mIQpVyBDvb+lEGZJNsPigJG382YVMLfc/l99Zz65E2fWG1xPhxE9L7ife6SwEIPcqPav9CTnD3G7zFdFiNavt/676AzmOnbOLh3JaDFcW2ri7nuBemPHrwKAAGQQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:00:41 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:00:41 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v2 1/2] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Mon, 24 Nov 2025 18:00:12 +0000
Message-Id: <20251124180013.61625-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251124180013.61625-1-cupertino.miranda@oracle.com>
References: <20251124180013.61625-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0002.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::7) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c740eba-279e-4cff-aa0b-08de2b835f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5gPsohID/KkbmWCtk1nrFGYSVLE0SyYSrLXytRdTETNH+TlLsZ2leZDb/kY?=
 =?us-ascii?Q?mZEKAGXn83Pfs+WcxyYLfPO1goWZ3XwmsB7nfWD1F4gpkloVFTghQ0Z83toD?=
 =?us-ascii?Q?isQw1BP2uczzb+PB2sPLr7UA9LuVnisjdpvlTnkSaX/g/Mo0HAYLn4f+2S7g?=
 =?us-ascii?Q?XD9AqmqveRV5iAnnGwWsOt7bVq/gAFRp9P7qa4mXSpKhaPQff5WfsCgbY0NJ?=
 =?us-ascii?Q?14OVvznMPU9s7axaQAVNnmU4MB9jNt8GaknnX8w+6aVE4CEnKVKhTcJZMFCI?=
 =?us-ascii?Q?u+fJeWFMge5d9EeZQEtRBRxH4wzOI1NhcvbSX9pGyfXi+fzu6LWk8efbcTLi?=
 =?us-ascii?Q?k42EXV3YXWM8Yn2N0Qoec6z8/LkxJzKfRtkUCd3fvGr1eago1ItH8jnZsPZk?=
 =?us-ascii?Q?tIKipliH72J1vpJWxZV/dxjHxH4H/F+w/gZ+mEyM+6NCbf+FUEmWKp11+Nxt?=
 =?us-ascii?Q?K7DG7OgJA+Q594fGqQAIsI0fgMa9xbg6N8oCgjWS7okHYisbJWzLtI48v75v?=
 =?us-ascii?Q?LGWYAgohrKLpGSLW1jbtad8GCkdQwQ4ZT69bkCxftnJX/6lWGcWbiQ8+41Q5?=
 =?us-ascii?Q?kwepxV3gpuSvOgTeN/W4MTGeTj4qac9NoIF8RLhyz4xnRpBn1TuuPBp48rEc?=
 =?us-ascii?Q?c9gx1p3jlHiMlyimpITVR/7dUreh1BBfJiMz3CdaGK2KClGB1PcMakI0/NUw?=
 =?us-ascii?Q?itkVvs43NB+HWRDrkFj22PfbSCJ0PfkueIM/ljpt/84+TpDaioSBOqanXz0Z?=
 =?us-ascii?Q?Q/RW/KyVA1xiKQw/PbAu5sFtI6jjEjoqklDTwiTRxFAdaJww62jItuMPAYq5?=
 =?us-ascii?Q?Gx/c03be+mFsBw2f4vQkq3103IrmVm08+ulQjcMF4wdf8pca00dEslmwbqRR?=
 =?us-ascii?Q?1hek9f2y1DHYv/3AgcYvKPwU4JzYHDpJyDUmpvKsHBda6Efn/fXbQmHZENdg?=
 =?us-ascii?Q?cxUWiTH8JaZ+ChIqH/+XaC6Z9XsMjvMYh2ltPzywhJJpiuaEjC14Sv1cxpKs?=
 =?us-ascii?Q?PK+LX75nqXkewjjzqQ9lnApu9rnO5hvPCOCnN2s00dXySMDfTHoNF6LFD8JO?=
 =?us-ascii?Q?le91ab+f1aALTGTINU/ax3MslECjU59ab+DxRhNFkdtILS2J3UkLcr3SBA4c?=
 =?us-ascii?Q?eOOf2xiq2keX5FkVkd+Hawd7ile7meKegJ8kqnMl9rau02q9UthjaZdYQ1q5?=
 =?us-ascii?Q?xrWEDy7Ml4vl+RQ0Gylw3wOzTlxbIDyjq8kvHkPmu02LM5U5w56qn2bySeWE?=
 =?us-ascii?Q?csbrEn1FwtgvCAWPBZUmmIhyiakR90GZ2+za/rD2QXR2wZaYnAIHgrXmUccn?=
 =?us-ascii?Q?87fRRoLctjrO5CuEpMoKW1FM4VM3139c40Xx0/F6hcaWKOMnrBzRVhjlBgvi?=
 =?us-ascii?Q?Wc+MgWhCoc8uE3wHl3L5KpMqVw7tc7EhVHIY+ogH5FIoG1gmu1b1wsOBmgqY?=
 =?us-ascii?Q?qKuY9JZiepDA4aPA/3MtTvU3Yt3f9QKhJ4scCoOYwyrP2lGj//h0rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvxQXDrThBY2pc1MefK4Cd8zYlSyUe+G+AVWFnlHlm8n5M9+nqHhkHiYO+fN?=
 =?us-ascii?Q?6JBuxgqmJHubcCNdPSt7weRrYAiNUtcyvPEblTZrmi9Jaxx7meLRS6/QHrml?=
 =?us-ascii?Q?zQ5xMsUfPTNDiZIbdHR363xk8/OZn3FucH3e5xZunWOgWNMO70Pa34ZAvYyY?=
 =?us-ascii?Q?RIttJ1etJytfKFuU6817Ix5mxcjJDQcdeVKxhdXR/EXDLaJ4oLjaFL8bMY4f?=
 =?us-ascii?Q?fGu3S9LBBeBUb3j12urfD4qHAFuvdNF+8O/rbcYAcYvJe2ZGit2lgQ5Qg/dn?=
 =?us-ascii?Q?LvtJ5LI1NLSje3XQBQcSc5Ag8RayPFp3ydnXTdxI1Zn7pdDz0ys1YPgq5+wC?=
 =?us-ascii?Q?AT/56fWA2xElK84LPUI0Of/BOyvm5QIB6ZpA1d3CbRfjmULKOti6irLOVKEL?=
 =?us-ascii?Q?VLhXjNLWg33X67yYoa7Nfgi+kn1Phquzmw/wEH82OA9lR5dx2m/HFeK2EKeo?=
 =?us-ascii?Q?vAgOiQ9YU4/lLgSxlM7h7Xtt+v0Hi2ddGYbg5UqC4c+bd8koQAFJagTyOnXO?=
 =?us-ascii?Q?HY7+gDQSlNyqy+HJimToLUGufgVzdVkYSW4aJ9VS9s3h5PT++0h074GRaIoB?=
 =?us-ascii?Q?0zXyZX5KQoRNojPaswtO5K3QCefv+BV8qQLcLTI/s/qeJd1eEC8mvDkvflTX?=
 =?us-ascii?Q?fmLDlS/bUF5u3JYvy9sdvcYViJ0RgSonRKWi1QbiDwYlW8UCZm8ve9MmH19P?=
 =?us-ascii?Q?hVkYZmgZFO9wN5PAeVBkH11ExHw6+SX3LccbgsB+ql+dK/Sab90Ngjugkwce?=
 =?us-ascii?Q?uhs/rLUGs8lxaFOlJzl5N7LAMM/0e7pZX/3ZP+I81OW5qfyP7TL49xFA3zBX?=
 =?us-ascii?Q?FkOR8DhwHRC8o/a98f3tSlIoZRShbGl7sK+LObLlv/7pe9CIa4naGRXmxD47?=
 =?us-ascii?Q?j9FamZsZ5Bje+b1rZzpUVLTMmT+qZ97+GFnPbnIPLIgpcRW+a8jKwbTaPt32?=
 =?us-ascii?Q?Eb8vZhUp2LXXGLFoa7tWj7avboTr+fyLSFPUgOiEZ1+vS/lLINiVd4HjB84J?=
 =?us-ascii?Q?Nasulq5aWTL51Fmez/4nk7G3naanYRtNAtx6e7w2o8pf22AFj3yx+72a9Rui?=
 =?us-ascii?Q?TBlPwCTYZjnsVGRrJAUi5P5FIJw5m0a8unMJNUBp1WEA6ANOHk8FSfE4Vjih?=
 =?us-ascii?Q?gVJHawRjmLy3N/qQjwoMpOl5YdcFEvir87ZtJ7Z37BkYzjjzvrLprj7paq9+?=
 =?us-ascii?Q?eG4qjI1Vak2/vsi9vxLVc5Xmb7qrVzg5l9yTAte0Fve1csUzDHWaa0wuKQD9?=
 =?us-ascii?Q?Xpc89WnzOimQyLyJMXPGQ/C1lF8a+ZauLhj+aFukMoFPvmdqPATJoI/DpFNH?=
 =?us-ascii?Q?llouyr9KK4VJf8cvtaxMpFYzErZqyaqzj9ig5xOf/4Vl7k3ZGbg3CiIRDMhF?=
 =?us-ascii?Q?rvdFpW9xA5dj6a88oAusMkHiKQb/QRpIYAt5RbsBG4sq1voD9npKDVCHlApc?=
 =?us-ascii?Q?srebf2G2HQ9fWRla61pGAi1wc4B3byjXyI2rqMASgpSjdOJyOCIipWwo9fjo?=
 =?us-ascii?Q?hHhMXF+wd5KnVUkS4QQsdmJxTRe08scj/LUk1bFXnUP6hN83osQeZfbHTqOg?=
 =?us-ascii?Q?jNvpbMvi5ESQOoorQQS3qXt4C4RMxgjF5uW9KwrSiDvxWdxH9dY1yYZyA+0K?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NzVD37c12hRCOsRCJOtT+rPpL9lbS34X276kJ+pZ1P9z5PtmOPDJzLFhuudsHmK+5AxlutY6gP3rsmD0kwcnK682XV8qV06H7LCnyzF6YVa2RYkIamV/elAMfMCrXc4/cZHbKuNgsDhyOE5phvBOxi9fcy/Snj+3+SxqKamyYe+SLRsidGdNwKc7s+D62GolWyta4DGFezjrOglLcLMY5V1q0tQ42cM+s/QVqFAWQvAmf0ib1br6bajF1mQGppJUGes49PvR9lenJvV7O4dfD3+UpoGt1vjSstvPW7UKsWh6PXDaRFMk47s3NfqqkQ0dn5+FdhiLMIVo7uCb7lu2lftWIUGfkZ6lQYwpWHxYIm33eXtFFVlKl4Liu6phq25VePW7VZpnj9O2+v8A6Ku8RLDASKYINAKm+yj6d2/5EbqAp01E+1xdBJ7sVVFhK036q53vIjgMYvmZCreDbLUC5bYPZOybiXvfWAikzaOhIP4cuVVSB8P5C9ytC7ZEzKaEiD4sfBUQok6QeDLeMrIpzfFNP/GnajoznJ70NZkhz5rRz0MoFbLpxizeOW+2KLh1tZ7sqGtlFqyuNr5kdQQ8YNZSyHgV9mVK5iFAb+3wg1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c740eba-279e-4cff-aa0b-08de2b835f16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:00:41.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJyyt1zei0nmmKbvexXTY4YwKJvzadKKBUmeGXW1eqdngVPKaOLMjRXfWjjmiMCZWP2QyhGz127wzLM5ELDQcRsbM9BwwRveHuTXTH0H7nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_07,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511240156
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=69249d4d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=yPCof4ZbAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=zLsXoKLw0gD4jKH3iaAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1OCBTYWx0ZWRfX1qm1A3sZeFS+
 QDbOf6fEoZvN6vpQ9YjU7DdYNjkg44PyySd0qdjV2hntSeL0Mv+3OyuW45xVFRa3mfLy14KX/GF
 sI/luWh05p4rkDFbpW3ziRpDBPkdMmIsE/OoREIIjczn3TuehwXXuLlS2IIyyvkc9teiqN/oWj+
 kOduG5Zq3pkTBiqOQyWGqHQc143YU9R21yddNglO2bXugmMVPBrRMfRjUygqrxbgvBGDI69vu/o
 sQj82lRoJ7fM5JsXZ69SN7TbUObJKMBNG++RkCnMvOVHHyYABbKTviEZgqSn4CD1G0OtH/jtLUS
 Y1pepBts9Bbk/8U3DasOMklxFCUXZpwwk2ykAA4wHWvLjynFeknZsWymDD7L+iQ/vMJBes3XVQ9
 cg55npxmnbeAPUJewyO7mlY5HJ9nQg==
X-Proofpoint-ORIG-GUID: g_Ne396iTwTJ2Ot7_yvaWyhRdsk796HT
X-Proofpoint-GUID: g_Ne396iTwTJ2Ot7_yvaWyhRdsk796HT

This patch improves the verifier to correctly compute bounds for
sign extension compiler pattern composed of left shift by 32bits
followed by a sign right shift by 32bits.  Pattern in the verifier was
limitted to positive value bounds and would reset bound computation for
negative values.  New code allows both positive and negative values for
sign extension without compromising bound computation and verifier to
pass.

This change is required by GCC which generate such pattern, and was
detected in the context of systemd, as described in the following GCC
bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119731

Three new tests were added in verifier_subreg.c.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..a1be9d92adca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15272,21 +15272,17 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 				   u64 umin_val, u64 umax_val)
 {
 	/* Special case <<32 because it is a common compiler pattern to sign
-	 * extend subreg by doing <<32 s>>32. In this case if 32bit bounds are
-	 * positive we know this shift will also be positive so we can track
-	 * bounds correctly. Otherwise we lose all sign bit information except
-	 * what we can pick up from var_off. Perhaps we can generalize this
-	 * later to shifts of any length.
+	 * extend subreg by doing <<32 s>>32. smin/smax assignments are correct
+	 * because s32 bounds don't flip sign when shifting to the left by
+	 * 32bits.
 	 */
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_max_value >= 0)
+	if (umin_val == 32 && umax_val == 32) {
 		dst_reg->smax_value = (s64)dst_reg->s32_max_value << 32;
-	else
-		dst_reg->smax_value = S64_MAX;
-
-	if (umin_val == 32 && umax_val == 32 && dst_reg->s32_min_value >= 0)
 		dst_reg->smin_value = (s64)dst_reg->s32_min_value << 32;
-	else
+	} else {
+		dst_reg->smax_value = S64_MAX;
 		dst_reg->smin_value = S64_MIN;
+	}
 
 	/* If we might shift our top bit out, then we know nothing */
 	if (dst_reg->umax_value > 1ULL << (63 - umax_val)) {
-- 
2.39.5


