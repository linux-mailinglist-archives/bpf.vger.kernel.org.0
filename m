Return-Path: <bpf+bounces-12605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CE7CE6EE
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D382281D2A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4F41E3B;
	Wed, 18 Oct 2023 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwmQtJKw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E347348;
	Wed, 18 Oct 2023 18:39:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC9F7;
	Wed, 18 Oct 2023 11:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwT/cYsslehnFX+AXR4e4VZaklxi79wZZcNYzpANLXTeOKGd1VoiZLFAl9bcuFYbLYi5MvOO473oquCwkuv/o/wP84kjiMkmFEpW9H09JvAhv0uEphscmYqDOvIr1gbM0RxpOTW2hh9yA3Vo3yH1TrNdF5MRTJ8cVDoxvMytk25xNrepJx67qaEYVHY339HDzwVwckZcZ+WG9PehIpqLeqfrZeq6qP75VvHzWBLD8Uwe5WqX7NrVk2ptpxH/nb51Fsauj2Bt2gD95VfZqdzWHAoU1aN4+b9YyBAJXeOZuF2df8/LMdMzk6XO185zt2PFyIB1CB+OY3P2pd3gKApGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU6nctpme4VBYwdNpPP+ppDPSlae2DuoX26bmDkya8g=;
 b=SizUYLF//lEiKjwcxHumnVgDJP8puUlJUcUKBy0zyVzz329Bm/6ZNVnr7ziZwrzsQ+NhfXPUuk2/cEDwUuqdfQ4mllsa+rUJnccDxK1PcjMIqVIJpe1wYizQ9OoQg3XUA/V3fCQpDGghrxsGEWmybpqrGM+NSN7f0vJYLWluPJnUrkU+Ng3a6+y8jXiN9zB5vNo8wye60AMyq3LwG424vE3e62f9d0/5mJRFhqnLCeEoh8q1M/+kLnVY9hUwV2JUnp0ngC6Lz7NkkAh6sDip3aUuWm8MV7huwEZXGVo6Q0+zrbmz9rOfBngyulIXrBMPWK2+MlPfQxv1qUWwqBhklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU6nctpme4VBYwdNpPP+ppDPSlae2DuoX26bmDkya8g=;
 b=OwmQtJKwddk3eC52CndBT8qI2qLaQE4F/Fd1E7XhhTFRTt6vef3awybIvbSk3AKfYK352qLf7EuHDoDb2YBp/9EDD/p6WRI/wjzvbchffUgy6LzaZYC9/67xi5xAlTTC3qd8hFbTfElUBroVxX9bkMIchCZyHRXfAvBR4xehpYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 18 Oct
 2023 18:39:53 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:39:52 +0000
