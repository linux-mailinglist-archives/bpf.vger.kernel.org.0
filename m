Return-Path: <bpf+bounces-28766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E08BDC8E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1E41C212F3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302E13BC39;
	Tue,  7 May 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gy9yCSCf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N4Eg+zKd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA23A59
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067759; cv=fail; b=c8duwofGVBgdftdgTFPwS6lGJBx7sqpjYzlqGXkhEzzjTwPM3EXPjnMotDG+yFdlipy6PJKFXzTiRfiowPvIQDYJY0YC/8QtOOndQsGt4gnG2EehB3Pbv8h/r2e1GNgG5AM5ZO4ORttuB7PwRYDFcll9yU/4yMYGWFePRQp8hbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067759; c=relaxed/simple;
	bh=lEeY8l4eO4ULqo47poR+T8q0enw1i2gVtk8bixthuZY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NvLMDxNfNfYD7VHjOuU41SNqMpSYeCtcONaINHK1iMDyT2MKmsebenInHTKnuPt/dlXaHyD7zsna53r3MOFI+o/o0MpTZhZPICYEL8S+Ch5ttajAOb6iVvNAiJx0wdHWbalsRxLSNYva/VCl9Folc3zfz8KXi777vnJwyhiI7TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gy9yCSCf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N4Eg+zKd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4476SrWM030103
	for <bpf@vger.kernel.org>; Tue, 7 May 2024 07:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Zsj/sksqpLZUOt4ru/oUpo4on9wyOrWuFWwpDpFipBE=;
 b=gy9yCSCfw4FiI4ubR/CUEibfu2JhD+cXukS059wtlB3MWBRNh8+JUyNL8L/d074vTZYF
 ZqncKhGEcC6ACO7NS7sdjJ/9X3XT1WWUJC6U3GgdD6OATAOqroJ14BeWAmoRTekG9sNL
 vMmnNlrTYJsovIVzAToWQLRZBqCWco8CluBm+h/bCR0oSTPe8Q+sqBdYRI8fr8PvFpO4
 IKjU85n9JR+qyJ1Jb9vt+kJiZjvzT0rTLz788gkAcuAE2afSwNdiv7ZTCPG5aTPJshxJ
 AppT2n6HtvIvho0cxJymUSjyyg1lpaoyTTU9LvhBepzJYZ/wQMkkM+QqYSHznNqm0cMd 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvc9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 07 May 2024 07:42:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4476T12k039402
	for <bpf@vger.kernel.org>; Tue, 7 May 2024 07:42:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6n19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 07 May 2024 07:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4uTjFyvFHnoSUmXMapMtA3hj7oJqZ9Od87ZBHggG61RDkXkJUQcrQPy04UK+Ri22wBpA3DmUDcgX5EYrvCaGqOvrXcWzNkTUNDuBSJs+lNOz+k0Y6qIqz/mTwQ+BZtsaHBZ+ady9sjviqNo2veqhAptb73E97uYlCvvQqlNeeZHpDKreOPLNmr9tFjCf9l4ulhd+vj1IvaRFYUcie+5agCEEIf/nR5AGs1EdGJi2rzvwHQEUGSmFi2XhLz2dv7dAPJMUW5mluznBNSyAXcM57eXHlPMiLSdl3a0RKyhb719EgaNLtwpg9Uu1XhSIIYWimPh67CTuUV7D7UC3ecILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsj/sksqpLZUOt4ru/oUpo4on9wyOrWuFWwpDpFipBE=;
 b=dBwVQdSTfQ028eKyKdrHUgoxLKYLJ5j7NJKdu/UeUajnCepLwuiQgudsCWQduuQWwi8lnPN3lgrdZLALOrHsQCSQG1aHlspMPZmE4hzAfEnvKyWaa534ez5ohylDOyK8FK1q10+H/lDcdWv4vUvH55e4cLwysBB+ktqiLukV+e/y+/oi/M103KxMLx6uq3qQAtKO1iaitXOgNZ5A9yJN6QO1qZUNqeUZ38C0tJpEhSn2GznsUTFe3Z3FndksN7V1cBX85YoLYCBrqxSXLP4qZReOBdOKiQFW3Ot9mD1taZCzONkOV2E/PN0xTaMNDkoLe0PSG1wjA9nNCzMXHYyF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsj/sksqpLZUOt4ru/oUpo4on9wyOrWuFWwpDpFipBE=;
 b=N4Eg+zKdmxd0mkS2NuGvQB2ifzhVnMJnXEoEW9CZuxY5oM/PkP8oSfavJcAiWDORc091N7qpIAA1D7QXf4ldWbJ2kwaExNYO98K/cI08CnNhVZ+C6limXu3SU30SUkDMqaDeNXHEZ15XG9ZCJisJg7sviGG2JvpXRM5m+fo9m5U=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:42:31 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:42:31 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: [PATCH bpf-next V2 0/2] bpf: avoid `attribute ignored' warnings in GCC
Date: Tue,  7 May 2024 09:42:25 +0200
Message-Id: <20240507074227.4523-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 47137fe5-35cc-4f50-6b9b-08dc6e6940b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?laWqgXlBn1/v18OmQBdEB8vU4CysTZ946/mCFniwGEErjm3NCtu5us9bkkl1?=
 =?us-ascii?Q?UFwhxaDF6glg0xRcaMKB9n3AgJZ95hQHsih8mcIiyjbW+elrGpjFuP7Q92CZ?=
 =?us-ascii?Q?Y0sO/aOIOeJ3TjlGxTiY2EssEWycmODltle25bncvkyUpPuNtGmvhpbUMnm1?=
 =?us-ascii?Q?HMV0w+MNicZGuDbnJ3MG8vaf01pPzrYiQn3emxw4frClpQAR2OPXpHy5vtlb?=
 =?us-ascii?Q?4h8OChLxSpjojvq57YlcW54VAR2vxoybNIs6RFzUswqYlO71FZM+JKl30D1v?=
 =?us-ascii?Q?SCQ6QDv5fJ2W/af1npUozaWrlx8D4BxllEzFd1xHYfRp0KCi8deUvL4FTkwn?=
 =?us-ascii?Q?Dn2TXiD1ZnEePm7L5/gtv5TEVfKzBO8C4CybATy539GHdXACLTQ7vDycmV3R?=
 =?us-ascii?Q?M5QbgR+HPQMUY4KJPg52LNg6IZDQTtH2taxbWYqO3o6D+YuKR+GevdCCz2LX?=
 =?us-ascii?Q?77Y4FCHlJ1jVKgul2z7oYsgYIq/jldOf++MoTE216GtAJqeguFXFBE7aT21e?=
 =?us-ascii?Q?7z+pBnaYaSWTVzEGa5kGUnB5/sZqqEu6fpguw3c5Thl9u3mu2fPZgTVRbvhy?=
 =?us-ascii?Q?84aZFK+I/CYzT716wdQyeVsJ3EmGY5x6MiTBUHTybkdrKT09GkSh/zi/tmjB?=
 =?us-ascii?Q?JyMTNbOcZj3XwLdufroQxUM2lKVkYfYBENbTp9ATmr4Yqpk5yatHiYCvSllM?=
 =?us-ascii?Q?aWihqlM3a1ZlE2kj72Bl0qh0HDMqLgSMsG2FDy02ZaQhCbf9evL5sn66Qc/H?=
 =?us-ascii?Q?yqHX1cM/031aRiY5cCL6WJDwcSRRlYAwafwIVY26k2KStKEwrwVli36W7MqY?=
 =?us-ascii?Q?aCb6DXfOfljZA7yHARO69i9hFX2IRs2y0M+tIOZj5uuQwraEYcv5lz16ukNT?=
 =?us-ascii?Q?8c2sG97421nLJ19IYVZefbEUE3B58SumPojYg+ckZneaGPYXeT2V9jKFv00W?=
 =?us-ascii?Q?Gfxetw9INOGMDOdRffvLwnD2BebwNSoxZDMxgECRLB+n6g05V28hKb71mWVH?=
 =?us-ascii?Q?WLrYosPc5purGuRQIVLuu9Ial9yZs362zb+HBpbE0Ess3cHEPC1Y8qffZzcc?=
 =?us-ascii?Q?GS8mxumWO2IyHHo3WHd6I+Ji0/Z4Vc4gG75R0W/wxgTbhVn7eS7GIpZuWeLu?=
 =?us-ascii?Q?pB5R1SRvyQawdA0shLSewdITD9UIUxHmKOh0q7/5+QgT2FVZJBgCug2lDO3v?=
 =?us-ascii?Q?8rIhGTlwXyC/sxrmyU7vGa/fjN0pDNtyJWAX6Bu/oIN5Xia4uNBqS5JhTO2s?=
 =?us-ascii?Q?25UrTfZ8i5uEBMQ1RS3TdYIKlZYMRSPK4QmX3D6q3g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s7bopefdIh95suA91Tc99m4Oc2SbaVUM2P9my7/p6nxkKy8XOa4GucvNMDkM?=
 =?us-ascii?Q?gVMn2Rrb7VucOgLDCcD6AoDoHkeqnJULB1tmW62Pwm9saJU9kvl0Oj/1GBB5?=
 =?us-ascii?Q?7fo90cRs6p+962waEaFNVt/T1NTRsench11jL3m1Grw3pR4tU0Ivb+6J7ak1?=
 =?us-ascii?Q?wEyDEpt0D+BmYQbeIr0X30D6PXWmZ4J2aViBlX6A7BeP+nnyoSbHLDmto2fs?=
 =?us-ascii?Q?TCNH+OJzKmdljt1qfkaKfSxk77Wa3KG5jU6JaM0s0OxbBfmN6oJE3FtsoxBu?=
 =?us-ascii?Q?r4YmVGjiI4Fpx1tBttxiTZG+LyQBzceb+M/KtH98onXAewa+uo84+94G6zCi?=
 =?us-ascii?Q?3QbbpOD2vdTWfbQW7Qhp2xVF9OnLOeTlVCrpe0zq86dIwwygaavKgEvXpAvY?=
 =?us-ascii?Q?34fOIIJAdiYxkl6rjo57VDAOgCgJ/J9UgoftVPMaIV34R34YSDhcvO9b+FTw?=
 =?us-ascii?Q?hcA0ESeQZQCFRpXcu8DbbeC7JHbSiEQxfTQePSKFF89gFzmlD/Mo5Ayd6ftP?=
 =?us-ascii?Q?M845kF8vy02Q/jdX+9cm9NZesV0u55KNJ0TSTgUdCzhHSz1QDnH4ggzaLIn8?=
 =?us-ascii?Q?osQlSLZbfJNmX5tYierQGqQ0LBO0EtG+0Dk8CwNWk1GpMJHWQarm3maJhJk0?=
 =?us-ascii?Q?+NrUek4JKjqdr9Gue9WWxjnTSxUCP1eK9n5zYNstc99kOq/X4k7SiFa19hwN?=
 =?us-ascii?Q?wWlEW837jw3ZiuPzBU6NZ1KxRx8VkmFpujaJZrS/tn3ijk2LXSDyyBny/DkZ?=
 =?us-ascii?Q?5ZuuGGPsJRf46hCv9kZZySqrW8sTKD6esCJw2pXyHl8RIu0fSXDOFgAU9l3T?=
 =?us-ascii?Q?gI3rCqNqA5v456pYwt9g2z7fFF4zZizdZJjmF/Qf4Cx9OWBzV7POShNLWOAo?=
 =?us-ascii?Q?Z7d4ZzyS1ZNYvws5JvauC6M0+emIHjGnjwLpKW56uKLX5nESyqlmxKXgEmfe?=
 =?us-ascii?Q?OQkF/0UAWLR9BwHa8CL4IpEQzhxWpwg/gU/MO4IOWzkvsFaQGA2PxvsvXm86?=
 =?us-ascii?Q?EiZhteJcPLwJ7MKazQD90vTSaekVy/Sh/dGd6kdMlbF7u1xhd4cGoGdfkp6P?=
 =?us-ascii?Q?IKtd5rW3M4clcTFDmaKtv+vzAB5u886qCNYFX1TNYbxw/onTaaNU9yEcEOnW?=
 =?us-ascii?Q?PFPQVQYMhOds1bG4OMTP/MLNGpUDpTKQpi3ngKrqkVJqR5fGIoVyLn5Aj2lb?=
 =?us-ascii?Q?FXXk1Tc/73IGwSGU9G8p+ne1l2VSeOUQ72OD7qw2Yf7df7cW5mXlJKIvrGJO?=
 =?us-ascii?Q?iWgMHiiOPpnYZg3nE13lPtp8WWVn1OeyMeIerUq+SGUc+YGW3NlgBtNyJGYM?=
 =?us-ascii?Q?H5y1wCe+jGaNcvNtu3wMGmcRzg9kBAMfW6x88hHhu6iuQwitg4SP30uXtHy5?=
 =?us-ascii?Q?qj7I10RE1ndNNRGdo3KAjYFhnojzMv0cUZqcwJ4RKK8FktumS+PUzw8GCrb1?=
 =?us-ascii?Q?7kx5Y8/+rLG6DpujYoCMst4MFinVzA3JuVq8MBps0Klhao5aBNNVC1nAjqyG?=
 =?us-ascii?Q?q43nzVIs97cEO3fAjxXJVRY26OAVIhXeehCFdBCSEqgldl2EvtKREnQqIT5s?=
 =?us-ascii?Q?GgyugCdZfE39ZQ/W6nTpmV3rmdLH5MLxsEpBjmWYCJgxTb6+NawYMOyyT1hB?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D2cXBRltEEMSGIWqSvcLDThcTUZZbxbh5EFn81hCKkEt1TtI0Bep9llewvYCjLuE35hvyEIXmSlprIJTUstt33+mbcvYkDFMoeGMJING+oZB76vOIzETfbw2/2dJXjCpNP7HsAmrf+p8QzyMv4rpFNcbNr3CiYPBBUq33pdTvk0kSoDzj+JdFVsfc5g7Auo6FUCyR6ePm+lNacUpoCsoUXT7GLvhrQvmZfE6YctFdhBjC8iVsxYpr+UfkgE1QszZf+AaGJtcw6OdCxJwIACyyQEevvMMV2PFUfBlPbYuHI1RhoV7jKF4+H4m9VwCmEWVM88hBOmDtrrH3j7287M7iBWx80q6E3Hc1pdYnNZ9/8kGdeAbHyLacKbr6dRNhqtuc6uaz33eItQmHspaKrNAZ3uN6Yuyo3CX2Q6puDqe4GUDE8mIFsAobc9kOds8CBpDmu8Ff01ccPayyM6ORB4v1EX07LAAD4JWJ1uiabmnGQ8ayM+F/z4+JuekV00dz++5b6EeI1X9qMY2D4/HuuGVAYQwGA8EQJRzDogSLUsvRxPJG1Aa+zo/63mTL2DjNDL0lL/dsfHZ4H5iCL89z1fel5TywpSJb0nAX2Xa9sW29vs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47137fe5-35cc-4f50-6b9b-08dc6e6940b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:42:31.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 491hc0mAoJyJ/qHdYCyecr/iBglJUOr924q4xp/3bJMdbVGn6i+E1vcIdv7G44FTL48tofu4lbbmpBG4NyWQzjODmTZu+tQ4B7JalrCXuD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070051
X-Proofpoint-GUID: Si_HO_KCYXU66VNt6tQpcezInV83fiik
X-Proofpoint-ORIG-GUID: Si_HO_KCYXU66VNt6tQpcezInV83fiik

These two patches avoid warnings (turned into errors) when building
the BPF selftests with GCC.

[Changes from V1:
- As requested by reviewer, an additional patch has been added in
  order to remove __hidden from the `private' macro in
  cpumask_common.h.
- Typo bening -> benign fixed in the commit message of the second
  patch.]

Jose E. Marchesi (2):
  bpf: avoid __hidden__ attribute in static object
  bpf: disable some `attribute ignored' warnings in GCC

 tools/testing/selftests/bpf/Makefile               | 2 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.2


