Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79C69AD30
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 14:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBQNxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBQNxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 08:53:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1DC17CCD
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676642010; x=1708178010;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MPBfK0rU005cQNGGj/21HR9za+uAW/as5T0wQGTlG8c=;
  b=OfRaQMKNa0IdonwicxuEG2aj/NEjKyB4Th4UMmm7kFvmQoCDumBrdEtN
   0+h2K8vs2ezlIITsj5vJVMuc0WEM0X9JIAitmq013q31zaEdHHLQs4T4d
   YcrTVw0X/cs6fEnalhKYLgnfG6WcEXANuryJMHyuCP+0/wNQQS38E6ooI
   sZOEnTaJyNhjjVztyt5ep9ZopUbWBMPQk92np5Q0xqQNVggOra7SsyqyY
   3IdV7xiDlMUHjt7tuKWSc+H6VTEXI5c8WtYtfyc0RSjqf694V1KZd6R/+
   zgvO/r1q2coz6I8207bZYR4SJGg/6V7AVBPDpLtig8MiJskT1BMZDtt2t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="418210628"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="418210628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="620405083"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="620405083"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2023 05:52:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:52:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:52:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 05:52:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 17 Feb 2023 05:52:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb7vSQ1N0LY6W6lxE09McIH2rBYONVRliPaPAYZQPPLHHZaHnW4YLeLvSeoB1tHY2IyPY4u5TQlh6B4jxWUJRbrqRKrNvw+5CwpbRwASD2V/03e2P+kZOIifPvimFdxgIHyQvZXn6D654l6k59ZFilsWjZpU25SF7U55f6rDrsHI1DmhvxrWyAdh+BN4tQeXlKdJH4hDpZ4KpkJf2MyBmXHMlCf/YucO1fSYxwe+O10NvjCXKQLAR0bC7+Tad4bRDbKuC4y0moSkn4oJZgou4EdqgHgngqmbIB/9+vnne3M+IgLJZwfJRt+D/RZOgn+YSp8Eor12ohvlDpQ5YN62vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPYGBoEYxJ+GhVwLyk00HyxT27W3EXOHBQdmemsIivk=;
 b=J8M9zgZp2pksWHZ7LpON/59PCs/Rl/+KlLsU6ZZ2M9+K00Xdo8dGCyWJhnzqQDlIHUZAxpZrG7nAqbidQgTsiTa/xZTL72TUgVSW2UxEb/2gwUJAxcddAVhLc5h65MZozBv7MSdMY0k0bhmwT7xZ+AnfAW+1KiynDjKLteUgFwV+WDAZWcwhyWoX4kA8sXxLWQVKqFV1lBYlBu7yoZ7CCejJr2fxVSTccDV3svZxBuIxulZzbmDmK3YExxXX860QJtmdppPaZh6r/ir3ql/eyiR0ck6OTQPOnhXbSyM6SFuIx+JMQqw086QHJvY3YC3JXHOyuE0suKCxVaAICybOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB5122.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Fri, 17 Feb
 2023 13:52:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%4]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 13:52:24 +0000
