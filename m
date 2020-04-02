Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5340D19CBB3
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbgDBUi1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 16:38:27 -0400
Received: from pub.regulars.win ([89.163.144.234]:50238 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgDBUi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 16:38:26 -0400
Subject: Re: [PATCH v4 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585859903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=yU9hKHsWF04/aHMSAoqtWXojqC2smH8PJdSe85WG+s0=;
        b=ZCMoDjDEQ+JMvQThTix0Oq40GUHZekLHqu/CMFOVQHlLzDzemAnV0G9FfYylWzY445heWK
        jghG+YF5yjomUG0DryIiXNHyQHEZJ+HFnYokjYUD4Y2pMRmRehNbw5dQfgTI5J3rprAQt0
        SA3TqCtBHlEzjZosZtNEXBknwyCTt6c=
To:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>, kpsingh@google.com
References: <202004010849.CC7E9412@keescook>
 <20200402153335.38447-1-slava@bacher09.org>
 <f43f4e17-f496-9ee1-7d89-c8f742720a5f@bacher09.org>
 <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
 <202004021328.E6161480@keescook>
From:   Slava Bacherikov <slava@bacher09.org>
Autocrypt: addr=slava@bacher09.org; prefer-encrypt=mutual; keydata=
 mQINBFFdcIUBEAC9HZz+DbqCs+jyJjpvRyped8U4bz716OZKvZCTH4fNxrrV0fYWRn7LJ/dU
 r5tBnwhmlTWD4v6hk88qpD9flagkSP4UuIAo+3aopxvrkyWXXYiEAjSL2uTFolcEO40HuYPk
 7nprTEzHcHgcYq2wzJfE046gimzFYcUXkrv1gC89RdkwOgLTFb80QUpKyVeoKJWKWHPfRqGF
 FxpFwMnW3IrgZhOnl8X859WwKUc/agPz05LjaksGpAP8ayfruxtG/3Hl7OulYPWIkTuxHAtK
 xW9QL7Vt24P8rVLC7sgNZYcjaOcY70PCkGLnquETuIeeCwhKr/e2n+ymH+CxlAiUY+blNpO5
 S5P+rwb0qPvGDzjF+Drdp0ye/S3kMa+FNrELW06Fp74p7BgsPgNsuBVg300JWMFXiS7YeMZV
 cyedAzGbcO8yxrY6ZnuNF8rLiZOYde79yN82wTNw/fWZtHhz8QJELZzMNjZd3/w61ztSs9ng
 mduiqv9EyNKlEEuxy6N4jGTQ2YYLE/YcIx654rCfpJWJhj2kDd4k2uNRrhJI7t4duHC86K4M
 HiOwC7PIKlIbtrpYnTZPXXcQHp69LDzxCAA6dgGkhjZsUTVci0rTEfRQjkXYvK/f3P1SHF1M
 EHoeEaclqvpkuvPcbHQ/TBwBJs+ekdFCTmBzv0UwqZKfaPW5yQARAQABtDJTbGF2YSBCYWNo
 ZXJpa292IChNeSBOZXcgS2V5KSA8c2xhdmFAYmFjaGVyMDkub3JnPokCWQQTAQIAQwIbIwUJ
 DShogAcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAFiEEZkmc+DLOftzkG8AWUSYbvb34nfMF
 AlkF95wCGQEACgkQUSYbvb34nfO7FQ//drNtAxFi294vVZnN+wyVimXGiyBHpBPnEK5/hSQ5
 oBVvjFl8Ws7q13WWklhdPgM3atAukADMG5wr3IM3ctS1L2+502TYGv8W5jvUlso/TxjNdVQz
 SDicmPCMMs91BWHiJHkYKErUXxNtCaBQqVV2rAKiDoK1gtFrWfH/3OgP6RS+mLMt5eJ/PHsc
 kAuvaXOIzWxjclGMB2yAQzmK7SImOHp7YUBqXrOt523sz29p+1q0+y6ZRlPNctys/okUdnoK
 bi0rMBqbHngaoi/al9Clh9jrhqjZHJLPSM091u3ubuQkvtg3BOhqs0I/b7Xz83VxN0pj8XHI
 z4MRFwfhVSKW4pRLf92DKAa9PEYxA9QtboKafZG2EJfrUauba29/JoIh8Evi5MIuWNeZK7pK
 t3+NadAwXwcLP4RlLuOkVrF+DAuhEktvdJBvTfUkipeQo3YGcffm1daJWoUKiP2a3tqJ9fz8
 Zd5cy8hvKFCv5VsoqF2voc6uaadH1/Pwylnw2fzTfGzFP0bsz/HI8F7g3WFv0PrrtkXnPUCD
 2IbmIGe8fi7NBTIqtc+mDMsqOIa4hlLBGkP8jHnCPv6oaGYlWemzcVhehU3XQOKyT2lroZan
 nnARpEW9lSSeWPba99+PJu0q2rEaQj/Vhy/m2db89kYeLcEuItd4DYKk7rHZSrHBKwM=
Message-ID: <ddd2ac2e-fc7e-3216-69cd-4e9a01df1958@bacher09.org>
Date:   Thu, 2 Apr 2020 23:38:21 +0300
MIME-Version: 1.0
In-Reply-To: <202004021328.E6161480@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



02.04.2020 23:34, Kees Cook wrote:
> On Thu, Apr 02, 2020 at 12:31:36PM -0700, Andrii Nakryiko wrote:
>> On Thu, Apr 2, 2020 at 8:40 AM Slava Bacherikov <slava@bacher09.org> wrote:
>>>
>>>
>>>
>>> 02.04.2020 18:33, Slava Bacherikov wrote:
>>>> +     depends on DEBUG_INFO || COMPILE_TEST
>>>
>>> Andrii are you fine by this ?
>>
>> I think it needs a good comment explaining this weirdness, at least.
>> As I said, if there is no DEBUG_INFO, there is not point in doing
>> DWARF-to-BTF conversion, even more -- it actually might fail, I
>> haven't checked what pahole does in that case. So I'd rather drop
>> GCC_PLUGIN_RANDSTRUCT is that's the issue here. DEBUG_INFO_SPLIT and
>> DEBUG_INFO_REDUCED look good.

Yesterday before sending it I tested it against latest bpf git with
allyesconfig and it compiled fine, even worked in vm ;)
> 
> The DEBUG_INFO is separate, AIUI -- it sounds like BTF may entirely
> break on a compile with weird DWARF configs.
> 
> The GCC_PLUGIN_RANDSTRUCT issue is separate: it doesn't make sense to
> run a kernel built with BTF and GCC_PLUGIN_RANDSTRUCT. But they should
> have nothing to do with each other with regard to compilation. So, to
> keep GCC_PLUGIN_RANDSTRUCT disable for "real" builds but leave it on for
> all*config, randconfig, etc, I'd like to keep the || COMPILE_TEST,
> otherwise GCC_PLUGIN_RANDSTRUCT won't be part of the many CIs doing
> compilation testing.
> 
> And FWIW, I'm fine to let GCC_PLUGIN_RANDSTRUCT and BTF build together.
> But if they want to be depends-conflicted, I wanted to keep the test
> compile trap door.
> 

Oh, seems I misunderstood you, if everyone agree I'll drop it.
