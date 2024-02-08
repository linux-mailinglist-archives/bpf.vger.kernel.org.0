Return-Path: <bpf+bounces-21544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C739B84E9C0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C50289CAB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D83F9EB;
	Thu,  8 Feb 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0yf6B3p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkK7W94b"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6C383BB
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424590; cv=fail; b=dn9mBJYGPam3TIyujl+A4GSsKgKTO3NHOppqvW8hAVSmH4sKVspptg/Q9FSPsB9Af2NrgpJ9iCmfZUHJmXqJa+d7gmrxIxHettLmeYWB+ePUegpIott7UIWgN7NB5BShqabB8OK3aGh+a6so8bhDjNaJnlmamHEEOXgpfwc5X8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424590; c=relaxed/simple;
	bh=9eoZXkInrrIUWwfYT7qEJwjCNoJNiIEoMCzH2hMMsPs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I/NNHKyTdhDu3r5K/RN6TPDO3MTA8SrSsv8whV3NADAcPf3/F7SChiF2wk66nWG58wlweAAzE4wfA54SLyrMrgSdU/JHu5vMkG88fPwbzNHQ8pPB0gVUR81LtdoQVs0ebKq+pIj9W6BwVhozuQlWCYux2+NIzMfiQAyGem8MR9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O0yf6B3p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkK7W94b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418KOCkZ014932;
	Thu, 8 Feb 2024 20:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=fs6LcaI1zBJTOzOBVdVnZY9bRSb2vC+rLXhkNoLvKBw=;
 b=O0yf6B3p3ZqH6hydhhdGfu/a9knaDQ8Uq7hEQv41XPLrKyU7089tnkDLCm5gPWfuI8Pi
 GvGkbCycgd1czt/In21uYpCLReyWjskFpuL9jN7PuSS+kcmh6PRsdpT94NyM8UWmKE1r
 35s62vqfgmdoroQC3KWFSohvlgW5QNgvB5Fi0j7gfPYI0fDQ+PpfXEg6RVAtFp+O+Vbg
 bP4YOeUJkX0GpPJfqx2nDsm5LRm0Kq+Byz7dEBb3GeH6YXtrJjxguMdGGCWcaGrXue63
 MBV4/OZ6DOpv1RwnAVTre1IPjmJjxx/AxZw37+eQMnLTVnseVbNE8kg+uRtzCfeOt0Ug 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c945x8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:36:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418J7brr040219;
	Thu, 8 Feb 2024 20:36:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxhhg3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 20:36:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOskXJGKW9VMN/sc+Um/Huw78UaudXG7rWfyTn0VpounuwsLxCYSLqhZaoXQFJa7iJ7HWVVEM75JZ4muC30PJyYENbnwaWXvDiMcInueErvJjk4rCSeX1UcZ+IcWqxDC4+w8UdJViHBOsZFv7avSQCfoTKoT6MtDdydWQX/LCRxsR4+SwdpFZEMKI0ZIueSMp6irOfYdJmcJuOP0j5BW2VwwA9KIv5hldeSF2O+wBMkPJsV9KldCNOWUwUrn2Tx8duLo33FdAr6rSyHgwRCTzqJxXKnn6rKZSsj+tn+rXrilZQ+Xrc3trfWRPE8AUXuzcM1oS2/9n5pgFoQv2PPq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs6LcaI1zBJTOzOBVdVnZY9bRSb2vC+rLXhkNoLvKBw=;
 b=M3xobdJDptv53MKlXaex9Gc+VWUDLP1ReLGDTbe3fAjldCf4gpedfCGQuZex3CFzw8wyjIho0ULz2ajy850tRwz9yd5OAHWBzHqwe1rMURkZaBP9vUC3hyTAD7HxhRAZ/b6EeC3RTPlkUeNmg23Rsl5PoL/sBDXYaqk1p0IyCrsgw7MMP7P63FX6fjMbJ+rBX8dDBLxYW53gtMww4ugqEb7Nix/+M9mEhG+zvFLrK3OAYLJS465e4BKx29ATSqItfVlTuGqTn19dx0XZwVVxe8W83ayAietG03jRsiefoSinoJYXzlk8e2igkldnuVWm+/USTQbHbAvg2nO81kinog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs6LcaI1zBJTOzOBVdVnZY9bRSb2vC+rLXhkNoLvKBw=;
 b=nkK7W94btOgfY82IIRXPlDCiL9KFGGPNdjHIDscj+JCpmIGFYPGBYJuNSl4AqL5OYzXXVgsuIXD4MOjRRk+BrcsezZEYCXskhVYLeT9dXb21398/mqm5gEf4D91mKKrM+ZWl9uX9NpC99aPtPWxHmzK4ERHCQpyOkoQMowxQx4w=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 20:36:19 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 20:36:19 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH bpf-next V2] bpf: abstract loop unrolling pragmas in BPF selftests
