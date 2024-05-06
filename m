Return-Path: <bpf+bounces-28675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843018BD005
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39301287B8C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7AE13D53F;
	Mon,  6 May 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LO26I+ZB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e6HzEzoP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCF13D27A
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005179; cv=fail; b=aO5DUsH+BQSiUyNm28wPp2EkwDcVyJREzM0q8/kn/g5ByQTng5yNoKJKmE2dYc8C2tODDMsVxEyZBZP2eB/PDcxAOpVfeyFFSACQrhy1qTljxj2uJ89DXlyDyHfmu+v9Xq6kImpQtCSckXysZtucv+nSt5VL286To4aqDYeqLFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005179; c=relaxed/simple;
	bh=7T+D9bqjxOXTOETxk6ysIqz5TeQBL9q3F/S+6B2+HMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExBmgSNixgxki9PBOl0J+bR3I0Bwat0ZL1H/dIlim+FplAtOdl7SBrJuXaxhXrIL/xQJMb3FBNVV6birbRUhVfxNLUtXDQV3BCu/ke0J97PXCfxKsVRLjOgY94M9HU7ZJBReSge8DLkpG/oSDz+K9dGjYTNPOptqSz2iDZeS+wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LO26I+ZB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e6HzEzoP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446AmxSS018884;
	Mon, 6 May 2024 14:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ldl8ijx+ZFAEE1ICG8DsIV3lqNvGyrJ/4SlWHtRnnts=;
 b=LO26I+ZBQ48RthWDfIlTHT+ElxN7evXLu9TaFMz3SFYuqrOA8PlJuhznBmiSOyYz1e7f
 oZi/QcB4sv6eGhsqLSfXA+Mfe6JuY1cBpL5AP0P/JaLTunMionFOvY3CDiKDX9tviTR6
 c4CQr00ev/5Nmp2XE7tsbMylOjPG9Su/BZ4pXQAWQQiZwmgMhW1K7fNiUFrV6sAdvr8p
 XkdFC5IsiCxAlmzrAjuHKag+Lp0vWCSYq+Y3pYkucFGzqZJNQZbYEedG/GDjLBMAzTde
 2AecD4sC4XWCFcYx5r0EqVVbrXNjWmdt+Qn+x+XEjKQbxyZCovj+9KjnYqP8AXw0/F4V TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvapnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CsDdg040813;
	Mon, 6 May 2024 14:19:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5x36m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2Wih+l5Z8SU7aLK6VGNwmCDddcNLeVloJGay5pMbNfeBM7eHHgZczJE1cBEho97qexp9WtaaO/dQ6xd/ikmVOr8vlZcP/Arc9l2J4svXwIlklumXUoq2xbIVKGQSco6WrwTyqxPoBgohGmBfLTjPjjkuJM12iiwH+ou1JTHCV+jbgEBsRXIqhMeb9O1Vlle27bFudZvBfmDjT/Mck3lErmzW7HqB6JXm3geHyyH7jMmMq0hCzI/2m/u05yFVWGtvWd3/ssv33kUrhO2aZXKPFcZljLIGxKupSqXvZPoD6Re4813W6aXcuJ8pWE1tDjyw54J19TfK5aCA+bZYP/JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldl8ijx+ZFAEE1ICG8DsIV3lqNvGyrJ/4SlWHtRnnts=;
 b=DgURiQzsW3MBSJX/NGbacy3WfVdtE0amBCqvheBClHVhlFpfTW1tHdLqY/o+UrNd7ZPHY83RGj5Z1aclsPfQVbWAj058ri+LbpVf0iHkWQOcRUXj/IoEylgxEVYRQtyIly+Fpy6VgIHT8IehSlud9kBhbhAWEluWc0xhjsDuNr83+Q1oOcKCr3+rHuNJ9FpJbJu5crltqCpQubJyVtyhDHZdWNWlML7i9c7GwpYD0HTPJGr2pV7L/jpwO8XEZq+aufH5iidK9N7LGujNJzwRknxaFcvZ02KUv9NPylv1qvR30Y+b4xr7O9sdJ05GZMh5DoveudDVMnveO9kmmxfhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldl8ijx+ZFAEE1ICG8DsIV3lqNvGyrJ/4SlWHtRnnts=;
 b=e6HzEzoPpXQt2mz5uLHxqfr+jbbeTvA6s11ALAmVhWFmAEH7tFZACUzNM2y1lU4yP30RNGhISc6cWZF+SkpP4OLzs8nOdaTZCkxj7gPjE8/sWNeQJqBKiLczFJkoOA5aFYpaa0HbK8X+Ivs/iDHRLgKc6cv7cR/7PK22CBPIUBU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:32 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:32 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v5 1/6] bpf/verifier: replace calls to mark_reg_unknown.
