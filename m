Return-Path: <bpf+bounces-40805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BB98E770
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21DE1C256F0
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABE1A00EC;
	Wed,  2 Oct 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmAtQPJn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPJco+X5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B71991BD;
	Wed,  2 Oct 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913225; cv=fail; b=UzE3zukf+EHVhukfZEo/IIAecc1px+15tn9nSDMR/AFhobZ/Sp54AGq/1DqSUjSIWnKkR+OG8ZP3s1Fb+CwWhU+kV7/PVPM45u+5696SOnJwr/tUNwqod9AET8uqeIgdW6Xb1t35hFALSvweKvEWZulN4pOAhVQIuLlSm0/JHJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913225; c=relaxed/simple;
	bh=rXmZNM2jSdpu1QBTzUbSsKG4v4v4hsVu7KYkODgReec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfHjJ7yDiS2PVdbjvuP/Mxy6Ay9RN+gPLhsiFnyb/W8N16alZnwQBSsLDsoCdyZ+h5oZ9mWIMUGi9jYmtPscHRSs+ocSXvbLVCkv+RkPFA/2Sl7bPsChhK6f6vyB97AjAZ5jEphjNsBvgqRb5KKHFGBjIHwacwug4uafjIXE5nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NmAtQPJn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPJco+X5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Mfawv027744;
	Wed, 2 Oct 2024 23:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=UAxRwZtx5V2p0Ij2CY0NVjRU6jWJ/jcPAJvafwzIleM=; b=
	NmAtQPJnkXEVdNLqbk9BqnVcvOff3cGmdxL81ZzLiqd16BuHHw9XOOQtfJXQmSdC
	5usPAHXFx2uOtLcdC66Cd8cs7a8zAFg606UMKXtdNhf/zfRfcf/4CWawAIxzz4AL
	9zFC5onUxkLGwCSlR2TL71pMQdteTOlWQCi5J7+qjo8Ou7KEmFhMkcABOsHZNMUl
	Cs0HQWDsAeFcUlq3fBKJolvVq8MEF3jGryypQ0ONd0eQ4bA/sTFO/eidmKztLnwf
	p+DvKHcZIYcXMgW0npoggtkcwnowQj0V2q+kZUqRiZmfSP9VRdxhN/L4GS9k+m4c
	+UfFPLfvK0UHPmualXNi9w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt2xg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492Lrv6D029452;
	Wed, 2 Oct 2024 23:53:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889r8q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn9LSHPQRdlRpyNTViDxiNS41i42p6lbip4KIHC28+ZwI3uUwOpwmk1k6F6Tx3sTSRW+PB76zxuCzXn7cIqVIPBko4zlIRjyPd06bXpQe6x3ohPhRi+s2PIfWJRciOx1TaTwGMs55jPv5xSwc/6TUYxH2WT9t81/w2wkfLvWfoHO0aBf3ywKGr31pVUxtIQOX3xQjXwnzGpapTKaxBEyjzkKhHFqrlpgKIyMQnFDrYMUUV0uWZ+FWynCbU4YRnn0pFSNhiy9yA03kk8MNEIcR+DrDA3pQjOdlpdizMrW9azl3DsJwsLej655L0X5ORGkjz///SSXAvdMleSzbrUN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAxRwZtx5V2p0Ij2CY0NVjRU6jWJ/jcPAJvafwzIleM=;
 b=JhfrnyF93+TpUYzSn6rnFKHD/+wYs6FiPzk0D5Hti+me6FkL8YYuslhcMerdnPnvQ1EK/3kvSQPLNwh+8VkHiH0anQ8zlBAbaV0UjB4t2mGPUET9Y21o+Y7dVWNhSUYO64uqkdBHThDearI0du2LKqi+3aU0EtR9hA18DcHEs8zDnk31sjZkzGmzhDxEMuudR+edoYUnng0WwFspBGefC77raXLu37vv5afSafWZdrAEVj+5AFS2FR20XYqg7soL38WwiA9kDFNza8MW9J42LANQ7nkhPjkJPbFFKcqanvS1yF1vrBZmCelpCeiX2Rqx+KfsSMn8WIcwnH7oR0eHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAxRwZtx5V2p0Ij2CY0NVjRU6jWJ/jcPAJvafwzIleM=;
 b=EPJco+X570lPtOn//HDnmsBakExYqd1aSmciO5lbEy3KaLa8dYx/AQKTNhkBI2nkm/o9zf7JmElq+8yAoKH3HYopaKn+X+wj2v4C5VBRiESBQyHttDgCFaCiY8OGNTKFSBMWDYYJKZJR8YN29pZur6KqWTFd+1B4TH7/B2KNTaw=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:53:11 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:53:10 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
