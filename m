Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0074054EB68
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377835AbiFPUlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 16:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPUlN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 16:41:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D815DBE4;
        Thu, 16 Jun 2022 13:41:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v1so4871798ejg.13;
        Thu, 16 Jun 2022 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZX9JgSgpO6/STPh5oKqOZionL+u6SB4bHVqwwDB2X20=;
        b=bNZQ9KCrFNfpH1fpV1F5+xKr1rmQKZCAjhQuZuZHrfO2qHvxvN3fF6kl77Esdg3LvH
         NPhLv5H9RLBSB3FFk+p4G6Ztr0xlVvXKUdxuy55CgOt6u39vMKepJ5zAML5kUfuPVwrN
         NXCdL1M1E+YbmwPX61sc+s21qbGb2lZm2N/sFz9JjHzjMOdoi5PpGjWM02db0p9kKfwE
         kV2gMVjtoURZHG+V5U2jvb93VndEtQNIBgI0NuvB0BWjZJFIC1ciBr+iBUlx4/PsUsby
         zXrlKg00GckRocagToHzdn7DNv4uuGZgu76pYc1PbCPlpl3UEJvWsiAunWsADN17/RWY
         9vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZX9JgSgpO6/STPh5oKqOZionL+u6SB4bHVqwwDB2X20=;
        b=SuwHFhwmZxTdd+/q9K2HJ2NXBkIqCjaqrzLWDQddGohT+O7QnhCKA5uNGEYd518Alv
         mt5ZHayRmMnkhq7NQueCS11RccjHdwsAI/QvgDixkJBnZ7yYdLevrF4P8WvL+kG2UNLi
         LMeq1sNODzzTzd44VEusG8EOuu9RtAQ44N/EhkdHtBly+gvG6keqKg5U5f+BGJhjKut4
         YGgRJ6lBBPqItJrnOjcTGcD4VMHDCp3P7ukSIu8WlLH8jT2Zu9uPqEK4fmOGv4M1LF20
         9niJsgYQ/agArrYDlKzd6vVVCdcYD6t8KD8MmCY3zevfUgTwMDKpthWk9Dpplz1R7UeL
         QBtQ==
X-Gm-Message-State: AJIora8SftEqE6lj2++5BSMgWu/z/R/e59OANkQQ5hB5p5Yso+jIc70m
        VyvmGsXQTyOdriemOxuzTE1v/ylaJXBO4LSjiOU=
X-Google-Smtp-Source: AGRyM1tB6Gsh98JOw9W33WN1cg50OH8cLEEFBGJezTVrFNX14LbO/D1lgZbD7RaamLRg4jbJhyY0xDC/WwAs9Xwi62s=
X-Received: by 2002:a17:906:8302:b0:70d:7465:495a with SMTP id
 j2-20020a170906830200b0070d7465495amr6046586ejx.115.1655412070693; Thu, 16
 Jun 2022 13:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220610112648.29695-1-quentin@isovalent.com> <20220610112648.29695-2-quentin@isovalent.com>
 <YqNsWAH24bAIPjqy@google.com> <cb05a59e-07d5-ddd1-b028-82133faaf67e@isovalent.com>
 <CAKH8qBvvq0f+D8BXChw_8krH896J_cYg0yhRfnDOSO_U1n394w@mail.gmail.com>
 <71b56050-11ad-bd06-09c9-1a8c61b4c1b4@isovalent.com> <CAKH8qBsFyakQRd1q6XWggdv4F5+HrHoC4njg9jQFDOfq+kRBCQ@mail.gmail.com>
 <CALOAHbCvWzOJ169fPTCp1KsFpkEVukKgGnH4mDeYGOEv6hsEpQ@mail.gmail.com>
 <e9aa57d2-4ce7-23f2-0ba1-ea58f3254353@isovalent.com> <CALOAHbDDx_xDeUk8R+y-aREX9KMRbo+CqCV7m5dADdvijuHRQw@mail.gmail.com>
 <CAKH8qBuPh4aaEz_vv1s2gWYYPRm8e5gMaM-RcuCqg+AeaeZcPg@mail.gmail.com>
 <CALOAHbAfjegzchFOb9b1+4d0OLsVWOpnr7ARMXqcKbnbG=u2BA@mail.gmail.com>
 <68e789f7-aa68-cc6a-fb33-b686d14f80a5@isovalent.com> <CALOAHbCTJOm8wLAeuhnjnN96_9c+hB5YjLGO_4NsgiB=8_QQOA@mail.gmail.com>
 <CAKH8qBs01xiVxE_6BYcYgJrz9afgHY2P=NadyRCQfKRU+Td8Ow@mail.gmail.com>
