Return-Path: <bpf+bounces-40804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385298E76F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9191C25620
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1DA19F11E;
	Wed,  2 Oct 2024 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D9htrK4j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RJxly5JP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE751A01B4;
	Wed,  2 Oct 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913203; cv=fail; b=cKyiGJILLxtZaAeButMT2f0/ZCjP91gVhMZbYACtKMQlXGmlU203ZMD2rT+Ohron3CVowsDP47I3XUXZsmd/Nka9ADtG3yai+wiMUZqOx/qd9Y31jPjDt+bVPpF5p4iFbJ/cJS9glph0HmnEqc1Vozgv8gFjMJo5cJG96O0/2ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913203; c=relaxed/simple;
	bh=2LG0Kq/wKCYRduoIOMMvC56m0jC3cG2PokpnnZBthf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJp9KZMgOFR8vQtn1QTMmo1+4GigMMCgC+X4Cyr9eWNoRRbO4m2FZI7KtuUPlIXpOxRg5lgsxUWSgU7XhWNAuB8UO0BSkJ5qqGgFyVIljPPvQMQ14/f6escUDvmQm4HaCKTsFfg5/EZDw994PFSZKHVXfz6+KyoJUjytF7SJmoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D9htrK4j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RJxly5JP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Mg3NZ030406;
	Wed, 2 Oct 2024 23:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=pVK6nXB9t2ffgoFJ0L8YrQqV0yMTmG/WqLknci9FUNI=; b=
	D9htrK4jucAKWVltBjHFOdqCUtAhbIzXrSHc138Szfs6dsaqH4T9IR3hUw7+hVlF
	63vCGTJVk0D/Pk0jvkXCZtjJ7VEfqDgAkPsdA5oSeazQoVJzjBhU2mxME8QnX0nJ
	GKCFkwf+LyX6G49DuPKmusbx/DzyxKL4ym1sCy2laHQIn0niI7UBkN3gFyzAIIRb
	A+bc1pxd6O8erfpjSl6lz3Y493ub/ymuB4Oaipx+sy/3Z/2EQNAHZ4H6jBBUDwIU
	0Kbpg32ySuEUDtY2y/9VT7wyR5CkGiMVBEd7R0X3g8zDoxZtlLWtVsjbkHrgRTRl
	TW/8Bb847VZLx300JDWmkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87daufa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492LeH8R028425;
	Wed, 2 Oct 2024 23:53:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889r8p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4R9T352ohKDu6ZH8Yqc7uHTgNm6xJDLSNCyzC9B3bNQZAx3GRa+5uoAmMWY5Az1KkNCGFo1UTPi8wy0JvK4FqrQ3pAaTOv7ootrHrrZJzVcxFNpQjY9kV7msCNdroP6+oiRd3wpvKRmWgMnIyyENRW9IJsmIlqz34JR7gkB+F8FkmXwF8ssIJnMtVSl6tYA2/NKuFJH0kWa8F52jt4zyc3ESSz7Qa+pjaETSh4jfoWI3WOawmVREHBOL6Pvtb0t8TO4qZy0hSbI2gpe4Nwsd7wNZo+3plQdKZdfpXGqLehY/ydYvycWnV7Icm8c+Sja+Mjyh7mvCFfP+di5KRMzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVK6nXB9t2ffgoFJ0L8YrQqV0yMTmG/WqLknci9FUNI=;
 b=Oo3Bh90o+Ag6enjPuyBmobD2rxbCxn5HYPVNB6Cig4yfjkQ0kicq1D2etaLbviWyfvdu9xPFxu18GPmuu36YbqFy03QCSjORtDokhlVfVvtMFQGTCxIhIgrGHvTBNQOYbo4ljR/+gUvFL8Ow2ak8mIqilaoVvPw3SV2Xs6EMWr5PLPTMQqnl1fmVnT/7jUhmyoh//9W5hBl7arXUnY8AslL/ZCKx9Uq1EQyEC5Z2Gk6QmAupqqxcj371sRhaBBIW8OhwEdZ+DwVw9/MtLPowp3eRrwwoMVMaaW9t56nVOghzdgwDL5SZyTTxt8tmNHq+LosiL3SEUardpniFRzn8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVK6nXB9t2ffgoFJ0L8YrQqV0yMTmG/WqLknci9FUNI=;
 b=RJxly5JPJUCcv6Gaq6DLj26EhDQkS1Lo+Oc82OKif3GtFWM/pXlBdogqFTL/vazpvovnKXTVadnMkMf+lFezg2hzWSaKgOXCDq3MjgpQLr2r5cIIN1g7oIh33D86a3XUMJ7Opp0HghD3VQJ7PzV/9s3SA2l/8gSZQjhC8oJUJOo=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:53:07 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:53:07 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 4/5] btf_encoder: allow encoding VARs from many sections
