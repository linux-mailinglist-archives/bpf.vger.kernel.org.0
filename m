Return-Path: <bpf+bounces-40969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2F990A1C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90E6B20FBD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBD1D9A63;
	Fri,  4 Oct 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5neuvP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dYWh7kYY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2551798C;
	Fri,  4 Oct 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062804; cv=fail; b=pxU5b5EwFdTXgxpqLuLSLqvUPebJFQKKQxz3rD7YHBMHeBebQSO636tSY96sGtDIUbRcJcXY+Ox4FOxA9mSuKFaKPtFawxrEoKNLBL6tqoYLFKYoUu2nWnaXt0tb47L2WWfrZJqjZxNR9UKmwenCZZL9lY4muZo31y5XElyuJ00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062804; c=relaxed/simple;
	bh=SyQG1eQINFGicppgv0VramZgOZ2KNlh0xpmGRX69fhE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JFCh45DqreWdC9575taY+IX7nwPyWFs8qxTNHkz+u+CQ54eV1OTFRMAt/FzGY7QiDWd5I2CO4bsygWf6favTSQOByicHIK7oKwD6lMeuu+ezcMVNihnmeQePpFuq2gD+lzDeknk38sy07RTyol993MUcOL66gCgprAi7e/I0Awc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T5neuvP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dYWh7kYY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfrD2024728;
	Fri, 4 Oct 2024 17:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=kYEtDT6SLTo0vW
	c8z9zEe34DpQ2gbHorzIcA1b7Qml4=; b=T5neuvP4YQJnyK0BKgW2PV4B8yDvmz
	qD90LJVSrbyxTNmeNvxc/n62NvaG4JaGtUelAjElHnR8qqWM+4O/ySkez4LHFIpT
	2aWk8b+kWvctMpWVdfahN606dU1Su+brsU+U/XHbE7Wp7Rvq4WF+g7baNOMfoZHv
	fIZRl3w5pgJCq9B5tCCRh1x2F61Ud219JsZ3xU7XsSfjF3PRtEiUlFhOE6Fmlgty
	0RCjZa91+q1U9oc9jHyBf65UhYjOgVSqoA+W2DEBHb936gX3xhKZlbhYbRzELqMl
	NrdHa7VXp3po6Us+doUFHK49SfqyLJUHk1VgEh092DXNZQikICEEKwrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422048a4qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H4rGI005877;
	Fri, 4 Oct 2024 17:26:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056u661-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6lidTcvR3GwY1KCXFIsgO9YqjMxDN4Wx7bdWxb/1UcW5h4wn5qKDk+a2oMMz2NSLvlsu1dup+IXGXlo+9gcyaVVVcepEaENeKLsWj83u+XQMciPGOJ/OFC1/Kpclmhoga59WWmQnsJgWpQ81EFGAFyW1uz0twiYpBpwou989ZStUBJecYp3t4j2azV0CMNu1b86GxOMHFOJ2scVfC9kBPOdaFIu38hZAXsOy+tL+K3mMpax2IcW3XBfZogkwFU/My8yVvSqTIaDQzV4rl4Ue1jVFmvpxu/jRDv6ogQKiqnRStzFi5qrVdI6x4Vm1qu0UHFoPLeCJ2JC9uJdnPDSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYEtDT6SLTo0vWc8z9zEe34DpQ2gbHorzIcA1b7Qml4=;
 b=gb1TtfKct7HbWyA8IrSdIs5qMVi94F6/wYIL02ihnL1gLYL3IDc4n8eEVrZXLcmpHegQ6t8yHaNCXzMPNYSTsdIdkAbkirZtgAGeRJVZgZHfsHHrBoggs6QpbixmSWAYMII0R77dembePwq/31NZikOMDIEWM0x1SfHtScZWMtqFRNSzJdOW1x4p7E4RowEIIr/0WDiANUwdSt6d9ZBCv/uvqTvr8TcJgs0AZjOcZBd3+k8hvW3jFMMxlKz3TQA+wHBYrGzjehd+5K6rXvmfYsA3eABYAND6OwNBQjf+4eNvKaHKopVFMypO3lU9D1mXHhbhiMEHQOmnzYFJxy6Dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYEtDT6SLTo0vWc8z9zEe34DpQ2gbHorzIcA1b7Qml4=;
 b=dYWh7kYYDvwGoo50RNNgCOSxp2/Ua+HBf6k3Clq/EFNBT5H2NQFlTRdKCni57jyyWRMjRb/1Z/IfsVmmYtcCP9m4NhVEDf4XFcnYCGlByBzeT65UwiDRnl+dnHtlcsR0OSS2YiEzSDqjynqjNHMCCmbwARlltZZUSmZ5ncg6Wv8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:26:33 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:26:33 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v4 0/4] Emit global variables in BTF
