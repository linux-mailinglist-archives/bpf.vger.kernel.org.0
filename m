Return-Path: <bpf+bounces-63033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA743B0172A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DD33A5CE8
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20A21C18E;
	Fri, 11 Jul 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkbQmkm5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zt8e2Mgf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6B1B3925;
	Fri, 11 Jul 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224732; cv=fail; b=kZaFcO0BcoqlpxS+JC6LR/H1jxq4NstHW8UfBXEQSJovLQK7ws3GWWLJl85/Ixz8qDdyHyEu0zGXY5kGk3ygV+962LuBg6cppzAwM6PWb7XG9bElmxa7PCXG1C6wTB3olT2emR8emDp+5OHEvOL7AWWVoiaCNRHG+g8lSa88rCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224732; c=relaxed/simple;
	bh=eFep/aUFHc7IWOIaPuLCLzFzPSFkJkelgUv/kOYhm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hkl9S36YLN0AH8/3BLJ+nZ6Nez4n1078vRWfymhNWa/hWT5T7etKjOmX0gxuFhCLtlW8rGU1CSS2hpKTWqs3oHCUksidTLMp1L5BgG5xBzLzuygWq9HhLzZ6zMISnnwVqhLBRnCacqPo9pm+kNYncsGMB9MJQYzz9InwBFrhy4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkbQmkm5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zt8e2Mgf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8kx6G028731;
	Fri, 11 Jul 2025 09:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5g3Y10QlO9IVhHk7/s
	9u/lhmhUoCeyl8CnpP+TzQ5Ck=; b=LkbQmkm57YJmf7Iu8FVSiYNk1QjcIkZulT
	MBeWjXfohk0s4+GgDeRRg1j5UfO8Eq6DH0snIGP64IOA+pr1IiDYLaw3x04bn75J
	FChcw8PrQFxvRHbGTOn2AFwx0AXmglPf5STLxE0aaZ54hRSahYDm+jQ7zctLrVlv
	D09V57MtOrjZQ2VdTWqH+9GaJLG9jx5PNWAu6que7sUY91ooiDlpzDkN77HqM0pC
	Tc9XCAXjD/hQg9WR3y/hrKnjVYD89z03Eu1Zf5cL8Z3urAgN0y7suLSMPsbhK3So
	P+6EOf/uiqtFYV5U/CGT3o6+qPBZVE6VD58HXyNFJ7vIWG0o+Z7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tyd9r0mb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 09:05:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B75ZQE040420;
	Fri, 11 Jul 2025 08:58:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdjc5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzHnzMQsSQTmnXBAdAboc7MfjSo0a5aNrdX1ZQj3M2wBbCyW3+8TVnxqzcMJi+V1tbUGyxXDssOVIgCEFtqFo4AXhLd8PtOxhxSe6iXuvaPKFelWIbu7uuYxNsGZVD9kfnTKyo+TkGXkFB3Y/pNlT05nNLjU/TtuOIXrO0G+AF+NLa6QBGmdjGZWzbKk6yJO8UZNIqKciH7OzpVr9T+TwXwIg6AtyhZ8JFPed73S7dR0DM30VdmOwrPGeFxZ1Wo44yUlu2mzoy/13pkhfhawOiYiBJyoLWEKKII0VPsXhaW6Cl3/h8umOSGnsT6c3XN3HsRRIaF8cd53nmsgrg0jlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g3Y10QlO9IVhHk7/s9u/lhmhUoCeyl8CnpP+TzQ5Ck=;
 b=lvtM8uX3/5w1g3rGbkSeV1oJ+k0BQHYJ4cq2IyGGoet+julLtFd222A59Rv4HnKUXNCm9HDSk9AI9QwQP77MYyDZbqOPLqcUNE/VJrZQhttuT6g8cEfA2vsS14tVn/Ul8SY5eMaSQDfpQ5UIVsEfNOwm87pv+elbIuoyIZKX+tmnVkWhWwaPfzXo5nJ0KXoVkOVDjenAi0McSdIkg7QT2P+o12M5pCsHkoXHOruMqUu9vrH9jGC4w8/MkAJQT3c1liOn0vaYIXR6uVBZY5E1Ml49WmaMptJ83ZSf51NbLfSBwgrfc5QNYLBmvHsfxI+swZmANRzSuU+pLUUOnIC9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g3Y10QlO9IVhHk7/s9u/lhmhUoCeyl8CnpP+TzQ5Ck=;
 b=zt8e2Mgf9/0XGrAsPrvxnqcmCtIYsmTivXQ3zIa44KcVhfc0Rq7xnrfclxytSnXC9leZS8y7T90POINLgOl+IX14oNfgurYQNKkJfvRSPFPUH/4hbu8S3GcVCgADUf5tpAx59ZiDRlT2te5t2InfM3DAXfhY0x3vV5UTFyA+fFw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 08:58:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 08:58:51 +0000
