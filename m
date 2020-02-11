Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3638159968
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 20:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgBKTJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 14:09:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBKTJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 14:09:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so6225723pgn.5;
        Tue, 11 Feb 2020 11:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DdsrzRs5GOQlNR32edutZ6f0+7+c3wenHW9tPk91IXQ=;
        b=jUFg2P2wPWe5n8gJz2v94k0wIKdVuT2M2HF3uq3iA7aKhI+IkXcLVhjY8zpCZG9SNY
         9cNfTMW/PveAoPemS2Q/VOoo9/R26xUGAfBgCeUAXxNp7R0RAjsP57uQm2dhZBbNFLLD
         E5FlwyYdXnPAAOweUrUVacckqkfiuxwg10oTX5F7VN2Zn4bkd906Tv8xeuSFNQAZ08MV
         hi/3nSZONHkfRrnxoujljl9n6Z0+TdrmZXdkBE08kIu49khw+C3sw8j0fekV8BymxxZj
         wR/dHEo3QGbHSOhTTEjK6gF1fM4siv+fgj2LimhxzE3E/eHaCbLP8FfQD5cR/B94n2BE
         +6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DdsrzRs5GOQlNR32edutZ6f0+7+c3wenHW9tPk91IXQ=;
        b=buPmm9/6wvTFdCdY2Ko5zwHbj9Tkho7EMlXmjwKMHRqpQDBTVCli88XqDQYw9g2Oww
         nxRJyFfUEQCVp38CTfR/1GCAwRjLbskQ9cptamK7iQ2FQENlRanUIwKusPejoYkgb0jg
         3QSU/zgbZomqDA9jFT86YpxlExFCN5iNBA6sAmuIb5Q0wZX8T1Duro76H+Roj4kvXBbn
         f2JUI7MZf6FlitrGra3tRDOX9A0SdXH9c8h+dUI0d9TQke8jBbt0tyttmWS3ubSqPqUv
         sOu8t2IwKTpgciI19gcrKEZpQd39esMhAu0dgex9z/4H/hZzllBbau/JamSNWPSMWsGw
         JznA==
X-Gm-Message-State: APjAAAWPZIOl0OIiRXTXVJdIeIjdPEprdaQ7NEMVBxk4NmxNAwIUdf/c
        h8Jy9yjuRJjFhb6p4ghgIy8=
X-Google-Smtp-Source: APXvYqzRHkBLhol9enkRUQh0FR/hutR9VwxiVXEvgSOpAc6SqnqoNFvmuuWvGmS6H9lHdEVKdyxi7w==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr4453233pfp.97.1581448187897;
        Tue, 11 Feb 2020 11:09:47 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:aeb4])
        by smtp.gmail.com with ESMTPSA id v8sm4989689pfn.172.2020.02.11.11.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:09:47 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:09:45 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
Message-ID: <20200211190943.sysdbz2zuz5666nq@ast-mbp>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp>
 <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> [...]
> > > * When using the semantic provided by fexit, the BPF LSM program will
> > >   always be executed and will be able to override / clobber the
> > >   decision of LSMs which appear before it in the ordered list. This
> > >   semantic is very different from what we currently have (i.e. the BPF
> > >   LSM hook is only called if all the other LSMs allow the action) and
> > >   seems to be bypassing the LSM framework.
> >
> > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > trampoline generator specific to lsm progs.
> [...]
> > Using fexit mechanism and bpf_sk_storage generalization is
> > all that is needed. None of it should touch security/*.
> 
> If I understand your suggestion correctly, that seems like a terrible
> idea to me from the perspective of inspectability and debuggability.
> If at runtime, a function can branch off elsewhere to modify its
> decision, I want to see that in the source code. If someone e.g.
> changes the parameters or the locking rules around a security hook,
> how are they supposed to understand the implications if that happens
> through some magic fexit trampoline that is injected at runtime?

I'm not following the concern. There is error injection facility that is
heavily used with and without bpf. In this case there is really no difference
whether trampoline is used with direct call or indirect callback via function
pointer. Both will jump to bpf prog. The _source code_ of bpf program will
_always_ be available for humans to examine via "bpftool prog dump" since BTF
is required. So from inspectability and debuggability point of view lsm+bpf
stuff is way more visible than any builtin LSM. At any time people will be able
to see what exactly is running on the system. Assuming folks can read C code.
