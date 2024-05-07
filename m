Return-Path: <bpf+bounces-28937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8068BEBE3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685FB1F257EF
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2D16D9DB;
	Tue,  7 May 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gGtjBRLW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1q0vtYW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1639216EBED
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107716; cv=fail; b=B4XsDm+iEcu5j439kLJ2II/Q0VndlDQA6mBfdWyvvq+Kv4xHYU+2+UQfoBgXCn+CLzAEasoJdxyEzXEV2D/IvTHmb8uat5b6Ow/mlt+kenk3KwWNY21p2vgEQ0o1VgSGggiv5L906v62Ppnis/zkF+S8bhJhXZq5fXhsFm8+NQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107716; c=relaxed/simple;
	bh=FLZTBSC3eYqc9o352nPSEwuoCgI+WaGByOFGUfblY9I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=erkgU3/vfVjQoyNVDSP2SGbdGv234PGUEV4yTAb9MaA8wz6CRWt2ROyG4VwDjyelh0gvZZ89LHz7zlvMHWD2UI2WA0jEH3dV2erXqfDnnM04uIMS5WB5xtZKHmU2vjGNLMwpsvrjot7owm+O1XW6KxkmohzjfkfRahdgIESb34g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gGtjBRLW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1q0vtYW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IK6QQ006536;
	Tue, 7 May 2024 18:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=CwC4rn8cWAf87rIujsGNoFiRdUpc5qtMg8SOMIcE8Dg=;
 b=gGtjBRLWvDyao+C39fZ/5S/BE2oUlf+ipKNwD1nFOsG66AufhkV47nfsi56PH+3S+ot9
 PKo3tjsx5MMwjWbC5zdO43OfM4wF3u7Be9zbi7Dd+Ml3/TnTEpnN+zWqKuOxsYm3YrLs
 XXulxODR+U82uuRQZ9TE0knJo7JUeS/P2vDSTOTIbeAr2g5lujF1NUXra1aWRcpKYkJ9
 1+9slD4Lj6045szSI0b/9/Se4xERxF+vaXxgiWS1N5LwLuUiu53ZaXq8GNImJg0q2t0A
 4x9YySLlc/9sJBm3zB7KPyy0INQ96oh1KUniisPk+m7UyhmB6PEmx0mPuaufrTHMekEt oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv02ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:48:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJ2oK020104;
	Tue, 7 May 2024 18:48:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfk13gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT8iKpycYyKsx/UokI1T/JV3YrbSqXa0bHxrckLD9GZDTFCWgqiy9Mt7JH2CGYVQajP9p2a9O2ZKwwHuLy1QZofmkZi6T5PXXb9sFerrHTk6idnTSLlUDT/Ky/gf0fPiFYFfEDtvhcH3jlf+GyCiCuPs9ciSGYxqql3ZAwMytUw9LDvPmYf0JfaT59OK8TrrmJzF5fNUD4lrnLb8ANeY4m92ma0EbPaq3YAIy6Nwgu+zKd3DhRY7AXZ9DknYIUUMQV0C15iwupa/9Ljmh2V1wM5mb2DZkjkt5L5Rm5Na+YDoCxNw8D/lJtUmOc0iwYB+UpEs0LaCKB3+0vswoQsjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwC4rn8cWAf87rIujsGNoFiRdUpc5qtMg8SOMIcE8Dg=;
 b=GPv5ohjFJTZ5Kq4Ke7tlawRJHY4VPaFeuxG35t8kWqwBcVNGKr0x3yL2Kotc1OmZWEReZd8v+ukFwNed7dlYzgJ47qqeRILHmXyQNJ08IgDWJ5awhTa3F78Zq1aYbaj6K4ixX0rQOTavUAzFnGGK1KeeA2yr/NhPb/mcgojgDcDwjbPfoGw3jcucIsmIAmYLHf41dPWFgUgt+nWUFuIVa2aeTByFPtCHicSjeT1qOBz8PU0tiBlySe9qmAhmcsW2GtygmF6j3wAmMHo00krEpIRyAG+zHZjNY6yCA4V/i896wEM+Ecsz86Zww5quSuePk2WMeZTkQ13p29jbOxWmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwC4rn8cWAf87rIujsGNoFiRdUpc5qtMg8SOMIcE8Dg=;
 b=L1q0vtYWAIX65hzfYMwaJi+pZECnwQpt2o3i1ivdeKERbYdyNAFxVppLv8php6jF6cFlx32Kh8lcezuyLq637irvfemkel3FSZaHqxbC4tBsuJGBKEE4BnvXQZ5KjXwTpsHp/nUiEhewl4WBv5gZhvia1qbLqwKgvPCBlit5YsA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ2PR10MB7581.namprd10.prod.outlook.com (2603:10b6:a03:546::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:48:02 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:48:02 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next V2] bpf: avoid uninitialized warnings in verifier_global_subprogs.c
