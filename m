Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A352D998
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbiESP5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiESP5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 11:57:45 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411089E9E2
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652975862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MULdNrt+vhfFUcKneaMHvTdLlHEIbs9CFhA5AaUefPQ=;
        b=QMclCsSjjZf504Durqs/zw47ciRHgSd6HvfoHyuO5uh/uxX4sZZhV212pzzsZ95IeAMJVz
        4exTu+NtlWtcY5fff0lMLwu1BhZWWQo4n69QJK1TUf0OUenz889TRoaOzHulodz6pgsC5+
        uQ8rjwdGL+7tCONDFcNYP4mgLfF5F7Y=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-Ej2HFpsaMrucf89sQsQiow-1; Thu, 19 May 2022 17:57:41 +0200
X-MC-Unique: Ej2HFpsaMrucf89sQsQiow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzG5ST71oK9Wy03PGEB7vmAr8ijK0calZfVWvelRrFR5IYPTlYJSZUlsJvG4YmR6voFu0tzbhZMrWR7Ytyx4UcgDXwqpQV4D+2A/DSSxXzbvQbn3GExA5kk6HXoUnmHPB6YUEt5duC5LlG2DkygKmsNKzesZFCgbpnC/mzlOvU6iW7eDeV4gsJ40pEySRPT+94ZffWO/t6FoptzKHo4V+7j8vJXGI4/cgNf+G5fHivRKgWUCV/0BBDU/hbA1MCZb6JNS4UZE/QP5FOXQZhQAbnR9MHwZCDX2k1P28D3HIS8Tsp6Q/PRHpKdSqMKtHpXpj06R+ZFYjmeYf4R3VeiAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MULdNrt+vhfFUcKneaMHvTdLlHEIbs9CFhA5AaUefPQ=;
 b=LJi54wK8AvYUYbgCM2OjNNfYWeTFJIjIBLX7aT2jojOh3EZfAerQ84QV7I9bMAsQBwxRItBKOw0Ge5C8wZJw4xmh7uvnPS4BoMX2214BSc83LzrnEAs0xYQfAAxsCAzD4YBlhujDQ2HqNg7WB1kE6yixPvNMlO+i/DNTyjBqsihq4G88QZIM4/FIj11FiZCoArW+56O2XmoZMK0RqU/E2WdcqitqnoeUVA9WBB1EgWiTD1ifmwQVbBc2dsb+RtcOFVBtILlcTUIJEoBwCdAemAl7zOcqUS4vyWT7uXqcUVvrAlhHr/4/GMW6g5pYi5LliwvgkdBzI+z15+zOaYImXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 15:57:39 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::40a2:1b77:8319:a7fa%5]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 15:57:39 +0000
Date:   Thu, 19 May 2022 23:57:33 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf selftest compiling error
Message-ID: <YoZo7S0w+92VXEDB@syu-laptop>
References: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
 <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
 <YoUIAFPYea86JvDx@syu-laptop>
 <YoX97QJ976GelRw6@myrica>
 <b90f2bc7-6405-7eaa-ef54-ebdf031a72b0@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b90f2bc7-6405-7eaa-ef54-ebdf031a72b0@isovalent.com>
