Return-Path: <bpf+bounces-67259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57CB41A89
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB61F56481D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581D2D595D;
	Wed,  3 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ExMz6zo/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2162C21F9;
	Wed,  3 Sep 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893033; cv=fail; b=Gb55mNl0ycYrcPgcitxfdIihSSMBr0OIM7qHTwee5TyUjURaBtezMNasilzU3c8tksaIvi/TCcBnQmlTLEGJWB+DDJikLa2RB6BP5+HujOrUX4TF5K4JjO4jW3eMYNTyx5ofv40G0Yh+5FrARmUn16iesZ2zxs9B+2Mexz6TCnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893033; c=relaxed/simple;
	bh=zRMzsvvK5MXYHuijPpRslBgHgQ7JlzZ69lb+K8Rjoqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofCGgvZ8yEAtdY/DvNEfPgYI23gSj8ppaLVtSmt6DYDhytz1A/P+fEJO9vEHIsp4iXC53IDBYPu010nvCADW24fbQ/4Am24htvfs8BQFVacfqetTQAo4clK1mPk4dAUzIlRX2xtoB/1B1nHb8CLC3pVAYiL/r11ymUuKnU1oX7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ExMz6zo/; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1hFNp83NgaFtIM53w/N7cEiQQHoNhHyYpLjSqGy2/XW/K934hYbaT8G+/NyPzNFzwWVIq6XZBou4pz5NqqBklxDRrozH1CodE6F5hFf9Ksw1iCIeQY3CImtsO/5KztvufVyW9s/GIeUEIHD8M5tgWFcYEVAYFxFkIPnfRfbfyVsSDINS0wgMmBv5RgHmNlis5GBfnirUKsWatUzpUqg6TBAtTJqXD1v09RqUKfa18xoxa1DAriJMNbzoFoFBhl4OpfCe74jkbNUZiBawjBpATO3K1TBVBKnAdmXtcFC0w0JDXUctSi5+3jjt41yXINngIGvMba5lGDMxfX0DrndPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjutrobTKi2DMcGp14IzNGizSQiJU6YF3UBj+VVDRTk=;
 b=BVkcqdwBdVuB+rDNTit+djJSodDT1GWRD73n03hVIEbqHjGBD82kiYh9FjbBAb1IzCweLQunGVJw0PXkHqf9MoU+Q4PcfKQYkMU56wv+zkAxaTqPA6fJRlmaKU7YzBaWAoTwODPmfzuc9M//5ZYynsT3vanfItyNs9WNCjzYB3D2TJMaoHrNpw119BQ4l6+yFngs7OD4pSfM5j1o+XFlnQaoeD+S8fqpZ4j07YjnajBlML08RFYwqOr/yISVS3OzAtNtt1Q7x51VC7xO/cLggapOtLasyg7RTilkoeJ3c+Op0ler0GO1aiaynsNfnHMzBBojdRgPaX01QTTSOVQUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjutrobTKi2DMcGp14IzNGizSQiJU6YF3UBj+VVDRTk=;
 b=ExMz6zo/RG/QSKsHI2HhJoyodMkUnWFrCFp0kj6OFLRTYCZL1h3tV0y0nQcEaAIQbzTKtQfk2roDEdfPb2roqtzzik2lA8RVnDe0tKtLtjalyxlgTv/myMk9y1zx+1xLWF2FGB3F1h696YSOzVIwxkfMCKWxLRHmnFww0O8jkpB8Y3XqLFSlowr3X/Kt8ajkcMvLuc7I0CG/IaWr80EvjtA8mZyVQVg2OXuQwaPPxjlUmA6eZmcfMNNygtKcN5D/gQR9WHdCXry7wd8PL4aGKpcdNNWZS2SMJn/fu7aPe8EmP5nz6oiMJ5QI9CbOvrMog6Mrv2628fdvqyboHgmo+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:50:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:50:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] sched/debug: Fix updating of ppos on server write ops
