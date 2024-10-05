Return-Path: <bpf+bounces-41039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22E99135D
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 02:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758441F2470A
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82129A0;
	Sat,  5 Oct 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oARtQrFa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YxwlxpHC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5386182;
	Sat,  5 Oct 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086517; cv=fail; b=cdbaLqJ0lpMIEmWA9S62zTnXJsnQWeDYwkmPvrA9644SL8DCtgCetlbkrxGJ3FJC54J1P22rcYAU99Lru3oNYsEcQq3WtCyvm5AWDJAhjuqdXzlvu6bFWTBjvmVWm31R66SzYEdLKQyjz9DbICNhlbdRN4Ty+x90Js4ayJbclWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086517; c=relaxed/simple;
	bh=nyw/pfSaqzwDOdTrVyPLK7D9feGF6SKeIEStxDvST/4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mFXxbsG1zmJnyIt9rc/N4lIUkEAmHbr3zXFo+zUbdIKEn4wOvJyvETxSqddAvXmvUCY8M/4b42wsh84dUuMcyrYm+LPLhpqkImP2zvXauhQn4HVPaQK0qgJA1jHDqAROGVcW0PzHBnIoqH+X2IsbKIDK9XcQMSXx36lQAYdjk00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oARtQrFa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YxwlxpHC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Lto5p008433;
	Sat, 5 Oct 2024 00:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=rTuobRBX0rPeMh
	jzWBytNSUlde7jpv8GPJtW25mz2sg=; b=oARtQrFagMtW8XzioK5bSItR1UnbAR
	l3hYZDX77BuP+/cRFlLChNUF+IZh0U3mNFNXQQ5wr/QangsdT7leu9HLnMVm1w/6
	Ljyn27zKnTZszeOMbr4Aiucu9ZftzVafS/iznmp8uVLHzCtkCu5gMQGHCp60eBut
	bhju///h/mNpBvutQsJYEdtrUiOgtP4WHZSHNDx9y4UhscOVxaQUkbPsRxdg9Vhp
	eIGmEbZ04IwW2Q0Mx9lPsx7TY/ESafWNKrayuy79nPHd/6jhN45xOLfdv9LRWqEw
	U/UXd2Gl1FUWYVdOiceCTM8kkD/emDQGbqb85qqOGNskerpsgzp6dysQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204ftnpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 00:01:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49500FL4013281;
	Sat, 5 Oct 2024 00:01:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4220586u2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 00:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK+9i1aw8FY+ZIHqXvNhoeTcH4ADErx9AEe8kuTYCJLEe1sYhbEyORehSX4HMfWWbUtnWvZYvn8vMZ326oYRxmrF4chAuTnsLExH7EE9Q4w4Uw+dU9SrLbjoYkqAsCAXS9XqTbLXABB7t/vDO6x1mX4wJc8o1pmC8H7A2PIy05SskEavrIM6Cg4IMadyUnpgv+R4HKMqgpmuC5UhBQVwRmtmsfhv/101leoaZ3d7PhACBwEklR8vfD3yKOcsxYUVVXmj2fhkBMRfr5FQibHXQwp8qy0myJ+Ee8QdsXTIimM+9qfaTpttlUXLfra+tk3EV25Bg/w1bXwa4B5Y9E2jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTuobRBX0rPeMhjzWBytNSUlde7jpv8GPJtW25mz2sg=;
 b=nqqyI+pAZqciE5uDy4mqx2qShXKveA219F4EDNB43L/zhGsOydXhvmnyuzqF1KWvfhKY8Y279lXhfs+Gx1u7IKpcKKLEh1gH6SRyedc5A2ZO3mhSEfqBYSNAZdrMmQYvt+ODo3a8UUCY+izsyQvlbp9Ehld6sFGp8pzFc9ZIWxv6neaBR4HjJ+2+bWMOA7nIRA7DvB+gsKOuroWqMFSX7osuD49LR/t4sWKcro/1UkjBn10kGlWKpA7w7t7zAqSvfgDd6H1fudWZgRq78+gZ4Id3UidUsr1Tyd0zjodvwfmxV9eux3sPCBa1L1EdcehHRxkFiQMCkKcra0gK22AqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTuobRBX0rPeMhjzWBytNSUlde7jpv8GPJtW25mz2sg=;
 b=YxwlxpHCZrgenbbqoNupcmTkRsfslAsgeFj/kGOtUOSXnw+deTKljyVel9LQhFlAmfvKcTR20R6KB3Kb4TSrlxgttQnqt0YRNmGkBSMg+VsBrA4V0w6zEArORWP3nU/JzEnHNUIZ1h6cDDRAmLs0AFHf0PPBM044frgIjGbYy2w=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ2PR10MB7654.namprd10.prod.outlook.com (2603:10b6:a03:53b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 00:01:49 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Sat, 5 Oct 2024
 00:01:49 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: fix reversed condition for matching ELF section
Date: Fri,  4 Oct 2024 17:01:46 -0700
Message-ID: <20241005000147.723515-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ2PR10MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 192430b4-01bb-43ad-ed19-08dce4d0e8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eVu2ac7AaI+AAZr5UDq/hn5P5gtzrmv0SMRiT8I5/kvrKE2mw7beQs4dmhW9?=
 =?us-ascii?Q?zGShT7i0Vmt2k4DLGtUTfD2f7oocthJN3Lq79ZrEjXwXgf3dDWbvtedlGsv8?=
 =?us-ascii?Q?V07tj2/h1ODxsk77G9krFUGin3Uu2vXGsZ5Yj8oIkHQ0PekxachQlaj4+j8O?=
 =?us-ascii?Q?gpZVY/MXmTbJZPbUyLHOtAsH6hTu461dOFDqyNPRk6nyx4Gm0xvGUH0YMtTX?=
 =?us-ascii?Q?5hYEx1RaQB3rhbRQVRVuFUESvcUB/e4uNbCppBq8p+OsVnBPcPmn8YNY4pIc?=
 =?us-ascii?Q?q3HLjGRZQGZaB1xNhY5ee12ZYVegeVw2gqWZ7VLHy6NvZuk6TxYIvWArzcip?=
 =?us-ascii?Q?a9QHTBsPmLElwB3grlo6UYGOvhbUAp6mqjirNIWAQBuSDczLLv6zzsZkmuPQ?=
 =?us-ascii?Q?qJvpNabpxMDsD/w4bTf7KYDxr0D3TubFdPdBJViOOqWfSOlfiVRKqryZiOVL?=
 =?us-ascii?Q?13wH/YHZ/XpX78VEYPEa7AyPgNsKW7Kc0AkYlWtg+F2thJ53kHdYFcH2ndO2?=
 =?us-ascii?Q?mbI6ZBfA0VImkERyACaCawxTwj+aeNmUpoK+0wndMAHnsmEVkLd6db07HAEK?=
 =?us-ascii?Q?OOAdQtFHhB3MOOLN4gvxLrwtybw3xDYESi5pHsOS8VSdmn4OdV933qDzLmx+?=
 =?us-ascii?Q?qKk9E84LEDhHB4k18mGaZRB7zVTVuExzSB+bKUtyIn0ie3VXookHpUxLaPNc?=
 =?us-ascii?Q?FRqMQiR7ICyRinl8bnAJ+oFOrg3+IA48devuOwW/MD+A85GcpPBc6yyakzpl?=
 =?us-ascii?Q?56oXHs0Ed/9g0nXs3VSPjbPB3cIvg6HW1l3pEoBiTPfUdBFgYeXXW+JT0opU?=
 =?us-ascii?Q?TQp2chcyPVP6eNmPh2gD7m0k/+BERS8/4BF50axGmZJ9DzJkpr1urNN7RR1w?=
 =?us-ascii?Q?NdgCs43n3fuUKBn/CMKozOTZ2wfLZqIkAdZugl/3FhMEd2aFeydCgJJK7RZD?=
 =?us-ascii?Q?sV578W0S8HkVElJ6wQMLQIVj2xtekC+3SkY0qa84mv4YtUz47KjUJFXnIZzC?=
 =?us-ascii?Q?ATAMLj9ZYidoeA1OMxsZ38u5oQbT/S5X1tOzkf3XyyE2yAbl9k1W7Jt75ChC?=
 =?us-ascii?Q?xpICdS8Bo87HcfUQfkqRz4Z94bpJpkP3iQerA71N83MI4sTzzz6PEgqeExGF?=
 =?us-ascii?Q?hluJ87iKpNKlGS4WdlkjNU/nKhULF1ZuJf2TdmNyYmZvOfy6U1o3S+ff0/Fh?=
 =?us-ascii?Q?s6KDRhNu4LCSS//mEg1gywZjxA5k0K0tGU1JwWLHi9GavAgjKEoK8rai1U73?=
 =?us-ascii?Q?56JJjTElyIZZpSAhMxI90CBuxeqFnGTvVCbUPfCcfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/+R1g46MDeg1s+m720nGEsbpQA2dLXMoS0vlP1vaJXD3mVZuyOO+Tpq7ODR?=
 =?us-ascii?Q?ubKewLUMxDJwgahhF8mPnGmARMMA9BmjnSu8DbP1AE1rxytEExNrhm8ormEP?=
 =?us-ascii?Q?8dhgWdty6PLVaeJqnI8k4VbSSeOULAwhVZxdZCc5pibbcjmjfPDoAjHKZeX3?=
 =?us-ascii?Q?usWXiNhamGE9B7CoH09EMKvihyslMRgxIG88IMbJXJNbtzlM0pP7tyXLinqP?=
 =?us-ascii?Q?ABqTzqM1UokcwN64gRQniHarHvmm2BkOXQ1mosEVlxa/l9lS6ZvLs2fgRY5h?=
 =?us-ascii?Q?sVt+oERL2Id+bXinqV/zYBXSgtv7NpdSoPqBT54qXZnDIZmiBVzCa9/mlQHz?=
 =?us-ascii?Q?HDifd3GBzi7/mgtBWvyNa7DoNr1hSIGP9Olp/Ax3cEixkde9w/UMZpGC4Pe2?=
 =?us-ascii?Q?s0XgBR1Fa4oBcrYta0/RCZwVaFW3ZZ5AVqu/3/mSYRHTcSY0VchOTWoGJL66?=
 =?us-ascii?Q?fPC2e/LxibrnhTmSOlPoYNA/5XOGos36cfkxaOd5E8s9HRgMxvZ3h6Pxpd+o?=
 =?us-ascii?Q?tZZV8PALNDQe0Yq9pUhQ0ul4ug8+O20dPrRQRn+3W6y9Wm/9MRBddqgaXKWA?=
 =?us-ascii?Q?wZEVCQeHoSBybi++PTNk2RBvKOcHyNV2y0TlXw3elps2NO3ZtlXqVo/V0UFg?=
 =?us-ascii?Q?BnTbY8gtKA5/W1zIQtpCyW+r8iiDtO5CXSkxr9VGzBnF+oaNEDXHQpvI90/y?=
 =?us-ascii?Q?aOpRzpCjSPGd4o06QpaxwG98ff4VqPvXGppQEGuDDuLluMnNmb4wGeb5aAhI?=
 =?us-ascii?Q?96Bq1uX1jGLiwC7NQXTP2jtGoHtrPFN/NXhXUgd0m3Ifqytr+onJBIbZKvns?=
 =?us-ascii?Q?zEaddONjtKTmrB1K6PIoYLHkePc3XyOsAMjd9M4gUVdFc4uBqxF28P9LGCgn?=
 =?us-ascii?Q?QfoqCVJku9/y8IiPkOya+0SrpySNv9QHbkp8d7Q4FQdyeQ3nA+u4aMNNCT+n?=
 =?us-ascii?Q?hYwTlcrlf0ZFSCf25I+1F0K6p7iIOvoy7GpvDp4nQglmBVoR9c8KD/x6Q8mX?=
 =?us-ascii?Q?CiINTH5SjuA9OuJBzOT86vcpvIWD2l5hwMOUZd08uNDR7KM4GCVZ5Y4tN/GJ?=
 =?us-ascii?Q?ZSxnLCINU6KvmInUzdy4NeWj2q7o7hhpu7O46G/IAKl64/saT3bJmwBVYT3z?=
 =?us-ascii?Q?SDwQVv/iNXWzO/RK5kdRbTYVP5azvoK7Vhm4zx6mcrFaJfKU6ZgF7tQtvrVd?=
 =?us-ascii?Q?vBLP6ygGm8GxFg1Z22OzF41+ZqKBfH0V4LBeJZstxAabW1JqSRUZStYL3gPx?=
 =?us-ascii?Q?KiJDyODlZ7TZgPSGLqpZzgFeuvJA115QwFLc4hg/NxT6qvhLQxEixMYD8gcD?=
 =?us-ascii?Q?lvXrTqzt8HSbusx3qjdb9bBW2jM1/uPQd5S/M7nTsgy45E71fbCbyQ6RH3W6?=
 =?us-ascii?Q?QyjLdnmQlblrYg8fUcY+B1ee4iAfMGiz0UxHbvrdCwG0Iy0G6N/kAykd5MWM?=
 =?us-ascii?Q?FVJ6VI2eOS6gEkNQHET+bTwvvAfCSxhTC2hM4blNZ95FycIVdMdd+uSNgmgG?=
 =?us-ascii?Q?ug5el7pVN1abzW3aPiS75EKZ+YPsdrcAmazHAeegDe2b287p5aosH6mAa4BN?=
 =?us-ascii?Q?bjKN0Ptpg6+5ITC/gzR+bFxxbXEXqGu5v9qc0mBrojAftPQK3DgvmCm1TQeA?=
 =?us-ascii?Q?W4ONoDULgrsadfO+mJCnsKM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VwKvoz478wadIzFqGQIKa/Xsf58v4bqYGLeQuk+ISstxgxd9+WY05A/5xwH3r2lsDLjAxcwmsMkQ2sLaMHFn5FVQBMTbyHDrVhoKLvqfD2LDimTeUtm4dVfylNr98J/IbDFcYdP1wryoXI72PJ1wmGomVwhI4RccBaqufw4CgL9krekjK4ksuCATOLolOz3pfLBC4cX94vDgqwos4bU1KVZmKI6M4WmFCDjYv4tVmP2suQ2Cebf0fRn2l1K1/HYJyw5SQYc5M93sJoROh+2uMOCVoGD0umjO0kQS4fl9zTZFJPqHOvwC99BqGqS4n6DTDClL6IdRxoVcckgPpm9ySST2t5muhORUGB8VBTi39AZ4vf97QPJWWuUy1X64y4h/BoQ74FIB/iXAkHHTo6l9BnK+Np2Y7yzIOiCUDMk7W+lna/zIxxY9hEmzSsgVUwFbkgigPlgh5Ij5iLu8EuqQcBqn9GbkA/3iSNAfw5IesGfP4rGrTjfrYT/lw2myCSLDNoZqhx5fFfQbgVuie25beWaPosUSIX0K6gU7iEwR1eE6iMbXzO/S2jVGSBNV1aCjsQPWnBERWdLuW0K15Q9UwWs49FaO4D1qd4hLybHAIps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192430b4-01bb-43ad-ed19-08dce4d0e8c4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 00:01:49.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szlCXCUhVNAHzDaew0ayq1SUaHBcE8CRKXj1JDYsPij9t4FBca/io+rl9r9LJrJ4UQAzYoEKSqShR748/G8mls5mSWQnhxWOhrJeAlFMqZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_21,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040166
X-Proofpoint-GUID: cm9lo7Cs83T83HG31xtLlUNkoSlpDFO1
X-Proofpoint-ORIG-GUID: cm9lo7Cs83T83HG31xtLlUNkoSlpDFO1

We only want to consider PROGBITS and NOBITS. However, when refactoring
this function for clarity, I managed to miss flip this condition. The
result is fewer variables output, and bad section names used for the
ones that are emitted.

Fixes: bf2eedb ("btf_encoder: Stop indexing symbols for VARs")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Hi Arnaldo,

This clearly slipped by me in my last small edit based on Alan's feedback, and I
didn't run a full enough validation test after the last tweak since it was "just
some small nits".

(His code review suggestion was not buggy... I introduced it as I shoddily
redid his suggestion).

Sorry for the bug introduced at the last second - feel free to fold this into
the commit or keep the commit as a monument to the bug :)

Thanks,
Stephen

 btf_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 201a48c..5954238 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2137,8 +2137,8 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
 	/* Start at index 1 to ignore initial SHT_NULL section */
 	for (size_t i = 1; i < encoder->seccnt; i++) {
 		/* Variables are only present in PROGBITS or NOBITS (.bss) */
-		if (encoder->secinfo[i].type == SHT_PROGBITS ||
-		    encoder->secinfo[i].type == SHT_NOBITS)
+		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
+		     encoder->secinfo[i].type == SHT_NOBITS))
 			continue;
 
 		if (encoder->secinfo[i].addr <= addr &&
-- 
2.43.5


