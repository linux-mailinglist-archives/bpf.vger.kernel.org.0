Return-Path: <bpf+bounces-77994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5FCFA32A
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0CC32D1D9E
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A6833D4FC;
	Tue,  6 Jan 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4bTQuXI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I/dgroTq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07233CE8F
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721018; cv=fail; b=edZHY94DH1AoDGgyKtXrW8K70NKTqxBkGNKU9CfTa00RmjXQE0G9lzlRf+4bgNdBzAc2s7TgWr/FXVGD6drpVpjOVBMLsHJ2nwv23XLwjylR3ZD3QBqTAZrMXJVJnceXFcsp2x6t0/NS0q1bWXG+b11Cv4ZCiv7pztNUEIp/tyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721018; c=relaxed/simple;
	bh=2UNJXJKtlqfEBNmCrf851jJx7agWUP5MG9WQ+FR3J6U=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VMJ3kVFRGmijS+u2WfWeN7PYc94BT6PH6Y74uOTwILi9qeF+eSBkbV6R/mZO0xjhDX+IDrt5Bmbjy7zs/6bCPKAvxIzQ4/W7BWLW4tzVQnEfuowC1BJSXBm48v7Pv2/zweALyKLigmIMEgb3zXGlafGyIdRgkZ7Do05huoe98qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4bTQuXI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I/dgroTq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606H5DIq131634
	for <bpf@vger.kernel.org>; Tue, 6 Jan 2026 17:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Uw2mf6JLTWwZnkam
	MKdo/9WrWhC/UdJTBZZlMUShv6I=; b=T4bTQuXIfsvivZdWeOyDUK29rGznZUag
	/h5vD+pT+oJ0GmxTxoU909sxddfWtBrKJTvAQll1Yj/wsx59XidsR7EhzXl/8Mqa
	Ev/IqTdzH6CbDHFeoF7odC8fxaCLBgXl4t7anAbwdLbz74hIsiT2bskk7uSdhfLH
	HnOeffMEiAELwemcg6kBHQ0iKtn/KtZrgLVwRfyKrAevSzmeIbK1QeS7zqaYMOew
	ZJk4jsP93iEW5YK6FtVzQnAvzh/bXeFn0o1ok1xLhXnSvVzvkDDOvJTibTySWaVp
	3DdhDyfG+asVMv3TtWKzReveX/v37w6FUrtgq07ocI6faTSbGXgupw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh6g1g23u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 17:36:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606FuYkX034124
	for <bpf@vger.kernel.org>; Tue, 6 Jan 2026 17:36:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8v37m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 17:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwF1zapDu+WavoioR/RnO5JkRbGfNfGmfYyylc+IqCzpj2Ie8fKZS+qkxX7YlQRfnWxf+td1M5zm9W6kco2fgq44X7/iCRitCWrR6qOH8nHFnToE16ns6vRnIBadho6H0flJlcbWmcdkxTP3LxrYgxMsbqGVYoY4/WonZJgyvPJoMjtkFUA6CO5IheaEZ3pDB9j2kQSfDN7FYRPuGMVIuCyVv2pBJCsR4C+1Tk8q7Rlub1BgPv//zJP1M8VzdeaK0GMO7YHeEKiM3DtlmOaFxs2atq0bGUUiaLIdySF/RYla/GPn78s1It1QEneAz30Ib3w/X6UEEJtbpVAJPS662Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw2mf6JLTWwZnkamMKdo/9WrWhC/UdJTBZZlMUShv6I=;
 b=DtruM/HWB36jSTEsedKtPVADrkm6UNM3+pM67F1v6FDOWrN/qXMFVRAbtP8CyJNOL4diYw7qW5zy0yjzRMnJattiYCvbBqOONVP01fH+e3Jv55RgEE7XbO51ndgncYpGFHEJtXJeuz9Ob4TbWmoPyn70g6r2KTzrIlCNHddsTH8sqXl57QmSyXyqZaJvh+nd03x6+6WTWZhOzPEG5WzzoSDKatGObXYzXvub3FWywdYeTbZFSZfdF3qxYqi7yZBuKEz5HCFOpF0p1ABjkbgyoDUYerbXiVdIiNyXfpvkQzOoa+yCjRhjxDltUh+PQxjyp2HnA5qZN5wOb66KiZI5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw2mf6JLTWwZnkamMKdo/9WrWhC/UdJTBZZlMUShv6I=;
 b=I/dgroTq0QN0Ca9AhnK06VZ/X3ixltv3/TDiVJRBuYd9+K2HiA4KeTu2tUn8ASTdaoYYmXNP+I4FIi9v/lrF6K5uKQRv8gQwA7med8QUChbGqs8lF1KECRdStyq+1H6r+WL0kKHf1mBOiwhpZrCYYxK47yGp2EuLH+uy823YgR0=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Tue, 6 Jan
 2026 17:36:53 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 17:36:53 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: selftests fixes for GCC-BPF 16