Date: Wed,  2 Oct 2024 16:52:47 -0700
Message-ID: <20241002235253.487251-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:408:4c::45) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|BLAPR10MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e397948-7af5-460a-896c-08dce33d5ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+brBr2OBGSd26tQgKPQX7S0hrZ5ZU2uiG8CaoFI3xSM6JMitFvzoRCUAmwL?=
 =?us-ascii?Q?kmx5PIjMjHssNZ0cWTes1k74yZyxmkYDBROjnXBA5GYHzbA5x0vmKY9CNQuE?=
 =?us-ascii?Q?VGdHHNC+3RgC8wiciYqCINgSXRBLZ6yGp4hpbgoc1EXyI8g6TX1sm2jE+3JO?=
 =?us-ascii?Q?FRSoFz/eQTp9OvWJ1gOTJP9b8Gupgl4wt1D2pZGnqkNU37YF6ZOftwAUjNc8?=
 =?us-ascii?Q?acEN3164Pu50G0iQRp5TGsXCSs8BSucG3Kcm0Vz+L9buqi4pnqcpl5sm26bn?=
 =?us-ascii?Q?xlvQDNiddwXOnfQQOks4dio6j7nWpOzSBct8hirWG5b82hEte0HOVtpBfFch?=
 =?us-ascii?Q?ZYgw7Lmi5FjMchDmWfm44N9t0rVSK/XSJwcjLZKXYrJREiLt8LptjHpfffSi?=
 =?us-ascii?Q?WEqUgGJczJ93EenIt37sxU6lvgyrUZ9dY5sgijIaApcc5zLSSTK37yjk5EXh?=
 =?us-ascii?Q?N0eeASoSWapy8xX9SQI/c9a8oN5WbihPNnGQSxhAullUm+6YYUnx3DjAL3Qc?=
 =?us-ascii?Q?chSdxbJ6wWSct4jyfM+rzAqu/4rxqUAnqxEUi9lbeMVrNazHtIaUuuwrC+Av?=
 =?us-ascii?Q?qU/Iqwc5wOa8jDzma+At7tFe3bLXrHkTjGgCyqFDUypGBamS2rtzVGeecpFc?=
 =?us-ascii?Q?9As/3No01o0Glg54g4k6NP7CZoPA7/waG/qMWKAm8P4/v7za5KseCROtR0+M?=
 =?us-ascii?Q?lFmZYiNVq+1wKdxxc4tJ4YkdualXkg06EFMctoxRQ144bCfu0hqM8wHUuwNT?=
 =?us-ascii?Q?aB72TD7XADSKjhHawJN20a14LjwbQSMmZMsmSQLfdsbI8QO2TwxFYbKysVZ1?=
 =?us-ascii?Q?0bdQC6yrgHFH1h+Witk0aYKxnjkRyW8ktqzZ/mmP/dehlh+3iIOQ2aRm5nBp?=
 =?us-ascii?Q?aM97lArZziNWTRs6C1CybMh2m0xyttgm8sUfyt9qxNr9W0DdAQHgaD3xHHlR?=
 =?us-ascii?Q?dnm/tCVYuZwJBxe7b+7PDhVPkwi3HwFnni3ylSELXiRselTep/ofSWqhsjG6?=
 =?us-ascii?Q?gPqxl4VeJZXGdgluSlmEiVkaiVr01CNsbGTqoWkaQMhDGu/+z/cVMOqyb7vU?=
 =?us-ascii?Q?/1tMWONalxnG5ZAHB7FPcolzKKa5L+a3Q7ujEgyrUIlN36Y+3GixZ3ftYUHq?=
 =?us-ascii?Q?cchjQRwRxPM8Y/nW2K+m9c0vAs/o9lQ6rhrpnN4cjbQaAFIEram+4bnCTLsc?=
 =?us-ascii?Q?45HNOl4LRqGTqfKy2TUvrzFVhIj2qqpbDqHZ9Vjv95Ef0VJVj2M3ovvMcbYo?=
 =?us-ascii?Q?fWAbNWiLdfC8vRY/sr2obwDn24LA6ycycHx38ELC5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYGtiSNaCTlkfH0QqdFIDnhlvis7L3pDrSzOqYIwHUhIdSYFnEz6/tKP53vO?=
 =?us-ascii?Q?RFBBcxjE0vYDiGFXlxiub4n5MZ75KokXye1ZJNefyawBDEUK/ZDCCVQtnUQK?=
 =?us-ascii?Q?Hd+6ffQ+GoTc7wMDqv1IKR1fUZEyoC7tUTqyR5fw2yUdXzYRSxNpaXc5bzRY?=
 =?us-ascii?Q?w+KI4smq52nHhJ7PvVGeLmYxZsMEY1ihRWPp7wP/QPf8uafpW6JZFfBAMp2y?=
 =?us-ascii?Q?7+XzGEBQIAKvvUxOnU3MMirOoH6TxkhXlnSNAvveNN4MoCLFspGqH4wZkiM5?=
 =?us-ascii?Q?8VzWnW9FGvxXciLzVqevKEzSxvr2J/reoLKe4cS44zj3TizpENz5g/X4klo3?=
 =?us-ascii?Q?XlCZ5Q726Yj3P+LkSJR6KGkLGBmEBMCHuh8WYljLWxvXLdYKwei3XMs2gITb?=
 =?us-ascii?Q?ea7ePdBATOBB2XTptLBhNAXdMSNZGAqIzP/2fRTWGEv1c+YdamOOE5ng+tr5?=
 =?us-ascii?Q?vG+fnF/eBPTL8WTDURfBE4mkfs4fyi65on0MCvTe12yvil5UG6dSL8b8OgPt?=
 =?us-ascii?Q?oJWdVkjCRBHHakAX7Mng2R9fQvXxVjv7Kkv8p7ZAxg56BxkHEYj2H3SCYhK7?=
 =?us-ascii?Q?lPo49FpEeG37kfxhVy18MlZlW8juvyUauk1iss0Bf7uUhsWS4ReX3Cp/XWOt?=
 =?us-ascii?Q?pI8IVQ+5TgQu4eves+BDYycNEtycWpiMQ+R6uLzhOsqM4QjFzXB4ukfp/FVy?=
 =?us-ascii?Q?6UMAzRNOjHjSaiUL9Eeu+nsM85UofmrT1C7vfxlhZgfiAfTICxQfzUX0oy0U?=
 =?us-ascii?Q?QCBIMEakeCR6wEokBP3SBoWcXhY+lyw6JeWZdeW9O+oXtZjPstJP6fOywrQ1?=
 =?us-ascii?Q?PABx/CLxpKbF2QCzM5Triy/O65YFZZ/AnEBNnQyUsw9ieJe9hJif91P4TYV0?=
 =?us-ascii?Q?Bm5HQ8lzxqhvZPyw0lTVqRpFuVSrpwRDESNVu/4KIx1RNQo9EsM9mDkJBnv8?=
 =?us-ascii?Q?iK/bmpHZKuKD3KJTuqI+1KXKaGGNsIcoPkrrMe9aEO83EC7j88AdPbQcFrtr?=
 =?us-ascii?Q?fZdY4BS/neGFB9yx5ZZnemFsUzEj8d6keuI9wE8yI313RkljRsyj/MsK300i?=
 =?us-ascii?Q?WttyLhfSXBIt6OkC58g4pk/iHuUnDCr+up7sS5Y+EBQQJwAPmCLU0VSppUsN?=
 =?us-ascii?Q?Cn8aosMmtLO7hFAdRMKTTRqK3Ect88EBuu3VpWNCifQsqncL0hJnJbSTcnqH?=
 =?us-ascii?Q?GpeCyWSNTZtK8WA3hiU/NNi0RS4W+q6bVZIiSdds/LMoh+Xx0b0AeAU81y+n?=
 =?us-ascii?Q?ZqR7po7vwKm8CDmDheAUQloC1EDv8vY9PuAYmXsybR6uyuCWQOKq1suP7PIl?=
 =?us-ascii?Q?TL2vAgDoGSSqszncaTc/EAsT8LH4bicrgVMqIT1XNo53E+Cda0Da54wvJP8n?=
 =?us-ascii?Q?6xUv+Yq1qckYpw9EOWKR9OMKO8tEM8PIFZ+qgPLJNMVBxL/kP9rKOv8v0rYG?=
 =?us-ascii?Q?gqiw4uSh9HbnFQHxWQLEmLJD0GxW2wZkA1PHwt6a7KuSl2OrhMIPTIVcFtxY?=
 =?us-ascii?Q?Ipg1BN4aoIYtUUBhnyVpyD5wAMCI1bbLrcjSyV1psyPnCkG5tosifxkliPXQ?=
 =?us-ascii?Q?dkKc13c5CZ24gYogekBGUs+CuyTzhuPGZE5HFFi5try8mUae/3qVJA7N3Rvk?=
 =?us-ascii?Q?0yWYslJUZMf0hPWIfYTMhLs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lPws5/Ccsasrh2AxtzNorI2pI4TU/0N62ty18EQCDJqPv5kFJfI6zCRje3VmtbuIla3tiEbf8fI0C4acofDE9BIQacEJmYhTtz57TvCBODFiOrQBalMNj4QVHtMvt4iJQ9mp0+eoLG4SX82dNEU2OfKSvSayzA17eCLw+XTam9VapVWDP8jx5jScK+GkzfJ6YjDkgm108MUSdgH/svsKggWh78LQU5VaZIoDuc58hQbzXL6+do0oBfzVuAP6jf5JASHtOBbMxQPObLZIlLls/AjCEavaXGL1xMWVu6/y0FtZlGBh8wcY0R4vNcJPpI85cGWzwNSheEnheHULaH/gzLshaq+BLEv6qrUpUdV7AH1tPaU2dl0jTOm34MDAINltTkvh+X/fPG7WglbJJGrrvWmcxLJKnN7LLlBFhP3SVJkbBt/duHijJppZREBH/CaXsdFgI/cDbSPhtnZBkxENIGHopN+YYqh+4AiseCOWFlx3Q+g9k9hHylrToDZfj/KfA5rx4XdBxBQBsuApb6EujMPe+BFl61jCQdZzL+eiu4GlW2PQllZA4+3yoI4Iyy6RPZUOH31U6AtkqfB2aUEvH1oS6FHGFYakd95h5IMxteY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e397948-7af5-460a-896c-08dce33d5ecb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:53:10.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1jCU85C9NcprUVLbhYvCKAyLTH9i5/oMG2lKDBHlM5sceJ4Sm9T8WspyAhpAQUl0VnMY+yIHBhKSj2Ds020G3TkCFkBNNYJAwvkdMoV5K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020170
