Return-Path: <bpf+bounces-79417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6642D39D38
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 793BF30021DE
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A33043A2;
	Mon, 19 Jan 2026 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqyMU4lS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bEmtkisW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E162EB87E;
	Mon, 19 Jan 2026 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768794187; cv=fail; b=luZkRF0qnLDiHhE9kicRBGBLJFa+6VYycv0IGNKzvzxVg57qLczpA8g9RFIchej3gNtR2C878M2Hi1rDiTukZND9Q5oLhHbFIiucO/TO70D2sfI0MtZB0ahvjhM12hKcvvYcSvmevCAPURQxclFOmfEBLwC8S4ekQ6r3oJEfvtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768794187; c=relaxed/simple;
	bh=m7IvDSYxus1OxUdrGLppg94Wyx0Q4s8nQgCIegiQMJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E3bGcXBghFVdDKsUKe36skRVuDq+VR/qPUyMAYlm6GXq0bygIRsI4Z/GPIusGH7RhJGZlZeD0E4Zh8tWCHNlkhR5SXDYyf9tCX5u9Ta0s2gVHPgi9lymyOLasac9ELAifDS29ligzE+h/UTAKTNVkAcaavhOq9u7G2d2yr4vNqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MqyMU4lS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bEmtkisW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J1r2gK1183545;
	Mon, 19 Jan 2026 03:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/Qj3Yk8fgFeedntqP/
	d9uo+z8NvlNFkBmhmvZ4ONtsU=; b=MqyMU4lSBN1Lu5P4cXr4SCFImMP0kvYrzZ
	yw3+XFkUa5L6FHvz2roQJVA08ZbqgOL+BlvVhTf44s6Wk1DjDtTtBH3MeOt77TE5
	VI4HYt2l2BRzr0keGhcAOk+A99hTPMTUxG64DXEchbU39k26SKR18q/Hu4Kv0Pkv
	hqkQ+eU0dar+brJqJD2heCf2YTryJsCaQWDcJv3Pr9SepnDVWMEBIwC8EJjuGcGP
	NA2pifP4m8n0mD2zb8uvex2rIjpdMCMtQyOd/JfKTC3JDX7B0Jf0dC5v2uYFSnNB
	VrcwFF/NARvm+RzmuHiAD1+ZcA8dGuqxE7FcGxB8cCH5yzv6jJvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa1p21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 03:42:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J1l53T008406;
	Mon, 19 Jan 2026 03:42:09 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v7uq0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 03:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsfGQwk17qz7bpBiQB30IIJ15xYt2fi0ietT9BNd/YIMcVYkJ8dGJ00oundSy5188SDy+3w8jlptSXLifNHgAn4vX3n9mlJnJlpzJop0pTOthc/0A++6GGZHqlmVAaOsQ7HTJV3ochVPm2ogPZOiyyujevWz/YzJoi6kXiidOdrPtpQlvHPs+tSV1TbL6MG2rK7Vrnez9IutiFdkCP9sTS/T3jjYDSdyWnPdXocKEDxwxDQJPbYc5Y76goGxy5rP7IhRQB4L7KgN3EjX8fYANokUc125bJs8lB5jz4GvaQZOXJzZDftiYIEQiAGVO1Xll41fN7snDVy6mKJb2FmHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qj3Yk8fgFeedntqP/d9uo+z8NvlNFkBmhmvZ4ONtsU=;
 b=tzgqmfsER/bsoLO2VvAFO32AyGjrH+e06OPRpnmg6rgltwuhCpL5Bix5vWK8QNdsnbWVh+xVLomaaCakw6j4v2wR59nAnydEWrq15So42CB9XdtDjcfSTY4KUkOUXgg7UxL1HLsirSPT6TpYkHU+zC26H7igEH39P1+ke6MGf+BKyhUa//9hBMi3jVS61G6h7cE0TGfhUBVTQsxIqkrRuPPF1ooH1l57OzeRMpegkwEQBPYVwB1j0nZuDWAShMJSChS9k4/3V/1QVkj1oj23ruKyNPiXZS3W00T7SNFg43FfCC9WeSLyG5Nf8M+q+mOWW079He7vLfJhYWXwRsxIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qj3Yk8fgFeedntqP/d9uo+z8NvlNFkBmhmvZ4ONtsU=;
 b=bEmtkisWWhw1gtWmFrYKpKwjLtfa+yJp4+1hoEQkV4RTrbjaUVeUX0Bo6i9rXQrD1tMouBaQa51UwbGpFIYG4PLtsukCxLMKsMmndr/yTv4u0TgmdfSk3Pbn55FI5HofA6/Z7xTC5r4cs8gOdXi6A6TeAFZcW/Va+7fv8FBCZ+4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6635.namprd10.prod.outlook.com (2603:10b6:930:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 03:42:02 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 03:42:02 +0000
Date: Mon, 19 Jan 2026 12:41:55 +0900
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
Subject: Re: [PATCH v3 02/21] slab: add SLAB_CONSISTENCY_CHECKS to
 SLAB_NEVER_MERGE
Message-ID: <aW2oA98AZYY_gC5t@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
X-ClientProxiedBy: SE2P216CA0148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 1061569f-3839-4331-abd9-08de570cb510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYBvZPKQx2vHCQUGdXttLkrFvkarw1FdtjjwwKFStOsNnsjvFVPhjVAM0fYm?=
 =?us-ascii?Q?t9vSKSNckHsJVJIxfR1aDDoB0zkJFyD0q07bk+2bTJ6XslSbM6F622jL+z1y?=
 =?us-ascii?Q?IV+xDBl7ryLvStntBcP7/hsZg8g6LbgAbUXLOecNYHarzfAb4cRqkNqeLNhY?=
 =?us-ascii?Q?Ck+VHq39wiH8G75xlMshxZMINXHp7XDtHByNmd41UNCI0CYb767+xQES8Z5h?=
 =?us-ascii?Q?fdBJWL0X523ZG6tnfFTLM4Q/CSXBpKMUucIYNP/IlPyPE3ZCPMwx9cRqMh6k?=
 =?us-ascii?Q?xkFSyTCYDRboXD3rQ7UBrgxP46/La4XYlssV9a/qRc/zg9jeC2S+y7/gtDk2?=
 =?us-ascii?Q?xJyuM1QEs6X+oz9zgykSfTKJ8aSei2IZh3OepCbCWJxZoFy0sIcKISipNoYD?=
 =?us-ascii?Q?F76afZTmRIo+GmkcbFop24Rn/G3fotFeDLgEfaGUNiww4dwlAB4ZbUtTtIuH?=
 =?us-ascii?Q?DYd1whFAesKWOkF3KpPqAO13xIAbdtUdTYFwQHX/RQwbsWtFm2fkGsPr/ZYO?=
 =?us-ascii?Q?6PVxkbBVSRnicSvHZmj3AIe2Vewd3BeIdmOhMY95AMQA9gSKolB02sdoVWhK?=
 =?us-ascii?Q?FZdT5QhYxoXyf8LHZsNknMBKR1eHGRRZIQ7dg7zjWRafd2BXa55h0Jqo6fil?=
 =?us-ascii?Q?epUS3ST+/UjpP5J5tfOyXnfE+UemX665yUqhpsibeK769c4kNfGtrZ5lnwWj?=
 =?us-ascii?Q?RzAWoqZbW+mA7O2B38pCifdV74wiJ6aBDreb/KYZxWVSgH0cjisbcQK8L5zT?=
 =?us-ascii?Q?QBKhH7X0qoMJ+WdgRyP6vaqRNGBm1jfl4NKZsnjGpHvhbGnZKiTaxYk0Eg2g?=
 =?us-ascii?Q?9O2DWCyusKuyD/JNNrYK/8AIGIkrYk4CvOlC3E1WjkdVZ6VqsYOi/y7hJg09?=
 =?us-ascii?Q?ZouADQXzPzGL060hns/AJ8fcKzKFyftivZFiCUNv9XGVN/cXiSWF2FKM+inj?=
 =?us-ascii?Q?p+3NMMBPY/VnFc/GWzmIHhZSeUo5pg1HlpW9Fe4cuToqRr7xycnMF6i9jACR?=
 =?us-ascii?Q?UCar9nnJcqrTARPI63YZw1GmggDQEWhCr/1jR2l5sXGaaGQ+YgQISSybrUr0?=
 =?us-ascii?Q?st4vx5kYiIj+JwW2r+6H7Keo74p3SCB2SxhyvZxHXo5wwhNePxBSL4Hp4i/i?=
 =?us-ascii?Q?BNcUBl1RtWU7o0EggQ8ZkNKhSLym4nZxHC5UKFnK2IWtbf+/04SGajI6cMFU?=
 =?us-ascii?Q?V2Q6RNC3BeOZJ6b/fkkxdPfEJGQ2CA5G17slmyMTez7LK+KCOlcPjJ3xJX6g?=
 =?us-ascii?Q?NLFdmBdbjqKvSUt1+jcRwCjXsrS5o/vNIj7rR/0qQgyqgvxtgoQJQZfmJeGk?=
 =?us-ascii?Q?Ufvy7vnc5upZeOr7pIu3LHqIv8Ru2LV94j20GHHuQKwr2jKEoCnrwNk/Efbf?=
 =?us-ascii?Q?5nIjoA1MjoU0ukB/nbMqPaMIcMFn5+HzTfbvfD/8zl33V+Ra1Pg9VtE7/tK+?=
 =?us-ascii?Q?1hGUIujyV4U8941qM0+P4YB0lb/zx/hEIGQiiVLyLlwjNghGoSs4H9T3I+Ix?=
 =?us-ascii?Q?CsxAypCv0ejq+Zo95RgDhOhJkEzqcTUwmI2LPWmxScYsQlV1iLQxfLzkv9B0?=
 =?us-ascii?Q?DxLJng81QHj55eOEev0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYJ9VdfDw36x7yymmhtO2/eMVYJJKp2R6LUpTmOA2j2aZHpmRFrYATySkh9+?=
 =?us-ascii?Q?4mZ8QGR+6YM3rt43Gxrv10S6iVzl/kOB11DJeXryKQ+LZNlS1AyTZFCji4LO?=
 =?us-ascii?Q?S4eUiQmo/ZjGgV1T6CTujL1nJLwl6zTHZUPSaIvh+gP7En9gm4ehboLMPT6y?=
 =?us-ascii?Q?VfoCB6w4aYjZe1ye6Cc6wROQfUXlwSoTRD+0Q9Bjg9oJxe6cX6MykZFjTQKC?=
 =?us-ascii?Q?XVS6w49FnTIicPjZoZUgtXxcDVsAiubxRwq0HvISja5uuOknwTPzdgLHEfDK?=
 =?us-ascii?Q?RXZ0c4PO+rtNWa3qYmGSHFA8iJetllgbd0ky2QqTLYsbigTUZJyexkPOMIKI?=
 =?us-ascii?Q?R1TtoAwgacrWe1H5yFsEbBjh5EYDSUbiO40yQRqrBI8P/J57qxLB1U/FfjF5?=
 =?us-ascii?Q?EK3A3kRrH46yys+hLCCkx7q6ucXpBz7HQHk8jbMHsztjAIcsuWPNlYGk7vlI?=
 =?us-ascii?Q?msK7/Hy+6YR7vRTRHpfACKTqYughLIjr4X9O/1ghIARJL2nkExGamF7bQyik?=
 =?us-ascii?Q?011U+nWy+x/FDK79xskg91whr3T+GDwoaJuVYe4qqDiqKs2ywGbKc4q4KXzk?=
 =?us-ascii?Q?RVrGHlnL5S1Zr+32Xrd194HHCMrKxiFeCAtx8KJnW3A/HAbSTTWN96RDSyq4?=
 =?us-ascii?Q?lNN7KCJA//IuO76O0McCZU6PNR6BK0XliDyCH4gEgZVCdi1+6m/B4KOKvk4k?=
 =?us-ascii?Q?YFYFbSUckhMLU9L5wxHjb/k6UrObwXxtimFZx18UJf39mLVSly06tqy14SC5?=
 =?us-ascii?Q?asFamQbDBCdUIPOh9lxIyxF/VcIp4HrE6o+znSwh367ZGYA2AGT8hETvOUmu?=
 =?us-ascii?Q?p5z23idiS0WhpV1l7WvuP4bSWPoDGYcCkfys2rh97mT10TWRZ01nIuVBDwrX?=
 =?us-ascii?Q?6qtkrO3+J2V0Hk77j9tpAx+kAvOllPVMDjEYsDgCjsqMN9T4Lj8GdpILyY7K?=
 =?us-ascii?Q?rMXqRe81MCarKfP7S6M4DmqVTkZpbOGfPhcQELq0N/TSGpZ0VNeU3G17PdG/?=
 =?us-ascii?Q?gih8JUem/WAIdhdlSWezW6OO/BtaALLUEeQWfvQf5sv7+L2j8ZEIjWY2U8u/?=
 =?us-ascii?Q?EHifj1tBsq0VEpQKr/qqpigW9BgYeNdtpNHuj0pNXx4DW4c20gjTZhG84y60?=
 =?us-ascii?Q?5P9KuIcFg8CMKP1TlBmAYKs68nb22z8JquLZWC8bMQxhzd3Y0Jwcz/oWEq5N?=
 =?us-ascii?Q?UanW/O1M2Zm6xp+zLVo38ppfqr61ScUJFpO9W5aaM3jzhdgtdlawln5KE7Y2?=
 =?us-ascii?Q?E8gZTQDHeXGTX0KcosRcOzxxOJrPPBwP9t70nW92sqcr2MVyA5pxvjnmF7zZ?=
 =?us-ascii?Q?nXXGGQfwqEAPlWy2Md30joVw+kxG7rmYbhtFEHDLZBlv8sGwvImn8ctwSYGS?=
 =?us-ascii?Q?8XJTroz1dJZQdQGe7pq3oZ4mXw539gSkh+KZ3JuU0iivvRc3i5NAseJFBlOx?=
 =?us-ascii?Q?rvEX0cU47U6x3Neqc27OLHPSXSy2HSc19lQkZIxYInytWDftpK2DgbcMiXbF?=
 =?us-ascii?Q?WmR4Veu/pEfUxDrzXDrHqf50ll1MjeqbPujuL5lAdR7o43DeSaWXEpiLEHRF?=
 =?us-ascii?Q?gC6I6UKBdbvc8aX7QlwH8KLmA3NXnSDSk/zg3gLKg/WQEEGhFMXjKCTewPQJ?=
 =?us-ascii?Q?bvKQ9qinMFWS4ILfNZOEAKCL8seotu/lLWYjrigZGfm9U3nFjfbTNeNdLLuL?=
 =?us-ascii?Q?R86L9BaqTQ/ti7q0jE+yAZsRNz1mxWSfIyozRvZQtvDOUe7AO2Pzi/JzWJ9K?=
 =?us-ascii?Q?/sO9YLqGwg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mOvGbcjULls64Asot4oIg/jirIPVzr2b964RvVZZ6XgyaL0i93XAKCm6fmhkcOCaSB2VGbPT9S25iBP6hAc5pfCG3r+Hfz2L0NvC6Gs1jJp61/oQEJGYUtz5hgUVeocBVfLdbl55P/vsN7SIw+FNGtAhbaQHES8o6mCBJP/R9qe18n+qvSbrlAxecDtH1X60QCU6bn790AHKMGALl0Bie+PI6WsjB8dh6B3KETn0py73Q+owt5AbtQLjHPxbRpkvOCR3ThO3Vum93B2BUN8FZAWu6ze6EbLwAcU+GGR3uF0Ox1cn7JPia27FACl92fHfin2WIVUs0Ly6VLZDy0FlnsmcJelh5fdFueTL+L7eZTDISdfBzIL+nU3tCM8KfWoZ+bq27gad56LNDGGJbjJ7eNZA+6vx7eRgF8IQC2u2HKyo4F3t+we9G8nif2PPUawpGeVJVgzMs/v5wv/BRS3QUC6UzHGWTsEZuZnTrM39nIpCPPBBHnTtK8esESSOv6usA24dnzyiZvEN1b4TwB0g+DRF4hloF9DdbTsJHmzj88zgHJ7cPIRJrd+iPE+WxCwdrInNuUC9y+FDUrWlRy9phIH6UTpok6wS3r0+ivpjYms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1061569f-3839-4331-abd9-08de570cb510
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 03:42:02.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+F9i9LvWb8GR9dpo3D3keCepg5x0n/e+uHevhrqe9JCitYIGOvcuxb4tVLzRXuDbgKc4fncgVaajUex5VAGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAyOSBTYWx0ZWRfX3iyTB72kw4Qz
 P+OwNINAfw0VprI+RBrtmxtk9I8ld8ah6Lfwo6+KQMvx8YC7ZRI3Zlz1J+2T3BcwWzRb1MS83km
 v9gE7D0xp234WE0I1pmrIYTkIjkuxdj5ZIPY56K9Vmd1FInid9HDC0O4nGSjG0rglq2xDII+/VD
 36ccez6jFnA+7No8bfHQcOkc3HB63b/uT+8XnALye6i+5Tp6GFO1eW6LCmzDCgPYGVob25/B9M0
 m+7vR45Dczb/GfbpJ/jYoHuJRXpuwS9P5rymPzk390Z7BnjH7fu5ZyIKwDuSD/FqZS1rj4yJ/GH
 uY7MuqTaT63yOsOCbDfmTbMYcRKVq7M4trZ0SySbDDCY9PQx+z2LmmaN6tzDZUhBdP0UGWN8lox
 LeSGUXW5UZ9UPY9ooe5Jy0SD0fyxo5OTVNwuPkPzyxJlh5MTnVP6VjiqncQYSasuFiaTIKS6Fc1
 +yE9RHGxzbMdpEuvjuQ==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696da812 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=tsyjUIWJt81gzSTrp9sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: aLLo0fiRRvIitoO7PrtvpRkolNi29Fkk
X-Proofpoint-GUID: aLLo0fiRRvIitoO7PrtvpRkolNi29Fkk

On Fri, Jan 16, 2026 at 03:40:22PM +0100, Vlastimil Babka wrote:
> All the debug flags prevent merging, except SLAB_CONSISTENCY_CHECKS. This
> is suboptimal because this flag (like any debug flags) prevents the
> usage of any fastpaths, and thus affect performance of any aliased
> cache. Also the objects from an aliased cache than the one specified for
> debugging could also interfere with the debugging efforts.
> 
> Fix this by adding the whole SLAB_DEBUG_FLAGS collection to
> SLAB_NEVER_MERGE instead of individual debug flags, so it now also
> includes SLAB_CONSISTENCY_CHECKS.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

