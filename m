Return-Path: <bpf+bounces-40849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEFD98F513
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522CF1F22322
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480A1A76DA;
	Thu,  3 Oct 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LA4sC4ur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rJcX/xrO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72151A7250;
	Thu,  3 Oct 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976553; cv=fail; b=eDJXH79tscJ9qxZKzOGepJpjWoirxnN5m8sRh0JOkvN9bj8HsJ0OaI1aR0LTKhVS7+VGcOsI8wCiNyIj12mo6HxjyCmoDWnKl+HWQTYS19Ij6H4po+BbHsPpS87lQXUusn5Tmh7/C6JVQsmr/n2LsebW7kHx2nu+QKO0FWejI1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976553; c=relaxed/simple;
	bh=BklhJsf48D8GbkU3iTMERplTXGDZ4zM5mlJqgAC/T1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=L3SegYxS0CEJwxeEmIfb1WQsaN2OcNpcgPMFPnFOPXK/xYhbBWdDD85TCtihkAFubeijuDk/aBEVnfstypQ+yje8GXmOmRcGLltbfYWzwGnrc46ErvZsmVezx31oT1IzBD4RDz5Ot9v6F6Jrn0zqjxc0vWF+ZcrJbMPrZdxoS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LA4sC4ur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rJcX/xrO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493FMdbm001026;
	Thu, 3 Oct 2024 17:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=CrQ97kAp4xN8Ur
	mpbHb+hFhX5bAE6Lk0RMccM07MH/s=; b=LA4sC4urRNhMHIe7G4OFZSV8ZsqWrZ
	Pz4gIN7YFQ6r5OIHmGijXtR5EFnb1tk7fR/7flCS4KTnibEkCfLQiUNL+KNWAXSY
	dV+dzkQ/boG1I7oPcU9mjbeUeqAcsKu0hhPjP3aBLrkSzJcgG+TnZhl9zGVj5BiT
	KtNn1+ghplgdP3H+2CmwBo6WSyuhca+szfAxQrDX/5uEipg3gxzFadPJ/IPOVMsC
	nLjclYFtpFWtI6TecDhWkrsDczZS02c18PCKDAk457UwCLjCsF8bFeUg2rtPwsQl
	oS90OeLLLYAAXk2Cgi3VU6ioM5muKndszRZIor0p6kw1KcdqvhdkqGRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbcqu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:29:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493Gu2ro026243;
	Thu, 3 Oct 2024 17:29:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88ak35v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp4fFzg4U9lpAU+8rEJVBwv17JsKwMQuZS1J3SiRQhj7nrXS78LTBDkA9WvGfpnDHGnTjIxBA86H+ic3CgF/DuNiRED3EGN9TdO3kQLCgXK0e6rDXa59s0Qnrv6iGbMF703WbBl8NVU7y3ovK9OvmbHTgG1BvHs5H181Oye1B8k+m9uDZ5ZJZtXk0MLDzLmwhuPAp1bO+/idZoUSvXhb9zTClFpw/ZAQUj8p0DCtkFm5L6cSavmShQFg2COyLs2n6blWsFLKqm2UGqnBJbURecS7ooMOfkRVdRqJTm2SOwdPZWQoBXafXIsOWMhkzgvhIDDH+9dcoQvv5NJCg4Pikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrQ97kAp4xN8UrmpbHb+hFhX5bAE6Lk0RMccM07MH/s=;
 b=gyZdM15thxnRJ1+hf4x9w1uFxE7VTQ+Dm9p+7l+CcT9lzBVvYlrfWMRXXMrTwo2WnmCG7mCQlX+KKD4jGI7S15n3p6MVikZB72oNcfJmY8tWIexMY+VgbpyOYFVOGQ4VcJjmx7oiMyui+TvF810FC5I2slLl7kXobqZ/CNywyn/blohriw37o/gDSei3c8MJOhaAUv+NJqyIxrRkurDHf48xH2/4GtBsh6RSlzJsxbrL+xl5djWjMoIbtMxu38YFTiAqoKdaqiHo8gYn18W6Pn0PMvpA92RgoqByaGwjoFM1FMDIpj+xn2vmy+B9S2Y6hTlw3spP+qOh3o9dX7taOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrQ97kAp4xN8UrmpbHb+hFhX5bAE6Lk0RMccM07MH/s=;
 b=rJcX/xrOGPbaWnDSJ7PsOUN3PdO7K2naUoe9XMU3rKCCwuxaDNu0TSQ7E8RRUTGLr5r26VHcN7UE/Bp/A0HkTUiSDbp1KZ4neDx08SfULY4lHXp+QWIREcEKhG/UIjcnqIfAH42xqOkTrn3M2YCu6NgEf46Bh1jyGsJ5bDAof8Y=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 17:29:04 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 17:29:04 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 4/5] btf_encoder: allow encoding VARs from
 many sections
