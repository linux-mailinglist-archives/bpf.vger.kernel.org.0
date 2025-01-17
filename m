Return-Path: <bpf+bounces-49177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C03A14DE8
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C51881C61
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CE1FCCE1;
	Fri, 17 Jan 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KK2dx3h3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i91PvlMh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B01FBEAF
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110700; cv=fail; b=WmGU57RiHwG4vbleIDR65FdH662rRa3J/eNwNGJO9jPxcNah4sD0lY51bAbAfnC2sD8c2mSQT5I3AaNmqIIGb1IALbaxZNcm5DOgqFIOKtbbPg82zCWkQ4YlDUflMHAVjCa/Ap5BokqUOIC15MhTuehw2uWkjv9dXAunRoq1Lm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110700; c=relaxed/simple;
	bh=Vs5hnlVcNvJr0G1GRrmKcFFYHDeiJcxIgc5tJjsQJ/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=feR4hVIwfMtWWgtpSXHxX3D2Fy4U1qxftGQ8F1Reh42GcGEkK2dNpDmEl+OG+Q74N3XGVISwpD7HynUPXQZ4aQm613IMpVguYyHMvvKesdlklpvUkkTdVNNvPbjc/6WF7uTPSQc+GqDsNyB0mzTtMX9hrulB0sXybMxDHIO4xe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KK2dx3h3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i91PvlMh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H5to3l009922;
	Fri, 17 Jan 2025 10:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=iuL57fQPAE7rcoEkEC
	EyB1NznkDhrLrDhoY/9QzRYpI=; b=KK2dx3h3cr9TDorT5dqg7hWUmyvex2aN+a
	qE9lGZtTmgxKgdZgXCeJQfclIrbQqKTE6PLJ3DhLq1R+GsaSwrM73qBTT6+n2tsX
	n/1nUIc6Bjp11vkLt6/EcIcTPqiC10tcIMEFgzpQ6A6NquxlLCM0kuQWoObCyktZ
	MF357Ub0poxcGjU51TPJZV5sOqYlXtZ5vNSP2U7IHfaLQCC+u5i53FKiScapyCSU
	jSt2nf7xEYtuz80WIvFHNYLnEiD1bJ1Uj2a/ohBe9vn2KFqoDmZ4CxsYeYp5qxaJ
	c07Eh+OFiVpcofc9uXhrLgin0LTYiptoolch36ueUYunm/8vbiew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfhrnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 10:44:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9iNEp032241;
	Fri, 17 Jan 2025 10:44:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3c14yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 10:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txQljohejjuuHv9FnzIsNIWs/Q8mlfn562/2Fa4a2YzoGjstTSyl+0KF12nV3lIcfVHLeq2CObMnaAMMndDp9oRkq1XhVvqLB4KFrwspGJu7lH8dlmV5TpQ7eFG+2nx0kTpYWAxm3c0l1BuF8BYuYZJkQxn6jA74ULbIamSORByhO7XFtHI/n9npdKcb3ydqXSUDzH12ul9Ib8jPloJnrDqWnwxvVt8m5rt5al2i5ifU7RWfU6Ip4uzBhuap7qBDhOL4u8PKUQ+dM3zxP9aU9ns4GvYtYplr28eLdrpw6Jn7PS3tLtVf2YUNGglN9xB1T+iognEqJ7/ssU5tODOaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuL57fQPAE7rcoEkECEyB1NznkDhrLrDhoY/9QzRYpI=;
 b=RO6tOrymKm0RQ+FqbpHl8lK56XLhO8BXoBg6QyVCBwj1WXQ7ui22Aoay1fI/U5y8GgBIPwKXCiKu6X7CG/yOEm0w2CKH9OuKw9qNWlWlmmrvraNTg0vcuWj+EEbcA1Xdi1WI1WMZF7Y05DdzFXDraPFtvi0xPiuudTzVi1vo6DSs9cFRQuyx1wbgqq0NvW/DDO3RjqMBbjs7u6OV6s3332pIXhFTCAkks8cDB8Ae8ADho/hfHQGC0Sa2Ez3RbU0XicWYG4zcNpPKa9ZpHEsQdnEFBYiTWaKETUt0yVxiFuTpWtK88NfHKlLgUB7F1ox7DFwevIbZiiJH2r1gTkoBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuL57fQPAE7rcoEkECEyB1NznkDhrLrDhoY/9QzRYpI=;
 b=i91PvlMhDc1ZqpoHM+H8FB6SrQzl3BtKzHVYBwsLRNyJCfLOdC0ZDU3aY7AJHdA4/9okJ0msNLDL/HDrdtbZ/Hq8pREW4rba4yVlB2e2GI/h+RuW89YM+NX/Dk1yl8I4hMUEgT2UV/KddXQRvLgkoSDs8Vz747Za01eK5dus1I4=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 10:44:09 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 10:44:08 +0000
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
In-Reply-To: <8zWDbpQS-9sjNHlLlLHFNncS_8_Tl0clkrX-Jst-1FeRJWHWYpPQe9DLdKTQwfPoLX8Grb0tB-714dcMOFsdTRBd0-ZcYwpkqe-HgGXkenc=@pm.me>
	(Ihor Solodrai's message of "Fri, 17 Jan 2025 03:32:36 +0000")
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
	<Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
	<87bjw6qpje.fsf@oracle.com>
	<8zWDbpQS-9sjNHlLlLHFNncS_8_Tl0clkrX-Jst-1FeRJWHWYpPQe9DLdKTQwfPoLX8Grb0tB-714dcMOFsdTRBd0-ZcYwpkqe-HgGXkenc=@pm.me>
Date: Fri, 17 Jan 2025 11:44:04 +0100
Message-ID: <87ldv9k9e3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|PH0PR10MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: ac10c332-e71f-4d5a-e20a-08dd36e3df2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+j19c9P8owr3RtweIZw3XXZBtBnMvMniidy8m7J/TRP/mv2dTAaTKBa0FCpm?=
 =?us-ascii?Q?FnXPUW1jWOpW+zWRHx6LGTtdexyHibHcueO6C51n4ZuzxGveFK4HiqVKBXFn?=
 =?us-ascii?Q?I0zMm+yPiEBHz/WD0CnugVH8fA1iAJijHtx2sqdr2Kf48OTM+sf1Q3iLW41R?=
 =?us-ascii?Q?J5H8B8HktJYrm9M7i/SCLfs/EGxcX08bWDwNO9eD4brhtgQVBo8F7PvGr21p?=
 =?us-ascii?Q?uhj+u/s2uZB/KjEtq1euNtq1iQORogCrI1xxsFnx4zbTFxo17YEH4f1426Q6?=
 =?us-ascii?Q?R/ucqyBIW3VSP87QHJo/xujxQghnlD/uMy3NMICwhx3aTGDhxxFjke8S+YTK?=
 =?us-ascii?Q?dLU6IslvVr5JkNaLMg7t+GIPzKxnErTCVE8NSMjauJrX8cOdRgnxaL32Ltgn?=
 =?us-ascii?Q?kxJ1+U06BLq7xa5f8ihxHWd6s1ScqVPLNA8+jERG2JVdUAk39sIF/hrZ2Zuj?=
 =?us-ascii?Q?+gtEYJdF+Wmf2QPhXUSMAUUaUSCjoeynbcerOXO2Hlsp3CBgda5S8bFdSAXJ?=
 =?us-ascii?Q?8FGNVe26jhdpNM04My69DE3r7kYGlGzf9GykMHxpsP6mqxbDESXPIBxUYCbB?=
 =?us-ascii?Q?FZNtTBsODLw8f5fswyuAq1q4NhVAU+EsJbZDpji/Zj52xmNmgoaxTp6BD2i7?=
 =?us-ascii?Q?Kl7MCwdoWFxdPNaRkv/AjtuF0BJJ56vArv6kHPhSQ9K1cAN3Euwn9sDpV+Sl?=
 =?us-ascii?Q?3Q3BhFQjcTQ5yM2uv6GDD0DKuj5xuKGH+ijAjXv4mJKMTg/sWkdRl4X3ozPY?=
 =?us-ascii?Q?VEQ69u2QH0BoN/5SU4QPGOVAdapywaYK901l3J5T0B/vEaD/aXSVE/UwpBjh?=
 =?us-ascii?Q?TgHeHasN6srpDRnI6L9Rp14gghZnn8pCJxKrNuAI/7RSuKAfN9aQu6aKEr8v?=
 =?us-ascii?Q?nRKboisl5ePYcj7duGalmB5RkanKRsbdIZfMSI8TgpKN/DWMkEIf8+0CW7SO?=
 =?us-ascii?Q?hJV3upm7iYeLrV8QP2L1R82iR6d//6MfTT51StyCa3LfdG2vTexkr62FnzPx?=
 =?us-ascii?Q?/Xu321cPizIF9w2J8OAfLLtDtpvCD/Jvk+sg9/Sr8wWx36kqbZHV+JldeN25?=
 =?us-ascii?Q?tCmeP8a9hHtjOsxUCTT0x43roXNm5Vdab4QD8SYsNdazmoUghrkbBK7hcqzD?=
 =?us-ascii?Q?TbN/t96lRIjrPPMmZJeqeel3FPCAJcQpfjz3rQNQzoBfCiDFIj4owTSnsyVm?=
 =?us-ascii?Q?gHWPrpEdrcvs56f8Dj4XQZgs7/ly61joSTUErFiWxnMM2bD7ACR5wn54NscH?=
 =?us-ascii?Q?LcuoI1lipzE1U81gydmwBxYRu0gpzvSxa4/j1XzSmOTscdiNxJJx8PFwvRRk?=
 =?us-ascii?Q?15q/ZzGKv/FY89o9wdNkTN4CmCasi7br4Coaq5rWz7udM1wny4ZaxdoxSWIC?=
 =?us-ascii?Q?QNNkwtKS2k/W/NbBuwtydoEn20QE0WIIFvB7q1DWQB7p82LvLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI0Y1SvLw1SqkxcfUsXlm4PCYvUSYUoOD4cbrfXh58rv6S9/EdG0bEdRnCiT?=
 =?us-ascii?Q?8HBVqdnLWf5LIDVYjHicpsilqoLqkmj8elME/7YqmlggPgMBaE+kpn0VvWXV?=
 =?us-ascii?Q?l+p1vd+t/HyHUDa3prkK/ZxtT1NztSWO41Xj7BdWQXnIXxAMIQ+gENWfJBYl?=
 =?us-ascii?Q?Xl3bxqtwQhxC12MQaS4v53pyj55WU7zKs9bJW+UNXipLzie5z4Aviizu4PzW?=
 =?us-ascii?Q?/MAqhBsdFaVReACydE3R4EaYEBjjPQt7lQM8oM7KkPiJe0Eeco4Blv0CaIuv?=
 =?us-ascii?Q?AkH5boRcu8tnvVY0s8Qd7wubiw2ql5pNX7IGJrnUSCR8QswS4JTFZxHMUdi3?=
 =?us-ascii?Q?MEI19sCXxI/7fR8aJavOeQQ94/glEJZT2p9qDmSc75RalqBaJkcoDgajTGO4?=
 =?us-ascii?Q?QUE/H+EGqqezNoO5yOhh/wW5VTCDjyRpEJFExlqhIIG/gJ+RFXRxWpvB4bBC?=
 =?us-ascii?Q?7TTiv7d48nC5rbksA+YIeJYSI3mQdsAW7ruYfuz2LPCxt/xEDwgC/oTwm5a4?=
 =?us-ascii?Q?CPpycQYVsL1EcqpSyC5m/ROqvzzTx5hKbMbe3iO17Dh2r+f7mivGh7QpLNOL?=
 =?us-ascii?Q?a+pChkMg17CNelGiIRpdPyW6BvXdnEl8hzejCDjRSAOpmL2B5JtSI91WbT26?=
 =?us-ascii?Q?kYYCzi7Q3RZ/lmWgg/029Iyyfb74MELB8uPRfH2JnRN41Z37ZSoFNCv2oJwV?=
 =?us-ascii?Q?CPUo429DZCIDb8phfcCe7qokhr5SDwJUE30P1pjYotzwb+TdT8pDkAR1dESl?=
 =?us-ascii?Q?wwxTkKmyJPPViU69ILoa//l3Aod2LzV9VaTBkU63tg3aip+G0tbHdAVNQOk0?=
 =?us-ascii?Q?H+ujrOZj/jhMtZhwPGvJplFH9ik1pblnib5l/R0QnZVFadVWLRWW7VOozHvd?=
 =?us-ascii?Q?rvh5lpW5omRJQ6WpVrhCvY9a2un4Skladg14FHonKCdXs7wQhtLFbEMS2UWb?=
 =?us-ascii?Q?OldJypNhXf1i7esr36g+9x2KGdP710lpawPUcydAUKVwhE8hwL84lvl4Umyt?=
 =?us-ascii?Q?UJJkmUc5lAglLT6pW/CFCPrCWXQMlC09tXx54gCj8rcGewbzkStIDwv98xKF?=
 =?us-ascii?Q?9hW9O+jBLflAz6vQOx29hGJnR/AjOmA+MJSsXFwYH4MCNNJsT1VfhkVjVCia?=
 =?us-ascii?Q?MUXM9ENVTG42i3tXqO57Lw5Mv86+NravdNvPNbbAACxUikDBAccNsq6DWzSp?=
 =?us-ascii?Q?o98Hd6Eg999w8zd3xsLoa7yRLS5zADysBAKPdaEhBcRvX9lJqcV8K/icTjR5?=
 =?us-ascii?Q?W4UR+YfCkpJ9PJI/0PlhWyYpLWIS+bBJWCPtZ15upgPU4CJt41Pq2/Pap78O?=
 =?us-ascii?Q?cN8uO9AZw/BPvCcHd1bJcwcPwpseQGlLrucoBEV64+zBH0LNR8oQ4MWBFRbW?=
 =?us-ascii?Q?lBmfxn3Pmn9TsPVrMogONeLSnh2Wrw8D0xPh4cFkM3hviTNxfFFKQIxbYf1B?=
 =?us-ascii?Q?G+SVq6vYAl4Z7IG6JyJMdwlY5DtIFPLoFlI4LAM7PNE/FtYcSdfzGhJjPWFl?=
 =?us-ascii?Q?Ro5mcN2l/l/sYxw8dTg+pKEXrsDNwSPxbZLbRfiAcq0qn7O7I6LmarhhEMIJ?=
 =?us-ascii?Q?ZxbH+O/Gr+tMJjTvJ5H8ER4BcKV+2nDaB/O9n00zPrwRQPp0Kh3Ia71rhGj8?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6IutG+s2onneHyTT8evwL/HhPwghkx/ZJ/XeMPmrIK5q7miKiuqd8uSEZ9+noy67KUa29ze6OjnKRq41X2JduDA6zmoLpn6aOTpIZ6forAoj+p2Ylsbz2UnVatiFfRgjRruE8Hl9Sea9nuBwUbuKQ2pTz6OvtPzToaDVhsJs4mQZ5TNjyTcSUDUPthFRToVFTRIZXzvTT0/nogvKR4ZclR6sYwhje1CRKWhJxt2/GdsN8b5KwzjS2f73h7UoE2ST2p7yy5QJHNkebiqjRs7tOOwpiv0cQFTWghiyV6Op0yxnpeS7oc3ewGFFLElm6J1BHK3gzp1csiBQZeFgpZ34+6xOcLI0xOH21+1Fc3xg8L9squBgb0X4o5M1mWDmuARRSBKZprtDkZ7cOFqn1V6GaThyiose/sDJQLPhNRthPukN1fq0IJAaaNzKov7LfnIYJ1uGDclCKR1rPUlpRj8qcEkNluVWcQesjCnVQKPyECUP5Dy3oItJQi8TIbV5hEMKD7k1CrmSSec7RCQaJybPtucYFWoIobj3pExfL6YcEbZ0yvfWd68W2CTJlFfNKwONuwKy7uVPIrWBiQulkr4bFxQLPUgo6SyhEc4SFGW+iOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac10c332-e71f-4d5a-e20a-08dd36e3df2c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:44:08.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IBkW72OckUhICLogOqjY4mRdzDfj+4qlCFVAQrHOIUjWvc4tsQ/VMGOMOeaSVU0AUa3a/OdwqIMQPh1yRUlZci0p8CHK/KKnTO/wSi6UbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170086
X-Proofpoint-GUID: hUcJ1Y2cGwWJ9VEJnFrVb8fy6bzyEevh
X-Proofpoint-ORIG-GUID: hUcJ1Y2cGwWJ9VEJnFrVb8fy6bzyEevh


> On Thursday, January 16th, 2025 at 3:58 PM, Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
>
>> 
>> [...]
>> > > 
>> > > Effective BPF selftests denylist for GCC BPF is located here:
>> > > https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc
>> > 
>> > The announcement triggered an off-list discussion among BPF devs about
>> > how to handle the test running, given the long denylist.
>> > 
>> > The problem is that any new test is now a potential subject to
>> > debugging whether the test needs changes, or GCC doesn't work for it.
>> > 
>> > As of now, an important missing piece on GCC side is the decl_tags
>> > support, as they are heavily used by BPF selftests. See a message from
>> > Yonghong Song:
>> > https://gcc.gnu.org/pipermail/gcc-patches/2025-January/673841.html
>> > 
>> > Some discussed suggestions:
>> > * Run test_progs-bpf_gcc with "allowed to fail", so that the
>> > pipeline is never blocked
>> > * Only run GCC BPF compilation, and don't execute the tests
>> 
>> 
>> I think that this is the best solution for now, and the most useful.
>> 
>> As soon as we achieve passing all the selftests (hopefully soon) then we
>> can change the CI to flag regressions on test run failures as well.
>
> Ok. I disabled the execution of the test_progs-bpf_gcc test runner for now.
>
> I think we should check on the state of the tests again after decl_tags
> support is landed.

Thank you.  Sounds like a plan :)