Message-ID: <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
Date: Wed, 18 Oct 2023 14:39:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Li Hua
 <hucool.lihua@huawei.com>, Alexander Potapenko <glider@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Rae Moar <rmoar@google.com>,
 rust-for-linux@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
 <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::16) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dc2bcf-2bab-4f3f-431d-08dbd0099de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nh1d9aWG59PxpJzKHLDyKN2xy3VVPnqbKEmk0YAi/e8H2/RxIK7dMdRuLsZFZUJpBZ+ebZa8qsFAXmYHClCEL9GbJRDkAv631tpqw0MXUV50slTEdnM8Uypc6Kr/pg2ulcKcRlF+xmhOkBRvZ6o6558gNu65dshbUY4f4vC4ek5akrM3Z9/R/yX8SGPgTJ0fT6n91G1tJLUQS1ZNjEw2epWSYHXFP2ml4xFupnG7DM3H8QA0Wpbqm2RMvrLHycXBwgfS6xm2ThP4KduiNvPcmC7H7M4nZu+MtysYBzyoD8KJK1TKdomzgc0mlSR9gkanI7XojZFJPzE+6IV9k0AF4oXiLWMvqczwGamxpr5FQAD9cQDwJQzs/fTY31FfXZxsA+mgXQqK1RyXbvU8KS3v8t8R5M1RYRFLBty7xYfMTYCgIaymINR6KfS1LTEo5DXKhMBhGslefu5IytgB7Bh19UifR8gCifw7QOlLx7IwsHGON0oiBKM4WHorPAuYpHLgHvlIVL3UyYLng0HOjuWZQKyXsMf6zCRzuYHkghN6CBc+nOk2wL2EvYUtLX+foHs/NNFcRPqD7rMXFW/tQznQZvF2uHFcwb3MAU7Ima/nnUOXaLq1Yj2+B17540L1V2jAg1l02BRBtJ6OywU7STb28Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(6916009)(2616005)(26005)(66556008)(66476007)(54906003)(66946007)(4326008)(8936002)(8676002)(316002)(53546011)(6512007)(36756003)(2906002)(478600001)(31696002)(6666004)(7416002)(6506007)(86362001)(83380400001)(5660300002)(38100700002)(31686004)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhBcUlKeHF2WjRIcHR4Ym5MazVyUWVOVVRScHZGUXFLVjZKTGRFVjI2L3U3?=
 =?utf-8?B?Ty85SGtpSlloQzhyeDRXRWxnZC8rWWxSd1FaRk15TkYwOUdvbjR0OU1ZOHJs?=
 =?utf-8?B?U2I0c2MyVFdYczlUOWthblp5UjVvNE0xMkZyNVdsWFE0QUdvSy9UUXVTdkZT?=
 =?utf-8?B?L2trSDFKUktpLzlEcnRhaFZFdWVuRmFPNnBKYWYzY2MxN1ptWGtUQ1J2NEIr?=
 =?utf-8?B?Q1hjN3pXdmNNSmw0WE5mQ081Zmk4ZzU1RnJ3NktZWlVSNTZhQXZxdzR5OFFa?=
 =?utf-8?B?VTFYQUFtaGFLYlZrd2t5ZHBCV2RXWGlRTlYzbkxZa21pdlEzQ2xJQzdxcVp1?=
 =?utf-8?B?NWgrcXBNWTdFTUdnU0dRbmQ5TmY4NHFma2pOdmFEOGd3VFdtSkN3cng5bVh6?=
 =?utf-8?B?cjRyVVdua0pLdHRicUd4LzByM20wQkJTT2FCaUw1TzNoWmIyUGd5Ti9vL0l5?=
 =?utf-8?B?VVV6cTFVSzY2NklCa055eHNucDcyU2UyODY3K0k1b0FoUkdYelUvQlF0Y1hI?=
 =?utf-8?B?RlJhYXorN3VsQVVEMHM3dzh4OGNyWFVhZ3UzdU9BZENzdDZyQmgzMnhXd2Za?=
 =?utf-8?B?cHNQKzBQZVJVWit2bEE2ZjZVa1duK3lDUVY2ZEVQbWRWRWdQRWJCby9LVDNx?=
 =?utf-8?B?UXI0WENIMVZtNVZNTTBkR3RDSUQ0ajFkZVh2OWRtYkpFRVZONGFiRDVSVCts?=
 =?utf-8?B?Y21BcEh4SXhiQVE2SytUaC9VSUlDalNPNmZLUzVkY3o0b2h5b0ZxTzVBZWJB?=
 =?utf-8?B?SEJjU2Vtc0VLSnhIMlhUaVR1d0p1cU5nd1VzTzBTNkdRWmQ0dlBETmZJdldx?=
 =?utf-8?B?VVU0OUxodVFTendxSEM4MG1lcWM1ckpaUmJHb1N0SGh6L245MjczWjBKeFpv?=
 =?utf-8?B?UDlERlp0RHhvaERodlQ3S01TRFhONzR4WmUxZXlRd3o2a1pxc05wZW9pOERk?=
 =?utf-8?B?OUdEazhjd0RqcTY5R2tJWnduc0dhZ3d1MkdzanczVEhlOFVYZmJRZzhHT2Vm?=
 =?utf-8?B?dnZjSy8rc3dDb1FnYjcvYUpOZGtxaHltZHo3SmprYmtzTElDNlEwS2FWcDRC?=
 =?utf-8?B?c2F3TFc5K1BQeUFLMVY3QVhrRDBndWRWSEtaTTlub0xBYm5XU242bDh0Tkg1?=
 =?utf-8?B?UDdUdUtpZkJpYmF6UFNrM2dUM20yS0NkSHRnaDJ5anRpMEE0b0h2enova0tu?=
 =?utf-8?B?M2JwN1UwOWwrdnoyMHVLL28reDVEVTJGSk10SzVlME9oT3pvQU9qeGR1cDhF?=
 =?utf-8?B?NjZKZTB6NytyWkxsdlp1VUZPNFZCMUFtWEtwbXZKUENSci95eGNPZ3hwM2RU?=
 =?utf-8?B?N1d2OVJpQ3MzaHVReHg1SW0xUGZneGdGYmZQNkxCMUFUNXFGa0lxeVdSV0pH?=
 =?utf-8?B?dUJtOWtWLzlyN1Buak1aeHFRWGVHMUNkMW5WNUlPZ1hvckFqZ0NnK1UvemtS?=
 =?utf-8?B?OFY5dUNLTXNBTWc1cy83L1BoZXhvVlIyTnR6aEx5RGpPQ3RodFZxRlFpNnV3?=
 =?utf-8?B?aVo1eGgzY2FpOVlNNVYzcUFub2lCdERGczUyZG8vNGZON1RkMGZUMjBjQUZa?=
 =?utf-8?B?Rkl6R0dZbnlYYlQxM1NVQnl5TUN4N1RrVXRvQjg5SVE3SzVFR0dST1ArWjE4?=
 =?utf-8?B?NXU1VmFOaURPZlBadENvOG5xZ242bCtHS1lVL3BzOWhqVGVxbFRUcmdlN0o1?=
 =?utf-8?B?UllJY3JSd1NkTDB0bGExaHJ3dmN0R0g2QmdZaERFUUl0YitZQ1kzMGVxaFVy?=
 =?utf-8?B?Uy9TZGdaZWVqR2tqVVkxcUczV0dOWW53UTl6bkFaVDExcXZER1hQMDFzNHJC?=
 =?utf-8?B?S0xhazZEdjBTM2FnUjdDV2hRajV4S0RzQll3WFdwa05HZUp3UFNvUGNhMkpV?=
 =?utf-8?B?QlZUbGtEbHd4a3JwVnBFS1E1Mll5R3NzanllM1RPaWZLS0ZCUXdKUm84K1NW?=
 =?utf-8?B?Z2JTQTJITFlzUUJlbmJna1hwdXVxb1YwUW5OczZkVDJibDJKbzBNRGk4UjVV?=
 =?utf-8?B?Q2VGd3duc0h1TmRHRkdFN1cxSUQ5a29CYTI2YVBnekFqaG9lYWhsU0hkTW5y?=
 =?utf-8?B?TEZ4eG8vSmpYMmtwZjREalNTd2dvQ0hNOUhGVGJaQ1hLZUFiWlIrRjA3eDJu?=
 =?utf-8?Q?f5UPbdn/fMl31rSoUa9jVNofW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dc2bcf-2bab-4f3f-431d-08dbd0099de7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:39:52.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZjSgYglR0s5ZTXu8GLHDWLG67Pmzgq+hnEDwAi+9MLjp8O2mrhfbjOWE/zaNxL8DbZ9VOAlybzlefA/4pFWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

On 10/18/23 14:29, Geert Uytterhoeven wrote:
> Hi Hamza,
> 
> On Wed, Oct 18, 2023 at 8:24 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>> With every release of LLVM, both of these sanitizers eat up more and
>> more of the stack. So, set FRAME_WARN to 0 if either of them is enabled
>> for a given build.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
> Thanks for your patch!
> 
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -429,11 +429,10 @@ endif # DEBUG_INFO
>>   config FRAME_WARN
>>          int "Warn for stack frames larger than"
>>          range 0 8192
>> -       default 0 if KMSAN
>> +       default 0 if KASAN || KCSAN || KMSAN
> 
> Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootable?

They are all intended to be used for runtime debugging, so I'd imagine so.

> Stack overflows do cause crashes.

It is worth noting that FRAME_WARN has been disabled for KMSAN for quite
a while and as far as I can tell no one has complained.

> 
>>          default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>          default 2048 if PARISC
>>          default 1536 if (!64BIT && XTENSA)
>> -       default 1280 if KASAN && !64BIT
>>          default 1024 if !64BIT
>>          default 2048 if 64BIT
>>          help
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
-- 
Hamza


