Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5865D58F
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjADOZQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 09:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjADOZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 09:25:07 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228823B2
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 06:25:05 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pD4hR-0009US-JD; Wed, 04 Jan 2023 15:25:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pD4hR-0006Bo-77; Wed, 04 Jan 2023 15:25:01 +0100
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
 <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43406cdf-19c1-b80e-0f10-39a1afbf4b8b@iogearbox.net>
Date:   Wed, 4 Jan 2023 15:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26771/Wed Jan  4 09:47:43 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/4/23 12:51 AM, Alexei Starovoitov wrote:
> On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
>> On 12/31/22 1:42 AM, Alexei Starovoitov wrote:
>>> On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
>>>>>>
>>>>>> Taking bpf_get_current_task() as an example, I think it's better to have
>>>>>> the debate be "should we keep supporting this / are users still using
>>>>>> it?" rather than, "it's UAPI, there's nothing to even discuss". The
>>>>>> point being that even if bpf_get_current_task() is still used, there may
>>>>>> (and inevitably will) be other UAPI helpers that are useless and that we
>>>>>> just can't remove.
>>>
>>> Sorry, missed this question in the previous reply.
>>> The answer is "it's UAPI, there's nothing to even discuss".
>>> It doesn't matter whether bpf_get_current_task() is used heavily or not used at all.
>>> The chance of breaking user space is what paralyzes the changes.
>>> Any change to uapi header file is looked at with a magnifying glass.
>>> There is no deprecation story for uapi.
>>> The definition and semantics of bpf helpers are frozen _forever_.
>>> And our uapi/bpf.h is not in a good company:
>>> ls -Sla include/uapi/linux/|head
>>> -rw-r--r-- 1 ast users 331159 Nov  3 08:32 nl80211.h
>>> -rw-r--r-- 1 ast users 265312 Dec 25 13:51 bpf.h
>>> -rw-r--r-- 1 ast users 118621 Dec 25 13:51 v4l2-controls.h
>>> -rw-r--r-- 1 ast users  99533 Dec 25 13:51 videodev2.h
>>> -rw-r--r-- 1 ast users  86460 Nov 29 11:15 ethtool.h
>>>
>>> "Freeze bpf helpers now" is a minimum we should do right now.
>>> We need to take aggressive steps to freeze the growth of the whole uapi/bpf.h
>>
>> Imho, freezing BPF helpers now is way too aggressive step. One aspect which was
>> not discussed here is that unstable kfuncs will be a pain for user experience
>> compared to BPF helpers. Probably not for FB or G who maintain they own limited
>> set of kernels, but for all others. If there is valid reason that kfuncs will have
>> to change one way or another, then BPF applications using them will have to carry
>> the maintenance burden on their side to be able to support a variety of kernel
>> versions with working around the kfunc quirks. So you're essentially outsourcing
>> the problem from kernel to users, which will suck from a user experience (and add
>> to development cost on their side).
> 
> It's actually the opposite.
> A small company that wants to use BPF needs to have a workaround/plan B for
> different kernels and different distros.
> That's why cilium and others have to detect availability of helpers and bpf features.
> One bpf prog for newer kernel and potentially completely different solution
> for older kernels.
> That's the biggest obstacle in bpf adoption: the required features are in
> the latest kernels, but companies have to support older kernels too.
> Now look at the problem from different angle:
> Detecting kfuncs is no different than detecting helpers.
> The bpf users has to have a workaround when helper/kfunc is not available.
> In that sense stability of the helpers vs instability of kfuncs is irrelevant.
> Both might not exist in a particular kernel.
> So if cilium starts to use kfunc it won't be extra development cost and
> bpf program writer experience using kfuncs vs using helpers is the same as well.

But that was not the point I was making. What you describe above is the baseline
cost which is there regardless of BPF helper vs kfunc.. detecting availability
and having a workaround for older kernel if needed. The added cost is if kfunc
changes over time for whichever valid reason, then you are essentially pushing
the maintenance cost _from kernel to users_ when they need to keep track of that
and implement workarounds specifically to make the kfunc work in their program
for a set of kernels they plan to support, which they otherwise would /not/ have
if it was a BPF helper. It raises the barrier from user side. Similarly, if users
started out with using kfunc from a base kernel, and in future it might get
removed given its not stable, then a workaround (if possible) needs to be
implemented for newer kernels - probably rare occasion but not impossible or
something that can be ruled out entirely. So the stability of the helpers vs
instability of kfuncs is relevant in that case, not for the case you describe
above, and that is extra development cost on user side. Generally, what I'm saying
is, there needs to be a path forward where we are still open for both instead of
completely freezing the former.

> But with kfuncs we can solve this bpf adoption issue.
> The helpers are not easily backportable and cannot be added in modules,
> so company's workarounds for older kernel are painful.
> While kfuncs are trivially added in a module.

Maybe to a small degree. Often shipping out-of-tree kernel module is generally
a no-go from corp policy and there's nothing you can do about it in such case.

"trivially added" is a bit oversimplified as well.. depends on the kfunc of course,
but potentially painful in terms of having to work around various changing kernel
internals for your kfunc implementation and only possible if kernel actually exposes
the needed functionality to modules. While the adoption issue /can/ in some cases be
solved, I don't think it will be widely practical to solve adoption issue. Eventually
only time will solve it when everyone is on decent enough kernel as baseline, this
is what is there today at least for networking and tracing side where BPF is widely
adopted and its available framework big enough to solve many use cases.