Date: Fri, 11 Jul 2025 17:58:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Message-ID: <aHDSLyHZ8b1ELeWe@hyeyoo>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709172441.1032006-1-vitaly.wool@konsulko.se>
X-ClientProxiedBy: SE2P216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 557c2a77-fd84-4e83-22ec-08ddc0592835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whxVKpTgUXJalD//eLts6MZ2qKM4zaZvVLN+clE/NSB0ejJHwHjOxLwRyHz+?=
 =?us-ascii?Q?39ISC7iYrGAvP+SXiJVzMph5FNPji3BH3T5Dx8/5Ro3LtrzVoVFEwnclne7c?=
 =?us-ascii?Q?RNW4f3cxv7PGmMZAxv3dh+4NTTNrws2hpcvpEmEWVH4jOvO2kZj7rfs6JAAh?=
 =?us-ascii?Q?R7615yC0YJg3N1j/koZ7UyOnXllczykGh9tor7zAaXWbEbVGUmZDfKz7VvU0?=
 =?us-ascii?Q?6TKaTz1DzE4VAlXxTj+cBISOjJhWhB5GkHBHpJ5aLYZhmhV7jmHMfAedWA85?=
 =?us-ascii?Q?rdDAOFutIEBQbQnhZkDVdW1Xx0b3hnNK6UacvR3KpMi5Lve4P2EVss5/IzH0?=
 =?us-ascii?Q?7iKIE6ecSrX4BeuB1CslJFZoZnsagdzZIjuXFLT/aBuru8dBrkTSFOEhunod?=
 =?us-ascii?Q?I1nslv/IhEUOx5wLjyCZUGThzV6J0dYFBzVQxy8wxqIyrqXv3gIVR1jmyF3f?=
 =?us-ascii?Q?SSbhINJc9um89EfdwLRs2ovpkqU1xYUZOh90O/rpZsQl8g6XAQ0scQnby4bB?=
 =?us-ascii?Q?RoyxfURmV2tCMnQ8FbsVrQAUqlSLZyoaIedMzBCl1F7idh0Uvh4UFSItYnkY?=
 =?us-ascii?Q?ZBaOtEhZdDjIf7nMalqk8UqG4WjskSaQ7l5IC10FyiIhARbv3417ya/9++T4?=
 =?us-ascii?Q?n2wJDRFuyr8Y5CoQg4kiYdWlSG99VfEKmUYfjv67OZ1WKOtN6EpvFjw9XbEh?=
 =?us-ascii?Q?G3mMtHUiVG8wqefsxjQFRe5PedNDjsBu+JpZxTJhRUfQTtLvQVxqcTksk6fi?=
 =?us-ascii?Q?X/q9iTpSL60+3yZbRnE5T4VoPmrH1sN4Eh435C7yZghVDXnSVvKztJSG5/EL?=
 =?us-ascii?Q?B7MZaduK7tPqj7qp5e0AxhgMUWIJwG8CI3UVcClJ5F6TKqyypNFsi8ZHtGXX?=
 =?us-ascii?Q?pNjbsqOuAg6U9JET8jo2n/1PGewy276YmbmyNo/2c9IDGNLv9nVGO3VicEeO?=
 =?us-ascii?Q?vH0BEXtK+owoccaf1RMbfWrF3GlQIlWR5lWKyaek2EdnEcAQikYbHqKuBHWm?=
 =?us-ascii?Q?Mg0NPOKN8qbirjnwHJgg9irW9W92EIRpEdIWgAjn5vXkiPnA7Y981ddp+GJU?=
 =?us-ascii?Q?3ybcrTMVFoAr6XCXx4mJqRmEb7de5aTZikkRgEuUKeTenzc49cbXarLA+ci4?=
 =?us-ascii?Q?Zk0f+zNiolPAt36TneuA/v5KdmfFh7vrU41qk9J+DUKFoIqwKmOvwH+5MIBw?=
 =?us-ascii?Q?U0ZRyI46l9OBiddkpwN7NOO9HtGzkoUrXRr+fgrCPYcACT4DBqxUFtfdplM/?=
 =?us-ascii?Q?Su7n7GLh1GdbCwY68i0iUrRpu77FCqva9yB2GstoRA1wQk9fY3inlBqS6mCQ?=
 =?us-ascii?Q?N5aJxMuAdG8mwY+Eqz1k19ohEmOpIXynMZkXalyMbf1jIVbI0ui3hg4GXIqT?=
 =?us-ascii?Q?wlhlDhymmI/xn/NJrbldqG6tNvQlh0DbTC20FV49QrvQuZkaogc6DmXDulvq?=
 =?us-ascii?Q?rwsUIDvQEKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4UjyrsZejqAUtWosbTuHTde96vdXMopodZUCbgTPhB1baJO8qwufl1Q5G4V?=
 =?us-ascii?Q?ubcAoNGxBupbQdqGUQghVOCLr8uiAXO6P5I1i7P7/omYz40RQkVlQo4cR/U1?=
 =?us-ascii?Q?VFC/ucSmTu/TClbkU7lI0nOaHba4GmKCr5nrGPoO8a7q5y9Ntkc4te+oDjv3?=
 =?us-ascii?Q?c2vMreSxrgYMHsFrKgYWOic5l88eqgwolAhDv/ftn/mLJh0nPvs4lz9ZTH5w?=
 =?us-ascii?Q?k6SdSx8H0971SW5r7/4Ve2jnyEmWzO4EUqfEHy2+R3QZmDdMfGAeqRGq9BLF?=
 =?us-ascii?Q?lngKk4srnmw+nfPLRD8z7j0qLw5gakO/recc+uY+PxHyVRzc/WTzZsCkrNdq?=
 =?us-ascii?Q?AD20q5lDgBVIX3n+65xPJOntb48Rs3to7QfW2Gmbyszsj07CuaTEP2QCMIkg?=
 =?us-ascii?Q?e8ujLrlhZjA5qTUEPxBfD39j5QwszSPXl+3SPhNVwgSGJHTYEWybS5F73YQc?=
 =?us-ascii?Q?WhPcthJ8/fb5gk8viHOiUFvHoaIbUc6837a5wMiBxRyfh9T2dgkYdaFQ2NJ2?=
 =?us-ascii?Q?6D0583YXGG+AgBaZfO7wzrRh7awen/AFKBZcSQ1iXD8kON3vbB7JY2vF6kJw?=
 =?us-ascii?Q?1CmNbP8liruvqtx7aYsz/+rws7PmognN0+XixVhhkyIAtswM72a208SXkHUR?=
 =?us-ascii?Q?aLVZKxoFoMWMXEvrmCPHozfLlb49KsXsF9OR9+3Bh5vLUJCPoj8SEJrJuFts?=
 =?us-ascii?Q?EZs7JP5xNG1iPURARGRmSc45SzTn+YlmkR89nGhPVQs+D3sSbrxARZdym142?=
 =?us-ascii?Q?kSokBYzMFBRgLrbvZBJcPbMcjUhWYYQw5RWTp5Q5Snqj4Wm1UBawTtDxd/1v?=
 =?us-ascii?Q?rZCjtRqnKmmHwepg8GMhbXfCzhAmsrgqEqPmlbgK/x/qAPlQBlk9JytKnET7?=
 =?us-ascii?Q?VdtCHReTgqcg+U+PF2hgsqu1e5fed7H4BTnTgbwsoPeo/MBALvMYOOWHE9hs?=
 =?us-ascii?Q?gxHJk6p2CmTGHwAsgJdsD5rs6fL0vTavebPIBqi5IME/zxUdn0wosJn60vRh?=
 =?us-ascii?Q?hyUPv/Hd2ePpNM7cfd6LegFyKOUOuRLer+tqyT9jptFU1j28DMlX8Ctqyxc8?=
 =?us-ascii?Q?4fz1na/v+fLJH7GgExz8ixMQixrd1gBV8FZT03D3o8EVl7ETlF85Hc91TFpO?=
 =?us-ascii?Q?GccD9RW1DCkwm1g+FBZ+ZPujMdDAdPPDNnNChI0KoN6sabWPlu67eteSeOIx?=
 =?us-ascii?Q?STRKsoFYMngaex2F2fIRZ+FBKhCeG/LeLYfPccEHsyKYBytVEbODnyvT6UTM?=
 =?us-ascii?Q?fG/lbsH1uOAvpfcIvyyWeahS6gtYkRlh8FSRcL1KiXmZOnleGUflFRLq8N+A?=
 =?us-ascii?Q?6ZpMDqbVEl1z9ROLtWMIlfekKT2ihjDfdKwnmMCIzSYb3K5r4xR0+bX/IW4s?=
 =?us-ascii?Q?jF5hVVSMFxeoIm6XWx8ESq7VRegnKPTvUdAN6ypXu2FGWF9V+4nTxSNvkWzR?=
 =?us-ascii?Q?j4LNf9b4AVbOXDmsF8lAa/loZqJw5gBcoMmnpZb34ObK8HD2lIBWcuyRoFSL?=
 =?us-ascii?Q?orjqYbpk1BhV5gSRxv7jBjEa3ZIXkXGCLMWZ+KaHt+ooIsyiZley7Y2UMnpt?=
 =?us-ascii?Q?kOjAP/neSERoM971IfX6p7FPIHqkkspbCmXqWZ/W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+ecMicDD1HRH6JQqBvA66cfWbloB/yNcyA9Revgv1N8Az4FR5iPVKGsTyI3RbfmtVd4RHgO2enxU7B3OBkY9dSGKN5k7XZFZKcAA9J3WkwRuXfGnqXY5SMB+PVsNeXE5TCkr/O68ehdyA+zrIZIXWgfztQ+DUl/wp2t31vD8qvbPSlZkFibxzPQ4foC47ca7qvQJfpG8Z1IbV9ytVFLMc8OH08+tysf7ay4vwbc0gsiqyVQryJchlDV2W7powSS6ut6LChqFqRBu9v/5mltXkr/jZKtbT+2perv2mdhcyYHT+4WEzS49eih8UJ6UnDQzgmK4J70wpFia98nlt2gjVJ58mV/Z5fke0pOaKoUlWJV8T9ljbJtHSRFq3/54mfuQEmTK8QAOFeilEjeYZY+EISV3dLgQjLWDYmiqolADsj5q2P0lLWoIlYcBCwb3reU4zIqzE/rJBDwTYD2zcNiXhOg8rh7mU+pbNIhPJR6jwoNdB0UBwv0wJ9gxMPHQtfIP0jm8mnnbc9ntHeo9cYrCUhkxBWh2L97xdEJamOzS0tJtX0QrxgqevrOMsOAFBfgYG2U7fle60btBuUlKxTZQNwT0kMEW2pNURiO1+DJi210=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557c2a77-fd84-4e83-22ec-08ddc0592835
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:58:51.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +knfZANNiH4lAGLF1bV8FkJQ8cz6IkW0GsGHG6r4RKJYeoH9sDxfHfZTjaAuMIR0N+waHuvCkj6zwQ+KVtZRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110062
X-Proofpoint-ORIG-GUID: EdXVmxvHtG0REyZ3KIKSd6xDPp-KTHSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2MyBTYWx0ZWRfX8W8VdJh7lkOu /Ldk9oGsa/OzIDc3zMbq+T9pa4JndJAVyX4CAQhM9CcL+r8g2BM1fCKlv6dznYDJ3ImPCxkAuBj 238I5gbVyEIML739qzBKZf+SbJyhliI9KYc55Tm3S/QhSii9ypePMc0muFB5OlWrMGEVbgCFzjK
 31bKZtuxaaxxsiKBeZeSSTNkWo+xnUWuy8OA5BvGjlybDeqNmB7V1FFduT05s0S8yD+i78p7smW zX2TTfrHrLxQ8macy3ntLATwZz1QeRmNzTpTSjdBGkkFtvJpQED93sBhvHLOTVCalSLaNr25I9n smDbedLo3DrEGTZLzdHpYs2VBCFIHlX7CVYdtIupANTf4rRCuyQ4Dq7IemLEV1G+wEIjKLjhQi5
 eknkNowSAFTuZbn4CmFsEHzuikuXjO/PhdOwcWFTx9fJ21NNlfGNnVpkV3zQh2ohrA7sYQfY
