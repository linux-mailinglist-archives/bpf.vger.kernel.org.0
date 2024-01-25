Return-Path: <bpf+bounces-20321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04483C0CF
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 12:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD202893A6
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C012C699;
	Thu, 25 Jan 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0n32OhD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uisxqm9r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69C17735
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182293; cv=fail; b=QtMXo/Qt0L3HFDzsRqdB0AUmr1nkSIvJnrK3xkhMNK1LQUA7dxBxnyBZgves3vxKwtm2iU+fCYcxCXc2Li7u0raWlPjwoO3TVJrM5Mz9De2VXl+pLnu8/h/9NmN2kcdzu9eeM0FoNyK8WUYnB2YaeELNtHqMm0PvkX8xqq1v7ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182293; c=relaxed/simple;
	bh=ZLNfCs5wS9+Ol0HvmyL0Nd+Uodeg/BqU0Yhl3zZvJds=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CCiZEigZxer/RdLpqq7ZuIETg1mneuU7DQf1VAXLz67C1zfwQzSJ7NuVLD8sG5p0aH3mizOpj7gu0xBkarGrAnSGACh2cFr6VEWMTmbAXqKy8QzfHs7qzF7Eo4y22Tmddce9wZ9/6IZhbQOkPHVMqULiS/+SQ+mGBNNqkfhF77o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C0n32OhD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uisxqm9r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9wsQs013566;
	Thu, 25 Jan 2024 11:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=x8HMQND+Tlw+/I0ssz1nUg1z03jKpwWoEUeMPrODb7A=;
 b=C0n32OhDMbAcvdXHXKpmZuDK+M+s+3BwrPuvrps8M9iDmEjXDXUoiYAvenV63Wh+r9dT
 3G+JsryMyR1uflbR6lcrTxz8XmiENhqxD6GBhFwlrAj2AWhMEkJmGPRD/nqgMfrODPYa
 5Jp6id1gNUpnRalkQZLpsa8On8rnVw9Ns+e6Aq5nhsFMBF6OLqOEvxuStrZPohlXPiXG
 P+zopsDkz2UfJFRhRM1iEUmwMGvHz/fJsq/LBVvoA6XWqbh2NQlffqs4hZ9IeIcF2Eje
 nuJ82By+ydT+nORSsy7zT1TtF+qWg0P0S8lWBT/ulrOllrMVvIhbGypPlq941QzlbiLF AA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n86r57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 11:31:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9jVYA014360;
	Thu, 25 Jan 2024 11:31:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs37488qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 11:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEJH4C5mMKjdpMjUkgnJWluEVwIBKcTPS1KKFXkwrRpxxlbE20QLrjDuEJA641R3VrnAEmyF/7DJOfjczZ3nBbzRFp4QUOFnh2wRPeElLeItVzpdvKGwmK73Kyge37UTdoyOymezb8VxZ9gq0hXbAVxhMc4HE19fX6zxpsYaqkhxANLl0QtvXZXPk+M0Ww9UdOLs2q5zycMzXcG/i8covZfWRsEG1UO0UFXiZ5GOFZBy1pGSeHX1WiYoodSS2qcz41VM9YOTP/SLKw3SNFgQSoK2meFZ+deK6qNw3E/b9gB6LESLBvZYMtKgLhmqCz2KoVKFyCAcmwZZVTTnOAgthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8HMQND+Tlw+/I0ssz1nUg1z03jKpwWoEUeMPrODb7A=;
 b=fyIVh+/r3dQuKdxnHTMnCIfu4l9eMvkUWp8ftqaEP1siV5mfwVs9HIuZkouIq1uoLS9XVQojamBCjg4kPx+Oht2QxXMc5NTRH1/n+TFUPXEduJJb1I5nUw/BCb7fHHz3/nJOq2PkZe+fWamOjI9v+wxvbkQhda0+ITGTHVufxGYOp+lzmIiu5U7UadvrwpR8TqfafJxLXUwQHhe0uRQe0ZLkDLI7nXyY2OZQUqdctHDSWfh6PWgJambGapOEqQD4leVQTFf6VXvc1rLLR4oqGzAlXAALYLxkuolaxx1/8l4bDbcXC5RDh7n6a6wRAXFOU569KQO7neKASebLsh6Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8HMQND+Tlw+/I0ssz1nUg1z03jKpwWoEUeMPrODb7A=;
 b=uisxqm9rI1nC692kpJppcgj6Tc4EEKtAS9/+HkTPsHom44dj2qnZSo4D2JI5WLr7CgdV5DfRBY3Q2ixb/bDuCYOW/o1Dbyi0wY61Dsbf6Uuvz36CmDAI/ETOe+A6I0vFO0dfyh+v/m2vMSZLoWcQclIca/u/8tDfVVRRw4GyzUY=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 11:31:17 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:31:17 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@meta.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com,
        Andrii Nakryiko
 <andriin@fb.com>
