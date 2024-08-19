Return-Path: <bpf+bounces-37515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58502956DE3
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD6B26F60
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9157173355;
	Mon, 19 Aug 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lb1LCVjE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OdJLqTmL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4416C6A0
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079209; cv=fail; b=EoyhJopwHC4HF5slllMooz8LA+8HA5q+P4lnMo6yrHSgnHoy0CP34cE78PGe1n8FNo7b/LPv5yGYQ1yvDOTvr/p1Mq6UWMpwsowapQHuDiipptnfXhbQIs/h+N8Z8YORU8tvIpcc6y8cBIsy8PnWzIYTbMx2yXwQjugONHnboBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079209; c=relaxed/simple;
	bh=m4ukiOGIsibsa9KJM60XGEwJE/KeekEJsQYaff9RJug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TiuqozAr3kMtxjUiAB14SLOpi0PdpKKLCL/wTFH7BC00l9NJPFDY/MjeaFARbi4HLWoteaQgP6s1p80IDFp3ppSp7fl04zW/EjeLlcnSDu89Li96DFFe3Jhq7B/vIGjDlKBUfCC22mk6gnzkfLKhJl6wCPPbbmO8zuo2SRpB1BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lb1LCVjE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OdJLqTmL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6ujP003650;
	Mon, 19 Aug 2024 14:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=; b=
	Lb1LCVjENCR3pDlyMX8iaylIdB42brXtQ+NmLSvtAL5zALyZ83IfkIspW9f4TxW/
	JW6nYGW7uqRob8nBl4hWJUrtDnUdtiUlSDdJV6zr2DSVg8ZidOV691AhsLHLcw+V
	R4Z0XtXh8x1BUlXNKoV3AFwmwYMr+Aw97s1u1WHa7H2aWpXr9UGvxzEeG1iihAKD
	13aLqYYO6GObXIaOqSZ09dNrq24WnFPGVwd89d3MUQpQzmlIdvi1mJjOLbsnneyY
	6Y8Zz9JaLnh8QZSvyBmgsNHP3SxtsgvkzTLcckepSVubvtumTjo95OGGMGch33Vo
	ncbFxZcrrt4zi/NRuZLGVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4utt8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbHb3018978;
	Mon, 19 Aug 2024 14:53:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h4266bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlL6vDvtez4TXqBBrF15yPXArU3LQp3RA4lJrvjJyT+F0qSsfV3vR6Rb7EcDPYTKUqKSy+q+eJbljvk16ZByxw6EXgTH9e1LJyHX2PMWP0DdWWHLuAoTVZ4BK3EOEL/ovweIwWbCMGsP0j73+xDvmNPjUshk9Xq9yTwuYLJ4frWq5HVE/0uTCXUgpG8HIMXscMRMvu10983LmWYTy1vE3eLFzuHb19keREdNM2wDt89xArn+JedOwZEDoPafK6UCdZxwokuzMC3T+0UkJWaafsYxfRkahaxq7PW0BE4EaIDEVHkJMJUgy30MMUKX+1hN7pqx8MJCsW48O19qKrDNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=;
 b=NMvzwhs4gKDC2llerBPTBIH9F6NUulzirXBqHtIUwW5GJPG9z5P3nZCOatAY5yiE7PVvC8F2yG++61OaPZblrxazQs4UQw/iydmfp3MkcGDDXZHj94dFDZ7hiru6aEW+i5488pFXSy31yfeZX9GMJlUPpyKzmfaVkJRTKNSO+yMXzLxul/KVKQNh1mfD+HO4dQmxNGJw/EsQRenb1xE42vYRa7rCdXLmPU3zZJko7KXpg/vZ4pS6h+3e9PjcaktB+lP7cxl+Ccwnt2xcGSG7okKE59RVUyZPfc+3uc2hObgGFdj0MKOWLzZ9xZYVavvS0a99lBfKGbyF/YuGcRlhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z35dEbfkB2VTX7MJTmShyELW5+GJMSHjFCMRfNFiARE=;
 b=OdJLqTmLajo42f4tgypGnAriIXdxo0d/2sXmjgbsLqg92sP6al8zeuPOOFQLfsSoHP4AtWSmluVKPv1QuSsFhtwHmtq2EMGMxiL35byvDgmGKOPvWRUV1/8zfsue5jyv4u1ybXKL2xcRl67tCRbvVhB7RdxoOXvPXntImfuXFpQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 14:53:17 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 14:53:17 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 2/3] selftest/bpf: _GNU_SOURCE redefined in g++
