Return-Path: <bpf+bounces-40848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B220198F50A
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6771F21F0D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFF1A76D1;
	Thu,  3 Oct 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lX9O1v4V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pxjmqxrm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980819F46D;
	Thu,  3 Oct 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976378; cv=fail; b=iMo0LGx/FeokTGhXf8ZzHvTc8WBBC7BimCm7tuNMdgjcVd91PEWifqc+78djljI2eTa5QHQQGAVtDzbasX3XLYoY66M+ksbPRSmbnmDjuHefVnP24tI7u02tGGilWbGzzDul4uxrPzhBJZBc8qK7+0T1PJUCQ7qLA3QOiCBk6Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976378; c=relaxed/simple;
	bh=rlh7s5HPEQsbPmHhA48fzGvA/8TZZHlLXfaNgaTNz/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=ql8GCVPDRA0XMoqQIRBBrCHL0T85P8ueIoF4Bk/RHzEHJ6MbxYB+sqNRnGc/Y0CnGJJIFQizrC7maylhLPuNDwbaKkDmvBQ1qerzH6rAqMmANMyDZOEZHVrQ5zvpjtgPyfJmWriECD2mtgRl7GkIqOa/CVVjgB6R/t2xWwtCGHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lX9O1v4V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pxjmqxrm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493FMd4Y001023;
	Thu, 3 Oct 2024 17:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=8hIcn+nDx5OprQ
	2mbFW6Y0mw5O740ubLKMDalZkNK7w=; b=lX9O1v4V9beHbXg4WUmjgXyPO1IAM8
	CBBSZTzTu99Sa4zSGfopDwEgJsSpaSfVHCj+G6yMEWnL0eJRHMkQ5Q0KQ4u1QGRN
	v2+L+nrw4qM8G7tJEDTD9yLbLS3y+sTyN3F+WcZXpzX3NWJaYrGW/rL00mxInE1O
	JwipbfqRiM1DWOGpAH44Ndx2IBHQHj7zgQiea3ahjJCKlTjGKiC1Mef0cS6Mnd4M
	7ZMToh90rPa7N8vQYDG6lag5jALKjUSaMZNkYudaLHWD7qUiQss9fgLKOY7cBl9X
	25tJ5/gIbLQSehF2s+RCSFHYFWxSuhfkt8AOmlEwXxEh0ZlS3GV2LiEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbcqnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:26:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493G2SPE017460;
	Thu, 3 Oct 2024 17:26:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88afh5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkoZ9K2M2FSzjI7xuJAMzxn43eApgAulgOMtJD0slP2V1eIwwayNSRGUaqaIeNWLznVlWTnZ244o/v58OByol82m5X0bpdKnjozGTMh+6+mkPq+Zya/sKVnN67TgfeAU8hRDD5RFfeEHB14D868G8/kSVNmWLJxqI/rg/rdIpBUSMFdDCUVvQzjvDVsotQDRU/HN2C4XlEKSw5leMlVM0YKIMWs871JYyUGiCzhpVXiI2n+P5m6Y2PRo3iWR5vCZm1AMFo7CWTOSXo2arY41L+57P3qaMtXXre5yc6bOZb1hcp+0xAgweBYYaYrnfmDqPdPE6rzmTjPfHgB6mJvRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hIcn+nDx5OprQ2mbFW6Y0mw5O740ubLKMDalZkNK7w=;
 b=ZkAUt/HvUEtSPxWXVd8JZn9IewkSVScGtCjg9vdzgS+vatk78s5OK3Tn2DnMeD7WTjNOFppdx0xhFMajqTdbOS2tYTyRXdQBy1MYb4uTC+dtPjrkc/OtAXSb7gGRM8p9Xx18dvnmBsyupVqJpn0NGUJzT52sfvtnMqlPfmI2gtiCN39uNP60KLC4tRkLhyqHgK6+MhbL9jRV37hfHb2/B1oyMFNvRte+ZzJywbLiQ5CsVA1t6e6/IN6n4/+OWgGA/5HAZElVJlk+36fOl+kjl3iBcjfsK7TSJ4FSEFKt3sBv31Ufg98z6u4LXJRMWQevCFA2PBbW7sxQ57stXra5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hIcn+nDx5OprQ2mbFW6Y0mw5O740ubLKMDalZkNK7w=;
 b=PxjmqxrmX9gJLrWdcSy02ntdd0K/dGStzAVYcoqi3fJysYCmSQJJaoIwbWNt6DzREe0AXDhMXxCxkJa23VxFJYuw8WLSJiC/Aam1k4y4gckAzIy1NZoiNxf1UvTyG75W3JrA92V8EL4JwrI9Ji7amYcg7cz8WIUWx4Pit4/MeY8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 17:26:07 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 17:26:07 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 2/5] btf_encoder: stop indexing symbols for VARs
