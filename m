Return-Path: <bpf+bounces-28171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B28B6486
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DC228936B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325B1836E4;
	Mon, 29 Apr 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L1Yfk4Pg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IZMgFKDf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A51836DD
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425835; cv=fail; b=uDyEWQnCPCOPbYpVASW5e2iRt5oDHBlIXWDZfNmFd4erwbNz4VYK/D9TaozqDsh3YV2oH1RlPSfNBV3CocPD5peG/xzKC9HDvtDKNBguMJqvS0A88PKXQVstmnKmn25okXMALQRq4O0QBXA1Kq9Ya9i0gv5RkpMILtXT/cs+EJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425835; c=relaxed/simple;
	bh=i1WEvAk5/l0Sx2OouKxQZPvr3Z3NVO/ibggQdsms8ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYV+4m5yA1AkIhqShTfEOMnvi3/FCCnPq6D3i+VWJSzaKHFlIgSw7Rqpttt5msl/QY5hv0k2kRul4Nx8WYKDtZtrqfGTw01xwOGP2qFAuYgsdjqfGJ6rfPRKDNnk8ArkGjYdFLEaDeCnazSWOnxWIGlHJ5vwGvT2HpopJKCspWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L1Yfk4Pg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IZMgFKDf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFhcw015535;
	Mon, 29 Apr 2024 21:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=rUrrHaI67OFq2TQjWV/dILXIRUzE1IaaNzhCAY0THFM=;
 b=L1Yfk4PgFGgOncknf8gUqGYV2AE2A8xOMsDAKYTDMkKYdWWek8b9l1InoSKoXKNDT4qB
 nnBLWQQaAoui+TVZwVUCF3PKw1V7JkwMeuYR1DzQW7S1aFIiGAfhJwuoSUWNN1nu+62v
 FB5Xz6q2lkyvtfXBreL3+B9BtpbDeYHce0KmfDEf7kcbEFq447UC98lommE+eDp/GTM7
 RxWvouudthOENIHObN5GekKiCK3lFcCQECHGEisW316xLzG+2NLZvC8I+gGbQJcHvTUo
 f6VunXeuvgOXRY0cXh3wgE2mvTpIczk8JMoWYervHLNSBVIQWltl5s5taxgh5+Lfvjql IA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ckrhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKs2wU005034;
	Mon, 29 Apr 2024 21:23:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6g6wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zsm+zZbV1eZoX0BGkrI6HWGZiJcaRT+cHwaa6yO26B9bNxg2Mo9dD2JrpQleAEiCeyWVSVdHmJpG4qS/x+LKZ7cHGHFlAbma8BRL8gsUMDR8BjkaLdkB+wtED6WqNPMqMtbLvobgkOGqkWnUImn44N5LDKAMt5bBePvAhxYO4z6MgzsUtAy8tDnLf1syzNuqzAe7i3RaUPbzx3+YWDNVOCl07U2GAJkzzblAMbhG2/wdiFhdgjRFmxWR6P75n02otnE5L9Gi9ZH86p4fUQ755KKtjS74zx7iwQXT2rJ0ca7brQG0ZKLLyf5yQgM4DVeqCrG+y/W9H2VQsjJl8l/Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUrrHaI67OFq2TQjWV/dILXIRUzE1IaaNzhCAY0THFM=;
 b=VRXJ0Cwy98HfrQcZyllVM79sJlCyl0283KI0/uPxDsT5aykQslGDoj9EfiNhQvlNIqXrJPXmdJ8H4ySljyPjbpTrHfp7knTO4Rc7NuHW5Inj2+5EwfSldRKukR15J2b8aga3N4jRLECjJB/6+mkBbd61WzEwU8DWRXzHv6EEjEYOlVRfKzs/q1PjfcOH47A1eX22oKDlMz2YtociSEf6VkBpkBPZTlZ4nrD9OTPU+WNMCKPv28TauR2jCVASLPZ0gvJYfQwBCuYwOuNJfkkCFeWRXtgiw3PhBQ2rFS0luRRIDHMha0T7id8n8BJXQaQrwHtni/HdhS8l3Bx3xT0Ehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUrrHaI67OFq2TQjWV/dILXIRUzE1IaaNzhCAY0THFM=;
 b=IZMgFKDfUN1B9aWE2ayRZomei1gOfuh1FwssvDZ3nNF0uUggqT54h+XQo39l3xhh3TnKIjCdUGnP0XcmWCmEV2zmRH2rlgr6iboOxzGMH1bb8TBuJax9m3XxoROxaiOnrmzR7hz/Zw3zDPs6PFEiZI0bE5u2E7r1jA2H/y4LMEQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:45 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:45 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v4 5/7] bpf/verifier: relax MUL range computation check