Date: Mon, 19 Aug 2024 15:53:06 +0100
Message-Id: <20240819145307.1366227-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819145307.1366227-1-cupertino.miranda@oracle.com>
References: <20240819145307.1366227-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::35) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a33d83-9593-4a9d-c7d9-08dcc05ea8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pU80UHipWhTuilLxztYSraYmn7iwnmqXaaNxPrkaW4V3XQHUPYaabSU3rOZo?=
 =?us-ascii?Q?YupzByAFgCXVgXpjjrzFQbLeBrA0Evv2bm2WI+pr+CeVttQa0EoyUHKzzq2Z?=
 =?us-ascii?Q?kIMhpg9Pnq4oxeyTAZPwcl+HLS+yzdZIxKEDiX+d4upqv7rpms/Xq9QuSuNd?=
 =?us-ascii?Q?Ki8oMQcR01ktfZFHN+XGeNOOLR3BXWUqikeybzVOiYeGsawter6crnnlzh+O?=
 =?us-ascii?Q?7ZZ1LyPrzrt3cOZvzEwzXnD5h/dyDAyXexQRhiQymYjv16JyqBWTmdJ9AdS+?=
 =?us-ascii?Q?4Ipt4mGE1C8vq0hfIVP57Wi7CAMyApWcCxTkMZirmKSbFZ3yKBg9EeYmelRx?=
 =?us-ascii?Q?6UUa59cJoN7mIbjfALgxbuNy354ls7mOGs7tcdg9zTwtSM/ft9NY0q2aeU1l?=
 =?us-ascii?Q?837fKos/giN8h3xlcGdV0+l7MjLxo1ZWIEOLlF1b9cvQ12rNXVuXoOqACn+H?=
 =?us-ascii?Q?oSJ9gMrJ/63ONfd1e+sHKE8hmxb5SZExL2OKOOFpMz3FTq1M68Lnv8zeNObu?=
 =?us-ascii?Q?oMMC1iV4UyKZYayHDo77FFnx6urOBDjSL86e/0NeBIgNDafbAUWyku6Cg4fD?=
 =?us-ascii?Q?Q0YX/mZuuw7SfIxySbJsW2lfX7OPWX9CfpFeHIu54heIFOm4jvOBSFwQxJ8x?=
 =?us-ascii?Q?YAPMAXpHTWegRpQ3jsDmO+76rMrBk4Xtmwu1zC8id8Yg6g8xpt3oxMPlBvCa?=
 =?us-ascii?Q?VW7gXdRF0UsNxzMmJtBul4HmAg4eEp8RiHQWmKDg5Icj2qbh0tWc1mKeb9Ye?=
 =?us-ascii?Q?jTnLQbZo7zszrh7B1bWwrxSu91P61TQexrtxzoOlCc1j8npDYlmu1Sev4vi4?=
 =?us-ascii?Q?jq1Ce/JSgovS13Er8YdggSx1mudA4rwggYZc0Pz0SD7IcRgZCYXRKQsTmp08?=
 =?us-ascii?Q?VArRm7ElST6A9KsmKO8PrbzbF1aFhJzJ2LXag4oWnFFmTf160ssoJIKQdMVM?=
 =?us-ascii?Q?/03Kv2Uuy5mlmktpsIWgBn4sSbiksVqTNWDbyvC+6gLPvXTzwfeF8M6vAc2m?=
 =?us-ascii?Q?X3ZoTbHlgxSWHyDWnYXVUdj+07Vbgu2HhmXExtKk2Q7a7p6Gz8D3l6OPnteu?=
 =?us-ascii?Q?5+PJl7CIdppifiNBxK471JogosIxTPVVPDmsXvKQEUU8UGYECzY6O6a4pSK5?=
 =?us-ascii?Q?EFBCOoJIrH/NbcFbtI9KuHiNnUsqrmwK2yz+4Y9Ksi6bMEHWhg1j+8aCT/a2?=
 =?us-ascii?Q?gOlUkx/laCPHNS8wfrwqkszj8wzU7HCNraIRrNSD6KUUwESFA+9QzX04Svme?=
 =?us-ascii?Q?JZ9aHOgkACa38UAg+0Lqsk1LQm8F3AI6XOU0MOFEgq0EGrU+Z2D6Z+FdIgzq?=
 =?us-ascii?Q?E+MnY5hsL2EhatAuPskYFAwlXtA0YK00EOdnrbVEzRpAjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmA3M8KnDLoXT6WbovtpboH0yW8t0Rm7r30lmg5v8aKq5zmSU7XUb/6QYQZo?=
 =?us-ascii?Q?yl4B1+INqIEKz9yxw1/60d5CI+QgiK1WmP0Hv5NpIIvFzPYTMOh+ZnqD2EYI?=
 =?us-ascii?Q?3MUAYaA2AAyfF2g8FmTlqz+q5Ic5kzeqWp9S4o842jo5nrIb71iSKMUTPrbI?=
 =?us-ascii?Q?VzqDE2h2f+xF5nxtxwwt9Q+Vk0DHhMf0TNL3agH0hq/lFGn9/6/bUscKSJBe?=
 =?us-ascii?Q?MFkGGfrU4tSy4Cp+40rEoy/X5BXjL/2kiqkVXKFHj6PmRhjC8+gcKVJHe+Fl?=
 =?us-ascii?Q?+L6mqHTzRsa8xzgcwR0Bq+m/E88tRSYyLp6baiQHtO/+VhmqHIOkCig9eIem?=
 =?us-ascii?Q?k4ndOU4wsZaYfavE9/rdMcmiUX6UWRFL7DxaC0n5+cZCb/PghDqBIRtpuGdD?=
 =?us-ascii?Q?d0N7yKEYrVmzlhwkeSnZzjZYCFcbP8Z4YMdjPKYzQDpnWevHr/GipbDVhWYy?=
 =?us-ascii?Q?auHhlAb9YArRnRbCXBMdTSeIZeSNsSDwHlcljbL0BF62AbfUdQkya5AVQLQp?=
 =?us-ascii?Q?Y/0YQv6C/k586uwZte5jrrunPacQ0uRqmHLzzzGqMegkI07pWWy1Ckmz73lV?=
 =?us-ascii?Q?gFjnHSz2rVM5DzJrdAleUXIDyM5djLhPo5U1VsBjxRl341Dpmgl9Jyw8Ogej?=
 =?us-ascii?Q?BMgIwE9CNfMA1lXwaZjplTuxzq8KZyAFfWst9aGyWw0IAgudVUitHLXQoLuN?=
 =?us-ascii?Q?Sm2Qb1jJUFaD7MFAfc0G6ESsnsQVHC8MH/J4LJYmLI/EG9seORZf9J7as4Ci?=
 =?us-ascii?Q?NX+0GPgMc0+kBWj/ExA4LucLZzZTIyWKck1HCAOO9yZtPM0aXUJw2LGFFF6y?=
 =?us-ascii?Q?vW+cAGyQ+BF6vtfuwh6XShSc1ObGCXmG2EF2jJcDqV4/JVd272rMdbQ75RIh?=
 =?us-ascii?Q?sEuihcNUSdpGIkksfjnjQXdO1ORg1729dHUcCnnFUN9NSX7NlugWQ1u033Zb?=
 =?us-ascii?Q?cbvF/ZteBRwMfGCkdCBNgb43ynfUUo/j5ZoVafblXGMQ7EDenVjfI9JfcM3y?=
 =?us-ascii?Q?nuLivk+6elrjTafwYHx8o6ouP+7HOU7W0IlBzpsRYy6U5T3ok+s6g5YhqPQL?=
 =?us-ascii?Q?C8fndMuCeWba3sKHt7Dk2UD9Mt6D02TnJUb7v3SC2f4Rwp0ZjR8XsGv46rhz?=
 =?us-ascii?Q?tdDFN9NocoY8nb27jO8UofMxCy8pxwRwMJDNQVnz9vGEsIji8l+QWdUM28fI?=
 =?us-ascii?Q?icyUyTltVP9cPnUKCZve/6OyLxLef6+LHE+EyWNrk7Vk+FRZI1bGv9KFZgRE?=
 =?us-ascii?Q?wODjc9Y9IhgQvDLO8f74Q0rB0/zxHN1S1LJltmVD0H3xR1Vht7q46sojAcyT?=
 =?us-ascii?Q?UaGGwYR/6aMvsBr4qreyft/iMXUfUG6uLdoKItF9y7iLvaozvntKBZyzFB/i?=
 =?us-ascii?Q?dCz6PggQgdQw1y3Mr3Jh1PWe+oXjemZqhlbIKlMGDcL45NWb5Y5gpRGDrRtG?=
 =?us-ascii?Q?NQqovkepWICZcqql6wX3Z7gMSQNoFi54Ul0uw//nqrvxvJD/0GqXAOnBkXIt?=
 =?us-ascii?Q?bS4AgxEYcLbvocY5s1fF/KZO5l7LPN+myxDyeXSe4KKS2RjqC+0RUG1CpH7r?=
 =?us-ascii?Q?nKiFBA4LRmQSrwoMtYAHX4wPlMd7pwKZfC06rXwzNwYq3CtWY3pCjItcCL+Z?=
 =?us-ascii?Q?v5Jwv2CUsk3Ci/nFCKbZ2iY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HYwREVajWrTQPI0tEznKBQlzd21DlXgPC2tTOBEuSUDcofPl7/y90YjDl9Ky0FEluKiCF3h6Om1xSUhgc1nIuwFHgYtMYjIYbmSjAbPymCJ57Og9oWGnOg2cywnaqaMr/3rWZRdhjXP9SGDiZNKZnpjN/VPothAMVog7GoSyxOyIgXBGyXTcfYlYF6SfbFPPNZe4huOD8pwKPjImqfu1kcY33iBb1i8ukfIUgz5SFCLoPswYVhbrEkf0jzolgfUGQTvBoNuLdIJMbumVTshmJqOzEuWC+uCYs4I+nLeSr6NPjwBgOhMGpjz3FN6uOvVdr9v1YfYhUZ58UmIzkru1VpjZ9xRTVDHC7uXyH3vdx6yJCyyT89O2TtZ5TsVi7UwGZDs8H0/Dtcg8Y7+OiTr9o1pM+K1yvoOzV7Zz7pEGDrEx9wqFO2YzigfRW4GGdbcCmZvtUrrV/eN5Uf+Bzj/ecqQrQl2K4k0u1RFHONrh70bZ7Y2ayE9r6AUln6wwwET9CT/7XeSsNK4AdSpeg3dDQc8Isu8/PxtI2pTDDcP5lEwtcPeZOZNodONEGhECT8MixAS1SZSmZbk72OB1iqy2eMkpHbsbUOSqoVTVnftgaFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a33d83-9593-4a9d-c7d9-08dcc05ea8e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:53:17.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTG5X9H/gVe6kgUgIju2bLN6/cDy+gztqHqO04vhKyHEWnokSsMwl4C7PbSnLO7Nj9Cv1jIn5Ga0VzgALqfivbL0bdAyXZpyV5kOMJJ7Xtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190099
X-Proofpoint-ORIG-GUID: miIlkAOL5CsMzjHUSqpnq346VAinco56
X-Proofpoint-GUID: miIlkAOL5CsMzjHUSqpnq346VAinco56

The following commit:

commit cc937dad85aea4ab9e4f9827d7ea55932c86906b
Author: Edward Liaw <edliaw@google.com>
Date:   Tue Jun 25 22:34:45 2024 +0000

    selftests: centralize -D_GNU_SOURCE= to CFLAGS in lib.mk

introduces "-D_GNU_SOURCE=" to generic CFLAGS used within bpf selfttests
makefiles which include lib.mk.
g++ by default sets the _GNU_SOURCE flag internally which
reports the following warning and subsequent error:

<command-line>: error: "_GNU_SOURCE" redefined [-Werror]
<command-line>: note: this is the location of the previous definition

This patch removes that _GNU_SOURCE definition from CFLAGS when
compiling CPP files.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ded6e22b3076..f06c51bfd522 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -741,7 +741,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
-	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
+	$(Q)$(CXX) $(subst -D_GNU_SOURCE=,,$(CFLAGS)) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
-- 
2.30.2