Date: Tue,  6 Jan 2026 18:36:48 +0100
Message-Id: <20260106173650.18191-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef1491b-ea23-473d-3d7e-08de4d4a2dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/rHQB41GxLgK6m6Yr/IHOkM0g89Kw/+Nh0jUgw6v2EDkO6Vip3ubWwpLnJqr?=
 =?us-ascii?Q?bgB+9qczTRGOtAXwckIulgIPMxf5T1fO9Py01+VCYHFXP6d6JbXNfCjeNU6V?=
 =?us-ascii?Q?AC8IkLvf45ttlYY2vqNRzRp4ekoN7PAK4DcHcPfJDNz95qhuCcndhdoFtRth?=
 =?us-ascii?Q?PQa9fdy+n5L8UvsqmvkRXvDXiH+10j7BWS62uJvfwKAcf4+0ua9XBJ1C0GJq?=
 =?us-ascii?Q?xindOoXoRbsAd0JdbWT3C/dzYcCMJnwuv76VFONNs4jQSoyAHm8jz1MS0xU6?=
 =?us-ascii?Q?Dc26dQ8YqquIZ/LzF/13HcaaIxDFU/sMeKUVPK7xshNs1dtHDfBhIcGz5ovq?=
 =?us-ascii?Q?eQ/oh7/NuDHDkANdjGBMfdCs+0U1e9U01I+mpFu/Sog1TnBU7UeuK0bvI00V?=
 =?us-ascii?Q?5iVQXtai18Io7PXPP1hqajCPZGwNHTDriFzxuMSE8gQ4iCaS9hX8iM+gNLtp?=
 =?us-ascii?Q?cizRzAHaj5hpn1LfgejYexYFpgqOYOZUJ3ZD77N5bcKxLtVMVxbwwJV28Usi?=
 =?us-ascii?Q?lak4vPvbX4f9RliGpYkUd4l8iJy5SayTW8H6Fk4CHImvrQuGJDYfKQf0hl6u?=
 =?us-ascii?Q?GbEd758eDxNuvXdL8OfgCbG9WRcPqK7vJkGjXm6sTHq8TORDfE4pC9vzGKiX?=
 =?us-ascii?Q?7DmxjthNGzfS9TMaiGG/BFofi955PT0f2PrQrl7sclw3NPxJT7Z4Tf3Ln9sZ?=
 =?us-ascii?Q?6rBHJVeg/+QSXufBobxP6HeS0JSGQPFnVS6i4Ccx5FPzALNOsWhGLbJNOVaV?=
 =?us-ascii?Q?nJCRBYMYcsWQ8MRIlPwThRT2qOeAJqCS12hq6KaOJAl4lHQXEOQQXBMQKG/v?=
 =?us-ascii?Q?pzlU1F4R+hCNGKRU3gHiZHz5VdaqmKIckMuO3TrK3WDL3oQf0wgPhYvEuSWC?=
 =?us-ascii?Q?PT/X4JnCM1n2UwLQQwWcOGBh32s/a9QX8qJUx+aama0Z3f8oYxP2qGv1qYtO?=
 =?us-ascii?Q?yWwQmVUWzpZR4MNOO13zpw4fCJSewicAbUy5eEmRLlPo+AHjG9anuX6R4LAI?=
 =?us-ascii?Q?ivR2FZ7dr0LXu0iZx/zXTK9yABdQKfhVkzEF5B9H/zymttErnmvl2UFpeqj2?=
 =?us-ascii?Q?NZ6rR5LmvvUPFM6gG1w8xNWLn0E3ueUq94bo+1Dvsp7vIfgJBxARTjJe9JUS?=
 =?us-ascii?Q?ZlXsaM8AedOPHMt5FOKpAUNVoiYmrBxzcmloqjF/4JHd5Aw7MjOMt0J3Bc2t?=
 =?us-ascii?Q?C4JQD304ofxgM3S4H5UbvSy2hcNBVEdXFVCoMCPxbO/ri5IGs/fg0ISWU1jI?=
 =?us-ascii?Q?RVeNLyDBHOY4vUJgvU82URk/BUgDAatx0yKReCBwS43OZ3/At3PA7BZku8ym?=
 =?us-ascii?Q?rU8GgSVouj448G2s3njJWMYkeYKmUbwrHMkvF0Rj4qud5pt6/etrPyKNMrMK?=
 =?us-ascii?Q?W4AqnqkgL3tjTofe/VaxqVneKpYtFui0IDFLzYpVlD6WSH3n3S7fP2b+50RG?=
 =?us-ascii?Q?F2Bbm0zPofOV1d+S09DdJ7tQXhh5oo7u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UObnrcJRlfdDlbbHUiiFeIaYlODKVNHOzYKtIFTlXbWxCOuUfN9QsHEDuUBm?=
 =?us-ascii?Q?L08Bp4Y36RTUXi/oiNWRADGXyBqNiAvljZU619u3+PUbBN0mIrv00ira80Pc?=
 =?us-ascii?Q?Ek7P4qFFMWEtoUd5e68Gq8Hx6aK8hhN+L5BR/j4N56Erze0nlNZItHgftXDp?=
 =?us-ascii?Q?qroE2AgopTslAitIuCnNiNox5ULtSzgEx9twGAkBhCAx62guRuwYneNZZYXd?=
 =?us-ascii?Q?JrcWUx1JwFLUuuH+PP+GSFIcFLyD50nF/kpregCfEsoS5Sa9v0u8cLilEs/V?=
 =?us-ascii?Q?TV+xkm8+UPNPYwpALcvTcaP5lPrtYqlRAT6+2JcdxBfhLDG+/jLsX0XP6e4B?=
 =?us-ascii?Q?xtmfmVN5Fd5AvgJnyIUks/DcEmUBTXvKni9HacLmUK/eR+PEwS9q8V/pPTvo?=
 =?us-ascii?Q?wzvgxErOhTXkDYF4vDra92+aJRhh5eCGZv1dJMk+V5pVR7o9uD2pNrP+nKA4?=
 =?us-ascii?Q?SL61HuvknyOBxxXbw0DvvJ8nm239twvrWvDnYfwbkBFv01zHStQa7GWSRIq8?=
 =?us-ascii?Q?4UQlfaQPE4ch5s3JPr4bjiChvoYwe69g8u5w2MsDjxAhpTMGJzWUJBNuYwf0?=
 =?us-ascii?Q?iVrjI2xEDPySyudgqJQRM/feYNs82l79X65IoqTBV2MwJRedCzeleOzxVGIM?=
 =?us-ascii?Q?svz4vwOeJrETjXGUqv4fsl5vJ+HpsPIkpEEPzk6IC9MtZVuiYjXsp4dsN95i?=
 =?us-ascii?Q?c1gRVazm4CMAxu1Xae4E9bzRZATJo3uz734FIMgAuyPPPOAQrhfPJk1pfJgY?=
 =?us-ascii?Q?I5R/Hv/QdpVHFxRKfJBJlrqQz6xrUgeVjLh/TF2Kgj1CSNTe6aKMunpW00iL?=
 =?us-ascii?Q?C/J4sXUUlOVsUDgP86Kc7ejbRBq0YCWUPjk6JylbelfVXpGlu4N/cGzsN5I/?=
 =?us-ascii?Q?3MFNXNd9szpn96a3+8ifkbqUt5XzS9zsL9Tf8ytYsx8vBu9+H7t+nf5dIh/k?=
 =?us-ascii?Q?31p7SJsaSF9OWs1Wptinst7ON13cxhonLCuHNRynnYi1Kd4CF4qSiuNqZzvS?=
 =?us-ascii?Q?YWeiKr5z+lzVXWy03/Dsl5uj6XdN0YgUMyBYZUl7SbmWoYMZ6hTcUb5nfOO2?=
 =?us-ascii?Q?Svuc8rjMCgsXnKgOyO3G/f7dmxFvg0Md147mo97xndOd8/pACQKGUOaNfi7k?=
 =?us-ascii?Q?RpM1+RiDzyfEDyxoVWCDa0F8zjuiPdBOm5AoTUvfsb53WH3nbTyfZg07qQgN?=
 =?us-ascii?Q?XoLO/zTfvuW+ivSl7VQWojWrwQOCtmH3jnTzaj4Fl969PNAwcfr7JFWf/Ok0?=
 =?us-ascii?Q?Uw8W9NuqXgtYuPLdRVfu7fwX+oYoeF2/0c+/66Tv/fUom6jdIn1tRffi1auo?=
 =?us-ascii?Q?j9UNJL2T0wWrdXLKG9Vuk4gJ3aiwrLloTq8rP5wsg4mcbukaN0zwLqVZaeEn?=
 =?us-ascii?Q?LHskrjGSi5JY8OWM3UfsKUQNa+PzxH+IK1UxRPI2v7aNiahVzakD1EGW2J+1?=
 =?us-ascii?Q?ggDeDpoSnh89dbxZAogdZeHUbeobfXHMZwnt9zQMURzdLYFGZSyIoZqiduQj?=
 =?us-ascii?Q?o+d0hlGQdBI6JeILg43VElV5XpQJv8Ej2s/Rg2FOqEJLzJu7xH08nSVHZkoq?=
 =?us-ascii?Q?m+za3wRYLfQIN7qQDcgIRUY/3SMrZIWD1q1uLgktnj1MXTIU6dL2ERQOhl2D?=
 =?us-ascii?Q?8iMwr8sdIlz2yeGF9teAdRbFjt2KQTRXY3xw+y9n/k2L+eC6sRstuHAWVn0d?=
 =?us-ascii?Q?Ihnw6aJGqnfcktn80I19fxcJEmmIG/CYT0u7nDi9/o+VzoKi+jzOGrXX36Om?=
 =?us-ascii?Q?9cm2fTGRFapaOvP3R0k0WXwuYcC79rg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X+jol++rO9CWPSccNhbN1oEACX7e8/yqPgHOw7TXdY9BFsi3MzrNU2KNsrFbZiqLksGd4IkmZi2I5dnd80cEIq1yd4h8K9SoXNC9fpTjFrb9YcRPTieZYmSrZ+x6ySneIKhqdmB8DJymdYHskHm2mnW5XafLVAVeoS3WOsU6h5ElJJHrZWfxx6Wx0CI3TlPlsuLx55CgeJF092yrcZtPWky1kzVVCQjIzXvTVYfmyEdMd85aBVoIdrnSTkfqc/+qdwiVwG2l36ke2rUijBL1jekUCQWsI7zS0GJ92i+HTxAnEPwqm5/uPzz/8ieUZy2GL9XzZ1nNEnnhp8TI8FcRpTNw79HAjOVDzRgsShk7jz1a1NNpD01NPbcAiDSjLhFD098Hbs2eci2IkBOs/msLp3OAF2rbbfMHHZi2I85UwmSfxa+qEBYdREFlisUTu4SoD7NVlVMSQ5j56Fr72dOXmcGJ/j1qQdf3eori2MxfVUB9PsXmo7ihmIcParYhWJcduYodUJavwteHQ2XfuNy1PpV0xGPa/pNI9XooPtlKxWY9NRMqODTw3KEOJKlOpYQHPqilvTV02Vigt800bBcol6+T6OKUuqEHlqYOom/sshM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef1491b-ea23-473d-3d7e-08de4d4a2dfe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:36:52.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLR01zxhr1aH46Mb5boh3uKKuxCJI9O2hIZNmcr0zjXQS+Teubj+5htkz/ozAbmI+kgQyvW4PClyYyZsiz2UcKgWdB5LfceTJ+CBsDNCULw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=708 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060152
