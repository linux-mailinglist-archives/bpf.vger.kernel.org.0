Return-Path: <bpf+bounces-12739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18227D0314
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10F91F23F36
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB23DFF1;
	Thu, 19 Oct 2023 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c6/FDmwx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E03D3B5;
	Thu, 19 Oct 2023 20:17:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08274124;
	Thu, 19 Oct 2023 13:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYTkTYgn1C7k+gulS0SXPggS4Ri1fY0uKt1HdZbDAhdkNFh6+zFDlsBenvE2hNa7MwJnXIzYvQKwO4orXCfK+6sYSUK3uvMjAXbLR+6OqZ0/H5W895UinH3mN5tNDq9gQiBjAGKj0KwVs4cX48BYLQG7O2hrZQdxrq3Lg2cU0+dApJK2QkfyPu7q9rYnsySjSONausb3vydRgGzL2o3y8AolGfPBxtVJ9150AebDvoz5Le6TeUeTwe9ZT8mSZDmkPN59gCu3qxxBGX69/bSjIOFV7Rs/SvRQ4r+NXZQbi+hSfu2gxF8ngERlJU4YC2QXRt6YA3/8eC4BrpLtqnoejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+1qGJ1b1W/hrmbe9VlayPZ0BGk79yLrvvAYCz9Z+Ic=;
 b=EB51bvc8luL0XcOTcBIK8LmOw+FAIrkF/V3mvKKd1zGxi+mUBnXKLb9VZ8CvKYAQdnVygRPtqQWRcBGVwC6JHX9t2aPPQxS6hC2t6a417bSnGwH+cMk4S1pMqkU25s6REqGIkfJo/nuC40qQNUhP7xYQeDNGSAw6SBE7qIGkRBkz8/HYvu1xcIm18H+jrogLi0EVhkNFp1F5J4JrYZpnmfA5gQTzIH9x01bW9z6zYK1cL1Nv1MlCmq8osOYzuDQUj8KVPhrF7OGxA52X+JlDpDAHJEAwK2m5cOzLPXzQ/Cskydb2daV4LFMtW5l1fE+nk2IrIOvNjNnNPzwQRZmeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+1qGJ1b1W/hrmbe9VlayPZ0BGk79yLrvvAYCz9Z+Ic=;
 b=c6/FDmwx4W1xMVmG+lxU3pOHFRWdezlf3Eis1sYqACwuJ9rVI7JKSkHEYeJ8V/UIVLSONfKPeXUzOsGmTfp3TxIDvWeehgKfhpADFvX7JshfixIskCEeF/j3MQ/DSxYrxGL5AoKFoois7f9QyHJZqRWdW9UlSil6QWMCFtNWelw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Thu, 19 Oct 2023 20:17:31 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 20:17:31 +0000
