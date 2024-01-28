Return-Path: <bpf+bounces-20515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C642783F54E
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D476282AB2
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C242030D;
	Sun, 28 Jan 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FKr9Dfuu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCQgOVnm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21F200B7
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443093; cv=fail; b=YsuAK+2dC2MmtWdXM7UQhGEtrgMZq2eadZl8RSsKxQWcvhACKsA4YiFUWgzzzjhbZb8nfdxEzLN6sm0omNdqgwNVz31sUwZPURNBI5YwQ8WIoNgAGF78gmf3lv7upXSVwlpEbQZP4tIhWk1eeH46by6u8DFSrqwWOElUrSDlmXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443093; c=relaxed/simple;
	bh=O5GrLWQy1qUP+cro7y3RcR2jSbB1T3k5HGViASs12eA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=rbvKCM+5UhDbrnyBVad7lOxhSKm0Qjf3+GuSVyceSy+RYZyVyyMiCHsWlG3+2zZYRFCt3v1aNW0Nv+t0gZPQuHdRkDMbuHfubRzFSBcmz6MOyNAYmh6E6JITBC6Kp/lFBaf8Ho8PQoLVNQ+gzb6F+MDyDiKQN3szootXIHhZdwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FKr9Dfuu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCQgOVnm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40S6wckX023992;
	Sun, 28 Jan 2024 11:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6OWBSD+orOpsn2cxwQmbxDxRaregPrPLP0kU42baIsU=;
 b=FKr9DfuulX7tyie3V+qyv638Fu6xQeg9fGbyzq7t7JZB5cTRPy/4XxHZ9lFiYdCIcAdT
 0lmeGlx2tG/Do4Jv6T5CDUK2VCEbxrPRqjKV58tUpHBQC8+8m4AW4rSlBi/HebhlEc53
 FcZLKXg+YRjVBXPF1noTXxpb9xrPhCpEAi5Fz8zrfB8+aHtBLvcXJM7UfTHmKStgA8sN
 8M6tGoURnhxkE+TdP03oouNyiirn2f7OpWSSshMVd2pjGPoWSNoBH2/jn5evnVPSRgiB
 5U0gdrBXWW6uhzz54YBPn4U12lz8qzfFC4XGPe205CnscOdL/mCk+H3yPXq19qqOngHT VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2a361-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 11:57:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40S9YHx7040141;
	Sun, 28 Jan 2024 11:57:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr94mwue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 11:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JETIonC1KDRTftC1uC2H+6c5sa2lbHBxTiPTsCcfgNSGaXpHdRjdpU5S/H9iNDBkWopikKPBaqLO+9PrDNSxBLefHnBiJaBE3K/p8KGcGk8WHZtQDcZREc7DnAeyBN70bF5M6L13rctLSueN2UXwRJupnOolJrPzN/NhJVM/i3ZXM/VNG60Jxf5K3b8xSz4I6MW0yvB8JhwhV/PYsfTaZCoAXw0JeDOxue+pmsQiTNdcqaS5C5pTQ1uZWYcHgwpzvN1chq8h6IelU3V1pfoL9KqQ5Fv9m7lyPHqMVOT8hMjbk1D9H7TRl9xSi/+WSh6xox3Ryfy5JDre/EVDIlbIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OWBSD+orOpsn2cxwQmbxDxRaregPrPLP0kU42baIsU=;
 b=dkhUvSUPdxhphf+1QVdwePHDD+R1MdFZNRmNKIxgTrjYRg5lPD2hO5vpd/uJRHN4R7ewajwvd4Of6bMXoh4djbGOZs+50HgaxlefxvTDVBdvfHtZ690IKwbDrxvSBcasgYKKOxw+LRYn8rxGvoiFoR/m5ag8ly8G9p5rqZfbvUrYwKZXtuF8d7VWhxc57vae8oni+hY/VtVTF6j7xjbiBuDghSlGBtbSnR02XJNDBU3FVWXkNd8rmAH7zb5EEg0CGj7PYYvvkAh1D/riz0ylX0HAKJficCwyMroNGEwRp+I+s2sWvNzUDcnMm2njNWgFyw4Fdoqi5p7A5i4W3UKebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OWBSD+orOpsn2cxwQmbxDxRaregPrPLP0kU42baIsU=;
 b=YCQgOVnmwLr8xTRuQNRmj1dLBuJK3phpMcjyMeO6yKwvXowRTaQRs5Fwtlk+JsXA6cL0nwFnQXoCPuhqaO/4/K1LGJif1gglkCTpF/H21vNsY3TD1u5+saF/h1eABlrEdv/6g+UDjbbTFEGPUOv5+iTGWcFW3jfM8YgOz5yFFpA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 11:57:56 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 11:57:56 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, eddyz87@gmail.com,
        cupertino.miranda@oracle.com, david.faust@oracle.com