Date: Thu,  8 Feb 2024 21:36:12 +0100
Message-Id: <20240208203612.29611-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 282ba14a-c5d1-4c07-b968-08dc28e59af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z6hIZ1RBEk63CVO9SQR+/c3tD6PN79n1AofzOnz0QGp3hz1SlDH1YHHPbCNrmooGSawIKXmZdkKxjACSXaEKIgFFc6ZjA99AUU2aq1HVGhLyXymwGNvYs6RtCX8sqpIvJO5PDDERXWzrQjHYFtBC6xFvJlBmsiCvBvHT/PBWNmTokAOH6tjHU9G5M1GSEgxsjxAclnhYgC3KQDYPubpXaflrNXCOR8m/F41ti5tbLKb526aQIcF8y4qe6IGitcNELo0WhBagol4v6OgWwsMW3YmVXtWRp+NtovqpmiQlTLtcQ4ME8v5PuV0+cYVKqZO8N0FrdPUeZiwH1SmfGRMPmFzHedtZyA2ClL+E8yRUgqZV8oNgaICy1vujtQQ/SuEFMullrshnbOeLv9hku8lNElm3KEkM7qttC6oOhcFgmrH1s3SFK+c/meSBsGwIT9NzhBr2eOMvIObrRZ3RpNeoGBnggRZD0jsHRtfiZgtuillwijGdJoHZPVq1UGiJDbjJqveEQbgFqUdzF9/RslBl6sms+sxRWk4aXFJTz5UQJB0EmnNvlRDp7xKKLM4Sids9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(6486002)(478600001)(6916009)(66946007)(66556008)(66476007)(316002)(54906003)(5660300002)(1076003)(6512007)(26005)(2906002)(30864003)(107886003)(2616005)(36756003)(6506007)(6666004)(86362001)(4326008)(8936002)(83380400001)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q8wForiIIoWUGG6w5GOCo0o3XH3Tkta/r3xcrotR9mKFk/oIYfJSDR+ZNP97?=
 =?us-ascii?Q?0RRbpYYQfRyhYI1Ke92+UGeKWFnzNziMRXSuPoaPsRyDgG//5YiYrjXqeAaj?=
 =?us-ascii?Q?48QEaolaOHXSdoXdGoqMdB0YHtDMdGaXe2ldAUNHOymGFokaVtdWYhXRY6Nc?=
 =?us-ascii?Q?b2+DXl2u1uHaOioXdcG+Fcr7zN+D7AWUYATZRUfMbAL7bkD5odW9B88frkah?=
 =?us-ascii?Q?zW8PDYIbpQRUvq8V/Sl9os9rbL0gooDcs4tkhizHZ6T1sXlr0zE5Jz8D+cRH?=
 =?us-ascii?Q?EC33PsvrEf1yut/3Ts1vHsOZMgKj+5FxVTNwHj2HOu1MifK2COYcVZmhjuvf?=
 =?us-ascii?Q?buGrORiuvWIsYkHivEebp0y+rLxUJvRgDIyhlGHRI+d+WMK80sre1s9niII1?=
 =?us-ascii?Q?s6rT6BX85wzClcaaZe4jFKSQ+rvrSre2A1JttWBo9dFN0JD+2n3f1eyBCpzN?=
 =?us-ascii?Q?LkPg5H788DG4N4I5GS5DH6UPSM4+urVbTBqhpffKaKc6ynd2gOwNa+AFzn3q?=
 =?us-ascii?Q?K7Ka4cppnSD8+79yFp457zVQogoY1pO/LJfu4nMoUmuehAOTICBLtcIi8BHd?=
 =?us-ascii?Q?5kE1JjvSY0onnj8AAL2EUDsc5UWTFl88uzP68owblmbxAcoSZ4snvAu8F394?=
 =?us-ascii?Q?avDci1eWUPfSt+6nbdOkBwDrOpmhCHMWLHdR0fsDWiUcxc4hTjPfiR2w2B1d?=
 =?us-ascii?Q?x1QDLNsln40Ls1DiqPkJsZpWfY5KHYaDRvZyonc2WzdONmj+s2g500hyIVS+?=
 =?us-ascii?Q?kor1uyQtxiogtftnrODI7q84Eyl2ugp5gkaLnT9FhHtfV2ukqmbZUaMU2fwN?=
 =?us-ascii?Q?+arAw6PrUcxk7cT66BZ/mJTv6xQysp/wek6K3ZZpRkelSbc7JjlkuPvfn5HV?=
 =?us-ascii?Q?XCPrRO/C7b0NPaxXnCqNymvBnt28kMgMIsZ84CxTtvUg9wGly7pLHlOqH5G9?=
 =?us-ascii?Q?SgMS+0LJb24MWv6J5clAP0R9WOGphFir0H0+epxjfaqds6tYHu9MKaU9g/EI?=
 =?us-ascii?Q?UhihMJYOSBG2AbmWr/NAWkoYMhPY4MmARc+uXGGOGI1PC3+glrgCXpRqe2Th?=
 =?us-ascii?Q?kUEhox9QqqS4DNeQx7l1KpzLPaQy4sgWWo1AX/45EXgy69++ExEecs5tIPSv?=
 =?us-ascii?Q?Wes5T8LZkrajeHfVAaGcZUdrVY0XxC1uwMrmfT3xDVhtQm6SDlLfUuu+Z8yr?=
 =?us-ascii?Q?pvIDxDymMkJNFKiiGbzo+OaZtPD5H4DnmHRWRQobrDaaOwaiSZVbkzy5oGzo?=
 =?us-ascii?Q?2SJMAamrHnIpdzcdM6fLgTI568JbsHhd+HPitbf5vg/6SZDBQzFCGoAoBHrE?=
 =?us-ascii?Q?lI1es73XjdadL0gowvcFyMKQsJ6aDvmqRarGOuRG5+J6B/U1Z7DyE82xCAth?=
 =?us-ascii?Q?2ROE5l3QkQmyQrau8arlzWMRSMwZ0vPqIjKL/4J2U0dj8ncYmitZtU/hKl41?=
 =?us-ascii?Q?qB1YWeIJPCOclqdPWW1YkYWOXPSQGYmm2GC2RVyX0brQsg3HtXBdiq2KWM1V?=
 =?us-ascii?Q?twt2Yvk2hYF07HXRXCZuEUhD/fu/ZcH7sKreM2rW5KbtPfprlpK/6CFjKAjl?=
 =?us-ascii?Q?xv0dAxs6pCO+EI8bBU33s/2BZFaNPOZH/oCsmRji9ZQUkg619oLdBIj3nhDF?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p5VEQS5SbQOjvKfKZFaD4ydO4kwojbmCoclHHLuOtxTCseie/nDuDzjVwdBW+GM1MLuWtrZTSkUzyKLqlabD/is4oFrPgaFG9S2pJlUCPvSZzzGBAnHmBERBbEyxBCq2I1MbNUKm2iLYbtRJpD6ALqWUgAOPw43nCnvfNBa6is06SdLVsLZfP5BpQni9OW6sdHuvCZAOtU7PW6pfd7DcNejyLvKH0agQF1d7mkmiLKqsNtnwDhgd0VoTcTAjyWn+Kb30wkpH92U1ON4xZmArBKYmgNV5GdCH7s7tkcQOtSWRKKIbG+haNs0ZAxklOQDj80jSSXF2Use3kpypvRMRBRAXM4Md0hFZzSYp4IWSL1NmTWDqStH16sO3gDX2VDFvS1JaThPr89mYk3kHdwT56tWx8cjbRrWSAF/wSrvwRSlSiOYUliz6iK7YxRfbgF1zp7gw2HOG4vX1VVzKjpQpBK9z+jK73LSREmkRBn09MED8hlGgimlcP6qnpmRhnkszv3hvGQW+obzwGKRNTSCI6EE5CR+Ah/ytkkakaHpJFwLqDxmS6EFjRTzqlU30+R7oAyiVF9li+RL6qcG9hoLqV8qmmQf0+m6j/+/Fyuf9Egc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282ba14a-c5d1-4c07-b968-08dc28e59af8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:36:19.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDYQzR4Zca0RXn6thoCMqv3vtD7cosAll1NY9C99/nlqVYMaPiDeBIon7PGnouGtGpEsKdBcIgRy9LTodBf5/9iwc21g+VramMEvFPZPitc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=905 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080110
