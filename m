Return-Path: <bpf+bounces-62557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DBAFBCBC
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4097AE53D
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC31266B56;
	Mon,  7 Jul 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DzfUsdT3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YvKhC7Cn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD625A355
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921064; cv=fail; b=WKhfMsnIgTVZE4yJZjKKc2NNkk429EIi0wsh2Pd0b/8LwMOpdRIDzJCsLzUZVRqA2SWe32zyDj2YM2j6jd5AqAMAG/Rm/DnhbkH4+oGXNMqk1ZNwHzO/briRrpDTZA1g/OS+E7Fm8vBZh+6W1QE/R+5UKCVcnbYX5/tyCzTSMNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921064; c=relaxed/simple;
	bh=je4E2hpUOSkvzDQ7veKYqm1lJycWd54+CNMvmDxSpw4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SIvz5U9H+yj7qY4JhdcTuVQUTGDvpbgMUumPzZqKn/yJnGGSY/JpqOq/f+/A9vVyNssam0PF72t0tuUYDVp7i04Jd3Zuuvj6Tusws6tZ+g6AjUZ3KWdydd7aJ1ZfWirVKR37egwzgKF0AGnW7VnBt/wK+5+ptpjrcmDM3IyRiRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DzfUsdT3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YvKhC7Cn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567K6ioH017646;
	Mon, 7 Jul 2025 20:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2025-04-25; bh=nulq5
	fZCa5eOiByYPvP/Og8DRYDPjvQdLXrNUZdS6kE=; b=DzfUsdT38cgtFhnpL7f9y
	NOVFlIqvLdkSLF6yrWB0267dX48ccRAYviHhQkfDXgFssapNlQBvQNA65uW9hzyh
	PrCE5n/cK6TnAFdJcNGGXiqDMGj9yoP6e7WBW9LmJirVNWBJiJG2GFwW5e+17DH8
	ZXXolLvEeKuDhVhKUDH/JMzXNLMgNNfueSajC84Yv3GE3VruqQOOf9R3gw41qXwL
	ZGvUZMTaRjwGoWeyeGrVLDmINGtpeR+Kiw7ht+W/QeXZeNZopzQMykcdUiMISvWE
	2WktzXLpnG/y9CIGM2wODV6j7tp4z6NqPmh+IWfCDZs4aNG9OhrE/YUPFx7+GiEu
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rn0107b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 20:44:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567JrfKt024387;
	Mon, 7 Jul 2025 20:44:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg91jrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 20:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrcw3p4h063eGi4LkkR4qlAwSg11JXev9cRCgywRnbf558AukeNGAWoK36kpbs7PoH44gF47rU89KPhAFCP787F2WjFSTF0o7QuqcthxkqB0RL1UUQ0V3Oq1loi+FC0Lbxi9+c3/FNBSzs00Zh5qiScseaaEH71YTzFJxEahCSQqzau5OohrzsyFJV+LNZF3GtqYfyovZ6khJ2rLqsXi/AUAnz0hDiAIKvaNjF3TwP475CKa/vPn4Ax1N6XCZEgxuGkTpISRePVQ2c1c24cb8wWvUpLegv83B5A93PO2mAKeOigM+nG0OECb0BoFYKHEW3Nv8KNDY0Z3BczMCUhgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nulq5fZCa5eOiByYPvP/Og8DRYDPjvQdLXrNUZdS6kE=;
 b=ZpiE6AlvrZ0Xf9n9b68vHNbZ7OtUT5kMisTUtuT58zv18Wku9CIRTxnCbuyQ2Dq3GrjoFYY1MULTl9i2PXcliNQ6u4FstQxnM/9H/KZlW2ro5tgx6IHKNnKciV0gLnjmvHym4UrJiC8BQ8c1m359TZLHbQbqdCCykKopeC1VVXaozEoW0bGOPznGb9SljNdHPfUtQd4Anw3BTj/uHwCj/gh7XjjrOMVqOz68oLzJHqrXAg48zuP1S95FeWcSxFaLXzUlv8gOL9pKo7MxrmoT2XI+BV4wGYR1ghC7JMi9SiGE7mphPMIjvyXaryi/9swmMju4eRJNAiLIa7CVugQKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nulq5fZCa5eOiByYPvP/Og8DRYDPjvQdLXrNUZdS6kE=;
 b=YvKhC7CnfF7DxwrHBPuXSFVE1mWhGWlI1z9NurImLCaFXbl4SlL8xlRcxyhTMN2q+px1ImXRxKfjfauj6BouzWbIEsvcn/A0CIvPKBHISZfDfBcDEYU9AEuLDmotmHHDMPqUJkR7qnsdy3oXnGyvmCvCuy4tzj89wYNv3TIhYyY=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by MN6PR10MB7544.namprd10.prod.outlook.com (2603:10b6:208:46c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 20:44:05 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 20:44:05 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: "ast@kernel.org" <ast@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "ndrii@kernel.org" <ndrii@kernel.org>
Subject: Potential BPF Arena Security Vulnerability, Possible Memory Access
 and Overflow Issues
Thread-Topic: Potential BPF Arena Security Vulnerability, Possible Memory
 Access and Overflow Issues
Thread-Index: AQHb73/gGezcs/ER4Ui6lbLmIZ6b2A==
Date: Mon, 7 Jul 2025 20:44:05 +0000
Message-ID: <1A9DA34D-7AC9-4A77-A07D-46B4DD0E3136@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|MN6PR10MB7544:EE_
x-ms-office365-filtering-correlation-id: 00f06e33-5a57-4d0b-2ab9-08ddbd970379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YPR7PjwfQTRhPRPQgH09Sm40W3j+mtPuG0U0kqNqjbXfBLxfGmD6yTNdgRaC?=
 =?us-ascii?Q?NXG/6jDLuZqHxbfQKcYaHQx6KEscCwyft1E1kf2D5hI6ushb39RPNn1M+YNh?=
 =?us-ascii?Q?3INvsjHpBHFqgiyPzHXy0XFVr+QlAqaQwlosTc/5es+ec8rbtuvrmk8/5qMw?=
 =?us-ascii?Q?YJaI6VlVOR6w1RSv0vs+UIoA8Gapq8NoZU5BZdpxdhyqkY29xnTNObhHnpzR?=
 =?us-ascii?Q?q3L/ElHfty4GGDUVJfV6L0HBCxt92fH55VwihxMhGkJb1V0QX5subwmNNie2?=
 =?us-ascii?Q?/j2ArHNYG5CnSx9Ey9bjXZmk1tSeCOWhkkarT266WTFIQVAi4xEQ1CibLqYj?=
 =?us-ascii?Q?5obHbhhCiepSNKKUHE/kdSnmYqXaVzGT+Kr5/SU9oIdBJ1hREF/07lfL35uA?=
 =?us-ascii?Q?SeWUBtrpuCF2Sv0rCNLVxk3tA1kTBwq4GysTfTZkxYPNy3Xuv4B5XXZinJyk?=
 =?us-ascii?Q?+kNkChXZev38fXIAZbjOc3BZ7oUMBdQfydVlTgRemQejIJvgv5xGnzn+AbpT?=
 =?us-ascii?Q?MMkn/n1KHyEI9aR6iIxYtFHd5lPUHwEK/+qQtinaJoJFu3u3bI2owpMF7xwz?=
 =?us-ascii?Q?2nILpTFAkcZpQWMF9huezcf061/gSsDZR/Qt7R0AFz9G48fCcjhb7WBm0ntQ?=
 =?us-ascii?Q?y2VqFjChUmpvxBM0yq6ouuslRpMOER47FKZLt/n12urDEQB1Ir+cMOGfS71u?=
 =?us-ascii?Q?ufQW+/0p05Evq3JFXggd/Km1SGg7LT0eU7+luPK6iZ2yz3+TAt/QjSjz+4DX?=
 =?us-ascii?Q?9yX0yK7AtKBUK2JoZkjEPddWtNV9qb9I2gzao8R1oroGfhch6RyGGQFH6rnN?=
 =?us-ascii?Q?ao6V4SURsANbftNBfPXHpsq5ssB7qgD7jFuT4C73XAFa7QWqe4yu58kR0F07?=
 =?us-ascii?Q?/NS/d1khG4VUxBfrjHHnpmBaOmJSEJCt5MFP5GZEkebGnpAtNqpWxQauWKvC?=
 =?us-ascii?Q?BT5ZpUSh1UqkHi7zIbwhbfYAI8MvjGd3AvvnuklhXtBokRu5aIJI9WNOCvbQ?=
 =?us-ascii?Q?XzTAXfAppxX8Zeop4NC/2pViORgge9TcBHsLBH+2nnZBK/Rq5zOq6Qb6knDL?=
 =?us-ascii?Q?pRB13tJZM2dLMx5lcpn5fN3NrpHBpIYzqYV1cFHYFXoA7Gv7IGS6+VVPiqmc?=
 =?us-ascii?Q?9XGEObw10BEXWlqBRYyKF7LSDPOc5joqCkkeEmG4i1UmhYN3zE6yn+5gPJhs?=
 =?us-ascii?Q?ssOLooLC7xDakYDRlHO/B5e4+PgnMg4XMvmVH24RdrAAcqqfjCv5YN0R+nRW?=
 =?us-ascii?Q?3XgvOt3/2IJFIknANVdgO5D53rf0HdztE9X9JLUtjKmk7EdbKTXJu5JEXV/h?=
 =?us-ascii?Q?pH69L2Nc1lCoa8aOuVVEtZlxYPIpIQy2aMEIPV/pLU8kwf7vgTlQkgohom18?=
 =?us-ascii?Q?Ybz/TtFVruK5lQpA33yUjbBWGvweDPSX5sJi6N8dA1HAewmkU8HuYVQENwNU?=
 =?us-ascii?Q?9oWxEK2hG3P6d/oWXQ8hLWIzM0O6EeRVA7qrAEH652fJYtXOcvsR9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2rwlhI+ZR1d5b6gLM/mEKMu3j7LXDWF9NXYYGfGt4F+66dczr+N/B87ci6Qz?=
 =?us-ascii?Q?X0TVpwiB7P5T8bmTx8nlULTewtM8uJQDkV+8gtPkyaEf4H91ovC83wnKa+C4?=
 =?us-ascii?Q?XiFWdD/CzgPWWUfM3EvsriIdopna6Ik1Td/Dse47LCD57BEr/xaPXo2U86xy?=
 =?us-ascii?Q?epigX8Z2+ftpIvfSmxzrklx/zxc0tVOp1+OtS74+84LqIoio6WrEETBMmp0E?=
 =?us-ascii?Q?vCr0duB6TR1gSmae87zJ4R7NRp/VI0SsaLsn8X8V17CRbJ8OOfLXCotA2iW4?=
 =?us-ascii?Q?0dkjxscVLZGZBZEooFRHATsKnbbV00+zzZWA2vHOmcXhBIE+VhqMnEjBOAwa?=
 =?us-ascii?Q?f1Gip/3RIrLO9Nr+DcjG5CbokNJMuwjQBprdX6CDtPQtxYgxGh7SgFHndo9f?=
 =?us-ascii?Q?F0LYdtK0eyWR0juYsqjcpRPHD8K++Mom3UVJcebS063fGgBo5E4okTs/Kccu?=
 =?us-ascii?Q?Y8vYmXYzdYINa6LiJBbQNH9Iam4K37VhMRxjlq2KjBgGkmu/Dx5PmlXaZIkH?=
 =?us-ascii?Q?aq2bHpoRSzdqTtzXAT/FCUgh2E8KfSPsl87OLF4weVal6YafhSNNM7/yekJ/?=
 =?us-ascii?Q?+bMF6DcPQkNszYIBS2oVSML5QLpisPdKMoryvpdBRAXsWgFZO4zG/g5N6YXV?=
 =?us-ascii?Q?DkEe9eHztuKtIy0XEhP4+ie/rPusT/E4XkYL1uU36TmeCoOLoT8tJsuKOdYx?=
 =?us-ascii?Q?XKfOm1HnTje3KSCMTVjZNU7Qey9rOiU+Cxa2+r6T7alcUh2k1ijHg5EbbuZu?=
 =?us-ascii?Q?Al4E50XJlmydX5BuNuMm3HnRnajvFTodBazZ6i70FyHfyUlPSaD4UrqEGHZk?=
 =?us-ascii?Q?XDgli5jkQi2RfldWr6RCh5u9i/hi5TLpH2A4gUue8F75WY+vXVE1cCWXQChn?=
 =?us-ascii?Q?E+BGrD0urIbpMMDx67UkzbQLtZrvcRzmY3cVJjJoZHsVDKruGOhbhoLkJBBY?=
 =?us-ascii?Q?QduL++M5F1vaXIg1r4587bFLaQ/ima/xPqPfHN5dWYVKBxSKNJL3VGtkdMYM?=
 =?us-ascii?Q?duuFVa6XTVDMLe1Flfv8GTfMKyXoCvlTtxlTxelVOB6PhiHeYyOAbMNjEAxc?=
 =?us-ascii?Q?xZnNkTES4b5xHr3yDjXtQ+tpd+TQletisl8DjlvrGEx2nxoQG5CDlZSH81xR?=
 =?us-ascii?Q?VYzwtOF7AvgrYZ3kp/gjePJ3feiQC2ESHyuXGhFKuHC6MRnVIGy840huWjR0?=
 =?us-ascii?Q?MBennEq0aQI0G8qxESDkpY84JE0fupz3atqlh2PSIas0M1o0SMI7VXArcrz6?=
 =?us-ascii?Q?uJU/yg2fGihCtk5slIpLpluHxmAMr7TGgWpvCWEeKz4+PwyICEsVpVQZBUkm?=
 =?us-ascii?Q?zia/T399UU3ew41nJa3ryQ49FlkQSKsE0Iyy/FLKGuukJQnai1/t8dsa7vr6?=
 =?us-ascii?Q?Wlqt+iZ393//7xs5JOiU1gRzRzS0iCzk0BZona5mxQiYMlyEwMSz3xnGnse1?=
 =?us-ascii?Q?4yJkDRiS4eMqPNiU0FtGsjNgzEG+Z32KxPSBu9UsGKiVO+KoyMI0/mrMDkud?=
 =?us-ascii?Q?x6B0sCCo+Jr6vcFGeDz6Fb+4zCiCQ0d9RJ2yBfso5FrZ18FYhcLzUos5/6uW?=
 =?us-ascii?Q?4GA2vm2HWfT4V05DLYdmscIvcZhfOqP0bbVVvyWuKADq5fSB/p52/Qmwb1H7?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A78CAC467A4DE4FBAB1F2D34AE32291@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UxhsGDSnGqH7Kt7IbMDJTp1XILU8OmE33tGK/uD/7VklLQ9ozn0qIcWJGSMNEiR1QeL9FneYI4vbt18VV9719nUN8UuugM/WcuJoONfd9Q0q8Xye/AqfQQ6XktBwmDqlguAZVudxnpp4BGP2tjaMSl6kIARycm1jueotXH5qb4l6i6ETLcjIzK2x7LjNkouj4kfCxsM7rfNcPV0erBFPtPz6IbCCW4/LWIn+U2Rt8N8LmdL/2pmIzSplIgpTvoTzxD3ORVxzN2S+NQMUzJV/dEXOrIazsl7EnJBRrOzkBnoRVrrCuWGJgox01jl9Tboq2lO3gVInb4uSOnshM4ETcfrqyzGJV1i+FiwvflyaDAJdsLLhzbevjzwNlUB9rS3Gs/I+9Z+VSzMV71uEAqj+GNg/vhwvoVj97ltU4FKIs87DZ5EVpoRPGisHxvb/h6Ho/6TGJrwA6F4bE1nR4tlrJP++kFlKqvI4/OyoxKto8CpvMCO6/h8cTh9+mJOjwDyuPfkeRynekPqUgYxT+AafbMAuGgK0qQ1XVALwbdqQy3zHuiULmPksllC0MYfKWlYTkQSCCtYNiVCEXI1+57IRz2JUU/ZtVuaT3zw6bvUmENQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f06e33-5a57-4d0b-2ab9-08ddbd970379
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 20:44:05.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HY+mWFSBf3aR6iRGgqwBY2GzhO+IqnYwt2QalOGofkMt1unN5OZLiyXvpqc/OcaM1Tje2kZGqHlaYzC2IcMolw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=877 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEzOCBTYWx0ZWRfX2MMkn5CIhYCp p3Kl/fpAzHJTGmEn6ryb6MKkaJMMWbChoB5BYldNKRUIsFZiRAXrZPj0/7209cXJyR6UXhZcBcJ k6AXUxckBZCxs8y38h5ZPpMBBH3LCeBzbI8UjbJX7pJdR2+yE1fQPvjzURHzMaepK4DPuO6lPE5
 VETn1yT/SUWXKRL7W4s9DW7yQooYuVLCCRfYn9lUrlkJfvXeVqZRMYn1Hq7DjiBwCe14Ff2xptc Wu42JmzHGymM+BuPp0jxVe7RMvG1YmiAqU3Gpr+1MInJVw8S2GAdt1jLMeu+8TV6S7ubAw5iSfx Xe/QqkdVdQgriCUkeALSZHbmcM7oN2x7ikgB8xc/IdzMhiX++ZJlShRs0zK/Gmusl/AsdswguzH
 x6amvUtHzsAud99R5dafvkDS/Y+3PgewYcJi6r/RM45P/OwLgIR6WUvmyoHxTiYoPILLV84/
X-Proofpoint-GUID: e2V24jW7Sk9ThuXjByb6ET5T4urIpAP6
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=686c3199 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Uph_BBUWqL_cey0OrWwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: e2V24jW7Sk9ThuXjByb6ET5T4urIpAP6

Hi Alexei,

I recently noticed that the verifier_arena_large selftest would fail on the=
 overflow and underflow section for 64k page size kernels. After a deeper i=
nvestigation, the similar issue is also reproducible on 4k page size over b=
oth x86 and aarch64 platforms.=20

The root reason of this failure looks to be a failed or missing check of th=
e pointer upper 32-bit from the user space. User space could access the are=
na space value even the pointer is not in the assigned user space pointer r=
ange. For example, if the user_vm_start is 7f7d26200000 and arena size is 4=
G (end upper bound is 7f7e26200000), when I set *(7f7e26200000 - 65536) =3D=
 20, I could also get the value of (7f7d26200000 - 65536) as 20. It should =
be 0 if that is out of the range.=20

Could you please take a look at this issue? Or could you please point me wh=
ere is the place doing the address translation and I could try to provide a=
 patch for this?=20

Thank you very much.=20
Yifei

Methods on reproduce:
1. Use a 64k page size arm based kernel and run verifier_arena_large selfte=
st, it would failed on return 12 and 13. Or
2.  Use a 4k page size arm or x86 kernel, set the page2 start address to be=
 base + ARENA_SIZE - PAGE_SIZE*16 and also check if (*(page1 - PAGE_SIZE) !=
=3D 0) for return 12.=20



