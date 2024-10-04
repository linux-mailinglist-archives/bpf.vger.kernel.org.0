Return-Path: <bpf+bounces-40971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0B990A1E
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C582F1C22338
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59731DAC85;
	Fri,  4 Oct 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHYcAi20";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hW2muueT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802801D9A62;
	Fri,  4 Oct 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062806; cv=fail; b=b/zm19jq9ohLjXoNGgyhB38I11gR0VNifMUf3dLJuXpLqCjF19JUHDGl+UTN99BG0bR+/NcT6fLpFxf33LKxGmkdV5OaeTKl1h5aWQX0o51HBbdE2kFKL0niQBCntNEVzLMaZjpB8TeiK6NAnt5/wCckk6nSHwVdsTko5ASPJ8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062806; c=relaxed/simple;
	bh=c/MDGrKQqSrqE11GT/m3g/CnlzoEheGl8zN6pW+MTf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJ1NxbS7BgOsCbhPMsfbblVCOVvIApBt/OvncrzPK7xDyL1szBmo6sY+eb/2+pCm6SuQHeqeilcj7PYKW/RV2G1MjQKGjYYxs1bv18XUp4NTVeXp3FPdv0ZXuz6DULT3qFObO5uZ1X40PZuRlmn6Wld/WuvxElq6x2bHV033OeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHYcAi20; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hW2muueT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Gfs0H001853;
	Fri, 4 Oct 2024 17:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=xzGdJz58yU+OYmxzfakqJV+SzcpjJdEmE4cs54NFXuk=; b=
	BHYcAi20XUr9OJRRBnq4znJmFbPUE5NR2L2yvnt7JrBzCMqqBqc/dUXv1v8+urGU
	COJ+PgQ5XO7dYDF52tUHs39bBj4NR7HELJxyRxUTGJSZWwcnVwxLj+92SEOMwPyT
	VCO/SIYSd+rq7YtSiBrtvHV6B9Ah/xylj2PTLKjY975AFZ3N3FahRg6OKV319pfJ
	3TvKmF/mNnx7Lsxk2c0ff4tkNd0XbrDszxcucNwD9Xx0Ob9w1ifQKnmHUlNTbR4q
	x504LSafmvDffc/QXvQD9THI/RWoTVt4glWeMZKtDMbxVEcZOZ67MYeTviabz9HS
	rCFpOb0zIBamZ9GVa6z9jw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b24na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H0BH7005936;
	Fri, 4 Oct 2024 17:26:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056u670-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q16yu/84SX525wTr2fALhWHpAwmnPcoup1N8Ssctgitt7eIPPfSykb+coQ4wS48526k2UkWnqvdOr5vsqR7tEaqA2ZmQRLDmxerA4Fxjqc75ZS+YWniVyl5cVNIAlwxPvnjFj2vLMoNnqC32mzcHoWGO6vVEjGRZRDuy8FLraKEdp8nS6Yay+u0T3wUlVqFQlA/JEAddbeTrWZ7pAqB1X+DiQga25qcsDxUglpVvfqV6d55WBCt2qUkHTLz+ue7L6d18wNiBU6hyp+5cfmiKa+56CizV7C+PcBZ8lH2TO6s6MatNgzrKlf7IDB1Qw2C1wp9VKJTdMcZFa5yU9Om1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzGdJz58yU+OYmxzfakqJV+SzcpjJdEmE4cs54NFXuk=;
 b=ZP7FN1s3FYcN+MvhlBt069NszihIkGLgnbWhO+9FDRlhorn7qpF9dq1mTEEEEijt6Irok3vy8Dk0n3KP47PZfG5FjxRdySOTv849IhMSTD2B2rbFJS45s2aMv/I/5WW51MCBBZ2gHsLyOPPHUOmXyMqhL/xb9hVVnb+Vx0OAQ+2H1/IjWa/AxHM6BTFssx880Vr22f4/I6WEvB+PE9Tdbp1z+OhCEg+EZi1yKBb05PJzlHO3XNMq17aRlwP5rnzt8oxAb2FMKO2nQNHSNjuEXK60DOiUQHBMDakSgusltx+n9t2pmlfgXzpozfFslUAYRgE+YEr5/3l5dPUWT9azcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzGdJz58yU+OYmxzfakqJV+SzcpjJdEmE4cs54NFXuk=;
 b=hW2muueTM5JUYp8r/Pe7Zp2URdkB7f7Njpe4udbRysEmZDQ+ZwGqVZrw+3UcDtxy2Uq8E7NZhHVe0rNZF02oQqJp/VGgx9iBxF2mI746dJQK7eKiir2VDn/ONNTdJ+C/RuuCATufolbvCPTTRpo+FrZRVHdNWXCYsD6p0Q/yP/g=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:26:36 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:26:36 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v4 3/4] btf_encoder: allow encoding VARs from many sections
