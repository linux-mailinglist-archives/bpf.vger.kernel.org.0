Return-Path: <bpf+bounces-28921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF68BEB56
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E65B28E57
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3E16C87F;
	Tue,  7 May 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SbIZIX17";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xgs4lOPB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563115ECC6
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105625; cv=fail; b=XC8uKJGRkvzsmkTDRJz9choNzgJMlp6kgXs/BBO9+Ycu8DOCG34aqgPt3XjqTQMj3jh2V9xjUuCz/tkOgzEuyPYYuojP9TnGpE+/JDDEMuVgHTCAi1O5CHtB6bvb2FIhdsDokokMO2wIKBd5S0ecdCfX6Yhu/jMcO3MeVY5SIHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105625; c=relaxed/simple;
	bh=rqzrY63u9roOQjlooi3LDXdzEMqnaWuEAE4N3i7vFYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=L5YBeweMFVh0k7ikkzqc+KW2mxF2JC0QMTjaG0nh4DYeQLGc2OFv1FowlbHfQMx4BgC6SI+vaZ3wpWoOAt6a9m2MlcJ0sytR1QKOfeZ8A5cTWsbQ2513KNu6OdFP1bK4mlGwvLB/NWqlLgOKZsSi7S+BZ6TCxafuuMpuM4RLl2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SbIZIX17; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xgs4lOPB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GduNc008198;
	Tue, 7 May 2024 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Xf5rVhpV/D8mVs8xmSLk4GC+hB7rq0JLSankdsHO43s=;
 b=SbIZIX17W7Gz2JCR2MsErg4I1d2JAlN7rus8weQS0BYum74GeEeZ5EXGinFdo+H+/UuI
 1NmJJXSwujWoOVjZZwq88Fkd2VsCuGaiTzoT1LGHc/l6htn1TansLHco46KvnzswhFOf
 0TiOd5yYPYfXbtgDYJ8cwKXKLxjNz4NkQSOcTyyGjsUfdsanP3iNGqYiPkSgqZHqXzW6
 w1cYXI2RJ3N2ZhYzcRLl031Xgq88OuV0tdxtgz1maG/SMDVdYZolwFcyriFv72hgGCRY
 Tkw4tsC4JFBbedGV/MZ1dDp+ZHttcOPHBK6TyYgjgBw+Zd5CR8MSfgmQ7CbcPS8fdoRn pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeewn93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:13:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447H2jNI006999;
	Tue, 7 May 2024 18:13:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf8drfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcqIFeJqi7ij5fsxQ9Eac9PAN6eAWUOJ5yteEnkRlego860IA09hSXUM0WbSZXRDHOVHX/u8WOUWUPrfm3juP2WM5HdxXlM1/snDB5nmJSHt3OxBL1z1Eh+umplTw4ITYBHnrtYY7amRo8jgb5RzvVLQscDRU1skRjnU/80s1Yt5x4fNzxOTynmK0sKImjHV5Ue95W+z3qcf8AsgRuNau/IHe6wbA/wl+InExsYQ02D7guyjpI8r2FSijMe0IiX58e1+HZ++xXNP2UPQYBLxUvPDMNMkzvrbwArsWq/EQbAm3JD1jSAzry3+4xiuhIOMTb/+gnIrQod269YLgF2LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf5rVhpV/D8mVs8xmSLk4GC+hB7rq0JLSankdsHO43s=;
 b=ZquulTFRb5+lYCLoWF7rO0xMo7hmnMVZnLtO9YlLhjwdRhx8wBHbctpnuD4zmJrG2XuEfxbYzK7bHxnVOuNcMR8Jr5t+kYgHR0N9i6ifRQhYcQgvw+EyqoK9t5KXWx4MLSexiDORmpiIAwfEppmJ48PX1VwQQjL13S0vtP9IlT1dkITMf1E9ZASnwVgoQY5w0VGgMoZtatpZHkHw1QHa/PTrYJTdX7DalwzAC8BxJedFjnutHCYnj7DFsammEfCAw2IVqbAuT20XrnHQ2WFCMKgRHG2vub0hO1ug+Hc+GLAvqI4PkniCCa8RzHAp0v+3Vbxmr+lZZdXyqjPkhB78Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf5rVhpV/D8mVs8xmSLk4GC+hB7rq0JLSankdsHO43s=;
 b=Xgs4lOPBOoV8Me03eJZQDNs5X9FTHKCOhFJQZEFY3jEWLau1IGgVIlKRQ0BXl+TRdZLDf/FyYMmXRX5SVJxjksqHOn0ctNC5UbPpfYQ0HqTeg/9SQdgNH0lB1N9nRF5T4IlK75a5MDfS+UKfZY3CnUfHahTI5e17exrMq2WW5b4=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 18:13:38 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:13:38 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid uninitialized value in
 BPF_CORE_READ_BITFIELD
