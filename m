Return-Path: <bpf+bounces-28811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15468BE1FC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169781F24CB8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF6158A2C;
	Tue,  7 May 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2YxMzeO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCPGFAa6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396415B122
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084570; cv=fail; b=rIFEKEBsEJJIGALQpqH/t52mcwyBaokmfXBLa+TWbBlbIgnFXzZDZcJYXmoeqOBtDcR5JwAiYUyE7/HcG5bGs2g8mwhfkYpGCKtmcEDTP4Cs52328AT4Ocim8N+kooIY7ODTqVj4navHQYQuK8nqdB/Y/7lRmBYXSJ0Z/XrRyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084570; c=relaxed/simple;
	bh=9hq8HTfUEKtZ/iYhcmlxetgdZz27huoeug+w2x8utPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqE7sxySnZIYN4TNmOCTtGq6Hy71fKsqtXtB37I6xnAFUqj9ft97fPB7RIe+DEfkfnXl8swqWrks11ypPDjx9pDezCx3AvQdzEmNqi5wdtC3PzB1vB+P+nJPKaiGnnYjbJTf7dWCIvZvaJPZ5SA9oRjxQ6yjM3yB3YSeOsNOb1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2YxMzeO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TCPGFAa6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44793vd8016425;
	Tue, 7 May 2024 12:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=0W3TdYY4ikEzAZkSpi6LSDiWOrAnxYJ0MNK7IwslH4o=;
 b=I2YxMzeOmBcuw67TbUCVOiIOqCX4jun9FsIb4ldVFtMK3U/e19PYxmScny+s7SEYx2BX
 Whx1frlFr50j1UUJKR4k4x/VpHdGFzh6iYi0GPeeL7p9Z4vKlEva80yysU7GiXrnFbDM
 hd54SJhcN+DSIs9JXIE6bXyPX9hjKzR/YMGd2c1JaBa+GFgJKYywLqINnkcMMok+Grtx
 drcwaYVwrSkDMlDbRW+jat42YgyngtYDFyHgSn7PIPCYJzjrjymJLZwh+5AAfSaSO3MD
 Owv6ztdMwSnT/+Prm1XrBM9UvkWQ9sE5GSvitt6292j6pIUMkhRx0IRrsRef1hGAzfQ8 6A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt54tu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:22:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447CMgpe007085;
	Tue, 7 May 2024 12:22:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7xhkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoQfR2O16v00hZcYHfrMuYXBEay5IpSoYkjPwOs26b5R1j1vhbt55oGwuiYMwGm3dacOX8x2/cKcSeLfAfGh3etqkmW8VrQdeujamtZBTZBs+NGREdl7UW6OpAQgg1NHRypF+6R8tJCFI73hkNjs5X0fMEICMyvapkqcpp2wioTeudSY3x01bJpAlxh98VXpbnJwm0B8ZvRVk6WTquaEcUzoA69ZgdU7inat62NOz3YS27jksg9Pd3eQ6WWVfIXkimXg66fqjOYkFqPhfmTO1CUV7xYE7p2+SCqzrnYh+OwDFPlsS49wcQbmOc9cEXirDU3FCIqzgjKtMQ0F+3ynUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W3TdYY4ikEzAZkSpi6LSDiWOrAnxYJ0MNK7IwslH4o=;
 b=H2EFIKvS6PYIN47/8PJPW2+5EHxWxY2TyEWmwScgqA/NSPpvD0NCJCyZuUUUx57AJbgRFjmHQnrILSHLl7GF+SMPLjKVSi+mkjDNx5EDpY1oNTCDED5aSinaU2d96Lql5a+VbwJabxNDSTpS/6Z8nzKxoM1jsPsbkk0mzf7pZsr81jrZblJYEm3dxSdJpv0ImfMUAQGUADR2eUULopRR3PuPA0fD764BhFEBUCwjtL8wCTOVLAwZ9pUm222KKGHCQLRc2l0+igewZ3e4qFWqylfv6R96sjYi+AmcZVUsyl1VPzgIXJ1NiBEH86q21GRZgfGTmJyesRdC2oi9kMcp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W3TdYY4ikEzAZkSpi6LSDiWOrAnxYJ0MNK7IwslH4o=;
 b=TCPGFAa6IZ8yklyYcQyz97NF5vxDBQNHaoZfwQ2wlY0Uc6QCGH0G/3WiMZ1YcEoATCy3/WPzZF3rAEr35mS2UB4Ez8RfY/W/pFprpTS3xr7XPDj1OzhTgMUpYth7eRuhtB566Q13l35EFFdYRVLGYfQLu43QF9GL67h9Gu3dM4g=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 12:22:40 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:22:40 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Add CFLAGS per source file and runner
