Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13280549CB2
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347215AbiFMTCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346412AbiFMTBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:01:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD05BA2043;
        Mon, 13 Jun 2022 09:32:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so12175940ejj.12;
        Mon, 13 Jun 2022 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzGUDFsCzgw46dGv6ss6usYvH4hs/ViW0MBbfLbUFZo=;
        b=nlzoagPwfj0LhMxs/l6fz01dGnoU8NwE84NIq7Z2b3twrp78wtAO6rOKeKiVTFusP7
         DA72WRZWGZHmVsuLEoc94tH9YUkZZyUsCkk48w072AYa/RAwiYpl+M0VfPfa8EuCV3BR
         NHbGip+Q9ylMufrEnBK3ascMy98+8R075H+3DcdXhVsd6ZdOSD0UhVEvB7gSakBHxQO7
         7IF36HNqCRLdBYiuqNmGAQ7zOcRsevztguKDLQXjJRgeMOdskiIJWdfl2GxfxfSKRI4N
         xva0SsGfAP3VuOCK+0Q4GOzw6WiQBkz1QWpky4Br/dcTfyaOi0tUHsj9df9xLMbP1XlU
         b+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzGUDFsCzgw46dGv6ss6usYvH4hs/ViW0MBbfLbUFZo=;
        b=mhBwjTvJB8pPDqnGqVBjwjn1pBe7gdFE2lBXANHbb0DfwWl0FyqJGPGnnYAfl7wB/U
         339HwyB8X9zw/l6lynQqFh3T+r7G+mmGlYeMSnHwmAXoSeMUCI7mxodE+S2qu0NSSsWP
         lKnSV9KXI3YQre3tQjSUNgTb4LCLQWcgr/JB+Q0zfvir2joyCJTGOxSREmHXfuKZasq6
         4cw65lUYNIEzBxn70TSBxBfypwM6uXtILQlQKtGT+fIlPKYxnJJ550uFePbLww+DRKiJ
         9QwUFozYGGJIpFKmAv14OnEJBiXDprMRU1+JCT1GcygWKO2WC1Yaa2K5EhHXtFr1zECd
         E7WA==
X-Gm-Message-State: AJIora+wrc/lYx6qgl2DqdP6hOn+7+HmJig4eofaqnTy8qMhuiEPzX7x
        dgsHYx9ZYNq6nfGpPUJPYk6fuTiBoJzRnzpc0kM=
X-Google-Smtp-Source: AGRyM1s7otRFzVDsgVpHgB8YBSBn5B3HuFv81h+np5C9Ev0ygTto3YXAf/DlT32RZriOPGh8D4qt3ACY+wvv7oOvPas=
X-Received: by 2002:a17:906:1f52:b0:6f4:ebc2:da82 with SMTP id
 d18-20020a1709061f5200b006f4ebc2da82mr622092ejk.176.1655137965221; Mon, 13
 Jun 2022 09:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220525114003.61890-1-jolsa@kernel.org> <CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg382+_4kQoTLnj4eQ@mail.gmail.com>
 <CAADnVQJcDKVAOeJ8LX9j-cUKdkptuFWFDnB3o9C_o0bSScGnsQ@mail.gmail.com>
 <CAEf4Bzay1-pRLw+zHG1TjHRTRpqQdtmpmDvNdq=ef-0OUQD0QQ@mail.gmail.com>
 <CAADnVQJtJEzsr4a+brn4n65Pt1dP-3WTSHZe23_AetxWRTm0Tg@mail.gmail.com>
 <CAEf4BzafJ8wThrsaYgn_WtmCau_VFDXB9enp-FiYhnzb==tsMQ@mail.gmail.com>
 <20220611205326.7ladtowtvt3ap6z3@macbook-pro-3.dhcp.thefacebook.com> <YqcvVpcJR6R8MH35@krava>
In-Reply-To: <YqcvVpcJR6R8MH35@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Jun 2022 09:32:33 -0700
Message-ID: <CAEf4BzbnnUpeqrHTdr2vwgjt9VKS=ZFsSQ9yzjKoO7Ozdg53YA@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Use prog->active instead of bpf_prog_active
 for kprobe_multi
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
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

