Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E9866DEA6
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjAQNUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 08:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjAQNUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 08:20:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1A39B96;
        Tue, 17 Jan 2023 05:20:08 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HCObHb010980;
        Tue, 17 Jan 2023 13:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Ow4CcR6a7muy0B7EFRvtVJG1Hspi7nggjE0LwOk7+dI=;
 b=Rj4vL1fY0+UVsRb0dQDGCrKxKEUYu1FF8qbA1uvENeviXHC/lcJ6ZrUZ3Z4qR4+6Mcb4
 oaE4nOOFIjcEjQQVM3+ZmxCSddrZUH1/P9XS3f8tZz4YenWW8MHNuLE4/9GHN066cGor
 MA4s5w7xfkvfAXy+QZCAmevN5Wnylgzinq6XliDnsEKBNnz5KjR2zSJ1NYcEE7gSTQoS
 6q1NhVyjHzG6qjQnYnGXV+bEjxOYX0z70G0J2CpBpHehzZBirIzb7IhHAZGD5viGyDOq
 skX5I8HCn1iN3Ti7JM1mstydk0fmILzV6mOQEGKo8BJjnJnlC36tpnsmvuFFuLaMGxES aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaacpxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 13:19:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HBx0Kf031112;
        Tue, 17 Jan 2023 13:19:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rx4sb0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 13:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1wD5uYbfXudePNjSaCjKBPre01WqOyXn0+BjMwz2l52/askTw7/ixX3R/UJGZcXkQS4gdCeTUbKVDdJP0bTVG/apL8BcBkLKriif0wWspa6xOrLK44j1qN/kljPaNE5hLox/V55yqYLMua1Cr2YndDBejIF6wZ0NyvhK7mwuVG/wnx98YOIqaMu4NldrsbulmZlufRFWWzBxjvU67CVC2zz5sXgBLnLUMY8T6StUAOAcS3VAsys/bpa1hvjJ49XKbvkOr7WHcyVL7YwlL2M0Nn2Dbxk51ggq2V5XMW+a5A9ZVUItiO2WKmDzNiqxJVvGJd9ejx7eK8IzJxJIKei+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow4CcR6a7muy0B7EFRvtVJG1Hspi7nggjE0LwOk7+dI=;
 b=EC4s3w9gmq0TYUMSSLj0bWw+XVodLwUowM8fzKav7HsO+Z3GFxIlFu9ZBqZYPlwfUb+dZ0U9HC95z2yyS1nDy1jMiQHhb48lYmZKjK8/EEe4zs6ofM5SXN+E/VBtNzCZeDycxlW5dvrfTLvfvmx6WpRGvpg41NHyFXdt1fqWJEZefWLGbTa/j0QrTh/yr4pWMguc0+CWEZB52FJcuuh+HFlnigrPT2A71N4v11eigKnNXyyZR0oWBocumKsG/xGptgk4AU0iTA2aTd+cQLBN8xcdRxLJr3Xs1OWnTw7Bg+Aa0Q0Q8cVmkYXrsX+R6wszTjfyRnhIRjAKaLPqdiTHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow4CcR6a7muy0B7EFRvtVJG1Hspi7nggjE0LwOk7+dI=;
 b=h4k6IMPe2GhPt8Jt/Ml36fjpgPFs1XXpaTYfVmkBQqtJIUCoC5jMiBr9quYmDc2vUdBtaCEnJ5vwjoXIPFOkHjxyHfxg7hcf33LlwkQnjndem2ic04hUBLlOVr2uycPwGrpT8LR6NVO7fzpA5IkMiuk0Tslo6O5JXpOsPbvXc4Q=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA1PR10MB7116.namprd10.prod.outlook.com (2603:10b6:208:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 17 Jan
 2023 13:19:35 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%3]) with mapi id 15.20.6002.009; Tue, 17 Jan 2023
 13:19:35 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        david.faust@oracle.com, elena.zannoni@oracle.com
Subject: Re: [PATCH] tools: bpf: Disable stack protector
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
        <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
        <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
        <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
        <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com>
Date:   Tue, 17 Jan 2023 14:23:51 +0100
In-Reply-To: <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com> (Yonghong Song's
        message of "Mon, 16 Jan 2023 23:05:15 -0800")
