Return-Path: <bpf+bounces-75383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B3C82007
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D28E4E79B8
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8D31770F;
	Mon, 24 Nov 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CC0yItpU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MCSZkHlL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2413176E4
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007255; cv=fail; b=rrrWOt6NOI08Qx/F70u/QqqdPK/NAfvREJIekePdGxbwZR08UBUOoh78+Zhs5wiWR5inVRnX8D11TwyYtdlSfapTlb6q+6n+x5F0j/lQ1TI716O5j6edBgiyAmK0T6sPhoSOI2Fa6Ijb6IBzxVyxid1iGD4sr6X+wNK2YtWCZnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007255; c=relaxed/simple;
	bh=ysl7FTnI+M/AFy3x2gjWruxIVn7hAx9YnWmIKDePoyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t35gOtSz0z0p8896drQdb5SpyFKQ7kkTTlHioQrTn8yvifR97VSzchjylpskIIQYXnEyzAfYZXW3G1pzIlbU/7fiAu6T/S5Nw+pPOvuoewl7zPFlyxEJX+4s/Gg6YVW1xdTVWk7LbyFhDVXytjCk7o2EXdMSnv4oWNr9GWY33J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CC0yItpU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MCSZkHlL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVHEO1084749;
	Mon, 24 Nov 2025 18:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z//FDfB5DbBkXQ2/zrjz1alTt3CHZ270CBGZ/6xg7vw=; b=
	CC0yItpUDuuZWZHqOcAe6bU8s4uVbnH3yHIXnucT9UcnFOSZrPF4KybUlWswnmnS
	Xke5azHDtLGIoRYv5L1AASfQERNGvD+Dc5Qe+TI8yfwUr71jcLtNtFMxM5af4HF3
	5BgFQWrVyaVlTmiZwGmq069Nn1hzv5pLHHqzKoWxMInwpFOgM3ENMMJCudtlB0si
	sDDpehKnkalm0Pn3TGNW6wgiBCuVf5YGGZHqeQxidSiJ2egSfPyBqwhOWxyAAiQD
	Fy+v1eLYjfZJBJIqmrdmAC/pXaCG5mTG6wHP9CCpqtZqqQj+bdG1XjFIjRx1shSY
	RIslZ51JFgCBsKJCw3oesA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhjjk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOGuAEd029669;
	Mon, 24 Nov 2025 18:00:49 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mbx9pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4bg+YkFuvyIdBRn/JRm7uvUKElZf6IUYeb0w92FFb8XvSdcpr7WLX4FH2aPoqjGpzLmMcdAWhINCGu6yNnzhdddUKYiqjTywQng0S51dmTyVSCK9meuZSPHMmMxgXimuRpd4KYnNRQjulo8HuAYlG+fkH5u/Zd6MHfRrz3TC2N2jEW32Qrp+z+SDJHPDLlv6BcFyxUq2A417it1MhX/CEmLraEVd5E2PXrMHkUojCqCOghIbwXsCi4QcOSUoU9H2YaWooVbUCcZ+gikLeo5KgeX+uGN3WdzvB2S7NlQH944XmeTMSh4YsNuN48xilfywmtCzVv/IU669Eu4uKXEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z//FDfB5DbBkXQ2/zrjz1alTt3CHZ270CBGZ/6xg7vw=;
 b=xH1RmzDQIddYXrbGYZXeTddGD5IXifLkTALV4Al3L5ICKGp38DrzF0kE2p00+V+LNRB/MFDYlbduodRhB/8VL6N5TQNNgdOueGso3MT6rjd7bA+xtBxyUUSBPvJf74Ad4j2wr7/9Qp0M6UUql6ZnPS/BsRFu4aoCreTamYzutuFrMY51vynqR6bcpPIJDpi1rySYaooS6P6VgR7Gj3AAXhC/pC/ZeKj82t5TRAHrXRcS6kMgN28RHEAjz71bOHvcxfh/bPQT/Z1QxC2JqylbHFAJ4Q2zOiKYr/EitFoTD41Kedf7GpL9VQR9hAvgooaMjrx58latkfQZjp/JfzBb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z//FDfB5DbBkXQ2/zrjz1alTt3CHZ270CBGZ/6xg7vw=;
 b=MCSZkHlL9vc17ovWBQBMDExfrcArdVqwtqzb5WILK10BEf8Ma+kdFfdDs9N3j4cpgQFb1oo74HrlR1YPlOWS4fxg5O3ZNfIaJKAROSU83QDZk77c0GPTsuWbIepd7oRfDIRNBEWqlZvFHIrhTQlEQqhk+hPW2o8gR9+byXHvAqU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:00:45 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:00:45 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v2 2/2] selftests/bpf: add verifier sign extension bound computation tests.