Subject: Anonymous struct types in parameter lists in BPF selftests
Date: Thu, 25 Jan 2024 12:31:11 +0100
Message-ID: <875xzhzm2o.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f0111d-e004-42ce-762f-08dc1d992525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G+NpiKjKpTbuj8N8fPh2RVEPMhMWUzkmiMZ2tjB1SjK0agw/dpEIUqLT02pOX+ZX2ThIHJinGBlALJtPu1XRPYEZ7KXh+bUoTXt4/ThyiypZVsVSD7exU8QMoH25nvGtJgW4UEFiXiNN0ijgHrK8acf8us4NAFAGR3zeE+zogXFJYO5GtgyvmLs8yK7F/20gaySTS5Hi4WSNsqQaxfD1GK+7OKxjOcO2GoRVTn5i8ayS9TXQXzIU40MnjSSqMhI+QwT5t9w5bkm/0Lzs8uyZUL6Va89tVgM9Is/3OAXHuzEGhmtDJQ2cWqPK7yQrzwf2YaPxy+mGr3RQT0PGSD5byOPZ+MF10J6Boz5J9jzrhwfM6Mb6XLDMyif3Dllokl8nLZo/NOAVVIQeJUT5cE9ik/6b8bXzAE5ubMEz+6mtnYnHlbU974e2p5FA2PlV0wu+BxDpaCfU7EzfXeVOQfNulg+Gl6YzxbNDVfj99DmGUWgRis+nFES//m6mxRWmQ7us8zWodRGIrIKTOmX7I+FKOLZAg9b98pjKZxA8Z7koPjP3kE4aAMh6UcK/F/CWqgbcbufWFPlxiEr1WqaBDFYS1sjl39oVye+hr/1QQZYHwXfJE0FEbet7C4mWQx6cbWV2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(966005)(6486002)(54906003)(66476007)(66556008)(6916009)(316002)(66946007)(36756003)(41300700001)(86362001)(6666004)(6512007)(6506007)(83380400001)(2906002)(5660300002)(38100700002)(26005)(2616005)(478600001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f1/jH5q2JkwogWyVM10Z8dqVGEaXqONzJkGXFFifRuvTozgb8PuPDLnhuKdK?=
 =?us-ascii?Q?C2TlrpvFPQXhG+tGjnOxBp3mD90UJYAe30vBbc52Gw15eVbZaxbXjGl5UxO0?=
 =?us-ascii?Q?vRgtswjsozKwkiZFq4bgyfJRwqmzcZnweuPGwY4ZTAJeOkLvzUc2rgDO74Q3?=
 =?us-ascii?Q?k0Xaa4w6XZJCH4Uve30jk2i4vHXIeLz2RexmC8iDmKo0og2mjWlzXfwnCRDe?=
 =?us-ascii?Q?Ze0kGsCYYfhO4ZyP7ff5UcfJ36vQasQ8xC1n0PrK3EpwrxuM/uc5qSOMFK5M?=
 =?us-ascii?Q?lCFGwWIQVgmfJSj4kYTjQz/bn9PNItm+OjAfyLj6gp2BTKlNioJfcyt8lh+P?=
 =?us-ascii?Q?0jXxIEfVTkYAELx+DIQQ4c6ngPhk3TAlrCySN3onnwNraKbXk4d7ZrOQqErm?=
 =?us-ascii?Q?hJVPG9FIJhQxrtuVL2MB52fXI1UEQGkvbXYWtUqyn6D6Feph23u0BjeMEPsE?=
 =?us-ascii?Q?lCjgSFkJfu0fNXg0911TKhfaRKIF0BozcRPJIiYhD25u+aqULL0g+YP+u5YC?=
 =?us-ascii?Q?PWhzk2MMhDlP7M6twIC396R2n4d8Q/PHZIUYVqmoReCIGK4zOp3RD1wTMU2d?=
 =?us-ascii?Q?OmlUY2Wu1smMtUCTK4EDIQkNN0veFeJUCQoDvZ6V8BDyJoi5XsrNIto1gjMj?=
 =?us-ascii?Q?A15PrM60KQj5UNUDO805w41ZXuMfEDeiwBCWtrfWh16Pw6pwhKkYUSOPulmJ?=
 =?us-ascii?Q?JquES0pctYwahDjOgzERP5ptf8ftzhhUa+2GU5CAl0Ucz2rxUFbAL+Pziip+?=
 =?us-ascii?Q?/NzF5VfdnVXELQK6zQ71qNB+XozblLUblM6Lp8uYdVp2r71JUfQvzf/5mK9p?=
 =?us-ascii?Q?37s2jlbcijCK+DDvDtnA24L67jaIpSKGYZ/KkskMS1lUGnp2tp7Wb7p4l4CV?=
 =?us-ascii?Q?VYAYCDuWzf2fyTWZj+jxqcU2l7lmRLeNLQmXxYTkdz2FoblH7bddpXfjCOGS?=
 =?us-ascii?Q?65FA/QWMRC/VMRZM/zVNUN0o0JCxXKPAr6nog3usrNUElo98PGy4z4T77Bj3?=
 =?us-ascii?Q?Sn8AbqVHUj+Mz0rwAm7rjpfDrDzZt5cUY9KT8hOfWzd6kpp7gHlK0c2vkcke?=
 =?us-ascii?Q?HvNOZa2rNJualrcUQYg6U6/ivfD8eSaR5tdMkeQBmm0cQaYWwFtp4I2Sizez?=
 =?us-ascii?Q?TL07hhvtpq4i6Y/TlgosLKhobt61hV/+RaeFKPp8Npr4CxYzB/FKzwPGUHD9?=
 =?us-ascii?Q?3RHJS3J9dPEJGO42ABRZ7SFz82er6U9GUgsdnhgIOAPADY56P0837IdaNHVx?=
 =?us-ascii?Q?xPmrRHI+RfxjvYSAlRc0z2fxX98JK4X9HOXGcKWnpe360U5L9mIRN1jWW7Iv?=
 =?us-ascii?Q?CN3j8vAv2VXfuyXo4yBvVXBEm/ijnvjrFeCiw7qdZJdRAZL0NXTGtBhedZoz?=
 =?us-ascii?Q?w9BOOGOmAyloCH43rLsCxFno+F2wUBTrbVOy27A5CMRjdBNEgaHT2jQWeSyT?=
 =?us-ascii?Q?crjkk/xlAusoLWp+LzcCzX3LVRjLaJEhQ5WjXWuTSLiRVXjBtNZFE/VMypo/?=
 =?us-ascii?Q?oW0gXXGnutuMdV0m0ARlxOmcmC2KVoNqlDEbDWZKnsphnj4i+uk6WCZJoUXO?=
 =?us-ascii?Q?C3DdTjDapQNkYx7mPOu/4WMcj2gwkk02QS06TZu9gkEgCuB18ziXaImMXcn2?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BcmW33qmsbI2K4SyNKkOTPXz9blcAigPOnJCHczNr1EuDKS0AqXY4t8nr/v6St/EbWOip9jijWF4R1Wje9tlZZv9vwiZNqUaz/Sme6b/1ljJZWUkBpaeNV7g7eC2TwfaPJPGdhV5iFmWkXiqBNkldBQBQF3FqTDhVxkM/g+rTkrMxAsCNmB5ojGF47MGAC6fDAOnWhkMjOdXkpx6O2oR9XTz0pBAYKQdIO5GPLjeWbdRvuNOx5emvKLkljAGN0N0flR8ttQQd/VIC38Tj2Mj9Vq4WjDaQ1sC2PLbSxkFLetpB4KZUuGPhNmFWbPjgfnXdzvXK/yjvZ8Qf4uDpCc/wMi8UvihFoUN9Llv1xg88qTyLM8MEruIJNV9ZgqNQzHJzaxaA6Ugn+D/X+w5va6wmD80YUHddqQe97+nAgW1eMei+RynF9V3qhkmTlk3h7SN7MCj2HNBbqMtyoCv6OM2EwPGzlfQe2Nlp1Bty0dJK76j76wlDRsDOqFUvhUIvbGoH+8Xlr0YEsBUijZYW0MMFZYt+znHgmFHC+L7XrMPDwhAhzz+/AuHc03Ce7mhv0mRzcgb78h5Ohi3f2yjpsdY20a5xoorEUMef4Sfvls1lIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f0111d-e004-42ce-762f-08dc1d992525
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:31:17.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4NQq5DRLpXGgMYe4PJArNhW02V2x0GH7Z+Tj87Q927TTYIapKIQKck7gQ3YihqtnU+V7/aelusawJvojEVcdpWJj36vLMvfjRM/oa+XvGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250079
X-Proofpoint-GUID: yzzE2itq2CUA7-M3IqB0JFh9evVJUmEQ
X-Proofpoint-ORIG-GUID: yzzE2itq2CUA7-M3IqB0JFh9evVJUmEQ