X-Proofpoint-ORIG-GUID: uEMCMiwfZrc8TksReBVuhQ7CSN50GHNT
X-Proofpoint-GUID: uEMCMiwfZrc8TksReBVuhQ7CSN50GHNT

[Changes from V1:
- Avoid conflict by rebasing with latest master.]

Some BPF tests use loop unrolling compiler pragmas that are clang
specific and not supported by GCC.  These pragmas, along with their
GCC equivalences are:

  #pragma clang loop unroll_count(N)
  #pragma GCC unroll N

  #pragma clang loop unroll(full)
  #pragma GCC unroll 65534

  #pragma clang loop unroll(disable)
  #pragma GCC unroll 1

  #pragma unroll [aka #pragma clang loop unroll(enable)]
  There is no GCC equivalence to this pragma.  It enables unrolling on
  loops that the compiler would not ordinarily unroll even with
  -O2|-funroll-loops, but it is not equivalent to full unrolling
  either.

This patch adds a new header progs/bpf_compiler.h that defines the
following macros, which correspond to each pair of compiler-specific
pragmas above:

  __pragma_loop_unroll_count(N)
  __pragma_loop_unroll_full
  __pragma_loop_no_unroll
  __pragma_loop_unroll

The selftests using loop unrolling pragmas are then changed to include
the header and use these macros in place of the explicit pragmas.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 .../selftests/bpf/progs/bpf_compiler.h        | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/iters.c     |  5 +--
 tools/testing/selftests/bpf/progs/loop4.c     |  4 ++-
 .../selftests/bpf/progs/profiler.inc.h        | 17 +++++-----
 tools/testing/selftests/bpf/progs/pyperf.h    |  7 ++--
 .../testing/selftests/bpf/progs/strobemeta.h  | 18 +++++-----
 .../selftests/bpf/progs/test_cls_redirect.c   |  5 +--
 .../selftests/bpf/progs/test_lwt_seg6local.c  |  6 ++--
 .../selftests/bpf/progs/test_seg6_loop.c      |  4 ++-
 .../selftests/bpf/progs/test_skb_ctx.c        |  4 ++-
 .../selftests/bpf/progs/test_sysctl_loop1.c   |  6 ++--
 .../selftests/bpf/progs/test_sysctl_loop2.c   |  6 ++--
 .../selftests/bpf/progs/test_sysctl_prog.c    |  6 ++--
 .../selftests/bpf/progs/test_tc_tunnel.c      |  3 +-
 tools/testing/selftests/bpf/progs/test_xdp.c  |  3 +-
 .../selftests/bpf/progs/test_xdp_loop.c       |  3 +-
 .../selftests/bpf/progs/test_xdp_noinline.c   |  5 +--
 .../selftests/bpf/progs/xdp_synproxy_kern.c   |  6 ++--
 .../testing/selftests/bpf/progs/xdping_kern.c |  3 +-
 19 files changed, 102 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h