In-Reply-To: <263a563a-3abe-4c88-8a1e-e10fb8a6dfad@linux.dev> (Yonghong Song's
	message of "Tue, 7 May 2024 09:23:31 -0700")
References: <20240507113950.28208-1-jose.marchesi@oracle.com>
	<263a563a-3abe-4c88-8a1e-e10fb8a6dfad@linux.dev>
Date: Tue, 07 May 2024 20:13:34 +0200
Message-ID: <87zft1cwxd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::30) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BN0PR10MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: acf3afef-d76e-41e3-41b5-08dc6ec16aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pEgcabA2KTgYb82B8KdJASYRLLMXh95Kf7xk3xc2FhfTG3bVOzukTglOGOM9?=
 =?us-ascii?Q?bvB2M67KkZYtAHr/bMXjGE15eOl10ZoHkB0bj24GWe09ftvl85hhNCXWcykz?=
 =?us-ascii?Q?EyT05X3s8eENBtb/BW7Du6aMS1oHd+cQbBhf2u3BJsCPYffowmO5yHqePLoI?=
 =?us-ascii?Q?iub9/IMxKPMwD3kbn8ZYzOYTD3LU+F03A/U69Cd8lu0YdbljNEvDZbU8cEMf?=
 =?us-ascii?Q?zewhTsh0BLcgz5Oaa0A704qLnpK/RB19ZvNxUztekJj3OBvehWK9Z/ekGGB6?=
 =?us-ascii?Q?DpJ1bHKeNb1vDTPQSDtI26FNhy2Z7vK65Jf8JxmfXKwPSeB73A2I3/bviL9r?=
 =?us-ascii?Q?4b9lqOE5rLIYqQ0eRtu8bZVtpgjrCg18SMxfLdS1nfZvrDycpx6dyZPa9i5y?=
 =?us-ascii?Q?QMe3SpGMa8fZxV467ucxu4Txx5vxPkfa1UnIiZDzdbZgtdbnwa2xuukHdMSa?=
 =?us-ascii?Q?opPg0HSY3LG1zXAkaonlrZi6adrb2VjIl8dhwvOVNRZE0c6Ixym+fPt/AMKG?=
 =?us-ascii?Q?xTgcyxgzofWSj6y3V2CXOo83xNftsOwz/2SfR17qVFF6h3LYK47jYj8IFUmc?=
 =?us-ascii?Q?3UPnb8+YJDY/lsxqrn2LiCR9WfxJ+eUolHb2DK3DzqBi1KwIe0CmHXdWXcb+?=
 =?us-ascii?Q?zFh22rKqQLm9bMD1N1kPiuGhyVCZejyC59LZtVcOCnA7y1t08HaUEdTpAHP6?=
 =?us-ascii?Q?7qw8C640+RDuWTkBi4a98TcKXR4tIm3vFA1o8k7f/rbY2+JiY+lNms9RuBxl?=
 =?us-ascii?Q?rQgepA92xstyYEyzjwe7toJ3P+2XASOVo3El7EStV9qU+dn2Tkij1l9k2RSZ?=
 =?us-ascii?Q?slAJsQwkodi6vR4JyspoE56wYipG+jsLsOB/IWpUYLjotJmgMQKmEvZOYwRl?=
 =?us-ascii?Q?rxQ2CUNxV3t8GDpoNCTv94kBIofIFpgRE424aTZk1q0ySxQJdP03jbeRv9yy?=
 =?us-ascii?Q?lScsVuHXP5z7SvM3DHyf1RyjMAMCJ3m17f6hHykn6ctl1ApR4wykFxcKDSba?=
 =?us-ascii?Q?c5T3HFAbKwaJcmeGK+artDYbvSYi0P4fYW4/G4JS12vlcQ+uWsaj6xcHTMAQ?=
 =?us-ascii?Q?XIqLwChURxgReFVOCco+vp4J56PIu4cFSIeVKJ7p3KHgd4/d0YJ3vCo9VkAC?=
 =?us-ascii?Q?f7ibx9NdGNGXPIN2gXNm5IaSXzDmQFfNTqyKywiVW6bMvv0vPxUgl21+6w4N?=
 =?us-ascii?Q?XBQt71qjg8VtbQdNJGphJCUWmAXrAa/YYjF9Yi74YOzMhlc5Dw3HMHV1ZMfH?=
 =?us-ascii?Q?cwQFbq4BxO0H5CbUOWqLLGXrBFF6L2PEP2KGIWANDg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o3DGjjRGeiwXjQ6YkwOlyPzooVp09HRRwNCRSxu1yX8iLx8nhtcDTC+o7dre?=
 =?us-ascii?Q?76Wl911g7anBHoheM13+4BstDXKHrwBfrmwlJi05xja81FhoNsYnLHksBaJl?=
 =?us-ascii?Q?VtNSpglFwxyLt3gzixJlaSLH8/aZpuYip/TLpKjTk9Kz/bReNI+I7WsgTSZ3?=
 =?us-ascii?Q?5D2j0IfMg7ResmqmCSHpU1AkRXF6oO35auxHu+YLqiLPmZcqH1o8UtARXGbe?=
 =?us-ascii?Q?w/wwOrpVegwFhxFgJB1WjKBG3B0h7xdbXGMxOQe29P1ovGpGEkKYAjODFBRO?=
 =?us-ascii?Q?42YXst91JZFVgMe0g36WkoS1FVpAPn44Hj7+Y66BjxJOAbNyVu3unPwWUVj7?=
 =?us-ascii?Q?4mWYzNObb/V7ujGFKhHj4qJeI2GTamAWjuyBIqQDmXubamJtvdLy1thr3j79?=
 =?us-ascii?Q?ZPNlAfQffiuiIZOTBsO2GehIxqcDs2dsSL4wuqKOeyE14pL6T476eWgzWZKz?=
 =?us-ascii?Q?jQHQNpdG7ezTKSR94QDncm7rb4vYzfyG5CSh1zKIFADHwk2ZuPPYlFJJtQjX?=
 =?us-ascii?Q?yETIN2STiCNDSzzFeHwWCgYgRDSmXOlRTc6aVPN6vGR+cZo4udgTLQ+fcxFX?=
 =?us-ascii?Q?GWJMb4AO3FlhdMRaypMfj7Ju141EVtnJ1z/KgFvnsBp6/Bgfns4YzfdZeuUR?=
 =?us-ascii?Q?1bicTJkHjo9bvy5A1Er+BECAlPUXwHsqUAFOH96HmwcGaYWxuteR+9FVM4Aj?=
 =?us-ascii?Q?QXQhPgHmTi49b0FhMafNCfU/i7gat9FlJjr62c99O3x+FREPIGyHWSUU6BgQ?=
 =?us-ascii?Q?L4HhHMWLYKjO3iHVMex2F6DsJtaY/2g2sDO7iDu5ExSwVo43LROC4dOJj6eQ?=
 =?us-ascii?Q?dsoM2+EsUYpzEvXALp+Ysz4HUOiVTqfszukPDryW9sGVtUZcD8AKfKGnT8G/?=
 =?us-ascii?Q?mw3YlIqM7clurEIaJbUydbRaWOhX/yPvYkFR/73OI3R8YALREP64OU616XrJ?=
 =?us-ascii?Q?NpxXE2ov0LLaAt9Nz4dEWcWQg8tonvdcaRTRWRazIm/L96WAS6UKShmOyDIX?=
 =?us-ascii?Q?cROkDnOnH/F2TKTZ58SbqQmDowIw93oT1aHkgC0rzpIU4x8xAbvdEziAmK62?=
 =?us-ascii?Q?h9PfEhsjtn8ZWIBNh5CwjO69Dp6R9kzvCO0DDftkcdeOT6QBz1P63ontsbkp?=
 =?us-ascii?Q?FggZgmeY8zH24RI9hPQqmulrl8XkuNJO9GapkRUHGifYE/96N2swTWpxGg98?=
 =?us-ascii?Q?SU/9a7n3Rwqcy/bAohMv39FgmNkm+bSeQh/tdvaHkgp/9PS5Q77GOrjgHuJx?=
 =?us-ascii?Q?e0kzKmp8uHU7/00nwWmY1RxRGPhboONrHq56zZbjxRwmQMWLUZmS2Qnn17vU?=
 =?us-ascii?Q?wxWHPi71XYhe8YAmODkxSRoAR0l1N0JbMXCzSpSmHOWkwJDwya27jTOlpFtx?=
 =?us-ascii?Q?udg71sZ2/kKjxksynT+IPjjxStNgAAJ9XE9+F1f97c0CEkwqgM19LbiT5UJf?=
 =?us-ascii?Q?/NVwrHV2YOJ0LwGZ2HOEqG3EyonQ3aHdxmszY/KJQM/uMYL+54RbUfwWULly?=
 =?us-ascii?Q?bujZ6py5a4sLEg/sf2VenKzjLNxyjHOD63q7C3bQwlBfXKe/AkWwj5Oze5Ih?=
 =?us-ascii?Q?ABQlK4VlvGE42n8FQfhZOGo8tE0wflnS2hGHARczl9hx5Wc7i44ZLvG6Dw74?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cpmbJ1dMqt+/Ct4wFsJDruhHhNWxDALjqyZEr6T7VomDGAuWAEQRqW9B4KlO3ftAC1oJUUH34Ny2wbVzOd9hjW5i8uTV1r7hPs4j5NUacEDrT1jBeybcltpKJ6Z4OLrsH08+5KyQt7dn0j56ltDSsoR5lLNbw07oAHpRRNWIpjHdC0B7EW1qxVebMjkYKAKXNcBvd/g0XS/yNJnyfUyAtQcvsTXJlS6z0bNILqB65KPXM6qHQol24+CPm38A+rH0Z38wV5vu236fwH67ocw6NW6GZGxu5TQUOca8JG49BS+yjN27tIh/CXVfifHzKALTlH+wG2wtroetjVZ7ev5e2k0bmYaZlB3Fl8hI0ZOOCvclF4TgiqjGJ4weJ/roTOWQ0m3fWusehetobpEPbP6msT1U6d7vclySBxhz5xPvhWwryORWBb9o18PmKLCxryvkdEUj3lfiwFaTa8f9uJDVNYnSgRILPLbLm2Xl2SIaqs4RURJhkrmM3/wxLnOur5nS9yIQo0I7MeGbTJar7ccfoGr8NQdvae28Vu43mqLDviSDwtxnGhitshan34S5bP8iiX+ma50gZTLuEDK2XCdl+XFf74kYLYjkupL3kfePk1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf3afef-d76e-41e3-41b5-08dc6ec16aea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:13:38.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2aaJ7qICwCZ3QNTIckd+0pD8gnVY3MhFOeAHsZ/3xqSOonTbSB0WuxyMHytME4Uh0Q0mvDs3j/OkNFcMsCLc745xJz/n4W39Gfj4rXiX5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070127
