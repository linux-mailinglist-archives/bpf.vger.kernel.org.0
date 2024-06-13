Return-Path: <bpf+bounces-32094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01263907672
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B9A1F21925
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDB144312;
	Thu, 13 Jun 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUaOLWFE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XyXv2zNj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2E1494CB
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292072; cv=fail; b=XdG/peORxFZRZywB/3wttvZNweGhugMfF1a0es2DGRB03eOY3Bel2jDUjc4minI5LFmzdaiRnU6FvvrSMJ4WWae9Je24YGeYgreCTAs73eV6ofmqchjpidX/5U5HwgSIu2HOhRd7I4Sb0TyfjhjNgdRBgKYAeAlvXjjKCmklIOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292072; c=relaxed/simple;
	bh=WaNV9EBKQLkxDrpOZr0bnA7R8OzatPcD/N5OY6rEngg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpGCFDYX84h+eCVROjvptF4vSx9KX3NGImwf25SzEhEm7cBM7sihOuq1MofHEWr4dD9NRViQS4NY3pXr66iA6mUJN9xeC/HEMv+433dy5sOPi0l1Nghyo0o/kSuNWh1+XiICQUJnvVZcJwRubXImG4WIHtMXdJnF09ccrmaC3s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUaOLWFE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XyXv2zNj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtRqY000896;
	Thu, 13 Jun 2024 15:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=jwynrXkWTGzOp78/9VwZnsuFGWwL8Obuhh3tlE+KziQ=; b=
	FUaOLWFEcIvcepeVXVaFWQDzLAiqOr8LB4Jpu2lX/FaTIGHk6+b+764obJGMn72r
	iSW20Rm1VmwbD6V82IMUd/Ji6cqmAyYDEgrK3PXCAXkKQT8twZnov4emvhm9m8ZF
	J5aaNSw+obQ9kf5LxrCUqAPOkcWBpsYI8dj6CEGLBt1/tQXxfqkixgnl8ENyiq1H
	A89ajTpMehyjSUk+CUvGzjpVwFIImgznXope67rker3mzd/AmLuDw5tXCDO/ouCy
	SZPI8K7CvlwtUjAqWVhSU9YWXc7wYsSuAIggpzCQ7UXOviku6ZJWFWCb/wQhusHT
	fEbnYjvz0HmK/tp7gnroHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj9ufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:21:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEIxK7027145;
	Thu, 13 Jun 2024 15:21:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwd5qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btCwfiFJxMYHHxXMFf1esnPexHQn1DBlZVIJLIWIpllSOOTCq0GzAH/QgqggdcJLULEBaH5R9ItMSsrT+//Ner9WwKCzlH1Y3+N+xspb604hnuyLZWD2F/SKtGGVuOYqM39GqedK4t8NH7n6Yugg0XRzLSBLlf58XFMPwNuoF62C96IcmyQXnw16KiOE5HOYxBv7uKS1Ii1OC+FO2y65LpR7SB/uJmZU7W96sptBOHmHhZ7yl3+ybfuoNAZrJB2VHWPbnGQAfnU3G/LwwDyvl38/UMNww+Z+rpa4yFhfBJmEk7/Fm/fZF8NqoTpSgUoLd4z4d+6Af6IjqdHt8zO+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwynrXkWTGzOp78/9VwZnsuFGWwL8Obuhh3tlE+KziQ=;
 b=XI5GnE1D8w/W1B4HGPcZScUbuEN0otEvZbEZUD5Fh8V9IiNMGgsEon+4N8Rk2FztU6GdLgcaazV+evo1mmCDM/0mdOI1QcvHAph6itFMNsHmim4MnrpCchZneIik+bztkMdgFICQzF40XtLtjZctCv8yeFYslSuUyar0VXPcELPtKyI+GO3csC31khiMswieUElRp0sajl9wl7hHUp9lg/Ok0NLCQ3gCGkZ/y9YsGntc394UHjTjivGfG4fd7DaShc3I91l29O3ahYV+EmhM59ziF+pv6DhF9d5EBSrSn5ZFdX7S/BVgaXg3JxKhX3CnyW3MQPPkgPol6AssDSYGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwynrXkWTGzOp78/9VwZnsuFGWwL8Obuhh3tlE+KziQ=;
 b=XyXv2zNj27tRnCGoX5Gzd7L9QiWPUZ7lNf0cIZ05J3mrapNAAXrSkPU6ur60Re1Jq3l7+clY5D/X1UOw19hPWj7POJ4ZHj+nvpxjGB7Dxp2iqmXMoRvvqPhBJE8hYKvkRabypqujc26XQD/MVjVkWFzfKsJ/mzCl4fnsrSApNbg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:21:02 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 15:21:02 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Match tests against regular expression