diff --git a/tools/testing/selftests/bpf/progs/bpf_compiler.h b/tools/testing/selftests/bpf/progs/bpf_compiler.h
new file mode 100644
index 000000000000..a7c343dc82e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_compiler.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_COMPILER_H__
+#define __BPF_COMPILER_H__
+
+#define DO_PRAGMA_(X) _Pragma(#X)
+
+#if __clang__
+#define __pragma_loop_unroll DO_PRAGMA_(clang loop unroll(enable))
+#else
+/* In GCC -funroll-loops, which is enabled with -O2, should have the
+   same impact than the loop-unroll-enable pragma above.  */
+#define __pragma_loop_unroll
+#endif
+
+#if __clang__
+#define __pragma_loop_unroll_count(N) DO_PRAGMA_(clang loop unroll_count(N))
+#else
+#define __pragma_loop_unroll_count(N) DO_PRAGMA_(GCC unroll N)
+#endif
+
+#if __clang__
+#define __pragma_loop_unroll_full DO_PRAGMA_(clang loop unroll(full))
+#else
+#define __pragma_loop_unroll_full DO_PRAGMA_(GCC unroll 65534)
+#endif
+
+#if __clang__
+#define __pragma_loop_no_unroll DO_PRAGMA_(clang loop unroll(disable))
+#else
+#define __pragma_loop_no_unroll DO_PRAGMA_(GCC unroll 1)
+#endif
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 225f02dd66d0..3db416606f2f 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_compiler.h"
 
 #define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
 