X-Authority-Analysis: v=2.4 cv=TONFS0la c=1 sm=1 tr=0 ts=6870d3be cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=YNFgnjWMrwDcOAm7uGwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EdXVmxvHtG0REyZ3KIKSd6xDPp-KTHSe

On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
> Reimplement k[v]realloc_node() to be able to set node and
> alignment should a user need to do so. In order to do that while
> retaining the maximal backward compatibility, add
> k[v]realloc_node_align() functions and redefine the rest of API
> using these new ones.
> 
> While doing that, we also keep the number of  _noprof variants to a
> minimum, which implies some changes to the existing users of older
> _noprof functions, that basically being bcachefs.
> 
> With that change we also provide the ability for the Rust part of
> the kernel to set node and alignment in its K[v]xxx
> [re]allocations.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> ---
>  fs/bcachefs/darray.c   |  2 +-
>  fs/bcachefs/util.h     |  2 +-
>  include/linux/bpfptr.h |  2 +-
>  include/linux/slab.h   | 38 +++++++++++++++----------
>  lib/rhashtable.c       |  4 +--
>  mm/slub.c              | 64 +++++++++++++++++++++++++++++-------------
>  6 files changed, 72 insertions(+), 40 deletions(-)
 
> diff --git a/mm/slub.c b/mm/slub.c
> index c4b64821e680..6fad4cdea6c4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4845,7 +4845,7 @@ void kfree(const void *object)
>  EXPORT_SYMBOL(kfree);
>  
>  static __always_inline __realloc_size(2) void *
> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
> +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
>  {
>  	void *ret;
>  	size_t ks = 0;
> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  	if (!kasan_check_byte(p))
>  		return NULL;
>  
> +	/* refuse to proceed if alignment is bigger than what kmalloc() provides */
> +	if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
> +		return NULL;

Hmm but what happens if `p` is aligned to `align`, but the new object is not?

For example, what will happen if we  allocate object with size=64, align=64
and then do krealloc with size=96, align=64...

Or am I missing something?

> +	/*
> +	 * If reallocation is not necessary (e. g. the new size is less
> +	 * than the current allocated size), the current allocation will be
> +	 * preserved unless __GFP_THISNODE is set. In the latter case a new
> +	 * allocation on the requested node will be attempted.
> +	 */
> +	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> +		     nid != page_to_nid(virt_to_page(p)))
> +		goto alloc_new;
> +
>  	if (is_kfence_address(p)) {
>  		ks = orig_size = kfence_ksize(p);
>  	} else {

-- 
Cheers,
Harry / Hyeonggon

