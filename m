Return-Path: <bpf+bounces-40801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3098E76C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EC92840B8
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C971991A9;
	Wed,  2 Oct 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKbjaElp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SKsXdaHl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEF19F11E;
	Wed,  2 Oct 2024 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913186; cv=fail; b=eWnxaEx8S4r0q2fX4DL23wNZ31SxJf3ACBZdsljxjqhTlo/shrsNxjbSxl/EBE0aEwLN3m293W+DnKKLrCy30V3/VVGe9MJeRxQtyGqYPE9Y/5n/nAPQNhsORZcjQNEzPeatDUaP943VDt9YU1iSa69bDys/TzkfHXijwQSwxQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913186; c=relaxed/simple;
	bh=MvLyetgH+KPoMxLmPBsS/gLHDNcqr80lXeEHNuLzfA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsQLCSN0zIr3v5wTQDYKTy62geN0NKMqBh0MZrWyGq1G5nuX2Egel5FRBhnhfk/Ob2vH5WHmdx/d3fFcdjlv2lMh2N9ygOsPiuL/ti6FAYgHfYmkzscPsKlqusKzmsZCoNx0swjcJCHmH5fEVXsnv0pp19lxNsOe3rBfEWlQGBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKbjaElp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SKsXdaHl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492MffXa023095;
	Wed, 2 Oct 2024 23:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cS/5+NCdgo3qKZ3FTO8/7PyLt/sD7dGd/9NM+VvReBY=; b=
	IKbjaElpBcVUB+BS+68RUJI91dHagteUVp/jzq6jQ7BR+V8VEddDvY2Ubwiakf2x
	6rIorYNPDhW+g9i0+IdI1bBeQ8QY1EHxGg8Fci8KivWEBy4XMTztjW3E9g7xPwcn
	tyTV41Z6cYqh897ZHRPONLWvfjFqDx8thTsV4WVBzlgN6B8w/b3nFrw1Q93SKGBd
	xfJvbXgh0rm20Ps6GJReNCIXSxL1gKydxdkr/WBcywLo6XUjKsnpsc03Y/Qw/0Kk
	/yAhUIXaMtRMbq/rKfUNnYGozDeThGYlsZ2ruZVHjXh3uqCZ/liuBvUkJfbosjPJ
	7hRYFUKCLvUIJ6KinLlaxQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabttst9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492LQoSI017460;
	Wed, 2 Oct 2024 23:53:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889g60n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wjhud2PGbr/dt2wN66YkxCuyrfpUiedETdrtpf5OloL7DYNrtz08sFng9eNJNpFmZu7/eQ2+OemLaU9L6c7jzQJcowjcuhAkBy5lxX+TWuORLFsAS9LGAi4+s707FcD5xEB1CufxDgegVXQaqX7+Kj3w2Bd9wrJgEkldBwXeLpVVbFmsqDW7FnjX7FNfMAsZR7Y0TlzqpqF5n/SThNFlk0dkTLVCvmC4WO/rtMIt+ff6Kf6RPCvPEQe+TR5eFZEYPdmWAwonAEQgZ0UDj9eIxNB8/sYDSmlaY4u8qpbUXs7S6VoraifuECTqrWEIOo/yBMbEbHx8vRmrYaloKt+Yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cS/5+NCdgo3qKZ3FTO8/7PyLt/sD7dGd/9NM+VvReBY=;
 b=iqIg/BWFRx5/rlYSxP5zW8vbhFZzApwxTULv8WOYBRf3Mfpqt0EnFEsWwTriw7u6E867El8eYHe2VoGjGI/Hsx4EVV5iXkFbvntH+V3QN6MdB61Vlai6AqA+RK1uLsvMvMJCWKTU4vA1LUp16OpDaW4Zkw3n1T0MbpohxpkidBK7MFZY06sgm+aImN31rMpjau3n3x0sEAcQPqI/KkueV/Zj9FOFp6WKUJw3R5TNlwnjb9E7kxLHu6cGqInDEspHj1ltQJO78yu08QA6lJ9Y2D7o39Dk1F8v8kR+PHg0bfHoQMyFEbbRe/fynHTLVIF99zaKKQo8jx1jC66Heq38Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cS/5+NCdgo3qKZ3FTO8/7PyLt/sD7dGd/9NM+VvReBY=;
 b=SKsXdaHli/Rr3X9nny9w9hgiQJkA6QnPTYTdmkLi1eLJH+dpXotuPVfFEUVZ20xtWAMr5b0FFu1HMA+VgX51BVLfopa3ERRbQ8k8fiOeJfyYxMQhf3SRkIk4fzwe8o3DjZz2Wr3rgcA9aKYyaQ/vZju6wg7UIqsD6apfU1js3LY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:52:59 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:52:59 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 1/5] btf_encoder: use bitfield to control var encoding
