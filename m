Return-Path: <bpf+bounces-66258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F5B30870
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD066881FE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5C2C0288;
	Thu, 21 Aug 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mmYi6n8L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CO2zKivP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2D393DC3;
	Thu, 21 Aug 2025 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812169; cv=fail; b=AXJH3wglMKPIMfcgECk/xAgto2ziWrIsUunvCC75+7DxgiU9ntN+zLgZH2xYDwmLeT9o0UMewfUqod2GZ+Dg97iUlqZAgfR4UvKxc8s0/TbD1/bNMgXde9DqwjWL1UYrsqQh4UZ8VOH8JDJQKAIhug5/5XpIVJ9doLBISb9DjR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812169; c=relaxed/simple;
	bh=WqZ0eDP+TBSTJDGgfpGfNNmsIIxJjM55kpBZ1rhUrg4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=U0AyyeKdaxVU+Z+YB04IvSdxTVXE+JBV5DOF9N/NPs8CqkipN/PVLghhw3jSyxpMFlmOmnTvWmPf6XxSlfaBxT6nudj+PtLcSGHfNixhR2RFCJKH+Ro+JEH8tm/TEHXr8jwt3W7f3ww4VbVNbN/+BHNqq1OHQHRxzFwb2KCw6ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mmYi6n8L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CO2zKivP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LLQsL9012303;
	Thu, 21 Aug 2025 21:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=u22mEGRrTQ6drisEQQ
	plxBMsI9lk0SpgayWknsaCYTc=; b=mmYi6n8LzMqLXeGDRpKbp3kPbzST8JIhJG
	XRPRr52/2wLq2gqqUIbGJiuUg0Y043HLbIJXGjpLhpvZ/rrbLmQx//peJrtEeK/h
	C+S/gvcTDlaqWB65WoHeRyQBhrC032369hpKaAnGCdVjN5XGy5ZrxpsBJ1x/xaUC
	8PirMR47PQDa8YfThihn6CVdNGv5731PVjE+VF4u5WJ+UUV9Mt85uD4gnC8twayb
	o2nfFxsoyPVvQix5stVHssdkvJn2wcfy2d4pIxCX86e0MSsrYB6sXQIqjmsNu8xK
	GMBcE0T+FMswO0/xjcjI25M4VFyGkiKHao4jrJzXvO+9/i+hjfIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa2685hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:35:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LKWQCQ007281;
	Thu, 21 Aug 2025 21:35:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3smwjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 21:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MILmPoIgpP5GPYuc67+S1eBR/AALb6pgxXqoAThzbq+D9j77gp46KXKHifCerge0g/nRbyrKOEBWIZmuD2xkMGziBgxaBwZX8hU9X+H7I5MmWNZ0xSTpxw5vp78wmk4hqy9cJCUAJjBJobPgvNIlbp3UAhgIkwOXO4P6jnAYyNVJIbpM3GE0CLf9FsNWKwg5xnc2b3i5QwKavCgFr8yCD1GZrJ220NKZrpuRjEcfqiiHrg/b0PGk0myo/DPjtHJRJUZR+sO3p9ilGgQxGFjqEmydB3HvCePoRg1XErL+3VfpiOCMQUVKsInKL0L/BGyg09owG/BlEYySZMAgyuzjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u22mEGRrTQ6drisEQQplxBMsI9lk0SpgayWknsaCYTc=;
 b=dpNYixAvkjAoWWN2jd+3rsyl8uVJJ3rvkYjpn+vhwLZvtNIHCCVnOvmbT3+Jftk9JELtozjA123yMowT2mRKJz/blo18Fa2wZbuehLVd/jlgRaA9QuKmV4N6YJrEPbeOe1Gc35mhFAdPzjYe1HiezK1j+EXYO4Csj3TtVXoVs34bZenWMBBtqCvOzjc/Mf0Cx/GVjc2krAjkhcPD1+8IqGbeiXM34y3SsyEk9lu1VdrQ+MfkmJZiiMEaNQEvbqznHQZEbhZ2ZphTgNa4cj6l2+J8Ucv1WLFcAAqNNF3xaZCjZd070O9dMPaAFlEOQv7s2ZKd5+C37ixlfDMKgod0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u22mEGRrTQ6drisEQQplxBMsI9lk0SpgayWknsaCYTc=;
 b=CO2zKivPCubKThImYY1FtJjqcmCrjgqTwFL9GxK5CMK0g3W8QeqmFKP6JpGfAITxqlF87FR9T+VvlzsggZHXyTgjFgXMQDOdr4kpIfbOQsCNg0108KrMKsqpv38NVtRI5p1bdNxkYebk6uPBYnwC0jj9OiLXswv2Bhu4uZvaRDc=
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb) by DS0PR10MB8054.namprd10.prod.outlook.com
 (2603:10b6:8:1f1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 21:35:54 +0000
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3]) by PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3%8]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 21:35:54 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>, nick.alcock@oracle.com,
        Alan Maguire
 <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
        Clark Williams
 <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves
 <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
