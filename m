Return-Path: <bpf+bounces-27751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8328B164A
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE61C214F9
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE816E861;
	Wed, 24 Apr 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XGQ7HGxs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B97xVH0Y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42923BE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998486; cv=fail; b=GPnJ1m3kK4pml9zexwCC/IsTAjKZrPgtMom4ax38tZk7SISLhSfh+/zvREQhqGO+tz/jBI5k4m+lSE+qsBI5ZX85TDaEJ2Bufs4HeVQ6VMp5VlDd6z5sNANCKTc2cjkcUf42xixosnd580RWy1aUTnLDsdHwTxb+QT+4se2/N0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998486; c=relaxed/simple;
	bh=93jHUR5GRFixHZoqlvb6YtkD4WD3EI/9V76HSWCyNdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eOfCA1gKT4Z4vmwrQvSLBwTisWgHjFVC1LaUDGe7mIhYu/evqMua0ovqKl3Ua6qvqqRCT/HEYXYZug9CqX62GLlrqoXQUjpcOFOzLXYQG2gnD2KNWW1F/p5bPWYYZMX2lSXVGRtNGBx7clBRzXK5omUWKH+w7WmeJqiB8Dct91g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XGQ7HGxs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B97xVH0Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OI1Llw014712;
	Wed, 24 Apr 2024 22:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pPDwpg9gU8mzYW2XhD95Bl+aCQye3Yxb/5jmVYrAz18=;
 b=XGQ7HGxssrs3PJArzeKoCTxo2Gldpn9+BXYz+QIOLX2FecrD8aGxT7rGkhdhDUKud81u
 ESsDij7LSKoKc8J4Pdv+JfiqAdTyfrYo2U/9wO45WxpsyyEnZE3vClmk2mOrlT2OQ73A
 or9ZPPwW5wQzMcXwwCvzOiHuFUeo5hVf0+pCAxszfl2RaNWA2uDkhMA4KezELpPyUmgF
 WMiq1g6XzoQnk3k6z3dJX/bMMOiiyvfdnXxqHuZ+m8MHdXp1DYZ/yoFT/+FTL3BcYJFB
 IdZUlyLcMnWimmYR6GY8WjQpCaqnu0fFNAmWVQPYcNx1l1lS4bO735bFUOH2tDfIYWF0 kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4hbxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OL4H1v001732;
	Wed, 24 Apr 2024 22:41:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a4avj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzoai0N+CFwXVPjLwUb1OBbuh2mJTE3LDlkl2Mqcc8DGAVNSf+KV5A6VnAD0UzZJ/BaOby+tEbfb6K/B64ch12YdeeDHkgI8hUIZnVJ71Iribr/l3q5v1KmQxOf4TrqynOIVFLUhHakYKLANCgE3MFbz5vqBqgs3hkWRDr9ImbyHLIUIquQeU1dJx1qeoTg1KyJ3BukFpUoHFtmaLq55H/BbGyGZB59SY/dNPhumfPmLAvOhF0VXubQfdXarR+ZYo4yCiA0vTutBtxGiY6+6VN6dLlZbXNN/4zUpc/Fte+8Zbpp82BPQPV38vbDJFjKFDym0QxJF8m65+OWYwlb7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPDwpg9gU8mzYW2XhD95Bl+aCQye3Yxb/5jmVYrAz18=;
 b=ZMt5uVoTIQxHzqLifJwYCkIUvsjs4578PSjgKNoxkKyJZKvCyINcqw6eZcSLsXEVu2nv6ZARoKCNlVQiwE+EVJItOJYiZsIM9dPVNbuN0XhGOrGYUffPqifA8psscWYiswDpvTTRS1w0/VJj3ZuWVy8q87Pk3cPpQ65pdAjcUE/FYka8KoTS0idekLOg07d/4ABZMQoBY4931neOAg5iqWPgchqaIdDuNlnLluxX2uG6cBVjTIUeqHp+gXWXZxcYJrcCTO4SJS6n/sfkQsarOrmRCYfngZ/0Er7phf0he7uQZQ+FVtoHxjLTdL0SH9NmS6dunuhAL3oN2H1mce46bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPDwpg9gU8mzYW2XhD95Bl+aCQye3Yxb/5jmVYrAz18=;
 b=B97xVH0YlSGP8XAoyUAQh4SfZ8n4shNxeF6dQqwExQkFyn4bYKJQSNe3zG7ZEsvTrxitus0WMEjiyDe4kK/LZoftJKjD4oBeig3O1FLXT1JL09oFcJPdwz1k8c9yhNwo8cAPV+HYvSvtDf3sAAZaPORPJ+FP6DljYGP7nGbKteg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:20 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:20 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 1/6] bpf/verifier: replace calls to mark_reg_unknown.
