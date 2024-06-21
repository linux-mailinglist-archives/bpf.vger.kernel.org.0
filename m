Return-Path: <bpf+bounces-32739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79176912AD8
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2901B268BF
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3B15AACD;
	Fri, 21 Jun 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFWR+v4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aTqfxH8f"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABE4F215
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985946; cv=fail; b=hG3nV2LXvZVEfkmxkkmc4n3SAKGJ6RcTUYiGCZ9omAuI8WWiEk8LZJuDZFHAoRYh5Pi3YADhiOSZGO3lDnRMC+DWkjluQRG/qqhN0JfhC8THWWvH5+QUflXJJ82ZZO7H98DOslyWFHzVLUfzKdz4IIkW1EliBvUh1HELMizKi7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985946; c=relaxed/simple;
	bh=mAv11q9KET4wc5fGxZZFcOxJibMOn7uvYgUXufgCo1E=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=PPbW9EX/tf6LEBn5DxZGLkrlvfqXiYa9QZ72Vzv3hv++74v/7tESL7ueSR6gKPv99cjjAkfyiH/O5ptj1cvFVVluT1IbP7o/W4dT3PdC1vWBmJ4t8BIlHFH02dJG6XulYiDfWfDBaK9qHA5Qb8/HNUr8VrQuPXbs8SbWtL6FyzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFWR+v4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aTqfxH8f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXbhp016940;
	Fri, 21 Jun 2024 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=+eiNnqVG3kEUyY
	Ksy89ezgu+KIQ7B+pfN7Ap8G9JVwA=; b=FFWR+v4EZrM3SJiNYJp5bQbHdFgEgo
	QyM8v2kPPbu/3VsvuAbXYEzYXjIHHVzMidcdYXc/NBL/gC47b+Pa4vICER7aPiGK
	RbQxGLO15PtneHaHzgAILA7J7KwT9iMljrUNZWMhEwTGJ1XpI9b+/thZUr2D4GIu
	H3Qpuk6XM2dVvvrPuHELEtx83P/HehTrBso5PgV7KuciiRjQqQEsAgGG9gLaZvHU
	uss7G9MFViwqzQSK8k4RZtxKXijOS6re82UePnWlUNwkSmEAg3weMt1YWSmFdvjz
	7gT9qE16J1UyZd2VqLNW8Q7BSGe7YOZ0a8yIgs46Jm0WXDkgOtyMkiVA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgt41h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:05:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LG5KpT019392;
	Fri, 21 Jun 2024 16:05:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn412bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 16:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO02akII2TQbl/hXnEjBT9Wk0IO1t6zr7noZ9FKoEnBNA3BWlcVSC9L+Kfb+jcP60Np4W8a/kUYyCJ1VdG9EDutyP2EMOmuQsbT6GIwM8wG16H+iQkyJcyBVQUdYx8BTDK4U9fQH9Xscj3JNVTSE72WI+kvaqIngyGYty2ONHpbx/G2G64mqbnb96tj837R+PJylA7vSODb80GiRyQuCwfeWyXVaX4Bma+iR9N4ebhLxW7K0zRxpay7lGNRxLFqLyCpj18gyNnltEtzqtzJkO0jFcZSK2jXiXUoEvmygUFZ+pfx43vKiYly1N34dFOGLmUYZxxDfie7uWJ0caPZXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eiNnqVG3kEUyYKsy89ezgu+KIQ7B+pfN7Ap8G9JVwA=;
 b=EoYdtinRvGHo68dt9a4gWb/RAIlcy5LzGhEHQvNLv7fG7Yr9YWrRFVvYD8tHrebjB5zqMlPNi4e3mYizgijXSEM6HAkCRIQj4HuBSJbzBLFCF4WDyQn4BBkcHuYUPXcA1NIK6VWPMsKZTI4zEVsDLjtAJ/AdkK6xUcBEnhIiLy6UraZR0fdKqFOZhW8E01uYqJ3YapSTNcuWakK82uNSZkMX9lWGmFofWre0t5xdJDyVhXN0iIEdPFAMGlx8rDUkj/cVE/ld6WWLq7jwJXiAMgpNw2MvRkbauAOL4qJLGdXGd/mHhBkudkUfgPL3LoHILT8y2fKB7UtwPe4TJ1ef9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eiNnqVG3kEUyYKsy89ezgu+KIQ7B+pfN7Ap8G9JVwA=;
 b=aTqfxH8fQpjPj5lJnFbrxoU8dQLXSGyn7yKsOGjX5RjYYvfa42MI26QVDsRa2d3sgYPcr7JQihmOYy2NpbT4VIbw/87EVscw6GQAtDOiwZzzvuN/f1kEmt9TOGa7BQikL5Wc54VU7v5nP3RbsEvk94dsR8wZYBxaJvgT7yG+Mno=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:05:32 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:05:32 +0000