Date: Mon, 24 Nov 2025 18:00:13 +0000
Message-Id: <20251124180013.61625-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251124180013.61625-1-cupertino.miranda@oracle.com>
References: <20251124180013.61625-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cab01b-fa11-40d1-f53e-08de2b83638d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KTuaDOA1ooRyZo8T3vwrNNNBYLLikc9Vujs3vKZoLnYnk3rTBCK05Jrm6mRQ?=
 =?us-ascii?Q?r+wmI5iylTXtqm+6x5TDmzwmuJODs/2NPj040ftRUwq6XikhHO7ojeuNvKlo?=
 =?us-ascii?Q?Wy35S59LHUxGVzlUaqGPMxXKo1Dbw7VppT7mpIFwgIgOzUGrFwlMOXAjo8Mc?=
 =?us-ascii?Q?jLLsIvJh4N2mjdOiEFDUZbncOMK5Bw3aO1nR+Ww3tohmuFf6lm8WDj2bMDJV?=
 =?us-ascii?Q?oLZ0SnQ1uS7odnEUtYw6/408+C3/HXvGT+R3mXbMNG7S5viusk6FDPTsEG2e?=
 =?us-ascii?Q?FVMMb8qxW/cJu3xF8+kXa3oGe/jweSjjvbvKacGOIqA21omTVP5IPubdLH7U?=
 =?us-ascii?Q?Y+yQwtXMo85cBQHJjhE922btAKZRCwQt9m1EbccI2ItiR2nKE0B6xdMjGGdO?=
 =?us-ascii?Q?W8K+9qi4/ZLS2472flZ3JHrm6ctPgzBcY+YWKN5EhTaMSxlNqL/pIQPJXIO/?=
 =?us-ascii?Q?wcOqMUMO+r4ug7FiinLzfsGGj+VTecxXRPqsgJgJ3vt+SssiA7B3u9KIcp+L?=
 =?us-ascii?Q?hojpTPEpV1Wj7EWFAXeF1rRQlRtILmruxJifXpSRZQ80HX1LEqgWwyUwzct7?=
 =?us-ascii?Q?JiDrZ7khIRgxhqPpl6CLPJGCui5FqFA7o/ERLnF5HBcg04sb1IQyz6Jddp/l?=
 =?us-ascii?Q?ikkdDXBUcLm3kGWkElWFLX7QsRTWe5ToWg7rtDncpDwcoOSisIqgZhaAeMCk?=
 =?us-ascii?Q?6hZ5RN4K51YlvCA4WG3M9/54ppe9Iz76DT4gWrZKTIXeczbd9XuC793YEELa?=
 =?us-ascii?Q?hQSFO0PuQ9Fs17OeXVcNQG1q+4mzpzkE3EGDx2u+3W/uJ9NlVZw1xDj0tmMB?=
 =?us-ascii?Q?br0IEbHjzZVBldP9l6rtTVLDiyLqBFmWM14QO2bl3JgraUzYN9Crh4Di1NmB?=
 =?us-ascii?Q?8RvMVOu78icSojv2QUY5FSiYIo2ZDDytZ523Auh/MDxBfpoSQg16djDsyQud?=
 =?us-ascii?Q?iJM7SooW1WCObgwRMjYsGdNO+JyqGQn2pty3vAcniAptF1qDp1OzJ5/omq+7?=
 =?us-ascii?Q?Vg86EVZg1ITDIYtgbuKbR+NMTibAdx8XFG8VBvDkQ7u75PvrhVhHBZORbU0J?=
 =?us-ascii?Q?pHz33xcwSN+dqiToHZnQGE/2x6PwzBaQl6J9CfzQ1aXEd7pBAFpjpuPGEJF+?=
 =?us-ascii?Q?fnQ0omIF12r36RnCoDCIFnGXoZsYa29BaBnU6aOuOCExEWpKNsGUABCtQC6p?=
 =?us-ascii?Q?saL6vgJTk19wE0dppsG8Fyq3K3WE2OOA7oWANGdttrUJyAUbOYgwspsBVDNY?=
 =?us-ascii?Q?RJb/WSQSbZyra74u51zaw92bOyBFGD8JayAHATWqAmYziV5qiNPdKKsL5zU2?=
 =?us-ascii?Q?9bx8l30pjQxQwwUrUOKc4zQL3Kbre+VNXSlkj6mVUcVuOFgWinj8YFU0vM5a?=
 =?us-ascii?Q?MhcB1fpuzBhQz5esOLwkxNRgCoDfpM63CVywNrJzX4V/hnEXDg1I4sqTtdXv?=
 =?us-ascii?Q?wwevkZcMcKvp2YaeACxC8+dGkawjmb79?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzh39Sd+LKkaXKj1Nk2ePBevbkxrZHoLx2Tem+3NP7lJF+WI0ABKu8m4iYXA?=
 =?us-ascii?Q?Wurj4DWY4nLedS9jJGPAZi8raT8mT6YGfR+kJwhbfRjKX9VZdfLYg66dolaq?=
 =?us-ascii?Q?Zf6ZLugVAh+d3Zz1z/OX0aGVMXYhfC3k8TL4EspmXoJxO3Dld5VI9OIwRbGG?=
 =?us-ascii?Q?Mg1ZiUtXLhaZqzosYG3bKoO5q+Lu+Dw+xrpZqlQCq1wjJgWJmF0ds0OCYisc?=
 =?us-ascii?Q?a4ZVHaFK00mn/i127Vc1QJFX6ZNs1QF6SihylRnl6i9T5oHu5NABgJuZD5gH?=
 =?us-ascii?Q?ITKSPKEvvZJhmiGPx8pXccQtYTohhj7LMpA7zEWvWin+n5vsXXDHqw00OdvQ?=
 =?us-ascii?Q?fykaJ0n9jrjX+EA1GaNvq0WEk3CLNrNmG13eHBP7eOw5fejret/LT3U7cby1?=
 =?us-ascii?Q?SnWWqIRWFaL9r7yvTJNiRjwWV9oN2kdGf3AnXS6TQdvuSh5z5sApbs/n1LYj?=
 =?us-ascii?Q?yetTADN8mDxhm1QUdDukJ1uVBv7CVqUz+b/TXGGOMIB5QRS8hGkrc4R29vu2?=
 =?us-ascii?Q?N4lyGhrCz4Mg82dGozUSxtmMq6mPl33ge/uvGCLVIXBdjETMwb19PyLJ/GLS?=
 =?us-ascii?Q?se1+RynAe7cvk4h5cezJxDEiM280qfbMyaVOZkzFFHwJlgR4/e6STCxSS/mG?=
 =?us-ascii?Q?SmOc7xEO//jlpl2S17FIpc/CP6MDZH93lYtHZcXsQJGkxe8wWiakdF69ZdvZ?=
 =?us-ascii?Q?WchFFOWELNhB4esYNS1/YAWChwh29tnxJwbLlTigu/Chb+agzGWELRA/KTYB?=
 =?us-ascii?Q?UMgeOuCWgi1N8mzIxEdx3uEeV2ke2prtHT12Qmwc8LrUd4GHa+zO4j0OuEl8?=
 =?us-ascii?Q?nRBywE2wIbXDIQ1hYgRjHvUMr3IVBwgn9ggyqEYH2E1qbYuokIlfKjO1nY00?=
 =?us-ascii?Q?A+VCs6q20Wq7rkcte7rptRc6VFx8M0kfuZ73gAPsBy0+FGM+GiG0GmC38UuR?=
 =?us-ascii?Q?XBWSG5fl9pWYovN7wzytOvhTVhBMey8XJ9V/eJR/vywMc/AW72w13BclFSBU?=
 =?us-ascii?Q?3UVwG+RDKiWhkUWc5wHNK19tOtOXAoBJvcfw/UI1tkj5espRxDunb98o7x8F?=
 =?us-ascii?Q?/3QpnnJtpeTN2noxqC4EGXZ5h15nHaYEkI7swZ3HIwhq+KlwCZ8nsLnzolod?=
 =?us-ascii?Q?7N2q0VE/6t1p0bqRYCB9W/br0/RCDdd5QnZuKPso7CijsMpC2X9Pzi/cIynh?=
 =?us-ascii?Q?7qd0TGdB7mbrIlgEYuaR1JBxw+YvGk1uFDdoIKhA36R5fINNQanTFHfs+t3Q?=
 =?us-ascii?Q?+C2wXwp+iYOrwAEblCWdC9/DpbF4bRwGza5W2YsL9Y6aRM9IVUd3vaxki4n3?=
 =?us-ascii?Q?22ADxQWoyo4ybOymutOPmhHV++6U8rweG2mt4crBnFJp3B6GgLecytp25iJN?=
 =?us-ascii?Q?3jZQpX/ib3/UH3sUvAfcUAeYTsL42KxCHduxTXmhIuHOURp0z9QtXakIFiQC?=
 =?us-ascii?Q?7H7EZELnZPuY7QPPOmncd+ne5yOglz4Ak2k4uDl/cgVs0MYElwmCvV1ZTcbT?=
 =?us-ascii?Q?FwmdVrY5RlDx59rrvDQI0xTAinsKlcY5oPlM7wXwwjZzyxvLNxZL6m/eMwIa?=
 =?us-ascii?Q?aeorCTN3yhtMs73EGdfbcsr07pPtJPYWhoRkjrovSKDMsJaiYP3xWA9xAsmt?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Duoof3KP9rbWURbs0cD9xN0g1nsTtuU8+nNlGPuRemavzKcsJEbHMh9gvJTId1qnrQS4i1oR/Lm/uzDb9Tgnxuuefequ2MvucsgddhtD7eUXNfiFVystPkS0MrNKAs2kJCveVkghB74qyhm611clkvfnoPLTP7MmCdnb3e29fSSc8tg2Z5pp2Iuh4edyEZiVGIcPsaf34B9paBFz+OhgCfIH9C6SCbGSGrPtJgvdQbR68v5Tl7xhmdegZa5T2tIEQhopEt3pZgFDKQrnhAaCOrTLJfaGrIiSc/lVD8RblfCLl6KHS5gI5vdlP2RX5xEsqprGl2Z1/Z5DUdg0nAH/YaBUoZSpiJaJNLLN/U7g2sYsmug3G9lSlgHbtNwBIBeyK9jyXUnko0GVIYf4EWYCnS4o9OsQ0GwkvJCK6c6EIq8JLlyrG5AtdwQ17W2iDCE2YI8dIQP4juQnXGJehHOw5RT4/TEITEeeLn847+J5oe2MDQ+WboOWbcq8HPS1CP8JlxuIHuauIIVrG8VbE8dJO91LtgtdArJVk45P9oFsN1XycDn+8ploU1P5rCSBKSWOjT6/PuElQIU7USvEbEhx05BNGQIHc6NwnPEdsyneCK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cab01b-fa11-40d1-f53e-08de2b83638d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:00:45.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET0AMMayJGpGbeBj/hCte1O/jgG75Kqm+yXUHBMPVs8DnF3AdmGq4m1Yb+g9B+dWTKDet0SiB3PV6gv5zflMdJmQNErlBSEgaTCz80IR5Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_07,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240156
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69249d52 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=YKY8qPteO0UkzRZ4YNIA:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1OCBTYWx0ZWRfX4yRIw1BOjqti
 aVq3B1XllWsmpzqp40/ivzwqgptLHqrelDcpMbTZYb/0AZWW+PDpWRf7I+tb1ZLhLVYgdE7FoT6
 9VQ5/E6rTqysOgTljVwkOfAds+M5Pwelk7XdPBvCzML03J0KXw5gShsGHqp6CEzCqUbHsxjytzi
 4d5O7kw48nmzAYjdpssI7fvM6YcPfZmtVLBDwMkdDYd8lA0l6TLYBAGFXWDJVJnUgsPeswa2PfE
 y8N1M1ZBvYy0NvRsTYIW7LjkJrsH3OIfVoRWCcOFLemGxmVcVzKrkFuM3dJJCKQuUWCg+Mqj4Qc
 /HzFryrtPvDnJ7iBz7dE7tV1OQf0vjNVmvyBd8pykCb83mQ7lXvs0oV1vZA3VcrvtmZbE8MBVmT
 dtM4ov1NTJcNlDVeyXS3cV8VD6vjS7q3AC77WSQCWBlJ4IHap9A=
