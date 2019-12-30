Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93C12D3A1
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfL3S4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 13:56:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42273 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfL3S4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 13:56:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so25631899qkg.9;
        Mon, 30 Dec 2019 10:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNO/Hk5SvlZUntSVYUXT/N6cNir5bvB5pW0khbEEdBg=;
        b=TN+ftY369cQzd2rj90leoiCh82gVHdPl6rkfpEdvmGf/gQt5OGjjLSPVhracdpLchO
         qkckrsFU7qc+FZ9hXLWDjdX8gE2HWzxDYiQhFRiJS3WdhNzwtvY0bw8+Svpnox1N8d4W
         9m9s4u/b8P8Zm2Zhys9yWE40tKNOLX3qD1JPVKhtS/6MyPWduUwp8HdKZw2LJD6w+ODY
         0Rr3Xg25LWIuwu82Ha3EYiKFvkKaKSv5D0xPFIViQMkIkIKRh6eE4Z7S9hzpdC5yUW2j
         Pqe/C0QlbSqzfHzGM4Pm37706OyAT7GPWFWqWgODF0VlTdYzUEyym1KFBAq+PRYf6fbF
         crXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNO/Hk5SvlZUntSVYUXT/N6cNir5bvB5pW0khbEEdBg=;
        b=XGdIl7vIpE+XGHS0ysFDU5e8oyhN/f7o0VQFdYASEesxinncIYozMM1mF5hVzVgBXR
         1x1R6cJyL3TmycycYsk1wmoz0f1MxmTw22gBpX70RTLX3PTiO0MnfumGS2Vh5iQE4xPy
         mt+M/c3JZEvXBcugO3+F1m6PmgGTnWgKTtdtJ6lP/3Mm6wfzY3p+vO8lez15tnZtqWEK
         jEg6fyafhmeGzRWeQ+kcN19p4lbIJXz3ITaGGGkVr8+nVOblKwZwvlNR/IhFPH+cgoPL
         1GD62CZfAPK/rVV7AzKk0DxNU2NwH+WMe+452oHNva9cjssDFI5MJJdCr4U2p+F3bVGK
         +RYQ==
X-Gm-Message-State: APjAAAVaqns1QSVhRsPDkHMJH0s7XJ2oWnMRC3wDNl/zzPz1o048e+Cs
        tuWBhMUL1aznx85yF+mqANIfevn5vvAYrzQr238=
X-Google-Smtp-Source: APXvYqxe+dIas1aZfaZPUYlz0AHLEVSoZ3Cf4l76RSzTnmKm6vgknRi8IUOmSVg8aVwzNiFKcqRiBViVgKBfYHxFCEo=
X-Received: by 2002:a37:e408:: with SMTP id y8mr55475323qkf.39.1577732206986;
 Mon, 30 Dec 2019 10:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-10-kpsingh@chromium.org>
 <CAEf4BzYgcez2G1qJW9saJmzfeYirGdH58aAcUk-+YTJF6vyOuQ@mail.gmail.com> <20191230151135.GC70684@google.com>
In-Reply-To: <20191230151135.GC70684@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Dec 2019 10:56:35 -0800
Message-ID: <CAEf4BzaXBLRYP=BZYzr3fmc7ZH=JZ9TY27_HnOxj3ut2RCnZjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/13] bpf: lsm: Add a helper function bpf_lsm_event_output
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 30, 2019 at 7:11 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-Dec 22:36, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > This helper is similar to bpf_perf_event_output except that
> > > it does need a ctx argument which is more usable in the
> > > BTF based LSM programs where the context is converted to
> > > the signature of the attacthed BTF type.
> > >
> > > An example usage of this function would be:
> > >
> > > struct {
> > >          __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > >          __uint(key_size, sizeof(int));
> > >          __uint(value_size, sizeof(u32));
> > > } perf_map SEC(".maps");
> > >
> > > BPF_TRACE_1(bpf_prog1, "lsm/bprm_check_security,
> > >             struct linux_binprm *, bprm)
> > > {
> > >         char buf[BUF_SIZE];
> > >         int len;
> > >         u64 flags = BPF_F_CURRENT_CPU;
> > >
> > >         /* some logic that fills up buf with len data */
> > >         len = fill_up_buf(buf);
> > >         if (len < 0)
> > >                 return len;
> > >         if (len > BU)
> > >                 return 0;
> > >
> > >         bpf_lsm_event_output(&perf_map, flags, buf, len);
> >
> > This seems to be generally useful and not LSM-specific, so maybe name
> > it more generically as bpf_event_output instead?
>
> Agreed, I am happy to rename this.
>
> >
> > I'm also curious why we needed both bpf_perf_event_output and
> > bpf_perf_event_output_raw_tp, if it could be done as simply as you did
> > it here. What's different between those three and why your
> > bpf_lsm_event_output doesn't need pt_regs passed into them?
>
> That's because my implementation uses the following function from
> bpf_trace.c:
>
> u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>                      void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
>
> This does not require a pt_regs argument and handles fetching them
> internally:
>
>         regs = this_cpu_ptr(&bpf_pt_regs.regs[nest_level - 1]);
>
>         perf_fetch_caller_regs(regs);
>         perf_sample_data_init(sd, 0, 0);
>         sd->raw = &raw;
>
>         ret = __bpf_perf_event_output(regs, map, flags, sd);
>
> - KP

Yeah, I saw that bit. I guess I'm confused why we couldn't do the same
for, say, raw_tracepoint case. Now Jiri Olsa is adding another similar
helper doing its own storage of pt_regs. If all of them can share the
same (even if with bigger nest_level) array of pt_regs, that would
great.

>
> >
> > >         return 0;
> > > }
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 10 +++++++++-
> > >  kernel/bpf/verifier.c          |  1 +
> > >  security/bpf/ops.c             | 21 +++++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h | 10 +++++++++-
> > >  4 files changed, 40 insertions(+), 2 deletions(-)
> > >
> >
> > [...]