X-Proofpoint-GUID: 5mVxvaVoV1GHSwcdBGYS6Utpx7ip9e0b
X-Proofpoint-ORIG-GUID: 5mVxvaVoV1GHSwcdBGYS6Utpx7ip9e0b

So far, pahole has only encoded type information for percpu variables.
However, there are several reasons why type information for all global
variables would be useful in the kernel:

1. Runtime kernel debuggers like drgn could use the BTF to introspect
kernel data structures without needing to install heavyweight DWARF.

2. BPF programs using the "__ksym" annotation could declare the
variables using the correct type, rather than "void".

It makes sense to introduce a feature for this in pahole so that these
capabilities can be explored in the kernel. The feature is non-default:
when using "--btf-features=default", it is disabled. It must be
explicitly requested, e.g. with "--btf-features=+global_var".

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c      | 5 +++++
 btf_encoder.h      | 1 +
 dwarves.h          | 1 +
 man-pages/pahole.1 | 7 +++++--
 pahole.c           | 3 ++-
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2fd1648..2730ea8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2348,6 +2348,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->encode_vars = 0;
 		if (!conf_load->skip_encoding_btf_vars)
 			encoder->encode_vars |= BTF_VAR_PERCPU;
+		if (conf_load->encode_btf_global_vars)
+			encoder->encode_vars |= BTF_VAR_GLOBAL;
 
 		GElf_Ehdr ehdr;
 