Date: Fri,  4 Oct 2024 10:26:24 -0700
Message-ID: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: bad3788d-a1b5-4b1c-2abf-08dce499b0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ov+4JJdifLQTdUX2jRQtkWdTJAskGztq2L7vJf+w2CJPtB6JeqEhceLi2HkS?=
 =?us-ascii?Q?j3KEW5dJ+jOpkCZlawUhrkuXm0abR7othErNHrj4hPDdmKZBkEuKsrYwb//A?=
 =?us-ascii?Q?jUo8lxzZ7pdZXVrlszhgGOnWpVFzoj5AQJePWqyf+LInYrUM3ff0ZCdLzYwP?=
 =?us-ascii?Q?T1vwLigEKF9XyHkKvuSg6sgHY+ZdsEBOyLiRk15L2+avWJK1CJaY3Odpa4Rs?=
 =?us-ascii?Q?t5uLGER/OEB/cpOF11aULvGKeprxuzBaiAyK543TRLvewJZ2Jt9+I63SMvgo?=
 =?us-ascii?Q?kbf4X3LLo/bue3kgLlDkeb+RN+85hKVOfq/6gzS/D2L6aDA96uzF/w8XzplR?=
 =?us-ascii?Q?i0m06j34vqu3n+SQGCmNsuS9NFbxx1AFY19/+FYCf+gPIyqXRWzG8M+g6Z32?=
 =?us-ascii?Q?5wIXmJn8y1qE08HnKJDjNWNXyEqePgr/MOH06GCQo/371CmQOczZck+5v/5F?=
 =?us-ascii?Q?TMYIBE2EysvmktfPEoxaWRBRx3aQOQdU6UC0xQX4um34m1fbn1S3WsWg6gP1?=
 =?us-ascii?Q?Kqvia+vNxtt0Nnh/3miOUfapjzdkc5BLmsizygOWFD1OCViVpEp4noBDHRWn?=
 =?us-ascii?Q?yvRomXBbQDplQFqW2ZpC7xsJorGxPvyZH0iCWxtPyJ8ctWoRiEfL17ZT4jeO?=
 =?us-ascii?Q?Mm+K/yP9iZplPY+9fzWFJtS8Z03vigebsIMOeW62x/ac8OThUxLTfnNg+ie0?=
 =?us-ascii?Q?CL0G90T6StFYRepwoQWSlWzxxfBWMeDLxI4PR42f9BM9NBhwU5w9KTv7L7ru?=
 =?us-ascii?Q?KLgARS9O49FE9Uol1Jqbr+BgRYSpQoOd+9CZJyWpRaHgMLZzfaueMb81HFlo?=
 =?us-ascii?Q?yZvtq4Ytu+Q5YojgpgnlptRSF9+P1g2O9MbO042Jv09wYCPGVmv5zchzueqV?=
 =?us-ascii?Q?7l09ro7KPTJ0mxFieuadh7l19l0btAyuHRpkhDwGxDDAA7nXL679dKIo/q/5?=
 =?us-ascii?Q?oOlJdputb7L6xLMdHO/WyenaT4hj1SWk+q1fmxiRVetxn9D46Lim/JiRlbG/?=
 =?us-ascii?Q?OBY6EvE57nL/lOF5sFqArxAxrY/Ch8SMRmX8spg40vvux7W3zYfbR8o7UL67?=
 =?us-ascii?Q?UWZBYAsVFGy0nQLeMYIyutl4HRd0gfNlSyi6yNowV2hSXHK4pTX1Ipq+bQR2?=
 =?us-ascii?Q?rj6JsMzl5qmd9lqCjJQN9e1WsZmM5bQaJqRXt9H1jpYRcgSS1HpEqJ5LUp5u?=
 =?us-ascii?Q?2H7wDXWudQPK6OtAJihR7Xk7X3afcJCmTXTke3gd2J9ReTxDYBKj4AGQVljT?=
 =?us-ascii?Q?plD3jgnu1M1CZGoOO2UTSUbyGUdTndg8xs1Z8C7nosUcyh3WzE7qzp0UuJ8Z?=
 =?us-ascii?Q?6Lg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNgJX4nLaJOw4AoY2KM3cZGma0vuKz74ne3PPSz5DKeqcumIUmagxyja1oKG?=
 =?us-ascii?Q?67ujP0OcJ0SUqyU4FBwHBOtFvkC9oOT/h9hOiBbDvkWfeBrt5n1w+4jIWIg4?=
 =?us-ascii?Q?78Y2yxfn5mUjcE1bH0uyqEZUYTwG/yxkqkMDlGSZe7ourTU1v4hKu8wfi2AX?=
 =?us-ascii?Q?b3mipexpWeMKrEdraK55o3DpvhABMuQZJvgHV/G4e1Vz+uwDlVcUgCKCCnaX?=
 =?us-ascii?Q?VxldT2T+UjXcq2U+zUr4Gs3OWpwEPkuiieQisAa4OdNExcvGvVeOZNGuMtqB?=
 =?us-ascii?Q?pn6EdioLELZP4C56rtTf4yn2uesGMVM7Hh+w/Kzue938f6zyYXlHxf60FXfP?=
 =?us-ascii?Q?qWv4aDExF7a2ooZJUn9u+atXI3iG1EFv24lktrUPohsbfuOMH2buIA0Z4Tvt?=
 =?us-ascii?Q?imhxU4H6zdcyhOnt8KIdCnUym0cYnL4BffWiq27GimaQQUUAnX+GSfMXcNK8?=
 =?us-ascii?Q?Lid/B0sRX8vBQNeL/ZSF6eco+rwc6tGZet2a08pluFXvAcdhjOYHR1REQHBO?=
 =?us-ascii?Q?vmkkGTYdFJF+lhW12mPAEQPA/hsqOBqxZZM+VqQkLRPFkw2zTAfBu4ldPcWr?=
 =?us-ascii?Q?AtUeCxBDCDGpTMZNtpmEvVkhHWcD0p7V4cE8f8oij3v0FNJgUJNb0UlZMwHM?=
 =?us-ascii?Q?IwRGdHzj9Wsk5OhA+rvU/OIoQS2pPWaQHpwGDcZvX8YeM1LN1AcJGe92FhgM?=
 =?us-ascii?Q?zHhp0ljzwa052SBmS2f4nOlVMY2ugodEThN+r0PFv66VPJKg3DBJKxMcXpr9?=
 =?us-ascii?Q?5EHWMZUPZJNdVlWgFWiA4FtxH/thpdsjDxPsP+UY9Nl2r3J/UtcoqJ4zAPz1?=
 =?us-ascii?Q?k3XeWapEGtY/+hiiC1csE2XNoAbPFKbjyixJMKfsLE/EDWLCg5OXDYNxs7NA?=
 =?us-ascii?Q?CwSSUDWjBgN8kLHj/9AOrx2CVly3uG30TCNfSyjOy5m6rpasj2qIIayCNGVy?=
 =?us-ascii?Q?a+F5rOWk/DTFfsj09VdILNZFOTJFwljY2gr7KRXUiBHJEHv3nW7K4//9YAeT?=
 =?us-ascii?Q?8ei5s0hByP9b1fCbtnLE4jl+sFwP4wyQI7LdTmft9bmfZitVBoSGV6iyipC1?=
 =?us-ascii?Q?riJndbr40duC/2/x9YuDrkcg87OeVaWqAeiF1zq6fTVt5eiy+hJ987xc4rVv?=
 =?us-ascii?Q?CRqErQT2b6g+aw6uh3YhLmukbHtuhHEjX+cXoh1boh7yh05+rVLiPa5TVOxW?=
 =?us-ascii?Q?oJzAHmWCUazlqfzM+RrWfu6PECYupM4qEMtyVkqfqVlsFV5kX/9VZtD9OXQ6?=
 =?us-ascii?Q?QK1CxFrJ9pftnB4Q+QKcZbPEwSVGlVRBfOF7k0Pe+k/hgx2OJ2itwUN6gUIh?=
 =?us-ascii?Q?IHQRxkPqF7RJx4FDeFXQvUonPpqpU2H6PvRyuIMQP/8tZx2pRaPkNB2sXNzZ?=
 =?us-ascii?Q?kdoYrobhMuAtIlDeu49vPa3X00YlFDhDHWVqC+bLUmojROtZTm6mXE4J3DGC?=
 =?us-ascii?Q?BKsNaJ8KpwjxAVr8cgYw/uf9uuDurud0rLbEiQJvR1GY7vuTTZzeY1VcPI5v?=
 =?us-ascii?Q?p5YhZyM3ZuUszseoMN/yGL67tWT0K1EJuPAv4dDChNpfum8YVdq4oNV9nKhy?=
 =?us-ascii?Q?JCdl9QaQaUJZNghXGDiRalvP8Hy1Wp/VWSBP9btiE4mPW7DJ4gEhYcElde0M?=
 =?us-ascii?Q?RZ6uO3c5DCuQmyqezEKpUSw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2K5R9URlmZ4JrjrGaLfV8F9a6MF3TZ9QfDqtwA396h9gQCP2LMuUasWoBql9o1GeUMrxCqy8crLbD0kKPujKzwkuhUp2H+6NHHLs+wwhxuyvWtqd/sQDsvgJZNxbV1H3VfH599EV/z+YAQOHU6VtphF7It8k6jOx+Swa0jl7SUnbS5xwYiilLnYxuxnzi5os+GtLceA44cSXMlLNavRZvAVhS6JJkTC0KVIndfvml4SuLZdqvXmpptcHlHjGoHKSOH9x4Kf8BMUWJ5Slu5DcAtpuKGS9QSx8OD+sdV+CdmvVgHdNCOch1DtW7uS9jyCzvycnvsUNrwnAUus/5jCPELpJxOPAF1z0zWiK0K8KMqdD+HYfl9oSFiVFinu8qOBWDqvb+DIR6CLi2XCCOKsBtt8gItE45hw1ovdlejuERgeHYIVQk6ZlrssU1ERDz+Ih2Sm/myQTGWQo+X1SgXf/00mJWCICyOtTduCACztVsBI60we7n08mPz/T6B8fdQLZY91Cv53ybZVAi+ADOR0+CTYnf3wD+tpnrnlJ6JbRBdd9qlxB/7XxSQ6AZi/D+KuLU6bn4paswZSu4DIyn1/qJI0aEfaPFfBNOR2yIKk5C8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad3788d-a1b5-4b1c-2abf-08dce499b0de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:26:32.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we4jKGOEmh3nWqfaHyVB4DgQ5SLk0QC1Tb9BXCvixIF2DmyVm9qhXJ37YmJfdYRfvevZwDopRS7Twyfc+CQQNfQwH8d1BbARNZisIbfqDTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040119
X-Proofpoint-ORIG-GUID: HsoCgwI5kkjcbZ0o1p_ZzzpLZrg6rBCm
X-Proofpoint-GUID: HsoCgwI5kkjcbZ0o1p_ZzzpLZrg6rBCm

Hi all,

This is v4 of the series which adds global variables to pahole's generated BTF.

Since v3:

1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
2. Consistently start shndx loops at 1, and use size_t.
3. Since patch 1 of v3 was already applied, I dropped it out of this series.

v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.brennan@oracle.com/
v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/
v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/

Thanks everyone for your review, tests, and consideration!
Stephen

Stephen Brennan (4):
  btf_encoder: stop indexing symbols for VARs
  btf_encoder: explicitly check addr/size for u32 overflow
  btf_encoder: allow encoding VARs from many sections
  pahole: add global_var BTF feature

 btf_encoder.c      | 340 +++++++++++++++++++++------------------------
 btf_encoder.h      |   1 +
 dwarves.h          |   1 +
 man-pages/pahole.1 |   7 +-
 pahole.c           |   3 +-
 5 files changed, 167 insertions(+), 185 deletions(-)

-- 
2.43.5


