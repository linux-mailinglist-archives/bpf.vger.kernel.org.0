Return-Path: <bpf+bounces-8557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5750788297
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B541C20F5C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC1A925;
	Fri, 25 Aug 2023 08:46:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B401C06
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:46:43 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD7E7D
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 01:46:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P7guDp018672;
	Fri, 25 Aug 2023 08:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VrKEXrjtmWSMPoo+Xt3jCJF+iaUAcotvBXaQWNrS9F0=;
 b=YN0UQU1YXXRQoWKIyDazfe1OHK3lhu/xOBguDiUKKt7NuY3Ki2r0qdEMiwXXpyBPrO1E
 dG9P4aY032K3gKLXoZxwBttfwWZTcEteqFYe7/ckV4+9YiY1ZqJIi5dq0wsKtds69qfK
 SoqWCm2C5BjswWAYD3zr27aTMnRxblo0r5zVQ7NDuR0MfeFiAV1TGepoJb13IvgkpZPN
 kVDDluwRQtIvSm2VkARgVwwzdmWLsgR5HSMy7m+iBl6Mbp7cZcrWmY8RZHfgSW64tlLr
 pMUbAxoZI1wu1p77ufy3TDQml7NoHUK6rvDWn4gw+zPbvpihnNaTcTkYsDqoD/KIUc3q 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxnvxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 08:46:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P8ESNS005879;
	Fri, 25 Aug 2023 08:46:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yuaxy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Aug 2023 08:46:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvQo/ditXZdR5bAcLT3D+j+wGkb2qyn7Job9/uq5QHZASAN1Qod++6OJvws3in8bT/st6GfWNlSetTwEgZdcmeC7JrevKlFwBpiEQLrNG04JQnjeXurSBsvIjqxJ8zJPCLIewqZBW/Dmfi1C43G4lLQsuOpEn3E7YnLGAz3Fk7MXlus7bYcX6XyNNKj2LBWW70mRgCopcBhsxORvQr4pSPSypK0oBZ2pDC7DSUpELPUrU5C7HjwbeXkLvACmSm5eaZsgZJ63ETPP72Z8jj0/p31ERzlL6966e+AYzCSavGZYVxAzuLYNxlodZhvis0lEL+CTqoTs26fPaNs72aq/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrKEXrjtmWSMPoo+Xt3jCJF+iaUAcotvBXaQWNrS9F0=;
 b=VY6cYi9Op2C0xR+G4yMdZ8GaCWUYTCfs6HmES0x5LdFdbWtrIgUnM7SnF0ZBTF+oUzpcjBlQSU5wwfbQBC0qS+aDHsb3YaHF4tsPReOtmkax7gtithALHBY9IxWq3TEeHdEpObp8dNw7LTrWcXlBT4DWR/1dYVNcw0F/RZS1sOK5ceEcd7ydbKMXykjEWQpn/PpS7+Dk3zZZip2EOY/gKUeU6QCrG/Ow9T91SGnyrXIJCCbp0V6nKYFzit5ZyhuHpbge5vm+vSqm+r5KtHayApZlNnhbvqe+7G8H6/HkM61at+KfAofrANzDV+4T8JeTPUJvI27YU4NZjN+kHgmMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrKEXrjtmWSMPoo+Xt3jCJF+iaUAcotvBXaQWNrS9F0=;
 b=XlY3uWs9RN4XsWw6UGTDTkBTJ37aM9nXCu6WAyWqzcMkyGX0J2unyBXDCAuVjDUme3QIoEFzKmlfXsd6K7FbaQzgBLeHMmY+IvW981gm9CaVz2JNvvtsclZKPc7+rftCFF3v0MMon2HIRGdBfx9T4NFP+akdtFiTUul85NEHN1o=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4119.namprd10.prod.outlook.com (2603:10b6:610:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Fri, 25 Aug
 2023 08:46:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 08:46:20 +0000
Message-ID: <5af91869-61ff-c3cf-c292-c8f10accd4fc@oracle.com>
Date: Fri, 25 Aug 2023 09:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 bpf-next] libbpf: add basic BTF sanity validation
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20230824201358.1395122-1-andrii@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230824201358.1395122-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bf5b54-6104-4809-57e0-08dba547c0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xj7Vw//nN0hHgFKgZeCmQ7kfHEXiX7lGdaheQnUR16EcF/5UHiz3Mysb0tcjXqDxTer7aewoNYyQ0wK79C2VsU6pFmLOvXkM3+s73h7AQcRBStKkmHtXXYgeL6PGyTu4jrWY9OxXVHd9fKQ6cwBO8LmQaFjXLYmjPNLykzxYuw59Je0fpFpb6wTGBymkjWEau0DmQdZ5xmv31uGdsyI/YcRD6/Injwpz7h99z7ws1Y4j7GzkX1uZlWXjcpozTg7Wh8kk3AIeEgMYXdKffeBMtNe0zYm7BSEhdDPS8M7hjRLk8eqC/pChLbJh4RwWCNUmcQwoFcisSGsgcvurhvbmJJy29KqVP+s2KHzEbJ/4PxLj4qmK4xjVCm19nOKdCUOnSi1qX1oASdoFFQoP38C26R/1YfvkcuprvTT+lPaAXHC2DncEDRYWcbV+GZ6rlqAbmEfPGxto7rwoYPnWwYbYYkLuDr1AXpIAS1Jeq4IaeEL/q+CgpCDDDT9UDOAsM+aqKBekVRMHgY0CTll2145QYMGIHwKQvoXRDABbjL+shdA/IxZG00ZF/KJwsQm//Sa9I708VmbZM61CuOf7o88nogqVvD+hgtLtwaStfDLbkokpypJH7gZQsaEr5L3RzQhwAfkltRHn5/4IR8Z7j5ZXjV7frmFAQh3R9jO4Vn4dw2w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(186009)(1800799009)(451199024)(66476007)(316002)(66556008)(6512007)(8676002)(8936002)(966005)(66946007)(4326008)(2616005)(36756003)(41300700001)(478600001)(6666004)(53546011)(5660300002)(6486002)(83380400001)(38100700002)(2906002)(31686004)(31696002)(86362001)(44832011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEd1RVRyZWtzWnpuNUh5RTN3M0ZDY0MxaW5aRlpMN0xwbU9jZVdZRzhkTnR2?=
 =?utf-8?B?Mm04VExGTGppOUpIQjk1VHUwV1BxQ0E3V29YSHNhVEZoU1N2cEJhaTRKVWJI?=
 =?utf-8?B?N3Iyd2RXU25mQU9tNXRYQTlqT2RWUjd0ZWtQa0tnYzREdnNtVFdZc2RHWDFS?=
 =?utf-8?B?VEF2MDZwMUdJSDVuaTh0TWJyWUl5cUVQM1FCU2pZRUZXa2hyVk9VNXRLK2Vl?=
 =?utf-8?B?aTVGL3NUWXpSc095RllUREpYQWZzYnI3bFFmLzdJTDl0TGFrWGNuU0R3Q2VF?=
 =?utf-8?B?S0RPNll2SUVZOFFKUUo4azdFc1M3K0NhVFhUNVdWTCt4K012c2dFK1RuK0oy?=
 =?utf-8?B?UDdiZFV6QlpjbnI1SjZxOEd2VFR6T3l6VFFnbmRmSEtYVHNHNmZ6cFY5cXlx?=
 =?utf-8?B?bHd5bzlHOFcrTEtxSnlxMDIweWdXTDIzczFLZFdGeHNLeC9iNkhETTRLN0dw?=
 =?utf-8?B?R3JkZU9FcDFmcmRablVmZUs2a2lKd2MyZXl5RU5YZnVOZ3VNL3JlK2dMSlFZ?=
 =?utf-8?B?YjRiWVJ1RTRGNE5Qc3ZmU2JiYklMYy8vNUdEZ2lRRC92K3NNVUE2L0taQ0lS?=
 =?utf-8?B?MVAxV2hjanErbk9ySFhYOW44Q1hmWk5rMVE5TklISStKVTZWbmhQalNyUm0v?=
 =?utf-8?B?bUxRTDdsTVBnc0lBVUhwajhQSEx5WjZ2bjZaQ3N1cWgwczZlL1dObnZoMTJq?=
 =?utf-8?B?WjBqdnpzUFo2ZXd6YTF6QWRsWTRPVE90dWY2bndkMVBpcjVna0RTTGJac2tQ?=
 =?utf-8?B?eEJyY1JFaUNaZ3JqTFJyMFpxLzhOeloyYjRtNmhEbVUza0JNSTk2RTZWZ3pM?=
 =?utf-8?B?dkJCa0dSVDZiZXAwNXVFSk1OcFNrc2pQT1RhSzZyY0NhM2NWdmNxa0Qra05T?=
 =?utf-8?B?UE8wc0xhMWh0cEZ5eWl0N0dGeUEyalBwN3Z6aHA1dktkbDVveGFBWmd2eFhm?=
 =?utf-8?B?RTZ4MFFETE0rVUxoaWt0R0tNZU5VREppWlFqYzE4SWQvRVdCTHlxdjNhS2dl?=
 =?utf-8?B?WTBHekpwNU8za2wrazhwTm1pNmthdS9RUkllZnlBaG5DckRRdHBNUnU5V29j?=
 =?utf-8?B?SVNBWVlWZTJ5QUdIS3pTMmpNbkdhbUJqaFlkVkhxWkdBclFIUkhkM2YxNnFD?=
 =?utf-8?B?VjhqWXNkWUZ2MzVlQTd6OTVBMHNZLzBTUjBVSTdBeGV0M3k4ekloaDJqRDVx?=
 =?utf-8?B?RXBFVklqRGVVRVJUWHl4cXhLOFkyelNDaUdHVFl0bDJaY2hVbkQwTUNlNG5Q?=
 =?utf-8?B?b29qRTAzekRVbVVkeVNlUUE4M09laEowdVY5V1dBLzZzandDVFlwTmRVbFhq?=
 =?utf-8?B?TUNGZ3VHTy9mNG1NaVhHTitLVnBFeU10LzhUNDAxNHZNb0JBYnpybHlxdjE2?=
 =?utf-8?B?VUxxN1J1bkFsaG84ajlVdHgzQnRQMmc1bld1SGF0bDgwTW5jMm9raHJDT2lW?=
 =?utf-8?B?b1ljSTJWTGxHSFMyb0c3cnFIRHVadFlHK0VZamRVY0xwQXFzc2RYNDlmVzZG?=
 =?utf-8?B?dXgzUVdiSXVRU3hqclVsOHpIa1JVWWMxNFZhTGQvSWZSR0Q5Z3B5MGE3YUoy?=
 =?utf-8?B?d2crUmFOM1p0OU1va25TRkh5TDFvaUJGUWF1eThEOHVYR0tHd3paa3M2aGNq?=
 =?utf-8?B?TXU1OGd6UnBGM0EvamM1NmRWZFBQZEtPVXN0REZ0QmVhV0grNWlFM3cwaEsz?=
 =?utf-8?B?dXVQeno1YVZpOExzSUlNeHo1bkNOYkl6QjkraHUvWSttcDhrM2ZOZk9zOGU0?=
 =?utf-8?B?Q0p2YlRGTjUrV1o1L0ZYUnJIbG5aLzlEYlRHSEZseDFEYzdxN3h0TzhYQ2N2?=
 =?utf-8?B?Z3dka0hXckRDVlJITGx5TFhaakNEajl3bWttTHA1RUR3VkhBNjJIREtRa3Q2?=
 =?utf-8?B?bkhnakpKbDluc0pMbHIvcU95U1F5YkxVS0tEbXYzdzl1L1I4QWt2dytLK2hm?=
 =?utf-8?B?ZVkyaDRPQkpyYUVJUzBZMzZ4S3NVY29Wc2xGREkyclFQTU0xTkhON3BraWF3?=
 =?utf-8?B?YWpkaE96cCtDekphVHFmdzVKa1VxbThCK0tEUWdGazNEbGJIVHBUamdYWFdU?=
 =?utf-8?B?bUxBemxieGphVG91aC9aSUxFeWRrNGxsTnY3OU1qdFJIQVBMakpUeWZxOWpq?=
 =?utf-8?B?clloY2RMSFNCZ1Z4VFgzclY0SE5LNG4rbWd1ODZkdXpWQVhWZzBhYlhwbkNF?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VoHBdzT2imj7XfIgMwve86kOy0M+CNWz397A0RNgDbNY8q9mEnKEAF+s00lS3ars5ic///ILkI/gy0205/w5j2P1+hjobOHzNqy2rl9N7qO9VWORBvjtBlqXvuyVcUPh5U6R8bMXTFd6lInMeyvs4F/IKU+9+YMV5MaH2EyK5xcrC3tKCddD178ObEoBWciqhf03QssO6sXBqm4tb8AzzoQnsmCp9cktIsxyh3mDVWFWaIDR0cnsrXKiXxiPq0NKL/cio4RFL0lgdsTrLY6dEej57Bi4ImFFuStWRR5dsEd8OoCpQbjiPa8hlR7wbS5LHWG9j5Nf4w9Ic9XEnIsOegDkLL/RDm3i0VdfDHbNzUUBHfDFXjjDgDCQt9P7DQPUOEjCo/ziV13LcNASZeJIKVzdwLILS1X/TqjaHnbP2ybBniPaPezNuI+QRtbXQVHCjj8PKQqhTE8oPDUXdQjGYTkqeXsiHdIcrVWvtzkMy3ke7R77f9CFJJ2DM5VNwmuPSeBSvXSQekZPYfp05H1Bm0Q0nRIP+1vG8rQiC8e9rhqHVs9kN9QwxWpMm9iHXzL52RWmKtYAdL1q7mMzJPQCISYJUGgVB1BN67Hs8xLpHPxTEdFGxdpZegRua9swDg9gD9WXbR7wbhALHFQ3QU57rJ/wNucJUnNxC9gohaPZobmJDjobzmHBThlqQUNITS6ergoE7KUebKGia/gUOVtDUQCwhH6X/aIlc08wFsrizf1aJfUhgoF9EMHFre8NVzzGl/3HY9MsJ8jBJjrCi8rgSf6xX+2ydjWV4wZqysX6tX5VF6q5+R2A3D2hMgIw49W6mbwBHXkMPxi+jIumM7xHtgFOuKM59mmIrepFUR9RbIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bf5b54-6104-4809-57e0-08dba547c0b6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 08:46:20.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+YpurwTezAaGriBAJwI6zjIQcwQiIyb2OHk3+U7KyXCr+faS+xi+FyOfkE2mSd6ha/UcE60Bd8YtO5j3qZIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250076
