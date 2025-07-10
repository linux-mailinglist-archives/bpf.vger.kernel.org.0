Return-Path: <bpf+bounces-62924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98354B00623
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AC3481510
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D164B2749CF;
	Thu, 10 Jul 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyuIMIoa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="glqcar6i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58F274678;
	Thu, 10 Jul 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160228; cv=fail; b=QYQ2Y19c3tErfoEQCL0pF22Fv6ySngylsUf7CZW5uJU5/0MgqJhMgPQtQAWJ+z7bbbFkdmoGpi1sZ84HjXEB39XJwXw6sNYUyDIkcmamB/dPmd2nXo/og/XN4n0GQ6TqsOXKnmKsrubk37h9Xuo7xmIrEc2jHByIcdZSfocnqQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160228; c=relaxed/simple;
	bh=jCMdCN5+RRcFEZlRWbO45oy+8ngwux+92Xum4axsYT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=py/CwCX9JGzLh0S9WR/HuioQYTTWOWBT5mX3GRvUdWAcj/70AmtmPNy0h36PjrNiVS9puS2k7W+KozfBwFfi4eFgLxAslVcNysbFeitEQYoIbA9CC8zYtOFLimphuTUEzHROVTVdWSCZMKD4vGujyn1A2tmGlzkbXzLGkrKdo34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nyuIMIoa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=glqcar6i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEv9kr015221;
	Thu, 10 Jul 2025 15:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ycprmu5WGBzanHqBJZ5y960bvhmb5qjxNACvdzyfQzQ=; b=
	nyuIMIoaXJlrcxDe1zS/hiPe5DZfHbOu7OiokE3kEH4quNBo+ZLPs56s+KHi2LWB
	lSsW7nRsiojh/Onfl2yhr1tjos5wYi00mB4xC9zZOC2/nk2bCMgNSfXauva3PNLZ
	ks+S6/HtCqmf1PDR3oLEsjM3xeCKRL3r1BPsRLUSdqBWxeqqiSfmLiM5FRP3UtjC
	6zjywxb9TkpFKDnF5OuHbv1l9AAO4dr+wv57X9KBgUGPJNhOUpPighPdVpABl16A
	Z5vmFSJ5Ulwy/nKpbIlhZwCYAhOfXtHDYQfVwKcczPbLZ9LaX9E3M7OUHWRi6eCU
	vAj1IT1bUIdstFIZpR/lpg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfqsr14u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:09:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF2jOI027257;
	Thu, 10 Jul 2025 15:09:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcdcb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7VN/wwHl7y0cR0B4a13CET7KBc2bPu3O5EKtBZL2Hpk/yjBPGyAjfXbWr1T096poVStCUKD+AAdV6zEo7hUqZjdjgUVussD4zDVokhZrLCU+t4jRvTWny2n2UKkOy91aQfN8pJS2P1X3dg2gfz9NOIKB/3coMxJEmzm3+p3vVwtEaXbCeMmUa+u9QKdkOzCN89uV9XriAz/1Bm97brXP0f4fzreExB7dbNm9J7oxSUdwKZEWlAk6GLv0jpRYbKGwT1cl3BZngxThc8xkIEZ/LYXx1fS14Omc/KfW7Nwd97TQEXZXQHaYmri4ZU19IzDNDXSWTkvDoOADroQa45Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ycprmu5WGBzanHqBJZ5y960bvhmb5qjxNACvdzyfQzQ=;
 b=ytHZZxLFGuzB5e4g39IrqXK7KZQFa9yI/g+xOCKuQeBTiC5MkekQHPntmQA6MP7YHjlQG0TstqbaDESifUy/xyaERPETn1ULMh2cgPn+qyqq3AxCTE+hvp3JWXa/OJ6J3kpHiKyQNMaWn6cMBY5LL//U9DVakBnVFQdlheFGHqxLSJtQbM7T5Z3bfdJZKM9lK+6jpdtlGqrf0wR+177viaqQx25J4zihvYhDE5O+RLvQ/lWWtTQUdtzRKl5BN+5HvRErxYCGu3U6B7YohGyuEWwESgJX9AbAwSa7NC+/aDsk1+C4tgEjNtHQNLLSyZwcd6Lj0qulkAzgmS+qXs9cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ycprmu5WGBzanHqBJZ5y960bvhmb5qjxNACvdzyfQzQ=;
 b=glqcar6imI4kPev5CAG9fw1Mvt7FXDXEeuYIyjpuiZtzPf6I4jsPm9J9OD+FecCGnnBhJ6xiSR9oZgcdOjBa4fL3U8L25ojm/+cqvTwlCSxRVcUFh6jWJpbXMjqZVY2IrOz6zfrqt5gtlB38mLnhnSqnWEILrdYahgbcyEIRI6Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PPF0AF60B9AF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 10 Jul
 2025 15:09:45 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Thu, 10 Jul 2025
 15:09:45 +0000
