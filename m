Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D7697E40
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBOOVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOOVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 09:21:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4486181;
        Wed, 15 Feb 2023 06:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4bSiCO9mt5Y9+7XioKSb5E+CSsHx1u/A0WmPOEfbjvslzE89Wkv8QGipoO1R2RcBCSzgqNENzhBHmELr+FRxtoAw6yDmnV+r5SiahyUEA+VWKlJAt4z5zAmvFy9jx9Bxdp5G2OcKEmhfLraW7MAWaXcOIMHyHAoAko1epKBNVMfFesTBi4Uf2shH5cJ5W6xHlvzX5PDILv1v7VBx8hZ9X7xzvLmImGpVESFUmhHMzWgHlL/+u/m8+0RvbN3w8Uo5nIuwQQeWWdYUDW3tcgyuF1T4NN7x0Z6NMrP0MCZooFaS2xGDJdTtbn/o86e2Jepl0FUtZ10ITtAkkWGuEMKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpghRHhP48F6cyIWS3wNILyM8ZqA5uE+/H1tIRPRi9s=;
 b=MEb9WWa5RFG2luVOzzhkOsFFsxN/SZ2Fj1hqq8t86PajisWrEwYiujAsmCLE8dYG7hcVNGPBFgdzOQYf0tvQbS5Sl+YFbIXqktyIz+GTQdnoPv9N/3/oB+WmIiv7a9bMZDru6cbH9xRvIzQWYm9z1z9Gi8U7Yo3IBQFPkwCwy+bMLDE1h2EF9gaHXFCSkvjre1UXkCXGqThxnqGfLPE939PE2gSZSm8MAYOVx0zj17sxGXP7jRfmXqiNhEvj09CxD4u+J410ZtYxYvscCW95+yX74ukHfC3NXFBw0jbBK0Ki4PGFYzsxzHHc4Ya9BaR/i/lu57luIFUVupdFogt11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpghRHhP48F6cyIWS3wNILyM8ZqA5uE+/H1tIRPRi9s=;
 b=DkM2N/NLnkY9XtKm5oGSq5hK5MEo1kWXXPGM3ZA1JXUll00kefn41HcTU1WHlth9IVa5Bx0h1BIWE9KrFZTVwc0NjknPJaZy83WYuCpkAX0oY/D6K+GNSYT4Poeuu1bj7a3lBpDZOAz/dc4V0hzrd1QlupfCaqidr14OA6O/8Dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 14:20:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 14:20:57 +0000
Date:   Wed, 15 Feb 2023 22:20:26 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] Documentation: amd-pstate: disambiguate user space
 sections
