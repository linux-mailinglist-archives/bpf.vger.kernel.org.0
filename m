Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E847461F05
	for <lists+bpf@lfdr.de>; Mon, 29 Nov 2021 19:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379284AbhK2Sml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 13:42:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:10278 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379920AbhK2Ski (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 13:40:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236275187"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="236275187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 10:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458541881"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 10:28:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:28:29 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:28:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 10:28:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 10:28:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIr/XLeqFWqMUpI4H4QrZZqxFv4EdAhutXoKWG41MZC1Y8ItijSiwqQTR/3wquzfQXPu+G05vKphfyoaSUAYEVLX7Bfb4XlVmAjZKKVW4hT2opeCszFur6PTBS+n5UxDQ+ILP6KiFJQONNZJkRos9Y3UXIQtRmwrY17S6x994XQJRF3JtbE97Q7Z6+9mYRHE1CHBjPB+g8ocWvbFxK6F7WndDJGHFOv2Xbt39VKKBqvvEyo9xiGr7dP70eby+zo4tt8BF1F6wYBDk5h6nMul+7zkyYZI3beQOAI5c6i1DD1oCjoDwLFjww+5UsPmcQLRC7xdqrN8jaAPY2ihSgL3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlcA88cQXReOMPu4XVoSreRMmzgEL5fFrtxy6odtmpE=;
 b=CnEIDVtj6leGDc2/MJA3sDqe3vCvBCN+UPQSYE6wxIn0pPjytafcRL8Ldj5KTubokhdC1/ts9hO0dhJJpQOPkH7CDBPMvVMLCgBz2DOD5SNMMYkbK8W4JAjU9M3KHrU6KV4km7tTREFcGJPmJiY6UzW/l7jVUqozHl4lvphmeB8P1Ldwb9yt9XwvpLJ7nFuIW91yRMVA2n7yZwihJ1qZA37dGa1FkYziSpxrCRuO4pvMll+taMxupyKINURfodVpfolf+csg03a49gZD4AjW2CPs9kzmOoyFRQJ0wf9H+rCnj+PvAmx+2jWRCx+Qy1gq8ETefSsTqBToZ/6ZFTOKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlcA88cQXReOMPu4XVoSreRMmzgEL5fFrtxy6odtmpE=;
 b=f29Q/JUSKYQ+zwET8HurUUr1gjyYABe+2U+iQkHxTjfHtYYXqmJM6u2ELNbqfg2YfERusstrUODRQNtv53q+kX7MkkqphlxZADCFkEPeNtVyTkv2qExtGCGLozecf33nss6FWY1ZxAI2umcnx3uip85JdVY63qqq0+7LmGKXmTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2258.namprd11.prod.outlook.com (2603:10b6:405:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 18:28:24 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Mon, 29 Nov 2021
 18:28:24 +0000
Message-ID: <788c3607-55f3-3d94-75a2-46456899bd12@intel.com>
Date:   Mon, 29 Nov 2021 10:28:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH bpf] cacheinfo: move get_cpu_cacheinfo_id() back out
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <song@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, bpf <bpf@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20211120165528.197359-1-kuba@kernel.org>
 <CAPhsuW4g1PhdczQh=iqDR_CzB=6FoM4QPF9DmknEP0hZ_Ac3TA@mail.gmail.com>
 <d4c52f8f-7efb-3d2a-8f2e-c983cd0c8cce@arm.com>
 <CAPhsuW6CMBymKpOMdL-bianESBLfbKa5JwmFypKL3dx4k0rmSQ@mail.gmail.com>
 <CAADnVQ+2kPhfG_DOrYpibDfs-COC5AHyKEDbqPNWnPhLhrV=uA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAADnVQ+2kPhfG_DOrYpibDfs-COC5AHyKEDbqPNWnPhLhrV=uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 18:28:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e989413b-1308-4a52-1262-08d9b3660581
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2258:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2258DFE389B6E74C5ED0EC52F8669@BN6PR1101MB2258.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VD9JSkiKHgwPoNjPq64MQkxdSKKJeZoB+bco5D4Wl1WsM0hu/1RkaiOgekGqFRPzyw3P+BVV83jsYoLdS+2VQnzl83FcVJN1gZVZmYoPHAaBUEum7LIHdjyEUQRytoXhYqrHApEbzIEwssm6E8Y3Iq1jfhURCWrOVQYRCXSceIJWr3Grpx1TtolxpThU6D7LC++zIOMZmvVMItyTPFiHlv3TRv4W2M2MIUiRL/8sfBD94Iw8UASOkplj1pVWGTjZ/39TEynb8PU1kNGZzVMWV6CcLEOKx1G9NmLg8GLMSRJsDw/RKHSqwFeCQxVw7LPP7U8PV91FVz8Koz53tCMCq3CF+VvtLxOzD6p53OCU/W2xbYI94rAt5Mf9eiW3VlITPHKaFjP1YXHH9rgZlYxQRhkeFAvVb4PVdNqeNCaVywdcbAyUq0lunO8lGQRuoagx3jKU3rPr8AmaLw7KuzLNUyhg2pk2OHECvHe2pG7EALis+6+ynkPs2f63vIOTg/+PHIoJforzsnug8xDScECFhe4Nz3U5De45lcjfNjfSc9IiDXjri0GQE2ftP3KEUH9KrvD6i9gHR6q1cainBEwXsKYj/dzHwgbOcnPf8CylZGk3HuA4lvGxVeCAe4RRDdws+NWfPd/6Os9SyGmZ/uta//ET7fJrhV5b4K6DgmAiiInQcoGwjt7IEnQbPhmiAeJo68YnU0/7x8gVzhxDYOrAeKSQB/mYEHgNlE5fq1guVpEreY4ZHmtoWAR0urCocacgjl+m2EjdWoKu3TMD2J/2qtwQpgWco943MByaqKtZDZM1JqcLJoc9fN1qs2nGYs38CoomrzxAe2OtKMp2qJJyeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(16576012)(44832011)(316002)(38100700002)(508600001)(83380400001)(8936002)(86362001)(66476007)(54906003)(66946007)(36756003)(2906002)(66556008)(110136005)(956004)(966005)(6666004)(31696002)(2616005)(8676002)(7416002)(4326008)(186003)(82960400001)(6486002)(53546011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUYzNHdybU1DdXpHbmpCcHY3UWdoNXpmVFZRaXZ0OUNqZHZDTG9ieFJjUVB5?=
 =?utf-8?B?VjRZazhvaFd1TytyQUFRZ2Q0a3Q2MzBsT2lKOXc4VTA1bm1tNU9NS0xPeWNR?=
 =?utf-8?B?OHEzYVdZWGJRcnJ5R3IySnhaVnVBc3UyVExJdzRRdkVtMjhhT2FmUmFKMC9h?=
 =?utf-8?B?cldLTHQxN053TmtiNnlPRmxGUDdGR0JERXgxK1Rsd3JzNExIdUJjam0xWEkv?=
 =?utf-8?B?S2g2dFRwS0daRXJrTlQ1YVVNMHRHMXZFdVBzTEszVGxWREhDZGZ6VS9iRlg4?=
 =?utf-8?B?L1FIRTkvbEVId0cwOUNrLzBDVlE2WWtqYW9pNUM0dklnYitqOHVJWmRMbzZ5?=
 =?utf-8?B?UzFGTUZoS0JzNVEzVUNGaCtzY1FPTm1qVTl1bEZ2YmZuRG04UEFkbWExUytM?=
 =?utf-8?B?NXY2VGpkbHN3YWt0QUl0b3paS1dBTG1JSS9ucElCbjZtZ2laQUN3cTNqeHJO?=
 =?utf-8?B?M0hUZDhjT1FjNWQvbjVPbHNuNkhhRXdrY1Q0b2ZHbUVidnc1UzBUVDZ0ZC9H?=
 =?utf-8?B?K2RwblRrMTNzTzBkREh1TGNGU0k1aWZIK040OFA4NFUzSDllUFhESUtwLzc3?=
 =?utf-8?B?K0liY0U0MzgxRU9kOGFZWU5ZZXlWb3FvQ0w2djM2aWV1alJhQjFlYlNMSHNO?=
 =?utf-8?B?RCtlTzA5eEVtZEdKWkl1SG8rM01VQ1prYUlzb1ozYUhLZ1R2dVBKQ3FISGRa?=
 =?utf-8?B?dEJ0dGg5SUk5NlN4QkJWUWlDdmpRSlBuVFVaSTZhR01CTXg4bkZLZVhuTGVK?=
 =?utf-8?B?MThxYW1OdWJva3g3aHUvemFUVjl0elNBa0kzeUd5c2dTekR2clJTazNtTEp1?=
 =?utf-8?B?TTBjZWloRmRINy9idXljeTdQek5XQ2c3dnFZVEJLY3N3QkpNbDZRZjRmb2ta?=
 =?utf-8?B?Yi9jM21MYjRtalFYclIwMk5LWDhnaU41MTFyNDd0ZlpmMjZPZFJ5RTNNN0Rx?=
 =?utf-8?B?TE5CQkJjUFQzMjRXVXcrSDFlSlJYZkswZWFadHRSeFJKbGg5WXliTnhYWmE0?=
 =?utf-8?B?aW9ZNzk1Mk5JL2RLL1hmY2h1REQ5TGlSMnZqUGN3UXpKdkdqVlpWY3Q4eFF3?=
 =?utf-8?B?QVVBOTc5U3lneU4zN2xVa2x6SG9lNUtGZFFEc25CRVo5UHZuM280RGZXMERv?=
 =?utf-8?B?Q0VtbGdnU1NQMWR1NHZadmZObkZsQ05TaFo3UXZoQzdlN3hLS0pBMWlkNUNS?=
 =?utf-8?B?UHJKMlFHMXYxQkhWa3BMUnZtbkJ6cWlxMDFvMHpGUW9HZk5EUk9TYTI3M2ha?=
 =?utf-8?B?bkN0d3NPbThOM1B4WVlaSks3eWpmWVluNjRGVmVFNmhybGtWMU50SWJ0bkxH?=
 =?utf-8?B?N0FvU1JONjNnY2JSbDZQUXhtdlZJSkE4emFkYVlRNkFoY3RwVmFESzhFeHpX?=
 =?utf-8?B?NGlWQi85bzZCa3JTVnhZS3VTTGQ5WWdPd0NJa3FzRmdlYnNPQVRJK0VMZGkv?=
 =?utf-8?B?YWtuUlcydkFYb1c4TEY3cjVLZWs3MkYreFpWc0dLaC9INjREbHY2Rzd5N3dY?=
 =?utf-8?B?M1NVb2lNVkhQZWhTSlQzTk5EWFBZWWdkMGhLMFpYUVJzWUtQeG4xbktSckEz?=
 =?utf-8?B?ZFMzeDBYUjhXakZXQUIyRms5cFowSzg0eTQreWhtREQ2S0RLL0MrZmVKcEJ5?=
 =?utf-8?B?dTlQcmtyLzFkV3NxaXQzVUl1ZlhCU1ZYRGwzZDFxcGhWTE5MSEVBWmQxU2tD?=
 =?utf-8?B?NGNqZEEwanQrNWM1T0QwM2F6UzJ2UFp4WHdYbTNMb1htV0RjZ1ZoK3FRS1BT?=
 =?utf-8?B?U0tqNUhwS25Wb2tOT2Vya2pTdWVBNDI0VTRRVTFRSktiNG1yR0FDODJhaEtx?=
 =?utf-8?B?cXhSSExXbTV2Z2tqOEFwVHZzY3BabEFUZkpEbXpxUWpUaWw3SmY2ak9FVm5m?=
 =?utf-8?B?eXpscnA2a2t3ZTRPTWFNVFNwRExkZ2pkNGJ3WXA3b3NrQzBwNmRQQVZ0Qlp2?=
 =?utf-8?B?QjdFdXlxQktxMTkyKzAyS1JlcHNOVURHdzVrYmZ4NFprWU1JNzJ6ZHhKTjEr?=
 =?utf-8?B?bEUrZnNwVEVvZnBjbHVTeVRFNnZsaHBhd0xIQlkvREdIMXJqSHViUTZxcHB0?=
 =?utf-8?B?WnY1Vm5LYmpDTEJ2UWNuYkxPTDE0VllzelM0VTk0YitxK3ZIQ3gxWHVvakZ0?=
 =?utf-8?B?UDErbFgycExzQW9OcldNUzhlb1cxSVhEMzhvRmVCNmhIUDlMdVVVRXZENUo0?=
 =?utf-8?B?M2RtMUlqVTFuV1ZXbFBrYmNsT2hYTTNLZytkWkpZdjJ0WDJRUkI2SUdDNGVX?=
 =?utf-8?Q?AN2y4CJvbH1lRs6x9vqCjdTrlSM/maOt9EuOAdv8r0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e989413b-1308-4a52-1262-08d9b3660581
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:28:23.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOaTKw/AfS9AK5PhyA1y+8d/ZQXTTOy5rRRzXF5DreA80UwxJynBtEaKdaXO4tG/XTJj4pGCnyhHx507Dd9OpNZVJo2ty6DK4cw/BFPa1ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2258
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Everybody,

On 11/25/2021 7:59 AM, Alexei Starovoitov wrote:
> On Wed, Nov 24, 2021 at 1:14 AM Song Liu <song@kernel.org> wrote:
>>
>> On Tue, Nov 23, 2021 at 8:49 AM James Morse <james.morse@arm.com> wrote:
>>>
>>> Hello,
>>>
>>> On 23/11/2021 17:45, Song Liu wrote:
>>>> On Sat, Nov 20, 2021 at 6:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>
>>>>> This commit more or less reverts commit 709c4362725a ("cacheinfo:
>>>>> Move resctrl's get_cache_id() to the cacheinfo header file").
>>>>>
>>>>> There are no users of the static inline helper outside of resctrl/core.c
>>>>> and cpu.h is a pretty heavy include, it pulls in device.h etc. This
>>>>> trips up architectures like riscv which want to access cacheinfo
>>>>> in low level headers like elf.h.
>>>>>
>>>>> Link: https://lore.kernel.org/all/20211120035253.72074-1-kuba@kernel.org/
>>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>> ---
>>>
>>>>> x86 resctrl folks, does this look okay?
>>>>>
>>>>> I'd like to do some bpf header cleanups in -next which this is blocking.
>>>>> How would you like to handle that? This change looks entirely harmless,
>>>>> can I get an ack and take this via bpf/netdev to Linus ASAP so it
>>>>> propagates to all trees?
>>>>
>>>> Does this patch target the bpf tree, or the bpf-next tree? If we want to unblock
>>>> bpf header cleanup in -next, we can simply include it in a set for bpf-next.
>>>
>>>
>>> Some background: this is part of the mpam tree that wires up resctrl for arm64. This patch
>>> floated to the top and got merged with some cleanup as it was independent of the wider
>>> resctrl changes.
>>>
>>> If the cpu.h include is the problem, I can't see what that is needed for. It almost
>>> certainly came in with a lockdep annotation that got replaced by a comment instead.
>>
>> Thanks for the information.
>>
>> I can ack the patch for the patch itself.
>>
>> Acked-by: Song Liu <songliubraving@fb.com>
>>
>> But I am not sure whether we should ship it via bpf tree. It seems to
>> me that the
>> only reason we ship it via bpf tree is to get it to upstream ASAP?
>>
>> Alexei/Daniel/Andrii, what do you think about this?
> 
> I don't completely understand why it cannot go via -next along
> with other patches, but if Jakub needs it asap here is my
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> and probably the fastest is for Jakub to take it via net tree directly.

These responses seems to ignore the information provided by James.

How about just the hunk below. It is not needed by the other parts 
removed and addresses the issue described in the changelog.

--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,7 +3,6 @@
   #define _LINUX_CACHEINFO_H

   #include <linux/bitops.h>
-#include <linux/cpu.h>
   #include <linux/cpumask.h>
   #include <linux/smp.h>

Reinette

