Return-Path: <bpf+bounces-27211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17B8AAB9F
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FA71F217AD
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8257BAF3;
	Fri, 19 Apr 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ct3jSWHX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vhN2GwW+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BB73518
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519709; cv=fail; b=bnTXYYhZF1DUeEXrxBDeM73LdtcnlwphPY2z3icewS6zEGBcik2WhKgUAmzCVAM5ZjfFPP3zk5nNqLIkRh5M5uoc1hHw7HCircbOLiChYNNqWMfEnJ2K0e74EGEYX2JMy06+B9YCkX2+IcZTYNRASH10/NRwORvS0gpjSHJ7roo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519709; c=relaxed/simple;
	bh=iQ9aQLrEu/XYY+x2aKhCymit6Li9cM7M8G6vsfBul18=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=s58rbtp5Yrg5n4pZnmFWWevCM/RW1yUzVgNFX+u8Q7wut+2E2wXKN9Q58vHieKvT1xsQyZNWa+23NyEsusJMfRtx0OEUIbF1LmJjJbg8YbMvoMrfN0cotS63mwWMBmTe7uVg4yBaxCNQHFPtZIzGWjPY9cOR3RhY4ab1e1zXFyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ct3jSWHX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vhN2GwW+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8wkRG027133;
	Fri, 19 Apr 2024 09:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=AtEHsX99HVwHmLp4dfovIcYg93Qr3wKK7LP501yCvrM=;
 b=ct3jSWHXGXI4zRMO82T3CPLuIOvq2ab94NqAqU/Ak1OnfXU9y2jFUZ6Jkht+eRh0Y7lJ
 l0w9tVWTpxO0zvvI8gQHuDMd6UG/8NI6RRzKLWpdHY42gDt0ZAST9nTKyLjANWGi+vBe
 IMobHVH2lbad+ulWKWBNEIAP7gbg7TngyE5desQGfjwMaUUQxZsBlLE8/wkTHYVpB6CW
 eyqL4dzZVufnEwVWqgQ44hzF3Cg3DY3rBRsJFdMOxeRBNYoVSegKAClma/UzNEfU3OsI
 OxBnPzFELPHxVtFURUrXLHmD0QcYEefcxbIMqyfkHhi14AtB9qB+n/ZkfXTaDkzq2jJn Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3ecnf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:41:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8RLFj016741;
	Fri, 19 Apr 2024 09:41:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbjbuvjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um5XUaBpiRW4I3D5VKBapn2kqPvNNieEAoh3o/ulbTz3LGgcLkMAZBpGHgSvaqbUaZVIRmRptJ8u5iyDSJCol5NxSnIIQhWNYDbr8+gtDFiRQglg4L8Jd+fHwiNMVdlrUgDIbcuPghYOyHV0PGj+I0+K3kx1AMVbBaNCgJB74YN47vOnEI5rGKBep+szyu0djFniz63bKE5XA7qtVe4X6cTraAuscfNZFoLUjQXT4VpzU4Tjwtrh7GwosM0yTrERSGE5QWrjvaMQC8xiW+K4nhC6eMuU8FR5sod7G/4cm+M/HyvnsN6Tt8EENUbTUYGN7sdBaZuE6nadA/mXEwJykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtEHsX99HVwHmLp4dfovIcYg93Qr3wKK7LP501yCvrM=;
 b=dLvShDAyXvPtZj4yZX187mkjC+vhW9CNtXd2OKe1w9shoUqTrawbqm5RBsfYcEzzv2nxP7MA7AyYVOBnWVnQOSSVKveTZmqrV2ysDNn8ELSUa7IgjAf0gCE441d6FziQ+oHBzQKuBTV0yVn0+s/BkT+drDMpo0FDcLmQM0aItgYXPw+/Zrz2IaB/U4zQwKRwdz58UmNuA8pWukor/ZQfXTqV4SXgS7NHvNEG5ty7/tK31gzoBKfdMdTgy6z8zoZGaqFPh8sU8WwckLhevZLKEYM9wBj/UkCKw8MV+u9AUjY7pYKbRXA/VXb2y0RaOhTk8ooTXPBEW4c1aDpq3uyGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtEHsX99HVwHmLp4dfovIcYg93Qr3wKK7LP501yCvrM=;
 b=vhN2GwW+FNnilbeMKGbIScwmu6iA0k7szIeqeJIlXDOZ/DJM49NJyiLiFtCxtW0RwudBvIucBTBVkw103NMtF3N2hoiGOXWkjYkmyVfIAwfJx7K4A/sQxr0n3XVfetvJ0IvzTjAn1RNSQgnfCg3y6dnhJrFmj2PCyqx2yycjcTc=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 09:41:42 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 09:41:42 +0000
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-4-cupertino.miranda@oracle.com>
 <8a4deb9d5bbdce4699d8891f205b5894a2cbe59b.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        "Elena
 Zannoni" <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: XOR and OR range
 computation tests.
