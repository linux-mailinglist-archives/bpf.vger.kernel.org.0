Return-Path: <bpf+bounces-36239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5869452F3
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796D5B21057
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6A143743;
	Thu,  1 Aug 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ru3eIIuB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nn22Dael"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649631E4A6
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537702; cv=fail; b=JbtDGd4gREr/Hjpqe3J3jEoehNNP3tVVjv9ZCtID4Atwu/AurPQVkzgKtPZOeCoaM80jj7NGWiLqRN+h3MzSL6Cw5kV7d15uvj5ik9U941koQB59t7x2VAmsXvkG8WldGo2jmpKJxe2vo6lUi92r/v7He9z9lyrCZGIdtkLlr9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537702; c=relaxed/simple;
	bh=kWD8Jb8M3Q4hbsdpJYKOrTClTelnQayXQlcksAINeOY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OwxHk91qqfkmnxZR5nEWpDdVWCGXS6edXWSfWkEeWsqwY/QloYBgD0vTkchiSvi6eUHMuqik76sAptRVTcIoLtgRZK+IOOUJVIY1s5C55EOh29hEmSklUKZXi2yjURxggXKk+orVv1HmNZNXeBkZbQy/UYrTo4IZCVmSQxd7wrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ru3eIIuB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nn22Dael; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471H0W0q012408;
	Thu, 1 Aug 2024 18:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=DcRuCcAv+RYRzdcOaSH+vbr62MA2oQBPsbxsGw6Wlo4=; b=
	Ru3eIIuBam7qxN7X5J3ezr2J0xiFIa8OcK+7vojK9PfI7FVquaJ1yi7rsPw+6D89
	OJXp6Atg+xtm+hqqXpgVisY+7nrtrqAQVZ1tyibxtLSi7lSppPMk76KBbbihulLf
	hQ/JE3GNukGwseSi2XzuOLMQrZGAR+HUfr1Z6mdMR5uC9eXi2Jr0fohoqk+T/OEH
	szr8/+bkSZFNncOSi5hbu1i38ioUiRO5IwoGRwiKLFYPoxS4kgK4kD7aZScJ8HVU
	0++fhRoEWVhGelkexLU3UIGqQyyHnBWzWPR8/WBY1bAFGY+lvFTNu/bviNnS8whF
	gSd59E3BiosiB2c6KlTlKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacte16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 18:41:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471INWC5005876;
	Thu, 1 Aug 2024 18:41:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c38s4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 18:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp7MSujnipWlPZajwAFWImW9/CsggCRpakUWccoTrb7fz0kZXgNLKczqEVfINtKAajGCJcMVs9hc2enAdLymAt4uckAwtN2D5QqI3E7gH86qLlU2Z+6zc6pYhN4e2hchVL1x053rGrmtGkRSfqwQ728zYlMmllY+aY5zQYMIuMZ6OhY32/R1VfpgS0834l0Ad0VS5buiJtkpV189gtRiTn9BQq+bagsEndAWeH9zt7a21ByQf7CuUAR0cagEWu3aNYGdqiACW2N8+aEXQdznJNFUMlQe/e2GCQZ+SHWW5wwi/TZgufqBcAlyFS7VhZ9jUfuNQFiUDBZK7V1KNxgPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcRuCcAv+RYRzdcOaSH+vbr62MA2oQBPsbxsGw6Wlo4=;
 b=pYTAQkICTsUpzksxnPlpyOHFhs1wFnLeEC1YcKmzuyi+MxhP+X4hC/B1+fNoxt7GLkkA8Ia5AE26QQV+3iY60m3AvrMrcqCepliElTPmVdSeZuIBu9Grx7W0NsU5F63sbp37FwHBK9n+qMphyI318dLowQGAusD6a9LDcVDJKLwsVCSfzRyM7nKowAX9CodQ+2/HIzEs5mrxx+mGcOx+mamCTYOub0FwG4Ug4weR+XVppWc0ClPQi3JliP1Hlb2kUo55LrW3pi/YYKtDUotSp4eAlnCfDbFNoalspkvJN48Cc2qcBqcnO3VOQ47ebshizsUD6DPuXUpS7ZvI3uihPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcRuCcAv+RYRzdcOaSH+vbr62MA2oQBPsbxsGw6Wlo4=;
 b=Nn22DaelpVKfjlbDWQNaT+dIqLsVoz5Hscb5o8M2d8SYbWFfCloO+HEjkcs5NX1cEk86NjgBj6JwZHDukU62/T6t7iwwj4YDPJbgK92zIm9VWTcODUqsStwvwu3ddQDpUyF6RN3kyN+espqEPO+Uth+7ugOcr8iQa/I2uytW4Cw=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 1 Aug
 2024 18:41:34 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 18:41:33 +0000
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        david.faust@oracle.com
Subject: Question regarding "Add testcases for tailcall hierarchy fixing"
Date: Thu, 01 Aug 2024 19:41:27 +0100
Message-ID: <871q38gk6g.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d60f35-b5ea-4d2f-33c8-08dcb25990ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4bj4Bpe4FHKJ2Id5K5V+bFeBbTNFdMuXn9buxAMfAoS/SWSgL5DMwFGUPRIW?=
 =?us-ascii?Q?a7cV97XJ/QaqEk2AFnM5Fm9LggParS/9kfzKYc+9iXXRYIcfUPfFibPF0Xn/?=
 =?us-ascii?Q?2bWxdc2qQ6HJicti9/tC55tyeanQcDfaVTwL2rtpYTQWzmj/SHlLSd4VdsFe?=
 =?us-ascii?Q?KUoGWcqFxDGNqaOY03f2fabg2uCCAhXQbLbmFUgpMzq4+jFjDaLR7A3xSOMB?=
 =?us-ascii?Q?3+6dMc6A1ktzmnywg8ujUJDtlyUi09YKDCzrjE9TVR2fibJ/IMlYsVJrs+Yn?=
 =?us-ascii?Q?jedElwraJhVcRQxtY2DldTT1wcdRWKIZQnBBfg4l0Pk9IYuhWHOrbCfx851q?=
 =?us-ascii?Q?6Xqo8hzQ6rZrGklMo2/BfukgKaETyw4G9an0woPrzRdjNh3GDrrgQ1JlXiEx?=
 =?us-ascii?Q?W65WhxUCNuuHqnvCPMLns2nitsXSoHBDXr1hysZ1c2afOyxUFaVO8/0iWfs3?=
 =?us-ascii?Q?Nx6ZCRd3nPcZI5KkSS/MT2oNyZXgCiJpr0ejfmTtCsZyo+U+EDngUOgKwMPA?=
 =?us-ascii?Q?+5psjvoXvDtqNgFL5M/hq9WJSqc8IF24YjmRB+NgeQBUD38bhonWuCECDTda?=
 =?us-ascii?Q?goyPW482DWRVq0AZ3wtGemgHFzEGo+rU1CzaXSnQj5gxHWe5h1DMZMNEr1y6?=
 =?us-ascii?Q?3Cwq4o9f4UNitjAXVdGeILCKxlaooLkAF6pSosA4wWr629JeK4hbDN6CLTO1?=
 =?us-ascii?Q?IyTxKvdvEkN3rSidT9egw6WEJFRt6l/lFwrLLLVvzQ2gM8Kxar9DWydKMiti?=
 =?us-ascii?Q?4WW2ykgONGQiI4vDIJ8JvQlyGJ1LieGNI7jN8I4azQwd6UikZqGFK8T64W+S?=
 =?us-ascii?Q?shrX5DfQLD/MPX7kXnrb9MYHCQ7IphajiuTVgc4zVjQTFC1uOiuakutsF4g8?=
 =?us-ascii?Q?/KE0+ObI1Qoc0xRtp+mnfMVU4YPjAGg9BIWSOm3GPGVjdCE3rltfyZnstWeO?=
 =?us-ascii?Q?rJ5gcdJz8inNrPUdXmNp+B8Gv4Hfkwt3pPouyTXIO6R4KM0pXSLM51Z/sVfW?=
 =?us-ascii?Q?/xaEhEg8iQlIR8FTaW3G7cI3sUrKslXXaEaLOMNLELUP8ebrKNMREkxv6g1V?=
 =?us-ascii?Q?SgPp5O0l1ppDkx5LSO3qFiGg+zJzfFLLXWXbR4zd4aJ8RvMfblomgh36ds/w?=
 =?us-ascii?Q?3YmrJdaCaatbB8S25yZxtrKJvZpkgOx//q5oQjfmIW+NZoID5Ej36FJ6II+c?=
 =?us-ascii?Q?klsmz1Mymju5Wb+/JzctUI3HJxXzIafWtYyhudOFCjYXnbjrNsdFV6zAdHj3?=
 =?us-ascii?Q?hUjLRXVgXYNjJeTIU9z2vDxvJSjuuLu7KDniPAKr1mnuykag0ds//bd2Ryqb?=
 =?us-ascii?Q?2cjRSdIXN014twmV3pUBEIUKn1LqFLmy+4r1jM8WZ/9B2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAB98wiFMRBt3n7qBccX9MniVfoZ5YvNAr5NMhai/fUG48ym9f07uIIpxDCg?=
 =?us-ascii?Q?ww2Am8Kwsn8JCv73zlacZObeNE2mzYWElzijUliHCQyLSDOSZhSGWvA+ZD6U?=
 =?us-ascii?Q?vr+xg/NQtFw8APHkjzV4dJMstwDQaJlnP7nxt7PTUILqVSPbXJ0gxJSfmxaY?=
 =?us-ascii?Q?UNaPcTidqkwo+ofQcVlBKm6D8eWK1JaYPndRfNqAcsPkOmC1AGHCXk2UKAWL?=
 =?us-ascii?Q?MHSnVDzYhcE1tXh/5UaN1rPFaKz9+GDiiKmxWvC6lNudvtbkNHkkLJoF2sy0?=
 =?us-ascii?Q?jlBEz67gZQZzFjJ0Abu2xeQioAMqjlVN5+y7o8DQnX8UmdS0OpN/gtahOtqI?=
 =?us-ascii?Q?koHjaN/vqWqN6RJPLIl/kthBI7lXIREpvWf4iBoOFTnO3FNdeYYtGyxD+fAi?=
 =?us-ascii?Q?+VACf8jo5/SibGTIBgJyvS0tYjwAbwpB1GCpFSrh8d7yhZfgazXAHmxKPmVy?=
 =?us-ascii?Q?bT8kn0uuYKwfwBmqNEVR0kMHXA/XC/A4O8PBeOKGqvAH+VBq3hrcbMEHY8CY?=
 =?us-ascii?Q?wPzq47ucrb0tVmshsGChiefUSmAEP9b+pbIwXNtHOTUm21DQFT85UaXGFkqX?=
 =?us-ascii?Q?KuCGbaYAyMZ6zVgqbFb+VvBis8d4B7bf2QJbNwJKK4u41hEbGKscq1p66enO?=
 =?us-ascii?Q?iPk/CqkcsIuBDqtxcp2tjC601LgOHck+hHJagvK6Yju0XX6gomSQ+LQM6svQ?=
 =?us-ascii?Q?Q7Mg9o11ayJVhYtNsEp6A9PlNKw55duh2+xPjxK6iaUXRKiVQvQTYl314Ubk?=
 =?us-ascii?Q?eM5M40SOnP+QItkhOsGvi9n75kePcxgk0fhpZVy+6uQQEsyYpDH7y1pQ7mqO?=
 =?us-ascii?Q?czjUScMk0sTjtrsaXNxUfAop60ZTzZemcrDo5SU99S7v4t3JojRiCaAwXfdL?=
 =?us-ascii?Q?ZGfZeZxWusfml33rvAZB2NdbnQTyVTdKmMjkgqWeluO3DcotFiF5mdVOk9jA?=
 =?us-ascii?Q?fVt4M5LrCpiAkLJ0aJLwxiHhi8bn5K6CKGBuZvW1ed6RPtd5NYEVLGDAfsCz?=
 =?us-ascii?Q?mhdAcojxdcDRHFj/lKaILCSRGoXO875V8NV3b81CqG0Yk8713I5AiMHOnipj?=
 =?us-ascii?Q?ZhXY273UcVS1ve0ulj7RTe2OTG1nERODvrY8AjyN5RnSVLroK7a+lkVc8L0W?=
 =?us-ascii?Q?9ZKpx+7JMTF3FIdHIc1jgs+kS0e7S5GYkXkZtIdumgHuXVD2RxwT31ajMfmg?=
 =?us-ascii?Q?9yHTb9xOc2AiI4hcr7mfZBf4BHb0RmPTv0ze7O1Z3svmKPUOrOD/lodOpDIq?=
 =?us-ascii?Q?DOUv78I4QaLFjwtMDjzRaZkQe+uKc8rURZVKAME3ZhROM4wH5Jx/NHqhM5pF?=
 =?us-ascii?Q?5nRhPUkiS01f6KF7M2PlpV48P+6yeIUBVksgccRSRQH14WwGFaghqCv7N4x4?=
 =?us-ascii?Q?/YaihWJ8AyZaNUwM61EsOr+4cmrMivowpbcGNlcof5Uj4fNZeCD0HPzGH8WP?=
 =?us-ascii?Q?ExbmgqFx/FnajZPUt3do646Uoe8YEz6y8+H1z7Xp3xQO0fBGQ9NuLUQGvWII?=
 =?us-ascii?Q?O8uwBO0HMNGDNUMPsx+mAq/8DEqZJu0tY+karchi8MbrnsbQwEO37C9fKj1D?=
 =?us-ascii?Q?fLrvFtsI25aqc25uPtpCRgswjnN5l56/YDeDmLo6EKzUJrDIvsb1ZoDJZy1T?=
 =?us-ascii?Q?qPXF8B9hY5+JU5j5QwPxb+8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M4dASlt5dGT9eaz1BXU9ouygd/HUFrqRKT2Pn8yHU6ZquPQPEChVaC/ewp+kC/KoJ+vPpjwODr7WAVtQyfP7QAK6z3PB90ldmPy/m/UcctIjLf79nKNlC0kwlaQ2ahBl2mmRNWri2tWMuY/GAEN1KxS0FgHMFr7CqoFKqavzCcRANYe1TU0AUmF3eekR5Bpsuz5l89XrLRb4CfFmURMhrkQkwoK3Y6aItXfJ6TogaHAAZNyOOTBv0LjnHOTFELx+KPevg4ARVgNjkTERQ8HKjBeGvzeNbCGvLR96LLENfjyxjWzqWyd60Af+KjDVwAsWoFoNBpQtgEn5W95ynsyCZkXRsAeNCx8syxGEYPtTV9hB55zt6+BYrllI1MKOKy/MFlkZUeUxcqVf2iNXmlMtBqlflsk/fu5KQ0u/hI20HSWuBMVHWC0fcl+SG3oDSVjA4e+niYhoymWFYXH1CUeL5gHDIz9qsiN6A7ZhxeK+ez3WILT7E7UkFAwQ0rqxsjnoibMXyOoJu94dJjY60Nx5PI5gKFwlQ9O0171n3dds2EKGS8KQPTj5/qMwOYmjyOARGnH+LjqOq3UcZ8heYld3qAakfoO/YNJaQ2gC2BW7QaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d60f35-b5ea-4d2f-33c8-08dcb25990ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 18:41:33.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMby/dBPz2av3sTYyrcQt83yHn8rWeTmXmZ7G680bsq3s0wevW4r5pvw2pD30lL1K97x1csqNpAARUBJhxRAfjdm8Jus2jNOL8ZogieAh+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_17,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010123
X-Proofpoint-ORIG-GUID: OYcQ6Td-nnQAwDfnro2ftlv2rpzWVilr
X-Proofpoint-GUID: OYcQ6Td-nnQAwDfnro2ftlv2rpzWVilr


Hi Leon,

In the following commit:

commit b83b936f3e9a3c63896852198a1814e90e68eef5
Author: Leon Hwang <hffilwlqm@gmail.com>

    selftests/bpf: Add testcases for tailcall hierarchy fixing

you created 2 tests files that contain the following inline assembly.

    asm volatile (""::"r+"(ret));

I presume the actual intent is to force the unused ret variable to
exist as a register.

When compiling that line in GCC it produces the following error:

progs/tailcall_bpf2bpf_hierarchy2.c: In function 'tailcall_bpf2bpf_hierarchy_2':
progs/tailcall_bpf2bpf_hierarchy2.c:66:9: error: input operand constraint contains '+'
   66 |         asm volatile (""::"r+"(ret));
      |         ^~~

After analysing the reasoning behind the error, the plausible solution
is to change the constraint to "+r" and move it from the input operands
list to output operands, i.e:

      asm volatile ("":"+r"(ret));

Can you please confirm that this change would be complient with the test
semantics ?

Regards,
Cupertino

