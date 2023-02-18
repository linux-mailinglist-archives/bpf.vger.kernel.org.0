Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453769BBD9
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBRUaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 15:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBRUaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 15:30:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665DD15547
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 12:30:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31I5wcZF008208;
        Sat, 18 Feb 2023 20:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LeZpJk6MCEaN8onULGDKGvc2gn1Eu0yiSIywKosQQco=;
 b=nmt+6M7o1eYEUp1ceXuvJiGRJjiFz13wpj3zcFJF8k92FbN9OMxA/RDkW5G6eiWRoZSL
 7Bu0HZ4MIDn/o4wrtX6A3JRWkH+t1Ptz1W4DkkdfaSUcm3NfojXKAW3ibwEG0vnD1AsL
 7+04GbTxYGyc1z61IuJesePwtFnAgJng0hpLaXxknq49nfJ4aA5zN7pbRSxxkVqVxx3W
 J866OaKyqVD0FY9fSXtRODYlRe8+KFPkIfbBGfBcpwDrEoD2GEjUQjBvkOer1eia4AFI
 GwbxDB+GD6BYi3tm8mAyLL+wVLGHwrMrDC7W8BjTbcfSQAFm+19ZkWdcPegQNCLh9ZqC pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90gr71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Feb 2023 20:29:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31IJu5Jw027301;
        Sat, 18 Feb 2023 20:29:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn42mpxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Feb 2023 20:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZavFx2KlpcShiHY3ii1hnyUj1ZsteN8UkjBMO5H3ugVK2XqQtt87FQr6UwKn974/yowDQOLgWyObhWc/fHg2wY5nLijC1xmgyB4MaY08IKYA0++GAC0+AsKh/H5wNIy3FM5CBXAvFpBMkbeyL32UbcpjpC6LgXk1dD80JA2CuhADUAl7iIGCjk/HO9uYhnWdrFqPRwVVkjFSB6ZBChTA7lpxc7PINSE2CGZBMg65pChXTju8Cp2nMMBWHiTFMGUgK9a4WyPaNyopsLyNc27MWkkHh2rI8aiKzx+w7rNsB/OTPs1H+AXMdwIykcucWhb651DjFnnXuKHoehPKC0Tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeZpJk6MCEaN8onULGDKGvc2gn1Eu0yiSIywKosQQco=;
 b=IdvaiD7CQW3V1qLo6usZS8co6T32E1RRQlRqkhbliIzZtle9z81WIbv+bZPutZM6/Hy7n9a51dAP/PXaNkI6J7Qvk52Aj48V2sn0962QpHqpnzvBihkabYF7Wgr9CEreGicakiyrpLd+jDk9R+m3qxc7HmEZI2Jzkxh48W8UPQ20UBEDMHKBziz/vDEwRWP1N8g5GXKR95xqUpLtF7N45bUT3tuxJsbY4ISwK82OfX6fvGbnrBxB5wGoTZ8nhUU2o5ypqUcK6awgUjkw6LGjtk6C8TVNrTMi169RirDiqpOPnvJQVdiUecSeoZT3XVLSX+yPmUN0Xzjl8tSWozGy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeZpJk6MCEaN8onULGDKGvc2gn1Eu0yiSIywKosQQco=;
 b=Vc8KjsAH9cX5oIlncHkuuSy2/bZHBjw7szhppLZ3MqUVtq9ORESuSFfG7bFAY8F/Cwenx7s0qW65WHDmbYNkU1ncFYKOgECAlEhnooLtGz0cUrM8eFiOSKAL1dWKapGC25E/ppLmU5zZwJULMPeJ7/+muQAM7xWTQ51SCEvHLbM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6317.namprd10.prod.outlook.com (2603:10b6:806:250::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.14; Sat, 18 Feb
 2023 20:29:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6134.014; Sat, 18 Feb 2023
 20:29:38 +0000
Subject: Re: [PATCH bpf-next 0/3] libbpf: Make uprobe attachment APK aware
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
References: <20230217191908.1000004-1-deso@posteo.net>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <de1878ef-1963-6f9d-3861-a3a6cb3ceb65@oracle.com>
Date:   Sat, 18 Feb 2023 20:29:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230217191908.1000004-1-deso@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:208:14::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f17dc0-9063-42e4-fb85-08db11eedb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1o7V+a+cFFasSJHG+hiP0O7MklUPXbQXTV/7oI7YD7vQiLgDE8YuNHZhMFNQfTmtB0lolqur7SW4ojch3rGe4fxYy9EOeTP8scBspYv1X+Lu+4q7pb2AYw0iHVz1pPd6ERqNt4SsHvb+XzB4eTsqOu52DwkTAptQmtl1BKTjZ7QZo/QuUpUvA6YtA1nO0udoxKR0PG9ngmZJXsFA6G/1gx6DaqEJbLD18Tw4APtRClXApXqA3zs6zgb4NxWA8IGKZ9Jx8Wu38zo2Q4KdaO5pWiRbn4vYhvSXAOv+F9shdc8OQ0fL6JQXyElNDJwDC36sbgcapoqv+mpKwbLUHVTJrer+gLn1LOYvASUV36BD+nPtheRm/vDn8vnsJMHfRUJyTb2yM5+XPouC97nSFlcJGkzkFCbPKcl5LFeT7cy/FkCSVx+tRFnDEMz3TXUKlU1KZNBlY2uMQoEYITVGwtqXfF8x+YEuSiUsU+opDVESYsS9WMoRABFA+ZODUSBsa2EyaDO1Zylcjz1RavrUHprOkyE4Tw3vR69Kw6hrWJ6KMAFDUBtwoIQT53U33r/Pts+/hNbh9oVLw50yMOXruSnA9mOFM76jzoPaehR7EsF0KH2T/jsFOAnh7WJQScpdffl7caFOQMs++R9rv7eYDSdU67LomdVIhoWH2lbkUr8OMmEbs+UhZi0c7ZBpp4sslm83pUJx/qmFCX7P1AE6tAvlOjHm5dbUaQ3E+LPymLIm8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(36756003)(6506007)(6666004)(8676002)(2616005)(6486002)(966005)(53546011)(478600001)(6512007)(186003)(41300700001)(316002)(66556008)(66476007)(66946007)(44832011)(2906002)(8936002)(5660300002)(38100700002)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjc5ZE43U2MrSHg3Q3RCcnJ6dko5NGI5Qm9iZGZVc1JhSFMwN2poa00xdEIz?=
 =?utf-8?B?T2tQR3E5N1F1dzNqMG9ZUzh5V3hPVzlLd29laGtzN0RpSXVuSnQza2VTbXhl?=
 =?utf-8?B?VHRsbjJKOUdaSmsvWkp6Rlg5R2RyRTlvVDZ0cVB5YUVuSHJGaTBXNGZOamY2?=
 =?utf-8?B?MHFnQlNlNXZ2dHJrOWp0ZElJN3c3RENvNmlJVkx1T0R1aE83UWdpVW5iK2FQ?=
 =?utf-8?B?a3A0d3NLUnRYZVBycVhOQjN5aU5YTVloelgrYXFsek5kaS8rK1ZqRnh5RUk3?=
 =?utf-8?B?TS9zVUlmZ3l2RmdrNmJ2T2xPeXZRM3hON2tNOE4rOFBPUFdnSE5PY1BNbG9U?=
 =?utf-8?B?aWx0VGFxT0QrcFM0eCtyS2U1a2Nrd3V1RUdldUlDVFBuOVQxTHRidFVZa1dy?=
 =?utf-8?B?UmZNZ2UvNWxERUxSa3E2OVdiK1RacmNQeVNSQnVpMWxpWmUyQmhnUDlJYTVt?=
 =?utf-8?B?STZ2YXN2Qlo2bTBvVzU4UVJnekhxY0M3L2NoWjViNTU3Tk5rU0ZVOVBwdUtY?=
 =?utf-8?B?cnQ1UGFxNVV3d3A2K2s0OHBlKzRhZVVheHoyekRaWTBPVmtadENHVGxZY0p3?=
 =?utf-8?B?VWhFblNPV2RaUWVxWmFlVEhNRjFBa3JPV0hmekhVSjE5TjhDVmNsNSs2Nmwv?=
 =?utf-8?B?UWw0S1NIRmN6NGxrS2xKcDBoK1NHWHNSR3VuUCtnRWN1bTFEQmRueHRwU3Bn?=
 =?utf-8?B?K3RHSk5jZXRaMlN5cHd3eVVFSEVaMllaOEIwUksxSmsyNmNCemRadURxUE43?=
 =?utf-8?B?OThqQisvYWt0UmdjL2g1SHdSNFNqMWVDL1ZnTksyNnBRZE9KTXNjNE9XVEZV?=
 =?utf-8?B?UUxaaUExcTVNaDVlQ0t4d3dma3Q3Qk9PNHFaR083OEtQYktBQ2dRVnViUkJJ?=
 =?utf-8?B?RDMyZ1RVQk9VZEh6dkNXTGZESEhveHVyWTVFb2FDWCtHSWdLTVhzZ21ydlRR?=
 =?utf-8?B?M1VGTG9TaTlyWVdCak5oeWFPeFF5Zk5nTnhYZGVuM3d3cTlmNW1Ddmpac0hl?=
 =?utf-8?B?elRKa1VkYUxhbW5ReTcwYTJGZ3hZQ3lHd29XRnFuN09oS0FGQlJ0ZTcwNktw?=
 =?utf-8?B?MExHK2dxcEc3dTR6MVFLOTZLWWNNRzNkbERZTkJ6clE5ZW9YVTVNSlpra0ZQ?=
 =?utf-8?B?cWUxQ1VQeFE1TXladGpDUkNXK05UTGIzU2hoVkQ1NjFoUlpnakl5dS9JaXI2?=
 =?utf-8?B?UHR6ZFB2SzVDQ3NodFRjOU1RU2ZDVXJEalMrTVBKZ25nSW5mYldkZFF6elVi?=
 =?utf-8?B?cHBSSUw1SFA3SnJ0emZRVFZOdHNwVEhsQk1ldGNJck9DYllPSEZORWJyN1lV?=
 =?utf-8?B?dHNZZHhJQksvMklWMkZrUFBZdGZvRkhpbGxJQ0pLY3NHbzl3a3dJSy9PWGV5?=
 =?utf-8?B?NHMwVGZKRW0rY0d0NEsvTjZCMld2blcyQlJBNnpFRUNpdmZrckR2Y01OaVVC?=
 =?utf-8?B?YnRBYUVqOGhDZVVpQXRLdXRKVnJGazJCaURWRTBGeVd4dEhJV3hUNVpLWUxZ?=
 =?utf-8?B?WVE5ZVlhaWpnS1BvN0EveE50M0Fya21DcmRmVnhuUWVpeHVCQTR5dFp3U2ov?=
 =?utf-8?B?N01zREQ1S2doZ0FLbXBTN1ZzS1hnSDB1Rm5FQ01YaU8rY0lwMElQNXZQLzdL?=
 =?utf-8?B?Tno3NjR6NFhpN0FkYk1CTHUrUlBkbHN2d0hTOWJZSGZPT2ZhOHJ5VHIvOEha?=
 =?utf-8?B?NThxOHNZNTY0cUN6UzAwcTRBTnlDampXOFdDTURNVS9RdEw0SG14S01XRDNl?=
 =?utf-8?B?d204OTBZc1oybDZGSUloUytyUElobWRGdDNBTFgzTnE0eWNwd2ZhK1RRZ05G?=
 =?utf-8?B?NmxPK1I5WTlTUFlEdTFuUDV0WkJmckc2amNVcEFwdWI0dW9kRG1lRlN1MzJE?=
 =?utf-8?B?cnlHZ3I1RXNEVW0ySkRBNFNmaTRaV3dsWHI0RWJSUTAyeGJQM1BoR041UjVR?=
 =?utf-8?B?aWNSYmxEM25mK21Sdk14ajZ0bXJmaEVIekhCVHMzRzh0S3FXUHJQeENQVGpp?=
 =?utf-8?B?RWQwdzM4TEtTNXQ5M0VuaU11bWpmWE04d1NZTjdhSzFrcXBOVDlFM0cxeDRk?=
 =?utf-8?B?SFJDWkJnNnNNQ0FuQVkwNUtmSyszUEFMQ0E4NW9XOVlzVUd3WDlpbnB2WFZG?=
 =?utf-8?B?dDlHSWxTZUZrTUQvT2NnaEZBQzl3ZEJyYUFCaUlaZFV0eTdVOUpOVVg5TnVn?=
 =?utf-8?Q?OPoTUI1MD0k6rTUEqV64E+E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J9PJ7IsFCXOkoV4OGmS7Oqy8baAhTfw2G28Pl5GvOoKELCbaa64WQuqDjqAn4QglC7sZQ/dllJIPX7Hb5EySD/DKV3Q2xMWWVuf7ugTVmu7cQQ4xDVBovzwobUbjN9d0R1fFRLX9IE1MVLS7WI2ZgfTyAb5946/50u81jPLjRZH/u+1B6QeTicI0qAXNYKvlMVD682ASS1cdIHqIk+CAqZQDccdc5U7l1wZH/xPfSYLspJwLFEB/b4sEwkc3lKm4LYTlcvADM1Qco5fgG2QL/ZokbrSucdC8Fo039ZZfMHBPGO1Jn5TL3bpfr5hNDb2iFdY8093uwiqa1p9QRucZSS4RJSZX+ZWhh5bNKVzPOKR/teOQ6bjSf3mHX3ubpjpE+9RkywCyJ5gaGD0BS6xDru+3hrsFoYRVPffijFUJyTq+7eI3T2OnvbEfnU+IPmIGdmuZqPsiqOSNGpcsUHXcBnortNeJlhQMhHn0golyuGWwHukaJlkUtaX4cu8K8Uxs8yYDeJox5xUzOVYXWPrckM9+CjIEzlSqTui5pq7/leJRt0+1EwerP6bg/VO/d1YC92YjzQmBQY4nGzn3013rzbAeDaGBUqnCB0cys+2aEUZyI094D31muv7HvwnvMAjGSmo7+dzwJ118q18AkiwOCo/prAjLUx4NrQdwNLXatDrqaRdDqwz8/nKAT2abgJqNv2i6W59b0ny5hKwh6sNnYu8Tv5er6R8JlmNGhNf7qnGq6ggdPenvcah4BNXWpElK1EJW8Fa+QcIa7n2tzjvwIw1XbMRV2dy8HpbXMCqAvylWJxfcBEAAWw6e861X4SaYEm/VEZLydfO0/2McBXh8r5PcLcHgcPw6L+HCLiypstlItI4ThYGwRsnVNVz209nQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f17dc0-9063-42e4-fb85-08db11eedb20
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 20:29:38.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OyIDRn0PVqWONDx0tLx0IgJ59KSDSCkGDZy/ebmncOVkKyRTgb1/XM8wTZ2VYT+THwg02NeQRDakmNtybhKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-18_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302180190
X-Proofpoint-ORIG-GUID: JaaMCGPDkc48mptjF4gY9AatQBWKn4XT
X-Proofpoint-GUID: JaaMCGPDkc48mptjF4gY9AatQBWKn4XT
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 17/02/2023 19:19, Daniel Müller wrote:
> On Android, APKs (android packages; zip packages with somewhat
> prescriptive contents) are first class citizens in the system: the
> shared objects contained in them don't exist in unpacked form on the
> file system. Rather, they are mmaped directly from within the archive
> and the archive is also what the kernel is aware of.
> 
> For users that complicates the process of attaching a uprobe to a
> function contained in a shared object in one such APK: they'd have to
> find the byte offset of said function from the beginning of the archive.
> That is cumbersome to do manually and can be fragile, because various
> changes could invalidate said offset.
> 
> That is why for uprobes inside ELF files (not inside an APK), commit
> d112c9ce249b ("libbpf: Support function name-based attach uprobes") added
> support for attaching to symbols by name. On Android, that mechanism
> currently does not work, because this logic is not APK aware.
> 
> This patch set introduces first class support for attaching uprobes to
> functions inside ELF objects contained in APKs via function names. We
> add support for recognizing the following syntax for a binary path:
>   <archive>!/<binary-in-archive>
> 
>   (e.g., /system/app/test-app.apk!/lib/arm64-v8a/libc++.so)
> 
> This syntax is common in the Android eco system and used by tools such
> as simpleperf. It is also what is being proposed for bcc [0].
> 
> If the user provides such a binary path, we find <binary-in-archive>
> (lib/arm64-v8a/libc++.so in the example) inside of <archive>
> (/system/app/test-app.apk). We perform the regular ELF offset search
> inside the binary and add that to the offset within the archive itself,
> to retrieve the offset at which to attach the uprobe.
> 

I have to look in a bit more depth here, but my first thought is if
we need the APK specifics in libbpf itself? Would having additional
uprobe opts that specify elf memory and some sort of "don't attach,
just figure out offset" flag work? Then you could perhaps do the work
in patch 3 outside of libbpf, calling attach once to get the
offset within the elf (using the changes in patch 2 to support ELF
memory), then a second time to do the attach using the offset previously
computed.

Then you could implement the APK handling in a custom SEC() handler
which runs based on seeing an APK path or apk_uprobe/ prefix. Is that
approach feasible? I'm guessing there's something I'm missing, but it
would be good to understand what that is. Thanks!

Alan

> [0] https://github.com/iovisor/bcc/pull/4440
> 
> Daniel Müller (3):
>   libbpf: Implement basic zip archive parsing support
>   libbpf: Introduce elf_find_func_offset_from_elf_file() function
>   libbpf: Add support for attaching uprobes to shared objects in APKs
> 
>  tools/lib/bpf/Build    |   2 +-
>  tools/lib/bpf/libbpf.c | 137 ++++++++++++---
>  tools/lib/bpf/zip.c    | 371 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/zip.h    |  47 ++++++
>  4 files changed, 533 insertions(+), 24 deletions(-)
>  create mode 100644 tools/lib/bpf/zip.c
>  create mode 100644 tools/lib/bpf/zip.h
> 