Date: Wed,  2 Oct 2024 16:52:43 -0700
Message-ID: <20241002235253.487251-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e699cc5-e053-4b17-95a0-08dce33d5801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baRnr1tikJ4QVrwjqUGvx0a1fmnzWmfPFhV036za5SOe7z4hjIS+a7tMQLom?=
 =?us-ascii?Q?uhx/n36UemRlV7TW4ne8Ll0fw7X5DX1LCncYHT6TOWEPADYvi+neiquNJ+om?=
 =?us-ascii?Q?s6PZtXCb54oWHtvmvJdNjgqPoctntGuW+KHyeHHVv2H6l442RjYnxfC7EmX5?=
 =?us-ascii?Q?KALqlfzeEX1iTdosSfsTiZCcCNBFJJWkQhk+w9c2JsFyUEDvF0DNPvnBte0c?=
 =?us-ascii?Q?FFaWhzNUJcYhbNwJzvIUCGLMVCkuvE9g+TIbFMFYshl9cNYov0H2V/5BICAQ?=
 =?us-ascii?Q?Br0wPdnQ0MlbmEs6sfOCcm0rxjGbpoqLfIdYGNQRG2MG0KrxSpydLfquHHoC?=
 =?us-ascii?Q?ZElWQtD8jB7torfPNx1hypXVmti3O5BsJgj+t/b+csJjPdp4x/IkGo1Ev39Q?=
 =?us-ascii?Q?CQKO8/s4WbtNfnimTHznqNxlLkvC171RpryYFHCN5LO+NcNBvohiWO4YV/pq?=
 =?us-ascii?Q?pnPoEG7No7YCb8DFPapIYyjfaIbYg30Fxy7lNmGprbs7nZGxTPmCrDSC88lW?=
 =?us-ascii?Q?+8wHxERj5df4aJJDo4cL2b0dMyIjRwdh0ahaO3gFcyA5JgJ72NEtj2mV1UY9?=
 =?us-ascii?Q?N9pAxVCJmxF1XoQqWmSpwt+Aiud+d1r72Dn0iEABim7dla2A2SJh3a7FTYyk?=
 =?us-ascii?Q?p5iZ0fx9187l+SGNP3orZnPda8shNFPTCbTpCk63EuduZizIphmakNPptwgi?=
 =?us-ascii?Q?KXqsgsKoEeBfTU4UfB4LPtMbvkcIp1+bmKFzIDZzoi0AOGTmsB0QAs0t0iQU?=
 =?us-ascii?Q?oA//FzUG/wJqNMtMI70oIXjXzb33ftx+fR2C99qLWs+bRyzaiyQmDvb+4W5I?=
 =?us-ascii?Q?SF0N0mEybYN7yn/QWeVzeFQT7b8XxV+dsHAXaziQhazvO+QTES6J3ZtfXsYs?=
 =?us-ascii?Q?ePluf3J3RrmRi8xdEKx9MZMS5fc4f0oB5huepBu+X2X8rTAyw5mw4LvR8+WR?=
 =?us-ascii?Q?TDqhs2Dwq2wApz+EAfxa5f2ufrlcCqIbHgq/bf7KPJa6JTuwgqhLhCkwjyPB?=
 =?us-ascii?Q?2BTRKwjQx5nTfW+6eig6c2BjO7vvkKD1FqiX2il/moABa2vEAjATMPfkPtYc?=
 =?us-ascii?Q?/vHkgnRkorF8eRvXo0hUM36w9YbbaQ33kx/Rs+6Yaim30JKub9Y0BvXrXb0L?=
 =?us-ascii?Q?tJA56CGcIRqzR9iyVLv4EK9hdkIjAfnc9L5+9jeX7nxVc60ZU2BWTGx8BGOJ?=
 =?us-ascii?Q?GLDEuAb3x+VANQLmnujtkeSd4fTyp4KnJSLT3T7LXyk9SCpb/H57j2zqwwVe?=
 =?us-ascii?Q?tVA+HdSmXm3NRDRr9Imf5xO2ByApT7OseP4sq7mzrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LHzOJNOXv+NHUk28U/O7/E7uUyFZlwO86WJ5o1aqLczdxOquxh9uDgdstRT5?=
 =?us-ascii?Q?sxdbIs6E4lemWsSa37xmI7i4eSgij2H4IWydVSQZ3Z6ZUH8YImrzE9bXnaUd?=
 =?us-ascii?Q?A/cB6qhqyq3vLU59vrtK7rYR7/4O8BQjf0G3u/DnEuLqIb+uxRMCElm0XrWf?=
 =?us-ascii?Q?HDBrirAsdHHeGkRDA7gtpvVw3dJCbyGy748eep70KOn9abtDJg+RPXxLWLdi?=
 =?us-ascii?Q?By0Grm5hK2oz/DQJx151MYHc95AjkHkzos4qXQJI1e5YDWgycE+ENdrP0SXP?=
 =?us-ascii?Q?rjyAuFhRh0srMdaycwKscC2f6jQWZAXShYa2nJy6zedpoik4gZnypxN9bli/?=
 =?us-ascii?Q?1Krsv7HfqXpAZsfGDNPw7kwcGpndCqQo8qKize9N5fj5icnmI2Ko1HQp9Odm?=
 =?us-ascii?Q?KWmAsRp8+ZVdfOZcvlO3rdAPmzyjTeKuV1BhFLhSxQGZbHthRBgJdspn2Rtq?=
 =?us-ascii?Q?AoPDcPbFBH/XPT1TqzaTl3p3lM46EqnoEvOgsLHeM4KHZk2D4CXmSjIQU6Y1?=
 =?us-ascii?Q?C0HKZR0Q5vKADBpeR/qec2tKXSwl9f2fTZDvAb1EwD97/2cA/ptIUbJIYvBf?=
 =?us-ascii?Q?w7PqytHghB7NLG6Af5aR7cYofJK3y70ghCRgg2+YwHkjthj+0nS5MvDIomFP?=
 =?us-ascii?Q?IfcMrdwfXLsXscRIirdirSvuTtBNSk38i1Q2SNAF+303viKR9j1ukrrNyjT6?=
 =?us-ascii?Q?c8gSLqT6sDCRrtCoTbFqhX+DzFSvCHySaSEODhahai1TmLRtpbWXM2HY3gfx?=
 =?us-ascii?Q?V0aVq8WTFIEsqVT2QCxVu5uIMMSAtAei9NN8PYKz1K+Q6GYMdDxs/64dK+pe?=
 =?us-ascii?Q?0EqyvBe4ddyMgjuO4wCmmKx5CoTJBdlQ5wvz5EtEV8tINHdujxzPPGJSLQnj?=
 =?us-ascii?Q?zjn+WOZ04Dlmf5UsFLNn/PPUV48g5PTsNFq+pUUUqqWDYiYDc4PqhqfskJDr?=
 =?us-ascii?Q?GXiWwqhrUmgrY5SkaVm2rnFZoY26ru1m/5srENCdvhWhGYPsGcimxgH7NRl/?=
 =?us-ascii?Q?RnT2FOVSWv2pknP5S9GjVDT+WHgNsDykoRtHNpVRcmz24ndtLwF2tn93Fs4M?=
 =?us-ascii?Q?dSFVD2SFjoAWch2l3/yR1hzn72lmgX7YSlyIQCiTNrMH+y/3zp+Jv2zUJqNS?=
 =?us-ascii?Q?PtAqkaP28Mj5xbHuJFL2MjqrJU7gHHWnuslOXbOjrPg0zmkLKtv3AHmXgp5o?=
 =?us-ascii?Q?aYX5K4Cll1lWVCa58c+Ne6GLcAG8tOnPGoF+AR+YzsAPN58EEvcxzsgy6Ukw?=
 =?us-ascii?Q?xIIUAuf3EyRtfhjKhXQI7MaHk9bX+UFtQ5LMrEuWaJQwQqW1XSATJ6gIAG60?=
 =?us-ascii?Q?XgvhFGScftUsfAZpbFdW9yDM5SXjy3Oj1oONv4NiyuDVZXkR4OXKu+QbPSPJ?=
 =?us-ascii?Q?YcTyvMRqJrvJgTJAPA7ue45eei4DF5OyhYzXHkfgGsJovGU7NKMih24GloAK?=
 =?us-ascii?Q?2/38X4ydlp0/FqlmDd/RwjiuENFUqVQIREReDVRTinjqD9vghkX3DGaIMpB7?=
 =?us-ascii?Q?JpyfU6TRz9egzPD2ubOOkXymahr1ykongLV2j9Cjh2jYSpsEVGsp3O+X+wwG?=
 =?us-ascii?Q?rZ8sUO0bgAFLy557yxpjCdll69+hBnvMQ3fCw8gKyxL6sC8xE6mMHyPjJrCQ?=
 =?us-ascii?Q?IqEnwXbyCvvH8zCtBu9thsU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fuD5rrTY8GV/Pd5P/RB/yYypO4a1gIWxP7TPJKDSpLCDgpFQ2hhEDdWlgBaupOi8HGCMj5YhIe+m02jfrT4bzx1Ul3/6Epoe8bHjoZXplNBaRUo7V2BgOQq/Bl7hL1eQqX5LDKBHjXLzU40oEudBt2elLMu2jdcqz8fUyh8PcVDHA1IlDuxp3WnonGUGhvyAwNf1BXe1lkXSl5FYMwP3f6RcQXDdinwkvHfrp4ZWUnI5QvxxWKJF4+Xd5i5RZS/Yyl7DO4D0XIexHs84DtAvKSEkyAoyefoDLOrA7iTAy4Byjau7mw0LV/ZdtjW+7SuHr/KCgxhHCBzZaR+t7oK5v1eFXvDfToFXhnGOB2/FunyzTH0aYjzD6MBL1aHppyvaNv1h1lrjXPvJbll1KlEnp+mWGZicDe+LcDCCJKzsbsc7FCeOKK4TzAttgpp4MCT6FWOnh2A6itnp/NtTv6YF1bLRZqhgMCzihLgIclJWx2fxbWuxHUvtv3YABcK9gOBJ+DD/kJc3bZa2IkDsh5EaLgAWB9+whap8KrjL85A2d+Pck7EaDy9OL2UeSzWdBgRoWbGhnfHeTmMeXwXHsDv+XkHgyrcsrHq/oZkQ7JQogGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e699cc5-e053-4b17-95a0-08dce33d5801
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:52:58.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc9d7QOeH6xVQOkL5AHXbeqVm+ov3ef/6cHZ0AydfV4C9SoMP4ZSLw1sPArbo6u0+QlIqxtsQ8XQZIr3PxXjRxW19Sixi36KTROxQhlepJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020169
X-Proofpoint-ORIG-GUID: 7d5slh684KYydDnjCd4Eify4x_iy-YHG
X-Proofpoint-GUID: 7d5slh684KYydDnjCd4Eify4x_iy-YHG

