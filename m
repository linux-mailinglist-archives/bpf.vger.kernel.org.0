Return-Path: <bpf+bounces-75937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99044C9D9DE
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321763A93A1
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 03:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37E254B1F;
	Wed,  3 Dec 2025 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="q96kWuOW";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="gpkPwbhq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C202B9BA;
	Wed,  3 Dec 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731609; cv=fail; b=mlhU1hY11t+21iYg1yjRc9gRMPfkAQyEY9v8pI89odt+De2R0IddBqjR3hOQuS3I+qFjzLmdwVjC2b7jo3h6fFljto9EWH5rkZHfEaOZggf6ZFCF/hp4T+99yquZ0q60FKaC6uEfZIypl/KVrdDiid//Mq57vCE4CPHUxdg4mKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731609; c=relaxed/simple;
	bh=wz9rKnDrpa9DlR+6/U91YfYRF7YR69FFMk+Rg3jtRDo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5l1Zs3cmOcRthueOeb3eSlSYO53Z9m+TYlOt60V4eBCu0fNUdJHMloj+dqb0gjcTb21hRxEKGVrO7FyADANj9G6D7A/Y4kV37z1q8/dWzQQdDo40Ny9OWooaMsymj1ScgoIhjB3DLeLBiVq+coJloDJSHNIm54AFR3aQf68tJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=q96kWuOW; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=gpkPwbhq; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B32wB9t2193908;
	Tue, 2 Dec 2025 19:13:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=d6nBQHf1AzsXN
	Ia3eWkmbyX9M0c0vuPNNSn+Fo4YM6E=; b=q96kWuOWxZBLzXVnbwjppxIt1DBA7
	JjcIVZvXFyHzl7L1IJ8nHyPMxoKhXBWWfQLhMNfX4mgz12HXXJskNCfrfo4JsaYy
	1uvQOy4bBgKUkFuWNPNOelJ9jwi0taLAPcMtK0q9XtauF/OmHaaMfdFSweQnitZt
	+WYqsNGZevQ44q9PRBmik0hGpe3M1wYyYLCdKXs2oP2ocwLyqC/bHjUeyrqtB61S
	+cmocT53J2PGlaLaHZ5cK6naeoHy0p/dt1acHHAqesr2zVptAD6dyScIAvA3rGcu
	axn8CglLN03/QuS7YPf/YO2x0KAEYu+cYwhb6VfGFslMH1q8ZafqEOIyg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021132.outbound.protection.outlook.com [52.101.52.132])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4asttgaeht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 19:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/Iy/EO68CPYDxuP1KnLVTPWt8Eet3w6QtMKA06jO/fFPfdEFF+lDQxNGy/Xz6iKy+eAjgNkntwQQKyybQSuTPlNjkGBJwWXzcHR0eNRXOTniRU6JgeKH5vLSdI3BGTItrNwsDvK0hVbMK7M6tShRUO7JgFX9qmlR0/+g3rASvo0x96oSOVFky+82haBnHKxoxJ8dtQvLV4p6PRYzlrsek5wUiA6zuTm0awyHPkA/ld3IaywF0hmV14vtNe/Hl4gzWC1qbcjUgiBPbySiRy8BCE3niu913jTfsV4P3H2c8UZxjVivtSC6rRFUGhFy4Gh30rBa2BOruGBeJ3gxxiWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6nBQHf1AzsXNIa3eWkmbyX9M0c0vuPNNSn+Fo4YM6E=;
 b=NfA2OTEkx+DOm6g6y474nY76r0mTdnJ35UrM+H0vcW4GZkhqKHeyYyxP2OQb8p93eTh2jk1MVF/QxcrQZUXRbQtJNaVulRpUejdOISuYh1ZndJ5YS0431OsPHcZQtnjK8dU4P/McDeRGYVSIsCpKal3kPP9xvctaxU0ewa+gY8hSvPE+m+iN2ABI+puZBYAEtSqD3j67d/0EfzEVWgUbw9GyWjWz6h6opZz/m5FVf1pCmSJlNMFfUS9erF9JaHenarG5LwNXaVPK1/a/VTLckyIrtHwFwQwTBqsbazPEci32yopaJNqQEGpcChOlQ9CHp61BYefOJPOit0KsEYudyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6nBQHf1AzsXNIa3eWkmbyX9M0c0vuPNNSn+Fo4YM6E=;
 b=gpkPwbhqpH1eJ3Rh8WAjJ+PY4Gv2yivln/BDEzGMXaQFthSqszd34yCMkJjNH5A/hH3JtjKq//slRbcahYakinx3r9PsBN0jZGhhUpNRXQMWka6nJtNOEq1k1e/ctOZ7fYuXbF11K5y4KKRBDcwPAUrc1hCFBhxhDG6U/SPswhri3UvRfs7UvK1ZHTy/zpq2RFJ8RU4lq6xEhHrhrO7YHxvhFQamSRjFFKhoB+CNF4YC5in5Sl82lGVaeMwZkufqX8wayELJsqsfx+DS68sKg68EX3k+st/2y7xg/sagFV39I57XeMulnvHZDGwD638/iylduOnnhW/P6IkWgZvikg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8030.namprd02.prod.outlook.com
 (2603:10b6:408:16d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 03:12:57 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 03:12:57 +0000
From: Jon Kohler <jon@nutanix.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Tomas Glozar <tglozar@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH] perf build: build BPF skeletons with fPIC
Date: Tue,  2 Dec 2025 20:55:26 -0700
Message-ID: <20251203035526.1237602-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::18) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c9e2ec-e19d-4baf-5e71-08de3219dbb6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EErYReQwL0K2YYkhxtKc/2NdJKvsneeIcNguy00EhYcUEpwEkLdavboeLIDv?=
 =?us-ascii?Q?lZrcihVU/gKK3k3AFz8w2yXBIvNpIIF1Qu2CTWWj0x/p7z7Hnzq4WopldatU?=
 =?us-ascii?Q?Y4Eb8MLPMEbE16UVUPrjtMqmD5RjMS9L+ft+b0qdMxYU01t5x02vCfjEqw+C?=
 =?us-ascii?Q?o1aCtnT5tY0T5Ibuu37WyqzCqE2evAu1PCnqZ26PYQOhlvPu8TP6dCsYDTBa?=
 =?us-ascii?Q?fnuyR0RzaiCQZqEDCFDJWMxl4JeRkQuMe7HLCrM5g0N0/zpiRCaJkcaQj/EV?=
 =?us-ascii?Q?kQ0vnZzcSk+uwtqh/EU02NBmyooSnAuP2qnVvVNRM7cO3HxBhJ6cCT8dOuRv?=
 =?us-ascii?Q?1XPl8wH+20IwRk4cHKS4fBO3WMFgZtvDqMSgHq4g2HXbnasvBWX/M1JdOgO3?=
 =?us-ascii?Q?HYGg9lj2Cnmv0+8d4VRU0iHrIfChsP2IXKow6LRjW5j+3px3YwoLRFPZ6TcM?=
 =?us-ascii?Q?v4iXGAxmGH59Ye0594hPh37HQFR6sTma2EzLBjd7gjOuT7Os0DSLPHQ68fks?=
 =?us-ascii?Q?8FCtuZOVdLnH/yNclS/YAiAb2QlOrnWW0mXE+L93efSqaSm/mJC3tt5aCjFj?=
 =?us-ascii?Q?HtkLNCuNCu9NqM1Qd191AuhCfhX5sMviiUMYmg2f2GkQNXNSx7ukZAh0Zje0?=
 =?us-ascii?Q?KqETpyKJV8Y/BDUN0DaKnAPcUCsr4gOS2XlohppYOo2bgINSRxf+tAIZxspj?=
 =?us-ascii?Q?wrT/1zabpKEEhL/H6TUSdmQBnhuVSPcz36I1WQXXoEoPrp4H2OcKRfOrNC4L?=
 =?us-ascii?Q?YLsJVjUXYZYwfnxc6sRX8CsUYPQ26VUSju4U0L8a9WXJbpm4gz16nhCx+X9V?=
 =?us-ascii?Q?uOln1XBuPyniMRsLs7bD7eCZD+FQ4VNLC3qbM9rnEOlXxJgmRqngC1i0t1P7?=
 =?us-ascii?Q?WG0Eqs3Dq26uuvfA2+qztuZn486S/RZCU1ovMSPrit9AGdztuKrA2T+zVaTC?=
 =?us-ascii?Q?3VlmoOa/G3AmYgVJy4gUgzpB1G5GshklakBll4EIS1J/nc0ZQmCBCaYiUBX/?=
 =?us-ascii?Q?kGJPhAJfDXMD823xl2yWygq+4kJYftU5o8TE4YeGkASe8i2EmeqrGOJow2hv?=
 =?us-ascii?Q?+eestwoKf8rQHBqT6+LHv5JwSxrDehWl+1qG6+Vo3XfXRBmobG5Eabhs3BhB?=
 =?us-ascii?Q?9vdepNSI9Czza6Txe5uXWavsyKK351oFJ8hEFwB+5Vgc8TJf9N8s6gEr1l69?=
 =?us-ascii?Q?qj1NepfLxYdCAWeC1sVPpcmjvyAmOJgI+R4Lwj6SbcHryGrYPFk5cfbu1k9V?=
 =?us-ascii?Q?YvASeqKPPncoxySvikEufgsdTFWZwY45EM/bloBvRY5sZzI3fIGQf7QZUHTc?=
 =?us-ascii?Q?P5rvUNGkWptU62/J5u1MGQLl2kTPnL89zF21alHgYGqZDgCZgCWMzs8OkcKr?=
 =?us-ascii?Q?CRS7Cci2j3HvLY5d0808/B+bPeYW+jblZ9BePL3vv3xMNHz4vNl986PeMMTF?=
 =?us-ascii?Q?TfN3wKnbkMIezK87hpWEkWTsQHd4zIFzGImhLQAOddEwDokLEkJXEuD0Dwo/?=
 =?us-ascii?Q?iZbGXLM/X9O0XcH/fqg7JTPcNNJpnJ4uKDcxh/5B1fnhbrKssKI2mWTcGg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQNEl7kzXnP1zI+MNy4cQdmtY3rvC1FP6TTQpFhjpeV7hPyg8rkZF/lGR2cH?=
 =?us-ascii?Q?LzPBk0zG9+xDFb7P45KhPnWsg7hs8sMJlI+Im0TU1B50KAMGS8Nm2ZUk6cVS?=
 =?us-ascii?Q?fiZcxXUS1Xkt4pw7ZJMhveWYbtbtRc9lHLdYe69mtPdXTr2cTgmPjsJAeBwk?=
 =?us-ascii?Q?+J7Dyet/wtjY9Gkzu97PbuFNb5HeuVoATrvcI+ds6XaXC2LmyEItvjid/bYI?=
 =?us-ascii?Q?k5joMc2z1l0zlGlS1/PP0lPP23HuHlW2LLM44/grSodn9xOi5ddybD4P4l8t?=
 =?us-ascii?Q?DHRXgkqkgszq6fq6B2SGDVjt8DdjMIAg+UtaTLgi7WYLSJNrBW6GUC0AoMjL?=
 =?us-ascii?Q?Di9sDKbXqpON4kS0wC6SncU3HlULwuNQCFmxEq9TajAvuNTXtJepIu6vBTJt?=
 =?us-ascii?Q?pmX1Z0pNbirxagjjcWKJT2osMxMSk2McKPPX7jz4u5y2WUnpimDjMbQ+fUtn?=
 =?us-ascii?Q?8mdj7bCPdSYlJ/sdeGbLF+Sj5f0/xin/Xhh5Ed0YQjiuCd29983Ogp1qb9In?=
 =?us-ascii?Q?KLcWO53qT2e2o61lKJxox5sxGW9Rlpj8OIVDv0CBuUGxGCOzXKpRiBm0ubzj?=
 =?us-ascii?Q?9PB+xu7OW5eNrAZTjAwvn/EzGhI7ZADpzv1+3neRpYbS/D+22O5PXSgv3ox5?=
 =?us-ascii?Q?Bj09myxhiSglhvyG0KWymPAvb3g5y9lnjLqrUOQQqIelo/n5veWnaSGQcYSj?=
 =?us-ascii?Q?8RiNjEyj3A3O7qpgona8WuFAHwE+NcusvLfNBAg0T6aUHGSDsOVWJ4NQMrnf?=
 =?us-ascii?Q?G1ZXOV52sujDgbY1sLJUEa98WmIuzZAg7rqML9cpYg0o3uwKesp3ZbYKkTKG?=
 =?us-ascii?Q?if3eI2dpndw43sBWZ4HUp52unmiwKlzJdHiedGaHLHvHiZLWJyENiTw+yxpe?=
 =?us-ascii?Q?w96QieSCPgG0ToNKYYWjY7PwXTGo5/pHaSgeQ4739Fe2yGrckYzj0Hj4Camx?=
 =?us-ascii?Q?uyYzbDOszbgj9+s4aBxCpUGLH6aXCHfjJaZdN4M89wdtgRgmJZ6Q1eKC2Y46?=
 =?us-ascii?Q?7t2jTeusldDgVZCJxRtC1yyf5bZKCg0h5KhZAe0chbb3zBWUUUICgYs0e2hV?=
 =?us-ascii?Q?sJ4Bf2pf48c+E1Ft6aqKwwdM7wKG5oUgdf5wzABGuXgWQiXuQ0XixlIR2UWn?=
 =?us-ascii?Q?aFJpl0Y+OVEzE/e3lo2EAJdc2dHw1zIx6cdRUEtmYwUWyXfWjlPDcvA7f270?=
 =?us-ascii?Q?WWlskL3KgOND0skkMoIjCOoi9QJlIqzlJ9Z1OLUJOtnOI+RF6YeAWi9KKtYa?=
 =?us-ascii?Q?/CbqhwuPDvvRPjBxPSxVYhdfEB3ZYe0LWVLoQkkI6/5GFLsEsmXf2HM2yAk8?=
 =?us-ascii?Q?V4Al6XTVZWEDNEWO8awDzsrf9cMGnARhVHCDrDCcvhQytKLXC7EjpcZYAQk5?=
 =?us-ascii?Q?/Qy/JrDJwHlp2OvyMMV/Kf/sL9HcqHpJBdh8W+4h9T+r+mTPCFUnvTWEyTqG?=
 =?us-ascii?Q?dhpY7dkoLxKFDTCykxe3TuvuVa0G4QTs5VcMVN7EI6l05Gkh3SqiJXhPuuti?=
 =?us-ascii?Q?9yl49hifqUWtmp++A+KIDXkWGQHe8Ml7FfgVS+T6VB2OjC1d7SvLQVh68Ee1?=
 =?us-ascii?Q?/uSpEw7oJZ/6KgDDsZLvLquncAPSxMrYFW2qxaHKRelKqALtctQRpHNJsn1X?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c9e2ec-e19d-4baf-5e71-08de3219dbb6
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:12:57.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW5/pJ5PjT1bnjxHfUoCxvsDY2oDwwqhfqYESv+dqgUK2cGx6waw4lp6vAHQYNuE2dZi8m32R6IbxyV/5+NAp+LWQ97OT2Uuyl5fwh7tQP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8030
X-Proofpoint-GUID: bMUn9lskt0ZvLuAMXBqcH1EALVv1MlSa
X-Proofpoint-ORIG-GUID: bMUn9lskt0ZvLuAMXBqcH1EALVv1MlSa
X-Authority-Analysis: v=2.4 cv=Urdu9uwB c=1 sm=1 tr=0 ts=692faabb cx=c_pps
 a=Jry067FxzTqLSYox7+vmHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=V6_SfRwt4mKuhsd9XPwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAyMyBTYWx0ZWRfX35rvGtIQKQ5D
 CCjLSe4vG/DAbS/ySQICUG6A2B9mhz4QxKd2G7fBc/t/qVd6Ejit1QLQJ2E5wadTEuuy4mYakYV
 a9IunkaTgj8oGU9Gn5e7C2wFpGAqrtAELqAAEJpM/Qd/W8bDfvYsVVsiAX9Eq46CWJ+PhRfbXkN
 XoTvuJQiAcSflJw2CScX40QlUlUsLSAa1u6EhsPMeLl2HoZ5benC23R+6y212JqQTWBIRe9gc2T
 7/x+Z1e+Wq/xH7fuq8EKa6kov8MM11IIi+BHjFofNdA/Aza8jX488K9C4fB6z++GJ+vvw7EQqwO
 n6TUzHycI2UQIHfVxDmB2qT6u4n+VSWU8jaDkq2LoU4331kZoQpNtDtK1qjsiHSFnoxOe4WAFW3
 uLJX4Pn5JQsLpHjmcfGd6q6zOETp1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Fix Makefile.perf to ensure that bpf skeletons are built with fPIC.

When building with BUILD_BPF_SKEL=1, bpf_skel's was not getting built
with fPIC, seeing compilation failures like:

/usr/bin/ld: /builddir/.../tools/perf/util/bpf_skel/.tmp/bootstrap/main.o:
  relocation R_X86_64_32 against `.rodata.str1.8' can not be used when
  making a PIE object; recompile with -fPIE

Bisected down to 6.18 commit a39516805992 ("tools build: Don't assume
libtracefs-devel is always available").

Fixes: a39516805992 ("tools build: Don't assume libtracefs-devel is always available")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 02f87c49801f..4557c2e89e88 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1211,7 +1211,7 @@ endif
 
 $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
-		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
+		EXTRA_CFLAGS="-fPIC" OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
 # Paths to search for a kernel to generate vmlinux.h from.
 VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
-- 
2.43.0


