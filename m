Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420BA35E727
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhDMTgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 15:36:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbhDMTgp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 15:36:45 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DJUV28026336;
        Tue, 13 Apr 2021 12:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YhIfNM1H+op+nEoOG6OWf7SHTJ81kgaC3riyvk5BEHs=;
 b=QfBYGfhJ63y9KqTKMgd0UyRoBo9j+7Y4gKaH3JnOZqasrkGSAkbINxWk6aR6v+7F2NoB
 YOr50mqdq1RrdRbQ9UkyabbORVnMe87F/dforKNbgwEokZcc9d2Au03pXO2HRTqCuPJ2
 3qwnHVcc7Z3xQZxlKBQA3cog1rloTg/AWDA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37w4k84eu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 12:36:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 12:36:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBLUFhDywUUStlOraVxn3KCq5JZPGemzzoGva8h3EyRgyaR1s8QYWOpAh3x7+Cyp782nkmt9c+fH3gVu7FEOJSX5ljFljqkQGrdC0u02ZI8nBpd5PXhmuEsNDelGYMv7GTPDI9Djvjy2ADackVk11MhSDIyD08IxJ6EP1NZ0dwMJb3arEjbEZR6E+es2blQKzaTAIDMSF2riHZtHoeg6Rl/nOImP8/gEY5c5Y+ZqELOAybq8pAn/AOwR88PfM+p0K1DJt+e4OBFqGSlmT5GB6PyO7mT5qiPKP0QJgb1ssGnohD0dlHJGdqk8GhfIDi2wSCDpSrsI6uOmTJ9GTmrfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhIfNM1H+op+nEoOG6OWf7SHTJ81kgaC3riyvk5BEHs=;
 b=YhB/5KNDDtwNJclhYJ+jKLbRsn9m8UQMqmSugqb1OGWSEn1fSLm0nocIpW57Ghw0ubgisa2ssU+wusH8y3G+Wp93xZzbMphd6EQvEBle/h4fucpKPZ3KSIHjspjTDxegzXCI0jAgfkvGSsto1b4C66Z/DLgZfSuLB9M2KMeGEevWsbIKzwvpho4+LeyDEa+FQOO6B+9ePoAV9f6dkhTAlHkR7aVq56dUk0gqSQKglfRlpEg+4Gq+Q82+KEJ6o8n3VqnXUqea3B6gH+f6CG9xS7G/AGY6MZlZ6AOzHDxl6ERAGtERIt/IoctR0VyDVJ4HujIZm0wRM6dOboYzwvvIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2198.namprd15.prod.outlook.com (2603:10b6:a02:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 19:36:15 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 19:36:15 +0000
Date:   Tue, 13 Apr 2021 12:36:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/5] bpf: tools: support build selftests/bpf
 with clang
