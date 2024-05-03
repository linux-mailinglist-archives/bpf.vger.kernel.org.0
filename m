Return-Path: <bpf+bounces-28507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C008BAC8C
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 14:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D454E1F22E36
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0B1DFEB;
	Fri,  3 May 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOfRIH7A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+ige7p9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175B1AACA
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739563; cv=fail; b=qBK/Z+e5T7GYNLhQVbWKAEgHhWwCmBBEDx26KiQ6Yc9SbZNsFxOVLNr5ZmdpGj05mUnvVk4abAAWCsONeHYXs8S+13PW8BXbge6SdTK8CgUnvnOl9Lv5hiYEhcgShzh7ESXLP63XqHBDea1jEWGKD2TDQjZ9AZYeQNaS+KEViDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739563; c=relaxed/simple;
	bh=jAMHiccU5X5r0s9doSMvI1VlxTlbvLZaimETRoJIjEI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nIL3cjIZMw6U2HiXDGyRd0N2LhwdcLw/mzd4r3jyqbR1O+24wZVkmL+htwQ6lEJtVKqxOvtFQWYfTQ1q+K35gvD0OazDdDjmMSpTR9pTn95dqaMSz2hO4BEWzUS8AOswzJtFOvMnhToe20yqlj1Fb4bJvH4m0FU/UV703KYb4ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOfRIH7A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+ige7p9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C2Tcr018611;
	Fri, 3 May 2024 12:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=L5fLOC5lWKJo0waoP+9gzQJyaHyEqKtfmU5iATJeocM=;
 b=cOfRIH7A8uMGmm6WhP4Z83Mqrs0/PbQNAWxu7xHmCl02lF5+Ch6NBT1lhwieYolxGrOC
 hDRxssZWAFSOkO3gbDknmpok0GiC0+Aqua4guLCAksdKpLjqdWgUSoecuIK2wBUBTpRC
 tbXTMz2W8H7C0osBX/+hujaholggTGISi2emvJCrLwGpDM8lvOBhn1pDRLuzTOXaYTIP
 IZUnde2UrCXpXrI7sqIgQ7Ut2zCaC2ffaloOj1GzCaFvjWff2L+pmCxKZqqZkRi/uhJa
 65IUTW6rNj0+cCykapeQRHj9DOq+TFQlHT+jAOamCc1EH8xLkO5nh4+q/dk3bGuqsl+f wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsww05jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 12:32:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443BgRRU039977;
	Fri, 3 May 2024 12:32:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcfjj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 12:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWl5a894tkiF9zFoTHP1RWwOrvvrQ1NGBxuHM9vE9pYbvf/hzHm7rOXrkfwyX5Qpit7fa1Kvk4xxAa+nPDIj2aADK6JODjtS/nT9f/OjAYtG3US+3AaAk/o6UdPHSaylo70yp9zp0yh1kNmGf6hX7I2rQI13BpQ6h0OEZdJ/CofU6aGsYL9ccH56m+y+GT9V0Qoq7vqwtw5tlVadwCKkE5jYvbyjx+PoL0nm9X6kLFG6xgGNL1DqB/9k2EGhaAyemtIiqhs2G5UkOKriXuipecVTqWYvlLmD1tGaZJJ3896aV5Ywhw/gK7Mxr4vCFfHzutAHoOWz6Kfj2f15BvsUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5fLOC5lWKJo0waoP+9gzQJyaHyEqKtfmU5iATJeocM=;
 b=X5BnxjGjrWUUOQdtz+5iJd1Xx9Py8R5eCMJaPs6uKFe71ImxPCUjN+sDDrLx7/K6npGnHXrHvj+QjQzstyhliu0tEEFarv0UrxT73gvPT+LJZdsdkAazT3acspjz25Iv8ZaT+0ZHUC4XXydZHdTUYlpr7Ja3NhxxUymYKXcQuGYnjyAWTyizBpZ3NkkH41C+GQLGgdr2Hb/zlFXx7MpK4wqj7EHteBvcGL39Jq0tAfAXaQ1cNBJhRT0HElSNSSb5w5Cs1OcoDhWMXnL1nTC31ITAZxOAF7SqWoHfYLYpmWXVdFOF10kghynC/qNrJvpYezLdLrafeKF9Ttwk/cJkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5fLOC5lWKJo0waoP+9gzQJyaHyEqKtfmU5iATJeocM=;
 b=x+ige7p9zKjkPIzH1O/aqp8RnIhPbV7tkQFW3QgLaiJBdQntPduG1IL7fiu+Qo4UB3s6UaY3BFUFu+E3ATBB7EZSsZ/r6BUATPLbJxX83lmbDy7EuUkB2yuCGRD2uWdtczOXV6Sz+C9lN5Z61leVicCiAbsDb/bK4WZdpk8ZptM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 12:32:28 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 12:32:28 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: disable some `attribute ignored' warnings in GCC
Date: Fri,  3 May 2024 14:32:13 +0200
Message-Id: <20240503123213.5380-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY8PR10MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: af9a629a-677b-4d2e-75e1-08dc6b6d1811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t7VAbOg48IXmtMiIYFK+tRm6oTNxhp+uBTSdB/ycCJhC7+UAhyYaoUeeANkc?=
 =?us-ascii?Q?ZxJoROv9vC3N0aF8Ec/2TK+BCPKdH1ApJaQ0cKdmAmRjK0+oIbj0rnNguKUR?=
 =?us-ascii?Q?G3H45nRIKCcs2R7FPK16giW8uN6uHLlmVElBbZUr6xY2lugeBNaHE9mqoNPP?=
 =?us-ascii?Q?HrUihJaqQPU4grbwEqa8UupKrOtKya5Wd72pWIGA9+y4tcdxwooD9vh4jcD0?=
 =?us-ascii?Q?7CFHBfjiT2R8ZtPzyOAZZb8HWVsk99YGLxNOgtDCQxra1+TaCP9Ig5KaAtSd?=
 =?us-ascii?Q?yX1hjfO2UIotRSiO1d441Xjpy4DiYO8jXLa6xpxn8bZTDBXkouNSqZVy3Opd?=
 =?us-ascii?Q?xQ5yS8haAsS+nE+weq3wYkrwEHn2LZQI5u0ln8e559zMoydj6C9TS2b+1hlo?=
 =?us-ascii?Q?rtzZTL82buVGp7I1SFWKf/Xr89GjEf9BGk3KcDRXd7jGgIevsCVW8pIBGqzW?=
 =?us-ascii?Q?XmhMfQKeAm02BRE8jprkn/df9AbchedHJEUMsRtVRG+5ud8L39nnCWB8LYAt?=
 =?us-ascii?Q?J3rbQPhDy1E7MOekm00CQfmeLRn4XERtXbunZ6NzRmhAcnfSNgVUwJFdrQXG?=
 =?us-ascii?Q?Fz8JZ1Y1hK7WdZU3Xc2WF40Qi33jb6/C34QpOchR2oDFmGVCpVFVbmvgKT3V?=
 =?us-ascii?Q?A3niXKJNixlEx0g0qMpZIvTuaa8XnVPEN5Z3SZdxQLtyS0WwpirBZXzUXu9B?=
 =?us-ascii?Q?TuhxorLcn0UV6F6BYDMqVZbwKFqVB1eV9einDvJRDqXWtrftNQr3Iozk957P?=
 =?us-ascii?Q?qiztk9077LPKYAD/BPRDZdGXBvb5BeC7LC/B56JfKdoLRA5LeH1r7IqW+1pV?=
 =?us-ascii?Q?30If5r6/OaxH0KbTMxBv7dgKcOUPsRd6T8Fabln5SDMCA2Ujvd2s4OxJwiMK?=
 =?us-ascii?Q?o46w4dN3kDif45iFa/tn9JF0//Ivg8FILPh8fxb6mEdIACCQ0fnfywI9R7Vi?=
 =?us-ascii?Q?Hj79ipbAK96HvoYRfbLzyEuvlfI653wZFSxkKfLOxMYqjvwOeEDBifIps5GZ?=
 =?us-ascii?Q?2dnWXbjjf/6ybfsZ0OJcIa3MFYrQGIo5JX5KZ4uu0kBn50RRi0D1Ky/+iyM9?=
 =?us-ascii?Q?JxnKGNkJeuEA9eLlKleXjniTwtaN98MKbR5mgIHpoork41uz/DrloD+SlGTR?=
 =?us-ascii?Q?R201urxofzASVw9I/ae/o0wo/9i/kYMx7I24TQ/rlXOdKB8dcTJnwBobGanD?=
 =?us-ascii?Q?WfETXfRnEoOARuzTRBAFbXuRMvoEypSktXv3nx9sEHn0P8dNS9wdRMYP4qc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?96JPjhYbNYc3RocvsgIitFxVtPjLuhz+TQyNm2EdqKoi0xSO6VmxLbK6COfZ?=
 =?us-ascii?Q?/E5C9o5Ep4/hyTlz6GOG0cW6AiatoQ9F9bVMwlAniYUfIEH0BJSGn5eaC8s8?=
 =?us-ascii?Q?ZsrknEdFlhH9o6Rd80L9EjL+xdjlJJJBqTwJ18C8APoSg31Yjaonxcw1JQyx?=
 =?us-ascii?Q?XxGh/Whj3k++63JGimQ0teU/AOesGVwAuoR+Pd9e+x1Bi0FglDRVMzp0Rua+?=
 =?us-ascii?Q?EJVNnMQw2SCxRjLUGTkRxgVdKI9nfBuEtsUVcNAZsWXKlRVD5ZR+tP08Ac4N?=
 =?us-ascii?Q?6WvSupK7AE/vHYjqlULR9iR0Yq1ZEiQQ6PPBxLgKIqr3CtF1mafuwFc4KLFR?=
 =?us-ascii?Q?Wv4tKK3r+eV+GzlBk30G1FubGQLLbKxqmbmzob3KQ9VZkKglSaucU8y4s14Z?=
 =?us-ascii?Q?Ak+vxjurTdVe05Hi8PH1ObZURjxtEEsLPiahvPJ26KvJGrHMf93IZzLXH8Op?=
 =?us-ascii?Q?KgS0y2To2JwF2fCEG7LvGBZ/PqAU/i36OJ3nt0Y1gSK4xJhPr792JqCtNjSG?=
 =?us-ascii?Q?3xqkfBv6FHRx3FY/GMk1+ejsFrT/+VyOmPYCP7aBvYRwAgS54jKRDVdx8SJn?=
 =?us-ascii?Q?07ib5sNVugj6JL3IsziKiVAkI5jt0F9S61aA3KwxMpUkLJc/XenaFt1r84C6?=
 =?us-ascii?Q?tePQ0aADUEAJMkqHaq3o6BvBJo85y97r0qCkSF5dXm+M02rkElvvFtUJ/fdo?=
 =?us-ascii?Q?fUnmbK98Bvethe83x70Zj2Wb/fmCGkFXaArfuTGEaXWejJmcy4xdq0dvqriI?=
 =?us-ascii?Q?gOIHPNlVOMFhU4Bk88BWAsQtrMLieqlwTQSTnFW4jMBmKw512k2YNs24c/Pm?=
 =?us-ascii?Q?4nhwuxgp0WAlQzSOY1EF6fnSbaLocYoclkD4JeIVCI1KH0wNNGHccdbYxyc+?=
 =?us-ascii?Q?CiGz5vhPm0bRqYq5nq2HeSXP4bWd93KB+iPscx+y6dpMeNqAP/IwltdBz0/3?=
 =?us-ascii?Q?uHjGYn5/qRxZMGITwf4m0sbq0Kshl7I/7ULIr0LNl3T9q+w/KZKgzp4eQTSp?=
 =?us-ascii?Q?aiMUiTx1i2hHfV1aya6tD4u3iuM/zaz+pwVbhMJoWh78WPrWNYKgxrGyeLWb?=
 =?us-ascii?Q?rImeZ2V0fJNAZapZ+hGHn29dtOiGpexzBALZycrthKXY7BWgRPWAlRVmqjjT?=
 =?us-ascii?Q?h6sdzah8TrOLJyf3Sthx4ud6cmEGJsmvtWjCEHAVVJnuyuXHiJZ5+8o3+c84?=
 =?us-ascii?Q?V1AMRiisJX/00iZIMxsPYPVuXqvBmjA+Xm1XGZiqyxMuf4Y7uY1RAUJy/G91?=
 =?us-ascii?Q?kr431SBtwNc17SN5Yz78GbPVp6AAEJfb6WUL9blsugJJHhUIbbVCGVHLI85x?=
 =?us-ascii?Q?xh37OaHWVaPExuESTfTC/dFsRul3zolgmB/jm/3/moIaKgPttPuVFfPCg0mG?=
 =?us-ascii?Q?Lvt0BxCZ/ClW+NmdprVm+9wz/jCoTIeGWcpaxoWfLrnfuEeLA2egKYaQFIgs?=
 =?us-ascii?Q?fl4APEBgrZy0siROLh2QWUfXdm48CybJuebEH0aKzHwyakuTKRr4hA/vlVS5?=
 =?us-ascii?Q?1YwxQI7K8zEb7sICSZiZBzvROfq73Pruvw9z3fxw0nKO2YMMIDSp5wJUqJ7g?=
 =?us-ascii?Q?kfVr2qXYuUt+AckT1Ec4+yBE/eZkUvgLXDrMj9+ruqOE4dC36h4YVC/yKgwV?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A3Fa6HqOG0BikkmYCFL4EsFsvLgU0ljoL9KZMXP71W1fV1Xjyw53LKJoBwDj8Upo+F/0EScVGPGGX5rV5d90cY1s6pekTX0du3k+tCCguWZJILmcHwR6Gk+28e1mSLEycbvt+/w62HVeZlVRSzJmHOS3qXum5fkuuFVPqhdi+nAsYh8ig9NSQOUdtkfRTn7MQ9HesLxVW8G5FFylR1l1AKPRqT2mj9/udMNRIERj1Uqro9xXNLCkcq/e7gAS15DEKoizS5oKStGN54Jz+yfZd7mxbbAEHvnmXE+W9bHmzbJh6RiaarXqPepEWwiENxNr2x1aNE10VqcW8S5gmEtRXfCgUjLfPOsakwV3PoSjESoN5gbYxpeWKLzIZLwwGZqt3ml+DCoQ/ebbKyXW2gSunm1BB8azeOAkY6HI3tYuE6fNx54a5/XPk3C6ta7KJyFcwuJ2BW9tPSmJ8MPJWMeBhB6RxjzooSx9x6O+doTd7HPJG+PKdbYWr2Yus8+pn5Z2rjeEKL/agZu3ojMMHrXw1no9MnBedmzhhSYn9HEnu5+ZMIhPqxBiSa5B5JpFsBLzvK2GKDhy1/zEx0ySdFvxYfqMv/MI4m7IJksSXcSuXXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a629a-677b-4d2e-75e1-08dc6b6d1811
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:32:28.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+/LjcFvhI/nrlhPv2g6nqOGIq3OpwCX4e6H8vwKKbUboukwNgWCfmoxaZSrJmHTEgFTqlWXL77g2BNy/VUoMA0W7Y6ch+qAQ3D2N0y/BbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_08,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030090
X-Proofpoint-GUID: dNpdxP7vvET4CesBJ_-j0gCagnfBuc_9
X-Proofpoint-ORIG-GUID: dNpdxP7vvET4CesBJ_-j0gCagnfBuc_9

This patch modifies selftests/bpf/Makefile to pass -Wno-attributes to
GCC.  This is because of the following attributes which are ignored:

- btf_decl_tag
- btf_type_tag

  There are many of these.  At the moment none of these are
  recognized/handled by gcc-bpf.

  We are aware that btf_decl_tag is necessary for some of the
  selftest harness to communicate test failure/success.  Support for
  it is in progress in GCC upstream:

  https://gcc.gnu.org/pipermail/gcc-patches/2024-May/650482.html

  However, the GCC master branch is not yet open, so the series
  above (currently under review upstream) wont be able to make it
  there until 14.1 gets released, probably mid next week.

  As for btf_type_tag, more extensive work will be needed in GCC
  upstream to support it in both BTF and DWARF.  We have a WIP big
  patch for that, but that is not needed to compile/build the
  selftests.

- used

  There are SEC macros defined in the selftests as:

  #define SEC(N) __attribute__((section(N),used))

  The SEC macro is used for both functions and global variables.
  According to the GCC documentation `used' attribute is really only
  meaningful for functions, and it warns when the attribute is used
  for other global objects, like for example ctl_array in
  test_xdp_noinline.c.

  Ignoring this is bening.

- visibility

  In progs/cpumask_common.h:13 there is:

    #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
    private(MASK) static struct bpf_cpumask __kptr * global_mask;

  The __hidden macro defines to:

  tools/lib/bpf/bpf_helpers.h:#define __hidden __attribute__((visibility("hidden")))

  GCC emits an "attribute ignored" warning because static implies
  hidden visibility.

  Ignoring this warning is benign.  An alternative would be to make
  global_mask as non-static.

- align_value

  In progs/test_cls_redirect.c:127 there is:

  typedef uint8_t *net_ptr __attribute__((align_value(8)));

  GCC warns that it is ignoring this attribute, because it is not
  implemented by GCC.

  I think ignoring this attribute in GCC is bening, because according
  to the clang documentation [1] its purpose seems to be merely
  declarative and doesn't seem to translate into extra checks at
  run-time, only to pehaps better optimized code ("runtime behavior is
  undefined if the pointed memory object is not aligned to the
  specified alignment").

  [1] https://clang.llvm.org/docs/AttributeReference.html#align-value

Tested in bpf-next master.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ba28d42b74db..5d9c906bc3cb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -431,7 +431,7 @@ endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -Wno-attributes -O2 -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
-- 
2.30.2