In-Reply-To: <CAKH8qBs01xiVxE_6BYcYgJrz9afgHY2P=NadyRCQfKRU+Td8Ow@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Jun 2022 13:40:58 -0700
Message-ID: <CAEf4BzZLq3-ZyQF-k2ZV04O3PDx3BW=sQjLfp7C8uYBAHP7xJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] Revert "bpftool: Use libbpf 1.0 API mode
 instead of RLIMIT_MEMLOCK"
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Harsh Modi <harshmodi@google.com>,
        Paul Chaignon <paul@cilium.io>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 11:08 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Thu, Jun 16, 2022 at 7:54 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 9:59 PM Quentin Monnet <quentin@isovalent.com> wrote:
> > >
> > > 2022-06-16 00:05 UTC+0800 ~ Yafang Shao <laoar.shao@gmail.com>
> > > > On Wed, Jun 15, 2022 at 11:52 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >>
> > > >> On Wed, Jun 15, 2022 at 6:23 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >>>
> > > >>> On Tue, Jun 14, 2022 at 10:20 PM Quentin Monnet <quentin@isovalent.com> wrote:
> > > >>>>
> > > >>>> 2022-06-14 20:37 UTC+0800 ~ Yafang Shao <laoar.shao@gmail.com>
> > > >>>>> On Sat, Jun 11, 2022 at 1:17 AM Stanislav Fomichev <sdf@google.com> wrote:
> > > >>>>>>
> > > >>>>>> On Fri, Jun 10, 2022 at 10:00 AM Quentin Monnet <quentin@isovalent.com> wrote:
> > > >>>>>>>
> > > >>>>>>> 2022-06-10 09:46 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> > > >>>>>>>> On Fri, Jun 10, 2022 at 9:34 AM Quentin Monnet <quentin@isovalent.com> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> 2022-06-10 09:07 UTC-0700 ~ sdf@google.com
> > > >>>>>>>>>> On 06/10, Quentin Monnet wrote:
> > > >>>>>>>>>>> This reverts commit a777e18f1bcd32528ff5dfd10a6629b655b05eb8.
> > > >>>>>>>>>>
> > > >>>>>>>>>>> In commit a777e18f1bcd ("bpftool: Use libbpf 1.0 API mode instead of
> > > >>>>>>>>>>> RLIMIT_MEMLOCK"), we removed the rlimit bump in bpftool, because the
> > > >>>>>>>>>>> kernel has switched to memcg-based memory accounting. Thanks to the
> > > >>>>>>>>>>> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK, we attempted to keep compatibility
> > > >>>>>>>>>>> with other systems and ask libbpf to raise the limit for us if
> > > >>>>>>>>>>> necessary.
> > > >>>>>>>>>>
> > > >>>>>>>>>>> How do we know if memcg-based accounting is supported? There is a probe
> > > >>>>>>>>>>> in libbpf to check this. But this probe currently relies on the
> > > >>>>>>>>>>> availability of a given BPF helper, bpf_ktime_get_coarse_ns(), which
> > > >>>>>>>>>>> landed in the same kernel version as the memory accounting change. This
> > > >>>>>>>>>>> works in the generic case, but it may fail, for example, if the helper
> > > >>>>>>>>>>> function has been backported to an older kernel. This has been observed
> > > >>>>>>>>>>> for Google Cloud's Container-Optimized OS (COS), where the helper is
> > > >>>>>>>>>>> available but rlimit is still in use. The probe succeeds, the rlimit is
> > > >>>>>>>>>>> not raised, and probing features with bpftool, for example, fails.
> > > >>>>>>>>>>
> > > >>>>>>>>>>> A patch was submitted [0] to update this probe in libbpf, based on what
> > > >>>>>>>>>>> the cilium/ebpf Go library does [1]. It would lower the soft rlimit to
> > > >>>>>>>>>>> 0, attempt to load a BPF object, and reset the rlimit. But it may induce
> > > >>>>>>>>>>> some hard-to-debug flakiness if another process starts, or the current
> > > >>>>>>>>>>> application is killed, while the rlimit is reduced, and the approach was
> > > >>>>>>>>>>> discarded.
> > > >>>>>>>>>>
> > > >>>>>>>>>>> As a workaround to ensure that the rlimit bump does not depend on the
> > > >>>>>>>>>>> availability of a given helper, we restore the unconditional rlimit bump
> > > >>>>>>>>>>> in bpftool for now.
> > > >>>>>>>>>>
> > > >>>>>>>>>>> [0]
> > > >>>>>>>>>>> https://lore.kernel.org/bpf/20220609143614.97837-1-quentin@isovalent.com/
> > > >>>>>>>>>>> [1] https://github.com/cilium/ebpf/blob/v0.9.0/rlimit/rlimit.go#L39
> > > >>>>>>>>>>
> > > >>>>>>>>>>> Cc: Yafang Shao <laoar.shao@gmail.com>
> > > >>>>>>>>>>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> > > >>>>>>>>>>> ---
> > > >>>>>>>>>>>   tools/bpf/bpftool/common.c     | 8 ++++++++
> > > >>>>>>>>>>>   tools/bpf/bpftool/feature.c    | 2 ++
> > > >>>>>>>>>>>   tools/bpf/bpftool/main.c       | 6 +++---
> > > >>>>>>>>>>>   tools/bpf/bpftool/main.h       | 2 ++
> > > >>>>>>>>>>>   tools/bpf/bpftool/map.c        | 2 ++
> > > >>>>>>>>>>>   tools/bpf/bpftool/pids.c       | 1 +
> > > >>>>>>>>>>>   tools/bpf/bpftool/prog.c       | 3 +++
> > > >>>>>>>>>>>   tools/bpf/bpftool/struct_ops.c | 2 ++
> > > >>>>>>>>>>>   8 files changed, 23 insertions(+), 3 deletions(-)
> > > >>>>>>>>>>
> > > >>>>>>>>>>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> > > >>>>>>>>>>> index a45b42ee8ab0..a0d4acd7c54a 100644
> > > >>>>>>>>>>> --- a/tools/bpf/bpftool/common.c
> > > >>>>>>>>>>> +++ b/tools/bpf/bpftool/common.c
> > > >>>>>>>>>>> @@ -17,6 +17,7 @@
> > > >>>>>>>>>>>   #include <linux/magic.h>
> > > >>>>>>>>>>>   #include <net/if.h>
> > > >>>>>>>>>>>   #include <sys/mount.h>
> > > >>>>>>>>>>> +#include <sys/resource.h>
> > > >>>>>>>>>>>   #include <sys/stat.h>
> > > >>>>>>>>>>>   #include <sys/vfs.h>
> > > >>>>>>>>>>
> > > >>>>>>>>>>> @@ -72,6 +73,13 @@ static bool is_bpffs(char *path)
> > > >>>>>>>>>>>       return (unsigned long)st_fs.f_type == BPF_FS_MAGIC;
> > > >>>>>>>>>>>   }
> > > >>>>>>>>>>
> > > >>>>>>>>>>> +void set_max_rlimit(void)
> > > >>>>>>>>>>> +{
> > > >>>>>>>>>>> +    struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> > > >>>>>>>>>>> +
> > > >>>>>>>>>>> +    setrlimit(RLIMIT_MEMLOCK, &rinf);
> > > >>>>>>>>>>
> > > >>>>>>>>>> Do you think it might make sense to print to stderr some warning if
> > > >>>>>>>>>> we actually happen to adjust this limit?
> > > >>>>>>>>>>
> > > >>>>>>>>>> if (getrlimit(MEMLOCK) != RLIM_INFINITY) {
> > > >>>>>>>>>>     fprintf(stderr, "Warning: resetting MEMLOCK rlimit to
> > > >>>>>>>>>>     infinity!\n");
> > > >>>>>>>>>>     setrlimit(RLIMIT_MEMLOCK, &rinf);
> > > >>>>>>>>>> }
> > > >>>>>>>>>>
> > > >>>>>>>>>> ?
> > > >>>>>>>>>>
> > > >>>>>>>>>> Because while it's nice that we automatically do this, this might still
> > > >>>>>>>>>> lead to surprises for some users. OTOH, not sure whether people
> > > >>>>>>>>>> actually read those warnings? :-/
> > > >>>>>>>>>
> > > >>>>>>>>> I'm not strictly opposed to a warning, but I'm not completely sure this
> > > >>>>>>>>> is desirable.
> > > >>>>>>>>>
> > > >>>>>>>>> Bpftool has raised the rlimit for a long time, it changed only in April,
> > > >>>>>>>>> so I don't think it would come up as a surprise for people who have used
> > > >>>>>>>>> it for a while. I think this is also something that several other
> > > >>>>>>>>> BPF-related applications (BCC I think?, bpftrace, Cilium come to mind)
> > > >>>>>>>>> have been doing too.
> > > >>>>>>>>
> > > >>>>>>>> In this case ignore me and let's continue doing that :-)
> > > >>>>>>>>
> > > >>>>>>>> Btw, eventually we'd still like to stop doing that I'd presume?
> > > >>>>>>>
> > > >>>>>>> Agreed. I was thinking either finding a way to improve the probe in
> > > >>>>>>> libbpf, or waiting for some more time until 5.11 gets old, but this may
> > > >>>>>>> take years :/
> > > >>>>>>>
> > > >>>>>>>> Should
> > > >>>>>>>> we at some point follow up with something like:
> > > >>>>>>>>
> > > >>>>>>>> if (kernel_version >= 5.11) { don't touch memlock; }
> > > >>>>>>>>
> > > >>>>>>>> ?
> > > >>>>>>>>
> > > >>>>>>>> I guess we care only about <5.11 because of the backports, but 5.11+
> > > >>>>>>>> kernels are guaranteed to have memcg.
> > > >>>>>>>
> > > >>>>>>> You mean from uname() and parsing the release? Yes I suppose we could do
> > > >>>>>>> that, can do as a follow-up.
> > > >>>>>>
> > > >>>>>> Yeah, uname-based, I don't think we can do better? Given that probing
> > > >>>>>> is problematic as well :-(
> > > >>>>>> But idk, up to you.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Agreed with the uname-based solution. Another possible solution is to
> > > >>>>> probe the member 'memcg' in struct bpf_map, in case someone may
> > > >>>>> backport memcg-based  memory accounting, but that will be a little
> > > >>>>> over-engineering. The uname-based solution is simple and can work.
> > > >>>>>
> > > >>>>
> > > >>>> Thanks! Yes, memcg would be more complex: the struct is not exposed to
> > > >>>> user space, and BTF is not a hard dependency for bpftool. I'll work on
> > > >>>> the uname-based test as a follow-up to this set.
> > > >>>>
> > > >>>
> > > >>> After a second thought, the uname-based test may not work, because
> > > >>> CONFIG_MEMCG_KMEM can be disabled.
> > > >>
> > > >> Does it matter? Regardless of whether there is memcg or not, we
> > > >> shouldn't touch ulimit on 5.11+
> > > >> If there is no memcg, there is no bpf memory enforcement.
> > > >
> > > > Right, rlimit-based accounting is totally removed, that is not the
> > > > same with what I thought before, while I thought it will fallback to
> > > > rlimit-based if kmemcg is disabled.
> > >
> > > Agreed, and so I've got a patch ready for the uname-based probe.
> > >
> > > But talking about this with Daniel, we were wondering if it would make
> > > sense instead to have the probe I had initially submitted (lower the
> > > rlimit to 0, attempt to load a program, reset rlimit - see [0]), but
> > > only for bpftool instead of libbpf? My understanding is that the memlock
> > > rlimit is per-process, right? So this shouldn't affect any other
> > > process, and because bpftool is not multithreaded, nothing other than
> > > probing would happen while the rlimit is at zero?
> >
> > Makes sense.
> > It is safe to do the probe within bpftool.
>
> +1, seems to be safe to continue doing that in bpftool.

Agree, doing it in the *application* (which bpftool is for libbpf)
seems totally safe and fine.
