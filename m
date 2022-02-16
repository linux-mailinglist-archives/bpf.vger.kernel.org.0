Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33BB4B85FA
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiBPKiC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 05:38:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBPKiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 05:38:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2134.outbound.protection.outlook.com [40.107.237.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E115F630
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 02:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odptsThnAechmGcl+E45QrcYrvUbZgLNe5lFLOS0fFC/7ttV5NdJxz4y2GPRcRgU9/aQk8sIjR5yOpVvqHFngofOIsePkCiO9098QS1fKLku8elCl4e8qbU15uGcCNaoXfj1gmDu1EnlPgE8MShdr/cfmv+/SNz2aFWNRHZQFOrJNothiLdzIo6xMDQUak/KdAXZKgWeDkqj7QNi8cNls6HBlpVxyxOxJivXAwK9EBZ/fvj6KRHegT3mvu3oih/uvfKViWxOI0nXwvhWymdM76yu0k5/GKAugs/lp4UA/7OD7gX0r/e0HkkBmtNRnVA6LrbK5mKPjwwXMMDPCzj4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0wQ1gOu+qfw0UOEmn2YMzOl2IqqumHuTufgDIpescs=;
 b=LLM2G5z/Wj9kJ79HLPCtnPvWdZV4Pxh61vFan8Ac4nANQp6KQJkCwjNUDI2kOxR85uRO5wf1OlBhucvDA12NiZnRp11gY8VCXK2xBmqOfSSK9TG/UjGuLqPcrbTjwnzAzYiBaSBQrXHV+DYAkT1F73Lk7AvTRiqzduz6cf7za8regTaQf/7o4wn3/aPIQcpWjX0XvYEVU3/JPDneOvoy7/Ca6cB9lNK700ZlXbEXei/sFCjl/fvcqPfei7YIo8sZ7v2hOKmyvTERn5s2KqcH1bysxHT4NCdS9/8NP6Cs88Kp3OK+C2vxN1jSmWHgyvleDXAYQvtdSEUeh+sdP7K7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0wQ1gOu+qfw0UOEmn2YMzOl2IqqumHuTufgDIpescs=;
 b=trXQ6/ru/iHGwx6EX9yvLkeS9HDzjAJlcA8raZJJpwrRJX46P3DO8H7tNE2bVIA4eZUOlWYRY6Dm2iwQ2YbjcDEPHMfPpr1xYsbfL1Afvckbh/rinxTc+ZXw6KCfsleG+m7BYBftnsRJREz+qJqEFt0mvl9EJzWcIsSWSfTN1eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by SJ0PR13MB5692.namprd13.prod.outlook.com (2603:10b6:a03:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.13; Wed, 16 Feb
 2022 10:37:45 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%4]) with mapi id 15.20.5017.007; Wed, 16 Feb 2022
 10:37:45 +0000
Date:   Wed, 16 Feb 2022 11:37:39 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Simon Horman <simon.horman@corigine.com>,
        David Beckett <david.beckett@netronome.com>
Subject: Re: [PATCH bpf-next 2/6] bpftool: stop supporting BPF
 offload-enabled feature probing
Message-ID: <YgzT81NRqceBfEa4@bismarck.dyn.berto.se>
References: <20220202225916.3313522-1-andrii@kernel.org>
 <20220202225916.3313522-3-andrii@kernel.org>
 <86567f94-ec2a-5441-2657-4e8f3f21059d@isovalent.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86567f94-ec2a-5441-2657-4e8f3f21059d@isovalent.com>