In-Reply-To: <00b14c22-a920-43bb-adea-98759db17d04@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-3-stephen.s.brennan@oracle.com>
 <00b14c22-a920-43bb-adea-98759db17d04@oracle.com>
Date: Thu, 03 Oct 2024 10:26:01 -0700
Message-ID: <8734ldm72u.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: c8058014-eb59-47a9-f939-08dce3d0770f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IjhP+jAHxoCFW81GSWup1PEBAaxBHm2oqunmwEueGbyYdM5leW5AQ12WFPnI?=
 =?us-ascii?Q?1vxH0KFi6fECinO3SK2YF80hhTJl5IzF1X67O2oOw7yYj0WnCyUpyTefFaQL?=
 =?us-ascii?Q?Z2TQ9ENJQtJ+usCq/3b/VWs8QbXHj//R82AqswmG+hRwCr/hvx3+a2R6jeRb?=
 =?us-ascii?Q?ob23JtQWPRFYDB/nYGRRKXbhlAiX3hL//aDNa/Bg6TKGQXPo5DPs/AjcsFGh?=
 =?us-ascii?Q?r1D10Xovi4rIwJUmw8OXXbkQlTNXLPZDcRXobZ5qa6ZKtP8CFliyR1MolU8y?=
 =?us-ascii?Q?tMOlqpK+UlqoVBzGWNGDhW7u1Ge2yWQCj4QZxP7VhdltdQ3rekBhxZE76IOZ?=
 =?us-ascii?Q?bq9WpQq+H4ovhGR6JdVFMQKuKlaQKdBQOQ8nB1I3TkDUIVtZouSB2ORx5DZm?=
 =?us-ascii?Q?aKBKkJfU9mYPUFBlgwTRf87v0a/N/biYvDfuuxL3puGDTO1U/DH8NC9icN7R?=
 =?us-ascii?Q?Gb8PJlqKpViLz8z1eQqf/iEE9ISoYdM7EwvEc2y/xhj0kZkTjZx5dtdAevZN?=
 =?us-ascii?Q?aghlUYWXoQc27ZhtgD5yIRoiDEb3oL2Ppr2SQu9y+5h5gUJCu6zwkRLErtOz?=
 =?us-ascii?Q?ru99RmrfeXqHPvHww/idwdWLkaEX+a/08gOWlOfYRuuHPrV4qdgquxjNLEZU?=
 =?us-ascii?Q?E1U8UJVZtLmQd3QWrFfp0OLrLlzXppZVzJn7DrQAXTjdd6+69Gac6jxwIXCn?=
 =?us-ascii?Q?Y6KG/w+voDQYUOjmp1gja/cpWDG7nDS+bAccx4twX5tYrC/wsReVjZrr4j8o?=
 =?us-ascii?Q?xV0JjDmX07xU2gyzI2cElnmAIsFIMeERPj7cvDqTtSVdtr4r6ewqtF8i3CBd?=
 =?us-ascii?Q?6//f8H55Rz6ERA99FfQwTLSgX8s09j6trIZdWgb8WxK8kOux26urOX0v1GJO?=
 =?us-ascii?Q?Yc34+mnNbgLeXPc5Vx4FvU1bP3/fCyFypij4z0oUIPTZjYy8fecwq27o/9ef?=
 =?us-ascii?Q?2LOUCeWE/mgv7bpt2MWh8aSQyDwVcrmom7OlKWjCfI4+FehDIvgkVvByMl6M?=
 =?us-ascii?Q?f1AZh08R1mZfi+Tw5uFamqF9HAl72i6AcaAdPlN8166i276rN46XZ2z/pOST?=
 =?us-ascii?Q?XABmmo2/DoRTybgOmuyRyfvY6cq+zSm/Vdp5DJfxhwRBJOg7xqn/PeB0hCfI?=
 =?us-ascii?Q?YsR4f8nPCC+oPOGMkqP9AuU6DucgrvRoae0M2vS6IWPdvQ53KDbSleorMGjf?=
 =?us-ascii?Q?I9694GLs9UEQAMTwjwKjwF3qoPeWTo2O4X7HQ00Ll+rp5jj79CzbF3s6x78i?=
 =?us-ascii?Q?2OAkRZW3K2SeL+nRx1GVL9Joy7ZExRf49f0GaE3EcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+GV+UFDUIjfIjfX5FjXhElT2aRgrPZBv3njpCK8OSu1lyTuGWWTdO2y10xq?=
 =?us-ascii?Q?acnr1KbMfwYY/QdKkzrhxZxeVRiNd+95+JDcY77DjEW/gM6w0EsicFtDmpCx?=
 =?us-ascii?Q?tppn4lTngQ6y2+ngcc3p3nNEnnn4k5fUfcjShW1Uk37ppSTKZsRPEFHPntla?=
 =?us-ascii?Q?TW6qgiy8hvXVA40nopbi9JC2vyCl2o0y6ZQlg1Z18iWsJEhtfMOcQkB9OCmV?=
 =?us-ascii?Q?63y0E4l+qcvwVqmJiXs049WUKoQ0vxCLBuFGIggHd/0qerbbgjqHs96rtPwO?=
 =?us-ascii?Q?y0L2x35SfaOqPOvFAWUHpkoiY5Qs42+NcvmPs3RuVRJRT+XiG1CkL9wYRBnr?=
 =?us-ascii?Q?NFXEokkNqVcNMncx4OgtDxYuFvyETe3viKIpgRx8I8A9oCMnzABP41W6IRdE?=
 =?us-ascii?Q?nw7EbeXFmBwFHj0crdOqQXaMhegx8gnP1q+uq4rOjV325l1q7CdiakWtXeu1?=
 =?us-ascii?Q?YWzpQ3I4759YAqdfHEoHOu8ij15bbkL2gDK0OwSIHqyJhF+fd2Hmrqv5a+Ze?=
 =?us-ascii?Q?pJt6DtTuzDZQiavaH+p3H1ASfqdsBtpVvHu07x7bbN5s4bdbmDAwoFA2RZCL?=
 =?us-ascii?Q?Uo9DBhkV1m5f1wGh+45j6qX2roN7o+FZJZFEnnrDcACbBd6e3nOxuZvyZNLB?=
 =?us-ascii?Q?DauY9h1yfwMmbQeuZctGcwK/jGUXRG0pWk5Z26YQowyTmD7efSMQC5j/EAHV?=
 =?us-ascii?Q?bbSckCEta3fHAT7IBnW3Hrrkc4uJ2HXiislUNyteRCU+X5urFHjmb+EE75mf?=
 =?us-ascii?Q?DlxkpddsIqJRSYo4BHlG3yU0x+UTWb3wavSJ47x7/t1T0ExiIGiaSsTxffCd?=
 =?us-ascii?Q?+TxuD1VkPrrx8iwNjpHu8Dp3Fae9pQi8tTYY2hYhKZiJNtSJqJ9iEz3DNT9m?=
 =?us-ascii?Q?yN+6xQLBLWxYr5cVLUCeiaHusNd/diI2iw1to5WeYSW+kbVRFRqfChF9ZX2Q?=
 =?us-ascii?Q?3ZsOPzdKRPVQTo0G9Pl6+Fy+i3IgC7xadG3GxdFSJWrtPao8Ur4Tcsv7bwLK?=
 =?us-ascii?Q?5pbkLrXbt7zqA4R121hO4cCOW9zkEemsLawpnk/prtZFlJjilBcZjyg/dbnk?=
 =?us-ascii?Q?trQlVFrPNGYkhy5FZOyi3xu7DXbibNTXbbALEfUwgRl90HJiuQiH4NXP57+a?=
 =?us-ascii?Q?14iUfNe96vH01rDPqbzmCESspe+aQ9J4NsPi30uv1iSUTu1UuiSYQdooqkxI?=
 =?us-ascii?Q?x2A3sNaSZeQkEqQx/HEmcWnF6xap8iBJF+NkXQRaSUWl42xVMdeVGnPm0MHB?=
 =?us-ascii?Q?sZkZNAKUdlX7Ee6bmhiskQ/X319Uc4802mddUwaAWgesMNMt7Ovuf85Ky3mC?=
 =?us-ascii?Q?ERXi3+EV8GLwfW6F9OM99OCywWWyCruglhFwz7OIIcglZT7LoLdmA2z1QWTc?=
 =?us-ascii?Q?I9b24e+cOnUi5ergiiZ9rCP+3dfHRxta5Eg684ihKb9KJzlJeB6PUwpTrj5O?=
 =?us-ascii?Q?ktpuBGoNK5oUdavXodWNLv6INHZGJutmvq77wFGB8SC4mrrjbLTK6aQ1KBrX?=
 =?us-ascii?Q?jNf74RzhcBoyApbRriagKkjVeWflwYNHdsMLYmPFE4Y2413gYAfn0vG97I3z?=
 =?us-ascii?Q?AK2hhzFxj7F2ATkGjx0FGMeTPCH/l1OATKoCwDxWf/lFXMsWQm/rid1BZObc?=
 =?us-ascii?Q?7xCB9Ad3dLvtUstqjhCPO0E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jre/+oeRzuRnzZU5JyZmT5GqoyVVG5zRG8xr5hFFosEWNkLEXrpTeVhZlgqmoL0LDLA7LJblzSEcJ3eWrk4oG0k+kFavTYAwV7xi2/G7HdgYAhtDXn9Q+NfNCuDekqj+kKtIQYt+5jNnSnLGR+RtShAwDkRccCiYNNmJvvME0P5t2xoJS7waet8v+TpIWs2pu8UdJgzpradMnU1TO0n2fCPHuXkYD0dW87Ih/sl8PpvG3z2bHmanC6Nsu9fbIwC+RmTr9FA+HBdq6fAogUgD8qrwKGKac5xk1stL52LstrqPqzdmeGWd0ZSd2VI3n0DGE3opF5HHcM0Cc76P+vIWHHP2tOaLwkBqVYSjXAooi8JJSYFbHYFAAuHhX9raDT9nwLDTBekQh8WlG4r2e6CDyVjtMgTXLYPhk9GoGivJRydRu6BwrfrEO/evoIGF2zz7KZdq1uew8JnZpcYA9MoqLiOjZfBeKuB46870md5v9DNJ8ub+oQsdlbij8y56+y3M+jn1LcMSClpVl+1CqZx4GIdNFrUoPq68VwWtFsXnojUAtdF6Zyl9FYjbsvB0keSeNx0SWHl7qcQ2MLFWYSpTxa3d7QlKGjXlDgZ0Ybr5lcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8058014-eb59-47a9-f939-08dce3d0770f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 17:26:07.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g/32IrqMFKXp+t8NBPfLd7Eum76co4jpoNghncXMwzyYFzFs03fJFu4BJMx3o83E9AGJr+6hKlh86/UE1B72sdVM7iO84vNGaTTkET4RXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_15,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030125