References: <20250807182538.136498-1-acme@kernel.org>
	<CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
	<b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
	<8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com>
Emacs: because Hell was full.
Date: Thu, 21 Aug 2025 22:35:51 +0100
In-Reply-To: <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com> (Arnaldo
	Carvalho de Melo's message of "Fri, 08 Aug 2025 16:10:38 -0300")
Message-ID: <87zfbsici0.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFA3184E4F2:EE_|DS0PR10MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f95fe7d-8d5e-4eec-dfe0-08dde0fab54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9llY3IbrXvMKesun2HqzBg3P1vXBzwINJ4ri1F+HyPL8wofzIi/H7Sl+Ud6u?=
 =?us-ascii?Q?aA0pnhkMIhoEL7B3dFS7XrlGtrq+4glxPgl5bv8dcUI9eE2uqn9lUmkvjBVg?=
 =?us-ascii?Q?Ig1N5a9sUJXp13gg8Tx0N5WWjebyitHEdqme0scrEYNTFRbmKHSSR+j3ytZe?=
 =?us-ascii?Q?LTYKsWrDBAclUaWRTJ/zAosI9TI7n1KZjoBX+VAfIO2A/jUu4jumn/oqEJ/9?=
 =?us-ascii?Q?nAFSzGnlMo7xyCxiU0OX4NLHj0XaaAEuHDOlSsVw32mOURA7gernB1W65GEx?=
 =?us-ascii?Q?cPXO3c7q5GUUqvnzzv3Mu7z3tZbz/Fy8YxX5KjTr4UeuHoFMSlG7Lv+riknj?=
 =?us-ascii?Q?Dx6QVjHeCqPZUzT5kSHxv14/CHLZCr2vQrm/yXDp5fKN7wRXV2oluXCoG0TH?=
 =?us-ascii?Q?glZrZ6WCQhtMt+TruE6iVpuwXqe3fTjGFk7lPDuL3V+EUeR+TQ8uo5f3wMDB?=
 =?us-ascii?Q?cjAKPMKC52VZRb89HqqbcISQquOQPpzL9+Uc/p+1u1SpHbh+I7Wxw+wXVJy4?=
 =?us-ascii?Q?EfIQIxyPzbZfC2+/1oZ25Flj/vAgzezyqzbzoUTsUJuin0NtL45hvYQIvpBW?=
 =?us-ascii?Q?xj6pl9oRUVkHzNgT8jkx/odUIfNZVzkvi4/GoqtYiteobKoBrJ8z6D0XI1nb?=
 =?us-ascii?Q?DyEB54Fp0aftmXWI1cubVi4P/1oWncfyTJJavwUMUG7uXY0i9Uuny23wBmsU?=
 =?us-ascii?Q?V4Rs9XGWxY+1/7pUNEBwr0KUCwRldJ3Kc+SK5dfq4jnc7CvjDHKxJtHLi3Vd?=
 =?us-ascii?Q?jz/LG/uxfcKyhWiDWf6nC50qM8qQIBnky6V7TaHzMTH6kU5AsrYjQqhmFnaz?=
 =?us-ascii?Q?+Z+17wmlfdRceIwzCg7ssriZpesF1q/31rhRbIDUBDjrK6/MXzCzFajBS7O+?=
 =?us-ascii?Q?TZIpu8qK0byFauKAgDjRiAuqoXJDqUweHcp7BX+6BeRbKEk9GM3EqbFdIK0H?=
 =?us-ascii?Q?xpGALJlRspB059CCj952+jAY0Y3b/qoltsvT3WqT5Xw+1NKAGpIJ2O4a8KJe?=
 =?us-ascii?Q?U2xEQ4MetyRnyXJU1V3FkDeO9IBs7p2YjrSkpWfUdlrNHd0CUe0DuKJP355v?=
 =?us-ascii?Q?KumwaQvONbBNuzLOF484YrTM3dNpSsMCvgtPvJYpx7QDld37xs+GJWY/U47h?=
 =?us-ascii?Q?rjt2nxUknnXqaCYsnVR8WMtaiHVZWClxwzBeJGC5uKU799m3gHED2n8Uenpc?=
 =?us-ascii?Q?iUopVZ3cCRi8c3WENVOmYJmWQg6eUXVx8OXQ4s9F6yt0cqtXm4Z57ijP4xFh?=
 =?us-ascii?Q?W0zP7PbzKLt0GRkd9hmhYMYJUAmqXH4vqfF++8cS/K/egit+VtTdC6S4qwzu?=
 =?us-ascii?Q?5wR87Z3jGKsvehOKCqcuwd+Cxa1GitGw8zaHzdfkU2I8mU2qCZM5dmvNJmB2?=
 =?us-ascii?Q?wZdHGAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFA3184E4F2.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4In1u976GxGm1q8fL1RKHgfE8AN7+iNysfzj+1rpO6GIa0oebXhmQ/om6X5?=
 =?us-ascii?Q?zw3UFm2B14RWqo9hUHJqnjTd+RS39PwpiMD3lD4wtm7mfFjfWIL6zJ450Ais?=
 =?us-ascii?Q?+9xDCbtQIJpdibSjlZxzhobGtwTyr1TzfT0zaBOkUeyPgtrdwo1gP6Ebrdl9?=
 =?us-ascii?Q?BckI0+y0L1vMpuxPGyuorOCK2JeXjY9bp+rdOPphLIt+Rka/pXtsnlHXQL03?=
 =?us-ascii?Q?KF95lAzO0ezU+UHI83WTNA2bjBxg8nA4ifC0GHg9xSyGYkNwA0kh9kC/Zz05?=
 =?us-ascii?Q?nrI6xSM+cLXH/Zu+INUvLLElfj3LaD4Wzin0odEcMpg1rSZPlOtPlSM625+A?=
 =?us-ascii?Q?sH5mskjdw3lRsK034in88zCWw1lvbJ+KmIN8KGm967IbDFK6P3PHQPGX4lp3?=
 =?us-ascii?Q?vO3HwIxiCLKOTxQ5nYId9N8by53UT7r8n6fW3sDdcQDIbtfAEHzBOiG4rSHk?=
 =?us-ascii?Q?wV9NaZwY9PkBC4OKKZ1WD5moCNQ3z5goSuCErSLVGyiqMbVs6XtisByvmBet?=
 =?us-ascii?Q?SftjwQWiZ7VC+KsljKpK9afcocPfoJf4rFkr0dqpdLipn2WAVo8qNHdBqn3E?=
 =?us-ascii?Q?Vsfn76egGRt6LVy+hwbEjLEBey7NVaWviRHnfr1IejDSGZlF/zy2Jos46IvC?=
 =?us-ascii?Q?itbkVCJ4YgwH6G4o+vwpfFBMP3qa8xjomx0N8gcGKV0Jqbai8Eij244Hv22c?=
 =?us-ascii?Q?zX85yGm+/5cM+WjbO+MnApoLMTu/7/8KMl2fd/NuS/4SfKFs5rKsbzqB/eLC?=
 =?us-ascii?Q?pMIWnFb4dwNpCfIoA3/ArwxXolFSmSnuiIKgrr20GS8q7jxQVl5uUzn2YVpV?=
 =?us-ascii?Q?hatEFr+D88hkjieAv0gXOubcIwRL9BcQOiW8uJ8MX7Ma3g4gFlT0CbsGk6a7?=
 =?us-ascii?Q?EJLN8N0fgnm+oqc/DnJa6eKTGpIBxSmSYEuMbIr58fmBGMF/QzrZh7VT14V6?=
 =?us-ascii?Q?UaKSGKpjdJ3/nc78GUeNbMI7CKgzXMEpvq2bgmv7h+qUnFr5j9FBr8G1ybx4?=
 =?us-ascii?Q?oxU0W0izhf502mLRv8/tfL0W7jT1d+MpT/Li3x5WxT0SGSlRqNyA3f5yfVQg?=
 =?us-ascii?Q?rhFdc/+daVqyQw7hQ8GKjbjF4RmwStE3xacV8Bsqea4cZHCG2SoZvyssOpnw?=
 =?us-ascii?Q?qsuICG8xa1tX6Rm2ufxiTfuiZASrGqgKo9gvaE89+6V8EAEv9ZfgAZ3yXlWZ?=
 =?us-ascii?Q?WCFlvW0FRiEdDlSAHzT3GnpNAXvO9UsPTbV57OVhGtggHQEtTnpZruS8Wea4?=
 =?us-ascii?Q?YhLvXLRmnPxFpt3Ql5Jbu/HkHV5PjpNI/baYYWSaYkoscIX7j4HawpjSkKY7?=
 =?us-ascii?Q?SqHrbZs0vNUN6uR10t1kgA4AlfIYGRy2a22PnhOFWXF8e4nDFuKCA2GsjTEZ?=
 =?us-ascii?Q?oVRZQFjbAJo8fMZfe7l5mVcBjtzEhgJbivAtS+MujbjogJbhByfPHvTf1pEU?=
 =?us-ascii?Q?4wKIXpMPGxDm3HImY3AFFWIanGxmaq6RjEBYujXR2ASG2rgQd7Z6NacDzsbQ?=
 =?us-ascii?Q?WbuYKHO44YdRpzMRQLHLpfgo9ovmQk+F0j1NUG4zTt00ddD0KFPtVD1v5BQi?=
 =?us-ascii?Q?CGsxA2bpxYDui1ymHF/mPY/wDRb8q6JXwE+buGHJJSiW21s4F7tjo4lIImP+?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9PLeFB/ycQ+3q8iIcW2HSzR3QO/RUR/fgxoyYkHj0mH+XH7+qnIWgCwIGSJgRfgm2pD3q3OZXnhglvWq3VJA4bJyqz7zEIxf0bOiUzX80SWsK23nPo49K2FwZ4ThBac6E0fy4fVRSHxZuxVKrrFymOUtwBhKCXjm+e8duf3nXjrP537wg/tnML2tBSy7b49gt2ONnOxJos4DfRLFhho6XF9WSc7odzpIPo3MLnUgozUos3oEscpFiJzDaM7kOuJlS71fJvwyrUha6MAAqTP799hxif7o9LVH67KicrE83PphIZBu/U5EBj9gKgN9nz4T+A0q+qYuIlFnh6tpFFQ8OIcBw7ziEtB7rM/PdJUOFZFiG/12T8HVk7/fqIiVvqwm6tNhQoxziWZFpkxTrDokivAYJSDVJL2gr/eDdZ5nRCMlqvH5UAy2deNBLrAKuZj2lI0Ty8lSj1ipXSMZBwZXUfSatPu0hSoeE91eO03PV4+Df3sX9wRR1+pyxTB5NWk2OUdFjrwK7mL8PLx/xETmPHfVY416dPt88zVbHnKvKn+2TzR8tWLCs5ca1n3JvS6FB49RMF3LbvcbUcPyGK/mCg3hGzQSjLG2YvR1+WPwrm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f95fe7d-8d5e-4eec-dfe0-08dde0fab54d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFA3184E4F2.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 21:35:54.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMxvRV2/U70y+Dfli7G7vfRM9tCRK9aKDqMJcXn+cZYCqYg+JMvxZkLpR2URer7VTSowPKVFNxitElRsHszSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210185
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a7913e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=PM7QdzbvwkqI9MqRD-UA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ushBtft3AV5MY4JJQB-FNyBI-PXN_dPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfX1KcVrnnnOSFt
 nEgrgMVtZxCUe/YHo+yEYc473NKnsTC5bTC8PL30lk08/fMxsBDNUYYqqkkUCwC+8HA9dJAvFpD
 pzXlLeSaKLU23TOryAXp9V/cBBjZ3b20Gl8dyTJp7RdM8EFH9v8Kg3fJBEuqo1gzIy8CmKPCfrT
 sgNBtPPIo2eJ1fHirRWvEwUCMUbvxWPnpdVjKacXfeAlfLcUlhfYD750nRLiaWOaMyjPLVyjuPn
 cJfK9+cZTiQbMhJR9ep9lccSDAgX0pKugayg2fdsivunb0FW4rwHT5y2OxykAH5XZOZl9G+/NVm
 nVF3M/Q/ikEqkJXSR4RS8M0Px/W9dI6Hcmzmudd0ui2RyQq2ZU+yFOkyVD1Vxcd+DZ9CXr8LyZw
 qL3eHcfzEVFV3jVij4Mw6qy4jSaG7w==
X-Proofpoint-ORIG-GUID: ushBtft3AV5MY4JJQB-FNyBI-PXN_dPd

On 8 Aug 2025, Arnaldo Carvalho de Melo told this:

> On August 8, 2025 3:28:13 PM GMT-03:00, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>On Thu, 2025-08-07 at 19:09 -0700, Alexei Starovoitov wrote:
>>
>>> Before you jump into 1,2,3 let's discuss the end goal.
>>> I think the assumption here is that this btf-for-each-.o approach
>>> is supposed to speed up the build, right ?

Generating BTF directly in the compiler certainly does, in situations
where we can avoid DWARF. We reduce the amount of data written out by
something like 11GiB (!) in my tests.

>>I'd like to second Alexei's question.
>>In the cover letter Arnaldo points out that un-deduplicated BTF
>>amounts for 325Mb, while total DWARF size is 365Mb.

That very much depends on the kernels you build. In my tests of
enterprise kernels (including modules) with the GCC+btfarchive toolchain
(not feeding it to pahole yet), I found total DWARF of 11.2GiB,
undeduplicated BTF of 550MiB (counting raw .o compiler output alone),
and a final dedupicated BTF size (including all modules) of about 38MiB
(which I'm sure I can reduce).

>>The size of DWARF sections in the final vmlinux is comparable to yours: 307Mb.
>>The total size of the generated binaries is 905Mb.
>>So, unless the above calculations are messed up, the total gain here is:
>>- save ~500Mb generated during build

For me, 11GiB :)

>>- save some time on pahole not needing to parse/convert DWARF

In my tests, a *lot*. I think Arnaldo has recently improved this, but
back in April when I was comparing things, I had to kill pahole when it
was dedupping an allmodconfig kernel-plus-modules because it ate more
than 70GiB of RAM and was still chewing on all 20 cores of my machine
after two hours. btfdedup (which uses the libctf deduplicator used by
GNU ld), despite being single-threaded and doing things like ambiguous
type detection as well, used 12GiB and took 19 minutes. (Multithreading
it is in progress, too). allyesconfig is faster. Anything sane is faster
yet. Enterprise kernels take about four minutes, which is not too
different from pahole.

I was shocked by this: I thought libctf would be slower than pahole, and
instead it turned out to be faster, sometimes much faster. I suspect
much of this frankly ridiculous difference was DWARF conversion, and so
would be improved by doing it in parallel (as here), but... still. Not
having to generate and consume all that DWARF is bound to help! It's
like 95% less work...

>>So, I see several drawbacks:
>>- As you note, there would be two avenues to generate BTF now:
>>  - DWARF + pahole
>>  - BTF + pahole (replaced by BTF + ld at some point?)

The code exists... BTF + ld + dedupping the resulting ld-dedupped output
together.

Note that the code used to deduplicate BTF with libctf (as used by ld)
is not large. Look:
https://github.com/nickalcock/linux/blob/nix/btfa/scripts/btf/btfarchive.c
(and of those functions, you don't need transform_module_names(),
suck_in_modules(), or suck_in_lines(): it's really no more code than is
needed to tell it which inputs map to which modules, then a couple of
lines to trigger dedup and emit the resulting BTF archive).

It's entirely reasonable for pahole in future to simply call libctf's
deduplicator to dedup BTF if it sees that the linker hasn't done it, or
to do what btfarchive does here itself to dedup the linker-deduplicated
per-module output and the vmlinux BTF against each other (and then we
don't need btfarchive at all, which means fewer build system changes).

This would let pahole dedup BTF if needed while not wasting time on it
if the linker already did it, *and* let you ditch the pahole
deduplicator so you don't need to maintain it any more, even when clang
et al are being used. (Obviously, you'd only do this once libctf's dedup
is up to scratch and once it's in a release binutils, since I'm sure
there will be bugs I need to fix!)

>>  This is a potential source of bugs.

That's not a very good argument. *Everything* is a potential source of
bugs. I will of course prioritize fixing any bugs in libctf that affect
pahole's operation: not breaking pahole matters!

>>  Is the goal to forgo DWARF+pahole at some point in the future?
>
> I think the goal is to allow DWARF less builds, which can probably save time even if we do use pahole to convert DWARF generated from the compiler into BTF and right away strip DWARF.
>
> This is for use cases where DWARF isn't needed and we want to for example have CI systems running faster.

Yep! Also this means that you can get new features like type and decl
tags into BTF faster, because it's much quicker to get them into GCC and
libctf (at least for recent compiler releases) than it is to get them
into DWARF just so you can get them out of DWARF again and translate
them into BTF. DWARF simply has many more consumers to think about,
while the kernel is obviously a critical consumer of GCC's and libctf's
generated BTF (we do need to consider userspace, but we don't need to be
as conservative as a giant behemoth like DWARF must be. I'm confident
enough in my testing to be willing to backport things to binutils
release branches as needed, though probably not to points before the
first release where BTF support is added to libctf because that change
is pretty massive.)

> My initial interest was to do minimal changes to pave the way for BTF
> generated for vmlinux directly from the compiler, but the realization
> that DWARF still has a lot of mileage, meaning distros will continue
> to enable it for the foreseeable future makes me think that maybe
> doing nothing and continue to use the current method is the sensible
> thing to do.

Speaking purely selfishly, I would be... unhappy to find that I'd spent
all this effort on a BTF-capable deduplicator only to find you didn't
want to use it no matter how good it ended up being :( this seems like a
rather sudden change of heart...

>>- I assume that it is much faster to land changes in pahole compared
>>  to changes in gcc, so future btf modifications/features might be a
>>  bit harder to execute. Wdyt?

As noted, I think this is not really true, at least once the core BTF
dedup stuff has landed: I can backport stuff on top of them without
doing releases, and distros usually pick it up within a few days. The
principal delay is testing...

> Right, that too, even if we enable generation of BTF for native .o
> files by the compiler we would still want to use pahole to augment it
> with new features or to fixup compiler BTF generation bugs. And maybe
> for generating tags that are only possible to have the necessary info
> at the last moment.

Well, yes. I thought it was always the plan for pahole to keep consuming
and augmenting BTF! Among other things, the kernel uses a bunch of
additional sections that reference BTF types that GNU ld has no idea how
to generate, and which nobody is planning to use outside the kernel.
That's also where a lot of the innovation is happening, and GCC and GNU
ld don't need to get involved in that at all (unless and until you want
them to).

I can say that changing libctf to support *every difference from CTF
that BTF has got* and teaching GNU ld to handle that took about two
months, so implementing single changes in future doesn't seem like an
insurmountable burden (and much of that two months was spent on
infrastructural adjustments to allow easier changes in future -- the
hardest single BTF feature to suppoert was probably datasecs and vars,
and that took about a week including deduplication). Obviously there
will be bugs, but when they show up I'll fix them.

I am not worried about the maintenance burden of supporting new BTF
stuff in binutils libctf and I don't think Jose is worried about it in
GCC either.

I mean, it's not like it's going to be an extra burden for long: the
medium-term goal is to replace CTF with BTF entirely, even for userspace
consumption. There are surprisingly few new features needed before we
can consign CTF to history and converge on one type format to rule them
all. (I think they're all entirely nondisruptive too.)

> Now if we could have hooks in the linker associated with a given ELF
> section name (.BTF) to use instead of just concatenating, and then at
> the end have another hook that would finish the process by doing the
> dedup, just like I do in this series, that would save one of those
> linker calls.

Yeah, we looked at that, but GNU ld's plugin support is totally focused
on the needs of LTO and can't really handle what dedup needs at all:
fixing that would likely be a substantial and fiddly change. As part of
the CTF and BTF work there *are* internal hooks in ld and libbfd that do
what is needed, but they're not exported outside the linker, and
exporting them looks to be... painful. (But it seems unnecessary for GNU
ld, since it will after all be able to dedup BTF with no plugins at all,
and already can in my proof-of-concept branch on binutils-gdb git.)

-- 
NULL && (void)