X-Proofpoint-GUID: iK-Cdqf8kKEu9jlOoG5AgkJ7tefrhvnl
X-Proofpoint-ORIG-GUID: iK-Cdqf8kKEu9jlOoG5AgkJ7tefrhvnl
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/2023 21:13, Andrii Nakryiko wrote:
> Implement a simple and straightforward BTF sanity check when parsing BTF
> data. Right now it's very basic and just validates that all the string
> offsets and type IDs are within valid range. But even with such simple
> checks it fixes a bunch of crashes found by OSS fuzzer ([0]-[5]) and
> will allow fuzzer to make further progress.
> 
> Some other invariants will be checked in follow up patches (like
> ensuring there is no infinite type loops), but this seems like a good
> start already.
> 
> v1->v2:
>   - fix array index_type vs type copy/paste error (Eduard);
>   - add type ID check in FUNC_PROTO validation (Eduard);
>   - move sanity check to btf parsing time (Martin).
> 
>   [0] https://github.com/libbpf/libbpf/issues/482
>   [1] https://github.com/libbpf/libbpf/issues/483
>   [2] https://github.com/libbpf/libbpf/issues/485
>   [3] https://github.com/libbpf/libbpf/issues/613
>   [4] https://github.com/libbpf/libbpf/issues/618
>   [5] https://github.com/libbpf/libbpf/issues/619
> 
> Closes: https://github.com/libbpf/libbpf/issues/617
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

