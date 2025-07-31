Return-Path: <bpf+bounces-64805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F202B170E3
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13481169DAC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847B021A433;
	Thu, 31 Jul 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SEwGCWH7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XF/45A5w"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DB2E3716;
	Thu, 31 Jul 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963676; cv=fail; b=RyR7fUFzt0XRunEmyR1hDSY6SnI0klV/AyKldZtbfhE3eZ4C/khXbWj/f5kQhluZUYyTHGXUk2QnxExUiFgKse/GT39WvtxXJdwnHHZp2P5rcWwifi3T0jNnvnsMSNH+Q8o4A3FfxU6CICpc30JDsj5UPQAHd9akA2tAs1msjBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963676; c=relaxed/simple;
	bh=5h6zjkAkRbOeejh603iI9511eWLXVMR3MsUzpvKPGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKFEoTznVHXWQi4FdE3y+oB5ote2Bt0txL7NzasdUuWn4d7fU/AXAEnSdhQtw5vwZHYH0LCPu+ftMuUIrTg3NotzRIxyNYi39+ADniAW5hmQKUtqS/F7o71DtFhMqD9mybJvuOUGIS9OggGNbSgGgaAMuVnHP3LYgXk4bgeWF6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SEwGCWH7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XF/45A5w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAsR5A010690;
	Thu, 31 Jul 2025 12:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6uNRe5cFelaUvLJUoe
	BxcrgFTrJ0EKKKfWAbuFf17Gw=; b=SEwGCWH7Avx/MkTdqQwDf+AR9o+sVXAynE
	3L94k96E4H/vsaBy+/0jGge4JHIU2Kbhq+VKNGWbM5Agr6OABxYy9xVCHtDk1smC
	iqJiKn7DtRz+hXa5Lo6zLPuURlepVULazcL3YWbywAmpkPahkwQxlw9X+gGHW1nT
	CuRGa0308xVbPlmrxLfMcRwm+F38zYDhZDuHm43Qww02ildTnWuKrw40J2OZUQkl
	Kj+4R1O6Alx5FYWiaUBntdZp7/WGcTZS64dgPO/QwmmAtGfsoEYrkbFhQdIPH4Tr
	z4EmUSbqJ0JPYCd42BjvZvdW61FNxDXqrE83riY8YLSUXIeXLeMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q733yb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:07:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VALipZ016791;
	Thu, 31 Jul 2025 12:07:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjqu73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 12:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWRVv6sDrVUM39jV8VU0aOkjXtEmaEyuD1nIQSJCRruuOYzK8U1p7dhxe7DKRE74hRZTixnMWxmnwjTnVqxSY6XdhsLATPTc8cofEtO08gYsZWnlWIoRQJ8s031ybTM8LHwsoIqDOpulyP6d4yDbfrQ/S68pYsDqHIYUHqAqzDa8M9hmJ9tCRpexIBzRaxPScVobb5+LafvQ5LW+QMPMY+TCHhTyupdfc5NKIzZ+w2+82OWN0J0psSQmkAhvOjCjq/sJFaZc6N/74/w2cMelNC/9eeuH7wRc08RHodKcBcN3yXBihiUqilW97R8CfcbOSaIzk0UssEEL/h3faWzUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uNRe5cFelaUvLJUoeBxcrgFTrJ0EKKKfWAbuFf17Gw=;
 b=zKkijN8X4//kuqnrsRWaHb/CM8G/HbCZS9MSW3DNf4hmYZ7cObtiwd8memPihhXNHqk+jh7My9LWoyxCzKVhhhJOA7VfBvtsWrpb4tdoRTUVpkpmjIL8FnVCFn8xlosAWeZW/34RwWIN/2hxg8UxuA4YCF2wmwU5TyaJAUeAjBXhWSOoXvyx1qaMokE3t9zDUQOKq937aSzmlvWaw3v8vGFZM5kVc60oSTY0HxwBh+InkpGZpjIK5/J6Myn8PTQ/XoAkoDttkSnHFxKmumwb3SM7yq6LT4s8u8e4xloX/O2rpGGItN4XrWf5K1+9fRT/YtY2TTcihJQXBOY9h3aIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uNRe5cFelaUvLJUoeBxcrgFTrJ0EKKKfWAbuFf17Gw=;
 b=XF/45A5wImJwFtMXKNhzHVKDtUAvAyh66SSu5IfZUrIbxTzxwAsLy581+ijF+KeGXqpG4ZYlEg1WeoI5M0B0+ZmnaaAycrfMxpGH8KNUxJluCUpmmmzgpHr05E+F26PZ4upRRWokfHQS4LE3uZlwoSgVr4GDUxcMTw5/9XS698Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 12:07:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 12:07:24 +0000
