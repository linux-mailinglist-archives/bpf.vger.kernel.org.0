Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3765E890
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjAEKDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 05:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjAEKDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 05:03:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AD119026
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 02:02:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304MEKiY028230;
        Thu, 5 Jan 2023 10:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Ltj+gSedoMaxUfVKYnHlamABotqaillkGAVtTmbm/6A=;
 b=ch4f0uYt1Va68cWotLL2DCR9cjVOM4FWSBE2L/0H2sqhTNFALYwtqQMOvJOe45SgS7q2
 7HqqZgRMTMFRra2dxwOC/OrFOeEYCnX+UqHbPPScCzoSqZtmI9xhbZxZ9o7Q45iMMaxj
 xgMZv/6Ek6aK66iUCLk+K1Kiuyk+cv2apXkuoyPNvOisluydYr1gAISgp57wYp811pO2
 qtRBZUitEeUjmhxmfRHG4rpNPpjhVTZH4VT5kj2I0qklqaw8HpmlAmWtC6zdD4W6RhmP
 J1NVUrRM3HIT9eGQ7jtbhUzA/zMYY2LxJ9ezdBpQ9ROmR2I+R+1x9ABeqJJeIDEIXqYs tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtre9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 10:02:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3059nQVX021684;
        Thu, 5 Jan 2023 10:02:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwepsjc0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 10:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7AlxLsseg8X2lmg1nQUDAvRHyD+Kr0GqSlA+a4YvYOxZPqLWdHrrgF228jl1pIz0101s8jLZ3NEqgF452uZXWD5TsRlWb+up3Cmkt9peBXtikimsKn/QTyZoYgYv5psJISJ8ih+FQsBetwzjhbMpBw5LbmmYZ0oHm9rm3u3p219nT0pvsSSkckmYV+jUHrmCkwm8Vr6J6pK22xsLsUFXe3NR18zoTpgsFW5+O6YjOgVoicxWWiiKE71PI5LkORKah/FDbxkHdvJWkjIhsdy9z/Zq5Y+I68HAt8mBEnnpvRWE07m7u0xBbejeb4SiDV0K+yaL8Cd4Bu1RIfHQKqBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ltj+gSedoMaxUfVKYnHlamABotqaillkGAVtTmbm/6A=;
 b=ewb86uvKIQA5RVivUqRGG6Ry6GfUb1579VCD7jsH7byK9ihuQR0LuVTh6ujO8Mt7KVrecAtmAi8iXnanYk0N+birffJOxKIQsOn+1lsMuTOfXv6bMexTOud6iF3QvBjNses2/RJww6fQlcOAu1PH3qkeexLjXg6DzKu8vxy8mREyxrvOPJI8wCsBKqn0Pf8fmI2/wb6pyskZ2UcwSqxWgyBKsoN9ShuSaBGRtUqaEDof8RhaL5xBxc4qRPmR7NxRIXu5Asu9q8F3Vghj1+qPOZQifFm46MxL1UjOUoftmFpM5mI6a/zAVCsJfc1GbRuhPvGfQFlO0qK0UujOF5YSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ltj+gSedoMaxUfVKYnHlamABotqaillkGAVtTmbm/6A=;
 b=QP1u1eSJkBnX6QIc3thkF6lG013TivihOt4rQ5P9aUu/bJBuFO1I17MVhs5HlvxANAeKb67xjjQYZYmAKt9b2ZOaMsdc8YNzFIQiW5z1Y4XYqv+ruwC9k97peN+di8A+noIGhvcnY6Q5mFW1m1R9Wuna+Pzeoo6gaY61ZakNGSY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:02:02 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:02:02 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, david.faust@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
References: <20221231163122.1360813-1-eddyz87@gmail.com>
        <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
