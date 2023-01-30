Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748EC6817F5
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjA3Rrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 12:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbjA3Rrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 12:47:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F801BFD
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 09:47:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UHYTEt025721;
        Mon, 30 Jan 2023 17:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=DEjcOS4Aeib+hWf55QpXOOdmxMzDUzSYqfi82j1xp1s=;
 b=ANRG6M8AqT6KK4UkR563qwVj/ks+tjF+5DoL5dP1ZQTA9PC53qgug0bxi5C2Sk4c+vpC
 B8JNl2JZWTGJOvIaDciBOir8zKWGDHKS6eVlhOfVrgvd+fT1SZ3QxKSoWsu85xjwq6nn
 COFSz/pwwOcSMpIO86sigChqnoxkToBBd1vOSSoy95esP8zDy6/R9zjko+E57QDoGfmv
 s6/SLEwuThF5K8YYqsvxEM8jjF5Okt2U9PQrmXNp/oNAyTr9eycEj/BROOux/B6NUka8
 7GbVsWAw/QG5QhLG94clWBFm1IpsPlZPskwm3agmVyhEwpAcN+5ajMDcOiohYEbX6TpF ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8kjd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 17:47:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UGjqDx020580;
        Mon, 30 Jan 2023 17:47:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5b71de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 17:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZzUCaYwVtf5AOooi5Ukx2srvDZM4COwnYHR8DBG1mZy2QtaR+5tzFOJb4X/CUOXiVuC036MiYY/4dwdHTIC30PChyqp8P2wYUyurYTcP3sGsntM1yt2Sad27DTBKd5Rr0ztNK9M/RsNwzLqLEsvqsGTL71xSpOpFAW5zzq8iEqRERpVzeorZbIUdTYh7doJU6vJwY7c5e1OzlSN0mG/mZjqR9LRp5QsaiAIdRZnr4x5C6nqMg4F9FRp6+naeFnSSVk9uS+wDHGfjt5aE4evmujJhUP10LHLlnsrrEON5UkBPBJ8TWnJD9wSdY37uvlp0E92Iel3T1eYoPsXHW7zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEjcOS4Aeib+hWf55QpXOOdmxMzDUzSYqfi82j1xp1s=;
 b=VwPOmst5PB9tQKGMSWQD6Uz7QntnBswRT/CgzxBkls9V47X31LGajTCoco9jbLwz1+N4rzwDTlFNz6DK2Ipfm1W5LzEM3xqhcRGyH5c96+ekpD4jEqcmnnyQ576cAldv/vBWSOPmBdefd1BEU3R17Sbvr1TFhIHGiVzFxBIHAoMCqK9E2KIA8m1kppksnocnVs4TIQ6gS7mMH32nwAtxfXC93WmGF6x9yWVDYjhLSZdVntgkiAqZyRZRUFOnWgw7adNRgb52rtYEO/g1JAQRKHq5r7G5vnwLdaVIJrnvAl95bM7wQ2dDF2Ij+kSyZquGk2pZg+TgsXHTZAR6R/VscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEjcOS4Aeib+hWf55QpXOOdmxMzDUzSYqfi82j1xp1s=;
 b=CDgp5Ykbp69ZN2D7KacUiHb7Z7zGscNVtJpSwMoDjyOgDq+E6RYCjuP4KmfenWP1a+ZAznPP9nEMyTRilvFEKiiRMzYktv09je0bPl/hDTmWr3Sjy4pSUpW03S/Ckydj136Ag2MtYousxuyHMOAA7qf24zsk4lmw8x/tGKF4szw=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Mon, 30 Jan
 2023 17:47:24 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6064.019; Mon, 30 Jan 2023
 17:47:24 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     bpf@vger.kernel.org, david.faust@oracle.com,
        elena.zannoni@oracle.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        Yonghong Song <yhs@fb.com>, ndesaulniers@google.com