Date: Thu, 31 Jul 2025 13:07:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v14 1/4] :mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <2c2f397b-e829-48f6-a8b8-29619439fef8@lucifer.local>
References: <20250730191921.352591-1-vitaly.wool@konsulko.se>
 <20250730192002.355169-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730192002.355169-1-vitaly.wool@konsulko.se>
X-ClientProxiedBy: GV2PEPF00006632.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3c8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: d1708b46-989a-4359-ddcf-08ddd02acf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTlVGyZPSOvyrGY6+x0l+frcEFc9Ox8qQg3AaWvS4xjH+CAzZ4juOieFxg0q?=
 =?us-ascii?Q?PsgQ0Nuo6aJ9vPUTDUElk905oBQ/qb4wUavbnW12qIQOwS7Q/49O5B8oaBWQ?=
 =?us-ascii?Q?TcKE4to4Yr8ft+ZFCgwU4K6fXc6pEA4qfBFPwIBojpu+5sSIPqZe+2YD2GYB?=
 =?us-ascii?Q?ygCRh9er45kJZImkRTHhJZlrna7edEBdifteCJb3Mi7hpOoVGN9j+Ytb0j0o?=
 =?us-ascii?Q?fXD0sgDWf48Wkmwg+vkFgIySFZLq7okbqrAAZzJwwRtLNzhG/uyZ7fAhudEX?=
 =?us-ascii?Q?R0hx+XL2SGenqgdV56BhwsnEDt5Jf5lFYkPiJGICgjSWbDPUD5yxkjS4N8JI?=
 =?us-ascii?Q?vE2uTMIsdPB4gffU80WRL9ozwxRz51zjeVv/7iG5WUANRChubKl0gu7oM4vF?=
 =?us-ascii?Q?Q0vzOeAjSP4DjW4q3eFAenLxclaf/0k6YFuTAmz+lZ0YcBsD7s5vMAFajob4?=
 =?us-ascii?Q?rO5ZkePx6j17EOA8OL2WodHQ2p8bjg0JCqlLkc2tzKoYNiCizfdXnawKxQ6S?=
 =?us-ascii?Q?6yecaD3rU+UtehA98h3LCHBcDP4kEh3O5fDbtIByT++KjnQYx3whmrVk09nE?=
 =?us-ascii?Q?fRfSJyykWzEksrkaAS6fwJU3xp67+XZm8sGXBRiETHaCryjP70Znrv94mXmE?=
 =?us-ascii?Q?56jA1oam9Av6WJTmncpK7yOERxxyBhz5kfP1v1uDNvEisuuMvCx5zUazLc4L?=
 =?us-ascii?Q?tlfz3wqiIBtnxvB5yXeDqypID3wy64u4/CoRGpP31aAOuxzntTdEGFLDRZ/F?=
 =?us-ascii?Q?Vgx8t/JO4IffZgJ1rglrJWfLt2qKJrinNcby13FcDQDN1dYkQGp93gTlzhWd?=
 =?us-ascii?Q?eV9mk9gHYuDiYIQTigdwVgZWPgoE7RhPjidFOZip0iPyKweYzi91NAaYT3CR?=
 =?us-ascii?Q?gKyp3IhuTi/ryYydB8BMOR8tpkdSWNJ9jg1hLGkfuX89GtJLBROCHmExPI0o?=
 =?us-ascii?Q?es/dIYARSUDsRCIheGRF3eVytiFDoQCVCW1GvQ41Tgm4S+JaFUerVroW9Cek?=
 =?us-ascii?Q?Vaq5/TrrW+ZU6Cr0/9Cf/eyjEFf6a8tezCmnIQu/eHZVPdLo7IVO5C0r8NYu?=
 =?us-ascii?Q?kQbj51LpLwhZebQIs1UgqpVQSpxMddt0VHi4U5mE1ARr9ZBdwQlFl3zcfjRq?=
 =?us-ascii?Q?BFXaQGgkjb3P7HtbLZhn2kRxBPLz3J5RqiHj06D2qwa4gRNpQzE31MgwgzNb?=
 =?us-ascii?Q?v3IKjhGyioBMcw/SX1xtwkYdIroZY6mZ60KE7uuHVCgopMa9iAengxVd6SaH?=
 =?us-ascii?Q?NhBluF2RN80FdfkmuhDerphuW2BDh2wgd0UDg/uZF/hEZ3a937b0fUPL1awZ?=
 =?us-ascii?Q?aD1is8c/IeDV6CkrHJFS3xBlrWovk3VRI2nYMH1RqWY5cm1Lf2L4Mo4SBQjI?=
 =?us-ascii?Q?v4+t/IiKXghj3vfMVTrCzQ7wlQE5HmMQ5j5l0HXCsz5g+8oXkH0/RrYHpOiL?=
 =?us-ascii?Q?h95S20L6vRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T63dGUa7pTi4g2nZJR17XwI//tIDI46HAK/VJXVYnhMayT4bAqxAIUtBMDXg?=
 =?us-ascii?Q?CCEsdErnBd5/A2E1VytqhUdexidGsxA0ZKOLa4kEUod4Bf2LuTGz5ov2VQz3?=
 =?us-ascii?Q?qr2WSigk8XE/U619a3vsjYwGvqbXhjhTUfffB6D49jwBkUstCHPdPd6SPirO?=
 =?us-ascii?Q?Gq3xkkeT/b0zJz6ExrQZEREmU/v6Jk0d/UcoUTdhvwL4w0us/QDOtTyyTIl2?=
 =?us-ascii?Q?TRBwbuwvuQ4LQcC0ArzDLIChqpTpaPGxIVz8pbuvkU+MxJmGPZ0psyPUqQ3X?=
 =?us-ascii?Q?42oxnNnaRaQU1yCLzvcg88B1jWOXIvtZMbFjoxv3Ik9aUAa9u1yHKoz57F/5?=
 =?us-ascii?Q?cGRp9JL6lV8RAQsxhiuur+6H4+0ERZmQAII9UuLZaP7mkwBvsAkKEspd+XJx?=
 =?us-ascii?Q?lMpvXvzlecKL2/KWXEtTMPxhJFnABikvipi6jyFDe2KS0JclnE7r564nXVk9?=
 =?us-ascii?Q?7J0QY+NbTaZPguJoV/xJ2X/BmvenT00MFr8U1+oOWYwMRufqq5/MhWen+11/?=
 =?us-ascii?Q?MC+7MiZuCkKZMjS+OtEAcsmRDWyBiH+8EPu1Nk07iVMn6Hdc5HGBB3bFjHyP?=
 =?us-ascii?Q?PPlWdG5sTMIugF3/wU3jiYNgUr6lUfPC0FGKvXno/lpzyx9/y9dxKa5P/MQ1?=
 =?us-ascii?Q?ihJhDubfkWkreWf0dEPcx+seCP2MvUJHjT+D+4t/BJo9evuCu2BPxLpEg3X4?=
 =?us-ascii?Q?zw1jJvqUowiYjwHsNM7/8cBohGHkkH7YNnBrcKoGM3XuMyPriSo/NnmKvVBw?=
 =?us-ascii?Q?/5st0XlsJ0vmRiU88oU/9efM69QZBWaAd/t4+Yv+u67Y58RQd5j14RLCuAvd?=
 =?us-ascii?Q?QpgDzfi2cjoNvVTeFQJOLf6o7QLNHKQSt9AEPuWN1+Mai0oHAV90wnHH2/OH?=
 =?us-ascii?Q?lT2GWman3RD0/+hOoWJOfHhgvzHzUdtbsJcPFQcM/zMzpq6uZ7Ecrs9BEojt?=
 =?us-ascii?Q?ff9k5jqx4J8C/hyODjkkOHYeCNQ7vRev74bKHj1Sh4JhxaPDBux19USs8+JD?=
 =?us-ascii?Q?46SVl++v6KDP49AIUoYpEvcV8C8361wFGdXAf/JCafbD2p3vGIpqkrJK50mG?=
 =?us-ascii?Q?Bo5yfq//YmZfCds+XhJw/LNYBOZlCnNkxUR8609rUDj2tCKaIVfgHyTuDPIK?=
 =?us-ascii?Q?rSLgsnEEenq7sn5KlJdVqJOhwrG52lp3rb3mOJi+jp06A5Mmz16F6Ykb0uHz?=
 =?us-ascii?Q?F4RcM72EEn9SZusP8ajSEeVvU7bFD1NChNuV+91+pN1xJgZFkKnjAmRLgEZ9?=
 =?us-ascii?Q?twqcsWcpeRBZ2itG+c8EtObbg7MRpaMfg0FdTwKqlpvKf3YZTxX9C8cD/+wZ?=
 =?us-ascii?Q?eitqKNVLMaclWXL9iBHhEAmv/f71M+WdQz21ivFdodO3S3cZe7+sBOPQpYJa?=
 =?us-ascii?Q?6fyU80rrzDj7eimf6nvhy7+AYQ125J4WnqI83ROId13CtktLFusM3Ez/3v4v?=
 =?us-ascii?Q?djYnzEWEW/3RgIGNxafgjnwQstndgraLS75VAMA9Thbya05G0PwhXGn4nt+Q?=
 =?us-ascii?Q?qUVVV/L85+CUerBlfJvWCwrtm9BoGOughk7Qp+gLYxGXZy9AMBnmqxlLint2?=
 =?us-ascii?Q?vP3YC0cs0PTU8MMmp/THFKR0dKS7dLdRGtvB61WVMuf5rH1BhGfaSW5aK2x0?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eedyfT7wrT/SAbVpBxl4pLNRzE6eiONhehAUXOFCNC9u0KhJPFnr5Pkfvf9q4BVyO0H3FnUEbL4To7W9A3Dl/x9ZqVC2Jt6uuWD6WcjBdVAwmcHi5YuOxc5UdNspM+QVE4FXQVd83co/g4PFzyE5lrOOdKAeuL3MwI0slM6q+UTOhCkNHusn8VRfWBazji+/KKeEYHn5kiauJo3O0TdZ5IGU/xnBzX1IJyhVSXRXgIrBRxNhCECs5yVkB6eGbKf8rU+2TlZmNI9c+jbLaIwUK86MwQbrHMkx5kf22jp9FTdeT3AGWOLIH/foU26dwt5mgYne9pUXhruUcd9R8tYPsllJutnUW812krhfG3uB2gjHaNkYZbs+WglQSPA00PPQ1BiegbBq9Xh5JVW93ANH6ZI04SDfICcqRxuYbyRwq5NwmTktGDFY4MLalAB7eFF2cjmNwvc7hYUXdUSFP01D/0Vc050bPu+b+A6teJXxcBCP46OXLy47o5CsrXjvFUrH6B8TLpKuE7is/cNT54wbp/pfvonsIvPOKvDGRfG1BAzipY9W1RGux6/5XnnbUsv6d9xT9Urw+c0U1H92KMibU7B5hkEMHuQQI2YI8nZ9LPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1708b46-989a-4359-ddcf-08ddd02acf5c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:07:24.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFRaZG43OLQE2U4iut6jKCC5OZciWF6Osp+UBxYZEgvZ0gBHw8bCuC0spyDOFus+cdl2gJbzVs3ncbNAqKmvTxD9MSKxFVi2DnXZ+zRRtWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA4MyBTYWx0ZWRfX+qTyKKbaIG7C
 MsLRcEK23HeK7qn8KQpFiw97z9FweKds9ALFB207QLGFHYO7UVgcQO8GDdUqIJ/Yg5YwbhbS4yg
 gaEohlGKCtLN5j52t+l1DbH7+QhHfBqfsYpfWWvg5XeycojYQBa9qyWNLpbtDxrgO08Ug7Gb9KS
 yS/DxcNutXcw3Nte7l5BwikS0+uNapZjtZlSDCgDTSmJqCUUc/YD4CD1xnDmDwkkDV0yg7cD9XP
 pc6z5VAQcWyfF3Boef3Uc/CMFb4NYP29HYwXxB7pUi65kky8qFAPx+OXaheQ7N5IGZyjtqhuOYJ
 q+QCODVEnENf5CTW1rj1uI5NN4gpN9G81XmnITQvD+QBSepzxL98FtefoGbzUhrKK4+SwO5Qotj
 SFOeoBuvT7foFTHFEfZuxhSORekXNo71gvnkOEFhMgQi3wlypSVB1IwWaBAaXmlNQGlXJxpm
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688b5c7f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Y8mYsLuOk6LQwvwhDr0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: 5jHaAPz4RTCvVmWEa7qsKt9picrk58j2
X-Proofpoint-ORIG-GUID: 5jHaAPz4RTCvVmWEa7qsKt9picrk58j2