@@ -183,7 +184,7 @@ int iter_pragma_unroll_loop(const void *ctx)
 	MY_PID_GUARD();
 
 	bpf_iter_num_new(&it, 0, 2);
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
@@ -238,7 +239,7 @@ int iter_multiple_sequential_loops(const void *ctx)
 	bpf_iter_num_destroy(&it);
 
 	bpf_iter_num_new(&it, 0, 2);
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
diff --git a/tools/testing/selftests/bpf/progs/loop4.c b/tools/testing/selftests/bpf/progs/loop4.c
index b35337926d66..0de0357f57cc 100644
--- a/tools/testing/selftests/bpf/progs/loop4.c
+++ b/tools/testing/selftests/bpf/progs/loop4.c
@@ -3,6 +3,8 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 char _license[] SEC("license") = "GPL";
 
 SEC("socket")
@@ -10,7 +12,7 @@ int combinations(volatile struct __sk_buff* skb)
 {
 	int ret = 0, i;
 
-#pragma nounroll
+	__pragma_loop_no_unroll
 	for (i = 0; i < 20; i++)
 		if (skb->len)
 			ret |= 1 << i;
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index de3b6e4e4d0a..6957d9f2805e 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -8,6 +8,7 @@
 #include "profiler.h"
 #include "err.h"
 #include "bpf_experimental.h"
+#include "bpf_compiler.h"
 
 #ifndef NULL
 #define NULL 0
@@ -169,7 +170,7 @@ static INLINE int get_var_spid_index(struct var_kill_data_arr_t* arr_struct,
 				     int spid)
 {
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 		if (arr_struct->array[i].meta.pid == spid)
@@ -185,7 +186,7 @@ static INLINE void populate_ancestors(struct task_struct* task,
 
 	ancestors_data->num_ancestors = 0;
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (num_ancestors = 0; num_ancestors < MAX_ANCESTORS; num_ancestors++) {
 		parent = BPF_CORE_READ(parent, real_parent);
@@ -212,7 +213,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
 	size_t filepart_length;
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
 		filepart_length =
@@ -261,7 +262,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 		int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
 						  pids_cgrp_id___local);
 #ifdef UNROLL
-#pragma unroll
+		__pragma_loop_unroll
 #endif
 		for (int i = 0; i < CGROUP_SUBSYS_COUNT; i++) {
 			struct cgroup_subsys_state* subsys =
@@ -402,7 +403,7 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 			if (kill_data == NULL)
 				return 0;
 #ifdef UNROLL
-#pragma unroll
+			__pragma_loop_unroll
 #endif
 			for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 				if (arr_struct->array[i].meta.pid == 0) {
@@ -482,7 +483,7 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 	struct dentry* parent_dentry;
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		filepart_length =
@@ -508,7 +509,7 @@ is_ancestor_in_allowed_inodes(struct dentry* filp_dentry)
 {
 	struct dentry* parent_dentry;
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
 		u64 dir_ino = BPF_CORE_READ(filp_dentry, d_inode, i_ino);
@@ -629,7 +630,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 	struct kernfs_node* proc_kernfs = BPF_CORE_READ(task, cgroups, dfl_cgrp, kn);
 
 #ifdef UNROLL
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++) {
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 026d573ce179..86484f07e1d1 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -8,6 +8,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_compiler.h"
 
 #define FUNCTION_NAME_LEN 64
 #define FILE_NAME_LEN 128
@@ -298,11 +299,11 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 #if defined(USE_ITER)
 /* no for loop, no unrolling */
 #elif defined(NO_UNROLL)
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #elif defined(UNROLL_COUNT)
-#pragma clang loop unroll_count(UNROLL_COUNT)
+	__pragma_loop_unroll_count(UNROLL_COUNT)
 #else
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 #endif /* NO_UNROLL */
 		/* Unwind python stack */
 #ifdef USE_ITER
diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 40df2cc26eaf..f74459eead26 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -10,6 +10,8 @@
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 typedef uint32_t pid_t;
 struct task_struct {};
 
@@ -419,9 +421,9 @@ static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
 	}
 
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif
 	for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
 		if (i >= map.cnt)
@@ -560,25 +562,25 @@ static void *read_strobe_meta(struct task_struct *task,
 		payload_off = sizeof(data->payload);
 #else
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_INTS; ++i) {
 		read_int_var(cfg, i, tls_base, &value, data);
 	}
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_STRS; ++i) {
 		payload_off = read_str_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #ifdef NO_UNROLL
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 #else
-#pragma unroll
+	__pragma_loop_unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_MAPS; ++i) {
 		payload_off = read_map_var(cfg, i, tls_base, &value, data, payload_off);
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index bfc9179259d5..683c8aaa63da 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -20,6 +20,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
 #include "test_cls_redirect.h"
 
 #pragma GCC diagnostic ignored "-Waddress-of-packed-member"
@@ -269,7 +270,7 @@ static INLINING void pkt_ipv4_checksum(struct iphdr *iph)
 	uint32_t acc = 0;
 	uint16_t *ipw = (uint16_t *)iph;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (size_t i = 0; i < sizeof(struct iphdr) / 2; i++) {
 		acc += ipw[i];
 	}
@@ -296,7 +297,7 @@ bool pkt_skip_ipv6_extension_headers(buf_t *pkt,
 	};
 	*is_fragment = false;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 6; i++) {
 		switch (exthdr.next) {
 		case IPPROTO_FRAGMENT:
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
index 48ff2b2ad5e7..fed66f36adb6 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
+
 /* Packet parsing state machine helpers. */
 #define cursor_advance(_cursor, _len) \
 	({ void *_tmp = _cursor; _cursor += _len; _tmp; })
@@ -131,7 +133,7 @@ int is_valid_tlv_boundary(struct __sk_buff *skb, struct ip6_srh_t *srh,
 	*pad_off = 0;
 
 	// we can only go as far as ~10 TLVs due to the BPF max stack size
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 10; i++) {
 		struct sr6_tlv_t tlv;
 
@@ -302,7 +304,7 @@ int __encap_srh(struct __sk_buff *skb)
 
 	seg = (struct ip6_addr_t *)((char *)srh + sizeof(*srh));
 
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (unsigned long long lo = 0; lo < 4; lo++) {
 		seg->lo = bpf_cpu_to_be64(4 - lo);
 		seg->hi = bpf_cpu_to_be64(hi);
diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
index a7278f064368..5059050f74f6 100644
--- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
+
 /* Packet parsing state machine helpers. */
 #define cursor_advance(_cursor, _len) \
 	({ void *_tmp = _cursor; _cursor += _len; _tmp; })
@@ -134,7 +136,7 @@ static __always_inline int is_valid_tlv_boundary(struct __sk_buff *skb,
 	// we can only go as far as ~10 TLVs due to the BPF max stack size
 	// workaround: define induction variable "i" as "long" instead
 	// of "int" to prevent alu32 sub-register spilling.
-	#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (long i = 0; i < 100; i++) {
 		struct sr6_tlv_t tlv;
 
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index c482110cfc95..a724a70c6700 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -3,12 +3,14 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 char _license[] SEC("license") = "GPL";
 
 SEC("tc")
 int process(struct __sk_buff *skb)
 {
-	#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < 5; i++) {
 		if (skb->cb[i] != i + 1)
 			return 1;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 553a282d816a..7f74077d6622 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
@@ -30,7 +32,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -59,7 +61,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
index 2b64bc563a12..68a75436e8af 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
@@ -30,7 +32,7 @@ static __attribute__((noinline)) int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -57,7 +59,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index 5489823c83fc..efc3c61f7852 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -9,6 +9,8 @@
 
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_compiler.h"
+
 /* Max supported length of a string with unsigned long in base 10 (pow2 - 1). */
 #define MAX_ULONG_STR_LEN 0xF
 
@@ -31,7 +33,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
 		return 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < sizeof(tcp_mem_name); ++i)
 		if (name[i] != tcp_mem_name[i])
 			return 0;
@@ -57,7 +59,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	if (ret < 0 || ret >= MAX_VALUE_STR_LEN)
 		return 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
 		ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
 				  tcp_mem + i);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index d8d7ab5e8e30..404124a93892 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -19,6 +19,7 @@
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_compiler.h"
 
 #pragma GCC diagnostic ignored "-Waddress-of-packed-member"
 
@@ -83,7 +84,7 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 
 	iph->check = 0;
 
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0, csum = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *iph16++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
index d7a9a74b7245..8caf58be5818 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp.c
@@ -19,6 +19,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
+#include "bpf_compiler.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
@@ -137,7 +138,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	iph->ttl = 8;
 
 	next_iph = (__u16 *)iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (i = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *next_iph++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index c98fb44156f0..93267a68825b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -15,6 +15,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include "test_iptunnel_common.h"
+#include "bpf_compiler.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
@@ -133,7 +134,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	iph->ttl = 8;
 
 	next_iph = (__u16 *)iph;
-#pragma clang loop unroll(disable)
+	__pragma_loop_no_unroll
 	for (i = 0; i < sizeof(*iph) >> 1; i++)
 		csum += *next_iph++;
 
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index 42c8f6ded0e4..5c7e4758a0ca 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -15,6 +15,7 @@
 #include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_compiler.h"
 
 static __always_inline __u32 rol32(__u32 word, unsigned int shift)
 {
@@ -362,7 +363,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	iph->ttl = 4;
 
 	next_iph_u16 = (__u16 *) iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
@@ -409,7 +410,7 @@ int send_icmp_reply(void *data, void *data_end)
 	iph->saddr = tmp_addr;
 	iph->check = 0;
 	next_iph_u16 = (__u16 *) iph;
-#pragma clang loop unroll(full)
+	__pragma_loop_unroll_full
 	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 518329c666e9..7ea9785738b5 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -7,6 +7,8 @@
 #include <bpf/bpf_endian.h>
 #include <asm/errno.h>
 
+#include "bpf_compiler.h"
+
 #define TC_ACT_OK 0
 #define TC_ACT_SHOT 2
 
@@ -151,11 +153,11 @@ static __always_inline __u16 csum_ipv6_magic(const struct in6_addr *saddr,
 	__u64 sum = csum;
 	int i;
 
-#pragma unroll
+	__pragma_loop_unroll
 	for (i = 0; i < 4; i++)
 		sum += (__u32)saddr->in6_u.u6_addr32[i];
 
-#pragma unroll
+	__pragma_loop_unroll
 	for (i = 0; i < 4; i++)
 		sum += (__u32)daddr->in6_u.u6_addr32[i];
 
diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
index 54cf1765118b..44e2b0ef23ae 100644
--- a/tools/testing/selftests/bpf/progs/xdping_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
@@ -15,6 +15,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bpf_compiler.h"
 #include "xdping.h"
 
 struct {
@@ -116,7 +117,7 @@ int xdping_client(struct xdp_md *ctx)
 		return XDP_PASS;
 
 	if (pinginfo->start) {
-#pragma clang loop unroll(full)
+		__pragma_loop_unroll_full
 		for (i = 0; i < XDPING_MAX_COUNT; i++) {
 			if (pinginfo->times[i] == 0)
 				break;
-- 
2.30.2