X-ClientProxiedBy: AM6P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::38) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fef9c6-9925-4d0b-e4db-08da39b04ca6
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5542E7E805033C99703DB420BFD09@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+a14cPTr0YK02I5CT4+YhavtsZFODqnMyLeCzdI8iEvPoik7pPcHOvpiIJPDglWPLqAbMo5qCyndculDdH+aVTqt98OJx0PO1D9QjQ61uZYDx65wkuVYDnlWp4nZczxm421E0hd27Us7jQhKmlJHB0zk2CYnFN+rOMItg18Ixox7ss+eiszSSkR5F8IAh9xMBaNedrkSksOzIt2jnySpaxKtuTuV+lkABLMaKvsQTyPXpVqNWdo4ybttPCvn0Vpo8ZQOEeurjyAgoJuhS61UIF8w0/gjfoZ56GAe3d6tIalWkApNXSk3JtMDdoQStum+7pGdfjsXXBlq2m60J765e+0EFH4+qWigbYZBu+cTSRUaNFAc4BFkJt5AbSMwAwg1V/aR9+HFsbb6uFwvZkgQ4P8wXd1btvf+8yx2CsjUDG7bkJYHD/Xi8cX+7UGmHrYYRgChwFCT+g3RL2rhyorAxRPqHC8w/U4l1mpxudLdx5s8TZc9fxv60JtVnxe9XshscVzK7dyl04BppMa5tTKRR3PnBmTsK+FbuPM/4ZugYcKS8S0lClwyLvdZc1WvYp1bBoJJ3nHmjngpnpZedUWEmjn7ii3PZ4BhWXmHeumMoytnaBnH6UFvPxsQOVfabHL98BHK+m8oxuo9hguYu20li1tRCGfXaFrcrJus72idqh4u7N2RONYZoq892u0Zeea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(6506007)(66946007)(66556008)(66476007)(53546011)(26005)(8936002)(6512007)(9686003)(54906003)(6916009)(316002)(8676002)(6666004)(38100700002)(4326008)(6486002)(508600001)(86362001)(186003)(33716001)(3480700007)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FEVzRYcmErN2VlTlZzMzcrY3NaZ3VtWEwzRWs2OFljU2FiL2QrRjFJQzRk?=
 =?utf-8?B?Y0NyZ2VEd0pMKzMrSERXWTRCOXFTa25aN0dzdERDUnBYQ2h1OEltU2VsRnBt?=
 =?utf-8?B?ckwwVTNCcVJ5d0JaT3RRdldESzdtaFZFb09oWDM2dGZ4SkhZRFFOeWpYazZ5?=
 =?utf-8?B?WFA0YkRIWE1wcVhETkxlR1ZFMytiaUQ5akNwb1dBZjZWRitwa01rOFhsbkx6?=
 =?utf-8?B?SXdZR0E2eWZYWXhiaGpSZlRTdjBSYnM5NUd1ZklRd2dnWHQ2dmpTRnRYaEF2?=
 =?utf-8?B?akxxZGF4V01yVzd0NWNCeHpaRzBYTnltdkh6THIvMDVpTCtQcXhnQ0hOTmtO?=
 =?utf-8?B?bmZnNVFyTGNwMHg4YnlpV1N0ZFVVNFgybFp4TFcyWnd1ZTVXa0Zlb2JpWXdF?=
 =?utf-8?B?NG5NRm9XSTJRdGI1UmVZUklMUTVKZG1oS2R1cUtoMmxET0MzV045WDhmUHJS?=
 =?utf-8?B?TmpKNlYzTUQ1a3Y0RGwvMUxJOXNwVDVzYUVweW0rbVF4UmVWeVlDRXlFOStY?=
 =?utf-8?B?NXBVVE9VN20xMElnbEd2U0hrZEtxZlkrSG5uVXVDOGVGTWp3eWpxUTlUNTZJ?=
 =?utf-8?B?V0s4L3g0R2Q2R2RpcUhNUVM2REtEMVp5UXdVK2NxZWZxTWwyVzQ0TCtyTGNE?=
 =?utf-8?B?WEZqVUNXOEp2eG9jSTh0VG1pSHNUUzFJZU5kM2xYYjFub2ozOVM1YVdFN3Bz?=
 =?utf-8?B?WU9kTGZYTnpaa0dDMDA5ck51NTJqandHeWZ1Rzl0R21IbWJiZ3YvdkJkaENx?=
 =?utf-8?B?eHFVR05lTVlpek43M0k4eG1HcnJyK2tRMk5CaENBd2ZuRmZ4ZFhQKzZZYWpO?=
 =?utf-8?B?dU5waEEyLzNvZDBNdnB3UFRHd2RZVzcwMlF5Y1hvek1NdUVjZVRYcU01TXNN?=
 =?utf-8?B?Tk12QXBCK0ZHeENXeFJmU2pvd0RqU0VXZ1N5Ny9SM3dUd2VFR2p1a2hoZk1I?=
 =?utf-8?B?UXFkdjQ0c284dFlab1R0S2JISnVMZFRxdXY0SzFOeDdZaExZa1BVTHBBYVB0?=
 =?utf-8?B?bDVHNXd5U3VxOW9Rb0VFNmRFQTNnU0RpSytPZTJBeHRkeFV6ZnM3a2MvbzM4?=
 =?utf-8?B?MVUrVWc4S01ySFdXcWdlNmxmc2ZxNUVFWldhT0tybDVTTnNqSFBGWnh4WU5z?=
 =?utf-8?B?UnRja2Z6UFRpVFJLR3VjZmJQRm5DcTMxR3UxODRKcWFTODhwNlN5bENzdVJH?=
 =?utf-8?B?cGw5ejRsaE85MTR1WWE5cE4zc2c4SWxNZytGWWlmakpsUVZ3VkZaWGZHMEg1?=
 =?utf-8?B?ajB4WXdtUnovSFRTZFUrNEF2SzI5U2h5WE1HamNlOFZlYktTUlR5ancvcXdN?=
 =?utf-8?B?ZytFNGErVGk2VzNyUUVsOEVCSFR1UmpGSTQ4NmU2OHptTjhrZUdBTXJQUDlW?=
 =?utf-8?B?c0x3eGY3TysyZkRjVmdkK01hWEdvVnhtR0MwcUJWSDJFVjR4dHNUMFJNS1E1?=
 =?utf-8?B?ejA5SWRlM0Iyd1B1a3pocUt4T2h4UWdNSVJGS2lHZVN3MndCdm9EbnNuY0Rj?=
 =?utf-8?B?WFF5UEpvNUkyam5WL1J5Ujl6NE1hdHNJem5kY2IxSTZyWUs1b3RJczI0OGwz?=
 =?utf-8?B?TS9UMkxjSnBkVk5MaVVKZ1J1cVVLK2VoYVJvTjJTcnBuOWFBQUZLMlEySktT?=
 =?utf-8?B?Z05oSm4yNXBTKzhSQVFlOENHYVk0dXVQU0s0L0ZCV1NPakJ0S1VsZHVPWU5m?=
 =?utf-8?B?Tzcyd2llRFhTck1TWlVSdE14QTlGa1ZYQ2hwSGhLOWZSSjlWZWU0Kzdkc3NG?=
 =?utf-8?B?bnREcldQaFVnbjBOcDRhd1REdlMxSG4zU3JqK1k4U3dCVkFWRllqZ1Nxc0Jz?=
 =?utf-8?B?K3ZqbUxUSGNEMGUzOGZFNVVsaWgwNFZRMDdEc1czS0ZLaTFkNm5wcS8zU054?=
 =?utf-8?B?VHdSWVZkOGp4TEQ3REpTUERzUTJvL0RtaEJ0SXdnTDZjWGRMSS8rK25EZ3Bx?=
 =?utf-8?B?OTB1alVQQU8rVzVWOXFvZnRnRHB4bVJZRVc5WFhKNTVnbmFJNnVvaXVDZUJS?=
 =?utf-8?B?WjBndkxJWkhnZU10L1VvUEJPQkk5R1lBeWEvYzlkemV6T1JRaWM4YWRMVHd6?=
 =?utf-8?B?clFmQ0ptYmYrYkxzK29xcFRMZUNwWFRValpUZFBqZkRxaStMak44cDB5SDhR?=
 =?utf-8?B?YjR4ai9OUnF6OENOTzIvd2F6MSt4Y2ZYbWROaW1pQWlxSnU0Unk0cU4ybGow?=
 =?utf-8?B?SnBqUFZ3NFlSanh0eDJ1dmEwMXRJWnJyWmFJN3VaTjFYSkJ2eHp4cDI3R1ZV?=
 =?utf-8?B?R0lncUw5SWRlNnllS0lRZndnY3lUMEZJSkVnTWFQSitHcHV0S005VlhmQUhU?=
 =?utf-8?B?NjQ5OWJFUGZFOWpDNzZIZE9EYkV2RkltT20xNTBiM3Q3M3Q1WVQwUT09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fef9c6-9925-4d0b-e4db-08da39b04ca6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:57:39.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsWH27hCgMOUOgXiJTfPiE93W1T5qqXHwcT0dRA4cD6YIlwhAa1fe9Xgg8xdxNJkKghVjhkGY3tCiD/j8EDkhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 01:10:42PM +0100, Quentin Monnet wrote:
