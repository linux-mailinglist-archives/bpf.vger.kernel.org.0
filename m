Return-Path: <bpf+bounces-28512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3638BAE9E
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D79C1C216BF
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2CC154BE9;
	Fri,  3 May 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6WfNXax";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RoRdhs8P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C067152193
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745668; cv=fail; b=hgJYlGFrXpbc6HLhOv+SCuCEteypckedPAEoBnNEyR+b9sHYQ3pa1pzHNruhQ5Mr6qRI2rZOk9TYxRs+jSaY3HHhwMEsi7Z7sLetvUibL4LtTRc7LWLI3gdscmXuVs0nULZm6fWw9VEPDjUvQq1TCBC5XbN+bqolYFOvn4Kt7bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745668; c=relaxed/simple;
	bh=cS27vkZoOs5iMzQowb4x8CslnGSvq/kIL+7ZS2yuPUA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=DBaKxHwOYCWNv644U9VD5Ib2UUYNLMoMKkpU+dt+ijf8VUqEzhZFwJR+j4KMq4fSkyoHYlelaniM9xjaxakIusFzHItn7BLZTUiV3AHwfacBWd4M5cGQldUpUGdZwYGZU56Oz5SUNFj6agtalAiBF9GPijcydllmgnptn6T6Wls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G6WfNXax; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RoRdhs8P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C2hBP001644;
	Fri, 3 May 2024 14:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DaUQIK1x6fVrYrRNaIq4IV2uboupEyurcQGc15VsBUc=;
 b=G6WfNXax4d4alDnFfuak9yiwEpENYqNIPWxUBkjTC2X6z2zOGoj0pUeoVPQcsr3u9lqZ
 UW7QDyDox2yy2fgQQOiwWs/0NoYTaLqlkJuWkSqm8dO2U/Z/FYklO3t5nt17MHdwp38+
 lYtrCUGQiPpyfLX3AoWaw6acOotS+VmaTDJSNiR+ojg0tGQSU8rcet7V89mtO2npx/p8
 40dePPr6ug17rDPKs3cJppMS7Q087HmO8F1d+uZh4zhzOOyfSBf2hl2RLDQ9B1hu6ND9
 /4is1bXRaXxKF0Fx5hsnWIkBWyokp7vkK0KiP/Ct8CXN56+aBk5/6+mu65iy+NYOY9kq 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf7yte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 14:14:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443D3f3C019996;
	Fri, 3 May 2024 14:14:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbvm86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 14:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6vMLio/LLouCOv0wa9cBCeom0BEiM/Pjox7GN+0dkURxbh2fRy0w36NlG6qOgRKZ76v+TbVex+DrHR+cIdtb3ZABurCWXwR3f+brDT1nrtK2Vl+4xlhO4MkTjlioiqhx0goev9P3gAOx3qB7ExG4TqQP8E2aC61h+FaHEX0NQz5sJkfh1VPDzad5Nr948T6eFNtWmhtxKif7GkFIs+AAFpr+oH/0I5T9whewF4ks5ml4u6AwxCfnrp1PwdmAGjKkYP6jXRx3eG4CrQco2irBuafcluSnEgztJB8emf6uubq7jxO0hUnm6ElwC0boFSGDuTvRhVP57A/lgfKc4XOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaUQIK1x6fVrYrRNaIq4IV2uboupEyurcQGc15VsBUc=;
 b=THRX3zC3zXEwywHk5dGxI3bLgGJHvf1kiQVYyh4Qka/c7XR7RNxeQFsTeR+C+R2VFATrLn03IdAO4bqD18R4G1eUGBWWKFdJhLVWpnDFOYkIhQ8Xa1D5P2BRKEcBOO/ySvi7rXep+GEQusvzQt7mODxTwsCANjefk08xqMBz0gEklBSZUzjucucDbEtNGKgXbPKEpUL4XHm0n2aPQUdKbnHCf2i6gq296o1ikaKePG0QgKkbhqhvAofQOGEVSuOU0kUDKKJG/Km+y9COcudjxnCq39hTRXybRhazUgqI9ITTW9QbH8eRsQfciDlgDC1rI/IdTPt+BiHMx9F/ZPQVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaUQIK1x6fVrYrRNaIq4IV2uboupEyurcQGc15VsBUc=;
 b=RoRdhs8PUOP3XtMgADAtobdyodb1Ih5/c1XyJFZCLqNvEmSU5suFX+0sUzh4lzOBPiq1MLkxgYkT71gysl6LBRF4VnLsaXRjCFoWZ9KI1wnAQWYjSsKDCfWvLhV1qRaawj7LNiVXZ8kfhcl+dSSmjQrU1up6gMnZKXmEDfJKEnM=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH3PR10MB7496.namprd10.prod.outlook.com (2603:10b6:610:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 14:14:19 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 14:14:19 +0000
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Subject: Re: [PATCH bpf-next v4 0/7] bpf/verifier: range computation
 improvements
In-reply-to: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Date: Fri, 03 May 2024 15:14:16 +0100
Message-ID: <87ikzvt22v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH3PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 425c4749-a84f-4150-2a40-08dc6b7b527a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9ybIsvCsYTEm2pMBEGTJRm8TXI1TkDJfJv0LRQVL3x3LFLDTl3+Q3aW7yWFk?=
 =?us-ascii?Q?owJN1IKcpmHVXBWcvFm4/cfC7u2E1tdGS7GAFT//O3VmE1h7aVCK3BKHXrCa?=
 =?us-ascii?Q?DwmPmSoVVO3aHZQI3Dg+hOVaA0emFuqgikuGbkjU/1LsgGGeMQqi5UOk63SB?=
 =?us-ascii?Q?t9A1DXZB5OtTuU8hLgQJ5MVuvYYBj9FGBJFELWC2R1VEgkNvGSc4/YeVL48r?=
 =?us-ascii?Q?TnfqVID9cOpIYwa0Br9vANgJf/pE0FbSOzh+CYXiX6ExGsO+JKW6l12pHiR9?=
 =?us-ascii?Q?aLY5FkF9yIak1pHbV71Y/+cHVPCmbMvvfggXlvOXDBQh3J+fRQsPxEG6slTn?=
 =?us-ascii?Q?wN1xAOEJ4ueHzhMHnyjVzh0vVQDhp+e9PBk/yDEnwBeqFk9+PlFbQktbJnxB?=
 =?us-ascii?Q?VkCzzMPShpLlmU83hSFIXSbchUHqqeBB3vwVs4wUNUbs8Q6br5tC7ELA8dZh?=
 =?us-ascii?Q?N9SZzm+9YK2Ka+gMwxZfCRKYSUfV7QXCV6LsD22MNL0IftN+o7rr2hwTosm5?=
 =?us-ascii?Q?OiLn4/yVUEb5BTwHyH6NDdWgT7y85SPddF4VEmpemITHAhqk3IzFcGMmBnEU?=
 =?us-ascii?Q?k9sHErtfHXQBgm+PtAQ7zK5dUrncNyHY1LWZq006ZSia0gW8o47qn8/JGOkp?=
 =?us-ascii?Q?4EyRh0QwFrGovnt0VD0WyjMqS7ggivXxuLD6Gd62xpMhtYGE9AKNRBNO9A2N?=
 =?us-ascii?Q?CUcWCYXw/EZm4IaOHC5QAWjCHXBfWJnoJ7afBM0CqAHXF0lym8gUSvSJwp/7?=
 =?us-ascii?Q?1Bu9qTPPD7LT7WO9xMhqUpGtzyoi5CycIDBAG3QO3jz5MRglUhhL9rRVa4f2?=
 =?us-ascii?Q?gQIMePKdcjzkCCgE8pu1rjPtQhs79EmfCM9G+fghpYwA0KT824XIFhZBY5kX?=
 =?us-ascii?Q?k9QolxtLEMqnleaXMMJMa/zjNYBQFEJ4Ok+s1K3qVGGzxjwOpTpbcK9S5RVp?=
 =?us-ascii?Q?XOWbHzlO55FGV46oPraZraqjtXQ7vvclaDnpUSUlFL4vGJys1b8CD68ZFBnc?=
 =?us-ascii?Q?RMfBguHkxm4Z+pXUbJohsjGJ+sLz4DC8WSBJk/L1bYo+aoBpS1yyYaDb7VOB?=
 =?us-ascii?Q?lRaPCCamQ6xS37/Ty1RZCLAd2VOqg9vwlN2fTwsgqiu3PjzmgyfJ68AtCCBL?=
 =?us-ascii?Q?bU1//mm4V+brginb62OHr7x/ksPNdHFRdijvHvqUmhaHHPT8yKtnUWURM5B4?=
 =?us-ascii?Q?w+hxhY1N4lwLUgg5OTIpnjks+opLopLNxcpJXI3aZshNtEg0Tugn5k+z+4gQ?=
 =?us-ascii?Q?JeSMX5jV59tSCmzVjrxpeggjXwsQ09zL0UJ7dFLJjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7A4kJ4oQJOKKSPtulH6Q02oI5C5YqK5BJXB5dyt6Iqk2Ui2iutvZXDYE5buL?=
 =?us-ascii?Q?58GJUeGx66T2hBazyi8NJBe0ntajE7167x2DyNqGp46SpTGiuIjTqeV2hYrf?=
 =?us-ascii?Q?SeN7VRlZF6NILnDNpqmHAcMB6jQsYZcQ6IofBaqkOfq4K9BGKGnPyGspfHWY?=
 =?us-ascii?Q?LlPty+HEy6cY80xwMs1C4eGCRoxLFVrN5WQfqULCkIedtoEa+YjhR8w3DSKr?=
 =?us-ascii?Q?ISqk+viSEAqqFHn04oh01TkofuORw1Fe/bDCKNQCVznGY7y4yFRFpWkYnN4z?=
 =?us-ascii?Q?02R1rweklofyDjHpfmUKbMdxk5za//cadCw2+dTv0Y22AedWWMojp1p2BX08?=
 =?us-ascii?Q?g1oGH6Wvv0ezmo/Kxs9eq4UnpVgqsB78v6cAPUWSGyRHiepQcREJHNXEap4T?=
 =?us-ascii?Q?iRNSF1tXqIeVng6BVdPYo47JChzz4urB2qUeqNxOGqucorVk0gURheNI0MYQ?=
 =?us-ascii?Q?iMKzjy4AUrJ4wcIP2YksvMQtWA03Dk+wCakB02IjxH2OpxApDAXeazIeK38Q?=
 =?us-ascii?Q?kWKfVhWFBwizCCGeECig0QW+I1hDX0evuqEYypm2SktKi/Dvrhi8/sLWcGGQ?=
 =?us-ascii?Q?TnfIdIepAR5gvZOwyOmIlAgur1KtjyINqZtG4buVDVihMMkZQlYUePJltOtH?=
 =?us-ascii?Q?feUhG45E6Dw+3JTo7uDQXxLjmz9dvKpcOC08X6eY4nKSS5K4VxSjyPtfckFv?=
 =?us-ascii?Q?/fcDTaOtQ32CWFTxJ83bZGCfGx4XheQaQ7e8CPMfsckJuLsUnEsNQfUpTMB+?=
 =?us-ascii?Q?H+CABKHWNMl3LpFz4vWTX7G91mYxbniyFraOZLbptEtbKmuKbwZ8fMgEqhfQ?=
 =?us-ascii?Q?I3EhicsFVLyvU5LEWE0k0vrDLdFP2tPZs2lo/9nk7q2CnqTEDiU0lO34U/wu?=
 =?us-ascii?Q?9hLTHxtg3jxNsbnfcioKCYL+4cCbf2lzLL6YVqUvTBmqeDtHKERn+TPXRcOn?=
 =?us-ascii?Q?vEvWFn+9WWzCqZksY+MFVayOTVrPaLsVK3Y7It064fNO8bk0niQHjuAcFtuR?=
 =?us-ascii?Q?fiVkarKIKapIQPIeA6SV99q3HReSeCK7Z63NoYA/qR6Jqb54e0UG1H2m3en1?=
 =?us-ascii?Q?LY89Ypet110onBDxl9E+2CELNXzbYn6h+o4jZAaroA3joFXtwAnZi4RvDT9y?=
 =?us-ascii?Q?H17/IBQQ0UgQpxGoXiVLPhrEowIK9EJhcOYs+hiUI57GD23H7kVxp1uTKO65?=
 =?us-ascii?Q?dF3tvLsOtvI94CAzpU4Fzph6kbjKR4PO5XcidfmNfrFLp+JdSiahUnzNPceK?=
 =?us-ascii?Q?ngs/NimR4Z85c60l9Jz3jjEHj3lmKMbh2BzMHmoui3kLjfxj9ONFnLl0zdij?=
 =?us-ascii?Q?ftOKk0d/MBQlg7EHs2Lbnh1ac05DMOUiOs/lUKRGY1Hh9dVAXRk+V9nYKWBb?=
 =?us-ascii?Q?fHtTHpvcO3vgLG1WsIx9EPegVxP01ck0Rs7DHn54l3rQLaMVi7X5vtcQ6oNC?=
 =?us-ascii?Q?DN+/Ojm81aZai+yovIyXMIvBNW/Eu7b7FhNamgSeqTAneR/RtbCrWe7q3TGk?=
 =?us-ascii?Q?lcT+whB2HLx9cIxDlsyguug9xPlO7HMShKHHXOQSf0OLeWqk/Zr4ElTShaE6?=
 =?us-ascii?Q?uDNVFhHWGBrsNStQsagHd34EOtSwIF+iP2FFYw/futhP670ZWSc1tR4AtfxZ?=
 =?us-ascii?Q?7Q3ymJbirKycCwCE1MJAmS8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v/hXoYOhGZQbKyweQs34sl738kq6BCqmtIeM8fPl2fZXAEkEHVHZYF4Rl8cWrvh5s71V2VQrqzmy4pO9PnF9ZFU1xxivzybzuC2vgqi0JcQbafK6/L+BLjwX5Eqc/jmmaNAt5QSaLygpORXbeTNDD3Z3nennGdh1zHdiB43uRmA++ILpbtcE6e2IYO08JudivWrD/DRsfpmIvRSwGmWndFrS6dTGgLCJcwEi9FOcChu/L0xzGl/WLHPzC1wnzX3c9Us0Q3PfkMSC0HY/3HqYEKVgQt+Zxilo3Elh8mgY3tQ7E/n1RlX/DQ5Qlk82L3DcpELm0SmBXcxfni4CP9WwWYVdyA4vfPjDEhRe5IodF83rVCNYvgGs7bTcmbd3+q57eRZkQfVaPbEbK5Vywg3UnRw8U5gtDaJAq0nsiBdywqvsrmLr/dY+v5rToQMMHxJEu+iPiParu1IKknMFG+NlfBmppyxJUCR+EbkHSd+WFLfekbBHc7o8zVvrBQMnlyYxkWfpm8XboSFn1ap+zNh1RkwlGDhE/pVIkKZBHG7+oFjbtz/D3c22S4rsne4BPAC3yvzttqrAFyjTsdARWPAyGxpWVyfpB2LlUYP6fIkVkxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c4749-a84f-4150-2a40-08dc6b7b527a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 14:14:19.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDB04S811YkWbZ5vywHAerRyVJC3qqDn4zsr13J1d2Kd6iaip8a4xr1bkhKfuH4jAbxHeJiRfx1kG8hOxgIWMaKWAD3+RVUj1Ub3TXedDH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030102
X-Proofpoint-ORIG-GUID: a19YnJmBzGB5LJdmEceEEoNYyHMR4gz4
X-Proofpoint-GUID: a19YnJmBzGB5LJdmEceEEoNYyHMR4gz4


Hi everyone,

I wonder if there is anything else to do for this patch series.
Alexei: Without that later removed change in patch 2, the intermediate
state of the patches does not properly work. Eduard refered to that and
agreed in the review for patch 7.

Best regards,
Cupertino

Cupertino Miranda writes:

> Hi everyone,
>
> New version.
> There is one extra patch which implements some code improvements
> suggested by Andrii.
>
> Thanks for your reviews!
>
> Regards,
> Cupertino
>
> Changes from v1:
>  - Reordered patches in the series.
>  - Fix refactor to be acurate with original code.
>  - Fixed other mentioned small problems.
>
> Changes from v2:
>  - Added a patch to replace mark_reg_unknowon for __mark_reg_unknown in
>    the context of range computation.
>  - Reverted implementation of refactor to v1 which used a simpler
>    boolean return value in check function.
>  - Further relaxed MUL to allow it to still compute a range when neither
>    of its registers is a known value.
>  - Simplified tests based on Eduards example.
>  - Added messages in selftest commits.
>
> Changes from v3:
>  - Improved commit message of patch nr 1.
>  - Coding style fixes.
>  - Improve XOR and OR tests.
>  - Made function calls to pass struct bpf_reg_state pointer instead.
>  - Improved final code as a last patch.
>
> Cupertino Miranda (7):
>   bpf/verifier: replace calls to mark_reg_unknown.
>   bpf/verifier: refactor checks for range computation
>   bpf/verifier: improve XOR and OR range computation
>   selftests/bpf: XOR and OR range computation tests.
>   bpf/verifier: relax MUL range computation check
>   selftests/bpf: MUL range computation tests.
>   bpf/verifier: improve code after range computation recent changes.
>
>  kernel/bpf/verifier.c                         | 111 ++++++++----------
>  .../selftests/bpf/progs/verifier_bounds.c     |  63 ++++++++++
>  2 files changed, 109 insertions(+), 65 deletions(-)