Date: Wed,  2 Oct 2024 16:52:46 -0700
Message-ID: <20241002235253.487251-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 435c72a0-1b03-466f-f7d9-08dce33d5d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIHdMnulkk98I6opoAnFFkMyz1XPTpfbX6GQIwdxEtEe07+IDkyykWAGN0Te?=
 =?us-ascii?Q?TCmwJ08GAafVXsuRtp3x0Ay8Lydn9AE7M3g2+6dpWlTChiHascs8eXp72pn/?=
 =?us-ascii?Q?lwunlbyEyGO1xZzIC6XVWzaVXBDWitErH5wck90yiNSL93TqrCPspxYqS0Ax?=
 =?us-ascii?Q?wYk6qKKZ/yr1U24imp0ffFvhVEfi12KzeV4Vu4t1GRbYUMLnMrSzkLrYrQcu?=
 =?us-ascii?Q?z2DN6g5IQ4lbE+tOiY9Y8ycmqsBVEA+BhFKaaLcI3ReBbtSv/M88gxiZxvnJ?=
 =?us-ascii?Q?DCcgMaUOAX07x0jGQzu0uED1KN48IgWKmaLf1rejIpaUG6+5wXaYiqQU8c/M?=
 =?us-ascii?Q?Sz56J2UVk8Vch3dWAoS7XGIAPy0C3qWAz+3hrgRae9XtkSa8yfcszsLSBO8h?=
 =?us-ascii?Q?CjYiQFupeDaAs4fH5Bcs/B6u0nTbTHY3oFQtDP3kfl0qIpfQrAiZa+f5IWFN?=
 =?us-ascii?Q?Xj8mZ/QvJLyEaIjKzLNiugceHzDI85Eh/zQXVQ+fLAfK08LZXT9qsacMCa3T?=
 =?us-ascii?Q?2lmfebPQrb6F5JDbz3OGSItYHD84SY+yiV7bXQ2Mb8PuZxWBuHjcLeqoWTlG?=
 =?us-ascii?Q?ktw1CAnqV0dKXDsD2mp2maof8VlnesY4XGSCBdMHeiV4xIyAZE36BowdpVbE?=
 =?us-ascii?Q?ONXPIoLZN87AsOYg4kbAA9L5XNwwgM3ZqWQ0DukpBODmRMAbwS1uANXnYDX6?=
 =?us-ascii?Q?HGiYkPfDkaXJtA9KN9IGIMbNRpxD9TVoTte8RCCDA9SKprkq941qJJY7TdV6?=
 =?us-ascii?Q?+GMS/xrWtof26Y53QNSZtxpHY/t6qQp762h5G5eBdAj96/xHSNcNwy2hkkyB?=
 =?us-ascii?Q?ixdnJM+hRXXJ1AtjeJfqna98/+eKSoYI58g4+5zOecFJe2YP1pQlVnSr8nDt?=
 =?us-ascii?Q?5i+HRem+TXcQ0jbYHJDJdqaW7qJIQPTi6F/ZMN2VtZqlXf01GB8A3D0Zsj7t?=
 =?us-ascii?Q?LcPS6C12t/qWUFtRh9k25twJ9KN3EDyhzNhp0y3FwcKlYvm/iN0LY8+1unkz?=
 =?us-ascii?Q?cRAaSG7/rGsWcUWOamKRsIVtnSjgrxV93hCTjkSRSQj25t/QxMDAWWUhmYGR?=
 =?us-ascii?Q?cTjtfpQQBNiDvv2CGtolIM4uVCO5YBGLZdvn9qpgiVGWGzL81cbtEmaNVpMZ?=
 =?us-ascii?Q?HyiwOeK/eGDpx3gj+szazB9e/608x2xjGOMurH16FdzwyLRqhubFbb/hMrA5?=
 =?us-ascii?Q?x4K5V967Bd50m0fRvVyVE+0nS/bmcggcsOK55cIA6n1VGFQs2H8iRhFaw4J6?=
 =?us-ascii?Q?rFnnpuOSOTo1jj93eCR180q/K/YrQ3emGELhg6XQXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QLJ3XhqlDScJLmzURDujA2JrGVxJm+NLTRgbGG3pJKDM+iGirf2AdUTW/oM?=
 =?us-ascii?Q?Hj3eF3HKhj9YB0aMOUENJvm0O2JFU9eKwE0KhiUY2frWIvq/WJikcK6PfaJ1?=
 =?us-ascii?Q?SyHhaLoZouXh7qWWVdqoJHfhOdXIt568ZPl31J+F112Z7xdhpxwWyzqLlsfu?=
 =?us-ascii?Q?619pgqvxd1goFAu092Rsz4366jRG9bhHnkeJ9P4qD203NaItwqvckDz/GmrR?=
 =?us-ascii?Q?3+Inbscyqo7iassczmKM+4vXbe84OiKKzLfHER+lySpIpEOhnzz5ZKiRQd3a?=
 =?us-ascii?Q?HL5d7NoT+ualPFIQ196UznHepo74l0PsLAPnadCbXKFmrz0kajqKN5mzj8XU?=
 =?us-ascii?Q?9SKCnv/Iz5wPY4nToKNFCkpS3x8jcIbreOwaN3c8Xv0988WvD2NfJvpWXCZI?=
 =?us-ascii?Q?4Tk9s9MlSgAE58q6YwiK7zrIOrDvx69/dd067z2Z34mSAAXUNVbFLMLiVszH?=
 =?us-ascii?Q?YYh1JH5kAC6O1RkJoTHW12yFF88bAF124uSSGZOm+oC+U5cnGnwixLtRRZdV?=
 =?us-ascii?Q?HlELB9zm5lCB0K87mZ29h+xDoROcGwh4mByWkpDK/W+NFYhJI52WVncU9c5H?=
 =?us-ascii?Q?xNYkInOTeMlA0fDJRP/K0mBIHhfwhABpzKdA59YNmrcRGWlaQWcf/teU6abY?=
 =?us-ascii?Q?vKSFx3AbOZWexG50aRvDJUSGjfXq6uP5Wap+U2TdYcda2vi77Ju/8GUfZw1l?=
 =?us-ascii?Q?toHj/ArkWZ4sQC+xC4WJwQyiA0Lx6wv27ERkbW4gkoQztiyn30VU5Q0AIypU?=
 =?us-ascii?Q?NxoB5l9k6khLmcJoNRo+OXe1F7tc3iUB4HW31Dno6SnsXAWaY8ALovoB7Q61?=
 =?us-ascii?Q?UdtdyVO6kuL+f3f4HROy1Z8gKhC7U9OhVNtfZqCapCji1FmT9+vOQCscxi4S?=
 =?us-ascii?Q?NEU1fBUEyBRY0fbpdecY6vPQ9SEYTKkpVusAVoIGmQ9QL3qHpCyJ8hjCwSKL?=
 =?us-ascii?Q?kIibeWQSjmW33UjqXDK2dZ2PP5F7AIEdybSdynjVvqEEK7ZJmCrgHePFzwR7?=
 =?us-ascii?Q?s73sO26zENEGdthJKrZDTtd/FLQ8OtoCnGM30YYnvdQYinpixZNzBc7kIRDO?=
 =?us-ascii?Q?bs+n1B9Y0AuoBdNHgmHVYC9TVfJrV29o0QdzjFu4+ry3iurjJvd6KILjShQt?=
 =?us-ascii?Q?dYjpOMJLBQa64AnWAFPuuOOgCHOhDZ8XCqdWu0WifyR+qHFIiDM2jn1N4wEl?=
 =?us-ascii?Q?RmzRIOAwz3uARmTZRWaiOwtXmqmCiAZl3/BuUMLT+DyTt8+AGkBNfmKvQsat?=
 =?us-ascii?Q?7LeoLZLD/fplTa9RYOL3ybGAFiIC8eXHaMURv1h8b5jg578/+McHSWk9CDgw?=
 =?us-ascii?Q?v5FoozAkRd110/2RPy+WvxatF+D2VpnS1IaOCpPHs82uOvbgL/Tkb51Ul0T+?=
 =?us-ascii?Q?uL1JTELk8igFOc/3AnyvyEIokxppkD2vNGGj7XT2WmTFjksG8aAQ+A7DCyBJ?=
 =?us-ascii?Q?KfBirvxS8cLJ9hb1V77dFEedKVXw4ylmm9e02AqkkXkBmAShiMplm6NE9v6e?=
 =?us-ascii?Q?YpBBY6Q3BvWKtzjN99eEza6w2REE4xtRzMRIvQM5y0/yFZ9ezXIKUFcP/Ek8?=
 =?us-ascii?Q?2utd06qs1gnnFpnZ34dhe5ExuMYIsPjDyZVIqzj9hqU8fX3nWhvQFntNQI3i?=
 =?us-ascii?Q?UgkuzhSM5gQTsy8O4EEUBBM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ijkvaQwgfyUnnU/t5LoI25gUaESAsC2irH7khHz7BKpKkkgYboSW4Po9izdQfVCRgEF7gQrdrnzK610hw64JGbQdb2hxXH5ZcW+/nH3caOtWl2xWwz0IWlvW7jY/Q6rOKGYabDPgTuTq4PpXHJqsZ0J1gkMqvcgrBABWffhn7t10o/lDH+A7ws5QRV1iBguy6zac0hAvrbXcu6aBuZMBrrgFga3bVrG44NLcFaSmZBOcC0YymXP0705TMg4G1vg3B4lImQ160BTh6/wsbj3+iAecEcxv840XHKCxVAHDo1QoO9EkjgoiWhYl6sdyGeZBcoKG3WbjXY6s/tM+tPUzG9VWO0kF58I/ddbGDYvxAE8ze+Dfbz+sQARVR3OybYlS4zYQDznFIEdday19h2+EizAKjYnnIaKtSbrPpOx3dLRIfbk/cUjzfUW81ostU+uFbplIwc6Qf1zRIi2MovH3ezIem5qvxV72Jzmb6/kO2Mm9oL/t04UpDlAWZzH7CJtw4Yrniqv/z2NN11iGVpvxOh0lWFoWdK1X7AcvMWXmpTyN8MdXDCTZ0mNENbFAHJqcDPvL3w26CdGKSiNtg5235QEmdOnCCCaKUIOOmBddBM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435c72a0-1b03-466f-f7d9-08dce33d5d15
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:53:07.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VABEwd93gZlucXYCYTb+99b4ajZ1YK0bwnqoOl+QPL7d0GL0hhkKIj0eQRQ/zVr32yQZWlczS8GCTomiEkI62xAUOP70as/XeKYPY5P4zL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020169
X-Proofpoint-GUID: 7lmhBFxJkObRe020vB_aMb3DAgHFNMwt
X-Proofpoint-ORIG-GUID: 7lmhBFxJkObRe020vB_aMb3DAgHFNMwt

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
---
 btf_encoder.c | 90 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1872e00..2fd1648 100644
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
+	for (shndx = 0; shndx < other->seccnt; shndx++) {
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
+	for (shndx = 0; shndx < encoder->seccnt; shndx++)
+		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
+			btf_encoder__add_datasec(encoder, shndx);
 
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
@@ -2167,7 +2179,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 	struct tag *pos;
 	int err = -1;
 
-	if (encoder->percpu_shndx == 0 || !encoder->symtab)
+	if (!encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -2180,6 +2192,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		struct llvm_annotation *annot;
 		const struct tag *tag;
 		size_t shndx, size;
+		struct elf_secinfo *sec = NULL;
 		uint64_t addr;
 		int id;
 
@@ -2211,7 +2224,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 		/* Get the ELF section info for the variable */
 		shndx = get_elf_section(encoder, addr);
-		if (shndx != encoder->percpu_shndx)
+		if (shndx >= 0 && shndx < encoder->seccnt)
+			sec = &encoder->secinfo[shndx];
+		if (!sec || !sec->include)
 			continue;
 
 		/* Convert addr to section relative */
@@ -2252,7 +2267,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		size = tag__size(tag, cu);
 		if (size == 0 || size > UINT32_MAX) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
+				fprintf(stderr, "Ignoring %s-sized variable '%s'...\n",
 					size == 0 ? "zero" : "over", name);
 			continue;
 		}
@@ -2289,13 +2304,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
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
@@ -2373,6 +2389,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
+		bool found_percpu = false;
 		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
 			const char *secname = NULL;
 			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
@@ -2383,11 +2400,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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
@@ -2415,12 +2435,14 @@ void btf_encoder__delete_func(struct elf_function *func)
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