@@ -2400,6 +2402,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].name = secname;
 			encoder->secinfo[shndx].type = shdr.sh_type;
 
+			if (encoder->encode_vars & BTF_VAR_GLOBAL)
+				encoder->secinfo[shndx].include = true;
+
 			if (strcmp(secname, PERCPU_SECTION) == 0) {
 				found_percpu = true;
 				if (encoder->encode_vars & BTF_VAR_PERCPU)
diff --git a/btf_encoder.h b/btf_encoder.h
index 91e7947..824963b 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -20,6 +20,7 @@ struct list_head;
 enum btf_var_option {
 	BTF_VAR_NONE = 0,
 	BTF_VAR_PERCPU = 1,
+	BTF_VAR_GLOBAL = 2,
 };
 
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
diff --git a/dwarves.h b/dwarves.h
index 0fede91..fef881f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -92,6 +92,7 @@ struct conf_load {
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
+	bool			encode_btf_global_vars;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index b3e6632..7c1a69a 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -238,7 +238,9 @@ the debugging information.
 
 .TP
 .B \-\-skip_encoding_btf_vars
-Do not encode VARs in BTF.
+By default, VARs are encoded only for percpu variables. When specified, this
+option prevents encoding any VARs. Note that this option can be overridden
+by the feature "global_var".
 
 .TP
 .B \-\-skip_encoding_btf_decl_tag
@@ -304,7 +306,7 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 	encode_force       Ignore invalid symbols when encoding BTF; for example
 	                   if a symbol has an invalid name, it will be ignored
 	                   and BTF encoding will continue.
-	var                Encode variables using BTF_KIND_VAR in BTF.
+	var                Encode percpu variables using BTF_KIND_VAR in BTF.
 	float              Encode floating-point types in BTF.
 	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
 	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
@@ -329,6 +331,7 @@ Supported non-standard features (not enabled for 'default')
 	                   the associated base BTF to support later relocation
 	                   of split BTF with a possibly changed base, storing
 	                   it in a .BTF.base ELF section.
+	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index b21a7f2..9f0dc59 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1301,6 +1301,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
+	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1733,7 +1734,7 @@ static const struct argp_option pahole__options[] = {
 	{
 		.name = "skip_encoding_btf_vars",
 		.key  = ARGP_skip_encoding_btf_vars,
-		.doc  = "Do not encode VARs in BTF."
+		.doc  = "Do not encode any VARs in BTF [if this is not specified, only percpu variables are encoded. To encode global variables too, use --encode_btf_global_vars]."
 	},
 	{
 		.name = "btf_encode_force",
-- 
2.43.5


