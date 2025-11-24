Return-Path: <bpf+bounces-75382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02453C81FFF
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC703AC8BB
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01CA318124;
	Mon, 24 Nov 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HG9lzpSt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QnO6H5Wn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5A217722
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007254; cv=fail; b=XDTtz4F9w8g+/cnqTOGroMpbXs4QKyZg8htDWO5X+YHUDXEs+nekcZULSRQy207VtYdd5ZFi1sFmj2y9p5c59ZvxuFYtTdAsSGcWTflgWuJtufIQhvMHZvxFsTH8kTSR4S8QtRgGX6QJ6NWp+3g6CpK0qQE3GapVEVxlbvEKrJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007254; c=relaxed/simple;
	bh=X9Hd3ZzJ8FlvBl6+IQqFfiWyoWli3Tqo8JizAZl8JIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VCfUnqlWdOgSHXB1EKIgWdqpKdLi0SmR78iZFeDr4ttVgQwxtV6VPw5icdWc6vJuLyJaGzmBUywlXc0MJAbF+/CgmRFPcG+PmaVjY7HqGRjyaDCdc0HtEcDp/BPH/viOqLgXdlC1rnlQuXRBHEn3caJ70nO1LbgIqbkfx8YrMsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HG9lzpSt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QnO6H5Wn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVDLh1078620;
	Mon, 24 Nov 2025 18:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ePpUuxBv8gVfyYeT
	kH2+4GCgWSF4OIEJ1JU/3jfxT74=; b=HG9lzpStp3nI4FQEN76c0VNLzgr3jCj0
	Ik4vedDyGE/EdBGNrpltlsWHuNipYDjCe9wjAbMaiaJtR+8Va+KRxqRJErF6LZxx
	0rW8Vw8J0NFyqBr8EXj/hEG9btsfM7GVu05q79xQ3zW3JyWx+OofqqMBdwKyOPHb
	QXPM65bMNKQWjTF78KRrURIf6JjJ6cNouY0bmaLi8nirSfmag40rM5EFbHOc1rh7
	fEPY8IuEzJi/nDRMkdGoxzr5Pp6/W7AmZ7mdx8r0NUx07j2Lcy5KYkIgqqOvkdhg
	rAGkAdo8qYYEfnEurlrWCDQOGpbSEzm2/chdeffzxk+0NmRRLMAlkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddam9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOHAX96022628;
	Mon, 24 Nov 2025 18:00:41 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mjemgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 18:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4HBRWQ2WMiW5bNMtSMlddEETevIsoxqcHFQ6t1YguZYZPLKpZiTh+IAtsP/okyNhkp+k+BjRJo3RItoNfVaC7QBQ1iMqxMnHSd3RI0ykEcn9kNGfcbMXMSWuDKNftrKNrHT4Kp5Eeul0S+TAm8CfWu8derq9p5z9Y+6ZK5M+3nT8IkU8vswd1zQHgiQ9rHywYMzxey36HLHtS4t6uXsg4CyY6iisajGBspQV6J3GTSG0/i+wyzW8Fh9AiCspQgaLnCR5dHJvfWX+W+85P2U4bWczrzuClseq5aqqyLYfFacmBhFUT+N1WoBLC8M28LiWqMjlD9sg/sm//qfk4FJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePpUuxBv8gVfyYeTkH2+4GCgWSF4OIEJ1JU/3jfxT74=;
 b=PlwxiKUE6YjtuYnm148NsxRURWwbIQLAECP3YkV4cKp99OmprlV1bAEtWFcUZbBN5CR5BgV8wKYWgB8DAe/fxLB8DkOUbtgd+dzGaLGIHmWSQbioj28yn73kiKrR0uphBL/Ay+qxj0KyNxhMg7kjOj6cRuk02p+e7No7gpAt3ePcOuz41KtpRh1V1yPKIz1+I934Huhfh088I13pzLtjcdzXKnEDOjCaUKvLwDwHuC+/t3+E+8gpN0UaxOZmPsIgEoihXmTBoyCSIB22+0zm1kRMHVVPBCeiSq/Io3z2cMtduM3sWq284xiNMRJy+y7DEsYDJ0fFHrTbK+3ZZl/vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePpUuxBv8gVfyYeTkH2+4GCgWSF4OIEJ1JU/3jfxT74=;
 b=QnO6H5Wn4/PNCP+r57clNExMVZFPqxDtCOTnqDjSsy4lAmaIEfT9J4Q+fihZ30aoKoXQCceO4hy/iO7Htx1YgH40Gv2Tcy/xvvCZgcDzg8zvaUdvVjRFuE/NN2K2Tn+Hun6ScGB/CLy/O597IsA2rQDbeVfYDIVclTgkfApH9g8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:00:33 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 18:00:33 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v2 0/2] bpf: verifier improvement in 32bit shift sign extension pattern
