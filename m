Return-Path: <bpf+bounces-28685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F98BD172
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D462862E5
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22215531D;
	Mon,  6 May 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kTr7r52v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cnW4ptx4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC84EB45
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008735; cv=fail; b=D3YrjP2DqatwRQoZZ149uv5U/ngDJdMksQZUaytbsZoRyipmI2ZiXl08KSuTPv0KeJnqXHj/XHfk+NYwmBvQlUmDnEr7WE4fBZI+TNW77ishjSQfLulHWLS1qkLhGfTaw+t7MyKiiGl5b+s1l2cX8lmB2w5GsiqozAqZvsBg5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008735; c=relaxed/simple;
	bh=Jl8MpiwguG8Hs1zSkD6Ul5rVTHYZtbS7YGw8+AwM7Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=quJKYIe/JU346Uk/Quwsp2Csxcan5HL7C5e41fu8y6c+XCUCAAj+rQ95bWXJvi4Cbst7XoLsXwGp4EORYbZIYSqSNCq48aOohnSVgB1JBWPQkKDmrcOrbwDmiJKD6KQd7aUFRrlTq+ruXwh7BE9At7k348IbHEwp6HEH9vcgWI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kTr7r52v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cnW4ptx4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446AnATQ031879;
	Mon, 6 May 2024 15:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=RZ2ums6VaCFYkg07TIw98uVIZjaANGR6cPdRRbV9VjY=;
 b=kTr7r52v4t9WlzDrm5L0KXvJJ88OhmFMVfa1d0vo5/Xq+jl+5S7xoWJycCnjO4nwpMRN
 RvCtkXBvit+pNHf1KSn7Dw3cYLyHDdfc4h/eqMv+jh4l3iShJ9jdX7RCZZhyOnyjRAm0
 L3BzRvBl/AD83Vit8FAEJfbwmJJrlt1Q9K/iaPNi8JhW9IrOR3WXJdXdtm3vPwCrOKzG
 HngzMc0P8jgJbyxbz5CrBUX+kTo0lrMLT9F+JS2Dr2staeVWL5qQl++Wt0QHVjQDeczW
 Br6gNoT+UzIK6SWrs0l2RADkyimLGe+7zp0RTAPzcnJxHwooFhVOpcBdMxQhTAqTXsY3 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt52v0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:18:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446E2BLO006923;
	Mon, 6 May 2024 15:18:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6se9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+ixt123FqmazCJTPDUMRsHNzGed3f+40bnTr97VzfCARaw3QZQl/FXDWyvvz3LOnUajxcJ5a2GqjHEDpnGOwn8HZXq9oBlPSIFNO/LPdAB2NJ3q52n4MQpchx005zWlZYtAEW4PBqi0AZx4FTULajB70ff3+Qb0ViBAE8fQudSJxsSz5NwACz3jJwz5nel2mQWRuIoaByk3Gw6v8QOcWbw2mMcZCjI41fXl+ACpod9kdZZ6ZkfB5erX6M/TabcyneCIuQYqMDElcbj/7nLYJrbfkBwQDyWqVuR/FvO87I3FsfEAUZ11O+CHRDkG6wh8+H2ih5Dy1MWAFDNeRwGE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ2ums6VaCFYkg07TIw98uVIZjaANGR6cPdRRbV9VjY=;
 b=BVI3pvsuPD5qSZBgWlLNGlZpYJlN6lfNIziLVOaPeJBvgHQfLvPrnKJ0E0IIYnSzu7L9sLp5Nr8AgqL5Zaorcr6rhhLszmta5eRnpPrHJxkNzcc6H6RJmWRcsK4EcvgIFjiwSAGO64NLt/hjy29KEWl9KnvDrJlD/UyuuaD+E7ldGTopB9uUtmWK+9bjYgJI2CGjE+4gZ9K5hWad8wiCwyi8VAEBULLIROOMzsClbMRipugSYPCcV6/b91ULOWuJICBP+W1i/JHO/FSTM1McNtRXpjCIEBmGgqyvMYmnIih81Pj5hp32LxjhRveDZqV/0eZYyPZzlGD6RH3WJly8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ2ums6VaCFYkg07TIw98uVIZjaANGR6cPdRRbV9VjY=;
 b=cnW4ptx4vENJclSkEGZnUxy0wKLwSXnGKnhpTDSEI+H73ryJK+0SvxzkWmtVRJZAMq0pKH+hM0/BtlJmMk9yBkUmpu8Zn/8T+T5Baf1LV63X0c+Fpu4HAPYvKSm6NuUKYGNf9VxjGKLI8RdE0no5IHIazFY3uFRXbE6QTGBkTuU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 15:18:46 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:18:46 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Fix number of arguments in test
