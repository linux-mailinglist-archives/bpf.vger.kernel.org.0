Return-Path: <bpf+bounces-71192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C6BE7CA9
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51A6E35C3D2
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15922DBF69;
	Fri, 17 Oct 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVC3A6g7"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656C2D8370;
	Fri, 17 Oct 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693649; cv=fail; b=QJRd5uFi9shACjhEk6DsmEHbeKnqBVTB6F8v/MNmeFO6IYlqB0CqL/YesVGn3rqOQ/NcNzgwQIqjrJMdJGVIXOFR8YXTbMfc748mtpsH+CwK3Wiu0xWzAO/EyRR4hF3Ab3AxINy8kYnB15OH8m8tQMAcZOsKDKaQiSDPEPTvrBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693649; c=relaxed/simple;
	bh=UKPusOgfx2Am0TXOKqmSRGGnMA2D52swUs4m0y2BTfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKE38hezOZ9BbbXJMrwtfn6WWT37uYBdtJV/O4wUxALTwJAUDJpggwEhXkD4J/+dXVbr1X57UrHtm/iH0pc3CaUsWeDXpYHtRDicf4r1vLeDGXpEOHv1SgFgTIvV63yWJr3Ej8FrTA40EcMT1vFXJcl7s7MV0VJDdyg9zOt6Xrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVC3A6g7; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUC+FfM21RZv6LpCnpZ1YHuBcNBZFWs2awjyiFW00KeoWhe+1DPtShT7neb4B/diiBs8aBCffeYh06k0Jzu6PyjJ4OrXRCWOgGyP5h+8iByS8sv+f7sV08KLFMVU7yIbFcUy1VxF2+bLbvnDckWppGwrA4rsWTUpFBk5le9QdJWRc5C3X+9p8NnyHn/HVXaiwcG1PvtSnyNFob44D4ZzB8/Ge9qFTFpJGIXhSCW3Qv+jl1KRdQ26SdrdPRcFyvsaX+E1PUCJ9rDnnTE1YUzp0jFdP4D+rvCe23GjP/JBrgpHbfwNVEwEZonNz0SZf16OFIopaMijPMob/E/T7KTvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+TE6emTuJemdv6KssVBWrvUMGebgwy/OXUenyxVphs=;
 b=iFBdfct+hhwfq6a11jzKVA/msCzYW6IIhFfnps1XKGYdm3XOYnFA6d4fCPlHrNVfq5tGP0010Ei6ocRG+UlOkEHpxh4L5+FdlZce+gI8axpjXGljL9/qL5pzB1TmdnJdKrJYpn3sma1TwViyJ2OoIWGenAvKjM40pPBcLVgZzOe/9gCCAtw6wDkb8jbvMQTKTkQgtZZjwXu+j8pwhAkLn+dxvRrDJGxsBxqIXJ12oQgiGgvLJyUA0BKDl+eC0ydN/GoS0mtD0aFe/oZQTKBuLw4tlCYebLAKq/vBiVYXJzdTZCui/ImvpYUMJmlagHV2KyaQgcoNnKTPgvAqs6DC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+TE6emTuJemdv6KssVBWrvUMGebgwy/OXUenyxVphs=;
 b=PVC3A6g72w2Wd7CJlX81r/0Y5AxJFfrODi8bd/QtaceXWYhGyDiiArLdnAqBRFIJE1bRKM41/fS/7T/U23tnPduM3x6NAIS95CX4nO1TMtsQ4yVJJVkT4SaqAkgo6dX8+fZhVL05by2DTQaCzL+36ygY2ExZCvZa1Un2PyYxUEpzvZgo1CeoPAXO3x9RSLhrzCKzvx+z+l5TSTntUF+686g7vY9BTea9E+riV52gt1BPRrQzyDEeRdWBn5mLJM5E+HDKrS+Rt8I3d516MUBUvQ96NwbCo50NC9PB9qkrNZJYPFae+QbiYYOfCuJz4aruT5ihCvmtWLSK5RYDHHVlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:34:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:34:04 +0000
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
Subject: [PATCH 10/14] sched/deadline: Allow to initialize DL server when needed
Date: Fri, 17 Oct 2025 11:25:57 +0200
Message-ID: <20251017093214.70029-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: dee4a953-9fc1-4d44-6424-08de0d604fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omhsNV0O84gdOFzo/CoJhuKNfQNxNHK6wNV50x+c7HKIqI+5KhE4E/BvcQ5t?=
 =?us-ascii?Q?Czt4yAZ6LDND6l2hzyP95/3TLMIG6hlKPDFpnBBHRI7fbY0NiY2gqPHSfzAh?=
 =?us-ascii?Q?0E71tawKLv9XzR3z2jzaYNywY0I5YcXnOLcKWVMFJWY6q7NS121GWZ2tETo6?=
 =?us-ascii?Q?zjjD6Zvk5PkRiaFmdpV+i/Q3MIb0Pjeja4LaIygHdr86OajcGn3zlvL9y1Ec?=
 =?us-ascii?Q?wPOHQ1dAPzBRL/4IBVidsRhqAw0dwnbDw16f6CmhUQ5M/NHeEtCz6kGXXOz+?=
 =?us-ascii?Q?KD7i2QGkYidqyETQGzbewiAcC+m0LbwufE5+xlWEh4mdlQSXuwyLT/E+2+qW?=
 =?us-ascii?Q?ACGUQVbWD1tK62kBJ5o/oX8TN+IAPsP6HMuj5yYqoKX7OakeV9TL8DHYijQ6?=
 =?us-ascii?Q?qW7hV7MZ3gHIouLqkD14htGfUPw6Px/ukmqretdpcOZOod1eAV2XujBlPvP1?=
 =?us-ascii?Q?PFGpyCCj7n+0MphCmo/8hYdVQdGUvYFJI19X28c/keSMoaUbj6F3u4HAHcOP?=
 =?us-ascii?Q?ZlIADU6VjDnIsezp/T+IvssJdkLxZ5+XpHJzioQXm10gGVz2wg1Nw7eKLVhG?=
 =?us-ascii?Q?KCN4sxrBy7qgRaS2e+VE14zJuuRBIBzuwsVKUvWPFckNfZAc7I0mzY8GUqqx?=
 =?us-ascii?Q?svA/kBePIH1duFW7xBN1j5RJdpo/tWQDBv9uEHZgo7PLOVJsE7oYkzEeL30A?=
 =?us-ascii?Q?EJQUnB7NOihdGSilhzBN/khiYPBcFZIOxESzTwzz9A4Co4GNk5zj7D74gyDJ?=
 =?us-ascii?Q?RPYlnS9z7k4gR45Les7RwsPT3OsABt5gZ/p3XuDLSHF8TouXTbex+CSqqYkA?=
 =?us-ascii?Q?p4n9zGROfS5K008lE8ALI18rT/eYFRrdUX6Qu08wKfBnL2iA2OX4+cc1I/1p?=
 =?us-ascii?Q?WvOXLDY0534W41coeEvuQN/pnGFPRI+S5bwzFRpBb1KiAqp9SQb93sSxACXF?=
 =?us-ascii?Q?KXQdyYy0wYLqMmS/WmEjSk2BmA0fxAoMfmOsjNuiyllNK+8bkP8kv9rWi8h5?=
 =?us-ascii?Q?c/jI+cWwu+IE51CYIVVKis6M9JPjP4xf+ftDxmyHXgcIKHZcMvSA+6JYL/vX?=
 =?us-ascii?Q?4CaHkxX2grvzgrXO78lBBMZM8tyFp0/+rdxl4p913y6TkRy759MfRxh1rl9W?=
 =?us-ascii?Q?SnAJI1OxEeeVlmClNwiNJlzu6Po6ys0TIq9csIyvApl28lmNzbeeSK6TEfCR?=
 =?us-ascii?Q?CjED1QRppEgLjj4nhIpN/5EzU0p0Wql75Bo3B2VdiMXD18JPg/zZYCAryesw?=
 =?us-ascii?Q?Vf8wilEdXO7kRh7M5JTNTE191pnrxqcoS4qCoBcqwi95h9BXHI0Z7MBhjj1f?=
 =?us-ascii?Q?/NkSqdJCFAEUtWGFjkVFDcLBFKf1SbtG1rAf4bS/53ZRKeIrCPKm6R5oHC1a?=
 =?us-ascii?Q?cPNTh9x1lQUyEhxeZumITd3gCnnR2IT+txENTXSMkaEwu5j9pQuc/Z/F/KnC?=
 =?us-ascii?Q?bBGgJGowHcWry4haK2LmWrMqmGB0yQ/DDnqBqOJnRo6ApWptjPydGqrc1fHu?=
 =?us-ascii?Q?7uCNpTiO+CjFXxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkhciZDCtj+R+Jg/Ee+fsIVp3cEzQoiJzqoyhgGWI0MDaycBnFC5gularZlN?=
 =?us-ascii?Q?cU03tyw6/vatqrwkjYgHm9V5Ocl63nw6gOsggcS0gvqjMwruTHu3fZx7sMXH?=
 =?us-ascii?Q?g66rjvVscdbET2Zs/P2osMiIlG8N8gF6lW7qzoGDiUTyW7CRVgPreOA88HyH?=
 =?us-ascii?Q?t1JpmBHq5xeKxOYB88zH482rd+sH83HQPL01MUzJjUsUqZPZv1wDiv4bN6Wa?=
 =?us-ascii?Q?FqFNx3mw+32Gxh11lvCXfIpALWJIyHN4ID8knd/ILHVusCznI9x737sl1hrg?=
 =?us-ascii?Q?O9gvImZkzYmARDqSSr9OKBBbw7WbTt5DcS/Ps/ga1cvBQ3ZuuTu14skc4lre?=
 =?us-ascii?Q?ZKFYuTYkEzIjB7Z8SXN7Yn2nckqcBJt+xHw7z/MvBAu6j7s85yd7d4Xk6F7g?=
 =?us-ascii?Q?npkOGphL+4ykBpMTuJEuHeBZHIld6c5BvAmt5oEBy43liwQzkefKR5A4P+Dr?=
 =?us-ascii?Q?qeYGJC/4zYWXaO/UaiDeM1Smnnj2t7uq27enuM/xySD37XB9nXQYsRfZn2VR?=
 =?us-ascii?Q?75wOq/2PjLF1+1fz8Aq11Bjr/kWIoMs2LyAiELRyrzI6zUigEbG8s547RuvT?=
 =?us-ascii?Q?/iNDzLp3NSEJQ2jabBviq2s1g+K54faelHVk6xYS0fbY6rQrFMXYHMLePB9b?=
 =?us-ascii?Q?YLr1Gu8w8IuCk5i5weerwEVtZIXVWsW7DPURHDs7sKjZ8O4O0E3xp6ENO47x?=
 =?us-ascii?Q?3rT+n7680o76BwawoBjjb5N/X9KzlRHUDQ9CnONV2cUQMtoNayyN5uqGj+Nn?=
 =?us-ascii?Q?YtJ8IA9bSrY466s0modaq0jTtWikjHxdzDrl/U2Op2RsB2hDBTK2Ui8oFfjR?=
 =?us-ascii?Q?BqlDwtMmuFXRFk4nFvJzsnxb+MORve8R1lcU7N/KMm2ulHeq6f5QMAOaBfqr?=
 =?us-ascii?Q?owodRUVlzWymRhEKjJcM7dl/7w6uR+sxeXk7MtxSS/kgGokxLOPbzCzpn6w/?=
 =?us-ascii?Q?elDBGlK0C23wrE6iW9V4kcoiy628tN3ILHNqi8ifsLuPkj4NIQKcBF/VoG8D?=
 =?us-ascii?Q?QIufzawb1glqRRlFeBNlNhnR/Q6yFnGg5LwTt4EM94TOU6a8iFrKVlgnkF2Z?=
 =?us-ascii?Q?+MUj5UW7d7Ux+oGbajKR7ondCgmZwFeA9/z3L7yOtc8ZdUpnfXpNyAQRN15h?=
 =?us-ascii?Q?WyvSXeXxQeRGwcjhZgOlVk4gk+9uJ611oA0hCdfJnbS+YDsr+T3ChBBF/BW5?=
 =?us-ascii?Q?X87yLU3F1QhkrgTupMeeqK5fOgyRj1+xR2faYHP3YmIdwG0OZVHg6KVYJKjS?=
 =?us-ascii?Q?bIepVF+9zkilQfw9v3JnHanfuSVV6t5t0vAOYhh3M7xNot1aGsYM2Tp6uzq/?=
 =?us-ascii?Q?yKTywSYyaYadWiFdipLBYiUDUPFGzCiWRAnQuKpWLobx69Pl9oCMq054J5NO?=
 =?us-ascii?Q?dhw+ac/sk+AWkntGITwg2vOCUdGoTNxxu1YPmQ8c3BFwnwHrWvCJzWyQPT0C?=
 =?us-ascii?Q?1oPzKC6ATCavYn6IAiVS6oMM/Obqhdv451NKjcvZyqFp0ajRSl4jZM5kMesw?=
 =?us-ascii?Q?AThjEIPM4GACMVzqVpHjP/feN1jZEUUt1fZ5ujm42vEtx5X09bddJjFQ7t5m?=
 =?us-ascii?Q?Hs8WhPEUZ7rNwpu+MLGrw1eW9r8CMVT0pcPfnSqU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee4a953-9fc1-4d44-6424-08de0d604fbf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:34:04.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLHC1QD1sL5yjvkqis90w3z6aNHoFKFBHAdRXGom0mQDvut6WnbOmeG4aCOv70JaLi8Uf8e5Wv5tDnuVsQ+fhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