Date: Mon,  6 May 2024 15:18:44 +0100
Message-Id: <20240506141849.185293-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6245d265-de44-4849-aefd-08dc6dd78c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HtYWH6lqCvhd5ijjmF6CeM+s6cYgZLgydKxREs3zMOixlZYA6LnCiMHt/X46?=
 =?us-ascii?Q?2wkjGe21GtrlPXnfy0IZxD0QNo4aKdtEhmyj2bKmbwGCXTRTuHc9eCEOmZwh?=
 =?us-ascii?Q?ruI+NR0xg0Qj5gcqZUw2T64c37tD6hKs36ikJdIp+ArVWi4e8PsRDh4gUJ9T?=
 =?us-ascii?Q?zi2Efg9LrubSTrqyPu7FU1nWjc4nxkc01utRnXHV681+9757joSm16tIazih?=
 =?us-ascii?Q?0xA6qHp9ZypFtnET2aeCul4WiR526l37ulSnzxnSzJvArf/RBEaQysR6OMII?=
 =?us-ascii?Q?xi88HDwF169C1YlEzmWgJDk0L3zeC0tLrc2MBuj/+mj9dUGTc3VGP5S+h5Bp?=
 =?us-ascii?Q?X8QspUnTT6SiZ6YhNLNLRKENoiCO3MTxaLNaT2rA3IXrDf1/zibRuXxO3jtw?=
 =?us-ascii?Q?tsTA6v2r8w9ErU0DiqqEExN9AaK3Xf7pFZfU3UTmVk5J0l1peWJEw52nftqn?=
 =?us-ascii?Q?XBmTLwxhcqQIS+wvZgFCMIffTwVWI+aYR4ANiEWtQmBQqSDdCnoq4rY/q5gL?=
 =?us-ascii?Q?z5+XTUDieTVSgs1QZQRYpCuWB6rkRFvwn+PXRa6CQAY/fHHaJsQEOdov6klV?=
 =?us-ascii?Q?7qnIsCB4TUQrGmaQd0VfP+RCaf1o6/DotubPCljw8r83Qm/ryowmCBe3tYO8?=
 =?us-ascii?Q?Yh6TkeIWQ38+2Ld3Zw1MXdYFTnksIQvK30DgsOCqjMXK236yEtYNGCR7aYBP?=
 =?us-ascii?Q?jNhwEZFVHEiFfsdl0Ptzp8IDZ/jnc/aNp7rAp4JlVhAmEOUQK84KIVCX+1Ui?=
 =?us-ascii?Q?rJBdgUW3edMUM/7dBFd685xJRTfSTcn0lfwvEKWFrG6GInf8Y4R+aVIDbPuJ?=
 =?us-ascii?Q?sMbCMsdEuDu4GhuL7GguLbtmquiwGJY3dvY8Wd8kAVdr95q2tjOeh4+j4mcs?=
 =?us-ascii?Q?U3uQrltQ2iDSphF2NmHhUDi4kG0xzXouC74kDEShtOtuz7ub2eOY+Hi0sMHA?=
 =?us-ascii?Q?VW+45YPn0dpsaxAH/ot6T4X86PK4tksLhFmV0Yqwdx20ZBmRJ8URwUV1Ak8T?=
 =?us-ascii?Q?o0t2WuDFicbQ+dCuCjigXwD4/TneTY62ixs6TSnP+C2j5UWb7aR1qUQ85LnI?=
 =?us-ascii?Q?gcYGmcNAyz8aOoriMV+3iMxP9a50O1OxC81HE7wMxvMGICwPwcCi5lPOUuz/?=
 =?us-ascii?Q?qiLyp7XsRvLKzHVVE3XV5nE/41AbH2+NjgA46hfa6ai2uaXsqQLZVRwtnNNc?=
 =?us-ascii?Q?De3bdcBbwudjBIFbDxDX6SuaAEApScD7lsIpgvxnI8uR7E5+WZEFT8xHp2EI?=
 =?us-ascii?Q?TsnkPoL36z9OulAyPDMVGeczJ2Oa2+5LqoJ6Ds9fXw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9yJBZvwU2QBJkSVCZnk8uF8P/TfzX1xmy22EvNwrtP2amp+y6TaHAolN1UW1?=
 =?us-ascii?Q?f6taNPZFVFJI+C5ADH7AvufWmywUniGFKWg1Q/uBpir0mUj9FkVdHj9IG4Nk?=
 =?us-ascii?Q?hM6zd0ubEQHiWoYaIJGD+9Xv7zllJTbTaqjqkn2WGUIqPAul88MbZwxump+C?=
 =?us-ascii?Q?+dLtoZN1W0/LHtcCAwvGwPwktJNnEIV5ktmW1qk1Wtzlqr1wmE6IhoB2cOCC?=
 =?us-ascii?Q?nebHlnLiCkhWARS4DdnuaD9BiSULLohERELhNb6lV6ZedEsgC9cI5cNaRt0L?=
 =?us-ascii?Q?LwuTjN+zOpvWoMxgXxqTPZWYZjAJ3/OPPUXOZ4BRbhrp2Dq9j3K647FmdCsV?=
 =?us-ascii?Q?Ktdwo9m6CUBlYB88RHtu6bvZ3LjVZmil2drnno1BgdrW2Dir5rztBIFOXd3w?=
 =?us-ascii?Q?guPq4ky+im4fCg9W4NJVMoA9auGVedgrgn0XaDIXy9wvueRrQ0WBTjgs21e7?=
 =?us-ascii?Q?FLrzKStycgS/fe3HtjBYoV+OT3EBT3aWEvxvRb4MWj+xqdbu0iKqI5uBC0Px?=
 =?us-ascii?Q?MxfjZ2dtim9yUxWY+xPJVyEBRVjpF3qLihZQpkugltJznGY4yVVNa1f4hImG?=
 =?us-ascii?Q?CJpm6ZbiSHUWQd4nc+RdF6Ey7aPZe/jait6OPPQ5589mSToGlUQrYlR5v4TY?=
 =?us-ascii?Q?hiX7/1ih1mLevSPX9z64i33OZN4emSbHySbgufp1W/cSF7iWO7yf4L8NdVeK?=
 =?us-ascii?Q?vaL1K9FX7CqNFWgKjfxsEuSJ/LaWheRF8RZmep511DSyXz7tBSnznh0cTyCx?=
 =?us-ascii?Q?SBlTCS6f6p3wWH5kpPM1aYy7t7plty9a9wEd6Y60X0ehMHn5L0u+4QDy29dU?=
 =?us-ascii?Q?fa8ucNEWoaHH4kEaIlMN2/A3XhmlmATV2UwMwL5olmDu/9LhvpSt6CqTUmyh?=
 =?us-ascii?Q?fOZLtcAM/yWnpzQjdgSgk0cVNaWqSnLGzsR9mizFRjiQ8mOSzqWRrRQR0ntl?=
 =?us-ascii?Q?hl/+t3Cqp7dLQuxyWSsYAEKhst3XfCvl4gln4iZeUF8gpTTG/vPluXEiPVbH?=
 =?us-ascii?Q?+kcwqYTAdeRVCFq8AimLR+tdFPrV7BC3RnH0FX9hHq4e0hiLZ3m9Ev8v8o8L?=
 =?us-ascii?Q?3kzLg8I04vSI+o6IkNnxE2wktDsiehmn0R4Fkm1LqLdsoo+PH5yFe/zxa74R?=
 =?us-ascii?Q?AixuVUMMoigdosOni7P5yyWyzv4Fw6SLoajYyJRbdjixTFfJz2BDGRZWlF5t?=
 =?us-ascii?Q?yLtwW1XYBWWZbB6nSbSO+JJGChfJJ+C0RfKOweDVS34Nn33mX+/ynTcOykLt?=
 =?us-ascii?Q?hPf1wwCwMsf7+i/mYEQ+yv9c1WACcssnvy6h/qLhmkpOS9o6Za1f+u4VcQY+?=
 =?us-ascii?Q?WPdeahtU75cH7BC3cOL9mAX8LvbV6Cm9FhauYacXFMOD73L5j7tXQMzk9rtz?=
 =?us-ascii?Q?N+jySeunoJ8WcJT+RFWG00UEdbBfCr38rlbChCLP28dqdGTcZ7xMU572JcQ8?=
 =?us-ascii?Q?bkCXO4xHJw4NTu9EWAnRTGkVo4wk76rr2F5McNAR1SJr1FSG2VufTlMXOpRc?=
 =?us-ascii?Q?XZLCmS5Fd9U/9dR1xzip2ZDBseyebavuRw+u7e/7PrnL5XjU4A3lUDC2yKy5?=
 =?us-ascii?Q?5xiPmdeghOJlATeIqW7sBuhYb/tifUSvLFXJCRYgwjY2o2qHdDPlLXKct/2e?=
 =?us-ascii?Q?2Sg/Z+aNnIX0rmpqMGGbA4c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B5yqkWY/hfZRZkqZZ7J2uTrgYWkcAer9iEF4UXPFipF9qNbnTZlmQxTphL0pF3HaFLy7jKuITBB9Bu/9P0MA9lUyHGNFM4/2a0Trhz5CxtHbNQ34wWIYKb6Sr75z4RwpZ0iHBJOvKs4SEY7CuE4K19cOcy/YBsT/shHMNG3cYaUO2tKoO9CzbV6rJdB9lsVBAwfWexCi+IrQ1V2ZDMml111eIyreKdbxDvNeNkw/B7ANnbIdpXN9Goc8sJpkS4LoU9dLraksDKfNbung97gPGPlsXelUcyPIdH4vUyrW6sRn/Gaolrnj8sh2TH5q2lUQjabwygKXJQrwrel9tGbir1iJbXWuBIELiIydyPkEBUi+f7hIysADzvcxqazNKUouPzZKAk6LxS1OfMnhzrKPYvzZX4uDDb7OVR4erQ4Ess8Z5TtBPHB+5rx6fKvTYgpoCoBHyONIHDtxrAIuE0btGolt1A3uVyk444ntL2T5Fskg4FIeG0u9YeUl+kAndHjzlKOtKv/UXcKvrkkrBJw+y8/I/Zx6zPznZtjqyUziQbHi4pBb4+uA8LEtTgcd2+M87yz0eeQdEz+4Rq8dSPJHjoP2QULkY0DBFJfUaa1lPt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6245d265-de44-4849-aefd-08dc6dd78c61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:32.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Esds6wgxtxaeKllPsDbJ7meAta+MB9Ber95vvVEwzF7yBwUHSWDVzYlfPf310OPq7GMlb2a5hiL/8sGTM+1MJdiycut4vgeMx0cSnnz5kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060099