We will need more granularity in the future, in order to add support for
encoding global variables as well. So replace the skip_encoding_vars
boolean with a flag variable named "encode_vars". There is currently
only one bit specified, and it is set when percpu variables should be
emitted.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 10 ++++++----
 btf_encoder.h |  6 ++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 51cd7bf..652a945 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -119,7 +119,6 @@ struct btf_encoder {
 	uint32_t	  type_id_off;
 	bool		  has_index_type,
 			  need_index_type,
-			  skip_encoding_vars,
 			  raw_output,
 			  verbose,
 			  force,
@@ -137,6 +136,7 @@ struct btf_encoder {
 		int		allocated;
 		uint32_t	shndx;
 	} percpu;
+	int                encode_vars;
 	struct {
 		struct elf_function *entries;
 		int		    allocated;
@@ -2369,7 +2369,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
-		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
@@ -2377,6 +2376,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->encode_vars = 0;
+		if (!conf_load->skip_encoding_btf_vars)
+			encoder->encode_vars |= BTF_VAR_PERCPU;
 
 		GElf_Ehdr ehdr;
 
@@ -2436,7 +2438,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (!encoder->percpu.shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
+		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -2633,7 +2635,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			goto out;
 	}
 
-	if (!encoder->skip_encoding_vars)
+	if (encoder->encode_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
 	if (!err)
diff --git a/btf_encoder.h b/btf_encoder.h
index f54c95a..91e7947 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,6 +16,12 @@ struct btf;
 struct cu;
 struct list_head;
 
+/* Bit flags specifying which kinds of variables are emitted */
+enum btf_var_option {
+	BTF_VAR_NONE = 0,
+	BTF_VAR_PERCPU = 1,
+};
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
-- 
2.43.5


