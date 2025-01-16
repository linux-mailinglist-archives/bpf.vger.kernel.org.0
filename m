Return-Path: <bpf+bounces-49138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6CA146E3
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A803A240F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22F1A4F09;
	Fri, 17 Jan 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WtbAQi9Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iaftEBfk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596825A657
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072037; cv=fail; b=t2MjP17CdjCQnZT/zbUFK8kPtafAGqtcUQoDBOvnfJVpxM6vEF9mncDmi10vdBHsOvW2rnL8/kNGvsLIfq69W4r+psGihISGATHWm1sKCz+DitoYiWcMT2J3QEp98oWZ5hoXZWtmL5dfswFg0HHW+3M6n7GUXRyDQxEdMDpL2Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072037; c=relaxed/simple;
	bh=WrP3wchjey13zTa/g+OK1SB+xaFa5iWPLhcy6M0sy6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=FnJnyl4aDWjKg7qvcHXPD+EadLqq/1KHmg1dKMBHSMeQkNAI9vjAuy6h7wZORH/VAY5KI2mhl6iCZZXQ+WD9XiENu5DOXQiqYvXfYnfD8Qn48H6jAosWebcbvgKZJrrpZH9HmzEpOoUosmINH5Z4MxGDbZplMJ63Gy3mlSDPwTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WtbAQi9Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iaftEBfk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GMBmBT012105;
	Thu, 16 Jan 2025 23:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Jk5aM8i+B9Q63xeg67
	8ySlxOa4viopEVdjMsLYYUbJs=; b=WtbAQi9ZgKB0pMCMi4RXLLn8IxKeEOfiiv
	bjBKM1w45KBIHWNFueg6pUwwg+K8kl8X/ZeO8EV3bkmMYWplCs+Pfb1QAvnN6haM
	IUqJpO7XYJH1sYzW+HwRiUXObo2PXDURJcdGAvIAZ8FxfhXzEi9Q/ogUxzXuXRZj
	qBVEBy3B8m6YVU2rTMuBH8AWN481OrpBXzqsb5BiEen973S2Xl8wuhmGD3ZZ88Ax
	2gU9nmDmTL1ZG0je4X+2z42oMQTG4dL/P9EHZLEKGk48CBlvQDWqmzfHs8ttsCVn
	dhoM6l8wlGxNzghS4+y57Vc4yqv5fQEvMkAGsMxZ1pWJUn7TMKaQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfgvqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 23:59:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GM7pAS005154;
	Thu, 16 Jan 2025 23:59:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4473e5p8hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 23:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfO7tPIhKKu2OcQeXBBiN0H/QL1cO+VUo4saR/8A141x13k0PfP+f7Yup4PqRJfqvDPCOFt0bZLdMgHpzTD9aj3fq9dW7qDX4eeq66GYK02d3O6H+HgxLlNZo4zyCWg+gvC1lSGHlYHQcGVOJv5PbNyHZD3uN9Q4I5JukYwp3PH/V8G1Nc9xdrNfll329byFNk0tqQlFpGNGp8SOLy4s5Lw153vlHAr4hvgCQVmm+GuExUtviigZaH/+c0770ksxhMxch1LyczQ6eLBFhooJU5owYtIVqpMbwooOPweK59jhXhiVw9Y9oOsR2HEOelSohJmx5IDg34dGklknqAyhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk5aM8i+B9Q63xeg678ySlxOa4viopEVdjMsLYYUbJs=;
 b=EbC95dPr0rXMuvCPnZ1+cC+2ckX2XyuLkFcysMKkwF9Con4Pb34obWhHCsL4QbxASIrjw4IEKSD2ta6PR69f/db5nykiXPpzY8CXb52FI0+LReWHVSGejAbnSAFnh6gYhNcDDVfvefPRgo8HKtVQRcznsMiUkAcNWvUZqigedjqB2YUQJYQrVqDqtwbwi047IGmD6e+pM+pqIkJ8yJpR5nvGRu+88MQO3BnHVgC8RaoR7v9VRnu9KKHvNkcPCHG1QcrkUQ/TL+XOpI+Z3wqViQGaHN+VzAaogY87qHrwRPbkF1Wjc3GjTGUwDECM5F+Q5uwVNHJxyl8d76eZgbDwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk5aM8i+B9Q63xeg678ySlxOa4viopEVdjMsLYYUbJs=;
 b=iaftEBfk+D8ZoxYzOxZs7j7GzKY1yLf87OD4FcEQglgtH+pW3BGqhbSc8pJKAa6gNWtb/0Dslf1TqElPiTOjaYbGpTTASqFKDw52pgLi8/0dnBZ8aEEqeFUX68VNr/sXVBaUSMHD7CHBx2TxCQjJKCk2KoVPVPztQ6dOFgohXV8=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by SA6PR10MB8063.namprd10.prod.outlook.com (2603:10b6:806:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 23:59:11 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 23:59:11 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle
 <chantra@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        Andrew Pinski <pinskia@gmail.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
In-Reply-To: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
	(Ihor Solodrai's message of "Thu, 16 Jan 2025 20:44:54 +0000")
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
Date: Fri, 17 Jan 2025 00:59:08 +0100
Message-ID: <877c6uqpir.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|SA6PR10MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d322ea-6dfd-4b27-0fcb-08dd3689c5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X9CLNWKa8EJay8xAiAN8l7tR2Hca04pIgda8AN1vRBlrkm6At6X86faCda4K?=
 =?us-ascii?Q?ntLrvYqBU/mhr5ZkIgGCKADnDTZgcXQYyWMtMUpaffHpdp/kC9DPMcSpLxVw?=
 =?us-ascii?Q?tXvGjhXVtVhAjLlXaClDuRQzLi1bYOscAArpAfyUwdjJlBelybJipaSvhvk3?=
 =?us-ascii?Q?XJuLFKAhTuUlNHRfrz2rp5J7LCZt+U8LbmG7i2BDW/u++nqp6lUNeGDViltc?=
 =?us-ascii?Q?/FVA8HGp1v1mfwnORjBL7daRYfPLfTAhfV/LthHZnlwoFMcJ143Mah/+KaKp?=
 =?us-ascii?Q?/3aysQyFZSRr6bz82l7cqWyD4DrFT6xCSE/SIRtRtHrIEQlDpQfWhizoyRog?=
 =?us-ascii?Q?f+6oOsaPn+UmD5WYvdHfExuXVFGVl2XSYfV/Yy4L7Mj/X2yDOFLkWpxpSsXa?=
 =?us-ascii?Q?Et1EWLYeqb9R+NmNmOBH8KUn7fAqqj0OgD+I+04ZxcOcHL5Y2WwggoI1MKSD?=
 =?us-ascii?Q?hPaej070kTdFPRbtD+IcdIdnsQcj26z1gIJxPE0X3pc7wH8n/6jVlnK8zhM6?=
 =?us-ascii?Q?6ueE5Cgsfju3lH5vFgwaXqj35r36BnBiXFKJcAYtwfbjTPRw4aTddjMS9b8m?=
 =?us-ascii?Q?cn018g2des+YuvdyE9cJ9R4+yfDf7OpZIiu0lyRf+mnSxhbhXMmQm2/uJVeA?=
 =?us-ascii?Q?veG+bijlTngSn2DpPtN+rqUj87BKj2GqGhe8GWVjpAl4KLGLHxByq9dz0Cbt?=
 =?us-ascii?Q?J1iCPGht9ycK0rdDxlkKvWrh39cnC3XxgrxVa2kkErsWaFoA998ntCdK8N8N?=
 =?us-ascii?Q?be8WdAPz7WZ5Z2fUw0PcFUkrAcjTo5X0T3c9T0yjpFD7ZpJxUf9KwL00R65P?=
 =?us-ascii?Q?G9sh78oPK60mvO3NFi2F5S2QPRpGnhbNEC58hOb/YLwOswH/nD8VcAsWmodb?=
 =?us-ascii?Q?MAEs6vjAK9kYlHrN3R5Ven2vA6v3/JTxi20qcNBvj+YGf/EHYNSY5ukWmdtX?=
 =?us-ascii?Q?g2iDZsO8NtV5kuk/hkwT0w3vrT0Msz2Bp69rdrxnqcynRZrz7Moif+yGGPCN?=
 =?us-ascii?Q?PHkkGZQZRqGNeerBo9jZkIfcpkuEvkITzBVPypVtElO/uQeKIVdmo6MCjM4D?=
 =?us-ascii?Q?UjLHds6wRFwmXRHD6+mnGWphkd8p6t4egE8Jkk5SWV5KcI8yZN6TXysnaMeV?=
 =?us-ascii?Q?p4+H/WrZAzD1dRp+sWhNaNNeOy8cqq/56qb5Ue3Kp+c5BjYxidfUyvwAR7if?=
 =?us-ascii?Q?NWKngUuyICInJE8t83Tv8XuEY5HNcZJKwdiweoofI82aKUt6hmtpb5SBiRaT?=
 =?us-ascii?Q?KCjbefNYuX2GSFB3j+jLgnTXMoiP1MHJOzpGGYBEzY/QNIlpQs9FXg65MEse?=
 =?us-ascii?Q?WPhYaBxzjuouOMrBVgPXaKrM27EaY30McYQIDxigtlXNjdDsxYRVvJ3araX2?=
 =?us-ascii?Q?WxsMB9xWwfCCXxrluvxn9feMLEguCeN5/kC+cw5mSEwNdOcSpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5is/ga7hbDt7+HbbO1s3az+0IQzNxOHEoSZGxKQj4VKLatbWp/7/+F6GuMKS?=
 =?us-ascii?Q?J8p8YQ1ca2dhkB5kfd8ruNmVZbGd+xs3tUffT/s9Fm/nBODNm04b+lukE9MI?=
 =?us-ascii?Q?G3sqBaModqAoYn038UkS/Sjaxpjp4YSc0Dcf6pB1NQMp9DuVkjRS2ZOxPV5Z?=
 =?us-ascii?Q?mKSFtqty/huFfMFMCyB+yN+cnrhW1Je5dUGCO/RdUf8vk11VfNNPcWUTE4v5?=
 =?us-ascii?Q?QCGdVX5Wly/TrOcmAMz6qX2ng8X6a7pn/gujTe0QyTQ3FQdDBtl9XrTYAYwM?=
 =?us-ascii?Q?e5w2qHhsQQIameb2xrrSQ1mCXdu3zv8cMHAu6rM0fqOvFd2x+TD4b0hpCeji?=
 =?us-ascii?Q?18oxooNw36NJqLcWcqaFvraPfPg3CRV/Cu7k0jh3ilmrD3htZgxYCeQRmkWc?=
 =?us-ascii?Q?/X5AjIDEMFtO6VQrzKt5/LNeuTnEx6ol00E8yrHPy2a84m78Rmqkp5XjImdh?=
 =?us-ascii?Q?KcHHk41zCIQPA1I8Ha3ZWfb3Q4UzaH/FqgkX2I+nX9bknjhUoarh1UQSR0kW?=
 =?us-ascii?Q?y2GSgr4cBSeL1fo/wX8H9PGNGB+v5wvsTfTSbWBRNOVBSw/iVWH23G9xbDAe?=
 =?us-ascii?Q?IWPN6Q9vRj+Wv+M1c9tERktb9twCOb3CMIUMOPOlR/cqr+mSPsDi9HN3C0sl?=
 =?us-ascii?Q?cRZC2jGKj+Gz83kuLkLleX8u8ZnUUydM43KGXZ2dehN4UejKlgnOUetd1qAp?=
 =?us-ascii?Q?zkaiDBCTs26H7RuYMvUjl7YaMHZ7GG/LC26zXHcaHQ1+k8OvGGqmEPTq/GlN?=
 =?us-ascii?Q?ZY9kC+HOA8nfD4mnXQy+w1xRmOW7tEKRUxVviMEhCVU6dDPK9ppMerHN+Hl1?=
 =?us-ascii?Q?PhoZwqbFCu7W1cbns4OM++uFEP0bBKGOdf43qT3v5+fuEipfkOU/morP0KnT?=
 =?us-ascii?Q?U13t2Vi+NYG4WrdmFHMKTzBFFOY0e2S4Qne2zxdkExuuBLO+/we9+qPFCENU?=
 =?us-ascii?Q?p3/W+jrL10U2GRZJoJBYKMFVLoGS/nJdilr9DQZSbsyBW0k62i0UKfRn49x6?=
 =?us-ascii?Q?d6y6UIEMiMRCPSHpgvWhhriVIWcMvxDqhuZsG7ln37VKoV4Wyeda4kesvaZS?=
 =?us-ascii?Q?XR/irm8B4/dz+P59XRoOFIEUZmn3sCljp5YEiF7KMohXJWBGPNNV2mi0ZSeQ?=
 =?us-ascii?Q?FuXzR92ATpJW06W80pGBHS/CFOYPDbsHEINfjRX+01WIUffUzKcTlLvHt8JF?=
 =?us-ascii?Q?vo6JOYr47BAWt6jbVmdjxiQaXNrDVmgFRawax2E9IgteNCB3EUA5Dwh1x7Ks?=
 =?us-ascii?Q?izTw8++X4apI5eeP1mdsK2GVF2sDNA7GjCoYk+HmEIh0bhCDciAbJuchnibI?=
 =?us-ascii?Q?q2e8DXd69sD/hCHisAzmERL8XpSZLFA1aG8ESvs5gNM69o8i6tSeqd+bO7wN?=
 =?us-ascii?Q?/z4MzgXtzx5JGyWH+lfznj2cnp9Dpyq7g99vmXq0mrEZg69GQx/2kLMVSmdZ?=
 =?us-ascii?Q?QI1Ph1rQ6iRgF4MHCSMrfU5naTqhe24cCBR3EEDOvNU0h64GOCEznc/C2ico?=
 =?us-ascii?Q?//l6JK8pYYtSg3Es4V0j1S3skXqdHRHwBDgFW/Pmo5ZxFjexVa1f4alKNLiG?=
 =?us-ascii?Q?LUbME5IGJtqbeqhVAa9OR2UOcrM6748SQSBs6vuxtziUiRXCrge0qlU1NMvJ?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R+8MzZ53midtRbw/H7QFrbPIYBszAWD05LkeYZl0wKR6X7yqgCa4vOgHvstEnqjofagB9CsWUUaZvZjRv96Rf3yJ0uR/6u7Y2QPJZ7YEuF7u6I6SRsokFuSGRJfEWt1immwQ4BzXal1di48XWGsxtmRMtDouMblTs+Jimarh2iUi/r6ma5+Md9kw4YvvHx9LB7Mqi5ne3tgammxnwsoIavXaHWIdg/vBSXYr0/iYBcQUs2xmb6K5miG9FxdtX7IoEsvgO7goxwF06f7QtigS+G22nnDVFupPW7diVGvUmSfoT1TqIVoRv0c3KIRQpflB72n5QtUqmNr/vL8K5daSShzPQDnXVedfcp/s/yX024ZHjLoF0MuwioDUmpVOMjZ44CyDRoHXLUrfPXyPqjAL+iXuvDvU755HoO9W/mEL3jYW5msFm3KaLLSbsz2g/RTOYzKSn3VpJM3qhk3CooHkiPBPAkNXzENfxImX1U1E+smvSR3/WWOXNSFuklPTZtkb7o7AKMmqMZDDS8IRz2hKdg5OpUxmAM9GdASF3MRtb8rGp3IdxNbt6MZELQ3kpNG5X19N5hy7/BFMjviZxT+X+ac3wM9V4XBTgTT+iQv/vMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d322ea-6dfd-4b27-0fcb-08dd3689c5d9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 23:59:11.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axVRnda1u8nE5eMv2UDbxSADNRrHtMOdxq8A/h3S7C+0QCdEwtqlHpv3L2lWcr/7/hMkZh2BHcSwJywPmXMqgJfFEByuO6tooh/dqRLUvLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160178
X-Proofpoint-GUID: x2QaKyX1LT56W8OUnAs9jFpZ5_fjsaa1
X-Proofpoint-ORIG-GUID: x2QaKyX1LT56W8OUnAs9jFpZ5_fjsaa1


Thank you for getting this up and running!

> Hi everyone.
>
> GCC BPF support in BPF CI has been landed.
>
> The BPF CI dashboard is here:
> https://github.com/kernel-patches/bpf/actions/workflows/test.yml
>
> A summary of what happens on CI (relevant to GCC BPF):
>   * Linux Kernel is built on a target source revision
>   * Latest snapshots of GCC 15 and binutils are downloaded
>     * GCC BPF compiler is built and cached
>   * selftests/bpf test runners are built with BPF_GCC variable set
>     * BPF_GCC triggers a build of test_progs-bpf_gcc runner
>     * The runner contains BPF binaries produced by GCC BPF
>   * In a separate job, test_progs-bpf_gcc is executed within qemu
>     against the target kernel
>
> GCC BPF is only tested on x86_64.
>
> On x86_64 we test the following toolchains for building the kernel and
> test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.
>
> An example of successful test run (you have to login to github to see
> the logs):
> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/35736973856
>
> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.
>
> Effective BPF selftests denylist for GCC BPF is located here:
> https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>
> When a patch is submitted to BPF, normally a corresponding PR for
> kernel-patches/bpf github repo is automatically created to trigger a
> BPF CI run for this change. PRs opened manually will do that too, and
> this can be used to test patches before submission.
>
> Since the CI automatically pulls latest GCC snapshot, a change in GCC
> can potentially cause CI failures unrelated to Linux changes being
> tested. This is not the only dependency like that, of course.
>
> In such situations, a change is usually made in CI code to mitigate
> the failure in order to unblock the pipeline for patches. If that
> happens with GCC, someone (most likely me) will have to reach out to
> GCC team. I guess gcc@gcc.gnu.org would be the default point of
> contact, but if there are specific people who should be notified
> please let me know.