In-reply-to: <8a4deb9d5bbdce4699d8891f205b5894a2cbe59b.camel@gmail.com>
Date: Fri, 19 Apr 2024 10:41:37 +0100
Message-ID: <875xwdk7u6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0321.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bbd31d-2088-46bd-747f-08dc6054eb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZZot37JViktCNPLLFMgQJXx9MsKUU/HnO56tW7wE2bDtEM2ncz1slZYNVUvt33DJqtsSQiZHrnBhZrFzvWCsejH+3PzDZLfKBuii89fyzf0fIegl8aQbFTt3WyjCfW46ON+4TrXGHUO73KrXrKw8nGVtSttMnVUmZnYemmcTkQr3O2YAdLQllzYRzrQ1npvSOef1NegLdIFP7Sfidp/5wHFUZRlwQRy50PyN5druTEpO0/ZYJVkbncifIvMQqGump1fcEzkYWd4GyrcCwQZEtOOr6CAKx71svPkqjITFus0lSJH4qKV+vMBFkKqOhd6me+t7TJiWHOV+lMEnTmnyH2AVT+z2xQc7IhQeIJelLH9OpNGRDHE59MrAD+EHOW7/hcWcgFCjBOcBIgeApBCJwmafybhFkZyVHGihPC+J2VPqq0bibbfAm034i4KBHgfLWwR5iIA6iqDo6eSoxXP+vRMz0F2tsC17MExX5wg1GAM/mZdMGwg5knZ1zZVNG6A2BzRG8TFmK3jZ1keV1ohtcjfk8Jo26IU5EStkjyuPdG9rFbZDZOFPn27rghQ2TOzDj0Ah14jO/RWzY62G7qctl0eSdYX9cnAfhSH+xZOUwHHYTMSfOk5QwohJkiHXXYNFuBEwBfGx001BJBhdZrtpuo4dPMrYYiG6WnNuXzYdJt0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2Uq0y487/IT+YcQMbLdUCfMk0yA4Q6mLGadtbPrDUNaXWBaIgc9y7bJjMr51?=
 =?us-ascii?Q?Dwm+t1trP9ySg8DHwiDDXuzYoimjsMRtvjUOAfhBFODIAW3Cx3RdHbW3Z/kF?=
 =?us-ascii?Q?j1LiQcn1qMd7V7Q5DbfcRZah335QlO+DMgrqsiGMSNVWxzY4AWOMoiCaN5Gi?=
 =?us-ascii?Q?Xg4i0NzjnEsk+gf0DT8UMWrf0VupoF2YRQwifDZhB2sdqjj3hC2u2G8MpZZr?=
 =?us-ascii?Q?pAGEgCiq/nFWPJVOOAQYPsZyU7mv67EkVIlxZQb1OJCc4M287nzR1Mo6iaRo?=
 =?us-ascii?Q?JevQ0IFl0RSMSlmZ3pir/RDWI2KIFoWzlaKhZJWikBENeU0gIU0QvnfwmZkZ?=
 =?us-ascii?Q?hOwkrc7Qc6k8BPuBeWNuHl3LjSn1V3h0WTEn0XzJlEL2cUVxOg6YgAZpmZE1?=
 =?us-ascii?Q?JBi8+rZkb8SvmS7QzVbI1HCQ7aTkwGK4O8KM5xWaWly/a6zdzZV6IdsbeKMr?=
 =?us-ascii?Q?2aRoHYgvgRd7E6uwh+1nsyB3I+TlqfI6gtyK4DqfZXfkK6l2LaPZuQ+dx4Hs?=
 =?us-ascii?Q?5A5mGYylyf9sWSuX9SFCZTbcX9LMIrP2f098MjoFCNgJlBGkiRaARjDWn4nL?=
 =?us-ascii?Q?etbhijx8B2/4jzs92am1v6ogRsnz9oDASoB6a0rG/iwEH6Jg3GYWeYEM52l8?=
 =?us-ascii?Q?xdKSO2PEjT559HiwJTIp7dcaS9e9axD6wf9QYB90nQj62BQrmH/nBh2pW/i5?=
 =?us-ascii?Q?hGGYNN4wRz/8XHjW82vLmB4Txdw+0nPRuItPqKPC9el7hjvLD97bl8ckYERT?=
 =?us-ascii?Q?u9SoPOj9fFDDuCNiGSlggHqfxQQF/dTlM/Va43mp4lZ8T0BmMQzbo4kJadKG?=
 =?us-ascii?Q?ehRk7iibAO4r8sKcibRDNQ8jGwflrE3EuXMXn75JHegM7Onsqlkbt3RpsdyW?=
 =?us-ascii?Q?pVISOWyKgbhhSIJ9Fsed4YHHvo7N4QUEpdfecPpfp3tQY0KYAKlWlNCWMzQs?=
 =?us-ascii?Q?H1p9q/WygbCTEvNb0oidPz2I0bR3uFTmPnIgLxU2ohL3lNKKdVyhamzzx85A?=
 =?us-ascii?Q?e4UHvD93ZLBVEtzqK82/Tw372gl9BeZ9WBQFv5wXlnRIHrKDPnPsOvQf+2tF?=
 =?us-ascii?Q?6vFbcp5rNQVWMgdw12eH8B3qmNaXiLVoNUzkeBk28fRRc4NaN9Pg5zVdL/+D?=
 =?us-ascii?Q?xPQK6OD2dNtDKUTIGil9k/zbnxoRfJJVbQ9vo70+iiY0Ua8fOb7gHVNt4O0S?=
 =?us-ascii?Q?oXFAitar4Wb1sn4vuUB5NV4+3nVVM/hGjo3s52OOpjkdCR8x+S7KDIHoaCES?=
 =?us-ascii?Q?WOMXysMES3pgZoPW+QAqAPZbVDIkSLiFLnZ9mFmfYzrl+q0SPd3Gb/5ibJqB?=
 =?us-ascii?Q?ybkH9moXUuEfYalf1blfU3+a/Ad40rWZZDR5GljkqVoxz0P4yHL+z3W+vzZc?=
 =?us-ascii?Q?g8eZN3+5nL6mZHq6oPY31bgk9npRVyE2rDFE8ah6Zi1d+K6EI2N2XMSnDv+D?=
 =?us-ascii?Q?VAiMX8T/ehmI3UPir35tctQR7hsF/n3ymTgTsbhQYBd7Sf28D11BeJHHfU5h?=
 =?us-ascii?Q?QBkdASPF3MNX6GrID4fZweo5hRHbCz6u7hW/ZAFGeTHLm069iHUN1l1E9YyE?=
 =?us-ascii?Q?r9gTRTZaWsvBrq+CFb8ataVhKR/uhJ/rRuadl0bzbVcnPmk0NaDWjE7Mo+a2?=
 =?us-ascii?Q?OMkucgqq0dp2Xul2VfFmnY0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zARYgg4ulwHRCPaeFeM43OWM7Ef5Ay6+HC8IWZUOdLQieFuZddug+LJf18I31+POjRNPFlwIVRfVGrvItTDNwpdxYOtESkDKbB2rUneEH6oTZalcdCJD5kp3hu+Q3cv01/znqS67OBWS6oijrchm14gcAhRa2GRLBnD4dLbfTe6ArIhksB1CvPLlxqOkP2KK6LGacRtM1V0UXN2o4uW5KIcs+dRTTOozAyffUXGVUXsmyuabPKyOSu+iq1qfwVlic3kJVwHs7za0FWXs1zHpShrElRVzj8B6qoDwEmAGTRTR+ZXFXOUc3CNesDgGVkum7p71Vv12piaywrVbzDnr5/JABIFDKP0b05LvFiINYN9k/AuGMSks5PjWzEDugPA7DpK4UZ7QK5Ehr/Agd8L2GOasF8xBhSd3iiwpNymKcZBfo3UJrbMdg5lce48ktFy5Ifh5EkwwssObzJRZvnXRXNhAmybsYY+wNNMdwdIbxJgK/Z84Qjjfm+v080zi1mGCAKJlZNgndpkuazRX/KLph+7ibepQX148x8YWDOx5N87gf01PAEmoFIJlgx7V8WPVmtTVmGF2vVr33M+QwLhFDbdH7Et+DqUreL40azxR2TI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bbd31d-2088-46bd-747f-08dc6054eb25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:41:42.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZBhlAaivIxQyft8Jh+dK/+9WufggViu7DPs4iAkwHtwSGZSB5h6xls46xahBmXSgYsPquEP2a4+BnDEl3NJ07/sZydS7KcHGGauxG73bpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190071