Subject: Re: [PATCH] bpf: generate const static pointers for kernel helpers
In-Reply-To: <e4493711-52c9-43fe-b1b5-4bf210b768e8@linux.dev> (Yonghong Song's
	message of "Sat, 27 Jan 2024 12:29:58 -0800")
References: <20240127185031.29854-1-jose.marchesi@oracle.com>
	<e4493711-52c9-43fe-b1b5-4bf210b768e8@linux.dev>
Date: Sun, 28 Jan 2024 12:57:53 +0100
Message-ID: <87ede1sm9q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: 05626d68-7ea4-4d0a-69d3-08dc1ff85d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2yUxfagoFVueJKgGzfsSbtAhCinn+d9LDluaUpYNGdxzFNA1pgD9PwL/zTnYYJaoPNysAhQ5VrwweRPzuQ3V4HseWlraAEnrnEro4MNwu/ZHnFCovsQ7xBeLMI/Q8vqWCLMpw/67GT4da4CnB2gMVwD0iW8uFpfvvoAjLq67gXyHPyCX0vTEkYw/Td/4/q6AIOXm+ib3wyuqrgl7spK+tAODuSDvRitgaIzJ1DESvbp6TUw/xCOnCQAwc2eOcfl6A3bhRMLwgFkRfD1h6s4/NI/GOB93N9bFsikTuOK1PziJzwtYNVcH0AKPyIhgyR4BE8yK6SrGFjr0Wx3b6jp9rh2ClNslhrzVG1aotrgnbjX7OYKEBEZMU139m/f6YFHeIYTgxIfi0uUFHvEbC44wWujWlRxrKQthjdgAewg6BmlhEpcEy3k/0+r0sA0K42r+8MaGwBF06SPlcyB/LPQ0XbqCabBIwa119TMsO5nOoZ3DPU5sjrC5CRvERrxlLmyWj2n5Pw2/l/tU0mp4rRzMera4rus7qzYMcsGb9Cx6W96y1huiZ1FIn5YKzdzOwxvRk6CQmzNDd4xm5VD9MFEU+P8meZMEum8x48VEJybrFSubhuq7ud1PDNSsOZAoaABX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(86362001)(36756003)(2616005)(107886003)(26005)(38100700002)(6512007)(6486002)(53546011)(6506007)(2906002)(478600001)(6916009)(6666004)(41300700001)(316002)(66556008)(66476007)(66946007)(8936002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6wLPbODtHtsl8zh2S9Er/SaSuMI3WjKbkdwAOAmLGyAXMF/8SQQYCkdSUO5q?=
 =?us-ascii?Q?fPfrDXDXZljks5De9GhFHi8kJcE0hKGAZLdVHiqsAhNGhB8RDH8GjP0/Xsc9?=
 =?us-ascii?Q?7Jb7ia5DYT7KJXzuIVBwckVSgcSwpifi0OPtXeZaJxFYcA1fYss9Xse/qm5B?=
 =?us-ascii?Q?oCOvKXcWMPRfXa4j0+lXaC5RBf82ygmkpL/cKm4G5NThM7r/ppB2dZRj6mao?=
 =?us-ascii?Q?aSEBiAusN0l3dbGpKTJfhKCuV0y4qfLq1zr41GI3kj/6upt81GfNq/YjM47/?=
 =?us-ascii?Q?3yxtiVpxQl0EOb6GDFu2e6jqsaiOxic16ryiXn6m5eLMhPjClTfAoTF3BRpr?=
 =?us-ascii?Q?5zmkEjvy13iRjRpVeh1Y7xuQ2mY8cz/k3Ew2MYKbOYC41qBeSiM3EPdzmak+?=
 =?us-ascii?Q?RGMX0/i6n0CZDy9hqvw7/zIlWKQDKsDqBBo8xkDe8mZ+684IH9OorGldRl86?=
 =?us-ascii?Q?pviQm3FMVwkml2GxV5TFg7kjaoqP/VL/bOoYBJe+ge1CM5mdIrM3ziT+AplD?=
 =?us-ascii?Q?RPK5Jg5XaTMHrYCaSi/4ycc5gAX94E8d+nJPHzvDYkhwycw+UIrWwVB6TaYd?=
 =?us-ascii?Q?TIqIkDFrKVZOmmKw2l1NILOxL2uzfdzpdQ0SCru7TDSsWnxo2OzpW2qGZBj+?=
 =?us-ascii?Q?IvpEElHuPIC1BIV+AWDm9tY4zJecTfU99rxdhxW31RreoDYFXHTbNNWbWOAe?=
 =?us-ascii?Q?ZU+gowGKi9dzv362Prwb3hHuR4hS/3QaIoHZvRkZbvkG0l1f8p2Pgy/+kmu9?=
 =?us-ascii?Q?pYSIStNo2TPvG7aIR84RiFFkbVjQGQHdl/nibG3Qc4j5HdO+j7UuR4R4134D?=
 =?us-ascii?Q?4xtlwHaUO0nCAPKb85EaKnWBlxy402vJeqn8nPOP40N6pG3iVX4/chLfUuT2?=
 =?us-ascii?Q?HjwcqMxLt4sWC3dg9gIA/ZbQ04KzXt2v4GFxYJl5/AqL0xktktQ2Etzi0oyo?=
 =?us-ascii?Q?fiFxfY5hpBx0vWTnbC4HdcEe7ACJ0DKoP0zp28RP1smLbAq56+6mFlMxyoQ/?=
 =?us-ascii?Q?vKuvWmt32eWmRMu/qA9R4bTERY00GdA4lKGCj/U7fZ+jYcZFqiw2kl3FOGAK?=
 =?us-ascii?Q?i79L2SnbF30+CHdBvYPAdjRVwAMH0vhqWadqWbF3P2HfUO0ShkW/ZBkvQ5Vu?=
 =?us-ascii?Q?nZcMG0XX/aebiL+8PuUR6kOMmR/PNKlTY7iZYTY7a1Kj9jnezlxHFIrGXLza?=
 =?us-ascii?Q?T+LjIdfNhhI8dOB4FT8KQTQr+KUg5NxduQQWduWWpIjImuudU+5Rht+2BcK1?=
 =?us-ascii?Q?s7zrdXISdvtmYC+G5fgJ6hn4r8Pws1PdUdhjU7tL6A68FpCoTilTcVTNfaH8?=
 =?us-ascii?Q?1tvuahUIowa7PHZnQR8CogleZT1UauYKbhkJAPly5D+swjt0wH9ugRQhQm88?=
 =?us-ascii?Q?ASoBPRK5r66dY3XfmvATI0ggmL3+rWkYp1YplaBzufDwh+Y4DmJEtGF2MbBR?=
 =?us-ascii?Q?3M7d3sJF10anfkQ7dnDprnhk2d85cktM+dlhEQ5NokQfKqTs/KEy0SuRbzto?=
 =?us-ascii?Q?I59n0IuQUKDENbnNJV6DSY+52+mhqz2PqtuSe6+cCjtDzCwLdsLHYoWesR/B?=
 =?us-ascii?Q?IQkN8zFZJavBg9OPk8+ImKCgI5WcKWnUhu0J9fdARnFMJD2QyuYOxFfQ56M4?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bs3jL/y5oAngDN503PgcuvtYXByL/3qxR38/30hyZKUGXrT+9UWW1pD67J0fUVFES0MFOyS8vantB4gIxVTVgdw4CvF/KkO8nYzgeX5r9PYguwyFVAvHrM7b7+SZfP8jCxjKGsNqaRhWOTTNrcixZcwgv/TOaDVKAIFyFhwxo0OKCNk3fTvtIdZ1WbKar5AZVrB9wO9ooBY/vxGvokdgnGD7Z4FgBBRXzYYZii+2mCYw20xtF9Ya0t8v3MA25RgvdbHOI5S0TZhsGtIVBZ6L7EDkyDLs2drrw/42HzqiQH78yDdofqaIE2CeANx+pQTE2fnA6z4jlSdM+j3HfmbNHytq3BMU1NuwtxciDwgKYcsWLsF/VpDZBtTvWTe7ZoKbvQzHqaxGpXfBec3YfJFhKVhvKiBPYz3SPwEfQx9yX5wAIr+woPDsNwTvr5m1Dpz/O3qGxZ2nI9o6QMjPgciB0qx5mcVmj2PRcDmK7GeGPoZLL3wyXrv8la5gQvuAGKfqRuJniqIVCMPxz9Lv26EiuRV3e7itxaRxiPWHM6zHWd6cBGXGmeZShbVoHzsWGSNffLdV9qbw6jJQ7AD5x52j9qY8bZnb7jMidbt3bkGpqS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05626d68-7ea4-4d0a-69d3-08dc1ff85d95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 11:57:56.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSu7JaJDOPEC3EgPBn+P20lptIT7wMiJuuP1O0yTKc9veMli/bBxiq08wuGeGrNeiEXqrnJfReMaG2N894RwubmKrNqosp0OfLgug8b1xjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401280088
X-Proofpoint-GUID: sKNiPd6KE3e2YgnGqhC3LM3UGhdMtD4T
X-Proofpoint-ORIG-GUID: sKNiPd6KE3e2YgnGqhC3LM3UGhdMtD4T


> On 1/27/24 10:50 AM, Jose E. Marchesi wrote:
>> The generated bpf_helper_defs.h file currently contains definitions
>> like this for the kernel helpers, which are static objects:
>>
>>    static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>
>> These work well in both clang and GCC because both compilers do
>> constant propagation with -O1 and higher optimization, resulting in
>> `call 1' BPF instructions being generated, which are calls to kernel
>> helpers.
>>
>> However, there is a discrepancy on how the -Wunused-variable
>> warning (activated by -Wall) is handled in these compilers:
>>
>> - clang will not emit -Wunused-variable warnings for static variables
>>    defined in C header files, be them constant or not constant.
>>
>> - GCC will not emit -Wunused-variable warnings for _constant_ static
>>    variables defined in header files, but it will emit warnings for
>>    non-constant static variables defined in header files.
>>
>> There is no reason for these bpf_helpers_def.h pointers to not be
>> declared constant, and it is actually desirable to do so, since their
>> values are not to be changed.  So this patch modifies bpf_doc.py to
>> generate prototypes like:
>>
>>    static void *(* const bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>
>> This allows GCC to not error while compiling BPF programs with `-Wall
>> -Werror', while still being able to detect and error on legitimate
>> unused variables in the program themselves.
>>
>> This change doesn't impact the desired constant propagation in neither
>> Clang nor GCC with -O1 and higher.  On the contrary, being declared as
>> constant may increase the odds they get constant folded when
>> used/referred to in certain circumstances.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: alexei.starovoitov@gmail.com
>> Cc: yonghong.song@linux.dev
>> Cc: eddyz87@gmail.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: david.faust@oracle.com
>
> LGTM. Please add proper tag in the commit subject, e.g.,
> "[PATCH bpf-next]" instead of "[PATCH]", so CI can pick
> up the patch and do proper test.

Sorry about that.  I will use the proper Subject in future patches.

>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
>> ---
>>   scripts/bpf_doc.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index 61b7dddedc46..2b94749c99cc 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -827,7 +827,7 @@ class PrinterHelpers(Printer):
>>                   print(' *{}{}'.format(' \t' if line else '', line))
>>             print(' */')
>> -        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>> +        print('static %s %s(* const %s)(' % (self.map_type(proto['ret_type']),
>>                                         proto['ret_star'], proto['name']), end='')
>>           comma = ''
>>           for i, a in enumerate(proto['args']):

