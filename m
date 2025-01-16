Return-Path: <bpf+bounces-49137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE9EA146DF
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7EF1886144
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A81A4F09;
	Thu, 16 Jan 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahcBKX/X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WcFCHKws"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC625A626
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071978; cv=fail; b=vDrh9ik32mLlRDtyoF58NJtoMwMFWCZsh2IlL2yGdk+yUz+YePEh7H/tfz3BQAXAlb1hEr4w95ZHIMwYUtUTeivCr5L3Z1OIblyDY08jICopnjoAhfgEF9M04UhPVbZef+fDjvqs/Jn6gPejxZ9Z4oTavjlR52cN695Ydp02/kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071978; c=relaxed/simple;
	bh=HjPfIuVHniQZ9a8dpAV7n/g+MS1gp2Pnm8Bd6EFCM1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=MILViuF7DQ9z9yXHn6SzOs9bY4fC+vp9uon0gWiHNS6Q5GjA7pRlkCilOANkDFewUG9UIc/iK4eWXLFc0p5b5MdlgtWqjk7K2NAQDJt1bgzsvWCYCOh5SVD7L9IohaGvmgttFAootH7MK+vcEqr9uBfNQjgOvKXmr9XlIR0NhtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahcBKX/X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WcFCHKws; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GMCEui008298;
	Thu, 16 Jan 2025 23:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=f41QmYeVvKN/lrB6uA
	+26XVkTtyExdSdcaixJb/FLQA=; b=ahcBKX/X+7qTuVubCwjnun17163ab1Kv6b
	WF/9r+OOjz/hqV9ZKIslVEMC0op5LUfAuePJ1BwYvi3GPT4CirIkbs71hLoJgnsy
	rSYouwMK4wfka7ytfBfLk3WWseKeJJWFFIv+ZFQZrmqE/CAZPCmQDcnE6uyq9TDr
	hBrtWhbdtbLLKEGbmMLdTUwdgNi0C7hPRz0IswAUfGWMFT0Z/aaFlK65XS1pWPpG
	gllUefL2l1UXfqVZx/IdmxDqDrVrOklatDrWmw54g5er0wwXaZ01QGLaVcbC2VpX
	UtedY4xGtQ4Ur/yffhOvfupj678fvZMSRAaAUEMwPFs7i6imuaSQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4478pj8cx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 23:58:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GN4vCu032099;
	Thu, 16 Jan 2025 23:58:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3bgn8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 23:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz+hL2zMZYlwf2nGlbcDY02oZEER4XuCFdiPhSjXiwnDVDthkOc7+IuMpRRpdU5Er6TSsQWdDYTYCAmkxQzm87HMeqrWxESCgm0F+0is1la6BV3s8TbXcct2ut/fhj1nXcR1EM4WormL/Fn7eC80IHVIcqB19QPH+GRWcDmEWDCJQTUbvw8lysxVkfKAgrpuAY0/UusuRd0Mli39Qsu6LwXq9Ar6i8bKZEtra201QOIYiYu7kx8MFduEjCzXPR3hIveeDzRZhW9TaZdOezXUeY+g4N7t0fvSixNme1bHQd0hiOx8ULEfygdlZRhXMTfKQA6Tc09LVWPEpjzrXGoXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f41QmYeVvKN/lrB6uA+26XVkTtyExdSdcaixJb/FLQA=;
 b=WHVwtkvrAMaXPFLvzkYl4aFhZvuPB1w246lZ7VnLS3mfxYpP7WHK+6Cic+OayMe4W2RhX9R4QUh+Od8rR0QxmMp18XqvgOJq+yMKBPYzAXpcU6dMw0CUiJ0LTWiSKdkPUgPvaHknQ2Iwb1/hhunYe2k1e9ZZZ3qKi533kfZjUOIx3WNb1rpfW0HzPPTcJJq3vf623+fw9bjJS25QMk+ln1RKDsvnHHh2+ZpNWQXxeHiynMmyOBBjJebpotwPmqKmbKAs4ceah66m2G9WonhYaXKBbxN0blNgea6PDKOmTfUKYn2/XRT7G2k3yrIOR6VCgjWOBJFK0P6ClKW6jZ4F3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f41QmYeVvKN/lrB6uA+26XVkTtyExdSdcaixJb/FLQA=;
 b=WcFCHKwsLacnpyUzfOelmu92YdSfk6761XQUG/J5+heIUSjiyWx1kKsUEBYtNlMKIf9Oa1B5+gpcaU7vOM92HYyL+XIX52We3ZV3UeVmvQq3okfA+R483NUCQmYqQ6zTAHhy188B7XotA5SVl5wMuI1m+t3yI4GoIZ04X7J+pJQ=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by SA6PR10MB8063.namprd10.prod.outlook.com (2603:10b6:806:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 23:58:48 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 23:58:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle
 <chantra@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        Andrew Pinski <pinskia@gmail.com>, Yonghong
 Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
In-Reply-To: <Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
	(Ihor Solodrai's message of "Thu, 16 Jan 2025 22:05:23 +0000")
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
	<Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
Date: Fri, 17 Jan 2025 00:58:45 +0100
Message-ID: <87bjw6qpje.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0439.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::12) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|SA6PR10MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: a078f4ec-f867-43ef-c790-08dd3689b800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?he9uD27SL5wp+vLED+hcZS0CJEpC7srMFzad413j04dTcTcio/t/XYOMiEGI?=
 =?us-ascii?Q?rbGtPDPmGA7fJ5hDuv5yjdL1MMHbYiHHVhuavDiZ0f28rbzXqVSFIjGA2L15?=
 =?us-ascii?Q?Ej8TmJ8XHJA+IOld6Ivb+oqmyIXAYKemag2iqT9C1DumVPBmLVr8M6Q9d+Uz?=
 =?us-ascii?Q?AxhjZ34RNHWUUkv66U9goB4GATblNs+7ByUud+OZSLQMsUctQELak7LVNBD7?=
 =?us-ascii?Q?CyiZqhnKMT0L1K9P4+yuDuZRamU6oCplSzMfBX07PjQ6nTEPxCswCQ67dQyN?=
 =?us-ascii?Q?syhrIQDbYvY8fDsLYUsvwBXeSkuyAZt7V69HWGjV6NsGQyZiCiYpnyHptPiK?=
 =?us-ascii?Q?3E3E5XtqbG4xuv87cAIZzI8LrLGt7AxXqXW4DCkQzyuZvND0+Q3Cx0KHiodj?=
 =?us-ascii?Q?4WpebEtJEGdAcKBLw276jf9p7duDngYCKu/cGsP4Or/6yEzeN0puv4nDvvwx?=
 =?us-ascii?Q?3Bp2f5gvduWhqjyvCNWFUpNPtaWstkVFQ5vu+QxurYtXcBQBBAWigt6QjcT0?=
 =?us-ascii?Q?ZhVGyGpx1MjZKkqx6Bfvwvbw275do3gMkWsJH8Gryi/QymETbDMzRaCiL5s7?=
 =?us-ascii?Q?ttH+WaU6Ds6rHfaVxKkGl/ujwR09LvIyW/I+5jSlypJ43lwU3f7EdzUrhJM0?=
 =?us-ascii?Q?intGWtuqP3NOgPA7C1TwjN0ioqb4iTFg74FMdJpYKOVz9V1ekFndbdPADmHb?=
 =?us-ascii?Q?/g9ontpb8vRiAITohc8SskWEivNmHOEh1K1rv3SFGOhmhINWEqM3NW/XZ4Td?=
 =?us-ascii?Q?g5lDTv6/XPBUhTN7Hvcj3ZICFURYNgTTojzNKaHNSy6C1LJtwO+UgsLso6J7?=
 =?us-ascii?Q?mfqaXeDV6/ahHAQxCA5m0wbXjds1KYo2rwzcLr6PnAMOjLdoWf5aQry/Mefp?=
 =?us-ascii?Q?EYS2wteKsRfEu6N27mLviBzv3NK/1nXECD1rbakpXwR5z5qH5MefgYVw6gQZ?=
 =?us-ascii?Q?Pti/6BlrzwK57kGafD2omVP/VQSPWH73Hjkk0E7YXqUcM8t6cb25oHw1cbHP?=
 =?us-ascii?Q?iqZEoZeu4Vi2VYCMVughf74vzvnAGEApIG6hF6svY/ExHO/CXRRmwUUByzqJ?=
 =?us-ascii?Q?X6d4LJsnt9OlqnEa3eBygF21LoS8NpLNNm057nzXShDgzTgAcFxsS3BZul4y?=
 =?us-ascii?Q?ATsUgEyAWSG16hjmI5A1rpPrlC8/x8qg47xUa9ZATCqKpM9k3ORggaQE3s7Q?=
 =?us-ascii?Q?ToCHv2n2gu5iOWsxnJUeepqBaGN3BktwmLkeW5gIPm4BmDrip2uJoxHLhr9i?=
 =?us-ascii?Q?oYW9/lcOj16dn/F92Xp50Ocdx32JQgqyI97j9y6zi2jG1XEGLG1nen3u1/ez?=
 =?us-ascii?Q?+eA6qJqo5xxGjOAmBv2OzRg7z3l589Gz/m8qNn97UpJTfWjnDX4sjuFq18+H?=
 =?us-ascii?Q?JsDhqr61d8G8TNj15iZ0b77E5mvAW2J3+T2a48+l4HUDvAj3yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87q7Eg9gLkvlA+Bnz/c+78ElPDiOh4Yipaj6ePnGfYLqIqBcTqtdXco6GZG2?=
 =?us-ascii?Q?fbzpCMVRzq0himeuuDsoW8YVWPfLen86Fh6ztKa8bUNalLYGCYSHukFOuY4o?=
 =?us-ascii?Q?2OMh7aytoIo4mA3miDyLf83E7Zt0hdhGXu7sH42bVMqwHji2byAtn4D4fKRk?=
 =?us-ascii?Q?Dkd1Er8XRUmBbpKSEh0RX7RdG1bJygl5gpEaJbEKrA7Fs23mBHNp+PwHc1rA?=
 =?us-ascii?Q?BxU4iP0uFEZ631qk+HBLfjdKTrr9jB7+9HQEcZVov1N1U1pJfl4L5NPoXFIe?=
 =?us-ascii?Q?IZb4boENWLUY0jOQ2R9AkjWaQaesd56L86wYcI3scpkjbgtbZmfb6TKUhvdL?=
 =?us-ascii?Q?Rxoym/fL/Sn/1GImxpMMnVlX7PsItPXn2qVkyCS5WXN6r56uM0ENX9i9VUT3?=
 =?us-ascii?Q?YpqqWZZvMZKVmQ2FgrFFIhiFjmCf8NZ+57RmzUQ2qElSIkLcUHRba75JvXsJ?=
 =?us-ascii?Q?ZBVQteePZTSveq4XZI3iBgy7/KDjRXRulln6tsmnEUUMwXrmadLUWy56RpT7?=
 =?us-ascii?Q?RHJKzTlTwrm0qKG2dwduuu0II4MdTfOcZUISOIz/+4T6kx2kldbBNKEauW09?=
 =?us-ascii?Q?8EIoP5jiRjg5kb01r1tIv1o0KY0ZWGl0t74d3jTrr1um/iG8tT07lTUoNRDY?=
 =?us-ascii?Q?JMKAUsdElfRc9xz61pRjryHijWOwusOY4VZkr0Ag+vrEixkgDhO0nOCtzmxD?=
 =?us-ascii?Q?v7hz7aRSqpTUbz9QMSoLyMd+d5MM00cCHrtbPzEPLKJZpJOuRFE1Pn45atb0?=
 =?us-ascii?Q?TcYNJ4eo7Q2e45Eq6uHrTlndT3DISeS23sxZQMQRpCZ2k7vHLSI6/RXf2a2+?=
 =?us-ascii?Q?CAvkuchKg8PdE73uiSg382bx3sQxNC8VP8rU4CHywOo0zTla7Q51LlSOqTM7?=
 =?us-ascii?Q?TwLWEuTkflwq+RWz883ppIMjYzlog0S1awLbjHCkHDrGl9jt5tgPURfNmXNt?=
 =?us-ascii?Q?3Q4hgoIkmgnZ5oVJmSiT1hVcstNfb0XgSDVrnc5JHWxNx8mj2981RdKPenkG?=
 =?us-ascii?Q?a+m4bSa9iIsJj7EO7IYTWcNewQ4yzGKXo9Mlyjl8SDc2rfK6tM4DJJ0BhuaI?=
 =?us-ascii?Q?HYZ8WW8UHU/S9fSq0MB6V8UVWpByusSuP2nePRmZEEy4uucn8YNGg+7KYzih?=
 =?us-ascii?Q?tnbVKeQOtE+avSxKBopHpJuZR7rBKmcqNGm3M/YxBafFeWwSF39OCj9Xa1KO?=
 =?us-ascii?Q?Vzae9vnotEn2jMhdQP4GbKq8aj2m9ceKMTGHpW60vY2elmtGrHRquHEWRHGd?=
 =?us-ascii?Q?G68Y2UeRuDKT/Brua28mKohEdl5mWGqSoZVvSKZ+wlVVw1WJF7RzHonguHTn?=
 =?us-ascii?Q?Ghv4Dq/+47u4SAWSfDOXJbbaFfMC6gvBJ9njDcv3+CjxGnEAl3lcNEVa3jWo?=
 =?us-ascii?Q?7XVzMTXI5bFxCgGifAgjYFkVQcAuwANw3bfrnk6kbFMjsJeTzw8nMIZcvbzm?=
 =?us-ascii?Q?gWPncI8JmaNU6BYhRmon61FGu82fE+Xy6IBKCXSARThcDzdlzCpkpoxSyNDp?=
 =?us-ascii?Q?Cggy+pZs/QAdq3VrbVZfr9NR+4+CS6uWTOMpcUKS4cNagtCMMY48jEUMRXCL?=
 =?us-ascii?Q?nuzAluet3y4IoONGaP2AGbqyNgjRlCG4WPukmnGL0wLCIRjFN5R4gn/m25dl?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7FFdELQDJwsPgURaqI/t+5HPVAh7KJJwWA3ne1ukE1EjgOC01Q3XxDeJVuiyoi0btc6pm/ZRL2xV/Enav3oO+UPHvXGSFxJZKIFUgRlaGjqjXq5u60yFoVXdvvkgT2ADb1vukKb1X07wTFuKerTjY4ua/SoBNWbVjoNt9IwJnUXFHgYEGxma8S6qkon9Dd/7kTbxEEdri49HzpUTMwTfXcn5N24QpO2LM/yjqr/tvyW9FNOV6SbhhWAG1MbOU0KxJ7l2M0vT3UqrZ8Gkt7NKWmlvb3oGpX+pbHzPFVRfVAqe+vO1x0B+pYx8/ZWfnfZNs2xI3MAglt/uMS89gGPqkvUA1FMy+F3/hxyS47Gt6u1tPpHj4ABjbUZGoPKuj+qY6hP89tNYhoBU+Cqxa1rucq4/G6q271GWTBAy8DXZlxBTMra0E8crhMCWPjORiI6ilzWAnqydZQVYoywtFV2FI8Jx2dnMLk1e6ptb2uNOd0QjcdvLhw2nzeS2wqa7AgKokzQHTVRelmPIDxIePQ7/nZrHzbbk44BeURJhEjYVqmyROzdFMAKnHE/1R2sGsBUZCH6gIGbkt+S+ioiJx7oOb2ny0InqH/kv/6cZSiBXLU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a078f4ec-f867-43ef-c790-08dd3689b800
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 23:58:48.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43lhWiA7VK5nGXDlzU1GEIy4gfq9BSRMDFGQFPUOP4+u/HS6oC9eylG4fnaRYyg39S9rI6mX+AMiV3oqY8j8Rl6c6OGdpGd1KNUbZJyOmNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160178
X-Proofpoint-GUID: nQvXbdgwDSFk_2lCyQEx6mXnHCv538y6
X-Proofpoint-ORIG-GUID: nQvXbdgwDSFk_2lCyQEx6mXnHCv538y6


> On Thursday, January 16th, 2025 at 12:44 PM, Ihor Solodrai <ihor.solodrai@pm.me> wrote:
>
>> 
>> 
>> Hi everyone.
>> 
>> GCC BPF support in BPF CI has been landed.
>> 
>> The BPF CI dashboard is here:
>> https://github.com/kernel-patches/bpf/actions/workflows/test.yml
>> 
>> A summary of what happens on CI (relevant to GCC BPF):
>> * Linux Kernel is built on a target source revision
>> * Latest snapshots of GCC 15 and binutils are downloaded
>> * GCC BPF compiler is built and cached
>> * selftests/bpf test runners are built with BPF_GCC variable set
>> * BPF_GCC triggers a build of test_progs-bpf_gcc runner
>> * The runner contains BPF binaries produced by GCC BPF
>> * In a separate job, test_progs-bpf_gcc is executed within qemu
>> against the target kernel
>> 
>> GCC BPF is only tested on x86_64.
>> 
>> On x86_64 we test the following toolchains for building the kernel and
>> test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.
>> 
>> An example of successful test run (you have to login to github to see
>> the logs):
>> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/35736973856
>> 
>> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.
>> 
>> Effective BPF selftests denylist for GCC BPF is located here:
>> https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>
> The announcement triggered an off-list discussion among BPF devs about
> how to handle the test running, given the long denylist.
>
> The problem is that any new test is now a potential subject to
> debugging whether the test needs changes, or GCC doesn't work for it.
>
> As of now, an important missing piece on GCC side is the decl_tags
> support, as they are heavily used by BPF selftests. See a message from
> Yonghong Song:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-January/673841.html
>
> Some discussed suggestions:
>   * Run test_progs-bpf_gcc with "allowed to fail", so that the
>     pipeline is never blocked
>   * Only run GCC BPF *compilation*, and don't execute the tests

I think that this is the best solution for now, and the most useful.

As soon as we achieve passing all the selftests (hopefully soon) then we
can change the CI to flag regressions on test run failures as well.


>   * Flip denylist to allowlist to prevent regressions, but not force
>     new tests to work with GCC
>
> Input from GCC devs will be much appreciated.
>
> Thanks.
>
>> 
>> When a patch is submitted to BPF, normally a corresponding PR for
>> kernel-patches/bpf github repo is automatically created to trigger a
>> BPF CI run for this change. PRs opened manually will do that too, and
>> this can be used to test patches before submission.
>> 
>> Since the CI automatically pulls latest GCC snapshot, a change in GCC
>> can potentially cause CI failures unrelated to Linux changes being
>> tested. This is not the only dependency like that, of course.
>> 
>> In such situations, a change is usually made in CI code to mitigate
>> the failure in order to unblock the pipeline for patches. If that
>> happens with GCC, someone (most likely me) will have to reach out to
>> GCC team. I guess gcc@gcc.gnu.org would be the default point of
>> contact, but if there are specific people who should be notified
>> please let me know.

