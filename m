Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDB136173
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgAITyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 14:54:39 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:55026 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgAITyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 14:54:38 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 14:54:37 EST
X-EEMSG-check-017: 44059245|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="44059245"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 19:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578599242; x=1610135242;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gmC0lVd264gHhXWaSirdq88iKOynkxANSorQkJtiK9M=;
  b=dXIbX2R6WgieEzaQmbrf6S9zmbQ3ZZt633hSrI6ThDEytssAcqj/XA+P
   ifuJdQsv8Wpmd2fouLGDw6P+trpYx+6JnZv09B3KtPZfCnhqwIAiYmF5i
   NoQzgt8Qovl9ykqb4yZZtLPJIevbzFMr1RzxFzqI1/v+XhrHUBdBPDfOS
   WOnCL0Xe5Ha+71ZCT71QUdcstuT0trFFlcjNwBVAhlxL3h2CZjntXh6Ot
   WOne3wkSoaCwHWxtoDQy39MANzlGXHdHMgxYg/zhRZHfSOspE/rvIfsl8
   iDXhLX+mdtvyw3mRSfLblmcmfKvnvOteRKGhT+h/2xesACvApiFL/0dGL
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="31787047"
IronPort-PHdr: =?us-ascii?q?9a23=3AQVcK9xP2A09fC9jUNvUl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0KPnyr8bcNUDSrc9gkEXOFd2Cra4d0KyM7fmrCDZIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQjQq8Uajo9vJrgswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZCcKyJU7xx7fdvyIaJKE7Q7kVOaUJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kAD+MqIgmsy4GuQ3LB?=
 =?us-ascii?q?QBU3KH+eW8yLLj/Ur5TK9MjvIqianWrIrWJcEapq69GwNV04Aj5AijDzq+zd?=
 =?us-ascii?q?gVknYKIEhFdR6alYTlJV7DLO7iAfuim1islS1kx/HCPr3vGJXNKX3Dna/6fb?=
 =?us-ascii?q?lg8E5R0xYzzNBD6JJUDbENOvTzWlTru9DCAR85NBK0z/79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPRqV+I/eMvI++DZI8VozvyN/gl5+TpjX88mF8dYKyp0YEQaHCiEfRsO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzTO7viF2FSz5TfXeyX7kn6zE9Eo2mCJnMRoG3jLyGxi?=
 =?us-ascii?q?e7EYVcZnpaBVCUDXfoa4KEVu8PaC2MPMBhiSALVb+mS48izhyhqA/6y6BgLu?=
 =?us-ascii?q?rR+y0YqJfj2MJy5+3JmhE47SZ0ANiF02GRU2F0mXsFSCMs06Bkv0N8ykyO0b?=
 =?us-ascii?q?NkjPxYD9NT+v1JUgMkOp7G1uB1F8r9VhjdcdeOTVasWs+mDi0pTtIt398OZF?=
 =?us-ascii?q?5wG9GjjhDFwiqrDKYZl7+VC5wu9KLTwXzxKt1jy3bJyqYhlUMqQshROm28gK?=
 =?us-ascii?q?5w6QzTC5TOk0WDmKagbb4c0zLV9Gef0WqOu1lVXxVoUaXLRn0feETWosrj5k?=
 =?us-ascii?q?/YTL+hF64nMg1fxs6GMKdKbcfpjVpeTvf5JNvee36xm3u3BRuQwrOMbYzqe3?=
 =?us-ascii?q?gS3SnEE0gLjRwc/WucNQg/Giego3vSDDlpFV3yfkPs9fdxpWilTk870Q6KdV?=
 =?us-ascii?q?dt17mr9R4Pg/yTVfcT0qgDuCc7pDV+BEy90M7OC9qcuwphe71Rbskm4Fdbzm?=
 =?us-ascii?q?/ZtBJyPoamL698gl4SaQN3v1nh1x9vEIVPjdAqrG82zAp1Ma+XzUlOdzWZ3Z?=
 =?us-ascii?q?/uPr3aMWjy/Bega6HIwF7eys2Z+qAA6fgirVXsoh2pHFI483p7y9lVz2ec5p?=
 =?us-ascii?q?LSAQoOUZLxXVw49wJ8p7HbfCYw/J/b1X12Mamztz/C2s8pBO4/xhanZddfP7?=
 =?us-ascii?q?uOFBXuHM0CG8iuNOsqlkCsbhIEJu9S8LI7P9mhd/qIw6OrM+FgnDWpjWRD/o?=
 =?us-ascii?q?9xyF6D9y15SuTQxZYK3+mY3hebVzf7lFqhqsL3mZxfaDEdGWq/zifkBIpPaa?=
 =?us-ascii?q?FoYYkLDmKuKdWtxtpin57tR2JY9Fm7Clwdws+mZxySYEHn0g1Wz0gYvGarmS?=
 =?us-ascii?q?SizzNqnDEpobGS3CPLw+v4dRoHPnRHS3VljVfpOYK0lcwVXFC0bwg1kxuo/U?=
 =?us-ascii?q?T6yLJdpKR5L2neWkhIfy/xL2FtVqu/qKCObNJI6JMtqS9XSvizYUiGSr7hpB?=
 =?us-ascii?q?sXyybjH2lRxD07czynoZr5nxt9iGKSKHZ8smDVdt13xRfa/NbcX+Je3iIaRC?=
 =?us-ascii?q?lkjjnaHkSzP9mz/dWVjJfDruG+WHinVpBIaibr15mPtDa95WJ0Gx2zhfGzmt?=
 =?us-ascii?q?r/GwggzSD7z8VqVTnPrBvkZ4nr1ri1PPl6cUlpC1/86sl6GoZjnYcqgpEfx2?=
 =?us-ascii?q?QajI2P/XUbiWfzLclb2aXmYXoXWzEL3cDa4BP52EB4Mn2Jx5j5VnKYwstget?=
 =?us-ascii?q?m6Z3ka2iUn78BFEK2U9qBLnTNpolqkqgLcefp9kS0Bxvst7X4VmecJtxE2wy?=
 =?us-ascii?q?qBArASB05YPSntlxSV6tCytqJXZHygcbKozkpxgcihDK2eogFbQHv5eY0tHS?=
 =?us-ascii?q?Fq4cV+K1/M3mb85pv4d9nXaNIZrgeUnAvYj+hJNJIxkeIHhTFgOWL7sn0lz+?=
 =?us-ascii?q?87jQF10pGgpoeHNWRt/KS2AhNDOD36fNkf9S3qjaZbhsyWxZygHo19GjUXW5?=
 =?us-ascii?q?vlVfKpEDIJtfn8OQaBCycwpWucGbraBQWf8ltpr2rTE5C3MHGaPGIZwst4RB?=
 =?us-ascii?q?mSOkNSmwAUUy8+np49FgGqwtbtf1t+5jAU/lT4sAdDyvp0NxnjVWfSvAKoZS?=
 =?us-ascii?q?s0SJeBLBpZ9BpN60DOMcOE6+JzBDxY/puurAGWKWyUeR5IDWcXVUyAHVzjOa?=
 =?us-ascii?q?Ou5dbY+eiCGuW+N+fOYamJqeFGSviH34yv3ZVj/zuXK8qAJGdiAOM+2kpHWn?=
 =?us-ascii?q?B5FdjZly8JSyMJiyLHd9Sbqwuk+i1rssC/9+zmWA315YSRBLtSMtVv9guyga?=
 =?us-ascii?q?eCMe6QmSl4KThf1pMRw3/H1aIQ3EITiyFpcTmhC7MAtTTCTKjIgK9YEwYbaz?=
 =?us-ascii?q?9vNMtP96882AhNNtLcitPxzLF4leQ5C1lbWlz7gMGme9cHI2S8NFzbHkaLM6?=
 =?us-ascii?q?iJJT3Kw8Hve6+zVbpQjOBMvR2qpTmbC1PjPiiElzTxTBCgLO9MgTqUPBxZv4?=
 =?us-ascii?q?G9fRJtBnb5QN36bR27Ncd9jScqzr0smnPKKWkcPCBlc0NQsLKQ6z9YgvR5G2?=
 =?us-ascii?q?Bb63plKu+EmyCH4OnEMZsWt+VkAjhul+Jd5nQ6zL5V4z9eSPNpnyvSq8Zko0?=
 =?us-ascii?q?u6nemX1jpnTB1Opy5RhI2Wu0VtI77U9pdbVnre4B0N6mCQAQwQp9R5Et3vp7?=
 =?us-ascii?q?xQyt/XmaLxLzdN7cnZ/MUGCMjSNc2LKnwhPgT1GDLOCgsETCahNXvDiExFjP?=
 =?us-ascii?q?GS6nqVo4Aiqpf2hZoOTqRWVEQvGfMHDkRpBdkCIJBwXjM+j7GXltIH5X27rE?=
 =?us-ascii?q?qZeMIPnaiPbfOUDvWnfDWBlrhCaBsgyrPiKoESK4i93FZtPB0yvo3PFlGYeN?=
 =?us-ascii?q?dXuCx6Jls2pUJX6nllZms63k/kLAS37ylAO+Szm0sNlgZmYekrvAzp6lMzK0?=
 =?us-ascii?q?uC8DA8i2EtiN7lhnaXaze3I6CuC9IFQxHovlQ8Z8uoCz1+ahe/yAk9bmbJ?=
