Return-Path: <bpf+bounces-60508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE761AD797F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 20:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BB3A0FF6
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61322C032B;
	Thu, 12 Jun 2025 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m0ZkQCK7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ie3HegvD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CD1DE4EC
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751230; cv=fail; b=DnzNThUw+NGAKdticHUwKrxrZewB/BW/Ykg1wHBveYvQ4XjI6hKZQTNs1cPXBLnUSnK/mvZck4LVM23kkHVBYo6EC+XjM1F1Y/GcdyUPB3i65qD18NYk/iqz3Iha37yr/oAFNi+KQlayWlZj4oDo9ZpZFV9AX8vRW/wADrNAlqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751230; c=relaxed/simple;
	bh=dRH1xwDL5kD7A/Fvtr3Uu/B+4GeEoZAROWwhyMTbRYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=cS4PzT8G1T3eTpLJ5L0Ed6qWlu8AuMh/dfCfqP3S/z5gQzf0gmeSffoyR9G2qLAacvV/6KoWpS1Z7kp0rdT202bXUG2/Xu/yQZDs1+6fVPYexRnGRJae726TAVRw2dYgMbGGXOXGm5g/GnOSqVdDrx2+b3u6ZBBhGCV4JK/wMz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m0ZkQCK7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ie3HegvD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtZec029157;
	Thu, 12 Jun 2025 18:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IiPJ/zYD2nnbeenHx5
	YxrZK83Aq1oTd+qvbsS/rxlCI=; b=m0ZkQCK7dVHZeT0eRi+KQbrq34h3TNo6/z
	5v8twMOi9olCVQAjkZXN+OSjc15EyoIx0kOenAL4IYG5CqXJRT5GTKOh8dU5TtOp
	j0bR7I3vESr0xWiCyaBfGWlZcdU3Lwb1sEXVaisdcsEJmWoRyO+DqZu1oXiScPP9
	FQo8b9JZyKtRiaJ3jjaI4KLX6pn5D1H4gwqIhvS3wkH+kzNPKLepmJvvnfo8IuU4
	Te/xWx+pTTYlWGCb9Z25EZQJURf0KazGu7487vEzgNDB5xh9iCt57g1eQmzHsX0M
	ElYEykRvNVpXV1SQEWbih/jF+z2j4bT4CTU9hqWNDFVJiX8B4e8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk1qku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 18:00:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGb9Jj009073;
	Thu, 12 Jun 2025 18:00:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvcmtr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 18:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV8GdAeIbfpMWq3t33wEcOqsuQ+pVg0nuihg/BvpaSJj3WK+RJhB8Ni9wuwkO5xexI91sWYwEFQ1Z8OSIHqHeCRidXUZS1/Si1s1n38IU4tHdtoxzbpngxOM4i85my+HLoB/1Ma4Adg20QIH9avDGo657m1ha7vqMnJbNi0DwvbCuezHcdc5NBS/ZhDmixAIdpL7t1YODCPC1yFfZpIReLJh7FsDtCcEXLksW2gwGPmnkPX4UqEIsPsm0+gEfzc61kNV0dYr2FezOQLkpNU16uPvP9hbURzSvaL6BeZpoXWGq81ZytEvo5kV0ZmZ+RX95alUyc2VD7kJlI4K2lo+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiPJ/zYD2nnbeenHx5YxrZK83Aq1oTd+qvbsS/rxlCI=;
 b=Znz4DG4PHqKUkVpBJsuNA9e+nc5/teCGeKaV/EsaRBPEfjqYRmYFhhCp7Gvsw9kn7cWvvGbnCFBAtKC7soJseNrTPFEvIOVbDPZtiRKIv621B9/AeV2tEKNMjDdXpxHEyTj59tgm7TRHoyzxuE4IbNlC2U+qqWPhwzwqYrAGVPVKFGLjEkyhFb2MLIdZ5rzWdGa4x5nG+sJb2aWO45CZsh7dFhUMRLQsqU5XL/K/ZMUoqZiAea8WdW0UExgIH07lQsDH6SU2CLdyfCJ4CKCD7+g88+OydRZviWmcSFYJbetviXfQMc9HnoWvOMkpz1AjkQuQt2PgrkMpRtejy8UFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiPJ/zYD2nnbeenHx5YxrZK83Aq1oTd+qvbsS/rxlCI=;
 b=Ie3HegvDQ6kapfaf2ekCbQLhjwi0YGPe/eCXsBz6mXpJFXjOHIPhfT8Y2ZiuYsA6L2TEo/BA9CSHifq0bBix/XkTqQ4V1Fh2xVssOL/UvcLDDVz1/vjEUhNgeMHpIzuz46WR/Rcjr0Qa6Z/VoZ8fjjz53QX+tjVmR+VEEpi5q+k=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by BY5PR10MB4243.namprd10.prod.outlook.com (2603:10b6:a03:210::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Thu, 12 Jun
 2025 18:00:00 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 18:00:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix some incorrect inline asm
 codes
In-Reply-To: <20250612171938.2373564-1-yonghong.song@linux.dev>
References: <20250612171938.2373564-1-yonghong.song@linux.dev>
Date: Thu, 12 Jun 2025 19:59:56 +0200
Message-ID: <87plf87sdf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|BY5PR10MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 907b13de-128b-4928-b6c6-08dda9daf2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MRJK+ZKB27bJBn9kpLB+b9moUcjFrxKADIf8aYpWcqD5auOzaEU2niDs+RoY?=
 =?us-ascii?Q?7xzQzxxJmH5n9Ujpa2foz3xrI56oafS1fvTpmYaMbxVQZ4mYYrF1YIaZ7zuY?=
 =?us-ascii?Q?ScLJNe247YK7pKp4GRNgGDo/MeSh8CzvYkQs4EvapCzlBzkCKKuyUovP58eb?=
 =?us-ascii?Q?4xljsLLdjmGpNAvZfCQ5jkaXAJcBACmLI9+m+vCY3YYRtNsMFCkNy7LFIIGe?=
 =?us-ascii?Q?8fkLC76HpfnGR48doJfLkUp9qm1yxldcM2V6O09R1mKi4KgneG6l8f77JhPf?=
 =?us-ascii?Q?Xw6zFXePA/E3wcydGau5+s9f1hflAyUKXrztBUGo4v3cMlzQrcWNRmvORFmI?=
 =?us-ascii?Q?ouHTMnfds99UrICndkBO/3yhLCrFTLuJxtvfRlwBxesc15fHObeqgwwZyyuj?=
 =?us-ascii?Q?IEhuFtIb5e6d4FWjzxgdsiIDvjAtVtGOFcMq9vPq3GVuYnucV4V2k5Y0Ntaq?=
 =?us-ascii?Q?Bl1FJMtdn6oMWYzSqipvrADzBUQwZGG5vRYP0fcfF2hBQ/+N3txCr0vOA77r?=
 =?us-ascii?Q?IrFJ4jOS30Gqnu8Y2IBZef6CIJUixh/rWJ1mfm2o3ZqvxgPFJPOOg5AJakKL?=
 =?us-ascii?Q?S3dylNXk828xBtV+iX87gQ7PHh4BhSL3dJhJ0eXv1c1lKJgVEmW67lOiSOI/?=
 =?us-ascii?Q?v+UJzKx4GyrXm1mfOskmQQD9o1rQprFmnQb7rTHWexM2JB3lJ0Gi3gN2J/99?=
 =?us-ascii?Q?tLbbgmyJFeQ/IiG7PI2zol7Ec4WyuzVAiqcGnRuFhv3yuHSMNKU2cX4vKje7?=
 =?us-ascii?Q?xgUvkXEGmj+4AQtz0+NEM1PHD1M3S2hQGWK4lv04bQWwfhB9n1p3iz4S8giA?=
 =?us-ascii?Q?YB9MKPoerQfMfExo7LKAunKTIptbDqqaCvLE/WTvmAeClmSED27VrCEiakxb?=
 =?us-ascii?Q?T847bVLNsB9tZILrFnWiPiLZzhrxPxEPNo/2XnFtCo9ReE6F5twCNylsve17?=
 =?us-ascii?Q?oOKuAxrBDb9Wa7/WprRlvDKU+pPlYlFTeRayiQuAs93UoS/FUvjTA3BOl318?=
 =?us-ascii?Q?/Mnd0MPIgNO0PtYxZ0gWnpw2iRsa9Jgb+9xlaqoUgk9DVXxJo56dbuo2R4qN?=
 =?us-ascii?Q?owWOO5Pn8PoVzBq3rM8ZHnrQqQoYbJqCHxq5ytx3MKv6DTOKiXCgLNLeeUZO?=
 =?us-ascii?Q?1ung0yBrTeflTfI0O6tbVELo59UIj+aCEgZzZEz3IubZFRiWXdmQ5KkqOf1D?=
 =?us-ascii?Q?lbfQdYT0XiL2NcdcMEpqo7kvIT3kz5IzM+ih90xGqpZXGpCf9oMzhiAifmnZ?=
 =?us-ascii?Q?gUXh6wgWwsp9eVGImRa3U/Rijz4x3gJHmP5jr6HsSYC0QVEkwJMaWeJ69ysS?=
 =?us-ascii?Q?4OLad8WZkfi9eYJ/kKWCN+bUHzlmZbtscayLB4nDbhmbpdhAruwOcITpuT2Y?=
 =?us-ascii?Q?lNlZ1UPU1RrKWyLE0wCSklViGmWK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jLNT2h1MYb4xUvcbW5RGTkkfp+5XMQR2Uj7y57kkMUTStvKkTfoauK5AcTQ?=
 =?us-ascii?Q?6dly3taBf52/hvWw1kbMoi4E+Qh6Y2LofjFjpxsG8f6bMPsfPDczYkoylxuK?=
 =?us-ascii?Q?N5V92RkBzLh6o8PdZKM9dCItxAKJte9584EQpf+OyfBSnBgbSFRwLJgbN3VY?=
 =?us-ascii?Q?Km0f80Oto7+WidogEA00k8TmiP/PqxX7/3DwmwE/Ay3H3O7IOqIJDmoLT7IZ?=
 =?us-ascii?Q?qXMMx+3VGKdevccM7go7NPtNNxaF91mD0x5W9oMwlbtLJmK/EZOVe0s/OJeZ?=
 =?us-ascii?Q?nG98qLiGfDV4qsk0xJSj8NaTLrMzBQrNSOcYu6nHEPeioyND/gY9dpnHtF9v?=
 =?us-ascii?Q?eAxTeqWa+5UaAr97Dprde5A48I/Kc9XViBTRWUYOP1yViH2pMrV6HrG+/rt3?=
 =?us-ascii?Q?AFYU4G9lWHbclRUc+v64IJCSTFn2797BtVjCBzpRnwa8GOAxPoyaquf9r0Vo?=
 =?us-ascii?Q?uBEz5VPTXT6hxuhsr4QcDftBqEirro7V8dxBp/KSwq3mLvEy6eelXCuGiTZL?=
 =?us-ascii?Q?6JR3x+DVCQJwWkXx2f8IBSdXGEv6Lb925K5u6LBZD97kq+8rPVoXfD+SMGS9?=
 =?us-ascii?Q?kq6MjaJdhHP1tPdsoUs+3DW00D2krgiBp+jrI2GU37VEyW6/GW45PSMLbiIf?=
 =?us-ascii?Q?pH659DJVAzGX2fdBH4wdG0POeNBN0sBoaD10M2DcGlYQR8SIvd3H0yJKif1v?=
 =?us-ascii?Q?6OYvtvo2aUPCn86xVfe4l2wsvbItTAJBK55uj23ha+tqaIUfNqa1772awBU9?=
 =?us-ascii?Q?/TYs3CkcWrG1/3hJZ49Edu9/Y0s865nW1Dct375PzSkY47LkesQP4JTHdO7E?=
 =?us-ascii?Q?BEx7T81Ea/1kLVmXFtawvRo7AND0RoWY0BcQLqY9bnzblFLccTqOY6Se4CW5?=
 =?us-ascii?Q?NTabNck8nkFpfT4JbcT9ZjVeO8cTHxKUhr4D1nkv84E46Pf8lHSsnmV5DDy6?=
 =?us-ascii?Q?uGQFO2GJG6Q8+uUFO4BhVMXoswQocbmNNP5SFJHOhD8ebkor6efQi5fhbs+5?=
 =?us-ascii?Q?DrpEUIxACsxE6EJwyzKw32/dBCLfTlZl8XmqD4okzb32VMmrqkLFc7lleMqL?=
 =?us-ascii?Q?YGkna1hvkTaVFMhIJSBEKUY6lWddAK4Y3oMKJeRKFXCn0kPBUNrW7ev5V5uO?=
 =?us-ascii?Q?7nnDwp+ztjN2JKH7XxH8orF7VFKRJ+nz7oHIueVi1QW9zaGUh+RarJ33Vdlz?=
 =?us-ascii?Q?HfYZdBmliycdtrnCUYJi/TwTQMAkZJiQH9WV5pIotwUzDNTFHNuygcBRXSDm?=
 =?us-ascii?Q?QB4FU2rdEfBAeUKULlqRTwoYukoPiVIHepMaGvGMOw5mqsTRdVC34C++1+/Y?=
 =?us-ascii?Q?GsiRdW8cp2h0A58J5Ra7+0/gCNHUcEe7mi1hK0ucW4TCuCrvliJLuj4SQ4qM?=
 =?us-ascii?Q?DCKiLon11mvUM55ztfIjqcjlrwshQ/qQYMNsuAOZVE6F2s6zGqKTvuqa7ph9?=
 =?us-ascii?Q?AyhiK0anzrNt7XJDdP1gMqkvi5Kq0/EX5R+bNiobWjQJqV1DZbkCd3+ETPkx?=
 =?us-ascii?Q?a2a7fpQFRfOGF0WjVr271UiTxgKcnyx/dqaRgJW03zMq6G3krOGMAH2SObXF?=
 =?us-ascii?Q?vircdZIxcOpTMzOiKTjMhgltapvfiwQu09SusRsuPTycMMOt59iXSxzfbbxW?=
 =?us-ascii?Q?Ul2fmDL24LO71kqNPinABVIr8WQAJYvdaqs0Sdz2GXeN+LEEwubg8JQ3XVKQ?=
 =?us-ascii?Q?w7IFmg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q16MpyGKwM783A548fVY9OcjLIgWWU9DkUsb9uUMx/QwSMV01F3Bl+1dV31a92XDUxTVtqNxhn1QxrSnUyiu4rQfGGv6OHcXNdO2dQc5H0PtEmOKNUtsQYSDvNrUWLAcRBYy37QYGHqNcmABx8VzSPlthzf3+PMDhKlh1CcyBdYT1X/TQq9Rtt4eJ2SvD9Z8UkiX60TUH0i7OV1fv9fFeKsPcmosu5zt0z/cbR4isPZjebp3FvHtIld1kh30gNG2mPNGIPwohGvl7LSmB1G3jjg6YASvdOg37HIe6B+qQlEgb5qOB/FD6DBjbkU8C8R19wZ5Kp3iRZzcX2rw+arw2X4zjOuxJveM5RC1UGOhqm1KpOgrf//lzHgoP1UXlP31D9PcWorC73qPVM5MQ+TANuMEKQZTqhYUhCAH7lVnGUIEAn0fMO99GIOMGNBeQvTLa5jxOVBdl94E446u7HB8V8W3smfzw+WFze/seCESjurlW57LFTnTd6QY9VQma4P/q1uxmRevYmddI4R0RIu93viq/X5Om1JSmK9tS2eHoFkpPNt95R0+QHb0brNxiylO1SRqIYX8djBLvSZleEiXLXUaUSyHhciqnYAiX9K3ZuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b13de-128b-4928-b6c6-08dda9daf2ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 18:00:00.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65rlAo5LbZv/QH4cOGRsrpww0QVCG9ju3FXEIdExA1Ez8m0B+3M+N/p1Dtt5T+Mb8HPBc7EOf2MMPrZnj6w7Tlyr7exMGZVC8jXnM9jBwTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120138
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684b15a3 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=SaMwMn81APTqb7sfxrsA:9 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEzOCBTYWx0ZWRfXwX318iisXQEI SjMH8+Wiv6F1NWEWfMIx7laxwgF0MIane3jK+Eu3QCZgcjN41t5bhBut7mhMbohG0E8OeVmludj 6cjSgNCMkAYfC03BKjZ7PA0F/UDrxb9t7Zvui/YfzxIPUKtYoFgUzLEnt4HbWHq84eDUZ8TWhO8
 M2NiCYE6/p9ItYb26CiqLU8MYDHi9hhZEjOWJQInL26hCCI+yxGBhwkz6V1vHQEmWk5UQh2Hedo Ub0rHoS2xU30k4FRpumcrktnye4pPDAduoMeCheWbZjaef//fhmyWBycjRVUIw1IrylcVSjr2+2 7HQUkFkGASt3hI0peBiekEO4OHaa67+s2beZFtqMFjXd3autC8B3YVh2LR4YA9e/mCMGk5Y9vQY
 pVvJEHOoRsuufDX6xTa4PsaVUt+LA0z6QMvlC5142WlRF/V1DhMKnW9nKPiUXsK4YLwIoxAd
X-Proofpoint-ORIG-GUID: IMfgxkTBCg-ZryQIMpigMGzfs7UXRsyz
X-Proofpoint-GUID: IMfgxkTBCg-ZryQIMpigMGzfs7UXRsyz



> In one of upstream thread ([1]), there is a discussion about
> the below inline asm code:
>
>   if r1 == 0xdeadbeef goto +2;
>   ...
>
> In actual llvm backend, the above 0xdeadbeef will actually do
> sign extension to 64bit value and then compare to register r1.
>
> But the code itself does not imply the above semantics. It looks
> like the comparision is between r1 and 0xdeadbeef. For example,
> let us at a simple C code:
>   $ cat t1.c
>   int foo(long a) { return a == 0xdeadbeef ? 2 : 3; }
>   $ clang --target=bpf -O2 -c t1.c && llvm-objdump -d t1.o
>     ...
>     w0 = 0x2
>     r2 = 0xdeadbeef ll
>     if r1 == r2 goto +0x1
>     w0 = 0x3
>     exit
> It does try to compare r1 and 0xdeadbeef.
>
> To address the above confusing inline asm issue, llvm backend ([2])
> added some range checking for such insns and beyond. For the above
> insn asm, the warning like below
>   warning: immediate out of range, shall fit in int range
> will be issued. If -Werror is in the compilation flags, the
> error will be issued.

I believe in GAS we used to do exactly that, to error out in case of
overflow, then we changed it to match current llvm's behavior after some
discussion at https://lore.kernel.org/bpf/877cpwgzgh.fsf@oracle.com.

commit 5be1b787276d2adbe85ae7febc709ca517b62f08
Author: Jose E. Marchesi <jose.marchesi@oracle.com>
Date:   Thu Aug 17 09:38:37 2023 +0200

    bpf: gas: consolidate handling of immediate overflows
    
    This commit changes the BPF GAS port in order to handle immediate
    overflows the same way than the clang BPF assembler:
    
    - For an immediate field of N bits, any written number (positive or
      negative) whose two's complement encoding fit in N its is accepted.
      This means that -2 is the same than 0xffffffe.  It is up to the
      instructions to decide how to interpret the encoded value.
    
    - Immediate fields in jump instructions are no longer relaxed.
      Relaxing to jump instructions with wider range is only performed
      when expressions are involved.
    
    - The manual is updated to document this, and testsuite adapted
      accordingly.
    
    Tested in x86_64-linux-gnu host, bpf-unknown-none target.


>
> To avoid the above warning/error, the afore-mentioned inline asm
> should be rewritten to
>
>   if r1 == -559038737 goto +2;
>   ...
>
> Fix a few selftest cases like the above based on insn range checking
> requirement in [2].
>
>   [1] https://lore.kernel.org/bpf/70affb12-327b-4882-bd1d-afda8b8c6f56@linux.dev/
>   [2] https://github.com/llvm/llvm-project/pull/142989
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../testing/selftests/bpf/progs/dummy_st_ops_success.c |  2 +-
>  tools/testing/selftests/bpf/progs/dynptr_fail.c        |  2 +-
>  tools/testing/selftests/bpf/progs/iters.c              |  2 +-
>  tools/testing/selftests/bpf/progs/verifier_and.c       |  2 +-
>  tools/testing/selftests/bpf/progs/verifier_bounds.c    |  4 ++--
>  .../bpf/progs/verifier_direct_packet_access.c          |  8 ++++----
>  tools/testing/selftests/bpf/progs/verifier_ldsx.c      |  2 +-
>  tools/testing/selftests/bpf/progs/verifier_masking.c   |  4 ++--
>  tools/testing/selftests/bpf/progs/verifier_movsx.c     |  2 +-
>  .../testing/selftests/bpf/progs/verifier_or_jmp32_k.c  |  2 +-
>  tools/testing/selftests/bpf/progs/verifier_raw_stack.c |  4 ++--
>  .../selftests/bpf/progs/verifier_search_pruning.c      |  6 +++---
>  .../testing/selftests/bpf/progs/verifier_spill_fill.c  |  6 +++---
>  tools/testing/selftests/bpf/progs/verifier_stack_ptr.c | 10 +++++-----
>  tools/testing/selftests/bpf/progs/verifier_subreg.c    |  6 +++---
>  tools/testing/selftests/bpf/progs/verifier_unpriv.c    |  2 +-
>  16 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> index ec0c595d47af..54b3d599f31a 100644
> --- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> +++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
> @@ -19,7 +19,7 @@ int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
>  	 */
>  	asm volatile (
>  		"if %[state] != 0 goto +2;"
> -		"r0 = 0xf2f3f4f5;"
> +		"r0 = -218893067;"
>  		"exit;"
>  	::[state]"p"(state));
>  
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index bd8f15229f5c..7c7dac6bd3c2 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -761,7 +761,7 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
>  		 *(u64 *)(r2 + 0) = r9;			\
>  		 r3 = r10;				\
>  		 r3 += -24;				\
> -		 r9 = 0xeB9FeB9F;			\
> +		 r9 = -341840993;			\
>  		 *(u64 *)(r10 - 16) = r9;		\
>  		 *(u64 *)(r10 - 24) = r9;		\
>  		 r9 = 0;				\
> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
> index 7dd92a303bf6..e13023fa9593 100644
> --- a/tools/testing/selftests/bpf/progs/iters.c
> +++ b/tools/testing/selftests/bpf/progs/iters.c
> @@ -774,7 +774,7 @@ __naked int delayed_read_mark(void)
>  	"3:"
>  		"r1 = r7;"
>  		"r2 = 8;"
> -		"r3 = 0xdeadbeef;"
> +		"r3 = -559038737;"
>  		"call %[bpf_probe_read_user];"
>  		"goto 1b;"
>  	"2:"
> diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
> index 2b4fdca162be..b53b41590b5e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_and.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_and.c
> @@ -99,7 +99,7 @@ __naked void known_subreg_with_unknown_reg(void)
>  	call %[bpf_get_prandom_u32];			\
>  	r0 <<= 32;					\
>  	r0 += 1;					\
> -	r0 &= 0xFFFF1234;				\
> +	r0 &= -60876;					\
>  	/* Upper bits are unknown but AND above masks out 1 zero'ing lower bits */\
>  	if w0 < 1 goto l0_%=;				\
>  	r1 = *(u32*)(r1 + 512);				\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 30e16153fdf1..4a174f182768 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -152,7 +152,7 @@ __naked void on_sign_extended_mov_test1(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 == 0 goto l0_%=;				\
>  	/* r2 = 0xffff'ffff'ffff'ffff */		\
> -	r2 = 0xffffffff;				\
> +	r2 = -1;					\
>  	/* r2 = 0xffff'ffff */				\
>  	r2 >>= 32;					\
>  	/* r0 = <oob pointer> */			\
> @@ -183,7 +183,7 @@ __naked void on_sign_extended_mov_test2(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 == 0 goto l0_%=;				\
>  	/* r2 = 0xffff'ffff'ffff'ffff */		\
> -	r2 = 0xffffffff;				\
> +	r2 = -1;					\
>  	/* r2 = 0xfff'ffff */				\
>  	r2 >>= 36;					\
>  	/* r0 = <oob pointer> */			\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
> index 28b602ac9cbe..1213b495a0e4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
> @@ -485,7 +485,7 @@ __naked void test20_x_pkt_ptr_1(void)
>  	asm volatile ("					\
>  	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
>  	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
> -	r0 = 0xffffffff;				\
> +	r0 = -1;					\
>  	*(u64*)(r10 - 8) = r0;				\
>  	r0 = *(u64*)(r10 - 8);				\
>  	r0 &= 0x7fff;					\
> @@ -515,7 +515,7 @@ __naked void test21_x_pkt_ptr_2(void)
>  	r0 = r2;					\
>  	r0 += 8;					\
>  	if r0 > r3 goto l0_%=;				\
> -	r4 = 0xffffffff;				\
> +	r4 = -1;					\
>  	*(u64*)(r10 - 8) = r4;				\
>  	r4 = *(u64*)(r10 - 8);				\
>  	r4 &= 0x7fff;					\
> @@ -548,7 +548,7 @@ __naked void test22_x_pkt_ptr_3(void)
>  	r3 = *(u64*)(r10 - 16);				\
>  	if r0 > r3 goto l0_%=;				\
>  	r2 = *(u64*)(r10 - 8);				\
> -	r4 = 0xffffffff;				\
> +	r4 = -1;					\
>  	lock *(u64 *)(r10 - 8) += r4;			\
>  	r4 = *(u64*)(r10 - 8);				\
>  	r4 >>= 49;					\
> @@ -605,7 +605,7 @@ __naked void test24_x_pkt_ptr_5(void)
>  	asm volatile ("					\
>  	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
>  	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
> -	r0 = 0xffffffff;				\
> +	r0 = -1;					\
>  	*(u64*)(r10 - 8) = r0;				\
>  	r0 = *(u64*)(r10 - 8);				\
>  	r0 &= 0xff;					\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> index 52edee41caf6..5fa84834cba0 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -50,7 +50,7 @@ __success __success_unpriv __retval(-1)
>  __naked void ldsx_s32(void)
>  {
>  	asm volatile (
> -	"r1 = 0xfffffffe;"
> +	"r1 = -2;"
>  	"*(u64 *)(r10 - 8) = r1;"
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  	"r0 = *(s32 *)(r10 - 8);"
> diff --git a/tools/testing/selftests/bpf/progs/verifier_masking.c b/tools/testing/selftests/bpf/progs/verifier_masking.c
> index 5732cc1b4c47..7581cd61241e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_masking.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_masking.c
> @@ -171,7 +171,7 @@ __success __success_unpriv __retval(0)
>  __naked void test_out_of_bounds_9(void)
>  {
>  	asm volatile ("					\
> -	r1 = 0xffffffff;				\
> +	r1 = -1;					\
>  	w2 = %[__imm_0];				\
>  	r2 -= r1;					\
>  	r2 |= r1;					\
> @@ -191,7 +191,7 @@ __success __success_unpriv __retval(0)
>  __naked void test_out_of_bounds_10(void)
>  {
>  	asm volatile ("					\
> -	r1 = 0xffffffff;				\
> +	r1 = -1;					\
>  	w2 = %[__imm_0];				\
>  	r2 -= r1;					\
>  	r2 |= r1;					\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> index a4d8814eb5ed..93b513ab7007 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> @@ -64,7 +64,7 @@ __success __success_unpriv __retval(-1)
>  __naked void mov64sx_s32(void)
>  {
>  	asm volatile ("					\
> -	r0 = 0xfffffffe;				\
> +	r0 = -2;					\
>  	r0 = (s32)r0;					\
>  	r0 >>= 1;					\
>  	exit;						\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
> index f37713a265ac..bee5363c1c08 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
> @@ -11,7 +11,7 @@ __msg("R0 invalid mem access 'scalar'")
>  __naked void or_jmp32_k(void)
>  {
>  	asm volatile ("					\
> -	r0 = 0xffffffff;				\
> +	r0 = -1;					\
>  	r0 /= 1;					\
>  	r1 = 0;						\
>  	w1 = -1;					\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> index c689665e07b9..0219d5890d7c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> @@ -280,9 +280,9 @@ __naked void load_bytes_invalid_access_3(void)
>  	asm volatile ("					\
>  	r2 = 4;						\
>  	r6 = r10;					\
> -	r6 += 0xffffffff;				\
> +	r6 += -1;					\
>  	r3 = r6;					\
> -	r4 = 0xffffffff;				\
> +	r4 = -1;					\
>  	call %[bpf_skb_load_bytes];			\
>  	r0 = *(u64*)(r6 + 0);				\
>  	exit;						\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> index f40e57251e94..def73e133930 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> @@ -253,14 +253,14 @@ l0_%=:	w3 /= 0;					\
>  	*(u32*)(r10 - 8) = r7;				\
>  	r8 = *(u64*)(r10 - 8);				\
>  	/* if r8 != X goto pc+1  r8 known in fallthrough branch */\
> -	if r8 != 0xffffffff goto l1_%=;			\
> +	if r8 != -1 goto l1_%=;				\
>  	r3 = 1;						\
>  l1_%=:	/* if r8 == X goto pc+1  condition always true on first\
>  	 * traversal, so starts backtracking to mark r8 as requiring\
>  	 * precision. r7 marked as needing precision. r6 not marked\
>  	 * since it's not tracked.			\
>  	 */						\
> -	if r8 == 0xffffffff goto l2_%=;			\
> +	if r8 == -1 goto l2_%=;				\
>  	/* fails if r8 correctly marked unknown after fill. */\
>  	w3 /= 0;					\
>  l2_%=:	r0 = 0;						\
> @@ -324,7 +324,7 @@ __naked void and_register_parent_chain_bug(void)
>  	/* if r0 > r6 goto +1 */			\
>  	if r0 > r6 goto l0_%=;				\
>  	/* *(u64 *)(r10 - 8) = 0xdeadbeef */		\
> -	r0 = 0xdeadbeef;				\
> +	r0 = -559038737;				\
>  	*(u64*)(r10 - 8) = r0;				\
>  l0_%=:	r1 = 42;					\
>  	*(u8*)(r10 - 8) = r1;				\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 1e5a511e8494..78acd6360267 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -393,7 +393,7 @@ __naked void spill_32bit_of_64bit_fail(void)
>  	call %[bpf_get_prandom_u32];			\
>  	r0 &= 0x8;					\
>  	/* Put a large number into r1. */		\
> -	r1 = 0xffffffff;				\
> +	r1 = -1;					\
>  	r1 <<= 32;					\
>  	r1 += r0;					\
>  	/* Assign an ID to r1. */			\
> @@ -827,7 +827,7 @@ __naked void spill_64bit_of_64bit_ok(void)
>  	asm volatile ("					\
>  	/* Roll one bit to make the register inexact. */\
>  	call %[bpf_get_prandom_u32];			\
> -	r0 &= 0x80000000;				\
> +	r0 &= -2147483648;				\
>  	r0 <<= 32;					\
>  	/* 64-bit spill r0 to stack - should assign an ID. */\
>  	*(u64*)(r10 - 8) = r0;				\
> @@ -1057,7 +1057,7 @@ __naked void fill_32bit_after_spill_64bit_clear_id(void)
>  	call %[bpf_get_prandom_u32];			\
>  	r0 &= 0x8;					\
>  	/* Put a large number into r1. */		\
> -	r1 = 0xffffffff;				\
> +	r1 = -1;					\
>  	r1 <<= 32;					\
>  	r1 += r0;					\
>  	/* 64-bit spill r1 to stack - should assign an ID. */\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> index 24aabc6083fd..1d05d5fe04bc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> @@ -28,7 +28,7 @@ __naked void ptr_to_stack_store_load(void)
>  	asm volatile ("					\
>  	r1 = r10;					\
>  	r1 += -10;					\
> -	r0 = 0xfaceb00c;				\
> +	r0 = -87117812;					\
>  	*(u64*)(r1 + 2) = r0;				\
>  	r0 = *(u64*)(r1 + 2);				\
>  	exit;						\
> @@ -44,7 +44,7 @@ __naked void load_bad_alignment_on_off(void)
>  	asm volatile ("					\
>  	r1 = r10;					\
>  	r1 += -8;					\
> -	r0 = 0xfaceb00c;				\
> +	r0 = -87117812;					\
>  	*(u64*)(r1 + 2) = r0;				\
>  	r0 = *(u64*)(r1 + 2);				\
>  	exit;						\
> @@ -60,7 +60,7 @@ __naked void load_bad_alignment_on_reg(void)
>  	asm volatile ("					\
>  	r1 = r10;					\
>  	r1 += -10;					\
> -	r0 = 0xfaceb00c;				\
> +	r0 = -87117812;					\
>  	*(u64*)(r1 + 8) = r0;				\
>  	r0 = *(u64*)(r1 + 8);				\
>  	exit;						\
> @@ -76,7 +76,7 @@ __naked void load_out_of_bounds_low(void)
>  	asm volatile ("					\
>  	r1 = r10;					\
>  	r1 += -80000;					\
> -	r0 = 0xfaceb00c;				\
> +	r0 = -87117812;					\
>  	*(u64*)(r1 + 8) = r0;				\
>  	r0 = *(u64*)(r1 + 8);				\
>  	exit;						\
> @@ -92,7 +92,7 @@ __naked void load_out_of_bounds_high(void)
>  	asm volatile ("					\
>  	r1 = r10;					\
>  	r1 += -8;					\
> -	r0 = 0xfaceb00c;				\
> +	r0 = -87117812;					\
>  	*(u64*)(r1 + 8) = r0;				\
>  	r0 = *(u64*)(r1 + 8);				\
>  	exit;						\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> index 8613ea160dcd..23584d5880a4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> @@ -615,7 +615,7 @@ __naked void ldx_b_zero_extend_check(void)
>  	asm volatile ("					\
>  	r6 = r10;					\
>  	r6 += -4;					\
> -	r7 = 0xfaceb00c;				\
> +	r7 = -87117812;					\
>  	*(u32*)(r6 + 0) = r7;				\
>  	call %[bpf_get_prandom_u32];			\
>  	r1 = 0x1000000000 ll;				\
> @@ -636,7 +636,7 @@ __naked void ldx_h_zero_extend_check(void)
>  	asm volatile ("					\
>  	r6 = r10;					\
>  	r6 += -4;					\
> -	r7 = 0xfaceb00c;				\
> +	r7 = -87117812;					\
>  	*(u32*)(r6 + 0) = r7;				\
>  	call %[bpf_get_prandom_u32];			\
>  	r1 = 0x1000000000 ll;				\
> @@ -657,7 +657,7 @@ __naked void ldx_w_zero_extend_check(void)
>  	asm volatile ("					\
>  	r6 = r10;					\
>  	r6 += -4;					\
> -	r7 = 0xfaceb00c;				\
> +	r7 = -87117812;					\
>  	*(u32*)(r6 + 0) = r7;				\
>  	call %[bpf_get_prandom_u32];			\
>  	r1 = 0x1000000000 ll;				\
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> index 4470541b5e71..cfe7c013ec2b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -776,7 +776,7 @@ __naked void unpriv_spec_v1_type_confusion(void)
>  	r6 = r10;					\
>  	r6 += -8;					\
>  	/* r6: pointer to readable stack slot */	\
> -	r9 = 0xffffc900;				\
> +	r9 = -14080;					\
>  	r9 <<= 32;					\
>  	/* r9: scalar controlled by attacker */		\
>  	r0 = *(u64 *)(r0 + 0); /* cache miss */		\

