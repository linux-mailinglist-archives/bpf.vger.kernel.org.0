Return-Path: <bpf+bounces-60792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E05ADBF47
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 04:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842F41721D4
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C70238151;
	Tue, 17 Jun 2025 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QDcOZCpj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vl9NmPKe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222842BF014;
	Tue, 17 Jun 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127921; cv=fail; b=K5A3yHuvVrUtkiIZPnvHKpaeu2UxANwwIpl2QbX1A+RV7RaOVWE42wXhgU8g4P8ckhDuDlI/I8lEOuKwY4/G4M1c2FdsuXfJZUV0STALXzo5XHWctA6IJtQbq8gmB/Q2iZ95T6tXSCPB2i2sazKoURY6NZ6s2sihGNDL12soP+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127921; c=relaxed/simple;
	bh=iH1jVDOVXrTLBSoTUOfGWsNcGQYcFt1tyl9zeGVpp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arP33Z/AAXIa/BfN0QxLTEl4jDHeTy+HyibZyWmxEbmizUHxJrOzZ4UDksYvp4kE7XNHc0YUKRQZ/E+Os80nsAnoCpQkW/V8iPNZwUUE+iiS/XchjrQS3fm5/rBy4TW0Sh1AJDn9M3z+Cwe+RUL7q4l8YIOjClwZW98br1LF8Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QDcOZCpj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vl9NmPKe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H1lSYM017345;
	Tue, 17 Jun 2025 02:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cL4c1vI4Q/ptoKs9i9yDoQfSR0G4+r+9X5qOR1yRzPw=; b=
	QDcOZCpjU+1QZB+/eK03cwpS0rIHsXCIisoU2jbb9F5jNd9SSzJjCWGBp29ZY/2x
	Er/oNEuVnP6vtwHnCi2uVdIESaXVNVqWUvQlEc1ugU7pqG9oR4RbZTTy7o9x6Bzl
	KQuLe71oL1fbfhLMnAFffcVz5xCmyDD7kWKfY8AX8WS9xjBy7TfV/HnscAa9dlpq
	uzsyHfFs9ISdqP++r552rZNX7IT4e2498jIvMzqMPRojFPEeMq5SQv+DxQyLjToy
	qcq4XnLDgcetCsHFjdZL71Sj0Wl2i5N9QNMta5gZ/g+0rf6YtyV9kKMLzQ1tjcyI
	jAfj3nlDYstLaW6aLkK64A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914emawa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:37:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H0UL1P036300;
	Tue, 17 Jun 2025 02:37:53 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhf5mf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDp72TICVy7G33B+av6LwUYO1BaoqrNFp5YyfKZPjLGRm/zr2LMsebEvgin18WVS7syu/8/us80CkG3Th890WFBSiNHzoBkOVsFQqj0FibCD6vQooQIJSNbRpdJxuE5gVAe0vkb63yJi/m4ZtOuSB7y9TSIRVQGzPkZJZqlBTtrFZ3qi/2LuL398wLcNN6S1W6cqRIe9PDRo7Sb2apaES1UcV+BhF/kyp5ZiBX4BE8vIrydgvCRpB7lZaEPXNR/kjb0CvO0FR2wgJKOr0Ksauz//zi1jK5cdyiLk7aoV4kgDZb10EIk4FL/QAPVHFZO2dP8vSVTGIjH+vLbDNOC3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL4c1vI4Q/ptoKs9i9yDoQfSR0G4+r+9X5qOR1yRzPw=;
 b=ZHnqxEtTJVgOSObTcgMGmSekv0oRAM6QrWRCr8eDR/xqD1sgoxtM5y68rkQdI/Ty3UO7nue19oxl1zvBvWXpIpAXk+2TpQGS/isdiCdZ3s4wno0kt7x8f2NiEJ0vGQhUonA3+Ys2U+I67AZvjh0irAApfcIzitEsUhF1wsE8Fj1nYyKjD7rGg+lz6ABa6e3Pgg8q0VO1BLXh+0ccDNDAmv33wkwlYy0qha6GQgDUkAwJn1apC8cF/0oNYoDMb00r2ZZaE2wGE4EJriIR+3w+8xnrsJUFQHkChxC4lS+Hekv9qQsJuHVxEOmcQlotjgY4a7QGNp0Ze5/5Mn95YY2VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL4c1vI4Q/ptoKs9i9yDoQfSR0G4+r+9X5qOR1yRzPw=;
 b=vl9NmPKeVld7x4WPlYXnac/rJTBEn7ZqG0QzuFZFIvm1ldn34kgZ3w64uSCug4YLGOuqmR9mN067VzeuglpFzpvzzSEsCoTvKK1cP9zEVMsGhRfD7BmCZtJL9KkwzkiFCiUUu4MjwivkWhES/9/kHi9g7WyMOXCgGcoEEmV6Gn4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB7219.namprd10.prod.outlook.com (2603:10b6:930:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 02:37:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 02:37:50 +0000
Date: Tue, 17 Jun 2025 11:37:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>,
        willy@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
        hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
        tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
        saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: Re: [PATCH net-next 9/9] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
Message-ID: <aFDU9CWgluCBqWrc@hyeyoo>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-10-byungchul@sk.com>
 <CAHS8izMLnyJNnK-K-kR1cSt0LOaZ5iGSYsM2R=QhTQDSjCm8pg@mail.gmail.com>
 <20250610014500.GB65598@system.software.com>
 <937e62c5-0d12-4bea-b0c1-a267c491cf72@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <937e62c5-0d12-4bea-b0c1-a267c491cf72@gmail.com>
X-ClientProxiedBy: SEWP216CA0140.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: cad3f4d4-c98e-4cb5-e9d1-08ddad47f3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdIVjN4S256Ukd1eXFqZThnUmxvcUFOZDhFTVk2VjlhaE1URmJROVI0SlNH?=
 =?utf-8?B?Y1FkcE9oYUdMWFFBbHdZZUtOSjdzOWovYWREaWRacmwzMzN3WXRsTGpiZEZT?=
 =?utf-8?B?Vmx4RWY3RjZoKzRmSUZ4RzdzaFZ3REdCN20yUU5DeWtQM2xOUWtyQ0tSZW1P?=
 =?utf-8?B?dEpDWVN5ekpjOUpwcDcxeGZZU3lVcG9LcXFBVTNPcVRrY0xmenRUWnUxa0dv?=
 =?utf-8?B?dXg3RzhtUmpteGRDZ0ZmY0xYTnhVNUxMUEdycC9pODI2bGpaNDdiUS91UFlD?=
 =?utf-8?B?MVNmV0owZ1NISEhNbEhLQS91RTl2dVpqRUVSeG5ySXk1Q0xacVI5SUFTV1do?=
 =?utf-8?B?Q1hNWThodS9xRWJMSDd0SDF2MkR5SE1ucE1VTE03Q0hnWGd6Mlg2ZktCay85?=
 =?utf-8?B?ckxQejlsOG1qd0FCTlBSNE5CY1pJS3lMckRERUcvQ21jVUUwQ3BSdTRoNm1X?=
 =?utf-8?B?VG5YczBPZFNNZlZkZUtvR2pIZmFhN0tyN2thK3ByUDRiMUltSkE2d3NPaG94?=
 =?utf-8?B?alZRT0FYa2FzSVFub2RUREJRVnhVM3VQbEVLaUJZN2pwUEZRdHVVcnBNOGZE?=
 =?utf-8?B?Y0dSUzBtVk8wVGlZS25xMy9SV3NyQjN1cjdla1pRVndtSUVwSnNPT0hFcWZ2?=
 =?utf-8?B?em1tVytMUFFYNkRWZGRyVzlHN2xrSXJHMk1ZL2dzNHAvUHJURHJ0UWZ5MzF3?=
 =?utf-8?B?ZW1oSjdOUG9pMy9BanJzcWk0Y2tpKzV6dStYZnJMajdJOTVUbnpxbXNvTmVT?=
 =?utf-8?B?QnpacUlJeHJIT2UxSG5ETThQOFJiS0gyTGdKQnRnbEdDWFoycC9sMGR5SHEx?=
 =?utf-8?B?VXpSN3U4K1JEUzBBc2lOTnlrRHZadHdveDg1eEpBdkhDY2lzZ0l1NDVjWUhG?=
 =?utf-8?B?OGF5UzVGbkxZQWRUQ0YwWHpDeVFTRVBzRW9Qd3VrQ0tIajhyY3NNMzhPU0E4?=
 =?utf-8?B?YzVCQTFkNHhFRjNKMm90ejlFV2tQZU5mSVFJMC81ckRveXh3K2I1NE1VSml0?=
 =?utf-8?B?eVlVT2J0YW5zQll4cXEzVmZIdUUvdzJuMmF1ZHlJTUNUK0FtYWdGcWpyWjQv?=
 =?utf-8?B?aElFZzJlbTQ0dmcrMkxLYWR2RkZLVCt2U1BZZ1YyVnVTVkljUDhSK3VWaldP?=
 =?utf-8?B?R2NZTm9rRyttYlNrYWd5eWZZaFFMZmlockVhVlRPOWIxaldhMmZrVnVIK2E4?=
 =?utf-8?B?TVpuSFFxTkdSMnIrcnZQNDJWYSsxSE9JWlhWVElHZDIyVWhkM05JbkpmaVcr?=
 =?utf-8?B?OUxMM2UzNnptK3FndmFHZEF2MG5xUjdwZFh4dG02VFpkbnpQQmhUYkZ3cjRo?=
 =?utf-8?B?N3J0S1N3S0lTWlppNHVFZUJhSTBKbklkUUk0eGdWc0x2MmI5WHRZby83eW43?=
 =?utf-8?B?c0J1VG56SHArdERLSFdjQVBueHVtcGJhaWcxbEJGbld0dFI1d1RlZmNHVGc2?=
 =?utf-8?B?NHdTdUpKblBremFGRkc4UUpBcGd0K3ZEL21ocEphRDU2Mno1OXFqWjlabjlV?=
 =?utf-8?B?YklBSW5oL2YyNXJIMXdoaktBZERIWXFPZzVoNmxQaG5ieHJNVFZ0M1NFWDFK?=
 =?utf-8?B?U2cxaUtIMDhESDB3Rk9tOURHbHg4VDA3eCs4YmFqT2pkc0NFZTE3dlVhcEN0?=
 =?utf-8?B?ZzkxaEM1anNJWkxscHNHb3BYT1Y2cEljSlFmdytwMmduNVdkYmhlVmxqdjYw?=
 =?utf-8?B?SGFiU0FnOUJPT2JlMm9iNEJaa21kdVZsSXZQNG84SUdDdU1zMXB6VnlKOGZn?=
 =?utf-8?B?dHp1M3FmeW0wdVFQK1dHK29yTTlpWldibFdNQXVIWkJWT0xDcWk2TEN2cDVo?=
 =?utf-8?B?US8zZVI5bFhnYmpsVElIZEkyd0ZjYVRsaisydlhnR1o4cjVSRXlYY2ZNTDBI?=
 =?utf-8?B?TDhlUHUrY25HcUN3MkJFWmVCMld6QS9adjh4M25iVEpOeTRHeEVMeTFRM3ov?=
 =?utf-8?Q?pfr/VEoPrGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNxYXNKK2xzS251YnJvS1FUNkc1a0FXai9xU0pkVEx1ektvUXVDeGhyL0pv?=
 =?utf-8?B?Q3dxb243bTRBNFNENXFvT2hLS0FicTVWMUJ4aUtWRkRqL2NMTzZnWjB3Vnh5?=
 =?utf-8?B?SFp4d2VObk55SFhHcVRlbTFpdkF0azJjWjJFN2ZPSll2M29YNHd4b0pyd2Zv?=
 =?utf-8?B?dmIvT2thQ2FSN244UzhtVmJreXpvYk94UHFRZkNndmplbk1sTjJoTFZZZ0Nj?=
 =?utf-8?B?bXZtV1cvTGxoV2lpb0Q3QTRxWlR0S1E2Y3hFeDdWUTQ3eFVrNmVCWFNpekRL?=
 =?utf-8?B?NUhxeG5ZQThTSk1uS29iUmQ0eWk0SEtvU212NnB4aSt3RlllUjdBZFhQV3l4?=
 =?utf-8?B?RmVXNGtyOFhTVkRmalMvelFZalh3Ui9McXZpOHd2TUdXQWZFUmxtUDUrTXh2?=
 =?utf-8?B?d0paZXhTMmVlNGNZL3pVMVJlOGZ2Tlh5WWhGdWp4UnpJNVRTWENwcmw0ZWV2?=
 =?utf-8?B?cVdWZ3VSRlkzaWxzRDEwdUVvQUtValcwcVBQemVLeFliVUVIdWd3QnJScGVB?=
 =?utf-8?B?bVZYV01PcHo0djRDd3V4Smk4WGprTXQzOTJxTW5PcmxqYU9TVW9ST0U2TC9o?=
 =?utf-8?B?Mk5SK2VVK2tDM0JpSFJxSy9td3lFR1FIaiszT1R3a2kwM0pkN3YyYkFVRytl?=
 =?utf-8?B?UjZ6MXNOTi9XZ0tWQTJOSkt3WmJ1Qkx0amp0V0Zla2tyZFR2UGYrazF3cEs2?=
 =?utf-8?B?V2lQK2xuUXhPVWtOSmc1KzI4MHc4c1JZY3NqOFZjRXMzS3FlUVB3WTFtVld5?=
 =?utf-8?B?aXlVQlV6aElJcE5GclhHOVJGNklxZzNnRUNEeWFxV25jT2JkQnM1eDNyWW5k?=
 =?utf-8?B?R25USVUyK2ZTWjBzRDFiRkI2MDFpWXNUZVhLNDMvdDlDTnNpa1BTaUJ1aVRX?=
 =?utf-8?B?enZMdUthRzlFbHlyakxGbFBCNG1vR2ltcnJGY2pNaVN0U0xmbG1vZG1ObXdz?=
 =?utf-8?B?M0s1SnVTL052OVE3QzRnb08xaU0xMjBLR1hRK1NtUFhSdzVHZ0RGM1k5a1RB?=
 =?utf-8?B?TU5hNHo5alF3WDBuOWJhUG16Q3lBTGtPYkFPcUd3YzNrNEFZU2hVTFdCbTJZ?=
 =?utf-8?B?VjFUQkRwc1NjdjhYK2ZIT2h0UWF4SngxYmNQbFAzTjVxT1ZkcE5wZmdzbGhL?=
 =?utf-8?B?Y3hUV0xPM0RwN0FlRFZnQXM1L3NEd2tGYXFNT1hyNFh1ZlRPcmlRNklla0g0?=
 =?utf-8?B?UHlSSVI3Q2hUQ2xubHFUTkRlMGxhRzdZbXZvVUxrZ0tpeUpmcUF1L1JCQlgz?=
 =?utf-8?B?UDF0OXdsbE8yUnJERHdvRldoMTFKRUpHU25XWnpJY0ZTRVhqMm9XQmhibWlk?=
 =?utf-8?B?RFpkY0NwS09Bazl6RituOFVlVUI4am1TQkxNenlLMHFxY3g0SmxnV21YT2po?=
 =?utf-8?B?S0dVempUcUhvc0FGS081VS9mK3FEOG9xM3A0cUxFTHd4Q1c5ZlhlNnlYNmk5?=
 =?utf-8?B?VkJ6OElCYitibkN4NFlXaGkzNnA2ak1uQlRoMEJGM01pVnBzY2wrVEhVczFB?=
 =?utf-8?B?V2NGd2lxOWxtNk5UaGRmb1BHVzZPQ1F2am9rbnJsM29UR0xicWppUHNacFk4?=
 =?utf-8?B?Ly9ob3B1UXBmRFJOUmpZbFNwSXJ0d1FpRlZkN0Faa2R3dit2R2xMcGlNWmhZ?=
 =?utf-8?B?dHRQb0NHWWVxaHhHNmNWNVFXcUFBcGUvN1JHeHR5SlllOUtxejA1NVdLU0ZP?=
 =?utf-8?B?dmhEV2xmbGwvWCtIOHBLTUxiSFdCdGQwbkVkUFg0WDlzaTVsdzFXci93cmwv?=
 =?utf-8?B?c0d6WENaVmdLd3ZRSGtOQkdWL0dZTjlVRHF4N3kySXQ1REV6cmlhdDNsNDhr?=
 =?utf-8?B?M3UycjJnUkE2R25OcTNjM0N6RkpZeElTejFxUWttbFk0T2ZjOHlGZjFxYlpF?=
 =?utf-8?B?S0pyenZGZjFUY1lERWdBY0ViNXVDY0w2c3RlVHB3Y2l2bHgzZG02TFZJNHUv?=
 =?utf-8?B?UXpHTDk1d0g1MGxydTZiU2ZTZDREOCs1MzNHQ2k4K25SczNWNWNkQ3VIK2V5?=
 =?utf-8?B?d045d2ZmYnZiQlRqZmFlUFBCV1V3Z3dYaStveW01dkI4M2hNTmtCWU8wb2g1?=
 =?utf-8?B?Y2Z6OTlSMVg4OFRhQmZadHdON3ExRXBKNmZodW1mZ0JxU1B1RklRYUFrb1Fp?=
 =?utf-8?Q?kkYhIugFR7UgAl0Bj4OfKqEcw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcQtqqPRkw11YjDYvvPvfti0dHnbRatoLTskP2mjxC/TnineM0qDycUigVZmiVfDjlxlJNJW90S2IPekrnW1vfHm4SYsQgT5U3LS/i1gEK16MZ23mJx22iriSynpvxnLbpOfn2L0ScYYNOmgFyHc3LKLygbvFw4ASPdrKlDR1Q6if8VQ7pXdHmbeEjoAuGTaG4pI9dIWyq67XVjOE7clNYRYzK8jCZbuV5XifQ6hpK1MjftCFd/I4nBgWQzm2h+G4+smCyQJkO4w01DvFS55qEqihjSW4UUmprV+owRsZftsWF6AFzdoAIDWbrg0xDOj+rnSHCBDo3QGXusHJlusCSikRJ8zKojP1ybvoV3sD5tfW5RW/mTVzjhXOGS9GbChkagevOHhY8Wp2nFWXoncP8Xxywwaz3/FGr3OavKXxLQgastzsASyteemW7hwD+dYX7Ky58RmSMT3PD+j6rjNnGDWIt27s7Y9i/G6sivfRTGijEkEX3ZEqi9uDM4kZ/TzZ9ut8Bg9Hb0tJpVdg4vhTaOTklc9uQv6thaGLbByxDBm8qjeuMpZAajieZt0YdFz66jh62Y0fH+pdnsrt0O65970fFSxyGxMfHYTI4iCvoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad3f4d4-c98e-4cb5-e9d1-08ddad47f3cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:37:50.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjOn70cVjiF5tD5VThnKxtlz0bvXSnnvFc9YoJcpyKoA73n0/g17Fsl0jSqRuoRNSuNnMj2DXXASw2QQMDQ4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170021
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAyMiBTYWx0ZWRfX25J/X8yQsq90 BI1Mdbw6r6ZgoJ9Ta1XLBtx9OwRWhE2BV15P4HH92TAYfh2Flz0atDiSo3Pi1mIca0NRI/XTyG/ VIbXOczlIqLRCnfS4buxmoIR0HImfdoRA4TwwdzPi1f9GhxvlC02mPdpOk/0cCs2DWuBnJb721A
 lH0bhdKlf674KR1eNSDc7dFF8CRuOB/e1SfRfQ+pbgu1Y5q0pwC6LOxtY0hSNcYMf/xY31+Rl9K 6oUfqzjhKcJyNj4nyxtMB8t4kTKpaNOJRflD4zWWNWWySCDdZsTePa+kYz00RPJG82L+cs1lJ+x udc4InBBvm7izSnFDrbGd87bLZoLEFep02TUpgp5gkKcSkrkG4pRZyQVMxaYRMwfMceD7sc6FN4
 4c1qSExF+gUp7nvB/sF0prG6WI3ijuSh65bZf9iFzT2D90oAFyHO2zeSlTnQMy6zl5MZO255
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=6850d504 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ph6IYJdgAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=d_xNIzraBtZ8sBu7EV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ty6LBwuTSqq6QlXLCppH:22 cc=ntf awl=host:14714
X-Proofpoint-GUID: EUYopvPLTKijLpOPA_l-301GH3-ifUlL
X-Proofpoint-ORIG-GUID: EUYopvPLTKijLpOPA_l-301GH3-ifUlL

On Wed, Jun 11, 2025 at 03:30:28PM +0100, Pavel Begunkov wrote:
> On 6/10/25 02:45, Byungchul Park wrote:
> > On Mon, Jun 09, 2025 at 10:39:06AM -0700, Mina Almasry wrote:
> > > On Sun, Jun 8, 2025 at 9:32 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > To simplify struct page, the effort to separate its own descriptor from
> > > > struct page is required and the work for page pool is on going.
> > > > 
> > > > To achieve that, all the code should avoid directly accessing page pool
> > > > members of struct page.
> > > > 
> > > > Access ->pp_magic through struct netmem_desc instead of directly
> > > > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > > > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > > > without header dependency issue.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > ---
> > > >   include/linux/mm.h   | 12 ------------
> > > >   include/net/netmem.h | 14 ++++++++++++++
> > > >   mm/page_alloc.c      |  1 +
> > > >   3 files changed, 15 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index e51dba8398f7..f23560853447 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -4311,16 +4311,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > >    */
> > > >   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > 
> > > > -#ifdef CONFIG_PAGE_POOL
> > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > -{
> > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > -}
> > > > -#else
> > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > -{
> > > > -       return false;
> > > > -}
> > > > -#endif
> > > > -
> > > >   #endif /* _LINUX_MM_H */
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index d84ab624b489..8f354ae7d5c3 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > > >    */
> > > >   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > > > 
> > > > +#ifdef CONFIG_PAGE_POOL
> > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > +{
> > > > +       struct netmem_desc *desc = (struct netmem_desc *)page;
> > > > +
> > > > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > +}
> > > > +#else
> > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +#endif
> > > > +
> > > >   /* net_iov */
> > > > 
> > > >   DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 4f29e393f6af..be0752c0ac92 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -55,6 +55,7 @@
> > > >   #include <linux/delayacct.h>
> > > >   #include <linux/cacheinfo.h>
> > > >   #include <linux/pgalloc_tag.h>
> > > > +#include <net/netmem.h>
> > > 
> > > mm files starting to include netmem.h is a bit interesting. I did not
> > > expect/want dependencies outside of net. If anything the netmem stuff
> > > include linux/mm.h
> > 
> > That's what I also concerned.  However, now that there are no way to
> > check the type of memory in a general way but require to use one of pp
> > fields, page_pool_page_is_pp() should be served by pp code e.i. network
> > subsystem.
> > 
> > This should be changed once either 1) mm provides a general way to check
> > the type or 2) pp code is moved to mm code.  I think this approach
> > should acceptable until then.
> 
> I'd argue in the end the helper should be in mm.h as mm is going to
> dictate how to check the type and keep them enumerated.
>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