> 2022-05-19 09:21 UTC+0100 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Hi,
> > 
> > On Wed, May 18, 2022 at 10:51:44PM +0800, Shung-Hsi Yu wrote:
> >> On Thu, May 12, 2022 at 06:12:36PM -0700, Vincent Li wrote:
> >>> On Thu, May 12, 2022 at 5:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> I cloned the bpf-next and tried to compile the bpf selftest.
> >>>>
> >>>> first I got error
> >>>>
> >>>> "
> >>>> CC      /usr/src/bpf
> >>>> next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
> >>>>
> >>>> make[1]: *** No rule to make target
> >>>> '/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
> >>>> '/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
> >>>> Stop.
> >>
> >> I also ran into the same issue on bpf-next, and the error seems rather
> >> absurd as
> >>
> >>   1. asm-generic/bitops/find.h was removed back in 47d8c15615c0a "include:
> >>      move find.h from asm_generic to linux", so perhaps this error has
> >>      something to do with Makefile.asm-generic
> >>   2. normal way of building bpftool with `make tools/bpf/bpftool` still
> >>      works fine
> >>
> >> Anyway removing ARCH= CROSS_COMPILE= in the bpf selftests Makefile
> >> (reverting change added in ea79020a2d9e "selftests/bpf: Enable
> >> cross-building with clang") can be used as a workaround to get the build
> >> working again. Adding the commit author to the thread to see if there is
> >> better approach available.
> > 
> > Could you share the commands that lead to this error?  And did you make
> > sure to clean the build tree?  I often get errors when building tools
> > because my toolchains changed and some dependencies in generated .*.d
> > files do not exist anymore.

In hindsight I likely did a clean after removing the cross-compile
environment variables, and that's probably what made the build work, not the
removal of ARCH= CROSS_COMPILE=. Sorry for jumping to conclusion.

> > I can't reproduce this specific error on today's linux-next (but found
> > another issue with out-of-tree build that I'll investigate). This is what
> > I run, on an x86 host for an x86 target:
> > 
> >  $ make defconfig
> >  $ cat tools/testing/selftests/bpf/config >> .config
> >    # and enable CONFIG_DEBUG_INFO_BTF
> >  $ make
> >  $ make -C tools/testing/selftests TARGETS=bpf SKIP_TARGETS=
> > 
> > Thanks,
> > Jean
> 
> Hi, for what it's worth I also observed the same today in samples/bpf;
> but after "make clean" the issue disappeared, and I can't reproduce it
> anymore.
> 
> Quentin

I also can't get the error to reproduce.

Thanks,
Shung-Hsi