Date: Thu, 10 Jul 2025 11:09:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <3ohcdmztpnxuxhsp23ixpu4kfctbuqju7ju2oykeficsumtyqo@etxvrmrhxvue>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
 <D0D76B82-E390-498E-AE84-1B2CA6C0F809@konsulko.se>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D0D76B82-E390-498E-AE84-1B2CA6C0F809@konsulko.se>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PPF0AF60B9AF:EE_
X-MS-Office365-Filtering-Correlation-Id: a13c3059-8fa3-4fd3-48b0-08ddbfc3cdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWE2cGtEZzlXd0p3YXJhQlpWVldNRDVlNkFLWC9JQVVmT1lkcVRaUVRMaUJj?=
 =?utf-8?B?b3B5V0U5Wm1WeGRyWXZ3VDV0R2ZOaGN1RWdKZml6N1dSaWRsK2YyMzdVYUUx?=
 =?utf-8?B?bkRiT2hMRUM2TGlTdHFpR3FJbk9LbFdtZkJNc0VKY0pkQ2trMS9raDV2N2pI?=
 =?utf-8?B?bmlZVm85bUpidXFJQjJIQm0wTFFaRkFoYWRmblRNYkV3L1YvMW1ZaVNyWFFC?=
 =?utf-8?B?S3BXVzAxT1JRNFFjdmN0SEV0elpsaHptRy9LUkVyK2dUNTFRTm9lZnlLeGFv?=
 =?utf-8?B?SUlOd3lOazVGS2trOUptTWJIbmx5NFpmUjhJRjk5WGthd3BNb1kzSzhUazlL?=
 =?utf-8?B?bTNRYkFkMzMycTZ6Q0NFNG96WVpGbTdPbFZVYTVQcXpGWE5KWTdJdUp0N0hC?=
 =?utf-8?B?MGt2RmhZVDlXcCtYRHlFdk5qQ01tdVpzaFN0UHZncUxCWFVmd2JTd0dqenVS?=
 =?utf-8?B?S1paS2hmZmtGeTd6M2FmZDhRTUsrN2NYc1p1dUVVbWVxRG9YTm9VZHFJclhs?=
 =?utf-8?B?WlBoWU9FdFBjaUJGREhnOGVaQ1U1TTBXS3NpUDd3Ui9tVUdSblMxa0dNYjM0?=
 =?utf-8?B?RUdET0pzMHJqTS9wZ0NBSFViK3JFc01QYURtQVBzVWtIYVh0OUtBVi8yVncw?=
 =?utf-8?B?S2RYaXlsbEpmMFNWUmpEeExwZ2hNc2p1WS9SOGk2VXNFWjRoMTFrQXV6anNS?=
 =?utf-8?B?SnRwYjlZMnZzaG1CRjNydGROdVgvZzVsUjI2dGl5THZ2Z0lqTWp6T01Ub2Rw?=
 =?utf-8?B?bkxvSFRlaEV2dEZjTXo3MGtjdjdMb29vcDBlc2JsQUhKNS9pMFBxNEZVVEpi?=
 =?utf-8?B?dGY4aExmNWZrNUpmeU5uM1RoQ0hpbUJHKzZFVVVGNERVTTdLVDZKVUJiMW9G?=
 =?utf-8?B?QWJtQks3YjArUzQvZDdRQ3ZWODE1bUFMY3hlSFNqNVh1bllHa2dSOUZjS0l0?=
 =?utf-8?B?MVB0RHZvY3htNFZwZ2FFRWs4UWx1K08xMWhUTWFLMUhHN3RaVnNjd1RXWk4v?=
 =?utf-8?B?ZlZ1TjVsTGdKaTVjTWdKMEhQeDQ3T01xay9uRGRFN3F2UkZDSVA4TC8vTnBx?=
 =?utf-8?B?T1lsL09MS1dKMUg2QzJaemFKQVNtVjJES1QxMlpDSFhnUE91bEpYVzNQY2FQ?=
 =?utf-8?B?Z1g3dDh0Vkw0NzlncDJPUXRpcllleEFBdGRmZks4UWxhY3I2NE93UmIxN1Ny?=
 =?utf-8?B?QXFpS203RCs5S25YdGhBZWZSdWV5NDV4dnZFSnRZa0FRZWYvV1RHREdEQk9X?=
 =?utf-8?B?VitFV1dNSHpXVkhpT1g2ekN0WlRmYlM4NWIxYmJhaDdzamI4MEM2S2t1ZU02?=
 =?utf-8?B?UjRmNWRkY2ZuVkpsemhUb3pDR3cwNHU5Zys4WTFoaXArRjZyVEszSlZNcXlv?=
 =?utf-8?B?NG1JMGNMajZrZTBiOGdkZWFXV3hLbWFyQ3lwS3BuKzJYa1pBSTRVSE1KN0Zv?=
 =?utf-8?B?VDJ2L1IyRUQ3ajJzM2I2YU1FV2NjaXdLazkwbWszZGtrazA5b0djS0ZNaktX?=
 =?utf-8?B?ZTJzenM2NEdMRXlaWlR1OTNTdnJTeTFEb1AyNUplZUVRRTI2SkRGTEhLVVMx?=
 =?utf-8?B?dXh1VG1QMms0UDVsK01CbEFiaTdYM2xScEt4L01YVWgrS3BLeTdBRUR5ZFF4?=
 =?utf-8?B?alBZd29rNjBHS01sMGxGNWMyN08rblVhaC92cENFWGlCWE53cHgwR2tCbFhN?=
 =?utf-8?B?Z0MzbjN6RTgvZGU5ekhTL3c3YjZJdm1MdmRPRURKTHBjYlc5dzZJdEhWZE5i?=
 =?utf-8?B?OWN4a1d0RWthVkZiYUZCNTNHNHB3QjF1UWdzSHIxR01OeWlYUHhhNTZPaVdX?=
 =?utf-8?B?NnZIOTNFaVg2TEI4K2hpL2x5Zmd1QzE3VnNnVDhmais5elNPK2IxbEJITTJZ?=
 =?utf-8?B?alh3aUJFS0tpVjlsL1FTZU9xeVg0bjNiUS84QWNqamJ5UDFBR0JIZE41dy9X?=
 =?utf-8?Q?SlnXNa9bXeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2JUQkIxNVZ0UWc3V3ZmNVlpaWx3eURwclBNT25lb2dBMjZoWXJMUVJxT3kr?=
 =?utf-8?B?R2RpV0oxMWtEZWtNOVNqQkw2cHhXeDVRWEF4ODJ3L2pUN2FnMU1wck5CWkhW?=
 =?utf-8?B?UkRQVnVWVm9iQmhmMG8zN2lSNC9uek96WGlEbkJNRmpaT0EwN29Jd2hSNzBt?=
 =?utf-8?B?bGxuUG1xU0F6QUJNeDhPZFhPWEZmZHlzdDBsdHpJZEppc2JjWERQUExOK3NR?=
 =?utf-8?B?WURjYmhBT3lwVi9GcHNPbjFLK3dObWRZWFVuY1F5WGNSV2hya3hvVXlHZkE4?=
 =?utf-8?B?TndoaGJwb3p3aGRMZ0w5dlU1TFYrdUI5WHJvZW1SMFF1TVdRVXYxRHY4VjFu?=
 =?utf-8?B?VFhJLzRudUtjVmc4WWMwclBydmdHemJnNUVCaTJaMEFyeXNmSDlKWkc0dklz?=
 =?utf-8?B?dllmbGppNGsxMzBvNjJNSjRoZ2R6TmdWSDEzS2IwKzYvU0hFMmppbjVyUjMx?=
 =?utf-8?B?aEkrOFRkcGlJRzFXbWVDaFFuWThIdXhJU2xjeGZQYldJREtqWmoyTFpXSzRh?=
 =?utf-8?B?STUvaTdhZ1dRU1hBM1NSOG1wdS9HYnk0T25MdHp4THl6TElqeWk2Vm5zOVJr?=
 =?utf-8?B?S0lQZUlVb20ydHY4QkNHdGVNU21adXZEZU5Qb0owY1RyNTlxbVAyM0E1cVov?=
 =?utf-8?B?aTZMTEsrYU5WWXgzMUxyUFBCbnFzVlFDRm91TVBkRk9SZzlnNWJ2M2lsNC9E?=
 =?utf-8?B?cFdqWmZMZVFUK0o5b3M1ejVITDQyRzVQemZvUnBDZnl5TlFxNGdJMlEwQUIw?=
 =?utf-8?B?SmMzUTNHMkxpdmsxUFRoVDBsYi9LMTA1QVROQk8rNDhFS0NtMGpidFFGdW1U?=
 =?utf-8?B?d25DWEdhVmorNUlVL1FmS2RROHVZUC90bFRGQ3BrVUp6elFremJwaDFURXE1?=
 =?utf-8?B?YnF1RmlLUklQRmFTbmpwSk5ORkVaVVhxRDJHU0o5ZDBUVHhSd0J5bktMNGg1?=
 =?utf-8?B?RGNmM2pCTXFWMVpnczlvN0Q2Um9XeFowSngwYXdCNkpnaklreXpGVHAzZWIz?=
 =?utf-8?B?RlI3N093RW1ta29vd1Q1dkR3bVJTd3FWVjhFQytpS1RVZXdpcnFINTllcjNK?=
 =?utf-8?B?WW5NQ2oxRnBTRUZyKzd3ZWxaaFdycGZiV2FlWlJvZjBDOG9JdHRRM2Y2amN5?=
 =?utf-8?B?cmV2VnpFcFptZjd4MXN4eU9RTjZlZVo3N0NUa3dNRE4wT1VFTEJGOHlTLzRO?=
 =?utf-8?B?V3RQb3pkbU1wOG5LdDBkR0Z1YWwrdTJ1NkVkMlIvSGNmQUk2TFgva3VjRWE2?=
 =?utf-8?B?UnBac3hFZHl5V0V3U1hTdTMvZnQxVDFhM3I4VzVob2U3UHV2blVBRXl6ZXNn?=
 =?utf-8?B?YXNHQ0NqQ3VRN2owOXl1MEIwQnVhUG92TWRDbUI0L0NxSzB0NCtPTWRoTndz?=
 =?utf-8?B?SGZ1bDVlbldWMkZCeExjNEV5djU1UUU0OHhFazFaMXE4VzQxcm93N0pWbUM0?=
 =?utf-8?B?V29pbWxqSHB4amU1aXRzNTNud0dxK0FwaEx1V1VXcjlWNWVyNCtaTzVCNGhw?=
 =?utf-8?B?Z2EzSkg5N0NoOWdvbWUwSkFHN1h5QUdEL2FuR0FWaHl2SlpYNXhwNVVxQnM4?=
 =?utf-8?B?U2E3VTVTNzVVbTdBMmh3cmJpaERwQUgwMnNtV0lHYU9rdDRlUGVpOEZRL0Iz?=
 =?utf-8?B?MDh2ckZrNDBjbDFuVFNhcURRTHNIa0NxZWF5N1lta3NlM2hpRStUNHFJbTBP?=
 =?utf-8?B?VlY1OGJEQWxXcUd6YlBJd0VGT28yWWlTbmZZcTdKZVc3UVlYdWR1K3Z5SmNt?=
 =?utf-8?B?aHhxamJrbkxUY2d1eHh0eHRrREtyT0JHMEdIYnl3ZVZ0NGwyRHU0eSt0RWR5?=
 =?utf-8?B?d01BMVRPTGZ3Mmk4Z2w5OWM3dGdKMWlJeTgvWG1ndUVhbm5RUklGNFFXaTU1?=
 =?utf-8?B?QUd1anpKcmJEL28xV0FJeUIrSnZIMURWL0c3a0E4dk1YWmRBc3NySUMxU1hB?=
 =?utf-8?B?eFgrZjRpeStOZm5QZTltMklicjdWeG5VUVlyZHFYSjErSUcram9sTThucUxm?=
 =?utf-8?B?R1dGTURSdUF3aWpCUTFWb2RJOTE3Z2dNc0k3SWlLVjNzR2RHMmhkZjdnbnhy?=
 =?utf-8?B?VEhja3lzREdUUU9rTE00OFlINU83bTlrZU1jc3ZCRWtDcUVWbUxuZVlCeEkz?=
 =?utf-8?Q?4uTuz40ujga0bKsLj2YAoNJo7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WqWUb3cZmyWq4HggJyn0VluZYIx2NeJ2BS/E0VMc7l7UpDoM6/yiLvQaQZEewO+u5y7QCMfariRwZnZOAtvvw+jFeIkWORZBGQrdEXtqT5YVfufEWz6hABWVu2QzHrg75Xy3+tU8Zv7xXxWvr1ig7C2DQ5G6Jn4rSByu+dK8fXc0zrJOcPz065nvLpW472nD53nepFuVLGn6KmcxDIM0hfn6JU1pcZylEZ2nclk9uv3smmclhIanwVXilDhRF08Ql9L9Wy6B8Qr6vWcPJ9kWX0UMlCgaaiBHvyZmshNIbr6R8954X/CxOeVvRbnDitdhFWW6hMBUZAXxK3pdsZZ5bMz5HFC7DtEOZsmobGzZltgQedkZYcoP+Jb/mN8Diy2cPgdVJD+dyWlBS+8G9fPbEvUIv55eINOO446RiKHMA0D+EvVOtU5h3HvEj15eoJGW+coVZyZa3jdF28DkOABGOY/9ft3pyq6m69xurLi/Oybj70CtVyVergVljEjC1oBOIQsa+suPveg7zSFPC6mDPTP7fHRfDX1Rx5GtHheQDMuS7yGVaL/ZEz4LCZyFfOnOOVbW6B31vbC3hW5glxuAy/L6QpvfsQ3b9HCn4+jHzmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c3059-8fa3-4fd3-48b0-08ddbfc3cdbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:09:45.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEzxmL/YmOZnieQOfA01iWSiqbM0O6f5+T5RfQ8OhVeYtF02HMkZOiok7YpOjL0583+1LGoQdLGHSOIeadgiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0AF60B9AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100130
