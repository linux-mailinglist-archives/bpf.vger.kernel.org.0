Return-Path: <bpf+bounces-40123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B797D26D
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB681F21D50
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A6762EF;
	Fri, 20 Sep 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIDLBuDV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fT4KqRSe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62D76035;
	Fri, 20 Sep 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820363; cv=fail; b=KJk4/FMqo0wTvCwtRUsAGdtjn8eXCJGFgI8ENxkH2iswA4Ra+tX2++dK4wrDnaIA5ayAMvwjoKHCk87e3/PFBW1P91jPsCahzrka0KCxgrjH/b9zhqFZ0VmKFa6Lvty5CmojL+O40vjPGU9hJ/R9v27krogNIrWHZxrpqOMUYbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820363; c=relaxed/simple;
	bh=FFvPv/OjEoL4QM1kX5dmFmzN/Bn1THlrPH6RYc8X0F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUw5EjK/1i7W1yGXw2hzw0DzYiLu2hkEaEieKRisEfAVkb670+Jh06jhr4lyt2L53s+rzYAYbYVGbjDaXXq7A0YPCVT1S/TFZK3/EaztaN5nqBv2VpwWAB+kj8Q1LJB+pLzgvbqHbKtoipi8OfK6iJuQrrg3kxGBFCQPQyxV7CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIDLBuDV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fT4KqRSe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tcY8019530;
	Fri, 20 Sep 2024 08:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ZRg+DJm/XEjnm0VM5nYr6UKD/fYTWZRXBdwbO8mdu0Q=; b=
	AIDLBuDVuoLrWlcpn9v+Cxh2YwVHyGkB1KdjigGZ36LRJ8c8XFrApfTWPzWS2sHO
	hpyHt0Ljy+/e4K9WvhCSEXTvS7Y30RZ+x9KVNQcOVURTX+5zn/TEWZoTI4io5Phq
	OcdxDpAA3TJTcQDP5dzaJI0wlaAdr2nBAXQm4ZC1N74jEDva18PLUuvOvm5heivX
	7IKXTJ5Sbqdsd61DlJLrH3XQrwTQhRCqN+aovCCJWS1VslB7ultRaRDTV2wUpXsX
	B9n3XknkLYmEjNlFdFBX58b94Z1NNHqeutoUWKUwCTp9akq0wxjjNs4c2bUGtAQk
	SiA/wp3azV12So5PIpWkRg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdwtde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K80jwb017909;
	Fri, 20 Sep 2024 08:19:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd1jn25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNqvxBrR2kZf9VCxH10PPWuf8IuEWZhur3QBJAXuKb6QWLtg/0VeTEOGnG4ihjQPJJrfMiZ7v7CQnpBPiYwG+fScLyX4PSPtbKzIIttzYTFTp708tc+tAZiiO5lpPNKAJ4OwkwcyUy61neu6CN9FSJDUXfcBus+oqtatxbyrPav5fO7n2u/g3CJ3/rCd8QaLdRbMOR+eKjD2JZ090kFnby69kIV20m+s+51S0b5xzY299IXPiUvzfS2ok+u9bMW3fb5NUEYSeKQkXO8qBNNxSF87O8+oGgp4zdI+ESSrCwe0GFgVWxcFofC8rqu6fQDirZXSLckh3B86GDFBWNjvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRg+DJm/XEjnm0VM5nYr6UKD/fYTWZRXBdwbO8mdu0Q=;
 b=gsTN7jLve6nAx+21K5u75win9NeACRR6T99mJJWbqa3iSoAUc8VV+LuXvz5Eu2z66+dhBiFHnEEj6/KtRYAMjVHGWw60wfsBqYGzo0rVpc67PGbGJ2wc0wKjy9jimusxrdRnV+1gLyAPhNaM5wZxs+CJcSHEniyMqhB6ksC1sXqMPnj6475ioLKItE8Or7rgviveqiNBwLNOiJZugpEdb7jJVEvVsJ4aZSgqGL0UVlO7Uf9newAiQJUNg0Zlc7RMYV3RRmO23E3JHLA2EoovlDcpbD90z8TgXXOAVO6ovWvjNl58eqJuJYRArTT8Eht6kaph44soIRR9el6DvlAmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRg+DJm/XEjnm0VM5nYr6UKD/fYTWZRXBdwbO8mdu0Q=;
 b=fT4KqRSeghEzNtbS33e5foK83CH6gTNSVygSAXhBW+1aefCKCojHj30g05gSOZFDTBb4ncISGbuIUJ6GljHl0PmltCTJt4e6XEcemHVCyidspAigUcPtldhPxFuedrcBgHxIRXpEU0VXBnCIoeyenupL1Jk+MjaBPUlSKcI8HtQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:19:14 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:19:14 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 2/4] dwarf_loader: add "artificial" and "top_level" variable flags
