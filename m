Return-Path: <bpf+bounces-5860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F9762210
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED331C20F83
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87FA263D1;
	Tue, 25 Jul 2023 19:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF81F163
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:12:11 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF43172A
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 12:12:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PFsJZa006539;
	Tue, 25 Jul 2023 19:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Z8zzV0zDP7H5ptfUAIOVzzo4F/6ZwiRfAoev8gELxn0=;
 b=Hdt5fTXJZfmkDoR0fl0/91/hE+DqWCo7w+cWWIrg2gu1B5GdUl+50KVyoHyeF1PaWIoy
 dcIaTddQi7jX/5bk603k0EgocF+BGaE+99pBQCHdL58P5gUEefidr8y0otVm9PmifwfU
 A4ze+rs2Nr+dOc1Ym2YfBNqsPgkghlyQKcxi4fXtMI07j+3CwwYfKVqVrZ2SgzL4UtQS
 4wBbsarvhRnvGCGdSibvKIJakC1btk9TDC4qhaNGy4OnWVtJNZMoLUAEh9NPW9YL4M/T
 a8YvGO0rqMtutVKwYAX+piuBAy+B0pS92WnHTxnIKMe/fbgN53d1qkrQDMrKx4A8xMgY 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuntme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 19:12:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PHlu4f033540;
	Tue, 25 Jul 2023 19:12:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbg31m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 19:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1arNVJgEo0xzLV7JC1JqEqMpsYyIvG24txFRfznYFkDKdXWl61PB5TT3LYNnbYEDMe6j4QFYRzvLGeQzCWXSXHg8n4Ilq++S6OZlQXb+bbrwoFICP67MLMBMHxBsYOM+5/Huhmbem14KoZA3WVka7Gjhm9cxb/saAFixvxiHgsG/WiWjrxI1KDUD8p84e4PBwXAYaBVcyXw2Q4aZLlVYI6UpsZknDGLpNbYGZxXi+USUpwvZuZU18ybRCBPTq4o//sXBViEl/c/rMMMnddYZKDuAXn8RThxIto/9mRUTmhgkZtyV2QZ9xj/+iRo0kfTxy0iYPLdd0u5MAXJkhbuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8zzV0zDP7H5ptfUAIOVzzo4F/6ZwiRfAoev8gELxn0=;
 b=QRZrEdY6lGKghlP5k7La7dSVTrEWTUh/mzIRc+MA+J9FzOyny01UZsjPqCSeuaFhFcYTNTdTZMO+Y/axNiHx8/Gf1KbkWy9ha3lFQFDJ5PJRZ5SDrDE41YYxM935twSHvVYQaA+M86ADdTplowJtRYX/0EfSt77pGkghE5xIKbIAHiah3fppLxN780lnn6Rq+/2WlpX9tXvRkUhLb73SvLpPmOnsSqUc+50olgud2KuyWkXsjFYAS+NS2vOiKoFWI4g5pDw2HHFDFPtPeZo3VNjP22I9DUC+A/W4BMc5FgR8tJ2L9225Cc5T8IqGiun+vdxFPmgwM2NOVerxXQZ3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8zzV0zDP7H5ptfUAIOVzzo4F/6ZwiRfAoev8gELxn0=;
 b=Ly22risuTg33cLtAn8JmimRP7uOCvnJ7ywkdBTpx+NLvIzSGx7wkFsqUps8lLe6oBSY/GqZL+7E2dt9MUr2SojnWGm6zEy6RodH3+IHI2RHiBrj2ij4ZUrrXI2xIr43T7/9gl0pC35t0fMKVwX8hIuwfbKOv6hu8H3YABS2r3n0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 19:12:00 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:12:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Register encoding in assembly for load/store instructions