X-Proofpoint-GUID: JommgIjOUFQN91fKVE5bN408SD0j72pP
X-Proofpoint-ORIG-GUID: JommgIjOUFQN91fKVE5bN408SD0j72pP
X-Authority-Analysis: v=2.4 cv=OvNPyz/t c=1 sm=1 tr=0 ts=686fd7bd b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=WicMf2zBfVUbSQQ01gUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMCBTYWx0ZWRfXzZ2k88GXG1oy nt6iFrC9vc4qjzs/uvMFvbN1bjj0FMmAx0uo05HY/Alx9ey3khQTYegCxrNL/g6+G9Xc+uwM/OI QzPbGwXjKA5lmPN9cDneuLRHKKJzfcAwD1P/xOqbbSi+JtdhALlz66lW1d3ulFCzEl0AQb04oNY
 5sziFMw/r7OJeeEbaRT8Bb1UQ4zFyL55A9qFmPkf9cIrHIpdirzqtE7b8l6MbZOkZs94L3fDgoc qPbZeHfNKSejCn2aDT1FDcKQbyjRz7sBl5K6jTSHVnq27i9gR05UaBU1Co/YM7z+WNJ3V5yGvas fmqT5t5ao4jmdZL27ZoqdA0Y7O3UWXrYkPXqbkp91DbMpkk+Q7dekFPjo4fOD9XYdpJrtAyUq77
 gC8fCsOTCtzGqAO+pWz29ovmAcOzSi1PLsGQfOtL6NnDmBnGNLGLGfih5ziUiE/J/sOtnsso