Date: Mon, 29 Apr 2024 22:22:48 +0100
Message-Id: <20240429212250.78420-6-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::7) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1889de-921c-4230-a0bb-08dc6892a70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5D2AEI7FLM++XC4RqYOFFsS0Ysc+MF/T8Z6okhZ9EKNKryg9Xyr1/BhGJBl0?=
 =?us-ascii?Q?gPH8bB/VhEF5vTZIRNFRi3/Oh0HE0LFHug453ZHnwvcMql7zzgmQ1cLEwsFU?=
 =?us-ascii?Q?oeQr7hvHvgtOIzrqZxY8XxHq9EEnzv/MQ1woxynDo/gc5No+7oxpFIXg9EJt?=
 =?us-ascii?Q?JnR3J51NY+WjIo83zHIs2dq9/TMX2gRBRqY2RSaogParFByy5KURlBK0E6PM?=
 =?us-ascii?Q?6oJEqS/ljjp/LEJWl6Gi9wwbZXJwnDtFSz5mBEI7LcwBVhuVrDF4rBMVxRK/?=
 =?us-ascii?Q?/PkojRUOyMZOnjjn1riRrXnHNeJnjWHWsid5ZW0oY19C3slXbjnD86S9YHkh?=
 =?us-ascii?Q?Y5WV0LNv7s+St70g6HkF7jcIMdvfBmLZOKJ5xPg8v+6eGazCl7di18EKnpp9?=
 =?us-ascii?Q?3Cok9L1MHa0PtgEtit0wYvTzGIgg8uAzRXHGi/ze2t2lNdCTikB7CUY7RRbW?=
 =?us-ascii?Q?SRO5PqfXYrlYl0B+02J8vrY6fm7pbQXvIJ6OZ8gLSJefBRw0qc7ze+/jW/sZ?=
 =?us-ascii?Q?woYposhFFNbnvGiEAMePlX0+hucXZnTXb2/ETZMObO6MFYa31Xro+dqIfSIN?=
 =?us-ascii?Q?pujRrmHtUbPhG9Tm36pUsCQNBKbYuVjfIN5cGe9WbntTnbwgX8GvHdUlklnB?=
 =?us-ascii?Q?jk774mIP4PSFnLIsF3J6SZdJ7XbEc39BTB7Ep5wg03cQkiWe8ql/CWQ6roM7?=
 =?us-ascii?Q?j73Jq44LEKjlLhGG9uU7uHyAUy9/MM4Gy2xPdFi/7WpYPGQ8r+xPW2FgzHjQ?=
 =?us-ascii?Q?GQWDc64DHNCeXHIHL2KvMzY65Xe9ZNp7oqNp4ipTEdHvKYG4aUF7HLO+HQjm?=
 =?us-ascii?Q?qIrgRX56InxfSHd0j6+x8bT6dwbeXoJtoJ6NzqGMjpVk67NTQSvain2d+Tl7?=
 =?us-ascii?Q?3tmO07cZbm3N3WIiLusrI07qOcuM7vBLXhHgwomz1fSajGT/SeCnaREra+39?=
 =?us-ascii?Q?wEQe4YSrn4Ko8b3A4i4MRcBbq88dv0k3SkIgCOQAM+czm5nTIjOkrkQDr2d2?=
 =?us-ascii?Q?AKssolm7AOq6eJ8RXOfhQnekCwwPWM6FVdZuoeHKmqZMchjGLopjeq/gDhZi?=
 =?us-ascii?Q?mfRFhEHObg0UTQKUoT0foU0wV7D2en8hCvShy/yo508j2nZMEPpe099C0zS/?=
 =?us-ascii?Q?KqF9UqCry6o4XRt2BeYys6j9wpdaRliaGzOp4YT3sSIrjLmqr0CJMufIK9kT?=
 =?us-ascii?Q?cVCyq9sSMMGZxGvclrha9UDxdsYSCfgUEsA4CBzwyBmjHBUPCRkcMWo9rA6A?=
 =?us-ascii?Q?bwh0V9KIJ2avRmWDPnbBb/i8dVv/8oNvB0mo3P7vNA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xWI8MBVvNnSXfFemERgM9qtzll1iBghtd9+3FdAlXrjsJ3HEXz4/S3PG0kMV?=
 =?us-ascii?Q?Sd43z6fSuGINiH2hnbb2eMkhOk6cYJ5PdL08TK7enRkY+iwWZeGbOq2tikJs?=
 =?us-ascii?Q?+746fmepz29tiR7nWRALCWf+a+IJpjAw0CNNlM5Gz+Zw/zf/q5v3Xj7mngUo?=
 =?us-ascii?Q?3AhI6p3oDIO+ZX7gVMOc+rROtV7i91x9YOvbq5lpQ/TBg5lsVgoFVPudQ+fD?=
 =?us-ascii?Q?Ii7pybukFa1QLBT38M1G+WFWYt3RPf0nXiAbL/JFVxYcC0tfOK5DWX2tUzHa?=
 =?us-ascii?Q?VA9XdzemM505ix2gy6Itl/JYG/hUcgcfr4TiD7IPvAkz4+r99+ZxZeFahLX9?=
 =?us-ascii?Q?lAYg+AkNlRkqfaqN4Ov9jqgVSnOBZcHR2xA6v2oXQflIf4FUKjjXI/F6W/BZ?=
 =?us-ascii?Q?J67cB9BKdE6rrdBd6ji88R24ND9OXuFVANvDxHQceNoIHXMsFq5eHFDA3Now?=
 =?us-ascii?Q?QBwTCPaSubkpOQxQjzLktJ+55wbhfrmSgjpjxkc1rkF4cL/s3rkzscpfYy7w?=
 =?us-ascii?Q?NO3E3PUskUGSTCNLdY5aea4l3NQEcdLAkmX+AqwhPT7XpK687681MxCPpRlc?=
 =?us-ascii?Q?3UhnalvYZdWkyRKkiZIbsnSrRGYCpYrO2s8/kz8Z9GaXvhfH/9cHYFkdobcM?=
 =?us-ascii?Q?f+40c6ZodLWFIbExWQuELT8Pz2cMvU2sjH5FyLDFX8K4NwWjAiaG7bqEZgY+?=
 =?us-ascii?Q?Nl0YCXIeN//nAxkBPspOax8hdVZbPV5u8C2n9x2/S0ANgCaEng45d0H/JMKR?=
 =?us-ascii?Q?VjNZLmOQWCYVeV8xhRjDg9wmJWhLepFbgwMGD1RZBpMWR7lVEXfI2BlqoYZD?=
 =?us-ascii?Q?LIEC3EzdX2WzhhNQYpEgVcZtsdU0erpb9rKhoX6nWMeXSCC91uTbBr3QVGjH?=
 =?us-ascii?Q?7gGFwZN1W5UWyh9YLVeAIC9MwN6JJJekOxaCkm/UlB5zBQpg2RjkOAWwHsvh?=
 =?us-ascii?Q?WAl3WMbxWbN2lvPdKATKojEbh4o6t1dQZ8nRtbFnblXo0yWCbWkiHdhJmjzr?=
 =?us-ascii?Q?2Szh4zG6rfhisrLv2s/BU316Ckf2RmVoQ+q7qN/VOsdywWdn4Wb+WrK2/sND?=
 =?us-ascii?Q?FQMnpfCMAS+jteeADOSiqVaGnFfe/cn9hz01oIdCLnTlxbN5d6DsybY7og68?=
 =?us-ascii?Q?pOVFaP+xC89Al4ftfmnonTcIg9i/B+2PMLCPmAiTtVY35oCmMsB/HaXNUXUB?=
 =?us-ascii?Q?pCvV3tmjBAwO/RZEgFkFx966FL9/HzmjUgmz+vBySYNxAqpBvs50ptnLXMPb?=
 =?us-ascii?Q?k21fQ2rDPk2cES5jQXmGGy/5KuTupGFQ1OJoM+8QNUIwK2Vzckon3uRDpsM0?=
 =?us-ascii?Q?M6crNfLZ4nqnXlejMryWEYTwrB5UhV9yPKeya4WsmdlezjpeM6wF3e8AL+mm?=
 =?us-ascii?Q?IK5g2WLHrZUTx6hHl/VkgFoZo/XXKjr1aK/9cCxXhnMxpAY9FQAGIf5jf0Hf?=
 =?us-ascii?Q?neDbd+IiUWYvVQvoFGvCtD2jsbgJpHy7timwJt+4K1suIhXA1G0oqaiJ+H96?=
 =?us-ascii?Q?/hCPExU94TUcyhlg2ZS+Yl+tC+S+5CAy1nSSeLt3PBkIpCtc6onA/sgsgG+e?=
 =?us-ascii?Q?zht2JYB3kUrReDktOBLvORUn/vx192nEm2P9QgdHQqdp6UfYy7uAwfeGCzpi?=
 =?us-ascii?Q?7+3qLvVdbZXc4UYXhUa8xv8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vJsxvPcyiqPScnSJ1ok71lwaDQSAuqFYm3jqgAToeTlJ5O++EKkySimfq1FIYtkbxEvPSx02OYyqC4UppvgO7Tb9BITJbqsRbp5Rbd7+BMSNobUHrqTgdjLs8awKUiFM5gdYGPUIp2J/Dd4GVCTvrFf1VS5NTSlaZU5UYfQEy7OYbyE7QpchHfGclKQOW5wRvFwG7bbVrMB845C1Z3LosTChpM+WlVF1ppSf7jeGSFJCow9ZeeSeK8ypgJxSixdLawMrOA+jnJKM4WVMbTu8ckNr+S19iH/5P5BUL57CtfOIdkPr4C09ge4kd5n3Ejb87cKSlcP4TICO8X5ZH63FYMCtHejDSG+y+t2eHCZniWPeFKH7xzIZ8E4QaIPigAlg0jtGA6+UD1FwxTo2MAmnZh32bVJ9mggr7Ck7+0rFHjTFauLdkRg7xjyff5aqHKqIItrOw4yRUKtp3YyZ1wgc1/dNHkytiihEk9dLFYYw0At2a9cu17D8GqJ3CkSzM3NGmQdBo46BUBxM5FPjFkJtqh/KiCSxEkEgBLUSFNr8vKyI2JP8bzai0wlvaW3ckpLP0HBlPalIvQfliZHH5IL0kv7kHOEfL8fLZjM1+rb03/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1889de-921c-4230-a0bb-08dc6892a70f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:45.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htu759adxGYFsYgu/mfMueIKmW4h0d0S3py2V7dJgIr2kQhJw1SGhXHH7NMPmQhmS/Xoeb9Ti2wu02jFXpl3uLnDxWs667WdPM+rcl7QwpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-GUID: BMfyoPyDIipoleCBLdoyeuZsj5sNTQoR
X-Proofpoint-ORIG-GUID: BMfyoPyDIipoleCBLdoyeuZsj5sNTQoR

MUL instruction required that src_reg would be a known value (i.e.
src_reg would be a const value). The condition in this case can be
relaxed, since the range computation algorithm used in current code
already supports a proper range computation for any valid range value on
its operands.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54aca9b377a4..b6344cead2e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13746,12 +13746,8 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
-		return true;
-
-	/* Compute range for the following only if the src_reg is const.
-	 */
 	case BPF_MUL:
-		return src_is_const;
+		return true;
 
 	/* Shift operators range is only computable if shift dimension operand
 	 * is a constant. Shifts greater than 31 or 63 are undefined. This
-- 
2.39.2


