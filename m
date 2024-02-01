Return-Path: <bpf+bounces-20943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9284560E
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1D91F26D8F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B915CD40;
	Thu,  1 Feb 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8A7xKhS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zs5nBHwo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EC3A1C3
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785869; cv=fail; b=gLwWJiWr6N+FSJOX7cfn4sNbB591ucRXg5ElziQVlqtQjzK/8cZXIvvLw3IcDgl+hYzMgQLcTWmKs9FZK2GUcBiTDYbO0Mrb0pxM4N/QIfSft/58Pfvy0xYk1y6dGeP+zeFeNJJAzs45WSx8rbgc14WG9qkoMKB1WSG2MsmKp58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785869; c=relaxed/simple;
	bh=yF5EsJ0ZXxJ82nBAlKY9VSn1llGJ8+LivBksSlBX/mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=a73Y6GXqA8p0ax10+pRPMKXW5Tby6L3UxJlsG9XxdiWSkA1MZOF692EPCddsRhGb5SygWjfybIbmffaxz9pHM5MF0TlkrjBmQ8IgVUjAm/yMxV2fKpny+cL9g0LWqnF/nq4PXxOETD/yUoawHh7gnMWEph4VlOyQre7d/k4xTQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B8A7xKhS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zs5nBHwo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411AmvDo024227;
	Thu, 1 Feb 2024 11:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=0i4ijY2FmrFzSv+wNhxD1jEw2CikTLdeQGGEXZCF3H0=;
 b=B8A7xKhSpVj2eT5gDEGPI46RJXZB8r/kXLj7WbOFCE4uByceKBA7moK25erMMg1rcGOa
 nsc89YInBtLL4FJLuvj9his1Lm9BsnKp8ZmqGKZD9mT8quz6aVad+UuSXPkn/ltfgo9a
 vTCfyDTdixw45uO/lIFhJK/aqRo7UnqCzGY7ZWWAgv3N7GSjL1zPzyQptKfHaJU0ZQRj
 rB9qUEleswJqqablkZ6gvr6UCUzwgjNWhiyLK4yZt+WVdPYcYFePV1K2EZpUN16sZHKw
 6D/IwZKDlHEgy+w/0IY4H+RPlA9sHJAaX+6DP0Y7pYCALPYuQKLIREFJ3mgs9B3TdHVZ gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseum9jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 11:11:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 411Ad7j6016425;
	Thu, 1 Feb 2024 11:11:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9gg482-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 11:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y880itf04JL+ETKzsdyIgRUBHkS4bRkDoqHpGjtuwJ3IbGyFAagRvFHwipVtiB+o35pJijLnpUyKiw5uvz+SnkGFcv9DjiC+ObnzvsJHNnuH7hQRDCPiG6QywUICij2RXXp3w6C7N0GXSwfG5SgFagTekn2fUitWcoyb1yGwZ6q5EkXU7wtHVE5/Do/pFp2iTv5WGWfu17bKvkcCsibYtdiWh3inqNQQ2LQvcbn5FpWIxRDLZdz+s29aolygHwImvWlKwPfWBJNSAmMIT5CBi5NTknWHwZb5cc1JA4CeC16uTnPymQl1RO8F7puhmpVCiisg7FxENYt8/lAFPzrmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i4ijY2FmrFzSv+wNhxD1jEw2CikTLdeQGGEXZCF3H0=;
 b=Iv4MObG9mYc+odEgBeQawRiJQY5Er3uOOtUbE5aaouHU8SHAG+3JhumvAOJvXhGViDwGcISxttnRNpvPBaS/bV7Jmg1TXTeBJsDA7mweS4QddZEe9sPv12uYyy5yDKknCu97R/ale7MfAwEoeo3spbuNoKk1hbg39y40LbwgHS7kysMwi4+oClr9tX2Fmnvpau3BnAtjXa52zwZbladZHND3lACFcO0qNKXJ5R7YW/IsXeuFe51uBpF3skVXN1o67wbW6rU50kEzjB2DNyiKzZLNbML0VcaJBXFiPHaobwP5gZEwEUfjyx55+EnIYqkKZouO4kutCKEgqQ7TBRVjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i4ijY2FmrFzSv+wNhxD1jEw2CikTLdeQGGEXZCF3H0=;
 b=Zs5nBHwo/dgY8q12wdbjzCS8QFRwLaIrzGojSwJERVEnUud3QN4lEaXjBFhxbUrLgRJ3BwF9600SURlTU7A2z+SaCKYoipp8AjXoHXUMShUzIoDiKLzg30WWy/2j44aZE7m5NpYRJMaiuTz1KXdo3yGH7e/L53SmD7iGzO15xX0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 11:10:59 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 11:10:59 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>