X-Proofpoint-GUID: -1Hx9HRSXeiNviiQIH2Vs_zMni6bGwDj
X-Proofpoint-ORIG-GUID: -1Hx9HRSXeiNviiQIH2Vs_zMni6bGwDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MyBTYWx0ZWRfX+nFr/fc5Yz2W
 4XSJUD8Rbtif/csCc23SOVLwbgsmpWexGviOs20JMMBL/ljLEgCmH2LsfUODFHBQwMmO1BdoJS1
 QcUWXBdHzyej+BHtun6tDGAYfSyVyfdPDs5gXqz/DA9rrFApzmU2IuNDxAfyTaY1o7CRg9usGkX
 f/3h5dF22+p0j2WN7xwZFZsuWEDcknQpIdU6MJCKp7y0gFokdn2yJ6NIIP70GYdyv+T0sY2ui7l
 Ia6YfYV4EHquMFjc2gsTu/rXNlgui6dIB+FUzNLlzel696m3hq/B7rKarV48iosUGu5nKaSlORH
 BiHuJijFFfD0dBX9wiTHwIcDi7F0xzc+N2byGTsiERevnwsw+HJfYSdTB8ApuE9ANQQMozfFSBM
 GV7Vjod5qFdkSoP46TxXLqbddTPPi6LQu2wLURa3tSfG29FwyUfz+3jv3NLVqGlzAxhTeQ8gIt+
 RwpciSG7HH8ka6JpFSA==
X-Authority-Analysis: v=2.4 cv=GboaXAXL c=1 sm=1 tr=0 ts=695d4838 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CsbV5m2PV3gDiFHaLRsA:9

Hello.

Just a couple of small fixes to get the BPF selftests build with what
will become GCC 16 this spring.  One of the regressions is due to a
change in the behavior of a warning in GCC 16.  The other is due to
the fact that GCC 16 actually implements btf_decl_tag and
btf_type_tag.

Salud!

Jose E. Marchesi (2):
  bpf: adapt selftests to GCC 16 -Wunused-but-set-variable
  bpf: GCC requires function attributes before the declarator

 tools/testing/selftests/bpf/progs/free_timer.c        | 10 ++++++++++
 tools/testing/selftests/bpf/progs/rcu_read_lock.c     | 10 ++++++++++
 tools/testing/selftests/bpf/progs/test_btf_decl_tag.c |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.30.2


