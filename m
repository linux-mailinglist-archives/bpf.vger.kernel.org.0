Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8FF634DFF
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiKWCno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 21:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiKWCnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 21:43:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBE85ED7;
        Tue, 22 Nov 2022 18:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669171421; x=1700707421;
  h=message-id:date:subject:to:cc:from:
   content-transfer-encoding:mime-version;
  bh=YZn8aVV5faQcx/UHCdwkWQvrVsR6R6ej4MrZBAVIycA=;
  b=W6seQUCWUIrVxQpOi2y8TTgN8Z+NyRBn3ib6kwmE6eL/EYLxk12VDnfx
   60ER1VgdaEH2zFus0iH92TR1YXlYegei68OdDjBjcmH1SsHTVQklNpreI
   urkX1GGFp3K0skGHsrZ5dVop1BRitdo6y67ogAgB3SlBKeiSsNtIMWRS6
   pMH6Cpfr81PDT7uw8jjXxaOHroFRehZghIt/m+SOjtyxaP8TYGvgN+QkX
   7Q0MtULAwLA4/yQ1sSY2Y2NeBN3ZwQCgW7Hw4YYilROnjf71KNjcNoM6Q
   FOSAQxPvg5SoP/G8p8DWwx5yVQx13pNkMWIsvKs/NjIFtgQuvy76lk7GS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312665483"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="312665483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 18:43:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747601869"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="747601869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 18:43:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:43:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 18:43:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 18:43:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 18:43:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeIoq9vcA57UYtJO82RFtfUVz/kXm5v+NqYWz20dmYncdcZciZOO0gzDZJeFC/ER4KpjP6CE31cRR1/8y7bCdn5NFbteliS1774Vu/GosP7qaeQYpq3Pws3xdMzJgqcfDb6WlbVbHj+VB8Gsj+JKVFeub//tGXeeq7EC04OCBOHsvwn4zVEOoCgm1hZnxgB/iP3BB6gDK1u4GKDzLW5zBIidRq8RTr5gE3FR/BdDVchhLkVlelPQcBzEIQTyixxiPzvgVV5GI+OlhcSUjXm47f6dfgMagRSyy2i3X4EiP1BT6OGihIuY/eVuwPDWyQ1VsNZqqyUuwKROHybBaySBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFgbJX83f12a9yRdr4Q9wCAykYbrvPN2X2zWgl2ND6M=;
 b=GMDmh/nMOX6MEyg/vLMx5WbiTcadUa0HsxGCW+6hyoMv9slB4lurQ3xSfpXbZeWSxQEnHyqh8OD86O6yJxZabmBEn3oye72/FTm+MvDv0BMNEFuFc4fMp+sgwfFIwkp7aWPg8zUKjzURYeiIrpAhLEMr3vM0zKqsIKuQ5h9338abqLN35rF49q8guIBfQ1wiT31P6K3j+YOAS+kpPtAqf4t8YUhJGQDZ+bgFMDf2r5Ia/NX0tSs3BJRhc6uhZc/mUVV5kapkzN2UOctgyGHzBAUF+ujBt/4v2D7WLMkLpZ7tL0k1P7zdEAxk0g5wHgwF70We/ssZwTiZD0EyIIPfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 02:43:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 02:43:27 +0000
Message-ID: <54f23c9c-97ae-e326-5873-bfa5d2c81f52@intel.com>
Date:   Wed, 23 Nov 2022 10:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] tracing: Optimize event type allocation with IDA
Content-Language: en-US
To:     Zheng Yejian <zhengyejian1@huawei.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <mhiramat@kernel.org>, <oe-lkp@lists.linux.dev>,
        <rostedt@goodmis.org>