Message-ID: <a9237e7a-e08c-4904-b84a-f6198333a78c@amd.com>
Date: Thu, 19 Oct 2023 16:17:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Potapenko <glider@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Tom Rix <trix@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Li Hua
 <hucool.lihua@huawei.com>, Rae Moar <rmoar@google.com>,
 rust-for-linux@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
 <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
 <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
 <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
 <22580470-7def-4723-b836-1688db6da038@app.fastmail.com>
 <20231019155600.GB60597@dev-arch.thelio-3990X>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231019155600.GB60597@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1758f286-9ebe-459b-f9a4-08dbd0e06c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1YUWApU2IIWDF6DjVLrfsugTaHu+NQ5NGOoBZfg3WfZFNydhnrpdQei+AxxkLZtUtOyWgi7y4fLf9khvcw/yW/21NAEIRLQh+rB+HAfW11/vccRctgoUFQVOkO0le+M/oVcEXbQIsTP0U4xvJbgW6jXJlqf+pH/WiXq5Jz+rn++eNdz1nInESobUlhW1alN703tK1CzxvLirWVZ42ejJbSoA+G4EfI35RR30DvihnKz4lZsVrRJ4t+oLxbCDfOj4RoLFrm/lhWSDq38pSlP/NoMFUzOqrqunERnBWXeHkmfXjVmgutv7wePUF2lOxEsJ+kRlCS74fj/aP01m/sKzN05DVSTvPnAbOhvySki4z8UY0Cybcy6YCTJi7ftJenNj7zqO1K6CX+GRIeIyBkUV62AOAlJIa6BhDIktnadb6G5f1ZTyQeHwaz5QOJhSovnLdXhiej45soSiqESh1ieYcXld0hK4x59QoLnDSOYiOCJuJv22B4LhdUomX1GlFtD4dZfZlHOXcJbKrXtwJbSEBnIceFDGS+m+4FnlAzO7Orf3zAi9y3rGWgHZ3sRRT+wtiOoMAri00PDqFwIrDrTBHS6BnYKhkvqGcyMRJebW/hN2q7ECQQ7e8CgpS4OykJ+i6RnKXOImnQhzdYMTkzQ/CB5p6u4RFJkx37FrhReYeHflG+iOnAygwu874+Fq6YLQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(31686004)(38100700002)(83380400001)(54906003)(5660300002)(66946007)(8676002)(4326008)(7416002)(8936002)(86362001)(2906002)(110136005)(66476007)(44832011)(966005)(6486002)(66556008)(53546011)(6506007)(478600001)(6666004)(316002)(31696002)(66899024)(2616005)(36756003)(6512007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZsRUQrcFYxS1BBcDRWTnFxOWRsU2lhYVE0YmpJdE5GdFNOL0ZKQVJ0bWQ5?=
 =?utf-8?B?OEJiTlRXZGtJZElPUW1uSU1lUWU1RHZaS1FVV1k3MXRqb0FBVmZ0M0VJUlJL?=
 =?utf-8?B?ZThhdFhQMWdtRXBKa3h3WWdzYllPTVJqU0NRbTBsWGJrRERvVkpQMk1EVFBz?=
 =?utf-8?B?V2lJMkxVdzY5RllURjNYMzU2aDZSWVFDdGZJaTB1MFlZSGEzMWlPanhJNGhv?=
 =?utf-8?B?SGRKR28rUDUzcUVCbEJXSzZ0Y24vaTdBb2xpVENWaGJBZlBaNUNFNkUzc0k0?=
 =?utf-8?B?aklXRlE5dkpiUFp6c0RJVlJBTE1CRVdwWE90dFU5bjNoM092NkhHL09vK1J4?=
 =?utf-8?B?YjJyWjlNZStIdUtHMlIrOFlMTG9CT05wUTFwS0lic3lMbWR5VFprRlUzQlBH?=
 =?utf-8?B?MHJnQzhYYUNXUzJmckNZb0FBM0RIZytWMTh1RDZKWmhFWkpqVG1YbEdRN0JI?=
 =?utf-8?B?LytFUlpud2FVWFIvYXA3VmlVaFRMc2VTVm4zcFZvaDBvcHhRVW56QWUwamdS?=
 =?utf-8?B?MGF1SXBxZXlPQjRNd2FZVjJOUlYveFZWV2JRdk4rVXRmRlJjZnZBcmpCanY4?=
 =?utf-8?B?MDFqTUR1bndpUVR0NFN5dEJ1djFmd3lDclhRbzBhYkRTZG9nZGtHWTM0Ukwx?=
 =?utf-8?B?YXN2WDZ1dFY3ZzUvUUhubXJFWTE3OTVjQ2RJZ2FMUWZibG8rWHdCRTIxaDVo?=
 =?utf-8?B?OXRseExLZ2pOaGJ3OUdzRmJzZFJFMTFJVkdpUndQUUxQeWNVRTQ4UGluMWpU?=
 =?utf-8?B?NzFLaE1Fb2kvK25DQTJ3WFF3TTBZUm5UN3VTQ08xRXc3aUkxRnVlcnR6SVFD?=
 =?utf-8?B?NFB6NFJvVGhkUFNvekY1U3ZUaC9wajdaK2RwV3FReUhlZWVQcEJ1R3Q1dmw0?=
 =?utf-8?B?SGdoWXBVRzRJcFpNY2xCc2xrRCtUTjZ4OXJ1Z0F5bUwwS1BnTXByRGVsazJH?=
 =?utf-8?B?Q3J6RjlYTWpQZkVnNGJoWGNLeHZpK044ZWhpM0o0TFJLVDJ1S0JNcytTQ011?=
 =?utf-8?B?bEJYMVV6eVU2Q3lXU2tkaElKcHBkZUM3L0N1MWkwMFROUHZDSlFiUCtCQ2Ru?=
 =?utf-8?B?K2ZNNFRSUVRYQUtUTTd0THVtak1ESlJTN3JCTVJmRzNVdHdwYkFCYWZIOUpU?=
 =?utf-8?B?MERyNk9oZVc2ZWxTWEdCQkRGY2o0aFcyMU1Kam14TnI2R294Tm1rSjY1dmNK?=
 =?utf-8?B?WG5qTFdNN1JWYjZXRll4dzRORXQ0N0lTYXkrOERKaTRvU0JFcWNFK256cHBY?=
 =?utf-8?B?V1N5T0FPUkI4NlZVRHZ4TDJ5SHMySmdFbTFWY3ZCZm5kb3NNRmZ6ZTZWQ250?=
 =?utf-8?B?a1dSYUVscDAxR0YwK2dsWHRZOFBOTTdneXdmUWxneHlUcWFMK3R3QjBEZTQv?=
 =?utf-8?B?RFpuRHI2TW4ycDc0blo4Z0lBdmZZUVE4cUZpV0FDTGlNNDM4UE9LRmZ2Q0Vs?=
 =?utf-8?B?ckRUdFNnUndxN0pONGJrMUxpcVEwbTdRS2txQWpQdnZPTEdOckFaMWhTUHBq?=
 =?utf-8?B?UDl0SWZwb3p6NE1IUEtUMFk4a2RXMDlJVmd5VXA5U09WbVcyMTJmeGVuYlEz?=
 =?utf-8?B?blA4SzVOYlpJUS8xVUJEQWR3bzZhc3hPY0R1MWtnaGh0M0NpZDRaOXF3aFFF?=
 =?utf-8?B?UzMrNUFzWEM3SDJ0R0x5S3ZkUTRFNkp6dC82dnZWZGZIQ08rWUlyY0V1MG5z?=
 =?utf-8?B?TWJ3R1JXaWhYdU5tNlhRb050NENscm9oclh2eU5BbmxyRXkvNkVYUWR5Tk9T?=
 =?utf-8?B?R200K2RjdEtCK2lVWE8yMGJYVEhYcWJkempsb0kwZ3NXUEp3UHRpOXdoMmh2?=
 =?utf-8?B?ZWhvV2xlRDhxa2c4RUpjWXNNQ2RGL0U2azdQNDNQZGtzZmhwdTRLaFJWNktX?=
 =?utf-8?B?TWU4dnNPczFsdTE5dDlDa1Q5bTV2VDBEZDNPbG9rRmQvQ2NsWFV3RTZDYW1l?=
 =?utf-8?B?Z0sxcWViRVJISVcwT1hYWnRUaWh1WTlSS0tIWTdMOG1tbW1MNkFJbDg2OElt?=
 =?utf-8?B?cTc4V0xSc2c5Yk9IdEpIKzFFMUdHTXpROFNISHl5am51eC9VQVE4Q0tQUzE5?=
 =?utf-8?B?VGZHaUQra0lySWxiSE84SXROdjZtelJvbHlFdkg0cklWUE80MFIySWtUMWVK?=
 =?utf-8?Q?RNsGZrR/C761Q0i+L6lJjCbLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1758f286-9ebe-459b-f9a4-08dbd0e06c6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:17:31.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ieGRtnbjL0PaAYTLLaRYZtkLrz/fyA6g8zaYKgOIYzyc3MPkojFvvLfOXjSakbcIJ9r/7n6iNVQJJF16dD8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

On 10/19/23 11:56, Nathan Chancellor wrote:
> On Thu, Oct 19, 2023 at 02:53:01PM +0200, Arnd Bergmann wrote:
>> On Thu, Oct 19, 2023, at 12:04, Alexander Potapenko wrote:
>>> So the remaining option would be to just increase the frame size every
>>> time a new function surpasses the limit.
>>
>> That is clearly not an option, though we could try to
>> add Kconfig dependencies that avoid the known bad combinations,
>> such as annotating the AMD GPU driver as
>>
>>        depends on (CC_IS_GCC || CLANG_VERSION >=180000) || !(KASAN || KCSAN)
> 
> This would effectively disable the AMDGPU driver for allmodconfig, which
> is somewhat unfortunate as it is an easy testing target.
> 
> Taking a step back, this is all being done because of a couple of
> warnings in the AMDGPU code. If fixing those in the source is too much
> effort (I did note [1] that GCC is at the current limit for that file
> even with Rodrigo's series applied [2]), couldn't we just take the
> existing workaround that this Makefile has for this file and its high
> stack usage and just extend it slightly for clang?

I personally don't mind fixing these issues in the driver, but the fact
that they the creep back every time a new major version of Clang rolls
out (that has been true for the past couple of years at the very
least), makes it rather annoying to deal with.

> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> index 66431525f2a0..fd49e3526c0d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> @@ -58,7 +58,7 @@ endif
>   endif
>   
>   ifneq ($(CONFIG_FRAME_WARN),0)
> -frame_warn_flag := -Wframe-larger-than=2048
> +frame_warn_flag := -Wframe-larger-than=$(if $(CONFIG_CC_IS_CLANG),3072,2048)
>   endif
>   
>   CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
> 
> That would address the immediate concern of the warning breaking builds
> with CONFIG_WERROR=y while not raising the limit for other files in the
> kernel (just this one file in AMDGPU) and avoiding disabling the whole
> driver. The number could be lower, I think ~2500 bytes is the most usage
> I see with Rodrigo's series applied, so maybe 2800 would be a decent
> limit? Once there is a fix in the compiler, this expression could be
> changed to use clang-min-version or something of that sort.
> 
> [1]: https://lore.kernel.org/20231017172231.GA2348194@dev-arch.thelio-3990X/
> [2]: https://lore.kernel.org/20231016142031.241912-1-Rodrigo.Siqueira@amd.com/
> 
> Cheers,
> Nathan
-- 
Hamza