Date: Thu, 13 Jun 2024 16:20:37 +0100
Message-Id: <20240613152037.395298-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613152037.395298-1-cupertino.miranda@oracle.com>
References: <20240613152037.395298-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::6) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: fee6511f-9a12-48a1-2aa8-08dc8bbc6fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gLMMA02OGJn1Bbyn+kbm/Sxrx3JjFiC0hdlld46kmhdRzzy0oUC3JO30H/Lk?=
 =?us-ascii?Q?2djB8O6fh4B2H1rd3OmJGFjgF+ywdBetg6NtT8HIzWsZ3+METkaOSW32dP8u?=
 =?us-ascii?Q?ddMv3huESnebf9K6CO2k6j85jMFdGG6ttHBfA7egITe+tL+Z2cRVB0sH0aym?=
 =?us-ascii?Q?VmkZ3KHUTJQ20tj6k8wTkbAU3cttoxl+bkO+v5cifmETWadmkbC+q+cpXSPK?=
 =?us-ascii?Q?xw7mYZCciqY5BVn/vKtk6jyQ8NzkKBn48I6r/0vp2UQr47ez1kIMd7d7Orba?=
 =?us-ascii?Q?Kq+vlWnBQa1B2ieF3yD91hlxgdnJRknsWy2aDYoNSELs5CO/1z4+R+EVxojn?=
 =?us-ascii?Q?ZR3CozMIHSA3Nyd5Y1PhSgr+3o9+SV9J/72FfYyU/V5I+hB8myoOHoHN6dyi?=
 =?us-ascii?Q?dV6QZ3l/3FJ9d21g7tVQDfs9h42y4kJeeCqqSUSH3ospPGbAC5JmpP3/6SCy?=
 =?us-ascii?Q?tkt+Ry1mch5cxIcBuaJo7W9AVEYRjeO6rJAgd8B1uL4tX/lFQCWp68ray5Hm?=
 =?us-ascii?Q?57XE9uAV/COjc+MFmwwvvxnYWAZQPXEDWOO1IJB0XXdWivmNRfxAMdDd0YyL?=
 =?us-ascii?Q?j8FjUNzbUW7zINIsfQIrWzFuIp6EoSMvWgsEu5FrcSPXCbMje3evnTnI5Nw6?=
 =?us-ascii?Q?f4rrJB5oht0jXoq9//ED+gxE/YEGaOAqEDCxq5WHcD5mdtMQYjdpHgn0k1RF?=
 =?us-ascii?Q?xYGT6MzATehOcy+2mj5SaM6Ol20Nc/mAdaNHLr9icegCehvbqqkvMYECUF5c?=
 =?us-ascii?Q?nDsC8a86Ra//5gCyx2AHz9rzv60Fhbfm61B8hoJo57H052EBrzt7Zi+veV6E?=
 =?us-ascii?Q?FhU1J8FXRTZNWsJOsFvYzCIkd5cr7lnYA+Qr67ZW4koLkXmnnNPbtzwmMWtx?=
 =?us-ascii?Q?WoRcIPSRkCLnOt5aItK4KPsoEydR6BplEecvZP56pns9tojEOVy1RqpWg0mF?=
 =?us-ascii?Q?8GxNgyd7GfxMFV9z2vn6hS09QwrQDn4eMMFh8ZubJNvMfyAvYvr5/WmZFWhq?=
 =?us-ascii?Q?QbU6C3lLB6LKu3DH/KottqLjXstn6a3eB+jauQeZhBYblYFmAK827x1OaJd1?=
 =?us-ascii?Q?LNiXa1lmDgmMtz7wagOhIVJn/yt7lvzBmDDItpVqrwzQR6l1W70wHVDBOkAj?=
 =?us-ascii?Q?6me1oDh9UTjhnaT3N60oMBdZceNJWgdyLtSWYFobn6nyXOYPtLk5waPnYiPA?=
 =?us-ascii?Q?fcu/I0FOdMu6yfyuZ2Y95jPFJBft/WQz079nJBrXz5/MgoSmaSTqp2LyvDlb?=
 =?us-ascii?Q?bnrP6WBdGtRyrwX/c46W3sXARaWiO3rKgv3ix4zl7zuFPkJuv0zuvhEYXuNx?=
 =?us-ascii?Q?X7jkyL3fcfgRLEGGu71hC0ou?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4dWud1FvgQLds0u3CT6VWleGLQI29CCvY9a7q4DJrzYRkNSTnrFR16TVY0qW?=
 =?us-ascii?Q?xi4mEtoxbu2MNCNBl4rcBTWTIDrFBOo5L+CEyyvFb8QXwycFipRbwN6P+oPh?=
 =?us-ascii?Q?mD+OScvaIV2ziWzBvAuaUAd6PfV0CF7zUaGXVaAgbqOQpwE0GB8iG9LzOkxH?=
 =?us-ascii?Q?t07Wcc3/rkzpivL6cbM1nsA75FIZvLTZqcP5c17ax0fCRhyVToKpRTox5cuv?=
 =?us-ascii?Q?t1YC3P0BlKgN9xp/U7jUheel+nRASrcYIGgJrf4m1+4tPA3Ez2VenszjgM+L?=
 =?us-ascii?Q?NJt/KV3GZrBiib4AlXRMpU3NhMREhcM2yfIAm6VANr8CHArFL6RdsGzKkREZ?=
 =?us-ascii?Q?gY2Bu25wnWRhGvRYN1gC4abOX+Nya0WtKUp38PqSEyVMj2Y4L/KXoQ0s/a2i?=
 =?us-ascii?Q?ahIexTtCCu1BjuGIo+K85WDtRnQi7ZpibSwn7WouPukwHwu1+B9BjN5X7VqI?=
 =?us-ascii?Q?8u1ld2G98cT3xSMIZuztgo03H91blYAnrv361ZEsPQnVVHYIc+vxrRhKMmlH?=
 =?us-ascii?Q?bQBJjKGQ6ojK4LMoqwAxh6Gs8ynUNW62RAlMqo8YYewVYLxZftPR197CuQLG?=
 =?us-ascii?Q?+mJDV9VPYOP2NBMYeJDkoKkkq5Wf8Ca0BGo2aX6/Yw05SxehjlMQ4Ay4mljC?=
 =?us-ascii?Q?mSySv4h/UXIdehcjQmMby+/T52YKNS1vErq/aKMHaXi7wc0+Hi2i5lUfFeP9?=
 =?us-ascii?Q?azPaZ5ZA1N+3R3wOcGUs93bq4grfD0PEYOV1NMfvZJvN2Gg9sOFhjyBGwCT7?=
 =?us-ascii?Q?Py6w1r6T/pMQseS+udMXNvGeXM8usDne06ItoY6FlNEyjmS6Lmc3WUuaAo2j?=
 =?us-ascii?Q?esKPdcYFrfnClfl8ElIfHDQ09OqHE+EizwAHG5DKFt4s5T9fcENvssd4ABYr?=
 =?us-ascii?Q?zqThBJWoKtzNiEwvzq/7ko5AIbAT9hoZJz7OojRz6axzBHaCFMzgbvlqytzh?=
 =?us-ascii?Q?ojnblShD7z7m4RDmhnY4xx17Xwx1+W1+bIl+dGVf7paVEVib0jhYU6wsHS6P?=
 =?us-ascii?Q?Ma14dNDbz7iUnHHy+TUL85/4HGvxb5d/SjAW4KXZu+SjCqmpZQuMqQCXXxHp?=
 =?us-ascii?Q?7Js96+vdmBVEljyjF2n5gaeZw7hidXbLK8MevIqrkl0tZ34cb5/hgaz6L+S/?=
 =?us-ascii?Q?ZXiI53wSB0QF/4xetoOLcIx+MZ6i1/C1F2Hz3Ttq4GyGLKNpe/lEo3MpFL0t?=
 =?us-ascii?Q?L7Y3lu1CKdlMqoI/VoH3wKFVzD4JINoij9fLFhMBPyUx8cGUnsv6ToOsoc8y?=
 =?us-ascii?Q?GWq3AMgF4+12or+nQfe6+4dWH3JpHWbEG0W/mScwIvm0IL5lYnrPvyHr678g?=
 =?us-ascii?Q?JyPnZ+pIvv9Wq6uyrIxJApj5Awbbye8UcUpleJQov0eE7nkAZQ1mssg/QkH/?=
 =?us-ascii?Q?cZJU1S6NbfzxqdnrN81JBPh4pvwSItT9F/tklYZQhacnzYOEGSrn6u/x+3ER?=
 =?us-ascii?Q?J4eluRTrUaPZpf643dvr/n90XOxIL1um+ShWO4859Lfm/sInKgwqBZ805iLf?=
 =?us-ascii?Q?nn3LzffivaEK0gmOUr+s1rNnOwhWF4FEA5qrFr74YWwciAZv4K1EGFYSZKZ7?=
 =?us-ascii?Q?4GZ9frYO3iIOvOwgXVtJ4ziPPEsc8/d+LU8ed0AnCJMGGQPHz2hW6GfmFz4w?=
 =?us-ascii?Q?VGiqZ+1roqKc8ED3uNExJEo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9hm8zkKMBMKGsg7jmgTDa0xnB0n0TUNk4Smgxn/tcbS5zJFZh9URZco6qGbN5oe40vSJneP/Gs/emFh5oyyBlPf7VVH5P6jjnUa4Dmh9rYXzGccdXi6fG0oIdy+ilbPNzHrIVCFOLUPVK11IUG3vdAObPMirxpFIX0GzvH1iuaGKMhap/JOQoPZlqr3iHeeXIsP8G1HSJ1dikHhcMtIOB66uXJOn7/l4Qe8HPCbBAzVcO3rFjj673fYHmqFQc231hBBDQX6PrGP4dut2Aq/0pqdHcrZkY19cBNuBjlrmY8WKG790q9dXdSN4rUnhfFLPChzKf8s01pYa9zpsGnX0ZfvSkNocTptCkgDeXpEFAaWAxFzcuXKiHYCTCElkpbKUwQkpoOQfao1R+6KRGQrpoEWDLUX/3Qoo+LUM+SqxE0OiGc+YocqU/mqmR1W5zXUjXg26KVl6CTor6nc2XPo7fMBAVlgVJOlStbve9YG25d4UQukEsSWcv/JQ+KgjrwXa0vBBGWqB9FGs+C5M72s/vd1V4xWTF483/MjnK6nOC7tP9+B5tsWEpZETm0xHF7wJpSpESAgYRtv8VjfPYAExrNlbJLUezbk1l6yxzgBu9xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee6511f-9a12-48a1-2aa8-08dc8bbc6fb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:21:02.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrVwJoAmxyrkuB6XF8YfsGo7x7gpUSmxgkFAvKuj9Jt6+YGsxX6+VsOBbKR6ljWvUal1uNEtaXe5xZ2DSrklTH4wMrp4z9hT8N8txsRgHPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130111