Date: Mon,  6 May 2024 16:18:27 +0100
Message-Id: <20240506151829.186607-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1f7af5-e828-47b6-1ece-08dc6ddfd2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IiP9YCEXWPaGnRnN9s7wt5PCaoQN5r8ef9jSX2fm2fBptLZXhpjnC1Zfyc9y?=
 =?us-ascii?Q?L9fK0hfoT2cLf2lsTb8iTA+DP4CEHxoegX9TludrY4yADI/IsfuzCy97+LKU?=
 =?us-ascii?Q?CvmQNLRnJgSeytLy44uipXZYRvE/W87s4c6D/iklmg6I1fqcaIgVBSZCNWtB?=
 =?us-ascii?Q?kvmgrcDvxqSGEvIBtQ2Sc4XQry5NQpvPtKlcokRd+HPQ5BBk1UzSNzYsUpTY?=
 =?us-ascii?Q?CuY0sKROPAv7K5GHwQjXbeSjRt5wjaxcN8dfBihxneCjFUCSygrZXH0fYKdx?=
 =?us-ascii?Q?Qp6UaJz5za7Nz8GLqv4c7n4Zj6D2vj2TRZZ8Ii/lVNEOmZsm8kJtAsUho4UK?=
 =?us-ascii?Q?i/lDklpiuamsrlV95lB8KZAmj36NUFwOg6nfyQRywvx/nckt9/Ba7yqIKfNh?=
 =?us-ascii?Q?yJIxVEr8UnZfifBI8ifHRj7XjS81VGJpsC69AmqWZ0H3eU1BCYcoHiGuHr9r?=
 =?us-ascii?Q?ZGXPZSDSCSV9FV7zJdvZOJpNFpcPEi+hYwFpb8/ZZy7ngqUKmwwS2bPVvxB3?=
 =?us-ascii?Q?bYLLLYoeoCHei5ZENoxICUB3H6s3Pfu8bYGS+JVRNamaTmi13ZGwYfggIYgc?=
 =?us-ascii?Q?zpah/wqM57+6H/c+nmPJ7X5oJiJ2ujkZFwnN9T5UzYU4E86tC1OAE9zxJIf2?=
 =?us-ascii?Q?dlqws/VcYtWVPQXvbalBw0wBXpl/qsqMDrNucWRvpkV385ifGfPzwY1ehIwA?=
 =?us-ascii?Q?vFowrbc2rXifSR6DHWzVMN0Yz4ja1lOe+8sC84Vbi/nohMh0w5GhaL1Y/baS?=
 =?us-ascii?Q?IdaHE817KcN4j/O06VN6/Bs/kEJA6tD0oMuk3TafBFpBMRVF0dXRpvTQnqdC?=
 =?us-ascii?Q?6RS8MnkOF4uriXjFIqaPgLTrzduy0mvGrojewHaoRGwQ67+lit51G7PbCtOn?=
 =?us-ascii?Q?QqEuZx8oFa/S26O/hOrJ8zOM7v1y6T7jDGZY/w0lCSAmEI0BdKwKK5pChj/m?=
 =?us-ascii?Q?i69U7K/Vn/AGcmDRPXRA+n1H86//o1X91WnIJQznZTT2lE1BkR2KWUwbiz3c?=
 =?us-ascii?Q?7QDzOwggiKkXD7yz0cs+hVwKnVqMwZX124OlmhVGRgsNyzfN+5X/aqwLNx7M?=
 =?us-ascii?Q?jFH8bHHQlGufMxRSpssZ2rMOwVGVBWGIzQn/8XtJGum4GzrlbkDUSeTYAQDd?=
 =?us-ascii?Q?dKHPScwSzX60QC6r2mcoe4uNm6DaDngv3HZ46FU3IXsZ5ig2PPvD8Qz6TrPo?=
 =?us-ascii?Q?hieWNVl3BeH8l6Mb0Q317ssFSEfozpE+wqReN9kF335u4bDziN1N0LkKUMcw?=
 =?us-ascii?Q?N2ywuBJP0dUTJ3FF9eDKf07+bB8cTJdPKbFa28w0qg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KvlFFg82nTOgTq+tX570Wa7LhtHhJMvtLaM9XPUhiUG4slfa5nU/BslLPW+8?=
 =?us-ascii?Q?AInAUCkS2K4sJbT9WocUu4kCHlzznUCvLg5GdX7AJdFk+ruG5al0CH6Qwyjy?=
 =?us-ascii?Q?3tRonP4LnPTvN6u5VpU66ECTfLQHK/8mQK3dyiH5PrHfjQ1W3Iv1lcJgj7u6?=
 =?us-ascii?Q?6Rp7dLAC2gZb0JQQjRl5IJbHhg6/fl23Hk281MYfAVnHNk/6va9GIWJ9Nbec?=
 =?us-ascii?Q?xLWqu2iQwXGQtUKSsjoH33Tlox9ay7FlhBdT6GC9xW+mUrs0ZTu5VUeoFwNW?=
 =?us-ascii?Q?eEvh6GOOsonzu8hD9wj8fFhwaaAJ8X63OCp2f8diZ91PQMFCXnDbkIDh2zdd?=
 =?us-ascii?Q?8SQVO6PqdnNpVdhvKeR7OZ6UoJREaROZaN8RHv8s1FZ0xpLe1VhKlPDiw5fN?=
 =?us-ascii?Q?RGVJq9rPuu0E3/fk5anQuFvT0/rtX4mnr3lYpHNY+T1pkI4Co8umRIP4dRDM?=
 =?us-ascii?Q?jPuLKQ3DIn/I6kLsEVB2yx6dVehdwsBRCoOSXUphlM4RgDYaEB1Y5dM3Vvti?=
 =?us-ascii?Q?vCSmXdJXZk+skGidsC5Kq1KG4D2gyA8g2A7qLgJIypXm4D+vtsnFAb+3gVJG?=
 =?us-ascii?Q?83GkS7b8u+dp1FRPfyYXoT9ZVvQKT91C8isxF3NKkh1/fKo4xRX7eW2Fa7Sp?=
 =?us-ascii?Q?TF5Ghhr8bArszQgb29o+ptBeXk/gcDH7A19RM99Ij3toBLmEdvrp1aroTETw?=
 =?us-ascii?Q?7pQti3kdWpx/2YcsFNgiJUjRCSFXbo+X2h8aD6BBDc8gfK0kL46yB8+SRICR?=
 =?us-ascii?Q?Tb1oxTaGP2NhtR3/U+YvHBjEMPJc475fTEQjqtM42Gvyx8n52XyfwpP90y3R?=
 =?us-ascii?Q?w83Sfy59VZ/m/xGe4GoHox8tef94FrPcYu/NkK9ik6SXwV0R/pzMdarI2JnN?=
 =?us-ascii?Q?UOvZPptzW78mA3dHv0XxUd2nybPQnNXEpOXtp0ixy8RGPXlpYOhW/+IzUHWV?=
 =?us-ascii?Q?0JbM1qKs7OO1hGNwVa1aBWdrmZkmiCG8a3abohhZs3+w7hDJxYDKdmy0Ic2J?=
 =?us-ascii?Q?9ciA4jwK9UOk0iHdT9T0qD9DHMPWhFUOV+D/dOOBg/kekKly5AGist8KMHW8?=
 =?us-ascii?Q?JjWY9muwnUv1I149Y9LW+SjdkPBHaH4wXGTZtXQcvJB1ODjc62ReOHbgsbHD?=
 =?us-ascii?Q?M/e9JZgJi90Yry4m7LFoS66+pikPDNRTCJgYvJS1Gv2fA2/FrIclAKcvcHOv?=
 =?us-ascii?Q?Kp5D0P7kGdM95orEsbKxw5oxr9P4IYOp8Ojh54IJVXFtCeoUAAS+7QFvouKW?=
 =?us-ascii?Q?3d/EReYgWznWIEolp2dFSi/14dLgGZ32RHmp0nmzFYQ7dnGzEgFut+56P8lD?=
 =?us-ascii?Q?Ez/DJosTjDJ+FPpo4xU3i/F+/lTh1Ze/XVsrOcprrJWR4yV7NkXx96ATkhLb?=
 =?us-ascii?Q?qXCvN2mO6XGwr1zJnR9YE4M/aFzTLBHpQnW+DGWVIHbVDeJbd7vvSbD33jyu?=
 =?us-ascii?Q?sSuvBGg+9HIAR33GR5lwMS41QcoptHQz5MrtBoXKFSXBsRmJWRiR7xemT5Xg?=
 =?us-ascii?Q?+TcHDginVNwtFPffm649/546dgwc1nRzAzljqCH0UwelQFOkJA7W74T36zut?=
 =?us-ascii?Q?kVqeMohT4YaM5Djc8zH/enj8AarCIeHHtOOE9amF0Qszl9cy2FAKXa5zdLYf?=
 =?us-ascii?Q?1Hk5CaJXxns8ASAzj2cdrG4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9utagW2/84LNlfW8mYiQ8tvX8RtO4mmFCAgGeCzzRvXnufIGWij2RgzR4nlJrd9Z1nacPd+1U/PZIkQYLtNSFL+p5J0AlioXvKdM2pFcBKAkKQ1zkWeZYftcZSCTQEnVDPvd9Mkpz/Tzyu0O00m56ggbawFQUs4SeKSeB9boNri8Q1oJ0kkeznuDaRvh0fm/84+B60t8+hwC9rKWv8y5GDbl3Uo+yFpTycYH/o9hbCH1QeXEnCpMwBKUIb/tm0z2Dwb7tzPqCYTkqQymgfgYeq7z+UOIgdQTDRhWLabjAd5f81fpLTThSth+T2ikC+rzTdey/UYqU37B2cZl98szrk+WD783DUUqd7QwWY1Myss71Jg0NsDexpIJXsod+SneSM3O5PmgZeTOuK/jacJwAfUy/D/o/ENIboAwRd5cxJA2p6hFD5mr/AYfHlkr9JlovdFielScA1ZAOexSImuSAvILR/9TLFoZowq8o2l4fJjmRza4yC/VDjG0pPBcjsfSxJ9CibTzighNq0DxAgX/XXeLTyjJWUJ8ZYxsmurgd0RFmV7fOUGaUe/skIEzTqzAI9gdgS7+TIcVuDiU5mYYgXNO6t0DNzkvi1/6DDAvVhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1f7af5-e828-47b6-1ece-08dc6ddfd2ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:18:46.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mNxT7Xmd6Sxr9dr8jlJPXht0Tq+U70tbbAYwCvbXQIw+apb7yVYUXUekWGpLV8YTWRshiEAzDOkC77fByaZwryW0cqLDzpi82T4AV1hzFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060106
X-Proofpoint-GUID: hyRdHSmt-up73YIbDMDLjGjL8-XGE5fj
X-Proofpoint-ORIG-GUID: hyRdHSmt-up73YIbDMDLjGjL8-XGE5fj

Hi everyone,

This patch series is in the context of GCC support.
GCC errors when number of arguments does not fit within the
requirements of BPF.
These patches fixes the functions that contain 6 arguments by
combining those in an array.

Best regards,
Cupertino

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>

Cupertino Miranda (2):
  selftests/bpf: Add CFLAGS per source file and runner
  selftests/bpf: Change functions definitions to support GCC

 tools/testing/selftests/bpf/Makefile             | 16 +++++++++-------
 .../selftests/bpf/progs/test_xdp_noinline.c      | 15 +++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.39.2