Date: Wed,  3 Sep 2025 11:33:28 +0200
Message-ID: <20250903095008.162049-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a99cf78-604e-46f6-c918-08ddeacf50e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGdB3LHHmA64J6Su1R9Ikt7EkVJ5J/I/eDIovZCoRZLER7zGdm55H1uq4Z6Z?=
 =?us-ascii?Q?5JDJ/wBxu+bYPcVxinEnf2vtz35ldMpNyFHwcKNgMG+u+u4rc/X5WaWDNH0y?=
 =?us-ascii?Q?xQce8fRvU078aT9MKsqIAIMD9LsXDqUMPBnUBtxYBHOrsM1/JRpzv7qmj080?=
 =?us-ascii?Q?+qRsrCXni+2xojNeyw9a1J7mal8m5vdZK9Awwk8opLvb4S8U6xoZblmQxLCE?=
 =?us-ascii?Q?nH8nqhDZoTJ1xKXtO6jSrAKYwCWed8CuW62p4EYye8atCpFyIABRc3CVHNsH?=
 =?us-ascii?Q?EvY8Tl7cASoKUGwKv/g7TgjAi6xi3vIItbQEJvuMilCb4B8/iB8nNmTFPm2H?=
 =?us-ascii?Q?pwe+YRVaZG/Xq+qopfE42ZZjZ0Jst0ADNLUjaOmk8DN5tBLq99JBiuofq+uX?=
 =?us-ascii?Q?W7nWHY8SGp5DpteBTlSgsklUiH2iBAigjFd6qkb7fdpIY7azTvHnXl8ClE5j?=
 =?us-ascii?Q?9DMYPqJ1Vm7nYVxrAJsKHNw2ccnjzREJn0a1eH/MR6xb6fxKlcsPx11wdkl9?=
 =?us-ascii?Q?jwWTx5Q/u76pO/x/xks2jnNJ70sLJJamcatJRupRDq+vasyzTo7isgbhY3UN?=
 =?us-ascii?Q?kTFDtSSftLCcMLbdA9qtsS3IeZo+PCHnGbLqLqzsiLEzEoRG/dUQJ8Okr6SE?=
 =?us-ascii?Q?kKUAjM+/m4qmf0a3N9BxMysUbnG8d9Zpn3ExuEr3StAatmK0/TvKNAdWA0x0?=
 =?us-ascii?Q?LQakd5V/9OA/Vb9PG9mgWp4XyBhbSN1kXUM/MyrsBwe7mzBsxcSv1WVvt4k8?=
 =?us-ascii?Q?ZYX4BWxvBGfZqBqDsinHhj2hBftSyOg9oMXABj8DCihypfgXMSYHgqu49Stw?=
 =?us-ascii?Q?qe+CRF1pBRSOQCw7w7r729ICpHTL1qnKUV6d+1KGPfiBNswUsVtM2gBzdMSj?=
 =?us-ascii?Q?8qtGymQF7NG0E62aoMU1KvnCe5KnEjr0oloKkE1RKmpMtEifzZfpVon4PcPM?=
 =?us-ascii?Q?+eYCsHvb7EvLntlI0uGjh0EMfZIanSh0iZd1+JOTFvrlaUD3sQ0OL5VxlmTM?=
 =?us-ascii?Q?HFkAzDn6GVPYhNZdeuKOS7arDWt6ruDZONOiXVT/hH6qFarTYkRhf+w6xHPJ?=
 =?us-ascii?Q?0BiiPQ/ROD//jS58QKaaBqXCuVHcZDUbgJkyPGRveKZPAY8Kk1JPFyjYnN38?=
 =?us-ascii?Q?kpf0sFCjRTZnkrruwykmB2v0Oj7Lhf2UPw3dJWvOwtOVXKXkqYksp7Yq55DV?=
 =?us-ascii?Q?tSD6gvDzTOrhkhXfDAM4A5ylb9xe5uO7s2DcYTL7IecxAPLj9BpZ0sAZdNa9?=
 =?us-ascii?Q?KJ0zrQMoF20gM46j5vWYOlksJwXon0c56LWljHrARDESivWfYZCR62KOppm4?=
 =?us-ascii?Q?pQ6En99y70qDP0M2UIarnFP4TtIyzkX53U7O4dbLhFeCBiCtdRZpC3RpcQB7?=
 =?us-ascii?Q?+AUxrdAaK9GXN3Yhu1gXScpdmrvBceeYAdZljetOl4orKnyZcQy0je15pZy/?=
 =?us-ascii?Q?iEQpa3zF2SF4vvNHTBbLtwMxT6ooAUYNGP/UvribQH5riK8Txp9eHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IujA4x4gj3YMiefrjM15VUg8d8uoe4yPUnNBXbBEZykbfigzmsJQDdMDUa1P?=
 =?us-ascii?Q?gEAZIpMbXMuxFm8p2R3ayEWnsBYFXwWG52SwLcl5uZMq+ugs2PXsn8Azd2RU?=
 =?us-ascii?Q?DiYVz5QvCZVkXCkaTMs33Ad+fGvnDTNrcX29G0nkvQAyIdO683vzDt9rp628?=
 =?us-ascii?Q?TfPGhi+8YNu7AVyJelih4OA2tPx0ioihdLK8vtLpu/4WaOe5zzAlJ4sK/Pp+?=
 =?us-ascii?Q?tLG5UBoG7RZv1Boh3F/gKPP8AQ+LZPipR9bwNDKWmdthpvqCpX10XPTuP+Vd?=
 =?us-ascii?Q?9CLz2UC723gsxF/vo2Cwj8PC1ZQPY+X20z968tgC26mTAcrpEqt+emysmsuU?=
 =?us-ascii?Q?bLWIazUTwdEXTBCyBqZNIQSRr6VRledC4UQE0AD+EiGXSROWM9l0Wba/iEG0?=
 =?us-ascii?Q?4eqgQJFk7gdvlbVmUs22W0Wk58QvIxq4JoiilCOUDvgJYCjX1futgfF+J4pH?=
 =?us-ascii?Q?68+8lBhAgU2l6nies0gk0atGJNjRIUJMdThzC/PMry8ZRqgKG0cIGCH0HSjy?=
 =?us-ascii?Q?qT2BVPyxAVnFrJDu/mC2RTzVEPp67q5ttBdhjHd8ZjRdBMdbm+FfL6hUAaTu?=
 =?us-ascii?Q?FZdsxzgFncSjH7F72XergwaNkYhgJR4vQJx6QSvXKa5gDcxAWk6YsN0zYobA?=
 =?us-ascii?Q?Yfus6lBOO0SOaaUIaC7EoXUIPBo79uFe50rrYCFK6Vuz9LPBHuPLEWTDFP2b?=
 =?us-ascii?Q?AFr2MVIKlmb3iBVvtbDRq0A1PJ+2n82BX2GWim48HOJK4oex7iP8wPHFRHh3?=
 =?us-ascii?Q?mk7i6LIctlsmdB0e4Qg9YErbKVdLCzdjvCbJfZdx6G8ZGy73O6nABlZd4TJS?=
 =?us-ascii?Q?0uWN97LWkdqzJhAr1ueq38QjRF1uwMkaDPhzb4oSU7MWFDZadErxBPfJFNiW?=
 =?us-ascii?Q?LQdEqI09ppQC5BlzxN/ImDhTsdajh0xIc7cXeJ1bR2wHPX/gVuExHKF7s9p4?=
 =?us-ascii?Q?FiA3dDYCaL5M9VpcKzr2gYUntr5tiEkcawrxXpwjTGwfhv63AbvFJXThagOC?=
 =?us-ascii?Q?SlV2yev8Rc2Ebj7XgDTU0Awh/cFAx7SyQg3ESAUbbVbIRQZTjSVrI9xFkwrj?=
 =?us-ascii?Q?i1mLI9mXxKXDoY6Sj0446EUSyXvQzfuuwChRCLxDz3A3Q6klvy9YsB6YYXqe?=
 =?us-ascii?Q?uthiVSgQadIQFg15ZCREGnKidgDj7f4fpuncBUbHTbDf7zS7F5I4ui7t+uki?=
 =?us-ascii?Q?E2kZR/UuCjCxw6sAvGtN6chR44ba+DhpuNwRJIs/7n6jl72C6680gz9uPdQ7?=
 =?us-ascii?Q?pey1ByqoIYEZr1EDnbRR3vCjaT5MSzm4XkH+PZ5OAK35UsQWmBTAKCaxolRU?=
 =?us-ascii?Q?P8tC85x7tQyilituexeP+lDw2hSmz955i0YOeIB78hyTq61gElqEvVo02wHn?=
 =?us-ascii?Q?Rm8Q3QXrA6ON4eDDx/Vo8tQLmjfdGsnJ4q2NBpFR4HQ9X6Dyn8Scu1d+OMyJ?=
 =?us-ascii?Q?SDKVu0UNykLDaR42NGnZg8SwRCIk6tWfQNaKs4Uxr6BVjXCbCWX2tEsVFmWq?=
 =?us-ascii?Q?Fv2qIXSc6rZZdE3CO/wHE90OoukAcsla38mBCuPKqNpzkYD/YN6BBzWnBOB9?=
 =?us-ascii?Q?FmUtzzGtSucQtQPlz7VaCA+W/TmdPY0F+VlUzIyP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a99cf78-604e-46f6-c918-08ddeacf50e4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:50:29.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeI7AkG3CpE5M7ELzeDYj1Jd2XtaV4XVM4tI/7K0ZB197i9jAOC3rO5tZ+Sac6oG2GJhKvsssasoxpvJclqLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f0..dbe2aee8628ce 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -382,8 +382,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -391,6 +389,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.51.0