NIT: Subject line here is typo'd, you prefixed a : by mistake. I'm sure
Andrew can yank this out though.

On Wed, Jul 30, 2025 at 09:20:02PM +0200, Vitaly Wool wrote:
> Reimplement vrealloc() to be able to set node and alignment should
> a user need to do so. Rename the function to vrealloc_node_align()
> to better match what it actually does now and introduce macros for
> vrealloc() and friends for backward compatibility.
>
> With that change we also provide the ability for the Rust part of
> the kernel to set node and alignment in its allocations.
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks for improving the comment, so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/vmalloc.h | 12 +++++++++---
>  mm/nommu.c              |  3 ++-
>  mm/vmalloc.c            | 29 ++++++++++++++++++++++++-----
>  3 files changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..68791f7cb3ba 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -197,9 +197,15 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
>  extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
>  #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
>
> -void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> -		__realloc_size(2);
> -#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
> +void *__must_check vrealloc_node_align_noprof(const void *p, size_t size,
> +		unsigned long align, gfp_t flags, int nid) __realloc_size(2);
> +#define vrealloc_node_noprof(_p, _s, _f, _nid)	\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, _nid)
> +#define vrealloc_noprof(_p, _s, _f)		\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, NUMA_NO_NODE)
> +#define vrealloc_node_align(...)		alloc_hooks(vrealloc_node_align_noprof(__VA_ARGS__))
> +#define vrealloc_node(...)			alloc_hooks(vrealloc_node_noprof(__VA_ARGS__))
> +#define vrealloc(...)				alloc_hooks(vrealloc_noprof(__VA_ARGS__))
>
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 07504d666d6a..3bb62b779ef4 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -119,7 +119,8 @@ void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc_noprof);
>
> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
> +				 gfp_t flags, int node)
>  {
>  	return krealloc_noprof(p, size, (flags | __GFP_COMP) & ~__GFP_HIGHMEM);
>  }
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..e299b51bd922 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4089,19 +4089,29 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>
>  /**
> - * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
> + * remain unchanged
>   * @p: object to reallocate memory for
>   * @size: the size to reallocate
> + * @align: requested alignment
>   * @flags: the flags for the page level allocator
> + * @nid: node number of the target node
> + *
> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc_XXX(). If @size
> + * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
>   *
> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> - * @p is not a %NULL pointer, the object pointed to is freed.
> + * If the caller wants the new memory to be on specific node *only*,
> + * __GFP_THISNODE flag should be set, otherwise the function will try to avoid
> + * reallocation and possibly disregard the specified @nid.
>   *
>   * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
>   * initial memory allocation, every subsequent call to this API for the same
>   * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
>   * __GFP_ZERO is not fully honored by this API.
>   *
> + * Requesting an alignment that is bigger than the alignment of the existing
> + * allocation will fail.
> + *
>   * In any case, the contents of the object pointed to are preserved up to the
>   * lesser of the new and old sizes.
>   *
> @@ -4111,7 +4121,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
>   * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
>   *         failure
>   */

Much better thanks!

> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
> +				 gfp_t flags, int nid)
>  {
>  	struct vm_struct *vm = NULL;
>  	size_t alloced_size = 0;
> @@ -4135,6 +4146,12 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		if (WARN(alloced_size < old_size,
>  			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
>  			return NULL;
> +		if (WARN(!IS_ALIGNED((unsigned long)p, align),
> +			 "will not reallocate with a bigger alignment (0x%lx)\n", align))
> +			return NULL;
> +		if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> +			     nid != page_to_nid(vmalloc_to_page(p)))
> +			goto need_realloc;
>  	}
>
>  	/*
> @@ -4165,8 +4182,10 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		return (void *)p;
>  	}
>
> +need_realloc:
>  	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> -	n = __vmalloc_noprof(size, flags);
> +	n = __vmalloc_node_noprof(size, align, flags, nid, __builtin_return_address(0));
> +
>  	if (!n)
>  		return NULL;
>
> --
> 2.39.2
>

