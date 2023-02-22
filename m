Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC369FF66
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjBVXYL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBVXX4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:23:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC6B3B87F
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:23:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGTEYD008605;
        Wed, 22 Feb 2023 23:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0kE1YCtx+VdUxWuZf33HYPYx0uEYHLKloeohiV9sJrs=;
 b=p0i32Nt4KCS0aYBf5/LrFsSDwBOWUgHF9CMk2JByuc/7SxYjMFs5b/ewp/09OnMqNUxr
 jUYOWCBzsXKHR1bFI18oge2KmJxYcO58W6HrSsLXBc0hTenBq1/kpiEhA7/t22tewOwK
 9oCpA5p4ZaIa7G8gPOjVBD2axE/MlYXUZgYMpaYdsZwaP1pD8d3WYsxfAZt24RHH5wrq
 Wre4/s7YJGuxTx5dkZuRCPZCzEGqEpKv+owSN879zyrGuI1AScBZyeXKp0DdSR/k8pXw
 dZgxN214+MkOcAkXeJrvW38nkDxOgb8SGFTJTD8rJoaYGKxRFBxzp6/zziUIiF1ziGjF Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3ha82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 23:23:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MMJwmi031274;
        Wed, 22 Feb 2023 23:23:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn478att-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 23:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhIkiepsYNuE1iu1xWnnz6SVHoApSMYlXoHT7D5pbDHRvBDbSkC8TA1aXappl0AOUz+8o6NKMpqUE+usAAB3TRuK47VKvtE4+EP7qMgZ1pPg/ioNxaXWafcKkz3QVLIMANDJAVJxx/I51sn6mBTGVNYyJFPd9wp6NgAHoNLavJt14sUdtmVaFuaSk+pPnYOCHnemOI67FLOmAGfqrp0IIepNVbBY2fJtnftwrYcCt+T6n94xZ9soEJckmVvfzgpp6nTrZlynDJq7UDCbyvseRz17+IjX4ztmV8OZvCBt/bpxgE2xRha7xbPSa80YB2j+4GSBy4l/bxmbxXGk0DFS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kE1YCtx+VdUxWuZf33HYPYx0uEYHLKloeohiV9sJrs=;
 b=ZaQ4+vUZ7r/6j8HRBR5tZJokdBTdRIPzchmy/Q5TsrvooDfQeBGEByEh2WsKwuSjBBhdW8GyFKVYmDLuzBf1aoJMJBTuo2y8YuK9CFETkbL4rrefaNCPMDpo7K4eB+TTCF0MXWbQeEXLdf9MQyjLt4WjplZgdk7hsPCUWyD1ME0qX8Xr+AT12XbcaXfTZN3na1Mu9qzV+T5/PUhULp66qlyOO0QByUQMwTMJyJ7r4gQR3A7/PRsqrRTwsVN3WS5GdQVqn/qsIyYsvEeCJyFcSNndTAmyiTBy8sZNSOXdxPAR9w87OHD5CyTgLqPYdSHA+I9ESwOvNMyZK8+VO9uVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kE1YCtx+VdUxWuZf33HYPYx0uEYHLKloeohiV9sJrs=;
 b=Bc+QNSSHUUPX3XoY6fw64kBI2c2XrrZMFfCckX3nUY28h1JxfC3bDO5/YnrxBRnHgqJSFr4YnfKUVZRjH5j6zPAYcx1bZ6y1U3qJ9LZTOWVQsg/ZsCfeCpb4md8u2vTnkWwWmobWE2aVASbl3AJrAQAk0A2p+oNRWrgfxaZSZPQ=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 22 Feb
 2023 23:23:47 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 23:23:46 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
In-Reply-To: <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 22 Feb 2023 14:10:49 -0800")
References: <20230220223742.1347-1-dthaler1968@googlemail.com>
        <CAADnVQ++hR7Cj3OXGLWpV_=4MnFndq5qS8r5b-YYPC_OB=gjQg@mail.gmail.com>