Date: Fri,  4 Oct 2024 10:26:27 -0700
Message-ID: <20241004172631.629870-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 5132fd1f-edb9-498c-aa46-08dce499b30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Ypp9aqGYIgMIhvdvnIhG3vJo3aQnWktxW41AgLuPFg8WF6seutwS6tEcskv?=
 =?us-ascii?Q?jw+rcEgIdqY2IwEGnFMzplN3SSakua7qJwajs5+2YdiRWyUHAt6QeVGAJTLZ?=
 =?us-ascii?Q?7pFIt5xaRZEEaNhpJJFMiVwcVFaEPAhFc68+DBiMTCJiv2DHXQFoi7e6VNIu?=
 =?us-ascii?Q?nyykd7p6DfwGEiRz/s9MMrcSr4iwjiuNt0sJyo2M5sXUJq+VRsOcEMp5LfeA?=
 =?us-ascii?Q?3aCpOwIob5FtP/2SVG83Z2+l+P9eJkiDW1HrCWX7Kc5hpzAwpZZpQnxIfYU4?=
 =?us-ascii?Q?6JsuI1OdGXDZkKfeC/zl4hVgiud5cDqdWGKyJzMp1X6C6nW9jjTheUu/EvsM?=
 =?us-ascii?Q?xNGx7XtuiKXJ7y7ORRxEBXqhnMK1btUSqv+N2c3kIKB9ReBl5xV0o5rvAg7s?=
 =?us-ascii?Q?sxq9tDNj/HbUhpxA1E9f+q3uuF5we/UIJnpWE7okqOwuo1yMuEi9PcybQhsv?=
 =?us-ascii?Q?lmkj1ttq/1UFWv7ADXwt6iv8/Vi11lq2TYIUEOzkg5L3Xs6WnKIZB8TrFe6A?=
 =?us-ascii?Q?9ILZ2LdUAhO7IW2aEKh7eKjuU2XWJrrnDSZVIGx+AF3bc91jNMzBr/kBderI?=
 =?us-ascii?Q?ne531SH6LoN+1jHLuPRGGFjIaQa0AAYqxkCKD54kHs9BRAHCGAVznyWd5LCt?=
 =?us-ascii?Q?AkIL3PwSHOakyl4QZXsTdz+hYo+ROFTvBAWyMJVXt6Rn0anqeTqQyWeOS31s?=
 =?us-ascii?Q?DO2yKhaqxI3jgJiMr6saafMgltDQtol7RGVmRzE9JgepGkqalQ7GN4oxKFvi?=
 =?us-ascii?Q?5pEFDqI6xYEVrtHpEIuCXlk8qCA1FEzENicp+NyUtytg6RxHKSQDA3V8HDZB?=
 =?us-ascii?Q?8XvEM2vvp677DmXAwmLv4n8mEHoyciNnt5XCB0vHrbpkurgXZvjxvT17MBRz?=
 =?us-ascii?Q?fBhCFIIh+fQCykR182EKi0RwvE5DzOcWNfvwq1PThQcYBq1uf3ullYWZM3rQ?=
 =?us-ascii?Q?E543/8YLPolzoVir/O5YRraJlU2CHqBKG6bnccBFr4aDYcmhOgYecq5uMlgt?=
 =?us-ascii?Q?rGMtgFZcYb9/AiSyADhE09sti6zS4MCHnwks9s6JW4BnVAzN49jnhnoGEkl1?=
 =?us-ascii?Q?7hdzTa6r1jXc74l27/nApsbNo1exI++QWCmBy+h06qv4W/t6u8U8s2ADB0NJ?=
 =?us-ascii?Q?D3jNQ5FMx2++aLPoB+LsLbIMZzBj/CpUaEL8A5dLS6iSROz1x5AuWnzHkjbJ?=
 =?us-ascii?Q?sbDEOFDwEsHw5ejGfi6Xlfe7QeYjCWaGDW4ij2341Ri7VnHTeSkSUr2NR/4H?=
 =?us-ascii?Q?6LzgoEgCCWPCmms6R3KDbBD3smHYMSr9OAs0YyFtcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFtWLTf0Wh5+vv61Iws397AE1dXIdw+uaaHDoGHqrGx4CxWY5iXj4hFsEy4B?=
 =?us-ascii?Q?WcUHK6BBLdUxUrghymArp1PbteMQ0DlEkTLhEiK0MXc3p+zElOYYVDwewbmO?=
 =?us-ascii?Q?zih4471e4VEBoIEcLWqtLuw7SUL5Co1/AJb9r51cpRiTbYDH6Vt1/q1AABX7?=
 =?us-ascii?Q?2XMlQi7I3hOa5fgWKCaxHPxGmiMy4+K8JrYhGJOGDYJld+a+oaDwcoFu/F+n?=
 =?us-ascii?Q?jaVnhzvp+2RyjE1oablEM/NRaV505pAj6mAWymedxggBxkNcBcGDpS4pLndd?=
 =?us-ascii?Q?qNrikgT7k81YW2Edcuq6j/MjyaLVgWfkdkYt9wNNTjp/QmQ9v64fJ/EAPlmT?=
 =?us-ascii?Q?u7ZyUP1k+TGQKlnZzbBBvcRIZp66ZnSQi3r37kjoRrznapKsTv6i7UJd8LZJ?=
 =?us-ascii?Q?rUp+T4aKTacOcxvNuOF+QKv2HzsanqJ325GQK33kYCKCl3VTqPAOoVP0S4kn?=
 =?us-ascii?Q?JYhcw4mciFZU+mJwaVvLd8rGJWB/+UhOsgWs7fBJib3LoDAkLxzWpwuet3z4?=
 =?us-ascii?Q?nSr/8Rro/sPhZZUUSfDQvTFYD4r1LQ18+sGD/KdhJw+hf9QuL6YPXO+TjIsF?=
 =?us-ascii?Q?CexeHgbZthBpJZT6pRLeMx3KYAeyMvhgHf1huXctpIzOm4faQFln3jZxCPE+?=
 =?us-ascii?Q?dRxZ8OpJpqVM7OwVDCkbsPeD6SF8OCp9reRrxNuAOJZtWK+QA2FGKeAhGkem?=
 =?us-ascii?Q?E0jNd4XEqKc1fUoXx+pAesdC5aasBpXqjCaGMbR3s3+aMeRYXBwFXxUKE+uR?=
 =?us-ascii?Q?XTcvSh9c9wcvm8GkgXhRc8k8QD42HxWTLV7DZmom4EGU1GYJOCpB9acRsTK4?=
 =?us-ascii?Q?9cMFpysRWifdl6EIkZlA8KJJg6Po1YjDIa9VX7T53ec4uJHoRMQMJqp7kmF/?=
 =?us-ascii?Q?Hfcc8W9m3qVHejK96SweuPRdKqOpUA7kTye+pFI3wmbOB7Q6L/pI5r9Vdz6W?=
 =?us-ascii?Q?H77I+hnp/ZP8ZeEb0a3ZIs0vB5jde5tSQpHMPDv6t1+/vWpjSBVLOhZeppR9?=
 =?us-ascii?Q?GXgO4mOIY4AKMfGLKNM+arRgt5O71O5W3xo03YAWqcCgUHWs3D7D95nmaI9W?=
 =?us-ascii?Q?XO+hcK3mJ5lcWK1R4vFfxh0Rm1QcbWsFaxUuOxhyFpX+JCImHIS0sfLPftjh?=
 =?us-ascii?Q?WvZltD83b/qenYgD44oMFW7C+0KPpOwKgIvjXFlzUww0kj2XAbOJzBaZHDoW?=
 =?us-ascii?Q?2Y2OPX1QwiCQH2toLTLmwoE6Ghh7T48ueJeZYVa2WQ2i8TklhuYfKGV3+svJ?=
 =?us-ascii?Q?/heRwwsnOuD0HTZJSsk63tB2JPRrgNHeClnT76RuGUONH9LRFSjoiMUG7lqC?=
 =?us-ascii?Q?Yt86PFcyoCr80+Mexu6SmRRIAxCIniW8yPjI1ZEW16BbU5Tsh+jc/3Ls9VVx?=
 =?us-ascii?Q?kmNPfMzeUcLa+xaPHRz2+QYT5TJIKzARDy+wEVONYPbWaZEv0zefJK/a2NEY?=
 =?us-ascii?Q?TTc5rEA49KL3O/yv9CibonsJ8tt0KkMpULqgcHNkknlFaBazVFBXIExcyiIm?=
 =?us-ascii?Q?oJJH4QDikXBInAcn4LyLI8Gi5PIZYpgjNbHJPgaGvqeKR0eOx7GVDG46ps3r?=
 =?us-ascii?Q?TRIVPmrTYoDxJVWdXQPf/WZiW6ZQOBpX7soRtuHnY0xF8PqAV8tCYlO9NOj6?=
 =?us-ascii?Q?N/9UIMgezGW6MEZJ0wcQ/tY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pt/ZdWJaRHiT/+WDefU2tETw3s3cDBFF5lozxwZyMDlR+JiBCsWWwu/TxcJ3jXGCPbo1B2kyEESzmvc4TNhkEBHD9sULXsw7OCIR2bJTjRKsxr85VXtdYXqls8+pDaCQ7SjPoNS2dst7xu2DgHPTMWTO9mx2Q0NG07GEPH9NG5ghjW0UWRfSfUNHNtpblHFGJ9IRlYRt4hkjib+70puLeuYP3rX2IFr1ILTu+WkUIbMCytXrwxFF80vvEjguKNFKJUafgJg8aWwgCslADOTFaXZfHSAmaTXiw+OsIOsO3Np8+t0vXY5JEjVCzV7TaQnuoG86lRmH5Lj849gISx8Y3hGLFn0RtyU9SxwTxth+60oVT3IiOA8N/ZOv9qujetpOz31lIpy5YbcFWgMocewy0EZOzoDmSSjt209fPXQf5JueN26//9RLO4jX1eR0BtHZv0LNU1GhabXwV+vSxzONM60CqcyhCIKvt231FCTE+fdgNKVe37fnk8bFMxKjOExjsRVz+kVKgQqctNeaP0EotDP++GKf2YBSegrWglHWVEKT9i3EEf+g8p10NqFdGMQcqutqlYmE17qtbdY+7Jqzlt7t7Pw0M6DXUSvmDLWJb9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5132fd1f-edb9-498c-aa46-08dce499b30f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:26:36.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYUxsw/V4FXZtPeXaw/E3fNLaK2AtCEY3bN8LtkFG/jATij+N8qEYMgeaLpcFSADM0j4naRsNVxk9jggz9ZV8vY3wtR5lkytj36Vnoexlxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040119