X-Proofpoint-GUID: HmeAw5wJWE2G02wPFk-Vi_b1mqYaUMh6
X-Proofpoint-ORIG-GUID: HmeAw5wJWE2G02wPFk-Vi_b1mqYaUMh6


Eduard Zingerman writes:

> On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
>
> [...]
>
>> +SEC("socket")
>> +__description("bounds check for reg32 <= 1, 0 xor (0,1)")
>> +__success __failure_unpriv
>> +__msg_unpriv("R0 min value is outside of the allowed memory range")
>> +__retval(0)
>> +__naked void t_0_xor_01(void)
>> +{
>> +	asm volatile ("					\
>> +	call %[bpf_get_prandom_u32];                    \
>> +	r6 = r0;                                        \
>> +	r1 = 0;						\
>> +	*(u64*)(r10 - 8) = r1;				\
>> +	r2 = r10;					\
>> +	r2 += -8;					\
>> +	r1 = %[map_hash_8b] ll;				\
>> +	call %[bpf_map_lookup_elem];			\
>> +	if r0 != 0 goto l0_%=;				\
>> +	exit;						\
>> +l0_%=:	w1 = 0;						\
>> +	r6 >>= 63;					\
>> +	w1 ^= w6;					\
>> +	if w1 <= 1 goto l1_%=;				\
>> +	r0 = *(u64*)(r0 + 8);				\
>> +l1_%=:	r0 = 0;						\
>> +	exit;						\
>> +"	:
>> +	: __imm(bpf_map_lookup_elem),
>> +	  __imm_addr(map_hash_8b),
>> +	  __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>
> I think that this test case (and one below) should be simplified,
> e.g. as follows:
>
> SEC("socket")
> __success __log_level(2)
> __msg("5: (af) r0 ^= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))")
> __naked void non_const_xor_src_dst(void)
> {
> 	asm volatile ("					\
> 	call %[bpf_get_prandom_u32];                    \
> 	r6 = r0;					\
> 	call %[bpf_get_prandom_u32];                    \
> 	r6 &= 0xff;					\
> 	r0 &= 0x0f;					\
> 	r0 ^= r6;					\
> 	exit;						\
> "	:
> 	: __imm(bpf_map_lookup_elem),
> 	  __imm_addr(map_hash_8b),
> 	  __imm(bpf_get_prandom_u32)
> 	: __clobber_all);
> }
>
> Patch #2 allows verifier to compute dst range for xor operation with
> non-constant src and dst registers, which is exactly what checked when
> verifier log for instruction "r0 ^= r6" is verified.
> Manipulations with maps, unpriv behavior and retval are just a distraction.

Thanks for the suggestion.
I could not make it fail in the past without that control-flow in the
end of the test. I will try this.

