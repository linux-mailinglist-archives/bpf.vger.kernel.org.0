Return-Path: <bpf+bounces-40852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31598F58D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39411F2514A
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063661AAE1D;
	Thu,  3 Oct 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SDzkO10X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iMtP0/bn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA11A7250;
	Thu,  3 Oct 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977724; cv=fail; b=k0Lu42RhvzexugSB2roD1ULarsnTpQUJUs19axdr2qCCFXeU5gZOL+rLmdBfTfLdvxXNEG1fEi9ST0q3e2dals4mKCBoOyng8gTPJtJzkQ9Z+EsEVSMV75exkrEK3wm2QRkBIgldEl3EfR/qfgFZO1SpXxCLrXCxcqCwuk6wXM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977724; c=relaxed/simple;
	bh=pW9aCYyDYb7/MbJxyIA8hNWlbhMTyavqzr6VbVZsPrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=sapnHVyACpQipUFE/lh1hkV23nsvM1tJ+9pgGG1603Pm7vPZXIVV74xNo0YrlGppgpphUWKsC2IOIeJ0W4L7hi5Dp2ctwSEaD0bmT7pNXm19RtgTf0uOms9LG/kQoh+nDq4Agx1F1KA0pt2xSkB8qKVN4LqMw+XZFFo4Xt7In28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SDzkO10X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iMtP0/bn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493FMa0F009174;
	Thu, 3 Oct 2024 17:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=6az4j2XvjdtXEu
	96bkDL6OcCmiWkGSNCAxJEi8xYhwQ=; b=SDzkO10XCtnkbzn02FrVTKADPpLPXF
	YNpBoqpY7A80pPZwf+2Shf01oZkHVTD3uJaKpHN23b6JQwr11YUs6V5m1JO1sdRj
	aDmLA2+Cuk+opaSKyXZjTQijxFPZQjcrz++pI3A04JXRhHBoWXUR1qkzr7ylOVRk
	M2yp7gCnfISJy8rQs+uiOUIkmsxT10piLiTuj7QMa+0NYvHTqf+G5s8X0/8zFRta
	IC1miVY1m8VkDL8eWNKdN5LGkTOc1njbNhtoXsiTVV3Bu2jW1Lch0zhZJEsZIgi7
	rnmmwO32xDXXZ3zIRfw7HCLMkAm3H71PT/0bm1XeiaVqObuBczlVaPGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3cx09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:48:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493GasdF040635;
	Thu, 3 Oct 2024 17:48:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88agm2k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 17:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIWNJUhW3OaRFl7fkg1yR9OYhLRm7/6Co6Qcevf5l3za4Jf/WR6kI/qv7QXc5F85r+z7Sag9o/5XbBuj6yQ67lCRgtQvPwO2y0jKJeHxT0wVzCcN/UIpcWgjfbUsFXcBuFysgX2P7yc8bKeDL7eGYYdhXX8spcGBn3Fr+0E5eDR8tj6VovAP+/OlA6qwVW4Yy1KEzfekj34X0ZVapHuKq9yTngmDaduYZGYLnZDk+l+8SJoMh29l1kOBUWXQtI3GYd9V6Cn6Esgz3b15Q3wvSNeVOPRxfYYQdMkPCJohiesxQnvY5ds+rrkfglHGCSsrsgB5V0IA2DPGwYKkRV7E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6az4j2XvjdtXEu96bkDL6OcCmiWkGSNCAxJEi8xYhwQ=;
 b=h/Hv48GuVbNvXZf1uacjvY9JDYO0wqxmojUZ8NLLwMkGQsTAR1vRZCkzBUbP8uKXLQs78QVlkKVITfLVRdQlQ/r2uuJ4RbQF7MoXq8HXEObktC8PAlY5eB9VUXzeZ98pES2ondaPhJ8E7NhgGhjUC5Rr5ngpUhJ3dy4Taxg1FDf3nndAZ3FWo53uJUJbxQAq54eTAjEKccU/t06xSqfIYMtm1Myd0uXDztKecKIXP25k7wtUS1UBaKSJUod2RfYN+6Fk6EejyfWdLYe+n+TYLiDKZWk6eQXzTE817dwDnFCa73NdhPpEcIDl1wV7Bex2+gaFuU+s70FT12gojkTo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6az4j2XvjdtXEu96bkDL6OcCmiWkGSNCAxJEi8xYhwQ=;
 b=iMtP0/bnpnlH+xZEGrTcusHCZ7bJk9bUBEdrqSIX2gFYpLMTcNgj/wvyfKw29EJ38PS18af8eiB5C2K+2T+9ARg7ZtqZ2cfARoKROyXAqiEIdv0JgF8GfLoKIpxuQT10L1xaY5trXgrKECXd0ks4X8oURbfoptVcuFJPJ9GyC/w=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 17:48:24 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 17:48:24 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire
 <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