X-Proofpoint-GUID: bJQFqf2iYC9WaD7OrbCCFHS-uLdjbmqB
X-Proofpoint-ORIG-GUID: bJQFqf2iYC9WaD7OrbCCFHS-uLdjbmqB

This patch changes a few tests to make use of regular expressions.
Fixed tests otherwise fail when compiled with GCC.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
 tools/testing/selftests/bpf/progs/rbtree_fail.c          | 2 +-
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb5867..64cc9d936a13 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
  * mem_or_null pointers.
  */
 SEC("?raw_tp")
-__failure __msg("R1 type=scalar expected=percpu_ptr_")
+__failure __regex("R[0-9]+ type=scalar expected=percpu_ptr_")
 int dynptr_invalidate_slice_or_null(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
 
 /* Destruction of dynptr should also any slices obtained from it */
 SEC("?raw_tp")
-__failure __msg("R7 invalid mem access 'scalar'")
+__failure __regex("R[0-9]+ invalid mem access 'scalar'")
 int dynptr_invalidate_slice_failure(void *ctx)
 {
 	struct bpf_dynptr ptr1;
@@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R0 cannot write into rdonly_mem")
+__failure __regex("R[0-9]+ cannot write into rdonly_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 3fecf1c6dfe5..b722a1e1ddef 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=10")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 1553b9c16aa7..f8d4b7cfcd68 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=4 alloc_insn=21")
+__failure __regex("Unreleased reference id=4 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=9")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 {
 	struct node_acquire *n, *m;
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..450b57933c79 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -799,7 +799,7 @@ l0_%=:	r0 = *(u32*)(r0 + %[bpf_xdp_sock_queue_id]);	\
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockmap, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockmap_key(void)
 {
 	asm volatile ("					\
@@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockhash, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockhash_key(void)
 {
 	asm volatile ("					\
-- 
2.39.2