X-Proofpoint-GUID: AH_60sAYYjirSicJSG0eGVtcUF2nZD0b
X-Proofpoint-ORIG-GUID: AH_60sAYYjirSicJSG0eGVtcUF2nZD0b


> On 5/7/24 4:39 AM, Jose E. Marchesi wrote:
>> GCC warns that `val' may be used uninitialized in the
>> BPF_CORE_READ_BITFIELD macro, defined in bpf_core_read.h as:
>>
>> 	[...]
>> 	unsigned long long val;						      \
>> 	[...]								      \
>> 	switch (__CORE_RELO(s, field, BYTE_SIZE)) {			      \
>> 	case 1: val = *(const unsigned char *)p; break;			      \
>> 	case 2: val = *(const unsigned short *)p; break;		      \
>> 	case 4: val = *(const unsigned int *)p; break;			      \
>> 	case 8: val = *(const unsigned long long *)p; break;		      \
>>          }       							      \
>> 	[...]
>> 	val;								      \
>> 	}								      \
>>
>> This patch initializes `val' to zero in order to avoid the warning,
>> and random values to be used in case __builtin_preserve_field_info
>> returns unexpected values for BPF_FIELD_BYTE_SIZE.
>
> In clang, __builtin_preserve_field_info either returns correct value
> or caused compilation error. Do you mean for gcc __builtin_preserve_field_info
> might return an unexpected value here?

The __builtin_preserve_field_info implementation in GCC will emit an
error if the size of the bitfield is not a power of two.  It doesn't
check that the bitfield is 64-bit or smaller, but that should not be a
problem.

So I would say we are ok there.

> BTW, your change makes sense to silent this warning. So Ack below.
>
>
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
>> ---
>>   tools/lib/bpf/bpf_core_read.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
>> index b5c7ce5c243a..88d129b5f0a1 100644
>> --- a/tools/lib/bpf/bpf_core_read.h
>> +++ b/tools/lib/bpf/bpf_core_read.h
>> @@ -89,7 +89,7 @@ enum bpf_enum_value_kind {
>>    */
>>   #define BPF_CORE_READ_BITFIELD(s, field) ({				      \
>>   	const void *p = (const void *)s + __CORE_RELO(s, field, BYTE_OFFSET); \
>> -	unsigned long long val;						      \
>> +	unsigned long long val = 0;					      \
>>   									      \
>>   	/* This is a so-called barrier_var() operation that makes specified   \
>>   	 * variable "a black box" for optimizing compiler.		      \