Subject: LSF/MM/BPF activity proposal: Compiled BPF
Date:   Mon, 30 Jan 2023 18:47:11 +0100
Message-ID: <87edrbhq3k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: e8baf0ef-d989-475d-e936-08db02ea0b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6ylfOoQNXZzJkpN3avWRhfl555kGLyMOKoFAjFRbd5kWE1d7WGSuzjsuOZfyBT2nHS6RZeJf3+RxdpQeqi9IsIcy14fZuIEA3fJk2LmageEguBptk0YN5+//wVeJvlj+7AWAXnKm1w3v3CDtLGsfDEccQpRfgl9zpToUO62REEj3WzwrUXxSvkLurCE6DtFIT//w7ZDdn9cBKmtQZs2mPzC9ip772+rJCs9YDzq/1q8wSMteTwrPyIn6yJ+18JUcTkSLyvO3ybOT+gGohGefxt8/l0T63t7/3QiDjLVMKVDjPm1bPkz0ZI0yEvIyQUuosbfdG4FDVPV8imfdo5D+k7uyD8VfNxf0KmF9du0zHe7Ro0I4I9zrOVhhO4s2kHwB57KNzdGfCdYXGlTAnP8s7OleRY4RYn4+vRATs+MLjyZ6TAHyR7F0dom7YmgWbMACTkNcCGeaTvKConzP+SrPTnK+adOl3jN1O1nkF9w1FIYZTdU+vezWnJonnISLrj5MH6dghWoSU+AS6r3srA9+R2Ckt4TsX/3eYzJOJi68BQdSqPUN8OUYfAmly/no0zaAQr7Uyz9pBBx8sbKbh6qX8giGck2Huq3wSs3739X9XL6mSGI4oXDSV43wUtrLZRXHqcQJp3uquObgWnGHHIOJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(478600001)(6486002)(41300700001)(6666004)(6506007)(2616005)(26005)(186003)(6512007)(54906003)(83380400001)(66946007)(316002)(66556008)(38100700002)(4326008)(6916009)(66476007)(8676002)(5660300002)(36756003)(2906002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3p09M2+stAp8dvY8Y5oMgIeHMLzTdbKJqerS9jv8o905TaVA2R8Jlpflgy76?=
 =?us-ascii?Q?nGbexHADCtgjz+DsehoP+GvyWnLjVvzFatYIce36kQj3wEDYqtlDDgY2fVya?=
 =?us-ascii?Q?U8RDKtbaSlppHS5BnkZn8bTdHOjemEKzlgya1UkH+z46xWIH9ZW/uToJ3ySz?=
 =?us-ascii?Q?4GGL/c9xr/lIgViBnIoUzpGht25aMxhXg0vadHmprsYj4xIYFNaIOiK/D6K+?=
 =?us-ascii?Q?CPr5dwe3KQCDJquljTm9ILnucZwj9S5BbNXfKdkcJEBLf1wRjcJd5/CeKxH6?=
 =?us-ascii?Q?2GjgWUVhOgWM/Xjs3GlVRIfQM5L9NkZ7HIgHReJ1pOKYgLFr4vnAOLV92WtO?=
 =?us-ascii?Q?aeV2XTk44NGY459xFbvsPSGEL1cFTXd37wsEKs7AP5z/AjnpV/Um+aP3PRwm?=
 =?us-ascii?Q?CFwXLD5HiClvtPDATpwT4l6rpAd++h7kLcB1nkT/idGzCQeauLCUZ3Z0tAvT?=
 =?us-ascii?Q?g8xVgsT5RxpNJDgPN3Ek1+uq3KBUkJBpZ3MIK1QdgCF/+nwfDiBoNwennyhj?=
 =?us-ascii?Q?jxjRqyNXx0jSxve0AjFJCNMy9kCiQPL7mX176TeP1jKWrVkv60sj50u4QMlo?=
 =?us-ascii?Q?cSEOv0iWjMjbedc9qdIg00dPbHX5BHQzbah0AYbW9uH4sVsq5ZmA3i4rVacx?=
 =?us-ascii?Q?Bc64Fm9/YbvxSi2VRlL+MApQBYBaT6htWQxhwsBOiyLlyzpjgojQMFcc7+pa?=
 =?us-ascii?Q?Ia1Vv4cw7PfqpchnugNeJMgy4jLpNOdVqetiScgBqwNoQjDeawTOow0Pmrlk?=
 =?us-ascii?Q?DgWOZdg8PDmsBDsQNiu3XNH6y3+gr0c6XtAoTwQOCutIMPdvVPKLEhL381Ai?=
 =?us-ascii?Q?/0RdnS9WbR1Cgornco2+8+xuuYVxCEAFWO+QchwXC4nqpZtlEPON/vJx3skb?=
 =?us-ascii?Q?ipCjvpuMgJVvhrWoF18aZ/MXACHuDGctFRnS3D5Sqi3/2ddpsPrKVkCcZ8tv?=
 =?us-ascii?Q?u4pYCSHOdOQ2VktbqOiS9ZiidvWn3aLL2tBNhnhxOm6btooRAMXRjmuE7pOb?=
 =?us-ascii?Q?ZJhc0ilvYIBmtYxXx+wnHJi1UTM8MOogRUaWl9t5OYxUHvoOit330AzhipjK?=
 =?us-ascii?Q?oKae88mDj6BXXnBr5oWG8UhGIZGTT8I5L13xGhs6G0onHMwiBaThniiqjs0m?=
 =?us-ascii?Q?P2rEXbrSZadvJawEHFXlZbfWm5rGufueY1f13+J3HuakuksBU6lH9glWiHzi?=
 =?us-ascii?Q?LDM29orm2G1V7ITW1OEr9QWkCOfUkncX2sR2lPed0zXUBZpUsqjbhc0ChVzp?=
 =?us-ascii?Q?hNBamVJA+Ft8FmeKjUjp8aS0Sr+CTPHnBlchw7yPn1Ne14MmrppgLL+Rcsn8?=
 =?us-ascii?Q?/9vvljrHgzTWnkOnS+Ako5C5STImN5Lc7uwzbnbx6vGhXuH7rZFA8T7OTHTy?=
 =?us-ascii?Q?7jcq2zP8Oy4zaN7GVrnyrFnUbwz0z1Hs462TvbsvJwkS6sPCcCktJl3HLyrd?=
 =?us-ascii?Q?iF2eeomL6PUvxd7cHYqOjUbIS2qUSrtmjh34VgwtTS68PgbNpwWEHyzw2Gow?=
 =?us-ascii?Q?NZ65XcpMIQiV1VYQMw3AqegFEqF9iH8Z9HnSrtf45fpsqJTzVNojm5o9Eoea?=
 =?us-ascii?Q?q2POvz0S8RGPmmMy8n0QhQu+GFZwRlLL/d+xDuOwEWHujZebFrs/ivV7O5hV?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Yrk31Ej+3TkW2l1A060dWwebtFXhALdHe1pAttFwd57KghvBN17iuXH2ublAf3/cq7rFrpW8Xl6xZL1gom0MkEh/If2hSbCOVEiTTkv0V2xFxrgf1QaVusH7QmSyM5l0sxG/QzEv8pkQ60cOHFdGbAWCmH8lLzmsgmjCrpZTxPu3x7JvwjgyRSyoSlp6UN1gqWYEpehHAT2xYmeFUmxaIrkonCk/GfeNm/Q8EAljy4369yEH2X8Z9cVGcI73GFFnfibvm8vshV4nthOKP2Whuq0TWfVQgBd1G5LNUDdi1MyqwzWFFm76fKHsYLeOi2Ys9mtf2Iv3s+veg9+rOgtLgyedkjKtQfexgYki+st4JYEvvjWEvq4QqoGiJIWCN4QEE6PbUdLMqyk/vr0nWQ0qZlRS7TZSp2ELC+8gFrgnk3tg+XEtwNy3ATJRJHtlMG3zYwXhPJfFMoaRTUZUaBcNw6R/0UrJG4uzCTX+DCwoOIUoGqihTPfnh1WAfIN/JkZZyvsuqSn4sOL8HiqLkuQAzARwDQdJyJ4fKO/k9t3WQXKUWR0UJk+nTKwr0dyIAPTMM2iZdQ44GPQHy8HNbo0ycPO/mKVK6cxLo6O1AQEXcP4oRLpTq3ItmQsYRVjSRZzZj/ytXQ8q9roc+cw2GH37G0nPSm8A7sjaF4/C4bQFzqb+gIb5a3wwLZtWzwD5Yz8vpxsUQ8a6wv81/XLpEZDNKH1RwtBVJXd79UHoNhN/bz0xKHAcW7e7sUTYhtVboMTQuSDuU7wQrxCqmp4sMErtdV3bu4vA0plIDTrztCR61YPTMHg2aUGrpkikP7bDJCCMD/7FAJDu3efmIMTSLG4T+qGL4cpf5c7OjsHSDiSd2K/YyL7Xy9Ur09t5kPo2H2I/2CPk6sCBXIdKMwJeU537A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8baf0ef-d989-475d-e936-08db02ea0b45
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:47:23.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI7xVYbFfjoTr7IgAT/jBF4xNa9nzCkDlTHGAzzRTLw5tRSyCT55RgDG2La0Qr1S5SIZKXLdMPj1O5qbIWUi9F9w193BzcKollYGOQxALdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=462
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300171
X-Proofpoint-GUID: NfDvlmYFBseZRu7E2qTOByXgTBCBZ1Db
X-Proofpoint-ORIG-GUID: NfDvlmYFBseZRu7E2qTOByXgTBCBZ1Db
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hello.

