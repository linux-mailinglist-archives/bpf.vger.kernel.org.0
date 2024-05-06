Return-Path: <bpf+bounces-28687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169B8BD174
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 17:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843FA1C21C7B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13E15531D;
	Mon,  6 May 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKnt+VIq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yzcfuOsF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5981552ED
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008744; cv=fail; b=gsTcmu4TRUsHFUev7e8ZFymCBvjkPzlKREiwr5ecvVHPlmkp2byUoCTcur5OgRpHnPoGYuF8C8YvR3shm0NO/RHX++wtMGo8aLZMdKqqH3N9LkYR6855UwjddjZuvCiLWdPUr1UGYKlx8Ak5y4pv/YAE4yI+V6qW4g1K5gHXrRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008744; c=relaxed/simple;
	bh=cGW7AQqURRTMu0+Qwla9phQ9EVlI6Sw4qSGHYYXd8uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWSR0/dOGaLD3NcwFoUuevdAvH/Jad5oB3xMtdQ3LKftqTAuUKNrU5dk4cNutzeeO++kjse0Z4j0FhzTNovRjO8ZuELYXOufIib3bY/IrWyrKQYgdWZFl18OkZh5i7AvwY/03AlQzx4sFQ2yWELt67djy+EP1sxu8+REq7Z5bBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKnt+VIq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yzcfuOsF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446An54d009283;
	Mon, 6 May 2024 15:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=c2E71BJbuv5p6mFx4wRMMU09muUWSbM5A9AGJ8GQqiQ=;
 b=hKnt+VIq6+0oRFUhXmZJl+tRMzLv3SbwtGIfghviHJvgLf5ZI+zBPHXxdHR/v6FHYXYZ
 TOUfPe3K+4+HyL7XhlQNj65BUgbyW6YZ9yw30z167Vub6jkGwE/JzeCQaXiI5pBhPtJb
 9YMUhuTAVl2W0RAsSTpc59prylbbd6rjh5/CVONIrzNZQ2zyjVK4iAq/UJ4q0u36NLvW
 sWKt9uSoYapjFQUrIiO+8X9WrZpMo/TDxhbKq6b6N3B5++PQfuTifI/WWw5jVuhpC3kt
 ySVBQOKRtVfAWuNypJCuDJDdzlz7Ha2Hfa2O3HHoQe1jYAv6iu++QADGYT4f2qyAHEPD Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeetufm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:19:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446EAE63006969;
	Mon, 6 May 2024 15:19:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6seg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be9RpkzijSwx9P5/Af+X0OXEFLVMPbmNKkZJLTi7DNplh9nrX5mkMYfciwMTOz8C4oGdi2jV5r0JQbKiQTSapCJD5BnPH9/0Bczrn2DFc+Ans/v/1xkesTncATTE8BRivaJGMgVKUFnJG6hqn++AQc2l1CirHDqDw9gWkomVn3V/e1UgkQGDdkxvYNf2dApOWKvPIo9mBlhG7J8jtSOZjijWvdpInmtTcs3BCfCSkPSLJqKjNZYIqu2BYGWqKL8msRwvVdj6U6IllWwyzWYW+5X59Tjuv3DeMyVBYY3oN8Pd8q7eq3qlOz/OOrN6u53evRm8RM890WPWL4Jw483Y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2E71BJbuv5p6mFx4wRMMU09muUWSbM5A9AGJ8GQqiQ=;
 b=h+yCMv0Eg4DzHb6w16IrVgO30MCikTBRifF83jG0IcBtpFCZ1pOv8G5hgS907UWTf/aAgKqeut0v/vh6N6hXXhuaa1aloTAMXxzMS08jlCHghXsCXk/MsSb62FGdjvgr1SfbjxRU+KMugSq/Z8O60LtXUftZf8N/bzK41vBhJ0XiHAAn77TaVwYg0ErETJeoJwyrFowDzq7h1LEpttEym3ZWISiVrQGAb4gU00wQ8koYxzEygh/3Pz06JjouuSIUDUt6wgeNy3M8i49NKRFWKB+k1ENM5uF/ZZ+nnMrCzTZOqjN7kg1EI+9CO0uen8+rwdQemEocOlfYJOHlLjLWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2E71BJbuv5p6mFx4wRMMU09muUWSbM5A9AGJ8GQqiQ=;
 b=yzcfuOsFDbT9ymFSFDiwQ6drqNb06htAk4V+83lNFf+8g1vGkdMXgT8cUS31/RY2RQ7AmZl33HH9HJSBlHW0EI9JNCvJ7Juk9A1UJFc/DG2QY0asZEBD7O6uykhM9qMZM0/arbphKuopZaj7RQbEwLEJsIZxoVzsDJxu4Xkdx8o=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ2PR10MB7015.namprd10.prod.outlook.com (2603:10b6:a03:4c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 15:18:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:18:56 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Change functions definitions to support GCC
Date: Mon,  6 May 2024 16:18:29 +0100
Message-Id: <20240506151829.186607-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506151829.186607-1-cupertino.miranda@oracle.com>
References: <20240506151829.186607-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ2PR10MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc67da1-17cd-4b15-bfe3-08dc6ddfd896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RoyzJlKYygraPzxN4r0XAiv9N0yWeEE8x/IUAV7e9ExVFkegjarOpOO/TDM5?=
 =?us-ascii?Q?h+kv66pKMrhI1WHjxrR/GmCWch1EGECZLW/2oBwkkFiTvghH+QknQ75hX7Ca?=
 =?us-ascii?Q?RNgU17GcA6mQDVTLbqa3Cw4J60rq1SVDo9iganrUBjGWIEO5aDb1JozU4ah5?=
 =?us-ascii?Q?nKzP/rFBOMgbLHSoJ7vVb+BTZofaA3odpJMHpnKAgXD0zYraz9OTr7nMoy/g?=
 =?us-ascii?Q?FcnpqItD3iINDSEvMVK4u1rAh9AdY/IWjmHFf0l8UN/knwUW96q2eoKo2k13?=
 =?us-ascii?Q?KdT4EFAZY3iX41b3H0qkhDZMJFGJ44ru5g+7jn6RgW0q+7QuaWKbAULX0aBF?=
 =?us-ascii?Q?Uqap547y4u3d256uwUtDuT+ejFdmz3rkxIoLkdI8rsEo8QGiDI8njO8S8DrV?=
 =?us-ascii?Q?tDLyFVN3+gp87sHx0dRCLyRLtq9qnPDBaa896tUYSqjQS9lMoBjnrhqJYe7n?=
 =?us-ascii?Q?yxyYyzxbo1zR6344N2MsW8IKbKJXgTGLPSHh+SP7oJ5AXvwBYgQmP72LihnZ?=
 =?us-ascii?Q?r7xOr22/mRPMO16vUKQY1hpUAXbFQuZFU+k0wkN34E7g6tadHWOK1Ono0vBb?=
 =?us-ascii?Q?lh+ajHE2pnV8Mpwf38kcas9+FV21tgnEEj7c6p8IDnUE/EEHZ7mZkSvFF364?=
 =?us-ascii?Q?0oCVc8F1ztbe55RbtLiRoOMY1o6VsGM5tR5ednnKiWXk3SFHPlAjAYxPXHMj?=
 =?us-ascii?Q?HOGWRzqgEx3aPFkoTCnZUwGsEC+H2nARWP29N+7YKSYPsJJOLCoXin1YAS0B?=
 =?us-ascii?Q?gONzuIz4/tAfwII5f/BNOvH7n57ydnMGAq/SXr/FzZAToNyURc81uaU/Wi6/?=
 =?us-ascii?Q?HzFmqE80G7LIiexje2PFRu5RmIMqiKhWC6HEZ3y74JuxvF/OScUU705PN3Yl?=
 =?us-ascii?Q?zI/Cph+zYKqZSLHzxcHKt12K3kzGAr/ROvnZzhPna7EpzgnqkC2y3ImCPpi9?=
 =?us-ascii?Q?sWrv3OCg9mVYH9uTg9yYef4vMpVx5zp0da0thdONF/GIpIiRmqtNlcHRGV75?=
 =?us-ascii?Q?oy3FllFouAhmjnu4YlPwUEvCs8YQosXeJUkypq8IJ6ztI2k298O2j3Fz51x4?=
 =?us-ascii?Q?g0n4Mf8yyAFX9AG7cCLxXyXBdD1bE28T2o2Th7Wwd5QbwRwvUKPogm8QJUPs?=
 =?us-ascii?Q?AgWqQyAk/m7lFSHr6pPEAStK0mb37vmN8PcM6Csf5JyFX/2cLxn5luwuCV1P?=
 =?us-ascii?Q?672ibjyL4PyPK4TCfzhEq+YEmlMgrhUdRtjQf1cr8BwQKbz640t/smVX/JSt?=
 =?us-ascii?Q?WrUqmBbb2/wRC+pI6Sw8xwVzv3d2ehFJ27LpSviH7g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8dXCmGqQwg8qRXv3wq8TRa7WZThZcPNjx8T77yjmlX4MllHWAfMPK8jOJzo7?=
 =?us-ascii?Q?maZi0QPpRSXHJ8U/xjtnOAZHNvOb451DGqjMpqd9xTWwW2ELmFOTwFTierkd?=
 =?us-ascii?Q?XAXBAqL6eSH7uxPv7ebFbrQU9shFuWC8iOfsZwHQz5rrPEYB6ja0wr97mx5K?=
 =?us-ascii?Q?iNKglplMPcPr96tmYEviSag44deRvrsJvTtDEqHuFXbI2msKcV6gwZiGLgGK?=
 =?us-ascii?Q?FUK+4miRbD590Upi37l/2rMv1n6jMrFnj1jubTKN+uaTTZbtftwd7sP59oTV?=
 =?us-ascii?Q?HcGuLQrn2HCBTjKUfH011ENjdMNUX85GPiSQun1BfJ3UMgXXyEwSp6a/bg3G?=
 =?us-ascii?Q?BDRTwY1tK4dESwt3dd/uW74AdatfJwY16Smj+JBpnB4IewCofb6ev9U8f5v0?=
 =?us-ascii?Q?wnsj/uKMsb29Pjuslof0hZMr92e9x6uI0q3dogkwY8WXyhVVpDYA/gEBzoZ5?=
 =?us-ascii?Q?qs4hiRKUalKNViDqzpVgbfLW4s7fl15y6Mg9u5Gl38xVqi1tVddHl91p2ns7?=
 =?us-ascii?Q?/J6T9GXIN0k1/uoH9Nm1B3BipuHYDZzrxPPqQgkmh1i3uW5TA8a8fMWbBXmg?=
 =?us-ascii?Q?CJXJ4SzsWkpmV9v+wCmWYW4sXApXd/B3msZ2cBQu33gzRQ0ow1xRtJygoqhP?=
 =?us-ascii?Q?kYt+iPxZXqg53SgH+L1EPXmBglPCgvsy4oESlHX7yOvti3wh+3GlnXAOQqws?=
 =?us-ascii?Q?IMNsu9ps7K3x8lFiC3uV5Id/Oxs07T1crh1ZR3KSqE0o83iuua9mgwohQ7B1?=
 =?us-ascii?Q?lXdCqiY+8evkDzarbTurq7O1m8Y0dBTpoBpMU9N1+kX9xkPfnF+IxwD7hGMu?=
 =?us-ascii?Q?1Z8AfjKlH25uWrpoCpSfJspN+HF9RUhCjL6RdNEPy/kfEBvq3L3e+jmHKJzt?=
 =?us-ascii?Q?3ysJq8i/7rRVGCTWjU+8tXEhPL3+z/d1Rr1Ql3+GpEbIkvQ0ysdx0HKlBBvn?=
 =?us-ascii?Q?lM1czDLGBYUiEB9KwgyJShPmLRD/tjFwZPV7qgYTsTZyDa9gG+A4PWPX/r/w?=
 =?us-ascii?Q?7Lfn4ahnFL8APSLO+gWbUUO4LH21NUwJ3DJ95Tiu/jrSLFxW8845mDWvABSD?=
 =?us-ascii?Q?+n9pvayWJpwhQV0zwMci+h+XNRU92C8SSBVWHHE6hCK7oPPa2N2GV6wnCS+r?=
 =?us-ascii?Q?J17PleT7XmbNJsl4wfevpuCAs2szp0RGv4GA2i/oEYCZc9Ja1AUmszTTm+/P?=
 =?us-ascii?Q?xNlxcTCfsyg8zzU6j6kGBPlN7bU2TL1DnCtlgUTxtkAhu5I0IdtNLxiDlaY3?=
 =?us-ascii?Q?4rp8sthFcRD91BMsU/5YrkwPPwmbWIxxeKTz3dyT8sN6YrZ4kN2z5CYjKh0x?=
 =?us-ascii?Q?t5XQtQ7NyHXSdWghxORGJD2tMm6Dg1V95/zfaHuOzwmeV6cSDT9UFi+GbRU4?=
 =?us-ascii?Q?txYgMv4yl+hFCWgfixp7oPf8R6YLC3JyU8eVJHcYCKBPCLjdfR+rHr43BIWb?=
 =?us-ascii?Q?nMOvVyQGAAvCBGtfry1LeX72jBhxxhLWXlZYcLksekUVPUW9SPewc/WaMEqd?=
 =?us-ascii?Q?CtW7lAcZLgiZIC2yRXrpEc8MrFFbbccI9NEe1qHE8HTaQIu6EBBDkXBrxHhA?=
 =?us-ascii?Q?cjZJ17xY7rMyyZ9nVMZrC5QDFywMmOJOgcz6FX4jbgwz7GKU3S6S0GCHlELG?=
 =?us-ascii?Q?gxE4VJHucYqgH/aTYTjQwlk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yCQr+O6PqNhl+juC7X/CrftOrLx5e7rRaaoITnBGBmRkd7X+eALIPzvv0UVTG8HOBkGgi+vIoIC/c9Vp2a03Lgaq3Ww3ODZCh3HmOvnbH+At3lka3AWqzS8X7g5uly1ossYCseBqAxES8UyLykDSrxdazipWzxqYsKEnUSmFVQrMksz/0sIrLhng4/ooeuJNVW/k9Pv9uMtWLNZNLAZWuGMAJdyZ2FJ1t9sH60iRNyTXeAlyLoN8rza0QNXXFclFjfenH1Qt7P954xzRVRefX5Vey3Z0mqiuME22Egg/XuEr5OIHhYpN8MeQvYu6jRIhqU8nm24RTmng1MoD54lQmZJoYpWBSFNHuBXEgXNKVmuQEF+csO1fMsPkSx0r1RaE6V6gbP+nZJZCfNctPKZi/mw01Nr9a6Eks/+/O44N4794VHYIVgVEMSqNwWTLnNOxGq9ohxcb8TNcKNDje1ylRFmw5CeCzqvJ+eVfT9SQh5mD2kwHK+VLg9yLHPgGBFY++UktV9AyVfe0zTaR1g2MQL5D327cbJJTloU/yEjVe7SwrIrrr5d6gksUV0BwJKdHxK/0TMvpDt+nguVdiWV19kugYsTvkwVrIXeD/1vb0V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc67da1-17cd-4b15-bfe3-08dc6ddfd896
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:18:56.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtMlMCkGmPTYG/d9W0tIlFnpyA8dLBRSBNWAO5H0Z8Ml0SBaHQTGc5dfBzkQ0H47R1zXrtO68uMtBQxtEI8JIRYgzCK5MC2qA7P9UxUotHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060106
X-Proofpoint-GUID: LKm5Eu8pqCs7c4Qd423iMRW46pCzDe-D
X-Proofpoint-ORIG-GUID: LKm5Eu8pqCs7c4Qd423iMRW46pCzDe-D

The test_xdp_noinline.c contains 2 functions that use more then 5
arguments. This patch collapses the 2 last arguments in an array.
Also in GCC and ipa_sra optimization increases the number of arguments
used in function encap_v4. This pass disables the optimization for that
particular file.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 tools/testing/selftests/bpf/Makefile              |  1 +
 .../selftests/bpf/progs/test_xdp_noinline.c       | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e506a5948cc2..6fe9b0dd2ea0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -86,6 +86,7 @@ progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
+progs/test_xdp_noinline.c-bpf_gcc-CFLAGS := -fno-ipa-sra
 endif
 
 ifneq ($(CLANG_CPUV4),)
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index 5c7e4758a0ca..a38199f900ec 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -588,12 +588,13 @@ static void connection_table_lookup(struct real_definition **real,
 __attribute__ ((noinline))
 static int process_l3_headers_v6(struct packet_description *pckt,
 				 __u8 *protocol, __u64 off,
-				 __u16 *pkt_bytes, void *data,
-				 void *data_end)
+				 __u16 *pkt_bytes, void *extra_args[2])
 {
 	struct ipv6hdr *ip6h;
 	__u64 iph_len;
 	int action;
+	void *data = extra_args[0];
+	void *data_end = extra_args[1];
 
 	ip6h = data + off;
 	if (ip6h + 1 > data_end)
@@ -619,11 +620,12 @@ static int process_l3_headers_v6(struct packet_description *pckt,
 __attribute__ ((noinline))
 static int process_l3_headers_v4(struct packet_description *pckt,
 				 __u8 *protocol, __u64 off,
-				 __u16 *pkt_bytes, void *data,
-				 void *data_end)
+				 __u16 *pkt_bytes, void *extra_args[2])
 {
 	struct iphdr *iph;
 	int action;
+	void *data = extra_args[0];
+	void *data_end = extra_args[1];
 
 	iph = data + off;
 	if (iph + 1 > data_end)
@@ -666,13 +668,14 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	__u8 protocol;
 	__u32 vip_num;
 	int action;
+	void *extra_args[2] = { data, data_end };
 
 	if (is_ipv6)
 		action = process_l3_headers_v6(&pckt, &protocol, off,
-					       &pkt_bytes, data, data_end);
+					       &pkt_bytes, extra_args);
 	else
 		action = process_l3_headers_v4(&pckt, &protocol, off,
-					       &pkt_bytes, data, data_end);
+					       &pkt_bytes, extra_args);
 	if (action >= 0)
 		return action;
 	protocol = pckt.flow.proto;
-- 
2.39.2