Date:   Thu, 05 Jan 2023 11:06:12 +0100
In-Reply-To: <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
        (Andrii Nakryiko's message of "Wed, 4 Jan 2023 14:10:18 -0800")
Message-ID: <874jt5mh2j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b6acb4-f62c-4548-2b39-08daef03e43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hg6ci8P+ydzqPZg+tfYT3auw6hQUADQ9XgIqmeomEnYfu06vnQE4txhr7leBpX/xmIIgvytfMMmt12rcdCfYYC6w85+LbEQYVAuvH+MAXReZl4awf+cmukRoBa2basmaFUNVXNpuISBLTc3QK0ZQ3VmJKah8K444jQz4NdkyhkoRD0OL/mklIMHFJm3yzgWqTq1xn2EjxYTzyuet+tlMMKlpdGUJOqdygVORi4L9kD13DTuD/O8BI0Qq0AXY0dSfHLWNrMTyE+hVcOrJFn1INI9vLyIzXY7P1rQmslQ7wchkq9ruUHD0Hp9iySlKdsoeIv3gojzFPLaboo7amCXRG4WgnuCfNRJaqF3whD5XA4N+MN0LPT/2PVg/hXfYtf3/zdQX72hlImQL0KVqYaMcasXXIdeXa7I2PJ6D5ysPnimDWDnJoCy6csLen7c4GTJIixdDD2SxwvMzK+J8DK5oICPKTMnnH9e8cDExkah4LGG0sSWHvQmW0UXtKGjTmclH671MTKfmFCOpk+HES9wArJU+zh7sFju0dwp3f7g/FLMR6fkIFERC4ogIXF76Elysvdte8vdTI+A0CAs44Fii6JnmQLaguVZCYxZ/lj947LmsrKaXAioh81fisQh430Z8aYvqD0uDG+xSJajp00zuV6w68mbgTJBOhvlbAV1LVp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(83380400001)(86362001)(2906002)(8936002)(38100700002)(5660300002)(41300700001)(478600001)(6666004)(186003)(8676002)(53546011)(6506007)(2616005)(66476007)(4326008)(6512007)(26005)(316002)(6916009)(966005)(66946007)(6486002)(54906003)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?basv9XHRrbnSsr7yFQNdehCTCiRijSZsmNwLMk3uOCEmGbPDMVU8hKB4teKl?=
 =?us-ascii?Q?G5VbS3hftWx+qDqgNX1E+TQ576N+QjKLnESspYmJx+jKSPDPt/p5GgypTzfF?=
 =?us-ascii?Q?QyEZ9ak9tmkxTfcA+VbGbRAvbiJdbORD8nn3be2rTsiHyDWGPjGlQGcmtnnT?=
 =?us-ascii?Q?JDh5QGKUpv6sfRikt8GetV6U46AaCO3VZbziWohMEVSYFKTQ/gAEg1nrgl7h?=
 =?us-ascii?Q?9Olq+KweN4WrU07k/sP5C4yv6z4cjRA0JbR+QllA90hOQ98Wl7xgGRGcAXww?=
 =?us-ascii?Q?p3mYzW7I+vDLWEzLUB18i7xr1hEji3eYgi2p5Al2sefnHYGqZXV5fK3pX4cj?=
 =?us-ascii?Q?e5+ubNDO3wklPg2ADBFj/vVbtVJANSoW30nQhwfU/NOz177+DUyzPpo9HP3r?=
 =?us-ascii?Q?u/pe5/wfxPvkCoWd82/3CoC1smUFhyCLcLG4R4X6JBUExAunTY1ZloDHCkKA?=
 =?us-ascii?Q?lhXG83n+dnin0K2mppuQtgwrRfE+rYpXxRDq8ga8oK6JvwzJXh69zUjDdsgh?=
 =?us-ascii?Q?PFkj6ljM+TsVd+eG7H0GKustlwz9OcqM/nCgVP1MA+JQ64Q+4UL6yAFbInP6?=
 =?us-ascii?Q?2igxNmb31ie9VxBQ4LEaAFETISOcLa6J8MHA1ziTK51hMboON+S7ZyM7HrA2?=
 =?us-ascii?Q?LNQZ4nkibuinNnz9RIdiaFKdmtC6lUYpdnDdsFLqFXFfsRc/OIbzWPKRn/xz?=
 =?us-ascii?Q?XDcLCm7ToE4YSQQF+Ky6yHBZREMdn6wXqcbjfH8PTBKoKI2iWi7/BiA7a2lm?=
 =?us-ascii?Q?jTKuE4QhfPG6Cdq9U0LXVtllse4LZMxzBtL77fv3w43P5jnd0/Wk52bSxBAw?=
 =?us-ascii?Q?FlC8OyQ29JDYTPzBYg/jmlcuBf5t6paDiSvk4YP9GxvCeEnPl0Bpy/E1aXJB?=
 =?us-ascii?Q?hwWd15Hjcu8yhAqp6ADS+G5OUlgDl8p0UvdHT5jGYUQIhEMeY5EwwZMsw6V2?=
 =?us-ascii?Q?HEeUkFH2RaMF3SqSdBvO3bJGqP8r+8TcUE4tB9Ky6IqnyVkiEqTkOmxy39WS?=
 =?us-ascii?Q?sPB+RZNei1zJozRSro+kww6Q77WhMW2SbwQXmLi1E94W6KMF6FsZ3164BP3q?=
 =?us-ascii?Q?hVBMizTe+ckzY3H9u0MjzTJ3XPZaLewx9UjPsPFUvaxvOYau1GfjIbJOdbRm?=
 =?us-ascii?Q?NyhbLMQh45TlBa4mMslNNGTIcDiClLftQQuemb/G8fgagZEdNzTtXzdDF3Zu?=
 =?us-ascii?Q?eE/qtszlaXU0cFInR4LnNlb8FZbljeHvoAXBVNJZg+rrxrbsTHQa6XXID9xT?=
 =?us-ascii?Q?qT/1/z3kIvRn7wfbk2hMrCG9AaD3BYqdjOKsDYLCeY8G3786fThLnw/BiJDp?=
 =?us-ascii?Q?IH3eVSrbX7I5URlbjTQsv9L/g0h0+to+bR0Sq2xXRbFLhOOAWIHOcleTgroY?=
 =?us-ascii?Q?7OJFBrF87NzOJeXi/up4Wo+Xj6t9MYXR30DZ8H99ybH498Yct7/yg8KGMKWm?=
 =?us-ascii?Q?aY4bKlVkejDKa1ofSjWqdqCOEXNuzH1pIduoWrVVikA4oDNFF9mW34YlH1sP?=
 =?us-ascii?Q?Z88mWCGS/edLFGjks7DkXQRk+Zjg9XJmv/ZSM/P7OGe4DRzMyiqrk+un/Cq8?=
 =?us-ascii?Q?nVPg/POpdA2DQkBG874dhE+HVdOVxDLP4KXZCaTZFmP08mwwP4DoyZBGY7UE?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cKRzf19QayYp6U3wKeCHRXBYusDqomq/rewpw8m3prpJmq/tC0Elzw6aGGSk?=
 =?us-ascii?Q?+db95MKkxQxsnHLQVzpYZ2IPQuGyqiGXW+LH58N3ir4W2FebgcSbJ7bqQKmd?=
 =?us-ascii?Q?EHPyZsVG4bg1C7AeCatUPvFkPT2XabDw+KK8D5K+h+DOQp9yNo+xIULLf9er?=
 =?us-ascii?Q?qJVLtTwHVfST4b9ne9TafRF5X1sqgGIi76q1Mcu2amiYl4luPR77W+JwOnHF?=
 =?us-ascii?Q?8wK2XFfIKBLSyOme1s3uaGvdLuRdrU1HxXcLrl6NwNihTUMMIaBaZXM2mkoF?=
 =?us-ascii?Q?K7rrCGnzsXfPIsVIZ4v/z7xpvunBzmNHayF4Fx+NSbhcMv+wM1+MOj+CNH9w?=
 =?us-ascii?Q?84HsUO5c1mlBdPQlUQm/NoydKKsGTFFhzcNWSi4XHDmyypQfNVhzcRSz/hg0?=
 =?us-ascii?Q?X01XtmeTZWlgMTcy8AWPBKUuYbOARqCkI0ENGrZ/8RU1Gz6nqEOKbzFIl+Ge?=
 =?us-ascii?Q?hbfWvX/GpBZvIAA+DGopr/Y/sfDM7Vf82Q3sThK/m7RwWvE1DI56HxXrpoZ5?=
 =?us-ascii?Q?9buUwLiurvcWZJBswe8YQxCODk4eNzcU8y2i9rMoZE/kCOzfREoF2CsPps85?=
 =?us-ascii?Q?hgTcZRRkNYCeC2aDABuLwIlIJegqp4ASNobzt5acQLqgZ4lEN1t7k6PDnrvI?=
 =?us-ascii?Q?5TfJ+cCPJFyW3c8LgLkb6EJSLWUQMhNkbVKmFVctyU/juNFCPeK7VCmB5dhJ?=
 =?us-ascii?Q?xKlZY4hWnYjepPekSGLuyXupm4lnohmxrQ4Eb6mWb2MBOoquIB457mQeYIPO?=
 =?us-ascii?Q?euebRHPpw1fvuCYM0lvKeA/Gyc78IcbBnP49oMl1vJT212xDpMPHMIQFQzCm?=
 =?us-ascii?Q?jb8kpB/YrA8oGGQiQ8sCoPUdP2x026KKUppKhis6nufwH3+aQvPgBhm4ZkV2?=
 =?us-ascii?Q?VJeapmPtSi+L8mKKRWa4KZmFEs+GPqt3WfshHJPHWBbv7EEva5hrfGcKlBEo?=
 =?us-ascii?Q?+TYxPjDRKTRrP+/OHsscPv9EGQ3gkvrk0ov5KHVHsUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b6acb4-f62c-4548-2b39-08daef03e43c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:02:02.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6u+eWNLNZrpRi5tTDE2hSKShHNDN3wvw3Wb/42TteD77DT04eFguq300v4Q78xibGFMoK5/WEYif22+odNriFKZ6urpgaxwx7K/ismq+Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050081
X-Proofpoint-GUID: qr5mciGXyqmfUFEGTVgq1ViBK124-Sv0
X-Proofpoint-ORIG-GUID: qr5mciGXyqmfUFEGTVgq1ViBK124-Sv0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> BPF has two documented (non-atomic) memory store instructions:
>>
>> BPF_STX: *(size *) (dst_reg + off) = src_reg
>> BPF_ST : *(size *) (dst_reg + off) = imm32
>>
>> Currently LLVM BPF back-end does not emit BPF_ST instruction and does
>> not allow one to be specified as inline assembly.
>>
>> Recently I've been exploring ways to port some of the verifier test
>> cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
>> and machinery provided in tools/testing/selftests/bpf/test_loader.c
>> (which should hopefully simplify tests maintenance).
>> The BPF_ST instruction is popular in these tests: used in 52 of 94 files.
>>
>> While it is possible to adjust LLVM to only support BPF_ST for inline
>> assembly blocks it seems a bit wasteful. This patch-set contains a set
>> of changes to verifier necessary in case when LLVM is allowed to
>> freely emit BPF_ST instructions (source code is available here [1]).
>
> Would we gate LLVM's emitting of BPF_ST for C code behind some new
> cpu=v4? What is the benefit for compiler to start automatically emit
> such instructions? Such thinking about logistics, if there isn't much
> benefit, as BPF application owner I wouldn't bother enabling this
> behavior risking regressions on old kernels that don't have these
> changes.

Hmm, GCC happily generates BPF_ST instructions:

  $ echo 'int v; void foo () {  v = 666; }' | bpf-unknown-none-gcc -O2 -xc -S -o foo.s -
  $ cat foo.s
        .file	"<stdin>"
        .text
        .align	3
        .global	foo
        .type	foo, @function
  foo:
        lddw	%r0,v
        stw	[%r0+0],666
        exit
        .size	foo, .-foo
        .global	v
        .type	v, @object
        .lcomm	v,4,4
        .ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"

Been doing that since October 2019, I think before the cpu versioning
mechanism was got in place?

We weren't aware this was problematic.  Does the verifier reject such
instructions?

> So I feel like the biggest benefit is to be able to use this
> instruction in embedded assembly, to make writing and maintaining
> tests easier.
>
>> The changes include:
>>  - update to verifier.c:check_stack_write_*() functions to track
>>    constant values spilled to stack via BPF_ST instruction in a same
>>    way stack spills of known registers by BPF_STX are tracked;
>>  - updates to verifier.c:convert_ctx_access() and it's callbacks to
>>    handle BPF_ST instruction in a way similar to BPF_STX;
>>  - some test adjustments and a few new tests.
>>
>> With the above changes applied and LLVM from [1] all test_verifier,
>> test_maps, test_progs and test_progs-no_alu32 test cases are passing.
>>
>> When built using the LLVM version from [1] BPF programs generated for
>> selftests and Cilium programs (taken from [2]) see certain reduction
>> in size, e.g. below are total numbers of instructions for files with
>> over 5K instructions:
>>
>> File                                    Insns   Insns   Insns   Diff
>>                                         w/o     with    diff    pct
>>                                         BPF_ST  BPF_ST
>> cilium/bpf_host.o                       44620   43774   -846    -1.90%
>> cilium/bpf_lxc.o                        36842   36060   -782    -2.12%
>> cilium/bpf_overlay.o                    23557   23186   -371    -1.57%
>> cilium/bpf_xdp.o                        26397   25931   -466    -1.77%
>> selftests/core_kern.bpf.o               12359   12359    0       0.00%
>> selftests/linked_list_fail.bpf.o        5501    5302    -199    -3.62%
>> selftests/profiler1.bpf.o               17828   17709   -119    -0.67%
>> selftests/pyperf100.bpf.o               49793   49268   -525    -1.05%
>> selftests/pyperf180.bpf.o               88738   87813   -925    -1.04%
>> selftests/pyperf50.bpf.o                25388   25113   -275    -1.08%
>> selftests/pyperf600.bpf.o               78330   78300   -30     -0.04%
>> selftests/pyperf_global.bpf.o           5244    5188    -56     -1.07%
>> selftests/pyperf_subprogs.bpf.o         5262    5192    -70     -1.33%
>> selftests/strobemeta.bpf.o              17154   16065   -1089   -6.35%
>> selftests/test_verif_scale2.bpf.o       11337   11337    0       0.00%
>>
>> (Instructions are counted by counting the number of instruction lines
>>  in disassembly).
>>
>> Is community interested in this work?
>> Are there any omissions in my changes to the verifier?
>>
>> Known issue:
>>
>> There are two programs (one Cilium, one selftest) that exhibit
>> anomalous increase in verifier processing time with this patch-set:
>>
>>  File                 Program                        Insns (A)  Insns (B)  Insns   (DIFF)
>>  -------------------  -----------------------------  ---------  ---------  --------------
>>  bpf_host.o           tail_ipv6_host_policy_ingress       1576       2403  +827 (+52.47%)
>>  map_kptr.bpf.o       test_map_kptr                        400        475   +75 (+18.75%)
>>  -------------------  -----------------------------  ---------  ---------  --------------
>>
>> These are under investigation.
>>
>> Thanks,
>> Eduard
>>
>> [1] https://reviews.llvm.org/D140804
>> [2] git@github.com:anakryiko/cilium.git
>>
>> Eduard Zingerman (5):
>>   bpf: more precise stack write reasoning for BPF_ST instruction
>>   selftests/bpf: check if verifier tracks constants spilled by
>>     BPF_ST_MEM
>>   bpf: allow ctx writes using BPF_ST_MEM instruction
>>   selftests/bpf: test if pointer type is tracked for BPF_ST_MEM
>>   selftests/bpf: don't match exact insn index in expected error message
>>
>>  kernel/bpf/cgroup.c                           |  49 +++++---
>>  kernel/bpf/verifier.c                         | 102 +++++++++-------
>>  net/core/filter.c                             |  72 ++++++------
>>  .../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
>>  .../selftests/bpf/prog_tests/spin_lock.c      |   8 +-
>>  .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
>>  .../selftests/bpf/verifier/bpf_st_mem.c       |  29 +++++
>>  tools/testing/selftests/bpf/verifier/ctx.c    |  11 --
>>  tools/testing/selftests/bpf/verifier/unpriv.c |  23 ++++
>>  9 files changed, 249 insertions(+), 157 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c
>>
>> --
>> 2.39.0
>>