In-Reply-To: <87o7jzbz0z.fsf@oracle.com> (Jose E. Marchesi's message of "Tue,
	25 Jul 2023 20:56:44 +0200")
References: <87ila7dhmp.fsf@oracle.com>
	<5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
	<87o7jzbz0z.fsf@oracle.com>
Date: Tue, 25 Jul 2023 21:11:55 +0200
Message-ID: <87edkvbybo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::42) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fc3f1f-7f1e-4588-4436-08db8d4305c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vg6TjoJGBz9ckwT2mW8RmOHKTnyJTfD9p8nXDL0dBwzho9dB7vbNKGSgDlvppjrHXaItzwtvlcKqBf9j7Q5H8eZrC5Swmv/30IWnHV2mAOXTKmU1x+CYc/9OzsIf9LtSkABCLorfNzzsSRz93BzCMIkxy1YjO7DQ0+d0cVPRyAIjFt3uJkI6AaWzX79naE8J8SdfC+SkQYwBfZMcNfDET/BjXciAJuAQdSXwj1Iu/zx7gep3Ad0UmZWEGGtq++vt/VsvLdhNjjbgYrNnbBECY3KICHKC5YjXUr5x0fzbSr5sa9Bphkv+fa13EhtT4ywDY0JD4PJcNeD/EG6CkK6dm/DouGf23ga3L5W1pa4H0nfvbSTcBVGGkkeqo+UAzBuq0hjZi5Fwpdvv2pJKO3vttyE/k97+MuvjDqTNYh3zjvQ1pubLKveMaljRbRNDBjoWdqbV5Kbg67TzE+ZXS2kUPRxOxUhIlZBK0SRpyP+jWT8ee5yJELjkNgb/LgYWDjXs+PqHVbbDkH5OSM+FmLTClND6LW/x19xb9iEsF3W1A1sG1hZm46cvtlLTx2TdUhZ7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(6486002)(66476007)(66556008)(66946007)(2616005)(36756003)(83380400001)(86362001)(38100700002)(478600001)(6512007)(53546011)(26005)(186003)(6506007)(6666004)(41300700001)(5660300002)(2906002)(316002)(4326008)(6916009)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+MZvdaf6+7FJ4uEg3vAFbWM39WNC8ZfHdWzp8Xe10Cmj7UlPseoaiGZYXWbH?=
 =?us-ascii?Q?CB54kJ7f80tbjD6ptSqsRUgRFD7ghiNj/610YP92FSPy2Zz+yY7t0DKpFyYz?=
 =?us-ascii?Q?R83oraGgW/1S58kXHyxIylvyxqDDb7DLRI5jHd7Lb9o1lx8RY//hOBK7h09c?=
 =?us-ascii?Q?HmGpOOx4RsGOKgiJzNmGx1F3xg6LxCZ5uir/uLmiGsmQ8M+YUWC8CnlDU8YC?=
 =?us-ascii?Q?btdHOgdVaqHWJ/rF92+NR/VWoX8TyjARoWN0vKcjuDnCOqbW4zUO3CMcTd6E?=
 =?us-ascii?Q?RCv7b2hkv9EzpVy7uRGn7IBdzJVBOVxYAQpvmKYmkRMn1gi7we7ZmlpbTBm+?=
 =?us-ascii?Q?9s+N1WMYE9NNAvl2DhjZQGa5CVs303AJVqhHJu0W3LF7g+l92loHhHwHKZpW?=
 =?us-ascii?Q?vX0GgQxno9q/Es2cymUAWhi4go8ZILDh3oWeg8MbDf/C07ybHbH773v2O6g6?=
 =?us-ascii?Q?yuA55Auf8N0dxuhZ7LfmKLDyU7xTtGJgFWyknQYQYBf2uHQg8Kf+cMOE8fhh?=
 =?us-ascii?Q?Vk/vU3iORFN41MdJN4uSW9dQtZPC39f5OZn9166yypx2y/BLUmbBC52iWyfR?=
 =?us-ascii?Q?Xiv+VgkjPrwhzTVguG852jztQWmtLWa0DILNd6c/7EuZCGs/UO+wZT5gU1rF?=
 =?us-ascii?Q?4UmmUEFb5u3aQ6GVFLj/52fwxRB68pygOkipdpGAlr6vP+xgFw6pz4pPzUYN?=
 =?us-ascii?Q?pA407k/D8+pcjrRENFJ3RDS7ydyBjPT9dDr+KRZW91aQvnX/7g+eJPg5DwQI?=
 =?us-ascii?Q?4/4lQaC+aNT0RsQOHHsqu50kg5VC0C+o7xdChU7ehKzFtav18dEnB2WOldd2?=
 =?us-ascii?Q?SshZnFgnh5hHLb2SUf/8hsLGPjCZT+np/PPZyIiZXV1mTOHjDAZSf6IjX0mx?=
 =?us-ascii?Q?WGzVONQ0M0mhBxOe8glG/TyKXom86nNZfPtXleWfmOwVbsDNE9MzMQBf+Rfd?=
 =?us-ascii?Q?KzqwDyTkgittXcLqWdZpMFnltHwq4se6JBMs18Rspo5vwOMgfuIoCq5kgvsF?=
 =?us-ascii?Q?NeJNWPYofA1GVsbL4xD/pLHEYKejw2tmJh0QZArhwunldCcYPtPlX06z8YFf?=
 =?us-ascii?Q?jdvZFQj4c/QOXG6Q/ZsjcFahNOX9aKrOFCN4vkj+4h2dn3Tkbpww8L31ACBW?=
 =?us-ascii?Q?PzSUD5YimUjF+d5xtD9p6FozpQFzvMRiUBRE5MRxNzgjIr459BmkWSOAYlRi?=
 =?us-ascii?Q?hUblAKLOrjT46r4OdY2G4hWXxpM6gBStduw+3H8NnS3kUO+yZu65lX0EWLRG?=
 =?us-ascii?Q?+bAb9HYdE2eG0yn6zXGsSkoITiRpdKOWgb2+7xxNbbdDadN+1OKSTOc7bDba?=
 =?us-ascii?Q?fD6rtn4vlU3Y5vmmmfqyG1GkMn3I+FBP0v8hQ35CDd/7haQV6VFmPtyqPtnU?=
 =?us-ascii?Q?5OzSHSx6GJPzpdvZz50WkEfZEYmG2zwdgoEH+IfgvI6/8XcwMZSQqD1lJbgU?=
 =?us-ascii?Q?gxRXup5n9JIkCnddLE2CHwUxBWeLJRTTGhuNkX8vTRFMEZDzCECeqxk0FAo0?=
 =?us-ascii?Q?YDrH9lam3eVmNiN7scCfxLfKQVgU1XE17d5GAEKkuQVJzcdFmNPqHe0BTzFa?=
 =?us-ascii?Q?wgFDfXo06oamYz1i9OdNYKaO+OtCWj5YXXTvIm2NHSOHMP/L1m/t0qRMctz1?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0JsqcXyhUyoyhmo74EXkogSzGk7Aqa7KZnLgO3sqc1NPxZDWqQ7JFNrfWmfcMG0MpbkfVBuJ9N1tHoXQYSqXM++raT1fEAw4Pm7Bofp2ln+a9HRWbXoZ0V6QyrHAuKhOBP1UuizVOEmR8uvVQVyjTz88h56hv8UzcRSsKGK/r3mJlipLdJjLrEtDGmqMRzG1LaQmlRzWI7IhqgWhtRs/19gr438u9hdRK4K+ga6lWuDYZlEDt8CcGeA4Q9813j+TsOkXhhILjy/Wp9n9DD3guXgBQl8k5kGswtSmZo/UB6tO26pWE4TrHw8B842ydamYT2mq86sT1bLwh0GUeU8lYaEZQPZSGoV/BuIP/8L51vmyjeqYZCzGJYeEO6KsQHeViKdPG8gFiSycXBAHs6hO9tPunwtul8qnMXD8/8LuIBz/U3KB/hIN6rUX6zoYerUt4en7T5wo8+L6uU/0PZRI/ZlDYvabbAIyNzYjgX2OaAF+sfSBrXWfkSfaptfBXU3nmE1gZFE6Ds4NNkm3NMolykWWX9CBrtJjKJhFniTCxw7jqEr05b8JMZcVUPuNhXoQZ1uhhAGOdrDxO8aAkJnuwK88qU4vL7bh13TfuwgNNsRPA6+W9TUGUYw74EnkpcLQF1uYEttzz4Tgs6TEoCjjdPG7f4tPYyvj/I+zQlq9WRDwbwJFBtMMcuMnNR5WqOA+5w0A8Qp6OTnJfm8AAekJsQZebWiUQrHMQfR/+Vm4GzudeitanNMMNKM07FYA3g49VRmsIGUwCz9HuDjccVSle0EOpAJxtnqwU5CRnRq133CYM2L6o8BDynFGKhAVclr+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fc3f1f-7f1e-4588-4436-08db8d4305c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:12:00.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vYsYGNSIkdemXnLIg6rsNzIp/qASvaUBDQrRV7DROzxlwbbf3D40FVgTcayjThRZHRcc8Z2ymeW9/C4R50tSzjH2hwEh7/7PXhScv4ihyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250164