Message-ID: <50c35055-afa9-d01e-9a05-ea5351280e4f@intel.com>
Date:   Fri, 17 Feb 2023 14:50:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [linux-next:master 12987/13499] include/linux/build_bug.h:78:41:
 error: static assertion failed: "SKB_WITH_OVERHEAD(TEST_XDP_FRAME_SIZE -
 XDP_PACKET_HEADROOM) == TEST_MAX_PKT_SIZE"
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        "Martin KaFai Lau" <martin.lau@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        <bpf@vger.kernel.org>
References: <202302172104.q3ddwzqu-lkp@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202302172104.q3ddwzqu-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:4:29::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a41206-f545-4ee1-110c-08db10ee3254
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ys37uyVGj3iAQV6SCUkqMbv3o9ml8AyTTqzWS5v8egIqugiADdf5Oy28xw5TOexrRG08JT5U3o4xnH2TsVip2Szee5a093JdJExw4z2KY18n2k5qDM8xdsTcoLXfnjWd5DCC9lTV14dxN5Kb+qysVIpwOyqFlwdPbsG23DOZTWRjCVbYDQoilFK2Vsxm5Ql0fO5LvGbDhTApIst/FVYxVZGTXD/1rcp8S6p/3ZScxychIL9ErN/as7bSSICjv6O6mWPYzGFZhoctDnIWN9xwwqAUmUvWT+KiizP9z3yqNARjiWByUIUs5A+45ViKQ4SpTaI37GXs3/DkXLsbdLsA7z/tEl65nmZ4XIx9nUAc4GIh4zJvBxg2H749QXY7chNxHVpbB9IDvJ+xPInVwUXKlxxbKaoYD12f5WypyvY3Ky/PssoTYBc5ultQfz/r5P9r2oTz/04+IvCcz+jJOIDzkBlVC4/JIUXtCioLmz0C/JiznnFekai5+eQF7FJxKortB6lG49EXTpPxsAkrP563AGFw9edi58GajhLyNp59y2SedRdwTBQ2duWnulqZIJfaAwgvA209Mxe/kjxezftcEBxB4ORNehaCnO7GRVu6sHvka2QMwyem9QA6k//62YXrOxxVh0vMDy1BkA/kBl9YeR9yI8B9XfvoxSaBHKJkn/s/UXLZesL1nNwmH+tcpxvxG34OInTjPIs153JmAbRmerwdHmjseIYZulPN133VnIoG/EntQmfC4LYMtfYEIQ6R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(4326008)(66476007)(66556008)(31686004)(83380400001)(8676002)(41300700001)(66946007)(316002)(186003)(26005)(36756003)(6512007)(8936002)(6506007)(82960400001)(54906003)(2616005)(31696002)(478600001)(4001150100001)(86362001)(38100700002)(2906002)(110136005)(6486002)(5660300002)(6666004)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJraURYSkcvM01HY3dtbk9ERUdPMzBTYzNkanloNFYyUjBVd1FzYzNpeHN4?=
 =?utf-8?B?QnFtSm1mQ1dVQ2x6elFBZHN5eWRyU3hDNjRmcUdabitCekJZOFR0dVFmajBz?=
 =?utf-8?B?UklaclR3cHFnTVk3NGN4N1FRcG8rWVJ5QnVLZjJmbjlVOHVFUEdJRjlrYWVi?=
 =?utf-8?B?cG56Q1lPOUsrY0k2WHBVL0dDOFVoaFRaa240a0RhMjRsV0Erc29sQ2ZOUGh2?=
 =?utf-8?B?NUQ1b2pMa2NCQjBWMTBSc1ZoRFhYQWJrdlE0YTdtajMwOXFNMVdOQjl3Uk1N?=
 =?utf-8?B?MTFpMnI0NGh1Tm9qd24xNjZ3OWprVUt0aStZQWZ0UzVzeXFaR29DcSt3Uk9s?=
 =?utf-8?B?M1hvK3JMdEQ3S3dheEdXMlF2cjlxcDNZM2ovaHk5QiszejNhQU1uSVdvd3Jv?=
 =?utf-8?B?d1dWWjF5eUlkaE00OVVZeURCQStuOCtkYUprYU1zR2FVSU9CMzFKdjF4TTBp?=
 =?utf-8?B?dXlERC9URXBZMUIzaFBnUlltM3UweThpSC9iSlkrNXZIRjdrU3Q4OVAxVzE1?=
 =?utf-8?B?TkNiK2N3UEhEWDRwNVYwSm51dXdRZlk4cldJWlZFbXFQTGhLMUZWejlxQ3NU?=
 =?utf-8?B?dnpzNTc3YStMOW1ROUo1RElnaFEwLzZyb3pBbmtwN0tJc0JsUHVDcTlWRzlX?=
 =?utf-8?B?eURCaFkzcWIvcXlCZisrSG12Mk5CVnZ2Y2sxaUYrT1hBSDQ4ZU5OTUxFMVN6?=
 =?utf-8?B?Sm1WdU9sdmJGWU42eDhoSktXU0kxdWlpQm9YWVFiWVlxRHAydTdoRVF1bVZh?=
 =?utf-8?B?QVJ4WjNPZW9RSFp6UlZoanVrREJQdTBoRHR0UkhVTXhsaXd2WC9xUi8zTnh1?=
 =?utf-8?B?NzZaUkVrY25ucUJtdU1BeXlvKzh3c29sZEw0cEd5TTdUa0I1NExaNUZDRkhz?=
 =?utf-8?B?Q2daOVVWYlJ2YzVldWxTZWVzejdsMEpTKzNJeEVHUUt6RkRzeWFpL3o4MlFm?=
 =?utf-8?B?Y0lMU2Eyb2RTa1h6S053clJ6MG8rTXI3c25FQk9TQjhIMmpWUis0cmliT0tp?=
 =?utf-8?B?akNJNjF4N2c3TTNMcjZXOGdXN2JjOEVHNElFMGI5eW00VGd6S2g5V25pVUJ6?=
 =?utf-8?B?TVNXa0gzWlVkRVk1RlFzSVE4ZHM4MzVLV0NXaUg3Y281WVlmM2VTam44dFJm?=
 =?utf-8?B?QXFWQVkvSytnUnl6aHA3WEgzNi9hc2gyQUpuNlVDNWJFbEZ1YnNNYXJZREpG?=
 =?utf-8?B?MFU4MHgxbXErOWttZHE2WmlQRkFsLzJKQ3Vuc1BxV1lSTE82VWpwenJOYncy?=
 =?utf-8?B?TTEyQ0JXQ1VUVmtSMFFmZW8rZDVxdWtCM2pTY2FwVVdJSzAwUncvbmpUd0RW?=
 =?utf-8?B?MWxBalkrMTViS1phc3JNbldYMmNhbkhjT1pTejZZWmpRcTZxZzdUbGwxVHY0?=
 =?utf-8?B?SnIxZGNXZitLc0pVVkUxbUZtT3ZHdXRWVXFmOE80WVFEQUpuZDltZEphTCth?=
 =?utf-8?B?Q0JjUmRqS1pMZk10L1FRenFHRlZzMUcxU0x2OGpIYU80ZzF3dGt1WEI4bnMr?=
 =?utf-8?B?cGZXTFFLQ0J2MkpzdUw4Slh3bEZxSE85MTN2YlEweTBsNGgzdUJsR2RqdThM?=
 =?utf-8?B?a3NXNmFVUXgrcnZnSmFYQ3BNMEVrc1lVMnBhR0dUdUw4S2p3a0dKeFJLZHdk?=
 =?utf-8?B?ZnkvQlNZS2w0MndqMGsxNVRheWNRQVh4bDRxWWRhd2NvanRNa3dvcE9MSnhu?=
 =?utf-8?B?KytLb091QjR6RmRHOS9kc21VL2lWTkFOV04xbDRWbUVnZE13aG9OR29RUkVr?=
 =?utf-8?B?NDhHMERKTCsya2U3L2tHRGR2dnIvbFJ1TkVueEdGOXFzT0dJRHdKQzlKVDJl?=
 =?utf-8?B?TEgrSzBkRElzOGIzdXE5djJ2WDNUMVdFeWcyUW9NL1pJSVJ6dzY5R3JFaUEr?=
 =?utf-8?B?Wnc0MUkzdTk4RWprM2RrVlBiUi9NamlmYzE3bnYxQ1N0aE55ekU4bkx1alRQ?=
 =?utf-8?B?NjM4djJaRGVqLzhyTWNqL0N6STdES0VhOTlHT3I2blNyTW95NjVDbGNJVVM3?=
 =?utf-8?B?R0hqTGJGQTJTRVhGN1ZEREI5ZlhGMCtUSGtUUkVWeWo0VTF0MERYamZ1Rjdo?=
 =?utf-8?B?UGo3ZkZwekcySU43aDF5bG80M05nMy9ucWhqUWNqVVZoZ24zdWhSREMxMmM5?=
 =?utf-8?B?eTZQL2x3dlRQSy9GNS9Cc1gydEU5NXFMT1hqMXAzVllBZ0l1RTJ1LytONHg1?=
 =?utf-8?Q?H0gRhtvEjAHn6EIpU0ob6aU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a41206-f545-4ee1-110c-08db10ee3254
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:52:23.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhDTTb1ZGyxK6cYxmamXrT3av8WX0bIo3akDB5XAeDkS252NMdGRQnfJkeGfZNNYAuQTvgTWGM1SdZeSeJCeDxv5X5ToBRM9owy0og9JFTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kernel Test Robot <lkp@intel.com>
Date: Fri, 17 Feb 2023 21:45:40 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   c068f40300a0eaa34f7105d137a5560b86951aa9
> commit: 6c20822fada1b8adb77fa450d03a0d449686a4a9 [12987/13499] bpf, test_run: fix &xdp_frame misplacement for LIVE_FRAMES
> config: ia64-randconfig-r025-20230213 (https://download.01.org/0day-ci/archive/20230217/202302172104.q3ddwzqu-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0

ia64 has 128-byte cacheline on some configs. While I can easily test it
in the kernel, what do I do in the userspace test >_<
Or just exclude non-{64,256} CLs from the assertion?

> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6c20822fada1b8adb77fa450d03a0d449686a4a9
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 6c20822fada1b8adb77fa450d03a0d449686a4a9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash net/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302172104.q3ddwzqu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/timer.h:5,
>                     from include/linux/workqueue.h:9,
>                     from include/linux/bpf.h:10,
>                     from net/bpf/test_run.c:4:
>>> include/linux/build_bug.h:78:41: error: static assertion failed: "SKB_WITH_OVERHEAD(TEST_XDP_FRAME_SIZE - XDP_PACKET_HEADROOM) == TEST_MAX_PKT_SIZE"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    net/bpf/test_run.c:132:1: note: in expansion of macro 'static_assert'
>      132 | static_assert(SKB_WITH_OVERHEAD(TEST_XDP_FRAME_SIZE - XDP_PACKET_HEADROOM) ==
>          | ^~~~~~~~~~~~~
> 
> 
> vim +78 include/linux/build_bug.h
> 
> bc6245e5efd70c Ian Abbott       2017-07-10  60  
> 6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
> 6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
> 6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
> 6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
> 6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
> 6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
> 6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
> 6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
> 6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
> 6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
> 6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> 6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> 6bab69c65013be Rasmus Villemoes 2019-03-07  79  
> 07a368b3f55a79 Maxim Levitsky   2022-10-25  80  
> 
> :::::: The code at line 78 was first introduced by commit
> :::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert
> 
> :::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 

Thanks,
Olek