In-Reply-To: <Zv7R2RcFRqMPLB5K@x1>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
 <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com> <Zv6v0WdEBg4dEJAP@x1>
 <9cda0821-4b25-498e-acf3-cd8055d82ca5@oracle.com> <Zv7R2RcFRqMPLB5K@x1>
Date: Thu, 03 Oct 2024 10:48:23 -0700
Message-ID: <87ttdtkrh4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd7edf1-630e-4b83-2771-08dce3d39425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAGispwttPxvZ/Z4Kos4wDrYYGoynab7MA5ZIR7ZXo0X4y7Woud+UK1fNVvN?=
 =?us-ascii?Q?2/JFJjyiibbF9UJ3LTCgKSP+JvJPRjgXatUrDlmKR7nng67fyLpy3UhpkCCm?=
 =?us-ascii?Q?AJoGcWE7yTWwWJET84oXu+YiEfyF3bz/J7HqmoDS9jTIeaaJi6Rn0pXVh5g1?=
 =?us-ascii?Q?KV01bLu8E5n6ZMN4JfGB8iN3gbkibLEkMDZ2/GENdKVanyKe5cQWtSU4dVTQ?=
 =?us-ascii?Q?xjYO68qNyXelaJc6Rx+Bwb9k24Z8CQBTE2tsJupG+UbZwkryVdvJKF8B8bzX?=
 =?us-ascii?Q?k7xKD3HpFharSvVc4/QUAZRzsZztYlRnTW07b08xyzSuT0eTuTGqmQFKubvd?=
 =?us-ascii?Q?HGgeeMSvNShUZWT2vAm5+0xuL7FZFiEqQTtUOhy51ukLbtqJZdFFnGRIDqcL?=
 =?us-ascii?Q?9cnTGFGiEILd40YkdRuiGb46QQjUwMIh+rEIqqzcBRU9M/UmFzORoFPXT1vX?=
 =?us-ascii?Q?R38lbdtt4zpZAnii5Zr7iVD3lgtvHzdB+DZs381dkKYYPd5VUAPzkb3GXdvY?=
 =?us-ascii?Q?1aLikDfp2Bh9pib7hXyjw8bHE9bhPR+zoGtYQQtxWqqJozlQUBIKC7dftKTA?=
 =?us-ascii?Q?S40lbtOiNxPwWFJ13kAS6Vjr7u9zUeS0a7Kw24EabhchEMCZlaMj7SGtBLIK?=
 =?us-ascii?Q?GazmGHbF4aTGuPYj7WoKaERKvETKSmJ+PzcPURN9SIvKXcboGZBsaulAGfd0?=
 =?us-ascii?Q?sndiEFDHKHW0T9dCJI35+UGwP0PjxKKqpnaJ5VlA6+kwT5COTWjhZPBI35bC?=
 =?us-ascii?Q?DSuY8X8bFMjSOfzPRhxkid/cz/E+ahKxYmG2QHiKV7/yXhhsHJHNk9Wk8Zqu?=
 =?us-ascii?Q?RDYO81zEH1Xh9Ka/lLz8j8IaHAOdSkSCPNJzgneUDn8/1ZY5NgMd0AK3EOBw?=
 =?us-ascii?Q?RAEEx/O8g69aMrVZ5mlnNc6SHjDb+4P0ZpuoCI5lRdriu0TO0wBBa7n5Yarl?=
 =?us-ascii?Q?PjLh6J9/dHvzd9/4AkO+3+RjXRsQRegP785HWcnCSRg2rRlYgccDBeWNlR8z?=
 =?us-ascii?Q?P9SSqNA7dbHOkhcxUGkXptSpHo5ea7Lr+/Neox7d1owt9TaW/t08JySGoN1t?=
 =?us-ascii?Q?hRAJRiOorpIZwSBd3nnfHqcfNUBXLyCd1CcdyOdx843yMEm6EomKrfxuPpbU?=
 =?us-ascii?Q?iUwtn8Qv//QKHyh/+wbmU/4HQQL+b2j7uHTrZq4B4UpaPhH+/oG8zC1YDKHQ?=
 =?us-ascii?Q?dP9aKCUoWPLc2cgv7Cg8vKe4uJx09tQzGBlK2vbNVKQtoqviA0/mekVN+mDZ?=
 =?us-ascii?Q?w388smGM/qiF+r4z0xS4snMUsO5E0sNCMiY7bwK/vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLwjHQ0X4gSKC0SpOTr1FJJd6KE9eM90U2uB1HAkkkzhRa2vIAlsGxFWthWS?=
 =?us-ascii?Q?McTU+Ce1zQxlkk8iJHOFH9RLk3gwO3YAEcGmUJFXtGyldl7ree7AJjrVJ5yt?=
 =?us-ascii?Q?EfDJLnPz93HogzdQE5cNbVBYa1O7/X/MypeOjn1zjGD9TfTXygY0wvxS8UCy?=
 =?us-ascii?Q?WBrjsKN6vqPkGTf7t0sHsMoU9b63AtOer4pFEjLcTuPqEFVqxgQSkg7LVWsc?=
 =?us-ascii?Q?L7iaa0tHdjNhvEv1ZL6167g/FxdH6OEavydP/kQ2pZ03buOpuIBR6d54qB6V?=
 =?us-ascii?Q?bGfP06mN1sVpI/ApxVJWROppMAGXMg/RqdIqwaS81eITynufdmbAE/KfY3oY?=
 =?us-ascii?Q?bhC+W/H8esuDEgFwlFX8AG681OujrUnwcROYs/aGLpNOrh1hBXJdgOzOG2Me?=
 =?us-ascii?Q?gYpilvxEcLza6n6+C4nVOJqbPnMDihhWHOK5Le2xqAvXIrnU4EAT5/uSg+Xu?=
 =?us-ascii?Q?EBIgbnJfIXqgkApZJAtQ9/btqH21BEerOGOsDowvc2bZGQ6oKhDhmyzILeUD?=
 =?us-ascii?Q?KUKWx2YOH8JxzzdS6sLRmUS5F9unxT5RRBS3kgJtSFcHFOIi+HBkaPnM4Yrw?=
 =?us-ascii?Q?LsgR8EuE80yVK0qxGeAmHkgTo/+ZpWt0tDVuZKLE+tW2pOWEFfcOpo6z/uyH?=
 =?us-ascii?Q?6GqJ+ldLye7bpe4l+FL/V/5e1EZOrIwbSSPV466kkx8GJTSlvMo1aIowqbo6?=
 =?us-ascii?Q?EL8A4Ic3478R8koYcfxz9lcHKVZWHJihj3XSwU3fOkN4K3NgPLu7O8XubwT7?=
 =?us-ascii?Q?TrmN5aZFIyFcL3yQLs2U6lbEBFhwPP/o27MFfqwjLYdubGbHfZHz5Ij3dEni?=
 =?us-ascii?Q?jK3MXiB6fQpNKz4cOLg42w9Y71rHFe+5m+p6Ti1n/snwyacaicDfNRJhPDTh?=
 =?us-ascii?Q?LP+qlvNvIULktQhQkKspC/qBYBXIxp5igAmoj41Bm0aMyhteVYoY8B2FJiqg?=
 =?us-ascii?Q?h8w/nOsMdmwrh9q6VM+KH0WmGSxja+lNPGFcY2TRAg9foVLOR6FculaNALqU?=
 =?us-ascii?Q?CU23MkOusJ8bZ7tRy+2+xC2PhVtK/kXoXHgxBtfuW8EcURs3QAEhzLzwoMws?=
 =?us-ascii?Q?1OxFbQ+TK1s3QCZVs89kv6QZmMb90pWJZI/ix4Q5foQ2AY5IGsPVITHd6fjF?=
 =?us-ascii?Q?5Rg9ay6DeOi0qdnOy9XucPVWf9sjwOXChDpSDl7gr0h66XaeTF+HL9Fvym7S?=
 =?us-ascii?Q?EwjxYfqQi9b1GwUCyrY1RRGl+t7HDpOxti55UpAjZtcLsy6d+jwdpiNOTxho?=
 =?us-ascii?Q?t6TCf2tpAAh0kzvlcQ/vXLyCQsiPmDgM/bLHEdUfYS4XwNSGjAjPBfnVORgR?=
 =?us-ascii?Q?kyILBZbStDlRasqvx4h9ZBi5mtRu+Ytimk4MhoTdTL3yJ7uOvRZjA4E4EpgR?=
 =?us-ascii?Q?oG6FZoKC8NZII0RvCQvYkwrzK1MM0pJc+gk8t1hGyl0Ex6kGAJFryx2iWgeD?=
 =?us-ascii?Q?i7UKcj/4dQgR7Gzwzn62GM62oLcN5M8TfbxF+Bho7zvKHIXDhHy2BT89Qkqn?=
 =?us-ascii?Q?JHmYsX7h6W7U3Qd4sgynbG3ccaT2mMHKgHyvMJ1iF+cCWMGIdLcZ3YUEdRFx?=
 =?us-ascii?Q?aboJjGio9dYxDxCXPB5v/nhDVO2klR7ZqnzjMEX6bMIP4XXKKpBZFT895ZBh?=
 =?us-ascii?Q?GhF5qSpIm/RMaA4HE+SUYTA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UHQfQ8PlnLWpWOPr9LSE2N8U59sl/TPpoaciP2tILABTPwsSZkCedliNntc2QlOJLKzPyVcURoGkEdRbvcS85n05cNwvjZxrAoL35zvNTpv1XHt1oIYYCRu/LobOtaCe7zJSlUABbElNt7kd6X9b4uzGfvpaHfu8coliYmIOg4vCm6EwhWK5mT0oGy6nfzfjwrgDUy3BqM78hofetn00/s1n8FtXUQ6VBvcBJ0YfR1uulgdlaCEezW8pQufNSPFt3caOf/aztldhv+6vLetfIlt+WB7/tgRxxsRfMk6jKr/tSQHO4Jns73ummwhT3J48YhEk7Savahl0kHWCbPTBSPmkFZyksPQNRElhg3LA3OkPHY1T5s+pHNvzGp3go5GZ7bTPhrE/EIMO+Kk5Pg2yQoESJ3rUIgeXVVqEStL1NuRSlvYU8F9g3Tw+BAV1zPENtB3yt9UgiRgHAdnfEhVmsmGRHQK6CaMPh+fXYAua/zf8mLTj8cAx9QXj1bSo0rAsq0ko0mFmulsuCXujSt1dfHcGHrw/6dKX3bgcMl7Ww43N4eQGIDrmnvquKliMYar1xmmjll5C6lp9ESHcAiKXAPVqPTk7Rt3RleWdP29nxQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd7edf1-630e-4b83-2771-08dce3d39425
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 17:48:24.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54H1CR7fkwhlc3TkA9+4SVUogDZ+qLwPm3fCPElKfzY2x8o17Tigwr02+MGFRyLn2O5HGHqFDt8L7jHALPR241lPkXoxwkjLndJGYf6AVj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_15,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410030128
X-Proofpoint-GUID: LxIU_Pi2GoZHxJjP7k1o_MEeXTqYZdEm
X-Proofpoint-ORIG-GUID: LxIU_Pi2GoZHxJjP7k1o_MEeXTqYZdEm

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> On Thu, Oct 03, 2024 at 04:21:07PM +0100, Alan Maguire wrote:
>> On 03/10/2024 15:53, Arnaldo Carvalho de Melo wrote:
>> > On Thu, Oct 03, 2024 at 03:40:35PM +0100, Alan Maguire wrote:
>> >> On 03/10/2024 00:52, Stephen Brennan wrote:
>> >>> So far, pahole has only encoded type information for percpu variables.
>> >>> However, there are several reasons why type information for all global
>> >>> variables would be useful in the kernel:
>> > 
>> >>> 1. Runtime kernel debuggers like drgn could use the BTF to introspect
>> >>> kernel data structures without needing to install heavyweight DWARF.
>> > 
>> >>> 2. BPF programs using the "__ksym" annotation could declare the
>> >>> variables using the correct type, rather than "void".
>> > 
>> >>> It makes sense to introduce a feature for this in pahole so that these
>> >>> capabilities can be explored in the kernel. The feature is non-default:
>> >>> when using "--btf-features=default", it is disabled. It must be
>> >>> explicitly requested, e.g. with "--btf-features=+global_var".
>> >  
>> >> I'm not totally sure switching global_var to a non-default feature is
>> >> the right answer here.
>> >  
>> >> The --btf_features "default" set of options are meant to closely mirror
>> >> the upstream kernel options we enable when doing BTF encoding. However,
>> >> in scripts/Makefile.btf we don't use "default"; we explicitly call out
>> >> the set of features we want. We can't just use "default" in that context
>> >> since the meaning of "default" varies based upon whatever version of
>> >> pahole you have.
>> >  
>> >> So "default" is simply a convenient shorthand for pahole testing which
>> >> corresponds to "give me the set of features that upstream kernels use".
>> >> It could have a better name that reflects that more clearly I suppose.
>> >  
>> >> When we do switch this on in-kernel, we'll add the explicit "global_var"
>> >> to the list of features in scripts/Makefile.btf.
>> >  
>> >> So with all this said, do we make global_vars a default or non-default
>> >> feature? It would seem to make sense to specify non-default, since it is
>> >> not switched on for the kernel yet, but looking ahead, what if the 1.28
>> >> pahole release is used to build vmlinux BTF and we add global_var to the
>> >> list of features? In such a case, our "default" set of values would be
>> >> out of step with the kernel. So it's not a huge deal, but I would
>> >> consider keeping this a default feature to facilitate testing; this
>> >> won't change what the kernel does, but it makes testing with full
>> >> variable generation easier (I can just do "--btf_features=default").
>> > 
>> > This "default" really is confusing, as you spelled out above :-\