Date: Tue,  7 May 2024 20:47:56 +0200
Message-Id: <20240507184756.1772-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ2PR10MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc3239a-c4da-402f-88fc-08dc6ec63900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S0LiYaa2wTEE+TM39SNNbuyn2emvxXSxEssKFgz+qSnR0spT/MEUF9v1QG05?=
 =?us-ascii?Q?7jEEHI8gNyMH4APeHPtcL3LJB5T5mucitSDltPEAk1X6G7WwafCiStixKGk5?=
 =?us-ascii?Q?mGKZ0vRS1moTqnydp6+JkkugAdBhCkdV5omrdMDzlAi00kPFDXDjQemkUz5b?=
 =?us-ascii?Q?RrGGoNZi7V1JCfoXESjbCCGvHal/3GfPJmfDJn3CzQD5h4Z/RG0xjmynl7oT?=
 =?us-ascii?Q?6lehYe91ITATyaXSpi7uAgvRXhkfb2n2PqK+k3dIltwboL5V648YyWdGnUML?=
 =?us-ascii?Q?3Cguxe1knlp1K22LPDqwupadkVDxM6Q+Garsjgn8U/aKNm1tXrHhrwtFYN9Q?=
 =?us-ascii?Q?+5mJJsRMOj8zuX9oZ0YVVEgxjYf5BUaSExJFl3kdn9s0RiWfmUxixp7kaH9/?=
 =?us-ascii?Q?IrS7+tBKeB6+jpOwWSFJmnrQW1yq23lPsdb4LvTXQomyYlZe3ZwjLOoW2YKX?=
 =?us-ascii?Q?6e1TlmLd1ZcIqaNjuh8W7xdXDH9h0LbWS+qUHA3N/1xTbfduo8mQOWBHu/k8?=
 =?us-ascii?Q?X7GenoxGqZgTLQLM2cso31fK23vOzpHY9T0yxunm5Mc5HB/La79ZzciKV6c9?=
 =?us-ascii?Q?xjG4/JyVxnJW52Kury2n3P7+fhXQn5plUIXKEXDH1qb1RmRQU5F8SKVtHI/J?=
 =?us-ascii?Q?WHYkl9+b4BH5P7O5divJ3OONVVzHmAzIr7Fc+w31eo/HuCFwH9Y049WNLfJ+?=
 =?us-ascii?Q?/U9LgSYg6DXkQMCeju2Bf74brmBqx4srWgf68ftMmQWojibBCUPDpG/olum8?=
 =?us-ascii?Q?dwJUHk0TwW2T+HtqUXjUC/hRY8iVXpUeJXg3E/3Gufhab7fklFKg2WA6+936?=
 =?us-ascii?Q?xeiAqy5MGL6CBCeJjqbKnCCKgH36K8PiHAOOGrd4KJK7mFpO1DtjPR2xvvf2?=
 =?us-ascii?Q?cX8nW0z/bC0T+ksertN/CV+L1Igxzbi0EP9zXTLO4cfklqgthQB0KRlewcZF?=
 =?us-ascii?Q?HViWTUtiaoTFNlK1Z0qx+L1ePOmeX2UqT2i4sNNQWm0MZu5D26hYRyxp8LB6?=
 =?us-ascii?Q?1HX3vQgnn2l3pzXF5w0AJ/0SHMzN9ITWlfRQFkRZ+xxL53KJblbo7LUgfo3D?=
 =?us-ascii?Q?HJmue2Ydv6q+IGTU/4EYLamxUwSd4BT9mK+XEXzyhZwJMlJUs14Ry66aUs2J?=
 =?us-ascii?Q?dgdZqS8ZzVNqVmeFJB3gajHen6869EC9ngUBrDm3EZ0WcAxmbIW0ES3jbSzN?=
 =?us-ascii?Q?+Rw+nOs449kZ5sdNidaBukYfZfyYD8w1bPPxNnrTH0Knw7FmuPubRUT8BrQ9?=
 =?us-ascii?Q?tO790BBhBALPGmuOes4tOG6+Ry8X1U/Co648KJVfuQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?icL/MvpQu1iaYADWG+jsqOADS7N0Zae+g+7A6m9AIp7ymo2cC7T1DcP+Io7n?=
 =?us-ascii?Q?+VMaeMqrY4IYQ8b5/ow9i4XZHNm8XcNEG+GbcSgCyGaWCW2PzpIeYUhKGark?=
 =?us-ascii?Q?O67cziZn1bOeFpY6AsNn8w1biK5kw3QlsrZw7KuSOvwg7XWa0zwwtszVWgPu?=
 =?us-ascii?Q?kWFNcssryIx92TsUdsYU4wGUzJ4WpNuBdDon08dzVcOaZYmuzeSuubhbIURt?=
 =?us-ascii?Q?t8fvQUcGhrFjJKFBZ284g0QPzLGmvEFZibt7ieU0HI2M4CGR7gDkdsIFoHXH?=
 =?us-ascii?Q?GXEfQcAQqKObc2riY73+i+7zVDO63NFo/js01KpjKTwwr6ANEnQMjEsQH5k9?=
 =?us-ascii?Q?hGXhWmezCZJtWwZY5SmiY1/Vzy2iUrWeZVaRcEGFFsi8n7YfLOR3OIwNhClz?=
 =?us-ascii?Q?bPUqbWqrSIq8zNetpDUM2hfbE0OFXWjqGHDgspwstg4yhysELUxY3hlJhQex?=
 =?us-ascii?Q?v9MUWp96j6MSqk5rEqnrpBpno7emI63Iaf/ar14/Va9iXO9NFJN58KIotSBx?=
 =?us-ascii?Q?FF+Of5mp7MEga+X0Ab2RlTPxiEZ/X7FLVxhs3/F1mFxtKEgx7kvahZw3u6O3?=
 =?us-ascii?Q?qOlAFrCEnVZiwZER6gHCtCTJwJfAYzScqRXXlntNOY8kn/ipdCEDuzwH5sGm?=
 =?us-ascii?Q?H6DH9wesWwma9QMLM4pdGfYY15xrn9CX7QEuZUJAb/q4wVaj7+N+fsir7UWP?=
 =?us-ascii?Q?vzGjy8EzKNPJemW4/Gi4JcHf1jNXFlomDB4k087oAt1WJjbC1a5qPCVuSlYT?=
 =?us-ascii?Q?cGUsrExxaU1WRUTaW+r0scyjFt/eNmuqgyXA+dyw/oHaduQD6823ULMCcdsF?=
 =?us-ascii?Q?sY3bLAT1SGQ7S1XDMVdOaIIWkHaFMenSPDDKE3uZHhr+wpu06rwLRCcF7Dgm?=
 =?us-ascii?Q?v/p1lrOy2cqo2eq97PQiM1ptoORu4BKELiETObwXd/HuBMgFKI8nw5dW1anS?=
 =?us-ascii?Q?/NRhgxllS0Ue3KMA8bpjNLkdzuzwSyd0lyLuySbpK48F899wRrry7jtw0X8y?=
 =?us-ascii?Q?e8oDMGmEujkb8DUoslXaGg783ROgEMPGhoHexCIRMzERQcQu+tqRI5bJQdl7?=
 =?us-ascii?Q?KriAvB1CPXL6XsNodNQnRDu71Iy4KGezMziZdssYc5l9Nioa0hC9IcYaz/s/?=
 =?us-ascii?Q?YG+r3p0tCLEWLMxQzRRon/scFzDdAKHy63zTsRxD7minOIBoc0XsCPnn1w8Q?=
 =?us-ascii?Q?Qzz5yLoJP1714D2Tm+jCjl5/UbhDNJj75KhA5Dp4lbW6KWGeqTXDzncLxoOf?=
 =?us-ascii?Q?mQumgc8wrlwXZWWJpqADSkqUEiy/algmt0Cc4nsIkRhEkLIEOMIj3ysRjViz?=
 =?us-ascii?Q?DLIIFLeuWV0qE9fPVEFmkRn/b73AiLN88N6SgJN26wYaukny7hzxLgRxOII5?=
 =?us-ascii?Q?PUDlO9zM7VJXFmXkDKfbO4V8w7soZ3kWJ/VFB0xGn3PZpPDtWfTSaJqvZu6V?=
 =?us-ascii?Q?kYZakFNop4s6DUyfQJ9Q41mAaFsorzwxpgK2NSGFXeaRF+HGYwsRo9ahpk4z?=
 =?us-ascii?Q?TGv5jtvdfKsa5HnvVx088+hQMu9+UzU3ZxbPAxEN5BzE5OX2opQ/iGLtX3F0?=
 =?us-ascii?Q?n5mBCWW7uvw99D7P3YUMouxnSjPvJQnkh/hRTVQ1pcKWqqtX2MOvovp7TDHj?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	94S2vKx9MCG9926wWgCAMfK/uOHrCn604BdXn8basRrZAzz8qgtIxjEoGOley9oOWAjIv00N2eZETfprtKWX1z6suwIreEn7S3wDQ9R/WzrdFx1aMoCJYZsiR/jsSXORXXfc4BMQ+WeCrx3xmc7EjMKtBIHsSojR/X9UsMmdeXeLA2Bg1zOldiAtHu4wrQo1Zh0hczgiVijO2x8Oug66J8noEgZ03UAKWQyn9W18eiG7CHdePE335Ohuneg3A59U1qAH6Y3toM9p+MbNScwWEQ3IcxGQpSremfUA2dnmTnXvDMaFKCFbQZ+cO22drwy+Lg1VpcirD77kIcMInRNJHPh30+JEt/4vbGqpIHzWYkzSRET0tyQHJX1Lynu+dpGYjK/AJhKs1iZ8FFqzRDZAIjaIKmHQ1OupkiizmD6UsT8mWOitS/0nmsiAwgw/+oB99yfH7Mz3QcRcl7wdAYA/eccgrKRqmsg4Z/1VjFI4kBrl2DRXspqCQjlh8zf+RFCUAW1GyZ6gs756t5RJBbRUr9AMvnLO7dVhTLR8blcWID3VyTF7IKk/8wlT1k4GTYOxRLAlkVVA/RIcXYMgbrAX4auiRJtnyfukYAhG5JQXGnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc3239a-c4da-402f-88fc-08dc6ec63900
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:48:02.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWmc3Lv6YCjvTtyfPsQZYkfQH1QSbM5++C3eeacx6dDSHt+trkaGvLoRVqlw6elo7Mvt9Ji7/Q80NVFmhADgy7fJCjVWqgehN+1HK0EN36g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405070132
X-Proofpoint-GUID: snd6VzX7Tvy98yKj--7pFMjwlGuXYLna
X-Proofpoint-ORIG-GUID: snd6VzX7Tvy98yKj--7pFMjwlGuXYLna

[Changes from V1:
- The warning to disable is -Wmaybe-uninitialized, not -Wuninitialized.
- This warning is only supported in GCC.]

The BPF selftest verifier_global_subprogs.c contains code that
purposedly performs out of bounds access to memory, to check whether
the kernel verifier is able to catch them.  For example:

  __noinline int global_unsupp(const int *mem)
  {
	if (!mem)
		return 0;
	return mem[100]; /* BOOM */
  }

With -O1 and higher and no inlining, GCC notices this fact and emits a
"maybe uninitialized" warning.  This is by design.  Note that the
emission of these warnings is highly dependent on the precise
optimizations that are performed.

This patch adds a compiler pragma to verifier_global_subprogs.c to
ignore these warnings.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/progs/verifier_global_subprogs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index baff5ffe9405..a9fc30ed4d73 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -8,6 +8,13 @@
 #include "xdp_metadata.h"
 #include "bpf_kfuncs.h"
 
+/* The compiler may be able to detect the access to uninitialized
+   memory in the routines performing out of bound memory accesses and
+   emit warnings about it.  This is the case of GCC. */
+#if !defined(__clang__)
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
+
 int arr[1];
 int unkn_idx;
 const volatile bool call_dead_subprog = false;
-- 
2.30.2