References: <20240617141458.471620-1-cupertino.miranda@oracle.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 0/2] Regular expression support for test
 output matching
In-reply-to: <20240617141458.471620-1-cupertino.miranda@oracle.com>
Date: Fri, 21 Jun 2024 17:05:27 +0100
Message-ID: <874j9mp9h4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH2PR10MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: a3061211-43dd-4b80-e0f1-08dc920bfa18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X59uITsg/ULZDO91C/WWy1gOrJBLAeG+4Z0gv1nvgoXaHJRUbNJwcVnMAt3N?=
 =?us-ascii?Q?6NYIoQ1CMRriTADg9KBoMh1RKiKFyb247DedtAc/PJE47UZ/Mq5X6vgHokBT?=
 =?us-ascii?Q?8KruLG5iZXmkCIVilRncPoerob36cmoggm6hLicHPseMmCUXxCx2FeVzJ2Ut?=
 =?us-ascii?Q?JzLmWykcWDUMU5+U6bPB9nTzLXmYRhOaWti0tCsiRM+KhNTnIEqKyGBLxty1?=
 =?us-ascii?Q?pyqWIhSeZh9wGd6GDiecHs7CRsiPjX8lTceqrEsET9EDtkD44asd7fMgZ1HD?=
 =?us-ascii?Q?B1sPSiRJhaozh8pwqKyBI7vk6d30hNNI8K6a1W1s+yMuCDg/VmzdT5IXlDWz?=
 =?us-ascii?Q?cAAkyzCKZgtRwLr3KC5AZ4WtuFY7TNp9ZO0ItOF8c6Be97GxU02chqizLTdH?=
 =?us-ascii?Q?QlCzDk1op6V9zUivzYQC35M/t7AQXrl2EuAOGuDj2xok69dX4jQL64haJ4Q7?=
 =?us-ascii?Q?p62rgCfmNb2uZLKGF/iIClpOsj8cCzXqzhoAwyxjhvFkvceRo/WxSkvoDj5e?=
 =?us-ascii?Q?Fg+D9UAlj7OCaE3OvuXlaG4I55Ea51JEcCfb39wlBXSosNnVXRYqOzXps/nI?=
 =?us-ascii?Q?/ZeCp3uVwYvLYR4kaWVQxxQuQaF12mFBG3sy1D+o4prstMsijbVcDgagjnWt?=
 =?us-ascii?Q?43m/3mG5Z5t53bvEvxRsQI1kl199lrl6xLJJaUGkuPKzhjyYqK313Mc9J3o3?=
 =?us-ascii?Q?0g965vuB2gYTrEswpUEuImFUtbuq0HiwEGk1YBUOYqOgdzv6KQoHBmYQyt5I?=
 =?us-ascii?Q?9TG55gZDlM4JVnI1SzeDL/X1DzU0lErDK+AvIK2ISWMxdGDVgjxEnKl+m/nq?=
 =?us-ascii?Q?2VNDrXbQRa9U6d/M5gNtTkMSmvSU/TKIyvqyvvijsUJiqMxEr0q7bafFwTQ2?=
 =?us-ascii?Q?mDsGdoTywK+n4Zpi/Rm4yKFMsOBQO7DPfqtroyQQQ5LpvgiPHYJHuWouFyoz?=
 =?us-ascii?Q?WJcyVGsz/oMdlYBPbcY7leClGJMapniqou968hrXr8CBjqmrL6zmRRW+o42c?=
 =?us-ascii?Q?rLAo3P+u/ZSIaz+eraDQfRj93gZAHXvxaRXDPTH13Euz+It7znabOaEh/TYb?=
 =?us-ascii?Q?Ca6HAtTfkrQ0APhY195O2OC7PVmpyFNdoGSuPcslZkjcwL3xmMq1h8rrU3F+?=
 =?us-ascii?Q?dbWxNAdrAejXoZpcITkjWMumvcc9AwYidDJ1+0qiZkeJOICPjFgK/QMxJm7u?=
 =?us-ascii?Q?bp+k8zFCJ/k/LGUnhohyAQYn6e+GI/5pk3nQbd0Zzqp+QUPUxZbXzW67mXlm?=
 =?us-ascii?Q?t5/XFzp9bTBnwKaq9trpw5vF/kQWwvOp5UJthRx0kXTSQf4n+2JPZv1Lj6b3?=
 =?us-ascii?Q?2NNoFmqKWQEbn8Y7Xb5MD5+N?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zOXJhXAI4BYXBkJ8ZsBnNC6SWBmOahm97pWrCUrlc48X/QyUqhFVJUEKeKNK?=
 =?us-ascii?Q?Qi1JhsB4h/YZ1UiV6bWaVdJr0h2IPplTeE8L0+vYUIse8wapS3kEPw2/yUzm?=
 =?us-ascii?Q?KQSp9fvsZ3/wtkX1eF0bYFzXNJ/LzyJovVty76Omn/LNYR6yjWngV/CG4eF/?=
 =?us-ascii?Q?GUsiwX7GbhxCQW4ILyGSu7OkHkzmCM/Xp7afyAOEFL5OZg6rWFELjZ8pDQeR?=
 =?us-ascii?Q?mwKNp/FVfIOVH2hmXItIK/u9xshKz2o3UrFumbKHX2jDZILBFEFl+mSoqdpD?=
 =?us-ascii?Q?LE0LnY+bkrkcMvh0gKS4OrJ/QXqzk8G1nBo2ethlLGfFOIhutcBXiaTcj3GN?=
 =?us-ascii?Q?l0DdCbWL41V0XN47Flz9r4ifReDZ4UE0fS0Ywvj86xGFmEGPvW7Pbl20l70i?=
 =?us-ascii?Q?C1PTS24XsYcFg2TcdvoOuiV++w5CUIhSwFZ0eUo1FgVVn76eZMWJa26MnJXW?=
 =?us-ascii?Q?mF+yaV3RxEvbmFf/iWIrD+d7fxtCcYXuXFC+iPnkbzfgpE4bpSlUZTgzEpHc?=
 =?us-ascii?Q?vWw16kR+Px1z8w3jcDt2y4KyaVbSAUqVRqfIavj0p0jIZHtwt40mK7J7rD0Y?=
 =?us-ascii?Q?qs4Ae+w7F+rZc4iAc1nrekJXAa979Ojs61S26C2ZfNssnhi2Fw3mZqKp5w1D?=
 =?us-ascii?Q?Paa+W0MfVDuyZd4AW/Clj8CQ6BWMrmpPwaS7/yZ7EDrz6AtvtaxYUCvbskNN?=
 =?us-ascii?Q?/JvGhHKXvMoPs+khEm67MCJ8eljok/NZzdJkITcukNicdsBj7SHBCF3noE8g?=
 =?us-ascii?Q?cRY6eY7hjVPd61Niag5ZU7G0YbE89MnOyOMNJD4EoKSwBbqgw2Nzny+jHqm9?=
 =?us-ascii?Q?XtF+vG+wIr/cRoVEJw5B09pAiUWABa10ZCVsgos/yus2XbfeMwak1M3mCn5D?=
 =?us-ascii?Q?D2z0u8duciYlxturZR48ATV8BzsKtlnQtkNdo3K4ljTE3z5a3lPYeKltxxfl?=
 =?us-ascii?Q?uzjaSUSmXLkanCs6icZveOIBlNpJX1O7zwZGMdfHAQFF6+maHh8bjnxAq/5I?=
 =?us-ascii?Q?YFXNsx7avquR7rsh4dOFlMskUK7Uy0wk4a9i6YukoUSR8fJ9rSIZrARAu8hr?=
 =?us-ascii?Q?qg6fi7RJ1OKMEtSldPQmAqar3FkKdIy+zPUmUdIzVN2iv0jT9BRg9kO+6qST?=
 =?us-ascii?Q?qlW8l3iGuEWC2Oar74tvGZtl3uLcrmchO7wv8zok7jbFF9K24RwtIFRHkeH+?=
 =?us-ascii?Q?6/SWaSkfrcYh6PYHAGXo7409KuxbL65aI5JJjuBGGhr/iWCVSjirQsQjLPm4?=
 =?us-ascii?Q?UfPYc6ehhq8y4f6nKocVzc+LrrXEbWflxxO0g/4GMoTOT2kIkBDazsAPAFp3?=
 =?us-ascii?Q?hJsf7ghGwZSV2zmm8UtvTwWeGJLU0AiKHPBAFLTcqhpIh3sleMHZZJMlhnaS?=
 =?us-ascii?Q?hyB6lxaNWZAGcujW8Gdl3clue0w31h3NBYErKMs6klHBvdpSxUz8I/6QhFl4?=
 =?us-ascii?Q?+qKVDqcuUHCbN2PMQmj43ooRsbVBDNOe12OrFWa6/HLl4CEehgmR9UultvLK?=
 =?us-ascii?Q?1ebmgFYs04XM2lWcdrLZ7hpocRhXdyFtUEaz1nf6NzbT7C/xiSNPvJovuxSJ?=
 =?us-ascii?Q?Bjv5scUqbWsS5nTaTHNVsHa4oSMHAESf1H1BvqukiEnjueWPBvhF0YNLT+Es?=
 =?us-ascii?Q?VJW/LkeG/leWIAeKRdC28mk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aTkqY71FH0GeHGl39NsA3KuFDK/t+4nUO+5ymIHyYhATH9lfJLiRUVJd8cpiOk1EQyUi2UZDmJWd8oM+24BZOfThuxXJIma4LEi8njr5yRA1wJHENuB54xwOSfGA2JdbSLJLdT2zsbzcsbTq2u366RL6CPl5zzCELp0VLd10hYQPWPSW7R3F1is98uEhWCIP4cO62je9yZPRWvbEIPIEIlFueTTD/suO7vCsxWOimec8yaBfoEAq+dwQqaQ+LftWVmTHV8lgepC38yjXR2n9pdLMqPfisgenhKxJK6VWJZSQWVnqZFKNb366ZMEq9/Uam1rFqhEtkvlX+C7/KLiBoiDhUgKYpe/um2v3OnPFfs2OtUCPuuFCxtXTPe+yEiJt1K2BrTr041yfTmKppFKmVOfQpume4m9o9Ztt3M/RYcLg0A2XcsTzsM6qTZGhcl4b064UrEWYuNXfGOXtG0/Ju1wxPIHz5TvnoecusfkKNELa1hv/Ih0fjg0h4DNPgb9D8svV3/aSB4qGR/59g3KCzIQdg1vTOeQ9NVFZvP4LsMMUMSF1HQ4oTpX1qSJf8udgJtnZfkHn8QUSQY+PmI/O3ct2QUo/5Ih/+OGDJ3AITDY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3061211-43dd-4b80-e0f1-08dc920bfa18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:05:32.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/vsbsx1VEDBubiJiK5L+VSOtWwFC2NF8iVz3S84HraJda1rdLmTc8aUN7BPnBCSRnZw/y69lfH1mBLh2u8tNANovwYItWanivlo4VQK+hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_07,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210116
X-Proofpoint-GUID: KQUu3EQ41X7e9qIf4TPC0p7hxU-U9c15
X-Proofpoint-ORIG-GUID: KQUu3EQ41X7e9qIf4TPC0p7hxU-U9c15


Hi everyone,

Just would like to confirm if there are any pending comments or
suggestions to which I forgot to address so far.
I know this was a rocky series, my apologies for that, and thank you
very much for your detailed reviews.

Looking forward to your comments.

Regards,
Cupertino


Cupertino Miranda writes:

> Hi everyone,
>
> This version removes regexp from inline assembly examples that did not
> require the regular expressions to match.
>
> Thanks,
> Cupertino
>
> Cupertino Miranda (2):
>   selftests/bpf: Support checks against a regular expression
>   selftests/bpf: Match tests against regular expression
>
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
>  .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
>  .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
>  tools/testing/selftests/bpf/test_loader.c     | 117 ++++++++++++++----
>  5 files changed, 104 insertions(+), 36 deletions(-)