X-IPAS-Result: =?us-ascii?q?A2B3CgBJghde/wHyM5AZAUscAQEBAQEHAQERAQQEAQGBe?=
 =?us-ascii?q?wKBe4EYVAEgEiqECYkDhmIBAQEBAQEGgRIliW6RSAkBAQEBAQEBAQEtCgEBh?=
 =?us-ascii?q?EACghM4EwIQAQEBBAEBAQEBBQMBAWyFCwgkDII7KQGCegEFIxVBEAsYAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjPwGCViUPjUieHIEyhUmDQ4E3BoEOKAGMMnmBB4ERJwwDg?=
 =?us-ascii?q?l0+gksZAoRzgl4EjU+CO4cVRpdHgkCCRYRzjmkGG4JHjEGLXI5YiFeUJiKBW?=
 =?us-ascii?q?CsIAhgIIQ+DJ1AYDYEUj3GKcSMDMAyRCQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2020 19:47:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009Jkf6t017383;
        Thu, 9 Jan 2020 14:46:41 -0500
Subject: Re: [PATCH bpf-next v1 00/13] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Paul Moore <paul@paul-moore.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <95036040-6b1c-116c-bd6b-684f00174b4f@schaufler-ca.com>
 <CACYkzJ5nYh7eGuru4vQ=2ZWumGPszBRbgqxmhd4WQRXktAUKkQ@mail.gmail.com>
 <201912301112.A1A63A4@keescook>
 <c4e6cdf2-1233-fc82-ca01-ba84d218f5aa@tycho.nsa.gov>
 <alpine.LRH.2.21.2001090551000.27794@namei.org>
 <e59607cc-1a84-cbdd-5117-7efec86b11ff@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100437550.21515@namei.org>
 <e90e03e3-b92f-6e1a-132f-1b648d9d2139@tycho.nsa.gov>
 <alpine.LRH.2.21.2001100558550.31925@namei.org>
 <20200109194302.GA85350@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8e035f4d-5120-de6a-7ac8-a35841a92b8a@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 14:47:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109194302.GA85350@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/20 2:43 PM, KP Singh wrote:
