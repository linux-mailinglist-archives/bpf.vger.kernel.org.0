Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E043D3BEA97
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 17:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGGPWQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 11:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232225AbhGGPWQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 11:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625671175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjNUgz6mqt/4pNa8w2Xldle8j77XowpLl5djQ8TARDs=;
        b=BgAqVBq4qrsR3UAmSUoyoWs3p7opVH5/FaOSlJUbACeBAlYNAI0H76Qgbd/W0ZQb1dJXxf
        lnB4TxjsQG0iVcKbxtcNmKkvgiHHAbxHCTg1iq24Ns82mAgTRZxQBiws8chIdacKqh3Ovc
        Fc5G8WnoFFBHs96wC3+vfvCmXVVYFgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-dc4QYvspNQeAwAQFj31rGg-1; Wed, 07 Jul 2021 11:19:34 -0400
X-MC-Unique: dc4QYvspNQeAwAQFj31rGg-1
Received: by mail-wm1-f72.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so1096441wmh.9
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 08:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjNUgz6mqt/4pNa8w2Xldle8j77XowpLl5djQ8TARDs=;
        b=S7h195iF6NR83zS5gx1A/a1udDN0ho4i0QEtMAiEUicC3VWttTcMp7OlMC3eCh+EU6
         mmFaBao/K4ITte+v08cdmesFPd7dzMEQDcopiyIfpNM+55UluOV+6grTng/EzsbzCh/+
         JWgd0HQepD0VYxPQldKMV7JCfJyOyDuEvYMIjNBVRzFWngAAbTl+auuja9wkmDJbkpN4
         vpBT30Eq7hnwTOL7HbHW7GMVysOspqE5EdLsL82+wmr6K23spK1I9zosOwKpyTwLR4vF
         KT9BiEPmGT5QIyPySHyEAJmneRck2THOEgOROb2YkQI5mqQQhlUxEoSfx8Rp/MXI6vdY
         TFmQ==
X-Gm-Message-State: AOAM530faVUVrqh09mi1ZbCQXvez0fQj0IQvtBh1YCezA7NqwFzQpfKO
        0Y+23iX8eDqnsf5XRQTahuNor6/0yvXn6OzLgkjx//UbqADBZ/JD+puO+UpBO2vGBWUVnE1HWre
        XWA4v37YdSzaI
X-Received: by 2002:a7b:cd8d:: with SMTP id y13mr130236wmj.131.1625671173187;
        Wed, 07 Jul 2021 08:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdE+ugbCW3ITOrPkMmaTxtBpHoLy9I0l8XyejJi96Rw+DLMfJGu+57QXoNart4pG1QZhzsJA==
X-Received: by 2002:a7b:cd8d:: with SMTP id y13mr130221wmj.131.1625671173035;
        Wed, 07 Jul 2021 08:19:33 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id b21sm6636001wmj.35.2021.07.07.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 08:19:32 -0700 (PDT)
Date:   Wed, 7 Jul 2021 17:19:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFCv3 00/19] x86/ftrace/bpf: Add batch support for
 direct/tracing attach
Message-ID: <YOXGAHExKlDHjAvG@krava>
References: <20210605111034.1810858-1-jolsa@kernel.org>
 <CAEf4BzaK+t7zom6JHWf6XSPGDxjwhG4Wj3+CHKVshdmP3=FgnA@mail.gmail.com>
 <YM2r139rHuXialVG@krava>
 <CAEf4BzaCXG=Z4F=WQCZVRQFq2zYeY_tmxRVpOtZpgJ2Y+sVLgw@mail.gmail.com>
 <CAEf4BzaGdD=B5qcaraSKVpNp_NQLBLLxiCsLEQB-0i7JxxA_Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaGdD=B5qcaraSKVpNp_NQLBLLxiCsLEQB-0i7JxxA_Bw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 06, 2021 at 01:26:46PM -0700, Andrii Nakryiko wrote:

SNIP

> > > >
> > > > It's a 10x speed up. And a good chunk of those 2.7 seconds is in some
> > > > preparatory steps not related to fentry/fexit stuff.
> > > >
> > > > It's not exactly apples-to-apples, though, because the limitations you
> > > > have right now prevents attaching both fentry and fexit programs to
> > > > the same set of kernel functions. This makes it pretty useless for a
> > >
> > > hum, you could do link_update with fexit program on the link fd,
> > > like in the selftest, right?
> >
> > Hm... I didn't realize we can attach two different prog FDs to the
> > same link, honestly (and was too lazy to look through selftests
> > again). I can try that later. But it's actually quite a
> > counter-intuitive API (I honestly assumed that link_update can be used
> > to add more BTF IDs, but not change prog_fd). Previously bpf_link was
> > always associated with single BPF prog FD. It would be good to keep
> > that property in the final version, but we can get back to that later.
> 
> Ok, I'm back from PTO and as a warm-up did a two-line change to make
> retsnoop work end-to-end using this bpf_link_update() approach. See
> [0]. I still think it's a completely confusing API to do
> bpf_link_update() to have both fexit and fentry, but it worked for
> this experiment.

we need the same set of functions, and we have 'fd' representing
that ;-) but that could hopefully go away with the new approach

> 
> BTW, adding ~900 fexit attachments is barely noticeable, which is
> great, means that attachment is instantaneous.

right I see similar not noticable time in bpftrace as well
thanks for testing that,

jirka

> 
> real    0m2.739s
> user    0m0.351s
> sys     0m2.370s
> 
>   [0] https://github.com/anakryiko/retsnoop/commit/c915d729d6e98f83601e432e61cb1bdf476ceefb
> 

SNIP

