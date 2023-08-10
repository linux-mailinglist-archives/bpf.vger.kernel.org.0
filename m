Return-Path: <bpf+bounces-7442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059837775E8
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA61C2157F
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90E1E521;
	Thu, 10 Aug 2023 10:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FE3D71
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 10:35:52 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15765E4D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 03:35:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A7Yn0L031066;
	Thu, 10 Aug 2023 10:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=aTfHSuCTuYzD8MLkBzEWLz0YEU1ud4u4qlJENhFsNLg=;
 b=C6geHRemmvNJjSZ6uW6vsRTfVnD88vOwwXBoZfCUBTmySmPagSE9uz7H1zdkBOX2SqR6
 MCK0UKMC19Z+O5mCUR+dOIhN0MWpNt4TJhb+7MOLOu2JFjQZ7NKLyftzi6RmPo9o+yAt
 boZYkvKXBu1q0Es+4UclLi7GbY3HjiGF7emTq8kVWHXGFkUVJMb2kYSEd2VDD0f7z4Fq
 nVjd5enLobSH3kU6oFcs/CYV3F5YruQqaAddQtb/JaBrVaj5rGJ6OuspI+JchBujXKRN
 t3UCiZSUIgMAx+nmE9wluU2nVirb2m5PRa5B6Gpi3mJQ7ze48FqBPCzHFj9UvTFUNKBp Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaatsge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 10:35:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37A9XGQq017875;
	Thu, 10 Aug 2023 10:35:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv8t97x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 10:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwfwG2pSVTwhe0BpAacEaxZcOFjWYWeB9LSUUVJ2VMxCIO/p3I3Pn235xvKjFQ0XxjnueNzL+8IzjbbiXYznkuMCf1tLuJOUkprEQxDT1YV3q+jqglla7cfsWC+PTw9U2oIDizGnU3jlsITMw/tSTH+CqXCyvdtPBdzjh59HEJWYbLKfW5u4sRTDboQpRusWfNHyc+SwWNyojHmn1vRAVKTcYI3eDdQvkaSuc22eQojztcj5Bi3s6AyHk4AN9BtBiEhZYsoTFgd4lT54jmMFL7FC3fT2Fl/+cZS8S/1DQbu5cpv4zEFWZfvZxsdsy5r2iuXGT3hVxRAoGKu+4nueOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTfHSuCTuYzD8MLkBzEWLz0YEU1ud4u4qlJENhFsNLg=;
 b=kVPmwjuDHg2cM9Uprgyh+bXJWVmQJ/rWxD5YUHttg5Tmj16N+ApVEeY0W8CKC+imwwkEa5Ev4B4bUeAL8RIIPy9tKR0IXlp5RmGq9SQFCAKxCPdzNYK3s8R3u+JcpRJ90nN8Fke86GO51QhGumTPZwzRNAs87MJRPUXF6IQzAlpA6rKesG5eHoHI71IuCLcGlSR7gGXcifmVYoYEI0ALQgjQbVWp/IlP7DAehS7GvrEab0ZxWUIXbKfF39MFclLMI+xlLplSNU7SdTuf/TtBFSiTVkRr9HHo9jPB3xEbJABSZQLlAxkmC4z3QZ5Vl4Xcvcsvh/VKtZsou7wIiZBUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTfHSuCTuYzD8MLkBzEWLz0YEU1ud4u4qlJENhFsNLg=;
 b=YxnhQ+dOve3LhDAmbE07kwg9Iv/1DsLEdL0eEeigxk6nyZLR0a4COkjEQbMPO+/4wobkcLxjyxNfG/QInWeiHMaXr7etkvVOvYi9YQmJi+rdJREJQoTh7q0qTl7crlINpPm43EhLlIbN92tUcd9bzx4KYTNFQzwIuAH6VkovQhc=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Thu, 10 Aug
 2023 10:35:41 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 10:35:41 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Nick Desaulniers <ndesaulniers@google.com>