Yeah, I spent a while staring at the comment and reading the code to
understand the nuance between the initial and default values. I don't
think I fully understood it until this v3 patch, and admittedly I still
didn't have the full context of how "default" was used.

One interesting point of comparison is the "-M" argument to
"qemu-system-$arch". For example:

  $ qemu-system-x86_64 -M ?
  Supported machines are:
  microvm              microvm (i386)
  pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-9.0)
  pc-i440fx-9.0        Standard PC (i440FX + PIIX, 1996) (default)
  pc-i440fx-8.2        Standard PC (i440FX + PIIX, 1996)
  pc-i440fx-8.1        Standard PC (i440FX + PIIX, 1996)
  pc-i440fx-8.0        Standard PC (i440FX + PIIX, 1996)
  [...]

So the default "pc" machine is simply an alias that gets updated to the
most recent machine (with potential new behaviors) every release, but
you can always select a specific machine that you care about.

Maybe it would make sense if there were versioned defaults, so that
"default" always picks whatever is relevant to the most recent upstream
kernel, but you could also select the default as of an older pahole
release.

That does sound like plenty of complexity added to an already somewhat
confusing system, so I'm not sold on it. The flexibility for adjusting
to new kernel defaults is appealing though.

>> >When to
>> > add something to it so that it reflects what the kernel has is tricky,
>> > perhaps we should instead have a ~/.config/pahole file where developers
>> > can add BTF features to add to --btf_features=default in the period
>> > where something new was _really_ added to the kernel and before the next
>> > version when it _have been added to the kernel set of BTF features_ thus
>> > should be set into stone in the pahole sources?
>  
>> it's a nice idea; I suppose once we have more automated tests, this will
>> be less of an issue too. I'm looking at adding a BTF variable test
>> shortly, would be good to have coverage there too, especially since
>> we're growing the amount of info we encode in this area.
>
> Sure thing, the more tests, the better!
>  
>> > So I think we should do as Stephen did, keep it out of
>> > --btf_features=default, as it is not yet in the kernel set of options,
>> > and have the config file, starting with being able to set those
>> > features, i.e. we would have:
>
>> > $ cat ~/.config/pahole
>> > [btf_encoder]
>> > 	btf_features=+global_var
>
>> > wdyt?
>  
>> I think that makes perfect sense, great idea!
>
> I was looking for a library to do that to avoid "stealing" the
> perf-config code, but perhaps we should use an env var for that?
>
> PAHOLE_BTF_FEATURES='+global_var'
>
> To keep things simple?

One concern with configuration files is that (at least on my system)
they tend to sit around and get forgotten, unless they're super well
known configs like ~/.bashrc. So at some point, I could see myself
setting a pahole config and then 6 months later wondering why pahole
behaves differently on two different systems.

Env vars are easy to set permanently if you want, but are also more
visible and centralized with your other configurations, so they're my
preference.

Thanks,
Stephen