On Mon, Jun 13, 2022 at 5:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sat, Jun 11, 2022 at 01:53:26PM -0700, Alexei Starovoitov wrote:
> > On Fri, Jun 10, 2022 at 10:58:50AM -0700, Andrii Nakryiko wrote:
> > > On Thu, Jun 9, 2022 at 3:03 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 9, 2022 at 11:27 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 7, 2022 at 9:29 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, May 31, 2022 at 4:24 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 25, 2022 at 4:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > > > >
> > > > > > > > hi,
> > > > > > > > Alexei suggested to use prog->active instead global bpf_prog_active
> > > > > > > > for programs attached with kprobe multi [1].
> > > > > > > >
> > > > > > > > AFAICS this will bypass bpf_disable_instrumentation, which seems to be
> > > > > > > > ok for some places like hash map update, but I'm not sure about other
> > > > > > > > places, hence this is RFC post.
> > > > > > > >
> > > > > > > > I'm not sure how are kprobes different to trampolines in this regard,
> > > > > > > > because trampolines use prog->active and it's not a problem.
> > > > > > > >
> > > > > > > > thoughts?
> > > > > > > >
> > > > > > >
> > > > > > > Let's say we have two kernel functions A and B? B can be called from
> > > > > > > BPF program though some BPF helper, ok? Now let's say I have two BPF
> > > > > > > programs kprobeX and kretprobeX, both are attached to A and B. With
> > > > > > > using prog->active instead of per-cpu bpf_prog_active, what would be
> > > > > > > the behavior when A is called somewhere in the kernel.
> > > > > > >
> > > > > > > 1. A is called
> > > > > > > 2. kprobeX is activated for A, calls some helper which eventually calls B
> > > > > > >   3. kprobeX is attempted to be called for B, but is skipped due to prog->active
> > > > > > >   4. B runs
> > > > > > >   5. kretprobeX is activated for B, calls some helper which eventually calls B
> > > > > > >     6. kprobeX is ignored (prog->active > 0)
> > > > > > >     7. B runs
> > > > > > >     8. kretprobeX is ignored (prog->active > 0)
> > > > > > > 9. kretprobeX is activated for A, calls helper which calls B
> > > > > > >   10. kprobeX is activated for B
> > > > > > >     11. kprobeX is ignored (prog->active > 0)
> > > > > >
> > > > > > not correct. kprobeX actually runs.
> > > > > > but the end result is correct.
> > > > > >
> > > > >
> > > > > Right, it was a long sequence, but you got the idea :)
> >
> > The above analysis was actually incorrect.
> > There are three kprobe flavors: int3, opt, ftrace.
> > while multi-kprobe is based on fprobe.
> > kretprobe can be traditional and rethook based.
> > In all of these mechanisms there is at least ftrace_test_recursion_trylock()
> > and for kprobes there is kprobe_running (per-cpu current_kprobe) filter
> > that acts as bpf_prog_active.
> >
> > So this:
> > 1. kprobeX for A
> > 2. kretprobeX for B
> > 3. kretprobeX for A
> > 4. kprobeX for B
> > doesn't seem possible.
> > Unless there is reproducer of above behavior there is no point using above
> > as a design argument.
>
> yes, I just experimentally verified ;-) I have a selftest with new test
> helper doing Andrii's scenario (with kprobes on ftrace) and kprobe_running
> check will take care of the entry side:
>
>         if (kprobe_running()) {
>                 kprobes_inc_nmissed_count(p);
>
> and as a results kretprobe won't be installed as well

Great, then I rest my case, this is mostly what I've been worrying
about. Thanks, Jiri, for confirming!

>
> >
> > > > > > It's awful. We have to fix it.
> > > > >
> > > > > You can call it "a fix" if you'd like, but it's changing a very
> > > > > user-visible behavior and guarantees on which users relied for a
> > > > > while. So even if we switch to per-prog protection it will have to be
> > > > > some sort of opt-in (flag, new program type, whatever).
> > > >
> > > > No opt-in allowed for fixes and it's a bug fix.
> > > > No one should rely on broken kernel behavior.
> > > > If retsnoop rely on that it's really retsnoop's fault.
> > >
> > > No point in arguing if we can't even agree on whether this is a bug or
> > > not, sorry.
> > >
> > > Getting kretprobe invocation out of the blue without getting
> > > corresponding kprobe invocation first (both of which were successfully
> > > attached) seems like more of a bug to me. But perhaps that's a matter
> > > of subjective opinion.
> >
> > The issue of kprobe/kretprobe mismatch was known for long time.
> > First maxactive was an issue. It should be solved by rethook now.
> > Then kprobe/kretprobe attach is not atomic.
> > bpf prog attaching kprobe and kretprobe to the same func cannot assume
> > that they will always pair. bcc scripts had to deal with this.
> >
> > Say, kprobe/kretprobe will become fentry/fexit like with prog->active only.
> > If retsnoop wants to do its own per-cpu prog_active counter it will
> > prevent out-of-order fentry/fexit for the case when the same prog
> > is attached to before-bpf-func and during-bpf-func. Only retsnoop's progs
> > will miss during-bpf-func events. Such policy decisions is localized to one tool.
> > All other users will see the events they care about.
> > kprobe/kretprobe/fprobe run handlers with preemption disabled which makes
> > these mechanisms unfriendly to RT. Their design shows that they're not suitable
> > for always-on running. When bpf+kprobe was introduced 7 years ago it wasn't
> > meant to be 24-7 either. bpf_prog_active is modeled like current_kprobe.
> > It was addressing the deadlock issue with spinlocks in maps.
> > Recursion was not an issue.
> > Sadly kprobe/kretprobe/fprobe look unfixable in this form. Too much work
> > needs to be done to enable something like:
> > user A attaches prog A to func X. X runs, prog A runs with migration disabled.
> > Preemption. Something else starts on this cpu. Another user B attaching prog B
> > to func Y should see its prog being executed.
> > With kprobes it looks impossible. While fentry was designed with this use case
> > in mind. Note it's not about sleepable progs. Normal bpf progs can be preempted.
> >
> > Back to Jiri's question whether we can remove bpf_prog_active from
> > trace_call_bpf.  Yes. We can and we should. It will allow bperf to collect
> > stack traces that include bpf progs. It's an important fix. Incorrect retsnoop
> > assumptions about kprobes will not be affected.
>
> which bperf tool are you talking about (I found 2)?
>
> and given that the kprobe layer is effectively doing the bpf_prog_active check,
> what's the benefit of the change then?
>
> thanks,
> jirka