When switching between fair and sched_ext, we need to initialize the
bandwidth contribution of the DL server independently for each class.

Add support for on-demand initialization to handle such transitions.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 36 +++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ba2d58bfc82c8..16e229180bf46 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1576,6 +1576,32 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
 
+/**
+ * dl_server_init_params - Initialize bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function initializes the bandwidth reservation for a DL server
+ * entity, its bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_init_params(struct sched_dl_entity *dl_se)
+{
+	u64 runtime =  50 * NSEC_PER_MSEC;
+	u64 period = 1000 * NSEC_PER_MSEC;
+	int err;
+
+	err = dl_server_apply_params(dl_se, runtime, period, 1);
+	if (err)
+		return err;
+
+	dl_se->dl_server = 1;
+	dl_se->dl_defer = 1;
+	setup_new_dl_entity(dl_se);
+
+	return err;
+}
+
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
@@ -1615,8 +1641,7 @@ void sched_init_dl_servers(void)
 	struct sched_dl_entity *dl_se;
 
 	for_each_online_cpu(cpu) {
-		u64 runtime =  50 * NSEC_PER_MSEC;
-		u64 period = 1000 * NSEC_PER_MSEC;
+		int err;
 
 		rq = cpu_rq(cpu);
 
@@ -1626,11 +1651,8 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		err = dl_server_init_params(dl_se);
+		WARN_ON_ONCE(err);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2c1404e961171..eda1141f94fd5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -419,6 +419,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_init_params(struct sched_dl_entity *dl_se);
 extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
-- 
2.51.0


