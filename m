Return-Path: <bpf+bounces-49139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E1A146E6
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57D218897EC
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43562904;
	Fri, 17 Jan 2025 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNyiJ7om";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B7rMJzWO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A523BE
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072144; cv=fail; b=Or39w9LMw7OfPtJMe2Sx1lEfxWSudAYFGBP9qXuQpHBA/Tj8mxVkc02/Q8CBzbtR10Mo+nC3YWo80+fd9gLjA9NueatQGxoqbknDjOYva+4Q8s7wMx2u5+F/AfA09596fVSTee2PsSgmz2o4l6nM9TX9UiHQD4Pnf60X4ZTJMgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072144; c=relaxed/simple;
	bh=VIv1NbAZi/6nWBknDwNNyH55yrbse6y59A43iMk67PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=DwelPf2paN/1OJeT6zh0n9UELVnJ1bLC3h6NB8fw4LwRaWaeEIqf3lumRS7ryY6ZD9/TkazgZCtEk6LcUZO+G8tDg7c8+ZgTiP2VUf8X13E4xMWlFQ8IPwC1ZlEIkCx78hcnKdMY/58ShGvNX5ysKFuvDZ4mTFj/bE7s7NS06Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNyiJ7om; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B7rMJzWO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GMBpwM029663;
	Fri, 17 Jan 2025 00:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VIv1NbAZi/6nWBknDw
	NNyH55yrbse6y59A43iMk67PQ=; b=hNyiJ7omrQaPMwFefQN/0Yu5RX7GU/EuCp
	LAm1hxZSOhVlwMHNwHb3Wb51fxLXAor5WY843Zyws/pV8ShPBoHDHvZbBY1LDfQd
	fzZbF3O100QryR9j1W2wRnIcDMjKZJm6I9W8JT+1pvIPa6pt/f7sb65tGJDnyPs8
	9QpNVu6BPjXfrgVhFdbRZYKLQchDmD4xMWIc8ECVxoZGfwah9zC7arotNDNtPG0Z
	EmHI26cQtWsm/e5SDDdFayvXXJD+IAeeFuzdJt3cMxNGwZf09IE4JJPBhFpiGU2u
	cV6SBBpUP/1IN/RshJ0LrZR3s42DVjInAatPKmx4yWIsPyxNLHWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446wtp9tss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 00:01:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GMre6D040344;
	Fri, 17 Jan 2025 00:01:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3bga09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 00:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq2SitSPamBS0DPGkd59TsVF1Q2zRshQIB/d5F0ESPd2ZahlFKycoi4Lyl8R/yprAsAx6qd0dXv2VczIJBdMFz3N0VnS96PuFXfL0xY/Ze3lpI1ll9Muhwm3IcmUKuVr+KXzzjM68D5r6KX4rvS0veX0uWJFcebt08XZ0CwmEZtdxXKQymfGzUS3jjJqvMurzR4o6XFWu4qihO3Q3XV77DtvSEalwnDSGMwkRTpPbH/oC+ZLRmnX0dlr4YF7K25jlaXiUfgGHQ69OGZhfEF3JR2uo3j+HWC4KKSwN90VFGeTQvR6pcY2oThzqwZY2Dh5IqU9t72lq/C6MUg7Oz1FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIv1NbAZi/6nWBknDwNNyH55yrbse6y59A43iMk67PQ=;
 b=DLk+b+ys7D8ykOUk+gAylwRfJlzBaeBRt+IvcyhouC1bQd1hCyoyVVib8oTrLwabKlS7Ah7NcQ+PE75YrvSonyGbluaHHwwUZq+m4TDGDdk08ILoCehv09Qv521bNLguMuqlnm/WoCm5cU7Hcgc38AJUfhkHxD3HwDRLtx2gmBjknGABvK6CTaCWmGh/0aN+k2vX6ep7ENoAb73nYawyOgcVLqcUrrfheQbthg2KU8ueQMNQumwm0gy3Th4hxOdtF9+GDPyHWwurR9urGstUT6ncmz92VwVC9++XZeh9UnPwJN2E5BQ389PP4QVpy+i2ECAdZnrkLxvs/bAq7I/ebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIv1NbAZi/6nWBknDwNNyH55yrbse6y59A43iMk67PQ=;
 b=B7rMJzWOApRwxV3yEFVS/72ei4toDEcAmrJFn5DGo0Q4rA5kzuSNVVKhC1NYPGHw82XP/tMHRoFOqw1OEPFVaUUA3tFRLRAj95oSbygYvbKU8b6hzWe89rABspfgzjEqt3m7cnI6Qy9pdCxVjaAye18t5FOaLmaoPd4WFs4uI+Y=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 00:01:07 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:01:07 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle
 <chantra@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        Andrew Pinski <pinskia@gmail.com>, Yonghong
 Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