We would like to suggest to the LSF/MM/BPF organization to have a
working session on "compiled BPF", i.e. on the part of BPF that involves
compilers and linkers.  This mainly involves the two mainstream
compilers that target BPF: clang and GCC, but other BPF toolchains are
slowly appearing (like the Rust compiler) and that makes it even more
important to consolidate compiled BPF.

Examples of topics to cover are the covergence of the support in both
clang/llvm and GCC, several aspects of the ABI that need to be
discussed/clarified/decided in order to avoid undefined compiler
behavior and divergences, issues related to the BPF standarization, and
suggestions on how to lift some of the existing limitations impacting
BPF C programs.

The goal is to reach agreements about particular things, document the
agreements, stick to them, and a clear plan to implement whatever is
needed in the respective compilers/tools.

Potential participants in case the activity takes place:

- Both David Faust (GNU toolchain, BPF port hacker) and myself (GNU
  toolchain, BPF port maintainer) are willing to attend the event,
  prepare discussion material, organize and participate in the
  discussions.

- Nick Desaulniers (LLVM maintainer) is also interested in attending and
  participating, provided other compromises he has in May don't get in
  the way.

- More? (Please add yourself to this list by replying to this email in
  case you are interested.)

Would the BPF community and the LSF/MM/BPF organization be interested in
having such an activity?