Aside and independent of all that, kfuncs added in out of tree modules should be
discouraged. After all we want developers to contribute back to upstream kernel,
and for a very long time we've had the stance that no extra functionality should be
possible via out of tree module extensions.

> Let's take bpf_sock_destroy that Aditi wants to add as an example.
> If it's done as a helper the cilium would need to wait for the next kernel release
> and next distro release some years from now to actually use it at the customer site.

Yeap, with some distros in K8s space being better than others, for example, some like
Flatcar tend to be fairly up to date. With major LTS ones it takes 1+ years though.

> If bpf_sock_destroy is added as kfunc you can ship an extra kernel module
> with just that kfunc to your customers. You can also attempt to convince a distro
> that this module with kfuncs should be certified, since the same kfunc is in upstream kernel.
> The customer can use cilium that relies on bpf_sock_destroy much sooner
> and likely there won't be a need to develop a completely different workaround
> for kernels without that kfunc.

See above wrt modules. Some larger users which run their own DC infra also build
kernels for themselves, so in some cases it's possible and easier from corp policy
PoV to just cherry-pick upstream commits and roll them into their own kernel build
until they upgrade at some point to a base kernel where this comes by default. Some
of the distro vendors build "hw enablement" kernels for cloud providers and there
it is possible too to ask for backports on core functionality even if not in stable,
it's a slow process however.

[...]
>> Ofc there is interest in keeping changes to a
>> minimum, but it's not the same as BPF helpers where there is a significantly higher
>> guarantee that things continue to keep working going forward. Today in Cilium we
>> don't use any of the kfuncs, we might at some point when we see it necessary, but
>> likely to a limited degree if sth cannot be solved as-is and only kfunc is present
>> as a solution. But again, from a UX it's not great having to know that things can
>> break anytime soon with newer kernels (things might already with verifier/LLVM
>> upgrade and kfunc potentially adds yet another level). Generally speaking, I'm not
>> against kfuncs but I suggest only making "freeze bpf helpers now" a soft freeze
>> with a path forward for promoting some of the kfuncs which have been around and
>> matured for a while and didn't need changes as stable BPF helpers to indicate their
>> maturity level when we see it fit. So it's not a hard "no", but possible promotion
>> when suitable.
> 
> The problem with 'soft' freeze that it's open to interpretation and abuse.
> It feels to me you're saying that cilium is not using kfuncs and
> therefore all cilium features additions are ok to be done as helpers.
> That doesn't sound fair to other bpf devs.

I think you misread, lets not twist what I mentioned. All I was saying is that we
should keep the door open for both to continue to co-exist; both have a place, both
come with their advantages but also baggage. It's not that one is absolutely better
than the other, and that maintenance baggage is either on our side or pushed towards
users.

[...]
>> Discoverability plus being able to know semantics from a user PoV to figure out when
>> workarounds for older/newer kernels are required to be able to support both kernels.
> 
> Sounds like your concern is that there could be a kfunc that changed it semantics,
> but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
> such patches from landing. It's up to us to define sane and user friendly deprecation of kfuncs.

Yes, that is a concern. New kfunc and deprecation with eventual removal of the old
one might be better in such case, agree.

[...]
>> is imho repeating the same story as BPF helpers vs kfuncs. Saying a kfunc is 'pretty
>> stable' is kind of hinting to users that it's close to UAPI, but yet it's unstable.
> 
> correct.
> 
>> It'll confuse even more. I'd rather have a path forward where those kfuncs get promoted
> 
> why confuse more? There are EXPORT_SYMBOL like kmalloc that are quite stable,
> yet they can change.
> EXPORT_SYMBOL_GPL is exact analogy to kfunc.

They are quite stable because they are used in lots of places in-tree and changing
would cause a ton of needless churn and merge conflicts for everyone, etc. You might
not always have this kind of visibility on usage of kfuncs. The data you have is
from your internal code base and what's in some of the larger OSS projects, but
certainly a more limited/biased view. So as with 'soft' freeze this is just as well open
to interpretation. "confuse more" because you declare it quite stable, yet not stable.
Why is there fear to make them proper uapi then with the given known guarantees? From
user side this guarantee is a good thing, not a bad thing. Mistakes were/are made all
the time and learned from. Imagine syscall API is not stable anymore. Would you invest
the cost to develop an application against it? Imho, it's one of BPF's strengths and
we should keep the door open, not close it.

>> to actual BPF helpers by then where we go and say, that kfunc has proven itself in production
>> and from an API PoV that it is ready to be a proper BPF helper, and until this point
> 
> "Proper BPF helper" model is broken.
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> 
> is a hack that works only when compiler optimizes the code.
> See gcc's attr(kernel_helper) workaround.
> This 'proper helper' hack is the reason we cannot compile bpf programs with -O0.
> And because it's uapi we cannot even fix this
> With kfuncs we will be able to compile with -O0 and debug bpf programs with better tools.
> These tools don't exist yet, but we have a way forward whereas with helpers
> we are stuck with -O2.

Better debugging tools are needed either way, independent of -O0 or -O2. I don't
think -O0 is a requirement or barrier for that. It may open up possibilities for
new tools, but production is still running with -O2. Proper BPF helper model is
broken, but everyone relies on it, and will be for a very very long time to come,
whether we like it or not. There is a larger ecosystem around BPF devs outside of
kernel, and developers will use the existing means today. There are recommendations /
guidelines that we can provide but we also don't have control over what developers
are doing. Yet we should make their life easier, not harder. Better debugging
possibilities should cater to everyone.

Thanks,
Daniel