In-Reply-To: <Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
	(Ihor Solodrai's message of "Thu, 16 Jan 2025 22:05:23 +0000")
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
	<Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
Date: Fri, 17 Jan 2025 01:01:02 +0100
Message-ID: <87zfjqpav5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 06171379-7b5b-4e39-4f30-08dd368a0b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nRxqsNGT9S9Z0or/ed4mwuyGGbwEvf/2XDfamuFqQfdRD7cfp8tJi9cI4hO/?=
 =?us-ascii?Q?7NvmQXCGQm/iGAOpuiLOFhHG/UPqNRGyVKGwepJ2UUThRMXGp4rbhPTPYJwq?=
 =?us-ascii?Q?zJP6il3FoymV+I1c69fqjKpa3E0FCYumIGlYklgODqKxzKxMALZLV9Iaug6q?=
 =?us-ascii?Q?M5dTyVtv7cjD0/XsYxa7JkSQorLNM6I3QPrjUauDk8iEESp0eZOJ3vElOe9c?=
 =?us-ascii?Q?Orr05dDYq5/fUy58lhgZvecpcxs03T9EvS9cIHZCQ4Oj2uESLPr9KvoBdLD6?=
 =?us-ascii?Q?/MAmUWhIGvghVOv8qKiL2vJYo3BUjrBiZPge6V+ETTDkcdAv+m9Aw6xbq9DJ?=
 =?us-ascii?Q?Oz2JCrNTBs1QDRKWXXmHu27TgNBnIp3wFsEGzy6if+n1v9AFC4WR5UsyRJqm?=
 =?us-ascii?Q?m1XjClzhZLpVG5UOtXBBZzjHcJFm9ax96kmNYKSmEAEFCbUvbTkLwN+tkrOe?=
 =?us-ascii?Q?04y74obYxEzzkKT+V3ZUWZ5HHX6bHchuXT/uRYC0vabFT0am6ULqyhtmam9J?=
 =?us-ascii?Q?zrEoLIjPUSy7gY0MpS04dSt+hezveZVpj2TWyc/JnR/mC/eJmCI5ePNjvblQ?=
 =?us-ascii?Q?pI4PJGsBvQBJbgMS69P2M6LbvNMyac/0M7IWo7/xp/sHT4tCkUatChdVRNFY?=
 =?us-ascii?Q?JENe28ouJ5aa+WaiHzKAGnqyzznXRS55os3d2oU5+SsPGJq4OisbqKvJbiWe?=
 =?us-ascii?Q?ss+ALeA2WqGzSwPA9J6k4q4GQie9AE49t0BlHDjdGZ5M2SXSJoDYF0h34WbN?=
 =?us-ascii?Q?xlsq6ENM+kVDjbzRTQsfVzm5UxbPjer2g/6yoMaIKeFqPJfB0VenrYbb0NuI?=
 =?us-ascii?Q?iiTLAEI9iknWvUTeuzXpotorF3VN4ol7soo1GvGzCdS5SAgroUQTc1tw7FeE?=
 =?us-ascii?Q?481axErUobEslw8GXETJc20zR6ixdGVHNU8/K1XOThrbHbQKhSiO+yadFVK9?=
 =?us-ascii?Q?B/SQHIi6WFXdAFcOIosKh42u3FvaMQ68p6MrmbOR14FvsZgu9pf1V+hwdDWP?=
 =?us-ascii?Q?DskmeBEc027Vk4fCRHOtsyVTW2cynLwiXnEr5pEUElYMDoDzknqxLTRiXBXH?=
 =?us-ascii?Q?zjFj+DrQkJ0X2fslUI2lP8kHtLZsmeMAPyFLOmx/n5vs6QsMQ64E0xjycrov?=
 =?us-ascii?Q?hh9grOo8jBoGaCgXZ9MBOzAiWgkOycrhU4ykZ4hKJc49OBnamS2uJC96U08p?=
 =?us-ascii?Q?PIBwoNKJyySUrwx269yp99LYUIuA4SRk9+W0xo8caKw92hiH+45we667tnlQ?=
 =?us-ascii?Q?eh34acanlLXHnWtIrkRDlahBTi/jeEgtREoqn/FhdX4/Lb9EgJAopuP4GECq?=
 =?us-ascii?Q?u694L6Yk2CNGgp7xf9+0tWP6irbJ39xSQntjeyK/QXaLMmgzjDyUapz/P9cr?=
 =?us-ascii?Q?i5QHvhH6a0NddzaN9YZA5GQ6ooMB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUrkaOkCk/t7y+lmPnJtujej0nlYtSan7wSqyruas71dGFB+7JB/16MVZuuZ?=
 =?us-ascii?Q?aM22GeMkcdrFPZHozrtJFkdDdAeCDkIsys7YaPE6a6YiihkethHhxiy+ZP0+?=
 =?us-ascii?Q?Q2T/NTIUDxcUojPbVLt7r+N5wsdkpnaQH2XSp1H8qp+dy7Omh9/Bp8kh4deZ?=
 =?us-ascii?Q?jLZtpJOe3Uyt691e6CQtThoB2DWAzAgAXrDEO0d7p+3NoTsrIysJVe96kUWE?=
 =?us-ascii?Q?F2NYz4MFPmFWpaP7MRCvpRD0CdxW0axZPr1eE9KgfX4/ia7ar+Diow+8XYjC?=
 =?us-ascii?Q?OgSVqCC+M595l5fStE9sM6cvkou3kRSyvDcFXHPQvsKJIpih4Su8MKnbvDYX?=
 =?us-ascii?Q?B4zH6iotxArWg6Gwv9Q8NuXyhB3QzAnck26baG0jQ1vjDFFIHKv821Yh7Ytm?=
 =?us-ascii?Q?cfJhWF+wkYF8+Z+o1hdt4zxlxVt21q+EMxE2Z2/Npz6VD9MJ65pP+KkkOWCk?=
 =?us-ascii?Q?j1jTj0sN4YzeKw7LUInpBwaJyys/BwxPRXCdbuEVhFA+x7Dcz5oruRKBQN4Q?=
 =?us-ascii?Q?/q9RsjfpjItHK1GU/nsDZxTNXXqQvq6ZjJ7Nn3+YXwaxMTxeko+08cV9biPx?=
 =?us-ascii?Q?69KORTC2OPOZeX2l5g9p1FEpxx7j32/lpaG0g6iy7eU7XuH/xrdah5te/mPE?=
 =?us-ascii?Q?KN99lkkxOYs2pmKenUiKiKQzoW9tsANDd1bBMYs0GXgayB1q7Unb3x4QLoBh?=
 =?us-ascii?Q?dP3VZ4k5pEGg3s82OZLrjQVmVtPyMNxb1bARHkChseWARG9lYKBxC3KhzoYa?=
 =?us-ascii?Q?CxJpU4V/w+W/rDb/LIBLRuCvsPleNlnky724m7mzpuObkWIj+P8YxVeX2zBn?=
 =?us-ascii?Q?TMUaHFyZ6gWZ+LS673AHwYNF10fHo/pXZaIlRfpOZ8WaBmRkBCZ47BBMj8H9?=
 =?us-ascii?Q?2X0J3fgAjHSiGgWRFacEwPrxDyJw4tSkDfzxwHR2gS5WE1MDOEsnH81NS4s6?=
 =?us-ascii?Q?bEqycar5N92FZZ65ybeusu7DBNT60uc1RG1pcHzQFMJxsjAlNyUkNN7usG1z?=
 =?us-ascii?Q?o0hJXueB11C8z1YitkE1qxmVXfX6ohlfg0xutKTwTSjn/HrQGUvI0v5fgcFF?=
 =?us-ascii?Q?xuuouhxPvnOko0fSjHgxIp/hiblEpeNNEB8wIUlsJbXYYLsiwxEolqVKlVhs?=
 =?us-ascii?Q?rbwpz1Fioev+A9k+QJbF4bp4OQWp2pXJ2rSqDe6xj8WDp4jM109Wqdzme16b?=
 =?us-ascii?Q?7wUwR+ayKf+ujKw7OEP23LIk8c8By6e18keP2iQEiQD6XsiA9pM7O1Q3oys8?=
 =?us-ascii?Q?NnFM2dvnJeep7VdVPZg+lmLCmTfz9v/tvmaDMJwwDFqjSR8qYdPo1oFSH5Lv?=
 =?us-ascii?Q?IdWvqv/hM+U1J89zkXVWActy9u50m3ye3X8ZEkPUqxmGuc8MhwuXYQrbMf3H?=
 =?us-ascii?Q?gSudPDEWmb36TJtqJk1rPf4iHWribNo/+euvkHfjAQIt3T/Giw3Lu2iD6c6w?=
 =?us-ascii?Q?XNP3gDvbI5HePct/ZH50/TZh1piX783fZPwAu+wXfwpoJ8INzWb3EJrlO4Z6?=
 =?us-ascii?Q?q6lGwP4bsiYbbfGGt8TOnGrpz3Jcv8lJZ8MAHnX3UcS+vZN4kxJ3YRGcEoZr?=
 =?us-ascii?Q?HRv568jdgVLC0U92WNfdyqoO75MZA2u8MaByBdCVNYBQTTdK4gIm2PB64gko?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlDvLQOOI06Y5HSJ1wuVnvJr+RbPyZlgGHPBnoQ/xvtL8SxH7P+8pb2+if9Z8uDSH9f25HDyuyW1mekjSjK1mbgY2tWdxYsK/FI0qLkq37SHi0dYApNw+goy+8IZ2+queRdoA58OW7Cra3DP3vHHzhjpLo7xZgpVZ28X8yhJpcmAswEmR7PQTNYcYPbqGBmxWrPBjij7RdGUdXRnuOEYftqK5SHrgVFx1QpWP0RlP12bMJFc7h91UvEWulJrPFQKzUEFFXE7w0VNIY5sXufVm+5H+Y0LxNQkZMX2ztzd1OUvF++LMQv/hoCtu6ir3EVfVh3F68oMIVJ44n/e5iRjSrtu8A6NIr2xtT6O9XGeHZpqczCH7WUWkppyYjTgSyPDMnNWTxeYG92V8frukeDEmHfi86pUjMOcVEcOc27C4xGTirMI8jxq6Ea0pmU4bYZhnGJFf2BfjvCIUHZt66N8m1Igr4Y5248MqUbY8G99BXxu/8vlgAjvUVelfnEPq5t1TpvBZyCOuT7AVU1i1I7rd4xGPB6W5pQP3bVNRaRcs21Q+ZHWlO59GPlAy2hCzKHYvaHAYQReckDGCGOakI/Cj/o8z9RzoT8zmmzluFAE4sQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06171379-7b5b-4e39-4f30-08dd368a0b00
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 00:01:07.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQw3/VhvyAfKnohxPwIFZ0GavthzRnBxgHpFCAhU8aZyUwQyeF/v5vHXLwNK42IPWVVghd4mrpxOStPHYpGZ7RnqnUf0nKdM8930LUaYnkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=698 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160178
X-Proofpoint-ORIG-GUID: 7tsmArmQh4l9C98jpZ5yJ88GB43TbCdC
X-Proofpoint-GUID: 7tsmArmQh4l9C98jpZ5yJ88GB43TbCdC


> As of now, an important missing piece on GCC side is the decl_tags
> support, as they are heavily used by BPF selftests. See a message from
> Yonghong Song:
> https://gcc.gnu.org/pipermail/gcc-patches/2025-January/673841.html

Faust is working on a V2 of that patch series that will be submitted to
gcc-patches soon.