Message-ID: <87bkmx9tw8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA1PR10MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c49f29-bc73-457c-3b7e-08daf88d7a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NtRf822K0/2lHkxBzd0UjOTd6xJcaq2cUaBOxpwwAetcrLxGjH52PECqW5XDm1wD0eIYAVxM8ct0c71apHvHRoxrSgkadvij1xS27ro1VIK96VSxo0y6+DftBeoPuF8YYolfve9aRttk2PlBRh7xq/Zxyrnx/zUssr2XypuUqj21AV0fF9ABAghcJ2AL7FGfW06o7M9/VcHCr7nXfuNXgUXrIxV+lmf/+i9MW0Is6Nuphc+o7wn/svnX1vGuE5eTCskz2NShKyAqBm/zf9InC3KuvlQMlolvv+RDyZ/0oHv8zLAPwKlFa6iPhwI+QBPTq0d/uXcqctqsmjpSJ2iRf9cE0Eab0Lq4g6gJ063d/uwO+k8+9jGnZ9LpNGp37zqpiXGOWldxzaaODlY4Tc9RmISKhpEGCfyg9utJR6z8Ths8RJzI5OW9G/fer0ykdPni2bFNuagL6/NxC764a7Fs/AOEyFbBJ51l16D+DsKjvw20Y43jLxL1nhZCTvEzX49xbp/Y4+IApksgAKThZudgaBOEOyoI9QN4AN0o+UEA0tM5au629cdVuqljFQJZAu8PxGAm9WSVCinwhf79SJRaI5OEqEWAtkYegCYcsZL6VzW1S1s554zb6uAvehkHdFsTSkMhA9n/GdftuOt0Ghm0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(2906002)(8936002)(6512007)(7416002)(5660300002)(41300700001)(36756003)(186003)(66556008)(4326008)(53546011)(6916009)(8676002)(66476007)(38100700002)(2616005)(86362001)(26005)(83380400001)(66946007)(478600001)(107886003)(54906003)(6486002)(6506007)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZ6ygcgLg9TpksJb9S/2AXWRlQMm94vntEiANtsBPQJ98tuVpaWtXmjxCZPb?=
 =?us-ascii?Q?sMII49Giol1zjD1c9e5CLFQLRyb80zXAlBwFVTqVbUkpVlroRc5uFzfOtOLH?=
 =?us-ascii?Q?FFkYaXzr4ZsB878MRP4CBqfFlILx0ShJbGyhEp5DNj94DlBlVQDaKUiBwpdz?=
 =?us-ascii?Q?APn1PL3jU5C1bCjMEbUtgx56nanMcTwWgqiyyqFBMKG+U5Fr3nQ3CN4EEZ7i?=
 =?us-ascii?Q?SNsizOgYAcNz1UDnXA6JEXSLDi/UqhEBjej6yXbTnvdH/Ga4Y72CIapqdLEK?=
 =?us-ascii?Q?kMWZ7sPnwuVQAwU/E1SuJ9IrNr4iSnPFZTFAP0ztTZtdt4McZQac0ZL7l/Qv?=
 =?us-ascii?Q?FhDO9twvA5K9QFxfeqJGB/NS3ZJgOESZRwPrSfjxNqHo4hmrzqdQDt20kaM9?=
 =?us-ascii?Q?ZKNF/7LNPeikC5clRxzT/7jyZraTqHdCSE7pKnqoFc58QHuG61olkFPTAyif?=
 =?us-ascii?Q?sSHvPBisCyzwOGJVHjYbLCskejvxa8iXafdQTKoT+YKbHWW4OGLc07LbRS7J?=
 =?us-ascii?Q?8RdQnz+Nex1XOtyO2Mfp/aq2JLwLxOLjrY6mFO+3p9eORbatrW0LCIyT4jJb?=
 =?us-ascii?Q?L7VpZ6B42JUV/cxWL4eBNXlajq7wZdcyo23kuOAQHN2kp2luzACrOWdX0YrQ?=
 =?us-ascii?Q?omDbmc4wpbCAXBRRSNcNiJ7SDy3uvsDLcc00STFwzWkaIDPT7GNnkalgnTlA?=
 =?us-ascii?Q?W8GEPv+eAS8Ri/kktpNZ3mUYwiUEmBfQYxgqbCppCd2H8Ajn4p8ii5XaD1bk?=
 =?us-ascii?Q?cf0PJDkUs3bkFaiGhGiUTI7CrMeUG7mjrSAGBaNlDrbyARpT1KOhS1/A8uoD?=
 =?us-ascii?Q?KWkafpym0cdSW7PV2ZEDgcIVTQf2khIg4w8Wt5Npi5n5a8rQmCtzegs1QV1x?=
 =?us-ascii?Q?sbh2TGd2s6SGSQe1cJmp0Yu4Dt0G+HR54D5XVSBOjzJKPs88X2Idp9MCiNuu?=
 =?us-ascii?Q?+8KldMyVaNlqwPPBxvcnulcFWttIugd6y0ki3piKXXywOD/DpVQTE5rsiPT0?=
 =?us-ascii?Q?H7EmI5yjV9BKG0HK3Xma0NiKBZqdia0Es+HMGxjsNhrr0aKjEJ37ijvGlMx8?=
 =?us-ascii?Q?8He0lJsyLJsOtQqt67Xk3Uj9OBp9P5ViNb5jDxJ5fgsUs80aVOui5ZanMQba?=
 =?us-ascii?Q?fM/YqmMhV9sRWRCccu6m5FT53w2bgO0SBksUToK1/tc7gGCcVtP0Z+8U1QY6?=
 =?us-ascii?Q?NfKyfZ9UkxM94Mrb/N4/cBvJcrtaz5hzqDdz3i8hSt1p+wvrEeWLeF7rbCBk?=
 =?us-ascii?Q?QUavB5MVOoktYH328rFwVvxZYKm4ZOuOkpiyxyLVkPVXIlsPs+P80FgXJ0k8?=
 =?us-ascii?Q?7o2ab4n/FoTKgHfxS8VjjkcdCuNg4fjWeGIHx7sU2upg+2w7szaSHrTAesr7?=
 =?us-ascii?Q?rEIxryLjamBop/cWwGy7h5WJ08whhY2Ki8A3SD6h6c+ZgnVaxWUIfB1LtxXx?=
 =?us-ascii?Q?y51bVLzd+mcMURC6ExV9ksKPlHHaCmuO/auSe1rJWr4BemDPMamI2Vr18wBk?=
 =?us-ascii?Q?4W7KNgzPSGb1mZ0GHZJ3rf69rMBJ5zUiNjxnLixPHhe/jmDRmqQYpcEV2AOJ?=
 =?us-ascii?Q?F01U7kR+TFfQEAL0x78msWfvhPWN9cWvQDO2g29hIWqF/8u9g+7xZbkENVHY?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q/N5ThNYa/07mhj/x3IhQKeH9DOd+ZjMRu1UBVzKOZwu2kZbATlTU4JynwR6?=
 =?us-ascii?Q?i6ACbgUG0v6XQ0h5qMcBC+xa7FLfwuE3zUMyzhQQGeuyBFnSeOV4eCJxOOI8?=
 =?us-ascii?Q?lUvspWHoiPu0ErNilgTqSIq1LTCg/JMK8gjlIJp3JwR5kHuiFTJOo3shjpTk?=
 =?us-ascii?Q?kcqv1fzSt9xoDr9/hF+AZRGwyr66TJMkJkXKqm1+C84i4NdqkB650czUO5me?=
 =?us-ascii?Q?ghpMGcnSXXn79RfQH2GTixTBRIJOd1Sr8akf2+sEGU727J86gxlsPYymzoF0?=
 =?us-ascii?Q?swWARaruOMP3vcpHlwesHEgGCc58if4d265hlcPZuyBdKdtyeKCG5/mBlgBR?=
 =?us-ascii?Q?Q73tGN+8I5+WeCobvatOS7zF3ZOSSYUv6EIwwRQIKqrxGC+W6H/ajdGWw6rt?=
 =?us-ascii?Q?nMO8sVTDjbQ9M2/bDu/gT0iHpeTo/522j8KLzsBaM6J7saYJFRpPxIbm6w86?=
 =?us-ascii?Q?eJJeBKWYw9J/SrCmW+5CCFssbPl1VAbT6g+aFxMXtYDnNEOCy9F0XjfFBrNU?=
 =?us-ascii?Q?/AyE0gBuzAdyxw5zOT3CBA2GHMfrj4u8CPHJx8In1AkPIicPkZXGjZEM7Z0A?=
 =?us-ascii?Q?qm4tMi2Z4oyJ0G3ydDThzWn7lw06y82Fh6O6XAYeg1TCCUmxBjKwNI574oQl?=
 =?us-ascii?Q?nKny8FcT4nTNr7pcvDXi1RJRLOjklA9xf1OgzxrfN6G1VFYBoZICrzwmDC7Z?=
 =?us-ascii?Q?7bx7hLvbnvBucs2l7edG++IQl/5SBCjYdcDHCiN39MWn+x6PC5LZ1YAqLRR9?=
 =?us-ascii?Q?MqFWXJwlUr9WgqsJgMxtNOPdA2ZlmlZuBLiC9/DARJnyv9au+goR8RxxEPIM?=
 =?us-ascii?Q?UXHDxKsBoWTM0QnL1cFUUxcQ/b4Qj+htUxXTlCCJkl/xMuwuHbaDGf0DmrUF?=
 =?us-ascii?Q?QQ0mFoalV0lJbYyfmzNmIkPRu6FvhjyLags3lCP8XIYWfUo8bLUbzDoZVJVi?=
 =?us-ascii?Q?SkTBrgMMbcX2xZCelg/o7FsTsz/fImKkDW2EdKfk2X/pX0FAqabqEq1uPsab?=
 =?us-ascii?Q?TICMati75YNDIjnwRMm63TbxrdOHc5VEPt8UlIAQT5chPgK5HWldON1rY61S?=
 =?us-ascii?Q?vfBxxkl7YMYj/NnqVeJPlQ+NdDt8mA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c49f29-bc73-457c-3b7e-08daf88d7a2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:19:35.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcvgoWCSTcJ7pvtEGGYleFWaCGh1USpk0pqOhOwYPDUFubm16qMDyUA6zn8Lr7CBxhShH7DZkSuILlTlDGOVbNQ1lDY2N/rkcZpdELfV41Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=596 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170110