few small suggestions that could be in followups if needed, so

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8484b563b53d..28905539f045 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -448,6 +448,153 @@ static int btf_parse_type_sec(struct btf *btf)
>  	return 0;
>  }
>  
> +static int btf_validate_str(const struct btf *btf, __u32 str_off, const char *what, __u32 type_id)
> +{
> +	const char *s;
> +
> +	s = btf__str_by_offset(btf, str_off);
> +	if (!s) {
> +		pr_warn("btf: type [%u]: invalid %s (string offset %u)\n", type_id, what, str_off);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btf_validate_id(const struct btf *btf, __u32 id, __u32 ctx_id)
> +{
> +	const struct btf_type *t;
> +

might be worth having a self-reference test here to ensure ctx_id != id.

> +	t = btf__type_by_id(btf, id);
> +	if (!t) {
> +		pr_warn("btf: type [%u]: invalid referenced type ID %u\n", ctx_id, id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> + > +static int btf_validate_type(const struct btf *btf, const struct
btf_type *t, __u32 id)
> +{
> +	__u32 kind = btf_kind(t);
> +	int err, i, n;
> +
> +	err = btf_validate_str(btf, t->name_off, "type name", id);
> +	if (err)
> +		return err;
> +
> +	switch (kind) {
> +	case BTF_KIND_UNKN:
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_FLOAT:
> +		break;
> +	case BTF_KIND_PTR:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_FUNC:

would it be worth doing an additional check here that t->type for
BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO? I think that's the only case where
BTF mandates the kind of the target is a specific kind, so might be
worth checking. I initially thought passing an expected kind to
btf_validate_id() might make sense, but given that there's only one case
we have a specific expectation that seemed unnecessary.


> +	case BTF_KIND_VAR:
> +	case BTF_KIND_DECL_TAG:
> +	case BTF_KIND_TYPE_TAG:
> +		err = btf_validate_id(btf, t->type, id);
> +		if (err)
> +			return err;
> +		break;
> +	case BTF_KIND_ARRAY: {
> +		const struct btf_array *a = btf_array(t);
> +
> +		err = btf_validate_id(btf, a->type, id);
> +		err = err ?: btf_validate_id(btf, a->index_type, id);
> +		if (err)
> +			return err;
> +		break;
> +	}
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		const struct btf_member *m = btf_members(t);
> +
> +		n = btf_vlen(t);
> +		for (i = 0; i < n; i++, m++) {
> +			err = btf_validate_str(btf, m->name_off, "field name", id);
> +			err = err ?: btf_validate_id(btf, m->type, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_ENUM: {
> +		const struct btf_enum *m = btf_enum(t);
> +
> +		n = btf_vlen(t);
> +		for (i = 0; i < n; i++, m++) {
> +			err = btf_validate_str(btf, m->name_off, "enum name", id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_ENUM64: {
> +		const struct btf_enum64 *m = btf_enum64(t);
> +
> +		n = btf_vlen(t);
> +		for (i = 0; i < n; i++, m++) {
> +			err = btf_validate_str(btf, m->name_off, "enum name", id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_FUNC_PROTO: {
> +		const struct btf_param *m = btf_params(t);
> +
> +		n = btf_vlen(t);
> +		for (i = 0; i < n; i++, m++) {
> +			err = btf_validate_str(btf, m->name_off, "param name", id);
> +			err = err ?: btf_validate_id(btf, m->type, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_DATASEC: {
> +		const struct btf_var_secinfo *m = btf_var_secinfos(t);
> +
> +		n = btf_vlen(t);
> +		for (i = 0; i < n; i++, m++) {
> +			err = btf_validate_id(btf, m->type, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	default:
> +		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/* Validate basic sanity of BTF. It's intentionally less thorough than
> + * kernel's validation and validates only properties of BTF that libbpf relies
> + * on to be correct (e.g., valid type IDs, valid string offsets, etc)
> + */
> +static int btf_sanity_check(const struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	__u32 i, n = btf__type_cnt(btf);
> +	int err;
> +
> +	for (i = 1; i < n; i++) {
> +		t = btf_type_by_id(btf, i);
> +		err = btf_validate_type(btf, t, i);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  __u32 btf__type_cnt(const struct btf *btf)
>  {
>  	return btf->start_id + btf->nr_types;
> @@ -902,6 +1049,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
>  
>  	err = btf_parse_str_sec(btf);
>  	err = err ?: btf_parse_type_sec(btf);
> +	err = err ?: btf_sanity_check(btf);
>  	if (err)
>  		goto done;
>  

While we usually load vmlinux BTF from /sys/kernel/btf, we fall back to
a set of on-disk locations. Specifically in btf__load_vmlinux_btf(), for
the case where the array index > 0, it might be worth sanity-checking
BTF there too.

Thanks!

Alan