In-Reply-To: <ab2eb05d-9108-447d-8720-f511263b40b2@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-5-stephen.s.brennan@oracle.com>
 <ab2eb05d-9108-447d-8720-f511263b40b2@oracle.com>
Date: Thu, 03 Oct 2024 10:29:03 -0700
Message-ID: <87zfnlksdc.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd03446-b67c-4565-cde0-08dce3d0e0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9wb8zJwZdTnMbKLbyU1Y6a6ngirAiocZyX2AkLe13XbxVlCxWqtJC0kV7c/?=
 =?us-ascii?Q?D9ZchSO+BbS+av2UsHDjXC1Jg6NDrwfwEZSzgJXBIrBnAfFdp67hxa/TC9VE?=
 =?us-ascii?Q?hDVGW07J/YrXYpZ20wfz6ALtXArUKg8v3tYIjFU0ZS/HuxpXT+e8nOrNhAp2?=
 =?us-ascii?Q?heg4sIoXWDX703yWtl4TEVKTgnfN4St1PHbgnQtdX6KEIpZBraSQQWMsok0H?=
 =?us-ascii?Q?SDj5ycfOzLuj7SS+VLgPawU+BFkTNY9SJKu+CogXwUUW2EhIxXubQSxDcc6V?=
 =?us-ascii?Q?XDnE+MSwIw8kTxcpsCvjCSEEkek2rVhbCpUjt+P6uXb7E1NTc4Q1PWmxL5kK?=
 =?us-ascii?Q?qGTEPt8UCThKb0FrutZjR2fkpRR/IocY60M5rD3dwHmQwwT54snC6orUWOeS?=
 =?us-ascii?Q?WLK7BN2wJ8aGChzJVJOZaNvH1bSnR2FMDBxpVNEIWfU/1AbedyMnJyQxFMaL?=
 =?us-ascii?Q?INAHhBv39MyhSEYreNMx5lvsnc6ggtUOxfZRuL4q6iQKPQ10tKcmZcogcpbQ?=
 =?us-ascii?Q?hTpykfOV/0+97niFXyCzKjxHWyGV1hLsN4pnHjRm/iXMOuky84EUZM5rERiG?=
 =?us-ascii?Q?ZjdIXcC7ih1p9rrsidpLxlfxTmFpfA9PZkEcUzJmrsg2EDQmoAhiBAS4GtgH?=
 =?us-ascii?Q?moRIxSNd8a49nzFDZ45mem33TUg42TaPVLNZE1uMk7jUMbMD8sOt6KZWlyez?=
 =?us-ascii?Q?vXm5xDcSEhODnT82GrDcv32QP4IGPDaWaL+k3/W+sDTHhy8HEeFO/jgbM7iI?=
 =?us-ascii?Q?YNN2HmMrHiZAAtdOwadhShIttsAJA9Q0dUqQP2A+ggUJxPY2bg72fUdzSJSS?=
 =?us-ascii?Q?cJMr9wJHlhERAFWYXanhUS92a9KiyMPOb3wVuL6JH7fh+o9jm7Eewcyp4ygy?=
 =?us-ascii?Q?Exd/R4GBTO9GllCyqzqNiJUnfjTz/PNlfChJhQ/morTwsaeoQn6Sb3JP4fR7?=
 =?us-ascii?Q?nqwCeO7wDzTm2Qt+dGuwwZUtxCQRBkvIB+Dy0lWFybcIU1u/pQ9zpy85VKzg?=
 =?us-ascii?Q?zrlOV8aAnShUCbN4fsoT3UrjuStuTGEeAa/u6UZGzqnt3d0VedKWGMlCFBPD?=
 =?us-ascii?Q?hnTWRHmAwzDGI2ZaL4Y18unvqGIViFSrjZmpLjtJ3CTnzVEXarqXATu/GgW5?=
 =?us-ascii?Q?Zk+lHle2vulKwQlxSl7n35JRjUaK5xorRfEKbOIDvMQ+CARpdfmtwOItR5DM?=
 =?us-ascii?Q?pK6ckncvG9M+QAwqakbuvQRdzwoUifpS9/UwF+wk8catdxcikut3tJS2OgRk?=
 =?us-ascii?Q?A1q4AZ/MPrBqMJIWLAvSOHh+12bPh/Su3Zq4PEc0Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggctQJJf4M9s1sTXgLIL2j0Bp5vXUMk5sV1gmqqKmFIpNy4HNYo4sfqTNDLz?=
 =?us-ascii?Q?e2PbFqpTKnXOkaUdv1rH5XEqIbw5uFqvp7wGcXDj9TIZD/cbgqjd0EDiO/Sy?=
 =?us-ascii?Q?aKCT1pEapvcQlnzKIgg2mN+VrnMxx8HJyOjMVYM2K4K5QfWltKE97qRhxmzS?=
 =?us-ascii?Q?iyaGVj9peN1Np7QH6wqmxFIkpVKIAeUekXpe5Aj08pmUqdC9+XW6MYPQk5u0?=
 =?us-ascii?Q?Uyfm3kN44rlfAx3Ad4ENeq/fhGiQ9cS1bjt1irTOjFCWDBzYNc1bLQZe7fSZ?=
 =?us-ascii?Q?6dHGUI5RHYgR1IQpnf3tI8XVeVr7nrj0veiKMpLa2QDYqsKRQk58Tsl55B0o?=
 =?us-ascii?Q?ZOD4RUain64GJvPonHlHDW3yFCCiB0vd0QmnyfG4/FrfIApb5VAdvSyrEN5n?=
 =?us-ascii?Q?x1XbzSHh7oLWlt8AB10Z3Gd2B/rkonbGf4JMyW8wWVxiZw0W7ZIOD713Q416?=
 =?us-ascii?Q?WUFwtms9vPZd9RWpVhxF1/5okBvTenH9sBxOmbbNH3IKAWP0to8MvBao6SY1?=
 =?us-ascii?Q?ck+7bO0dwqmeGw14yfe52zhg4qF/8DfLRRn6llD9tCjD/A7eGhMh8ohp2hFV?=
 =?us-ascii?Q?EPiuCwZTtbTWpo/UQ+Tpv3aCoI81qLRewvXBVydvPDz5bW0wgBBx0TTc0UQJ?=
 =?us-ascii?Q?+6v0XKvrIciMKhNh9sJLTdkBsEt1iHr/rNeN6nu2XXmHw/gNMxr0U6WAOhXb?=
 =?us-ascii?Q?tmE8pOhoeP9NdYrM4M7n7fn69JxreDOnjJAW0k9L3DBsFvbmm63bq72YSEHi?=
 =?us-ascii?Q?bHWRTmIk8Zrk3j6zGIUnFcV38jEMLQKZ2dGKzsjFkYfvThobeYIIGgImMZ41?=
 =?us-ascii?Q?yjxpTP7srYOQ/c14yuUZ+H5LKr3YG5+042/oTJhmqXImJ1UYlz+dltTvZl6m?=
 =?us-ascii?Q?DVj9X8E/Z1UGHHDdD2Pylft4tkClEQsPiBtJCJ7xuMBWrFOabpgo8ac+tsXi?=
 =?us-ascii?Q?SSjwwr63VSgwIfISg/vtVS+obPRW/QF7oe9NsqigVYBfhp9XtxzW50O6RxdR?=
 =?us-ascii?Q?YO/wD2n1naTKqDYT9M5YeBOqRFmDF2dG+Wt8TJQIuu3kpd13LPFaAPDZYffw?=
 =?us-ascii?Q?gebsKtdSA4iwNrvx4D0q6gEiYBQxVmG0Urucni7Rf3P9rs+NuBm/7IeCEBNQ?=
 =?us-ascii?Q?wPiaK8+tF8awAykkqJATqY/NFpfrhRcb1nRlg/JhE2nW8+9ClySbyUzHb6Ck?=
 =?us-ascii?Q?U0soJ6iDtXUkhSiKkprxIDpzoxd/dl/aJuoqpSM5kS6jhTsT95XgOjWAjq9i?=
 =?us-ascii?Q?kuF6JYd7gIp7ZOEjQv24AmYlyXLaCY8aTUsPI004iu+Y5fYpWskwK2rtQLs0?=
 =?us-ascii?Q?f4yeAIdZtEJRxXkF8fmZLycjtklmGM5QeKLa6yaNsNHu2XNBOuSLEy3BUiA3?=
 =?us-ascii?Q?MwA+dzYI+sNI23pGnsiLF81zJ3sZGs4uU37mGU3CXPKwtk1g0oy8VIrmGdzo?=
 =?us-ascii?Q?AyNwCbbPizP0kxdFghV+/8GfPmUGOjX0tCOavygX4dB/GZa0lIY9og3oNjq9?=
 =?us-ascii?Q?H2Cnwy0cfnd8+JO3xe4ZQhkM6z6t3/SRMENIuvOrxsDuAxc+xMB4KBDMHgQW?=
 =?us-ascii?Q?qdxdxtmNF5gygz3JvNgmJOQF/EFHP8Ok90WbGYzCXDSjv62onSlJZXxGxf1W?=
 =?us-ascii?Q?AiGlkj9WsJgwbhDRfGfiaFA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJafFxyw22fyBcIw2V5HFRUBNZNBcscjaL5GHxON3Wqn9YgyM6OEqveww5oZUhc7pDlCay0WzH+bmOu+FJjEhFKiTefg7Lz6c8qauwVZ/KNWolmfv5EwFgSJzN+dGF6hXsL9NvkeaPdHXj/9nIW9JwNHaTzaFRoijtQAXck1v+JKt7N5aOuqr2PcdpCP6oe+ZmflKX3MjgytyI8xnNMTvrCmlPLwPgUaHI0GHnAvFMDrGc4hF3Td3bwplNL5EmcfJPuuOyzlHyGyd40TgtwYRvgG85dLnvZ0M+nnmYSlx6GFrbZAg1ZkvY+6szm6M5KR3Y/TtO6ntlNxdlWz0YLV5RRXFd0iodry3X/d4Yd02YYvIMoBehso7kDXPhgxO+8vAF+nt1IFlOYLCUg9M5TLadCt3udwlKMRWvve07b25uCQzpdCiioqb3Xv2C2A/Ois5MMHrWXj04k+Yj5JvfRdwvTSFl5BlReV1ujCeAod9dUOZJ1nXu732FePQAU1H2YnPQW/5y779H682mNXgrkKjY+eMpfpCGnq8s0CTQ4NmFj3bkA/s9P/n29iqp/K0YqK9XrXjcs1NfUG2Qjdq1YfjeC2lO0RL6nHa80eunoW5BM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd03446-b67c-4565-cde0-08dce3d0e0c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 17:29:04.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkOCsfJOe/5MnlVE/xqHvTSkJlQ0BXLufZM1NVX/oW3AcNiAIspwV9nrN015sb6un8jpVo8DZdR4GsbPZfNuBk9PgX3GUL/G15iOh2VwNMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_15,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030125