X-Proofpoint-ORIG-GUID: vOlSMtw0kNXSb99JL8rTYblJtzv2vSgj
X-Proofpoint-GUID: vOlSMtw0kNXSb99JL8rTYblJtzv2vSgj

Currently we maintain one buffer of DATASEC entries that describe the
offsets for variables in the percpu ELF section. In order to make it
possible to output all global variables, we'll need to output a DATASEC
for each ELF section containing variables, and we'll need to control
whether or not to encode variables on a per-section basis.

With this change, the ability to emit VARs from multiple sections is
technically present, but not enabled, so pahole still only emits percpu
variables. A subsequent change will enable emitting all global
variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 87 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5586cd8..838a0b1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -98,6 +98,8 @@ struct elf_secinfo {
 	const char *name;
 	uint64_t    sz;
 	uint32_t    type;
+	bool        include;
+	struct gobuffer secinfo;
 };
 
 /*
@@ -107,7 +109,6 @@ struct btf_encoder {
 	struct list_head  node;
 	struct btf        *btf;
 	struct cu         *cu;
-	struct gobuffer   percpu_secinfo;
 	const char	  *source_filename;
 	const char	  *filename;
 	struct elf_symtab *symtab;
@@ -124,7 +125,6 @@ struct btf_encoder {
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
-	size_t             percpu_shndx;
 	int                encode_vars;
 	struct {
 		struct elf_function *entries;
@@ -784,46 +784,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
 	return id;
 }
 
-static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
-				     uint32_t offset, uint32_t size)
+static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, size_t shndx,
+					    uint32_t type, uint32_t offset, uint32_t size)
 {
 	struct btf_var_secinfo si = {
 		.type = type,
 		.offset = offset,
 		.size = size,
 	};
-	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
+	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
 }
 
 int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
 {
-	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
-	size_t sz = gobuffer__size(var_secinfo_buf);
-	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
-	uint32_t type_id;
-	uint32_t next_type_id = btf__type_cnt(encoder->btf);
-	int32_t i, id;
-	struct btf_var_secinfo *vsi;
-
+	size_t shndx;
 	if (encoder == other)
 		return 0;
 
 	btf_encoder__add_saved_funcs(other);
 
-	for (i = 0; i < nr_var_secinfo; i++) {
-		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
-		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
-		if (id < 0)
-			return id;
+	for (shndx = 1; shndx < other->seccnt; shndx++) {
+		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
+		size_t sz = gobuffer__size(var_secinfo_buf);
+		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
+		uint32_t type_id;
+		uint32_t next_type_id = btf__type_cnt(encoder->btf);
+		int32_t i, id;
+		struct btf_var_secinfo *vsi;
+
+		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
+			fprintf(stderr, "mismatched ELF sections at index %zu: \"%s\", \"%s\"\n",
+				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
+			return -1;
+		}
+
+		for (i = 0; i < nr_var_secinfo; i++) {
+			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
+			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
+			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
+			if (id < 0)
+				return id;
+		}
 	}
 
 	return btf__add_btf(encoder->btf, other->btf);
 }
 
-static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
+static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_t shndx)
 {
-	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
+	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
+	const char *section_name = encoder->secinfo[shndx].name;
 	struct btf *btf = encoder->btf;
 	size_t sz = gobuffer__size(var_secinfo_buf);
 	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
@@ -2032,12 +2042,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	bool should_tag_kfuncs;
 	int err;
+	size_t shndx;
 
 	/* for single-threaded case, saved funcs are added here */
 	btf_encoder__add_saved_funcs(encoder);
 
