Return-Path: <bpf+bounces-21507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C828384E3AA
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA74B21495
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488779DDA;
	Thu,  8 Feb 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVKvPtpU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P7pzZHnw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD71E525
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404715; cv=fail; b=FH8fNLJMKMO0s58lQi0VOHkWJFHr8e47gmOe/OANXIJGtkVuxskhkhLSC/rvPXNY/XiivjYr1OZeo6gsTIL0UJ9cer0jptkqt6//yLUqdqrkpL2kDV6qrCOvxmRlSZZx5us9mzfKB2m24u+GsyowHhiR1CYCY3OJGYqvxEFfg7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404715; c=relaxed/simple;
	bh=zVh3qKfaXvl8T+8eOQNMdYceNIrw2Ak1uK1zUkxnbQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=dJNTq82U7lnQZaab2SiKgdsPMtdRvZBOge1pxdROtb+9YMgCmDqogm3tGQr+alP1cdtT5SdAte/3QR1QfZWXffzHCBD+46kTOya3QidQriNdnkec6x4MO9fb0Z4n1Uwkl61VBIWiG3X4QGJIIQ9Fl3LOYtLr3pUd0aYQO/pBx80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZVKvPtpU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P7pzZHnw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418EKIqk001004;
	Thu, 8 Feb 2024 15:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=zVh3qKfaXvl8T+8eOQNMdYceNIrw2Ak1uK1zUkxnbQ0=;
 b=ZVKvPtpUQ/84lu5ZQ2maT7TaJON7EzeeaveAvR0306ILffFM4QwjW+snIjPRV3uMwSrW
 eWAAhFevQWdy0IpvBvxBjWu639reXRSIp8pjMRtiENv8KjxgnTixrQOTIjz4xZn4jwtp
 tpRQpOLBzWOSq4be+NXnAYt4W7lldz+byrvOu9hyl6JolJfjnAJ1QKdTHR2tszhMikly
 Qzn+7t7JMYufbpXG3oFjDaVqbz+GAjqyWayB0TcIPUeeDABrmfCOmDc0f/lO/TTV5CaN
 +OsG8qz4viPgTrUtV4538/e335jkeeYeT7GVt054TAUjO2rBXEC6KY4pf8AS42MvaqVd AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd51rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 15:05:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418Et5cM007259;
	Thu, 8 Feb 2024 15:05:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb5aqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 15:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPDc9TA/AY88fm3KkrBZyfQuoR2YatTjFT5ZVE9vb/tcZz3frTAQhFjlrXu5WQQb7J5rMdsH9DUszBrzGVJaZI1B1qdbGXph5tGuIFetGBaRRXdCS3fHfbt4AFdz/+S4FQn1BLs6NAn15J3ZhEFENSlZqhZvz8DzddEZaVn0NCdjjsK6g+YZ57SUGpnvm3KAE2OvxwYvhsrS8CpPeK7ERDosyrHX0GYIRbScW4HvJn4VgI/v/FJCFaR2EkuhMJbVpSbwJF+1d1yOSJ4si70huEW2BhNpV/WwS4ebJNdBouxS/zVYKLf0s7D8P2xwh60fvtIoUb3n3zcC/6368AisHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVh3qKfaXvl8T+8eOQNMdYceNIrw2Ak1uK1zUkxnbQ0=;
 b=au+rvgacoUwuPzAULDAEnQ6oD7FWviRHPHfp/Yyx7TtgyQxq0L1AOm1DHq/xYLE+04BhSnqNtg7pD6KxicmxeXjtSHwBKGsBwlTfNkrEeSTVaouL4Flsj3NHhCo6sjX/ZjkXqNlZB8TCVIQ58eFOZBE/g83nBwN76iOoSB3jJ5T0Sqb1iifL3aQ7LpWQbWV1Q1SvVNDDRqM4VLcZwycIq4pQONB+EHMd604/Hof2H/JZQ2Gfsv6hCBpNNPcnVHuRZAFcR5nYkJA2NaUNA2r40C66PbLOQLWK/fr0wqmAfuKenDz+AFVVViYSb4wxEDGNBwMGJpjYnqXXoBdEHeZWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVh3qKfaXvl8T+8eOQNMdYceNIrw2Ak1uK1zUkxnbQ0=;
 b=P7pzZHnwZjXLAxCe4hCsH8+azclrVFz7E+o5glXTJ0DKP9Qgs9Wf7ifXOImaRKJMi+LzGqeS73g0wCcEi9eKAAb/r9JXBuCN03RV4ysk2kUVU417pHGK+wUQXRhqnVQ/DTVIJOgDzOA4BlA3yT2EU+IWxsLCgJ0wDFkbDtkfkIU=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH8PR10MB6313.namprd10.prod.outlook.com (2603:10b6:510:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 15:05:04 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 15:05:04 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        Yonghong
 Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 08 Feb 2024 16:18:55 +0200")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	<4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
Date: Thu, 08 Feb 2024 16:05:00 +0100
Message-ID: <87o7crdmjn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::23) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH8PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b643ae-e9e4-4e1b-d25b-08dc28b75499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o4+K3Atl7LGeoun1+Ln88BM7q+wz08WHu06CrlQElQ28UCqVjmGWc92GLyhnRpgyu67s50cFs/LVhR+rPS00SdO4AozwZi6qhPzcQvaOi77KrhTroT32AUIGsKlxjT4ZlzC6WdaMgxTb/XucLl9py76BUy0cdkKmx6SJwfgwJetrNp4xS1B1ngwNWQVdprCpTEhS9YfvcmoN79H5KOq/d0bN0LDLFnHGKYhO39LvCJWK6K8tp+fczo0CBYJ8zLcQyKHXXm501p+o5yrqyhBKdU6/yrNmFZRu9gMr3EAfCtpwr6SDtO8DlqBe6vDnXaBS03fPjq6nL9T6407/JI/8eWZkbzesoLI5ilknrtq8DH/GjE98g59vnSDxRiKaZhdOTTr2Bh3vOvUxBRYZfVSBhFp19iGIcL03aksmI6JlC+BDqLk6tpXvAw1FTfefZ5wdQW3MVBWs+4cuMUkLJCWBbHnawNtdWX6b8mX/yg9bfGbTnoWJ+NZIhFGF3ylvf20bQXVPHnQWz2/VCeFF3wi5whiOQXiLH929hQ0LpO7xSHEbCvHkgM7zixGmE9W2R4k8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(8676002)(8936002)(4326008)(4744005)(5660300002)(83380400001)(86362001)(107886003)(26005)(2616005)(38100700002)(36756003)(66476007)(66946007)(66556008)(54906003)(6916009)(316002)(6506007)(6666004)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fBUMeQ0OH9DQ2KUOMBLilxzoNK5xBgIGeRZ5xvsaHGEMS+3qwK+2ldGARgw6?=
 =?us-ascii?Q?1j26nqn2lxKCYiRpIqM8FetJBpcriUpJcRdKzX7SI9YSG4BzT0FplZ87LDOz?=
 =?us-ascii?Q?JrNXobLjIXjFdrSW9pdfaTZ8bMEdcffLQDB7565QVN2MANhqKavM6RaYE3rM?=
 =?us-ascii?Q?XI0nDZhGERJg3ID0IB7gs1zbv4F3DqPiKRGVNytfNJfUGgrMZBeMNiEvwyZW?=
 =?us-ascii?Q?GNiVicG6NL9PKzNCG5gszYrAYXn1IaTGA7F9w2NGmP9nNmnvpoyD/kc3XT/A?=
 =?us-ascii?Q?twXJm1KsQgoqTJM+k3wQG9h1UJOcfTHttmLadtGH+iXwjt7HjxKF0658r+b2?=
 =?us-ascii?Q?+UEOYRm8kiOJmQGZvCLuNfI2Nyss+adGSMzB19bRyy+xek92I20DvP2OFDIV?=
 =?us-ascii?Q?DkxecC9hXYABsjMqZwX8OBENz6pisaskTNE5ADuNtdDnPbY9JvCBvdS4t4KL?=
 =?us-ascii?Q?4tjsNE/txuc3UhZOcLbqiItgQoTr/vXOFgkdz3eENGEbpOxWjBtfba8Yzz3m?=
 =?us-ascii?Q?btbrV+/u+l+HOnjQz+CRqeaf1ewytK6/790H2cbARZ7IlwpAcfYoKpjxk0NC?=
 =?us-ascii?Q?F0uP7ZMwBDmiXPpqeNql07oOMwvllnXU9yN2eTkodPNgNtDBR/N497zu4g2z?=
 =?us-ascii?Q?s3VCaj+B8JNWZsjJ1p8AnvwvK5JImLnfVixdWpviBEloHPLY20F8vLS/GhRe?=
 =?us-ascii?Q?mftNS7NtS3DsMtK53/x1OEnvuuQ8W47JxFPAtBdYiU1JidP2BXvDSnAnc09F?=
 =?us-ascii?Q?hqDvxtVrWsUo6hCBHXvbkQKXPR2v359trE4dXvQePclLmtRW8YN4A08QPoae?=
 =?us-ascii?Q?ARRQ/btCqqPfZYkdOZZdcOrCKGC+Zn/OX9Fz3TePYOuq5ZLT4s3Q7Dx4a6X3?=
 =?us-ascii?Q?YWpDb5W2jDgi3yExkBW8JTmuoAykKqj7AdZVRiu5cqRZWNuxPOObSyGGQvk8?=
 =?us-ascii?Q?r+owVW54bD2c6G6DBNnExZIR9AAPZGi+AJ/wovk/WrQWg+xSxULV7p3wLGsJ?=
 =?us-ascii?Q?J5eDfkvAhMzTGImV0qpvVn8xern61lBA/MV09tSFx3QN0xuB7MCXc7+VbYZd?=
 =?us-ascii?Q?dxw0uAf+dQTMdM5cixjMpe82atov7240Ux3XU1GMEYNdQbz5kRU82Xcl0oNn?=
 =?us-ascii?Q?aLS2uukkOYsHo5c5pjbNef9IA1Ykk3Hnv7mxOfW9PI0kXMl05NB1D/sGG9Km?=
 =?us-ascii?Q?pqR6wdlQaGRSqOLyHyaMVZ5WSic/5F8OhtZ24N+rkDCMCnzAryNMufp1jxwm?=
 =?us-ascii?Q?xViZA1+/B6Sz+r/JNIrVhq4ZEoXbbRXHfF81zwvgIysbYxzj1tTdDdDfH8JI?=
 =?us-ascii?Q?rY1wDaWxIlX+GWWcWvJtESyBeVzxD+otMI2tefvQvsU3ihfjO/hyTZM6soum?=
 =?us-ascii?Q?AvjxIAwH19cQa1A6XG/eIhCjrmFflT3TT+GHw1haUBdBLeaHY0442e3ktEH5?=
 =?us-ascii?Q?QtoCW7e2hDTl/2BwTMBqCtCI6826ZF3ngbhofjN0xHSYZ+oWOHj62FeWvaIl?=
 =?us-ascii?Q?HAAgVa1h+tmYSdRRs3B/1Nf9a/JI3mKPHJg/w7BVRYq3wjgmdGZVee9jX77a?=
 =?us-ascii?Q?cIaqs8Xd1oTQoIgloe47+dgSo5nOICxy7h7Rvi10I6W1jTDgU2xhbbPl+dTU?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5iSSC6kKxGWFlygnj4E8QB5yKRMEtCg142NL8gEa5BmOZp2cgpg4YmKDgd/JpmNMEGrQ3uH1Iq67aVtPIlvoc4Pxwemqm6w/LRqo61VkL7OekxRQXfxBevgKWZs83EhemZpkncGKkzX96oT/OpPvXfgzdgepILxLFGsghD84wR8l37cYFQsrS9rNQ1MtV/k68YJjv50Yud1Q9+RcXwIqA+J/tvqT7OG/d49FDcskKd26t5nQKs5i2WPE6c+HYlIEUcyXYgASffyd4BMMXiCVFgdjA2l+QiXAe1KxTynIHMQj5pwIWB5kKK3Nn3arKl4fadquUI3EsDveu8gJFYcwztVpxmhT68LQsUfojmTJhPBfKtv2uXuZBF3azA8twBgP2QByiwnwDlLNlPe2oxoqfhwyTuaiOdqk4POpssvo9wcKCK5w07t/i/zsN5thaGBZyTojsJfd+9fDP/+9TJ/+7BafHgzAXiTHFb6GzJnPGhAhuWOefy4Mw89QpuJHOckBOmdDE/duca19B8zZtOuPpNAA1YvIn69vCLms37tu2RA8eRuIRmMisSc/cGbUEQLsMJAXlKVwy7oZnq4aPOjbXIppF+cWj5HJ5uNPR1I5T1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b643ae-e9e4-4e1b-d25b-08dc28b75499
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:05:04.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2stOS25cvsw8jm68Cp2EixiLZ3+WMTFD1qDl57zYZACb8oAOuebnNHtGGN2CCO9JoaPOQ85DhGqxupfZa+5rKPObAEPiy5wfI7UPVtFI8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=689 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080080
X-Proofpoint-GUID: C8bbNK9guF_U8VLRoO788wU9neXkfBOH
X-Proofpoint-ORIG-GUID: C8bbNK9guF_U8VLRoO788wU9neXkfBOH


> On Thu, 2024-02-08 at 13:55 +0100, Jose E. Marchesi wrote:
> [...]
>
>> However, it would be good if some clang wizard could confirm what
>> impact, if any, #pragma unroll (aka #pragma clang loop unroll(enabled))
>> has over -O2, before ditching these pragmas from the selftests.
>
> I compiled sefltests both with and without this patch,
> there are no differences in disassembly of generated BPF object files.
> (using current clang main).
>
> [...]

Hmm, wouldn't that mean that the loops in profiler.inc.h never get
unrolled regardless of optimization level or pragma? (profiler2.c)