Date: Wed, 24 Apr 2024 23:40:48 +0100
Message-Id: <20240424224053.471771-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0569.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 359e447e-c53d-436e-4294-08dc64afa95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qxGGfbq72mQ6OW3wnxXpBOi/ygLPfZihNC2M3QA46vAL+MFnaez2yoVAFsQc?=
 =?us-ascii?Q?ivOt36DJR/Jl6r1BG2AkAfudsh+KwnUGiangW05SLvEhhWukgFKxdKLVA96C?=
 =?us-ascii?Q?XOrN/edRXkvqNUk0D+PV+HBEcfl1CStVbLk828gOjLoMmElwSlQBTrP3TGgG?=
 =?us-ascii?Q?i0Lr4c+C+deVrNF4vWJtruMfQJ8UX3wRsgHkS/Jn2bomisrDeIGJuaDmlZOS?=
 =?us-ascii?Q?4Gf0LZ5WZK8KdkeiTeaopG3e6r24cY7EHdd5uNcZz6PRDJy0rITzsgxAjQit?=
 =?us-ascii?Q?6zp5iBpa7PYKLI7a0vjfqRytxEMB8DeEglKu351s6UGhQ7bMKEMfiX/STZmf?=
 =?us-ascii?Q?FC4JkPoB7CzzvFs3HGxfasptkBRWJVSRN41ZIOdKlzeKPIlG7nIlXsI1cZaX?=
 =?us-ascii?Q?U/Bcskwa9PbWDchD0n7pzhbVCcYuSawS/Yu5n4ZuYbEV01lPhdqvR2jrs+So?=
 =?us-ascii?Q?Hfzn4C+xKQCLSGPvK4JTfyaJ+NEKNbD2TRStj6n5wksjWLtGiQhlLYJL60NC?=
 =?us-ascii?Q?cnNRjRWmV+hW6LtkenKF8HBuHkyKI4RE7vfaL5l0UBhcnLV8FS5vn07ALSuG?=
 =?us-ascii?Q?eKitk7mKvoZe6FrodGxlS3f1LBlivsQEiIfxJWu+CyUgluc2AE1IHj98wwwn?=
 =?us-ascii?Q?55Hb68wILMZo0qTAImemPCSJ+YGNvrAk3SYxZ6muERu2b0qwp5sTuOxthpMX?=
 =?us-ascii?Q?RPNwLh73MM+vujivIQ7/W7nAAu9jm5otYj6IMLxpvQoVRhKyBTLc3/NOjr71?=
 =?us-ascii?Q?k9n5BZv1+3BhMIlZYxJmAWhFfdFI3H/0UWej81NkvqeGr6iwob8XDX9Ao05p?=
 =?us-ascii?Q?oI6zkUD5kKfhe1Xu+pS4D6FOiEXqWCPlCYrgcgOinP85T+a+SCw1rWrcuXV/?=
 =?us-ascii?Q?dh7dhWrEY87xH7G1NwQ6iaQcZHNt7DbGLjhkfkcqG9OgY9EI5NUfYHRJGSyp?=
 =?us-ascii?Q?tpsmtpRijv9HzaKbR3J53SH8XU9utqo9ss8U2mnl9OKtIgrape1CRW/h7smW?=
 =?us-ascii?Q?Qv1IOJ7R3dNAxVTofoY1Qyp/FpmQarzNx2jRmLLYXXld1PNT4IYoNZOdpTTx?=
 =?us-ascii?Q?mmRgqVrBPG6TIzZFljvfCZE+IHEDJJQqxYx5ZuY7d3BbRn8TOPXK5Bhl2KnY?=
 =?us-ascii?Q?YmchoAyk31XWlwewcHuVjCMG51kw8N8Irs/usYaA0XZVq+T783qsSJkUE4Fz?=
 =?us-ascii?Q?Z4h/QoPst2WrebX+scHRGmDR8Je9oPPJEhq+8EOEsArf3/gWiP1GdsN5amle?=
 =?us-ascii?Q?glnrPlUl30bFZqXrTpQ/7B4hfbt9ov2PneqIRHj7dw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mpblg/j7obLDx3T3T060t6HUeFk2adpZpmFfBse2cMqTWj4oBNtt/SfXXrLB?=
 =?us-ascii?Q?6rNXBKp5KPjqdEgjotO8MdMtihNRGwuxnkaWARD19qLb50kCoaZffRkA4Mkb?=
 =?us-ascii?Q?GePCIlnjrcs/PDp1K2kMavS5p+krAyO3xzM1sB/ul7ZT1vt3qYql4AyOqbKi?=
 =?us-ascii?Q?phjgGEhvHkqadru5Iu3npGPj7E4cT5e/1TlW5qismE8eV1D74eQXmM/Dglwv?=
 =?us-ascii?Q?t/fCFB2lv8U2XD5Hv4m6zxnHFTrDh76Plw87MXcJPM1iGWT6J5UMKKIyCr+Y?=
 =?us-ascii?Q?4DdVNZnMQ8/c2dqv88ItkWEo3EYT+leTPpWQey5NylO5pqRZ2dF4kXEfacWc?=
 =?us-ascii?Q?+x6r2dKF26w9f71fvuyEwAgDyxvQjNto3ZQiRo7CmzRJxSoPvgKXjgET00Po?=
 =?us-ascii?Q?6LS5Dd2Ghj8FD3sI0He7vcGK/CiXG0FdQUR3c/yNUO2l6nN11TcChhdSGG/H?=
 =?us-ascii?Q?WWvw4Ux0TI0O2RSAGigF6vv92PkkvO9eSfHlmxmkiubxYwxD/KIxyGiCmCbG?=
 =?us-ascii?Q?0Lt8I5QRgIOO/wA3b5LNFPh2QO0CPKUzgulIefclK8HaVYlEIg3o0FD/vq98?=
 =?us-ascii?Q?kz64spey1gsINpPgaLxS+mD1LpXGyuM9Xo0xlFRPcXUkK5eMQFENHAylMvGA?=
 =?us-ascii?Q?JLWLxuV8WorOnPWANFH3Xr4W5Goa/j23KuQpKsTonreF7WFCaO7KfOwzs+9f?=
 =?us-ascii?Q?jpuDb+zyY69x3OUQJ1x02PCY4T0y6iTyCC3aXhdTvmLX93A9HTQa7ZJwQypb?=
 =?us-ascii?Q?Uzm+4rglV2NSMN2wwNQgL+ZntSPWPGo8GBHtfkicJuKWeDPIYwezGZnrUbxI?=
 =?us-ascii?Q?fbH1HV+/AuDtYW3951Lt6EgkQ9657miUTgzFJzCjfn8jGVDk9Odmm0boP+ns?=
 =?us-ascii?Q?p5XTI5LUVHPP0lLcMP3b5fllf9l5YMczoe0mQYcfpl8E40BclSRD9hdbWLRR?=
 =?us-ascii?Q?Tmd1g433ksmgrHbaPVrVWmvBADcm65hduknJ6kEILS6y2+OHfVL79/4MeAGK?=
 =?us-ascii?Q?XPSfSIceTKKC3P62jxBk6Dkkm/Yc4AG3TJaEFMVmLL5GCvTJ1tPXKRMBO7/Y?=
 =?us-ascii?Q?+1z9CeHBQYgRk2EOMgLQyqQ8ash0Vla/7XPEGBucVD4PWAH9IqmoPvItmLvo?=
 =?us-ascii?Q?TOjQAaXRNigIwg4SvwyZMVFlAZQsszB/GEODLkktYmgTfAcD9Jr5HsUmqPJf?=
 =?us-ascii?Q?1xZDPiGX1QXRD9gldY+sEfpcS9ua9QKhuE6pews5Nv/S9OjEdfu6Nk4Pq2Ex?=
 =?us-ascii?Q?YC2WkCTt46jYOqKFE/mBypxqmvr/ehdD0MePw7vzON6f47f745P61Poi/b1z?=
 =?us-ascii?Q?MOhAs09rfnJgzc64VwWd9Yp7bImwd1IuLnBU4fhQFhVVGTXvrV0pzB8Ee0VD?=
 =?us-ascii?Q?JkAiKtlqTVVzdObKT4XzoQhkGtZLJvdQWM5l8twzx+0EntcbqibS051O3kxl?=
 =?us-ascii?Q?vSWnLqnXAAyWxnSnrFAs3cxI+1Yd5J1ur73O8GND31eED94dMGMHztI9Aih/?=
 =?us-ascii?Q?iYbhgTIFNSGd0HGQRv/sNiAvb5j67o7dICiEJYIk7JOpaBPZ3kmTEcXw04kD?=
 =?us-ascii?Q?N1Vot55xhjdupcL8iFd8s8vs0c2G2v+dtzyFBo39oz0tHKLhiTc0wLdVKNcQ?=
 =?us-ascii?Q?vZvgoQ8Ko1yMcXQG2tzRxg4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	980z5iRYQLpLwHemaLyA2SnlonEi5V59lMs4P9Q+kX+frFKOkjc0XxL0dMCKtJMbBBYX0BAUjKUQ3pLl2ePh7RgewHz2nw5fiyrR26PQ+CIBAbtvHWN2yqBUE2kRABK+/nL2H9FC/zjkZvBGs62cWxTMtLon86+g5/fhCuOgcNLGyzbxW/Fvn14GCAw9qej4TjRhEynKV2214fqLINZGReK418/pfGr+hhKLMvGOPADDS3O2OUV0GXMv6ESqlF3FY9QosgQPGSmDkUDjH+Rl0XBednE9K+ejwCrCxzY5s1ClNCMLNYpJfCc5eNM2tHbv15EjPIBgwVaFHsNBgKZqoidYJo0OXylrt9r7qNvprRSjJDOwsRv9ZQvRAs5LrpKAjeqzjucrBcJgg6NvdOTMPz5AUrgJNSoEK/rTW+kQKNm86V6jyFnGYuQEndNfja1ycQ9PJYBtiAv32IKcVfV+pH12T7rOKTnA5gBbJJ93i3KpwUFzpsAwnSqmbGQL4DutpoFHlOTUNZbdke3ahjLn/mFpAIHOjEp95uvvrQUAI9Hjy1LnvTqcnbrS6ciTR2659BOt9jhRPpNts3fiG+B6iiICNZC/u7mgAJTdWTvBNFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359e447e-c53d-436e-4294-08dc64afa95b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:20.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U9b3jcH6fqaMGPT0JPe+XKgljs5mjgSRxnfQAKd7+bQzyA4k82UTEK6hyoU9BrHU9fMekgzHXYmhLMOpOaP1KrPQcPWnhtBrwcr2IxwMfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240117
X-Proofpoint-GUID: kNTd57GAfmCubL6c0KLGwItrfxKzFTA3
X-Proofpoint-ORIG-GUID: kNTd57GAfmCubL6c0KLGwItrfxKzFTA3

In order to further simplify the code in adjust_scalar_min_max_vals all
the calls to mark_reg_unknown are replaced by __mark_reg_unknown.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a7e34e83a5b..6fe641c8ae33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13704,7 +13704,6 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state *dst_reg,
 				      struct bpf_reg_state src_reg)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
 	bool src_known;
 	s64 smin_val, smax_val;
@@ -13811,7 +13810,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13824,7 +13823,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13837,7 +13836,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13846,7 +13845,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		mark_reg_unknown(env, regs, insn->dst_reg);
+		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