Subject: Re: [PATCH bpf-next V2] bpf: use -Wno-address-of-packed-member when
 building with GCC
In-Reply-To: <aab2e90a-aa65-480f-8f08-186ebe3e81de@linux.dev> (Yonghong Song's
	message of "Wed, 31 Jan 2024 10:33:57 -0800")
References: <20240131094459.24818-1-jose.marchesi@oracle.com>
	<aab2e90a-aa65-480f-8f08-186ebe3e81de@linux.dev>
Date: Thu, 01 Feb 2024 12:10:56 +0100
Message-ID: <8734ucfni7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0172.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: b77c422b-c6b1-4ea6-cf2f-08dc23167847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g+q1J4524XfWQA9KhCfkc0acZFwU5ic7/T3CYqgFbYIZlqStiBbY0BTxXRiAfh4UKQ9cF0gVgn/nemKhraiT4zksM+FdX24/ckRSrI3d86FqP/dBM6T+WLAKrEco3VeR780McUFrmaj5/8bNaWa26J11PbsbzNqzX3qmvq55pqngwFkgiIkKGHvokyiNlQtRltVqTtCFeyVJO1Z+624ZEzMFvVlKf0FWRqL3Qx512hC5q2joVBv8yOOy1vH3hBioCqn9PKqOZTqNJYjZ83+Z3KgUd1TOJK/6Ea7LPCN7/YsDltdgLy821f8g5Gx+D827z38ida+cv4v/+Kmr2kySGzGko2YulDxwLijmq1V/u7G3CBXqZmFgRoWqdY6y38VYxrYjAapvmjNbZ0T+whSzLz6aNpGS6LuRoEiiPv+/j6Jy0J+s3aB4Tjo6omYBbu9UZ8CSmXX0hT1XhC+zLj8f7izoVCZb9vprja1W0eFW9vLybZssNXm/DS1m4VwzgdYN8OBDyklt1OkVC8X4TZWaF98noLczOb5KIc/QdMVqzQYKthd4iWEEctu/tBBh8UCKxFjqCA2aHKGDj7awvsxvmNDvmkNuYYIajxUQeQop5YcAotqNybAFpgoXwQR8yRmy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(66899024)(2906002)(36756003)(41300700001)(53546011)(86362001)(316002)(66946007)(66476007)(6916009)(54906003)(66556008)(6666004)(6512007)(107886003)(6506007)(6486002)(2616005)(26005)(478600001)(83380400001)(5660300002)(38100700002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RWKNxPBMInogJAmxBQKhODmstVmstdOX4tbx3UDWq3JjW2P02ae2fSSc5FUV?=
 =?us-ascii?Q?xYSV1r2WkvXWJ+w9edBJ2+CWfcrM8oawU+Srqhly4WSW4z+c1zH7W0qt9Y8k?=
 =?us-ascii?Q?uk2g5NOWs40PYGHUHROS2d1rHvprq+rQ7gNO3v5XV8DqEMcEjc51JXxdAVc7?=
 =?us-ascii?Q?Doed5M2dF9C79vQAH1cdWtPXLF9+i6j9nxb7jjAXQjtqnWW2uXRraXiqmmUF?=
 =?us-ascii?Q?6q0FuHJpzMeF6M+QMtQVaRqJ3flKd2UsFxT2MxkGrs/6z8fAMHm7YDn3F0QP?=
 =?us-ascii?Q?+2GuoU74D1dOfigtisNdY+AwvUkfuCP2quWolDULoDD6q5bL529MkWkN4ryE?=
 =?us-ascii?Q?OZ+Zx3KKD4wVfdVR5/Cp3lklJZeiYQh81ukbxDxYilznHiHdjmUclfHiZtfO?=
 =?us-ascii?Q?WhmFY0uLaegT7PSlNwIhNSu1mq9kiMXasADWvrmGW+E+7i42UgrtOMN/7TZ5?=
 =?us-ascii?Q?dPGQpEZq74LTnOenI1PbnkzP3By0kGZbpsg6JE1A7D9kg1pWA5siWYulk0ch?=
 =?us-ascii?Q?gnbOGyXkBLetv/kY1452qSY6wz8g8GGeo+bAtuPtEAv+gXmsPwjKX7P/hWvs?=
 =?us-ascii?Q?yCIIxvqvK13b3iyycIzHmHLLNgLKLjo6Y6ETubse1NFidFphjckYLADmINde?=
 =?us-ascii?Q?dFCqqQd2hyaqtilPwqsbZwS9DuISyUlVXFMYTTWkLDsUjb+jKV03VtKqEiM9?=
 =?us-ascii?Q?QkGVg0Ha2pqqmAyfkohklJLNjxHsQuGdYGD5SKIUrd93L+JOEC2wzZLC+x2O?=
 =?us-ascii?Q?s8UF4bRr+gwzsT3Zwu6viBuTrs2m1CZMRKsiLvEbcKdTOPX+BjIB9avAw3zQ?=
 =?us-ascii?Q?Vf39AxLB8lC4AKmF0hXgSMsgsgA5qTdq/UTsXtlP5b0zRJzfLQtGkc1puZyU?=
 =?us-ascii?Q?AGgjuEx2QuZscRMohxfSE0hpTmCgxnvZUONcmlg6c7zvalKDLDQG+L7Ba2SS?=
 =?us-ascii?Q?Phcw2xdBEbhFxTsv+YPVkKt/iqibtOTJpVHLta9yGpF9GpgJYt+qCQFlC62F?=
 =?us-ascii?Q?5Fwdy89H5RyXRdjT9YBE7bTcSfNFvUZXgabkS39Djni3ATzCb4S3hOfZSkIy?=
 =?us-ascii?Q?7lB105WLVe4Jb70wi/8OQkhR/ubGN74NK1rRd8moltIigntQiy2BLpmtdCkr?=
 =?us-ascii?Q?w4Z2vQGtskiT38anoo4/+Hvfi6/G3yLIZ7xSGFx72kgIM4GGBfehXiC2Jubr?=
 =?us-ascii?Q?VbOHP0p+gxd13QpsJOPeqcUzMHelM7B0yzF2RaF5KznxdWMSuiW4Mckh/xq3?=
 =?us-ascii?Q?P/cxsQ1egVHMVg2BC7r40YsYDyYPFBpsNRO5fSUkrnPNfuTVd6Ws9H9X3BwJ?=
 =?us-ascii?Q?M0ga+pO4ZC8pYX7zdmRUTSTz1Ekhfj+FDYghrUefGPHPs0BhyffVI7tqO6AU?=
 =?us-ascii?Q?nQSe6GZlyGOp3dPZyxPYyzcXcXJB+yaaWW71kMSyhqvm4eeR086MFdfZFLyW?=
 =?us-ascii?Q?GUMi/eSpuj+hARWNNl9X7n6u2yLRuMTCKr7QQEjcdKJ+nAutdYzmVL15mWVF?=
 =?us-ascii?Q?43ik7hQTzp0YtJXkMt5By2vVbKWZ56+XpqE4UgwySaEQItUDyno4P68PrSwv?=
 =?us-ascii?Q?FZwOhQeyK52A9+qidnQbIYPnwq4aMfg2xIZQX1u6eqgjksHIPo0nMRySeMPu?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i1ZADM4o3yi2eEHERvk9XG4OxRn5biTtG/4I1WpFQ3WI+PutEW8zEaFSH4wpi26wVqRDZmK1CgzrNKpmKB90dR3gBTaKwV2zDJA6GDCSuzBGvRAfpO03bPzzaADk5lXUV5aLNeq1OBjA9asRCWNPYfof+j0aLEUhLv52kxEdxD/05OhzH50DImyGuZdlVLWmIKhQ270f5cad62zRLYJy3FvfGBwKmNNDJq7CisB6KSlxNc8Zg9TFvqTxjx0VmW2uxa870iiJFdt6kHBKyh+59WaeROHqSdgg4Hu6SPqCKZV991omfPaYX40ye5755bnU3yA2mIB99AnqSH6gLA/Os/NrejnvnHdjVJa6pxD4KwPDQ8iRcTmKK2jA5XFgi9hvpoPKZ7bXeu/QwDeg3onvv0GVPWpfeaa4SHAX4V9r2Rbi3Izs5/+kUoDBm9HIjal/M04mwuu+X5PP+PGrjC2d9zIuzzW6zvEj5zwy88XyOT8yjdSiOtzl808pS3abK+gn9jdOBhk8LUeIr0u9p0ZhCYpA2GgEByyA85fQE9FiuKUI+DcxsokNA3F/GvUkMRv+7FgxnL7243jS0o47AUIYm8tgl2mIxrtlSWdn69U3CXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77c422b-c6b1-4ea6-cf2f-08dc23167847
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 11:10:59.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP7xyhdRECjw7mlBoep5rsU1CKUfNII4FQ7Xv2VX10EBMxpytFSnojmiLHqAkdcgP9dEsPtd/cu+WVw83QMp8WhQvuhY0hwZEn2PbQtd4uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010089
X-Proofpoint-ORIG-GUID: AyG7WnG5K_2taFAuXnodDkBH-Wj-WpIs
X-Proofpoint-GUID: AyG7WnG5K_2taFAuXnodDkBH-Wj-WpIs


> On 1/31/24 1:44 AM, Jose E. Marchesi wrote:
>> [Differences from V1:
>> - Now pragmas are used in testfiles instead of flags
>>    in Makefile.]
>>
>> GCC implements the -Wno-address-of-packed-member warning, which is
>> enabled by -Wall, that warns about taking the address of a packed
>> struct field when it can lead to an "unaligned" address.  Clang
>> doesn't support this warning.
>
> Look like this is not true.
>
> $ cat t.c
> struct __attribute__ ((packed)) Packed {
>   char a;
>   int b;
>   int c;
>   char d;
> };
>
> void test(const int *i, int *ptr);
> int foo() {
>   struct Packed p;
>   p.c = 1;
>   test(&p.c, &p.c);
>   return 0;
> }
> $ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --version
> clang version 16.0.3 (https://github.com/llvm/llvm-project.git da3cd333bea572fb10470f610a27f22bcb84b08c)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/yhs/work/llvm-project/llvm/build.16/install/bin
> $ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --target=bpf -O2 -c t.c
> t.c:12:9: warning: taking address of packed member 'c' of class or structure 'Packed' may result in an unaligned pointer value [-Waddress-of-packed-member]
>   test(&p.c, &p.c);
>         ^~~
> t.c:12:15: warning: taking address of packed member 'c' of class or structure 'Packed' may result in an unaligned pointer value [-Waddress-of-packed-member]
>   test(&p.c, &p.c);
>               ^~~
> 2 warnings generated.
> $ /home/yhs/work/llvm-project/llvm/build.16/install/bin/clang --target=bpf -O2 -c t.c -Wno-address-of-packed-member
> $

Hm I can actually confirm my local clang (18.0.0
586986a063ee4b9a7490aac102e103bab121c764) does support the warning.

I should have been confused by some other warning.  I'm dealing with
many of them.  Sorry about that.

I will submit a patch to remove the !__clang__ conditionals.

> But each compiler internal diag detection logic could be different, so
> it is totally possible that gcc might emit warning while clang does not
> like in some selftests mentioned.
>
>>
>> This triggers the following errors (-Werror) when building three
>> particular BPF selftests with GCC:
>>
>>    progs/test_cls_redirect.c
>>    986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>>    progs/test_cls_redirect_dynptr.c
>>    410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>>    progs/test_cls_redirect.c
>>    521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>>    progs/test_tc_tunnel.c
>>     232 |         set_ipv4_csum((void *)&h_outer.ip);
>>
>> These warnings do not signal any real problem in the tests as far as I
>> can see.
>>
>> This patch adds pragmas to these test files that inhibit the
>> -Waddress-of-packed-member if the compiler is not Clang.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: David Faust <david.faust@oracle.com>
>> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
>> ---
>>   tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 4 ++++
>>   tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 4 ++++
>>   tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> index 66b304982245..23e950ad84d2 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> @@ -22,6 +22,10 @@
>>     #include "test_cls_redirect.h"
>>   +#if !__clang__
>> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
>> +#endif
>
> So I suggest to remove the above '#if !__clang__' guard.
>
>> +
>>   #ifdef SUBPROGS
>>   #define INLINING __noinline
>>   #else
> [...]

