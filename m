Return-Path: <bpf+bounces-48377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208AA07154
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 10:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7892188351D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759072153D6;
	Thu,  9 Jan 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUJQXb+n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rhD6EKOa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6ED21518F
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414417; cv=fail; b=AnPt5qSX3jf0MlIaAJ/43eYYJSXuallZhoTySWvMz9zV9wTXJlMd64CG5XdhgIZ7xB3DX5CBw8IHhRrqrKjRduBazBnbWnXYQXmxU6dQkU7GcyKR+FMlq+jutw3jmD8auMit6OLCu6eSvUatf5WuWtD1VGiYG/+7Gho3Ijs3KEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414417; c=relaxed/simple;
	bh=afNvwVeRGYAdXGDuA3kwPhg7W2FGCkU1V+NkHYGjnKE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EE4EPDj5tWu8JSNBR/alf9i5Vg7JHnTQvdDTAoTY7ULjO048J37yjS22jlSbpX5qUMYjapx22iAb9oBGrh5yAAU44DcYpoVeU3e1MKlXt5tBfsBgxoYCWWaGkHEaEx5xi0ZM0Fj7se4RcwJ9QUJ6obYtRCdfsPlJHaMa7dL3OXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUJQXb+n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rhD6EKOa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094fw1Z000387;
	Thu, 9 Jan 2025 09:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=a3wEt+Km5ka99uYwuZ3rIqP43tYMX8KHyehIJJZIIHA=; b=
	nUJQXb+n2hNn0xgnJCPTeeFG6VjCzqHhIqbdi+AF0RK4wnUWaUjXYrwAJRSS5j8y
	3Ecf1zKLdljlCUqXoPZafoVyuXYm3gTobe0iyw9enQW/tawlK3RUBXiPuaWocug0
	g8dgM4IsxrK7a5kU54te7XmPd8YKZi68YAUEOMncMDEUx2cuhyUgO5EvzEJk0bR6
	O/QTmjdN8FH23Oz7ywrxm5alMBNw9JHWZPNxSjW6ueRsdjxhIRQlpRJ+R9vMUQ3q
	kWignK1xL2PEiIoAUKzIHMBKJ+1MbfsftPDzNYs6B/LHpvOVllYxxljijaln/5wn
	xxQFYYUx6AdZ6JkpbkkqEw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsrbe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 09:20:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5097Oxei011049;
	Thu, 9 Jan 2025 09:20:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueapmej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 09:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM34OTYqFqiE9rlwAA+6zBtb35sVcRm5PdF8TVExxqv5v2bnyyAbF/AF2jAmsSE+rw6+H0y2qyLsuAa9Wv27B4DXj0OFvkTQ4vhSWTQFQWoGdiwCOBG4yWGc8rlHrFXNnev9IaxSxn2CNY7/y6GPnuIc1OTTv+ihCFBfq17/yVpQUNwzhf2a4hqzRbE5Gne9msXIQgVQaPtNR23CCTAFKj/pmmhAKR2C35KTud2BETeB5w3n8lp3hB/L8IuW1YtYChGsCw8p9F+6G+npeoNq0nfnioj+isHb2dhKxzpWjsHmmiAioJ37d9NywsAJKh9S9QWlG35IRLkEB2YoBp/wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3wEt+Km5ka99uYwuZ3rIqP43tYMX8KHyehIJJZIIHA=;
 b=JrP4evKTqDTGO1SwUg8QnrfGPA0pM/PhCbj7o/Ly545fhDchJW331HeBoq06HDzkmdEM+A7vPup6vbSSKZkALgb1ulxryxWF4OUp0V9nyyvgWnO/ueGMBjemovPobGuk7vsK1Xu/A92Hmhb+ptIyjNCdqF2ni6EJLJ0PFp35M9/nudTMs++nGhV9sobcUlndEi97UcrHTBKIVrigF8U5U0huCAJbmP8AHMgDhbBuJX4NxRUN/JOS2o/L7BiOkiUY4WD5ZBj9TC8zOsE5UtJlLrFK5ka+uL/xjoCh2IkayRgpfQKs+4g1czxQv7M59/geUTksnxfCPl0gtpccbduvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3wEt+Km5ka99uYwuZ3rIqP43tYMX8KHyehIJJZIIHA=;
 b=rhD6EKOa+feWaZFc/rIDZewMTFmKHZL8cxlqAlBmYVUyIXAFdUV+7Myghd57Z5Z3ngp+D1XCwO0hM7JRFS0K3zKt5wx6ATy0VMTzx0h80z7QR+i4K5cW1MoyZDZo4NKbQeQq8/hO3YI3kCnykIqxHCoR0vYj+ujgbUUwMMoxgH0=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 09:20:10 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 09:20:09 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Compiled BPF
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 09 Jan 2025 10:20:06 +0100
Message-ID: <87wmf4xs1l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c268b3-14fb-4618-6add-08dd308ed07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SvnwHY7yBmoBJK2uStOgcDOo+0bcmPxNDOv4ycNARpCc7iCcgm71ucfGsGjO?=
 =?us-ascii?Q?IX7k0WcXerLSJAqHsclfJ3d98eFuznt/N4iNiVcNadDpaWPiaWZRgMQrLA/e?=
 =?us-ascii?Q?9IXXCDNyC3RoZj+QEDoGt5wOSQrCUALKmQhH5cpRvnpkdeiCcxqp1mth4ldw?=
 =?us-ascii?Q?IQ7N8TGFe7fdfs2n+wdct7VqsfZfNoHsOg5gp/zXRZLN3+AxV19yPpxdMF27?=
 =?us-ascii?Q?1Ej/f9VN18QfBRjKr84ccvl3VJP70+HhkYRyescsnAzmY6L23UfI2G5iHkwO?=
 =?us-ascii?Q?DHQjVpSWT0w+bSL466Z1L9dC7KJdud6qheJOLD2AcApI2c5poMTPfUfrQq7I?=
 =?us-ascii?Q?iA+Pz56bDiEL2UYvKUY4JQJqR0LHsB/bcZWcKio3qoOnEKAIa5mGyPzDnzwW?=
 =?us-ascii?Q?3TSFR6n8TXln8n7lWJ6775nAV+pAKvlKmaELvnUEvXzjrGLDn7/ehADaDe4D?=
 =?us-ascii?Q?ORhq3dSt7neGoK555ERtcnA1OVO5NqeseAwPky1cOryyBNAjrM6tvkr+7D/R?=
 =?us-ascii?Q?21wiClfKf98ikc2ImJdQyTx0eXeLCFZvusGwAGGMaqFHabMOfDVU6bErF4OS?=
 =?us-ascii?Q?YsvQMeAkNi4ixIFD1xvhsSASpQrLBP9F+LHp5tiRBjcZXfJGKbfi85+uGTvG?=
 =?us-ascii?Q?MHEqrHP1LSAUkvZ/OdZZae6Xx9TJ5oMQKUNmzL+QidEqzJZCDz1a3FpwWd2m?=
 =?us-ascii?Q?d3q8epK6oNDyD3so/NOMMsbs6FMSeOsbdbu6lEVDqnOnPThQVRkSoHZL8YQs?=
 =?us-ascii?Q?52lsLVOvM8yDt00WAp3GCSdbAKEx3e5xgrjNMCUnKDGkCG7Tjw0xdV+BYPSx?=
 =?us-ascii?Q?Zl8+EqbsxAfZtSOkD5JIlPKoHbkTgKQP4gUHprBz59V8h7mqiu1U5OaTMFh+?=
 =?us-ascii?Q?QveEgskV3Fh3xKKCCI9ANIrizh8McJepdTbdPwn+VZcfz4fEVoO58yhWxGI7?=
 =?us-ascii?Q?SFpzD8FX6En3P50hIhF11g1yyFdH6MxYOCDhfB9d6P09poc36mWvquQ1wWjw?=
 =?us-ascii?Q?cdKg6SRq2tV/SsZKQfsr2x5ojQ85klVulozNJ7RcnVIFIMVY4FEHiedu5Wly?=
 =?us-ascii?Q?g4bY+Z2eC5+LDgPrKk8FggjSOAo7ACILLtZzOde2yv/EZmqnRcDN81EqM8xo?=
 =?us-ascii?Q?dBnGQADufoPZcGG/Z3lmGdkzgKFugeSAm/PDOq+i5EkeVLTTDqyS0DliNXvK?=
 =?us-ascii?Q?7YbHLO0zFbA7+45SYFeZ/lMs3yoAxoKqAwDrXKZsW3k05hXCVTN79oxWqorw?=
 =?us-ascii?Q?7VnzmoVHhQ/Z0BW9D7XJVohcBpUBUh1ogYzxd3H03+/kFnULrz4mfC7bWMW2?=
 =?us-ascii?Q?WvybenWK++1wbXpAHFaI91TJpC0yYXhgPoGZNPoMTR5zLvx+LEUthSfWtoQE?=
 =?us-ascii?Q?+l7oshtQ3wjDZDXHoOTdNf5/fI9S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxzgz+PYgjcEFROChPgj2byVJ1w1gp39JOkea3Dug7KE1giYs/I009KAK80/?=
 =?us-ascii?Q?JnefCL0ghndFLrRMmJaFgk0zHz6siCilu3L8f287ryES3idVGHVY6Az6Iwa6?=
 =?us-ascii?Q?FjpLNjAn0udaHNpaHG1GIuz4nbNqJhLFWU2kp7JKouEPYWF6EUfPh86UsrQZ?=
 =?us-ascii?Q?yzC7gy6G3eVJfRFTW5ZTfxhhHbWZezC4upT1/cQ358YUffWmvxn32unNjlnk?=
 =?us-ascii?Q?65SVdnz2GyNyqe7IhE0iIxvT992NzPfmo4gaaBRoBAeqG1MoWmrlM77cFhAr?=
 =?us-ascii?Q?lkPVnAGP5u3IxouTW8hrY3VAJ57IdVdjN4ah7vNUTFqgFPrAnh5wAxYoKOYf?=
 =?us-ascii?Q?Gc05xbdj2m5wyUjmBBCFIk1sGG+cHOe5SiSDVu0iR4rsCGXJc4jKUQLqLmIx?=
 =?us-ascii?Q?Hf8S3VQKiECPw7pZrkE0bxNZLSOwFrBnDunaLR1fuF0MeRQp2gcAITU91XVj?=
 =?us-ascii?Q?px153OgNXI5/rEgA+S0nmnpEz+wzYNP05RFGie64NCGJzyqZUMg9kk1zNM0U?=
 =?us-ascii?Q?hZMlg0dl9XgGpShfPAcGuZvq7ZLVJkI8rsJChGLfCWnsUKT6rZNoHJ2WwJye?=
 =?us-ascii?Q?kkiyFmofDk2ButMjCWoqMkrT1ENVZgO3KHzBeQWZIdvmuhsaRL4/gPrvHl2a?=
 =?us-ascii?Q?5+0BZCHxoGK45ogvNroAOncasof5pWJO9gyOerKSnneUaADl7L9LlXIJYmLN?=
 =?us-ascii?Q?+Z29wC8JDzwuvDtThOYBOgzHmiZ7fdV5XklSyTSzZ76oQaYwDp6YMZ5eQJKz?=
 =?us-ascii?Q?C8O8K8KD9GD7GYuoZuJRAEGewrB/FdSyLFRTaNsTrevlzL4US/HYZcH1c4Ma?=
 =?us-ascii?Q?lcD29QuoQ08JDs1LImpInXbKbUtbpQy0wJ2yh6W6f3tzRS6EOcT2HkiJvAac?=
 =?us-ascii?Q?dw2z7ridMFBAqSUiO194cwKg1fqb+68gIEYI2wPoWjSJksAkuDDmE+NBfzx6?=
 =?us-ascii?Q?Kr9HUv6W2MU8pawN/KZGDp7y7emeVBCfBKVGgssROF56TdzRgxHpc66gw06b?=
 =?us-ascii?Q?PjlKph5mwt0Bo1rbFkskffAeqabhqTDXLjKl4YaxXpv3lLd+Aynp8qygvYJZ?=
 =?us-ascii?Q?jkdkCdfRvkMrVq4q7lq76Ro6p/5uY17Pc7izO2U1dMqxhHJtKCPLvA6q+n5U?=
 =?us-ascii?Q?yQaGU/gmMYxB/PvxmAnhlbCzhL4c/oHHg8votRZ3nPG9sq4r+p1X+8FHzH3S?=
 =?us-ascii?Q?PZsIF5UVqXf7Vtjhryv3ZGZtHCuXZ/hY8/1fSNRHQF3d0INpnp7fhKLD2Sl/?=
 =?us-ascii?Q?vJhLaBC0YVg+u232MVfsc59ZzgoiJRHRbAb2wi+/KwGlxZOhht/KZ3vUvVJG?=
 =?us-ascii?Q?A/SbFS9haJMpq/qngoePTusQP8L0grN+aQItU/Qw1Pn/jY0DNnVKOA0R7VqH?=
 =?us-ascii?Q?j+1Oegp+DlUTrC5b2kbH1ozsww4kL4sWyQWbQpEi9/X7c66seHMwAe2R3nls?=
 =?us-ascii?Q?vATWqNCTPFKaggXs4gyeNnWmVM8Zi2luCsxmb8eayIW3u9SMT8P3Su+riscS?=
 =?us-ascii?Q?LGyv3bDBBiuHFqrSJGsG6+b3D/ZzULYBpvcgoRtQkIj6TNGuOHzfpqZRxwoH?=
 =?us-ascii?Q?Y2CNkuWBwevKVHFW3Fwhdu2zbG8GZJ07tHY/eCql8b0H03jjuocJdv9xd2e2?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gYl+8QenOq9yWKFm4qc4YZIE2U3X6dSAlpDtXUXOjsKs+s4uj9T3DlhiI9jzuXAB0Sr91rNZKo1iFJwGa9Eq6gNcDh2HK8ot7oJn3nviuIvfrDUrB8vRp7YHtnM5LcPsBcUdBj8GS6a3tiikn1kyJhlgdOEyxXnpRiUcdoUYx39ez/LiVpKs1tjdSwFTYNVs9GS6NECLvyzv7vt97/fAHAXCg7LH9n/Wu8ulz6LwaayNyK7ZDobCXnA2s2aJ5QyIKWtGacuyGazHTEb30LY3/bAbsXsPLiJIPzPT7CfbMEZRtOQNWi240hL1KfiyOGAZPiI+3W4qPO7Xn7gZ74qVvIUeW4WH0SpZ0vzK1zgnD+E6uvrvPmPKPbz40SwLwHpKb8/C5sN2Ia01Hrr+VSxXlqt38F0H16JrHNd3K21aoaSjFz2DzX6YxKlA/p4IxA07it1hOnXGNdM4g8aj5rNYNEAEEpOGxjkHJcLhm3x6YiZgb6VjsTz1NV2RvsJps3qZpIVuup/ej+8XVSdWJXhz7VKZR7r3j6mHVGADNiJ3yIifMOPiT1MFt8ielzBflMXMWVqvEuEbE8ZouREVvy3RmCnOjbqS/EVQx10tN5yCyWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c268b3-14fb-4618-6add-08dd308ed07a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:20:09.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9BIu8eXP7N9ByampEILpce7xFVp0HL/BfxXikewFIdJ/HwINYR0u/NvIpFN+OQblXTB0sAKQ9adNRmbFxB4cFEOGUjeux7IL2PL7TqOHzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_03,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=868 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090075
X-Proofpoint-GUID: W0P8ulWHu3EukctE_TvQ74huQJBXldHl
X-Proofpoint-ORIG-GUID: W0P8ulWHu3EukctE_TvQ74huQJBXldHl


Hello.

I would like to propose an activity for the BPF track at LSFMMBPF.

As in previous editions, the purpose of the activity is to do a quick
recap of the current BPF support in both GCC and clang/LLVM and where we
stand, to discuss and clarify any particular issue that may be relevant
to either compiler, and to collect and address comments, requirements
and other feedback from the kernel hackers present.

On the GCC BPF side we would like to pay special attention to the topic
of divergences, as we are nowadays being bugged not so much by missing
features anymore, as it used to be, but by divergences in the support of
certain features between GCC and clang.  Some of these divergences are
trivial to fix just by following clang's behavior as they are found, but
others require discussion and agreement.  Also, we would like to expand
a bit the scope of the discussion to cover a few topics related to the
"environment" where the compiled BPF programs are built.  Examples of
the later are external linking and the inclusion of host standard
headers by BPF programs.

Thanks!