X-Proofpoint-GUID: iYsOuCIz4vPKRAeODCd323bKoE3_5bh0
X-Proofpoint-ORIG-GUID: iYsOuCIz4vPKRAeODCd323bKoE3_5bh0

In order to further simplify the code in adjust_scalar_min_max_vals all
the calls to mark_reg_unknown are replaced by __mark_reg_unknown.

static void mark_reg_unknown(struct bpf_verifier_env *env,
  			     struct bpf_reg_state *regs, u32 regno)
{
	if (WARN_ON(regno >= MAX_BPF_REG)) {
		... mark all regs not init ...
		return;
    }
	__mark_reg_unknown(env, regs + regno);
}

The 'regno >= MAX_BPF_REG' does not apply to
adjust_scalar_min_max_vals(), because it is only called from the
following stack:
  - check_alu_op
    - adjust_reg_min_max_vals
      - adjust_scalar_min_max_vals

The check_alu_op() does check_reg_arg() which verifies that both src and
dst register numbers are within bounds.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7360f04f9ec7..41c66cc6db80 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13887,7 +13887,6 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state *dst_reg,
 				      struct bpf_reg_state src_reg)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
 	bool src_known;
 	s64 smin_val, smax_val;
@@ -13994,7 +13993,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -14007,7 +14006,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -14020,7 +14019,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -14029,7 +14028,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		mark_reg_unknown(env, regs, insn->dst_reg);
+		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


