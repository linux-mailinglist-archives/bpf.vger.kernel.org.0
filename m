Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787E319A0B4
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 23:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaVYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 17:24:51 -0400
Received: from pub.regulars.win ([89.163.144.234]:45316 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgCaVYv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 17:24:51 -0400
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585689888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=kSnu8aYZJGCiJJXKBm4iCJ9kvH6rdwdaM0UQ4Eu6a6U=;
        b=lPKHPq0LADjBJSbKUE4TNjbYZXczD+b9PiG/FSOCFaSo/JP93CGHa3cCNMOYU8OTz612uE
        ZzN9EEIVjyIqJYFBBasnvkspoPKp7zozuC0u894cWpJk82LuTxVS7h+iOys2YNCEt/HZZU
        /D5GKO5qH3/Sidzj+mhcUbXViD2NYE8=
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook>
 <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
 <202003311110.2B08091E@keescook>
 <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
 <202003311257.3372EC63@keescook>
 <CAEf4BzYODtQtuO79BAn-m=2n8QwPRLd74UP-rwivHj6uLk3ycA@mail.gmail.com>
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
 nnARpEW9lSSeWPba99+PJu0q2rEaQj/Vhy/m2db89kYeLcEuItd4DYKk7rHZSrHBKwO5Ag0E
 UV1whQEQAL+iygdEbzvR2umvwH/bGU1WckI7UzydZb5HJ8BzDVl7xdTinH44S3FcPKFqx1rJ
 g0hJfE70VgLuqNE3wIEbNmdsBHJLmpvaRYGoeyMagWN6g0bB34f6eulguNxgJu8cHhtUTh5S
 Wnu9ot+awfaIRTLVqczHsak/ge5mLZ2o2+XIrotrAqOKiZ4d9OE7LjOKrjtd5ucaHyIPEkhY
 aQl6SgiDYnAGftn9AIjSP3yYuuEaPet9gNorPSdPktN4mnWIuGctEhuPGtH+8Glo48scIo1F
 Ctv1fE2ZjWN/ixok/cvShv8NvrF6iZp8fOLBQ5k3zTHER1Z8oid11VDMm0RdvLrna+UuB4Cd
 H33scvbgeUv+Wi4H4BgNQ92V9OzuawKRmzZB7Zmk2gIrM2FprJ2eGFFo+Cn9Au/DlXY/bZG8
 HTzd73f38A1xvRnKlPNRcVXQZuUZb3Gp70yCcwpNBmZ4v4QHdvbiTjtJ5kx5EigA6GJCYBuu
 LD9KghwGlenKH2HJP6iM+rYSr17Lsqtxf7dyM2cd32JOVZ0+v6toYVmLnqVHJaeZ/NaBAwNp
 LnbXYCTd9vr0b8lsBkenSVnvaWitf26LSVppM2sNfKMQYoISDc6HADcA/ZWABOqmRo91Vuoi
 xd3F/r57oHXkRLYvfst+0npFHLk3raFUFMaE3VrnhgNPABEBAAGJAiUEGAECAA8FAlFdcIUC
 GwwFCQ0oaIAACgkQUSYbvb34nfMdGg/9FanN5XwtN1k4H8NLMUv+kgE1MRGQGzoKUbvUyWy+
 /sO86gmA+W0/tfajKkQZ1YcEuDwqp22t8J8S4lMYPw6KqbTnk2jasx+JztWM3TqDRJ0f5bft
 nFxK66WeIpihIznYGT9586fpYxQpjskD5Uzlj6BxSkpKeOTnl1sAeC5FeO9I2Vos8yGqnUX1
 U7hLLBd/H2X0TT1c1ckoBV0sPRIeL3UtX2nr2giXX/7Rp1cDQNrmkrt2bYONnJ7uCE5axZR0
 la5fCNdKagu4qNY59FAHuYjKlZm5HyRUTiSRsxaDYBL2zRRMDSEeUE0vEJHrCruk5tiG4/FG
 yJp94j6BscV9OY0tWudAiOtuibg5XpQmfLSx6HQMSW7516UDfj9D94BzJAv2Jf/p23o3hAJm
 NnciL7qrTkF6BzCaA4Fn9uVJCCIt22SPeeP7uMzLfieDTGyx4EaU7jVu8pw7pwFKsAfCRLjt
 U0WfG0gxWV+4gW3xLELROCH7yj8I4EDwn+Q0euSYwiWqEGO6upnIBTQcYiPtKNo7BGvxtVJG
 jnLxzRafXczMK2VDWEnDahLDlDHx6okXNy7VZacR5/CcK0u5MIhDl9fD/Th1FZz94HIrbIIX
 fdzjFNfqeB5uZahQOWYM9rJN6XJ+9C9Zk6OfHPSv7TafeO8v7WXQBZdLtkNtX6MS+xg=
Message-ID: <8962ffa8-69b7-ab6b-3969-3029a95dfcec@bacher09.org>
Date:   Wed, 1 Apr 2020 00:24:46 +0300
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYODtQtuO79BAn-m=2n8QwPRLd74UP-rwivHj6uLk3ycA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



31.03.2020 23:23, Andrii Nakryiko пишет:
> On Tue, Mar 31, 2020 at 12:58 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Tue, Mar 31, 2020 at 12:50:07PM -0700, Andrii Nakryiko wrote:
>>> On Tue, Mar 31, 2020 at 11:12 AM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> On Tue, Mar 31, 2020 at 12:41:04AM +0200, Daniel Borkmann wrote:
>>>>> On 3/30/20 7:20 PM, Kees Cook wrote:
>>>>>> On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
>>>>>>> On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
>>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>>> On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
>>>>>>>>>
>>>>>>>>> I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
>>>>>>>>> of CONFIG_GCC_PLUGIN_RANDSTRUCT.
>>>>>>>>
>>>>>>>> Is it a theoretical stmt or you have data?
>>>>>>>> I think it's the other way around.
>>>>>>>> gcc-plugin breaks dwarf and breaks btf.
>>>>>>>> But I only looked at gcc patches without applying them.
>>>>>>>
>>>>>>> Ah, interesting - I haven't actually tested it, I just assumed
>>>>>>> (perhaps incorrectly) that the GCC plugin would deal with DWARF info
>>>>>>> properly.
>>>>>>
>>>>>> Yeah, GCC appears to create DWARF before the plugin does the
>>>>>> randomization[1], so it's not an exposure, but yes, struct randomization
>>>>>> is pretty completely incompatible with a bunch of things in the kernel
>>>>>> (by design). I'm happy to add negative "depends" in the Kconfig if it
>>>>>> helps clarify anything.
>>>>>
>>>>> Is this expected to get fixed at some point wrt DWARF? Perhaps would make
>>>>
>>>> No, gcc closed the issue as "won't fix".
>>>>
>>>>> sense then to add a negative "depends" for both DWARF and BTF if the option
>>>>> GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.
>>>>
>>>> I hadn't just to keep wider randconfig build test coverage. That said, I
>>>> could make it be: depends COMPILE_TEST || !DWARF ...
>>>>
>>>> I can certainly do that.
>>>
>>> I've asked Slava in [0] to disable all three known configs that break
>>> DWARF and subsequently BTF, I hope it's ok to just do it in one patch.
>>> Currently all these appear to result in invalid BTF due to various
>>> DWARF modifications:
>>>
>>>   - DEBUG_INFO_REDUCED (see [1])
>>>   - DEBUG_INFO_SPLIT (see [0]
>>>   - GCC_PLUGIN_RANDSTRUCT (this discussion).
>>>
>>>   [0] https://lore.kernel.org/bpf/CAEf4BzadnfAwfa1D0jZb=01Ou783GpK_U7PAYeEJca-L9kdnVA@mail.gmail.com/
>>>   [1] https://lore.kernel.org/bpf/CAEf4BzZri8KpwLcoPgjiVx_=QmJ2W9UzBkDqSO2rUWMzWogkKg@mail.gmail.com/
>>
>> Sure! That'd by fine by me. I'd just like it to be a "|| COMPILE_TEST"
>> for GCC_PLUGIN_RANDSTRUCT. Feel free to CC me for an Ack. :)
>>
> 
> +cc Slava
> 
> I'm unsure what COMPILE_TEST dependency (or is it anti-dependency?)
> has to do with BTF generation and reading description in Kconfig
> didn't clarify it for me. Can you please elaborate just a bit? Thanks!
> 
>> -Kees

Hi,

Regarding COMPILE_TEST, DEBUG_INFO has dependency on:

DEBUG_KERNEL && !COMPILE_TEST

And DEBUG_INFO_BTF depends on DEBUG_INFO, so enabling COMPILE_TEST
would block DEBUG_INFO and so DEBUG_INFO_BTF as well. Unless I don't
understand something and there is some other reason to add it.

--
Slava

>>
>>>
>>>
>>>>
>>>> -Kees
>>>>
>>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052
>>>>
>>>> --
>>>> Kees Cook
>>
>> --
>> Kees Cook