X-Proofpoint-ORIG-GUID: HlbzUp3ap9eO-0Qbwk7rziFBQXmQ6DPc
X-Proofpoint-GUID: HlbzUp3ap9eO-0Qbwk7rziFBQXmQ6DPc

This commit adds 3 tests to verify a common compiler generated
pattern for sign extension (r1 <<= 32; r1 s>>= 32).
The tests make sure the register bounds are correctly computed both for
positive and negative register values.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..55e56697dbc4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -531,6 +531,76 @@ __naked void arsh32_imm_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("arsh32 imm sign positive extend check")
+__success __retval(0)
+__naked void arsh32_imm_sign_extend_positive_check(void)
+__log_level(2)
+__msg("2: (57) r6 &= 4095                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
+__msg("3: (67) r6 <<= 32                     ; R6=scalar(smin=smin32=0,smax=umax=0xfff00000000,smax32=umax32=0,var_off=(0x0; 0xfff00000000))")
+__msg("4: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
+
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign negative extend check")
+__success __retval(0)
+__naked void arsh32_imm_sign_extend_negative_check(void)
+__log_level(2)
+__msg("3: (17) r6 -= 4095                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff00100000000,smax=smax32=umax32=0,umax=0xffffffff00000000,smin32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
+
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 -= 4095;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign extend check")
+__success __retval(0)
+__naked void arsh32_imm_sign_extend_check(void)
+__log_level(2)
+__msg("3: (17) r6 -= 2047                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff80100000000,smax=0x80000000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 -= 2047;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("end16 (to_le) reg zero extend check")
 __success __success_unpriv __retval(0)
-- 
2.39.5