* Vitaly Wool <vitaly.wool@konsulko.se> [250710 02:21]:
>=20
>=20
> > On Jul 9, 2025, at 9:01=E2=80=AFPM, Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> >=20
> > * Vitaly Wool <vitaly.wool@konsulko.se <mailto:vitaly.wool@konsulko.se>=
> [250709 13:24]:
> >> Reimplement vrealloc() to be able to set node and alignment should
> >> a user need to do so. Rename the function to vrealloc_node_align()
> >> to better match what it actually does now and introduce macros for
> >> vrealloc() and friends for backward compatibility.
> >>=20
> >> With that change we also provide the ability for the Rust part of
> >> the kernel to set node and alignment in its allocations.
> >>=20
> >> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> >> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> include/linux/vmalloc.h | 12 +++++++++---
> >> mm/nommu.c              |  3 ++-
> >> mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
> >> 3 files changed, 37 insertions(+), 9 deletions(-)
> >>=20
> > ...
> >=20
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 6dbcdceecae1..03dd06097b25 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long size, =
int node)
> >> EXPORT_SYMBOL(vzalloc_node_noprof);
> >>=20
> >> /**
> >> - * vrealloc - reallocate virtually contiguous memory; contents remain=
 unchanged
> >> + * vrealloc_node_align_noprof - reallocate virtually contiguous memor=
y; contents
> >> + * remain unchanged
> >>  * @p: object to reallocate memory for
> >>  * @size: the size to reallocate
> >> + * @align: requested alignment
> >>  * @flags: the flags for the page level allocator
> >> + * @nid: node number of the target node
> >> + *
> >> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). If =
@size is
> >> + * 0 and @p is not a %NULL pointer, the object pointed to is freed.
> >>  *
> >> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @siz=
e is 0 and
> >> - * @p is not a %NULL pointer, the object pointed to is freed.
> >> + * if @nid is not NUMA_NO_NODE, this function will try to allocate me=
mory on
> >> + * the given node. If reallocation is not necessary (e. g. the new si=
ze is less
> >> + * than the current allocated size), the current allocation will be p=
reserved
> >> + * unless __GFP_THISNODE is set. In the latter case a new allocation =
on the
> >> + * requested node will be attempted.
> >=20
> > I am having a very hard time understanding what you mean here.  What is
> > the latter case?
> >=20
> > If @nis is !NUMA_NO_NODE, the allocation will be attempted on the given
> > node.  Then things sort of get confusing.  What is the latter case?
>=20
> The latter case is __GFP_THISNODE present in flags. That=E2=80=99s the la=
test if-clause in this paragraph.
> >=20
> >>  *
> >>  * If __GFP_ZERO logic is requested, callers must ensure that, startin=
g with the
> >>  * initial memory allocation, every subsequent call to this API for th=
e same
> >>  * memory allocation is flagged with __GFP_ZERO. Otherwise, it is poss=
ible that
> >>  * __GFP_ZERO is not fully honored by this API.
> >>  *
> >> + * If the requested alignment is bigger than the one the *existing* a=
llocation
> >> + * has, this function will fail.
> >> + *
> >=20
> > It might be better to say something like:
> > Requesting an alignment that is bigger than the alignment of the
> > *existing* allocation will fail.
> >=20
>=20
> The whole function description in fact consists of several if-clauses (so=
me of which are nested) so I am just following the pattern here.
>=20

I'm not trying to be difficult but I am trying to nicely say that this
is a mess of words.  It's easier to just go find the code and try and
figure out what is going on instead of decoding what is written in the
description.

The pattern garbage.  I was trying to tell you this nicely, but your
change is better left undocumented than to add the above description.

The wording here is difficult to follow for a native English speaker.

You don't have to keep stating "this function", that wasn't part of the
pattern.

There are too many unnecessary negative statements "if @nis is not
NUMA_NO_NODE" or "if reallocation is not necessary".

The commas indicate that you can rewrite the sentences to be more clear
by stating the facts up front.

Stating "the latter case" is a barrier to non-native English speakers
and is unclear when you have multiple statements crammed into the
preceding sentence.

And it's easy to fix, but apparently you don't want to change it and
would rather follow a broken pattern?

Regards,
Liam



