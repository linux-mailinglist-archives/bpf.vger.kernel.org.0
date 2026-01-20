Return-Path: <bpf+bounces-79551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E0D3BEC6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF9E4ECC01
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3736215E;
	Tue, 20 Jan 2026 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NH0u2WMm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DMy0b/mg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B0332EAA;
	Tue, 20 Jan 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768886707; cv=fail; b=uUwSq/1nu96WZGE4omrk6EhjN/NkQ270h4RA/BPrHw7JSJ6g393OqGg9mCyyH6wa7AaBuu05k2OTrFChgaGhn+Qos2S3bQln01cOvTa3upuBDq8BTd78CkutdxXF5C1o9ioG7VyLPU/08s7FDIYnoGO+XjTbAFGY4UtTMG6EcGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768886707; c=relaxed/simple;
	bh=eMoxNd4jA2EfSEDONFN48Wjboi+qk8p4V4h/N2bCm4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cOewyFSy130lcMWsWBCpBhwwwVo4GT9VoWJrSgKz+xjBS6rYLed0RYDBGWhnuCUVw79il/cfq7yMun9yS62BNeswFMXYGvoWxucnV18pJR1/pYDouW6HKA7myKYdC1Vgsh2u3hWx4s+Zh/ATQSNHYabLZOM/JTXs0XUbEADydV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NH0u2WMm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DMy0b/mg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K2rNI52544756;
	Tue, 20 Jan 2026 05:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6EnPorl6HGyaG7HqCy
	BbOGhIGYoTvUQ2L06r2rUVwBY=; b=NH0u2WMmdb+xIKtO3Q5ZxFEfSGevEpXsSJ
	/gw5AMm22XRKeR6xhwWUpRE3Vv+Nw96W3/SJMulQoPPn344oVrDjaYPojzH3l2LQ
	OU6ZZnQR+jVAY3GIw1Dqx75locZLRybQqQue/4Mrc5ZOrRxVG6W/WUE/4DtKRN22
	2p9ianTayRJhI3XvU7MDJHc7+3vNHeliDoqPW8cDyd+1NUDZS26eCn8I85ynnIVQ
	erx6LuTUWCBze2t3TqXvnZv202G2SVmGs5hO1cR7v2VehbJoeE5l/fgtwzpUyuI2
	GaLrXO10FN4Hk4WaIpFtiuqwUdQGt2Pg9SPzPrDZWb49CRiHBaqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vu2rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:24:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K46ouf018942;
	Tue, 20 Jan 2026 05:24:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bsyrpx70y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIEy6k0DS1egF2/y/Njk9U+bs2v7MdwJweULHm52qygK3TIM0ZxD8KZmQWtdxKsDmSfT5qOn/A4xTyenLSVmayPb3XYKvlLMqY9ApfThPLpbLDGXZXswwhvo/DeyZ2bTJjIolX+NoLELNzLpGNvkkIVtP+Q2nRtYNpR8V6GjTAESXn5KqkimxH7IrsGVHSS3yaBUxfuwyj8duGZBkDnwn02ilmkzx2ygl/pRyL3ORNLqHLsAK1s9ZeOqVW/gCcxOnALjFcOz5YEiXpX1viUaHoQscBEErzIKXJhqb8lch7B23qaWznjdtoHMUofoeZYzsXJrUyl2Ibz9Rkbp5obhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EnPorl6HGyaG7HqCyBbOGhIGYoTvUQ2L06r2rUVwBY=;
 b=jjUmt7KgvVUD8y+QzUALNXYXSHZVQuo3tdTSx3+xd4kgax7DBAJYrXqaksv5vFGegUd2gafHH8zMIo2fHgGrKJmo7qOUTs8LcL7KTPnc+4HBj8mX4bGxMhMNyYrwkRruYneYj+58E2MFcN50HThe7rxVA3DPaIYHS4bLZ9VeraUqTMgw3ynpHWHY4G8qnCBzDk02U/kn5+ADiMsxTg6lNpIKNNUhCVnmg4pLrxqJqvx4Gho0TSkrPU/8kut0ao4/uvj9+cFb0jE5T8rcQqlvYvc6a3YJeYJMZ8HMSXveVPsJJZsx4AE5GGos3ObVt+DoWuryl4DwUWcqn0LePBjGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EnPorl6HGyaG7HqCyBbOGhIGYoTvUQ2L06r2rUVwBY=;
 b=DMy0b/mgtRfyCSQeQ3wWdaHN+mEJDkLjjPq1m2ho8IFntuBAH0L8jS3YKVGT0sQylu+79L611/ItWW6cSaYbYn5bYQviXyBC1JjHCeahVuV1QpKXZxXDuyPlyD8+aycXdbLdEHJ+bmklWbyjns5rdsnfPXwTuxMa9gRu8IWCKhY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6034.namprd10.prod.outlook.com (2603:10b6:510:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 05:24:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 05:24:26 +0000
Date: Tue, 20 Jan 2026 14:24:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
Message-ID: <aW8Rg9P-AZMQFlPL@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
X-ClientProxiedBy: SEWP216CA0041.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 213ab388-7b89-4ee0-bc6d-08de57e42dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+iAxAiZC37p3e1wi8sbd8sysCJBF1kGU1o1MGxrRugmqMP//NBcQr45stLT?=
 =?us-ascii?Q?4/jTsbxMnQ+bQCkquqRffwGVD5eA6Vr8qoYJH0I6/HuMnGVP1pJZXMuRAo99?=
 =?us-ascii?Q?z47FfW3vU9q9cGoOxQz0tSZz+Ov7VsKErRzVYKZ1BEuQeC6kWRU/RqTQE95+?=
 =?us-ascii?Q?OA1596HCs6qTL/A3l1VXdQE8/LxmFLimZkESTXUOaU+hfsuYBJLCCq9NVpDl?=
 =?us-ascii?Q?/q/uJQSEpOKgwHNXDux4bnFf50j2Mm1imgtZ586eWu/RsMwjLEir9BL5leq+?=
 =?us-ascii?Q?pZ9SiYDqOXHzT7EMGYOQOB64+f0CDoI3NCwKdCeoVhikRZnnCNOrws6DT8Fx?=
 =?us-ascii?Q?gKkEwprv1KpVL7Aj/ylvHiqDLVfSUnSZ/QHC1xLuoTeQo5xBbM4k5EWmnlui?=
 =?us-ascii?Q?DW3ozkgDAPVHUxglarS4Jxw8RezSAhpekFXsHITcdQb3yKeTBWwYtwYiphOI?=
 =?us-ascii?Q?a0q5/7stTC1v7VU4TLDqKYFJIo3Ht9zPpdzwrPc74uOoiast9i+/eOa0lK6N?=
 =?us-ascii?Q?bX+woBCFzYD84GaLbplxFYBJGkx/Qsjq3OMY2Rvm0aTN33rMJCqti2+l5Mg2?=
 =?us-ascii?Q?M2T9zTfNtHX7IEX07oTW+TbRH6Y/KHE34LB/WLwhiJ2A9FMRniXPletrR7Mz?=
 =?us-ascii?Q?9KeVbRto0ZckDuE1T/pljjCBzPO9F5nd3QiOR3Hv/YMIrqDalP8HHKLjRXfE?=
 =?us-ascii?Q?+uGb83brOypTz3ZT8S37wfCuXy+lOA8T6u3rLtxxAAo2a4+sWSupAh4+mP/X?=
 =?us-ascii?Q?gczdITNVFyEj149+ErQvOc41ro2CRxfXuPC78/e7KsvWcPRioe/lBnJp0rA2?=
 =?us-ascii?Q?wvtJepIvBHhwIAfHrssOrLqRuka+Wo7GwfeVq7nKvCaoBJolFvcHkIfjYE2s?=
 =?us-ascii?Q?2nL7VT4+ueH/fx0fbWd05RZdatrJxrJgetfA/nc4IoYkOK1j5PoW3BYcFeqf?=
 =?us-ascii?Q?aebs8L+kNuo4h38dj7aXLBZlaBFXNmD3yA68b8ucVYsRHrlyFUHzoHlWaTEb?=
 =?us-ascii?Q?ppIRhXeHOSe5yn61LcczZyIPXRyi1CsN6kigRA1GCHEa9ZtLzTAZTMQR+z09?=
 =?us-ascii?Q?tV0TTHoOvHyG96HFIoO8ObHT18HdU8M772jUXgp98mAdWs4iIV3+EHjhtzuN?=
 =?us-ascii?Q?sW0eq8HVI3qWATnRENEgsze1LKndnLbq8cl8UeSTWQQMsG3IXimYorDFBsRX?=
 =?us-ascii?Q?qLVX2K24PSrdozf4NZviElSV3iwOICKXO6M8MI+6GEY3TZ+UGaNsFxjtXyo2?=
 =?us-ascii?Q?kughj3CoO5QXCgDahsRHYjOtE2XfMNDDDgYH4g1MN7jPupunm5uTfs9gsIOZ?=
 =?us-ascii?Q?6J+4w8E4KeMfVrZVZt5vcSWHwUoC4KmKnnnciGDPEz9Kv4jbsCvommJr/p8V?=
 =?us-ascii?Q?gf9WvRnDZT4Fk01BcBDjzC0ccjlfs1EqI0X1PTxkSwj+dDdKbiA8cXjlnmNT?=
 =?us-ascii?Q?v6gTzhQzjk7UI4WjbHTG5vnjA3neubmZ0q3rNFr+cK9/xAVl4hxg0d1baOfv?=
 =?us-ascii?Q?AhvJJQiV7D8LmlXtc8mE8aU6tXogfkL3G2R4bvJsOm9AHZ9oZum4C44KWPgs?=
 =?us-ascii?Q?ea25QHnbAsobUlS1eHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7nP8l+D4W8c66+SlReLRSTXP+FSoKM1kbB1US6aneGW1XiF+1ldY4MmV35E?=
 =?us-ascii?Q?IAFRR1aUNXJLl39IPttTv8drOHEbPriN6td4UIBi6i0wuleNKWfZU6gb4s63?=
 =?us-ascii?Q?9lR9gSZdVIF7E70yWRd8iwcnceUAr5ZUU7DhcwYnYuAQ5pItGM62YUtSCOzx?=
 =?us-ascii?Q?a3eZ3wmTLfi5263PkAtnj3VGfGrDxNK2qkAGpkovbpv8EpqWv9Jw7KsZHY+z?=
 =?us-ascii?Q?jzdBPrjfcvX6x+Pg9zbI28G+sHH8h8nZ9AzyPnuX8uSJtXGGq/DVEogD2NA5?=
 =?us-ascii?Q?ta/j1zk62dc7Hv28mODLwO2TmbVUuCo4m9hXrIfoF+LupnBL1j4jY5Bi6lGD?=
 =?us-ascii?Q?j8foN36Uz35UJVEYol9YpWf5Q1GpqNE10OqUdUk4qwL2Da1A5bnifs8HDQ2i?=
 =?us-ascii?Q?SEoA7oySl0EfuWv18KyGuwL8VLGxC/7lZN+GI5AG7WlzzumpLF/Lpeq93qWn?=
 =?us-ascii?Q?YJAltFHZmB48R6LlMLONE9miKT+8wQZKFiSqbCwYjQbIAHSjkbAflOO57Kic?=
 =?us-ascii?Q?C/C+kK7p3NKUOhuQe2SYWr5POM0i+aBJd43LMdKd7N4HhNNVWnZe3+EmzdrU?=
 =?us-ascii?Q?MA4nDIAqpy11lpzgrC8PRJMVCvjRiBHcB9w5e5eX7lCoEOaxOA66Wpxun6Wf?=
 =?us-ascii?Q?Rt7Yp5CncFhs8b3vFPzCfwyf+AarGffOruLHIcELtbBe5tmimJzONP8q3WDt?=
 =?us-ascii?Q?xBCcKET5Cgtw/01IWhpWNJeQup9AoKfz1jwLzsqqWJwU2V49rmOexnv2E99t?=
 =?us-ascii?Q?B+W56d0GaoCEaBVvb/72q49H89PhFBTBLGBDp5pAh8k6myp7NoqxjEz3TdvF?=
 =?us-ascii?Q?aVMhcThtKr9Hwm5X+ID4gQPvZSUw9hcbINbtyVAEFAHbZdtxCWkey6fTtPKV?=
 =?us-ascii?Q?bepCZ3fw496Wgw6E5qeuaCN8JIJHUyw/y0q0Gq+HaB1Vx7p1xcr80Qw7ImM9?=
 =?us-ascii?Q?fm3vWUAaqjfOLJGoa01E6OSHthVlWOskxN9damorZIJ+XeSbXBt5WFEyrw2Z?=
 =?us-ascii?Q?XfYIdlyDePbqPLmj4BRxYh8VIfF9XcUq9GL20YNWoVMXcHql9BP8vz77P7hC?=
 =?us-ascii?Q?LOcCjOlPIWtfI9oVEpYW0DYdRDsC7/Ioy4qiJryS2U3Ra4ZP9cBxmvtW2cG+?=
 =?us-ascii?Q?MZmLhyRFVrvvOFEmXWzFOw1h+luVwf3awyQEM+/VmcuZ43CbSMSWhYUbqXr6?=
 =?us-ascii?Q?qquAwxyInQsV8ptE9D4qhSpUppn0DVlspFgtYWrqnRASa21TkLdVrLZaHRxI?=
 =?us-ascii?Q?0bJz+pJkKnXk2gn28qNjXT9XW3v7xc5fAUkeLIUckUTlCorwtXkfCwRuuQc/?=
 =?us-ascii?Q?5A4kr5uh6o9q72lGb+fai+M3MyXf7Zo9QGI8u1ObjKFcNe79U8x3a9MAjCrE?=
 =?us-ascii?Q?X/1ffI9rJtW1O2lJpBWrCk2CoP8P3psuOm1fCkdAnE6YK5MiPPPhu9/4jjmL?=
 =?us-ascii?Q?RAQDM/Fxc7wZT+K1xwARIiF2FJY1Mlv8H/UFs88M6uvWH0GZwkpW/dBMTX2b?=
 =?us-ascii?Q?3mnWJbmtE+pC1ibo143CGERSrC/dpIwyqHmpo6UcyjsjRBCEpyQPUE8sDycO?=
 =?us-ascii?Q?pzW5Ww/L8E9Cv+SYUOgSmtgLUJFjnhF/PclY6vjc+0bc/BBF8Ya0/ManC3ae?=
 =?us-ascii?Q?P8R0SuZD6AfVG695kDX02fEbxcZWAr7whMuDH//cVN1LutNerdkEdJRjkBLd?=
 =?us-ascii?Q?MRBxUoUl03/Ii9AMhvEr/Vq0ZYLv5RJPV1nvsjtJJop9NUWnfmmmOnM52c89?=
 =?us-ascii?Q?1Yvwbo9ZDg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1HWMSPO3krsM0wLQpaxT09QRQ9mYAylUkLKHuezUyLKpchFnGVQq1qIFuAooeCRPAshSmjDbqCE71UxS4LzycNgiqMSxOg6/xVnrFsOJCf9UjwXKLqsYWhVHtpBe2nf1i345xtV4flQCjtqtHN05EJJB7bo803ESW3AUXBWlS7VBzqe0Zv13FXGF1U3JF6mWBdeExW8UutfPTJnTdD7fh3lEvnPhOmeC6c1xSlRZLoAAy6hChZrafzG7P8seP/2tT7hdFoKuEubaDuW/bwD2EfC1zC8DZPMI840UoPUa1Wx5y8wNSJS8mXajbgLJSCiKWwwnRRyZ8TtFQ41Wi/Ukv2z/NqLyhy5lJbI9MuOL96kjaqryGcXF9pJ1CUzXbp/DEBjACzmS4w34i60qtUGHqpR0/w7my8OVQKJZHbZAphkFB/prUQ5McKkzg9bBJY3coKjeMwajeFb8qJ1sLS7Bl98xZ8j1GhCT/U5plW/+KhkHpHKWBUGzRAkO7LaP3sI52Tt0J+SVjftN0ZMToQy50JDGzCaehWXXkGWB5IERlk2YENGZ0etYNAH287F985APZarFHj9MoPM1WmoLdxlay5avgToSUTTrG8mRoXReSuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ab388-7b89-4ee0-bc6d-08de57e42dbb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:24:26.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqJ0JTDRUsJ+n8k/ntIF+3mesjnZIBbAltTMC/A24yinSiOr0r9AUtxwCfoVKnmwoQ3eA3bO5YYZX+0u++s0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601200042
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696f1190 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=cpnumEgXthh3se158sQA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12110
X-Proofpoint-GUID: GDcBSv0JIsOMjcOadIZOBUWY0UDWwJyB
X-Proofpoint-ORIG-GUID: GDcBSv0JIsOMjcOadIZOBUWY0UDWwJyB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA0MiBTYWx0ZWRfX1tYq2y0n4H9H
 zjIwCpUucw/+3Zt2wVfJn5lyJzffg0uWBjdA5o9sKBOIV7pVuF4IBX9vqTeaU2o4H1nt6m7+tgh
 IFWqFkjKgaqVUnC4Nn3MMZFfpF2UpGT9Q7RTv3wyTH5xjp4ULgOOKUAHGJVid9agzgqoZxt7wsE
 Fb+gPG14KZ3wLAMRw6BU9zrz5Tsv8lpB2fX3UvkA8hKP5GIcr4GmVmQASxUCrUFF/emugNfQZFO
 uLuXMKjJ9/0+NPueho9orzX664+XuYZsJzewJBc+xJK5kAXMXw7/X4l+ImtbmTqcwXxZFSZXvvs
 iSIcHoCsBbnxW3x/AWxZEYpP1rHETEZgDAqMr1UlwtNyoBggU2jfZacXUsw61/2a4id29jMoCeU
 +J4efXVaL8xRKJ++EvV0KvVUySn6qT/ny1PweQFPBMVdbd+wdQ/viZz2SVDzGyrktzn19yC+sAh
 o4ZAgxhdj+LlnqUd3cuOTCrzjbp+iekxqYhZa9E8=

On Fri, Jan 16, 2026 at 03:40:31PM +0100, Vlastimil Babka wrote:
> We have removed the partial slab usage from allocation paths. Now remove
> the whole config option and associated code.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