X-Proofpoint-ORIG-GUID: FAG_mpb5Y93aC023AqQOnfVX-tdB_OPq
X-Proofpoint-GUID: FAG_mpb5Y93aC023AqQOnfVX-tdB_OPq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>>> Hello Yonghong.
>>> We have noticed that the llvm disassembler uses different notations
>>> for
>>> registers in load and store instructions, depending somehow on the width
>>> of the data being loaded or stored.
>>> For example, this is an excerpt from the assembler-disassembler.s
>>> test
>>> file in llvm:
>>>    // Note: For the group below w1 is used as a destination for
>>> sizes u8, u16, u32.
>>>    // This is disassembler quirk, but is technically not wrong, as
>>> there are
>>>    //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>>    //
>>>    // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
>>>    // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
>>>    // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
>>>    // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
>>>    r1 = *(u8*)(r2 + 42)
>>>    r1 = *(u16*)(r2 + 42)
>>>    r1 = *(u32*)(r2 + 42)
>>>    r1 = *(u64*)(r2 + 42)
>>> The comment there clarifies that the usage of wN instead of rN in
>>> the
>>> u8, u16 and u32 cases is a "disassembler quirk".
>>> Anyway, the problem is that it seems that `clang -S' actually emits
>>> these forms with wN.
>>> Is that intended?
>>
>> Yes, this is intended since alu32 mode is enabled where
>> w* registers are used for 8/16/32 bit load.
>
> So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is still
> alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?

Sorry my keyboard num-lock activated mid-sentence.

I meant 'r1 = (u8*)(r2 + 42)'.
Why supporting that syntax as well as 'w1 = (u8*)(r2 + 42)'?

>
>> Note that for newer sign-extended loads, even at alu32 mode,
>> only r* register is used since the sign-extension extends
>> upto 64 bits for all variants (8/16/32).
>
> Yes we noticed that :)
>
>>
>>
>>
>>> 

