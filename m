Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340EF697DE7
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBONxT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 08:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBONxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 08:53:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EA9ECE;
        Wed, 15 Feb 2023 05:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLNHF/TvxwF+A4NtGZa+uQzVvm+b8Us+Wobi8UwA6knvrKZcLURfzFxybNqi+mkIb4Gfh5cd/APj8I1yQm1E/HpbFbvH0oRJz6QzjX3CYj80DIw8aRQwY23cBj2eDpEPOzC+HilqOCnHiCj+aQyWRWVnqbMwHJ4pb3dGcDqv9su0ppVV3yr3usXJUE4Neo8vxxggy9yCRzySVTlcWPo9NnZ0Y6vfVTjRvgDD4NUIbNEMLKQFrUxI17dOs/E0/q6Wu28AeZu66tFJStWsAlGrEHULDsOGBfagYGwSchwJz4VyBCVWfLBv2yRdLjsSM4qwKr/tiVkvJukY5Wi8WHgP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eygaEIfp/BCk0yBFZvXYTLPy4s+cXoCjjYs/5Fs/f34=;
 b=AZPuILiHT79S0aHZuzBcTkxqyz0xSBHB6LrFEmW931xJRwBM3vvmT0wv06L1C3yIJ+5T+mCcaywsQqmYkvHDx8YWyMUiWQ2/rTERSiem9f27XZay6JYe76dPycfVxUBFDzvDE2UB6/VlxnTy7qHySHsQ+0pF1ixw6SHqvKlvmLN1RJ3jIcZ8xxBiggkffpqU/fL1+gney4Itg+OVYMMzw5X3EKBL5brzKH1+tstrkfYS+cngN/3mpbwGICRNO08K/IRHKBOXCROghPzC/jhA+HUmhWXEwGPxQsk95J2yVmIudkj9Q5LYU4xWFWcf9H8dq4lJCkbI9wSVo6kqIZMOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eygaEIfp/BCk0yBFZvXYTLPy4s+cXoCjjYs/5Fs/f34=;
 b=kISuFyobFzrmYVJXN2N55zR4EOZQzWCcabcDrASHQjUfV0docyaaFL525/iXAhyOpGbvBcAn6yPnx0zMca14U+I8iWjE90dVZ9YDekErlMNOHoE7QngEsl78wdjnfQLleUU8Twr8XP+dk6LImrtclM50hafiRo+q0HSaQDjQeaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 13:53:03 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 13:53:03 +0000
Date:   Wed, 15 Feb 2023 13:52:46 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Huang Rui <ray.huang@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] Documentation: amd-pstate: disambiguate user space
 sections