X-Proofpoint-GUID: kuFIzEI5z39t0Tribl-WEj9oIpfd4kyu
X-Proofpoint-ORIG-GUID: kuFIzEI5z39t0Tribl-WEj9oIpfd4kyu

Alan Maguire <alan.maguire@oracle.com> writes:
> On 03/10/2024 00:52, Stephen Brennan wrote:
>> Currently we maintain one buffer of DATASEC entries that describe the
>> offsets for variables in the percpu ELF section. In order to make it
>> possible to output all global variables, we'll need to output a DATASEC
>> for each ELF section containing variables, and we'll need to control
>> whether or not to encode variables on a per-section basis.
>> 
>> With this change, the ability to emit VARs from multiple sections is
>> technically present, but not enabled, so pahole still only emits percpu
>> variables. A subsequent change will enable emitting all global
>> variables.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> Some questions about shndx handling, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
>> ---
>>  btf_encoder.c | 90 ++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 56 insertions(+), 34 deletions(-)
>> 
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 1872e00..2fd1648 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -98,6 +98,8 @@ struct elf_secinfo {
>>  	const char *name;
>>  	uint64_t    sz;
>>  	uint32_t    type;
>> +	bool        include;
>> +	struct gobuffer secinfo;
>>  };
>>  
>>  /*
>> @@ -107,7 +109,6 @@ struct btf_encoder {
>>  	struct list_head  node;
>>  	struct btf        *btf;
>>  	struct cu         *cu;
>> -	struct gobuffer   percpu_secinfo;
>>  	const char	  *source_filename;
>>  	const char	  *filename;
>>  	struct elf_symtab *symtab;
>> @@ -124,7 +125,6 @@ struct btf_encoder {
>>  	uint32_t	  array_index_id;
>>  	struct elf_secinfo *secinfo;
>>  	size_t             seccnt;
>> -	size_t             percpu_shndx;
>
> heh, ignore my earlier gripes about the type here since it's being
> removed now!
>
>>  	int                encode_vars;
>>  	struct {
>>  		struct elf_function *entries;
>> @@ -784,46 +784,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>>  	return id;
>>  }
>>  
>> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
>> -				     uint32_t offset, uint32_t size)
>> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, size_t shndx,
>> +					    uint32_t type, uint32_t offset, uint32_t size)
>>  {
>>  	struct btf_var_secinfo si = {
>>  		.type = type,
>>  		.offset = offset,
>>  		.size = size,
>>  	};
>> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
>> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>>  }
>>  
>>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
>> -	size_t sz = gobuffer__size(var_secinfo_buf);
>> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> -	uint32_t type_id;
>> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> -	int32_t i, id;
>> -	struct btf_var_secinfo *vsi;
>> -
>> +	size_t shndx;
>>  	if (encoder == other)
>>  		return 0;
>>  
>>  	btf_encoder__add_saved_funcs(other);
>>  
>> -	for (i = 0; i < nr_var_secinfo; i++) {
>> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
>> -		if (id < 0)
>> -			return id;
>> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
>
> can't we start from 1 here since the first section is SHT_NULL?

Yeah, we're starting from 1 elsewhere, so I think all the other loops
should do so. Otherwise it's inconsistent. Nice catch, thanks!

Stephen

>> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
>> +		size_t sz = gobuffer__size(var_secinfo_buf);
>> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> +		uint32_t type_id;
>> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
>> +		int32_t i, id;
>> +		struct btf_var_secinfo *vsi;
>> +
>> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
>> +			fprintf(stderr, "mismatched ELF sections at index %zu: \"%s\", \"%s\"\n",
>> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
>> +			return -1;
>> +		}
>> +
>> +		for (i = 0; i < nr_var_secinfo; i++) {
>> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
>> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
>> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
>> +			if (id < 0)
>> +				return id;
>> +		}
>>  	}
>>  
>>  	return btf__add_btf(encoder->btf, other->btf);
>>  }
>>  
>> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
>> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_t shndx)
>>  {
>> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
>> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
>> +	const char *section_name = encoder->secinfo[shndx].name;
>>  	struct btf *btf = encoder->btf;
>>  	size_t sz = gobuffer__size(var_secinfo_buf);
>>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
>> @@ -2032,12 +2042,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>>  {
>>  	bool should_tag_kfuncs;
>>  	int err;
>> +	size_t shndx;
>>  
>>  	/* for single-threaded case, saved funcs are added here */
>>  	btf_encoder__add_saved_funcs(encoder);
>>  
>> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
>> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
>> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>
> same question here for 0 shndx
>
>
>> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
>> +			btf_encoder__add_datasec(encoder, shndx);
>>  
>>  	/* Empty file, nothing to do, so... done! */
>>  	if (btf__type_cnt(encoder->btf) == 1)
>> @@ -2167,7 +2179,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  	struct tag *pos;
>>  	int err = -1;
>>  
>> -	if (encoder->percpu_shndx == 0 || !encoder->symtab)
>> +	if (!encoder->symtab)
>>  		return 0;
>>  
>>  	if (encoder->verbose)
>> @@ -2180,6 +2192,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		struct llvm_annotation *annot;
>>  		const struct tag *tag;
>>  		size_t shndx, size;
>> +		struct elf_secinfo *sec = NULL;
>>  		uint64_t addr;
>>  		int id;
>>  
>> @@ -2211,7 +2224,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  
>>  		/* Get the ELF section info for the variable */
>>  		shndx = get_elf_section(encoder, addr);
>> -		if (shndx != encoder->percpu_shndx)
>> +		if (shndx >= 0 && shndx < encoder->seccnt)
>> +			sec = &encoder->secinfo[shndx];
>> +		if (!sec || !sec->include)
>>  			continue;
>>  
>>  		/* Convert addr to section relative */
>> @@ -2252,7 +2267,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		size = tag__size(tag, cu);
>>  		if (size == 0 || size > UINT32_MAX) {
>>  			if (encoder->verbose)
>> -				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
>> +				fprintf(stderr, "Ignoring %s-sized variable '%s'...\n",
>>  					size == 0 ? "zero" : "over", name);
>>  			continue;
>>  		}
>> @@ -2289,13 +2304,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  		}
>>  
>>  		/*
>> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
>> -		 * encoder->types later when we add BTF_VAR_DATASEC.
>> +		 * Add the variable to the secinfo for the section it appears in.
>> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
>> +		 * an encoded variable.
>>  		 */
>> -		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
>> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, (uint32_t)addr, (uint32_t)size);
>>  		if (id < 0) {
>>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
>> -			        name, addr);
>> +				name, addr);
>>  			goto out;
>>  		}
>>  	}
>> @@ -2373,6 +2389,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			goto out_delete;
>>  		}
>>  
>> +		bool found_percpu = false;
>>  		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
>>  			const char *secname = NULL;
>>  			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
>> @@ -2383,11 +2400,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>  			encoder->secinfo[shndx].name = secname;
>>  			encoder->secinfo[shndx].type = shdr.sh_type;
>>  
>> -			if (strcmp(secname, PERCPU_SECTION) == 0)
>> -				encoder->percpu_shndx = shndx;
>> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
>> +				found_percpu = true;
>> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
>> +					encoder->secinfo[shndx].include = true;
>> +			}
>>  		}
>>  
>> -		if (!encoder->percpu_shndx && encoder->verbose)
>> +		if (!found_percpu && encoder->verbose)
>>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>  
>>  		if (btf_encoder__collect_symbols(encoder))
>> @@ -2415,12 +2435,14 @@ void btf_encoder__delete_func(struct elf_function *func)
>>  void btf_encoder__delete(struct btf_encoder *encoder)
>>  {
>>  	int i;
>> +	size_t shndx;
>>  
>>  	if (encoder == NULL)
>>  		return;
>>  
>>  	btf_encoders__delete(encoder);
>> -	__gobuffer__delete(&encoder->percpu_secinfo);
>> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>> +		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
>>  	zfree(&encoder->filename);
>>  	zfree(&encoder->source_filename);
>>  	btf__free(encoder->btf);

