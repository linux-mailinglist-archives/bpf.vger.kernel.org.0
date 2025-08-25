Return-Path: <bpf+bounces-66382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0182B3359B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 06:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DB188A0D7
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66491D5ABF;
	Mon, 25 Aug 2025 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9jwaRiX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QwRWFdBP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A872627
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097277; cv=fail; b=VvtTAnyImxQ5gHoHYBYvKGCtLqtt0YA8cNxKwJ0tHM3esg7Tfntg5XBX9Wc6GOty7/QhMCNdISZw5cksqcjsWKeoZey6IWZ5X3AtpXvNVcfJMUy6tFx86SBUw7f4+Pywt6CqJMJFBVE1HepWBDXxK6UoR8Tx5LwzGnECrg3fRL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097277; c=relaxed/simple;
	bh=VmhC+LENfFXUG/z29Zw2+frw48TiehZRTziatgBcul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iu8F3Vcas75/YFoq23devOuT5H3kp8zRwzRwyp2LoQM0UyczTLmQhk2qYrXnLFsw1JVMedpTWfz5fVTxN6hvM/CuvKuOw1vQFYc0tk2eM7RjfeRJhVPYMJiIQCI19Fs4ub+3PQllNjXb0WatJKPoCLGfi29Rva5gHuNnzjIwAbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9jwaRiX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QwRWFdBP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P1tkLm023654;
	Mon, 25 Aug 2025 04:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8MuIKRJ32n0XExdNZw
	h5PeSwz4CM4OxRNISCL4mhjMo=; b=T9jwaRiX12bEC2O2zuJQcb/nJJgUB2U06t
	Lz+tb76pD/AXKr6whkLbZZDWgxAlqNTPjUkz+rkmWIb/yBmB7pAwJejMVkBE1elw
	vcaz3Dcnh+AC46/yKdIMtHiJ/yf/Cwnxx6z2gV3phRpHOJGRhrHUtXNO3vixZu3h
	4fZHbcspv6PAXZO4cTdvmlBPfuQL33M/x7K5149qpGx4uW11wLVl1M6z6gulJSvP
	unGrft5lKru+K9BnmZb5ljB8+z2BGEOvxXEnJHgmpbdH8WryqqARvQLkbf/Qij2q
	7keJckFr9RBESRWKH3stuz0oO65MC8CSdvkspqtfupOjDuRAm1aw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt1hf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 04:46:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57P3hH2e012169;
	Mon, 25 Aug 2025 04:45:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q437q1b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 04:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0DaQCMnlfe0S206bSwtFXhqnl50rENZeufiws1uk5okM0gTS9aw03KEFE/rckiKWK3a2VcskLJuifAmzAEzkpt3ZgHIjGAcgCYmyx8TNRzFlR0jIprUa9OJ3lI5gWjiKoMonYDz9Fb2Fa5pepOys78G5xyAnM923uWUwWm90g8c84+FL3cTg99m0lnRiq5lJgOzWm158mghWQCc2fR2PAyv/HU3BfGLG4K1mKQUraO2olP+knc4w0CIuLQ9iNa2+ZxykFvclTaXEkYMhFBr4N1VGcX5CV+DzUjE4/sm1Mh/P5HgRjYu08cSEZiDbycvqoGRyu64w311c+Xy0OmT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MuIKRJ32n0XExdNZwh5PeSwz4CM4OxRNISCL4mhjMo=;
 b=EpWQNGeePmD1GQUnAqYszs5rqACsmvMDnLFmec93z60jxJMvoab3kZUPQPl9HDkxiyPBbdOfT5ZrKXa6vqaCZhAqDgBmiXh7bPGj0tTfM2dlVvlaOPW6juGy8H/AUhZhmLjsB2xV47TdnD3ms64L+XCxZr624Xvpvg0c8AvZG6RI2qwh63l+a1b39XJpzICikHfXzxNnH3CNLR8YknlzBgFxDkLWAjq76L/0SY5aiczBLMJpFSIO61CMVh7rg35MBwQW4h5VOFYs7Vb158lvm//a6pIO/MjJsArIEDVNhXWuymNE3aGzqu6no4rF2Jkf9taSXbnTuV17dZrXv2z19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MuIKRJ32n0XExdNZwh5PeSwz4CM4OxRNISCL4mhjMo=;
 b=QwRWFdBPh9Tu9HJF8ZDYZcIJMsoYbIPy4aMri+8hAjcV7MAHFRliFI8nDQ58nlSmmj3W3FNzzYS9jr0hOulP9agNXomquuSVsK9DrWlgfT/9uxHUvUNO9ejr7HjPJOZtS3+J8DLXY9YRnKQb7eiHaQ4ufBetOFlCCdUt8TOujFM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB5965.namprd10.prod.outlook.com (2603:10b6:8:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 04:45:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 04:45:10 +0000
Date: Mon, 25 Aug 2025 13:45:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aKvqT-BAXGkjW7JT@hyeyoo>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716022950.69330-6-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SL2P216CA0214.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 07df449d-cc82-45c7-f1fc-08dde3922c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pj7HwabTka3p8AI3zb35tBuLxPUxCHDZ+z7Lto6Gj4f8GuSlVv3jkhPR957?=
 =?us-ascii?Q?0b0YqStFK3kKAv6RqzpbbHVvLZW3VeaQozSu7SNmnX4EdANVEm8Od8ahw8Y8?=
 =?us-ascii?Q?HphGk7ursu6dXQfBJ7Vd2yArTqxhYzCyTXXYkG002ZqgALw5gKUgNYaaFa6m?=
 =?us-ascii?Q?kNpSq8Ar/upWtkaWs6eROvPJWwJ/elWbSdJwIV4tFiYSlGPGBT+tdy1by+/t?=
 =?us-ascii?Q?2ykzhB9TcoAGrbCXArvI6QzvX/i7toYAmk5+lrqQrLzSGf59LDPYrxBhPkmj?=
 =?us-ascii?Q?KmZK1HoutsEtayjwyJpHFXV1MrgqBTz97bZoc5aulzHt58BwbdvbCbGZe4Ca?=
 =?us-ascii?Q?87eRDw7rrFT/HfrlAVX1D8D9KtZbhsIes5LyoYiZOmUIqugbdzAQcd4Alc6b?=
 =?us-ascii?Q?cf+dcNpx3//k667/aLfdqbOejnStWqRymxiWOKCSeJqgt/9piB7kddLz2WPX?=
 =?us-ascii?Q?7TAHq9+AmZjkkbInHEH0xIB5cEJ4JoGpOw4xpyknpigJZYU4pU4rPup+PTRR?=
 =?us-ascii?Q?fQT/pH5Jzw2OBEBF0piH5j1pyxvOXOzapEVtV+k1otoIDrlVg8wXLhmpDEFV?=
 =?us-ascii?Q?y6t8PQOzZS7p26TqCHgZXcLDbdPmtu/+d2wjepfBn59CXHI45wTc1eARrUk7?=
 =?us-ascii?Q?Y4xs9kGlYw1BIlvAW3ZX9S6ssFcJd3Xb/FjPHckXs5P1ToIeFMrr4Kr9twdD?=
 =?us-ascii?Q?GzRumjUGBvbnMc4Nn3rxNOsDO4BWXNrU1GSEOHbaTusge0yYq2MmXH87CxuP?=
 =?us-ascii?Q?3qJBGIKV+azdk/7GOsRwgHjVaxbSs3Dka5La6Zu7SXwNnH1cjD/JerdZV3Xy?=
 =?us-ascii?Q?TOrROLYJssj4OVRzdJ62Rb/bhTTIGRrmHI5omIKlPCYvw0YVOCD1katDfYYB?=
 =?us-ascii?Q?GxrwwDzYw6FEyjoRxzOs5Ail1Sq3l7vr+Rt7mjX4GigMDFMHZELTZgB63Cfp?=
 =?us-ascii?Q?1UJYfEuKDCjqbP5YJRZrCUT5Au4Vp1cLJSMBSp2QvED3y8rlvWH1tCPf1Clu?=
 =?us-ascii?Q?c9xmoZeoDC2t/32if27hM3EInObojBb/419RcUZ2oY0Y94AAbVHMRT2yacuh?=
 =?us-ascii?Q?5mC71PDBFrOEuZCjfGCqIhSKS4Fevk/d25Q6Vz7KzvkZr9uJWpIgQ44zgwRI?=
 =?us-ascii?Q?mP4mQ95vALVNe9o7nRN+hmm80GBpTtNs0JhiiTpsaLYNPPl8fkDj00aCNiqd?=
 =?us-ascii?Q?Dt7kD2dPequksKoelers2/31MEzSDZohOfpdJopFYLTCMZ43bTOHm/HVOc4r?=
 =?us-ascii?Q?kAlE9/o+Kw40HY+SjuT5q91fW2kLBsI4TPBIiQmf4GcUpq08Sti4CUYLrev3?=
 =?us-ascii?Q?HgCC5z+kINeYLc8rqCgG0zHZrYdyY4UrkKFKaA3vNtzJL6EHZjVvbRZePYdH?=
 =?us-ascii?Q?sXnq8NPNFw/JOV9ISDVZ2djbdjbHBCkdI6PeUDAFpzRnkw4eNqViUutdIfHO?=
 =?us-ascii?Q?YleZzNJ+pBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6WLxDpDrrUp8CB35H/maHGhlSViJtkknNcnxiJliRfK/3AahIRw5tGYrG1E?=
 =?us-ascii?Q?Eo+ivjZIfpDWBOk1zHDPjtImevwdhKLzvBiW7lP2DWNzaols4SpuLN7MtRcb?=
 =?us-ascii?Q?MX18TAQY8laJiqI5pNrrwUjoEcppm/ErF4eKBt/Bt1kDYaelnRqMFhgETJbv?=
 =?us-ascii?Q?VwP8vLn9JbxHgkJXAt5rmZ9zspY5W7pwU7fCt9BXyTdxcnh1mEFjcNHS3Udg?=
 =?us-ascii?Q?lKTBpO4GwZqrrnV5OgAswN0CzIBgXToYJrTDlVQWdRX8ZeTJ46h+5sQcluDr?=
 =?us-ascii?Q?FXfk7UBSU/Z3IvI3Ep6LU5VT3SawvP3AOeF2Io4T5X8oeGQPakEOv0YfbPa8?=
 =?us-ascii?Q?/8T4X1YAeI8+hpbtrhK55E7uuVfZQQAbmQU0XwVdY+M80Ic/e7wYU5ORZeq/?=
 =?us-ascii?Q?vNBbe6yXGUIM1/VrL66vb7/fZt6dpugiNmF1R0sqlt6I83TUT6pPjNxhAz34?=
 =?us-ascii?Q?Y1euQFKt7IRPeUrbAtjtS/j2Q1r2Sn4cw4EcnFECK1iPesU0o3qg5lftvUVk?=
 =?us-ascii?Q?PVO9QoL81yX5JvQAPBaPDtqU50dcoQk0Wpdn6gziYYd38mkfDr5eyK8DRI8u?=
 =?us-ascii?Q?Z/oInyNJNRipVAqBQjiK/pQnoKYlAzqrPXZtjbGx3CytpvB0NaAw+UTBLQF5?=
 =?us-ascii?Q?avMyUdPxphSsG5/IjUUrMDsob2+t0QyKUi09ueJC055w8HZOgs240k6x9tEK?=
 =?us-ascii?Q?slu5F+v31irESKonAy4NBHdDETV6ZCgXzJLh5tsb5XfJdiph2sHbHITXGNK0?=
 =?us-ascii?Q?H+vMhkWoHN6dY25fcWGHwghxr6Vk8jgiGC3pPkphihfGoEFoO9SBAUL2N6qn?=
 =?us-ascii?Q?N+1i+AG7xtCmO4M9mVRq2cHbz3DSPadu+ZZBm6SChseFRTyfOorDdzAQVLqD?=
 =?us-ascii?Q?bMJpG2rL1F7H7oG4nTxVg2OFnfVN2XNXfB5o/ZG3LfjaUOloVKD+CBFN9Y/1?=
 =?us-ascii?Q?yl5Ycr+TaWlf8KVJI9HRH9Ml3xKoBj8SdYS0tu8/bJL4qqjAqaFIifgcGjIE?=
 =?us-ascii?Q?FKzVYga8zA9ZWeBwTFRyRpfuuwibpMXRynPBrsW//iPmqzuxEtmbjuIUJrDg?=
 =?us-ascii?Q?dncVQysJzK4Qk13TbCz6wNjo2OeSunHLszo28LFjtFTRM+mCOsTY88Kk50ek?=
 =?us-ascii?Q?VHAMLP6bantKsMeJdl2NWdGqjEcD3Df0pW6uNg62tJWz+8d7tJTQSr+9cxqv?=
 =?us-ascii?Q?npfIPQOg38+9RdIPfJA62oSIbM7kR/GRLObqIukHF7mM84AiTIPTgZfHNhxe?=
 =?us-ascii?Q?eeMWoOzlSvRQjJearzy/0BSip/zsxhKtiOAicGuXrPm3SFT2hqa1fUAUcEbu?=
 =?us-ascii?Q?4TkflfIuEojIMfIjpjzPYaVggHiW6RFdBqyVwXpRkqc42uOkoxMsPIKZkY3C?=
 =?us-ascii?Q?jmDsDbFHvdu45b/ptCCkz1cf7Rc7hk3/kVNNpsZqnpq5XEt9/OrHaf8xilo3?=
 =?us-ascii?Q?HoPZ0UHO5wTpKKhzxtKNQA2ZNxO8TSaqTyc/NghQNl245GvSHV8sfJ/CJVdE?=
 =?us-ascii?Q?8EIasrhyVEUrRavSf+nb4Nmaa9q1QSqbIHk5SXjyYDqXjT8MVnwzTrKirhF7?=
 =?us-ascii?Q?l3/Qh22+Ks+GPiSoGNv1qyqbvCKI58Ws9WGTjJJD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YHIa0jBvhYlgi6HmEUnUOk3JIc6zojtoQSToVS4dDsIQUXsani1PXCtCsdyIQfW2fTawNge+avrZsGTyZNBP/+XHVFs/IJl05nl3byhdEpl0F7RczTS4G2ZlGKq+h9hWTWgZuzRU8e4fR4O/sn/1uNGVqndSHqVbbz6mFuj/TzcuP524bKz/Xe/VjszfC+nXxtm1O+yr42SJte+O2YrWyZU8f5vOJA2pYd0g9KapyFIKlii9t7G4DTqX9baAw5bvjeoRWu2W1Y1ZdpplzHc4moqrCMq6TOzJgc2TU7p6FcSoEqdQW7mSnywAZY5lnDkCW+h3JFWX4911SoVwc5GU85oraiiW1ZlQuMBlc7dzx/pc1zkdRsnH/+7mjcmfT/QCIxvPxAcCHHcEmn9vVKZMoK/Hl5bg3aw1zDgwZCTZgt/+bDk0qo1T7ZngToiVPTTeqtz9/HKehbFIQ0PxuUMnMAUgEeg/AuFaKw6JDlrJ6jt6C+wt4qsgyhYaVMj/piUqxIEn6h6IQv1L5dqSPfbu/65mjsUdJ4tZzVTwkD6/M5Tu/fJmRpSDaeoW5dkyE9V7ZRcBXLXrafq/fp/jCS9L8e50pAbahi3w7D9qBCTBw6I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07df449d-cc82-45c7-f1fc-08dde3922c1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:45:10.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrATO+aag3c4s5IPLouGbz6Kx/01t3h3NRqPUfimTTVfp4AFAi/YNOJPdOGzSz4wyEKbhb9JaNyOZdl9eP3uUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250038
X-Proofpoint-ORIG-GUID: lAiKw2jHQB5GLFpSKdOCABbdCIjWrNF5
X-Proofpoint-GUID: lAiKw2jHQB5GLFpSKdOCABbdCIjWrNF5
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68abeab3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=FeHwLWA2l4aCqYYsvRAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfXyB3GvhUyTxkv
 oHluU3aSQbl58aIDFr5VaMwZAg8Dtmd9mqahEmrmPwy68TLSZn34mKr/KWk1AeDTVaZ0TyB4epO
 hi5pubgEg++5njkOYGkGoboRb9SffhgJbkK+amZvVHMQXEgjzht/bWJFxpKLE0AF+B/MP9HCFBp
 34g5qBnocE78RzB91Hp2HieGvgTfTrtj6YlXNPO6BZyo92PAZI82AbtrzwRipGAVcQ7wWjfomay
 FeEry7c+3mXFc2rkNZmo7QtBed4X+0I1YthjPeQnWQRsv8nFM+4RyuPyiAgCMjMX0Grvgt+tBIn
 rLM5+MKg7manBDXBBy8kaiHkRj4tO0vCkj8z+L4VGaAoSKe2TpRngq3mDYzeKrMS0susGeH2ltK
 zfG182rrh0P2Mx30+d9itgyV5Jn9hw==

On Tue, Jul 15, 2025 at 07:29:49PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation
> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> In that case retry the operation in a different kmalloc bucket.
> The second attempt will likely succeed, since this cpu locked
> different kmem_cache_cpu.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> a different bucket that is most likely is not locked by the current
> task. Though it may be locked by a different task it's safe to
> rt_spin_lock() on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> and in_nmi() or in PREEMPT_RT.
> 
> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> always defers to irq_work.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/kasan.h |  13 +-
>  include/linux/slab.h  |   4 +
>  mm/Kconfig            |   1 +
>  mm/kasan/common.c     |   5 +-
>  mm/slab.h             |   6 +
>  mm/slab_common.c      |   3 +
>  mm/slub.c             | 454 +++++++++++++++++++++++++++++++++++++-----
>  7 files changed, 434 insertions(+), 52 deletions(-)

> +static void defer_free(struct kmem_cache *s, void *head)
> +{
> +	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
> +
> +	if (llist_add(head + s->offset, &df->objects))
> +		irq_work_queue(&df->work);
> +}
> +
> +static void defer_deactivate_slab(struct slab *slab)
> +{
> +	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
> +
> +	if (llist_add(&slab->llnode, &df->slabs))
> +		irq_work_queue(&df->work);
> +}
> +
> +void defer_free_barrier(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
> +}

I think it should also initiate deferred frees, if kfree_nolock() freed
the last object in some CPUs?

> +
>  #ifndef CONFIG_SLUB_TINY
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that

-- 
Cheers,
Harry / Hyeonggon