Message-ID: <Y+zjrjladvHd9QRS@beas>
References: <20230215123253.41552-1-bagasdotme@gmail.com>
 <20230215123253.41552-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215123253.41552-4-bagasdotme@gmail.com>
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dd1e6f-7bfb-4789-6b0b-08db0f5bf4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umEm15/rLDiEJ/Ws0CWokhnW658POPFR0GGAFz71RBR7n8jDJ+65lp7LzNrS8G511TWIko/A9KfFdi0slJ2KL5134uYy6WHb6PYYQwOprprt7j9RGFru1moDtXmWQNo6/9cDxhs94c2KhBeyA2tC/UVLLJz60XnUrV2hrbaWz+5koiIk6jwhC8bbi2Ntoh2ng5PeCO8jXtm0wq/FP+/V9v+ZJ+mWIsVDoV+8xwczYk1sbSJy/RPyo4exBFJ2jpu8ovdLi9hQVcxm4QuSQc7E9qWbz3U691WYJEaVA/A8nBEr9ZGA9M57AiI3GWE4wOiBHLq6AVwSNjAHuV7V0FqJeVWaGfbBhRIl4dsgDoxjA6hz3XnVsr0BmwCZwN+BeEcdUKwK+EYKFHiwP1bt6x4jeJVXWYxQIvXJFb/xbQCkjeUskGDjh4MTlpEj/tvWdjw2w8fFBjr+i5B1A3mVOiVfbqL88zTv1GTviLLeS8nqvIPjmfCwdjsSWHxxYVgIgHIDe1HBlV6SFpK64xysefsXzkbw5fP/8jpkyzaKhA20/AGGpqVi+IAl0Q7qFSnl6zOlxvAdiMSGAu2yNyD5ofeuolX52jjQszeC+ndR1Pa7TQj9V0irucy6wz+mJzAh1glZpOfjwXC0754pTrCB9RSq8t69yFgn3yZf6J8l4w+GeGF2kKvK6b9YJUWHX6i6X5SE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(38100700002)(86362001)(33716001)(8676002)(6916009)(4326008)(66556008)(66476007)(66946007)(41300700001)(54906003)(316002)(7416002)(8936002)(2906002)(44832011)(5660300002)(83380400001)(6486002)(966005)(478600001)(26005)(9686003)(6512007)(186003)(6506007)(6666004)(66899018)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJeV0yOgeIQdfJCBW59NytuMocUau06Fp14zpcAqzI7IUN5x4tMLBV+DiURb?=
 =?us-ascii?Q?QTUssPdJEooWptSmZ0tV2pxMEQ+JeZ96Pfdi+0WaVJKxjOyF2kGNc1u56uGX?=
 =?us-ascii?Q?9rBEZlK7YPe2qsM1DRC01HBRx4owO4cRoV30+vAHzhD2b4uSUpZ+MbGQ1TUA?=
 =?us-ascii?Q?07534YKfbxCn/zCmdVwnBl6Zj8+dAKyRE/64tOHMsPYFf4UMwJX5yZ7xhjrm?=
 =?us-ascii?Q?IGIMUfwikZzKHXJSQWc1wV0DJKvEfI3zdqWicnoPRUufNmiVQOinz/PCvRlS?=
 =?us-ascii?Q?nxjcMaz3HTKfpqJrMTaYGqmnlk0kJp+va14TsSSdJdN5+M1DuMF4iyGs464G?=
 =?us-ascii?Q?XgTB/YujWSbiF2S4wegU1Q8JQc5+Y/bYW+DgUwv6iBXHkDGlR5YUxuE2vSu1?=
 =?us-ascii?Q?gfQls3SfuEkR8Qa2JE1OoAb+ox02TT5J7q8GQhIFJlcPVfAbYqZFZOU3AgOg?=
 =?us-ascii?Q?t8ACj0cCZSScd39KDLvffEqmYRzvjk8YqjuvZT2zWHpII64tRGXrwPsUmg68?=
 =?us-ascii?Q?Bxp2pZV4xhJoeXU7nlNvmLic+hxu5fSR+NRnO5oV/swLuzVuTREx7+J2Yy77?=
 =?us-ascii?Q?ZMKVSz8+bRrbPwEGT/g/jCXYFz545pBrj/3ifv4soQfaqodLpFhB4Jg/Iyto?=
 =?us-ascii?Q?c1aNAF1p7Qt1pRfItkqGJaXXAVBup7htyQqgA2N8Ox9V1OumMIS5jwyFztcL?=
 =?us-ascii?Q?BRVp8nWPekYaTuWdTn/3zJhwuJnzW4QDJREzzt5muTRFvqriNnopqs/pekGu?=
 =?us-ascii?Q?IGTbrBrsQE2DYWRUNJLkODjd7MplInHhyL+CWSMWk3GDURWxkC/zI49qM9Xn?=
 =?us-ascii?Q?vX0pkuDxh5FpiyZ5SufUk2dSwy/J9AD7ztAtfDZ4Et1ajqnm2nheA4DaUJkc?=
 =?us-ascii?Q?41sUydHmtc8+bdrvtf9fE6VrCOWRgJz5HJoBseaxyGwLIAVMrFSqqFdyOxCM?=
 =?us-ascii?Q?wVtd5O+1tS32fqr1vR+Zr/kJcVCYeCHu468NJsnTx94VRIyfGR3hC9UqPX8r?=
 =?us-ascii?Q?t/YbG1oi6ul8H8is1R0YylpMn1cKLxM7CLw7juQzoG0EXeQA0t5kzuO0UrOb?=
 =?us-ascii?Q?xPb4Ui/AbVp3bK9cb75vmFqlyQk8j2+R6O4FV1AJTcZH5swbP4rM70Tpzbat?=
 =?us-ascii?Q?zttXNcZqJpK17s+tAo5aQItWA106NdLsx06sRTxWpFW5dhwmrUM6Tc/hmH54?=
 =?us-ascii?Q?mv1Wdq2fLJIj9Z3wqyenmO0q8vkALeWdwAgUEjlZL3fQWr4jQQrjlfYGt3P3?=
 =?us-ascii?Q?OVb6cESmlfnQBkToQcdJ7mrcL4dcPc/csVOjVxGHLI3EcU8mLp0C5Wn1241F?=
 =?us-ascii?Q?+VSwdB03pnaY/iO/sC2XSXOsZ4MQ5UBMt6l+wljDijK9dXQuNIshMQVvS6ku?=
 =?us-ascii?Q?x+dpEDMvKW5G4Ma/refMa8eDtdY94uen+cnj/FzyhzUm+wpZ2hp1A025iMgU?=
 =?us-ascii?Q?m5FViM4LTGTSq9k5oC0EpfTXb1ADEyTGRoLibZMlL/GuuLSaes+XRNEe0UJU?=
 =?us-ascii?Q?uptO1YFdP7ans50S0/aqSfXcHHR02itLcnFaq2Q6veyXYchaT0U8lVoZ05Ov?=
 =?us-ascii?Q?CvcQUaqfSS27+jFGe7SNh1Mt6WSK+CHWv6OLBMZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dd1e6f-7bfb-4789-6b0b-08db0f5bf4e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:53:03.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ8hedGS5OqsQSPAz5dJh5uqPWOx+KeumV1qqZ1Zeb7YWDLICcpDt9sf5Hi8LCdlwfFqwekHvTyrqxg2KOMsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15 Feb 19:32, Bagas Sanjaya wrote:
> kernel test robot reported htmldocs warning:
> 
> Documentation/admin-guide/pm/amd-pstate.rst:343: WARNING: duplicate label admin-guide/pm/amd-pstate:user space interface in ``sysfs``, other instance in Documentation/admin-guide/pm/amd-pstate.rst
> 
> The documentation contains two sections with the same "User Space Interface
> in ``sysfs``" title. The first one deals with per-policy sysfs and the
> second one is about general attributes (currently only global attributes
> are documented).
> 
> Disambiguate title text of both sections to fix the warning.
> 
> Link: https://lore.kernel.org/linux-doc/202302151041.0SWs1RHK-lkp@intel.com/
> Fixes: b9e6a2d47b2565 ("Documentation: amd-pstate: introduce new global sysfs attributes")
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index bca9a0ebee3ed8..6e5298b521b18b 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -230,8 +230,8 @@ with :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond
>  to the request from AMD P-States.
>  
>  
> -User Space Interface in ``sysfs``
> -==================================
> +User Space Interface in ``sysfs`` - Per-policy control
> +======================================================
>  
>  ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
>  control its functionality at the system level. They are located in the
> @@ -339,8 +339,8 @@ processor must provide at least nominal performance requested and go higher if c
>  operating conditions allow.
>  
>  
> -User Space Interface in ``sysfs``
> -=================================
> +User Space Interface in ``sysfs`` - General
> +===========================================
>  
>  Global Attributes
>  -----------------
> -- 
> An old man doll... just what I always wanted! - Clara
> 

Thanks,
Wyes