X-Proofpoint-GUID: JiXFHAWt8_Kytj_Qqk5Pmkmnp7iUdIvl
X-Proofpoint-ORIG-GUID: JiXFHAWt8_Kytj_Qqk5Pmkmnp7iUdIvl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 1/16/23 2:49 PM, Peter Foley wrote:
>> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>
>>> A bit tangential, but since BPF LLVM backend does not support the
>>> stack protector (should it?) there is also an option to adjust LLVM
>>> to avoid this instrumentation, WDYT?
>>>
>> That would probably be worth doing, yes.
>> But given that won't help already released versions of clang, it
>> should probably happen in addition to this patch.
>
> Peter,
>
> If I understand correctly (by inspecting clang code), the stack
> protector is off by default. Do you have link to Gentoo build
> page to show how they enable stack protector? cmake config or
> a private patch?
>
> Jose,
>
> How gcc-bpf handle stack protector? The compiler just disables
> stack protector for bpf target?

It doesn't.  -fstack-protector is disabled by default in GCC.  When you
use it you get something like:

  $ echo 'int foo() { char s[256]; return s[3]; }' | bpf-unknown-none-gcc \
    -fstack-protector -S -o foo.s -O2 -xc -
  $ cat foo.s
  	.file	"<stdin>"
  	.text
  	.align	3
  	.global	foo
  	.type	foo, @function
  foo:
  	lddw	%r1,__stack_chk_guard
  	ldxdw	%r0,[%r1+0]
  	stxdw	[%fp+-8],%r0
  	ldxb	%r0,[%fp+-261]
  	lsh	%r0,56
  	arsh	%r0,56
  	ldxdw	%r2,[%fp+-8]
  	ldxdw	%r3,[%r1+0]
 	jne	%r2,%r3,.L4
  	exit
  .L4:
  	call	__stack_chk_fail
  	.size	foo, .-foo
  	.ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"

i.e. it pushes a stack canary and checks it upon function exit, calling
__stack_chk_fail.

If clang has -fstack-protector ON by default and you change the BPF
backend in order to ignore the flag, I think we should do the same in
GCC.