From:   Yujie Liu <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 6724312f-61af-4982-85d1-08daccfc7f78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuC9vPA46yoAvu9E761PDASsuE44aJeFNO7nBfJILzPfLA1Svz2BIJYZJRAxcPekUM81rPP3vjr4axn/mHJnZ5t+x4FzWynoqhg0cYqE7/Brs4oSd/Vak562eJbBSew1SFzp+64SbpSm7F9rBK3OPQgEiN6FxWSOdfV2qHHJhmFm8pfaCw2jxp2Tdey2uwrUu5W8WII89hk89L0gxYj+ZktHXkgGiQk3QCqeW33MwtXKqFkZeTpSxJ3GRYPPaaW7pLsEu447MEAIj3oa+/fbJYTNBYGSfjodCH4pjcS7QVDibSKUaNpIINAbuNBWvMbnpKsuueklULLdhozBC75/6ix5TS4qAlLUw39F1X/pqmBGr4dh0DMy+hlV5AzN+A40kmkPLQ/mhadphY84WcsTI3qQ1/FlImqhyI0oqaOj88mhWbyva6qSSrTSJ5tEaKvDEOQUskLtmej+T9nmd9x8PUMZGH3wGJHV1BhXALBRD36PThpQMwSmcpreE7ipWcSJ4DIFePrWvG7OHJhNt1wMjA28AFUrAljXPv66MX5CsgW9um1PyUkulo98mHq9W+zBCW9NGmiMUFlS2sv7eQyrdQ9wmnqvXc7XVEeP0FuiadC848S7lyza8/108z0MqkSzXhpbtNZ1ZrOdP37SFOqqcU6kdpUKKoXsc6eOcIOBdb3V6lEBwVhMXVIMXdCg/AvNm18tdVaiK5d+rpZOQzkfDHB23FNpj1n+URqQXIixpnToU9eVypZL5IkqZF4dV+SzOjvVmIq1s8gZqWVLGJ993XctHsG8WbiyxpOkfR3HfQJowQHsleGDx44DRFuGGoaW7pKpIEwItxrg1hX0PMV+0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(66946007)(41300700001)(66476007)(66556008)(8676002)(4326008)(316002)(26005)(6916009)(82960400001)(6512007)(83380400001)(38100700002)(2906002)(36756003)(8936002)(186003)(5660300002)(86362001)(2616005)(44832011)(30864003)(31696002)(478600001)(6506007)(6486002)(966005)(31686004)(53546011)(6666004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1QvM3o2VGhHQktWVEhZWlViZFR1cEJCSi9SNE1LdVFoemMvNE5wd2JZSUM4?=
 =?utf-8?B?SHVYQlcxK3JUVWY4dkhYcDBLZ24wQlpXT0VuS0Rlb3FkTnMrN20xT2R1VjBL?=
 =?utf-8?B?SHUvcERJblBnMVQ0QWdhRHJMelNsbGlXZjVobHdRTFlWQjhma2k1T1liOG5Y?=
 =?utf-8?B?Q1Z1YUtzeCs1Z2NSZTlhN3kvMDZwUzUxTjE3aVErTm9sVUc1bndlRHJna0RX?=
 =?utf-8?B?cTRnVHM1K1JzSDhhWEdRMTEzZkZDWG9vbWM5TUhOdHFrSVI5ZGtrTjVpNUQz?=
 =?utf-8?B?bDZZY1Y0TjlzRXpNaTl2Q1BDanRpRE1Wb0UrYko4bWx1dkxMY283S1FNbWJz?=
 =?utf-8?B?dE96V0MvdVJNSjB0TjV1QjI0dDMzYVBaZ3lFb3RUSk5GeFlCMkhjOFZ1d3cy?=
 =?utf-8?B?N2FRYldPR2hoeE4zWnR3a0xEUVl2ZEhhRkxqbGdUS2w5ek1qUGtSK09yWTVn?=
 =?utf-8?B?dkJ1QmNpUmFvMk5VNDZ1emVGeUozemIzT0FjV3JsZE9Gc3JaM1gyOTZIWEFj?=
 =?utf-8?B?dExZWUFlTGlmU3piVkJTa1VBRGxjUFBQZE5GWGJTV1daL3NDWUNIL1NLelVh?=
 =?utf-8?B?REdSSHU0L2lPMGhPM1M0ZFZpNzJweXRaQjJBWEJ2N0Nwd3IvaXlRblYwdGRS?=
 =?utf-8?B?cHRDSDNSYldoQ3U2Z3FiVVlDTFNyVDd4dFhLdVNrM1MyNjdwYWh1S1JLSWll?=
 =?utf-8?B?R3hJdXA2QmNsaFhBSDdha09xdVk4WENoaEFIZEZ6azJYamk4bVplSWhiNm15?=
 =?utf-8?B?VmFFSE1nK3BlN3FzSHBxdVVGV0swK3k5UlFGYUNWcFVkK3BjdGovYmpPWVhW?=
 =?utf-8?B?ZzM3YndacDh5RWwyQWlweDhBMStiaWtJa3pEbUR5SFNJeG1MUDV1QWpkNWIy?=
 =?utf-8?B?eDlzc3F3bnk0TVNGeEN4dnFGM0ZQbWJRTHVrL2VZMXRvdFBTYmREUTNCWUkx?=
 =?utf-8?B?THkrTFIzakZMOHZ0TGx0U3pOUmJwdWJOTnVtRTNKRG93YnlYUjlIWUtnWTBv?=
 =?utf-8?B?NjRGNlN5SzJBWGZjdFZVNm43MVlpdGQ5UUJwRk1iNHdqdGk4RGtJeWRFK3Fh?=
 =?utf-8?B?aXl6SUQreGhGaklTR1c1YU9UbWt5VnlXK0dDN0ZKN1JZRUF4d0xOb09vOHpG?=
 =?utf-8?B?ajNWOHNwcVhmN2NMaDU4WXJHQzhpQms5eFFnQStOcjZOR3k5aEhaRHI3emRw?=
 =?utf-8?B?K1NIUFRLYi83YjBVdHo3WThzczY0azBoNmJuSTlRcUpwNmNUSkxaMjFlZ0c0?=
 =?utf-8?B?TEg4RmtPOGYvcmJZcUFoWEpTbnIzQ2syUGo5cVBCeElFOGk1VmYvaThXR0Rl?=
 =?utf-8?B?S2RSdW9MdHUraTVOYUptM1VBMldWOCtrT2x5TEZKM0RQYTI2enUyNFFrNDdz?=
 =?utf-8?B?by9LdmJDcEZwS0Y3TEFmWklqbXUwR3Z4N0VOZzh0a0twUTI3dmwrd3Q4emNi?=
 =?utf-8?B?LzlERVF5c3ZRejdTVmtCd1hvTnZjMG01Z1hSVEdJT2g3RGVxOWV5aUd5a09J?=
 =?utf-8?B?M0FMVG5QNEc2T0QvK3VzODNJdnhOOXc4VWp0Y1JHcTdhVWRVZkJwVUxBcjBp?=
 =?utf-8?B?WUI2QlJ4LzNMVnc4SEtFM1NoQXJmWC9EenlqNjVLemF3TUdqNmFNTjh6VEho?=
 =?utf-8?B?SVptMnVXd3d2eDdDdytrQWRPdXlSd1REWHZmQ1dUdkJlbURGK1EyVHpMTTBC?=
 =?utf-8?B?TmZLdTJLQVUyK3JwN05hYyt5WGQ0bEJVZ2NXWnJNQzNNTi9TcUE5TWRPbXNz?=
 =?utf-8?B?TDhqYXgrdGJRcnhlb0ppdFlnUmNyN3RGNG4zOUhVbDJpN3krVEhGNm5CT1Ez?=
 =?utf-8?B?Z2hHY3l2MWV6MDdjSmd4QU1POFpLbDZTam5JdkpIb3Iya3phL1RNYnhQWENm?=
 =?utf-8?B?K08yam9naHpnNTg3TWdFbHVUN1RHSjIzd2VQTlhrNTNWOGNDdnI4S1A3N1Ju?=
 =?utf-8?B?RXd2blVnK2NNdWdVdElvTklkK1dZUzNhUjJrcUkxemtWUXEyMGt1QWErTVpH?=
 =?utf-8?B?QUF4YS90VElHSVc0eFJrS2pTUHRHeDRWenVXZXFjMmxHaFI0SWx1Qk8xZHI2?=
 =?utf-8?B?T3l5bDArcHg3TkN5aFF6YWJ1V2NSVy9hRmR2SHVmZ1NnRmd0L29XSGpObG1M?=
 =?utf-8?Q?xLfpPU5SKVNTPQu1e0v9IGgRf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6724312f-61af-4982-85d1-08daccfc7f78
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 02:43:27.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZADPAKcMCQyLEPiZZiiYbn+UyJn0V3yxHesE/2fk91zL9CRHjm2D3oh0a0dJvUpDDpeAWbonF9PDLbrNcVQ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yejian,

On 11/18/2022 14:41, Zheng Yejian wrote:
> On Wed, 16 Nov 2022 23:50:04 +0800, kernel test robot <yujie.liu@intel.com> wrote:
>> [-- Attachment #1: Type: text/plain, Size: 8013 bytes --]
>>
>> Greeting,
>>
>> FYI, we noticed BUG:KASAN:use-after-free_in_string due to commit (built with gcc-11):
>>
>> commit: bb10be779a5fc1147d5765257c64a2fbea9607c5 ("[PATCH] tracing: Optimize event type allocation with IDA")
>> url: https://github.com/intel-lab-lkp/linux/commits/Zheng-Yejian/tracing-Optimize-event-type-allocation-with-IDA/20221109-112530
>> base: https://git.kernel.org/cgit/linux/kernel/git/rostedt/linux-trace.git for-next
>> patch link: https://lore.kernel.org/all/20221109032352.254502-1-zhengyejian1@huawei.com/
>> patch subject: [PATCH] tracing: Optimize event type allocation with IDA
>>
>> in testcase: kernel-selftests
>> version: kernel-selftests-x86_64-9313ba54-1_20221017
>> with following parameters:
>>
>> 	group: ftrace
>>
>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>
>> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> [ 341.472391][ T5846] BUG: KASAN: use-after-free in string (vsprintf.c:?)
>> [  341.478762][ T5846] Read of size 1 at addr ffff88812a630000 by task grep/5846
>> [  341.485921][ T5846]
>> [  341.488122][ T5846] CPU: 3 PID: 5846 Comm: grep Not tainted 6.0.0-rc7-00021-gbb10be779a5f #1
>> [  341.496580][ T5846] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
>> [  341.506170][ T5846] Call Trace:
>> [  341.509326][ T5846]  <TASK>
>> [ 341.512133][ T5846] dump_stack_lvl (??:?)
>> [ 341.516511][ T5846] print_address_description+0x1f/0x1e0
>> [ 341.522974][ T5846] print_report.cold (report.c:?)
>> [ 341.527698][ T5846] ? do_raw_spin_lock (??:?)
>> [ 341.532596][ T5846] ? string (vsprintf.c:?)
>> [ 341.536625][ T5846] kasan_report (??:?)
>> [ 341.540909][ T5846] ? kallsyms_lookup_buildid (kallsyms.c:?)
>> [ 341.546332][ T5846] ? string (vsprintf.c:?)
>> [ 341.550362][ T5846] string (vsprintf.c:?)
>> [ 341.554220][ T5846] ? ip6_addr_string_sa (vsprintf.c:?)
>> [ 341.559293][ T5846] ? enable_ptr_key_workfn (vsprintf.c:?)
>> [ 341.564454][ T5846] vsnprintf (??:?)
>> [ 341.568657][ T5846] ? pointer (??:?)
>> [ 341.572771][ T5846] ? pointer (??:?)
>> [ 341.576889][ T5846] seq_buf_vprintf (??:?)
>> [ 341.581440][ T5846] trace_seq_printf (??:?)
>> [ 341.586165][ T5846] ? trace_seq_bitmask (??:?)
>> [ 341.591151][ T5846] ? trace_seq_bitmask (??:?)
>> [ 341.596136][ T5846] ? memcpy (??:?)
>> [ 341.599991][ T5846] ? seq_buf_putmem (??:?)
>> [ 341.604631][ T5846] ? print_type_symbol (??:?)
>> [ 341.609440][ T5846] print_type_string (??:?)
>> [ 341.614165][ T5846] ? print_type_symbol (??:?)
>> [ 341.618976][ T5846] print_kprobe_event (trace_kprobe.c:?)
>> [ 341.623876][ T5846] print_trace_line (??:?)
>> [ 341.628600][ T5846] ? tracing_buffers_read (??:?)
>> [ 341.633844][ T5846] ? trace_hardirqs_on (??:?)
>> [ 341.638737][ T5846] ? _raw_spin_unlock_irqrestore (??:?)
>> [ 341.644417][ T5846] ? trace_find_next_entry_inc (??:?)
>> [ 341.650099][ T5846] s_show (??:?)
>> [ 341.653865][ T5846] seq_read_iter (??:?)
>> [ 341.658419][ T5846] ? cp_new_stat (stat.c:?)
>> [ 341.662882][ T5846] seq_read (??:?)
>> [ 341.666911][ T5846] ? seq_read_iter (??:?)
>> [ 341.671729][ T5846] ? fsnotify_perm+0x13b/0x4a0
>> [ 341.676973][ T5846] vfs_read (??:?)
>> [ 341.681003][ T5846] ? kernel_read (??:?)
>> [ 341.685470][ T5846] ? syscall_exit_to_user_mode (??:?)
>> [ 341.690975][ T5846] ? __fget_light (file.c:?)
>> [ 341.695438][ T5846] ksys_read (??:?)
>> [ 341.699467][ T5846] ? __ia32_sys_pwrite64 (??:?)
>> [ 341.704620][ T5846] ? lockdep_hardirqs_on_prepare (lockdep.c:?)
>> [ 341.711083][ T5846] ? syscall_enter_from_user_mode (??:?)
>> [ 341.716853][ T5846] do_syscall_64 (??:?)
>> [ 341.721143][ T5846] ? lockdep_hardirqs_on_prepare (lockdep.c:?)
>> [ 341.727609][ T5846] entry_SYSCALL_64_after_hwframe (??:?)
>> [  341.733374][ T5846] RIP: 0033:0x7f9da419902d
>> [ 341.737663][ T5846] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d b6 55 0a 00 e8 99 fe 01 00 66 0f 1f 84 00 00 00 00 00 80 3d b1 25 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
>> All code
>> ========
>>     0:	31 c0			xor    %eax,%eax
>>     2:	e9 c6 fe ff ff		jmpq   0xfffffffffffffecd
>>     7:	50			push   %rax
>>     8:	48 8d 3d b6 55 0a 00	lea    0xa55b6(%rip),%rdi        # 0xa55c5
>>     f:	e8 99 fe 01 00		callq  0x1fead
>>    14:	66 0f 1f 84 00 00 00	nopw   0x0(%rax,%rax,1)
>>    1b:	00 00
>>    1d:	80 3d b1 25 0e 00 00	cmpb   $0x0,0xe25b1(%rip)        # 0xe25d5
>>    24:	74 17			je     0x3d
>>    26:	31 c0			xor    %eax,%eax
>>    28:	0f 05			syscall
>>    2a:*	48 3d 00 f0 ff ff	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>>    30:	77 5b			ja     0x8d
>>    32:	c3			retq
>>    33:	66 2e 0f 1f 84 00 00	nopw   %cs:0x0(%rax,%rax,1)
>>    3a:	00 00 00
>>    3d:	48			rex.W
>>    3e:	83			.byte 0x83
>>    3f:	ec			in     (%dx),%al
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0:	48 3d 00 f0 ff ff	cmp    $0xfffffffffffff000,%rax
>>     6:	77 5b			ja     0x63
>>     8:	c3			retq
>>     9:	66 2e 0f 1f 84 00 00	nopw   %cs:0x0(%rax,%rax,1)
>>    10:	00 00 00
>>    13:	48			rex.W
>>    14:	83			.byte 0x83
>>    15:	ec			in     (%dx),%al
>> [  341.757163][ T5846] RSP: 002b:00007fff7b2e0818 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> [  341.765446][ T5846] RAX: ffffffffffffffda RBX: 0000000000018000 RCX: 00007f9da419902d
>> [  341.773296][ T5846] RDX: 0000000000018000 RSI: 00005612d0f5e000 RDI: 0000000000000005
>> [  341.781148][ T5846] RBP: 00005612d0f5e000 R08: 00000000000395e1 R09: 0000000000000000
>> [  341.789000][ T5846] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff7b2e08e0
>> [  341.796852][ T5846] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000005
>> [  341.804710][ T5846]  </TASK>
>> [  341.807601][ T5846]
>> [  341.809798][ T5846] The buggy address belongs to the physical page:
>> [  341.816082][ T5846] page:00000000345a71f1 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12a630
>> [  341.826198][ T5846] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>> [  341.833443][ T5846] raw: 0017ffffc0000000 ffffea0005b73208 ffffea0004a98e08 0000000000000000
>> [  341.841901][ T5846] raw: 0000000000000000 0000000000070000 00000000ffffffff 0000000000000000
>> [  341.850361][ T5846] page dumped because: kasan: bad access detected
>> [  341.856650][ T5846]
>> [  341.858850][ T5846] Memory state around the buggy address:
>> [  341.864354][ T5846]  ffff88812a62ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  341.872284][ T5846]  ffff88812a62ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  341.880221][ T5846] >ffff88812a630000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [  341.888159][ T5846]                    ^
>> [  341.892100][ T5846]  ffff88812a630080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [  341.900036][ T5846]  ffff88812a630100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> [  341.907978][ T5846] ==================================================================
>> [  341.915979][ T5846] Disabling lock debugging due to kernel taint
>>
>>
>> If you fix the issue, kindly add following tag
>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>> | Link: https://lore.kernel.org/oe-lkp/202211162205.6cb42ae6-yujie.liu@intel.com
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
> 
> Thanks for your test!
> 
> Looking into above call trace, it seems something wrong happened when read
> 'string' type data of some kprobe events.
> 
> But I currently feel like it hard to relate this issue to my modification
> since I change event type allocation in the patch and it can only affect
> event registration.
> 
> I cannot run the lkp-tests in my environment, sorry for that. I'd like to
> know if this problem would always happen after applying my patch? Could you
> please provide exact testcase or more detailed logs? Thanks!