Date: Fri, 20 Sep 2024 01:18:59 -0700
Message-ID: <20240920081903.13473-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e31cc1e-3ab0-4571-6cbe-08dcd94ce9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOs3Sm4xIKdM1PERsqrShLfYSfXM0XI0Zw4eobF73yfPhcvnLKNDzMCYjRHd?=
 =?us-ascii?Q?sQTONzjpSqDwkNZdTHos7ZCRGFSaFVEdwCEXCAc3buvLIy+jl0ySshnIocKK?=
 =?us-ascii?Q?ww0rjEdaeaXulR2MENodU3GOO8Vut/lcxw1zxCPcAlZXgq0lO1kJmp/MvwCq?=
 =?us-ascii?Q?XMjWz+vuNS/goGriu8vYU4J5dAb4TaKl9ULpYraUUAl80+KK5496nFD6JO2t?=
 =?us-ascii?Q?vHykSMBFh2fv5MqAbrhBrvL84DXYGU+cGlXTrNPGZ1GFLcnzxra0F59MGZjL?=
 =?us-ascii?Q?QrlB1NjuNTvioUNpAa83+otFwaKY/vOLUG33MABIwTOazL7frseiudKYXter?=
 =?us-ascii?Q?Ed9Paarc1BDxhBom/kCzitVRM1v5QEkMGc/Xb14SEo2O9mKk42ZA6iRhf5CC?=
 =?us-ascii?Q?a91RR/gwbP3NWyt6M/KWdc6tX9UT9S4/2EE4i4VDFObZt6lDdAmqvCuEkjIb?=
 =?us-ascii?Q?X+hQtQ5xWgx6sXTYCR0TbRpyTCNRvhBAnrOd1zahyta3BVjYI2xlzeT5cnCs?=
 =?us-ascii?Q?2ndOc1Rn71l9+QDntoJoYFYG3WJShmbOLLYTq3n7yxLHo8i59LkQ+FFl0Tif?=
 =?us-ascii?Q?xVVaVjsu8/PX1qvnhxmEQlXNYufLp3usdXN0HkZze4a2j3857Q0/lLqHfasG?=
 =?us-ascii?Q?CPfW1q8PV4isqhTIXEOlxu6hX6aAYTg0BlUIZvNxNkJ3pk4M8H9tYqNDHNS6?=
 =?us-ascii?Q?xNyKBAmSKCNvoeBGUq2BmgkxT7kYr5pPNNTVSTp+/A/LUfN8dUpWRbCKq54X?=
 =?us-ascii?Q?Q2QWh/nGTCp1kdUJMd48WOKb4ckM+qOTGMCJu/U5FZkvvOgUnWdmp8Y5QRx/?=
 =?us-ascii?Q?E8ph1JFST3fus+WrAASoMlFBbW7sIei1zI2HAKEFivoJqECluhK271XAgvO1?=
 =?us-ascii?Q?BaBT0jt7CIWNVi+X5UcBxG8686mhdQFzuXNnh+JmngZrH8KvM2uVy3N0ZHQB?=
 =?us-ascii?Q?sfgkYgAmGTdYFYsliJXrssVhUdVZcXPL0g1ELTP6va7p0G4+dnSLTjVARbac?=
 =?us-ascii?Q?i8G2rtnuXCn8JWAylHFUeH1RgQyZAc58CVav4srYdhkZPQt9Azc9j6F4gSrp?=
 =?us-ascii?Q?3zf/Bx1TX3TwLxyqak7s0bNYa0x0jm2Vaety2zznlPSsKJku9EHM0OFj47aL?=
 =?us-ascii?Q?JY+HyeodL7i/r+PYFQyZbdQmykc+Y/Vf6mXpO49aM727xQo2KE69httZloi1?=
 =?us-ascii?Q?g06NOcY9Bgv65AgI6KP7FPvqcwgv3jNjwmvpddGzaEziDN1ZF5xpcdqp2+9N?=
 =?us-ascii?Q?RskHq8S/o7HaXW4B/zty0KekVvKTSjLxTbUHN13h7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08vsfvLa4XBFVT4sLLqsVh7RVH0c6NvE6HNtJ9C0kPOyGwrhoPE2+4LuhyBj?=
 =?us-ascii?Q?5ULSNfZg8F3T5IKUPs55qRccL/OYQWJtSN1ql2YiO1xVPmLeka7/HY8xsEfs?=
 =?us-ascii?Q?kI9NoWrYg+NctcUcBhwSUIv014LB9xOTbYwUxm7xzcTS4WJrrwvbpqjHRgUz?=
 =?us-ascii?Q?JJvouswex20tTBN93iAPeFVAhFfLUlvl7H6LP51YSLFVuX1PbEVZA1SlXNYJ?=
 =?us-ascii?Q?T5q82wqsR2m2LclkyvIjIUbSRevRcM0UuhksjxCPug6pJ/iOFwnRiorzTRvj?=
 =?us-ascii?Q?BijCnaUUJfHRdXU56z/MnOI1gVdbGBgVTB/3w01SV6VuSgTlxx0C4/3NhPJU?=
 =?us-ascii?Q?r6P58anpc9oRGqPEPRxL7BKt1hCGEOzK4JSAEH6Xy28XWP464q46g21f3iex?=
 =?us-ascii?Q?BOOcLKRExacwcy8UyRF4M/rebBVG/bewaKi0ljv9Rz7R3VchYNN0eIKmgJLs?=
 =?us-ascii?Q?vFdm1AXKq/Gpwiancd/GZx/maDD46CfBZI3UCXllI225++e8xC5APpSe5W0Z?=
 =?us-ascii?Q?FcXHWbYhv67fYLSuoucllwKF2FtmXHtoCn1iottYsqfjBuyJ/0X/xSmozMtW?=
 =?us-ascii?Q?66gDctD7hJQ9BYZDd1FQ3RZt9dLfnZF57Fd3gOUrh5obIPKxYccTAHoO64OB?=
 =?us-ascii?Q?dl4ZnEfsCY5jFMeU1yoeDJal1fGFmMF0KiCOd3+/orrtx2XNEAoeTglS1Ecu?=
 =?us-ascii?Q?yyEWvL3aMSDe0/TMWTh3zAm85fNY4B+1AxqTVHi8Y4PWCKvn+Rq0q2m7U6LH?=
 =?us-ascii?Q?g0+/usskSt2okEzGfCXgfhEwmCwOWteXBvXrUEQKEFYFkziSHmBzoA1hRP+G?=
 =?us-ascii?Q?ifWeqPGu64Tzpe7+veZwZTDPEf+YLll4+leyKW4VPJgsL1+jRWcR3ZZeNjo6?=
 =?us-ascii?Q?+SH5KaLwAJQR2zvDInvGb2cHFfKMVmt+sw2GbrKBmrsyOf49Opbj42agjb3T?=
 =?us-ascii?Q?M6CJqCttCFFC5kOLtWxBCqUfB6575YgIh7+v8/u9bFfqIrY1B9xf9CqNXRtQ?=
 =?us-ascii?Q?m3geQqXnZoDx0p1xpI+XXl2Bxta6i5xW8570KkEYHv1r0FRo2Q0EXVjQPY6h?=
 =?us-ascii?Q?HFOJy3fujCQ9LtD51nB9HFaq1L6FFly+03eZKIuA3BQf9Ryfl8c2jf1A3quz?=
 =?us-ascii?Q?ZKJPNFPNgAvrbrONXY70VjR1RTmC9p5K5NXZD6gAKE5Qn6IsSf/lnk+nFaIm?=
 =?us-ascii?Q?yDnmlNEe03cCQrlCnMMyMhz6zo/wgDU+WBI7CgCdGzm84fXIXtaasWLv/tAK?=
 =?us-ascii?Q?gq2mvdSGuqoeKvQ6UIrXZDeH0nV+RZNqYsLtGDyNoYbH9m8mA22FnVRVMpFv?=
 =?us-ascii?Q?xOlfLw8CKS67MT8qQwX596B/Q6ReZ/y8JtbEEOg38Acxz/XBbP+F/MStcAFf?=
 =?us-ascii?Q?ht+QQEh9DLoZfK1Lgz/qOQ1099Prb3vADMbojClKsi3OsZ0J9MR2eZP5lhQV?=
 =?us-ascii?Q?OhOrqbkFop+chg0Vk0xHYz6BsrK5ocK0acdvYXA/yzoM9GAiB5RcVMGBn1wR?=
 =?us-ascii?Q?Drf4Kcm1iRdguC//14/wMQtF2bFiejdEnl8uJL3M9pEiGFk0m4PYki2Rkgby?=
 =?us-ascii?Q?Ql1BNJOTBtpSykK3DMGODMztLQkfIQI3FV32HI0l8RlFW/e+KVUstuC9+i/d?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fCoFjfroKbIiXhouy4gmDOEVa6uXzEAY9/ab4FlYwR8169g59mTMZFxVFlnKhMpYAAd8fnJ4QLD14GC1Ww6RLPwEKsDo/YDyQZHjlY1k1yJ/WLGwNkZ1QjjCCsfA6WM33rJ+gvmlv5DaCSjYQ7T2HyO8OnuutMKsfLx0vhdaG97laCM3UswaqmU9rjbOO/yUTu4lOIRu/g28AwgMjzjxjE6wYiG4o53xK0+If6aWdENz+1wdC47fvlFJokqI0c4pdP88Lgwa8fDs7a9mMMR7rwGtnX6tkhcVn2a/bGO7Cw3saAMLXGWmgs9b43OLu5D+MQ2KtHu0XdCgzgizbuJRhpPU1sVDsd5GiNRVFHFS/7nqefPsV3dxrEIVXu2uXdDbrBJ1S8yc5OQPDLKTirHgWkDkjEZqU+Je7Q9x5abLioVuNjeKdmcYezBrIT/2pwsfjnMj4v8WYy/LJ8v1tJ/BdSWJHk2+pjDMCrs7qoE4S8yHBnV7sBMDoygAagpqXCCyVhOz/NzdGNuwOm9D4YVSFpZgLp0+8g0VngaBfic8uEhCeDVB52FPPmOC8PXlFWAmDDZWffSoTQlUhXzRZ+AtJXrQVX2sQj0mURFP3TM3BjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e31cc1e-3ab0-4571-6cbe-08dcd94ce9cd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:19:14.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rum386EyNrg5LwBXHp3ErazqxOCsod3r6NzXFT+VV6/NBfCubZmxmQ5R6U/k/vGKIt8mjKipNjneiQHN2l8J3Sf3dgRlrvOODt9oOZKx1JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200058