Date: Mon, 24 Nov 2025 18:00:11 +0000
Message-Id: <20251124180013.61625-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0092.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: eadf186c-d985-4902-0f6a-08de2b835a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0MWEoFeIq/76aAKhiAdu1EXMcrn1+8u2W5SCCG3UWpLN9IliEKF49UG1+yFX?=
 =?us-ascii?Q?QZXM7i84H7g6GCNu3XMrJD9yE5kaiMe3gIbG0ip7xIQfY/rQOML/WcqCAjkO?=
 =?us-ascii?Q?gDvLJVC1+RWXdqYwjZUJaKjtZLQaiVwse/FXe7JPcEJ+rdZMlkNP68u+vOck?=
 =?us-ascii?Q?90xA5LZLsoLpG3ETzxHoZf0QAF9Jafa8qL4uY97r/iznwvTtZ8nsX2USZL9q?=
 =?us-ascii?Q?DH/3pE+At1wYNzHaAEFGgs0lGxEtuBvE0OQEsId8yswnkyh2zKeEqUNqK+3u?=
 =?us-ascii?Q?pWGQHkTAYLsRarMv/tnSBDtKfP65kKLkH9QJ4R/e1sLeY06y3Sz8lhRqt/O2?=
 =?us-ascii?Q?Txl9GkC0Pk8ChVi8F3ZQdY+Ivl5Hzy+q+8iSKArkLEvssveKmC7B5MM6jy0F?=
 =?us-ascii?Q?PbW29i0kXoisU+a7NKquFrwvGUk09FbA2JKiwzw9FpfAKoK00Wvvfnf06I9r?=
 =?us-ascii?Q?Wg9XJn1OOL7Fzu3KK644Ozr4KJ91feSaSAnU1Of155E11LnaIm1/PNzKJYnh?=
 =?us-ascii?Q?DeuFj2cwIOe8V7/kP7fH2nsO78WieyqjQ5zMxLWGIoLCeMWOqFNxEw4jg5vq?=
 =?us-ascii?Q?FyGPUxFfa0BdEeNBa2lwBg/nh1BqC/wfChNqdZUlAxgaKxe7l1EPB4Jvwjk4?=
 =?us-ascii?Q?AXuKCB+Fi72kMXqZxIW28989w+jnIdwGYverOdzP6TuivfU/hWLtwcOQPZON?=
 =?us-ascii?Q?fM/9QbDiEybrIWBHbTAoB/CXHjCe0+OXMxNH2mOL8Pzit37Rtxo86LqnmctR?=
 =?us-ascii?Q?XOA58j0pzfFN6UXAEqavgBF32CZUM1Rx5LaO2F76HdEWV8XZWqXQETALKkDe?=
 =?us-ascii?Q?XahFBAZWYOvL2hpvHH+7oU4nhD4968+dKWB6bvn6+jEIUGynGBsJ17As8LgP?=
 =?us-ascii?Q?M2+k8BkWysSso5NHDIBD5mo4bMwB/zPWptpsDbowj/ZiIUyn3r7PNYyMMnt1?=
 =?us-ascii?Q?J2i1N9KC2PmSWuE8FGm09DW5DSs1qifjkuu7t7+oIKvPlKC3acIHovlCf6S4?=
 =?us-ascii?Q?CCe4xk8wwIKF+HgM2dLRF7g8MJupI98df3okPs8a1UOiM2qnGXlujuyLK2Qj?=
 =?us-ascii?Q?9hluYdPUTMWvzFprWDxuS6lmuAiUwitiGlEBqSLE8d5JHI7+Sszh3bl2zTh6?=
 =?us-ascii?Q?As6naNwMZhVaKHBBrcl6BnE1x1ZxxiPMkjzQfMETgPc0JNtb5+x8WsA9I6OE?=
 =?us-ascii?Q?zOgwtn3Ra/xljGlsCcx0jN+m7Pax/gl8RxA0rms2Hnjy2QUZ5v50rCngwB2V?=
 =?us-ascii?Q?JztRHZ3mT0Bua0f0yNnPOxDslk7Lj5n9NAv7L1QmTVieTAT/qx1C5VYjKcdb?=
 =?us-ascii?Q?cPQ7xZ4jbiLREQ7c/8MRIa/vQYxg+NieQkNEdiIDHxh/IWx1+62Z5AlqCsR3?=
 =?us-ascii?Q?zjJsuk1cJ/NfWUkJSwQy4rPTaMi3ggj3cvldNpy61jsz94/2Pz6wXpr+dvXD?=
 =?us-ascii?Q?aM5ucuQE5SFQnyEU3dom8kMqdVC7VgUU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iR/Iq0FU8xucXnHWwfHXqSsROP1HZHriItOQ/hQe6nmdfsX1Qt1tnb53J94n?=
 =?us-ascii?Q?b9xyNvqHhRcd3YSBS2/Ythe8u4t25xMPoXWnVhrec5xNpGsU+MPk9nebqcic?=
 =?us-ascii?Q?eEhfpBy8VUFNLtuSNNBVV7Bl3Ye+Ttkz7f7BXNS5zXmVXxAnrTxT4QzTU49w?=
 =?us-ascii?Q?S719UZDHjcWQsffvr4UQ8CfN7jKfSgV5AGJwbhlmxE6IaqzD5LL5c58p5u5A?=
 =?us-ascii?Q?Q63zZeUG0j/Gs1AHnMfeK0mk4npdJCuXgMA7vW9Qinb5wP7W8+/k3Z66rftB?=
 =?us-ascii?Q?5ItzRBuaT3gctwFqgqoW8kFSiRUYu+USBcv8bNOYy+foVZbqshYiDLoiN+/V?=
 =?us-ascii?Q?HHHYPsTdkjS1Pu8QHr9ZMEgQDshQH0uzQRMhUfP86xfHLcXT9zLhmkGQl4v1?=
 =?us-ascii?Q?beLD/DaP1EGA85Be55DSdOy7H2T2iKTzYO6h9zFgGsFFWsZ9fCjKSDz6QRib?=
 =?us-ascii?Q?3qOkMunLVkMgRI1YDBGsD+Tn3T0PEU5ZEX2XN50oyp5c4QJzONgzdRIrLaW5?=
 =?us-ascii?Q?97EUQA8HageXdJsyI5gF+0qE06x/QMxy9BBDJJ03SzqRdLwZ/iT8sJ9w+UM/?=
 =?us-ascii?Q?dgj0fqpQMa1Og5Uw/hO9XB/rcb5Ohiw/XV0u8tyZYEylMtTDVqyQEk90YHQF?=
 =?us-ascii?Q?ThDJacHwVs4vyZofKog+F63d2bgcBGG/PmobXZc2HjF15BLMSG72T4UXix9V?=
 =?us-ascii?Q?K0EsCBG6/EQOVQAD0aUZTkSmxgenZaqsEERMUo5/GmXqKhiHxnrnSLrvoVdl?=
 =?us-ascii?Q?V9MMw2bLN4nzdTH/NHdV4sYmWKUChIwAOJM8iHsTKG+ZKqLtKNKzva3rtJsW?=
 =?us-ascii?Q?dWmJEX83DdsCQJ5FrTdtY2/TeXulh3MinRK45PzbajgrLJs5yE1PG72H4Fh6?=
 =?us-ascii?Q?ffV/Ll8HEyPcDaKI7LKHyJgMftW7QVgPj7FFohBpWEJe7E/6GllfN9pSTxKt?=
 =?us-ascii?Q?efZ48R4FBFkts59ovHDzd3+cztLmrCHzD7afR42ay0q8dXYmJcFEeovxfeIS?=
 =?us-ascii?Q?XWxGFUsDF94okmG1oAQ9A+FQU8LHqOzQEbY+Vb/h5tiPhtYk7WznbKqu1Ij2?=
 =?us-ascii?Q?HmDNbI56AF80sfb6G7rX6V34KhVacIJwiTPeXJEkTCAzIot2PyUMH3vhOadA?=
 =?us-ascii?Q?OK2XlFnM+eXvInj0hH589PPKeyuYuQlcurU/AE1ln9NOhN6hDo2PLoshxYrA?=
 =?us-ascii?Q?VLtazO2ytM1JmUGQuk1Rje3VU+tSA1a1sOiYuS6F5wa2CKW36HC8DMZHcbsA?=
 =?us-ascii?Q?ywnkQ1XI2jz9xmDOYXp9z9WbfymeEhyBD4YJYWJh2p/H/c/GS0WkpgbBVsuZ?=
 =?us-ascii?Q?/hHpHZ3747nYAuwTUzhukgdxhdH4zC3QfAqfutHMhMqJOfP+OULXMsl0iN0w?=
 =?us-ascii?Q?WzcfmU0d43ri74lQcvpl0KkNo/xJStn9BKPanR3Vh+spT6Cw2Ku/vRUFnwHP?=
 =?us-ascii?Q?TEPyhIyzbzZ9jH0PA31jR52pQYhNSjmpO+M+fh6tAEy73vzYNFnp8Umj9Yvr?=
 =?us-ascii?Q?s2kaisr9H4MrnryXx+8cPdjHK8JkvMf/GuRfXbQJ4YDwaA1sA8LmR7JYIYMT?=
 =?us-ascii?Q?Pb6KCEXm3zGl8sRyqNTUvjRRiwwW6fkkjdBoQuPahVdTPAJJ1zp8FhX78RCF?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LgaiUGkOiTbhG0ZxFvlaigzXNMtlDh8FHuxBCgV6PFiF+0ZXcZ9ax9BL834Hzf1MfhzF+fh6qGU8f+NOttUCCYTJCKx8BLgc/obEoVijtdmLpMUwpuBWeI/4DKWvu6SebXFMjl+CayON3XW3/itNN07gpbGp6cBd1NAZZ+NTqX78KhpiDV9DsOmfKJtAaqGbM5x6iBBIRH4DLm6la5MZv3fgESciz/dczzqIp8XPOOWU/3TXedU8h67VM9vf1w2jP96Nz6yreSlT4oCiI58o1vg7SkDgYkVMR4ZX2a7mbfIpygSiRu2ZxQojrSUhDwiKOtI9ilog2bTq5wlsqwyQkvz6Pust4FpI1irpcmQdzxJU3UNBd7tbi/0OtcErmEMJVI1dDU+xxPhYrmRD8SZlB//3iKjxXe+8tBJHm0PhEwPowrWGjLRI12SjYe4gor2xOlbRuSrBY7nQOb/TcT7N7hSFm8kRCFtByaZadUY0SjzAwWSUc6FR3WXjHA8F73MVIPFW9jRenxBBmkKsbhH0kJHsslo6b86jQueHTm73pCT08pXnL46UT8SCFjWyjvqyhmk/CPosV4mfpxW95PdKHVFlZiUZwwtX6+gBg7YaUcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf186c-d985-4902-0f6a-08de2b835a4e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:00:33.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV+vpFs2Y/SqTPnW0QOL/ZDEhbhcvs8tl6QnxEDcfp75LhiWkJOQxWJu4NWGOgcKiq0V8mESzhOhAmPbb3XFEhFEDen2wwQO8rnfdtLPwA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_07,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240156