Message-ID: <Y+zqKk1BTvIe5+5r@amd.com>
References: <20230215123253.41552-1-bagasdotme@gmail.com>
 <20230215123253.41552-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215123253.41552-4-bagasdotme@gmail.com>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM4PR12MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5368bbf0-9e65-4a48-14da-08db0f5fdaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYK1eFOj+8z3j5jWMC0Fq8DIStngzsRXEB7vvvzwJnPEgCIi8Up696lXrLtMV7IioTE1oy8ahBMZZQC5XtsrKFgspO9fHsjJiOyKUFAIRdXzInBCKcLBcmKt0LTbJHbYSKLqHMIy5zh27QM867bQH9eFXERjmEkXNw2YoGrmLjcBHuxKE//09hKhjx5R9Y/o9kGYYAt2woK1hq1v/sF+ZBOeqlougesFeKLWY0L4nLVpMi4GMjHcBfye4lsuotYcmsJ2ETSkIqmRJlHfYpf5CIrw7XMiqoH9ezXZdBvKB55A6vIUHkNmHCXFM8c04Dk++r+SXhrN9MCPlaK685SQTEjy1Jj2dhOECzXJCDG/ekQNwUsV5++W2bMUjiJNJyKbSihbgjwGTJHnNRp/Sar+Yb4yvWHH9901cpdHhwpGKTCQNpGjR0SQMm9WlD2bAbbweepre6+Gi72L0RrIuFWL5wsaKRSpZTkZSYWT/49p0biIdNOBs64Td+EJxG9uwUTqTCdq8jRQAyoorOnoM/Y+Gvv5TgxblxRDZ+FTrFF62uBDPWXe/5aagLHvWoZohWugxBzvQLD/L0d59JyAiEclrNBlE4/K1K5FKy7s/fdn/GRgVlpXMJnIp/s+p/9VP/Ml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(5660300002)(2616005)(6916009)(36756003)(6666004)(478600001)(66556008)(966005)(86362001)(66476007)(316002)(4326008)(54906003)(66946007)(6486002)(6512007)(8676002)(26005)(8936002)(186003)(41300700001)(6506007)(2906002)(38100700002)(83380400001)(7416002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiK39BGoWO5EC4pGFMrI8r7x0w5mmWOCYfCdyUZRZc8S/rOIwecMZDXgRRU1?=
 =?us-ascii?Q?0/dtwxCZNW9AUTBm39ZvxDk/ijQvTy8aN1xb0RPkWTsq58dGn0X3Gqq8RxyX?=
 =?us-ascii?Q?wrywAkch9iAbaIUJ99KSNnqhZ+b0WRr+hbnVqrsXxYIA2X2GfiPPwmGn3le+?=
 =?us-ascii?Q?vzTt7fwUPKlGp69rJ75Hwl7UYxmJt8ZRHBdMCvebV5MqoL/Uwu9xqzyhNplU?=
 =?us-ascii?Q?u1N4CKxxk+Caer55auUu8yjDtsLkfFKbBRjejCLYkVDLhR+o7cDdCeSRG59R?=
 =?us-ascii?Q?XsL5q57wxd77UpsZrGXJcy7Vyz7/mKmJkvD0jW982kW1nTgb+V6UYU1zxi4y?=
 =?us-ascii?Q?lFkm3ayc2SwLRQX1Gtfucwh1t7awoFPC0hrgdFp1FQj0czXeBqJwDSEcp9Sw?=
 =?us-ascii?Q?ObvuJHi5E+QX9SKjax9xgdFlnwT1t6d16BzvH+i/9CpeTh8V3X23pb3GBLA+?=
 =?us-ascii?Q?E12olnVfuMhBLeI5+En7uAK61fXcYHi4yUsiMQDVuTHboZQBN2fwLZxGfl7O?=
 =?us-ascii?Q?zsMsGrMltFb/VLQZbmJd03pMuS4HHGAQ8SNDqMQQU3EI6NFmdh5BA5E29J/g?=
 =?us-ascii?Q?KbkL6X8tTt4PDEaevVWUloCLxnFX5wahAEQs2Rr0nxKC75PAWSGodrtCuQHA?=
 =?us-ascii?Q?D4BIikfoBvetPG56ujle3xsFgO35OhapVIQWKs3MUsyaLfxwU32P08y6yiiX?=
 =?us-ascii?Q?PmTdxVHlESjsqwMzlNK93jfvjkxDZlkqCaUGYCgkZl/ihbuUAzeaZRmVE76E?=
 =?us-ascii?Q?6XRL6S5t+r5RavmmcBki6jWVHgaOMaEElA4sSnbER+pkuq0NJQZI3EwoRq0I?=
 =?us-ascii?Q?ZhxeVtTl8uuI1703vBJv7M6hJxbQs2fID25WSnRE+iXOKbp2fGNAtuHnS37+?=
 =?us-ascii?Q?+J2BPnkuDTosDUPhTD/pPda7NzeeImC6iAN8rybcubYOYqQofftU5IotioHq?=
 =?us-ascii?Q?5r2b1/UolTdU31/o0ryz6jhk89bRno3wsnpJnTPuKCknwswHY/6f56GaZkqx?=
 =?us-ascii?Q?XtkD2ured1c0/6PjqPHmxTKtrVhh2P1vSeV6FP5jlBO3FiOlB1j1Bp6G0NpA?=
 =?us-ascii?Q?3ycbzI5fEclqrnjQnsztfasTcetsH9NKy2Oqyd2U2tbsoYncdTWPMuwR8cM4?=
 =?us-ascii?Q?DvMJEr8qyKQprB/Z2UdAqhigzYGqZM4qRyhyTYplHHBWUqaDWFEDUwja80bt?=
 =?us-ascii?Q?+hBAkXzqCKGLQdxP78hSjAqp26qTlgZ2T8sAZlgHEcBYHPUXGk+2DU+ENx2g?=
 =?us-ascii?Q?cpdtuaSuB+juT2DMqgsacjyWQ1xXo1aVZuA92v83LSsuYLjVM3vQ1cXlKm+7?=
 =?us-ascii?Q?Jjn3wgkfZE8pqoaWJvEMXvlTZcBcwLcmQNnlmmq93VDSqPaugSO28hd1MMYr?=
 =?us-ascii?Q?kvragXKxHzRXAd/7HjtRKBU7ubGYA5MGAYi7gYVwN6GyDkKaN3lniFu5hABy?=
 =?us-ascii?Q?xOAvyNm2XeUiZBAryW9s3DNsa96DBsKz93WzB6vTLHyx7YTolxZBVSlycWOj?=
 =?us-ascii?Q?Xy+FhWdcyM4lo2OVc6aCubenTYtDzPdR9nQQUhnm89bLftBiToQaUYD44agH?=
 =?us-ascii?Q?EH3A904vccsRXnNYA5X+rWxXBgtARlmfC2jqXtt9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5368bbf0-9e65-4a48-14da-08db0f5fdaa2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 14:20:57.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi8afux5p3XqMRJduVvRjW6fRPy5/tVVrhZ29thNYI97zNwHPZeq9Wc7Q2QRvkqw5eYePle1GZ0WgIGUol+fPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 08:32:53PM +0800, Bagas Sanjaya wrote:
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
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Huang Rui <ray.huang@amd.com>

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