Message-ID: <20210413193612.fba4d4ykialmlev6@kafai-mbp.dhcp.thefacebook.com>
References: <20210413153408.3027270-1-yhs@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413153408.3027270-1-yhs@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:7849]
X-ClientProxiedBy: MWHPR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:300:81::12) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:7849) by MWHPR14CA0050.namprd14.prod.outlook.com (2603:10b6:300:81::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 19:36:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dffea489-0871-4009-fb42-08d8feb3670f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB219889B06F087FAE9694DF4AD54F9@BYAPR15MB2198.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLwhOEgxP2GFD7Tb74dT5OdO9MZwgb3zZ1yAB551/WKQtC5a16rCS6HlCBj545goB9nalkxefbF9x8r5hTxO0D37gCqy6JLrZDPAYcZkRFCj8epMaPhRnEzpXkWXczId0mFzP7Zre/8KVMsJSO9hNlYJbldEga0XPOylexasl75hBpIl8UFngWLKyUl4FY1W2I0YNbPVRjKqGDQZP86W4LhEA9ckdesKQwGIIF4Z7R8MIXYETu+aR1UmkE1e89Ecwm6EG8AsHeDFqzABVYYdBaiWPqwUz9Z6NfJ+V8QG4gJERo3mJ06ps00FzifeeJXtJosSr5LxRsP/rrhquYTMSuZZ4yktkn+xJTcpiwSLnqvRmFBZec/yR//jc7P0znrK8ZzzpuDL3I88NtNyq4stGAEacCdHZaZOFVMVdrRCKXRBOUSI+0pS7e0CnJb6R2SYYu0/0T533o9OTnveMyN6zfJI++LOo4hfyCm1VIHlyMbbQr9K1yDRwsnxMLQ2r6mI69el2X68Lzw1imy/rTfete7md72WScj9vDB8THkAHdcG0tgXwmrH2rxINgxUNrmnTT2JWg9hdk3PA2Fdi4d2P81Ls44EQVUptEI0XdmDpRvMzpHSZObPhZl/0md+utM2WQuZoaSwdk085oDQ/mRpUWD8fRpoMi49YFfq0SRkhuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39860400002)(83380400001)(6506007)(478600001)(7696005)(6862004)(8936002)(86362001)(8676002)(2906002)(4326008)(316002)(55016002)(5660300002)(966005)(66946007)(16526019)(38100700002)(52116002)(54906003)(9686003)(66476007)(6636002)(66556008)(186003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cXfJsbVx85BcvDV7sJtyBsK2KRRDpm43ZLzq/+gu7SrK4FeRNXnMGLmOZcYl?=
 =?us-ascii?Q?0FAu2VZSEIKHOws5OHpKnYpmVAU178ojlOHPIh8qCs6ttH2J33YGPnbyk6iW?=
 =?us-ascii?Q?zqaBGpTFqKJcXG9BYNaBmPI7Ja0cVkoL96rzOSJSa3WO+HBXib+XWtNjHI7V?=
 =?us-ascii?Q?J9ITDNGlAEQbIqnKyjeCrqyJPFGZEHObXH64O5OER64TZy7eJmGEh+cj+p2v?=
 =?us-ascii?Q?O4PLNRWnNj4l65Nh9XnICIttHdpNltmr2XVdSjm4ojzVqsQ2cavvz8i/J4Zf?=
 =?us-ascii?Q?WgbuM07eQ9OiALgl9QfHw/k4zKDJcErlJg55SoXV/0UsE1u0+oqo6SDqqPIC?=
 =?us-ascii?Q?mgvRwr+ArFSY8JCgpzv83FrdrbySqswTwkPCux7vUuTEaDEoz5hZHqquX73T?=
 =?us-ascii?Q?8RHeQSr691P3JuUvWtPmGVIWdknKMcX56QuyY3DgwE0B7woIeR+ChmBvJHf9?=
 =?us-ascii?Q?mrVpwk9+NVK65qWvwGR8UiuORcwMIwbzK/pxi6PKtBMKCxcET4U0W2oMd2N5?=
 =?us-ascii?Q?emVjt0hMo25joiKWga5d0eFutcb5Gr10RgG/ySP1cm/ilNZ0tTVIYqI2WK4H?=
 =?us-ascii?Q?eQ73YAj9pW+0VIqztsWAs/nDrYsM4M2eHt0OAQG4uQhs09R0GnDYiDwebQq+?=
 =?us-ascii?Q?Xz8/w3lalcn8UeLjprQhrkaTZPhS6r6A6uZfFIRbQRhLztTJ8JnSWvuONzAA?=
 =?us-ascii?Q?tuhFKhBzgaxXQTIRuF27i8BjSI+gHfYREYKSKXpREvr5AOTmK5nRIu0sGwxR?=
 =?us-ascii?Q?fFUFdld03FSvYK9fDX3LLnh+3djxbVtLrpFskd+dBvBiIcJrIvd+7JX7oCvO?=
 =?us-ascii?Q?a7PzoW5gS3lIAIO6bVYk78etO7iO7FYg1kN/X1O47LoM+qNaitUstSUg2jnw?=
 =?us-ascii?Q?Rr6JPq68knk5H3aUvTsm2HfV93p1yzy91T/qYncJXhJuQkFKtSX2dH/4zeJ8?=
 =?us-ascii?Q?HbWNHBoJh8ZIwzqjQEydeancj0SONkL+jPqICwnZIHhyY3VJqlApGtZTIbRn?=
 =?us-ascii?Q?10Cq7gV7FH7WhC6jlpX0FQR6dFelQidBezNVkGoRCaCTNEJPm1cuNBHlQqM6?=
 =?us-ascii?Q?yPWOroH2Knwnp47cn9dzwhWvNZ9cRlJ/6/EmPSMM8CVtfiw76MIS+KQHB1X3?=
 =?us-ascii?Q?dkQKgBcIl0NSyCLxSCubvHaY3+mVASkNegQzS3q0AV/HTRxU4vRwXgsmDSoZ?=
 =?us-ascii?Q?owPAUuOVJNDFh1wK91ByG8ZHlE1vweUQQ/rx1+Y0GA/Bph5yVRsARzi0AiuG?=
 =?us-ascii?Q?1K2UEboQwF5dDPFovdz7y3syxAkurKGw20wC1GJq5f5fwVcb7hN6xcq03XJ7?=
 =?us-ascii?Q?7rilD9S3TRMgJVxSUmOswIk+zgWCdi7r+WjrkdjdHRdVoA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dffea489-0871-4009-fb42-08d8feb3670f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 19:36:15.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZiT894xFIgFic8vNyZFxMG4+Dildu3Lhy3OJLWq7DnDbJRWdWPyzDkOHsCOFg05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2198
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: b1LkrFljHHf0yzDu7g6WVmJHy89ROpxU
X-Proofpoint-GUID: b1LkrFljHHf0yzDu7g6WVmJHy89ROpxU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_15:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 08:34:08AM -0700, Yonghong Song wrote:
> To build kernel with clang, people typically use
>   make -j60 LLVM=1 LLVM_IAS=1
> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
> 
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> 
> I am using latest bpf-next kernel code base and
> latest clang built from source from
>   https://github.com/llvm/llvm-project.git
> Using earlier version of llvm may have compilation errors, see
>   tools/testing/selftests/bpf
> due to continuous development in llvm bpf features and selftests
> to use these features.
> 
> To run bpf selftest properly, you need have certain necessary
> kernel configs like at:
>   bpf-next:tools/testing/selftests/bpf/config
> (not that this is not a complete .config file and some other configs
>  might still be needed.)
> 
> Currently, using the above command, some compilations
> still use gcc and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
Acked-by: Martin KaFai Lau <kafai@fb.com>