This problem is not 100% reproducible in our test. We did 29 rounds of test,
19 of which can reproduce it, while the base commit is always clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
   lkp-skl-d06/kernel-selftests/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/ftrace

commit:
   0ce0638edf5ec ("ftrace: Properly unset FTRACE_HASH_FL_MOD")
   bb10be779a5fc ("tracing: Optimize event type allocation with IDA")

    0ce0638edf5ec                 bb10be779a5fc
---------------- --------------- ------------
        fail:runs  %reproduction    fail:runs
            |             |             |
            :20          95%          19:29    dmesg.BUG:KASAN:use-after-free_in_string


Running lkp-tests seems to be a bit complex, sorry about that. We reconfirmed
that the problem can be reproduced by simply run a ftrace selftest case below.
Could you please have a try?

$ cd linux/tools/testing/selftests/ftrace
$ ./ftracetest test.d/kprobe/kprobe_args_string.tc
$ dmesg
...
[  339.517182][ T5803] ==================================================================
[  339.525127][ T5803] BUG: KASAN: use-after-free in string+0x29c/0x320
[  339.531492][ T5803] Read of size 1 at addr ffff888108d7c578 by task grep/5803
[  339.538645][ T5803]
[  339.540845][ T5803] CPU: 3 PID: 5803 Comm: grep Not tainted 6.0.0-rc7-00021-gbb10be779a5f #1
[  339.549295][ T5803] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[  339.558877][ T5803] Call Trace:
[  339.562030][ T5803]  <TASK>
[  339.564835][ T5803]  dump_stack_lvl+0x45/0x59
[  339.569210][ T5803]  print_address_description+0x1f/0x1e0
[  339.575663][ T5803]  print_report.cold+0x55/0x232
[  339.580380][ T5803]  ? do_raw_spin_lock+0x12e/0x270
[  339.585275][ T5803]  ? string+0x29c/0x320
[  339.589299][ T5803]  kasan_report+0xb1/0x190
[  339.593582][ T5803]  ? kallsyms_lookup_buildid+0xb0/0x2c0
[  339.598998][ T5803]  ? string+0x29c/0x320
[  339.603026][ T5803]  string+0x29c/0x320
...


The full dmesg and test log are attached in the original report, please check
them for more details.

https://lore.kernel.org/oe-lkp/202211162205.6cb42ae6-yujie.liu@intel.com

--
Best Regards,
Yujie