X-ClientProxiedBy: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2524aef7-e98e-4157-484a-08d9f1385e63
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5692:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR13MB569286CE08003477C745457DE7359@SJ0PR13MB5692.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4L+l6BMLq4vzTOj9tukHj1VqQRqedkrkOi9Q6397+Bof6ix2E1bzcwTB0MO3AfBaOYOizcESL2/N8k/E2gYkmioOLJ37hbBqrfX186mN7AIpB4JQLMLpFenuTK5fPig77VH7f5EOv0Hs/L1cjpFDhTM0BOANDXyJv+JXJLoYpo1ZGNFD58qVEa1tr7SoFgGveWzrbPHT51YcQjbXsKFVD76vFPfBvNd6MHi6G3keZxj+8OP/ttX5TJRZZk4Sx2WZzd+gY4QdBITQpoVoE+0jlMm5Ohe0tKpgC7suVICiyXbMwn03RXn22qFzceQZW8wcMkzXP9AESgMbcJX6T68pvQrBAeJCtBFgwtEQBfANLCdWFtj030tIY5kbNGwMRW2HTc7QXLVEYUUZq8eSMrNIHhEsS8rb2A2GgJdLuc7P/C/AtBVQ08DcwKNIjn8IWPahEUPiZvFioe9ycowrdfxIQ3KH0uY4PsUCYbVXpFwAF3dMNadW6CJaCNWvtB6dndfx99opZVj3JF7DfTcnWsZhHr7EGWIpBiWDd1A2re6V078o8JQjlkEN9sFKve92Ow45CCWz0neiOk/DrBiOpgR8GJKg08K2hHbM0gHp/tAgFplHl1qUYLZ74L3eyRfbWe2ATjnE4grGEbhEpu2g0sQuIyibsxj3d8MshIsTcOWEaDJXtcLPjn5tCKDeUV3N1Wo2QhZjLxBD7e0P05CaNpcdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(39830400003)(366004)(136003)(346002)(376002)(38100700002)(8936002)(38350700002)(86362001)(5660300002)(110136005)(26005)(6506007)(2906002)(4326008)(6512007)(9686003)(66946007)(52116002)(54906003)(316002)(6486002)(53546011)(66556008)(83380400001)(66476007)(6666004)(66574015)(186003)(508600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6d54SaukzPFNV542FV3YhSplChV1lxpgTKeiUh075LsCSJrmcdPtrfgXLJ?=
 =?iso-8859-1?Q?lO4b3s8D8vEow2nlTWT6aXx/bEEvwv3ZcyZ7szl/MmljSgx1NcGAdZIkO4?=
 =?iso-8859-1?Q?ahhk/wv3c1t/aDhDjoeElMz7avGupU87vNU6Pd9IOAIiJlxo/fi5brFX0Z?=
 =?iso-8859-1?Q?XWR9dUDnHz40GUB0emqF0U9qSr5UK4L4LIiHw9ra2J/lRt6/lou8eeE3K2?=
 =?iso-8859-1?Q?fWEs+dpgfSRfd7w4TLrCbFUHI4IchJMAmxu/XZ+dMHinVCGkHo/6PJYc7X?=
 =?iso-8859-1?Q?CSoreb7JmLAh37B4ZY/cN/dXB6OvNm5ysS6P39EMHEPl6PNKIphE7mB07R?=
 =?iso-8859-1?Q?2luJYKd4nutT/zh5R2AWhGs00z69UtelXiB/FPeG7tfyim2AAADO7v92Sm?=
 =?iso-8859-1?Q?s5esx/MDmHnP0S15H2yjijCIOAipTG+FgnDYn30FkGjpqwCm9bIpHJbz5a?=
 =?iso-8859-1?Q?Cae+RXJJZMFxBdcGXuaw4Z5FFDyLo9rQvdPBIFAH9WWMYigNrNkRffbgF9?=
 =?iso-8859-1?Q?RTV/i73h/H48jEVrFBWhz12m5WkPanCO1V+TMrtDW3bZpZOE0+1Im5L5rF?=
 =?iso-8859-1?Q?ADxDK/taEvCbfZ4j6rUqqy3frhrcyyF4iQ1WG7HlHCVIDiQXBLM3c9ghTA?=
 =?iso-8859-1?Q?Dncnc6mRAFjh5ur9NbcFXoxxA1VVtQD0L0bCRxgpUm7LWPGq8X/7WmPVIZ?=
 =?iso-8859-1?Q?fcTstRPwcuzfdnQkh38pr6bDYt7vjijM07dJVR6yCmeyjAPU7OYohgETgp?=
 =?iso-8859-1?Q?rXljyCb4/+dQcTdKn+tZQygaddJVMDaEYsrR/PXCdmbY/alnCbwFjE1aoA?=
 =?iso-8859-1?Q?wasY7F9rj36Pwo9cL4CT5pST6oTbcCGLkgw88PbAWd+5pL7Pw5LPF0x0jB?=
 =?iso-8859-1?Q?QCgbX+dXhe3cu9BDPT60KC2/4ORhTmleVFmn3A/PjvLT3b+zXEvxrHca84?=
 =?iso-8859-1?Q?+Y3I4WMbGpRONKoGGQxkZwUsemNlsaNVmgxrV/N+G2wkf6UjUZGkKMQmlV?=
 =?iso-8859-1?Q?AZ2SD+8lcWtsOcrlK9jlZqiKbU4OZHPzSqTyiwtvVmJFhWsomJSac/GiCV?=
 =?iso-8859-1?Q?id/Df7brqZcF/MPyljuv3ayZFzZrosc8J/zx+FRH+Z5kY9yp6MMj92CRYT?=
 =?iso-8859-1?Q?tDXt5PqGcmopH2LeaCwkdxdOQ7wKw7TDFli5g7vGmQelBFqcZjrr/tW9oj?=
 =?iso-8859-1?Q?I85kVBAvjIYT0qlgIGHZpRhkMyo4n653fcJiIHEomRKEgeAfaDp9HoNW+A?=
 =?iso-8859-1?Q?+mjjMHUP5yFfbEKlBOTdR4aCkKk9w8nT276eOOSPdtBfa9xakIDfhAvjqg?=
 =?iso-8859-1?Q?6loyp8FRdMEpTk++7800skWuitMq8u5sZY895fzuA3lTmExfAw7lU472KS?=
 =?iso-8859-1?Q?q5BJd/Xv5/PQBDy3/RsAGkqHH/cLlDgFTHDj73Q/yo8tbCyKBB/US4ZSKv?=
 =?iso-8859-1?Q?n1c1S/C6MUfk4jFTexoVksHQ/q3OFL0Xv6jiZmJU9SC54W9Z8G+qYkv1tc?=
 =?iso-8859-1?Q?Jt9krsgMmFtCQPmTBRAOQq1jmFLU9YPvShpV3f+FY+fQlfjkH3W4vQmxpV?=
 =?iso-8859-1?Q?IYuT+80SsLav9G/rtA+669NYWgXsjgN7EYH4DbYfNxapvnYiLp5ZHKt3xB?=
 =?iso-8859-1?Q?D5xtkK9UFDajkWQv95OyLeR+GsxEN1mTdqVmyPUQMHTUTE/coq6VGQ91f6?=
 =?iso-8859-1?Q?YFwJzDPMAIj7Hj/dvPD2BAlFyUP/EJM8CEbRCckiKEoDovPvc/gpprHLl4?=
 =?iso-8859-1?Q?FDEw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2524aef7-e98e-4157-484a-08d9f1385e63
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:37:45.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgjH/b7YYZz3qg7gnMHRcqZr9FO/TrFcIOSlm0v05brONDBphPmjkqHBgClefyAs+jias5XoZyOaJX/2q4W7Jo4oV29EWnqGfwxpE3EVK0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5692
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin and Andrii,

Sorry for late reply.

On 2022-02-03 10:24:57 +0000, Quentin Monnet wrote:
> Thanks for the Cc. This feature was added for Netronome's SmartNICs 
> and I don't work with them anymore, so no objection from me (if 
> anything, that's one more incentive to finalise the new versioning 
> scheme and have this change under a new major version number!).
> 
> +Cc Simon, David: Hi! If you folks are still using bpftool to probe
> eBPF-related features supported by the NICs, we'll have to move the
> probes to bpftool.

We do use this feature and it is something we would like to keep.

Do I understand the situation correctly that in order to keep the 
functionality in bpftool the functionality of bpf_probe_prog_type(), 
bpf_probe_map_type() and bpf_probe_helper() needs to me moved from 
libbpf to bpftool and used if probing an NIC's features (ifindex 
provided) while using the new libbpf functions if not? And the reason 
for this being that libbpf going forward will not support probing of NIC 
features?

Is this something that can be added to this series as to avoid a release 
where this feature is missing?

-- 
Regards,
Niklas Söderlund