> On 10-Jan 06:07, James Morris wrote:
>> On Thu, 9 Jan 2020, Stephen Smalley wrote:
>>
>>> On 1/9/20 1:11 PM, James Morris wrote:
>>>> On Wed, 8 Jan 2020, Stephen Smalley wrote:
>>>>
>>>>> The cover letter subject line and the Kconfig help text refer to it as a
>>>>> BPF-based "MAC and Audit policy".  It has an enforce config option that
>>>>> enables the bpf programs to deny access, providing access control. IIRC,
>>>>> in
>>>>> the earlier discussion threads, the BPF maintainers suggested that Smack
>>>>> and
>>>>> other LSMs could be entirely re-implemented via it in the future, and that
>>>>> such an implementation would be more optimal.
>>>>
>>>> In this case, the eBPF code is similar to a kernel module, rather than a
>>>> loadable policy file.  It's a loadable mechanism, rather than a policy, in
>>>> my view.
>>>
>>> I thought you frowned on dynamically loadable LSMs for both security and
>>> correctness reasons?
> 
> Based on the feedback from the lists we've updated the design for v2.
> 
> In v2, LSM hook callbacks are allocated dynamically using BPF
> trampolines, appended to a separate security_hook_heads and run
> only after the statically allocated hooks.
> 
> The security_hook_heads for all the other LSMs (SELinux, AppArmor etc)
> still remains __lsm_ro_after_init and cannot be modified. We are still
> working on v2 (not ready for review yet) but the general idea can be
> seen here:
> 
>    https://github.com/sinkap/linux-krsi/blob/patch/v1/trampoline_prototype/security/bpf/lsm.c
> 
>>
>> Evaluating the security impact of this is the next step. My understanding
>> is that eBPF via BTF is constrained to read only access to hook
>> parameters, and that its behavior would be entirely restrictive.
>>
>> I'd like to understand the security impact more fully, though.  Can the
>> eBPF code make arbitrary writes to the kernel, or read anything other than
>> the correctly bounded LSM hook parameters?
>>
> 
> As mentioned, the BPF verifier does not allow writes to BTF types.
> 
>>> And a traditional security module would necessarily fall
>>> under GPL; is the eBPF code required to be likewise?  If not, KRSI is a
>>> gateway for proprietary LSMs...
>>
>> Right, we do not want this to be a GPL bypass.
> 
> This is not intended to be a GPL bypass and the BPF verifier checks
> for license compatibility of the loaded program with GPL.

IIUC, it checks that the program is GPL compatible if it uses a function 
marked GPL-only.  But what specifically is marked GPL-only that is 
required for eBPF programs using KRSI?

> 
> - KP
> 
>>
>> If these issues can be resolved, this may be a "safe" way to support
>> loadable LSM applications.
>>
>> Again, I'd be interested in knowing how this is is handled in the
>> networking stack (keeping in mind that LSM is a much more invasive API,
>> and may not be directly comparable).
>>
>> -- 
>> James Morris
>> <jmorris@namei.org>
>>

