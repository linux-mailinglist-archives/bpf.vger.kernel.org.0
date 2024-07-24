Return-Path: <bpf+bounces-35539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1993B58B
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F6B281985
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6915FA74;
	Wed, 24 Jul 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dncEUmY8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SGVaHeMl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425715F3E0;
	Wed, 24 Jul 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840759; cv=fail; b=ZGvvjYQqBILUTEqrRPh1vhf1RCLUuPVmzm4hLl0n3KwpoNNpObrOvyQz1ECvoljSCG5mZbzsjjibwX53MCjXIeVsexMFUQr0eIMzxsSta8XoSVhYtTmdh3PBQ5j8fcCE1zy+4u6Eb3GlxF5EQAMOnaTobRLrqsPeH6Q012z/zn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840759; c=relaxed/simple;
	bh=t82TpYFvqpskNRmrdwbJ+njmLxnfnyZtW8tkUfFN0yI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cTQwKsZL0KmJ87TmD4VYbiv/oB2hUXaZbkHeN1m08OhyEfyPNmFB8TMgClY6tidYUmaF+OnKkIlvDtYnvKzbOFyNN9XIkA0yX723mEV1xuqoobaJzXP+6Hqky/WLlak68TM50o4TsVdkA1+OcliDvhBovLYkYaW1lfcFuevLMQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dncEUmY8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SGVaHeMl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXrQL027271;
	Wed, 24 Jul 2024 17:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=AgbgSOJO348qTQ
	a7gjBmyaxcLp6lzSSQ1MHtuqxccOc=; b=dncEUmY8vo3h7wnCi8jM+w7k/5qZNF
	vrJ7CR/BN8CSMd7M4AWKj5lospwZxfC+s6tpKU3pshKBI0HAP6g8SqC+D0b3nel9
	NLQ5gwVuDndnbJxXtWzWqCj0Su9NVPla580XU5DjF0Pu3OKPaGSsYVR4IVBeOK20
	CjJY7B7WhtWkev6wgaT2vB6AQBXyjsQGewnI1cEQVZKsAkhojIVpYWda+9n+CJlJ
	NAMxqVlhaUCtSqboLz1OwOhcC2ZHlUgaLjqd1RNPcPrxv0KBD75Ax2vt/6Brb7n1
	lpfymESSwGGFezwhI9s8B8q4enaIrIP4Ihf2aLEQQfCvaf7Zh1EVLtSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0hg2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OH2v9L034367;
	Wed, 24 Jul 2024 17:05:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27pc3vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 17:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esVdQJJWJQG4yGdXkuW51lnwD1TpXO8NwieY1doZYy5ncEfOIm1E9WxzEoFQmBS0bhLZejiK1DX/Skk09IzVDoYw6DBMGCtZTT8/7AL1gCkZCGf+YSlAu+tfRg+EIbSiKAFIP/72LTCzmFjhTEJG7OQM4v6GFebMT1UwERTrmdNFuOUoLVyo4KvxEMnRnmfxVFE4+LqlZLJkbJs2ZJfefGsPrcpHx/F418wjvIPnxT8x40gt0JpWh/Gv20xRx4jSFQ8MTTnNUvreF9nqESB+KA+7xPjhAqXFbewFeTcwZWL2oXR2N5WgZiJabuLd9Z+jpRjtxU5u7AeOnTbifN8esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgbgSOJO348qTQa7gjBmyaxcLp6lzSSQ1MHtuqxccOc=;
 b=wdGc3+on2YUAD4/AM3IdabD+WQK2EznLhomhsShp/KDX11i2qVk/yv/NKa4VAsiet65yY6BXiYvp3ZcKc8h/8bW+MFGS5qWbMw+wGxYf+Y8Y7gJCOp53ErTsMJQF/qbUtRsF0wiHlEqx8jP2S0LwDFest+1Rd8Xa/xohwruNaWD+L7FXIIT7dkIEPhG4UOQowU1um5zcuu7CFqr4o2Uy5qj71/sk2SQHQzsRbCk44F503DbqVBW+/bgssweFJMbsZYP9qIsY+WXStsL71VEdSxtZd7y97F0P6od7cgD82Ih4Dh4ChXRGgUW3QeSPXBzmQt1dltvqUT8GF8Dr1X/skw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgbgSOJO348qTQa7gjBmyaxcLp6lzSSQ1MHtuqxccOc=;
 b=SGVaHeMlQBzHh6l2O/0avujSD9fhQuTfPFuGDIwazRwxsBlZK/pto9lmfeNNh4cDoRHAAtslOjVRrWinbYAP8T0GvkdUDz14TAEeZ894p+YV+ILg+bLjuHIkXCdmr2G03wVRqHRQiIYIfiofWJRbdIIt00rfpmD1CnGv5374ig4=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by IA1PR10MB7237.namprd10.prod.outlook.com (2603:10b6:208:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 17:05:27 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:05:27 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, si-wei.liu@oracle.com
Subject: [PATCH net 0/2] tap/tun: harden by dropping short frame
Date: Wed, 24 Jul 2024 10:04:50 -0700
Message-Id: <20240724170452.16837-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|IA1PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a7cf79-55c0-43e6-87ba-08dcac02d0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fozIXcJWsHmmuOpzPqANbrB89BGyAl8UhBILdgz3FJtuhD0xmVhzqvmG7h9f?=
 =?us-ascii?Q?mV8Tm6OYu4XLn43Yy7wSXf/l0XPVFKjINlfHpMin0GItSeN5Bw3/lXBVFt3J?=
 =?us-ascii?Q?5r0YFlyTdgnxpE0/E/J3Sx/8Ot4AdBthchBa60HgPHq3Ac97mIhglAD6oG7s?=
 =?us-ascii?Q?t9BZRYtnmxMFgyTPgDYPBnlCYFzdIbR8He/4BzcFrvxn2ybZapksCIW4Jk+x?=
 =?us-ascii?Q?omtqYXE27NJwFvy+K0NrhOdx+93P7pfn75lQ0YvFmPEMujWRBx0zC0Qzhrnu?=
 =?us-ascii?Q?ZDxlDydq739nntQpBjWLGQgC29HyXXpKTvnZ2WG+Q11BDpkhRnHrVmWAQRJk?=
 =?us-ascii?Q?raCE9yyueFyqr6/YjUA2QqZ6dtwAtrvIUcpr/lovyG3TqdVOHfa1DCjjonzc?=
 =?us-ascii?Q?ZNTOaC/oIcL0pMtN85/i168Lb79cMLWXeKxmtzQ/pOwHNtsKXEm3upJvJmFA?=
 =?us-ascii?Q?gMNHkHZgVoynVpVhRe4Wg3BIX8wcO19eAKX9zWCndmeW+o5Nc1nNug37VsZe?=
 =?us-ascii?Q?97wbYQEmNLLhCFE8WbLTjYQ0FlCYRm9dXg6yxY0groWUzdqRrr3iuF1l4j9F?=
 =?us-ascii?Q?KEgSURE2P9rLsXes2qgYczoJltPRtV/5rZHlPykioz6Mb5iQTISDjQIToAG9?=
 =?us-ascii?Q?3IXyd0gmISPhCzSWCO5I3MfsCZngVwFpwbTg5tLjWwcL1j2pywfOAV5EL1sA?=
 =?us-ascii?Q?sKIxmZ5MR8r1Pu3DXdJmm+VNIzNXwUe29B0bwN4TdlLNRByvFx851Z9GvReg?=
 =?us-ascii?Q?0XBQk68miZmVSnAA3i81Lrcd7uj/dubiDFYcWBhsOL8C/MabcJSOQFaI405r?=
 =?us-ascii?Q?e7nwb/k4ahSDESEZLisVdwVlRw5zETCu+JZXKyrd8Ks1wNacNKarH832TVTv?=
 =?us-ascii?Q?HBo+Kq5dx4JO90U5bTQG6/TVfVAarth7m1HGIwL4k7ihrVmA+iQIaEHFmh7f?=
 =?us-ascii?Q?RWjMLsXHeeEgOyQM8+CFCSwYq3PT208jH9YzYa8xYgdnMS9SCGfqGbBps71d?=
 =?us-ascii?Q?v9giCwosmj2l7G/VNXsydcoH2GtK1YBD4m7w2NItXt5+8t8PKdUysdLq5dQP?=
 =?us-ascii?Q?xaNlBj/ePN7lbhEjUbpFQnItvKROq/c+DqiI4YMjTPPDQtUVFXTeJYa+AvoC?=
 =?us-ascii?Q?3WkrPn2s/t+igYtsTmTJpqDgz004CEPqGwqaHfWT+uxGSopVG4iY7Phq7r2x?=
 =?us-ascii?Q?HWXkrxaRjgbbqx3iRpQfhDtmFilnJqLLsVl/4M5e+Xk7f81nYTVV4/qANAZp?=
 =?us-ascii?Q?gup9iYPTKGkH5PW9MbaQ5rEKh1n18k5XEVC3X+yIN4PgvEDZbx9GFt86kAw6?=
 =?us-ascii?Q?Ai2KEF0cwojzPUmZB7dD4bvzk1SUfZD+LKoURxvwSRfojA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ddJ5e0p1zUzzfewnuCY6kyNssgdMEB7/0GphPKH0hbtchffA2d8jqoCYsQR?=
 =?us-ascii?Q?R6SuuAaNdw6T1tTg2+A7WgLs1TkR7ZruhBCUosBeZCDy36pXWt/qU8uB9EI+?=
 =?us-ascii?Q?+htUZevnpQ5TQDbaF2NvfTBhoTle0soMLnrALHCgcpJrrULPP4gBpf4y2doi?=
 =?us-ascii?Q?60tmq2OgQEjj7oLGKLUeFRE2J4aXjX+uZlbIrYVJTjBOuO5o3oDsBDQ/vXut?=
 =?us-ascii?Q?gzbYY0tXMbRNRKbKzVihTYuOgGzeAMPKAzfCkZHeUr2jj/j6qluDo8N3Tr0v?=
 =?us-ascii?Q?Ai2NtiNWhOFpVj9ge/7xScfnzihBgPzwnLg4QI7vmT3fDnStOtOaTnTjdlJa?=
 =?us-ascii?Q?f2ZIuGewvg78LaRSjGVc+/jhBuyrin6pbWJXAvz03vehXcEBnkxhDTKsow9w?=
 =?us-ascii?Q?zT9+Z+BrJ6fhdfCk4Qsby79hED7NURLbKqT2wgYeuos5DqxOUB64eOESrVGz?=
 =?us-ascii?Q?ocz6x+zPW1VQB1VkBJrKoBK9Kv3Ju7sFBxTZrCGgFuGOkbHVqfvWNFQoqG19?=
 =?us-ascii?Q?lw2fclx4IHDTXi/bqvfLyop1Lr5FDYtYDl7Fc96oM95BCLnK5BE1bw4wC0N3?=
 =?us-ascii?Q?etVdHsZhzt7ZpLaPviv4GAsqpqmV2aI3C5koy8WPAnt05n0a95/h9TCRUe2l?=
 =?us-ascii?Q?14jbE8vmCyFjeBfFXopI80e8pOetTHu0sv6yy0AZ4RqfaVj8S2Cx6B5XTfHA?=
 =?us-ascii?Q?2K98w0xfqOKgi1IfqpA+qxmnHl92lCWKpv/s8hjWCyhwGdNADv6b3q7G7ZHw?=
 =?us-ascii?Q?qq+GgxscUr9qE9hoeEbhLK5jI4bVL92MgukYA60JVtLq3m39Jj8v4xFsIyqe?=
 =?us-ascii?Q?n0jxzf/KhcpzszGGESBXrTgPhDRxfuW2KMT/7p8fgWwr1bS+2Z28cJmVVAgu?=
 =?us-ascii?Q?73w9NGi7Wz1hpFhb7rOx6InEdKxkR4p3UUFFhd6zXJ6LSyyv1fooy82tGWPK?=
 =?us-ascii?Q?JljEbIZrsObD480V4pkSWCg+aQ72gk3Q4m5EE2v1D+zKzMHwcVlQAbfoFw58?=
 =?us-ascii?Q?sScucsfUjBCRgEK3MeYruW4pRgjrzdGBLMEoJQ9mX+8DiUV5Q3ZW1x9nJC2e?=
 =?us-ascii?Q?YznUTxySNb+9ks6uXUa6SbRmPi+0SgoIFqTM0Ta+cKnQW/OELFDPs8+xG8GA?=
 =?us-ascii?Q?RE0lzOzgH0u1EWqSyT8tADpUfn08J1aN+ncjeXdZh/wx3Wzd/Y+k3+R9k6ly?=
 =?us-ascii?Q?0IYtyN9fbx61BLp0E/UnLNJZaihb2Ir6Cit1Vhfr/ve8tq2KTujf6RJj9mi1?=
 =?us-ascii?Q?yJgwKY1wKsCq/Df2S4h5ZWmPNFnsI5y9VfsosuOlZUsyCB0aLraw8P/2B1H9?=
 =?us-ascii?Q?Oxie/4AgT/Yv38dfRcTh+0g92PIbFNgoo0dGdCPot7QZKViUG/V8dxgt3dsi?=
 =?us-ascii?Q?kEFM46d1JhN7GezUCPfoLmaMtbxsIORwRR2o8iko/6Xbv77zflxgGbt0nVPI?=
 =?us-ascii?Q?lZOe8E+kaHcY1s5qaGkCvvCneoyZt6wXbIR9O4CKCaHhSqNFBswvtB58n8C5?=
 =?us-ascii?Q?tKNHIry7VZ8QIcscXNu8CNPzM0a2jUD4r0BEurQs0upA1KacIebGSoRHjPNo?=
 =?us-ascii?Q?sKj9NXJva0cDHiWoapUe2FM8SwoXjlU3XOzcVPec?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AmW0qYXK7yd484KybxZFnwggTTtW8huLwpJ+3g98P8DIKl5qFi6lfTQrZ3uJcEy9bmoz5emt7AP5leyItoOXhH3x+LxkInUnHbq+LpSwciFWbCDUh7oRFigEjfwX2TiNhuhT1mP/8xbEUR8HNStkwTaQGv1zTf+mHkba/W3fthhLWOenAWCh9QJv3ANRBKYL1BdBTa0yvDs1f43rGwMZ/EIXQul+t6UjWtzAqxys6nOxNTBPllQZ/n1rNQDuGRjcMR9AaYLzn30BGbugrvTVAQmLB+/hz0WghhXFmX5g8ZhdbzkYLZ6GKlz24Iif52i6+sEmHALD7ZMNu9kHvO3EqH//BIXV+o+G17tGQrDXsRkrDh0omUPNQCgQ4sv/IEZx8R8NN7J+kyYHtpho0gnCFjfo61bX/Ip8NL6z+l23R/g5r0KPHd+EZwidyjzrgEqbOZ4yxb/HUdcS/751waGKPb9glN1IStOIWs5G8GrrhQdedIDKVVqQFaQV7zhZRMcUoByfoRKSVG6vNeNQGbdIjB2V4SD9ROkVcQdakmMrYWuz/fMpJomw0Ky9I62ZVU1c8wlTN0ToaeUc6PRnE0Idguf9grk1RrMcCEKqCOLQtvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a7cf79-55c0-43e6-87ba-08dcac02d0ad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:05:27.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VABX+BMPvyacyTyDIFTcCIOuqgF5wuOO2w+Cl0o8nL5ftrI3OE20n+1WvQxtJPYoDX+/YouNTwO0JW7Fse+BGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_18,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240123
X-Proofpoint-GUID: fZct7ko6Q2C0fky3UWelbLVN2KVazDp7
X-Proofpoint-ORIG-GUID: fZct7ko6Q2C0fky3UWelbLVN2KVazDp7

This is to harden all of tap/tun to avoid any short frame smaller than the
Ethernet header (ETH_HLEN).

While the xen-netback already rejects short frame smaller than ETH_HLEN ...

 914 static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 915                                      int budget,
 916                                      unsigned *copy_ops,
 917                                      unsigned *map_ops)
 918 {
... ...
1007                 if (unlikely(txreq.size < ETH_HLEN)) {
1008                         netdev_dbg(queue->vif->dev,
1009                                    "Bad packet size: %d\n", txreq.size);
1010                         xenvif_tx_err(queue, &txreq, extra_count, idx);
1011                         break;
1012                 }

... the short frame may not be dropped by vhost-net/tap/tun.

This fixes CVE-2024-41090 and CVE-2024-41091.

Thank you very much!

Dongli Zhang