X-Proofpoint-GUID: 6Wdon-NVYL05IOSgjvqVRbKvnTVJNQbX
X-Proofpoint-ORIG-GUID: 6Wdon-NVYL05IOSgjvqVRbKvnTVJNQbX

Alan Maguire <alan.maguire@oracle.com> writes:
> On 03/10/2024 00:52, Stephen Brennan wrote:
>> Currently we index symbols from the percpu ELF section, and when
>> processing DWARF variables for inclusion, we check whether the variable
>> matches an existing symbol. The matched symbol is used for three
>> purposes:
>> 
>> 1. When no symbol of the same address is found, the variable is skipped.
>>    This can occur because the symbol name was an invalid BTF
>>    identifier, and so it did not get indexed. Or more commonly, it can
>>    be because the variable is not stored in the per-cpu section, and
>>    thus was not indexed.
>> 2. If the symbol offset is 0, then we compare the DWARF variable's name
>>    against the symbol name to filter out "special" DWARF variables.
>> 3. We use the symbol size in the DATASEC entry for the variable.
>> 
>> For 1, we don't need the symbol table: we can simply check the DWARF
>> variable name directly, and we can use the variable address to determine
>> the ELF section it is contained in. For 3, we also don't need the symbol
>> table: we can use the variable's size information from DWARF. Issue 2 is
>> more complicated, but thanks to the addition of the "artificial" and
>> "top_level" flags, many of the "special" DWARF variables can be directly
>> filtered out, and the few remaining problematic variables can be
>> filtered by name from a kernel-specific list of patterns.
>> 
>> This allows the symbol table index to be removed. The benefit of
>> removing this index is twofold. First, handling variable addresses is
>> simplified, since we don't need to know whether the file is ET_REL.
>> Second, this will make it easier to output variables that aren't just
>> percpu, since we won't need to index variables from all ELF sections.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> a few small things below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
>> ---
>>  btf_encoder.c | 250 +++++++++++++++++++-------------------------------
>>  1 file changed, 96 insertions(+), 154 deletions(-)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 652a945..31a418a 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -93,16 +93,11 @@ struct elf_function {
>>  	struct btf_encoder_func_state state;
>>  };
>>  
>> -struct var_info {
>> -	uint64_t    addr;
>> -	const char *name;
>> -	uint32_t    sz;
>> -};
>> -
>>  struct elf_secinfo {
>>  	uint64_t    addr;
>>  	const char *name;
>>  	uint64_t    sz;
>> +	uint32_t    type;
>>  };
>>  
>>  /*
>> @@ -125,17 +120,11 @@ struct btf_encoder {
>>  			  gen_floats,
>>  			  skip_encoding_decl_tag,
>>  			  tag_kfuncs,
>> -			  is_rel,
>>  			  gen_distilled_base;
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo *secinfo;
>>  	size_t             seccnt;
>> -	struct {
>> -		struct var_info *vars;
>> -		int		var_cnt;
>> -		int		allocated;
>> -		uint32_t	shndx;
>> -	} percpu;
>> +	size_t             percpu_shndx;
>
> nit: feels odd to specify the shndx as a size_t ; libelf uses an int as
> return value for elf_scnshndx(). Not a big deal tho.

I picked size_t because elf_getshdrnum() places its result in a size_t
variable, and technically the extended value of e_shnum (which lives in
the sh_size field of the 0th entry in the section header table) could
have a 64-bit value.

I suppose that means that uint64_t would have been most correct (what if
pahole is built on a 32-bit platform and analyzing a 64-bit ELF file?),
but I decided to match the size_t from the libelf API, and it also
matches the "seccnt" variable above.

Anyway as you pointed out, it's not necessarily a huge deal since this
will get deleted shortly.

>>  	int                encode_vars;
>>  	struct {
>>  		struct elf_function *entries;
>> @@ -2098,111 +2087,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>>  	return err;
>>  }
>>  
>> -static int percpu_var_cmp(const void *_a, const void *_b)
>> -{
>> -	const struct var_info *a = _a;
>> -	const struct var_info *b = _b;
>> -
>> -	if (a->addr == b->addr)
>> -		return 0;
>> -	return a->addr < b->addr ? -1 : 1;
>> -}
>> -
>> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
>> -{
>> -	struct var_info key = { .addr = addr };
>> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
>> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -	if (!p)
>> -		return false;
>> -
>> -	*sz = p->sz;
>> -	*name = p->name;
>> -	return true;
>> -}
>> -
>> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
>> -{
>> -	const char *sym_name;
>> -	uint64_t addr;
>> -	uint32_t size;
>> -
>> -	/* compare a symbol's shndx to determine if it's a percpu variable */
>> -	if (sym_sec_idx != encoder->percpu.shndx)
>> -		return 0;
>> -	if (elf_sym__type(sym) != STT_OBJECT)
>> -		return 0;
>> -
>> -	addr = elf_sym__value(sym);
>> -
>> -	size = elf_sym__size(sym);
>> -	if (!size)
>> -		return 0; /* ignore zero-sized symbols */
>> -
>> -	sym_name = elf_sym__name(sym, encoder->symtab);
>> -	if (!btf_name_valid(sym_name)) {
>> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
>> -				    sym_name, encoder->verbose, encoder->force);
>> -		if (encoder->force)
>> -			return 0;
>> -		return -1;
>> -	}
>> -
>> -	if (encoder->verbose)
>> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
>> -
>> -	/* Make sure addr is section-relative. For kernel modules (which are
>> -	 * ET_REL files) this is already the case. For vmlinux (which is an
>> -	 * ET_EXEC file) we need to subtract the section address.
>> -	 */
>> -	if (!encoder->is_rel)
>> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
>> -
>> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
>> -		struct var_info *new;
>> -
>> -		new = reallocarray_grow(encoder->percpu.vars,
>> -					&encoder->percpu.allocated,
>> -					sizeof(*encoder->percpu.vars));
>> -		if (!new) {
>> -			fprintf(stderr, "Failed to allocate memory for variables\n");
>> -			return -1;
>> -		}
>> -		encoder->percpu.vars = new;
>> -	}
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
>> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
>> -	encoder->percpu.var_cnt++;
>> -
>> -	return 0;
>> -}
>>  
>> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
>> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>>  {
>> -	Elf32_Word sym_sec_idx;
>> +	uint32_t sym_sec_idx;
>>  	uint32_t core_id;
>>  	GElf_Sym sym;
>>  
>> -	/* cache variables' addresses, preparing for searching in symtab. */
>> -	encoder->percpu.var_cnt = 0;
>> -
>> -	/* search within symtab for percpu variables */
>>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
>> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
>> -			return -1;
>>  		if (btf_encoder__collect_function(encoder, &sym))
>>  			return -1;
>>  	}
>>  
>> -	if (collect_percpu_vars) {
>> -		if (encoder->percpu.var_cnt)
>> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
>> -
>> -		if (encoder->verbose)
>> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
>> -	}
>> -
>>  	if (encoder->functions.cnt) {
>>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>>  		      functions_cmp);
>> @@ -2224,15 +2120,54 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>>  	return true;
>>  }
>>  
>> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
>> +{
>> +	/* Start at index 1 to ignore initial SHT_NULL section */
>> +	for (int i = 1; i < encoder->seccnt; i++)
>> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
>> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
>> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
>> +		    encoder->secinfo[i].addr <= addr &&
>> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
>> +			return i;
>
>
> nit again: for readability this would benefit from brackets after the
> for () loop. because of the number of conditions might also be no harm
> to rewrite as
>
> 	for (int i = 1; i < encoder->seccnt; i++) {
> 		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> 		if (encoder->secinfo[i].type != SHT_PROGBITS &&
> 		    encoder->secinfo[i].type != SHT_NOBITS)
> 			continue;
>
> 		if (encoder->secinfo[i].addr <= addr &&
> 		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
> 			return i;
> 	}

That's much clearer than mine! Thanks, I'll add this to my commit.

>> +	return -ENOENT;
>> +}
>> +
>> +/*
>> + * Filter out variables / symbol names with common prefixes and no useful
>> + * values. Prefixes should be added sparingly, and it should be objectively
>> + * obvious that they are not useful.
>> + */
>> +static bool filter_variable_name(const char *name)
>> +{
>> +	static const struct { char *s; size_t len; } skip[] = {
>> +		#define X(str) {str, sizeof(str) - 1}
>> +		X("__UNIQUE_ID"),
>> +		X("__tpstrtab_"),
>> +		X("__exitcall_"),
>> +		X("__func_stack_frame_non_standard_")
>> +		#undef X
>> +	};
>> +	int i;
>> +
>> +	if (*name != '_')
>> +		return false;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  {
>>  	struct cu *cu = encoder->cu;
>>  	uint32_t core_id;
>>  	struct tag *pos;
>>  	int err = -1;
>> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>>  
>> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
>> +	if (encoder->percpu_shndx == 0 || !encoder->symtab)
>>  		return 0;
>>  
>>  	if (encoder->verbose)
>> @@ -2240,59 +2175,69 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  
>>  	cu__for_each_variable(cu, core_id, pos) {
>>  		struct variable *var = tag__variable(pos);
>> -		uint32_t size, type, linkage;
>> -		const char *name, *dwarf_name;
>> +		uint32_t type, linkage;
>> +		const char *name;
>>  		struct llvm_annotation *annot;
>>  		const struct tag *tag;
>> +		size_t shndx, size;
>>  		uint64_t addr;
>>  		int id;
>>  
>> +		/* Skip incomplete (non-defining) declarations */
>>  		if (var->declaration && !var->spec)
>>  			continue;
>>  
>> -		/* percpu variables are allocated in global space */
>> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
>> +		/*
>> +		 * top_level: indicates that the variable is declared at the top
>> +		 *   level of the CU, and thus it is globally scoped.
>> +		 * artificial: indicates that the variable is a compiler-generated
>> +		 *   "fake" variable that doesn't appear in the source.
>> +		 * scope: set by pahole to indicate the type of storage the
>> +		 *   variable has. GLOBAL indicates it is stored in static
>> +		 *   memory (as opposed to a stack variable or register)
>> +		 *
>> +		 * Some variables are "top_level" but not GLOBAL:
>> +		 *   e.g. current_stack_pointer, which is a register variable,
>> +		 *   despite having global CU-declarations. We don't want that,
>> +		 *   since no code could actually find this variable.
>> +		 * Some variables are GLOBAL but not top_level:
>> +		 *   e.g. function static variables
>> +		 */
>> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>>  			continue;
>>  
>>  		/* addr has to be recorded before we follow spec */
>>  		addr = var->ip.addr;
>> -		dwarf_name = variable__name(var);
>>  
>> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
>> -		 * always contains virtual symbol addresses, so subtract
>> -		 * the section address unconditionally.
>> -		 */
>> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
>> +		/* Get the ELF section info for the variable */
>> +		shndx = get_elf_section(encoder, addr);
>> +		if (shndx != encoder->percpu_shndx)
>>  			continue;
>> -		addr -= pcpu_scn->addr;
>>  
>> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
>> -			continue; /* not a per-CPU variable */
>> +		/* Convert addr to section relative */
>> +		addr -= encoder->secinfo[shndx].addr;
>>  
>> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
>> -		 * have addr == 0, which is the same as, say, valid
>> -		 * fixed_percpu_data per-CPU variable. To distinguish between
>> -		 * them, additionally compare DWARF and ELF symbol names. If
>> -		 * DWARF doesn't provide proper name, pessimistically assume
>> -		 * bad variable.
>> -		 *
>> -		 * Examples of such special variables are:
>> -		 *
>> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
>> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
>> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
>> -		 *
>> -		 *  This is relevant only for vmlinux image, as for kernel
>> -		 *  modules per-CPU data section has non-zero offset so all
>> -		 *  per-CPU symbols have non-zero values.
>> -		 */
>> -		if (var->ip.addr == 0) {
>> -			if (!dwarf_name || strcmp(dwarf_name, name))
>> +		/* DWARF specification reference should be followed, because
>> +		 * information like the name & type may not be present on var */
>> +		if (var->spec)
>> +			var = var->spec;
>> +
>> +		name = variable__name(var);
>> +		if (!name)
>> +			continue;
>> +
>> +		/* Check for invalid BTF names */
>> +		if (!btf_name_valid(name)) {
>> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
>> +					    name, encoder->verbose, encoder->force);
>> +			if (encoder->force)
>>  				continue;
>> +			else
>> +				return -1;
>>  		}
>>  
>> -		if (var->spec)
>> -			var = var->spec;
>> +		if (filter_variable_name(name))
>> +			continue;
>>  
>>  		if (var->ip.tag.type == 0) {
>>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
>> @@ -2304,9 +2249,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		tag = cu__type(cu, var->ip.tag.type);
>> -		if (tag__size(tag, cu) == 0) {
>> +		size = tag__size(tag, cu);
>> +		if (size == 0) {
>>  			if (encoder->verbose)
>> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
>> +				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
>>  			continue;
>>  		}
>>  
>> @@ -2388,8 +2334,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out_delete;
>>  		}
>>  
>> -		encoder->is_rel = ehdr.e_type == ET_REL;
>> -
>>  		switch (ehdr.e_ident[EI_DATA]) {
>>  		case ELFDATA2LSB:
>>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
>> @@ -2430,15 +2374,16 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>>  			encoder->secinfo[shndx].name = secname;
>> +			encoder->secinfo[shndx].type = shdr.sh_type;
>>  
>>  			if (strcmp(secname, PERCPU_SECTION) == 0)
>> -				encoder->percpu.shndx = shndx;
>> +				encoder->percpu_shndx = shndx;
>>  		}
>>  
>> -		if (!encoder->percpu.shndx && encoder->verbose)
>> +		if (!encoder->percpu_shndx && encoder->verbose)
>>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>  
>> -		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
>> +		if (btf_encoder__collect_symbols(encoder))
>>  			goto out_delete;
>>  
>>  		if (encoder->verbose)
>> @@ -2480,9 +2425,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>>  	free(encoder->functions.entries);
>>  	encoder->functions.entries = NULL;
>> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
>> -	free(encoder->percpu.vars);
>> -	encoder->percpu.vars = NULL;
>>  
>>  	free(encoder);
>>  }

