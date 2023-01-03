Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C365BF4C
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjACLoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjACLoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 06:44:05 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D12187
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 03:44:02 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pCfi3-0005Hu-Mn; Tue, 03 Jan 2023 12:43:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pCfi3-000Ljr-CT; Tue, 03 Jan 2023 12:43:59 +0100
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
Date:   Tue, 3 Jan 2023 12:43:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26770/Tue Jan  3 09:59:01 2023)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/31/22 1:42 AM, Alexei Starovoitov wrote:
> On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
>>>>
>>>> Taking bpf_get_current_task() as an example, I think it's better to have
>>>> the debate be "should we keep supporting this / are users still using
>>>> it?" rather than, "it's UAPI, there's nothing to even discuss". The
>>>> point being that even if bpf_get_current_task() is still used, there may
>>>> (and inevitably will) be other UAPI helpers that are useless and that we
>>>> just can't remove.
> 
> Sorry, missed this question in the previous reply.
> The answer is "it's UAPI, there's nothing to even discuss".
> It doesn't matter whether bpf_get_current_task() is used heavily or not used at all.
> The chance of breaking user space is what paralyzes the changes.
> Any change to uapi header file is looked at with a magnifying glass.
> There is no deprecation story for uapi.
> The definition and semantics of bpf helpers are frozen _forever_.
> And our uapi/bpf.h is not in a good company:
> ls -Sla include/uapi/linux/|head
> -rw-r--r-- 1 ast users 331159 Nov  3 08:32 nl80211.h
> -rw-r--r-- 1 ast users 265312 Dec 25 13:51 bpf.h
> -rw-r--r-- 1 ast users 118621 Dec 25 13:51 v4l2-controls.h
> -rw-r--r-- 1 ast users  99533 Dec 25 13:51 videodev2.h
> -rw-r--r-- 1 ast users  86460 Nov 29 11:15 ethtool.h
> 
> "Freeze bpf helpers now" is a minimum we should do right now.
> We need to take aggressive steps to freeze the growth of the whole uapi/bpf.h

Imho, freezing BPF helpers now is way too aggressive step. One aspect which was
not discussed here is that unstable kfuncs will be a pain for user experience
compared to BPF helpers. Probably not for FB or G who maintain they own limited
set of kernels, but for all others. If there is valid reason that kfuncs will have
to change one way or another, then BPF applications using them will have to carry
the maintenance burden on their side to be able to support a variety of kernel
versions with working around the kfunc quirks. So you're essentially outsourcing
the problem from kernel to users, which will suck from a user experience (and add
to development cost on their side). Ofc there is interest in keeping changes to a
minimum, but it's not the same as BPF helpers where there is a significantly higher
guarantee that things continue to keep working going forward. Today in Cilium we
don't use any of the kfuncs, we might at some point when we see it necessary, but
likely to a limited degree if sth cannot be solved as-is and only kfunc is present
as a solution. But again, from a UX it's not great having to know that things can
break anytime soon with newer kernels (things might already with verifier/LLVM
upgrade and kfunc potentially adds yet another level). Generally speaking, I'm not
against kfuncs but I suggest only making "freeze bpf helpers now" a soft freeze
with a path forward for promoting some of the kfuncs which have been around and
matured for a while and didn't need changes as stable BPF helpers to indicate their
maturity level when we see it fit. So it's not a hard "no", but possible promotion
when suitable.

[...]
> When I mentioned 91 kfunc in my previous reply I forgot to count another dozen kfuncs
> in sched-ext and another dozen in hid-bpf that are not in mainline yet.
> fuse-bpf will likely add their own kfuncs and so on.

For the latter agree as well given from a bigger picture, they are mainly niche use
cases at this point and in future.

> Your 'todo list' for kfuncs is absolutely correct. Are kfuncs a perfect substitute
> for helpers? No. They have downsides and we need to work on addressing downsides
> instead of growing bpf.h further.
> Are we ready to freeze bpf helpers? Absolutely yes.
> "please use kfuncs instead of helpers" was our recommendation for 9 month or so
> and now we need to make it an official rule.
> For bpf noobs it's certainly easier to add new prog type, new map type, new helper,
> but that gotta stop.
> Last prog type we added in May 2021 and we should try hard not to add one anymore.
> hid-bpf managed to do everything without new prog type.
> sched-ext is not adding new prog type either.
> This is great. We're breaking free from uapi constraints.
[...]

> The challenge of requiring the doc with a kfunc is that it can make kfunc
> look stable.
> We need the whole spectrum of kfuncs from pretty stable (like bpf_obj_new)
> to something very unstable (like bpf_kfunc_call_test_mem_len_fail2).
> We cannot require a doc with automatic .h for every kfunc.
> Therefore right now all kfuncs are completely unstable and
> stability story (including good doc and discoverability) is yet to be figured out.
[...]

Discoverability plus being able to know semantics from a user PoV to figure out when
workarounds for older/newer kernels are required to be able to support both kernels.
"something very unstable" sounds like it probably shouldn't even be merged in the
first place, but generally speaking a spectrum from pretty stable to very unstable
is imho repeating the same story as BPF helpers vs kfuncs. Saying a kfunc is 'pretty
stable' is kind of hinting to users that it's close to UAPI, but yet it's unstable.
It'll confuse even more. I'd rather have a path forward where those kfuncs get promoted
to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
and from an API PoV that it is ready to be a proper BPF helper, and until this point
it's unstable, expect things to change, period. If a kfunc actually changed for the
kernels that users develop against, they need to go and figure out anyway as part of
their development process (/ maintenance cost).

> Agree that any hard policy like 'only kfuncs from now on' gotta have its limits.
> Maybe there will be a strong reason to add a new helper one day,
> so we can keep the door open a tiny bit for an exception,

+1

> but for dynptr...
> There are kfuncs with dynptr already (bpf_verify_pkcs7_signature)
> So precedent is already made.

bpf_verify_pkcs7_signature as kfunc also makes sense given wider-spread adoption (and
ideally as part of an OSS project) is yet to be seen.

>> Also a reasonable point. My point above was really just a response to
>> your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
>> vs. helpers.
>>
>> [0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/
> 
> The flawed part of dynptr I was explaining here:
> https://lore.kernel.org/all/20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com/
> 
> It's not that the whole concept of dynptr is flawed,
> but using it as an abstraction on top of skb/xdp.
> I don't believe that the extreme performance demands of xdp users are
> compatible with 'lets verify in runtime' philosophy of dynptr.
> I could be wrong. That's why I'm fine adding dynptr_on_top_of_xdp as kfuncs
> and seeing it playing out, but certainly not as a stable helper.
> iirc Martin and Kuba had concerns about bits of dynptr(skb | xdp) too.

(My assumption was that you're adding it because you were planning to use
it internally?)

> With kfuncs we can iron out the issues while trying to use it whereas
> with helpers we will be stuck for long time in endless mailing list arguments.
> It's a win-win for everyone to switch everything to kfuncs.

Thanks,
Daniel