Hello.

In C functions whose declarations/definitions use struct types or enum
types (or pointers to them) in the parameter list, the scope of such
defined types is limited to the parameter list, which makes the
functions basically un-callable with type-correct arguments.

Therefore GCC has always emitted a warning when it finds such function
declarations, be them named:

  int f ( struct root { int i; } *arg)
  {
    return arg->i;
  }

  foo.c:1:9: warning: 'struct root' declared inside parameter list
             will not be visible outside of this definition or declaration
    1 |   int f(struct root { int i; } *_)
      |         ^~~~~~~~~~~

or anonymous:

  int f ( struct { int i; } *arg)
  {
    return arg->i;
  }

  foo.c:1:9: warning: anonymous struct declared inside parameter list
             will not be visible outside of this definition or declaration
    1 |   int f ( struct { int i; } *arg)
      |           ^~~~~~

This warning cannot be disabled.

Clang, on the other side, emits the warning by default when the type is
no anonymous (this warning can be disabled with -Wno-visibility):

  int f ( struct root { int i; } *arg)
  {
    return arg->i;
  }

  foo.c:1:18: warning: declaration of 'struct root' will not be visible
              outside of this function [-Wvisibility]
    int f ( struct root { int i; } *arg)

But it doesn't emit any warning if the type is anonymous, which is
puzzling to some (see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108189).

