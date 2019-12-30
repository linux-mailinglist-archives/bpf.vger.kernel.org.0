Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6AC12D160
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfL3PLk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 10:11:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41191 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfL3PLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 10:11:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so32914354wrw.8
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 07:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZcxTcpaDMQ5+cud/+WpfDIzafmGhnBWvqYEQ37cqqVk=;
        b=j4Gdq71cb5S9RxG66n3wNP3KmYROGwCIjNYd5Am2/jzwaS/IpDhxMiZq19RNIPb/0v
         zxNbS+HEX2iW2zKMXUIfNaQ/mHQL8Sj9fQMPWygG8lODq/pf0RmDzYla3vz1IBMjDmzr
         M6s4h9EAKUUPHz8UUFfPHYGIJyxK1v4eWQBnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcxTcpaDMQ5+cud/+WpfDIzafmGhnBWvqYEQ37cqqVk=;
        b=oanraz81k1XBtGBBQN4csHX3yuDCnLGwMkVxOrJT56R+7oCkg+jmmNXQrS21T8saIc
         DIj/3VdTH12vDH556BxV4Q1rgNEm8iRy1ZoNJXjyqGHXYQYwnTQbeNMw1MOGAj8gerlF
         SjwFnXfJSkSZrN3N5gtTD+N4SVztxzuBTPZlUGZKW3ZkhFi08ukDToE2yU/orXbkEZIK
         MX/XvWbbLZxnqkp0aOdg7iEyR6/H/dru3Ea1dNoZKppB5IJLWDy2YY33go/6aMCidViH
         wm5hZdBc8zREB33GxQkFuQdOMSy9aEx1BLWJMblnGUJSS/aFVTtXPB+at6oNiZhjl5sG
         jnVg==
X-Gm-Message-State: APjAAAUkqryzzVtfi1vGtOrdTNrmUTrLbg+iWrwUuyO2roGeG/x2FNZK
        UPKiJtmwCwa8PtfJqBU+UhHGlA==
X-Google-Smtp-Source: APXvYqx4oQJo3hvUvNvR8JQAqdGbojXIwOPhER/kRojKfQHqScQYPheCIzVswhv029S1ZQ/HTC/jFw==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr70792443wrs.224.1577718697833;
        Mon, 30 Dec 2019 07:11:37 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id o1sm46090041wrn.84.2019.12.30.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:11:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Dec 2019 16:11:35 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Subject: Re: [PATCH bpf-next v1 09/13] bpf: lsm: Add a helper function
 bpf_lsm_event_output
Message-ID: <20191230151135.GC70684@google.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-10-kpsingh@chromium.org>
 <CAEf4BzYgcez2G1qJW9saJmzfeYirGdH58aAcUk-+YTJF6vyOuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYgcez2G1qJW9saJmzfeYirGdH58aAcUk-+YTJF6vyOuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Dec 22:36, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > This helper is similar to bpf_perf_event_output except that
> > it does need a ctx argument which is more usable in the
> > BTF based LSM programs where the context is converted to
> > the signature of the attacthed BTF type.
> >
> > An example usage of this function would be:
> >
> > struct {
> >          __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >          __uint(key_size, sizeof(int));
> >          __uint(value_size, sizeof(u32));
> > } perf_map SEC(".maps");
> >
> > BPF_TRACE_1(bpf_prog1, "lsm/bprm_check_security,
> >             struct linux_binprm *, bprm)
> > {
> >         char buf[BUF_SIZE];
> >         int len;
> >         u64 flags = BPF_F_CURRENT_CPU;
> >
> >         /* some logic that fills up buf with len data */
> >         len = fill_up_buf(buf);
> >         if (len < 0)
> >                 return len;
> >         if (len > BU)
> >                 return 0;
> >
> >         bpf_lsm_event_output(&perf_map, flags, buf, len);
> 
> This seems to be generally useful and not LSM-specific, so maybe name
> it more generically as bpf_event_output instead?

Agreed, I am happy to rename this.

> 
> I'm also curious why we needed both bpf_perf_event_output and
> bpf_perf_event_output_raw_tp, if it could be done as simply as you did
> it here. What's different between those three and why your
> bpf_lsm_event_output doesn't need pt_regs passed into them?

That's because my implementation uses the following function from
bpf_trace.c:

u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)

This does not require a pt_regs argument and handles fetching them
internally:

	regs = this_cpu_ptr(&bpf_pt_regs.regs[nest_level - 1]);

	perf_fetch_caller_regs(regs);
	perf_sample_data_init(sd, 0, 0);
	sd->raw = &raw;

	ret = __bpf_perf_event_output(regs, map, flags, sd);

- KP

> 
> >         return 0;
> > }
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/uapi/linux/bpf.h       | 10 +++++++++-
> >  kernel/bpf/verifier.c          |  1 +
> >  security/bpf/ops.c             | 21 +++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 10 +++++++++-
> >  4 files changed, 40 insertions(+), 2 deletions(-)
> >
> 
> [...]