Subject: Usage of "p" constraint in BPF inline asm
Date: Thu, 10 Aug 2023 12:35:35 +0200
Message-ID: <87edkbnq14.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 301860c8-4fcf-4bd7-8448-08db998d8b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	30VSQrpNxtLpW3RP1ooeBhVSrgxpHJtgTlw1EDBnyR04ZKA7nr5TsQop3/5q6qoHlXNj8PiPF9H75AIwWYSYkcMvisnpGPPRUfSsLDDssadhvrc+mnqX0X437r+rYZ4Ws+hFnA7pWNqyLIS/miHZyYYujE/JQuaiRp43e4pcxuJMQA/hUuGfTBI7lWWdspAMpw4DBN7itCj3ahP50ZTJhHd/8Ul5pwSbmHViRX6gsnKFDWA2AONdXH499hNlVMH99VWscuMgJMgdsN4fai+Z2enYFxroiwOn5J1MrmxLJxjw8y4CAGoAesiR95HrfZqZrNQReEVSujciD2wPLwKtGIh09Z7m2gXgEUM5T9z+bmVEASwKN39gaIKVK3TuhkbAc+FvCBnZlRPsVnDkgHm2NAJ2GkM9tfuQ64szTO8qsP+f+I9zvSHXE3c0MtBwjh8GMCkQYm/fXmv7k2+L0+quVvdSJkoOCGCxQc3LAR3K8/+zx3LbxW2w/0w+tyZ3qVf6iCKT1XzCn43DDstu3maa/pRZrcY+t9l/Ppcej7fuFFMluvqJw6jyFdWDdZ4puv9R
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(1800799006)(451199021)(186006)(36756003)(5660300002)(2906002)(2616005)(6666004)(66476007)(66946007)(6512007)(66556008)(4326008)(38100700002)(6486002)(316002)(6916009)(6506007)(41300700001)(86362001)(8936002)(8676002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUZyUDhqY29xdC8veGU5bC9aSDFzcmgxNUlLNzNRWkYyM0ZUTk5JRjAvYUc3?=
 =?utf-8?B?cURCcmhmVXZKbTZ4bWZqK2RPc2JFTVlJcDM0RjVmdFZSU1ZEcnBpZmN1SW5v?=
 =?utf-8?B?cE9pc29sVHNsV2cybHYvOU5mT3BzSmZSaHVNMXVROWhWMUQ2dVZwdGdtbitZ?=
 =?utf-8?B?dHRTbTRNbHc0K3FuRS83VGp3Z2hMOHdIQ2lEc0VlUlkrM1EzOVp3TkhRbCtq?=
 =?utf-8?B?NVl3elVxUlpwbjRkcCsxdHN2d0I3UWZXbEhPQ3JHVjluTXRMaGd6ZmZOZEc5?=
 =?utf-8?B?SkE5NEk0TTJoUnJkQmxrcTZhVzVJSFZLaU4zUVJPR0xOaHlLcFNXejhOV0d4?=
 =?utf-8?B?aHpkeGVMRUNyMG5HRTVNN1RYTHRNcWZSZFJETDh1a2VMdE9MUlBBVnBtdGhn?=
 =?utf-8?B?ZVNLeHpiRFNOdCs2aDZIR1oxK0FvOFhWMGsvNDFMQ2QzcGtsR08xZkF6Y3NP?=
 =?utf-8?B?OGgzaHhieHoyTERSK1JnUFU2dndSUEdsZ0dQRnYvTldyREV2ZFBWNUN0UFp6?=
 =?utf-8?B?ZVlyT3E2OC9mUzFpdkFDWUxubGJTNVBpaHRhbHVrSERRM2NlRTdpdHN5Z1pY?=
 =?utf-8?B?bjFjdWZzMTV4YzM5STc3R3dpYUNDRXdoRHdGZjJBc25NVVpFR2lrU0sreWRp?=
 =?utf-8?B?dEdaWVVqQkRvY3QrekF0ZTRxSllEVm5lVGMxS3pFSWliRTFMcUlrcExSOHlw?=
 =?utf-8?B?aWJpQ01tWlVlMElZUStCRDdBUzNPaHQzYTBOSEJTbW5NMTlWNGlCNkJ2MTdG?=
 =?utf-8?B?U0RMQklycHV3dVREVHVJN3d0UTNnUUZsS21yaTZwMTJsOTZqMUR4aXJ0Vmt4?=
 =?utf-8?B?ODBwWlpySkJ1OVQ5RGwrbDJ4Y1pIUEtLNFpheWEzdWg1VkMwM3JGbGlXVm1J?=
 =?utf-8?B?N3ZTWGZlT3B3d3RtcnZxQU9yOWVtQzZUbUk3Y0FSS2JvOWdBNSs1UnJOZ3Nl?=
 =?utf-8?B?VHhEY0NrNEk4bzJFYjlML3BYZ1hZVmZIUzFxUUFrNVlrUzE5bHpJWi94Z1oy?=
 =?utf-8?B?Ukl1R2dJcURYbmpVUkw1Y0lWOTFTWHhJV2pnTnRRKzRvT0t4K3RUWVg2dWhP?=
 =?utf-8?B?VWUwM0lNZTJNVkxWMThVRWlibzBzeDVUL2w5NWZSUXRwUkt2UlViUTRvdFlo?=
 =?utf-8?B?SGpRUDdHN3F3TlVoMVhQMnJGS2xhd0FvZzBZS25Ud0tGdllPVXc3U3hZYkhv?=
 =?utf-8?B?OStZWVNXaWZ6UkYvekhlOWZtbXRmT3VqSGZCclRVTTYwQUptNE5VaitTaVVV?=
 =?utf-8?B?dzNPVHowMUlsZTFvVm5ZdCtyNXJjaGVwV2pvTnZMc1phSEI3RkRXcy9rVTlL?=
 =?utf-8?B?VExrWksrZXYwcHNCU2xnRHRSbGlDN3Y1S1p0L1J1U01kZEJURVFwZThab1M2?=
 =?utf-8?B?VENCK1RMclVTNEVTVHpESTJoZ1I2MHY0Yy9ZVW9ydXlaMzF0VHNWcm5FUW83?=
 =?utf-8?B?dmF6aFRKZTh3L21uWThZaWU4RTE2cHF2bGN4SWhscjVlZVBtTkllemN1Rjcw?=
 =?utf-8?B?a2JlZ3VuQkFqWXhHRlIwSk45ZWpNdTdwdGpOUzROSjRBbW5adW1EaEM1NU5k?=
 =?utf-8?B?OWRuSlY2dDBtYUJwekY1K1YvaWdlUzArTWRwaUY3VFNQcEdxT3RZTzRNUjky?=
 =?utf-8?B?TXM5YTNiRWx4RzJDRFFaQWZOQ3dVdi85M1pJdnlCdW5NVGFWcSs2Z1RYNU82?=
 =?utf-8?B?YVgxSHo0ZER1VXR0d2VtMmw3Z3MxYmpGRnJSdHZSRkphQTJybVZGKy9sTHow?=
 =?utf-8?B?Z3pTcGg5RExPQ0czSGhXa09lK21LR1JVMk1HRTY2MWlkQlZ6SlpLKzBoYzFL?=
 =?utf-8?B?a3cxNGxCcHZLSC94eEhzM2dxUUFoamIxL3lOT0FNY0NMUStGTXlDQjhsY2ZI?=
 =?utf-8?B?UVlsallzVGMrODM4K3cyYm0rZXFmak1SYmQzRXh4VFgxSSs4QWdva1B2N0JF?=
 =?utf-8?B?bGJlYW9qekgwV2VqVUNXU3hXLzBiQ29VVjV3eXFBdFd2YU9NWHRvMStPeHQ1?=
 =?utf-8?B?eGRCbWhLaXZoNG5BSGsvVU0rZHFkODRwT0dUYXp6dWQxSVhGRXR5NitPV0Q4?=
 =?utf-8?B?a0dHdHhRWGo5dVNjMWJvaUEva1pXNk5pYnJOWVE1N2daLzU3U1p0VTM5UllT?=
 =?utf-8?B?QW4wVmNhbDBWQ0ZjbmFUN2N4Vk5YK3BHOHgzeVNaSmFYVnFWSTVZWk1UcHlS?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gkE+WKWw59No+zqO0rSVVlqGRFP1Ew7hHuvV+KYEc9wqF73JMCn+vyr7qAKcspqggcy7S8LJjRffHg9mtQTx6L0vHvw1VGFIEGlDxEDcZ7I+xlLcs8FrBVb58w0rbBKMicCOqiHrd8pDkvlwAxBJUeHQzFfZvOSmAPvT2gi5mK0wEOlN9BwK6WlZpgctGr7SqMrWYCOjMbTSadxteceUTzKOjQFjUmwTOAzzYX6mr1xacuH+wvAWn401/JgfI1dlOhGDfYkW/NC7aT46Mo5uuHKebOQQ98mZPYqR+MThmHjBJ/1k1i8X23k4AeOqOwLqCJADnjvXNPDiK+/OPoKa8kJFsEHOgxktnGGtMU/WmvZtaJ7gZ3eKaqDzt+wnWcmg43oLueRqpv9NlOlS+Q6mk546KLDY5m5apwmtjkiWj/p3eW/IZkk0qpov7M7DPyuk3cvB8yk8U+orjc2UK/84dv+mZCrmCyjUQWoYl7KdJNqRCgP6JnsEqKPGMIxta+oTZrLFfsAPK06S4hWk+AuvvC7jQyAqrFmid4P58FgB4zbYvwlV0el5BkpZc7P6NT7JIm5fJ76HaJSRa/F6xN2A6aVjyGbGHoNzAuV57m35frkNg88gBTUS9BU2grUMClfZ6+bitTYByCejcHsRzEUpKchybLygJj/RVoIPqtf8bBQ56afw/yNhh+AQKSNJ28+LPOTnd72VR4oZh9/QF8toknfXeQQwPAU17i9qCphfOLwxeQhEqM3nalwkMMZX/zbWYpnLi8aef1PqekMtv5dEklHjmPR35Jh5N+ZoLyx2dq0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301860c8-4fcf-4bd7-8448-08db998d8b83
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:35:41.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3V+9EHyos+imN5jzgxb2iqzy9/1oDpll6vy/b8OV7wiick/Fm8VukrerDDTHZxNICoMmMeokbUPDW6peODmmMGZTn2BGnSpzTCZOfDGI6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100090
X-Proofpoint-ORIG-GUID: i8oyX6DQBFcVBBK92p4vcmfvhI2cODjn
X-Proofpoint-GUID: i8oyX6DQBFcVBBK92p4vcmfvhI2cODjn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello.

We found that some of the BPF selftests use the "p" constraint in inline
assembly snippets, for input operands for MOV (rN =3D rM) instructions.

This is mainly done via the __imm_ptr macro defined in
tools/testing/selftests/bpf/progs/bpf_misc.h:

  #define __imm_ptr(name) [name]"p"(&name)

Example:

  int consume_first_item_only(void *ctx)
  {
        struct bpf_iter_num iter;
        asm volatile (
                /* create iterator */
                "r1 =3D %[iter];"
                [...]
                :
                : __imm_ptr(iter)
                : CLOBBERS);
        [...]
  }

Little equivalent reproducer:

  int bar ()
  {
    int jorl;
    asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
    return jorl;
  }

The "p" constraint is a tricky one.  It is documented in the GCC manual
section "Simple Constraints":

  An operand that is a valid memory address is allowed.  This is for
  ``load address'' and ``push address'' instructions.

  p in the constraint must be accompanied by address_operand as the
  predicate in the match_operand.  This predicate interprets the mode
  specified in the match_operand as the mode of the memory reference for
  which the address would be valid.

There are two problems:

1. It is questionable whether that constraint was ever intended to be
   used in inline assembly templates, because its behavior really
   depends on compiler internals.  A "memory address" is not the same
   than a "memory operand" or a "memory reference" (constraint "m"), and
   in fact its usage in the template above results in an error in both
   x86_64-linux-gnu and bpf-unkonwn-none:

     foo.c: In function =E2=80=98bar=E2=80=99:
     foo.c:6:3: error: invalid 'asm': invalid expression as operand
        6 |   asm volatile ("r1 =3D %[jorl]" : : [jorl]"p"(&jorl));
          |   ^~~

   I would assume the same happens with aarch64, riscv, and most/all
   other targets in GCC, that do not accept operands of the form A + B
   that are not wrapped either in a const or in a memory reference.

   To avoid that error, the usage of the "p" constraint in internal GCC
   instruction templates is supposed to be complemented by the 'a'
   modifier, like in:

     asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));

   Internally documented (in GCC's final.cc) as:

     %aN means expect operand N to be a memory address
        (not a memory reference!) and print a reference
        to that address.

   That works because when the modifier 'a' is found, GCC prints an
   "operand address", which is not the same than an "operand".

   But...

2. Even if we used the internal 'a' modifier (we shouldn't) the 'rN =3D
   rM' instruction really requires a register argument.  In cases
   involving automatics, like in the examples above, we easily end with:

     bar:
        #APP
            r1 =3D r10-4
        #NO_APP

   In other cases we could conceibly also end with a 64-bit label that
   may overflow the 32-bit immediate operand of `rN =3D imm32'
   instructions:

        r1 =3D foo

   All of which is clearly wrong.

clang happens to do "the right thing" in the current usage of __imm_ptr
in the BPF tests, because even with -O2 it seems to "reload" the
fp-relative address of the automatic to a register like in:

  bar:
	r1 =3D r10
	r1 +=3D -4
	#APP
	r1 =3D r1
	#NO_APP

Which is what GCC would generate with -O0.  Whether this is by chance or
by design (Nick, do you know?) I don't think the compiler should be
expected to do that reload driven by the "p" constraint.

I would suggest to change that macro (and similar out of macro usages of
the "p" constraint in selftests/bpf/progs/iters.c) to use the "r"
constraint instead.  If a register is what is required, we should let
the compiler know.

Thoughts?

PS: I am aware that the x86 port of the kernel uses the "p" constraint
    in the percpu macros (arch/x86/include/asm/percpu.h) but that usage
    is in a different context (I would assume it is used in x86
    instructions that get constant addresses or global addresses loaded
    in registers and not automatics) where it seems to work well.