Date:   Thu, 23 Feb 2023 00:23:41 +0100
Message-ID: <87ttzdwagy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f1d03-172d-4f02-03ec-08db152bd894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQ72dB+/P/iH2As63PZKvkDJbjXljcZAdwmTEqQv89S57uATj97WrX0uU8KvH1ACJBf9fYCD9gBHpW+Rd0HQZDwTiz8K7pUWQ/wjWxpl96WclzSk7O+vz7+vASiGN67eLGqXEPNgoevs39qVJ3KmU8tB5J335nAy8X4Q1bdnukqeZvXjOh96Ped1RBIaoat8SjqMze4J/ejqShpyHfdP/sqvVLUtXA2OyosRyaD17BEsHVY7GRjwOLlqz7HM92/ntUAPLEV+l3X/MDdLCmMCzdBqPmdRcO53d7RTbfdRNtKrEj0DK8bSV7m5TgOquzVtId2DeN+96Xb3ilnVGHQSawNdyquqePAnyYSGDkOefue22noneQrLeP2Dh8RwOpXnInqS/5HN6tFYLHuymkzYGdYzFrLbJHxi/nLoSqaBu+uqa5oGB4LoEUv2SLvMabocGoxz2Lh4HoCCmSMWkyoQ3FlKPpbWGqXVWoSUjMsBM/bQyXWT6xPpHmzg8HtfOSj9AmsqXuq4gs66Ou7GwgNOqSJ9H/VrbTZ8JXetKC62iFtTDmz0G105sgs/Mxzwg3tCgnUKU4EKreBue4QA0pFx55n9mHEl8hnK16H2Ck2uczKrZ2WzHh8tRjamtyTVS3I09aBA7uXHiVHSL0limxw3Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199018)(45080400002)(316002)(54906003)(41300700001)(5660300002)(26005)(478600001)(86362001)(8936002)(6486002)(66476007)(4326008)(66946007)(6916009)(8676002)(66556008)(2906002)(38100700002)(6512007)(6506007)(53546011)(6666004)(83380400001)(2616005)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dNTnbkDB9jDKFevHvIgkqcsSxX/QpZu9lcPajNLTValvD0mIUaGCHERAon8P?=
 =?us-ascii?Q?cIXJD6fNyI3uy++g8C2niM+o6iZ4lklOtSn8QLfejfNgtJRYPT1tYDT1CnLK?=
 =?us-ascii?Q?wID8h/eQwYXO5W9Cq2K5Ott6pgsds9pI1Aw8x0Sy8iqVqrL6Uy2euHy5eVVt?=
 =?us-ascii?Q?JVjlqaYmrP8qnu1sTsIRVIce8C5YpJKgEn5MtShsGTxHUcoCgkHIwG2SOwA+?=
 =?us-ascii?Q?gwTXQPsRQAJ+PK1eAsYTdUJIaR18/9e+oYcei5Uj9TwzTUZRUWpzJJ8XhljY?=
 =?us-ascii?Q?jgd30ootajDSUcx6LlzEGxYrbXiGLYu/RMMxL3RJie/h5ct8WU/9ioNKMe6b?=
 =?us-ascii?Q?x00yIXbGYcrDrnjeFdDyGEOeQ5I0IoSRqnNHXoUGU8DQRW/lQIGlvvZjLM4v?=
 =?us-ascii?Q?zWiRpD2gN5w0aAVZwPHkryvoPUJIRePh67UbPUT0GlJ2u1TgfkISm8i+GMCP?=
 =?us-ascii?Q?U0e+HZ8BQDp9kr8soaAyq5/Acq/iv8id2Vh4D4r4pe4QhD5YrxujSJeh/ouH?=
 =?us-ascii?Q?W9OjPtLxjk5n4Nv/RCHh8Pp1zSgQPUKhf13r+OykBxjFU+J9bH7nMF/Eogzk?=
 =?us-ascii?Q?WQy3HHak7YlhZ2K14UANHaZSBwtWRhixTUZVNkkoyCwWtYV3oklP8IlQPQUY?=
 =?us-ascii?Q?xMJtTBk2xxSUlZPGY3SMTu8G6U3OWzHn8QYcKH9Ccjq48HwKlgvKYQSFB5wF?=
 =?us-ascii?Q?1a+hu8Jv9c/B72jGv7gA/qA4b4+xqnS8LNmqK8ufp0ggTbVb3P2tOiG5F4H7?=
 =?us-ascii?Q?B3WsHERM+/NtNPBVdTY0sqVqkacFH+8SftZAqeg3e3i71n9b7m/Gm0LTZO4F?=
 =?us-ascii?Q?ei1Li9EdsOB3ywPNrCOMfTS7bTLOhgZqd4PLhgNb3kporx95zWTshI6ZCxHZ?=
 =?us-ascii?Q?H+zUvjm8Gwrub+nT9T2R1WDfC/myKkPFZfdPquO0NLc1eZ/vtXXGL40S0iUo?=
 =?us-ascii?Q?cgxXRpRmN2aLwzUy3aj1KZoyHu7Hx3Y8IW20Lre5mJD34be3pta3ohweKkrz?=
 =?us-ascii?Q?e2OZf5zl1Mmf51Is1+JF14NropnWgiXnsGdQyX3qYvPpleEegfuJSmCekxbM?=
 =?us-ascii?Q?dyClcizkcAUO5wb2XHedT4F4qJMZ3yF3/EMREN8e7OAvhrgpX01BHJpkXo8Q?=
 =?us-ascii?Q?j7ZhFdlFyTiU40Ey4rfwumHWIZAKrPWuxatIxf0aZySA4lfaaBtHIGolCISZ?=
 =?us-ascii?Q?MCAyj+AIYNBpVMg3DiFPwOs2b+ZaAE7qrs/YeoU6nSMXqBRD7d+AM3DXopwK?=
 =?us-ascii?Q?SbohuiOqTuFPkUqVqKO11UjeEEa8QixUL72kKMeIbHPE6DI2m0+etGLMq7nj?=
 =?us-ascii?Q?rgXNDIg9Ko9FLgM00PngPqtdHV82x0CCZPo15UZH5tmaXzyaSXY5bT2wSsIR?=
 =?us-ascii?Q?wIKM8Yc7J0N+heQ0Y7KNkNRSpL0N5+pRURTxJWmFqKhcXm7YgNwx1j7MqSjh?=
 =?us-ascii?Q?DVD+Q+mhi020MbSRBL8Ub6TTMz+8dpYlGItSW5S+sN9TWqHR2VbBmenilhwb?=
 =?us-ascii?Q?Z43hau0STtbsQt+iKK6t8/Zgr4VQP6g4FoV+nUORPWEL0oRlZIlxPXTb46WW?=
 =?us-ascii?Q?U1wo4eM9KtZNudzTaVl71TAv1utuzFIrng8lYTI0PajUgkm7MFH16rkRegTI?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kX+6XPoyUbSXG9iuKIUewUG7XBVY1FpN5egfpIyCeMFwiB14cJSbPpXiV9jmxD8V3LdqE+MroqDE2xz7AHqq+t+VoIREuLQ73Q/J8LTzWMBupZCKUXT5LBrb1OJTWx/ZP7XVU5ZuEE7grOc1ZyofA4gUU3EfTRSfcXF9RsEQdYudY44L/OtzAZcS3mXjZGFBG2LD63ruoRKSdnhwPVLmr7LmZ5XtE3HRhDKKENvTB6kByFay7vIiliZmhK8AMK+CYZJnpOe8dhG400uBc9EAg43zjdfW4vB2IlpJ57NdgsawmZ+lnoVaNYwfM+gg8zGAnq8u+K33m0S57DmDSZMp7K+Uhq1AQI2TsivHgKNsDEU6Vk0kRWZc0UYmcnnsZfu+zHaU8J9Mz/kLSot8GZfAM3kpC5X4rkYilo1BLMxQ/pjkxzm7lru0Lh+fvsYsi/li/lICKdBAMU77kGPXvj07ZgMv4C2twVorRc8sSeaKc4IfA1nClMh35V9xFBlXY2xVupxGfl1Y+kPif7wfGOfbsH0q8Q1vSn7oX8gi/7jyn8moXaH5+A4G/ua32YSaW1aWwj+O7uuzDPcFXecBlbTpvmqDiMXufb9t72lzUhS3tq5dx46nZBxMlXZLC6Ts6dNBab9IjeWg/lE/yqU+LAVTndG2+6Sg7U5QAoz7cRLJym/Rm1QdBaE1cyUwKPMnEJkhUPCHPN/iXgVPyR+fgFnO0D4C571zL5g93H2w7t6ctYPuQYvSb/akBzG/pZYh8Jk6159AAbojmlqt5zYTbHkZzcTO1iEPXSlYRPYJ94zyPOAmfsuqr5cs1niTWC/UdYUZmnHaEVrfsqf5KEyfuO8h/Pa1C94lr8VI6v6xPtgXDr/ADisKXKEmH3P4c62oT92beoczOdTeOvkhK6M4YC/ui6j85bCF2H3Vch5rMcFbkXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f1d03-172d-4f02-03ec-08db152bd894
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 23:23:46.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhKNQzjSAiOIjbCchTQhCaRFTcm0dxqvpt74J9PMJMg1kcqZYJ+9PDU4+SHGvzdY79wyUP3BkcKBEA189Z762krZv9QZz3MhvMvf5JVN8Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220203
X-Proofpoint-GUID: _fQT1c77_3AyT07y2HL4POiGrUPD_NWA
X-Proofpoint-ORIG-GUID: _fQT1c77_3AyT07y2HL4POiGrUPD_NWA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Mon, Feb 20, 2023 at 2:37 PM Dave Thaler
> <dthaler1968=40googlemail.com@dmarc.ietf.org> wrote:
>>
>> From: Dave Thaler <dthaler@microsoft.com>
>>
>> Document the discussion from the email thread on the IETF bpf list,
>> where it was explained that the raw format varies by endianness
>> of the processor.
>>
>> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
>>
>> Acked-by: David Vernet <void@manifault.com>
>> ---
>>
>> V1 -> V2: rebased on top of latest master
>> ---
>>  Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> index af515de5fc3..1d473f060fa 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -38,8 +38,9 @@ eBPF has two instruction encodings:
>>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>>    constant) value after the basic instruction for a total of 128 bits.
>>
>> -The basic instruction encoding is as follows, where MSB and LSB mean the most significant
>> -bits and least significant bits, respectively:
>> +The basic instruction encoding looks as follows for a little-endian processor,
>> +where MSB and LSB mean the most significant bits and least significant bits,
>> +respectively:
>>
>>  =============  =======  =======  =======  ============
>>  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
>> @@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
>>  **opcode**
>>    operation to perform
>>
>> +and as follows for a big-endian processor:
>> +
>> +=============  =======  ====================  ===============  ============
>> +32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
>> +=============  =======  ====================  ===============  ============
>> +immediate      offset   destination register  source register  opcode
>> +=============  =======  ====================  ===============  ============
>
> I've changed it to:
> imm            offset   dst_reg  src_reg  opcode
>
> to match the little endian table,
> but now one of the tables feels wrong.
> The encoding is always done by applying C standard to the struct:
> struct bpf_insn {
>         __u8    code;           /* opcode */
>         __u8    dst_reg:4;      /* dest register */
>         __u8    src_reg:4;      /* source register */
>         __s16   off;            /* signed offset */
>         __s32   imm;            /* signed immediate constant */
> };
> I'm not sure how to express this clearly in the table.

Perhaps it would be simpler to document how the instruction bytes are
stored (be it in an ELF file or as bytes in a memory buffer to be loaded
into the kernel or some other BPF consumer) as opposed to how the
instructions look like once loaded (as a 64-bit word) by a little-endian
or big-endian kernel?

Stored little-endian BPF instructions:

  code src_reg dst_reg off imm

  foo-le.o:     file format elf64-bpfle

  0000000000000000 <.text>:
     0:   07 01 00 00 ef be ad de         r1 += 0xdeadbeef

Stored big-endian BPF instructions:

  code dst_reg src_reg off imm

  foo-be.o:     file format elf64-bpfbe

  0000000000000000 <.text>:
     0:   07 10 00 00 de ad be ef         r1 += 0xdeadbeef

i.e. in the stored bytes the code always comes first, then the
registers, then the offset, then the immediate, regardless of
endianness.

This may be easier to understand by implementors looking to generate
and/or consume bytes conforming BPF instructions.