X-Proofpoint-GUID: --2glNFYVE3hB4GVpeTfwIBYgT4GUo10
X-Proofpoint-ORIG-GUID: --2glNFYVE3hB4GVpeTfwIBYgT4GUo10

The "artificial" flag corresponds directly to DW_AT_artificial, which
indicates a compiler-generated variable (e.g. __func__) which shouldn't
be included in the output.

The "top_level" flag is intended to be a better proxy for global scoped
variables. It indicates that a variable was a direct child of a
compilation unit, rather than a child of a subroutine or lexical block.
Currently, the DWARF loader examines the DWARF location expression, and
if the location is found to be at a constant memory address (not stack,
register, etc), then the variable is assumed to be globally scoped.
However, this includes a variety of variables that aren't truly globally
scoped: most commonly, static local variables of functions. Their
locations may be static, but they're not globally accessible in any
useful way.

These flags will be used by the BTF encoder to select global variables.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 12 +++++++-----
 dwarves.h      |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 065ed4d..d162214 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -730,7 +730,7 @@ const char *variable__scope_str(const struct variable *var)
 	return "unknown";
 }
 
-static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
 {
 	bool has_specification = dwarf_hasattr(die, DW_AT_specification);
 	struct variable *var = tag__alloc(cu, sizeof(*var));
@@ -743,6 +743,8 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
 		/* non-defining declaration of an object */
 		var->declaration = dwarf_hasattr(die, DW_AT_declaration);
 		var->has_specification = has_specification;
+		var->artificial = dwarf_hasattr(die, DW_AT_artificial);
+		var->top_level = top_level;
 		var->scope = VSCOPE_UNKNOWN;
 		INIT_LIST_HEAD(&var->annots);
 		var->ip.addr = 0;
@@ -1767,9 +1769,9 @@ static struct tag *die__create_new_label(Dwarf_Die *die,
 	return &label->ip.tag;
 }
 
-static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int top_level)
 {
-	struct variable *var = variable__new(die, cu, conf);
+	struct variable *var = variable__new(die, cu, conf, top_level);
 
 	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
 		return NULL;
@@ -2243,7 +2245,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
-			tag = die__create_new_variable(die, cu, conf);
+			tag = die__create_new_variable(die, cu, conf, 0);
 			if (tag == NULL)
 				goto out_enomem;
 			lexblock__add_variable(lexblock, tag__variable(tag));
@@ -2367,7 +2369,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_union_type:
 		tag = die__create_new_union(die, cu, conf);	break;
 	case DW_TAG_variable:
-		tag = die__create_new_variable(die, cu, conf);	break;
+		tag = die__create_new_variable(die, cu, conf, top_level);	break;
 	case DW_TAG_constant: // First seen in a Go CU
 		tag = die__create_new_constant(die, cu, conf);	break;
 	default:
diff --git a/dwarves.h b/dwarves.h
index f2d3988..0fede91 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -848,6 +848,8 @@ struct variable {
 	uint8_t		 external:1;
 	uint8_t		 declaration:1;
 	uint8_t		 has_specification:1;
+	uint8_t		 artificial:1;
+	uint8_t		 top_level:1;
 	enum vscope	 scope;
 	struct location	 location;
 	struct hlist_node tool_hnode;
-- 
2.43.5


