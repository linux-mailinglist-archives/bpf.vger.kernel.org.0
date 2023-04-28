Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30C6F13A0
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjD1IxJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbjD1Iwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 04:52:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3259D0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 01:52:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7iDHD032664;
        Fri, 28 Apr 2023 08:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=y3Wd20+eyTfXdAllH6KUIyuAuRIstbk3aje14ooec6E=;
 b=cUzTGUIASx4t46l51mr66+XDzNPMU31o61DG1i+CY1UamzyjKM4Q+MSuauSKvGWIW+tt
 apd1KB+mIgcFR1DZ8GTsOtZgkSooUJSiWO3TZM/Cf616RZfka9adD1y/YDLZfMjNd3g7
 FWRSoUw1ORtPi9wcNAhiZQax9SiChopcdx4CYJ2dS7c9AdLJOXaqRO6pxjOt8hOH2z+m
 xG8pPMMi/Wn+jU5cVFIRZDWejMcTWOeAuMYBa2dxBOLCqI4mVuwp2br1Q880SgMPOc/W
 b4AY9ro36R1hLtwWXJ+ekmx0twOrq6uXcfWw18uuHD7Sn3QFWC2b2Dety0vcRVYwG2B9 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47faws51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 08:52:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33S7Ot4g007142;
        Fri, 28 Apr 2023 08:52:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461afy2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 08:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f69HUx0/bq5YZj4Nq0mJ/8dofMY9fviDxnwAj+7OZVBzb2eiaYLtChqagk1O56BvJDR8Z25fHgTsp0jmdgHPf1k6kcknTvMQ9NXtJd2ETpLsoqRTR5SwNUb7Axmt7SIFzdHHD+GPPKxwhpwtTrUMYXFIyCN2eSSulL8MDiU8wo6leKsQpaSxbh5mTs9w2z+8vBmGAEsUZzsrMFTK8ovNorlmu6YBJljzeUJOxa7v3WLw48Wv7p2SbBISL261jVjodFRihsylNrpu548C/CMkVy2YyZZ56feclq5yfUlBIaKYPicdfRQcaQO4XZ+mm0I7m/R5/J/FEzCDWmZEy0s99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Wd20+eyTfXdAllH6KUIyuAuRIstbk3aje14ooec6E=;
 b=XyfOfu4C5GU1RL2Yi+CgP/udx717/qhzuGeajJxjdrQ8iRv0mzatmOv2AUVJYMzakkTxwNh8jFDhI5d6nHFAhWITjPGAq+b7lhz5cDwioRG0eKNX0ckhIESG2Dd2RLwlIgrPwwhQjMBfnS2mSthB9QT/yifgf/EXl380j98UKcvfv//kVdtvMAi9YHhXFU7sn8QlM5ccMmyYvPZgcSy5rN6xAWT4fpkHhi3AO/jB4Zrh7r1a2l9julBZzi9lEcI7wPGvdSNCJooZZ3NNKIBi3XDX5T+morDSAjsrbI28oLEFtjfxTNpAA2pZXwOqtw7vC8FWmzx+HXWOy3MU1OSWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Wd20+eyTfXdAllH6KUIyuAuRIstbk3aje14ooec6E=;
 b=t9coN5f0pMIgvEee3vo/mab/3L0iE0jiYwwOts9WDKu1ptApMSMK6O62KWpkB4h0L44xlHsYw+6smr1D4i8AFwcdvtGqOfHAqvczc6Zb7LyUpEXIbu5RezAouuM8mSxiM9/qQMy+v1SO3j3dt19o9ivZS3SM7erNhU99V4x6uzw=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH8PR10MB6526.namprd10.prod.outlook.com (2603:10b6:510:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 28 Apr
 2023 08:52:09 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 08:52:09 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
In-Reply-To: <87zg6ufnrr.fsf@oracle.com> (Jose E. Marchesi's message of "Wed,
        26 Apr 2023 21:26:32 +0200")
References: <878reeilxk.fsf@oracle.com>
        <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
        <87zg6ufnrr.fsf@oracle.com>
Date:   Fri, 28 Apr 2023 10:52:03 +0200
Message-ID: <87edo4bd8s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH8PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: b2aba569-2135-4c9a-92b3-08db47c5d9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DikE2JqWGlIZULCEOXhZbCaKaxcea+BK3RzPAGRNnE6XuMtyJvaJA1n3VOIORNYtCvYsesG0yFWdEh5dOuxlLJ5sfHr6jG54nt09HHxGGyxy2QuhxUEyaqYXcZtxqVF/F1JnoKwDGGc/rsQwgQbMnWu0VTI0rd4akCq2sGTVyq/0NuChMUICx25ZPXFEsy5pmwlYJXt1RBBIHD3Cw88XfY1a64mQWBkEF4VMahHt5dfgZsCQbftU1HjDQd4iJsOp6UIk+uW9g+5VvYASBQmMm19/33CeC7yFKMjGAd575JaKtEoIU0sR16/G88To3ZkGgq7lKrYYMenZ7dND/+Sl18qrXJE4e9w7eHk+by3cznGsPmGeN8qeqe/ee+OpII2kTEwylIqp3/Zpy7zx6isvldUH7hdimyugeBbEkbqtFVb/H2P4MTxh1+Z2U+JCbxQtP2yzmO54Kz6T6bOmFHHbHYC5YKMW/IREMsJBQn0s+0o3yLMxCQRfgNLqbiZLoIJbTADy8EA+9wHKFfYM4ReGRmKqOHUPIHUPid+oG02O99+Lsx7q9BjAfwXMJ9MdZ+7WpeNejhCzOKvRTvSQy+81SediEpg9MdGNINMS9DpyeHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(6916009)(38100700002)(6506007)(41300700001)(6512007)(186003)(6666004)(53546011)(83380400001)(2906002)(4744005)(8936002)(5660300002)(2616005)(478600001)(36756003)(86362001)(66556008)(316002)(8676002)(966005)(4326008)(6486002)(66946007)(66476007)(533714005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGB7q+CN+Sqf+403jihxqLkITPBbcXqgKR6elQV7gMM2PLJgrYEMx0PDRBnK?=
 =?us-ascii?Q?QOKyF8fzDm9XmLOiAbPCjQavQu7tMKJERtLpbgaUWoApHr8oBbN1blSFW43G?=
 =?us-ascii?Q?zTyO37PA+/1HvaJqLjafuux+4QOa5CO3cnLgBHEcyXo/H2ej5fxXxZXKkQC/?=
 =?us-ascii?Q?xKSxps8TFZ5zzCyGAPC0sU6hkLZDq+wuWxX8GAGM4rXrRgju0dTd8Tewl0gs?=
 =?us-ascii?Q?jU9/RyiVEuTB8HUUAER8CUMAvgruDj1sPow2l5wS1ZVjl+gBE7MY2Msdl68v?=
 =?us-ascii?Q?zlPdtKlgFNoEnHChdp7sgn9cNtRAk8EISfbQd/4QA7IpG4debCgVNs/IkQxT?=
 =?us-ascii?Q?1bEqbl7ksVyg1pbi5xqfN6csoEnKpe+asrSIcIEjd1aEa5PNtmG/T+7LqbLa?=
 =?us-ascii?Q?dv1mocuNO1AzqNkSQZ9mLBWgCqOP8MMhh4OOeRiMaa9EYbCTWtQ0CkkulHDe?=
 =?us-ascii?Q?hcTJXSA634DUgBhM6fBV0bI7Po3CW6AuyTvV1sdoPT18ZgSQPKoWQv7xYhG1?=
 =?us-ascii?Q?4vtvY3lZ0+xEq2MAhJsEL2RFo0ih4oLnBXTGQQhMhCMMgkYKV4fFnvQyuqnO?=
 =?us-ascii?Q?cFy9NCzXmtkXVAOXqmkm2JfOFazlrv3Lz0E3U90U62yhrxuRXay+hTVl1JCo?=
 =?us-ascii?Q?wW+1yi13OViXOQQ0geFlglTZbVnbDkl+k1c0e1kTwztSbRuiqQ4/U7azqAjG?=
 =?us-ascii?Q?7t1SdobnLWuUMI3h9E/XCt+ilbmj33XRn3citBVTaRMAVfc7Xj2+ROLt0ed0?=
 =?us-ascii?Q?JN1uULq54PmbezVdT2jq894o2+f8w4aW1zSCepdaGzHPMUwVPb0k5l0zsF48?=
 =?us-ascii?Q?J8sItyiVqMUw0ywqUEb5RwpG/QhVGPzgibBS5ez/MW4YtSFQKL90nK83Wpq9?=
 =?us-ascii?Q?idyNlv+s5AZjGsboLU0BQxMRaIDlcbcu1N7mnsK7r3q0D4KZeuhMJUXpuvNB?=
 =?us-ascii?Q?cj0pgO8jQaVVJXgRYbxSmG2QVhYCYOkhupXr5BuKCxF64C8o8Z5w2WvgsTz6?=
 =?us-ascii?Q?Ofqc/HhfdueSPBbiOuL1K2iE53AVG+hRuLEacEDK+KLRFLJ+CFOUr0Ie7MIy?=
 =?us-ascii?Q?dNylx9wEIg86uEJshnsCBuNcYXWUZRpGqTv2HhOBn/Ey5pThE8tFRHIjXKjs?=
 =?us-ascii?Q?XVutyS1ra7ETDnR0DsMVplYW9Y1QV85KHnR8eVv4pwpxeBFlpHjTSNpziJgm?=
 =?us-ascii?Q?dGgp/1RlUGITmhgzEC91d3ZTSDaYglnEmbq7g8+FN+AXoNf1M4X9tnzWojXj?=
 =?us-ascii?Q?z82yGbLojKg9+JIGUJ+Bg7NB1afdAxPulqwynaXvl+dl35nztrAIRbxrmtGv?=
 =?us-ascii?Q?zopXR56AzaTfOTKO0RcR+TZrew3t/xi94MYl7n+Qn6iqrGWjooXJ1KZyI4bm?=
 =?us-ascii?Q?De1fiwWEvEYcHy3qHfjJuVY+mF2qYGbOIKpry06gGv63/fZjQmCgiBHARPLU?=
 =?us-ascii?Q?nwZn59azQNuWhQpeMpBOcW4Ls2Z+1WKlSkpJtCN5u+z0ihDPWRZgFguE6YBe?=
 =?us-ascii?Q?sAKNdXUFqMj8qai0tahIXDRo1a43EBm8Ihv1FZhm1govj0//t4DBhlovjtDB?=
 =?us-ascii?Q?KaQLCPlsUObOruBeOvB6m7Qcs7EAArj4vLKZxOePqwgxzQ5K4hqGKZ1Zbe4B?=
 =?us-ascii?Q?Ze8AYR4RoNF1+XgSdSo3e1/LTAAJ3nHqW7+JpcXo3PRest6AjxU3uxdpTpty?=
 =?us-ascii?Q?Li+Zqw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u971kghKvjoH0RkyMJzsMYDcBQyB86tUH5G3vh+Lz1hPRWJhEktpwZwTzUoQkc1p4b4j01sRPTXdCU0cj3leY8BeZGTiCdgHuix+gJbkfECGPeVbkIwJ5KZAHlLSkVoU1grW9jt+m1p4K2Ae9XPGU7f8wEIgGVfAjOgWxVB/BUry2kxHI5KPJWzjvIUuEMqzgPFSUx8QJNVFQ/Lb0cIJ09gDlkjDWrHXz2HAdFDT5IbiYDibIII5dr0r0n2461Hi51YtjpdMTKkEAvizi1102OutDbQNo5rcuriqNklSAjx/XrMXS7ifWxs2C3ZOwL1FAOfxBQMU2u7wnBT97PKHwao35AROKLFLqCs3xY08CuoX/4zt3St9M8fw7XM32fniLWtOcxRj+oWLxKQ8+sySq8Kqd8tgr7oj2w0krS7SrnWaB0o1PLQKXPjs0xmp26NMYUw9136t57UdyhJYeLTc7PAi7pkmC3CsA9hHk9DGxyylric4ZP1xhP3ahbaWBpzSnwiVNMo9xWUYe1xxTCsyMOPUoroEp0U9RETrd5mO2w9kP/psjS2zm0y4BjUaZ3M5bg8B/SHY/P6XvVorpO3Hf9VgRUVw90umOeUbWptgPNMyzzAQy0umK4/bFxZ9Kp0aGqI2D0W+XAwXM7fiaI8ZEhoa4o+NBXe1aSw2ef1AGLO2c+Q7yhZgAIWXEOHONcLflRI/R+EHSubBMlG85at2LOyn49K6WB51W5pfrZG9D8/l2BBhjqqaUAjBII1otAy1ePkk45O439kNry3w3d0oA/0VLLXNcalntNpmKJqkkSnHxw4c0QiG4CTzJ5dTMUcs
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aba569-2135-4c9a-92b3-08db47c5d9d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:52:09.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgGiSzpe7KUalOGujKIatW98Z2TfP63Xeznmf9odeKPXP5CFQ65uJAxxhlZyEuyVMkEih9cYaMaeAyDRnf5St+r3m7y2/21c8kgFoL1MK90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_03,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=990 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280071
X-Proofpoint-ORIG-GUID: 5CcMrfmLaodgAXFR45it8_sqevXFBF2v
X-Proofpoint-GUID: 5CcMrfmLaodgAXFR45it8_sqevXFBF2v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
>>> Just a heads up, we just committed support for the assembly syntax
>>> used
>>> by clang to the GNU assembler [1].
>>
>> Thanks! Do you which gcc release is expected to contain these changes?
>
> This is the assembler, i.e. binutils.
> We don't need to update the compiler.

Turns out we do indeed have to update GCC.  Otherwise non-trivial inline
asm ends in mixed syntaxes within an instruction (like r2 = %r3).  We
are looking into this.

Oh well.

>
>>> Salud!
>>> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.html