Is it possible to configure the CI to send an email to certain
recipients when the build of the selftests with GCC fails?  That would
help us to keep an eye on the patches and either fix GCC or provide
advise on how to fix the selftest in case it contains bad C.

>
> Thanks.
>
>> 
>> > * Flip denylist to allowlist to prevent regressions, but not force
>> > new tests to work with GCC
>> > 
>> > Input from GCC devs will be much appreciated.
>> > 
>> > Thanks.
>> > 
>> > > When a patch is submitted to BPF, normally a corresponding PR for
>> > > kernel-patches/bpf github repo is automatically created to trigger a
>> > > BPF CI run for this change. PRs opened manually will do that too, and
>> > > this can be used to test patches before submission.
>> > > 
>> > > Since the CI automatically pulls latest GCC snapshot, a change in GCC
>> > > can potentially cause CI failures unrelated to Linux changes being
>> > > tested. This is not the only dependency like that, of course.
>> > > 
>> > > In such situations, a change is usually made in CI code to mitigate
>> > > the failure in order to unblock the pipeline for patches. If that
>> > > happens with GCC, someone (most likely me) will have to reach out to
>> > > GCC team. I guess gcc@gcc.gnu.org would be the default point of
>> > > contact, but if there are specific people who should be notified
>> > > please let me know.