X-Proofpoint-GUID: oWPxCWuQnYAoeDms8JUBCXo26d82P58A
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=69249d4a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=tDmDHNVo8rsm2W6MhaEA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1OCBTYWx0ZWRfX2z3C0sXFHuz8
 cE5NF8BokJm69N3Vf/D6do+z0M2+u46ytjMY1Kw76WOe3McENgQm9FDvsY3bGrDnbCMQVh5uuSW
 3p0MFgBxIT41zCYb8fcYgyfR2yn8too1CJ040QCGESNof6Wu/X7aqU4HkC4/5jAkSro7qr8Suhu
 M4AJ0CeRsUAnMEJMFaIgDMNWeYrVppOmHhb3v+tmABJfxjOzmuzad/GmRv8EW1IWM5RhWanUP6j
 clXHJHFbLacsEhu9R5fbzRwIQugz4fskehkA5dDSLTcELsuV3gbRmVAJRtk9skZmio2JgvZmBNt
 jpW9LuLAXjx3zE83zWGeP4+oVIDmKOcUImt3ooQwV2v3B+zmv0tAYSPTpuFlCsEyKhAOJ1dE14C
 6vAwzSvnxZVsLfFPM+rK87YJbeARTDv4SyYPMcLdJErpNTioL7Y=
X-Proofpoint-ORIG-GUID: oWPxCWuQnYAoeDms8JUBCXo26d82P58A

Hi everyone

This is v2.
Eduard: Thanks for your quick feedback.

Looking forward to your review.

Cheers,
Cupertino

Changed from v1:
 - Split initial patch in 2 patches. The verifier changes and seftests.
 - Improve comment near the verifier change.
 - Improved code for the added selftests.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>

Cupertino Miranda (2):
  bpf: verifier improvement in 32bit shift sign extension pattern
  selftests/bpf: add verifier sign extension bound computation tests.

 kernel/bpf/verifier.c                         | 18 ++---
 .../selftests/bpf/progs/verifier_subreg.c     | 70 +++++++++++++++++++
 2 files changed, 77 insertions(+), 11 deletions(-)

-- 
2.39.5