Now, there are a few BPF selftests that contain function declarations
that get arguments of anonymous struct types defined inline:

  btf_dump_test_case_bitfields.c
  btf_dump_test_case_namespacing.c
  btf_dump_test_case_packing.c
  btf_dump_test_case_padding.c
  btf_dump_test_case_syntax.c

The first four tests can easily be changed to no longer use anonymous
definitions of struct types in the formal arguments, since their purpose
(as far as I can see) is to test quirks related to struct fields and
other unrelated issue.  This makes them buildable with GCC with -Werror.
See diff below.

However, btf_dump_test_case_syntax.c explicitly tests the dumping of a C
function like the above:

 * - `fn_ptr2_t`: function, taking anonymous struct as a first arg and pointer
 *   to a function, that takes int and returns int, as a second arg; returning
 *   a pointer to a const pointer to a char. Equivalent to:
 *	typedef struct { int a; } s_t;
 *	typedef int (*fn_t)(int);
 *	typedef char * const * (*fn_ptr2_t)(s_t, fn_t);

the function being:

  typedef char * const * (*fn_ptr2_t)(struct {
  	int a;
  }, int (*)(int));

which is not really equivalent to the above because one is an anonymous
struct type, the other is named, and also the scope issue described
above.

That makes me wonder, since this is testing the C generation from BTF,
what motivated this particular test?  Is there some particular code in
the kernel (or anywhere else) that uses anonymous struct types defined
in parameter lists?  If so, how are these functions used?

I understand the code above is legal C code, even if questionable in
practice, so perhaps the right thing to do is to build these selftests
with -Wno-error, because the warnings are actually expected?

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
index e01690618e1e..7ee9f6fcb8d9 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
@@ -82,11 +82,12 @@ struct bitfield_flushed {
 	long b: 16;
 };
 
-int f(struct {
+struct root {
 	struct bitfields_only_mixed_types _1;
 	struct bitfield_mixed_with_others _2;
 	struct bitfield_flushed _3;
-} *_)
+};
+int f(struct root *_)
 {
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
index 92a4ad428710..0472183ed56d 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_namespacing.c
@@ -51,7 +51,7 @@ typedef int Z;
 
 /*------ END-EXPECTED-OUTPUT ------ */
 
-int f(struct {
+struct root {
 	struct S _1;
 	S _2;
 	union U _3;
@@ -67,7 +67,8 @@ int f(struct {
 	X xx;
 	Y yy;
 	Z zz;
-} *_)
+};
+int f(struct root *_)
 {
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
index 7998f27df7dd..8a83f049029f 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
@@ -134,7 +134,7 @@ struct outer_packed_struct {
 
 /* ------ END-EXPECTED-OUTPUT ------ */
 
-int f(struct {
+struct root {
 	struct packed_trailing_space _1;
 	struct non_packed_trailing_space _2;
 	struct packed_fields _3;
@@ -147,7 +147,8 @@ int f(struct {
 	struct usb_host_endpoint _10;
 	struct outer_nonpacked_struct _11;
 	struct outer_packed_struct _12;
-} *_)
+};
+int f(struct root *_)
 {
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index 79276fbe454a..2e03d1455c12 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -222,7 +222,7 @@ struct outer_mixed_but_unpacked {
 
 /* ------ END-EXPECTED-OUTPUT ------ */
 
-int f(struct {
+struct root {
 	struct padded_implicitly _1;
 	struct padded_explicitly _2;
 	struct padded_a_lot _3;
@@ -243,7 +243,8 @@ int f(struct {
 	struct ib_wc _201;
 	struct acpi_object_method _202;
 	struct outer_mixed_but_unpacked _203;
-} *_)
+};
+int f(struct root *_)
 {
 	return 0;
 }