Date: Tue,  7 May 2024 13:22:19 +0100
Message-Id: <20240507122220.207820-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240507122220.207820-1-cupertino.miranda@oracle.com>
References: <20240507122220.207820-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 435d2314-0719-43bf-2df6-08dc6e90636e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hij9S43SwnznwXSPqDvwwR98aGhgU/GGdOH7bJRo80LWnUgfhPN1AM1iZoST?=
 =?us-ascii?Q?17u/ytC0bNpUAt4pWUBTnZLNW4MExlT8x3wIicMfXI8cRb3ogm6ESEhXkmuW?=
 =?us-ascii?Q?iRRkccj69+LTQPbTc088XRSqBgDrP1YX0CPnp89ZzysG/fxPBuPesrlVe7sM?=
 =?us-ascii?Q?nS9yzS4YtfHX19UPSY4JF32VFNPydY14HK0+VU05zU9dyRW562zMjw33H7O8?=
 =?us-ascii?Q?SMg+yMREC24jATRJLWymUTpFT0N4Fr571QRMnNKrg134b7/HYsLWm2hbtalJ?=
 =?us-ascii?Q?/y1XDmHWYWHjzHdVnS5s9njDLyVXwq9ZDbbw8Sv/hNQHWjfnrAGI3U+EZR6T?=
 =?us-ascii?Q?L8S5uWExW9m3flC+cH0Neqlm4qvgZhcIkDpYrVmt25Ki6p2wMk/TH61Kn22i?=
 =?us-ascii?Q?AB2ZEHJwc/NOSFre6NA9qkSBtteXk7C9iVv635V0lGiMyL32YB05Ll/hRCRA?=
 =?us-ascii?Q?/QnlPq1jJKp+ZjnrsVpsXnUVGnWo2192V5fEKVmY4ulAxzQclZkEjFMTuLep?=
 =?us-ascii?Q?mz1EJx4rcoO76Pxwl5xFhqfWk2vtDaUMPz6sa3FIh+RXw9VusRP7r7o/moQm?=
 =?us-ascii?Q?aZL2TYHL8qMGXCn8sMIGrA9rvt/SEMjifAwaQuuSbKct5pk00Jvy4qhsjoq/?=
 =?us-ascii?Q?zH6oy4py2QvXDsQx9ikcPLCdn57zGjT5U1MQ3LzNwUZ8xByZUaE2WKC9zRvT?=
 =?us-ascii?Q?/DcRDCUog8GHRzceIhLZ97iaUU+RYamV8MbSk9fCXwUJ8/TPGDo0M3ZloQDn?=
 =?us-ascii?Q?Rgvbzk66GMdocayUaNYRCyxYQOrL+L9vDyufiN48RYouvr51MCcvA5wZDeZN?=
 =?us-ascii?Q?8kg2obdUw6Yt1RSlAdDGLZrqqn+IhTKpGD7NMtpSOxTAo7z6bDtCnun7R6S5?=
 =?us-ascii?Q?LYmTl+YyCq8y/NWgtbWTyR+PiwxBkmXwSHuHvI5KqjLpkhcVb/RNve5uNvFG?=
 =?us-ascii?Q?4qzrXwAYW4bTDGx7f5v2zZFv1wAZgl2FnJ7brPEKrwQFEYjvKuLeh/R9Nvsk?=
 =?us-ascii?Q?Nh05MQI+dr1SZk0tV5k99qiRe3q8OqzkvvBl+gagnphDx2W0ZagyZ8S3hySH?=
 =?us-ascii?Q?4C7GPk1V+QyqCfOf3zLQnyC/cz5OUwDKRE0PAaU8RvuSAM5lMLiLKfH7Meye?=
 =?us-ascii?Q?QGxR0rFhsU84uRuHSFMvmoRlXdjEmIctAyO4RE9zkFDvnVSEz4apFJXNGBjP?=
 =?us-ascii?Q?lXqdL8ApAD7B6Nu0Yn8bXraZOpOobOd09aEjprIb9vxUtZWQjKqZKQYzw0G1?=
 =?us-ascii?Q?ChJi8Nigp/ahSpCcj+ZI97ojLWCVWgilTL9mms+POw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eUZDvHDg6xTAmQzDFrx6r/hJG7PRWJgK75a3oJi+fEzsehg426SEb2vZZCtf?=
 =?us-ascii?Q?0nk82Bh5mHDuQn2+fdUWTh6xq63IsGfE2NQ73swlHSJyBH1cqj8o2YAT1t8n?=
 =?us-ascii?Q?6MTPfSezNDtGIZU6DHXb6kYI062a1jLaD4lk9o3qH8qPGiePf2ils8WM9ThT?=
 =?us-ascii?Q?sbn1+W4zWDTZ3URGJ97jsgHMlCYwW/dkyNSwP/PjslFZj3PKCIi2/wM2jPzy?=
 =?us-ascii?Q?v6w9Vmr2yHsQTbh50fcS4/8LZE0oezMn7Cfux3jR2kW7shatC8c8stAki2iX?=
 =?us-ascii?Q?BqL29Y8u4yDEHqAYx/mmw3HAj9xvAj8jImysWwcJiIkBOsPjU2v0bk+I4THr?=
 =?us-ascii?Q?YaGqj+GNswyymclef266H3Y5fjjt65FFLG4eYFL13h/9bFuOUV59E/yzwJ7e?=
 =?us-ascii?Q?AN67mHlyVAwDu1X0gIAU8JxhUpKKYiq1wn1lNDDGEbzUaLAXFyCOULpHknoC?=
 =?us-ascii?Q?8m22/OiAxLm1nFBY1wOjUZVRWYskAf8fOQ9efTraZZudXWuPkJ70UKGvcAfb?=
 =?us-ascii?Q?e7wacD/fmLHEOXRcEvPXnGl+Hc4rjNRGnncnrKmo2UrTwB0riCiGJTHOb9IB?=
 =?us-ascii?Q?YG41IIZSAsSN34wk7gV+xBYvtTLlTQ2/tfZxFc1ocm8UNfk4VTYblELyRQYj?=
 =?us-ascii?Q?q4u4oXol7Iw8o0wtt1d4lmSABq1yEv4ukBvgoTbMxd0+3avOr+bK0KSUu6nR?=
 =?us-ascii?Q?Hgwt4U2E9HUTaZawUCURAqjKoct7WzcRGl3SWQHBH9Vb3os8tfq+4BkmItdr?=
 =?us-ascii?Q?Kwg8Sp5gOUQUvOuRimpojQBYxgzcThMWrnarQv7gACNggLDq/D3obYoiub6v?=
 =?us-ascii?Q?FP3RAbgNhmKBST98IcLMBrfeezTikcYD3LdOZ3uO2CGb+5dyMeIpGenhLmV4?=
 =?us-ascii?Q?atncsJEB54IxsNBvD+baVUa943PMvN6pPxGxSC5z4fhmwyDPj239MGpSEyFI?=
 =?us-ascii?Q?YjAjFyCpCbIBiODm10oPwr3eevxGZFfzYoj+Z9wHnuz6s7428SiKYhwXydhk?=
 =?us-ascii?Q?STeAAWn99s8PKreB23uT28p8I5zLsBKrbipXBdFb+quLR04dxiifkLDpb6ZP?=
 =?us-ascii?Q?mhoo/34YsYtks8SUfGjKTsKUB2U36Nh7NJBK5cVv7mtICzH3sJMBN63/ZcEN?=
 =?us-ascii?Q?ttzoU0wUXjrAkbvd4W0dBBj5B1P9ogspURuBo1bNNhYR8cQRofocOszCVjwp?=
 =?us-ascii?Q?adXeV1UF/9F9MXvHexGGsxmmrzZ48m42/XKoZ0YAdDf94r5WJfuNTi57m2ts?=
 =?us-ascii?Q?1hoyQyy4I7zDuGLWPrw4NHb+HV/vaX1Z9J9eXm3LCPasvTRaOveP/jqdVe8T?=
 =?us-ascii?Q?mnP4Azk4O6lB9ycEzvcfT6mA6lP4tWy0Nja3Fk+mi4A3MYT8A6ftmXQ00TVq?=
 =?us-ascii?Q?QnXKrIlD2gEKCQ8GK+L8lF42HbuszUB//hLtbfm5h47xiWRAMVat669zoJ4o?=
 =?us-ascii?Q?1CzhHCR4QFTPJq8oSJUBlqZfIn7glxF2iAMocpLBeme4hZTopHtER627IDrH?=
 =?us-ascii?Q?IyyqJaN9oVJ82adHJXOsC1t2jYqq/I6FRIqIdJr68yIr84fZHh8w3vRtqLpE?=
 =?us-ascii?Q?cKCRs8lIpvEKOH7taohlsqk2YdlSFR6jAsEhPy/x69U6vnQ0jd+vXp7LzelB?=
 =?us-ascii?Q?XXSz6ijhIKB+rrUtKIYtCKA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s3DJKcW30TvbIkEex4nHSLiYmcZpahaZ3P/qjUfS628elc0Z+QAR3OjJ9Cv6CrcS4ZM9ih4yq+zZi2o0h7JmMkJW21PAB/d+KZmh6Z3yyXFgn1ADYx3TNni0vgRcRJM4pDXRLBOF9UtiAazNfGCp8Cqw1VRDAJt/2R2zFhHYEUvdAlTz4ei+dyt0nP2CXucAzXO0MfW4LxuHK6HqyxuKZmXqnHx8OE3FO7pw6oaMTf24YFymeI9CC/n8d3ccvIeWmyPdion+FAbVik22EJLhMjC+gQKsUEP4KvNVEnIMkcWFUMkHJyiejF/DNu5zPMNtCYWU7fZnh/oJ455YvmLjM08tObgCnaSF0hJ9u7kNUVyjBIrPHJbyI7dxOl48S860eIu9ZNqcp2hqlkO252C7pM9erUL2cGwgMK9bEilOTwBaS7zNaLFGTwt0mtA0LWpt9XJoyCGhhsdunr8SnqdvP8XPsw9noe/S+ZVSFvQAoy1fLiZwXF6uOAhcTrO+nfZy5VK+ea2M+XCEwesRvQgCgzxRNRZBjfeAD8uORHDX77yt/LIBXJDIGmDaFiiDR8u2atmML16tkvLIMJWC1Mp3ssqFL6ZPugCihesmQ7TWQII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435d2314-0719-43bf-2df6-08dc6e90636e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 12:22:40.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Tj4+pwr/ww25NUK+Y+aAgd0NER+RPQxHyLVNask0lUeF0bs/PHXVDFqYMmOJQan8B+AzMld6esfoay4RUw1d+IcaM5zoIFQQXIlK2XO5W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070084
X-Proofpoint-GUID: 4bqfSA5FAfcxC7fi1qqEmiU-_MYJCr4K
X-Proofpoint-ORIG-GUID: 4bqfSA5FAfcxC7fi1qqEmiU-_MYJCr4K

This patch adds support to specify CFLAGS per source file and per test
runner.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ba28d42b74db..bd103b770c19 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -81,11 +81,11 @@ TEST_INST_SUBDIRS += bpf_gcc
 # The following tests contain C code that, although technically legal,
 # triggers GCC warnings that cannot be disabled: declaration of
 # anonymous struct types in function parameter lists.
-progs/btf_dump_test_case_bitfields.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_bitfields.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
 endif
 
 ifneq ($(CLANG_CPUV4),)
@@ -470,7 +470,7 @@ LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(ske
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
 
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
@@ -498,7 +498,7 @@ endef
 # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
 # set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER_RULES
 
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
@@ -521,7 +521,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS)         \
-					  $$($$<-CFLAGS))
+					  $$($$<-CFLAGS)		\
+					  $$($$<-$2-CFLAGS))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-- 
2.39.2