-	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
-		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
+	for (shndx = 1; shndx < encoder->seccnt; shndx++)
+		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
+			btf_encoder__add_datasec(encoder, shndx);
 
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
@@ -2170,7 +2182,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 	struct tag *pos;
 	int err = -1;
 
-	if (encoder->percpu_shndx == 0 || !encoder->symtab)
+	if (!encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -2214,7 +2226,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 		/* Get the ELF section info for the variable */
 		shndx = get_elf_section(encoder, addr);
-		if (shndx != encoder->percpu_shndx)
+		if (!shndx || shndx >= encoder->seccnt || !encoder->secinfo[shndx].include)
 			continue;
 
 		/* Convert addr to section relative */
@@ -2255,7 +2267,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		size = tag__size(tag, cu);
 		if (size == 0 || size > UINT32_MAX) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
+				fprintf(stderr, "Ignoring %s-sized variable '%s'...\n",
 					size == 0 ? "zero" : "over", name);
 			continue;
 		}
@@ -2292,13 +2304,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		/*
-		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
-		 * encoder->types later when we add BTF_VAR_DATASEC.
+		 * Add the variable to the secinfo for the section it appears in.
+		 * Later we will generate a BTF_VAR_DATASEC for all any section with
+		 * an encoded variable.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
+		id = btf_encoder__add_var_secinfo(encoder, shndx, id, (uint32_t)addr, (uint32_t)size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
+				name, addr);
 			goto out;
 		}
 	}
@@ -2376,6 +2389,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
+		bool found_percpu = false;
 		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
 			const char *secname = NULL;
 			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
@@ -2386,11 +2400,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].name = secname;
 			encoder->secinfo[shndx].type = shdr.sh_type;
 
-			if (strcmp(secname, PERCPU_SECTION) == 0)
-				encoder->percpu_shndx = shndx;
+			if (strcmp(secname, PERCPU_SECTION) == 0) {
+				found_percpu = true;
+				if (encoder->encode_vars & BTF_VAR_PERCPU)
+					encoder->secinfo[shndx].include = true;
+			}
 		}
 
-		if (!encoder->percpu_shndx && encoder->verbose)
+		if (!found_percpu && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
 		if (btf_encoder__collect_symbols(encoder))
@@ -2418,12 +2435,14 @@ void btf_encoder__delete_func(struct elf_function *func)
 void btf_encoder__delete(struct btf_encoder *encoder)
 {
 	int i;
+	size_t shndx;
 
 	if (encoder == NULL)
 		return;
 
 	btf_encoders__delete(encoder);
-	__gobuffer__delete(&encoder->percpu_secinfo);
+	for (shndx = 0; shndx < encoder->seccnt; shndx++)
+		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
 	zfree(&encoder->filename);
 	zfree(&encoder->source_filename);
 	btf__free(encoder->btf);
-- 
2.43.5


